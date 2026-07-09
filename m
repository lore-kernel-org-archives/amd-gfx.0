Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6C0C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 10:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D45110EABC;
	Thu,  9 Jul 2026 10:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FRQfoJZN";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D0010EABC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 10:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwEaC1jQY4AFO4smRnofOJYfVW+SV/r0TiDxglb688b0TiADutku0mtNza92fdLfed2YrAx9pUsixhpiFEWQywKRpcm2fAAKlzjS4CUDNYnjzbKkLWDrDDkhAEfWBwPF8ialyGxuDmztMWOsXluBDdairc94CWFmuZyVPkpXlSAoRvvfs/PeWwGlQFKptds5De3/D1kglwnm8pBNxM4vzHkdI7ZvTjJmSqaZk0uyHEqYjWAgbcEF2ODNt/AvT4vnAfzY7gIg6pOpSIku/7pw1ccUR9cFCPk8acGKJDcIK9f7tCQlMUV89IlCDLATq0ctAGuf3rNJvbB9X02l6/sodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ms3aNVBpuPzval376aTPogqSbgko37bCaI+aDqSl4A8=;
 b=qNc7FV7a/+GOZOzwIKQTh+b00SG6aIcKNWmNbMyP5tYADJ0kq2F4wAjzxaTnnD7XkTjUNZ9eWBKCrm+BjQJc7gqrv4S55Cbk6j/MfJxZ/61IgHyVy8cr1Fid2ha6Mcc4wuatsIqnSS7o85xHIa3LJF4VoXTYksWfNTgSMivQCZAVDjk5sLDy2DT8cic7/N/CLHIOhl36j0N/Zj1YtLgysKQd0I9dh7ViUiWIab2VIr8QuNkcJznw4FzdDqpS0jgEZoAbn9wneFJMnsi9EsqaD9YrcPc+RUf2zObR5sqazKuxAuUZCOKWAwZ3qKDB8hbL/E5WFDawZaXak3VTlJx/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ms3aNVBpuPzval376aTPogqSbgko37bCaI+aDqSl4A8=;
 b=FRQfoJZNa6qQxEsd0qZCrzEta/OBzYYK1Xz7QtEjFi8QNENIjig9VqKKB+Dp/muNchIgBttCzRaumFPhafr0XlNYdTyMhCyka2ONHosVQxQwj3U7NtybafrnSNVNkr8xzK6jVxMjqtW5gA0yZRAobC0k6yS39YSOGWLkpECYy30=
Received: from DM6PR04CA0012.namprd04.prod.outlook.com (2603:10b6:5:334::17)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 10:42:54 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::1d) by DM6PR04CA0012.outlook.office365.com
 (2603:10b6:5:334::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 10:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 10:42:53 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 05:42:50 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Update smu_v15_0_8 gpu metrics
Date: Thu, 9 Jul 2026 18:42:26 +0800
Message-ID: <20260709104226.1768300-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260709104226.1768300-1-asad.kamal@amd.com>
References: <20260709104226.1768300-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 3caf9333-1608-4d59-7afd-08dedda6d490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FBdJQymBRrIn0QtyqpuEmF2becU/83YlKwYwoGGJv2ySyMZLEbTaNgP58Nao3+BvK05SUihE4ISrs5tH5DmkmoV8zfD2zkfJMS4P8yB2Xu0yJDqsaaP7t4XtBe4krWww6bxGTc4c9ngZ77clg1rVc+stiAHI94s/OWymPfGh4upkwOn76br6pcor7Yb/q546yZK/awGCxZSOlGUnUldQJC5USxrifvInmRB2wCPt7E8l6L00rDyaYXTvUTJtc3+OdD1aQikaffSppZuOZ3kJNTBp/xp5+DNQePemSE2WgTD63DKXiZ+OiUpUYRqjDtE+Ir+OJaLZmB7QxyRhaUMlFYyBiK6THEWSrqh88lOCALnPJl8Pek9MwSpp56i0GsNAtW1GpUDD/eX10cTEEGa7N9W1VdKB+qHBV2IqXZjYeENEbc21RXtgtb8I/T96w5U8ufJFoAkujK/nq5Rc1/xtaHdMURpZntPA1vbVXacOGlISq2PEmCBP06Q4+YxBO1YfoeX9k1npV+nMECZXeWfo1RW3TeQvYzbC5dAUz5w3tgkboSGKJRqf2S/EpkKgzlIRzNF5jepmNiLl+QE/ew8ku9q6suUCvFfZ+QGitfbQSz1uNFZ9+fas+Vu5SG0hs/+GH3uP4pAH8egYMF0g5ZLbYP1uKQmdeAddCtfAEYJA62AqzOKgB9YvDSQCjWaNjgyJZUAUF6qo1nOFcWIetMNteQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2WO1XnWx5/GOZkQhuG6SdPE+thlg9C+s6ZiF2ycYiP0UOaI9ru0AQPE4kHcEcTkEvPtU+MFiNr7jLCcADPKas3e58lXG97hTgPb9q+sFAXu9gKPZWXFZXn5FNpzsKlbixjNdzg31IwubMipzmEl1w1V5YzwvR4kpcFpcocyhgr+jFtFXPZcakFCKbppmlIigxrlq78vWrts8gXaZXExft9YVfGYgHGRLC95nL9ACvdZXOWXt8RfiezHJDcYGgyKOMLkLrA0u8Qg2d88L6Wbwti9qUhGivo5P2VYlMiXpgGYVClMI9Z5e9XdlGiTv091aHMPIwtpQ3l+44XLIYSzJmBYKY23f3jf+3PLbIZUHPbAhpw5LFqq9mw9tDGl302/0hQ4i0kyTN6IFVcOVOo15En+kyBrrgeJpUdmwRoaoUHeKmzcSyZBUQNFkfr5dWD/V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:42:53.3006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3caf9333-1608-4d59-7afd-08dedda6d490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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

Update two classes of inconsistencies in the smu_v15_0_8 GPU metrics
definition relative to smu_v13_0_6:

Correct missing unit annotations for accumulated activity fields
that represent percentage-based utilization. These were incorrectly
marked as NONE instead of PERCENT

Widen pcie_bandwidth_inst from U32 to U64 to be consistent with
the smu_v13_0_6 definition.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index 4dfc40aaffcb..cebe1fba932b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -118,14 +118,14 @@ typedef struct {
 		   SMU_MTYPE(U16), xgmi_link_width);                           \
 	SMU_SCALAR(SMU_MATTR(XGMI_LINK_SPEED), SMU_MUNIT(SPEED_1),             \
 		   SMU_MTYPE(U16), xgmi_link_speed);                           \
-	SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(NONE),               \
+	SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(PERCENT),               \
 		   SMU_MTYPE(U64), gfx_activity_acc);                          \
-	SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(NONE),               \
+	SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(PERCENT),               \
 		   SMU_MTYPE(U64), mem_activity_acc);                          \
-	SMU_ARRAY(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(NONE),              \
+	SMU_ARRAY(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(PERCENT),              \
 		  SMU_MTYPE(U64), pcie_bandwidth_acc, SMU_15_0_8_MAX_MID);     \
 	SMU_ARRAY(SMU_MATTR(PCIE_BANDWIDTH_INST), SMU_MUNIT(BW_1),             \
-		  SMU_MTYPE(U32), pcie_bandwidth_inst, SMU_15_0_8_MAX_MID);    \
+		  SMU_MTYPE(U64), pcie_bandwidth_inst, SMU_15_0_8_MAX_MID);    \
 	SMU_SCALAR(SMU_MATTR(PCIE_L0_TO_RECOV_COUNT_ACC), SMU_MUNIT(NONE),     \
 		   SMU_MTYPE(U64), pcie_l0_to_recov_count_acc);                \
 	SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_COUNT_ACC), SMU_MUNIT(NONE),          \
@@ -164,7 +164,7 @@ typedef struct {
 		  jpeg_busy, SMU_15_0_8_MAX_JPEG);                             \
 	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
 		  vcn_busy, SMU_15_0_8_MAX_VCN);                               \
-	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(NONE), SMU_MTYPE(U64),    \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64),    \
 		  gfx_busy_acc, SMU_15_0_8_MAX_XCC);                           \
 	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
 		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
@@ -322,7 +322,7 @@ DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_baseboard_temp_metrics,
 		  jpeg_busy, SMU_15_0_8_MAX_JPEG);                             \
 	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U8),     \
 		  vcn_busy, SMU_15_0_8_MAX_VCN);                               \
-	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(NONE), SMU_MTYPE(U64),    \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64),    \
 		  gfx_busy_acc, SMU_15_0_8_MAX_XCC);                           \
 	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
 		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
-- 
2.46.0

