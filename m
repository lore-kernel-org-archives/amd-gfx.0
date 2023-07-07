Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82931EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 19:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F073D10E057;
	Fri,  7 Jul 2023 19:32:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 013BE10E057
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 19:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n848y8uHb910dDWLoLOPZG0gLo1v5pxhiFjL9F/F2b1Cw/LO2cSr3Jwj8pV7irAl0I1uKXStZtB/deBb92dJoYcsHYau+b7xvX1IViaWkKrVNNKbqo62zpwH6XAlO2chergCYSCuUs9b4z+v0deaU8oS9trgliNTPVLE3UIAtWRoHYO4xBBMr4v9pbmsuLEm9BRZplB2ksZPmifK0KENgY5mZBxh40O3ExXB+1ucxW3ED7NQWiXpQJ7P5y8fQ+9c5sTw2fpJ34WqPkE+uvdBuRSAxATV6PW3GuP/366DhNvoiOYga+yR1bobnzWFqSjapHgQW+hYivQfI68T6mXAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHOVRlZes2WMuviFH+Ap2vZ84j94Wd8MonoMJmO6ubI=;
 b=QaBH0o4dWsHL2x52eD8+/6pznVJD+FwzzSvz5CqVYm4RhlVPteFj0vvgy4nnsy+kU6Hv20FqSkB0CVJa19DVVnp0J8bnAOj68bDZmqJGV945d2u/y4/LeulqC1Hjhy45q3kEyFBl4MMBvtCF5VTW8JNW+fibjXKT/TNPrvfl1PBQV8DflQ7oR+9AlbWVHio+eix1jrRPhuHNpbq17O0NGFWjuIvaTg9GS6OBlxAeWdJU4p8ToeubdxpEwzB8++HBlbBlNoSPIdTkATvmtLv6cUHrXoX61b/CJ5kJTI/phxElkaaiPAb3dy0dL0GRQpednfTTqAzdpvQ52+bmWPqPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHOVRlZes2WMuviFH+Ap2vZ84j94Wd8MonoMJmO6ubI=;
 b=GHP/zKSuLJFJo9gACJJnnf6XRpltvsvsborEfgRNYDNQgqc4Xpe+F28AaZw9ZZvXkxneS+NEp/TjPruh2Yig8kPvSy2okSUp8XNbCZX81mWM8KW9uIv85DdfcPB+IKg+3IZT9cORjmh3SbfAQq3bMgpL6k1Dj/ZQvhoNCFOP4T4=
Received: from DS7P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::6) by
 MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 19:31:59 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::90) by DS7P222CA0010.outlook.office365.com
 (2603:10b6:8:2e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 19:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 19:31:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 14:31:57 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] Disable dynamic switching for SMU13 on Intel hosts
Date: Fri, 7 Jul 2023 14:31:33 -0500
Message-ID: <20230707193135.16716-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: a0413932-6455-4228-06c7-08db7f20d499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrNTpBUL/euKLsPfH7cVOx+e3CbBMoqV9+dh0h1gKezS+M0KcSPIoi9s6vLs3KVAIXrkm6JfPpyL84gRL6g2aaVU0M5nyv6FJOMe7NY8QS3wAjsH2IjQOZk/sgKhqvZYXx3WGQN1ukq3yKEr2kiLTsqQtXSQ2QKgBot0kArejUGxxwARZU1R6O1V2+86G4mPL2J5Cfwo4z+JAlVvpTyRIuvTO5fP3DUADGhC9zVCGmHekoWdVR+2a816Xoh6oG3Eqvt2pxOwNM0s1/KrcZgkyPhWI6yB1dfzRTMjBtfui4rnkleofH0Uqlyt2WOy7januWun97AeHv56h/hTBydk6M/5lAu2k3GIKoPIwJjSgqfMPB7/1nXf0uNBIh/iC/bgue6xmQO75jkaX43+x/6+OU2iZbm+JztupIqMKwm/JMXha4X6f+J+HbTKAHh7HsmjczAugpx5Mi6wC+dkSeNQd8ny227wTs+joeEBnGQfYG7weLnJiFlvKi9G5bG6LiqdrV2YsnWWi3Ije4laXxJb//3HSSoKSUX0Afy83M0yX0vTNXEMMWphsMNXTiGqSCCXYe6r/USoMw0J8rf9Tpz50RQT+N5uYLeNqKIId2SW9R28K/aDW2COrmvT/qKM+AsvPn3wtUHYl87C+FW19VWOZ916U+CcGor3aA5l5JoORGCxUCat7g8SdTJQBi0414BPtPuKryoy0wj5gLqeaEFClwhKSWA0thhYnXyUnrA/XiL8GjxfLQcgqhUiOQDHup0L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(6916009)(4326008)(44832011)(70586007)(70206006)(41300700001)(316002)(8676002)(40460700003)(5660300002)(86362001)(82310400005)(36756003)(8936002)(40480700001)(4744005)(2906002)(426003)(7696005)(6666004)(83380400001)(1076003)(26005)(336012)(16526019)(186003)(2616005)(36860700001)(82740400003)(47076005)(356005)(966005)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:31:58.4755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0413932-6455-4228-06c7-08db7f20d499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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

When ASPM is enabled, DPM is used to perform dynamic switching.  When
connected to an Intel PCIe controller this causes malfunctions.

Identify this combination and disable dynamic switching in SMU13.

This series superceeds my other series [1] and fixes it in a cleaner way.

[1] https://patchwork.freedesktop.org/series/120245/

Evan Quan (1):
  drm/amd/pm: share the code around SMU13 pcie parameters update

Mario Limonciello (1):
  drm/amd/pm: conditionally disable pcie lane/speed switching for SMU13

 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  4 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 67 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 +--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 +--------
 4 files changed, 73 insertions(+), 64 deletions(-)

-- 
2.25.1

