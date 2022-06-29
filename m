Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C283CC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 03:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3829A10F79B;
	Wed, 29 Jun 2022 03:21:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED70E10F778
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 03:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9yluRWTDi40m3xt6Gn6bPzPc+SrDFLob+0s/mRNy+dQq1u8AGmVr6szQHkAq3NFbcStgBA2/QDUFepbgt4AxRLZTQ7Yw7SCAzcKF16+/ve+BrFR5i8IYmHkjdDqFopvlZKAnh8VTdYQlhTIwWNLq/KEkEr9HIhnuMPOpPdroz5qylPn+UCc4u/2XWHDkhJhxCuQRv6iSwE1BXsYrRTY4Ei6GI+0UfvFh562QyPMNwhLSTg+tfyy0UJ73q6qGhKLIrLJAtKA9k/jdawQVSgfXonobE7PDDIx7qjgRpFu1cDYEIsWuJnlXubirzSXe5/dltbJEVyb4zjEWCe110DdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vNRycE2n+oR01X4r0fpBCeDVJlNBDG5BrNnqQDdhQQ=;
 b=bTB8tQUl2l89au0bDSsRnbGnGKnT1noIlIcC6HGGA5q7vsXeygAr+alKMd1IRMRdH6xUQ2e9uQQlcxiI2QiV7qgMzVLCL5nev/zZ2zk8w2PhTt7pDpfaypsmHUEKwBrmIvFSFun+ec8eIQ8DmXQc72oSp9pEs6JgWfa1Y6y6wnqO73glM5B52HYmxxDPL22+4Rgx89FbFIFDDD4xedu9ab9Jj5DB6wf406YynKZgOMXGtcdep1O588qxr2uO0bNcU5XgLk9kwARDVOO/lYdkIB6/vIVaEP2xxm8EeF6lcZM7/MFDllb7FCXI+fm3iaQh/sYXUVJPgXWCHBsrgkPTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vNRycE2n+oR01X4r0fpBCeDVJlNBDG5BrNnqQDdhQQ=;
 b=3wsOyvxH63mlCCCVQgRjMwIiZw5ByMlfozLlslkaq+Aerr/VS8waNijzZAKiKanDubno8MwQFw9wTHci0o2k4ebtd8FWAMFrk+vT79p77G03qrqDmwpl/40GLbsU0K86A/ugnnK9GhObyPBc9gjncPiVBGAiBvCp5m8WLF2ClSs=
Received: from DM6PR05CA0045.namprd05.prod.outlook.com (2603:10b6:5:335::14)
 by DM5PR1201MB2474.namprd12.prod.outlook.com (2603:10b6:3:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 03:21:32 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::d) by DM6PR05CA0045.outlook.office365.com
 (2603:10b6:5:335::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.12 via Frontend
 Transport; Wed, 29 Jun 2022 03:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 03:21:32 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 22:21:08 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu/mes11: update mes interface for acessing
 registers
Date: Wed, 29 Jun 2022 11:20:28 +0800
Message-ID: <20220629032034.2994328-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 998893da-a292-4792-14e7-08da597e7714
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2474:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRdoLnBYnM5LuelgbKTVrw7+iPO8zC+Lp1eCdkrmbcP7SB7RptLuk5t8QfJl+mdwz61PunYxznmMMSrAt2U3l7lz4ws3YwQUraDZyqvj8eB+usKvsM4JF6KvFfN2M+3QMoL3l6Iav7r4ldeF1h62CgsMecULN9/5syXt2Z+jqSifaxdfelADOGm8trISqPBRiUeFhfl0Ivcn5sm6uOrbmFKLfIGPaIeI1oudZ4gvmHiUwFqdGxDMFQ85uSzfY5HfJafZK3vgU5TOsAMtgGESfdMK8ugZlrZHB2WElrkUZwiQAmr8OnOMDHQv9QnQqpqv4o39AzT9awOos0uqXGxBhxWnPoMs6a8G7VXAkUpdU9mXSOh5BUWiGrXRoO6eFzmE6LbZUHYATe3cj+3ixmcognJg68N5s0xMkenyWisyeFdgwIt8MCxW1QEUiWYORiecYecBbvfPwnw6/hE2BBPlDT2MeY/KkjF7Hgv7/mqfyYMIvvN2LmERDYmc1GSDcA+YcpBIxzg8Sg+V9UAyC0l2BvY7mMQjyZxLQkg0fB7kg46hVKeycjxgahy1VpkgSME5mxKBVzl3uLdwFsDpyREQRhlJRxZvZQqpODPfAyCMS7eeNnOHHGwYjHnzqyfckzRKy+09SrV9aaOAtX6uV0+BHfFUcX7jTgi7l4pEsiBmxW+sAVNoY0jdu0YRiB5A983wx8DqwmBrLm+AES9sZgeod3yUHexlvsYWYR6fkUPSZs/cvZ1a3YTfzN0DjKaSgEdH8Y/50yS/WgQLe4kNaSc15LiGCkC1ECSIURkjUW014v6ah5RTz/gxaBrKB6LSIaR4LQjrWYgsBPNEmfF6b2SZSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(40470700004)(36840700001)(478600001)(8936002)(8676002)(70586007)(26005)(41300700001)(15650500001)(70206006)(5660300002)(7696005)(1076003)(82310400005)(356005)(4326008)(2616005)(82740400003)(316002)(6666004)(86362001)(36756003)(6916009)(40460700003)(83380400001)(36860700001)(426003)(186003)(336012)(40480700001)(81166007)(16526019)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 03:21:32.3340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998893da-a292-4792-14e7-08da597e7714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2474
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update MES firmware api for accessing registers.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 37 +++++++++++++------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 9a70af44614b..94776e6c3ad9 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -508,27 +508,40 @@ union MESAPI__SET_DEBUG_VMID {
 };
 
 enum MESAPI_MISC_OPCODE {
-	MESAPI_MISC__MODIFY_REG,
+	MESAPI_MISC__WRITE_REG,
 	MESAPI_MISC__INV_GART,
 	MESAPI_MISC__QUERY_STATUS,
+	MESAPI_MISC__READ_REG,
+	MESAPI_MISC__WAIT_REG_MEM,
 	MESAPI_MISC__MAX,
 };
 
-enum MODIFY_REG_SUBCODE {
-	MODIFY_REG__OVERWRITE,
-	MODIFY_REG__RMW_OR,
-	MODIFY_REG__RMW_AND,
-	MODIFY_REG__MAX,
-};
-
 enum { MISC_DATA_MAX_SIZE_IN_DWORDS = 20 };
 
-struct MODIFY_REG {
-	enum MODIFY_REG_SUBCODE   subcode;
+struct WRITE_REG {
 	uint32_t                  reg_offset;
 	uint32_t                  reg_value;
 };
 
+struct READ_REG {
+	uint32_t                  reg_offset;
+	uint64_t                  buffer_addr;
+};
+
+enum WRM_OPERATION {
+	WRM_OPERATION__WAIT_REG_MEM,
+	WRM_OPERATION__WR_WAIT_WR_REG,
+	WRM_OPERATION__MAX,
+};
+
+struct WAIT_REG_MEM {
+	enum WRM_OPERATION         op;
+	uint32_t                   reference;
+	uint32_t                   mask;
+	uint32_t                   reg_offset1;
+	uint32_t                   reg_offset2;
+};
+
 struct INV_GART {
 	uint64_t                  inv_range_va_start;
 	uint64_t                  inv_range_size;
@@ -545,9 +558,11 @@ union MESAPI__MISC {
 		struct MES_API_STATUS	api_status;
 
 		union {
-			struct		MODIFY_REG modify_reg;
+			struct		WRITE_REG write_reg;
 			struct		INV_GART inv_gart;
 			struct		QUERY_STATUS query_status;
+			struct		READ_REG read_reg;
+			struct          WAIT_REG_MEM wait_reg_mem;
 			uint32_t	data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
 	};
-- 
2.35.1

