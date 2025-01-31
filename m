Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF29C02190
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BABA10E3D6;
	Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v34RYX3A";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F70E10E3C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os2ZAAX12bq/WEcPNsuyad8NsOmCYLv+PBHtgDpDlyuHuEjk4z7bcmACMYbRD7QuLSsGfagRDXEbcA6LL9I0Iehm4QvrxPUS8y2w+hsEfRUVEiJj1nKU39/rMgVOZ5Pk/r8ibr1E+W09qdI8TlpNcAOaxz8JNAJthHwvgsF9NhO2uW68eNI+wik5d7VIMz7Rm0B2cM6dQcJGh5htOpIWDGpMwpC9UB0J7FqouKlZIf1wpetqWKFFa8vDKNDAC/zNrXri2VNah/pKnZejXlqBOtsJvfpXKaGMuWLwkBYBhmHs4JnuTLCvxoaNN6ZYujGahJ0oRoB9RIZpv4r0NmfvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvvMSQY164cLFvIz9ws7/kvt5szCy6I1pFBs7Z4B1eE=;
 b=gdVFjmCspNWuWO/zDByrxXPJ6HB3xeo/xqtZ6LMcavdv4blECbVdno4uO31ijzSQsrFZcCsxQNgwpirIS4xIiYTMYHWPRET3vOlGvoX2kWJ1FwFuxdXh3UZh/FNrUZV0jZ0WFsNmtZTmEqWZXp1df+7AWranLcpF9TYINmF5Nanme72yOpDY5TIk8jSUwC5Pa9zCAojfEi8KQRrVg6iwznEkSGJmh/4RtVeboEssZVqO0TR/vvLW6QT113+Z/sBDKFHVe41rlhXG+VVW29o7q5LPpohPVH4XmRFzbKpnTqh3mnjxaolkhbqnLwTYdHjJQ1tj9KDJdLXw94YXpz882w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvvMSQY164cLFvIz9ws7/kvt5szCy6I1pFBs7Z4B1eE=;
 b=v34RYX3AWR0RpWcMWF5DSBhFHaQnTl/cWvHpPqf2uaCNc2Rwej2jknwHK0Ht4IMdhvGOrQxXLJTXHlmaEwiEaVWgSn9zEiYhzvgPX6XK49A/6P+em1Yk1qXOFS0mhXhOtWc6TnABBdeMEz46kTPNAdlZ20534gTsTR8zo2/Gqbo=
Received: from CH5P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::20)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Fri, 31 Jan
 2025 16:58:16 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::f5) by CH5P220CA0023.outlook.office365.com
 (2603:10b6:610:1ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/44] drm/amdgpu/vcn5.0.0: convert internal functions to use
 vcn_inst
Date: Fri, 31 Jan 2025 11:57:15 -0500
Message-ID: <20250131165741.1798488-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bead4f-29f0-4c2c-bef9-08dd421874bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aARgb8MJJrwnlB4GI6rtlG3Nzsh4ZKdfcGKjYW9QQrrzL/e5QrNtPYI6p4u2?=
 =?us-ascii?Q?il9Y00B4KypMVB7uK/7REd+UUP0QtzLYHYQHz7F6Ih7LMzgaJpmmHRVX402Y?=
 =?us-ascii?Q?Q8zpxke98YZgKHLvoRl8RYxP5qU21RLNbkY0EhWJ3RzIA5liExdl/L2eknQI?=
 =?us-ascii?Q?T5o9Cqgb0hllE3MgQaUPRhpSKIXcyxfqwTIqzaAAnZuve9upU3NFJ26f3DK5?=
 =?us-ascii?Q?AqkM5cfFMvrwX3nLTggx+KDYI/+Hxs81QRUOYuznRfjljRuoFjd71Nx8braB?=
 =?us-ascii?Q?MdbVjWeNfuqDPH5E5YrEYBdU+ETPebXGTtpr6SZE/5bzJoXAkQ82atuZ/yW2?=
 =?us-ascii?Q?qnK/8jxBnq1wDbn5KGXDgHPkEY66dxCcmnlED1aAcwHGRmQsIpfb+1iR1c6v?=
 =?us-ascii?Q?Q80wSgp2+eGsrRAmSfWuwwfaEcdXDPn9bqKwyS2Deaek/6sal6YmCSdqajPc?=
 =?us-ascii?Q?moeMkpFJWjTHgXHTWNKdPpW4q5NZDSj0lNHMUQX+fBapvHgEBAPpsFThFe3C?=
 =?us-ascii?Q?j6s64OomaJ4B9wo9HKAeFnpYiKFJCOZzsqXX5C7IJc02+wvGHlLIy0IhSkRn?=
 =?us-ascii?Q?QyVe/2j+naG99pG/V65VvtzNyNgbGWoUqEQGxwL7ECRORKcf+YYfvLBhVZVO?=
 =?us-ascii?Q?tduuWhFWtFVfpUAfoeTEXwz8/IwLHhtJ/0CZzbNqKYsN7osBBzME2/RS3Hb6?=
 =?us-ascii?Q?9ACG4ppfKCIhwu3OhmjMNwsEtPNdi5pLZ7NgdhhEzaBCbp638fC3rADKPitj?=
 =?us-ascii?Q?zm0C1OQslsAYAcpNoI1R6gvNQPZEw2764r5tUDW+d17tYWJprybLMesPxffD?=
 =?us-ascii?Q?VLaG/VOqXBYd6zBBDficIM5Q4t2uv7trr+knsg+27pfR55O3tvHDHW+l5KOS?=
 =?us-ascii?Q?IK/lO7INCRLcigrYC4flmkQ3F5Crt/4fA8zVTmpENtzrUaVIndXn8Ys0cICi?=
 =?us-ascii?Q?RT0zTLV/sW+K+YSW+pkGxGYAcEUpO2uCnlv0+rSkmwo0BKoqN8EikJg6kdiI?=
 =?us-ascii?Q?7aorN8bc8pkqNzE3Gv4EEc9piuHhrTmRRpVLkFAJpah+XECfSvXmMAB8bP/7?=
 =?us-ascii?Q?W9vGcPGVfk/TWr8vv822dtwkxxO/tWYXlP7z95PteDeAH6oiVqsijOHFoh5Y?=
 =?us-ascii?Q?CCyNEVssYAuTnQv7eTPRqtqmwyrPlMIeLB+5jcAB2MU6mKJP3+/nI/oCL8U3?=
 =?us-ascii?Q?SanFEJGuLNGIrhrAcVO6D3iOabVYN3+p3svYReNVqEvcUpTJCv8n6uwLlC14?=
 =?us-ascii?Q?QT7KkAwhdHTioO2wToo20ySOb1WngPtS3qk6dCV9eqZaXZfCqTQARWLpMcpz?=
 =?us-ascii?Q?HGTfUm4pz4HE6dahszLGyak5qSgx4goomsP961x4BeRVJFL6H/ZIzfCaoNpQ?=
 =?us-ascii?Q?DR16DWk/VXY6+rHcft1oEqLYKJUkSTki7cKsE08A9i3NbJXWayiy06gcJw4o?=
 =?us-ascii?Q?3dbvo6d7zcUBcDbXZpr3NLK8mJQMhBwplod/4xwN2AqrgU52DxDKmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:16.0650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bead4f-29f0-4c2c-bef9-08dd421874bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
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

Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev->vcn.inst[].

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 99 ++++++++++++++-----------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d3e4d02c12a06..a71960d899e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -367,13 +367,14 @@ static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v5_0_0_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -427,14 +428,16 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v5_0_0_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -537,13 +540,14 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 /**
  * vcn_v5_0_0_disable_static_power_gating - disable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable static power gating for VCN block
  */
-static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -604,13 +608,14 @@ static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev, i
 /**
  * vcn_v5_0_0_enable_static_power_gating - enable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable static power gating for VCN block
  */
-static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -650,12 +655,11 @@ static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev, in
 /**
  * vcn_v5_0_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 	return;
 }
@@ -664,15 +668,15 @@ static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_device *adev, int inst
 /**
  * vcn_v5_0_0_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  * @sram_sel: sram select
- * @inst_idx: instance number index
  * @indirect: indirectly write sram
  *
  * Disable clock gating for VCN block with dpg mode
  */
-static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
-	int inst_idx, uint8_t indirect)
+static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+						     uint8_t sram_sel,
+						     uint8_t indirect)
 {
 	return;
 }
@@ -681,12 +685,11 @@ static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v5_0_0_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 	return;
 }
@@ -694,14 +697,16 @@ static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v5_0_0_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -741,7 +746,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_LMI_CTRL), tmp, 0, indirect);
 
-	vcn_v5_0_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v5_0_0_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -793,13 +798,14 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 /**
  * vcn_v5_0_0_start - VCN start
  *
- * @adev: amdgpu_device pointer
- * @i: instance to start
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -814,10 +820,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v5_0_0_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v5_0_0_disable_static_power_gating(adev, i);
+	vcn_v5_0_0_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
@@ -848,7 +854,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
 		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
 
-	vcn_v5_0_0_mc_resume(adev, i);
+	vcn_v5_0_0_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
@@ -944,13 +950,14 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 /**
  * vcn_v5_0_0_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -974,13 +981,14 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v5_0_0_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
- * @i: instance to stop
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
@@ -992,7 +1000,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
 	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v5_0_0_stop_dpg_mode(adev, i);
+		vcn_v5_0_0_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1045,7 +1053,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
 
 	/* enable VCN power gating */
-	vcn_v5_0_0_enable_static_power_gating(adev, i);
+	vcn_v5_0_0_enable_static_power_gating(vinst);
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -1271,15 +1279,17 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v5_0_0_enable_clock_gating(adev, i);
+			vcn_v5_0_0_enable_clock_gating(vinst);
 		} else {
-			vcn_v5_0_0_disable_clock_gating(adev, i);
+			vcn_v5_0_0_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1291,15 +1301,16 @@ static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
 	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v5_0_0_stop(adev, i);
+		ret = vcn_v5_0_0_stop(vinst);
 	else
-		ret = vcn_v5_0_0_start(adev, i);
+		ret = vcn_v5_0_0_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.48.1

