Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77285C636D6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 18:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1AD10E28B;
	Mon, 20 Feb 2023 18:17:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D52B10E28B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 18:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyeAizdJ6NdePuh8CuUZpVgnSybBSFCRMFAiiOX7MJun1E1cFfpxGbIOQ3ymulGNY/LdYXm42O6bpuU3gFD+WQyQ/E6Sm3Xxbq1YIEAjdwwKJ1RD+QLp3vKWrd8KRIhnQsiJ0ADIkV4WruFzH9Ox0j4k4kkY+Ms6zTnHwNr6SQyntYVts5e4sHfw6P3W5D0R9ZwXtJB6NmuuDSfuNx1vwOVTP/r+TOc/YdO8nxXcQIlrFNpmfGOcA00HC50kdlhXQCHZSf4LqRdLqhOEXwDMGuptw870zsT964EpsDihb1oQSTDveyqOnFpiby1LQzbUZOURrYZiakqVgDBB5Y6PeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pQRfa6m8K6eBjEwKB1tQ8s0Rrli4MmDHgXJnM9ON24=;
 b=hUqxFoMaVQlVNeI673ajd7YE6VOakZwPmP+NKoWnNYfhTg2hojVTmrWiNkOlCHswmVDMHJIyWDnUlPbeK5hBAC8SjAu9rv2ZqtfTpNMKmx5EVi0WRiMn74AsR+P70PtQzOvrq2Fah6JBbxDsBDDaK/7hchisY0XXtsvPJSPIWPuHxNisQ7JsycCLNXiTq022mbPmlKGp7lSsAnygVPRCtggxFqab3ABJKkD1ieeMWNQ1LEaBlZJdQL4I7Pmq8yDwcz25xuOfyNIXaMUW1UH8nuz4pzMFKB5FbGEg5NAcVkJMZN9XPhIGuIkUPS14fS8xc0svH1F5PFe8P6yZGOH1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pQRfa6m8K6eBjEwKB1tQ8s0Rrli4MmDHgXJnM9ON24=;
 b=2oKslYWy2fCMOJetvtVszruSaqedUfIwlXzMFJZNRx/ZKFpCvncw1667vmaFSJEMFoEnX5gbosEVx4APxYoknoRlRBLvMYa56EkGkOro2wpD/oZupWz1elwAMTTUdyy0O1OpXcd51gPXljGtJbAdJh9/mP2igWGXIb3qUV3Pa/0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 18:17:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41%5]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 18:17:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd: Fix initialization for nbio 7.5.1
Thread-Topic: [PATCH] drm/amd: Fix initialization for nbio 7.5.1
Thread-Index: AQHZRVbAgXlZu86PL0+w2q7RXI7/2q7YJBV+
Date: Mon, 20 Feb 2023 18:17:37 +0000
Message-ID: <BL1PR12MB5144C7CC74E287ED5ED4B475F7A49@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230220181057.24162-1-mario.limonciello@amd.com>
In-Reply-To: <20230220181057.24162-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-20T18:17:36.466Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BN9PR12MB5324:EE_
x-ms-office365-filtering-correlation-id: f3580b6d-28b2-404a-6eda-08db136ebedd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /tm+0ynSlDH1+4cORZ6YGMx+sBwhezOfnS3j0rwHHB3KnuSStsmiZZwmAoplA9LouYwK7EvWbFT8iCHfqkUvLJLLA+QF3CInRHdJ5dXAoz8H0hQnbG8lPGjVh9G5vS/Vkie4OWXETMtYxUj1Yxyb+ibuQwuo72SGMMmuzJeidOsLB4B65tO+hjdHr1s4znn24WGqYm7lats+kdA9UZnLI68AzVndECbrFV0K2KL/YcI+46kAVjSSlDiE0BalPcfLTEuDyB88M/Gg9L9gFsI6UCvysrz4TfhKpR+xKSTLYDD918ov5AFz1tcSBymJvvuWya18MkqBxQWVwvESfV2ov1e3oOwm0DjXAnvRW6f3HFXw0U7TFChJ1mMtN7hGvjvywjxtE5pDkWvtJ+31e/E0iL2ullb6DkcbvJNBWMWeJOpEkwgQQ1mO0eBHkHwpXuqPc0CvwZy5Yq6QlyZnIbWeKGmmLlZTKC+D+zLeemRMaQxN3oLRGMFg9BKSsdezFIEkkxwIUvC+rU+hbCkNH7cQR+DO5E6llmtQuvtdJd5GQSAmWw3yLYyHqgi+7by0oieNC2kCmASQUls627aMkKTfJPYzg53IKnwCIv0uVdJekxFEskqxhf3UyJFjAbBo28wO1m9AOXqweRRH3/A0YZmDUc50h9mP9Q0dpfQ6z6ZymCR96BBruGtyLkD78PzUGp3C2FLhj+kAAgR0OPHtSiRVkA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199018)(19627405001)(122000001)(2906002)(86362001)(38100700002)(71200400001)(7696005)(26005)(53546011)(478600001)(186003)(9686003)(55016003)(6506007)(38070700005)(33656002)(76116006)(91956017)(66446008)(64756008)(66476007)(66556008)(8936002)(316002)(110136005)(66946007)(41300700001)(8676002)(4326008)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uesDeDfazsCD8Rc3aRLI9XG+w/Z6+Fq+NopzmeSejmT2nADDwg1bH7t7jnfj?=
 =?us-ascii?Q?0D2mYf2SsFzQ90+kmttMPpwKhh6Zwqe0E3TMj7SdSyEaBWNWt9iuH7JG9HVf?=
 =?us-ascii?Q?HmztQK7nXp+lEc4ZxSDnEc1mf27Z7egGoHH19h3v2Pe91jww8/6UDBkkR46C?=
 =?us-ascii?Q?b1hny08QoFm+IV+AmjJspF9q6LjOwFaj459o8Na72suokupEsxg0COIyaQon?=
 =?us-ascii?Q?VId2IShmG/Ee3vb9xdx7b+4CXO0OqdMfmLsHqUVatK5ifkZHAvD6GTte7h1W?=
 =?us-ascii?Q?PbSe3OzBSdycpOad4+cHAr6lzNNoG2edgMWtRmDX9q8Py9DoHQFtySSCc0Gg?=
 =?us-ascii?Q?K62BR4SP/MyTpoUzC/FPwcoKP2fz8ozFAW24/TyGUrMbrA81We3bOvbj5jkJ?=
 =?us-ascii?Q?x4m2l+MPc++5GvIr66u9ZU/Bk3TlosenQpbDBvR6IEy8gpZEcjZNpWRHAagU?=
 =?us-ascii?Q?dBwgO6wpfeZR3BbaXEmkvZptNZOQRasyGJ2D5MN5/AxL7bWlI5eoiGXvDLJ5?=
 =?us-ascii?Q?XpxoWVDVgP4YXsTJONy2zOKGodgVNKhn0mZBFG1w5Ww8YABiUguicOgHnEQ2?=
 =?us-ascii?Q?g9Tt02t39QDymT+o0prq4aVHnEvm/rMpnW1SeL7POVsv77VUrPthR3ucyIU6?=
 =?us-ascii?Q?EOr+5jBS94Yt/6v+uJrUXcYVqyNtlK5o3YxZ9Fr6U6n6+gINxr0JOhtZGHY2?=
 =?us-ascii?Q?oUlXFNSLsxFolOqotvTygZRxdFJTE0BHZrsvMV3Ju69Q8GO7bntG4zeAPQGH?=
 =?us-ascii?Q?lh+Zs+6NOgokClVDVD1gB37Bv5stc2pCpEDwkY7Z3jKA5IvhD+sVkpEaeiQV?=
 =?us-ascii?Q?yTwfvMpXe6+jbQcoj1NhUnoGuoUyBSkmVn97RwF8Pxe9YZrhTLKWDk4G2Jdp?=
 =?us-ascii?Q?rGPrEtzyDCe1bWXxgLViEO2TFcKtlJ1ubksLVQRD86rYSF48TCdjmP5NBrMJ?=
 =?us-ascii?Q?HgLXTLL8C5O2zHzXuLO8YBFAZ0mcXK/gLvcrhorArblfSzB5Zb4W3hFj0xoj?=
 =?us-ascii?Q?lhaFa/bCShr9a7x18382DIcGhSXI8kmtVinsK8mrmtY/lCgVlQd24f7ko8qD?=
 =?us-ascii?Q?+bf1JcgXZ0fC5dSITeFnAZujlZAd2GUQgmph2MiyKT8HBeUIz5O1YGGqlAl2?=
 =?us-ascii?Q?zI2+zdANOOGnAEwYu3QxyqeaLtUfCujtV+pA930DV+hlxNX1S4GKlnUO1aD1?=
 =?us-ascii?Q?Y89x4KlvEqp1Ps/L95QLzmwxJGWmyEP14BJ2Lna62OGh7rEroWMBMjcNzlz2?=
 =?us-ascii?Q?1WTenrHnvW6IAJBiAbNCFYyfQjY6j0SffnEpjml6pqNdLD+tZDjtU3J2rTHK?=
 =?us-ascii?Q?uOlacDULOhch+u5Oj7qhsdLLK8J6qypVIbB/ODkIt0RNiw9J2qARLuxs5xlO?=
 =?us-ascii?Q?wH1vbaTpQ69CtlPkpVDVCwk2GN5lB44X9Mqa6e/tEAdlBpo0jnvjUDxi9MI2?=
 =?us-ascii?Q?wyK7OnviMCPyOq3mlEHkOGXvc59k2XXSvfav829t0AsWqQZeZib9gP/+QSxp?=
 =?us-ascii?Q?Nsp/WY7OMuOS1rmTLe9h4HtdFiPqJlxzYQ4DFDSePyXLeSQw9jGsOwvi2tyI?=
 =?us-ascii?Q?cHyKwJQ+pKYHCTvJRfs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144C7CC74E287ED5ED4B475F7A49BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3580b6d-28b2-404a-6eda-08db136ebedd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 18:17:37.1945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MbAOu0Z037hBeHCpZijNIDvv53brTLdX3e8R3DxS7kHqOss28mlOv5pzoRy485C9d55KneGhcAqNtk4J8HgMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324
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
Cc: "Gong, Richard" <Richard.Gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144C7CC74E287ED5ED4B475F7A49BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Monday, February 20, 2023 1:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gong, Richard <Richard.Gong@amd.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>
Subject: [PATCH] drm/amd: Fix initialization for nbio 7.5.1

A mistake has been made in the BIOS for some ASICs with NBIO 7.5.1
where some NBIO registers aren't properly setup.

Ensure that they're set during initialization.

Tested-by: Richard Gong <richard.gong@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_2.c
index 31776b12e4c45..4b0d563c6522c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -382,6 +382,11 @@ static void nbio_v7_2_init_registers(struct amdgpu_dev=
ice *adev)
                 if (def !=3D data)
                         WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1=
_PCIE_MST_CTRL_3), data);
                 break;
+       case IP_VERSION(7, 5, 1):
+               data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);
+               data &=3D ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F=
0_MASK;
+               WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);
+               fallthrough;
         default:
                 def =3D data =3D RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0=
, regPCIE_CONFIG_CNTL));
                 data =3D REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
--
2.25.1


--_000_BL1PR12MB5144C7CC74E287ED5ED4B475F7A49BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Monday, February 20, 2023 1:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gong, Richard &lt;Richard.Gong@amd.com&gt;; Limonciello, Mario &=
lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd: Fix initialization for nbio 7.5.1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A mistake has been made in the BIOS for some ASICs=
 with NBIO 7.5.1<br>
where some NBIO registers aren't properly setup.<br>
<br>
Ensure that they're set during initialization.<br>
<br>
Tested-by: Richard Gong &lt;richard.gong@amd.com&gt;<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 5 +++++<br>
&nbsp;1 file changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_2.c<br>
index 31776b12e4c45..4b0d563c6522c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
@@ -382,6 +382,11 @@ static void nbio_v7_2_init_registers(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3), data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 5, 1):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data &amp;=3D ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0=
_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fallthrough;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_PCIE_PORT(SOC15_REG_OFFSET(NB=
IO, 0, regPCIE_CONFIG_CNTL));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, PCIE_CONFIG_CNTL,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144C7CC74E287ED5ED4B475F7A49BL1PR12MB5144namp_--
