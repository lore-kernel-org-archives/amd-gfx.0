Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7DAC5478C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 23:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB13210EDBF;
	Fri,  1 Mar 2024 23:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gnNqmGAv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BFC510EDBF
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 23:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW/VYFW8zUIZD7+jUJJxmSVZhApLF+3+r6l4XmCAIKt2E6BD/uJRhfWDVuVWSn+uSbiZv7TAHROt6J+5Ku+V63AZMFN/4xXmcsNOltksJJzDmc3Wwpvgkn7v6QOby3mT55UmDZ5uT0UN+NX4Z4EKfFI6XfWteb9kn8c4rX3CCEiEyENvHVjcnsGdT0BKl650JIl61PRtOZQq+O629xrJgy6sOubfgajRhELep1tXWecqUKbZVfz1aMn5bnPYriAMW5ZycPfcyMasE0ZeVHio/HLc5bJCmi/YirOAzoFfk5f+QBIUvYq5CiPmspLrr960SvUnBPpP/XKhtXTm7NsBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IK3TWH2dQAzO70wsitTVmJTkMXQyUN07LDoeGZSh/M=;
 b=QXCXiq6eaSBpqxNnIsZ+2A1EFKQoQUSkFMVf0dXU8NYwjzSEqDoMt1ccfNV8/GToHCZNz/v6JYrWoyUwxtf6ybA23F/pE7RTylGa1U4Yu5bs/kEHJn4CruZwU+56WAvRAXlOPSfMcHP2mnLGxwzcSwdRa0+k6cS9MtQHf4X8IeykIcQdB65ViH1KnpX9tH+Ic4hy8Ho+WI52kMJ4sGRvyUqf2qHdk/cnyBpH+FtsBHTUZVt7rIgZhX1MyFUNP58vRsoQFICC2Nknb+oEVxn+aDKSI4FI4ezaR4m+kdZtoUvB+JhIXcMjLuNJ4EdT8miawL4encS7S25WTAA1lvs0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IK3TWH2dQAzO70wsitTVmJTkMXQyUN07LDoeGZSh/M=;
 b=gnNqmGAvxM9D5nv6Ee4aftWixCO+ifC1y00DnKQ+NQpJ475oSfbjh6b0ZUwj6To78JhqT/qlDtSYyAVk3/yQWdIhpWVOkkZB+jbOeAdhxJoPGtp4REaeQP9/TUk7+bNGtO0ohWdT1ejtAN+t4q3ge60EUAGM3xt9KlN94e2NtQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 23:31:41 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 23:31:41 +0000
Message-ID: <c91afc93-00e1-8bf5-91e9-8c563f8a5a8f@amd.com>
Date: Fri, 1 Mar 2024 18:31:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240301110724.947-1-shashank.sharma@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240301110724.947-1-shashank.sharma@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::43) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 299b3bf5-dde6-4663-d7ca-08dc3a47bff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdUfVcvfenNbm0fDREWg5UXIAfoMj6+xV2cp/tJZFbXte9CuJasmxWW221mZsfvTjQln+iKGTpObLYp4IyssvKrrBpKtkBLk8PF0MIKBjAEzw7vh8zZLQj9F/qpa66A0RTaAoDQc9IODjn/WhKuDUgSy0pl7thUr9C2CBbu3zyWcPvM4LLrx/Miy/zUGxbsGrQkDP9Ix3VZGQ6ZfkLwzYoQn821z/6UnMDhNCc1JobHnonnxyDSZT2VKDgzrZVKJTqusyZqfgHhd5aTpYMYGJBnbMRtRfPYWI3cQAqzRKGR1UM5SmLSSaS7jIJvk9d4r8dpcz9WIivkGKyVi1hLcHUImtWcDKOfvpjMf98b+ZL4tjDBXxCXVpXfAk11grW+o89zJbb81jshvxAg6/qYpbcJDPHJE1RdH+PfoOWmQ9e8y3+bvIzXj3vOH60Jwywn9jg4gfU+35hayOEKvd8Bw0N4ICTvcshn0GZGiPtooUXO18ewlqF07qIsLlBRyY2ERhNHXz+gy0bKwa7Oc3zxrDp69FaR4QhcRKqPM/CSJGmB/QZKkKsn9O4wzENsQNPzs6ezoqY4Smryhw2eptiX331/mP0z1j9XMME/7zCdqLRmRJNoKRzqyBexTAfWKVwXv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkg0N08yd1MyOE9kS01pNyt5K0wxMnVYK1pYZlZQVlB5b0o3VDF6Mm1nMjhI?=
 =?utf-8?B?QWNMUy94eUV2MjVJQVFVRkR3ZC9yYVNJWFdHallvY2tvTFlHOTMzUkJwbkZp?=
 =?utf-8?B?RGtFQmxyeVpZNG9saFhUT0RsYmIwVHNYWmNmMm10THJFUElIWC90SXpoUzQz?=
 =?utf-8?B?eVYzRlQrcXd4bjZ2bHZRQVY1bHl5emUweTJpTWwvSzBpMmMxaEFkVXZqTk9l?=
 =?utf-8?B?YWJoUFBlTG5XaitRT2xvYTJXUjRtSnB4ZnVSTElTVXRkdlRDZ2ZQSDI1QlJZ?=
 =?utf-8?B?b0RyR05sR25zdU5WVFYybWhiMkZmQXN1SENBai9EdkZpeVlvZDJQaFFiaVhK?=
 =?utf-8?B?UGltSkFidzY0VHdQY2NnTytndEdlSzF5YS9ZbFl0cWZJdXFvOCs3bWVQMll2?=
 =?utf-8?B?YlZOcXZHemo0SEoreHhuVTk3YVVWektpb1pxVFRUU0JwL0xxVDlTdFlFM25o?=
 =?utf-8?B?UnI2WS9vM1Q0cnRPZUJ2RjVmYitUbHVmclFGNWlvWktUL1pGempkN3NrMkps?=
 =?utf-8?B?VWE4aTNtSXp5Y1ZIaGc5UStmaWk3YnBYdU9UK21qR0t1N3I1d0VFem50T01t?=
 =?utf-8?B?TlpaQ0hubG5pRDFzZkhyRjlvUXVlSGxGMG1yRWkzTFFkR1piQW84SXBrK0hR?=
 =?utf-8?B?S01UYVpEcHl6V2VQcXlkdXpVREJrM1VnV3ZaWFFFTmRTcjdqWlVUQXV4R0Ni?=
 =?utf-8?B?T3U2N0hSZ3l3cmsvbUhONVFjOS82T1dXK25YRTN6YW9jakJVUDJHQldwY3lj?=
 =?utf-8?B?dVlNeFJPWVVGS0x0ZEJCYUZHczNjTThqM3BJdGMwcFZEVlpzcVlhcFY2Sk1Y?=
 =?utf-8?B?MjlXeWJyOFlQMVE0MjFrWEpuK2lCeVVla1FnNDNFL0hpaVkyNkhzSGJvRTRX?=
 =?utf-8?B?MEdJcGY4ejNiWVFUZ3poenhsVVlqR1FHR1JyZnZWS1RZNVBXOGRMOFNxTHJr?=
 =?utf-8?B?WE9KRDc4Tkx6NjhpTm55TG45NWF4Szd6TzNHRDlrcXljSkg3c3EwQWlFRlVn?=
 =?utf-8?B?S2xkbzdCU2VKYllSWk9qUk1BQm1oWlZhbmZXV0IweG4vemVOVnlqeDIwbEQ2?=
 =?utf-8?B?ZUxRVXpYVWVFZ3F0RlBMeWpOQVpwcEFKUVJpa0lVQ3lZUW1LbWtkbVF2aFk0?=
 =?utf-8?B?SjQ3ZkVEbjBneUMycUNLRVA0enFMdnNLbk5iek5YYWFwNXVIUk9FZ25mVmJO?=
 =?utf-8?B?MzRRTkt1aDBscFNLWjhEcFlLekEzL2dnY3NZSzhTK3BHKzBXbnc4SGs1TVhM?=
 =?utf-8?B?b05iNzVqQ2NFa0YvYXh1MUxUS3U0TVRTV1A3cTduYWpKekxTSU1jVHAwYmI4?=
 =?utf-8?B?NnZxZFF4R1p0NHh0UVJXUzM0S2ZOcDRaRnYrM3oyQUlYa0MxWWFuRlh0YkJF?=
 =?utf-8?B?MEFxbDhjdjhBSHhHcGRoQnFJWnc4UGZLZzB2dmUrU25PTUVXVUo1bEEyZ3Jr?=
 =?utf-8?B?cGwvR24wMTd6b3ZJUTREWmYvKzNxQUZ0c1ZLeTYxYmpYWjRxV2ZJNmhpV0Vy?=
 =?utf-8?B?Z3FWVVQzTllmRDFiaTFySHR4L1d0Y2FER3lndDJqZWpDOXBZN3VSdksrWGQv?=
 =?utf-8?B?QnNUcnNHTDkvdTVHN1NOcGdHemtwZmdHNXRLR0Q2K0wwSnVHUUVDclVGZFVR?=
 =?utf-8?B?S25zYkF5alZEN09ubDFXc3pYbTJVMWRYUmlkaW9taEluSmtDcG5pUSt2N1VX?=
 =?utf-8?B?Vkl0YkNMY05oaGhrb2Rka0c3SzdJcDBXcWNqVzFDVnZWbVdSSlNDOG84bFVs?=
 =?utf-8?B?bzYxTmlSdzZ2QW1xTnlDWitCeUJQanBrbkI0WjNPUE5BaktzSXRkVjIzMmhY?=
 =?utf-8?B?SWpnQS83ZGkrNVp5QXRlbmVvQ2duWGEzd2MvdHhybmo1emg4WXFQNVBvd2R2?=
 =?utf-8?B?WUJpMU9qVm11ekxTN09oMjlXcFN4cWwyVDM2eXJ5SFlDVnJ4QmM0MWswU3BG?=
 =?utf-8?B?OEM0U3BGRVZrQXNJSUdiTTlUMlhYclZlcWQ2VFBjNkh5M0ZWaHpDb2FLMlFj?=
 =?utf-8?B?WVJCcUNYVkVjRmdpOU56YW8rbGJjclBXUnA2VVZKR3ZJczZxSnRaUnowQWNC?=
 =?utf-8?B?Wnc0MEFXSU1RUHBkSE9WQWZqRDlxVnBST0JxV1BMaENYcTVLalZGMk5wSmtl?=
 =?utf-8?Q?1Y7M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299b3bf5-dde6-4663-d7ca-08dc3a47bff0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 23:31:41.8296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpbuqSgfmE41F17mZb3Yx99AOaoO9wG6AQdBDdUWMpG2mk+EAd6NvWlPk6wtSxu8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-03-01 06:07, Shashank Sharma
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240301110724.947-1-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>

The problem is that when (for example) 4k pages are replaced
with a single 2M page we need to wait for change to be flushed
out by invalidating the TLB before the PT can be freed.

Solve this by moving the TLB flush into a DMA-fence object which
can be used to delay the freeing of the PT BOs until it is signaled.

V2: (Shashank)
    - rebase
    - set dma_fence_error only in case of error
    - add tlb_flush fence only when PT/PD BO is locked (Felix)
    - use vm-&gt;pasid when f is NULL (Mukul)

V4: - add a wait for (f-&gt;dependency) in tlb_fence_work (Christian)
    - move the misplaced fence_create call to the end (Philip)

Cc: Christian Koenig <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Cc: Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 111 ++++++++++++++++++
 4 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index fa26a4e3a99d..91ab4cf29b5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
-	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
+	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
+	amdgpu_ib.o amdgpu_pll.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0960e0a665d3..310aae6fb49b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = vm-&gt;update_funcs-&gt;commit(&amp;params, fence);
 
+	/* Prepare a TLB flush fence to be attached to PTs */
+	if (!unlocked &amp;&amp; params.needs_flush &amp;&amp; vm-&gt;is_compute_context) {
+		amdgpu_vm_tlb_fence_create(adev, vm, fence);
+
+		/* Makes sure no PD/PT is freed before the flush */
+		dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv, *fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
+	}
+</pre>
    </blockquote>
    Adding fence here seems too late, the fence has to add before
    calling amdgpu_vm_pt_free_dfs inside amdgpu_vm_ptes_update.<br>
    <blockquote type="cite" cite="mid:20240301110724.947-1-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	drm_dev_exit(idx);
@@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	mutex_init(&amp;vm-&gt;eviction_lock);
 	vm-&gt;evicting = false;
+	vm-&gt;tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev-&gt;vm_manager.root_level,
 				false, &amp;root, xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 64b3f69efa57..298f604b8e5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -341,6 +341,7 @@ struct amdgpu_vm {
 	atomic64_t		tlb_seq;
 	uint64_t		tlb_seq_va;
 	uint64_t		*tlb_seq_cpu_addr;
+	uint64_t		tlb_fence_context;
 
 	atomic64_t		kfd_last_flushed_seq;
 
@@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct dma_fence **fence);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
new file mode 100644
index 000000000000..54c33c24fa46
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the &quot;Software&quot;),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include &lt;linux/dma-fence.h&gt;
+#include &lt;linux/workqueue.h&gt;
+
+#include &quot;amdgpu.h&quot;
+#include &quot;amdgpu_vm.h&quot;
+#include &quot;amdgpu_gmc.h&quot;
+
+struct amdgpu_tlb_fence {
+	struct dma_fence	base;
+	struct amdgpu_device	*adev;
+	struct dma_fence	*dependency;
+	struct work_struct	work;
+	spinlock_t		lock;
+	uint16_t		pasid;
+
+};
+
+static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
+{
+	return &quot;amdgpu tlb fence&quot;;
+}
+
+static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
+{
+	return &quot;amdgpu tlb timeline&quot;;
+}
+
+static void amdgpu_tlb_fence_work(struct work_struct *work)
+{
+	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
+	int r;
+
+	if (f-&gt;dependency) {
+		dma_fence_wait(f-&gt;dependency, false);
+		f-&gt;dependency = dma_fence_get_stub();
+	}
+
+	r = amdgpu_gmc_flush_gpu_tlb_pasid(f-&gt;adev, f-&gt;pasid, 2, true, 0);</pre>
    </blockquote>
    <p>should flush all xcc of kfd node-&gt;xcc_mask, but cannot get kfd
      node here.<br>
    </p>
    <p>maybe we could signal tlb flush fence inside kfd_flush_tlb, and
      remove this work completely.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240301110724.947-1-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	if (r) {
+		dev_err(f-&gt;adev-&gt;dev, &quot;TLB flush failed for PASID %d.\n&quot;,
+			f-&gt;pasid);
+		dma_fence_set_error(&amp;f-&gt;base, r);
+	}
+
+	dma_fence_signal(&amp;f-&gt;base);
+	dma_fence_put(&amp;f-&gt;base);
+}
+
+static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
+	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
+};
+
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+				struct dma_fence **fence)
+{
+	struct amdgpu_tlb_fence *f;
+
+	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	if (!f) {
+		/*
+		 * We can't fail since the PDEs and PTEs are already updated, so
+		 * just block for the dependency and execute the TLB flush
+		 */
+		if (*fence)
+			dma_fence_wait(*fence, false);
+
+		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm-&gt;pasid, 2, true, 0);
+		*fence = dma_fence_get_stub();
+		return;
+	}
+
+	f-&gt;adev = adev;
+	f-&gt;dependency = *fence;
+	f-&gt;pasid = vm-&gt;pasid;
+	INIT_WORK(&amp;f-&gt;work, amdgpu_tlb_fence_work);
+	spin_lock_init(&amp;f-&gt;lock);
+
+	dma_fence_init(&amp;f-&gt;base, &amp;amdgpu_tlb_fence_ops, &amp;f-&gt;lock,
+		       vm-&gt;tlb_fence_context, atomic64_read(&amp;vm-&gt;tlb_seq));
+
+	/* TODO: We probably need a separate wq here */
+	dma_fence_get(&amp;f-&gt;base);
+	schedule_work(&amp;f-&gt;work);
+
+	*fence = &amp;f-&gt;base;
+}
</pre>
    </blockquote>
  </body>
</html>
