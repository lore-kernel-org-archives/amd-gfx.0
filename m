Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3CDC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2320F10EFEF;
	Thu, 30 Mar 2023 19:43:00 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6BAC10E2D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv4t0JsCnqMHwMuhMTh0l2ZSgGxR671qDC64XNLDgP9hVvn4bqetE2+srnMoRmI7JsSvOcrXGahpbcU+/rW9qTfW7hNY/Uho5t437JEifhe9CsKgnWJtnnV71qMSTtvyeJWZVCJ63GPTW9XiT8P0Y/5LghlXo36oSOevds2WhsyBfj3o8RoMINYuk+CMD9oqSxd1euOuWPO2PaSNgzxOYtdFjpmUYhKdoUGlupyLkgurpHSqN9IPE2EK5yswxO/o2WHFplfyoOJLbse0dfOBIEcTOggGonRR5N99Ii3+lEjDNV3c2gjI85bwnhmMyrb7SwWu5yDzWwTsg2w82d1NYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tidbJN5xw4mrplSVujrLZ+N+Aelu8CnDArfeu8/K+pM=;
 b=CiJLBl3p4BFnCf+Yc4WJ6tkiq73EAOvgk4MofnwugkwP3e03G2p22ExqbEvC9UUVYUxcA1ylA7h6h3USuGwM4Tg+9/N4atO+N+koZudtJHrLD7ZPmFNuOYgLNFZa1j1u9NMgqxeCk5UAC5itTDNLWmdSM6bWc9UV3U3RkCNP5XA2aS//nAR0UuaLQ41M3HhXyrlcRiHjzoeFX7KBW73Ojj8KOfn9SrMcL1NppaOZ8jShvj0EBaT+zuGaFel1Olw+3aIOy0m+yOOp7Fcz/gCgKq8tv98HXHRwOURiXlnoc755H/5FfDrs49qxyIICunapnuRQU2LMMTICWvS224y+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tidbJN5xw4mrplSVujrLZ+N+Aelu8CnDArfeu8/K+pM=;
 b=at4f3FTh8QAjSxf924AwFlAi/I2tb+hbo/7KwLBaZHRyjlUVF1R7pwq4IsycBS9JmMwGFY0bP2o9wHX4l4J5W8kub4SpjAedGng/V7uPHcUkZa0w4UqMOuwahIMOvGWF0qZOroUzuWYo2mxYkzYh0Qb//QlH3hrFd1UhdEGwEF8=
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Thu, 30 Mar
 2023 19:42:52 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::46) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/23] drm/amdkfd: Fix SDMA+HIQ HQD allocation on GFX9.4.3
Date: Thu, 30 Mar 2023 15:42:18 -0400
Message-ID: <20230330194234.1135527-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb2aa8d-809c-4753-a7ba-08db3156f35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnb6WD1NpOS8/yM6xDrvuTI1ByZTlInfl3pSwNPyM7PFj7GatfibkQLsNfBBx0usbobIURWuFHovCKGo+2AKySGPH9vHKQSXQioQpuGpaOWJm26vFERfrm8wi+0F407/IFD4KmaRSZqSUzZRORaZwfhmwCf5w2dbSC/e3MfogzRezgNGlpdPoSvtzXWu9/ahsMxdsIE7B1XEbcy+QhLSU+bOkFy4ghPHys7PidWv/Efdjh9xvyOTjQyNOYNoFyaki3ofWoKRCyWDtWWDtOu0qYUVVldl8PSWWGAGwGMPo8TifxTg9cRceMEbJeDQIvPHeueW5vp5a0b6ljR+AvPHt9gcLojo36J7957019Q9qrUedDhGJDGpU6zrkOrN38Gh4d7O2Ch7JwSxMgv0r7MnwvMM3OafJpZrwL/qz6MLFFz0QJ5ncCfBOthcePXFla2QDAoGVkpjP3UXz9PlXah6kM0uxxeVe5e+UNwNQtDqk1IZ0GMNY0Wi85A0AqsirVlAx5lDWFuwNatTCb6zysR5VGQdlEBnSz6960kbR7p303iyJXmVI1S7UnD2wPbDrdsWVEhzDpFxgfNtuPRr61t6QVvTDHMLGU/qCgGfXzmuaD6p1zoG572m9C9OPDYc4AYATMbJDjZ9mS6GUZkOXQsYhsHtHh6SmH6/Z+6Khrdew+KpWZrBsvWw8dm+08MbITEqp1fSXH01keW3DqHe/H5Lx3j+Dar9JwULhPgd2IuS4HA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(8936002)(86362001)(41300700001)(8676002)(6916009)(70586007)(70206006)(4326008)(316002)(6666004)(36756003)(47076005)(5660300002)(478600001)(54906003)(1076003)(26005)(82310400005)(336012)(40480700001)(36860700001)(16526019)(356005)(186003)(83380400001)(426003)(81166007)(2616005)(7696005)(40460700003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:52.2356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb2aa8d-809c-4753-a7ba-08db3156f35f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

The calculation for allocating the SDMA+HIQ HQDs was updated
incorrectly when support for GFX 9.4.3 was added. This causes
kernel crash logs when allocating SDMA HQDs.

Fixes: bb3dcef654a8 ("drm/amdkfd: Update MQD management on multi XCC setup")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1d53cbc55253..a0520569d00c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2291,7 +2291,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
 		get_num_all_sdma_engines(dqm) *
 		dev->kfd->device_info.num_sdma_queues_per_engine +
-		(dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size +
+		(dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size *
 		dqm->dev->num_xcc_per_node);
 
 	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
-- 
2.39.2

