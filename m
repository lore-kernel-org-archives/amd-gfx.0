Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E66C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 16:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1744961361
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 16:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1744961361
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8922D6E1B7;
	Mon,  8 Nov 2021 16:30:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB9A6E16D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 16:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3N81sYxolmc4SZxzwYLzibWLnzkwFD6jcjjrKQozUBBpsGP6LJire0CJHmMJ5h0uh43Sg0LCaLkSKPP8uRLr66BtNYoRwcW9oCcXd82AYLzuMAzpnO7XikHJBZxIT2sryQWstoAbFPrDWlYV6QA0T+qajEQYvXSKw9NQLxqEXP3RU9eZCu9pYMWQZrG6IqmLiQdSQcO4F7sdJSkJeK3qH1zjnYpb3Nfga01yMgYgheBTPbLnWY1iNHAJj5tOdMvR3BZjmSGLmTpEVcaK0SoilwZr/5pHbGNhZTMdEH87Fxea5gwkiM0FlCid79SYzMYewMeLVSZTW/35HLxbeb/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBjmdsKBRWk76erF9Sn5nkRCPOjcYx2O8jsu7hkrR5c=;
 b=Kl4oWEUx0NQobJ38YD6YteiFyRBwJNpUE7qz1eRgYicPD4TWcblHk2mMQN93Ye4sbSdJFsoFwQ4b9qQmnKMLHjJmgjtB7lQSRD0tBS0CUuYV1sZgY0kCtvnmnGFp2gfJwTWo/nN1jPsvrAXiIoBURrADDnHgHdLu+J46vK8x8X1ULxekz6/ZCkucMZcJN5D6IuD9PbQ5XOiNmuadddNxkBp4aIsaLhJxmfdgNk6wGkGlDIwJxJctaC5CR0PsEaQbW8w3Xopad21kDwbfo3bYKgZ494Kb+7xH9EzZsMqWXLcIX/eoFLfT4sTEDCgcJdTHkpWbGgmdXC9fbZl5innFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBjmdsKBRWk76erF9Sn5nkRCPOjcYx2O8jsu7hkrR5c=;
 b=JdsY98vK989YNCH/H0EUCqmMiC+prrxpb2bYXmurTSm3aC5dsTWXCg1i1Ks4kDWjknBhUD+Nzer3/LS/Vcz2VX2WIUIUQgE75ljMW5NttfY/jYdq893Fdk9Ogxhv7bIZYqx/kizClL1HJlrjJjmsXE8AAG0HY5HLTVLq5ynTvMs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 16:30:47 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Mon, 8 Nov 2021
 16:30:47 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Fix retry fault drain race conditions
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211108141549.1573995-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <c4694c50-027f-d619-6088-b5d4780c817a@amd.com>
Date: Mon, 8 Nov 2021 11:30:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211108141549.1573995-1-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 LO4P265CA0007.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 16:30:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ace60da-56dc-4f52-0745-08d9a2d51e26
X-MS-TrafficTypeDiagnostic: DM4PR12MB5278:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5278FAD84619207C773EA60FE6919@DM4PR12MB5278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lOBmK9l06yZ5l9xlfDa3xNnK28ti5f4DapW9pnTZRUbp/GuhSfXktuoITL7OfSvUOZFLReA7zW5sp2d4mspUY/neg00cdbm+TX4RvZP+dnLvCQCz3gdlD2ku//lQYYFIxVvMGPIBvnfGdIReyxRztoW5yqQJhV3TvzeykP0RIcyrlXps7/OUTDbRcb94wkJ6iz5s21vlqQB7ooBMJJV2tHORfikLg6X1gFo3YRm2e6vgyfGT1bLdn1xhsmaSzkYDjjimXodciv/BkhutexwPbLLb3okXZPft5bIb2QELioT24t1WMddC1AoO1/BkY2q20TM9Grf+ZuH/aQReZb81+6d2tSHZK4pswNjrQ1P5yQ2QgIz2Rvl6f8e9CxPxaktD7rw21J1zo7OFw22Homf3xJvTe/e7ku+PLJmP/qVTka594E65+4C48kn2kKujucAr/0bXBGGqvxVYddYsUxUdVnM7zct9oo+tzBGVdaV0+Any0eII80cdwzQPGVkx6chnzUOCroXxyNfqhC+MMLWDZUeZq7CXzCvycY0AJXhDcgWVdebgd6MmZmXDhYyNrBCIEWtwIgndceWg9TJs51ch4ARJLEY6q2aDr5WUWc/5/9tB01g+arw7cC/btRJObkzToN7v882lvuSe6RTfQ7tgzJq7kh5LaZui4emp6HStCw3CcU4nNQEZLtQg8CSO6nl9hBxfuXicVQM60mu7btcaemaJKRbgH3u7BtPhkHtYVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(8936002)(8676002)(31686004)(4326008)(6486002)(186003)(6666004)(2616005)(956004)(2906002)(38100700002)(53546011)(508600001)(36756003)(54906003)(66946007)(5660300002)(16576012)(31696002)(316002)(66476007)(83380400001)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFExTGV4anBxQzR0RHZHblRrY0VGaFN4TXh4dHZxK3BMMHZQY1JLSVFBOTRZ?=
 =?utf-8?B?L0NIcWVJeUVHTVYyVW5mcWY2eGpTMnJuU3g0dmEzSDRBb3lhaTlKL21PalZH?=
 =?utf-8?B?a05BazkvOU80dDkxcWNBdUMxQmhkbGwyRm4rbHpEb3U1R3pNYW9GODczR0xS?=
 =?utf-8?B?S1pzZU53WW41Kzg1ck1UWVQzcEhpWVVDSnBIc1V1SkFnNlZOclR5QSt4VHpF?=
 =?utf-8?B?YnRnMmRUV2VzRjhDL3ZrbHpjZ1c1VEM1NkRTdldnQTJJcnI1SUVDeDVkQldv?=
 =?utf-8?B?V2IwT053d0N2ZDR1OTNxSjlmMXA2TmMwMnlURnJmNUc4MkR2dWRLQklNcTZB?=
 =?utf-8?B?NzU2U21sSFRJZzJ0ZHJ1VVNSK3lWdFp6MjVydTZhQnk4d2svdUw3QTVJaWtq?=
 =?utf-8?B?djNkUHEreXZ3U2srSmhSMXJjclAvUUtjWURlVjBZbDB2WlYwaFdhZEZOcXIr?=
 =?utf-8?B?U0xRMzhZOGdNN0ZQT3ZmRU93RURFdTlOWlR4ZkJCc3dQaXlsaUpEbG82MWxr?=
 =?utf-8?B?T01semJUNWx1ZVZsVnBOdGxmNGxRa1gyOS9EUDVHbmV1K0FpdnNKQ0JHRzZU?=
 =?utf-8?B?Z2RjYmJvVUxyRFo4UDZXdHFpUHRUWlVrZGJNbXEyaWZ4V2lUWXRvb0dSQ1Bz?=
 =?utf-8?B?UGs1YnVRRmRNWjI0RFZpdlNTN1RwZld3ZklxTmRPVU5WRVdVeExJNERzVzEr?=
 =?utf-8?B?Q0VyVGZTeXg0dmdQNGIzZmpybnZmMU1oUmxuZnFPZnFWdVA1ZUVxNTg5V0xT?=
 =?utf-8?B?bGZmbThESTRsYU8zdml1eW5vYU80d0l3OUhTSmlMYWF4SWEwbTRRd2UrZm5t?=
 =?utf-8?B?R2NobVRKNk04M1lUaEFCMFJjWk9IbXZzUVBSbUt6Tm1GWmNZMFJrZnlkTkJ3?=
 =?utf-8?B?ZlpDb1FWU2NSWk1zd003MklJRk1TZ2w3YW9wbWVXa3phT0pvSXBoeXdyaWZX?=
 =?utf-8?B?OEVUbit0MzZtSEdKL2ZQQWpHaXJ3bDJaMGF4Um5nYTRRVEszaXVrbUowdlZq?=
 =?utf-8?B?VG15a0FIVnRrb2MxVGpCQ0syTXBQMlBjZXBzTTZTRGxUaGVrOVp5cEROdll1?=
 =?utf-8?B?K3RHNWVqNTVQbmIvRHdXSkRUaGlTd21sc2V5YzlYZEsvTnh4NGZTRkNmbWVS?=
 =?utf-8?B?czBiM2lIdGdLM05lZTVacTJXMk11K0xYRGp4THVnaWpTb1V4SG04NlY0aW5Q?=
 =?utf-8?B?dFlrV1FXZ0U0L3ZuUkpGOElhdXBTeGNDL2I5YSs0dnNVbjVFVkhpMTk2bW9D?=
 =?utf-8?B?cHNCZGp0M25VYVV1ZnFMM2lSWHRzK3NZajZXNUs4SmZ3VWxzcGpkNjAwejY3?=
 =?utf-8?B?VWgra2k2R2xQRDZOVms5L0k2QXVRZUo0WGZsSmN6ZWM1a1NETS8zOURMQnhr?=
 =?utf-8?B?R3ErdzJoeXRJN210WWZsRlVSaC9KTUt4a3BEWFF0ZHVQWG1vYW45L2JyNFdR?=
 =?utf-8?B?dnFoUUgzU0lzM2g3eXpaMmlrOHRkcnZMNE9ma3Y3NVdmY09nTmFMUlRjTzBI?=
 =?utf-8?B?RU4yRmVPT0xlZXJvNUxqRlZDR0RHaFJFNWxSU2dBalRMY1pieWhkSnRCOW1G?=
 =?utf-8?B?WEV3SmIzcUJwMEdPWG9qZlAwZUs0eGxaMHNLR0dnWWZHb1pQWVF6MFZQKyth?=
 =?utf-8?B?N2svVXJGNlh5QktKdjVWNmVqN0dhRGQrL2tTQ0VDUnR2dnpCcnNXaWFma3FY?=
 =?utf-8?B?Q3l2RzdLaGs3d1BOeWFUbVBtN3prSUhrM0pOaXRtWWZnY3g4TFRDZmcxcEhQ?=
 =?utf-8?B?RVI4WndFUkNYY2VPU3IyTnBBNEtHaHBVWmxoaERDbUdzUnlxQlp0VStEaFR6?=
 =?utf-8?B?SFhUbXZpWE5QR01ONkVMaTdZR0YrS0psaVpSS1RTQW5FcHA1OTFoVGc5MWJh?=
 =?utf-8?B?SHhkbDl3SVhWNEpwL1E3ZlNXWjJMZWEzUVV0aU44RkdqRWlqK2hNa3gvcDJu?=
 =?utf-8?B?d2VKeVE1WWkxS2poVHEydHZCNVIzd3hlY0ZiSEJqcmc5MGpJR0xOMHlRbHhH?=
 =?utf-8?B?SVdOS2xXRk5VZTByL1NrVzB5REltK0lVTy9hZ0xxenlNcWJQd3FTN3pzTHpv?=
 =?utf-8?B?Y09jV1lZdFNKNW15MUZUalY3ZnNVbUQ2R0lOdU16RzR2azNzeE1wRlZZME1I?=
 =?utf-8?Q?vJD4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ace60da-56dc-4f52-0745-08d9a2d51e26
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 16:30:46.9896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xujHw58b6FKALFToPNqd4sszJPyMY+rVsiyG1ql0ANdzJZw2npKxD7xhcFgka4KK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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
Cc: Alex Sierra <Alex.Sierra@amd.com>, Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-08 9:15 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211108141549.1573995-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">The check for whether to drain retry faults must be under the mmap write
lock to serialize with munmap notifier callbacks.

We were also missing checks on child ranges. To fix that, simplify the
logic by using a flag rather than checking on each prange. That also
allows draining less freqeuntly when many ranges are unmapped at once.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Tested-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Tested-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20211108141549.1573995-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2a5b4d86bf40..78ae96fc8a6a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -766,6 +766,7 @@ struct svm_range_list {
 	struct list_head		deferred_range_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
+	bool				drain_pagefaults;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct 		*faulting_task;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 065fa2a74c78..77239b06b236 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1991,20 +1991,28 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 		pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] op %d\n&quot;, prange,
 			 prange-&gt;start, prange-&gt;last, prange-&gt;work_item.op);
 
-		/* Make sure no stale retry fault coming after range is freed */
-		if (prange-&gt;work_item.op == SVM_OP_UNMAP_RANGE)
-			svm_range_drain_retry_fault(prange-&gt;svms);
-
 		mm = prange-&gt;work_item.mm;
+retry:
 		mmap_write_lock(mm);
 		mutex_lock(&amp;svms-&gt;lock);
 
-		/* Remove from deferred_list must be inside mmap write lock,
+		/* Checking for the need to drain retry faults must be in
+		 * mmap write lock to serialize with munmap notifiers.
+		 *
+		 * Remove from deferred_list must be inside mmap write lock,
 		 * otherwise, svm_range_list_lock_and_flush_work may hold mmap
 		 * write lock, and continue because deferred_list is empty, then
 		 * deferred_list handle is blocked by mmap write lock.
 		 */
 		spin_lock(&amp;svms-&gt;deferred_list_lock);
+		if (unlikely(svms-&gt;drain_pagefaults)) {
+			svms-&gt;drain_pagefaults = false;
+			spin_unlock(&amp;svms-&gt;deferred_list_lock);
+			mutex_unlock(&amp;svms-&gt;lock);
+			mmap_write_unlock(mm);
+			svm_range_drain_retry_fault(svms);
+			goto retry;
+		}
 		list_del_init(&amp;prange-&gt;deferred_list);
 		spin_unlock(&amp;svms-&gt;deferred_list_lock);
 
@@ -2037,6 +2045,12 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
 			struct mm_struct *mm, enum svm_work_list_ops op)
 {
 	spin_lock(&amp;svms-&gt;deferred_list_lock);
+	/* Make sure pending page faults are drained in the deferred worker
+	 * before the range is freed to avoid straggler interrupts on
+	 * unmapped memory causing &quot;phantom faults&quot;.
+	 */
+	if (op == SVM_OP_UNMAP_RANGE)
+		svms-&gt;drain_pagefaults = true;
 	/* if prange is on the deferred list */
 	if (!list_empty(&amp;prange-&gt;deferred_list)) {
 		pr_debug(&quot;update exist prange 0x%p work op %d\n&quot;, prange, op);
</pre>
    </blockquote>
  </body>
</html>
