Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F921C04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 09:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40628909B7;
	Wed, 27 Jul 2022 09:01:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD19C34C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 09:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQr/TvqZtUzY6g/vBkFOJkffhZSjvJ0X77kHL4UOT0C1NWSZ1E7LLR8dRmz/0R8v7HmEm3wqpxgckv36fVRY+ushfAp6iqX6mhtYEc5aoN6btoGA7LGbCZZtB6NoNsv6veIfgnNNi1Sxg37SanYiwq7B5um9+fMoneZ0MtyIeu9NF5cHy/opFNUtS1XAYAB/OPN8bI37ldghi/SNXs93HZv8P3aPv4r8dsXfWS0onF/7QIeDwB/AtrqkQ8EotAC09jseYO355PGU7V6EHU5arDckmm7bYHn3DQIaXPXHi+A05P2Sb4+VkCUrc1CEEICm41+kCDhAWM9WrDa6UZAIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mZGx2lBqPp5525t648yR3yzdRG4x1FNiTo+qtkDWG4=;
 b=nHVOD/Drg9N8KaQRpJotGc790rCpcOh/39jWsaQXMpWB+O9zqf3ojvSW6jsbppW9zcm8cq3+EDDBYJIGM9wDWFjWl1Fmam8an+PELyIwi6SCZgwB7OQ5axQBxq7CovcfEPP6OJveV3qChIsceT382NvAn0sMqNTRFyMzqtuFbCyHhREiubX6AMh4ZxiKPbF7zgP5hU3m+sZawILdC9Lg7bkkszVk2fBFv2fOmBuoI8HS3roSVREekC/xL0FkN2Qsg1Jy8wYP3d6OvOwrrNQsyNNnS7a0LsEECOnOHlWzjBobC9ceVokueoJc34W/8/8TOLEbk6SPx6K0hnscPATq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mZGx2lBqPp5525t648yR3yzdRG4x1FNiTo+qtkDWG4=;
 b=EIJspOzNcBEXa+ho6JR3PzKan/RFFRcuImqYBhuzNwVlWCr11+n0HAsNcgNjKUV4VrXZpCdoQ0CHpAuqlIVR66n1ptXwR/DhPt0fBRRK0Yz5tBfUaFzZltIUJBxtjWZOrsrzj/r4rCK9kjySGwu2oXsZUZLfngOVFstquGVkh/4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4747.namprd12.prod.outlook.com (2603:10b6:5:30::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 09:01:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%9]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 09:01:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: add additional page fault settings for
 gfx11
Thread-Topic: [PATCH] drm/amd/amdgpu: add additional page fault settings for
 gfx11
Thread-Index: AQHYoZcxD/XdoJuhy0GUvU9XUOKGMq2R63zA
Date: Wed, 27 Jul 2022 09:01:06 +0000
Message-ID: <BN9PR12MB52574258F3AEDFCCAA6EE8C6FC979@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220727085909.9206-1-Jack.Gui@amd.com>
In-Reply-To: <20220727085909.9206-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-27T09:01:04Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fd016638-e99a-4af3-9b62-9b1cbed05c1a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5e17026-4602-4184-a9f3-08da6fae8aa8
x-ms-traffictypediagnostic: DM6PR12MB4747:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PiUOD9BVRX7j1oQ2JBqIArvfaAulAoaeZUZOxAZaWUxha/zh/hVH3yzV+vEoZfdU3UZG295DhysSdc/tdrwTcNhoFnKlcSAktP5ZcWDW+ZxFMJoi4/8HO30w3UaI64uJbyci8loenDRuIh1WamxJmgJqCAEWnsSjYbuX+EHpUUBFf21Y08r+59VOwPp+Kva6FFhykrb4gZkzHXzU6N+x1oXgsfFUweVcu6r+dYwX6+69JRc6/V5C3NndQWgAZCdvYcOK1uOo29Izbm3KcDuPSgb7m/xfQWBLlulPnZvHyareoEfnFppDznYZgvDTZd+WFEkOVFLYz+/AjQq+M6p+K4NcMuseUoqu9KBQSV9LQzuVw2BoeHAYv1dptgaBTguryyVW9BgymK13NmWCXTo4qC3VuTYRk0baMQg9JVaQlRzIYDXfLi5/mq2+lLOGlbQUUq42OrXi3rqyGT6PnnWNOODib3bCELDsC1s//gwlFJ9bFjpOj5V8mLtcD1ZvQjVodYhS12nTeQE+2RMcOPPwuv8RLXDff/jcXbXMFJXLnppIT9uK59NieotDhKE7ZK4EXZOsxl0QqHAaZ2HCUweyuI43bILU5eTjeh3Qkn0FsmHa44Nkg8qXFWslL5raLcu6+r/Ci1djFHxN3gZlQzhuOoM1iF1xay6fDV5JKwPGE2Qkryd3/8WFiR9yoCmpKGHeX2RevFD34/sIS9dmI4rGsQvZocJwkxDNJb/k5b70sfCOuDkxDYjchq1NjpDYPWgAfdsnKnGZuZ6YveoB2lb+qcX2sToJI/WXdql42czqh/GF8zkKnXZJX+2L2BrjN31n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(66446008)(53546011)(66476007)(64756008)(66946007)(4326008)(8676002)(8936002)(76116006)(9686003)(33656002)(52536014)(66556008)(71200400001)(478600001)(5660300002)(316002)(122000001)(38100700002)(26005)(6636002)(38070700005)(55016003)(186003)(41300700001)(86362001)(7696005)(6506007)(2906002)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oODDUaD3qhn9jywv8obbtKJQeF2rH6h5bGzs+EYIDwAgxtaRK1IA5OGi8lkz?=
 =?us-ascii?Q?8GrvTlHHgGmUCb2F7b6SphV5+cI4N31fDRzJj/uKtjaXrOmISIwi/FcQSHDM?=
 =?us-ascii?Q?G3op76hBtZFx4XOrofKqsm/7JRuGRGqAS8IsjFnI0PsVIT0f/+4RzrlOQ+A/?=
 =?us-ascii?Q?UlGkQY+ipcOE5nkDFaRXoFweCb5+pc4EbMar/AxCL571Ts1q8xWRIBeKSkgI?=
 =?us-ascii?Q?0FqxaqtcL0vAGlh5d5U3XZE0I+Vmof8SSDDUUKruru1dBL06SqVf3WllXezO?=
 =?us-ascii?Q?Epb5k63SlsOcC605soAH7IgysmBiciVbhObN3htQwAvYXqtB4a8zxUB4/hPn?=
 =?us-ascii?Q?tRgAzewIYs60L2CWxps6jcTnTRoIinShRhD+P0LGDMaF8e1KTcjMzXW5j3yC?=
 =?us-ascii?Q?1z1UZ+lm2rRR8acP9X2rymhfSbmqbrO3T1U1GzzaIiVQqgjY4Q8jBFlEcLSd?=
 =?us-ascii?Q?CEFqrZeIKP4j11IeTRnSZFgK9b0K3es+YFAYGuqSleZ5r/AFhnNXJMBvNYbh?=
 =?us-ascii?Q?ewSGnA7OxBuI5IoJ7FtqE4AIY/w9pl3qEivgv2QtHBvJqkIW9zdcwbik3Uqd?=
 =?us-ascii?Q?udyxUSO4xSEuT/uWuWnm1unZrCQ1QUN33qBY8mnQBtj/lQ6mqSoEIse/JG+D?=
 =?us-ascii?Q?D1sOFTplCfEvAc+03RsymRV3RxdOT9VmA//XYQRbLCQXVQv8nJ0T72DbEdYl?=
 =?us-ascii?Q?5PPQQhyUhdi0PHm4LnKVLnW/MeUh1b0tVyRCvVvQ1xrZNDdeFWDjPvUrPzGP?=
 =?us-ascii?Q?NlxJ4F/UjwSpnrqIWL9Xugfv9ozSWjCYlEmSkIQUXgHPclmUzjfZPDN7kMpS?=
 =?us-ascii?Q?aYq/CH5sNnnmEBC1AYREj9yvrECdNFqTtR6qOG5b7TcSGGlOz4IeGb+f4qYl?=
 =?us-ascii?Q?K5z0PfzJmOea859egKI2KiJTy/6aQns+esEdXm9RfPt63Lu7RyWrd+UjwiRj?=
 =?us-ascii?Q?5hPtfBlcahRLcrxbygUNArdv17eQ6M8ee02N6ps/PUrvRpSJwMZbDS0uBqWu?=
 =?us-ascii?Q?mBWNGn2gyClcacZ7vgx0/vYcFkozGbjRZXzWKMDsTOyAVnMVwUV4BFlhUpnt?=
 =?us-ascii?Q?u45zlDBM7VEo8vZpMjmrQZxF8CSn1ufD4P5TWe5ac4Kq0EG9z1KoqPn9Kpb7?=
 =?us-ascii?Q?gmtrJeepIzUr0IBTjWdzLNVafGOGtmbGDbqpebMdreHsnwazNzBPhW3RrohD?=
 =?us-ascii?Q?9ZsLh4G5p2TsZ7ApsZ9/tLwDxI60khm5coKF9yZvIogQeOPey8tM8VKqvj+o?=
 =?us-ascii?Q?uIyoxytGBGw68uDUwSzrjiiEF0oXlHYY2gQcEvbD2cJ0oj5oqw1rjKvHPiXj?=
 =?us-ascii?Q?JntjAgM6ZhWMslXnbocYUnPEJm/rPqWT3/No79ZFantLTPjeTdA3wuwedenI?=
 =?us-ascii?Q?vxpadYEh389naCvzcg0+mZUYeoNIMrnt7EiPLB074KE9Di3/TNyGiLrE5UUM?=
 =?us-ascii?Q?lhIQ6E4lZ/FBjVF+5euv7eqXdfDAt5u/ZB6AJN995mXAYOLQpjK3pUjqwb8D?=
 =?us-ascii?Q?rYjoN9HTQCfl2brfROozguHUJerVBmIDCV6K6zSSVv3bKZuyq06LnByDx+0B?=
 =?us-ascii?Q?8wFMuYUzd+v75x7LegRrRTxAXOaAJqUeb7eh07kV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e17026-4602-4184-a9f3-08da6fae8aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 09:01:06.7023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tl9bngGzw30Bb8h6pxSemTJWW4xWN59RZzx3mlK0Fmw9WNkIaRjBxV5FPDVooSElFy6ojVtB589cMm/T3vyUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4747
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
Cc: "Gui, Jack" <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com>=20
Sent: Wednesday, July 27, 2022 16:59
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add additional page fault settings for gfx=
11

Add three additional page fault settings.

V2: move reg offset definition to header file. (Alex)
V3: add all shift/mask definitions of used reg. (Hawking)

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Ibab979853fd233a1c2017672f2534947fa1d637d
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c      | 32 ++++++++++++++++---
 .../include/asic_reg/gc/gc_11_0_0_offset.h    |  3 ++
 .../include/asic_reg/gc/gc_11_0_0_sh_mask.h   | 25 +++++++++++++++
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v3_0.c
index 5eccaa2c7ca0..0e13370c2057 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -26,13 +26,10 @@
=20
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
+#include "gc/gc_11_0_0_default.h"
 #include "navi10_enum.h"
 #include "soc15_common.h"
=20
-#define regGCVM_L2_CNTL3_DEFAULT		0x80100007
-#define regGCVM_L2_CNTL4_DEFAULT		0x000000c1
-#define regGCVM_L2_CNTL5_DEFAULT		0x00003fe0
-
 static const char *gfxhub_client_ids[] =3D {
 	"CB/DB",
 	"Reserved",
@@ -414,12 +411,39 @@ static void gfxhub_v3_0_set_fault_enable_default(stru=
ct amdgpu_device *adev,  {
 	u32 tmp;
=20
+	/* NO halt CP when page fault */
+	tmp =3D RREG32_SOC15(GC, 0, regCP_DEBUG);
+	tmp =3D REG_SET_FIELD(tmp, CP_DEBUG, CPG_UTCL1_ERROR_HALT_DISABLE, 1);
+	WREG32_SOC15(GC, 0, regCP_DEBUG, tmp);
+
+	/**
+	 * Set GRBM_GFX_INDEX in broad cast mode
+	 * before programming GL1C_UTCL0_CNTL1 and SQG_CONFIG
+	 */
+	WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX, regGRBM_GFX_INDEX_DEFAULT);
+
+	/**
+	 * Retry respond mode: RETRY
+	 * Error (no retry) respond mode: SUCCESS
+	 */
+	tmp =3D RREG32_SOC15(GC, 0, regGL1C_UTCL0_CNTL1);
+	tmp =3D REG_SET_FIELD(tmp, GL1C_UTCL0_CNTL1, RESP_MODE, 0);
+	tmp =3D REG_SET_FIELD(tmp, GL1C_UTCL0_CNTL1, RESP_FAULT_MODE, 0x2);
+	WREG32_SOC15(GC, 0, regGL1C_UTCL0_CNTL1, tmp);
+
 	/* These registers are not accessible to VF-SRIOV.
 	 * The PF will program them instead.
 	 */
 	if (amdgpu_sriov_vf(adev))
 		return;
=20
+	/* Disable SQ XNACK interrupt for all VMIDs */
+	tmp =3D RREG32_SOC15(GC, 0, regSQG_CONFIG);
+	tmp =3D REG_SET_FIELD(tmp, SQG_CONFIG, XNACK_INTR_MASK,
+			    SQG_CONFIG__XNACK_INTR_MASK_MASK >>
+			    SQG_CONFIG__XNACK_INTR_MASK__SHIFT);
+	WREG32_SOC15(GC, 0, regSQG_CONFIG, tmp);
+
 	tmp =3D RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL);
 	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value); diff --git a/drivers=
/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b/drivers/gpu/drm/amd/i=
nclude/asic_reg/gc/gc_11_0_0_offset.h
index e5b85bf1d7dc..c92c4b83253f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
@@ -4221,6 +4221,7 @@
 #define regCP_ECC_FIRSTOCCURRENCE_RING1_BASE_IDX                          =
                              0
 #define regGB_EDC_MODE                                                    =
                              0x1e1e
 #define regGB_EDC_MODE_BASE_IDX                                           =
                              0
+#define regCP_DEBUG                                                       =
                              0x1e1f
 #define regCP_DEBUG_BASE_IDX                                              =
                              0
 #define regCP_CPC_DEBUG                                                   =
                              0x1e21
 #define regCP_CPC_DEBUG_BASE_IDX                                          =
                              0
@@ -8306,6 +8307,8 @@
 #define regGL1I_GL1R_REP_FGCG_OVERRIDE_BASE_IDX                           =
                              1
 #define regGL1C_STATUS                                                    =
                              0x2d41
 #define regGL1C_STATUS_BASE_IDX                                           =
                              1
+#define regGL1C_UTCL0_CNTL1                                               =
                              0x2d42
+#define regGL1C_UTCL0_CNTL1_BASE_IDX                                      =
                              1
 #define regGL1C_UTCL0_CNTL2                                               =
                              0x2d43
 #define regGL1C_UTCL0_CNTL2_BASE_IDX                                      =
                              1
 #define regGL1C_UTCL0_STATUS                                              =
                              0x2d44
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h b/=
drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
index 119c97b28fea..4f08f90856fc 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
@@ -29424,6 +29424,31 @@
 #define GL1C_STATUS__TAG_EVICT_MASK                                       =
                                    0x04000000L
 #define GL1C_STATUS__TAG_REQUEST_STATE_OPERATION_MASK                     =
                                    0x78000000L
 #define GL1C_STATUS__TRACKER_LAST_SET_MATCHES_CURRENT_SET_MASK            =
                                    0x80000000L
+//GL1C_UTCL0_CNTL1
+#define GL1C_UTCL0_CNTL1__FORCE_4K_L2_RESP__SHIFT                         =
                                    0x0
+#define GL1C_UTCL0_CNTL1__GPUVM_64K_DEF__SHIFT                            =
                                    0x1
+#define GL1C_UTCL0_CNTL1__GPUVM_PERM_MODE__SHIFT                          =
                                    0x2
+#define GL1C_UTCL0_CNTL1__RESP_MODE__SHIFT                                =
                                    0x3
+#define GL1C_UTCL0_CNTL1__RESP_FAULT_MODE__SHIFT                          =
                                    0x5
+#define GL1C_UTCL0_CNTL1__CLIENTID__SHIFT                                 =
                                    0x7
+#define GL1C_UTCL0_CNTL1__REG_INV_VMID__SHIFT                             =
                                    0x13
+#define GL1C_UTCL0_CNTL1__REG_INV_TOGGLE__SHIFT                           =
                                    0x18
+#define GL1C_UTCL0_CNTL1__FORCE_MISS__SHIFT                               =
                                    0x1a
+#define GL1C_UTCL0_CNTL1__FORCE_IN_ORDER__SHIFT                           =
                                    0x1b
+#define GL1C_UTCL0_CNTL1__REDUCE_FIFO_DEPTH_BY_2__SHIFT                   =
                                    0x1c
+#define GL1C_UTCL0_CNTL1__REDUCE_CACHE_SIZE_BY_2__SHIFT                   =
                                    0x1e
+#define GL1C_UTCL0_CNTL1__FORCE_4K_L2_RESP_MASK                           =
                                    0x00000001L
+#define GL1C_UTCL0_CNTL1__GPUVM_64K_DEF_MASK                              =
                                    0x00000002L
+#define GL1C_UTCL0_CNTL1__GPUVM_PERM_MODE_MASK                            =
                                    0x00000004L
+#define GL1C_UTCL0_CNTL1__RESP_MODE_MASK                                  =
                                    0x00000018L
+#define GL1C_UTCL0_CNTL1__RESP_FAULT_MODE_MASK                            =
                                    0x00000060L
+#define GL1C_UTCL0_CNTL1__CLIENTID_MASK                                   =
                                    0x0000FF80L
+#define GL1C_UTCL0_CNTL1__REG_INV_VMID_MASK                               =
                                    0x00780000L
+#define GL1C_UTCL0_CNTL1__REG_INV_TOGGLE_MASK                             =
                                    0x01000000L
+#define GL1C_UTCL0_CNTL1__FORCE_MISS_MASK                                 =
                                    0x04000000L
+#define GL1C_UTCL0_CNTL1__FORCE_IN_ORDER_MASK                             =
                                    0x06000000L
+#define GL1C_UTCL0_CNTL1__REDUCE_FIFO_DEPTH_BY_2_MASK                     =
                                    0x30000000L
+#define GL1C_UTCL0_CNTL1__REDUCE_CACHE_SIZE_BY_2_MASK                     =
                                    0xC0000000L
 //GL1C_UTCL0_CNTL2
 #define GL1C_UTCL0_CNTL2__SPARE__SHIFT                                    =
                                    0x0
 #define GL1C_UTCL0_CNTL2__COMP_SYNC_DISABLE__SHIFT                        =
                                    0x8
--
2.37.0
