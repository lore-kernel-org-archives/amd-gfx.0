Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66421C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 10:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C4C64F5C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 10:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C4C64F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551F36EA4A;
	Wed,  3 Feb 2021 10:59:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B29E6EA4A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 10:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV7WFLDxFrWsqRxPdbBRm9jkgtYCVwrVawLNn3F99br3v14MTn0ixPFTVTayqno9nxt6xAuTMSqCYy/sik8ptVJ9nZxyrcy7yBAOvgwTgmnny6q95vrE7MgZ82rLmdO/lm7XhjvAEkPKgO5HK50j9fCeBKzLRRnhBHX2WI+udw06+W7dyAXy1q1POyun/zwfU0UIt8fKzRh0Kd0vTiTDgh3cuR8l1mkEt1CHiVpCQXsuwESIViZFs723SDHB7rYj3shRNjZb54HgNu1tEXGByUfwWlLPILbZ0ftnr7Gu0E0qxYaNUuDpgXfPFuoay4AGT//Mq5Bilxg8WQRCiAvBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQmxGiFw6dmU9Zb02bxohrjSyUN1PtP2eXu/Gc97x2U=;
 b=Syd+ys9glb0yZ5AyhOKQ1BfinBU+7DLHnyqZ8zeD0rSXPby0zUpQCF6EHkuw16wGN2dHcsqkBxhqG5+XlVQDkIX2lIJ1l5jSyJbDjgDaQod/nZlTfv3K8JM/ridGyM5xK9FL3oJk0yXAXoI/j1EX11L0qco+Lt/JNW+XBaEssqye35J0DbhvBlnB4D0xLJ4fMv8/k5TwT2kXvrDtjq0hriOcMU1OgR309yZm8J2plAFyyBUSSQlRPIE3oSzBo3Eky4VQT7ZUPmTDzdoA8lFI+p2mE7gskdLtA0mykcCXYE6owklcX/GDK8BlXhHAToZOy6bVKDgzySmcw+AWHKfqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQmxGiFw6dmU9Zb02bxohrjSyUN1PtP2eXu/Gc97x2U=;
 b=sGxPavo3D2IvmOsUd3zxswsVYQ1tjWX1wOtuqvhvHTiIUywQr2/8qy1hdHy+GUBf0QsUoX1L49SJM1eA6Y0QbAk0lMh9ZErfKXhmCYlk2v403U12cqDkYpoIq4DzkCdCLApJwwTM4yIYelkCs8dBoU7xBtdxiW+hOeMmjOnNaLA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 10:59:44 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 10:59:44 +0000
Subject: Re: [PATCH v3] drm/amd/pm: enable DCS
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210203104725.2000-1-kenneth.feng@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <4eccb233-82b7-0c93-1259-382dc0000b66@amd.com>
Date: Wed, 3 Feb 2021 11:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210203104725.2000-1-kenneth.feng@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.33.84]
X-ClientProxiedBy: AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::11) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.33.84) by
 AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Wed, 3 Feb 2021 10:59:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dad13f4b-a71b-40eb-fc16-08d8c832d00c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4450373FD3C0D713CC41E4078BB49@DM6PR12MB4450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2iipIQ4JqoHlVYMXgFx+nVgdaAIWBZmGaWKlwkPa4mqnWBbfrQQ4FE/yy1Q16PLoaCV0W0Ph/UjKlzn/26Ayf6cYDkm5Qol7hj0AZjkh6ru7Wc40edfTdC4AOznrh2qxYYS6jzuZu6dmfSFN3Hd2AN7mYZ7DPYU2lxf4SR+ZxaG5n2oA4sz19XDSS+aOnXM+gdoEqIvEGdMk+qA7qB+M3FaFItJdBQC3M/z8k8wM+Zxk+V4qh6yZodr2BRKhcCy2zwaOJIhGqIhQam4F/7abjBewHBrvSSeKhdNhM5ofGCnGDNAbIs5ACjf6UbJ7K9Rcas0hxPQ/kVQw3RMz4sSurkXSrCkdLp3xRXIUJ7zYqbrx5i4kWCkTx5sY1d74ZwxR47WSZVf7zZ6xJ8OX4oVPBgnF4Dv2h0t7W3q4BBZKPHYSm18Btx65sin1+FhOFYYquRUP/Yv/SI4lChXZOHNpvEY6lj42+zMJxzNWMz9tzeuofVwTdD8yaOGqBJmVqr++yF4AbzMAWxbNaWVA1tHXQwre/iPNjHqM6osS2mC1IMlEuicxxvW4AM5b0JVRWofutN5zzR99fObdIPxpRqu9rqwvHJH/kRvon3YY4OIq/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(26005)(8676002)(186003)(16576012)(36756003)(956004)(53546011)(2616005)(316002)(478600001)(6666004)(16526019)(6486002)(8936002)(31696002)(52116002)(66946007)(31686004)(66476007)(83380400001)(66556008)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?clZzZFJQa0FrV0hQdDV2cDFKQW1DUnk2MkkzRFVLb0YxVmZ1UXlpdzlQY2tC?=
 =?utf-8?B?R2szMTJIa0xremp6QjR3MGhKdWxGSnVtVGV4T2ZjV2VyNnJVRTJVV1VWU29O?=
 =?utf-8?B?bjNyZ0ZZVTYyWDFSdm55ZnVDYkMxRnRIL0IyYkNQaVRYbzJSOHFCUTlXN0xH?=
 =?utf-8?B?MEpURERJb1dPdkoyUDUyUjZqY25HVXBsN0g2bGFPcXJpVU94K2J6c2hJOWJh?=
 =?utf-8?B?TnluRjRyYzdmck1DdnkyYU9Rdnh0bU8waFZ4dGcrZ3FzSWQ5SzhnR3gzdzJI?=
 =?utf-8?B?eXBRNWVBNVhlRjNQOU1XWm8vbTJNcVMwRW5RS3F4VnZDY3BRRTZoZVJGQWI3?=
 =?utf-8?B?TklvbldqWXBXYmIyazB1dlhrZkVSMWJWaDBqNlJlaE5iMkhJaXNTYzQ0a0p2?=
 =?utf-8?B?ZWgxc1ZXaWhQVk00b3VnMHJlTklOWW1EenBKeGNqd0Y4QTJFeHl5bDR5V1dz?=
 =?utf-8?B?dEJDOEZ1YTRpQlM3Y3ErZ050OVRoQzRPQVYydWQySkp5NWVISlh2VGd6b1Rm?=
 =?utf-8?B?Nmxac0NRWnJqMHc3Y1lxOXRqK3JRZjlZZkhjZ042T25OS2dlTlZKbWtrRHdn?=
 =?utf-8?B?QW1CekxudWVENXV1Q2hIWlJvb0hNR2hheFl1VGtRWXQvS3p6a0E5V3k0SFBq?=
 =?utf-8?B?QURNVGt4MUsvVTBRMk1ZcTYvWlNPSHVwQ0JEMyt1OE5zOGxmVXR2Rm51U1Q0?=
 =?utf-8?B?VExiRHd2U2lBcXR3M3Z6R0FpNXVQeFZFbkpvRGVYdzcveE1mUlVLc283TUFl?=
 =?utf-8?B?TGhZa1I5QmI2Y2NUSklQSWNpbGdUNmtqbDhtclVYVzkrWjl2cVo5SktrQ0Ry?=
 =?utf-8?B?UDV5YmxQOEhCSGdQdVFWZDAraTFlbnJQZnFkdEJOWWphNkpPb2I4NWVnZFFW?=
 =?utf-8?B?NEwrQ0h1S2w5RlVFeFU0b2FCSEhXM1FjeDdSY3lSaHZjN1lDU2R5TXRHRTM2?=
 =?utf-8?B?S25sTFNXNERFZ0pwMUZMZUhpMlVBNGxiMUlBOC85YTh6a1RXUE12OHVQaG1p?=
 =?utf-8?B?SEZPVlBnSHp6ME5hRVloYkxHejVHWUJWTDc4ZkVSTlFrTVFmTmptL3c2b3Vr?=
 =?utf-8?B?TVZ0TWdSSWVtNEoxY1JQdERVMnNGb0M3ZFl5dktCLzlrMDQwTHR4eWs1eGt2?=
 =?utf-8?B?UDBCeHFITVRKSTI5Nkxrc0Q3TG5zZ3VQclRUMmI0aVRvSlplcXdGM29yclZv?=
 =?utf-8?B?ZXk4K1R3anRDOTRhaFF5eHRMVjF0Ni9sQTVFYjdPQkM3Q0E2WGVHbUdIUTh6?=
 =?utf-8?B?M1M4aW9HYlR6NzBoZUpMaGNvSm5qZUlCYkRYVmdaNFJXaWdYN3FQVGhPK0d0?=
 =?utf-8?B?SkR0M0dtZ2JOYmUzUGxZNDIwenRxS1V5MXhHZlYvR3dzYldCQmJtRFNsVUNl?=
 =?utf-8?B?bEs3ZHZteUJPSVRaMjZITFh3REVDUThrQmJVeHV4NlZ6cnVBRXgzaGhsejB5?=
 =?utf-8?B?ZGNGSXBTRUFidXZxZTBBK1JhejNaOFZ3NWpCTjRSRVJMd0tNdXBjb3Fnb09H?=
 =?utf-8?B?S1dGOTZScGo2NDRDbHZzVnVzeEVSZ09yb09rbmtndU15eE1TV2VwTEdYR2Zm?=
 =?utf-8?B?MXB2cDVJMTYzZUpLMnIvRHRJVkJWMk9vY09CQTEySVhiaVRJLzNGV0lyeUpU?=
 =?utf-8?B?TmsrbFJsb1RrdjR5ZXFKVzRuejZNVVNjN3YwVWpEZWlhMGlCMXpNK0Mwb0dp?=
 =?utf-8?B?ckxsQXBXMkJ6aXY5K0RsOHdrSm5OekdvelNDdnRDVERudXRwMjR2QWtWMzU4?=
 =?utf-8?Q?of7Fd6yAdaelnksXyvK9xBnpB38MlaRyeuH+MwN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad13f4b-a71b-40eb-fc16-08d8c832d00c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:59:44.3083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncSGCElG+w6iscSaG+kX/7jqbsaa9XAHYbMyDsNl1N2OyRR6xbRS+d9Whu5dSSrWwh5kXRonOBNUHnrk1Q/C2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/3/21 11:47 AM, Kenneth Feng wrote:
> Enable Async DCS


Please expand the commit message, like v1/v2 of this patch.


Regards,

Nirmoy


>
> V3:
> 1. add the flag to skip APU support.
> 2. remove the hunk for workload selection since
> it doesn't impact the function.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                 | 8 ++++++--
>   drivers/gpu/drm/amd/include/amd_shared.h                | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 +++++
>   3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2fd3a80bb034..ca3dce6d463e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -131,8 +131,12 @@ uint amdgpu_pg_mask = 0xffffffff;
>   uint amdgpu_sdma_phase_quantum = 32;
>   char *amdgpu_disable_cu = NULL;
>   char *amdgpu_virtual_display = NULL;
> -/* OverDrive(bit 14) disabled by default*/
> -uint amdgpu_pp_feature_mask = 0xffffbfff;
> +
> +/*
> + * OverDrive(bit 14) disabled by default
> + * GFX DCS(bit 19) disabled by default
> + */
> +uint amdgpu_pp_feature_mask = 0xfff7bfff;
>   uint amdgpu_force_long_training;
>   int amdgpu_job_hang_limit;
>   int amdgpu_lbpw = -1;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 9676016a37ce..43ed6291b2b8 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -213,6 +213,7 @@ enum PP_FEATURE_MASK {
>   	PP_ACG_MASK = 0x10000,
>   	PP_STUTTER_MODE = 0x20000,
>   	PP_AVFS_MASK = 0x40000,
> +	PP_GFX_DCS_MASK = 0x80000,
>   };
>   
>   enum DC_FEATURE_MASK {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index cf59f2218b7e..fd090d057d26 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -261,6 +261,11 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
>   		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
>   	}
>   
> +	if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
> +	    (adev->asic_type > CHIP_SIENNA_CICHLID) &&
> +	    !(adev->flags & AMD_IS_APU))
> +		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
> +
>   	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
>   		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
>   					| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
