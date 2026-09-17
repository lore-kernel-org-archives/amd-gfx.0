Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175B4C982D2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 18:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290A110E00A;
	Thu, 17 Sep 2026 18:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C+Lew7C9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E73910E00A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 18:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyLhSMpxutMDZD0rBELSfW6InaSwn3CkCLQiipiF+ZcqUAVzSz1NSyfPfC17FW00Flk/z8wBv+eCrZ43BucdN2sdgA+icx78opjnJsNKdI+vG6z4/OWKQKgDjJznARChQE1VB/+BW4nM4spm6IZq6J+x+oMCoTQ6gIYWuZnwaIiLdP/QpFu6I0UmNdztQ7EAqx7l0aNbr7lY19UI+ei8uiVfzfszemZz70k/P6xHqpg86V7kQM4zbSY1idwj89BHPFHD6fAaTpJtS42w+5F6qKArH6Af/bAX0uhrIFTH23eyJ1Ze71sZb/ZKPg0otfBBlTpe7bpr563+gtRDAeJM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWgtVQJpVYdkWlYjtLoGzun9oFHYb90K+iRSmQNmatc=;
 b=GWvwfBTQFt4L+vp+sVbkxGwzqaIi4Z3/6Z56vbKp/nqIf508iHndMSsYqazQKbeRLffs+4735qoiHXighZ9/Eg8EfXD5AZ76CB0oETPTU1YfF70WKf1qaHggKk5Vhf93NoMOHT5gUTvAnhVWzKeKK0fmnszEloI4/lZePBXakU88orpaWnC90sPZLt81oaB4f1yIm8pq5/d+GIFqH2OMPNzTOYGwlUKg8XbXwniNKLYkgCczu1BG5+7IvdfHuUUQ87f7jORADYB7ReRKIHCDilTp3Wuq9FMzUtqQAqP3Im9XXeQjtFOz3ypiSjHbjxfZl31uwa4wlwsIk/inMo0Wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWgtVQJpVYdkWlYjtLoGzun9oFHYb90K+iRSmQNmatc=;
 b=C+Lew7C9WKsz3iWsFFuSmWki6qsZwkmdIbMHkyKt0CdfTBjwfciX9lTc/y7vDmEiBvgX/TfGxHS8V7s+qHxdXM5wTwzlre4aeBD2Mzhxy5BRCnt6jJvvjxzRUswC/E0dAABsSe9hvBKp/nP0Qij8/SJrnYzaFmjJaWO/aiXXKbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by SA1PR12MB6775.namprd12.prod.outlook.com
 (2603:10b6:806:25a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 17:59:54 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 17:59:53 +0000
Message-ID: <e751339b-cfff-43bc-a19a-963408134677@amd.com>
Date: Thu, 17 Sep 2026 13:59:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] drm/amdgpu: Resync UALink ring wptr after reboot
To: Philip Yang <yangp@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com
References: <20260916152528.3918848-1-Philip.Yang@amd.com>
 <b6349b6d-0357-4850-8957-6d2d17649a05@amd.com>
 <ca5f45bb-2bbd-464b-94fb-336456e9966c@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <ca5f45bb-2bbd-464b-94fb-336456e9966c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::25) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4049fa67-4868-4845-0063-08df14e579ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|11063799006|6133799003|5023799004|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: aeXDhTTL4AvRuygF79RD6WTWorpSqp/qWXIFXL0O8q2r6RadU+ne9q+gJkFdfugPFmRb87ri2f8kdCqfWOvQn6eObwrW95Y46qfvtzj0OwS9RPhHo7boiuqjzM8qbh0rzBE4wn1LUqfPP5UiQ7KY2Gl3VBmBbtfE6SWCLtxgn+ABn31fxB4a4cfgyCcFKEikdcs7gbqUh5KMl0AW+0VazBQH+8LCRmLqfxYsAUVmKCoiM8aZmkPGregaL8V/wTKzaUzBNojWDXRVOsJjme+gER6dAgOx8lIPrUTAwtczEZWmMT4IBCyKUoD2ROd5uYZ+30muaJODXha7ktXpOnalBg8lsxG3KZXu3TotlH5DvbI2xC2gaLecN6lp7oDR+Cq0XG/LFB7+e6I4yIRLZXU9jh/T7SJ/1FbnBXT1DwtgfZh1JKSLDUvn908Ko5jFs+9PAXoM2x34OJLZ/ZSA6zKv+xffncgG8zVmAcf33icHSBkQeFrFz+OKE+7boH1nHDVxwy9d02VyfVOeRpcPY3NUVtO6zhtyzbuTpbkMfgT8Xp/S5u7++2JKATDx52SCuItcFpoXdvxIuQaWb+MgmrnQ2kKTfUuI1WPYaL/WyaUI/zM+yR0Nof8hO+jUQfGiuT3v1Yr7q1G4eHRUHqY9N+pk5laXhja1D8AqrKhiBgvQrBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(5023799004)(3023799007)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3p0RDFUblRVdmwyK0pWNExHRUxLYkc0Um44dWpNTmlQREFQeGVwakJHTUxQ?=
 =?utf-8?B?QktlYnhscmhDeXFIeFZUcEl0VzA5M3VlZUlYSFhJQWJvekYwU3ZMOGsvSVFx?=
 =?utf-8?B?NkxMYi9Xdk5oZ1gvSWxEVFVPdXB4eFYyeGdTd1c4VlpsRGphVkxhbWkxY0x6?=
 =?utf-8?B?T3lqTXduR0o4aGJtamQ2S0pNTmM5OG02bStHSGpJTjVQQWVGOUlOSFFUU0FD?=
 =?utf-8?B?SzgwTS9JWHdvVmNVWDVJVUR6NFh4MEhVYW5hMXkrSXpMOGsyaGV6TXlrSEFq?=
 =?utf-8?B?WG9sWC93dmtaNmhIOUN4S0tuc1ZCNjJ4Tm5kTXBXd21pTFVNT3JyTDBLbTN4?=
 =?utf-8?B?VFpZRWVEMTZZY0xueFB5SmtmR0I3Rzd4bGsrNDRtSWJmcXRqS2lBWVowUVBU?=
 =?utf-8?B?Sjd6YlFJVHBXYjhYRUkzd3ZGL3VncHIyajlEUmwzRVJNYlRkbi9zU1FReTd2?=
 =?utf-8?B?QmlsMlhsTWF3ZUk5Y24vSmJmMHJsb0tSM0VBOTJQb3J1SGpKS1B0MDNQR2xZ?=
 =?utf-8?B?bzRXN2FTYTBFczRzQVg2NGs4SE5COVhOcGgvUzFxbnZ4azJLR0VlSjhQR0Uz?=
 =?utf-8?B?MWNydTlyVnRZM2hzNDZjNE9Od3h0eFBYNmNOT3c2aUJGQlMrRUs1OHNBQThh?=
 =?utf-8?B?b21GVjYzT1JoVDVuNWJLcEdYRWowakY1QytVOWRTU3N5RGdyTDZtZERncHZ5?=
 =?utf-8?B?YWcxNGFjYXdOZVcvYWZpUytuSXYyYWpWVDlkaXR0MDlVUUZjY2FOZEJTL1JN?=
 =?utf-8?B?TzMrUGRDY0NmUzhQdjFWSnhNaURwMWw1NWNqdk9wVlZSK25Cc3lWOTZwM1Uy?=
 =?utf-8?B?WXFtSE10RkZzUWVaUm13aW90b0JlbWcyQ1JUTVRlbVRJR0JQaEJXc3dIcTYy?=
 =?utf-8?B?cjJwWVg3S2xabmRxN1IxZnYvVGd6NEt4RXFvY0NGY0VuZmRGSWlwd2JWb2dV?=
 =?utf-8?B?ek9nWHdRQ0pKYlRUUE4zWEc3WDFKVVZvMitsQXhrS0ZSTjNiaDZweTVjQ0Zu?=
 =?utf-8?B?QkgzOFB5Qzlya093SUhLeWdmZ3NKV2hVc2ZjSHNBaFhGaWdLN3Z5L2lPR1NF?=
 =?utf-8?B?L1oyQU9WM2Z2MDhNSlVmMUtqNVhsa2c1QTl1K0hrMnpnWUJPZ21vUG5JNDRX?=
 =?utf-8?B?M283N3pkTXlGNnpFNy8yZmJESTR3RUN2NXkzbzBtTk13d0swdWNramtzbWp6?=
 =?utf-8?B?RmFScVJYV3lKdUtPV2w1MkZNVGR6ZGNneGdFMStHKyt0L3B0YVF1NlNCaGFV?=
 =?utf-8?B?SWhzN1Y1cmpVRXN4Kzk0YnhkTVdFY3ZwdVR5dzd3T1pEZ3pnbEIzL0g2MWVC?=
 =?utf-8?B?a2pnRElDSkhiT3o4Wmd3NEJjVjluWCtnYW1RU01wSUpicDBYSytaekZCS3Zk?=
 =?utf-8?B?ZVM3RVpTQmV3MVF5Z1RUa01IS2MvRUhiMFM4b0FzaEFoVTBWWkEzOHljU0ky?=
 =?utf-8?B?NENiRUcydkFDOWNpZWJxZm1wYnB1QUhaSU5NUEJOWjE4N0NXbUFYM2xicDZY?=
 =?utf-8?B?a2N6R21XMWgzeDdNOVZGR0M3L1RjcU5iWnlPdG1PR1dvQU8wT1V3L0Q3OTds?=
 =?utf-8?B?SThSZVNLSFJtbm1BVGdIejdpdnVmMXZSOFUvN3g4MVRaMkZFZUpEOGgwaXQz?=
 =?utf-8?B?Yzh1QUdNN0hHTU1VVjRuaTNobmxLYVREbElGMk5Hd1NPUFNzeTZralhoTkZx?=
 =?utf-8?B?SU0wOUhLWDBCNnNFcmhCN2J4eDZpakZaRE5QZXFXdXBjSHhSbEFFM0FaMGZ5?=
 =?utf-8?B?dUErSE5VNVNnM1RuZnNLWm9SNy9lb2VWN1dhNXY3cEJYL1dUaWx1d3RpUXNL?=
 =?utf-8?B?R09scURRSnQ4eXVQdnBENmhLeUZhQXNHZ2JpQjVkRzF5b2dMOUFObDdqcDNB?=
 =?utf-8?B?RWFjbk5NemlPMGpleWVEaVJFclduSU1TNkZXMklOdCtWRXFzWXczNGpPZHFD?=
 =?utf-8?B?UDF0d29haGxzUWJLd0h4NEZONG9TWG14SnFYZDdkOUVFeVhNUnRaSjBlOE5h?=
 =?utf-8?B?dTVvaGJtSTlQME9mVnBUSlI2bDZYdW5TZnQxb3RrN1ZTUWE4cUwxS3haNzVZ?=
 =?utf-8?B?MU41Y2lnRW9FQmFNUHJWeGN6dFFIVitEWGJjMUtNdWQ1dEE4QW4ya0paMmhD?=
 =?utf-8?B?aGRaVlFFSEdTeHdUdEJLR2lkZkZvdm16eGdialVWTkNzYzBYY3ZkRWlRVTlr?=
 =?utf-8?B?Q2JYY1dTUDRhWGRmVTZRUXhNWW5FN2FXRGpWdUNGT0x3SEhQS3BwZUxBanNn?=
 =?utf-8?B?ODIzZmUybjFvTzNwTW9mVmVMbkd4NUt4SjRlWWlxSFdpZ0t6dkE1MmdYbkRI?=
 =?utf-8?B?NE1yUjB0elNWVU92STA4aWw5d2RycUw0THAvNHd2U1dKOXJuYUwxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4049fa67-4868-4845-0063-08df14e579ac
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:59:53.5384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJk3liFWlGlxchVdhu+hpGPLxaXzrQNnef5Orv0neM0TfaN1KCZMpBmfAeWnQxGk3M7pGkpk2fLzCEsQnNZ39A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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

On 2026-09-17 10:07, Philip Yang wrote:
>
>
> On 2026-09-16 21:33, Mukul Joshi wrote:
>>
>>
>> On 9/16/2026 11:25 AM, Philip Yang wrote:
>>> When one side of UALink nodes reboots, its ring wptr resets to 0 while
>>> the peer keeps a stale value. Read the remote wptr and adopt it as the
>>> local wptr and rptr to resync, before the first message is sent. Either
>>> side can notice first, so do this both when setting up the connection
>>> and when receiving the HELLO from the peer.
>>>
>>> On the sdma path, read the wptr in a fence callback because the IB buffer
>>> holding the result is recycled once the fence signals, so reading it
>>> after dma_fence_wait_timeout() is too late. The lsdma path copies
>>> synchronously, so it reads the wptr directly.
>>>
>>> Take peer->lock in the callers (amdgpu_ualink_remote_interrupt and
>>> amdgpu_ualink_remote_shootdown) instead of in amdgpu_ualink_send_command,
>>> so the ring->ready check and the send are atomic against a concurrent
>>> ring reset.
>>>
>>> Move the rptr refresh and ring-full check out of amdgpu_ualink_send_command()
>>> into amdgpu_ualink_ring_check_space(), so it runs under the caller's
>>> peer->lock before the job is allocated.
>>>
>>> On a failed NPA-REQ send, reset the connection like the NPA-RSP timeout path
>>> already does, so the next attempt resyncs the ring wptr.
>>>
>>> On connection reset, amdgpu_ualink_reset_peer_rings() only clears
>>> ring->ready, so the writeback address is re-registered on the next send.
>>>
>>> v10:
>>>    - Fix the resync missed on the receiving side: after a reboot the peer
>>>      may send HELLO before we set up the connection, so resync the ring
>>>      wptr in amdgpu_ualink_process_hello_msg() too.
>>>
>>> v9:
>>>    - Fix the unnecessary connection reset after an app exits: the peer is
>>>      idle here but still busy handling NPA revokes on the remote, so the
>>>      HELLO reset a healthy connection. Only send it if the wptr changed.
>>>    - Resync both rings together under peer->lock, read both remote wptr
>>>      before updating either so a failed read changes nothing.
>>>
>>> v8:
>>>    - Fix regression with concurrent import ioctls: do the idle check and
>>>      ring reset in amdgpu_ualink_setup_connection() under conn_state->lock,
>>>      and return -EAGAIN for IN_PROGRESS/PENDING first.
>>>    - Reset the peer rings only, the imp/exp xarray cleanup is not needed to
>>>      resync wptr.
>>>
>>> v7:
>>>    - With v6 reboot one node of vPOD test passed on minirack.
>>>    - Use the per-remote imported and exported handle lists for the idle
>>>      check instead of walking the xarrays.
>>>    - Rename amdgpu_ualink_resync_peer_rings() to
>>>      amdgpu_ualink_reset_peer_rings(), it only clears ring->ready.
>>>
>>> v6:
>>>    - Check idleness per remote accelerator instead of globally, and reset
>>>      the stale connection at the import ioctl so the peer re-runs the
>>>      HELLO handshake after a reboot.
>>>
>>> v5:
>>>    - Resync the ring pointers at the import ioctl when the connection is
>>>      completely idle (no exported or imported BOs), so the first command
>>>      from a new application after a remote reboot/reset succeeds.
>>>    - Put the sdma wptr read fence callback on the stack instead of
>>>      allocating it; it is cancelled on timeout so it never outlives the
>>>      call.
>>>
>>> v4:
>>>    - Cancel the sdma fence callback on the wait timeout/failure path so it
>>>      cannot write into the caller's stack after the function returns, and
>>>      free the callback state in one place.
>>>
>>> v3:
>>>    - Resync both rings at connection setup instead of on the send path.
>>>    - Set the writeback rptr too, the stale value disagrees with the
>>>      resynced wptr until the remote FW writes it back.
>>>
>>> v2:
>>>    - Match the FW change: resync wptr only on the first send or after a
>>>      timeout, instead of checking the remote periodically.
>>>
>>> Suggested-by: Felix Kuehling<felix.kuehling@amd.com>
>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 339 +++++++++++++++++----
>>>   1 file changed, 287 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> index b2c2650b0149..c0327f6854a6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> @@ -56,6 +56,10 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>>   					  u32 size_in_pages, u32 flush_type);
>>>   static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
>>>   static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev);
>>> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>>> +					   u32 remote_accel_id);
>>> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>> +					  u32 remote_accel_id);
>>>   
>>>   #define STRIP_NPA(addr)						\
>>>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
>>> @@ -2282,11 +2286,23 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>>>   						generation_count);
>>>   	}
>>>   
>>> +	/* Peer may have rebooted. */
>>> +	r = amdgpu_ualink_ring_resync_ptrs(adev, sender_acc_id);
>>> +	if (r < 0) {
>>> +		dev_err(adev->dev,
>>> +			"HELLO: resync sender AccId %u ptrs failed %d\n",
>>> +			sender_acc_id, r);
>>> +		goto out_set_state;
>>> +	}
>>> +	if (r)
>>> +		amdgpu_ualink_reset_peer_rings(adev, sender_acc_id);
>>> +
>>>   	r = amdgpu_ualink_send_hello_ack_msg(adev, sender_acc_id);
>>>   	if (r)
>>>   		dev_err(adev->dev, "HELLO-ACK: send failed to remote AccId:%u\n",
>>>   			sender_acc_id);
>>>   
>>> +out_set_state:
>>>   	mutex_lock(&conn_state->lock);
>>>   	if (r) {
>>>   		conn_state->state = AMDGPU_UALINK_CONN_NOT_READY;
>>> @@ -2303,6 +2319,14 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>>>   	mutex_unlock(&conn_state->lock);
>>>   }
>>>   
>>> +/* True if nothing is exported to, or imported from, this remote accelerator. */
>>> +static bool amdgpu_ualink_peer_idle(struct amdgpu_device *adev, u32 remote_accel_id)
>>> +{
>>> +	/* Unlocked: a racing import at worst costs one redundant ring resync. */
>>> +	return list_empty(&adev->ualink.imp_handles_list[remote_accel_id]) &&
>>> +	       list_empty(&adev->ualink.exp_handles_list[remote_accel_id]);
>>> +}
>>> +
>>>   static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
>>>   					  u32 remote_acc_id)
>>>   {
>>> @@ -2324,16 +2348,31 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
>>>   	 * already done by another thread.
>>>   	 */
>>>   	mutex_lock(&conn_state->lock);
>>> -	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) {
>>> -		r = 0;
>>> -		goto out;
>>> -	} else if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
>>> -		   conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
>>> +	if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
>>> +	    conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
>>>   		r = -EAGAIN;
>>>   		goto out;
>>>   	}
>>>   
>>> +	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED &&
>>> +	    !amdgpu_ualink_peer_idle(adev, remote_acc_id)) {
>>> +		r = 0;
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* Peer is idle or not connected, it may have rebooted. Skip the
>>> +	 * handshake if the rings are still in sync, it would reset the remote.
>>> +	 */
>>> +	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_acc_id);
>>> +	if (r < 0)
>>> +		goto out;
>>> +	if (!r && conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED)
>>> +		goto out;
>>> +
>>> +	amdgpu_ualink_reset_peer_rings(adev, remote_acc_id);
>>> +
>>>   	conn_state->state = AMDGPU_UALINK_CONN_IN_PROGRESS;
>>> +
>>>   	mutex_unlock(&conn_state->lock);
>>>   
>>>   	/* Send HELLO message */
>>> @@ -3670,7 +3709,7 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
>>>   		dev_warn(adev->dev,
>>>   			"IMPORT: NPA-REQ send failed to remote AccId:%u\n",
>>>   			remote_acc_id);
>>> -		return r;
>>> +		goto reset_conn;
>>>   	}
>>>   
>>>   	/* Wait for the NPA_RSP to come back */
>>> @@ -5511,6 +5550,34 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
>>>   typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32 wb, u32 dw0,
>>>   				   u32 dw1, u32 dw2, u32 dw3);
>>>   
>>> +/*
>>> + * Refresh rptr from the writeback and check the ring has room for one more
>>> + * command. The caller must hold the peer lock.
>>> + *
>>> + * Return 0 on success or a negative error code.
>>> + */
>>> +static int amdgpu_ualink_ring_check_space(struct amdgpu_device *adev,
>>> +					  u32 remote_accel_id,
>>> +					  struct amdgpu_ualink_ring *ring,
>>> +					  struct amdgpu_ualink_wb *wb_cpu)
>>> +{
>>> +	ring->rptr = READ_ONCE(wb_cpu->rptr);
>>> +
>>> +	if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
>>> +		dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n",
>>> +			remote_accel_id, ring->wptr, ring->rptr);
>>> +		return -EFAULT;
>>> +	}
>>> +
>>> +	if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
>>> +		dev_err(adev->dev, "accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n",
>>> +			remote_accel_id, ring->wptr, ring->rptr);
>>> +		return -ENOSPC;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>   				      u32 remote_accel_id,
>>>   				      struct amdgpu_ualink_ring *ring,
>>> @@ -5536,6 +5603,10 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>   
>>>   	peer = &remote->peer[remote_accel_id];
>>>   
>>> +	r = amdgpu_ualink_ring_check_space(adev, remote_accel_id, ring, wb_cpu);
>>> +	if (r)
>>> +		goto out;
>>> +
>>>   	/*
>>>   	 * 3 sdma copy commands: write data to ring buffer, update wptr, ring doorbell
>>>   	 *
>>> @@ -5552,25 +5623,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>   				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>>   				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>>   	if (r)
>>> -		return r;
>>> -
>>> -	mutex_lock(&peer->lock);
>>> -
>>> -	ring->rptr = READ_ONCE(wb_cpu->rptr);
>>> -
>>> -	if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
>>> -		dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n",
>>> -			remote_accel_id, ring->wptr, ring->rptr);
>>> -		r = -EFAULT;
>>> -		goto unlock_free;
>>> -	}
>>> -
>>> -	if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
>>> -		dev_err(adev->dev, "accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n",
>>> -			remote_accel_id, ring->wptr, ring->rptr);
>>> -		r = -ENOSPC;
>>> -		goto unlock_free;
>>> -	}
>>> +		goto out;
>>>   
>>>   	ib = &job->ibs[0];
>>>   	src = ib->gpu_addr + ndw_copy_cmd * 4;
>>> @@ -5628,12 +5681,11 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>   			dev_dbg(adev->dev,
>>>   				"remote %u lsdma copy failed (r %d), skip completion wait\n",
>>>   				remote_accel_id, r);
>>> -			mutex_unlock(&peer->lock);
>>>   			return r;
>>>   		}
>>>   
>>>   		goto out_wait_complete;
>>> -        }
>>> +	}
>>>   
>>>   	sdma_ring = &adev->sdma.instance[0].ring;
>>>   
>>> @@ -5664,12 +5716,9 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>   	if (r <= 0) {
>>>   		dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
>>>   			remote_accel_id, r);
>>> -
>>>   		if (r == 0)
>>>   			r = -ETIME;
>>> -
>>> -		mutex_unlock(&peer->lock);
>>> -		return r;
>>> +		goto out;
>>>   	}
>>>   
>>>   out_wait_complete:
>>> @@ -5678,21 +5727,15 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>>>   	 */
>>>   	r = amdgpu_ualink_remote_wait_timeout(adev, remote_accel_id, wb_cpu, seq);
>>>   
>>> -	/* increase local copy ring wptr, only if FW not timeout */
>>> -	if (r != -ETIME)
>>> -		ring->wptr++;
>>> -
>>>   	/*
>>> -	 * Release ring lock after the remote FW handle command completes to
>>> -	 * prevent race conditions.
>>> +	 * Advance wptr unless the remote timed out, even if the FW returned an
>>> +	 * error status. On timeout the caller resets the connection, which
>>> +	 * resyncs wptr from the remote in amdgpu_ualink_setup_connection.
>>>   	 */
>>> -	mutex_unlock(&peer->lock);
>>> -	return r;
>>> -
>>> +	if (r != -ETIME)
>>> +		ring->wptr++;
>>>   
>>> -unlock_free:
>>> -	mutex_unlock(&peer->lock);
>>> -	amdgpu_job_free(job);
>>> +out:
>>>   	dev_dbg(adev->dev, "ret r = %d\n", r);
>>>   	return r;
>>>   }
>>> @@ -5732,6 +5775,192 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>>>   		remote_accel_id, npa + offset);
>>>   }
>>>   
>>> +struct amdgpu_ualink_wptr_fence_cb {
>>> +	struct dma_fence_cb base;
>>> +	u64 *wptr_cpu;
>>> +	u64 result;
>>> +};
>>> +
>>> +static void amdgpu_ualink_read_wptr_fence_cb(struct dma_fence *fence,
>>> +					     struct dma_fence_cb *cb)
>>> +{
>>> +	struct amdgpu_ualink_wptr_fence_cb *wptr_cb;
>>> +
>>> +	wptr_cb = container_of(cb, typeof(*wptr_cb), base);
>>> +	wptr_cb->result = *wptr_cb->wptr_cpu;
>>> +}
>>> +
>>> +static int amdgpu_ualink_read_remote_wptr(struct amdgpu_device *adev,
>>> +					  u32 remote_accel_id,
>>> +					  struct amdgpu_ualink_ring *ring,
>>> +					  u64 *wptr)
>>> +{
>>> +	struct amdgpu_ualink_remote *remote = to_remote(adev);
>>> +	struct amdgpu_ualink_peer *peer = &remote->peer[remote_accel_id];
>>> +	struct amdgpu_ualink_wptr_fence_cb wptr_cb = { };
>>> +	struct amdgpu_ring *sdma_ring;
>>> +	struct dma_fence *fence;
>>> +	struct amdgpu_job *job;
>>> +	struct amdgpu_ib *ib;
>>> +	u32 ndw, ndw_copy_cmd;
>>> +	u64 wptr_gpu, *wptr_cpu;
>>> +	int r = 0;
>>> +
>> Minor nitpick here.
>>
>> Maybe we should check here that the accelerator state is still active 
>> similar to what we are doing in
>>
>> amdgpu_ualink_send_command().onnection is estiblished,
>>
> good point, will add below check, vpod could be deactivated from 
> side-band when app is running.
>
>     /* Refuse sends unless active */
>     if (adev->ualink.info->accel_state != 
> AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
>         return -ESHUTDOWN;

Are you sure? I was thinking that reading the remote rptr should be done 
regardless of the accelerator state. This needs to happen before we can 
make the accelerator active for the first time.

Regards,
   Felix


>
> Regards,
> Philip
>>
>> Other than that, this patch is:
>>
>> Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
>>
>>> +	*wptr = 0;
>>> +
>>> +	/* 1 sdma copy command to read wptr */
>>> +	ndw_copy_cmd = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>>> +
>>> +	/* wptr 2 dwords */
>>> +	ndw = ndw_copy_cmd + 2;
>>> +	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
>>> +				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>> +				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>>> +	if (r)
>>> +		return r;
>>> +
>>> +	ib = &job->ibs[0];
>>> +	wptr_gpu = ib->gpu_addr + ndw_copy_cmd * 4;
>>> +	wptr_cpu = (u64 *)(ib->ptr + ndw_copy_cmd);
>>> +
>>> +	dev_dbg(adev->dev, "read wptr from remote %u npa gart wptr 0x%llx use %s\n",
>>> +		remote_accel_id, ring->wptr_npa_gart,
>>> +		remote->use_lsdma ? "lsdma" : "sdma");
>>> +
>>> +	if (remote->use_lsdma) {
>>> +		r = amdgpu_lsdma_copy_mem(adev, ring->wptr_npa_gart, wptr_gpu, 8);
>>> +		if (!r)
>>> +			*wptr = *wptr_cpu;
>>> +		amdgpu_job_free(job);
>>> +		goto out;
>>> +	}
>>> +
>>> +	wptr_cb.wptr_cpu = wptr_cpu;
>>> +
>>> +	amdgpu_emit_copy_buffer(adev, ib, ring->wptr_npa_gart, wptr_gpu, 8, 0);
>>> +
>>> +	sdma_ring = &adev->sdma.instance[0].ring;
>>> +	amdgpu_ring_pad_ib(sdma_ring, ib);
>>> +	WARN_ON(ib->length_dw > ndw_copy_cmd);
>>> +
>>> +	fence = amdgpu_job_submit(job);
>>> +
>>> +	r = dma_fence_add_callback(fence, &wptr_cb.base,
>>> +				   amdgpu_ualink_read_wptr_fence_cb);
>>> +	if (r == -ENOENT) {
>>> +		/* Fence already signaled; the callback won't run, do it inline. */
>>> +		amdgpu_ualink_read_wptr_fence_cb(fence, &wptr_cb.base);
>>> +		r = 0;
>>> +		goto out_put_fence;
>>> +	} else if (r) {
>>> +		/* -EINVAL: NULL fence or func, not expected here. */
>>> +		goto out_put_fence;
>>> +	}
>>> +
>>> +	r = dma_fence_wait_timeout(fence, false, AMDGPU_FENCE_JIFFIES_TIMEOUT);
>>> +	if (r > 0) {
>>> +		r = 0;	/* read wptr successfully */
>>> +		goto out_put_fence;
>>> +	}
>>> +
>>> +	dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
>>> +		remote_accel_id, r);
>>> +
>>> +	if (r == 0)
>>> +		r = -ETIME;
>>> +
>>> +	/*
>>> +	 * Timed out: the callback is still armed and wptr_cb is on our stack.
>>> +	 * Cancel it so it can't fire after we return and write into the freed
>>> +	 * stack frame.
>>> +	 */
>>> +	dma_fence_remove_callback(fence, &wptr_cb.base);
>>> +
>>> +out_put_fence:
>>> +	if (!r)
>>> +		*wptr = wptr_cb.result;
>>> +	dma_fence_put(fence);
>>> +
>>> +out:
>>> +	dev_dbg(adev->dev, "remote %u wptr 0x%llx return %d\n",
>>> +		remote_accel_id, *wptr, r);
>>> +	return r;
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_ualink_ring_resync_ptrs - sync local ring pointers from remote
>>> + * @adev: amdgpu device pointer
>>> + * @remote_accel_id: remote accelerator ID
>>> + *
>>> + * After a reboot on either side the two ends disagree on wptr. Read the remote
>>> + * wptr of both peer rings and adopt it as the local wptr and rptr.
>>> + *
>>> + * Return 0 if both rings already match, 1 if they were resynced, or a negative
>>> + * error code if a remote read failed, leaving the rings untouched.
>>> + */
>>> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>> +					  u32 remote_accel_id)
>>> +{
>>> +	struct amdgpu_ualink_peer *peer = &to_remote(adev)->peer[remote_accel_id];
>>> +	struct amdgpu_ualink_wb *int_wb, *tlb_wb;
>>> +	u64 int_wptr, tlb_wptr;
>>> +	int r;
>>> +
>>> +	/* ring->wptr and ring->rptr are owned by the send path. */
>>> +	guard(mutex)(&peer->lock);
>>> +
>>> +	/* Read both before updating either, so a failure changes nothing. */
>>> +	r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
>>> +					   &peer->interrupt, &int_wptr);
>>> +	if (!r)
>>> +		r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
>>> +						   &peer->shootdown, &tlb_wptr);
>>> +	if (r) {
>>> +		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
>>> +			ualink_accel_id(adev), remote_accel_id, r);
>>> +		return r;
>>> +	}
>>> +
>>> +	if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr == tlb_wptr) {
>>> +		dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n",
>>> +			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
>>> +		return 0;
>>> +	}
>>> +
>>> +	dev_dbg(adev->dev,
>>> +		"accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n",
>>> +		ualink_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>>> +		remote_accel_id, int_wptr, tlb_wptr);
>>> +
>>> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
>>> +				  RB_TYPE_REMOTE_INTERRUPT);
>>> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
>>> +				  RB_TYPE_TLB_INV);
>>> +
>>> +	peer->interrupt.wptr = int_wptr;
>>> +	peer->interrupt.rptr = int_wptr;
>>> +	peer->shootdown.wptr = tlb_wptr;
>>> +	peer->shootdown.rptr = tlb_wptr;
>>> +
>>> +	/* Drop the stale writeback rptr, it disagrees with the resynced wptr. */
>>> +	WRITE_ONCE(int_wb->rptr, int_wptr);
>>> +	WRITE_ONCE(tlb_wb->rptr, tlb_wptr);
>>> +	return 1;
>>> +}
>>> +
>>> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>>> +					   u32 remote_accel_id)
>>> +{
>>> +	struct amdgpu_ualink_peer *peer = &to_remote(adev)->peer[remote_accel_id];
>>> +
>>> +	dev_dbg(adev->dev, "remote accel_id %u\n", remote_accel_id);
>>> +
>>> +	guard(mutex)(&peer->lock);
>>> +
>>> +	peer->interrupt.ready = false;
>>> +	peer->shootdown.ready = false;
>>> +}
>>> +
>>>   static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
>>>   					   u32 remote_accel_id, u32 ring_type)
>>>   {
>>> @@ -5794,6 +6023,9 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>>   
>>>   	peer = &remote->peer[remote_accel_id];
>>>   	ring = &peer->shootdown;
>>> +
>>> +	guard(mutex)(&peer->lock);
>>> +
>>>   	if (!ring->ready) {
>>>   		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
>>>   		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>> @@ -5802,11 +6034,11 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>>>   			return r;
>>>   	}
>>>   
>>> -	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
>>> -				       amdgpu_ualink_emit_shootdown,
>>> -				       flush_type, upper_32_bits(addr),
>>> -				       lower_32_bits(addr), size_in_pages);
>>> -	return r;
>>> +	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
>>> +					  ring->wb_cpu,
>>> +					  amdgpu_ualink_emit_shootdown,
>>> +					  flush_type, upper_32_bits(addr),
>>> +					  lower_32_bits(addr), size_in_pages);
>>>   }
>>>   
>>>   /**
>>> @@ -5835,6 +6067,9 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>>   
>>>   	peer = &remote->peer[remote_accel_id];
>>>   	ring = &peer->interrupt;
>>> +
>>> +	guard(mutex)(&peer->lock);
>>> +
>>>   	if (!ring->ready) {
>>>   		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
>>>   		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>>> @@ -5843,10 +6078,10 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>>   			return r;
>>>   	}
>>>   
>>> -	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
>>> -				       amdgpu_ualink_emit_interrupt,
>>> -				       dw0, dw1, dw2, dw3);
>>> -	return r;
>>> +	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
>>> +					  ring->wb_cpu,
>>> +					  amdgpu_ualink_emit_interrupt,
>>> +					  dw0, dw1, dw2, dw3);
>>>   }
>>>   
>>>   /**
>
