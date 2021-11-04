Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69714C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 00:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3A561051
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 00:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C3A561051
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45176F413;
	Thu,  4 Nov 2021 00:59:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D4F96F413
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 00:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0f/fJp4rulmHQMBgYf9v1iijJiHUZsLsYoN5LbCz0MYj4CS+j74i1VcwlwI+YGjY/FL+YEKwKVcBLq3VxZBb+SWeNeIExaSLRdYSE3naoEP2nnEb5F7oNfSJKVt8L9iPo3EPMFCS95MjzGFy1Pt1kz7UREUBIjc3qVPCytPVoZ0NFBH3xYm2wkAvjHkLRJKRV3ZRhRfeYTlc5lgiveLeRuRm9Ogm5Xzek7Es7tCPuX+LkuB32st9JMl9M2/9qBLIfbLRS9z8EVPtE6Q3txhLGRLYOi1f+ZL84dBAQGGf2IFO0YKnmKXaDq/xqWU1qwkjWsXBNF2q3QmDAghLAnK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGUGJQipDa9l2oUvAY+RfChYWTVQX39MnmgJdR8lm2o=;
 b=QoUBNqVoWk1RpbVru2qNSsFlM0tSB6amFoBeql4QdHGEzxksAFLzSnJsWU+9DSfO5MCtCDtvpixLa7N9muoZrEtxZ3ynZxhE7t81y5khdSGKGnO9B+1S/hIxuoAouNZ8rCIbsJg0rqy28eGT7lY6KdajM1MDjZQPmOd9uxXVZmcpjb/wXUScuS54GgAgJ/aqu0Li5XnarJExnMPfBduq2OX1DojR6G3xVG+BlKujY2v9LX9v0yf48vLwo8Qe6RpbNucTZKj63ZMds4Q0GNSTpYezJHARMnAWezz55qlFECdueBwWm0kYo4zxdV2j9NkXnC5bUynzQHjc7P3RpLEfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGUGJQipDa9l2oUvAY+RfChYWTVQX39MnmgJdR8lm2o=;
 b=pFF7eiunYIlvNpw90CWBGzY28p/lpEtwHdt5gnonUTdxvY6f5FbrhDKw0v2A53fYHQcqTx5KCqFj+reyMy8lLKEMz2ATviujJaEhOlFiTFDlW/YCXayhztg+Ay9g2Yua7iAWBuOi8jY7DU5uSjY07zYV1KRtfXWVIjWJ8cjGbm0=
Received: from CO2PR04CA0158.namprd04.prod.outlook.com (2603:10b6:104:4::12)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 00:59:07 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::a1) by CO2PR04CA0158.outlook.office365.com
 (2603:10b6:104:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 00:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 00:59:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 19:59:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: fix sysfs_emit/sysfs_emit_at handling
Date: Wed, 3 Nov 2021 20:58:52 -0400
Message-ID: <20211104005852.2454705-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fcc4454-a848-452a-fe59-08d99f2e4da0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4198:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4198EF7A65459ACD334CCB99F78D9@CH2PR12MB4198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUPyN1AXl6aB6+hRGUGWW/SOil15uHNl1T5vO/0Vbr3JOCU3uf9BZ7VtOye/ww5kWY+s4yvFYP6Yat/ebVqzAFsZdm4dt8N6PZYhIHkdTNaQOy2sQBSZAT00oxg7IEp98ZahyGo+12QTM6j700O9BljAsewAvGMW/Ydb4xk6DBEqhMMMRd43wpN3bzzpOaJJpI+WGv9mf/UFXa6kWwCcouUHJgwRWumZT+tVbSBNmkOOUqgj+aIbGA58hWz34bf6aLqhdxbijr1rlW1NLSzef8knAxN/PNfwUIEgrp7WfADvbZviY1bXCR4OXqjcsF8BNVzHKWvlVHIzZ5XhLZo2hMT2PQx8er0wYoQXPthY6UMJbSel9AWGs+du5Bvkp7D3O1aEVHVI3Xthz0viiEHOK9/k/EEoUjLAG2g5TKBVndHaoBNFzXKHmYsVOKYMnwlvvGEOC1z4wyaMzb9uveS3Kp8+dYfp00iG8whwAFiwE5GYwLGjGelj6kShrmf4cornjpkg/XROvmnY1Xic/fJlXc2qZjScelDopmyvXbivRbap/oqb6BeGYbiUq2BAnueiotuHbv69tnfcBCUGfvXDP4IREEiSxuTCsQRDKmjKl5brtS0GwVdpYcoOouhPAn4bqy8P/Asu2H2zsHsiUaqqkEPHll371IXTRWy3L3wzcDxdjzG0l+gbBDGSx2GcaRW4a3gesP/AISG9PW8m/TP/Vh+qCI1MhmxLTO4QoKRve6Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(83380400001)(82310400003)(186003)(54906003)(966005)(16526019)(2616005)(6916009)(70206006)(6666004)(86362001)(47076005)(336012)(426003)(4326008)(36860700001)(8676002)(30864003)(36756003)(70586007)(1076003)(356005)(316002)(508600001)(5660300002)(8936002)(7696005)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 00:59:06.7745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcc4454-a848-452a-fe59-08d99f2e4da0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>,
 Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sysfs_emit and sysfs_emit_at requrie a page boundary
aligned buf address. Make them happy!

v2: fix sysfs_emit -> sysfs_emit_at missed conversions

Cc: Lang Yu <lang.yu@amd.com>
Cc: Darren Powell <darren.powell@amd.com>
Fixes: 6db0c87a0a8e ("amdgpu/pm: Replace hwmgr smu usage of sprintf with sysfs_emit")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1774
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  8 ++++++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 10 +++++++---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |  2 ++
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h    | 13 +++++++++++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 12 +++++++++---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |  4 ++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  | 14 ++++++++++----
 7 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 1de3ae77e03e..258c573acc97 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1024,6 +1024,8 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 	uint32_t min_freq, max_freq = 0;
 	uint32_t ret = 0;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	switch (type) {
 	case PP_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
@@ -1065,7 +1067,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			if (ret)
 				return ret;
 
-			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(data->gfx_actual_soft_min_freq > 0) ? data->gfx_actual_soft_min_freq : min_freq);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -1081,7 +1083,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			if (ret)
 				return ret;
 
-			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
 				min_freq, max_freq);
 		}
@@ -1456,6 +1458,8 @@ static int smu10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	if (!buf)
 		return -EINVAL;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	size += sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[0],
 			title[1], title[2], title[3], title[4], title[5]);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index e7803ce8f67a..aceebf584225 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4914,6 +4914,8 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 	int size = 0;
 	uint32_t i, now, clock, pcie_speed;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	switch (type) {
 	case PP_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency, &clock);
@@ -4963,7 +4965,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
-			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 			for (i = 0; i < odn_sclk_table->num_of_pl; i++)
 				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
 					i, odn_sclk_table->entries[i].clock/100,
@@ -4972,7 +4974,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 	case OD_MCLK:
 		if (hwmgr->od_enabled) {
-			size = sysfs_emit(buf, "%s:\n", "OD_MCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
 			for (i = 0; i < odn_mclk_table->num_of_pl; i++)
 				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
 					i, odn_mclk_table->entries[i].clock/100,
@@ -4981,7 +4983,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 	case OD_RANGE:
 		if (hwmgr->od_enabled) {
-			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.sclk_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
@@ -5518,6 +5520,8 @@ static int smu7_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	if (!buf)
 		return -EINVAL;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	size += sysfs_emit_at(buf, size, "%s %16s %16s %16s %16s %16s %16s %16s\n",
 			title[0], title[1], title[2], title[3],
 			title[4], title[5], title[6], title[7]);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b94a77e4e714..8e28a8eecefc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1550,6 +1550,8 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
 	uint32_t i, now;
 	int size = 0;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	switch (type) {
 	case PP_SCLK:
 		now = PHM_GET_FIELD(cgs_read_ind_register(hwmgr->device,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
index ad33983a8064..2a75da1e9f03 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
@@ -109,6 +109,19 @@ int phm_irq_process(struct amdgpu_device *adev,
 			   struct amdgpu_irq_src *source,
 			   struct amdgpu_iv_entry *entry);
 
+/*
+ * Helper function to make sysfs_emit_at() happy. Align buf to
+ * the current page boundary and record the offset.
+ */
+static inline void phm_get_sysfs_buf(char **buf, int *offset)
+{
+	if (!*buf || !offset)
+		return;
+
+	*offset = offset_in_page(*buf);
+	*buf -= *offset;
+}
+
 int smu9_register_irq_handlers(struct pp_hwmgr *hwmgr);
 
 void *smu_atom_get_data_table(void *dev, uint32_t table, uint16_t *size,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index c152a61ddd2c..c981fc2882f0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -4548,6 +4548,8 @@ static int vega10_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
 	int ret = 0;
 	int size = 0;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	ret = vega10_get_enabled_smc_features(hwmgr, &features_enabled);
 	PP_ASSERT_WITH_CODE(!ret,
 			"[EnableAllSmuFeatures] Failed to get enabled smc features!",
@@ -4637,6 +4639,8 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	int i, now, size = 0, count = 0;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	switch (type) {
 	case PP_SCLK:
 		if (data->registry_data.sclk_dpm_key_disabled)
@@ -4717,7 +4721,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
-			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_sclk;
 			for (i = 0; i < podn_vdd_dep->count; i++)
 				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
@@ -4727,7 +4731,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 	case OD_MCLK:
 		if (hwmgr->od_enabled) {
-			size = sysfs_emit(buf, "%s:\n", "OD_MCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
 			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_mclk;
 			for (i = 0; i < podn_vdd_dep->count; i++)
 				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
@@ -4737,7 +4741,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 	case OD_RANGE:
 		if (hwmgr->od_enabled) {
-			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.gfx_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
@@ -5112,6 +5116,8 @@ static int vega10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	if (!buf)
 		return -EINVAL;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	size += sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[0],
 			title[1], title[2], title[3], title[4], title[5]);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 8558718e15a8..f7e783e1c888 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2141,6 +2141,8 @@ static int vega12_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
 	int ret = 0;
 	int size = 0;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	ret = vega12_get_enabled_smc_features(hwmgr, &features_enabled);
 	PP_ASSERT_WITH_CODE(!ret,
 		"[EnableAllSmuFeatures] Failed to get enabled smc features!",
@@ -2244,6 +2246,8 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 	int i, now, size = 0;
 	struct pp_clock_levels_with_latency clocks;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	switch (type) {
 	case PP_SCLK:
 		PP_ASSERT_WITH_CODE(
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 0cf39c1244b1..03e63be4ee27 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -3238,6 +3238,8 @@ static int vega20_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
 	int ret = 0;
 	int size = 0;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	ret = vega20_get_enabled_smc_features(hwmgr, &features_enabled);
 	PP_ASSERT_WITH_CODE(!ret,
 			"[EnableAllSmuFeatures] Failed to get enabled smc features!",
@@ -3364,6 +3366,8 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 	int ret = 0;
 	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	switch (type) {
 	case PP_SCLK:
 		ret = vega20_get_current_clk_freq(hwmgr, PPCLK_GFXCLK, &now);
@@ -3479,7 +3483,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 	case OD_SCLK:
 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
-			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 				od_table->GfxclkFmin);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -3489,7 +3493,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	case OD_MCLK:
 		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
-			size = sysfs_emit(buf, "%s:\n", "OD_MCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 				od_table->UclkFmax);
 		}
@@ -3503,7 +3507,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
-			size = sysfs_emit(buf, "%s:\n", "OD_VDDC_CURVE");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_VDDC_CURVE");
 			size += sysfs_emit_at(buf, size, "0: %10uMhz %10dmV\n",
 				od_table->GfxclkFreq1,
 				od_table->GfxclkVolt1 / VOLTAGE_SCALE);
@@ -3518,7 +3522,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 
 	case OD_RANGE:
-		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 
 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
@@ -4003,6 +4007,8 @@ static int vega20_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	if (!buf)
 		return -EINVAL;
 
+	phm_get_sysfs_buf(&buf, &size);
+
 	size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
-- 
2.31.1

