Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B42EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A794710ED72;
	Tue,  3 May 2022 20:29:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0942710ED52
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmbh7qvDotOCwOyPi8DpRgN7RJ/Sl5Aobh6QWV5NczqCHqWdsC+ykvQ+xqnAWX4HXmLeHVQUB6CN8CiDBinUZe6AQ3TRqnUJAyTPesslAR5vyvl3TTFUuwTEjIFRvx51JUAdhE0AK8Cy+M6fvjATw/Aup62wxjBNUmUqBLqNqhovAy/FKqLyovpAdIQleNOYtdwlaT8aPMQQT+quuO9WA/IBPRPekvcGEzDVftTison3hjpdeTiQOGBK5xP2bVpPXEwrPMHivrcHuBF3KrAkM5zyyYp1dTZKWu+r6O05sUZ3q+lwzycR+JOaMsImzQK+Jp/BSbwHBg1kDPb08t/zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OoE4b+pv9yczvSCXV9oX2rxkYxH4nqpwOOt9HBBgeU=;
 b=ga2QJA8bKMQLaAAn1uJRklmjAgRv2DsJEU1qBjZEj0dfJccKjqwSUU6ICZ0dWPzP1lkdF9AI4d8nSJUqcH4mKC+CT0BEeLVWvseYkKfkkoN1adFdxhtn+R1ba7bu+LzQt3rwn6X9l65ijE4OI9y5g93UOguvtXjXOrhKpICM0Bc7RZuq5ywbNuWgF0B7Ay0SAUJN/bgIbYbt7hVqvJO7+VATShwrhn4oWyflIDhoJ5sxFJR0REe7Dq5zLVcXXSqQkNEDXi7IVnMVgXb20ttfmYjB0drkd/3M1bOsr3GY3Bz8Pxpyk5mwkLi4Xo4Kq1Hc3NcQqGE8J//KLeVZIUhkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OoE4b+pv9yczvSCXV9oX2rxkYxH4nqpwOOt9HBBgeU=;
 b=0YLZQ97AhwxZp/9baSk/xIgrOJIpszCFh7DlIfFB7VODAyeXLbPBmokTGoLcsHBZrCBAR4Axho3YnJrGMnVn57qnVmUqM1O/EmI0HIBidm5H2DpTLRZhtsMXbKhlEN9BUOcjAmaQPUv3PTQSQE6Q3OcKGtEjgQbIOH5ukRrRoEo=
Received: from DM6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:5:bc::34) by
 CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Tue, 3 May 2022 20:29:28 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::33) by DM6PR13CA0021.outlook.office365.com
 (2603:10b6:5:bc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.13 via Frontend
 Transport; Tue, 3 May 2022 20:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add VCN4_0_4 firmware
Date: Tue, 3 May 2022 16:28:53 -0400
Message-ID: <20220503202912.1211009-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ffc644-6405-4a53-1c50-08da2d439f6a
X-MS-TrafficTypeDiagnostic: CY5PR12MB6298:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB629809E79F72E5593A96EA65F7C09@CY5PR12MB6298.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taoZIYi5lIBlxf5nBxa3vvhkRtA3laJeTyVPIQihYhYBxfPMrslcFN4E173T2FIXlA+NP1dUFkYzu37mQAN0oQ+MUSGWsh3j8/VtAc2hTAuW6Lm3brAmYlqRf8DfQW4xsUNoqTgBT1eg20I2u/Gkstx+gj1hDsn/pJL6HQd+3XJIMMzbLTORoHObjstzGbitzaXJeVStTuJqbc77hEet3wBGjxGGTJ0wT3SKhCAR2CYbaGBA6BxQIURTOxbaL0RSz0haKLB3IRfD76KRQm+zq7lPLX7thUwbu9ahHD9+a8ukQ6VgF7sGSAJZTvsaNF74GG5YD57djeZA4m+ln5m9XDM93kznwaXgTvl8j/yDRuXiWzrDCtAYQcv8eNpTq9GTbSGNw5EhIwIAGe4ZG8CFJNPcNijMgfE8+udin2YAkLcQ315lqxcJZtXWjSryjPptGAzHa97WCdcK8A2AkxfMX6gELj1dN+TtIHClEas2gczoHV/+njOXTc24ScHUYk4YqLAj92bUBlJnn4iYPBtjcNABtOzTR+pG847dd4FsMbZKi6GL0gG5LGi3pN7u8CbXrtnsPS8S/v5vpPDnXB1QvdAcvslbSYt5AlbEaGhPxDcUBPHMMG4Wx5djfRQXHHUx8pGbL+Jbd7mfth4q09VdHXP30VYXS/yEu/yhYVonSG0MccR9e8Xf1Cnnvyz4mhSDngOKJHrW/pBq8wmlnY7+8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(426003)(82310400005)(508600001)(336012)(2616005)(47076005)(86362001)(81166007)(26005)(1076003)(356005)(6666004)(2906002)(36860700001)(70206006)(316002)(7696005)(186003)(16526019)(5660300002)(36756003)(8936002)(70586007)(54906003)(6916009)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:28.5842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ffc644-6405-4a53-1c50-08da2d439f6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add VCN4_0_4 firmware.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 29f26db92f5c..eccf001928b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -54,6 +54,7 @@
 #define FIRMWARE_YELLOW_CARP	"amdgpu/yellow_carp_vcn.bin"
 #define FIRMWARE_VCN_3_1_2	"amdgpu/vcn_3_1_2.bin"
 #define FIRMWARE_VCN4_0_0	"amdgpu/vcn_4_0_0.bin"
+#define FIRMWARE_VCN4_0_4      "amdgpu/vcn_4_0_4.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -73,6 +74,7 @@ MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY);
 MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP);
 MODULE_FIRMWARE(FIRMWARE_VCN_3_1_2);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_0);
+MODULE_FIRMWARE(FIRMWARE_VCN4_0_4);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
@@ -183,6 +185,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case IP_VERSION(4, 0, 4):
+		fw_name = FIRMWARE_VCN4_0_4;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = false;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.35.1

