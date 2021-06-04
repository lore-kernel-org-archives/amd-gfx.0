Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3FDC07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 11:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584126140C
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 11:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584126140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0746C6E33F;
	Fri,  4 Jun 2021 11:56:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65976E33F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 11:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iksfu/Ph/APgfLNLT77ljFqR5Mvo2OS5h3Y5cse/mC8HVfm2OvMa8hVVjjjD28AVB3DWdOK8pAXFj5GNeD5l37y96LbSIM1Z4gGjsGiZvBK9ArBJhE5gi3p3z4xhRVscWVH3no8pK4s05LbNzYpsVFOauTSee+p+3eidcxz5Qik2c//4QHjG/6GAIOR7q14aQq6/F9K+mOcs+V1qY7U5UC7Zh0j1/+C8l3KoLtOUiP3KmKym7W/977zAU915l/0lAPILX+k4LQgoKAQYgsYmBq3k5hIAsPtN1aRk+nilg/Wm77LSjY3TtWyLwQrZavSFazKHOFCqARbHFda1eZAI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzSqwwYeLUJ24QJkXViXMPnHiAD4HIj4VS8A1kKD9+w=;
 b=NcfCclh9xzBVpdSVJ8gylpk3zV3MMSh5LfuHcDPz3iCpNJWq0m6JpE7Gx9zT5qLIO02wO7sqlU3F61wot4LkuHpqhHCQbK6WU/OugAop41a9cVfscHiGV5Udx6nWHQSKUaC7N8ZSzVFKS0ej6KFifyL3PV6o5l93Ds/BgWIiPnMlPOBzKxpCjJ1ZcA10jbvZzbncnHNcmYXkZT9dOMYZJ6tVIXAhMk2BDjB47/gptcTtPmNo3ItixbllD+5YCRpAHsjZBXFQEoaSRxga9H9miKqIoKjsVcp4RxuqrK7XFTbdcLqi9Xl4zjaRgwB+YnZ5Hro1IfHy9nGuH0BURdGb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzSqwwYeLUJ24QJkXViXMPnHiAD4HIj4VS8A1kKD9+w=;
 b=m6+2saDOJJQ99sxQqWAl2I5mR5vFAxDvQK0lmhMuFSQoBbN4efEstH7WaoZBorI0pRo6FFt3cqI/Fg/8HCtkBRlXJiE0FSiPxCwuWqbPR+NyzxMFDPfKDf84RTTVtoRkSkU4/Rvim0nHG9xj1ox/nMIbEbhDxzdhNQtmtUm2J0c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 11:56:23 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 11:56:23 +0000
Subject: Re: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature status
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210604095823.1403271-1-evan.quan@amd.com>
 <20210604095823.1403271-4-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <83d7ff01-061e-707a-0774-fc29e05c2684@amd.com>
Date: Fri, 4 Jun 2021 17:26:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210604095823.1403271-4-evan.quan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: MAXPR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::34) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.250] (165.204.159.242) by
 MAXPR01CA0116.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.21 via Frontend Transport; Fri, 4 Jun 2021 11:56:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ae55168-3b26-4af1-1d2f-08d9274fc639
X-MS-TrafficTypeDiagnostic: CH0PR12MB5059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB505966B3DB6133645F0B880B973B9@CH0PR12MB5059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYFml09ug4wrz/91rpmGPcCEUFCVUyTEvygGrfZqfOtHx+IDiJVTH1ten3kLHagKB10f1YmJTbR6Lc/IJso3IxZ2ahgiKjDPt34hG0J2/EYdcxswyLk2BUUv1gqqcEv6K+ScdUOu+yLgqxf1h58kytnhQKM/Hg0ReLYCcIGYQsWe84C5r0mOC7Kfr7YCmbwyf6toJjegz0kLMetlhO+LJPe56/Z/lFH8ObQBKu8E8dkewnXRTzsTwHPrcT3Cn3Rg1h92OOiTmPEHqcG+XZv/cIXANioseo01f4WPkF6Q8SWXCt1lb8EJlyHoqWt5e0T89sC/j+Qh+AKgePXkSZ3kISHwTLAoqeqCvtNrSAGeYwMayWPluvxjSMsc0OrZ8j3pYyz0FJyE/ASwzXNt4xupyuIWhnkKxaPFgv3V+rSYZEuJ3+IM16xYLKRPiCKBYFxjhUrdHlWR07NUFOPb1ihP0bFLEH0bv4PxqaszzJ2804Cc9xjdHQxV0ikMlP6fAmSwdVUegm8ow/Tgx6os49fZ+lNX3hoh3NoRBV/JWphu3cg9ejtkoQJ+eklBlN/iq3W+8swLshCqBevHO8DzKcWmGiPaatx3mgNMwq4eO7Yu7WMurgmWxApCLQOPSnWfxqFYLDqQrhjCyYlRzSeox9HCI2BXJsXMRzupmxGrmGsb3BM2H7vbjoec6slehEpkh8WQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(66946007)(66476007)(66556008)(8676002)(6666004)(6486002)(2616005)(31696002)(53546011)(86362001)(5660300002)(31686004)(956004)(36756003)(16576012)(4326008)(38100700002)(186003)(478600001)(16526019)(316002)(83380400001)(2906002)(26005)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TWxUUUpCNGpVcHNFb2Q0YmJwNkZROUpiUi8rZUcrMUxEdDBwbEQrTU1zeVRM?=
 =?utf-8?B?ZVExVUNyN3BuaHNYTGZlUEZndlZQOGR0Uks0WWx1RFY2WUw1OFRhUTRsSXpo?=
 =?utf-8?B?cEh2cFpuOGdWWFJBdlVhUE4zT0M1cFNOTjQ0ZDJ2SkQ1ZjZ3TFhjaGpOcFAw?=
 =?utf-8?B?YzRNaHhkc1EwbkNHNWNIUnYrZXFtLzlPcldKa080NkFjaEJONDNDd1htaThF?=
 =?utf-8?B?TnNGMGV0UE9EMFJmeW9uZFcvQlU1bjQrb2pzbm1BSnc1cXNWTVg2bUxacDlD?=
 =?utf-8?B?K2NPTW1vajl2bXhLWFFkYmhwWCtTUDNSRnJ1Yk4wTmhvMGE5TFd5NHB3UDBp?=
 =?utf-8?B?T1NpZ1BHbDh4VWdmWTZYMis5c1duQW1KUGFxSFo2SzNHYnp5SjBCR3pSaEdB?=
 =?utf-8?B?czNxYlEya3Y0NndpREgxNmdVdjVrNlBiQzZ1cVUyOCs1a0JRM3JIajZzcHh0?=
 =?utf-8?B?UmljdXpzY3hCTlp0NkJKY2ZZcEZJQ051VzdqRXBwWkszMzllV3FIM3FnOE40?=
 =?utf-8?B?WktCeXdVNXBuRW1QMUJMVXhlbmZNZGFtRUViMTNNaXZEUnorUUh0bEJmWS9M?=
 =?utf-8?B?aW9UQWVkb2poR0lBcEVFQWtJbDJUZnpKU3U4bkRnZEltUFhuWWtGVVJ2cHo5?=
 =?utf-8?B?aVM4dXRIelQwQllpc2FaZWtZNEN1Sjk1eU9pRWJnTnJYSUpWeEJGZWlocjRW?=
 =?utf-8?B?STE0MkJGSG4zc1dwbmt4N09TK0FhK2JzVWRBNHA3OEFJcWZac2lYakFvWEM0?=
 =?utf-8?B?djgrVGxGWmtqRXZlMklaQ2hiTzRkUGtEYlcyb1NVdnEvS09jZDhMVXhWdEo5?=
 =?utf-8?B?VzYvSksvZWhQTnZRNStDeWhWd2NldWh4UzBlRXc3eWFZSStVNWdBNTA5b0Z6?=
 =?utf-8?B?b3NkaFdMdG00V2cwQ3M2SFlNVjZGWWRkMkJCSzJXUnhad1pvOTYyVmsyVUM4?=
 =?utf-8?B?ek5Udmt1elBzZkRxYy94VzBCNnJqYklIN01FL2hYVmdhaHp3SUtZK013bUpx?=
 =?utf-8?B?b01iT0lnNCtISENFTzZhZkxIMENuREdtamtWeDdmeFFLZk4zUm1TdDFmL1pP?=
 =?utf-8?B?dFNaMDhza1FMdE1ERXhnRjlESUp4L2RpRXFySWE5NTRtY1ByOGY5ZTIydzdO?=
 =?utf-8?B?MXRpQndtaXpzdDQwb3pFa1VyTTI2TG9yZUU5cmt1RGdYL28zNDBESEdyWnJ6?=
 =?utf-8?B?RVdVSHJTWDFZNWtBK3Z2Z3I2U3BnK0F4Y0ZDcGFsQmc4d21kSXU0cVBqcE5l?=
 =?utf-8?B?NmcvWTB3RE5BaG5sc3JyV09tRm1LRU1HZk41SkJJOFJINlJsa1NQZ2ZlbExu?=
 =?utf-8?B?dUNGZVNuRURranMrWnRXckxLTEtqamFPV0E2NUlMNnMvWEZtVUdXZXd4YXQ0?=
 =?utf-8?B?eHVvQjd4emRDM1ppU0pNU2kxb2dFbXRSSHhjSkpYc3hFMlpUVVNlcWtWWFdo?=
 =?utf-8?B?emVML2ZKdk16dWFncXhDWTgzb3JNaU1sdGxDem5jYTNLT3ZsMjFiTTdpV0pq?=
 =?utf-8?B?S1F5TTBTcFc2K3ozTitKSTZxMzRHclI3ZDZTaGZCQUhsdngzbGd4U0h2cEhn?=
 =?utf-8?B?TTF0S0NNYmVabklRWkt1RE50S091MWJmWWZmUnFnbDMzZ2RGcjdxU0ZFeUpH?=
 =?utf-8?B?dzhRWTBWTWFPcTZIL0lpM2VoSnVHSUt3bm94VGhpOHNPaUhmQ2ltTE9Kd1hv?=
 =?utf-8?B?d2c5TWY0K2hkdGZIY0NkYkxrSU5IS0NzZFljaFBjMFRZTkdWSkY2bDVBaFlr?=
 =?utf-8?Q?goeWmbj/EodJyac1hqLLLl7gUK8alDHS8dZJyCd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae55168-3b26-4af1-1d2f-08d9274fc639
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 11:56:23.5020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SQdwq3QCQTxZhOsiSELBtsmW4VWKxNVeDzmPrt7qDRUossdOJfnJToR8/uZds7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/4/2021 3:28 PM, Evan Quan wrote:
> For some ASICs, the real dpm feature disablement job is handled by
> PMFW during baco reset and custom pptable loading. Cached dpm feature
> status need to be cleared to pair that.
> 
> Change-Id: I9e37d80e13599833301c04711b097fb37c2e41f9
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
> V1->V2:
>    - correct the setting for baco bit(pointed out by Lijo)
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  6 +++++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 ++++++++++++--
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 25 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 +++
>   drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
>   7 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index fb7438224872..3f9b2a839a37 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -937,6 +937,12 @@ struct pptable_funcs {
>   	 */
>   	int (*disable_all_features_with_exception)(struct smu_context *smu, enum smu_feature_mask mask);
>   
> +	/**
> +	 * @clear_cached_dpm_feature_status_with_exception: Clear cached dpm feature status with
> +	 *                                                  exception to those in &mask.
> +	 */
> +	int (*clear_cached_dpm_feature_status_with_exception)(struct smu_context *smu, enum smu_feature_mask mask);
> +

Since this is a just a utility function which clears sw bitmask without 
touching hardware, do we need a ppt_func? In case that is needed, we 
already have this - smu_cmn_disable_all_features_with_exception. So, 
can't this remain as a standalone smu_cmn function which can be called 
from anywhere? Nowadays, I get a red alert when a ppt_func gets added :)

Thanks,
Lijo

>   	/**
>   	 * @notify_display_change: Enable fast memory clock switching.
>   	 *
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c9a31556e077..aba475d06507 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1352,6 +1352,16 @@ static int smu_hw_init(void *handle)
>   	return 0;
>   }
>   
> +static void smu_reset_cached_dpm_feature_status(struct smu_context *smu)
> +{
> +	struct smu_feature *feature = &smu->smu_feature;
> +
> +	mutex_lock(&feature->mutex);
> +	bitmap_zero(feature->enabled, feature->feature_num);
> +	bitmap_zero(feature->supported, feature->feature_num);
> +	mutex_unlock(&feature->mutex);
> +}
> +
>   static int smu_disable_dpms(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> @@ -1374,16 +1384,21 @@ static int smu_disable_dpms(struct smu_context *smu)
>   	 */
>   	if (smu->uploading_custom_pp_table &&
>   	    (adev->asic_type >= CHIP_NAVI10) &&
> -	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
> +	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH)) {
> +		smu_reset_cached_dpm_feature_status(smu);
>   		return 0;
> +	}
>   
>   	/*
>   	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
>   	 * on BACO in. Driver involvement is unnecessary.
>   	 */
>   	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
> -	     use_baco)
> +	     use_baco) {
> +		smu_clear_cached_dpm_feature_status_with_exception(smu,
> +								   SMU_FEATURE_BACO_BIT);
>   		return 0;
> +	}
>   
>   	/*
>   	 * For gpu reset, runpm and hibernation through BACO,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index afd4bd850c63..8c3ea20fb0f6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -3083,6 +3083,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.get_enabled_mask = smu_cmn_get_enabled_mask,
>   	.feature_is_enabled = smu_cmn_feature_is_enabled,
>   	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
> +	.clear_cached_dpm_feature_status_with_exception = smu_cmn_clear_cached_dpm_feature_status_with_exception,
>   	.notify_display_change = smu_v11_0_notify_display_change,
>   	.set_power_limit = smu_v11_0_set_power_limit,
>   	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b4a2bb0f3f4c..14a14c30ee5e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3886,6 +3886,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.get_enabled_mask = smu_cmn_get_enabled_mask,
>   	.feature_is_enabled = smu_cmn_feature_is_enabled,
>   	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
> +	.clear_cached_dpm_feature_status_with_exception = smu_cmn_clear_cached_dpm_feature_status_with_exception,
>   	.notify_display_change = NULL,
>   	.set_power_limit = smu_v11_0_set_power_limit,
>   	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 0ceb7329838c..b9c38abc9d37 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -594,6 +594,31 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
>   						   0);
>   }
>   
> +int smu_cmn_clear_cached_dpm_feature_status_with_exception(struct smu_context *smu,
> +							   enum smu_feature_mask mask)
> +{
> +	struct smu_feature *feature = &smu->smu_feature;
> +	uint64_t features_to_disable = U64_MAX;
> +	int skipped_feature_id;
> +
> +	skipped_feature_id = smu_cmn_to_asic_specific_index(smu,
> +							    CMN2ASIC_MAPPING_FEATURE,
> +							    mask);
> +	if (skipped_feature_id < 0)
> +		return -EINVAL;
> +
> +	features_to_disable &= ~(1ULL << skipped_feature_id);
> +
> +	mutex_lock(&feature->mutex);
> +	bitmap_andnot(feature->enabled, feature->enabled,
> +			(unsigned long *)(&features_to_disable), SMU_FEATURE_MAX);
> +	bitmap_andnot(feature->supported, feature->supported,
> +			(unsigned long *)(&features_to_disable), SMU_FEATURE_MAX);
> +	mutex_unlock(&feature->mutex);
> +
> +	return 0;
> +}
> +
>   int smu_cmn_get_smc_version(struct smu_context *smu,
>   			    uint32_t *if_version,
>   			    uint32_t *smu_version)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index da6ff6f024f9..12ad07132d15 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -77,6 +77,9 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
>   int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
>   						enum smu_feature_mask mask);
>   
> +int smu_cmn_clear_cached_dpm_feature_status_with_exception(struct smu_context *smu,
> +							   enum smu_feature_mask mask);
> +
>   int smu_cmn_get_smc_version(struct smu_context *smu,
>   			    uint32_t *if_version,
>   			    uint32_t *smu_version);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index 33101dc93bcc..b12dcfab55fe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -58,6 +58,7 @@
>   #define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
>   #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
>   #define smu_disable_all_features_with_exception(smu, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
> +#define smu_clear_cached_dpm_feature_status_with_exception(smu, mask)	smu_ppt_funcs(clear_cached_dpm_feature_status_with_exception, 0, smu, mask)
>   #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
>   #define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
>   #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
