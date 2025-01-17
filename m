Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6028FC02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 06:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E44610EA65;
	Fri, 17 Jan 2025 06:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="edEbtRF7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C17810EA65
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 06:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdxcNvNBhVtWgubylaqeI6GcV/Y78hxa7GqqtVJ2AN40rALATuXn2T932bJBqcMAQs19UnPx/MPG83dXHWZOjAycegjVhfiFillloLG2+kcqgP8+sPftexpuuYDjrRQPf+9AqtEl2ar56rvLfozgVNDikjIBBRArwL5MZTuemHFHuaAUtBgi9lQqREMlswTN3dTdRGqvEZfRCQJADzEAbqGVj+uplxUf3lbGwX6DY4Yh3+bUJRX2VQ8SBP+dkXJ1lYOHXnZmkC/x+naVyj7L83hMbz2tHMF2tJ4MyPLNY4lrHUp/cNmHjOmESzT5Q/Wc0nHQEqJV+3PuqSwrh09p0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgh5jxEi5tKE/Jj6istATqU6sRhR/fJzLu+RQ1p75tg=;
 b=qUT8VId+CIHKT27E1v+IVtRI7zZIIHtu20JPvOuen3xcKBrfgY4/FNOURLANv+LCSr7t0bR++mhguXsqiYpgMEoqlxEaaIwGzc+ZxUId9917Ss36VMxLFJIDzADeqY9Q2ydT3XAkAH01/5YVZzgNeUeSGxBywE/mKW+gZWrcLY1E2fqqAz+LqKUrTrXuxnngDDcnMWE9U0MrNbR/tHuMjQBt7EFekud39TBemAJneX196h6mJV0K3jxQ1FT7Z5BujQypyF3mm3iFDWRpzYmh36yW1fTIQTGGmsGE1YO2ENrntG3T9WX6VzBq1B1Wc2K8Ea0CACfsPxa369BcljgEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgh5jxEi5tKE/Jj6istATqU6sRhR/fJzLu+RQ1p75tg=;
 b=edEbtRF7YFIYG25mFLi7j29jb+3GtD6zTzJWDP1jEUNNKpv8PweCGAhEAtjG+RTLL9RrPjl4m3mIxVLgcBGhOb3z479fjihwo8EtGRv+VZuVWXnggHRIIk3Mgemu1LWO+7jl5lpiWhHBfGSOFAV99i6nbxzO+E8aYEX4RD1xzOM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 06:21:47 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 06:21:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
Thread-Topic: [PATCH] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
Thread-Index: AQHbaJdcCrTZD48m/0GVKAjg5peo0rMafrcw
Date: Fri, 17 Jan 2025 06:21:46 +0000
Message-ID: <PH7PR12MB59974EB0916D8725921D77ED821B2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250117042108.3840620-1-jesse.zhang@amd.com>
In-Reply-To: <20250117042108.3840620-1-jesse.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0c309f4b-9c1a-4629-a86b-43915a20b2c0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-17T06:20:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB7621:EE_
x-ms-office365-filtering-correlation-id: 17635ae6-70b3-4cda-a593-08dd36bf3859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eH4NW+FosoYoD5cp2FKr+tq7fSpCwVus22tJe8Kd6yhEboJrUDILhE2TWVZ0?=
 =?us-ascii?Q?aZ54RISHh4fxOwj1dOf/Inoi0FTHK1CSnVKFB+bqh0G8kJDbCFMA9DXZhWRv?=
 =?us-ascii?Q?wPGhS2Nw21Ab+robrutyNKLJIumtWrL4fu70WFNBppzRo0b8krWAsLPVC78K?=
 =?us-ascii?Q?3SIMq3AQgMBHNgSe0O/KUgpCPhHhrDYTi0wlvPyj0c7B9vPYhFqu66uWBQ3U?=
 =?us-ascii?Q?ikZYfnstGdTISXsVXAUQa1ky0g0TNUM08xGvuLVT45QwN5BfbAd9wu77uSCB?=
 =?us-ascii?Q?3CCCOHwRO4xFAt8igH7Kgp18wgxGAK89elzWIBScN+3/KQXFWiKd7QiEif23?=
 =?us-ascii?Q?AAXG+gRkOh7isWi8Zdk/XJlrQT4AfVNSj3LW7ETGT8JCNT1wlYJrYfXU6rOK?=
 =?us-ascii?Q?nCHKbF8T3B4XUZRU0u/GhbmKu4mTmn1YUFIWkCD57YwNB+0n5OY4g5YSdPXz?=
 =?us-ascii?Q?HCDPmSvXw3FwIsQZK9ZI5mZF0D3t3BVKltH/J6SZTRTWldbl/cTlHmiXX/pc?=
 =?us-ascii?Q?PzV9JmVBJmIjD7L5xferjKuwJWyzZbo6KgEkMR3X8y2G02qH787abnPbFu5v?=
 =?us-ascii?Q?LL8p5cBC1Hjxm/ZdtWxt59aS3eIFv7nPn4OHDn/5RL4kM7aqg+SybMo2ISo9?=
 =?us-ascii?Q?sm7m8Ki61sZIk/nJBN7zYTtBkiS8vGi4cN4dIY7Bfv15qvcDgWKNU6taN49L?=
 =?us-ascii?Q?hPHTnOPVmjNouEQ3/hmQ57jQBnUSii5y0/N+b/zTb8hweiYRBnbaCYPN1sAz?=
 =?us-ascii?Q?v6LSXHsMV+OOt2iiri498FxfVhZDXkMFk4hcjj3ddpkhLS5wetUwiXfAGp+8?=
 =?us-ascii?Q?2h9DZiZIR7FijqTT4vi13jugDrkfKxha4V+XJimxg9sIbFW2N8RA7O11S4iU?=
 =?us-ascii?Q?r1NGWoD76b/W4aSocMAZF7ulVGH2FMJF73avgOJPVENdIO8K2OF2i0SBSEVi?=
 =?us-ascii?Q?OucyClvCByi+E+zOIaDyFImgZ+ERDu8GOkU1n6bXKBurWpPxACwnDQmHxFnD?=
 =?us-ascii?Q?HiNWHZ1O714pBFtIoYg4TAqjuRfOv8qD/XvOlh0epyoyWFvMM/xVES+QpsDE?=
 =?us-ascii?Q?xOzGn7zDnSImioderMqTcLsIeUTJ9G5INHpRD1oihrhigQDuTAC/C1T5zJrL?=
 =?us-ascii?Q?NG3ZONAj+MoLN3Hfz7JtlrpSlGMuDECCMCMLSczDpgniRb82KnRIps7DEwH4?=
 =?us-ascii?Q?A/Vohj5mrKwpz7Y3eHV/drqhtUTEMsTOjH2yFzmX+x95hQhMpDP1ph13dror?=
 =?us-ascii?Q?Xv6WTHYcsyXFPv3HX4MOYgO0qNZCcmqrXqiv2wVf3+t7buUFp2cA1E9Zzu/W?=
 =?us-ascii?Q?pDhz57rpTnFgGdMCyowUS3hgCK4q+Ah3d78ID9PRYxrdjFuHjgxh0AH6mdQ7?=
 =?us-ascii?Q?VLRCPDv91dN5Pt5+XTIjN5AHLhW6DT08sfsQqfaoa1u35Nc18wSRDYWx1xru?=
 =?us-ascii?Q?39dRR3Cw1Jrqd5oxp9oXJdOVl+7jdUyy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?frWeQjeozEw56IqKXd6MCaEtBRFpnbGLw6Vc2Htby89wMuR21qU9j0IArqNS?=
 =?us-ascii?Q?v9a3JLq19L5OebolRciXFLQ+Oc1UjWbyQntMfZPPmbmmSj/Vg5stRhuoXRz2?=
 =?us-ascii?Q?2jNyGzxj4ji5d8l0ImVBaYgS2e2WzdBGgFwBuvlJs2GNMr4NEPfinxo6jC8r?=
 =?us-ascii?Q?YwJWeF19cadsSVkYNfEHsbHFSwlO0E0m2mMWRS8DLgYw65KxvNqEf+YKAzuc?=
 =?us-ascii?Q?6eKoXQDOd8DvTyhEUYjflbkHLMNX59sKaYyXJpZD17svuCXwHmBFtOWfuH9V?=
 =?us-ascii?Q?03BhzLIQ81XIwkqP5KLV2LijjlFls3bO5umRYFx7QPfOyd1EWm/aSq7SKU3X?=
 =?us-ascii?Q?G/qSpVAy/2syPTKJ3vuGfBdFT6bcXjEASk37LuK6tzWkRRS119QMhC9Jy/IA?=
 =?us-ascii?Q?HxwO82u8EoY+u3KWQfA3JcuEtzz8SLBgS5Fvd5AjDlvVa/F3tvfEIHNPBLHj?=
 =?us-ascii?Q?u27j5/WftVGjK/7X6b12vX5S3fznvMnPcqy/wVB0hQBpo7ZJfYRhLtOBAqhg?=
 =?us-ascii?Q?yE5D+38Yeb7XUon2lmt5FH70CQkfeYI6KdbM9hkhLbNeShxT3TrT2GXR5O/f?=
 =?us-ascii?Q?ship5IB3AbSYWp26e3BPlahXdHYRbSICbQE8/Favi3idUsLHnizyfmEmsL29?=
 =?us-ascii?Q?5RQCs/XivwEZBlQucCS0fGnVm7blUOrymW2Hv/W7b2D9tgNnV6jb19b1CbJC?=
 =?us-ascii?Q?1u9AXMXCQNvu99qGTq/wYFf4x/hLe7p4/iF9mqsdegqhetrQ+htPzGvE+DIY?=
 =?us-ascii?Q?Omhkfch09BDa1sg86FDpCZ4HYfmu5vLE5zdBv0udJRObBDu6AZfTtCSVfiX3?=
 =?us-ascii?Q?wmRZwvBqufF+r+rxu2/Kl6msqT/noAmuVSdDLZ0NLTw+FFNjM38g7QLhFPJ+?=
 =?us-ascii?Q?kw6rXzRiFuIdw9otg/7kZIRcaIOuqA8naEdZ6WE34HAwOJQhfcWwTX8+6tLg?=
 =?us-ascii?Q?pmT/WU2z4jv+XFjsxdC5Fl7ZCcURiaO1Ir7fis5yF0LoPsFyvtlB6t8F/QMh?=
 =?us-ascii?Q?iYYU4lE7P07IgID5ZH/kTxZYffaTrHBQXWVZMxIOB6WaP6CwFQT2TGCXed5c?=
 =?us-ascii?Q?jtt3NzT5g6RvomCBDSrGehektCkoJc5EVuvWMtHa5+Qamw8n2rLaFMJowvuS?=
 =?us-ascii?Q?W5YGbYRmJ0StqLEFFyVhdNTJl1wZwuGtDloIsCqyTnaqgVXpab3OFTOyb1VP?=
 =?us-ascii?Q?z80ylCrtyBQQVUAOY9xQqd8JTez1JQUxXpAvJEMEJ2wAU2p7Y22lC34FpJc/?=
 =?us-ascii?Q?9NE9UxE/PiiDjo37zr6DXFyNLzos12mOQ8UfbnK0k0A+kBGyw6r8Y5wp6zP1?=
 =?us-ascii?Q?RTOGJU6goATpX0nEPt0QwUomzhNAEPaTx3nTK2ykR5zrQ13cMNuHBqabc90W?=
 =?us-ascii?Q?m37PVWzati/JWYFG3MpgqQF4zjBlJU0JAcCx1Bqq6TYqTSmZiP6tRp9ZgUfX?=
 =?us-ascii?Q?vZEzYYRobHbqMGCEraCdubn76JNVvgjBCZmGvRk0XhFvQAq1WJVY4JSFPfhW?=
 =?us-ascii?Q?HTdKp14lRo5jkDK77XbKenzhrnPucTDhnC9R+9jxwipKgC1WUhCU3WTDk8u3?=
 =?us-ascii?Q?GJqmCe8eCFMoCvPB6sg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17635ae6-70b3-4cda-a593-08dd36bf3859
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 06:21:46.7909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSV0tGjdHTSb2JPB5JLtH72IHR6TuJOJK7mtE01Wgl9TOvqbVDOLmnr2Cle+GcrN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
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

You'd better re-coding this patch base on following patch from Lijo.

[PATCH] drm/amd/pm: Add capability flags for SMU v13.0.6

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse.zh=
ang@amd.com
Sent: Friday, January 17, 2025 12:21
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhu, Jiadong <Jiadon=
g.Zhu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie) <Jesse.=
Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware versio=
n checks

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the firmware version checks in `smu_v13_0_6_reset_sdma=
` to support multiple SMU programs with different firmware version threshol=
ds.

V2: return -EOPNOTSUPP for unspported pmfw
V3: except IP_VERSION(13, 0, 12) which is not supported.

Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 35e2f0662fb5..31d9aafe0e83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2746,12 +2746,23 @@ static int smu_v13_0_6_reset_sdma(struct smu_contex=
t *smu, uint32_t inst_mask)  {
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;
-
-       /* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and =
above */
-       if ((adev->flags & AMD_IS_APU) ||
-           amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 6) =
||
-           smu->smc_fw_version < 0x00557900)
-               return 0;
+       uint32_t smu_program;
+
+       smu_program =3D (smu->smc_fw_version >> 24) & 0xff;
+       /* the message is only valid on SMU 13.0.6/13.0.14 with these pmfw =
and above */
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2) ||
+               ((smu_program =3D=3D 0) && (smu->smc_fw_version < 0x0055790=
0)) ||
+               ((smu_program =3D=3D 4) && (smu->smc_fw_version < 0x4557000=
)) ||
+               ((smu_program =3D=3D 5) && (smu->smc_fw_version < 0x5551200=
)) ||
+               ((smu_program =3D=3D 7) && (smu->smc_fw_version < 0x7550700=
))) {
+               dev_err(smu->adev->dev,
+               "ResetSDMA not supported: SMU program %u requires PMFW >=3D=
 0x%x\n"
+               "Current PMFW version: 0x%x\n", smu_program,
+               smu_program =3D=3D 0 ? 0x00557900 : smu_program =3D=3D 4 ? =
0x4557000 :
+               smu_program =3D=3D 5 ? 0x5551200 : smu_program =3D=3D 7 ? 0=
x7550700 : 0,
+               smu->smc_fw_version);
+               return -EOPNOTSUPP;
+       }

        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                              SMU_MSG_ResetSDMA, inst_mask,=
 NULL);
--
2.25.1

