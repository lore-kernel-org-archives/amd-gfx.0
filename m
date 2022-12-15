Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F903C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 06:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A15210E06B;
	Thu, 15 Dec 2022 06:17:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B9C10E06B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 06:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwB54SQuK95VrSUb3uaN+awYOCBqmP/Ep5RBqckayDn64deKHkOZbqi9cKwxgXQim9qIHb5qXvkIexdbj/0z/IQ47+I4+rEe8KWBgrXLE70NZ43Pg6vveXzoSrk2cUeO8E1BDU0ptmeFqpSRHImqQ15n4NRbjiuRo8xn0Bx2J51MhQk6enYmhell2kHuDltKSWcFXi3xWlMIplCHATTRVcdEg920cmiN/l8+HodNUKMvp+fKlKE0lior4MgoeLG5p2Y4AGc9WGNOmzjhZ0mbpcZMQctx8K+4+eW9Ua0m2TwdV549hmIPOJ1dsSnfxKiB0LgHeqdh7MPluXJ70k2xWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fS7BTaSFbAphjpxt0b3TTld1FxIJdqc+2/1oe3pMrE=;
 b=Jl/BtH9AKzNOQqI6vyiJbg2ywK7HZm6So2NahWDX5kUCBGGb+bkhzeccQFFsRI2aW8GO3cr8CbaF4G/2iRR3YhSDIyq/asVWriAxN84lzLJzMlNTGitL2vjpdBoVmUgAPyMdHitoj9vC1eaWUPZEioVY/6ArpaXpcNvE3zdz2EEZIS2f3z1et9QRtokBewM41iO3Gn3w9ADuOM6tC/9ns+hlCGwfH73Gc1x6nc4PpyisyaMtCbmutdnDt5/aSG5suFBdUlp7L2aImLahVZDxLfdC+rcjXawn2G0aKZAz8JIVlNmZIkb2680EZRYGzCBzr1YcsMf71uiHcu1DHuQaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fS7BTaSFbAphjpxt0b3TTld1FxIJdqc+2/1oe3pMrE=;
 b=khT6FqLEfVSwfO3cC03Hau5BQ9sgeq/ZVXExfw0W6xU+RzNBTrnA8K0AIh9iPhkrxrjk9pUk3IWdHnUgCE98Zhwxs9aLyIJyOBRvYCivh1qfYRhgK+b/JLxynSfGCm3JnPQ4Z/jY07S8PN0sSOuB979j+HqXA72ABJm5soXnVo0=
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 06:17:24 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::1c) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Thu, 15 Dec 2022 06:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Thu, 15 Dec 2022 06:17:24 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 00:17:21 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: bump SMU13.0.0 driver_if header to version
 0x34
Date: Thu, 15 Dec 2022 14:16:58 +0800
Message-ID: <20221215061658.3894208-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221215061658.3894208-1-evan.quan@amd.com>
References: <20221215061658.3894208-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ae978b-9fc4-4e31-ab6d-08dade640825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWvM5srWTS7YG9TQumhgJBYxZ5cGmnD3gBRKofBX7mh1TUSiEJjQYfyUBYUq97YmioOMh7IsiQHOjQ9LGvxdMhBdhlgI3mzzokCDWDcsYMqM4GM/po4N/t/gB/1bwTkGhKgL26Lw4qvVNLEI6xjH2BgTUHrOSb2de6AZAw2O3T2k/LygtK2BI0kDuuAfgWcrfHO1oKL88BRnN3gD8csPwzPM+uJ4Hf09wBVHa4kiQPo5ry+L9Eh+7THzvPtnPtaoZHMLACz3zobPeDxeopmt3y5rjDyQeiz4SAW2Tzn0ST/0aAiZIlw4dUHnlTV73yNa9rtjghPS6SfNoCYeRLQtRZF5yFKb9EKwyttPDR2+1WqML8lcVzCj/bQk0Rx7mhwJGdNFkKqKztqwQVqELRvwaz+76E3sOa+Gl8ZtkSII+ru+CjNeTDD7WHUqQkY4JPjxnscEoFgZf5R72OOEVUmybN2d0bt77ZrXwTsCoUcfGLbyxWjbGtL62ljxO+41Xktjvm+38NRbNnW88WASx9ckTujXdkNIyuWXxvpAdkQTVKyLC+/92qneYp+aQWnziOxy3Pj9FklFJrxadtu2DXB9ZZ+/8RKllH2+tb2m95ac/eWoLmtGwQexA9v4LhzNu3oTqhX0PcUd66opxA+jh5XRZ7Kov12T3wovF9asmXJFkIxPDM0SnNUv/FKQHt134Iqj10dqsl+UqzBz9ZjLXfrKAk3mD9+B2gown/H0eA10BSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(44832011)(40480700001)(2906002)(6666004)(86362001)(2616005)(1076003)(16526019)(36860700001)(426003)(47076005)(336012)(7696005)(4326008)(186003)(70586007)(70206006)(83380400001)(8676002)(26005)(41300700001)(40460700003)(356005)(5660300002)(8936002)(316002)(82740400003)(81166007)(54906003)(6916009)(478600001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 06:17:24.0191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ae978b-9fc4-4e31-ab6d-08dade640825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit the latest PMFW and suppress the warning emerged on driver loading.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia81ffdc8969a3b667454aa35c6d05d9de238ebcd
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h  | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                    | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                  | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index b76f0f7e4299..d6b964cf73bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -522,9 +522,9 @@ typedef enum  {
   TEMP_HOTSPOT_M,
   TEMP_MEM,
   TEMP_VR_GFX,
+  TEMP_VR_SOC,
   TEMP_VR_MEM0,
   TEMP_VR_MEM1,
-  TEMP_VR_SOC,
   TEMP_VR_U,
   TEMP_LIQUID0,
   TEMP_LIQUID1,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 8d4ab1da17e9..913d3a8d7e2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -28,6 +28,7 @@
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x34
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4db5f2630054..0ac9cac805f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -290,6 +290,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
 		break;
 	case IP_VERSION(13, 0, 0):
+		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0;
+		break;
 	case IP_VERSION(13, 0, 10):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10;
 		break;
-- 
2.34.1

