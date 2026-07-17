Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1352C4451B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 21:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD4A10E4F9;
	Fri, 17 Jul 2026 21:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lWD0NWbm";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4983E10E4F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 21:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGFP/uCc5LjvVH+96vau9wRS7j/Bt8JTHrJTfJ+KYwF4kHa9fFYie87zeYHnfU35P7HMJYPI0BHNwQv4TmkAgH9szf1o5bJEotK5J0YxGQnaDCPk3GE+svwn956kNVhsqeVBSucFfWXBZNl/fGhC6AHBY1PASKAoVwww6daJ2taLyXhFp5Rg72XYziim98nl009v4f5Zs7WTxIcchMDLQUr0Xc1a1lBXaLdY+l26zsQk4ck8j2pb1cp/RcblLNmCKT2qLxfqOZ342/5oMW4fNvCk8UDF2N7UkWcGPGgdXyoiT5rWjoWTV3MigvoiGZEYhboOt2my/CS966V26MoKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu9mExPtnzadT1UWYcpeMqwwiX3aAm5AM7Yb0huxYGg=;
 b=xGoxXMjqmEEX5DeTFn7VcQRqxRYtntWcqP2xyA67iZbwZGdThpeJqcau/PieEH+STRR6N7kF9KqDS4ESP66A4w/92uJ2eQy/Vta+NKvjJAm5TCITfwAAvWRCjqBkB1wzCZaxc1KB2ozRn1oCslzvOqI7GFdIwu9r/Vir4FGxOB/CHbaQAVfeUKaSDTTpU+eKVplvy/znWqNrWh2Yv6Y1KuI66gNwHtu5hLHE60386w4nf2Q8rRl1WVMzm28uh7WHTnxZc/8goOKgrnNrBE3qNbDwhbNjWObnwARKq9oNodrRixzy6ykGYakPKoL2E87KaI6aPTcASIPUgkjJSbGyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu9mExPtnzadT1UWYcpeMqwwiX3aAm5AM7Yb0huxYGg=;
 b=lWD0NWbmUl2k1WGETA6klMuJCy3FT8s1hz2ivVAvJN0juK57//0ev/mduE3h8dSONv60GKPuA3y9Nxnc2NjFLBrS4wXcPHob0s77VMTLSBFhmkcgsvtRM3O50C3GU3nV3wEyZhjR0IbpJvWfC3DrEnJ6pei30aeaywlY1D5SAI4=
Received: from BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 21:12:09 +0000
Received: from BN5PR12MB9461.namprd12.prod.outlook.com
 ([fe80::680f:56f2:d52:4f61]) by BN5PR12MB9461.namprd12.prod.outlook.com
 ([fe80::680f:56f2:d52:4f61%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 21:12:09 +0000
From: "Soliman, Fares" <Fares.Soliman@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
CC: "Liang, Richard qi" <Richardqi.Liang@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Topic: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Index: AQHdEss7rMXd478p50KeJIbebVUkB7ZyKKPJ
Date: Fri, 17 Jul 2026 21:12:09 +0000
Message-ID: <BN5PR12MB946127BAAAE2D4707BDD8A6BEBC62@BN5PR12MB9461.namprd12.prod.outlook.com>
References: <20260713132624.1173426-1-Fares.Soliman@amd.com>
In-Reply-To: <20260713132624.1173426-1-Fares.Soliman@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-17T20:01:53.4560183Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN5PR12MB9461:EE_|SA1PR12MB8093:EE_
x-ms-office365-filtering-correlation-id: 87803a81-085f-44bf-3373-08dee448106a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: 638cKnIn/F+5Ez7TdQWkfC3znp8NEF54y1FxWYDVPFjlQYIUZqgWi3IbwT17Iks70AOvEpYcBrKofvGMu8y8YPYRGGfh08e2M1vhlsplW3ruYxdhE2FiP5fPzL0kmJggYLh1Ou7EllvCvbISPMLRCpRdC61wZ19vme0cp+fEmR4+EMLLDNTJQJ8WC3AzYLIJWf927IiAYhD79Xq/cp+2IqzY3uw4JR5DcnsoswZAiQKqycRSE0Tx2lp7B4hWsxRPEj9+69dz3p6JqfxhnJ70dRZrErvx+kf0QpaMC3/OtXI1x2CBwbl7oaV03/A146vcTSftzfDjbmLX1sRisDgoWFV7hHEMdNJBtL0QRo28mGYoqEnb5yZCrxccg95LIXtnysMp4thMr8WycLTDXgRfkFGuHgUbDzg2DIaE14TkXV0xyxsjrmT2tSBHDaiFgO1xdwb+RZZvD8jqe6fm0uFCN0T2fH1JAAXCvp5/4p6hpWR10z440m/VxlR4ztq8gzuB1dyauqRDNEwDXmLSgpFxD5dXZdElvVChXcV/x1Bxu9wwNd4PHeVd2Zs85J7ic9sklq0d7WTem9SFxdj8lvkZr1TXrhCtbglZae6+Nvf4/vBtAxRQTLW+ry9g3/97Jyy3ktlJICh8bPjVnY7riVegcFPybfuoCDO5Cs6DCnAQL1VqumQRGFTbp7bH6v0b5YAPqS/ODBxXf7rCKx3XLnhNiNw2Somsr5qvSK5jX3cBRE0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN5PR12MB9461.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4R/TEm998p9cn2xo3I73s+wUiC+Yya9v/6Vvw6NLwarNjqZMBZ5/CcrdSDXC?=
 =?us-ascii?Q?cRqJdvokeog/GwmvOthhHd/kFVUq03DS4NgYjK/GpEVCqzG9wpqEzWbwwPt5?=
 =?us-ascii?Q?RenSsEigOeqkK6tNbp7Tskk6RlsXew/gP9THH6YED+h6MGLFz3t2DDJizLtm?=
 =?us-ascii?Q?ku5uZSu97sc5f3xTrvhAsBYyzuGCTbJIbsIQ3IUO6SELxpSxIMD4KR2+afUC?=
 =?us-ascii?Q?7bzgaLyWposTpXKl5SJGmCzbh42wswEhCcTkSXMeESDEvm9j28MqAq/xJ7iL?=
 =?us-ascii?Q?bpzW4pVwHPyunCjRDy/eaBNED+ZPHR5ip6UFaxzn6USTE1yq46Lj2vwZO9Fs?=
 =?us-ascii?Q?bciloHvu0Ig2KJejFg3UnSG8w9h9CSihz+b+gI1IZgQ3bcmnlCYBJyFSCTFg?=
 =?us-ascii?Q?Msr4b/19y0w78L6zNMzEm+EZvYnxulF51c82dBmJ9Wrwn0WRkEtfaFhQhjdJ?=
 =?us-ascii?Q?eY1Dm7chJokR0+BAzdoGUX2I86JOnzpmkuXuk+mJ5tsLQ7B1yRYiapgqAMOd?=
 =?us-ascii?Q?GFuc3arwr39J1aV8yLt5nyV8rePHPN+seMmfceQU14WDCDRbbRlOUGN6P9jR?=
 =?us-ascii?Q?/QXo29D8X/Kp22Q816f+Dj/O4N+MOSA9WyDlAtGhClw9VZIv0gmggRdkopjs?=
 =?us-ascii?Q?inZXBz/RgDYIrVJrwjQAWHUpScDMaYDXgiQe/u7B5RsqYlQssxRUiJxdelHN?=
 =?us-ascii?Q?n3fUZaDeUFqCHyHzBP/+IKJFgpyt6olI9WnHv/t4Cw+06xEhrle4ZANyyPGn?=
 =?us-ascii?Q?6VfTn3kyIjpslp6WJubpDxlCuyW1IV221oKi4rHAUsRkv4ZXXt1AC+zr8y2C?=
 =?us-ascii?Q?reChR76JTC/ceSkZ2B5it1z8j4O3allJPjCTlBIVl9UuqIZLnG9aAAeopTQn?=
 =?us-ascii?Q?6M+UaESQt/xLIBk7ZIUPlMtliEZNgwHF6eLhLz139CpzOmMgn6M5tHJoryuZ?=
 =?us-ascii?Q?8XHrDageJEQKo+70kBHO/2Xfa0HLGKUDBY9VANNf5BWkOv/WuswL9rsK6eB9?=
 =?us-ascii?Q?qqUH9piwl4mnP168NGPkVButNUS2tqmkPR/qpisv+vgvCmp9NHc26wd07Pji?=
 =?us-ascii?Q?BkTJOk8dK2XIuo6rbfgwIn7AW/mJK74EcKWE4ek5zVxyNMJyVOCPgIjkQ6vE?=
 =?us-ascii?Q?2FXIykHs8UANh0Yf8KL05I9RJy1A7ZOJkz98tw7d7VJ6EwtKDthJoBj08jb3?=
 =?us-ascii?Q?szkYQHH4ebMi25d7FT/vTJ/dEbb1CFWBywQrzsgQ7oN+QNuBcp+Tz1QJuuFf?=
 =?us-ascii?Q?PE4Eq8ER0S2yNLQSPE4wlvJX1FrU9o0ipSA2ghfJI3/iRH55xIcH/ZLBMfDi?=
 =?us-ascii?Q?AMB8uPKeO97S2WwO47WAeDx6m46S8LI4/ZminKZB4FoWjaeVykK39cnYUmLI?=
 =?us-ascii?Q?UcqF/hSvswERl7JYSOsNaunLhtyGfQkgfu43S/9J8xygQgoDQZhwAXspov12?=
 =?us-ascii?Q?9el1bvGzZL3hYzR6ScTVjkVGZ5lrlUg/mHEjjJQH9lzDLQTa/R6VnDRqsRLF?=
 =?us-ascii?Q?B5Yksqf95/ocb0jMfhc5JXDRAbv5qvXzPPKLp6SYbWMiAEzi0Cz4m0zO9+G6?=
 =?us-ascii?Q?xnJfYM6pRYRMf3siveJ+TzOM2MxdLly1rZk2YsOWc0HLIURzxN9NVxEZR3QU?=
 =?us-ascii?Q?ha7XjOswokqLx3J4CCjN++IHnuipDzb5GUe8SCQjRrcIFC+hqjuEoG6HMelf?=
 =?us-ascii?Q?FqNUOfgqTayZdTIsUG6baZ5AE+AsdtF1+WvrJQuhIxqGLtgD?=
Content-Type: multipart/alternative;
 boundary="_000_BN5PR12MB946127BAAAE2D4707BDD8A6BEBC62BN5PR12MB9461namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9461.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87803a81-085f-44bf-3373-08dee448106a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 21:12:09.6840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWbdYRgNADkPz0RprVXbeX2qBGaLmZ6K9/kxIDpS7dOdYukEd6O4qIS1gEXASiKt0meSoPjl347QVlrMqfuVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
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

--_000_BN5PR12MB946127BAAAE2D4707BDD8A6BEBC62BN5PR12MB9461namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Alex,

I've updated the patch earlier this week to gate on when the new PMFW inter=
face was added (4.63.62.00). If you can let me know what you think, that wo=
uld be excellent.

Thanks!
Fares

________________________________
From: Soliman, Fares <Fares.Soliman@amd.com>
Sent: Monday, 13 July 2026 09:26:24
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liang, Richard qi <Richardqi.Liang@amd.com>; Soliman, Fares <Fares.Soli=
man@amd.com>
Subject: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly gat=
her GFXOFF residency logs

Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs
on Van Gogh. Logs are now gathered live rather than starting then
stopping logging and reading an average value afterwards. This is
in accordance to changes made in PMFW.

In regards to messageID 0x52, the old interface uses a start/stop
parameter, and the new one doesn't. The firmware is checked to
determine which method to use.

v2: added firmware guard to new interface, old interface kept as
fallback

Signed-off-by: Fares Soliman <Fares.Soliman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  6 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 50 +++++++++++++++----
 5 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 5c4d4ff001ea..46514a1faf1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f=
, char __user *buf,
  * @size: Number of bytes to read
  * @pos:  Offset to seek to
  *
- * Read the last residency value logged. It doesn't auto update, one needs=
 to
- * stop logging before getting the current value.
+ * Read a live GFXOFF residency sample from firmware. One needs to start l=
ogging
+ * before getting the current value.
  */
 static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, char _=
_user *buf,
                                                     size_t size, loff_t *p=
os)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index f8fd93999617..d94e3dcf7f9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1333,7 +1333,7 @@ struct pptable_funcs {
         u32 (*set_gfx_off_residency)(struct smu_context *smu, bool start);

         /**
-        * @get_gfx_off_residency: Average GFXOFF residency % during the lo=
gging interval
+        * @get_gfx_off_residency: Live GFXOFF residency percentage
          */
         u32 (*get_gfx_off_residency)(struct smu_context *smu, uint32_t *re=
sidency);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/d=
rivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..4206514765cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -110,8 +110,10 @@
 #define PPSMC_MSG_GetSlowPPTLimit                      0x4C
 #define PPSMC_MSG_GetGfxOffStatus                      0x50
 #define PPSMC_MSG_GetGfxOffEntryCount                  0x51
-#define PPSMC_MSG_LogGfxOffResidency                  0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_GfxOffResidencyLogReadSample        0x52
+#define PPSMC_MSG_StopGfxOffResidencyLogging            0x53
+#define PPSMC_MSG_StartGfxOffResidencyLogging           0x56
+#define PPSMC_Message_Count                            0x57

 //Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index 636ff90923d9..acf03838d49d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -252,7 +252,9 @@
         __SMU_DUMMY_MAP(DriverMode2Reset), \
         __SMU_DUMMY_MAP(GetGfxOffStatus),                \
         __SMU_DUMMY_MAP(GetGfxOffEntryCount),            \
-       __SMU_DUMMY_MAP(LogGfxOffResidency),                    \
+       __SMU_DUMMY_MAP(StartGfxOffResidencyLogging),           \
+       __SMU_DUMMY_MAP(GfxOffResidencyLogReadSample),          \
+       __SMU_DUMMY_MAP(StopGfxOffResidencyLogging),            \
         __SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),           \
         __SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel), \
         __SMU_DUMMY_MAP(AllowGpo),      \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 717ba46c8933..1104f8b05b29 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -72,6 +72,12 @@ static const struct smu_feature_bits vangogh_dpm_feature=
s =3D {
         }
 };

+/*
+ * SMU support new GFXOFF residency log interface since version 4.63.62.00=
,
+ * use this to get live readings of GFXOFF residency
+ */
+#define SUPPORT_LIVE_RESIDENCY_MSG_VERSION 0x043f3e00
+
 static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] =
=3D {
         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,    =
              0),
         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,  =
              0),
@@ -142,7 +148,9 @@ static struct cmn2asic_msg_mapping vangogh_message_map[=
SMU_MSG_MAX_COUNT] =3D {
         MSG_MAP(GetSlowPPTLimit,                    PPSMC_MSG_GetSlowPPTLi=
mit,                                          0),
         MSG_MAP(GetGfxOffStatus,                    PPSMC_MSG_GetGfxOffSta=
tus,                                           0),
         MSG_MAP(GetGfxOffEntryCount,                PPSMC_MSG_GetGfxOffEnt=
ryCount,                                       0),
-       MSG_MAP(LogGfxOffResidency,                 PPSMC_MSG_LogGfxOffResi=
dency,                                        0),
+       MSG_MAP(StartGfxOffResidencyLogging,  PPSMC_MSG_StartGfxOffResidenc=
yLogging,    0),
+       MSG_MAP(GfxOffResidencyLogReadSample, PPSMC_MSG_GfxOffResidencyLogR=
eadSample,   0),
+       MSG_MAP(StopGfxOffResidencyLogging,   PPSMC_MSG_StopGfxOffResidency=
Logging,             0),
 };

 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT]=
 =3D {
@@ -2450,19 +2458,32 @@ static int vangogh_set_power_limit(struct smu_conte=
xt *smu,
 static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool star=
t)
 {
         int ret =3D 0;
-       u32 residency;
         struct amdgpu_device *adev =3D smu->adev;

         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
                 return 0;

-       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LogGfxOffResid=
ency,
-                                             start, &residency);
-       if (ret)
-               return ret;
+       if (smu->smc_fw_version < SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
+               u32 residency;
+
+               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxOff=
ResidencyLogReadSample,
+                                                       start, &residency);
+               if (ret)
+                       return ret;

-       if (!start)
-               adev->gfx.gfx_off_residency =3D residency;
+               if (!start)
+                       adev->gfx.gfx_off_residency =3D residency;
+       } else {
+               if (start) {
+                       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_StartGfxO=
ffResidencyLogging, NULL);
+                       if (ret)
+                               return ret;
+               } else {
+                       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_StopGfxOf=
fResidencyLogging, NULL);
+                       if (ret)
+                               return ret;
+               }
+       }

         return ret;
 }
@@ -2479,11 +2500,20 @@ static u32 vangogh_set_gfxoff_residency(struct smu_=
context *smu, bool start)
  */
 static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_t =
*residency)
 {
+       int ret =3D 0;
         struct amdgpu_device *adev =3D smu->adev;

-       *residency =3D adev->gfx.gfx_off_residency;
+       if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+               return 0;
+
+       if (smu->smc_fw_version < SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
+               *residency =3D adev->gfx.gfx_off_residency;
+       } else {
+               ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GfxOffResidencyLo=
gReadSample,
+                                                               residency);
+       }

-       return 0;
+       return ret;
 }

 /**
--
2.43.0

--_000_BN5PR12MB946127BAAAE2D4707BDD8A6BEBC62BN5PR12MB9461namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Times New Roman",serif;
	color:black;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Alex,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">I&#8217;ve updated the p=
atch earlier this week to gate on when the new PMFW interface was added (4.=
63.62.00). If you can let me know what you think, that would be excellent.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">Thanks!<br>
Fares<o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Solima=
n, Fares &lt;Fares.Soliman@amd.com&gt;<br>
<b>Sent:</b> Monday, 13 July 2026 09:26:24<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liang, Richard qi &lt;Richardqi.Liang@amd.com&gt;; Soliman, Fare=
s &lt;Fares.Soliman@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correc=
tly gather GFXOFF residency logs</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Updates PPSMC_MSGs and set/get functions for gathering GFXOFF l=
ogs<br>
on Van Gogh. Logs are now gathered live rather than starting then<br>
stopping logging and reading an average value afterwards. This is<br>
in accordance to changes made in PMFW.<br>
<br>
In regards to messageID 0x52, the old interface uses a start/stop<br>
parameter, and the new one doesn't. The firmware is checked to<br>
determine which method to use.<br>
<br>
v2: added firmware guard to new interface, old interface kept as<br>
fallback<br>
<br>
Signed-off-by: Fares Soliman &lt;Fares.Soliman@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp; |&nbsp; 4 +-<=
br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp; 2 +-<br>
&nbsp;.../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h&nbsp;&nbsp;&nbsp; |&nbsp; =
6 ++-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h&nbsp; |&nbsp; 4 +-<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; | 50 +++++++++++++=
++----<br>
&nbsp;5 files changed, 50 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 5c4d4ff001ea..46514a1faf1f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f=
, char __user *buf,<br>
&nbsp; * @size: Number of bytes to read<br>
&nbsp; * @pos:&nbsp; Offset to seek to<br>
&nbsp; *<br>
- * Read the last residency value logged. It doesn't auto update, one needs=
 to<br>
- * stop logging before getting the current value.<br>
+ * Read a live GFXOFF residency sample from firmware. One needs to start l=
ogging<br>
+ * before getting the current value.<br>
&nbsp; */<br>
&nbsp;static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, c=
har __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; size_t size, loff_t *pos)<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index f8fd93999617..d94e3dcf7f9a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -1333,7 +1333,7 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*set_gfx_off_residenc=
y)(struct smu_context *smu, bool start);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_gfx_off_residency: Avera=
ge GFXOFF residency % during the logging interval<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_gfx_off_residency: Live =
GFXOFF residency percentage<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_gfx_off_residenc=
y)(struct smu_context *smu, uint32_t *residency);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/d=
rivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
index 7471e2df2828..4206514765cd 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
@@ -110,8 +110,10 @@<br>
&nbsp;#define PPSMC_MSG_GetSlowPPTLimit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0x4C<br>
&nbsp;#define PPSMC_MSG_GetGfxOffStatus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0x50<br>
&nbsp;#define PPSMC_MSG_GetGfxOffEntryCount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x51=
<br>
-#define PPSMC_MSG_LogGfxOffResidency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x52<br>
-#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x53<br>
+#define PPSMC_MSG_GfxOffResidencyLogReadSample&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x52<br>
+#define PPSMC_MSG_StopGfxOffResidencyLogging&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x53<br>
+#define PPSMC_MSG_StartGfxOffResidencyLogging&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x56<br>
+#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x57<br>
&nbsp;<br>
&nbsp;//Argument for PPSMC_MSG_GfxDeviceDriverReset<br>
&nbsp;enum {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h<br>
index 636ff90923d9..acf03838d49d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
@@ -252,7 +252,9 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DriverMode=
2Reset), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetGfxOffS=
tatus),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetGfxOffE=
ntryCount),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(LogGfxOffResidency),&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(StartGfxOffResidencyL=
ogging),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GfxOffResidencyLogRea=
dSample),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(StopGfxOffResidencyLo=
gging),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetNumBadM=
emoryPagesRetired),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetBadMemo=
ryPagesRetiredFlagsPerChannel), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(AllowGpo),=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 717ba46c8933..1104f8b05b29 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -72,6 +72,12 @@ static const struct smu_feature_bits vangogh_dpm_feature=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;};<br>
&nbsp;<br>
+/*<br>
+ * SMU support new GFXOFF residency log interface since version 4.63.62.00=
,<br>
+ * use this to get live readings of GFXOFF residency<br>
+ */<br>
+#define SUPPORT_LIVE_RESIDENCY_MSG_VERSION 0x043f3e00<br>
+<br>
&nbsp;static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_CO=
UNT] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TestMessage,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TestMessage,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSmuVersion,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetSmuVersion,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
@@ -142,7 +148,9 @@ static struct cmn2asic_msg_mapping vangogh_message_map[=
SMU_MSG_MAX_COUNT] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSlowPPTLimit,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetSlowPPTLimit,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetGfxOffStatus,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetGfxOffStatus,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetGfxOffEntryCoun=
t,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; PPSMC_MSG_GetGfxOffEntryCount,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(LogGfxOffResidency,&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PPSMC_MSG_LogGfxOffResidency,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(StartGfxOffResidencyLogging,&=
nbsp; PPSMC_MSG_StartGfxOffResidencyLogging,&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxOffResidencyLogReadSample,=
 PPSMC_MSG_GfxOffResidencyLogReadSample,&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(StopGfxOffResidencyLogging,&n=
bsp;&nbsp; PPSMC_MSG_StopGfxOffResidencyLogging,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_C=
OUNT] =3D {<br>
@@ -2450,19 +2458,32 @@ static int vangogh_set_power_limit(struct smu_conte=
xt *smu,<br>
&nbsp;static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool=
 start)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 residency;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_featu=
re &amp; PP_GFXOFF_MASK))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu, SMU_MSG_LogGfxOffResidency,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, &amp;residency);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt; SUPPO=
RT_LIVE_RESIDENCY_MSG_VERSION) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; u32 residency;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxOffResid=
encyLogReadSample,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; start, &amp;residency);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!start)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.gfx_off_residency =3D residency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!start)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.gfx=
_off_residency =3D residency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (start) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg(smu, SMU_MSG_StartGfxOffResidencyLogging, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg(smu, SMU_MSG_StopGfxOffResidencyLogging, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -2479,11 +2500,20 @@ static u32 vangogh_set_gfxoff_residency(struct smu_=
context *smu, bool start)<br>
&nbsp; */<br>
&nbsp;static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint=
32_t *residency)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *residency =3D adev-&gt;gfx.gfx_off_r=
esidency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp; PP=
_GFXOFF_MASK))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt; SUPPO=
RT_LIVE_RESIDENCY_MSG_VERSION) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *residency =3D adev-&gt;gfx.gfx_off_residency;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GfxOffResidencyLogRead=
Sample,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
esidency);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
-- <br>
2.43.0<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN5PR12MB946127BAAAE2D4707BDD8A6BEBC62BN5PR12MB9461namp_--
