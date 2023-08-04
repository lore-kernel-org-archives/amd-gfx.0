Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8192BC00528
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 10:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C272C10E6C6;
	Fri,  4 Aug 2023 10:34:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9FE10E6C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 10:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gou58GZjDvsnvjE2Z54habbuDGD6TYnSWDAOJZGk4ARuCn6VfC83Oh31Xxxh4+gEJv+oNIMd13FvmpOHFk7qduqmSvgSxBw3GIy9qlspC4w+6jTudtQiusg1aidWEi6LpotPlFhn92dk6KvuPUr6qs8fqvpTK8AsYC3GlXJ/4dA/JZ/1dfLTdnAMuBY+3QuaNo7Qw5s42U0FlD5iWcLa5fnpeHT9f5wkL4KcbI3Ocod3Zvl12Dsdi045mSSGI385HYcSp9a1ImLBWdJRlKWvPxqrO5VjYaIEdzIAItHw4mwHD/LKRJvvIn47vlGxEY015tPgr+R/FFiP2GWzwHBYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmx6RUO4RsUVZwd5gBaBiHL0HgvnQuMK614ZjiZ3f5U=;
 b=cSE4PTF2ON+SBzaXOxz+1qMP0+zoTFMBfKBUr9/NBqWBrXd8nIp06GvpNjS/lLdi0jwUuo7CQz7pm5z4asv3sopD3TPhyjCUeQL4HjbdBi2dandOOwt6VkNOlJ5lpqjsTkisRd4DYvLARcBCeWTNh6c12Wk4GO2H/d+GJVPU46TjVDE/PH0tO7/EpAX4TqAKwQYnmy6D6jpKXSemaQlp+DjlwJn+6ZLgUxVV72hnb1zx+rCsYtMl+YkTQwFcT6jV7zsrX7BVevds7DM44ZOl4lGOK0l1hUEG4fSnG1fuOUzx6j33Y+FKgRNzdjvT2vtPs3XcmX8oVA9R2U6gPKYpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmx6RUO4RsUVZwd5gBaBiHL0HgvnQuMK614ZjiZ3f5U=;
 b=DIR18dQvZDdyFAyvxPQNMj6+/gAxGGLPI4BQh8Kfe2W0cAqmVP6Q2Esia0fnQYVF73PDqu+NJws2nUCwH+POYLGN1nZ9nlev8jKeOi4mlkdlSv7B7xiZaazAYzV4ri8xcLvTJtQwuR05vzRqruKf77pcKhEn/NJnTYwl3xLjzjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 10:34:35 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 10:34:35 +0000
Message-ID: <7aa0c1b2-db02-5dd0-39a0-d08954ff07c3@amd.com>
Date: Fri, 4 Aug 2023 16:04:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: update smu_v13_0_6 message vf flag
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230804102127.1681956-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230804102127.1681956-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3f9720-e060-4411-4b77-08db94d66524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJP/hlU4BldV64hN/AL3dsau1PCnt3toZSgPYTBiAUV9qm+oFkrwH0QTm+uUtv4xsoSykwJYnJHQHTJ1bN4GSMjv8Lqs93UUDKW7iWIgIPCLZX+91qxqba/d6WHJVeRRnPnSYP+8b+k/Hx4Y8o02Flc537XlgQZk14QrwgIkoowjY+8r5O9EFfKnbf1ZCYVMFMJqsZMOnEEXN9Y8YU45X32KKtY+1Z/LsH97IydKujAwQ849coTPoYsbXYtAdnF4vjoO5VUH/YU0Jf7ipBu2Ks6bzPitkG9gem/QKpUGgqBkAhJbb8DML6yEapA7ENCSVUM8/2xw9p963PCuX175aqbbkCs6ZOgarcJBUEYIPuaYxRppbcdRhQit71OgQiqr9xq0lMLD6bFsdbcofW9L0qk4J8mVDLR/7XFpRG0+5+bKj1HxHSIXJ9HWNiZR+DgUukMaAFT/6uyMHZWyIKJHe91RvWRmYKvIMi5SgRD9QBauP+3o4lSD0AV2nfOEo1/Ht2dk4S11hS9OKhZKAXw7G7U5u4oG9nlNWPFVjuaR1HObpUVka9ieF75i6WiHA00n54TqejQsQQOlloB8YURC7+eZ7t4TnPoHxXepTY4gXywMT21psBTfenSVVdWunODRfLIH/hYVz2qTSRkIqcj1dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(1800799003)(186006)(316002)(478600001)(31696002)(2616005)(5660300002)(83380400001)(2906002)(86362001)(38100700002)(15650500001)(36756003)(6666004)(6506007)(53546011)(26005)(8676002)(8936002)(6512007)(41300700001)(6486002)(4326008)(66946007)(66556008)(31686004)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRBYjlUbVkxNCtOUzBRUnNsWjlnaHhiSHBHY1ZJRC9QZ2p5dnZNTkt1eitU?=
 =?utf-8?B?bEV4RGZObDM1Nk5kUEhNWEdYK2V0OVdRc0NiK3pNQXBKRmkwRytMOTVDZXRy?=
 =?utf-8?B?U3JXWGtLR1V4VW5uRExKdWdtUTBMMmlQNVUzbXRqQi82RXhMUTg2bXJCWjV2?=
 =?utf-8?B?SE96OE5OaVh3d1o5dlZGNExsczBPOGF3cTFLZ3FYUEwxcklScXNxNFBzbzNC?=
 =?utf-8?B?a3lQaUlZZkFVdHNlaDkzLzZoaDM0ZmVucEVDUURCekRZbFpvZjFBQ2JzcllH?=
 =?utf-8?B?K3dKYmQ0THU1WXlLT1hXd0dXT2xxSERvc2hrL1RsWFA1aWZsa0R2WU05ZzB3?=
 =?utf-8?B?WlZkbVBRVk9sYzZXQzVWRWt6SGRuTHRRcmYwbHBBeUJkYkxYeXpTUUtCTTNQ?=
 =?utf-8?B?VVdLczF4ZHZGSFk4MHdUcExQM2x4OXBUcjhFVTZHNGkyOVRmamlWaWpBbWRs?=
 =?utf-8?B?VVNGWGlyS24veDZuTVdSbERrRHFsRkl5YkxjOXg2TEh4bkhkeVN6aUFtcGkv?=
 =?utf-8?B?RWVKTEcyTWp1MWlSTVd2cEhpcTlxM3Y3ckVkYzNrTzFlQVRHY3k1Zlh4YUNr?=
 =?utf-8?B?YURqWHgxbG5DUzd4aDkvN3M4WWlPMjNscXY0TjVzb3VzcUI3dlN5Si8ySmlB?=
 =?utf-8?B?alhmYzF2VTFvTUw2bEFzQXJTNUJGN2d1d1ZVdTVkb2FxeFA1dXl4Rm5JSmJt?=
 =?utf-8?B?bnBQZitLZUJ1dlZnRk55WFl4ck1COEtPVmF2YkNtMDN1OEZZbGZHSjJrRFgv?=
 =?utf-8?B?TU16cGFpK0g4c3lNbDJTanF0RThzSVExL05hQXNtVGN3dXZBL1BXVVMvT1A4?=
 =?utf-8?B?SDBDcE0vYWI0a0o2enN3bHFoSDZKV3JDYnBQTE55OWhmSjVlTTMxekQzMXRV?=
 =?utf-8?B?M2sxWDRxb0NuWFYzdVdLb1NwSlk3Q1hwTk02ekEraU1wRjdDWTFPajBUUXZr?=
 =?utf-8?B?RWdoSldEbk14N3Y2OVJNdU9tZDZBVjl2cTZZbUp6aC94eWU0bUtONWZCTjFj?=
 =?utf-8?B?clAxMHZkMTBCM1JzNm9tRHhlNXFZM2UwYnFpRXd2eG9USk9qT25wWWNEc3J2?=
 =?utf-8?B?a0VIeEhJdUh0NER1NDVhZ08zZGs0QXRIZU1uRVkxZFFMYVM3Tmo5cDROMERU?=
 =?utf-8?B?RWRJbG5RQmRTRWs0N25kYURpTlllTFJDOEgrWERha2dsR0gwRHZIaHlVeXBF?=
 =?utf-8?B?YkszVXpwaWFrVWxKWDE1a2llY2hTdFpEMlVHNXMwY3JGdGJac3J0aVFHOGln?=
 =?utf-8?B?MGdVbnlSbzNvREpTaWZNRzloMGFvVU1yU0dqNjVGTUFzUkxpRjlGV0VTU3BW?=
 =?utf-8?B?a0FjNE9QVVM2MjFkdXA5c20zZm9wbzIyNjAxSlpoM0xrcXJSc21yRm5pQkR5?=
 =?utf-8?B?YUVWZzBocHV2dTFIeVpaeG5xVHJhM2MrbTJEODNQbldJcFlFRlJaMUhXRlVS?=
 =?utf-8?B?ZHc3Wk5ybmNLYlc4M0EyVXlXdEFPQ2x3RzQ5d2JMbk9JNkVBWkRGRGI1WWhv?=
 =?utf-8?B?VDMyWWFYN0Y0OTNINGcyVUYrMnNKcDEwWDhOakorNTFZR2JUQXFFZVhpdW5X?=
 =?utf-8?B?L3llV1VUbWxkRTNiZXFnMStDcGU5NHQ0TVFtS1dMSUF5QjZPclMrNkNHL3Y1?=
 =?utf-8?B?aW14OFhQYVJiZkJlb1BQOEI4UDZ4VnFCOXVNcHg2MVNRQzA1eFNUNUFUQXNE?=
 =?utf-8?B?WHZaVzFrQ3o1cjVTREtHaG5KYlhVN3JZQSt4bGV5SmtFQXlrQTdzOXJmOFZt?=
 =?utf-8?B?bDdYRXJQRnN3ajQ1UG1uTW8yVVFkWkp5NS81QVBLRUJlKzltNndqdnF4T1kv?=
 =?utf-8?B?U0tPcHQ4TldDdUYxUUFiUVVaRkdPZlY1S29SZzRyWFkrdUhEVE1ycDZxbFRL?=
 =?utf-8?B?Rjc3RTJtZzhIVy9FdUx0eDlPQ0Z2N1JYRmxJNG53eWttbTBHRVF4MEpTZ0ZI?=
 =?utf-8?B?VVJ5cWhqQ0p5ck5LQ2FHYzVHRkUzaDR4SDR0WC9zQXE2Ylp1QTlxWGZ2WUpZ?=
 =?utf-8?B?aW55d1Bza0d1K2tIa3pHZDV2QUh4SCttUjREQ1VtZHluUFhVT0ZZRW5DL1pQ?=
 =?utf-8?B?OG10SkJlajJBV1FBMGdpTVlhNDFyT2xnVmpUWGlzam00UGNZQndZMnVEZU9T?=
 =?utf-8?Q?Zc08Tn4Y3qmfN/ecdmv1d70Mg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3f9720-e060-4411-4b77-08db94d66524
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 10:34:34.9161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYonxnwZ/tqxhtWz9Ca/kxYR3DtMyyo95b9qLPqS4pO6sJX83Kxq65bicMzsB+S7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/4/2023 3:51 PM, Yang Wang wrote:
> v1:
> Enable following message in vf mode.
> - PPSMC_MSG_GetMinGfxclkFreqquency
> - PPSMC_MSG_GetMaxGfxclkFreqquency
> - PPSMC_MSG_GetMinDpmFreq
> - PPSMC_MSG_GetMaxDpmFreq
> 
> these message will cause pp_dpm_* device node not work properly.
> 
> v2:
> the following message is disabled in VF mode. (since pmfw 85.69.0)
> - PPSMC_MSG_EnableAllSmuFeatures
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 00eba3f950c6..c53c370d2a3f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -89,8 +89,8 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
>   	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
>   	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
>   	MSG_MAP(GetDriverIfVersion,		     PPSMC_MSG_GetDriverIfVersion,		1),
> -	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures,		1),
> -	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures,		1),
> +	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures,		0),
> +	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures,		0),
>   	MSG_MAP(RequestI2cTransaction,		     PPSMC_MSG_RequestI2cTransaction,		0),
>   	MSG_MAP(GetMetricsTable,		     PPSMC_MSG_GetMetricsTable,			1),
>   	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
> @@ -101,8 +101,8 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
>   	MSG_MAP(SetToolsDramAddrLow,		     PPSMC_MSG_SetToolsDramAddrLow,		0),
>   	MSG_MAP(SetSoftMinByFreq,		     PPSMC_MSG_SetSoftMinByFreq,		0),
>   	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq,		0),
> -	MSG_MAP(GetMinDpmFreq,			     PPSMC_MSG_GetMinDpmFreq,			0),
> -	MSG_MAP(GetMaxDpmFreq,			     PPSMC_MSG_GetMaxDpmFreq,			0),
> +	MSG_MAP(GetMinDpmFreq,			     PPSMC_MSG_GetMinDpmFreq,			1),
> +	MSG_MAP(GetMaxDpmFreq,			     PPSMC_MSG_GetMaxDpmFreq,			1),
>   	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex,		1),
>   	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
>   	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
> @@ -121,8 +121,8 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
>   	MSG_MAP(EnableDeterminism,		     PPSMC_MSG_EnableDeterminism,		0),
>   	MSG_MAP(DisableDeterminism,		     PPSMC_MSG_DisableDeterminism,		0),
>   	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
> -	MSG_MAP(GetMinGfxclkFrequency,               PPSMC_MSG_GetMinGfxDpmFreq,                0),
> -	MSG_MAP(GetMaxGfxclkFrequency,               PPSMC_MSG_GetMaxGfxDpmFreq,                0),
> +	MSG_MAP(GetMinGfxclkFrequency,               PPSMC_MSG_GetMinGfxDpmFreq,                1),
> +	MSG_MAP(GetMaxGfxclkFrequency,               PPSMC_MSG_GetMaxGfxDpmFreq,                1),
>   	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                0),
>   	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                0),
>   	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
> @@ -1386,6 +1386,9 @@ static int smu_v13_0_6_system_features_control(struct smu_context *smu,
>   	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return 0;
> +
>   	if (enable) {
>   		if (!(adev->flags & AMD_IS_APU))
>   			ret = smu_v13_0_system_features_control(smu, enable);
