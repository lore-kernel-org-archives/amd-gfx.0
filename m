Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1CCECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E39BC10E38B;
	Tue, 30 Aug 2022 18:40:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D102410E36F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvXSo9nyE7CpbmDCA7B8Twh1gFvHNMrvJQaymW1VgZgbYN7I6O4nJJSOta58cWfiEBBIVqwrHAy34n/9hnvvaM15oFVgV28SCAz/JDNrOE0FD28VNAfWNQAHtgQh7Ov3P67TgR+gD2Kl+KI/iII53exShCLdi1Ohs4ySeShc1Z3YE8jNywRvVE9N4Bvqu7hQl6PXa5TU6vYqxNJiQAjkbuhWr5qc9yZOVHhwMHnW6KbLLEREtchC18tY2z08HiPfRNt5rgWc/9UwB20zwX5ab2lgVoTOO9B75iygWpy7T7QI77NA1UFLjIM906qcyMO1pUF6bnSRBxgC07VG1xldGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X1VB03zCR60ehSqPGDo9wtYXBU/Fx8ojuOZlJsCJLc=;
 b=Rvwr5dRphxyfPaiaklDjmGqCt3VSuM7WEc0/VKgL5f0g5tVuLPyy8z8yDEXk/gV0R0jlytpLGQ/YO2T76yaCFb76G82WqkaGrKswD99yE9RUfysj0xYQrKAAUBo0mJwj1kjv4UagqiEi11Yy7dYwZOuGTLxmRb5eaqQeKI4M/CXnoW9VqP+0Ow5g1Ktm0e5Vva4yYxpdu/Vuo/BYOsLIbBHgBqOBvel9tXCnR9QGcvzK98jej2LzOGrUQV02p1HtWdCW7o0zBy8Fp4SD8VPcVA23xI7y7pm/ZUhV0tU7p9aiB2Ytw0CStfwjJxf5HACKWc0oPbuRoN6XouRleSAYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7X1VB03zCR60ehSqPGDo9wtYXBU/Fx8ojuOZlJsCJLc=;
 b=HfDMY+uIFwDe7oBBTFS5tBrOp8Gs6j7mteH9YM9minKAKTtXcwBeOlwVzI25kDO149I5nnn/yftpf8VKkFPYzdfA19XAihOwxcMM6GHIhFRev4QSdBRMvRllANylbijPR+DGhoOhmpjjI5dZpy+wSCI2bV/ufn0XV8tGn10RHTM=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 18:40:28 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::82) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amdgpu: add a compute pipe reset for RS64
Date: Tue, 30 Aug 2022 14:39:56 -0400
Message-ID: <20220830184012.1825313-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1052e039-8367-4913-f9c0-08da8ab71c74
X-MS-TrafficTypeDiagnostic: MW4PR12MB5642:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPUkrUXo7NTZKkyCSCmXznRrFyBF0Z3/irqcSZhdhUdGQ71KwFTFJzY4NHsfKJfQe+K/NldWHbBGoHFpATN0TQST0/hdJQRk3z4XU7wu+u8Bacw0HQLgbhNk4S8IJEV3z5VNpQTcHJE5Xyc1swz1xDZB1xGkhqTciPBiL2VKKKzJCfoyQ8tHyqz/YysN8FegNIuIDcSQOLxHuo8agoMNH1/sQhTiT+khIoJBiJwra0B/Xg6hlfeGllR0Kx5p4jpi+wm9rkO4epcmgXwMAZ0fWGA/F+Np3UsF3QgcsoqXZvewMAeQG6oGxmSLSs/GMBQMP9CiB5NRP7a/iY9cj0rU8nb+wKbEe7YxSNZVvoDkmS0+SVPbqz+TKHfC9PYbzEfi9Kxh9kfQmSXZfbqu0twgiuWv0kCz8EZ6bVcko0E70/8IJQ3iInfLrcjSBQqTgJYCqF78CD6ZUHPJiyilBcpsngJhwseUCWkHhsL1QrJ5DwNRVijTqTJS4t5XJd3q5MoA2ZtUvEAqi5dDty5v8jiGYvwEXm5uz+uw2A2bxj04vzxLl21it/5VlNcQfKiJKXGO2aLtLzrxx+iUShlX6CfK5aMie5wnqNIENcqyEmxlHeQgCQ0A+OUfYTYdM4SaygYCP6WtZlFcz9k4FshT7GyDI6zLurs/+/LeyvasbXYFAnS28mcRw3Fh7C2qY/3pr8xe6x/O/d2dJwmCvHGgZZTFjP9kOfBaBFmXNLol1l+s2siOoiS1cSUMZv8kLc9iXGCtPPLlcdy+J9PxwsG4J16vLhZ9uj7JN5MpvScueSzovmsnNyRmk95qnSiplV6rddyR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(40470700004)(36840700001)(46966006)(54906003)(6916009)(316002)(4326008)(8676002)(70586007)(70206006)(86362001)(8936002)(36756003)(478600001)(5660300002)(356005)(41300700001)(81166007)(82310400005)(2616005)(7696005)(2906002)(6666004)(82740400003)(26005)(36860700001)(40480700001)(16526019)(40460700003)(336012)(426003)(47076005)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:28.6485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1052e039-8367-4913-f9c0-08da8ab71c74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Horace Chen <horace.chen@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Horace Chen <horace.chen@amd.com>

[Why]
Under SR-IOV, we are not sure whether pipe status is
good or not when doing initialization. The compute engine
maybe fail to bringup if pipe status is bad.

[How]
Do an RS64 pipe reset for MEC before we do initialization.
Also apply to bare-metal.

Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f2d126b110e8..fa718318568e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2725,6 +2725,21 @@ static void gfx_v11_0_config_gfx_rs64(struct amdgpu_device *adev)
 					mec_hdr->ucode_start_addr_hi >> 2);
 	}
 	soc21_grbm_select(adev, 0, 0, 0, 0);
+
+	/* reset mec pipe */
+	tmp = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE0_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE1_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 1);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
+
+	/* clear mec pipe reset */
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE0_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE1_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 0);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
 }
 
 static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
-- 
2.37.1

