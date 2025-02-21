Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C9EC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA46A10EA86;
	Fri, 21 Feb 2025 15:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UJYrvsY5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDC110E251
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vt9HRj0wj3utpNkMlCbkYwEodRpV7jcBOLXbdrQOnK6pTNvWaV0oe3G+8T4GfBVU5EO7VO0WzUgvvYfwUvH5RFJDilFMyZAmDl56KUq0JtT8UwIBzfdsh0mx6qyrpHxXP0AoeKFtgUKYTUyMoK3AlD0v6Dg2poPNoqfuoQoO92dW4dfSO7lAlOQQkwomncALlxSpE3cealh+bcJQvYB3fw+RUNL7BAyxptDA+Pz0gXxtTUPbMFbwkbYHZGLuphkDaAFNYg9MSMydT1gLjBW+y110xvyXG8zhTx5ZJafsWfq/8AmWvfWw3jBlBLuvyU8GRptuPJ0ZNsIEM1nbsrMvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8sCGgZ8M0+q5SI3VKtrJzDbYLhEtFkJaVYyfrJClVs=;
 b=tcAeRlywijVA0GhBJMUlGLO3LTIxU6rxWBKRkHDimy6fLgCmg/baEXLjh4il+xiT08R+tVEokned7LBHRpwQakbsOYIhc+BlsjQP6ekx8Jf2z7mrHi5DjcDKcnwl3RpWqfUGVQJ5bcMNlWWrVjH4Ij6hL/fHADkDP0XXAXAq5I+mO1IgGfVNjZveFIhEkkiKowN0qBlTESqpssPMb9FxEjxzEmsWHw0wvM+HQeKHPIeX1hJERSlV3HxIMQC+zPPuNr6qJGrkOdmKkDDMP3mguzz62oxRJyOStgWLjgeL5yjU6eHAHbEAwQr2MjoQMFa5qCP6OZAXKq0FY6+dTvqkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8sCGgZ8M0+q5SI3VKtrJzDbYLhEtFkJaVYyfrJClVs=;
 b=UJYrvsY5pOaTm2PDPD78pvSYZX85rVllSr1UeT0hJn2hSr40xa275yNAFkHT61w/713WSrkQK0V88rp1HkMc7coucgeZY4b1Sw8FTAPPi7ORyYcK4ZEcpjp/mEjUFelZJpvABECdHOUOuV+utpvQojg/tbkus2I8wWu64AmtnSU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 15:15:24 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 15:15:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: handling of set performance level
Thread-Topic: [PATCH] drm/amd/pm: handling of set performance level
Thread-Index: AQHbhGfaYFIpqjpPekKph7MS8reoRrNR3epg
Date: Fri, 21 Feb 2025 15:15:24 +0000
Message-ID: <BN9PR12MB5257AEC07BC86F071DB9BFFDFCC72@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250221135158.2582632-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20250221135158.2582632-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7c7d945e-49ba-49ea-bbcb-bccca835df96;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T15:14:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9250:EE_
x-ms-office365-filtering-correlation-id: a01413f6-ce98-4cca-7162-08dd528a90d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/Jm4kvuKQof3622q5VDkRewI+H5vAoIIFVfFrk7fg/KYFczpD0q2RXlJ0QOn?=
 =?us-ascii?Q?Fo/Yr/o6WrmKBhu2CgPC/YUQr2er/OtS2AjpnsGmmnBCPFQaOA7sbe3pNP00?=
 =?us-ascii?Q?ICe6M0OvQormCAwnbikyWihe8dutYKn3nsyaLAx1YoQD1VbM9aM7/F3PwZu1?=
 =?us-ascii?Q?i8pymArXOFna907CmZTcxwLah9oPi7hc0+MXoXNK/GZeJ6gVAawL8ykfpvbq?=
 =?us-ascii?Q?DdAeVp7husXQ/7+821S3UzWdmRn45Sk4eARN4Ol3qd0P4c1YjnaZTzjBarSs?=
 =?us-ascii?Q?wiMYNYDuuw0sApBPZIdK8/DzoHyseFRbgV9hSoBYZ8y9QxFPe4/jR9ets7hS?=
 =?us-ascii?Q?BUFMEe6TfGf7vJ1QN6gkE2sGHoDD4SMlqrOiGr8gCVtCcjLBwRRuRL3xOvzK?=
 =?us-ascii?Q?DxfLcdsO8C9VcLhlhHCDtGRTGHb6FiarDS9mXoxPGjK5L9yj6mp97fcfRWCJ?=
 =?us-ascii?Q?rh+tJybuF6hoakX6AacP3905CKPmEFoDCZWazZxPQm9ANUJhqnoFpkpZX586?=
 =?us-ascii?Q?zu69lN7hQs1h+m2ndGT9UZrunj4YK9jIzu06sycrnrhlNkP1DIr6WbSUuuSy?=
 =?us-ascii?Q?umeZzY7drG0UFzh/dLEXCMIpU+feGRoo0ay5/zjg2YZqygIluk4ZMYOZDedm?=
 =?us-ascii?Q?3DPtPE2/A144a3hyjKR9v9+Wu3tFqvacLkhcIDsn4uCbF7qL0Ze/nyASIPxg?=
 =?us-ascii?Q?5kb8bDR+tDxur4nkZ4nel7EqRJs5GwWkkq8ddcRx73bKvXxUMbYnBNqSceE2?=
 =?us-ascii?Q?sL0fYETyAspCdi0dNIlI7DBrerkJxN375LIwQ/qj4LFcbJcCfBBrLf9gfXCS?=
 =?us-ascii?Q?hMCn/RdUb9iExj9tpqPqWVepFukSMK2ptzIr49h+O61X6+lyrDq2lu6kDmcC?=
 =?us-ascii?Q?H/jWJcqJ/dF/0sTxTPd27UBeVobHWXbZsfhFH7k4UQ/8L1CoONx8HA5h1pe+?=
 =?us-ascii?Q?UiGVe9uNWdjlpa3gOWchk3Wl3K/I3wmVpqXUEWGWSS642otA9K1VB2ki+oC0?=
 =?us-ascii?Q?oWH/AHljffNykxZBRPv/dLikn90VdH9wLW6YvCdDtC4usiHQYG0eJH7KC5UQ?=
 =?us-ascii?Q?7usNozfa/MHSYzPJ/N9SGYjvt8Fgd89PQAqzTA6G0HlCCUDWfPaC2THpMFzr?=
 =?us-ascii?Q?Fy7zEke7J37YQDiKHaRgx7UpTodWvhmsbNc79stfVfpLdR8bfC4aTwqXLjqz?=
 =?us-ascii?Q?elQvFnqJtLiPkvMiG63+Bo6Lx5lbdzfyUVXVu5igGF+bmwPe9pMaYCB1JH0D?=
 =?us-ascii?Q?gOciXtLtn9wlLmbRNjnehJmJPd7Zufz2QYPDldmF/dUE3zuqtNXMtM43pVmp?=
 =?us-ascii?Q?rzTTqaPlPs48tqkYLuW4xyvwI+0xGxZrKqZ4756Xr1c6sat6mOpdP0kp66M8?=
 =?us-ascii?Q?A9CF23T1o9XjBWiHC5EALhwkUsBkk9Q2+mLqdR4+SEBkVWtK3NUO3w9t4bLp?=
 =?us-ascii?Q?2flRMSfOZAzxE29Px5CNiANUaGNsdBCp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GIjSkgJg4oy4PIC4OU4bFjbJp55EBhDR3euE6SaO2FHTaaodZzghJsBf1yqx?=
 =?us-ascii?Q?vb5BvHuC1em9RurQx0+CWkMlSx7VjsZlOEqsNdvlY8uxkLSqPXxXAbvlgb/W?=
 =?us-ascii?Q?KmLW6MK+ZH4hPw283s2ff+wFOaLAI0e+ZnFNp1M/ICbilDpduzX+cB7GUi09?=
 =?us-ascii?Q?qDBXPN4s+/w91fiqpDk7SfskVcw+Onwr4EJJXPW4ciSWl0wckVgyBd1oOyp7?=
 =?us-ascii?Q?l1NWeoKW+mxUmmYLDjZSKZKagQuZvVKgd4Z+SwsTaLGTPsiOWDzPIY2QwJgB?=
 =?us-ascii?Q?tEdDHIBJm8vjkkJ+sHHWijBIDUoDjG097PLvfWqs7+ILPMcGOt7a0ptDw4mK?=
 =?us-ascii?Q?DWES3uCJ2rSi8ZpXXmUPFL5w8GpDA2SjFXMszs+tYJwVdpvzyNJw13zXtxCB?=
 =?us-ascii?Q?rvB6AntA0dL3R+Zsv+tiAgRam+TLUC6/u+sEjoxRS7Vs7MwIHF1jVJqRfi1U?=
 =?us-ascii?Q?C4Mk2/ivv2gPocS2fJsIokcSXUm8Muzm8OfbT9E+w8939W7ceNhhIeu2YVUR?=
 =?us-ascii?Q?Tbbxjo0R7xem82rGyZv0zmPFxS3jQLGKTHY/ghRXxl8f+Fr0ZfJW7roTF5bM?=
 =?us-ascii?Q?LWII9ZbC+jMKnWIomiOY+7ImlmHvIrT5x39wY9zh9JvYzvcE0NANpbElfanv?=
 =?us-ascii?Q?69UbCsJavTBPiwYHeGRhkLvg4tDuUlSmXUTRz/8dPvr0HM5HCOsFUALaFxbC?=
 =?us-ascii?Q?56EHnBra/tARWV382KgSCxBP55uFu4/uQ5hTfQQnFJLfbyUfHcqvAiGIxQir?=
 =?us-ascii?Q?nG8KTWezTZ4dHEPgoUe80yFbNSr3ZVUgFaNcl3AyP79Xm68imJLKKyPqVQ52?=
 =?us-ascii?Q?6DvE1DSLzitiXWlYMrJB3x3SB3AnpaIwpu0fST8x1TlfR9YaV9Kyl8pVJif9?=
 =?us-ascii?Q?Rv5EJL/vQOD4dCSq10bdClSLmIW8BfOH+U5Be93JG2g9ClqRngklc4g70jMZ?=
 =?us-ascii?Q?2ESIJ3fGcH8KslqQrKLdiTYFkQIi6oUAqy+2/BEbT2cMGxmPdKjPt1oBkbGB?=
 =?us-ascii?Q?DCc2iRdqmf5I1++9TGbOATAeGpoVnMImdBQFoBozApkb4yYyY0iHBFlEFKVG?=
 =?us-ascii?Q?0f6bhrO6Z4zon1LRfPkL6lriSVXF5QbpjimKr1wcnptO2gGVrBn0GzvdNIUk?=
 =?us-ascii?Q?knmAk46yZsRnTdeBH+Y7Lx9jwYra/1uVWg1HnW9oNF3pyUs8Y3lcdmBrswXX?=
 =?us-ascii?Q?4sPEak4tfrI6n4CL3/72v9PTpPCfUcFv75VaToVm4m48M4LPKWW+Xn00Uq9i?=
 =?us-ascii?Q?QYHdOH0IJ3gsFVeWT2NiUC1B5132jRabUqx7OTBl0qg6XCyARHB1k4ZttOF8?=
 =?us-ascii?Q?bq+fUpspy29kgsEXlTsdNw6iuHHXOTqlrI1WZyw40lk1yIJprV+DEVVTuoOC?=
 =?us-ascii?Q?2mqY1gXlKDQkU8t29SaUXYImzETo3H4U6W1ZpktIX6nGN3leIL3tPP6MuCqq?=
 =?us-ascii?Q?d4eedzlLJLBT5GZbDBUKqd34NJclCVhmhBNF5Q6sik5EeIxLN24lx859b8z+?=
 =?us-ascii?Q?CPiAPwUBXV8PPAX7DfNCVv2vUP1uIYjA0d1N8YPnKlHqaJa9zYUGXWvV2r6v?=
 =?us-ascii?Q?xUJ40OkJxC7r48QtsKc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01413f6-ce98-4cca-7162-08dd528a90d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 15:15:24.4953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xB6XtyeS9EhJiUn/33OYB29gHIhJ51N7GHmfZ2LTsh1GQlrf2uSL3yxnuOLg154qZfmzQzFfk/PLkT3Xqobalw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
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
From: Gadre, Mangesh <Mangesh.Gadre@amd.com>
Sent: Friday, February 21, 2025 9:52 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Gadre, Mangesh <Mangesh.Gadre@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>
Subject: [PATCH] drm/amd/pm: handling of set performance level

display performance level when set not supported

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index d71c8c58caa4..c3552e0cb35e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2315,7 +2315,10 @@ static int smu_adjust_power_state_dynamic(struct smu=
_context *smu,
        if (smu_dpm_ctx->dpm_level !=3D level) {
                ret =3D smu_asic_set_performance_level(smu, level);
                if (ret) {
-                       dev_err(smu->adev->dev, "Failed to set performance =
level!");
+                       if (ret =3D=3D -EOPNOTSUPP)
+                               dev_info(smu->adev->dev, "set performance l=
evel %d not supported", level);
+                       else
+                               dev_err(smu->adev->dev, "Failed to set perf=
ormance level %d", level);
                        return ret;
                }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9f276f393b81..7fff57900a58 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1947,7 +1947,7 @@ static int smu_v13_0_6_set_performance_level(struct s=
mu_context *smu,
                break;
        }

-       return -EINVAL;
+       return -EOPNOTSUPP;
 }

 static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu=
,
--
2.34.1

