Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4E7C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 14:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD5F710E1DE;
	Tue, 21 Mar 2023 14:30:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7663910E1DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 14:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4h6WnWQmfeUh/RKsvJKHk+tOG5B+OqkB/qqlc5Fza4eW6W2U2GScvQd12ogyhibpgnkXQZ2XiDZRqYJaA4Fd0jZEOzFuh9Qa7FzeLGMtk5zpYP2aLl+pikErxBludndbXSo+uspBkXTn7im4PyPSiWBUZV940UXHuB6i1wg+EWFiFwFMf8F4NF+XKtNt/i9UqZ1VaU5AI4DC03dpl8ky3HWKhTJmFFZvvpU90XMZw86tpXKpxyUoCqNuDgKCX8nmRiWEfJYF42GC3ovdbBuI2NqJXvlxX8uYtitKYdEcScS6K0lQH65uj2TOnJPU9V3z46aJzlo6Dp7a15K9aqvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF1qGliUstqbXFKlbwEzkqiQgi/I2hJ7pSmBHfrn7Jg=;
 b=D+2eNpyue8FO1UWfV/+zyaYpC51rAiNw7VEj8xc5rkWfNVgy9DG3uz7mXwhisJ2VBBHdZ1RC0uVrdX0Q+YYQUD39oe3Xwg7stHQ+eif+Fq3BMcKeqWZA9si5bYeSLWtuG20YtuAWR82DKurvIPAGyNmfPtGeAAQL/Z90+oFqaMksvOzFSdGj9JCCu6mIv8VRtrH9f7KYheGCvgwTppvj9pZ95gxSb41xTI+sIDu4Z0vtBeEztJ/uGOv271FT2OjETO2i6+AD4iGz6+52t2EpVyF3keVQj+tZnB8AKr5JPMMpPMrjTzAqMLlcdRG5ZXmFjPiIACr43FcLRCR8ES7aog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF1qGliUstqbXFKlbwEzkqiQgi/I2hJ7pSmBHfrn7Jg=;
 b=OgRNAlzxgkCNKu/ZlSeljdH7MdxY8IIE6pC8QT7RVHhLDFTS4zAgX9wmitWZCwUAqFW3JOsI1pqg5b5J105etF4klCT77+9qDNOC6ypZarqEUGl968dZksX18zaNdS9vB8vCf0xf6OLgXkvrlzwcGfjEvdNPYi1jDmlU69YVHq8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:30:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4e0d:adcd:8547:2ff6]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4e0d:adcd:8547:2ff6%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:30:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded
Thread-Topic: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded
Thread-Index: AQHZW9Y0RDqR2LtSX0a0LpaiVjjnva8FS4DE
Date: Tue, 21 Mar 2023 14:30:15 +0000
Message-ID: <BL1PR12MB5144C514C69B42718855FB22F7819@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230321091900.144479-1-Tong.Liu01@amd.com>
In-Reply-To: <20230321091900.144479-1-Tong.Liu01@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-21T14:30:15.328Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB6293:EE_
x-ms-office365-filtering-correlation-id: 2107ea63-a3b3-44a8-8d6c-08db2a18ca0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tATuycy+z2Msz9R3sqYtD4f1Hgsp6a0uTMYHgQ+EekSsRlMaxprA0lPod+x9a+l9ryZbLAxuWZjZbNh+0u/qZNKKLfrxn+X7fVA5/ty2KTp5/lCesPwRKYBKZIQF+XFKPmAx2H5nKkvRs8Ss/+1gJ4Z7ceNSU42vUj7+H55XvcHsavtOGdtr0ZhY3pqhGNoyuW3tAK6MwX7ysTLbHfvDMWeHaIl8UjLvjr4wmYWuydlF+kn1fwVD6umBiYm3lsZ7jhMDj6S7tLvJTXZpoKptzaROnUhKyvl1gHKgIZKUdp4+vRhdrFFtRPUCDbfN1/BWsIvQAHyhgyFKhRdJAXCSVJRPfMorzFLLljuWn0HuRkcIzpBoY9apmJwFDY3EWCAlWcBr7nwxFzuQ2iPR1xZM+Dx4z0wSXLDpuX1tsp/sXAe+ZFMH8F8LkM+Indz2w/RWLPtI2+WRGuQweJN6Fgo5iHI9KA6Kt3xJty8frCv4VShphN0tWezTGlQmGZaFzQAy8FqgQV9yXxppz8A1UEEU8lZd1DtZXF76kv00zGLkY4YiUWmUXzarYFvWPwzQIe4nVoZxWECs2xsba2c7d5SC1HR4buTNkQRIDjaNgsgtBhX7pgaVJzA5XsbmyV76WZxHoZUEokCrPxUFotNj08fxIDWH3GgqbAaMovhUwC3xTB6Tx55ewd5jHYJCdQg8C8kxGim+rjpL/MlPThbZ3nNT3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199018)(86362001)(38070700005)(33656002)(4326008)(110136005)(54906003)(66476007)(41300700001)(8936002)(5660300002)(66556008)(52536014)(478600001)(8676002)(64756008)(66946007)(76116006)(66446008)(71200400001)(2906002)(55016003)(38100700002)(26005)(122000001)(186003)(6506007)(53546011)(316002)(9686003)(7696005)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bkXy0B17I1pzCHkAgD7/K0U2whwrXTRb1f+Thky2qz8A3CTPcqwSapVXc8++?=
 =?us-ascii?Q?cgv5AWP7+FfRVcipsUet0k2t4dz2YrH634VesVQ4hjy/4fHwhi86skzZOdOb?=
 =?us-ascii?Q?sGAT9d1YgTOn2bVaTGPHsb13UfAKB9cjKTJaiRiYYFx0KmCS8jPCtWq+jMTO?=
 =?us-ascii?Q?6HvKycUIvAoWKfl3d3s74rrDchcnzPqGZvm5muHx0lB0bAKQ72vzYYGChl6b?=
 =?us-ascii?Q?keIcN9j5gjES5nvNXcM2lnRg+CnAWG4HKOLnbDJOQZpVHy/u3uNcwn5/iVGn?=
 =?us-ascii?Q?+e8n74Cw1fxMmFY5s8t7WndsPXiepVhnTndGCWBhtlVVMR5ViEfE9/bUTMV2?=
 =?us-ascii?Q?64iX85E1m7nKx1crkDhJ8TpirmAKIoaOMAgJrMlpGp7J6NqW76+nNWs+aAQO?=
 =?us-ascii?Q?VOiJANKWxjIVPjFmKdYp5UINTCtovW/FridtRpUb4Q7cVHqyjWp8/WA9EvTu?=
 =?us-ascii?Q?3pw9mESZoA3rq6AiHyYX8Fd/d/fzcIABy/7/foaUUbA4ZfaTJ3rk7XvHORgP?=
 =?us-ascii?Q?mJLIb7q9ziI0z/jX1MfbEXgMk9PbU+blFoarjmF+tCGFFokk3Pj9xpWjED3U?=
 =?us-ascii?Q?e45ne1iAhPiYybINBQpvbYhmZ0piYDGjJmaj+hLiqBtJLleHfOHWpWDo4Isx?=
 =?us-ascii?Q?sp08dMDWsVYgKfUnWCZBoCl+Cvq/us2koR7RuAvv6xwKRrEypxjLyMpgpRL4?=
 =?us-ascii?Q?MTwbvOz8qqcwudyTKUp7FlMyNhjZdRfEmxnhuXZx0UkIplPiQaN+ubiiNX+o?=
 =?us-ascii?Q?s34UyDgSAAjJEUGMoLdMa7odVUR5kq3a0/hmKcYJvABaHz7zRBfoLUod0CyG?=
 =?us-ascii?Q?NQ4VEpbg7SrSb3u4+K/Goy3pI074p3a4SVoWW4v36ma5bLXllTr9rF9PncXP?=
 =?us-ascii?Q?P7cZrsLsGPT1x4BI6T0DMvKMHEAQneFqgXXPZGunEtSmyY3Wb5gNflmflTlP?=
 =?us-ascii?Q?j3BA4JiMF5oLUNOUn+Ulz+qm74LxyTH9aFlUg5qwdIgrjW+LmpACzOY3DH2i?=
 =?us-ascii?Q?QYc8asqhaC7TI3bKkDVAYxkFrj/zXEzvkf3BjVeTHoXBAfNZMJs9TCMdCxv1?=
 =?us-ascii?Q?mIkxk9thjwfk0DnsGnXTsS4oxucB4wtTNlEc2DQ5I/ogkaEzo3ApCjwZFQ9J?=
 =?us-ascii?Q?RPqJIqZUSpQQv4Uv+BW9YwuI5iLtMvu3ElNZ6ieUTWD9RSm0toF+tM5iKQjh?=
 =?us-ascii?Q?rVZDt+uwWiDUudAnWBovVMI6y+voJpqIYY9eY70b7Y7yGnBCsVSWO2HByNrw?=
 =?us-ascii?Q?uzaQuxy8+KDe1SquVC30EXUzbuotbxdk/J4M86Wpb4w8hZt9yKyLlyR6DskY?=
 =?us-ascii?Q?+ShAGXnX8ik6udF39pt8shHlAGctG7cfYcytsPBdO9g1clR6ewQMqgZ8Yl21?=
 =?us-ascii?Q?4i4hJKhaIq7xgptYFzTvzZOAf9xG702b+6YkolDGqAscYHlZRilJNjZHFh+c?=
 =?us-ascii?Q?gqPOJuj6IYJtwO8YWK7Rkw9Z8bs6OFgQDzDuisa36AjQpBG8tbCN10x9wZFH?=
 =?us-ascii?Q?iTP5R9wG6sFFFqjJGhXLyRbibGPNX2COmprKF1/TaWI0x0qlHZUzmzGddzOH?=
 =?us-ascii?Q?NlAchfjjPDGCQ87kTLs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144C514C69B42718855FB22F7819BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2107ea63-a3b3-44a8-8d6c-08db2a18ca0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 14:30:15.9834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFPGIDUCj3j8Ki4q1wP0/H4LSTFVhIWkp4PLv/qYEnrNy4TkrVChHgKJCSjtAgnUcCYL8g0vN3ZxDhyI05XJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144C514C69B42718855FB22F7819BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Tong Liu01 <Tong.Liu01@amd.com>
Sent: Tuesday, March 21, 2023 5:19 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu01, Tong (Esther) <To=
ng.Liu01@amd.com>
Subject: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded

[why]
For Navi12 and CHIP_SIENNA_CICHLID SRIOV, TMR is not loaded. Should
also skip tmr unload

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 0b9e99c35a05..69addf2751aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -841,6 +841,12 @@ static int psp_tmr_unload(struct psp_context *psp)
         int ret;
         struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);

+       /* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
+        * Already set up by host driver.
+        */
+       if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+               return 0;
+
         psp_prep_tmr_unload_cmd_buf(psp, cmd);
         dev_dbg(psp->adev->dev, "free PSP TMR buffer\n");

--
2.34.1


--_000_BL1PR12MB5144C514C69B42718855FB22F7819BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tong Liu01 &lt;Tong.L=
iu01@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 21, 2023 5:19 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Chen, Horace &lt;Horace.Ch=
en@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christi=
an &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deuch=
er@amd.com&gt;; Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking
 &lt;Hawking.Zhang@amd.com&gt;; Liu01, Tong (Esther) &lt;Tong.Liu01@amd.com=
&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[why]<br>
For Navi12 and CHIP_SIENNA_CICHLID SRIOV, TMR is not loaded. Should<br>
also skip tmr unload<br>
<br>
Signed-off-by: Tong Liu01 &lt;Tong.Liu01@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 0b9e99c35a05..69addf2751aa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -841,6 +841,12 @@ static int psp_tmr_unload(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *c=
md =3D acquire_psp_cmd_buf(psp);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For Navi12 and CHIP_SIENNA_CICHLID=
 SRIOV, do not set up TMR.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Already set up by host driver=
.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev) &am=
p;&amp; psp_skip_tmr(psp))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_tmr_unload_cmd_bu=
f(psp, cmd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(psp-&gt;adev-&gt;d=
ev, &quot;free PSP TMR buffer\n&quot;);<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144C514C69B42718855FB22F7819BL1PR12MB5144namp_--
