Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AF5C4829E
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Feb 2024 07:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C42810E087;
	Sun, 18 Feb 2024 07:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2klGV89G";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B5610E087
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Feb 2024 07:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAf6/lOIWvh1H3JTJEQGEFffkpQX/D347OzKIsXjj6MXITI8Gf11zEauX+oyNuM36nUrOLW9nYg0LC6bPpKxPJaXgdOC0Ja+NUxiaCVtzJrETfa2K2eZ+OtEwUO0RGeCFAExxq1HzzOJnyfbWKYrWMyw+E4HSexqm8k72uiEW8CjRUkFceo2ExVAmfXbCqAPahS+sxv6kqI+E/9tOqiWEt4UeMLD5ZfWOyLXFGyb0fbii9uSGpvewUWrCEsCt5QOEPqHWkrbjcpsQ2oN1xq2tDzi/Gy+zv1/PO41YhzXZIV9nA1amb3cNwfkjvREq/Jbhf3YknzbpuKHDuCG1Z35Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+304oB4bo89ddSXHcQGJtSsy8A5NLlMLFSo382+Uak=;
 b=Qpc8b4e7n0b6iRmhZUDmdrPOPW2ksQcsDi21JfSsKdNyBXJUNmg4b6g6ndCrueRGMG9ko9/HNfVllgOZvVXYdbNO0m+aAnSwDwRV+DzMc8Xv8xndvlSQCbXPTS7wZz+TqlNqIEdsqG+SKRW7SmcEhQG955xhOxHRUBPJnycDUyalmJcXSwGfD8VTwDgTw8PgBXDPxCnjPDf5P5AJSfEeWUEHNLKcUar8NPCLLtxRe76O076AdYxO0dVSS/oKtkFU0kgfmsF6dKequ1z0WSvX00wupf7maN582XcIEVNDmT9o44GiwuxW/K3P0+De9yP7LuLIraDm342DbEHOfNi2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+304oB4bo89ddSXHcQGJtSsy8A5NLlMLFSo382+Uak=;
 b=2klGV89GxbRo/BIdUMxEXXJ5P7ros5BulyFJdIAYPsTLyWMQVAKhTHOK92+oOS6OtnKdjt6IYEnJ11nlfhFjKa1mh4Hu8/2bGqSpIgpOV8GxJJb3ZLI30UFvYCxy2VhjSIxrCwgFql34vESFlSNj6YA3/Fkoj5dHY9MxkPb6uco=
Received: from BYAPR06CA0046.namprd06.prod.outlook.com (2603:10b6:a03:14b::23)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Sun, 18 Feb
 2024 07:31:34 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::61) by BYAPR06CA0046.outlook.office365.com
 (2603:10b6:a03:14b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Sun, 18 Feb 2024 07:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sun, 18 Feb 2024 07:31:33 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 01:31:31 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Thomas Chai <YiPeng.Chai@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Do not enable/disable bif ras irq from guest
Date: Sun, 18 Feb 2024 15:31:17 +0800
Message-ID: <20240218073117.2185-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM6PR12MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: eb18acb1-8f79-4bfe-e7d6-08dc3053a21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFkGzU4H2AuwN+Ip1/7pX0Q5ijEI4mlxeuqMNpWkiBl5xoIwg8xRSyPT4R+CYuQzfoMQhSKD759RuQsHGLko8RPeRo3q5P1ThNjJCO7P6aygrMrRncucgTM9gRPh0MSvOGDZbdJLyUi2qj9pC9wY3bMQS9IqHbmxgq2jBouwiN6RH1EORhZv6oh4/2UnK2VEGD+P1QjyR12667mxrbKpLUG9fQIujj/JJG3/KkBDT5q16348t1vhSFYtCwm+WvX6s3A4JWfJNX4xiMlRHk6ijiRms8ZhzrmYO1s92yvHCs+qDTYoW1P6OjHOMu7YYWv1NJqCfie35NTnVz+nVVX6Eh/+JhCzTAMzut998e2VM+pv3UrxybRzg5rcIps6xvwqIvS5GBFQkqMah/lwKHqJKtxKkjvoOV/dm+GYhbjGzglKzD3Gr07Mvv7pTcv6IS0+EPmdYLbv+Bj9KqKAMIN/whLsvuLh77blVmMawwMLkaTuFpBpRo6a/gNcunbal40C1Izs00K1wHKRSKQQc0CHqFd9lOPA2eOgNqHj7t2MbFJrhiWtR+CdhoSmBJ3pUbG3K4uURNXM0BG/bwpivx2F0uKp/+pPN1vS4b9IJ+1Cz2ztNlGwbx5P4bRYDGZB5BBj80iL8QYl8Ba4CEAFGc5zrGbQeNWXtFIor2q9EaZrs+Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(82310400011)(64100799003)(36860700004)(1800799012)(451199024)(46966006)(40470700004)(5660300002)(8676002)(70586007)(70206006)(8936002)(4744005)(2906002)(4326008)(110136005)(6636002)(316002)(6666004)(7696005)(478600001)(26005)(16526019)(426003)(336012)(86362001)(36756003)(83380400001)(356005)(82740400003)(81166007)(1076003)(2616005)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 07:31:33.9092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb18acb1-8f79-4bfe-e7d6-08dc3053a21f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
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

Only do this from host side.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 15033efec2ba..2c8702560090 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1278,7 +1278,8 @@ static int soc15_common_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_put_irq(adev);
 
-	if (adev->nbio.ras_if &&
+	if ((!amdgpu_sriov_vf(adev)) &&
+	    adev->nbio.ras_if &&
 	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
 		if (adev->nbio.ras &&
 		    adev->nbio.ras->init_ras_controller_interrupt)
-- 
2.17.1

