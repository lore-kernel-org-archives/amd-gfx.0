Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AA7C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 13:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F122082F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 13:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ecLSFvnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F122082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950466E430;
	Thu, 18 Jun 2020 13:59:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A5D6E430
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 13:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avwVHMX9/ewoRIRWRyPgrUe8vyWaiPxYcfwJt6QWyJtpBtfyU2i4BaJeNbqPFv8ONfcp2VfTgzcKWv3PSnJnVHpm5Z+YnzUbXx5xlFdTbGzlPoKmYVXex4BGHdMieazSwZ92TfFx+vt5c8QIxN7GBBQ7VKXaXDWRA8pKm0582qOfNlrt/j7oBrIsv5O8jpuzclyB9nBGPAjoEPFX/3kuMLtT+33g4VIzM3VQnW4XKL3jae7a8Vx04bFbeXdQ8OJxcpe+qgvZCQWiwlmAOPYkTkqQai5ihvlXtJYqjVQBGqKk3PkZCmlSbNFdoSFZA/wIfWcYu6JZGOEeKYVPaXhOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l59u59mvbyqXzt3LvCIEw/TrUkvKF2Yy968E746gmII=;
 b=ddxgtzSKLc5MfxlUJEDZDRpMmDUccMvtf6CYd+Ost+5prbI5AMRpdbFyBMOIwdNRbYpkDx1T08EShUISEKPFumvbGTBXFoMTgCsSBvMkqADu9KuC9aD8si6KiZoG8VY/OKgXYQ0l/0aENTH+bCLZaQ6EdhM6Jn7I99CkvQuZUNjVRmifsRyiYj/hKZfNjnVsx/jiqT9S20sTLgc/l85jRC3BdQeMMG+cIVRkK/yx2GS5VIUDIGTpmBH7+g6whsY60aR4lxNrun0YAj9xjo9J4lcSewPqCEEpU6G5BdhTFW1sDN7/OZv26m2G+3rPKtLCcZAusdhIH/2krlhQTHWVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l59u59mvbyqXzt3LvCIEw/TrUkvKF2Yy968E746gmII=;
 b=ecLSFvnTR5RvbhTwZFCaUiLgWkRiwIFU5j/4UVjRwRmzpUIMqL+rCKUpokEU0ANTrLEIDG2UD/Js8y6t40oIknLl5aycRUMpqzop0L8HVgz0tj2VDwYSFruQhIWCbd6Y9KEvoiHJ6QmSKxvJ97hDYEvYUWs2vYMG6iore3Dix6Q=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3743.namprd12.prod.outlook.com (2603:10b6:208:168::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 13:59:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 13:59:40 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: label internally used symbols as static
Thread-Topic: [PATCH 1/4] drm/amdgpu: label internally used symbols as static
Thread-Index: AQHWRXKnyzz3hmPxeE23r4P624N24ajeZmvp
Date: Thu, 18 Jun 2020 13:59:40 +0000
Message-ID: <MN2PR12MB44888992FE8BC63EE48AA5F6F79B0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200618131712.90389-1-nirmoy.das@amd.com>
In-Reply-To: <20200618131712.90389-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-18T13:59:39.903Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.51.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf023464-9519-45ac-e368-08d8138fd877
x-ms-traffictypediagnostic: MN2PR12MB3743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB374386782717FA1DCB19B484F79B0@MN2PR12MB3743.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:40;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9wF3GCIQXMr+Mhbdk3+tvIhT/5UGYX+qwux9wPINx8OHOsGt4Fc6Pw8l37vef1WbcuzKjDPxL2h40koT+/TGzZyYDdgGViH1EJFPSy9PS/mp/8AIj/AcWdmBE8Suj/vG1BYj0bmYTsvgaeubD/nAtwho82EW06zRQAJ2uzA37KJWT3ECSVSYxZrQawnVPUA2x0Euql5jglJCBprbNtxcFeZ5NTka4Zkzt+R0VN/Lt8y5WgJAzwadCYxNAW8g7zvRh6898iZn7CXnW74LlhW3q/RNZlGcwKypMhR+O3GtPaWtckIZOp/xTcw2VJn/AGSNHmnGCC/mnQrYeOoZ6CqZIL0h1t6WhOcsTJp+re3tQmY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(316002)(83380400001)(966005)(8676002)(53546011)(19627405001)(478600001)(110136005)(8936002)(45080400002)(6506007)(7696005)(166002)(33656002)(2906002)(5660300002)(66446008)(71200400001)(52536014)(26005)(66946007)(76116006)(66476007)(66556008)(64756008)(4326008)(186003)(86362001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: n6BXxsGnTvNq5TWhg/vfKukazqwQJRR5ULP3mk7fOqi6O7c2M6V5k7hJkoJo9cxIgOv79yC3kfzHosk4XEpffPU5Et1zEg2i2mInkMcEcQDoYvhYRoQZ3xPqy8hdOYlgN+Q8rySEpmm1eFL2NjUSH7V5nLtI3yQ499G5VtkyGbDNYxCuDQVVVQZz74aHvJSUTxYs/v6LBpM0YOliFvrN2QKIO3yqbXLvqRXWM5FdRbVLfFCiuK/bGAaH79t/hbCTeVrqEpKsXuBcCU36YGw6P1/tJdA5KBF1mvPJPOULQLk2o0AJULtkqW8v63jhdOaF7E9XREW/0Ysrq3ne4VmtkqqFqZHcECRihq2l6G4xcyb8OcTcNUDuoUhVNUk2/dzs1u6ogftq8b0qbJWCRjSaAwWzy1879nHqB0NNkywMYbPM+ESH6/Q6Fbrn8V/HmCq0IfkgtTJd/BCyrhtXfJovsKtPJog0RVA13WcCXKWFlkcbfHp2c4Mc+xDug1GxgUxf
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf023464-9519-45ac-e368-08d8138fd877
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 13:59:40.4328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzIO9QCxugVtesBEYIFfmaRnkEilKOA0GjLX7cbcBfyhMn7kxg1L7vfmg7rcrjvPOl62phex70ogdYDTfSSddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>
Content-Type: multipart/mixed; boundary="===============2044172914=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2044172914==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44888992FE8BC63EE48AA5F6F79B0MN2PR12MB4488namp_"

--_000_MN2PR12MB44888992FE8BC63EE48AA5F6F79B0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Nirmoy D=
as <nirmoy.aiemd@gmail.com>
Sent: Thursday, June 18, 2020 9:17 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: label internally used symbols as static

Used sparse(make C=3D1) to find these loose ends.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c          | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index b5d6274952a5..4ef38c2411ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -32,7 +32,7 @@
 #define mmMM_DATA               0x1
 #define HW_ID_MAX               300

-const char *hw_id_names[HW_ID_MAX] =3D {
+static const char *hw_id_names[HW_ID_MAX] =3D {
         [MP1_HWID]              =3D "MP1",
         [MP2_HWID]              =3D "MP2",
         [THM_HWID]              =3D "THM",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index 6ae80b33182c..e811fecc540f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -32,7 +32,7 @@
 #define I2C_PRODUCT_INFO_ADDR_SIZE      0x2
 #define I2C_PRODUCT_INFO_OFFSET         0xC0

-bool is_fru_eeprom_supported(struct amdgpu_device *adev)
+static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
         /* TODO: Gaming SKUs don't have the FRU EEPROM.
          * Use this hack to address hangs on modprobe on gaming SKUs
@@ -48,7 +48,7 @@ bool is_fru_eeprom_supported(struct amdgpu_device *adev)
         return false;
 }

-int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
+static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t add=
rptr,
                            unsigned char *buff)
 {
         int ret, size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 60558497f054..0723dee2958b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -583,7 +583,7 @@ static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_c=
md_resp *cmd,
         cmd->cmd.cmd_invoke_cmd.ta_cmd_id        =3D ta_cmd_id;
 }

-int psp_ta_invoke(struct psp_context *psp,
+static int psp_ta_invoke(struct psp_context *psp,
                   uint32_t ta_cmd_id,
                   uint32_t session_id)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 9bfe59b70030..ab8e7c91c645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -86,7 +86,7 @@ void amdgpu_ras_set_error_query_ready(struct amdgpu_devic=
e *adev, bool ready)
                 amdgpu_ras_get_context(adev)->error_query_ready =3D ready;
 }

-bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *adev)
+static bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *adev)
 {
         if (adev && amdgpu_ras_get_context(adev))
                 return amdgpu_ras_get_context(adev)->error_query_ready;
@@ -505,7 +505,7 @@ struct ras_manager *amdgpu_ras_find_obj(struct amdgpu_d=
evice *adev,
 }
 /* obj end */

-void amdgpu_ras_parse_status_code(struct amdgpu_device* adev,
+static void amdgpu_ras_parse_status_code(struct amdgpu_device *adev,
                                   const char*             invoke_type,
                                   const char*             block_name,
                                   enum ta_ras_status      ret)
@@ -815,7 +815,7 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 }

 /* Trigger XGMI/WAFL error */
-int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
+static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
                                  struct ta_ras_trigger_error_input *block_=
info)
 {
         int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 5b42c50366c9..64b572307104 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1113,7 +1113,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt=
 *ttm)
 #endif
 }

-int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
+static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
                                 struct ttm_buffer_object *tbo,
                                 uint64_t flags)
 {
@@ -1835,7 +1835,7 @@ static void amdgpu_ttm_training_data_block_init(struc=
t amdgpu_device *adev)
                 (adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
         ctx->train_data_size =3D
                 GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
-
+
         DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_tra=
in_data_offset:%llx.\n",
                         ctx->train_data_size,
                         ctx->p2c_train_data_offset,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 0891f27ba166..da233a9e429d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -515,12 +515,12 @@ void amdgpu_detect_virtualization(struct amdgpu_devic=
e *adev)
         }
 }

-bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
+static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
 {
         return amdgpu_sriov_is_debug(adev) ? true : false;
 }

-bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev)
+static bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev)
 {
         return amdgpu_sriov_is_normal(adev) ? true : false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c
index 0cc011f9190d..4aec76049a60 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3039,7 +3039,7 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device *a=
dev,
         mqd->cp_hqd_active =3D 1;
 }

-int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd)
+static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd =
*mqd)
 {
         uint32_t tmp;
         uint32_t mqd_reg;
@@ -5209,7 +5209,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device=
 *adev)
         cu_info->lds_size =3D 64;
 }

-const struct amdgpu_ip_block_version gfx_v7_0_ip_block =3D
+static const struct amdgpu_ip_block_version gfx_v7_0_ip_block =3D
 {
         .type =3D AMD_IP_BLOCK_TYPE_GFX,
         .major =3D 7,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 1d4128227ffd..efb759b62d21 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4589,7 +4589,7 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring=
)
         return 0;
 }

-int gfx_v8_0_mqd_commit(struct amdgpu_device *adev,
+static int gfx_v8_0_mqd_commit(struct amdgpu_device *adev,
                         struct vi_mqd *mqd)
 {
         uint32_t mqd_reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index c3e59b765268..99ffc3e1fddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -722,7 +722,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
=3D
         mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };

-void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
+static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32=
 v)
 {
         static void *scratch_reg0;
         static void *scratch_reg1;
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C2d950e88102e4969c83508d81389c7c3%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637280829787212213&amp;sdata=3DC9iEaENRFogB6gKjLTS=
LQx0UM32tsHnCPiOggnL%2Bd04%3D&amp;reserved=3D0

--_000_MN2PR12MB44888992FE8BC63EE48AA5F6F79B0MN2PR12MB4488namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Nirmoy Das &lt;nirmoy.aiemd@g=
mail.com&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 9:17 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/4] drm/amdgpu: label internally used symbols as st=
atic</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Used sparse(make C=3D1) to find these loose ends.<=
br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 6 &#43;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;9 files changed, 15 insertions(&#43;), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index b5d6274952a5..4ef38c2411ae 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -32,7 &#43;32,7 @@<br>
&nbsp;#define mmMM_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1<br>
&nbsp;#define HW_ID_MAX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 300<br>
&nbsp;<br>
-const char *hw_id_names[HW_ID_MAX] =3D {<br>
&#43;static const char *hw_id_names[HW_ID_MAX] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [MP1_HWID]&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;MP=
1&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [MP2_HWID]&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;MP=
2&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [THM_HWID]&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D &quot;TH=
M&quot;,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
index 6ae80b33182c..e811fecc540f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
@@ -32,7 &#43;32,7 @@<br>
&nbsp;#define I2C_PRODUCT_INFO_ADDR_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2<=
br>
&nbsp;#define I2C_PRODUCT_INFO_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0xC0<br>
&nbsp;<br>
-bool is_fru_eeprom_supported(struct amdgpu_device *adev)<br>
&#43;static bool is_fru_eeprom_supported(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Gaming SKUs don't=
 have the FRU EEPROM.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use this hack to a=
ddress hangs on modprobe on gaming SKUs<br>
@@ -48,7 &#43;48,7 @@ bool is_fru_eeprom_supported(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
-int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,<b=
r>
&#43;static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t=
 addrptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; unsigned char *buff)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, size;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 60558497f054..0723dee2958b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -583,7 &#43;583,7 @@ static void psp_prep_ta_invoke_cmd_buf(struct psp_g=
fx_cmd_resp *cmd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_invoke_cmd=
.ta_cmd_id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D ta_cmd_id;<br>
&nbsp;}<br>
&nbsp;<br>
-int psp_ta_invoke(struct psp_context *psp,<br>
&#43;static int psp_ta_invoke(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_cmd_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t session_id)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 9bfe59b70030..ab8e7c91c645 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -86,7 &#43;86,7 @@ void amdgpu_ras_set_error_query_ready(struct amdgpu_d=
evice *adev, bool ready)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_get_context(adev)-&gt;error_query_ready =
=3D ready;<br>
&nbsp;}<br>
&nbsp;<br>
-bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *adev)<br>
&#43;static bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *ade=
v)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev &amp;&amp; amdgpu=
_ras_get_context(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_ras_get_context(adev)-&gt;error_query_r=
eady;<br>
@@ -505,7 &#43;505,7 @@ struct ras_manager *amdgpu_ras_find_obj(struct amdg=
pu_device *adev,<br>
&nbsp;}<br>
&nbsp;/* obj end */<br>
&nbsp;<br>
-void amdgpu_ras_parse_status_code(struct amdgpu_device* adev,<br>
&#43;static void amdgpu_ras_parse_status_code(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char*&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; invoke_type=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char*&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_name,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ta_ras_status&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret)<br>
@@ -815,7 &#43;815,7 @@ int amdgpu_ras_error_query(struct amdgpu_device *ad=
ev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/* Trigger XGMI/WAFL error */<br>
-int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,<br>
&#43;static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_ras_trigger_erro=
r_input *block_info)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 5b42c50366c9..64b572307104 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1113,7 &#43;1113,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct tt=
m_tt *ttm)<br>
&nbsp;#endif<br>
&nbsp;}<br>
&nbsp;<br>
-int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,<br>
&#43;static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *tbo,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags)<br>
&nbsp;{<br>
@@ -1835,7 &#43;1835,7 @@ static void amdgpu_ttm_training_data_block_init(s=
truct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (adev-&gt;gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSE=
T);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_size =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;train_data=
_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n&quot;,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&=
gt;train_data_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&=
gt;p2c_train_data_offset,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 0891f27ba166..da233a9e429d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -515,12 &#43;515,12 @@ void amdgpu_detect_virtualization(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)<br>
&#43;static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_sriov_is_deb=
ug(adev) ? true : false;<br>
&nbsp;}<br>
&nbsp;<br>
-bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev)<br>
&#43;static bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *ad=
ev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_sriov_is_nor=
mal(adev) ? true : false;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c<br>
index 0cc011f9190d..4aec76049a60 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
@@ -3039,7 &#43;3039,7 @@ static void gfx_v7_0_mqd_init(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_active =3D =
1;<br>
&nbsp;}<br>
&nbsp;<br>
-int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd)<b=
r>
&#43;static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_=
mqd *mqd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_reg;<br>
@@ -5209,7 &#43;5209,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu_info-&gt;lds_size =3D 6=
4;<br>
&nbsp;}<br>
&nbsp;<br>
-const struct amdgpu_ip_block_version gfx_v7_0_ip_block =3D<br>
&#43;static const struct amdgpu_ip_block_version gfx_v7_0_ip_block =3D<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D AMD_IP_BLOCK_TYP=
E_GFX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .major =3D 7,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 1d4128227ffd..efb759b62d21 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -4589,7 &#43;4589,7 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *=
ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-int gfx_v8_0_mqd_commit(struct amdgpu_device *adev,<br>
&#43;static int gfx_v8_0_mqd_commit(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t vi_mqd *mqd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_reg;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index c3e59b765268..99ffc3e1fddc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -722,7 &#43;722,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSET=
S[] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_SRM_INDEX_CNTL_DATA_=
7 - mmRLC_SRM_INDEX_CNTL_DATA_0,<br>
&nbsp;};<br>
&nbsp;<br>
-void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)<br>
&#43;static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,=
 u32 v)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void *scratch_reg0;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void *scratch_reg1;=
<br>
-- <br>
2.27.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C2d950e88102e4969c83508d81389c7c3%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280829787212213&amp;amp;sdata=3D=
C9iEaENRFogB6gKjLTSLQx0UM32tsHnCPiOggnL%2Bd04%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C2d950e88102e4969c83508d81389c7c3%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637280829787212213&amp;amp;sdata=3DC9iEaENRFogB6gK=
jLTSLQx0UM32tsHnCPiOggnL%2Bd04%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44888992FE8BC63EE48AA5F6F79B0MN2PR12MB4488namp_--

--===============2044172914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2044172914==--
