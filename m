Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B4BCE79A1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 19:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C6F10E31B;
	Mon, 25 Sep 2023 19:52:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED21810E31B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 19:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5Fo7loC8xem6nvuVyMXix8y/l2CCuIKwA4KpPcuqFFxgYqS4jhWuSjR6ypBBmq2MsCwkxdvnR0kqabL5WkfIluWV+IgaOVgEtsk7OfDFuAfccnfBzl1a+7+bQ51ZxVYuz2iUdnU/D4ru/V18yIUpTpMWdyLCt2vewGPpFxm3Jb2RsiinOLmhcHOH11TDa1ZhxOZo6vZxNW3NybeTqNmI74WDOKOE/54CIq6ZszpbycTxw4hoGmcLWb9pDqYhSpEkf93dqthF9aMemm8Wsm9g1pLsAqN5qOC/dOYCv04NK4TDNrL+XJTwsBnx3AAR9gAK5Y4ot6om8RBjmDXVMcW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWvZhG/8QBVYa/LVSZFfRgSpwHOOxOxzImsEvfL6/ao=;
 b=gt642cS8s/zmHKLJi0duWH73ajpnMYUQmgcFqJX0Vh4rfSxWZHL2DF1S9YmuNjg8frO+Fgc5ElOAPpxl5rLyLeSJhkk8k4v/reNXJkIOMby4MDgedOyG8hq+8y+X19SChz3QmRL1Ut57doCf29VmApg2Yaf9EBAQdDVjL1g8q3Jfy5N6s++c4nPP+yOyYKnvD+7nWvgU7NrfOJBXw6kn32I0TVbZscjz0uAQMKrYFKImChSIy9LLBwrzbKKOuNIgxvbeyXnH8vgd8maT9RC7GmjL0d/FdRzWaqX3yFUv5Gk9c+lLubTsu8fKU6vtk1wxtdIY293YNSZ6e2NtQ3GYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWvZhG/8QBVYa/LVSZFfRgSpwHOOxOxzImsEvfL6/ao=;
 b=4c+CeUrs0Ai5ho7zvV3RnBaxMs9ubP5roDLWzLiVw3gXj+yao+/GQFPYdwlvSMfcwTwDOMu0JzQzfwvxZrF2vQTbGCiCVEts1A4DU0wL1REa5F6FCp+o8CjNrXnk0Bsl4q6pjCxed0abmJ3vbBn5yliAco+1LQMnb0DEUyFgxe4=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 19:52:48 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::9a) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Mon, 25 Sep 2023 19:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 19:52:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 14:52:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] Some cleanups related to missing microcode
Date: Mon, 25 Sep 2023 14:51:59 -0500
Message-ID: <20230925195207.124850-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 1360a2f8-50b6-4e6a-ec5e-08dbbe00fe2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WC7mb1htOvNZJNB+YM3d4iaMpQGrSWl1EVrBKnVgcG6x/DiaBdrq1JbRHERchFheBl6yDRBh52Xzpy11Ie7CJeXY02gDzQ09bY/xpG9/+TRujqm5oeN41u+XTXukQRcfB4j92nlv75rd8mMqJquOw3MpSkCKu9aJwGep2B1QHELzs5/bL01vcULYWxtZFCv6iu9AqZE+f59/GNgaxhnR2RIEn5vNRnW7478/A/XXGa4iBLYt/9P4q386JRP1ZC2HfWhdb8kuQ0TaUNazIw+XB2DQDOt/U0pti+2qe4UzMO8EK+IiYaiRXpzQO0QkuiShkHPuEkZDeFzDjykrvzCyid81vR1ShIO64RzguXvFrt+9jQWsqnL4abKyoiEZjRtSVa++MFP3lhOWmH0bTkyDn9X7ca8vJ8h8MP67fIWiVZd+7kU6m25DuMet0FQXA10tyVk1Xnk1w9Yodvdk5fJR8ky6OC3PzKWj5NYHl4LI1upoKZH9YsLNfLtYCv3pGcbX0rTPKYawemFU2g3lqwEigd1jt81jo6mCicNyei8ILaXxDhZT/aH8lfjYDkTcIc+aV01UMoxedkP0N9OMLlDuNBLsCiTP9nViDJFTOSfTATTFkUQysi8+jqqLY4umAF2L2m+fABOvqsLY64zBze7OXT9MeKhy9EmDpdZf/xM+Tw4AM2XiZXcnkoV/5FIH+eInMXH0JVfV2OUG/H1kpvS61oxW9LVL62X5E95sul5xVc+T4R3Kjc9733bNODxsYqn57x65sGQ0BK/jhvj/rE6NKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(81166007)(6666004)(7696005)(8676002)(2616005)(47076005)(478600001)(4326008)(16526019)(70586007)(83380400001)(336012)(2906002)(5660300002)(1076003)(316002)(70206006)(6916009)(426003)(8936002)(41300700001)(40480700001)(36756003)(36860700001)(44832011)(82740400003)(86362001)(26005)(40460700003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:52:47.5285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1360a2f8-50b6-4e6a-ec5e-08dbbe00fe2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
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

I recently found a noisier experience than I expected with missing
microcode.  As a result I found that some microcode wasn't being loaded
in early_init and some messages were unnecessary.

Mario Limonciello (8):
  drm/amd: Drop error message about failing to load DMUB firmware
  drm/amd: Drop error message about failing to load SDMA firmware
  drm/amd: Move microcode init from sw_init to early_init for SDMA v5.0
  drm/amd: Move microcode init from sw_init to early_init for SDMA v6.0
  drm/amd: Move microcode init from sw_init to early_init for SDMA v5.2
  drm/amd: Move microcode init from sw_init to early_init for SDMA v3.0
  drm/amd: Move microcode init from sw_init to early_init for SDMA v2.4
  drm/amd: Move microcode init from sw_init to early_init for CIK SDMA

 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            | 11 +++++------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 --
 9 files changed, 32 insertions(+), 44 deletions(-)

-- 
2.34.1

