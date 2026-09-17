Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94489C982CC
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 01:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61DD10E03A;
	Thu, 17 Sep 2026 01:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7kaD7go";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0FF10E03A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 01:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gw4NxUM7l5mxX2PuYt4VPkBf7lkLHH812zJyRmV5UhM4Cc4RnZ18MpK1OLeZngttl2CxtPP4G1pqWr0592Y+82GpIU5fNhnlHxuKSdMEO0G6VrHXzItbBcou0B0d/xKs7wVJrwi1ah7rGbjubCuuP5AUwYeYt/fplu1b3raFnmFGED5OXIPcFpKwHJWTn5hPhtx8vcD8rqdJRUgiSJHvGdvINMavfyf4zdt8kJ0CrVCR/05yPqaRgl39DOxl0U5zuF2Ly+b27j3TZ5kQFx0Ynop7Vgo0/qmCxrEClplDdk6WKVxzbEscryUy5dWw19MxwPcKuO8qwNdFeW9p+h3mMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5wQD8C2MayMUiZaJclzAMUp4AsYnYPIFnf7ZPBHvVE=;
 b=cMZ1m3DLJRLh/cn/FmlLTwcX4cEyZ6aB94zPca0jR5ROr+9bH/kkgYJOVowbqtlxSY4du5ng7BNpAde8ke2mmaAk0GnxBh8y6GBX9g4I3YRcfVECxLi0eZ56JqDWQYUL+s2gx2PU4lCIXI2WSgA/QIqwo+WdS2fnwb23HeFMc7Z1rz7YvIih5QPcszLSZcYU5G+0lTDs3AHqmwMDmNOJ0gp51rUZWg2bzhXc9FpYkl7alvL/kLOvn7xPcJ6o+n90osLysSazrMSBajLRnJ2pHUye3Ba9p6YSNfv3g3gE+qCCZ5u/F4EVfSG7dF+XKpLF/Jtc6EGUoIdyIvVz9MA05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5wQD8C2MayMUiZaJclzAMUp4AsYnYPIFnf7ZPBHvVE=;
 b=m7kaD7goNpcQZB/Y3u8KnbuGNoM936yg3sZXi+ZzcLQ/k43xwTdlzvJSq3axT7tnw/vbad8YydLmn/nFuVwXJe+AUyVw5EeG57iF1t0vTIIvDigNZoMZeZwT2oJvYlHDn+VW2u9dNHNA0h26GdeipTAAeo07I15fEWTiU3UpJ40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by CY8PR12MB7290.namprd12.prod.outlook.com
 (2603:10b6:930:55::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 01:33:37 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 01:33:37 +0000
Content-Type: multipart/alternative;
 boundary="------------u9qMDGza1eIwHzG04yHxmgtg"
Message-ID: <b6349b6d-0357-4850-8957-6d2d17649a05@amd.com>
Date: Wed, 16 Sep 2026 21:33:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] drm/amdgpu: Resync UALink ring wptr after reboot
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com
References: <20260916152528.3918848-1-Philip.Yang@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20260916152528.3918848-1-Philip.Yang@amd.com>
X-ClientProxiedBy: YT1PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::18) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d44e756-0a90-42cd-9873-08df145bb1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|3023799007|11063799006|5023799004|56012099006|8096899003|10067099003;
X-Microsoft-Antispam-Message-Info: +sndLHbM1A17i4LYbLV5z4kEBoTIHqjhpglygvDuf/YIqCQGgw6C06waEuF6tRUqAmGmzl31B5rOISr2/wTelHBJp8c20uCuYh9Vw1DhEKpPDqm8/aWARyW8J292p8nVXG/ODq8/n3L0yfwIKMXloN7Flyx5Xhcfuw7Jde0RYoAsxgep4H3QECcASWG8CDQZHCHKfa9MdpmYsRUDwBlO3Gq/Njhmyt09SEk8dilPncBaLwj0N5hUcpzAo+Vp/kEE2YsVM5e+RCVFg/MGfeyoGFWUmwmksZjLk6hSjeaqk7rAiMzOli7nz/wsBLyLMlktzGlVkuVqfHUT3zIkKdK8mg3tO+ftWhc6W8b0Ty+Tfg8iphxw+eEC0x2k42cfYn54EXRSLPTtlf9GljjsWyg3XtyAu9p7PmaywhJrJe+bbgTH7EFUAaab6H6HfX+bRSWWsVlx7hsilZTUM6Z71HaSfmhxYUZifrAbcal7Sh3PiCiTG4OG/ILvY0ELAer8fLbpv5FYtQevEc9dcSNIT8ktv+763wW2iAIiWBJZDxRM4Vu187WBmtfJhmf5P0VhBa2rxVyUdeFgoGCGiBGubRhvzSn2UskHbY0wYUoZpBYBYxLYRayMs9vN+sGK0q+pOVov8v7bEPTrnQs9lvvgniEh4TTGi6hUKNiBp0PzLRkyfLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(5023799004)(56012099006)(8096899003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBEVHdGdzhqc3hUekZUUGN4UHVZQ1h5WFJreE9qbHRaMGliM0ZhVElWdnNs?=
 =?utf-8?B?Zk1SNlBsNzNVcWcvcUdRWlJCeGF3M2NQWlZ3S05lRlVleEtVVkI4ZUxpcnZo?=
 =?utf-8?B?Y3g1Q0RQYmc0NWVXY0RlVGJMYVByeFFIUTZKYnkrVU5FWVlaRWwycjdQM1JE?=
 =?utf-8?B?M3QzTEZuLzhueE1FaWR5ZVJ1NTRMbjFtU1A1MHlGbTFPM0ZuK091Y2NIOEJv?=
 =?utf-8?B?WWhldGhCak4zQ3l3Z25HMXpleUs3S3hFTjFFVk1yTTVVQTN0VkZVVVhDdU5C?=
 =?utf-8?B?WmtlZm83NkdRYWpYaDZpL2FGMHlIQ2gyb25wWHl5Q2lPRVZFaVJXMjFsU04w?=
 =?utf-8?B?TTg3MmM3S2FPa3JMNnNLeUhYTUZNWkZrYnpXUTJRZGd4UkZVUFBFcTFTWXg2?=
 =?utf-8?B?dC8rc3pOZS8xVlJtVHlNWmxsWFBBM1k2cWtoVHpScGl3ZGZPN1Y0aUJINXdn?=
 =?utf-8?B?VGhHVEVEL0V6a2Q4OE03U2dsaDVuS2w3RW9CMGxjK0MxdHVDcGpFZ2FxeHA5?=
 =?utf-8?B?cG1LQW1yWXlwRTVBbEVYVjNsamlUYWV2L2ZOUEJ0NXJxdXZQUDMyNFV3MmZV?=
 =?utf-8?B?RHB5MHIzOEVRTW5aYnB0czIxbXVaSEFwRm41K2JINXhLT1JxODV1RklUSlJm?=
 =?utf-8?B?d2RPWW96dFoxZG0vajhNM2hRcmJPb1ZJSnE4Q2ZMaHk2V1l5WnE5aWl0Zng3?=
 =?utf-8?B?MFpuT2lFZmhwUktNMERmQzhNT2Y5Uk9uWDVLN2s3djJkeFJ3eTFUTWVkaTRu?=
 =?utf-8?B?MnFyVDZ0MEk3RUhjRWpxTG9RL2RqL2trT2EyUGlmZUtlTklZRWdTSGxYeFcv?=
 =?utf-8?B?S0dJaDhxQXIxbklNTzRZRVUxUjc2Q1cwSjVNQmcwN2hsWkFYWXNVb0V6Qnhm?=
 =?utf-8?B?b3p5TkZFMDhBMDM4YUZ0eFV6TDErelEwQnE2YTlocDdnRUVFdlcweVBtM1pL?=
 =?utf-8?B?S3hwYXhPazREeHIvRHFieVZwRUdaNnRFQitmUEFITDdOZkQ1WkpnWkE5R1cy?=
 =?utf-8?B?SkxDbWlYUklhZGJFdlJmVlFVbmhNaGNNQ2hXeFpreEdQNDlxSGxwSUJUTUlJ?=
 =?utf-8?B?TXEwZHRUWmxIRDc0WkR4L1dXd2NZeFB6SjBEdGNrY3AzdVovYWxnU1hpQ1V2?=
 =?utf-8?B?YzR2U3NVV083Y3FRdmdVL0ZVejB1RUFYSjJST05ZY2pXWlZ1TXV3QnVzaWpC?=
 =?utf-8?B?OVFFNjZmOHZ0ZmNPaUJDcCt0YWFSeFVTSzVQa2tSZEpQQXkwRUtJeGNsbEhD?=
 =?utf-8?B?bW0yRDhaajQxQjlLc0Jxa1BxbzVxSDM0UDQ2RzdjcDFQb2dnZEsvb1FyYVFw?=
 =?utf-8?B?Yk9mODUwT2p3d21uUmlkelpScTdjdVJiQ0dPUHI4eldLM2pyYmd2YW5QUDA0?=
 =?utf-8?B?VGdkcDl1SVZBb2dJTDA1UHczNDdtWmZKK1NPMkJJNytTWEFmRGZ6ZTlsY2h2?=
 =?utf-8?B?Sm5xN1dnYXdEeG5vUzZJK3Iybmh5MFdRdDFxSUltRCtwd3VWREVhcXh4M01P?=
 =?utf-8?B?T0JhQlhCVmgxbGNpdkdNaG5FclA1MjdQOVVqWklteW5mb0pKVHVLVS9ubHI3?=
 =?utf-8?B?THVIU2hzREpESC9VODFHc2xvWVBmU1hjRUxVWXd3d25TdS95aXRQVkpTVU45?=
 =?utf-8?B?VFUvRDZWbDcxdlJqY0ZNWlowaHpWMm91cFMxeENmT2dhZTFxTjBoMjY3d0Ny?=
 =?utf-8?B?SlpOZC9TTmo5bHk2MlNMOVpuQzUxM0tBMW9tVExQYW9CRVFaSHZnRENGN1ZI?=
 =?utf-8?B?Yk1VdkFxNGtvdHNDUzJFa3VtZG54RVFUbVpZa3VaNElRTlJ5OE10UHg5WUZl?=
 =?utf-8?B?QjZ6MGlmWnBxSDZhamdrbTZldVYveWpqR3pzL25vZ05LM0NsaXg3T3o5OVdr?=
 =?utf-8?B?V0dVM0wxVENFWVFDQWJHcmE1KytwTzk4cytzTy9ZM05PNWdYYThZZm5kV0Y0?=
 =?utf-8?B?VmxydG1NM2dZRnZ3WW9QcVVxOUlFM1VETUF3T2h4aTdrcURzNlBLYjZBc003?=
 =?utf-8?B?cERyNTg5VWhTSFhneVVvM0V1UHprSjJ0N3NKMXZQZjIvN3VQdm5NS2JuUWFN?=
 =?utf-8?B?b2ZlZXlmT3lEWnJ3RTZOamI4b0hTZk1nVGo2NERjU0pHSmg0dTJ3d1JPMVpL?=
 =?utf-8?B?a2N2VG5yZ21pVkIyYnp5T2pOQVhTenVBVWVkYVRoQlg5Nk40Z3FXanNiZjJV?=
 =?utf-8?B?TDR1YnEyRjhzdkk4Y3psa3lMRkhZbVRKODZqRzVDazZuQmtwRUFxcnJRVko0?=
 =?utf-8?B?UG1yWDBEWTUvRWQ3Q3BmdGFQZGZoR3k3Y0puV3RkVTF1QnROWExkRXZ2ZVBN?=
 =?utf-8?B?RUQ3UTJGY0hiT2J5KzM4R2RyVSszMUROMHpWVHN4TUlYYTdwVU9QUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d44e756-0a90-42cd-9873-08df145bb1e0
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 01:33:37.0577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9mguD+VKhdSxFJ1UUspq/rnQv7nDNA4O0gsRbX3Zp932geib446QETpdIxkQVoNFSMR/IKdff9eBffAOlWpWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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

--------------u9qMDGza1eIwHzG04yHxmgtg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/16/2026 11:25 AM, Philip Yang wrote:
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
> Suggested-by: Felix Kuehling<felix.kuehling@amd.com>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
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
Minor nitpick here.

Maybe we should check here that the accelerator state is still active 
similar to what we are doing in

amdgpu_ualink_send_command().

Other than that, this patch is:

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

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
--------------u9qMDGza1eIwHzG04yHxmgtg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
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

Suggested-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
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
    <p>amdgpu_ualink_send_command().</p>
    <p>Other than that, this patch is:</p>
    <p>Reviewed-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a></p>
    <blockquote type="cite" cite="mid:20260916152528.3918848-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	*wptr = 0;
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
  </body>
</html>

--------------u9qMDGza1eIwHzG04yHxmgtg--
