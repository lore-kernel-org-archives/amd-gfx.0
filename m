Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640E9C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996C810E37F;
	Wed,  8 Nov 2023 04:22:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E8A10E37F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVOiFGUjgjBTTySzYblIyqeJ6wBNyVe6nsuSDaOGIFHpcDMxSPBCxvKMsZTgbfaNKQAuNkpnEjDHBB/YvaBggsz4h3gNg7/d1Jh5/04imxr6/QUfPspeQiIegTwFa7OBWIzWnJMlexfxycq2pHepzpeOpWRYph/0i6QMnQrvBBWVpXFjZcfZz76SZe3/pbrW0reYyYvvBfHzdR/zeIjv7FKADVXZU9ZrNg9at6BI6C4o07kELfbis3jy6aZW7FMOsUey7PZZ+CUTsao4qDebbLHHltrbwdiP1UWV8lmm9Ho0R82Jgxs3xk/XNpiVrFZkpDklIp+6ijy9epez/J5kHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGGH071ijU1YcyYknNJoMQHI0lJ2RPeuvGcPQYOjxuA=;
 b=KfQenylbPbJNaWyQ9IrVmJAvdRbeKXW+U4kXOgYRwMzL5CRdI7UpB9873nWwdGO2A994ZBZBaLggjwkYE/MtpC15q5ljV0zh3dYMMhJauWsEz5vr/NMlyElj7zni272kHMNzCDoKZiAiA/J7oIvGNX5oFdEzwUZfWr17IdIz8KJGs0eXBgROSYPzYbrKT9fYHmql8Z3dgPYEGRaH9yWo8pBq3jhjlZBMHBhG0+9hefq2rutbP0dBAc7UMAIwRV7F/8qQN73hFYAlRzgBQN9H4tYcRa9+uEvQSqAJMgoauh/3dlBTQRF8xoEKEnFbrbtzffaowfMd2JKnb5f6IKOUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGGH071ijU1YcyYknNJoMQHI0lJ2RPeuvGcPQYOjxuA=;
 b=XhqQLb4xUWxGy4N9zNbivsBn4TDuSNRc4MweSDhISvLUxyH6shPHiJ7jCUokJNsVdfuW6oBwYcumgl3uxG2PevHO9wgZF3u7TZXA9KhmsMdjzKJD7tpJlLVpnlUmYlpc6SwWulH5x1IOCljTENw7P8SPmok9adQDMDltqIV9zL0=
Received: from CH5P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::17)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 04:22:27 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::6) by CH5P223CA0005.outlook.office365.com
 (2603:10b6:610:1f3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 04:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:22:26 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:22:23 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/4] drm/amdgpu: add pm metrics structure definition
Date: Wed, 8 Nov 2023 09:52:04 +0530
Message-ID: <20231108042207.528357-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|BN9PR12MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 1414c106-afa5-426c-7937-08dbe012502f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGKdPbzC/72oOtBrGIufhIw7pMPb4Got8F+23PffVOcvRiBB/dAUQPfbvq+qIqmqXmTsGVc1lTtVXfF9BGNLWTbuQfTT7ML05Jwz4nQNnfTEDLMOU/sHJd6+rQ8RpVW3V3pMZX1oEujWFpOWlvurKqKgXziXdOrHMcQbA2tWY80eUvBhngV0IOpIacYlXkjhO4pKR2OisFjArrMbZvEpTyiE3zy31xHN+3rzI0gqaUsetOXRZoKpd5EzAJprVzRoh0M1Od5SEk2bPxNd8p/RDu8PRIJaDGBnymC5t2XO3HluBrSE68tdOFSTijzUvB1oXmFjioH+/j5TMUYdytIb+tpr/22Vh2TqeeKITmZqfT3SI6xQFnJGwj4McGndmKzD2R6bxW8ztOexR0pu2l3se0xIsCPBG6hQVls1vuOWZfLWh4XCSWmxWidiEQmp9eC0IfKy/kz1LcwrbT3MBddo1MEIA20vKVV56puSWIxZQf2uIuaKy0AfM8S/XeVGIKkuCLLGFOzlYXr8nZVqXxIqpNm5Ja60WIVqnLI6noO4MHr1S2Td8DqsSSDOv9Xq/UHenmEOcpTjpTu1dKAZrcs+BTJ3igGutvpGld/70n4uuxtTRNWgDUk/Lad9OWdvplFZD6WEWQSeP6bh5skMnLkB8xfmt9a8miiL39bQ3AmhkTO6WpKasL0LUrAivbmoW+/p+1j4cPVKtgHps5WqRbzjFbkUBNngGqx7DDM3sGI4n+Hja3jUzoKNd7XHZ1SsiVUTrtCxRHDDrWTtFczJTfdBgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(64100799003)(36840700001)(46966006)(40470700004)(6666004)(36756003)(1076003)(7696005)(478600001)(70586007)(6916009)(54906003)(316002)(2616005)(70206006)(16526019)(26005)(426003)(336012)(8936002)(8676002)(4326008)(44832011)(40480700001)(86362001)(47076005)(5660300002)(36860700001)(2906002)(40460700003)(41300700001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:22:26.1597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1414c106-afa5-426c-7937-08dbe012502f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kevinyang.wang@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Define the pm metrics structures to be exposed via sysfs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index b14231f470dc..f9c438d16c56 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1127,4 +1127,19 @@ struct gpu_metrics_v3_0 {
 	/* Metrics table alpha filter time constant [us] */
 	uint32_t			time_filter_alphavalue;
 };
+
+struct amdgpu_pmmetrics_header {
+	uint16_t structure_size;
+	uint16_t pad;
+	uint32_t mp1_ip_discovery_version;
+	uint32_t pmfw_version;
+	uint32_t pmmetrics_version;
+};
+
+struct amdgpu_pm_metrics {
+	struct amdgpu_pmmetrics_header common_header;
+
+	uint8_t data[];
+};
+
 #endif
-- 
2.25.1

