Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910CAD6E2BE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 05:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FEE10E135;
	Wed, 20 Nov 2024 05:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="al1bepDz";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EB010E135
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 05:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQREL+X2zUyQ4rhPfIOLTiBa+KlEd7Zt/6u0MZ5Dtfcq9bdTT6Jk2eQMljUb69BS29lXCjKq0yXZ/8aCfyIveHubPyvk2BtRNT7dNKZkdXDpMqvMQahXHSxvNu1qr13VCtCY4Abs/4vPsbPt/n15x2iC6kpNMg0rmd/75NrJ3kVyLV8GATmjX3FaxcD+yikqkaqUUnsHk7asKvTDggHmjaZLGcogO7fw0ONWIdXHcOybvyltsO0X4lnJACymEwc2uF3WKTdx3SGgxiizr7d3c4R6Mnlexw3vcH2cD++eIRdw3navQjGUfHFrilbIqIMY3x25nWeuHPDi2R2sySUAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIoj4v01kVsO3J5+wuXS6ZdXvNZxz8mwdLI2acYFTiw=;
 b=gTae+RJa7DIpp/zOOH8kZaD6RBFK5eArtMEWdHPylHUHEXjbKQow98A8SECGl76wP1Fj16Rf8HK2uoJOkELVhPO/siJoVFKRbglsR6BDyl5jNJhtYNf1Bph+3dC8RpbFYTZB6eMP4XkMcJT+YDLD4iU9OtEbWB2jUS5NVNQZ7vIPzkKEssS9cppxW4hJddtnI/4QEfzxd7hFsY5z7OGLjpR1YgJFsirUMBiDC1vq53DGbqrh9kRwybmcjpFhaXkTer3J8sGmO/AvbJIpJPLP6g9wdfrUVo8Kp3FSULihN3Apn4Xuk/xQ+arsK75FGZqG4K8vzRwVGpmBvEabAYiavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIoj4v01kVsO3J5+wuXS6ZdXvNZxz8mwdLI2acYFTiw=;
 b=al1bepDzprrJGS31r5tL0MYieYpXooCgLE4JAYj028Jbr90s7D3fh1IKDD8oshuQKl8zgcKtlnJ3X1Le37f7QfYuqsNymUOkoa/2UvfIuCugKWSmjH+rqmDzfFDu34AL/2BWLYe5tIgPeMaQ4+whTWgizUaC1Ejh8xubjxpdEG0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 05:56:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 05:56:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Prefer RAS recovery for scheduler hang
Thread-Topic: [PATCH] drm/amdgpu: Prefer RAS recovery for scheduler hang
Thread-Index: AQHbOXz+OPJb6eoYOU6J5ZU8DGCrwbK/rqkg
Date: Wed, 20 Nov 2024 05:56:02 +0000
Message-ID: <BN9PR12MB52576510454A164C645D74B3FC212@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241118054422.3382434-1-lijo.lazar@amd.com>
In-Reply-To: <20241118054422.3382434-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c42f3cdb-55e7-4787-ae66-0e1ce4f9579b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-20T05:55:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN6PR12MB8472:EE_
x-ms-office365-filtering-correlation-id: b36f7670-0338-41ee-d144-08dd0928039f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oYZCxqxrB/5HOXojKqz0rzk2M/QDs2q+tqeOadMIr6Updi46zLc5q+kGcao2?=
 =?us-ascii?Q?M6t17AeSZzVm8PGhYxytiZ7S1E+h2mSe/wLR7+wlNFHaUA/lTbPEKppfK8qc?=
 =?us-ascii?Q?uESr1UybY3saok3bBKlbf4s+6hcKnny+DWS5oGCTOwiFrUbVtIDNvIHVPJn5?=
 =?us-ascii?Q?1nVrocxC8790vE7hFY4JbE85oHATqVi0PMk+thJy3RTcu6pT3jaulP9LVa7j?=
 =?us-ascii?Q?PpxBYUdjEGHnderCYmrFCEjH4jfFPBfzcXjiUt0jSUqUM0bMtT3xPjD76nZk?=
 =?us-ascii?Q?rsDu2Uw9r+AoojlCqBuWNegAxdWJovOzuCFc17Kqwn9s9kb5TSM2xyeO0esO?=
 =?us-ascii?Q?L5hakPD7gn2OdB9bhbvSumLBY9uD2NF1TBALX/p21067XW50rwejfcaB34Ac?=
 =?us-ascii?Q?wdtTpkOlMPjzrY7x85FGrEnkNJ/pdEe/yTTIl2n/8qsp3X4XJ4/+llNyIIrj?=
 =?us-ascii?Q?wSAzhl4O5gA+Kx3/zAEjfPnqCyuDBH/+aUQxUlod64y/ONxQVZQIYRqFKtmw?=
 =?us-ascii?Q?6OjmAzFYYR4LgBaM3t0b+R8q9nHq0ZSnqO7EB1S79fpJdvhovRE26vdTjqwj?=
 =?us-ascii?Q?8JN6QUUFwK1N+SM4vB7k5KPsEBt7reHWz+D1GNMt8GSGVVeBJr9nid20F5SQ?=
 =?us-ascii?Q?AR30BJ3fylI4XT5+CL27IUy3qTpjl4gv8XqcbMXpKlhdVkV2OlQjqmmNFb36?=
 =?us-ascii?Q?YcfwVkSp4Tm44bkvDCS1Eo1HEeKw5FgsQB5HX3bauAl2YGQ9egPEI1hhzegA?=
 =?us-ascii?Q?9LEw++25P0mY3P/ju6KmalfSp8ES4QZTTXTJnV+0aYh8RJ/MBBIBfoy6bEk3?=
 =?us-ascii?Q?BOKelcZiU/PPNYfRZqJBOWj9zwQG1pWdeE2Qfm2bbTk3BRLjHfcVbaDoF/Pi?=
 =?us-ascii?Q?gW5j+xlzJquRBW9lM+PzX7WDULiF9pco/sbPWmiNUdOcEYoLg26FqUZh28h8?=
 =?us-ascii?Q?aC/8LDgaYRU1J1Db9ZjPw5YBTmWTdo+3ZlwTFN3FJiRl/hBS2VujuTVJ0Lau?=
 =?us-ascii?Q?on6O2GjQ8EwK296pHCAHspiDi4U+0uNrFOzXOBb+0wzKO7EnMua6dKF8hnL4?=
 =?us-ascii?Q?NlxlLb461l3hCyCsnRYRJte8vQtCS2L90VLCih2JBpczbPOHQA3C7bunrhwJ?=
 =?us-ascii?Q?FpSpa2NUqO+SyjlT2V06gAf5IWCiuVXgSTydbt8BY6cyxV7h8jXdOHlEEdlD?=
 =?us-ascii?Q?fo4KPnjJnRqrT7xvBctw7j6cvg0B+nwOZUwHqko4SYGCADH9T67RZh7EjkBy?=
 =?us-ascii?Q?4QYuFwqYbcxlot7Y8DQFNiXuAQOfIoMziOjeeLP7sq8a3rCDdNBh7j0DnheN?=
 =?us-ascii?Q?ItMzpEkNFLrI5e3g3PCkXT/uzmJx2CRS7//GIkuE8iQfA0A+sonUE6ZM96sT?=
 =?us-ascii?Q?nmmvx0E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dA9o+YSaNxxNVBp0SzBxyeR/AuTvFrwih4xnX8FW5suim54doY6TsflIsTwf?=
 =?us-ascii?Q?olk6qRrkcc6KhUp8wIHVJ6eLO8phdK11bnAAeULoFnr+AOi3hPzvf/KAuEys?=
 =?us-ascii?Q?BUOUznuNkoVNQjTEFsiP8CmSX/8Y3CiWTckuzpEnaG624WGO+M6V7TJoJJsA?=
 =?us-ascii?Q?/AVCHuhHWf66n4KgsLdB5ASGzeB3eqLYQyA2AyMcGH4QAc+3hMcaxMtOF1Tr?=
 =?us-ascii?Q?U7qGCNtvxuh2TqluT4o1f+UduZP0LtBjkMg345NuXXW2EygjLwhIKEj/SnoF?=
 =?us-ascii?Q?MTBDye0iQwxWAF0bhiYOad+Il8uJiTYyDCFeV19mxrfc44Mr/vnJlGxwdDfR?=
 =?us-ascii?Q?oZ2y4oxamHMcpej5Z3xgHTNcojhBA6Pfh5Otoj2iP8QXOfRHZ4PSTX+JpHeF?=
 =?us-ascii?Q?126qfT3tbDBBShWY53vzlitWqdpo1kQ1EU1zuJ5iSBzDkRLFmoK8R7By1j1C?=
 =?us-ascii?Q?5ENUKRPWivckJLPhKV3GDhsUBpIZmASb+8ufOPKdRGD+idE6A0cRNvEYduyr?=
 =?us-ascii?Q?3xs+HthanD1lxbD4Xu1lwk2BoSXW/aGkZc2gZzzL44Tbb1buoGjZJVlj9ldI?=
 =?us-ascii?Q?Yro4Q3PVJDsdK7WSkso9hhsTBy3HY75rTIsqUW2o+Rykj6p1YZSqhkxSiAtR?=
 =?us-ascii?Q?lUICyvRMtCqAM9GPrQ/kw6CQcFZSxWKeNZ2ILW3CwTctiAbnLRgWdbc6eezv?=
 =?us-ascii?Q?q1aymJ2CwlSBZiiF9BAaYqXLBiUo6ujqe/wCzs7Fqpq+AT1HF03tb66c9Bcz?=
 =?us-ascii?Q?tddKEz2RGKUQy7yXm4Etfz3FsMRsS/AT8LwkaBUPX6b5Hp/k+GU7MPH/qAP/?=
 =?us-ascii?Q?TJi1QrLcAsovI0rFGwlJ6PU/pKPaNdUGDykleRP/lkMAlaIQIVfCvY8NlwyQ?=
 =?us-ascii?Q?l5ydEWY6Yh2rEnMG0CPqVCg7VRYHPszRSczdgTocYB5y2Iu5X7q9MnkLyso9?=
 =?us-ascii?Q?fiiZ6R8I508A8Cl464itithoIzYV+hK+sW1b0CvYkjNmnSgSnCYhaGlke05R?=
 =?us-ascii?Q?wUJUv9yCMYEeVsKXhvpmhISjlCfYT8dAqxTHwvYlsEYQj2lhlH8+0hDAcYhM?=
 =?us-ascii?Q?38oYofCJE99cE+TqC7m5fLyVBeLY1yGZH/+y51iVeLJ/VbtBC1pxhQf0Fc9o?=
 =?us-ascii?Q?PMRth7yHyWHgvDD6O5x0hfE86I8y71pXMKmIw4qL1iTnd5bBmE11FZCHwhyf?=
 =?us-ascii?Q?F3IVrlGQcnUVw2VPGW2M5o7GSFlV92fX/ylpWKuv38MKFCRwpkt3dHSbMiUC?=
 =?us-ascii?Q?vaKySBHAsBbwR35Y+7JkHj565lJSWmkOqFaU75fAfUY2YwNu1wOvCviB7cyy?=
 =?us-ascii?Q?CW9UOPmImy1RbQyfgPh8kIp3E323/ykkcMq4H298WJuaCdFNdVKvcj33zz2y?=
 =?us-ascii?Q?c+IPNWr2o56PemMbrYix7sxCCM8ihzVf+GeodZJrtXsjPVzgbGoD+gSYuJrE?=
 =?us-ascii?Q?ljfBB1yWErCwhvdbFer9cVOePFQz3Fv8eOJI7RbuCt4FFZ3bi25maTxGQ3yv?=
 =?us-ascii?Q?57QadMhyNtpTi4Yz/6NYL30hdzLKnVK9WIsDhEDAp00+IOC4kOC/PZOBc0PK?=
 =?us-ascii?Q?I3RznI7JhqopFRywhvz/JUiNWTAcSkHQ1tLkDjNx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36f7670-0338-41ee-d144-08dd0928039f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 05:56:02.0462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKbZOhsrgJBtljp4vMaAxrpQfrPOcMuIfUvfJ7Rs04hgwOAE5caeO9WZNnJCvUxX5GSAsaMyyjpesUw4gABZ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, November 18, 2024 13:44
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@=
amd.com>
Subject: [PATCH] drm/amdgpu: Prefer RAS recovery for scheduler hang

Before scheduling a recovery due to scheduler/job hang, check if a RAS erro=
r is detected. If so, choose RAS recovery to handle the situation. A schedu=
ler/job hang could be the side effect of a RAS error. In such cases, it is =
required to go through the RAS error recovery process. A RAS error recovery=
 process in certains cases also could avoid a full device device reset.

An error state is maintained in RAS context to detect the block affected. F=
atal Error state uses unused block id. Set the block id when error is detec=
ted. If the interrupt handler detected a poison error, it's not required to=
 look for a fatal error. Skip fatal error checking in such cases.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 15 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 55 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       | 11 +++-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  2 +
 5 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 3a588fecb0c5..6a2fd9e4f470 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -332,6 +332,8 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_c=
ontrol *reset_ctl,
        list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
                dev_info(tmp_adev->dev,
                         "GPU reset succeeded, trying to resume\n");
+               /*TBD: Ideally should clear only GFX, SDMA blocks*/
+               amdgpu_ras_clear_err_state(tmp_adev);
                r =3D aldebaran_mode2_restore_ip(tmp_adev);
                if (r)
                        goto end;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b3ca911e55d6..b4464f42d72a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5165,7 +5165,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
        if (r)
                return r;

-       amdgpu_ras_set_fed(adev, false);
+       amdgpu_ras_clear_err_state(adev);
        amdgpu_irq_gpu_reset_resume_helper(adev);

        /* some sw clean up VF needs to do before recover */ @@ -5460,7 +54=
60,7 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *r=
eset_context)
                amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
                if (full_reset) {
                        /* post card */
-                       amdgpu_ras_set_fed(tmp_adev, false);
+                       amdgpu_ras_clear_err_state(tmp_adev);
                        r =3D amdgpu_device_asic_init(tmp_adev);
                        if (r) {
                                dev_warn(tmp_adev->dev, "asic atom init fai=
led!"); @@ -5786,6 +5786,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_=
device *adev,
        bool audio_suspended =3D false;
        int retry_limit =3D AMDGPU_MAX_RETRY_LIMIT;

+       /*
+        * If it reaches here because of hang/timeout and a RAS error is
+        * detected at the same time, let RAS recovery take care of it.
+        */
+       if (amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY) &&
+           reset_context->src !=3D AMDGPU_RESET_SRC_RAS) {
+               dev_dbg(adev->dev,
+                       "Gpu recovery from source: %d yielding to RAS error=
 recovery handling",
+                       reset_context->src);
+               return 0;
+       }
        /*
         * Special case: RAS triggered and full reset isn't supported
         */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 1bc95b0cdbb8..e31b12144577 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2156,6 +2156,16 @@ void amdgpu_ras_interrupt_fatal_error_handler(struct=
 amdgpu_device *adev)
        /* Fatal error events are handled on host side */
        if (amdgpu_sriov_vf(adev))
                return;
+       /**
+        * If the current interrupt is caused by a non-fatal RAS error, ski=
p
+        * check for fatal error. For fatal errors, FED status of all devic=
es
+        * in XGMI hive gets set when the first device gets fatal error
+        * interrupt. The error gets propagated to other devices as well, s=
o
+        * make sure to ack the interrupt regardless of FED status.
+        */
+       if (!amdgpu_ras_get_fed_status(adev) &&
+           amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY))
+               return;

        if (adev->nbio.ras &&
            adev->nbio.ras->handle_ras_controller_intr_no_bifring)
@@ -2185,6 +2195,7 @@ static void amdgpu_ras_interrupt_poison_consumption_h=
andler(struct ras_manager *
        if (ret)
                return;

+       amdgpu_ras_set_err_poison(adev, block_obj->ras_comm.block);
        /* both query_poison_status and handle_poison_consumption are optio=
nal,
         * but at least one of them should be implemented if we need poison
         * consumption handler
@@ -4083,16 +4094,56 @@ bool amdgpu_ras_get_fed_status(struct amdgpu_device=
 *adev)
        if (!ras)
                return false;

-       return atomic_read(&ras->fed);
+       return test_bit(AMDGPU_RAS_BLOCK__LAST, &ras->ras_err_state);
 }

 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status)  {
        struct amdgpu_ras *ras;

+       ras =3D amdgpu_ras_get_context(adev);
+       if (ras) {
+               if (status)
+                       set_bit(AMDGPU_RAS_BLOCK__LAST, &ras->ras_err_state=
);
+               else
+                       clear_bit(AMDGPU_RAS_BLOCK__LAST, &ras->ras_err_sta=
te);
+       }
+}
+
+void amdgpu_ras_clear_err_state(struct amdgpu_device *adev) {
+       struct amdgpu_ras *ras;
+
        ras =3D amdgpu_ras_get_context(adev);
        if (ras)
-               atomic_set(&ras->fed, !!status);
+               ras->ras_err_state =3D 0;
+}
+
+void amdgpu_ras_set_err_poison(struct amdgpu_device *adev,
+                              enum amdgpu_ras_block block)
+{
+       struct amdgpu_ras *ras;
+
+       ras =3D amdgpu_ras_get_context(adev);
+       if (ras)
+               set_bit(block, &ras->ras_err_state);
+}
+
+bool amdgpu_ras_is_err_state(struct amdgpu_device *adev, int block) {
+       struct amdgpu_ras *ras;
+
+       ras =3D amdgpu_ras_get_context(adev);
+       if (ras) {
+               if (block =3D=3D AMDGPU_RAS_BLOCK__ANY)
+                       return (ras->ras_err_state !=3D 0);
+               else
+                       return test_bit(block, &ras->ras_err_state) ||
+                              test_bit(AMDGPU_RAS_BLOCK__LAST,
+                                       &ras->ras_err_state);
+       }
+
+       return false;
 }

 static struct ras_event_manager *__get_ras_event_mgr(struct amdgpu_device =
*adev) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras.h
index 6db772ecfee4..b13debcf48ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -99,7 +99,8 @@ enum amdgpu_ras_block {
        AMDGPU_RAS_BLOCK__IH,
        AMDGPU_RAS_BLOCK__MPIO,

-       AMDGPU_RAS_BLOCK__LAST
+       AMDGPU_RAS_BLOCK__LAST,
+       AMDGPU_RAS_BLOCK__ANY =3D -1
 };

 enum amdgpu_ras_mca_block {
@@ -558,8 +559,8 @@ struct amdgpu_ras {
        struct ras_ecc_log_info  umc_ecc_log;
        struct delayed_work page_retirement_dwork;

-       /* Fatal error detected flag */
-       atomic_t fed;
+       /* ras errors detected */
+       unsigned long ras_err_state;

        /* RAS event manager */
        struct ras_event_manager __event_mgr;
@@ -952,6 +953,10 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, =
struct device_attribute *a

 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);  bool am=
dgpu_ras_get_fed_status(struct amdgpu_device *adev);
+void amdgpu_ras_set_err_poison(struct amdgpu_device *adev,
+                              enum amdgpu_ras_block block); void
+amdgpu_ras_clear_err_state(struct amdgpu_device *adev); bool
+amdgpu_ras_is_err_state(struct amdgpu_device *adev, int block);

 u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event=
_type type);  int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *ad=
ev, enum ras_event_type type, diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_i=
nt_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index d46a13156ee9..0cb5c582ce7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -184,6 +184,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
                } else {
                        reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                }
+               amdgpu_ras_set_err_poison(dev->adev, AMDGPU_RAS_BLOCK__GFX)=
;
                break;
        case SOC15_IH_CLIENTID_VMC:
        case SOC15_IH_CLIENTID_VMC1:
@@ -213,6 +214,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
                } else {
                        reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                }
+               amdgpu_ras_set_err_poison(dev->adev, AMDGPU_RAS_BLOCK__SDMA=
);
                break;
        default:
                dev_warn(dev->adev->dev,
--
2.25.1

