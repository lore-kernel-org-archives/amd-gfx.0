Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5367C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 02:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501B810E1E2;
	Tue, 30 Jul 2024 02:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cpVlSr9n";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7349710E1E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 02:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd4CwEr/L1yW/iOoI9vupKZEDnJB5VpiXgIMUHXP6wb1f1265xZIN4xTkhXaf8PdSYxUrUQsnMnOaa5ZQGzNXtQ8kX/sjKUTB0UvfB2l9tZkrmGYu9KhvLoFrHZ6Hhm262elvcF5CTL4mVWh+W/79hepVrernEjMp0tP9fVBnSYzGLq2TXquyNJpjNdVJ9QtA3nJhiZ9f4WsdZCkkrFLy9I8JrvNXqp55DXFo8OkKc4nkg/fXVf/d2r20fW5Xu46Dp9NuuAQ26ATmQ9TCueJSddbOqH5lupKT6xM2iffSb0WMyhTgal9pO+y70V6sgcQpk+Y/Hfrr6pXC5Xtk6csuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvGjmK8MXjnp1lisnKe4qLVGpa/gmFHob2BJkPz347Q=;
 b=yCN2+9fUn2ENaMuqpuk/ccVSIQRzl346guRyRGohdZgYCKcoj2R+7G00v/K7hXcBzhWLYCqgOLqW6ZKx8rRnkwblU5ej1rVMFG5JGcghdE1w84zeEdPKbdAjzQ8m1OHGZ9KBur4BeghQuwQBKTu2jMEaQmom5eNzIHiP2eBq0xjniF/a+F/EQjQizcLoEtw9smvPdZ1HTDVkhFASts4IWgaXASNAk++UjbTMMjVOyQ7T1pUUoTGCC7DkV6XHZije+d7X2jYZVpZW1ISQ8/8UBEUGAAJkECkdy/cSeCxB1crhzFt5E9p8MXaBTt1MZKsIjhLLroFWepWolNJ3TKpR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvGjmK8MXjnp1lisnKe4qLVGpa/gmFHob2BJkPz347Q=;
 b=cpVlSr9nje1xDyS11MX4Mtvdl+cxwKFfi54bT/lYyB638XvmgNKrnlM4NpxWaz3KoY8mW/KEbFcTqskFw99SJyYgW3Nx0tORmSkcgy21NEIYr5he1atYFRyfWtc//FmashENixphjjjnLfALUHSNQ+Q5oeZvIer/7nv/+CXHvMU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 02:09:18 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 02:09:18 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: add overdrive support on smu v14.0.2/3
Thread-Topic: [PATCH] drm/amd/pm: add overdrive support on smu v14.0.2/3
Thread-Index: AQHa4iIWT1MefIlq90i3yENymTejbLIOhPyw
Date: Tue, 30 Jul 2024 02:09:18 +0000
Message-ID: <PH7PR12MB5997B9128A4551E3CEB99F6A82B02@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240730014451.195377-1-kenneth.feng@amd.com>
In-Reply-To: <20240730014451.195377-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9522863d-e19d-4b59-9348-9426b5b5db72;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-30T02:03:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4172:EE_
x-ms-office365-filtering-correlation-id: 67dba2e7-624f-49b7-1d08-08dcb03c9e64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WplBDtsTKaIWfxf32L3cvTxPo1NswoOpq0tNtDCSwLuQ7H8RPiKEwxsHco+9?=
 =?us-ascii?Q?+06JsWPFE1wzdQ/X67aYkqRSENKBksOVli1wThwyFddPGx3ShQzjvsB/d50C?=
 =?us-ascii?Q?nuTbAEv8BtHVYUyZgvYrmO68R2nUcUgP4VSHf4REWGSt3xWATO0+lA5eYvSm?=
 =?us-ascii?Q?x75lg8kKNNnfNLShJaZN47uqEl7tpK3gKvOyicZ11FKy+S+CORVrLKOnxP16?=
 =?us-ascii?Q?ergMWTd9jWgPtAD+r6wUjMjpti0rEW77/JzgAzDrPQb0RYL/PlvkKHKIh/44?=
 =?us-ascii?Q?8/FGQMQHir6c9KX95aJa1HWjbLyr2C52uXffbWJV+znSO3SBPdw+e/wbsxge?=
 =?us-ascii?Q?L481D9/Q/Bnv/9sk56Q46Y0Rp+chNs4Uh3l27SW4Pr7i0Y2I/oM6dY/IQlvJ?=
 =?us-ascii?Q?cIPplkudf2/pcIe27uUAGe/tm5gZCo//3JEBdZFhHTHqCZDJVHvQPP3fZSvc?=
 =?us-ascii?Q?SN52bX/C6JehA6rgzi2Ghv2TTvqQMsoylXg7k8q1u122I8ckyOyecoy9ZPBd?=
 =?us-ascii?Q?a4mJcHBiIXSK5MDE83PcAa5JUNuRmy2k/2O4Cm7aKaBaNEBhbsm23GFpFkzf?=
 =?us-ascii?Q?oxGjTMD3mNX4PgcrQlgom+RyxCkeoy4Wk8bM4Y0tAXiRPJ4gA/rwCrFue5Av?=
 =?us-ascii?Q?dNL0ruxw+rHxtFGY/u3eo4MYXv+BmPk5pVf3NV6RzphLVDpscdpYHkwZg6W9?=
 =?us-ascii?Q?9MkTeWgUT3ZOy/fSdNGTccgf/ARCdnpubwFMgLwdwVDM4aft53fz61akZJpQ?=
 =?us-ascii?Q?uKqWs2xJ7FkrWDUgQWhv4BTbBGCzKVrmNEV1o20eiQ2o7M3n4AvT1/munIpA?=
 =?us-ascii?Q?xcEzrjrihoP9pTDRdupuVN9m6bneKHCKVo4vzdVpE4FzN3P986tl8ANf/V3R?=
 =?us-ascii?Q?j7F5yuWD4lSvX3Z86s3eYS76uBhSfsWEscmq9n0/R7mk68zh/JAZKasEFP3z?=
 =?us-ascii?Q?PPVo8mH3hfRz7GM3HSEAagRGgKpU35If+ErI+BC7CPVg/dY+rbnnEIdwbq+C?=
 =?us-ascii?Q?hXSF08G+2gcxqyVeQUUtoT5BYRiVGywEquh+EAOvsNkDuoxpO8Or1xnNIfxK?=
 =?us-ascii?Q?CKTU5ZUid+F8zGgIJdAp5fDXbNbhfMKUbKFmDinY6qFgX2uTCGjcncesA/DA?=
 =?us-ascii?Q?mYvgs+0eCRWJ0qt6X0eG0c1JQveK2cUH0TEHpqnwgLV6nBjfCh+9LX/+hrKa?=
 =?us-ascii?Q?nXOzcKtUwJvKHI7nR2ojPxVupHM/DroBePu8a7APKOd8YIgM97g0+IpZdKoF?=
 =?us-ascii?Q?ddmryx1EzmnIQO6q1cqh2hsw/h0ZLjHvzzgtdqBNw65YbgP8WgBdEFt6kYzO?=
 =?us-ascii?Q?GHdjc5iyaHSZ8jDHlHKuroCzEbWQiOz8FvFooqUdBTxaDGqqmopxzx2qzAr9?=
 =?us-ascii?Q?o+LVU5eH0wzcgk0pLjH46grvraueppwffrws2n2dqfpGjRaH3w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yb7mXt2a+KhtHQVoBok9GQ4xzHMFmPHdAosPiufRhjoKZPhn/KSh4pbjOE5a?=
 =?us-ascii?Q?P2TAIvETVCKpWy2QB30OhhrZMc1rzQZZ/7WRBxeCmZawGvEuUeiJBblzIu1B?=
 =?us-ascii?Q?pYSkY+KWCmuHfBQU7zCDelTtUzpnKqbiuLzHzwz2zhJCSB155qCfpm2jo+x9?=
 =?us-ascii?Q?KI3tJxBQVUYAVVSFcSs+6SIv4D3ucK4DRsbII9KCI+oPXbq1UTTX7rZymcwC?=
 =?us-ascii?Q?xX05+NVzer90MbKr1F4//hke5JP9ksRg5JUuyHecTHKFYlldkGbt2pL8utrh?=
 =?us-ascii?Q?aGTl+Tam8i41eM73mmbjFop+dUXn2wtzvr+m1JZMc4Ha4QguTL82pchDBm1v?=
 =?us-ascii?Q?ZXgCsORUFrH71u5+sEOmKwzsPdbV46+hXeazuhT+8u2cgfz9y1UCxeYta1CD?=
 =?us-ascii?Q?7+3TNcU4+lawI+h8Na+q3lTgnCOt4WTI/ilti4pZj3jpnigEZJK014jc14gW?=
 =?us-ascii?Q?19s6nMxCqlhwY45QQNjBbxpPXyuTVXFL3aXnllUdYsM3kITgLuQiNfG7U6/5?=
 =?us-ascii?Q?64Q77kBepyMpHEZVfN6OKpAHdin/0DpF5EZGsu7mjofGyd9+f4wEuPHC3Tip?=
 =?us-ascii?Q?H29R9QlxuCDw7qcHdB3AW03eswJIXdoLGiBozPzndA5AZM53Qq3lvFqLvdrU?=
 =?us-ascii?Q?69spOsJ9zy8iOth8t6FRJdLMLEXsfd9My4UzRfifv0Gu170fG5h/MvGL0PCx?=
 =?us-ascii?Q?cIslZDUHYY/5zDzMl5zEJSnb/lfF8W9aookQ31cxMk+d+CTLDhgrrGwH4ydU?=
 =?us-ascii?Q?/xTg/670B/QVi3K9oZNimp8/Qg9rs05TlcDFSmqg3tJ4NpbE9ktF7JMQ4QIE?=
 =?us-ascii?Q?x9QERfDin8fNPhFXv0PsQTpbpL08yThcsLqnYUrM5oBFvp0naLD4AZ4Xoi39?=
 =?us-ascii?Q?S1ILrHRm5TCSOaqH0UmKYBFhpIUhCD9c2idV4aoFJXSZVIdg9FJCUmW4YogL?=
 =?us-ascii?Q?UEpNpqIIeb9Mlc3lL1OqqZUd+/mAG/QuIprrUwU73YHBRel12w77Dl2B9IJc?=
 =?us-ascii?Q?WRwkXN33W3zj/2tN62B08TKbt1/knfkzZuJkVQ+cPTJABIEQjm/7t8Wxqd+b?=
 =?us-ascii?Q?7xB/+CUodcxhbU4UxSRzCRjmkvKYRBM38y5d85lXQWdhWQrCpkJkbTa12AY1?=
 =?us-ascii?Q?vIhKqRm0fvfe/ydtd8h3hw0F4Pc0yRlOcSXpxJa+KUp+qzOqKkE0IX7hwI4d?=
 =?us-ascii?Q?Tu0XmMqgfA1S+ZGcLvf81mkF/wlgbKVuw5ODDgnldbll36SmF1RyIiOYVtGH?=
 =?us-ascii?Q?3E8x00tMwsnyxfKrRnVKKC3o4SuH8ZHiU8MPfIbSOnaU9QJTA4X5+J73rzij?=
 =?us-ascii?Q?hgKRPxJhFyfNO1m7hIIDTUhSM/tpFYukymJOdsslBAyZvxvaWCKmA+wag7MJ?=
 =?us-ascii?Q?nW1vwEGCAd+7Q7sfNwzr42QksMwelEaz/gPVeD+061Obpnf8sgCi/MvaCGSh?=
 =?us-ascii?Q?T4yg2VuoXrhdACDwPvF0hdLXe8mKh2b7p2r8kLtXIKko9pnfLisMS0A7GUWy?=
 =?us-ascii?Q?TPGHy1IzzYYwbG6QXG5k5FPPuVw4sohL+1GVPnY3YUxcfQhT+Atuv7AwF+ci?=
 =?us-ascii?Q?Lnhp4PVML4g7+MjdGGk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dba2e7-624f-49b7-1d08-08dcb03c9e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 02:09:18.1531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vHr5q4nFtexkKQTa73PXIJHAqQRftFxCPEsefHuIu+k7hORaxSQroyy9F/u7ME2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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

Some comments inline.
After fixed, the patch is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Tuesday, July 30, 2024 9:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: add overdrive support on smu v14.0.2/3

add overdrive support on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  11 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 888 +++++++++++++++++-
 2 files changed, 896 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 09973615f210..865e916fc425 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -452,17 +452,26 @@ int smu_v14_0_init_smc_tables(struct smu_context *smu=
)
                        ret =3D -ENOMEM;
                        goto err3_out;
                }
+
+               smu_table->user_overdrive_table =3D
+                       kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNE=
L);
+               if (!smu_table->user_overdrive_table) {
+                       ret =3D -ENOMEM;
+                       goto err4_out;
+               }
        }

        smu_table->combo_pptable =3D
                kzalloc(tables[SMU_TABLE_COMBO_PPTABLE].size, GFP_KERNEL);
        if (!smu_table->combo_pptable) {
                ret =3D -ENOMEM;
-               goto err4_out;
+               goto err5_out;
        }

        return 0;

+err5_out:
+       kfree(smu_table->user_overdrive_table);
 err4_out:
        kfree(smu_table->boot_overdrive_table);
 err3_out:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e1a27903c80a..85cf450d4df1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -68,6 +68,18 @@
 #define DEBUGSMC_MSG_Mode1Reset        2
 #define LINK_SPEED_MAX                                 3

+#define PP_OD_FEATURE_GFXCLK_FMIN                      0
+#define PP_OD_FEATURE_GFXCLK_FMAX                      1
+#define PP_OD_FEATURE_UCLK_FMIN                                2
+#define PP_OD_FEATURE_UCLK_FMAX                                3
+#define PP_OD_FEATURE_GFX_VF_CURVE                     4
+#define PP_OD_FEATURE_FAN_CURVE_TEMP                   5
+#define PP_OD_FEATURE_FAN_CURVE_PWM                    6
+#define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT               7
+#define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET              8
+#define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE           9
+#define PP_OD_FEATURE_FAN_MINIMUM_PWM                  10
+
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COU=
NT] =3D {
        MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,     =
            1),
        MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,   =
            1),
@@ -204,6 +216,7 @@ static struct cmn2asic_mapping smu_v14_0_2_table_map[SM=
U_TABLE_COUNT] =3D {
        [SMU_TABLE_COMBO_PPTABLE] =3D {1, TABLE_COMBO_PPTABLE},
        TAB_MAP(I2C_COMMANDS),
        TAB_MAP(ECCINFO),
+       TAB_MAP(OVERDRIVE),
 };

 static struct cmn2asic_mapping smu_v14_0_2_pwr_src_map[SMU_POWER_SOURCE_CO=
UNT] =3D { @@ -1029,16 +1042,97 @@ static int smu_v14_0_2_get_current_clk_f=
req_by_table(struct smu_context *smu,
                                                value);
 }

+static bool smu_v14_0_2_is_od_feature_supported(struct smu_context *smu,
+                                               int od_feature_bit)
+{
+       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
+       const OverDriveLimits_t * const overdrive_upperlimits =3D
+                               &pptable->SkuTable.OverDriveLimitsBasicMax;
+
+       return overdrive_upperlimits->FeatureCtrlMask & (1U <<
+od_feature_bit); }
+
+static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
+                                             int od_feature_bit,
+                                             int32_t *min,
+                                             int32_t *max)
+{
+       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
+       const OverDriveLimits_t * const overdrive_upperlimits =3D
+                               &pptable->SkuTable.OverDriveLimitsBasicMax;
+       const OverDriveLimits_t * const overdrive_lowerlimits =3D
+                               &pptable->SkuTable.OverDriveLimitsBasicMin;
+       int32_t od_min_setting, od_max_setting;
+
+       switch (od_feature_bit) {
+       case PP_OD_FEATURE_GFXCLK_FMIN:
+               od_min_setting =3D overdrive_lowerlimits->GfxclkFmin;
+               od_max_setting =3D overdrive_upperlimits->GfxclkFmin;
+               break;
+       case PP_OD_FEATURE_GFXCLK_FMAX:
+               od_min_setting =3D overdrive_lowerlimits->GfxclkFmax;
+               od_max_setting =3D overdrive_upperlimits->GfxclkFmax;
+               break;
+       case PP_OD_FEATURE_UCLK_FMIN:
+               od_min_setting =3D overdrive_lowerlimits->UclkFmin;
+               od_max_setting =3D overdrive_upperlimits->UclkFmin;
+               break;
+       case PP_OD_FEATURE_UCLK_FMAX:
+               od_min_setting =3D overdrive_lowerlimits->UclkFmax;
+               od_max_setting =3D overdrive_upperlimits->UclkFmax;
+               break;
+       case PP_OD_FEATURE_GFX_VF_CURVE:
+               od_min_setting =3D overdrive_lowerlimits->VoltageOffsetPerZ=
oneBoundary[0];
+               od_max_setting =3D overdrive_upperlimits->VoltageOffsetPerZ=
oneBoundary[0];
+               break;
+       case PP_OD_FEATURE_FAN_CURVE_TEMP:
+               od_min_setting =3D overdrive_lowerlimits->FanLinearTempPoin=
ts[0];
+               od_max_setting =3D overdrive_upperlimits->FanLinearTempPoin=
ts[0];
+               break;
+       case PP_OD_FEATURE_FAN_CURVE_PWM:
+               od_min_setting =3D overdrive_lowerlimits->FanLinearPwmPoint=
s[0];
+               od_max_setting =3D overdrive_upperlimits->FanLinearPwmPoint=
s[0];
+               break;
+       case PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT:
+               od_min_setting =3D overdrive_lowerlimits->AcousticLimitRpmT=
hreshold;
+               od_max_setting =3D overdrive_upperlimits->AcousticLimitRpmT=
hreshold;
+               break;
+       case PP_OD_FEATURE_FAN_ACOUSTIC_TARGET:
+               od_min_setting =3D overdrive_lowerlimits->AcousticTargetRpm=
Threshold;
+               od_max_setting =3D overdrive_upperlimits->AcousticTargetRpm=
Threshold;
+               break;
+       case PP_OD_FEATURE_FAN_TARGET_TEMPERATURE:
+               od_min_setting =3D overdrive_lowerlimits->FanTargetTemperat=
ure;
+               od_max_setting =3D overdrive_upperlimits->FanTargetTemperat=
ure;
+               break;
+       case PP_OD_FEATURE_FAN_MINIMUM_PWM:
+               od_min_setting =3D overdrive_lowerlimits->FanMinimumPwm;
+               od_max_setting =3D overdrive_upperlimits->FanMinimumPwm;
+               break;
+       default:
+               od_min_setting =3D od_max_setting =3D INT_MAX;
+               break;
+       }
+
+       if (min)
+               *min =3D od_min_setting;
+       if (max)
+               *max =3D od_max_setting;
+}
+
 static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
                                        enum smu_clk_type clk_type,
                                        char *buf)
 {
        struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
        struct smu_14_0_dpm_context *dpm_context =3D smu_dpm->dpm_context;
+       OverDriveTableExternal_t *od_table =3D
+               (OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
        struct smu_14_0_dpm_table *single_dpm_table;
        struct smu_14_0_pcie_table *pcie_table;
        uint32_t gen_speed, lane_width;
        int i, curr_freq, size =3D 0;
+       int32_t min_value, max_value;
        int ret =3D 0;

        smu_cmn_get_sysfs_buf(&buf, &size);
@@ -1159,6 +1253,183 @@ static int smu_v14_0_2_print_clk_levels(struct smu_=
context *smu,
                                        "*" : "");
                break;

+       case SMU_OD_SCLK:
+               if (!smu_v14_0_2_is_od_feature_supported(smu,
+                                                        PP_OD_FEATURE_GFXC=
LK_BIT))
+                       break;
+
+               size +=3D sysfs_emit_at(buf, size, "OD_SCLK:\n");
+               size +=3D sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+                                       od_table->OverDriveTable.GfxclkFmin=
,
+                                       od_table->OverDriveTable.GfxclkFmax=
);
+               break;
+
+       case SMU_OD_MCLK:
+               if (!smu_v14_0_2_is_od_feature_supported(smu,
+                                                        PP_OD_FEATURE_UCLK=
_BIT))
+                       break;
+
+               size +=3D sysfs_emit_at(buf, size, "OD_MCLK:\n");
+               size +=3D sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMHz\n",
+                                       od_table->OverDriveTable.UclkFmin,
+                                       od_table->OverDriveTable.UclkFmax);
+               break;
+
+       case SMU_OD_VDDGFX_OFFSET:
+               if (!smu_v14_0_2_is_od_feature_supported(smu,
+                                                        PP_OD_FEATURE_GFX_=
VF_CURVE_BIT))
+                       break;
+
+               size +=3D sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
+               size +=3D sysfs_emit_at(buf, size, "%dmV\n",
+                                     od_table->OverDriveTable.VoltageOffse=
tPerZoneBoundary[0]);
+               break;
+
+       case SMU_OD_FAN_CURVE:
+               if (!smu_v14_0_2_is_od_feature_supported(smu,
+                                                        PP_OD_FEATURE_FAN_=
CURVE_BIT))
+                       break;
+
+               size +=3D sysfs_emit_at(buf, size, "OD_FAN_CURVE:\n");
+               for (i =3D 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++)
+                       size +=3D sysfs_emit_at(buf, size, "%d: %dC %d%%\n"=
,
+                                               i,
+                                               (int)od_table->OverDriveTab=
le.FanLinearTempPoints[i],
+                                               (int)od_table->OverDriveTab=
le.FanLinearPwmPoints[i]);
+
+               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_CURVE_T=
EMP,
+                                                 &min_value,
+                                                 &max_value);
+               size +=3D sysfs_emit_at(buf, size, "FAN_CURVE(hotspot temp)=
: %uC %uC\n",
+                                     min_value, max_value);
+
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_CURVE_P=
WM,
+                                                 &min_value,
+                                                 &max_value);
+               size +=3D sysfs_emit_at(buf, size, "FAN_CURVE(fan speed): %=
u%% %u%%\n",
+                                     min_value, max_value);
+
+               break;
+
+       case SMU_OD_ACOUSTIC_LIMIT:
+               if (!smu_v14_0_2_is_od_feature_supported(smu,
+                                                        PP_OD_FEATURE_FAN_=
CURVE_BIT))
+                       break;
+
+               size +=3D sysfs_emit_at(buf, size, "OD_ACOUSTIC_LIMIT:\n");
+               size +=3D sysfs_emit_at(buf, size, "%d\n",
+                                       (int)od_table->OverDriveTable.Acous=
ticLimitRpmThreshold);
+
+               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_ACOUSTI=
C_LIMIT,
+                                                 &min_value,
+                                                 &max_value);
+               size +=3D sysfs_emit_at(buf, size, "ACOUSTIC_LIMIT: %u %u\n=
",
+                                     min_value, max_value);
+               break;
+
+       case SMU_OD_ACOUSTIC_TARGET:
+               if (!smu_v14_0_2_is_od_feature_supported(smu,
+                                                        PP_OD_FEATURE_FAN_=
CURVE_BIT))
+                       break;
+
+               size +=3D sysfs_emit_at(buf, size, "OD_ACOUSTIC_TARGET:\n")=
;
+               size +=3D sysfs_emit_at(buf, size, "%d\n",
+                                       (int)od_table->OverDriveTable.Acous=
ticTargetRpmThreshold);
+
+               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_ACOUSTI=
C_TARGET,
+                                                 &min_value,
+                                                 &max_value);
+               size +=3D sysfs_emit_at(buf, size, "ACOUSTIC_TARGET: %u %u\=
n",
+                                     min_value, max_value);
+               break;
+
+       case SMU_OD_FAN_TARGET_TEMPERATURE:
+               if (!smu_v14_0_2_is_od_feature_supported(smu,
+                                                        PP_OD_FEATURE_FAN_=
CURVE_BIT))
+                       break;
+
+               size +=3D sysfs_emit_at(buf, size, "FAN_TARGET_TEMPERATURE:=
\n");
+               size +=3D sysfs_emit_at(buf, size, "%d\n",
+                                       (int)od_table->OverDriveTable.FanTa=
rgetTemperature);
+
+               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_TARGET_=
TEMPERATURE,
+                                                 &min_value,
+                                                 &max_value);
+               size +=3D sysfs_emit_at(buf, size, "TARGET_TEMPERATURE: %u =
%u\n",
+                                     min_value, max_value);
+               break;
+
+       case SMU_OD_FAN_MINIMUM_PWM:
+               if (!smu_v14_0_2_is_od_feature_supported(smu,
+                                                        PP_OD_FEATURE_FAN_=
CURVE_BIT))
+                       break;
+
+               size +=3D sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
+               size +=3D sysfs_emit_at(buf, size, "%d\n",
+                                       (int)od_table->OverDriveTable.FanMi=
nimumPwm);
+
+               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_MINIMUM=
_PWM,
+                                                 &min_value,
+                                                 &max_value);
+               size +=3D sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n",
+                                     min_value, max_value);
+               break;
+
+       case SMU_OD_RANGE:
+               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_GFXCLK_BIT) &&
+                   !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_UCLK_BIT) &&
+                   !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_GFX_VF_CURVE_BIT))
+                       break;
+
+               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+
+               if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_=
GFXCLK_BIT)) {
+                       smu_v14_0_2_get_od_setting_limits(smu,
+                                                         PP_OD_FEATURE_GFX=
CLK_FMIN,
+                                                         &min_value,
+                                                         NULL);
+                       smu_v14_0_2_get_od_setting_limits(smu,
+                                                         PP_OD_FEATURE_GFX=
CLK_FMAX,
+                                                         NULL,
+                                                         &max_value);
+                       size +=3D sysfs_emit_at(buf, size, "SCLK: %7uMhz %1=
0uMhz\n",
+                                             min_value, max_value);
+               }
+
+               if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_=
UCLK_BIT)) {
+                       smu_v14_0_2_get_od_setting_limits(smu,
+                                                         PP_OD_FEATURE_UCL=
K_FMIN,
+                                                         &min_value,
+                                                         NULL);
+                       smu_v14_0_2_get_od_setting_limits(smu,
+                                                         PP_OD_FEATURE_UCL=
K_FMAX,
+                                                         NULL,
+                                                         &max_value);
+                       size +=3D sysfs_emit_at(buf, size, "MCLK: %7uMhz %1=
0uMhz\n",
+                                             min_value, max_value);
+               }
+
+               if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_=
GFX_VF_CURVE_BIT)) {
+                       smu_v14_0_2_get_od_setting_limits(smu,
+                                                         PP_OD_FEATURE_GFX=
_VF_CURVE,
+                                                         &min_value,
+                                                         &max_value);
+                       size +=3D sysfs_emit_at(buf, size, "VDDGFX_OFFSET: =
%7dmv %10dmv\n",
+                                             min_value, max_value);
+               }
+               break;
+
        default:
                break;
        }
@@ -1400,7 +1671,27 @@ static int smu_v14_0_2_get_power_limit(struct smu_co=
ntext *smu,
                                       uint32_t *max_power_limit,
                                       uint32_t *min_power_limit)
 {
-       // TODO
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       PPTable_t *pptable =3D table_context->driver_pptable;
+       CustomSkuTable_t *skutable =3D &pptable->CustomSkuTable;
+       uint32_t power_limit;
+       uint32_t msg_limit =3D
+pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+
+       if (smu_v14_0_get_current_power_limit(smu, &power_limit))
+               power_limit =3D smu->adev->pm.ac_power ?
+                             skutable->SocketPowerLimitAc[PPT_THROTTLER_PP=
T0] :
+                             skutable->SocketPowerLimitDc[PPT_THROTTLER_PP=
T0];
+
+       if (current_power_limit)
+               *current_power_limit =3D power_limit;
+       if (default_power_limit)
+               *default_power_limit =3D power_limit;
+
+       if (max_power_limit)
+               *max_power_limit =3D msg_limit;
+
+       if (min_power_limit)
+               *min_power_limit =3D 0;

        return 0;
 }
@@ -1950,6 +2241,596 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct s=
mu_context *smu,
        return sizeof(struct gpu_metrics_v1_3);  }

+static void smu_v14_0_2_dump_od_table(struct smu_context *smu,
+                                     OverDriveTableExternal_t *od_table) {
+       struct amdgpu_device *adev =3D smu->adev;
+
+       dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTab=
le.GfxclkFmin,
+                                                    od_table->OverDriveTab=
le.GfxclkFmax);
+       dev_dbg(adev->dev, "OD: Uclk: (%d, %d)\n", od_table->OverDriveTable=
.UclkFmin,
+                                                  od_table->OverDriveTable=
.UclkFmax);
+}
+
+static int smu_v14_0_2_upload_overdrive_table(struct smu_context *smu,
+                                             OverDriveTableExternal_t *od_=
table) {
+       int ret =3D 0;
+
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_OVERDRIVE,
+                                  0,
+                                  (void *)od_table,
+                                  true);
+       if (ret)
+               dev_err(smu->adev->dev, "Failed to upload overdrive table!\=
n");
+
+       return ret;
+}
+
+static void smu_v14_0_2_set_supported_od_feature_mask(struct
+smu_context *smu) {
+       struct amdgpu_device *adev =3D smu->adev;
+
+       if (smu_v14_0_2_is_od_feature_supported(smu,
+                                               PP_OD_FEATURE_FAN_CURVE_BIT=
))
+               adev->pm.od_feature_mask |=3D OD_OPS_SUPPORT_FAN_CURVE_RETR=
IEVE |
+                                           OD_OPS_SUPPORT_FAN_CURVE_SET |
+                                           OD_OPS_SUPPORT_ACOUSTIC_LIMIT_T=
HRESHOLD_RETRIEVE |
+                                           OD_OPS_SUPPORT_ACOUSTIC_LIMIT_T=
HRESHOLD_SET |
+                                           OD_OPS_SUPPORT_ACOUSTIC_TARGET_=
THRESHOLD_RETRIEVE |
+                                           OD_OPS_SUPPORT_ACOUSTIC_TARGET_=
THRESHOLD_SET |
+                                           OD_OPS_SUPPORT_FAN_TARGET_TEMPE=
RATURE_RETRIEVE |
+                                           OD_OPS_SUPPORT_FAN_TARGET_TEMPE=
RATURE_SET |
+                                           OD_OPS_SUPPORT_FAN_MINIMUM_PWM_=
RETRIEVE |
+                                           OD_OPS_SUPPORT_FAN_MINIMUM_PWM_=
SET;
+}
+
+static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
+                                          OverDriveTableExternal_t *od_tab=
le) {
+       int ret =3D 0;
[kevin]:
Initialization is unnecessary, and same problem on the other place, better =
fixes it before submitting.
+
+       ret =3D smu_cmn_update_table(smu,
+                                  SMU_TABLE_OVERDRIVE,
+                                  0,
+                                  (void *)od_table,
+                                  false);
+       if (ret)
+               dev_err(smu->adev->dev, "Failed to get overdrive table!\n")=
;
+
+       return ret;
+}
+
+static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
+{
+       OverDriveTableExternal_t *od_table =3D
+               (OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
+       OverDriveTableExternal_t *boot_od_table =3D
+               (OverDriveTableExternal_t *)smu->smu_table.boot_overdrive_t=
able;
+       OverDriveTableExternal_t *user_od_table =3D
+               (OverDriveTableExternal_t *)smu->smu_table.user_overdrive_t=
able;
+       OverDriveTableExternal_t user_od_table_bak;
+       int ret =3D 0;
+       int i;
[Kevin]:
It is better making the same type variables in the same line.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

+
+       ret =3D smu_v14_0_2_get_overdrive_table(smu, boot_od_table);
+       if (ret)
+               return ret;
+
+       smu_v14_0_2_dump_od_table(smu, boot_od_table);
+
+       memcpy(od_table,
+              boot_od_table,
+              sizeof(OverDriveTableExternal_t));
+
+       /*
+        * For S3/S4/Runpm resume, we need to setup those overdrive tables =
again,
+        * but we have to preserve user defined values in "user_od_table".
+        */
+       if (!smu->adev->in_suspend) {
+               memcpy(user_od_table,
+                      boot_od_table,
+                      sizeof(OverDriveTableExternal_t));
+               smu->user_dpm_profile.user_od =3D false;
+       } else if (smu->user_dpm_profile.user_od) {
+               memcpy(&user_od_table_bak,
+                      user_od_table,
+                      sizeof(OverDriveTableExternal_t));
+               memcpy(user_od_table,
+                      boot_od_table,
+                      sizeof(OverDriveTableExternal_t));
+               user_od_table->OverDriveTable.GfxclkFmin =3D
+                               user_od_table_bak.OverDriveTable.GfxclkFmin=
;
+               user_od_table->OverDriveTable.GfxclkFmax =3D
+                               user_od_table_bak.OverDriveTable.GfxclkFmax=
;
+               user_od_table->OverDriveTable.UclkFmin =3D
+                               user_od_table_bak.OverDriveTable.UclkFmin;
+               user_od_table->OverDriveTable.UclkFmax =3D
+                               user_od_table_bak.OverDriveTable.UclkFmax;
+               for (i =3D 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
+                       user_od_table->OverDriveTable.VoltageOffsetPerZoneB=
oundary[i] =3D
+                               user_od_table_bak.OverDriveTable.VoltageOff=
setPerZoneBoundary[i];
+               for (i =3D 0; i < NUM_OD_FAN_MAX_POINTS - 1; i++) {
+                       user_od_table->OverDriveTable.FanLinearTempPoints[i=
] =3D
+                               user_od_table_bak.OverDriveTable.FanLinearT=
empPoints[i];
+                       user_od_table->OverDriveTable.FanLinearPwmPoints[i]=
 =3D
+                               user_od_table_bak.OverDriveTable.FanLinearP=
wmPoints[i];
+               }
+               user_od_table->OverDriveTable.AcousticLimitRpmThreshold =3D
+                       user_od_table_bak.OverDriveTable.AcousticLimitRpmTh=
reshold;
+               user_od_table->OverDriveTable.AcousticTargetRpmThreshold =
=3D
+                       user_od_table_bak.OverDriveTable.AcousticTargetRpmT=
hreshold;
+               user_od_table->OverDriveTable.FanTargetTemperature =3D
+                       user_od_table_bak.OverDriveTable.FanTargetTemperatu=
re;
+               user_od_table->OverDriveTable.FanMinimumPwm =3D
+                       user_od_table_bak.OverDriveTable.FanMinimumPwm;
+       }
+
+       smu_v14_0_2_set_supported_od_feature_mask(smu);
+
+       return 0;
+}
+
+static int smu_v14_0_2_restore_user_od_settings(struct smu_context
+*smu) {
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       OverDriveTableExternal_t *od_table =3D table_context->overdrive_tab=
le;
+       OverDriveTableExternal_t *user_od_table =3D table_context->user_ove=
rdrive_table;
+       int res;
+
+       user_od_table->OverDriveTable.FeatureCtrlMask =3D BIT(PP_OD_FEATURE=
_GFXCLK_BIT) |
+                                                       BIT(PP_OD_FEATURE_U=
CLK_BIT) |
+                                                       BIT(PP_OD_FEATURE_G=
FX_VF_CURVE_BIT) |
+                                                       BIT(PP_OD_FEATURE_F=
AN_CURVE_BIT);
+       res =3D smu_v14_0_2_upload_overdrive_table(smu, user_od_table);
+       user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
+       if (res =3D=3D 0)
+               memcpy(od_table, user_od_table, sizeof(OverDriveTableExtern=
al_t));
+
+       return res;
+}
+
+static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu,
+long input) {
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       OverDriveTableExternal_t *boot_overdrive_table =3D
+               (OverDriveTableExternal_t *)table_context->boot_overdrive_t=
able;
+       OverDriveTableExternal_t *od_table =3D
+               (OverDriveTableExternal_t *)table_context->overdrive_table;
+       struct amdgpu_device *adev =3D smu->adev;
+       int i;
+
+       switch (input) {
+       case PP_OD_EDIT_FAN_CURVE:
+               for (i =3D 0; i < NUM_OD_FAN_MAX_POINTS; i++) {
+                       od_table->OverDriveTable.FanLinearTempPoints[i] =3D
+                                       boot_overdrive_table->OverDriveTabl=
e.FanLinearTempPoints[i];
+                       od_table->OverDriveTable.FanLinearPwmPoints[i] =3D
+                                       boot_overdrive_table->OverDriveTabl=
e.FanLinearPwmPoints[i];
+               }
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+       case PP_OD_EDIT_ACOUSTIC_LIMIT:
+               od_table->OverDriveTable.AcousticLimitRpmThreshold =3D
+                                       boot_overdrive_table->OverDriveTabl=
e.AcousticLimitRpmThreshold;
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+       case PP_OD_EDIT_ACOUSTIC_TARGET:
+               od_table->OverDriveTable.AcousticTargetRpmThreshold =3D
+                                       boot_overdrive_table->OverDriveTabl=
e.AcousticTargetRpmThreshold;
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+       case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+               od_table->OverDriveTable.FanTargetTemperature =3D
+                                       boot_overdrive_table->OverDriveTabl=
e.FanTargetTemperature;
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+       case PP_OD_EDIT_FAN_MINIMUM_PWM:
+               od_table->OverDriveTable.FanMinimumPwm =3D
+                                       boot_overdrive_table->OverDriveTabl=
e.FanMinimumPwm;
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+       default:
+               dev_info(adev->dev, "Invalid table index: %ld\n", input);
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
+static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
+                                        enum PP_OD_DPM_TABLE_COMMAND type,
+                                        long input[],
+                                        uint32_t size)
+{
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       OverDriveTableExternal_t *od_table =3D
+               (OverDriveTableExternal_t *)table_context->overdrive_table;
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t offset_of_voltageoffset;
+       int32_t minimum, maximum;
+       uint32_t feature_ctrlmask;
+       int i, ret =3D 0;
+
+       switch (type) {
+       case PP_OD_EDIT_SCLK_VDDC_TABLE:
+               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_GFXCLK_BIT)) {
+                       dev_warn(adev->dev, "GFXCLK_LIMITS setting not supp=
orted!\n");
+                       return -ENOTSUPP;
+               }
+
+               for (i =3D 0; i < size; i +=3D 2) {
+                       if (i + 2 > size) {
+                               dev_info(adev->dev, "invalid number of inpu=
t parameters %d\n", size);
+                               return -EINVAL;
+                       }
+
+                       switch (input[i]) {
+                       case 0:
+                               smu_v14_0_2_get_od_setting_limits(smu,
+                                                                 PP_OD_FEA=
TURE_GFXCLK_FMIN,
+                                                                 &minimum,
+                                                                 &maximum)=
;
+                               if (input[i + 1] < minimum ||
+                                   input[i + 1] > maximum) {
+                                       dev_info(adev->dev, "GfxclkFmin (%l=
d) must be within [%u, %u]!\n",
+                                               input[i + 1], minimum, maxi=
mum);
+                                       return -EINVAL;
+                               }
+
+                               od_table->OverDriveTable.GfxclkFmin =3D inp=
ut[i + 1];
+                               od_table->OverDriveTable.FeatureCtrlMask |=
=3D 1U << PP_OD_FEATURE_GFXCLK_BIT;
+                               break;
+
+                       case 1:
+                               smu_v14_0_2_get_od_setting_limits(smu,
+                                                                 PP_OD_FEA=
TURE_GFXCLK_FMAX,
+                                                                 &minimum,
+                                                                 &maximum)=
;
+                               if (input[i + 1] < minimum ||
+                                   input[i + 1] > maximum) {
+                                       dev_info(adev->dev, "GfxclkFmax (%l=
d) must be within [%u, %u]!\n",
+                                               input[i + 1], minimum, maxi=
mum);
+                                       return -EINVAL;
+                               }
+
+                               od_table->OverDriveTable.GfxclkFmax =3D inp=
ut[i + 1];
+                               od_table->OverDriveTable.FeatureCtrlMask |=
=3D 1U << PP_OD_FEATURE_GFXCLK_BIT;
+                               break;
+
+                       default:
+                               dev_info(adev->dev, "Invalid SCLK_VDDC_TABL=
E index: %ld\n", input[i]);
+                               dev_info(adev->dev, "Supported indices: [0:=
min,1:max]\n");
+                               return -EINVAL;
+                       }
+               }
+
+               if (od_table->OverDriveTable.GfxclkFmin > od_table->OverDri=
veTable.GfxclkFmax) {
+                       dev_err(adev->dev,
+                               "Invalid setting: GfxclkFmin(%u) is bigger =
than GfxclkFmax(%u)\n",
+                               (uint32_t)od_table->OverDriveTable.GfxclkFm=
in,
+                               (uint32_t)od_table->OverDriveTable.GfxclkFm=
ax);
+                       return -EINVAL;
+               }
+               break;
+
+       case PP_OD_EDIT_MCLK_VDDC_TABLE:
+               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_UCLK_BIT)) {
+                       dev_warn(adev->dev, "UCLK_LIMITS setting not suppor=
ted!\n");
+                       return -ENOTSUPP;
+               }
+
+               for (i =3D 0; i < size; i +=3D 2) {
+                       if (i + 2 > size) {
+                               dev_info(adev->dev, "invalid number of inpu=
t parameters %d\n", size);
+                               return -EINVAL;
+                       }
+
+                       switch (input[i]) {
+                       case 0:
+                               smu_v14_0_2_get_od_setting_limits(smu,
+                                                                 PP_OD_FEA=
TURE_UCLK_FMIN,
+                                                                 &minimum,
+                                                                 &maximum)=
;
+                               if (input[i + 1] < minimum ||
+                                   input[i + 1] > maximum) {
+                                       dev_info(adev->dev, "UclkFmin (%ld)=
 must be within [%u, %u]!\n",
+                                               input[i + 1], minimum, maxi=
mum);
+                                       return -EINVAL;
+                               }
+
+                               od_table->OverDriveTable.UclkFmin =3D input=
[i + 1];
+                               od_table->OverDriveTable.FeatureCtrlMask |=
=3D 1U << PP_OD_FEATURE_UCLK_BIT;
+                               break;
+
+                       case 1:
+                               smu_v14_0_2_get_od_setting_limits(smu,
+                                                                 PP_OD_FEA=
TURE_UCLK_FMAX,
+                                                                 &minimum,
+                                                                 &maximum)=
;
+                               if (input[i + 1] < minimum ||
+                                   input[i + 1] > maximum) {
+                                       dev_info(adev->dev, "UclkFmax (%ld)=
 must be within [%u, %u]!\n",
+                                               input[i + 1], minimum, maxi=
mum);
+                                       return -EINVAL;
+                               }
+
+                               od_table->OverDriveTable.UclkFmax =3D input=
[i + 1];
+                               od_table->OverDriveTable.FeatureCtrlMask |=
=3D 1U << PP_OD_FEATURE_UCLK_BIT;
+                               break;
+
+                       default:
+                               dev_info(adev->dev, "Invalid MCLK_VDDC_TABL=
E index: %ld\n", input[i]);
+                               dev_info(adev->dev, "Supported indices: [0:=
min,1:max]\n");
+                               return -EINVAL;
+                       }
+               }
+
+               if (od_table->OverDriveTable.UclkFmin > od_table->OverDrive=
Table.UclkFmax) {
+                       dev_err(adev->dev,
+                               "Invalid setting: UclkFmin(%u) is bigger th=
an UclkFmax(%u)\n",
+                               (uint32_t)od_table->OverDriveTable.UclkFmin=
,
+                               (uint32_t)od_table->OverDriveTable.UclkFmax=
);
+                       return -EINVAL;
+               }
+               break;
+
+       case PP_OD_EDIT_VDDGFX_OFFSET:
+               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_GFX_VF_CURVE_BIT)) {
+                       dev_warn(adev->dev, "Gfx offset setting not support=
ed!\n");
+                       return -ENOTSUPP;
+               }
+
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_GFX_VF_CURV=
E,
+                                                 &minimum,
+                                                 &maximum);
+               if (input[0] < minimum ||
+                   input[0] > maximum) {
+                       dev_info(adev->dev, "Voltage offset (%ld) must be w=
ithin [%d, %d]!\n",
+                                input[0], minimum, maximum);
+                       return -EINVAL;
+               }
+
+               for (i =3D 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
+                       od_table->OverDriveTable.VoltageOffsetPerZoneBounda=
ry[i] =3D input[0];
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_GFX_VF_CURVE_BIT);
+               break;
+
+       case PP_OD_EDIT_FAN_CURVE:
+               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_FAN_CURVE_BIT)) {
+                       dev_warn(adev->dev, "Fan curve setting not supporte=
d!\n");
+                       return -ENOTSUPP;
+               }
+
+               if (input[0] >=3D NUM_OD_FAN_MAX_POINTS - 1 ||
+                   input[0] < 0)
+                       return -EINVAL;
+
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_CURVE_T=
EMP,
+                                                 &minimum,
+                                                 &maximum);
+               if (input[1] < minimum ||
+                   input[1] > maximum) {
+                       dev_info(adev->dev, "Fan curve temp setting(%ld) mu=
st be within [%d, %d]!\n",
+                                input[1], minimum, maximum);
+                       return -EINVAL;
+               }
+
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_CURVE_P=
WM,
+                                                 &minimum,
+                                                 &maximum);
+               if (input[2] < minimum ||
+                   input[2] > maximum) {
+                       dev_info(adev->dev, "Fan curve pwm setting(%ld) mus=
t be within [%d, %d]!\n",
+                                input[2], minimum, maximum);
+                       return -EINVAL;
+               }
+
+               od_table->OverDriveTable.FanLinearTempPoints[input[0]] =3D =
input[1];
+               od_table->OverDriveTable.FanLinearPwmPoints[input[0]] =3D i=
nput[2];
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_MANUAL_LINEAR=
;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+
+       case PP_OD_EDIT_ACOUSTIC_LIMIT:
+               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_FAN_CURVE_BIT)) {
+                       dev_warn(adev->dev, "Fan curve setting not supporte=
d!\n");
+                       return -ENOTSUPP;
+               }
+
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_ACOUSTI=
C_LIMIT,
+                                                 &minimum,
+                                                 &maximum);
+               if (input[0] < minimum ||
+                   input[0] > maximum) {
+                       dev_info(adev->dev, "acoustic limit threshold setti=
ng(%ld) must be within [%d, %d]!\n",
+                                input[0], minimum, maximum);
+                       return -EINVAL;
+               }
+
+               od_table->OverDriveTable.AcousticLimitRpmThreshold =3D inpu=
t[0];
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+
+       case PP_OD_EDIT_ACOUSTIC_TARGET:
+               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_FAN_CURVE_BIT)) {
+                       dev_warn(adev->dev, "Fan curve setting not supporte=
d!\n");
+                       return -ENOTSUPP;
+               }
+
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_ACOUSTI=
C_TARGET,
+                                                 &minimum,
+                                                 &maximum);
+               if (input[0] < minimum ||
+                   input[0] > maximum) {
+                       dev_info(adev->dev, "acoustic target threshold sett=
ing(%ld) must be within [%d, %d]!\n",
+                                input[0], minimum, maximum);
+                       return -EINVAL;
+               }
+
+               od_table->OverDriveTable.AcousticTargetRpmThreshold =3D inp=
ut[0];
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+
+       case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_FAN_CURVE_BIT)) {
+                       dev_warn(adev->dev, "Fan curve setting not supporte=
d!\n");
+                       return -ENOTSUPP;
+               }
+
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_TARGET_=
TEMPERATURE,
+                                                 &minimum,
+                                                 &maximum);
+               if (input[0] < minimum ||
+                   input[0] > maximum) {
+                       dev_info(adev->dev, "fan target temperature setting=
(%ld) must be within [%d, %d]!\n",
+                                input[0], minimum, maximum);
+                       return -EINVAL;
+               }
+
+               od_table->OverDriveTable.FanTargetTemperature =3D input[0];
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+
+       case PP_OD_EDIT_FAN_MINIMUM_PWM:
+               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE=
_FAN_CURVE_BIT)) {
+                       dev_warn(adev->dev, "Fan curve setting not supporte=
d!\n");
+                       return -ENOTSUPP;
+               }
+
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_FAN_MINIMUM=
_PWM,
+                                                 &minimum,
+                                                 &maximum);
+               if (input[0] < minimum ||
+                   input[0] > maximum) {
+                       dev_info(adev->dev, "fan minimum pwm setting(%ld) m=
ust be within [%d, %d]!\n",
+                                input[0], minimum, maximum);
+                       return -EINVAL;
+               }
+
+               od_table->OverDriveTable.FanMinimumPwm =3D input[0];
+               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               break;
+
+       case PP_OD_RESTORE_DEFAULT_TABLE:
+               if (size =3D=3D 1) {
+                       ret =3D smu_v14_0_2_od_restore_table_single(smu, in=
put[0]);
+                       if (ret)
+                               return ret;
+               } else {
+                       feature_ctrlmask =3D od_table->OverDriveTable.Featu=
reCtrlMask;
+                       memcpy(od_table,
+                      table_context->boot_overdrive_table,
+                      sizeof(OverDriveTableExternal_t));
+                       od_table->OverDriveTable.FeatureCtrlMask =3D featur=
e_ctrlmask;
+               }
+               fallthrough;
+       case PP_OD_COMMIT_DPM_TABLE:
+               /*
+                * The member below instructs PMFW the settings focused in
+                * this single operation.
+                * `uint32_t FeatureCtrlMask;`
+                * It does not contain actual informations about user's cus=
tom
+                * settings. Thus we do not cache it.
+                */
+               offset_of_voltageoffset =3D offsetof(OverDriveTable_t, Volt=
ageOffsetPerZoneBoundary);
+               if (memcmp((u8 *)od_table + offset_of_voltageoffset,
+                          table_context->user_overdrive_table + offset_of_=
voltageoffset,
+                          sizeof(OverDriveTableExternal_t) - offset_of_vol=
tageoffset)) {
+                       smu_v14_0_2_dump_od_table(smu, od_table);
+
+                       ret =3D smu_v14_0_2_upload_overdrive_table(smu, od_=
table);
+                       if (ret) {
+                               dev_err(adev->dev, "Failed to upload overdr=
ive table!\n");
+                               return ret;
+                       }
+
+                       od_table->OverDriveTable.FeatureCtrlMask =3D 0;
+                       memcpy(table_context->user_overdrive_table + offset=
_of_voltageoffset,
+                              (u8 *)od_table + offset_of_voltageoffset,
+                              sizeof(OverDriveTableExternal_t) - offset_of=
_voltageoffset);
+
+                       if (!memcmp(table_context->user_overdrive_table,
+                                   table_context->boot_overdrive_table,
+                                   sizeof(OverDriveTableExternal_t)))
+                               smu->user_dpm_profile.user_od =3D false;
+                       else
+                               smu->user_dpm_profile.user_od =3D true;
+               }
+               break;
+
+       default:
+               return -ENOSYS;
+       }
+
+       return ret;
+}
+
+static int smu_v14_0_2_set_power_limit(struct smu_context *smu,
+                                      enum smu_ppt_limit_type limit_type,
+                                      uint32_t limit)
+{
+       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
+       uint32_t msg_limit =3D pptable->SkuTable.MsgLimits.Power[PPT_THROTT=
LER_PPT0][POWER_SOURCE_AC];
+       struct smu_table_context *table_context =3D &smu->smu_table;
+       OverDriveTableExternal_t *od_table =3D
+               (OverDriveTableExternal_t *)table_context->overdrive_table;
+       int ret =3D 0;
+
+       if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT)
+               return -EINVAL;
+
+       if (limit <=3D msg_limit) {
+               if (smu->current_power_limit > msg_limit) {
+                       od_table->OverDriveTable.Ppt =3D 0;
+                       od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
+PP_OD_FEATURE_PPT_BIT;
+
+                       ret =3D smu_v14_0_2_upload_overdrive_table(smu, od_=
table);
+                       if (ret) {
+                               dev_err(smu->adev->dev, "Failed to upload o=
verdrive table!\n");
+                               return ret;
+                       }
+               }
+               return smu_v14_0_set_power_limit(smu, limit_type, limit);
+       } else if (smu->od_enabled) {
+               ret =3D smu_v14_0_set_power_limit(smu, limit_type, msg_limi=
t);
+               if (ret)
+                       return ret;
+
+               od_table->OverDriveTable.Ppt =3D (limit * 100) / msg_limit =
- 100;
+               od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
+PP_OD_FEATURE_PPT_BIT;
+
+               ret =3D smu_v14_0_2_upload_overdrive_table(smu, od_table);
+               if (ret) {
+                 dev_err(smu->adev->dev, "Failed to upload overdrive table=
!\n");
+                 return ret;
+               }
+
+               smu->current_power_limit =3D limit;
+       } else {
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_2_ppt_funcs =3D {
        .get_allowed_feature_mask =3D smu_v14_0_2_get_allowed_feature_mask,
        .set_default_dpm_table =3D smu_v14_0_2_set_default_dpm_table,
@@ -1988,13 +2869,16 @@ static const struct pptable_funcs smu_v14_0_2_ppt_f=
uncs =3D {
        .notify_memory_pool_location =3D smu_v14_0_notify_memory_pool_locat=
ion,
        .get_gpu_metrics =3D smu_v14_0_2_get_gpu_metrics,
        .set_soft_freq_limited_range =3D smu_v14_0_set_soft_freq_limited_ra=
nge,
+       .set_default_od_settings =3D smu_v14_0_2_set_default_od_settings,
+       .restore_user_od_settings =3D smu_v14_0_2_restore_user_od_settings,
+       .od_edit_dpm_table =3D smu_v14_0_2_od_edit_dpm_table,
        .init_pptable_microcode =3D smu_v14_0_init_pptable_microcode,
        .populate_umd_state_clk =3D smu_v14_0_2_populate_umd_state_clk,
        .set_performance_level =3D smu_v14_0_set_performance_level,
        .gfx_off_control =3D smu_v14_0_gfx_off_control,
        .get_unique_id =3D smu_v14_0_2_get_unique_id,
        .get_power_limit =3D smu_v14_0_2_get_power_limit,
-       .set_power_limit =3D smu_v14_0_set_power_limit,
+       .set_power_limit =3D smu_v14_0_2_set_power_limit,
        .set_power_source =3D smu_v14_0_set_power_source,
        .get_power_profile_mode =3D smu_v14_0_2_get_power_profile_mode,
        .set_power_profile_mode =3D smu_v14_0_2_set_power_profile_mode,
--
2.34.1

