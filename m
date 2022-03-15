Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA90C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 10:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69E610E328;
	Tue, 15 Mar 2022 10:26:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7522110E30D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 10:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIcvI1U0iv/16GW99Gs9HmzLhfzaBsiSzcZx50ML1ghosXNPyAhUmI9CJymgpcTOJOfyk+ltgB5i+7ztdGR3TKa3/kScV5vuy6Rbxq+ujO5d5mjWS/yPDr4M30S6oFZoXsa/DVz5h34VEdcPhRwKMlLfxAbCcMPuGG9wkJc88QTNrW+0TdflLofvOZaSMWOzJ/tDkgIa0ae7YnZa05rWDgDfz4RP+5r34onaitiotPs6LKD7X4coQTx89yV3vCx5ZHh4sDkr+Le26zetSL79JDi2YlSejdVDOq3hx5vLSFokvvtvRaHxKDLW55S0fJvZ582K2IGcYkX79/a2Q8opXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZxQfDxzFys5MSelKtT6pG8psrE9k0oxAamm1dva11A=;
 b=J9Y5ZZrDT0Z2G5FzGH4480C5YAeUx3J+wZSpI6pW3zV7JgWpw9G8q+Ib1tHnl/xDyIjXQ+J0R+x4UhnQNwBVZGb+77f6IE6l9Lb0te0HlHUT+fjdSoEhgh1L84y41FefdTxCtA4yZ2kT7EpWDh6Mn8qM/jN55O7TMMFX9Kqc5oSM0Mad/zFAEkfhoojF7fKnm8GYahUUzOHdplDesAamglM3Nsv+tTK0QRG/DMcP7YCQ7TlB4nMw3035J3+nM27/zXB8NqIo2WQzks7po/A/xvKDsDtaFeGY+6G6nHPFYPvJ8JcJagsTGa7de18cNgjfmfmKTiJJYDHkFnFlljerRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZxQfDxzFys5MSelKtT6pG8psrE9k0oxAamm1dva11A=;
 b=DeimJTwZlKsfyMDEFcKNlBUv3cCmdT3uj/p4hHxe4LdpiTEhdg1VPImzIFqY7XgVvpLWjjtrpvwvR7HVPW+xrBYFrFuWSCrLsLqeK54wY7ZDgbKjpIrUJRvY/zWYzpNzEBJOF4eLZ+BZo2EGKp7sRdPTQhlNqgMXrOs3XFuZaoI=
Received: from DM5PR13CA0068.namprd13.prod.outlook.com (2603:10b6:3:117::30)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 10:26:31 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::85) by DM5PR13CA0068.outlook.office365.com
 (2603:10b6:3:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Tue, 15 Mar 2022 10:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 10:26:31 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 05:26:29 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
Date: Tue, 15 Mar 2022 18:25:51 +0800
Message-ID: <20220315102551.3581234-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d00d1f-6302-4787-f660-08da066e45d9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB503901691F1C646638C46AAEC1109@DM4PR12MB5039.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCJDDvcVaO9ZaSy147Ei6XMYfW+kPf/WoWXHvjxneZPO5gUjHQaD0rORDTNxko3LLzSkupZdkDKnTUaOnIet8SPp+5LHWE5QgRJFq7sDeHIjI676KGSMp5Nu1XnjWwyZwqTbyE23ET7GRu3W8Ywi0/iNNTEi9DCZ6txN2RrHjgbbp7IGhciFeIKlADxIyNGfQ+kimbb3Da97+PkXygf16jUsNKA6vXJgFYWVvlsUChzvAIbtvhaavrecOGfCjhlbgFjS+Z9xDLObK+9SYZ1KgkJOtNQqlJaYciWqWA5V39mzzUI1KxCiovIklDMuLryxB4BUzF3DlHrORAObM7PDNS5DivLBmmWgPiE9Uij6Ki/BBj05K4wTZQzCHDA+VJNwNmx3PF+pKIWyM7jrtnzQLzcYdMWMO1PjZ+jMv+68hjwi/3GdzNWh85fSj+PEbPNL/zeb9pZWujkCX+9C6EfkRtg+IMz+4HHfI7IDrRtaGTE7PDgjSGqniXd4/5uLNzddrhXa/Kp1CdpOLnpDLBIpqJmy3EGoKv+PzorAqEvYdf9RVckxEHGYgZNXmoVfhfRYFNM5dJdkjy5tUMxxLFH3wyl7CcmNiGwNXynh+9DnfT5pk5dVieUGzRajWao0JZWEyrGsR53usuv4xg3pPuMi7RiNgU4WJ/7dqpFm3W7PRvvQZEPi7rFKtGIQMmfQfNQVdhCt2jZzsEgb+vo+XULR3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(86362001)(54906003)(6916009)(81166007)(356005)(316002)(83380400001)(36756003)(186003)(1076003)(26005)(16526019)(426003)(336012)(8936002)(70206006)(8676002)(4326008)(70586007)(508600001)(6666004)(47076005)(40460700003)(2616005)(82310400004)(7696005)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 10:26:31.3334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d00d1f-6302-4787-f660-08da066e45d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GFX DPM is disbaled, Stable pstate Test in amdgpu_test fails.
Check GFX DPM statue before change clock level

Log:
[   46.595274] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:02:00.0 on minor 0
[   46.599929] fbcon: amdgpudrmfb (fb0) is primary device
[   46.785753] Console: switching to colour frame buffer device 240x67
[   46.811765] amdgpu 0000:02:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[  131.398407] amdgpu 0000:02:00.0: amdgpu: Failed to set performance level!

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 7bfac029e513..b81711c4ff33 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -991,7 +991,7 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	if (sclk_min && sclk_max) {
+	if (sclk_min && sclk_max && smu_v13_0_5_clk_dpm_is_enabled(smu, SMU_SCLK)) {
 		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
 							    SMU_SCLK,
 							    sclk_min,
-- 
2.35.1

