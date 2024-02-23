Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF66C54798
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 16:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD8210EC69;
	Fri, 23 Feb 2024 16:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EyHzW/K9";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE6A10EC69
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 16:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsKhXBw661LXZRlipMuzIqxMjBA+11t5TxJRf3zhhV+tJohvVbNXxzPF5TwsKbqw/jWkdOuSuArWomxtYDGT/OvCU1nF6FdChCiddbjfvQ6yWdvHktwi7IuYdmk95SkXCgbR3DNBb1qNJwFYjDSXPu/SD9eYS8MUZo0RwNprjN3Aq+gEtBoXjH1OKeHx0bieKYWqePz+suUJKUQHbuD5HecN499zHyiKc7NciOxrhRfIzDefLifYpslSL8sT2DeZ3JEGmef+UwqSuwPjUQ4e8aRbEqXBMwTSM8OB59luY8agm0L2c+tB/wn9hSflcVNcXbxs8+Ou79EnSTjzYq4rhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH1E97TqX5B+kuD46PIaucgrl0VHfVDDSoJ0cUgyVks=;
 b=YVgoEg/8/sIAFHZNz50TSG26bBw4PlupPuN5DzKEAqFwxiN2fZ7Vb1TWCa1YEUCfN8zyrTHgyB3NpgWkQ4UaXApnrppDjRwFTHEbh9KIk80ThoMU+sZX++MZmDpXWUNRqdWBMSgzxcLjbeTEXQma0NW2sJvm6HK4Zhie0GCTI5EmZ402+rx7jEKu9WbuXozWLN509xSe+a/BkznEpaakTvXESahsCVmwckj8QE5CQT2Rs7YjhXy7pStdNWN/RJrso68VGt/w5jk0rMkjAiU/qK1iZLOmCCuKGgI/BBQBh2s9lrugRwNWBNb5uXm6v2Il6sXDx9EYx3e9/T6LaXw6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH1E97TqX5B+kuD46PIaucgrl0VHfVDDSoJ0cUgyVks=;
 b=EyHzW/K9j/6VzuRi82eWss5sCjiwdI8qR42Kh+7mEOMnmguoFKZd6xftNA0f12nLIlR+BDZxbTYfBzFZtGNwXR6AC8/6NLyqILMuTczoHdoE0iJO7CR29GtnvH+kqSF26FkE0mfPiJf3iM6ghiOrJ2vmf0wAOW8cUjbkADpxabU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 16:58:56 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 16:58:56 +0000
Message-ID: <be0a4509-497f-2264-987d-2941ce21d97f@amd.com>
Date: Fri, 23 Feb 2024 11:58:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240223134206.899-1-shashank.sharma@amd.com>
 <20240223134206.899-2-shashank.sharma@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240223134206.899-2-shashank.sharma@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d760f0-6725-40af-6cc5-08dc3490b934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTLYgRj+Dr6zuhHTXnLwAGP2UKIARTB6IHOF0FIKeX30NP3aiwLZNpaFj6qn9BwPUrMooZp8unk6CX/gHLWxYYGT4XwCQjADDlPaYBSNphB5Cwf9v3IWuwGl2kfDxIFOrjJDgkoECMtfdBN/2mjE1UZJDjPn2rj3PqRIMHHZYowOM8SeHV57RxPpphetvYJmDblptiC1AlTuDiPf/xOhznxbQjsW7XTMRYCVVvS+SwXgnBPMunwFBguJUJvTSq9RP1W3h3tvzTa+q4BoMWFC3/+5iCq3EIWyyX9X+bxS7XpsuDjfERbOWO56O941eZ4Xz9I3BlBLCJJJSr+r4k2IjLkZrVb2vhxbiiKEVv2NNhaITcmYi0HgJb3/48PjOE0o4zGcqn8iG7ufz2ZuUigKQLIDwQ94DCRfj0qnG/zK+8jsdOJXJOSICSmxgI1REco5y7uNi0ELydW2U5gebJ8cdv554FY6iHs47aU3bck89pU8fVYyo1SX8IeK4JUqeyTOBHHtsV3DRGWkgXazFTop+33KncLzH9rSe6UJqpISXNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHppN1NKeHEzbmFrS0t2Nm1zckNHVVBHUGJxSVZncW1PakNTb3RNSW9iUHZ1?=
 =?utf-8?B?MzY1c2pzdVN5Q0lVZ3JDdm5VbVlUL3lVM2lsMmlKRjkyMjFpQk0xRlR6RkpD?=
 =?utf-8?B?ZXFRNytwbVJQVGIwY1BzVUVUUG45N2paNDBqL3B4WWwzWGhzdnJMUWdnTzB1?=
 =?utf-8?B?K29MYmpNODgzeVd1K3h0WVpCNUwvUjJZcGtZcy9kREZHZWN5cDNGK3poQXIw?=
 =?utf-8?B?NGkwYnBZc2o2dk5EdUlLQ2VpYkh6eHRJSVUwWldqKzJsQzVsTTlHQmhBL3F3?=
 =?utf-8?B?TlV1ODNwMmM5NDF5UkRaWjhOUHpjWHM4UmpTVndqakd3cTJVUEdtMGYrVFFX?=
 =?utf-8?B?Y3o2eTllVEdRWHQwdnV0RW5NcG1nZFdTblRLWjlPbWFnSk83dUJvVkUyMW5G?=
 =?utf-8?B?STBCeWg2Z2M3Zno3blNDd3lpdVgvU1VZZWlld2ZoSC90dnRFb1NOWjBFbGRU?=
 =?utf-8?B?TmpxWjJyczYrdXZ4aVJMMFgyRkJBSE51WEpKWmFXUHJkejZndFNUaW1HeDNH?=
 =?utf-8?B?Tk1PTTU0TVRuT1ZtNlNDa0kvUVpYQ2ZFUEdTbWJNYW9ybTVLQWhsNVVLdEZM?=
 =?utf-8?B?RTNuTW8zZkJDMXZia3pmUGNBaXljU1dOR25PcTExbFk0b2FzRkYyUW5QaW5Q?=
 =?utf-8?B?cXFWZEg5eElMUG11L0sweStWb2VvekdDN2tyb1lGUEdGbTdhZG5zV1VSNWtj?=
 =?utf-8?B?enRob053OXMwRHpZeXJtNkU3c2tPUXYzRTljM2ZyK3hlejcwb082azJEUmEw?=
 =?utf-8?B?c0krbE9PYWZPOU5BZGlnMnIzM2lzT3k5am5TOXRBT0Zrd0VJYk4zUlI0V3BZ?=
 =?utf-8?B?VGQwQmROdlVMV0g2ZnJxVTJEZU5IMFNxNENjR3gvQTFreXFpTk81TGlZbEFR?=
 =?utf-8?B?SG5GSDQ5cTVhUXlRbGZRZTBuZWNyUGhnWXFqTERHZS9qeWJzbGM1WjZjNFA0?=
 =?utf-8?B?K1hNcWg5NGJwY3JCVGZha1V1TWNjSlQwdFFYOC94dmVzcnBtdURaWG04cFQ3?=
 =?utf-8?B?VjhkS3lKaHhCL2pzenE2VTFjOFFNZ3VISWdKaURVK1ZManlMaWtaZGl6RUw3?=
 =?utf-8?B?TU84QXhISW5JamhjbndXSUpiVng2SUp0V3JTSXBhS2dPVkszdFRwZWVjTksy?=
 =?utf-8?B?SjUzNDNwQUNsUSsxZloveWZJRERFb1JSK1plbTFwdHhpMTJGc1JCRFhEelFW?=
 =?utf-8?B?aEp4NW5xNmdzdnpOc04zNE96ajJSU0F6RTR4VjFzNzN6Tlk1MERJcldiTGZn?=
 =?utf-8?B?dktxbkt0VTFKbkpSTSt6aU9DR1EwVm8zVkZweUxRYldiZU04YTRUNzBqbXVD?=
 =?utf-8?B?blgwNll4SWozazFwWE5YZVljRkdZN0ZHQUVIRndpSk1vUWlrUS9oQ3ZTMU5q?=
 =?utf-8?B?TUFDRU1IZU1GQVpoU2dlLys3U2JVbTMvUU5QK0Y3UXF4NnhacFFMb2kwb3JW?=
 =?utf-8?B?SEl1VDIzT1Zjb0draDhLUGs5T0FQSUNtMEc4R3k1T1lKc0pNU1QvYnBqbk9j?=
 =?utf-8?B?blNtNEp3dkVQMndCeXlOUElETnUyVksrT3FqYXp0OUNmWGFHTUdGMjV3cW9I?=
 =?utf-8?B?SDR1RTZrRUFPS3RhOWVVTkljdXBaNXpVSlpzSGQrVXRoUHdCTGl6aENuSlhS?=
 =?utf-8?B?ZStEZSswcGpEWEcwejlqZHQzVXhKQmlGSStqNk9kTWV4SkdpNkRMZUJ5bENR?=
 =?utf-8?B?WXdSWjBTU2F6L2xMVW9YdmlHUHdGYmFhQ25IZjIyL0J1Z1F2R2p0RFI5VHgz?=
 =?utf-8?B?M0dtV2p4QjZQYnpDemZlZkJpaEZ2R3pZZTdkTkxtN2s4RVdXMVZRRS8xTks4?=
 =?utf-8?B?ZHFSMVk1RHpoN2U3dnBMWm9pSG8vdEM2aDAzUjNvd3F5Rlp5N3JpcWVGQWph?=
 =?utf-8?B?aHJtMmFsd2NmaDlkbTAwZHM5ZWpJVER2ZmUzZVBrQVpoeFEvcHY1ZnlveEZr?=
 =?utf-8?B?Y21LdVA4MW85OVhwNEIrc29VM0F1UzBxd0k4VGVTQS96TDlEVm9SZGFOSG1V?=
 =?utf-8?B?TnFGTEgrb0VmSU9FV3laWmpjem5ad0lWUjg1U25BYWJMSVZMRlQ0eUJSSnVh?=
 =?utf-8?B?MzFLQlk1bXRRaCt3UTljcXVLZmtHcDRoYlJyanZrMTZNQi9ZRWJTV1hNL05N?=
 =?utf-8?Q?+xEI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d760f0-6725-40af-6cc5-08dc3490b934
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:58:56.7931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxDY9uCGG3GmpwyPteazxh8wH1LEu89hIXebBwnhCz7/Ba/dLUR/9ELKk70fySbq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
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
    <div class="moz-cite-prefix">On 2024-02-23 08:42, Shashank Sharma
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240223134206.899-2-shashank.sharma@amd.com">
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
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 106 ++++++++++++++++++
 4 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4c989da4d2f3..fdbb3d770c7b 100644
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
index 0960e0a665d3..67c690044b97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -932,6 +932,15 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_unlock;
 
+	/* Prepare a TLB flush fence to be attached to PTs */
+	if (!unlocked &amp;&amp; params.needs_flush &amp;&amp; vm-&gt;is_compute_context) {
+		amdgpu_vm_tlb_fence_create(adev, vm, fence);
+
+		/* Makes sure no PD/PT is freed before the flush */
+		dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv, *fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
+	}
+
 	amdgpu_res_first(pages_addr ? NULL : res, offset,
 			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &amp;cursor);
 	while (cursor.remaining) {
@@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	mutex_init(&amp;vm-&gt;eviction_lock);
 	vm-&gt;evicting = false;
+	vm-&gt;tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev-&gt;vm_manager.root_level,
 				false, &amp;root, xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ac9380afcb69..8e6fd25d07b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -332,6 +332,7 @@ struct amdgpu_vm {
 	atomic64_t		tlb_seq;
 	uint64_t		tlb_seq_va;
 	uint64_t		*tlb_seq_cpu_addr;
+	uint64_t		tlb_fence_context;
 
 	atomic64_t		kfd_last_flushed_seq;
 
@@ -585,5 +586,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct dma_fence **fence);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
new file mode 100644
index 000000000000..569681badd7c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -0,0 +1,106 @@
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
+	r = amdgpu_gmc_flush_gpu_tlb_pasid(f-&gt;adev, f-&gt;pasid, 2, true, 0);
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
+	/* TODO: We probably need a separate wq here */</pre>
    </blockquote>
    <p>tlb_fence_work flush tlb, then signal fence to free pt bo, but
      how to guarantee the tlb_fence_work is executed after updating
      page table done? This looks racy to schedule tlb_fence_work right
      after creating fence to attach to pt bo.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240223134206.899-2-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	dma_fence_get(&amp;f-&gt;base);
+	schedule_work(&amp;f-&gt;work);
+
+	*fence = &amp;f-&gt;base;
+}
</pre>
    </blockquote>
  </body>
</html>
