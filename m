Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5334CCA473
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 13:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D802BAF0;
	Fri, 22 Jul 2022 13:27:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377212BAF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 13:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOBBmCGz7JWji0sCaXfecb7uq4SZA9aLa0IEZgA0hEWi3hkVs1X3whZGRe1PFEsDGaM8HEICFU9DZzawju8lV8LOTrH3zgVyUUKwzeQgXVqVTbaGINRh7Tt6ZHIkn44yfug8tgTcmgxJQo01rX7i2NQJhEgZTxhNkoJ3qd9Mu7QBD1GnaJOEHtMFW1CVf7DydbmItXY81v5QldDGZmlVPH2pP3FsgBYpiy8zP/foqg8jzRm4rInAzZGr9B7WVIQY/0y2f+F9p1uQBIUW9jitrIsdqBbNW0DMmqSftGaznK0tsea/zv7v7kTby+O5PRJV+/pMVZja3M1yg9IqkPfoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dL+L+SJxuJTreb8NtKQ8GejtxGNgblfvstQFFzKTRI=;
 b=eQJCZb3X/e572lpZRhy2K10KSSyEKv/YllKmoKDw7Dr2ZFrzCOEW6GkrxJEmqydprVDJusnjZ4BWJzgSarsJvCqJ3+czGfbln0+l91PRxi7+iE3Q226XG9VW3Gqe8J9BqONt8It77WDoeOI4ea12RleFmBpO4+NPo34c97641hjDKvKaDUBhEEzEnp0wbf7kWSyugrxnvc6Bw7Ek2GQTPfNhkJt2b4lAOlyE6gtwxbbVgz1WcWX1hkkJlGG0wRDY9sQsZ7S9O2EgRot5yeZfZryY0sYhLYKaRRe86nfrrxI+JqPE1bRKbfKtEsEuZlW1yHAviotnEQYK8ty4tk/xsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dL+L+SJxuJTreb8NtKQ8GejtxGNgblfvstQFFzKTRI=;
 b=QuCHFPF+SRX62Z/lL7Ay4ygLjx0jreDfvGhjUErllhR97S397tT3qVYlAuIuOhyBjnrwAFRkof0KK/DOeVt2219+XdRjiDnbtamAUc2eKgnaSuD8NTXO4Bx8BYmwFpmbn8SBNn6S1trXO/4CrpD8naN9ArC9I7qUoBgH4GRjc5U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 13:27:23 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%7]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 13:27:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable swiotlb for gmc 10.0
Thread-Topic: [PATCH] drm/amdgpu: enable swiotlb for gmc 10.0
Thread-Index: AQHYnXH1+HWFPl++e0azG2OPe9VdzK2KYn4F
Date: Fri, 22 Jul 2022 13:27:23 +0000
Message-ID: <BL1PR12MB514448C851CE2F3019FF6A3DF7909@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220722022239.728988-1-aaron.liu@amd.com>
In-Reply-To: <20220722022239.728988-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-22T13:27:23.071Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c714ec34-b1ac-4827-e473-08da6be5e97d
x-ms-traffictypediagnostic: BL1PR12MB5205:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aGcRTDbTwst8jPUmlUkJ3bcUwXLdtXg030Ny3qgZBEmQD3zidAF1WkLJ0kgr/7j+VYHEVNdzwgWUFE/owj5xHv31D37SITOcJ3YaciFRNxi9DTPSgT6kUoiR5QUA2YOg+epNVdxXQBVn/0B9J8HqedyjQQV8GXaO/ly6reiQMDl3LPK4TrJoYSkyx63bwLFsvZbTVwliT3iCvP6ZUIpRnOq82bZN30pAa7W9YsBViJKqfX3x7XsykjJP4bA4TDmvfoFXcqvPTmfWGwLauAVBwSfFzS170lOdPvpoDciemRwtWLv9G5Sohb8XwHZ4kwILplk0yR9+vTyTxvDeWQhr/ARg9sTfJghsSshVCWabWQHRhRNcu7DyVYvzPh1yoTXRqBoSnrMx1RY0Ol8gxipLNoVd7lxqxFNkiywq4FwCwn2++ngPwpUGT+VXXKHj+65yd03ilYBhzpGG8T9CuFmBkBBlevD3+Mqgfi1F3K3iSySqbldyoYh0uYCd4PRadW/ydLSitjP5lhhziHzUm3KuB4TKHmJ6GCFTLQLfyz0Gzr+8tTNqzgeyUbX6UPAY8aD+XpqhGyuMbblEBOFExCb36xWmCvTOcn47UlDMXnDVLotw8Xi0mabUl4GYEiFZUO0/OdoEK3Htf3DODLgLNUaYWsNJgZ6uugA6O8VkCWWDnm5qcCJw/qOF91XlkVWjC/38qkBDtNHolYonceA6Ochow25BeaPt/LMLafvCS6PbSrXcRCYurwhbiT4v7lcz/d3HGAmWBxdj13XxYRocSiGG4vZqeV78zDPJVBSc1YAoCIY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(52536014)(19627405001)(8936002)(33656002)(5660300002)(2906002)(186003)(66476007)(4326008)(86362001)(66556008)(66446008)(66946007)(76116006)(64756008)(55016003)(8676002)(478600001)(38100700002)(122000001)(41300700001)(110136005)(71200400001)(316002)(38070700005)(53546011)(6506007)(7696005)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?drSpToFrHLiYlRN2A+vO+lnsWkXA/x9h93EYHmM+o1/5l819AJ4UgVddD7lq?=
 =?us-ascii?Q?Dtg1pE9+D8RTPoZ/V6UIo1ZSeo7RdqFVaizyvPaTLE7pNf1YXACGjTiGDjv6?=
 =?us-ascii?Q?dRE2+YVyTJ8ep4RqEKyeNqa14PTI/ICubBNADjIALp0DKidRSJYeKMHZgq7R?=
 =?us-ascii?Q?C9RtBDVHnzeK6Jys3dWmG/CoX/1XSSNmV6R1F+A2fGiEbQg2CQyoxmkVsNfx?=
 =?us-ascii?Q?pP5RRsNKF0Re7ylzFRJSQrJ5GW1taNdgn46LkYFvcadbh1W+soX6P33LrKNG?=
 =?us-ascii?Q?k53FiQH023y+cPap4Ik1Zi1vd6e70yzt4izUdlnLH4XE4nnJq9vwVU/gAm6w?=
 =?us-ascii?Q?2EBxeFUvaXOkMztIFEFq7OBPJoHsiorC3O7LI/wWZNTTr0LdVQRlt+bHSPnQ?=
 =?us-ascii?Q?NI7WukqE4ITc8SBuBQ0RoOu7vFDHEBRCAaOD9zPNA8EQ71c5cJWtN5kOtOH4?=
 =?us-ascii?Q?2jXkUwqSGmkZaJtsvY4EqB9dE6OaTLXDum5orAWUOgZt6ZJdzOGSo5uD0XV4?=
 =?us-ascii?Q?PTxoHZ1NzJWPuMPN+Tew5OhC+QXBGaKEvEKsXb/0As8FkPoMuqn82y5m5iG4?=
 =?us-ascii?Q?dpmrVNN9WDrEft3RwiIFQGVzSQss68wC0wAagC9+frlKuE6q0K/HrseSJdyB?=
 =?us-ascii?Q?VROKDyKiw3xM8kPRrlYYOUDc4r61hqEd8FJsDVluD0cyk1eB2oZrv6pdm5AX?=
 =?us-ascii?Q?v3SaW8MO8zVYwYtJOtHxG1RKP+7SuahF56uQLnv41RPPnWPlyykriLGdM/Qs?=
 =?us-ascii?Q?GeTB8eWaiLVIPyoIkZMVavgLTJXqSeHPGGTn4iuD30SbvDGxMO11cnY1cyL5?=
 =?us-ascii?Q?klQEg+SfVKQyVjMoe7PrsjXXNQJwyiszgZKFMuOTpIg0p+Gm+vnvZvFs1fKk?=
 =?us-ascii?Q?zBqe/L0hV71qsvrP0mIUNgO86fyBVTam/No26Yi9xSz1GEFLghWfeGJ5EiwI?=
 =?us-ascii?Q?aLVYnwkmUGleWZu6N4iO9yQY4wENVZsvi1RwI3DMDw04fJIorRa0eFKlEN05?=
 =?us-ascii?Q?D1xmCJPEAYOi494k63h/prtgYCq/7saTRxkwJJc4zpBU03u0m63vjlrnB9j4?=
 =?us-ascii?Q?IKfs+y7HXRTMTck4QUVU+/xmT6hr0zTJ+S6C+HQPggjNUDOyvYOg7YmhK4Yo?=
 =?us-ascii?Q?YWXkgwLwJaFqNtvy534Jd/NWsoFAzDIGQ0hJRdviTUTrOGs9fI+6n0Iz7uTu?=
 =?us-ascii?Q?zVpQlqcf4/zoZK2rGmDgjWopouO6oJgd7pkWHqt/3N2iqkfIyreptBSYEYBt?=
 =?us-ascii?Q?BuGgsWQFXMSWZIPwK82SddAuuxbYzd/Qe7n16lv/GV3nWDXmSzHAE0Ke90qQ?=
 =?us-ascii?Q?dxvoUjnSolNt+dJWbjAnkt2iI6+nkXIimCDY6f0R0Yz193yEL5amSrJkwIgN?=
 =?us-ascii?Q?tX0J6V7fkZ8H6gBrOsJtVt/IUr6d6iuAFOFm2FwYAOX3L7qn2rePabeBjtUh?=
 =?us-ascii?Q?YfhJdt3eod1ND5RJJn5mAlM6Auu58r8C3CDrwliSh6bJ6/kg9Vs3C+lV+HLf?=
 =?us-ascii?Q?vC+9kT1QldVg4LBkQs2iYlBzmFyiK9cqq9qUwVvBPD2UWjj1m+HyAiSIRacZ?=
 =?us-ascii?Q?KEq0GojLjEhrKWuhFmI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514448C851CE2F3019FF6A3DF7909BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c714ec34-b1ac-4827-e473-08da6be5e97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 13:27:23.4902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2l5s1VfD9MF/sGpAnjl+m5yZeY0sglmgYgxmsXc/HWjOkv1dSsH4BJme4hxqB4+pPrR/nvOhDor9vI2KQqjFaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514448C851CE2F3019FF6A3DF7909BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Looks like gmc11 is missing this too.  Care to send a patch for that as wel=
l?

Alex

________________________________
From: Liu, Aaron <Aaron.Liu@amd.com>
Sent: Thursday, July 21, 2022 10:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: enable swiotlb for gmc 10.0

Enable swiotlb for gmc 10.0.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 6470290aaf7d..a1a98c7fe8e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -967,6 +967,8 @@ static int gmc_v10_0_sw_init(void *handle)
                 return r;
         }

+       adev->need_swiotlb =3D drm_need_swiotlb(44);
+
         r =3D gmc_v10_0_mc_init(adev);
         if (r)
                 return r;
--
2.37.0


--_000_BL1PR12MB514448C851CE2F3019FF6A3DF7909BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Looks like gmc11 is missing this too.&nbsp; Care to send a patch for that a=
s well?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Aaron &lt;Aaron.=
Liu@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 21, 2022 10:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable swiotlb for gmc 10.0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable swiotlb for gmc 10.0.<br>
<br>
Signed-off-by: Aaron Liu &lt;aaron.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index 6470290aaf7d..a1a98c7fe8e1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -967,6 +967,8 @@ static int gmc_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;need_swiotlb =3D drm_need_sw=
iotlb(44);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gmc_v10_0_mc_init(ad=
ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
-- <br>
2.37.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514448C851CE2F3019FF6A3DF7909BL1PR12MB5144namp_--
