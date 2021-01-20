Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A27C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 04:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A3523121
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 04:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A3523121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7E989F07;
	Wed, 20 Jan 2021 04:10:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69D089F07
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 04:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf1SgJYffUVeep7bNmHp018IX0BqTMswuUUrHI5D+a2MzMlJn7yMnvt48gzmAF4Bk4ux2Ro2/zWkGbjseQTAI4bVzlyAyBOsiWAA2uU9V89pIme6ghIv5C4EUa3SPk4gBv3vl26dKIR2vYVZS/QkF5xYJs3l0FjhMXFdOio8g/vHQLWsey2IDiyWLfw5/6a00B87QW4cfhR0SEmc4/+8WWhE43n9feEIymgy2XKZnA7ykr2C5ZfN6NvAGCXCwpTtjt+cs5uAL/LWtkqdQeClKnmiT1Cx8wxXl5asxUwGbnDchZ/OV/96UTu1hMHqHVsMjVmo/37lWTrcPCluC7r1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubnu3SL7R12ELdN07cSTrISw7Lc3C53ZH2HpzOBHzyE=;
 b=S8QhRi63/ZK4jFCfUtonGJY2xs5ZoWN8w1tRISA3n6ZOBVSLj/Dy/XKt1sGlqejARFi1JAQgdA3OTLOrPVcCVm1PtMxaVYfGomdPe8nVb9aErmV0mwRgfuWLfwYSA+PE8ywAGKCtIkzr1F7nhj9GO298pa8/RoQn2LCcbu4a1CsIDj0eeu+MKgYbzMZy+Fr8QiF1TlsU1C5O9CLV3FSHpUQatwHNInOtSe5Dm2y574W9K8VKxDqdzbiXdBkQT3PpAAcU4xApOyrii47Q40H8A8E18eTNihzicEWeIzvYef9ulxU7+f6VCgL90pZ+jqPrtkbRv/3dLKZwa6Id9LeqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubnu3SL7R12ELdN07cSTrISw7Lc3C53ZH2HpzOBHzyE=;
 b=TLSFHbAE/0eOTZ67BN4IHylbzNiZPbJLtSKv94eMmi4DSjT9oaHcJCldOzmMqcJ4+MzaWcig7SQk8bj0AuEPdVhb6lm8eLRm80bpxCLCZrfVY/PrrWLQINHunbKEM1N2Sm2KbQLcXcEWWU29DqSlK/VNq32YJ5J/GtKC/Wwtbf4=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3440.namprd12.prod.outlook.com (2603:10b6:208:d0::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Wed, 20 Jan
 2021 04:10:05 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 04:10:05 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: make the error log more clear for fine grain
 tuning function
Thread-Topic: [PATCH] drm/amd/pm: make the error log more clear for fine grain
 tuning function
Thread-Index: AQHW7t8VR6rBx2lk/0WnCdCvinoRZKov5B86
Date: Wed, 20 Jan 2021 04:10:05 +0000
Message-ID: <MN2PR12MB3022DF9FACBC945BA0E7750CA2A20@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210120034821.15400-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210120034821.15400-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-20T04:10:04.853Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed6f6f99-ea0f-412d-725c-08d8bcf94477
x-ms-traffictypediagnostic: MN2PR12MB3440:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB34405AAB4286EB158904A635A2A20@MN2PR12MB3440.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WppC2tUJKT2PreKihOBHv3krpOQM2gvxwgKJbk3tG6txw5YGtWxyz9rOzG5UvriZUrlFHnBj9fTjHoJ+UdZUN6rzyYA8ydpgAFGXfh7yXVe0W5zQ8Aq+8/JhG7J5dg2lSHTNHTDmoNC0OiFlBF3zXfrmD8WIB482ECFLnM9loHPiPVc+JB/3SEaCLuMZ18TD0h5n8jLa8lJGruax7o4i+F82PMDWLaxnlblTDxoDN7sRu6hZBvhxJd5o0MQ1GCy4vsQSCpVEkOPp8QDM/qA2UVy+0ZSAl+Mebj0dhq+cJQTyBVWM6doTOFdHGnFFLKML5fY2qnfj1E/hTyuAgFNIDghtrzYuYPngYteBLWhyJsMRdXnipvTafrTTqKQs4GY9NsWV8lmsS6bMAa6gGOBm5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(7696005)(8936002)(53546011)(110136005)(8676002)(86362001)(19627405001)(33656002)(55016002)(71200400001)(2906002)(9686003)(66556008)(6506007)(64756008)(66476007)(54906003)(83380400001)(76116006)(316002)(91956017)(26005)(186003)(52536014)(5660300002)(66446008)(66946007)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?wgWF0ByaG8i1FWRufKeSka3ep4zbVCAJ2SyV8sHVeJKvihor7LVXtLJlMA?=
 =?iso-8859-1?Q?7ipfbp/w8oT4ZJHfmfUd5aC5y7VWZ2lUVTqGoj806YWDhD+eXT/MOoENWj?=
 =?iso-8859-1?Q?sURE5I8oUPEv0XZYui2eRWWXru0NbavlgPHSn4AfrJHxwRvj9IvFOZRFnW?=
 =?iso-8859-1?Q?GgT0Mf9cuwBiB14xEb8fruEP9oM7dfNNYU4uXJb8laC6FImR+09fvjsXWG?=
 =?iso-8859-1?Q?os8s9qjDmRjJWt7lm4xT+9zgmAC7owSz/eEGikPIqxL5ttjiajJDF1MjBB?=
 =?iso-8859-1?Q?jq79eQzJLGyy3BZooaAmGKd6Q+XM2118/Fg+ak7Xqf9FTd1gaxz1Ofjt7s?=
 =?iso-8859-1?Q?OvfvlRgXEEqlzkbgDlS/oEUHtvdztgx2J1JbXbF77TDY7NDki9GfV46QFp?=
 =?iso-8859-1?Q?bODPgGIcJMwdr+GdB+TzZU1sjpWcvGTafRNxbu/PZw/hvPbnxMZl1P+6Vz?=
 =?iso-8859-1?Q?WkQKAzbgDNTRFkUQGbAXMY+yf92Udj4Q8wuir2gvocEoYGD5uE0c3jZPu+?=
 =?iso-8859-1?Q?8eTdzuJ7wEChtjUgNAkWnqguL/AC2fz3S5A8cbw/6QDntbHOpYWLH2Qi45?=
 =?iso-8859-1?Q?ODX0jkMmAKcGDKIoRns852XmtOv9NVPpFd+pRi6V98uuTjTLa++BM/Bm4N?=
 =?iso-8859-1?Q?iS6SX7bajj8Q55jmJ94+yqH79+Wg5INb5pFS1IP3OIgSIjQfBkAWMfs6fX?=
 =?iso-8859-1?Q?D4KyXTAF2Eab7ov2OgeMpBPU3HPBzMrL3fwt7nZMm0Wa5twL0BOo9brcop?=
 =?iso-8859-1?Q?g1ImER6o1n3Sa5LkXTNQ+T1Uf/bBx/7S7MLzDlaJ+4YTUItp17hiAqmoq7?=
 =?iso-8859-1?Q?el2lDCaUQBB7RztuL2kwSt6rdQFwMqVs2gU0712NgE2YhRbtOiof/HgWUT?=
 =?iso-8859-1?Q?lGg/io1rSVIVfF/Pkm8q7S6a+HNiEyEGXwA8JdBxqGqcbaK0z8aD0RX/op?=
 =?iso-8859-1?Q?hPEV6qQjlUW8B/xoAEbwGBSaOLq/Eywr5LOBzP6rfXnUv3RWmkEvCedCxL?=
 =?iso-8859-1?Q?ILNALCCUlBcoz0q4E=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6f6f99-ea0f-412d-725c-08d8bcf94477
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 04:10:05.3263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ceik+4OBtcrtI1LxmO13cZ3U9kBtKXEHXQvaLpxEu1kJPk5vo4uTMPI9Ub7pQOl7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3440
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============1915370751=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1915370751==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022DF9FACBC945BA0E7750CA2A20MN2PR12MB3022namp_"

--_000_MN2PR12MB3022DF9FACBC945BA0E7750CA2A20MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


________________________________
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Wednesday, January 20, 2021 11:48 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang, K=
evin(Yang) <Kevin1.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Du, Xia=
ojian <Xiaojian.Du@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amd/pm: make the error log more clear for fine grain t=
uning function

From: Xiaojian Du <xiaojian.du@amd.com>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to make the error log more clear for fine grian tuning
function, it covers Raven/Raven2/Picasso/Renoir/Vangogh.
The fine grain tuning function uses the sysfs file -- pp_od_clk_voltage,
but only when another sysfs file -- power_dpm_force_performance_level is
switched to "manual" mode, it is allowd to access "pp_od_clk_voltage".

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c     | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c      | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 88322781e447..ed05a30d1139 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwm=
gr *hwmgr,
         }

         if (!smu10_data->fine_grain_enabled) {
-               pr_err("Fine grain not started\n");
+               pr_err("pp_od_clk_voltage is not accessible if power_dpm_fo=
rce_perfomance_level is not in manual mode!\n");
[kevin]:
for above codes, the old one looks better for me, i prefer to keep current =
design.

Best Regards,
Kevin
                 return -EINVAL;
         }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6d3c556dbe6b..a847fa66797e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1452,7 +1452,8 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

         if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) =
{
-               dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+               dev_warn(smu->adev->dev,
+                       "pp_od_clk_voltage is not accessible if power_dpm_f=
orce_perfomance_level is not in manual mode!\n");
                 return -EINVAL;
         }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ab15570305f7..4ce8fb1d5ce9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -350,7 +350,8 @@ static int renoir_od_edit_dpm_table(struct smu_context =
*smu,
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

         if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) =
{
-               dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+               dev_warn(smu->adev->dev,
+                       "pp_od_clk_voltage is not accessible if power_dpm_f=
orce_perfomance_level is not in manual mode!\n");
                 return -EINVAL;
[Kevin]:
Just tell the User what's going on, not why.
and we'd better make a function to check manual mode , then embed it to eve=
ry sysfs node in amdgpu_pm.c
using a unify interface to return result to user.

Best Regards,
Kevin
         }

--
2.17.1


--_000_MN2PR12MB3022DF9FACBC945BA0E7750CA2A20MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
: 12pt; color: rgb(0, 0, 0);">
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Du, Xiaojian &lt;Xiao=
jian.Du@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 20, 2021 11:48 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Lazar, Lijo &lt;=
Lijo.Lazar@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.Du@amd.com&gt;; Du, Xiaoj=
ian &lt;Xiaojian.Du@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: make the error log more clear for fine =
grain tuning function</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Xiaojian Du &lt;xiaojian.du@amd.com&gt;<br>
<br>
From: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
<br>
This patch is to make the error log more clear for fine grian tuning<br>
function, it covers Raven/Raven2/Picasso/Renoir/Vangogh.<br>
The fine grain tuning function uses the sysfs file -- pp_od_clk_voltage,<br=
>
but only when another sysfs file -- power_dpm_force_performance_level is<br=
>
switched to &quot;manual&quot; mode, it is allowd to access &quot;pp_od_clk=
_voltage&quot;.<br>
<br>
Signed-off-by: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp;&nbsp;&nbsp;&nb=
sp; | 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 3 ++-<br>
&nbsp;3 files changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
index 88322781e447..ed05a30d1139 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwm=
gr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu10_data-&gt;fine_g=
rain_enabled) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;Fine grain not started\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;pp_od_clk_voltage is not accessible if power_dpm_fo=
rce_perfomance_level is not in manual mode!\n&quot;);</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">for above codes, the old one looks better for me, =
i prefer to keep current design.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Best Regards,</div>
<div class=3D"PlainText">Kevin<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 6d3c556dbe6b..a847fa66797e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -1452,7 +1452,8 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;Fine grain is not enabled!\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od_clk_=
voltage is not accessible if power_dpm_force_perfomance_level is not in man=
ual mode!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
index ab15570305f7..4ce8fb1d5ce9 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
@@ -350,7 +350,8 @@ static int renoir_od_edit_dpm_table(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;Fine grain is not enabled!\=
n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od_clk_=
voltage is not accessible if power_dpm_force_perfomance_level is not in man=
ual mode!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;</div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;segoe ui&quot;, =
&quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-syst=
em, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; fon=
t-size: 11pt; color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">=
[Kevin]:</span></div>
<div class=3D"PlainText"></div>
<span style=3D"color: rgb(50, 49, 48); font-family: &quot;segoe ui&quot;, &=
quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-syste=
m, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; font=
-size: 11pt; text-align: justify; background-color: rgba(0, 0, 0, 0); displ=
ay: inline !important;">Just
 tell the User what's going on, not why.</span></span></font></div>
<div class=3D"BodyFragment">
<div style=3D"text-align: justify;"><font face=3D"segoe ui, segoe ui web (w=
est european), segoe ui, -apple-system, blinkmacsystemfont, roboto, helveti=
ca neue, sans-serif"><span style=3D"font-size: 14.6667px;">and we'd better =
make a function to check manual mode ,
 the</span><span style=3D"font-size: 11pt; font-family: &quot;segoe ui&quot=
;, &quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-s=
ystem, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; =
color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">n
</span><span style=3D"font-size: 14.6667px;"><span style=3D"color: rgb(50, =
49, 48); font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west europe=
an)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, roboto,=
 &quot;helvetica neue&quot;, sans-serif; font-size: 11pt; background-color:=
 rgba(0, 0, 0, 0); display: inline !important;">embed</span></span><span st=
yle=3D"font-size: 11pt; font-family: &quot;segoe ui&quot;, &quot;segoe ui w=
eb (west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsyst=
emfont, roboto, &quot;helvetica neue&quot;, sans-serif; color: rgb(50, 49, =
48); background-color: rgba(0, 0, 0, 0);">
 it t</span><span style=3D"font-size: 14.6667px;">o every sysfs node in amd=
gpu_pm.c</span></font></div>
<div style=3D"text-align: justify;"><span style=3D"font-size: 14.6667px;">u=
sing a unify interface to return result to user.</span></div>
<font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Best Regards,</div>
<div class=3D"PlainText">Kevin<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022DF9FACBC945BA0E7750CA2A20MN2PR12MB3022namp_--

--===============1915370751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1915370751==--
