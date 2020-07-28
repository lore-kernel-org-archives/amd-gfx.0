Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5185AC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 14:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27237206F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 14:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v/f0g9Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27237206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAA26E2E0;
	Tue, 28 Jul 2020 14:16:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB716E2E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 14:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH5UASadRQr8CLR3ZpY45aLSGq8A8tylIHQ0l+roOW3u28kmfaPrfILc/vwZhYK8WUfZrvUTQGLX/nHdK7R2FyXpW0ibrMudOLg5opewplhMZ6+5owJQoP76miIgEXgP9D6UzUF3CwsUkwZ+NBQytgvatvII0kbfOXDEDXJLvQcRyPxtUE/ciXZKSmKiKBLNmRbEORIyimgNJHjeC646aVGoo9G1i7oK4AnIOPg9e778qpiD3zI1Fo+c4ITPxhaLbf5np2ETJQMWav6MWaSuMap5aNs5vpqHTY0bJuX4qn4UXlQe3H/+XzxNnFRuc3jjfBt4vNLHGEC54erIM/mq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXUSPasgsKxrjJw98Tzi+K9KqAbUhvi6qOTc8G+0Y2A=;
 b=YG1TBGnnu3SUqU4eLBfYS+o6M54zDO2+v6OnRi/mmGx+Sc1NFpg7lnfSWbrRwl/Ze6PQROOCE1zHGoChclbZTOfaRA0yhENYn6pfy9ZvdsnAzsnzDUSNZ++8XDkVPjJ+nmDLIx9fKqYVElO54QrL1yGaJJ5I1HU33TQ0pQmFPhkhhsb6cXviSf+LWBgmWn95qA1KW0J7z6FtIJF6zWYJU9IBlvlEmx3qj488QcdZM9Ybg5mCDFI37mzOOYC27E0f+Zy+NRxWup4nzJSD0225/xoZII7tnYW0gJtiOvj3i4MG6e0rGZmPxn/LuAz8SvT/lT0a0syNUb4ZCIxRG5p2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXUSPasgsKxrjJw98Tzi+K9KqAbUhvi6qOTc8G+0Y2A=;
 b=v/f0g9Bw4a538i2R5abin93ZoNiFSmkhEKv/VgqVya6peKmMJOGi31KLDeS3jpSgHWwVEYWCwK+7Srd056Zfs0XyHlW4GssGyHDJjNd5bd+FyH1vJ8Ion9dUY07MrrE06tKyOzCxol1oGUDS4ngQGPJ8bialw32xt4Ij4/IiJ64=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Tue, 28 Jul
 2020 14:16:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b08f:7a26:ea10:c9d4]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b08f:7a26:ea10:c9d4%8]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 14:16:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit(v2)
Thread-Topic: [PATCH] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit(v2)
Thread-Index: AQHWZK1gPyG6F8SFtECXWSSqTFbxWakdCWEd
Date: Tue, 28 Jul 2020 14:16:32 +0000
Message-ID: <MN2PR12MB44884A56B4F6E0C013DA86F1F7730@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200728070433.4265-1-tianci.yin@amd.com>
In-Reply-To: <20200728070433.4265-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T14:16:32.414Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 632d8c12-2e49-4779-5294-08d83300d483
x-ms-traffictypediagnostic: MN2PR12MB4376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB437622133AF74906E569E076F7730@MN2PR12MB4376.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+rF5ZNMc4gfF4WetGUpdu9mXpmA30MQpxRSG9t7ej3dIqWLr5hHYi0AIARwEAyteMqS3MsPrru4DCJgFMYrnqcbf6R74HX5VjrQLvalIDlKKnDKCfHDxKTOU8AxFBCJH3zpCTxpBKJKQFPpt6W4SXC9xoEFn6FjZZwXcBK6PIERHToKHXfT9lW0aiSeCcvb8jZtsKegue3lcLiSphTS930C/xT994O+Mc/vm1dpbG59S4gLsxF9YTahrXJ9NR55jsDFH34ZXV1AGYcHhUB0sC9boNXpsPWb1telp2dSoMD8zjb0myvuw2z4I++jfelkjQmrCtO3GYsB/4kJgnZBNPAxXVrmwGzpnRGiqxDvkpEgtnPig5uvtIpVcN694kqJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(86362001)(26005)(52536014)(66556008)(66446008)(7696005)(9686003)(66476007)(8676002)(66946007)(55016002)(2906002)(64756008)(19627405001)(76116006)(186003)(8936002)(478600001)(53546011)(33656002)(6506007)(110136005)(316002)(5660300002)(83380400001)(71200400001)(54906003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1ZZ+VqZGpfhmMYnNvEkjNUFMxvRKYUJagKIxhGi+vfFHWrDfskGN572EnDq5EWlbfM1H+V0YXcDHZ+OE9tlYmM9MOlOQVsv8pGm4Ra3yX8O6qV0t9UsuOHFuhuvYkxmjoacAfmZKcEg/gWKBgaeOwrD05flTFZurSBLcGbF7KG4W0bBpGf3O4p7YcIlTmOyShvJgbgbG4aVfy4ZK5f2f6E8c8mB6Y/Em2ZreQ0iX4VgxYsKCDZID8q4CbG7NPEKBA4TaltlBiPn58W0bDGBFSbDJFmN2w1a1aGB7CDaelBcVjsCVrOlCD4xUzS8DQ4Sw6DuddoJJBtp4Pq8zZMGC9yYUcYHGJkwMKK7vTV2OUR1Ve2q8aNFaFvioXqHWB7GCwJg/LljP8uVDYSpjHtmsm5/LaFExWvY4STvtIgS3L47nJvWW0Pgi5N49C6+sqP9u7raGNme/pidVwCZ1ecX8KV78h+N/Aweb0tX58orbEbU+2ZoDqdG5YMsQB5d0oCZD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632d8c12-2e49-4779-5294-08d83300d483
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 14:16:32.9714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: of92JpxPKQCWFVUrB5f+5lQIWp2FQ/4Mxdg6QS0EjniqgPU8T4Ilbi/VI/QkZwru0WcwTnPbNdMGDx9MgyjLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Hesik, 
 Christopher" <Christopher.Hesik@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1394346389=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1394346389==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44884A56B4F6E0C013DA86F1F7730MN2PR12MB4488namp_"

--_000_MN2PR12MB44884A56B4F6E0C013DA86F1F7730MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Would it be better to put this code into amdgpu_gfx_off_ctrl()?  Then we'll=
 handle this in all cases where we disable gfx off.

Alex

________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Tuesday, July 28, 2020 3:04 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.X=
u@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Swamy, Manjunat=
ha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Guchun=
 <Guchun.Chen@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Yin, Tianci (=
Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amdgpu: reconfigure spm golden settings on Navi1x afte=
r GFXOFF exit(v2)

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,
reconfigure the golden settings after GFXOFF exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 55463e7a11e2..41487123c207 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,

         struct smu_context *smu =3D (struct smu_context*)(handle);
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
+       struct amdgpu_device *adev =3D smu->adev;

         if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
                 return -EINVAL;
@@ -1318,12 +1319,22 @@ static int smu_enable_umd_pstate(void *handle,
                 if (*level & profile_mode_mask) {
                         smu_dpm_ctx->saved_dpm_level =3D smu_dpm_ctx->dpm_=
level;
                         smu_dpm_ctx->enable_umd_pstate =3D true;
-                       amdgpu_device_ip_set_powergating_state(smu->adev,
+                       amdgpu_device_ip_set_powergating_state(adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_PG_STAT=
E_UNGATE);
-                       amdgpu_device_ip_set_clockgating_state(smu->adev,
+                       amdgpu_device_ip_set_clockgating_state(adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_CG_STAT=
E_UNGATE);
+
+                       if (adev->asic_type >=3D CHIP_NAVI10 &&
+                           adev->asic_type <=3D CHIP_NAVI12 &&
+                           (adev->pm.pp_feature & PP_GFXOFF_MASK)) {
+                               if (adev->gfx.funcs->init_spm_golden) {
+                                       dev_dbg(adev->dev,"GFXOFF exited, r=
e-init SPM golden settings\n");
+                                       amdgpu_gfx_init_spm_golden(adev);
+                               } else
+                                       dev_warn(adev->dev,"Callback init_s=
pm_golden is NULL\n");
+                       }
                 }
         } else {
                 /* exit umd pstate, restore level, enable gfx cg*/
@@ -1331,10 +1342,10 @@ static int smu_enable_umd_pstate(void *handle,
                         if (*level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXI=
T)
                                 *level =3D smu_dpm_ctx->saved_dpm_level;
                         smu_dpm_ctx->enable_umd_pstate =3D false;
-                       amdgpu_device_ip_set_clockgating_state(smu->adev,
+                       amdgpu_device_ip_set_clockgating_state(adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_CG_STAT=
E_GATE);
-                       amdgpu_device_ip_set_powergating_state(smu->adev,
+                       amdgpu_device_ip_set_powergating_state(adev,
                                                                AMD_IP_BLOC=
K_TYPE_GFX,
                                                                AMD_PG_STAT=
E_GATE);
                 }
--
2.17.1


--_000_MN2PR12MB44884A56B4F6E0C013DA86F1F7730MN2PR12MB4488namp_
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
Would it be better to put this code into amdgpu_gfx_off_ctrl()?&nbsp; Then =
we'll handle this in all cases where we disable gfx off.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tianci Yin &lt;tianci=
.yin@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 28, 2020 3:04 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Hesik, Christopher &lt;Christoph=
er.Hesik@amd.com&gt;; Swamy, Manjunatha &lt;Manjunatha.Swamy@amd.com&gt;;
 Quan, Evan &lt;Evan.Quan@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com=
&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Yin, Tianci (Rico) &lt;Ti=
anci.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: reconfigure spm golden settings on Navi=
1x after GFXOFF exit(v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.co=
m&gt;<br>
<br>
On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,<br=
>
reconfigure the golden settings after GFXOFF exit.<br>
<br>
Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9<br>
Reviewed-by: Feifei Xu &lt;Feifei Xu@amd.com&gt;<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 19 +++++++++++++++----<b=
r>
&nbsp;1 file changed, 15 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 55463e7a11e2..41487123c207 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D (struct smu_context*)(handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;is_apu &amp;&=
amp; !smu_dpm_ctx-&gt;dpm_context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -1318,12 +1319,22 @@ static int smu_enable_umd_pstate(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (*level &amp; profile_mode_mask) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_d=
pm_ctx-&gt;saved_dpm_level =3D smu_dpm_ctx-&gt;dpm_level;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_d=
pm_ctx-&gt;enable_umd_pstate =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_powergating_state(smu-&gt;adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_powergating_state(adev,<br>
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
sp; AMD_PG_STATE_UNGATE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_clockgating_state(smu-&gt;adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_clockgating_state(adev,<br>
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
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asi=
c_type &gt;=3D CHIP_NAVI10 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;asic_type &lt;=3D CHIP_NAVI12 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.funcs-&gt;init_spm_golden)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_dbg(adev-&gt;dev,&quot;GFXOFF exited, re-init SPM golden settings\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_gfx_init_spm_golden(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_warn(adev-&gt;dev,&quot;Callback init_spm_golden is NULL\n&quot;);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* exit umd pstate, restore level, enable gfx cg*/<br=
>
@@ -1331,10 +1342,10 @@ static int smu_enable_umd_pstate(void *handle,<br>
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
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_clockgating_state(smu-&gt;adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_clockgating_state(adev,<br>
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
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_powergating_state(smu-&gt;adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_set_powergating_state(adev,<br>
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
sp; AMD_PG_STATE_GATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44884A56B4F6E0C013DA86F1F7730MN2PR12MB4488namp_--

--===============1394346389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1394346389==--
