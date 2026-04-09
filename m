Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF50E9DE6C
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 08:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3199B10E325;
	Thu,  9 Apr 2026 08:48:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JtIuH7Eu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013001.outbound.protection.outlook.com
 [40.93.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E846510E325
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 08:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZKV9KSNhImnlVGBgV+T4m5D2dyjKFKO/WrOuyIL82qSbferpPx3tr25lZg1ENdF9MfNSHo9lHD5c85igWqW8+9aiPnkq479BYDKgB/pPHQOZBIpY+SUt0KbNPL+aRIBfP1+FbtQhDlN+GuHmZeIY8R3+alAEBwmVg8zG7fYQPON3QOg8TJ0yuSmYBAj7Pa0WFdFKJg/ONaoggUx7uRc4Y2GeqKeD/AobjJ3QN21d8g5moGJ4ZY0ZrF3rrirjFl956c7LMGoONQOgyf5DZ8cc97C+q62tJMjMV6lIzd7i2CP9sdvgf1R5ntPrvkMLVctiUxmr4MLPBMKxp6rPO2uCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfxby5GidOP2StKVucuxJyFdj8c19yYNwVitFXtU3ek=;
 b=LHwQojFIr/7lR1xgHWujulEuVIRuokdDoNwLdatZYNgUoqRNs2Eq3SET4fEC5IgmbJsxch1GiKOqUD/Y+MD3XYwug0VHqgGwGVU3Xd1D3mF7La6O0x64yIWAQ+mDvkBrtpgoar2IyuCLxn3tn50gANZLnTCIEnDFJX4DHaPpG4VyzORHtBU/Tp+3D7XNOn0jiBd7vtK8PocFC/Z2cbIZYoBXTtVuDlPw30PWQouwTOj5vChHIZzadn11XfHRn+TO/8oNSEU2PLgoh7jjybiGwelRoSZsyFCj9M22bZzarxSXUgVbJKf6sVfjOs+WsQ7iumSdMc3ygJZiKm5QkDpPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfxby5GidOP2StKVucuxJyFdj8c19yYNwVitFXtU3ek=;
 b=JtIuH7EuKlH1suXwWoAqy3EokKPqMsx7bmpTdq/HHHUPPPgDnSQayNKVIlTbA7AAih/KmLe45HrETbxa/gmNa4DtnOm8ClbBGqF19/PH42KBImG8LNbnaFaK6EGDE+UuAyuDlxwAogBaCoOwyVJvI8aAzFtbNoiMBqhHerHrjKE=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 08:47:58 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.20.9769.014; Thu, 9 Apr 2026
 08:47:58 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix typo in OD fan feature mask bit clear on
 smu v14.0.x
Thread-Topic: [PATCH] drm/amd/pm: fix typo in OD fan feature mask bit clear on
 smu v14.0.x
Thread-Index: AQHcx85ybI8gENvKiU6YLvxDztB0crXWa1YA
Date: Thu, 9 Apr 2026 08:47:58 +0000
Message-ID: <MW4PR12MB6803F4511794CB579B7CC7A88E582@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260409031012.3446559-1-kevinyang.wang@amd.com>
In-Reply-To: <20260409031012.3446559-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-09T08:47:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|PH7PR12MB6665:EE_
x-ms-office365-filtering-correlation-id: 0fcf7213-6c72-41f1-48d3-08de9614b339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: d141U3nKZQfItgqf6jRgZTpKnfTLkauv9YQh9QrqfvWb8f+3NL/1BCMNkg9kw6TRH6hUcv5Og0uq1yOAWjbJnMMuAA1nYj7zsBIlQmazHtpXsEHFyoNX56fd4D3AYnCOf89Mm+U5708M2k9cTzlGQnaD8cLheG6ozKAJgfhm8PU3PWBiMoPQeuy74MI85zVVVkNcNFgCyXmHBLPRQfQPtJ6KxfFjErTbtrBqo23rikZWgkjzob8xEHuqkVIbcGJsLrfpNMGtoX5ROTtvFbd2sWzwHp3TT/zDQLcHPaSxL1ODFBd+4c43yI/vZncYLJHqGZWg4JNMfKD1dJKRwC6kgf6gaB1dPgOpCoOHMl0jD2YTARIj+xWIwpTnoPbG+0nxHXj2LxoJpFLwTO3tnGUDi801w5EcMQ2UTkONfQwiARveysNEiz9Q6qUtp9ItSSYMCP6bO9xLyaN/Hm2ImowCP23qfrBB54CWapgAAuCZvBZhvS+DFffL95w/8PI4fmidjVpyMxBdN4L16zpGgllv8P6zdxSr1IPfAIR7SXC5jH8bB9JnJP9bTFUirtxPQXn5L0hyKhtLZiolJ07+b5aT7TfDrmaZtyT4RbK5CBMp9iXhs8HU7Srf8B/cbamQ7rbwfgSUekAnWfxpVGU2pRgcIAB3KBD+c4FeLk+WoLUw8OV1KaReOFmG/WyBBbQwezW9C+BCb6OTgXl9FwaHz1XU8EhjPuWoKvbovEwYCEtrp3gQAYSksg007lciIdgFf2HNDZKgLp77s+T/XkI8CKRjr82QBLRJb5M3BxgIG8OHs3E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pXQBQ9ccm/zsg3nZt1IzY5U2TSgsLT0N1a/bigREFyMN3PeEn3qwA8DRyiRi?=
 =?us-ascii?Q?bjyIhE3TobhxgLTuK4H3p9AR95zQGO3jbklLAvHf/4iXfqwxQew+LKh3gAV8?=
 =?us-ascii?Q?xHB1GANXUlIpEVAXQOqb1trEwZswDYB0Mf9BoeG7fFQxGUfhn9FVkJnlbI7E?=
 =?us-ascii?Q?iCLreqQiJNLa19XOiKmCaOlYCwq1jZYqrmDygTnw81xHvTiKNKaQrBWN0whF?=
 =?us-ascii?Q?wr98y9qEDwc/dNld+LZlGn52BBH+14evJh2LJ1y8iYTEzryNkh6wr07mZZ9G?=
 =?us-ascii?Q?4q4eKjwLTf3RGxMTqqmx5YNoYK73m9yPnLxesa1xC3CLXdFEjH3UtfCqgyAc?=
 =?us-ascii?Q?DT+RkKDbBeSEZKQcWHhyd/aWx4eyPWpvfPjgTqgkr5USB0CtmxC56IhhqX2m?=
 =?us-ascii?Q?7fuQD0I3FDUtGKRt/W7VRuM42JgYH3LuQo1SbMUhof5Yn9a876R+ZFU/N8p/?=
 =?us-ascii?Q?7QfZ44ouebjzr2JCkUPlVt2W6pLLznCIputBEyeZTomwSvmuF9rvnJD61HWJ?=
 =?us-ascii?Q?yiVb+FjpsvUbE+AgOLMUf2KiRG8Qx2ekrBxW48JnQa8nARQu8t12BT+PGy6G?=
 =?us-ascii?Q?kkpXi0bL7PToTiy+TAKve4XIx7lf4+zOZ2DGFQvzvuj6gtLTE9s2CNjeHV8J?=
 =?us-ascii?Q?bTg0nbDryRxGa/945splrCO6E0yv4pDCybtEO4iDmrvEBiJGGoAvga4NKhBm?=
 =?us-ascii?Q?Bn7IP6hrKOdzD8+5JFKAu7I0+kpZ3t64/gauJgTm5tQA7m4OrIgLNgWTOG7C?=
 =?us-ascii?Q?eL32M+tV/2FrVADEjfoVcFYsVWifndCiAP19JeBYl8TSKSaBajhtSHQLV4n6?=
 =?us-ascii?Q?naj3ax753CXjjUVyzLzVkoXsvO2mDq8EhIaVuGvaYkVs2OF/avChI3XqvIWl?=
 =?us-ascii?Q?gaIXsWG5BC4tdVDvk95P0jDDD46iLZvS/1rK4BuigZIz0QSOdTkQevJyMonX?=
 =?us-ascii?Q?If6G29xaErHjWAZ/MYiveS9TtqEvnH68kGn3Uz6K8uvN0nijO+MDGH7IMoRV?=
 =?us-ascii?Q?G0GN6SbTjzsHIBipjzS+UQUAQg211+HJ/g55kE8m7tTXCwmqIoH6YBnn3WAx?=
 =?us-ascii?Q?YfJwV+yV0I0nDe90mG77Q+vKJnGmxQFJgCCJmhFTBDMqxgEF1kyTmMr+Wtmj?=
 =?us-ascii?Q?I0VUMVsrJRucR2asmRQfjrKA28k5Ra7YSQZ2cWqloOjFuH8HlPPOQXie7Vjz?=
 =?us-ascii?Q?V6K5SRScAia2iWybvom6GCITAN4E/y5GwUKFn459aIJtCV5t0glxewDpdZ4Y?=
 =?us-ascii?Q?4W1/SYSHUMrJJGFjepD4m46wpNXISagZmJE6aYKQO9CqlDYvoc4SE7i+hKJO?=
 =?us-ascii?Q?TynGwzNWZAq1GEODZXSNbwzbvyPhWZpdWzAdiqOYNIWyjRKGUjWtiESvznOZ?=
 =?us-ascii?Q?/PG8kR4djMKVRjwVzWLSUBuBK+G6+nGo1txASFleQkt+RUqZBDUb2ZzHcjaj?=
 =?us-ascii?Q?xKIWEB/+ON9dKYQXZjIHlfvLnRyNuSrCIha25nCv3X1TLzz49wK/Ct1WqnrZ?=
 =?us-ascii?Q?bGCcoYV0MNDMGWuWuv2bdAhnql/cNriUhRr/B3VTBrt8AMzh+CODM6i/NdMZ?=
 =?us-ascii?Q?wVCG7brsKmwEeGkMzKR1MvQqSmXsQzi9sAbEHfYSLmrpF4vnEbKfFIL6LR+p?=
 =?us-ascii?Q?fqWmQNHIO34mxFAKd5VMKgTFOJTqiohHRy24PWIfg2Bp5OyP+5P4KfoQJeOF?=
 =?us-ascii?Q?lRhudMBF5j+Vo+wvdLa8JRfeanrKlh9sZzuEA4nfGeTGI9Rc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcf7213-6c72-41f1-48d3-08de9614b339
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 08:47:58.3325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFmUGNnkTDTocKQuNiFRwqri982ZvRLiNhtd5rf1hJnUnlu79DrNPKb18HYxzEqR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, April 9, 2026 11:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix typo in OD fan feature mask bit clear on s=
mu v14.0.x

Fix a trivial typo in SMUv14.0.2 OverDrive fan control bit handling.
The code missed the '~' bitwise NOT operator when clearing feature bits, us=
e &=3D ~BIT() instead of &=3D BIT() to correctly clear the corresponding bi=
ts.

Fixes: b787d21fab08 ("drm/amd/pm: fix incorrect FeatureCtrlMask setting on =
smu v14.0.x")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0ccad0b48c09..fa5131a2890b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2434,7 +2434,7 @@ static int smu_v14_0_2_od_restore_table_single(struct=
 smu_context *smu, long inp
                }
                od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
                od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
-               od_table->OverDriveTable.FeatureCtrlMask &=3D BIT(PP_OD_FEA=
TURE_FAN_LEGACY_BIT);
+               od_table->OverDriveTable.FeatureCtrlMask &=3D
+~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
                break;
        case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
                od_table->OverDriveTable.FanZeroRpmEnable =3D @@ -2464,7 +2=
464,7 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context =
*smu, long inp
                                        boot_overdrive_table->OverDriveTabl=
e.FanMinimumPwm;
                od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
                od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_LEGACY_BIT);
-               od_table->OverDriveTable.FeatureCtrlMask &=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               od_table->OverDriveTable.FeatureCtrlMask &=3D
+~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
                break;
        default:
                dev_info(adev->dev, "Invalid table index: %ld\n", input); @=
@ -2723,7 +2723,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_co=
ntext *smu,
                od_table->OverDriveTable.FanMinimumPwm =3D input[0];
                od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
                od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_FEA=
TURE_FAN_LEGACY_BIT);
-               od_table->OverDriveTable.FeatureCtrlMask &=3D BIT(PP_OD_FEA=
TURE_FAN_CURVE_BIT);
+               od_table->OverDriveTable.FeatureCtrlMask &=3D
+~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
                break;

        case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
--
2.47.3

