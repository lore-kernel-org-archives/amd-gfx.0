Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F76AE9370C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 13:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A88B10E400;
	Thu,  5 Oct 2023 13:25:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 702D710E3FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 13:25:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCsFmW6KGkgalrFhpqLoAEK2UyguvCCYxqZjaKpr3a9eViR1Ls2Ux24MGvlNtpSzNl0FkWFe05EaAjPP7VyD6ebDlmCws9NrxSdwAqcKFVsn8uKum7Aiml0du2chjZM1dsPfyTT/7LgIhY+sW6KrWDgDzLEmb5ZjcBTilH/796Uju3qy44RDb78xVhwT4sNbFTH+IIhdhvSgAAmDaDNoT778JdCbZokS+lPZyZEzD2xEny5tL9O/Mk10HwecG5HYfyf7AwNjBJGFdc6dkcJdC2EYltlusHc/IleFoCKJukzXbGhnkKyEF5uCjvoXpNBh4YRDw62r/mtz8KECsriSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5t4SIFCo2IpPgfn+gyWWh8glrCNW7bVDqVkURtmoWE=;
 b=WUnkCrokC5JCOLAThusGv5JCFJtw+e/OlSymRfNB+22djisVRVnG7jgmejFO6TlfE+ik9sXZDf/XOOwJD4j4+51UgpD4TtmYBE3YzIWXD4j4cNdZ2Kpw9TAEV89jn4Wbwv0OnkdOb5rryGIo88ivjkX8Kjo8BrH/y+ZdcGmF8yI7uHBLAVg8dwIjTFMZiGJpygEavJdd7kBazGj5vtrThoZPsbIbNH2g3NEwuxD/rYZ3fD9PblnDeqXJJCE2EBosBi3UfjtHBufXPDeNs42XtbBtxha8NvxO11aCkzwVSWVh2fzXYBc1Rgeo3ockoKtnKDMp0IPDLhXhWdaDr5vGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5t4SIFCo2IpPgfn+gyWWh8glrCNW7bVDqVkURtmoWE=;
 b=CWUxYeqg9uJUH3HmHGYVqrW9Ivtdei5zN5Ic53WQMQX3qw/481f3nxnsA9CAVEGJCTi8nL9Nokzw+l9s3brzkZlpuUKGZ/lPQ4g4SwB2Wk4+CAlaL6KNWSH1vYN17pRsnjyIoAkueqmTuYZJ5+iaGT92XQn7dYWBBkyV7qQGs5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 13:25:42 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 13:25:42 +0000
Message-ID: <5ab131d8-4285-32cd-8fc2-5137522a2f03@amd.com>
Date: Thu, 5 Oct 2023 09:25:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231003233108.16892-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231003233108.16892-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: b31d08f5-08a3-41da-2d4f-08dbc5a69295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NN0qMUxcNrxWnGDXIoZkTlWAWBPrQc6SakqImvMUdCzOqE1bxW4Cmn4kmB4XNf24WwckWdsPSkDgH5h6DGHZRo7miVCg86Py1I61T1L4F5N90+e2MQrDqA5qD4PMrL/2j13R2C+RCi6TKhgHX78p14+T4t8FWI2w6rXt88/DEE7wh/MIJ21aPMfex2kRf/knZL6FBP/34/CYHmp97xkeNk/zt+T8gXmIqfhSmW4z4qSRQ9BfWcYQEp3iOJ3Or1zTmdJeBamFOvBU8cRK9vyI/+RFBT1JBsitn/s0lJRgzMLHPqZ1oqrDKAXHtMoNbwlc6DdmLu0NFAL3qutEmHIhPHKuXV8R82JSwbg40kWGBkR/gqScBMhgiwML0y47apH4T3AVw0fzkNdmjAh5maNBF5JCtxoSDzz9m2d5ZbfmjXiLwpoD4wLiukY0THC74xgY9DHxCYzfFD0w8CS44Zxweup6G8ADoAbTd/bdsJQ6IOzEO98Tq4ViUdjT2sqwIH/YPd8xROll4dgsLJojLvR0DUzyWKoCfxkaQpPHzwoHORvYtRWfpp1P9HnaY4qb7SLansF4SeANiM59F4ssDjMJK7gXx/EgAwp67zlnBHgwqUctk2H95WOMT4LiNOKDZS9z4QtqSeE0yMRjMEq282IU1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(6486002)(6666004)(53546011)(6506007)(478600001)(83380400001)(2616005)(26005)(2906002)(30864003)(316002)(8936002)(66476007)(66556008)(66946007)(8676002)(5660300002)(4326008)(41300700001)(36756003)(38100700002)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVpQbU9TU0tYMzF4TTQ1NlhwenZoWERXQlN6bHQxc29jYmdtQWlYam1ZckNH?=
 =?utf-8?B?L2lGQndXZ1NRVWlPUlZXYUhmU0xnZGJvbHJhNGxVSExjQjM2Y09UZVZWSlg1?=
 =?utf-8?B?RWQ5TWg0L3lNMnJFWVlsREpnNUpUSEJnZ0IzZHU5N2lMc2Urc1pLZDNWR2Mr?=
 =?utf-8?B?SGc5RUhlOXZRT2RBalB5TXVJWjNJME5TQUpUcnZKajdQOEhzKzdUNnQwOG5V?=
 =?utf-8?B?dnVmYUkzWHltMU4rVnFaNFc5b3RDOTlOOWl6Q3dKZ1FOSHNXUU9LQlpPQjR0?=
 =?utf-8?B?TUt5bDdneXhSR1N3Z2RmSkJSRnVnYUg5ejNWUnNuMHM2YXpWLzVkeCtodFdE?=
 =?utf-8?B?aVRIcUpSYlRKZGtCV090WlFVWGJYL21ScHgvYzlTSS9oYWNOYnhlelZyZWhD?=
 =?utf-8?B?RzFEeXROejdtbURJUlBGaGdHSlROUkhxTkVhMVFRSFkrTHZ0REJFOGluRUV5?=
 =?utf-8?B?Q3krNjRCd2h6RmR2SjN6OWxETnRIVnlDSW1tN09sSy9Eb2k1RzhnV3dVa0Fu?=
 =?utf-8?B?bFA5ZEZaVW1OYTJiMVZvSzRldEpUYkVhMXVJVXdzVDNva3hrOXUrajlocjIz?=
 =?utf-8?B?MWZZaitQVllDZldsc09qbWdkTXZhTHpmRFF1L0dudm9YV2o5TDMrODNlM3J4?=
 =?utf-8?B?OWRtaGs4aWw0Y1RhaFVlaE5JRk5nMHZBRkxKUVVVaytUanhkcDk5aGhVWUo3?=
 =?utf-8?B?bDZLUnZZTDZnUFA3RWd1OWlTaCtXY3ZxRTNwRndTYklINmEvcDVQRmxzRVdk?=
 =?utf-8?B?MkxFRHMxUllrdHp6L3A0b1VhbzFWV2tWTWpJaHI5SjdUY21vcStPWkNlQThO?=
 =?utf-8?B?c2YrWTNibzZlYngwZ3A2VVF0dC9FNW5ROFhpVHNiYzNKY2lSQ0pyL0tXdWQv?=
 =?utf-8?B?Ymt0aG90MURxVDJyU042clF4a0pUOVg0MW92c1BzYmVWUXY2VGxDSEVGTDN3?=
 =?utf-8?B?RDNvYzdMVzlnb244aDJFU043ZWwzNnhJb0NFLzhZNnRrSEliZ2JGejNidk1o?=
 =?utf-8?B?VXd6WDVMS0N5WEpUc0lpYUVYa3p2ei9BTlRLR2Vwb1RkaVpCcWlTUU1qa3VM?=
 =?utf-8?B?U0VUajdlT01xTFo0elVrbGFlaklySk1vYzRBTDJTYkJZTWlIb1FkT2s4cjB5?=
 =?utf-8?B?VS9xb0wvYUJubzJvcDRlMXZnbHIyQWN5ZDdBalVBTG1WZE91OURVYWd1RWw2?=
 =?utf-8?B?TGU3OWVvOVBUOFhwbzJERmpxVXJtZUNhQ3NWUUhQY3lQdEJPUEN5eG00eTNE?=
 =?utf-8?B?OElEcCthTXg1eHEzZnVncnRibEs1eGlteVo1QnZnWGFtNTZVV3U4WWVlMU9y?=
 =?utf-8?B?UElNQTBsZ3h2cm1ZZEpOcDlzSytKanJETHlvYWRRQjN6dlJXK1ZRbkRSRjlL?=
 =?utf-8?B?R0N3YlRFTTlhNzl4aGFaSDcvWkZNVU9DYSs4ZmU4UGRuallqditVK3lSeWRx?=
 =?utf-8?B?SElKN3VOVkMrdFBESkJzd1JmeXBIS3FLMVM3NW5UbTVjUytqOU9XS0N4d1l6?=
 =?utf-8?B?V1VsNWY1ZTdhbVYwMlBad1g5eThxQ2g3NHoyRmVOeTlCeklVdVh4ZWFtVCsx?=
 =?utf-8?B?bVljRTg1bndSL0phSjVQVWsvd0NGVWZ1T1FOVjBjTi9veTM5SWUzcWUzeEV5?=
 =?utf-8?B?alBkQmp2THRtTTJ2TWI0c1NiQmVjMFRLcUh5cGNHV0FSVksycUVKY2ZqaXcz?=
 =?utf-8?B?MkRtQmZnQW1FWW5NMnNoQms2OFdWVUQ5ejJxTVdGay9RYUNMQmhVREVWUmdo?=
 =?utf-8?B?Y0Jnd0NadktrVDJabWIvQkc3bWdiSGVTc3RDR0U2dHB6c0lhRGNzWkl2M2FF?=
 =?utf-8?B?NlJrTGhFdTJCbHcrM1VzL2pCOXBIWHRZWTAzQmFSMGJRU2l4U1J4Q1ByeW5C?=
 =?utf-8?B?cmVWd0d5RXdvRVFpcVJrU2gvd1lid0R4S1Y5NTJDVTJyL281WXhKWTNpTzhK?=
 =?utf-8?B?MXBRaTA5ZytEWUdGRnF6aERMbkN5cFhlc1NwbTFQUlozcC9NdEtwcjJTaVZN?=
 =?utf-8?B?blFyWGN6eWliRmZTTDFmeDl2TVlHMndHblVBQmpvOXgrb2tOY1RiZzQwaCtM?=
 =?utf-8?B?VnN1dDNXa29CV0F5WTI0ZHVKNnZ5d2RqWCt5OGZEYzFFV21kSlpRQ2JDYkI4?=
 =?utf-8?Q?3Xrw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31d08f5-08a3-41da-2d4f-08dbc5a69295
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 13:25:41.9119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gktFiJk8Perbo+wNbFR7k7kdE+0Igd7XSUcif4IFZSyXpUJ0AU5O3uuStIi8O6NT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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
    <p>Sorry for the late reply, just notice 2 other issues:<br>
    </p>
    <p>1. function svm_range_split_by_granularity can be removed now.</p>
    <p>2. svm_range_restore_pages should map partial range to GPUs after
      partial migration.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <div class="moz-cite-prefix">On 2023-10-03 19:31, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231003233108.16892-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

This patch implements partial migration in gpu page fault according to migration
granularity(default 2MB) and not split svm range in cpu page fault handling.
A svm range may include pages from both system ram and vram of one gpu now.
These chagnes are expected to improve migration performance and reduce mmu
callback and TLB flush workloads.

Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 156 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  83 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   6 +-
 4 files changed, 162 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6c25dab051d5..6a059e4aff86 100644
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
@@ -498,23 +501,30 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	unsigned long cpages = 0;
 	long r = 0;
 
-	if (prange-&gt;actual_loc == best_loc) {
-		pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n&quot;,
-			 prange-&gt;svms, prange-&gt;start, prange-&gt;last, best_loc);
+	if (!best_loc) {
+		pr_debug(&quot;svms 0x%p [0x%lx 0x%lx] migrate to sys ram\n&quot;,
+			prange-&gt;svms, start_mgr, last_mgr);
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
 
@@ -663,19 +676,19 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
-		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
-		       uint32_t trigger, struct page *fault_page)
+			struct vm_area_struct *vma, uint64_t start, uint64_t end,
+			uint32_t trigger, struct page *fault_page)
 {
 	struct kfd_process *p = container_of(prange-&gt;svms, struct kfd_process, svms);
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
@@ -771,33 +788,41 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
  * 0 - OK, otherwise error code
  */
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
-			    uint32_t trigger, struct page *fault_page)
+			unsigned long start_mgr, unsigned long last_mgr,
+			uint32_t trigger, struct page *fault_page)
 {
 	struct kfd_node *node;
 	struct vm_area_struct *vma;
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
+				 start_mgr, last_mgr, prange-&gt;start, prange-&gt;last);
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
+								trigger, NULL);
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
+			struct mm_struct *mm, uint32_t trigger)
 {
-	if  (!prange-&gt;actual_loc)
-		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
+	if  (!prange-&gt;actual_loc || prange-&gt;actual_loc == best_loc)
+		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
+						mm, trigger);
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
+						KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf-&gt;page);
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
+			uint32_t trigger, struct page *fault_page);
+
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 649f9685e1ec..5a15866b52ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -156,7 +156,7 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
-		      unsigned long *hmm_pfns, uint32_t gpuidx)
+		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	dma_addr_t *addr = prange-&gt;dma_addr[gpuidx];
@@ -171,6 +171,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		prange-&gt;dma_addr[gpuidx] = addr;
 	}
 
+	*vram_pages = 0;
 	addr += offset;
 	for (i = 0; i &lt; npages; i++) {
 		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
@@ -180,6 +181,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		if (is_zone_device_page(page)) {
 			struct amdgpu_device *bo_adev = prange-&gt;svm_bo-&gt;node-&gt;adev;
 
+			(*vram_pages)++;
 			addr[i] = (hmm_pfns[i] &lt;&lt; PAGE_SHIFT) +
 				   bo_adev-&gt;vm_manager.vram_base_offset -
 				   bo_adev-&gt;kfd.pgmap.range.start;
@@ -202,7 +204,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		  unsigned long offset, unsigned long npages,
-		  unsigned long *hmm_pfns)
+		  unsigned long *hmm_pfns, uint64_t *vram_pages)
 {
 	struct kfd_process *p;
 	uint32_t gpuidx;
@@ -221,7 +223,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 
 		r = svm_range_dma_map_dev(pdd-&gt;dev-&gt;adev, prange, offset, npages,
-					  hmm_pfns, gpuidx);
+					  hmm_pfns, gpuidx, vram_pages);
 		if (r)
 			break;
 	}
@@ -347,6 +349,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&amp;prange-&gt;child_list);
 	atomic_set(&amp;prange-&gt;invalid, 0);
 	prange-&gt;validate_timestamp = 0;
+	prange-&gt;vram_pages = 0;
 	mutex_init(&amp;prange-&gt;migrate_mutex);
 	mutex_init(&amp;prange-&gt;lock);
 
@@ -393,6 +396,8 @@ static void svm_range_bo_release(struct kref *kref)
 			 prange-&gt;start, prange-&gt;last);
 		mutex_lock(&amp;prange-&gt;lock);
 		prange-&gt;svm_bo = NULL;
+		/* prange should not hold vram page now */
+		WARN_ON(prange-&gt;actual_loc);
 		mutex_unlock(&amp;prange-&gt;lock);
 
 		spin_lock(&amp;svm_bo-&gt;list_lock);
@@ -973,6 +978,11 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
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
@@ -1617,6 +1627,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
+	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1685,11 +1696,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 	}
 
+	vram_pages = 0;
 	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
 	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
 	for (addr = start; !r &amp;&amp; addr &lt; end; ) {
 		struct hmm_range *hmm_range;
 		struct vm_area_struct *vma;
+		uint64_t vram_pages_vma;
 		unsigned long next = 0;
 		unsigned long offset;
 		unsigned long npages;
@@ -1718,9 +1731,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1746,6 +1761,19 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1998,6 +2026,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
 	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
+	new-&gt;vram_pages = old-&gt;vram_pages;
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -2116,7 +2145,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node-&gt;last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &amp;&amp;
-		    prange-&gt;mapped_to_gpu) {
+			prange-&gt;mapped_to_gpu) {
 			/* nothing to do */
 		} else if (node-&gt;start &lt; start || node-&gt;last &gt; last) {
 			/* node intersects the update range and its attributes
@@ -2906,6 +2935,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
 			uint64_t addr, bool write_fault)
 {
+	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -3041,32 +3071,35 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p-&gt;lead_thread-&gt;pid, addr,
 				       write_fault, timestamp);
 
-	if (prange-&gt;actual_loc != best_loc) {
+	if (prange-&gt;actual_loc != 0 || best_loc != 0) {
 		migration = true;
+		/* Align migration range start and size to granularity size */
+		size = 1UL &lt;&lt; prange-&gt;granularity;
+		start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange-&gt;start);
+		last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange-&gt;last);
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
+				r, svms, start, last);
 			goto out_unlock_range;
 		}
 	}
@@ -3420,18 +3453,24 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
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
+		(best_loc == 0 &amp;&amp; prange-&gt;actual_loc == 0))
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
+					mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
 	return r;
@@ -3486,7 +3525,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 		do {
+			/* migrate all vram pages in this prange to sys ram
+			 * after that prange-&gt;actual_loc should be zero
+			 */
 			r = svm_migrate_vram_to_ram(prange, mm,
+					prange-&gt;start, prange-&gt;last,
 					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
 		} while (!r &amp;&amp; prange-&gt;actual_loc &amp;&amp; --retries);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c528df1d0ba2..be11ba0c4289 100644
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
</pre>
    </blockquote>
  </body>
</html>
