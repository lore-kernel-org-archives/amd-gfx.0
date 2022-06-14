Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579D2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 02:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF07410F515;
	Tue, 14 Jun 2022 02:39:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7847210F431
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 02:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZbJvDRfrKlhqvh4vVHBbEL2QuNsoZFK09g5pPoK9JFaFPZGYUqCrA0jD8ugAyZmFBjaQvodlybrvDyxsjxssv4txSDQrDisSKTa19JWzN0tO7WkCI+hFLbKpwV7ANrpdqk4LW2f1J8S+amESvM420xcfiFeLAPr26i2Rt3hXs+V3t6Trh0cNs1KKi/z3cE1CW7pGbbVVzMzjgba+iYGT8YOf7dstun/3/FDCFfiqVLwTN84ohlKnmUf4KtGfjYwFypCpgIbMs5M4uosA9BiXiKTr1sbx+Ibar9gRy8B5I1ymr9AaVfm5LZpp/RgNwDVnkn9qtdAMYK4DbtJY5E+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUtdR0wbPLlJ+XmNK3YOgfTpu3WH53QLrUpf4cjK9QQ=;
 b=ItjzaIFw32nwU9C68UANQ8z0UMBJ21QavhICbfQZpCgLHHjFf41zpyShzolHiKqHq8QDAjVxslbpS5nOt5klbXDI+SriUNUTolrNt9xYsFIvO785CU0OxXRR80BQZXtgb/FtD7mbM/CgpgMd7R05T92vaHKoV/s0ob73sNg9L84vuwgtvY6y+CPJ+MhZeOrkkywCZYERXE/V3aoTD3E6pIWAn0r6evd4pOiacNNVTxyjHTf3iiNHXt1++5cZ6eAVwB6pVSGOmSvpN3dWi6OWq2sUbsx/0MWUKUo1QjxJy4zbLPsDkyt1BMfxnAt4orFYMbBqkatkWTTftKM5O3shbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUtdR0wbPLlJ+XmNK3YOgfTpu3WH53QLrUpf4cjK9QQ=;
 b=BhkOU2pEJOO8rXyTa6RL6FpqRQGiYqIsgFrE1FJa7qwfaWTDBDTO5M9dPhsko4ueFfIK/bEJ7oIxps++u5HG7e1+kVPnTILwO1BXLXniqfsIPEPbzVaJ/bo4BEI9PDUr2kJVQmksfus/g84cTpu2giuYnHtfVy8saGMIZmrtYyE=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 02:39:18 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5cc1:31e9:80ac:7e7c]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5cc1:31e9:80ac:7e7c%9]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 02:39:17 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: remove redundant enable_mes/enable_mes_kiq
 setting
Thread-Topic: [PATCH] drm/amdgpu: remove redundant enable_mes/enable_mes_kiq
 setting
Thread-Index: AQHYfhWKri2rsYsA9UqZZQ55EZmNCK1OMWgk
Date: Tue, 14 Jun 2022 02:39:17 +0000
Message-ID: <MW3PR12MB44583B29E6733DE47EC41B71EFAA9@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20220612043143.2755859-1-yifan1.zhang@amd.com>
In-Reply-To: <20220612043143.2755859-1-yifan1.zhang@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-14T02:39:17.159Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
suggested_attachment_session_id: db1c33ec-0475-0ef3-6c76-91d76f09c4aa
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15c56926-b0b5-4ef4-baba-08da4daf1404
x-ms-traffictypediagnostic: BL3PR12MB6522:EE_
x-microsoft-antispam-prvs: <BL3PR12MB6522A1CAB5A7B10A89B6E3BFEFAA9@BL3PR12MB6522.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LiVEfdU018GDt77e5bpFemw6g0LFqAIntgcGaAw74Hyfiv5ip/wUePmbchElUEMj4xj/laJNo+G+Y4OXHzcMG7wHrzvaauTajsj7GFa68kGnQ+GsEsJzLBem1h6Fj2hjZf+uB2ogfveOqdfJqMFHx4wMznEu7muKZQmTnGiIRXQ5/dKYc54Cb0dgQcOQhNIbdIzQZCwoXxxHTdz2gz3QkoTAdHZtlWHXGcTBgBajCDAGEFewNHEJlkUzp1GzPwIYBINQ0w8JPn4ybmfYlcsfM8SI1VmL9voQYfT/a0LpicvslSuRVZCyE2hDXCl3YUMtNmHHuHJPSBpxw3ZNkUnJfZenHCoJK2bSFAfBMOKvzefYm4EZ8QDW77su5eF6jrJDsMt4oWLA9ple5Es04xRCCym/2whewwtyUieRQOjNO4zCHVspSSWWKqeefIg7dgJUf5AfOD9M88DFL5ESTJi/aKMwhE5dd889G+ARqP739Xd4O0Wd1X9vMmVhkCk5QjyZTs8V9LcUGrfQo+Q3dnOcQwDpA3G1t0J+26YJe53Lt+V2gO91FZo3gukY2cdwtzTLParMEqAdXWIpLurOrGB46N8CKBMDYZCZuTm8OoojrNnglaXpHLwONbSV3Qdm3/Rk2ECu4yAsu6LRWnEmlKXsVEwxpEQjxTATR9XyLaxEfRFGPNVuzwpUJHVJyAbc1uVDZXmObQutisOVZ2qrMnU4XA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(316002)(9686003)(508600001)(26005)(66556008)(53546011)(110136005)(71200400001)(91956017)(33656002)(4326008)(5660300002)(8676002)(64756008)(76116006)(66946007)(66476007)(2906002)(66446008)(52536014)(8936002)(86362001)(19627405001)(186003)(83380400001)(6506007)(38100700002)(55016003)(7696005)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YGm+NNOgmAcUyRarvwxoA43LfFru7NtJ5yD6ydU4CT89dQjgj1KhvJhYelVx?=
 =?us-ascii?Q?FibfsP/rTn2kfWZ1yyunSNLC8qhI2TbKEfkncGymWYxqghBSdPCzJ7f8oMqs?=
 =?us-ascii?Q?2HH/C3lU6SSBXBdpUJc1n6Ytg+6Ld/gZ31Jzose0SlsMODLYF2fK2WqKfSsv?=
 =?us-ascii?Q?Rkdny7IBFlQhIbpuebiG5MeBLsgTs5S33YQf65Wt5GALldx7M6fvTGf/n36S?=
 =?us-ascii?Q?r5pWxbgmx1+aH6hacvXuY/4mu4XUI8Q3JcEdppA8s6MrpGsaTVNgTlhCmLaJ?=
 =?us-ascii?Q?zwrL+fxPKirJwsoULswh7xqyQiXa0OQkq1LCNK4Gi/jhsujGem3QyrUM+/Vi?=
 =?us-ascii?Q?0F+U3KAalKEGjPVqYN6YKdS29rqwVkie+UlwBPBdH2WDSyce1U+/1zFjTNrD?=
 =?us-ascii?Q?s3wdzyWHsmTh9vAbCVLjuB7U8g4rvOxHRvka425LC4z75vL2Mru7hhBFgQkM?=
 =?us-ascii?Q?0+qxJtS5gCBJhf46J5Bzw6WNUH/UekaGe1zWsLd+r+5Z2NLXekuOYUTnMENf?=
 =?us-ascii?Q?EZudMdcsyEaY1qJLGt0MccCfvhtynOZ9C44Pl8ivKM7gjdPYyFtSUwb5WW5m?=
 =?us-ascii?Q?ZalLo1qhRiktlZvWlaVc8IFg1ixUcPJ1tj4w7pkqwFRu6GT9DbcoJ+fOEkUK?=
 =?us-ascii?Q?8Yv4lFzLDcQKvSME2faZaVaeM7HE6/p/KCjVC5/neRy6W/sBYgmQMMWc5Z/I?=
 =?us-ascii?Q?DVqxsm3oy/gUOm7hwdyLBDiUy6a9xIpVW+t5WKVv/Rk+YCOE6Mm628ZeT0f0?=
 =?us-ascii?Q?LA0ZdockTxHqncctIo1Pt3O0KXlYwAulCw9AoAuuV/erHQUxzEnJTXEqU/Vf?=
 =?us-ascii?Q?iqqmRXM64CEgsrttrwTOFWvMuKg9FcbQQiKVxW231fX1gto+7LvwSc4hFPZX?=
 =?us-ascii?Q?XjilZrQNKTmMpgCeliudlROOvSzSZ4LFmlwrKShmVrlhG566mV9XkGsVMb3j?=
 =?us-ascii?Q?6bDXc1mxkqGiqf9ziOMYAcpW2UI+eYzbeh/lL6maAVrhW/gFdJuLVnW0FGwq?=
 =?us-ascii?Q?GVqol8PjDEObKc92Tn6Ih1F7pC9Ws9cQ2FJEhT1pUJ0fmm6tEc1UkstLix1C?=
 =?us-ascii?Q?RQDTSRTsuIv/tIyaZ2RCU0ISjgvNsrKb3Fwsp2FtsAWs2MnY7gBzKcIe1Icp?=
 =?us-ascii?Q?u49tDqS5qWvEt65Rsh+c1tgFWJVlZc5OWqump+tits4cyawldxwiEpRbH0a5?=
 =?us-ascii?Q?DY3gxc6r8erRP9JvfF5C0WMHI3I5ASQpPPj1+nM5qsqcRTrcGipHlPT+Etx4?=
 =?us-ascii?Q?Ey3pfxJfJHmKigLPrTZjIFcA0PiV9VlgysvBCzWWU97HFiaAJibHHVZPsuqF?=
 =?us-ascii?Q?w4wBwVSFlOPvNxB4XDxQ+IbJqcaYQUy5EJav14BRhuL8gZoEdWRsxlUDUnZq?=
 =?us-ascii?Q?ytaM89Xg5eeAXtF/PfzGgV6XAvLTkr0pwNRbHFZvXDgU2kFLq8+4p2E2ukeK?=
 =?us-ascii?Q?sjLLYjw6j2lmhco7Yv4xhZ3tQ6Bp1vLJ7WwuQ4dI9ejiuHug1qafvZL/YRno?=
 =?us-ascii?Q?wINd+Xp8a1NLmhQhRPC4NZ46Do7DCDGCtMYeREf93QMy8Y1yRQZxo8nxlA4P?=
 =?us-ascii?Q?tbGVSmdhvY6bc3S6OnnEiCtlRdTQFgF55SGOLmQicU9xsbrJQG6n40lfDUIQ?=
 =?us-ascii?Q?ev5yRUTxa0koc2CtvtbWMEWI/6Inw+s8qwgckcoK7XMxBfjBsYJMn94RUfIf?=
 =?us-ascii?Q?wrqeDvBOhYWjJWzTCPbs5tNbqJx71jX7gL38h3XLlURIt9tP?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB44583B29E6733DE47EC41B71EFAA9MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c56926-b0b5-4ef4-baba-08da4daf1404
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 02:39:17.6191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7f1dQ+la3mTEyAZOyCpYpgxu4xjpTMCJVvzQCb0LXfdTuMNRm6csjrBAFWXCjOM3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MW3PR12MB44583B29E6733DE47EC41B71EFAA9MW3PR12MB4458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>

Regards,
Jack
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yifan Zh=
ang <yifan1.zhang@amd.com>
Sent: Sunday, 12 June 2022 12:31
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>
Subject: [PATCH] drm/amdgpu: remove redundant enable_mes/enable_mes_kiq set=
ting

enable_mes and enable_mes_kiq are set in both device init and
MES IP init. Leave the ones in MES IP init, since it is
a more accurate way to judge from GC IP version.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 68a53528089f..2b92281dd0c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3614,14 +3614,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         if (amdgpu_mcbp)
                 DRM_INFO("MCBP is enabled\n");

-       if (adev->asic_type >=3D CHIP_NAVI10) {
-               if (amdgpu_mes || amdgpu_mes_kiq)
-                       adev->enable_mes =3D true;
-
-               if (amdgpu_mes_kiq)
-                       adev->enable_mes_kiq =3D true;
-       }
-
         /*
          * Reset domain needs to be present early, before XGMI hive discov=
ered
          * (if any) and intitialized to use reset sem and in_gpu reset fla=
g
--
2.35.1


--_000_MW3PR12MB44583B29E6733DE47EC41B71EFAA9MW3PR12MB4458namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by:&nbsp;Jack Xiao &lt;Jack.Xiao@amd.com&gt;<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jack</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yifan Zhang &lt;yifan1.zhang@=
amd.com&gt;<br>
<b>Sent:</b> Sunday, 12 June 2022 12:31<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: remove redundant enable_mes/enable_mes_=
kiq setting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">enable_mes and enable_mes_kiq are set in both devi=
ce init and<br>
MES IP init. Leave the ones in MES IP init, since it is<br>
a more accurate way to judge from GC IP version.<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 --------<br>
&nbsp;1 file changed, 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 68a53528089f..2b92281dd0c1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3614,14 +3614,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_mcbp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;MCBP is enabled\n&quot;);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_N=
AVI10) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_mes || amdgpu_mes_kiq)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;enable_=
mes =3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_mes_kiq)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;enable_=
mes_kiq =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Reset domain needs=
 to be present early, before XGMI hive discovered<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (if any) and intit=
ialized to use reset sem and in_gpu reset flag<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB44583B29E6733DE47EC41B71EFAA9MW3PR12MB4458namp_--
