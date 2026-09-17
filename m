Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B444CC88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 18:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3309610F05A;
	Thu, 17 Sep 2026 18:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SiumYvom";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F64E10E775
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 18:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGiYlynTviyyn7FFBw0jY+dW130OIIYDRAF5jms7o4j8zXF76nt790KKyb6aXN3iNCt9x/+++tpW0j0E4844H8BCOeG32wFSJFBraeexPKzM3WdGuJNet3cq1h1NGGVmNcFGJn+/k9phw0tMjrjYTnATtEjzVyxd9gc00OIayCaf28mhrY0JdoNy+9KSb1mizA/QGSWc8Eoze+EGOGSvbW/vMjmI21I/E2pzdKvjv2j3MFRZrPB6X5P1S7pyHoiKQhqjJ7LynzbfVsuFCQ5E+6TnjyLEVZc2drQ7C0cKmn4y/dlWjkQ2BaeMSXXrE8jxpFgq1sHLNWss/9z01XZtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GeqW69Mzde2UAkR0wqd7GQ/R917/l4h+ttp+RRTo84=;
 b=fdWTNCTtmjoilxfxYO3tWQPROo8O/JH0qzrrZDlk2rfQUltaNNsj8DFWrWW2N7QtPJYPpiGhLFJyt4G2TN36mgy4dgTue0dZNnmDNiEAGeGeVqE+uQcbrrmIZJ+FKdFzCnamV4VI5VynlvImRNynZstp37f9JaTMjN5EuK7tHQxlnbyGzu3YbasXNMrGFtVsl/gMA1/1qrSeH5a9xeF36rEIQN8H7RsU9AADIpp5+rrnqelrOaX1KJ6GhGY//AClJgvfsMGJoQe+UptR3wtbT/Fjuse7C2j15yjrkWMahOjBN7fwlOanSnSIt74erCZ/gg2DKFr8DINx/l0+Kzqo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GeqW69Mzde2UAkR0wqd7GQ/R917/l4h+ttp+RRTo84=;
 b=SiumYvomzl3dKmES2Wucy4fJnB9lXsCRlOiZuWPrWs3fuTzS7u/yPIXaoSd8RJswFxeO31eYdiN0+DTMJflhUw8jabC3otoN9LxJurANaLRhcCyWvhlD7IIfuPDxCOuxEvp9P7fg1xZcBR3LTpcHCpKZnqEVhdyFhnWVX8XaU2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by SN7PR12MB7933.namprd12.prod.outlook.com
 (2603:10b6:806:342::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:42:38 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:42:38 +0000
Message-ID: <2730087e-5f10-43a4-aec2-20bd62e490e9@amd.com>
Date: Thu, 17 Sep 2026 14:42:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] drm/amdgpu: Resync UALink ring wptr after reboot
To: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <yangp@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com
References: <20260916152528.3918848-1-Philip.Yang@amd.com>
 <b6349b6d-0357-4850-8957-6d2d17649a05@amd.com>
 <ca5f45bb-2bbd-464b-94fb-336456e9966c@amd.com>
 <e751339b-cfff-43bc-a19a-963408134677@amd.com>
 <0bbd044b-f2c7-4da3-8939-9a1a6d60123b@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <0bbd044b-f2c7-4da3-8939-9a1a6d60123b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::26) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e2da50-a8d0-48bc-178d-08df14eb7259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|3023799007|10067099003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 8nEa9mWD70+NpZpspnwizJqW/vbiOd1lV8zmztHKcxlUIxdF4sUS1mADE4KZow5HiTrRJ7qS7vG7EaI04jNkzA6976ZFc4vjYd3BcGlrlic515y+GGKciML+SEcc0UTFbpbZOWC9G6IwZTRx5a5E0NKj8BYM6lhjLcq2Sce0kAap+NqCfJlYiNLed0r8jyT2ULWFcwk64H+uEWmIhfwwCOfFGnyA4Z6qJqAqbvnW2Uit1EvV5OkCZFY8k3m/YMwYmiN4DiVK6MxgxgAaJPx9uBviHjcSFUQoNgb2l71PGC2q5dHMoc4JEn3m6s/gQ681DeoXq1Whhd7cMArY27akDF8nsYVcDMuQTM0ssfswcmACRwvk/v+3QsPoasR/xuo0qzMMPN35UQXIgNHLEp9C3WSsuvxxjBt6hBZtz6ww/ghhDCupdvK9rl/br1I39NzSfD21LYJJggpLbhLInSI8KHE0zODvuKc+7s/3a7sbPloV2fKAh3dhJZV7X2DiPjpOWDf0cWgpkwdLrSXG3wCDCYExCaX1kCxwLBdAci1HpTnz5BkrnM9IR0eMwdgVbyCXktZcnv3ef02yhj9jnxGpX7eZ2FgeVILgP75CzETm+zz+Wq+qAJYSkjDJeqqDs06w+etHmle3i7yHu1uz8UKD6QX6ZpCPuS6pz+onfsd54tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkthQ3dHTTZIdlpubnJ5c2dsMitVNFh3NGFyU0NIS0FNWGVYNzFCTmhKeVg2?=
 =?utf-8?B?dHZsRHNRR25LczhWOTBRSituUHNTSVY5VzJHRkR5akhvbHJsMXp0ZytocHgy?=
 =?utf-8?B?K0dSTmpHcFB0RmVRZkhMaUdrRjJRdUZXMkZ1dGJFWUQ2RW91Q01nNlJiVG91?=
 =?utf-8?B?ZUZwWnFYQkxIVGRIVjQxVUFFQlV5K3UxSWs1Q1hYWEdoYnlqZG1aWWhGVzdv?=
 =?utf-8?B?N0x6NkZnRHNWaDZJK09rbnFDa2NocWJFTnN1VDBsUHhxVjBzcS9PcmUzZitT?=
 =?utf-8?B?bHdNeGl1UEhDQ1RlVDRpZmViQVc0TGlVUjJlTVAxMnhzanMwY0NxTWZSbVli?=
 =?utf-8?B?V1Nmdnp5ZWI0ejgvZFRTRktGemp4MGhzYjZSRDRjV3dEVmJseEFpZXdQNjhN?=
 =?utf-8?B?ZWhPbWR3MDg0Rk10WE9JZVk2RGhyUUJDQVdLUlJLK25Vdy9sTDE3RjhnYkxC?=
 =?utf-8?B?SFdzTHU5SWNmTnc0aHB1NzBFM01SbDhja2tOdEphUVRVODRzRHpEdmNiZmpt?=
 =?utf-8?B?alBZTDNjUitOTTNOSmVMMzM0SFNZVS9TNjZ2aks0ZFlYVFFJTVV6dXNNNHJa?=
 =?utf-8?B?cnl6dDN3dXJxcitPQWRyd0VzVy9yOVdCOXQ1Z09nRW40Q3ZtcGhwU3FCT3Fs?=
 =?utf-8?B?N21nQlQ4UE5tQXdUbGh6TmQ5bFhLZ0VPM05XS3dnTE0rd0dhOGtwQTFCUDFB?=
 =?utf-8?B?NGlqSlJCdUZJNHFRTWdQajE1bnBOSHJ6YkdwcTloREVZOStBNEd4TjM4aGti?=
 =?utf-8?B?OEkyZGFsQUErZHRQVEV2dkE3SVZERWN4c1J6RDZYdFI5Nm9vVXRkRHRqcHBr?=
 =?utf-8?B?emNnRlFveG9qUHZvRXJaVC9LcDk0OTVPejBJVG8ySmxxL1hwbzFxbjZ6ZW9X?=
 =?utf-8?B?MnRpcVpnSDVZQWxlS2pmdjh1WUxQRlg3aWJHcy9icmZNemJ3NkpVM2t2ZEFl?=
 =?utf-8?B?clNjTjJxV0QzR3VLY01KakpMbVhpM2VRYnFCaXNEVFRqLzZlZ0pwMGVmUWg2?=
 =?utf-8?B?VTBEUUs1SlpWM3hvS2ZwSHNxcXJjQ0xnS2EzVDhYUWVmY3hXNWxzeHpUai9z?=
 =?utf-8?B?ZFJaZ2VLdmVYQ3ZkWGFBdWd2enJFN3Z4OSs0ZDJQVHhSdFNmWHVZQU93bzlQ?=
 =?utf-8?B?UTFHQytlQkFxeGVvZS91UnpjSktFb0QzNGpuVHF6RG5UWjR3Q0RQZVBrb3h6?=
 =?utf-8?B?cmZZVWNueFV5WEE2YTZtREdybEJlZE15ZkNVSzZYV0dDUDJtSUhtNDlTcnlO?=
 =?utf-8?B?R2lNNHhhUGR6TW1nR2VjMzc1cWVyOERybEJubmVyWUtVcERDaDcwWnpaejBI?=
 =?utf-8?B?V3pic1ZzK2ZmVk1NQmduNlMva2JMcXFNb21Xend4K1BRcmpyUFZIMDN6WHBF?=
 =?utf-8?B?eXp0blZxYUx6MWxpZElYZ2FJdlVvTmYwT2RpUTYrMWk2YnVaSnZkbWdqWklq?=
 =?utf-8?B?Qmp1ZkljaHFHYmZnNDFySkFxeHNWTmZOcWlGYXdsMzVhRldCSlBhaTZ1clNv?=
 =?utf-8?B?aUxRQnlaRDdJdGN1cmN3WGdWT2ZubFBiZjd1Z296OUs0VXJabmIveGlHSDU3?=
 =?utf-8?B?ZG5FNG1adEViZWI4Q1FjZU4zam9YR1RrMWRHU1VpTVl6elQ1aFA1OGVQVVov?=
 =?utf-8?B?QlZweGhrWHBCek1uUVMxZUl6cHFhbkhocU0reW1NQVZ6VXdSaWJqZWdiMFUw?=
 =?utf-8?B?SmJJNTh1MWRxamdXejBIdXV6K1Q5QW43Q0RQakFwRjRvSzRmeEV4RmVTN3R2?=
 =?utf-8?B?allEcFBISjV1c3BOZHRVY0JGL0JTZjY5SG5uV01MUVFTVDVxY3Vzam5NaDJH?=
 =?utf-8?B?Q3NJSnltUEVWd1ZHTmJEUW1samNSZVVtVStXOUdROWFyVG5WdGhnRTZBNEFa?=
 =?utf-8?B?UnE0OUtiT2ZKdTAwcXU4YlJ6cGJ6QlJhTG5IelhnZWRUYlFxa2dsdFlzUkc1?=
 =?utf-8?B?R2kzZG00TzByLytMb0dUbk9iRC9TbUxTMjZKQXJETWkxSmhXcGR2MlpYRGtt?=
 =?utf-8?B?M3lOZ0w3dXBNblpXVG9KRjFQT0laRlpnSkpKSXV2TEN3OEI1M2MxcWVtUUxF?=
 =?utf-8?B?ODBhZHBkL2hYSlBSaEY0SHNqS3B5aWttMmRtMFVQVnltRVpHUjJFS1J3aW9a?=
 =?utf-8?B?ZVhVRUxpSUpyVXJYckE3eXVjR1Q1QmV5NXdndU5oTUp5ekoyaC9iQWl6ZVdo?=
 =?utf-8?B?K3Zadzc2cmw2N2Q5YjBpVzZ4aWFMNEtSOWx4TURCU3Z6NUdRWGJpUkpxcU1T?=
 =?utf-8?B?SzJzcW5zb1l0NFVzSHhHV0h0bnY3d2d1bHp0Sks2eEt2VFFpVmE5SkFkZFdO?=
 =?utf-8?B?SHIyTjVhL0l2S0xhUWJ5Ulp4bG5RYUV4WU5BT0w0a3BPdEZOU0c4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e2da50-a8d0-48bc-178d-08df14eb7259
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:42:38.0422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t48xA6/jsxf6oIfkU9wQ6UrbQkChuVW7IFLD++p7N2A2U8DIDZzMf0vns02dPHjQTYvN3zy1shkgVxMEDhT99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2026-09-17 14:37, Mukul Joshi wrote:
>
>
> On 9/17/2026 1:59 PM, Felix Kuehling wrote:
>> On 2026-09-17 10:07, Philip Yang wrote:
>>>
>>>
>>> On 2026-09-16 21:33, Mukul Joshi wrote:
>>>>
>>>>
>>>> On 9/16/2026 11:25 AM, Philip Yang wrote:
>>>>> When one side of UALink nodes reboots, its ring wptr resets to 0 
>>>>> while
>>>>> the peer keeps a stale value. Read the remote wptr and adopt it as 
>>>>> the
>>>>> local wptr and rptr to resync, before the first message is sent. 
>>>>> Either
>>>>> side can notice first, so do this both when setting up the connection
>>>>> and when receiving the HELLO from the peer.
>>>>>
>>>>> On the sdma path, read the wptr in a fence callback because the IB 
>>>>> buffer
>>>>> holding the result is recycled once the fence signals, so reading it
>>>>> after dma_fence_wait_timeout() is too late. The lsdma path copies
>>>>> synchronously, so it reads the wptr directly.
>>>>>
>>>>> Take peer->lock in the callers (amdgpu_ualink_remote_interrupt and
>>>>> amdgpu_ualink_remote_shootdown) instead of in 
>>>>> amdgpu_ualink_send_command,
>>>>> so the ring->ready check and the send are atomic against a concurrent
>>>>> ring reset.
>>>>>
>>>>> Move the rptr refresh and ring-full check out of 
>>>>> amdgpu_ualink_send_command()
>>>>> into amdgpu_ualink_ring_check_space(), so it runs under the caller's
>>>>> peer->lock before the job is allocated.
>>>>>
>>>>> On a failed NPA-REQ send, reset the connection like the NPA-RSP 
>>>>> timeout path
>>>>> already does, so the next attempt resyncs the ring wptr.
>>>>>
>>>>> On connection reset, amdgpu_ualink_reset_peer_rings() only clears
>>>>> ring->ready, so the writeback address is re-registered on the next 
>>>>> send.
>>>>>
>>>>> v10:
>>>>>    - Fix the resync missed on the receiving side: after a reboot 
>>>>> the peer
>>>>>      may send HELLO before we set up the connection, so resync the 
>>>>> ring
>>>>>      wptr in amdgpu_ualink_process_hello_msg() too.
>>>>>
>>>>> v9:
>>>>>    - Fix the unnecessary connection reset after an app exits: the 
>>>>> peer is
>>>>>      idle here but still busy handling NPA revokes on the remote, 
>>>>> so the
>>>>>      HELLO reset a healthy connection. Only send it if the wptr 
>>>>> changed.
>>>>>    - Resync both rings together under peer->lock, read both remote 
>>>>> wptr
>>>>>      before updating either so a failed read changes nothing.
>>>>>
>>>>> v8:
>>>>>    - Fix regression with concurrent import ioctls: do the idle 
>>>>> check and
>>>>>      ring reset in amdgpu_ualink_setup_connection() under 
>>>>> conn_state->lock,
>>>>>      and return -EAGAIN for IN_PROGRESS/PENDING first.
>>>>>    - Reset the peer rings only, the imp/exp xarray cleanup is not 
>>>>> needed to
>>>>>      resync wptr.
>>>>>
>>>>> v7:
>>>>>    - With v6 reboot one node of vPOD test passed on minirack.
>>>>>    - Use the per-remote imported and exported handle lists for the 
>>>>> idle
>>>>>      check instead of walking the xarrays.
>>>>>    - Rename amdgpu_ualink_resync_peer_rings() to
>>>>>      amdgpu_ualink_reset_peer_rings(), it only clears ring->ready.
>>>>>
>>>>> v6:
>>>>>    - Check idleness per remote accelerator instead of globally, 
>>>>> and reset
>>>>>      the stale connection at the import ioctl so the peer re-runs the
>>>>>      HELLO handshake after a reboot.
>>>>>
>>>>> v5:
>>>>>    - Resync the ring pointers at the import ioctl when the 
>>>>> connection is
>>>>>      completely idle (no exported or imported BOs), so the first 
>>>>> command
>>>>>      from a new application after a remote reboot/reset succeeds.
>>>>>    - Put the sdma wptr read fence callback on the stack instead of
>>>>>      allocating it; it is cancelled on timeout so it never 
>>>>> outlives the
>>>>>      call.
>>>>>
>>>>> v4:
>>>>>    - Cancel the sdma fence callback on the wait timeout/failure 
>>>>> path so it
>>>>>      cannot write into the caller's stack after the function 
>>>>> returns, and
>>>>>      free the callback state in one place.
>>>>>
>>>>> v3:
>>>>>    - Resync both rings at connection setup instead of on the send 
>>>>> path.
>>>>>    - Set the writeback rptr too, the stale value disagrees with the
>>>>>      resynced wptr until the remote FW writes it back.
>>>>>
>>>>> v2:
>>>>>    - Match the FW change: resync wptr only on the first send or 
>>>>> after a
>>>>>      timeout, instead of checking the remote periodically.
>>>>>
>>>>> Suggested-by: Felix Kuehling<felix.kuehling@amd.com>
>>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 339 
>>>>> +++++++++++++++++----
>>>>>   1 file changed, 287 insertions(+), 52 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>>> index b2c2650b0149..c0327f6854a6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>>> @@ -56,6 +56,10 @@ static int 
>>>>> amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>>>>                         u32 size_in_pages, u32 flush_type);
>>>>>   static void __amdgpu_ualink_activate_vpod_locked(struct 
>>>>> amdgpu_device *adev);
>>>>>   static bool amdgpu_ualink_vpod_membership_changed(struct 
>>>>> amdgpu_device *adev);
>>>>> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device 
>>>>> *adev,
>>>>> +                       u32 remote_accel_id);
>>>>> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device 
>>>>> *adev,
>>>>> +                      u32 remote_accel_id);
>>>>>     #define STRIP_NPA(addr)                        \
>>>>>       (((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
>>>>> @@ -2282,11 +2286,23 @@ static void 
>>>>> amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>>>>>                           generation_count);
>>>>>       }
>>>>>   +    /* Peer may have rebooted. */
>>>>> +    r = amdgpu_ualink_ring_resync_ptrs(adev, sender_acc_id);
>>>>> +    if (r < 0) {
>>>>> +        dev_err(adev->dev,
>>>>> +            "HELLO: resync sender AccId %u ptrs failed %d\n",
>>>>> +            sender_acc_id, r);
>>>>> +        goto out_set_state;
>>>>> +    }
>>>>> +    if (r)
>>>>> +        amdgpu_ualink_reset_peer_rings(adev, sender_acc_id);
>>>>> +
>>>>>       r = amdgpu_ualink_send_hello_ack_msg(adev, sender_acc_id);
>>>>>       if (r)
>>>>>           dev_err(adev->dev, "HELLO-ACK: send failed to remote 
>>>>> AccId:%u\n",
>>>>>               sender_acc_id);
>>>>>   +out_set_state:
>>>>>       mutex_lock(&conn_state->lock);
>>>>>       if (r) {
>>>>>           conn_state->state = AMDGPU_UALINK_CONN_NOT_READY;
>>>>> @@ -2303,6 +2319,14 @@ static void 
>>>>> amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>>>>>       mutex_unlock(&conn_state->lock);
>>>>>   }
>>>>>   +/* True if nothing is exported to, or imported from, this 
>>>>> remote accelerator. */
>>>>> +static bool amdgpu_ualink_peer_idle(struct amdgpu_device *adev, 
>>>>> u32 remote_accel_id)
>>>>> +{
>>>>> +    /* Unlocked: a racing import at worst costs one redundant 
>>>>> ring resync. */
>>>>> +    return 
>>>>> list_empty(&adev->ualink.imp_handles_list[remote_accel_id]) &&
>>>>> + list_empty(&adev->ualink.exp_handles_list[remote_accel_id]);
>>>>> +}
>>>>> +
>>>>>   static int amdgpu_ualink_setup_connection(struct amdgpu_device 
>>>>> *adev,
>>>>>                         u32 remote_acc_id)
>>>>>   {
>>>>> @@ -2324,16 +2348,31 @@ static int 
>>>>> amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
>>>>>        * already done by another thread.
>>>>>        */
>>>>>       mutex_lock(&conn_state->lock);
>>>>> -    if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) {
>>>>> -        r = 0;
>>>>> -        goto out;
>>>>> -    } else if (conn_state->state == 
>>>>> AMDGPU_UALINK_CONN_IN_PROGRESS ||
>>>>> -           conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
>>>>> +    if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
>>>>> +        conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
>>>>>           r = -EAGAIN;
>>>>>           goto out;
>>>>>       }
>>>>>   +    if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED &&
>>>>> +        !amdgpu_ualink_peer_idle(adev, remote_acc_id)) {
>>>>> +        r = 0;
>>>>> +        goto out;
>>>>> +    }
>>>>> +
>>>>> +    /* Peer is idle or not connected, it may have rebooted. Skip the
>>>>> +     * handshake if the rings are still in sync, it would reset 
>>>>> the remote.
>>>>> +     */
>>>>> +    r = amdgpu_ualink_ring_resync_ptrs(adev, remote_acc_id);
>>>>> +    if (r < 0)
>>>>> +        goto out;
>>>>> +    if (!r && conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED)
>>>>> +        goto out;
>>>>> +
>>>>> +    amdgpu_ualink_reset_peer_rings(adev, remote_acc_id);
>>>>> +
>>>>>       conn_state->state = AMDGPU_UALINK_CONN_IN_PROGRESS;
>>>>> +
>>>>>       mutex_unlock(&conn_state->lock);
>>>>>         /* Send HELLO message */
>>>>> @@ -3670,7 +3709,7 @@ static int 
>>>>> amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
>>>>>           dev_warn(adev->dev,
>>>>>               "IMPORT: NPA-REQ send failed to remote AccId:%u\n",
>>>>>               remote_acc_id);
>>>>> -        return r;
>>>>> +        goto reset_conn;
>>>>>       }
>>>>>         /* Wait for the NPA_RSP to come back */
>>>>> @@ -5511,6 +5550,34 @@ static void 
>>>>> amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
>>>>>   typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32 wb, u32 
>>>>> dw0,
>>>>>                      u32 dw1, u32 dw2, u32 dw3);
>>>>>   +/*
>>>>> + * Refresh rptr from the writeback and check the ring has room 
>>>>> for one more
>>>>> + * command. The caller must hold the peer lock.
>>>>> + *
>>>>> + * Return 0 on success or a negative error code.
>>>>> + */
>>>>> +static int amdgpu_ualink_ring_check_space(struct amdgpu_device 
>>>>> *adev,
>>>>> +                      u32 remote_accel_id,
>>>>> +                      struct amdgpu_ualink_ring *ring,
>>>>> +                      struct amdgpu_ualink_wb *wb_cpu)
>>>>> +{
>>>>> +    ring->rptr = READ_ONCE(wb_cpu->rptr);
>>>>> +
>>>>> +    if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
>>>>> +        dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx 
>>>>> rptr 0x%llx\n",
>>>>> +            remote_accel_id, ring->wptr, ring->rptr);
>>>>> +        return -EFAULT;
>>>>> +    }
>>>>> +
>>>>> +    if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
>>>>> +        dev_err(adev->dev, "accel_id %u command ring full wptr 
>>>>> 0x%llx rptr 0x%llx\n",
>>>>> +            remote_accel_id, ring->wptr, ring->rptr);
>>>>> +        return -ENOSPC;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>   static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>>                         u32 remote_accel_id,
>>>>>                         struct amdgpu_ualink_ring *ring,
>>>>> @@ -5536,6 +5603,10 @@ static int 
>>>>> amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>>         peer = &remote->peer[remote_accel_id];
>>>>>   +    r = amdgpu_ualink_ring_check_space(adev, remote_accel_id, 
>>>>> ring, wb_cpu);
>>>>> +    if (r)
>>>>> +        goto out;
>>>>> +
>>>>>       /*
>>>>>        * 3 sdma copy commands: write data to ring buffer, update 
>>>>> wptr, ring doorbell
>>>>>        *
>>>>> @@ -5552,25 +5623,7 @@ static int 
>>>>> amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>>                        ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>>>> AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>>>>       if (r)
>>>>> -        return r;
>>>>> -
>>>>> -    mutex_lock(&peer->lock);
>>>>> -
>>>>> -    ring->rptr = READ_ONCE(wb_cpu->rptr);
>>>>> -
>>>>> -    if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
>>>>> -        dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx 
>>>>> rptr 0x%llx\n",
>>>>> -            remote_accel_id, ring->wptr, ring->rptr);
>>>>> -        r = -EFAULT;
>>>>> -        goto unlock_free;
>>>>> -    }
>>>>> -
>>>>> -    if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
>>>>> -        dev_err(adev->dev, "accel_id %u command ring full wptr 
>>>>> 0x%llx rptr 0x%llx\n",
>>>>> -            remote_accel_id, ring->wptr, ring->rptr);
>>>>> -        r = -ENOSPC;
>>>>> -        goto unlock_free;
>>>>> -    }
>>>>> +        goto out;
>>>>>         ib = &job->ibs[0];
>>>>>       src = ib->gpu_addr + ndw_copy_cmd * 4;
>>>>> @@ -5628,12 +5681,11 @@ static int 
>>>>> amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>>               dev_dbg(adev->dev,
>>>>>                   "remote %u lsdma copy failed (r %d), skip 
>>>>> completion wait\n",
>>>>>                   remote_accel_id, r);
>>>>> -            mutex_unlock(&peer->lock);
>>>>>               return r;
>>>>>           }
>>>>>             goto out_wait_complete;
>>>>> -        }
>>>>> +    }
>>>>>         sdma_ring = &adev->sdma.instance[0].ring;
>>>>>   @@ -5664,12 +5716,9 @@ static int 
>>>>> amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>>       if (r <= 0) {
>>>>>           dev_dbg(adev->dev, "remote %u sdma fence wait return r 
>>>>> %d\n",
>>>>>               remote_accel_id, r);
>>>>> -
>>>>>           if (r == 0)
>>>>>               r = -ETIME;
>>>>> -
>>>>> -        mutex_unlock(&peer->lock);
>>>>> -        return r;
>>>>> +        goto out;
>>>>>       }
>>>>>     out_wait_complete:
>>>>> @@ -5678,21 +5727,15 @@ static int 
>>>>> amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>>        */
>>>>>       r = amdgpu_ualink_remote_wait_timeout(adev, remote_accel_id, 
>>>>> wb_cpu, seq);
>>>>>   -    /* increase local copy ring wptr, only if FW not timeout */
>>>>> -    if (r != -ETIME)
>>>>> -        ring->wptr++;
>>>>> -
>>>>>       /*
>>>>> -     * Release ring lock after the remote FW handle command 
>>>>> completes to
>>>>> -     * prevent race conditions.
>>>>> +     * Advance wptr unless the remote timed out, even if the FW 
>>>>> returned an
>>>>> +     * error status. On timeout the caller resets the connection, 
>>>>> which
>>>>> +     * resyncs wptr from the remote in 
>>>>> amdgpu_ualink_setup_connection.
>>>>>        */
>>>>> -    mutex_unlock(&peer->lock);
>>>>> -    return r;
>>>>> -
>>>>> +    if (r != -ETIME)
>>>>> +        ring->wptr++;
>>>>>   -unlock_free:
>>>>> -    mutex_unlock(&peer->lock);
>>>>> -    amdgpu_job_free(job);
>>>>> +out:
>>>>>       dev_dbg(adev->dev, "ret r = %d\n", r);
>>>>>       return r;
>>>>>   }
>>>>> @@ -5732,6 +5775,192 @@ static void 
>>>>> amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>>>>>           remote_accel_id, npa + offset);
>>>>>   }
>>>>>   +struct amdgpu_ualink_wptr_fence_cb {
>>>>> +    struct dma_fence_cb base;
>>>>> +    u64 *wptr_cpu;
>>>>> +    u64 result;
>>>>> +};
>>>>> +
>>>>> +static void amdgpu_ualink_read_wptr_fence_cb(struct dma_fence 
>>>>> *fence,
>>>>> +                         struct dma_fence_cb *cb)
>>>>> +{
>>>>> +    struct amdgpu_ualink_wptr_fence_cb *wptr_cb;
>>>>> +
>>>>> +    wptr_cb = container_of(cb, typeof(*wptr_cb), base);
>>>>> +    wptr_cb->result = *wptr_cb->wptr_cpu;
>>>>> +}
>>>>> +
>>>>> +static int amdgpu_ualink_read_remote_wptr(struct amdgpu_device 
>>>>> *adev,
>>>>> +                      u32 remote_accel_id,
>>>>> +                      struct amdgpu_ualink_ring *ring,
>>>>> +                      u64 *wptr)
>>>>> +{
>>>>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>>> +    struct amdgpu_ualink_peer *peer = 
>>>>> &remote->peer[remote_accel_id];
>>>>> +    struct amdgpu_ualink_wptr_fence_cb wptr_cb = { };
>>>>> +    struct amdgpu_ring *sdma_ring;
>>>>> +    struct dma_fence *fence;
>>>>> +    struct amdgpu_job *job;
>>>>> +    struct amdgpu_ib *ib;
>>>>> +    u32 ndw, ndw_copy_cmd;
>>>>> +    u64 wptr_gpu, *wptr_cpu;
>>>>> +    int r = 0;
>>>>> +
>>>> Minor nitpick here.
>>>>
>>>> Maybe we should check here that the accelerator state is still 
>>>> active similar to what we are doing in
>>>>
>>>> amdgpu_ualink_send_command().onnection is estiblished,
>>>>
>>> good point, will add below check, vpod could be deactivated from 
>>> side-band when app is running.
>>>
>>>     /* Refuse sends unless active */
>>>     if (adev->ualink.info->accel_state != 
>>> AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
>>>         return -ESHUTDOWN;
>>
>> Are you sure? I was thinking that reading the remote rptr should be 
>> done regardless of the accelerator state. This needs to happen before 
>> we can make the accelerator active for the first time.
>>
> Are you mixing connection_state vs accel_state here? Accel_state needs 
> to be active before any communication with a remote GPU is done.
>
Yes, I was. Thanks. Makes sense, remote access should only happen when 
AIFM has configured the accelerator into active state.


> Regards,
>
> Mukul
>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Philip
>>>>
>>>> Other than that, this patch is:
>>>>
>>>> Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
>>>>
>>>>> +    *wptr = 0;
>>>>> +
>>>>> +    /* 1 sdma copy command to read wptr */
>>>>> +    ndw_copy_cmd = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>>>>> +
>>>>> +    /* wptr 2 dwords */
>>>>> +    ndw = ndw_copy_cmd + 2;
>>>>> +    r = amdgpu_job_alloc_with_ib(adev, &peer->entity, 
>>>>> AMDGPU_FENCE_OWNER_VM,
>>>>> +                     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>>>> + AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> +    ib = &job->ibs[0];
>>>>> +    wptr_gpu = ib->gpu_addr + ndw_copy_cmd * 4;
>>>>> +    wptr_cpu = (u64 *)(ib->ptr + ndw_copy_cmd);
>>>>> +
>>>>> +    dev_dbg(adev->dev, "read wptr from remote %u npa gart wptr 
>>>>> 0x%llx use %s\n",
>>>>> +        remote_accel_id, ring->wptr_npa_gart,
>>>>> +        remote->use_lsdma ? "lsdma" : "sdma");
>>>>> +
>>>>> +    if (remote->use_lsdma) {
>>>>> +        r = amdgpu_lsdma_copy_mem(adev, ring->wptr_npa_gart, 
>>>>> wptr_gpu, 8);
>>>>> +        if (!r)
>>>>> +            *wptr = *wptr_cpu;
>>>>> +        amdgpu_job_free(job);
>>>>> +        goto out;
>>>>> +    }
>>>>> +
>>>>> +    wptr_cb.wptr_cpu = wptr_cpu;
>>>>> +
>>>>> +    amdgpu_emit_copy_buffer(adev, ib, ring->wptr_npa_gart, 
>>>>> wptr_gpu, 8, 0);
>>>>> +
>>>>> +    sdma_ring = &adev->sdma.instance[0].ring;
>>>>> +    amdgpu_ring_pad_ib(sdma_ring, ib);
>>>>> +    WARN_ON(ib->length_dw > ndw_copy_cmd);
>>>>> +
>>>>> +    fence = amdgpu_job_submit(job);
>>>>> +
>>>>> +    r = dma_fence_add_callback(fence, &wptr_cb.base,
>>>>> +                   amdgpu_ualink_read_wptr_fence_cb);
>>>>> +    if (r == -ENOENT) {
>>>>> +        /* Fence already signaled; the callback won't run, do it 
>>>>> inline. */
>>>>> +        amdgpu_ualink_read_wptr_fence_cb(fence, &wptr_cb.base);
>>>>> +        r = 0;
>>>>> +        goto out_put_fence;
>>>>> +    } else if (r) {
>>>>> +        /* -EINVAL: NULL fence or func, not expected here. */
>>>>> +        goto out_put_fence;
>>>>> +    }
>>>>> +
>>>>> +    r = dma_fence_wait_timeout(fence, false, 
>>>>> AMDGPU_FENCE_JIFFIES_TIMEOUT);
>>>>> +    if (r > 0) {
>>>>> +        r = 0;    /* read wptr successfully */
>>>>> +        goto out_put_fence;
>>>>> +    }
>>>>> +
>>>>> +    dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
>>>>> +        remote_accel_id, r);
>>>>> +
>>>>> +    if (r == 0)
>>>>> +        r = -ETIME;
>>>>> +
>>>>> +    /*
>>>>> +     * Timed out: the callback is still armed and wptr_cb is on 
>>>>> our stack.
>>>>> +     * Cancel it so it can't fire after we return and write into 
>>>>> the freed
>>>>> +     * stack frame.
>>>>> +     */
>>>>> +    dma_fence_remove_callback(fence, &wptr_cb.base);
>>>>> +
>>>>> +out_put_fence:
>>>>> +    if (!r)
>>>>> +        *wptr = wptr_cb.result;
>>>>> +    dma_fence_put(fence);
>>>>> +
>>>>> +out:
>>>>> +    dev_dbg(adev->dev, "remote %u wptr 0x%llx return %d\n",
>>>>> +        remote_accel_id, *wptr, r);
>>>>> +    return r;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * amdgpu_ualink_ring_resync_ptrs - sync local ring pointers from 
>>>>> remote
>>>>> + * @adev: amdgpu device pointer
>>>>> + * @remote_accel_id: remote accelerator ID
>>>>> + *
>>>>> + * After a reboot on either side the two ends disagree on wptr. 
>>>>> Read the remote
>>>>> + * wptr of both peer rings and adopt it as the local wptr and rptr.
>>>>> + *
>>>>> + * Return 0 if both rings already match, 1 if they were resynced, 
>>>>> or a negative
>>>>> + * error code if a remote read failed, leaving the rings untouched.
>>>>> + */
>>>>> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device 
>>>>> *adev,
>>>>> +                      u32 remote_accel_id)
>>>>> +{
>>>>> +    struct amdgpu_ualink_peer *peer = 
>>>>> &to_remote(adev)->peer[remote_accel_id];
>>>>> +    struct amdgpu_ualink_wb *int_wb, *tlb_wb;
>>>>> +    u64 int_wptr, tlb_wptr;
>>>>> +    int r;
>>>>> +
>>>>> +    /* ring->wptr and ring->rptr are owned by the send path. */
>>>>> +    guard(mutex)(&peer->lock);
>>>>> +
>>>>> +    /* Read both before updating either, so a failure changes 
>>>>> nothing. */
>>>>> +    r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
>>>>> +                       &peer->interrupt, &int_wptr);
>>>>> +    if (!r)
>>>>> +        r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
>>>>> +                           &peer->shootdown, &tlb_wptr);
>>>>> +    if (r) {
>>>>> +        dev_dbg(adev->dev, "accel_id %u read remote %u wptr 
>>>>> failed %d\n",
>>>>> +            ualink_accel_id(adev), remote_accel_id, r);
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr 
>>>>> == tlb_wptr) {
>>>>> +        dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is 
>>>>> same as remote %u\n",
>>>>> +            ualink_accel_id(adev), int_wptr, tlb_wptr, 
>>>>> remote_accel_id);
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    dev_dbg(adev->dev,
>>>>> +        "accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 
>>>>> 0x%llx 0x%llx\n",
>>>>> +        ualink_accel_id(adev), peer->interrupt.wptr, 
>>>>> peer->shootdown.wptr,
>>>>> +        remote_accel_id, int_wptr, tlb_wptr);
>>>>> +
>>>>> +    amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
>>>>> +                  RB_TYPE_REMOTE_INTERRUPT);
>>>>> +    amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
>>>>> +                  RB_TYPE_TLB_INV);
>>>>> +
>>>>> +    peer->interrupt.wptr = int_wptr;
>>>>> +    peer->interrupt.rptr = int_wptr;
>>>>> +    peer->shootdown.wptr = tlb_wptr;
>>>>> +    peer->shootdown.rptr = tlb_wptr;
>>>>> +
>>>>> +    /* Drop the stale writeback rptr, it disagrees with the 
>>>>> resynced wptr. */
>>>>> +    WRITE_ONCE(int_wb->rptr, int_wptr);
>>>>> +    WRITE_ONCE(tlb_wb->rptr, tlb_wptr);
>>>>> +    return 1;
>>>>> +}
>>>>> +
>>>>> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device 
>>>>> *adev,
>>>>> +                       u32 remote_accel_id)
>>>>> +{
>>>>> +    struct amdgpu_ualink_peer *peer = 
>>>>> &to_remote(adev)->peer[remote_accel_id];
>>>>> +
>>>>> +    dev_dbg(adev->dev, "remote accel_id %u\n", remote_accel_id);
>>>>> +
>>>>> +    guard(mutex)(&peer->lock);
>>>>> +
>>>>> +    peer->interrupt.ready = false;
>>>>> +    peer->shootdown.ready = false;
>>>>> +}
>>>>> +
>>>>>   static int amdgpu_ualink_update_wb_address(struct amdgpu_device 
>>>>> *adev,
>>>>>                          u32 remote_accel_id, u32 ring_type)
>>>>>   {
>>>>> @@ -5794,6 +6023,9 @@ static int 
>>>>> amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>>>>         peer = &remote->peer[remote_accel_id];
>>>>>       ring = &peer->shootdown;
>>>>> +
>>>>> +    guard(mutex)(&peer->lock);
>>>>> +
>>>>>       if (!ring->ready) {
>>>>>           dev_dbg(adev->dev, "accel_id %u ring not ready\n", 
>>>>> remote_accel_id);
>>>>>           r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>>>> @@ -5802,11 +6034,11 @@ static int 
>>>>> amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>>>>               return r;
>>>>>       }
>>>>>   -    r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, 
>>>>> ring->wb_cpu,
>>>>> -                       amdgpu_ualink_emit_shootdown,
>>>>> -                       flush_type, upper_32_bits(addr),
>>>>> -                       lower_32_bits(addr), size_in_pages);
>>>>> -    return r;
>>>>> +    return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
>>>>> +                      ring->wb_cpu,
>>>>> +                      amdgpu_ualink_emit_shootdown,
>>>>> +                      flush_type, upper_32_bits(addr),
>>>>> +                      lower_32_bits(addr), size_in_pages);
>>>>>   }
>>>>>     /**
>>>>> @@ -5835,6 +6067,9 @@ static int 
>>>>> amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>>>>         peer = &remote->peer[remote_accel_id];
>>>>>       ring = &peer->interrupt;
>>>>> +
>>>>> +    guard(mutex)(&peer->lock);
>>>>> +
>>>>>       if (!ring->ready) {
>>>>>           dev_dbg(adev->dev, "accel_id %u ring not ready\n", 
>>>>> remote_accel_id);
>>>>>           r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>>>> @@ -5843,10 +6078,10 @@ static int 
>>>>> amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>>>>               return r;
>>>>>       }
>>>>>   -    r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, 
>>>>> ring->wb_cpu,
>>>>> -                       amdgpu_ualink_emit_interrupt,
>>>>> -                       dw0, dw1, dw2, dw3);
>>>>> -    return r;
>>>>> +    return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
>>>>> +                      ring->wb_cpu,
>>>>> +                      amdgpu_ualink_emit_interrupt,
>>>>> +                      dw0, dw1, dw2, dw3);
>>>>>   }
>>>>>     /**
>>>
