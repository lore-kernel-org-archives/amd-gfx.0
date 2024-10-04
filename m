Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1CCCF8852
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 15:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD06C10EA3D;
	Fri,  4 Oct 2024 15:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="phfwWypX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE9410EA3D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 15:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdwjx9dw6UzPmGo/D+Py2DNfVN4EV19NvHzuKWtrDxr9xWqyPp/r1n9dC8cO65zi7Z1rTkh/JV3iy2JUS5llkr/1MeA8Qw8VEnYyvp2NFwoFI8vL4CHg7xWwwEku8WHr+++BWKbi3byAuA9L2mzZZMalNZmmwj3mCw+QV3N8CAI6WvgKUCwtL6EgvdjsqBJqZPpqL/ldu2BMvkdx9F//pc2DLyXayrPBSl1bjuSoXHStzu4vlLArZZvrqhb1jSCSzMTM3LOVKVvS5VKhRfFmaek9zeemPiTw9dhPCtB5gl0P72X8mShCTwCjzN1ih/Vj3rKZ3xIjha4gI3K61r4i4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNPDkZYpKFpFxe9aFS1F3kLIhfMkXtGSyntqwH3C+Og=;
 b=Gt0byDc/KwLCEWHMzBwgNSpKsAiOoCojz72tQqel01rPqplfKChy5YBLQT2AmvZD8nF9q+BzsWeN6/GvVu4MNN1G9x7q1v24+3Zg5ZYnmmbG0nIRRlT+q8Sf2YX9Ir7W7iNHRFSelsq+BDrvK6JzKL//KNGWVD9RzTLFs/AU8Oa+KseNxRdV7/wObKafpD1YDJq08Ja3Lw9kVy4fW0gwSLfs5EIW0Qne/IA1/A7ZU7S1REpRvRubgoFI49+S0wUE4+oAvOXL28UZAMvmLF+5A7lX6m4wWbclPl9EFjH3LXtyRx0aG0V69vddhZMIO8gLXHUdqk/N6ke86aLxMvYklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNPDkZYpKFpFxe9aFS1F3kLIhfMkXtGSyntqwH3C+Og=;
 b=phfwWypXqbaTXjJwHuvNfKFwNo+lZA+7fiMM+WuRESzMth13WUBtNQM7OdRts5/3TlEl/ps+KvjZD9HJOnSPi2hs1SbjVt0T13iiEVcUhYFA4HVbNu7NSo5YQ1qOhjIey9MS48j2ndcBFhqSAeMkeYd0kCszzVesLvyr/WMVfZc=
Received: from CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::18)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:57:54 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::54) by CH5P223CA0007.outlook.office365.com
 (2603:10b6:610:1f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 15:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Fri, 4 Oct 2024 15:57:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 10:57:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/swsmu: add automatic parameter to
 set_soft_freq_range
Date: Fri, 4 Oct 2024 11:57:38 -0400
Message-ID: <20241004155738.488919-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004155738.488919-1-alexander.deucher@amd.com>
References: <20241004155738.488919-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 1704b8bc-0625-4985-3b77-08dce48d4f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WvnosZps6NSodH3RP22YLR/0D30g2t1tnS/AGh9WyMi9J0Wx+HSHdDpMc/WL?=
 =?us-ascii?Q?hGS55WPSgnkmHIa890BKo08llxLdm49Zl510NJTnRz5gsFaO4KPMpr3kxpu0?=
 =?us-ascii?Q?J6vBKDwTUIgw6dZo6QRi/bjg58WK/+7Q9UfzURnAjWF1NipJQi1ZrFsekw92?=
 =?us-ascii?Q?Jt9q8K+1mivmeZD1Jh/dbjxSLbbM667s8yLbW7RwrQSzvz8Vqyvvn/edoENZ?=
 =?us-ascii?Q?g9pnzdnY4YW8GjXdCnqb2YIB5Yr/e7iIFk1iGRmpp1Og3uoM2RDDQJJpycxC?=
 =?us-ascii?Q?i/GykNTQ45mgELcccmk4i+vRtrDeL6ifi+U+520997RcHm9WHAz+SvbU9zXv?=
 =?us-ascii?Q?BxZ73eadb6XAP0PJaPOeWr6QI5JI5xHui3wLiG5QpiAGzcde1pf5EWLIb2Dm?=
 =?us-ascii?Q?r0C4+S8Lu+UBq1t49I72JmS54nuKTmvoAjYB+3dTDFmTSgOPrfrwVhUctSAz?=
 =?us-ascii?Q?PBNwsOOvXf6/vm/sWuuZqjVITZxJyjLCmZN+v0aEGcEoRfvPE+QkusXufzA/?=
 =?us-ascii?Q?PJW5TYKdPHG1APUZxTw7UwCxpJG1s8VMsWNtHCkGrq7N1SX6y++Zl8cr3Zq9?=
 =?us-ascii?Q?Guoy+qgqnPh7ideBomfmVV+q+VzA8u1uphYtrx5RtVejBRHLEZmvJ3K6aasc?=
 =?us-ascii?Q?inr950yZEwvz+rONytH94yijthhqgkCpfStWNSEKQ37YiqJ4A3rq4NNgbyB4?=
 =?us-ascii?Q?JunHiFWkM8OBk/jd0hrgFNHsdmUBajqp90jZPromGhVzjBeMhLX7jr9JImKt?=
 =?us-ascii?Q?iOeBzUBOKnja615bKZyBRcsDEVHVAlI8J0gUlHp8xfWFVY0v9lpGHVwea299?=
 =?us-ascii?Q?JKpw5dEOe8QzLi2rl8J47qEeBhBTukV2yC7WRi2A+oPx5u19GlBE1gbpKTrz?=
 =?us-ascii?Q?K7ed2BRvSD3oYXifqNPaw2KbdyQ9By8wjUm/DPM0r/FEkBqPxH9TsAoTQY/E?=
 =?us-ascii?Q?gYFyJ0fwbFlkh/TPuUIeJBZK6Zd+9sRsfoA66yVQf4ZC7+1Qmpq6+Sq0y4PM?=
 =?us-ascii?Q?ugcGLGpEuIpE5e5865/X+CMBU4N8JgkI4wZSzk/I28W11cZ578ec1ZE79tfr?=
 =?us-ascii?Q?m0d6QVfvScS+8U9IRd4a47/kNY3top6kdyvfH8rfL6Z8uFHgvaCfr4P12B6u?=
 =?us-ascii?Q?8jRgsdDoVlYSsUNY9X4ALLLhz8cWy3B/Lmtmi3a/d2+i8Pb3/FHy6WHAK672?=
 =?us-ascii?Q?xTk/vMsPC7VcBiGreTA+0il2Tqhe3910rS6DV67j8hwup9BLf492HbOeZg1K?=
 =?us-ascii?Q?iMylhc/2DhqE6AnMVc/HBDeIIP2O0c9WYZfEtxqVxoq1vR2uloE/lTShYHuW?=
 =?us-ascii?Q?4UImByB+prLahgTuDN11TvxVdi76z0VS2wSlIsKU01X+VDqQ6Ej0exINHBgI?=
 =?us-ascii?Q?npNQ8WE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:57:54.6488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1704b8bc-0625-4985-3b77-08dce48d4f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
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

On chips that support it, you can specificy 0 and 0xffff for
min and max and the PMFW will use that to determine the optimal
min and max.  This enables optimal performance when the
user manually switches between performance levels using sysfs.
Previously we'd set soft min/max which could limit performance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 25 +++++++++----
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 +++++-----
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 14 ++++----
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  2 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 ++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 34 +++++++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  3 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 22 +++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 ++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  3 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 36 +++++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 33 ++++++++++++-----
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  3 +-
 21 files changed, 152 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ceaeb0152a5d..accc96a03bd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -140,7 +140,8 @@ int smu_set_soft_freq_range(struct smu_context *smu,
 		ret = smu->ppt_funcs->set_soft_freq_limited_range(smu,
 								  clk_type,
 								  min,
-								  max);
+								  max,
+								  false);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 727da0c37e06..8bb32b3f0d9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1255,7 +1255,8 @@ struct pptable_funcs {
 	 * @set_soft_freq_limited_range: Set the soft frequency range of a clock
 	 *                               domain in MHz.
 	 */
-	int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max);
+	int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max,
+					   bool automatic);
 
 	/**
 	 * @set_power_source: Notify the SMU of the current power source.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index c2ab336bb530..ed8304d82831 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -255,7 +255,7 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 						 uint32_t *min, uint32_t *max);
 
 int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max);
+					  uint32_t min, uint32_t max, bool automatic);
 
 int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
 					  enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
index 1ad2dff71090..0886d8cffbd0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
@@ -56,7 +56,7 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *smu);
 int smu_v12_0_mode2_reset(struct smu_context *smu);
 
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max);
+					  uint32_t min, uint32_t max, bool automatic);
 
 int smu_v12_0_set_driver_table_location(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index e58220a7ee2f..044d6893b43e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -219,7 +219,7 @@ int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 				    uint32_t *min, uint32_t *max);
 
 int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
-					  uint32_t min, uint32_t max);
+					  uint32_t min, uint32_t max, bool automatic);
 
 int smu_v13_0_set_hard_freq_limited_range(struct smu_context *smu,
 					  enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 46b456590a08..6cada19a8482 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -186,7 +186,7 @@ int smu_v14_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 				    uint32_t *min, uint32_t *max);
 
 int smu_v14_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
-					  uint32_t min, uint32_t max);
+					  uint32_t min, uint32_t max, bool automatic);
 
 int smu_v14_0_set_hard_freq_limited_range(struct smu_context *smu,
 					  enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 16af1a329621..9fa305ba6422 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1689,7 +1689,7 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			return 0;
 
-		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
 			return 0;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3b29cb74c47b..77e58eb46328 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1469,7 +1469,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto forec_level_out;
 
-		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
 			goto forec_level_out;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 8981302b19c8..480cf3cb204d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1764,7 +1764,8 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 					  enum smu_clk_type clk_type,
 					  uint32_t min,
-					  uint32_t max)
+					  uint32_t max,
+					  bool automatic)
 {
 	int ret = 0, clk_id = 0;
 	uint32_t param;
@@ -1779,7 +1780,10 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 		return clk_id;
 
 	if (max > 0) {
-		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
+		if (automatic)
+			param = (uint32_t)((clk_id << 16) | 0xffff);
+		else
+			param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
 						  param, NULL);
 		if (ret)
@@ -1787,7 +1791,10 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 	if (min > 0) {
-		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
+		if (automatic)
+			param = (uint32_t)((clk_id << 16) | 0);
+		else
+			param = (uint32_t)((clk_id << 16) | (min & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
 						  param, NULL);
 		if (ret)
@@ -1855,6 +1862,7 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 	uint32_t mclk_min = 0, mclk_max = 0;
 	uint32_t socclk_min = 0, socclk_max = 0;
 	int ret = 0;
+	bool auto_level = false;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1874,6 +1882,7 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 		mclk_max = mem_table->max;
 		socclk_min = soc_table->min;
 		socclk_max = soc_table->max;
+		auto_level = true;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 		sclk_min = sclk_max = pstate_table->gfxclk_pstate.standard;
@@ -1906,13 +1915,15 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 2)) {
 		mclk_min = mclk_max = 0;
 		socclk_min = socclk_max = 0;
+		auto_level = false;
 	}
 
 	if (sclk_min && sclk_max) {
 		ret = smu_v11_0_set_soft_freq_limited_range(smu,
 							    SMU_GFXCLK,
 							    sclk_min,
-							    sclk_max);
+							    sclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 	}
@@ -1921,7 +1932,8 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 		ret = smu_v11_0_set_soft_freq_limited_range(smu,
 							    SMU_MCLK,
 							    mclk_min,
-							    mclk_max);
+							    mclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 	}
@@ -1930,7 +1942,8 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 		ret = smu_v11_0_set_soft_freq_limited_range(smu,
 							    SMU_SOCCLK,
 							    socclk_min,
-							    socclk_max);
+							    socclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 22737b11b1bf..a333ab827f48 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1091,9 +1091,10 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 }
 
 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
-					  enum smu_clk_type clk_type,
-					  uint32_t min,
-					  uint32_t max)
+					       enum smu_clk_type clk_type,
+					       uint32_t min,
+					       uint32_t max,
+					       bool automatic)
 {
 	int ret = 0;
 
@@ -1299,7 +1300,7 @@ static int vangogh_force_dpm_limit_value(struct smu_context *smu, bool highest)
 			return ret;
 
 		force_freq = highest ? max_freq : min_freq;
-		ret = vangogh_set_soft_freq_limited_range(smu, clk_type, force_freq, force_freq);
+		ret = vangogh_set_soft_freq_limited_range(smu, clk_type, force_freq, force_freq, false);
 		if (ret)
 			return ret;
 	}
@@ -1335,7 +1336,7 @@ static int vangogh_unforce_dpm_levels(struct smu_context *smu)
 		if (ret)
 			return ret;
 
-		ret = vangogh_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		ret = vangogh_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
 
 		if (ret)
 			return ret;
@@ -1354,7 +1355,7 @@ static int vangogh_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = vangogh_set_soft_freq_limited_range(smu, SMU_FCLK, fclk_freq, fclk_freq);
+	ret = vangogh_set_soft_freq_limited_range(smu, SMU_FCLK, fclk_freq, fclk_freq, false);
 	if (ret)
 		return ret;
 
@@ -1362,7 +1363,7 @@ static int vangogh_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = vangogh_set_soft_freq_limited_range(smu, SMU_SOCCLK, socclk_freq, socclk_freq);
+	ret = vangogh_set_soft_freq_limited_range(smu, SMU_SOCCLK, socclk_freq, socclk_freq, false);
 	if (ret)
 		return ret;
 
@@ -1370,7 +1371,7 @@ static int vangogh_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = vangogh_set_soft_freq_limited_range(smu, SMU_VCLK, vclk_freq, vclk_freq);
+	ret = vangogh_set_soft_freq_limited_range(smu, SMU_VCLK, vclk_freq, vclk_freq, false);
 	if (ret)
 		return ret;
 
@@ -1378,7 +1379,7 @@ static int vangogh_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = vangogh_set_soft_freq_limited_range(smu, SMU_DCLK, dclk_freq, dclk_freq);
+	ret = vangogh_set_soft_freq_limited_range(smu, SMU_DCLK, dclk_freq, dclk_freq, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index cc0504b063fa..0b210b1f2628 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -707,7 +707,7 @@ static int renoir_force_dpm_limit_value(struct smu_context *smu, bool highest)
 			return ret;
 
 		force_freq = highest ? max_freq : min_freq;
-		ret = smu_v12_0_set_soft_freq_limited_range(smu, clk_type, force_freq, force_freq);
+		ret = smu_v12_0_set_soft_freq_limited_range(smu, clk_type, force_freq, force_freq, false);
 		if (ret)
 			return ret;
 	}
@@ -740,7 +740,7 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 		if (ret)
 			return ret;
 
-		ret = smu_v12_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		ret = smu_v12_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
 			return ret;
 	}
@@ -911,7 +911,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
+	ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_freq, sclk_freq, false);
 	if (ret)
 		return ret;
 
@@ -919,7 +919,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
+	ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
 	if (ret)
 		return ret;
 
@@ -961,13 +961,13 @@ static int renior_set_dpm_profile_freq(struct smu_context *smu,
 	}
 
 	if (sclk)
-		ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk, sclk);
+		ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk, sclk, false);
 
 	if (socclk)
-		ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_SOCCLK, socclk, socclk);
+		ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_SOCCLK, socclk, socclk, false);
 
 	if (fclk)
-		ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_FCLK, fclk, fclk);
+		ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_FCLK, fclk, fclk, false);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index ed15f5a0fd11..3d3cd546f0ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -211,7 +211,7 @@ int smu_v12_0_mode2_reset(struct smu_context *smu)
 }
 
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max)
+					  uint32_t min, uint32_t max, bool automatic)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2c35eb31475a..f6b029354327 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1297,9 +1297,10 @@ static int aldebaran_set_performance_level(struct smu_context *smu,
 }
 
 static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
-					  enum smu_clk_type clk_type,
-					  uint32_t min,
-					  uint32_t max)
+						 enum smu_clk_type clk_type,
+						 uint32_t min,
+						 uint32_t max,
+						 bool automatic)
 {
 	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
@@ -1328,7 +1329,7 @@ static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
 			return 0;
 
 		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK,
-							    min, max);
+							    min, max, false);
 		if (!ret) {
 			pstate_table->gfxclk_pstate.curr.min = min;
 			pstate_table->gfxclk_pstate.curr.max = max;
@@ -1348,7 +1349,7 @@ static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
 		/* Restore default min/max clocks and enable determinism */
 		min_clk = dpm_context->dpm_tables.gfx_table.min;
 		max_clk = dpm_context->dpm_tables.gfx_table.max;
-		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);
+		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk, false);
 		if (!ret) {
 			usleep_range(500, 1000);
 			ret = smu_cmn_send_smc_msg_with_param(smu,
@@ -1422,7 +1423,7 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 			min_clk = dpm_context->dpm_tables.gfx_table.min;
 			max_clk = dpm_context->dpm_tables.gfx_table.max;
 
-			return aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);
+			return aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk, false);
 		}
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
@@ -1441,7 +1442,7 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 			min_clk = pstate_table->gfxclk_pstate.custom.min;
 			max_clk = pstate_table->gfxclk_pstate.custom.max;
 
-			return aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);
+			return aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk, false);
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e17466cc1952..6cfd66363915 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1608,7 +1608,8 @@ int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 					  enum smu_clk_type clk_type,
 					  uint32_t min,
-					  uint32_t max)
+					  uint32_t max,
+					  bool automatic)
 {
 	int ret = 0, clk_id = 0;
 	uint32_t param;
@@ -1623,7 +1624,10 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 		return clk_id;
 
 	if (max > 0) {
-		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
+		if (automatic)
+			param = (uint32_t)((clk_id << 16) | 0xffff);
+		else
+			param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
 						      param, NULL);
 		if (ret)
@@ -1631,7 +1635,10 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 	if (min > 0) {
-		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
+		if (automatic)
+			param = (uint32_t)((clk_id << 16) | 0);
+		else
+			param = (uint32_t)((clk_id << 16) | (min & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
 						      param, NULL);
 		if (ret)
@@ -1708,6 +1715,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 	uint32_t dclk_min = 0, dclk_max = 0;
 	uint32_t fclk_min = 0, fclk_max = 0;
 	int ret = 0, i;
+	bool auto_level = false;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1739,6 +1747,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 		dclk_max = dclk_table->max;
 		fclk_min = fclk_table->min;
 		fclk_max = fclk_table->max;
+		auto_level = true;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 		sclk_min = sclk_max = pstate_table->gfxclk_pstate.standard;
@@ -1780,13 +1789,15 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 		vclk_min = vclk_max = 0;
 		dclk_min = dclk_max = 0;
 		fclk_min = fclk_max = 0;
+		auto_level = false;
 	}
 
 	if (sclk_min && sclk_max) {
 		ret = smu_v13_0_set_soft_freq_limited_range(smu,
 							    SMU_GFXCLK,
 							    sclk_min,
-							    sclk_max);
+							    sclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 
@@ -1798,7 +1809,8 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 		ret = smu_v13_0_set_soft_freq_limited_range(smu,
 							    SMU_MCLK,
 							    mclk_min,
-							    mclk_max);
+							    mclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 
@@ -1810,7 +1822,8 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 		ret = smu_v13_0_set_soft_freq_limited_range(smu,
 							    SMU_SOCCLK,
 							    socclk_min,
-							    socclk_max);
+							    socclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 
@@ -1825,7 +1838,8 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 			ret = smu_v13_0_set_soft_freq_limited_range(smu,
 								    i ? SMU_VCLK1 : SMU_VCLK,
 								    vclk_min,
-								    vclk_max);
+								    vclk_max,
+								    auto_level);
 			if (ret)
 				return ret;
 		}
@@ -1840,7 +1854,8 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 			ret = smu_v13_0_set_soft_freq_limited_range(smu,
 								    i ? SMU_DCLK1 : SMU_DCLK,
 								    dclk_min,
-								    dclk_max);
+								    dclk_max,
+								    auto_level);
 			if (ret)
 				return ret;
 		}
@@ -1852,7 +1867,8 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 		ret = smu_v13_0_set_soft_freq_limited_range(smu,
 							    SMU_FCLK,
 							    fclk_min,
-							    fclk_max);
+							    fclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4e658abe3a20..3e2277abc754 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1962,7 +1962,8 @@ static int smu_v13_0_0_force_clk_levels(struct smu_context *smu,
 		ret = smu_v13_0_set_soft_freq_limited_range(smu,
 							    clk_type,
 							    min_freq,
-							    max_freq);
+							    max_freq,
+							    false);
 		break;
 	case SMU_DCEFCLK:
 	case SMU_PCIE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 9c2c43bfed0b..a71b7c0803f1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -811,9 +811,10 @@ static int smu_v13_0_5_get_dpm_ultimate_freq(struct smu_context *smu,
 }
 
 static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
-							enum smu_clk_type clk_type,
-							uint32_t min,
-							uint32_t max)
+						   enum smu_clk_type clk_type,
+						   uint32_t min,
+						   uint32_t max,
+						   bool automatic)
 {
 	enum smu_message_type msg_set_min, msg_set_max;
 	uint32_t min_clk = min;
@@ -950,7 +951,7 @@ static int smu_v13_0_5_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto force_level_out;
 
-		ret = smu_v13_0_5_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		ret = smu_v13_0_5_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
 			goto force_level_out;
 		break;
@@ -1046,9 +1047,10 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 
 	if (sclk_min && sclk_max) {
 		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
-							    SMU_SCLK,
-							    sclk_min,
-							    sclk_max);
+							      SMU_SCLK,
+							      sclk_min,
+							      sclk_max,
+							      false);
 		if (ret)
 			return ret;
 
@@ -1060,7 +1062,8 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
 							      SMU_VCLK,
 							      vclk_min,
-							      vclk_max);
+							      vclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
@@ -1069,7 +1072,8 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
 							      SMU_DCLK,
 							      dclk_min,
-							      dclk_max);
+							      dclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 52f3c537bb3f..ea9bfd026b4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1746,7 +1746,7 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 		if (uclk_table->max != pstate_table->uclk_pstate.curr.max) {
 			/* Min UCLK is not expected to be changed */
 			ret = smu_v13_0_set_soft_freq_limited_range(
-				smu, SMU_UCLK, 0, uclk_table->max);
+				smu, SMU_UCLK, 0, uclk_table->max, false);
 			if (ret)
 				return ret;
 			pstate_table->uclk_pstate.curr.max = uclk_table->max;
@@ -1765,7 +1765,8 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 
 static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 						   enum smu_clk_type clk_type,
-						   uint32_t min, uint32_t max)
+						   uint32_t min, uint32_t max,
+						   bool automatic)
 {
 	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
@@ -1813,7 +1814,7 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 				return -EOPNOTSUPP;
 			/* Only max clock limiting is allowed for UCLK */
 			ret = smu_v13_0_set_soft_freq_limited_range(
-				smu, SMU_UCLK, 0, max);
+				smu, SMU_UCLK, 0, max, false);
 			if (!ret)
 				pstate_table->uclk_pstate.curr.max = max;
 		}
@@ -1953,7 +1954,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			max_clk = dpm_context->dpm_tables.gfx_table.max;
 
 			ret = smu_v13_0_6_set_soft_freq_limited_range(
-				smu, SMU_GFXCLK, min_clk, max_clk);
+				smu, SMU_GFXCLK, min_clk, max_clk, false);
 
 			if (ret)
 				return ret;
@@ -1961,7 +1962,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			min_clk = dpm_context->dpm_tables.uclk_table.min;
 			max_clk = dpm_context->dpm_tables.uclk_table.max;
 			ret = smu_v13_0_6_set_soft_freq_limited_range(
-				smu, SMU_UCLK, min_clk, max_clk);
+				smu, SMU_UCLK, min_clk, max_clk, false);
 			if (ret)
 				return ret;
 			pstate_table->uclk_pstate.custom.max = 0;
@@ -1985,7 +1986,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			max_clk = pstate_table->gfxclk_pstate.custom.max;
 
 			ret = smu_v13_0_6_set_soft_freq_limited_range(
-				smu, SMU_GFXCLK, min_clk, max_clk);
+				smu, SMU_GFXCLK, min_clk, max_clk, false);
 
 			if (ret)
 				return ret;
@@ -1996,7 +1997,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			min_clk = pstate_table->uclk_pstate.curr.min;
 			max_clk = pstate_table->uclk_pstate.custom.max;
 			return smu_v13_0_6_set_soft_freq_limited_range(
-				smu, SMU_UCLK, min_clk, max_clk);
+				smu, SMU_UCLK, min_clk, max_clk, false);
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f7d7cae16d9b..23f13388455f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1951,7 +1951,8 @@ static int smu_v13_0_7_force_clk_levels(struct smu_context *smu,
 		ret = smu_v13_0_set_soft_freq_limited_range(smu,
 							    clk_type,
 							    min_freq,
-							    max_freq);
+							    max_freq,
+							    false);
 		break;
 	case SMU_DCEFCLK:
 	case SMU_PCIE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 260c339f89c5..71d58c8c8cc0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -945,9 +945,10 @@ static int yellow_carp_get_dpm_ultimate_freq(struct smu_context *smu,
 }
 
 static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
-							enum smu_clk_type clk_type,
-							uint32_t min,
-							uint32_t max)
+						   enum smu_clk_type clk_type,
+						   uint32_t min,
+						   uint32_t max,
+						   bool automatic)
 {
 	enum smu_message_type msg_set_min, msg_set_max;
 	uint32_t min_clk = min;
@@ -1134,7 +1135,7 @@ static int yellow_carp_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto force_level_out;
 
-		ret = yellow_carp_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		ret = yellow_carp_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
 			goto force_level_out;
 		break;
@@ -1254,9 +1255,10 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 
 	if (sclk_min && sclk_max) {
 		ret = yellow_carp_set_soft_freq_limited_range(smu,
-							    SMU_SCLK,
-							    sclk_min,
-							    sclk_max);
+							      SMU_SCLK,
+							      sclk_min,
+							      sclk_max,
+							      false);
 		if (ret)
 			return ret;
 
@@ -1266,18 +1268,20 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 
 	if (fclk_min && fclk_max) {
 		ret = yellow_carp_set_soft_freq_limited_range(smu,
-							    SMU_FCLK,
-							    fclk_min,
-							    fclk_max);
+							      SMU_FCLK,
+							      fclk_min,
+							      fclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
 
 	if (socclk_min && socclk_max) {
 		ret = yellow_carp_set_soft_freq_limited_range(smu,
-							    SMU_SOCCLK,
-							    socclk_min,
-							    socclk_max);
+							      SMU_SOCCLK,
+							      socclk_min,
+							      socclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
@@ -1286,7 +1290,8 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 		ret = yellow_carp_set_soft_freq_limited_range(smu,
 							      SMU_VCLK,
 							      vclk_min,
-							      vclk_max);
+							      vclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
@@ -1295,7 +1300,8 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 		ret = yellow_carp_set_soft_freq_limited_range(smu,
 							      SMU_DCLK,
 							      dclk_min,
-							      dclk_max);
+							      dclk_max,
+							      false);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 865e916fc425..f7745eaf118e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1102,7 +1102,8 @@ int smu_v14_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 int smu_v14_0_set_soft_freq_limited_range(struct smu_context *smu,
 					  enum smu_clk_type clk_type,
 					  uint32_t min,
-					  uint32_t max)
+					  uint32_t max,
+					  bool automatic)
 {
 	int ret = 0, clk_id = 0;
 	uint32_t param;
@@ -1117,7 +1118,10 @@ int smu_v14_0_set_soft_freq_limited_range(struct smu_context *smu,
 		return clk_id;
 
 	if (max > 0) {
-		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
+		if (automatic)
+			param = (uint32_t)((clk_id << 16) | 0xffff);
+		else
+			param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
 						      param, NULL);
 		if (ret)
@@ -1125,7 +1129,10 @@ int smu_v14_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 	if (min > 0) {
-		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
+		if (automatic)
+			param = (uint32_t)((clk_id << 16) | 0);
+		else
+			param = (uint32_t)((clk_id << 16) | (min & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
 						      param, NULL);
 		if (ret)
@@ -1202,6 +1209,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 	uint32_t dclk_min = 0, dclk_max = 0;
 	uint32_t fclk_min = 0, fclk_max = 0;
 	int ret = 0, i;
+	bool auto_level = false;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1233,6 +1241,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 		dclk_max = dclk_table->max;
 		fclk_min = fclk_table->min;
 		fclk_max = fclk_table->max;
+		auto_level = true;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 		sclk_min = sclk_max = pstate_table->gfxclk_pstate.standard;
@@ -1268,7 +1277,8 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_set_soft_freq_limited_range(smu,
 							    SMU_GFXCLK,
 							    sclk_min,
-							    sclk_max);
+							    sclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 
@@ -1280,7 +1290,8 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_set_soft_freq_limited_range(smu,
 							    SMU_MCLK,
 							    mclk_min,
-							    mclk_max);
+							    mclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 
@@ -1292,7 +1303,8 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_set_soft_freq_limited_range(smu,
 							    SMU_SOCCLK,
 							    socclk_min,
-							    socclk_max);
+							    socclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 
@@ -1307,7 +1319,8 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 			ret = smu_v14_0_set_soft_freq_limited_range(smu,
 								    i ? SMU_VCLK1 : SMU_VCLK,
 								    vclk_min,
-								    vclk_max);
+								    vclk_max,
+								    auto_level);
 			if (ret)
 				return ret;
 		}
@@ -1322,7 +1335,8 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 			ret = smu_v14_0_set_soft_freq_limited_range(smu,
 								    i ? SMU_DCLK1 : SMU_DCLK,
 								    dclk_min,
-								    dclk_max);
+								    dclk_max,
+								    auto_level);
 			if (ret)
 				return ret;
 		}
@@ -1334,7 +1348,8 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 		ret = smu_v14_0_set_soft_freq_limited_range(smu,
 							    SMU_FCLK,
 							    fclk_min,
-							    fclk_max);
+							    fclk_max,
+							    auto_level);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index ade3ee398e3d..27f4e0ce447d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1503,7 +1503,8 @@ static int smu_v14_0_2_force_clk_levels(struct smu_context *smu,
 		ret = smu_v14_0_set_soft_freq_limited_range(smu,
 							    clk_type,
 							    min_freq,
-							    max_freq);
+							    max_freq,
+							    false);
 		break;
 	case SMU_DCEFCLK:
 	case SMU_PCIE:
-- 
2.46.2

