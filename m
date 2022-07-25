Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2967FC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 18:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC8C28BB32;
	Mon, 25 Jul 2022 18:36:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44708FE15
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 18:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caDokncDHrYpegKNB0XMbahektpx1OsUpG7lnVkBWguITBHzMtJzeV7ILRM7rkRqxdbWdwVfTNo2nuH99uF91i/5oGI8dt7/gpHjnC24dHd/8C/vHoROZ46p2wMbkJXynrn7yxiYWq9pzqvWQqPfSFI+CC6FPjOqrezw0AE1/D72iHWNRdlEQ82THRhVWI2jmV+nu4geNY3c9VZ0PxHSNwiAeL+/9YX/5uSsJJqhsVILK/CgBnm2550TsxVDCQ52sVNakJf4IQmYGmelEJ+tHp1Il47UTN3+fb+x2SJj50zcGOqBJouGzgD4IIRNIeHo5N3h/oW+sn38VChBKg48cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EeINOo8WoUvAyHspbd4zehO8y4K7uYsIhQMYBfBrCw=;
 b=SkY8+92psM3j2G/VAMet09YxSaviWXIOeeMke9F1MEUmpnQtfjnKJ1Ack0VaaQW6gZxc6QRdPlhd8rIYgGLUfpRicWH218W/oyHFe9oXMtzc2Hra31RZBH5OoTBS8nsqFLsjoBdwD87FgkwfI/gInM5SVZTSaQCPlwX8RFi17ynZ4uuqZTiHDjKwxbiiRrSx6edklvCrGG8HLFg4Nq3oarkL8/WXSIxi3cnsxZT8FsA179D+YFYX3J3KIx88t2pn+9mdSAix9d3WCyEVs/Hm3A8bF6CJ+ReFXiHFUbF0vPkyHxwYet3RD785Wm/O/ayPwuiZmiRe1Y5aLHyIiLc25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EeINOo8WoUvAyHspbd4zehO8y4K7uYsIhQMYBfBrCw=;
 b=uYJVJ1Ok2DDWyvi3ndPDvCjR1OT/fA2QwGU5n27d1V0UxGKpRPEzPdWgHavHdwBTW2Ymn09ToRNZoX2P9ReJNvEEA9/Uja/mDANCLkmocgEmN/7L3lHD6SZPOzligabEJyysCmek9GmsdbZqak0ArHVffiUTazSSdW1XVI+GRdY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN8PR12MB3635.namprd12.prod.outlook.com (2603:10b6:408:46::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 18:36:40 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 18:36:40 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm for consistency
Thread-Topic: [PATCH] drm/amdgpu: use adev_to_drm for consistency
Thread-Index: AQHYn+5/fXaNMm57qUuAPsb9pVOJ0q2PavZQ
Date: Mon, 25 Jul 2022 18:36:40 +0000
Message-ID: <BL1PR12MB514494BD0E3FFF8BE5B1CCB5F7959@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220725061830.26989-1-guchun.chen@amd.com>
In-Reply-To: <20220725061830.26989-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-25T18:36:39.664Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3181557-e99a-4632-2d58-08da6e6c9d4e
x-ms-traffictypediagnostic: BN8PR12MB3635:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Vq/HS9ZVG6INlIelUdLC8nzp5HNC/IqQOKXlHFjIuL5Lgo+UN4Tktj6VXsOUgCi+H7G2hTV6lQaiM2dEWs/9AEjGX3aniHYttta1V3K+fnctEfuAwaTNLEXetj0XCPN4pV5JY4O0buiqYcCPm4Y6XO6QOnK30UxAXik5TEhoIEs2VcFWtjFV3SrlWo9uPalj58PlMXYDaN+msTQeJIWfWGKgMXtcZ6RONo3C53QdljFHjnJ+/ur+vtit2SUAlYYLmMUNZvHMB9GXe1I/a0SuyOtvvK5h3mPv3ybFiXNV69m4P7Rf+0nINwJ0/xXsa5ehH74QLhAy17h55W6bAsezlW6ovkKDDnH1O7s4DBYbxhZDDeLHdgS1HWBpMIKIMGA+ClF6AZDl6P5R1qhGBkzWH1i+o4kEyXkR1CqVF1amlaSjhAEN6KJad4nTgFM+/uNDz+MFliEnIEL3UyKy8m4+M+WGGejAIBovMZGN6Heq0gtMwo2OuRYvWy7UblIs50FFlA7EY/FSo92d1HFl4wMuiyylWY4Rj+3betYTeuWWX49ZUVMAMTdyLrwTk0imKLdfdyV6fcGQ3DkVZRe5rmep+4gsdPr4WtBBl90MC+fFjYpDV3VzY6jdYgPa1qzVZ2wWf3/0HCoxRgJ11+2TuNqn3caSPK8Rbmz8XWfN44Zy3jeWHaTHET97yYcvcdB0kLmgv1y7C0v6oAc/cAyJS6KVeBILiEDy1fnWeDng9WLEOwUlTkYQkEU3unT4AzsYkgZtoZoPdOoPQF47TucJAw+mea/o7kp/eeRXU3f0P7I6Ds=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(122000001)(55016003)(6636002)(19627405001)(38100700002)(316002)(110136005)(38070700005)(83380400001)(186003)(5660300002)(478600001)(8936002)(41300700001)(33656002)(71200400001)(64756008)(86362001)(66556008)(66446008)(8676002)(66476007)(9686003)(26005)(76116006)(66946007)(53546011)(2906002)(6506007)(52536014)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dKJRbv3cU3/tkRYEbY+KgbRK7kBZKzk539fAojNKSEtXgmDG+ihGQzE89Brg?=
 =?us-ascii?Q?6ALSsocH9zgQxcU6JFLyVO4zxyTnlPkBiTGxQrXW7J5Y8ud+KkcldTL6wNDZ?=
 =?us-ascii?Q?YMHb4HTym/t5w704tUFGDQ5Mo6suhrmxcRCsCbO89cXYdPMyh8TMMlGTVTPD?=
 =?us-ascii?Q?CkFALQLHmWP1UlVnr9m3Vq6qHir7OGI2yozTeQZarGiTEaUZo7bjl5Tl5ZIP?=
 =?us-ascii?Q?LzbVVoc80aKMQ4UvIRz5DGx+KXd3Ghzlotgd5igDo5WkryOZKg1k9EpPWwdt?=
 =?us-ascii?Q?4Mj69KINU4az3wO+wcgZxas5lA8sUmRS8azy74f9eHhlVFJSY06qWVHVVvlv?=
 =?us-ascii?Q?IOt9kxaMTUEi3+9BMfaYfj2l+UIRsO1Ngon9tOh2GK/WJnlH03SnL34h2Lx3?=
 =?us-ascii?Q?d4Fll4QoOFOPoKtGpPcJMdq2ly3570r+8RhWhN4T48IqKHYoeMua2rJvJSmx?=
 =?us-ascii?Q?SQdyth30vp4WYaDRHk9BIzeS/83+QVaAq6WHmCJbdvWXs6dTE9WlN36hYtB0?=
 =?us-ascii?Q?HvKtHGcJe6Hwi/SWc6/tv1ENHOyyTjnu8+BLCMe+QWC3S9Pzfv9Zy0WjMFmK?=
 =?us-ascii?Q?L4E33VjVKRMXrwoj5pWlpEoaVgCTWuIPIaLqq1IvNsnGJVjLnHjZYUHaCcaD?=
 =?us-ascii?Q?LotR0pjz6MkeFPS6epw6YpLRPnHEJO1BsakjKJWLpLCLvf3z6FO3Z2VbqNwu?=
 =?us-ascii?Q?CXij3Hn1egXu2P68LthVGhHuOUOkfN3/fgZT/Y9gXDteqibenEhgq+1JioFt?=
 =?us-ascii?Q?N0Cgerl5wc87r8SzpGY0NEsckvDyrJvPX5ZlkFzmN/Io+/1XUGjUcTRWqQC1?=
 =?us-ascii?Q?WqO4nWkrWH67kpgn2IQJYCAbFDe1g1XGNWV9uqyMpZCYc8AbgCePVlKZVgLN?=
 =?us-ascii?Q?Hl/bXcskgRpV26ZAphlTQIL6pbELQaS3TQGFR9JxszPmNvF1GeU+ExuFhQH2?=
 =?us-ascii?Q?qfKDOxqPH684ILaeBQ5c1qMnpUkSyD5tnt8s4oUcf+0kw9LoZWUBcz4R8bHV?=
 =?us-ascii?Q?C+UqvxnpFc9ZLqtqzfkthSVO7CkvejDqds6Do8vrbgRhTsPRq6K7lbi40ZhX?=
 =?us-ascii?Q?Ki8cAWomlT9LNWNiOmkgLrpFkmiTpGy4ZJa0nM8siI+tc3xJj1e0edaBnGUn?=
 =?us-ascii?Q?wO9JJqeJ9/Jl30Jy9tFAymbOtFQ7PhvsAoqgMYiD/f7Q3G1lGqJyVSuUat5K?=
 =?us-ascii?Q?AmtVCcwsE/Z1Ew3uQGMsduECWD2upe5r1zkH0dpp4+urxaXhdil4mIvdpNs/?=
 =?us-ascii?Q?OFsCeld0I84k1+wHQvkarkd5zF6K3A4T6q9p3DpVxOXvjdIKMkcWVJF+dkyZ?=
 =?us-ascii?Q?+F9L+PaHVIVaGqWgnCiM148UXKU6JgPLdwiTeve6aeQ8amGlypCLHYchWiwM?=
 =?us-ascii?Q?ccml1wu7YczzZEvH5Tm8s7NOkxmsZE5kKRV84TTmkQ5P+mHcGCi7MUDUBYyG?=
 =?us-ascii?Q?PeVXLbch/pk6zwQ9NadHnAbts9DKABhPWFHfRnA+EiMg+/3GjCfdPdShXxJX?=
 =?us-ascii?Q?PiOaAEjm+4VVRk6/p3sh98/NXi5Qutckdom9KOWWgXgjQaem+/23b/jLqZZg?=
 =?us-ascii?Q?BcMytSHBFYOu7D+s87A=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514494BD0E3FFF8BE5B1CCB5F7959BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3181557-e99a-4632-2d58-08da6e6c9d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 18:36:40.0859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: st57H0sNuiTW3Gwu0F/zeOpKEiAiwAgNWhYpKsabfiJLZC24oiTTCBwHlANR6tfBGFmuih5w6WdJEfu4MEoe8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3635
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

--_000_BL1PR12MB514494BD0E3FFF8BE5B1CCB5F7959BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Guchun C=
hen <guchun.chen@amd.com>
Sent: Monday, July 25, 2022 2:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@=
amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: use adev_to_drm for consistency

Keep code consistency when accessing drm_device from amdgpu driver.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index 84ac2401895a..698a59ec3dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -150,7 +150,7 @@ static int vcn_v4_0_sw_fini(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         int i, r, idx;

-       if (drm_dev_enter(&adev->ddev, &idx)) {
+       if (drm_dev_enter(adev_to_drm(adev), &idx)) {
                 for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
                         volatile struct amdgpu_vcn4_fw_shared *fw_shared;

--
2.17.1


--_000_BL1PR12MB514494BD0E3FFF8BE5B1CCB5F7959BL1PR12MB5144namp_
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
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Guchun Chen &lt;guchun.chen@a=
md.com&gt;<br>
<b>Sent:</b> Monday, July 25, 2022 2:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.co=
m&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: use adev_to_drm for consistency</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Keep code consistency when accessing drm_device fr=
om amdgpu driver.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c<br>
index 84ac2401895a..698a59ec3dba 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
@@ -150,7 +150,7 @@ static int vcn_v4_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r, idx;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drm_dev_enter(&amp;adev-&gt;ddev,=
 &amp;idx)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drm_dev_enter(adev_to_drm(adev), =
&amp;idx)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volat=
ile struct amdgpu_vcn4_fw_shared *fw_shared;<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514494BD0E3FFF8BE5B1CCB5F7959BL1PR12MB5144namp_--
