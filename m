Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B631C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 13:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C5A10E0AD;
	Tue, 13 Jun 2023 13:17:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2ACA10E0AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 13:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY4WC5U3V6wF8+6daAuPdqSa0WJ5KAnG6p1lJNtJont74jPzICaIF3zigxI/yXmpjt86HWKp+UFCNKThzeHi5sjCBoGOsFsALdcD8IyoV7pz8V/staKK5xx96SsdNL0iQ76FpwNAibUUU/EKLzL2yKQ/YM3Y5zyhLUILTM12NK5ag6F6mIO5CkYsQ9IW+SR3jy4UgDwqYVKUatux7UtOwMsAcJi8HTq/oby522EwwrzJ5eC2b+7diCZewx3Da7pzKXVUDfDOcUkWgAB5LKFX8OycvoAx/7uE4Qgf1heFDFDEO7fb3lNCsCyUE0w2EkZMzGXXAJy0cru/eVZ6F7OeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EklNU1NAx6mVtv11tM0GBUe7H+p/f42oy/+QUmFMbqk=;
 b=V/hAwd13vw2ReZCdK89aSlD/ycMi3IgwkV3hilKC0C7UNSsxFx+8SgH8I8gXpPs+Kpr55QnH6iKZKB3wWCn5ZgzXVv0Iw/rBHrITvKBPvpTCdGiaVppFpS5gS/p8iwqYFAPvKbGjWycVUxL6FCxg7dFI9TV/vkGQpqLanZHr4DC7W1Wv0p/274nk4JuZTQCPpys8DHrsxiFyv9m8V00u/JM2rXSBn/D9aqDOiNvD69rD6PYmCranGmyfFzj/h8aEkeEvBsoUMncsv7Asp2z6cq62sgD8AWInbbGBgoFToAES5xUvhMLuNHaAKfyAR4n+hzksTV7CIjQnzI77YNi+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EklNU1NAx6mVtv11tM0GBUe7H+p/f42oy/+QUmFMbqk=;
 b=DTeFbo9HIFQFHu7ZqCB3PYeWjCEU8yFl2awPai6C1+8zaVSnoP+/nbs5KHiV01kXWyfDqCKyY2zJa2rj/iICE+SXj4xq3R08oxtHCXYVCGeZ+bOvC9712XgJDeJaOrWnQ657NpYNtmgH5f3ipYQhwYjPHigSUzlPoc5F0mDoOmw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 13:17:02 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 13:17:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: update external rev_id for gc_11_0_1 and
 gc_11_0_4
Thread-Topic: [PATCH] drm/amdgpu: update external rev_id for gc_11_0_1 and
 gc_11_0_4
Thread-Index: AQHZnaSJysnBGoWAfEO4UUXW5+jcK6+It1IP
Date: Tue, 13 Jun 2023 13:17:02 +0000
Message-ID: <BL1PR12MB5144636AA55252744E350019F755A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230613030915.485806-1-aaron.liu@amd.com>
In-Reply-To: <20230613030915.485806-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-13T13:17:01.640Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB8321:EE_
x-ms-office365-filtering-correlation-id: 8f0bc2cb-a0cb-42b7-95e3-08db6c107a25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmeE7ZRzy/HLLQZH4TFItxG30DAby4hYJKsyfwub3oZAHaWfNe1i7w/05tuL/A8oBD/MTjKQdgpheI53YNVtzJcAZDz6gZxRCZP6Kfkbt27ox3sM5xzFMzaSP1kb9IGJ9z6fi4U5VqRidYChkEiGbrO2aQ0K+UsAXgD6ZDh8JHMooG1DGJ0WqwIQ+TuSjURh2UMDdthQv7XJGNiiGDQzDzYRT4T+lp5sClMH0GpJRdofHHvwmI3wdK+piaojPmRub/7LtUDY3ojSighodK63jhFegtzgs61rixkM3eMAbGa+TfI/8Ncu9xHPI9+MXdOjsZiGHl5FQ92bhepkZ3xI7Ai/9qHiEqgvUEBfoI4DYQd0h0PBHF3V9X7q1EcotXPUe3n2rVwQ5Aaqds6labyL+HYzMfIs1FODxRduJpGYH/dFJC0ATAS6skF6igF34MuUr7EZXhmVNOALYk8+LCIincZJCWBNpuGNkML5RbeplQohDoaoQGmFDer7gByVij3A5fgwKs3GWAvM0Rjxb3Jbimtl90HrNSDZJzpauQCC1qtmq2ksxkq4CmyMkaYoiO1tMNmiXZPIS2cLGAgrvLU3yXkcANFFX9nKjA/W8+RgFPb+CWIGzSRTbyyLJP0VvCqj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(38070700005)(86362001)(33656002)(66556008)(110136005)(4326008)(478600001)(71200400001)(76116006)(64756008)(66946007)(66476007)(66446008)(316002)(7696005)(55016003)(5660300002)(2906002)(52536014)(8936002)(8676002)(41300700001)(15650500001)(122000001)(38100700002)(9686003)(26005)(186003)(83380400001)(6506007)(53546011)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mf4+DQ2RXy9YcCOBMNMgjkpDfD+RTLZETS8+np8TfinEAGHaeQv0w2L0dZ03?=
 =?us-ascii?Q?P8oidyoajsW5Ph72FqGw75dkrQ/rGZHjmRqW73bv5vDe8wfoRB6KHLiHg0w9?=
 =?us-ascii?Q?u4vETKFQZZ5lSdbDRH0Oar9RcjFmKPDPesPhuA21LXae/KAawOHFrT2qIc6r?=
 =?us-ascii?Q?7SjTMfkWwaxJ3B+N7tClAM5vkUeS/M/30udrWNNyQrbkY4XG41gf0yXH+Xmv?=
 =?us-ascii?Q?kymgiooo7m0wUMtA93Ug2ndKIgB0X6OF8H/r/8+OAB2o/dLEvlW1wlTb6OOP?=
 =?us-ascii?Q?Rtwdr6l6aUhiAaU7+da25zY5sgic6NawjATxjJgYe236UwrWAKbwypTaOBz7?=
 =?us-ascii?Q?FW9nLMB1DRNE8qKNzZfaLhkbr02g394EeQuHCyg4GNfa0xZAcI/+6xcLm1nh?=
 =?us-ascii?Q?nfqSoA6+1QncHTPhgxsqV+o7uOm8LWYWIswcnbEvSq6sPROt2GCgrqa6f3A0?=
 =?us-ascii?Q?kdyqHTf3+EmDIEmkaH2xTng/nxnuTVTNicVrtbiZhn11VEindLlXu8s9+60Q?=
 =?us-ascii?Q?rFuSdLIevdZNWHBUg7iVV1q2BbvhBuTE9VPHL7/xF+7SZVs6+OF6ckd8Oe6H?=
 =?us-ascii?Q?o2+ot/FzfDxvCVQQtL9zC/JibkXaVb02n0fpJusotnSVlhrquV1i+h9o/dXE?=
 =?us-ascii?Q?YwGFPxArVLrwklPBQ9SYNd/dAttHeEhMv+wNu9tfL5onfRzStLSzpXbelNLF?=
 =?us-ascii?Q?FGYts5xwtz8YJctiAOHqk9ClPF6XS3THfvc6HoQ9MwnKa1LZCFFTI7jTPwQU?=
 =?us-ascii?Q?nI+jWkQSDMwjtbyTPYbq/ENpuAvIe4lBycJRGdRogAGf2Bhez/vL3syDbQW4?=
 =?us-ascii?Q?p5lrWd79PqRD5lRQukYIerAGWzToBVkd5HeuUQrnQ1faKfm0/I79aeiEIx7m?=
 =?us-ascii?Q?OjduRuDf8psKP+LzPoKKYd0yjP49l/Ki4ILsQTKKgkcCey8nq33edZ3rbdAQ?=
 =?us-ascii?Q?ik+SCxtICNS0jJq0sJgu1WBCap+XLcDV1GJlFdW5pt9y16HQINqRQncUHgIB?=
 =?us-ascii?Q?oK1FQPOnl42MK4TfNGNW1K/sHgqCNUn3Yy/8hs2fJ0MTyhuUSPZ1XNnOHYsU?=
 =?us-ascii?Q?abmXeTS7WTp2+Lzl/tcim0L/YagsVbT2FA+IHiSe4F3Xcj/jwB2tvXUWTr2u?=
 =?us-ascii?Q?upqXbvRv4TOrAgp96weQxVc19cgKF+EmnwzsK5XbBFIr/SCooh7FiYEjiFGs?=
 =?us-ascii?Q?B6IVoKJgG4WSwjNrU+HZpycwCbbwvMOr5IYmjFebyMXO8tii2B1IMy+cnEHD?=
 =?us-ascii?Q?eUak5mJUdexP0qyK2kd5MXbFqY9jNDN0Ri2fccRdfnuB9yaEypMnctldxN6p?=
 =?us-ascii?Q?Xb+Or3OZYQztwhRQl+xGouK1MDtNPr7D02bEfGXHPyw9hwoFh5JCL/rq+Unt?=
 =?us-ascii?Q?zBZ6nGY4V9k8H8jDr7K7acM9xaJiK4QeVtZIRgf+pheXR9sOCX4F0Uw3QFW0?=
 =?us-ascii?Q?ZHrqvBb6TGDNpzz/souK/uCeMfboMlIpndPWGza68ufzQ49tQyMV/EDJ6TlR?=
 =?us-ascii?Q?YMsUMYGrcpWQHlTFUgMgQkKh7l+07UQiujnqW8BHfi+uOmTeZ6TqTfIj3Rlg?=
 =?us-ascii?Q?r69rY2tMnR3CWzwWd+8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144636AA55252744E350019F755ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0bc2cb-a0cb-42b7-95e3-08db6c107a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 13:17:02.7048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPhywjPUJ5MSsDVSncsg9rcffhHgQpJAI+C1MA/ZdtPyHApBRPYs/R+pe9za5dvSLX817yblqXmTVWAEl4N3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144636AA55252744E350019F755ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aaron Li=
u <aaron.liu@amd.com>
Sent: Monday, June 12, 2023 11:09 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: update external rev_id for gc_11_0_1 and gc_11=
_0_4

For gc_11_0_1, the external rev_id of A0/A1 series is 0x1,
the external rev_id of A2 is 0x10.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index e5e5d68a4d70..caaf9da4c1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -665,7 +665,10 @@ static int soc21_common_early_init(void *handle)
                         AMD_PG_SUPPORT_VCN |
                         AMD_PG_SUPPORT_VCN_DPG |
                         AMD_PG_SUPPORT_JPEG;
-               adev->external_rev_id =3D adev->rev_id + 0x1;
+               if (adev->rev_id < 0xA)
+                       adev->external_rev_id =3D 0x1;
+               else
+                       adev->external_rev_id =3D 0x10;
                 break;
         case IP_VERSION(11, 0, 3):
                 adev->cg_flags =3D AMD_CG_SUPPORT_VCN_MGCG |
@@ -705,7 +708,7 @@ static int soc21_common_early_init(void *handle)
                         AMD_PG_SUPPORT_VCN_DPG |
                         AMD_PG_SUPPORT_GFX_PG |
                         AMD_PG_SUPPORT_JPEG;
-               adev->external_rev_id =3D adev->rev_id + 0x80;
+               adev->external_rev_id =3D 0x80;
                 break;

         default:
--
2.39.0


--_000_BL1PR12MB5144636AA55252744E350019F755ABL1PR12MB5144namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Aaron Liu &lt;aaron.liu@amd.c=
om&gt;<br>
<b>Sent:</b> Monday, June 12, 2023 11:09 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update external rev_id for gc_11_0_1 an=
d gc_11_0_4</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For gc_11_0_1, the external rev_id of A0/A1 series=
 is 0x1,<br>
the external rev_id of A2 is 0x10.<br>
<br>
Signed-off-by: Aaron Liu &lt;aaron.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++--<br>
&nbsp;1 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index e5e5d68a4d70..caaf9da4c1c0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -665,7 +665,10 @@ static int soc21_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_VCN |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_VCN_DPG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_JPEG;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;rev_id &lt; 0xA)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;externa=
l_rev_id =3D 0x1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;externa=
l_rev_id =3D 0x10;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 3):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_VCN_MGCG |<br>
@@ -705,7 +708,7 @@ static int soc21_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_VCN_DPG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_GFX_PG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_JPEG;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x80;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;external_rev_id =3D 0x80;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-- <br>
2.39.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144636AA55252744E350019F755ABL1PR12MB5144namp_--
