Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7FFC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E7360FF1
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E7360FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8E66E223;
	Thu, 22 Apr 2021 13:09:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450216E223
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 13:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR8OJxFtz3a681YvYyBo/L7L93Um2MTQQO/Djnsnex1MVlW7HVizosp6DxdhQsjHaOwzULev2c3v6EBBu7xOh/jGAYWc5COShajMTQL+Uq7GLbTJXGs0eI0eNkOeni2bWwrGsGJIYG+xGYHs1gOQmfXPwO1iVDzdOuhuzr63e20CUicX9z+y8TR6v2T7BMonORCRe1FTSX/mri1m4ouv8AjIBpp5N2mfzuT1K+AFyYzB8nRG+ThN03/ocyNf7jMyibB78jQqUbHOatvpgZZCDGudEnzf+NInEMCmelZ107SkdnBxLoW+Pe2AJP7Mrn/DeWCErBe2hTqyv/hbvxQx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ4VRK+/52lpJy2s9Y+LJK1v4b9hrZyWY4XAsdMyGu8=;
 b=ezMHsCqci0IzPC/bR1Nt+2p4XhPHQMbB47vu/1CUDvfiX/u69CD6M6JIIotyjNZ8mtDRPfauV4d+6KrxutMsj9T8EkWPNDMamtcVpRumgeyaE2LcNL+mUI/v2iyWXoT5KWSRWV5UpCSxnpuMNbvwjtw5s61uP7ChM3HPCrORjSMlCUUmvL5QPXm5+TbyM4VShzFcGu26OCz2x/xy5ZqXLqbn4ZFg7lc49GJZgfNgjWH9G7iuYjOCclHRquWgYI07Lm+56PPoHthEEapUVYvvbf5XT4Rgem/KL6D3QxCWwdMvfj/2m2Wq8qHchFaepbWKb5jYGl83RTKsJj3oh8NYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ4VRK+/52lpJy2s9Y+LJK1v4b9hrZyWY4XAsdMyGu8=;
 b=EJ51EbC9HnwiKzaegSYYV0ckonh+ipYq044YLA+4c72acyo3+nQLLFMJU9YAPFWuWSUWSvU6Li1XnwJy8xSLjgelWdcYexjKt+Fddb+xqkYkXgdiXnIENmP4kR1CMragPg5fyxh6DBrnhBryzZ8FDE51/kBVOd1gKUMOi491zzE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.23; Thu, 22 Apr 2021 13:08:59 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Thu, 22 Apr 2021
 13:08:59 +0000
Subject: Re: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Sierra <alex.sierra@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210420015205.9606-1-alex.sierra@amd.com>
 <803e53c6-7268-5521-fd4f-835da994a07e@amd.com>
 <bcd32802-4b03-c7a8-03b6-34e6f3ee0710@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <13fd91b6-473a-984f-6678-b3e3af613e0d@amd.com>
Date: Thu, 22 Apr 2021 09:08:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <bcd32802-4b03-c7a8-03b6-34e6f3ee0710@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::45) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Thu, 22 Apr 2021 13:08:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbf6e34-f711-41aa-b363-08d9058fcad4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4636A107150767F40C3C9C37E6469@DM6PR12MB4636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/rdUDl3NE0d4Rb9JfJ8axZCaa6JoB3MNhRFlK5yQqN6hl+kraANtojEP1vuVXKub1qfGpEhFCfhXZIf/dmAKJ91kY2MlA5D+dVeguK54vypOv+jEaH/PeLKabrznFsQvf4unEsZ5rE5O3g+Py7vJ9oVdo21jGG+18Q8stGQt0YXBZHRZqLFiXCnXKko7DOsjbch2Y87/q6GBi07N7pY92SBMlJlKYSLtjj2qlOf3MBVBb9RdpcnUjBeEXSDQPA+ScMxeWNdzxjl2pfwCe7proNv7m2lngtiYG9yZZRKKajN1U7CjmIYzcXdbW82G1e88DRNjHeFvUnl8jiv5OOTAXkbrScza24J0Tc1x9YvBxVTObigCcAO9fsEDefJGvVXYxXsmaplJ2WdrhGhQxTkOJ8RjdpRoGq92Tc86Az5Cu2CUUX7BsijkO3ykWSy9uwLPG62OEwvlDoPSJneq2OsKdfzLb8yUUlOqMHJ8LXQJuHDZRo2c3yWs/BqVRFKeDwz/xguw/qcSnm/rrk8ROculy2kT9tgL0JVzMiZ7ERK7lOnnuKDk5ZCkHl07fU54Xsd28qZEYPeG2sYwtGiQlVfihrGVmIyXADjHkUC/gZoWC+t5gJsbCrW8VgtiLz9p/mFuC1Zgh5Teog9nxHUlFgNFE7diMu69Lr0nZMr0twX935bdp28AO7YwrfFghnuxQg8cXC9yw+Nh0g2BO53J/m3bftdugXbz3AKZDXt8O8kGJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(366004)(136003)(346002)(376002)(110136005)(16576012)(83380400001)(186003)(5660300002)(53546011)(66946007)(38100700002)(2616005)(36756003)(8676002)(6486002)(8936002)(66556008)(478600001)(6636002)(26005)(16526019)(166002)(956004)(66476007)(31686004)(316002)(2906002)(966005)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZUR3S1gvOStTclVzSkFuV2ZxMG9Da0ZRRzJIb08veVJ0Ny85M051dGF1Wjdt?=
 =?utf-8?B?d2Zxait2dE5Rc1NvcWVsai94VE9vN09jYWxWUnIxT1pjQlJiUVRKMmY3VVI5?=
 =?utf-8?B?TkZ5NWliMy9ES2I4RFQ5dDhNS1pUK2dBNXpoMHdmYWRRanpPTnB3bUMyZlJJ?=
 =?utf-8?B?b2Uzc29YQjZBRlhhYUVndHluQ1J3aWpZTSs5YVB2N3h3YTlSM2I2VGcxYW9H?=
 =?utf-8?B?WFZudlY5UE9zZDF3RXc1M1NDOVRkQnJRNHRCVmFIK2NZbHJCRC9jRG9zLzVW?=
 =?utf-8?B?MitCQUIvVC8rSzhpcG5QcnBaQVFDYnJIKytpakRuUk0yaGh0dEJLWUhiYksw?=
 =?utf-8?B?S3pwVGhydVh0SXd1eGJQRTA0c0dITVBKb2Z2MEh4RWxFeWRJbk1MVDJUNjdh?=
 =?utf-8?B?ZGIrUWdGeHAyTS9rM3BLOEIwakhoWk1OZDVobVRVN1pTMVJqSkJzWnJRc3BI?=
 =?utf-8?B?QnU1VkJ2QjRVTUkrQlAxYVVCd2RaZmFsZWhKUmUwcmRaUmJMSTdJbVNiOTF4?=
 =?utf-8?B?SEhHU0ZmekZFd2d1cXNuZ1YwMmJBbGZXWHZtdnZtZkYrZ202SVZhRTZUeFFo?=
 =?utf-8?B?UG16dzlETVJVa1lHTGdSOWsvWkZ1cDJzZUFqQlNUVWdyQUpzL0pNTUJWVGNH?=
 =?utf-8?B?TC9NYXFxT21zN0tPdGdrYmNqeDBHTkIwVWZhMXhnc0JDZDNpR05CdGdTdjFC?=
 =?utf-8?B?ZUtBNWoveEJxRXFYVDhEWm5OcFRHWEVrSmFmTkdkc1NxeW9EaEhLeHVuVWZF?=
 =?utf-8?B?ZEY2VS9DcEdSTUV1Y3NheEZCYkNpZURTM2VMOS84YlFUanZFTUQrTUl3Z2tF?=
 =?utf-8?B?cUVIM0gwMms2aTVTUllKSTQyVStUZnJQekNzUmhqM1R4aGhDTWkxNTd6NkRC?=
 =?utf-8?B?WUN6WUIyUmtvVTh3eEZvVE16Mzg4Nkhpc1B5Ni9ITEhobDVNbkVXQUpnOXdE?=
 =?utf-8?B?dU45SjlqejVUc1ZtUTQ5U2dOSEgvbGh6U1Y5cE1mMDZjWG9ZQzRwLy9Samhr?=
 =?utf-8?B?NXBzRXNpcGthRHJGeHh4YzFWalJiUjVjTEI2Zk8xTE81RTdqVVRNbU1LUXpz?=
 =?utf-8?B?c3EvWmN4aHVNSmtSRGFKWXBhaFRsQnJ1b2RDWXUxUGN4QTFWTitUYlkvT0lt?=
 =?utf-8?B?Q29GYVpLSjY1VkNLTW5RckVSMFhoVWxtZHNEeklDTDlxNjlrQkFPaGl1K3RR?=
 =?utf-8?B?Uk5pVWxWUEsvYlBWalJyak11U0tPN1V4a3pmTkxpajNzdjJzVFBOK3dvOHhN?=
 =?utf-8?B?UFVNSzZNZmVZNlV6ZjJicnpCeC9Xckg4NjE2b3I2cy9YeEp0NjIvRjlmK2V1?=
 =?utf-8?B?ekk0Wm5EYW8zamRBZEZncDMrSS84anVCRWZJeTluVUFtdmoxN3ViNkZYTk9N?=
 =?utf-8?B?aGdTcmRVWjcwM3VqVTlNSy9uMTNhbWJzVDdIMGNaSm1RZGpLSzl3WFFQUjdv?=
 =?utf-8?B?V25vdVRGN0V6MHVlaEIrNFQ1WTR4OWVYcnNaWHBoWUF3STZNRUs5dHFYcStX?=
 =?utf-8?B?VFFsZ09ONmE1Z05wMzBkYWlSdWpkaS9XZDVQSVZjQ2dhS08wYS9zZkhUV3Vt?=
 =?utf-8?B?SmphMU5rQXF5U3FNK2dOaDJLNmRhNEk4aWttUWdCUXFNeDIwcGZoN2loVzFj?=
 =?utf-8?B?VmZwTmxqYlFnUTlnWU9RUjkxVERrZUQ2dndXMXlFOGg5V1RWd1VwU2JZODdr?=
 =?utf-8?B?clBxTzFqTEtLTkVvVGZTamtTdmVLUlFxTU1mMDlrQUVZaDNDS0ZNM3I1L1BB?=
 =?utf-8?Q?AqIB+HsYY4I7GtLc7a7tG+OavFLu0BaW3lvhn/u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbf6e34-f711-41aa-b363-08d9058fcad4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 13:08:59.2314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHoA6BqND69D5tn8otF26q6UmrSD5yJNjoSnfZW6Kb85bZ7daUTW2eYTnc0yQ63L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4636
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
Content-Type: multipart/mixed; boundary="===============0106835420=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0106835420==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-20 9:25 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:bcd32802-4b03-c7a8-03b6-34e6f3ee0710@amd.com">
      <pre class="moz-quote-pre" wrap="">
Am 2021-04-20 um 8:45 p.m. schrieb Felix Kuehling:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 2021-04-19 um 9:52 p.m. schrieb Alex Sierra:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">SVM ranges are created for unregistered memory, triggered
by page faults. These ranges are migrated/mapped to
GPU VRAM memory.

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">This looks generally good to me. One more nit-pick inline in addition to
Philip's comments. And one question.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I found another potential deadlock. See inline. [+Philip]


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">---
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
+			(unsigned long)ALIGN_DOWN(addr, 2UL &lt;&lt; 20)) &gt;&gt; PAGE_SHIFT;
+	end_limit = min(vma-&gt;vm_end,
+			(unsigned long)ALIGN(addr + 1, 2UL &lt;&lt; 20)) &gt;&gt; PAGE_SHIFT;
+	/* First range that starts after the fault address */
+	node = interval_tree_iter_first(&amp;p-&gt;svms.objects, (addr &gt;&gt; PAGE_SHIFT) + 1, ULONG_MAX);
+	if (node) {
+		end_limit = min(end_limit, node-&gt;start);
+		/* Last range that ends before the fault address */
+		node = container_of(rb_prev(&amp;node-&gt;rb), struct interval_tree_node, rb);
+	} else {
+		/* Last range must end before addr because there was no range after addr */
+		node = container_of(rb_last(&amp;p-&gt;svms.objects.rb_root),
+				    struct interval_tree_node, rb);
+	}
+	if (node)
+		start_limit = max(start_limit, node-&gt;last + 1);
+
+	*start = start_limit;
+	*last = end_limit - 1;
+
+	pr_debug(&quot;vma start: %lx start: %lx vma end: %lx last: %lx\n&quot;,
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
+	if (svm_range_get_range_boundaries(p, addr &lt;&lt; PAGE_SHIFT,
+					   &amp;start, &amp;last))
+		return NULL;
+
+	svms = &amp;p-&gt;svms;
+	prange = svm_range_new(&amp;p-&gt;svms, start, last);
+	if (!prange) {
+		pr_debug(&quot;Failed to create prange in address [0x%llx]\\n&quot;, addr);
+		goto out;
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">You can just return here, since you're not doing any cleanup at the out:
label.


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+	}
+	if (kfd_process_gpuid_from_kgd(p, adev, &amp;gpuid, &amp;gpuidx)) {
+		pr_debug(&quot;failed to get gpuid from kgd\n&quot;);
+		svm_range_free(prange);
+		prange = NULL;
+		goto out;
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Just return.


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+	}
+	prange-&gt;preferred_loc = gpuid;
+	prange-&gt;actual_loc = 0;
+	/* Gurantee prange is migrate it */
+	prange-&gt;validate_timestamp -= AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING;
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Is this really specific to svm_range_create_unregistered_range? Or
should we always do this in svm_range_new to guarantee that new ranges
can get validated?
</pre>
      </blockquote>
    </blockquote>
    It's good idea to set prange-&gt;validate_timestamp to 0 in
    svm_range_new, then we don't need the special handle here, and
    restore_page will recover range to update page table without waiting
    for AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING for new range,
    AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING is used to skip duplicate retry
    fault on different pages of same range.<br>
    <blockquote type="cite" cite="mid:bcd32802-4b03-c7a8-03b6-34e6f3ee0710@amd.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+	svm_range_add_to_svms(prange);
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
+			 * Also flush pending deferred work to make sure the interval
+			 * tree is up to date before we add a new range
+			 */
+			mutex_unlock(&amp;svms-&gt;lock);
+			mmap_read_unlock(mm);
+			svm_range_list_lock_and_flush_work(svms, mm);
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think this can deadlock with a deferred worker trying to drain
interrupts (Philip's patch series). If we cannot flush deferred work
here, we need to be more careful creating new ranges to make sure they
don't conflict with added deferred or child ranges.</pre>
    </blockquote>
    <p>It's impossible to have deadlock with deferred worker to drain
      interrupts, because drain interrupt wait for restore_pages without
      taking any lock, and restore_pages flush deferred work without
      taking any lock too.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:bcd32802-4b03-c7a8-03b6-34e6f3ee0710@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+			write_locked = true;
+			goto retry_write_locked;
+		}
+		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
+		if (!prange) {
+			pr_debug(&quot;failed to create unregisterd range svms 0x%p address [0x%llx]\n&quot;,
+			svms, addr);
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
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============0106835420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0106835420==--
