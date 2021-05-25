Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3397EC2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 13:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E086C60FE8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 13:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E086C60FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DA56E140;
	Tue, 25 May 2021 13:59:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F3A6E140
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 13:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljOs93CfIgwoIYFH1WbbE6tR/gic5HLAPvY0YsbpG4p3QSF74Auvr8VhHjDqKuxF1RH/0YAW/4NygUgzeqeh8OKwUQHl1dWE5kZnPgCf930Cv8YMZWIDbpo10AQztFQfDEIpuN0WyZ0nYHQOdUzWkiNJig0Vfnghj7G9kn3COmyxnWbvNZ6YxT5SrvDFkrJ/35y4ssaD/z+UChUf2B3UH76QKzC3CldNMufJEVxmxHzjclSBjfhDWE//2N0PhFcXErkK6AzucrgYQnJaQxZitHLNuPS8d9XJJgwvpHJZ5+0QDiZybcSA3SZZm1i5VTS7yPaw5BbqygILqXXkMYA3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPo5nOENke/adUGu2rWXNkCOX3iS9bCwjfsFw6bL36c=;
 b=A+Rw0cp6heUfQgBHDxOftni/fI2HOmUZY6P/tbCGvaOyByvs7W6T1mzJ0wxqWZJnC0inGIn7NiTfIlf0fiIfwQ/WVO3AQLNi6utkGz/P6ZHJcXrKSA6GknRbstF/GYrOQq2wmrJymfhxwwitRaVrEo+HnfqaP6wDQdZ5YWlbWRF20TAAKgByyg5kjp6KF0dZyCiTpois/5Im+Q/IvWV821IJ42ZxHJU6u1nu+UrHwUWEV+hDJXF45Pm4tkU4hRG9MQQALCANUVp5PLloTO96OL3gthKYR0wqGK0EqHfQEJAsGbfsyIUDQGtAFCJb0P1S1vRIGTfgiZFBA19Smr9PSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPo5nOENke/adUGu2rWXNkCOX3iS9bCwjfsFw6bL36c=;
 b=RMKQcRPr91+ohReA1mVX98eKmNiXTxJiIG9roZ6Pwby5FJCgM9y16g2DsOmsxr56WBfAX373L+n3JilqzHMzyl6wIBqYQxAzyV+lryM8Gdbg5oqVXXZKLQdNXm32R+4Xw55v6VmJfmpBSQPhSkHJO5pPaUCZcM8SfO2fpN57ojY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 13:59:46 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145%6]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 13:59:46 +0000
Subject: Re: [PATCH] drm/amdkfd: use resource cursor in
 svm_migrate_copy_to_vram
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 felix.kuehling@amd.com
References: <20210521135203.169068-1-christian.koenig@amd.com>
 <914a1fbd-653a-3edf-27cb-4aa064267985@amd.com>
 <091aaf6e-73f2-3ae1-e4cb-309732424150@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <cb1d4a21-760b-adf7-04cf-080017d1b654@amd.com>
Date: Tue, 25 May 2021 09:59:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <091aaf6e-73f2-3ae1-e4cb-309732424150@gmail.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Tue, 25 May 2021 13:59:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1703c612-e898-4e33-38b7-08d91f855ac4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5215BB957BC0C57618563D46E6259@DM4PR12MB5215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zenq/uWK9Gp+1+l/4jU6iuzDaJZPoAktP4HT9/cGZVR682SBvjp6/byZSe51UKimv7Tur+lsv0Yod1vl0c0kow57JwVjEfi1Xmn6m4S/z8Jl4qygxCEGfJYqprdK9C2o8C8txTIulJKU/VoMjan9+nguwdIyKtfSTJwXf5N/w86+Z5svNBbfFTiAF0Nkh01kOt0WqB+r9yBMCvfPFK/5Gd276uYTloz41m6OVnuTumBpHHZ5+22pGfRgjFJQy5hq2zDYVhhZQe1giXwFAkjuQ4xzauTtU2s6xz2DCOXnrwT5pLf5a9E4gCSn6gy9z5Eo7FXW7VLGFq2ilm7NAO/2ui9G8r5GtaXbxgVn7SN0ltYRNyMnlqG8pGBE3aYdMRiFJBiIspIuYIBLouqPy4bN4yy7zGeXvqQv5ub9eu0kO1xJ+gbTx6KqslCAQ9Z8o32825hSGQkrxx5KsfI4YEwLDHky0QJlA5oEyiWl0r7HawlUUk/VMWKXYNfWBB7JxZ7/YAdUKC8s79xH201YEUHikgbxhOw4mmz3GlVDeTEmgc+XqwPlOuSoJYfyh4rZTf5PKAj+1pMC5+pTzqv4AicVsCi/OnYKuRdlfiD8S/jKw1jthPr2qczBAeKfIbCFW+YXDCOAjoaqDs1Z4RZCmYpU5S+OZbxt26Lo5TZcoxWlO7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(376002)(136003)(5660300002)(4326008)(31686004)(66574015)(16576012)(83380400001)(8676002)(31696002)(36756003)(6486002)(186003)(478600001)(2906002)(316002)(16526019)(8936002)(956004)(66556008)(2616005)(26005)(6636002)(38100700002)(53546011)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OVphVVdQeS9rWUhGQlRIZmNSWnp6TzNpYzl5eHFhM3ExOG9haGFzQVJpTEZu?=
 =?utf-8?B?eVU0c3FkRS9tSkpLRzZlU1lTWDRNS1RveHdkWk9RRHNudHV1YzNrUFJGdFJK?=
 =?utf-8?B?VEVhY0ZTaEJWWEd3ampxOVM1a3g4cXYvTm1lMEVSNEJCanF1T0ttaXZqNk0v?=
 =?utf-8?B?ZE0wOS8yQmtKRStCNEUrSW5sWnptd0VDNndGaDVremJLYlRReXdCME9Ucldi?=
 =?utf-8?B?K1NIdGlybmlOYjBZOWlCdXArVkxHOXdiMFZBTitZUGxVdEJLaUJ0ekV3Zzhn?=
 =?utf-8?B?ZFA3SEpQRlNxVGd5UHBCdEhhdk5jK1lscHVuT0RwY3RXU3J3V0diUVJkQS90?=
 =?utf-8?B?YVZPU2gyR2lQc0NTSjVXSE80U1BGeWdPRTlnVUZMMGxTemp4TGRWcjZkcTkx?=
 =?utf-8?B?YnkxUHMxQnF5RGpkQ3ZTNWZMbWdkUTdKemdsL3M2Uld5S21aTGZMRUwranZI?=
 =?utf-8?B?UTU4Qmx5RzJka1BwMWhPS05TVkFxRy9tTU9uMEZ0eWZjK0p0M3JadTNEY0J6?=
 =?utf-8?B?QUJoWGVJSFI2VmJGSjdKZzlGZXQ3cU01empYOEd6RUxFSnJ4bG15aCtiS1RE?=
 =?utf-8?B?dDN4MUlma2ZNNzZwd3I0eS9vMVRpWmF1Wkc2VzRsK1Ewc2hMc2ljMHBzdjFx?=
 =?utf-8?B?bU5GeGtjTi9aY3hWODlzL3ltczY3cEg2UzROcDNzRStoVDBTNnNuVFNTL0Mx?=
 =?utf-8?B?T3cvcjM5ckV2MngzVTJib3JxOWg4b0ZFdkxET1R3Yk9ERUFwbElnZ2JKV1pj?=
 =?utf-8?B?MG0wRXBFczUvblVHR3p3WmhHdzFwZmxLd0loSEljR2NpQnQ1UTh2UGwrcHdJ?=
 =?utf-8?B?S3EzRG00Y0UrcGczVTlFN2JTQXFLbFBKNkdTMHBsV3lpZVFwbXNGdFNhaWRG?=
 =?utf-8?B?cjhoS05uRVlHbnRNK21CV0E1SUdZbDN3bjJsK0ErZWd0Qm5GcVJhWml6UGZs?=
 =?utf-8?B?QzZFQjZGNVh0bEVYdHBmcWtOZEEvSVcxT0NqL0YvbS9yU0VFYk0rSXFzSGVj?=
 =?utf-8?B?WkNLdE9uNW00VU9NWk1WT3I0eWcva2ZBSktpc0NCMTlNVy9hQXlBYzhISzRF?=
 =?utf-8?B?L1RVT0JNUktJT0kvU2tNVUM1UXM0czdpQ21CUXFTZmV2L2lLYXFTRUw0a1RM?=
 =?utf-8?B?eVpua3JndXpJT3ZJaVNRdWJyRG1nT25hRllHZCtsL0FYZy9xNWc2aWk1ZktS?=
 =?utf-8?B?Tk9TaUhEdzQvWmtEYzVUeVJuZUVsMU8vdHlTNzJiZGtxTFhGVDdndzZDcDFy?=
 =?utf-8?B?OUdVaTdrMnZvTGY5clRycyttS1k1QVdZNFB1MzRlTU9FY2pLOWdsNjZobWlK?=
 =?utf-8?B?V3ZmRXkwYWRxSFRKbGRXZXpqaGdBRUhMdzZ4M3hrS0JvSTVzMi96R0NhYnNJ?=
 =?utf-8?B?ck9ZSFBPZWFrZjJaQkw3dEs2TmZteEkzbEFFaWtjVno5aHJMQUJqcVJrMzl1?=
 =?utf-8?B?TEZ5dGRlUmYzbTY5TDhRRkN4elN3bmpXd0Nxdk01Ymk2TFhqY1MzZUJQMDVX?=
 =?utf-8?B?UmNLUDhNVDhzZ0MxUmdoQ2xrVTAyVXdPNmJaZE80TkJXR1NESTZoZUUvdmNx?=
 =?utf-8?B?V29Uclg0OVhoOGhKTTRQRFhidGZ0NS9pSFVLZXMwdWFWZ0RuaEJBTVJGblZ1?=
 =?utf-8?B?UEtSeUhpRzFrWlZ0bXYxTitPMGk1MEYyZWpSSWtPT2VWT013SXNxR2QzTFNP?=
 =?utf-8?B?NnZHMTM2ekR6eGhidTh3anNvSk4rNVBoem1UM2JzRHNoK2dMTFU0cndKZG5J?=
 =?utf-8?Q?zG3jmwhNCPVO3xDqUrUdVRgCxBe7fXbIGxCMWF/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1703c612-e898-4e33-38b7-08d91f855ac4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 13:59:46.4870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkQituaUFpt8yCxfAffbab7aOqtAH1iXHuQFznC4umoGXnkdERWbV6lX9Xj/XwxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0695407416=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0695407416==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-05-23 1:10 p.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:091aaf6e-73f2-3ae1-e4cb-309732424150@gmail.com">Am
      21.05.21 um 21:28 schrieb philip yang:
      <br>
      <blockquote type="cite">
        <br>
        This simply the logic, several comments inline.
        <br>
        <br>
        Thanks,
        <br>
        <br>
        Philip
        <br>
        <br>
        On 2021-05-21 9:52 a.m., Christian König wrote:
        <br>
        <blockquote type="cite">Access to the mm_node is now forbidden.
          So instead of hand wiring that
          <br>
          use the cursor functionality.
          <br>
          <br>
          Signed-off-by: Christian König<a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 76
          +++---------------------
          <br>
          &nbsp; 1 file changed, 9 insertions(+), 67 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          index fd8f544f0de2..cb28d1e660af 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          @@ -29,6 +29,7 @@
          <br>
          &nbsp; #include &quot;amdgpu_object.h&quot;
          <br>
          &nbsp; #include &quot;amdgpu_vm.h&quot;
          <br>
          &nbsp; #include &quot;amdgpu_mn.h&quot;
          <br>
          +#include &quot;amdgpu_res_cursor.h&quot;
          <br>
          &nbsp; #include &quot;kfd_priv.h&quot;
          <br>
          &nbsp; #include &quot;kfd_svm.h&quot;
          <br>
          &nbsp; #include &quot;kfd_migrate.h&quot;
          <br>
          @@ -205,34 +206,6 @@ svm_migrate_copy_done(struct
          amdgpu_device *adev, struct dma_fence *mfence)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
          <br>
          &nbsp; }
          <br>
          &nbsp; -static uint64_t
          <br>
          -svm_migrate_node_physical_addr(struct amdgpu_device *adev,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node **mm_node, uint64_t
          *offset)
          <br>
          -{
          <br>
          -&nbsp;&nbsp;&nbsp; struct drm_mm_node *node = *mm_node;
          <br>
          -&nbsp;&nbsp;&nbsp; uint64_t pos = *offset;
          <br>
          -
          <br>
          -&nbsp;&nbsp;&nbsp; if (node-&gt;start == AMDGPU_BO_INVALID_OFFSET) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drm node is not validated\n&quot;);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
          <br>
          -&nbsp;&nbsp;&nbsp; }
          <br>
          -
          <br>
          -&nbsp;&nbsp;&nbsp; pr_debug(&quot;vram node start 0x%llx npages 0x%llx\n&quot;,
          node-&gt;start,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node-&gt;size);
          <br>
          -
          <br>
          -&nbsp;&nbsp;&nbsp; if (pos &gt;= node-&gt;size) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do&nbsp; {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos -= node-&gt;size;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node++;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (pos &gt;= node-&gt;size);
          <br>
          -
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mm_node = node;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset = pos;
          <br>
          -&nbsp;&nbsp;&nbsp; }
          <br>
          -
          <br>
          -&nbsp;&nbsp;&nbsp; return (node-&gt;start + pos) &lt;&lt; PAGE_SHIFT;
          <br>
          -}
          <br>
          -
          <br>
          &nbsp; unsigned long
          <br>
          &nbsp; svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned
          long addr)
          <br>
          &nbsp; {
          <br>
          @@ -297,11 +270,9 @@ svm_migrate_copy_to_vram(struct
          amdgpu_device *adev, struct svm_range *prange,
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;cpages;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;
          <br>
          -&nbsp;&nbsp;&nbsp; struct drm_mm_node *node;
          <br>
          +&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *src;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *dst;
          <br>
          -&nbsp;&nbsp;&nbsp; uint64_t vram_addr;
          <br>
          -&nbsp;&nbsp;&nbsp; uint64_t offset;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t i, j;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
          <br>
          &nbsp; @@ -317,19 +288,12 @@ svm_migrate_copy_to_vram(struct
          amdgpu_device *adev, struct svm_range *prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; node = prange-&gt;ttm_res-&gt;mm_node;
          <br>
          -&nbsp;&nbsp;&nbsp; offset = prange-&gt;offset;
          <br>
          -&nbsp;&nbsp;&nbsp; vram_addr = svm_migrate_node_physical_addr(adev,
          &amp;node, &amp;offset);
          <br>
          -&nbsp;&nbsp;&nbsp; if (!vram_addr) {
          <br>
        </blockquote>
        The prange-&gt;ttm_res valid check is not needed because we
        already check svm_range_vram_node_new return value
        <br>
        <blockquote type="cite">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(1, &quot;vram node address
          is 0\n&quot;);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ENOMEM;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
          <br>
          -&nbsp;&nbsp;&nbsp; }
          <br>
          -
          <br>
          +&nbsp;&nbsp;&nbsp; amdgpu_res_first(prange-&gt;ttm_res, prange-&gt;offset,
          npages &lt;&lt; PAGE_SHIFT,
          <br>
        </blockquote>
        <br>
        prange-&gt;offset&lt;&lt; PAGE_SHIFT
        <br>
        <br>
        amdgpu_res_first takes start and size in bytes,
        prange-&gt;offset use page aligned offset
        <br>
        <br>
      </blockquote>
      <br>
      Ah, yes good point.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;cursor);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages; i++) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = vram_addr + (j &lt;&lt; PAGE_SHIFT);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev,
          dst[i]);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
          migrate-&gt;dst[i]);
          <br>
          &nbsp; @@ -354,18 +318,10 @@ svm_migrate_copy_to_vram(struct
          amdgpu_device *adev, struct svm_range *prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset += j;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_addr = (node-&gt;start + offset)
          &lt;&lt; PAGE_SHIFT;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, j &lt;&lt;
          PAGE_SHIFT);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset++;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_addr += PAGE_SIZE;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (offset &gt;= node-&gt;size) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node++;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;next node size 0x%llx\n&quot;,
          node-&gt;size);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_addr = node-&gt;start &lt;&lt;
          PAGE_SHIFT;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset = 0;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, PAGE_SIZE);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          @@ -373,22 +329,8 @@ svm_migrate_copy_to_vram(struct
          amdgpu_device *adev, struct svm_range *prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;dma mapping src to 0x%llx, page_to_pfn
          0x%lx\n&quot;,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] &gt;&gt; PAGE_SHIFT,
          page_to_pfn(spage));
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j + offset &gt;= node-&gt;size - 1 &amp;&amp; i
          &lt; npages - 1) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src + i -
          j,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst + i - j, j + 1,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FROM_RAM_TO_VRAM,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;
          <br>
          -
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node++;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;next node size 0x%llx\n&quot;,
          node-&gt;size);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_addr = node-&gt;start &lt;&lt; PAGE_SHIFT;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset = 0;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j++;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, PAGE_SIZE);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j++;
          <br>
        </blockquote>
        Here to handle cross mm_node case.
        <br>
        <br>
        if (j &gt;= cursor-&gt;size - 1 &amp;&amp; i &lt; npages - 1) {
        <br>
        <br>
        &nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src + i - j,
        <br>
        <br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dst + i - j, j + 1,
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FROM_RAM_TO_VRAM,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;goto out_free_vram_pages;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j + 1) * PAGE_SIZE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; j= 0;
        <br>
        } else {
        <br>
        &nbsp;&nbsp;&nbsp; j++;
        <br>
        }
        <br>
      </blockquote>
      <br>
      Yeah, that was the point I couldn't understand. Why would we want
      that anyway?
      <br>
    </blockquote>
    <p>svm_migrate_copy_memory_gart uses sdma to copy from system memory
      to vram, system memory is gart mapping paged memory, and vram is
      direct mapping, physically continuous memory. We have to call
      svm_migrate_copy_memory_gart to setup new sdma for two cases:<br>
    </p>
    <p>1. system memory pages array, if src page is not
      MIGRATE_PFN_VALID</p>
    <p>2. if dst vram page cross mm_nodes, physical vram address is not
      continuous.<br>
    </p>
    <p>This if is for case 2. <br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:091aaf6e-73f2-3ae1-e4cb-309732424150@gmail.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src + i - j,
          dst + i - j, j,
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--===============0695407416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0695407416==--
