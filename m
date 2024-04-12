Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6055AC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 06:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B490C10F481;
	Fri, 12 Apr 2024 06:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x+XwoG+R";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91A310F481
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 06:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jE0Kyk3Focq2k5SAY8d5tmp+qot6hL2H70tptdDqd2E+zHU0pCPNAQuSy0gRUV0F33HuEFG2HD40ntaAiEgiJi5zwUzETS+vvhS1Nlhd1wK28Qdiz/p5FT4PI+YYjUD2uTAApciHnAyO24b6Rb3NnGOb23Qd4Bnxojc9D3jxc+yz+42Qa/Z7DLy9zuYNCbQidxOpCkRwJ7Q3d8drsyhWgfsDQEwRAC7cYQslni9Ldb3+kqjHURFrNO7Bobrd901Cif4RcuifNeKac9zhPW5ywd56xLjmE4AD5mW9eKe4/8XuMDiQkywzTJPFMRtOE9mo1OnzwWwTZAeePueERFgNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ozjt7q+fycTayras07NEsivj1/SxvkQfsILzJP5aqU=;
 b=WXVDgJf0GvhDCwxLapCsN3qbTL/sGn5tBdazXrz9Ur3/CA2/8/BqokBi/9fN+AxoENWF8tjHXYq75Jl793UAq/PQsI1uxCQH9v6mc2kYzfs+povf0wRWLGjjS1kDuPwf01vjaEXn17DidcGhTGIwrpHfrJGvt0U0oM68oWueizWlZ3FAd52VMvuJO+yHTSL6nGQjyXreBbRmG6l3bjAH8fS6xseBkQ4Fy2PfbJRAckG2qYLv8vzcwZroibkGAmIpoam8NIGdoQe7NY+ZgVQUWf8O1ke7xKb6uFix5KChXXWIK+lVl9POCM/auUNHJbphQtPfPGyDYiHFvYNoIEeG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ozjt7q+fycTayras07NEsivj1/SxvkQfsILzJP5aqU=;
 b=x+XwoG+R3a0C8X4frW+D46Hzu1q+bxW751FmGQhGvBuRYPqg058wALmLOqnC/6FunaXUOvpH8Ew+QGnuU4O273USS20OhQjLMybMd2D6732PzxfkXpHAXIPAHVctO7/aEOHzsY4mwguB030E6OFksxlOEa7lU1qOCaZSkdDuuCM=
Received: from SN7PR04CA0228.namprd04.prod.outlook.com (2603:10b6:806:127::23)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 06:23:51 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::5a) by SN7PR04CA0228.outlook.office365.com
 (2603:10b6:806:127::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28 via Frontend
 Transport; Fri, 12 Apr 2024 06:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 06:23:50 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 01:23:47 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Support setting reset_method at runtime
Date: Fri, 12 Apr 2024 14:21:14 +0800
Message-ID: <20240412062114.3581242-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e11f6f-105f-408e-1f1b-08dc5ab91e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42ITmlsKLPH8qvPK6fejlR8w5sVg0rvckXmOqtvEcq8b75RKGIFnfTQeT03DvTioMbz87QuJp92/qBPo8172Dh9PvCRcLXHH83ZZBFouWd0+eU+3XCwvNj2kvgIa8+YgdBQnlsimO9orvY+YyUhq6R0V/omBgLUHwaeYPgxuhG+mR7jopFfCHtBFYC1jDIrW1sMAS8A2nQd8BC7BS1RC5DQmmOQZLQV3y+8tjIiLjqYauXJnBALgxKEJo4LnsFnb2gnfMgvq7pTYSSBOK0q70O2zMUyj3hbgeQkeH7gac7ugsjgZKM5j8Ggvm4gkexCO9JtABIinZXgPJZJrtXzIZEm0s5tCaaqFkPlYnafVNFO1DpP8FTwEbG5tCMbWrMyv1yocGg8LMCrIG0hfChH0qsQ5FoxePovjUAPOHA+4iR5/6q535PZZ+SngzLbjYb2Ff3EVb4jAB4TbHS4J1T+GXpBLjdqMcWqMfgOe1ktntd4erW/ht/dXc0LEB9b+Fr0/rdYOnzmpz3uug1knk5zNU8gjfmRbgsMloPCGUIdfbUbRGKwt4xZgDSngDEp3k/VX3N7fa71rTX8oQ7FLNjuMdKFj7uiw3hVaTl9KaqQFbzdaOY5w2unhQoEMXvRSQ1X67o556nULdAvd8IEAtGXdkybdgWooXQV0huF63QYbQ957FXuukAAjVKwyZ5GdgbNPfW1bj5/tBiKlcjwqPrTEvBEcml7az7SOvZavqisgUs+5EOlGTe9lx2ILTmRwR/97
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 06:23:50.4470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e11f6f-105f-408e-1f1b-08dc5ab91e64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 80b9642f2bc4..5f5bf0c26b1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -915,7 +915,7 @@ module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
  * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
  */
 MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
-module_param_named(reset_method, amdgpu_reset_method, int, 0444);
+module_param_named(reset_method, amdgpu_reset_method, int, 0644);
 
 /**
  * DOC: bad_page_threshold (int) Bad page threshold is specifies the
-- 
2.25.1

