Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A05C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 10:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88D860E8F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 10:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D88D860E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6052189B29;
	Mon, 25 Oct 2021 10:25:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B295E89B29
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 10:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLQBKa1neK2JTy/5GCJf/DAJpIm38CwVjdGKirwYUxsYJ+VUdyx7J5nZbhQ17XIl4kazEFwahayR7PNicYSaY+E85r0sTl6uw85O4ejyJ22G7sSzBRLyUcpMAzey8cCKPq/W4chz9oH/coo2ze/zGq70px7KCt4EqAkBsUwB8CjKa6APc/KBkO3fB/elzwygWbOpQxxC5gUVxdIK9MtQmGiixgTjZc5A/YoRHLZDmkZYNKzCI/IIhgIMeeFFpYqnMXJEVmFj9YEHtvNnKh7U2Ovjx1uleI+vdbd2QBSOQxleJsYhBWXvtFpoqXsK2PRXTGPClGuWmRnPwxqDM3HdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmbAjqRg67fd4MyZFhbK9kSR5k1IFy5xaHkqQWvdZsk=;
 b=N0kG9hD0h0IhVGyXnjmh6Y61wKZMyCjXiLoaWMtRrOUBhG3SILRyM/MqmbKsaV0FrTUXspfB7+CwKzMXur+pj3O/YMFIPhS+MUBOyUxqeSrlAF5uXfjizaUx0YZwxtj/7hNDcenqvG+hJWrySHkbptLhfl2du9BC7rDEHYdG660vchsLN3R738mLtZXX9AH1yQe0MM7L3VEQGsySprq2gwq2TJlibbZY7KnPWP916d4hI4J/e4lXTpKnRrUNA7VO2rGAIHYmN785ALXmlK3daq1oub02eTUXYDl146TrprkxRHgZrfEULLeurj+gtJ45Ryr9SPPJ503qJQKvwTrUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmbAjqRg67fd4MyZFhbK9kSR5k1IFy5xaHkqQWvdZsk=;
 b=uDfKjkPonrw1khUxOBYYVz9AYYKojuzrcE9GwPoxHo/e5HVmM2CGsn2nnUWtUQw3OkMUUn7VyCMlDz3UW8NUtPRPv1JL7LQ4/c+HxzKT3ss3ckl2X2CQb7HyKJo7XPvf/Msl3qDZApumn0LjnNuXPVfDYu8JPBONFHsFOx9Pa8k=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 10:25:04 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 10:25:04 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: skip GPRs init for some CU settings on
 ALDEBARAN
Thread-Topic: [PATCH] drm/amdgpu: skip GPRs init for some CU settings on
 ALDEBARAN
Thread-Index: AQHXyX4mOkYJyLdTrkaPBP5M+Pax7avjcoYAgAAPeoU=
Date: Mon, 25 Oct 2021 10:25:04 +0000
Message-ID: <DM6PR12MB4650D85DA62902993A2F82D6B0839@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211025085550.5846-1-tao.zhou1@amd.com>
 <BN9PR12MB52571EED4049DD92756E2BF6FC839@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52571EED4049DD92756E2BF6FC839@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-25T10:25:03.805Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 50affb40-3c87-6008-46a4-ef78b92676e4
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b013b4a8-6070-499d-df37-08d997a1b5cc
x-ms-traffictypediagnostic: DM6PR12MB2954:
x-microsoft-antispam-prvs: <DM6PR12MB29543880DACD0CEDFACCAE22B0839@DM6PR12MB2954.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIVgWoALDKpRjCUbc+S5eFBk6FjCKcasvMnwRt6sgLFi9xd+ttnZUEAvGg5Sgjfk5j1RBBZXTde1SpiajDB/KLBDXB3ch/T8g9A2YcNOlG44Nv0IF5Iqjrc2VULvEmXawvzyEEqkq5jA8zligKaR7zLGAHidOP+nT2LxQw6eOIPOmZMCM/Hdj7SLb4EYzHhAXxNF8H40HsLE8b9TlbmsrRBTeZNPrhqXBa795VEOEeK+03vSM6p3DSYUGsNRntMtjlW5S1y/LIl36JfyOsnj7Rsk75ey/EmTvbgbPI21WR+oz+QtqjmuTGQDNfGyC35FRrCt50aTzHyQwljppa75WzPj2w8LR9kMhGhJmw/2oT3ljv6DeNCoqBgWNLMAVK4QREKgmz3lo2sx06ekc1xaIKG19nx7TANZ6UpjC/bm+hb4roZG46t1CI3Be/FhyTRBAalyW9JRfAa7s88+gnUTGqaHb2YYmuwUMja0pM3WD/Ct1UzwprtPb+iTppCyWToQ3exiJTXEVTJHbXD+oGoTjjqfoo/U+OrPAmOd0z0sRklu2RzdckueUOan4og0t4Lfj1/IX/fDJyty/owOZYE2+bC7jlDY6xwlcY6xPHlcvHcOwT9l7cl93D6Y6jnI18R1NJhXaSi5gaTEZY2eQgbo2Tof7LREpmhxgj7JpNJuFI1naT+f4JFJF8SJJyzYxLqtE3FLOC3RaOrjQQWnPIKsZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(52536014)(83380400001)(122000001)(38100700002)(316002)(38070700005)(186003)(53546011)(110136005)(7696005)(8676002)(8936002)(5660300002)(66446008)(9686003)(86362001)(6506007)(2906002)(64756008)(91956017)(19627405001)(66556008)(508600001)(66476007)(55016002)(66946007)(76116006)(26005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9uBw/XQMZy3BY/xoaBw3ByBuYoEhtWI869gPapv1CDwPD1PYMohDVQe6Gb+M?=
 =?us-ascii?Q?fLDsCHcvWQIRJ4dyh1dJAtKrIxX0iVpMoOTWEyfSdBw1oT1Tgo/0JBBUlsHH?=
 =?us-ascii?Q?Y/zL8rxLqduIQhKAo7SpHJM4avldEJJeqQDIG4CXj3sxtyuGkGIr+FDZ/j4v?=
 =?us-ascii?Q?+3f7kI4otPuhl9s2r4hsHSgpeMCEXZImmyim01bMIF9uPSF7bz6VhHrfpMOu?=
 =?us-ascii?Q?udyWf5S7OMcZje55MkRWHqoiXJaQydJEWIYMzt+0Cb6DoBi5OY/ij7GzoCHX?=
 =?us-ascii?Q?AXnPspp1GRXhdnXixZ3/oMYkeT7r2qlghgsy2uVyWxcASg5917zLCbWTdOK8?=
 =?us-ascii?Q?NIhqZP/ExJPgdBNaWkSo5NnCllCVkPTgLL4waVac6Be5q2BWTMdtRlCsZVbg?=
 =?us-ascii?Q?pVBa6q2kHCGR44629vg5V4O3C942lNjoUr692cqP17EwwfmWSvRyl1TQj3A5?=
 =?us-ascii?Q?B+DMtfSd8Aj3CHYYYm+Q+rcriDIYTwTDVGtI3X/zh9HHdRmdEr1wIdZLsjKB?=
 =?us-ascii?Q?oERae71W6U7xcTNE62ANfIgAnRKs5bKfGI2mtAJSokc+0G/zDb+cqcCM06tB?=
 =?us-ascii?Q?bqg9rS4u7CvJrr5dstxYe+Xq5TlWmb4Da2h43/D/SAAtN40s4wweilPvFyBg?=
 =?us-ascii?Q?E6htnYNFJfTXTxTMNy86RiCudoqwCZaMC+31ExNxNlG18OOSfEGnzilDaCwG?=
 =?us-ascii?Q?TXAt2hDJFVvhqWuTTudpvzuEuJ0t6yYuUPcWF5CWNTH3SOYuOKp7z+yWMYxQ?=
 =?us-ascii?Q?b9W3RoC/EGFAr/sjq6xDGRtJPweYCofJNBj5beEfqL2hEfylCVWsYXIYmVRF?=
 =?us-ascii?Q?J3CN+sKhn+bKIeTzmqujTA+oOM6R3Fd5u+F568Gs/ChiqQQXR40MpUmbcxjw?=
 =?us-ascii?Q?BfIwQNbw8hACOn7pbP6yki8QloJL6eOvLYzViA6ZqYbatcmawngdHxga4jqw?=
 =?us-ascii?Q?+JlLvcr+4jbpMK6Ahgu4W9arQoYpBS+CHZ+5iNPqp4tExO/cbr8Zagu9Z/6T?=
 =?us-ascii?Q?eCY6peAH/0EM/X1UG8MBl/gdLK3sVQbY0J8MLFyZ3I1fmIqn6evQMVPKKoKw?=
 =?us-ascii?Q?e3+uYv6zqs9eijq46A2Akf8WZ3d0q3pTk8WW/pQXOznZKixHWl6w0IfwmVkz?=
 =?us-ascii?Q?tcM9qvavFDMtuYA7lzQIIEz3YZSyVQukC6RoUIIYvLZJRf3Cr5xQFGhy6Sh0?=
 =?us-ascii?Q?pZfCFLYz66GAylG213XdA4e5MYhKfbiQHf19PR5JC9lUT/6fk7Ri8Xg/WC02?=
 =?us-ascii?Q?8RKM1CbKujDCAlMQGrL7DNshV0SEk9ursfUL1q+S64ba5GNX5y3t2zuhIfqb?=
 =?us-ascii?Q?1TXWczJ0aNvP1rCTzZwgZsnV+vw8cJVTUU/dME1F7S9PoNS1GrEqbdNzQK0B?=
 =?us-ascii?Q?zjhgFo963Zmk0FogM9Myx5QHRGOYTvJB5YT0m47sT9VtFH84ijF9G+fbwEDz?=
 =?us-ascii?Q?+XhWDs85N4bhZ1wDx3Ico9MayvQOX1FkrjB6KF4d8RCK5wrzKSw19nEae+rD?=
 =?us-ascii?Q?zg6aT7DdDnuOdeci4dbQg6+JgEF2gN8/rysyBqEg1a5FaOO1cTC2DVOw9EPl?=
 =?us-ascii?Q?6+okqHVkMVOq9a3XFXY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4650D85DA62902993A2F82D6B0839DM6PR12MB4650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b013b4a8-6070-499d-df37-08d997a1b5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 10:25:04.3718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oDJrM3MMAaaUIlhuka1zKI6qevWadIQMzPJ0JpMyHcVDq3LAS3SXQriImtlYxEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2954
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

--_000_DM6PR12MB4650D85DA62902993A2F82D6B0839DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thanks, will and comment as you suggested.

Regards,
Tao
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, October 25, 2021 5:29 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip GPRs init for some CU settings on ALD=
EBARAN

[AMD Official Use Only]

Please add inline comment to remind us remove this workaround later. Other =
than the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, October 25, 2021 16:56
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: skip GPRs init for some CU settings on ALDEBAR=
AN

Skip GPRs init in specific condition since current GPRs init algorithm only=
 works for some CU settings.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_2.c
index 00a2b36a24b3..a1f424e2ff5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -706,6 +706,10 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_de=
vice *adev)
         if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
                 return 0;

+       /* workaround for some CU settings, skip GPRs init */
+       if (adev->gfx.cu_info.bitmap[1][1] =3D=3D 0x3f7f)
+               return 0;
+
         gfx_v9_4_2_do_sgprs_init(adev);

         gfx_v9_4_2_do_vgprs_init(adev);
--
2.17.1

--_000_DM6PR12MB4650D85DA62902993A2F82D6B0839DM6PR12MB4650namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks, will and comment as you suggested.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Tao<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, October 25, 2021 5:29 PM<br>
<b>To:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: skip GPRs init for some CU settings=
 on ALDEBARAN</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only]<br>
<br>
Please add inline comment to remind us remove this workaround later. Other =
than the patch is<br>
<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <br>
Sent: Monday, October 25, 2021 16:56<br>
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com=
&gt;<br>
Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: skip GPRs init for some CU settings on ALDEBAR=
AN<br>
<br>
Skip GPRs init in specific condition since current GPRs init algorithm only=
 works for some CU settings.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 4 ++++<br>
&nbsp;1 file changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_2.c<br>
index 00a2b36a24b3..a1f424e2ff5f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<br>
@@ -706,6 +706,10 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_support=
ed(adev, AMDGPU_RAS_BLOCK__GFX))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* workaround for some CU settings, s=
kip GPRs init */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.cu_info.bitmap[1][1]=
 =3D=3D 0x3f7f)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_2_do_sgprs_init(a=
dev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_2_do_vgprs_init(a=
dev);<br>
-- <br>
2.17.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB4650D85DA62902993A2F82D6B0839DM6PR12MB4650namp_--
