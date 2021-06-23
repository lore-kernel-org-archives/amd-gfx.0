Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC20C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 14:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5AD608FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 14:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5AD608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E316E920;
	Wed, 23 Jun 2021 14:54:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01D986E920
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 14:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqMy6xepGAWJksIz/tVdz+H+hZE8+M+wW7KI1dFFcPCtrvtj3pZheBiFgjorR90QtMw3vJvD8bRIJXzzX5k552jtROdwjKGgyfbpEaX3eKvZRPzI20trt3bEOhsfFd2B9rCRDnQ5qe/LgZFgAbfoC61fyMj4L6yVnmts4SlqXXAGO8mKQIm48R3kyrZueQFgnFj5InVB5qaigMKONkUg98CxiqjaXyF8Oxmmqbkeees1WdT8krlAn00EoC+Vd+6HT0NeYRS3EE4PzAnWlxtXTHHgtHeslE7Q1J6swaeqfJX0Rugb4pLwziWaibYAFSfIG6N02EoXz4UIj9pCFJ6Bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK3q2+HALUvwsajZSmEPwRpMpvruCVw3fBHjQcimUxI=;
 b=bSvd/ajiq7COh1I/jdoO4CpXnjGtKQ+PYzAsWcRFkqqGzNclIlNL4kqlW+mBC31BLdcxzgDYHwR2TPHPztUTqfcTmVrRwBYw2wTD6VDtjQrJBFDkLzY66Ljqm0Q3rPf8CJLNnfbUBLR/y/t/qEAH/dfY6AMk24AN2pVO6vMIog9NLFCk2NXmr4onk18sYG8lxb3KUU4L2GEZs1fWbbdw7E6u+MwzxBlL+IcP5kvluZyq2LM0hDiyYEAK4m01F5bctKoKxEbPmz/DZr+CTHG319vqiLcixYH+29nTIM1aHTpyPWWvLoZ70e6T19lmKS2wfGl4qFsV4rwYDDebjAhdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK3q2+HALUvwsajZSmEPwRpMpvruCVw3fBHjQcimUxI=;
 b=FyZeflBjPvVosuHB6qEFPdx8gWUMZ/pZAzeJhAch9RHCRa0XCjylWQ7rXdtw/trcAEpOqcT+PV1R3blqQuQkrCeOCQrROPO0u6navO0MtorX5NhCwGrkMms3+m7gro8AmbTrBMZjO5qzVx7j5mZw1ivwEd5Yt0LuuaJQ9fFjkPg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM8PR12MB5494.namprd12.prod.outlook.com (2603:10b6:8:24::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19; Wed, 23 Jun 2021 14:54:35 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f0d0:ef63:9b7e:b13]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f0d0:ef63:9b7e:b13%4]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 14:54:34 +0000
Subject: Re: [PATCH 4/4] drm/amdkfd: implement counters for vm fault and
 migration
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210622133213.21393-1-Philip.Yang@amd.com>
 <20210622133213.21393-4-Philip.Yang@amd.com>
 <4150a526-9bd3-3d7e-0aa0-5ceef3abecec@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <a31063bc-8249-062b-8784-e467e14b8db5@amd.com>
Date: Wed, 23 Jun 2021 10:54:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <4150a526-9bd3-3d7e-0aa0-5ceef3abecec@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19 via Frontend Transport; Wed, 23 Jun 2021 14:54:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57c4e129-fb52-45a9-b95e-08d93656d086
X-MS-TrafficTypeDiagnostic: DM8PR12MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54945EFE5F6DD922BF99408CE6089@DM8PR12MB5494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxvzvtKOYSGuxMqFbaJHHwmnPVmF0kItj08MRlTOfULlN2RxEmssiCmQf2MrSBYsS2Ji5phLT3YxmmyHv4xq6Ll+iYLitb3329Y0TJ2UVEZZA5LX2tnI5xn1cOGaFc/DASJeCxAEUSIt/ph2exy31RW7XiWqfay6cl118Vk1F8zUTBL4tnUBNoxPTGaZBU4SA85+kUbNZscPN4bua6IID9xvTTCSIgXNhBKX6KiqZjoSt+qV9u/PUNFFMk6mTEM2rzacky0IS23jBt8o2cA1uF135h+oA2dWXUjyiP03f+7+05z+G32PbHx3UWNGZphJChqlgAL4mzKs9x6UzYyWLrkJWBSOUtRN51zfZuEjEEpbMunF0FlrrWqOlpaOE+x0JWYZssJVGAxqrN6OPkgMsR5GgazEwbkeRR+GxoEZYUg8xZEoRaq3g57xsLG45POuZJ/+OzIFaWi+lpQ8RWl9WBHYk00Wtu9Q7WOya0GPmeU2Odbtq1ftpgxlCcKNp43zoUDzo/sY+oxDpBBMPk7i4Zg7ygudMPanCS5pdEWD9QycSlYNqQaa3olRC4ygsrhwOe/Zz7/iZyO3ot9FIvTEciLzXHhHVsmllm8y3S6VTriRwIt4nSOEpaAkkz1bjVttkIgntbOWV0SvPuaVYZOfDXcMzGTm9RiMli35bIMlUFJvkAFCVjge9z6C19PNpzc+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(31686004)(186003)(16526019)(36756003)(8936002)(53546011)(5660300002)(26005)(8676002)(66556008)(66946007)(66476007)(38100700002)(83380400001)(478600001)(956004)(16576012)(2616005)(316002)(110136005)(2906002)(31696002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MklUYXY4STJuOHl1VjQ0K2dUV3RVNU5zL0xpenlGY2NPbnhoK2JFOGcwaloz?=
 =?utf-8?B?MXNzcHBoek9KeUw5NlRFL0ZmWnpFQzNCRjc0MjNsQWpoTUttNDFwWFFVdGFR?=
 =?utf-8?B?THg1MGVtTThnVmN6RDNvaDdsMVZmY1NFK0JGb0dpYk9SUHo4Mm1NMzNRclgv?=
 =?utf-8?B?a01SUTlYN1BTRnlPZVZOYW9OWWZjMnFYQUhSSEIreDZ1MVlXQTl2aGtpNy94?=
 =?utf-8?B?Uk54ckxzbnBFY1NSNXpLVzFkcmhKN3MvYVN0SlB2YmxtS1JSNXhObFV0ME10?=
 =?utf-8?B?OGtPazNQdVVCOXZSd05rM3ZDQ3hQZ1pydzY5eXNOZEI0YzRiSkJCeWdVUGZm?=
 =?utf-8?B?UXF5dFBLbUp1QWpibkh1Y3UyMW9YZXhKZW82ZGphSXkweWpIczZHd1psQ2Rm?=
 =?utf-8?B?NVJ5VlhNY0ZBUGFQMmdyZVlBOXNBKzhHcGlGM1gxZ3F5am5TeERXTG5vUU5x?=
 =?utf-8?B?K0ZVQU9jUDlKSU9MRjNWWEJVaDdPalcvNTVSS3hrSzBJNy9RVGtrMjFRRjEz?=
 =?utf-8?B?Ykh6bnk0NnZzMWVyYUlYZWttVUdITUdJcEJOY0l3MUJyajQxSDJhSmdhU09v?=
 =?utf-8?B?dUhzZHFleU03QVg3SlZPRUc2b2JuVDdJTFpTU3Foa2dMNi94clhCNkZTL1Zl?=
 =?utf-8?B?eWg0Z091TERkNDY4cS9MY1Fabm9MYWE2eUh4U2RFbVhIWmVnTUkvOXorZWtO?=
 =?utf-8?B?eXkrYzdmV0twdGhPa0VDRU0xK2pLWm55TzVOQ2k0ODl2RUNiVHlDNXh6dVMr?=
 =?utf-8?B?Vm82RUNPRGhjcHhlUE9KV0YvNTdwcENUNjVvTEd5V0FIc1pjcTdpOUhTWUlG?=
 =?utf-8?B?OTQzdnBPTzRLd2ZQRi90OWMvTU0rRzFkdTg0d1RkSFhINVVvZFQxL3JKSWdD?=
 =?utf-8?B?UVE2VVJHQ1pxenQreFBuZGZueEoxSHM2cmtpS2VvMkZIZnJkVmpGZDlpUnFT?=
 =?utf-8?B?dWlRRVl0TUZxUGYxV0Fld2dkTDg0TXVkQm1NZTBxajVLamFoQ21jb0tVS3Jo?=
 =?utf-8?B?dmxrbTgxNzUwckZaNXNPZmpMWWdwbGY5Tmk1VDJNODdhNGw4c1BRa285WXhE?=
 =?utf-8?B?STIvdm9FZ0xaTlFHTGpnUUJxVmlnbEwxRXkyb0d4TXh0OG95b0pWRTZrcXZB?=
 =?utf-8?B?ZjBrUVVXbmNHSXliektmZTV2dEFpRDFWU0kwNWQwYkxQYTdtdk8vbU9sVThF?=
 =?utf-8?B?bVdyaVkzYTVxVVZBUktOaGtKU05nZE9YVytUZ3BnU2JRUGdjT0M2ekZtbzBJ?=
 =?utf-8?B?M2pHTisrdE5jbVhmY2UyRWdOY203NnBEMStibHFwR0kyMjg5VG1iYS95SjI2?=
 =?utf-8?B?VC9sOUpHS2hNOWVCRmk1Qy84WEcxMEVTcUcrb2VNd3JMV3NSclZFR2gxNXY2?=
 =?utf-8?B?UGNTZUxrb2NqOU5sTFQ0a2RaWDdxVVJNTGFITUQ0VVNheUlqV0UrbUVwSS9T?=
 =?utf-8?B?YVRvaVNKSUhXdFU0RWxyMzBiZnpNVGpwbldFd0RFZTA5YWtmaFBVcWV4N0k5?=
 =?utf-8?B?cG9SeEZWYVJDalNYTFgveUdWUTRvYkYyQmFDWlBFd3BBWGduQ001c1JpYWxw?=
 =?utf-8?B?R1RQdFFLdlJlaUZBTWM5YXI0SmtFS2UxcHY0NktxdHNRT3IxbC9JdUdHdHJu?=
 =?utf-8?B?allVYS92UjFNdk9TczdvSUgyaDM2ZnVycGJta01GRjI0VTFENVJGNXNSR2lr?=
 =?utf-8?B?b3BuS0RaekJVZUJUUEU0SVcwTXAraDEzcXRLcU5ScnFiK3paaUV1NGlRNG5B?=
 =?utf-8?Q?zbCTmwCuCDdQJ8kVBWpsE56VMFTkKWsjfLDcCsz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c4e129-fb52-45a9-b95e-08d93656d086
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 14:54:34.8749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOTDUz/pLpgElVwQlLLWuHPy6r2v+2ZWXdyfn2lFix6kLpcDDdoyGwUDG0pYjcG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5494
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
Content-Type: multipart/mixed; boundary="===============0302682695=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0302682695==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-06-22 7:31 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4150a526-9bd3-3d7e-0aa0-5ceef3abecec@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-06-22 um 9:32 a.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add helper function to get process device data structure from adev to
update counters.

Update vm faults, page_in, page_out counters will no be executed in
parallel, use WRITE_ONCE to avoid any form of compiler optimizations.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index fd8f544f0de2..45b5349283af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -413,6 +413,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			uint64_t end)
 {
 	uint64_t npages = (end - start) &gt;&gt; PAGE_SHIFT;
+	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
 	dma_addr_t *scratch;
@@ -473,6 +474,12 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
+	if (!r) {
+		pdd = svm_range_get_pdd_by_adev(prange, adev);
+		if (pdd)
+			WRITE_ONCE(pdd-&gt;page_in, pdd-&gt;page_in + migrate.cpages);
+	}
+
 	return r;
 }
 
@@ -629,6 +636,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
 {
 	uint64_t npages = (end - start) &gt;&gt; PAGE_SHIFT;
+	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
 	dma_addr_t *scratch;
@@ -678,6 +686,12 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
+	if (!r) {
+		pdd = svm_range_get_pdd_by_adev(prange, adev);
+		if (pdd)
+			WRITE_ONCE(pdd-&gt;page_out,
+				   pdd-&gt;page_out + migrate.cpages);
+	}
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5468ea4264c6..f3323328f01f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -564,6 +564,24 @@ svm_range_get_adev_by_id(struct svm_range *prange, uint32_t gpu_id)
 	return (struct amdgpu_device *)pdd-&gt;dev-&gt;kgd;
 }
 
+struct kfd_process_device *
+svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
+{
+	struct kfd_process *p;
+	int32_t gpu_idx, gpuid;
+	int r;
+
+	p = container_of(prange-&gt;svms, struct kfd_process, svms);
+
+	r = kfd_process_gpuid_from_kgd(p, adev, &amp;gpuid, &amp;gpu_idx);
+	if (r) {
+		pr_debug(&quot;failed to get device id by adev %p\n&quot;, adev);
+		return NULL;
+	}
+
+	return kfd_process_device_from_gpuidx(p, gpu_idx);
+}
+
 static int svm_range_bo_validate(void *param, struct amdgpu_bo *bo)
 {
 	struct ttm_operation_ctx ctx = { false, false };
@@ -2315,6 +2333,7 @@ int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint64_t addr)
 {
+	struct kfd_process_device *pdd;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -2440,6 +2459,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 out_unlock_svms:
 	mutex_unlock(&amp;svms-&gt;lock);
 	mmap_read_unlock(mm);
+
+	pdd = svm_range_get_pdd_by_adev(prange, adev);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
svm_range_get_pdd_by_adev needs to do a linear search. You don't need
this here because you already know the gpuidx. I think you can just call
kfd_process_device_from_gpuidx(p, gpu_idx) here.</pre>
    </blockquote>
    Thanks for the review. There are 5 cases here, case 3, 4,5 have
    gpu_idx, and case 1, 2 still need svm_range_get_pdd_by_adev, I will
    add new helper function svm_range_count_fault. The profiler don't
    care the details of vm fault, count all cases and report to sysfs.<br>
    <br>
    <p>1. fault on different page of same range</p>
    <p>2. fault is skipped to recover later</p>
    <p>3. fault cannot recover because GPU no access</p>
    <p>4. fault recover failed, may try again later<br>
    </p>
    <p>5. fault is recovered</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:4150a526-9bd3-3d7e-0aa0-5ceef3abecec@amd.com">
      <pre class="moz-quote-pre" wrap="">

With that fixed, the series is

Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>


P.S.: Thanks for catching and fixing those memory leaks in patch 2.


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+	if (pdd)
+		WRITE_ONCE(pdd-&gt;faults, pdd-&gt;faults + 1);
+
 	mmput(mm);
 out:
 	kfd_unref_process(p);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 0c0fc399395e..a9af03994d1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -174,6 +174,8 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
 void svm_range_free_dma_mappings(struct svm_range *prange);
 void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
+struct kfd_process_device *
+svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
 
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============0302682695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0302682695==--
