Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6904CC47DDB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 21:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C02910E0C0;
	Tue, 23 Jan 2024 21:01:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFF910E14F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 21:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMAWLp0V+VCUP/Fc949F09yN6GNyCK7R5x7b/k6wY4Dh7BIzbPdj7MvuC/T240yZfvivuKtMGc6PjI1MqjkGwomHZu7o4h1xJHB/tQJcbKMcD1XGBXEJlV/BQtr2Kv7BatMDQl5sR+U/J7mu79SYXVbx8ATHxcQnlBkca1cHrsFwqKHWTz14ssW4fo4q7af8zmBC5rgjkLsPVMaSXnaW2B7nS0QZZ0idekN2E6QaWDwCDLlTDaIPv6WaKxMxba9dhYvq/oCBuI/rQca5jVO8y3+1hYAQ7W55zGJ/9mP+P3wSPxR1wKM4R4rf7s2lhfQd4zixf2U6Tk5eMActIf4dlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0ZUuwWo0Aj+1tGHvGqy6TOcLkPJqm3KWHnDGa+s7cM=;
 b=buG7MYjhFZRaO/AGleaPVjs19uGYVIL8qgua7rj72Jh4QMVQVk3GepBOhaLt6GRlfyDOAmI2cKOnWr2SERXWFM6WHMfhRVS6HnUIXdSjh4aYLQDnZptglGJ8pjL1PmiWXCG4eFAxuPFgHulohDsdarsgi6DvHBk6mcFEXqnn/6gn8mMRM6hEOu0HqDNYllX1im+3REGATHHP+O8AQkYfH3RRocGmMBC4akIWRszHTDIgMCZx7S/enEPYe57i+PcTbVpHXUKbrEyCgqdE3s/pEqXcpH+VOKtGaia1m4fsT09l8rD83jgvGCFTVveMP9RCdmkvkVHo/UZhR9g8EqQRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0ZUuwWo0Aj+1tGHvGqy6TOcLkPJqm3KWHnDGa+s7cM=;
 b=fX0aGNjFxAucHFAf9HbAf3X5zCLcDc6TRL2pkeVSdfbXYOPGJDQr55WYtKYbOoVO9zBKD78KrWscOZP0Mk0KqQ43wI+zmTGu1D0eKd/xlL5mKv842YI2zcGYPHVSVC64A3LHFGI1BSxrx+efOx+gN3/AJHTp8oUX02FumbSfs1A=
Received: from CYZPR19CA0004.namprd19.prod.outlook.com (2603:10b6:930:8e::10)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 21:01:08 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:8e:cafe::61) by CYZPR19CA0004.outlook.office365.com
 (2603:10b6:930:8e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36 via Frontend
 Transport; Tue, 23 Jan 2024 21:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 21:01:08 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 15:01:07 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix module unload hang with RAS enabled
Date: Tue, 23 Jan 2024 16:00:45 -0500
Message-ID: <20240123210045.208152-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac0c152-8c48-4bef-5dcc-08dc1c566bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZuhPkDA1CL2tjBo347l1IFm3zoLZPxkgpI7K5Lyxkz0+ZjAaAAFHvXaQeS8s2WUK831EHvOEE7oN/lKK62z0j/J2McvQLMWQ4Yt+QOudWM10IenSbQICxywNh7zOtQvvpnpNDIZ/3RSkRnj+zjeYUVlZIPLM37pVKgVeTc8Ge9q9u42P/QJjAwlu0/tWF4J1tb/ycNmwUsjIAmm0GGxIJQ8kdP4WqqWT7Uqy1UCaQwl5adb1YI0YPtFL3wKDLV5+vr+cZRR4IoeTIWCPcgGNtbSjIVoQkyPLJj1yRD9znU+k6M+tGas4ycBAqFrETWuvJ4IC2hA+do03T6pKnzau7sAm7g6bQvTmO3WTfbIokGAk8Zzx7R4KrgC7KYGzETLEHRpeTflNK161YKI9QvQpeYtdQe1qlBfjkK6dHoAOtCZIPFz2Eue9i3uq4+4E8bB+/LnsLYDUaXhFuahbUNHt2gY02XUzoJqWTyVoA7kKiay5nDTe9CXXZE0XiMt6IkpNlvO2j8GZdvtDfUXbTywuTxzNTZV5aW1N7FI59eH/SsTT2WbH+KDy9oX38jdMIY2iX8aB0gha8fQahZ8VeMhv5a69R6aZD3klFFHFTNHc2GW/s0RB1jvRZdUUUUlgNSbDTAMylQf0/ODr7GbP/+0ljS3u7lfmp79VGS8Cq+TY7D72M8Zr4JF3zO1ay3uPpDouPeR+Tx6y1mwxdpnfRI+hFn4esZwtQUOEgBs1rGtMBW5OHn4MfNyQYV4B2eCUm9VvoavdLPOO9sIpqlFsfEchw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(478600001)(36756003)(86362001)(426003)(356005)(82740400003)(81166007)(336012)(2616005)(1076003)(26005)(47076005)(83380400001)(16526019)(4326008)(36860700001)(44832011)(5660300002)(54906003)(8936002)(2906002)(8676002)(6916009)(6666004)(316002)(7696005)(41300700001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 21:01:08.2550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac0c152-8c48-4bef-5dcc-08dc1c566bf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, YiPeng.Chai@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver unload hangs because the page retirement kthread cannot
be stopped as it is sleeping and waiting on page retirement event
to occur. Add kthread_should_stop() to the event condition to wake up the
kthread when kthread stop is called during driver unload.

Fixes: 45c3d468793d ("drm/amdgpu: Prepare for asynchronous processing of umc page retirement")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a32e7eb31354..80816c4ec1f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2670,8 +2670,12 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 	while (!kthread_should_stop()) {
 
 		wait_event_interruptible(con->page_retirement_wq,
+				kthread_should_stop() ||
 				atomic_read(&con->page_retirement_req_cnt));
 
+		if (kthread_should_stop())
+			break;
+
 		dev_info(adev->dev, "Start processing page retirement. request:%d\n",
 			atomic_read(&con->page_retirement_req_cnt));
 
-- 
2.35.1

