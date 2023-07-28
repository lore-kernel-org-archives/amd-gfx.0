Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25112C41513
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 06:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A5A10E659;
	Fri, 28 Jul 2023 06:49:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53FF010E055
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 06:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRpIyGnkLo9ln3Yx8OqeVn09wYNZtUeEjTGIC9smeQS7T5R9mwjyzDw54CrzQfy5rioPkc229HP+XSJsyzXz0fUhVxTbHMAGtuaY0+/V31sV+zAt3GVkQDS1pXC+2E4XqpTjkXh8EQTOx5arCo+zcrvcLY/5mMNYhROneMZ4PDNymwX9FlVBXtDpaWsuBck+tipj0KS19uX+bzk1ghpvp5Jmfl2GcHE/D/Or2HGjtU/0d805Z7M87jN4xtUEQXIm/J0lAo+7uYCvCFpqV0Luij8bMiAf2sYgXA8gDwg5Mqto2RtFR7bnyVLHjoEaOw/K+bzIz6ooRa+uL3N8O0Yo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QnnTo7SWKEWAphR4IDYqJJajHItysQj7tihBo9Gsts=;
 b=INsRhtlE1s+siY5wE8wujuZWjpQchTvTnt0QtQX/s4ojaGD7f0/Zol9B+uyTh4tcBYxsn51BVulRGXbWRNGhXFdm9spQMkavAdQr/AGLc3XFSy3zdKEe9MZ3nnLc4iSPOojx/ERIc/EYCFDrQ7dupUpDkYit8qlIG+DSjkwNCvQyFL9EO2VMwpQBAuRc92+HZZZPaU/y3iEXt78mGnNActrdEL41wwV2rGBAVrfrh/++1vkGAvOd5EUXQpA1HbyZmFWiG83SsuLHC4HMrBHsFi62mnEzWWWEveKZ0nijc8iEgLHf3cxcFIIzMpiVzACyDg+zpIUkXhf6TSfq7Pzd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QnnTo7SWKEWAphR4IDYqJJajHItysQj7tihBo9Gsts=;
 b=4XT7S9fAT6uvLMspgRHEi/3h2D10G/RioTueuJXvug4RhkoKB9G7ZL4O7IKNRmK04uTith3DkqFuCu2LqCKuK9aasvSFRuW+SuKmZQNbYd5PfsbYYhZKhRdWi2kevDMUO7Th+T4q+WXhgUUBUgXqZsMC5CqW9fYQshDaHBgHSxY=
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:49:46 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e8) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Fri, 28 Jul 2023 06:49:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 01:49:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Add pci replay count to nbio v7.9
Date: Fri, 28 Jul 2023 12:19:11 +0530
Message-ID: <20230728064912.3652140-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728064912.3652140-1-lijo.lazar@amd.com>
References: <20230728064912.3652140-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 9701a232-8d71-481a-f35f-08db8f36d4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sk0ETzt0ZAeEO6jZg7puywoPXpDjqABd/wMQsymPAptn/WQFewYp7F0HNrZfW60NWfdlpvPtb8bl8fYdrSH2snCAjRbazcwQ40GfftjdvyWJizyQomZdR0H9718FxWE2GSqXyJskoRc11/GLK86KhR7tOX8WP/7taASQjWkxE9X9IhGwh9/HCIlEIEZhIjDP1uWZOdrAPaviSDX7ds7EDA7ihZ5WyXDv6cLeuEQY6LKEqAOGvO3WOluN+cTD+xTLGHgUi2G7SoiWOWRO7iGQ5Ywn0rxTPpjqLe7mvYVuGOm2W7UgFfUkBydOCKo+e70/hZk0XjO5m6kDU0khY2EVw6WpiLn1wClScsTaT+7zP1BuU3xXHsU35AvCSd1OV19BfHrtcXrLqRTV/mb5wBc96FynztUp+xwt+B5J9k5V1+0RhIsWnCRw2AI+fjVMDB0D6yOH6lBbMjnpvY4Mbv5oWsOQ4kDlYJi97H7ZTLR0/h7ZLJBKJq8an+aV6pychpe8dnFYp9bh8ApoQblemQYBn1qbQZ9guI9tzk/81RrbfpOT1hpmkvG3tAPdApVBd/2sEcL6MKqsBJxLi3Svj+1N12p6kGuUfrTdJNJ5fwLQL4npOPhU7S/bFu+I4ge7tlS9e4iv3TAKvXa2I4D70pZm4gnb95VBhi9C0sPgSNh54OgdkU3FeCxYZ9C9dG10Ot7BaW2Qa6EkKzCasPC/SL6/rI3qL0vscTrgx4HzdeMamP62ViuTWJxIpvuRGfHC8uGRbpStaZ65qG8mbd5MqqQnLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(2906002)(44832011)(316002)(40460700003)(8936002)(8676002)(36756003)(86362001)(40480700001)(26005)(1076003)(7696005)(82740400003)(356005)(478600001)(6666004)(47076005)(83380400001)(2616005)(16526019)(36860700001)(186003)(426003)(336012)(5660300002)(70206006)(70586007)(6916009)(4326008)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:49:46.1361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9701a232-8d71-481a-f35f-08db8f36d4ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add implementation to get pcie replay count for nbio v7.9.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c     |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index cd1a02d30420..1d1ab188ef15 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -32,6 +32,9 @@
 
 #define NPS_MODE_MASK 0x000000FFL
 
+/* Core 0 Port 0 counter */
+#define smnPCIEP_NAK_COUNTER 0x1A340218
+
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -427,6 +430,22 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	}
 }
 
+static u64 nbio_v7_9_get_pcie_replay_count(struct amdgpu_device *adev)
+{
+	u32 val, nak_r, nak_g;
+
+	if (adev->flags & AMD_IS_APU)
+		return 0;
+
+	/* Get the number of NAKs received and generated */
+	val = RREG32_PCIE(smnPCIEP_NAK_COUNTER);
+	nak_r = val & 0xFFFF;
+	nak_g = val >> 16;
+
+	/* Add the total number of NAKs, i.e the number of replays */
+	return (nak_r + nak_g);
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_9_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_9_get_hdp_flush_done_offset,
@@ -450,4 +469,5 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.init_registers = nbio_v7_9_init_registers,
+	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index afcaeadda4c7..158e611474ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -895,7 +895,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.init_doorbell_index = &aqua_vanjaram_doorbell_index_init,
 	.get_pcie_usage = &vega20_get_pcie_usage,
 	.need_reset_on_init = &soc15_need_reset_on_init,
-	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
+	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
 	.pre_asic_init = &soc15_pre_asic_init,
 	.query_video_codecs = &soc15_query_video_codecs,
-- 
2.25.1

