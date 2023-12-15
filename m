Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E4DC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0382010EA31;
	Fri, 15 Dec 2023 16:01:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B4410EA47
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2vHOg3cIfDOxAkerT/TyfEeFhTjauadQLV3CZl1NXHEgmJO0FhrqNglCQH+ijdRYZzfcDSj3Trke+F6KgmrLodIdRYMnwMtSgyJpHakQgUJkvNw4+78zNtQNlCqHTKFD9woQiEcyKOikvldDdLHuq+wL1uQsRFbXwwga5CMrn64Vx1ayDMNSFdVQaAgMVANnOMlnyQR9OHxLpu7RV93Jj32jGPje8FC2j2eiBgxKpfu6aIikCozzZe0zGW9Zj+UnlqauGQUYN6PDcGj0LROqeWZOc+XJqLzDhLs+eoG6LenukBtgP6xX08W9fyR2UIjASpKPk/UIKQV2SWjkUTsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7js2Cp6Q4IuArXfnwEx0TNXRyzbJ0kxFxRr8cfB0Y6I=;
 b=Ry4Pw+w84cfpXcj15B8Zd4aPb9DdLI8MWND3O2yweEwdalvb1zZbNEXUT2sW5e0V4CcZJ8cCfx0nqPGNqbfcCPzahIve8/p6vX1FNW+krmY/vR8HqdCrfTYPw+/pLBbJ1csvUFw95dYAfouVfbnendK4BBCDKXTopiFGJQJ63bjKnzqM5E3p7E5nmwyRoc3OfyBGjj1uU2OiD6MkWarImrORdyiYn4y6q7abgqCbK3EqzApoAUmU/IyYvbyfQ50MJvaSkpGcI1pFfU6NeiHatSjBmtSbBFPSXTdYgQv0P6eoX6BSx+KtUWTfSvR2W7R6e5bnkqXaUCegeHRt3vFkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7js2Cp6Q4IuArXfnwEx0TNXRyzbJ0kxFxRr8cfB0Y6I=;
 b=e+aguaus4vgYKtzERKWJlJTWqn3y3pcqDEFGvtal3bxxNnl14RuFgJhMUhUbjUKnrr0GxGowJ801TBjqndQYCXuxLrkMKTSn9dUeeRfQcbDGZ4MLhz3m35LbJ0o4d2zV4O5j/k3DC/8f0I2ZWPtDpo0KEgDCTp+E/XIwFP76Y2E=
Received: from SA0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:806:130::10)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:01:05 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::34) by SA0PR13CA0005.outlook.office365.com
 (2603:10b6:806:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.13 via Frontend
 Transport; Fri, 15 Dec 2023 16:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:01:05 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:01:05 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 24/24] drm/amdkfd: bump kfd ioctl minor version for pc
 sampling availability
Date: Fri, 15 Dec 2023 10:59:51 -0500
Message-ID: <20231215155951.811884-25-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f960bdf-3390-44fb-017a-08dbfd870b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFEo9gz00QsjME60RqoOAkIjkAl1EbVXwYfYu+LWLT66+zXrjHI8h+NV0eO4pkZc34pLr4ilmrARIdSoRBtw3497klhWak1CT/3oN3jWO0P7C9hPZf3BhIiqC16x0ZiJ1ycp1W/8vM3MfnV5qj+cENG26g/UNP7Lg1yMHOfNOJS5yn6WqL4jEe3idqfGgg9wUkr8tcfDzFAv74XvExMEQhfMVT268pxtt/LcQ5Ox/IhoRj9W3qH43SGtFfxp5UBpmCp1WgYCCQF//Rt3l7/lFSA6B921ogWtH++KdVD4NrFAcrv8GLd86FH9PWf14BttlolrRoxHJ0gVHRaScrMzU8Odr/qODHWndXy4WPfK6pVcHysx3RDpnhyUv4r81uPP0F7o8axB1Lv0QO4i31PvVKxWQkraY7Hb8Tr3z3K7gdGi74HilyuPaDzMrfBbWlE0pO7Re4RYqMBLZYsmmcS+RTE+dqo2a7jswrB9t9hd4lDBbO8atNTbzzP1SBZc3AnEdhlT28gbo8Y19aLV7pilEO0azpjF3SrVfyUDpxTbTJbyyeq/UV/IA35h/3kVW1vinoTh47LmIoqIwHX7Un7RbHN5N/g67joNe1y7ihdqjwOv4gpelyrW8zvVQ0kxmwKSmU1hMHrjjAQ0jefiCd39OzDiyQEzK1EKGvQ4iBCXh1tvLQMNwA5JST06HfslmO/AKCn60YnE5ar8e3To2qK2nzLJhk7XS8CjFmMcRlqFOsmjgysYmGj71zjPNF7QLTZGf7f9vv9nySfLoWZHaQ/+kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(316002)(356005)(81166007)(82740400003)(36756003)(86362001)(26005)(47076005)(83380400001)(16526019)(2616005)(1076003)(336012)(426003)(478600001)(2906002)(4744005)(54906003)(6916009)(70586007)(70206006)(7696005)(6666004)(5660300002)(8936002)(8676002)(4326008)(41300700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:01:05.8307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f960bdf-3390-44fb-017a-08dbfd870b88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bump the minor version to declare pc sampling feature is now
available.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 1bd1347effea..62d8642d3d1c 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -40,9 +40,10 @@
  * - 1.12 - Add DMA buf export ioctl
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
+ * - 1.15 - Add PC Sampling ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 14
+#define KFD_IOCTL_MINOR_VERSION 15
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.25.1

