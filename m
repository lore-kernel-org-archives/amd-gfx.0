Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C27C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 17:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A49810E24A;
	Wed, 29 Jun 2022 17:05:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F40110E245
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 17:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+QWWOPXo1S6a09Uqc8HfxzCNrLUR+CvkL+kYZ2pmsMiOIUJJkvFc0EdmE3PCNgSqhoF7ZGYsVwmsBk+be48rMcFyeEeVZ7PdcI33aNV4mcHzESFLWbzcWaIEEaR91LhmVM1QISe7Biz66wJq2TMqo4DmHIkOC5z7lZMsMgjeXhi5wbPWC84sGVpxRymcp1lGoeREhlenTprf+0gkAIz/0+KE47Aso6ISXIKUofdG1bC2Nwdhk4R7pNnK+M1KCWAv/Kb/8mwHF3uhf+wouV8qkKene3sWSnBHlDWEeCeL1yj2RVx4YtCuyBbvtjl9DQeHm6Qlqw1q2y3LPwwbA27kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWmH1tzu2rW8o/snsZTNRlSz+ObjhS1jVT4BZ5o38AA=;
 b=BOVYqbZXBIwi5p6lY6Wd1G41joM3JQvHfCWeFjgL0mNWGJKITCQNDR6nISDALGIuis7rSdiiNfQ2++STYUTf73VMfvV292qtgt7TSdOkTqS6SNr/SaV0TT6owdHeKo9tY2l52PUhHW0FkOnjwQWogpMe9HMbsE3e/HceUMhWA6Nlq0pzmK+mUWVJpHzvN9WsFMYadC8H2bhMRqyHTrUFLduxXsK70TjVMuHQh8K4YcdHK/+drgwATmzM6D4dH0VGoJMsJirS+Ek2vt5YibdbCtJVpmnAl1aPzj6D8Q0kqkzshhVmYVx3RjSzzo7LuOZP4qLVv4JxriN7maUJkYEwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWmH1tzu2rW8o/snsZTNRlSz+ObjhS1jVT4BZ5o38AA=;
 b=uT3h2OW7voS628kMHfd2w+9jex0q9li4LIo0BvWbhvkxGGRwtVi+sCY/vI0JQnibeefNblSZ298DQjOMfNtXe8CcVr8xoiImPxYq7SNQHpxABKUJrrviVYRwsHRxEmaAwhQqaSOoYYctQJPdq8F1Jtmcckr0gTPKafQ8k4Bd1DM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Wed, 29 Jun
 2022 17:05:28 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%7]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 17:05:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "alexdeucher@gmail.com"
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd: Load TA firmware for DCN321/DCN32
Thread-Topic: [PATCH] drm/amd: Load TA firmware for DCN321/DCN32
Thread-Index: AQHYi9ekueW+w/Vsd0qoOAKuWMH/j61mnRUT
Date: Wed, 29 Jun 2022 17:05:28 +0000
Message-ID: <BL1PR12MB5144439CCFA68FC5C1E26924F7BB9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220629164518.2449787-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220629164518.2449787-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-29T17:05:27.745Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6319b02-551e-4620-283a-08da59f1911d
x-ms-traffictypediagnostic: MN2PR12MB4342:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DUUwpI06gHDFHns704lHTDBn+O3Nx+Eupg/FIElaqUUZkvkhNBGGp7Wz2pJuOfbWz5llvQb1kNQQxbFJ1s/eOdUOHFf7oFsei9T+a4O/fG6mUZJNIUUdgVmxCXi2E5msSs2yNwDiFkca3xLrrQHIlOJMrhB5aQQxmFjaRDWOb3mlUh1M8N5ywICM3Vsn9Ri0jUcmo/euguedyhat+jj6fuTePYytwo8vSUAPAlkmkxyyBcPHv9g9n8E/YFjb32VUH7sWaKQ09bhii2JYr1LEriqRlThhhdTMB0OSJlZBa9FFiAyDW7hparCZIvOx3nfWbx5dmkIZi9VqX9fSo/KySAW4L0o4RkqVJQ80qvgO6t44rZOXz0O1IXYPm6flizhrbSlJnld7mcLMiegQ5MDYcON+PqIrQl1YRLpixnxMTeMy+DOqf846Xu3o+HIMnTVpu/OY6sMo4yaKnAADCK7xoICTfaLxf6WPoVDfztOMfzpxxIKHYEGCSh00/nNGIdGC/ABjlTNHbHgrurxnfjdkAlzet4w6m8yJgtSjuzuobRAdSIWdDd6ZO51LaD8tKnoRssfNcVqEUdz6vzbd5OD3U9Hno1XjiJEJAGX2xIcp7szUPhYJV2nBkoS8iDqkdzBNcY6VjGbZy6TEYkHGGgTNz+qzY3BZ2bwnlj7rpnWFLfGBDsizwlFMhDXnFcUfQFZsBCKrO89eF5keooHiaaeDT2fFuyhACgkKXy5Lk54Ndk5f4Mj/+VR8wbS/1IGeuNZzKOQIeqIa4t15fKdnDvK4XhdjrWjOofibHmqUySg2oL0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(7696005)(316002)(26005)(76116006)(122000001)(186003)(66476007)(38100700002)(38070700005)(71200400001)(41300700001)(83380400001)(64756008)(55016003)(110136005)(478600001)(86362001)(53546011)(4326008)(9686003)(66946007)(2906002)(6506007)(52536014)(8936002)(66446008)(8676002)(19627405001)(5660300002)(33656002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?efIulFBgC3wBUf7MhX80CIvs10I9H1fENjNy2zCLu4IBs/Bq83qeE80/cOE0?=
 =?us-ascii?Q?7T6fGOLGvmbbTxZunbPOUDyo7UNtXzZqUzC8354/Ysrxx0eMsWqq1gRkh42E?=
 =?us-ascii?Q?Q3HOSKyX1Rty2DeWjusgA5TwRNQ0PpFrgRxxy13ZIHaN4IZW5dD+E/PW3Yi2?=
 =?us-ascii?Q?h5WZqRgpMmsV572bM+E4ez1GLe13PRrGzYWrK92qt17kNfDfp13g6ENkbyoX?=
 =?us-ascii?Q?C2VQtWG/bsh2bIhVW4l/FjnmMg3AwgJPWeeiX95aS3LpGgS20NN7q63GNT8C?=
 =?us-ascii?Q?pwfHNbJHAZ+JNyZJUd5hlv9GtwXCW/qim9D6H/L1bStZXJcUqTWiB7NMN0do?=
 =?us-ascii?Q?G2C0G+5Lt8v0atR4hzxKhBh8fP0/1Z4f8+W2MF0t+hooFZamSgklPW60pfDs?=
 =?us-ascii?Q?rKub08s8Jr6k27GW9U2DbG01Vys7c5jl/rdz0Glr8Io/3+JPFZTuotESyQ81?=
 =?us-ascii?Q?9PFK4OO94rlqMQ5GWokqXgtGIXUFsebuQ3WmW8yQOq1Dq6GxnjliIi0JuYHU?=
 =?us-ascii?Q?P6dW38sjgEOo9N7zByLkigzYO0FIQV855iKCVba1PkubkDNA2UCNROIf1GtM?=
 =?us-ascii?Q?mI/WdL7eKfGnGIdph98Tbz//G9mMrLy0JYi3I7YMeuQrui+IdZlSyBMq4XY1?=
 =?us-ascii?Q?XwJb4/td1Jr2R8I/b5YiGHQjskwEzsR305M8eGWkQqLnLg/NF5gh0tV+dObk?=
 =?us-ascii?Q?829f6q1rRuv0hDA2v6dU5O4BDRptns4G2WmIhGi2EVLJGfNz4TgXFsiRbNgN?=
 =?us-ascii?Q?4W9O42l+It4E+Yqv3AdEXXqsISjBz+nmonWWh4m8p7vqMmbL6Toc47uLL7H3?=
 =?us-ascii?Q?X4pRLxaJUTQE47Y7lO/S3ZtkwVdzTL8JpLpJQfPmr7xgJQHZQzLCkmh1crjG?=
 =?us-ascii?Q?zNcgFvZNmx2/Eb6Doue11IZ4Zh6Lt6FbeFlQPeTup8opnOkk573zq+4Tyy3e?=
 =?us-ascii?Q?LH3FS0T8EjG0/WtuiFB4dPwcoEwjFdB1yT0c40epe7jFj9QrqtlidjEzOgqR?=
 =?us-ascii?Q?CpRJ3TAudrQSR/ywucGWM4bOwAp+u5QhaIxQ0isl6qNnW9GhRCjr1PwSO1gk?=
 =?us-ascii?Q?XXw9gQFsxzQ5zbf3E3tEv+G5mitaTGLtJ3ZewEVxEhbLzAYpZ9PNDL0El7bi?=
 =?us-ascii?Q?yblROHDQQaAyE66BKj6cNqbBiBvOvrPos/ZjSRm3hOiiQwwU+XxqZRPWMlIq?=
 =?us-ascii?Q?jwPJ3POp6G2xa2W0ke8zPmYwdSeevE6Z8/8NY0GyQ4wI8mXOIwIJuw2w2ccg?=
 =?us-ascii?Q?CtpWcQHMvsCjJU5cHZwQGbkJgLEVrW8E9oN3uJRCVFqzgap1FQostu3w8Azm?=
 =?us-ascii?Q?nweFZ3/PPXPzW5QtNAsef5mPLrJNLhmte6fwgnmXTI4FpEJ/MtpK3K42/mFg?=
 =?us-ascii?Q?xgD19Bi9iB6tyzwV6EnDIRaGCcnP9loaQ4jShLsua12T+OZ34WuJ1e/WC3m8?=
 =?us-ascii?Q?EK9MzG3rcjQdVmqv1yUCTAVGf4IU48foItnAywi590zMfA4hBVQ1C8qSzhF3?=
 =?us-ascii?Q?+QKlhMtrF7gE1SiTJimEIXca6JuyBjhVNAKZNeT3ktoPXHyOu2p58hnRhKP2?=
 =?us-ascii?Q?9s8f0MKpwlu4fJ4fQCI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144439CCFA68FC5C1E26924F7BB9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6319b02-551e-4620-283a-08da59f1911d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 17:05:28.2475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbT5k13CjTZLUmzcFrkciErYx1WXrtjaDKkp3Hk9Zdfi1G0vtRceASBVPRuHZzm0lmTcy485yIiHxVUwaqNfxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144439CCFA68FC5C1E26924F7BB9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aurabind=
o Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, June 29, 2022 12:45 PM
To: alexdeucher@gmail.com <alexdeucher@gmail.com>; amd-gfx@lists.freedeskto=
p.org <amd-gfx@lists.freedesktop.org>
Cc: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amd: Load TA firmware for DCN321/DCN32

[Why&How]
TA firmware is needed to enable HDCP.

Changes in v2:

Load separate firmware for PSP 13.0.0

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 9e1ef81933ff..30386d34d0d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -39,7 +39,9 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");

 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -103,6 +105,10 @@ static int psp_v13_0_init_microcode(struct psp_context=
 *psp)
         case IP_VERSION(13, 0, 0):
         case IP_VERSION(13, 0, 7):
                 err =3D psp_init_sos_microcode(psp, chip_name);
+               if (err)
+                       return err;
+               /* It's not necessary to load ras ta on Guest side */
+               err =3D psp_init_ta_microcode(psp, chip_name);
                 if (err)
                         return err;
                 break;
--
2.36.1


--_000_BL1PR12MB5144439CCFA68FC5C1E26924F7BB9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Aurabindo Pillai &lt;aurabind=
o.pillai@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 29, 2022 12:45 PM<br>
<b>To:</b> alexdeucher@gmail.com &lt;alexdeucher@gmail.com&gt;; amd-gfx@lis=
ts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd: Load TA firmware for DCN321/DCN32</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why&amp;How]<br>
TA firmware is needed to enable HDCP.<br>
<br>
Changes in v2:<br>
<br>
Load separate firmware for PSP 13.0.0<br>
<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c<br>
index 9e1ef81933ff..30386d34d0d6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
@@ -39,7 +39,9 @@ MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_5_ta.bin&quot;);<br=
>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_8_toc.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_8_ta.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_0_sos.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_0_ta.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_7_sos.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_7_ta.bin&quot;);<br>
&nbsp;<br>
&nbsp;/* For large FW files the time to complete can be very long */<br>
&nbsp;#define USBC_PD_POLLING_LIMIT_S 240<br>
@@ -103,6 +105,10 @@ static int psp_v13_0_init_microcode(struct psp_context=
 *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D psp_init_sos_microcode(psp, chip_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* It's not necessary to load ras ta on Guest side */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D psp_init_ta_microcode(psp, chip_name);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.36.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144439CCFA68FC5C1E26924F7BB9BL1PR12MB5144namp_--
