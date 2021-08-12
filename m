Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB80C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3820160FBF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3820160FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89906E069;
	Thu, 12 Aug 2021 09:48:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DCE6E069
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 09:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPjo0RRQXvpMbn0Tuz3oUFkYpDE9DWTxLbBz9bvrzt+D9j99wf4MrOXViN8/Z7tL0Qf6/TCsxw96P517ZFooHh9O1CnFaYJUnzDcDoOqhu2wYeKENUbAw1hrDX5gaI1NZHAJdmCcZtQv3e9kcPRD9wYzJ5Xxxt29L9WPhDuvAZa9ds+qjY3othawJIvBELPucRuYZtAegsOmPE4SEB+VXArlMSRFXpGDIZD7OzsSmpwkYyaHpjuxzHyYxSeFlSrqg8yF96NYj1FObfYeezsipXQr1u+KGf71RTObTKxneJ9mdGdsGwBjz6EfnkQWshxwTS7AIW3DrOaRDvgTm+i5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh9dkyWIX/iP8FmqErqk89Ag28EEuiqa7/7+pCCnZZc=;
 b=COLHPIj6ZxFKdQlKYW8+68m8bcKyoz7RnUQmCiEqgle0SgFQ11v/ciT7sdKyTnfzRZfkVmhSOei258mZwxAi+ykNV/XVlwSK64dRrUUO+fJZXSLRnwdm9nemkhkTB7L7SpeaZSz4U/0n2CgeAiNNM7gRfyQ5a0VqesBFtp7CXofdUDwDl2+VERfHd9nbobUJT6jBD55P/qmr8gyX1DlLSl9W/y+WWpk4sY3XjDD4hBYqGIRaD4TYcQp2YOx0ZnrFSAmZj8bbK6SlCVaVxe7efrP074uNVeHB4UaS/LqOzu/xlfRgjvVyOvqZqu5d1lTmTY33V3C3VN6Bi1UBxc/Kdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh9dkyWIX/iP8FmqErqk89Ag28EEuiqa7/7+pCCnZZc=;
 b=RylSQ278ak1oAwwpuhzIEXwhPfVqBvBgOT5DPMTplfODDQG8i/Z6IMYKOolS7QZyhbm2F8czwRmO51BlPYd2OhZ4Fy3t+Q4txUHOZTHoYE68jkPB76h2aR1UlbKVPB0X1bP0qfhqeKmWl7oHkQiCr0wz72WLCKGpwYACBJlLrRg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 09:48:45 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 09:48:45 +0000
Subject: Re: [PATCH V3 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: nils.wallmenius@gmail.com, Guchun.Chen@amd.com
References: <20210812093308.1322342-1-evan.quan@amd.com>
 <20210812093308.1322342-2-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <6bcfaa06-182f-9f19-f3f8-ab16b9265efb@amd.com>
Date: Thu, 12 Aug 2021 15:18:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210812093308.1322342-2-evan.quan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::33) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 09:48:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab98ef52-dd13-4cf5-6f9a-08d95d766025
X-MS-TrafficTypeDiagnostic: BN9PR12MB5178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5178FF3F27677DA07A6E000097F99@BN9PR12MB5178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APIFI2ZaDFhTlTTymrwiG7BJeP/0tNXCW6KsSoUxYZ94G3Mrl6ihzSmnvw6c3Q0iqnYAOk55v1AqESBvjZQhjTzV0lQnmSOI85eakwfhzwE+Mw6NizJgh6Gi+NeiYbHaaXCyjVrrIxjnqLGTtgWmBgjWeKusDJWJzFcvtfiLrhRMkpRq8tNc0LX0mpUfLuCaEeBGe6XGo59dS3vu1rQKtxea0Zcjs+Yc6uXdiaWJSli65RnDIekdKiGASpHVh7ty+wArpLkev3DU7q+bnrX5hez5i1AV1S7uaYeYqdkDPIjLbCYntYBCUnSHylXERcBLUW9X50Ry9CAMcGWf/jPiwTgesURtvR2iRigCSeRmiN6npOUA57oxE/et6bMCdg8Pn+Vv2Vq22lqnWzvidgUNNWkDgnXb4x5vXmZaAyxeLPS7o+E/kRr73+dxI6xiqp40E1DOthOr3Iy4wlpjbcnPwDfwyqOBqh4nV4uBn5Xf4X5WF8uQEpK6s90vOu08Rc0OVyhSgFW59wNShnJdUSMTAGc+mxJws5CXYkXLOm6V5gh94MTzh2e1xyZz2lbX6fKj3zM/L0xh9CPCgUV+PGpfCSXjft0lTSzXKJ04cG5RKOQNYnG4skXKXyQZN3HeFYRJ2FmBI+/16ZKrPkrlb+B6Z8uH2ho9pJ6zYGtZ4jMywcraMvaONGujExoltPhAri2c+1NNZc8jNmEklduhclwa4OfSFyEH5LnJSwFGvbHEVs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(316002)(86362001)(83380400001)(16576012)(478600001)(4326008)(31686004)(956004)(5660300002)(2616005)(53546011)(8936002)(38100700002)(66946007)(31696002)(6486002)(26005)(8676002)(2906002)(66476007)(6666004)(66556008)(186003)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emxCd2hmS3hMRkV4STRmQVlmSlJ0VUg2V2xDTTFZa0dnbXhJYllXQjZ6VDUv?=
 =?utf-8?B?NTVGVFY1WTA3K0dtMXJZZzBMNEcvMEtROGtrOGtNNmlWTU90b2Zpc2FHWkJV?=
 =?utf-8?B?OGpTUzJqREZveXllTEJCUEVRKzNLcVJPVW81YlRRWWV6dFU2MmlRM2J5Smd1?=
 =?utf-8?B?UUladnIrQy9OeXhkSCtVbkpCRkJSNVZpNkhTSGZQbkRFSWFWdFFWWExSOHhY?=
 =?utf-8?B?WXhNZDRzYWFQRW5UY0FGNkZPSlROTmt1MVh6WGRoVk0vb2YralFSUmthTW9V?=
 =?utf-8?B?MlQ0UXgwU0ZaMzBiN2JDMHlreGNrVHFnWFBrZTZKUTBFcVhwMncweFI0YXlY?=
 =?utf-8?B?Qll1MWFoVTF3dm9JZGtMcWI1QWk3RW5tUlYxZG5NakZ6N05pV3JTdWxuMDda?=
 =?utf-8?B?SFYwK0REWk5wYnJmZ0ptdmdPZVVJTVhwbXhiMmloM3ZTWnZhQXJ4cjJyLzMx?=
 =?utf-8?B?ZzI4d2dyK2tKQnJKZGFTV3V2ZEhyNTFoQVN3S2oyY3VEelExbWtYWFNRL0Ey?=
 =?utf-8?B?MXpDMjZFNXZiSHYyYzFibk91MVllalFtUHEvK21sU3BmMmdNbHV4aHlaQUky?=
 =?utf-8?B?ek5sb2xSajZabHpZc2IwVy9kcFRXNm5Wa0xYa1Q2U09YdWw0ZWhYQ25BamVw?=
 =?utf-8?B?cXlYeS9JU2kzaEFyRzRpS0JGaWtxT09hZ01WNGorZTZuOHFMeVcrTlVhenA5?=
 =?utf-8?B?eU15Y0FORHpoR1JSeHVOQU9henl5YzU3UFVKaUNXc1ZZVjVHYnd6Wnh5TWp2?=
 =?utf-8?B?eUJyOERDczZwUmN5V0lYc1dYc0dYelVqNWpFTDhJYVZJem5OV3BVSEZ4dXps?=
 =?utf-8?B?cm16RWVRZDlPQjRKV285Sm00U2hVU1dhOUQ2cllCeG9mQUtLR011cFlZMzJY?=
 =?utf-8?B?VTEzbGlLdkdrVUZVQjFINTR6ZTFqNEw2bHdEand0RlMyUXhVTWFQMXV0MSsx?=
 =?utf-8?B?RkRRNVBnWHBPRDI5b1ZnRERtNjhPRzhId2ZPTDE1ekpwK1NhaHFpL0E3czBl?=
 =?utf-8?B?N3B4S1hNY0tadXVVQTBHTjNhakhPeEthcWdLV1o1Qm1DdUY5bllWbkhLby9F?=
 =?utf-8?B?MENBMmswS01kZzBsbkMwV0xGSURMWE9keEI0YllOSHpuQ3Q4K1JUQUdvVVpt?=
 =?utf-8?B?TkZyMzRPK2s3OWUyVEtaU3llb1RCTnVYaTlTMVVzS1NXcVB2VEhxV00rTVBr?=
 =?utf-8?B?cldUQ2s4NnBpT2JGVXUwNUJaeTBMcm5ZZXd4Z2Rva3JoeDVYa3k1SzNGQlUx?=
 =?utf-8?B?OXpoMzlWQXorSmpBK0FvK3pPazZTWlpRL0FDSkNYMnppNUh1NThnNkZwMGZS?=
 =?utf-8?B?bTg1VmVEaDQrekhmVlBULzhIR0xuSWpueGV2Vlo1clZWYlNsZVNqcDJic0c2?=
 =?utf-8?B?U1pSNGZrNkdybzFvVXp5Um1GUjR5Zm5iYWtmWDZLNmZrWURXbzFnVHo4dks0?=
 =?utf-8?B?a0VBbDUvTUs0cWxnS0ZPSWlaaytQdS92RkpPVjFmUmZlNjI2SW5NRTU2TUk4?=
 =?utf-8?B?Q0VLVkkxLzVRZUlwMHhuMU16NE9sd2NVMUxPY2RyT1MrWFlQM3lRdUJnTVh6?=
 =?utf-8?B?QXlTUXZwSjNJaHFIdiswWEhncTBzSnpQRmhUTGZ3MitCOHpLN3g0Zk4zM29B?=
 =?utf-8?B?NWxWaFRaWUpreXlaZ3A5S3EzL0RZNzZZcmVib2pZWThsN0NqWEY3Sm5FRVBM?=
 =?utf-8?B?eDBMYkQ2cEdyanB5UXdhd0tPYXI3QnpaTDFWUXJkd1N5VVQ5OElyMEd1OWY3?=
 =?utf-8?Q?Y/9mX92ZTLL8lybe+GJ3ii/q1S4DBJoGOD/pSqb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab98ef52-dd13-4cf5-6f9a-08d95d766025
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 09:48:45.1002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR/iBS4L8r7klXrf8bxTpWliA9CSjekGxjkR4qrB5oSnGWPQhNOuyzs3Ux8kAB/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
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



On 8/12/2021 3:03 PM, Evan Quan wrote:
> As the relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
> PWM and RPM is not true for SMU11 ASICs. So, both the RPM and PWM
> settings need to be saved.
> 
> Change-Id: I318c134d442273d518b805339cdf383e151b935d
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2:
>    - coding style and logging prints optimization (Guchun)
>    - reuse existing flags (Lijo)
> v2->v3:
>    - disallow fan speed setting via PWM and RPM at the same time (Lijo)
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  3 +++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  3 +++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 30 ++++++++++++++++++-----
>   3 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 04c7d82f8b89..112ee5f5d855 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3174,6 +3174,9 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
>    *
>    * - fan[1-\*]_enable: Enable or disable the sensors.1: Enable 0: Disable
>    *
> + * NOTE: DO NOT set the fan speed via "pwm1" and "fan[1-\*]_target" interfaces at the same time.
> + *       That will get the former one overridden.
> + *
>    * hwmon interfaces for GPU clocks:
>    *
>    * - freq1_input: the gfx/compute clock in hertz
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 183654f8b564..29934a5af44e 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -34,6 +34,8 @@
>   #define SMU_FW_NAME_LEN			0x24
>   
>   #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
> +#define SMU_CUSTOM_FAN_SPEED_RPM     (1 << 1)
> +#define SMU_CUSTOM_FAN_SPEED_PWM     (1 << 2)
>   
>   // Power Throttlers
>   #define SMU_THROTTLER_PPT0_BIT			0
> @@ -230,6 +232,7 @@ struct smu_user_dpm_profile {
>   	uint32_t fan_mode;
>   	uint32_t power_limit;
>   	uint32_t fan_speed_percent;
> +	uint32_t fan_speed_rpm;
>   	uint32_t flags;
>   	uint32_t user_od;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index e33e67310030..39390bbb79e8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -413,7 +413,13 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   		if (!ret && smu->user_dpm_profile.fan_speed_percent) {
>   			ret = smu_set_fan_speed_percent(smu, smu->user_dpm_profile.fan_speed_percent);
>   			if (ret)
> -				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
> +				dev_err(smu->adev->dev, "Failed to set manual fan speed in percent\n");
> +		}
> +
> +		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
> +			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
> +			if (ret)
> +				dev_err(smu->adev->dev, "Failed to set manual fan speed in rpm\n");
>   		}
>   	}
>   
> @@ -2179,7 +2185,6 @@ static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
>   static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   {
>   	struct smu_context *smu = handle;
> -	u32 percent;
>   	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> @@ -2190,8 +2195,12 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   	if (smu->ppt_funcs->set_fan_speed_rpm) {
>   		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>   		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {

Sorry, another miss in review :) The above line should probably be -
if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {

Fix it while submitting. Apart from that, the series is

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> -			percent = speed * 100 / smu->fan_max_rpm;
> -			smu->user_dpm_profile.fan_speed_percent = percent;
> +			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
> +			smu->user_dpm_profile.fan_speed_rpm = speed;
> +
> +			/* Override custom PWM setting as they cannot co-exist */
> +			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_PWM;
> +			smu->user_dpm_profile.fan_speed_percent = 0;
>   		}
>   	}
>   
> @@ -2552,8 +2561,11 @@ static int smu_set_fan_control_mode(struct smu_context *smu, int value)
>   
>   	/* reset user dpm fan speed */
>   	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
> -			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> +			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
>   		smu->user_dpm_profile.fan_speed_percent = 0;
> +		smu->user_dpm_profile.fan_speed_rpm = 0;
> +		smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
> +	}
>   
>   	return ret;
>   }
> @@ -2604,8 +2616,14 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
>   		if (speed > 100)
>   			speed = 100;
>   		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> +		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
> +			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
>   			smu->user_dpm_profile.fan_speed_percent = speed;
> +
> +			/* Override custom RPM setting as they cannot co-exist */
> +			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_RPM;
> +			smu->user_dpm_profile.fan_speed_rpm = 0;
> +		}
>   	}
>   
>   	mutex_unlock(&smu->mutex);
> 
