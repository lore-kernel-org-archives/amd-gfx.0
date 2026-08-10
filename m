Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F299C5AE49
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795BB10E5E8;
	Mon, 10 Aug 2026 03:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vlKRxQxl";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF3E310E5E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clJ8nVt9FpjslH5DL70JZhPJqPqi9DY1EGgrZh4yt7eyOSu0FNWigvgTY1VCZ7+8Xj27N/nZHxdD0xYj1B6ZSE27pqilA2E/OzUMXwsrRKaG+Z0DGGWKHUzzl5dfUChSkjxPEYyFryThUarURbk44rwhQirDZYWgtbt75GGffBDNNPBZlFRkH0h1YeMlgai731qRvwxSv/hEyIjROLlAyeSWZE5IEENK1jEZN6fiAViTip4HDBgoOrap67He09FJFJnAB4rOC7kJ9m9ZycJl68W2LhIotWr+kisSrahjELEM7Wq6CqYyOTbDpUStYy3aZmo6dxs5BWFDg+n/ef1E0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZlZe/3m40U7c37FvhAibG6hplPk5Ty90CDnXCTuFDU=;
 b=SaSycU4RfUNSL81Z/9fKaTlEEN83AeWhFeiyS10LkAmDXT2S7nKxEt0tfJfh4QOZqwo5mG/OTTvvy/zgNCZSPGxQjjXEV6ZfcV+ERYP329B/7vJYvgLjswPV7PO+e5JOdNjR3kXK6a65XQaNzoNs8RMeQV+C3ZUunIlrJGhyx48v6oOJe7n0Gp2GLiQ3Gd636VOwS70MmvYvXPvwHZmo4Ed61np4mvJ1+gREJoatEUQPmsmJLJZIH/33A9RjbBNxhOSGRxdYC5yZ0pgAxB6mwNgWy/nl+YKm27eFQiBPAb00TWvDHDJC1xtlcQlFiBIXXghUgRaaSLdxPm3MvVw0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZlZe/3m40U7c37FvhAibG6hplPk5Ty90CDnXCTuFDU=;
 b=vlKRxQxlfuTAivLXh0Cs1zFk3ppH2NhiW5CSv7HHQe1irUMSgP5RessqrRAjeTEJtCQUDyVM4nzOJZ+cMFsxYCBDHBqdAHm/w3KdZd9lpUC+hfy3DO7yVtRhqKGokooVCCg8/Wpg6sp341Xzniio8JhjfZyQpAVfamUgf6tbSdM=
Received: from DM6PR06CA0088.namprd06.prod.outlook.com (2603:10b6:5:336::21)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:11 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::40) by DM6PR06CA0088.outlook.office365.com
 (2603:10b6:5:336::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:11 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:07 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 09/13] drm/amdgpu: VCN 5_0_2 correct process interrupt warn
 message
Date: Sun, 9 Aug 2026 23:36:40 -0400
Message-ID: <20260810033644.118194-9-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbcbcca-9a65-49e8-b7a4-08def6913890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 40cD5gMJcWwlyo0N6SvlzpLCaitWeWbQNJIo8cEUkeLzDW6pGsZL7JIATeGXWyGShoQKrjpOBCik0GpGxfCbRHMxpizugSscCaFmnUdT5Z/nSxR/uH9aAgqcjZYQjql0u4aLG0ilqowqfQa6hQvQ3kBu7rqlZJsAp2O/pNKe4M4FdspdwTdrNF/CeRoVLrS3dbqRBOUWr+QM0dCdNbPg8kjk9f86qwWnrD8CLmsTJYgifVcJZMN0C6qOa2TX8nstTrwmvGx3LrLsnju+R6qH69tmoBWci1BaVFRFqVNNsMoiMXefkrTgsre259XoQHk6GbVWukZJtVM/eOcfZtT1y6xWdYsHgVJsAeXw7IR4UENBaPJcnBiAQQJgTFI1fGNcgRxqPjFEYRWy3tqNbVut9wV0jCRA3P/BlBdwBuPHwIWnkl1Qfnk2VS+xE7P77nazVorp5+HnzCj0T4niaGEyFNd78dnnIi54uYkCgoMK4b6YTXuh9kbL3ARZNgReqXQ2+x2da6hjRXR1IE8hAW8o9pv1tZtcveoSFv7OQvY7+wpiKUuU+vs1PRjtokdmIq+yNyHdDUqrOU5tzTMHzjN/kaZ74vSntZrXJQg9aDpnEsuzDhVdD6farDsBec4xJD3PE4AY59EK5xhLDEWWLUNU5E1kKk8HTGCWtUJwztg/9fv/PDQTe0kLceWZvGXLzoSXB+CgdjLWq9h2ZD/S2o5e5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9ilwMyHIpcWc/jFD2PHAE4lIHRL4qdBT29NukLdrgvaxJD6GY0Ea/UxOaEApOH5KTdwF9tKtq83/zdDUvYSIJC/wpf+X/0O4irgOS+Qv1GQA2e757ZWQrqS/wwYbamRPR+YQBwbbcfI5hfWDCepP2N4WkLUl0KBHG9z97qQdaRbtGWn/lFfUIqt6ikO8bXLjgQwzRJCJKm4rDZWlvyeEJlzvYX5y3fZZct9m4DWbDY7VFgDl0TZy70O0BX9IIzfVCAiI/6AGoWC6MLfFAWKyFDOir9a8+XfFvAfvwmVK9jQ0ozxie8IEITM78KY2knu045mnIPbC/R4U0hBUzguZpVzCQR/HeaN1STrgfSn+0LJ3Y5tYjCeBskx/o8mrs9ox075s4xWFkOKrAhW9ETN1iWb5XbocvTH0md5BzSQG4JXXWIrdWRtKO0srG1Hcu/+Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:11.2025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbcbcca-9a65-49e8-b7a4-08def6913890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
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

From: Sonny Jiang <sonny.jiang@amd.com>

Fix the incorrect interrupt process warning message.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index 2842d8a9b42b..74aae5b5eec4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -1172,7 +1172,7 @@ static int vcn_v5_0_2_process_interrupt(struct amdgpu_device *adev, struct amdgp
 		break;
 	default:
 		dev_WARN_ONCE(adev->dev, 1,
-				"Interrupt received for unknown VCN instance %d",
+				"Interrupt received for unknown VCN node_id %d",
 				entry->node_id);
 		return 0;
 	}
@@ -1186,7 +1186,7 @@ static int vcn_v5_0_2_process_interrupt(struct amdgpu_device *adev, struct amdgp
 	if (i >= adev->vcn.num_vcn_inst) {
 		dev_WARN_ONCE(adev->dev, 1,
 				"Interrupt received for unknown VCN instance %d",
-				entry->node_id);
+				inst);
 		return 0;
 	}
 
-- 
2.43.0

