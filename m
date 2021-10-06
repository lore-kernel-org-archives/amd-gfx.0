Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1EEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 19:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C70261053
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 19:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C70261053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB406EE58;
	Wed,  6 Oct 2021 19:57:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CF16EE44
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 19:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUIwdH6npKGiskWPbtao9AlLyapPLi98zl9SorrgEsv+yoUPjCw5j9YZHr9Xm2K6phNMMJJnKtsnr+NmIUIkR5m/edbF1UkK2V2wmHxLqDOcPxaVZjodu1jmQiSafgnbeURQGkhu/vR+rT0R9h/joNarQwAovpSnlBrZucocy2r1C9i/lb8B/DeF2bQlvMF69cMaru8bmqHmIZI/S1sEc4g3YJe2t6FVePe4/OoAFHttVQ3eicaD/fUGYbRdnyUEFcw5by+/xm2w1pwWRzmbJ1L4iSqxG5tOHoDM4vRoeq15OLX6bCkMmaVzD4uRXgdiehtNSNm8xeydzuQ1p4KyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhLWVwQlgRwma87tX5NXm73l4DZZ2VSKWAFlIyV1n9o=;
 b=Ec45RklsamHDDkiy8bmdJbesSdd4CA6nzN9b8RRCZ3TYYgsyel3NCxfZggN6wbnMM/bb/pZE4v3UGTwT26BoNX9rntPfxqDgRgmgaZOh84eeE63TTU9m6wxlr7tAwvhbrivLqg/0CgobERGXqDEarA8dTvDWnevKk0twukokyzITd+LsKi9ZPKYZzGLFkIL3mhnRLs3BU48j6aN/0Ecf+r5wJ3F0oV9cuq0pmu/WNxNSeNUjn2mohMIleAPzOOVdCWvmgo7akqF1cFVin/JkVyQl5TFPTHhobFhUjDcIzGH2tnLJDM+gkAP/OBwx9aaYKJ/dy3VoarlwIdso62m8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhLWVwQlgRwma87tX5NXm73l4DZZ2VSKWAFlIyV1n9o=;
 b=YDHz8N/cwT7mRRPjE5dkNjYSHv2N8/5tagWP17A0OnvnnoBDmN1YpSpyla0UG/7PQ9M/IRMtoFlaMI10JzrxnswubA+EzDLFkUKCSCQVLDCCxTmbbhiFWO/bP3O7aK3ZV9nXszIfrxoDbob1vBxh48usdN7Na02iVfqxuZQPOgA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 6 Oct
 2021 19:57:53 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 19:57:53 +0000
Subject: Re: [PATCH 3/4] drm/amdkfd: avoid svm conflicting with userptr address
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211006143210.4954-1-Philip.Yang@amd.com>
 <20211006143210.4954-3-Philip.Yang@amd.com>
 <5fb56030-ac37-3162-48b7-41cd70c08f0f@amd.com>
 <7fc4e4e8-a649-0032-b3cb-e575b5c4d8c8@amd.com>
 <bdbaf7d9-4c5e-4fad-6638-0be9d9861a56@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <4c442f71-53b9-1d8c-d7bb-6ee979bad617@amd.com>
Date: Wed, 6 Oct 2021 15:57:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <bdbaf7d9-4c5e-4fad-6638-0be9d9861a56@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Wed, 6 Oct 2021 19:57:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d249993-7a34-41bc-97f6-08d989039547
X-MS-TrafficTypeDiagnostic: DM4PR12MB5245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52450FF0B76FD32E684D28B4E6B09@DM4PR12MB5245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iF5wCWp8bRaux52DythscjZeBEYf+m9pKqO6lTUCe4NZ9VF2IUJjrfQVs7tqYBhSpsQzARyOpoAbZ6m3hXeXmBY2pHkFpzwwBmDGadTkYVaRnurAQIbPifSwvNyBh2Jc8QHGCVhV3rVzBlSSWPsd0jt3r1cBG68Hw7ZGn5SuNzen7EjPbufP7pCHssmr6nt8ER+bjkItNk4g9ooYg56UewjLELLs4Kt6yx/AZJcuQRcOkAa33X+aYtRyY5eDNY6aJNxw7genSpGFc+Mjv+plzAiZD+EM0HM2D4uex0d7iwgeQtnBebW4bT38QIos5AtdEwGHCwPDvatuMlrdFEIid9L4lIBsNMCPu8e9jaKmfVw8Elvi1DHo2s4Z/7DHLj40nFBO63sMlODrzDbivtQ+V1BPEZcJ8Jz+zIGbkB9QFHrKAdXMBOHMAIjwk2bjEnPy7a0PfuocMMcwROtbPhLG2Xl19enPj0g/+3uuLp5eft3mS2QyFPyMctJXCXgzYjxDIKCIWI0hON65yQvVXGgR1W3i7QjzfasXEf7JZ1j9uxX0beVYj92X+U4kPMUZQfNElOozT2j+hWDUuON58OMcSJUcHz3eRLjggo6fAi5OkH5nI4Ji+4CzKdRuiQCI6HMkE9BArYJa6wqav9brDu+BQe/OrWLrWW/55+Yv5XYm10AxBDQ3QUXX41voLJ6ZSYIIq/8GlEJ1K9WyhoxL6/KE+2j4NPLIaDiJ6yHMHLuUbVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(316002)(956004)(26005)(8676002)(8936002)(6486002)(5660300002)(83380400001)(53546011)(508600001)(66556008)(66476007)(31696002)(38100700002)(2906002)(36756003)(110136005)(66946007)(2616005)(16576012)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlRVnluSmRQWHBFSU5DVkdhdkxCQ2VQSWxaV3ZiUHR0dEtKcVZuNzQ2T2h6?=
 =?utf-8?B?WVRia0QyR0dXRFR2TktFbHJyVkNCbjFWakxCWWxnL2Y0TlpJZTk5VWNBSHRF?=
 =?utf-8?B?aDlKaTdhMFkvOUtQWC9OT3pOOEk3K01HWS91eEJuTXl0S1Nabi80UXlCUDlJ?=
 =?utf-8?B?NDNBSlYyeHI5ejRXOUZXb2NucDl5cEU1Q3YxQXFJK0U5ajVIMzNkQUt1aXNi?=
 =?utf-8?B?dlNZUHQvUjQraTFHZEF1ZjVNNVBSeU9adkRMNDdsOENKRktid1ZUNFQ1NHh0?=
 =?utf-8?B?MXI4MGFmUmRBbjkyZHB6cW1jNDZFaGdid0U0SFZBbmdNd1gxcHF2SXlFeVlG?=
 =?utf-8?B?cEhxUXV4V2p5S0FNTVRGQk1XU0xhNEoyaE1sNE8vVHloRHovZjBIbWdydGtH?=
 =?utf-8?B?TzJ0YlduYXZBOUsvMzFVUGk0K25hcndCYUx2dXN0d1FNMkRDK1BDV2s3cmlE?=
 =?utf-8?B?bHBMZUlGeUc3R2VPcFFlY3YxcWt0TU5nVUZsRG9TRHgvNXRpaVpUWVU3Tk5m?=
 =?utf-8?B?ZmlZYTJPQ2pMMmh5K1pmcytKWnN4YU5IWk5GU3Fsd3JGcWhTbmhKdlRySjBT?=
 =?utf-8?B?OVgvYjQvaXhNUjg5Ylc2RU9NYWFQanBoWkYrUEU4aHorM0x1MkJTRXNlNlhz?=
 =?utf-8?B?ZzAwZ2VHVHFUWmFDOHpxaHpTcVRlbjRQM0J2KzlmTTdFTVY4dUs4MXh3dHUx?=
 =?utf-8?B?NFpvOURxZThBUTBFUWw2dXlTYkx1RUozYU1xVmQranQwcHE4ellsUlpCOFhE?=
 =?utf-8?B?MjlVZDFrbTN3L1lveDJaZHkyVXRmbU5EdzB5R1RzN0lNaFZpZ3hSTVpsSVM2?=
 =?utf-8?B?VnNRbGFmUTJ0YlpDTGZyMXEvNjNwNkhWS1UwM2l6dERXaHVEVGtWcXRhdXN0?=
 =?utf-8?B?MmF6L1pmU3JPd0oxYVJqNG13Q042Wk5aMzVIVVhtTXVMRWZDTXpkQXo0N2Nh?=
 =?utf-8?B?dlVJRFZUczBaTkp6RHZwbHA3V2F4SVRDellpU041b3gwUmhDM2RtUFEyRXo3?=
 =?utf-8?B?bVZUSW83cTJXR3dHZ0VEbThjQUIzQlBmRE83b2dySm85R3dXTGVKOC94SURl?=
 =?utf-8?B?NnRlbXRUV2hQZUhSTXUrOW1zbER5REJtS2VjOWVhS3VYOE5KZTFNdnFaajBo?=
 =?utf-8?B?MEZONDM5NWZTeHNVR3VodE9jbUR6Nkp6TUxMY2ZjZmVldXJGYkV0WkhzOEVC?=
 =?utf-8?B?Y3RXSW1uSmJiUC9OY281dmJ1OWNON1pTY1ZQQjRCdUI5YjhCWGpYcXhtUjhF?=
 =?utf-8?B?UHpHZUptRGRJb0F0a20zb2N4WElpM3NaOVlVNnhwdWk0TVNoTW9iOHpDU0Vl?=
 =?utf-8?B?dnVSRndIMmZLY05aUGFwWTgvcHZrQnRPd1VoN2p6UnJVSWk0WUliemZpOVFn?=
 =?utf-8?B?Y1pJbHV3LzdlR0tVVHNLNXp2RzdsaktQaXN6c3pxM0ZEVHhXMDZNWlQ5QUgv?=
 =?utf-8?B?QmlZQklOT1lCbWt5WDdFK2t3UjhxRmNuYThXSFVMcjRjWU9ZMzlITWV5VkJV?=
 =?utf-8?B?WGN2d0d6emdUUzhBTzBodEQ2ZVIyQ1YyZkpjbXFNV1p1YkdqRWNhVE9wSTBa?=
 =?utf-8?B?bnE5dVVwZjdzUmJHUEo4TmUwNEE2VUc5bUpqNFgxcWhacHNweXk0RU10TVFJ?=
 =?utf-8?B?ZUltdzQ0S2ZDejRPc2VEbk9lU0ZrelMrRUdvSkhPUmk0NWZYM0xpVjlxMUxD?=
 =?utf-8?B?WWNjTEpjWWVtR0VpYWZ6SHNETGdxYVJCR0syakROczFCQ0FkQk1xeTN4N3Ev?=
 =?utf-8?Q?O3+nFKKCUq9tE2bXOJgxVwtRWyDGN1lAReq3yZ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d249993-7a34-41bc-97f6-08d989039547
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 19:57:53.3643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3O/+bXwj1jdRGo5pFRgJb/xkI6/H+fkhM8tV/ky/QAdmO7BYHfC37eghP9XM+EHy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-10-06 2:23 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:bdbaf7d9-4c5e-4fad-6638-0be9d9861a56@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-10-06 um 2:09 p.m. schrieb philip yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 2021-10-06 1:22 p.m., Felix Kuehling wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Am 2021-10-06 um 10:32 a.m. schrieb Philip Yang:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">For ioctl_alloc_memory_of_gpu to alloc userptr bo, check userptr address
does not exist in svm-&gt;objects.

For svm range allocation, look for address in the userptr range of
interval tree VA nodes.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Why? The purpose of the check is to prevent the same GPU virtual address
being managed by the two different memory managers. So checking
args-&gt;va_addr should be correct even for userptr BOs. The CPU virtual
address should be OK to be mapped with userptr and SVM at the same time
as long as the userptr uses a distinct GPU virtual address.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
userptr cpu virtual address is registered to MMU notifier, if svm
range overlap with userptr, then migration svm range triggers mmu
notifier to evict userptr and evict user queues, for xnack on, this is
not correct. And restore userptr will fail if svm range is migrated to
vram because hmm_range_fault failed to get system pages, app will soft
hang as queues are not restored.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">OK. Then we need to check both the CPU and GPU virtual address ranges.
Having userptr or SVM registrations fail like that is not ideal. It only
changes the failure mode, but doesn't really fix applications affected
by this.

A real solution probably requires, that we reimplement userptrs using
the SVM API in the Thunk, when SVM is available. That way you avoid this
conflict between the two memory managers.
</pre>
    </blockquote>
    <p>I only find issue in patch 4/4, this is not real app issue right
      now, but I realize this could happen, just want to prevent this
      case. It is good idea to use svm path for userptr if svm is
      supported. I will drop this patch, and resend v2 for patch 4/4.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:bdbaf7d9-4c5e-4fad-6638-0be9d9861a56@amd.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Regards,

Philip

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Regards,
&nbsp; Felix


</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Change helper svm_range_check_vm to return amdgpu_bo, which will be used
to avoid creating new svm range overlap with bo later.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 55 +++++++++++++++++++-----
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f1e7edeb4e6b..34dfa6a938bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1255,6 +1255,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	long err;
 	uint64_t offset = args-&gt;mmap_offset;
 	uint32_t flags = args-&gt;flags;
+	unsigned long start, last;
 
 	if (args-&gt;size == 0)
 		return -EINVAL;
@@ -1266,11 +1267,17 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	svm_range_list_lock_and_flush_work(&amp;p-&gt;svms, current-&gt;mm);
 	mutex_lock(&amp;p-&gt;svms.lock);
 	mmap_write_unlock(current-&gt;mm);
-	if (interval_tree_iter_first(&amp;p-&gt;svms.objects,
-				     args-&gt;va_addr &gt;&gt; PAGE_SHIFT,
-				     (args-&gt;va_addr + args-&gt;size - 1) &gt;&gt; PAGE_SHIFT)) {
-		pr_err(&quot;Address: 0x%llx already allocated by SVM\n&quot;,
-			args-&gt;va_addr);
+
+	if (flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+		start = args-&gt;mmap_offset &gt;&gt; PAGE_SHIFT;
+		last = (args-&gt;mmap_offset + args-&gt;size - 1) &gt;&gt; PAGE_SHIFT;
+	} else {
+		start = args-&gt;va_addr &gt;&gt; PAGE_SHIFT;
+		last = (args-&gt;va_addr + args-&gt;size - 1) &gt;&gt; PAGE_SHIFT;
+	}
+
+	if (interval_tree_iter_first(&amp;p-&gt;svms.objects, start, last)) {
+		pr_err(&quot;[0x%lx 0x%lx] already allocated by SVM\n&quot;, start, last);
 		mutex_unlock(&amp;p-&gt;svms.lock);
 		return -EADDRINUSE;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7f0743fcfcc3..d49c08618714 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2679,15 +2679,18 @@ int svm_range_list_init(struct kfd_process *p)
  *
  * Context: Process context
  *
- * Return 0 - OK, if the range is not mapped.
+ * Return NULL - if the range is not mapped.
+ * amdgpu_bo - if the range is mapped by old API
  * Otherwise error code:
- * -EADDRINUSE - if address is mapped already by kfd_ioctl_alloc_memory_of_gpu
  * -ERESTARTSYS - A wait for the buffer to become unreserved was interrupted by
  * a signal. Release all buffer reservations and return to user-space.
  */
-static int
+static struct amdgpu_bo *
 svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
 {
+	struct amdgpu_bo_va_mapping *mapping;
+	struct interval_tree_node *node;
+	struct amdgpu_bo *bo = NULL;
 	uint32_t i;
 	int r;
 
@@ -2700,16 +2703,42 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
 		vm = drm_priv_to_vm(p-&gt;pdds[i]-&gt;drm_priv);
 		r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
 		if (r)
-			return r;
-		if (interval_tree_iter_first(&amp;vm-&gt;va, start, last)) {
-			pr_debug(&quot;Range [0x%llx 0x%llx] already mapped\n&quot;, start, last);
-			amdgpu_bo_unreserve(vm-&gt;root.bo);
-			return -EADDRINUSE;
+			return ERR_PTR(r);
+		node = interval_tree_iter_first(&amp;vm-&gt;va, start, last);
+		if (node) {
+			pr_debug(&quot;range [0x%llx 0x%llx] already TTM mapped\n&quot;,
+				 start, last);
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			bo = mapping-&gt;bo_va-&gt;base.bo;
+			goto out_unreserve;
+		}
+
+		/* Check userptr by searching entire vm-&gt;va interval tree */
+		node = interval_tree_iter_first(&amp;vm-&gt;va, 0, ~0ULL);
+		while (node) {
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			bo = mapping-&gt;bo_va-&gt;base.bo;
+
+			if (amdgpu_ttm_tt_affect_userptr(bo-&gt;tbo.ttm,
+							 start &lt;&lt; PAGE_SHIFT,
+							 last &lt;&lt; PAGE_SHIFT)) {
+				pr_debug(&quot;[0x%llx 0x%llx] userptr mapped\n&quot;,
+					 start, last);
+				goto out_unreserve;
+			}
+			bo = NULL;
+			node = interval_tree_iter_next(node, 0, ~0ULL);
 		}
+
+out_unreserve:
 		amdgpu_bo_unreserve(vm-&gt;root.bo);
+		if (bo)
+			break;
 	}
 
-	return 0;
+	return bo;
 }
 
 /**
@@ -2732,6 +2761,7 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 	struct vm_area_struct *vma;
 	unsigned long end;
 	unsigned long start_unchg = start;
+	struct amdgpu_bo *bo;
 
 	start &lt;&lt;= PAGE_SHIFT;
 	end = start + (size &lt;&lt; PAGE_SHIFT);
@@ -2743,7 +2773,12 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 		start = min(end, vma-&gt;vm_end);
 	} while (start &lt; end);
 
-	return svm_range_check_vm(p, start_unchg, (end - 1) &gt;&gt; PAGE_SHIFT);
+	bo = svm_range_check_vm(p, start_unchg, (end - 1) &gt;&gt; PAGE_SHIFT);
+	if (IS_ERR(bo))
+		return PTR_ERR(bo);
+	if (bo)
+		return -EADDRINUSE;
+	return 0;
 }
 
 /**
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
