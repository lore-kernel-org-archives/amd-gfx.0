Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970EBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 11:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588B461544
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 11:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 588B461544
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA826E497;
	Wed, 17 Nov 2021 11:15:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7776E497
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 11:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYflGLbbH3m3iR+M2aGqllNwz9us0hwppYaYdY8BVRDmNdddxi3L8BqcuympxKppfcPafPZK8uxX/z+/FU3gAQXZT1Gj6iJZwG4lkGcfPO0qj8yNzcpd4W9HFpZ+H3/EtOPnfEPy1PnumYDJAC2bSmpgQ8OSCq1VTTXtsZDNbFkuLV8BhAZ5OD8fP4JCNNEWnaHfJlDu0jKsprYNd/CiaAEh2G9/zssr1SzHBi3YyUMJBmIUlnSC6RuQHUZuPyzcT7Vt8WiF4wnE87Wmwt2b64fl/Ia+QArbzTZEaHF+2ubwS9UmAekFidWtKZU2VtRHiYY9X5UuC41bTQ+0VA0qWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pstvrWm3VySyabgxPToPgxeYm/iNMI4v9WCYuPiyn2o=;
 b=LGQbT6tm4cqMdyBZB5hi1CMeKgG3SvdeErMcZSkTt/4h2LOJnNVyG0lPT0gtxRTjTFJA6WREHSFnobMZBhjTgTzzz/Hm8eeJMnb32kKHGUYh1aX1lCEjd3Oa6KDMQcacqJNXu7g6i87hGkWR2qSrkwHetnfs5O7ztuCqJgu1G/dSEs9g/7MSDwEXq1bUr+jQa+yk/JnlpzfsQOJ8lfyVwGQRgTC0YdZ6we7mdlwLxtTb0wGbXSI5m3l/2xQTQlFvD8QBSzpQ8jtvWdFmDU0goV0yh9ZRts55FOptWe7CvZ7+OJd9vZHE0/UCOlGv61jzjEnQSmvN/QlS5xxLBCNjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pstvrWm3VySyabgxPToPgxeYm/iNMI4v9WCYuPiyn2o=;
 b=fzQQOArRGbO7bAkYVYfDMsHQXnzRiEtGnl4TynyVilE/db0ufxEAYLinSjf/fodUQslhbCVrS9RAKhLM47nkd/f5U1W7kB8vXbmPaAG7cTGEfVUbSRG5lX1dug4jjy/9N1Hvp+vRrdkr/dRme1zJOBzWC7wEVkwUcQmdD9MIkc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 11:14:56 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 11:14:56 +0000
Message-ID: <8eab09ca-8294-a41b-d44b-fe6bbd84d727@amd.com>
Date: Wed, 17 Nov 2021 16:44:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH Review 4/4] query umc error info from ecc_table
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, John.Clements@amd.com, Evan.Quan@amd.com,
 KevinYang.Wang@amd.com
References: <20211117101132.6568-1-Stanley.Yang@amd.com>
 <20211117101132.6568-4-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211117101132.6568-4-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::24) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR0101CA0062.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Wed, 17 Nov 2021 11:14:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbfb2a9-d39f-4823-af0c-08d9a9bb7c8b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1756B94F32F1D4ABA671CEDB979A9@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/Ta5PvZfLxV5QKvQFE84pR3t7IoEwHN/0jt1bnoZsNoEwPvPcE/R+B5aCOACArK+ErAErbhUbIEOlSTgnumreKGnZmM11bYcrnhbc3YasbcQAw/7XkU2NFOIDDK+aDM4lshULkSn8xgTdm32AFDG4SQKRVdQAeaXb5Yb5yeqFHzbSGxMdCrjKjpGS21PWtaiNWSNE+f8LAFAePPvLOc9IDUTrle1jurcZTnVh3UOW43bN/bZhvgAe9ynaeLOYWPkaCWwbrwzL551HyzBQTQY2fQKj+P7qmjFwsSXnRe7L12drHLgxSjdFq2hwf9daOteiVzwTazjQADY9qzaS2Sen3CPh3fm/TPKqHQw53TUUvEMSVN1F7vz5kTTe2pSWRcG5GNPZ12y+GOpzHLXe5gE0fyD/cXcdPDYjM3mrkqduCyfjrI9nmUqh7ad4jPgklwPjwIgLIyyYN4aKImMjEwnLsBOs5zu1fA7TruQfhoBwRpqLlEzOxaaYP8M2WiQcYeo6+GnuoMvnSvKMSEyjKeqE9pxq1HZisN/yNUO/VeKi1GaFJ85OkvVbjsi2lgQ9gvrMnnZ2KMa+jwGPcjOUjWEWM2iXhUIO4mhkNX2rTJjLcMJeo9pMssLFE6W8t9nv30r8vnzK5eoM6x2eys6FHRiwKxDZli65Hi9XY0nNN/PlXj7/ISH5dgD7JdO+zunBqlrWDvHPrMPLs0loac2klvdk85iwfFmHdtxhrYY3o2sD6IvdplV6uF4CA37fJFf/fV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(16576012)(66946007)(66556008)(31696002)(53546011)(2906002)(186003)(8936002)(316002)(66476007)(26005)(6486002)(36756003)(2616005)(6666004)(8676002)(31686004)(6636002)(86362001)(83380400001)(38100700002)(956004)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJ5dEFhQ21vOEhOclhRUmlxaTI2em9OeTBESGxzY1d4UGg1OWFiZllSUTFX?=
 =?utf-8?B?R3EwMEZsOFcxZEdqR2FtVGhubnRpNW91SHZPajBjV2xJaWx2QlhLclQ3TzVk?=
 =?utf-8?B?YlRVaDNTSEFJY3kvQVg4c1FWVkY3bXlTcnZpYVlSYU1uTWxHVDlrUmhWYkFG?=
 =?utf-8?B?QnBFZk1ZdDMwcnNmdStJQUVDWlFrUEg5cHpZRk1DUnNQMUxHOVFUYmFGVDdP?=
 =?utf-8?B?UHpEdk51MEZrQm53K0lUdWpMZXhrcmI4ZlBjdkpkUmNtNGYvRkZJemdDd1Nj?=
 =?utf-8?B?RlhJVkphVno3cTdMdjR0UVJDSUNoeUhDeFZHcWZiTFY1Mm1IUXEzUFpxN0hR?=
 =?utf-8?B?eFpXd2cycXVKU1BQOE80OWhNcG14b2MzN20vbHA5c1FmMXVFck9FNGwxTkty?=
 =?utf-8?B?L0FxZklWcEp5bXJYNWdqN3I1dTVLUXN6eTRod0dQaFBYMElBUGZsdGZzSU1T?=
 =?utf-8?B?U010bkxENFZrMUdzblA5dWpiRFlhTFRqaFM0bEQ3SGpTTzRkWGt3Nm0vdEx1?=
 =?utf-8?B?Wm05WnZCdytVZHdLMnlTU3NDcFV2WFl3eHo0Z09sZUJpYlpyZTZkYUtJMFlL?=
 =?utf-8?B?SGFPTGx2T0JZNWNDZGJuV3RWVjdWcGJ0UlJHaUVrUGprS3hDUVQxb3VDdmlu?=
 =?utf-8?B?SlBUTWpyVWRYYlR3S2FkREV6cmt4ZjNxNzFsZ2lNdEp5bFFsOGZySUNyODNS?=
 =?utf-8?B?eFc0TFl1QlZUTkMwR0VyMkhIdmx5REdxanBGZ1lYZjY1K05jdFN5cmZib3Z0?=
 =?utf-8?B?T2Z0OGo4SWNESWJDM1lqVEs4NlVhZTNSbnJWOHYvcExQQWxBOUluRXhwYUcz?=
 =?utf-8?B?eENFTURhZitYdlU2VC9UQTdmQ0JUWnc0Ulg4KzhDd3JKTXpDdlBSUjl1U1NH?=
 =?utf-8?B?UXIwdnhQRWJjbEFMa2dHb3NhV0t5YmExVEhSRnloaUd0ZDM5aGRGU3dCVVAy?=
 =?utf-8?B?empraDdzci9Ud0xhL2syQjhGTHhERDU5WHJnVUZ2VGhqU1dLZ3l3VE5rWXRM?=
 =?utf-8?B?T3ZNZWYzcWVIUFI5RWVFRktGbGkzSUkxcVVUd1B4RDBWYTRyb1MwUWptaVFx?=
 =?utf-8?B?UEdPbFNWRFZoaWVPY2FqejlVSDBYZHBOdVlFR3o0ajR6T1dvTDB0OFlpRWwy?=
 =?utf-8?B?NXJiWGlkQ0F1cDJYTCtEanpodnNUVTlQN3RwWDBaWEFFRXhwNG1tVEpydi9v?=
 =?utf-8?B?NEFJd3B4MlhmZXlQQzNyVTZzZStBNllWWGQ2ZnJ6dGNEYllBS3dpZHp0V2Zk?=
 =?utf-8?B?ME1rYWt2enR4dWM5WTF3YTMrRFFTQUUvdDBPckdMell5SWFVVTNaNWZlZkhN?=
 =?utf-8?B?aEZhM1JSd2loQi9YMnFnb21ja0FUNWg4V203WlMzSXJDUmM2UXZIRmhaQnQ1?=
 =?utf-8?B?L0FyNEZuMGJUM0FIQzZ3VXpkckNNSDlvTXlSandIV0Mzc3pjZDNkaWRzNjlz?=
 =?utf-8?B?NDRuOGwxVU1TRGYxOC9IaTFxN1ZjK2wzTDh3L0dFbkk2c1VFNGxKeDQ4elJO?=
 =?utf-8?B?RXE3cjU1YlUxRkt2WG9DSzZWNVU2SFhwTjdKOWx4OUtxb3c1cUk3WllWa010?=
 =?utf-8?B?am9HSm5UYkFrRCtsdWRlOHlZcUlTWXY1UElJUHRQaUQzQVhxK3d1d2dPaEMw?=
 =?utf-8?B?MnorbEZSR0RvUGtlUEpWamFWOC9zcUxURldyL3A4Wmd5T25JVWFlaDVLaXFX?=
 =?utf-8?B?ZWdFWGR4YjRIQjh6WG5yYmFHTXhQdzhmWlR4dlU0ZW96YW4rajBaRW9OT2No?=
 =?utf-8?B?aTdvM3ByejR5dXkxNXNMOGhudXhwWWVtZVEzdWwxTWpsWHlnaGFPOGZ6Q3dH?=
 =?utf-8?B?QzNLNlAyQUxRakpIbit6VHRyK1dJaUZZMGY3UTNZNUp3dWo3cEkxQmlsZ29l?=
 =?utf-8?B?b3g1RldNZVE3c21xSE90WC9nZU13UnhkQWp3dEVtZllQRmx1MkxqWTQ1WTl0?=
 =?utf-8?B?UkFpWHI1K1VvVTZORXRaRFhSYUwzeFgzZmF6YjBsZnd2TkY0anpBQkFKOXBD?=
 =?utf-8?B?RldyblBQMWU4SzBHY2FiQWlFNkJOc1BiQU50cytnMEJac2hqM2RJZC9kWkRi?=
 =?utf-8?B?QmRxMnBnbms1TUFYUUlZVFlNaEdTQUdSVzJoSEhESVp5T3l0SDZaSXFJdGkr?=
 =?utf-8?Q?qWvg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbfb2a9-d39f-4823-af0c-08d9a9bb7c8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 11:14:56.6981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /27j56Usih9OYI1da6helxvHyZGKvwj/iRW5WyuxqIXojID7VshSkWZTcRz16doa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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



On 11/17/2021 3:41 PM, Stanley.Yang wrote:
> if smu support ECCTABLE, driver can message smu to get ecc_table
> then query umc error info from ECCTABLE
> apply pmfw version check to ensure backward compatibility
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 42 ++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  7 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 71 +++++++++++++------
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 ++++
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  4 ++
>   6 files changed, 107 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 90f0db3b4f65..6b0f2ba1e420 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -888,6 +888,38 @@ void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
>   	}
>   }
>   
> +static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_data *err_data)
> +{
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +
> +	/*
> +	 * choosing right query method according to
> +	 * whether smu support query error information
> +	 */
> +	if ((ras->smu_version >= SUPPORT_ECCTABLE_SMU_VERSION) &&
> +			!smu_get_ecc_info(&adev->smu, (void *)&(ras->umc_ecc))) {
> +

This version check should be in aldebaran_ppt implementation. In general 
the callback will check the FW version that supports ECC table for the 
corresponding ASIC. It may return ENOTSUPP or similar if the FW version 
doesn't support ECC table and that may be checked here. Keeping 
smu_version in ras context is not needed.

> +		if (adev->umc.ras_funcs &&
> +			adev->umc.ras_funcs->message_smu_query_ras_error_count)
> +			adev->umc.ras_funcs->message_smu_query_ras_error_count(adev, err_data);
> +
> +		if (adev->umc.ras_funcs &&
> +			adev->umc.ras_funcs->message_smu_query_ras_error_address)
> +			adev->umc.ras_funcs->message_smu_query_ras_error_address(adev, err_data);
> +	} else {
> +		if (adev->umc.ras_funcs &&
> +			adev->umc.ras_funcs->query_ras_error_count)
> +			adev->umc.ras_funcs->query_ras_error_count(adev, err_data);
> +
> +		/* umc query_ras_error_address is also responsible for clearing
> +		 * error status
> +		 */
> +		if (adev->umc.ras_funcs &&
> +		    adev->umc.ras_funcs->query_ras_error_address)
> +			adev->umc.ras_funcs->query_ras_error_address(adev, err_data);
> +	}
> +}
> +
>   /* query/inject/cure begin */
>   int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
>   				  struct ras_query_if *info)
> @@ -901,15 +933,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
>   
>   	switch (info->head.block) {
>   	case AMDGPU_RAS_BLOCK__UMC:
> -		if (adev->umc.ras_funcs &&
> -		    adev->umc.ras_funcs->query_ras_error_count)
> -			adev->umc.ras_funcs->query_ras_error_count(adev, &err_data);
> -		/* umc query_ras_error_address is also responsible for clearing
> -		 * error status
> -		 */
> -		if (adev->umc.ras_funcs &&
> -		    adev->umc.ras_funcs->query_ras_error_address)
> -			adev->umc.ras_funcs->query_ras_error_address(adev, &err_data);
> +		amdgpu_ras_get_ecc_info(adev, &err_data);
>   		break;
>   	case AMDGPU_RAS_BLOCK__SDMA:
>   		if (adev->sdma.funcs->query_ras_error_count) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index bcbf3264d92f..3f0de0cc8403 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -322,6 +322,12 @@ struct ras_common_if {
>   
>   #define MAX_UMC_CHANNEL_NUM 32
>   
> +/*
> + * SMU support ECCTABLE since version 68.42.0,
> + * use this to decide query umc error info method
> + */
> +#define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
> +
>   struct ecc_info_per_ch {
>   	uint16_t ce_count_lo_chip;
>   	uint16_t ce_count_hi_chip;
> @@ -375,6 +381,7 @@ struct amdgpu_ras {
>   
>   	/* record umc error info queried from smu */
>   	struct umc_ecc_info umc_ecc;
> +	uint32_t smu_version;
>   };
>   
>   struct ras_fs_data {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 0c7c56a91b25..2c3e97c9410b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -97,28 +97,57 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   
>   	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> -	if (adev->umc.ras_funcs &&
> -	    adev->umc.ras_funcs->query_ras_error_count)
> -	    adev->umc.ras_funcs->query_ras_error_count(adev, ras_error_status);
>   
> -	if (adev->umc.ras_funcs &&
> -	    adev->umc.ras_funcs->query_ras_error_address &&
> -	    adev->umc.max_ras_err_cnt_per_query) {
> -		err_data->err_addr =
> -			kcalloc(adev->umc.max_ras_err_cnt_per_query,
> -				sizeof(struct eeprom_table_record), GFP_KERNEL);
> -
> -		/* still call query_ras_error_address to clear error status
> -		 * even NOMEM error is encountered
> -		 */
> -		if(!err_data->err_addr)
> -			dev_warn(adev->dev, "Failed to alloc memory for "
> -					"umc error address record!\n");
> -
> -		/* umc query_ras_error_address is also responsible for clearing
> -		 * error status
> -		 */
> -		adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
> +	if ((con->smu_version >= SUPPORT_ECCTABLE_SMU_VERSION) &&
> +			!smu_get_ecc_info(&adev->smu, (void *)&(con->umc_ecc))) {
> +
Same comment as above.

> +		if (adev->umc.ras_funcs &&
> +		    adev->umc.ras_funcs->message_smu_query_ras_error_count)
> +		    adev->umc.ras_funcs->message_smu_query_ras_error_count(adev, ras_error_status);
> +
> +		if (adev->umc.ras_funcs &&
> +		    adev->umc.ras_funcs->message_smu_query_ras_error_address &&
> +		    adev->umc.max_ras_err_cnt_per_query) {
> +			err_data->err_addr =
> +				kcalloc(adev->umc.max_ras_err_cnt_per_query,
> +					sizeof(struct eeprom_table_record), GFP_KERNEL);
> +
> +			/* still call query_ras_error_address to clear error status
> +			 * even NOMEM error is encountered
> +			 */
> +			if(!err_data->err_addr)
> +				dev_warn(adev->dev, "Failed to alloc memory for "
> +						"umc error address record!\n");
> +
> +			/* umc query_ras_error_address is also responsible for clearing
> +			 * error status
> +			 */
> +			adev->umc.ras_funcs->message_smu_query_ras_error_address(adev, ras_error_status);
> +		}
> +	} else {
> +		if (adev->umc.ras_funcs &&
> +		    adev->umc.ras_funcs->query_ras_error_count)
> +		    adev->umc.ras_funcs->query_ras_error_count(adev, ras_error_status);
> +
> +		if (adev->umc.ras_funcs &&
> +		    adev->umc.ras_funcs->query_ras_error_address &&
> +		    adev->umc.max_ras_err_cnt_per_query) {
> +			err_data->err_addr =
> +				kcalloc(adev->umc.max_ras_err_cnt_per_query,
> +					sizeof(struct eeprom_table_record), GFP_KERNEL);
> +
> +			/* still call query_ras_error_address to clear error status
> +			 * even NOMEM error is encountered
> +			 */
> +			if(!err_data->err_addr)
> +				dev_warn(adev->dev, "Failed to alloc memory for "
> +						"umc error address record!\n");
> +
> +			/* umc query_ras_error_address is also responsible for clearing
> +			 * error status
> +			 */
> +			adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
> +		}
>   	}
>   
>   	/* only uncorrectable error needs gpu reset */
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index ea65de0160c3..7a06021a58f0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -1404,6 +1404,7 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable);
>   
>   int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
>   		       uint64_t event_arg);
> +int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>   
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 01168b8955bf..6340c079f35e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3072,6 +3072,18 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable)
>   	return ret;
>   }
>   
> +int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc)
> +{
> +	int ret = -1;
> +
> +	if (smu->ppt_funcs &&
> +		smu->ppt_funcs->get_ecc_info)
> +		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
> +

Shouldn't return -1 if ppt func is not present. If ppt func is not 
present, that means this method is not supported for the SOC; return 
ENOTSUPP.

> +	return ret;
> +
> +}
> +

Probably the above function should be clubbed with patch 3 - smu support 
for getting ras ecc info.

>   static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
>   {
>   	struct smu_context *smu = handle;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 55421ea622fb..55ef10ca684a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -200,11 +200,15 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
>   	uint16_t smu_major;
>   	uint8_t smu_minor, smu_debug;
>   	int ret = 0;
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(smu->adev);
>   
>   	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
>   	if (ret)
>   		return ret;
>   
> +	/* record smu interface version, help umc query error method */
> +	ras->smu_version = smu_version;
> +

This is not needed. ASIC specific functions can check the FW version for 
ECC table support.

Thanks,
Lijo

>   	smu_major = (smu_version >> 16) & 0xffff;
>   	smu_minor = (smu_version >> 8) & 0xff;
>   	smu_debug = (smu_version >> 0) & 0xff;
> 
