Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8539AF9D0ED
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 18:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA7210E652;
	Tue, 14 Apr 2026 18:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BBVnvw+y";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0558B10E652
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 18:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm1GAOjcguKbguyOqEpypjfSCFCJo+xD0gatYiqC9y3VtyACs+WBctBiKmoRxCg6IRnXYBzG66OM5Wa2dgV5yHDNGzCaoDLo32RFQ6rro12sVzgKiFXN5udNOy91VlP0rxXAOVJnLwk8Egr5aIFB+2NCzAi+lJLN5ACjgFBJuDHzWUgcC5OjasrITaLUt4LPZZg6T0K+jvY5VEQlUb9h+P5lIpKDNHc9xGDQPHUNa0BW35+m0oR1vFFkvy6JlwxHirpMRPBSf7/dR7YkUggwXixptsddL7/IiYg/TfSFghxVTMfGx1j/SoUcfyBTXUDZOmaCABi6XnsIJprQgAm9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjK0fzaXpfqGj7H+tvZLSgq4Wb1R3OJowcUnEGtH0E8=;
 b=XhZVKf1twrTzHO/4BS7OY76vHQeDBNrf+SbHQzd2RbPYZ+CeBh9THGWg6+T5QOOcrdgFz+/9RPM669T7PUIAbTo4zSlatWKVYabNrrKNZHQnT9lvcHz6I4Ws2IxzBY0ZVoOkIkRbDCmNrPnTrC89IZD/4iHIQCeJYkM8TO7qyXM+Wj9IjFDN5zNvNO/5y43wnW1xTIATya8RrdMJ9UtJ1pcu4zwNl6qyTz7uhsLyvmAA8wSsYfupqSjyPUMXj3t+1Fyr35EDghc5AIX9L8I3HUww2x9H3GZ3BVt7fsCbKyBq+p5LtF6Qil+XmSj1/GSMIKbHdP3cYO2w4imKPTEIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjK0fzaXpfqGj7H+tvZLSgq4Wb1R3OJowcUnEGtH0E8=;
 b=BBVnvw+yQGoGU4AuNHihD+/tL0E8W5aF1JfCzYDssw9sD9FO1Mmxgf9J+7qkRg0Rvu3OsAfGR0SCpT15F8ZVNqePu3m4g9NfWifqR8lfLCmckGuYClQxEEvaqRNbAMHigXuRM6cdwdbC8EQ/gz4XYECON0OVqStHNkVFfsM4tbU=
Received: from BN9PR03CA0420.namprd03.prod.outlook.com (2603:10b6:408:111::35)
 by LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 18:50:08 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::92) by BN9PR03CA0420.outlook.office365.com
 (2603:10b6:408:111::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 18:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 18:50:08 +0000
Received: from siweihe2-Desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 13:50:07 -0500
From: Siwei He <siwei.he@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <harish.kasiviswanathan@amd.com>, Siwei He
 <siwei.he@amd.com>
Subject: [PATCH] drm/amdgpu: OR init_pte_flags into invalid leaf PTE updates
Date: Tue, 14 Apr 2026 14:48:19 -0400
Message-ID: <20260414184819.612245-1-siwei.he@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d95de6-e479-4427-3b83-08de9a56a66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qO4wPETEiaqDFdm8VPML7dIgl2p9R2PntOsVjlfYpwbz4j7wJH/cWDwMx+9zGKY4MZ8sLPfKa5voS+tC1Z7OboIYtYzPNwEa9xNWXGksrHqw7/6+YdD9xTyeZi7GTcC//5IPfy5tI0zDC29PJmKWRsa3wCwYyHDTf4gqpvBw7ag6bKRUp9c260zdDs9lmPi+F2fhVcEXmtwVXqfQQbAuMfgmLmfxOO5nw8ZTfSdhrOSkwVYR9fF0JbsEyWD7+q7cU8/k+XgNY+Iw3iLT2reg3PVONEAYDIVwV6PNg5YvfjIQuf7oopJKOVO4XTjVuowbC39hVExrNAyX15s/6siuWdjl1U/Q1iIUh1lCX+4MGpDSaNGwKswryombj1YkJCRdl9oAYQgZasjNCOLpgplpjGF90EJnPomIjm+bJpYunqnrTucbmvwv4xsWxWXopT0YvouYwGjfJGvghs7RQPXARxrX+RmCW+E6sh6dJeeAa2xKcxVvnomZqGKDmbUlXa2JWnR1BGk5mkOHviGdkfFcrSzzKRbeZAUbYbErgI2+4lWHDF5sJTc9eK7JCI1n8a2PvHfEVqZ4sTVYgZTl6jfaUGwql2GZoKBv1QHH/hUqGmQke0pTNdeZREc0CkBX9g/+wCArTydBaZFrz87OF0KNpKPuh3mLQp2kg0uojcF5OI/BtLl8X6Ydovg8nKLrhlt7nazzxJuYWt/ZBJoRTr0YpxM7uF6v5fohgBQBBfuTQKqARlZpY3EZ1KFAArVE9caHRQJh3Mo0ek2H/9Lduv/DmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R+7tZYWPWZ4dmxwSIiT6RLAsqgda0cfLvy6sPDxI9aq9xy1HJvLUceZmM2OVi+T6sySUDqZCs5o/6CT+4segde16oqo0TrOm+tp5ns58VeKiZHqV+5XlqBrIg6j6uYyNqFBLkMv8LKCsWUCJObQtOdTvp0wWBHqn+EBSt+7grW9irigzWBoyMLKibOTR4YZGSGMErtPUNCyA+Tdtx2mQaE9J1m25t6mciqkVf4fJPTHOpzw3vFHCP6nvDI01bbIb9Y2Unf1rPZCpzbwlhKVh+/JgX3VKX5sj07/M0Bg7wRBkJxFXLavZFD65tHJNcLKZ3n64aEcEXJo7CSpNWKMxw9c/RVZnJMItJhBAm4TSaknBQGjAgPoW4TE5VjpAid3wZcqKmQFRkOhLsvrTO6/G/ioYeHtWgtGWJ4aRlZGJsofjaDtt+i+K5kso07mjNahY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 18:50:08.2609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d95de6-e479-4427-3b83-08de9a56a66a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097
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

Invalid leaf clears that only set AMDGPU_PTE_EXECUTABLE match the old
GMC9 fault-priority workaround but omit adev->gmc.init_pte_flags.
On GFX12 that includes AMDGPU_PTE_IS_PTE; without it, some cleared
PTEs can fault as no-retry and bypass the SVM/XNACK handler when a
VA is reused after a BO unmap.

Apply init_pte_flags in amdgpu_vm_pte_update_flags() alongside
EXECUTABLE so range-driven clears (e.g. amdgpu_vm_clear_freed) match
amdgpu_vm_pt_clear() for leaf templates.

Signed-off-by: Siwei He <siwei.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 31a437ce9570..a930f1522f96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -693,8 +693,11 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		   !(flags & AMDGPU_PTE_VALID) &&
 		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
 
-		/* Workaround for fault priority problem on GMC9 */
-		flags |= AMDGPU_PTE_EXECUTABLE;
+		/* Workaround for fault priority problem on GMC9 and GFX12,
+		 * EXECUTABLE for GMC9 fault priority and init_pte_flags
+		 * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
+		 */
+		flags |= AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
 	}
 
 	/*
-- 
2.43.0

