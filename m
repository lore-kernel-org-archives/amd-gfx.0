Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD56C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 00:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7B910E075;
	Mon, 21 Nov 2022 00:39:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEE610E075
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 00:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzVg2nDK0JE5gRq8/bXVE1GoRJGmd+5OTj4NvL/H2VquZqOrdeV1ISEaZFr9NT47gomtyZt8oo7nPVmte6QwzKvgQQFYQSVAbQmHD212M6hy58lnmIE2m4BJN3wEbgKjdFeYqacMMBlUPDLqu2BXoZR1mHdrRltiKiTysKCoWSixQm+fIeJ5O5/9GQHWoR0MJ8cwWyaHND5KSyDykFXpTsYJidl0anqW2TQd6xtIAz7hw9CSaL/38WiqH8WbvjzUKgx/ZTRLNgLutkDdZ2jIwZrROx7ir+FHzqhDQyTyFEz4UjlxHSQw4OX8DU99FSQKD+w52VMB4O8WrHdkqGdAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmYAM0JskdBV9UtK+jIVUP1tPacSV8AQ+lrc4wZzK6E=;
 b=ghCqLPHBR+T/U7nnOnW2QbZh0tLooHVpqFpGDenqkfpNYeUhv0GJHYpOTR6ZHYtl0vK2mxFlaeTBL/k1Lad3TrvV86CBxdlibORxq9GrY5DpheQ5CdDbUz4Gpoye1HdlqAro7tJEHCl8V6lXuy66qXJIR4SG2Ox1nosj+illI8bE2MO0p+tbljh6jLRTw4wSGQ0DTMrMda9bnWTw+wjMSGjlIWuv2KHEN4MxYPcZxxGY8rUgGa/sKDpmKUa3EJyyJXlsP+4myRiW7T6fTGLwenRH67yXdVLGr35JSjB4HNthfETeSaFzm5bP3ygyNe4FN9jfzr3oGW3tYQG3YdLD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmYAM0JskdBV9UtK+jIVUP1tPacSV8AQ+lrc4wZzK6E=;
 b=fcKRMp1YY3QknZ2xNDaN9UmJ6D/3o09j7+4pUZf3qauU5klCDbGasTsmJ+QTzzlaMvYKnLzstDL8HkTmrYHb5aypVgXLtH2KYxLe8XHMsjdSUAJd1v0kIn+Ka6EPp2wL6EkWaUytbbysSvhFTMm5F6Gv+3SNOL1b3Oz0ueDlFbc=
Received: from DM6PR07CA0117.namprd07.prod.outlook.com (2603:10b6:5:330::32)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Mon, 21 Nov
 2022 00:39:45 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::f) by DM6PR07CA0117.outlook.office365.com
 (2603:10b6:5:330::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 00:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 00:39:45 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 20 Nov 2022 18:39:42 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: poll BACO status after RPM BACO exits
Date: Mon, 21 Nov 2022 08:39:29 +0800
Message-ID: <20221121003929.3296266-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8dacf1-c3ee-4a98-8cd1-08dacb58e2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dyaZ7ZXjskncIsIMSUZC1sG9NrSzZG2REsA/UpnbuqjL2zuCWDdqQR+u1lLu1o7o8ZvRFabXXGoFHfVC/u3YHezk+Ay8jT7kRV5bnVIiu+yxi7H4X8fi2U2roTADgoFjHXWAxQdgD2cWn7ZUh5dfCFoB9sJWRB9MMeG7aE75rlEoXcfzHmmfMI8NIjrgsm4TBnU0kbJQdzcu3X44icywK3+6bA3ZX0C7MBanTA0y4FEYeFL1JM9nysbQUJW4DiLnVOKv6px0mcP9zVLwQbDT3yprFEZ+xwEi6HuP4LugquzSENs/nQUvkjAoKjL/3WhAvqYfWPVxpboRYYazFYTX35/WkX7U6w0nwoSANQjrBd9yy94ifDrRbbA4HoTjy+nEufYfpQEwAJp5oca3q5bXvZsSY6KftG/IhSsOkp3Kr+golvkwQoXYGFbYFKBW1veuzZGjCuHEan8RmM/SV/HWvcjky6hYs8Zf/2AKQoJ9H2zQo1lbiXBW9LrjybTYQkiIOGtUtToZd54ar5AnOdDEIan/0A5dG6y7zufr/JEOnHA0Wn8QzhP3LqB12wLCSPRk6RYK4cIHhAIsy51VJhxbWnGaiblZwiLsTZLDSCQoXK8izzV/nHg/A9UljWal0fqGkw7yoYMoBPLsIhjzgIgu82N3MthAsZ4gR9RGa8SwYPjNHm5cw4PAosoJPhF9gs6JS0dA7ZzzUoi4OWkAaN/2+BDwmX8U/5HHV2Gqrf7n97MGh1o6ZoKjbAJ/DxZ9RJw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(86362001)(186003)(40480700001)(40460700003)(8936002)(2616005)(70206006)(41300700001)(70586007)(8676002)(336012)(4326008)(82740400003)(47076005)(316002)(16526019)(44832011)(5660300002)(478600001)(6666004)(6636002)(81166007)(1076003)(110136005)(426003)(356005)(26005)(7696005)(36860700001)(2906002)(36756003)(83380400001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 00:39:45.1106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8dacf1-c3ee-4a98-8cd1-08dacb58e2fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After executing BACO exit, driver needs to poll the status
to ensure FW has completed BACO exit sequence to prevent
timing issue.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index dccbd9f70723..796c8179bfbf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -79,6 +79,16 @@ MODULE_FIRMWARE("amdgpu/beige_goby_smc.bin");
 #define mmTHM_BACO_CNTL_ARCT			0xA7
 #define mmTHM_BACO_CNTL_ARCT_BASE_IDX		0
 
+static void smu_v11_0_poll_baco_exit(struct smu_context *smu)
+{
+	uint32_t data, loop = 0;
+
+	do {
+		msleep(1);
+		data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
+	} while ((data & 0x100) && (++loop < 100));
+}
+
 int smu_v11_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1685,7 +1695,18 @@ int smu_v11_0_baco_enter(struct smu_context *smu)
 
 int smu_v11_0_baco_exit(struct smu_context *smu)
 {
-	return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+	int ret = 0;
+
+	ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+	if (!ret) {
+		/*
+		 * Poll BACO exit status to ensure FW has completed
+		 * BACO exit process to avoid timing issues.
+		 */
+		smu_v11_0_poll_baco_exit(smu);
+	}
+
+	return ret;
 }
 
 int smu_v11_0_mode1_reset(struct smu_context *smu)
-- 
2.25.1

