Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84514C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 10:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1DF10E021;
	Tue,  7 Nov 2023 10:34:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5405B10E021
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 10:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr9X0PGwTw0QYQMxy/m3yop2dcp3beNxHo/ONNUxhlYHbKr4kjwrNiR3H1QNPhwbHgX14wDRwyFOYRB4X2q7lU1M44AzUMQ8Jjk4Vdt6I6EYtR+fT5zqRvNJA+yUq2QjhoIPrP3Z0QCuaY8scI/aI3s6goEwauB3q3gpCqaECOhF5yDEuZ48ZK5hBQ7lwyBWR77fDgZ+ynuiL6UJgyn7FbGbH16AOR/v6lt/HKXNkt9JAlCJbRWwu/aAlD0S45LVhmDv5Gw/xnyuSYLAtPxiwqDHEN4+lUB9JTac/cBnBGUaZvGt1xD0ArK3ekvCDFkT1RatvCwqSiJc6tSb8d4Tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv8B4khLTaiW/1f2VhU6RpLlvSUjQOsfP8s8pbTlytM=;
 b=amsDRhMUy7o3FgBbD5z5CGJFueWG+G9JTYWTQ+Ocy0lbSeg5xbCW/cs43b6vN1DZF6Ufj5FsyeEx1pELw6pCho4gLEvaquqdPpRvsLQ5F6pg8YWlXVJh7SSvFkwd9xNFjPp34+OKQZ2PPXksHOs6OdG5lSlJjRGCznPk9Gr79uoZkLX/JjRmJrQoMs0uaiPVx1JCLzhkoXrPpiO1lbF3g/MHAlvtmqpGFtASoujcsuwl0n0r3PT8PgtEA/9u5pKAliF5MDCM4DoAXoJn2Ra5dl2FqAfN9WXfs1gh8qjMgv1b0a96m0zOjeRTb+N/ywkcAV0UhhLTay7l1JVEiIEYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv8B4khLTaiW/1f2VhU6RpLlvSUjQOsfP8s8pbTlytM=;
 b=UwbRYFsH6eSl9YxD/S9UjlD6yC0HlMP+vxwVj7Ihu3JX7pzR5y7pdzEGyoHaVr99NHL13C6bS2xS1c8qYplIko29ix7tKsjdbZjzxw6jKyaCiiFLlK2tbJzj2OIud69FIREnHlDMJQD2ToMew/drVeXE/+ZRzeITP84no1xjam0=
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Tue, 7 Nov 2023 10:34:23 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::c3) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Tue, 7 Nov 2023 10:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 10:34:22 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 04:34:18 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amd/pm: raise the deep sleep clock threshold for smu
 13.0.6
Date: Tue, 7 Nov 2023 18:34:10 +0800
Message-ID: <20231107103410.11435-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 540776bb-e0e9-4d90-a81c-08dbdf7d1b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSgZ3UCCNFI5fR6dG5hS7jSHvCIInvGJVmL8rcWZReco5/6tJXS3+z1P0tNr+daY3s5WeqIh3ILPlYbzo5VMsmDSrbloAr4PdTzDbk91/097MBZvkxPGxYuRP7DD483qqyjG6g6ES5918v1OvMb3KddphwjjqV5jR0OK5hFJsw3UvR4uOQSFyCE5sdumcN7VP8MaejFt1NMJmmUew02GRchAuofsDoqxElFYYe+tPsRR+K4iyV5UjCPkIFyJy/eH0zk/YFTkMvpqK0IoMTmGkgL2mQ64KsIgZAN2sxpvYN936orlbRvYXusvhOisrFL1KasIP53x3oSTAAMybvcMUFqXDE/2/+W8PY2yW/6Ym+sdyYLHV1Pi0uGMsTUz42rLfpdpZ8C/Jc17HV92uRjVxUj8SA5mmcO5R+8mnDnu5BQDaa9H01sCRSBhQEp6e0UcUaox4+uA/mTkAsZkBNek3qBio3BeI/PgihojIxZLkf6GMHoOXgFhaWeDiA4JShtoeUiNwaevMaeAEItAICXlc8RfIAbnEnPJcy9G7vnoPKtjt68exRJFhMZQr2iRp6egOAAWH5NCsfG6iyEV4wezNUuDCL34yUEyz22AxfOrhwo5BLR7BQdyEvuoP7BpDOFjcOEW/AYXzsHFAoolGfEqKw0pNEjRXZoQKDaq2QsI7d7T8S45M7pP50flo8eh4WuFSp9FLjdunIgMzBZwx8mzJuxAXSm+KiY782AoWiDVRGnysxDh7EBL4eB+iucErNRP56nQTtOnYF8VYzZKw+MjKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(336012)(426003)(40460700003)(6916009)(40480700001)(70586007)(70206006)(36756003)(7696005)(6666004)(1076003)(2616005)(26005)(81166007)(47076005)(82740400003)(356005)(83380400001)(86362001)(36860700001)(316002)(478600001)(2906002)(8936002)(44832011)(8676002)(4744005)(5660300002)(41300700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 10:34:22.0520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 540776bb-e0e9-4d90-a81c-08dbdf7d1b14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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

The DS clock may exceed the limit as sclk dfll divider is 16 to target freq.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 20f66e696f87..83e1228e6eee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -94,7 +94,7 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_6.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
 #define LINK_SPEED_MAX				4
 
-#define SMU_13_0_6_DSCLK_THRESHOLD 100
+#define SMU_13_0_6_DSCLK_THRESHOLD 140
 
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
 	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
-- 
2.38.1

