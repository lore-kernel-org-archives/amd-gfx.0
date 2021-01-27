Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80311C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 08:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103BF20727
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 08:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103BF20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93A56E5C8;
	Wed, 27 Jan 2021 08:46:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16A06E5C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 08:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX1sEIJ6Qea5qyWaHKSHVu1jJpH8Ph0NBYZfCWegAsKWYMJIggO4MjaK4aKd4MaTvu9R8F0NmUKmliy7i8/tW8aEKVijZGoVetQU87wifLV5YWBB+juEw8SKsXlIk8z1NhlCiqsrltwGu2XiQR9t6vBI25mIfoqWlwzA5zmX3i7Ue0CidNVrpsRYQQU7Km3axlrj8vnd1gZa3kFSyRuId924Gv6YwV/lL+b7iijPmU9dDeUFYYP4j3J6fQkFKC8eZ4Iu11mEZPP0n6rnlON4mD/MiucdFYo/Bgs70l8ew5wYVVX+0xfZpihT0gSVAxcj1w/C8M0G37pj18zEnO1qTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCQMX5P5dVweEsXrNyzAg8eKy7PFXV02Bh3/ERPGch4=;
 b=K1bS02bmP20C+fxRfPLd/FEqnswA1uLvKVoJvrSNf31tNrekgm/+j2H/5/dL8cPzwWFzMPJPF2/T+aFNKlSzoG5oNBjG7glM0qmnhCJfLX6Ym7XuUdO+yNQ+eNVeU0csFlJz2DTsqcwIWi7s6ESlyAWu3K2bQgEcpGA82of8JUGXOF1SiqJ9164/azJqgZexXiOF4TXIqkDNVUUOKrOHz3Qx06oaXLD451FVUGvsw+0nqqki84UtadehhZ4CgBzjDY2K1tRYDJVpbquOnSUteV9n0uohmzYG8hyzUqPZEU/Xi7A/JyyHNWiIYe3LjaCG0aFXcVzF16NHc1K1HmN9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCQMX5P5dVweEsXrNyzAg8eKy7PFXV02Bh3/ERPGch4=;
 b=09UPRLzYrKruEjUsOe+P+657fmfxkOeIe9XGmyxH65L5InOl/B1NHt4+EYaPzFr7LH40/+zRxsUR9XSIKIpFqfelORT9LdCA+FBf7BhYPRxxtdqXs94+KTUvfUikuFqq7nlJW8+6w1ZHXWv8g4zphG95npABZBBdvXFADGA4/eE=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR1201MB0155.namprd12.prod.outlook.com (2603:10b6:4:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 08:45:59 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533%4]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 08:45:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: Enable gfx DCS feature
Thread-Topic: [PATCH v2] drm/amd/pm: Enable gfx DCS feature
Thread-Index: AQHW9ITYGpJgr3jhL02RwiHMbks9gKo7JaqQ
Date: Wed, 27 Jan 2021 08:45:59 +0000
Message-ID: <DM6PR12MB465063B568B439018B82D3DEB0BB9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210127081648.28759-1-kenneth.feng@amd.com>
In-Reply-To: <20210127081648.28759-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T08:46:02Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=54187f58-07cd-4530-bff3-07e9b583322d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4f4f8f1-331a-48ea-e0ce-08d8c29ff88b
x-ms-traffictypediagnostic: DM5PR1201MB0155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB01559477BDB5089D1CEF523FB0BB9@DM5PR1201MB0155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3PJapvsduYUlt/WlkYV7vufHZKqcms2YP6aofB2f8NGPmfcvBHvKEtjs8OeZ49YUdTPK8wqZ9d6LlSKSrP6Wrktob+c/UvW6EMdvEmbqDEvboy6O0IsvCBwX/CKGOL3evdCL+nQtCOmZfiRirlzgL/7CJdrYp0vDojbcU96lyNxNdUEGN4LIYrje6e0X1EdxMBDEcbO6m9kmXLNsb75WWnDoZm3rYXgaa20FIKPwtHAP6+hhBb/D5JvCAeSiO2JkJnZvBHXde5e6ByxCohH/rk1udAUcjpYESxf4PIeHILOUy/Hptb12HijuQFJpUI+3KMnPS+QiGu89hOG1AwW/PMPlUlT7wL1bgesTAe5YjCKnUVXqpcGMU1ga1Lm8C9xSnMroCHOxCFU+pjwrp8mZ/TVHVuyzCdgSM1y7iLWvEzKB3/BexgW3ukK0xXGF1mVaUODYR/zbKfbxqHRDkhkrkcftf+dadpHeDbXS4ESCeqOfXQQHYP0s6QefVSJMTBdhg73pV8+puyxxzw9QpgbTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(316002)(9686003)(66946007)(71200400001)(4326008)(8676002)(2906002)(55016002)(33656002)(64756008)(186003)(7696005)(66446008)(478600001)(66556008)(6506007)(66476007)(53546011)(52536014)(5660300002)(8936002)(86362001)(26005)(110136005)(83380400001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hXWcpNvWPvqiilQFTJXS/KGpsozba9vdFV4BcJak8TLniMWtKVXQU7GPucWV?=
 =?us-ascii?Q?BLzSH9YSxXoSmySIjluR6+PvrAXEtZREWTQVFn6bHT71xbktstlo3nJExOVt?=
 =?us-ascii?Q?e8pV3RGzmU1OB1ZK1DFkGG+KxIGNulWAmFXC5+746yi3nn7BAMe6B0NgnQjW?=
 =?us-ascii?Q?5jXa4hTeU9/nCSYZR33ajRd8OYcptiL1mz5FEHCgYVH0hAcWgHIW/5CediUG?=
 =?us-ascii?Q?C0PTn1dzMQWtgAYFoffb5UU4MQb/cj7ZF6Q0qi9AYFK5t4pen/2Rm2LH2cqK?=
 =?us-ascii?Q?p7bb9tzCtJj+Y76nha+iHOj/7yT0kiXY8v5bFYU+YAfRTmZ3FUfUJO1B6KPv?=
 =?us-ascii?Q?7CkTJTpd515C+4rAy83HIxyjKpg/YSVs1OFd2E9AhDQb4tURfS5AYlS63YYv?=
 =?us-ascii?Q?GCdDSILB3vdAiGVrzc4X3Y8/UgHSl27lcRYlpiq0dhtJ0AjZvMcCP2iB6A+h?=
 =?us-ascii?Q?Kgwmkv6Ifye5skNSZ7j3WQmB4dTPaNEKSIEsBn5ERfxwa23nwDQ5GGYoQbcO?=
 =?us-ascii?Q?Y7uZLrC+jc8zrqp6vMpgurRpiTG4T1pIpHGc7hh5WUY+/7ZCmzuXSI9bcBlN?=
 =?us-ascii?Q?ysLoGe31C6hKZ7T61JkeO254zrcgVWnDXgrepz6a1zZWZQ09ziWS6U2BH9/0?=
 =?us-ascii?Q?kiHWLtAnelhFYdnd23DE4zN/RLbq5vBg1t1TIMshrCWpl1MOWZkkdIV5bVvZ?=
 =?us-ascii?Q?Ai/QDj9eshAKa00qIhdG02F+I6mGy8npVVYoRHpubEPaa1iKO0wJjbZmh8JY?=
 =?us-ascii?Q?8tEJYA72/pYZ4r18jWrWLOfL8VoY9+0vhhnMbXyauEtXV8kg53bwhRdez7sG?=
 =?us-ascii?Q?qTPdVF7Js3EfmPQGLN1Fdx70L88aQz2ZqkB2jkDWRhN4rnLxdnYv3Q5rD98V?=
 =?us-ascii?Q?0OF9d3V3SMJLucLLv5Zmg+uzcnD/dAa7iWi543EgejhLjHQiFpEoVjpUI8cQ?=
 =?us-ascii?Q?qzeZPlnrGFnlCFKtxz/7BE0CQNEEt9P8eG2rsiZc+8HdC3MFOHY50a2vwrTF?=
 =?us-ascii?Q?DCK7ArZLUOWdqn0ZhslopZ/UtMnTldsiuCDeRR4WATs1PDrHchd84o54oNOp?=
 =?us-ascii?Q?Navg1w0Z?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f4f8f1-331a-48ea-e0ce-08d8c29ff88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 08:45:59.7830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mP072w8HsxlJfnHK3gvwClVM4HqtI8l7PCISf81DNDm8e67r5rBKfxAHyne/FRRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0155
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Kenneth Feng <kenneth.feng@amd.com>
> Sent: Wednesday, January 27, 2021 4:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>
> Subject: [PATCH v2] drm/amd/pm: Enable gfx DCS feature
> 
> Background:
> Gfx Duty Cycle Scaling(DCS) is applied on the small power limit skus.
> When the current/power/temperature exceeds the limit with the heavy
> workload, the gfx core can be shut off and powered on back and forth.
> The ON time and OFF time is determined by the firmware according to the
> accumulated power credits.
> This feature is different from gfxoff.Gfxoff is applied in the idle case and DCS is
> applied in the case with heavey workload.There are two types of DCS:
> Async DCS and Frame-aligned DCS.Frame-aligned DCS is applied on 3D fullscreen
> and VR workload.
> Since we only supports Async DCS now,disalbe DCS when the 3D fullscreen or
> the VR workload type is chosen.
> 
> Verification:
> The power is lowerer or the perf/watt is increased in the throttling case.
> To be simplified, the entry/exit counter can be observed from the firmware.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c              |  8 ++++++--
>  drivers/gpu/drm/amd/include/amd_shared.h             |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 ++++++++++++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 82c2fa8a67cd..186bbe139bde 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -131,8 +131,12 @@ uint amdgpu_pg_mask = 0xffffffff;  uint
> amdgpu_sdma_phase_quantum = 32;  char *amdgpu_disable_cu = NULL;  char
> *amdgpu_virtual_display = NULL;
> -/* OverDrive(bit 14) disabled by default*/ -uint amdgpu_pp_feature_mask =
> 0xffffbfff;
> +
> +/*
> + * OverDrive(bit 14) disabled by default
> + * GFX DCS(bit 19) disabled by default
> + */
> +uint amdgpu_pp_feature_mask = 0xfff7bfff;
>  uint amdgpu_force_long_training;
>  int amdgpu_job_hang_limit;
>  int amdgpu_lbpw = -1;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index 9676016a37ce..43ed6291b2b8 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -213,6 +213,7 @@ enum PP_FEATURE_MASK {
>  	PP_ACG_MASK = 0x10000,
>  	PP_STUTTER_MODE = 0x20000,
>  	PP_AVFS_MASK = 0x40000,
> +	PP_GFX_DCS_MASK = 0x80000,
>  };
> 
>  enum DC_FEATURE_MASK {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 24f3c96a5e5e..dffdcebc80e1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct
> smu_context *smu,
>  		*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
>  	}
> 
> +	if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) && adev->asic_type >
> CHIP_SIENNA_CICHLID)
> +		*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_GFX_DCS_BIT);
> +
>  	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
>  		*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
>  					|
> FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> @@ -1437,6 +1440,15 @@ static int
> sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>  	smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
>  				    1 << workload_type, NULL);
> 
> +	/* have to disable dcs if it's the 3D fullscreen or VR workload type */
> +	if ((smu->adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
> +	    smu->adev->asic_type > CHIP_SIENNA_CICHLID) {
> +		ret = smu_cmn_feature_set_enabled(smu,
> SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
> +			WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT ||
> workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return ret;
>  }
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
