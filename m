Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C0DC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 00:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6386044F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 00:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6386044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4076E923;
	Wed, 21 Apr 2021 00:16:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A64C6E923
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 00:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMIUfeKoB56I6kA0DgUhIrk3spzPio5ht7eXoXjj4h1HvllwIW+HFTFOWz+x/cpw4ikvnqRDRPI5ljc2zfe4XvlyIeLX9r1I734+QBGqLVKqVQuCdwb3INAw1AsFXebJtfje61PmSLPrfP3W2xPgJdw5wX+qMmhpLE/5zc/BSAl9d3c00c9V5TaFTxMPWiSEqOmfbJSpipxFtyMq09uNE3sD50eY6lTegsYStKb8drdiyqeljj84NOSy0nn5FLEOBofGsSdjIPgXdRvu1Ziu/vdQ2wxnfUrTtD6vzFGzUk5tRzzpDAIMH/34Jm9Fm0Om1xz0qbd9qbpdHLCNIxXt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzgewwGflTioLfVtvM/wG/IUQPKV+opBMwauHFSFGQs=;
 b=a7UJRWu4hTPKg1zEYW0vj5Xn3bL69q2ZQz8HnMbreRLIWyLl7C8C5SZ+rkoVf7s+9VSbDo0g90jkwFwfFIYW73M16ZG5y4CTzT4erPj8Cpnbsve40cfNroahu2lOOeosnuoXzqL7FHcX27y94+jml3bJVu/wio1JNd/rdbwZPpnr83YiMI2jayBwDBIKzqaZqqvAmi4Zr5vmVwRAx1j335pHIyZ2MGsReyYrDmwxvFmVlbgTmwPH0vzLRxbJmhXL201oqF9BHmP8BuLtYqYteIow32oMh1kgVHDohsKxf37oHiBu3L6xExL1z5jaNTkSptbSJj2un01xGWRD7guyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzgewwGflTioLfVtvM/wG/IUQPKV+opBMwauHFSFGQs=;
 b=At7MnNtNVDAYsGMhhOiuYAlH5n0Xq1WXa2FNWg/zYv0VagYJ0gmm5+V3z/gdHOi8z9LWLMsWNeP9Mi+DO+WnyXzUWy+MniaRlUFY1sdNv73QMDYfRYCemPj0ZFMzz07RfwlQpHdbYvzot5zeC6HYmX2HGo3YeNFxWkcDYnb9Imo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Wed, 21 Apr 2021 00:16:32 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Wed, 21 Apr 2021
 00:16:32 +0000
Subject: Re: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210420015205.9606-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <4228c4fc-f01e-4d76-c77b-37976d7c790e@amd.com>
Date: Tue, 20 Apr 2021 20:16:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210420015205.9606-1-alex.sierra@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::42) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend
 Transport; Wed, 21 Apr 2021 00:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d62981-6946-43d0-50ab-08d9045ab744
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB010868EA03C8FFC70E1DD647E6479@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HhwyGXFgxSf4vCME4vwGGzbd/xCFrfUjZ4kAHHfC3NT7RRk+eVCtsWQ7mbpzSGgsM3PF0oT9JRTAE3OrU+b73Xso0BHKjRzl7VRwyT6EiWRKZnb1F8ximpyajnaeHSL76g1/8oSZJzhFvsZgIPkr5ilpKxuQh8y2zRB7yS5ZA2OgfJcqZ3O6Xthlb/AR9CGvOhbcgt8+vLcHxjhABB5VrWQgO1AKgv1pzXGP5KrXBGCHNNoHYCuIW6s9mdvJlimo5E5c7/9j2/9vp9o14ixAorj04a13NVFHJRghmEKYTVGms1dCPhgmC1hYmN3g469FLLxwOdZW8V06VqeLXcVZm5RWn+sHer/eOv7p6t6sjsBtZgnIzBul7G4Xsk+ZBdXBXyd9j6s9IRSdfCTIPsFRzWg1GvSNHmR7Qyr/x+65cq+/0+geqZ7FAdDM5BBxSoINE5pdU/P8jAkJsMSdBIkpIw/wNx9H21RXlNSoyInrHip7qv41o1gqBE268NAcwQnxau763beZxKI6GOYCEftx4DApzW7p6lG69DVL6MLhbP6SHNhDlDeJ6RR+eM93R2ettNi/D5/ilKNulBx8G9v6716W7Ie+C5ZLCNu95v+1exJ3VrAbl8OGgov7pgNtYCpiw020DSKhZbSpSwn8/9/wCUHeC3waBzHp23Wz5+4DdzxLjGUHTjRF+Y4StWj/DTf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(38100700002)(6486002)(26005)(956004)(16576012)(36756003)(316002)(478600001)(2906002)(31686004)(16526019)(8676002)(186003)(2616005)(8936002)(53546011)(66476007)(66556008)(66946007)(5660300002)(83380400001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RnJzZE5LRFpKU09HZkNwTUFqVnFhSXlJUXpLVm1vZlFqam00MzNkNVMxQjFR?=
 =?utf-8?B?NzFoNnFLQncwNXd1OWRwendabEFBdVJkenhtSXJwbFRac0tlSlhrSjlZSDlv?=
 =?utf-8?B?M1FUTnBSVGJtY2xpSmYrbyt2a1N2UGRmQUZBOGxUYXJma3BNVnR1djRKWWo1?=
 =?utf-8?B?cGZJN01Dd1l5VTIydWhGL3RkdUNHUDhjb0JIejEzOEpsUTNRR29xYjBxV0Vs?=
 =?utf-8?B?d2hOZXA5QnpEeTNEaVNFdmM0dm5XaFd0cURuWk00UStRVUlBTGE3U0dFOXAw?=
 =?utf-8?B?bk5oZXJTRUtJKzc0NmxwRm91Y3ZlNlBrRFRBb3RVbkUrdE9zZ1V1a2RDSnFL?=
 =?utf-8?B?bTZjRkRjS3Bob2JzN1NxWjVnMXBhcDdNdmV0Nk9mSEpUT2MxYURuL0JLeVV1?=
 =?utf-8?B?T2lXNHp0MitwLzBjK21yVXkrY3dRdmt6ZzhOdmE5VmYxY3Z1T1VaNmtBVlhB?=
 =?utf-8?B?czNxZkR1RUdNSlVZK21aY2drWmNDSE1rODZ5OGV5MkVXSDFENTJKY0UyTkxO?=
 =?utf-8?B?T2o1MGUxc0JhY2dKcVRoWFlla3oxSmJqNXUveWl5ZWZBbE5tVkdHcTBpcEJj?=
 =?utf-8?B?dWJKMnFlWklHV2YyZFBzYlpaeWR3bC9QTzNhdzVvT1EwYVBLNyt1NnpvcUY1?=
 =?utf-8?B?cElkUENGSkhYc085OHIxaC9oMTVvSnFPcnVUUmJHZm9GK3BtYlVjZWdZSC9h?=
 =?utf-8?B?QXlENHRNTlpNWSs4VWJ6SFVnSEUyVE1oL3JWTDhzRUh0OGV3UmU2RUJxVWpV?=
 =?utf-8?B?Q3VhWXlOUU5XdkIySnppTEp4MDRlU1RUeG5HeENkOTRqRWlyVDNSUmU4QzJ1?=
 =?utf-8?B?WU9LQ0tVN2ZMeUxGbTY5RjJlb0lEK2JPanYvVThQSXQyQzl4ZWpmU2hDdW1X?=
 =?utf-8?B?L2V1czFkMHpqbk5iTllYWHFGVmtiUHVHb3FxT244bVIyajg4N21lVURqYnQx?=
 =?utf-8?B?TE93NllTL3EvbTNYZ0lDak42ZDB6ZXk0TFBpZkJwSmNCSmprSUpNYTUxMUQ5?=
 =?utf-8?B?a25uSGdCaExic0ticnpKZ2VHcVVsSnBySDN4eUNhK1NjT1k4eHdFaW93cUtJ?=
 =?utf-8?B?bmhQZWFLcDExcmN5aEw0TzZSQ0haVHo2U3djdVBCSGIwU1J5KzdGYkNUZi90?=
 =?utf-8?B?c3d1Wk53M0VYWnR2cUFPR0tKUVZUSExwQ0hoNVRGSE1uY282c2lIL1NzNER6?=
 =?utf-8?B?YnRMbm1xRHdiZjhZMEl3Y2VTZWpKR0ludjVVT1Y3dVkyU0hjc2hOVkptRmIw?=
 =?utf-8?B?VytIS1p3NTViaW56MzN3dzd3MWROSGExQTZDM3lYNUNhVTViRWQ1cWdka1Np?=
 =?utf-8?B?WTQrbHh0YUNWTGRqenNTaXNpUTQxbEVNZktaM1JQTVJnWDNIM3BFaVZFU2ZV?=
 =?utf-8?B?WTk2RUlUd3FNcWQxb2puK0o0ckFXNWRmTzR4RHVNblBKUDVrV3VVWDFwa2p4?=
 =?utf-8?B?Ry9IeXJwNzdsVVlOSXBxUEJueWxKQ0lSNEdXd1NsVTFJZnVxeTRUL2lFb1dN?=
 =?utf-8?B?KzhKR2tVaDQyNGg1TnlGbEJOV2l4c1Z0ZEcrb0lDVVg4QUZVU29RSUhrcC83?=
 =?utf-8?B?ZUcrWURHNzY0S0lhaTMzS2EzdC9uZk5rdTd0aFpsM0pHd0FDenZMMkxUOGY1?=
 =?utf-8?B?Vzc0b1VWd3A2S21ralVTZTFIY0Z3TnRqWlZHN25DcGpabmZTQUpVTmJyMFFH?=
 =?utf-8?B?OHR5a1dYN3Q1U3lMMXpGUzBVc0Q1U3FVR3VVTys0bStEYmU0TzJEMy80STJi?=
 =?utf-8?Q?AukbK2wPUJXL9w+YB2yQrUJ1K35plshgPovArQY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d62981-6946-43d0-50ab-08d9045ab744
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 00:16:32.2218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaJmd0mRrZ4PpLQd/qe9mxmAYcUGNgpfOal5vtAWm80fE7wFPFrX+PNnUTasLbtr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
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
Content-Type: multipart/mixed; boundary="===============0656709140=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0656709140==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-19 9:52 p.m., Alex Sierra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">SVM ranges are created for unregistered memory, triggered
by page faults. These ranges are migrated/mapped to
GPU VRAM memory.

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 103 ++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 45dd055118eb..a8a92c533cf7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2179,6 +2179,84 @@ svm_range_best_restore_location(struct svm_range *prange,
 
 	return -1;
 }
+static int
+svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
+				unsigned long *start, unsigned long *last)
+{
+	struct vm_area_struct *vma;
+	struct interval_tree_node *node;
+	unsigned long start_limit, end_limit;
+
+	vma = find_vma(p-&gt;mm, addr);
+	if (!vma || addr &lt; vma-&gt;vm_start) {
+		pr_debug(&quot;VMA does not exist in address [0x%llx]\n&quot;, addr);
+		return -EFAULT;
+	}
+	start_limit = max(vma-&gt;vm_start,
+			(unsigned long)ALIGN_DOWN(addr, 2UL &lt;&lt; 20)) &gt;&gt; PAGE_SHIFT;</pre>
    </blockquote>
    line over 80 columns<br>
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	end_limit = min(vma-&gt;vm_end,
+			(unsigned long)ALIGN(addr + 1, 2UL &lt;&lt; 20)) &gt;&gt; PAGE_SHIFT;</pre>
    </blockquote>
    line over 80 columns
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	/* First range that starts after the fault address */
+	node = interval_tree_iter_first(&amp;p-&gt;svms.objects, (addr &gt;&gt; PAGE_SHIFT) + 1, ULONG_MAX);</pre>
    </blockquote>
    line over 80 columns
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	if (node) {
+		end_limit = min(end_limit, node-&gt;start);
+		/* Last range that ends before the fault address */
+		node = container_of(rb_prev(&amp;node-&gt;rb), struct interval_tree_node, rb);</pre>
    </blockquote>
    line over 80 columns
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	} else {
+		/* Last range must end before addr because there was no range after addr */</pre>
    </blockquote>
    line over 80 columns
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		node = container_of(rb_last(&amp;p-&gt;svms.objects.rb_root),
+				    struct interval_tree_node, rb);
+	}
+	if (node)
+		start_limit = max(start_limit, node-&gt;last + 1);
+
+	*start = start_limit;
+	*last = end_limit - 1;
+
+	pr_debug(&quot;vma start: %lx start: %lx vma end: %lx last: %lx\n&quot;,</pre>
    </blockquote>
    use 0x%lx, to show address as hex<br>
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		  vma-&gt;vm_start &gt;&gt; PAGE_SHIFT, *start,
+		  vma-&gt;vm_end &gt;&gt; PAGE_SHIFT, *last);
+
+	return 0;
+
+}
+static struct
+svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
+						struct kfd_process *p,
+						struct mm_struct *mm,
+						int64_t addr)
+{
+	struct svm_range *prange = NULL;
+	struct svm_range_list *svms;
+	unsigned long start, last;
+	uint32_t gpuid, gpuidx;
+
+	if (svm_range_get_range_boundaries(p, addr &lt;&lt; PAGE_SHIFT,</pre>
    </blockquote>
    We use pfn address inside svm code, and do address PAGE_SHIFT
    to/from kernel functions, pass addr here.<br>
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+					   &amp;start, &amp;last)) 
</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		return NULL;
+
+	svms = &amp;p-&gt;svms;</pre>
    </blockquote>
    svms is not used, can be removed.<br>
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	prange = svm_range_new(&amp;p-&gt;svms, start, last);
+	if (!prange) {
+		pr_debug(&quot;Failed to create prange in address [0x%llx]\\n&quot;, addr);
+		goto out;
+	}
+	if (kfd_process_gpuid_from_kgd(p, adev, &amp;gpuid, &amp;gpuidx)) {
+		pr_debug(&quot;failed to get gpuid from kgd\n&quot;);
+		svm_range_free(prange);
+		prange = NULL;
+		goto out;
+	}
+	prange-&gt;preferred_loc = gpuid;
+	prange-&gt;actual_loc = 0;
+	/* Gurantee prange is migrate it */
+	prange-&gt;validate_timestamp -= AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING;
+	svm_range_add_to_svms(prange);
+	svm_range_add_notifier_locked(mm, prange);
+
+out:
+	return prange;
+}
 
 /* svm_range_skip_recover - decide if prange can be recovered
  * @prange: svm range structure
@@ -2228,6 +2306,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct kfd_process *p;
 	uint64_t timestamp;
 	int32_t best_loc, gpuidx;
+	bool write_locked = false;
 	int r = 0;
 
 	p = kfd_lookup_process_by_pasid(pasid);
@@ -2251,14 +2330,34 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	}
 
 	mmap_read_lock(mm);
+retry_write_locked:
 	mutex_lock(&amp;svms-&gt;lock);
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug(&quot;failed to find prange svms 0x%p address [0x%llx]\n&quot;,
 			 svms, addr);
-		r = -EFAULT;
-		goto out_unlock_svms;
+		if (!write_locked) {
+			/* Need the write lock to create new range with MMU notifier.
+			 * Also flush pending deferred work to make sure the interval</pre>
    </blockquote>
    line over 80 columns<br>
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			 * tree is up to date before we add a new range
+			 */
+			mutex_unlock(&amp;svms-&gt;lock);
+			mmap_read_unlock(mm);
+			svm_range_list_lock_and_flush_work(svms, mm);
+			write_locked = true;
+			goto retry_write_locked;
+		}
+		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
+		if (!prange) {
+			pr_debug(&quot;failed to create unregisterd range svms 0x%p address [0x%llx]\n&quot;,</pre>
    </blockquote>
    <p>line over 80 columns</p>
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">+			svms, addr);</pre>
    </blockquote>
    <p>indent</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20210420015205.9606-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			mmap_write_downgrade(mm);
+			r = -EFAULT;
+			goto out_unlock_svms;
+		}
 	}
+	if (write_locked)
+		mmap_write_downgrade(mm);
 
 	mutex_lock(&amp;prange-&gt;migrate_mutex);
 
</pre>
    </blockquote>
  </body>
</html>

--===============0656709140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0656709140==--
