Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03E7C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CA910E919;
	Tue, 28 Mar 2023 15:15:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D4D10E919
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLh6sEuOAlHlWOv9cXsdDYJFbPYyP85rHgMdEZPOaVJww0x4tTawlyz+ilgYxve8sQVGF9g6hSwcUh3taYUXM4LePU7hUkTdfa0LbZvfOSP6avcJYqnGh33hcjLCSGJ5RiBqEFD+5pilG3Nkuk3TKrzVZwRHiFem3fze2SKsMW1hNq0Q5OpdVPE7brysyXtp7E4QKJr18TEoql5swn4bFgEiGq8MFAsH1Gqz5o/6ZJReM0wdswU4Z3mPn7dR6KdIlxJFucG7pjXUNVTGp0a4vFdOEIZPPgiLAIkFQzf4inZh7/XT44Fs72B7MBi5mObOcukBzUjN+dZ5wh3c6s3W1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HHIvBMKsTqJFsyACzkOCGU/08K8Xbfr04257KZlNEA=;
 b=DMJh7f02HEWMxbCYZWdrm8CyOOi6JFkxjpOFMdSlVRXEm4zY/xF4VDnO9nio+UDg/Ujo/rh2DpIC6BDU6gDrAGtJ948FDaOBMYX4hprtk/ibMcYplrFQ2nQO3neUQeUMzrmuCvml4k4FJbibeZzli+WzPQqPxlklmiWVAI08xxHl/aJCKwL+x8guzTzZXzimjWNKuOp+PHEqoQhc0+P1f/6kRvo5C1cVLIbZkb4An0JP7O29zNod2m4xZ8khBjZcRtG9gnBid/Q/DfrCAi1IVfxlIDUlnk/TiyT/rp+uPndDFwlkJNiXqXQevcJNT7f8rncOcCPtDkYok1tkHCI/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HHIvBMKsTqJFsyACzkOCGU/08K8Xbfr04257KZlNEA=;
 b=BhjPr0PnoaJR7HisNR1OC4Vy70+YfTY1Baf6+AyIrZV0sMsd4DuvrBmmQbgO+7eOjeSsEjPuYqVHVdceNOkmOUkUxvPfqmWLx3A6pqs4qPehYx9IAQABKo4TN8g5vyaP6hNnKYYDwTQg9yGW3/BOBITvB8Bf2qJ2Ks8vFopxZzE=
Received: from BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::17)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:53 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::d3) by BLAP220CA0012.outlook.office365.com
 (2603:10b6:208:32c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/32] drm/amdgpu: program GRBM_MCM_ADDR for non-AID0 GRBM
Date: Tue, 28 Mar 2023 11:13:42 -0400
Message-ID: <20230328151344.1934291-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: e22f3878-e50c-41a4-a537-08db2f9f2ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYIObjf+LAfaYQxxGMs6tE/L7vTQuAW/SN/1WSXx9uJQh70NuipEs3hDC8afdnZdOCaoA7RzpOxHMwQ37sTC/wx0DIKUTwayudQwZZaG2NWjvyze/LkmjxceRKq+K36VnIkWEsM0+jixNHvzP+wQcmJtDdLS6yp4/f2DzCVsw658CdO9xaz0I9aylC9e8aE6OzXC3YGqO2ItHN3rcPvOM9QxCGu9wVCk6CULXvB4SW6SoAi/SCWvUpAjO888V2N+FOGC4I8PdANH/iVQoJUyAT9zDbTiUvvt9EcnNL2JseKkca5ihhadqwJW+T2BQzmTFNQWqSfQ2asS26rzJr6bWZbbg3xZ4PwhHmhJNNr9koyyHNR7m0KhukiBffjNbQXq80oD3XB5h9DJFKFD0BQbZgpGjAKeaU3HMyD7YO4qy9nhIYapq2ADuRfAn3vgpnn3wdjkOrA6PcEtnzF8ZW7dN2M4Fk3yzJuZaoWYYaIHKV6t2L10Mx2zlKuRNDMALrcsRlYShUuQeZfuVlQx9eZXjL5pihynAGOoW+uHcS6UHDSxxafrnGSgi5tLlXDpUXArwDRDZzqBGs7V7gD/sf/6rUmSPlGSmXa7vjmtZezqUZNKKmdtFn74aMwB4F3r9F93u+wxZJT7iUm1eed8IJ5DKf7TIsybbRtC5Kz/AuwJfQFbinR5wEPhbzezFwtq/xusT9aYgf0Q3hvA/5NlsnB+dz9eTlqo7tjOXxLwbnpBBqY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(4744005)(70586007)(5660300002)(316002)(2906002)(81166007)(8936002)(478600001)(426003)(356005)(2616005)(82740400003)(70206006)(36860700001)(6916009)(8676002)(41300700001)(336012)(4326008)(47076005)(7696005)(40460700003)(16526019)(86362001)(40480700001)(6666004)(82310400005)(26005)(186003)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:53.4843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e22f3878-e50c-41a4-a537-08db2f9f2ed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Otherwise the EOP interrupt on non-AID0 cannot route to IH0.

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 3811a7d82af9..bd375e472823 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -189,7 +189,10 @@ static void gfx_v9_4_3_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 
 static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 {
+	int i;
 
+	for (i = 2; i < adev->gfx.num_xcd; i++)
+		WREG32_SOC15(GC, i, regGRBM_MCM_ADDR, 0x4);
 }
 
 static void gfx_v9_4_3_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
-- 
2.39.2

