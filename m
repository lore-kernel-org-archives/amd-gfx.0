Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A25DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 15:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2670A10E21F;
	Tue, 15 Mar 2022 15:05:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2DC10E21F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 15:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0nQ9TJ6I+RByg4m4HboPcAYzgJ3KR7MZDNMqrkOPoRYWXlu9/udcConMixcv9cUMKz7Yp6yiljidBayR8QyqhtUss2v4wUdroZcySt7zNYko+RLUKDQ8oPdRICuEWAWCnVAgYr2qaUmQWxUMQV/IVLq6b3DyeDkcw60ied2k/UpGtGo+6GdmKV5AVLbWaQxm6+7GwPZNEZhj4j1vAKBSWHw1+0VNNzul0KptWTLKyIOtjA84KLawO/zkLEtC3xydn7GOpJ7p7hfVPCKj6hwSvdy7Si35sesTyOrEBYxBfpGB4gw4212yHBPqRccZNCrUZklgGTpwuT27TfuZDoUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnGLttxPrla115rWbCvr/JeO5ajSXiZF+7Dci6A3nac=;
 b=WVmZwRByLA8Ykm4HGhRTnEVfj/VKBBNgeMnXfCVnKb/y9uoysRSn5aLp9c7CutIlFWBB6J7OcTjNPuOKp8BJZNkp2V/NL2SCEb8ydu53IfjFRzmr/iVF/cKubNtlz6yi0k5Yu8lsU3TJlcOvX9rYOws9yyS1KUuKomeK+dDiy3LPOkrzvcmg/D3mVawlDXAZDjy/vLdXr2YJm5c8AFXcrIe/RlmRUmUjwSMuj88k6mjjH+KQczSIFgL98nnNv8LHn3laMII9QlgLisnTmuYIwdgm+Yf+BqmxCwp10AxdVrQGVhKc0vyhw+1xt9RI4knKUJuAZrbcRJHSTESdGTi2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnGLttxPrla115rWbCvr/JeO5ajSXiZF+7Dci6A3nac=;
 b=kh8ztFzdxK+gbuFrtYPke5rKkCCuyoP/C+jqSly4zPMFkjDkxRqQ8Sw/0ixXOwWI09e4mh6STl5ymHOeB1/UIj2sRjLcBc8kqI2ucYhFVum7pDTXVt0xBEFCK1SiviWKR0e/vB6SqZcPanK4eLmv5XwMy9J3ChPOG02/SvJNnrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 15:05:41 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::ecac:8946:43b0:c1ec]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::ecac:8946:43b0:c1ec%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 15:05:41 +0000
Subject: [PATCH V2 1/1] drm/amdkfd: evict svm bo worker handle error
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220314145020.9142-1-Philip.Yang@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <7fe7133a-bf8d-66c2-7fbc-7d49c48454a9@amd.com>
Date: Tue, 15 Mar 2022 11:05:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220314145020.9142-1-Philip.Yang@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:610:20::38) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e777c7-299a-49c7-4b85-08da06954595
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB528645ED7824EE5ADA2BB3E2E6109@BL1PR12MB5286.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7ORGYa1IgILl5adLfnTstCrBqi9r0DGt2eYajqPGTKs7B5fDOzO0nssyV6fkTxxZuoTSvGLSXXLfgRVj8EUov4LaQWk24Vo9T9pUQmM9i3finfAVk5e1A2nOG5cjWt7zH1KyvoUKhLeI/5WSydqC39OX6okGy12FkaIrVuITLvHJ8G9Jm7PA/nazxo7GUEtUJvxYt6V4kAy28pw0qISunmf/Lirz3okfIdaizGZx7XG3byhAzzFacssH/GXhCMb0XzRqyVKUPwRQiJf9UK79SB9v3OnoKlgfuqH6vq8R12MrgrUiwm6V9EW544NxX038QNeDsEMgnYpU0aa/0eXGYVSEArtxS3A1/aVkJx3t1hF8yilmme+M+h9K+aRaPue0xu9slYZ6zT7Y0WrsfymuEQg+bKvM4AmJaebkxUCbi5nJYmGRv1GIbestlAhd/WkKZ0Qpp5HACeri8DB95nGV3l6u5n6wYuzPHyN+rT+PQFEX2Usp6hqlY1oc1CyxvcAPVjdwtzg4KnVS0t3jLQJjhdHSa0X9wZ5zSdzUN1+xdcEEo4XfeBQuHJ/Sn1QNB9yGboDIgOxPpq/okqgvld6KhUXNWlU4scXzMeplfYXV0+YLCHG+msI6FGo8NsB4aam6bLFj1b1PshxSGzKrLSUOrLvmQgVkGXLXq+80/NpX9n39gEmvZMbLq5RIZd8xVo163Yqod44SrOg6GeSBRpjy8gQMJDQ8bUX1fC08O2YcuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(6506007)(6486002)(508600001)(6512007)(2906002)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(2616005)(38100700002)(31686004)(5660300002)(31696002)(8936002)(83380400001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWsxa3BwYWxZN01IRldMNzcvOFNSTU1mU0xmVlduRi9VY2oyL3ZkaUNPU0R3?=
 =?utf-8?B?OTVZUnl1K3Z6R1d1dEJCN25HZHVNL09FdnF3MkEyUk0zU3c3eDVKaHo1cSt3?=
 =?utf-8?B?Ni9idVI3UEdIMUZKNmhRWGZtSVU4K3d2NnJ4RzlPZUl3Yk56OTZiWTZuSkc0?=
 =?utf-8?B?ZEE2MCt6djByMmZnenliUmU2Rld5K0RLUFY4cTFrYzExdERWY2plVjVidXBB?=
 =?utf-8?B?M1hqN0VqRFRhUVVnbjNmdkVTRkhPVmFKOFVDdVUrTW5BMHY5WnRzcHJuazBD?=
 =?utf-8?B?bjJNeGhMa0pjcTBTTzVpWU92QmlvbmZSb2Q5L29uT1doQm9EWEF3ekt6bTVw?=
 =?utf-8?B?WGtVNlJTbTlPcmxwZGt4NlV2RWJxM0ZCVU95ZmYzazRQWC93UVNZODlpRUJW?=
 =?utf-8?B?TTNCeCswVGg4Y3Q0KzF2bi9GeUpyc0JCOWhXQjJDQTZVKy9GRXFqUFRNbFFC?=
 =?utf-8?B?enpuaEFXSXdVWG5uRHRJbEhqVUZ4NDRRY2ZIOXN4RHQ3bGxHM1dhWStGYkVx?=
 =?utf-8?B?bFpkVC9iU0JVNXQ0bHFvZ085eURFRnJWVkR0YllWTEFXdmxBS0gyemNBWUVP?=
 =?utf-8?B?byt5RDZmVkI2TTBVVE9qSVhxaGNLUThzTW9BNDJublVZMU9nZmpKaHZMNlls?=
 =?utf-8?B?alVlRXFFSWpqT2RoQlBvOHQ4dGI4elRDTXhHc1Vsbkpkdk9qYmI3QkdrcktL?=
 =?utf-8?B?cnpMMXJ6K1RGTjVuTlNmenlUazhrWHo0dnJsMnhxb25kSndvQm5KVWJQdFRt?=
 =?utf-8?B?M0hzT3lKMmFWclQrMml2YlNZT05xOTRoUkhWVCt5am15RDZqQm5hUjVkd2J0?=
 =?utf-8?B?NGszVnRaV2dxYngrM2cxclpZQ0g1SzRWSklVVVNlcGxKZ1phNkFLK2w1VjRr?=
 =?utf-8?B?a0JQb1RkajJnbGRvQ1hLWnFmeVJQekg5RWcxajNKNXA4MkxCcG02c1IwYk05?=
 =?utf-8?B?RzNxSWpqY2s5QjZRTzVZamJ4dkthM3MwTG04eHFHUEQzcDFWY0RsRlpDQzcw?=
 =?utf-8?B?M2JLNWZCUmhDSVhUTm95OEFUcng2ZDdybTIyVlhrWUsvQVB6OE1QcWJkdTRq?=
 =?utf-8?B?SXQ5YUVBcDBOUjYxTGpWYWdoOFF4NDBxZTFmTXpoWXhSY1F5d2lPSlU4RWVk?=
 =?utf-8?B?Sk9VYk1VOTV5UnRybEs5Z005eGFUOVNHdElkTnpVZzltZk9oOG8wYmJ3b0Jm?=
 =?utf-8?B?WkpnZHpSVElzUTFUbDY2YVFudGxIQ2NMRU4rZTRZeDljdDF2YVhkZTFRY0p0?=
 =?utf-8?B?cWE1V3Nxc0doMnNxMHFYcjZXZEk3cmdlU2lZem9ZMldJOFJxRVNzM0RhcHlX?=
 =?utf-8?B?aFE2bTZZZ2o1c01YdnhqSjFSVDdNTFNlSjZsb1VxRmgwbnd6SGVVekpNQitr?=
 =?utf-8?B?Zm9zcllUNGMydEd2WXArelRpVHl4SUxBY2dYeXliUXJPZzRNYkd5ZE9NRXls?=
 =?utf-8?B?RXFCelBHbHRtRzFQcVV6dU81UWR5ZHNpV3lCRVZhL2JBZ0E0YUNMd3hnMkxJ?=
 =?utf-8?B?dkZEYkFTdzFLZ1Y3TkVBZDlhQ1E2b1h6OXdiQlFlbDl5ditzdklGL2ljekU3?=
 =?utf-8?B?SmZhZENOdSs3VmhuaUpsMEJwYm44dEtwUmhySmF0SHdGeHFCQzVwbmxvaC82?=
 =?utf-8?B?SkhUNWhCWVNaSG1uMXBkaXBCZkg3cnJwSVdvMGw3aFdjTGwrUHJEY0lsZU9V?=
 =?utf-8?B?TE9WV2tDVTR3RHN3bGhZdVEydUwrQTlBR1JKT3RYUVo4aGFzTmdwNTBkUmtJ?=
 =?utf-8?B?SUJhRTMxK2piRHZsMjloaEJmcEVKclI2VUFwcCthL0tVNVBUMjJRTmQwTVpU?=
 =?utf-8?B?NDNuVncyVnJqQkNQQXRsNS9EbzBVOUI4Y24xbEVDckNZSFBSbzdUMUZlOVRH?=
 =?utf-8?B?d3orQkFxU1Y2REN5ajRCSjJ4U3dDQlI3TzlGbHlwbmR0bllBYjJMNjJEZ3F0?=
 =?utf-8?Q?hXnSKI3utH3TRhY6Dq1Ln75etWBYTQZr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e777c7-299a-49c7-4b85-08da06954595
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:05:41.5058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 282ouHPe9/Q2YcokH+wi95IWeTy9kMCN0viekGHaEk6AUWKsuDDMxSZ/sSEcaqg5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
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
Cc: alex.sierra@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-text-plain" wrap="true" style="font-family:
      -moz-fixed; font-size: 12px;" lang="x-western">
      <pre class="moz-quote-pre" wrap="">Migrate vram to ram may fail to find the vma if process is exiting
and vma is removed, evict svm bo worker sets prange-&gt;svm_bo to NULL
and warn svm_bo ref count != 1 only if migrating vram to ram
successfully.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 28 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 21 +++++++++++-------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7f689094be5a..7187417273f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -638,6 +638,23 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	return r;
 }
 
+/**
+ * svm_migrate_vma_to_ram - migrate range inside one vma from device to system
+ *
+ * @adev: amdgpu device to migrate from
+ * @prange: svm range structure
+ * @vma: vm_area_struct that range [start, end] belongs to
+ * @start: range start virtual address in pages
+ * @end: range end virtual address in pages
+ *
+ * Context: Process context, caller hold mmap read lock, svms lock except calling
+ *          from svm_range_evict_svm_bo_worker, prange-&gt;migrate_mutex
+ *
+ * Return:
+ *   0 - success with all pages migrated
+ *   negative values - indicate error
+ *   positive values - partial migration, number of pages not migrated
+ */
 static long
 svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
@@ -709,8 +726,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		pdd = svm_range_get_pdd_by_adev(prange, adev);
 		if (pdd)
 			WRITE_ONCE(pdd-&gt;page_out, pdd-&gt;page_out + cpages);
-
-		return upages;
 	}
 	return r ? r : upages;
 }
@@ -759,13 +774,16 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 		unsigned long next;
 
 		vma = find_vma(mm, addr);
-		if (!vma || addr &lt; vma-&gt;vm_start)
+		if (!vma || addr &lt; vma-&gt;vm_start) {
+			pr_debug(&quot;failed to find vma for prange %p\n&quot;, prange);
+			r = -EFAULT;
 			break;
+		}
 
 		next = min(vma-&gt;vm_end, end);
 		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
 		if (r &lt; 0) {
-			pr_debug(&quot;failed %ld to migrate\n&quot;, r);
+			pr_debug(&quot;failed %ld to migrate prange %p\n&quot;, r, prange);
 			break;
 		} else {
 			upages += r;
@@ -773,7 +791,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
 		addr = next;
 	}
 
-	if (!upages) {
+	if (r &gt;= 0 &amp;&amp; !upages) {
 		svm_range_vram_node_free(prange);
 		prange-&gt;actual_loc = 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 509d915cbe69..3b8856b4cece 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3155,6 +3155,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	struct svm_range_bo *svm_bo;
 	struct kfd_process *p;
 	struct mm_struct *mm;
+	int r = 0;
 
 	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
 	if (!svm_bo_ref_unless_zero(svm_bo))
@@ -3170,7 +3171,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
 	mmap_read_lock(mm);
 	spin_lock(&amp;svm_bo-&gt;list_lock);
-	while (!list_empty(&amp;svm_bo-&gt;range_list)) {
+	while (!list_empty(&amp;svm_bo-&gt;range_list) &amp;&amp; !r) {
 		struct svm_range *prange =
 				list_first_entry(&amp;svm_bo-&gt;range_list,
 						struct svm_range, svm_bo_list);
@@ -3184,15 +3185,18 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 		do {
-			svm_migrate_vram_to_ram(prange,
+			r = svm_migrate_vram_to_ram(prange,
 						svm_bo-&gt;eviction_fence-&gt;mm);
-		} while (prange-&gt;actual_loc &amp;&amp; --retries);
-		WARN(prange-&gt;actual_loc, &quot;Migration failed during eviction&quot;);
+		} while (!r &amp;&amp; prange-&gt;actual_loc &amp;&amp; --retries);
 
-		mutex_lock(&amp;prange-&gt;lock);
-		prange-&gt;svm_bo = NULL;
-		mutex_unlock(&amp;prange-&gt;lock);
+		if (!r &amp;&amp; prange-&gt;actual_loc)
+			pr_info_once(&quot;Migration failed during eviction&quot;);
 
+		if (!prange-&gt;actual_loc) {
+			mutex_lock(&amp;prange-&gt;lock);
+			prange-&gt;svm_bo = NULL;
+			mutex_unlock(&amp;prange-&gt;lock);
+		}
 		mutex_unlock(&amp;prange-&gt;migrate_mutex);
 
 		spin_lock(&amp;svm_bo-&gt;list_lock);
@@ -3201,10 +3205,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	mmap_read_unlock(mm);
 
 	dma_fence_signal(&amp;svm_bo-&gt;eviction_fence-&gt;base);
+
 	/* This is the last reference to svm_bo, after svm_range_vram_node_free
 	 * has been called in svm_migrate_vram_to_ram
 	 */
-	WARN_ONCE(kref_read(&amp;svm_bo-&gt;kref) != 1, &quot;This was not the last reference\n&quot;);
+	WARN_ONCE(!r &amp;&amp; kref_read(&amp;svm_bo-&gt;kref) != 1, &quot;This was not the last reference\n&quot;);
 	svm_range_bo_unref(svm_bo);
 }
 
<div class="moz-txt-sig">-- 
2.35.1

</div></pre>
    </div>
  </body>
</html>
