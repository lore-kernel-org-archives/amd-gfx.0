Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB05C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 04:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE5F10E7B3;
	Fri,  1 Dec 2023 04:38:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3766410E7B3
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 04:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blUOxOifJq5PWYMTtB1IeRWep9/TA7M7zxuSKb2RnKW5+TnGRocpnG4+EzfPh4s3HpfHPF6M/prC0Dnn/G1lIEIJhwmPpdo5hJl7uoS8cPkgstkf5gNdl7gwFYfUPgdwZcCiaEF3AHVMF1nlnK9hKPbRGYx262rR/lFXpnhiAFRgxmb0GVYoxowJiYKM9ASZ74eYS6RVYMraOf68UOHwwT2M9daiSZ1dl59QEphcJtUG8AiF6IExk1nCBARkXBhE8bUV7a5FnTv8YKaEiA590r/CSXDobAjTlkpCUsrAey+9J/awYUDfGkg9+scgM/GT+FEsx05AVsUas5UiBL9syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR8stKuYkbsEhQ9fAP4moF/jZJFvTeZxUK0N9XsbIvs=;
 b=RTlNlOZrqTnjFvu5Jb0dpmUYFjaT2HMk7wHmrC6DB4HnENe7o55V8qyYEnJl1n40rXZ9rhFyDCTrWQJmOcwdtgoPWv8m+O4UDeJ/54bz3na5JPyPf74cqgSlbPNuTnpP8PrU0QKzQTinpCxVoNVrpTFxyNwYPfArQEXV7a9iVmkbqX9WXUZzk0ht1HAsjurWP6CVco0tvHJZWlXZ9yXpPZrGRiXZKqgWFafWOYxGo+v6zGXNvt0KjiLkwCiSBHNjXle1K2iAm+Kz9svNeyMo63ft0l2feSKEuymAKJhJCy41kdz6H0COIAoDAZoggwI7jRg3400KjT9Vb9gkVcCcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR8stKuYkbsEhQ9fAP4moF/jZJFvTeZxUK0N9XsbIvs=;
 b=jVkFX70kvOJ9nY15LRRl6tlloeD7LpZXUJaqp/vUJwGoYop7K1YpzSds0e4uSUd/nsR+wj53v0S1kFSYWGMEFDktouUDQJt05eyIY0g+zot/MbKXJ03uxdu8VH2vDaxoYWxYCW7O4yudxdDJLzn9SN8AenJ/0sIr2J5oBqOzFx0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 04:38:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 04:38:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: disable MCBP by default
Thread-Topic: [PATCH] drm/amdgpu: disable MCBP by default
Thread-Index: AQHaI/F5XkGOdpdlrUqGJ/bgfRbRsLCT2HxJ
Date: Fri, 1 Dec 2023 04:38:37 +0000
Message-ID: <BL1PR12MB51443C187BAA0FF6B9780E1CF781A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231201005751.4194154-1-jiadong.zhu@amd.com>
In-Reply-To: <20231201005751.4194154-1-jiadong.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-01T04:38:36.903Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8481:EE_
x-ms-office365-filtering-correlation-id: 56b08f68-8e46-41cf-4e5c-08dbf2276260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RgRWM4fqNihX5K2taZtHci3P4g+xjMtWr8BJGb9365fn6+iWo1THE3DopZ+25z+Yh0CZ1FYATvTMqGOPR6AW9U8sS+yWLYPvvXwPN1b5HagAzaoraQR94Nd/oEFXfzbbI4TIAyWlGlR/SNu66UKv/GJ80FHV9QLlch17pPT3nL57eO8KX6CfRJSsEgBBXlZv9621MMnXNkdulAoZNWfUWaxR961UVtKBZk00AuO8mXJRG1ScRSzs4OmO1r/cgjofq/TatmBy9txFMPBfFmzZwc+69k8GqcUxAO6PHU9cEnlW59XbXQ0pKWFQ/YMhcgQeIFZ7r+K+v/tkiECQRZgIDEvyBXLB7jz5N2QEwUBkU1SMmRO2olPAICtnYUvhN2AClrTSjpEnXwOYoIhuRPFd0w5XkM+WhQsKNngnGstdwPXfQcSgo7q6X7ZH4QE/nPH6oleBDnocBrWWiqLlhMxzJcK9fmTFBPrv4nFbIyP/jGAssn9Y9PYy2inrgwViTtGPC4aQKux8c9T591R9Xm1m7Or8ksmjOMusOBtn2mN31CxTTh5Z4FqwS16HW8JJXVHTY7GX8MjuXfTpAKMDdXYS8BQHGlXSptAi2SQZflrM37QbdZr+nfo0DU9Ze76JEKAM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(38070700009)(19627405001)(86362001)(83380400001)(76116006)(66446008)(64756008)(66476007)(71200400001)(33656002)(38100700002)(66946007)(122000001)(9686003)(26005)(6506007)(53546011)(7696005)(110136005)(2906002)(316002)(66556008)(8936002)(8676002)(5660300002)(478600001)(52536014)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ue7r/OFdKooD4zyBaVHvAwMuz3OkVQ7udv46s8ITsYTj7qHLVOP8HYjugQpa?=
 =?us-ascii?Q?YAw8xJce2bltO3WdedtH6R2JeiNfAeAStEN3eH+PIvWWaLL+GJ0BUlBOEIar?=
 =?us-ascii?Q?SMMKrSdav2fi4se+ZEZbbv3iTSDvb7jyWB/s8NR5JAFklitPLxJCDcZIURBX?=
 =?us-ascii?Q?6Sgo0lsjQwKKwepZPHpveZGisToMBR69Pn+3RuMmM6n/0vXoZtfNxIX4MBbA?=
 =?us-ascii?Q?52oOX2aRLfTpeYJlCt4j44ElhChb71ArwvUGMv2HVT2mr8Z4vlTrDwJartIB?=
 =?us-ascii?Q?sqom95/1wkieJFz9pbFscR2gC0UETNX1HM05IVzkcYmEa79sQPUcMhFxCG1D?=
 =?us-ascii?Q?AxXtA4HeqBKzM97uPDwwYByJPO3au78Upb6mN1L5FaFEHG0FF8/pcM5O8RwE?=
 =?us-ascii?Q?LdKg5e0soIyUIYMA9zuUWgBjCCJv+owPMYMlpTJUqLhUg4sQu9zJyynAmOCT?=
 =?us-ascii?Q?qcKKDKP1MlquLJ/e/PqOJdtB0Bx32GyEPMs1xDNC0C7zE+LxTD83E3Eswf5Q?=
 =?us-ascii?Q?6Myho/q/vJKisIBIestrdb8ZbTvmxEA1RvyNBiIJTAXfZL4e9fhX7soOyGn+?=
 =?us-ascii?Q?cnJi7zw1CammNQXoB9ACwEP/SKSHE4H9sfO2eamyeiEwipAgJyPrjqEYjlj6?=
 =?us-ascii?Q?18WzX3dsKtwRqURHZMC5XVmfagNKqVR7ml34FA0OEV5m1Lj8VG0iI2x3OWBG?=
 =?us-ascii?Q?GkDJpOn02Tg4lY3/IcSNzme8TgKqni2kYB0+D/RpbgYY1okv0xpPPStyjnU2?=
 =?us-ascii?Q?b0bJzGpIq2nAdqRF7958sCfvbLl82GHYpPt17K6ZyDN2/miczC3uRi+YLVhs?=
 =?us-ascii?Q?TRz5To5NJvg/TiizuO7YCmAP4AzT5H+OEr5WaK3HKhYK366y97BG1Gek+UcM?=
 =?us-ascii?Q?52tXqGExVlBjOl9QoS/CNiYpekTnjInQ++N2asGxT5MGEAfPQj4zUNSyScVC?=
 =?us-ascii?Q?wrpkJzrf9TWBsUsjzd157YLVav/E6UUdhkf/TXi2G+Zx1vi/MhjuSOLS4BU3?=
 =?us-ascii?Q?T1a3lYwv1+3upkVut+FB2246e2SQTz+ltiv9iMDWrPlXrvicMOM2r3MHTWcq?=
 =?us-ascii?Q?qDQJfhcDghIZg/oLEtAz+oPyaeC/IMpVqbNeOmAbNwnHZtaD6pujr67QbcUp?=
 =?us-ascii?Q?CXPPBbAdsfqbkl8Ba7onFk2pAkQHCBVmwWdt+2zfHT2JeVarW0y1HF+bzCtD?=
 =?us-ascii?Q?6qEWxxFepQYHwBz+jca1BiCxwMIhlD1OwbdAu9/jjVn4pgjUvLvSMP06d36E?=
 =?us-ascii?Q?CU8XAyEOB/8rPHkiuKHm6grsBMnpc1inKXcrtM0ZeGnJYm8+ltMHVTBUVg8F?=
 =?us-ascii?Q?cFnrxUYxcXlyHcbJ48HBpzjzFoBa/HiC+10pQQRB2qtkXm/MmLGxVT8GPqbs?=
 =?us-ascii?Q?ODVS4rrnkOkON7OVdIpsZDYbvUC/Pip8p5X0eMq1Qx5Ao3AttYlA0N8rYoe+?=
 =?us-ascii?Q?3x5vJ8dISEqWHgba/5liqNgQVVY+h9DE+OLpEpitHhFw/KZWHAJNy+CD+uqe?=
 =?us-ascii?Q?vNuo7RJYmQLBMh/iABPE9qqPudOxqGTdtzNru3EFSWRcSSvRNWsTUCHNPCCk?=
 =?us-ascii?Q?wVzMv/YunQ7FNWEGQ6w=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51443C187BAA0FF6B9780E1CF781ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b08f68-8e46-41cf-4e5c-08dbf2276260
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 04:38:37.1068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHWDso/nEjbKitpnOB5bdO9dNJLHkEpwFXx96v9o43AfqS0yaVDJ9xec/04Ad5f7rNoCxkvYEu9Upe1RnbqdYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
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

--_000_BL1PR12MB51443C187BAA0FF6B9780E1CF781ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of jiadong.=
zhu@amd.com <jiadong.zhu@amd.com>
Sent: Thursday, November 30, 2023 7:57 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: disable MCBP by default

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Disable MCBP(mid command buffer preemption) by default as old Mesa
hangs with it. We shall not enable the feature that breaks old usermode
driver.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 21b8a8f2b622..280fcad9ce93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3690,10 +3690,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_dev=
ice *adev)
                 adev->gfx.mcbp =3D true;
         else if (amdgpu_mcbp =3D=3D 0)
                 adev->gfx.mcbp =3D false;
-       else if ((amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 0,=
 0)) &&
-                (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0=
)) &&
-                adev->gfx.num_gfx_rings)
-               adev->gfx.mcbp =3D true;

         if (amdgpu_sriov_vf(adev))
                 adev->gfx.mcbp =3D true;
--
2.25.1


--_000_BL1PR12MB51443C187BAA0FF6B9780E1CF781ABL1PR12MB5144namp_
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
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Acked-by: Alex Deuch=
er &lt;alexander.deucher@amd.com&gt;</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of jiadong.zhu@amd.com &lt;jiado=
ng.zhu@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 30, 2023 7:57 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhu, Jiadong &lt;Jiadong.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable MCBP by default</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiadong Zhu &lt;Jiadong.Zhu@amd.com&gt;<br>
<br>
Disable MCBP(mid command buffer preemption) by default as old Mesa<br>
hangs with it. We shall not enable the feature that breaks old usermode<br>
driver.<br>
<br>
Signed-off-by: Jiadong Zhu &lt;Jiadong.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----<br>
&nbsp;1 file changed, 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 21b8a8f2b622..280fcad9ce93 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3690,10 +3690,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mcbp =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (amdgpu_mcbp =3D=
=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mcbp =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if ((amdgpu_ip_version(adev, GC_=
HWIP, 0) &gt;=3D IP_VERSION(9, 0, 0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) &lt; IP_VERSION(10, 0=
, 0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.mcbp =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mcbp =3D true;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51443C187BAA0FF6B9780E1CF781ABL1PR12MB5144namp_--
