Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576CCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E534E10F052;
	Fri, 29 Apr 2022 17:36:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F3E10F04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNOeU+3HbFSIfVH9A8jkQWb3/LZsWw9laQq8ecRePEu6NCetTysmDvHUDLQnwB/tJl9SRWOKZS1t8hz1ndPKVDKtKKS1c6LOdnKlbyajMY2Yq1nzIaeDyQV5Vlm64AwbFcS4iV7aHyLLu5JOUg3HBhs03rWBP72gPfT/NRPb9tG3YIMCo9g+ZKkfRYzyYIj6TXaFb936F9K1vwORFnaH8LkWMaKqWX2+ddJoRe9KdjxNHuYXMWehajCPbE/3SyNz7PoOTi8fiiyBrk13fbpQM8NzNhzb4hhh+1HC7lww0bKTIsGosLP4Vrg4aWkmwg2uUnsIWGNGGGXVBVyGqa2Vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRAIn/abG/4DLhUaNyOo30rmljmxzBmXQaOqgSsAgXE=;
 b=QD48Qn32vFW3WyHf0CCt6g63p9/tNVnyqW08TrBXr1PGAepDCtsNX9ERm3kVOl4eoRhjm1AHrbsgZWQaZqmMo1Te4dyaV9LKvYxma5zCKrMQThTufr62wbnRePKaAYXX/5+wAPL+4vpRGU1r9BdO1MibkONhQf9UD0Sg/E6V1UgbHR+VCmXf+7BLhFXk2kWQwGeTIobkQqP7wIEX/HXtDfOV5kC2Ysx86rK8Qxs6cvAyDCX6lo8ES07R26WrcwzzURQ+qkGPqqhJPXLCWVyKqhumjez5sXi8iWCB3zuNKdoUGD6P8yC2RXXmGdApWLKXQH+yl0Whfj/sIt5VfTIPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRAIn/abG/4DLhUaNyOo30rmljmxzBmXQaOqgSsAgXE=;
 b=eUzBkA8ZopvlSf35zxY6x5EST6l68s3v5+diRQi4/jhULZ0R3+Vd0hZl+1MuurtMBBUmGfWt/cjGbSOkJ+QB5LYs3DNIEBS/YMTBzv5jGrinowqji+UmIJLgzYTpEz8IkCiVmz1LSzq5oOOHtGTxl7eTfq2KvkaHDh/iKcPznIc=
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by BYAPR12MB3190.namprd12.prod.outlook.com (2603:10b6:a03:132::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:36:32 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::5) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:36:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:36:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: support rlc v2_3 ucode struct
Date: Fri, 29 Apr 2022 13:36:14 -0400
Message-ID: <20220429173617.433334-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429173617.433334-1-alexander.deucher@amd.com>
References: <20220429173617.433334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb10c0c9-2ec1-4557-f917-08da2a06cced
X-MS-TrafficTypeDiagnostic: BYAPR12MB3190:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31905A62C58172C6D3184623F7FC9@BYAPR12MB3190.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SEL/OHmO0uIurBip3WFhGjC4V5rwDFxZwcXAmQLu0Lq7bS0d1QGVg9FfD4R9vP4vBiSOaL1AvaD5Nk7NAjmn68odout9814Xuxj0redl716vu8PRterT8CrYur0jVfMyT0EOu7wHlaMZuRWrL4JLTT/bjfzzCe2VyP9qfhkPCGM8tY0qPPjMh/saZluLSU59OrKLnQuHdyuNryIMs0I2NAdzot1tUeYomAcjukckyn7QEttyUPl+qeE5vHESmaQFi8az7/TnnT+kT2t8eosVjmchDRuwkxuLAgGeUNNgPdVaJ2i/0rha0gKQ6OWcTS1dqzwYEnf1qXs7pGTa9evcomFuIWfVtIEw2WiPLXLQvc6JY+qDQ/J3EOtZji3f0XX1Xx8aib2NjwBy98ZwcCPss6IWgKhvRpxxw+yUk+WQH+KkLUrjfIYlsV4RTA0Hl1hqeHSbSKJrThSWMxreyWexBK5pz678qYCv4ykMYN2k9yj3bF+AePrJh/Av1Sjrv8jA38nluUG+UolBmxIfdvfFKw5k4tyQaWudgxApnZlQSp4D0+wvmTl+n6DR2XfvP5Fdj0zeH6tquiWAxtvkU9kRpWYJ9dGfjNGy5Zx2zgwKOzkCdAWl63ocqeGxpeeqRWTRZsaGh2mja0HiNAuIUtIg21exkOvxI58bwwyLDY0Yj0iI9kj563yXtSwEOn5J2h25daTqIWh6wP7K5RXkZKSVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(82310400005)(6916009)(36860700001)(36756003)(81166007)(54906003)(356005)(8676002)(4326008)(70206006)(70586007)(40460700003)(7696005)(83380400001)(6666004)(2616005)(86362001)(5660300002)(26005)(508600001)(16526019)(47076005)(426003)(336012)(186003)(1076003)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:36:32.1883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb10c0c9-2ec1-4557-f917-08da2a06cced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3190
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add support for rlc v2_3 to support RLCV and RLCP fw load.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 3f671a62b009..6232a89f02dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -179,6 +179,8 @@ struct amdgpu_rlc {
 	u32 save_restore_list_srm_size_bytes;
 	u32 rlc_iram_ucode_size_bytes;
 	u32 rlc_dram_ucode_size_bytes;
+	u32 rlcp_ucode_size_bytes;
+	u32 rlcv_ucode_size_bytes;
 
 	u32 *register_list_format;
 	u32 *register_restore;
@@ -187,6 +189,8 @@ struct amdgpu_rlc {
 	u8 *save_restore_list_srm;
 	u8 *rlc_iram_ucode;
 	u8 *rlc_dram_ucode;
+	u8 *rlcp_ucode;
+	u8 *rlcv_ucode;
 
 	bool is_rlc_v2_1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index bf9ead9c71f3..f535770f8092 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -248,7 +248,7 @@ struct rlc_firmware_header_v2_1 {
 	uint32_t save_restore_list_srm_offset_bytes;
 };
 
-/* version_major=2, version_minor=1 */
+/* version_major=2, version_minor=2 */
 struct rlc_firmware_header_v2_2 {
 	struct rlc_firmware_header_v2_1 v2_1;
 	uint32_t rlc_iram_ucode_size_bytes;
@@ -257,6 +257,15 @@ struct rlc_firmware_header_v2_2 {
 	uint32_t rlc_dram_ucode_offset_bytes;
 };
 
+/* version_major=2, version_minor=3 */
+struct rlc_firmware_header_v2_3 {
+    struct rlc_firmware_header_v2_2 v2_2;
+    uint32_t rlcp_ucode_size_bytes;
+    uint32_t rlcp_ucode_offset_bytes;
+    uint32_t rlcv_ucode_size_bytes;
+    uint32_t rlcv_ucode_offset_bytes;
+};
+
 /* version_major=1, version_minor=0 */
 struct sdma_firmware_header_v1_0 {
 	struct common_firmware_header header;
@@ -342,6 +351,8 @@ union amdgpu_firmware_header {
 	struct rlc_firmware_header_v1_0 rlc;
 	struct rlc_firmware_header_v2_0 rlc_v2_0;
 	struct rlc_firmware_header_v2_1 rlc_v2_1;
+	struct rlc_firmware_header_v2_2 rlc_v2_2;
+	struct rlc_firmware_header_v2_3 rlc_v2_3;
 	struct sdma_firmware_header_v1_0 sdma;
 	struct sdma_firmware_header_v1_1 sdma_v1_1;
 	struct gpu_info_firmware_header_v1_0 gpu_info;
-- 
2.35.1

