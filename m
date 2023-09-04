Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D3AC71153
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 07:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F0010E2C1;
	Mon,  4 Sep 2023 07:51:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C79D10E105
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 07:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzFG+uoxgfVRsSrc0ljPIC+cMG/ELqcZiitt5pGhv9OzRzftBiKkXgmRp9vuYnf0yOKG6GNdDLGsT/Qhj3+aZjQKUL0zUX1RZcBNkD68SdclSYAEgSOw90fDs7WT2q6j5pQ89bQ90xB4kspv6LcgLh4xM/x3YfBCafXMDxy+TmkxSkGJUMHzKfnothUM1o8iCYeXT35jdEtWMSArGPSuvP/GsPJCfljTQuaNPoXT0DohioXfLU7l3P7ibqHRpztWyA9yYznklTAV7qttTHxOaTuAKLhUh7+K3U6dfw+GaExodbYmSX2z/OSmhZYfzno8UHP0ZaYh122kLVgB1SEiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXQrEPe6FVZF/jz/XK48J3dZs15qOI+fJ6eeT12b6T0=;
 b=Pt4YNSoyE+P8TJDTUuxQZCYJ58PhtvS2o3PfZioVbvoVw9gIZeThj6yeydkUEnkbbe5wS8FmaTrLCRtRKN+Jo14Lyt5u5FwDOSzwacANzHxPTIWof1/2TIjp2thZVFsy26AUpAv4Sgc+H9eMpY/GEO6q5mLprx2e64amziw75jPu64QBFPem6GMeIJ1BJ+9yKqzHJ/84DOkp9/eRJvO5ZGDvVGvXdbRUjXxkT9lmzI1RzA0wzmQzsLHgQLp1PcKnuBubORe4tbbTV0Lzhmy+WXECywQZjLsDHurod+beOC0EmrTJLPtsNwdYPn1kfCf8BeVvpY3AFRoI8UWoLseQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXQrEPe6FVZF/jz/XK48J3dZs15qOI+fJ6eeT12b6T0=;
 b=AFTlfnD26p8x0/DXSTV6xMtHtFClBgr5mMZAnSWkXbuFY6HlMWmMWPRRmxh3B94bkqhuhH4vOxVDIX5Tv2pjMVMD07FdslztxMeWgytkHHzLLsi/DWUgS5pEk8K+QKfa/MWRimMtcn1HtwlETRZHfOLTKsN6yxOurgYfg830w3g=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 07:51:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20%6]) with mapi id 15.20.6745.021; Mon, 4 Sep 2023
 07:51:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: Add RREG64_PCIE_EXT/WREG64_PCIE_EXT
 functions
Thread-Topic: [PATCH 1/3] drm/amdgpu: Add RREG64_PCIE_EXT/WREG64_PCIE_EXT
 functions
Thread-Index: AQHZ3wAuprVzYWQ7AU2BZ0T2dGTqyLAKSbyw
Date: Mon, 4 Sep 2023 07:51:29 +0000
Message-ID: <BN9PR12MB525796F4E41A8742C83029ADFCE9A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230904071832.58979-1-candice.li@amd.com>
In-Reply-To: <20230904071832.58979-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3394f6f1-7e58-4127-b4c5-1a703cddab1c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-04T07:46:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB8906:EE_
x-ms-office365-filtering-correlation-id: 999ea0a4-a69e-4256-473e-08dbad1bbff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxnqD0TLBJ+YJ2s5zHFa0IY/rgCM+k5fYQOrYgKNivuhgMmrlTYVLFaS8ZakblGFbkHY/WMDCFvHxFRsxP/sPS+mthPnD0wF3feKEvDt9VTCsNJ1w+3qQaT+pWeutHFpDzwL/nMvjnplUYPZwWbT08JSOsRAFskKCiRB9uyj5A6lNo5CY8g0L29REIyEc2BCLNbMIT2rWC0rOCDUwGQDtVkF5tCmaWWn/2HZ7rztw7q663JNhVlo7L/Bd5HQwtEi2LNUfsqyBP1/boidx93a3FZefqrqP4/AF9h3y2oZmPXd84chpbB47/OuQpB9zoIKPmGLSbkUAvIvfRdUXWimhogV364VqR7+NUQLHw4KioGdobJXbB+aayEQ32/9mZOFvuK1uCck/3GxB2DOhGAq7++z88rXCJcMWV212LjZED6JwzpnaX17U9RCyOdtxLjPHA9upZ+Xzt6lUWV6P1DWVF244JzEgvenvMkIwsS903O9tLQQV/lBgHfP398+vhCMuxfDT1/qJdbJjpGqpIWaSgMy2a+lhasAShesKK+RMtsNXOYobi/5GIeDNs283RshFB/5v06iaryphU9jHuxvPSD6jEzyzKUbwpb8wnA3GCbROV9RqyBnzMkg8qEAHXnH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199024)(186009)(1800799009)(26005)(71200400001)(55016003)(8936002)(4326008)(8676002)(52536014)(83380400001)(5660300002)(9686003)(53546011)(6506007)(7696005)(41300700001)(54906003)(76116006)(478600001)(66446008)(64756008)(110136005)(66946007)(66556008)(66476007)(86362001)(33656002)(316002)(38100700002)(38070700005)(122000001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nDvwPMmZUjBAorzOT4KLhxWdEWk8m5HdHgriwgyzbMQkwT2Mo4rzAk9xcHdt?=
 =?us-ascii?Q?YiOog6q5WNa509JDoKOpsUnhWZGzrTYpGMH8xLKRGV/Xm/6A+xDqDuJwpkrW?=
 =?us-ascii?Q?1+XzQLZQVKfiS2PADPo9yBsPQg6EnOYemD4SHp1YQnFul2+px7i5cqLaCuXU?=
 =?us-ascii?Q?HtsRijtbv59h+uh0eRPLmKITlVCdDZg3qC+6YuFlllCMRVac8ArYmBrtMMFt?=
 =?us-ascii?Q?VjE5M+PLxsmEYs1RqT14MYK3k0327QvevGG6WCRduZfNZgow5g5RGpDuG5VB?=
 =?us-ascii?Q?BLfty/PU/S7LqHN/TAg55ofCnmDfyrU+ePQ0QXarIwMohdd2Dh9YtAOM71mm?=
 =?us-ascii?Q?xtsMOhD1bvMbGxJxLl4kcF+e5bVC6f/u0vZvrnlGVSK6LnLIx+ryyNpHpJ/3?=
 =?us-ascii?Q?+E9UNIsxGVMT2jJDhQjLHtRNkXjSMMXadJXbCkyVnm26s3f6NzdJxq4YB6Qy?=
 =?us-ascii?Q?uLUU8/RxKl7HrtUNDssKwPbyNtyrqD7WlZBk+ngevJWp59Vrz1zW48khTVZz?=
 =?us-ascii?Q?m6tpIAIJQc9RFwRtkGwAADq83D1Em0B5re9gujvag43Xi4HMqWdNoR5YU74B?=
 =?us-ascii?Q?q8IfoYay6K4kGRa3ujdEen2m1+Vs9yZ+QDLfuMbA5XsTQvGd/4co1a5KaPIM?=
 =?us-ascii?Q?Diu+vTHiuD5mYJYnxADuI9V9nBAmieuYOSocku2Ptm3KJWJ80fbfMOp/ZE9s?=
 =?us-ascii?Q?cnKFn4j0HTz3hBMixW5kBcIEtpLJyWugo/cACejch8OePfCdCag0YccVCOE4?=
 =?us-ascii?Q?T5cTnog1aY+oBBEQqGQHrULJtptiVFEWzBoFdDUoG3BYE9dz9rQSN3323FFk?=
 =?us-ascii?Q?jF22lNPUdKytQZfxieGgqiR5r3jZw2sgduIXygqZZtdHTAe1brktVFo8Qmgn?=
 =?us-ascii?Q?yVyDPxoo4jbB0xUqeZPibvJgGl4KyfiLmPjpJhk2djyD44eY4YGFiQyXvebT?=
 =?us-ascii?Q?JOrmuaJqkgG1A8Sq16QAEz8rXmhem88jbSd+SvdwuDgfNgDC6fLo+Scx5WrU?=
 =?us-ascii?Q?izrWK6FFMx3Yjvh2mAPaX3PAUeSvQQOiumJlwrY9BmtI6UppIGpNmxuxwdi7?=
 =?us-ascii?Q?Wqr5FD2tF/RkSyXNaHQaV2Ey9IbRnahOR/4TgqnKScJEMSqSuYrslFgvTVbb?=
 =?us-ascii?Q?AeoUdOqDI58yKa7JQRcjj2X6Q7U9p63u0JeVadu9VxOoqw4/dW9uWihdxM/K?=
 =?us-ascii?Q?mm24BwueSR0hAENOevItaDWIzaL3b6wBifvKPwH7eha7/jMtX4MZqTSewKuM?=
 =?us-ascii?Q?y0RzV8MxJSHQFxhN4yZKpn4xQeC6onLf7ZB/AqZ9L4gAQb0UfmLR9Yn7WZJ9?=
 =?us-ascii?Q?jeIvoDuXP6KCrqrnjitk/BQreZxCgNKagSz1SMVwm9MpzFzgp+Z/R+JPKaxP?=
 =?us-ascii?Q?iqaYQnIVQLriWjU6lr/cNvxp+AcWYD7eh2Dj0+NDTdZ/jqM+0IEELxKCmXt9?=
 =?us-ascii?Q?+bCTgnKSVIgNB17Dwb7s0YgYVOyNRssUjIAiyQSn4eAR7g0is9D7ZR65BURl?=
 =?us-ascii?Q?5wpbmTOkXNs5J2PskyFUTwQd1/7CG224SaTtGqibBLam+5ins2dhMxn1hljF?=
 =?us-ascii?Q?kw4I8E5RnHqflKOJ9lV5vqasttEW4nGbzIXInjHM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999ea0a4-a69e-4256-473e-08dbad1bbff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 07:51:29.9005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Io30bEfvIHayzDbgMu9OmhgrIIcZ4+qU/Jv6jMC+TcGZs8Z2KFsn+/h2stNvICu0x1wFDJqDGZQZBPW29Hyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please split the change in amdgpu_device_indirect_rreg|wreg_ext to another =
patch.

With above addressed, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Monday, September 4, 2023 15:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add RREG64_PCIE_EXT/WREG64_PCIE_EXT functi=
ons

1. Add 64bits register access support on register whose address is greater =
than 32bits.
2. Update RREG32_PCIE_EXT/WREG32_PCIE_EXT.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 119 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   2 +
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 45e5db95496906..6ff4289b255bbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -653,6 +653,9 @@ typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device*=
, uint64_t, uint32_t);  typedef uint64_t (*amdgpu_rreg64_t)(struct amdgpu_d=
evice*, uint32_t);  typedef void (*amdgpu_wreg64_t)(struct amdgpu_device*, =
uint32_t, uint64_t);

+typedef uint64_t (*amdgpu_rreg64_ext_t)(struct amdgpu_device*,
+uint64_t); typedef void (*amdgpu_wreg64_ext_t)(struct amdgpu_device*,
+uint64_t, uint64_t);
+
 typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device*, uint32_t, u=
int32_t);  typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint3=
2_t, uint32_t, uint32_t);

@@ -867,6 +870,8 @@ struct amdgpu_device {
        amdgpu_wreg_ext_t               pcie_wreg_ext;
        amdgpu_rreg64_t                 pcie_rreg64;
        amdgpu_wreg64_t                 pcie_wreg64;
+       amdgpu_rreg64_ext_t                     pcie_rreg64_ext;
+       amdgpu_wreg64_ext_t                     pcie_wreg64_ext;
        /* protects concurrent UVD register access */
        spinlock_t uvd_ctx_idx_lock;
        amdgpu_rreg_t                   uvd_ctx_rreg;
@@ -1178,10 +1183,14 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_devic=
e *adev,
                                u32 reg_addr);
 u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
                                  u32 reg_addr);
+u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev,
+                                 u64 reg_addr);
 void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
                                 u32 reg_addr, u32 reg_data);
 void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
                                   u32 reg_addr, u64 reg_data);
+void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev,
+                                  u64 reg_addr, u64 reg_data);
 u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);  bool amdgpu_dev=
ice_asic_has_dc_support(enum amd_asic_type asic_type);  bool amdgpu_device_=
has_dc_support(struct amdgpu_device *adev); @@ -1224,6 +1233,8 @@ int emu_s=
oc_asic_init(struct amdgpu_device *adev);  #define WREG32_PCIE_EXT(reg, v) =
adev->pcie_wreg_ext(adev, (reg), (v))  #define RREG64_PCIE(reg) adev->pcie_=
rreg64(adev, (reg))  #define WREG64_PCIE(reg, v) adev->pcie_wreg64(adev, (r=
eg), (v))
+#define RREG64_PCIE_EXT(reg) adev->pcie_rreg64_ext(adev, (reg)) #define
+WREG64_PCIE_EXT(reg, v) adev->pcie_wreg64_ext(adev, (reg), (v))
 #define RREG32_SMC(reg) adev->smc_rreg(adev, (reg))  #define WREG32_SMC(re=
g, v) adev->smc_wreg(adev, (reg), (v))  #define RREG32_UVD_CTX(reg) adev->u=
vd_ctx_rreg(adev, (reg)) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index de9223b5e6fd76..57b24053e1e320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -574,7 +574,7 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_devic=
e *adev,

        pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
        pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
-       if (adev->nbio.funcs->get_pcie_index_hi_offset)
+       if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset=
))
                pcie_index_hi =3D adev->nbio.funcs->get_pcie_index_hi_offse=
t(adev);
        else
                pcie_index_hi =3D 0;
@@ -641,6 +641,56 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device=
 *adev,
        return r;
 }

+u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev,
+                                 u64 reg_addr)
+{
+       unsigned long flags, pcie_index, pcie_data;
+       unsigned long pcie_index_hi =3D 0;
+       void __iomem *pcie_index_offset;
+       void __iomem *pcie_index_hi_offset;
+       void __iomem *pcie_data_offset;
+       u64 r;
+
+       pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
+       pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
+       if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset=
))
+               pcie_index_hi =3D adev->nbio.funcs->get_pcie_index_hi_offse=
t(adev);
+
+       spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+       pcie_index_offset =3D (void __iomem *)adev->rmmio + pcie_index * 4;
+       pcie_data_offset =3D (void __iomem *)adev->rmmio + pcie_data * 4;
+       if (pcie_index_hi !=3D 0)
+               pcie_index_hi_offset =3D (void __iomem *)adev->rmmio +
+                       pcie_index_hi * 4;
+
+       /* read low 32 bits */
+       writel(reg_addr, pcie_index_offset);
+       readl(pcie_index_offset);
+       if (pcie_index_hi !=3D 0) {
+               writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+               readl(pcie_index_hi_offset);
+       }
+       r =3D readl(pcie_data_offset);
+       /* read high 32 bits */
+       writel(reg_addr + 4, pcie_index_offset);
+       readl(pcie_index_offset);
+       if (pcie_index_hi !=3D 0) {
+               writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+               readl(pcie_index_hi_offset);
+       }
+       r |=3D ((u64)readl(pcie_data_offset) << 32);
+
+       /* clear the high bits */
+       if (pcie_index_hi !=3D 0) {
+               writel(0, pcie_index_hi_offset);
+               readl(pcie_index_hi_offset);
+       }
+
+       spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+       return r;
+}
+
 /**
  * amdgpu_device_indirect_wreg - write an indirect register address
  *
@@ -680,7 +730,7 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_devi=
ce *adev,

        pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
        pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
-       if (adev->nbio.funcs->get_pcie_index_hi_offset)
+       if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset=
))
                pcie_index_hi =3D adev->nbio.funcs->get_pcie_index_hi_offse=
t(adev);
        else
                pcie_index_hi =3D 0;
@@ -745,6 +795,55 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_devic=
e *adev,
        spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);  }

+void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev,
+                                  u64 reg_addr, u64 reg_data)
+{
+       unsigned long flags, pcie_index, pcie_data;
+       unsigned long pcie_index_hi =3D 0;
+       void __iomem *pcie_index_offset;
+       void __iomem *pcie_index_hi_offset;
+       void __iomem *pcie_data_offset;
+
+       pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
+       pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
+       if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset=
))
+               pcie_index_hi =3D adev->nbio.funcs->get_pcie_index_hi_offse=
t(adev);
+
+       spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+       pcie_index_offset =3D (void __iomem *)adev->rmmio + pcie_index * 4;
+       pcie_data_offset =3D (void __iomem *)adev->rmmio + pcie_data * 4;
+       if (pcie_index_hi !=3D 0)
+               pcie_index_hi_offset =3D (void __iomem *)adev->rmmio +
+                               pcie_index_hi * 4;
+
+       /* write low 32 bits */
+       writel(reg_addr, pcie_index_offset);
+       readl(pcie_index_offset);
+       if (pcie_index_hi !=3D 0) {
+               writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+               readl(pcie_index_hi_offset);
+       }
+       writel((u32)(reg_data & 0xffffffffULL), pcie_data_offset);
+       readl(pcie_data_offset);
+       /* write high 32 bits */
+       writel(reg_addr + 4, pcie_index_offset);
+       readl(pcie_index_offset);
+       if (pcie_index_hi !=3D 0) {
+               writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+               readl(pcie_index_hi_offset);
+       }
+       writel((u32)(reg_data >> 32), pcie_data_offset);
+       readl(pcie_data_offset);
+
+       /* clear the high bits */
+       if (pcie_index_hi !=3D 0) {
+               writel(0, pcie_index_hi_offset);
+               readl(pcie_index_hi_offset);
+       }
+
+       spin_unlock_irqrestore(&adev->pcie_idx_lock, flags); }
+
 /**
  * amdgpu_device_get_rev_id - query device rev_id
  *
@@ -822,6 +921,13 @@ static uint64_t amdgpu_invalid_rreg64(struct amdgpu_de=
vice *adev, uint32_t reg)
        return 0;
 }

+static uint64_t amdgpu_invalid_rreg64_ext(struct amdgpu_device *adev,
+uint64_t reg) {
+       DRM_ERROR("Invalid callback to read register 0x%llX\n", reg);
+       BUG();
+       return 0;
+}
+
 /**
  * amdgpu_invalid_wreg64 - dummy reg write function
  *
@@ -839,6 +945,13 @@ static void amdgpu_invalid_wreg64(struct amdgpu_device=
 *adev, uint32_t reg, uint
        BUG();
 }

+static void amdgpu_invalid_wreg64_ext(struct amdgpu_device *adev,
+uint64_t reg, uint64_t v) {
+       DRM_ERROR("Invalid callback to write 64 bit register 0x%llX with 0x=
%08llX\n",
+                 reg, v);
+       BUG();
+}
+
 /**
  * amdgpu_block_invalid_rreg - dummy reg read function
  *
@@ -3583,6 +3696,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        adev->pciep_wreg =3D &amdgpu_invalid_wreg;
        adev->pcie_rreg64 =3D &amdgpu_invalid_rreg64;
        adev->pcie_wreg64 =3D &amdgpu_invalid_wreg64;
+       adev->pcie_rreg64_ext =3D &amdgpu_invalid_rreg64_ext;
+       adev->pcie_wreg64_ext =3D &amdgpu_invalid_wreg64_ext;
        adev->uvd_ctx_rreg =3D &amdgpu_invalid_rreg;
        adev->uvd_ctx_wreg =3D &amdgpu_invalid_wreg;
        adev->didt_rreg =3D &amdgpu_invalid_rreg; diff --git a/drivers/gpu/=
drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c45721ca916e40..63dadd72d2ecf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -919,6 +919,8 @@ static int soc15_common_early_init(void *handle)
        adev->pcie_wreg_ext =3D &amdgpu_device_indirect_wreg_ext;
        adev->pcie_rreg64 =3D &amdgpu_device_indirect_rreg64;
        adev->pcie_wreg64 =3D &amdgpu_device_indirect_wreg64;
+       adev->pcie_rreg64_ext =3D &amdgpu_device_indirect_rreg64_ext;
+       adev->pcie_wreg64_ext =3D &amdgpu_device_indirect_wreg64_ext;
        adev->uvd_ctx_rreg =3D &soc15_uvd_ctx_rreg;
        adev->uvd_ctx_wreg =3D &soc15_uvd_ctx_wreg;
        adev->didt_rreg =3D &soc15_didt_rreg;
--
2.25.1

