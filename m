Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791B0C43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 12:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4080420409
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 12:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4080420409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95666E0EE;
	Wed,  4 Dec 2019 12:41:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E326E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 12:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzlXmHJQYCl+SHjtYCB5pjEDI2NKvXDxWIYj3TEWx/orpdwlJKs6FhME8Z3VwCS2nVMdfQA2Ss2A+KjSh9Kt52MpXywQkiWPI8DOFlFOMDcuB0f0fdc9VBX3Ntv4FndAFSEbi+OIv44TPWvk2LCXmUHohzw6rjBEx0ePfCOP/U9Y/PUcfdL5RiIld8IOtz2ilqYdLd7RXuV+TjtUQn+Wx1bO32miOLczh3xlSoS2xXEvjQpTkeoJIBAZo40d4EJb+3tCCd4X/U16mXAhammpVN7sgBWnFKJr4c3+EbbQoztNbZn3uQg4e8rF7pDSQayVDyTm8wVK6C+ruW/DHJx6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0SOy7obPLE/LMe/MheuoQ9VAHgGIRuQhgWiuEkcbwQ=;
 b=eXiD2aEZZWogaI3B7xAaHem36TzyCOIDJhWmMP5pCKmPAuF0bslUPhLheiYHlqpV7KyZog9SmHJ4OPmfQ5jYsBXoOUlW6p7N/RrsT+af+fDAAG8RneTAjR0+HfiawtLUiPJU2FVwNaJHsrPamSluya0GeIdXxkV535t552arrFE1XpPcJ3rf95+0VaFs+iZCHM1SaNzspJbWQwdvVXCC0l7UommyIbGwTX2dyKF26HvMevtukBnkFqMrpFnY8iKuEdphRk/nSoNsPL3I7CAcLlYa0TTlzYGiVhwLpI8gd4aKDJcC7c16FoNugvo1Bf1jrdWQoc2Ksnqmqw4Ir6qzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB2973.namprd12.prod.outlook.com (20.178.243.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 12:41:00 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 12:41:00 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: drop unnecessary API wrapper and
 return value
Thread-Topic: [PATCH 1/2] drm/amd/powerplay: drop unnecessary API wrapper and
 return value
Thread-Index: AQHVqojGcqy2c9qKMUuFrmLaxXghuqep5zjU
Date: Wed, 4 Dec 2019 12:41:00 +0000
Message-ID: <MN2PR12MB32961EFFD79528A4EFF4BF5AA25D0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191204095339.25497-1-evan.quan@amd.com>
In-Reply-To: <20191204095339.25497-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-04T12:40:59.561Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
x-originating-ip: [58.246.141.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8ebb9f3-85e8-4714-b2dc-08d778b7378d
x-ms-traffictypediagnostic: MN2PR12MB2973:|MN2PR12MB2973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29738794CA9689499A0B9058A25D0@MN2PR12MB2973.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(6636002)(8936002)(33656002)(8676002)(81156014)(81166006)(74316002)(19627405001)(6306002)(55016002)(2501003)(6246003)(7736002)(229853002)(54896002)(9686003)(6436002)(45080400002)(66446008)(64756008)(91956017)(66556008)(76176011)(66946007)(66476007)(76116006)(53546011)(102836004)(26005)(99286004)(186003)(5660300002)(86362001)(7696005)(6506007)(316002)(478600001)(14454004)(25786009)(3846002)(966005)(71190400001)(71200400001)(11346002)(6116002)(2906002)(52536014)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2973;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtTZhyrbOi28U13M5seEwsJJBKUacXMBw1aW+axqYNAo5ymeblSPBwDEYdfmayV2TK3ZX6xUWrO9lZTB+FTBdgczGLmBBeYTxw1dkmnTfNzTdegh3h06Fb9ghvyPSKrQ/siaEtHj44IjdtbVrptG/JWuj+w5HzswBGo0v01N/ArFy2ALjj5CYLuMGIZl2VObvWViK449uvchkkZLlIGc6l5GZp/hFmD7cIWVS8D4oCr2cdlcvrYnZ2Gt9SMTzfuBUkillhV25mWGorBVieEJ3eAl+XNgQwi9MaDtkP73BzhHyvQNqypaOF7vueSXsIkHs22OKg9jBW3SjP3UW34Hht/0cj2H6wz6D8Kzwfa+5tLg7WqZrDscPdwFnC8Fbg1J/jf/dBvVxgD6p+taQtt3+Ximyoj/YCLp62RCHOeeJTAfUrYMvExcW3/F/k9vlkqM6W9cGNTWCOoXUYzILjPxX0HkejuIgJZx/Zi7nwi9nXE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ebb9f3-85e8-4714-b2dc-08d778b7378d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 12:41:00.0867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAdsOXAc/C+njMNvVXFaPX9+EDvoJs7hmUC+qCn8PgzAapYdkIFPfiYDGw/xDPNu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0SOy7obPLE/LMe/MheuoQ9VAHgGIRuQhgWiuEkcbwQ=;
 b=vSPU+MRdzDQupsrItjoFt+ox3kDB9eVmWU+J3hmHUzv08hvVVJqpnEsYCespx3rkQBl/HQ56QmeHfglJmY+ecUEQ75JNuScCuoPtKVy4yLi0qVZfGDaQJd+xgWXQ8srL3HLWNYpIv3z/mPgE722X69QSOL1rNdXgg0SxLe/Ctyg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0848204343=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0848204343==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32961EFFD79528A4EFF4BF5AA25D0MN2PR12MB3296namp_"

--_000_MN2PR12MB32961EFFD79528A4EFF4BF5AA25D0MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

this change doesn't make sense, and if you really think the return value is=
 useless.
It is more reasonable to accept parameters with return value, not parameter=
.
I think these two patches make the code look worse, unless there's a bug in=
 it.

add @Huang, Ray<mailto:Ray.Huang@amd.com> double check.

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Wednesday, December 4, 2019 5:53 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/powerplay: drop unnecessary API wrapper and re=
turn value

Some minor cosmetic fixes.

Change-Id: I3ec217289f4cb491720430f2d0b0b4efe5e2b9aa
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 12 ++----
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 39 +++++--------------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 22 ++---------
 6 files changed, 19 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 2dd960e85a24..00a0df9b41c9 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -198,9 +198,7 @@ int smu_get_smc_version(struct smu_context *smu, uint32=
_t *if_version, uint32_t
                 if (ret)
                         return ret;

-               ret =3D smu_read_smc_arg(smu, if_version);
-               if (ret)
-                       return ret;
+               smu_read_smc_arg(smu, if_version);
         }

         if (smu_version) {
@@ -208,9 +206,7 @@ int smu_get_smc_version(struct smu_context *smu, uint32=
_t *if_version, uint32_t
                 if (ret)
                         return ret;

-               ret =3D smu_read_smc_arg(smu, smu_version);
-               if (ret)
-                       return ret;
+               smu_read_smc_arg(smu, smu_version);
         }

         return ret;
@@ -339,9 +335,7 @@ int smu_get_dpm_freq_by_index(struct smu_context *smu, =
enum smu_clk_type clk_typ
         if (ret)
                 return ret;

-       ret =3D smu_read_smc_arg(smu, &param);
-       if (ret)
-               return ret;
+       smu_read_smc_arg(smu, &param);

         /* BIT31:  0 - Fine grained DPM, 1 - Dicrete DPM
          * now, we un-support it */
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index ca3fdc6777cf..e7b18b209bc7 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -502,7 +502,7 @@ struct pptable_funcs {
         int (*system_features_control)(struct smu_context *smu, bool en);
         int (*send_smc_msg_with_param)(struct smu_context *smu,
                                        enum smu_message_type msg, uint32_t=
 param);
-       int (*read_smc_arg)(struct smu_context *smu, uint32_t *arg);
+       void (*read_smc_arg)(struct smu_context *smu, uint32_t *arg);
         int (*init_display_count)(struct smu_context *smu, uint32_t count)=
;
         int (*set_allowed_mask)(struct smu_context *smu);
         int (*get_enabled_mask)(struct smu_context *smu, uint32_t *feature=
_mask, uint32_t num);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index 610e301a5fce..4160147a03f3 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -183,7 +183,7 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
                               enum smu_message_type msg,
                               uint32_t param);

-int smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg);
+void smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg);

 int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count);

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v12_0.h
index 922973b7e29f..710af2860a8f 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -40,7 +40,7 @@ struct smu_12_0_cmn2aisc_mapping {
 int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,
                                               uint16_t msg);

-int smu_v12_0_read_arg(struct smu_context *smu, uint32_t *arg);
+void smu_v12_0_read_arg(struct smu_context *smu, uint32_t *arg);

 int smu_v12_0_wait_for_response(struct smu_context *smu);

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 8683e0678b56..325ec4864f90 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -53,20 +53,11 @@ MODULE_FIRMWARE("amdgpu/navi12_smc.bin");

 #define SMU11_VOLTAGE_SCALE 4

-static int smu_v11_0_send_msg_without_waiting(struct smu_context *smu,
-                                             uint16_t msg)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
-       return 0;
-}
-
-int smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg)
+void smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg)
 {
         struct amdgpu_device *adev =3D smu->adev;

         *arg =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
-       return 0;
 }

 static int smu_v11_0_wait_for_response(struct smu_context *smu)
@@ -109,7 +100,7 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,

         WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);

-       smu_v11_0_send_msg_without_waiting(smu, (uint16_t)index);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, (uint16_t)index);

         ret =3D smu_v11_0_wait_for_response(smu);
         if (ret)
@@ -843,16 +834,12 @@ int smu_v11_0_get_enabled_mask(struct smu_context *sm=
u,
         ret =3D smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh);
         if (ret)
                 return ret;
-       ret =3D smu_read_smc_arg(smu, &feature_mask_high);
-       if (ret)
-               return ret;
+       smu_read_smc_arg(smu, &feature_mask_high);

         ret =3D smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow);
         if (ret)
                 return ret;
-       ret =3D smu_read_smc_arg(smu, &feature_mask_low);
-       if (ret)
-               return ret;
+       smu_read_smc_arg(smu, &feature_mask_low);

         feature_mask[0] =3D feature_mask_low;
         feature_mask[1] =3D feature_mask_high;
@@ -924,9 +911,7 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context =
*smu, uint32_t *clock,
                 return ret;
         }

-       ret =3D smu_read_smc_arg(smu, clock);
-       if (ret)
-               return ret;
+       smu_read_smc_arg(smu, clock);

         if (*clock !=3D 0)
                 return 0;
@@ -939,7 +924,7 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context =
*smu, uint32_t *clock,
                 return ret;
         }

-       ret =3D smu_read_smc_arg(smu, clock);
+       smu_read_smc_arg(smu, clock);

         return ret;
 }
@@ -1107,9 +1092,7 @@ int smu_v11_0_get_current_clk_freq(struct smu_context=
 *smu,
                 if (ret)
                         return ret;

-               ret =3D smu_read_smc_arg(smu, &freq);
-               if (ret)
-                       return ret;
+               smu_read_smc_arg(smu, &freq);
         }

         freq *=3D 100;
@@ -1749,18 +1732,14 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_cont=
ext *smu, enum smu_clk_type c
                 ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpm=
Freq, param);
                 if (ret)
                         goto failed;
-               ret =3D smu_read_smc_arg(smu, max);
-               if (ret)
-                       goto failed;
+               smu_read_smc_arg(smu, max);
         }

         if (min) {
                 ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpm=
Freq, param);
                 if (ret)
                         goto failed;
-               ret =3D smu_read_smc_arg(smu, min);
-               if (ret)
-                       goto failed;
+               smu_read_smc_arg(smu, min);
         }

 failed:
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c
index 269a7d73b58d..7f5f7e12a41e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -41,21 +41,11 @@
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK          0x00000006L
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT        0x1

-int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,
-                                             uint16_t msg)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-
-       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
-       return 0;
-}
-
-int smu_v12_0_read_arg(struct smu_context *smu, uint32_t *arg)
+void smu_v12_0_read_arg(struct smu_context *smu, uint32_t *arg)
 {
         struct amdgpu_device *adev =3D smu->adev;

         *arg =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
-       return 0;
 }

 int smu_v12_0_wait_for_response(struct smu_context *smu)
@@ -98,7 +88,7 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu,

         WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);

-       smu_v12_0_send_msg_without_waiting(smu, (uint16_t)index);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, (uint16_t)index);

         ret =3D smu_v12_0_wait_for_response(smu);
         if (ret)
@@ -352,9 +342,7 @@ int smu_v12_0_get_dpm_ultimate_freq(struct smu_context =
*smu, enum smu_clk_type c
                                 pr_err("Attempt to get max GX frequency fr=
om SMC Failed !\n");
                                 goto failed;
                         }
-                       ret =3D smu_read_smc_arg(smu, max);
-                       if (ret)
-                               goto failed;
+                       smu_read_smc_arg(smu, max);
                         break;
                 case SMU_UCLK:
                 case SMU_FCLK:
@@ -383,9 +371,7 @@ int smu_v12_0_get_dpm_ultimate_freq(struct smu_context =
*smu, enum smu_clk_type c
                                 pr_err("Attempt to get min GX frequency fr=
om SMC Failed !\n");
                                 goto failed;
                         }
-                       ret =3D smu_read_smc_arg(smu, min);
-                       if (ret)
-                               goto failed;
+                       smu_read_smc_arg(smu, min);
                         break;
                 case SMU_UCLK:
                 case SMU_FCLK:
--
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cb2381beaed6e4f83074608d7789fe6ef%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637110500489978071&amp;sdata=3DU15cqXp2n00LRZDeu2482cwoZ=
mEIrXWHCgF4NFap%2BkQ%3D&amp;reserved=3D0

--_000_MN2PR12MB32961EFFD79528A4EFF4BF5AA25D0MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">this change doesn't make
 sense,&nbsp;</span><span style=3D"background-color: rgba(0, 0, 0, 0); colo=
r: rgb(50, 49, 48); font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt;">and i=
f you
 really think the return value is useless.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div></div>
</div>
<span>It is more reasonable to accept parameters with return value, not par=
ameter.</span>
<div><span><span>I think these two patches make the code look worse,&nbsp;<=
/span></span>unless there's a bug in it.</div>
<div><br>
</div>
<div>add&nbsp;<a id=3D"OWAAM161346" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mentio=
n ms-bgc-nlr ms-fcl-b" href=3D"mailto:Ray.Huang@amd.com">@Huang, Ray</a>&nb=
sp;double check.<br>
</div>
<div><span><u><span></span><br>
</u></span></div>
<div><span>Best Regards,<br>
Kevin<br>
</span>
<div><br>
</div>
<span></span>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, December 4, 2019 5:53 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/powerplay: drop unnecessary API wrapper=
 and return value</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Some minor cosmetic fixes.<br>
<br>
Change-Id: I3ec217289f4cb491720430f2d0b0b4efe5e2b9aa<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; | 12 &#4=
3;&#43;----<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&nbsp; =
2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 3=
9 &#43;&#43;&#43;&#43;&#43;--------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 2=
2 &#43;&#43;---------<br>
&nbsp;6 files changed, 19 insertions(&#43;), 60 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 2dd960e85a24..00a0df9b41c9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -198,9 &#43;198,7 @@ int smu_get_smc_version(struct smu_context *smu, ui=
nt32_t *if_version, uint32_t<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_read_smc_arg(smu, if_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_read_smc_arg(smu, if_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_version) {<br>
@@ -208,9 &#43;206,7 @@ int smu_get_smc_version(struct smu_context *smu, ui=
nt32_t *if_version, uint32_t<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_read_smc_arg(smu, smu_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_read_smc_arg(smu, smu_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -339,9 &#43;335,7 @@ int smu_get_dpm_freq_by_index(struct smu_context *s=
mu, enum smu_clk_type clk_typ<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_read_smc_arg(smu, &amp;pa=
ram);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_read_smc_arg(smu, &amp;param)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BIT31:&nbsp; 0 - Fine g=
rained DPM, 1 - Dicrete DPM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * now, we un-support=
 it */<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index ca3fdc6777cf..e7b18b209bc7 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -502,7 &#43;502,7 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*system_features_cont=
rol)(struct smu_context *smu, bool en);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*send_smc_msg_with_pa=
ram)(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; enum smu_message_type msg, uint32_t param);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*read_smc_arg)(struct smu_contex=
t *smu, uint32_t *arg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*read_smc_arg)(struct smu_c=
ontext *smu, uint32_t *arg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*init_display_count)(=
struct smu_context *smu, uint32_t count);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_allowed_mask)(st=
ruct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_enabled_mask)(st=
ruct smu_context *smu, uint32_t *feature_mask, uint32_t num);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index 610e301a5fce..4160147a03f3 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -183,7 &#43;183,7 @@ smu_v11_0_send_msg_with_param(struct smu_context *s=
mu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_message_type msg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param);<br>
&nbsp;<br>
-int smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg);<br>
&#43;void smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg);<br>
&nbsp;<br>
&nbsp;int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t co=
unt);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v12_0.h<br>
index 922973b7e29f..710af2860a8f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h<br>
@@ -40,7 &#43;40,7 @@ struct smu_12_0_cmn2aisc_mapping {<br>
&nbsp;int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t msg);<br>
&nbsp;<br>
-int smu_v12_0_read_arg(struct smu_context *smu, uint32_t *arg);<br>
&#43;void smu_v12_0_read_arg(struct smu_context *smu, uint32_t *arg);<br>
&nbsp;<br>
&nbsp;int smu_v12_0_wait_for_response(struct smu_context *smu);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 8683e0678b56..325ec4864f90 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -53,20 &#43;53,11 @@ MODULE_FIRMWARE(&quot;amdgpu/navi12_smc.bin&quot;);=
<br>
&nbsp;<br>
&nbsp;#define SMU11_VOLTAGE_SCALE 4<br>
&nbsp;<br>
-static int smu_v11_0_send_msg_without_waiting(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t msg)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_66, msg);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg)<br>
&#43;void smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *arg =3D RREG32_SOC15(MP1,=
 0, mmMP1_SMN_C2PMSG_82);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu_v11_0_wait_for_response(struct smu_context *smu)<br>
@@ -109,7 &#43;100,7 @@ smu_v11_0_send_msg_with_param(struct smu_context *s=
mu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1=
_SMN_C2PMSG_82, param);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_send_msg_without_waiting(sm=
u, (uint16_t)index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_66, (uint16_t)index);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_wait_for=
_response(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -843,16 &#43;834,12 @@ int smu_v11_0_get_enabled_mask(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg(s=
mu, SMU_MSG_GetEnabledSmuFeaturesHigh);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_read_smc_arg(smu, &amp;fe=
ature_mask_high);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_read_smc_arg(smu, &amp;featur=
e_mask_high);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg(s=
mu, SMU_MSG_GetEnabledSmuFeaturesLow);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_read_smc_arg(smu, &amp;fe=
ature_mask_low);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_read_smc_arg(smu, &amp;featur=
e_mask_low);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask[0] =3D featur=
e_mask_low;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask[1] =3D featur=
e_mask_high;<br>
@@ -924,9 &#43;911,7 @@ smu_v11_0_get_max_sustainable_clock(struct smu_cont=
ext *smu, uint32_t *clock,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_read_smc_arg(smu, clock);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_read_smc_arg(smu, clock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*clock !=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -939,7 &#43;924,7 @@ smu_v11_0_get_max_sustainable_clock(struct smu_cont=
ext *smu, uint32_t *clock,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_read_smc_arg(smu, clock);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_read_smc_arg(smu, clock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -1107,9 &#43;1092,7 @@ int smu_v11_0_get_current_clk_freq(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_read_smc_arg(smu, &amp;freq);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_read_smc_arg(smu, &amp;freq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq *=3D 100;<br>
@@ -1749,18 &#43;1732,14 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_=
context *smu, enum smu_clk_type c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_GetM=
axDpmFreq, param);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
failed;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_read_smc_arg(smu, max);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_read_smc_arg(smu, max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (min) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_GetM=
inDpmFreq, param);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
failed;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_read_smc_arg(smu, min);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_read_smc_arg(smu, min);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;failed:<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c<br>
index 269a7d73b58d..7f5f7e12a41e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
@@ -41,21 &#43;41,11 @@<br>
&nbsp;#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000006L<br>
&nbsp;#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0x1<br>
&nbsp;<br>
-int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t msg)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_66, msg);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int smu_v12_0_read_arg(struct smu_context *smu, uint32_t *arg)<br>
&#43;void smu_v12_0_read_arg(struct smu_context *smu, uint32_t *arg)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *arg =3D RREG32_SOC15(MP1,=
 0, mmMP1_SMN_C2PMSG_82);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_v12_0_wait_for_response(struct smu_context *smu)<br>
@@ -98,7 &#43;88,7 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu=
,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1=
_SMN_C2PMSG_82, param);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v12_0_send_msg_without_waiting(sm=
u, (uint16_t)index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_66, (uint16_t)index);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v12_0_wait_for=
_response(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -352,9 &#43;342,7 @@ int smu_v12_0_get_dpm_ultimate_freq(struct smu_cont=
ext *smu, enum smu_clk_type c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Attempt to get max =
GX frequency from SMC Failed !\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_read=
_smc_arg(smu, max);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_read_smc=
_arg(smu, max);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_UCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
@@ -383,9 &#43;371,7 @@ int smu_v12_0_get_dpm_ultimate_freq(struct smu_cont=
ext *smu, enum smu_clk_type c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Attempt to get min =
GX frequency from SMC Failed !\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_read=
_smc_arg(smu, min);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_read_smc=
_arg(smu, min);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_UCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
-- <br>
2.24.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cb2381beaed6e4f83074608d7789fe6ef%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637110500489978071&amp;amp;sdata=3DU15cqX=
p2n00LRZDeu2482cwoZmEIrXWHCgF4NFap%2BkQ%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7Cb2381beaed6e4f83074608d7789fe6ef%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637110500489978071&amp;amp;sdata=3DU15cqXp2n00LRZDeu2482cwoZmE=
IrXWHCgF4NFap%2BkQ%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB32961EFFD79528A4EFF4BF5AA25D0MN2PR12MB3296namp_--

--===============0848204343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0848204343==--
