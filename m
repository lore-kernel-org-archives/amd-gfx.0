Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D470C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5DB10E69D;
	Tue, 26 Apr 2022 18:29:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B280A10E69D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kinX9GKRNBPH/r/CF98ZFIGx2Pmjtk5y8dKeV41/jKyJ2HBMsG3LOP+NBVbzrXmLM16Mud9x/qpY3pzXZAQ7XOwrLmXGAThBdDLZriEHVmvkdPpR01JVUAMS2M2nBaSnoOsgjuh2XsPDWzB4LwP8F9fh5yTzsLZmdMRx5IbH/LOSAc/zujIl3hCjedVI4XeGKVZr7N+IYEFiMaDVK4U/qJPL1+EOs2b7vbqMvQpT83hpqv1BannZD5CRfxgEb6/aESODwl1/RO6JeAxIHfdckmvDQmEk5NR7cEKjliKC4KkBA3CNe2syyrbbUqQKmuAHDvWLOdjN9FwTN1Dx9WTYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOmhoXdkTXfF5ar1NTFBnboQzz26usonW0Pgl26/t0Y=;
 b=A/V1apXPht0URohwaoBtVIiw5rHgqFkadWwyZ+1KmGrEuCkLkcOmZQDIoi7fnQKUI1AVxb8QdbuxyNjeMRBQS1/xb6HNphrlfcJaeNlIzlrgXxIQ/EPq5v48sCi6vAtgW0TcdN6sCW2tzfHabb3nG0dLx/tjrzF2djEmpez7ima/zrotoBv9e8T6cg3PjgPVmhPnj95cOAIk0yZLZN1/4quBHaiFYblbRwLwsGbTr6xRTGiG+7lsjbjXH9Qwh0AH3fIX0l6/pH39J6J7EQoXkmcf49KDm6Shtcp/AJ5Qs8m8sTOsPdOHqWdSztzhbI2MLRefCWWtLOnYu8ibv0U9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOmhoXdkTXfF5ar1NTFBnboQzz26usonW0Pgl26/t0Y=;
 b=H6SaH2H+eEW9Z0uAxpp1X8W3iM6Zf54BIg8cIHWaJivx9N4GqWP6+mDPDrz6duomfY4sXnSyqcriOWxcegKQUpz9HpXsnPVV36TlNfRlFGVx8Ir1P/qR09ONzX75RO35UoLyZoD2MVJV8bmyKtyRlM6ilU8FYomjcVi1cg1+Wi4=
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:29:38 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::a9) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 26 Apr 2022 18:29:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:29:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: add atom_gfx_info_v3_0 structure
Date: Tue, 26 Apr 2022 14:29:18 -0400
Message-ID: <20220426182920.3007060-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182920.3007060-1-alexander.deucher@amd.com>
References: <20220426182920.3007060-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a578654f-6188-40ee-75b4-08da27b2b84a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4247:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4247858B87CF780C22F11E68F7FB9@CH2PR12MB4247.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7QtRLpEr37w2sCFU1tuZMgS/H12I+XHwZZS/9IsxTfOH67/f+CF0lbC2lYpsFAU+uFGwuJMAji2EDtB4ZR0UQToPicaYI/GN1Q9frVMq2dYhCYkQgHzvmW8rKBgf3qmR/jg5YnzVreGjnHcoOlXT5NiQXrNmWS0iPNV+h5cOLTAEAXVnX7My38DGsX7RaChSLEY2NYkhicVTtA0x+1hVDqq0Kj2R0oHK+1tpxS4b1QeuWzsdX1sN6uILpY71y+QtfrbMtnmlDpNy2O/RFNgGi37k49f6WIEXKLtSxGwXMd7S7Goz4SZ+VuvuiUQFMwKqM/bsKwGejaWSQF3IJN4prFTblFGTZWQ+9b3jJMORjN7N2fT70paghE1knmUMflcLVtKdSiBe1ZGbguPv2gD4GVDCrKkXJVv1SIMeFIP4ey1Si6nGpxuuScnObRS6nlHkxNIU2WiI2VbDP9EDjI6Bb3biPeb+KwPtiTsA+o4LXin5lch8/yJ1c8nFXZaFiBUj+lsQ6EHzcjb932H1DYCBBiRb6TOi+LXWo6gkZ3Jmmm5RQgO/wovWrVrHWveDZ+LzUOvFNMZKwgb1Hg2BT7P0O3NrJeTlSXQ6Qm/nBULI9euMi5B8BqKGSgn7zjGPl2QJFs2CKAfYJID2AjdsT379YHCK7dD24ZsbKLl2LS8ZVd8N4zMj4sB3lGrMYVXRAkzhqJlL0Xq3dKyO4TcIDMy+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(70586007)(70206006)(8936002)(6666004)(2616005)(26005)(316002)(2906002)(1076003)(86362001)(508600001)(7696005)(4326008)(356005)(54906003)(6916009)(8676002)(426003)(336012)(16526019)(47076005)(186003)(82310400005)(40460700003)(36860700001)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:29:37.4021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a578654f-6188-40ee-75b4-08da27b2b84a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

atomfirmware table used for newer gfx IPs.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index b44341d6bcef..d516de41e6a9 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1673,6 +1673,39 @@ struct atom_gfx_info_v2_7 {
 	uint32_t reserved2[6];
 };
 
+struct atom_gfx_info_v3_0 {
+	struct atom_common_table_header table_header;
+	uint8_t gfxip_min_ver;
+	uint8_t gfxip_max_ver;
+	uint8_t max_shader_engines;
+	uint8_t max_tile_pipes;
+	uint8_t max_cu_per_sh;
+	uint8_t max_sh_per_se;
+	uint8_t max_backends_per_se;
+	uint8_t max_texture_channel_caches;
+	uint32_t regaddr_lsdma_queue0_rb_rptr;
+	uint32_t regaddr_lsdma_queue0_rb_rptr_hi;
+	uint32_t regaddr_lsdma_queue0_rb_wptr;
+	uint32_t regaddr_lsdma_queue0_rb_wptr_hi;
+	uint32_t regaddr_lsdma_command;
+	uint32_t regaddr_lsdma_status;
+	uint32_t regaddr_golden_tsc_count_lower;
+	uint32_t golden_tsc_count_lower_refclk;
+	uint8_t active_wgp_per_se;
+	uint8_t active_rb_per_se;
+	uint8_t active_se;
+	uint8_t reserved1;
+	uint32_t sram_rm_fuses_val;
+	uint32_t sram_custom_rm_fuses_val;
+	uint32_t inactive_sa_mask;
+	uint32_t gc_config;
+	uint8_t inactive_wgp[16];
+	uint8_t inactive_rb[16];
+	uint32_t gdfll_as_wait_ctrl_val;
+	uint32_t gdfll_as_step_ctrl_val;
+	uint32_t reserved[8];
+};
+
 /* 
   ***************************************************************************
     Data Table smu_info  structure
-- 
2.35.1

