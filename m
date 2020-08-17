Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5489C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 14:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0AF20674
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 14:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xt9xw40Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0AF20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0606F6E0F0;
	Mon, 17 Aug 2020 14:18:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5606E0F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 14:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5kRilqgX3hmCABRZnXLySoAcrRanvVLiXdrDSSJjUf8dGHjZ3PZH8iGxbd4DJW2jGD3EN2Tpy7Dx2T4sVs91mXIxq1Lq9Tyqqh/nfiSBYBK7fZpqcDIjQZW+/j/qTWDKrf7c6TWnkZK8DobXj9tu8pUOWz32YGWHQQ31KA1WW8wvMmV/p8dzGibJ5D7U5EYqyPNvv2iimmgk3cKf/ttfS4fFV/VTQyzVWVrJqVyP1xNQ9GHCRMhrk8j7yrE4kPt57JQNJdSNgNJJkmwXxBP8nqecaXGKjPyozmSsgxQ6w65KKxNm3xVC35Qux2LfIQlGhetvJpAg5ygGbCjoYHxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk0LY2dBq2tnHwEK9mO3J15LI3bB0JAiRJKD0oRwjHY=;
 b=GcyqykjnmY5zUfFu1vrsvD9/2/aW206LNQJ57fYX2AAqioc3x6zXZyXHJMkLnqubOnV3/YwJ4NdYAV+Dsm05JITA4XMJ34y/NG49NONBCmSLovKI7hBHZ/cbq4tz5/pEBBOYukp0hXjXB2uwUAND32n39sN3ATzr8uhbtMLnH1QiqDqq1DuB2a84DZYMNSsGr1f42vRQtxe102KRzvL3ojxm0MjasZknVclpit9JopJWcimDf7obm6sN6/UjQdcyncheoMGYEpu/juv6JRahEsPUz8XnvJsal9g2QTfqkl3hzDT1G5X/Ry1+PvUwwXjiuEHK3cT1bZLW7chuc4SVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk0LY2dBq2tnHwEK9mO3J15LI3bB0JAiRJKD0oRwjHY=;
 b=xt9xw40Qbuh+jvZCP5Og0uUpYGKVit6U4/4d2+EzJFgbIPaVaDJzD9e6ZX9c6mudGYKqYfRQPD4XVo8mFZYRrMYshTIFYYpmuJVj1pNOQJWM+4XSAuOXJJhOetPFlmErk6rxqVnr1vv47yO0fLLfLqf9ggzZC2D3zqIhuUUNTi8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2434.namprd12.prod.outlook.com (2603:10b6:207:4d::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Mon, 17 Aug
 2020 14:18:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 14:18:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] drm/amd/pm: disable/enable gfx ulv on UMD pstate
 enter/exit
Thread-Topic: [PATCH 1/5] drm/amd/pm: disable/enable gfx ulv on UMD pstate
 enter/exit
Thread-Index: AQHWdGr1PxTYUSPqiUeW9OohcRA2Bqk8WW0c
Date: Mon, 17 Aug 2020 14:18:18 +0000
Message-ID: <MN2PR12MB448862FA29FD0870E45A423BF75F0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200817074917.9607-1-evan.quan@amd.com>
In-Reply-To: <20200817074917.9607-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-17T14:18:18.376Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4629219-9abf-4259-1ab5-08d842b863cd
x-ms-traffictypediagnostic: BL0PR12MB2434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2434C980A246CFE0E024B53AF75F0@BL0PR12MB2434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oO3nIi3Yb4ebJKfNeVcLgLVBhdlc5O0xbA7Epn9pg4slfNIFUrKtRwdZQxFDuuBia+OLzHoRk7jV+6JvJTs9/9rBRWolfIJkU0DlFItAlkpI0uwWavGJ+I3WXqeqjTkdqhyfTA5JWG0sqiWo8fisowQR9KCADoOwMY7NaSVX+QmTwNODfV1c/i/A9T/428gHGyN5r3/EGmGAj7MggGv2fyawlizX3d1cm2LYAkJweX5MBpPrgHFL7+vCE6/ju2fokkXhI6+EWo8R64UP5ZOi237AU1/vnLMCKrxHaa4TGAnp9C0GiLBLmH6G+DWElffG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(5660300002)(7696005)(55016002)(86362001)(9686003)(83380400001)(66446008)(66556008)(66476007)(52536014)(76116006)(64756008)(53546011)(66946007)(6506007)(71200400001)(110136005)(2906002)(8936002)(186003)(26005)(478600001)(8676002)(33656002)(19627405001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kck1L0b6EztScjgaXDyzpEUPdl0GIT45JMdNhnUju7be3n8gLcshohkRfeOrUVWq7nkJDPUKEjTnbrMsQph8J+QkxKd7M2clmg5vUzox0JkWh3sljZo6eeDnXH/0231r1SadrzcUNKr+i/x5FwNLLqoDjIO/N6c9bz2hsonclqSabHAzduvC22kK3ZgcTGP/Uwh34wbiKJQ3utwF1yxws3YmDIUrTSPcabR8lo52dmayEdCIQ2h0DWRS1E3g1EuDusKx7OA+Ja8dFLreD4c9Rt04JJ+NHao2H1p26Y/Ke2Ld5PsGXh1KW/6CQaAeW7c7Xr+Xot5Ae7kiOIpFdyC5v1IIZ1o7BHmfo9WC+sLX1EEjbbqr2ibyg931SYKl4AVb5X/6pdDLTRmt3biB06ZwCSSx87XyMsI8XLk9ugy3MYOzN+EBe4lvZRg4Lx0x49kuTmlmyHMB/+0AV/k9UFekoLRmwTmcveX4SgA9mgze8IUvD4Y6mEntTj+tbJ8qwguSdHKAauLX3dNHzAqKlIZwKStoYxJm99p+M6LeQYH5LDN0witrlXxBHxxcC+b2pG2eIRIL1D80eWtvMkCSgEPIE9+qWidpex4y5CnOYF2w9UUj4GMAm0LrSvzQby17OCWPtBDVl50UShEcXgCHkNBEqg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4629219-9abf-4259-1ab5-08d842b863cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 14:18:18.7581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNVAJMjvt3cQTZZ+PBhOQdPdz8J9x4U8rQT9ArVBA738kooVE8iNhq05YMKOEfQNyfhbpS+cVG3ELyFVXxMTZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2434
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
Content-Type: multipart/mixed; boundary="===============1964802986=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1964802986==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448862FA29FD0870E45A423BF75F0MN2PR12MB4488namp_"

--_000_MN2PR12MB448862FA29FD0870E45A423BF75F0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

You can probably just squash patches 2-5 into one patch.  Either way, serie=
s is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, August 17, 2020 3:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 1/5] drm/amd/pm: disable/enable gfx ulv on UMD pstate enter=
/exit

Add gfx ulv disablement/enablement on UMD pstate entering/exiting.

Change-Id: Ieb38fdb5975b563f24c0b172fedd01acf99afb10
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index bbe4a343e9f1..7cc707ec21c3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -596,6 +596,7 @@ struct pptable_funcs {
         int (*set_pp_feature_mask)(struct smu_context *smu, uint64_t new_m=
ask);
         ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);
         int (*enable_mgpu_fan_boost)(struct smu_context *smu);
+       int (*gfx_ulv_control)(struct smu_context *smu, bool enablement);
 };

 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 7d17c4f1b489..221b5c923ce1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1440,6 +1440,7 @@ static int smu_enable_umd_pstate(void *handle,
                         amdgpu_device_ip_set_clockgating_state(smu->adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_CG_STAT=
E_UNGATE);
+                       smu_gfx_ulv_control(smu, false);
                 }
         } else {
                 /* exit umd pstate, restore level, enable gfx cg*/
@@ -1447,6 +1448,7 @@ static int smu_enable_umd_pstate(void *handle,
                         if (*level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXI=
T)
                                 *level =3D smu_dpm_ctx->saved_dpm_level;
                         smu_dpm_ctx->enable_umd_pstate =3D false;
+                       smu_gfx_ulv_control(smu, true);
                         amdgpu_device_ip_set_clockgating_state(smu->adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_CG_STAT=
E_GATE);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_internal.h
index 264073d4e263..2fe29c6a00ce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -92,6 +92,7 @@
 #define smu_get_asic_power_limits(smu)                                  sm=
u_ppt_funcs(get_power_limit, 0, smu)
 #define smu_get_pp_feature_mask(smu, buf)                               sm=
u_ppt_funcs(get_pp_feature_mask, 0, smu, buf)
 #define smu_set_pp_feature_mask(smu, new_mask)                          sm=
u_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
+#define smu_gfx_ulv_control(smu, enablement)                           smu=
_ppt_funcs(gfx_ulv_control, 0, smu, enablement)

 #endif
 #endif
--
2.28.0


--_000_MN2PR12MB448862FA29FD0870E45A423BF75F0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You can probably just squash patches 2-5 into one patch.&nbsp; Either way, =
series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, August 17, 2020 3:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/5] drm/amd/pm: disable/enable gfx ulv on UMD pstat=
e enter/exit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add gfx ulv disablement/enablement on UMD pstate e=
ntering/exiting.<br>
<br>
Change-Id: Ieb38fdb5975b563f24c0b172fedd01acf99afb10<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp; | 1 +=
<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp; | 2 ++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 1 +<br>
&nbsp;3 files changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index bbe4a343e9f1..7cc707ec21c3 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -596,6 +596,7 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_pp_feature_mask)=
(struct smu_context *smu, uint64_t new_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t (*get_gpu_metrics)=
(struct smu_context *smu, void **table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*enable_mgpu_fan_boos=
t)(struct smu_context *smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*gfx_ulv_control)(struct smu_con=
text *smu, bool enablement);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;typedef enum {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 7d17c4f1b489..221b5c923ce1 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1440,6 +1440,7 @@ static int smu_enable_umd_pstate(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_set_clockgating_state(smu-&gt;adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_IP_BLOCK_TYPE_GFX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_CG_STATE_UNGATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_gfx_ulv_cont=
rol(smu, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* exit umd pstate, restore level, enable gfx cg*/<br=
>
@@ -1447,6 +1448,7 @@ static int smu_enable_umd_pstate(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*=
level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *level =3D smu_dpm_ctx-&gt;saved=
_dpm_level;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_d=
pm_ctx-&gt;enable_umd_pstate =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_gfx_ulv_cont=
rol(smu, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_set_clockgating_state(smu-&gt;adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_IP_BLOCK_TYPE_GFX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_CG_STATE_GATE);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_internal.h<br>
index 264073d4e263..2fe29c6a00ce 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
@@ -92,6 +92,7 @@<br>
&nbsp;#define smu_get_asic_power_limits(smu)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; smu_ppt_funcs(get_power_limit, 0, smu)<br>
&nbsp;#define smu_get_pp_feature_mask(smu, buf)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; smu_ppt_funcs(get_pp_feature_mask, 0, smu, buf)<br>
&nbsp;#define smu_set_pp_feature_mask(smu, new_mask)&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(set_pp_f=
eature_mask, 0, smu, new_mask)<br>
+#define smu_gfx_ulv_control(smu, enablement)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(gfx_ulv_c=
ontrol, 0, smu, enablement)<br>
&nbsp;<br>
&nbsp;#endif<br>
&nbsp;#endif<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448862FA29FD0870E45A423BF75F0MN2PR12MB4488namp_--

--===============1964802986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1964802986==--
