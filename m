Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B8BC982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 18:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05EAB10E2BB;
	Thu, 17 Sep 2026 18:37:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DANZKyJm";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F6110E2BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 18:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVpoQ/vW2nbUEwsuBOePgGK9OOJFeeBpmoNVv+ch+MjraMZC/v8QGH6QedOafiwnM+sIdlWWMm92SuZ8M1WJduKF4pBK60qgLu2W0fg/x+2Dq+RWcftxpj6e25mpSp3LVMvmrNMppieswoYD30S3GTpokd0pNHf2b6sStouMrBJIm7hu9afS6R8Te+zPlJGlLBJl9/uwqzO73dVsii/ANf1UoiPulVz3URdSTpEZb5ZFXFR4OgK440a3nkkKZ/IxCAxZVunIswlpsggRQ/RZJzQOJ6azqse9eeQc2cibFL0Q0hmgPtjSByoAFQZXdcCRHA5pKWHt0htgywRaUEgzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qyPFl3vooSNFLBwuaDgMOiB7TFVP9lTAMmialMbSkU=;
 b=VNOMDVC+DjEjHxCj1+o9o9unmngOBMFgJNkgyL3fmp6+JJOHu+M/AS4aA6brAau+l1zC8940CWSLWlkS6o2G7lMTx9BNW7d8HJkg+jDK4yNaV6TSTJtcpoaYrPpOadzzFXcAPBsKmMbXFXQQJNzwrc5+kTSOKa0n4ZTWJ/PY6aljOv35jb6wWPwjyj7lkYAt+OBWgEnlitO7/3NuKF7kcA7YottAQhm0xa1rLkoVGj0a+1qa+mENfQk1dzGehv994NmVgmSbSHpZGRXcPknGME1jXF9DH6vFLcEY/PIKjGi7NWwQNfCnOjaE2WPjdQJeksO4Qe+QGBwK9QP0QHSGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qyPFl3vooSNFLBwuaDgMOiB7TFVP9lTAMmialMbSkU=;
 b=DANZKyJmS/pbDHmiuj3ADvzRpdOCJfxtWUlbQB8aOgjMaPfcoAEBw1BrhzoG0CG9LsO9iqmLQwz2783FOjQidLm9TTGppt+sM5c3zVvA01ayrJBX4k2Ecx1qOSlaJUAAP3WceXrdiyALmpO6PGmSEb977MkSnMYmX2GfR8VUuzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:37:04 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:37:04 +0000
Content-Type: multipart/alternative;
 boundary="------------dfkhxMj6fW1Jai0ShjNxbOOQ"
Message-ID: <0bbd044b-f2c7-4da3-8939-9a1a6d60123b@amd.com>
Date: Thu, 17 Sep 2026 14:37:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] drm/amdgpu: Resync UALink ring wptr after reboot
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <yangp@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com
References: <20260916152528.3918848-1-Philip.Yang@amd.com>
 <b6349b6d-0357-4850-8957-6d2d17649a05@amd.com>
 <ca5f45bb-2bbd-464b-94fb-336456e9966c@amd.com>
 <e751339b-cfff-43bc-a19a-963408134677@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <e751339b-cfff-43bc-a19a-963408134677@amd.com>
X-ClientProxiedBy: YT4PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::20) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: f522029a-6873-4f2f-5143-08df14eaab95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|6133799003|4143699003|5023799004|3023799007|11063799006|22082099003|18002099003|10067099003|8096899003;
X-Microsoft-Antispam-Message-Info: ses+s1QZKppQicAZiHd5LuwMHtCr1jWDfsnRYBx9BBKc5e8q3NaDM9owwWtk11MqHOvivH934EiAaJomPntymjW7LQ8BtLKcpfoTrP7l7E+TfszOlaKXhrLiVlUsdpTStvrEnDMQV7lIaN3pkYV2GhrCw9Si5Ryzkdvpn84MPjn3zATLjVm36x95Qwg0c2GE/u64/XRRo/mpNm2eXlYy+bAciMz0DwejvRRp+TCvRIuNO3/v9Zh9dhrJKIsEKMYn1h4JY7FLDj/ZHRcM97unDa7drGV44VC/Un/IAz15WMudEN1WywNczfl+feLkYrWlEd3jNaBuTzo7AJkaUVBylNJYZ+gK2OxA2UthOTXDrnCHfxBwZKDswzHcSKEe9USeiUjRMbxEL01xnuPOLLGUd8eonXedDpHxFIXEvXP653dbIpIEhQgXgrzFcC4Eji64CjxdyCR/3eE+YEDR4rqKvnjkb8YfwvMbpKS7MNN6zNIJiXtMyEthJFQwMVWa/PcQtOUHwqY81T3igTDIKyVT6kuAzLN6wWhgMhiSRraJF8SdSJynNa/vx7s1lG5D/tIPXnztraqzWaVtiytFd1sYPikNB8OsIIyglxU2CpVFgl8LKBqs7Krroq0X9evSRSj6TGqqyuGEEkpQuG+2fqf5/86bAI/+B5jW0eJHAFelAHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(6133799003)(4143699003)(5023799004)(3023799007)(11063799006)(22082099003)(18002099003)(10067099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGFQYVRlTmNqemF0Z2hOcUF0blVaejNLNmRyeGsvYnlOZzBGUkZ1cEE2Mmpn?=
 =?utf-8?B?MUhJWC91RDhoSHNYMGQyaVpXVUp1bEhJTTNsbXlJaXNQTWNIWHhZdTFmWjht?=
 =?utf-8?B?SHp1VFgwTnNkMXR1M3JMb3NqdHQ2Zk9VdWg4K2hMN1JTVWJ4QkN0NmZkT25O?=
 =?utf-8?B?Z1Q4WGxOQ0tVbXhzajV5ZW0yaEoveUZVN2xjTGhmTkRXTHdoelJuVHJVR2Qr?=
 =?utf-8?B?Nzd3SjNrOFlna2l4TUFuR0VzWnhXaEg3U29pSHlzeEFRQkFvYlI1QkxrdjVs?=
 =?utf-8?B?Vmdwb0htWlFNOWEwQnVGeVZPaXM5WWxOWkF0NmxMZ3ZZUWRsK2lDS1ZnQ20v?=
 =?utf-8?B?dEt1VVJla0RHWnRQa1BBeW92TTFONmNxeWRwc0d4ZFZyMXdROUxTR3pKS2gv?=
 =?utf-8?B?QTlRUzBBTStOL0J2Y1YvdE5ITnkwTkdYanUxL3p5OW5tWXdDTWVYUFJ2dDNk?=
 =?utf-8?B?WXdXTnNLNjNCdk5XdHVHK0RBeitqNE5zL0IwUWJWeG5jMDM4SGZ1ZVppUHA5?=
 =?utf-8?B?VEV2R1RCVHNzVTVEYnNsdjdpUzQzTHVCUUI3dmd4dll5MW9Sbm1oOFFVTjRZ?=
 =?utf-8?B?N1hSN3JKVVowUUZKck9EblRicWhyWXV5eHZMUlBlMGZMMVNhTHNUcDQwK3pu?=
 =?utf-8?B?dEJocGY5Q21SMDFiUkU3azhhRWJvQ0Q1NnRPOHN4ZkxrQ0tWOGp5T3VOVTlz?=
 =?utf-8?B?UEZQT0ZSMTF5RzM5aWY5Z3BFdGwwei9XWVpTV3hHd045d2JwdWU3Vi96bUdu?=
 =?utf-8?B?REt1NTBWcjNaNmRlVWZNYllrSnI5QVRKZVNLTjlSZ3oyMzIrOUFuKzdxUzZG?=
 =?utf-8?B?UEtYcUUyU2JDdE5SQTdTRnZVM2dqNEQ0UUx0V2FSc25mK0pRWDB0dW1uT1k1?=
 =?utf-8?B?aitMUHFZTjg5c1RhMG83dDV5TUQ2ZVZvdkVuamQwckYrSGRqcEdIQk1iNVhk?=
 =?utf-8?B?S1pUQm5kN1hEa3cxbGF4Y3lMU0t2QjkzUXRhSU5hRk5Dd1M3SWZ3d1liNFNJ?=
 =?utf-8?B?bUJSUWlKbkJRT0szbXpROUc1VmRKcGFGRk5TOXc0MHQ3QzY3UkdCREJFazZt?=
 =?utf-8?B?ZkFVdDA0RGNXZWYrdmpZbmZwa3BDY3daRUJCL2prQjdvSzZhNU80bGN0a1JH?=
 =?utf-8?B?eW03R0hoT21jNnF3NGJIcTI4QWhBVFNYTW83Q1BuNTZWcE5hYnFVMmI1dWZR?=
 =?utf-8?B?azJOK1BZZWx0K3RwUXpVa3AyNnFkM044NkJWeVY5R0F5UDJLeFo0eE5IcmIx?=
 =?utf-8?B?TWdBOG44cjdudEh6eDdVOVpNWk4waTdBWWxwb2FQS0MvWFpzWHo3NG9IVFMz?=
 =?utf-8?B?cGxSSXVoVVI4ZEx3bXZGWHZPQXkrUmxSb2VLb013REhCMEhLL1VZM1lJQklt?=
 =?utf-8?B?SG9nMmpoWERsUGJrREF1U1MvaVZCdlZRZU90amRua0FSaVJLcm1sU1NHRGk0?=
 =?utf-8?B?azVoRm5zUlphdTRCWEtISXhDYUdxeGhBL0xOSTNzN2xmWVJGSlNBZWVXcms4?=
 =?utf-8?B?ZklNa0hSUWlGdlpqUmhtWWR3NEY0bEFYbHNHc0ZscXlIVlh4NVRHSXhjeWlG?=
 =?utf-8?B?dTI1d2ZlbFo2WER1ZE5qaEpwM2dueldnckliY0RHWkVPS0RqSUpqQjBZdkN0?=
 =?utf-8?B?VFVwcmF6M2xWWjBKd1AyTitwenY1bGUrS2ROa2R4Nzl4cWh5WWhDcllLWnd5?=
 =?utf-8?B?LzJrc1czV2VaTm9uU203eEhWTWhUazJYZzJCUkdQMWxhVk0rNzIwWmhrY1oy?=
 =?utf-8?B?Q0dIUmt2UzBYV1RLUFN4b2ZXbDZzcko2QzFFeTkxR3NrenR2VXlyaVJ3WTBz?=
 =?utf-8?B?cTVKSThGcUtPdUhLZjhZZlJPc1piYjZydWJSZmtYKzRGNi8xNUdzakFXekdC?=
 =?utf-8?B?KzNNVnNjcFJUc09lU05aQTl2bWdXUGQya1Z4RVNROHNVbVdMeGpGWHZaZ1kr?=
 =?utf-8?B?WGl5cFFXbk5VN2JwTzMyeWFlMlJKRGx2SG9mbkVvUmZISUhTMGw4V0wxUFNr?=
 =?utf-8?B?blFqRFUvQUp1U0JFRi9WWmxzMldLMCs5YUw5MDJWT2JEamNEa0taT0lKeGdV?=
 =?utf-8?B?ZHBkcEhvNWEyZFZmVjdkY0JNMVNWa1poeUVYQitEcXdHZDF3T2p3Q2x3UzMy?=
 =?utf-8?B?bm1GYnMrOVI4VGRrMnBVejVWV1c3cmRXSzg0RlZtU2NYV0hIT0VjaWI1TFBJ?=
 =?utf-8?B?TVpNdEJJbDVSamZBZUVISGFBSWFyQithdE9aNWZKZWJhblVzTTE5YUFCQlBL?=
 =?utf-8?B?Q0NRMUFxRXR2ZjdaaDNzV044emtycFRjKzZZTG84U2VCaDlueEpmbTFjOUFS?=
 =?utf-8?B?UXJLNjdOV1Z2T25NcmlBWFNOM1BYbnpXUE11dHEzUkxraERqeUdHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f522029a-6873-4f2f-5143-08df14eaab95
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:37:04.6287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju8zj+dNHmyC4U61upNLlA4P2NT2nh1sj9yq4wt2DlKDYIr1FzAq+YKxRkCAH3I/37gjvuXNTtaegUO9xwF98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
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

--------------dfkhxMj6fW1Jai0ShjNxbOOQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/17/2026 1:59 PM, Felix Kuehling wrote:
> On 2026-09-17 10:07, Philip Yang wrote:
>>
>>
>> On 2026-09-16 21:33, Mukul Joshi wrote:
>>>
>>>
>>> On 9/16/2026 11:25 AM, Philip Yang wrote:
>>>> When one side of UALink nodes reboots, its ring wptr resets to 0 while
>>>> the peer keeps a stale value. Read the remote wptr and adopt it as the
>>>> local wptr and rptr to resync, before the first message is sent. 
>>>> Either
>>>> side can notice first, so do this both when setting up the connection
>>>> and when receiving the HELLO from the peer.
>>>>
>>>> On the sdma path, read the wptr in a fence callback because the IB 
>>>> buffer
>>>> holding the result is recycled once the fence signals, so reading it
>>>> after dma_fence_wait_timeout() is too late. The lsdma path copies
>>>> synchronously, so it reads the wptr directly.
>>>>
>>>> Take peer->lock in the callers (amdgpu_ualink_remote_interrupt and
>>>> amdgpu_ualink_remote_shootdown) instead of in 
>>>> amdgpu_ualink_send_command,
>>>> so the ring->ready check and the send are atomic against a concurrent
>>>> ring reset.
>>>>
>>>> Move the rptr refresh and ring-full check out of 
>>>> amdgpu_ualink_send_command()
>>>> into amdgpu_ualink_ring_check_space(), so it runs under the caller's
>>>> peer->lock before the job is allocated.
>>>>
>>>> On a failed NPA-REQ send, reset the connection like the NPA-RSP 
>>>> timeout path
>>>> already does, so the next attempt resyncs the ring wptr.
>>>>
>>>> On connection reset, amdgpu_ualink_reset_peer_rings() only clears
>>>> ring->ready, so the writeback address is re-registered on the next 
>>>> send.
>>>>
>>>> v10:
>>>>    - Fix the resync missed on the receiving side: after a reboot 
>>>> the peer
>>>>      may send HELLO before we set up the connection, so resync the 
>>>> ring
>>>>      wptr in amdgpu_ualink_process_hello_msg() too.
>>>>
>>>> v9:
>>>>    - Fix the unnecessary connection reset after an app exits: the 
>>>> peer is
>>>>      idle here but still busy handling NPA revokes on the remote, 
>>>> so the
>>>>      HELLO reset a healthy connection. Only send it if the wptr 
>>>> changed.
>>>>    - Resync both rings together under peer->lock, read both remote 
>>>> wptr
>>>>      before updating either so a failed read changes nothing.
>>>>
>>>> v8:
>>>>    - Fix regression with concurrent import ioctls: do the idle 
>>>> check and
>>>>      ring reset in amdgpu_ualink_setup_connection() under 
>>>> conn_state->lock,
>>>>      and return -EAGAIN for IN_PROGRESS/PENDING first.
>>>>    - Reset the peer rings only, the imp/exp xarray cleanup is not 
>>>> needed to
>>>>      resync wptr.
>>>>
>>>> v7:
>>>>    - With v6 reboot one node of vPOD test passed on minirack.
>>>>    - Use the per-remote imported and exported handle lists for the 
>>>> idle
>>>>      check instead of walking the xarrays.
>>>>    - Rename amdgpu_ualink_resync_peer_rings() to
>>>>      amdgpu_ualink_reset_peer_rings(), it only clears ring->ready.
>>>>
>>>> v6:
>>>>    - Check idleness per remote accelerator instead of globally, and 
>>>> reset
>>>>      the stale connection at the import ioctl so the peer re-runs the
>>>>      HELLO handshake after a reboot.
>>>>
>>>> v5:
>>>>    - Resync the ring pointers at the import ioctl when the 
>>>> connection is
>>>>      completely idle (no exported or imported BOs), so the first 
>>>> command
>>>>      from a new application after a remote reboot/reset succeeds.
>>>>    - Put the sdma wptr read fence callback on the stack instead of
>>>>      allocating it; it is cancelled on timeout so it never outlives 
>>>> the
>>>>      call.
>>>>
>>>> v4:
>>>>    - Cancel the sdma fence callback on the wait timeout/failure 
>>>> path so it
>>>>      cannot write into the caller's stack after the function 
>>>> returns, and
>>>>      free the callback state in one place.
>>>>
>>>> v3:
>>>>    - Resync both rings at connection setup instead of on the send 
>>>> path.
>>>>    - Set the writeback rptr too, the stale value disagrees with the
>>>>      resynced wptr until the remote FW writes it back.
>>>>
>>>> v2:
>>>>    - Match the FW change: resync wptr only on the first send or 
>>>> after a
>>>>      timeout, instead of checking the remote periodically.
>>>>
>>>> Suggested-by: Felix Kuehling<felix.kuehling@amd.com>
>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 339 
>>>> +++++++++++++++++----
>>>>   1 file changed, 287 insertions(+), 52 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> index b2c2650b0149..c0327f6854a6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> @@ -56,6 +56,10 @@ static int amdgpu_ualink_remote_shootdown(struct 
>>>> amdgpu_device *adev,
>>>>                         u32 size_in_pages, u32 flush_type);
>>>>   static void __amdgpu_ualink_activate_vpod_locked(struct 
>>>> amdgpu_device *adev);
>>>>   static bool amdgpu_ualink_vpod_membership_changed(struct 
>>>> amdgpu_device *adev);
>>>> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device 
>>>> *adev,
>>>> +                       u32 remote_accel_id);
>>>> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>>> +                      u32 remote_accel_id);
>>>>     #define STRIP_NPA(addr)                        \
>>>>       (((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
>>>> @@ -2282,11 +2286,23 @@ static void 
>>>> amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>>>>                           generation_count);
>>>>       }
>>>>   +    /* Peer may have rebooted. */
>>>> +    r = amdgpu_ualink_ring_resync_ptrs(adev, sender_acc_id);
>>>> +    if (r < 0) {
>>>> +        dev_err(adev->dev,
>>>> +            "HELLO: resync sender AccId %u ptrs failed %d\n",
>>>> +            sender_acc_id, r);
>>>> +        goto out_set_state;
>>>> +    }
>>>> +    if (r)
>>>> +        amdgpu_ualink_reset_peer_rings(adev, sender_acc_id);
>>>> +
>>>>       r = amdgpu_ualink_send_hello_ack_msg(adev, sender_acc_id);
>>>>       if (r)
>>>>           dev_err(adev->dev, "HELLO-ACK: send failed to remote 
>>>> AccId:%u\n",
>>>>               sender_acc_id);
>>>>   +out_set_state:
>>>>       mutex_lock(&conn_state->lock);
>>>>       if (r) {
>>>>           conn_state->state = AMDGPU_UALINK_CONN_NOT_READY;
>>>> @@ -2303,6 +2319,14 @@ static void 
>>>> amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>>>>       mutex_unlock(&conn_state->lock);
>>>>   }
>>>>   +/* True if nothing is exported to, or imported from, this remote 
>>>> accelerator. */
>>>> +static bool amdgpu_ualink_peer_idle(struct amdgpu_device *adev, 
>>>> u32 remote_accel_id)
>>>> +{
>>>> +    /* Unlocked: a racing import at worst costs one redundant ring 
>>>> resync. */
>>>> +    return 
>>>> list_empty(&adev->ualink.imp_handles_list[remote_accel_id]) &&
>>>> + list_empty(&adev->ualink.exp_handles_list[remote_accel_id]);
>>>> +}
>>>> +
>>>>   static int amdgpu_ualink_setup_connection(struct amdgpu_device 
>>>> *adev,
>>>>                         u32 remote_acc_id)
>>>>   {
>>>> @@ -2324,16 +2348,31 @@ static int 
>>>> amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
>>>>        * already done by another thread.
>>>>        */
>>>>       mutex_lock(&conn_state->lock);
>>>> -    if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) {
>>>> -        r = 0;
>>>> -        goto out;
>>>> -    } else if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
>>>> -           conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
>>>> +    if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
>>>> +        conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
>>>>           r = -EAGAIN;
>>>>           goto out;
>>>>       }
>>>>   +    if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED &&
>>>> +        !amdgpu_ualink_peer_idle(adev, remote_acc_id)) {
>>>> +        r = 0;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    /* Peer is idle or not connected, it may have rebooted. Skip the
>>>> +     * handshake if the rings are still in sync, it would reset 
>>>> the remote.
>>>> +     */
>>>> +    r = amdgpu_ualink_ring_resync_ptrs(adev, remote_acc_id);
>>>> +    if (r < 0)
>>>> +        goto out;
>>>> +    if (!r && conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED)
>>>> +        goto out;
>>>> +
>>>> +    amdgpu_ualink_reset_peer_rings(adev, remote_acc_id);
>>>> +
>>>>       conn_state->state = AMDGPU_UALINK_CONN_IN_PROGRESS;
>>>> +
>>>>       mutex_unlock(&conn_state->lock);
>>>>         /* Send HELLO message */
>>>> @@ -3670,7 +3709,7 @@ static int 
>>>> amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
>>>>           dev_warn(adev->dev,
>>>>               "IMPORT: NPA-REQ send failed to remote AccId:%u\n",
>>>>               remote_acc_id);
>>>> -        return r;
>>>> +        goto reset_conn;
>>>>       }
>>>>         /* Wait for the NPA_RSP to come back */
>>>> @@ -5511,6 +5550,34 @@ static void 
>>>> amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
>>>>   typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32 wb, u32 
>>>> dw0,
>>>>                      u32 dw1, u32 dw2, u32 dw3);
>>>>   +/*
>>>> + * Refresh rptr from the writeback and check the ring has room for 
>>>> one more
>>>> + * command. The caller must hold the peer lock.
>>>> + *
>>>> + * Return 0 on success or a negative error code.
>>>> + */
>>>> +static int amdgpu_ualink_ring_check_space(struct amdgpu_device *adev,
>>>> +                      u32 remote_accel_id,
>>>> +                      struct amdgpu_ualink_ring *ring,
>>>> +                      struct amdgpu_ualink_wb *wb_cpu)
>>>> +{
>>>> +    ring->rptr = READ_ONCE(wb_cpu->rptr);
>>>> +
>>>> +    if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
>>>> +        dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx 
>>>> rptr 0x%llx\n",
>>>> +            remote_accel_id, ring->wptr, ring->rptr);
>>>> +        return -EFAULT;
>>>> +    }
>>>> +
>>>> +    if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
>>>> +        dev_err(adev->dev, "accel_id %u command ring full wptr 
>>>> 0x%llx rptr 0x%llx\n",
>>>> +            remote_accel_id, ring->wptr, ring->rptr);
>>>> +        return -ENOSPC;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>                         u32 remote_accel_id,
>>>>                         struct amdgpu_ualink_ring *ring,
>>>> @@ -5536,6 +5603,10 @@ static int amdgpu_ualink_send_command(struct 
>>>> amdgpu_device *adev,
>>>>         peer = &remote->peer[remote_accel_id];
>>>>   +    r = amdgpu_ualink_ring_check_space(adev, remote_accel_id, 
>>>> ring, wb_cpu);
>>>> +    if (r)
>>>> +        goto out;
>>>> +
>>>>       /*
>>>>        * 3 sdma copy commands: write data to ring buffer, update 
>>>> wptr, ring doorbell
>>>>        *
>>>> @@ -5552,25 +5623,7 @@ static int amdgpu_ualink_send_command(struct 
>>>> amdgpu_device *adev,
>>>>                        ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>>>                        AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>>>       if (r)
>>>> -        return r;
>>>> -
>>>> -    mutex_lock(&peer->lock);
>>>> -
>>>> -    ring->rptr = READ_ONCE(wb_cpu->rptr);
>>>> -
>>>> -    if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
>>>> -        dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx 
>>>> rptr 0x%llx\n",
>>>> -            remote_accel_id, ring->wptr, ring->rptr);
>>>> -        r = -EFAULT;
>>>> -        goto unlock_free;
>>>> -    }
>>>> -
>>>> -    if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
>>>> -        dev_err(adev->dev, "accel_id %u command ring full wptr 
>>>> 0x%llx rptr 0x%llx\n",
>>>> -            remote_accel_id, ring->wptr, ring->rptr);
>>>> -        r = -ENOSPC;
>>>> -        goto unlock_free;
>>>> -    }
>>>> +        goto out;
>>>>         ib = &job->ibs[0];
>>>>       src = ib->gpu_addr + ndw_copy_cmd * 4;
>>>> @@ -5628,12 +5681,11 @@ static int 
>>>> amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>               dev_dbg(adev->dev,
>>>>                   "remote %u lsdma copy failed (r %d), skip 
>>>> completion wait\n",
>>>>                   remote_accel_id, r);
>>>> -            mutex_unlock(&peer->lock);
>>>>               return r;
>>>>           }
>>>>             goto out_wait_complete;
>>>> -        }
>>>> +    }
>>>>         sdma_ring = &adev->sdma.instance[0].ring;
>>>>   @@ -5664,12 +5716,9 @@ static int 
>>>> amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>       if (r <= 0) {
>>>>           dev_dbg(adev->dev, "remote %u sdma fence wait return r 
>>>> %d\n",
>>>>               remote_accel_id, r);
>>>> -
>>>>           if (r == 0)
>>>>               r = -ETIME;
>>>> -
>>>> -        mutex_unlock(&peer->lock);
>>>> -        return r;
>>>> +        goto out;
>>>>       }
>>>>     out_wait_complete:
>>>> @@ -5678,21 +5727,15 @@ static int 
>>>> amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>>        */
>>>>       r = amdgpu_ualink_remote_wait_timeout(adev, remote_accel_id, 
>>>> wb_cpu, seq);
>>>>   -    /* increase local copy ring wptr, only if FW not timeout */
>>>> -    if (r != -ETIME)
>>>> -        ring->wptr++;
>>>> -
>>>>       /*
>>>> -     * Release ring lock after the remote FW handle command 
>>>> completes to
>>>> -     * prevent race conditions.
>>>> +     * Advance wptr unless the remote timed out, even if the FW 
>>>> returned an
>>>> +     * error status. On timeout the caller resets the connection, 
>>>> which
>>>> +     * resyncs wptr from the remote in 
>>>> amdgpu_ualink_setup_connection.
>>>>        */
>>>> -    mutex_unlock(&peer->lock);
>>>> -    return r;
>>>> -
>>>> +    if (r != -ETIME)
>>>> +        ring->wptr++;
>>>>   -unlock_free:
>>>> -    mutex_unlock(&peer->lock);
>>>> -    amdgpu_job_free(job);
>>>> +out:
>>>>       dev_dbg(adev->dev, "ret r = %d\n", r);
>>>>       return r;
>>>>   }
>>>> @@ -5732,6 +5775,192 @@ static void 
>>>> amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>>>>           remote_accel_id, npa + offset);
>>>>   }
>>>>   +struct amdgpu_ualink_wptr_fence_cb {
>>>> +    struct dma_fence_cb base;
>>>> +    u64 *wptr_cpu;
>>>> +    u64 result;
>>>> +};
>>>> +
>>>> +static void amdgpu_ualink_read_wptr_fence_cb(struct dma_fence *fence,
>>>> +                         struct dma_fence_cb *cb)
>>>> +{
>>>> +    struct amdgpu_ualink_wptr_fence_cb *wptr_cb;
>>>> +
>>>> +    wptr_cb = container_of(cb, typeof(*wptr_cb), base);
>>>> +    wptr_cb->result = *wptr_cb->wptr_cpu;
>>>> +}
>>>> +
>>>> +static int amdgpu_ualink_read_remote_wptr(struct amdgpu_device *adev,
>>>> +                      u32 remote_accel_id,
>>>> +                      struct amdgpu_ualink_ring *ring,
>>>> +                      u64 *wptr)
>>>> +{
>>>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>> +    struct amdgpu_ualink_peer *peer = &remote->peer[remote_accel_id];
>>>> +    struct amdgpu_ualink_wptr_fence_cb wptr_cb = { };
>>>> +    struct amdgpu_ring *sdma_ring;
>>>> +    struct dma_fence *fence;
>>>> +    struct amdgpu_job *job;
>>>> +    struct amdgpu_ib *ib;
>>>> +    u32 ndw, ndw_copy_cmd;
>>>> +    u64 wptr_gpu, *wptr_cpu;
>>>> +    int r = 0;
>>>> +
>>> Minor nitpick here.
>>>
>>> Maybe we should check here that the accelerator state is still 
>>> active similar to what we are doing in
>>>
>>> amdgpu_ualink_send_command().onnection is estiblished,
>>>
>> good point, will add below check, vpod could be deactivated from 
>> side-band when app is running.
>>
>>     /* Refuse sends unless active */
>>     if (adev->ualink.info->accel_state != 
>> AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
>>         return -ESHUTDOWN;
>
> Are you sure? I was thinking that reading the remote rptr should be 
> done regardless of the accelerator state. This needs to happen before 
> we can make the accelerator active for the first time.
>
Are you mixing connection_state vs accel_state here? Accel_state needs 
to be active before any communication with a remote GPU is done.

Regards,

Mukul

> Regards,
>   Felix
>
>
>>
>> Regards,
>> Philip
>>>
>>> Other than that, this patch is:
>>>
>>> Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
>>>
>>>> +    *wptr = 0;
>>>> +
>>>> +    /* 1 sdma copy command to read wptr */
>>>> +    ndw_copy_cmd = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>>>> +
>>>> +    /* wptr 2 dwords */
>>>> +    ndw = ndw_copy_cmd + 2;
>>>> +    r = amdgpu_job_alloc_with_ib(adev, &peer->entity, 
>>>> AMDGPU_FENCE_OWNER_VM,
>>>> +                     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>>> +                     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> +    ib = &job->ibs[0];
>>>> +    wptr_gpu = ib->gpu_addr + ndw_copy_cmd * 4;
>>>> +    wptr_cpu = (u64 *)(ib->ptr + ndw_copy_cmd);
>>>> +
>>>> +    dev_dbg(adev->dev, "read wptr from remote %u npa gart wptr 
>>>> 0x%llx use %s\n",
>>>> +        remote_accel_id, ring->wptr_npa_gart,
>>>> +        remote->use_lsdma ? "lsdma" : "sdma");
>>>> +
>>>> +    if (remote->use_lsdma) {
>>>> +        r = amdgpu_lsdma_copy_mem(adev, ring->wptr_npa_gart, 
>>>> wptr_gpu, 8);
>>>> +        if (!r)
>>>> +            *wptr = *wptr_cpu;
>>>> +        amdgpu_job_free(job);
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    wptr_cb.wptr_cpu = wptr_cpu;
>>>> +
>>>> +    amdgpu_emit_copy_buffer(adev, ib, ring->wptr_npa_gart, 
>>>> wptr_gpu, 8, 0);
>>>> +
>>>> +    sdma_ring = &adev->sdma.instance[0].ring;
>>>> +    amdgpu_ring_pad_ib(sdma_ring, ib);
>>>> +    WARN_ON(ib->length_dw > ndw_copy_cmd);
>>>> +
>>>> +    fence = amdgpu_job_submit(job);
>>>> +
>>>> +    r = dma_fence_add_callback(fence, &wptr_cb.base,
>>>> +                   amdgpu_ualink_read_wptr_fence_cb);
>>>> +    if (r == -ENOENT) {
>>>> +        /* Fence already signaled; the callback won't run, do it 
>>>> inline. */
>>>> +        amdgpu_ualink_read_wptr_fence_cb(fence, &wptr_cb.base);
>>>> +        r = 0;
>>>> +        goto out_put_fence;
>>>> +    } else if (r) {
>>>> +        /* -EINVAL: NULL fence or func, not expected here. */
>>>> +        goto out_put_fence;
>>>> +    }
>>>> +
>>>> +    r = dma_fence_wait_timeout(fence, false, 
>>>> AMDGPU_FENCE_JIFFIES_TIMEOUT);
>>>> +    if (r > 0) {
>>>> +        r = 0;    /* read wptr successfully */
>>>> +        goto out_put_fence;
>>>> +    }
>>>> +
>>>> +    dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
>>>> +        remote_accel_id, r);
>>>> +
>>>> +    if (r == 0)
>>>> +        r = -ETIME;
>>>> +
>>>> +    /*
>>>> +     * Timed out: the callback is still armed and wptr_cb is on 
>>>> our stack.
>>>> +     * Cancel it so it can't fire after we return and write into 
>>>> the freed
>>>> +     * stack frame.
>>>> +     */
>>>> +    dma_fence_remove_callback(fence, &wptr_cb.base);
>>>> +
>>>> +out_put_fence:
>>>> +    if (!r)
>>>> +        *wptr = wptr_cb.result;
>>>> +    dma_fence_put(fence);
>>>> +
>>>> +out:
>>>> +    dev_dbg(adev->dev, "remote %u wptr 0x%llx return %d\n",
>>>> +        remote_accel_id, *wptr, r);
>>>> +    return r;
>>>> +}
>>>> +
>>>> +/**
>>>> + * amdgpu_ualink_ring_resync_ptrs - sync local ring pointers from 
>>>> remote
>>>> + * @adev: amdgpu device pointer
>>>> + * @remote_accel_id: remote accelerator ID
>>>> + *
>>>> + * After a reboot on either side the two ends disagree on wptr. 
>>>> Read the remote
>>>> + * wptr of both peer rings and adopt it as the local wptr and rptr.
>>>> + *
>>>> + * Return 0 if both rings already match, 1 if they were resynced, 
>>>> or a negative
>>>> + * error code if a remote read failed, leaving the rings untouched.
>>>> + */
>>>> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>>> +                      u32 remote_accel_id)
>>>> +{
>>>> +    struct amdgpu_ualink_peer *peer = 
>>>> &to_remote(adev)->peer[remote_accel_id];
>>>> +    struct amdgpu_ualink_wb *int_wb, *tlb_wb;
>>>> +    u64 int_wptr, tlb_wptr;
>>>> +    int r;
>>>> +
>>>> +    /* ring->wptr and ring->rptr are owned by the send path. */
>>>> +    guard(mutex)(&peer->lock);
>>>> +
>>>> +    /* Read both before updating either, so a failure changes 
>>>> nothing. */
>>>> +    r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
>>>> +                       &peer->interrupt, &int_wptr);
>>>> +    if (!r)
>>>> +        r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
>>>> +                           &peer->shootdown, &tlb_wptr);
>>>> +    if (r) {
>>>> +        dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed 
>>>> %d\n",
>>>> +            ualink_accel_id(adev), remote_accel_id, r);
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr 
>>>> == tlb_wptr) {
>>>> +        dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same 
>>>> as remote %u\n",
>>>> +            ualink_accel_id(adev), int_wptr, tlb_wptr, 
>>>> remote_accel_id);
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    dev_dbg(adev->dev,
>>>> +        "accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 
>>>> 0x%llx 0x%llx\n",
>>>> +        ualink_accel_id(adev), peer->interrupt.wptr, 
>>>> peer->shootdown.wptr,
>>>> +        remote_accel_id, int_wptr, tlb_wptr);
>>>> +
>>>> +    amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
>>>> +                  RB_TYPE_REMOTE_INTERRUPT);
>>>> +    amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
>>>> +                  RB_TYPE_TLB_INV);
>>>> +
>>>> +    peer->interrupt.wptr = int_wptr;
>>>> +    peer->interrupt.rptr = int_wptr;
>>>> +    peer->shootdown.wptr = tlb_wptr;
>>>> +    peer->shootdown.rptr = tlb_wptr;
>>>> +
>>>> +    /* Drop the stale writeback rptr, it disagrees with the 
>>>> resynced wptr. */
>>>> +    WRITE_ONCE(int_wb->rptr, int_wptr);
>>>> +    WRITE_ONCE(tlb_wb->rptr, tlb_wptr);
>>>> +    return 1;
>>>> +}
>>>> +
>>>> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device 
>>>> *adev,
>>>> +                       u32 remote_accel_id)
>>>> +{
>>>> +    struct amdgpu_ualink_peer *peer = 
>>>> &to_remote(adev)->peer[remote_accel_id];
>>>> +
>>>> +    dev_dbg(adev->dev, "remote accel_id %u\n", remote_accel_id);
>>>> +
>>>> +    guard(mutex)(&peer->lock);
>>>> +
>>>> +    peer->interrupt.ready = false;
>>>> +    peer->shootdown.ready = false;
>>>> +}
>>>> +
>>>>   static int amdgpu_ualink_update_wb_address(struct amdgpu_device 
>>>> *adev,
>>>>                          u32 remote_accel_id, u32 ring_type)
>>>>   {
>>>> @@ -5794,6 +6023,9 @@ static int 
>>>> amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>>>         peer = &remote->peer[remote_accel_id];
>>>>       ring = &peer->shootdown;
>>>> +
>>>> +    guard(mutex)(&peer->lock);
>>>> +
>>>>       if (!ring->ready) {
>>>>           dev_dbg(adev->dev, "accel_id %u ring not ready\n", 
>>>> remote_accel_id);
>>>>           r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>>> @@ -5802,11 +6034,11 @@ static int 
>>>> amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>>>               return r;
>>>>       }
>>>>   -    r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, 
>>>> ring->wb_cpu,
>>>> -                       amdgpu_ualink_emit_shootdown,
>>>> -                       flush_type, upper_32_bits(addr),
>>>> -                       lower_32_bits(addr), size_in_pages);
>>>> -    return r;
>>>> +    return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
>>>> +                      ring->wb_cpu,
>>>> +                      amdgpu_ualink_emit_shootdown,
>>>> +                      flush_type, upper_32_bits(addr),
>>>> +                      lower_32_bits(addr), size_in_pages);
>>>>   }
>>>>     /**
>>>> @@ -5835,6 +6067,9 @@ static int 
>>>> amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>>>         peer = &remote->peer[remote_accel_id];
>>>>       ring = &peer->interrupt;
>>>> +
>>>> +    guard(mutex)(&peer->lock);
>>>> +
>>>>       if (!ring->ready) {
>>>>           dev_dbg(adev->dev, "accel_id %u ring not ready\n", 
>>>> remote_accel_id);
>>>>           r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>>> @@ -5843,10 +6078,10 @@ static int 
>>>> amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>>>               return r;
>>>>       }
>>>>   -    r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, 
>>>> ring->wb_cpu,
>>>> -                       amdgpu_ualink_emit_interrupt,
>>>> -                       dw0, dw1, dw2, dw3);
>>>> -    return r;
>>>> +    return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
>>>> +                      ring->wb_cpu,
>>>> +                      amdgpu_ualink_emit_interrupt,
>>>> +                      dw0, dw1, dw2, dw3);
>>>>   }
>>>>     /**
>>
--------------dfkhxMj6fW1Jai0ShjNxbOOQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/17/2026 1:59 PM, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:e751339b-cfff-43bc-a19a-963408134677@amd.com">On
      2026-09-17 10:07, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2026-09-16 21:33, Mukul Joshi wrote:
        <br>
        <blockquote type="cite">
          <br>
          <br>
          On 9/16/2026 11:25 AM, Philip Yang wrote:
          <br>
          <blockquote type="cite">When one side of UALink nodes reboots,
            its ring wptr resets to 0 while
            <br>
            the peer keeps a stale value. Read the remote wptr and adopt
            it as the
            <br>
            local wptr and rptr to resync, before the first message is
            sent. Either
            <br>
            side can notice first, so do this both when setting up the
            connection
            <br>
            and when receiving the HELLO from the peer.
            <br>
            <br>
            On the sdma path, read the wptr in a fence callback because
            the IB buffer
            <br>
            holding the result is recycled once the fence signals, so
            reading it
            <br>
            after dma_fence_wait_timeout() is too late. The lsdma path
            copies
            <br>
            synchronously, so it reads the wptr directly.
            <br>
            <br>
            Take peer-&gt;lock in the callers
            (amdgpu_ualink_remote_interrupt and
            <br>
            amdgpu_ualink_remote_shootdown) instead of in
            amdgpu_ualink_send_command,
            <br>
            so the ring-&gt;ready check and the send are atomic against
            a concurrent
            <br>
            ring reset.
            <br>
            <br>
            Move the rptr refresh and ring-full check out of
            amdgpu_ualink_send_command()
            <br>
            into amdgpu_ualink_ring_check_space(), so it runs under the
            caller's
            <br>
            peer-&gt;lock before the job is allocated.
            <br>
            <br>
            On a failed NPA-REQ send, reset the connection like the
            NPA-RSP timeout path
            <br>
            already does, so the next attempt resyncs the ring wptr.
            <br>
            <br>
            On connection reset, amdgpu_ualink_reset_peer_rings() only
            clears
            <br>
            ring-&gt;ready, so the writeback address is re-registered on
            the next send.
            <br>
            <br>
            v10:
            <br>
            &nbsp;&nbsp; - Fix the resync missed on the receiving side: after a
            reboot the peer
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; may send HELLO before we set up the connection, so
            resync the ring
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; wptr in amdgpu_ualink_process_hello_msg() too.
            <br>
            <br>
            v9:
            <br>
            &nbsp;&nbsp; - Fix the unnecessary connection reset after an app
            exits: the peer is
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; idle here but still busy handling NPA revokes on the
            remote, so the
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; HELLO reset a healthy connection. Only send it if the
            wptr changed.
            <br>
            &nbsp;&nbsp; - Resync both rings together under peer-&gt;lock, read
            both remote wptr
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; before updating either so a failed read changes
            nothing.
            <br>
            <br>
            v8:
            <br>
            &nbsp;&nbsp; - Fix regression with concurrent import ioctls: do the
            idle check and
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; ring reset in amdgpu_ualink_setup_connection() under
            conn_state-&gt;lock,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; and return -EAGAIN for IN_PROGRESS/PENDING first.
            <br>
            &nbsp;&nbsp; - Reset the peer rings only, the imp/exp xarray cleanup
            is not needed to
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; resync wptr.
            <br>
            <br>
            v7:
            <br>
            &nbsp;&nbsp; - With v6 reboot one node of vPOD test passed on
            minirack.
            <br>
            &nbsp;&nbsp; - Use the per-remote imported and exported handle lists
            for the idle
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; check instead of walking the xarrays.
            <br>
            &nbsp;&nbsp; - Rename amdgpu_ualink_resync_peer_rings() to
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_reset_peer_rings(), it only clears
            ring-&gt;ready.
            <br>
            <br>
            v6:
            <br>
            &nbsp;&nbsp; - Check idleness per remote accelerator instead of
            globally, and reset
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; the stale connection at the import ioctl so the peer
            re-runs the
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; HELLO handshake after a reboot.
            <br>
            <br>
            v5:
            <br>
            &nbsp;&nbsp; - Resync the ring pointers at the import ioctl when the
            connection is
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; completely idle (no exported or imported BOs), so the
            first command
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; from a new application after a remote reboot/reset
            succeeds.
            <br>
            &nbsp;&nbsp; - Put the sdma wptr read fence callback on the stack
            instead of
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; allocating it; it is cancelled on timeout so it never
            outlives the
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; call.
            <br>
            <br>
            v4:
            <br>
            &nbsp;&nbsp; - Cancel the sdma fence callback on the wait
            timeout/failure path so it
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; cannot write into the caller's stack after the function
            returns, and
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; free the callback state in one place.
            <br>
            <br>
            v3:
            <br>
            &nbsp;&nbsp; - Resync both rings at connection setup instead of on the
            send path.
            <br>
            &nbsp;&nbsp; - Set the writeback rptr too, the stale value disagrees
            with the
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; resynced wptr until the remote FW writes it back.
            <br>
            <br>
            v2:
            <br>
            &nbsp;&nbsp; - Match the FW change: resync wptr only on the first send
            or after a
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; timeout, instead of checking the remote periodically.
            <br>
            <br>
            Suggested-by: Felix Kuehling<a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
            <br>
            Signed-off-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            Reviewed-by: Felix Kuehling<a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 339
            +++++++++++++++++----
            <br>
            &nbsp; 1 file changed, 287 insertions(+), 52 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
            <br>
            index b2c2650b0149..c0327f6854a6 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
            <br>
            @@ -56,6 +56,10 @@ static int
            amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 size_in_pages, u32 flush_type);
            <br>
            &nbsp; static void __amdgpu_ualink_activate_vpod_locked(struct
            amdgpu_device *adev);
            <br>
            &nbsp; static bool amdgpu_ualink_vpod_membership_changed(struct
            amdgpu_device *adev);
            <br>
            +static void amdgpu_ualink_reset_peer_rings(struct
            amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id);
            <br>
            +static int amdgpu_ualink_ring_resync_ptrs(struct
            amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id);
            <br>
            &nbsp; &nbsp; #define STRIP_NPA(addr)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((u64)(addr) &amp;
            ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
            <br>
            @@ -2282,11 +2286,23 @@ static void
            amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; generation_count);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; /* Peer may have rebooted. */
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_ring_resync_ptrs(adev,
            sender_acc_id);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r &lt; 0) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;HELLO: resync sender AccId %u ptrs failed
            %d\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sender_acc_id, r);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_set_state;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_reset_peer_rings(adev,
            sender_acc_id);
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_send_hello_ack_msg(adev,
            sender_acc_id);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;HELLO-ACK: send failed to
            remote AccId:%u\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sender_acc_id);
            <br>
            &nbsp; +out_set_state:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;conn_state-&gt;lock);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conn_state-&gt;state =
            AMDGPU_UALINK_CONN_NOT_READY;
            <br>
            @@ -2303,6 +2319,14 @@ static void
            amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;conn_state-&gt;lock);
            <br>
            &nbsp; }
            <br>
            &nbsp; +/* True if nothing is exported to, or imported from, this
            remote accelerator. */
            <br>
            +static bool amdgpu_ualink_peer_idle(struct amdgpu_device
            *adev, u32 remote_accel_id)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; /* Unlocked: a racing import at worst costs one
            redundant ring resync. */
            <br>
            +&nbsp;&nbsp;&nbsp; return
            list_empty(&amp;adev-&gt;ualink.imp_handles_list[remote_accel_id])
            &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            list_empty(&amp;adev-&gt;ualink.exp_handles_list[remote_accel_id]);
            <br>
            +}
            <br>
            +
            <br>
            &nbsp; static int amdgpu_ualink_setup_connection(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_acc_id)
            <br>
            &nbsp; {
            <br>
            @@ -2324,16 +2348,31 @@ static int
            amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * already done by another thread.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;conn_state-&gt;lock);
            <br>
            -&nbsp;&nbsp;&nbsp; if (conn_state-&gt;state ==
            AMDGPU_UALINK_CONN_ESTABLISHED) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            -&nbsp;&nbsp;&nbsp; } else if (conn_state-&gt;state ==
            AMDGPU_UALINK_CONN_IN_PROGRESS ||
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conn_state-&gt;state ==
            AMDGPU_UALINK_CONN_PENDING) {
            <br>
            +&nbsp;&nbsp;&nbsp; if (conn_state-&gt;state ==
            AMDGPU_UALINK_CONN_IN_PROGRESS ||
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conn_state-&gt;state == AMDGPU_UALINK_CONN_PENDING)
            {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; if (conn_state-&gt;state ==
            AMDGPU_UALINK_CONN_ESTABLISHED &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_ualink_peer_idle(adev, remote_acc_id)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* Peer is idle or not connected, it may have rebooted.
            Skip the
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * handshake if the rings are still in sync, it would
            reset the remote.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_ring_resync_ptrs(adev,
            remote_acc_id);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r &lt; 0)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            +&nbsp;&nbsp;&nbsp; if (!r &amp;&amp; conn_state-&gt;state ==
            AMDGPU_UALINK_CONN_ESTABLISHED)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_ualink_reset_peer_rings(adev, remote_acc_id);
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conn_state-&gt;state = AMDGPU_UALINK_CONN_IN_PROGRESS;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;conn_state-&gt;lock);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Send HELLO message */
            <br>
            @@ -3670,7 +3709,7 @@ static int
            amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;IMPORT: NPA-REQ send failed to remote
            AccId:%u\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_acc_id);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto reset_conn;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for the NPA_RSP to come back */
            <br>
            @@ -5511,6 +5550,34 @@ static void
            amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32
            wb_data,
            <br>
            &nbsp; typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32
            wb, u32 dw0,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dw1, u32 dw2, u32 dw3);
            <br>
            &nbsp; +/*
            <br>
            + * Refresh rptr from the writeback and check the ring has
            room for one more
            <br>
            + * command. The caller must hold the peer lock.
            <br>
            + *
            <br>
            + * Return 0 on success or a negative error code.
            <br>
            + */
            <br>
            +static int amdgpu_ualink_ring_check_space(struct
            amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_ring *ring,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_wb *wb_cpu)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; ring-&gt;rptr = READ_ONCE(wb_cpu-&gt;rptr);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(ring-&gt;rptr &gt; ring-&gt;wptr)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;accel_id %u ring overflow
            wptr 0x%llx rptr 0x%llx\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, ring-&gt;wptr, ring-&gt;rptr);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if ((ring-&gt;wptr + 1 - ring-&gt;rptr) &gt;=
            ring-&gt;rb_size) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;accel_id %u command ring
            full wptr 0x%llx rptr 0x%llx\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, ring-&gt;wptr, ring-&gt;rptr);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOSPC;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            &nbsp; static int amdgpu_ualink_send_command(struct amdgpu_device
            *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_ring *ring,
            <br>
            @@ -5536,6 +5603,10 @@ static int
            amdgpu_ualink_send_command(struct amdgpu_device *adev,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer = &amp;remote-&gt;peer[remote_accel_id];
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_ring_check_space(adev,
            remote_accel_id, ring, wb_cpu);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 3 sdma copy commands: write data to ring buffer,
            update wptr, ring doorbell
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
            <br>
            @@ -5552,25 +5623,7 @@ static int
            amdgpu_ualink_send_command(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER,
            &amp;job);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; mutex_lock(&amp;peer-&gt;lock);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; ring-&gt;rptr = READ_ONCE(wb_cpu-&gt;rptr);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(ring-&gt;rptr &gt; ring-&gt;wptr)) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;accel_id %u ring overflow
            wptr 0x%llx rptr 0x%llx\n&quot;,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, ring-&gt;wptr, ring-&gt;rptr);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock_free;
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; if ((ring-&gt;wptr + 1 - ring-&gt;rptr) &gt;=
            ring-&gt;rb_size) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;accel_id %u command ring
            full wptr 0x%llx rptr 0x%llx\n&quot;,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, ring-&gt;wptr, ring-&gt;rptr);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ENOSPC;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock_free;
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib = &amp;job-&gt;ibs[0];
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src = ib-&gt;gpu_addr + ndw_copy_cmd * 4;
            <br>
            @@ -5628,12 +5681,11 @@ static int
            amdgpu_ualink_send_command(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;remote %u lsdma copy failed (r %d), skip
            completion wait\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, r);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;peer-&gt;lock);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_wait_complete;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_ring = &amp;adev-&gt;sdma.instance[0].ring;
            <br>
            &nbsp; @@ -5664,12 +5716,9 @@ static int
            amdgpu_ualink_send_command(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt;= 0) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;remote %u sdma fence wait
            return r %d\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, r);
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == 0)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ETIME;
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;peer-&gt;lock);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp; out_wait_complete:
            <br>
            @@ -5678,21 +5727,15 @@ static int
            amdgpu_ualink_send_command(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_remote_wait_timeout(adev,
            remote_accel_id, wb_cpu, seq);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; /* increase local copy ring wptr, only if FW not
            timeout */
            <br>
            -&nbsp;&nbsp;&nbsp; if (r != -ETIME)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr++;
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; * Release ring lock after the remote FW handle command
            completes to
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; * prevent race conditions.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * Advance wptr unless the remote timed out, even if
            the FW returned an
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * error status. On timeout the caller resets the
            connection, which
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * resyncs wptr from the remote in
            amdgpu_ualink_setup_connection.
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            -&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;peer-&gt;lock);
            <br>
            -&nbsp;&nbsp;&nbsp; return r;
            <br>
            -
            <br>
            +&nbsp;&nbsp;&nbsp; if (r != -ETIME)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr++;
            <br>
            &nbsp; -unlock_free:
            <br>
            -&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;peer-&gt;lock);
            <br>
            -&nbsp;&nbsp;&nbsp; amdgpu_job_free(job);
            <br>
            +out:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;ret r = %d\n&quot;, r);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp; }
            <br>
            @@ -5732,6 +5775,192 @@ static void
            amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, npa + offset);
            <br>
            &nbsp; }
            <br>
            &nbsp; +struct amdgpu_ualink_wptr_fence_cb {
            <br>
            +&nbsp;&nbsp;&nbsp; struct dma_fence_cb base;
            <br>
            +&nbsp;&nbsp;&nbsp; u64 *wptr_cpu;
            <br>
            +&nbsp;&nbsp;&nbsp; u64 result;
            <br>
            +};
            <br>
            +
            <br>
            +static void amdgpu_ualink_read_wptr_fence_cb(struct
            dma_fence *fence,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence_cb *cb)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_wptr_fence_cb *wptr_cb;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; wptr_cb = container_of(cb, typeof(*wptr_cb), base);
            <br>
            +&nbsp;&nbsp;&nbsp; wptr_cb-&gt;result = *wptr_cb-&gt;wptr_cpu;
            <br>
            +}
            <br>
            +
            <br>
            +static int amdgpu_ualink_read_remote_wptr(struct
            amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_ring *ring,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 *wptr)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_remote *remote = to_remote(adev);
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_peer *peer =
            &amp;remote-&gt;peer[remote_accel_id];
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_wptr_fence_cb wptr_cb = { };
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ring *sdma_ring;
            <br>
            +&nbsp;&nbsp;&nbsp; struct dma_fence *fence;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_job *job;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib;
            <br>
            +&nbsp;&nbsp;&nbsp; u32 ndw, ndw_copy_cmd;
            <br>
            +&nbsp;&nbsp;&nbsp; u64 wptr_gpu, *wptr_cpu;
            <br>
            +&nbsp;&nbsp;&nbsp; int r = 0;
            <br>
            +
            <br>
          </blockquote>
          Minor nitpick here.
          <br>
          <br>
          Maybe we should check here that the accelerator state is still
          active similar to what we are doing in
          <br>
          <br>
          amdgpu_ualink_send_command().onnection is estiblished,
          <br>
          <br>
        </blockquote>
        good point, will add below check, vpod could be deactivated from
        side-band when app is running.
        <br>
        <br>
        &nbsp; &nbsp; /* Refuse sends unless active */
        <br>
        &nbsp; &nbsp; if (adev-&gt;ualink.info-&gt;accel_state !=
        AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
        <br>
        &nbsp; &nbsp; &nbsp; &nbsp; return -ESHUTDOWN;
        <br>
      </blockquote>
      <br>
      Are you sure? I was thinking that reading the remote rptr should
      be done regardless of the accelerator state. This needs to happen
      before we can make the accelerator active for the first time.
      <br>
      <br>
    </blockquote>
    <p>Are you mixing connection_state vs accel_state here? Accel_state
      needs to be active before any communication with a remote GPU is
      done.</p>
    <p>Regards,</p>
    <p>Mukul</p>
    <blockquote type="cite" cite="mid:e751339b-cfff-43bc-a19a-963408134677@amd.com">Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        Philip
        <br>
        <blockquote type="cite">
          <br>
          Other than that, this patch is:
          <br>
          <br>
          Reviewed-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
          <br>
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp; *wptr = 0;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* 1 sdma copy command to read wptr */
            <br>
            +&nbsp;&nbsp;&nbsp; ndw_copy_cmd =
            ALIGN(adev-&gt;mman.buffer_funcs-&gt;copy_num_dw, 8);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* wptr 2 dwords */
            <br>
            +&nbsp;&nbsp;&nbsp; ndw = ndw_copy_cmd + 2;
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_job_alloc_with_ib(adev,
            &amp;peer-&gt;entity, AMDGPU_FENCE_OWNER_VM,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER,
            &amp;job);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; ib = &amp;job-&gt;ibs[0];
            <br>
            +&nbsp;&nbsp;&nbsp; wptr_gpu = ib-&gt;gpu_addr + ndw_copy_cmd * 4;
            <br>
            +&nbsp;&nbsp;&nbsp; wptr_cpu = (u64 *)(ib-&gt;ptr + ndw_copy_cmd);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;read wptr from remote %u npa
            gart wptr 0x%llx use %s\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, ring-&gt;wptr_npa_gart,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote-&gt;use_lsdma ? &quot;lsdma&quot; : &quot;sdma&quot;);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (remote-&gt;use_lsdma) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_lsdma_copy_mem(adev,
            ring-&gt;wptr_npa_gart, wptr_gpu, 8);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *wptr = *wptr_cpu;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_job_free(job);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; wptr_cb.wptr_cpu = wptr_cpu;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_emit_copy_buffer(adev, ib,
            ring-&gt;wptr_npa_gart, wptr_gpu, 8, 0);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; sdma_ring = &amp;adev-&gt;sdma.instance[0].ring;
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(sdma_ring, ib);
            <br>
            +&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw &gt; ndw_copy_cmd);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; fence = amdgpu_job_submit(job);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = dma_fence_add_callback(fence, &amp;wptr_cb.base,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_read_wptr_fence_cb);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r == -ENOENT) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fence already signaled; the callback won't run,
            do it inline. */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_read_wptr_fence_cb(fence,
            &amp;wptr_cb.base);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_put_fence;
            <br>
            +&nbsp;&nbsp;&nbsp; } else if (r) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* -EINVAL: NULL fence or func, not expected here.
            */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_put_fence;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; r = dma_fence_wait_timeout(fence, false,
            AMDGPU_FENCE_JIFFIES_TIMEOUT);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r &gt; 0) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;&nbsp;&nbsp;&nbsp; /* read wptr successfully */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_put_fence;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;remote %u sdma fence wait return
            r %d\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, r);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (r == 0)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ETIME;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /*
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * Timed out: the callback is still armed and wptr_cb
            is on our stack.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * Cancel it so it can't fire after we return and write
            into the freed
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * stack frame.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; dma_fence_remove_callback(fence, &amp;wptr_cb.base);
            <br>
            +
            <br>
            +out_put_fence:
            <br>
            +&nbsp;&nbsp;&nbsp; if (!r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *wptr = wptr_cb.result;
            <br>
            +&nbsp;&nbsp;&nbsp; dma_fence_put(fence);
            <br>
            +
            <br>
            +out:
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;remote %u wptr 0x%llx return
            %d\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, *wptr, r);
            <br>
            +&nbsp;&nbsp;&nbsp; return r;
            <br>
            +}
            <br>
            +
            <br>
            +/**
            <br>
            + * amdgpu_ualink_ring_resync_ptrs - sync local ring
            pointers from remote
            <br>
            + * @adev: amdgpu device pointer
            <br>
            + * @remote_accel_id: remote accelerator ID
            <br>
            + *
            <br>
            + * After a reboot on either side the two ends disagree on
            wptr. Read the remote
            <br>
            + * wptr of both peer rings and adopt it as the local wptr
            and rptr.
            <br>
            + *
            <br>
            + * Return 0 if both rings already match, 1 if they were
            resynced, or a negative
            <br>
            + * error code if a remote read failed, leaving the rings
            untouched.
            <br>
            + */
            <br>
            +static int amdgpu_ualink_ring_resync_ptrs(struct
            amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_peer *peer =
            &amp;to_remote(adev)-&gt;peer[remote_accel_id];
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_wb *int_wb, *tlb_wb;
            <br>
            +&nbsp;&nbsp;&nbsp; u64 int_wptr, tlb_wptr;
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* ring-&gt;wptr and ring-&gt;rptr are owned by the
            send path. */
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;peer-&gt;lock);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* Read both before updating either, so a failure
            changes nothing. */
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_read_remote_wptr(adev,
            remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;peer-&gt;interrupt,
            &amp;int_wptr);
            <br>
            +&nbsp;&nbsp;&nbsp; if (!r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_read_remote_wptr(adev,
            remote_accel_id,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;peer-&gt;shootdown,
            &amp;tlb_wptr);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;accel_id %u read remote %u
            wptr failed %d\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ualink_accel_id(adev), remote_accel_id, r);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (peer-&gt;interrupt.wptr == int_wptr &amp;&amp;
            peer-&gt;shootdown.wptr == tlb_wptr) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;accel_id %u wptr 0x%llx
            0x%llx is same as remote %u\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ualink_accel_id(adev), int_wptr, tlb_wptr,
            remote_accel_id);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;accel_id %u wptr 0x%llx 0x%llx sync to remote %u
            wptr 0x%llx 0x%llx\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ualink_accel_id(adev), peer-&gt;interrupt.wptr,
            peer-&gt;shootdown.wptr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id, int_wptr, tlb_wptr);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_ualink_get_wb_addr(adev, remote_accel_id,
            &amp;int_wb, NULL,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RB_TYPE_REMOTE_INTERRUPT);
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_ualink_get_wb_addr(adev, remote_accel_id,
            &amp;tlb_wb, NULL,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RB_TYPE_TLB_INV);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; peer-&gt;interrupt.wptr = int_wptr;
            <br>
            +&nbsp;&nbsp;&nbsp; peer-&gt;interrupt.rptr = int_wptr;
            <br>
            +&nbsp;&nbsp;&nbsp; peer-&gt;shootdown.wptr = tlb_wptr;
            <br>
            +&nbsp;&nbsp;&nbsp; peer-&gt;shootdown.rptr = tlb_wptr;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* Drop the stale writeback rptr, it disagrees with the
            resynced wptr. */
            <br>
            +&nbsp;&nbsp;&nbsp; WRITE_ONCE(int_wb-&gt;rptr, int_wptr);
            <br>
            +&nbsp;&nbsp;&nbsp; WRITE_ONCE(tlb_wb-&gt;rptr, tlb_wptr);
            <br>
            +&nbsp;&nbsp;&nbsp; return 1;
            <br>
            +}
            <br>
            +
            <br>
            +static void amdgpu_ualink_reset_peer_rings(struct
            amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_peer *peer =
            &amp;to_remote(adev)-&gt;peer[remote_accel_id];
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;remote accel_id %u\n&quot;,
            remote_accel_id);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;peer-&gt;lock);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; peer-&gt;interrupt.ready = false;
            <br>
            +&nbsp;&nbsp;&nbsp; peer-&gt;shootdown.ready = false;
            <br>
            +}
            <br>
            +
            <br>
            &nbsp; static int amdgpu_ualink_update_wb_address(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id, u32 ring_type)
            <br>
            &nbsp; {
            <br>
            @@ -5794,6 +6023,9 @@ static int
            amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer = &amp;remote-&gt;peer[remote_accel_id];
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring = &amp;peer-&gt;shootdown;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;peer-&gt;lock);
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring-&gt;ready) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;accel_id %u ring not
            ready\n&quot;, remote_accel_id);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_update_wb_address(adev,
            remote_accel_id,
            <br>
            @@ -5802,11 +6034,11 @@ static int
            amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_send_command(adev, remote_accel_id,
            ring, ring-&gt;wb_cpu,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_emit_shootdown,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_type, upper_32_bits(addr),
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(addr), size_in_pages);
            <br>
            -&nbsp;&nbsp;&nbsp; return r;
            <br>
            +&nbsp;&nbsp;&nbsp; return amdgpu_ualink_send_command(adev,
            remote_accel_id, ring,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wb_cpu,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_emit_shootdown,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_type, upper_32_bits(addr),
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(addr), size_in_pages);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            @@ -5835,6 +6067,9 @@ static int
            amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer = &amp;remote-&gt;peer[remote_accel_id];
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring = &amp;peer-&gt;interrupt;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;peer-&gt;lock);
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring-&gt;ready) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;accel_id %u ring not
            ready\n&quot;, remote_accel_id);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_update_wb_address(adev,
            remote_accel_id,
            <br>
            @@ -5843,10 +6078,10 @@ static int
            amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_send_command(adev, remote_accel_id,
            ring, ring-&gt;wb_cpu,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_emit_interrupt,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dw0, dw1, dw2, dw3);
            <br>
            -&nbsp;&nbsp;&nbsp; return r;
            <br>
            +&nbsp;&nbsp;&nbsp; return amdgpu_ualink_send_command(adev,
            remote_accel_id, ring,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wb_cpu,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_emit_interrupt,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dw0, dw1, dw2, dw3);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------dfkhxMj6fW1Jai0ShjNxbOOQ--
