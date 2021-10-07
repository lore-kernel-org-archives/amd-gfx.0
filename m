Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C40C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 21:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381E660F51
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 21:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 381E660F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B976F4E6;
	Thu,  7 Oct 2021 21:48:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5917B6F4E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 21:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIuR27yMEpHqxcEfHZaD41CXsMe11oEUAHVUiLrq9QZl25NGdy0TABLRahFXzqMMVfX/3eQG8Egji/Ockb9s8PI+eDPOtTQk8m2peEA5tLclH9QaWbwa+9SGcIl1megUrNdWxkmsF3GwpuUTktVCpyoyhhYgA8AXTiW+DFJkSmJfucCjy6aFUgU7ZYXPLnMztXWIYSR+fVaPZfGfyhb0ctDC4dET8Qam+pGrw7zwkyxFmAZGSH7DkDyJ7f80t6qfPzzaNphsoGpJADBkF2HcNjsLZBK1++STp6iFO7Ze7WQrOQMbegTKlESg84MwrUV/0viaPzv/4MZ+tgsz8z3qNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5DxU7cYwFPkQ/pinkg9FCzQpI4eBHnrJ8je8S2TTgU=;
 b=OIIIPue0HJ4b0OCcW8cghRUIG7RbFTb7BFt3xn5yc2S8VeL2WHGI1oQn68MsvdfVJEOIUKs3osMkySazd1DQhUIjBbSdFrUIimUQiMt81fpYx/XMtsBA7BbRsZ9BRaFbOxNtbpMrMRr1SuRWabZ7nM5N6Ckez3mtwYDGnBaauYll3eLRYHtbHjHLa5/Mx280MurBLzMwqHmgtEi+ZYNf79FR2LUcIjlBKX5NFOWG6TzBn0jk10bmWuaJ6HmNf6tcYBF0bAUohOBlnRjrT/J6SrAw6KPjsWA/NzJjrJlbjC6YjqqgpEIfqZcGyVDcA2qvNIE8A3441012UncypGyqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5DxU7cYwFPkQ/pinkg9FCzQpI4eBHnrJ8je8S2TTgU=;
 b=MdssTvqvsdsurnxpiJc+Y+YOkM/6htQ36/g68M2pURsvCYlc94sb13Qn8LeCiWDCSEW7/r+atVemOiwd0rLl9rR2nt2cPBMXWq+N+WFH3NSgdry4YLJ4USz279Sjnlovu63rYuiueYgQnOxweW9Y5CATm0bE4MzDg6Jk8fFBZGs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 21:48:29 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 21:48:29 +0000
Subject: Re: [PATCH] drm/amdkfd: rm BO resv on validation to avoid deadlock
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
References: <20211007214348.18726-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <8383526f-841d-ef60-f526-6f0a5108e5a8@amd.com>
Date: Thu, 7 Oct 2021 17:48:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211007214348.18726-1-alex.sierra@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19 via Frontend Transport; Thu, 7 Oct 2021 21:48:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b306fd89-6265-4a20-2c4d-08d989dc3310
X-MS-TrafficTypeDiagnostic: DM4PR12MB5183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5183210326E7E1B8048A2E22E6B19@DM4PR12MB5183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nl2TiQ7oXgN3wpJdC5fW4QGfiVDnBJJCkjweAAZPeR2PWB6gn7IGgzbEOzvz2PhYKaR9Y7c558qdZVurddfXbsyivxQ859WNs3PJw2sLJhzCNa9rF34v2/kBjChJkFgk4inBTVRg06h2xcEJWAxiNUATipAPPK6goDdcL0a3sqxNqHgsYVCzrmOmN3MBpw1dhCpadgNm2L6nHDTk7gaPReMK6vHrYbbXgeMpRNxSWNE3l3YVMy8/4nT0tpnWlM9CMlcBxZtBOegF6oPU08udCXboKqAy4ioCe9xgosetM9pwpkpNANXzyBQx9p+8T3MduUb8b6XI8HQH11CU8Cej1v85B43E4V8Gp42MWeJlRBnZblsmncb51yXou/sQBoQGgwWv69Q90MzRi7wixUfWXjoBvUtYN8QM5+O5PkHEzTuh77/eAUTfsHlTQ4I02FWtGVGVyqXMbwcv1lvrWEi+rDYrpC+ixsMvnFMrrjU7pgNQMBn4Fw3e7XlmpXzT0u1rMoM8P51GBaz926/ktHS+s17W9DAgeSaHUnQdLaHJzwMbIzGz2jlkRC5MgGvWBmDh9KVv/yWjmUMacwZhsogf9QSh+fDQFhgvS5OgAczvtW6THR4DDJKld4qcrEJqWSFh2eCwG/14hiOLUltddGimzbAPCd24lSL3rgVMbPpX8sUQLhWbgjrlrvX+WC3wjZQmzIB5uxcM/G5YD7YbFNgDnO0oe51nLQBiMs8oNRJ4ljY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(8936002)(66476007)(316002)(26005)(186003)(53546011)(38100700002)(6486002)(4326008)(66946007)(31686004)(2906002)(508600001)(2616005)(31696002)(5660300002)(8676002)(16576012)(83380400001)(956004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEMzOUdubW1nZUdYQmpacm5ycThRTVY5YktxNU5va1ZJTGN1SjdwODRmSm5x?=
 =?utf-8?B?NU05RzVpSlg2VDBBZ285am43VzRjbk93YXRWTVFvQ2Nkak1QOVdZRkdkZWo2?=
 =?utf-8?B?RWw1ZXhDMW1aZE9ycFNHWGs1MDVRbzNXdW1RUVBVSTFOS2cwM1oydlJSYUR0?=
 =?utf-8?B?NHJOZ0E1Yi9ack5nZVVxNTR4cXlWMHNYTzFMT1ptRkdYSnZTRGkydUU0MTV5?=
 =?utf-8?B?MCtkTDRQeHdFcDJVNGs4dUg0T2JoMHVCMXlkWFhVSHVXWjB4WEhvMjN5RW5z?=
 =?utf-8?B?aDhLRkhSdWJPQnc4RHIyMTllRm5HVXFaTGs4bUdpYlc3M1ZmWm9rVFVmMm5v?=
 =?utf-8?B?djhLemRzSUk0QVprRElXYXNsdDVLQWZyRVJoS29BRDRkMFJpSkpocGo3a3BW?=
 =?utf-8?B?a0YxZWFuMDlOaTNQSFJDQzZlbVRGbDJ2MjRUZTNoWUtZT20yL3RmdWVlUlA1?=
 =?utf-8?B?WGYrTkdHaE5WdGFoS0l5WmZ0MGFkYkphYVVkQUxLdWdGRDM3SWpCb285dm9j?=
 =?utf-8?B?YTRXWmthSEo5SytGRTZFQnc2VTFpaWdMc0dYZi9RQkVOMFJmVGt0WjhCbE5P?=
 =?utf-8?B?TVV2UDN0dFAxYU9mWEJJdzNocUtjSGgzbFVZZC9yVno5WnltdEZTL3ZIVjl2?=
 =?utf-8?B?cjFwZFd1S2YyRWIzMkE4eEVldW5MMWNQSzI5VC9QeC9IWDNhZkxVM3ZIRUNE?=
 =?utf-8?B?VUpCVUdYR3hId0Q4dWFBNDZpeDFlakJsdmdvN1Q5TEFQRGZ4NHNtWlRhNmZp?=
 =?utf-8?B?VVF4L0NQWjJsTC9GdERRWld0SnNjcUhSVFh4czNjRHd6bDZKVVhFQTdHNFFv?=
 =?utf-8?B?T0wxZmw5UjVuNTlsZkxkbWpTQ2s3bWYrdmlsekIrc052KzlqMDBicFNIYmM2?=
 =?utf-8?B?L0thRHI4YWVTUjlLTkkreFFmNTBYZ1hINnEvdUxyUTJEaTlncVFyNkF1VUlw?=
 =?utf-8?B?WjU4MkxYQU8zdGs2cm00bmx6SkVtY2pZdENVOHlGYWNiUzIwT3VFZ2xwUm9D?=
 =?utf-8?B?L09KZmR2WU5LNDFqNU5qUkhwb1B6dG9hLzhjalBGU0g0UmVJWXEvSjFBcUFU?=
 =?utf-8?B?TXZTa0dwWWtqNHdEcUtTSmpaOW1hZ1h5ZzN4QXhUM2lzVW1tODdQYjErMDBu?=
 =?utf-8?B?TGIrNCt6bCtGOWRESDcxMjlSRDdMUVBiUW0yenhpSEgvVGlFakQ1RGVlSHor?=
 =?utf-8?B?eXdSaW9xaDhXKzFsd243N25EbzB4UkZhSlhTYWJoSlFQU1luem1GWkVZVnVu?=
 =?utf-8?B?S1hTbWFTMUhqWElZdXlKaStqRHVPNm1uL3VtQklaNDY1NTQ1VTlaeUZkdnFM?=
 =?utf-8?B?YVdxMjYzcHJHUlBlei9zOGZ6VmtXaWNmODdpeFVRNTN4VS9tcDRvVG8rbkNr?=
 =?utf-8?B?TlBRMHdDNnBYVmh3cXY4SjBpU3RDZ001R3pjU1BvY3lES3o0OFhjdmVVMnhF?=
 =?utf-8?B?alR2WUVodmNpVURnVmhaMW4zS3RwRzJ6Qkl3M2FVWXRsSC9tanNpRkQvY0VO?=
 =?utf-8?B?ZU1XeVpjNkx0R2RCNVYxMjJwWjIwOGJScFo4L2dJTFc0VWFEWXRYQ0RiWWU1?=
 =?utf-8?B?RDY2dUxYQTdpTEw0Y2lwaXp0aXh2aFZCQ0NwZmM0OUpNTlNUZnB6T2FFaWV6?=
 =?utf-8?B?Yk13eS9LVUVrcWZyMStKK2FFNytCNTY4Vmx5M2dZa2M2MWlDekg4SW1ZMFJC?=
 =?utf-8?B?dXpPK28zSVVQeFVLamhBejAzaGRNWnVRYU5nZ2JPUmlnbkNaaWhxTW5oRFdu?=
 =?utf-8?Q?x9d2yCSw89jFAml75kF4KkU2i017pzpDoKNiBNk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b306fd89-6265-4a20-2c4d-08d989dc3310
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:48:29.3538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+OWOd0WkCY+2KhzQ44vE3C7WBdvSzYgCvOxqKPv4l2CjzIi/DOVEetNre7DkXU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
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
    <div class="moz-cite-prefix">On 2021-10-07 5:43 p.m., Alex Sierra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211007214348.18726-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">This fix the deadlock with the BO reservations during SVM_BO evictions
while allocations in VRAM are concurrently performed. More specific,
while the ttm waits for the fence to be signaled (ttm_bo_wait), it
already has the BO reserved. In parallel, the restore worker might be
running, prefetching memory to VRAM. This also requires to reserve the
BO, but blocks the mmap semaphore first. The deadlock happens when the
SVM_BO eviction worker kicks in and waits for the mmap semaphore held
in restore worker. Preventing signal the fence back, causing the
deadlock until the ttm times out.

We don't need to hold the BO reservation anymore during validation
and mapping. Now the physical addresses are taken from hmm_range_fault.
We also take migrate_mutex to prevent range migration while
validate_and_map update GPU page table.</pre>
    </blockquote>
    <br>
    <pre class="moz-quote-pre" wrap="">Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a></pre>
    <blockquote type="cite" cite="mid:20211007214348.18726-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c4de7ce2f21c..8db60b06b0e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1299,7 +1299,7 @@ struct svm_validate_context {
 	struct svm_range *prange;
 	bool intr;
 	unsigned long bitmap[MAX_GPU_INSTANCE];
-	struct ttm_validate_buffer tv[MAX_GPU_INSTANCE+1];
+	struct ttm_validate_buffer tv[MAX_GPU_INSTANCE];
 	struct list_head validate_list;
 	struct ww_acquire_ctx ticket;
 };
@@ -1326,11 +1326,6 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
 		ctx-&gt;tv[gpuidx].num_shared = 4;
 		list_add(&amp;ctx-&gt;tv[gpuidx].head, &amp;ctx-&gt;validate_list);
 	}
-	if (ctx-&gt;prange-&gt;svm_bo &amp;&amp; ctx-&gt;prange-&gt;ttm_res) {
-		ctx-&gt;tv[MAX_GPU_INSTANCE].bo = &amp;ctx-&gt;prange-&gt;svm_bo-&gt;bo-&gt;tbo;
-		ctx-&gt;tv[MAX_GPU_INSTANCE].num_shared = 1;
-		list_add(&amp;ctx-&gt;tv[MAX_GPU_INSTANCE].head, &amp;ctx-&gt;validate_list);
-	}
 
 	r = ttm_eu_reserve_buffers(&amp;ctx-&gt;ticket, &amp;ctx-&gt;validate_list,
 				   ctx-&gt;intr, NULL);
</pre>
    </blockquote>
  </body>
</html>
