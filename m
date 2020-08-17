Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A03FC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 14:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED73E20786
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 14:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DxsCrMET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED73E20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42CB6E0F5;
	Mon, 17 Aug 2020 14:18:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57986E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 14:18:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hhq0nDITZ9UYySewDZAP8hsmt1CPEjrPBEjEHiwtibmkrSKKpS5kIBAuJdcePe3ja9JqS9T+hbneJ0ndBz/JC4DM3IlIf8NG3GbtUmddu7dwBUjIK/yvb2nTw87wCKf/wYAcXuoNwHGPjn2k86hoON7r8Vf3DzagOE7tcVVuzZ69vytmtz4gGFxL4ATtRcZ4ozRUzhLpK6zhRnYDzQUsaEGIVczE6bu05riVgDSA7hOTUZGzNltT36j7HFLmwcyBwLFhkY+K94fSKq6cMtvt7Kfol4Kh9VjxJOju9fGwhfhAxH6szYzMy7jEZ2HhUcplJ/bGlwmtuZgDP6gXFfb/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC1cDlv7rNwzAk/zPiF/xWEYTD3e/vbhOdyiC3jjeoY=;
 b=k4azbbKPAYSNG5z4GmWHRGYQkhlhZ4FJBObqK9ilfshuYtlB2rBKaY1XPcEJvPJJIlOuOIiufuPSyOeHsqBvcAtfHWRgiSUVH15Z80uh4PvqbiQTNLZWLmN8pNT92t9R7PMbNQvqmElPc4JfYGeW2Acz6+rGLXFuk9HfawJ1zb6OSJ2ebganbkJOhPM7+b3PRDmSN4LAL/DAT3uhS55IItsY7KrC8vZfThbf2MXtjIufgOIOyRZbJcqPlhog3eNtztpBpDOadBMTXtxaQErZdOaf+8FNMPessc/uWISj6Qbzxrz3mzm2vPiouZqjZ1pXsKI9yO97D/UmfLRw+lKHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC1cDlv7rNwzAk/zPiF/xWEYTD3e/vbhOdyiC3jjeoY=;
 b=DxsCrMET9yX0wJkg5+CikJTDgdcJu/6EaaLfx573ptvmj4KVsL/F+KG7vah12CIQZ0DRxQ8dP9iSGPk4gKUuwahWnAoZzhZuyM0iX2VEmw5j4Ag4Pw3O3KKKwp5W0tezGkEpSj9CJr2XV3IRg2yK3MqGKX8n6nnsz9+P4SAjvrw=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 17 Aug
 2020 14:18:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 14:18:31 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] drm/amd/pm: disable/enable deep sleep features on UMD
 pstate enter/exit
Thread-Topic: [PATCH 1/5] drm/amd/pm: disable/enable deep sleep features on
 UMD pstate enter/exit
Thread-Index: AQHWdHCbKTRk2aV5UkWFa/gOaMAPvak8WaXQ
Date: Mon, 17 Aug 2020 14:18:31 +0000
Message-ID: <MN2PR12MB44883413B33942A7F2AA052CF75F0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200817082942.25733-1-evan.quan@amd.com>
In-Reply-To: <20200817082942.25733-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-17T14:18:31.189Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51805560-53cf-4752-3f40-08d842b86b7d
x-ms-traffictypediagnostic: MN2PR12MB4471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4471B2609222D9F534E183C9F75F0@MN2PR12MB4471.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZJBgyZN2GLkMZI5yZBSyBvqXgKFY34Wc+nqZqGZapuBk30JzvK0rK7OC4r3U9sSPN91FdIs0r2vEswTu6aeNdN085S3xfaFbk6/3xprA1RH9j5CaG1pyDP738E5JHhsI3ksexfCIvN5Pa8EYAhvbC+bpdMP2hTbCaV9iUFDAzkihGLO9kK3JbVxbs9O5uKBfiUvxMMxaUQoer+Nz5eieQw7GJjqDniuJa9+udEkDoKGXVXh69VT/x8z9lsnTRpABad/IuS/M2JxWyWKphlDdvtx8iccj+Wcx48lUN2w+L0SJ7RqXW8KAfJVenjLSClM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(8676002)(66476007)(33656002)(76116006)(186003)(9686003)(26005)(66446008)(64756008)(66556008)(5660300002)(66946007)(52536014)(7696005)(2906002)(478600001)(8936002)(71200400001)(316002)(86362001)(53546011)(19627405001)(83380400001)(55016002)(110136005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: sS+aG09roIeh2OEWgcWO1naM6jdihKvC28fr9Yw1sNzTfcT9RiyMGz5PpqhhO2iAvroV2JDlF2n1muz8KBoJQJSXD1AXcD12VNOx2TOz8ap0YhUN9B7P/B6RJhsxVmB4lCfDZIp8/ouUaOO3Hw2L5Qe5hr9oT3zhlt90vE59hQ9WyHJqMNncifH4GmAubYqCzxMyBHoacp0QzhE2tArQDc972vZJ99ydvOg6/EmM21mghT6ZSYmRstGlHSLloe0KJe5EQZLRQz+MaY+XHniVPcVzDmhmqQnno4k63NZmes463A8OhSPgnzFtAY+JiSoOcoY0RCkqOfw9+l2ATOETMZBTeNRoyb392W0sf9X/sJ7Gy9TGLiknHmmjq9zuorWNcLSOmLph5Gk4dWfSnO52uSzdVigumRj55KrUP3imhzwuU99BXUzZRuPdXWayYmBn1XqfaOemoSeqnJQB+DzQxa4iaubPJVdMlOgRbinbWLUydqi+wLJ8i2OX7PbfY+EpqgFmZd2YJY2r3fIgkvlIQQqwTxqyVoEfVUA4DQQqaPj4TY+NK0TR8veHrgF+UYvqwH6bPLac2HDf+Qj11dedYE4g65l67MUxaMppoMoZpJSLUDF5fLPDqSG4z+ABTngXDTYtPvv7UvKjzBwox1BBvA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51805560-53cf-4752-3f40-08d842b86b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 14:18:31.6446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DZNcx/TdZ2ILwvHLFkDd9r883lgH0LnGjor22V3YizehQFjdnJOjCHKh05w/zLHYRjLeMbPOTeqlpvTCSifFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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
Content-Type: multipart/mixed; boundary="===============1697647577=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1697647577==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44883413B33942A7F2AA052CF75F0MN2PR12MB4488namp_"

--_000_MN2PR12MB44883413B33942A7F2AA052CF75F0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

You can probably just squash patches 2-5 into one patch.  Either way, serie=
s is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, August 17, 2020 4:29 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 1/5] drm/amd/pm: disable/enable deep sleep features on UMD =
pstate enter/exit

Add deep sleep disablement/enablement on UMD pstate entering/exiting.

Change-Id: I4fbc02bb4a390ab82293a5ff9c91f2a8beb0a3c9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 7cc707ec21c3..4c5c041af4ee 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -597,6 +597,7 @@ struct pptable_funcs {
         ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);
         int (*enable_mgpu_fan_boost)(struct smu_context *smu);
         int (*gfx_ulv_control)(struct smu_context *smu, bool enablement);
+       int (*deep_sleep_control)(struct smu_context *smu, bool enablement)=
;
 };

 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 221b5c923ce1..8eb5b92903cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1441,6 +1441,7 @@ static int smu_enable_umd_pstate(void *handle,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_CG_STAT=
E_UNGATE);
                         smu_gfx_ulv_control(smu, false);
+                       smu_deep_sleep_control(smu, false);
                 }
         } else {
                 /* exit umd pstate, restore level, enable gfx cg*/
@@ -1448,6 +1449,7 @@ static int smu_enable_umd_pstate(void *handle,
                         if (*level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXI=
T)
                                 *level =3D smu_dpm_ctx->saved_dpm_level;
                         smu_dpm_ctx->enable_umd_pstate =3D false;
+                       smu_deep_sleep_control(smu, true);
                         smu_gfx_ulv_control(smu, true);
                         amdgpu_device_ip_set_clockgating_state(smu->adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_internal.h
index 2fe29c6a00ce..c88f8fab1bae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -93,6 +93,7 @@
 #define smu_get_pp_feature_mask(smu, buf)                               sm=
u_ppt_funcs(get_pp_feature_mask, 0, smu, buf)
 #define smu_set_pp_feature_mask(smu, new_mask)                          sm=
u_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
 #define smu_gfx_ulv_control(smu, enablement)                            sm=
u_ppt_funcs(gfx_ulv_control, 0, smu, enablement)
+#define smu_deep_sleep_control(smu, enablement)                           =
     smu_ppt_funcs(deep_sleep_control, 0, smu, enablement)

 #endif
 #endif
--
2.28.0


--_000_MN2PR12MB44883413B33942A7F2AA052CF75F0MN2PR12MB4488namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt">
You can probably just squash patches 2-5 into one patch.&nbsp; Either way, =
series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt">
<br>
</div>
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, August 17, 2020 4:29 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/5] drm/amd/pm: disable/enable deep sleep features =
on UMD pstate enter/exit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add deep sleep disablement/enablement on UMD pstat=
e entering/exiting.<br>
<br>
Change-Id: I4fbc02bb4a390ab82293a5ff9c91f2a8beb0a3c9<br>
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
index 7cc707ec21c3..4c5c041af4ee 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -597,6 +597,7 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t (*get_gpu_metrics)=
(struct smu_context *smu, void **table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*enable_mgpu_fan_boos=
t)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*gfx_ulv_control)(str=
uct smu_context *smu, bool enablement);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*deep_sleep_control)(struct smu_=
context *smu, bool enablement);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;typedef enum {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 221b5c923ce1..8eb5b92903cd 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1441,6 +1441,7 @@ static int smu_enable_umd_pstate(void *handle,<br>
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_g=
fx_ulv_control(smu, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_deep_sleep_c=
ontrol(smu, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* exit umd pstate, restore level, enable gfx cg*/<br=
>
@@ -1448,6 +1449,7 @@ static int smu_enable_umd_pstate(void *handle,<br>
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
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_deep_sleep_c=
ontrol(smu, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_g=
fx_ulv_control(smu, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_set_clockgating_state(smu-&gt;adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_IP_BLOCK_TYPE_GFX,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_internal.h<br>
index 2fe29c6a00ce..c88f8fab1bae 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
@@ -93,6 +93,7 @@<br>
&nbsp;#define smu_get_pp_feature_mask(smu, buf)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; smu_ppt_funcs(get_pp_feature_mask, 0, smu, buf)<br>
&nbsp;#define smu_set_pp_feature_mask(smu, new_mask)&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(set_pp_f=
eature_mask, 0, smu, new_mask)<br>
&nbsp;#define smu_gfx_ulv_control(smu, enablement)&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_func=
s(gfx_ulv_control, 0, smu, enablement)<br>
+#define smu_deep_sleep_control(smu, enablement)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; smu_ppt_funcs(deep_sleep_control, 0, smu, enablement)<br>
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

--_000_MN2PR12MB44883413B33942A7F2AA052CF75F0MN2PR12MB4488namp_--

--===============1697647577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1697647577==--
