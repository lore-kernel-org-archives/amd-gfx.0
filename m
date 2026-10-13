Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AA5CC6B10
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 14:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1ED10F83A;
	Tue, 13 Oct 2026 14:07:42 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAAC10E8B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 14:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHXRHpehhiJQfpirY4xDYDJEfRn25JnBcDcp+z4GMk+9/fBsNw9j5g11DRfGT4dn4iGugDq2pM7mXqsBuyXMklSAhcsWj3JtPCMUqL9zLMOXPbm8bXL8dVrVSrrV5kTe/no7eSQXhHwlspvvvA8i2t2D+ChcBqCk1QH3AOM3xjxttDImwIAOPVxa6gVrYS1mkTYZeVGZhOpUxnZZv+rfIBTCblrOft0TTla0SosbgV8E0VYV1souQgBSuwB1l2pzK9M1RHyeHXotMjfySX2r6IzhUgWgSmN60mPm3hL6jbBHHYTiIPtupSjxVxSsVwul1TF/to1Wm4wKvSu7ak1c7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd/eXeomLzZ8rQUnSKOtZm1SLm9320ay4sXkMRZmHSA=;
 b=Ai5wejvCBxyuV353Qxs0qENNnPYQ31XNXzkzZ7R2R8aJyVSbZD7ExmEKnW+cqhd9bFq6KuobPZhqyjgkEzsbIUdr5xnw0X9NUWWs/BmUc1C7Xg7g+jSoliHVksXvaf4t+GXjCTujicM39+wy+0RNwMRwCpJzOWGIM/cse3W6ihrcTdL3RAnaS690G5z8iiJHuD1VTTQe+AGypI2Hsn3LROt9qkKjeP8o7OPrGZGvimtHVH0IpBnUTsSGnn7cNS7xCGbGavviIRNJa5pD6vV1x+CJBv9HDeOEkDNmW5U5xkb9z1+6q/t2lPSPRVxYWOgKrYMembfxrEffzp8HxCrnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd/eXeomLzZ8rQUnSKOtZm1SLm9320ay4sXkMRZmHSA=;
 b=R+fRu3g/3a3d/STqyKKw7f+z4SCpy2+Ot+0nMMh4sXVKZyD1p5MPgiDGmJtcvP5cT8d9xkqpaiv5wbVGcN6p9lI420/NHmOK5ZaGRKBEQzlW7J7+n5YD/glj7BX2nncRmQVsUCTTcoqRMIGZ2nPxVW01OJgmzFYEW6ym46gJwjc=
Received: from DS7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::26) by
 DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.12; Tue, 13 Oct 2026 14:07:30 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::8b) by DS7P222CA0017.outlook.office365.com
 (2603:10b6:8:2e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 14:07:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 14:07:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 09:07:20 -0500
Received: from drvdevbldsrv2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 09:07:19 -0500
From: Raghavendra Prasad Mallela <raghavendraprasad.mallela@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: chandagb <chandagb@amd.com>, Chandana G B <Chandana.GB@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add the new optc_underflow_enable
Date: Tue, 13 Oct 2026 19:37:24 +0530
Message-ID: <20261013140724.2781729-1-raghavendraprasad.mallela@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 41287bac-ce6c-4d99-3e75-08df293350fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: AAHN4Wkn/hLrKzvEhlaUTMw12ZWShcgRz4wbIygi7ARDLCrmBLvKiCys7iO0r7X0NfsSjhMOqM0wusELmdgdbSVY3LPFj7xrEypX8hAbmsOLtADFLkeY1oi9hfseI4XCixiwidibTUDAkoXmdsP7oDEsUOBsM+seYPtkvQ13uxEBw5jNSUOK8a+DkJKw4kXUKlnaDt+Z7ghQ6JTKSfShrsbt2x1J6RkYp/TSGXEDCCKkg0l1dAQXxE/VOhSo2Hd23T9iBQQLyb14QYEXqM/198zw71PTZq+Y44xgdthAIEmlULZDbHqUUzPVyT064xUv7Qgaacy6klUAX1Sq6Q9gBGzXztmw1mNT/gMoKhTvsM6MgzaP6aa2F3Ga3QYLJLS4vKwIsXjoW2ZWnRdp8/WnRFNClCzNC8U3BoHH/2wSCutkz2HOF/INUIyMOTZt1/Q9aCKqkm5lsESjBp5V7FzFQ8B54er8TMewH2kb12M3exHVLwyZQOO3138DCBLnG3ZFx9wZiICqEApHI/F088PYPCnfWuj721peOxMaJ0RydouQ5rB2rQOr0dJgcqEUbHMlo17E1/tLlNKEI8bG3+3cGzcy0DLaQeeGrpEWPiRjUmAd5D0w7pOBY0qAZYdCvcgnHKX8vrNZ8Nks6ANw+JpuRj1tvBDkOGz3JOT98RutxFYp9w80XYXAtmfVjGuzBnHL5RdPnRvp8OJ+YMuLPNl+cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BxdqwYqYyXBuTkVckPcZ1o6yB7rwkUhTPplfhM0nEwc9p0cg/u1wB9/n5nO0HkUXiJStmP1jo5zjfI/2PLwi7Fb5GdHxsfcmGrCgxEzSvgCapdQgO6fh50r8/0r03yK2fFLci6FLxbhR1tSui1DCIoETQIR6HTzGsGQUjPgbwZ10Cuj1qqim+OMiRcUtN3vx6cnvi3njtB4H1zJoZyM2K6U8VQd4m/GUeRy9kw1DDJxOt7jqBQ7OGBC8nCnKpgkDzlpeJ9CJ1fDBABIimxF31Z8JcTWKSkqTGVV5SAzAtTrETwqn/eW9PrkwKFuwAmMD+8T12n9WxXahLIjSGMO+fh6LmyfrSsPTH2lP/pvdUt1RERFtDHL2e6zzwlK7qgbum2c9n+FWV/3BtkZAx74IvqK/XJD1rt4a03ORb4PludvLWW55T2dqgN8G0EvVm0Hr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:07:28.7903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41287bac-ce6c-4d99-3e75-08df293350fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

From: chandagb <chandagb@amd.com>

Use a reserved byte in external display connection info
structure for the optc_underflow interrupt feature to be
enabled or disabled.

Signed-off-by: Chandana G B <Chandana.GB@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 3d083010e734..12c00a2072ac 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1324,7 +1324,8 @@ struct atom_external_display_connection_info
   uint8_t                  remotedisplayconfig;
   uint8_t                  edptolvdsrxid;
   uint8_t                  fixdpvoltageswing;                         // usCaps[1]=1, this indicate DP_LANE_SET value
-  uint8_t                  reserved[3];                               // for potential expansion
+  uint8_t                  optc_underflow_enable;                     // enable OPTC underflow interrupt
+  uint8_t                  reserved[2];                               // for potential expansion
 };
 
 /* 
-- 
2.17.1

