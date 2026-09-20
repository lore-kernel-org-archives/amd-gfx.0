Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3D5C982D8
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Sep 2026 19:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7CA10E08E;
	Sun, 20 Sep 2026 19:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pBgFb0tZ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7515F10E295
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Sep 2026 19:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quDtNSe63T1qXwOikGFoCL83U17gCsdmDP5bmsSMcpBJM/JM4D4Tc9hLCv4BF3sReW8pGSd+dp6CQLC8WxAqj+IgpVhNzRHxX2apMQ0Q3HFbwbFZQKKbKXkMmX59LrItiIiVffq8bUTwQH/2W8IHXkylCVqCTogq+N3RbtRKnf+3aPP+vyWEB58+4kwcElaI7H5DQHLU+lLLtAAqEg3hwe7aALGWMEXochYaOae6dMsIfAF/vwA7IVR2CWBzE2Kc38KQ76IcBhz41AYnmLlYKHrSHpBBIwnQlpniT+7BpU81C1K7ghed5kUJoWGNxd/jW0aWGmUPwHZ7pr2+9Di0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZohFzozRhhQpB1abzqVxAQL8wA7UjEARA8XyFfa91M=;
 b=b4vAhN/vaziehstBzk/9dNhIiq/c+UK1E8YhLhx7fr4zs3RG6dQhh00vDLSruBvUvG1dWvbJVczVgWk06ga1JtJxiBpMZZz+NCy1wfqVxcHL/9axAPdR8WN0IeB7ujNIZ9pGRbTuPBJgfRz1DhDdelVP9t6S5eKrd/gzfMlzKFd9kwDtQrplms+IpurGJ0WS2o0GXjR0Ufd5skcOhtjQNsVQ9bFlKmRC1CZWKxLqWzMMxv3j13tBNsIVPMNmJ11gPyfaixT102JHF2iD4J0otYBfoqHNOXc918HtvUic8JVx3uNp5tHQV2kvTq9XcR0GptFX5I0Yhwt3hBdlCYtBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZohFzozRhhQpB1abzqVxAQL8wA7UjEARA8XyFfa91M=;
 b=pBgFb0tZU3KE0muSa+7R6gZA/F9D2/x7tBhPL/a0xGBPHjhBkicO5u07On17QqUf/VAnGvq4kp4bqQySsENyXzJLCYzXVh5Oqh0zHrqmNWuNeX14KTgQ8AY4qcE+QVevD479TgC8ro6jRe3CopHhsM7ue2/piZP3wPJJTXMkSVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by MN6PR12MB8566.namprd12.prod.outlook.com
 (2603:10b6:208:47c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sun, 20 Sep
 2026 19:26:08 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0428.015; Sun, 20 Sep 2026
 19:26:08 +0000
Content-Type: multipart/alternative;
 boundary="------------J10Mw9JKkZhPPtHAbiVcz0pm"
Message-ID: <c53c20a7-9d4b-44e1-8e38-4b4b32d539c6@amd.com>
Date: Sun, 20 Sep 2026 15:26:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhang, Horatio" <Hongkun.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Ma, Le" <Le.Ma@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260917100430.217954-1-hongkun.zhang@amd.com>
 <MN0PR12MB576143F1D159DB5DF1C1018CF7852@MN0PR12MB5761.namprd12.prod.outlook.com>
 <BN7PPFFF39339DDA5A38FD4F0358D122C45FC852@BN7PPFFF39339DD.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <BN7PPFFF39339DDA5A38FD4F0358D122C45FC852@BN7PPFFF39339DD.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0391.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::9) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe1024b-1772-44bd-677a-08df174d0552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: /L/yFCTDWwFsBZRq3BBT3VsnzJG+JfsL4VkJI0VIkySToLZgf+cgsHJ4ITzYeN+8nS33CL3vgKkGFeemxho1+6u90FuzGC0LtRK8M1fj3+rz8UUpi6ZFF8Pr23+gNjRTBE5OOfRHXZNDC42NNfCw7VGdxIeXOIGi/pRrMGMDadKUENTyss+i8DQgkw/x1IPVxGCD2Lw3F0eXBgB+d/W7GqCzcs5WK1McV0S0jyt2s4yOV8DMdgdgJ6AocoDM82XuogdmUbEAqwiBKhi5E3lKV68Vyp/phKzCQCh5G8wypQMWZtWdPnkBk2Z47PUCYYWQdqpKt64CR5KNoIapfnJf83UPE+pO2bnsUCzVCBrdfPw1+34/eBLpCFKVBGPQdZSyb9rtjTqrE3u1U68Xk9DSrecmWtnB02sM0+rIJQCu/8VWKe7xLEdqL+a14VavcwwSUHwhd27zhE8KHMhjIStIx4/wJSioDXVFACj5Cf0zJUiEKgNowC+JGqyEG4unCecmgWyItI7iQ71aKhQAT9kppp6vVkyHelzliVi8wXnch2Xomf6MWybWf6EYCfAoiU38zJlvt6Lb4tbcJa3Bs6a9PzB88oL8sR918JXz/fNkcWTjrRQGrU2dfgAd0z6w0kTLlwHyZFxJmafWS4grQ2tYYjwxHoSpXYdiQI4F8lzOFgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHZ0WS9UMEtlZ1Z0L0ZoWHNXcS8zNTVwc0VvUTFiRTIwOWt3WGZQTkt1djRM?=
 =?utf-8?B?Mjd0M2ljeC9qTWRhKzR6K3J3NXI3M1JWYVMxbnVhQW96dWpxR05id3BLOGI5?=
 =?utf-8?B?eVhBbzdhK0E2R2pLTUFUcHA2YVRzVFNVS29yRkVOOGM5WXhsUFVMZUdwUVZ3?=
 =?utf-8?B?ZGFJTDh2L1B3ZkRxMnJnUlpJdFRTV1lDSmltS3VXeDZISU02YWM5c0NyWmVE?=
 =?utf-8?B?bmE0c3ZFTXJrZzVzek5nNDE2Sk5ITVBvbEcyWldmVW8zbHhNQklJdVJQL2gx?=
 =?utf-8?B?Z1VKdk1UM3FrZWRWNGd1K2ZXcWtiTHNxMXR3dStjNjNpSndVRnByaHJnSVZY?=
 =?utf-8?B?UWRSemZxUGtnTC9BcHFGTUtvbjBNZkVVR25yaThNZVNYbzBUQk9DZWlLbmNq?=
 =?utf-8?B?UnFpM3RPeWN6bmpadFBPTis3dE96QUJseG4xL20vWmRraG5JcEQ4eHdkY2li?=
 =?utf-8?B?M2IwU0R5UHRuY0htQVRnOGROSkNjcFhYRGR1eGhxYnFzelRoNnNad3hMYzN3?=
 =?utf-8?B?UUs2aXBYS0Q4MUE0Q29NRzlPNlVqWXUxeTJ2b2VScXBMU1oyOU1ldnVTNVph?=
 =?utf-8?B?Nm1OdXlhVzVQbk1PRzVXSGgvZzYzTWVxWU1ZMDRyNHp3K1Q5K2FYdW4reWZQ?=
 =?utf-8?B?VmpFdkpWcit6UFRibE9wOHhpU053NlZLd25XWEIvUnowMm9SaHphOVh1S1lk?=
 =?utf-8?B?a05YSnpDd3BzbFVKdGY2TWQ3YlVaV21ZU0FYMThqR0V6NGRDRlM3RWE2K1Y0?=
 =?utf-8?B?MVJ5VzBDeFdyOGlac3d0TVJwMVNhcGkvYlBybEJIdHFIQlZYZGdJejRHalJW?=
 =?utf-8?B?cC9VNTUrNlZraEdPWWlkclpnVXpqSDRva0U3VWRaVWxDZk1QeW0xS2UzWHVN?=
 =?utf-8?B?QjJUdUxsOVF2alJGR3ZvenhrZ0haT3dNdTIwRHpUdFBSbmhycDJTelBJTUNh?=
 =?utf-8?B?OFhHeldicmRNRUpLVUVpOHpWYmZWK1p5a0hPS0t0WEpZRmF3K0IxTDdWOHJ3?=
 =?utf-8?B?b3lWN3p2dU1lS25aOFQ2aWpQYnJ4Q1JLT3R1VkdrM2ViMWlzZCtmVGFsbjJP?=
 =?utf-8?B?SUh0cWtnSWUrYkhPNDM4dEcya291a1ozRFZJR1JMemZCN1dEaHlXZlc0dUEw?=
 =?utf-8?B?czZDaW5lc2JqWUtJdHNDaUdzS25tUHQ5NUMvblEvQjBFSTVyYk1hdjMzNXJK?=
 =?utf-8?B?cWlJSGZZRkdXKy9oTU4wdTNEdlM0dHVuVVltc1NBeUVVeWxReUdRbDYxYlQw?=
 =?utf-8?B?YWVMSkVPMXFsUDF4Q21OSzVKbkNxSHNwNWpBOThvVkRwckJoUFZ1RWJPeW5s?=
 =?utf-8?B?N2ZIU01vck9KRUtWRGh6RWEwUHF3aEJLU0VnbE5saGdtam1nQU03em83SktH?=
 =?utf-8?B?T29tTXZCdHZvaWtRSzBQQVB3Ym4zYnJXdlBFN2pmY0hvQ1puU3lDWFN5L1Zy?=
 =?utf-8?B?RnBWZ2M1bjl1WXBEa2MwZUlsTG1uZDlKaEhVNTllNTltSFBXckVKM1BZZXJw?=
 =?utf-8?B?TS9yK2kwVkR2TEdwVmxvaWZrRWZ6RlBUYnJaOVZDUDV2NHczbktVNnlCYUUz?=
 =?utf-8?B?ZFZwSmR1Nm9xaWNRaEczeC8zUHhPR3psaFZjK0RLR3JZNWRydmUxZ3RIWGhR?=
 =?utf-8?B?NlhtSVJvWld6VW0waVNQVWIwRlJGeHBrNmxTQXRiUUtwZFR1bXo1TEVlT3oy?=
 =?utf-8?B?VUZmanczQWNlaHZFSWdzbXhhd3NaQmVqZHhWb01WWjVLd3pETVFzbmRvOVlR?=
 =?utf-8?B?UUgxdzNwcUhNdE9ZRmR3QkpBeGlZWFVucFBaaWRBZ01RWXBXT2dUTWVJZzh5?=
 =?utf-8?B?dHcyYzhmbUdVZ014UXJjNFhjdzV3YUZWUkU3M1lZQ3o0WGtMcjhxUWxqOWph?=
 =?utf-8?B?V3BuM1FCL0NkL0hjTmlsdnYxaXZKL01xYmNmK0RFaWk2MXZpSkwyYzhxRS9o?=
 =?utf-8?B?NU11MGVmYTFlTmUwdm5KMXRmMzBNeDU5YmN5bXBaZGhkemk1c0kxUC93bGpV?=
 =?utf-8?B?aWxiODB2aDBOMldBK0hsYzFCcDlUanlYT2x3VWY1T1dkOHdJRFNna0xNY0dy?=
 =?utf-8?B?NHVVdHh2RzI3emM1SDFGWktTTlBldVIvOUhYZGYvYk1NbWxSdHAzWVNBRWlV?=
 =?utf-8?B?c0J0YTgxa1FqMmplUlVTVURVOTlvMzFzWW80YWdJWUVpQXpmaGhrSGdJbStZ?=
 =?utf-8?B?OHNITnBWYmhFQ2VoQjRGRGxGay9ZYjlWcmtpVzcwYnQ1YkdNVG1NSTdVU0RV?=
 =?utf-8?B?enFMUVJTVHo3WkZ3YTkrdnZoanpyR1FtMG9yMzVKangwYTFQa1UrSUplK1JQ?=
 =?utf-8?Q?X2pqXHfdIO+RKNyAiD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe1024b-1772-44bd-677a-08df174d0552
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 19:26:08.1219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXO4PsXbhb+miR3OYZLA2J6mNd4Kmo8zH7o+CpBVWTNtvhPnrcS+fX+6s/rOyY09BihhN0RxibatFwJQMucokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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

--------------J10Mw9JKkZhPPtHAbiVcz0pm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Regardless of SDMA userq support, this patch still looks reasonable to 
me. The TLB fence doesn't make sense for NPA VMs. We handle TLB flushes 
for NPA page table updates explicitly in the amdgpu_ualink code.

Feel free to submit this patch with

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


On 2026-09-20 10:41, Zhang, Hawking wrote:
> AMD General
>
> Hi @Zhang, Horatio <mailto:Hongkun.Zhang@amd.com>,
> I think the issue is caused by the following code in 
> sdma_v7_1_sw_init, which incorrectly marks amdgpu user queues as 
> enabled for SDMA 7.1 as long as the CONFIG_DRM_AMDGPU_NAVI3X_USERQ is 
> enabled.
> Since SDMA 7.1 does not amdgpu user queues (it only supports rocm user 
> queues), could you please remove this code and check whether the issue 
> still occurs?
> #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
> #endif
> Regards,
> Hawking
> -----Original Message-----
> From: Zhang, Horatio <Hongkun.Zhang@amd.com>
> Sent: Sunday, September 20, 2026 5:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; 
> Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul 
> <Mukul.Joshi@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: skip the PASID TLB fence for the 
> UALink NPA VM
> AMD General
> Gentle Ping ...
> Best regards,
> Horatio
> -----Original Message-----
> From: Horatio Zhang <hongkun.zhang@amd.com>
> Sent: Thursday, September 17, 2026 6:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; 
> Zhang, Horatio <Hongkun.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: skip the PASID TLB fence for the UALink 
> NPA VM
> amdgpu_vm_make_npa() builds the UALink NPA VM on top of 
> amdgpu_vm_make_compute(), which unconditionally sets need_tlb_fence.
> That flag makes amdgpu_vm_tlb_flush() queue an asynchronous PASID 
> based TLB invalidation after every page table update.
> The NPA VM is created by the driver itself in
> amdgpu_ualink_manager_start() and never gets a PASID assigned, so
> vm->pasid stays 0, which MES cannot resolve on the MMHUB. The
> vm->invalidation
> never completes and MES stays unresponsive for the rest of the probe:
>   amdgpu: MES(0, 0) failed to respond to msg=INVALIDATE_TLBS
> The invalidation is not needed in the first place. An NPA VM is bound 
> to the reserved NPA VMID and amdgpu_ualink_flush_tlb() already 
> invalidates that VMID on the MMHUB after every mapping change. Clear 
> need_tlb_fence for NPA VMs.
> Fixes: aac13f6eded6 ("drm/amdgpu: Pin page tables in NPA VMs")
> Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
> ---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
> 1 file changed, 1 insertion(+)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 68d668dfe4f8..e255b5100362 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2793,6 +2793,7 @@ int amdgpu_vm_make_npa(struct amdgpu_device 
> *adev, struct amdgpu_vm *vm)
>                 return r;
>         vm->is_npa = true;
> +       vm->need_tlb_fence = false;
>         return 0;
> }
> --
> 2.43.0
--------------J10Mw9JKkZhPPtHAbiVcz0pm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Regardless of SDMA userq support, this patch still looks
      reasonable to me. The TLB fence doesn't make sense for NPA VMs. We
      handle TLB flushes for NPA page table updates explicitly in the
      amdgpu_ualink code.</p>
    <p>Feel free to submit this patch with</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-09-20 10:41, Zhang, Hawking
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BN7PPFFF39339DDA5A38FD4F0358D122C45FC852@BN7PPFFF39339DD.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from rtf -->
      <style>@scope { .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } }</style>
      <font face="Calibri" size="2"><span style="font-size:10pt;">
          <div style="padding-right:5pt;padding-left:5pt;"><font>AMD
              General<br>
            </font></div>
          <div style="margin-top:5pt;"><font face="Times New Roman" size="3"><span style="font-size:12pt;"><br>
              </span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Hi <a href="mailto:Hongkun.Zhang@amd.com" moz-do-not-send="true"><font><span style="">@Zhang,
                      Horatio</span></font></a>,</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">I think the issue is caused by
                the following code in sdma_v7_1_sw_init, which
                incorrectly marks amdgpu user queues as enabled for SDMA
                7.1 as long as the CONFIG_DRM_AMDGPU_NAVI3X_USERQ is
                enabled.
              </span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Since SDMA 7.1 does not amdgpu
                user queues (it only supports rocm user queues), could
                you please remove this code and check whether the issue
                still occurs?</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">#ifdef
                CONFIG_DRM_AMDGPU_NAVI3X_USERQ</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;userq_funcs[AMDGPU_HW_IP_DMA] =
                &amp;userq_mes_funcs;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">#endif</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Regards,</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Hawking</span></font></div>
          <a name="_MailEndCompose" moz-do-not-send="true"></a>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">-----Original Message-----<br>
                From: Zhang, Horatio <a class="moz-txt-link-rfc2396E" href="mailto:Hongkun.Zhang@amd.com">&lt;Hongkun.Zhang@amd.com&gt;</a> <br>
                Sent: Sunday, September 20, 2026 5:47 AM<br>
                To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                Cc: Zhang, Hawking <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Ma, Le
                <a class="moz-txt-link-rfc2396E" href="mailto:Le.Ma@amd.com">&lt;Le.Ma@amd.com&gt;</a>; Kuehling, Felix
                <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Joshi, Mukul
                <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                Subject: RE: [PATCH] drm/amdgpu: skip the PASID TLB
                fence for the UALink NPA VM</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">AMD General</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Gentle Ping ...</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Best regards,</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Horatio</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">-----Original Message-----</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">From: Horatio Zhang &lt;<a href="mailto:hongkun.zhang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">hongkun.zhang@amd.com</a>&gt;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Sent: Thursday, September 17,
                2026 6:05 PM</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">To: <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a></span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Cc: Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Hawking.Zhang@amd.com</a>&gt;;
                Ma, Le &lt;<a href="mailto:Le.Ma@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Le.Ma@amd.com</a>&gt;;
                Zhang, Horatio &lt;<a href="mailto:Hongkun.Zhang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Hongkun.Zhang@amd.com</a>&gt;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Subject: [PATCH] drm/amdgpu:
                skip the PASID TLB fence for the UALink NPA VM</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">amdgpu_vm_make_npa() builds the
                UALink NPA VM on top of amdgpu_vm_make_compute(), which
                unconditionally sets need_tlb_fence.</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">That flag makes
                amdgpu_vm_tlb_flush() queue an asynchronous PASID based
                TLB invalidation after every page table update.</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">The NPA VM is created by the
                driver itself in</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">amdgpu_ualink_manager_start()
                and never gets a PASID assigned, so</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">vm-&gt;pasid stays 0, which MES
                cannot resolve on the MMHUB. The </span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">vm-&gt;invalidation</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">never completes and MES stays
                unresponsive for the rest of the probe:</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp; amdgpu: MES(0, 0) failed to
                respond to msg=INVALIDATE_TLBS</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">The invalidation is not needed
                in the first place. An NPA VM is bound to the reserved
                NPA VMID and amdgpu_ualink_flush_tlb() already
                invalidates that VMID on the MMHUB after every mapping
                change.
                Clear need_tlb_fence for NPA VMs.</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Fixes: aac13f6eded6
                (&quot;drm/amdgpu: Pin page tables in NPA VMs&quot;)</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">Signed-off-by: Horatio Zhang
                &lt;<a href="mailto:hongkun.zhang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">hongkun.zhang@amd.com</a>&gt;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">---</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">
                drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;"> 1 file changed, 1 insertion(+)</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">index 68d668dfe4f8..e255b5100362
                100644</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">+++
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">@@ -2793,6 +2793,7 @@ int
                amdgpu_vm_make_npa(struct amdgpu_device *adev, struct
                amdgpu_vm *vm)</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;is_npa = true;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;need_tlb_fence =
                false;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;"> }</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">--</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">2.43.0</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Calibri" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
        </span></font>
    </blockquote>
  </body>
</html>

--------------J10Mw9JKkZhPPtHAbiVcz0pm--
