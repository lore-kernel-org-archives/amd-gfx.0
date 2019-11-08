Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9FFFA372C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 14:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CBA214DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CBA214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 695FE6E0B6;
	Fri,  8 Nov 2019 14:44:41 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690075.outbound.protection.outlook.com [40.107.69.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CABC6E0B6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 14:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHNlFIggByN/xsKDdi4QplvQ96BPuM/oo+yv0fLz1IgepH6NE4NBKm1iUQl7rmNgcz6p1V2mk8+LtMD5tDOwgH2bYIkbdVjMqegBGKVwLdqfaOrGKTEDvw0f76l7ig283FjTIt1vVJaGrTddVw1KFi+tYwV73kLq+3D7Sc6N9ZpjleCA6GmpwP/J+DP/aTIFPRKQPWWNqOJByUM5wqnhYYy19cGtn/xGF4gqjGd7piMxJO18gnoFQeAz6jcz4nnXm8cIJ2SXOqHOnFXB+lTEt3WVqjtK4kR0cJcA8umssjiqooM8xNQN6+cCIXrAlo5YlxyGYSyv3zLTI7tRI6VtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhXxM4XZz609RBUAiawap7DyYWcNXNHlu3Q8biZASIg=;
 b=bp9cFa5hezND/ha3g2SkiOGbAWqTP47ROTMDTuAeELaW5rhc+fHjLNfiB2+fjOV7HDoBXFnqq+lGIr+0esgy+vV7BXsk+cjgwe3u5p0ZM7Xzrmm5BBBirmc92/TSsxS+YzSb2EQBiX+/cHDAKn6YIdIoPZsSefPsyIvzv5PxmkAASHzZIAo9E/FTx/EIEbJu3i106L+6te5TiZ8UQxRpCvqN7lWLpal52YafrgSsENH3HOdDLgc18gtR5IETj057xJPFQ67BChmJr6/ALGgTDh7reo0NZeLjAX/5bnfvS/5XgztQyjERl/tl35tYnquRs/2eWKcfz+NpdtHH77KJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB1947.namprd12.prod.outlook.com (10.175.90.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 8 Nov 2019 14:44:38 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2430.020; Fri, 8 Nov 2019
 14:44:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for
 compute
Thread-Topic: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for
 compute
Thread-Index: AQHVlfdjkluKHSbR0U26NvMCG25q6KeBWhL+
Date: Fri, 8 Nov 2019 14:44:38 +0000
Message-ID:
 <DM5PR12MB18204B23450D8B0E427E4C8AF77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1573191771-8071-1-git-send-email-kenneth.feng@amd.com>
In-Reply-To: <1573191771-8071-1-git-send-email-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c191ccab-7389-4499-bf8f-08d7645a2e90
x-ms-traffictypediagnostic: DM5PR12MB1947:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB19472C1A8A8C8778D8046FD3F77B0@DM5PR12MB1947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(6436002)(19627405001)(486006)(7696005)(66946007)(2501003)(476003)(105004)(81166006)(86362001)(53546011)(186003)(66476007)(76176011)(14444005)(66556008)(26005)(102836004)(71200400001)(64756008)(6506007)(66446008)(11346002)(76116006)(110136005)(446003)(316002)(71190400001)(2906002)(256004)(6246003)(229853002)(8676002)(55016002)(478600001)(6306002)(8936002)(81156014)(6116002)(54896002)(14454004)(7736002)(3846002)(606006)(66066001)(236005)(52536014)(5660300002)(9686003)(74316002)(966005)(99286004)(33656002)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1947;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgPbZlUW/7DXHVL4KNAUJ+tXgnyd81CesXpferxFrPRPKHDgPycm2RcCb/T5jnBFTUEp+MyQJjSZWHM28eWcitPJbzNDkfuvZrnV3UznoaYyB9fDnLN0Fav91ROHrM1wdHSXV04l2Ir8w2U7xTrjUoYIV55tuMFRew5BjdcCQFq6lx8Gi6Q7WwNJ6F4H7nMoxjLfoL0t/nAkKif9+wkh6HCfbNpoe//G2EewaeeLHYpUec+C4mgYOVM3EqASGYhZrI/yYpObdkibWyyBOVE4cn/70xByjfRj5ORDvNBgPFF5jb4pgBb5pg8BMsTCDdFDrgi9mxQvLLx53Qp8e2Ubj3HlW4S/P0E9PreMumDHCXrNMD+s8NR/wKLpmam5qgogF+6/Qv23Wz+YItO7L/41X/oByg9DUtF0p36TYWg3qqNgzk6Fd6V0loeoLwD+fnAPzk+1lMmnHpoGG5gUrjjUmS1l9VNPSgzf+ph1jSrbMFc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c191ccab-7389-4499-bf8f-08d7645a2e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 14:44:38.6077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Z6M+c6W6dEPxpvruv3tVZKhgvZ40UOpgnmCBPF9ArO7unU4WJucvNL0m67E+jbkErmeg/ldNfgxpgMSIQjtPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1947
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhXxM4XZz609RBUAiawap7DyYWcNXNHlu3Q8biZASIg=;
 b=f+gFxt5jRk3TNeSD8DEtQCg5BvWEjorv61XB9KMJPk8LDWy9MobWnZ7SaIS9Sv+ICpPZgQ0EX8p3bshLWiFtoYleQPLgXafGYj1dHoRnLW05atmk06MEOBjJTMhYNCGrEMYCTk0XBRKrb+6Uvlc3wpo6RMrtKczZ3c8AX2bPeik=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============0649729491=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108144438.NnxN6Up4JhPgBu_iaC0CyMRx6mYvn5YKDo01qz-e-zc@z>

--===============0649729491==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18204B23450D8B0E427E4C8AF77B0DM5PR12MB1820namp_"

--_000_DM5PR12MB18204B23450D8B0E427E4C8AF77B0DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Do we need something similar for vega20?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Friday, November 8, 2019 12:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for c=
ompute

This is to improve the performance in the compute mode
for vega10. For example, the original performance for a rocm
bandwidth test: 2G internal GPU copy, is about 99GB/s.
With the idle power features disabled dynamically, the porformance
is promoted to about 215GB/s.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |  7 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 55 ++++++++++++++++++=
++++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  2 +
 3 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index 0314476..bd35f65 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -969,6 +969,13 @@ static int pp_dpm_switch_power_profile(void *handle,
                 workload =3D hwmgr->workload_setting[index];
         }

+       if (type =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
+               hwmgr->hwmgr_func->disable_power_features_for_compute_perfo=
rmance)
+                       if (hwmgr->hwmgr_func->disable_power_features_for_c=
ompute_performance(hwmgr, en)) {
+                               mutex_unlock(&hwmgr->smu_lock);
+                               return -EINVAL;
+                       }
+
         if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
                 hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload=
, 0);
         mutex_unlock(&hwmgr->smu_lock);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 4ea63a2..d3229c2 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -5263,6 +5263,59 @@ static int vega10_get_performance_level(struct pp_hw=
mgr *hwmgr, const struct pp_
         return 0;
 }

+static int vega10_disable_power_features_for_compute_performance(struct pp=
_hwmgr *hwmgr, bool disable)
+{
+       struct vega10_hwmgr *data =3D hwmgr->backend;
+       uint32_t feature_mask =3D 0;
+
+       if (disable) {
+               feature_mask |=3D data->smu_features[GNLD_ULV].enabled ?
+                       data->smu_features[GNLD_ULV].smu_feature_bitmap : 0=
;
+               feature_mask |=3D data->smu_features[GNLD_DS_GFXCLK].enable=
d ?
+                       data->smu_features[GNLD_DS_GFXCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D data->smu_features[GNLD_DS_SOCCLK].enable=
d ?
+                       data->smu_features[GNLD_DS_SOCCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D data->smu_features[GNLD_DS_LCLK].enabled =
?
+                       data->smu_features[GNLD_DS_LCLK].smu_feature_bitmap=
 : 0;
+               feature_mask |=3D data->smu_features[GNLD_DS_DCEFCLK].enabl=
ed ?
+                       data->smu_features[GNLD_DS_DCEFCLK].smu_feature_bit=
map : 0;
+       } else {
+               feature_mask |=3D (!data->smu_features[GNLD_ULV].enabled) ?
+                       data->smu_features[GNLD_ULV].smu_feature_bitmap : 0=
;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_GFXCLK].enab=
led) ?
+                       data->smu_features[GNLD_DS_GFXCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_SOCCLK].enab=
led) ?
+                       data->smu_features[GNLD_DS_SOCCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_LCLK].enable=
d) ?
+                       data->smu_features[GNLD_DS_LCLK].smu_feature_bitmap=
 : 0;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_DCEFCLK].ena=
bled) ?
+                       data->smu_features[GNLD_DS_DCEFCLK].smu_feature_bit=
map : 0;
+       }
+
+       if (feature_mask)
+               PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,
+                               !disable, feature_mask),
+                               "enable/disable power features for compute =
performance Failed!",
+                               return -EINVAL);
+
+       if (disable) {
+               data->smu_features[GNLD_ULV].enabled =3D false;
+               data->smu_features[GNLD_DS_GFXCLK].enabled =3D false;
+               data->smu_features[GNLD_DS_SOCCLK].enabled =3D false;
+               data->smu_features[GNLD_DS_LCLK].enabled =3D false;
+               data->smu_features[GNLD_DS_DCEFCLK].enabled =3D false;
+       } else {
+               data->smu_features[GNLD_ULV].enabled =3D true;
+               data->smu_features[GNLD_DS_GFXCLK].enabled =3D true;
+               data->smu_features[GNLD_DS_SOCCLK].enabled =3D true;
+               data->smu_features[GNLD_DS_LCLK].enabled =3D true;
+               data->smu_features[GNLD_DS_DCEFCLK].enabled =3D true;
+       }
+
+       return 0;
+
+}
+
 static const struct pp_hwmgr_func vega10_hwmgr_funcs =3D {
         .backend_init =3D vega10_hwmgr_backend_init,
         .backend_fini =3D vega10_hwmgr_backend_fini,
@@ -5330,6 +5383,8 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs =
=3D {
         .get_ppfeature_status =3D vega10_get_ppfeature_status,
         .set_ppfeature_status =3D vega10_set_ppfeature_status,
         .set_mp1_state =3D vega10_set_mp1_state,
+       .disable_power_features_for_compute_performance =3D
+                       vega10_disable_power_features_for_compute_performan=
ce,
 };

 int vega10_hwmgr_init(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 40403bc..af97767 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -357,6 +357,8 @@ struct pp_hwmgr_func {
         int (*smu_i2c_bus_access)(struct pp_hwmgr *hwmgr, bool aquire);
         int (*set_df_cstate)(struct pp_hwmgr *hwmgr, enum pp_df_cstate sta=
te);
         int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
+       int (*disable_power_features_for_compute_performance)(struct pp_hwm=
gr *hwmgr,
+                                       bool disable);
 };

 struct pp_table_func {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB18204B23450D8B0E427E4C8AF77B0DM5PR12MB1820namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Do we need something similar for vega20?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Friday, November 8, 2019 12:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/powerplay: dynamically disable ds and ul=
v for compute</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This is to improve the performance in the compute =
mode<br>
for vega10. For example, the original performance for a rocm<br>
bandwidth test: 2G internal GPU copy, is about 99GB/s.<br>
With the idle power features disabled dynamically, the porformance<br>
is promoted to about 215GB/s.<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 7 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 55 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;<br>
&nbsp;3 files changed, 64 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index 0314476..bd35f65 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -969,6 &#43;969,13 @@ static int pp_dpm_switch_power_profile(void *handl=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; workload =3D hwmgr-&gt;workload_setting[index];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D PP_SMC_POWER_PROF=
ILE_COMPUTE &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;disable_power_features_for_compute_=
performance)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&g=
t;hwmgr_func-&gt;disable_power_features_for_compute_performance(hwmgr, en))=
 {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_lock);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=
=3D AMD_DPM_FORCED_LEVEL_MANUAL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_mode(hwmgr=
, &amp;workload, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&g=
t;smu_lock);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 4ea63a2..d3229c2 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -5263,6 &#43;5263,59 @@ static int vega10_get_performance_level(struct p=
p_hwmgr *hwmgr, const struct pp_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int vega10_disable_power_features_for_compute_performance(struc=
t pp_hwmgr *hwmgr, bool disable)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =3D hwm=
gr-&gt;backend;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (disable) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_ULV].enabled ?<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_ULV].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_GFXCLK].enab=
led ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_GFXCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_SOCCLK].enab=
led ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_SOCCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_LCLK].enable=
d ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_LCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_DCEFCLK].ena=
bled ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_DCEFCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_ULV].enabled)=
 ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_ULV].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_GFXCLK].en=
abled) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_GFXCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_SOCCLK].en=
abled) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_SOCCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_LCLK].enab=
led) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_LCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_DCEFCLK].e=
nabled) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_DCEFCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature_mask)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !disable, feature_mask),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enable/disable power features for=
 compute performance Failed!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (disable) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_ULV].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_GFXCLK].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_SOCCLK].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_LCLK].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_DCEFCLK].enabled =3D false;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_ULV].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_GFXCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_SOCCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_LCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_DCEFCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct pp_hwmgr_func vega10_hwmgr_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_init =3D vega10_h=
wmgr_backend_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_fini =3D vega10_h=
wmgr_backend_fini,<br>
@@ -5330,6 &#43;5383,8 @@ static const struct pp_hwmgr_func vega10_hwmgr_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ppfeature_status =3D =
vega10_get_ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ppfeature_status =3D =
vega10_set_ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D vega10_=
set_mp1_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_power_features_for_compu=
te_performance =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_disab=
le_power_features_for_compute_performance,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int vega10_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 40403bc..af97767 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -357,6 &#43;357,8 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smu_i2c_bus_access)(=
struct pp_hwmgr *hwmgr, bool aquire);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_df_cstate)(struc=
t pp_hwmgr *hwmgr, enum pp_df_cstate state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_xgmi_pstate)(str=
uct pp_hwmgr *hwmgr, uint32_t pstate);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*disable_power_features_for_=
compute_performance)(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; bool disable);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct pp_table_func {<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB18204B23450D8B0E427E4C8AF77B0DM5PR12MB1820namp_--

--===============0649729491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0649729491==--
