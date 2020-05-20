Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 13:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D97207D3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 13:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rIrZ9jAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D97207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC436E82A;
	Wed, 20 May 2020 13:04:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB2F6E82A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 13:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0OT3ooeAQhOqchuc0k6UilQNMHWa/TP81VTcBQR6RnBK2vkZVlmpCGp9FFdLdJniPnnXsPlRyu3aHsj0Z4/Y+NI6l5xWbS5SI4hDar0exI7nsmS1MDNPRKtKULnzGfj+MgQLmrElJUbHTEP4IR0CSP9cGfMU7Lo4eD2qsVrabzpcy9OuB5jl9pmBjMO/UQaO1DOhjbuJflvopCrrIm58/tpG9KH4f464EHugs8J3xZWLsoApY58kAqIvX/4XHYuC0T9cMr8E+fr+TPs3rRbKvqS9wh5oBtCjcEDBPye58LhYcyzfjf0tlIfFVGXolMDmA81+2OdFmYFr7aP2ZKuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF69ccXZJpRiqvtQvW89diBIc8Rj69qIDDhex9lp3zM=;
 b=Rv0DKDZWyKiqzmUyYeicZpxih6aintZ6LsNzUzgLVaIPbT7jg/Tt8f9OWSbwI8fNsG2whFhtqICeScxCe3L3Qc6JqLVQSvgUCOHJDr7MkhggL1r/3ZIztcu1tovTMlAGpbHAjRPrqOa/CYcwYPleoTAG/3nhf0fwJ3Tk2PK2kDtN8oGrGBoNkvyjJhQwFNuljSllTTJjKjdWV9VrY8VvE4wbtDgPN0oz/YSCwQd8mWAR1f86dpgUy3BjmjZwrfxcwX20HY4v5azTfufpfr3ejZQWtZICNBbMbr9mlA+Xr7MN9IPVUErz4zxm8xlZjcOGurUTQpK0WhHTChn/MYWtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF69ccXZJpRiqvtQvW89diBIc8Rj69qIDDhex9lp3zM=;
 b=rIrZ9jAiTmXMI+pEFPTp8e0vRbun/rfihwsx30Kl1JBdzT3fiZmVBUc1aSU4qmQsYgOfdhvpL17mQJu0mq6dLYPDT0rhER2asjlesAOcPEHYmy7ST1frnUAjjpetUchQ7M6mjiUFIC0NeRG0RoRETyZuZy6wMQ4H8sAn6Hm+jNc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 13:04:29 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 13:04:29 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: remove the support of xgmi pstate
 on vega20 from swsmu
Thread-Topic: [PATCH 1/2] drm/amd/powerplay: remove the support of xgmi pstate
 on vega20 from swsmu
Thread-Index: AQHWLlnm1SvpYuGnLkK8YiFvc7q+Lqiw8TzI
Date: Wed, 20 May 2020 13:04:29 +0000
Message-ID: <MN2PR12MB44889A7DC25DF57F658E1EFFF7B60@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200520035048.29899-1-kevin1.wang@amd.com>
In-Reply-To: <20200520035048.29899-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-20T13:04:28.584Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.51.180.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8458820a-5638-4d72-a008-08d7fcbe54b9
x-ms-traffictypediagnostic: MN2PR12MB4096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB409634DD80DE48549B3EA573F7B60@MN2PR12MB4096.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x2K++lkMUYHzM7rvyH5aCR9UB23Y1t0lgqSmQR2poVmzeqH8ATFVTIZBRrIHXwVQtq/+iC/gE4z1V/WRKQF9pwNbmz9ZowBkcuT/aRtgYlR5aOBBOT1iymN2SsBt6SsExzoF1ndG/umuIzuFXNWiSmAdksxF36LIXTYD6nrPACMAziOpw7Wm2MA/QbwZe1GhpomQivDoV5uY9kFSEyNKmeMC52xcIbdNo/ZMl0d0Onk1uXS4JgovE2JaGlPl3pqHxn/f0mzS/dfSai+a3QZxMy6Qg3o7xK85X4Mpxv2Pq8yH5pwhUYu7RvbBt0drcFea672tpv6dAweUZmEUyeLpgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(19627405001)(66446008)(4326008)(8936002)(86362001)(8676002)(5660300002)(64756008)(9686003)(55016002)(71200400001)(53546011)(33656002)(66476007)(478600001)(52536014)(76116006)(7696005)(2906002)(316002)(66946007)(110136005)(26005)(186003)(6506007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gh/a5cIBduF7pVnPyPZCqi1EW7nhZbYB94riZx6Qj5J6SG70hBF27TdPczPSOV8Jki24OMzIepUB8ukRGOvxrmtIFDjWoMZXLbF7uWDj+FXDSyg63ds5W/2362R6t/gICmmg0Z8TQTiJdFHqMYsmAYeAwAEv6I23f5q8Q0u0sqQOKNdIKF8LYo2ynBfU6Zz46mLiXLF+ClS+3yJwG0uPZK6FI8EgKka46Uj+BdZtal4mg7t/MdBIkjD/yuq103rOgtXkZRpc8ltEZQKumNuvHbIVBBiCcExFH+WPt/4W+dMI8eTrYJVclFpulB/Z1z2aBA+D5BofqPVFrmx+Pgzra0tdShMeAYtwS/MqO8bQmfCMiC4pxbfseFM9e61ATkFAW1OCQ1Y8gdojOmTvtDe0uq3uEeD/EsRI1fjtWyi2MBk2wbIvsCgAqiJ+O49G7+qLihEqIA+syma0JvP6lKXA5ijQkamxOOUR7LukbThQ8OvihcQHwwtk2PgdzBL+NLyv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8458820a-5638-4d72-a008-08d7fcbe54b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 13:04:29.0964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMVIHnPdKfoQadAMRJFnfRvZowIfmyPzgmZ0xJ5WuOumTrkLONqp14bFEWljXXRwSoc1FaezZfIzWWe4whjQ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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
Content-Type: multipart/mixed; boundary="===============1524901142=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1524901142==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44889A7DC25DF57F658E1EFFF7B60MN2PR12MB4488namp_"

--_000_MN2PR12MB44889A7DC25DF57F658E1EFFF7B60MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Tuesday, May 19, 2020 11:50 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 1/2] drm/amd/powerplay: remove the support of xgmi pstate o=
n vega20 from swsmu

the vega20 asic uses legacy powerplay driver by default.

1. cleanup is_support_sw_smu_xgmi() function.
(ony use for vega20 xgmi pstate check)
2. by default, the vega20 set xgmi pstate by legacy powerplay routine.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c        |  4 ++--
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 11 -----------
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  1 -
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_dpm.c
index f36b58a7f485..65472b3dd815 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1162,7 +1162,7 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *=
adev,
 {
         int ret =3D 0;

-       if (is_support_sw_smu_xgmi(adev))
+       if (is_support_sw_smu(adev))
                 ret =3D smu_set_xgmi_pstate(&adev->smu, pstate);
         else if (adev->powerplay.pp_funcs &&
                  adev->powerplay.pp_funcs->set_xgmi_pstate)
@@ -1197,4 +1197,4 @@ int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_de=
vice *adev, bool en)
                 return smu_allow_xgmi_power_down(smu, en);

         return 0;
-}
\ No newline at end of file
+}
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 1abc4be6b72e..9ad6f0f3aada 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -575,17 +575,6 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
         return false;
 }

-bool is_support_sw_smu_xgmi(struct amdgpu_device *adev)
-{
-       if (!is_support_sw_smu(adev))
-               return false;
-
-       if (adev->asic_type =3D=3D CHIP_VEGA20)
-               return true;
-
-       return false;
-}
-
 int smu_sys_get_pp_table(struct smu_context *smu, void **table)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index 4d1c2a44a8b6..bac7e13dc801 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -675,7 +675,6 @@ int smu_update_table(struct smu_context *smu, enum smu_=
table_id table_index, int
                      void *table_data, bool drv2smu);

 bool is_support_sw_smu(struct amdgpu_device *adev);
-bool is_support_sw_smu_xgmi(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
 int smu_common_read_sensor(struct smu_context *smu, enum amd_pp_sensors se=
nsor,
                            void *data, uint32_t *size);
--
2.17.1


--_000_MN2PR12MB44889A7DC25DF57F658E1EFFF7B60MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 19, 2020 11:50 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/powerplay: remove the support of xgmi p=
state on vega20 from swsmu</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">the vega20 asic uses legacy powerplay driver by de=
fault.<br>
<br>
1. cleanup is_support_sw_smu_xgmi() function.<br>
(ony use for vega20 xgmi pstate check)<br>
2. by default, the vega20 set xgmi pstate by legacy powerplay routine.<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | =
11 -----------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |&nbsp; 1 -<br>
&nbsp;3 files changed, 2 insertions(&#43;), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_dpm.c<br>
index f36b58a7f485..65472b3dd815 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c<br>
@@ -1162,7 &#43;1162,7 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_devi=
ce *adev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu_xgmi(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_xgmi_pstate(&amp;adev-&gt;smu, pstate=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;powerpla=
y.pp_funcs &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_funcs-&gt;set_xgmi_pstate=
)<br>
@@ -1197,4 &#43;1197,4 @@ int amdgpu_dpm_allow_xgmi_power_down(struct amdgp=
u_device *adev, bool en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return smu_allow_xgmi_power_down(smu, en);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
\ No newline at end of file<br>
&#43;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 1abc4be6b72e..9ad6f0f3aada 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -575,17 &#43;575,6 @@ bool is_support_sw_smu(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
-bool is_support_sw_smu_xgmi(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_support_sw_smu(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VE=
GA20)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
-}<br>
-<br>
&nbsp;int smu_sys_get_pp_table(struct smu_context *smu, void **table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index 4d1c2a44a8b6..bac7e13dc801 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -675,7 &#43;675,6 @@ int smu_update_table(struct smu_context *smu, enum =
smu_table_id table_index, int<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *table_data, bool =
drv2smu);<br>
&nbsp;<br>
&nbsp;bool is_support_sw_smu(struct amdgpu_device *adev);<br>
-bool is_support_sw_smu_xgmi(struct amdgpu_device *adev);<br>
&nbsp;int smu_reset(struct smu_context *smu);<br>
&nbsp;int smu_common_read_sensor(struct smu_context *smu, enum amd_pp_senso=
rs sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; void *data, uint32_t *size);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44889A7DC25DF57F658E1EFFF7B60MN2PR12MB4488namp_--

--===============1524901142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1524901142==--
