Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C66C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 13:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A95E10E57C;
	Thu, 27 Jul 2023 13:29:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED6110E57C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 13:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLPlgrlz2DWAPUC3kzUkilojX2b5OJl6cEOP5e4czzwBZh3zgg7clyTF18yNXtCmzoN0/ZzhYtl0+mNgGOrUeHzdL5+aTGH+IQareBl9DiVopnFHP+nNmeJFLKJo4m+K1h0BkMzIOvfPaA74R9tg1sAjtLJwcgcvdaMox0TbrQOOO7IULu8paZ+Eu6JQ2ABKoxhPU27nfNMPIAcny9Y0uwT3vqCBswPFcWrwnAVzkspyTrh04IE8ZfjcJQmGnOrumlz7mv8ZvoMZfu2iNEw6tBhPs7IeVDy1V6X1swkoYLK0CiCDOo9UAHqe6X8rDR/Rrm9NsfB9e0R/kFQ44U1ngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrQQC+ma/0wDCLdoMByLXV0opb9fJQO63wGNVP2W+VQ=;
 b=SwbHRpnjZp+19YzWPwBgIk8CIT+gPSVhzDAVkZOq6luFO1AjaM70Zb9L86KFV/wgpbxfd0ReSB78OX6DEtv4ES0OlcIrkGfPka9ovPKKgkbnLKyVYIsLUPueY6lajr5Tyv53MnvqUA5yg+LklsSWmrvKvDqF9vbGxVddCEwGHy+ww8RQR1oNYWkpWz3VWMy3OYT4NJipX36PUS+0KR9gpN45UCevbXkfeGGQSoIofAdOqIx/bwBNb2jFv3ykQiRf5M3bnp2V0dlLtmPSbSi0kS++QfIWeS5jHm1oex+UvtGjFYQa4xuDRk/xi1YVlGdqkIOaypU9jV6VRluCYay8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrQQC+ma/0wDCLdoMByLXV0opb9fJQO63wGNVP2W+VQ=;
 b=mBz8bNG+fbnM2AKYfQEoS4xEJmF/LeiWsHCfPLq4WcXIdXO/8KD/HB/hkvn0cBshQjaUmRos1UdbN7dWfJGxow9+ep7i2b1rMPsifxnRR4uvwsydZxFnsCggUDAkvFfhXyVdHznSA3NVCd+a6rDl9X1M8vfUCewEes43ztObVbI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 13:29:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::bcfa:7757:68bd:f905%5]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 13:29:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0
Thread-Topic: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0
Thread-Index: AQHZwH9wx8nRCOBsQUGscXKP5eit5K/Nm8sK
Date: Thu, 27 Jul 2023 13:29:53 +0000
Message-ID: <BL1PR12MB5144B27DEB701CD55D1F3136F701A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230727114125.3891244-1-kenneth.feng@amd.com>
In-Reply-To: <20230727114125.3891244-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-27T13:29:53.220Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BN9PR12MB5036:EE_
x-ms-office365-filtering-correlation-id: bf2ebd41-7176-4cfe-7158-08db8ea59007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYxXlAH5aJ6uINTcfymFzuJ/bhLyJb05TbGBbmMzsqNEKL8Yha10uaGGwCAe2O0V4gNR9ZVsf3bCzlFBgl+YtG4iY84MpDZ58gnXkesFmQDX1817lULR5BmEbo5jaCNVFe5ApFBjW4lN9/FmcFkg/be3J2U5zj0DNHIe0Lm5+S9v/XtFi+qdRKWYnarJCD7NGaIuBNrLWphWab6zmudEeoMn0p0xPulYnYVosfQNlsLEcricN0hUcNy7JVeeLJNnYv67f0CoZIl2YBU4MIvzNk2gCPKqaZdFEriZII3neYFkQVqziKnR0PX55uz6Vt/tzbupN3ttgagDhxeFQ98HN+4R2Q6UafNEeBGXGZacBSC4+IDbihNVl+gaAo4pMXXhZh+UMbgLWW4Zpj51YB5OKapVC35nOQgC9oQF78IfZAk+eJCOFCfXVxUhsn7TquheT9Ao5OwAadGq8EcIEL1RCoEuqdMyQ81BqBbj8pNL4qy5wYksXZcKE5LTOLfnf1pJ675mlELwVZ/qu2XEQqZeTlUujVJ4H291GotcVhkeXZ2YQu6sAo30g+Kx43f0YN7R/9RwXt6wPJc138zEBvyiqwbCsfpMUwI75lYzFMCfdI8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(19627405001)(41300700001)(26005)(53546011)(71200400001)(38100700002)(122000001)(478600001)(9686003)(86362001)(4326008)(8936002)(8676002)(76116006)(186003)(316002)(66446008)(66556008)(66476007)(66946007)(33656002)(64756008)(6506007)(5660300002)(2906002)(110136005)(83380400001)(52536014)(38070700005)(55016003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nu6K3c8dfEzGQoIJNdnnlu6Y6aLVWBU42kk41amdt2bUyb0UsgtQzBIi11IG?=
 =?us-ascii?Q?8vx9jfbaay1yZcERgB3ylDsQ1hs6O2Igxwt0q8hZdY/EiypxK6NkrfivrD9D?=
 =?us-ascii?Q?ONu+GCcn7buNCbh7K7IXJvoDck3TcgPsbvvE8edzg5cLgaYiSlqXzTLxOcRL?=
 =?us-ascii?Q?SMd+KebePAwvK8fxEcanUz6zLmkZ4OgornDQFq88hc5R5XHFFv1EP1Tvash9?=
 =?us-ascii?Q?/ZcEMnFzxE1sDjlQJKtzMfEup2mkWay4+MeMaQNgr/W/95uc9xw/i+3mmi6o?=
 =?us-ascii?Q?SDOW2mR/VMvN37nK5z7WixetY9aRxJ2LCz+G7nTMnjelwDkNA864BOfOxhgu?=
 =?us-ascii?Q?JxuEgs1efBj3prdxL0095xz144bC7mhkLvkM0Lm4/nr7d7BOhfSeYcYHJ//4?=
 =?us-ascii?Q?tzYXM8N50hCb10Q6dnvQSFTZzSR8LexbkXZSjVVy48aPJeGqNaSmdzL9aT6i?=
 =?us-ascii?Q?XotoMznXrooTkx5FNkl+lJjUIcVVnvcwC/OiewSBsy6/ewaKyU399b0iXXBU?=
 =?us-ascii?Q?YsaQ3Z8862XQHzM1Yi82XK9YLEde1Lh32l2JWiwVWoQf4ex9kir27aBkaFNr?=
 =?us-ascii?Q?WoplmM9wYggl8Ec1tw+XJ9/txUKIfx92axcWTlvOoQy+r4cda7Xm2P0soKqo?=
 =?us-ascii?Q?UngATTIe9gzejDmF65qCmUUK8RwxHYJ2TLhLQAAschkL1fTNDI5m3bk69Fb3?=
 =?us-ascii?Q?XgP7Jz5LmkOL2cFF4ywX3UZOvTKJ36OMSPH6vllosDQnM2YT8gBYgR84QhSD?=
 =?us-ascii?Q?6ZbPcfnJboi+iSb+kRjPEjmdfAzW8eJdCVRIScjs0iPHenzcEx58ryiE2Peu?=
 =?us-ascii?Q?ofahEjjySqlW4+X45uMlH9ZrTd79h5s+ydlPV0KaeoIIe3+LpSSP7/k9MgHw?=
 =?us-ascii?Q?bUKKCIfLT5yxUH62N1e2FETQFzJir7DtLGrHrZAD/eCN9BkjD8koXuO8DWyi?=
 =?us-ascii?Q?PIyJDZlIGXRQ32c9XnUAFPgoGGTMnpPuMqzjJtQO3F9p2J/h2HEgqkEfa/5u?=
 =?us-ascii?Q?4Qd8+n3tV5EoQ673ArU2xmKl8luKl0I8g+42FqXqFzkCONcntgb/Re9XrNlt?=
 =?us-ascii?Q?oifR3UhHU/gpPaWeUQY5Hv00JBmi/M3qxOKeNgBRJE+LagpwjpBn81OLIyWK?=
 =?us-ascii?Q?DZ+AsLxE42gs+a08kSZ8O0PYM3YVquqcbUZjiwYhG9vqZdlaAdrS81ScUy1x?=
 =?us-ascii?Q?AdKxuhimWY5S/8BSo9Zd0mbGDXoyhzPtAP7DwQX0lqAYfjF6i7uIyuqSzZVa?=
 =?us-ascii?Q?qbHzh6gi8h9rjbL2KjONp3NZ3toLPBxfJlTC3tuEMDbFYKPNdpNKRWM255q6?=
 =?us-ascii?Q?NixGfxC4eTb9WwRcSp6gOX7I5L8WoqwngGA0IMY0iaSIBBNLtZcXlzkYvKkj?=
 =?us-ascii?Q?otQif+K28AMoYWVkdFQSD5jgCdETDCfnGXaseP+kjfw0uhJtehD7bG4qAKpO?=
 =?us-ascii?Q?HCZx45rOOxZxnX6aysAgCZYxycLRZZ1zi7BjRykyFcFlay+54HNqd3/uBCgL?=
 =?us-ascii?Q?yed1CbiOvl0ukveqYyF1/ghXZuMXTnvuK9tvGgVa6Zp3bPPn8LPP5tqzT/nI?=
 =?us-ascii?Q?xXKumNgxH8s9S4oNYG0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B27DEB701CD55D1F3136F701ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2ebd41-7176-4cfe-7158-08db8ea59007
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 13:29:53.9927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIDPtuhoFQAwLm4UjoNVBNyuruO4QkEPpCJv/VV0YttVhR+/YMsfq0SLlY/9SQjzf0Cimm5Ogol+lYUUZ/k99g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144B27DEB701CD55D1F3136F701ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Thursday, July 27, 2023 7:41 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0

correct the pcie width value in pp_dpm_pcie for smu 13.0.0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 232274423f9e..4bdbd3910e1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1140,7 +1140,6 @@ static int smu_v13_0_0_print_clk_levels(struct smu_co=
ntext *smu,
                 (OverDriveTableExternal_t *)smu->smu_table.overdrive_table=
;
         struct smu_13_0_dpm_table *single_dpm_table;
         struct smu_13_0_pcie_table *pcie_table;
-       const int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};
         uint32_t gen_speed, lane_width;
         int i, curr_freq, size =3D 0;
         int32_t min_value, max_value;
@@ -1256,7 +1255,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_co=
ntext *smu,
                                         (pcie_table->pcie_lane[i] =3D=3D 6=
) ? "x16" : "",
                                         pcie_table->clk_freq[i],
                                         (gen_speed =3D=3D DECODE_GEN_SPEED=
(pcie_table->pcie_gen[i])) &&
-                                       (lane_width =3D=3D DECODE_LANE_WIDT=
H(link_width[pcie_table->pcie_lane[i]])) ?
+                                       (lane_width =3D=3D DECODE_LANE_WIDT=
H(pcie_table->pcie_lane[i])) ?
                                         "*" : "");
                 break;

--
2.34.1


--_000_BL1PR12MB5144B27DEB701CD55D1F3136F701ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
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
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 27, 2023 7:41 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Feng, Kenneth &lt;Kenneth.=
Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">correct the pcie width value in pp_dpm_pcie for sm=
u 13.0.0<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 232274423f9e..4bdbd3910e1f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -1140,7 +1140,6 @@ static int smu_v13_0_0_print_clk_levels(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (OverDriveTableExternal_t *)smu-&gt;smu_table.overdri=
ve_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_dpm_table =
*single_dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_pcie_table=
 *pcie_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const int link_width[] =3D {0, 1, 2, =
4, 8, 12, 16};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gen_speed, lane_w=
idth;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, curr_freq, size =3D=
 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t min_value, max_val=
ue;<br>
@@ -1256,7 +1255,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (pcie_table-&gt;pcie_lane[i] =3D=3D 6) ? &quot;x16&quot; : =
&quot;&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_table-&gt;clk_freq[i],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (gen_speed =3D=3D DECODE_GEN_SPEED(pcie_table-&gt;pcie_gen[=
i])) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D DECODE_LANE_WIDTH(link_width[pcie_table-&gt;pcie_la=
ne[i]])) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D DECODE_LANE_WIDTH(pcie_table-&gt;pcie_lane[i])) ?<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;*&quot; : &quot;&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B27DEB701CD55D1F3136F701ABL1PR12MB5144namp_--
