Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5741AC61D97
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 00:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B3A10E5BE;
	Wed, 22 Nov 2023 00:32:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0611610E5BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 00:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrhAuQepLx+PA3VLiWUAHX7+6dfBF8Y7w5x9cc7J5W6pNlP/jhopFwqh/ey3hwu+CYbyOJlOHe7iqIwgfnjiNRLxZC5By5qyFb7Z8Cqh5+P28ByB/25piE9/j8RjLQ5bWpvzjcstPvGgEBZIbqr9KXusyFZliDMgiAwyEdXOBC4XLmWT6viqc742Dn1nZOU67dXGMEDchNY7h7UxftRbT5XLRB+FbyS9BONeym+Z1LtGwvGibyqIY7aI802Z5YSRnIy7CovMZYJ//HDYp8rhunLVC/o2nDbiEUu/59XMmXrvAz5JSgktojJqTumMXpeVP9KXVxPREAupGvDlF+HBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v+CvJUs6Q0caqM4ySyrGkTn6gfys5h6eaKui5Z7H1Y=;
 b=Q1VVkPgUavd4Fc1xvjHaj2m2RqMVTblkNJ99FkCXF4Z2zqlOWa92lATG0b5ZiuGpNn05dDZMLkoZNc7zEuaCV1I+jBujxs09pd05GOearrem/MGD1QP1b4avZ/Ql4YaBCLpOyCGO2VBZJ4TDdRY8drgDDwZHTFxKygdrlT7PdIYWxnluIeDU+J11ZRfTmPxmRtKnFEzx+zfADM2R/p+MWo0otXxZtjcdn4bQXJbbZPUv905nKhDpTESedOvqd7FoQLEaSiqKHqUDny+BuXr6E64+MQbsx3VTv0Z1+7Gu1rfqeBJRDe83OC3LHdg6nseL8+qvdJ1KYTGW2aeCTRQ88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v+CvJUs6Q0caqM4ySyrGkTn6gfys5h6eaKui5Z7H1Y=;
 b=P67FXh3jpsiemwTRcNuQQpFzcVjLUISligBlJH6/8gvCH4ZaFQ8JtQKL9wVTNQCIoYz1hmhDbnn1KnsvYaDRKQKJImekGUnwBnYkfwZj3p1UaMTVcf12Oi196Rl+rhsJNqSJ+18RlGr6JmTNE6EJ0JP9xUXjxgdikguKHmoIZ10=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 00:32:28 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 00:32:28 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add init_registers for nbio v7.11
Thread-Topic: [PATCH] drm/amdgpu: add init_registers for nbio v7.11
Thread-Index: AQHaHFqT/riZDfJzQkSnPrDn6U/S0rCFffFQ
Date: Wed, 22 Nov 2023 00:32:26 +0000
Message-ID: <CY5PR12MB6369F69A53F1241FF96417BEC1BAA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231121091011.3283118-1-li.ma@amd.com>
In-Reply-To: <20231121091011.3283118-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dc2c62a5-11e5-4c4b-ae43-2f0872694e0d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-22T00:32:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA0PR12MB4527:EE_
x-ms-office365-filtering-correlation-id: 6da4c5d1-7339-4454-3cda-08dbeaf28102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 07y6sG6ovYVIN7L8vbBY4yrPy6vq0gwzSyZFj2BGuhJvxHM1ci1cG3GfANNQweTKjGehwOBwB/pWu4Vra8y7ixDhhFneYPtvI+8mqBWIPQry0LfwFnaEUVvPktNtHUF/fzAUq4TEqPhfCKi9DiV4oXq67IpWzctsNk5379wYucaEMOtuc5T0qKnYGR9u9BSCm2SplcnI2GfnUwZNaoUgbUPadIcG+dKKWz9n5jd+O2gPl6SUvBzuz7IBPkpVyJLwtLDkRRZ8aVmTW38fcpez42A8Avex265Fayr8Dh9wZT7sgg6rhARXTj+IrKp0PBjeKqsiEGT18ENIBuazZbzd2KnZNBBvffoEWHoOwFP2fZmdC1Wzdb/wSqgWkpcdEYNjVnC0zcZjHdWEetekccVP6/zV9nWYhi/hxO4cMLSx2Qt/5+CEoFf6wib3wBwAtoG6S1YNgiis5ZEB/sIccejiKpDWFjlT2bISzj5gAlKsVmges69pgwbvu/gfdr2qVPK15wDFohWpIrAITvp5zeqCu/i5Rn8tQkR6ADxqPwWf+fe7J85hBRpWnG5frUg7PsuuhNFOY32xveMS0H3twOF5Q1LA/th1V2eUlFzS5yoDTebEucGj5ML+vg6yn/lhNCrB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(71200400001)(2906002)(53546011)(6506007)(478600001)(4326008)(8676002)(8936002)(66556008)(52536014)(64756008)(66946007)(66476007)(54906003)(66446008)(316002)(76116006)(110136005)(86362001)(122000001)(41300700001)(55016003)(83380400001)(33656002)(26005)(38100700002)(7696005)(38070700009)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dAuPz89lRDu/9trChPHGtsD5sMp77Fyg5Vp6z07aaCOIuC/XDYWCEh865KEP?=
 =?us-ascii?Q?hgPGlmBUwNv6ecsaxJAjT73DOHC269JsZWvYR7pCunLRJX/UKZaCVDcBjJr7?=
 =?us-ascii?Q?RBjne1mbPr4Se/kBXhg1Hgt5R6ROZefBToY2ji8700Dnf9TD9tX1JeZw/DmQ?=
 =?us-ascii?Q?BzrcntPOfKq4jKfka5byiI5Ac8PE/OXV987dN4PNoTq4vWCv5Lp/7QgvNNzm?=
 =?us-ascii?Q?GhLY3uyJHyocTEv+TaEvkPWt6oOY0aM0lPVJR+jpViP9liIJ2DyjhT6syX6v?=
 =?us-ascii?Q?wyZr3UFdUJDIzXziTYR9XV92iUQCibI/S18va4snmvMCWB9he4xMleeCuTzo?=
 =?us-ascii?Q?iuFmNoWURW7s4rKsBAEkpgsXrrETeeVBEEsHY2BNZ1IqpsVCkSDAfyQqqWN2?=
 =?us-ascii?Q?8TZ0nW00NBP+M9twNUoxKqKfqclxX6jZiunUfqmkb5K7zfcpAy6v3WQ10wGh?=
 =?us-ascii?Q?0ABBT7L1OY6jR1PjA/2bcTAdi2z74yZeU0oDwApA4UpiRQKUTIzpta8Vner1?=
 =?us-ascii?Q?AWUcsE1i/izDCWLZP8m8aDfwu78ojoc8/8Ol+Ue5kyqIdQqpgNrg4g5jUoSx?=
 =?us-ascii?Q?dCqebZVerFII5c8+/bBsGEICIgZqEO/tYNW+ilIjsOZj8YepRVngzaLRSpir?=
 =?us-ascii?Q?bgZ42cJ2Uqth2TM42HYEXGicq+H2Dao9ApDwSXWXVHEt2WFS0tv+rn9UHCiX?=
 =?us-ascii?Q?sjkbgLuQrWrbKOxLpR0pBlWC4GM9GTyWKjEigOcQPwNRbdqGu1uQKl4v5k3s?=
 =?us-ascii?Q?lTDji4v4odfWdgbD55F2vhCs4R92itcn5gQmYt5m6Fv/LP8132pa+Q3BQbF0?=
 =?us-ascii?Q?FG/ep0p81uuiM0qIC6uYT2cHfWJY04CImWF+Rtl5IcGK/7ThEVhaBqsdjVNT?=
 =?us-ascii?Q?a8fA2JXD6oom/iJrvZXUHA3Zf2LXcXSZqHvW1sw+qzxNx9ml8uaJ2qr2SmJe?=
 =?us-ascii?Q?gl0GF7sSJAitOX0ADjYGNLbx65RLCC6CjAhYneYMj6D8hS93tqukLRGi7RxK?=
 =?us-ascii?Q?di2b7N6i/zEJOp8NmP2fC1Mh7acYcjoeel6oiCkoLI1fL77Qrcv7VtDFKafg?=
 =?us-ascii?Q?gBGKAr2UuhaKQBX/S13xvsa0IArjaeg2+9r0Ofkb+1YZZWss3pLyM7PC2UI3?=
 =?us-ascii?Q?NlPIszJ7xq9pddUvpLUN/NltrWsCkM4ibaBT8qUE0oMbR9uqz+GiOas46s8x?=
 =?us-ascii?Q?t1tQmGdp9ZFUOoq45hXxj90+pBRsTtxKemQyiL0i676Vlhx4zG2mN68fPnY1?=
 =?us-ascii?Q?9JhGsZBtfOB6SUf6jQBBeoVke0UBKjYBObf7o1jmHJSJot4DLxGT3Ta66XZ3?=
 =?us-ascii?Q?sZXWiatPMKMMZS5nld30k4ymMITrgtH16t5+mwfPK0L6LOeAJV26tt+AP90J?=
 =?us-ascii?Q?bCj0FtgTT63SqjrQrQaXQDNonh3O0nnZeamnm/7PajCzm2JqlPOvTMpoKcGK?=
 =?us-ascii?Q?H39EOsIyS9CHqRZV3EUomT5hMKQ4lgZWg2EjbN6idHvhyjBfVo421OLUxkLT?=
 =?us-ascii?Q?pNoRa1JdMUnoXQgTxf94O7ZEzdPMO7s2KVh9gOohhlUdZ6wcbkXFruIk2GMy?=
 =?us-ascii?Q?kpquIrrGxP6XUzHYSAQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da4c5d1-7339-4454-3cda-08dbeaf28102
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 00:32:26.9885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVA2vMmGoOjOTEh8rkLDA3fMNIKSSs8zhucXkcWdAza8Rwy9xduLLhMYcWQK8Uw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yu,
 Lang" <Lang.Yu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>


-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Tuesday, November 21, 2023 5:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.=
Yu@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: add init_registers for nbio v7.11

enable init_registers callback func for nbio v7.11.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c       | 18 ++++++------
 .../asic_reg/nbio/nbio_7_11_0_offset.h        |  2 ++
 .../asic_reg/nbio/nbio_7_11_0_sh_mask.h       | 29 +++++++++++++++++++
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/=
amdgpu/nbio_v7_11.c
index 676ab1d20d2f..1f52b4b1db03 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -259,17 +259,17 @@ const struct nbio_hdp_flush_reg nbio_v7_11_hdp_flush_=
reg =3D {

 static void nbio_v7_11_init_registers(struct amdgpu_device *adev)  {
-/*     uint32_t def, data;
+       uint32_t def, data;
+
+       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_US=
B4_PCIE_MST_CTRL_3);
+       data =3D REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_C=
TRL_3,
+                               CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
+       data =3D REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_C=
TRL_3,
+                               CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);

-               def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_=
RC3X4_USB4_PCIE_MST_CTRL_3);
-               data =3D REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PC=
IE_MST_CTRL_3,
-                       CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
-               data =3D REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PC=
IE_MST_CTRL_3,
-                       CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
+       if (def !=3D data)
+               WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_M=
ST_CTRL_3,
+data);

-               if (def !=3D data)
-                       WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB=
4_PCIE_MST_CTRL_3, data);
-*/
 }

 static void nbio_v7_11_update_medium_grain_clock_gating(struct amdgpu_devi=
ce *adev, diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_=
0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
index ff30f04be591..7ee3d291120d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
@@ -781,6 +781,8 @@
 #define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2_BASE_IDX                =
                              5
 #define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1               =
                              0x420187
 #define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1_BASE_IDX      =
                              5
+#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3                    =
                              0x4201c6
+#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3_BASE_IDX           =
                              5


 // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.=
h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
index 7f131999a263..eb8c556d9c93 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
@@ -24646,6 +24646,35 @@
 //BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1
 #define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MA=
SK                                  0x00000001L
 #define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN=
_MASK                               0x00000008L
+//BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_PAYLOAD_S=
IZE_MODE__SHIFT                     0x8
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_PRIV_MAX_PAYL=
OAD_SIZE__SHIFT                     0x9
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_10BIT_TAG_EN_OVERR=
IDE__SHIFT                          0xb
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_10BIT_TAG_EN_=
OVERRIDE__SHIFT                     0xd
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__MST_DROP_SYNC_FLOOD_E=
N__SHIFT                            0xf
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_PAYLOAD_SIZE_M=
ODE__SHIFT                          0x10
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_PAYLOAD_S=
IZE__SHIFT                          0x11
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_REQUEST_S=
IZE_MODE__SHIFT                     0x14
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_READ_REQU=
EST_SIZE__SHIFT                     0x15
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_SAFE_MODE=
__SHIFT                             0x18
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_EXTENDED_TAG_EN_OV=
ERRIDE__SHIFT                       0x19
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQU=
EST_SIZE_MODE__SHIFT                0x1b
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQU=
EST_SIZE_PRIV__SHIFT                0x1c
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_EXTENDED_TAG_=
EN_OVERRIDE__SHIFT                  0x1e
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_PAYLOAD_S=
IZE_MODE_MASK                       0x00000100L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_PRIV_MAX_PAYL=
OAD_SIZE_MASK                       0x00000600L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_10BIT_TAG_EN_OVERR=
IDE_MASK                            0x00001800L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_10BIT_TAG_EN_=
OVERRIDE_MASK                       0x00006000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__MST_DROP_SYNC_FLOOD_E=
N_MASK                              0x00008000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_PAYLOAD_SIZE_M=
ODE_MASK                            0x00010000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_PAYLOAD_S=
IZE_MASK                            0x000E0000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_REQUEST_S=
IZE_MODE_MASK                       0x00100000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_PRIV_MAX_READ_REQU=
EST_SIZE_MASK                       0x00E00000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_MAX_READ_SAFE_MODE=
_MASK                               0x01000000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_EXTENDED_TAG_EN_OV=
ERRIDE_MASK                         0x06000000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQU=
EST_SIZE_MODE_MASK                  0x08000000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQU=
EST_SIZE_PRIV_MASK                  0x30000000L
+#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3__CI_SWUS_EXTENDED_TAG_=
EN_OVERRIDE_MASK                    0xC0000000L

 // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
 //BIF_CFG_DEV0_RC0_VENDOR_ID
--
2.25.1

