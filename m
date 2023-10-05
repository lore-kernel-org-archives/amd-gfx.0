Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C27CE936F9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 04:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C27610E3D0;
	Thu,  5 Oct 2023 04:25:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E1610E3D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 04:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY2YcIj+7vBmLWODB6RD46gxS/xtyGnwInUZxBM/GWplK/Tf80ht8KskwRoN+9QEVXg+7C8/G0PWcEJxOPlUkImB76Ve0cjejxt/8j6c5sdDd+MONsDVWumaeqzA11DZNAXDOm0aj9orJ89D76mZIKH8azaen3zJ+DWiFhe6mEwY9RcuKL958Cya8Qg0EeeUhHXeElAmFlUAds1DOUN3lbbWIo3HiHT2L97vsvzJfdGwEGoiMCsTR6PdcYgsHjWXxJOCO97dNJDGMbpOEa7hOPSlVtC19zR1MFtEzYnXOeJj0fXpe+RtNf8qPMRTApTIuiMI5tkgYj+PEc4qrO5ADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyrCydSE30DqUsBH7gZmirudcYch5lcH6v5DvScoQJg=;
 b=KUTgqzZJ9gxRUl1cHaShMShwo84V4Z9uJPA3OByYr+5bhzlipnTApAAUS2sL2GtHwdPlCJwYWbq/Opqmy+itf7yfbJPpCSVCfVTF+YlE5gusHukTyWLCmAjKdqMFGibVeSHiFNTo6f4esUXVSKRvD83uBECgf1Zr4D22OGA/PbheMqb/AKPN4YhQKSpwc2wdNfxzM1Ny6if8lhya/Uvr8SEUyajsYgCgKAPB3dYDAgEHWqleN6TPF02DwS2yn+2za7EVNJLaRc87erpV1uPTpikLV15ZtJCWreQ+zZyU7sKu3HidYrte0g789r7EjrnQe4hTUnA/Ub9IdZqDq0Makw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyrCydSE30DqUsBH7gZmirudcYch5lcH6v5DvScoQJg=;
 b=LJNJriB0Hw/zgxlhR8nukGIWP2hoeHxA+8vuJjWIzyJhr60llB99weQv9pWjiZdxcVjcEoa5dTyktNg9YNtm/7fQpHO4X2y6jduq3SiDeOiojGQPsGsP3yl2VEvERD3Nrhxz0RkX1feEqmdV9079amLr7wfI78s3yWymD55xDbY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 04:25:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 04:25:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/5] drm/amdgpu: Move package type enum to amdgpu_smuio
Thread-Topic: [PATCH v2 1/5] drm/amdgpu: Move package type enum to amdgpu_smuio
Thread-Index: AQHZ9pX8m/mEKYHv3UeyiD1xS5e8LrA6msOl
Date: Thu, 5 Oct 2023 04:25:43 +0000
Message-ID: <BL1PR12MB51440006FDA7DD3ACDF1B4BCF7CAA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231004073941.1489693-1-lijo.lazar@amd.com>
In-Reply-To: <20231004073941.1489693-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-05T04:25:42.922Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL1PR12MB5804:EE_
x-ms-office365-filtering-correlation-id: 5f1a76de-07ff-46a4-288a-08dbc55b23cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AUT2Hn0lBlNxkkhJJaStw43lSVeQ+n/CNWqrYlEwsQnUfT3Dig4ZkiXdWqEZRraxfml1lVlHER7uoGHrllzMLpvYlHwFhhBaZBWx/KEu+b1ZyLpkY2VwAkdsFgdHWneBFlVg7jwhrCqmPH2JX88pDwElcOSBb4saAAQm/2Lfnpv0fTqCV2Ru9QGIX/63yNHLuKG5+LVoWUMiCrsP+ZfZJEA1MX/tDGFKYnTkgSlfPxv1WJLiJK7dqVaTP/Aqol+s7KqEOlSV2I6Q2aPNMhmtShhqCEVZCywGsYdeqcHcW35tXyO4YmibiW6nig1Bm4yTspgDQcwI0qygwSCt23AC5hVVHVpuji5PfOZfmpG5nu+iIYP6nr+uuTYAcY/6EKQvw2Nv0ELxrWHj/Ro6IhONp/AoPLS2m8j+omvzqI8wXmQRXM00Hwg7uDgWp48v1rGnt0mGe1pffIZ7ydDgqXd/UIUhFoPSqFNIR8sxkxGs+zYSQEGoeUxAvw+jRBH3dZDWaA5H2ihefFZ5rBQ1I7meAut5r1r7sh0r3s+VXcUG/ND+7bGZiYMQ8LJ9MlzHFMbUIxguiVmuScSmdJtm9q7HpMqNh1by3ZjRnEYhVduyiGz9bARlBxSoMwrBfDOi8DDk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6506007)(7696005)(53546011)(41300700001)(71200400001)(26005)(19627405001)(478600001)(9686003)(122000001)(83380400001)(66476007)(64756008)(66556008)(66946007)(76116006)(66446008)(110136005)(38070700005)(38100700002)(316002)(86362001)(8936002)(52536014)(5660300002)(4326008)(8676002)(33656002)(55016003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7VNRKmAIEmBHr1+OrSGN6s+aVYWTyxxOS9PnMQKoDhPAVRnBB2FhUZWB2f6O?=
 =?us-ascii?Q?o+qktNyHxBuG+nSO8Y0ZweT2yPuhpJjf7OT3f/foKfUiSfErV78JHk2pKSgt?=
 =?us-ascii?Q?UwImW3WiiCpdeh0HPQ7ek/8oOlZYPeCsUk0s8dJs2WmjuFt9sU7Mv2oaxj7/?=
 =?us-ascii?Q?arBZiDhr3wOtHTKeir2X8JCmtv8Un+g/w6LGE5fk4R9PVSg3aabomnLfs6kq?=
 =?us-ascii?Q?0WtfD/rYblhx4HdWyRpEfOThStbL/pDy/Pmzh0QV2gXtoNcOpI16/S5B93s0?=
 =?us-ascii?Q?I1pH7WyojKe+Lx3n83tQu3aa7c5qonUJipMbPJSWTfUDY5XQo5MBI7Ha7GyF?=
 =?us-ascii?Q?Z2x9/ntZjmaDT1dckSalvsrt+hNEkZz6SXIDXuOqA/K3EvbHwYY9p8JeIKMH?=
 =?us-ascii?Q?+TQ+efUjIZnk+y14l2as747bj3dU1I+Zt20Xjw00fEyvIUhcjZqhNrAbdsTT?=
 =?us-ascii?Q?BT0vGJRYM3C+PcvQ2lOkJw9iI9AMdRZlGn6GiaGy7h6U2HJ4dIgAP+SXTxIv?=
 =?us-ascii?Q?batssWqLojCilbhIeIBB6SWVm+ddnRTwJ7wEyMJVFPECPvcsJS76VCLWN3bN?=
 =?us-ascii?Q?8scpTq7UvcxLVj1BXsnDQX0sENyIh2ccT5/I+jRc1nsF9sxo/Q2TPOt9Lu+a?=
 =?us-ascii?Q?z5TaZ5TY9TWPry5YnkoyJ4ipSgKBGCM2/ZlxtD1t1LgEGYUTZlFSTRh7orCq?=
 =?us-ascii?Q?u3v203WcA+exDAX1FNntvqrCtIINav4uzrlTjrP6uIyBlzWXvKjnx8O0Jbi9?=
 =?us-ascii?Q?uWSy5/mvTFLRPv35ijVj/788TMvb6Im5/E/tlaojoNzMMnnwbJw2ouyHq/Av?=
 =?us-ascii?Q?oYOQp5Qs17+c1QqnmkwGqEYjf9BoOWBEdcG6usulwlp6ItOYhOa8Gb4qhnwU?=
 =?us-ascii?Q?SAbIEbsxwX0QOMBB5p/XQKePCAqD7lcXiidfj//r7/D5BUvFouMYVqrUivxN?=
 =?us-ascii?Q?ouQRwKY3b4hrQRjjiV/4Y5E/sBhoilhCC8BWdFWZX0sDVMQz6y3eNPYaSFJA?=
 =?us-ascii?Q?vS94ZYCc+1HAXlke/gttl3tv0PZQbCCfA4PNJ87ihUr7ETpiW0PIElj+onDZ?=
 =?us-ascii?Q?AVkxfFze0lgkkeaQ9tEmdNABK+VrHb7X7wwxX/+fMrW+2TH+FEVwHuU/khkE?=
 =?us-ascii?Q?a0G7ID6YWq3MHVNmgtRw0AxQfYM/Yv6dDWM6GGEJrZF9V2S/XNYycK8UakWH?=
 =?us-ascii?Q?AupPq8nuVa/CYvL1Pc+91a4FzAVylgrVFaTpZ5oTXVVHNVWYjvRzf3mA0iHZ?=
 =?us-ascii?Q?Hkm5bdKlV4reOIrIrKqROdAPy4S8y5j8RaweHkfUnkX6CAQpMBwwts53kk1i?=
 =?us-ascii?Q?Oe2lFa9Dze9DPFwMJIOdOHDGrU0kWJcp5Qip0q1excJpYwczYQ/1/e7PUT3e?=
 =?us-ascii?Q?Pc9040b3UnD4xyP/VUo6ixECW6wKSwuLph6q1k8xMWRc2nnvMqVCMcvtk4qa?=
 =?us-ascii?Q?N+Q14ZUaZ1O8j/X7totgkHTHDW4OHkUswVk5GyKKPsdFPe8H0mIEPYel5sBD?=
 =?us-ascii?Q?970nklABWfnme2sfp4QSvfYMejZhax7dq3vC4qVmUQ3G5WNNVvEod4qWip+D?=
 =?us-ascii?Q?t7l1B7mBv4ocIQFe6e0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440006FDA7DD3ACDF1B4BCF7CAABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1a76de-07ff-46a4-288a-08dbc55b23cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 04:25:43.6246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sH7cv0+qX3P0BMmMUWMMCFlc506BR3WsLSG+5smY9//g37Q4bdkt9Kvm3uNP+LDeux2rAKLwp/YNRfU0E5XBPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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

--_000_BL1PR12MB51440006FDA7DD3ACDF1B4BCF7CAABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, October 4, 2023 3:39 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu: Move package type enum to amdgpu_smuio

Move definition of package type to amdgpu_smuio header and add new
package types for CEM and OAM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2: Move definition to amdgpu_smuio.h instead of amdgpu.h (Christian/Hawkin=
g)

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h | 7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index 42ac6d1bf9ca..7088c5015675 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {

 #define NUM_XCC(x) hweight16(x)

-enum amdgpu_pkg_type {
-       AMDGPU_PKG_TYPE_APU =3D 2,
-       AMDGPU_PKG_TYPE_UNKNOWN,
-};
-
 enum amdgpu_gfx_ras_mem_id_type {
         AMDGPU_GFX_CP_MEM =3D 0,
         AMDGPU_GFX_GCEA_MEM,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_smuio.h
index 89c38d864471..5910d50ac74d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -23,6 +23,13 @@
 #ifndef __AMDGPU_SMUIO_H__
 #define __AMDGPU_SMUIO_H__

+enum amdgpu_pkg_type {
+       AMDGPU_PKG_TYPE_APU =3D 2,
+       AMDGPU_PKG_TYPE_CEM =3D 3,
+       AMDGPU_PKG_TYPE_OAM =3D 4,
+       AMDGPU_PKG_TYPE_UNKNOWN,
+};
+
 struct amdgpu_smuio_funcs {
         u32 (*get_rom_index_offset)(struct amdgpu_device *adev);
         u32 (*get_rom_data_offset)(struct amdgpu_device *adev);
--
2.25.1


--_000_BL1PR12MB51440006FDA7DD3ACDF1B4BCF7CAABL1PR12MB5144namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Series is:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 4, 2023 3:39 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 1/5] drm/amdgpu: Move package type enum to amdgpu=
_smuio</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Move definition of package type to amdgpu_smuio he=
ader and add new<br>
package types for CEM and OAM.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
<br>
v2: Move definition to amdgpu_smuio.h instead of amdgpu.h (Christian/Hawkin=
g) <br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h&nbsp;&nbsp; | 5 -----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h | 7 +++++++<br>
&nbsp;2 files changed, 7 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h<br>
index 42ac6d1bf9ca..7088c5015675 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
@@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {<br>
&nbsp;<br>
&nbsp;#define NUM_XCC(x) hweight16(x)<br>
&nbsp;<br>
-enum amdgpu_pkg_type {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PKG_TYPE_APU =3D 2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PKG_TYPE_UNKNOWN,<br>
-};<br>
-<br>
&nbsp;enum amdgpu_gfx_ras_mem_id_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GFX_CP_MEM =3D 0,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GFX_GCEA_MEM,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_smuio.h<br>
index 89c38d864471..5910d50ac74d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h<br>
@@ -23,6 +23,13 @@<br>
&nbsp;#ifndef __AMDGPU_SMUIO_H__<br>
&nbsp;#define __AMDGPU_SMUIO_H__<br>
&nbsp;<br>
+enum amdgpu_pkg_type {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PKG_TYPE_APU =3D 2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PKG_TYPE_CEM =3D 3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PKG_TYPE_OAM =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PKG_TYPE_UNKNOWN,<br>
+};<br>
+<br>
&nbsp;struct amdgpu_smuio_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_rom_index_offset=
)(struct amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_rom_data_offset)=
(struct amdgpu_device *adev);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440006FDA7DD3ACDF1B4BCF7CAABL1PR12MB5144namp_--
