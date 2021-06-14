Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB1C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 13:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0F16120E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 13:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0F16120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CFE189AAE;
	Mon, 14 Jun 2021 13:52:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847A089AAE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 13:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy5p5aUbRFw4z+1jyCUN/xEKVoZjd0s4mM2Rt6rVODX3RK7XGCB3kTIMcR23wgMR580eNIYq9B7tCF9DqySbgS89SR8jheHjUaHwjmY1Z+DreDmMVs+7mxMfaq5eptUw2l2xSCaXD8AJRa7UFI0Vs73MP00Fq7v1Lpdu3LZZkb71f92blxRpYWt7EQ40MSljKmMix9TOd8i2F6vGF3q2FebTlrGiwq04FWiHn/iHR0HRekR+hPUBOv9cdzz6KPG1FbbJvuJHNZjSjL8+oOKys85ucyG3jGyE8my0dL3iZDP+n5k6/h0diu0VXrlhMrlf+ToM13PwqmYhCmqM+EfLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8uw4MmnR0snaJvj7CyXF4MM9Tx3KWl6VKgO4KxpL+o=;
 b=i2VyLSkfjcUo3GnnIFl6KkiBmbmL8TbEE+D+uuv3YT+qyLeAHuZIOwR9fcuRxtiiLi+wjZMDCY1D3u7sFPa11Or6sibvEBnG2YZt6vLrDoN+vf6bzuVlo6Lxisf6Dmp7c4eigOpv6WVbPB4AkKCLjv4gdLtWHcW/D+q1OTEZhaFBrnUZAJxUcemZ/tsVUZI93Sl+ZzCzmr97Y+znxb6ZXwejWsw3yNTEm78A6+JSFf1XjF1bkQcyg1U34G+cCAQW+VELuBXB76U9Wi2/f05Dk6ERb4zSB77+qFeinPmEIyYmjqCqUoPGqjjwovH7XC8B+38RBgIXymPeBvd558k6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8uw4MmnR0snaJvj7CyXF4MM9Tx3KWl6VKgO4KxpL+o=;
 b=VbRumPFijG9utQxKgsPId99UIbRjFailQScxW+bXnV93nwwfFtwwgkE7+Lhcnwfpl29glvTHoFS9WbOkvv0GB+YWgofU/fajsqtrHmp9PHdxXQLuOaiHLN36fSnABmb0gPDOiC4B8dtOVsZHmlK8gj+bsvnG18+ido00vlFMRfw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Mon, 14 Jun
 2021 13:52:20 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f0d0:ef63:9b7e:b13]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f0d0:ef63:9b7e:b13%4]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 13:52:20 +0000
Subject: Re: [PATCH] drm/amdkfd: avoid double alloc by ioctl_alloc and svm
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210611045143.557-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <c7852b93-af93-3ef5-372e-25928e268cd6@amd.com>
Date: Mon, 14 Jun 2021 09:52:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210611045143.557-1-alex.sierra@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::19) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTOPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Mon, 14 Jun 2021 13:52:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a16b049-50b4-46c7-da6a-08d92f3ba0ce
X-MS-TrafficTypeDiagnostic: DM4PR12MB5199:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51994D6F8088113E575AC4C8E6319@DM4PR12MB5199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1j/ccnD1sS3F3OtGIQBFZwTIbT9uSzfO846938KeQFGWg82geO0kDdIPw+gq6Mn1FyIT3UHRz5FF07VfzLG07NcLSbzqOEtaH8ksF9fLxyLdWevYMNOD/5mY5xMoYgawQpQcKCbNQtvpCx7StMjV9a87IX3AmoyG2yItCHn/qZN8eauUHYpeGDbdqy9P3bVhxkc1MulvsTaqRSb49JeWHrNRM167yIldaE98mf8ssOju5RPExe4jfU0Xwn2aln5TTDhHEFuk7We/l2RtgB/FOpxbsg+OWu3P1XCGaXeSGVFK8v3ItWwmvUlknoLDJAidcF8zmijfRTEQGUbvimIS0rHEeJpJXIG7TS+qPKMrkeGqec+42QczbGCzl+3diXocw+pjOvG5SZCRLAqs0iQw1bIksPzcfUizkfiz1JvSMeTpspMd139Kzq7i6O+dR8f2NQNVPCb9/rEfqSw1VLPTPPQXA9hQo0e6k1HRDbq17ftULEbEWpqFD8ZfLs74CDjcCaYvT1FirjDZLlXWNnn90bGvRKHsaioBwXIk2KjKJSBcx2PlPHhKxK0kRZDqddmnxx35qZgORwv9nws04w0I1Sl5FeIRLI88ZGTjc6eYhvZDLoWt/OAim+13lpZITbKB/Esb7t0wvkm0vDUR8zwbP2P/40dyiNCDqPZF8UdwNUi/fmaPGrVTfIJ8Qz8sDWJe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(26005)(316002)(6486002)(16576012)(2906002)(478600001)(36756003)(2616005)(16526019)(956004)(31686004)(83380400001)(186003)(66556008)(66476007)(8676002)(53546011)(38100700002)(31696002)(5660300002)(8936002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEErZFFkdFYwalcvU2p2SlNiQW9pVkFpTWRVRmtGemVHVFM2TzJBWjFFWFRt?=
 =?utf-8?B?dFZXMi9SUUY3aG9iR1hGaDBNM3RoWVpKejlHOU9uL2x6Zzg5dkJaeUZsaU42?=
 =?utf-8?B?Mi9nS1V5a1RDTFJBZzBzbTVlNCtIQ2p3bk55d2piT0g5RmFiNHVKUGNud3Iz?=
 =?utf-8?B?TW16d1pyY0FRanFVcHV5R0VLdnZKS3g0R0ZFa3VWQ21pUGNSSktVL1V6S3Nz?=
 =?utf-8?B?NzFJRGFwVnpPQm51VFJBNDNlSnFwc1ROa2c4bUd2NWVwNVdvTGpVb3lzZjNT?=
 =?utf-8?B?NElBREc2MEpKUFBpZ1JMdmtYVGxtRTJKU3o3RlhvelAwZ0V6R1IyUTdhNGRZ?=
 =?utf-8?B?Mmxnb3loL2RzUG9nbkNOVDMwNGZIcnJQdmZTZXBqKzV2YXBBMmZ2S3AyMFdY?=
 =?utf-8?B?cEZzbFVmUjQ0OE14NnV3NU9iNTFobFU1SDhsVUtHZWV0UC9SaEZVVE8vclE5?=
 =?utf-8?B?Y2I4cnRCWmxoeU5HampuRXZGMlROd3lSb1NSRlhVc0dNTExPNDk5bHFTZWhq?=
 =?utf-8?B?eXhqdmhWZ3I2YUZzOWErRHBmeU9PTWxYaHRiYmw3dDg1RnBHZncwZlNNQWYr?=
 =?utf-8?B?b05wU0V4RUZBSldadnNuQmUyWWs5OUxEMzhQM1U5Znk2RE4zUTl1RXNZekoz?=
 =?utf-8?B?cHovK1BZeHJFblpaYzlMQVJ3OVRYakt4cXAxNmhrY2hjZnJnaDBqMVArMDhK?=
 =?utf-8?B?ejdGcDVDUUZPNmdhUTNBdUJRY05xYjNpU2xRQmNRMDZ2YVUyN2l3WUJ0Mklk?=
 =?utf-8?B?dU5nalB4ckJHNkZ2S3RMRWF2WHh5bURnM2hNem9mNUJZS1hPUXZIVlYxU2p1?=
 =?utf-8?B?KzNia1FyMTFmMDhjZm05MkpRaENNbzU5TUNlRzRuTFlyZ2RLNHZEVkx2Nkx4?=
 =?utf-8?B?RjJUUFk0R0JRL3lLb1lJMnRSOG5TTjJRYzRheCthRU5WTDZRZWNwS3FkVkFx?=
 =?utf-8?B?YVptZExnSGNuVmlSMUw0dEQ1b0ZHdWJVTEFQRFdCeHhTSkRzSjZxcVFGUzlV?=
 =?utf-8?B?endDMHNIUHVIOXJMazhBRFpwUjBiLzBLV2VVeWlON2k2c3ByTGQ2OFhpeTE0?=
 =?utf-8?B?elE1T1d4UXBkNjI1VmpsZnRsS1ZpamY3QXhFVGJSRDBaYkpRVi85NVJ6NUFa?=
 =?utf-8?B?SzdULzRqMXM5aGptTVhyS1FSODZJNU9ZcXB4ZUFQM1d4SlBRODAwVVduV2Nm?=
 =?utf-8?B?MnJUYkVMc2FRb3pOWmhiY2k2LzcvZ2ZDcDZvVFJiU3ZOeU85UDhZUjh3aDhD?=
 =?utf-8?B?Zlp0ZWcxTkNmUEVRelNCaTA5RW9vb2JqMFRlbFpPNThvM2FuQWZRcitxeStF?=
 =?utf-8?B?NHFGM3BYWGdvSU0rSDhxcFJHQkdHN3VPZEJ4ZjFxajdlMFpSUDRSZmVXYWs3?=
 =?utf-8?B?RGhkQkxnT0MvaHZWWWwvYVAzMTNiSk5CNUoyRzdWL2RlRXNHNHQrU2VMNWRh?=
 =?utf-8?B?c1RXK1BRYXpld3lleW5YeDdYcDR4bzRKQ3RBY3UzRVJZdmc0Q1BySVFJeEx4?=
 =?utf-8?B?OXpJWjUzTXUyZ09Ca0p6d1BkV1lBWk9uemgzanl5c2Y5VkYxQ1JYdkgzeVhI?=
 =?utf-8?B?emF6WFdYZTNmRHdEL2FQbGpoNFYxYVZBbVNtRzVCb0h4WUpFRDJnckVTR3F6?=
 =?utf-8?B?VHZVeVI0Um5oNURUMU5zVS9PWFV5RFRoL3EvZWxSVDNyb2pXSU1LbHdSME1N?=
 =?utf-8?B?MER4TEhzT0l5dVlGTlh6cXZEdVlMaThDQVE4UXk1WkZJRHdESG5TdnMycFcw?=
 =?utf-8?Q?evAZvGWwFbjE2jreCJZW1jdd6L6Uu+lnvoPIY3K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a16b049-50b4-46c7-da6a-08d92f3ba0ce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 13:52:20.0527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWq+xFbVk1IbbCp+n+uBDL4vhVULCC3PpYvEhg0/rCA++atf/QjSRUaxN6LVKfhx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
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
Content-Type: multipart/mixed; boundary="===============2143568266=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2143568266==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-06-11 12:51 a.m., Alex Sierra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210611045143.557-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">[Why]
Avoid duplicated memory allocation for address ranges
that have been already allocated by either
ioctl_alloc_memory_of_gpu or SVM mechanisms first.

[How]
For SVM first allocations
Check if the address range passed into ioctl memory
alloc does not exist already in the kfd_process
svms-&gt;objects interval tree.

For ioctl_alloc_memory_of_gpu first allocations
Look for the address range into the interval tree VA from
the VM inside of each pdds used in a kfd_process.

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 63 ++++++++++++++++++------
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5788a4656fa1..0cfa685d9b8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1259,6 +1259,17 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args-&gt;size == 0)
 		return -EINVAL;
 
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+	struct svm_range_list *svms = &amp;p-&gt;svms;
+</pre>
    </blockquote>
    should take svms lock<br>
    <blockquote type="cite" cite="mid:20210611045143.557-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	if (interval_tree_iter_first(&amp;svms-&gt;objects,
+				     args-&gt;va_addr &gt;&gt; PAGE_SHIFT,
+				     (args-&gt;va_addr + args-&gt;size - 1) &gt;&gt; PAGE_SHIFT)) {
+		pr_info(&quot;Address: 0x%llx already allocated by SVM\n&quot;,
+			args-&gt;va_addr);
+		return -EADDRINUSE;
+	}
+#endif
 	dev = kfd_device_by_id(args-&gt;gpu_id);
 	if (!dev)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0f18bd0dc64e..883a9659cf8e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2485,9 +2485,40 @@ int svm_range_list_init(struct kfd_process *p)
 	return 0;
 }
 
+/**
+ * svm_range_is_vm_bo_mapped - check if virtual address range mapped already
+ * @p: current kfd_process
+ * @start: range start address, in pages
+ * @last: range last address, in pages
+ *
+ * The purpose is to avoid virtual address ranges already allocated by
+ * traditional kfd_ioctl_alloc_memory_of_gpu ioctl.
+ * It looks for each pdd in the kfd_process.
+ *
+ * Context: Process context
+ *
+ * Return true only if range has been mapped
+ */
+static bool
+svm_range_is_vm_bo_mapped(struct kfd_process *p, uint64_t start, uint64_t last)
+{
+	uint32_t i;
+
+	for (i = 0; i &lt; p-&gt;n_pdds; i++) {
+		struct amdgpu_vm *vm = drm_priv_to_vm(p-&gt;pdds[i]-&gt;drm_priv);
+</pre>
    </blockquote>
    take vm root page table bo lock<br>
    <blockquote type="cite" cite="mid:20210611045143.557-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		if (vm &amp;&amp; interval_tree_iter_first(&amp;vm-&gt;va, start, last)) {
+			pr_debug(&quot;Range [0x%llx 0x%llx] already mapped\n&quot;, start, last);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * svm_range_is_valid - check if virtual address range is valid
- * @mm: current process mm_struct
+ * @mm: current kfd_process
  * @start: range start address, in pages
  * @size: range size, in pages
  *
@@ -2496,28 +2527,28 @@ int svm_range_list_init(struct kfd_process *p)
  * Context: Process context
  *
  * Return:
- *  true - valid svm range
- *  false - invalid svm range
+ *  0 - OK, otherwise error code
  */
-static bool
-svm_range_is_valid(struct mm_struct *mm, uint64_t start, uint64_t size)
+static int
+svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)</pre>
    </blockquote>
    svm_range_is_vm_bo_mapped returns bool, this should return bool, or
    change <br>
    <pre class="moz-quote-pre" wrap="">svm_range_is_vm_bo_mapped to return int error code.

Regards,
Philip
</pre>
    <blockquote type="cite" cite="mid:20210611045143.557-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
 {
 	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
 	struct vm_area_struct *vma;
 	unsigned long end;
+	unsigned long start_unchg = start;
 
 	start &lt;&lt;= PAGE_SHIFT;
 	end = start + (size &lt;&lt; PAGE_SHIFT);
-
 	do {
-		vma = find_vma(mm, start);
+		vma = find_vma(p-&gt;mm, start);
 		if (!vma || start &lt; vma-&gt;vm_start ||
 		    (vma-&gt;vm_flags &amp; device_vma))
-			return false;
+			return -EFAULT;
 		start = min(end, vma-&gt;vm_end);
 	} while (start &lt; end);
 
-	return true;
+	return svm_range_is_vm_bo_mapped(p, start_unchg, (end - 1) &gt;&gt; PAGE_SHIFT) ?
+					 -EADDRINUSE:0;
 }
 
 /**
@@ -2826,9 +2857,9 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	svm_range_list_lock_and_flush_work(svms, mm);
 
-	if (!svm_range_is_valid(mm, start, size)) {
-		pr_debug(&quot;invalid range\n&quot;);
-		r = -EFAULT;
+	r = svm_range_is_valid(p, start, size);
+	if (r) {
+		pr_debug(&quot;invalid range r=%d\n&quot;, r);
 		mmap_write_unlock(mm);
 		goto out;
 	}
@@ -2929,15 +2960,17 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 	uint32_t flags = 0xffffffff;
 	int gpuidx;
 	uint32_t i;
+	int r = 0;
 
 	pr_debug(&quot;svms 0x%p [0x%llx 0x%llx] nattr 0x%x\n&quot;, &amp;p-&gt;svms, start,
 		 start + size - 1, nattr);
 
 	mmap_read_lock(mm);
-	if (!svm_range_is_valid(mm, start, size)) {
-		pr_debug(&quot;invalid range\n&quot;);
+	r = svm_range_is_valid(p, start, size);
+	if (r) {
+		pr_debug(&quot;invalid range r=%d\n&quot;, r);
 		mmap_read_unlock(mm);
-		return -EINVAL;
+		return r;
 	}
 	mmap_read_unlock(mm);
 
</pre>
    </blockquote>
  </body>
</html>

--===============2143568266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2143568266==--
