Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58F6CA5520
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 09:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6205310E04E;
	Wed, 13 Sep 2023 09:32:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DC710E04E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 09:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6Ykw9uMKp45Q8W8LryqGPh652Yf5zeqGtJG1cIzjsoEo6dO1IE3Hj2MBI8Qt1fLxC/l86abisugaLhpZrwkOaTj7QMY/9iB0mhtOt3wWzqL7eCfQKevMmZfgGzrEr2SS182ydCk2AAexnDerqJYSCKy0hzecmD+4Hf11bwGjohtXFpqnXQtu6nsvqlnE0giwFE4f3SLgx3CcSkWqGvO9BYHiTMCo0rBBXU/e4UK+RTLmoE5ulG7aNRRuX8JDmM6I4DfJjvGCfIQNioKEIYc5lrIkiaEpol1P4vg8GDf1Yzhqh5n4CePMLmc5wi9a6xgSMbfiZ9mcy5w6UVCWJN1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxwbI4cLM8LoKza9EGVaRFfi+/RChYFI9ygAuB3qvGE=;
 b=Frb3oVLtAyvkzKBTNMAfxOlm75mcct4iZ6djZV/NXaqLWqTBqyQggTGhVfLVy/BdKhBHr/XktiK/lPTC4joDxh6w4U5X1dBl9GAA+lrmeiegYGixnYQlRACqkw6mzr1/pNiOSfiZKXVrxY91ZIzIOQ6AKxLqohJ1asOgqu6Srx/aZLiDFpMGC0RUOUMcvgvP9kk3mmgZktdC2ZO48qgWHHkYe5hXLyeQCuLaBm2JrUwg5AuUXMfnzzzhMaMJk5MORcaLBVW9ToGznHGrGBUF8at+8JX2BMzLNT/cAPn599j1A6RcjdUWwMokV50sZTg9G3t4OlPDlfPBUi8B1o5QVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxwbI4cLM8LoKza9EGVaRFfi+/RChYFI9ygAuB3qvGE=;
 b=IK6XRnIsmlHDnmK8MFg2DTzjhHqtroLqukyRuAx7inCpBp847xWEysTbYYels0qCby7ThGmxwY2Utpu/Rt5tAuK1Dgwe9/AmZDiDsfYkevJzOYn+9mD7wc3AINl0AniMDrWXaepn8Qiv8yeq7yqfpZTlSthkpVj9/yN8xAHxstw=
Received: from DM6PR12CA0008.namprd12.prod.outlook.com (2603:10b6:5:1c0::21)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 09:32:14 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::62) by DM6PR12CA0008.outlook.office365.com
 (2603:10b6:5:1c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 09:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 09:32:14 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 04:32:12 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: add amdgpu smu mca dump feature support
Date: Wed, 13 Sep 2023 17:31:57 +0800
Message-ID: <20230913093200.312429-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 028bb757-e2af-4bc1-bb7b-08dbb43c507d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPOVmX7IzeEV9xQui+lHdHYr4Ccb3PgzF9NdMtkoujBzld8AnnEx8r5hmpYlM6cAA5mvaKsBN2nFGI2AGzqr/fUFx9tRvRgfKgKisOsk40UTxdYkXh62/zteTexkCrtI4jv/4uz2tIfI1evZOpt6j5ehhxDRLqS8/O5Js7mH2Sp3U/ugfgcmi5GSptODqs7MfiKx51vDW5gMM0/zlf7lHEp8953X28nDngHqXDXy3pJQuzOOLUy0a1+fm4UxuKVia8IDha5cxhJsOmpVJ5BXCPwjW+OkrEjcYlDBAPxc0ysJCILr5u0C3FgHhpkR9a8wOuqkVVq3nVoT2dHVfW08/JVWFLfBrY6WwLPFAeBniLi2qc/Kj2f45hprXo1XjQ0XVgYf8wkoC3p9lbloh4nMUaYracTAeflAF48BWF1UUF1FFf4oZPtLp8XLlK68eam0O+S+fF5dlqvoKwewb/Q/SzVLgdlKlsM9Yzkm/cOIBONIuh+jB1ujUcVB7G7ESLt32taMJ3PT6MU7nyqT0LyMtVlorV30h5btori9PiPXJ3KObRSuSUGrD4iTrXicIHwlPWE8rlqR6dgcFGo7/lszlqRGIiC3C2ul7ILptYQRIQoIupMbNEI/kq22jsqCis7IsnjbmHjlo8UTAhDyoL42CGltVka45tUl1d7gdPX0PEZ+XwcoBjJulJmjck0Y2uJYL0Fkr1MWfZxZfbYOvOgYtdAQiacXqaCd2ibsbYPyCnHRr5ZZgYY53wAoza1NXnA2e2nRksBM815ZZxM4z2bNUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(356005)(7696005)(40460700003)(41300700001)(316002)(81166007)(2906002)(82740400003)(86362001)(36756003)(478600001)(6916009)(70206006)(70586007)(6666004)(54906003)(40480700001)(83380400001)(1076003)(5660300002)(47076005)(8936002)(4326008)(8676002)(2616005)(16526019)(26005)(36860700001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:32:14.3730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 028bb757-e2af-4bc1-bb7b-08dbb43c507d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
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
Cc: alexander.deucher@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add amdgpu smu mca dump feature support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 68 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h | 57 +++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 8d9ff9e151de..9fa88ae81b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -142,3 +142,71 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs)
+{
+	struct amdgpu_mca *mca = &adev->mca;
+
+	mca->mca_funcs = mca_funcs;
+}
+
+int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
+{
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+
+	if (mca_funcs && mca_funcs->mca_set_debug_mode)
+		return mca_funcs->mca_set_debug_mode(adev, enable);
+
+	return -ENOTSUPP;
+}
+
+int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
+{
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+
+	if (!count)
+		return -EINVAL;
+
+	if (mca_funcs && mca_funcs->mca_get_valid_mca_count)
+		return mca_funcs->mca_get_valid_mca_count(adev, type, count);
+
+	return -ENOTSUPP;
+}
+
+int amdgpu_mca_smu_get_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, uint32_t *count)
+{
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	if (!count)
+		return -EINVAL;
+
+	if (mca_funcs && mca_funcs->mca_get_error_count)
+		return mca_funcs->mca_get_error_count(adev, blk, type, count);
+
+	return -ENOTSUPP;
+}
+
+int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev,enum amdgpu_mca_error_type type, int idx, struct mca_bank_entry *entry)
+{
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	int count;
+
+	switch (type) {
+	case AMDGPU_MCA_ERROR_TYPE_UE:
+		count = mca_funcs->max_ue_count;
+		break;
+	case AMDGPU_MCA_ERROR_TYPE_CE:
+		count = mca_funcs->max_ce_count;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (idx >= count)
+		return -EINVAL;
+
+	if (mca_funcs && mca_funcs->mca_get_mca_entry)
+		return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
+
+	return -ENOTSUPP;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 997a073e2409..6915ae0d5b92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -21,6 +21,26 @@
 #ifndef __AMDGPU_MCA_H__
 #define __AMDGPU_MCA_H__
 
+#include "amdgpu_ras.h"
+
+#define MCA_MAX_REGS_COUNT	(16)
+
+enum amdgpu_mca_ip {
+	AMDGPU_MCA_IP_UNKNOW = -1,
+	AMDGPU_MCA_IP_PSP = 0,
+	AMDGPU_MCA_IP_SDMA,
+	AMDGPU_MCA_IP_GC,
+	AMDGPU_MCA_IP_SMU,
+	AMDGPU_MCA_IP_MP5,
+	AMDGPU_MCA_IP_UMC,
+	AMDGPU_MCA_IP_COUNT,
+};
+
+enum amdgpu_mca_error_type {
+	AMDGPU_MCA_ERROR_TYPE_UE = 0,
+	AMDGPU_MCA_ERROR_TYPE_CE,
+};
+
 struct amdgpu_mca_ras_block {
 	struct amdgpu_ras_block_object ras_block;
 };
@@ -34,6 +54,36 @@ struct amdgpu_mca {
 	struct amdgpu_mca_ras mp0;
 	struct amdgpu_mca_ras mp1;
 	struct amdgpu_mca_ras mpio;
+	const struct amdgpu_mca_smu_funcs *mca_funcs;
+};
+
+struct mca_bank_info {
+	int socket_id;
+	int aid;
+	int hwid;
+	int mcatype;
+};
+
+struct mca_bank_entry {
+	int idx;
+	enum amdgpu_mca_error_type type;
+	enum amdgpu_mca_ip ip;
+	struct mca_bank_info info;
+	uint64_t regs[MCA_MAX_REGS_COUNT];
+};
+
+struct amdgpu_mca_smu_funcs {
+	int max_ue_count;
+	int max_ce_count;
+	int (*mca_set_debug_mode)(struct amdgpu_device *adev, bool enable);
+	int (*mca_get_error_count)(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+				   enum amdgpu_mca_error_type type, uint32_t *count);
+	int (*mca_get_valid_mca_count)(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
+				       uint32_t *count);
+	int (*mca_get_mca_entry)(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
+				 int idx, struct mca_bank_entry *entry);
+	int (*mca_get_ras_mca_idx_array)(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+					 enum amdgpu_mca_error_type type, int *idx_array, int *idx_array_size);
 };
 
 void amdgpu_mca_query_correctable_error_count(struct amdgpu_device *adev,
@@ -53,4 +103,11 @@ void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev);
+
+void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs);
+int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable);
+int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count);
+int amdgpu_mca_smu_get_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, uint32_t *count);
+int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev,enum amdgpu_mca_error_type type, int idx, struct mca_bank_entry *entry);
+
 #endif
-- 
2.34.1

