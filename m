Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7BDC982C1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 21:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F096610E010;
	Wed, 16 Sep 2026 21:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0/wFhkW0";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB0510E010
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 21:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHvWc7cE/xyC0lg940Sk9azrq5srA0Ahv36mfF4PJky3vR34a8+3M4NPBGgXQ9Q0uJkMB4WAuRXm9h0CslSbGQMT4B1Bdcs0ajoGX5+e/YJcxTF0GldxiIazAlA1aTzkSxzFQgRHBTQDlVTUPwBasr9PotOouRGgWgFO/U31CQC7NXVpy3Y/pc1WdumZK7H/NLN6dWfxOKLHoNeRPrQD1ypXVnrXMKMnbyhiggEPKt338YNB/DNQ2/IKm1kYCK/8tHxmhg+eyXdU0vBvJQsSssrDKJMZDbzTo2jFe5zOS0XT1t3azTymT64woUUwY33RGLyEBQoG6123JbH1w1vMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuPTo+qFhUmmpfTkhq63Oak3M6IOmTwfEYsQm0ghwDg=;
 b=pI9CNpixSDy+xOIzpL5jfSkRVZq5znagl/JZ3aA4Z8soBUj5sF0QHvzGoC6z/9CSFpNPMdmxWALd8dOIlVVGTRobl9BW+v4XmjWp8bqhvVZq8CbfyOrG1whTSGCgfF9R97oysFInboPjoSAxpjTMXm1VQNgE4+oRX+WtaSYNMIEC7xTbjo5Hgmbwfr0nSYE6ECA5HdV4FkG5sbmna4oYVDd1Y+tjQ8HGXX7iGwUmG6wePa9BWczIeNM1Ed8YU67s2K2KO/9a52eVuk2mMtMK/1lgfPf95iZglfYCA6EFRszG09jYa8jnQBWqMaIauIcYvToSx7V+dLUl1GqsEunj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuPTo+qFhUmmpfTkhq63Oak3M6IOmTwfEYsQm0ghwDg=;
 b=0/wFhkW0ifvaD4lF/9Xmc/7d4wd6YLXEksK6Bxtjl2viz4Kt19g8LctvJhLX4FC4Qs45E8l+2/WOh6KVN2MKEJ3AvAhGlXWve6Kl8TL+hm2NgNqgMOLu7cc4k2ER41c4bFY1FJDpRD3abcoYuz2EYJNBJrTLv5UzywBZh9XJG7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SN7PR12MB6932.namprd12.prod.outlook.com
 (2603:10b6:806:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 21:04:16 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 21:04:15 +0000
Message-ID: <bfd0e2d4-f28f-4e79-b154-4638672eef2b@amd.com>
Date: Wed, 16 Sep 2026 17:04:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] drm/amdgpu: Resync UALink ring wptr after reboot
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20260916152528.3918848-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260916152528.3918848-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::31) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0852cf89-a5cb-43b3-cee4-08df143610fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|3023799007|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 4W6f4gFBzNOjIhre7sXeti7uGTJ1rY5QQkmvTOCR1BDvdv/A+6VixeNCfslU+c/A+4W+Ef9v1hfmylQMpe8M7Zvz+kylRkaGugDbbvd/pmrbEl8i0fxWT2nP7VW6DILa2TTTmArFHkwzGepveY3i5F56Bd70TfjKl2y0KaOcWpBhGUyR4ByvUHClP/L5RjI/V7J1x1xDI0V3YQ+05rPFf2a5ZDmu4dhPmLY4/wE49l7Rqe/Gle9vxei6iJIrYQ5BKtNaSgiohnlR2YaQFIP341B+dacbQfFRmq8YRxpFfMSLXtSibVVOGHSu4JB2jroLoQ9rsdUqGmEgboGhkz7nvuPnTsxrA7UOAglC3ZHGupuwvtFn2x67Zowdh3RyoD9Stdp03HWrWsz6IlaZ4Z+I+cct+jmPTsZDTVMBDl2+OAfKjRFdPJUXNoL1WPV+62YC8kQ+VYKmHU+Lbh83TbwKrZwNWe77j+le9N16pGqP5ZpSk+8vKLEv7Hbywia+bNXdyiN0iC3UHK/xNVWL2BHTlzOAeZPRjJ9CpNS7dRosipH6YWiBEB6+4uousYp0PpACClyrYPdJ3AZRnCnPcl2s+nIdpoONPMgr3BI2KpU8hTzhlE4btHuCWE26WyztSZ1Yux/6dAN/dZ+3TIBjY2QzUPEII+gpwAI1pPzc2kyaU1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NtLzVRUnd3QTUrYnRoTXNTT2laUUduaW9Rd3JkVzJ6UHBjOFMyVjhJMSs0?=
 =?utf-8?B?Z2VseFlaZEhmb0dSVUx5RFFic0FnMXNBUU5IWVpIWFQ4aUJ2aGhvNytwaW15?=
 =?utf-8?B?Wm04WkxUbkxtSVVIT3dRRHZWQWlIWWdmM3Qrc1YwQ1psQ3FqdjdYNG10R25h?=
 =?utf-8?B?blRVWk1PeXJMbzRudm5mWW5UaXIwY1F6UUNwN0lvM21DMkc2VzhUODRSVDlT?=
 =?utf-8?B?QThSZ3VzQjJjRERlb3lOMUpvTURoQ0RKRVg2TGd2OHFTcEw2Y3lvek9keXA1?=
 =?utf-8?B?UzhVVURYTC9HdzV6Zm9ZMmoyNDVTU003ejNhdzVXTHVUd1BTQzNhT01vMmZJ?=
 =?utf-8?B?OFJVWFllWkF6MUVoaDllQW84WFNnc0lPd2ZIM1pydzdJVGgxSWljYlIycVNQ?=
 =?utf-8?B?K0lJblZDREd6L0s5QVlHRjkvME5OSHZyeW5wNXVqS3Nhei9DVUVKQjhZSC96?=
 =?utf-8?B?Y3lKSHJrSVVaQ21DazNuK21FQ1RKTFdObHUxVGdYbnNiMnNxVE9wM2JBN0tJ?=
 =?utf-8?B?MlhBZFlYSjZSUEprQTlTQVVBUlkvZ082YlJKYVY1S3hoeVdvRTZEdFdQUXlY?=
 =?utf-8?B?d1BRNUNNbi9OenBaZCtqZXViWjZDSzB4RkUxMmNUbEtzNXRrbmpCWU5IUkVV?=
 =?utf-8?B?bnJrOGhtcnNycXF4YWhIdStlZHljYjhheU1Hb3pQaEhDOXdpeDhlaXdUdjQw?=
 =?utf-8?B?UzJTbWFvOXdwNmFkb0p1d1kxU0dNemVaN1IycUt3ak1rdUFqdDZWRWlQV0dB?=
 =?utf-8?B?bndaRjdJKzhjaEJZcXg5djA3WGs5QXJlNVl5NGxPeHcxTERGZk5GdHZnMkNH?=
 =?utf-8?B?VXhlN09TNkpSTit4UVdYY3VYelVRYmlEMlk2TFg1WVNzNzc4UklhbWFLd0VH?=
 =?utf-8?B?TnFRL1Z5Zm44bkJiSGxPUnNYY3ZuZWo3SVM1ZGRQSjcxVHBZaUhSWDlnekg5?=
 =?utf-8?B?WWo4eEJnQ0E3akRDOStaNkRFRXppV0o3RkNGSHVXK3FvUVlNMTlsVHR0RTJM?=
 =?utf-8?B?VWdOQTBvRUR6aEtzQTNOUUpoT3Zjc0pZdVU4QmVVOTcyaGp5eFpxTnJacDU4?=
 =?utf-8?B?WHR4WHhIajdqbG1iWHp2OE85Z3Y1YzR5Yzh5M01HeVJmSmYvQ1BwdVRzSVJl?=
 =?utf-8?B?V3hMVzlFWHlqQk5aay9FZkljLytjV3R0Z2hYUU50TFArdEtsMHcybGZrVnh6?=
 =?utf-8?B?ODlQOEQ1VjBicnFvWnJXaUN6VnE5bFRSbXpWTmF1M1BTOGRQeUErTTlsTURK?=
 =?utf-8?B?WTVhVjY1UTRUT09sWXFXRkswajNzNm5KK2txVEhwOWNJNGZ5UERXeGw0aEhz?=
 =?utf-8?B?aXVhZm9NNVlaVndqMXdnUHN3VXpSbHJEK2VnSTNrazF2YVkrMnp4bXBoYit0?=
 =?utf-8?B?eUNwanl4OVV2bDB5SWVoM2ZaVUt0RHhTdmZwNGtZdjdxdFdva1JKSFVTQklZ?=
 =?utf-8?B?dVBid1ZiVnBEZGN0OXNwdkZxQXZKemtPeHZ1b0ZDOEVDcG54Uko2QnpiM2Z3?=
 =?utf-8?B?K0tCaWNKbDNPR21KME9vNGpMbS9LWVl1L3pWYnVveGNjcW9SYmhQZ0lTRzhz?=
 =?utf-8?B?WkR1aUFxbml4RHU5WE1heTMyMHNUMlMzMFRuYzRNSVVnMG5iL3BhMmJHQ3ZV?=
 =?utf-8?B?UGNvamxhYzhRTG1zTjBzYS82cTNHZE9rUVRJOXFTcDhxdHF2UmpFMW03cm9Q?=
 =?utf-8?B?aGdjWUJFUjZyQmFxYkhYMHFacDh4Z3lSbWl5WDZ5QXJnMHlrRzNUVXhEU0x6?=
 =?utf-8?B?SERaTWdDNE1kbHhIUXVBS3RtMldCV2NaNzZYd1VVTWI0MWZjU2dROEJzUjRQ?=
 =?utf-8?B?YXIxbkNMcm9UWlJ6WmZmamRvRFFSbGU0bit0Sm9YRVNtV2VsRzQ4aVltSm5i?=
 =?utf-8?B?azNETlIzc0lxMDFsRGY3R3lvOTd1K01YczQ3anI3VTljNWE5Tnd3TVhTQ29G?=
 =?utf-8?B?OStRSXdtVG9KK242Qkp6U2IzbE8rVkVUSFZpSmpqcGpFMHFpWVlzWEUxK0RL?=
 =?utf-8?B?c2pKVXBUUXlzYUdITzU3QllPajRoQ1JaUE9MTG9QSmZESktncFJ2RVNLbEFq?=
 =?utf-8?B?eE5TV3FLQUlaYkhjTDB6azVKNWUzV0FyVm44S2JyRjF5VkRYMG9BN0I1b0lq?=
 =?utf-8?B?Z2RpbGFBYTRBYzdoTm0wQU9DWlNMcEhhSWxkMDNzUVREUnlqdXNoNFkxY0g2?=
 =?utf-8?B?RUtDNlpSVmNmMlpybTROWGllNHdKR0h2Um1LR0NjTUNXdW9wY0p1Z0JNQnBT?=
 =?utf-8?B?VjlXZTRnVWMvRzQ3TWdoV21pSU9NaU0yUzZpRFNUTDZ4QVlqZDdYWS9YcWlM?=
 =?utf-8?B?VmJwN2NoTXhVbHVla1NHY3l6Y0NoTTI1TjRaQ2pzZnlSdWx4OUs5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0852cf89-a5cb-43b3-cee4-08df143610fb
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 21:04:15.7238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LurCr54gl7WrG4Vfa+c9lRhAJM1Jqi2tt7+GQiDDtfxOQhrh/kAcW++l4SXsLf3UV61P5kY6E2fp6u4TFcfsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
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

On 2026-09-16 11:25, Philip Yang wrote:
> When one side of UALink nodes reboots, its ring wptr resets to 0 while
> the peer keeps a stale value. Read the remote wptr and adopt it as the
> local wptr and rptr to resync, before the first message is sent. Either
> side can notice first, so do this both when setting up the connection
> and when receiving the HELLO from the peer.
>
> On the sdma path, read the wptr in a fence callback because the IB buffer
> holding the result is recycled once the fence signals, so reading it
> after dma_fence_wait_timeout() is too late. The lsdma path copies
> synchronously, so it reads the wptr directly.
>
> Take peer->lock in the callers (amdgpu_ualink_remote_interrupt and
> amdgpu_ualink_remote_shootdown) instead of in amdgpu_ualink_send_command,
> so the ring->ready check and the send are atomic against a concurrent
> ring reset.
>
> Move the rptr refresh and ring-full check out of amdgpu_ualink_send_command()
> into amdgpu_ualink_ring_check_space(), so it runs under the caller's
> peer->lock before the job is allocated.
>
> On a failed NPA-REQ send, reset the connection like the NPA-RSP timeout path
> already does, so the next attempt resyncs the ring wptr.
>
> On connection reset, amdgpu_ualink_reset_peer_rings() only clears
> ring->ready, so the writeback address is re-registered on the next send.
>
> v10:
>    - Fix the resync missed on the receiving side: after a reboot the peer
>      may send HELLO before we set up the connection, so resync the ring
>      wptr in amdgpu_ualink_process_hello_msg() too.
>
> v9:
>    - Fix the unnecessary connection reset after an app exits: the peer is
>      idle here but still busy handling NPA revokes on the remote, so the
>      HELLO reset a healthy connection. Only send it if the wptr changed.
>    - Resync both rings together under peer->lock, read both remote wptr
>      before updating either so a failed read changes nothing.
>
> v8:
>    - Fix regression with concurrent import ioctls: do the idle check and
>      ring reset in amdgpu_ualink_setup_connection() under conn_state->lock,
>      and return -EAGAIN for IN_PROGRESS/PENDING first.
>    - Reset the peer rings only, the imp/exp xarray cleanup is not needed to
>      resync wptr.
>
> v7:
>    - With v6 reboot one node of vPOD test passed on minirack.
>    - Use the per-remote imported and exported handle lists for the idle
>      check instead of walking the xarrays.
>    - Rename amdgpu_ualink_resync_peer_rings() to
>      amdgpu_ualink_reset_peer_rings(), it only clears ring->ready.
>
> v6:
>    - Check idleness per remote accelerator instead of globally, and reset
>      the stale connection at the import ioctl so the peer re-runs the
>      HELLO handshake after a reboot.
>
> v5:
>    - Resync the ring pointers at the import ioctl when the connection is
>      completely idle (no exported or imported BOs), so the first command
>      from a new application after a remote reboot/reset succeeds.
>    - Put the sdma wptr read fence callback on the stack instead of
>      allocating it; it is cancelled on timeout so it never outlives the
>      call.
>
> v4:
>    - Cancel the sdma fence callback on the wait timeout/failure path so it
>      cannot write into the caller's stack after the function returns, and
>      free the callback state in one place.
>
> v3:
>    - Resync both rings at connection setup instead of on the send path.
>    - Set the writeback rptr too, the stale value disagrees with the
>      resynced wptr until the remote FW writes it back.
>
> v2:
>    - Match the FW change: resync wptr only on the first send or after a
>      timeout, instead of checking the remote periodically.
>
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

v10 is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 339 +++++++++++++++++----
>   1 file changed, 287 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index b2c2650b0149..c0327f6854a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -56,6 +56,10 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>   					  u32 size_in_pages, u32 flush_type);
>   static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
>   static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev);
> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
> +					   u32 remote_accel_id);
> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
> +					  u32 remote_accel_id);
>   
>   #define STRIP_NPA(addr)						\
>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
> @@ -2282,11 +2286,23 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>   						generation_count);
>   	}
>   
> +	/* Peer may have rebooted. */
> +	r = amdgpu_ualink_ring_resync_ptrs(adev, sender_acc_id);
> +	if (r < 0) {
> +		dev_err(adev->dev,
> +			"HELLO: resync sender AccId %u ptrs failed %d\n",
> +			sender_acc_id, r);
> +		goto out_set_state;
> +	}
> +	if (r)
> +		amdgpu_ualink_reset_peer_rings(adev, sender_acc_id);
> +
>   	r = amdgpu_ualink_send_hello_ack_msg(adev, sender_acc_id);
>   	if (r)
>   		dev_err(adev->dev, "HELLO-ACK: send failed to remote AccId:%u\n",
>   			sender_acc_id);
>   
> +out_set_state:
>   	mutex_lock(&conn_state->lock);
>   	if (r) {
>   		conn_state->state = AMDGPU_UALINK_CONN_NOT_READY;
> @@ -2303,6 +2319,14 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
>   	mutex_unlock(&conn_state->lock);
>   }
>   
> +/* True if nothing is exported to, or imported from, this remote accelerator. */
> +static bool amdgpu_ualink_peer_idle(struct amdgpu_device *adev, u32 remote_accel_id)
> +{
> +	/* Unlocked: a racing import at worst costs one redundant ring resync. */
> +	return list_empty(&adev->ualink.imp_handles_list[remote_accel_id]) &&
> +	       list_empty(&adev->ualink.exp_handles_list[remote_accel_id]);
> +}
> +
>   static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
>   					  u32 remote_acc_id)
>   {
> @@ -2324,16 +2348,31 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
>   	 * already done by another thread.
>   	 */
>   	mutex_lock(&conn_state->lock);
> -	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) {
> -		r = 0;
> -		goto out;
> -	} else if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
> -		   conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
> +	if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
> +	    conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
>   		r = -EAGAIN;
>   		goto out;
>   	}
>   
> +	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED &&
> +	    !amdgpu_ualink_peer_idle(adev, remote_acc_id)) {
> +		r = 0;
> +		goto out;
> +	}
> +
> +	/* Peer is idle or not connected, it may have rebooted. Skip the
> +	 * handshake if the rings are still in sync, it would reset the remote.
> +	 */
> +	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_acc_id);
> +	if (r < 0)
> +		goto out;
> +	if (!r && conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED)
> +		goto out;
> +
> +	amdgpu_ualink_reset_peer_rings(adev, remote_acc_id);
> +
>   	conn_state->state = AMDGPU_UALINK_CONN_IN_PROGRESS;
> +
>   	mutex_unlock(&conn_state->lock);
>   
>   	/* Send HELLO message */
> @@ -3670,7 +3709,7 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
>   		dev_warn(adev->dev,
>   			"IMPORT: NPA-REQ send failed to remote AccId:%u\n",
>   			remote_acc_id);
> -		return r;
> +		goto reset_conn;
>   	}
>   
>   	/* Wait for the NPA_RSP to come back */
> @@ -5511,6 +5550,34 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
>   typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32 wb, u32 dw0,
>   				   u32 dw1, u32 dw2, u32 dw3);
>   
> +/*
> + * Refresh rptr from the writeback and check the ring has room for one more
> + * command. The caller must hold the peer lock.
> + *
> + * Return 0 on success or a negative error code.
> + */
> +static int amdgpu_ualink_ring_check_space(struct amdgpu_device *adev,
> +					  u32 remote_accel_id,
> +					  struct amdgpu_ualink_ring *ring,
> +					  struct amdgpu_ualink_wb *wb_cpu)
> +{
> +	ring->rptr = READ_ONCE(wb_cpu->rptr);
> +
> +	if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
> +		dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n",
> +			remote_accel_id, ring->wptr, ring->rptr);
> +		return -EFAULT;
> +	}
> +
> +	if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
> +		dev_err(adev->dev, "accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n",
> +			remote_accel_id, ring->wptr, ring->rptr);
> +		return -ENOSPC;
> +	}
> +
> +	return 0;
> +}
> +
>   static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>   				      u32 remote_accel_id,
>   				      struct amdgpu_ualink_ring *ring,
> @@ -5536,6 +5603,10 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>   
>   	peer = &remote->peer[remote_accel_id];
>   
> +	r = amdgpu_ualink_ring_check_space(adev, remote_accel_id, ring, wb_cpu);
> +	if (r)
> +		goto out;
> +
>   	/*
>   	 * 3 sdma copy commands: write data to ring buffer, update wptr, ring doorbell
>   	 *
> @@ -5552,25 +5623,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>   				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>   				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>   	if (r)
> -		return r;
> -
> -	mutex_lock(&peer->lock);
> -
> -	ring->rptr = READ_ONCE(wb_cpu->rptr);
> -
> -	if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
> -		dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n",
> -			remote_accel_id, ring->wptr, ring->rptr);
> -		r = -EFAULT;
> -		goto unlock_free;
> -	}
> -
> -	if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
> -		dev_err(adev->dev, "accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n",
> -			remote_accel_id, ring->wptr, ring->rptr);
> -		r = -ENOSPC;
> -		goto unlock_free;
> -	}
> +		goto out;
>   
>   	ib = &job->ibs[0];
>   	src = ib->gpu_addr + ndw_copy_cmd * 4;
> @@ -5628,12 +5681,11 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>   			dev_dbg(adev->dev,
>   				"remote %u lsdma copy failed (r %d), skip completion wait\n",
>   				remote_accel_id, r);
> -			mutex_unlock(&peer->lock);
>   			return r;
>   		}
>   
>   		goto out_wait_complete;
> -        }
> +	}
>   
>   	sdma_ring = &adev->sdma.instance[0].ring;
>   
> @@ -5664,12 +5716,9 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>   	if (r <= 0) {
>   		dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
>   			remote_accel_id, r);
> -
>   		if (r == 0)
>   			r = -ETIME;
> -
> -		mutex_unlock(&peer->lock);
> -		return r;
> +		goto out;
>   	}
>   
>   out_wait_complete:
> @@ -5678,21 +5727,15 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>   	 */
>   	r = amdgpu_ualink_remote_wait_timeout(adev, remote_accel_id, wb_cpu, seq);
>   
> -	/* increase local copy ring wptr, only if FW not timeout */
> -	if (r != -ETIME)
> -		ring->wptr++;
> -
>   	/*
> -	 * Release ring lock after the remote FW handle command completes to
> -	 * prevent race conditions.
> +	 * Advance wptr unless the remote timed out, even if the FW returned an
> +	 * error status. On timeout the caller resets the connection, which
> +	 * resyncs wptr from the remote in amdgpu_ualink_setup_connection.
>   	 */
> -	mutex_unlock(&peer->lock);
> -	return r;
> -
> +	if (r != -ETIME)
> +		ring->wptr++;
>   
> -unlock_free:
> -	mutex_unlock(&peer->lock);
> -	amdgpu_job_free(job);
> +out:
>   	dev_dbg(adev->dev, "ret r = %d\n", r);
>   	return r;
>   }
> @@ -5732,6 +5775,192 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   		remote_accel_id, npa + offset);
>   }
>   
> +struct amdgpu_ualink_wptr_fence_cb {
> +	struct dma_fence_cb base;
> +	u64 *wptr_cpu;
> +	u64 result;
> +};
> +
> +static void amdgpu_ualink_read_wptr_fence_cb(struct dma_fence *fence,
> +					     struct dma_fence_cb *cb)
> +{
> +	struct amdgpu_ualink_wptr_fence_cb *wptr_cb;
> +
> +	wptr_cb = container_of(cb, typeof(*wptr_cb), base);
> +	wptr_cb->result = *wptr_cb->wptr_cpu;
> +}
> +
> +static int amdgpu_ualink_read_remote_wptr(struct amdgpu_device *adev,
> +					  u32 remote_accel_id,
> +					  struct amdgpu_ualink_ring *ring,
> +					  u64 *wptr)
> +{
> +	struct amdgpu_ualink_remote *remote = to_remote(adev);
> +	struct amdgpu_ualink_peer *peer = &remote->peer[remote_accel_id];
> +	struct amdgpu_ualink_wptr_fence_cb wptr_cb = { };
> +	struct amdgpu_ring *sdma_ring;
> +	struct dma_fence *fence;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
> +	u32 ndw, ndw_copy_cmd;
> +	u64 wptr_gpu, *wptr_cpu;
> +	int r = 0;
> +
> +	*wptr = 0;
> +
> +	/* 1 sdma copy command to read wptr */
> +	ndw_copy_cmd = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> +
> +	/* wptr 2 dwords */
> +	ndw = ndw_copy_cmd + 2;
> +	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
> +				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
> +	if (r)
> +		return r;
> +
> +	ib = &job->ibs[0];
> +	wptr_gpu = ib->gpu_addr + ndw_copy_cmd * 4;
> +	wptr_cpu = (u64 *)(ib->ptr + ndw_copy_cmd);
> +
> +	dev_dbg(adev->dev, "read wptr from remote %u npa gart wptr 0x%llx use %s\n",
> +		remote_accel_id, ring->wptr_npa_gart,
> +		remote->use_lsdma ? "lsdma" : "sdma");
> +
> +	if (remote->use_lsdma) {
> +		r = amdgpu_lsdma_copy_mem(adev, ring->wptr_npa_gart, wptr_gpu, 8);
> +		if (!r)
> +			*wptr = *wptr_cpu;
> +		amdgpu_job_free(job);
> +		goto out;
> +	}
> +
> +	wptr_cb.wptr_cpu = wptr_cpu;
> +
> +	amdgpu_emit_copy_buffer(adev, ib, ring->wptr_npa_gart, wptr_gpu, 8, 0);
> +
> +	sdma_ring = &adev->sdma.instance[0].ring;
> +	amdgpu_ring_pad_ib(sdma_ring, ib);
> +	WARN_ON(ib->length_dw > ndw_copy_cmd);
> +
> +	fence = amdgpu_job_submit(job);
> +
> +	r = dma_fence_add_callback(fence, &wptr_cb.base,
> +				   amdgpu_ualink_read_wptr_fence_cb);
> +	if (r == -ENOENT) {
> +		/* Fence already signaled; the callback won't run, do it inline. */
> +		amdgpu_ualink_read_wptr_fence_cb(fence, &wptr_cb.base);
> +		r = 0;
> +		goto out_put_fence;
> +	} else if (r) {
> +		/* -EINVAL: NULL fence or func, not expected here. */
> +		goto out_put_fence;
> +	}
> +
> +	r = dma_fence_wait_timeout(fence, false, AMDGPU_FENCE_JIFFIES_TIMEOUT);
> +	if (r > 0) {
> +		r = 0;	/* read wptr successfully */
> +		goto out_put_fence;
> +	}
> +
> +	dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
> +		remote_accel_id, r);
> +
> +	if (r == 0)
> +		r = -ETIME;
> +
> +	/*
> +	 * Timed out: the callback is still armed and wptr_cb is on our stack.
> +	 * Cancel it so it can't fire after we return and write into the freed
> +	 * stack frame.
> +	 */
> +	dma_fence_remove_callback(fence, &wptr_cb.base);
> +
> +out_put_fence:
> +	if (!r)
> +		*wptr = wptr_cb.result;
> +	dma_fence_put(fence);
> +
> +out:
> +	dev_dbg(adev->dev, "remote %u wptr 0x%llx return %d\n",
> +		remote_accel_id, *wptr, r);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_ualink_ring_resync_ptrs - sync local ring pointers from remote
> + * @adev: amdgpu device pointer
> + * @remote_accel_id: remote accelerator ID
> + *
> + * After a reboot on either side the two ends disagree on wptr. Read the remote
> + * wptr of both peer rings and adopt it as the local wptr and rptr.
> + *
> + * Return 0 if both rings already match, 1 if they were resynced, or a negative
> + * error code if a remote read failed, leaving the rings untouched.
> + */
> +static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
> +					  u32 remote_accel_id)
> +{
> +	struct amdgpu_ualink_peer *peer = &to_remote(adev)->peer[remote_accel_id];
> +	struct amdgpu_ualink_wb *int_wb, *tlb_wb;
> +	u64 int_wptr, tlb_wptr;
> +	int r;
> +
> +	/* ring->wptr and ring->rptr are owned by the send path. */
> +	guard(mutex)(&peer->lock);
> +
> +	/* Read both before updating either, so a failure changes nothing. */
> +	r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
> +					   &peer->interrupt, &int_wptr);
> +	if (!r)
> +		r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
> +						   &peer->shootdown, &tlb_wptr);
> +	if (r) {
> +		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
> +			ualink_accel_id(adev), remote_accel_id, r);
> +		return r;
> +	}
> +
> +	if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr == tlb_wptr) {
> +		dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n",
> +			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
> +		return 0;
> +	}
> +
> +	dev_dbg(adev->dev,
> +		"accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n",
> +		ualink_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
> +		remote_accel_id, int_wptr, tlb_wptr);
> +
> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
> +				  RB_TYPE_REMOTE_INTERRUPT);
> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
> +				  RB_TYPE_TLB_INV);
> +
> +	peer->interrupt.wptr = int_wptr;
> +	peer->interrupt.rptr = int_wptr;
> +	peer->shootdown.wptr = tlb_wptr;
> +	peer->shootdown.rptr = tlb_wptr;
> +
> +	/* Drop the stale writeback rptr, it disagrees with the resynced wptr. */
> +	WRITE_ONCE(int_wb->rptr, int_wptr);
> +	WRITE_ONCE(tlb_wb->rptr, tlb_wptr);
> +	return 1;
> +}
> +
> +static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
> +					   u32 remote_accel_id)
> +{
> +	struct amdgpu_ualink_peer *peer = &to_remote(adev)->peer[remote_accel_id];
> +
> +	dev_dbg(adev->dev, "remote accel_id %u\n", remote_accel_id);
> +
> +	guard(mutex)(&peer->lock);
> +
> +	peer->interrupt.ready = false;
> +	peer->shootdown.ready = false;
> +}
> +
>   static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
>   					   u32 remote_accel_id, u32 ring_type)
>   {
> @@ -5794,6 +6023,9 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>   
>   	peer = &remote->peer[remote_accel_id];
>   	ring = &peer->shootdown;
> +
> +	guard(mutex)(&peer->lock);
> +
>   	if (!ring->ready) {
>   		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
>   		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
> @@ -5802,11 +6034,11 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
>   			return r;
>   	}
>   
> -	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
> -				       amdgpu_ualink_emit_shootdown,
> -				       flush_type, upper_32_bits(addr),
> -				       lower_32_bits(addr), size_in_pages);
> -	return r;
> +	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
> +					  ring->wb_cpu,
> +					  amdgpu_ualink_emit_shootdown,
> +					  flush_type, upper_32_bits(addr),
> +					  lower_32_bits(addr), size_in_pages);
>   }
>   
>   /**
> @@ -5835,6 +6067,9 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>   
>   	peer = &remote->peer[remote_accel_id];
>   	ring = &peer->interrupt;
> +
> +	guard(mutex)(&peer->lock);
> +
>   	if (!ring->ready) {
>   		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
>   		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
> @@ -5843,10 +6078,10 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>   			return r;
>   	}
>   
> -	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
> -				       amdgpu_ualink_emit_interrupt,
> -				       dw0, dw1, dw2, dw3);
> -	return r;
> +	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
> +					  ring->wb_cpu,
> +					  amdgpu_ualink_emit_interrupt,
> +					  dw0, dw1, dw2, dw3);
>   }
>   
>   /**
