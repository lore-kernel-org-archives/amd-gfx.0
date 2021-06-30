Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F2BC11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D8661D2B
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D8661D2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D616E922;
	Wed, 30 Jun 2021 04:00:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3381B6E922
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 04:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPS1VjRAEZt89V/d+SmQpgzxMTXdPSBQ2EldXx9UEpwSIzdsZlC3nEUAO1YVsZFxMMMhPrut8bFsenZQkes/BphBHuT7mrOgSn6/pzgoLFLaxL5f6KxYqF0l/mzI08h4djV1s3JrwaXZ+aDcuGlhDR7v8s780JN7jzvT3JVxko6qIrEbX/wb2VDZ79VWZqC5P8sGYuXgqW3OYadr5B+pbvSUItrkjyYu8LL4JWnTKPZPMNWDGlfw6r3/XaybM+9QYU6uN2AKlgxkdKn8ZXvohnqJZ1qfeQIpfYUP5LYxOLikaYswXeITPXeKbaUa9YhdHac5EMU/GiD1ENDE6Z16Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSRpey+DPuUVzQBe/OGnrf+FrY81xCeHLHI8T6s2YHk=;
 b=W7US8G5M5NulCJNtoVdd5VOVppiaNFK+oZjRJ5vxt/ZgqhzMOgjiXzhmSEvUbBj9kcGwdDW7BgGc/k0p1NkuoKdeTGYI1APkrN2W5jq4WrsPNR0yLzg0vwdA+pAx0HCDSeyLAQ9a/nzBuNSccOOCm77SZ2tqyUZ7mEsYJaf2GdWGJyhzkXO2cv4V7nDv4mkJsE5IOilLt+sCcrV2XZo6NroLT9tzN3Hf92lbUsmiO5rwQ4ElYvhy0xFAr3JOjY6CIA7VLVrdye/1GUy4PjAd10VVZIhHuldXtSZHJ6cq+LC3LCnWOZyhYMDH8l1v9ulU7s/ZXuPGI+FcY68KsXtGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSRpey+DPuUVzQBe/OGnrf+FrY81xCeHLHI8T6s2YHk=;
 b=4gVGAYCatg9g99mC3PmtUdSFKKQQCTjZmgmCx/8TbuM1ZZ2QyOwQDNRj8F4Tx2kkMwHijhjxh7t+YDQi6NAwZ55dwJ1CKd/iWamoN9RmAKdTtR8mnxmHgZDi29YABb1ARBQi7tpbbWrDjusrzDTAbVev0InzM6/IukQke0Yiyt4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 04:00:11 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 04:00:11 +0000
Subject: Re: [PATCH 01/11] drm/amdkfd: device pgmap owner at the svm migrate
 init
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629180206.8002-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <163561d9-7731-d0cd-e539-b754d3349be3@amd.com>
Date: Wed, 30 Jun 2021 00:00:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629180206.8002-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 04:00:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0b00ff-7c30-4645-8559-08d93b7b8e88
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53087CCA3351468E87D6B76692019@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +X2ru8L2ivb4ktI8oVv80S4VIeQqcnwJcG7xDG8U3vj/3UUPixK1vPOaGhVEZhm2NYX/37QmSKzMnbDVUVpcVWdDX01/A3TcbOPSBpaUWRC6qdFcARh7PH/X1VA4jR4xlIwlrm7PkHD8ua0K0vy2o1vzwhip0cKTNukwMxQPoONK9f9dKr+KEBcVSIz/OA4u+ZYUpMWBDDCA+k35bXJ9Fj7uvpgO7CvIkdqGHYhrJLrUlXeS5BTRVxfdzOnb5Kvo/GmxszfwMOyEyGsT+/aCrDZS4JpQZq/dTOXmt6BIKQM4ccMj2p1zc+A2o/o4pSMGrn0ttqGwSQiMGSsisVpIpkTLLHusi85P0k+uvmna0k1He/IqWDzOMcjVbK9G6oeYzLy8CxCQ9YO1G8kpXkv7fdspgjZmEsOhuyX1Zhm8NBhdbr/W0B+vxLlkMEdWG8ZC0R0o6pRD2sRNhH1a+3t6jnsldvlpCyYOUFJDPFccv3jHq6NB1CA2RPfx0Bel088F+m2SwgT8QLnVqISlhJI4Cj6oHprR2GFv4NYa4mUtE9t/dUkWPJhdaRAzQL0tGe7+It7iAShTuJWvacNvOz9YHVmy4RWcfwbcVlIHQZjND03bn82PzkGRW4Tttijc0cqJWj8GybITl8MZM6ryUfglBl/O/ZWgCi/jI/8wOHe9RH7Fm6pCRs8A/iO19aetRM4/uelhnxpIFqPKqNePnd6Tp3BM80b8x1dTIr6lUApxODgKL2wtQmTY7OOlWMp/9wKY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(44832011)(31686004)(5660300002)(2616005)(2906002)(36756003)(478600001)(956004)(66556008)(66476007)(8936002)(86362001)(31696002)(8676002)(66946007)(6486002)(16576012)(26005)(316002)(83380400001)(38100700002)(186003)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZCa3VyZXpkbVFaS2EvTzdiOEdqaUZabUZkZ05ZN2VrczNoL1ZXVXorcnZX?=
 =?utf-8?B?ODZxYllzU2Z3bWFWL3Q3cktzM210c1RhM0pGVFo3MUR1elFmeFlvY1dmTHQr?=
 =?utf-8?B?Sjc5M2FjZEYyMnM3eExMU0dxY21mUDRkd2pUWStaa25zeWxzR3dqM1M3VUl5?=
 =?utf-8?B?NStVNkQ1bHlsR3h2aWZ1dEpKNWtVdW5mZVlWZWZRNVpjYkEwYy9PUko4V0Vj?=
 =?utf-8?B?cW5hWW1QbnhKWW1hbjVQMzJ4aWhKZ3VaZHpOcjVBSnZoMHJnZGhjS2Jsc0pN?=
 =?utf-8?B?ZVdHWEtCNVU3Nk1YN3JNVENkSmVDUmRsSVkrcE5tYXgvVjFGZ3cybGZoNSsr?=
 =?utf-8?B?V3JrZjZvZzFyWmNBYWlHYnBPQnYvMHdTTmI1Vk5HKzJIeGxNTStNUDdHNFJ1?=
 =?utf-8?B?VXNHWmZ6YkdINUl4VjJJZmJ1U0J5TVNqc1NmSE1RVzhPV3o4TnJLdDFyYU1T?=
 =?utf-8?B?WDc5YmdFRXYybmVxMmQyU2NwQU5CL0c1T3NpaXBmcnRpbzF1NjBFN2hrMER4?=
 =?utf-8?B?Q0VJNUE2MUFuaVJITnl2L1lCa0ExTDZjd3dBUTJHUWhaNE94TGtWWkZtSFhq?=
 =?utf-8?B?dGlQaHF1NnlnUy8vRFpNNWdhQXMrSHVLeDVCb1oza1RLZVhmSFNtTHcyU1M5?=
 =?utf-8?B?cWFjd3JaUnpidlloWjd4dENUWndFZkVKM2ovSlczZnRKUXN1SzdBdWxMc2xu?=
 =?utf-8?B?V25mQlVNTWZZaU5lTlhnWVpXbEJLZitqY3J4empnWStDaFFKMHFjOUtBRkE3?=
 =?utf-8?B?elhIa0VuTVFlanJDR084OEg2REl1c1BQU3VyV3hGODd4WkFPTDFYUlUxMzdF?=
 =?utf-8?B?akNNZXpSL3g2bWErUzNNL3dVSTArYU9CYkdBVE9xenpJNDBVbzlnU3RFZGZV?=
 =?utf-8?B?N2FWcGpSZnRMYTZ6em1PZGkvZG9pR3Z3aFBaYjR1YkVac1VQVE9tbGNJbVRy?=
 =?utf-8?B?cjgzYlVDeUxxMWpCTkJYdmw4dW1DMjhNb1VJTjQ5QURLUFo4bkV6alMxcGtC?=
 =?utf-8?B?NjV0UFJMWWJXaVBMRWlCcVNYNlBaQ09XZS8wT3lmQWM3bkcvYndEUTBySWRZ?=
 =?utf-8?B?UFVjc2ptMXFlekthbDMvbHA1WmZJRjY0VmNqaGxEMnQzdUJpVmxJTHhJSVZh?=
 =?utf-8?B?ejF0cmpneWlEOVd4MlVFb05nVUZVekttQi82SEliVjRxQTF5MXdUNE1UZ2E1?=
 =?utf-8?B?bEFwWkxPTzN4V2FuZGZtcWxZMmJxN0MrdWlMNVFYbVgrZUpsSzNxS0VEZFgy?=
 =?utf-8?B?S080d2NtbTk0dlhqUVoxcEtab1ErOXJMemxFdWxIRnArbHlsNUpGNVFxUk9Q?=
 =?utf-8?B?N29KVHUySmlmYWxuZzR3K3NGTVZzek85TzVtTW5paDBlODBONGpIMnRRb0pr?=
 =?utf-8?B?MmRiVm1zb3FlMDAxZmNwQVlwUEI1Y2F2aXcrekphM01SQUxIUUlPbGMwNlY5?=
 =?utf-8?B?dXd4M1o2YzdKdEZsbDdBT0ZWTkx3anJFdFlHTTJSRXRyVEtWS0FSWUJ5cWlO?=
 =?utf-8?B?UFdUN2hVV0J5eDRPK1k5bTduaGNMZHdMQ0RyOHBPenVnbUxaSmgydEZ4Y1BS?=
 =?utf-8?B?bkc1Y0QwSWNSbE82N0lIREF4ZGtMaEp6T1NWdjd6TThPeXNyV3dWWVdEV0ta?=
 =?utf-8?B?SStLRzVzNUhac0pxMGJvSWY0UXFZOTRlZTNmZTRkb0RIKysrTzg4WXhsZDRR?=
 =?utf-8?B?VEJ4d0VDYXZEZCtCSlM3V2RFRWZqbm52VkV3MWlra1g3ZVNiTmJMVjB4WWpl?=
 =?utf-8?Q?a+zL8gb2tBg3A2whYc0F8KNeSE6I6p7KfM98TAC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0b00ff-7c30-4645-8559-08d93b7b8e88
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 04:00:11.1508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dOufQ9wfQuNc0F6svQBczqHSHPMLBD0LvFPaH63LX1XKBnYGiPtubd6AFaB+W424BZoJQxwwLmNWdIzTRXhSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-06-29 um 2:01 p.m. schrieb Alex Sierra:
> pgmap owner member at the svm migrate init could be referenced
> to either adev or hive, depending on device topology.

Please update the commit description before submitting the change:

GPUs in the same XGMI hive have direct access to all members' VRAM. When
mapping memory to a GPU, we don't need hmm_range_fault to fault
device-private pages in the same hive back to the host. Identifying the
page owner as the hive, rather than the individual GPU, accomplishes this.


>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 +++
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 45b5349283af..8ce71c8142aa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -427,7 +427,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  	migrate.start = start;
>  	migrate.end = end;
>  	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
> -	migrate.pgmap_owner = adev;
> +	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>  
>  	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
>  	size *= npages;
> @@ -649,7 +649,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  	migrate.start = start;
>  	migrate.end = end;
>  	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
> -	migrate.pgmap_owner = adev;
> +	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>  
>  	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
>  	size *= npages;
> @@ -921,7 +921,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  	pgmap->range.start = res->start;
>  	pgmap->range.end = res->end;
>  	pgmap->ops = &svm_migrate_pgmap_ops;
> -	pgmap->owner = adev;
> +	pgmap->owner = SVM_ADEV_PGMAP_OWNER(adev);
>  	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>  	r = devm_memremap_pages(adev->dev, pgmap);
>  	if (IS_ERR(r)) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index a9af03994d1a..1f88bdfdbcc2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -35,6 +35,9 @@
>  #include "amdgpu.h"
>  #include "kfd_priv.h"
>  
> +#define SVM_ADEV_PGMAP_OWNER(adev)\
> +			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
> +
>  struct svm_range_bo {
>  	struct amdgpu_bo		*bo;
>  	struct kref			kref;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
