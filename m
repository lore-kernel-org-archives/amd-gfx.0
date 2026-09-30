Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC3BCA5FA5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 03:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36E010F155;
	Wed, 30 Sep 2026 03:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VnFSlZ1d";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F3010F155
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 03:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzbxWKDeXhyQh+HeLZYeviwdEzK11NS9qhyikLLxCHm5R+ETC4jiiypP8wXdpNhrLyVWPnb3jcQkTYnAw8TRYh3yzKK/5Ks7fM8+ViWqx7++qZkCbI91ob+Ff4FYcJreZp7OzTuYcFY8IOQ13mCybCDWEuWZYFIhWxRB0q6V+IVs1zvWpvRFnNbYCDn1VddekaeU7u0FLBe+1QNUMkbUZ4pszzAX6Wm5+EoXlQdu2ZEQBvcSR9qft4xoPeb8Vsia8MOc4RFaIPbs3ZT+cPljHOTvLWcHB+fMbGNpzC+9WZscd219aUjTSzyZyLJzVH3Z2wCI7RQdXOhW7xU/uqFFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvPjvds9j24X3SIZYL3+cYTBs59GtLN223P0iDeFFIA=;
 b=bT7yViWhyJ1uLA/765EO6MU+eYAGRd8TgphEK73JmK+u/VyMvx52k9FX7/t1afmf/7QQzwmACkzA1mv8qJr7TWYfof3RG3zd/Ts3qjCjG2ckMNOCL/oj+aNZIWHp7Yr9mXJNxrvY9O10g+PzQsaNrCf30abCBUZ1zRmc3DSSOMjKw/Cvz5Ob2l4FTbnAHqv/5aqj+wymdSgtmU3mYqJJs4iBCjcoh85sTcv63NUxMcLdbm4KB5s7bgGUVEjW9ej2fOA7Lx0+TFfrmZ/BmvbG5qKf4b29e8f2mGS4RboekM161PdTfyPqWP3uzpRacFxuAlas8jd2wfjkCiu8JLDNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvPjvds9j24X3SIZYL3+cYTBs59GtLN223P0iDeFFIA=;
 b=VnFSlZ1dQ5uIhrwTkwzfodqiiFIRGxewszNiDNXiN+YiCPYPh3lpDcARikDfMe2OSgoBzOwL5EmOkU5F2qY62QawSigZdVwq37v3NKwbr9lLXGFoqAontzE3dG7om8w1cbsVTSMW+0vWMaUeg4qhdCd/nlhImNRcPsbywEaGMb4=
Received: from CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 03:02:02 +0000
Received: from CY1PR12MB9699.namprd12.prod.outlook.com
 ([fe80::e27c:fbef:402c:4440]) by CY1PR12MB9699.namprd12.prod.outlook.com
 ([fe80::e27c:fbef:402c:4440%6]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 03:02:02 +0000
From: "Wang, YuBiao (Ethan)" <YuBiao.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx12: read xccs-per-xcp from
 RLC_IMU_AID_CONFIG for VFI
Thread-Topic: [PATCH] drm/amdgpu/gfx12: read xccs-per-xcp from
 RLC_IMU_AID_CONFIG for VFI
Thread-Index: AQHdUIYGnirX2X1RPEyCcccyx7aOtrbmbvRA
Date: Wed, 30 Sep 2026 03:02:02 +0000
Message-ID: <CY1PR12MB9699B354F3B08B889E5A8784E58B2@CY1PR12MB9699.namprd12.prod.outlook.com>
References: <20260930024711.70728-1-YuBiao.Wang@amd.com>
In-Reply-To: <20260930024711.70728-1-YuBiao.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-30T03:01:34.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR12MB9699:EE_|DM4PR12MB7600:EE_
x-ms-office365-filtering-correlation-id: 2a2fa39d-44ec-4600-ae44-08df1e9f3364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: cOZQmI/sCl6eqFjNwmqu8HhBplLyy6xAdUe1Q+etl+bdt/xi+uE9EGT4xADflsZb47oZynnEu1zVeBbPjZlEVHXiD7/VMiu8dahlQXQ4Upi4BHd31COs1ugCYYb37t6UVEm9IyiyEfBgLdbHKQGseotzzDohcwAcyrNYf6gklHjgKmOD2Lju1ZAg27ZnLfTehLdTFr0+cJgux0sq7f4llXJLNfZa41YJx7MAJSmHHi9pDdN5F7bSct7JWyG4DKv9P75YxiRg5lwtlTaMqJHnMatgW2a+ZvSrQXCYSOta91JzmLYg7+9PRY6IMqFmyhMbF9ceGl+wlOkWHDBHlhqMUBCMJZHXYHJUS4jD0P9Z6UXTAc1lJLjRZY0r18vAeug+yspzbX7G2elHFPt40oMW2yHLgGTSM/RctY0QBY0Njdtcf8GSagNBsvbQZkKF750iLWFTQjobJXAXD9ssevdaOFCEIXWgfRKbyuaYU1lBQnYTytFpojYOwZW5JIX7MFdplJFh9yJ5UhAuqgl1mSL6H1n5dDg5PbcrJZc8KIvfbNb08jun9pleCyozIhdahICMMTBSCU9lALWfRAu5nFObpQnSxA3F6XgfWkhk8EqTgxm7A0sZUN738qvFArrRxfQKGB7tp1skZ/20vWmJgwDuEtNmQSmZZp/uGGDNRouOtM8OBtzJYcYU4j82t4AvnxdE/Q1jZvzkpz+0yB6fwnYWEU6q+Sh8J4esPsKr+HuhdAE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR12MB9699.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XoZIhSOdqtf8eRbgAbcZGXdq61ZhZLCT299NSI2/UWkNzhsfbHT3tDVCfRWI?=
 =?us-ascii?Q?EmorFuXSQRnwBqsB6ZuWH7PQRSnHEQ3G44k5TYzOb2yKglA8KHuApGlVfwh4?=
 =?us-ascii?Q?PPSyxlsLrOSqkLEX8BqMyiRGnPVRwRmPMDDN8YhMFmERIG9sQy8BPcoxb52u?=
 =?us-ascii?Q?vjXIoNPhA8Ut88ENVAqUlZShUfIReRIoANlZKhQnk6vQLLflvbxuzWBQRuP6?=
 =?us-ascii?Q?D5pQ+LeMUQWKKvIBkpxZqsMIdrGsRxf8IzGZKGJ8RWajh9wY2Ya1sRNi+L4N?=
 =?us-ascii?Q?ph1ZtNEPbW+BQFm/nmcNWwedjcd/nWMTFm1q8Id8Xwge9tQ3TnF8f1vFZiOI?=
 =?us-ascii?Q?JVIHPuXw5hb27VS88uMp8+SxIiyA7gs1SDjecod6ajyx1+3zp8/O2SI8CHiI?=
 =?us-ascii?Q?rXYgSh/i0nrcqVckun9dT+0ZG+aEOJwvcKp8y4oP/ibWxPjAfqWImX6T4E+S?=
 =?us-ascii?Q?NCFiiPFnfZLjCwW0Pa04nmMSQBseTjGuK/vFHVJINUsEqjOeg1aGg99IHYRZ?=
 =?us-ascii?Q?NmZvytC+VEUFrv5W65CH+1fNrrippq2J7KASkzo3zniTO54/16wBOLcjxTx0?=
 =?us-ascii?Q?KzvBt2Vpt0KyCnL+fpK6FnGQSJ/tuPQ5AG6b8TZf0NtNjUvQEPlvAKXWZuE6?=
 =?us-ascii?Q?Zm+mlPJdMYwHT3ICRaSzd9Yl45PwMCm8zPafiBlMkRSM5VnkQmoZ1n7L60Rb?=
 =?us-ascii?Q?QDeUSxCwjkfxErAwXfEwbJLS9teLx92qRUw3XFQhhn62KDyC4B9yK/9YO2Kl?=
 =?us-ascii?Q?SOQL7A8ZQoA6q4y0wZtzi2Hi2C7vcfnOKRtPoOnJA5E66/ZiDH1sCgu+cRPS?=
 =?us-ascii?Q?awp3w6i4RY5cSaK6pO3ZAmSYy3zKEXc9jiVfcAgZMiViAUdyzUgGQVTe2xp0?=
 =?us-ascii?Q?Jv+dsTPdIiFi7qAFmRrqZLAtZKdEzUIBrThRjcxXL0zLeFOD0+9ob/VHQHm0?=
 =?us-ascii?Q?1UgzBChbIgVtahW3n2NbqJrCbV5CO2Ys0PeXJIL/9gVA9RYjVh+713qjGf58?=
 =?us-ascii?Q?0s6wEgrtp8aauiF0wmiLxWSEVFvBN8OU5T+eK6f2QUBxWwhBBcebJ7GWbaDM?=
 =?us-ascii?Q?eDnsJ0x6XD28jaDd9qeIgvAFpByK45s2J4OMdJyMc+ThyyKaxKeA/sYwInyo?=
 =?us-ascii?Q?zOUxQi1iREtZ0FVGJu9ImGoVdGqP9VJ8KPqP2T/7bLXnOWCFt/OG+TQBByg1?=
 =?us-ascii?Q?nOyW3sfyb4AemgEmORV3WOERX5hU49XovbAAJcLx/h3bv6lA0GKZBW2+ohFF?=
 =?us-ascii?Q?xTIlzTbvUU/JHtgEV4SoqTwSxEiQEiLwU+ZtYD2mVl/9oW0QylSt4toi97b2?=
 =?us-ascii?Q?8xzLn4y/x+QuftUBSloFCcJs563X5lw07cvB/uQUBenVgyYpN12NT6REAA8h?=
 =?us-ascii?Q?ky0WjxJhgTeiIiiG5sljlXCUS4pYaAxChRu35yAaOFbCzky5HPv/5Fkn+Mh0?=
 =?us-ascii?Q?ULEayMmcEnnGCDKRSm2Hu6CZSq3Io6e4Szee+ivv5AqBAY6Tf1zn2TpqzlGI?=
 =?us-ascii?Q?SYCsbFO2uq0y0RHhSoU2cx7O9RF5mx89vtP9TUiDBQ0bwrCTtiWPbI1tF4tb?=
 =?us-ascii?Q?bEXvH8rWiO5KMyvSx6DSf7EBXbpu1oNMCBdR8hTUjcGPfHpyDhbgbK3htw61?=
 =?us-ascii?Q?X16bCzxvFbPO0tuOT5D8V2O3JvPfzs74E3Mv60BMVIyo4YzdC25Kfek3pHkH?=
 =?us-ascii?Q?+bl66g20OlhixccOu1Pjfl4Sy6QxSTAagOf8RwH/nVpU1473?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2fa39d-44ec-4600-ae44-08df1e9f3364
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 03:02:02.0328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qE0NpscOWtji8QaF3MrJbjwXTSo0nt4AFHvnstNpQWfE85kHwzW+Auboa00lY9llq1iclQE5cltJj1qygukF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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

AMD General

Adding the CC list.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YuBiao W=
ang
Sent: Wednesday, September 30, 2026 10:47 AM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gfx12: read xccs-per-xcp from RLC_IMU_AID_CONFI=
G for VFI

gfx_v12_1_get_xccs_per_xcp() supplies the compute partition layout that
gfx_v12_1_cp_resume() needs on a VF. Once VFI is enabled the VF reaches reg=
isters through RLCG, which cannot access the GFX_IMU registers, so the GFX_=
IMU_PARTITION_SWITCH read stops working. Take the same field from RLC_IMU_A=
ID_CONFIG instead, and read it with a direct MMIO access rather than RREG32=
_SOC15, which would route back into the RLCG path.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c              | 13 +++++++++++++
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h  |  2 ++  .../drm/amd/i=
nclude/asic_reg/gc/gc_12_1_0_sh_mask.h |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index 1cf175aac4de..4498e253846f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -703,6 +703,19 @@ static int gfx_v12_1_get_xccs_per_xcp(struct amdgpu_de=
vice *adev)
        u32 reg_data;

        /* the register data is expected to be the same on all instances */
+       if (amdgpu_sriov_vf(adev)) {
+               /*
+                * RLCG cannot access the GFX_IMU registers, so take the fi=
eld
+                * from RLC_IMU_AID_CONFIG and read it without going throug=
h
+                * the RLCG path.
+                */
+               reg_data =3D RREG32_NO_KIQ(SOC15_REG_OFFSET(GC, GET_INST(GC=
, 0),
+                                                        regRLC_IMU_AID_CON=
FIG));
+
+               return REG_GET_FIELD(reg_data, RLC_IMU_AID_CONFIG,
+                                    TOTAL_XCCS_IN_XCP);
+       }
+
        reg_data =3D RREG32_SOC15(GC, GET_INST(GC, 0),
                                regGFX_IMU_PARTITION_SWITCH_SHADOW);

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h b/d=
rivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
index dbd497d9fac1..249ffb38c05a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
@@ -6649,6 +6649,8 @@
 #define regRLC_IMU_MISC_BASE_IDX                                          =
                              1
 #define regRLC_IMU_RESET_VECTOR                                           =
                              0x4e17
 #define regRLC_IMU_RESET_VECTOR_BASE_IDX                                  =
                              1
+#define regRLC_IMU_AID_CONFIG                                             =
                              0x4e18
+#define regRLC_IMU_AID_CONFIG_BASE_IDX                                    =
                              1


 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_rlcsdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h b/=
drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
index 68dfafd8d027..f4a21a8c4e1b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
@@ -20866,6 +20866,10 @@
 #define RLC_IMU_RESET_VECTOR__VECTOR_MASK                                 =
                                    0x000000FCL
 #define RLC_IMU_RESET_VECTOR__RESERVED_MASK                               =
                                    0xFFFFFF00L

+//RLC_IMU_AID_CONFIG
+#define RLC_IMU_AID_CONFIG__TOTAL_XCCS_IN_XCP__SHIFT                      =
                                    0x2
+#define RLC_IMU_AID_CONFIG__TOTAL_XCCS_IN_XCP_MASK                        =
                                    0x0000003CL
+

 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_rlcsdec
 //RLC_RLCS_DEC_START
--
2.34.1

