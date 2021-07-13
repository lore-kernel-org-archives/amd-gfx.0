Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53656C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 19:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1548361183
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 19:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1548361183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941556E118;
	Tue, 13 Jul 2021 19:17:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503226E116
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 19:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOYAuamCv8d1r7F8G9mh6DU5ABESf1baUGf5+TMHddLBYm3a62jTsf3YCHa7K9yTLqIykj/OWWx9LXC3jeGvky4ZVjFMcNBYWCbBkxi/Rdeyn0Vju9SdCGQGiE5wEdNTQLGcjE5B7tTTyPf/pdam4Px4QAPiN5ydciqadAJi6Iyk+dPVf9l6BS8UI3PanbqgMBo9fhpnorJvIOefWGI5Bl2K3xT/uVb7vw3AGa0+nvlL9P930J+NaEPFkXiPIDJSSdhFRT81C6c0p9gt1xS5Wuba6hJcdzd2BWjQAKj51aEUIWzVBLFgeV0oHngcs4fRAD6RYy8qmLrKAANnsCaZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBp8uxC492O9sWtVQ5hbDfGPlZRtHyI6OrO/lE77asA=;
 b=h83TXc9tKWc37jediUG2MdmIF+kU9SaJq6OSaTn7YLpcd+id8s/Lcfugvz6Dosrlbo9iD2AWZ19FbYujvXAnPbZH9vDjG9jT30VjJpZqzn9raQlJ/ll0KfYSV01N6jgSjlQOcmrK8/S5tjx4gkSX6cWpgbfjS1l+AHRm4+NpBA14y8k2xXheKAjVUc0dLJL8NFOzXYjkXyKs2mxlNnKr9hVs8dX2FUzO/IpXKF7cLPM9O0rAm9qleRwF9tpAGhI9B/yaVji9xlupbnSbA6EOCOfuK52eMv6z2UA+sLW3B2OkfZprNKGCxH/++UCrwCBRVzhvdlFvLsTmThwFK7Ynpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBp8uxC492O9sWtVQ5hbDfGPlZRtHyI6OrO/lE77asA=;
 b=KpCl3C0a3S9HIFWtW30smiIQrrdtrpB2xVdyOoW8zGNhF3r2W5+6ek6fuj46pAtmc4RcgqBtw9k4wxu3HVHE456K/G0OdMnDz88qZqLH4vJVHNmqSXJ8qM9mW+R/k6Zw7q+s77qQZ+ubPUbO4OAKuxjUmvJKSr3sTRLQfkvVmIQ=
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Tue, 13 Jul 2021 19:17:43 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::2560:34ab:f08a:3248]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::2560:34ab:f08a:3248%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 19:17:43 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] amdgpu/nv.c - Added video codec support for Yellow
 Carp
Thread-Topic: [PATCH 1/2] amdgpu/nv.c - Added video codec support for Yellow
 Carp
Thread-Index: AQHXeBeynB34df2sdUWjCV24pTIpyatBR0ZD
Date: Tue, 13 Jul 2021 19:17:43 +0000
Message-ID: <DM5PR12MB2517B5A1FCD62DE19EB98A62E4149@DM5PR12MB2517.namprd12.prod.outlook.com>
References: <20210713184808.1268570-1-veerabadhran.gopalakrishnan@amd.com>,
 <20210713184808.1268570-2-veerabadhran.gopalakrishnan@amd.com>
In-Reply-To: <20210713184808.1268570-2-veerabadhran.gopalakrishnan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-13T19:17:43.323Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c00ffeec-88bc-4e76-a87d-08d94632e414
x-ms-traffictypediagnostic: DM6PR12MB4186:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4186620B9F4AD7AC3CBE0AC4E4149@DM6PR12MB4186.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wU/2oXU/1kxtjTmn2JHvzpwQw6/CLsJVTadkRutiest6yvQ4+QByPPw/Ywk5hnnxObBfVudSsjVCMiBXejvFc+sbK6Hknekq8si99DwYMgnjvq4eMkm4PsTFzf4TDxcZICsLbLhoOw0sUEbwfUrqDlIzLNSU8PdTjUOqxON6fDesG1AtAn00aFnu4M5Srf8EKpCeCX7Af9KMSQ0LkEArcYqNM7zjgCq6AU3JiTg2Sghd+aSR20LJHyuDYOVbtM4AkKvo/u6sDt0KHhRxemstKDH/ZThK+a8Yh9I0dX+jp2lHfquT2U3z6drtj6Un/pqxfOeDfx96W2RVs5VjkBR/FazZEtVBNUXLBQVPpGqVXu7bVSgqL0coyedBZTn9HWhYAkVBTVHgWR0z3A/iG17MS1cfFQXi0mMiWeXgoQ/GBTNOGSIuz5g46TDZHjIjA+oR8BeCiXv4C5Zwqc302zZn9Va/i5PPRacAx/VOCaD03Nis51Mn/qdv6bu5I/Ipl7Qv4hoKDJFtm9JPPDNYGwiNLyIp7IEobXSI9jdNiur7++jUszZZhW1l7wkN6yJRC9fa4oamONxuNctBAj0Gt0WlLN0Xc+udjGLv29z3TSVsEHjvk39ZtjBG43kqbFuvW4+BidtZMGPQzIuFW3n8PfOi0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(19627405001)(26005)(55016002)(122000001)(2906002)(33656002)(71200400001)(186003)(54906003)(66446008)(478600001)(9686003)(76116006)(110136005)(8676002)(66476007)(64756008)(66556008)(66946007)(53546011)(5660300002)(91956017)(7696005)(83380400001)(316002)(4326008)(8936002)(86362001)(6506007)(38100700002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kLRI/Wlp8peZyTfPlGpBzMZjFjLFnM7YM4n6FRgpDrskoOKJyf7LahhZ+rlb?=
 =?us-ascii?Q?bhhkxkQ+YczSz2vGaoRrFG16G8DqETfVsdf7+m8YHTM25L5VCWWPCkhNMMP+?=
 =?us-ascii?Q?0d2BCCocuThb1CPKzwm4gTHn9EoxKYTgWEIjN0M0qYJZAKmEpwtscXScIZnz?=
 =?us-ascii?Q?4MQJJC6uRQWVG7Epzrj54GpuvFksxxpz3r80No9AQXEd0fg7CTUZGksO4sS/?=
 =?us-ascii?Q?a0jgY2S+zHDRVETOhKoMVmqFdezo1iqbTCscEkNQy7D6BZJ7dhWkdCFUe7HQ?=
 =?us-ascii?Q?uD51vDyVjVUz9LwwGSqjJ3FdXgnYjWZw0/YxgI6fZbbnX3t2/6qqpkUn++kk?=
 =?us-ascii?Q?H87epBY0RjM2khHiPwpCPpjH+QxobIXNYRabiSWlF4oTmzAlUMuoI7vXTng6?=
 =?us-ascii?Q?BveikZnhDG7INrPV34xGH1+N8f990JevSsqX9WcZ0sQkQUjVK+7++bQFbTkU?=
 =?us-ascii?Q?gyhejQLuldCLLBiXrRWJE1nDL6P4OfAIFMKVP6QSE2tryckkpurSGaIxCcii?=
 =?us-ascii?Q?bfzRr3enN6VxOSs0exnBcxxvF1VTTBZY2Aa1BbbKjjpu2G+NzR8CQimAy3yF?=
 =?us-ascii?Q?795U13Q3dwDwOwdXmUZqtInBoPFOa4VvMgNwVcCw+Rz7KZK6tobDi3+kJt+s?=
 =?us-ascii?Q?/J3/C+Y6CQUieB/rp7povio7iALhA7D4OE8l8PWoV8ek1Zg5upec1VZ21+K7?=
 =?us-ascii?Q?JEGRdRLQektk07oXmRxL8XgiMIMbwX1wcYE/ApUQiW+LSDkLUXOaZyRZGRyE?=
 =?us-ascii?Q?G5TGjamz50Vh55oCxU3Cis7+7ewRYU5tOH6cc1wyKFlJI9wg6guHotlBgDni?=
 =?us-ascii?Q?Vj4w5s/aowxXCodrnV0iXY/iowHaCYbw2KocJ/BajXqmPKzDbCqNuwXw+WeN?=
 =?us-ascii?Q?BxB14Ndij0/QTMaWBQDN/MR1B7z15n/OrReZuCe43Tq1bZEFP3zGqVmPyaWU?=
 =?us-ascii?Q?hbp4HGwUgDcFjn05l/WF+PTUIistG54k+NaTiTPzr3iOHJy0fxaxHcM+18je?=
 =?us-ascii?Q?JYE/PqVECVcjge0AEDmoG0Jiy9a9mUfGC+kDxN5lxR3LRi8Dzs4qLRPbughM?=
 =?us-ascii?Q?0LQkyoLlFLwetnAQ+1n4rnPxsAVhc18hklDtgCVOua3EIo5pd9EQQVhlKS4P?=
 =?us-ascii?Q?lKr99MYRK8MYdO4Ntw3aCFyPzorqfsQvWzeH2dLFKC9JOCLmg58ROwmr0fhx?=
 =?us-ascii?Q?q7A7YCthVTNCWgR61rtWGMfHU9qSjSaxs49pol9ZeMcVBNwjbLbJCX7uBkDR?=
 =?us-ascii?Q?5c/BSjDaSfQ+aG1k1UpigWG4NZj0CbSUvgm15O5Cy07wXxGXwR/UupKl84p5?=
 =?us-ascii?Q?X0C9CRYor38secGmwBjEFSuH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00ffeec-88bc-4e76-a87d-08d94632e414
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 19:17:43.7154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYi7Zx9dU0+IVp03n0Hf0ZTIUW2AMFyC6P8PmwXtugDZqTUB4D1RYZoREFYWxbYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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
Cc: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Rao,
 Srinath" <Srinath.rao@amd.com>
Content-Type: multipart/mixed; boundary="===============1590752731=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1590752731==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB2517B5A1FCD62DE19EB98A62E4149DM5PR12MB2517namp_"

--_000_DM5PR12MB2517B5A1FCD62DE19EB98A62E4149DM5PR12MB2517namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: James Zhu <James.Zhu@amd.com> for the series


James Zhu

________________________________
From: Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd=
.com>
Sent: Tuesday, July 13, 2021 2:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Leo <Leo.Liu@amd.com>; Zhu, James <James.Zhu@amd.com>; Zhang, Boyu=
an <Boyuan.Zhang@amd.com>; Rao, Srinath <Srinath.rao@amd.com>; Gopalakrishn=
an, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 1/2] amdgpu/nv.c - Added video codec support for Yellow Car=
p

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Added the supported codecs in the video capabilities query.

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd=
.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 94a2c0742..04f6cf38c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -333,6 +333,19 @@ static const struct amdgpu_video_codecs bg_video_codec=
s_encode =3D {
         .codec_array =3D NULL,
 };

+/* Yellow Carp*/
+static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[]=
 =3D {
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096,=
 4906, 52)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352=
, 186)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352,=
 0)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096=
, 0)},
+};
+
+static const struct amdgpu_video_codecs yc_video_codecs_decode =3D {
+       .codec_count =3D ARRAY_SIZE(bg_video_codecs_decode_array),
+       .codec_array =3D bg_video_codecs_decode_array,
+};
+
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
                                  const struct amdgpu_video_codecs **codecs=
)
 {
@@ -353,12 +366,17 @@ static int nv_query_video_codecs(struct amdgpu_device=
 *adev, bool encode,
         case CHIP_NAVY_FLOUNDER:
         case CHIP_DIMGREY_CAVEFISH:
         case CHIP_VANGOGH:
-       case CHIP_YELLOW_CARP:
                 if (encode)
                         *codecs =3D &nv_video_codecs_encode;
                 else
                         *codecs =3D &sc_video_codecs_decode;
                 return 0;
+       case CHIP_YELLOW_CARP:
+               if (encode)
+                       *codecs =3D &nv_video_codecs_encode;
+               else
+                       *codecs =3D &yc_video_codecs_decode;
+               return 0;
         case CHIP_BEIGE_GOBY:
                 if (encode)
                         *codecs =3D &bg_video_codecs_encode;
--
2.25.1


--_000_DM5PR12MB2517B5A1FCD62DE19EB98A62E4149DM5PR12MB2517namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
Reviewed-by:<span style=3D"color:#c0c0c0"> </span>James<span style=3D"color=
:#c0c0c0">
</span>Zhu<span style=3D"color:#c0c0c0"> </span>&lt;James.Zhu@amd.com&gt;<s=
pan style=3D"color:#c0c0c0">
</span><span style=3D"color:#ff9d04">for</span><span style=3D"color:#c0c0c0=
"> </span>
the<span style=3D"color:#c0c0c0"> </span>series
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;"></p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Gopalakrishnan, Veera=
badhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 13, 2021 2:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Leo &lt;Leo.Liu@amd.com&gt;; Zhu, James &lt;James.Zhu@amd.c=
om&gt;; Zhang, Boyuan &lt;Boyuan.Zhang@amd.com&gt;; Rao, Srinath &lt;Srinat=
h.rao@amd.com&gt;; Gopalakrishnan, Veerabadhran (Veera) &lt;Veerabadhran.Go=
palakrishnan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] amdgpu/nv.c - Added video codec support for Yel=
low Carp</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Veerabadhran Gopalakrishnan &lt;veerabadhran=
.gopalakrishnan@amd.com&gt;<br>
<br>
Added the supported codecs in the video capabilities query.<br>
<br>
Signed-off-by: Veerabadhran Gopalakrishnan &lt;veerabadhran.gopalakrishnan@=
amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 20 +++++++++++++++++++-<br>
&nbsp;1 file changed, 19 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 94a2c0742..04f6cf38c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -333,6 +333,19 @@ static const struct amdgpu_video_codecs bg_video_codec=
s_encode =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .codec_array =3D NULL,<br>
&nbsp;};<br>
&nbsp;<br>
+/* Yellow Carp*/<br>
+static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[]=
 =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {codec_info_build(AMDGPU_INFO_VIDEO_C=
APS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {codec_info_build(AMDGPU_INFO_VIDEO_C=
APS_CODEC_IDX_HEVC, 8192, 4352, 186)},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {codec_info_build(AMDGPU_INFO_VIDEO_C=
APS_CODEC_IDX_VP9, 8192, 4352, 0)},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {codec_info_build(AMDGPU_INFO_VIDEO_C=
APS_CODEC_IDX_JPEG, 4096, 4096, 0)},<br>
+};<br>
+<br>
+static const struct amdgpu_video_codecs yc_video_codecs_decode =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .codec_count =3D ARRAY_SIZE(bg_video_=
codecs_decode_array),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .codec_array =3D bg_video_codecs_deco=
de_array,<br>
+};<br>
+<br>
&nbsp;static int nv_query_video_codecs(struct amdgpu_device *adev, bool enc=
ode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_video_=
codecs **codecs)<br>
&nbsp;{<br>
@@ -353,12 +366,17 @@ static int nv_query_video_codecs(struct amdgpu_device=
 *adev, bool encode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (encode)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *code=
cs =3D &amp;nv_video_codecs_encode;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *code=
cs =3D &amp;sc_video_codecs_decode;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (encode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *codecs =3D &amp=
;nv_video_codecs_encode;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *codecs =3D &amp=
;yc_video_codecs_decode;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (encode)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *code=
cs =3D &amp;bg_video_codecs_encode;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB2517B5A1FCD62DE19EB98A62E4149DM5PR12MB2517namp_--

--===============1590752731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1590752731==--
