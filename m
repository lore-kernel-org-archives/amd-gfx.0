Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1B7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 20:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E969910EDF3;
	Thu, 16 Dec 2021 20:04:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0ACB10EE01
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 20:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntNpETcuCXEUI5M9mI0h5iFiIn3mxn0K84KaQuoE3TkT5NPu0j5u3yX0/J17BZE0x9fTYJuCwhrwlZNX8IpB80+qz3ZSo7uncyESR66VhDXRKg/wgcqG6JQ7AOmTg3qX6gCL139hSgVM8a3+tyglx3TibyG6eKe0RQ8362WJSameIkyqv0T+c/RfzYvM5RLei6vafdTugYZdjZMt3YoYW4jgN+mhfp4xuoIk31hZUWJdK9CWEdgqyp+SuaoVWT4GmEC3Qgx7DkuLAj8yjBMOQkFyw3Bj+WO52J9V3RYWxZufjvcMu7xq1gXD3IrRNZoQbPt9AQLmFy53qJIbHBKJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0R/tOFeiXWD1EDzKo7gKPWiVBzStJ/yTjHkNbspj10=;
 b=N/ETK7hYUMBW6igZNXWWnR4fJvkwv92TU6gEkuvCU4+Llnig257yMVcU7HZQAffzjMrXVK81MTYRUadKdkmPuZLX2dk4QAmaH9fIL4ORq0OgCBYbdyse1W8QYJK9cwgg2YMcTEtZx4yKcDWHN3OskM/RB4pmBBtpGGHNJlqBWfaVZm+VQdWDGfySkaSYCnQ2cPizFm7DYfEBEjt8r+GWHxhaFrEQk8PyZbNNfOw+w5QbelulXU7DrY6h8RUMmcJv0clxBIBuBj1sS62/Bh/xSC94m8X1x1BHGXqEf2uBLweIZWmtbOMNxI2FVsSTbYEC1s2zI9uO8kMgFk1RfU+n2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0R/tOFeiXWD1EDzKo7gKPWiVBzStJ/yTjHkNbspj10=;
 b=CYqUQBt5yuJpbPvWoUyOTkLw/+SEapcwe/0SCK/2zZoToTPUpgv8X6YMbwpXuCJ55UnquFW8gew50WC/WisRS4c1t7rhJHGtAPoWC8GeWfhSHPJ3OrcE4vNxYVxS8jfXdryzDaBzf9TwxiaIaWQiiyAjoAnpCmpyzJPQOvs3SBE=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 20:04:21 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 20:04:21 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init
Thread-Topic: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init
Thread-Index: AQHX8rUgr7Nx96C31UmdODjnXj1b3aw1isyi
Date: Thu, 16 Dec 2021 20:04:21 +0000
Message-ID: <BYAPR12MB284063A5F6835C32A5AD5AC1F4779@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
 <20211216194233.3839-5-victor.skvortsov@amd.com>
In-Reply-To: <20211216194233.3839-5-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T20:04:20.737Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: bc90f015-6213-df3f-a35f-3ec9f8ac9aba
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9b5764f-1f2b-48bd-67c6-08d9c0cf4008
x-ms-traffictypediagnostic: BYAPR12MB4630:EE_
x-microsoft-antispam-prvs: <BYAPR12MB46304F916D37E95ADB451C7AF4779@BYAPR12MB4630.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:302;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3VtixE/1SGuRBK1zCFVyyfA8Un5lx6mkz5ngeRItoi7aTh92YAPtdalHFuQYzkZG5QMXpTlw8iaSkpk96DbZfrRWZoUAoKgFDiEw8T6KjWGY2VPVOybgz+0RTOAkdFeHwbXVdf9zg4YVHRHiqbTkeVkvo/CHNutQ+hgRknCbXxAtFViqQT9ANzlzdU+471bdMjfgiJL0nt26NA08na0gLw6wgtlpbEjHWJduyRnJnpjV8CiRjwicimQLv5sii31n+JBjvqcg58aS1PAUFrVRgxM3xdFjmqp9nO0zrE63UNM8UPdVzCOcqG0ybl8rgizKQGIvGTlAR6+xDLsrg1PfJWN9QEbYiR6gY4NWjhqkH0kcFKGo4OpZJ+CdhQX3xNC1Y5EDDWLMFmLZKBRb8jb/CcmDuVlyzh5I+SKBv7XdSMU1qnxNvoxh7ckVURa67JtS7jHJXCnb3iH4KIQTwEe9STT0/lFD7ZKS+oyHUmg4SlTkzY3GS5C9RETgAL6eiVq7dzHTmt24yO9yAwsgQXhDz3P7hW1wrsifOeoLja6vd15y/YxvLNwFzbi5rngCFJI/cNlsQF4V0XxbLsvVoUt9ybU/bTYwApq8c9zi7hn2sRBZjIJh9P20Qope1VrQyt+e/+olGXOlMB1nDXI6TUs3CIrmejoKPufj43mwnlFSuARAukRXTXj6rXfIMhiBrq2LyV7IeJZe9t+X2ZbExRbOxOybQfc4vN0D9f68bxbi6oA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(110136005)(55016003)(2906002)(6636002)(38070700005)(19627405001)(316002)(66476007)(86362001)(7696005)(53546011)(6506007)(52536014)(83380400001)(921005)(66946007)(5660300002)(76116006)(8676002)(66446008)(64756008)(66556008)(186003)(508600001)(9686003)(8936002)(122000001)(38100700002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qvfUH1JO8iZzcxXD3vRGF2e7PPtV6WC1RGbBgug4syl20zE5tuvyKv8K3xhb?=
 =?us-ascii?Q?JKtbOaljRyDlLE9FEB6FiPHOoQjANu9pCfO5Lci3/8MQ79khrn6DnMG2et+/?=
 =?us-ascii?Q?VbNgDgHAV8nsaXGd0VArGOAuJqeXGs3uYFtBZj8191NFu8e595AlvYiDMvbr?=
 =?us-ascii?Q?YPKotB4G6Bahadzz6Nor+a01gqqj15UOvezdDDRpHZdMCqrrgBAffHlKBxVX?=
 =?us-ascii?Q?0YLxg4IvZ6t9glvlK2VRXr2+3OEqkp8VHY4SAcNopzZBpDHBE+6GlJpkM3kf?=
 =?us-ascii?Q?xb8aHKjjHobk/H6ne0+2nxgqAOoWJN6WJ+DAt6uDkWj6YCEhMJyGDSZ26Zu8?=
 =?us-ascii?Q?5f9EgRnd+CETP68qGSjaFDYeKpaNvoqw7GHBVMq6RDtBFxUSxVPl19nw8E0n?=
 =?us-ascii?Q?x6/r926pqopjEiLXDdlZOWK70wNODLOOVqkEM3U3RBD2YIBTxE9cycvC4i5l?=
 =?us-ascii?Q?BisJMO944ltZLbqTbLKATXj+ZnowkOaCL0U1GDgVAfBd8uG3XHTvi7tPDqZr?=
 =?us-ascii?Q?bV4Q1zaIcLlWNxtnFVEyUwiY+sObYJ/xbYFd3i199B/AYnh5kET/iCWlBzYP?=
 =?us-ascii?Q?FfmWG9zgaUtE+DhkPc6W/XZ5A8GxBQc3UTBhSOZ3CkkBBKCWkXnYFgFOWuIc?=
 =?us-ascii?Q?bzTR1fUSKnV2mACQAAShlWda0P1WkYdEHgAn3eZfi/vvAvFuZrdvd1vU708q?=
 =?us-ascii?Q?O70QXwMNEblqfG/L1M0cPYW9mnjGhvj8sMvZkmkOU22Gccy/TAmD3tUm8DWV?=
 =?us-ascii?Q?UcC0Z+ZEo8dLJ+HG3PRgAGUiDj6ktg6OCJ/9od65gzs2WcOTIp5Kv8A/hJLC?=
 =?us-ascii?Q?IWYJ0jXAbki2D7eRmC2i+LyLOXnpJcrjjgN2qp0O8KjicLaK/2IDonCz9JRj?=
 =?us-ascii?Q?rSyL6Fr1v2UkcmKWGECZTIVG5W32umQoNO4o3+ywJYa0yTG0ZKHFc1E0XRMY?=
 =?us-ascii?Q?RqR63hDmQy+xFJJS9yXmFUHY2vY6YLJ3a6cZ7rpt5TuYrM0DYMFQN9Y1KIbL?=
 =?us-ascii?Q?gYLynpjs93YrGXiTmow/n07Yc9xu1wNntyLLIiOQYamXblgAaqYKPB0Uu8L2?=
 =?us-ascii?Q?/oH+5wEKcVU7iVA0Q2KAj92JSvKrVbafO5nfVi/8vEPjl3+37923wmM9MP8C?=
 =?us-ascii?Q?Wf988/R/qXEi3QdSbLO3xmUn5FBsr2wnzYcXyudJSZWIBEOxOnaaHBoKTFuX?=
 =?us-ascii?Q?cBiFWyiBGhyFW2q/V/01oaG46GHzfiRkV8alTQvLdiPaj0xdiUk4llafGEhY?=
 =?us-ascii?Q?T6lUWGcTPuDFtWvU6YE4cu+Isp2DaTrhBaAuyhAA5sjXOz0IxdrgYvL7Fjji?=
 =?us-ascii?Q?yfhBkR8Ws+BLqFKJC05XImd9Zaugb3NuFK0metXaJ0zo7It9r6zJe6SgsBJX?=
 =?us-ascii?Q?LPp7va+tDzRVToAQ6nI6SueU1D9+5vYHSa4MvTfcWebB53SBjj8a/wwCgQHA?=
 =?us-ascii?Q?XNiryY3DKp0W16gh/9bUxKqg8K0YkRhrSNgC4L8JUmHSsPxVwtEARgEcSZQg?=
 =?us-ascii?Q?MPrL5QVO3T1K/9Kf9zSVdlyuDK2LysAXPKuFcjGl5WXEPJFJpXB2jHsksSKW?=
 =?us-ascii?Q?4hR4lWRyr31dA3i934qZw03aj95dvQrZ0kbXNxE7?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB284063A5F6835C32A5AD5AC1F4779BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b5764f-1f2b-48bd-67c6-08d9c0cf4008
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 20:04:21.2293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyUf7BTaaUlPoHj8KJsSjJamPqXnnMkD0iM4spX1uGlnOcWwiFBUPPhG/QZvHX0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
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

--_000_BYAPR12MB284063A5F6835C32A5AD5AC1F4779BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: David Nieto <david.nieto@amd.com>
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Thursday, December 16, 2021 11:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init

Driver needs to call get_xgmi_info() before ip_init
to determine whether it needs to handle a pending hive reset.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 6 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 6 ------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5bd785cfc5ca..4fd370016834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3576,6 +3576,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         if (r)
                 return r;

+       /* Need to get xgmi info early to decide the reset behavior*/
+       if (adev->gmc.xgmi.supported) {
+               r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
+       if (r)
+                       return r;
+       }
+
         /* enable PCIE atomic ops */
         if (amdgpu_sriov_vf(adev))
                 adev->have_atomics_support =3D ((struct amd_sriov_msg_pf2v=
f_info *)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index ae46eb35b3d7..3d5d47a799e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -914,12 +914,6 @@ static int gmc_v10_0_sw_init(void *handle)
                 return r;
         }

-       if (adev->gmc.xgmi.supported) {
-               r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
-               if (r)
-                       return r;
-       }
-
         r =3D gmc_v10_0_mc_init(adev);
         if (r)
                 return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 2b86c63b032a..57f2729a7bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1628,12 +1628,6 @@ static int gmc_v9_0_sw_init(void *handle)
         }
         adev->need_swiotlb =3D drm_need_swiotlb(44);

-       if (adev->gmc.xgmi.supported) {
-               r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
-               if (r)
-                       return r;
-       }
-
         r =3D gmc_v9_0_mc_init(adev);
         if (r)
                 return r;
--
2.25.1


--_000_BYAPR12MB284063A5F6835C32A5AD5AC1F4779BYAPR12MB2840namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); d=
isplay: inline !important;">Reviewed-by: David Nieto &lt;david.nieto@amd.co=
m&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Skvortsov, Victor &lt=
;Victor.Skvortsov@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 16, 2021 11:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Driver needs to call get_xgmi_info() before ip_ini=
t<br>
to determine whether it needs to handle a pending hive reset.<br>
<br>
Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 6 --=
----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 6 ------<br>
&nbsp;3 files changed, 7 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 5bd785cfc5ca..4fd370016834 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3576,6 +3576,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Need to get xgmi info early to dec=
ide the reset behavior*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.supported) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable PCIE atomic ops =
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;have_atomics_support =3D ((struct amd_sriov_=
msg_pf2vf_info *)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index ae46eb35b3d7..3d5d47a799e3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -914,12 +914,6 @@ static int gmc_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.supported) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gmc_v10_0_mc_init(ad=
ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 2b86c63b032a..57f2729a7bd0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -1628,12 +1628,6 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;need_swiotlb =3D =
drm_need_swiotlb(44);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.supported) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gmc_v9_0_mc_init(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB284063A5F6835C32A5AD5AC1F4779BYAPR12MB2840namp_--
