Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985EBC5478C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 16:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF0E310E7CE;
	Mon, 26 Feb 2024 16:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ox1KwTXf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4905610E7D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 16:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQu1jdHW8+H9Kd8rDF2Y24wY+oNrjs+YrfXmizorpRATiCdBiWOTL5wn0LRKExxOBtQQB180AcUeX6WxghkF2r2y+eWakHUJ3+WZqjeuOGobUhP82u5P/0xYyQCayZ3ky/tWmKM+xdHW8YtUQZDo/0lR+mXAY0pMbHLCbXwPFeaQqr4uM1soGrmlktDgCG3m8kCiFEMzlD43SQjGVl2yLV100ye+9h1uwwT6ZqbEGtlC/8iu9RBxQCOhW1XJHr2+o8AZ1k4H1YHKCJayrwJjLMjadlAixrdevOn3j13fP6E02dm19q9EJo02hO5xIJF2rctS5Mzic1ZCquXdi4zKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/XjZxXLdC+EdKrPHO8pQwkdISrrF2P0FLMyPFQ9IB4=;
 b=mdMTKI5bx1COQr5paoJhYW7h6eXC6mC5RN3dOgQ+vZY76skRfEdf3a/j/W+cbhNw8lR0OYruBonsNNFSTWnqV3V/JoNhW73zpHTFTh7MUhC0Y2FezVCeDBEgTnmq9pHCMbU1USEi3OUi714H1N3wLSriDFbtmWC1MeIPLQGJWpIG7qqJ8VX9CZKKVcgQMV4FuHEQfnmWbetBE4dmHjNVOH2zzZ2ciR2MRhIxkeB/2tOB9zLKQzYbrquxn8l7jGkRRpMmezQp4FXVqSlpclnR9oz6Gms33eXaF2w1rTCxF9CIbVVR7GjRjp9pFEIywuHEYs9EHUlhhBG8pBEEtmopGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/XjZxXLdC+EdKrPHO8pQwkdISrrF2P0FLMyPFQ9IB4=;
 b=ox1KwTXftN6OS4rQVBtEPLHiVitSGGWgS1/vCwR7DxeNZLds86sG3tMQCXYcSFhlI5aWg5fNJ9+74Z60TyxK6KMURWFa3Mg8bkC5CbKDH+dKevUgJrh57u/Nk5/of29le2z5IppeIsO1sVz1lWE7kyOerHOyt2WiH9K3nVFxCIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.34; Mon, 26 Feb 2024 16:52:32 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 16:52:32 +0000
Message-ID: <555f7ad2-a3f9-1f79-970f-eba3512d8aff@amd.com>
Date: Mon, 26 Feb 2024 11:52:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240223134206.899-1-shashank.sharma@amd.com>
 <20240223134206.899-3-shashank.sharma@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240223134206.899-3-shashank.sharma@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: f3862b28-3a3d-4969-a691-08dc36eb5350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/1LdtMTLqRKNk/XG7+Mk4+gslh3rHAcJuZn3zWvHXMgFHjOdCYtEM6cZ/KFlhIP84PMByFXXO7OoIYnmWPgR/573aOrvgmMK2J6grDElLTvM00fymU/RP2a9ZM+2YoivQSdVkIoZojEHfSEr77MC5BM9n72Pn1pt/l55bqFPkEj2/asP/xmxYn1SYC24rvx44JiNkb4CkFywPhZl6nb79M2YBME+UcSfiG7bra1iJbrKrwzNlnsJIiHHL0EIfBF82YQszYQIL7PTgdFeGUCOZbPqsF+rcUiIfma3YcR1Qlc9b7K4RCa3huPS5VRqdQ+V29JHxfPOF3w+ftLAjH2uvigTZ2AbGAHNZQjcZWb8wzFuyegdL/bkjYmkF5hZDtImuBSSlSYdgMabEUgV/WQDO93I9j2yyRz7V6bHvthabT+tqNqnV9P+YSrUsaQhjAGgyOaemNJw3ljIPMqmfNFmCx612By031TNubzSrI5Dd1TqBcaz8nVNW7MQzdVK0rRvcmnfVaDw3rd9dw9Urs/pE8pOopNMl2Bui6JjTOS9iXhbH2sMM2KeZDZZ8Y8+w9PdYxizePrWPkQv6cve0XXQVmEgsMj9zgJuPdKWARzm65UXDLob217DyKVsFuZPRWSnoGXnt3qaMva4eAv3eNkJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lnc2JBalNIc2VDQWY3NVBka29acFB5YVFTNXhVQUlCaHBCSzFoemFwMndF?=
 =?utf-8?B?UUpscDdoVFptamlHNXIxV2VPeE9nVXA1TWdBMjJFa0tRM2ZXc2VBanAzN3ZI?=
 =?utf-8?B?YktWWUdCR1B1RDVURG1HMG9aWGVGNWg4c2JrSUtlWXoraEt5TDBwNTFkcita?=
 =?utf-8?B?SzRaenNXckFOcjg3UkVyM1p1TnhjR2t2ZkFYTXY5RUJkZ0hhaU94YTRzWWp5?=
 =?utf-8?B?M2s2bjhpcGt4YnhHVnQ3b05YTHRTNHRXdzNZYUZzYlVhNXBnbDVuZkFaaTNG?=
 =?utf-8?B?MXhCc3VZOU8yeEpsaGNLT01pZzNWRnYyU050KzNBdnJXTlplenNudkw0Z1k5?=
 =?utf-8?B?SEJsc1h1eGt4RVRka3d0cnM3My8zVlBlMEs5WXRpeGJWR1hWbVVGT3NYclBU?=
 =?utf-8?B?aHVSTDRUb3U1dmQzVjQyYTJOUXpmdjRDYUYyU0UyeGUxOFlXbDFsY1hvcXFK?=
 =?utf-8?B?UURjOFVScTdGa2RucTZLOVV3b1UyVndPT2FvdTRZMVNZZ1JLb1hiUjZqNUp1?=
 =?utf-8?B?eWZ5SWIzajBsUW1UYU5XL2RWMEhxUXczc1Bhb3NSYUVsNGdBRGdnbjliTnVI?=
 =?utf-8?B?T3JzSDZDMkdVT2hYTFgraHN2c21hdFRIMHZnVkdMYms2OHVidThHemNWNUFq?=
 =?utf-8?B?SFpaMjFCZ0Jadjl5QU5VUmxaQmljM2wwaWFwSGo2bmJRc1h1NmZzbit2S1U2?=
 =?utf-8?B?bFZkV0o3czVZdjN5c3BZMEVKVnhGZkxrK2QvQUpkaTk5cEg3enBBYjdLY3Bx?=
 =?utf-8?B?MXByZmFtcnkrbENPdWFVb0hnQ0pYSU1LeHJOeXVVcEk4SXdxZ1RiUTJFNUtD?=
 =?utf-8?B?K0ZsOUNlQVFQSjNRQk81QmRtaGROd0pDSkFaWTVNdzM2QitYNVZ5WnhIaHNI?=
 =?utf-8?B?aGVyWDhNWmRTNDFNZHNHeHVNa21DM2pLR2EwZFRBSUxwN0hiNGxjR0JBK2J2?=
 =?utf-8?B?Z01iUzJ6K2NQVi9ialJDaHprRzNhZktnRTNzTVg0MkQxR0R3Qm9WOUd1ZTJP?=
 =?utf-8?B?NmhNUy96cjlhUjFva0VIdFlSdXlPeWVQeWxhdWxmVUMrdExBYVFSTXRRcnc5?=
 =?utf-8?B?YWdEZW9EdmtXL29UVUljYkFOY3F4NDM0SWZ2NStHb2FNQlE3Q0tjRGllUmVa?=
 =?utf-8?B?WHQyaEQyTzZwU0RLVmFFOG1QRlpNQStocDUwRTY4LzhOKzV2ZEQyaWpHSHdv?=
 =?utf-8?B?czJnVDA2S09qWU5nQmhyQ1pBN3VPZjNMVGF5NFhKMUlaTkhzN3VETWVSbitQ?=
 =?utf-8?B?Ky9kbFVmVUlXbzEwbjRIaFI5N1liLzBTc0l6N2NHV0lyMDJPTk9YZnJVbjBj?=
 =?utf-8?B?VDZuTFlGTytLL3ArSlBIdlZXRS96TEVXR2FaN2RoQ0E0SElzRy9qMERVSVpT?=
 =?utf-8?B?NEFKbHFPMDVJR0pvWXJzeTBpTTZjS3hsMnFUL2hMV1VsOUdzRW5UVkRPZjhl?=
 =?utf-8?B?dXd0algrVkRzN2FXTnNNRVdTV3lqSnNOWFdSai9JUS9UdStCRGVRTE9kVElE?=
 =?utf-8?B?REdJaGZHZTQvM1VkdW5QclNtb1hUZnNNcFV5K09WdVNKczJKR295cE41NndD?=
 =?utf-8?B?TkhGazVKb0tkc29MRmFuYUVDMVhKbU9BbU9sVE1XazBlMi9wVG9JalN1VEor?=
 =?utf-8?B?RHdvZVlqU1owb21yZXhOWjA5Mm53MGs1cUc2aGtMWlNkMUlORGtGS3NxRk5N?=
 =?utf-8?B?RWsyejhTeEdYa0V4cGlNVzZxY0VvZTFJbkxxMnRmSk5od2FiaTNkZHZtekJ1?=
 =?utf-8?B?Qi9vWlJhTUZqOUxLWEFQa2p2TW42cll3TDRPZmRqVllJWUx3MGhyeEFyb2Vh?=
 =?utf-8?B?RStINElRZ0h2em40UnJGUXVROGJvQ1RUbUZxTjdMeFR0WFZ6bGRJWHNDT25I?=
 =?utf-8?B?Zk9zUWRZVGFObnc1VVBjcHZXMHEyRWJnMjZOQmxBdjdxYXM3SUgvb3RadFp2?=
 =?utf-8?B?Mk9iL2xiMUgwclA0SlJsbER6djdSSTk0T2pUdGUwSWVHNXN1cTNuV1hGaEl0?=
 =?utf-8?B?VFR0YzlWTm1Pb3R4V3lQd1lKSVdDZ0tCMDBjaUp2UXoxdFc2ZXNVSE5KT2Fp?=
 =?utf-8?B?ckJ6UzAvS2hQUFArblFIRG1CNmtyTkh3Tmg4VU9VTXhwVlJOdjF1SWdUUC9k?=
 =?utf-8?Q?cpx0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3862b28-3a3d-4969-a691-08dc36eb5350
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:52:32.4010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWMvXca2kp4ubp4SjZ9iUvYs675zUyi6U1askz+tVorzY11sTy9bbphdpdAAy3Fc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
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
    <blockquote type="cite" cite="mid:20240223134206.899-3-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">This patch:
- adds a new list in amdgou_vm to hold the VM PT entries being freed
- waits for the TLB flush using the vm-&gt;tlb_flush_fence
- actually frees the PT BOs

V2: rebase
V3: Do not attach the tlb_fence to the entries, rather add the entries
    to a list and delay their freeing (Christian)

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Cc: Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 51 ++++++++++++++++++++---
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 67c690044b97..eebb73f2c2ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -939,6 +939,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		/* Makes sure no PD/PT is freed before the flush */
 		dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv, *fence,
 				   DMA_RESV_USAGE_BOOKKEEP);
+
+		mutex_lock(&amp;vm-&gt;tlb_fence_lock);
+		vm-&gt;tlb_fence_last = *fence;
+		mutex_unlock(&amp;vm-&gt;tlb_fence_lock);
 	}
 
 	amdgpu_res_first(pages_addr ? NULL : res, offset,
@@ -2212,6 +2216,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	INIT_LIST_HEAD(&amp;vm-&gt;freed);
 	INIT_LIST_HEAD(&amp;vm-&gt;done);
 	INIT_LIST_HEAD(&amp;vm-&gt;pt_freed);
+	INIT_LIST_HEAD(&amp;vm-&gt;tlb_flush_waitlist);
 	INIT_WORK(&amp;vm-&gt;pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm-&gt;faults);
 
@@ -2244,6 +2249,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm-&gt;last_unlocked = dma_fence_get_stub();
 	vm-&gt;generation = 0;
 
+	mutex_init(&amp;vm-&gt;tlb_fence_lock);
 	mutex_init(&amp;vm-&gt;eviction_lock);
 	vm-&gt;evicting = false;
 	vm-&gt;tlb_fence_context = dma_fence_context_alloc(1);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e6fd25d07b7..77f10ed80973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -334,6 +334,10 @@ struct amdgpu_vm {
 	uint64_t		*tlb_seq_cpu_addr;
 	uint64_t		tlb_fence_context;
 
+	struct mutex 		tlb_fence_lock;
+	struct dma_fence	*tlb_fence_last;
+	struct list_head	tlb_flush_waitlist;
+
 	atomic64_t		kfd_last_flushed_seq;
 
 	/* How many times we had to re-generate the page tables */
@@ -379,6 +383,8 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	int count_bos;
 };
 
 struct amdgpu_vm_manager {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 95dc0afdaffb..57ea95c5c085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -643,13 +643,13 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	if (!entry-&gt;bo)
 		return;
 
-	entry-&gt;bo-&gt;vm_bo = NULL;
 	shadow = amdgpu_bo_shadowed(entry-&gt;bo);
 	if (shadow) {
 		ttm_bo_set_bulk_move(&amp;shadow-&gt;tbo, NULL);
 		amdgpu_bo_unref(&amp;shadow);
 	}
 	ttm_bo_set_bulk_move(&amp;entry-&gt;bo-&gt;tbo, NULL);
+	entry-&gt;bo-&gt;vm_bo = NULL;
 
 	spin_lock(&amp;entry-&gt;vm-&gt;status_lock);
 	list_del(&amp;entry-&gt;vm_status);
@@ -657,6 +657,38 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	amdgpu_bo_unref(&amp;entry-&gt;bo);
 }
 
+static void amdgpu_vm_pt_flush_waitlist(struct amdgpu_vm *vm)
+{
+	struct amdgpu_vm_bo_base *entry, *next;
+	LIST_HEAD(tlb_flush_waitlist);
+
+	if (!vm || list_empty(&amp;vm-&gt;tlb_flush_waitlist))
+		return;
+
+	/* Wait for pending TLB flush before freeing PT BOs */
+	mutex_lock(&amp;vm-&gt;tlb_fence_lock);
+	if (vm-&gt;tlb_fence_last &amp;&amp; !dma_fence_is_signaled(vm-&gt;tlb_fence_last)) {
+		if (dma_fence_wait_timeout(vm-&gt;tlb_fence_last, false,
+					   MAX_SCHEDULE_TIMEOUT) &lt;= 0) {
+			DRM_ERROR(&quot;Timedout waiting for TLB flush, not freeing PT BOs\n&quot;);
+			mutex_unlock(&amp;vm-&gt;tlb_fence_lock);
+			return;
+		}
+
+		vm-&gt;tlb_fence_last = NULL;
+	}
+
+	/* Save the waitlist locally and reset the flushlist */
+	list_splice_init(&amp;vm-&gt;tlb_flush_waitlist, &amp;tlb_flush_waitlist);
+	mutex_unlock(&amp;vm-&gt;tlb_fence_lock);
+
+	/* Now free the entries */
+	list_for_each_entry_safe(entry, next, &amp;tlb_flush_waitlist, vm_status) {
+		if (entry)
+			amdgpu_vm_pt_free(entry);
+	}
+}
+
 void amdgpu_vm_pt_free_work(struct work_struct *work)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
@@ -673,7 +705,7 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
 	amdgpu_bo_reserve(vm-&gt;root.bo, true);
 
 	list_for_each_entry_safe(entry, next, &amp;pt_freed, vm_status)
-		amdgpu_vm_pt_free(entry);
+		list_move(&amp;entry-&gt;vm_status, &amp;vm-&gt;tlb_flush_waitlist);
 
 	amdgpu_bo_unreserve(vm-&gt;root.bo);
 }
@@ -708,11 +740,17 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 		return;
 	}
 
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-		amdgpu_vm_pt_free(entry);
+	mutex_lock(&amp;vm-&gt;tlb_fence_lock);
+
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry) {
+		if (entry)
+			list_add(&amp;entry-&gt;vm_status, &amp;vm-&gt;tlb_flush_waitlist);
+	}
 
 	if (start)
-		amdgpu_vm_pt_free(start-&gt;entry);
+		list_add(&amp;start-&gt;entry-&gt;vm_status, &amp;vm-&gt;tlb_flush_waitlist);
+
+	mutex_unlock(&amp;vm-&gt;tlb_fence_lock);</pre>
    </blockquote>
    <p>Because pt bo attached with tlb flush fence already, so
      amdgpu_vm_pt_free will not free the bo, the tlb flush work will
      signal the tlb fence, and then the pt bo will be freed.</p>
    <p>To add freed pt bo to vm-&gt;tlb_flush_waitlist, and then wait
      for tlb flush fence at end of updating mapping is unnecessary,
      this patch seems redundant.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240223134206.899-3-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap=""> }
 
 /**
@@ -725,6 +763,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
 	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+	amdgpu_vm_pt_flush_waitlist(vm);
 }
 
 /**
@@ -1070,6 +1109,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		}
 	}
 
+	/* Actually free the buffers now */
+	amdgpu_vm_pt_flush_waitlist(params-&gt;vm);
 	return 0;
 }
 
</pre>
    </blockquote>
  </body>
</html>
