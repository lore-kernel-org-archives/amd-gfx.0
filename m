Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0475C4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A66C61364
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A66C61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958596EE2E;
	Fri, 11 Jun 2021 07:05:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452F86EE2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RC9abfFHnE8H0hpZBLROVGKMkGobZ2ah8srahz4770GHfPyGG2ZJ8zXCaO8GRHqsKl0Xsm/0vb8tetEvl5EpivIEUbPwd73/W8P+ko6XGx+rH5gkHet+goi3sLkJi5HLfzshMaybpyqSH4V/o9xUqOxNPaSJ5ckvZQ658ML15E+svBGufwcRbLHV6k6yk9E9pOQtGtUvR0kI/Hum7w6D+SP4hntIw0UOr8klTZZtHx+Qpf/qPp9r78qExC3tQ5+NSQTgKub8Fg2SK2t+TduyCVeOrg4B/SaykPW0PrDFFRfZZnXhu3Tpy7lbnBmBPqMh2LIpYaakINGoCz/lgeoSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN+L6uEun2bkPlzMEzGutPDYu77KUPQzAcul1liZOuo=;
 b=R1tOUyipUg1LgSmWdR5v/QVMF8XJAlZKthHr1kYCQ77KWW9ibHFo5uidITYBxuNeduRlx2h75XyfWL3YyfpCy4VVZomiOZELHH14mW5Inu6ODTLtRdk86grN25h9nufUIAP1NbyHiBysUE67L5rKUT4Svs6FmpD5/gGzQ7WzY+ET2KEeRg8t9BfhEP0EpM5LuP5qiZK4qn4HwfZvJSrNgM0dc0D3P0ZzCVQOs+dTVmXsRVpGHGoLE/TlV3pqH7E3dfNPlILg0zNuZ3kDBW1zxw+IrthtLnYZa5lrq3KWUK5lNp3avZ+NGRhe4rqBCZsM8WVkPCHtKnmYavfyS731eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN+L6uEun2bkPlzMEzGutPDYu77KUPQzAcul1liZOuo=;
 b=UNIbwYYnACN+Dc6jz5SAbUSjEutIbVsIPFFe2cGt6tds6ycJiFZhNuwQkinJhymXJ8R4hmZyphgCmbPeat7J++b9I4zRjOmDnW/1ZSCcNLzP6OPDchqS68lNEljcXRF0q71eXxOutsrK1IQzFI3uteq7wtxPVWTmKlaYlzw8ouk=
Received: from CO1PR15CA0088.namprd15.prod.outlook.com (2603:10b6:101:20::32)
 by CH2PR12MB5529.namprd12.prod.outlook.com (2603:10b6:610:36::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 07:05:55 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::e9) by CO1PR15CA0088.outlook.office365.com
 (2603:10b6:101:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Fri, 11 Jun 2021 07:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:05:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:54 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 11 Jun 2021 02:05:53 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: add psp runtime db structures
Date: Fri, 11 Jun 2021 15:05:43 +0800
Message-ID: <1623395146-2162-5-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
References: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e10f214d-a32d-4c6b-ac4e-08d92ca75b8c
X-MS-TrafficTypeDiagnostic: CH2PR12MB5529:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5529676D72F4AC478845E0C0FC349@CH2PR12MB5529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+GEw9+aHQkA6QnS4EkKAtMzEEm2DKtDPOOA5gpXYAfFFuObi76qJrROvFMrJzRPRz0mKYlSdI5r9opABrz/dlbgFJXETDq+NuKemcwy1MR/BVLPEIVw/jXLlNkhkCOmFyFbRho8gHJXhLGvcsDPiiETxP6LKPAVZB5nNIlZtBWbZqTHpAzX3p4w/dT28dC+YbcBpQEA9tT/UXd2Th7ox9aslV+M7sfOFLwbkRohRBk30U+/Ax5V/xmmfhZe/Dv9PVJbppQx20lMMtTttCZraaJBKc/HFuBNDWVomDosv0zVG0RldKXf5E1g1oQcypLfOneZ5wKC2+VccumFAY5AudMRLZ0kzpFQQdIwxHP4YFmQCUvWzoIjbSj/KTWYGh+eZL9KvSMsEysJJ/8eDUuDUzwZQm4Vbd83+NH+MqiPYnScXaj2aRc++0lItjMyCRVKsQlEB+/GJD1g2p9x9KRt3PZtSBlBGg8O+aFuS+8KfYgdtS4VlSf7l4qPKb/nCGmnBllkNAJjkNoxMu41nB7z2/0FTbGRlyOzTQPJ1yxIDIrUe3Uq4CAprLg9BfqbKnp23NISlrqrtyVkqy0/UzWAsmfqAiZteSRPocAxsjrJ2DfDtHiLFjaYOOYblLrsXY6bWxtzPRrmpNZr6CcNERKWGIOAxHtcPtoZChBdj20ySl3PXoq763gXhiR9kbGOd7Rs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(8936002)(426003)(336012)(36860700001)(82310400003)(2616005)(70206006)(8676002)(2906002)(316002)(356005)(86362001)(6666004)(7696005)(47076005)(6916009)(478600001)(70586007)(5660300002)(26005)(4326008)(186003)(36756003)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:05:55.5133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10f214d-a32d-4c6b-ac4e-08d92ca75b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5529
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PSP runtime database is used to share various
boot up information with driver.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 46a5328e00e0..4dad9b539f06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -226,6 +226,60 @@ struct psp_memory_training_context {
 	u32 training_cnt;
 };
 
+/** PSP runtime DB **/
+#define PSP_RUNTIME_DB_SIZE_IN_BYTES		0x10000
+#define PSP_RUNTIME_DB_OFFSET			0x100000
+#define PSP_RUNTIME_DB_COOKIE_ID		0x0ed5
+#define PSP_RUNTIME_DB_VER_1			0x0100
+#define PSP_RUNTIME_DB_DIAG_ENTRY_MAX_COUNT	0x40
+
+enum psp_runtime_entry_type {
+	PSP_RUNTIME_ENTRY_TYPE_INVALID		= 0x0,
+	PSP_RUNTIME_ENTRY_TYPE_TEST		= 0x1,
+	PSP_RUNTIME_ENTRY_TYPE_MGPU_COMMON	= 0x2,  /* Common mGPU runtime data */
+	PSP_RUNTIME_ENTRY_TYPE_MGPU_WAFL	= 0x3,  /* WAFL runtime data */
+	PSP_RUNTIME_ENTRY_TYPE_MGPU_XGMI	= 0x4,  /* XGMI runtime data */
+	PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG	= 0x5,  /* Boot Config runtime data */
+};
+
+/* PSP runtime DB header */
+struct psp_runtime_data_header {
+	/* determine the existence of runtime db */
+	uint16_t cookie;
+	/* version of runtime db */
+	uint16_t version;
+};
+
+/* PSP runtime DB entry */
+struct psp_runtime_entry {
+	/* type of runtime db entry */
+	uint32_t entry_type;
+	/* offset of entry in bytes */
+	uint16_t offset;
+	/* size of entry in bytes */
+	uint16_t size;
+};
+
+/* PSP runtime DB directory */
+struct psp_runtime_data_directory {
+	/* number of valid entries */
+	uint16_t			entry_count;
+	/* db entries*/
+	struct psp_runtime_entry	entry_list[PSP_RUNTIME_DB_DIAG_ENTRY_MAX_COUNT];
+};
+
+/* PSP runtime DB boot config feature bitmask */
+enum psp_runtime_boot_cfg_feature {
+	BOOT_CFG_FEATURE_GECC                       = 0x1,
+	BOOT_CFG_FEATURE_TWO_STAGE_DRAM_TRAINING    = 0x2,
+};
+
+/* PSP runtime DB boot config entry */
+struct psp_runtime_boot_cfg_entry {
+	uint32_t boot_cfg_bitmask;
+	uint32_t reserved;
+};
+
 struct psp_context
 {
 	struct amdgpu_device            *adev;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
