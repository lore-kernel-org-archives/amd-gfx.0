Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A13C76196
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 01:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8318D10E0B9;
	Wed, 12 Apr 2023 01:25:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B64E10E0B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 01:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJcAJwvXoCvWUwkYU2s+ktWj7Ve8eGdMEONBt/He6dqzLBo6Eg8ZMUVO3OX6obE8Pm5iTPiZuJlFB/bZ6SaURM/CrnFCe0WS2RxKYGRjXzsa+nOUblOj7n+N1TthI1WoBoXErGfac58etrYFoJ35X8UsJqSwg2zYRA0MqaH11cSY9G5j3Dwoes9xxVqoe/rckUDiHDpmcpESQQ29AJfkU8wAcK5TJjYh2NEu0kPA/zaOyfRk2oiYISGyhU5hwRgXXoVevMQesxxAmg7YOaHC/EOllzeLy5DNOJnZ6tTXQZGQx2JQ6o3NzdyNsuCc//WQPPqcpjhWg1WSlPVPUDSAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gDETDHzHikjqlNV5MxHrMWdmryZwU1kzpgA8w+jKGY=;
 b=mCKXni6ePPIu9o7duRVuVHKvBqPuUafoxxrS1wvLAw4P7sX+Gconx5IR5TDx/FcgY1FUsDhNkZLjgRjNZ7jgjuIbsP4+DAeT/essbtyeBzt8VpazhMrNcmb4qbZxPpOj6YJWDrX+rNIGGs+ROWrAYr+GoAcRwUQzVR9Ou2NURzOVvH1ri3kLJoEyAyOwAOWOh8/nNQvSPpKthckN3IlWUDLmaFdpS4pW81D7GFRYYy167MKj2vW38vT6tmQhl1WcwEqzceZvcGRSEric/pCyoAVas/fUpPU00fyU26VUZyq484d/9fja4o695I1wpVxnuXtrFs34s61OmBDlry0v5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gDETDHzHikjqlNV5MxHrMWdmryZwU1kzpgA8w+jKGY=;
 b=uBn3/R4GluWS3PRY7W92ZIxkfIvcvTEM3CErOCr231hVQ2lPkAMM8oImI6UoTMjJFDi73Tq+EnbLZePtuIR/Nh22A/qWkc+zz5DL6ROV/jH/Rv6KxDWu0bBDu+dFqA75Pr5oJZ41r1Ara6jWtCJi9rZiuLCbxPb6ek7X5lyXx8k=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 01:25:03 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::388e:83b6:f2cd:cd42]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::388e:83b6:f2cd:cd42%9]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 01:25:03 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, 
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: drm/amdgpu/gfx9: change the reference clock for raven/raven2
Thread-Topic: drm/amdgpu/gfx9: change the reference clock for raven/raven2
Thread-Index: Adls3Y+sz5H9A9DYT5SiI0Mz/SeAiA==
Date: Wed, 12 Apr 2023 01:25:02 +0000
Message-ID: <DM4PR12MB51527E447D080F457A43B415E39B9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-12T01:25:01Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=beb9939d-153b-4939-8ad8-327a5cb3a941;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-12T01:25:01Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 5a6337b5-1ead-4c16-a9c2-68263bcb0b93
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL1PR12MB5995:EE_
x-ms-office365-filtering-correlation-id: 5b87e476-e102-4fc7-1702-08db3af4bd9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kJ4cQwcDuX4fY/cm5PAMWr7XM74Lcrgx3uNjtzVIS3gNWIpNi9IQS+YJeW/H7+qSwfcrFZU/K0T3tPQDUkd9lFW0oX/wuUY4QMpM5nQtXJ4cyUz6JfJwmq/64r+BztuK+UplFSyMlUeO1c16XAuF4VR++EWMTaqCSZWojLHfr88k/s/3OryVb4JLTwjO4BAkStiax7QbcBN6MyT4VL1C7tg34/oKqKrssE+JvrvkJospJN/rt/CYpX8YX+/AbgwHGkMeIob9XYb5YV+0Bv33W8pkfSm50uBL+5g/dlboTnroqnHveYiSWQ8kJEzWcc0NB3UJzkyRmAUOR/OPznE+IJj/nE4gzWfo2+AmkP3O6zDNWL8xFUkj2vCoR7TGwiLhWM2Fq+6a6JQmSTqy3IquK+XCkZ9rKDQqNpl3JHmCMEAwtbPr1NomfWo9FoeMgsTdx1W/pvUBTGYtshgIo1tB9wke8nmix13c74g1etDvl7wG4epJxUbS6o4hJ8015L0AgzrYVGmp52Vfv68DrIqVDqsx5uhYOs+HKyuYSX1Q6WEhhCKtVaQ5e8twojvNGBJLyTwFnxAR52yUkp9/NoChvnYqC6rSSSi0Rp7sVfXa4f0Uu9/tu932xp+5XNMKzBCo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(6636002)(110136005)(33656002)(122000001)(478600001)(9686003)(6506007)(26005)(83380400001)(71200400001)(7696005)(41300700001)(316002)(66556008)(66476007)(64756008)(66446008)(186003)(66946007)(76116006)(38100700002)(5660300002)(52536014)(2906002)(4744005)(38070700005)(86362001)(8936002)(55016003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4yiDCXqMQkWnDPbiZqJ2faPveoQWEH5bDywC6Mf1ZMa9bKbjIiaa/srFi2SF?=
 =?us-ascii?Q?O5lRQAwxPEMwjgqyhRqo71kjoD1Y750DGj/5dFGS1YchnGfJzu8NXV89fLC0?=
 =?us-ascii?Q?mq+L0O/aVV0Ny5niA150rr6sA4n32bFn0qGoluXJ4BGKX25Hm542bRMU9+9h?=
 =?us-ascii?Q?QBNBU5HQUHQdvS0KhJ0sDxPZF5sPWnfdMc0/V2cXxROm8RRFl1G0zeDDLfDL?=
 =?us-ascii?Q?MTLzGSnPsqE1juyRoMwSH1RF2m7XtYhue5Ddy6+O+DcGxj/GXfraa3PAiogF?=
 =?us-ascii?Q?cFP1OUb3QDm/oSyXrHytiVIRHKN4/mg6gtkTDyBdrqPPli7XM0ntcpbhDhXF?=
 =?us-ascii?Q?b9gxjSK6jO3EYKGL/pWVTCmQRk5qG+23NMT5sMIAUQYel6G0ZFmEL/fL/XtP?=
 =?us-ascii?Q?0lsuz8pLJKjsR3MhmU+91mPkn3ZR8wW1Dt6O3/rhFj+lWL1UUH33Ci87TpB8?=
 =?us-ascii?Q?l1YVH7mwaoV2CvfLVPJk0A4gcBpIOkdAP64Opf+m388omuRG85CYLeMXMLxg?=
 =?us-ascii?Q?19phkrUs5KQxxxDoyOJtbDt+aO2y/0x6SRYOSnDcGWe2VElrYwGWXqEwoycO?=
 =?us-ascii?Q?bHE6U1m75cW3oRPK0m+XZrIOJ73z2OzOs4DgD4KKGw5A6nzpwmencpMyhI2N?=
 =?us-ascii?Q?VhEe0i0TKtMH4RyWqDSn29vYXSRF2B4AyglyYQMutVyUKYsY4oaq8tCc8XJ/?=
 =?us-ascii?Q?ptQVWzX3SAC5XPy7q2M9IMDlADStJgW/kZ9atNbpXmX3PDJ94RfV3N/bftZ+?=
 =?us-ascii?Q?Tl0KXuAB41QQzitkp0DV+oPjrE6DyJVPuCYDAk5IhKGD4W2TL2t9Sasa9hUj?=
 =?us-ascii?Q?moLnwNcZmnKjOL6Rnh7tdkuvvLGIQkUJvuiMglzl7B26NQQYjBV+ltDP/mZ5?=
 =?us-ascii?Q?AGKAdhCWh7KRPcgTkhRHWzlPfb2/Wz3ODAk+NvG6QhEp8Tl1zOAn2IlI0D3N?=
 =?us-ascii?Q?is4B5M6gUWGPOt4m7MmmO1UhzPX1fkgYgV5RK49EGRgqDKNubHRLA1mdpH5g?=
 =?us-ascii?Q?VtQPedK7/dl7pW6EBb0tclT0R8DFwm0tsHUHKZ50nQTRmxa0IrQ6EZNnsG9q?=
 =?us-ascii?Q?q9vrBIN/EWnDIwXwL5YSbPbG69ywLPFstNIQnH3s0MGe5upJhVRMTvp+HPDE?=
 =?us-ascii?Q?hJiTq+u1c3m7BVF4/uGjvNBZIbLjFsPAcq84MO/3WhJXggTvCf4TQyUzdKqu?=
 =?us-ascii?Q?TIPO5FakPJdvEYKArg6gQpUMj6KS4YmsF1mvvgEQJ4EvGt/7IqCQhKDpp/vr?=
 =?us-ascii?Q?xKJDOuIN3MomsV21A03htigPheRft+Vwlk7qOqz6Z/siXXdxY66x7QMIp6rn?=
 =?us-ascii?Q?Gc5hGq9oU6TsMQ2ZqDgw9FHiYzYmemLAwXS6tPMbQf7VK8PyaT/wlW37SSaj?=
 =?us-ascii?Q?2k4dMLYRTy/lh+hGWINdGSPMgllO9SzalFtMNst2phiWIY1W23Ky31bbsdA6?=
 =?us-ascii?Q?jcIv6dukmLF5oK23EsFl7RpC+iL63XbafD4gWdqVsvYSirpbzWZHfk44eSJF?=
 =?us-ascii?Q?SCphXRn4OKkV7pUwkQlWz2zBlFjqfJ+xjHMmw2hYU8RGU8j7vJceJzfe2dSm?=
 =?us-ascii?Q?DKglcWANoHsVSARNw+k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB51527E447D080F457A43B415E39B9DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b87e476-e102-4fc7-1702-08db3af4bd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 01:25:03.0024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuiNE7vBJ7W9kyDDAkWInaes5Iow9+NfeSMimzeyU1HbMCL21YgX2bo1Y5cqCm+S1H7Ow/YRuGPwgjxJ6T+lDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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

--_000_DM4PR12MB51527E447D080F457A43B415E39B9DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

    Due to switch to golden tsc register to get clock counter for raven/ ra=
ven2.
    Chang the reference clock from 25MHZ to 100MHZ.
    Signed-off-by: Jesse Zhang  Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.=
com>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 7d04c39332ad..0367a97c606b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -301,11 +301,10 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
        u32 reference_clock =3D adev->clock.spll.reference_freq;
        if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1))
-               return 10000;
-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||
+           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1) ||
+           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||
            adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 1))
-               return reference_clock / 4;
+               return 10000;
        return reference_clock;
}

--_000_DM4PR12MB51527E447D080F457A43B415E39B9DM4PR12MB5152namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Due to switch to golden tsc regis=
ter to get clock counter for raven/ raven2.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Chang the reference clock from 25=
MHZ to 100MHZ.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;Signed-off-by: Jesse Zhang&n=
bsp; <a href=3D"mailto:Jesse.Zhang@amd.com">
Jesse.Zhang@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/dr=
ivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 7d04c39332ad..0367a97c606b 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p><=
/p>
<p class=3D"MsoNormal">@@ -301,11 +301,10 @@ static u32 soc15_get_xclk(stru=
ct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 refer=
ence_clock =3D adev-&gt;clock.spll.reference_freq;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (=
adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0) ||<o:p></o:p>=
</p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1))<o:=
p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 10000;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;i=
p_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1) ||<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 1=
))<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return reference_clock / 4;<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 10000;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;retu=
rn reference_clock;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB51527E447D080F457A43B415E39B9DM4PR12MB5152namp_--
