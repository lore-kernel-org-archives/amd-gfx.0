Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B4B61262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24B4B61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81C86E8C0;
	Tue, 28 Sep 2021 16:44:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3416E8C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdOeV8DWpA0kFwLbToGx0+FQy/uxSqTX6m9zSbE0/ktK80qB10YYQiUb2trzPMKFkZ97m55yL9O4cCY/oOwdclxEaghfjBF2WHYbgswnY5ViezVjgp5Vz2x/NhXTSvDOyaLqLOPOcuWE7g+GWf26VHq8jyY77dKldX2auLDb7Z2IVrXw5RP3PjyNVFcaUOuVzfMv4gcM5GDTCo6GJynRqDOvjDlIMzrdZ/AJhOifsfBdRTFQPpQd+JQkt+AIuqm4xhGRCR/btTqXmeExqPA311vf4pdsbSxvY4XuYJl9etsIKt6fIozBTFMcbkZ80xE5XKrBloC3ZeRjQHvA5NGaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=N0aLLbQ6TiFgNoq96EqJZfIf6UJzNSWnVn8/gFClryk=;
 b=l9vdIubbzBbgXCJ7T4YgRxtHY8krDR/KywBkzLdQAav0as6U7ey7NH09TXyccWhgzxigzVME63ilcLzuB6EFNgnZgN6MvTzk7MM00rKEManz42H0tltmCfKwPcIPwgKICyiOBZ0fDZxCvRxCcuG3ON0971YYT+kxYGSuw1ZYh8AgYHkGVWOL4QEUMQYagif+afBkIjFu4j37Xks2o7Si9GAoDZa5FWJnsc0jjf7KE4atLhbzidOlLgtnX/li6TLhZjXfeV92w8qcRePdHKtrZQ5Zj7D8v+GEaCpwjojfAXgO2rloKXEJ3jNnPn7EHafwuAao10+BGxlLBSn7iua3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0aLLbQ6TiFgNoq96EqJZfIf6UJzNSWnVn8/gFClryk=;
 b=unp8FYBHDitX7rCmd23ajpuTBXSLvEupJZyGYZ0+ex3W6lALh0uojbRmg2bBP1wQscwRlfNHcuQdHT6EKnsk0mln0caZIDwgwe9FPSD4DURi4mM291XeeMljzTir61f/IynJnjz3bonh0ZDK9wydYj5nlnQR6ibhTPOk+1P4d00=
Received: from DM6PR10CA0002.namprd10.prod.outlook.com (2603:10b6:5:60::15) by
 CY4PR1201MB0118.namprd12.prod.outlook.com (2603:10b6:910:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 16:43:59 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::b0) by DM6PR10CA0002.outlook.office365.com
 (2603:10b6:5:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 16/64] drm/amdgpu/gfxhub2.1: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:49 -0400
Message-ID: <20210928164237.833132-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43dfec56-0c2e-48c5-71a4-08d9829f2bac
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0118:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0118B9237316F1A6C7BF9BACF7A89@CY4PR1201MB0118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:190;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZrX8O/9nhM4L7z9c8anRlnqtod5SllUpcuCW/DVFijuHPRY4tQDBZZ5tvDaSxek87QMr2GO+P0VN3FNYtYG3bTN9swJGM1p0iTKAx6UvEVpwaBc8zC3ax8gSt/I0UxD+5SC2MJweeHS/wstIS7ukLEg9oqFCLFSdCURu3aF/DZOWMsR97oSANd6DDaSuSBlzzajmi/JU3TLojwWlKipv/lC3RCZ9OC/pKjuVj/w8Nd9aVc1qC/4vnFeXJeo6bNzce0XxFNfVNYDYDuMzg6i0Cf0lMcSAEn9Z+VLSZDQY2mTq0oMtT/kSZGHcOJJ1zTDeY1MpGVT85TYHE9jNnXbPyC0uY39lzMixYxs+cufLEFi1BohfC1cBAgwLbEuCd93hVu7Wdn02Yfo9mCPAfPknhB/LJ+80RKjSmtiYQnzKRhFRylHcy4/ex33B5YM6IqnU2o0LGWrL5/ZrcfbPAhhOR23LpMwpe/5DqLDgh/MHKbrntBuSguMa3rY6kigROVX4bvDbLs9uEzThNgxhNtdwJQOudip9+1MdnL1JuMTcpW5VKoJ5rIo4mXaKScKKK4yXcqZkLB5S2NZ+9n59+tTkfjb3yhAquGUlLCU/o8qjGTP2y7Gytnsa3xO1MjrEnmCqoNsABGEKxznS9FAvIH4HeRv7Wit1Xkk+2Od69vX/1lLmEPcPiGBgJhZCdCZHllXerzHb2jtO1V+lUOpXqmB4A/ML23KEB9q4zguLsQVf+o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(66574015)(316002)(82310400003)(5660300002)(8936002)(426003)(36860700001)(81166007)(54906003)(4326008)(336012)(2616005)(6666004)(8676002)(356005)(26005)(16526019)(36756003)(186003)(508600001)(70206006)(1076003)(83380400001)(47076005)(86362001)(6916009)(70586007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:59.2958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dfec56-0c2e-48c5-71a4-08d9829f2bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 1a374ec0514a..149f3843e0e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -506,8 +506,8 @@ static int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
 	u32 max_num_physical_nodes   = 0;
 	u32 max_physical_node_id     = 0;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[XGMI_HWIP]) {
+	case IP_VERSION(4, 8, 0):
 		max_num_physical_nodes   = 4;
 		max_physical_node_id     = 3;
 		break;
@@ -544,7 +544,7 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 		adev->gfx.config.max_sh_per_se *
 		adev->gfx.config.max_shader_engines);
 
-	if (adev->asic_type == CHIP_YELLOW_CARP) {
+	if (adev->ip_versions[GC_HWIP] == IP_VERSION(10, 3, 3)) {
 		/* Get SA disabled bitmap from eFuse setting */
 		efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SA_UNIT_DISABLE);
 		efuse_setting &= CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK;
-- 
2.31.1

