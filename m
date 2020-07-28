Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438EDC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DBD20714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RrvxvcRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DBD20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C376A6E154;
	Tue, 28 Jul 2020 18:29:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA7B6E22A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 18:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIn+5Yrt2zz9Zxg40vPGIkL4Q5wVhAy0bOTrmOHlXbBgDMaHmmS3mAMPYvIe3iVGqhLlcT2np7RNBozLE1cU/PpP52AXBjDuPlZtJM/eSn430/BZc8f+jE/7DpZgtTBKJgzVJEYXP9W91Y6gTKZVUoEjZ6VaCsE9Px0m0sIuGo3okrrlcIAhYE+oSqy+ql6qa2/ukWvjs22WbCuInj1pLt7xWdzkdc606f2bVGWS37AY7H45xXzBlr5X/jpJr4fvAgcGzTLVJx8hjNYL79xIpJsNSL+Ed+UMaI8wqRsa6glo/YABkkwyQlfYHtIfw9yQhCfzqRVe2be+noiIH/DMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNizyL96EPvBwp0ebM1jovc9eReW9A0vO+mwZGikkMk=;
 b=AL0QRx6YZOwybGYYlm1EUNxeeVE3YEYf0Fwz1v0U854hHubovPuFrlxHD4mBM6ScjTAkPvZ+yD2Vx2wx6SkM4FiidKdX7glw8w31Vpk17noQ5AReLSjo4ZzZhkP73zJCt/KodfOro/RdDOWCBqINIFk/GHgSrPWoq2a7SO+HnAZoe3dg/8C/E1Ua45OEGcM3QhcX56nBJdSzFmB/yY1EAnzUqHZYX99Eii7BeAeuQXt4NHAmHaQaJVRJQbAV8AlGF1ca6/dO3HXK9AH3sJq2xGHwxbzJPNxDMeG+eeQEMZNZ3u80CxSyoJtsY/0wXDKVPiKEtKYSiBjm8/2F/fOJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNizyL96EPvBwp0ebM1jovc9eReW9A0vO+mwZGikkMk=;
 b=RrvxvcRCN28O3jl4Fh6cBAzJr0Ji7z3LfUdlbVmuIRx0KnQRA8rfO0RYjSInDDP7JVtSZFS++2YHZG2j/YDMFyQlfXYQcL+6HNjOiI0ZFATP08iLLoDyfi+LAwX9eG8JffuvcX5sQpkH3h7AL5gd9CtopDbHGKsxXM1mH0/hfG4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN8PR12MB3123.namprd12.prod.outlook.com (2603:10b6:408:42::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 18:29:46 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 18:29:46 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: add interface amdgpu_gfx_init_spm_golden
 for Navi1x
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200728052717.21071-1-tianci.yin@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <737bbfe1-a030-b411-5ba2-e0704c03c76c@amd.com>
Date: Tue, 28 Jul 2020 14:29:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728052717.21071-1-tianci.yin@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::25) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 28 Jul 2020 18:29:44 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de1920a5-2c8a-4eab-95a6-08d8332433fc
X-MS-TrafficTypeDiagnostic: BN8PR12MB3123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3123EEF39BFF6650B064006899730@BN8PR12MB3123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:359;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmzQUGw9vqg10EXx37O7GbD7EIIJUDPHOfzeduQW15yBM8s+MNf/Hm0ZqM9BGDqcNN6t9eSPTnsdHNvWpWjyZ7f7jUUh4/bgTv+F63NiWp+ACWVwOXIGoFJ/jThbj+kju71yb3pkLsf22m8+9npnCbDvU/flB8aBWNtuB21LrAGNYX6ZXhZzwFShXmbye+3w9T1aDYW7kTvo+HEh/8PM2u5wejk5dv0Fva/lq80gMzCeepelhIFic0/AMAkCgb1y55zVkKQfA/vRdYOZ5ZowkyK/9lFYroIAu583/LPphnjGb25ou9GtO5zEm+syJSfllT4/T+Rxp9twW3BHIhubd9qnX3DLXupySsnQLGWPicPmkRo2FR65XJn3B3fEOHyE2nvi63MqGBC38eFM9/NnAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(66946007)(2906002)(66476007)(6512007)(478600001)(6486002)(316002)(26005)(66556008)(8936002)(956004)(54906003)(36756003)(186003)(16526019)(2616005)(4326008)(5660300002)(8676002)(53546011)(6506007)(83380400001)(31686004)(44832011)(86362001)(52116002)(31696002)(32563001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: D25JqjOuP5PzJ/hu44mexd9xsxSVh8v2C/Et/9vt9DSm6vLStilqACHSVUvlTqKuEBNPUFbB4WZh4qg4sBR0frXE3+mtwqfGQVvY6lEX1bhjJIZlcnEGBNuSP3Sg9XMjNiZNwg6NXl4PqRRThQt4xA5S6FSMbMuT8uv1g+YV+RMS1h0MQvgaBRdMlORDignhKF9fKQPUB2hY14K6AxKTfXMERIxdQUpVCEtBj/+X2hdNN5KLjiLeERHzD3dXhzVRc1Ioj47BCcskoa0xfmpWnV8Nbj280B0V1XMfiu4SR1Lp6Bcl0/DBa+RQPb80TO215yv8lx7rXTMS4G2eoKO3YCyCOiKjq731fGiosXvD3zB1MRrcY/LvudctRvBU+td5a+yJES5/ftav1Yb3rcofLRqDHBKZvjW2RYEW+cSvzdBnSOukZnBnty/gBY7SNOWdR7Q+lsCCvyD8TiJHLY0aZkS9kJed048I0pMQSPCI1GQTkfKsQlT88Kjfu76KBFmI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1920a5-2c8a-4eab-95a6-08d8332433fc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 18:29:45.9384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/6YhHW6SssurvT9qRKu5rysbFtW2cuCd0RJ7arSDxD8f2lE325LmeDbF0197hVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3123
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
Cc: Feifei Xu <Feifei.Xu@amd.com>,
 Hesik Christopher <Christopher.Hesik@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Swamy Manjunatha <Manjunatha.Swamy@amd.com>, Evan Quan <evan.quan@amd.com>,
 Feng Kenneth <Kenneth.Feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-07-28 1:27 a.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
> 
> On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,

Use present tense:............... " are lost after "

> reconfiguration is needed. Make the configuration code as an interface for

Add "so a reconfiguration is needed. "

> future use.
> 

If the lines of your commit message are too long, then "git push" complains
about them. Sixty char wide is perfect, since "git log" indents them when
displaying them.

With this fixed, then Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> Change-Id: I172f3dc7f59da69b0364052dcad75a9c9aab019e
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 34 ++++++++++++++++++-------
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 1e7a2b0997c5..a611e78dd4ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -216,6 +216,7 @@ struct amdgpu_gfx_funcs {
>  	int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
>  	int (*query_ras_error_count) (struct amdgpu_device *adev, void *ras_error_status);
>  	void (*reset_ras_error_count) (struct amdgpu_device *adev);
> +	void (*init_spm_golden)(struct amdgpu_device *adev);
>  };
>  
>  struct sq_work {
> @@ -324,6 +325,7 @@ struct amdgpu_gfx {
>  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
>  #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
>  #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
> +#define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
>  
>  /**
>   * amdgpu_gfx_create_bitmask - create a bitmask
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index db9f1e89a0f8..da21ad04ac0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3307,6 +3307,29 @@ static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
>  	adev->gfx.kiq.pmf = &gfx_v10_0_kiq_pm4_funcs;
>  }
>  
> +static void gfx_v10_0_init_spm_golden_registers(struct amdgpu_device *adev)
> +{
> +	switch (adev->asic_type) {
> +	case CHIP_NAVI10:
> +		soc15_program_register_sequence(adev,
> +						golden_settings_gc_rlc_spm_10_0_nv10,
> +						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_0_nv10));
> +		break;
> +	case CHIP_NAVI14:
> +		soc15_program_register_sequence(adev,
> +						golden_settings_gc_rlc_spm_10_1_nv14,
> +						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_1_nv14));
> +		break;
> +	case CHIP_NAVI12:
> +		soc15_program_register_sequence(adev,
> +						golden_settings_gc_rlc_spm_10_1_2_nv12,
> +						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_1_2_nv12));
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>  {
>  	switch (adev->asic_type) {
> @@ -3317,9 +3340,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>  		soc15_program_register_sequence(adev,
>  						golden_settings_gc_10_0_nv10,
>  						(const u32)ARRAY_SIZE(golden_settings_gc_10_0_nv10));
> -		soc15_program_register_sequence(adev,
> -						golden_settings_gc_rlc_spm_10_0_nv10,
> -						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_0_nv10));
>  		break;
>  	case CHIP_NAVI14:
>  		soc15_program_register_sequence(adev,
> @@ -3328,9 +3348,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>  		soc15_program_register_sequence(adev,
>  						golden_settings_gc_10_1_nv14,
>  						(const u32)ARRAY_SIZE(golden_settings_gc_10_1_nv14));
> -		soc15_program_register_sequence(adev,
> -						golden_settings_gc_rlc_spm_10_1_nv14,
> -						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_1_nv14));
>  		break;
>  	case CHIP_NAVI12:
>  		soc15_program_register_sequence(adev,
> @@ -3339,9 +3356,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>  		soc15_program_register_sequence(adev,
>  						golden_settings_gc_10_1_2_nv12,
>  						(const u32)ARRAY_SIZE(golden_settings_gc_10_1_2_nv12));
> -		soc15_program_register_sequence(adev,
> -						golden_settings_gc_rlc_spm_10_1_2_nv12,
> -						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_1_2_nv12));
>  		break;
>  	case CHIP_SIENNA_CICHLID:
>  		soc15_program_register_sequence(adev,
> @@ -3360,6 +3374,7 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>  	default:
>  		break;
>  	}
> +	gfx_v10_0_init_spm_golden_registers(adev);
>  }
>  
>  static void gfx_v10_0_scratch_init(struct amdgpu_device *adev)
> @@ -4147,6 +4162,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>  	.read_wave_sgprs = &gfx_v10_0_read_wave_sgprs,
>  	.read_wave_vgprs = &gfx_v10_0_read_wave_vgprs,
>  	.select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
> +	.init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
>  };
>  
>  static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
