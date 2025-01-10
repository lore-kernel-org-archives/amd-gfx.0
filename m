Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B63E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 16:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6550610E0A6;
	Fri, 10 Jan 2025 16:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FOs8CTAE";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04AC10E0A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 16:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cp3/DBMxb8iaA2DhewvT1ajAPnfNveu2vSt7Q/gJCjboPN1uh2xNCaqIZXgW9EKk1AcbJsfmoeeJvSR4Gujgpi7KQbNRCKWbV0OppBVnP0/Kh6cSFvqtwjjcS85J9Ub5Z/u1Q09kO9aXZ5Daul3tEHtNzy1JDkf5xA7TpnoHi0ZnVqtaJ7u/7WL00T16aOh+Mu4Rl721ANdivgtn6LkbY6NsShLGFzkOaEkFteIidEgFcrd7+RlTvUljKH+iD2NQWzEBRsbXiiIeBHSuQCeqhvJ/vvd2sEnToJ6nGsbfIlKk5F9Mjff4g7kBH6hfg8Do93PGsUb9WxhSp7MSHzudiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ECLlOkxykXQ6jiTmgMzszayqpEvE9qYt6+zpfT5yQ8=;
 b=cN6Jt5febPVwl4e3gOjEFAytSIRSBqO8XxG9GY4h8avgaK6iy630DQ9FWPEqPpapHkAvJHlEA5YlUzGoIkLTSux2Awy8xzKCcDoJ3v+dCkA+Lt81zKNHeTs0vcLKY1xH6Voum4bpjuVhJSc/8yRpKh6K/WF1/mrMFqdJSIjSedkvClBlsbwRZpdgkZE3dvGDDm/ScBDEBmpmKWqyljvhqZud2EOAtwgAVlEcl9qmonbadGnI1os92CILV7BPTSYRWvjlwbRiUdjN7sNvYnVAC9Tw2SxNi11Xi0mby/X7jx4R7s5MME1bqFG2rhuIZVzmPDaFcjHGTA419mP0qjchVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ECLlOkxykXQ6jiTmgMzszayqpEvE9qYt6+zpfT5yQ8=;
 b=FOs8CTAE3OJhhAev7gK/QOGPwLPAJfvZ2MukYnTFyEOXa2LtKYyJOBv/YXSGHEkPZR3moqpR7q5fJ8ycUZ1usuJcqs5QKsXI8L6j71AyLAD8tibGWun90JAkNcNpmQCMX3mW7dvxvhn0uSXT7EZQktGyigKHtaxZ75W8YP0oqx0=
Received: from BN9PR03CA0599.namprd03.prod.outlook.com (2603:10b6:408:10d::34)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 16:18:23 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::46) by BN9PR03CA0599.outlook.office365.com
 (2603:10b6:408:10d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 16:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 16:18:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 10:18:21 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <sathishkumar.sundararaju@amd.com>, <sonny.jiang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Check RRMT status for VCN v4.0.3
Date: Fri, 10 Jan 2025 21:47:59 +0530
Message-ID: <20250110161800.1326934-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110161800.1326934-1-lijo.lazar@amd.com>
References: <20250110161800.1326934-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ba782d-a4bb-40ff-7001-08dd319267f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZW/qWPReBeZJyl+qnXf0cf9ZjkP6qU3IvyODOtAe7BQ8CkTPOtPc9z97GcAV?=
 =?us-ascii?Q?8hgtQomT/wtBbIoWw1vnop61PylYeljZ3OqOOuBDx8MVTFjYWrnHyqIXQ2rN?=
 =?us-ascii?Q?9btkobvtESwdB/WMFKtk7PzyEHlt0hW7Sn0JzVRWdlLwFRkmc/jT/jMYbRtO?=
 =?us-ascii?Q?4LC61NfzQq3kPCEo03dI/6NXwUW1d5H3D9lylmGJxZeDhaT/7OCW9/tTimWN?=
 =?us-ascii?Q?+5ZM+UMp1RxPGRZdcdS7bNFV/L1e9E6YYCG+8XkojNGiZv2OLECAz+F9Geaa?=
 =?us-ascii?Q?rRn20+5FvuJjsumoqFLIoYRqI2PADawQMKfblVRoR2COdmIMcDhx18GQEVam?=
 =?us-ascii?Q?HG8aK3PMtyJuTv4KCN/dPa+nRyvwMq4bp9PEjmCn7+18UINMV46ArK6g94ks?=
 =?us-ascii?Q?E7VjsDLWETRuxU88cD/ceo4IUszM7GDfkhqbvRcI6z8VxChjSb3A3Ciq8vhC?=
 =?us-ascii?Q?mO9zoB4ilGebYypEM3KiV9Krrf7kAEhmmk/uDWz2NZpdRf6j16pUnFtOY8FJ?=
 =?us-ascii?Q?8ji1PmnlqTMAbW94GacW2dH/sXt7YMAb6oIjT+SMsnUbTbpwIkk3Kxb92iAT?=
 =?us-ascii?Q?79FAbXNMu9anBCdJOj8M9pCegRH39GoXrH+pJnP/APc+WUq3ZcEnczp/7PcZ?=
 =?us-ascii?Q?PXmemwYyZSerg9JsZIJrOnQxG1vLIYRa0NW3YOqWy/vwNHFvJDYqxZwkd4YZ?=
 =?us-ascii?Q?MIhAJYcmd5FqrLB5UFJVxdepp85oe23WVjkryaR8TnPL/xrILQIUsILEeDc5?=
 =?us-ascii?Q?qyJKXaRNDaX8cwkPm+/cF4vtQxldSVLa3on6X8Nzh7yGZOKXugjJNyJ9t1Vl?=
 =?us-ascii?Q?IZU8bn9gXHXzfQ192bv2c8yOt7cim7Ia/CIzuKAXl+VVhc1Dl/RFdHSvC8yz?=
 =?us-ascii?Q?7shObe+uRgYUwwZPFcWDSz+hTVR2nAcfuZfaNVBMYVhse48PmgSsMGhwPRHp?=
 =?us-ascii?Q?rM45eIdFryYz9rQ54DO2bBwuOp52eefJv2yhlRiGlaJNLxDvtWVs1KHp+awi?=
 =?us-ascii?Q?r3L+HfoaZ8T4BHja/4IeynZDwNQ+eqxZku+RUdiPSdMSHaFhrj2XEhGkyUA2?=
 =?us-ascii?Q?jIN3g4QvLIvSkn21xTd/90EpyOK1JbcSTYvQmrignwG3XA+Md+pdj+VMFz9q?=
 =?us-ascii?Q?7Sj577pwI8yVkhr1TJZQjd/mviLaIGPs9GYWT0c2e57FUDSfZVqr5137v8d2?=
 =?us-ascii?Q?wyVYNevjm3VAXuvRsoqoTwFc1O+piefZChk85Kvll67XH0dlp/NgZpeKTDOk?=
 =?us-ascii?Q?zdwhPSACx7NodA9IMWIA17wdZ5z9XQcLJRQqR4y/bXSdMJ0Jt3mzp2aMX/7f?=
 =?us-ascii?Q?b1tboei63fcHLEAMG2hAODA0BhXFZfMK7snQY7AZD2EEtQJ8YKCOVdxTMaIM?=
 =?us-ascii?Q?o1aSlZqi999ZCWUM/LinF7sr+638Azy4AThhN4VmfKk/9N9JZFHz2YAt0RoO?=
 =?us-ascii?Q?x3UOr8ROTITtv5JJwaUR/8fyaCNIs1NZP4EPSiW5ZEsIQJICHXtRPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:18:23.4846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ba782d-a4bb-40ff-7001-08dd319267f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263
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

RRMT could get dynamically enabled/disabled by PSP firmware. Read the
status from register for reading RRMT status. For VFs, this is not
accessible, hence assume that it's always disabled for now.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index adaf4388ad28..c92f683ee595 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -238,6 +238,12 @@
 
 #define AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSHAKING 2
 
+enum amdgpu_vcn_caps {
+	AMDGPU_VCN_RRMT_ENABLED,
+};
+
+#define AMDGPU_VCN_CAPS(caps) BIT(AMDGPU_VCN_##caps)
+
 enum fw_queue_mode {
 	FW_QUEUE_RING_RESET = 1,
 	FW_QUEUE_DPG_HOLD_OFF = 2,
@@ -345,6 +351,7 @@ struct amdgpu_vcn {
 	uint32_t		*ip_dump;
 
 	uint32_t		supported_reset;
+	uint32_t		caps;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ecdc027f8220..f0716c10f23e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -98,8 +98,7 @@ static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
 
 static inline bool vcn_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 {
-	return (amdgpu_sriov_vf(adev) ||
-		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)));
+	return (adev->vcn.caps & AMDGPU_VCN_CAPS(RRMT_ENABLED)) == 0;
 }
 
 /**
@@ -295,6 +294,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 			ring->sched.ready = true;
 		}
 	} else {
+		/* This flag is not set for VF, assumed to be disabled always */
+		if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) &
+		    0x100)
+			adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
+
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 			struct amdgpu_vcn4_fw_shared *fw_shared;
 
-- 
2.25.1

