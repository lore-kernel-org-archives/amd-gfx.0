Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4371CC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21BA10EC5D;
	Wed, 29 Mar 2023 20:31:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617D810EC5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNkI+JaJdQlyJVvg1jJ2Hb/0n919/9dPQvU1SgBoHEA0U0axgCHZ7fuQiN8tKbWszPpXmyz+1VDZxPGRz1FJysX2qF5RjWoGFNEQtiWCnLXfwvcidz18vlII+aZcyhlQcuw+/KdyB19ncdiNKz6iSsgIpx243osDiYPHDkZx76r59S64oUrQypnzOtLnLuFfq9FXNBILDohMwdnXHid8N6D+tizcdQhj7wOnHfXSludid5thyNxvrdMsK6pvtiqdIbLU2KTiLEWhJp6IZsmJ9Kyv1tv5tlkwu8+fpMmac1brNv0JvCwXF3hs10wAZ9dyKuEWIjRYGWuPfSq3eW+AHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZrzumX57Iq01pcJmD0EmlLHz/QQB3P/1YbIIT+oaLY=;
 b=G4CvXOoQQ+NQ2gI/i1qMguCFiniW7pjtID5gr9FcSnsXUCN5Myh5sdbdBZ/weWL0U/H76Gd1iNhVvtIHx7Ug7ukEdSd3vXrfciZN6L+5FdRa9gQxtomz7XMKhQRmBfr0gPrVVB8CrRZO9Co/DrpY6kTe3rEnh5PmhYxsk09dZVnb1/7F+z7a5zv9xgMc94GH6AnQf5/nPTuHH5xQswFxYXQMyd3BySmYv+nYhW3S0VK3MuQqSIbLeA5UVLLrW/dZxFp8kQD/ddznLBAOgPsOyBnDtIma85oC/uzzfT0P/X//BJWxNXIJoC6TJp48dOeXCqoaSovy6T8phNQoxAAyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZrzumX57Iq01pcJmD0EmlLHz/QQB3P/1YbIIT+oaLY=;
 b=SQxG+0e4JRNRI3j96qjxehRjHPTgHgQAQLOXdmqPUutSsTYhyWWJqJxCXAKdGFYSUmUICsEPANq6DTDzpDea+/j/fL53m96n3HmJZpwjQjjpjBpPiZwSSBkReMI9a9eXEEpuAM3KDLiCAGjrB7R8fo8sZAvl2ZftkX3KFOCWl5w=
Received: from CY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:930::24) by
 CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Wed, 29 Mar 2023 20:31:12 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::57) by CY5PR13CA0015.outlook.office365.com
 (2603:10b6:930::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Wed, 29 Mar 2023 20:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.7 via Frontend Transport; Wed, 29 Mar 2023 20:31:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:31:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: init smuio funcs for smuio v13_0_3
Date: Wed, 29 Mar 2023 16:30:09 -0400
Message-ID: <20230329203009.1983616-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329203009.1983616-1-alexander.deucher@amd.com>
References: <20230329203009.1983616-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df02776-17a9-4a15-5d34-08db30948949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVmbxw/WYnXrLRuQJou+kz/+98FQRaGW6v+kBp5o1P80cArTsTHxpDlWFwgtFGRhIU4OQl1VcqN1CKMyW5Au+Tp8ftx5LgIS/R33zHaLS5q8yiZMSFVr62ieK1glxLMCc7m/iJgRchygRrIH8Q5WEyPa+nptVSWijgWArznL9lS5JNxl5QhR6qQLil9LoVcHhihPJEo/verCPTbfpBhUIGRpRXcb0MyqENS9lQ+GR8Hz+QKvlbp8zCHxrLoBIa9iVvEvaMP9fNNEb+x57v3U1RJTabUUi7mq7o8VhI9tUnfGP9sKWVg5rkQND1ZsJ6ZgvN+onWBOPIV9jI5O9WvfCb6qjZY8o+rwlmNqoHvh0U5J2NqWLdUSC+TSZ16hHZcPv0sDJYfodFwWCadwggLd+zngt3yPcCn30c5Kwr4rzv13j2O6dvNsBbyWjBlXN0mT4cZp1B+mJwCQwDcKFt4GpX6pb889o3b2w9ciLRdvsZsgy96LfFetHqD9SoiYu4HNu3I1bZL2Ip18FBDOQJXZs2gDJjqu0Mu+xkolWkN2ocFzPO6KZ2Dq8gPrfRdWuwTGwXYWeh65S8Mk44L+UWyT8sXIhJPsVBZIGsNZumhsS20anyou+yqVu4wjHEy8+4H3kUgznw2YUQxRWv/XLh2DQJ0sGsEN08RaId/57tWdsTIa6NqvCB8QDIzj/zuf/y61Qli42CDjE0wTpHW+LoUAucaXQMTWyQG/4LJRHWuK8WQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(82740400003)(4326008)(81166007)(41300700001)(8936002)(356005)(5660300002)(86362001)(40480700001)(36756003)(82310400005)(40460700003)(6916009)(316002)(478600001)(54906003)(7696005)(26005)(1076003)(70586007)(8676002)(83380400001)(426003)(336012)(70206006)(16526019)(2616005)(186003)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:31:11.8567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df02776-17a9-4a15-5d34-08db30948949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add callbacks for SMUIO 13.0.3

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 700ac74fcfcc..eea6083d5108 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -82,6 +82,7 @@
 #include "smuio_v11_0.h"
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"
+#include "smuio_v13_0_3.h"
 #include "smuio_v13_0_6.h"
 
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
@@ -2434,6 +2435,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 		adev->smuio.funcs = &smuio_v13_0_funcs;
 		break;
+	case IP_VERSION(13, 0, 3):
+		adev->smuio.funcs = &smuio_v13_0_3_funcs;
+		break;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 8):
 		adev->smuio.funcs = &smuio_v13_0_6_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h
index aec35f7efb58..795f66c5a58b 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h
@@ -23,6 +23,8 @@
 #ifndef __SMUIO_V13_0_3_H__
 #define __SMUIO_V13_0_3_H__
 
+#include "soc15_common.h"
+
 extern const struct amdgpu_smuio_funcs smuio_v13_0_3_funcs;
 
 #endif /* __SMUIO_V13_0_3_H__ */
-- 
2.39.2

