Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69948C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A32722AEC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A32722AEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5558970E;
	Mon, 28 Dec 2020 10:15:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1808970E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 10:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+F1pqm7D2kX8RnBg0h2FHNVMNfvVpNYnV0DvM57zWmuGEB4gF2G9TbbGrtQjVYtorCmUYnwKm0uDfnwspBaibrJmdsnZls/JkGaPCSNVdrNCe3VCvuZ1d+TxfqAURZkQeRO25QfvXhLhPF9eItTFr2LeSBVMpGob2VLPJKIUL0cBnPVSexGgXv1hYHjYFAehqblCul2zWJB2067k8sZ+HAKCA8T/qd8Rgr0VXV1kh/Z4fYB9VBGTC/bVHq6gJAI84hCZdO/TycyZc0CcvabOQ5VE1IOXITb6j+a84MNmM19Nhb2LCzIhahgy+vDzSMdE8EIUL2kSo1VQfNCae94eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuW9ZXb6AJ7jHCpBZpnKG5zQcwsZXqMqEKVGIkhZ73c=;
 b=OwGMuWu0t0hDvXUxnIS0O+or8rOMTWyjTAbx8WDmBbkDsqI6ltnaFgD3WQ6s/zY3CIR11PHD+PP3IA5YpZ2GIxWH4/UCk53YMATHhOCpm7WGWFlaXyRKBShu5REfb/I0+7lqTb6DiRI9sa9/4Eluv1fsk3hwX2OO4ne9AgVfAUPdXzpLtEQhGgfRyadAiBxDWyuqJHmcB5SQECDls9JOj2nfGFO57klIY1/IFmSVvSdqjolclK6Mtm3nGPxhZs1JcO5HfYetveIF31WsO4uB0HTeaGHN9tqSg76e8isS8REyuaHf92es8tuYRdHeSoTln/ZB+6jMIcmwXoWFD6+5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuW9ZXb6AJ7jHCpBZpnKG5zQcwsZXqMqEKVGIkhZ73c=;
 b=c/0FHgsC1K/a8NfNjEHn60Bb4qsNxZUyvqUNszrL/KN9Aa1s8c4EkF1kvk+m3sPvQWXAjesN9OySsZQM4WHpmbtfwYHtsgbRuwnO/qCz404OnwPNeVDJ2ZIVSYI4fWVIsKpC64noTnOcnBor81bgBOY9Ju+c1ZqRykQQjHDz8B8=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1311.namprd12.prod.outlook.com (2603:10b6:300:13::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.29; Mon, 28 Dec
 2020 10:15:21 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Mon, 28 Dec
 2020 10:15:21 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: switch hdp callback functions for hdp v5
Thread-Topic: [PATCH 4/5] drm/amdgpu: switch hdp callback functions for hdp v5
Thread-Index: AQHW3Pp3x6yzYQlKWEqtpOh/tElGaKoMSSWAgAAAp6A=
Date: Mon, 28 Dec 2020 10:15:21 +0000
Message-ID: <MWHPR12MB1854FCF96A578001BEEB23CBEFD90@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
 <20201228091834.3240927-4-likun.gao@amd.com>
 <CY4PR12MB1287B5EC514961FEA9A90733F1D90@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287B5EC514961FEA9A90733F1D90@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-28T10:07:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1ba84e10-3018-4f97-848b-0000e7c0d240;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-28T10:15:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: bc6bca5e-df40-4ae8-856c-0000da5fde5e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6171da4-dd4b-495c-8132-08d8ab197c34
x-ms-traffictypediagnostic: MWHPR12MB1311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB13119BE457409EBAA476A342EFD90@MWHPR12MB1311.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cLcNw4D26OuZMLpUy2hrWO5TZ//aHmZ/TLGBmBtOzZWfOps6+XrqmYhG+y4yfEwlacwJEWNyXXRljqmXijTHzszjb3k/Sr6lrwL7uBE8sDL91iPk50DLMXj/HkD53Mt07mRClG18+Df+0raV5QrGZoMvV8WhXNtz8rFpeQwzFunU7vR0EoATW7hxEKLgcWhxVlHD+InYRnD/xaoMSpEWGRcak+kRWk5dnAWhYFn5DVJauT3NHw7hzNHLffQhXONlC5Nk17tibOH7vJl6+76iPctIIYRNYXP0aOfEYA1DJJl7LF/pN/NLkTCRv78E/l3eW2s0zlgIRwp+KAiEcRzMwHRkZS0uU3ajigAQ1uYM1wqbt2AVMR0WWJpPZ17teuj5muU7D0y/j40zBtao5BiaEaAR92FiHKy0WyFdv004BiE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(478600001)(33656002)(316002)(76116006)(26005)(186003)(30864003)(86362001)(64756008)(66476007)(83380400001)(9686003)(110136005)(53546011)(52536014)(66446008)(7696005)(5660300002)(8936002)(71200400001)(966005)(8676002)(4326008)(2906002)(66946007)(66556008)(45080400002)(55016002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t2lsteGOvyiI4jy4n1N3C/Y+klhKrHQfm20vp6DCYScqNNAGw/uLcOYehWUT?=
 =?us-ascii?Q?MuJMSK06guClMwCqR0N0tCLFo6yVwJDwLz8YXtqTU2HD1s0vZG+k1Gah7eC/?=
 =?us-ascii?Q?qRyn/+XLpj37e7UBK2TBHOBPD9IucpvFHY45j32nA90agIJjg9R08xiY0C26?=
 =?us-ascii?Q?rBcwTcVL0swgMPTy7JModpxZvf4tD4em/9tdNoIUBhs7s5/gmWF6cwwC6xO4?=
 =?us-ascii?Q?S9VpcYpOuNf2TIqBXGgQY84Uk7PYVdUYc7dyRoBdLDttksR3jt+ufDkv7Ra9?=
 =?us-ascii?Q?4lUEVDxXEjFKTEISmYAdFqBoqvgJ3xoKdU23vO3FIaJqBFn+mGimf0gqkBad?=
 =?us-ascii?Q?mYLRMGQO6Zu2hkBrJ9X5Za/XK7smEwYaXSHMKNCqHdTKZE5M3bc0kQnTwHY0?=
 =?us-ascii?Q?Xjhfyzi6QNyXF+u2pS00ibJFIifHiCndbINP8H2jgpVED2BX8BwItHpzxWjz?=
 =?us-ascii?Q?kyIsI2VitPtYkYLqPn7U7Sf4NtURk8zszIMTweI8yEmXsnR4sq0KV75ffLPs?=
 =?us-ascii?Q?+ZU32AY9ADFe4xtmteYsR2hr5AplFD2tL/2VM/WTvbOHzZ5+w5WDjnOaW0TH?=
 =?us-ascii?Q?Wu4FeGofgkIQNDCdQfUVowdRHFAeWde/RtWsNzTTrKMmxxuW8nXIh/zUwbwN?=
 =?us-ascii?Q?/b7+5EQoobPAW0+pMuL6u6+WTRWLYL2nNpCxMQ2mC65Cyk3T+aENmveE6X4d?=
 =?us-ascii?Q?vT9flKAUypfbpHfyARNZ1mHEE9Nlbda0wSyHLk4p7NrHduM5ncPUvX6ogu5T?=
 =?us-ascii?Q?CYWtikpFDoH/jb4U577jQtTFnMQFJfz1Ix8GfLd6GIOocrwWVYhNSl+o0Kl6?=
 =?us-ascii?Q?YR2SKza2wjhZQw7ANoFAluELP/vxA5oYixrh2GZtGCeoVU9tafhe0LHOTvDk?=
 =?us-ascii?Q?+3QK5tvyoG3I9jxflBXyWbmZSax0B7PbSos+8abYuDLk1ArumE+2Ys7M+1VB?=
 =?us-ascii?Q?Uetj6qiGVI6JYsKg6OYUp+bzQ8nzrIlyfAD1OzQsqf8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6171da4-dd4b-495c-8132-08d8ab197c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2020 10:15:21.7114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLBnviA89LAPHYIJdcXoB1KtlssSFhO7MtoHdEXNDl9lGL4299lZXKqWY/EPPwcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1311
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

hdp.funcs should be initialized for all the ASIC when do ip early init (on xx_set_ip_blocks).

Regards,
Likun

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, December 28, 2020 6:10 PM
To: Gao, Likun <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: switch hdp callback functions for hdp v5

[AMD Public Use]

One question for this patch:

+		adev->hdp.funcs->flush_hdp(adev, NULL);

Shall we add one NULL pointer guard of hdp.funcs->flush_hdp before using it? Or it's not needed at all as hdp.funcs will be initialized for all related ASIC series.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun Gao
Sent: Monday, December 28, 2020 5:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: switch hdp callback functions for hdp v5

From: Likun Gao <Likun.Gao@amd.com>

Switch to use the HDP functions which unfied on hdp structure instead of the scattered hdp callback functions.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: If70683c8cb697a9e7a1ea5a21aa2ed84567e6919
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  14 +--
 drivers/gpu/drm/amd/amdgpu/nv.c        | 160 +------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c |   2 +-
 5 files changed, 13 insertions(+), 174 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d741fee91a37..e74cd443063a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o
+	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ba1086784525..10aae0abcffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -38,7 +38,6 @@
 #include "smuio/smuio_11_0_0_offset.h"
 #include "smuio/smuio_11_0_0_sh_mask.h"
 #include "navi10_enum.h"
-#include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
 
 #include "soc15.h"
@@ -5691,7 +5690,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0); @@ -5769,7 +5768,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CE_IC_BASE_CNTL, VMID, 0); @@ -5846,7 +5845,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0); @@ -6215,7 +6214,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0); diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5648c48be77f..3b7c6c31fce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -27,8 +27,6 @@
 #include "gmc_v10_0.h"
 #include "umc_v8_7.h"
 
-#include "hdp/hdp_5_0_0_offset.h"
-#include "hdp/hdp_5_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_offset.h"
 #include "dcn/dcn_2_0_0_offset.h"
@@ -312,7 +310,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	int r;
 
 	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	/* For SRIOV run time, driver shouldn't access the register through MMIO
 	 * Directly use kiq to do the vm invalidation instead @@ -995,7 +993,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)  {
 	int r;
 	bool value;
-	u32 tmp;
 
 	if (adev->gart.bo == NULL) {
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n"); @@ -1014,15 +1011,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL);
-	tmp |= HDP_MISC_CNTL__FLUSH_INVALIDATE_CACHE_MASK;
-	WREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL, tmp);
-
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL);
-	WREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL, tmp);
+	adev->hdp.funcs->init_registers(adev);
 
 	/* Flush HDP after it is initialized */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 6bee3677394a..1d785f06c79d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -38,8 +38,6 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
-#include "hdp/hdp_5_0_0_offset.h"
-#include "hdp/hdp_5_0_0_sh_mask.h"
 #include "smuio/smuio_11_0_0_offset.h"
 #include "mp/mp_11_0_offset.h"
 
@@ -50,6 +48,7 @@
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
 #include "nbio_v7_2.h"
+#include "hdp_v5_0.h"
 #include "nv.h"
 #include "navi10_ih.h"
 #include "gfx_v10_0.h"
@@ -514,6 +513,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v2_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
 	}
+	adev->hdp.funcs = &hdp_v5_0_funcs;
 
 	if (adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->gmc.xgmi.supported = true;
@@ -669,22 +669,6 @@ static uint32_t nv_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
-static void nv_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring) -{
-	adev->nbio.funcs->hdp_flush(adev, ring);
-}
-
-static void nv_invalidate_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	} else {
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
-	}
-}
-
 static bool nv_need_full_reset(struct amdgpu_device *adev)  {
 	return true;
@@ -788,8 +772,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.set_uvd_clocks = &nv_set_uvd_clocks,
 	.set_vce_clocks = &nv_set_vce_clocks,
 	.get_config_memsize = &nv_get_config_memsize,
-	.flush_hdp = &nv_flush_hdp,
-	.invalidate_hdp = &nv_invalidate_hdp,
 	.init_doorbell_index = &nv_init_doorbell_index,
 	.need_full_reset = &nv_need_full_reset,
 	.need_reset_on_init = &nv_need_reset_on_init, @@ -1080,120 +1062,6 @@ static int nv_common_soft_reset(void *handle)
 	return 0;
 }
 
-static void nv_update_hdp_mem_power_gating(struct amdgpu_device *adev,
-					   bool enable)
-{
-	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
-	uint32_t hdp_mem_pwr_cntl;
-
-	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_HDP_DS |
-				AMD_CG_SUPPORT_HDP_SD)))
-		return;
-
-	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
-
-	/* Before doing clock/power mode switch,
-	 * forced on IPH & RC clock */
-	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
-				     IPH_MEM_CLK_SOFT_OVERRIDE, 1);
-	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
-				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
-
-	/* HDP 5.0 doesn't support dynamic power mode switch,
-	 * disable clock and power gating before any changing */
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_CTRL_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_LS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_DS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_SD_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_CTRL_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_LS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_DS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_SD_EN, 0);
-	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
-
-	/* only one clock gating mode (LS/DS/SD) can be enabled */
-	if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_LS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_LS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_DS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_SD_EN, enable);
-		/* RC should not use shut down mode, fallback to ds */
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	}
-
-	/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
-	 * be set for SRAM LS/DS/SD */
-	if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
-							AMD_CG_SUPPORT_HDP_SD)) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						IPH_MEM_POWER_CTRL_EN, 1);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						RC_MEM_POWER_CTRL_EN, 1);
-	}
-
-	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
-
-	/* restore IPH & RC clock override after clock/power mode changing */
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl1);
-}
-
-static void nv_update_hdp_clock_gating(struct amdgpu_device *adev,
-				       bool enable)
-{
-	uint32_t hdp_clk_cntl;
-
-	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
-		return;
-
-	hdp_clk_cntl = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-
-	if (enable) {
-		hdp_clk_cntl &=
-			~(uint32_t)
-			  (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
-	} else {
-		hdp_clk_cntl |= HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
-	}
-
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
-}
-
 static int nv_common_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)  { @@ -1213,9 +1081,7 @@ static int nv_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		nv_update_hdp_mem_power_gating(adev,
-				   state == AMD_CG_STATE_GATE);
-		nv_update_hdp_clock_gating(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
 	default:
@@ -1234,31 +1100,13 @@ static int nv_common_set_powergating_state(void *handle,  static void nv_common_get_clockgating_state(void *handle, u32 *flags)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	uint32_t tmp;
 
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
 	adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	/* AMD_CG_SUPPORT_HDP_MGCG */
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-	if (!(tmp & (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
-		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
-
-	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
-	if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_LS;
-	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_DS_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_DS;
-	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_SD_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_SD;
+	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	return;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index a738a7d7e383..c325d6f53a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -690,7 +690,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		}
 
 		memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 		vfree(buf);
 	}
 
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C95696db274534d8bf55108d8ab119da0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637447439447119281%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=se654MRT%2FieoLR9wKve2VuBLWM8u4Yc7PMh%2BoE1a8kQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
