Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75786C25B46
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 20:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F8310E004;
	Mon, 23 Oct 2023 20:07:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D94F10E004
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 20:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYzsUCQep+n4nIjaxmLeJDSbw8xef4+Jdr61pzRKQIFlOSrdOc6bT6eL04UvMPB30uzQTr5Wor8osk1ITHhREnYTNQCWQMGGmOPU80veivqqXLKPnkEqGTYQp6daxCQgTQOcLC1OGAm4Bysc0vU5it3X7Z42CrG+aR9opbbtGg5QrUelMuENvos1kYuwEfAqwoIt4c5EgKwlIRymdvDicaCPYymAXVKYSqe2CK8IAI9Tqy13gSaZEP7yVL9Da37lxbWvCuUbhIvNKdGpQt3jk/aejuDsGHI2SQaAC1KKHIXVwFFtxPk9QGJiKYFE4TKlvNvlrBVzO+4RgefNUmPRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyhaLaN1eUT3/is2E39y73hlYHfQpdCiRV5+MakAjrM=;
 b=jmSVEpfu6hkQjkbSPP/AKsCSnXxUR4jalyaUWa7IsdWUCTsjgpPe+n7UTN5CbdPXDiMKs4pOekLtAtj0Nzf+M1ZHbf9OuNX4ZhJxGWD6f3sekD1V9qCbwSDqZ3JVbe+e+dkC4g7+EIbBwlsGEBX2eKkKCeL0Mv7NHI43fITIIdPpdqfR+ecTQEC2W6wAbU+Ldx3F3lRxR7bt8Wd68se6i+5usBS9BKxAvGVRyhXXNPrQ//tpJSm2rp8Vw3HPnIRg/9pSgQlGU/2U7CZWuwo2UNp6gl1HbSXtqu7+AcaqX5MTm177bBhgJ7JhmKfMYBD0ed4dEGXEyCpetuLQ9zWrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhaLaN1eUT3/is2E39y73hlYHfQpdCiRV5+MakAjrM=;
 b=r+9uQIH7ypnZ/mz0ANXeJb4O7MEJxC3tFn9Lt32nko04M4+0tIOWuFxb25Vn04LTZOxbPLl87M/H2GF3o1yvZpEj5Mz61/MKe8dPjLGQFl9MLtKj1Wv/3rYspeN3qMulx2RPHeXz5DrlCsawnZs4sNLhL1UKWtKqNTJWmdGQisU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 20:07:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 20:07:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdxcp: fix amdxcp unloads incompletely
Thread-Topic: [PATCH] drm/amdxcp: fix amdxcp unloads incompletely
Thread-Index: AQHZ4ZlgpCTnsLb2a0O61nK2uF1hmLBYFaX9
Date: Mon, 23 Oct 2023 20:07:10 +0000
Message-ID: <BL1PR12MB51447085D8C6B60C41C276D9F7D8A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230907144100.81325-1-James.Zhu@amd.com>
In-Reply-To: <20230907144100.81325-1-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-23T20:07:09.820Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB6583:EE_
x-ms-office365-filtering-correlation-id: 2bdd099d-f568-4d85-c10b-08dbd403a412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NWeGufPiW5qmYkcBtteTdrBi+Xc7Ybu9/LvWC1dnntf47GGH9bZLsXF1HtJG0eArq1QbAgwSfEeiKPywk8hCmoJeac77BEa8sPukkEPmFUtborxvzFT0U05Zx7pj1oDvBN1ZMll33KXnUmUgkWxd59yzkMdGP+hiC9h1ojPsAiCWCYhQLal3QCdLg3HZfy73zuZDTiDfmd/0YWkNXGxBTZ7WrX4XtK7jbnnV2ubl4Gtc4JNxO678TFZ9Pryf9id8MA3h5bWxcfCwZ5QuoyDdOmvOxoqpQDyyk3z+lf6uXrTFQOqLGSFJGndzn23/tRgCe0p4PU6wK3CkEGxqxojawe9JL2FxOSpef7AO4GbsW1Ci/ePDdjfQAVeqBjhIPt3dcyUhYG3ORXV1K/IqLZCUduAdefDQPuVVY4hNMXdoNn271ZDtmixOElyjNdaYF8EwP+i0f8bdXhTbcgTXz+Wy6NYw/ZbPId/RUmEFysg61aY/F6Pcao27fxM5n7J6gkoVPSQZZayV5U3DfiOQ9Teq6WCni7wyTqS1y+i3rIQbyQMirdK5nWQLjRA2DGJVefAAPZLfRSopKB1Z1D4Oxjgt1cKuRFEOy17/QgYXh4Vei49cy5884WDTX3AalR9nnnlb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(2906002)(38100700002)(54906003)(64756008)(76116006)(66446008)(316002)(66946007)(122000001)(66476007)(66556008)(71200400001)(110136005)(6506007)(478600001)(7696005)(53546011)(9686003)(83380400001)(52536014)(5660300002)(41300700001)(86362001)(4326008)(33656002)(8936002)(8676002)(26005)(38070700009)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QSH59jcdIj9uBfn0vLEWI9IEDX+GRj4+joPlcz/yXS5Wyn41CIs+cN03tO9B?=
 =?us-ascii?Q?pP2+CdzLH7P8iL2+ZTHDktx36MOxlH4TKKYe/xZNgds/ll3NW48MzFqV/2C3?=
 =?us-ascii?Q?734fnYyPUBlNrWZWtFdJc9oUMuEJOslYVNN2+TyQuGB2Q6vHWVhpKx+P7ZkA?=
 =?us-ascii?Q?LnRj098j9JfWHy89Hv+INYsOZfC9m1vxRP9SJsjUBhTjHg5A+kwx9bGLtMSG?=
 =?us-ascii?Q?Q3vrIRLbCSPyQjuEzKIF3zgfTrbjawSu7d0Sx1UFtlM1YfeyjvqPNsuBqHz0?=
 =?us-ascii?Q?CZDuPRtA6mMdX0EA8FqmX+YNFVViGNd1EtHfMlbbckkbbxUwH1/X4RUR8nSe?=
 =?us-ascii?Q?fspoYZ4Qsga6jLmvKSfMtBTrDghnHfkrEvo7qmEcIr2BlTWQjkw3wx6SOurg?=
 =?us-ascii?Q?sUyQp4ST+NCZZessqT/A5VUhvLF2+wZz9KFtirR42TvkFJUjY97s3Xetp9B3?=
 =?us-ascii?Q?n1yoPFJaycu+/iqZpeVqB+TBxVEuasI8GoNNCDdG9O9XjHyc3DxXnvRqSUpo?=
 =?us-ascii?Q?ILo8eNbllaYffOPn8NviyAIZ2/lVSe/3ddIZWw88rQyW6fXwwWz8K0a9Afcl?=
 =?us-ascii?Q?bYJqOCqh9G1uCJkkST/oFy9e/pEpUyt2nJS17YJ7TlBDMgFvlcCsZzxYLPLj?=
 =?us-ascii?Q?6DBaZ/rPtEe9rabtmtoNr5imJes5OuPT3BgP+VOB+1TSFrgVQxd2VVSQecZh?=
 =?us-ascii?Q?+rp4G03QUC067pfg6bpk4F36p0X+xigL/lotJf2XvRSiMVwQbcUqzGPUuNgH?=
 =?us-ascii?Q?VIkE51oRAXPXyZmlFMY1DhcDD7SSFpZQgYJEyfRIyqXZYBrHMJjDV5ljihFD?=
 =?us-ascii?Q?CyHIAWCWLPydF/nEcsazYF8+Qj18SBw4/gZiZ25QTpYAaIGK8UckikDECjqh?=
 =?us-ascii?Q?UO7vT1GMG1ZkvCY/V3xafZy8mVTToQ9rjBTqG3vOrgN8n4bjVbIkLBxlsj2i?=
 =?us-ascii?Q?zoEVjDHGn9mU72KBJLQatbjqjXJFSfkMAGRk/1tdxHMsjERqAMQCH1XPMz++?=
 =?us-ascii?Q?jvZbcIP/EUsgydg0CFmZ4YpkRF0QzGguoYyfPBB9IU0LpT65ItDNVhxLEruj?=
 =?us-ascii?Q?YN5bUkbjyGYRmD6l2Utf632PGKsTsA1kXCVgI3i28YthIMVg0ZGupRWP+ET2?=
 =?us-ascii?Q?UVboYn3O7jP4mbpNUqUY96vEJ+pys5dIUhQCKtjcBBXiSensx6+kv/BgSJuc?=
 =?us-ascii?Q?JGuh502T6qvvIL9JxJy95dZ/wHuT5LUdELbQuyzClxHzGt0k7OsvxAEIsoyS?=
 =?us-ascii?Q?tqGuxXQMeC4XTXpp1WxH3sRnUeHS7ryd3kZbcTEXR+z/LaqgItUbu+Fp5s5k?=
 =?us-ascii?Q?nlzpAjs9A07ggGYoC9BOQp3MB+EOKH+YhyrKNScfDILGYZcjMYy0dTXUsX1Y?=
 =?us-ascii?Q?NolANpctVDPlihOk/0Gv6kbWts5Ama7daIvBZLTaedUkAsZPnALfoD9WmCkz?=
 =?us-ascii?Q?8tjL4E8w2ZHriRPRCvi7f2t+nq6ST1vL3hhCB9MKvWMxyAw262NYS96h2v/n?=
 =?us-ascii?Q?gL9ktkeDoIprJXr899vWO39i6IrSkRKTRpxOvBI95vCQ2t0GX19vniYoVKtu?=
 =?us-ascii?Q?pdA8/O9Ak/cnK+3FRo4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51447085D8C6B60C41C276D9F7D8ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdd099d-f568-4d85-c10b-08dbd403a412
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 20:07:10.5518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2EyaZyQ6ogoZHkCTh88iRNzE/1OfN8QS3PPoCDkjgjXgB7RiDDMm6YJEq2XUCbZNe6/zzT2GEVzp2vtucLuJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51447085D8C6B60C41C276D9F7D8ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of James Zh=
u <James.Zhu@amd.com>
Sent: Thursday, September 7, 2023 10:41 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lin, Amber <Amber.Lin@amd.com>; Zhu, James <James.Zhu@amd.com>; Kamal, =
Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdxcp: fix amdxcp unloads incompletely

amdxcp unloads incompletely, and below error will be seen during load/unloa=
d,
sysfs: cannot create duplicate filename '/devices/platform/amdgpu_xcp.0'

devres_release_group will free xcp device at first, platform device will be
unregistered later in platform_device_unregister.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/=
amd/amdxcp/amdgpu_xcp_drv.c
index 353597fc908d..90ddd8371176 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -89,9 +89,10 @@ EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
 void amdgpu_xcp_drv_release(void)
 {
         for (--pdev_num; pdev_num >=3D 0; --pdev_num) {
-               devres_release_group(&xcp_dev[pdev_num]->pdev->dev, NULL);
-               platform_device_unregister(xcp_dev[pdev_num]->pdev);
-               xcp_dev[pdev_num]->pdev =3D NULL;
+               struct platform_device *pdev =3D xcp_dev[pdev_num]->pdev;
+
+               devres_release_group(&pdev->dev, NULL);
+               platform_device_unregister(pdev);
                 xcp_dev[pdev_num] =3D NULL;
         }
         pdev_num =3D 0;
--
2.34.1


--_000_BL1PR12MB51447085D8C6B60C41C276D9F7D8ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of James Zhu &lt;James.Zhu@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, September 7, 2023 10:41 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lin, Amber &lt;Amber.Lin@amd.com&gt;; Zhu, James &lt;James.Zhu@a=
md.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdxcp: fix amdxcp unloads incompletely</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">amdxcp unloads incompletely, and below error will =
be seen during load/unload,<br>
sysfs: cannot create duplicate filename '/devices/platform/amdgpu_xcp.0'<br=
>
<br>
devres_release_group will free xcp device at first, platform device will be=
<br>
unregistered later in platform_device_unregister.<br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 7 ++++---<br>
&nbsp;1 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/=
amd/amdxcp/amdgpu_xcp_drv.c<br>
index 353597fc908d..90ddd8371176 100644<br>
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br>
@@ -89,9 +89,10 @@ EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);<br>
&nbsp;void amdgpu_xcp_drv_release(void)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (--pdev_num; pdev_num =
&gt;=3D 0; --pdev_num) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; devres_release_group(&amp;xcp_dev[pdev_num]-&gt;pdev-&gt;dev, NU=
LL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; platform_device_unregister(xcp_dev[pdev_num]-&gt;pdev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; xcp_dev[pdev_num]-&gt;pdev =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct platform_device *pdev =3D xcp_dev[pdev_num]-&gt;pdev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; devres_release_group(&amp;pdev-&gt;dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; platform_device_unregister(pdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xcp_dev[pdev_num] =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdev_num =3D 0;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51447085D8C6B60C41C276D9F7D8ABL1PR12MB5144namp_--
