Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B342C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 11:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E55C210E86F;
	Mon, 13 Jul 2026 11:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEixQI6C";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA9E10E86F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 11:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewej/MRL4CceP2dBGEcN+vguZJVO1Gn3TAPaGXu36v5/fd6OIgju9Tk0UJVKen58vpeYgc1uvM3qDCcXMGLw/NupY9t4fVN6Vnt1j7bBD6vHGYB6Nej8vAApcAk/+MlX+9BR5qc11Zj0D4UDMdyuy0l5hpywMa7FP4gnVtHWMF8K6uaNHj7vITWGmGILrOqP07Yk7Ntdks5oZB6a41BznCyL5iTwptdB+1Xx+L8X6hSttRxNlWE5ZGkSgOMC2gonljpb+D/JdGnXInuVBf8KzfVvJCqhW0Ttt/+XM1mbR6W31VITLCFGYHoIwNnf6iMFqpXUGJ9h/6P4h6LOjFKdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCJyWYUNZEHiHyauSfnhA32XGZZWw9rJY6CLPvAk7jY=;
 b=Ku7aILw/U6zHj1d8zBPvYr7gnQbwBLhM0msaWx5qfYbyQGpv3Do1d0ULR+utSI9Yw/PxSGJGX8/VhGT64T7DvFNhjHPKA+s1rjM0CfWIjH7CCfYugs4lnVSRAn1OurZHWclblHa5y9sWvGy4K/RNq84gB8e6wowyeOGa3JeRFFgIIYKTOGl8qruzo+K5N8Qg/TDN0U57j+6JWT9AorKkT+ezh6+CyXw+F+31z8z8LD9w1K0MCz2Dst1e5MkvybS4ZYTGNvGewCywzF7B4B7SLh9ukgUSDwSbNW30xvHQKoTPhQ6sjTkf21vn9Oyqa/maQvIZq7QHZvYbOQueKLYFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCJyWYUNZEHiHyauSfnhA32XGZZWw9rJY6CLPvAk7jY=;
 b=mEixQI6CJYKbNCovjwNdjpqjtRIU9u42mfR0+oym5tJBON9ffy3pVVJsyf0RliOLjOAb4eamF0eD/L/xVQ8DF9Q0JCTXo0cPpu8TQDi3Hbo1+GfxZheAyAvxgHLd3ZT+v4Ge9ZFGx1leQvCKQEbypPS3HQD49WS9/0P0Si2k7+Y=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Mon, 13 Jul 2026 11:17:05 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%2]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 11:17:05 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amd/pm: update smu_v13_0_6 acc gpu metrics
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: update smu_v13_0_6 acc gpu metrics
Thread-Index: AQHdD549CAjUBws5PkqujIobP8eIS7ZrUvbg
Date: Mon, 13 Jul 2026 11:17:05 +0000
Message-ID: <DM4PR12MB5748E14B6F1AC354A754C8CE8EFA2@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260709122633.1788432-1-asad.kamal@amd.com>
In-Reply-To: <20260709122633.1788432-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-13T11:16:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|PH8PR12MB7160:EE_
x-ms-office365-filtering-correlation-id: d96ed867-fb1f-4115-2843-08dee0d0451f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: K2Mu2mWyxhQ/I4Q1eX1v8rfPsK0qvfGsjI9wgXtpu1twRZNJmgJy+EZrOwGwnwHERrpWVc4N5fkCL2vWUG/EOz4yk/ND4dfe1m0wpEOoPdYnKdK8dpZhmoludDRkNRwPV/W2u5bfe6aJyY9fDxUdNnVILapEXOoLi59rn73fZ7q7JmTEy+JEykHCj4d2aEyQvUoz2LPws7slYSkQBbJaAk0wrRwHUNf+HdjaOmtrORA2Cs/oU44aQuUV6hEklcC4Sn26qNahkcHNcsBucoOrXHjsrLFKGA55/mflqmoF4oTqgtksJvH5NZI5NN0HFm/vENIOrSHY/qzO5mPRseCiUdT9XJIwNnAJ/AYO4uEQmUWi8B7CuZ7IhahQtOm41chn2pO83xDGSMO9XT3QryUB2ZrtZPHUp3j5rg/F/jfPSdoDVANpbrWquwKO/tL0mO4faR5NFieqjC0YcSGJqr4sGoKNSSFQtipIENHTXCWmdn1Rl+VRZx55j0VKq+5Jm2UmKyxJvZT1gcPT+SwjBeU0av2pc7HOOwaKLYvwyNLf+5giliHQfE0ZPuU5QpuNbD4TzdYv/Uz9BN/rkZ+Ho9uHbsrgzu2ubdW2kLD0k0i2FCDcYz/EMDjhOQacvCjK/TA9n69s9Quy3EDat9la/ctSyKtJtJvsjqitiI5UvFuOXSSmRUFpFUmczmN2EzHUzmuiJGeaM9Nzr5Eu1DjnFEhx2bgvFmJibR5nKcm/JJjZ7O0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BeeQUfhQu4iuzBIZvE7ZpKjrU70KYVupj8/xRCO6PEF7NRkAG+6iqzVdPnmo?=
 =?us-ascii?Q?k08/yrlgJitVlhqsqFf0bbWISSIMunsy2oRA3ZpxcA1O8lqAD1aH9ZA73sed?=
 =?us-ascii?Q?fFV4Iqm/Ir3MzHTIQuJjpFr726zRhFKScyjJDmxVNe1CpTImiIQ5Y8am4ayd?=
 =?us-ascii?Q?yUvDmDce+ly8i2ZXhefcDhZ06QQx827I9DxprnBuFnzPECh+js8oqpvOuEEE?=
 =?us-ascii?Q?E8vSkz2mt8RSuUEgJOVYxvKX6DQLZ86qJ0NR9hY6LJdt63Q3x73WW6R2oEwU?=
 =?us-ascii?Q?2i4saZPGCr9FVpiaMOZ/IEUqc9fB8JHWnieJzdHhDtAkC3yk5Wy8MZ5O/BeK?=
 =?us-ascii?Q?viM6tncqBu2xbkrMac3emtdymcmIAUoV+1341aX6p0g3zgf+a5RqLu0PsBPo?=
 =?us-ascii?Q?HqxryDSI+UvvTL1lTN1GhnIUbG0mD+F6MXvp04DUcaQlExPW+NfQnkjf42q8?=
 =?us-ascii?Q?GkkEMBBXxXhkYbUHaOR6MhnZLNif8hzfO9r6j1NTCGfvZZpsXhttzzmml81n?=
 =?us-ascii?Q?nmPJxIL8NenL9P2B5vHXzqx893Ri6NXPhlJUnwPFZHrbEkhjjUPr5JweDHQs?=
 =?us-ascii?Q?3p1u44efrLPvthME6HjJvHssU0erPBsRvy5sGPyjasr0ZG7D1OJryfoYthrd?=
 =?us-ascii?Q?5j9S4QWLEuTZvatc7pka6OjL1ipBy5AEAgFsZbOrcKoXODhpDyeJVGRKFg8i?=
 =?us-ascii?Q?khpL4t1RQpeoamBf49hD7OTAT6wgrR63yMS5SbExUYXQ38Ik59rRV1n6g0Y+?=
 =?us-ascii?Q?rb54dfpKuk6hTqSho3Fo5o0SOucS8dGlYFciGZL5L7FAPToTj80fhcfKXMf6?=
 =?us-ascii?Q?NoQgm9fvNhAtb38jD4x3XrpLJLSxuUkGF1IpKH2aaIvFcbwbrQ5zrZWHPlQj?=
 =?us-ascii?Q?t+DVuBQa6BJL34VsgoXiyFgPSuC48bCfB0o/wKnxdsDNxEXQFJE2cvYLt42X?=
 =?us-ascii?Q?bbGd7H/RA7o7WAxw/OeCyLOxTumWuFE5CMGos3Cnca5nTzpA2cJH7ydS/23t?=
 =?us-ascii?Q?qSvNhJTmp3on80AaOTcRc79hHfS0/wnNTsEriab5672CBKgKD4mMiPgToAbC?=
 =?us-ascii?Q?Mws+6+O/BFFjTIxVMC/GJwybG3t4g8pIwCALol7Hln+06Z58i3+If7AEJ4D8?=
 =?us-ascii?Q?8qHvjDEqo5qPXgBhHmH3lqbcvWdj1cZcPgBxDcxhK2tO9HNdXsKupbiapBVS?=
 =?us-ascii?Q?fKbBjuaFXyrIuTGY6JBoCKkM0lPETMwDX1JwyKeKBo8CsP5C3u7PMLNoH0ya?=
 =?us-ascii?Q?yf1dcTjzH7/EOGiGX7vohfjwvNq4wBTM6mmc+FoMuqanSnXs58/ndPRrdAMy?=
 =?us-ascii?Q?PbPwtTCBhkXukhVJBkJal/4MeLHnvgUp3PHmLXZmTEONSgff2AZ5Nnwt2oNJ?=
 =?us-ascii?Q?l4eqhcMNrlYh8/gkVjcz0pwrFF1kEHy/pYLuGz5+yvc3g2mTJXj0XNcMJLel?=
 =?us-ascii?Q?j9Lk8nGLmhRuhwai0zAvMIUvGcxJp97jZO5YXVwb2Zdk7H4cK2fSN5L6aK9r?=
 =?us-ascii?Q?oog9vyQHeC5Ev2dJ7XfFPpg/oj2Du+9lI2gvFNqtMTDuuY4sfe6JknenLX3c?=
 =?us-ascii?Q?qELyrWQjbQepoBmBI8Lzf0w+7cA0XIKXuz1oIaFUkKkJPhdoqgM2eF572O/u?=
 =?us-ascii?Q?8S4f3MoEqZkauh/OCTvPgU0CS2XH6PNvyM9fauvZwo8wIsKt+tylclxMr/09?=
 =?us-ascii?Q?/C+d0AfSpNd3XJYs9x9aIoY1iJ73K48w8Gnc4PYCKNq7dkRb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96ed867-fb1f-4115-2843-08dee0d0451f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 11:17:05.0579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiPJaqUlKLhZFXrYXs685FiseOoNm6I8gWQtPadt0Qne0IfBagNRwzOul5V3Qa0BkFJbTKF5BTl2W/qi6yYB1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

Ping

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Thursday, July 9, 2026 5:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: update smu_v13_0_6 acc gpu metrics

Update two cases in the smu_v13_0_6 GPU metrics accumulated counter field d=
efinition

Widen the following fields from U32 to U64 to prevent counter wrap-around a=
nd match smu_v15_0_8 field sizes:

  - prochot_residency_acc
  - ppt_residency_acc
  - socket_thm_residency_acc
  - vr_thm_residency_acc
  - hbm_thm_residency_acc
  - gfx_activity_acc
  - mem_activity_acc
  - pcie_nak_sent_count_acc
  - pcie_nak_rcvd_count_acc
  - pcie_lc_perf_other_end_recovery

Correct the unit annotation from PERCENT to NONE for accumulated counter fi=
elds which are dimensionless hardware counters and carry no inherent unit:

  - gfx_activity_acc
  - mem_activity_acc
  - pcie_bandwidth_acc
  - gfx_busy_acc
v2: remove percent unit (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index a66bf33dbb58..6554780afff7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -144,15 +144,15 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_=
funcs;
        SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),       =
    \
                   SMU_MTYPE(U64), accumulation_counter);                  =
    \
        SMU_SCALAR(SMU_MATTR(PROCHOT_RESIDENCY_ACC), SMU_MUNIT(NONE),      =
    \
-                  SMU_MTYPE(U32), prochot_residency_acc);                 =
    \
+                  SMU_MTYPE(U64), prochot_residency_acc);                 =
    \
        SMU_SCALAR(SMU_MATTR(PPT_RESIDENCY_ACC), SMU_MUNIT(NONE),          =
    \
-                  SMU_MTYPE(U32), ppt_residency_acc);                     =
    \
+                  SMU_MTYPE(U64), ppt_residency_acc);                     =
    \
        SMU_SCALAR(SMU_MATTR(SOCKET_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),   =
    \
-                  SMU_MTYPE(U32), socket_thm_residency_acc);              =
    \
+                  SMU_MTYPE(U64), socket_thm_residency_acc);              =
    \
        SMU_SCALAR(SMU_MATTR(VR_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),       =
    \
-                  SMU_MTYPE(U32), vr_thm_residency_acc);                  =
    \
+                  SMU_MTYPE(U64), vr_thm_residency_acc);                  =
    \
        SMU_SCALAR(SMU_MATTR(HBM_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),      =
    \
-                  SMU_MTYPE(U32), hbm_thm_residency_acc);                 =
    \
+                  SMU_MTYPE(U64), hbm_thm_residency_acc);                 =
    \
        SMU_SCALAR(SMU_MATTR(GFXCLK_LOCK_STATUS), SMU_MUNIT(NONE),         =
    \
                   SMU_MTYPE(U32), gfxclk_lock_status);                    =
    \
        SMU_SCALAR(SMU_MATTR(PCIE_LINK_WIDTH), SMU_MUNIT(NONE),            =
    \
@@ -163,11 +163,11 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_=
funcs;
                   SMU_MTYPE(U16), xgmi_link_width);                       =
    \
        SMU_SCALAR(SMU_MATTR(XGMI_LINK_SPEED), SMU_MUNIT(SPEED_1),         =
    \
                   SMU_MTYPE(U16), xgmi_link_speed);                       =
    \
-       SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(PERCENT),        =
    \
-                  SMU_MTYPE(U32), gfx_activity_acc);                      =
    \
-       SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(PERCENT),        =
    \
-                  SMU_MTYPE(U32), mem_activity_acc);                      =
    \
-       SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(PERCENT),      =
    \
+       SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(NONE),           =
 \
+                  SMU_MTYPE(U64), gfx_activity_acc);                      =
    \
+       SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(NONE),           =
 \
+                  SMU_MTYPE(U64), mem_activity_acc);                      =
    \
+       SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(NONE),         =
 \
                   SMU_MTYPE(U64), pcie_bandwidth_acc);                    =
    \
        SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_INST), SMU_MUNIT(BW_1),        =
    \
                   SMU_MTYPE(U64), pcie_bandwidth_inst);                   =
    \
@@ -178,9 +178,9 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_fu=
ncs;
        SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_ROVER_COUNT_ACC), SMU_MUNIT(NONE),=
    \
                   SMU_MTYPE(U64), pcie_replay_rover_count_acc);           =
    \
        SMU_SCALAR(SMU_MATTR(PCIE_NAK_SENT_COUNT_ACC), SMU_MUNIT(NONE),    =
    \
-                  SMU_MTYPE(U32), pcie_nak_sent_count_acc);               =
    \
+                  SMU_MTYPE(U64), pcie_nak_sent_count_acc);               =
    \
        SMU_SCALAR(SMU_MATTR(PCIE_NAK_RCVD_COUNT_ACC), SMU_MUNIT(NONE),    =
    \
-                  SMU_MTYPE(U32), pcie_nak_rcvd_count_acc);               =
    \
+                  SMU_MTYPE(U64), pcie_nak_rcvd_count_acc);               =
    \
        SMU_ARRAY(SMU_MATTR(XGMI_READ_DATA_ACC), SMU_MUNIT(DATA_1),        =
    \
                  SMU_MTYPE(U64), xgmi_read_data_acc,                      =
    \
                  SMU_13_0_6_NUM_XGMI_LINKS);                              =
    \
@@ -203,7 +203,7 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_fu=
ncs;
        SMU_SCALAR(SMU_MATTR(CURRENT_UCLK), SMU_MUNIT(CLOCK_1),            =
    \
                   SMU_MTYPE(U16), current_uclk);                          =
    \
        SMU_SCALAR(SMU_MATTR(PCIE_LC_PERF_OTHER_END_RECOVERY),             =
    \
-                  SMU_MUNIT(NONE), SMU_MTYPE(U32),                        =
    \
+                  SMU_MUNIT(NONE), SMU_MTYPE(U64),                        =
    \
                   pcie_lc_perf_other_end_recovery);                       =
    \
        SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),            =
    \
                  SMU_MTYPE(U32), gfx_busy_inst, SMU_13_0_6_MAX_XCC);      =
    \
@@ -211,7 +211,7 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_fu=
ncs;
                  jpeg_busy, SMU_13_0_6_MAX_JPEG);                         =
    \
        SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16), =
    \
                  vcn_busy, SMU_13_0_6_MAX_VCN);                           =
    \
-       SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U6=
4), \
+       SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(NONE), SMU_MTYPE(U64),=
 \
                  gfx_busy_acc, SMU_13_0_6_MAX_XCC);                       =
    \
        SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),=
    \
                  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,            =
    \
@@ -256,7 +256,7 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *s=
mu, void **table,
                  jpeg_busy, SMU_13_0_6_MAX_JPEG);                         =
    \
        SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16), =
    \
                  vcn_busy, SMU_13_0_6_MAX_VCN);                           =
    \
-       SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U6=
4), \
+       SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(NONE), SMU_MTYPE(U64),=
 \
                  gfx_busy_acc, SMU_13_0_6_MAX_XCC);                       =
    \
        SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),=
    \
                  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,            =
    \
--
2.46.0

