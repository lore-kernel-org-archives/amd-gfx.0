Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A46C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 16:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C8B23750
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 16:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C8B23750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52266E854;
	Mon,  7 Dec 2020 16:16:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DDF6E854
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 16:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxneyEEhAP8zye5vnvV/STujA0wGAJfiMZIDjK24c8B9I3yKNCNlo8YdvB/ZogtEromz6u2yRd6jLPSG969oSrH0NcQPGL4NlP9VWvjxRytJqDOLyZSiWCsrHkwVopU9KZV7hfNZLBm4yXJxrIqOUi2hJxl24KnQ1+LtwT2+SZ/lUeNqevOQcWhh5lYZsZ1SI1v15qvu4kXm1peULMhUw9q3m6ZecYl37LGPSphIa5i6j+5Y6CsE1BQzojoyI8RsZy5oYVOefT4TRBO2kh7YGnZZP4IBdWNmmxChPyy8j2TsuKWi3tQwxy6qiKqqkkALHJq4hjg7V6xAcW7nvAqaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylNaw9OteoVi81IFj+o9ScabpGz30q8xEL4b32b3lOA=;
 b=eEQvc0gjU2zPEBy3wFgslJ81dIGDpepXJuM3N2zv6hjXglUC8XxCirZ2rYfmLp3Ujb8ZUNCjgcZ+nilqBAx66IZll0BgCLnn6GlzASOTEXycvgJ9zwQVf6mKSPKQijMF7m9BULWLx/gQ8fSJ1vvHtCo6U8MDyDSQ5MLDO9WgvknbNBR8+5EHnjRa2N05IaHugTgEqLzd4mkmdNyUi87kwROXm+SY98tRcQAhN0IEAyGc8XffbTE8M6KCu8NjaYcqhbq4cfU4H543cjdxpCYyOG1vIMpnFkLGJXVCANFhIZ0kTKH/0fhTgkdipDCWjHET5v6Lmz0Eqa8cKzEkdJyQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylNaw9OteoVi81IFj+o9ScabpGz30q8xEL4b32b3lOA=;
 b=N0M2Y1QMn1h0gEoi4o4q6yOuQsOdOqje2boQ6ReuHqQUnxtAzJ/Zu64Ln6x4hoPOTISCr7KM5iAiNb/kDf2m3933y1ah3WqaScXObPIQXqzBYEWYUZmSkc8VGBlMALHslVa29ESiGhLKK/0oRK4u9xvBMtrkxRJnChuk1wWk6ak=
Received: from BN8PR12MB3281.namprd12.prod.outlook.com (2603:10b6:408:6e::22)
 by BN7PR12MB2737.namprd12.prod.outlook.com (2603:10b6:408:30::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Mon, 7 Dec
 2020 16:16:17 +0000
Received: from BN8PR12MB3281.namprd12.prod.outlook.com
 ([fe80::b98f:7fbe:826f:b97b]) by BN8PR12MB3281.namprd12.prod.outlook.com
 ([fe80::b98f:7fbe:826f:b97b%5]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 16:16:17 +0000
From: "Brol, Eryk" <Eryk.Brol@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dcn3.01
Thread-Topic: [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dcn3.01
Thread-Index: AQHWyoTMglOHzwiPwUy2eP97qMymh6nruKsAgAAatFs=
Date: Mon, 7 Dec 2020 16:16:16 +0000
Message-ID: <BN8PR12MB3281D5BC81279E6C0FC836A5E5CE0@BN8PR12MB3281.namprd12.prod.outlook.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>,
 <20201204212850.224596-15-eryk.brol@amd.com>,
 <MN2PR12MB4488879965A579F764B05367F7CE0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488879965A579F764B05367F7CE0@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-07T16:16:16.646Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b26e5964-8eb7-4503-d5eb-08d89acb6d2c
x-ms-traffictypediagnostic: BN7PR12MB2737:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB273773D055F3D039E49376E9E5CE0@BN7PR12MB2737.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6G6ZxlrrnWpMXLtO8V2YoKbwbKKvEcqSE4X8+U1sAdL2BXHSmXdpBLiGSEQsU68ZIHwJM8U+NAuPJ/m8MLiRH2Xil1okty6pCPRJNzM3OaiGciPDsz4wQdOzTzgZnvqYi3vGIcIEcikmkAG3XKljENIuCNqyYbQgHgRmVGB0t9DIImSKNbErtoNJE3N6FOBaZa8k7RVGVzR8MARDXE3Ut7+T7JKS2mM+E77VoXpuHJc0pgrJ+VgpAAOQzxGRFzBHeGElYwKf72EYhSUHTrKzhfzpgS69gM/G9Fb5Hr2U8Dz7ofXh394eUeKtSk+apPu5/afDcG+Wu8pWR1K9W035fegoyQDkdZdbuHKj7RPvtGM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3281.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(45080400002)(66446008)(478600001)(64756008)(8936002)(76116006)(110136005)(55016002)(8676002)(66946007)(54906003)(4326008)(316002)(86362001)(7696005)(53546011)(19627405001)(66476007)(2906002)(33656002)(71200400001)(52536014)(9686003)(5660300002)(186003)(166002)(83380400001)(66556008)(6506007)(26005)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6b2h1vucG8VkqSkV0oyrGNpbP0ROZHi0M6J/y5OrvIzzsV76K5RvFzEPz5yY?=
 =?us-ascii?Q?VO6aD4TipmpsQhWKQvWSAyv3omrO+FrakmrueJ/qX+BzxfGSCof7vcaGkncl?=
 =?us-ascii?Q?EsZlH8jbPKg4dEJMtbF7PHcKPwQqNR9ILncxvu2aPHaIoHoka/dHErg57O22?=
 =?us-ascii?Q?Lk1YDiZF4VicBzy4UqoHLS3wszjzV3s+8k1Et31uFHenFStJsLWXR+dTCUls?=
 =?us-ascii?Q?FCITw3P0csR7vxpGFNc6cyTLDs5e2YEd4Z8Lvirte8AkrsmiK2eulrjNaRFf?=
 =?us-ascii?Q?fELxJA91FZF74jtXWUdlG8VCEw30HAaqdwvnGb+UotTOQrGLzDbEj4qeU/eX?=
 =?us-ascii?Q?90WDjBhnCyA016KL1EXSTJK+3oo6R/DPZDTnwTs/Ivjfd5oPRq65hUAXXKK6?=
 =?us-ascii?Q?EThKYBIY+LpiRvFvEsf2rRrL/PsMjktsUZ1JyyROoD4aZVLDBbMEyPv7ZndF?=
 =?us-ascii?Q?egjqEvQCyod36kQKKmNzr7/TGP5nFAu8N3YGgB1sgNvIdSnss9U2e5TfrFNc?=
 =?us-ascii?Q?Md2QyoXi6WrsFjTDMs1gbiGxI/I964pQ8vShVOx18YGJabTPJ/hS6+bcPDVf?=
 =?us-ascii?Q?KlSUek80i4M8iYcCLGAnGRcuwgjx6YuEqL7dkvcd0wtbzTmnzJTfN7WqQDST?=
 =?us-ascii?Q?NFsjLfGplxsponkEmNVH34bxzhzjamKjsgKdWWzbAsqPtaZLbE0G7zk2+PtL?=
 =?us-ascii?Q?R+6knAircIffXWCTNvJZoQ8kZ6+L/Kf8AbvYsdlQKUHMh6pN1jd23G7o01a0?=
 =?us-ascii?Q?cbNp8Fi86V+XLc5joWYi1ef1zSQUA2d8hzEBp80dXMgatyQA33yGpbKDDeWV?=
 =?us-ascii?Q?CY+dn5h6obkcY646BUhhx1MG+uYnKku/8dj684Q12+PQMW60q2b9pCZrCaeQ?=
 =?us-ascii?Q?d1hbw2IEIDe69AHthNFoQezeWuHCcitJ7ozfa9S8xuVOJiwBh9CESYHXNvd4?=
 =?us-ascii?Q?XlNU+yhR65I9x1zpu/3kGNzqrTjCEQTIozYhicXvbcA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3281.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26e5964-8eb7-4503-d5eb-08d89acb6d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 16:16:16.9990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtUXatlG5h9QKC6Y4ehABckG9adY9A++lwtLvep3S4evBULXvIwB1MoqALoceJqh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2737
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Sun,
 Yongqiang" <Yongqiang.Sun@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "R, Bindu" <Bindu.R@amd.com>
Content-Type: multipart/mixed; boundary="===============0343525641=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0343525641==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3281D5BC81279E6C0FC836A5E5CE0BN8PR12MB3281namp_"

--_000_BN8PR12MB3281D5BC81279E6C0FC836A5E5CE0BN8PR12MB3281namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks for pointing that out!

Eryk
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Monday, December 7, 2020 9:40 AM
To: Brol, Eryk <Eryk.Brol@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Liu, Charlene <Charlene.Liu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@am=
d.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.=
Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabi=
ndo <Aurabindo.Pillai@amd.com>; Sun, Yongqiang <Yongqiang.Sun@amd.com>; Lak=
ha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: Re: [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dcn3.=
01


[AMD Official Use Only - Internal Distribution Only]

We've dropped the CONFIG_DRM_AMD_DC_DCN3* kconfig options recently.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Eryk Bro=
l <eryk.brol@amd.com>
Sent: Friday, December 4, 2020 4:28 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Charlene <Charlene.Liu@amd.com>; Brol, Eryk <Eryk.Brol@amd.com>; L=
i, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd=
.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.S=
iqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Sun, Yongqi=
ang <Yongqiang.Sun@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>=
; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dcn3.01

From: Charlene Liu <Charlene.Liu@amd.com>

[Why]
dcn3_01 supports gpu_vm, but this is not enabled in amdgpu_dm

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 59f738008734..53a7cb21f603 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1035,6 +1035,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev=
)
                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
                         init_data.flags.disable_dmcu =3D true;
                 break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+       case CHIP_VANGOGH:
+               init_data.flags.gpu_vm_support =3D true;
+               break;
+#endif
         default:
                 break;
         }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C93575bd3247e42f848bc08d8989bee3e%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637427142787650359%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Dwf2Tl4Qz9IzTZVvfBRYcFHZ8Cr464ZEZ%2B1Pb1GP5W9E%3D&amp;reserved=3D0

--_000_BN8PR12MB3281D5BC81279E6C0FC836A5E5CE0BN8PR12MB3281namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thanks for pointing that out!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Eryk<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Monday, December 7, 2020 9:40 AM<br>
<b>To:</b> Brol, Eryk &lt;Eryk.Brol@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Liu, Charlene &lt;Charlene.Liu@amd.com&gt;; Li, Sun peng (Leo) &=
lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; =
Zhuo, Qingqing &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo=
.Siqueira@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;;
 Sun, Yongqiang &lt;Yongqiang.Sun@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawa=
npreet.Lakha@amd.com&gt;; R, Bindu &lt;Bindu.R@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 14/17] drm/amd/display: Enable gpu_vm_support fo=
r dcn3.01</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
We've dropped the <font size=3D"2"><span style=3D"font-size:11pt">CONFIG_DR=
M_AMD_DC_DCN3</span></font>* kconfig options recently.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Eryk Brol &lt;eryk.brol@amd=
.com&gt;<br>
<b>Sent:</b> Friday, December 4, 2020 4:28 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Charlene &lt;Charlene.Liu@amd.com&gt;; Brol, Eryk &lt;Eryk.=
Brol@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, =
Harry &lt;Harry.Wentland@amd.com&gt;; Zhuo, Qingqing &lt;Qingqing.Zhuo@amd.=
com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai,
 Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Sun, Yongqiang &lt;Yongqiang.S=
un@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; R, Bi=
ndu &lt;Bindu.R@amd.com&gt;<br>
<b>Subject:</b> [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dc=
n3.01</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: Charlene Liu &lt;Charlene.Liu@amd.com&gt;<=
br>
<br>
[Why]<br>
dcn3_01 supports gpu_vm, but this is not enabled in amdgpu_dm<br>
<br>
Signed-off-by: Charlene Liu &lt;Charlene.Liu@amd.com&gt;<br>
Reviewed-by: Yongqiang Sun &lt;yongqiang.sun@amd.com&gt;<br>
Acked-by: Eryk Brol &lt;eryk.brol@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++<br>
&nbsp;1 file changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 59f738008734..53a7cb21f603 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1035,6 +1035,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_GREEN_SARDINE(adev-&gt;external_rev_id=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_=
data.flags.disable_dmcu =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; init_data.flags.gpu_vm_support =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C93575bd3247e42f848bc08d8989bee3e%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637427142787650359%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Dwf2Tl4Qz9IzTZVvfBRYcFHZ8Cr464ZEZ%2B1Pb1GP5W9E%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C93575bd3247e42f848bc08d8989bee=
3e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637427142787650359%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3Dwf2Tl4Qz9IzTZVvfBRYcFHZ8Cr464ZEZ%2B1Pb1GP5W9=
E%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_BN8PR12MB3281D5BC81279E6C0FC836A5E5CE0BN8PR12MB3281namp_--

--===============0343525641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0343525641==--
