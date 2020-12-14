Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0FFC4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 18:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20767224D1
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 18:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20767224D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 719F18936C;
	Mon, 14 Dec 2020 18:20:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC5A48936C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 18:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkuCYCqINVJEsakOeVD+yxSSiNSbO/n7rG4BX3zDsbbGfh4QuZ6uL4fHNi9tKIZdzaFEYH6UZBV/IYQ/rp49X/lQu7y1RXK1aCczDYIQVZ1zwEvVX7qcM1zmd6FtqYKcMtp+umsuGrDfDVOTo85JT2S9dkJOP0lgfEA3j8C475puwn78+MGp0jsAr7rKJ/8IU8fztynZHhzD/6dlzTLqGWjdE9gSIsypvGNqfj6ihZ/bLPRyvJ+idcRtw3n6WlTHt4Ddj7vhgaihkrX09Jx2OxZrdAuQqGvZEaPTA6uSLY+bqpzSxFmRlgn3O1G20NvH3pAI3dlYK9VPWKlBFdbs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn7i99HSdffRExNOBhafJa5cMS8Q0fYyY7xzfWPqAG8=;
 b=iA6ZFuBn0jZLOwxucA6kljUQCdVN3TAYpN1ECiJZXXSC4Ww1vmHypwxBoGLF0pb7xvor1GAQdavGwM9lnQTUrIGNTD3Nv4mcX6R4PkCphg2nH58kQ9DKrHG1pOz13KYEbS6YKNukZzV/yGSL2uQuGcgVX2Tjide4bj3XZMiu9p9+qXNOJGJpBSOzREUuFZodx0D4P3MrPropKeJRt4l0Jm1HSZlbc/Yaeg30MHSXTyCq2FlxM5Q8Y9usU4w2H2KSDLa9ZVrca5+z2CTqnAiy4Laa/39SEsBPahIWmLYH2aNWwQKjmFUVgujp/JrRytNfZqrrFrIArseK7+TSmP59kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn7i99HSdffRExNOBhafJa5cMS8Q0fYyY7xzfWPqAG8=;
 b=1aMhPKY7etLgceWvvogLeQqHTQ+aHzx3Maq6o4bkmrCz6Ekea0zydDIFJbB0tZ+hiJUXgEFhS1zma56v9fQBx3g7rqztrsOC6x7dZxR9xfOZHKXIdLOo5ZjxlAORCn1tAoTvNi6b2tjFgW7iYfKq4+sEMc1esn8ipCunAizj5v8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Mon, 14 Dec
 2020 18:20:48 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3654.024; Mon, 14 Dec 2020
 18:20:48 +0000
Subject: Re: [PATCH] drm/amdkfd: correct
 amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu log.
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201214095202.2436484-1-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1ad63fb2-6d99-831c-530c-b0da6445e3c2@amd.com>
Date: Mon, 14 Dec 2020 13:20:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201214095202.2436484-1-yifan1.zhang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Mon, 14 Dec 2020 18:20:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f489edc-f448-40df-e59a-08d8a05cfb51
X-MS-TrafficTypeDiagnostic: MN2PR12MB4047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40475CFF2A0FDF18DC89821392C70@MN2PR12MB4047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeRoUmRO058skvlABN47XkfexUqSFrvu+D5WgW/w4gtSQezBrNWaWHbNcrFGqUiM+aB2hbLjC59eW7pSHVDAgNFEleq2AQljmC0ouSWwMqG3W7dlGgQu4jyfOV5q77mMgbq/7ypK9BwhDrdjHDqFRjdWxanwyoBfMhPOozxdnVQU5+PZXAyZ2eKgGRE7fpEvyOK448k5VoGZeEQMTVIEeaCrG8roe0W1xf7sHr1EFWYM26uOpdEaHBvXp/dH/Q9beRIQHXmW1Q33J8OlsWuNBoKIy5H2yYLwxvDOcExeRYrage+tUE11U6My4afqmv5wQd/wV5ZBpH6CSRKoFiFfHDMtb7Cu6HBb8UA+Kwb49faBJvMa2eRTZ+Kck7y8QI0FVy3aSPDhlryhzlmU+NkTZxVOl4UOh3D3J7B2ebGrq7tEC1IavBjvYrhSckkQeMJPQyIXrSV9GIC9p7w7EZWKMXLDpIiwmkDUV83vfSoMgKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(26005)(34490700003)(31686004)(16526019)(86362001)(83380400001)(16576012)(52116002)(5660300002)(2906002)(36756003)(44832011)(8676002)(508600001)(6486002)(66476007)(66556008)(31696002)(956004)(4001150100001)(186003)(8936002)(66946007)(4744005)(2616005)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YnE0R1pFVkRrcWZRVDNmTjRjZDRTNjRWTTY2UndUVXkwTGlwbk16NzM1eDdk?=
 =?utf-8?B?QmlvNW9mLzZBbDNFaHE2U3hmY3JxZXlEd1k4c05Ud3k1MmJOUnRRbVp0SlBL?=
 =?utf-8?B?dm1SNlFVek9BcUZZclFFUUlnWklReTFDQ0ZRUGF5UkxjWXNISk44YUg3UGhm?=
 =?utf-8?B?MXRzdWhEeEh1QXBGVTF4YWZ2M3RlRURrZ1owOXVlR1lQM1JZUUUwcVhDNnFs?=
 =?utf-8?B?c3VjUkdVMDhsSUFUby9NQXlmR2dNeWVYTmdtMzRiVGpGT1RPMmdUdmNCRHBB?=
 =?utf-8?B?QXJ3QlU5NnAzL2M3S0V0bEt1Wjh1VVloTzNMYnUzamRGZ3E5T2VPaUVXVDZM?=
 =?utf-8?B?TTBGYlE0THBiamVlSXRsVHErdXVoZzlGL2NqSi9wK0c5TEg5RjlHNnNYUFFj?=
 =?utf-8?B?TUxpdlQvckdodDRITzlPZGxia2krKy9LbzB6ci9FTHMyNGREQmJrbEZPL3Np?=
 =?utf-8?B?WU44RmVVV2EzYlUrT2Nmd2RkczY2dldreFVtR1FydG56RUlGYnJzbzNvYWxU?=
 =?utf-8?B?WTdYak9uOCtjcjh4eEJaek9mTlkwU1ZZTHVuekJWVHJsMms1aUNPek1UZXVo?=
 =?utf-8?B?bTh6cmpkYytaeTFnMEFrQXlwdzNsRzd6VThUQjdVQ1dhbVRGQ0hCZVMzOW9C?=
 =?utf-8?B?bVZXano0VUJUUTlqZHpGYU9qVVdPTU1raytiSnZFQjRLTWdvUmRNaEZmdVlP?=
 =?utf-8?B?N29qVnpIYmpTeVdvZG1seldQcGxWVGkxa2tEbERIS01qb0hsMmlZTTlvTEd3?=
 =?utf-8?B?ZXlqVjZuVHlXVGFBSWJPL2ZLaDVhcStCb1k3WjdkbHlac2hiNUhVWXhlcXpB?=
 =?utf-8?B?bXdFTUswNmNJeTRWdGI4UC9jeHJrcDhaN2prMldrTzVPOUZ4VnhROVlvM3Q4?=
 =?utf-8?B?ZFAzWXVrVXUrMGlHQUlBTUhpV2NBaDFhb1ErTEE2L3lIdWlubzVYSlZzTjVR?=
 =?utf-8?B?MU9nQXFUekNyaUlNWlFRczdBRlkvQ2FCVTVESWtNSUFFQ1R6dTBqeHMrV1Zx?=
 =?utf-8?B?UG5LMWp0Y1pVY0ZBYVQzTHNIZDJSWU1PY05YODVkM1R6OEdpajRPVXVVY3B5?=
 =?utf-8?B?dDJjK1J5Smg5VCtxTGx2VEJTT2U3b0Vzd3RzVCtRTDRFQzVja2VGQVhBMkk2?=
 =?utf-8?B?UXJVb0U4bjY0THVOM0RrdU02Q1ZlM01lOHFVd0V1Njg4QktHMzhTUVRuZGps?=
 =?utf-8?B?SE1wY3J1cUpIVnNtSUg3SDVId2hNb3VzUlVLUjVWT2xUb0V2UHpxZXJvMCt5?=
 =?utf-8?B?RHdRVDh3cm9CWVRadmVWLzh0bExmRlVUc0psSXZ3OFFFa1lDQ0VqMXJMaUVn?=
 =?utf-8?Q?IcIjkhEcx0Z+sCrkU33cuv6C3hXS1XtOP4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 18:20:48.5673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f489edc-f448-40df-e59a-08d8a05cfb51
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NugXMnpGhi3zANx4ZZDzHAxSbBcBU6Y1ff+XI++4z2yUzPPZtuBV7luBFkJsT0hlmZlgw6hfod9jd3Agp3lMGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

Am 2020-12-14 um 4:52 a.m. schrieb Yifan Zhang:
> it could also be insufficient vram that makes
> amdgpu_amdkfd_reserve_mem_limit fail.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index e54883ff74d2..99ad4e1d0896 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1213,7 +1213,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  
>  	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, alloc_domain, !!sg);
>  	if (ret) {
> -		pr_debug("Insufficient system memory\n");
> +		pr_debug("Insufficient memory\n");
>  		goto err_reserve_limit;
>  	}
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
