Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2693FC05027
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 03:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD0810E2C5;
	Tue,  7 Feb 2023 03:22:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96C310E449
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 03:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN5vZqbskmTOWvCacEYmdV3ZMpqn7N3+7gXmMbpZtziSRrSE6WE/uD2MzE4FG4Zn4+FABZMG94mb18zYe4r7W5yGerGIZxNm1fFX3JaS0im5fUir1bFeN7XO+C7+YFKlWJwGsLFnAO+t5AvPsGKBiaXEUv9DkThzDOv2EntpO7HR4I+nGWNaz0wrRncIeP32/OOx0NChLFzl34IiOrARGQgp2eQUCNG9QctnlTqDQ69a+b6SsqkaiY7oL1mbIQHbRfWHWQqFfY080sZ+pQfNc8d3OpUAO8eoKL8DDZhchxtMVxEph0bjBnjBgIIrYiK/1dXa2/I/Sp8kDH1QwfYExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk5NiuF2CmrKcHwM7kABSyyfeFTM5vZUokGx/k8cpNM=;
 b=LNNzqRaE6ijxOcbykkOdJit8we8xu0wzC68tCH93NkdmAxZRgPhY1pqGfqA3HsUXLFmPTDfncJHB6kV2xeCbIDKCGyi00nyx0RX7tk2ruR2sFIR316vE1K3ZRKSxK9RSDLbft7o63f2eQ+B4BtNWMtApZAdZMgh7UIz+vuncy251SefH+8fI1cbM5zui+WJJc/pqL/2cP7Sj5ZJc7x1fCewifSyUzjpIrjjK/05MfaY3QoQEjsAAclN71CEIYL7SW6VUUEWr2D7gq40TlL7LUglVaT1OKS8qv3me2owzJddFRjXNg4s38D7GsPr9GIN8gblBMMe4O1wMKdPz7oZN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk5NiuF2CmrKcHwM7kABSyyfeFTM5vZUokGx/k8cpNM=;
 b=gJu0E3s4L554T8DfDTSYC1SwhPyrNA8WUDsOpFKZ9vol+v8Kuc4nutHisAabDjAH1ASyr2T+XdBnAgCUGv4fc4TtPzS7ktDDSqa2oYQE0pwTVmo8EsF8v3Zt5b5HH8eFRFXfgCJJnC9ZFz3x5VnPHEvSgfAFZ6gydoXwlWGZo0E=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Tue, 7 Feb 2023 03:22:14 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::d068:807d:11c:eee0]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::d068:807d:11c:eee0%5]) with mapi id 15.20.6064.029; Tue, 7 Feb 2023
 03:22:13 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: bump SMU 13.0.0 driver_if header version
Thread-Topic: [PATCH 1/2] drm/amd/pm: bump SMU 13.0.0 driver_if header version
Thread-Index: AQHZOp7NNMZ9w9YqmEqopCw5FAhRm67C0Vvg
Date: Tue, 7 Feb 2023 03:22:13 +0000
Message-ID: <DM5PR12MB2469B46E1CF811B2EDA52DFCF1DB9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230207024855.1589467-1-evan.quan@amd.com>
In-Reply-To: <20230207024855.1589467-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM4PR12MB6397:EE_
x-ms-office365-filtering-correlation-id: e8270bf0-c097-4a6d-4d49-08db08ba81b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9OzdYJ08GutLIPWRmmxWF+2k43PCHb3cb0AgOcyvsv8Ktudabi1LosjYDwz7/uH7DbWD/dR4P8IAbbyDDEyb8SAytAh3af4z+HV404k3XnxZYjnj5wBHU3KgIYs4kgGuGwYT498p74QaUxY59aXTYk17iPKodgs4cNGeDMz0E8zA//JzewoSYTrin1cOnP26KzFV5QfjRFPfgjUiLV4I0whVEIHf30p5mg/7K3BJFLS8Djd8oK0jtBBzjIP+zUfavIcyBKVmoSNQDzZ/qNeB4UlJFHZcXwoF6ysProA6u5KtzC23fjzrO6gY5hBlJ1TikRua5t0+gfXAaFfnXxIq7wCLGfA+l7ZbqOvrNfjrdPBIpMEyrfsSeqXQhcJdC4n3h4fqFGqic5XEGh583N2KDhehR5Sj6a7M3V3woE20VGAArff2KoftPW0pMSNUJjMH8/lnEm2HrpKVNoupMJryXUUF7ToeHc8Uc/5TPwghra1yrWSNaCdUgYEgD3PKoGiyOuXOvKzOiwcW2GWCJCTLY3dp44vEO8hawa3OS9FtLFUCn5sjaGdDLmWDt4lH42TznA0y/yIb+1Rtgxyfsrh+6gKtL8ziILFsrxLBgZ1ZcG057PJNsPIPFbpkH4ehi7euJWbKlG9S9fQ+U1O0voU9Pm4aP+rL/1t6vOQYxQPkMY0JLl7ybi67sO2nQZHwSdcLOWcu8vGbo053acZNzQyng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(4326008)(76116006)(8676002)(66946007)(66446008)(66556008)(38070700005)(64756008)(66476007)(33656002)(122000001)(55016003)(26005)(9686003)(83380400001)(186003)(6506007)(53546011)(86362001)(316002)(54906003)(478600001)(71200400001)(38100700002)(110136005)(7696005)(2906002)(8936002)(52536014)(41300700001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oon9CpBx7DXvOu+OQ5/Kpa+MuPo8+WxCmI1Q3XpF9sMqmPCV3XxQdpoxZ2i4?=
 =?us-ascii?Q?sk+o8QmladN9t98AS3tD82poHMK8ZFWth6h6DAXNI0JyNOTBT+147N3xs6Xm?=
 =?us-ascii?Q?6J3H5p4gEIKncG/NjpJ9q412b7w3XF3IG9On9wGpI1ScqqD7bqi3UtNFqA33?=
 =?us-ascii?Q?/szBPIa9XY90oi/xr05163rFOk5Kfo+ZCIMgHrORsGaUI8kDBe7Os67Qftx+?=
 =?us-ascii?Q?yIIRYPFq4JKO8i18SMS0kIXddzoFBCOby3jPacTnR+ewlcy/ukxxW/F+JBDC?=
 =?us-ascii?Q?w9D8Lc7LvUK1zd9zimafDq383kHtFeO6FGXMOs+oIb0k006VTlecS6iNDVD/?=
 =?us-ascii?Q?3pqx+arnsXXLFsskX/88ED9Cas48X0UQRMa15t7BJnbTjkcr0cF4hJnqIjNJ?=
 =?us-ascii?Q?DdCUz1Rmimw2i9065IDeV0YefFFVQCGE60EQ3au4IIMvn+59vygFq/6o+DhH?=
 =?us-ascii?Q?HLtHuKCnqssl6QOoLjKM3YX7w1H6cgaLd78fA9IMnxsAEPR3Qwp2HKOKArzh?=
 =?us-ascii?Q?XfECKB5VozxbDruDYZoKpqkCwagfynG1EU8EXfQiHp4GMMVRWv1ILVhRIygb?=
 =?us-ascii?Q?3nTYWr0YQn8mJMmAhQplPU9zRjH/OVEEwTdO1FqVZ42tLeoJoP9DCXPPzwfy?=
 =?us-ascii?Q?t8gtZn9INnSzLkO1cR7DpCu3M0TfHXl6TZKjvh/znYC2/Ad24ohO4etxxhUA?=
 =?us-ascii?Q?gvLBbwhxHO3ngb5EMxIvLYhkyv4C3I92UN1aFzGmaTkLTm4fksNbQtv6FEMo?=
 =?us-ascii?Q?PRaCJ3SNn6s+lVZ3y2jOx7zrAQDJFY469U4G5yGbGb4tND35H5lmrg3fegD4?=
 =?us-ascii?Q?B0uJKrqDr0TQjtpoUEaosVhSa8keRPK5hV2CIDnvd7GfSX8MA00puqt0+9HE?=
 =?us-ascii?Q?8TYZUWJ8eBBvl6lyxyqiFmzfVcUNn9dJgLKV4hL3m3OmkWMIpLFEKQ9sPq2K?=
 =?us-ascii?Q?9IfGIFk/oBFHajDT9BMmL/ZXbvG7KLMssfHu0B5tt1rohlMiVj5Ku91wsoHM?=
 =?us-ascii?Q?dJ5AIC9BvqAP5ZRQZ+WYp3zCL6ai8XLx+nCWAoaBINQl1MeWm9bx+dAA2F4+?=
 =?us-ascii?Q?+l+kh+2ov+udTPnulrIPDLQV9ItoXQu+wcl1Pdg6IdFcMDPJCz2YBMxoZ/Pk?=
 =?us-ascii?Q?SvTBC9vMbrIDfrjcYqnVR3TqeQd5C7EKBNnBeoUZD0lDjfckKORWVsswx0lI?=
 =?us-ascii?Q?MFC2NCAjk4AZ8GFO0GWT5hHkWI6RRLc2mVEl32aZDoc9k4thzRicNLPRVDhI?=
 =?us-ascii?Q?TYfV++susMiu8mPQIGjrHALBOAs3B59J5+09/O9H7ku04d2LlnwnPuc1tKV+?=
 =?us-ascii?Q?zm4JJ/sHGwvgrNcvDVow9d114GWrlGoU769qmYfuYWIfE/88Lx7zwhgNMT8s?=
 =?us-ascii?Q?k+rgjyuycBcX+7Bg4f54lTWbfgkS51Y7gULO1DksVS+6pHPtAE5vxEiyKZd0?=
 =?us-ascii?Q?gagxgBYlpTCkt45DXIKQSAjOyogs1qhUqhq9si7NNDL7H/1awmLIO2ixoOdv?=
 =?us-ascii?Q?uiKOFsM/JW4pj87i2IWAkfI2faN8EleR3d5Sqt2U4fXGEXdXp4GOUimx0icn?=
 =?us-ascii?Q?lcLBzYkK4VY86Qf68hK3LMSieHx1rp79NOUujhr6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8270bf0-c097-4a6d-4d49-08db08ba81b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 03:22:13.5579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVoMaod6Izclyw6y2JiJzPcC/nK06/rBuoOkWLCqi5JAKCV63EeI59C4cmykDdLkccA3utaFkg9tZEXMz81Q6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Tuesday, February 7, 2023 10:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 1/2] drm/amd/pm: bump SMU 13.0.0 driver_if header version

This can suppress the warning caused by version mismatch.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I5e62de359015ac93b2dfd6a257584a5e6d38e1f8
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h   | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                 | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index d6b964cf73bd..4bc7aee4d44f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -123,7 +123,8 @@
 									(1 << FEATURE_DS_FCLK_BIT) | \
 									(1 << FEATURE_DS_LCLK_BIT) | \
 									(1 << FEATURE_DS_DCFCLK_BIT) | \
-									(1 << FEATURE_DS_UCLK_BIT))
+									(1 << FEATURE_DS_UCLK_BIT) | \
+									(1ULL << FEATURE_DS_VCN_BIT))
=20
 //For use with feature control messages  typedef enum { @@ -522,9 +523,9 @=
@ typedef enum  {
   TEMP_HOTSPOT_M,
   TEMP_MEM,
   TEMP_VR_GFX,
-  TEMP_VR_SOC,
   TEMP_VR_MEM0,
   TEMP_VR_MEM1,
+  TEMP_VR_SOC,
   TEMP_VR_U,
   TEMP_LIQUID0,
   TEMP_LIQUID1,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 913d3a8d7e2f..40adc4fa808a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -28,7 +28,7 @@
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF  #define SMU13_DRIVER_IF_VE=
RSION_YELLOW_CARP 0x04  #define SMU13_DRIVER_IF_VERSION_ALDE 0x08 -#define =
SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x34
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x37
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07  #define SMU13_DRIVER_IF_=
VERSION_SMU_V13_0_5 0x04  #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x=
32
--
2.34.1

