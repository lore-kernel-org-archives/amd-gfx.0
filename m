Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D59BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 15:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1790C0629;
	Mon, 25 Jul 2022 15:27:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870D0C0635
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 15:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bstXqg4Ovw/t06T09fLPy7tZpxBDhOF0X8G/QrOA3ErRA9kz06ZUxsOStJn4yI8C7G1kYPrKAxLfIuR0L7FwVAX0fOPlBPCJ1swEvpJxAbsLuQsiE/chO+i0BWviZNqBEVVX5sLC2wqYFixo0k1KTz/MjwMF4yR8IrIFVGvzRCAF83up1YWxKPrIKDTP7x2vDXxlAvCXftlgRkDYhTzSobuj63qHeOygea2AitSnPa3ctp1ccD9nzQHzLm7z9lLoXtQzt4LB6pZmVPZwEqBCNnaskCG83UEUMdLEwg6weqSA+tHvErlGWUuD+GA6RyfbKnrO7tlqSaji9H3ouWKiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rMoDljytJ6jDZYsVH+t5ZKUPNWKqhdhnZUedE4WtLY=;
 b=Vso4AFVVpwbU4EOA5DmaWYs/S8tdhR3XktswUv+F7JXN8G1AGA8uMFJTjKfVYvVzV6R7aYfWwS4lJ5rX0gDI/cHjOYh09JKjGRixiibgcSKyLbYcYdECceru4cm5afhhkhFBTCZ0feHvRSX2BJGrept30Fz6cYfnmLMCu42rsc4V0fX0xzba9cMWuI381Djp7bOHVptsRBJOS9aPBcBCvn730ncdknzle2qeqbUstzTY1iWJykwgFvXoX+Oq6J067zZRBjglpYfptqUSpp4/eCa9bmOqHmI/NLuzOaljw04xEHkAVX9tZE74HT4sTLLj3cUWWNJE+7ifbLhElsduqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rMoDljytJ6jDZYsVH+t5ZKUPNWKqhdhnZUedE4WtLY=;
 b=wKOnsFYF3IoMN3EU3ilGkxNy9Jo9TiL4YTX8oz0jk9LHFWVm7xLnbfsl72WtRODgOzj6PlCi9ji3QhJ9v/fNfMfUIbT57PfaN3j4W4+HAGNa2GyGutBSF16WcqvjcgG7Gm6PIDJOa9qk5wbatGQP8ih8DxKeRF6bemXYAdb93PM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 15:27:04 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595%6]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 15:27:04 +0000
Message-ID: <34f90984-c332-2adf-d1b6-d8afdc7cfa41@amd.com>
Date: Mon, 25 Jul 2022 11:27:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] drm/amdkfd: Set svm range max pages
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725122317.24606-1-Philip.Yang@amd.com>
 <20220725122317.24606-2-Philip.Yang@amd.com>
 <044e7f8e-9fa5-d78b-39f8-84bce155d4c6@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <044e7f8e-9fa5-d78b-39f8-84bce155d4c6@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:610:74::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e73d23-b954-485b-aa43-08da6e522108
X-MS-TrafficTypeDiagnostic: CY5PR12MB6346:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJbaswv2naZIYmXQk0Sxv4B6k38z5bJs9LcT3h9EjPdrgDuoohUaHsJSSJOquwnI4JN5bZw3J/o+j08dtkYOMIvL8+fpx57a9prcdpwIXlO/wZblyQKjaQ2R230r0MyA0y5iZfCaKedPkEEl3frzokefbbBTuy/sRYgGPpLRwl72k+OTS3fOgWMz4ovr2ksOaRaGZ1jJ7nKVotnWu2PgLxV28rxqOH6sbc8eFZdbHQUGdNOJuQQLGOp5CAna1F0K5vsVsGDTsagq89NUXinP/7hab2yaJtbgHMRCG/FjmuwafJRM2c7FSGjxMrheqb1xNvdE9Y0meb37QXaWRKU5XBZ/R0E8zRqUJy9Lb8KczA6w6oYRbWBRNTeluaTwMsRbe8PlXZOhuy+zZH4OZwGKA0/QQNdv7dj8RmmUvcbqOA+puZVmwUPg3fRyxV4vcurE/SBB/5jLbfLxQboHddwT/m0eWZEBw2w8piUbOkpvMxRHsLzUDRP6R3exM7SQ57SS1jmXemWe13SHul10Sf7jkafArMsk6MhY4UxI5Qeo+GdTy7qFCIDQVoqIXe9Cd0w0HtRmRcrE3kcV1cnCfHtEP92clxuuPoghvrGUT0qi4XWth0MtwbF+Hia4hIwlEMFY1CBiSEomWtSsp8KL8dOk3fPDQeD3Kf2+iigtXMaDE7D+0ybb2UnGRAS0vUIJ0ZS1+Scz7uU5b/jCz0yJS/w7TXaEMESv9Jlgv8Wz64CvT2XAbI2cGcKNeYT7NJU9nnMMTNVuazBqY8i6q4Yl7DwcYr3X/uqdJjUijIOmTuv1/2xWJCmdaLVdwr7ArS9n4X1jw6S0ifWRmWhMplID94ygYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(5660300002)(38100700002)(8936002)(6486002)(41300700001)(2906002)(110136005)(316002)(478600001)(6512007)(186003)(26005)(8676002)(83380400001)(66476007)(2616005)(53546011)(6506007)(66556008)(31686004)(66946007)(36756003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGJNdUhWUUVDZ0E0ZXR3emV5U29iRFFTQTQyVncrNWlyVzN5WmcwZS9CRWRo?=
 =?utf-8?B?L1pHendHTVYyVnpZTnZjdWtqb0VXUHVEMTUveEJGZERiZzkvWkRZOStYbjQ3?=
 =?utf-8?B?T00xM2wvMk44d252T3FuR1VZN25SdXltTFN1bVpyZnVPS3BwcEpXTTVUT3dU?=
 =?utf-8?B?RFVsdjNrL0pSSjAzdEx3eGRnZjFFRGJ3VDdia1JTMmgvYzRPK3BkZnBiQm4y?=
 =?utf-8?B?bFlnSWtJelhXdmVtWDQyMG9jWG1yOHV1TFE3bjhkOXAwOEc4VUdSNjJEclAz?=
 =?utf-8?B?bE8yYVo2ZUQ4Z3BJbDBDd3FvWlNjYTFnTjhWbkEwQjhKUEdvMWFZU3dMSXBT?=
 =?utf-8?B?Wm51Umk3T1ZPOVBGamZ4VVV0LzloS0xieHRqU0ZlQllnaGlPRld2L0Izclg3?=
 =?utf-8?B?Z3JLRko1L1NPeVhsUjdubVZKdGF5NEpQZ251NUdydnRkSzR4VlJYdkFWcEUr?=
 =?utf-8?B?UlJnRGRrSnljbXYzbVYyMVI4WnhaL0FURWVTYlM2WVZ1RU1yNlZyMzJMMGM1?=
 =?utf-8?B?Q1pSM0hXQUJ2NElIYUFpSWJtN1l1MUFFZ3krakFYWVJ4ZXgxNEh6bTFvczRF?=
 =?utf-8?B?RkJwSVROZnZBVlp1V0p4SlhCcWkrMnpvTFFiWUpzd21tc3lUT09sQ3ZwR2Fl?=
 =?utf-8?B?anJ0TUVvM0U4d2ZINElNWmpNUHdTQy9RY2tWS05qQkxqL24ycGRkZXNXNDNF?=
 =?utf-8?B?V250T2FEdDlRbzBBbVArdjZvNTU5NzNJZ2VWN1ZFYTM4K2U0c2hLdmpOTDQ0?=
 =?utf-8?B?UkVoOE5wRU93UStxaUhBRUJyUnVLTWlxbzJ3Z2lqa3EwbkRsNGFWTDcyRkxQ?=
 =?utf-8?B?enUwdk9nWEZuQUhqSDV3aGxqNHFoaHYzNTdJUGQ4K1FXc3ZYc1BIQ3hyMWVO?=
 =?utf-8?B?SUxkU3l4M1pnUlphMWlKV25vdzQ3cEpIamxWdHk1ZWRReDVIVG9IRTRYendv?=
 =?utf-8?B?U2NoaS9pdXFsTGJ3ZTd0ZE5sS0MyMEFDdUFVd3FOd0J3UGRsVmV4Yk13MmZU?=
 =?utf-8?B?RHFFUjFrMUF0WnRRYWFYRHlac2tmSHNUbDVwWUFQWXV6TUZ4K0d4K1Y1dlhh?=
 =?utf-8?B?UG9kb1VFdzJ3YS9aUUhkNWJsOTJydThHK3VIV3ZsQVhYd1ZnRm13Y2xmRzJL?=
 =?utf-8?B?UXFGblhWUGhUbXFRRXZmbHJoRFJJc3djZFdlby9tMXgvbHA5UGkzYUlmOGl3?=
 =?utf-8?B?akpnbSsxZkw5SndVeHQ5SHMzOTgxbDlTZlgwUklnNStmY25lZ2RzOG5maWg0?=
 =?utf-8?B?WXovOGFveHNEeXYza3N3UTFOOWxVL1VDZkRsVmw4UVpUczltNkd2R096OTF6?=
 =?utf-8?B?UmtmZitXWDFZUklaMXFvMTJpc0pjWW81QzhIdHp3QWt0UTFoWTBlbkNCeFNX?=
 =?utf-8?B?SENVa2pTYnBqS3BnRXZ3SUU1NVYyUkYwcFV0VTVJSE5ZVVZYV1QyUGNBVzd1?=
 =?utf-8?B?Mm5OLzFBb0N0SXI5QkN1aDFvMStUcFd4NXQvV2tUVFk3QmtkS25WSExnVlZq?=
 =?utf-8?B?ZENkdGl4VFRtN296QkU3eW1qRTJ0R1loQWlBV2Y3MGpCeGRzd1h6aWJ6aFkv?=
 =?utf-8?B?T09XTms0UW1RZ0hjTGpUTWtnblluT0dCY3hSSWlVaWFxY3RGbnhEVDNMeHN0?=
 =?utf-8?B?QmpHTW1ILzFKOTl4WCsrbk54REpJNXl2V0t3TGNSWFhDMnJHZEk0UTNVSktn?=
 =?utf-8?B?aGtGVmRqWCs2UjVoS016Wk1sSkxZSEJGWHdweSs0Y0FvcVdwcUhuOXZSN0s2?=
 =?utf-8?B?QkVLK2VBR3ZranRjNlpjcU9DUTlXa1l2Z21rYU5uNFN3RFA1RW1ENVVPYnFH?=
 =?utf-8?B?NVZpclpkZUlBZzQvMndLK0hzNHZWcm8zQ2l6eXlpa3JnV2FGYXJmMDFHVmJD?=
 =?utf-8?B?V1lqTDdQUk5WUkdhTzBTTVdUYVhHSkNOa0ZLQ0ZVMWljUGd4SGRETHRUTlU3?=
 =?utf-8?B?WXJKOUZyWVdpNDNDdzJ5WnVTZmhXZnllYkd5RU9LRW1BUmM2ZFArelFRUzcw?=
 =?utf-8?B?WlRscnM5U0JxWFl3cFM1cUtVRjFmNWdjcSt5dnY1bkVsbTNQdVpTZUt5cUM3?=
 =?utf-8?B?U0RSZXhTc01ITjcramZKNzhjM3JDcGhzNkY1bGZMNHJSamlmNnNxYXdhZFoy?=
 =?utf-8?Q?k650=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e73d23-b954-485b-aa43-08da6e522108
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 15:27:04.8185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WX7dSWbL5gKK4dz7dYOJ0kiDa0qjRR/Xj8YsmQ+/3AtnI/DUNkt9t0aaMuK3t7qN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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
    <div class="moz-cite-prefix">On 2022-07-25 10:34, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:044e7f8e-9fa5-d78b-39f8-84bce155d4c6@amd.com">Am
      2022-07-25 um 08:23 schrieb Philip Yang:
      <br>
      <blockquote type="cite">This will be used to split giant svm range
        into smaller ranges, to
        <br>
        support VRAM overcommitment by giant range and improve GPU retry
        fault
        <br>
        recover on giant range.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |&nbsp; 2 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 15 +++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++
        <br>
        &nbsp; 3 files changed, 20 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        index 9667015a6cbc..b1f87aa6138b 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        @@ -1019,6 +1019,8 @@ int svm_migrate_init(struct amdgpu_device
        *adev)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; svm_range_set_max_pages(adev);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;HMM registered %ldMB device memory\n&quot;, size
        &gt;&gt; 20);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index b592aee6d9d6..cf9565ddddf8 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -46,6 +46,11 @@
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING&nbsp;&nbsp;&nbsp; (2UL *
        NSEC_PER_MSEC)
        <br>
        &nbsp; +/* Giant svm range split into smaller ranges based on this,
        it is decided using
        <br>
        + * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB
        and align to 2MB.
        <br>
        + */
        <br>
        +uint64_t max_svm_range_pages;
        <br>
        +
        <br>
        &nbsp; struct criu_svm_metadata {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_criu_svm_range_priv_data data;
        <br>
        @@ -1869,6 +1874,16 @@ static struct svm_range
        *svm_range_clone(struct svm_range *old)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return new;
        <br>
        &nbsp; }
        <br>
        +__init void svm_range_set_max_pages(struct amdgpu_device *adev)
        <br>
      </blockquote>
      <br>
      Why is this marked as __init? This can run much later than module
      init.
      <br>
      <br>
    </blockquote>
    <p>Thanks, this was called in amdgpu_amdkfd_init from module init,
      forget to remove __init after calling from svm_migrate_init, which
      is called from pci_probe.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:044e7f8e-9fa5-d78b-39f8-84bce155d4c6@amd.com">
      <br>
      <blockquote type="cite">+{
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t pages;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* 1/32 VRAM size in pages */
        <br>
        +&nbsp;&nbsp;&nbsp; pages = adev-&gt;gmc.real_vram_size &gt;&gt; 17;
        <br>
        +&nbsp;&nbsp;&nbsp; pages = clamp(pages, 1ULL &lt;&lt; 9, 1ULL &lt;&lt; 18);
        <br>
        +&nbsp;&nbsp;&nbsp; max_svm_range_pages = min_not_zero(max_svm_range_pages,
        pages);
        <br>
        +&nbsp;&nbsp;&nbsp; max_svm_range_pages = ALIGN(max_svm_range_pages, 1ULL
        &lt;&lt; 9);
        <br>
      </blockquote>
      <br>
      I'd recommend updating max_svm_range_pages with a single
      WRITE_ONCE to avoid race conditions with GPU hot-plug.
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+}
        <br>
        &nbsp; &nbsp; /**
        <br>
        &nbsp;&nbsp; * svm_range_add - add svm range and handle overlap
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index eab7f6d3b13c..346a41bf8dbf 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -204,6 +204,9 @@ void
        svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
        struct mm_s
        <br>
        &nbsp; #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)-&gt;pgmap.type !=
        0)
        <br>
        &nbsp; &nbsp; void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
        <br>
        +
        <br>
        +__init void svm_range_set_max_pages(struct amdgpu_device
        *adev);
        <br>
        +
        <br>
        &nbsp; #else
        <br>
        &nbsp; &nbsp; struct kfd_process;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
