Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD27C5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 22:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4792112CD5;
	Mon, 11 Mar 2024 22:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3fL1gaI9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A57112CD5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 22:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnPFsjrLgU6KSazZljUWzmyO3nl1Re+PbQZQIY4/hfcHIwzyRVZT3TufB0Ljy3/scDX1yNDAQVZDrl1+SxrMBayPZiMvzb9JhPN0w/luFtSIGUKN71OqR9eYPOOWU5PNYQ3Q4BzxoMLVNgyWC4t2HgF2oT7KtQ56/sVjPDvffuBPLxE0Dmi7D6VU6L+WynRWjMM3mMamqWOZDiK0dWonj8PdkdFp6GIhGPTfqeJ4IG0RRfLGZ9K1evDai35WA34bXKZUMPj4gpdk96aB3XpJAvA46m0QbuBFK+nAsJFq+Vob9G2IX3RHFfKBOuoSPS24jOEers9xh14ht29nKMbHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS5rYfNg6VzeoClW17DbrofhJDYBGf9Z1o7Vwycr/e4=;
 b=T02+7zH9E0M4mZKuUOdJTjRYv7/6I6pKf4dyDAVxzfSDCVFerViPuuuXo33Kr16NI0C1sA7SsX7C6GAMZaSu50lRA8+RhdFSK6Xje7s8IguAzW12Ljvuh5W8hy+ArQ65+eCfIPhosZw5tKPR0L/rYN+XJHrNBhxsja11QWXGKZkXlJ/CD6toLM6KRChhGxPUmqobZOMj4P4iIjJkN02RI3btJevfMcKaLVMlrMElzX3DBwFw5Ggdrolw/duOfovdjMQCTV9d5EBgNCUTCWY41IfqqyG/WnpoQhVPYLFaTF3phbgjheTXTUwJDq4U1fwwfdmHSat0OAtk5hTYEN9joA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS5rYfNg6VzeoClW17DbrofhJDYBGf9Z1o7Vwycr/e4=;
 b=3fL1gaI9pXf5KKEef0XTRhrMlnIZx53x1tGGRdJPbtOAv3w6UqLU+qY5UXLTbJghq636RSMt84crVgRf/dSw8w6dhrIsMsnL7flvRabjPG++/yOFqoY33vLHHmh+Wfyw3rJZJlmpi4r6jAMYR9t6JoZfGPqPd4xXRaK4bCBtWwk=
Received: from BL1PR13CA0230.namprd13.prod.outlook.com (2603:10b6:208:2bf::25)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 22:21:51 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::40) by BL1PR13CA0230.outlook.office365.com
 (2603:10b6:208:2bf::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17 via Frontend
 Transport; Mon, 11 Mar 2024 22:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 22:21:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 17:21:50 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag
Date: Mon, 11 Mar 2024 18:21:19 -0400
Message-ID: <20240311222119.29917-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2c5955-61d8-45b3-46ce-08dc4219a62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95ueaUgDxVJxUfQK0lY5QAjA1Gsm2WjwviMgIewz1/6CyMUqYSE/z67eJPz8x/ezHWxhtzU5KIqpXWSg8PP/iouBS95i8p2ViU0FIMLBeCFDLhELsL30/xiT3WNCMuiCuHtZLnFVTFFADMH6PoJWxxIS0W9Kkd2cBuWjbgCGK5olx0HrHjAz4a/2Bxbh5yP/MTLVKzYyW0jgwFMlNQcjmJA7z9wgS5TvRVwQOTWYVNGdHjKAKfHFhz4PFrPEK62WQOc1bNFul3z3pyiUYpCr92PqsIFxz8bK9O8HIft/ti/YfFSZGsfqc0v9Evm0/5DpJKWS0vaODv+rkc0umf1+PyhYqd/qCU4vD+OMKrLGRPMCUwnjSo0MovyTnSM8mat6mE/ufNOyeW943F3Zr5M8g+Ofx9NyeBwsklBXYrNstHDBTxoawBW4jfeLgxy+WNtYi4ms/6pPS1rVnzdbVU18T61ss+Y3NXiz9JMNCgiYK7BpX1znw+RvIFwgSwjHTPfthDv7Jrwwogn/iLpJefMdsaCm1NZYQ6F7NZOuBhfeCpDuozs3HY2C8n5F3tgHHnAXn6qPLvkFsfqSO9OqM1d1zsxRNS1l/pyBx70pnwouhKVacqhPILqGVlB6xV3xG/1qU/WSQc/Pp/KVS0jdrdDJOjiZ8/ILre2w4SdbnILtw4Tmj4j1zQIWMxVvW6YU1cVTtGzTt+q3oC0AENWlXzdJw6Nl2fpVw7iuuzpnwD/0/xZ/cPW1PBQjYYPSxWwUy+q3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 22:21:50.8899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2c5955-61d8-45b3-46ce-08dc4219a62d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
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

Otherwise amdgpu_ttm_backend_unbind will not clear the gart page table
and leave valid mapping entry to the stale system page.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 75c9fd2c6c2a..b0ed10f4de60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -869,6 +869,7 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
 				 gtt->ttm.dma_address, flags);
 	}
+	gtt->bound = true;
 }
 
 /*
-- 
2.35.1

