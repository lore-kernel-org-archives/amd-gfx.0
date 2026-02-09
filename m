Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57160E81BD3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 17:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66D310E438;
	Mon,  9 Feb 2026 17:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kwsw2Sl1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D18810E438
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 17:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVGBP2TZx7TPvaNrfa+pCe8XBfwX1EjHd2PdnIIzOqiHMrpQOUyukrvMdeM2kdoWVeYbQ+jmClkTcAyCXWZpFys3QJ+yaSk0Pq6vOZCSt1apANgiVHmjeB5rTDspKQxw3RvJ7i12OPS4U4fDEWP3REacr39mkIqmzOzqa/wgwrC6j7KEdn8JDzv6pi9D2QUuJ8Af2upqDZcBZlXn3GTYw3RKpSmpr1upYfkJZ1lV11e74P/lxUQwhj9a1ZkbpFtxO4eoJnxJO1HlU43HZSWNUclaw7bZX5gETgdMnk2pgHoc4Mldr8PRrodLLbGtBmUvWYuM/99OtsOrQnXrwxapQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R46qn9nfQJWhxzI0EGb+PPkirgaHtYGaDzIFszBASOo=;
 b=B2ovT0H6XA6b9jOcpUxz8d/x+5nBGNK576HE4oTUmnZM7y7YCDHZYtY6y/4vk/01ecjM7qL7VaU1ZUkIs5O/Dwb9aJ6I4+uEkMM2tQcdqdSSpbkmYVF6V+S/aI3XzXJeEUUTc1at6h6pFE48oR5IR7dqcQ1iNwbdEdzz6ysNhs4dkAJHtk7DLCrIuxHELnK4DnN1yRZ+8BPXBrj2QvNqyfUQZyaxA/1ZIUb6GKLQCUMsiCxIbB1pCO8HSBng/yslTlp49MrkZB3MZ2eHkAVLdlGT5MFcVOU+zCAp5QLlMAtOQgHV7yqE52bOekwy0a1vaaGHs3L4lFQTc49Os5oT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R46qn9nfQJWhxzI0EGb+PPkirgaHtYGaDzIFszBASOo=;
 b=Kwsw2Sl1+ubUdjvY3VuSV+FVxHdxUqmLsdZWB4N0Y7Veh/9Ey1VwDNV3csNSjL1/ngJvutboW8BdmLgymJLXd1SJTVWeSE0Bn1DWXKbMJ0rauUSDGjcN5iJHZHGcyOkBki4YUf5zBd4nv4nzpW8zdf24usVmJFgQ9xmjmUU6z5Y=
Received: from MW4PR04CA0350.namprd04.prod.outlook.com (2603:10b6:303:8a::25)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 17:07:45 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::ad) by MW4PR04CA0350.outlook.office365.com
 (2603:10b6:303:8a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 17:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 17:07:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 9 Feb
 2026 11:07:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Feb
 2026 11:07:44 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Feb 2026 11:07:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove some retired module parameters
Date: Mon, 9 Feb 2026 12:07:36 -0500
Message-ID: <20260209170736.556398-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a7e2e3-b399-407c-7553-08de67fdbe98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OOgK/ti2J4Ryw+nLR3q4fzcIzbDeLVFYyeLffoQrpXdEtOA2BTIGXXDwIwvi?=
 =?us-ascii?Q?g08xPUvrnkU9Cze0BtCqto0+Pa64E0iMQOw204PkfOw8meAPTh1OxjUwdUyb?=
 =?us-ascii?Q?GjBF2feFUBhxXuyAbtJAmVAwZ1/THuA3i0sHs49EyvGsQGTCFI9tONAFV2Vr?=
 =?us-ascii?Q?GE38aj4dLgKc936LgLphMhz674LesRJUGlyTtBsiaMSQHC1510dOS8YkCd4l?=
 =?us-ascii?Q?MfJ6GWpTXorHWjpVz9thKpGXsz5KR1nTi7jz8XAMWFcBbPwBrM4gPaYG0Nfa?=
 =?us-ascii?Q?Yr4mUQJJo1n76DGIYtdkJKlR4acwlp9YPyisPvWgzhQU/AL/mTHHedSZelh/?=
 =?us-ascii?Q?w9gIBJ8FQr26FYTy/bcWsmTs5JT6aGQsCz6XU3mdnT6iI27AfQdgRjSF2D6Q?=
 =?us-ascii?Q?7cXLNDss81sVDRCLb/HWbw8YkBAtTQqF8HQsAu8KMYE22UWaIG7YHDYWkiEl?=
 =?us-ascii?Q?fob21sLpjA3/9zoVpwIwUsq39CD7siY+vkcFsZsKUCiMGywwYW0JC3ZnIPyk?=
 =?us-ascii?Q?J29Fl5qBthdDD13p+YXOS/oIVJcFAQTk4aLyXQxHcGfCh3y/q+6TaNz0g58Z?=
 =?us-ascii?Q?QXrSRf4rWCgktuL/5f9nmavS+AlKJfk8BjX/KpCFT8Sn5/m0H+D9pVoF52yz?=
 =?us-ascii?Q?k+3UuD6QGRXOVeKINySyobCgXi7RZaPoOc/kXuQUdr2sX7LNYpVi53rOmAKU?=
 =?us-ascii?Q?v+aTCT6NiPwZS2p0AHBx1mOd7iW5hq+Geg+30oVkC38LOAn04AA3U3vS3nlA?=
 =?us-ascii?Q?1wQPuD8Xr+CdPbrzgd741O4xHRVjPysWAeMbYRjhs5EWPDYfwSMEGlfl6q6r?=
 =?us-ascii?Q?ACbxjhOtyi2qQ3n0toVlFqDmJlaYhvuYAF7VS7vZhYp/dO4I+Yl/kqQZvW8z?=
 =?us-ascii?Q?FspmHVceSn0xheWoJjQCwAeaFVFKixxzenlh4fPreqc7dL2qrubkElog1mEG?=
 =?us-ascii?Q?H+yrq/ZaLj/4LqBBH5dm7LbMubPw6AAPq1arcvCnytn0ocPXouQFTJX+HsSI?=
 =?us-ascii?Q?R8MAZS3vSMPKgXUd9eyjIfRef3RJYWXwfhKXravdaai7nNd64Jd2mvyp6k3j?=
 =?us-ascii?Q?eVUZ1WyTxYBinDyzL0M4QOfdeAq0cpyokZcAa6tGdtcc3bRbyQil3frhApul?=
 =?us-ascii?Q?J9N8YjS4b0XX2V7+6T/I5pLZojSakB4b/rgqQj3qqiFkLczarN5HP7YQ3bxp?=
 =?us-ascii?Q?HCmuByfW01ai7UlamyqRnKozbmjsAjBMo9hmOLcrpM0h9+C+PDWx3I8b8rHF?=
 =?us-ascii?Q?xnnh7aJOp7nFhiI0XiGsUJOufuIz4F1WqfCkHx72+rnu4h2fGsLtWngF+pgO?=
 =?us-ascii?Q?fipo8aZTadq5fy/aiqdNKAwPOUqEX1K/nb1vNem+E7QZY9u7gdudwPQppIl6?=
 =?us-ascii?Q?IqbcWWotMKXFdciyaZT6ze0ZWSCTKbUhTjzbvxf8gmhsNjfzKWO1Cf0+aMte?=
 =?us-ascii?Q?6Hjjb1lJPO8eUFWDEpwDrZrmb/0Jt6Ql6LegClsO2rLynEhko7ijBLAGKvK4?=
 =?us-ascii?Q?v9KYXkEHImpNIoECmyv+O1xrEqtlmrxSiRnMBOCTDNd1FTVqhq86/WrMtaL2?=
 =?us-ascii?Q?ch5KxIMsEmbsSuZg4ERf1E2uWHmPyGcp8VDR5Qbxvp5c0eBo5IWfP/9V1SRx?=
 =?us-ascii?Q?GgDG2tguraMnv8ocTf0LaZCvc6Kj/A8Jx5SKoOd4Cs6UZ97PU29+6V2VRHKM?=
 =?us-ascii?Q?7169Bg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jUWUjPBn1jN1shmaMNdg+/bfSumtJHix2F/BdHRs+Vmh1R/HKItMbu/7rdm1ihYK0fyfqvnQ3/ZWp5dR9JrnOT0+nfop3yVkMc/GbQ8ijswDE5zpg0mRu1OivYaB66tijk1uvg6z4yCTwj8fXF2g2PHE+9yerGXoRXd1OAi74PBtoM7cTIzMZMMiG6ZGdu1ZSn7s1rLwnA8nWa9TE3wPzxygi3PNWPEAqIeFXaq3nrvkn8sanU+HM4EWElEhbdPHGa00nEt5sRllhaXFDFfbKeb/5wnJMPifOc09E9G6FX4W3pvUKSdBAyqxWOMBWm4+CsTtk8iOqPZTHRvpFKldO4rjnBS/YGXYlj9gha/Ixn453/NPsrZkPNF2DWk4wvYeprptGxrovJkTLfYiChJGYCbUveX+b+uUVxY+us85FR5hdNy0l/WYKkVpswH/vzLT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 17:07:45.3908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a7e2e3-b399-407c-7553-08de67fdbe98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

The mes and mes_kiq parameters we originally added for
mes bring up.  However, mes is required for operation
on gfx11 and newer so these parameters aren't actually
used by the driver anymore. Remove them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f5d15110e43b..0f6e9cdbe7d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -217,9 +217,7 @@ extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
-extern int amdgpu_mes;
 extern int amdgpu_mes_log_enable;
-extern int amdgpu_mes_kiq;
 extern int amdgpu_uni_mes;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5e04b5c0cb70e..3a6a482983383 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -223,9 +223,7 @@ uint amdgpu_dc_visual_confirm;
 int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp = -1;
 int amdgpu_discovery = -1;
-int amdgpu_mes;
 int amdgpu_mes_log_enable = 0;
-int amdgpu_mes_kiq;
 int amdgpu_uni_mes = 1;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
@@ -690,15 +688,6 @@ MODULE_PARM_DESC(discovery,
 	"Allow driver to discover hardware IPs from IP Discovery table at the top of VRAM");
 module_param_named(discovery, amdgpu_discovery, int, 0444);
 
-/**
- * DOC: mes (int)
- * Enable Micro Engine Scheduler. This is a new hw scheduling engine for gfx, sdma, and compute.
- * (0 = disabled (default), 1 = enabled)
- */
-MODULE_PARM_DESC(mes,
-	"Enable Micro Engine Scheduler (0 = disabled (default), 1 = enabled)");
-module_param_named(mes, amdgpu_mes, int, 0444);
-
 /**
  * DOC: mes_log_enable (int)
  * Enable Micro Engine Scheduler log. This is used to enable/disable MES internal log.
@@ -708,15 +697,6 @@ MODULE_PARM_DESC(mes_log_enable,
 	"Enable Micro Engine Scheduler log (0 = disabled (default), 1 = enabled)");
 module_param_named(mes_log_enable, amdgpu_mes_log_enable, int, 0444);
 
-/**
- * DOC: mes_kiq (int)
- * Enable Micro Engine Scheduler KIQ. This is a new engine pipe for kiq.
- * (0 = disabled (default), 1 = enabled)
- */
-MODULE_PARM_DESC(mes_kiq,
-	"Enable Micro Engine Scheduler KIQ (0 = disabled (default), 1 = enabled)");
-module_param_named(mes_kiq, amdgpu_mes_kiq, int, 0444);
-
 /**
  * DOC: uni_mes (int)
  * Enable Unified Micro Engine Scheduler. This is a new engine pipe for unified scheduler.
-- 
2.53.0

