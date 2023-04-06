Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50920C76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 14:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A5510E33D;
	Thu,  6 Apr 2023 14:05:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD3310E33D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 14:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPHTIXCDcm4jCsn25jo4QN10OR2N9xUm0uM6Ug7rXkIcmWzmr+/sZcAr+ubuOe+5LZ7XGJ7NJhTV8a+KmOaP75Xn8JQs2cxNuJ4NvAsJtCw3b2j0TAO/wqFmVJyshfaRMjSyBJdFaKA8z+uBlPnFWv/0yIp3hOxMWi5yddXNFNJGck+EN7MFSNqvkAh514LGqPyr1nvEznZLqZsNZQ78gp0C7PN76GVoof7Ex1oWDQR7BGL3Fldb2AemU8XgtpfA9ke90gmeT5Q82adxYxBqKLwQBG3NT9FIbGvirXUIrhSqFh8/kXXLlo7alnNX/GMQrlzoU/LwXmfzlS1JHbH3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq5GwSenB78TqL9d0owHCePXXSlwW0/Xazr/4IO+RuM=;
 b=e9kT6v088+OJiOshPUYnXg9QAEae2JR4UHy+B/elAO+HCz9VOOOejXify5+Z4QUIIOrFPeq+QutRG4DjMANJ/1uDbraWBT07ISdHpzQPYvKcl0l8QYDQ7C188lI395jfIMU9diMZFeBnnN/ljaEdCKX+vStO3P5er4jU5Uc2xL+hSAfi8bIWxzyeYuGVpMG//RlUryhcguZmZhzXUEGJ2v1otXO5wodtrY38EB0cBzOYAdKuFUaeznm5Qj8GY0QlMq/BmFnrII4fitXw6AABafUlPi6XYun1jW8a9axkvjNDyNWFF4aRGL5+R46EZ5fcJgHjgnl/9QUoWQLGco+sqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq5GwSenB78TqL9d0owHCePXXSlwW0/Xazr/4IO+RuM=;
 b=osPy89xOLefiWNf7MIKIF0RCotnt27h1W+iOVpB7GfaXwaYsSQeNFKG5wnsgqYxKlwwffkrEJ5+OeMeZusmh7lEAergnARIsmW/XsGDQwXwUrtSe1S38wbthcLAqCkDPpaRvZUYtO+PFoiAj6FWlDjkKuLGRIQiklgNNoT5P51s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 14:05:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 14:05:30 +0000
Message-ID: <3b45e949-e55c-46d0-a439-2f86b7073a0f@amd.com>
Date: Thu, 6 Apr 2023 09:05:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 2/2] drm/amd/pm/vangogh: Send SMT enable message to PMFW
To: Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, evan.quan@amd.com
References: <20230406124514.2906870-1-WenYou.Yang@amd.com>
 <20230406124514.2906870-3-WenYou.Yang@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230406124514.2906870-3-WenYou.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:610:cc::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e160e6d-3b78-4c6e-1193-08db36a7faf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUDSUqT/9npm/cP8iEM8nU2gactCgCxVSz4oqkx9OqO/+pvVtAcwsrb6taWt5hiwp3lsoih3PMWeQc+uiYPek5EjjKXnUmd7PggoRQpLZJmIPf7Isn7k41tWvVC7BdgJVdeY0OKqOpEG0LwMD3ktQbd+LmAThfFW9ggx7AlLyjO7fBSzBerB+HaxSBl5kpgjd410WEAzqHLAIJRUod+7eUYuKPedTEerFKEA0t4fo2iKTOfOQjD791luhCfJRX4YWgyglr6UfagX2GjOcQ26g4g18HnOJU+6VcuJ3EYF4CROeZ609oz17Bidsc+ofcLPJTZPZZhPX8BSBgGzH2p79erpEBlRK+NlpwkCS/YlVvcd2C5v2y8GIXcxSuyt3kq7i+/6IKsVW+R4c2/ybDvTWAie0YLokoak9qWW7AvMWVlc6jOfIDjIuV9REc+3Su2dnDq48a8uHi7uwdApsBLtcc70Jy0lTAR0hVAITzJUlBrmBAiG/10VDc8Z2KwEp13TyBWuJW9eBv8q87bw5CCeQODyPcBPY/5bdUySVuVz9seU5K9SeNadYSk1UoHUEc9X6rRlPEhCkTUmOwP5P9RdTdQLHpwPkdXjqIbi050W1II7hbpY9PWgHCGxVBVh2Zey25JwKPYCsZZ3OLGeIq7L6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(186003)(478600001)(6636002)(4326008)(8676002)(66476007)(66946007)(66556008)(5660300002)(316002)(8936002)(38100700002)(41300700001)(83380400001)(53546011)(6486002)(26005)(6512007)(6506007)(2616005)(86362001)(31696002)(2906002)(36756003)(15650500001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktOVHdKNk5XallERU4wZ3NoblNKODVUaER4bWNrTmhMdlVwQU5QV2dkUzRY?=
 =?utf-8?B?WG9pczQyZk40WTJjS0tGTHYvSmRPMFcwbUVHL3FqU3hDTSsxVVZaWWxYcnJp?=
 =?utf-8?B?N2wrVWRGcjBmQ0ZsUVR3bk4yeTlqSy9sbmFOS3dweU5SZGRvTThseXp0WUd0?=
 =?utf-8?B?TzdhZVF3dUFpS3dTRXNnNXEzalBrTDhkTVdsU1duZ2J1TkNJYUNJelE2UE1Y?=
 =?utf-8?B?dHVlMXlTb1hHTWpkb0d2ay9ndVNVZC83RGFzSnV4dEhmaE9Ga05tdUlNLzFP?=
 =?utf-8?B?NDB3SHo1dFR4M3VPN2FPVFI0aGZ2N01mMkZWUjF6cUp3WGFVVVByc3ZRM29E?=
 =?utf-8?B?ZUtwQTY3dkF1TTBEWDZzbjBVaUVwMnB3bE9jLzZMZi9VNFlLNC9oMFV0TlpJ?=
 =?utf-8?B?R1Q5ZWhkcU56SEx6UFc2YVNzVXJpQVpnZXJyS1ZaaFNoeU9HbWtIQ3FabjJK?=
 =?utf-8?B?SVlWM05sb1N2VkNYY1I0VkJUL2pZMGxNWFVOUklCYXZUbkRlM3FZeS9Cd2pl?=
 =?utf-8?B?d3Bzc1kxemZVS0hyUFR3Zk9aOTVSOCtJT0tyUW9USHZ2Y0tJWHV1eEw0bDdQ?=
 =?utf-8?B?Y3ZieWx6SUMzMHgwOEZGOWdtbTlyaUNFM1hLREpXQzNzaEJ4YlB1T1c0SVMw?=
 =?utf-8?B?M0JXNUkxalhpamIwMEZ5SFVIUExVRlRXdlB0cHBTQnR1aHJNTFljN2ZPdXRO?=
 =?utf-8?B?bTZ2YVBURUV4T25vSy9HQzdsN3ZhNTEwUEExTlc3UmFxTHNmdllvMFFZNjBX?=
 =?utf-8?B?NnVnZklmdUZCU3JZMnFSVllrTnhWdEdVT1VoOWVjWFZtNU1IdUhoMzBmM1hk?=
 =?utf-8?B?YXliSVFWajRSQ3U3cUoxK09oYnVTU3BNOUYzeE9zYzJQc1dQOXpGZlNZNWVn?=
 =?utf-8?B?QldEOTdNUWlwNk81alFKeFU2WUIxUkNna3FGM1AxOVNDTHQxUzQrMEtyRjQz?=
 =?utf-8?B?b25QMFY4R0pEMERYQzZyVnhwa25GY1J5S3FjQXV0VkJBSG5IN0pNOWRSRFZh?=
 =?utf-8?B?U2IweDJqNURNdkVqcW1hb1ZVQ1Jnd1FJdWlJWEptNWpWZkhJWTgrMEcvM3Vl?=
 =?utf-8?B?c1c0V2F5NG5yLzdtNmhkZ0J4cVlGM3ZIRGxEeUNBb2ZhcU1zcnNWWHoxUU5w?=
 =?utf-8?B?WjFlcjhMcFZoNUpnRjNybjY4RjZxb2NXS015K3BiVUlXdnhCcko1ZkZtNUxk?=
 =?utf-8?B?dTVVaXJkdW5vRHA5VkY5ckFpaFNuL29Yc2NpNVAwRERxZU5GK0ZFTWhWbHhL?=
 =?utf-8?B?SjczM0pudTIycitRSHBRWWRtUnR6V0xCWVJDUm5lTURpK1ozcEhVWlZUZzUw?=
 =?utf-8?B?SFhXd2ZjU0tjTlZNTTlyT2dheDU3aGVCaDJCSXJqVDBONGJmLzdtZHpDU2FF?=
 =?utf-8?B?RFZ0aWZSajJKRzRyc2NZZkM4N1JGSm9XaktpZTFHbEhQUHJqakRjc0NWczIw?=
 =?utf-8?B?cVR2ZWdjYWhpRk5BbU50OWlrbzE3MGxBMEJCK3VxUkw4ZVhxczJnTkxiaGhv?=
 =?utf-8?B?WEpibHYzN2JnRUt2ZEM4cmZaOVFtTlZEK0FCamtxbC9Pcms5ZFpNVWhiZm5X?=
 =?utf-8?B?ZDZvZE9YanZLSDMrejlwOUNtbnB4ZXp1OXFaTThKakpCdzd0REdZMmwxSEVs?=
 =?utf-8?B?VjRoM1Izc3U3SFAxWEdxTGZEMi9tSTNXWUo4emhIWFN0UDNOZGd1MGJvZ0Mr?=
 =?utf-8?B?TWdTbnloRUJHMnUrVXVKVkdKeWZKYWNkajFsc2J1WitJSVk5QjM4SUdqV0xC?=
 =?utf-8?B?TnR2SlBNQ1VRaXRpKy9mbUJKcHlxV0NHdExJaFMrSWUxc0Y1ZzJZLzFnU2p6?=
 =?utf-8?B?TW9nWWd6QVJVanRGR2xYNTgyT2lOZnhCenNVR2lFRVp1SVZpVERHL1BiYmNx?=
 =?utf-8?B?d0dJOWZ5VGgxeUluT0RKNTVhKzlVK3J5RDBOLzBtK2RYMkhpUFNpZ1I4S2JI?=
 =?utf-8?B?Z2pHYnh0TXRaK3o4UzVHQnhEcWxVQmpRS2N2OEowVnJ0aW1ma2JVazk0aUoz?=
 =?utf-8?B?VjNjNTg5Zll3MkNSanlIN2FIYW51UEdwVitRM0RaVzIzSEVEeVpEeW1ib1lL?=
 =?utf-8?B?VXJxRHZGRlB0Qkc2bzQrL2JWd2VMN08vSnBuRFp3VFc0eW1vU0MzYzNYaStt?=
 =?utf-8?Q?TjCYk3zaQ1/XhTH6KdYRyIksQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e160e6d-3b78-4c6e-1193-08db36a7faf4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 14:05:30.3182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7EWb9gRFtoXRJaKHIfHdVbagZ38d+qOJS+WEB+GBVDi1m8739qpd5JywWFSPBAJhpXz5Iudzbkbj/KP6TVgKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
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
Cc: kunliu13@amd.com, ying.li@amd.com, weiyuan2@amd.com,
 amd-gfx@lists.freedesktop.org, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/6/2023 07:45, Wenyou Yang wrote:
> When the SMT state is changed on the fly, sent the SMT enable
> message to the PMFW to notify it that the SMT state changed.
> 
> Add the support to send PPSMC_MSG_SetCClkSMTEnable(0x58) message
> to the PMFW for Vangogh.
> 
> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> ---
>   .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 32 ++++++++++++++++++-
>   3 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index 7471e2df2828..a6bfa1912c42 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -111,7 +111,8 @@
>   #define PPSMC_MSG_GetGfxOffStatus		       0x50
>   #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
>   #define PPSMC_MSG_LogGfxOffResidency		       0x52
> -#define PPSMC_Message_Count                            0x53
> +#define PPSMC_MSG_SetCClkSMTEnable		       0x58
> +#define PPSMC_Message_Count                            0x59
>   
>   //Argument for PPSMC_MSG_GfxDeviceDriverReset
>   enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..820812d910bf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>   	__SMU_DUMMY_MAP(AllowGpo),	\
>   	__SMU_DUMMY_MAP(Mode2Reset),	\
>   	__SMU_DUMMY_MAP(RequestI2cTransaction), \
> -	__SMU_DUMMY_MAP(GetMetricsTable),
> +	__SMU_DUMMY_MAP(GetMetricsTable), \
> +	__SMU_DUMMY_MAP(SetCClkSMTEnable),
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 7433dcaa16e0..ca1ff97f3353 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
>   	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
>   	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
> +	MSG_MAP(SetCClkSMTEnable,		    PPSMC_MSG_SetCClkSMTEnable,						0),
>   };
>   
>   static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
> @@ -460,6 +461,7 @@ static int vangogh_allocate_dpm_context(struct smu_context *smu)
>   
>   static int vangogh_init_smc_tables(struct smu_context *smu)
>   {
> +	uint32_t smu_version;
>   	int ret = 0;
>   
>   	ret = vangogh_tables_init(smu);
> @@ -477,9 +479,24 @@ static int vangogh_init_smc_tables(struct smu_context *smu)
>   	smu->cpu_core_num = 4;
>   #endif
>   
> +	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +	if (ret)
> +		return ret;
> +
> +	if (smu_version >= 0x063F0600)

AFAICT the value has already been looked up and you can instead use:

smu->adev->pm.fw_version >= 0x063F0600

> +		smu_smt_timer_init(smu);
> +
>   	return smu_v11_0_init_smc_tables(smu);
>   }
>   
> +static int vangogh_fini_smc_tables(struct smu_context *smu)
> +{
> +	smu_smt_timer_fini(smu);

Shouldn't this timer only be deleted if

smu->adev->pm.fw_version >= 0x063F0600

> +	smu_v11_0_fini_smc_tables(smu);
> +
> +	return 0;
> +}
> +
>   static int vangogh_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
>   {
>   	int ret = 0;
> @@ -2428,12 +2445,24 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
>   	return ret;
>   }
>   
> +static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool enable)
> +{
> +	int ret;
> +
> +	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetCClkSMTEnable,
> +					      enable ? 1 : 0, NULL);
> +	if (ret)
> +		dev_err(smu->adev->dev, "Set CPU SMT state failed!\n");

Given this is goign to be triggered by a timer, this might be best to be 
a rate limited message to avoid flooding the logs.

> +
> +	return ret;
> +}
> +
>   static const struct pptable_funcs vangogh_ppt_funcs = {
>   
>   	.check_fw_status = smu_v11_0_check_fw_status,
>   	.check_fw_version = smu_v11_0_check_fw_version,
>   	.init_smc_tables = vangogh_init_smc_tables,
> -	.fini_smc_tables = smu_v11_0_fini_smc_tables,
> +	.fini_smc_tables = vangogh_fini_smc_tables,
>   	.init_power = smu_v11_0_init_power,
>   	.fini_power = smu_v11_0_fini_power,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
> @@ -2474,6 +2503,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>   	.get_power_limit = vangogh_get_power_limit,
>   	.set_power_limit = vangogh_set_power_limit,
>   	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> +	.set_cpu_smt_enable = vangogh_set_cpu_smt_enable,
>   };
>   
>   void vangogh_set_ppt_funcs(struct smu_context *smu)

