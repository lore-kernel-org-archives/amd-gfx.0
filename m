Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BE3C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 04:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9DC6191D
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 04:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9DC6191D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DECAD6E1E8;
	Mon, 29 Mar 2021 04:03:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259A76E1E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 04:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFvcujesC48lmHYcKFUE2OCwtayaU0W01zr4z1cJ/ZRlzodY53LzQM39LQr5NaoRp1jZj6/4/PqaahxcqCY+hq0ZPaUDcOYmnBGjsdFFK1PbmORtLV9F6bn2dhCGXNxuD5LmeylB1M34C9Xk97HczgOB0PQNi2gAlBOdlbQ3mEW+Rar5nRYXYdQJfZ/c2VklXa40oISIrDjehEi3gofi4qhDrvrocNQtJUrm46IUYRkp51LeB7pWSIvDRbqeIVd8SiVUKKRG8kjLR43XFBHBpD23eUai/FkeRDb5HHM3IPFtXEnhAp5oxnjHma/36v/4lEoWi7xeP29XF3zfIEx/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD01C7Tnz1UeQSg/31T0pl57U3ZEGIU8hFQgy5d17hU=;
 b=med/30KqXXkDF8DuVcQ7PsUv8J59ZbnevPhQe8zpXitMpux/Urp0BFYCJ0+cqI1w5euV48ZCF1VUD4Vvvij9FJhBvDKA+RxXjLmWA4rsG1f66JrNNGVL45E3yz1eU9o8mQrVKclXxcXt0mdUMePMCQMLt2xDiFsTqz/qibszOuLdaDv41QxLW7v4BxpM1SsjgbGV52BSHdfl/2Xa0vSgdrjWUNSO5FinDBdA6GNy8jXKLKH7rxXYyK9JgAvgd0mHjNK2EnY38HSKODIY7jTd7/5Mjz0hE7uozgqpM652fkj/meeFy3xbjFAeZlYH1AQ4rWRXw4IZsRtgoqzFy2VuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD01C7Tnz1UeQSg/31T0pl57U3ZEGIU8hFQgy5d17hU=;
 b=GmBXUzBNjjdWT7mAR3vXt/lv9BFaKkJqWkcP5XYR1qPoNm+avWVuhi96jgkMPcoOKbfg8CWXiLpXLdm9ZNIpWeujII8B/3+3zR02S4CpOlV4DDJ1v3srJINStTXEqEgWmkxr3UBGL4hndKjuUrH5+YarmdGQTxxqnlIn2pB9tew=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB4755.namprd12.prod.outlook.com (2603:10b6:208:82::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Mon, 29 Mar
 2021 04:03:46 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::bc9f:d045:c79b:cc20]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::bc9f:d045:c79b:cc20%4]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 04:03:46 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Reset error code for 'no handler' case
Thread-Topic: [PATCH] drm/amdgpu: Reset error code for 'no handler' case
Thread-Index: AdciLGCHGYcjSM60TJ+lHEEa2Kmumg==
Date: Mon, 29 Mar 2021 04:03:46 +0000
Message-ID: <MN2PR12MB4549FFFC9ACA184CD96B1DA8977E9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T04:03:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e8d0f4d9-db1d-4001-b4cd-efa40f81f9f8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.197.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2391933f-1731-423b-8b8c-08d8f267a6d9
x-ms-traffictypediagnostic: BL0PR12MB4755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4755C361740B566E57C44338977E9@BL0PR12MB4755.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vp4rSNQtFHA3N7FDQbb8S+Em77DnyEAz4zacIHZPc8PBI7zRV1cwarLF0zhc99puZI/EoDS2xuHmM5+iVRGqWo0oCHcciO8kWaCR6/jxnXXubVrkCb58NTDA0wVdiehW7WQqP8HBndEYc6ywZ9uWcR+7jQICgb0RflGIqWFdyc5QivxJOAL/805WMU1xbaD+kFFzTZ4z9zYqO2BqTE29IMtG04dIF6B/LPnFDy/1ZeMmDxBA98ursg2zaoWAo4lmxKj8W7az6unkDgoivC2jg0LVb2zHeNUFYoUL5FHvM8roXaEukgUVSfCHTtTjVSISIVORZBzogpT7Dc03my7YY3+8BTdRdD+ve2u4jVMjLaHXFaDQnLVkd6AN4CrKmxzxkEi4AKM8/ShdFNlFm4ZZCUge0wpqpXEBttyZMtYyggzciHtU9aVTa2U1Ktv3u39BCqYMRtNQHyiLcWqLG2sjF2mb91V8ZGNkbf1M17/gOqOerwJYAhAHD9tniwDhVqxQYa0QOiS1VxnGixUFsq1anat8GAa1n2FLz7fd9c4HVOC2U1cXVPuJ2wQbPtEG5uqsLoPQBse48e5zeBwSp8oKM70elkXSSCls3+P9FLdtsjiSvoj+LYJKTmTMf0KHTxsq8hJByXNqeai3X/LSzuAt/y3na7FiOGSSVHr5clnSq4E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(2906002)(316002)(478600001)(86362001)(38100700001)(4326008)(26005)(54906003)(8676002)(55016002)(33656002)(71200400001)(66446008)(83380400001)(66946007)(76116006)(64756008)(66476007)(5660300002)(66556008)(7696005)(6916009)(6506007)(9686003)(8936002)(52536014)(186003)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HfWw/ehR1m8LzkI768tISidoiSkvGRI1odXpY6SotjCdYzCpxVBcpI3wzuT0?=
 =?us-ascii?Q?+dsN/kY3lfeAk6q8WCbun7grjeN1xf7ewQ2jqmOqIkUmBj+wJd5ElhSGJF28?=
 =?us-ascii?Q?JHZmX73WWlVauc+OHzH8C70f0QxWFXyCeqpY6c1bBtqpWUyilw8qAcNQJsQS?=
 =?us-ascii?Q?zzs6H5zoYCtEesmkObyvuklI+j0bt6DV0+S1x+AD8rE4pBnimh954KR/WVfd?=
 =?us-ascii?Q?mFwUoaWnTiFmWtZp49i9knYuYCqoLvGAaw8GN1ZALQ1wsUONs9hC8jjHGmeI?=
 =?us-ascii?Q?ukOqP4H3GBmea3/g/TrJgb6zmD52drshOaSdNSzMNQ9ncNkFknIhG9Zxf+q3?=
 =?us-ascii?Q?SgPZBjWbdq/p/5KjJTYemti2V17t2olA5wam29l0eWGnr4wO+Brm9Gyaj1yb?=
 =?us-ascii?Q?SVjUkt08PsKL6i4tkKVDwReAZ3BYaNAkQyrq4ib1mDf7YQP7rdwmZpX5rqQQ?=
 =?us-ascii?Q?hl9pcKwu94O7t99E2WawC6ITYqDYtZkVb0O8A8YuOMFt9frZGXdKOGC4BWG/?=
 =?us-ascii?Q?bQqHZpsczSp7WZj36dLGKRsQUguW+nuznei7Lx96N/RwW05x83/rduHbvyEN?=
 =?us-ascii?Q?nS/vxOUDoNAAM3E4eFpa3wvtRk3YnZDOgIBgGO4CUGVIw6HaitKayPsOihLB?=
 =?us-ascii?Q?o1Oh8jS6kL+70FTSuxRiC2OMuTvNNeLvnQUjNH33MUPLZ/hS+jaSWuXlzjRc?=
 =?us-ascii?Q?7nhwhFRFgkSKAL2z12o9I3QX4dfr7ZbnZKnbsYnYvLHxoPMlImdHfXEoeuj1?=
 =?us-ascii?Q?dBx6mDcLNle5t98z03Nr0iw3aEV75r9cEPsoTrEawo03cpZYKBCGWW70KqQb?=
 =?us-ascii?Q?IdRtlAUnsC0qF7RRyrm2BARl1cVKaBBHqneFv6Qs2WmzUJ01yv4YBJ0bTYrS?=
 =?us-ascii?Q?luA0olxXWX8AYf0oIABN73KbTnpGwJt+AsO/4wj3MrpvUNARGQ7mpxJblNQw?=
 =?us-ascii?Q?5I1YFJHcDLf72pOsRjZXx0WOk4c0y05p/JrqDWRtWa8bpTdyG8VpH5EBBZqS?=
 =?us-ascii?Q?n13/JpsgKfLfRuhy1oRx5CdGcls1UbghbWdOrNoWgl5cxuHrddq6SIwJuMij?=
 =?us-ascii?Q?lDvG1fFVzaY9Ae/fFdemvDTPyqp8hSfWHfRbEjcoV6wv6CUusHArLJrsmt5d?=
 =?us-ascii?Q?DGN2eDcfhFKRCiMflkTRR7m1U2k8BOsEKN15KhbdLg1D/3EpDiUjVYYRiNiP?=
 =?us-ascii?Q?RHGtyvuCdAAdX3T/ORy/MQrQ4PS/i/TNwk5gLQP2n4HF/ZbXBPPZ3b0m0196?=
 =?us-ascii?Q?tBv+B5cLT05SxX0d1qCKYhZ4j2lAmGv1ZggF6M2+HLS5GX3Xs9egPkMGLJV4?=
 =?us-ascii?Q?FZOmmvkUYe7Y5JEiVmriE+u8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2391933f-1731-423b-8b8c-08d8f267a6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 04:03:46.6279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bGIYWiKVMvpdkPq83DjkvBbZouA88jua7uJBWiFXqb/3L6W2CxW3QZ7qjghBMr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4755
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2138600048=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2138600048==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4549FFFC9ACA184CD96B1DA8977E9MN2PR12MB4549namp_"

--_000_MN2PR12MB4549FFFC9ACA184CD96B1DA8977E9MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

If reset handler is not implemented, reset error before proceeding.

Fixes issue with the following trace -
[  106.508592] amdgpu 0000:b1:00.0: amdgpu: ASIC reset failed with error, -=
38 for drm dev, 0000:b1:00.0
[  106.508972] amdgpu 0000:b1:00.0: amdgpu: GPU reset succeeded, trying to =
resume
[  106.509116] [drm] PCIE GART of 512M enabled.
[  106.509120] [drm] PTB located at 0x0000008000000000
[  106.509136] [drm] VRAM is lost due to GPU reset!
[  106.509332] [drm] PSP is resuming...

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++---
1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 319d69646a13..a501d1a4d000 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4281,7 +4281,10 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_devic=
e *adev,
                               drm_sched_increase_karma(&job->base);
                r =3D amdgpu_reset_prepare_hwcontext(adev, reset_context);
-              if (r !=3D -ENOSYS)
+             /* If reset handler not implemented, continue; otherwise retu=
rn */
+             if (r =3D=3D -ENOSYS)
+                             r =3D 0;
+             else
                               return r;
                /* Don't suspend on bare metal if we are not going to HW re=
set the ASIC */
@@ -4323,8 +4326,10 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,
               tmp_adev =3D list_first_entry(device_list_handle, struct amd=
gpu_device,
                                                                   reset_li=
st);
               r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
-
-              if (r !=3D -ENOSYS)
+             /* If reset handler not implemented, continue; otherwise retu=
rn */
+             if (r =3D=3D -ENOSYS)
+                             r =3D 0;
+             else
                               return r;
                /* Reset handler not implemented, use the default method */
--
2.17.1


--_000_MN2PR12MB4549FFFC9ACA184CD96B1DA8977E9MN2PR12MB4549namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">If reset handler is not implemented, reset error bef=
ore proceeding.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fixes issue with the following trace -<o:p></o:p></p=
>
<p class=3D"MsoNormal">[&nbsp; 106.508592] amdgpu 0000:b1:00.0: amdgpu: ASI=
C reset failed with error, -38 for drm dev, 0000:b1:00.0<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.508972] amdgpu 0000:b1:00.0: amdgpu: GPU=
 reset succeeded, trying to resume<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.509116] [drm] PCIE GART of 512M enabled.=
<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.509120] [drm] PTB located at 0x000000800=
0000000<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.509136] [drm] VRAM is lost due to GPU re=
set!<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 106.509332] [drm] PSP is resuming...<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++=
++++---<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 8 insertions(+), 3 deletions(-)<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_devic=
e.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 319d69646a13..a501d1a4d000 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -4281,7 +4281,10 @@ int amdgpu_device_pre_asic_re=
set(struct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_increase_ka=
rma(&amp;job-&gt;base);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_reset_prepare_hwcontext=
(adev, reset_context);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r !=3D -ENOSYS)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* If reset handler not implemented, continue; otherw=
ise return */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENOSYS)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Don't suspend on bare metal if we=
 are not going to HW reset the ASIC */<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -4323,8 +4326,10 @@ int amdgpu_do_asic_reset(stru=
ct list_head *device_list_handle,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_entry(device_list_=
handle, struct amdgpu_device,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;reset_list);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_reset_perform_reset(tmp_adev,=
 reset_context);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r !=3D -ENOSYS)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* If reset handler not implemented, continue; otherw=
ise return */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENOSYS)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset handler not implemented, us=
e the default method */<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4549FFFC9ACA184CD96B1DA8977E9MN2PR12MB4549namp_--

--===============2138600048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2138600048==--
