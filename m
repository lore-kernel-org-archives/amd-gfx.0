Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C6C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 21:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FACA10E5F6;
	Fri, 20 Oct 2023 21:59:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8AB110E5F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 21:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgdDZMtEnsEFFiLQxeYb1Sp41UhdcSs0yZefiHXjWCIG3yeloPeVlDhDEimMnk/HppwQdwsOysUdckj9GqZiAvjMfOexVUb/5pBqc9KXZzRCKrIfqX7eQhgNj56ukz5IUJzcKhuNiAoJwECntT1CjBTzW5RdWSwCXPQwT3Y5CB4F/kSBuqTp7Eo5vIaJRfEsarj5ZSCfzHSoyW2k6mOhzcTuyRK2LttSWulSJo1mNz+4shsrlRiKis+Z9p/dWtaV2iLXgmOIHr4ZPVFdm3OU3tVGpNgLjuTO07xYx3erZNTnp4V/G16JMX6Din+Jp//AGTY0H3o5edf3/J+lGXEbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDWKrfd6AHe8WeEzadgCjXI81dIpQ9Qj2vnnpt8Lyjs=;
 b=WUcsDfaF+dFbfFih5N+a2jlB3c/eK1rHaibj6THxsVnVjaO7AZbe6R2Ee2wTAz3K9aHHpXiJw7jMvavsHUg35CuFJxZ/KrFTYr6ckOwwo5ZJ1ebc58m0aemR7ZFZuiJRA5tz0dcDYM0xj09r25Ac8ecV7gVj8ubOMd6UkQQZPLWcDdccjUxrWx67xRLbwNJuzA3VtzfqJvF2KAFW1CoUJgeCeAtc4kiPqkLWWqpeI/oMtRCex9WZpk2sZFAIeF48HtybLe5SmaUkEbabmyw/oYB5wkk4iDR0vNWdXBCAtx23IQfyxnvas/Yi6LpON7PBF7++UdpPmRfumdGRVki0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDWKrfd6AHe8WeEzadgCjXI81dIpQ9Qj2vnnpt8Lyjs=;
 b=sfUXNEnDDDCLBpuL3C0Ucj1hJig1c//xqgOJmuxR8Y5tA3J0FM6z3E5/Ihk6cZNKBgOD7JCnQ2eCPrBqE96RUOrvWU0bzPyDof8STj1zJmdk4KmrO2YOel5WbSIOeMz0lDV1YAdc//Xy9ZyvH4jwNQ67RthWVscke+209XzGc2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 21:59:04 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:59:02 +0000
Message-ID: <dea70c06-2040-55c6-6199-4b86a8aea5e2@amd.com>
Date: Fri, 20 Oct 2023 17:59:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Use partial mapping in GPU page faults
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020215316.247816-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231020215316.247816-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BL1PR12MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a8019f-c57a-4341-feef-08dbd1b7c4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIDsrsZyXFJZSuO+sbDzfpsC5YpRo5i+EJ+YG00mBBP2Olthvnx1Dj2WQ73vFDBg1zLaqyq5JFlrIFsd5dMTveyX4qmpnhT0qBNGJxlhwZCtBMAqBKFAb55ftrorNXYlvT5tmW2uk2qjyrWIj68WHco1YWMaDx3QIhzETiWhgR9pFgV0gthaPEDdJUnTLB5eUa565BGjqC1fOvkpCdqtdwkqBKJwwqdLtWdzq1ZSKM8h8mL4NNx7EXiktCv8U59BGDCuSIdoOfZlqCF1hyWffi6SCto6pVwdqbi4aEr9EB45kozJPhxBXUZX/sOQdYPC6UxivkrZ8YiqOE6nbxOclkmjXl00DO5Yb4munFk8JMqeepeqKOEMd4pOMjVEc0/+2r3FfihbC3M4qxGDkLXdgfAEbbFewZdvx167QzPTHQ/PHLJn1CRLFeC6aoGXjxGcMOwLRiIUKLIz8QkY+Ef18jvvkgivAW6kzoQ0BNyqcpR3xYevxq+HU8q7DitZ0XY4t2HCO4xf6cRJ5u353k7DNO/YYU+FrKlB4iENTJYXPOlmIAHtPfTwCf+bxp5muoIMv8iNL6q0Blm6TZo7U/RxYcquanO3sm5pfUAd+U3QiIwUphuTJyELelLEPTYJs4o3hFlWAyLCcDZGxQFCNhAc6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(31696002)(36756003)(316002)(66556008)(66476007)(66946007)(2616005)(53546011)(6512007)(26005)(478600001)(6486002)(6506007)(41300700001)(2906002)(8936002)(4326008)(4001150100001)(8676002)(31686004)(5660300002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW1PQ3R1TVRzSjNaY20wUk4xbm5GSUJQYmMzdHJ4cHRHelJRWmU5RDFCQ2lx?=
 =?utf-8?B?SE5YaGkyMzAyVGpvZXNOTkNsQk5ha0RMcTZiZmpaU1VBUzM5UjIwS3dEeUxj?=
 =?utf-8?B?WndWVmRtTmhWcWVVVk9UYkY2SFppOVpmK2trSkwxNUkyYkM4ZHhWa0hibkYw?=
 =?utf-8?B?eGdZbmRCS2xYYWRnSk5VTDBkNjdtekJPejNkNkZEaEtGQ0NsVWVLeVVtMG5E?=
 =?utf-8?B?ejljZDEybGJMNmVUakJlcUNhT3M4Z2E2VVdrS2Ixd1FnNExaUXlvZytNRncx?=
 =?utf-8?B?TThYRmpwTThRTG03N0N1Uk1VbnVLaHRlUFZSSTQ2QTM5UEVaZTJYUGpTY2pX?=
 =?utf-8?B?MlJEMEpMTHNFdm4vRnpHYnZmMXg0Tk5YOUo2cUdPTkFTaXlLUFRFQ1dCSUxT?=
 =?utf-8?B?OEhrMjh6V05BTlptY0FqL2JVZ0RqMVc3QnE4ZGtBU01Ca0IxOTZDdE90WGNt?=
 =?utf-8?B?a1NkTzJJMmNGT3Z6eTdXVURZc3hnSXZneExVWGFyUFpIc1NaMXpaVElBZ2g0?=
 =?utf-8?B?REl1QitSY1hxMWtVYjBYbWUxV0Q0RDRpWHFWOEdVMG9TVWRyb2NibGFTemZy?=
 =?utf-8?B?L0dIRnA4N0dQUDRreEl3M2NEZUZDd0Q1UDJzTTZCTlZLWUNNeFBQeXNxZWk4?=
 =?utf-8?B?L0RZbzBURzgzOEpWT0RjVlRXQVBHVi9oeFdDWGl3U2VyR3dZOTdNenM4VndW?=
 =?utf-8?B?ZWh0aVcrL1ZEdlVWZmt6eU9ja2pmcDhpNFE5Q29QN2FzS3NRcUt0VzZqR0Jy?=
 =?utf-8?B?M1JyRkZVdmJXSlhDaU82YnZ4bGlDUDZnSENzMTBVMWNpanBuK2w1ME15dHhl?=
 =?utf-8?B?RUNLWWxaZE1oSk5sa3kySExZSUZWOHA2cEVoemsyMS9UcFdCSklFYXVEK2Yv?=
 =?utf-8?B?eDRxSWlJTTVEUmJNUjVtZ2RmWGZKNm84aFh3ekVSNXJpcWhXTFpTd3JYM25o?=
 =?utf-8?B?U3AzMzZzUE9RNzNxb2lDdkhJWGtzK3VGU1crZ20vaHU3YWdqWVZEK3FjTS9C?=
 =?utf-8?B?Y2ZoeXpYVGN0Z2hQa2VOWWpjNXFFMjVWVGZhQW9ZcFFxRjEvdGM4czNQYjAz?=
 =?utf-8?B?NDczU1RFcFpNWll2VXdMSTlHRlkxZDBTdzB5aFhrNG13K1F2c1hYUk9jWmlV?=
 =?utf-8?B?d05HekM1NXFmSElIc1JyQi9COTNWazlybUY0UWlTYUNrUTJVVmVVVEcyVEoy?=
 =?utf-8?B?ZE03cGxRZ3drTjQwczhNTlk2Zk5MSGlEVGp5WlIvQTc1R1dvUlN3Zk9hdE5O?=
 =?utf-8?B?YVBPaWlFSEZ0ZkRBTVNtM1oxVXFCRHp6NERYYlp2b2UrbHpUTVJDazVQYlpk?=
 =?utf-8?B?YVhadGozeW82bis2anhidGZHa3d6RDB2amlxVW1UZXRSQ0E3TzZZbDI5Nlk4?=
 =?utf-8?B?YkpYdkoyZTFqc0dVRE9sVlZHWlVIRUJJZm1uV3hOU2d1dVAvVEE3aUdoQ2FV?=
 =?utf-8?B?MU5SdXBhZjJSZDV2VEVVdm92M2RLZmxjRlFUWWZSV0NTNFdVeDB2TzdxbjVS?=
 =?utf-8?B?QTRiUEU3L05GTjhzRlVMT0E2VDZwbDRhNzZsemdBV1JmcjBDMzdPNDdKV1V0?=
 =?utf-8?B?eDZZY3IwNG93Q1hDY0dyRDI5UW03dmkwNUNtbWxYZ1k0MVF4R3NVQS93UzBT?=
 =?utf-8?B?NkFCWW0yRWFSVURYOTdlblZEYXJkT3VmcUhhTTVRNFM2c3Q5RWk0b2Q0b3BH?=
 =?utf-8?B?TDE4NG1vZ1k5cHY4YmtPWFFuQUg4Vm9QMkt4R2gxRFFNdFY0cjRucDBSbWlW?=
 =?utf-8?B?ZWtPVUZya0dwUzBGSW1rVXYraU85S2hqcE05WXBCMnB3Nzh4WnJDbEJVU05F?=
 =?utf-8?B?NlRuekZLVXFXTisxN3hyYzVrS2tIVkd3VzdKL2lHejRRY2Fub2JSNjk4WURJ?=
 =?utf-8?B?c1hDTzVjclZRTU94VVJSK2R1dlZPNkxSeUZxV1lMYnpBM0JLbjh5K2V6U0ln?=
 =?utf-8?B?Z3BOMXRMQzZJYnY0SC9uZUlyYTdTMlFVSjVmbEpZU0c5TlZGTnFyVkp3bXdZ?=
 =?utf-8?B?Sm5zMjdkUUR4VkE4RFRjeGE5Wlo4a2U3QjM3Z2daNlpIUG1XQ3FsbzJCWTVn?=
 =?utf-8?B?K3cvOW1mY1ZaZ1hrQ0Uvbmt1NDJ6cFVFSWZOaVZlMk96SExGdFZEQm1PckZK?=
 =?utf-8?Q?Eis8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a8019f-c57a-4341-feef-08dbd1b7c4e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:59:01.7280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTGUfG5cv7w6Ltv3tRpFb7uN1eYORu5BQV1VfMFN88Xqp2weBAUrORyAl+oAXEIa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-10-20 17:53, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231020215316.247816-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

After partial migration to recover GPU page fault this patch does GPU vm
space mapping for same page range that got migrated intead of mapping all
pages of svm range in which the page fault happened.

Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20231020215316.247816-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 29 ++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 54af7a2b29f8..3a71d04779b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1619,6 +1619,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  * 5. Release page table (and SVM BO) reservation
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
+				      unsigned long map_start, unsigned long map_last,
 				      struct svm_range *prange, int32_t gpuidx,
 				      bool intr, bool wait, bool flush_tlb)
 {
@@ -1699,6 +1700,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
 	for (addr = start; !r &amp;&amp; addr &lt; end; ) {
 		struct hmm_range *hmm_range;
+		unsigned long map_start_vma;
+		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
 		uint64_t vram_pages_vma;
 		unsigned long next = 0;
@@ -1747,9 +1750,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = -EAGAIN;
 		}
 
-		if (!r)
-			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-						  ctx-&gt;bitmap, wait, flush_tlb);
+		if (!r) {
+			map_start_vma = max(map_start, prange-&gt;start + offset);
+			map_last_vma = min(map_last, prange-&gt;start + offset + npages - 1);
+			if (map_start_vma &lt;= map_last_vma) {
+				offset = map_start_vma - prange-&gt;start;
+				npages = map_last_vma - map_start_vma + 1;
+				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+							  ctx-&gt;bitmap, wait, flush_tlb);
+			}
+		}
 
 		if (!r &amp;&amp; next == end)
 			prange-&gt;mapped_to_gpu = true;
@@ -1855,8 +1865,8 @@ static void svm_range_restore_work(struct work_struct *work)
 		 */
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true, false);
+		r = svm_range_validate_and_map(mm, prange-&gt;start, prange-&gt;last, prange,
+					       MAX_GPU_INSTANCE, false, true, false);
 		if (r)
 			pr_debug(&quot;failed %d to map 0x%lx to gpus\n&quot;, r,
 				 prange-&gt;start);
@@ -3069,6 +3079,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p-&gt;lead_thread-&gt;pid, addr,
 				       write_fault, timestamp);
 
+	start = prange-&gt;start;
+	last = prange-&gt;last;
 	if (prange-&gt;actual_loc != 0 || best_loc != 0) {
 		migration = true;
 		/* Align migration range start and size to granularity size */
@@ -3102,10 +3114,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
+	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
+				       false, false);
 	if (r)
 		pr_debug(&quot;failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n&quot;,
-			 r, svms, prange-&gt;start, prange-&gt;last);
+			 r, svms, start, last);
 
 	kfd_smi_event_page_fault_end(node, p-&gt;lead_thread-&gt;pid, addr,
 				     migration);
@@ -3650,7 +3663,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp; prange-&gt;mapped_to_gpu;
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
+		r = svm_range_validate_and_map(mm, prange-&gt;start, prange-&gt;last, prange, MAX_GPU_INSTANCE,
 					       true, true, flush_tlb);
 		if (r)
 			pr_debug(&quot;failed %d to map svm range\n&quot;, r);
</pre>
    </blockquote>
  </body>
</html>
