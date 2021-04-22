Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD4C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F8161450
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F8161450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AF66EAAD;
	Thu, 22 Apr 2021 15:27:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6478E6EAAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ekpvqk40Y8ibm2sNCNn24imcopzfBjV5NvUDhw0fDVBJG2M/ZGzGVncXZbos9NMMgDeTyQBS7yKTO4fdjCZSyRxV54WI9hLGyo5y4omqvp4batMJZMvNmVn4ULXC2aZIcsQSkDpQZMZ88gNmj1fwwakXBqInnlFbFMl7jbMC8oc/R8GELYWukTPJUKttt9+9YEx2zCdN6kYgL1Hz6pLd/TPl7f5yxcfZTlg4BLNcp/OPoQad1qFOxGFfNm9qwSqdX8RqDC8AnvExtbG9S/NTkS4hA1mSHvMEhNyL3lPq1oxhXPp9y2m8ROhKILmTzU1PTmiB9FeUBatJXmmm6rZ7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3fyXpY4GmbNe7sPO2wS2bowsQJRcA3onZxXsIzSxkw=;
 b=JUozhJtWnlNHpQnJJRQyP4UroXPY2tbHuD0tG/fVI35CgLnlSnvKB/lM7OXmKgcds/0Lsf/CXtQz45IMzD8QeFsS0H/y7ZbFF2IxHZgL7Xak86DzM3OYiDRI4gnI7QS2Fvefs0exhuOTRcT01zANFnhg3uN/2g9PlqH7FH113W6Vb3fOV23LT3ojzwy1K3bX/iYul42Ti0pM9b+sS0LlKm5jeJTWswKi7oLzxWZLVF5P22lVpIjg3Zjwaa+VJL7PU9tUtHX9wWwIsdUFTnEyUf9VtxF8FiO74LCrHDN7mSo46zN//LEJpDDdhW6TVT9eWkO4YHk+7XcQJxnPmqqcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3fyXpY4GmbNe7sPO2wS2bowsQJRcA3onZxXsIzSxkw=;
 b=BmPj/mLy+iuedcPqeC8BXtoWYvcA9M/2dif8lNxhTIvsXUarCEM3JTOiBCTVzJiGa+oZ6/7x2N5P8zv59AWombc00FvPyb6uxs/ZdI2JIxm4uODgdNq0puc/XDQR7L29EugqOv2u4IJkZrMKgVnllZ9qV/Jqo7vg3g29PppEisQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 15:27:09 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 15:27:09 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: set attribute access for default ranges
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210421195156.24250-1-alex.sierra@amd.com>
 <20210421195156.24250-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <be3a698c-0fbd-0797-e350-84463e6afc5d@amd.com>
Date: Thu, 22 Apr 2021 11:27:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210421195156.24250-2-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Thu, 22 Apr 2021 15:27:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c01559-d5ce-4441-7d05-08d905a317ed
X-MS-TrafficTypeDiagnostic: MN2PR12MB4438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4438A5941430684F406187F192469@MN2PR12MB4438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRo406NROXjmRIFHLWQFCNYiGrlyP+eZrZX9OcovHXGYcFAFRSUiXohmXHHqnlBfQ25TRYeEffFrqpuiEZDEq7OXQAHq4pcKuw5Eq60tA1AZzHw9mwEcWfkCkR9Q+SdpqE0yAPC9O9koywTL2vhiujxDpwIswFMd2kCa5cKSO0IohSVtnaR1ATrh9GDBZ2UqumcX0ReZ33jLHPx+LaSTnxsxmbUyAS+0Ja17zElu37wYz5898P5duf7FioOY2JdlwPfGTnfsikDDj9I1OKVfrwLOnPo/uUqz8rSs0prSbJqK+eyuqKSamikSubW+pVYM2v1EVHEMEnKsXJ9uc1E0eq4kmL09veRuj8tjLK8gxA1vycsi3xxf/Vs3KYmE+TQW5UkKL4QKo14wgweMMZsAYItvEZdk6vJzd0LqHVXkztH9chnlQOaxHP1wRjbz4VKQ1+Mu0YI/fCp8gj6EXcZeauO3dm8Piac/nYLJybeINJMmVUfzku9eHv9eNg26UbzOnj2mLXRbdDVrA8dqv/n2ZTJ/c+E7GvR2ddfleAK9NpBkwsdIRJDBGMAXwV4GEOLL8R5/Fju0ZvhrxP+rHIx4slLk6WMViCSBVqZwI8sQJpRMWcIEgfdWV3GQWSgaFR51Oq3gaJ0MwNHic40CiRqaMyu30kJi3ViRYmK9SzxcZmK3hsMj1BryI6VuXMZuiBjj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(8676002)(66946007)(16526019)(36756003)(66556008)(44832011)(38100700002)(26005)(8936002)(2616005)(6486002)(16576012)(956004)(478600001)(186003)(5660300002)(31686004)(316002)(2906002)(86362001)(83380400001)(31696002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OHMyei9hcVQ4UE55VHFaN08zVEo5bTluMm5oQ0cxYWgzdlZQTmMyckRmT2Nr?=
 =?utf-8?B?cFVHTUF3QjFCQ3lZMWZxazVDM1krL1k1b01ZQXkrZ0tVWUNTMzJrVklFM3d0?=
 =?utf-8?B?RVF6ZW50d3RnbzBTWmxzeVBQR0d2NGdSa1Nha0huL29CcjcxUTg4VVU4Z0E0?=
 =?utf-8?B?K3k1WFc5Q083bFBqa0hLSXR1eHFKTGNySTZYQUhiNWhIVU0wRS9saGhWRjJM?=
 =?utf-8?B?RGttY1EvS3dna09lL0FtMXZJZ0g0eTBHeUpyWFBsdGxrZ3oxMVJWVC9hb044?=
 =?utf-8?B?UWlkUEk0cVdjSnZJVjF0QlJvdTRidnUzNVVvMjkzcnB2dUVxQytpU2Q4R0dC?=
 =?utf-8?B?UWNOUHY5ZWdFaS95N1Jvd3FUajlLNlJJWGRCZERlekFGaC9QS3Z1bUZmRHpI?=
 =?utf-8?B?WVlQWEZ2VU5pSWFGemRBNjhXRmlkZE5IZnM2dUJ4N21Ld1BTVUcxVllKNG1J?=
 =?utf-8?B?U0VuTGhEL1U4cm1LTWRCNFdhVk55SjVJa2V6Rm1rS3Z1SHJhSHZJWWFSbUlN?=
 =?utf-8?B?UWIzVlhhQ1dObjJyL1JJMDdUbVJ2RkliOGdNWFBWSlNEbFNHQmRCK3M5Z1BW?=
 =?utf-8?B?OThLQVdEbWxoaXBRNGpsaTBuZGw0UWpUTTRYNzBaTXUyaW9lMWwwRlJidll2?=
 =?utf-8?B?N09zN20xcUhNY0xQb0JUTUpkcTQwK21BNkZOTnFsVEdhS1RuMkFVZy9CUmFU?=
 =?utf-8?B?UWRiemxLRTVrNHNLWlQ0TlRnTUpxMytpVmppSnlWY1RwSlM5OXQ0dHhPejg3?=
 =?utf-8?B?bU1FME1NUXdVdFJGNHg4cUxEUVd0ZEJjYnUyVDRHTFZwbkFaOHhHUEZEK0Uw?=
 =?utf-8?B?ZFJxbTZZMzlNdERhKzR1NDZHV1VzMWdYYU9JQktSM3NuSHk5TlY2ZllmZjRp?=
 =?utf-8?B?TVdOZjBYcHYvU1pyeXlkaFRUV0t4SUNFYld0cGovN2RyL09tYndCWUJtTVBN?=
 =?utf-8?B?aTdrWkhwMm1CQmVSRkFTSjAzaWZqTHR0NXBLSnJCRTBFKy9hN25ta3BCb1Uy?=
 =?utf-8?B?QWF0enI0eVRnTU1YZGt2OTRySUo5QVpQa2cwUExRa2dGaWZIQUM2YVNZTUJ3?=
 =?utf-8?B?cHlGS1czYnlaYkZNN3ZGMWJ5MnA1VjhPbFR6dis5b2RRNmV3RVpkSW9ST1JZ?=
 =?utf-8?B?OEhnNkVVbVAzSDdoS2RINjFXY2dzaGw2QldsT1pCMVovZG83U2p3MTFQS09B?=
 =?utf-8?B?WlJoU2g3SUVRUVltTkdGa1ZpdmhhMUg1T0lEblZHWG85UkJSZDdYSXM4ZWhP?=
 =?utf-8?B?NHp2T0lodHpEMFM1V2lQRHNEZTV6VXZzeE82TTR2S3VaNXBIYmtDVUhGMjAz?=
 =?utf-8?B?N3E4dUhnd1pvM1NWcTRGVjRZZVFzbDl6U2xORVVmRWxlaFhGc1pRS05QRkpw?=
 =?utf-8?B?eG5nM2VoajVrUERWcnVRN0ZNZ28vSDFhRyswUFE2dEpwQVNweVBUU2NnL0Jn?=
 =?utf-8?B?VG5uVkZmVkp5a3B1eGp4ZHA1ODMxTzFDRDN2ekFkS2VBWUJsU3UrWTVDODJ4?=
 =?utf-8?B?OStoc09HSjhOZ2dIUFkzVEdZYVdBUHA5cDFiVXRSbjZEOFJsdDR5NCt1eW91?=
 =?utf-8?B?bEYyVXIwYysxQkdVNGx2NEtMS2ZUeUtIejdIdFhCQnhJc2d2TVp2dmpqS0xH?=
 =?utf-8?B?WU5wRlJxNDdDVUNGVllRRWJjeS9mdEFuVWxuQW1mTUhMTDBZMFFqdEhrRXJZ?=
 =?utf-8?B?ZGlUcDdLMnRsKzNOaWVpT3ZKbTJxQ3JBVncwbStwWnVQd09FK2M4SkgydGdj?=
 =?utf-8?Q?Tkbpccqf0nOOri/EpRvnVavqdfIxYkenCN91bXd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c01559-d5ce-4441-7d05-08d905a317ed
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:27:09.0875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncIRrRW+zzbdavuFYaUgk77EW1FlczvEKfWXRw9DulxEoTvPS9aAd89mEjhpNtHh70Lyp2Vu55eOwJs0YBHwFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
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

Am 2021-04-21 um 3:51 p.m. schrieb Alex Sierra:
> Attribute access value for default ranges is set, based on
> process xnack on/off.
> XNACK ON has GPU access attribute for unregistered ranges through page
> fault. While XNACK OFF has no access attribute for unregistered ranges.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cb025a6f30d5..62cf342d254c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2963,12 +2963,11 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
>  		pr_debug("range attrs not found return default values\n");
>  		svm_range_set_default_attributes(&location, &prefetch_loc,
>  						 &granularity, &flags);
> -		/* TODO: Automatically create SVM ranges and map them on
> -		 * GPU page faults
>  		if (p->xnack_enabled)
>  			bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
> -		 */
> -
> +		else
> +			bitmap_zero(bitmap_access, MAX_GPU_INSTANCE);
> +		bitmap_zero(bitmap_aip, MAX_GPU_INSTANCE);
>  		goto fill_values;
>  	}
>  	bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
