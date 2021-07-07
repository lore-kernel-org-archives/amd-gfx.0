Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328DCC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8BD61CAC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8BD61CAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48C46E85B;
	Wed,  7 Jul 2021 09:11:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6266E85B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 09:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8N8sx2nkBxRAU+Dqpzkg/jCen47dx/J6IJrZoqu05+YdJk3LzautCY1S7xH2bZyv/ZjcbVP80VsoXHbVRpzovkCrPYbCSLUWkUwKLUB/H8F4IrN9UUMP5uDF22s7OjP8Rn8IecQ9Ekps3vw/5pdlAepEBshvY6kyLKLMkHJWjmWa/+TtQWvys3I0Ue//KrYDqlrp6HjoPN5R5Aihn2Hqz5tYX7QkiTxXnyb3wYYheYwVnULcCuLW3Dko15Vk0GSxO2ybRbUyOy0iam5VzcC7hkBZ23DQCuEae/1TK46sqbGM74FrCKhdh23lYTJX52t0IxG/gdHPr36kGri03KFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66JQ4qdS6i9qnb1LmC51qiRTTalXH3j0CY6QyT6hk2w=;
 b=djV+6mO7i6MLl42iGmWiZ8vBQ1m3oFf2v15MZxSxD2JixUR7XmHP+xBm8xPAfXtltb06Eu1C9AvQTglOgodW42xUPywCcr1758CaByzinrlcFPIArHKEh49Gvr4Xo+0bEFNfUD2yaa4YXE+NiXbnfklIMc8zsyUHVmnqetNBgvWcw3tKykmCtNC5vDil3mh1JaQOMQToSNs6TcCUinbfiMVNTWGPMUFzS+ehC52xW7hWWgRKlyp58BPjrUiE7cAgXfFYZSr/YExeTMlVtE5897Nm1Y19bkPtryusylSNBj4dODX755sESCIpAOlKurUMTM7eTA8Ihwxt0vFCCYug5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66JQ4qdS6i9qnb1LmC51qiRTTalXH3j0CY6QyT6hk2w=;
 b=N+fKtKLTV3QI+l/C+XJcmHtFduoQ/Err+0sM058BMQkW/bzvgDreWmEb6/UoiXRbv78kaNTItWuQHpds90km+Wu1sYvbJBDTkRERnL3fy3XeTHUywE6l0HwJPv5dMc9qQeys2YzJ/ShQztPolO7VTUpHDZtTLnbLNqHbo5XH850=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 09:10:59 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%9]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 09:10:59 +0000
Subject: Re: [PATCH 7/7] drm/amd/pm: correct the address of Arcturus fan
 related registers
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210707015647.139127-1-evan.quan@amd.com>
 <20210707015647.139127-7-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <fac951f5-3fa7-819f-cd18-69a279f4dc77@amd.com>
Date: Wed, 7 Jul 2021 14:40:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210707015647.139127-7-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 09:10:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bad3bdd-30bc-45d5-3eaf-08d9412722f5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5386EEC84D62B2134C7C52A4971A9@CH0PR12MB5386.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgzqsO+tqMzzwtqQslrORZs9tqcvGJwmabcJcRq7NGhVV2G80W+b565uUwmSLSko0UgpYhTyCohcN07UVsT5RVl8YWKxPh6JizXMMmhocoxsldefBDbeAg+AuKrr3GRg5v2gbJm10df/4UjM8vdoHg+a4vgm/CDeakWFgUeryvzTF3h1o01jJCv/MhBFOOovVK3lZ7koFkuJRPkyqx6WGeoVgqHrC4rsFG9VbTJXoaPJVMp1Noh4bos2CxWIjkmXQKACwUjQVNJq3b5nqRwLRU7OGmBZrmV/FgDcUc9cEY8tEKIZtvirkkPSIizdyb9AOW0oAJ0OJXZ/PF4PkdO9+7cTFxxFmy7nrwUnwmM/+Yt7FjMoXsM18PGr09EBEO07cFYF3u+s7bLcVKCdJUgikkKPh8U6UCAR6ZhMzVHO4FLkLZWww6LbI26UvGUfx/G4537uSY9YiW6VXD4JeCT0dP8ZaZELx3cQ6CXSmTB6kA0h+Gt2P8EQI44e38CzAfm9FdSt8Yx304KFkU3qfQx7oHs9EIm7PpCNiG8dv7ULiXvNpu1Eaw0T7CEHCtjJLWEhVVxQQyA9sVMD0skoQxecAUJ77On32o/Ox3JXsuCEpmpyZKakUkA9mJDgwgfus0cSxjeLAhAIF4i99a6i2AnkW/qzA/f0Vd6mpgetbNFNog8wa0X8M0UyzGtY9R+srINoXusjIfxrmpuV1jmUqbEREiAyN1sqcsSvIlU22IFtayU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(956004)(2616005)(186003)(5660300002)(66556008)(66476007)(31696002)(66946007)(38100700002)(6486002)(8676002)(26005)(53546011)(31686004)(478600001)(86362001)(8936002)(83380400001)(4326008)(2906002)(36756003)(6666004)(316002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZ4dzlpck14cWVxMjFuVDVEMTQxSU93RUtzMDA4Y3grakFrUE1SN3oxTXRm?=
 =?utf-8?B?bHdvNjNPVldUSjVka01RUzlEM1RtVzkvNTJqK0hSSDF0TXY0aitaZ3UybktZ?=
 =?utf-8?B?Y20rMUxnS3hoMG14d0RLZmVyQW5vQWJUNm1Tc0xWQUcxa3FDSTdSZWtIbVNw?=
 =?utf-8?B?Y1FwcDlpbXVWRmJ5ampKeDFZMVA4SUJCNFkzeHFBWEFSTnI5Wm1XOTM2bnZ4?=
 =?utf-8?B?RVBKTVk3bjhFZnQwY2F0RGJEdDROUjBwRVdxdkV6TDJrcjM3Y3owcHd3Ymcy?=
 =?utf-8?B?STl6U1Jva0h2Q3FGOUxrVVNIODd6VmNtNmRKd0ZiVkxvWnM5dGtwKzlzb2Zy?=
 =?utf-8?B?R1pwcjVIdGVYb0lmOWZuLzFlS20rQkpCVjA5eEZsT1l6Z2hxbWFBN2xoUmpW?=
 =?utf-8?B?d1FmeXVOMTlCNGd1Z2lNRm9BeTYxdndTMG1VbzhIN1ZBdktkMEgvNmdrZEx5?=
 =?utf-8?B?RUJxeVZYNGg5NVpwQXNNaE9nU3NyUEx1V1dOVHpFSVk1YXN2NHpDaG1DQU5N?=
 =?utf-8?B?N0p0akp0c0RRam1KUG5aQkN2enYxUVl0SXJFeC9CdFJOZDdGNTUxSFUzS1RG?=
 =?utf-8?B?Tk9OaVN2OCswOGFBL1cybzZFcWx6bjZtZ1l1bXdjeHJ6TzNycTc2VTEwSTlZ?=
 =?utf-8?B?L1psdm5RUUlOYnAvT3BJTklMNHhQOHErMHJKeklHTmhiWlJPVDBZeklkeTgw?=
 =?utf-8?B?QjVQSGQ5a3owU1FJYzY3YUxwR3hQRGtYVnFaaVp0S09lZ3g0NmhMckZndEtu?=
 =?utf-8?B?V1pXclFudkpRdkxqUlZYZE1WSU1wNUR6Q1RoVjVGMkNLbG1tajkyRmhyRmwz?=
 =?utf-8?B?RVNmN3h5MW5kQkh1Skpwb0ZRRGxFWGlRZ2c4cVNXeUVuaWtaWmZXRGNSTzEv?=
 =?utf-8?B?enlZazZ1Q2dxbWI5ZXZ4OFJOZkRHYlFpeVB3RWtqa0NPYmc0UTlkNC83SmRX?=
 =?utf-8?B?TGh6SWVveTA3QllXc3lEYm9Idk9BdDVnRTVlMllQcnZ2c3lmYnBpVVRVaXNx?=
 =?utf-8?B?ODU5VmU0WWZjZzE4cmpPUGE1MTZCY2ptU28wcmkyWHNZSk00TllSeUx2Tjgy?=
 =?utf-8?B?NWxseStDTmZkUy94ZStGYjRMQ09IZE53ODA4eXFoQ3ZPUGJLYjVRaDlNVjN3?=
 =?utf-8?B?SDM0RUtlZmdYajIzTExBamszODgxQmkxd0tzejluSzE0QmJvL2plZEZtcXhz?=
 =?utf-8?B?UTdINnoxZTRLTHVud3Avck01TnZkL1NJOHFodWVQaUk2dnM4ZEkzdHordFBk?=
 =?utf-8?B?S0oyMGtFVDdoRUpWY2FEcmQ3bWY4eEhwWldWZGhUNDNMdVNJRHRzeU9TYWNt?=
 =?utf-8?B?K25jWUV5azhqMFl3eUhISENmcnZRQXZuNkU0RkViK0JsSUc3VThPMFJWMUc2?=
 =?utf-8?B?V0hYN0R5UFJ4ZmpCNlpSVjZlWFhHL0lMaWpNM0IxdmZrY0hNY1BITktJY0ha?=
 =?utf-8?B?WVJCdTJ5TktDV1ROenBYRzNQQ2tCdy9pOTVMcmxkd2hSai8vRC9SNHMxVXAx?=
 =?utf-8?B?enlIZXozRDVRZU5LNEtIQ3EwWmpGWDgrMjdXUDVTTzdXOWwrNlg5a3hvZGhr?=
 =?utf-8?B?M25JVUw3bmJDd1AwN1FXaUNuV2Q3b2QxSmwralpLNDZiYk1zUm02VHhhSzNa?=
 =?utf-8?B?VC8zUzlnbzZDeitSek5KV000T282VmkxZitsRWxlMzBQUFgwUlIrZml5YnJl?=
 =?utf-8?B?M20vMVk5ZFV6aDllWjNqUHhVRytvcFBVN1l0Z2tKYWFvaTFILzFZTFVyYTNq?=
 =?utf-8?Q?SZbnPdxRLpozFQwlfQCqIZF0i4dFx5gTGLNgV3H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bad3bdd-30bc-45d5-3eaf-08d9412722f5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 09:10:59.7336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6caRKQVK9EiqByJahDRnZuVDJ+reWKuRYoc0xuN80j6JlkcYMYCOSCcu8h2zskOn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
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

Arcturus callbacks were dropped in another patch in this series. Instead 
of dropping, better to keep the callbacks and use the specific reg offsets.

Thanks,
Lijo

On 7/7/2021 7:26 AM, Evan Quan wrote:
> These registers have different address from other SMU V11 ASICs.
> 
> Change-Id: Iaeb0438331eed9b0313933da25622f8e4c048fab
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 104 +++++++++++++-----
>   1 file changed, 78 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 319bd7689df4..414c8674e32f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -79,6 +79,24 @@ MODULE_FIRMWARE("amdgpu/beige_goby_smc.bin");
>   #define mmTHM_BACO_CNTL_ARCT			0xA7
>   #define mmTHM_BACO_CNTL_ARCT_BASE_IDX		0
>   
> +#define mmCG_FDO_CTRL0_ARCT			0x8B
> +#define mmCG_FDO_CTRL0_ARCT_BASE_IDX		0
> +
> +#define mmCG_FDO_CTRL1_ARCT			0x8C
> +#define mmCG_FDO_CTRL1_ARCT_BASE_IDX		0
> +
> +#define mmCG_FDO_CTRL2_ARCT			0x8D
> +#define mmCG_FDO_CTRL2_ARCT_BASE_IDX		0
> +
> +#define mmCG_TACH_CTRL_ARCT			0x8E
> +#define mmCG_TACH_CTRL_ARCT_BASE_IDX		0
> +
> +#define mmCG_TACH_STATUS_ARCT			0x8F
> +#define mmCG_TACH_STATUS_ARCT_BASE_IDX		0
> +
> +#define mmCG_THERMAL_STATUS_ARCT		0x90
> +#define mmCG_THERMAL_STATUS_ARCT_BASE_IDX	0
> +
>   int smu_v11_0_init_microcode(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> @@ -1174,12 +1192,21 @@ smu_v11_0_set_fan_static_mode(struct smu_context *smu, uint32_t mode)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
> -		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
> -				   CG_FDO_CTRL2, TMIN, 0));
> -	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
> -		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
> -				   CG_FDO_CTRL2, FDO_PWM_MODE, mode));
> +	if (adev->asic_type == CHIP_ARCTURUS) {
> +		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT,
> +			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT),
> +					   CG_FDO_CTRL2, TMIN, 0));
> +		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT,
> +			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT),
> +					   CG_FDO_CTRL2, FDO_PWM_MODE, mode));
> +	} else {
> +		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
> +			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
> +					   CG_FDO_CTRL2, TMIN, 0));
> +		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
> +			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
> +					   CG_FDO_CTRL2, FDO_PWM_MODE, mode));
> +	}
>   
>   	return 0;
>   }
> @@ -1194,8 +1221,12 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
>   	if (speed > 255)
>   		speed = 255;
>   
> -	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
> -				CG_FDO_CTRL1, FMAX_DUTY100);
> +	if (adev->asic_type == CHIP_ARCTURUS)
> +		duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1_ARCT),
> +					CG_FDO_CTRL1, FMAX_DUTY100);
> +	else
> +		duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
> +					CG_FDO_CTRL1, FMAX_DUTY100);
>   	if (!duty100)
>   		return -EINVAL;
>   
> @@ -1203,9 +1234,14 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
>   	do_div(tmp64, 255);
>   	duty = (uint32_t)tmp64;
>   
> -	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
> -		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
> -				   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
> +	if (adev->asic_type == CHIP_ARCTURUS)
> +		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0_ARCT,
> +			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0_ARCT),
> +					   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
> +	else
> +		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
> +			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
> +					   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
>   
>   	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
>   }
> @@ -1214,13 +1250,14 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>   				uint32_t speed)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	uint32_t tach_period, crystal_clock_freq;
> -
>   	/*
>   	 * crystal_clock_freq div by 4 is required since the fan control
>   	 * module refers to 25MHz
> +	 * crystal_clock_freq used for fan speed rpm calculation is
> +	 * always 25Mhz. So, hardcode it as 2500(in 10K unit).
>   	 */
> -	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
> +	uint32_t crystal_clock_freq = 2500;
> +	uint32_t tach_period;
>   
>   	/*
>   	 * To prevent from possible overheat, some ASICs may have requirement
> @@ -1231,10 +1268,16 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>   	 *   lower than 500 RPM.
>   	 */
>   	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
> -	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
> -		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
> -				   CG_TACH_CTRL, TARGET_PERIOD,
> -				   tach_period));
> +	if (adev->asic_type == CHIP_ARCTURUS)
> +		WREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT,
> +			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT),
> +					   CG_TACH_CTRL, TARGET_PERIOD,
> +					   tach_period));
> +	else
> +		WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
> +			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
> +					   CG_TACH_CTRL, TARGET_PERIOD,
> +					   tach_period));
>   
>   	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
>   }
> @@ -1257,10 +1300,17 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
>   		return 0;
>   	}
>   
> -	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
> -				CG_FDO_CTRL1, FMAX_DUTY100);
> -	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
> -				CG_THERMAL_STATUS, FDO_PWM_DUTY);
> +	if (adev->asic_type == CHIP_ARCTURUS) {
> +		duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1_ARCT),
> +					CG_FDO_CTRL1, FMAX_DUTY100);
> +		duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS_ARCT),
> +					CG_THERMAL_STATUS, FDO_PWM_DUTY);
> +	} else {
> +		duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
> +					CG_FDO_CTRL1, FMAX_DUTY100);
> +		duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
> +					CG_THERMAL_STATUS, FDO_PWM_DUTY);
> +	}
>   	if (!duty100)
>   		return -EINVAL;
>   
> @@ -1278,7 +1328,8 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
>   				uint32_t *speed)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	uint32_t tach_status, crystal_clock_freq;
> +	uint32_t crystal_clock_freq = 2500;
> +	uint32_t tach_status;
>   	uint64_t tmp64;
>   
>   	/*
> @@ -1292,10 +1343,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
>   		return 0;
>   	}
>   
> -	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
>   	tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
> -
> -	tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS);
> +	if (adev->asic_type == CHIP_ARCTURUS)
> +		tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS_ARCT);
> +	else
> +		tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS);
>   	do_div(tmp64, tach_status);
>   	*speed = (uint32_t)tmp64;
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
