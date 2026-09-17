Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D7DC982D6
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 14:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C7E10EEC1;
	Thu, 17 Sep 2026 14:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6Iotj9H";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012059.outbound.protection.outlook.com
 [40.93.195.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7586A10EEC1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 14:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhGqJAZ40bJvDgZ5jDDHfCyDeNBJ0v+wLnCLvmzGj5w1YOe0SbMVf3I7ghodbD1V5DHUsSXKU6q6fF+f2OaaeB65GSwPPD5PUpeYuCOyWL4jgwMaLqrM/keB71YcYR6rLavidhaY0xtHw6DlicowlK/zzVpTWmv6NUCDocD2eqGSsPgCN5jYnsCwMXJWPJP/eft/DOcx6fPAfqKqOv5Yv0PRJyMAqsbEoQ0ArfbgvuknTOL4Rsp6dBcG0dhOkxYurRpWL+L7kH9hLqvzJVUej1UzKOBL86ppuIC+UstckaEwQmF1b4AHm0hfwSJcEWtfSkbWKnM8E4ubZZ4C5btmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiDSymc4BkiCuJ8WHD6sdkvsTQQZ4g8q8mjc43VYMr0=;
 b=Px/wFpclEZNQpeyw3tc9fKCNbHg4id40FDdM9zYE2XYLuzdzMSn3koJBubIgH9DkarAZ3fuYZA1gBd4Ld3rREJ7Q1yK9Lj93IahZvEmWkfrzeyemV+3SX1HPViDhzHQ05n9hO04+4ZhSrtOmIok/eqS7e7ydwBGVaYK5YpsOcLWDMkGZk74GIwpYf9Z8fiJb61wK5qNdYklCR0LW7mM4g89o3q0U1+RfFigKhn7qCyWvRnpBmqp5YfBG12HEb+dq3v/awWGE6qHZOg5D+8J58e2h69Cq15Wtd0HNFP3PY1fq/6a9G7y/xtq27d2EgWMnXTB0mQaMPg2CTNBnacjUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiDSymc4BkiCuJ8WHD6sdkvsTQQZ4g8q8mjc43VYMr0=;
 b=A6Iotj9HXWrcU1MoIs1s4pcxHd2OW87HYOfryphOd0SLL8IUEasjU+qTEx24bo7MSjhOCL2dRFGTkt8nBBwBKW21EKjPvweA6SpmXjeZ2fmIgvYzC9vrnz5FgAAfEEcHyqsB7mS4QE+gm8nccVqNSUjyqeAu+Jt7UuNPruzhWrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 14:07:21 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 14:07:20 +0000
Content-Type: multipart/alternative;
 boundary="------------cKPkq5At1nDVgOEmePP26bTi"
Message-ID: <ca5f45bb-2bbd-464b-94fb-336456e9966c@amd.com>
Date: Thu, 17 Sep 2026 10:07:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] drm/amdgpu: Resync UALink ring wptr after reboot
To: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20260916152528.3918848-1-Philip.Yang@amd.com>
 <b6349b6d-0357-4850-8957-6d2d17649a05@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <b6349b6d-0357-4850-8957-6d2d17649a05@amd.com>
X-ClientProxiedBy: YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::20) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dda62c-22d7-4043-0d23-08df14c4fd21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18002099003|3023799007|22082099003|8096899003|4143699003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 584+J6FRXN9kWXwbyvTUpC4My1XXE9hIyi8H0P+83xhJUSDPVZLax0T1lAlkP63QTeu6XSfgNdQnj/Nau+r1UKl0cjC2+QMIBmkcUuJpddd9Rp3bpjlLwq6u408l3CXSsNZyzoTr1oNQtfxhoynuKNgkz3cBMvCfGvroIxT28JrtAhbVI9coi/GRbdoP6sLqvZ1LEE+EkY/F5qxkO2lcN2LQHFKXPLEl4MGiJy8Taytj1YO0FTFgYQdTecBwstzFpluVp+EhYYmoXhG1cbU9CHF2My09L0T8SkmUPbTeDFUPJfcZ8alcfdM3tEGWMySoZp68MIyoSlMbn18clW3k4nuY+wzRP1DZe6Lp33QceN7W8q+6MO4aGzpPEHQ9HI+egBUpVGUrdfh+F19ypjUBIkNicwlwtJlizp4tTZ4TvY/83Xo5h6sIXykgZbPWkmVg/LQYFgViSeu6Caknie34X6Ym94B2EuYug+wGGwlMirTp0iJHy+phP6dWm5HEZGpZVu0XOApPec/XT3pYhU2AECsK3ptjUvMi2CyQ1gDYkd+gzuqV9Ep9abmCMScF6NbZnJyWgttv4eVgCXseTNbSRUk1ea8DZjtU9+IUQqZPaw6kAvy8DZTNnv7nFTlEtW4xwlLIh8EOBYfAZ45lLM73jc/l5AQIUi0oaAMiqfIyuT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18002099003)(3023799007)(22082099003)(8096899003)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJEbFBhOVBZV2pteFNaVnI0dXlOQ0hQWVZ1OGZuRmRUcVhDeHVHM1IyQU9s?=
 =?utf-8?B?R1Q1elNWa0NxNXhlQmdWYTRsM1VySzVxdVI2MkhkbTl4akRDVUwwRldzRzNl?=
 =?utf-8?B?WFpoM0V0aVd1UGFHVjFZVUdzNDg2OXVaSEFaMDMyNVVVbFl6bi93V1BENS9L?=
 =?utf-8?B?L1paQnF3M0lWNEltaGllZVZVTTlvSlpoeFF1V2lQQ1RUZWpuVGlqa3RYaFQ2?=
 =?utf-8?B?clI3NjdpYXprcGRLaTh5aklJTnkzNTZvT2VOZnQvaE1iL2x1NUlUODNqajJm?=
 =?utf-8?B?aVU2SHpPT0MyaXJZQ1VYZmFKa3g2ZEtsYmZTYTVmdmgxdG9sWURaOFNBWVFY?=
 =?utf-8?B?MUtrRnkwbXpzbUE5dmFreXVrR3YyaDk2dVkvSGlQTTdEOEpIdEV0N0hVMDNH?=
 =?utf-8?B?T1lTZm1wUjN6ZWlkM3FZaGNJT1ZYV011SS9MMVpVa0hVYzRhZG1yZmczMGho?=
 =?utf-8?B?Y3pSd1U5S3F2VWRDZ04rTGhsTE9LVmNkWkRlVG1TTkxZbkt6NE5HZE01dnJn?=
 =?utf-8?B?WnR0RDJ0ZTJHYWdnZDJJbG5vbjZYODRhdmoySUNxcGRWblRHRjdOVFUwVGNv?=
 =?utf-8?B?RUxQOXR4NHB1K2NwNGFrWTZ2RUwyUk5LcmZFV01VUHUyWGdKY3JaSlVvaHB0?=
 =?utf-8?B?MzlqUG11RzZERWRSTkpna3V1ZExEc3ZtZStyTzhVWlFIVSsxalgyY0wwSmVI?=
 =?utf-8?B?TWtKK0Y3QVBJb0kxem43K2tCWG1ZZnZ5cWF1KzlpQUVPSjRwTGIyK2k0OEpM?=
 =?utf-8?B?VGJxVmxtZERwK3RBNkJZZGkyaERzekx5ejdPK0Ntd0lDRGs2R2MyZjR5c3M3?=
 =?utf-8?B?c0tubVpmK0tLWk9oVUs2QWxpUnVGNHdXblBVMmZPTzhnTEQ4VU5KRXRUNGRr?=
 =?utf-8?B?cVBEVEFPNDhBcVNyTzU5Slo4VlByTUhVZTNhakxxdmZNTlZsL3dhb1FWUVJW?=
 =?utf-8?B?N3VNQk11TEU3R2Z5OXdFYlZQWUdhOUdpc0RUZnYyQ1NLWDB3ZVI0MGkwcGVI?=
 =?utf-8?B?T3JWNVBFMGRmSjRLLzFFZEtZZXk1Qlh5TVJ0eVFTQVpmNU9jVXlIZHlwem5O?=
 =?utf-8?B?ZnFIS2czU0dBdUdBVHVORFh4MnNMNENGK2pYZ0JEZUcrcnR1eWlWMjdJQm5X?=
 =?utf-8?B?WVF2bUd4UC9rc2RmSlFxdzh0YWlUeDZhRjNickNkNm0zRlZKa0NUUGRlNFl5?=
 =?utf-8?B?a2g2bE9sd0NpZFFaengzRC9hU2pPREhqckJwVGZ3NXh6M0dabE0xeDdwTnVD?=
 =?utf-8?B?MkE5MDRYYStOd0hNVUhUOUhLR2VpMFJXMytzUkdtdU5ObHJabHVRa1NObUtD?=
 =?utf-8?B?RHkramJLQ1NkR2wvR1p2NEpXSktwbHZJdTB4ZUxKa2pTLytMZ2xiL3FjTDUy?=
 =?utf-8?B?YWd3WWdScnVQV1lvN3h4YVRtTld2MTdoR2tuQlZOUDNOZ2w2V3YxNDVjaElH?=
 =?utf-8?B?NVBxVUZzTVN0N00zT3RFMWpnTmpVMTJYdTBpaXphTFhDVWZ1UHp0RVF2Q1hD?=
 =?utf-8?B?Rkd4VXdJWTE1aThnSkxnbFFoN0NlZG9WMjFsMzl3amlMMVZnQ0FpeWtWcGR0?=
 =?utf-8?B?aG9zVGZsR01uRVVmOWF2MkFTYW4vZWtNQUhIdGpodzRGb0h3OVB1VE82a0tN?=
 =?utf-8?B?d0haU0gzWVdlT1RrY2F6WVplczFGdVhWM0M1cXJNVzNxN0YrV3dJSU5aRk9r?=
 =?utf-8?B?TDUwZkR3ajR1VVJaa1k4S3gzMXJuY1U4UEM2S0M5c1FWTU81aFZ5R09XMG1F?=
 =?utf-8?B?cFg2VkVUL3ZiL1k0NnpDOVFIK05OSHpIVVYyVjRuN0ZINUcrZHBLMkZ1NXVL?=
 =?utf-8?B?Yi9CMnBoVkhtSDl1WktVQ2xCWXJ6dHo5ZmxNeUR2Tkp6MHBIVUlpb3NYSEpR?=
 =?utf-8?B?WGljNm9wbTJCMzBjRzA3Nnh6alhzRjhBbU1zbDBmVk5SRW5IVStMZXpDbVE5?=
 =?utf-8?B?aUZnTVJ1Zm5mYmRDY0hta0ladWp2QmdjSWNtSEFDckJPY0M3Nzk4LytaNHcr?=
 =?utf-8?B?M3IycUxJMlVLTG1XYzFNZStvMDR1RXBhS1FoNjBvdHJtWnpkd2xzM2tZZ2xv?=
 =?utf-8?B?SldzaEZSSXJyMUhWN3J1L2tzVVo4MFZ5cVRBRGd5OGRwK3Y3Y09XZWovOEtm?=
 =?utf-8?B?QlVYWGFWQmEwRkl0SWhqaWtiazkrb0tnSkpIUzBDeG00TjNFM1k3Um5rQ0ZS?=
 =?utf-8?B?ODI5TmEyRHZGWVNiOURtWXdsWVpQeUVoeWVrWUJLbHcvUDZWYXE1SWRVcFJ2?=
 =?utf-8?B?L1ArVVJaL3B2Q2NkTllkbnZUTnIwTEpIVG5COWUvNUN0R3VBK0k4MXkxS3Fq?=
 =?utf-8?Q?fy80BRMlZGOjeuXN5S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dda62c-22d7-4043-0d23-08df14c4fd21
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:07:20.4630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEU9hz4/w5QumDQRL4ODMxmQ45z6vBFjHJEV1RKLV9nps+bfO0D6AM0sMh+x0cHk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280
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

--------------cKPkq5At1nDVgOEmePP26bTi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-09-16 21:33, Mukul Joshi wrote:
>
>
> On 9/16/2026 11:25 AM, Philip Yang wrote:
>> When one side of UALink nodes reboots, its ring wptr resets to 0 while
>> the peer keeps a stale value. Read the remote wptr and adopt it as the
>> local wptr and rptr to resync, before the first message is sent. Either
>> side can notice first, so do this both when setting up the connection
>> and when receiving the HELLO from the peer.
>>
>> On the sdma path, read the wptr in a fence callback because the IB buffer
>> holding the result is recycled once the fence signals, so reading it
>> after dma_fence_wait_timeout() is too late. The lsdma path copies
>> synchronously, so it reads the wptr directly.
>>
>> Take peer->lock in the callers (amdgpu_ualink_remote_interrupt and
>> amdgpu_ualink_remote_shootdown) instead of in amdgpu_ualink_send_command,
>> so the ring->ready check and the send are atomic against a concurrent
>> ring reset.
>>
>> Move the rptr refresh and ring-full check out of amdgpu_ualink_send_command()
>> into amdgpu_ualink_ring_check_space(), so it runs under the caller's
>> peer->lock before the job is allocated.
>>
>> On a failed NPA-REQ send, reset the connection like the NPA-RSP timeout path
>> already does, so the next attempt resyncs the ring wptr.
>>
>> On connection reset, amdgpu_ualink_reset_peer_rings() only clears
>> ring->ready, so the writeback address is re-registered on the next send.
>>
>> v10:
>>    - Fix the resync missed on the receiving side: after a reboot the peer
>>      may send HELLO before we set up the connection, so resync the ring
>>      wptr in amdgpu_ualink_process_hello_msg() too.
>>
>> v9:
>>    - Fix the unnecessary connection reset after an app exits: the peer is
>>      idle here but still busy handling NPA revokes on the remote, so the
>>      HELLO reset a healthy connection. Only send it if the wptr changed.
>>    - Resync both rings together under peer->lock, read both remote wptr
>>      before updating either so a failed read changes nothing.
>>
>> v8:
>>    - Fix regression with concurrent import ioctls: do the idle check and
>>      ring reset in amdgpu_ualink_setup_connection() under conn_state->lock,
>>      and return -EAGAIN for IN_PROGRESS/PENDING first.
>>    - Reset the peer rings only, the imp/exp xarray cleanup is not needed to
>>      resync wptr.
>>
>> v7:
>>    - With v6 reboot one node of vPOD test passed on minirack.
>>    - Use the per-remote imported and exported handle lists for the idle
>>      check instead of walking the xarrays.
>>    - Rename amdgpu_ualink_resync_peer_rings() to
>>      amdgpu_ualink_reset_peer_rings(), it only clears ring->ready.
>>
>> v6:
>>    - Check idleness per remote accelerator instead of globally, and reset
>>      the stale connection at the import ioctl so the peer re-runs the
>>      HELLO handshake after a reboot.
>>
>> v5:
>>    - Resync the ring pointers at the import ioctl when the connection is
>>      completely idle (no exported or imported BOs), so the first command
>>      from a new application after a remote reboot/reset succeeds.
>>    - Put the sdma wptr read fence callback on the stack instead of
>>      allocating it; it is cancelled on timeout so it never outlives the
>>      call.
>>
>> v4:
>>    - Cancel the sdma fence callback on the wait timeout/failure path so it
>>      cannot write into the caller's stack after the function returns, and
>>      free the callback state in one place.
>>
>> v3:
>>    - Resync both rings at connection setup instead of on the send path.
>>    - Set the writeback rptr too, the stale value disagrees with the
>>      resynced wptr until the remote FW writes it back.
>>
>> v2:
>>    - Match the FW change: resync wptr only on the first send or after a
>>      timeout, instead of checking the remote periodically.
>>
>> Suggested-by: Felix Kuehling<felix.kuehling@amd.com>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 339 +++++++++++++++++----
>>   1 file changed, 287 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index b2c2650b0149..c0327f6854a6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -56,6 +56,10 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>   					  u32 size_in_pages, u32 flush_type);
>>   static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
>>   static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev);
>> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>> +					   u32 remote_accel_id);
>> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>> +					  u32 remote_accel_id);
>>   
>>   #define STRIP_NPA(addr)						\
>>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
>> @@ -2282,11 +2286,23 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>>   						generation_count);
>>   	}
>>   
>> +	/* Peer may have rebooted. */
>> +	r = amdgpu_ualink_ring_resync_ptrs(adev, sender_acc_id);
>> +	if (r < 0) {
>> +		dev_err(adev->dev,
>> +			"HELLO: resync sender AccId %u ptrs failed %d\n",
>> +			sender_acc_id, r);
>> +		goto out_set_state;
>> +	}
>> +	if (r)
>> +		amdgpu_ualink_reset_peer_rings(adev, sender_acc_id);
>> +
>>   	r = amdgpu_ualink_send_hello_ack_msg(adev, sender_acc_id);
>>   	if (r)
>>   		dev_err(adev->dev, "HELLO-ACK: send failed to remote AccId:%u\n",
>>   			sender_acc_id);
>>   
>> +out_set_state:
>>   	mutex_lock(&conn_state->lock);
>>   	if (r) {
>>   		conn_state->state = AMDGPU_UALINK_CONN_NOT_READY;
>> @@ -2303,6 +2319,14 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>>   	mutex_unlock(&conn_state->lock);
>>   }
>>   
>> +/* True if nothing is exported to, or imported from, this remote accelerator. */
>> +static bool amdgpu_ualink_peer_idle(struct amdgpu_device *adev, u32 remote_accel_id)
>> +{
>> +	/* Unlocked: a racing import at worst costs one redundant ring resync. */
>> +	return list_empty(&adev->ualink.imp_handles_list[remote_accel_id]) &&
>> +	       list_empty(&adev->ualink.exp_handles_list[remote_accel_id]);
>> +}
>> +
>>   static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
>>   					  u32 remote_acc_id)
>>   {
>> @@ -2324,16 +2348,31 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
>>   	 * already done by another thread.
>>   	 */
>>   	mutex_lock(&conn_state->lock);
>> -	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) {
>> -		r = 0;
>> -		goto out;
>> -	} else if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
>> -		   conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
>> +	if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
>> +	    conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
>>   		r = -EAGAIN;
>>   		goto out;
>>   	}
>>   
>> +	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED &&
>> +	    !amdgpu_ualink_peer_idle(adev, remote_acc_id)) {
>> +		r = 0;
>> +		goto out;
>> +	}
>> +
>> +	/* Peer is idle or not connected, it may have rebooted. Skip the
>> +	 * handshake if the rings are still in sync, it would reset the remote.
>> +	 */
>> +	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_acc_id);
>> +	if (r < 0)
>> +		goto out;
>> +	if (!r && conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED)
>> +		goto out;
>> +
>> +	amdgpu_ualink_reset_peer_rings(adev, remote_acc_id);
>> +
>>   	conn_state->state = AMDGPU_UALINK_CONN_IN_PROGRESS;
>> +
>>   	mutex_unlock(&conn_state->lock);
>>   
>>   	/* Send HELLO message */
>> @@ -3670,7 +3709,7 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
>>   		dev_warn(adev->dev,
>>   			"IMPORT: NPA-REQ send failed to remote AccId:%u\n",
>>   			remote_acc_id);
>> -		return r;
>> +		goto reset_conn;
>>   	}
>>   
>>   	/* Wait for the NPA_RSP to come back */
>> @@ -5511,6 +5550,34 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
>>   typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32 wb, u32 dw0,
>>   				   u32 dw1, u32 dw2, u32 dw3);
>>   
>> +/*
>> + * Refresh rptr from the writeback and check the ring has room for one more
>> + * command. The caller must hold the peer lock.
>> + *
>> + * Return 0 on success or a negative error code.
>> + */
>> +static int amdgpu_ualink_ring_check_space(struct amdgpu_device *adev,
>> +					  u32 remote_accel_id,
>> +					  struct amdgpu_ualink_ring *ring,
>> +					  struct amdgpu_ualink_wb *wb_cpu)
>> +{
>> +	ring->rptr = READ_ONCE(wb_cpu->rptr);
>> +
>> +	if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
>> +		dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n",
>> +			remote_accel_id, ring->wptr, ring->rptr);
>> +		return -EFAULT;
>> +	}
>> +
>> +	if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
>> +		dev_err(adev->dev, "accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n",
>> +			remote_accel_id, ring->wptr, ring->rptr);
>> +		return -ENOSPC;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>   				      u32 remote_accel_id,
>>   				      struct amdgpu_ualink_ring *ring,
>> @@ -5536,6 +5603,10 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>   
>>   	peer = &remote->peer[remote_accel_id];
>>   
>> +	r = amdgpu_ualink_ring_check_space(adev, remote_accel_id, ring, wb_cpu);
>> +	if (r)
>> +		goto out;
>> +
>>   	/*
>>   	 * 3 sdma copy commands: write data to ring buffer, update wptr, ring doorbell
>>   	 *
>> @@ -5552,25 +5623,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>   				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>   				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>   	if (r)
>> -		return r;
>> -
>> -	mutex_lock(&peer->lock);
>> -
>> -	ring->rptr = READ_ONCE(wb_cpu->rptr);
>> -
>> -	if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
>> -		dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n",
>> -			remote_accel_id, ring->wptr, ring->rptr);
>> -		r = -EFAULT;
>> -		goto unlock_free;
>> -	}
>> -
>> -	if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
>> -		dev_err(adev->dev, "accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n",
>> -			remote_accel_id, ring->wptr, ring->rptr);
>> -		r = -ENOSPC;
>> -		goto unlock_free;
>> -	}
>> +		goto out;
>>   
>>   	ib = &job->ibs[0];
>>   	src = ib->gpu_addr + ndw_copy_cmd * 4;
>> @@ -5628,12 +5681,11 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>   			dev_dbg(adev->dev,
>>   				"remote %u lsdma copy failed (r %d), skip completion wait\n",
>>   				remote_accel_id, r);
>> -			mutex_unlock(&peer->lock);
>>   			return r;
>>   		}
>>   
>>   		goto out_wait_complete;
>> -        }
>> +	}
>>   
>>   	sdma_ring = &adev->sdma.instance[0].ring;
>>   
>> @@ -5664,12 +5716,9 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>   	if (r <= 0) {
>>   		dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
>>   			remote_accel_id, r);
>> -
>>   		if (r == 0)
>>   			r = -ETIME;
>> -
>> -		mutex_unlock(&peer->lock);
>> -		return r;
>> +		goto out;
>>   	}
>>   
>>   out_wait_complete:
>> @@ -5678,21 +5727,15 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>   	 */
>>   	r = amdgpu_ualink_remote_wait_timeout(adev, remote_accel_id, wb_cpu, seq);
>>   
>> -	/* increase local copy ring wptr, only if FW not timeout */
>> -	if (r != -ETIME)
>> -		ring->wptr++;
>> -
>>   	/*
>> -	 * Release ring lock after the remote FW handle command completes to
>> -	 * prevent race conditions.
>> +	 * Advance wptr unless the remote timed out, even if the FW returned an
>> +	 * error status. On timeout the caller resets the connection, which
>> +	 * resyncs wptr from the remote in amdgpu_ualink_setup_connection.
>>   	 */
>> -	mutex_unlock(&peer->lock);
>> -	return r;
>> -
>> +	if (r != -ETIME)
>> +		ring->wptr++;
>>   
>> -unlock_free:
>> -	mutex_unlock(&peer->lock);
>> -	amdgpu_job_free(job);
>> +out:
>>   	dev_dbg(adev->dev, "ret r = %d\n", r);
>>   	return r;
>>   }
>> @@ -5732,6 +5775,192 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>>   		remote_accel_id, npa + offset);
>>   }
>>   
>> +struct amdgpu_ualink_wptr_fence_cb {
>> +	struct dma_fence_cb base;
>> +	u64 *wptr_cpu;
>> +	u64 result;
>> +};
>> +
>> +static void amdgpu_ualink_read_wptr_fence_cb(struct dma_fence *fence,
>> +					     struct dma_fence_cb *cb)
>> +{
>> +	struct amdgpu_ualink_wptr_fence_cb *wptr_cb;
>> +
>> +	wptr_cb = container_of(cb, typeof(*wptr_cb), base);
>> +	wptr_cb->result = *wptr_cb->wptr_cpu;
>> +}
>> +
>> +static int amdgpu_ualink_read_remote_wptr(struct amdgpu_device *adev,
>> +					  u32 remote_accel_id,
>> +					  struct amdgpu_ualink_ring *ring,
>> +					  u64 *wptr)
>> +{
>> +	struct amdgpu_ualink_remote *remote = to_remote(adev);
>> +	struct amdgpu_ualink_peer *peer = &remote->peer[remote_accel_id];
>> +	struct amdgpu_ualink_wptr_fence_cb wptr_cb = { };
>> +	struct amdgpu_ring *sdma_ring;
>> +	struct dma_fence *fence;
>> +	struct amdgpu_job *job;
>> +	struct amdgpu_ib *ib;
>> +	u32 ndw, ndw_copy_cmd;
>> +	u64 wptr_gpu, *wptr_cpu;
>> +	int r = 0;
>> +
> Minor nitpick here.
>
> Maybe we should check here that the accelerator state is still active 
> similar to what we are doing in
>
> amdgpu_ualink_send_command().onnection is estiblished,
>
good point, will add below check, vpod could be deactivated from 
side-band when app is running.

     /* Refuse sends unless active */
     if (adev->ualink.info->accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
         return -ESHUTDOWN;

Regards,
Philip
>
> Other than that, this patch is:
>
> Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
>
>> +	*wptr = 0;
>> +
>> +	/* 1 sdma copy command to read wptr */
>> +	ndw_copy_cmd = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>> +
>> +	/* wptr 2 dwords */
>> +	ndw = ndw_copy_cmd + 2;
>> +	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
>> +				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> +				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>> +	if (r)
>> +		return r;
>> +
>> +	ib = &job->ibs[0];
>> +	wptr_gpu = ib->gpu_addr + ndw_copy_cmd * 4;
>> +	wptr_cpu = (u64 *)(ib->ptr + ndw_copy_cmd);
>> +
>> +	dev_dbg(adev->dev, "read wptr from remote %u npa gart wptr 0x%llx use %s\n",
>> +		remote_accel_id, ring->wptr_npa_gart,
>> +		remote->use_lsdma ? "lsdma" : "sdma");
>> +
>> +	if (remote->use_lsdma) {
>> +		r = amdgpu_lsdma_copy_mem(adev, ring->wptr_npa_gart, wptr_gpu, 8);
>> +		if (!r)
>> +			*wptr = *wptr_cpu;
>> +		amdgpu_job_free(job);
>> +		goto out;
>> +	}
>> +
>> +	wptr_cb.wptr_cpu = wptr_cpu;
>> +
>> +	amdgpu_emit_copy_buffer(adev, ib, ring->wptr_npa_gart, wptr_gpu, 8, 0);
>> +
>> +	sdma_ring = &adev->sdma.instance[0].ring;
>> +	amdgpu_ring_pad_ib(sdma_ring, ib);
>> +	WARN_ON(ib->length_dw > ndw_copy_cmd);
>> +
>> +	fence = amdgpu_job_submit(job);
>> +
>> +	r = dma_fence_add_callback(fence, &wptr_cb.base,
>> +				   amdgpu_ualink_read_wptr_fence_cb);
>> +	if (r == -ENOENT) {
>> +		/* Fence already signaled; the callback won't run, do it inline. */
>> +		amdgpu_ualink_read_wptr_fence_cb(fence, &wptr_cb.base);
>> +		r = 0;
>> +		goto out_put_fence;
>> +	} else if (r) {
>> +		/* -EINVAL: NULL fence or func, not expected here. */
>> +		goto out_put_fence;
>> +	}
>> +
>> +	r = dma_fence_wait_timeout(fence, false, AMDGPU_FENCE_JIFFIES_TIMEOUT);
>> +	if (r > 0) {
>> +		r = 0;	/* read wptr successfully */
>> +		goto out_put_fence;
>> +	}
>> +
>> +	dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
>> +		remote_accel_id, r);
>> +
>> +	if (r == 0)
>> +		r = -ETIME;
>> +
>> +	/*
>> +	 * Timed out: the callback is still armed and wptr_cb is on our stack.
>> +	 * Cancel it so it can't fire after we return and write into the freed
>> +	 * stack frame.
>> +	 */
>> +	dma_fence_remove_callback(fence, &wptr_cb.base);
>> +
>> +out_put_fence:
>> +	if (!r)
>> +		*wptr = wptr_cb.result;
>> +	dma_fence_put(fence);
>> +
>> +out:
>> +	dev_dbg(adev->dev, "remote %u wptr 0x%llx return %d\n",
>> +		remote_accel_id, *wptr, r);
>> +	return r;
>> +}
>> +
>> +/**
>> + * amdgpu_ualink_ring_resync_ptrs - sync local ring pointers from remote
>> + * @adev: amdgpu device pointer
>> + * @remote_accel_id: remote accelerator ID
>> + *
>> + * After a reboot on either side the two ends disagree on wptr. Read the remote
>> + * wptr of both peer rings and adopt it as the local wptr and rptr.
>> + *
>> + * Return 0 if both rings already match, 1 if they were resynced, or a negative
>> + * error code if a remote read failed, leaving the rings untouched.
>> + */
>> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>> +					  u32 remote_accel_id)
>> +{
>> +	struct amdgpu_ualink_peer *peer = &to_remote(adev)->peer[remote_accel_id];
>> +	struct amdgpu_ualink_wb *int_wb, *tlb_wb;
>> +	u64 int_wptr, tlb_wptr;
>> +	int r;
>> +
>> +	/* ring->wptr and ring->rptr are owned by the send path. */
>> +	guard(mutex)(&peer->lock);
>> +
>> +	/* Read both before updating either, so a failure changes nothing. */
>> +	r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
>> +					   &peer->interrupt, &int_wptr);
>> +	if (!r)
>> +		r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
>> +						   &peer->shootdown, &tlb_wptr);
>> +	if (r) {
>> +		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
>> +			ualink_accel_id(adev), remote_accel_id, r);
>> +		return r;
>> +	}
>> +
>> +	if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr == tlb_wptr) {
>> +		dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n",
>> +			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
>> +		return 0;
>> +	}
>> +
>> +	dev_dbg(adev->dev,
>> +		"accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n",
>> +		ualink_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>> +		remote_accel_id, int_wptr, tlb_wptr);
>> +
>> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
>> +				  RB_TYPE_REMOTE_INTERRUPT);
>> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
>> +				  RB_TYPE_TLB_INV);
>> +
>> +	peer->interrupt.wptr = int_wptr;
>> +	peer->interrupt.rptr = int_wptr;
>> +	peer->shootdown.wptr = tlb_wptr;
>> +	peer->shootdown.rptr = tlb_wptr;
>> +
>> +	/* Drop the stale writeback rptr, it disagrees with the resynced wptr. */
>> +	WRITE_ONCE(int_wb->rptr, int_wptr);
>> +	WRITE_ONCE(tlb_wb->rptr, tlb_wptr);
>> +	return 1;
>> +}
>> +
>> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>> +					   u32 remote_accel_id)
>> +{
>> +	struct amdgpu_ualink_peer *peer = &to_remote(adev)->peer[remote_accel_id];
>> +
>> +	dev_dbg(adev->dev, "remote accel_id %u\n", remote_accel_id);
>> +
>> +	guard(mutex)(&peer->lock);
>> +
>> +	peer->interrupt.ready = false;
>> +	peer->shootdown.ready = false;
>> +}
>> +
>>   static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
>>   					   u32 remote_accel_id, u32 ring_type)
>>   {
>> @@ -5794,6 +6023,9 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>   
>>   	peer = &remote->peer[remote_accel_id];
>>   	ring = &peer->shootdown;
>> +
>> +	guard(mutex)(&peer->lock);
>> +
>>   	if (!ring->ready) {
>>   		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
>>   		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>> @@ -5802,11 +6034,11 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>   			return r;
>>   	}
>>   
>> -	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
>> -				       amdgpu_ualink_emit_shootdown,
>> -				       flush_type, upper_32_bits(addr),
>> -				       lower_32_bits(addr), size_in_pages);
>> -	return r;
>> +	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
>> +					  ring->wb_cpu,
>> +					  amdgpu_ualink_emit_shootdown,
>> +					  flush_type, upper_32_bits(addr),
>> +					  lower_32_bits(addr), size_in_pages);
>>   }
>>   
>>   /**
>> @@ -5835,6 +6067,9 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>   
>>   	peer = &remote->peer[remote_accel_id];
>>   	ring = &peer->interrupt;
>> +
>> +	guard(mutex)(&peer->lock);
>> +
>>   	if (!ring->ready) {
>>   		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
>>   		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>> @@ -5843,10 +6078,10 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>   			return r;
>>   	}
>>   
>> -	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
>> -				       amdgpu_ualink_emit_interrupt,
>> -				       dw0, dw1, dw2, dw3);
>> -	return r;
>> +	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
>> +					  ring->wb_cpu,
>> +					  amdgpu_ualink_emit_interrupt,
>> +					  dw0, dw1, dw2, dw3);
>>   }
>>   
>>   /**

--------------cKPkq5At1nDVgOEmePP26bTi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-09-16 21:33, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b6349b6d-0357-4850-8957-6d2d17649a05@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 9/16/2026 11:25 AM, Philip Yang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20260916152528.3918848-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">When one side of UALink nodes reboots, its ring wptr resets to 0 while
the peer keeps a stale value. Read the remote wptr and adopt it as the
local wptr and rptr to resync, before the first message is sent. Either
side can notice first, so do this both when setting up the connection
and when receiving the HELLO from the peer.

On the sdma path, read the wptr in a fence callback because the IB buffer
holding the result is recycled once the fence signals, so reading it
after dma_fence_wait_timeout() is too late. The lsdma path copies
synchronously, so it reads the wptr directly.

Take peer-&gt;lock in the callers (amdgpu_ualink_remote_interrupt and
amdgpu_ualink_remote_shootdown) instead of in amdgpu_ualink_send_command,
so the ring-&gt;ready check and the send are atomic against a concurrent
ring reset.

Move the rptr refresh and ring-full check out of amdgpu_ualink_send_command()
into amdgpu_ualink_ring_check_space(), so it runs under the caller's
peer-&gt;lock before the job is allocated.

On a failed NPA-REQ send, reset the connection like the NPA-RSP timeout path
already does, so the next attempt resyncs the ring wptr.

On connection reset, amdgpu_ualink_reset_peer_rings() only clears
ring-&gt;ready, so the writeback address is re-registered on the next send.

v10:
  - Fix the resync missed on the receiving side: after a reboot the peer
    may send HELLO before we set up the connection, so resync the ring
    wptr in amdgpu_ualink_process_hello_msg() too.

v9:
  - Fix the unnecessary connection reset after an app exits: the peer is
    idle here but still busy handling NPA revokes on the remote, so the
    HELLO reset a healthy connection. Only send it if the wptr changed.
  - Resync both rings together under peer-&gt;lock, read both remote wptr
    before updating either so a failed read changes nothing.

v8:
  - Fix regression with concurrent import ioctls: do the idle check and
    ring reset in amdgpu_ualink_setup_connection() under conn_state-&gt;lock,
    and return -EAGAIN for IN_PROGRESS/PENDING first.
  - Reset the peer rings only, the imp/exp xarray cleanup is not needed to
    resync wptr.

v7:
  - With v6 reboot one node of vPOD test passed on minirack.
  - Use the per-remote imported and exported handle lists for the idle
    check instead of walking the xarrays.
  - Rename amdgpu_ualink_resync_peer_rings() to
    amdgpu_ualink_reset_peer_rings(), it only clears ring-&gt;ready.

v6:
  - Check idleness per remote accelerator instead of globally, and reset
    the stale connection at the import ioctl so the peer re-runs the
    HELLO handshake after a reboot.

v5:
  - Resync the ring pointers at the import ioctl when the connection is
    completely idle (no exported or imported BOs), so the first command
    from a new application after a remote reboot/reset succeeds.
  - Put the sdma wptr read fence callback on the stack instead of
    allocating it; it is cancelled on timeout so it never outlives the
    call.

v4:
  - Cancel the sdma fence callback on the wait timeout/failure path so it
    cannot write into the caller's stack after the function returns, and
    free the callback state in one place.

v3:
  - Resync both rings at connection setup instead of on the send path.
  - Set the writeback rptr too, the stale value disagrees with the
    resynced wptr until the remote FW writes it back.

v2:
  - Match the FW change: resync wptr only on the first send or after a
    timeout, instead of checking the remote periodically.

Suggested-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com" moz-do-not-send="true">&lt;felix.kuehling@amd.com&gt;</a>
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com" moz-do-not-send="true">&lt;felix.kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 339 +++++++++++++++++----
 1 file changed, 287 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index b2c2650b0149..c0327f6854a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -56,6 +56,10 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 					  u32 size_in_pages, u32 flush_type);
 static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
 static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev);
+static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
+					   u32 remote_accel_id);
+static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
+					  u32 remote_accel_id);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) &amp; ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -2282,11 +2286,23 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
 						generation_count);
 	}
 
+	/* Peer may have rebooted. */
+	r = amdgpu_ualink_ring_resync_ptrs(adev, sender_acc_id);
+	if (r &lt; 0) {
+		dev_err(adev-&gt;dev,
+			&quot;HELLO: resync sender AccId %u ptrs failed %d\n&quot;,
+			sender_acc_id, r);
+		goto out_set_state;
+	}
+	if (r)
+		amdgpu_ualink_reset_peer_rings(adev, sender_acc_id);
+
 	r = amdgpu_ualink_send_hello_ack_msg(adev, sender_acc_id);
 	if (r)
 		dev_err(adev-&gt;dev, &quot;HELLO-ACK: send failed to remote AccId:%u\n&quot;,
 			sender_acc_id);
 
+out_set_state:
 	mutex_lock(&amp;conn_state-&gt;lock);
 	if (r) {
 		conn_state-&gt;state = AMDGPU_UALINK_CONN_NOT_READY;
@@ -2303,6 +2319,14 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
 	mutex_unlock(&amp;conn_state-&gt;lock);
 }
 
+/* True if nothing is exported to, or imported from, this remote accelerator. */
+static bool amdgpu_ualink_peer_idle(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	/* Unlocked: a racing import at worst costs one redundant ring resync. */
+	return list_empty(&amp;adev-&gt;ualink.imp_handles_list[remote_accel_id]) &amp;&amp;
+	       list_empty(&amp;adev-&gt;ualink.exp_handles_list[remote_accel_id]);
+}
+
 static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
 					  u32 remote_acc_id)
 {
@@ -2324,16 +2348,31 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
 	 * already done by another thread.
 	 */
 	mutex_lock(&amp;conn_state-&gt;lock);
-	if (conn_state-&gt;state == AMDGPU_UALINK_CONN_ESTABLISHED) {
-		r = 0;
-		goto out;
-	} else if (conn_state-&gt;state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
-		   conn_state-&gt;state == AMDGPU_UALINK_CONN_PENDING) {
+	if (conn_state-&gt;state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
+	    conn_state-&gt;state == AMDGPU_UALINK_CONN_PENDING) {
 		r = -EAGAIN;
 		goto out;
 	}
 
+	if (conn_state-&gt;state == AMDGPU_UALINK_CONN_ESTABLISHED &amp;&amp;
+	    !amdgpu_ualink_peer_idle(adev, remote_acc_id)) {
+		r = 0;
+		goto out;
+	}
+
+	/* Peer is idle or not connected, it may have rebooted. Skip the
+	 * handshake if the rings are still in sync, it would reset the remote.
+	 */
+	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_acc_id);
+	if (r &lt; 0)
+		goto out;
+	if (!r &amp;&amp; conn_state-&gt;state == AMDGPU_UALINK_CONN_ESTABLISHED)
+		goto out;
+
+	amdgpu_ualink_reset_peer_rings(adev, remote_acc_id);
+
 	conn_state-&gt;state = AMDGPU_UALINK_CONN_IN_PROGRESS;
+
 	mutex_unlock(&amp;conn_state-&gt;lock);
 
 	/* Send HELLO message */
@@ -3670,7 +3709,7 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 		dev_warn(adev-&gt;dev,
 			&quot;IMPORT: NPA-REQ send failed to remote AccId:%u\n&quot;,
 			remote_acc_id);
-		return r;
+		goto reset_conn;
 	}
 
 	/* Wait for the NPA_RSP to come back */
@@ -5511,6 +5550,34 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
 typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32 wb, u32 dw0,
 				   u32 dw1, u32 dw2, u32 dw3);
 
+/*
+ * Refresh rptr from the writeback and check the ring has room for one more
+ * command. The caller must hold the peer lock.
+ *
+ * Return 0 on success or a negative error code.
+ */
+static int amdgpu_ualink_ring_check_space(struct amdgpu_device *adev,
+					  u32 remote_accel_id,
+					  struct amdgpu_ualink_ring *ring,
+					  struct amdgpu_ualink_wb *wb_cpu)
+{
+	ring-&gt;rptr = READ_ONCE(wb_cpu-&gt;rptr);
+
+	if (WARN_ON_ONCE(ring-&gt;rptr &gt; ring-&gt;wptr)) {
+		dev_err(adev-&gt;dev, &quot;accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n&quot;,
+			remote_accel_id, ring-&gt;wptr, ring-&gt;rptr);
+		return -EFAULT;
+	}
+
+	if ((ring-&gt;wptr + 1 - ring-&gt;rptr) &gt;= ring-&gt;rb_size) {
+		dev_err(adev-&gt;dev, &quot;accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n&quot;,
+			remote_accel_id, ring-&gt;wptr, ring-&gt;rptr);
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
 static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 				      u32 remote_accel_id,
 				      struct amdgpu_ualink_ring *ring,
@@ -5536,6 +5603,10 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 
 	peer = &amp;remote-&gt;peer[remote_accel_id];
 
+	r = amdgpu_ualink_ring_check_space(adev, remote_accel_id, ring, wb_cpu);
+	if (r)
+		goto out;
+
 	/*
 	 * 3 sdma copy commands: write data to ring buffer, update wptr, ring doorbell
 	 *
@@ -5552,25 +5623,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
 				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &amp;job);
 	if (r)
-		return r;
-
-	mutex_lock(&amp;peer-&gt;lock);
-
-	ring-&gt;rptr = READ_ONCE(wb_cpu-&gt;rptr);
-
-	if (WARN_ON_ONCE(ring-&gt;rptr &gt; ring-&gt;wptr)) {
-		dev_err(adev-&gt;dev, &quot;accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n&quot;,
-			remote_accel_id, ring-&gt;wptr, ring-&gt;rptr);
-		r = -EFAULT;
-		goto unlock_free;
-	}
-
-	if ((ring-&gt;wptr + 1 - ring-&gt;rptr) &gt;= ring-&gt;rb_size) {
-		dev_err(adev-&gt;dev, &quot;accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n&quot;,
-			remote_accel_id, ring-&gt;wptr, ring-&gt;rptr);
-		r = -ENOSPC;
-		goto unlock_free;
-	}
+		goto out;
 
 	ib = &amp;job-&gt;ibs[0];
 	src = ib-&gt;gpu_addr + ndw_copy_cmd * 4;
@@ -5628,12 +5681,11 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 			dev_dbg(adev-&gt;dev,
 				&quot;remote %u lsdma copy failed (r %d), skip completion wait\n&quot;,
 				remote_accel_id, r);
-			mutex_unlock(&amp;peer-&gt;lock);
 			return r;
 		}
 
 		goto out_wait_complete;
-        }
+	}
 
 	sdma_ring = &amp;adev-&gt;sdma.instance[0].ring;
 
@@ -5664,12 +5716,9 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 	if (r &lt;= 0) {
 		dev_dbg(adev-&gt;dev, &quot;remote %u sdma fence wait return r %d\n&quot;,
 			remote_accel_id, r);
-
 		if (r == 0)
 			r = -ETIME;
-
-		mutex_unlock(&amp;peer-&gt;lock);
-		return r;
+		goto out;
 	}
 
 out_wait_complete:
@@ -5678,21 +5727,15 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 	 */
 	r = amdgpu_ualink_remote_wait_timeout(adev, remote_accel_id, wb_cpu, seq);
 
-	/* increase local copy ring wptr, only if FW not timeout */
-	if (r != -ETIME)
-		ring-&gt;wptr++;
-
 	/*
-	 * Release ring lock after the remote FW handle command completes to
-	 * prevent race conditions.
+	 * Advance wptr unless the remote timed out, even if the FW returned an
+	 * error status. On timeout the caller resets the connection, which
+	 * resyncs wptr from the remote in amdgpu_ualink_setup_connection.
 	 */
-	mutex_unlock(&amp;peer-&gt;lock);
-	return r;
-
+	if (r != -ETIME)
+		ring-&gt;wptr++;
 
-unlock_free:
-	mutex_unlock(&amp;peer-&gt;lock);
-	amdgpu_job_free(job);
+out:
 	dev_dbg(adev-&gt;dev, &quot;ret r = %d\n&quot;, r);
 	return r;
 }
@@ -5732,6 +5775,192 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 		remote_accel_id, npa + offset);
 }
 
+struct amdgpu_ualink_wptr_fence_cb {
+	struct dma_fence_cb base;
+	u64 *wptr_cpu;
+	u64 result;
+};
+
+static void amdgpu_ualink_read_wptr_fence_cb(struct dma_fence *fence,
+					     struct dma_fence_cb *cb)
+{
+	struct amdgpu_ualink_wptr_fence_cb *wptr_cb;
+
+	wptr_cb = container_of(cb, typeof(*wptr_cb), base);
+	wptr_cb-&gt;result = *wptr_cb-&gt;wptr_cpu;
+}
+
+static int amdgpu_ualink_read_remote_wptr(struct amdgpu_device *adev,
+					  u32 remote_accel_id,
+					  struct amdgpu_ualink_ring *ring,
+					  u64 *wptr)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_peer *peer = &amp;remote-&gt;peer[remote_accel_id];
+	struct amdgpu_ualink_wptr_fence_cb wptr_cb = { };
+	struct amdgpu_ring *sdma_ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	u32 ndw, ndw_copy_cmd;
+	u64 wptr_gpu, *wptr_cpu;
+	int r = 0;
+</pre>
      </blockquote>
      Minor nitpick here.
      <p>Maybe we should check here that the accelerator state is still
        active similar to what we are doing in</p>
      <p>amdgpu_ualink_send_command().onnection is estiblished,&nbsp;&nbsp;</p>
    </blockquote>
    good point, will add below check, vpod could be deactivated from
    side-band when app is running.<br>
    <br>
    &nbsp; &nbsp; /* Refuse sends unless active */<br>
    &nbsp; &nbsp; if (adev-&gt;ualink.info-&gt;accel_state !=
    AMDGPU_UALINK_ACCEL_STATE_ACTIVE)<br>
    &nbsp; &nbsp; &nbsp; &nbsp; return -ESHUTDOWN;<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:b6349b6d-0357-4850-8957-6d2d17649a05@amd.com">
      <p>Other than that, this patch is:</p>
      <p>Reviewed-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com" moz-do-not-send="true">&lt;mukul.joshi@amd.com&gt;</a></p>
      <blockquote type="cite" cite="mid:20260916152528.3918848-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">+	*wptr = 0;
+
+	/* 1 sdma copy command to read wptr */
+	ndw_copy_cmd = ALIGN(adev-&gt;mman.buffer_funcs-&gt;copy_num_dw, 8);
+
+	/* wptr 2 dwords */
+	ndw = ndw_copy_cmd + 2;
+	r = amdgpu_job_alloc_with_ib(adev, &amp;peer-&gt;entity, AMDGPU_FENCE_OWNER_VM,
+				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &amp;job);
+	if (r)
+		return r;
+
+	ib = &amp;job-&gt;ibs[0];
+	wptr_gpu = ib-&gt;gpu_addr + ndw_copy_cmd * 4;
+	wptr_cpu = (u64 *)(ib-&gt;ptr + ndw_copy_cmd);
+
+	dev_dbg(adev-&gt;dev, &quot;read wptr from remote %u npa gart wptr 0x%llx use %s\n&quot;,
+		remote_accel_id, ring-&gt;wptr_npa_gart,
+		remote-&gt;use_lsdma ? &quot;lsdma&quot; : &quot;sdma&quot;);
+
+	if (remote-&gt;use_lsdma) {
+		r = amdgpu_lsdma_copy_mem(adev, ring-&gt;wptr_npa_gart, wptr_gpu, 8);
+		if (!r)
+			*wptr = *wptr_cpu;
+		amdgpu_job_free(job);
+		goto out;
+	}
+
+	wptr_cb.wptr_cpu = wptr_cpu;
+
+	amdgpu_emit_copy_buffer(adev, ib, ring-&gt;wptr_npa_gart, wptr_gpu, 8, 0);
+
+	sdma_ring = &amp;adev-&gt;sdma.instance[0].ring;
+	amdgpu_ring_pad_ib(sdma_ring, ib);
+	WARN_ON(ib-&gt;length_dw &gt; ndw_copy_cmd);
+
+	fence = amdgpu_job_submit(job);
+
+	r = dma_fence_add_callback(fence, &amp;wptr_cb.base,
+				   amdgpu_ualink_read_wptr_fence_cb);
+	if (r == -ENOENT) {
+		/* Fence already signaled; the callback won't run, do it inline. */
+		amdgpu_ualink_read_wptr_fence_cb(fence, &amp;wptr_cb.base);
+		r = 0;
+		goto out_put_fence;
+	} else if (r) {
+		/* -EINVAL: NULL fence or func, not expected here. */
+		goto out_put_fence;
+	}
+
+	r = dma_fence_wait_timeout(fence, false, AMDGPU_FENCE_JIFFIES_TIMEOUT);
+	if (r &gt; 0) {
+		r = 0;	/* read wptr successfully */
+		goto out_put_fence;
+	}
+
+	dev_dbg(adev-&gt;dev, &quot;remote %u sdma fence wait return r %d\n&quot;,
+		remote_accel_id, r);
+
+	if (r == 0)
+		r = -ETIME;
+
+	/*
+	 * Timed out: the callback is still armed and wptr_cb is on our stack.
+	 * Cancel it so it can't fire after we return and write into the freed
+	 * stack frame.
+	 */
+	dma_fence_remove_callback(fence, &amp;wptr_cb.base);
+
+out_put_fence:
+	if (!r)
+		*wptr = wptr_cb.result;
+	dma_fence_put(fence);
+
+out:
+	dev_dbg(adev-&gt;dev, &quot;remote %u wptr 0x%llx return %d\n&quot;,
+		remote_accel_id, *wptr, r);
+	return r;
+}
+
+/**
+ * amdgpu_ualink_ring_resync_ptrs - sync local ring pointers from remote
+ * @adev: amdgpu device pointer
+ * @remote_accel_id: remote accelerator ID
+ *
+ * After a reboot on either side the two ends disagree on wptr. Read the remote
+ * wptr of both peer rings and adopt it as the local wptr and rptr.
+ *
+ * Return 0 if both rings already match, 1 if they were resynced, or a negative
+ * error code if a remote read failed, leaving the rings untouched.
+ */
+static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
+					  u32 remote_accel_id)
+{
+	struct amdgpu_ualink_peer *peer = &amp;to_remote(adev)-&gt;peer[remote_accel_id];
+	struct amdgpu_ualink_wb *int_wb, *tlb_wb;
+	u64 int_wptr, tlb_wptr;
+	int r;
+
+	/* ring-&gt;wptr and ring-&gt;rptr are owned by the send path. */
+	guard(mutex)(&amp;peer-&gt;lock);
+
+	/* Read both before updating either, so a failure changes nothing. */
+	r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
+					   &amp;peer-&gt;interrupt, &amp;int_wptr);
+	if (!r)
+		r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
+						   &amp;peer-&gt;shootdown, &amp;tlb_wptr);
+	if (r) {
+		dev_dbg(adev-&gt;dev, &quot;accel_id %u read remote %u wptr failed %d\n&quot;,
+			ualink_accel_id(adev), remote_accel_id, r);
+		return r;
+	}
+
+	if (peer-&gt;interrupt.wptr == int_wptr &amp;&amp; peer-&gt;shootdown.wptr == tlb_wptr) {
+		dev_dbg(adev-&gt;dev, &quot;accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n&quot;,
+			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
+		return 0;
+	}
+
+	dev_dbg(adev-&gt;dev,
+		&quot;accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n&quot;,
+		ualink_accel_id(adev), peer-&gt;interrupt.wptr, peer-&gt;shootdown.wptr,
+		remote_accel_id, int_wptr, tlb_wptr);
+
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &amp;int_wb, NULL,
+				  RB_TYPE_REMOTE_INTERRUPT);
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &amp;tlb_wb, NULL,
+				  RB_TYPE_TLB_INV);
+
+	peer-&gt;interrupt.wptr = int_wptr;
+	peer-&gt;interrupt.rptr = int_wptr;
+	peer-&gt;shootdown.wptr = tlb_wptr;
+	peer-&gt;shootdown.rptr = tlb_wptr;
+
+	/* Drop the stale writeback rptr, it disagrees with the resynced wptr. */
+	WRITE_ONCE(int_wb-&gt;rptr, int_wptr);
+	WRITE_ONCE(tlb_wb-&gt;rptr, tlb_wptr);
+	return 1;
+}
+
+static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
+					   u32 remote_accel_id)
+{
+	struct amdgpu_ualink_peer *peer = &amp;to_remote(adev)-&gt;peer[remote_accel_id];
+
+	dev_dbg(adev-&gt;dev, &quot;remote accel_id %u\n&quot;, remote_accel_id);
+
+	guard(mutex)(&amp;peer-&gt;lock);
+
+	peer-&gt;interrupt.ready = false;
+	peer-&gt;shootdown.ready = false;
+}
+
 static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 					   u32 remote_accel_id, u32 ring_type)
 {
@@ -5794,6 +6023,9 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 
 	peer = &amp;remote-&gt;peer[remote_accel_id];
 	ring = &amp;peer-&gt;shootdown;
+
+	guard(mutex)(&amp;peer-&gt;lock);
+
 	if (!ring-&gt;ready) {
 		dev_dbg(adev-&gt;dev, &quot;accel_id %u ring not ready\n&quot;, remote_accel_id);
 		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
@@ -5802,11 +6034,11 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 			return r;
 	}
 
-	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring-&gt;wb_cpu,
-				       amdgpu_ualink_emit_shootdown,
-				       flush_type, upper_32_bits(addr),
-				       lower_32_bits(addr), size_in_pages);
-	return r;
+	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
+					  ring-&gt;wb_cpu,
+					  amdgpu_ualink_emit_shootdown,
+					  flush_type, upper_32_bits(addr),
+					  lower_32_bits(addr), size_in_pages);
 }
 
 /**
@@ -5835,6 +6067,9 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 
 	peer = &amp;remote-&gt;peer[remote_accel_id];
 	ring = &amp;peer-&gt;interrupt;
+
+	guard(mutex)(&amp;peer-&gt;lock);
+
 	if (!ring-&gt;ready) {
 		dev_dbg(adev-&gt;dev, &quot;accel_id %u ring not ready\n&quot;, remote_accel_id);
 		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
@@ -5843,10 +6078,10 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 			return r;
 	}
 
-	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring-&gt;wb_cpu,
-				       amdgpu_ualink_emit_interrupt,
-				       dw0, dw1, dw2, dw3);
-	return r;
+	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
+					  ring-&gt;wb_cpu,
+					  amdgpu_ualink_emit_interrupt,
+					  dw0, dw1, dw2, dw3);
 }
 
 /**
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------cKPkq5At1nDVgOEmePP26bTi--
