Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74CFC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 20:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A92C11B59D;
	Thu,  7 Jul 2022 20:11:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D71011B59D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 20:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjiOcWeagWfTiyBz3aLT2EgpnDL4lRKEBaPLbZrhVrP0uARsrzR4ugkXuJvwgbmc/hktM/IveYNiXq/HQ5gwm/K7iYB/0w1gyrlMLslpYpEiUFeE7/NUfor5bUI4wXL+PRbNRo6oWnNYG/pGIvaAmGCs+3FYvnQ+N2IyXChvLwUdiYOfID0DapY4mZbV6jU8xa2iMBz5ovrFI/8tW+PoPq+T+bgj0Lra7tyKPeTs/Vh8rao0++y3WyG6G+LbpVYbGemNUMyY2vK7hStpX+fTGkP6vGJg6wJ25xvuUGoUmjS+EqkbjkWkTv/JBaFjAVZDiK8fb8D1H2eRRHRb3hgbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qjgwi4w9l+xY/xphQzoMIE3wOGqOusXH8kt2BcVHDKM=;
 b=Fzpt3HYS3C/BN5Z/gnEvLrMVVRriJPTFION07KWbNrx8WqaIMvfFihN42pXc8rVWeyyNAZhoic8h7PPr2fl8vsYS0J/1/6Yu2jbwFKYatykeNNkfaeS4Z/Z47TUb1JETQ7nQhHK0aDPuGTHi0TadfoOE9+T7fCypDcsTlgz/NMJ3xJOlRPADXe2DQ9B2dtPvBZlJvNc7TBLHsfXDtJ7M2p6faNCfSBVte6mUPl3puyQcpzZWn8Cx90v4ej0/jLKFhKGgpSmTC0uGgi9ALoqdzXf6lq5uiZJ+gn9+v70U69QNBKM4De0T7Pp8BcKPaJGjSx/45nbHSMJhvvopg/2iUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjgwi4w9l+xY/xphQzoMIE3wOGqOusXH8kt2BcVHDKM=;
 b=rjb1vn7Ajpjnn1DRBfoPzgxG9QLNZCodFBojBdKAIKYIGnDKeUwP1G0LQ7l2J5m8aG1/a+b/8KqZRp0P7fQGnKGjsAorNXANfq3DIX+GRL6dTh56sQG0BjjkWrWvsqn+uX13tjmLW55UoExPKcEIqZIax0bfhDKqEAYp/OHCd00=
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 MWHPR12MB1279.namprd12.prod.outlook.com (2603:10b6:300:d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.20; Thu, 7 Jul 2022 20:11:44 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::67) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Thu, 7 Jul 2022 20:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 20:11:44 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 15:11:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY instead
 of depending
Date: Thu, 7 Jul 2022 15:11:35 -0500
Message-ID: <20220707201135.5070-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cdf8d4f-d92d-4846-7b16-08da6054e9de
X-MS-TrafficTypeDiagnostic: MWHPR12MB1279:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfKNBgKwAcmbgCBF6KXfGf+2D+ZTwj2XGlzvV5Q3k1lT8HPHVp8amHOZmXCxpkNYJ6yDAUbjmNRVmlTq+CC+oUj+kTthWqESVMx/36oeTD1EY/UUUmO+xYpo+IyXzNu65fhyFzb0AnS13nQCAnUX/bYV+v4rXSXAvOtd0s9LwWTxgJ4eGSaVzKWtR7fAfInnV8i2Ji47fIEpIISXQMrFvxUA2PlsiIHBQkebrRCariG7wx5FvwB9b72qhTgC8zjHQiqRtwvdm0yOLObFHvVssLpQT7pA6BYV7OVrUloxwxyTb6k2JT9Js9tDSofdZF/2HHp0B8k9FYIkEvXb8PgBUIpFjY4UwsLqz/rHQPkQr9aZfFVZCEyj3qyKOxHFAm1k14n2ZpZxHrRhW1Y8wPPgMaLOz+AP+8BRgGrXJcyqdgmPTTmIAJGg4eV/L0Y6b5WYfMPUo6MC2Y+Mev3Oid0AbPbrlOd+Gd1FrjXSqo1ZNTPqE7wVZCm7yxYxLRmf02vBK32ZqERWce9ETk/KUAO+1Y0j4g+PYN1N3oCg9IP19jSllSaXIK6CBDJabjAr2HSUF2Pg/VxSX4n4TLy4fzxzqiTxD2LZGS9wk4a4e70V4lHSfqRTJWVotu/F41dBZ7Fc5mlDc0RCFuKVRcevQhgczSGCxont6tdsvUm8vivDs7O1SheQNjlhj8ipVJ5JI63oXYXFp2nj8ZoHr7ds9zqG9RBXP43bvwUFrHOFHz5EkGtuCT7fCysUukwwc67BGOxaMXaG9bAFnQVdKLCpNDR3nQRKq/9mkOjGw4EKJluCy3lC0KpO2YYVv5GlMR6DODz1xdSX0/PI/a836bSvJm5lkUVTRACinj8dEloFz5VhAPRT0vnbjLd17Hh7Tw9tD99l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(86362001)(41300700001)(40460700003)(2906002)(8936002)(356005)(82740400003)(44832011)(34020700004)(81166007)(5660300002)(6666004)(478600001)(316002)(7696005)(336012)(36756003)(110136005)(8676002)(4326008)(70206006)(70586007)(16526019)(186003)(426003)(40480700001)(47076005)(83380400001)(26005)(2616005)(6636002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 20:11:44.2600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdf8d4f-d92d-4846-7b16-08da6054e9de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1279
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

By having dependencies on PCI_P2PDMA and DMABUF_MOVE_NOTIFY the option
HSA_AMD_P2P is not discoverable.  The kernel menu configuration hides
it if the dependencies aren't satisfied, making it harder to find.

Instead select these options when enabling HSA_AMD_P2P.  This way
distributions and users can just enable HSA_AMD_P2P.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index 93bd4eda0d94..b153c26903ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -28,7 +28,9 @@ config HSA_AMD_SVM
 
 config HSA_AMD_P2P
 	bool "HSA kernel driver support for peer-to-peer for AMD GPU devices"
-	depends on HSA_AMD && PCI_P2PDMA && DMABUF_MOVE_NOTIFY
+	depends on HSA_AMD
+	select PCI_P2PDMA
+	select DMABUF_MOVE_NOTIFY
 	help
 	  Enable peer-to-peer (P2P) communication between AMD GPUs over
 	  the PCIe bus. This can improve performance of multi-GPU compute
-- 
2.34.1

