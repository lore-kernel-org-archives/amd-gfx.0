Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3731061B21
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 03:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171E210E849;
	Tue, 31 Mar 2026 03:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVvRnMnf";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B338B10E849
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 03:10:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4e5/3duxfl247rsYr3eKCcD+XxcXBRQOQGb9q8TiUa9XVIlsxKIxFb3FmxwzqPF8HYX+u0xBf4Gn6VSzCu3XxlXXR0dbhCh3IjobpngxBAUh7jkF0zVFkf9/8SC5ab5HDA9/0dgbfMyS2CNxcVxAXIAyfNk0/DKQOfnTj4C7zkK22zOCQO+1JBqs/NIdTmKBvyUP59s4T6TxSBPAhbAsc01p9RnPWdBFPB/+HPkCF88qYm7f5ZVV/9MVp2KKTDmfuPQhjN2u7iYYHZPqd3AWP55VwV8smQMWi21isZTHVbGymA4LQMmpKpwZrdaBWJSbPfXePQATWmW/GV6t9lPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMfvlIXDYRkRDyWU23o3JFTBvayURr2K8ns0ANLAvrk=;
 b=OfXkcnkI7LTOV9Xu2oq4iNd3aKSyWeMcsEjHKpevVm6h7qPfy2RLEz5dbg6Qkc3OV5sZKhs74Lnn+c9wVXaFpgYwvr+mjBBCMy9d+ZG04Y2uxfkFqDmFRcqMJyTFH+1NPvY7P9F8UI82Es/c9L/2Z2Lu4mb93iRPLhbF8xueOlFTRIy4J7a2wkcE+gMM0xcS1gi+Jf7a+m3r9laGuwNTRK4dv8G0d5bQHnQdO9iZiCIuODCYopvvKf8IidU5grC2itu2rEuOHdwx4lw6d8QnPaf3L0QpaoCRJHI8yZ7ogMSbO7f0JEprJ/2zcrShBmrtCsma1oThb0o1jG2UvtfWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMfvlIXDYRkRDyWU23o3JFTBvayURr2K8ns0ANLAvrk=;
 b=nVvRnMnfQ2kQbevUfEjFzBJ+sDFxx9gO4P8f6A2kKz9SDLo8yESsV/R5L25K7Yj5Ctc0dCUOEaaMw/7qi8ufBzILsnFBTStwaQW+h3/XeUpvkTtDS68ziakuH0Smgjhx1Ni+Oq/sVEExsdss2H+fNsfld+SNp6rqiltTPmfyTec=
Received: from SJ0PR05CA0199.namprd05.prod.outlook.com (2603:10b6:a03:330::24)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 03:10:35 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::5a) by SJ0PR05CA0199.outlook.office365.com
 (2603:10b6:a03:330::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.24 via Frontend Transport; Tue,
 31 Mar 2026 03:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 03:10:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 22:10:32 -0500
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 20:03:43 -0700
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <YiPeng.Chai@amd.com>, <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amd/ras: enable uniras via IP version check
Date: Tue, 31 Mar 2026 11:03:28 +0800
Message-ID: <20260331030328.1608708-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 25034e72-16b0-4e2e-45de-08de8ed31351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18092099006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: H6F91Pmdx3jbrHjutGI+NRnh1MLPzIjDilDjnzndztoQm6FMN+GAirdjaUMpSrqEL57v7X+XTz3aCFRNEj1sBsLRK4eHbfH6C6iPl3qaFi0WTVPcBqHRQ2C8CmdLXPrLLCeDxQ2QwALTuZP7sWU50O3Z2GQsTDDlf4HapbmJPkx+fiW92K/oF/UmK09NwhWVhYarDXG7ta9W/IK/MnWrqlLaIUR8h5eIXdQJhO/zGk8M6Ze+o8y8D1ShSaeQFm4OKPgmiIZ/05YbZMh6iV3LTBmokAhP63Jp03Ik/Zyyby2XL9vUtRbwjeaujWRT0ECN3ZG1sW0u/WcdN6OFRtqPfOaAU4ZGvSPiW0EuPhfleAKI8g/olwm6LZATbA0036SU1zwrma8ThchTQqdBa2M6BLPPVN5c3TUqPeoHN3tGhaHaXiEDNTfS76LbxTbCpVEvkWH1X78KrS2qcTHElYdkcPhRAqpnRVBRZFu5htri1hfvjEZnYPG3geLaZWBej4319ImPFPFn5VM4T8YVhusDJTEyM5l7mFED+LF1Hj3mZ/JeD1OPsQGR5EU1vHkE5HL302vVIn0ClJTblNz+gKlH7lDvxWYSdO6pnxMhcRLkMCWNnSEvlxxN7eOmGOk5zDYk/2BTxgoCGJ7gfq9U4xlCDFkVdaC/pzW1zXUQj6eB+OMFUCCZBwAoJgmd78xOC/lcsQL2O8UnwZNyvZvzQX3Mm8HyMybby8jvsVw8foAONVjyS/yt/O/CWYr4euWV0LjmcG6j+dLghCR0rLekCS2D+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18092099006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y2nw5uKFl11veNZ1r2J7/NQuFliNWcf50iJJmpynpXT+nqr9TocFq1Tl41NXgA0peczDvUWONljIxG7alqilI4UpjR62VjZvps3uX4BvUKPmdi4nEIMqxdy+lV4azn1o2v0MYwc9poea2eqFeL4GGMReO0HsFBlol+l12Ia8f8ck6phocPs5lKA57zbE0RHjBR3C2tK9c44Aii+TVwsgkLEiA/UinlQvLwVQaMZsiE+Ybd31dq93+bqd1yVZlg+rORsq7fwIp29R8qNiZk71UT2sNyz/ibpX1T/nDohhiSQTwNBfhPhDbpBzSD/cO3hLsJT4b6jCWb+W4JptQmR4Bq3Rr0uIVYIHMvtenk/z7DcS6BIMiwMulQTcHEElAw3e3dgKC0CIWHD1VoEZn7y8mYxtO3yS/EsgAPqa8+WGcGkuAYS4OOlHpnuT1yk7YPlt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:10:34.5183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25034e72-16b0-4e2e-45de-08de8ed31351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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

enable uniras via IP version check

Signed-off-by: Ce Sun <cesun102@amd.com>
Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 861b1f290475..f5416ffac9cd 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -290,8 +290,9 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Disabled by default */
 	con->uniras_enabled = false;
 
-	/* Enabled only in debug mode */
-	if (adev->debug_enable_ras_aca) {
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) {
+		con->uniras_enabled = true;
+	} else if (adev->debug_enable_ras_aca) {
 		con->uniras_enabled = true;
 		RAS_DEV_INFO(adev, "Debug amdgpu uniras!");
 	}
-- 
2.34.1

