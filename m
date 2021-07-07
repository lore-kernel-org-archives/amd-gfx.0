Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C09BC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3AF61C9D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3AF61C9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880F56E851;
	Wed,  7 Jul 2021 09:03:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5842B6E851
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 09:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq1rPgZCxOlGYfR5puvZx+/2Q/qLm8necA6L28Vth8we8O70+SLsPPR9U/R/XW1AplhrX87GIKOAtqXWOhe3zGDAQNA1gEXDv/ma9kwai1G4Md5lSpnST+1ywOefxq+TZB3CKMu1m1+IxdRAefy4imqZ6FvsfC2r9EfRS1MJeQbOfhKUBq84jx+LpRXGdDP7HrZM1rfSHWeGR1qo3Fts0pmTT34vHUYvP5ZVCmusHp65zLmGZjZOWdj7y40nlwGm9sjpcHXyUeejkjYWsGgAnqzoDcBXIOXALYLhTHncmFqJjlDGJvP9sJmnuOHIy9rdPbnpUDImx+ly0jM7NOVcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozwmRkhlmAxv/Xb38NrFh4CgO/Gb/fWTEWjXLYIgvuE=;
 b=D3WKIMoewhMCV0D5L9icH+nPA9eEy2VkmCGw6au2l7A8Vz/67RFC/B8gUpe30H4XUblKGw0nZ9wVbHc37efMLIsOLW66cLydC1ugTcoNrTXV3Em3VJtM5SqkZ8OgWeKI1i7on0K/MOACKXrLWHbtcHhbmnFJvu6ZipQwEjepWUpBfz2I20jLFGy1NjpIjWF7HVvC9WFgHSqcizsIui1qFUWkWiVDjkjhhCypCJlXHvSiKY5TLxImJDfWBdQWc1uxL2Bi4oMKI0TlIO1rhFmjJGYdNLQD3gCUdA8zr0ejDQ37GTTOz51esw72HTwjPbiAhwN5HzzjWTcXKb6GzyKiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozwmRkhlmAxv/Xb38NrFh4CgO/Gb/fWTEWjXLYIgvuE=;
 b=2gk5C2Rgk2tQ2zNsdgVcrffdQP86dDXU+3UwKM0aOnNoMumdbK88ZL6ioLqgoW1ayjbukbWSSjSTLasV3y0lGDwgW+3FZZw2RH2hoq/dWpJZgZNZISztmV9xa4VaRtynKinQ0SqdZgDFEzw2uOwfy+WjhBkeHkTRNdUlO1ujoE4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH2PR12MB5516.namprd12.prod.outlook.com (2603:10b6:610:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 09:03:47 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%9]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 09:03:47 +0000
Subject: Re: [PATCH 3/7] drm/amd/pm: correct the fan speed PWM retrieving
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210707015647.139127-1-evan.quan@amd.com>
 <20210707015647.139127-3-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <fb879ba3-fcd1-568f-20db-9dca580acfb5@amd.com>
Date: Wed, 7 Jul 2021 14:33:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210707015647.139127-3-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 09:03:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2994e5b-a34a-4994-494d-08d94126214e
X-MS-TrafficTypeDiagnostic: CH2PR12MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB55166DACA69E8631A4B78D5B971A9@CH2PR12MB5516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jx/zqOF4qOiJhwinMa1vP8bPcP+nbm55qrecq2O7gAAguXGPZMXN8zcN78XtsoQ3dmtqc5/mm2Z8e05tu0x2A7diZsFvPx4R4zaFPgbGPizuWSgxEiBUBg8A+q05haQjJpfLBvwv7zjUOLgkvIAkpQVAD7ynyx1+zw3nwMkoNJDxwQWC2Ie9sC1U3LOinb912v57qx6XSbswOAyE48EgVU1eHZMvKtyGvaqBu0G7PV+99Q2RUem3amxnXTh7gOguoI7kOFw0iU+c6tdzxtZtxbidfI67RSz9zEwKwnm9b211X97XtpPYJ9u/3O1tmELq3gjffp/NJtKuzAl43MKAE8+2PTnF4rYF5h/8rJNa0u3SUmbmc9gCEg7SiQvgQUKnEuyvaqr3/67+qQdlRZgCTeVybEvK0oNzHxQBwlbstn7d/JsNPsMSq07UauUHlmcJdEN7usmsEJcxu5UTAkqaenf/KD95MlFpZuvpLPqKaTwY+faFRZF2eH+1DOi872q2yyvmHzC1/hmvju445TplXsB1wn6r56oTZBsqEStb9/qnroy3qRvQaNRqR8P1dYi1/8x6x4yUw5P3AknMGdSZjq/RTmiXJ+MrobZ78GoyTFVfVvHhgtrrhIoM/J0gkRH1P7EFC8pOwR6fSBuMrUBp0v6elzTWsUeU/3zuw01M4yJiasJZwv+vZgejzEGCqw76cy3BIY+A6vM7JHuq8YekTnYVm4L25Wp/4+BDgJO8nR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(6666004)(31696002)(83380400001)(316002)(956004)(86362001)(26005)(6486002)(8676002)(38100700002)(53546011)(16576012)(478600001)(186003)(66476007)(4326008)(66946007)(5660300002)(66556008)(31686004)(2906002)(36756003)(8936002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElxLzE0SGhOV2tsZHN4UGhIeTlNYnVDTldnZjMvOUp4MnFjamZmZnZyOTBY?=
 =?utf-8?B?eVdwTGFMdThiak1QU28yZzBGRHBpb0NUV01UY29CZmFIdHprcXJVUzN6QlBy?=
 =?utf-8?B?N3ZRdFJpdi9GVGN5MytNVkFnRG1ESWxIWTZRUDFnemh6NXM2RXdSa1poWGd4?=
 =?utf-8?B?VjZQTllDd01JQ1h4RFRhaDNsZXZpYThuVThHTVRHM0hNK08rU3RGbDNJTU9w?=
 =?utf-8?B?UFQ5MElVNmJhK1hYOXNXa3Mzb1F5eEhpb0w1SWRJc0w4bmNpbVZkeVlKWXls?=
 =?utf-8?B?T3NDTWtTR1I1S3VEcGNVUytEUk9YdHgwbFYyYm5KVlE1a1YzdVlCSmIzMGJC?=
 =?utf-8?B?dXlsT1VXRldCdGxnUVVERzBMWlpKSEdZa0dhMmdtT2ZoY295QmZOTU8yUFNC?=
 =?utf-8?B?NjVqMC8vYUorV0FZSDFoMWgzclhNMmJlVmdjWm1CZ3NveE84RG1GMkpmTGpB?=
 =?utf-8?B?V2VrL3c1Z1JYeWdyZG9pYk5EQjc0VjlENjdBZFZreU5kbzFaUEdWRTZQZmIr?=
 =?utf-8?B?OUdIL1JpekFGS2pKbSt4VDk0Sk12dnBrT2loL1lsWVZSc1k5M1hOTm1acGRK?=
 =?utf-8?B?Z05uZUFmeVZ5eGRIRFNaSEFQdDJWcHRxRW5aTTlZWHB0UWo3K3hncDFWeGp0?=
 =?utf-8?B?MTJTSFFrSmo3dG9OUGp4SFA0ekN3d0ZIL0t1VEpqUkY2LzF1SkprZFdjRS9T?=
 =?utf-8?B?R0Y1d0QrcTJUcFdEZ1FyWHZ2Y3plVlZyeVc0M3NwY3MzbUtISGRiYW4vNHh6?=
 =?utf-8?B?eThkZE5idFA1dmc3WlQ3bVVBQ0FiOWF3Nk1QbWY3T3Fob0xaOEJubnJZNHcx?=
 =?utf-8?B?bEp6VVlmdktVUVVGWXI4VkxrWkFVUkxudHJtYWZDTDc2N1FYdE1nTHdFU1ZV?=
 =?utf-8?B?aDBBWDB6K0kvdTB3b3JRcS9hcGUwN2M4WXB6eDR0NDB1RlE2d2lsbDlCMHVj?=
 =?utf-8?B?TnNZVjBXYTJnTUlHZ2ZndzZ3WGUvWXZKb1I1SXlQRm52SExFNWJMMFo0NmpG?=
 =?utf-8?B?TytPSnF5b0hOazBjM2Z6Q001SEpndlMvNDBRSWUrcDI5WTFxMUQzU2RzbzRT?=
 =?utf-8?B?dDNIN1N4TXJXZzQ2UXIwSWlKdVRlR3I3dVZHUDV6cW00dXR6YWhYK1hWcnQ0?=
 =?utf-8?B?YmxvM3JWVGJQcjFXNU1najBGcm9nZ2orMSt2YVZkQUNQaFV4Ky9ZU1JBK2E5?=
 =?utf-8?B?ZEZRQ3BGY0hRdHNITGRJMDZ3c21rMmpyZFVHakpWZVNyU2ZYSVRwaXFCTy8y?=
 =?utf-8?B?VFROZWExQ3o0REZiQTR2TEpVZXIrL0FDM1ZBc1ZFWjlmZXQwYTg5ZUZTWnlG?=
 =?utf-8?B?emNUazlhZ1ptZld0clpPRXlLaGlUYmlESVNxUm5qeml0ZEF1UWJoeDUvU2dB?=
 =?utf-8?B?WE9kUEZZZ08yeUVBNUdMM0Q2T3RpbmVHa3d5WWZ1SGdZNkVlWDBONFY4M05w?=
 =?utf-8?B?K3JNbWF5dEdROURiSGN6VHRxNGlRY2dUZDlKbVlxQnlDdG9zLzAwM0Y2Z1BL?=
 =?utf-8?B?V1lnZmltaW5hYVI0OVowb3BVNkVINWlIbDl4VlkrMHRDNHNjN0lUV0R6b3Z5?=
 =?utf-8?B?bkZNQ1dMYU94WHFMTFJ3bjkwNGJNY2FkSUxtaFVacnRFTWhoYTEzcVkxODVo?=
 =?utf-8?B?UjR3U1U1bVFweFJLVGdQWUlwSTNmS0VmU3hGbm9yd3BuSWtkbkk1dTVPdjg3?=
 =?utf-8?B?aU50TTE0QlNxRG9pSmlMbEs2OGU5WHFDN09yYW11SlB0UzJQRDVtQ2l4R3Jt?=
 =?utf-8?Q?oneLpBJztMI1yrxts2+RRYBnJaduMi4+JKmNfi1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2994e5b-a34a-4994-494d-08d94126214e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 09:03:47.4799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLktivms6LVgluDRXqf3+q30pr+3O9BEJkzSuoFhYsMpYEcKR6cQsh1VYmCizoWF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5516
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



On 7/7/2021 7:26 AM, Evan Quan wrote:
> The relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
> PWM and RPM is not true for SMU11 ASICs. So, we need a new way to
> retrieving the fan speed PWM.
> 
> Change-Id: Idfe0276d7113b9c921b88fa08085a33fd971d621
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   .../include/asic_reg/thm/thm_11_0_2_offset.h  |  3 ++
>   .../include/asic_reg/thm/thm_11_0_2_sh_mask.h |  3 ++
>   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
>   .../amd/pm/powerplay/hwmgr/vega20_thermal.c   | 24 ++++++++-----
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 25 +------------
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 25 +------------
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 +------------
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 35 +++++++++++++++++++
>   8 files changed, 62 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
> index a485526f3a51..eca96abef445 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
> @@ -49,4 +49,7 @@
>   #define mmTHM_BACO_CNTL                                                                                0x0081
>   #define mmTHM_BACO_CNTL_BASE_IDX                                                                       0
>   
> +#define mmCG_THERMAL_STATUS                                                                            0x006C
> +#define mmCG_THERMAL_STATUS_BASE_IDX                                                                   0
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
> index d130d92aee19..f2f9eae9a68f 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
> @@ -92,5 +92,8 @@
>   #define THM_TCON_THERM_TRIP__RSVD3_MASK                                                                       0x7FFFC000L
>   #define THM_TCON_THERM_TRIP__SW_THERM_TP_MASK                                                                 0x80000000L
>   
> +#define CG_THERMAL_STATUS__FDO_PWM_DUTY__SHIFT                                                                0x9
> +#define CG_THERMAL_STATUS__FDO_PWM_DUTY_MASK                                                                  0x0001FE00L
> +
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 134a33e3de91..8e0f8e9a1665 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -226,6 +226,9 @@ int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
>   int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>   				uint32_t speed);
>   
> +int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
> +				    uint32_t *speed);
> +
>   int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
>   				     uint32_t pstate);
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> index 269dd7e95a44..43d754952bd9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> @@ -117,18 +117,24 @@ static int vega20_get_current_rpm(struct pp_hwmgr *hwmgr, uint32_t *current_rpm)
>   int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   		uint32_t *speed)
>   {
> -	struct vega20_hwmgr *data = (struct vega20_hwmgr *)(hwmgr->backend);
> -	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
> -	uint32_t current_rpm, percent = 0;
> -	int ret = 0;
> +	struct amdgpu_device *adev = hwmgr->adev;
> +	uint32_t duty100, duty;
> +	uint64_t tmp64;
>   
> -	ret = vega20_get_current_rpm(hwmgr, &current_rpm);
> -	if (ret)
> -		return ret;
> +	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
> +				CG_FDO_CTRL1, FMAX_DUTY100);
> +	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
> +				CG_THERMAL_STATUS, FDO_PWM_DUTY);
> +
> +	if (!duty100)
> +		return -EINVAL;
>   
> -	percent = current_rpm * 100 / pp_table->FanMaximumRpm;
> +	tmp64 = (uint64_t)duty * 100;
> +	do_div(tmp64, duty100);
> +	*speed = (uint32_t)tmp64;
>   
> -	*speed = percent > 100 ? 100 : percent;
> +	if (*speed > 100)
> +		*speed = 100;

Patch 5 avoids conversion as the relation between PWM and RPM is not 
linear. Suggest to return PWM value (0-255) directly instead of 
percentage. Since the function cannot be reused for rpm, it may make 
sense to rename to set/get pwm instead of percent.

Thanks,
Lijo

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
