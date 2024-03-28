Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F91C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 04:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62BF11228A;
	Thu, 28 Mar 2024 04:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cr+QVpYY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2560411228A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 04:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca2SDouuICJqFVOYdJQZqRMBVCXGbM7BCpqNy/+lpX3k5QLM/pzaZ2gNBZ9Sqtzjyz0UQE3O9WtwK2PfxOfy652uYnlG7m2Y1M3xEEefPeijRctXJeR8rTxIRaQ8fLwQvPzyUQSoMN3Z6nD2zln77H282Kq7BpL/6yAIhaxU/3Fm3uzLk88KbHtulwkjfqhjE0TbQZhfBYHHVvzydXh7R631z4Qs9cWurdQ3mfTnHDhtt2VfmMUNHkeiAuTXRA4Hzfl9Z9vpcOE3RiNFLs1gs4blfI5FlztmNGvwVCApZGXEcFB66fZTbhX1zPPoN+JS8+t7oLZOllG2m2GsRFaT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoRXhu9pIJ7UdwqBZz5PW6FJ0Ka4UPsNB7lD5hkb6iY=;
 b=AY9i7j+8IIV2kza3bd8TXn42TuxVAIYZ/bX1FcwFJgUbylu2RooCegCFpzo60Tjb+o6aJVjZYZTWEC0P6L9jZQEIG9XBYjlASbnqVM31JkDmLay99gICmeNoZ89iwlfKmzMY0h1fXb67498pZW5zmG/jGd7GnOaANsamy51rL0pXAdYdrks3HDzJNdiHEWcDdqA72+GdFsWBLaVK/cGdVzoeIfXlWgVGUgFl9zVS1WYt05E4OgVSqYYQTZlfBHgZqsWQVpSk1rO+Ov6gzDcm5bkZSpckYDi/5ZvVDIzV2ObApEsBuZUbXuAICkFeJCYCf/fe1ByU+U82uQaItnFsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoRXhu9pIJ7UdwqBZz5PW6FJ0Ka4UPsNB7lD5hkb6iY=;
 b=cr+QVpYYJK4FBAcOmW1MsEUtt4SJ9lUAvM5ztjjypv5Ik7PxhzT5FidHOlrNLdpiWr5kHtu1FdDAnKvilwZtDamS7qCHsup92+GLkVnH+ADhftajv8KaA96yvZEzzLl0T8GmeE+6ePhut2gpYrwfaZ4MeA+bLz4KKm5AKv9eT1I=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 04:23:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 04:23:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11
Thread-Topic: [PATCH] drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11
Thread-Index: AQHagMb1dwCgOF8Xe0WuNmRIadfyDLFMjbau
Date: Thu, 28 Mar 2024 04:23:22 +0000
Message-ID: <BL1PR12MB5144DCC97AE1E0F4A355FC10F73B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240328041720.276684-1-tim.huang@amd.com>
In-Reply-To: <20240328041720.276684-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T04:23:21.704Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB7295:EE_
x-ms-office365-filtering-correlation-id: e20335c1-5e13-44cd-db3c-08dc4edecdb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWI1kM9J6xnwOG3Tr8vQ3fM/naEZSxkR/5pfGxj5zNRLkcYFBufzaOdCVKf+q+x0G2I1OWkwcF5TAu78G/wuX9feY4xHw+YCVs7xu1/sKYKe2N2vjWNjKUk60QbZaX8+mWQKfEtoYy8ivPua73QJSbBoZ/yuEHHnljzxEves9sb4dQWMPKSERKXJpgIYgU7oCy4AZf4MGYNrzgSHAF1QTzRyWDw7gJvMTJ6fWtCJjx+ivLcc4rFyAx+N1A3hw4Tm8/fb+6z9X0PDlsDJXOwDIFOE3mw59640T10elnZUZHthRmUwFZnNusc1RfuyIuHxhIFWAyyRxoICpOjQnmPWbBP3b6BXON77Wj8PgHE5kMt0Xxt2od/jgOCwDr/6rONYi3e+JwNY9tllpV6krhVirbElrkfBSoyRuCb1S1IfpmxNWeTXYTaUi1/KSXalx1WpUybf1uWQfyGIwaE8iYC6sqZhbjk76Z8Upun8kMbnn6TQks3Vux0iXDyX+ZsrEmOn4ZXg5KZACU33a4a3uwS8XEnHyY/qzNRk/KzBx8d7M3aqEbNV7RH5TfE9zoawyblOrkdXauEeBQtfK1emlXI7l8daTWEYxIf61tkkAoOn2XgQ6Asm71EW2e9PILk+nFYhE3Wx+G8DFt3kmQwD6ffMduSuQE2X6ZwHF5dfyscmuzNH+deZs5xaUR44v1SUjPDSqNaD02yWUqtWkfxI/5H8xyUjy+udjXWOjgrQFm9vOwE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XqgOiZ6Vme8FahsRbJJhqq42TFG6PWiSDf2Iee70FORBSuZL32p+t42Ze+mN?=
 =?us-ascii?Q?insALQdzqxfT5tkV/RBtozaw5D5SfQk12sipx0awdywXeHXh0fLRc02dXSSi?=
 =?us-ascii?Q?IJp+TeryvjcVop8PQbJc+M+GnB+mD4Kl0AbRKEkJgiVSMegdb7rC2kURCWCH?=
 =?us-ascii?Q?SlA8HzQDA7LMdJ0gMa+1heQS2CFkG/XV1dxxRYfNtwj7I9zKxHYdAhC/y5tT?=
 =?us-ascii?Q?myDZEz02tvdEj0ktaEhRkmUofrU5D9aZrdM/vTzbicfx1LPfI0OGFR7EbdTC?=
 =?us-ascii?Q?kqPwQMgKEWd5NbdEVO3QVDj2GF885TmwfKKYEIYOI/udEpu8QiZWfvuAuCmw?=
 =?us-ascii?Q?ZM1xeEp9zIyjWuSXU4PmGLCUBsJzqmdGtoGHCXqreMRiO09ggoVs+jSIIVmY?=
 =?us-ascii?Q?a6Wrl6238Z7E6O2fO7Y5/fppUV0snvZFXl2xYUkXGrDfiQ0KH4+rIVxeuDmx?=
 =?us-ascii?Q?25hU2y9jHrb6CURvd5I4BURQLtw1rY8L56TZ0AIE3XmhWym+ThWYCK9kvxnh?=
 =?us-ascii?Q?OxT3MICpFW06HAG34MVEyYW/XWM83+SgDURoiB+kHmvAJEchTr4T4cALBIZ3?=
 =?us-ascii?Q?uz0wUpxMxzjwcyNlGkkpWsfRtGpCLvMOxZAvednG5+6P+WeG8piThTlBv0jN?=
 =?us-ascii?Q?eunQNFW1nR1Ip/5q/w55AQelDClPRYd8Upy06UbA/wOf2Q7WQMi5Lf9qSx+D?=
 =?us-ascii?Q?A8rpgy/0zEG8+XRGtfnMI/hg96cODUtEqhfj81h1kX926kWVzLUDRup7tCkS?=
 =?us-ascii?Q?6hTxlANTHjDMKXoBCqo28P1CyFLbccyVtPV3q4YVuP6tGthIJiVmSb1/BZ55?=
 =?us-ascii?Q?hIW/4qp3mns50GUCGRgxTUmoPmHUJZnJdH2bpkG9MA1P1EOLzOv5+BNjLvLl?=
 =?us-ascii?Q?fKYIbzflx/LVODyvkv7iWOd8gwT+CI+cGoiOaqVLmq9m3eabvzCKcmqQwT9v?=
 =?us-ascii?Q?RX7xGADEjOIRFZxG/8naltSxEN+3Okhrt+DQaKqnDHVysH1rjo8NM/0s5yQy?=
 =?us-ascii?Q?aIG2/4ALJQJhtYfq7Ap7hPoRxwWx/bZYOa3aZPgjjIliQsLLyOv8ViiJScuC?=
 =?us-ascii?Q?ciujID133tJiPeX1cYTP1zsjkAWTZqCDFDZibnBDZgJKIChQiKeiXIfIflaM?=
 =?us-ascii?Q?htifMROBh8XFVNgkmtKAwbgeYUMqrJwm2Fj8kmRStAGGAG8ehWdFXsDI+eJ9?=
 =?us-ascii?Q?r9i5CIRqXTx6cDeMCpsq/WG5Og7Zd5u8s8fZqCcQ09hgIqfiqCxwUk2b7BWm?=
 =?us-ascii?Q?Wh89TCrkofc0tXAAG7kypDqP/9XzydW/na5kcePJQJYsMD9Ef2ebFqM2QLCn?=
 =?us-ascii?Q?D0az7W/A767XAypjkyYd0BiWf/tkrTroP18i2dbOj0+l8HbDvQEiEyK1ETl+?=
 =?us-ascii?Q?focuuhYdjPm/587bFGGMKc1+7WLJSXIiozoR3pjopT1Dtid/9lAYZ4Z3mxKz?=
 =?us-ascii?Q?7HQqziQt8hMsaWo5S3QnAfApGXHSULW12jJuEuY6h0nHrzipkGkI0xGN2tHB?=
 =?us-ascii?Q?jjQvH7ICJLY/bKHceKSyJSMcGGTHcs9rzMPI1a15GdYw04U3hDa9INJn0sPL?=
 =?us-ascii?Q?ZpxGzltvnCx08F6fFVE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DCC97AE1E0F4A355FC10F73B2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20335c1-5e13-44cd-db3c-08dc4edecdb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 04:23:22.0394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJO8eD0qddD5wY9D0LBoPFWDH62jOGjcnUeoj0eTodN+Id0IfSevD5hkjwBveIrdGC4pqUYJvmYT1xaOto5uCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144DCC97AE1E0F4A355FC10F73B2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Thursday, March 28, 2024 12:17 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11

From: Tim Huang <Tim.Huang@amd.com>

While doing multiple S4 stress tests, GC/RLC/PMFW get into
an invalid state resulting into hard hangs.

Adding a GFX reset as workaround just before sending the
MP1_UNLOAD message avoids this failure.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index e8119918ef6b..88f1a0d878f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -226,8 +226,18 @@ static int smu_v13_0_4_system_features_control(struct =
smu_context *smu, bool en)
         struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!en && !adev->in_s0ix)
+       if (!en && !adev->in_s0ix) {
+               /* Adds a GFX reset as workaround just before sending the
+                * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
+                * an invalid state.
+                */
+               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDev=
iceDriverReset,
+                                                     SMU_RESET_MODE_2, NUL=
L);
+               if (ret)
+                       return ret;
+
                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnl=
oad, NULL);
+       }

         return ret;
 }
--
2.39.2


--_000_BL1PR12MB5144DCC97AE1E0F4A355FC10F73B2BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 28, 2024 12:17 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: fixes a random hang in S4 for SMU v13.0=
.4/11</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
<br>
While doing multiple S4 stress tests, GC/RLC/PMFW get into<br>
an invalid state resulting into hard hangs.<br>
<br>
Adding a GFX reset as workaround just before sending the<br>
MP1_UNLOAD message avoids this failure.<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 12 +++++++++++=
-<br>
&nbsp;1 file changed, 11 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
index e8119918ef6b..88f1a0d878f3 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
@@ -226,8 +226,18 @@ static int smu_v13_0_4_system_features_control(struct =
smu_context *smu, bool en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en &amp;&amp; !adev-&gt;in_s0ix)=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en &amp;&amp; !adev-&gt;in_s0ix)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Adds a GFX reset as workaround just before sending the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * an invalid state.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDr=
iverReset,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; SMU_RESET_MODE_2, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1F=
orUnload, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.39.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DCC97AE1E0F4A355FC10F73B2BL1PR12MB5144namp_--
