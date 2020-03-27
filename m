Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539BFC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 13:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225772082D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 13:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xc6dunuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225772082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4F66EA2D;
	Fri, 27 Mar 2020 13:29:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 710F36EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 13:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgszKzfOqTvcpn7NYcl1FprvRpA7Mq6YBCD68wNPo+0S9bs3vWwnhMD+vnz8eYSfmOr54fc+hLmhytJ9lD2Oxu2zMDOYD3xzbeOsQknNW7DXKRUawV/SNdp3xWA/lCX6D7N1TjFDzC+Jdo8xq4FM1IKgitpE5goaKl6KY0afloj7/Gt7G2lYc7Bb9zJ7B9qkxIOWRL42pduQEn5ybiFgH24ceBIgF9Ktfovo0FU9Zfx6pyyYknAW47ziqaltue6gJZuGtIW5p6OPSTI8Gi7KSR8K7zS3bq8GcVP1/hG9Vmzb7C7Udfr7BU8V693qFq2V0j/w2JW3oe6uiHWhQo+KmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B3PzfhCh0nlOIqvIPO2ytgsgRBDVFgJUYJNS91JjrI=;
 b=ftK8kUFuoJ6QaEOa4l6i99++JGPUmp9PuemWZv84dfokhgP+P4rvvFISGE68n6PqlYyLTTLpqvXrdpudR8ZvkOLEkYBbsqRJeGRzUPLf5l000XGywkCNKT+FYEH37cTgVOntZeaWIfOd5l8odAUoEbw0Ndx7PGMeQeVk/7Vq2af/MD2kzSAw8A/MSzmL/k6U89IlbNrVQ5ojkbCnF5HEIvfiEVmyQ/AGGvulrDg6eNxnTDjIH2GMqMIvE708mUv1DV3Nwgp50wqAJCO6h98CT1Gk4z5IcjskvW5kfYiCRpO9pC6IzQrZIzkhzvmtzSW8Aa8SiEY/asp6PocZp2l1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B3PzfhCh0nlOIqvIPO2ytgsgRBDVFgJUYJNS91JjrI=;
 b=xc6dunuYqByuW96xB4RJn77uER+zSj3tMMGggfhMF3uKHb3y+X+uShFe+EKSslIZHmP7fGIbe2C2iflPAcYOObtHwdNJrE8zUivMKA9s/PHBB6uH5mo8vAQGGKQ+63xn0E/pudu3nLc2NgVMD74bXv3KBsFuTZcRdvcz4xuqcvc=
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 27 Mar
 2020 13:29:00 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::d93f:b1ab:5d38:f931]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::d93f:b1ab:5d38:f931%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 13:29:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: move the ASIC specific nbio
 operation out of smu_v11_0.c
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: move the ASIC specific nbio
 operation out of smu_v11_0.c
Thread-Index: AQHWBA1ddWQ5cSjb2Eawoeazh5HYQ6hcbyPo
Date: Fri, 27 Mar 2020 13:29:00 +0000
Message-ID: <MW3PR12MB449168D71AD8C8EEEA0FAFF7F7CC0@MW3PR12MB4491.namprd12.prod.outlook.com>
References: <20200327075701.17821-1-evan.quan@amd.com>,
 <20200327075701.17821-2-evan.quan@amd.com>
In-Reply-To: <20200327075701.17821-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-27T13:28:59.488Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ff35b5c-c050-4766-ee44-08d7d252cf48
x-ms-traffictypediagnostic: MW3PR12MB4476:|MW3PR12MB4476:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB4476E04EE32902FF1F188A40F7CC0@MW3PR12MB4476.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(52536014)(7696005)(33656002)(76116006)(186003)(66476007)(66446008)(26005)(66946007)(5660300002)(110136005)(2906002)(45080400002)(71200400001)(53546011)(6506007)(64756008)(8936002)(9686003)(81156014)(478600001)(66556008)(316002)(55016002)(19627405001)(81166006)(966005)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW3PR12MB4476;
 H:MW3PR12MB4491.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cIHaVJT96UryKHuNL/rypYfiKL/cTY65op0t5F5ofZSx1jzc8vbfkF7sQBqWsGlPgXY97j/jni2HzdZag+5/qB43WU+reNKovmfMyZmAst39hcX+a8r+FpuiVd4ms2xf9cGdIalCb2RhxcP5C3SgExtN6kE8LYbVIYCA29DwgNr9BMZSM4LSgfXRvzRcQSBq+TRilnIodaKHlrKF2BPu6jOH/tHlUUPm7VYkG2q8xC10I2cCzE+hbDpeRF+F4T5oi3iXxFdjgbeZMITWxSsBalfB/KWbANUuIBVr9car+gEap+u2DgWW09xu34V8pzmkrIbKG09deuGTQbwmjFwxSbDvlU3jrDlwak0dwPev3DHaBYStcoGsFVapxUbNcG8wqPcMSiCE9GUttRh0TgN1jjLiw1wKecFl9fZfj+Ge3psIr9NGL6tNa+Mrx7FjerkozafflNqP4+T5hwkq+zJDUh9jxlD5Y820l5Ek4mCktQs=
x-ms-exchange-antispam-messagedata: tiCEwW89raskWlGxMUqnEnM2XGK18p9S7dYcjafOiSdUlZb+kzXPlpZV2zKEaHVGEWc+0Zn2L6XH4mgUySJtFKz00pScPl+IT3LxQxW3dNBWiUe/539r9uJayyU5cZNtIB3XqwJERhqlLEnXIFSr5A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff35b5c-c050-4766-ee44-08d7d252cf48
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 13:29:00.1993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55je9mvC0SKf/gOz/BdHp0kmC+5ShOKinOii1U8J1L7pQnkRGfZM7r/jzzEzwWCH7lktOCPWRrAWGwMz+ZYVbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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
Content-Type: multipart/mixed; boundary="===============0758388332=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0758388332==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB449168D71AD8C8EEEA0FAFF7F7CC0MW3PR12MB4491namp_"

--_000_MW3PR12MB449168D71AD8C8EEEA0FAFF7F7CC0MW3PR12MB4491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Friday, March 27, 2020 3:57 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amd/powerplay: move the ASIC specific nbio operati=
on out of smu_v11_0.c

This is ASIC specific and should be placed in _ppt.c of each ASIC.

Change-Id: If2b29ccf0dfc0dc90e1636a806b13ce2efed58c6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c   | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c    | 10 +---------
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c   | 14 +++++++++++++-
 4 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index c6d3bef15320..5db8c56066ee 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -35,6 +35,7 @@
 #include "arcturus_ppt.h"
 #include "smu_v11_0_pptable.h"
 #include "arcturus_ppsmc.h"
+#include "nbio/nbio_7_4_offset.h"
 #include "nbio/nbio_7_4_sh_mask.h"
 #include "amdgpu_xgmi.h"
 #include <linux/i2c.h>
@@ -2210,6 +2211,18 @@ static void arcturus_i2c_eeprom_control_fini(struct =
i2c_adapter *control)
         i2c_del_adapter(control);
 }

+static bool arcturus_is_baco_supported(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t val;
+
+       if (!smu_v11_0_baco_is_support(smu))
+               return false;
+
+       val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
+       return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false=
;
+}
+
 static uint32_t arcturus_get_pptable_power_limit(struct smu_context *smu)
 {
         PPTable_t *pptable =3D smu->smu_table.driver_pptable;
@@ -2321,7 +2334,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
         .register_irq_handler =3D smu_v11_0_register_irq_handler,
         .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
         .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sustainabl=
e_clocks_by_dc,
-       .baco_is_support=3D smu_v11_0_baco_is_support,
+       .baco_is_support=3D arcturus_is_baco_supported,
         .baco_get_state =3D smu_v11_0_baco_get_state,
         .baco_set_state =3D smu_v11_0_baco_set_state,
         .baco_enter =3D smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 1112e4c5f4d7..c94270f7c198 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -28,13 +28,15 @@
 #include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
+#include "soc15_common.h"
 #include "smu_v11_0.h"
 #include "smu11_driver_if_navi10.h"
 #include "atom.h"
 #include "navi10_ppt.h"
 #include "smu_v11_0_pptable.h"
 #include "smu_v11_0_ppsmc.h"
-#include "nbio/nbio_7_4_sh_mask.h"
+#include "nbio/nbio_2_3_offset.h"
+#include "nbio/nbio_2_3_sh_mask.h"

 #include "asic_reg/mp/mp_11_0_sh_mask.h"

@@ -1942,6 +1944,18 @@ static int navi10_setup_od_limits(struct smu_context=
 *smu) {
         return 0;
 }

+static bool navi10_is_baco_supported(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t val;
+
+       if (!smu_v11_0_baco_is_support(smu))
+               return false;
+
+       val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
+       return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false=
;
+}
+
 static int navi10_set_default_od_settings(struct smu_context *smu, bool in=
itialize) {
         OverDriveTable_t *od_table, *boot_od_table;
         int ret =3D 0;
@@ -2318,7 +2332,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
         .register_irq_handler =3D smu_v11_0_register_irq_handler,
         .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
         .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sustainabl=
e_clocks_by_dc,
-       .baco_is_support=3D smu_v11_0_baco_is_support,
+       .baco_is_support=3D navi10_is_baco_supported,
         .baco_get_state =3D smu_v11_0_baco_get_state,
         .baco_set_state =3D smu_v11_0_baco_set_state,
         .baco_enter =3D smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index 31b93cff19d5..655ba4fb05dc 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -42,8 +42,6 @@
 #include "asic_reg/thm/thm_11_0_2_sh_mask.h"
 #include "asic_reg/mp/mp_11_0_offset.h"
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
-#include "asic_reg/nbio/nbio_7_4_offset.h"
-#include "asic_reg/nbio/nbio_7_4_sh_mask.h"
 #include "asic_reg/smuio/smuio_11_0_0_offset.h"
 #include "asic_reg/smuio/smuio_11_0_0_sh_mask.h"

@@ -1662,9 +1660,7 @@ static int smu_v11_0_baco_set_armd3_sequence(struct s=
mu_context *smu, enum smu_v

 bool smu_v11_0_baco_is_support(struct smu_context *smu)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         struct smu_baco_context *smu_baco =3D &smu->smu_baco;
-       uint32_t val;
         bool baco_support;

         mutex_lock(&smu_baco->mutex);
@@ -1679,11 +1675,7 @@ bool smu_v11_0_baco_is_support(struct smu_context *s=
mu)
            !smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
                 return false;

-       val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
-       if (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
-               return true;
-
-       return false;
+       return true;
 }

 enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index 49ff3756bd9f..3f1044326dcb 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -35,6 +35,7 @@
 #include "vega20_ppt.h"
 #include "vega20_pptable.h"
 #include "vega20_ppsmc.h"
+#include "nbio/nbio_7_4_offset.h"
 #include "nbio/nbio_7_4_sh_mask.h"
 #include "asic_reg/thm/thm_11_0_2_offset.h"
 #include "asic_reg/thm/thm_11_0_2_sh_mask.h"
@@ -3174,6 +3175,17 @@ static int vega20_update_pcie_parameters(struct smu_=
context *smu,
         return ret;
 }

+static bool vega20_is_baco_supported(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t val;
+
+       if (!smu_v11_0_baco_is_support(smu))
+               return false;
+
+       val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
+       return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false=
;
+}

 static const struct pptable_funcs vega20_ppt_funcs =3D {
         .tables_init =3D vega20_tables_init,
@@ -3262,7 +3274,7 @@ static const struct pptable_funcs vega20_ppt_funcs =
=3D {
         .register_irq_handler =3D smu_v11_0_register_irq_handler,
         .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
         .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sustainabl=
e_clocks_by_dc,
-       .baco_is_support=3D smu_v11_0_baco_is_support,
+       .baco_is_support=3D vega20_is_baco_supported,
         .baco_get_state =3D smu_v11_0_baco_get_state,
         .baco_set_state =3D smu_v11_0_baco_set_state,
         .baco_enter =3D smu_v11_0_baco_enter,
--
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ccb038ac52dd74c4deb8b08d7d2247db2%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637208926495509214&amp;sdata=3DRWdMDhBZwNdo5bjDkf1=
RQXahEuulClXOCtwKD5i3fmw%3D&amp;reserved=3D0

--_000_MW3PR12MB449168D71AD8C8EEEA0FAFF7F7CC0MW3PR12MB4491namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, March 27, 2020 3:57 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/powerplay: move the ASIC specific nbio =
operation out of smu_v11_0.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This is ASIC specific and should be placed in _ppt=
.c of each ASIC.<br>
<br>
Change-Id: If2b29ccf0dfc0dc90e1636a806b13ce2efed58c6<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 15 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp; | 18 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<b=
r>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp; | 10 &#43=
;---------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp; | 14 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;4 files changed, 44 insertions(&#43;), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index c6d3bef15320..5db8c56066ee 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -35,6 &#43;35,7 @@<br>
&nbsp;#include &quot;arcturus_ppt.h&quot;<br>
&nbsp;#include &quot;smu_v11_0_pptable.h&quot;<br>
&nbsp;#include &quot;arcturus_ppsmc.h&quot;<br>
&#43;#include &quot;nbio/nbio_7_4_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_7_4_sh_mask.h&quot;<br>
&nbsp;#include &quot;amdgpu_xgmi.h&quot;<br>
&nbsp;#include &lt;linux/i2c.h&gt;<br>
@@ -2210,6 &#43;2211,18 @@ static void arcturus_i2c_eeprom_control_fini(str=
uct i2c_adapter *control)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_del_adapter(control);<=
br>
&nbsp;}<br>
&nbsp;<br>
&#43;static bool arcturus_is_baco_supported(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_v11_0_baco_is_support(sm=
u))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mmR=
CC_BIF_STRAP0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (val &amp; RCC_BIF_STRAP0_=
_STRAP_PX_CAPABLE_MASK) ? true : false;<br>
&#43;}<br>
&#43;<br>
&nbsp;static uint32_t arcturus_get_pptable_power_limit(struct smu_context *=
smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D smu=
-&gt;smu_table.driver_pptable;<br>
@@ -2321,7 &#43;2334,7 @@ static const struct pptable_funcs arcturus_ppt_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D =
smu_v11_0_register_irq_handler,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu=
_v11_0_set_azalia_d3_pme,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clock=
s_by_dc =3D smu_v11_0_get_max_sustainable_clocks_by_dc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D smu_v11_0_baco_is=
_support,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D arcturus_is_b=
aco_supported,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v1=
1_0_baco_get_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v1=
1_0_baco_set_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v11_0_=
baco_enter,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 1112e4c5f4d7..c94270f7c198 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -28,13 &#43;28,15 @@<br>
&nbsp;#include &quot;smu_internal.h&quot;<br>
&nbsp;#include &quot;atomfirmware.h&quot;<br>
&nbsp;#include &quot;amdgpu_atomfirmware.h&quot;<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;smu_v11_0.h&quot;<br>
&nbsp;#include &quot;smu11_driver_if_navi10.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&nbsp;#include &quot;navi10_ppt.h&quot;<br>
&nbsp;#include &quot;smu_v11_0_pptable.h&quot;<br>
&nbsp;#include &quot;smu_v11_0_ppsmc.h&quot;<br>
-#include &quot;nbio/nbio_7_4_sh_mask.h&quot;<br>
&#43;#include &quot;nbio/nbio_2_3_offset.h&quot;<br>
&#43;#include &quot;nbio/nbio_2_3_sh_mask.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;asic_reg/mp/mp_11_0_sh_mask.h&quot;<br>
&nbsp;<br>
@@ -1942,6 &#43;1944,18 @@ static int navi10_setup_od_limits(struct smu_con=
text *smu) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static bool navi10_is_baco_supported(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_v11_0_baco_is_support(sm=
u))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mmR=
CC_BIF_STRAP0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (val &amp; RCC_BIF_STRAP0_=
_STRAP_PX_CAPABLE_MASK) ? true : false;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int navi10_set_default_od_settings(struct smu_context *smu, bo=
ol initialize) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *od_table=
, *boot_od_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2318,7 &#43;2332,7 @@ static const struct pptable_funcs navi10_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D =
smu_v11_0_register_irq_handler,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu=
_v11_0_set_azalia_d3_pme,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clock=
s_by_dc =3D smu_v11_0_get_max_sustainable_clocks_by_dc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D smu_v11_0_baco_is=
_support,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D navi10_is_bac=
o_supported,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v1=
1_0_baco_get_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v1=
1_0_baco_set_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v11_0_=
baco_enter,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index 31b93cff19d5..655ba4fb05dc 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -42,8 &#43;42,6 @@<br>
&nbsp;#include &quot;asic_reg/thm/thm_11_0_2_sh_mask.h&quot;<br>
&nbsp;#include &quot;asic_reg/mp/mp_11_0_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/mp/mp_11_0_sh_mask.h&quot;<br>
-#include &quot;asic_reg/nbio/nbio_7_4_offset.h&quot;<br>
-#include &quot;asic_reg/nbio/nbio_7_4_sh_mask.h&quot;<br>
&nbsp;#include &quot;asic_reg/smuio/smuio_11_0_0_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/smuio/smuio_11_0_0_sh_mask.h&quot;<br>
&nbsp;<br>
@@ -1662,9 &#43;1660,7 @@ static int smu_v11_0_baco_set_armd3_sequence(stru=
ct smu_context *smu, enum smu_v<br>
&nbsp;<br>
&nbsp;bool smu_v11_0_baco_is_support(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *s=
mu_baco =3D &amp;smu-&gt;smu_baco;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool baco_support;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&=
gt;mutex);<br>
@@ -1679,11 &#43;1675,7 @@ bool smu_v11_0_baco_is_support(struct smu_contex=
t *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !smu_fea=
ture_is_enabled(smu, SMU_FEATURE_BACO_BIT))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mmRCC_B=
IF_STRAP0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (val &amp; RCC_BIF_STRAP0__STRAP_P=
X_CAPABLE_MASK)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)=
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index 49ff3756bd9f..3f1044326dcb 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -35,6 &#43;35,7 @@<br>
&nbsp;#include &quot;vega20_ppt.h&quot;<br>
&nbsp;#include &quot;vega20_pptable.h&quot;<br>
&nbsp;#include &quot;vega20_ppsmc.h&quot;<br>
&#43;#include &quot;nbio/nbio_7_4_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_7_4_sh_mask.h&quot;<br>
&nbsp;#include &quot;asic_reg/thm/thm_11_0_2_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/thm/thm_11_0_2_sh_mask.h&quot;<br>
@@ -3174,6 &#43;3175,17 @@ static int vega20_update_pcie_parameters(struct =
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static bool vega20_is_baco_supported(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_v11_0_baco_is_support(sm=
u))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mmR=
CC_BIF_STRAP0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (val &amp; RCC_BIF_STRAP0_=
_STRAP_PX_CAPABLE_MASK) ? true : false;<br>
&#43;}<br>
&nbsp;<br>
&nbsp;static const struct pptable_funcs vega20_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tables_init =3D vega20_ta=
bles_init,<br>
@@ -3262,7 &#43;3274,7 @@ static const struct pptable_funcs vega20_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D =
smu_v11_0_register_irq_handler,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu=
_v11_0_set_azalia_d3_pme,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clock=
s_by_dc =3D smu_v11_0_get_max_sustainable_clocks_by_dc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D smu_v11_0_baco_is=
_support,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D vega20_is_bac=
o_supported,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v1=
1_0_baco_get_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v1=
1_0_baco_set_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v11_0_=
baco_enter,<br>
-- <br>
2.26.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ccb038ac52dd74c4deb8b08d7d2247db2%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637208926495509214&amp;amp;sdata=3D=
RWdMDhBZwNdo5bjDkf1RQXahEuulClXOCtwKD5i3fmw%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7Ccb038ac52dd74c4deb8b08d7d2247db2%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637208926495509214&amp;amp;sdata=3DRWdMDhBZwNdo5bjDk=
f1RQXahEuulClXOCtwKD5i3fmw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB449168D71AD8C8EEEA0FAFF7F7CC0MW3PR12MB4491namp_--

--===============0758388332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0758388332==--
