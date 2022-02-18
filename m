Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD2CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 04:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F74010EC80;
	Fri, 18 Feb 2022 04:04:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3900F10EC60
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 04:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R66PndSDVmm8hvqkVUrZHOqYIetfkTrkSbXYOLDwvTs8RHUdRrfeIKuOx29Uczhgvb20LloFQb3rFcVAoGZYQjkI/imk13Dt+0HljiOKFxsMZ0HduqJ4u2Kjo7+mVkOfX2Pi1jLaZfYHGf35ErafUcXUNj6V2f4vKHXWPGvD9CFC+4Y8OgTHN6brsoXxm5NOqPdCvhkEGkQlCkkSSBdH3bU/cOsc7oZW35rMOL25Wj5PZvv99AFmpJhrNxy4MII4u330I687ernGi4tc+IvtpW9cO0viL3O9mEFqLLh4SwDuCPrzoIcoJqhCguWIqEXd9cHUuxwNjdHLnQHdRuXGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzTtEb1YwzoySaxpJ2oXq8ySKVP0f79wuyeGnwB16lM=;
 b=eu4A+Pf+Xjy/RFyAosbKy3CAjNBPNENtc4SJPkYXMw6Yj48DO9YYCkeIw0wU87WpzwLk/Zz3iTCf42G0n9VeGHgnHpGC/hf4574x9VltC87JPqo9xiGja7UTENWp9OswDcVnylPUDhDTYeVN7Yw2JsSOpIpYgnGoHj4MzuRWij1yKRe4bxX/1WtC8Si0LjogXIOkcLDOvFakru3XAFw9QeZfaMXsJtXUH2+PM+OhNVXekuiP8fl5zH7HbxI+Qs/NC3yRFCHzYRdiBcARC0LcEFBKBx9Aa1XHVu6agVZAnXnjibzll0mPI9RulHcP3W1538zq7feoGW1AF6wkiGt4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzTtEb1YwzoySaxpJ2oXq8ySKVP0f79wuyeGnwB16lM=;
 b=rDs+Kz85WMO3+yyK2HzL9VwPs3X15ZXK+3rI+dvoE3qCpSA9RFVOpSKQed7xPik2ry264IRDeH4zPJcHYYkMTQUQLpesgE7fTNlmva116OxHXTJhm0HcmDXmsiwW0oJhy2tipcy8PAZPX01rpIHwHr5pnF3oJ0n/OfTpn9jH79A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 04:04:55 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Fri, 18 Feb 2022
 04:04:55 +0000
Message-ID: <5db9229e-52c3-fc4a-f8b5-29a25366208e@amd.com>
Date: Fri, 18 Feb 2022 09:34:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1645156501-18317-1-git-send-email-Prike.Liang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1645156501-18317-1-git-send-email-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e63c133d-1d25-4bc9-fd19-08d9f293d225
X-MS-TrafficTypeDiagnostic: DM6PR12MB3180:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3180288F3F1EBB147F5DE5BB97379@DM6PR12MB3180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqnp8y0AAGzIz+ALe6mz7/7bSY/ySbQLqqfO6abFbDz1OYr8NibybV89wFWluMRQkRE/L4UHSHvJ2cTprLyNP5YaZ3YgZp07XlmtzL3LWtEQu07nY+I+o6E2pVC7QI4PyJnP6J3Q7YktIOgnIkU4WNv3joy/5eq0ORffsMpq8dRDPg9KyJlfwYT9JxoFSb2jLfK7usRF5L8S8UDelaRHhTf8w4ScSbIQm7p9yfXsm/T2YJquGFiyJ2a76tp0993GX04eWSrX8biohJTatbxagy37aVpBtucrjJzaRBppm4XrS+JOq3Bxhevrk+/oT5FdsLZiy53K61hDkvbrJq4MAD+F9ch5fHCSAttmJmgNOi1dNhQnLAeost67q15MISpWKWyVx574HBtnpxAsiWFn9yIQvDVASgxWgYxsSvqo961D2GpCBWFybDIHja+sL0p0MJRlO1VDOg1yicPiWw4bYmOAH2DRw2Inb0Ng4Fm7YdH+aEV2xSv529xYCe2Dgnm9JnM/SalvcxKPxu9RC5jm6p8op5drEjz+99wRn66km9IOkI48odfxNWLdoURS60xf3t6ZJqVUSD7126fsTI21/o5AQVQkuVMU8wzrNjKHtrlrEaNn+aAm5ny0IEvxmEXUj4CTornL1vngXUGxCYf2F1rIF4tBcPrpbQteBzMoUXOfkJ3QWp/fJfLqJlBtTvn8SiqpM4Nve2JRfmLTWLPtrOrMnLvC9biR0hjKk+qYS5TMZazK3bKFSZggcbRJS6ze
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(6486002)(508600001)(6506007)(53546011)(15650500001)(6512007)(2616005)(31686004)(316002)(8936002)(83380400001)(66476007)(4326008)(8676002)(38100700002)(2906002)(6666004)(186003)(26005)(31696002)(5660300002)(86362001)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3Y5TDJlejl6UUlrMjR2cVVIUXhreFBsa2w4bmZzZDRUdlhha0YzWXN2UE1D?=
 =?utf-8?B?YmUveWVQSS8zMDYzdzVyUFFORGllVDVlTm5BMkRobkVTNkxmWXg0N2lONU5D?=
 =?utf-8?B?ZU5ublBBNFdnaFhacks3ai95SldZamtCY2x4OFZTL25qVXpreGdnd0VrS3pD?=
 =?utf-8?B?amttS1FIbHNraUhENXNjWWN2S2h5Y3ZSVkJFUTY0eGgrVnBFS3pKUGxyV01S?=
 =?utf-8?B?c0hocGZmbmt4RStFRlFBN2ZBdkxrSVZMdHlTa3RjaE05dEgyUXU4aXhPR3h3?=
 =?utf-8?B?ay9mV1Zsc1Y3WmNMN1djdFNYcUFkYzFiSG1DYzhvYVFvangxN1NHSzdQL0I5?=
 =?utf-8?B?Smkza09NU0JEclhncjVLNENZYUpSRjBqMi9HTzl3TTFUdVRwVnlPS01BYU9X?=
 =?utf-8?B?Qmk2K1hmTzRBZlJPWFc5VjNrV2YwY3NSTll6eStVKzlEa0NQTjRQSzhTRGk5?=
 =?utf-8?B?aVVhUHE5OUJmWTNDR0M2SFlOS0R6bDg1d0xxNFdWck1oTk1jODd4TU1pRmc4?=
 =?utf-8?B?Z3g0bGF5UXRRRFZwb0trc1R0RzVqWU5VL05HMTNoQ0QvbWsxV1g4Y3NKMlZr?=
 =?utf-8?B?SUFKWExoUnlXQng0L2ROa2VTZGRObGNudEhJekRRaEN2Q1ZZNTdJZ2ZLdnE1?=
 =?utf-8?B?VDczdEpKSG5SMTRlVkdiSlBxbFhCS0JWV2dvc1NpalYweG5mMmRmaVp1d0Zh?=
 =?utf-8?B?MlRZRXBvQ3QrM3FhY2wxTHl2MzBEQndwYjBhMGVGN0dsR1AvdUlKak1KSnRT?=
 =?utf-8?B?RmlKalhEKzF6a2w1UWtyTlpFLzljVEJjOHoxZE9aVnZmalk3UnQwc3lpQmtw?=
 =?utf-8?B?UWhoK25YQXlnbFhTNG5JQWEySXE0M2dQc0xBQTVzUXdrU3hrQUdROUYxeEF5?=
 =?utf-8?B?M2EvZjdyR3Q1c0RXNHNYU29lM3JOcmpmZm9ldmhXYkcwem9UN0NsSzhnc0My?=
 =?utf-8?B?dGpuK0JWYzQvbkU2SWpxOFVHMFZDQ2pteHRsVFJtMGxza1hodEdOY0VZWnRB?=
 =?utf-8?B?TU5TKytqckJMTnMzUExJaFg4bFljSlpOUDN4eVcrcloyZVVUZGo2MVJhZWFr?=
 =?utf-8?B?aW1rN3oxL0Fxek9laElBeG05Q29wMmorSlFTWnBKalgyVlAySFVicWJqSW1q?=
 =?utf-8?B?QzAwdXdQV0VLYWJhL2YySi8rTG4yMTllSUJ5aEtJUFJYVkhUY0tua2pHV1hM?=
 =?utf-8?B?cXlQMU5LdkpRa1kyQWgvdWcxUER0emhtV0FkZmxsSnpibXFrRW9KVmVsbWJh?=
 =?utf-8?B?a1ZaRVZiTWJaaEVFMHJZZzJ1ck1yVERINE56QWVZZ2U0dEFXc3J4RkVqYXVx?=
 =?utf-8?B?T2ljSnJSK1NZKy9rbFZWSWhkWHg1d0xFcU5Idm5CL2hJYVhCZ2tyRnU3RWFC?=
 =?utf-8?B?Ym9OalZUWmErdGhUbGxFcmN3QWVVak8yVUhtSmROR2xla2RrV1pKaGtrbElq?=
 =?utf-8?B?YU51akpIUS9udlZSK3g2cndPTUo1d0NSSW5UV0xTakljQXU1UWhLSXo2T3NV?=
 =?utf-8?B?N3JNWW81UUF3NXZYNnMzQjJpWlZaTk4wZjdnRFFPTTJVanZJdTJ2MzFQb0sz?=
 =?utf-8?B?TVpXZVNVYjlHN3JrUjJyRlpWM0U3bmFadmxITzB2VzFlMERZQ2FWQ3lGYnc4?=
 =?utf-8?B?bWkyKzVGV0ViaDlVbnNaUEM0U3VuYmw1cSs0SjlyY3lKb3AyRmhsRWo1eFAv?=
 =?utf-8?B?UUtiTUVPaVo4OFJZZkRNT3Q2K1pkRVcyVHBnU2JWVzcxaXE3emlUeElBYVFB?=
 =?utf-8?B?d25Kckp4NTlHQU8rczVSY0pGWjdOblZ4NE1HMEdpYTVWWkxacFFadzVOblll?=
 =?utf-8?B?Y0VOZmRabFdadTdoRWZoTWtteGxNOVFyNUJsTVJyejR6ZWlDQm5kZWNmbzJk?=
 =?utf-8?B?L0dBN3Vua1lUbUFnU3Q5ZEE0ZkFtZDJ0NjB4UXhjcnExNHpKMGhjZldSRHBi?=
 =?utf-8?B?TTdnYTNJWGVIQXdOdmtNMFE3OWkvNU9kVmZOdHBrQjJGMkdCNGxBbFI2eVJP?=
 =?utf-8?B?VjRzb2g5MGxRTngzenBIeENJU0wva0p1M3pIZmhaK3ZGQ1RmYnREWERqREFY?=
 =?utf-8?B?dHpyUEZHYnZYVVVVVFNTM3JJSWhKaE5qTnVxOFpNeXBBYWN2K0EwNEFvdzZW?=
 =?utf-8?Q?kr+4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63c133d-1d25-4bc9-fd19-08d9f293d225
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 04:04:55.3517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2xU1om1k0NIGw4by/FzyvTrhZLXBGDVIS+wug8+A8C6Ua8H8eeKXyO4t+guT8Uo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
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
Cc: Alexander.Deucher@amd.com, Evan.Quan@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/18/2022 9:25 AM, Prike Liang wrote:
> There's always miss the SMU feature enabled checked in the NPI phase,
> so let validate the SMU feature enable message directly rather than
> add more and more MP1 version check.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 28 ++++++--------------------
>   1 file changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index f24111d28290..da1ac70ed455 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -552,10 +552,9 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
>   int smu_cmn_get_enabled_mask(struct smu_context *smu,
>   			     uint64_t *feature_mask)
>   {
> -	struct amdgpu_device *adev = smu->adev;
>   	uint32_t *feature_mask_high;
>   	uint32_t *feature_mask_low;
> -	int ret = 0;
> +	int ret = 0, index = 0;
>   
>   	if (!feature_mask)
>   		return -EINVAL;
> @@ -563,12 +562,10 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
>   	feature_mask_low = &((uint32_t *)feature_mask)[0];
>   	feature_mask_high = &((uint32_t *)feature_mask)[1];
>   
> -	switch (adev->ip_versions[MP1_HWIP][0]) {
> -	/* For Vangogh and Yellow Carp */
> -	case IP_VERSION(11, 5, 0):
> -	case IP_VERSION(13, 0, 1):
> -	case IP_VERSION(13, 0, 3):
> -	case IP_VERSION(13, 0, 8):
> +	index = smu_cmn_to_asic_specific_index(smu,
> +						CMN2ASIC_MAPPING_MSG,
> +						SMU_MSG_GetEnabledSmuFeatures);
> +	if (index > 0) {
>   		ret = smu_cmn_send_smc_msg_with_param(smu,
>   						      SMU_MSG_GetEnabledSmuFeatures,
>   						      0,
> @@ -580,19 +577,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
>   						      SMU_MSG_GetEnabledSmuFeatures,
>   						      1,
>   						      feature_mask_high);
> -		break;
> -	/*
> -	 * For Cyan Skillfish and Renoir, there is no interface provided by PMFW
> -	 * to retrieve the enabled features. So, we assume all features are enabled.
> -	 * TODO: add other APU ASICs which suffer from the same issue here
> -	 */
> -	case IP_VERSION(11, 0, 8):
> -	case IP_VERSION(12, 0, 0):
> -	case IP_VERSION(12, 0, 1):
> -		memset(feature_mask, 0xff, sizeof(*feature_mask));
> -		break;

This is broken now as these ASICs don't support any message. It is best 
to take out smu_cmn_get_enabled_mask altogether and move to smu_v*.c or 
*_ppt.c as this is a callback function.

Thanks,
Lijo

> -	/* other dGPU ASICs */
> -	default:
> +	} else {
>   		ret = smu_cmn_send_smc_msg(smu,
>   					   SMU_MSG_GetEnabledSmuFeaturesHigh,
>   					   feature_mask_high);
> @@ -602,7 +587,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
>   		ret = smu_cmn_send_smc_msg(smu,
>   					   SMU_MSG_GetEnabledSmuFeaturesLow,
>   					   feature_mask_low);
> -		break;
>   	}
>   
>   	return ret;
> 
