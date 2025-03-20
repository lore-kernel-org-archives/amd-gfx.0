Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA132C36000
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 09:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C1AB10E38E;
	Thu, 20 Mar 2025 09:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2PuTxVhc";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF8910E38E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 09:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvyf9qKl0WGingXnYmk68gUlq1qQA8PMSTaZVaOtR7FsnTuCmOAlm7854BaGOFdGq6xYKSsTl8unFhBzhDgKuAjmcJRREfEkslJ1bzye+TTko/w68bPzmKSGD1ajVigYVTlnrLiaNXIxrGdDmwCnJHarpAOL4S+YsotP0D2qs7OwA7grVWaw+teXZ03l0niJ3JbjYNOTFJfjrTwHwtnx/nbBSVJ8KZsTf9tW4t1+sIEUFgbLr83uLIaVjP+awveqH1aNlN/GXAKDMRooFcICCUQQ8LqmZpdqQk/BeoGf7yfcqe2jKRrDxbfkEXPYiZ5V08gOYVN0BbgR2Qub7nnKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZRt8bE6DRzLyUE1UFwQ4g9oqX1Ps4lPNjZe8I8Cadk=;
 b=j5KcNAvGA90k2qx8qSApPYCLe3o7eaaBCveqejtX1vtPRQsulQyBVzXX7oop6mKNYzBjs2/r3a8ZNPWQa5u/mapm+WFi2wq0ZM1OW1MZVobxqPak1Nttuyf8u/wpJr1tXCNafM95yi3UFpkzCjao63srtWI18aN/rx7fG5IJTZNz1yH+TgPE5ugWolqRohHMHOTDTDskSZ4vuXTXal+TTSF1+DFVnqgVjK1zzlDfXojFqlrlVhuBGP8wZha4kuMxsxnPHCydkA9o2mDH3msn4vsX3PEebbnq+kK6FoB0q+5nbmuuEnbrwcCUhWwM/54sYRrPseCpoAx9wtuKfkUbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZRt8bE6DRzLyUE1UFwQ4g9oqX1Ps4lPNjZe8I8Cadk=;
 b=2PuTxVhc/a8evnEv4ECmy/LJieue1PbWHQmDPuYPA4+28U6w6kMxuWooFPUPsbfMvD1IOIU1Y7qQ72EQQILm32UnHbc1WbboHivKiVZTA+vV295EIcUTtr8KAik/6yk/IPzZDuVH9m+h+t7NdUqDNsvFJEsLKT1o98oKAibZvpg=
Received: from BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42) by
 DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Thu, 20 Mar 2025 09:39:05 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::1e) by BYAPR01CA0029.outlook.office365.com
 (2603:10b6:a02:80::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 09:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 09:39:04 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 04:39:01 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <KevinYang.Wang@amd.com>, <Tao.Zhou1@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Date: Thu, 20 Mar 2025 17:38:45 +0800
Message-ID: <20250320093845.587026-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 613b5a00-e37d-4d5c-4d0a-08dd67930e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Afsjkxu+MMVQIHh5WO7VhHTsM5frz6I8ymrONuWbip6AvBiF6Ok/b5XET+xx?=
 =?us-ascii?Q?fT2diqJiL2vJxyIF5BiXtMRW10RR41L8xkGYD2R2phR7hdSNfd1JsqhIUPmM?=
 =?us-ascii?Q?2SR3fIJKLb0bHsCoCu9/ieDf/qDex5G/DebHt8m3fAVo1xOrvLzQsC1fKJtP?=
 =?us-ascii?Q?tq67E3VwzbK4qd3qD7JXnuKFjibciGXP4Doo620/PBRxZUqgHJOzTjkhWVPv?=
 =?us-ascii?Q?ZgoiJyC1luk1cIKPavpbCSg4Szhn5kSbhcFMXGhUigQRikJiebSLZw0B6HnF?=
 =?us-ascii?Q?GijOusi6GIoDWB0S3S+1uLdYOpKMp0nvJ3qygBdJ0s5qsZU7GyvjjUYy6FVx?=
 =?us-ascii?Q?DrJmpNGyKP1XkNyDnk8bviwirQlT1pHQ5RDFdxtHY8LzAxugdG5zu82Y3X5c?=
 =?us-ascii?Q?ype5SfexpA6vsioAFjtniPCSYvqNrLuLzWeIRPwQ4/Yex0f2m8ZWdC8DAYPY?=
 =?us-ascii?Q?VFxx9Axuoji7hy98+oq5HEuXHHTJnUQ2mXQtlgbiYm9kx3T8HRAN2QHhKHlK?=
 =?us-ascii?Q?mB5uc/lxfD5zTxXShjXWkgZCs4yjvAIJcd4LP9vq8jtlL9qyRgTeCrWuI7xH?=
 =?us-ascii?Q?lXmU8A38ttdg9qz2tU3sLqW1YoRFctKKRf9hv+JnUSlqJTOFZQmHbFpRy9ZC?=
 =?us-ascii?Q?okk+wZxv4dnIdOqcTHQ4Wsdlpfpo/wgtet7gJT+hQ2UlNWeHbZET6KR7AsRt?=
 =?us-ascii?Q?XidG6ru0eybg5fEmMe8oqrtcNYHSP7lWE+ZZ1lGsCHMCTJ6tgYjg8WzGGs1S?=
 =?us-ascii?Q?+QXNiGxtI6geTh+XTPN836P1KPjdyO3zgPoNxziRDvZmiDndUGDTiUcldEbr?=
 =?us-ascii?Q?X53ylKCRG6KGMhk+yNAXFZV6DWRBfIEPRZWCC8IOgwD5SWTe/zYpQKUKqsLN?=
 =?us-ascii?Q?tS/kDKr0aX3r+DYgHmruNoLwmDIeET4Jsk6XNRBrJmOpQWmt/cudg4UxFg93?=
 =?us-ascii?Q?NI/PVL/LZ1D0IjuI1fVAbPu1LbJvpIqgrYt20mrYD1LMzxYYXwzZyQgyd/0f?=
 =?us-ascii?Q?BI4VzWkPXPQLzmlfhJk0JYe2qCEgEBNL8iMuMZXvnY6d24kNs6uFYMxUMMZh?=
 =?us-ascii?Q?hdFLIdDPdEq7Y13JVoNZRGB68wVHSAuo059P9DEIqG+BKrhooaQSHVH7AoTu?=
 =?us-ascii?Q?CR611bkPBGQFE8ZoBDm7wZUhsFx0N+IslmtNmiNiE55S02yqDqv5n9QI9QYM?=
 =?us-ascii?Q?UnV3BeU/7mJx+kqqtuTXuIqBcM3GFNJujK4cLd+ZNmoWRXC6n1w2i15hpIqq?=
 =?us-ascii?Q?TZGM3/KEGYDfDMrgYzaUE+g72NBepqTaXiUhLTqt1/fJfVr57g/1LP5hyJo7?=
 =?us-ascii?Q?TloDLouesxb2LYAJwa3LW8qckPlowVr4nxXvczvVXT3aXPqeBuIAB+ZHZxzr?=
 =?us-ascii?Q?yyqFa7z5qj9X6NJcDSLhWiD8tXIgp3/kGhNoBZOcEXxy1z80j5gWEHPXkepf?=
 =?us-ascii?Q?AO/wvWSZayM1HU8fUJBbqOBd1+h97CIOp0cW9eT5oVPhNfE1ZjGf52+FDUtl?=
 =?us-ascii?Q?TEXd93X+R0yo1cM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:39:04.9137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 613b5a00-e37d-4d5c-4d0a-08dd67930e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
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

In the case of injecting uncorrected error with background workload,
the deferred error among uncorrected errors need to be specified
by checking the deferred and poison bits of status register.

v2: refine checking for deferred error
v2: log possiable DEs among CEs
v2: generate CPER records for DEs among UEs

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 25 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h | 16 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  8 ++++----
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index ffd4c64e123c..dc47f5fd4ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -391,6 +391,7 @@ static void aca_banks_generate_cper(struct amdgpu_device *adev,
 {
 	struct aca_bank_node *node;
 	struct aca_bank *bank;
+	int r;
 
 	if (!adev->cper.enabled)
 		return;
@@ -402,11 +403,27 @@ static void aca_banks_generate_cper(struct amdgpu_device *adev,
 
 	/* UEs must be encoded into separate CPER entries */
 	if (type == ACA_SMU_TYPE_UE) {
+		struct aca_banks de_banks;
+
+		aca_banks_init(&de_banks);
 		list_for_each_entry(node, &banks->list, node) {
 			bank = &node->bank;
-			if (amdgpu_cper_generate_ue_record(adev, bank))
-				dev_warn(adev->dev, "fail to generate ue cper records\n");
+			if (bank->aca_err_type == ACA_ERROR_TYPE_DEFERRED) {
+				r = aca_banks_add_bank(&de_banks, bank);
+				if (r)
+					dev_warn(adev->dev, "fail to add de banks, ret = %d\n", r);
+			} else {
+				if (amdgpu_cper_generate_ue_record(adev, bank))
+					dev_warn(adev->dev, "fail to generate ue cper records\n");
+			}
+		}
+
+		if (!list_empty(&de_banks.list)) {
+			if (amdgpu_cper_generate_ce_records(adev, &de_banks, de_banks.nr_banks))
+				dev_warn(adev->dev, "fail to generate de cper records\n");
 		}
+
+		aca_banks_release(&de_banks);
 	} else {
 		/*
 		 * SMU_TYPE_CE banks are combined into 1 CPER entries,
@@ -541,6 +558,10 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 	if (ret)
 		return ret;
 
+	/* DEs may contain in CEs or UEs */
+	if (type != ACA_ERROR_TYPE_DEFERRED)
+		aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data);
+
 	return aca_log_aca_error(handle, type, err_data);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 6f62e5d80ed6..6b180f1b33fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -76,11 +76,17 @@ struct ras_query_context;
 #define mmSMNAID_XCD1_MCA_SMU		0x38430400	/* SMN AID XCD1 */
 #define mmSMNXCD_XCD0_MCA_SMU		0x40430400	/* SMN XCD XCD0 */
 
-#define ACA_BANK_ERR_CE_DE_DECODE(bank)                                  \
-	((ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) ||   \
-	  ACA_REG__STATUS__DEFERRED((bank)->regs[ACA_REG_IDX_STATUS])) ? \
-		ACA_ERROR_TYPE_DEFERRED :                                \
-		ACA_ERROR_TYPE_CE)
+#define ACA_BANK_ERR_IS_DEFFERED(bank)                                \
+	(ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) || \
+	 ACA_REG__STATUS__DEFERRED((bank)->regs[ACA_REG_IDX_STATUS]))
+
+#define ACA_BANK_ERR_CE_DE_DECODE(bank)                             \
+	(ACA_BANK_ERR_IS_DEFFERED(bank) ? ACA_ERROR_TYPE_DEFERRED : \
+					  ACA_ERROR_TYPE_CE)
+
+#define ACA_BANK_ERR_UE_DE_DECODE(bank)                             \
+	(ACA_BANK_ERR_IS_DEFFERED(bank) ? ACA_ERROR_TYPE_DEFERRED : \
+					  ACA_ERROR_TYPE_UE)
 
 enum aca_reg_idx {
 	ACA_REG_IDX_CTL			= 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c0de682b7774..e62072779ae1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,7 +876,7 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 				      void *data)
 {
 	struct aca_bank_info info;
-	u64 misc0;
+	u64 misc0, status;
 	u32 instlo;
 	int ret;
 
@@ -890,12 +890,12 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 	info.die_id = instlo == mmSMNAID_XCD0_MCA_SMU ? 0 : 1;
 
 	misc0 = bank->regs[ACA_REG_IDX_MISC0];
+	status = bank->regs[ACA_REG_IDX_STATUS];
 
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info,
-						     ACA_ERROR_TYPE_UE, 1ULL);
+		bank->aca_err_type = ACA_BANK_ERR_UE_DE_DECODE(bank);
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type, 1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
 		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
-- 
2.34.1

