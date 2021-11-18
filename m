Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33648C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF1A61B3A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFF1A61B3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9B76E90C;
	Thu, 18 Nov 2021 09:33:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9AB6E902
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 09:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRSFAkKY+OcSQW+8+0NSXO3n5DRU23gUyW7QJWHLYc1QAQJmndWJNzGp5NvZiMfnfc1NBcY66/FOYvICdDGoCyezaINiprSmbjKN6Y+HnXbTqmdXbaMUPKMNqcz5aGRGs6+LN8AH+lGyJoOlavvlQdrEHYEGvXeUGqb0FqOm9byUnT6ZzqANeNagLChLT6ajEI6e5+qqgg7LJySSlygq/y8Qc6q0BpXzpuzNvq9CqYxY7+RTBlwFbERtHM0E9WiwF6lLC39L+oVRshPG8GK9ltoEYJjPYiToKgz7BaGVAKxlg3WANREIvsuyfrquBgH136JZ3LC9K4wlv7M1fiKZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgII8wLPqz+LmzVEjFVB2xkjg3Un1yLd9tUViH/4uvU=;
 b=Dyeo0DYI5pzuzDrM2HNV2Ao+U/C3ExbZVjn/NawI2UVOjaO9/+U9rzRUNDYjtarN+mtOCcNFScwQZth8Yrx3QBYk5XSu2UJM7DOIbd8O6OUC5odMlqsSzgc64zWA8ighAABwY9KpR2hCuOqihNQF7GLm1FM9Zw5VgTvAGAetbbDGst9iEZmJeNeUS348Ql0F0HwSrJjhQb18Hud0NozjKBpX4n+hDUgBc9f2ew7Na+NSaqcNgcAdK2/HdAWlf04JjMudK50Sov9OQ0gzUK1CnjmMBfS85TrLdoeQ0xlGjHUrLRsuKl29qciqij12/R8Zb35G4f74gHE52YIs/UDFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgII8wLPqz+LmzVEjFVB2xkjg3Un1yLd9tUViH/4uvU=;
 b=QkzC2f4zfZC1QN5HVumN++hva6x2iUHv4/NEpdee2HjP9pCY0av8KuOnnBhWyllnv1Tl5G2zWTudv8DhOaqZfScuhzsOaX57eW0A73tIRUnko+yvcwowvg3mBBPEFgIPYAsSB3RACChEeYu2FO70vfoiGKIZkDzFdb19SnNNI5g=
Received: from DM6PR03CA0059.namprd03.prod.outlook.com (2603:10b6:5:100::36)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 09:33:51 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::ed) by DM6PR03CA0059.outlook.office365.com
 (2603:10b6:5:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 18 Nov 2021 09:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 09:33:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 03:33:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 03:33:49 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 18 Nov 2021 03:33:48 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH Review 2/4] drm/amdgpu: add new query interface for umc block
 v2
Date: Thu, 18 Nov 2021 17:33:42 +0800
Message-ID: <20211118093344.4361-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211118093344.4361-1-Stanley.Yang@amd.com>
References: <20211118093344.4361-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb73f976-d94f-46a8-c6c0-08d9aa7687c1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4272:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42721FCE355B0716F3D741729A9B9@MN2PR12MB4272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rKj50B7mG+I8Nslf9NklYcY6H9P+yXr7KgCZMwQzg6hqlQ+5eWPeh0nzriR08aSoOTT8u1i6sdULAKvOeR5ZU54ilRoMTG6a+oCDPoK+G83g02EyOCEblDIbTX4JO/kh10n9wa8U2YH9nJSCDjITuVCc1UKL4N39+n6toM4ZIiufetDfR5AOR28clsXo9gOrx2qFgVd6DINulsbWcetPMNtO3sFsqTmyXwsnbmLwxsrbynKe/KSP6QzmfCQ6zQP6/ltjWa/fgihkqxPdVkHz6MsmoxRsBUkNiYe8m19RO0wYAQYTfvDgs93faigSJv/RSu87Gh7o7bYczXB9LvOeguonmY0Hy6cnpIxzEI58Fdh7g8fBqoyNg6U/aRPY5olk3SYoH+pk2q4QsK1fKhqg3YRTLscStwDALgzNHT8eGiDERtmxlYiAVQYmgUp7N15DjjBIytHY/A5upiABissS5JeZavAqgHMCGGIiG1U7Jo4FFgwOtbd922Il3mEk9jOdunhX/vwRUAVY9mpfqZwL1B87nRk63V3vBaLRC38ETLlUuRTHARce2WIh66lrHUTqbEmzl1TqpxPnfTfeTRiaxcLKdIRDyQxlUwNvR5AHpP1+l6KyKZsV17yNynNetEYG+Ni4PLBS8Zs7tMy2AtCdJ8NuGh9UbnQ4lD/+ozT7H4wAe7tVZv8gb4mRYWBpcBP3GJnwOwomsM5c8WGfS5WeagzpgzM0zwI+9koNIxpU8Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(70206006)(83380400001)(82310400003)(508600001)(336012)(8936002)(36756003)(36860700001)(86362001)(4326008)(6666004)(110136005)(70586007)(26005)(2906002)(47076005)(186003)(81166007)(8676002)(6636002)(316002)(426003)(2616005)(5660300002)(1076003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 09:33:50.9112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb73f976-d94f-46a8-c6c0-08d9aa7687c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add message smu to query error information

v2:
    rename message_smu to ecc_info

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  16 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   4 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 161 ++++++++++++++++++++++++
 3 files changed, 181 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index cdd0010a5389..bcbf3264d92f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -320,6 +320,19 @@ struct ras_common_if {
 	char name[32];
 };
 
+#define MAX_UMC_CHANNEL_NUM 32
+
+struct ecc_info_per_ch {
+	uint16_t ce_count_lo_chip;
+	uint16_t ce_count_hi_chip;
+	uint64_t mca_umc_status;
+	uint64_t mca_umc_addr;
+};
+
+struct umc_ecc_info {
+	struct ecc_info_per_ch ecc[MAX_UMC_CHANNEL_NUM];
+};
+
 struct amdgpu_ras {
 	/* ras infrastructure */
 	/* for ras itself. */
@@ -359,6 +372,9 @@ struct amdgpu_ras {
 	struct delayed_work ras_counte_delay_work;
 	atomic_t ras_ue_count;
 	atomic_t ras_ce_count;
+
+	/* record umc error info queried from smu */
+	struct umc_ecc_info umc_ecc;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 1f5fe2315236..9e40bade0a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -49,6 +49,10 @@ struct amdgpu_umc_ras_funcs {
 	void (*query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
 	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
+	void (*ecc_info_query_ras_error_count)(struct amdgpu_device *adev,
+				      void *ras_error_status);
+	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
+					void *ras_error_status);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index f7ec3fe134e5..6dd1e19e8d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -50,6 +50,165 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
 	return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST * umc_inst;
 }
 
+static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
+					      uint32_t umc_inst,
+					      uint32_t ch_inst)
+{
+	return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+}
+
+static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
+						   uint32_t channel_index,
+						   unsigned long *error_count)
+{
+	uint32_t ecc_err_cnt;
+	uint64_t mc_umc_status;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	/*
+	 * select the lower chip and check the error count
+	 * skip add error count, calc error counter only from mca_umc_status
+	 */
+	ecc_err_cnt = ras->umc_ecc.ecc[channel_index].ce_count_lo_chip;
+
+	/*
+	 * select the higher chip and check the err counter
+	 * skip add error count, calc error counter only from mca_umc_status
+	 */
+	ecc_err_cnt = ras->umc_ecc.ecc[channel_index].ce_count_hi_chip;
+
+	/* check for SRAM correctable error
+	  MCUMC_STATUS is a 64 bit register */
+	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
+		*error_count += 1;
+}
+
+static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_device *adev,
+						      uint32_t channel_index,
+						      unsigned long *error_count)
+{
+	uint64_t mc_umc_status;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	/* check the MCUMC_STATUS */
+	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
+	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1))
+		*error_count += 1;
+}
+
+static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
+					   void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+	uint32_t channel_index	 = 0;
+
+	/*TODO: driver needs to toggle DF Cstate to ensure
+	 * safe access of UMC registers. Will add the protection */
+	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
+							 umc_inst,
+							 ch_inst);
+		channel_index = get_umc_v6_7_channel_index(adev,
+							 umc_inst,
+							 ch_inst);
+		umc_v6_7_ecc_info_query_correctable_error_count(adev,
+						      channel_index,
+						      &(err_data->ce_count));
+		umc_v6_7_ecc_info_querry_uncorrectable_error_count(adev,
+							  channel_index,
+							  &(err_data->ue_count));
+	}
+}
+
+static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
+					 struct ras_err_data *err_data,
+					 uint32_t umc_reg_offset,
+					 uint32_t ch_inst,
+					 uint32_t umc_inst)
+{
+	uint64_t mc_umc_status, err_addr, retired_page;
+	struct eeprom_table_record *err_rec;
+	uint32_t channel_index;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	channel_index =
+		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+
+	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
+
+	if (mc_umc_status == 0)
+		return;
+
+	if (!err_data->err_addr)
+		return;
+
+	err_rec = &err_data->err_addr[err_data->err_addr_cnt];
+
+	/* calculate error address if ue/ce error is detected */
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
+
+		err_addr = ras->umc_ecc.ecc[channel_index].mca_umc_addr;
+		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+
+		/* translate umc channel address to soc pa, 3 parts are included */
+		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
+				ADDR_OF_256B_BLOCK(channel_index) |
+				OFFSET_IN_256B_BLOCK(err_addr);
+
+		/* we only save ue error information currently, ce is skipped */
+		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
+				== 1) {
+			err_rec->address = err_addr;
+			/* page frame address is saved */
+			err_rec->retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+			err_rec->ts = (uint64_t)ktime_get_real_seconds();
+			err_rec->err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
+			err_rec->cu = 0;
+			err_rec->mem_channel = channel_index;
+			err_rec->mcumc_id = umc_inst;
+
+			err_data->err_addr_cnt++;
+		}
+	}
+}
+
+static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
+					     void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	/*TODO: driver needs to toggle DF Cstate to ensure
+	 * safe access of UMC resgisters. Will add the protection
+	 * when firmware interface is ready */
+	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
+							 umc_inst,
+							 ch_inst);
+		umc_v6_7_ecc_info_query_error_address(adev,
+					     err_data,
+					     umc_reg_offset,
+					     ch_inst,
+					     umc_inst);
+	}
+}
+
 static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
 						   uint32_t umc_reg_offset,
 						   unsigned long *error_count)
@@ -327,4 +486,6 @@ const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs = {
 	.query_ras_error_count = umc_v6_7_query_ras_error_count,
 	.query_ras_error_address = umc_v6_7_query_ras_error_address,
 	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
+	.ecc_info_query_ras_error_count = umc_v6_7_ecc_info_query_ras_error_count,
+	.ecc_info_query_ras_error_address = umc_v6_7_ecc_info_query_ras_error_address,
 };
-- 
2.17.1

