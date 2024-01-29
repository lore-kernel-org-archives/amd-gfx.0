Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C13C47DDB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 16:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B6610EF42;
	Mon, 29 Jan 2024 16:25:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09BC10F090
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 16:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hISqUcdMZUpcHzwvoAOClf3oR3GKJkAw0s3JTykqLaHT4UpdFiSiryGyy6db/0Oe0KZmQw3agY+HSNV1N8wzqA+P5cJgDnjy+0kXW/PNxwo7yhHpFUjrnaLCAVuGxuhEztmzrLmeeSumEe3Z/aV6OyQ5ElcEZ7iHdh7kZdTYQrAAc4TDYGTsovUWtUvUsFqeLRRftfwgDkvaWidtSo7S6HFAGPT2LAfIHXQpyI5YiNX6bfJRTpLUDz598ToSGF4ZWlOPUr6SZ81zhVgL2Q2wcfgGcW5b8ctTmfyHg1WV4AXT3gwj9HgJ3O6AxQqAMNbZve3LAhGUj1QIhuQH/aKA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg3kkY9Tzd1gi66qaEmMPqk8c09e3YxZlY6moKnfOow=;
 b=bT72l22YNvKPV/HLY2/FqCIKcB+uTOpJ+HluTXueMupdOhc550KQGypRaEYkFSKo8PV7enPYOV8/7dn0xkfwXG+nDQzvX2kRkGrDjAzaVJlVns2PPhU0NJiYKbOUfBIiOnnVOwp/1Y/HCJ+30iUB77gfab0oNErPqq2AzFaUqlBPM2tvzRXI56WmE+2d1l5y1fwa+GthnjooCI9Z1lhsGySKeMozJeFl3vj0Kll1xUx8f3XzEp6NzzTojGCNodVJX2JRdOMq21vAGpNopINNk7Z7Fbcm+RppUjAzuYObap/hwN+bqMQuarVJD7//9gAvrypG42SRgAjn57+uhz3UHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg3kkY9Tzd1gi66qaEmMPqk8c09e3YxZlY6moKnfOow=;
 b=gR5leQ7cfhUuTbcATqRxjeXWftph4yMucwkfVmhtMCNM31hBLvmlnuWPn6p31jWAWa/DxQ+wlGt55zGIv5uipiVpe/9o/IejkwJvPepfpNeZynyDSoG4bwI3WX2XrAv9WQkF3UvkXEeS/ZuHmy+MVnSzLqB4XtVrHVOUTzsT4V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:25:11 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:25:11 +0000
Message-ID: <43f6a455-4256-bfbb-f4ca-84e46440e5eb@amd.com>
Date: Mon, 29 Jan 2024 11:25:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Support >=4GB GTT memory mapping
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240126194721.18853-1-Philip.Yang@amd.com>
 <e128767a-9980-4892-a8bc-9acc206dd84e@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <e128767a-9980-4892-a8bc-9acc206dd84e@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: d50d6799-fe15-4bf2-a87c-08dc20e6dd68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CDx3hrlqgkJ7OPrBGJs0DKmcMDqiSvWHyy4WNDj9jhtMD+GBIcPyZefMNcQmuE/moUEEVzmyv5ZvdBrLwh16wgArnR109aMLR7juIn3VasOQBCXk7PyLQP1un55HXZ7aJwdLUOp04oUaJVgoMlB5/mwO4LNJTWT02PcnXT8n66p3t5J3cfg4OlpQJt2/wiPmz7F6Ltf2R1FKxb62DdEWfyHiIPJSz5mXUZwP4+2j8/6LvsNh0BtRSYQbkvcW8PqMpjs/xH+9YhTB+D9Ymgd1rBSAV3OOoZ0G/oFrIqIoYNlxW7J+JRdlkMoIirQH+y7jUu/GwGahhtGSke2ClQKu2w1oG5JyDRL+bZ/KqBfHf5ELk6FuFAJRkzPQSb+9STiQTjBUuHjVcV4rC6F9B+7pfHnllIXhKPLUuZv1NJzt8X7iEUcESkYPoP9VYUgxpTcfZq64YGJzwk8yHjES0eU6Zh+kmE764/qb4v6CVilR9G2JC2T85WVBQg55gjpXPl4dDe5TRrOFn9YJBcRRlqNt55u0f9rj0tdtcqtZXi7sm5CceSnrQJ2+sDWpmSfbxZkJzwqguSOKrIzP+mbtkGn78sAnLDZ5ee+oZhGboxsg4mLqR0IAQuvvq1yGLkuhSEDeSDOe5oBGd/I1Uj1RaAVrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(31686004)(38100700002)(66556008)(110136005)(6506007)(316002)(53546011)(66946007)(66476007)(6486002)(8676002)(8936002)(66574015)(2616005)(5660300002)(6512007)(26005)(478600001)(2906002)(4326008)(31696002)(83380400001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5YRVY4QlhWbXkyKzJkNG0yZ0cyeXJ6bitkUWxDK1pyNDN0OGgwZmZ0OENr?=
 =?utf-8?B?d1JsODRQMGdNaDU0WWV4YmNGQlVzN3krRkR2cy9pREJYY0owNjhoTWZlRit1?=
 =?utf-8?B?S2lCOXVuNHVyN0UySkYwMGVUS3UrTTQ0UldJNkdwV1QzRWUwenNsRzdjRVZw?=
 =?utf-8?B?dDB5MU5YNUR2bUtMdU5OQ050amtTUmlrNVJyVXdCemtFQzlaOVlDRFZsaG1a?=
 =?utf-8?B?empyWGxTWDhFMTByTm8rRXczU1dleVMzNGtOeHphYk1QejNBOUFiQU5McTBH?=
 =?utf-8?B?ZkhUcXNHeWtrb1NUdzVQYWRkVjhqZzFJNlFqZm9sQ3pPZmxzVzViMWwzaHJU?=
 =?utf-8?B?elB6WDFiK0dmd1F6K2UrRHR6elVtNy85dUNxNFhON3hmbHgzUU40NVIySjA3?=
 =?utf-8?B?cG5BV25NbURxSkVJdVRDbWNOTDhhdzdsNXh5bnNic3hUVXZ6anBZeXp1QVNL?=
 =?utf-8?B?d1Y3N003NnBUWW1GM1p0T3h1SlNuVWN2cFFvUHoyUFNxQWdmWEtrbkJsYnBP?=
 =?utf-8?B?c0NackFUNXBRSFpaZkY4NE5mRnFaUkFOTzJnbHBSQ096dXhJTEVCNGxtTitR?=
 =?utf-8?B?U0diY1p6eHVZWUJXQjBsTkI1dEc1REZtY2k4SHFBQ2FXWlFaTURuUDR3dE1N?=
 =?utf-8?B?Nm9jaEJqbVNuc3VzR0FGc2diRVFSM0dqQ1VpYXdvR3l2UjNiUTVZUzdtQk5H?=
 =?utf-8?B?eFpUaUxtSWlWeWRjbCtKUVFjc0FQK0RRaTBHaTRvS2IxcnVkcEVLRll4TEt4?=
 =?utf-8?B?dmc3ZWRoZzhnOTJJbU40aXdKVDVRczd6cjFPd1c4L2dCQk5jckI1TnZwR3g3?=
 =?utf-8?B?d3c1a2UybjMxcUlmd0I2cmlldlcvM2x2bHpWVFZ1ZUcwaDNUOUl3VkZIOE03?=
 =?utf-8?B?VXRNVzdLQkxYZUVTTmxHMzhIbFhxVXdVT3p0S0t3eHVVQ0NNVUtzQ1M1ZGdL?=
 =?utf-8?B?dVkwQURmL3llbnB0aXRiRU5Gd3RvdkhJWkZqSXZSQnM5c1lkeU5UMzBtc21J?=
 =?utf-8?B?SWVCWlArYmkvQkt1dVc5dnQwMEJrZkhrU3BuZXdJVzNXUHNuR1F3UGFJSHRT?=
 =?utf-8?B?aFMrTUJDMHJHbG9tcUdBY2hrR2NHS1lGMFRKTHZKUWhFc1JQNW5nWmJJeTND?=
 =?utf-8?B?UERzMkFHcTNKcXdSRjVSaTVmK1JuZzZFYkxxTjYvYkt4UUVFd2ZYNTQ3anBF?=
 =?utf-8?B?RldScUlMTDVsbzFCUmdCYVZjSTFScitkNmcrY2l2YWlTbi84M2ZDcHpQK2p4?=
 =?utf-8?B?ZXNodzNPQThqVzJoUDg5T0NVRzNIcWkvaGFWQTVaM3hsbW5UajhQaDlvaGho?=
 =?utf-8?B?OHFHVExWMUFqZDk0aU45NUFNYzhYaU90R3ZTRjdiSkxoWENPZEIzNmlBVHJ0?=
 =?utf-8?B?Z2g0cWpNZnlHYXVaUXZXT1BURG1lZGpDcjRmTTZlZ1dMQTRORVQyVzZudjAy?=
 =?utf-8?B?bU5VdUJTanR3bnM1RFRhTFY4aWlVRm5WbmtiZEd4MmN2Nk1yVFUxODF5S3Rm?=
 =?utf-8?B?YTFIU040eGoxY0ZkL1lnKzJqQUlWcGJ5UHk3eUJ3bVowRU1kWTFNZGhmaWVI?=
 =?utf-8?B?QmVJYnFtS3pPRGh6WFMyTUtRQmlFMmtrQnRWVTV4Qk0xOW1PR1pXNitqanBI?=
 =?utf-8?B?YXY0cHZtOS90UzFEYTVBVzk0U2dMdnRpOVNSYkVodmpoQXFDalNuUzhJRTFJ?=
 =?utf-8?B?M0RhRFZMSHFBMUxueVgvL25VV0ZIa0t2U3dXcUtVT2dRSWpZY2FWM3pUdlhq?=
 =?utf-8?B?dFJlMVdmaGJUMURSM1JhcTd0UDY4Um4yeXVweXVmL1lNZy9tamVOR0VxcW8y?=
 =?utf-8?B?M1U1Ty9rMG5sQUEwMWxCSU1uMnRzb2dpTHpsZHNBL3FuT0lMMFhOelRLK2hD?=
 =?utf-8?B?TFJNYlE4TFVWOXVLM2o5TGZKS3dyeXlvY3ozNlVlS09IOHBsZzlIVzlRQzBH?=
 =?utf-8?B?aVhRZlBkSWYwNU5sbDVxMWlvOFBFOW5zZy9JSXZHWHo4cHFQR05KSXJ1Tlh4?=
 =?utf-8?B?TGtHTkh1eXNLUnc3alBTRU40cGhCQWgrZnl6SnBNWFcyTHp4VUlabVNmSHpQ?=
 =?utf-8?B?RmNFbEova3RhSTYzd3hDaVNIVnkxamRjckdPcGRGNmNiSXNRcTF0R0FrTmd4?=
 =?utf-8?Q?YSrs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50d6799-fe15-4bf2-a87c-08dc20e6dd68
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 16:25:11.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBc+TuNu+mZ1y9bn3sVXD8tLJz25cvVJ4xu/PyqnZLQ0Fp6GjyO5UvfQEz4bwrOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-01-29 05:06, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:e128767a-9980-4892-a8bc-9acc206dd84e@amd.com">Am
      26.01.24 um 20:47 schrieb Philip Yang:
      <br>
      <blockquote type="cite">This is to work around a bug in function
        drm_prime_pages_to_sg if length
        <br>
        of nr_pages &gt;= 4GB, by doing the same check for max_segment
        and then
        <br>
        calling sg_alloc_table_from_pages_segment directly instead.
        <br>
        <br>
        This issue shows up on APU because VRAM is allocated as GTT
        memory. It
        <br>
        also fixes &gt;=4GB GTT memory mapping for mGPUs with IOMMU
        isolation mode.
        <br>
      </blockquote>
      <br>
      Well that was talked about before and rejected. If we really want
      more than 4GiB in DMA-bufs we need to fix drm_prime_pages_to_sg()
      instead.
      <br>
    </blockquote>
    <p>I sent a patch to fix drm_prime_pages_to_sg but the patch was
      rejected.</p>
    <p>This issue happens on APU, as VRAM is allocated as GTT memory,
      get to this patch only if IOMMU is isolation mode, with IOMMU off
      or pt mode, multiple GPUs share the same dma mapping.</p>
    <p>Even with the fix patch accepted by drm, we still need this patch
      to workaround the issue on old kernel version.</p>
    <p>Regards,</p>
    <p>Philip&nbsp; <br>
    </p>
    <blockquote type="cite" cite="mid:e128767a-9980-4892-a8bc-9acc206dd84e@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 50
        ++++++++++++++-------
        <br>
        &nbsp; 1 file changed, 34 insertions(+), 16 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
        <br>
        index 055ba2ea4c12..a203633fd629 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
        <br>
        @@ -171,18 +171,41 @@ static struct sg_table
        *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (bo-&gt;tbo.resource-&gt;mem_type) {
        <br>
        -&nbsp;&nbsp;&nbsp; case TTM_PL_TT:
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sgt = drm_prime_pages_to_sg(obj-&gt;dev,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.ttm-&gt;pages,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.ttm-&gt;num_pages);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(sgt))
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sgt;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_map_sgtable(attach-&gt;dev, sgt, dir,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC))
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; case TTM_PL_TT: {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t max_segment = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 num_pages;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!sgt)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-ENOMEM);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (obj-&gt;dev)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_segment =
        dma_max_mapping_size(obj-&gt;dev-&gt;dev);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (max_segment == 0)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_segment = UINT_MAX;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use u64, otherwise if length of num_pages &gt;= 4GB
        then size
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (num_pages &lt;&lt; PAGE_SHIFT) becomes 0
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pages = bo-&gt;tbo.ttm-&gt;num_pages;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = sg_alloc_table_from_pages_segment(sgt,
        bo-&gt;tbo.ttm-&gt;pages,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pages, 0,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pages &lt;&lt; PAGE_SHIFT,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_segment, GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(sgt);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(err);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_map_sgtable(attach-&gt;dev, sgt, dir,
        DMA_ATTR_SKIP_CPU_SYNC)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_free_table(sgt);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(sgt);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-EBUSY);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TTM_PL_VRAM:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vram_mgr_alloc_sgt(adev,
        bo-&gt;tbo.resource, 0,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.base.size,
        attach-&gt;dev,
        <br>
        @@ -195,11 +218,6 @@ static struct sg_table
        *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sgt;
        <br>
        -
        <br>
        -error_free:
        <br>
        -&nbsp;&nbsp;&nbsp; sg_free_table(sgt);
        <br>
        -&nbsp;&nbsp;&nbsp; kfree(sgt);
        <br>
        -&nbsp;&nbsp;&nbsp; return ERR_PTR(-EBUSY);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; /**
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
