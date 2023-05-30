Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AA2C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 17:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2C1C10E405;
	Tue, 30 May 2023 17:53:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F82A89C28
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 17:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHXyQnnX6LSCyGXz5grsINxsjsLZmcWyFLT8wQHMxFBdrmJWgoO8EgH+LS3E25sHQndTKUzJARc3CFXvphRls6qhvWORX6oYVLcp250fG+GfHLghfIMciGqSY2km0tQyPQybudJvVrle0ygfAQP+8X8dsS8CQsTm8o6/snD6hDIVoH0W1ur3/CkHzgVOYXl0DfRa7qvSM+hUToSINbRX2ktpveKB25/BtsmEIr3wbpkOB/sEk/cLEK2k1R1j+nUtbHvDwC5ZmfNvHvN4TXXyAtvemjzqvHTAV3MZmEUFN1L7KhQNdq48oWC1ccm7RSeidC78IZ+RfhhMXkk1UXQtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oemFuKZWYqEevetgVkkMrn7KObA429IV0i03BILUsyw=;
 b=W3w32/G7jo9wkxKcwf2JZvRihqwTKtxmK+R/a8czWaF7PGyGbs5I57FH6PG+oLha/uUOSXqGgQbnxVoEQhWBvPGf7djc/sFBSuV4jUeKT9w/BkQBc5JGqrmJ2gVOxviCKvhOC3352Ee6ivQtGd42NGSq9YTpOHIGnEVUMaB7aGxbM6LZ2iyaWp73AL3zTJXXqXyus7cWY+yZ/sV30K+Gnr5yGAvW743kWswvm8aQiVJAMtPJp6Op13OWdcOJYp1db6Xp/KNP1I2MuACbFn2FQuPxsEAvyIz9AeTWKLOYxBCepDcFjsCcT58JbdRF2Io0RaDYNYqDAXQfm36hjQh9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oemFuKZWYqEevetgVkkMrn7KObA429IV0i03BILUsyw=;
 b=CmWriNmZ1Y2Di9Z4uDH7X8B0Hf8HcsRsldHo/CNGhmreukIw+ql6u6sTb47PSMdD2xvjz7h8sqoYAPGVFQYgS6eRe1Kty6/htq+YYG3lU689dWYtpJeWPwvfZhBiEqNs2cfuLtSRCzV00iSg/O14PBIdrqI2lSJYnSYO+JipoBk=
Received: from BYAPR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:40::16)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 17:53:33 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:40:cafe::1a) by BYAPR04CA0003.outlook.office365.com
 (2603:10b6:a03:40::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 17:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 17:53:32 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 12:53:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: Make lack of `ACPI_FADT_LOW_POWER_S0` or
 `CONFIG_AMD_PMC` louder during suspend path
Date: Tue, 30 May 2023 12:53:01 -0500
Message-ID: <20230530175301.231070-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530175301.231070-1-mario.limonciello@amd.com>
References: <20230530175301.231070-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b75907-6a9e-4d0c-229e-08db6136c8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ik6WyjQOp/2UvZoyzjkY1gWmUUad1KXPLRbie7EX/9jT1KS/uqzwnzMBe1LVuEXOQf+mlVl01Y8I1uxIH6vF8J7oNxf51DAxDNUKeLtKzokX0F6jnsM3df7SKS9OQ9qs15eyt/yxQ+Joo1EUHHl2S3ndPi7evODc8qFQSekAt1avcqq5AcRx3UbuQbeB7GYdMYHDW5IgRJ19dYCo6nfj+vaSopSE0o6OpggIIHx7fykgFEe9UAu+CDNKh5iyuwepcWglMcRPCUPa8zvplOcFAH0S2mATXRMUUUN99CTbmAYjB3LnhFj9c0moLPPUQ5wAUeQv7Fqr2qZKzLj9+VUfzlw9MZKTKpImd2y2MA2kJJV72fLEuz5vb6phRXxibx4Fz4/tCc63PvjqYTMBh9TaVpNKBSgHFIBRTdlEXR8Pla6ZfEloC9ZlSfFDJMRw3U9T0RMkEX370m8ckvU4pBkhLjlq+Xk9euL/jSEAxyfrHx/vsQf6JrKCbAZpMgAAw8FVdkPS5gSjXSYVKpaNIbq54ox805c2blbO5GdsYtBFZ74IPAOhQfyWT0spG9CCgGu+aRD7AayZANSujtUp07ZcLNd98wAvIeNk+D4T21c+KKTxFXJI7HN+t7V+f9UlkvBmIimQ7a4DsppruoV8v91z9hjXsjNOS6Fa/4OCa30+OA47t6rMJF/bO6xzXdCB4osAd/h/e0n2MJ0321NFmfhwRwkivZTHRXUz2mRtPUS/3D5ltaSFO/UYuVf7o9Ynqe0uDwPCfJWZWlZGD1j5fWZhhsq+eohKlXJRAMFn8wSJUGQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(966005)(426003)(336012)(478600001)(83380400001)(36860700001)(40460700003)(40480700001)(47076005)(5660300002)(186003)(16526019)(6916009)(4326008)(7696005)(86362001)(8676002)(82310400005)(8936002)(15650500001)(2906002)(316002)(41300700001)(82740400003)(81166007)(356005)(6666004)(44832011)(26005)(1076003)(70586007)(70206006)(2616005)(36756003)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 17:53:32.6504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b75907-6a9e-4d0c-229e-08db6136c8c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Users have reported that s2idle wasn't working on OEM Phoenix systems,
but it was root caused to be because `CONFIG_AMD_PMC` wasn't set in
the distribution kernel config.

To make this more apparent, raise the messaging to err instead of warn.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217497
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index a3523d03d769..f8b117afd5b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1508,14 +1508,14 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	 * in that case.
 	 */
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
-		dev_warn_once(adev->dev,
+		dev_err_once(adev->dev,
 			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
 			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
 		return false;
 	}
 
 #if !IS_ENABLED(CONFIG_AMD_PMC)
-	dev_warn_once(adev->dev,
+	dev_err_once(adev->dev,
 		      "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
 	return false;
 #else
-- 
2.34.1

