Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F91BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 14:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E055910E3EF;
	Tue, 15 Mar 2022 14:38:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71DA10E3EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 14:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlhRtm7DU1wMiI7f50QlYxXmdWzsXgHaUI/0kf8bgV0i1jHpfnCLz6fGosGrsWK5huZD1Fe1OAa8n1Fk2AqNqY6tMcstPKYjpWaGhG60KkyhNQuw4i8534JM8hDtw+vikfSdC8NaXmVkudvvdB44IIuMkM0MqF+UeCFm7LmQmhi/HEnE2fzdFbnZ5Fp+qJG1csL8QOpRd4rMZpNPIP4FRCqyuHsZW4nRJh3CkGJ6kIM417y/cVTMUFl0vFe1Kev2IfAizsLgxz/826kS5zNEAsnx/uB2WmdWMGcouk3C/Y02PuvI3Wfz5v6zucGZ1pwZ6if0aoG+HL7kZ28m2z9LSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw58NV1LgHBKzMOqmLCSyRJn/8z3ewcGRuSeoEhBeI0=;
 b=hJPD3PWFPBpmV6gksRGgD99WxZa7xJRTk1RQzBL4IRUfsx7A/ViTsGvYB8yRfSj7eoIvSW4ZaqXdncr7ySxsn1uYaGfASdbg5mHkyxpgevViyEI/X7rDP/bxoIg/GRtc5BqdPyT7eoKWtfTJh2Bu2ZoilgX0ORi+RfrQGx3ObciNk+DjFEi+oI0k33brsoEYb46qtEwzisu3ayA1JqQwJvd+S7JHvVQHyicZh1GEAYtRqZC0POFAsOP4sDtd84Lb+3mqc0tDEiGeW84urRKoTlxBSKB2DpmXMW4YscEV0MOEvDskLEvjYBG1LgIOcYQjtbQ+fdoEufWbcAMaHX645w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw58NV1LgHBKzMOqmLCSyRJn/8z3ewcGRuSeoEhBeI0=;
 b=nCkVaZ3amfly4oDieIZ+ou5qpfIueq5Vxzb8IqwBzvW4wBJ6ZCnxNmJYsDxZJDnJwl6pdMi4kOQrQ9V89/SASylJJHmmRjlPUn62MyU3nzZiwTjgRk9jlyEItcsuYivZGnd72HEiSR7N0gxLNe4sWGFQek3AoWVULYPuFvFqsEg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB2620.namprd12.prod.outlook.com (2603:10b6:5:42::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 14:38:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 14:38:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add stolen reserved memory for MI25
 SRIOV.
Thread-Index: AQHYOHagmXrJFUlD30OUJOyDPycGuKzAg6qu
Date: Tue, 15 Mar 2022 14:38:35 +0000
Message-ID: <BL1PR12MB5144FB9E772A14681FF6EB7FF7109@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220315141130.150367-1-yongqiang.sun@amd.com>
 <20220315141130.150367-2-yongqiang.sun@amd.com>
In-Reply-To: <20220315141130.150367-2-yongqiang.sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-15T14:38:35.078Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 33312a0a-8e5f-cf44-ae79-99a8b99922ff
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac0dbd26-37ca-410f-dab7-08da06917c9b
x-ms-traffictypediagnostic: DM6PR12MB2620:EE_
x-microsoft-antispam-prvs: <DM6PR12MB262026CFAC1AE6AD9A785B17F7109@DM6PR12MB2620.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRDt7P90mhwdYzM+fSrNxAgMt/qC+rqvtqqjNZWXMUV2p5sX3NGr5IgVRag8AZ/9DF2Qa6litky/ffC1pounh/trddEjyb6+dFfSuEJq5KG4+L20qtt5xZFY1PuLTPmO9jX2t+x3Py90foM/fSEHkTLIoPiR8AQpThi0KaOt2MNXXBopnAtwmrhHfCH4AZ7O1bty8uLq7uWnpFCqEraucJvmymNUWtakWUQwq2anfgI3NnSJ88rMNWCCWYdlL8kLPjAUs7BNJi0A28nPUhjc1DpCJiDetqrnhuiDp5x2LL5ExwfhNeDyN/atuNyMe6M3ENZZYIzyql7BIYdAOD26exu7AReQa7PImTX6QfVqJrEDhOSU0stWtD9TQsu3nqyOBk498BjzJBWaKisxjLKfGtHzFEumej5idP2pY8uKhwGWM1fw+JpI8zEyyv1mp3zee1vh4jGNnFgSnFoWXgdCihLIfG642Xe96GbPioZloWL8nB+cyA8hlt2kHimgVILCpulrEUjnB7hZYcZHH8AR3LqYmxdCbaMBsYZu7RGIrlCyVa1ztsV6qb6+lDppsFnjC0We81rWIm07nFLQfTzC9UtQH3WKa891KMUW5vDEtGoGRPbYSNNH0aPLMGwJEP8czQRJhbAqySAXVZzYcCheZ0yKQhdxLK9G0h3bFUVJo6uDlfg++aXq3onslFsWAO5elwJfLhZ9p7O2E0kCCBK6+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(66476007)(64756008)(8676002)(508600001)(66946007)(33656002)(66556008)(66446008)(76116006)(316002)(55016003)(186003)(26005)(8936002)(9686003)(2906002)(52536014)(53546011)(7696005)(6506007)(86362001)(5660300002)(38100700002)(38070700005)(110136005)(19627405001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+5PbsKBBNfGPfV7i0iNFmLSaB9DzB6ak9eBpHrOPI32/GIxnhSUnE7gt5uRN?=
 =?us-ascii?Q?Mo6zkT2gnAk67up1umjVljyRShRKwieAvWbhWvkXHI/mmUY0BegGIPjgeApX?=
 =?us-ascii?Q?NYomwIl1PSo2hD1SdocjLUB3PbOC/cq/AQee1BnA/VPNlqIPC013S00xdxAB?=
 =?us-ascii?Q?w2RTIUMd80gqL7UpxewKMVJECIvrUdNiS5bv5IgV2VFKcfDpYypF/iefPbp0?=
 =?us-ascii?Q?C7M2LA1ItzGlVtk2thE97/tAfwlzafVip6yG54cktROGlXXTcK30NBHhSNV4?=
 =?us-ascii?Q?D1oSXXE4rwbfNKUvbhdk7sZHvY9hry1uv/jFRYFfhZFVHqr5sstStXE3q34g?=
 =?us-ascii?Q?yOaVG0FQjrAQl6e851hJFaadHRNBDyDvP+tw3Qx1MPp6dlrvi0QOon5KtMez?=
 =?us-ascii?Q?sFjfezCyOcDBjgSPmMCcbCyW7XNKEichSpNGYg3nQYwmSGpm/hlAp9xJkyQm?=
 =?us-ascii?Q?7Yj+0I1NFh8du8L/FO2PG+HVfA5mP2Q88uSMVkScqwo27amtj4s34YTDIg6q?=
 =?us-ascii?Q?NdR7K10vMAgZY57UNc5hEYU+MnG8u/yo8qeb+NhClE7VRytCR1HqjryH3lH5?=
 =?us-ascii?Q?TOKH5wBJgXC3izHOEBokmtNB/czwExYehvROPTO1JHPULJwXf4jgMdcZNmpj?=
 =?us-ascii?Q?5gdeJxuofA3dBweNU+7+tWeymOB/oLgzt3yOqlo4kebOgUXjUjCHHQCmGOu1?=
 =?us-ascii?Q?Hk22KUp8XvijLKq8x2k/LcoRVcZdCze5WtTneaONPdI56BwxeSECIqTJB8Ej?=
 =?us-ascii?Q?ANd/Apfq7tgCpXxjGRcK61l6gJOmgf0pdZD6oDZMcEG++sIAUnUn0l9yoG+U?=
 =?us-ascii?Q?Muw9hmff93clm7+4Bn46GtABYKso70Ub3gICf/c5Vgze2BZXIw4Td7vaR0gt?=
 =?us-ascii?Q?x2QsbmuxqQ8mWyBpyNrBOjUP15ux2x5lP6zu63i5TwC7hJ71h/wpadw/OhYq?=
 =?us-ascii?Q?Ctez8tmXrJeohi8gH75WInY00wjiLwbHHsfZgpU2L8xcI2FJgZGw0RBDpqK+?=
 =?us-ascii?Q?d4nfHquQucbPxcAwKl4fm6qgogZzcgFKAoFGAFiFRYQrnt3257Db8DkpLujf?=
 =?us-ascii?Q?fKiC/mMZNFk4hunJ7rxjTHZuPfULW4hRNC8HMdmW4L+23VBSGTznIaFsPF/h?=
 =?us-ascii?Q?jn1Q2F77kd9wxV62vyVsT2OV+bPe9uUEe0O2buCyzBpusR2+G03jvojzTnDD?=
 =?us-ascii?Q?3kBNY48gioldm99jO5Yqq0jEzgjdr4iW6493TFsJ90udeBlAxH+lDyKIpx9a?=
 =?us-ascii?Q?wBdx0vwpfg89m8SiK+JM3e4H0uBdZNiTQhnIVG7tqrZ4Fsyzl+vjcWC7F3qS?=
 =?us-ascii?Q?2qU6of4aIwFxkhQ6ZqgFVrtKo1X9+J93oAeMcGHlNoScrHBaOf4IvdEEZC0R?=
 =?us-ascii?Q?4dJ4AFIBOlTZTmNPV0itv/Ag49mpWcGHj+ARh02XmEGaBvwjDGaawwfYbeOl?=
 =?us-ascii?Q?UcCAtdvkX7dMJ7NO3W71ge66U2LC/uom?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144FB9E772A14681FF6EB7FF7109BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0dbd26-37ca-410f-dab7-08da06917c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 14:38:35.5085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owHh2F9DTXPa9R8K3DC7zOl37uixENsiEaSZBqvs9tekIHRW8Mw6VvKRC47roqfz0eRd6ZW27ORz7VvyWjeQfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
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

--_000_BL1PR12MB5144FB9E772A14681FF6EB7FF7109BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Sun, Yongqiang <Yongqiang.Sun@amd.com>
Sent: Tuesday, March 15, 2022 10:11 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sun, Yongqiang <Yongqia=
ng.Sun@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.

MI25 SRIOV guest driver loading failed due to allocated memory overlaps
with firmware reserved area.
Allocate stolen reserved memory for MI25 SRIOV specifically to avoid the
memory overlap.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Change-Id: Ia1d1c4392fb792fa0186250dfc6270f35ffd6bed
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index f18d050a14cf..7021e8f390bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -643,6 +643,15 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_de=
vice *adev)
          */
         switch (adev->asic_type) {
         case CHIP_VEGA10:
+               adev->mman.keep_stolen_vga_memory =3D true;
+               /*
+                * VEGA10 SRIOV VF needs some firmware reserved area.
+                */
+               if (amdgpu_sriov_vf(adev)) {
+                       adev->mman.stolen_reserved_offset =3D 0x100000;
+                       adev->mman.stolen_reserved_size =3D 0x600000;
+               }
+               break;
         case CHIP_RAVEN:
         case CHIP_RENOIR:
                 adev->mman.keep_stolen_vga_memory =3D true;
--
2.25.1


--_000_BL1PR12MB5144FB9E772A14681FF6EB7FF7109BL1PR12MB5144namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sun, Yongqiang &lt;Yo=
ngqiang.Sun@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 15, 2022 10:11 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Sun, Yongq=
iang &lt;Yongqiang.Sun@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Add stolen reserved memory for MI25=
 SRIOV.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">MI25 SRIOV guest driver loading failed due to allo=
cated memory overlaps<br>
with firmware reserved area.<br>
Allocate stolen reserved memory for MI25 SRIOV specifically to avoid the<br=
>
memory overlap.<br>
<br>
Signed-off-by: Yongqiang Sun &lt;yongqiang.sun@amd.com&gt;<br>
Change-Id: Ia1d1c4392fb792fa0186250dfc6270f35ffd6bed<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++<br>
&nbsp;1 file changed, 9 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index f18d050a14cf..7021e8f390bd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -643,6 +643,15 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA10:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mman.keep_stolen_vga_memory =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * VEGA10 SRIOV VF needs some firmware reserved area.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.st=
olen_reserved_offset =3D 0x100000;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.st=
olen_reserved_size =3D 0x600000;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.keep_stolen_vga_memory =3D true;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144FB9E772A14681FF6EB7FF7109BL1PR12MB5144namp_--
