Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D59C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 14:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B28A10E567;
	Mon,  6 Jun 2022 14:28:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599CF10E2F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 14:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZvyZKVoMGa8infqwXOyrX9f8P35F3XijeYmegs4Qge+c+H4GZZWNJsAXdiQmcpDblJ52/DrgragP+5iaptHmo/oiVXryJYIDrhzciB5PqLGOHg9BzNfTuixmrugQyB5Yk39WI2lYJrikeKTcYXZni/OsTPczpocSTewDzLTFsICd7OqroK6wQRdqNv6aQvPV9udPgc5mtupOHEiyWzv9ulvFu9VPc2fuK6LlkKofWaQfnKHzF655qXmcM0o5HFsD/Jt2vtWyb4x1VoKaHydLjHPvW/4yRSZ8jcGAEaIQHE4hjPWv5cCKlQDPrNMXDBti6YCS72GfthbjvTA/iWZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTZrpAo6nC6rn3zoqM0KcxftMV5ZOu5J32lsSfWYAG8=;
 b=e5fkQi1aJFhMzFYFN/G8gzwGw1p+JsAEoti2F6lZ+Haym4F+9EJa91CMjT/tLkwq2gW3d9fzG9VhcASjNHTpdTAWF7O/a4gKi1o7FW1pV6l+puS+0QaenBrImq9aLrRo5NUd8vW9/3y3HbATWNVFYk9J5EZjD2mfVzweHUT/kR5p6kro17J/LpKJ7a9yoRXDIGDEWbfKo3xOqXlxBSByv5jiiM8H+bzmxQPbYoNKeC99pOU3tqVVCiSGDA94RrF5L7zGtALD6kLFoOzm/JfxwPRhPIeQr77LM7wvk0kxvHYJJvQP8uEWT4f5qRRKARw1WPd9Ta2ynRPVHbU04b9xvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTZrpAo6nC6rn3zoqM0KcxftMV5ZOu5J32lsSfWYAG8=;
 b=viYdPAA4az1lcv6RZxAHdVoW3hhGuSGhri7az1+qULhfHDii7Xo+cD57GJhVyL1ShuzlSsADlK4dRjFYhlHLyUZIfbw4JifJ6mE+d0UleNt2NKkUgsiaeprljmGpIoxyFEwfJ5tq9AA+ntkwWmUwywErj5C+nZq76HF2D1dXlJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY4PR1201MB2468.namprd12.prod.outlook.com (2603:10b6:903:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Mon, 6 Jun
 2022 14:28:45 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:28:45 +0000
Message-ID: <980be872-e72d-d19a-33f2-5a03804d8e4b@amd.com>
Date: Mon, 6 Jun 2022 10:28:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: Document and fix GTT BO kmap API
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220603184956.24168-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220603184956.24168-1-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:208:236::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c99755a-313d-480e-1e47-08da47c8dcc0
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24682ED39D2E368B970EF6B7E6A29@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9itkmAtVjFYMHY7voG88YfI3nGANk2t+ai5SnuGaeeNxShy7boAHTa9o/WieLjV6WnooaC0M86q/irgroCiXJZkBdkqjai9dknqDKWvHf/k5J+ccA/mGT7qwv9N+iW+MK8RRMUosvzh3oaIJhN0MRJ6x82n6UG9+OLKJwdp7yQTTCwPWK/OrS5evorBD5+c2bFxpOFXxXSovCJ9lOJPcnSPJR9gFfCazvaz6g35C40HVnl3TRbf5gowBt2WMWLGH830cJGeuCnguDONLP9vQ1zLqRDSxgz0kjx/3pM+ArurVr7fscZFllpaGYTLI8GFtShnQUrcMEvTk1InwwlNeYflxTxWHkuilU4wLNYp2ENlcLuip2dSmkctMxAKKfj7Kljfz5HP9fWB6R/7J5TtZyS5p3pZWSgmS4HK1h2Mb/HkL7jdH3QImBdg4LmtF9znDKRLSCKd4fd/p9IZpg/ORKTkCb4TrkcJSRePx5FhFlkHhpCkf5kfxilUulzVvrk+7zfBIPqOVIAlAxWZ8qJvNpYOduJJ1m4qpxa7eG/bO2y6dk8gWKVSJlgIFkQokAtvu3PwvEuMEV+7ALcoADIXVgDd9l7Seu8rISHShSJCehAveTrqKjhwiE9lzLY5H/8UwUnC2xfz5HKyAnuzZzb56Q0ULQgJPnuPUedPWkheHEYIx+RXfqo+LNRrtpnjCqmbgbwANi2k7VNdK5ZndCvJ4lvIwarhCxT/l0lSFz1dFLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(6486002)(38100700002)(186003)(2616005)(2906002)(6512007)(6506007)(26005)(31696002)(53546011)(36756003)(83380400001)(8936002)(5660300002)(8676002)(66556008)(66476007)(508600001)(66946007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVJsNTcyTkxueE9LSmhXUnFTWDJRalJNZkM2SWNUejlocEs2NFJRT0JtZGw4?=
 =?utf-8?B?azRJTkhzbG5RcHdGdTAxbm11L0U1bVNVMmhmQm00RjlhbFd3d0lCaTE2ZUQw?=
 =?utf-8?B?WXlIZWozdWNLYjRuRmJpbkthTGlmRVk3MXlTZnIrbFE3UFhJQUM5MytKcVIx?=
 =?utf-8?B?NnZuMDhHY2xuRGZySFJVZHhTdmV1MHBwSFVGenJDZnRRK0NVUk9FQW5MU1B0?=
 =?utf-8?B?VVR3c2JuMWgyVCtBeENiOTRDQ0RERHdnSWxHNlBJU1ZIMGw0WjNwb1lVcG9Z?=
 =?utf-8?B?QU9MbDJMRjRxb01LUzN1c3ZTdTcvQ0lRS1NMR2ZqNXJON2szZjI0VEkxOVBY?=
 =?utf-8?B?YlBtOUdUNE14RHBacFB6ZUVvbVk3c29oVDB0aCtEZ3hDeDUrS2R4K0RNZUR2?=
 =?utf-8?B?TmhRU3BvQWZKamV5Y0tCUmJZbmlaTXQwZ3NaS1psS3BZVWxOWXRoaFZQbkNr?=
 =?utf-8?B?M1MzN3JDVm14VWpBRlFiMGVlbVM4d2JFS0gzb2xpSXdOSWQ2N3RqNU5qK1JF?=
 =?utf-8?B?b0g2SnVCZHhDRlNQMkoxT2YvNGdJb3A5TmY3dm93Mmp5S1pLQks2S3FqQjky?=
 =?utf-8?B?Y1Bwdnd2Q1NIR0JOQmdzOUZ1ZnBiTURnRWlRLzVBVGlmY2NHbklWKzBTTTdr?=
 =?utf-8?B?aEpzM2N2QjFhOFZpR3JOZUNQNnFCek1TYTB3ODhtZjcyVmlUQlBQcWFNOUNG?=
 =?utf-8?B?NmxDUGZKelVNS2U4V3h6KytWbnFjTG5IaEMxQjQzc29oZlhveTlJcENMR2dP?=
 =?utf-8?B?QUljekdqb2cyaHB6U2Jaa2VFMzBUcm9WSW9CdmplOG5vT3I5dEE1UVhQSWc1?=
 =?utf-8?B?V3NMNkk1cmR6M1hIaG1FdzdKMkJ0Q3BFSFpnSllOUThUcUoreDJxSE9KSndG?=
 =?utf-8?B?by9zREhrN2JYMm5IZVc5SHpkc0JRcVZqZ3R4Z29wWG1pTUgrVzM4VWlOK1RK?=
 =?utf-8?B?VG9wQ1BSWE1EcThOajdqYm44SUtPQmtiYjVLeHlkV0twWnBSMVRtSXlsdXpn?=
 =?utf-8?B?UlQwUjhLcUVsZTI4MnJWdFF6Y082dXhZQlZtVnNuTFFrZmJoQ1E0a2lqY2ZN?=
 =?utf-8?B?VnY5djRYckVPU0ZkSkVmbTBudkNXRU9tZDZBNXFPcDVybjQ3WEU5MUVNRDJK?=
 =?utf-8?B?WDhkdWtHalRiMkRPbjlTL2lGYUxXNlpBaEdGeVp0NDZyKzhYaTRXSS9ZUjlh?=
 =?utf-8?B?b21zMjR3MHRPTWVhaHBZMHZvcy8reFdUYVprbi9SOEpESFJ4S1NVaFM5NHhU?=
 =?utf-8?B?cHBaUmFNWUFUZmVBQTNtL1phNDRNd2hiOHpaUTdYZHJPaEVvVUtvNm9LbUsw?=
 =?utf-8?B?MjRnTmFKMUxJWlBXeVlXZXdVeXd5N21OUzIwWU5wdm13c1pqOStZbG80T2tQ?=
 =?utf-8?B?ZC80YUFVRVBGZGVqMzlpVXI0bEZMaDM4M3RhcVVCM2J4MjRFSmh6MTZjVHdJ?=
 =?utf-8?B?b1lIMkRWYmlkZnZpZmJGWHROeGdLVWhLUHNEVmViV3FBTzhjMTZwY3Mrd0s4?=
 =?utf-8?B?SWN2WmdQTG9GUzlUdU4zbG5INHN2V1BiM3JsV0hwQk5OTmZaRlNrdFZ5bFZL?=
 =?utf-8?B?Q3NRL3BVc2tORkg3c0Q1MzVKamowalRoY09IM29Db3UxVW9TYUFQR3pFVzNW?=
 =?utf-8?B?eWREbjdLVnQwcUI0dWJ4Ukx4Z1ZSNWVxc3p6blRWY1NKS3NtZ0FxeUJDQk93?=
 =?utf-8?B?OWI5S09ySVRORS9UREdOUkVIWW1WNHRTSnp0U3VzeHh2MHF2N1luMFdEZHZp?=
 =?utf-8?B?WWVXb0lNVGdYYldNZjI4bXJmWmJKVTR3YVNhZWFaZzFVVW9YWjhkY1o3TkZO?=
 =?utf-8?B?d2FhNVlHbE5hcHFZanRnSk43SHpZREU5OE0wMVlweVZvdm9ZL3BtWnFXbmhK?=
 =?utf-8?B?dFFGdFNtVm9oLzdlRTVPMVd3WHp6emg5OXVtWFp2dmRKV09KaVFFZWRLWitC?=
 =?utf-8?B?YzBqMS8yMlNOUE03VmpCVUI0cnhvaTZ6NC9MaTNLaThFZUtwaFQxNWJFQ3F3?=
 =?utf-8?B?Y1FBeXI0Z0xEMjk2L3NTb3ZsMktJSVFEUE14YnRyNG9XOC9sYWNmcDBNaFls?=
 =?utf-8?B?QWF0M1JIcnBST29WZStZTTl0ek9mc21Fb2FKM01VaXkwUmI0MVppS0NGS0tB?=
 =?utf-8?B?eHhJNlZhMlFCRHcrU0RybkpqL2Q4eEkvNlpiOXRXZ0JybGdSYW0vNy9ZSU5w?=
 =?utf-8?B?Z20wUlgxWGprY0lZM3AvT0hzMXlOekNaanVPUWl0T291Zm5ORUptL2RTNGxW?=
 =?utf-8?B?NUNPOFNLa1JrOTJEenAySUlCVmQzbCtFNjRYN2c3NFZwUk12WGJkSVdtWkdC?=
 =?utf-8?B?NEgzdUpiTzVpeUFlYVJxVG9MLzF5MEVNdnQrV0QraGxkRlRHZlhEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c99755a-313d-480e-1e47-08da47c8dcc0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:28:45.0230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaQQVzTMkNONnfRKOVQcdTvchdOGnnUMWadJ44Gy4xw0m0EIAMsR6eIJylnL0I+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
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
    <div class="moz-cite-prefix">On 2022-06-03 14:49, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220603184956.24168-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">Removed an unused parameter from two functions and added kernel-doc
comments.
</pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20220603184956.24168-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 28 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  5 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  6 ++--
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..38c1a685cb24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -279,10 +279,9 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
-		struct kgd_mem *mem, void **kptr, uint64_t *size);
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
-		struct kgd_mem *mem);
+int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size);
+void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 054e4a76ae2e..763b9bf93671 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1942,8 +1942,21 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 	return ret;
 }
 
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
-		struct kgd_mem *mem, void **kptr, uint64_t *size)
+/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
+ *
+ * @mem: Buffer object to be mapped for CPU access
+ * @kptr[out]: pointer in kernel CPU address space
+ * @size[out]: size of the buffer
+ *
+ * Pins the BO and maps it for kernel CPU access. The eviction fence is removed
+ * from the BO, since pinned BOs cannot be evicted. The bo must remain on the
+ * validate_list, so the GPU mapping can be restored after a page table was
+ * evicted.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size)
 {
 	int ret;
 	struct amdgpu_bo *bo = mem-&gt;bo;
@@ -1994,8 +2007,15 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 	return ret;
 }
 
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
-						  struct kgd_mem *mem)
+/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
+ *
+ * @mem: Buffer object to be unmapped for CPU access
+ *
+ * Removes the kernel CPU mapping and unpins the BO. It does not restore the
+ * eviction fence, so this function should only be used for cleanup before the
+ * BO is destroyed.
+ */
+void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem-&gt;bo;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 4df9c36146ba..3942a56c28bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -377,8 +377,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 		return -EINVAL;
 	}
 
-	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd-&gt;adev,
-					mem, &amp;kern_addr, &amp;size);
+	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(mem, &amp;kern_addr, &amp;size);
 	if (err) {
 		pr_err(&quot;Failed to map event page to kernel\n&quot;);
 		return err;
@@ -387,7 +386,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
 	if (err) {
 		pr_err(&quot;Failed to set event page\n&quot;);
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kfd-&gt;adev, mem);
+		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
 		return err;
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e3d64ec8c353..a13e60d48b73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -693,7 +693,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 	struct kfd_dev *dev = pdd-&gt;dev;
 
 	if (kptr) {
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(dev-&gt;adev, mem);
+		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
 		kptr = NULL;
 	}
 
@@ -733,7 +733,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
-		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev-&gt;adev,
+		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(
 				(struct kgd_mem *)*mem, kptr, NULL);
 		if (err) {
 			pr_debug(&quot;Map GTT BO to kernel failed\n&quot;);
@@ -999,7 +999,7 @@ static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
 	if (!mem)
 		goto out;
 
-	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kdev-&gt;adev, mem);
+	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
 
 out:
 	mutex_unlock(&amp;p-&gt;mutex);
</pre>
    </blockquote>
  </body>
</html>
