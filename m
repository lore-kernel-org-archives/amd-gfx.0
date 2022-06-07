Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC91EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 03:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F49111AEC1;
	Tue,  7 Jun 2022 03:20:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743C311AEC1
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 03:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqLUzGGTApvMvVX0eI8yGwTvY2Q6DmrIwOysZCQJp+PtM1+4gwZ2rhr3Q3f2mILjWDgcwAlbt7GEoeFYxJow0v6jGJiGu4gJd6gAFIDHqdFBc+hKa3zKDOgp9hp1OTkH2KOfXEA7pVnSrfEI926Gis6xEsv0Pf0tzQskfkY5oiuLKDS+scS0U4N52/pxvr9wehmnM+ONF9I0t2IreQ9/CF4PDnJcB6bzcF94kWKpp84oTraEQvHpsqbPhXwvm/wFrhA0gGz429i3VNYyuPl+KtyfeUepAa8W83KeyHLBP10m4s7FlVkvJTN+u3JJdN74L1jxPHC0ADmAusR1mn5uyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCnoXR6nyRdcBsA7TmH2inLV20zbRAuVmn133+k9iAE=;
 b=eGF8tNFD1EbT8re88pCYpsGq12ttPqCtiu29GmhFc7Ukb0+wYSxDWOWIQEl/HFkXc8CAi4BuCmolkIcdabtBD5FnAcdwiXq/OO92wzZZg9ZvGDsDL7JiqF9zMJLH9VAb6zEU5RatJPu4A3jIAiYNcXJp3s2/EefccBfmjrpaueLk5mAQryHMzEFsTTJcZmizXY39hipiQ2TyiGPKV3s8vgsbswk5Ex+1iR78ERIHll3Ae/lYkTaSmcnIgj9xCGJeSeU9/eE2mW1EfCkPZ1sFiRnTUwlDzD9RWBiXx3RbCvcFuBfazIN2ZLypI9JtzZr/CD+9xUPE5BtshR54XvyGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCnoXR6nyRdcBsA7TmH2inLV20zbRAuVmn133+k9iAE=;
 b=gnCVImOavC0scYbqKGJb8zcifnC/1rdLR7mJq6NqWx04DuYexCUXBK0e+NgzYF/DtfVWuehwywh+jBBrgND/+oZJERjBManKZg7+NcT42TWLYueD/ru6N8RwcribZ9CO/hXO/i6HepR+MdtPsl7khFvJQYdlRzlEf3zeEV3k4Cc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 03:20:07 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::7d16:a6b1:7a6a:aae8]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::7d16:a6b1:7a6a:aae8%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 03:20:07 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Add fw version for 10.3.6
Thread-Topic: [PATCH] drm/amdkfd: Add fw version for 10.3.6
Thread-Index: Adh6GnCehdqG02mRTeC6U2QKMn0rNA==
Date: Tue, 7 Jun 2022 03:20:07 +0000
Message-ID: <DM4PR12MB5152E4FE7DB27155C242620BE3A59@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-07T02:50:26Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=726e751c-4fc2-4f28-bc7f-27c599743d03;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-07T03:20:00Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b0ca54e8-44f0-4329-b036-eaa518ab2dc2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4fe6f25-5029-4c58-34af-08da48349f7e
x-ms-traffictypediagnostic: BL1PR12MB5095:EE_
x-microsoft-antispam-prvs: <BL1PR12MB50954EAB016CF7566DC1F6C5E3A59@BL1PR12MB5095.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dt0dgxPOihugUwann897UaF/9Qs4V6oBezYCDWcvz7fqNXZEgqlg4fvDVAAqvPvvXxsFX6BDkCcWPgpEOb2LvYLgYyjl5vpBYttxv8FrlBqhbkOUP0V+bT24ixxFx+0GNbhnqpZJ5HQoGGfRBW7giFZgXmWdJIFslV1MlwOLNVGpFYlSKRABwoWyg1c0wdgQYZI6C5JsB8Yn3WwLB5mXpbsf1ZFCEnZVd/6Ob0BZBv0mgVLrVNMyGELoorRDRJGYhG2im0wKKcUZOqV568lEOY9pFG59GKOQS3amZ7okRTU8HGd55yJ34NMxFzwAgJeLiDrO01SCtKiNLouCTUhpYo2vCnzMljHIN49liVMq1VlRNLwSgdwHhqneZXyrk4YeZxvTp+d8KiDwg0MHFs8VueeZPUttkNCHHZkO2dh8RQMMAqq4ekQfxN5Zs3+DJSi7I9rqfOnRc3IGQCQiTEPuonaWNmC/++GRkQW6daDV/b5HkqY/OP/eM9+GjRZ5t5xx29hgLHnI0YMMgkRA2Q2c5uyxaRVc5i7K+E99UnkL8Mc/OwjBi6J4D1QEAC6rj9UP9+QzaMg4uSs0q14QiB9TgQdLoDfWWfaGODfZzdRPlfZ/8n2ehqOjfDDB0zuegZlQRzwy5zwrBYXgFM6UjfdD8cM/wlKEG49iFWAkfaok8svxFVgqiI9ZjJT+92EnlLf2EdTkLfnmXowtwA0YprBSA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(316002)(7696005)(71200400001)(76116006)(6916009)(55016003)(54906003)(186003)(9686003)(122000001)(38070700005)(86362001)(33656002)(4326008)(64756008)(66556008)(66446008)(8676002)(66476007)(66946007)(26005)(38100700002)(8936002)(52536014)(508600001)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EmmmWr9NflMGPIY5nXCs3MIZvREMCDRCwzK/oaYDBP+p9zNKQmyEzmC4twvH?=
 =?us-ascii?Q?HewswoSWBlwI4F+I0NuCT4Wk5LxoThea7F0DAPXkMhfdl8MfNmYG3THBCh0k?=
 =?us-ascii?Q?YQK+f+wnGzaoGxI8Ol5X+Tw7KYjjs/shYlsgoL9MAW26yNMJqfbXUEXsBBmU?=
 =?us-ascii?Q?WqylSxl+oOK3LSGCXQ/aPTvDe0/jBGkGXb/6cQhMo+G8vls86yU+KCRq3/3h?=
 =?us-ascii?Q?ig514jouqQqo/QjFo/sJrpevSXS+zPcbCXPVfXExlSPbOKr2ydupq1gQQngF?=
 =?us-ascii?Q?dX9cj2QjEQnQcxL3fvpy3ecR3pKSkluWQd3FUopJ/vQSOQfUaT9QYISGpD2U?=
 =?us-ascii?Q?nM/v/kBkQ4fxtHm+4V20h6Wct3LGvb2eR1FuFWv9Dv5dWV4HEqmkKamQWHh2?=
 =?us-ascii?Q?boB2eqK8lCH9wTMemwamVGmQIDEYsFGaHl0rz8S6PXR8JEOO6O9xQxcd6iO5?=
 =?us-ascii?Q?3EYizcCO/dkwnlYnXbC4trTENxsd/imJBgclHEgr+4cs4xnayJEMKuzdAI/u?=
 =?us-ascii?Q?ljTNlZednsvVVI7sstejxc5+AbJct9iWy2IsO+fKOCtKxaza90BSKms/Dxjc?=
 =?us-ascii?Q?ZAQL5dMH5juIf3HxEIpDa3P4+TAr0Sn0nEkoc9E3ElD9FtobpCQg/55cEYSR?=
 =?us-ascii?Q?nAtqDONWAZMojP06y0y2JRtNwdhl+L4agMPEQwqjR2b2KSeukiPLzt1vB89A?=
 =?us-ascii?Q?VT4RuRXV5vTDNBooZR7zwQAyJ1GqM23xpUNfBp/XjmPLg4Fm2mC8vtKJv1db?=
 =?us-ascii?Q?qfeV6/oDC7jLfrvuhxZAI802OvEWZ5cYYSGPwqgTurHldwJAtTWgLE5veYG3?=
 =?us-ascii?Q?Ictjjnn8YtWtn2sT9S1d68JClyayK2BIP+v4BdRhhWYOab/PvpOv+++eFNqC?=
 =?us-ascii?Q?a/a/qQ90msfuE10ulczlrUNmFZALQZRa7qT08QDdowxk8mqh4uZunowvhrRy?=
 =?us-ascii?Q?8SU/meb9+QRd399/AqzNQyMws5dqpPB4FYkCxvf3d8Ah41USV30MfzQZ+hth?=
 =?us-ascii?Q?n+POD2kQxvYDZMuL7kzEO30u1F7fE34uWh8/HCVjo2D9zJIh2kTGab/ZdjLz?=
 =?us-ascii?Q?lagzFBl+AS85WJ+D5Gg4wM+z7f/d36IgYWr2EjGaneUf41IpGLrvoB8DRqZG?=
 =?us-ascii?Q?MK4y/vulf0JN8++2CIsqEdIgjIN4/hN0cNzbrX+RaK+R0EQaCVItt85xoRD7?=
 =?us-ascii?Q?ktjRdUeMTz6FF/V3yRA2UR1M11RcYk/mNHgk1EzEnSt9aFXgvccjMgMwH5XJ?=
 =?us-ascii?Q?timdA9jOgliFzOx7uosofinoeHHI39tVnlVmb9pj8V+JAcpn/rQByagukAku?=
 =?us-ascii?Q?6EIqeOUOeLJ1Sh1iemd+SJJH1mxMaCxDijn6SqXkUrAJB/Qr0FTn9yEgpjcu?=
 =?us-ascii?Q?0OHjKUfBW8m9GCgMnQ+aHLHwM9jbR0i3WPFEmDyDI4+FxWF86SDDTw6+EsQz?=
 =?us-ascii?Q?IEjZNNC4w17AgTp6yIbZKBWGMJ/Y09xMkyyIkzO1B6hwLz7qmoQsPlQ4zPsv?=
 =?us-ascii?Q?D72rKQziUbhqIXYOBScKgyE9qIrj4b4IVtzFiBGUX/6XaOJRcrWrg1VTBsJs?=
 =?us-ascii?Q?SvPPBmLzZGWtRSkYR9fQVds6QwWFlyK4346MA98jbwduRAPPi8Pa/v07qpeQ?=
 =?us-ascii?Q?3I3cJCQ2lSySISGNgUeFhgwJA4u436cgDGFcerenshv+RsibmmZGNNnlmfYs?=
 =?us-ascii?Q?6NWjg2/YluEKs0UknV5NbNpiCJ+Hjyz08wiUYBPAK5CWOw73lXl6VHJUgb6c?=
 =?us-ascii?Q?lGzcq6j0Iw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5152E4FE7DB27155C242620BE3A59DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fe6f25-5029-4c58-34af-08da48349f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 03:20:07.7537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XuQLE1WI71ch5alqPWxhepq8cAd7ML7VQD5+tzn+X+VG1zUt3ItAceLxMR9klgAwZQVc2e13WkrH3sA+u8SkBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Chang, David" <David.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5152E4FE7DB27155C242620BE3A59DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

It will happed error on loading firmware.   we need add firmware version in=
formation.

[  309.650118] [drm] kiq ring mec 2 pipe 1 q 0
[  309.652595] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).
[  309.653402] kfd kfd: amdgpu: skipped device 1002:164e, PCI rejects atomi=
cs 18<92


Signed-off-by: Jesse Zhang Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.com>

    Reviewed-by: Alex Deucher alexander.deucher@amd.com<mailto:alexander.de=
ucher@amd.com>

    Reviewed-by: Mario Limonciello mario.limonciello@amd.com<mailto:mario.l=
imonciello@amd.com>

    Reviewed-by: Felix Kuehling Felix.Kuehling@amd.com<mailto:Felix.Kuehlin=
g@amd.com>
    Change-Id: I9c8d70071efdfce85c860ebf19690d52fb8d2383

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index f8635e768513..bf4200457772 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -182,7 +182,9 @@ static void kfd_device_info_init(struct kfd_dev *kfd,

                if (gc_version < IP_VERSION(11, 0, 0)) {
                        /* Navi2x+, Navi1x+ */
-                       if (gc_version >=3D IP_VERSION(10, 3, 0))
+                       if (gc_version =3D=3D IP_VERSION(10, 3, 6))
+                               kfd->device_info.no_atomic_fw_version =3D 1=
4;
+                       else if (gc_version >=3D IP_VERSION(10, 3, 0))
                                kfd->device_info.no_atomic_fw_version =3D 9=
2;
                        else if (gc_version >=3D IP_VERSION(10, 1, 1))
                                kfd->device_info.no_atomic_fw_version =3D 1=
45;



--_000_DM4PR12MB5152E4FE7DB27155C242620BE3A59DM4PR12MB5152namp_
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
<p class=3D"MsoNormal">It will happed error on loading firmware. &nbsp;&nbs=
p;we need add firmware version information.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[&nbsp; 309.650118] [drm] kiq ring mec 2 pipe 1 q 0<=
o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 309.652595] [drm] VCN decode and encode init=
ialized successfully(under DPG Mode).<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 309.653402] kfd kfd: amdgpu: skipped device =
1002:164e, PCI rejects atomics 18&lt;92<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Jesse Zhang <a href=3D"mailto:Jesse.Z=
hang@amd.com">
Jesse.Zhang@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Reviewed-by: Alex Deucher <a href=
=3D"mailto:alexander.deucher@amd.com">
alexander.deucher@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Reviewed-by: Mario Limonciello <a=
 href=3D"mailto:mario.limonciello@amd.com">
mario.limonciello@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Reviewed-by: Felix Kuehling <a hr=
ef=3D"mailto:Felix.Kuehling@amd.com">
Felix.Kuehling@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Change-Id: I9c8d70071efdfce85c860=
ebf19690d52fb8d2383<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c=
 b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<o:p></o:p></p>
<p class=3D"MsoNormal">index f8635e768513..bf4200457772 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -182,7 +182,9 @@ static void kfd_device_info_init=
(struct kfd_dev *kfd,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gc_version &lt; IP_VERSION(11, 0=
, 0)) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Navi2x+, Navi1x+ */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (gc_version &gt;=3D IP_VERSION(10, 3, 0))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (gc_version =3D=3D IP_VERSION(10, 3, 6))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_info.=
no_atomic_fw_version =3D 14;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; else if (gc_version &gt;=3D IP_VERSION(10, 3, 0))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_=
info.no_atomic_fw_version =3D 92;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; else if (gc_version &gt;=3D IP_VERSION(10, 1, 1))<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_=
info.no_atomic_fw_version =3D 145;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB5152E4FE7DB27155C242620BE3A59DM4PR12MB5152namp_--
