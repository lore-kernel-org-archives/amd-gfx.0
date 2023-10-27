Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7ABC25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 05:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CED810E920;
	Fri, 27 Oct 2023 05:39:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2521310E920
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 05:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knVxbNTAhV8fkQVKbUm8xCslOnnPV1T+ZoIGRqZXU65FP+ztCjH2tHWoEVeQZlh5WbA/HKr+ZEnti+bO5fcwamIfwSP4KTXLthBTBXygWgzuwkofz5CpTfe97l7mk1ScD6maiwARZNbUQXcAeW6f0rdhFuoKYVKqW7jiv6L3wg6H92kB2x8lOXK86zJzzMJSlLvLhUWfY40mlScoyfaAJo3MXGYOo+ICKiq7ZbnPaKbeBxqXO7J6D6QNQdg10uOsZdC1yBlcyx5ESt7a+qV3cQhc9mK3+C7WppMaSxE9vvuG++J10ZaerxWwZN4ZiiESIR9ImSGqtM5uPq5ytreHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7gFycQrsop9nRxNCDh7o1Z5nrFJztG9cKN0/0qtRpU=;
 b=D/qbqcoARQ7Sc+nxuoS6KwUc0CzZ4wP7YYnf5iKa6pyNNZ3up9wnWzJQuFxs8sgqBtI9RqKKxjCjcZmBPOpoh3dm2BEjdNsjf3w3id86+AsEFvTL3IUfJ0mGNjUA+ECK+Upl6mgHrTD41avc5IBC1NnXxk/+xOfSyrCYcDXquk//woaXomfc+MB4hBp7DiTgnIq0H5WO27SkitKs7vRbyjiKh9qBighrvSeIr01ZIeCEr8sVN1Jne1MSvhXPQcyOYGSgbED+DgBYANlySXuVq88i0TTRtlrto130KskV61cpq0k2gDhTA3fUD6yihwELVC1K7Ovv7zF630kpykjV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7gFycQrsop9nRxNCDh7o1Z5nrFJztG9cKN0/0qtRpU=;
 b=SyGzds6NKYLJxXTgRxrdtq5zMt2yIksKxeu7U1uQGmbxKQtAebCvNcNwBVf/XPNre7NGdbNYNoJuFoeXGaeWZ1p68j1uWG6gQivpRa/7t78OtxXxfcGyIwLTLGAOoVcYRadOU21XR9bJZQ8LTbh65emAJwPBylytHrkm29Vdc7s=
Received: from SN7PR04CA0057.namprd04.prod.outlook.com (2603:10b6:806:120::32)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 05:39:30 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::88) by SN7PR04CA0057.outlook.office365.com
 (2603:10b6:806:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 05:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 05:39:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 00:39:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix warnings
Date: Fri, 27 Oct 2023 11:09:06 +0530
Message-ID: <20231027053906.414311-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: eac418f1-8fcb-47b5-6491-08dbd6af16f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zPrifvucgFtQtM3OVwu6Qp/Rd9Nx0TPt4V7oJv6cS6QgV86TPFSL2ArODz/bo8qkESUf5+8rED44q+KZhIRzULu8+8ROtL43Lzb+xcMMhl6Ilv1ai52dSn70/xi7LS0JZWO4nUwt61d0UKXXL5SKE/ZWB8mz1OH+iU7qh6abXo9+VtrJHdLc9YZALzyzJlA+hlVF2J4JpGZwIAlmoU1cmTIgoo9Hq9gMD5EHDZWvvDGu9lm84WelB/X/kd9ttdLs7vEkGyuvTPqgckRAVoEPE1H/aLgtt4cfgD1SOAonOS7F6778URtFaJFAyVfVS9V9x4oQzjVbPajNIeu7N3kYqQhxJYoa40MkU/Tr/5bL+Hu3YWFfKGVXJ0fgehzuTT7dYbmoySjRvC8aJEzPklK9w5ZadZ6HX1pMHwooO0i09WDk1tVJaR9yhJtvTPR7f+8BxlqFv3j1Y04yoeAA/uzpAQD6tViQP1RiZCV/6XH/TCDf3u3MUr5bywhqptgdnY6U2+YG9TiwRo0VLs1G3omtKjTxIAob6R3Y6/Qr4TOHUEX5EyiXium1k3fCrvAoeQYx9nnAthE743BsGySIxyBAn5jUoBEIBoQZJFz/lX1mYhxrwFDwzRtg4DRrQ88chDrbxMrtV8uScuebaF79tOlNQ1YrL/gEhhhSO2et+ynuaVfDXhnuRPSE/aIOPZ0uycbNLj/ETeO4c6XyL2H0L+oMwiac10PN1uyhGYzhCfOiazeIHsiOvWq8qvRjwqVSyROYh9HHgOyR/6XsHlmd/6Ut+2c13sw/5v8ptxmZXpfcjI7nlJvoZANPmWmxLSpGIP9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(83380400001)(8936002)(2906002)(4326008)(8676002)(44832011)(81166007)(356005)(82740400003)(41300700001)(5660300002)(316002)(6916009)(26005)(426003)(336012)(478600001)(7696005)(1076003)(6666004)(86362001)(16526019)(2616005)(47076005)(36756003)(36860700001)(40460700003)(54906003)(40480700001)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 05:39:29.5430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac418f1-8fcb-47b5-6491-08dbd6af16f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
Cc: Alexander.Deucher@amd.com, kernel test robot <lkp@intel.com>,
 kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes warnings:

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:286:45:
warning: '%s' directive output may be truncated writing up to 29 bytes
into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:286:52:
warning: '%s' directive output may be truncated writing up to 29 bytes
into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:72:45: warning:
'%s' directive output may be truncated writing up to 29 bytes into a
region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:72:52: warning:
'%s' directive output may be truncated writing up to 29 bytes into a
region of size 23 [-Wformat-truncation=]

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e713ab4bb0f..cecd210397d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -273,7 +273,7 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t p2s_table_id = P2S_TABLE_ID_A;
 	int ret = 0, i, p2stable_count;
-	char ucode_prefix[30];
+	char ucode_prefix[15];
 	char fw_name[30];
 
 	/* No need to load P2S tables in IOV mode */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 4ac22f44d160..01f2ab456724 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -57,7 +57,7 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	char fw_name[30];
-	char ucode_prefix[30];
+	char ucode_prefix[15];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
 	const struct common_firmware_header *header;
-- 
2.25.1

