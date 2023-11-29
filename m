Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5613C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 16:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7833710E636;
	Wed, 29 Nov 2023 16:26:11 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E22E10E634
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 16:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf7dYSbo7z2CNqQ5wH57fMAHNixgYuYdYfchxvMOxHdf5lzWSK2B+2kK9dueYtrt0SOM6yRDvSbN8XEoqfcLV3H6RcDPzOxmJRUVnStBT6RCHjPneGNrpJyWhAB8wWAPtthtBjrIBFEgY0K9weHat2x50VQn/zkFKtR+hG9jjRGQjkCporKmeyk7SbRfQCaH3JRf4pqU7wd2edxJ9rTajwfXzLcRh1be/S78s6HIKopOKY8MWrplL7v0p49BGId92tPBUIzqdYKIrN5AOxrI69sCQxCBc2aahVhsmf1qQeBLbv2wTgZjR5o21BbXtwGA1FO6Fk9x6nmy/4fo44hbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buN2OY3PMF7nCm7gQt1FXupb+gGZsp4eEt+yX7UK+58=;
 b=EbQ5M8iTBs0e1dIpCiq1JCtmgmEyglXpmLlcX+Viv59PpwrLUGaPc1aSNH/iWB7+1R6BK/4wmh/cpZWrzuynduh1SQMz+TeexTuCKT9jr8OtG+tVZ/wUL56DU+brtZ9yRdqf83dHOcgBfOsMdFUozzTEGZ6uLD5u1tniTJM1OuTO2XKU0/v4+hcy5qacAC2Lj+4XDfsZlBQxAviI83jBoadSdqYlLhx6E6t46LXz1PNEQ4tldWODr8Tk1oF1iNUFQeUhEWtBY+q5DqYCFxcq/hNNosHufkR655YWgZRGZ/UcbpTsbnuOTzu7rZNExdKkVa7mu5wuKxXYBq+aoqYPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buN2OY3PMF7nCm7gQt1FXupb+gGZsp4eEt+yX7UK+58=;
 b=NJRpfSECyEx4JXic5XUUfcnolFaORkhYxFku1PX19aVSHWsP9hDARUpsSIZO4FDPD6/qGG/yyu4UPaMba3SJ5cZ5qlfISsWzv1GCqLsBVXvSdvqKsKPV3NdZka2CBhOycWsITd5VbZNKFKMwKfvTU97YCr7VJjN0je8l+QqrulU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 16:26:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 16:26:06 +0000
Message-ID: <e4d05f9a-587e-7df4-a805-41d97d14d673@amd.com>
Date: Wed, 29 Nov 2023 11:26:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Use partial migrations/mapping for GPU/CPU
 page faults in SVM
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231114210137.57695-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231114210137.57695-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::35) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 284ad4b1-53c9-4b72-35ca-08dbf0f7e30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4khW6sYzBdpRkfyIQVjb0ooV0UR8mNvdTmkdup27wqdswn/UFUwUQqb9i9D5RMsCnU0mRNIsK8I1Nqb5dLQfxDmqLUF0UfZ9PphK3Z1cQdygQtyFzggkv6CasNWzJnmQhKxWwuVt1DDap22iCCQaF8kppbwbJL2b0nhuqXHFhPZwYoaB8VQ4xtFk6XGkYh7tuJxgTYP0QJV9lpHH8xa4rSt4/SD/1kaJKVcunn+Vgh0CP8gFPkH0VdbyrHU+Qv3vwnmCZcj7tL7ufbVRF+1vNfeEDvtyD4ojURgeLH1dH9FuS1dpwyvtPkvBw9mpgINaKnDLhszWgbpgEELIofleoz+tUG8EnJC/H/f/3FkflLQyjirOpL9o5c+UnT5mpzwZHp7Sqr5tMG7dbul6sjPyC5WzuzAbT0xLM7PwVpl7RBRmRDXKDVQx4mHF5iPbV8gR+6s9DZfae/y9mPFRoy8W3OghTrdHYUxSkWRwpJhi63RWknHPS8gGRLjkxIEN/u2b+FDNfGt/5P2o8n0EnV4KSUjj/xMCTJ05DMr+Fd/4OmWbPr4NWKybqAmTlaHY8o+JbiFawE7AkKojhFr4mJRY32R0iqYp3g7ratEHhQqs2kyfvzFLs63afp+D0p4Wv6mOk2lrq/yvRNujAhuDJHb/mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(26005)(2616005)(6512007)(6666004)(36756003)(31696002)(38100700002)(83380400001)(4001150100001)(2906002)(30864003)(5660300002)(478600001)(316002)(4326008)(8936002)(8676002)(66476007)(66556008)(6506007)(6486002)(41300700001)(66946007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU5rb3NKeHpyVzluTllQZ3RUK0I2cXNVdUZYdTVadnB3dHYwYXVQR3ByMU9k?=
 =?utf-8?B?WnlydTJZemJKWE5MeXBCRmZ5SmpLUmRnQ2FwbUxTVElsbFdrNGRuTTlaRkF4?=
 =?utf-8?B?MFFvMWxWV0g0RDNYc1FscTJuZjk2ZlpYbmUzdVFrN2xiMkVLeXFCS0hsdDBT?=
 =?utf-8?B?amJwWXVXYVM0M3NVb0czd0ZQem02c2dJZG5PQ01BSDhaWE43aHdlTklneTdi?=
 =?utf-8?B?bldiQklwOUVEaGdBUGdoRUgrMzFNOFNsZ2EvUmJYVWpaUkVWWmY0cVU5TUJN?=
 =?utf-8?B?RnZicHM4akEwMXo4MnpXRDVrMUQ0RVdIYjFhSjFZaXJOUDNaS2NnR1RWT3ln?=
 =?utf-8?B?eFpiRkVJU3FZOTdjNGN5TU5hSTNjV1k2UCt2YS9lbW5FQVBBeTFIaktHYnVQ?=
 =?utf-8?B?SDIwRkVsWHlnZUZaMWw2Tll6K0RQY2tkWEFsc3NOeW50VGZld3ZIaFBNa3FJ?=
 =?utf-8?B?Z041YlhZa1kwZ2p5RFBkM0UwN01ucXN6Ti9idHRDL0syUXc1WHR2TE9DNlIy?=
 =?utf-8?B?dUxpRHRZeEppQmdPSnAzUVlDeFVUMlRzV3FXbXZlUitIUVFqamVjNnVGRGQ3?=
 =?utf-8?B?QXN6UnlFN3R5WFBCMkFyM1h1UStFZmNFdy9Bc3lydHYvbXEwaE5DY3hDU1VS?=
 =?utf-8?B?RlFEY2ZQQ2JDQ25YajNscGVMUVRzVGsxdkM3T3lkengrQm5aYXJybUxPUEx2?=
 =?utf-8?B?R3BSOEJXVDZ3YnFYcDBOUXgrcmhiQ1c0WTZZY24zVGRsZyt3V3F5a05seDZw?=
 =?utf-8?B?eUR0bW95OWVGV3k5VC9IV1V3UC9qTTJTMlc2SE9BKzFRbEJSelVzeGsyUVJ4?=
 =?utf-8?B?WWx4b3lWT1ZmWmprVFdnRnZhd0ZocjhsY2g0OFdNMFc5K1grL0JYYlZKREpw?=
 =?utf-8?B?SGZETVNXRDc2aDQ4MUhGZHBYY3RtejJ2Ums5TnF4YXRNcDM3bFcwMmNIbnNN?=
 =?utf-8?B?RjU1UTR6KzB6U2FmNGlqV1UvemlnU3FMTjR2MmxON1k5c3RKWlRwMTVSclJq?=
 =?utf-8?B?Tm1LUzRsdVBjaXZCbVEvRjRuWHZhamo0R25vYU1Wek0vTks4NGpITzhhUU03?=
 =?utf-8?B?WlNCMHFMOXhJMktocUxSVFZkMWZMQWkvZkhvQ01WMStXZit2RmVodFJVZ0F5?=
 =?utf-8?B?ZE9rRnUwRXNZL0FhM21FamxhZ1VyVkpuYkRsSzJyVCtyYjZnSFdLOS9pdHZK?=
 =?utf-8?B?NjJaQnpVenJjQXJQZXRxbzVXQzBlWW1hUERzNXIwTi9kZTZKa25aVzVQUmly?=
 =?utf-8?B?VDVzY3ZBdURBcHpCNlF4K0h2RERIaDhrSDdkRTQxWmNXWEhuaHkrTGFSQTVU?=
 =?utf-8?B?b1RnSE5Hc1IvQ1FVQXNxbUd6bElOcU80ZmZ6NEJnODVXeG1KWEJTb0JtUVFS?=
 =?utf-8?B?RWZFcHp0VUFNN3VuU3ZySFBQMFRQM0R3UVNOL2ZPNTV4VVZsZTlJYktZR0Yx?=
 =?utf-8?B?TXB3c1NPUDVLeGZ2b0lKL1VMUWJ5ZUh4NmJiTE9odjRZTktyWUtWL3Y2RlR6?=
 =?utf-8?B?OXJPNWVnNTVuSmYvNmVJaGwySGhrT21PY0ZsUE5nbHpxV3MvMXp0bkd5NTRG?=
 =?utf-8?B?QlpzdWxEejNpaGV6YS9YL2pvMURXL2tpaXhnQ3F4bUVqZWhCT3ZZdUVSanl2?=
 =?utf-8?B?ZTR4L2VvNVQwcjRNd24zdEtGeXRFRmV1UTh0UnVRQXF1bTVoU25HRUZFaDhp?=
 =?utf-8?B?dEg5cUVhZVp1dUVtY0dHVnd0aWhxdTVkSmxWYlJydkdyR2JNTHl0SjFoVitN?=
 =?utf-8?B?SzFlTk4yM04rMnR6dGwwVW9QeWZqZTRMa1REeHhoS0dhMm5tYk5ud2hUWW1n?=
 =?utf-8?B?UzNpWU9YWkxkNzhMNkJvWW50ZkJwV1Q0c200bzlOekdMSUVYaWZFV1BUd3g1?=
 =?utf-8?B?bnQvOGFZWWZWaWZWZW1GcFZMbmc5M1lYVHFacWE0Z2RpNElTNURncVVoaUhM?=
 =?utf-8?B?QUdNbE5pbHFVYW8zYTg4dHFMVHQ3blR4QzJOdWFFbXl1cmYzcE1LNUwyczVO?=
 =?utf-8?B?em92VzJPNzRPZW5VZkZBYzdHZ0FVMkcvZVhaS2lOSmYzQ2lZRVdVb0RjcXRR?=
 =?utf-8?B?VnBzeWRjK1B4Q1p0WTBtdm9DRTlkL1U2MHBJS2ZnUXZFVGh3Z2F5eHJNMkF2?=
 =?utf-8?Q?rV20=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284ad4b1-53c9-4b72-35ca-08dbf0f7e30f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 16:26:06.1731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj1LFK65vg+78x5POO2zyIr6xlsfRnXcQCe6j1rgDdcHqshhXlUBlvMFd6yZGc8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-11-14 16:01, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

This patch implements partial migration/mapping for gpu/cpu page faults in SVM
according to migration granularity(default 2MB). A svm range may include pages
from both system ram and vram of one gpu now. These chagnes are expected to
improve migration performance and reduce mmu callback and TLB flush workloads.

Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a></pre>
    </blockquote>
    <p>This patch looks good for me, kfdtest on VG10 passed overnight.
      With some indent issues and nitpick fixed below, this patch is:<br>
    </p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 152 +++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 176 +++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   9 +-
 4 files changed, 183 insertions(+), 160 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6c25dab051d5..67df1b46f292 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -442,10 +442,10 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 		goto out_free;
 	}
 	if (cpages != npages)
-		pr_debug(&quot;partial migration, 0x%lx/0x%llx pages migrated\n&quot;,
+		pr_debug(&quot;partial migration, 0x%lx/0x%llx pages collected\n&quot;,
 			 cpages, npages);
 	else
-		pr_debug(&quot;0x%lx pages migrated\n&quot;, cpages);
+		pr_debug(&quot;0x%lx pages collected\n&quot;, cpages);
 
 	r = svm_migrate_copy_to_vram(node, prange, &amp;migrate, &amp;mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&amp;migrate);
@@ -479,6 +479,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
  * svm_migrate_ram_to_vram - migrate svm range from system to device
  * @prange: range structure
  * @best_loc: the device to migrate to
+ * @start_mgr: start page to migrate
+ * @last_mgr: last page to migrate
  * @mm: the process mm structure
  * @trigger: reason of migration
  *
@@ -489,6 +491,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
  */
 static int
 svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
+			unsigned long start_mgr, unsigned long last_mgr,
 			struct mm_struct *mm, uint32_t trigger)
 {
 	unsigned long addr, start, end;
@@ -498,30 +501,37 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	unsigned long cpages = 0;
 	long r = 0;
 
-	if (prange-&gt;actual_loc == best_loc) {
-		pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n&quot;,
-			 prange-&gt;svms, prange-&gt;start, prange-&gt;last, best_loc);
+	if (!best_loc) {</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">+		pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] migrate to sys ram\n&quot;,
+			prange-&gt;svms, start_mgr, last_mgr);</pre>
    </blockquote>
    The callers check !best_loc already, the same check here is
    redundant, could be removed.<br>
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap=""></pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		return 0;
 	}
 
+	if (start_mgr &lt; prange-&gt;start || last_mgr &gt; prange-&gt;last) {
+		pr_debug(&quot;range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n&quot;,
+				 start_mgr, last_mgr, prange-&gt;start, prange-&gt;last);
+		return -EFAULT;
+	}
+
 	node = svm_range_get_node_by_id(prange, best_loc);
 	if (!node) {
 		pr_debug(&quot;failed to get kfd node by id 0x%x\n&quot;, best_loc);
 		return -ENODEV;
 	}
 
-	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n&quot;, prange-&gt;svms,
-		 prange-&gt;start, prange-&gt;last, best_loc);
+	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n&quot;,
+		prange-&gt;svms, start_mgr, last_mgr, prange-&gt;start, prange-&gt;last,
+		best_loc);
 
-	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
-	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
+	start = start_mgr &lt;&lt; PAGE_SHIFT;
+	end = (last_mgr + 1) &lt;&lt; PAGE_SHIFT;
 
 	r = svm_range_vram_node_new(node, prange, true);
 	if (r) {
 		dev_dbg(node-&gt;adev-&gt;dev, &quot;fail %ld to alloc vram\n&quot;, r);
 		return r;
 	}
-	ttm_res_offset = prange-&gt;offset &lt;&lt; PAGE_SHIFT;
+	ttm_res_offset = (start_mgr - prange-&gt;start + prange-&gt;offset) &lt;&lt; PAGE_SHIFT;
 
 	for (addr = start; addr &lt; end;) {
 		unsigned long next;
@@ -544,8 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 	if (cpages) {
 		prange-&gt;actual_loc = best_loc;
-		svm_range_dma_unmap(prange);
-	} else {
+		prange-&gt;vram_pages = prange-&gt;vram_pages + cpages;
+	} else if (!prange-&gt;actual_loc) {
+		/* if no page migrated and all pages from prange are at
+		 * sys ram drop svm_bo got from svm_range_vram_node_new
+		 */
 		svm_range_vram_node_free(prange);
 	}
 
@@ -663,9 +676,8 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
  * Context: Process context, caller hold mmap read lock, prange-&gt;migrate_mutex
  *
  * Return:
- *   0 - success with all pages migrated
  *   negative values - indicate error
- *   positive values - partial migration, number of pages not migrated
+ *   positive values or zero - number of pages got migrated
  */
 static long
 svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
@@ -676,6 +688,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	uint64_t npages = (end - start) &gt;&gt; PAGE_SHIFT;
 	unsigned long upages = npages;
 	unsigned long cpages = 0;
+	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node-&gt;adev;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
@@ -725,10 +738,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 		goto out_free;
 	}
 	if (cpages != npages)
-		pr_debug(&quot;partial migration, 0x%lx/0x%llx pages migrated\n&quot;,
+		pr_debug(&quot;partial migration, 0x%lx/0x%llx pages collected\n&quot;,
 			 cpages, npages);
 	else
-		pr_debug(&quot;0x%lx pages migrated\n&quot;, cpages);
+		pr_debug(&quot;0x%lx pages collected\n&quot;, cpages);
 
 	r = svm_migrate_copy_to_ram(adev, prange, &amp;migrate, &amp;mfence,
 				    scratch, npages);
@@ -751,17 +764,21 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	kvfree(buf);
 out:
 	if (!r &amp;&amp; cpages) {
+		mpages = cpages - upages;
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
-			WRITE_ONCE(pdd-&gt;page_out, pdd-&gt;page_out + cpages);
+			WRITE_ONCE(pdd-&gt;page_out, pdd-&gt;page_out + mpages);
 	}
-	return r ? r : upages;
+
+	return r ? r : mpages;
 }
 
 /**
  * svm_migrate_vram_to_ram - migrate svm range from device to system
  * @prange: range structure
  * @mm: process mm, use current-&gt;mm if NULL
+ * @start_mgr: start page need be migrated to sys ram
+ * @last_mgr: last page need be migrated to sys ram
  * @trigger: reason of migration
  * @fault_page: is from vmf-&gt;page, svm_migrate_to_ram(), this is CPU page fault callback
  *
@@ -771,6 +788,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
  * 0 - OK, otherwise error code
  */
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
+			    unsigned long start_mgr, unsigned long last_mgr,
 			    uint32_t trigger, struct page *fault_page)
 {
 	struct kfd_node *node;
@@ -778,26 +796,33 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	unsigned long addr;
 	unsigned long start;
 	unsigned long end;
-	unsigned long upages = 0;
+	unsigned long mpages = 0;
 	long r = 0;
 
+	/* this pragne has no any vram page to migrate to sys ram */
 	if (!prange-&gt;actual_loc) {
 		pr_debug(&quot;[0x%lx 0x%lx] already migrated to ram\n&quot;,
 			 prange-&gt;start, prange-&gt;last);
 		return 0;
 	}
 
+	if (start_mgr &lt; prange-&gt;start || last_mgr &gt; prange-&gt;last) {
+		pr_debug(&quot;range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n&quot;,
+				 start_mgr, last_mgr, prange-&gt;start, prange-&gt;last);</pre>
    </blockquote>
    Indent not alignment<br>
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		return -EFAULT;
+	}
+
 	node = svm_range_get_node_by_id(prange, prange-&gt;actual_loc);
 	if (!node) {
 		pr_debug(&quot;failed to get kfd node by id 0x%x\n&quot;, prange-&gt;actual_loc);
 		return -ENODEV;
 	}
 	pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n&quot;,
-		 prange-&gt;svms, prange, prange-&gt;start, prange-&gt;last,
+		 prange-&gt;svms, prange, start_mgr, last_mgr,
 		 prange-&gt;actual_loc);
 
-	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
-	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
+	start = start_mgr &lt;&lt; PAGE_SHIFT;
+	end = (last_mgr + 1) &lt;&lt; PAGE_SHIFT;
 
 	for (addr = start; addr &lt; end;) {
 		unsigned long next;
@@ -816,14 +841,21 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 			pr_debug(&quot;failed %ld to migrate prange %p\n&quot;, r, prange);
 			break;
 		} else {
-			upages += r;
+			mpages += r;
 		}
 		addr = next;
 	}
 
-	if (r &gt;= 0 &amp;&amp; !upages) {
-		svm_range_vram_node_free(prange);
-		prange-&gt;actual_loc = 0;
+	if (r &gt;= 0) {
+		prange-&gt;vram_pages -= mpages;
+
+		/* prange does not have vram page set its actual_loc to system
+		 * and drop its svm_bo ref
+		 */
+		if (prange-&gt;vram_pages == 0 &amp;&amp; prange-&gt;ttm_res) {
+			prange-&gt;actual_loc = 0;
+			svm_range_vram_node_free(prange);
+		}
 	}
 
 	return r &lt; 0 ? r : 0;
@@ -833,17 +865,23 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
  * svm_migrate_vram_to_vram - migrate svm range from device to device
  * @prange: range structure
  * @best_loc: the device to migrate to
+ * @start: start page need be migrated to sys ram
+ * @last: last page need be migrated to sys ram
  * @mm: process mm, use current-&gt;mm if NULL
  * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
+ * migrate all vram pages in prange to sys ram, then migrate
+ * [start, last] pages from sys ram to gpu node best_loc.
+ *
  * Return:
  * 0 - OK, otherwise error code
  */
 static int
 svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			 struct mm_struct *mm, uint32_t trigger)
+			unsigned long start, unsigned long last,
+			struct mm_struct *mm, uint32_t trigger)
 {
 	int r, retries = 3;
 
@@ -855,7 +893,8 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug(&quot;from gpu 0x%x to gpu 0x%x\n&quot;, prange-&gt;actual_loc, best_loc);
 
 	do {
-		r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
+		r = svm_migrate_vram_to_ram(prange, mm, prange-&gt;start, prange-&gt;last,
+								trigger, NULL);</pre>
    </blockquote>
    Indent not alignment
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		if (r)
 			return r;
 	} while (prange-&gt;actual_loc &amp;&amp; --retries);
@@ -863,17 +902,21 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	if (prange-&gt;actual_loc)
 		return -EDEADLK;
 
-	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
+	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger);
 }
 
 int
 svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
-		    struct mm_struct *mm, uint32_t trigger)
+			unsigned long start, unsigned long last,
+			struct mm_struct *mm, uint32_t trigger)</pre>
    </blockquote>
    Indent not alignment
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 {
-	if  (!prange-&gt;actual_loc)
-		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
+	if  (!prange-&gt;actual_loc || prange-&gt;actual_loc == best_loc)
+		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
+						mm, trigger);</pre>
    </blockquote>
    Indent not alignment
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
 	else
-		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
+		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
+						mm, trigger);
 
 }
 
@@ -889,10 +932,9 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
  */
 static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 {
+	unsigned long start, last, size;
 	unsigned long addr = vmf-&gt;address;
 	struct svm_range_bo *svm_bo;
-	enum svm_work_list_ops op;
-	struct svm_range *parent;
 	struct svm_range *prange;
 	struct kfd_process *p;
 	struct mm_struct *mm;
@@ -929,51 +971,31 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 
 	mutex_lock(&amp;p-&gt;svms.lock);
 
-	prange = svm_range_from_addr(&amp;p-&gt;svms, addr, &amp;parent);
+	prange = svm_range_from_addr(&amp;p-&gt;svms, addr, NULL);
 	if (!prange) {
 		pr_debug(&quot;failed get range svms 0x%p addr 0x%lx\n&quot;, &amp;p-&gt;svms, addr);
 		r = -EFAULT;
 		goto out_unlock_svms;
 	}
 
-	mutex_lock(&amp;parent-&gt;migrate_mutex);
-	if (prange != parent)
-		mutex_lock_nested(&amp;prange-&gt;migrate_mutex, 1);
+	mutex_lock(&amp;prange-&gt;migrate_mutex);
 
 	if (!prange-&gt;actual_loc)
 		goto out_unlock_prange;
 
-	svm_range_lock(parent);
-	if (prange != parent)
-		mutex_lock_nested(&amp;prange-&gt;lock, 1);
-	r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
-	if (prange != parent)
-		mutex_unlock(&amp;prange-&gt;lock);
-	svm_range_unlock(parent);
-	if (r) {
-		pr_debug(&quot;failed %d to split range by granularity\n&quot;, r);
-		goto out_unlock_prange;
-	}
+	/* Align migration range start and size to granularity size */
+	size = 1UL &lt;&lt; prange-&gt;granularity;
+	start = max(ALIGN_DOWN(addr, size), prange-&gt;start);
+	last = min(ALIGN(addr + 1, size) - 1, prange-&gt;last);
 
-	r = svm_migrate_vram_to_ram(prange, vmf-&gt;vma-&gt;vm_mm,
-				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
-				    vmf-&gt;page);
+	r = svm_migrate_vram_to_ram(prange, vmf-&gt;vma-&gt;vm_mm, start, last,
+						KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf-&gt;page);</pre>
    </blockquote>
    Indent not alignment
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	if (r)
 		pr_debug(&quot;failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n&quot;,
-			 r, prange-&gt;svms, prange, prange-&gt;start, prange-&gt;last);
-
-	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
-	if (p-&gt;xnack_enabled &amp;&amp; parent == prange)
-		op = SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP;
-	else
-		op = SVM_OP_UPDATE_RANGE_NOTIFIER;
-	svm_range_add_list_work(&amp;p-&gt;svms, parent, mm, op);
-	schedule_deferred_list_work(&amp;p-&gt;svms);
+			r, prange-&gt;svms, prange, start, last);
 
 out_unlock_prange:
-	if (prange != parent)
-		mutex_unlock(&amp;prange-&gt;migrate_mutex);
-	mutex_unlock(&amp;parent-&gt;migrate_mutex);
+	mutex_unlock(&amp;prange-&gt;migrate_mutex);
 out_unlock_svms:
 	mutex_unlock(&amp;p-&gt;svms.lock);
 out_unref_process:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
index 487f26368164..9e48d10e848e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
@@ -41,9 +41,13 @@ enum MIGRATION_COPY_DIR {
 };
 
 int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
+			unsigned long start, unsigned long last,
 			struct mm_struct *mm, uint32_t trigger);
+
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
-			    uint32_t trigger, struct page *fault_page);
+			unsigned long start, unsigned long last,
+			uint32_t trigger, struct page *fault_page);</pre>
    </blockquote>
    Indent not alignment
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b23ba92a794c..2d9bb364d52c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -156,12 +156,13 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
-		      unsigned long *hmm_pfns, uint32_t gpuidx)
+		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	dma_addr_t *addr = prange-&gt;dma_addr[gpuidx];
 	struct device *dev = adev-&gt;dev;
 	struct page *page;
+	uint64_t vram_pages_dev;
 	int i, r;
 
 	if (!addr) {
@@ -171,6 +172,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		prange-&gt;dma_addr[gpuidx] = addr;
 	}
 
+	vram_pages_dev = 0;
 	addr += offset;
 	for (i = 0; i &lt; npages; i++) {
 		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
@@ -180,6 +182,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		if (is_zone_device_page(page)) {
 			struct amdgpu_device *bo_adev = prange-&gt;svm_bo-&gt;node-&gt;adev;
 
+			vram_pages_dev++;
 			addr[i] = (hmm_pfns[i] &lt;&lt; PAGE_SHIFT) +
 				   bo_adev-&gt;vm_manager.vram_base_offset -
 				   bo_adev-&gt;kfd.pgmap.range.start;
@@ -196,13 +199,14 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		pr_debug_ratelimited(&quot;dma mapping 0x%llx for page addr 0x%lx\n&quot;,
 				     addr[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(page));
 	}
+	*vram_pages = vram_pages_dev;
 	return 0;
 }
 
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		  unsigned long offset, unsigned long npages,
-		  unsigned long *hmm_pfns)
+		  unsigned long *hmm_pfns, uint64_t *vram_pages)
 {
 	struct kfd_process *p;
 	uint32_t gpuidx;
@@ -221,7 +225,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 
 		r = svm_range_dma_map_dev(pdd-&gt;dev-&gt;adev, prange, offset, npages,
-					  hmm_pfns, gpuidx);
+					  hmm_pfns, gpuidx, vram_pages);
 		if (r)
 			break;
 	}
@@ -347,6 +351,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&amp;prange-&gt;child_list);
 	atomic_set(&amp;prange-&gt;invalid, 0);
 	prange-&gt;validate_timestamp = 0;
+	prange-&gt;vram_pages = 0;
 	mutex_init(&amp;prange-&gt;migrate_mutex);
 	mutex_init(&amp;prange-&gt;lock);
 
@@ -393,6 +398,8 @@ static void svm_range_bo_release(struct kref *kref)
 			 prange-&gt;start, prange-&gt;last);
 		mutex_lock(&amp;prange-&gt;lock);
 		prange-&gt;svm_bo = NULL;
+		/* prange should not hold vram page now */
+		WARN_ON(prange-&gt;actual_loc);</pre>
    </blockquote>
    <p>&nbsp;WARN_ONCE(prange-&gt;actual_loc, &quot;prange should not hold vram
      page&quot;);</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20231114210137.57695-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		mutex_unlock(&amp;prange-&gt;lock);
 
 		spin_lock(&amp;svm_bo-&gt;list_lock);
@@ -973,6 +980,11 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
 	new-&gt;ttm_res = old-&gt;ttm_res;
 
+	/* set new's vram_pages as old range's now, the acurate vram_pages
+	 * will be updated during mapping
+	 */
+	new-&gt;vram_pages = min(old-&gt;vram_pages, new-&gt;npages);
+
 	spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
 	list_add(&amp;new-&gt;svm_bo_list, &amp;new-&gt;svm_bo-&gt;range_list);
 	spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
@@ -1133,66 +1145,6 @@ svm_range_add_child(struct svm_range *prange, struct mm_struct *mm,
 	list_add_tail(&amp;pchild-&gt;child_list, &amp;prange-&gt;child_list);
 }
 
-/**
- * svm_range_split_by_granularity - collect ranges within granularity boundary
- *
- * @p: the process with svms list
- * @mm: mm structure
- * @addr: the vm fault address in pages, to split the prange
- * @parent: parent range if prange is from child list
- * @prange: prange to split
- *
- * Trims @prange to be a single aligned block of prange-&gt;granularity if
- * possible. The head and tail are added to the child_list in @parent.
- *
- * Context: caller must hold mmap_read_lock and prange-&gt;lock
- *
- * Return:
- * 0 - OK, otherwise error code
- */
-int
-svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
-			       unsigned long addr, struct svm_range *parent,
-			       struct svm_range *prange)
-{
-	struct svm_range *head, *tail;
-	unsigned long start, last, size;
-	int r;
-
-	/* Align splited range start and size to granularity size, then a single
-	 * PTE will be used for whole range, this reduces the number of PTE
-	 * updated and the L1 TLB space used for translation.
-	 */
-	size = 1UL &lt;&lt; prange-&gt;granularity;
-	start = ALIGN_DOWN(addr, size);
-	last = ALIGN(addr + 1, size) - 1;
-
-	pr_debug(&quot;svms 0x%p split [0x%lx 0x%lx] to [0x%lx 0x%lx] size 0x%lx\n&quot;,
-		 prange-&gt;svms, prange-&gt;start, prange-&gt;last, start, last, size);
-
-	if (start &gt; prange-&gt;start) {
-		r = svm_range_split(prange, start, prange-&gt;last, &amp;head);
-		if (r)
-			return r;
-		svm_range_add_child(parent, mm, head, SVM_OP_ADD_RANGE);
-	}
-
-	if (last &lt; prange-&gt;last) {
-		r = svm_range_split(prange, prange-&gt;start, last, &amp;tail);
-		if (r)
-			return r;
-		svm_range_add_child(parent, mm, tail, SVM_OP_ADD_RANGE);
-	}
-
-	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
-	if (p-&gt;xnack_enabled &amp;&amp; prange-&gt;work_item.op == SVM_OP_ADD_RANGE) {
-		prange-&gt;work_item.op = SVM_OP_ADD_RANGE_AND_MAP;
-		pr_debug(&quot;change prange 0x%p [0x%lx 0x%lx] op %d\n&quot;,
-			 prange, prange-&gt;start, prange-&gt;last,
-			 SVM_OP_ADD_RANGE_AND_MAP);
-	}
-	return 0;
-}
 static bool
 svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
 {
@@ -1615,12 +1567,14 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  * 5. Release page table (and SVM BO) reservation
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
+				      unsigned long map_start, unsigned long map_last,
 				      struct svm_range *prange, int32_t gpuidx,
 				      bool intr, bool wait, bool flush_tlb)
 {
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
+	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1689,11 +1643,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 	}
 
+	vram_pages = 0;
 	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
 	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
 	for (addr = start; !r &amp;&amp; addr &lt; end; ) {
 		struct hmm_range *hmm_range;
+		unsigned long map_start_vma;
+		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
+		uint64_t vram_pages_vma;
 		unsigned long next = 0;
 		unsigned long offset;
 		unsigned long npages;
@@ -1722,9 +1680,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		if (!r) {
 			offset = (addr - start) &gt;&gt; PAGE_SHIFT;
 			r = svm_range_dma_map(prange, ctx-&gt;bitmap, offset, npages,
-					      hmm_range-&gt;hmm_pfns);
+					      hmm_range-&gt;hmm_pfns, &amp;vram_pages_vma);
 			if (r)
 				pr_debug(&quot;failed %d to dma map range\n&quot;, r);
+			else
+				vram_pages += vram_pages_vma;
 		}
 
 		svm_range_lock(prange);
@@ -1738,9 +1698,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1750,6 +1717,19 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		addr = next;
 	}
 
+	if (addr == end) {
+		prange-&gt;vram_pages = vram_pages;
+
+		/* if prange does not include any vram page and it
+		 * has not released svm_bo drop its svm_bo reference
+		 * and set its actaul_loc to sys ram
+		 */
+		if (!vram_pages &amp;&amp; prange-&gt;ttm_res) {
+			prange-&gt;actual_loc = 0;
+			svm_range_vram_node_free(prange);
+		}
+	}
+
 	svm_range_unreserve_bos(ctx);
 	if (!r)
 		prange-&gt;validate_timestamp = ktime_get_boottime();
@@ -1833,8 +1813,8 @@ static void svm_range_restore_work(struct work_struct *work)
 		 */
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true, false);
+		r = svm_range_validate_and_map(mm, prange-&gt;start, prange-&gt;last, prange,
+					       MAX_GPU_INSTANCE, false, true, false);
 		if (r)
 			pr_debug(&quot;failed %d to map 0x%lx to gpus\n&quot;, r,
 				 prange-&gt;start);
@@ -2002,6 +1982,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
 	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
+	new-&gt;vram_pages = old-&gt;vram_pages;
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -2912,6 +2893,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
 			uint64_t addr, bool write_fault)
 {
+	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -3047,40 +3029,44 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p-&gt;lead_thread-&gt;pid, addr,
 				       write_fault, timestamp);
 
-	if (prange-&gt;actual_loc != best_loc) {
+	/* Align migration range start and size to granularity size */
+	size = 1UL &lt;&lt; prange-&gt;granularity;
+	start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange-&gt;start);
+	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange-&gt;last);
+	if (prange-&gt;actual_loc != 0 || best_loc != 0) {
 		migration = true;
+
 		if (best_loc) {
-			r = svm_migrate_to_vram(prange, best_loc, mm,
-					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
+			r = svm_migrate_to_vram(prange, best_loc, start, last,
+					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 			if (r) {
 				pr_debug(&quot;svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n&quot;,
 					 r, addr);
 				/* Fallback to system memory if migration to
 				 * VRAM failed
 				 */
-				if (prange-&gt;actual_loc)
-					r = svm_migrate_vram_to_ram(prange, mm,
-					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
-					   NULL);
+				if (prange-&gt;actual_loc &amp;&amp; prange-&gt;actual_loc != best_loc)
+					r = svm_migrate_vram_to_ram(prange, mm, start, last,
+						KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
 				else
 					r = 0;
 			}
 		} else {
-			r = svm_migrate_vram_to_ram(prange, mm,
-					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
-					NULL);
+			r = svm_migrate_vram_to_ram(prange, mm, start, last,
+					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
 		}
 		if (r) {
 			pr_debug(&quot;failed %d to migrate svms %p [0x%lx 0x%lx]\n&quot;,
-				 r, svms, prange-&gt;start, prange-&gt;last);
+				 r, svms, start, last);
 			goto out_unlock_range;
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
@@ -3426,18 +3412,24 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	*migrated = false;
 	best_loc = svm_range_best_prefetch_location(prange);
 
-	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
-	    best_loc == prange-&gt;actual_loc)
+	/* when best_loc is a gpu node and same as prange-&gt;actual_loc
+	 * we still need do migration as prange-&gt;actual_loc !=0 does
+	 * not mean all pages in prange are vram. hmm migrate will pick
+	 * up right pages during migration.
+	 */
+	if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
+	    (best_loc == 0 &amp;&amp; prange-&gt;actual_loc == 0))
 		return 0;
 
 	if (!best_loc) {
-		r = svm_migrate_vram_to_ram(prange, mm,
+		r = svm_migrate_vram_to_ram(prange, mm, prange-&gt;start, prange-&gt;last,
 					KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
 		*migrated = !r;
 		return r;
 	}
 
-	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
+	r = svm_migrate_to_vram(prange, best_loc, prange-&gt;start, prange-&gt;last,
+				mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
 	return r;
@@ -3492,7 +3484,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 		do {
+			/* migrate all vram pages in this prange to sys ram
+			 * after that prange-&gt;actual_loc should be zero
+			 */
 			r = svm_migrate_vram_to_ram(prange, mm,
+					prange-&gt;start, prange-&gt;last,
 					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
 		} while (!r &amp;&amp; prange-&gt;actual_loc &amp;&amp; --retries);
 
@@ -3616,8 +3612,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp; prange-&gt;mapped_to_gpu;
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       true, true, flush_tlb);
+		r = svm_range_validate_and_map(mm, prange-&gt;start, prange-&gt;last, prange,
+					       MAX_GPU_INSTANCE, true, true, flush_tlb);
 		if (r)
 			pr_debug(&quot;failed %d to map svm range\n&quot;, r);
 
@@ -3631,8 +3627,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		pr_debug(&quot;Remapping prange 0x%p [0x%lx 0x%lx]\n&quot;,
 			 prange, prange-&gt;start, prange-&gt;last);
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       true, true, prange-&gt;mapped_to_gpu);
+		r = svm_range_validate_and_map(mm,  prange-&gt;start, prange-&gt;last, prange,
+					       MAX_GPU_INSTANCE, true, true, prange-&gt;mapped_to_gpu);
 		if (r)
 			pr_debug(&quot;failed %d on remap svm range\n&quot;, r);
 		mutex_unlock(&amp;prange-&gt;migrate_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c528df1d0ba2..026863a0abcd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -78,6 +78,7 @@ struct svm_work_list_item {
  * @update_list:link list node used to add to update_list
  * @mapping:    bo_va mapping structure to create and update GPU page table
  * @npages:     number of pages
+ * @vram_pages: vram pages number in this svm_range
  * @dma_addr:   dma mapping address on each GPU for system memory physical page
  * @ttm_res:    vram ttm resource map
  * @offset:     range start offset within mm_nodes
@@ -88,7 +89,9 @@ struct svm_work_list_item {
  * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
  * @perferred_loc: perferred location, 0 for CPU, or GPU id
  * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
- * @actual_loc: the actual location, 0 for CPU, or GPU id
+ * @actual_loc: this svm_range location. 0: all pages are from sys ram;
+ *              GPU id: this svm_range may include vram pages from GPU with
+ *              id actual_loc.
  * @granularity:migration granularity, log2 num pages
  * @invalid:    not 0 means cpu page table is invalidated
  * @validate_timestamp: system timestamp when range is validated
@@ -112,6 +115,7 @@ struct svm_range {
 	struct list_head		list;
 	struct list_head		update_list;
 	uint64_t			npages;
+	uint64_t			vram_pages;
 	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
 	struct ttm_resource		*ttm_res;
 	uint64_t			offset;
@@ -168,9 +172,6 @@ struct kfd_node *svm_range_get_node_by_id(struct svm_range *prange,
 int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
-int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
-			       unsigned long addr, struct svm_range *parent,
-			       struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			    uint32_t vmid, uint32_t node_id, uint64_t addr,
 			    bool write_fault);
</pre>
    </blockquote>
  </body>
</html>
