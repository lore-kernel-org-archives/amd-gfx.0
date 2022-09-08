Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354E6C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 01:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566E110E103;
	Thu,  8 Sep 2022 01:59:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A3410E103
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 01:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbN0hTMMUjmY2HF+SsFM0lWtIrT4PaIa1jb8Q2zAiBjYkady9+C76/2TZhg4X+x5syCUONpCwtiXvinTB+Aaf7GYbYQhENGvggFuZb4zbHO+w1pj6isv9vViJfljkKSMeU5unN1nzJ3Bn1nJS7Iu80Ntek3yqpVjxU/ORfHf3S4rxhqmkN8Ggh6O+KRTfCPDZTSJbj35a0Grk02VDgSkio70qUXbtap5dG8yLoZQMTkMpWcmGTdKdM+BR7Zm8CmVO+FQ2tfx5cBCUv4OVgWgfMozcOs986W47najLNEaF0XgqNg/JCzfxhjW6uE4XKKu0+R41XN6aBNh2CEj4BhruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQpPhNgXdPPnHmXGJPI/WTYS+zoHg+ZM5QN4PpWYWns=;
 b=ZfrzwfBiZ6FI1WQ5CRUw+bNbWpC7FqHw70mejWrYk8Ye4TCPir0Sv65b+zYRicioaK74ikFgVMxs0BDM0sRnV/iUpOe8mbXIGADPM8WUjv05tYPcCu/UCVJZJpNGrG7wtcG8iF8MpaXUVSMr97V3aShICIQVEaZlxXVoE0P0pzLE2MhOaxlLStBJG3wsHIg9bnQbxrZMVAWhG4j54domD5ZsMg/ExooHrYMQ/U/KcsuwmSaUD9x/ozWuDmxZwBYxQawruzBxPgbNKNoEeiEsNAZ/1lsDSp5r9NOqgmA/JbDHvPLY0IbnTEHAKHh1I/GdxDv9Q9eUtygUjg+nKFAG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQpPhNgXdPPnHmXGJPI/WTYS+zoHg+ZM5QN4PpWYWns=;
 b=HgoGgI/vneGOVFZgqvndlYNwBykrAJSW1AfckQdoI5FMF7iLeQ3TFFG6tr5wpcs5D6Mrx6JQLAc5gQybmVAVgSbKGozc2Lesq3k3Cxd8kzBaVmdmuKz01vXIAU5cpCAGLNiLLH6kT7zLrOVNhTQeRDD5NvR3PP6yegzRmxoZvHw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 01:58:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 01:58:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Enable full reset when RAS is supported on gc
 v11_0_0
Thread-Topic: [PATCH] drm/amdgpu: Enable full reset when RAS is supported on
 gc v11_0_0
Thread-Index: AQHYwyAs/3LPYcA1dkWtmXFYV/ApZq3UxsXs
Date: Thu, 8 Sep 2022 01:58:54 +0000
Message-ID: <BN9PR12MB5257EB43ACC8F25A4A510461FC409@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220908011035.17145-1-candice.li@amd.com>
In-Reply-To: <20220908011035.17145-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-08T01:58:38.1741542Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c487b83-73b1-4fea-7740-08da913daf08
x-ms-traffictypediagnostic: DM4PR12MB6278:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FkchZfurBi268bwaMLDy73+2XRvC/rNPaduSOsfbLoLHUeP0Ndwhjp7dN80jqb+NGooXkuZM2zUV8iKxVvDprfGBWUNjgMr1MLYSvxkszzHNypxFHC6PVEGJMrR41UUmma0nrljfPcthQ64zHkkddLBVImbMLJ2YJGNmVh/KqP0BXyhZDfXD8MlWcZ+V3cvGxalVIbYzHAan/nwztqpGocSrEgBbkTaSKT4b1QLwXcioq1hLsE8sqdeMMBuwFVBiH35HrjxxDEDAK8GeFNI3T8n3rOMs80HOWqB56cd+TueGmPRZrOW+70gpXCliUfL5nVE7jNpKUW114rtMAyRM1eH+jN/EKn638EGPsnfRaXl9fFYlJ5oQUXTuM5uKsqn/vuy8NkSm803zb+IWgjW2dgB22L3Ua1bYDAYuj9Dr/oGFZqxiNuMADOqjSQyBNBOexENb8juBbg8jVfn+stuY4zMuDWrZGH6N/bEvixCZ94RgaTjPZ7r1Cqi6BYt4HujCT61QGxHYHrMPn0qzWFh9vXHRz+ZTBv7iQjH7mv3QTTEP2Vdj45L3rlG1QDIkMxmaItgvUxZAngAT0zR0J8gEK9rXjq0XG5AC7ZyjlQfYUDzp1yPtgVDp0AVpMKOwFpXeYHcJ3J+RZySvPQCr8OoJjFUklXV+PTA5jqdPmSxLjjFKFHIIQu3xG7grXAY+ej9qDOk1ykkd+HES/HfHqKnwwg/pzVNoyRubPA/oUzccrfMgz8LPSomVLnluY2Zh+tkubXnTjbOKsa7UoSkU+v0IVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(86362001)(122000001)(38100700002)(38070700005)(66446008)(64756008)(8676002)(4326008)(76116006)(66476007)(66556008)(66946007)(91956017)(33656002)(83380400001)(478600001)(9686003)(7696005)(26005)(41300700001)(71200400001)(53546011)(316002)(110136005)(6506007)(55016003)(186003)(8936002)(5660300002)(2906002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GX1DBaVtTs44EzFRya/i8nc9URhacllRcvmhhYmMbq8aycTSKJYbp09om2PW?=
 =?us-ascii?Q?cfK1qWp+O5QlHuVzeotyO2C9twr8XggtCDXMr9WCLlGXPzhc8AownwZQ4vRH?=
 =?us-ascii?Q?HSNklMVoJ6pvNtiNMyCUbWAB1A5fcWpX5rJyH4lYyn1lW7Rr7JFgUU3hfP23?=
 =?us-ascii?Q?bS3o2/SrbgzUym5Rj41DHmmH6eOzF6U7OzG1QEQ+DU/QdrsmBHuynN4vCsF4?=
 =?us-ascii?Q?leAXDZGLiDLZe8GdgSA6IHgkUKlR1a4lBZPNSHZXVrRlX4OVMdqrWngXhLdl?=
 =?us-ascii?Q?FFYTuM6x+JSoBUPxQoYqRNkixJAkziXmPN2z8kV5AN2I9sK16TKqu33T4RGY?=
 =?us-ascii?Q?SWsc+HtAKSz7t0T8lzG7Kt15pf+MZ131p99Y0eGZzSZm+MxFkezc4BQ+kLki?=
 =?us-ascii?Q?tSL/F/0oyZUXucgSrQZfd7rAo40w19VxAfaFRlOdT1/Xa/b0diAQrdMwREMZ?=
 =?us-ascii?Q?nLIHm5A8s1wd0qLGeoUMZE6HJessrIrwp7E7/D/3NJSwnxkkksw0b6UMcVlh?=
 =?us-ascii?Q?raC0nr1zk9//+DkUvTmAwx1luSp+/EGo646SvfTVLj+8GQmnAdZ8b22DyGjm?=
 =?us-ascii?Q?Y0EV1O10TZjZZLSFzoXk6eQjadILikiu0M2500Eb7ZmqzTWgagGORrvTXKOt?=
 =?us-ascii?Q?rzIdy8owsc0GGLxpqHpA6f9GR/6j48CikfaQc2EjRqNxuy2BoAdfHF8gdcuX?=
 =?us-ascii?Q?OiUMwR43nVjQlGKQPV2OBI5ocimj5+3CQHfg7lNXiF2EN8ZdbzKHsYh69tnK?=
 =?us-ascii?Q?kWsyeF9JU862avLirLHmHBTG6u2oTtjQsYv5o9fZQVoOpiVx+TRyDhhKu9r5?=
 =?us-ascii?Q?DUk3suhyabZDO9UAWwsZpyLHMwCW1dsH17OXqVRcuJJHQvgHwXY6PeSpNG28?=
 =?us-ascii?Q?gJZNSYtX8O40USjWE1mnIxULjkRKKChrXiq0otoZ+GeczfNsuT43c/qE3v+q?=
 =?us-ascii?Q?XHLT7jKR+xgdONRLgoy50YzhOqIAZfNZlzT+M8+24wjM+TLwWs5qqB4zVOTk?=
 =?us-ascii?Q?mjhayTILa5xZdfT+5penNnEiVokFerEM+BCeoRuWcbDkaNWcpVNxKNFLZjq2?=
 =?us-ascii?Q?3r9ffzBZphu14feUFY5M13VVfNT+CvWO90RnQRgSoAQHdL22HGDK1bUNhvfA?=
 =?us-ascii?Q?R3dlhNM7PeqZFEPV5z8LpPGW3VJKSTgENW7uWuTqo0YltNQ6/t6B7vFLctPV?=
 =?us-ascii?Q?vmxIuOy6vStOBxdyC7s6+SZL2p1ciQNW1rr3vs1RWUrQW0yPUy3ys0siocvR?=
 =?us-ascii?Q?DrH10PnlnLPHJUjuJE2/phY3kI+tdfZA1ZoBWyiM+IbIYa+SkE2gP0C8/toi?=
 =?us-ascii?Q?iG1n6fa/aYm5UQTHZivjb4xOJNNutDPE0IPoGQ8BoApmQDzmDhywpuXeXwFy?=
 =?us-ascii?Q?L1GiJ3hcj9KohH+vEknuP3fTqLzWavaOYEP6BG/aGwA3ph8xU2DZXnDiuRZO?=
 =?us-ascii?Q?IQPklfm85jywUpQCR+EOWcb/FN+c59L8CJlF5ZZ9XNvrCZnEpAGBuAYct4CL?=
 =?us-ascii?Q?ehu4vsZc+qhWWrkgND1auBXD6ufcYI63QcBZ+JVqF7lA2WdwF2J1Y/I3XiIp?=
 =?us-ascii?Q?GPYrNDS5/qg/LzKs7v+f4d17/Ji/St9oFIo/tDdta8Jja+8p3APd7H+LuzcG?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257EB43ACC8F25A4A510461FC409BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c487b83-73b1-4fea-7740-08da913daf08
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 01:58:54.1634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9wKR7l5Xj7k+FQeNhSSpPpSGFwl2dpVtrXwJCcHi7wt+seevA6OUmGFMZkEbSUapLunHRATfyERgwjodL0tlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257EB43ACC8F25A4A510461FC409BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Candice =
Li <candice.li@amd.com>
Date: Thursday, September 8, 2022 at 09:13
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Enable full reset when RAS is supported on gc =
v11_0_0
Enable full reset for RAS supported configuration on gc v11_0_0.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index a26c5723c46e27..81f32d77c98cd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -421,6 +421,10 @@ static bool soc21_need_full_reset(struct amdgpu_device=
 *adev)
 {
         switch (adev->ip_versions[GC_HWIP][0]) {
         case IP_VERSION(11, 0, 0):
+               if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+                       return true;
+               else
+                       return false;
         case IP_VERSION(11, 0, 2):
                 return false;
         default:
--
2.17.1

--_000_BN9PR12MB5257EB43ACC8F25A4A510461FC409BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Candice Li &lt;candice.li@a=
md.com&gt;<br>
<b>Date: </b>Thursday, September 8, 2022 at 09:13<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: Enable full reset when RAS is supported=
 on gc v11_0_0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Enable full reset for RAS supported configuration on gc v11_0_0=
.<br>
<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++++<br>
&nbsp;1 file changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index a26c5723c46e27..81f32d77c98cd5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -421,6 +421,10 @@ static bool soc21_need_full_reset(struct amdgpu_device=
 *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[GC_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-- <br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257EB43ACC8F25A4A510461FC409BN9PR12MB5257namp_--
