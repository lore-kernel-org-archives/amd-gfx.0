Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9703B1061B21
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 03:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3746710E84A;
	Tue, 31 Mar 2026 03:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWyVkudB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD4D10E84A
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 03:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtZ4I31dFGDDZJiIYWTA1PFc/9k79iVseKf/KwSY8Sjo86L11F+9z+FkbjgRtKJVne9qYQZascc0noKV8gVSYWbvya5A7YoJTCHzpV+K/ZajrlBGgOVX3I5VM3FPdUGJVOlIq/gX4ywI5xf3pV/rU5rvNoQSt8fKgqRbCNlEONNetTzIcej0M4rxb0on4DG8VCScqf6rkCkTiR7atfTw40oK9HLil4qiedj7tBS9ioU6wjh6bSW4kSKfc9FAsUiM0OwPNq9SAtZ2E4KKgygHv4uY74Xh97qD0APAHSiko+HVn61B1nMh/orGkM+uyXWLmA+rkYAdIL47MR3pkCHCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMfvlIXDYRkRDyWU23o3JFTBvayURr2K8ns0ANLAvrk=;
 b=WQ5kwawx2Sew2S0g0n5b/jzq/p+fNlEpdCJT0hzGR0QRB+5XAnoE4vVic5bOdC8Lg3oy/T9bN3cg1JLqNFX34H+VMWsWkMurB01CnVzPOXHe4UbfiD4s3EOvzVLsfEJHJqtZS9NYouZpopohXcIyk5A9Rj+dUu/uVRPMs+rdRhylMuL0dNA6nUIBByVSAhx31dZ4IKusPhkU4CKLa6xBccR5ZS10/qTNbkAEXdsu7yIhuO/tcxF4jZ2JbebnW+9Wawf8sscCY5RLnHyDGAvHlatamVraGtTdwqcwaw/umqLsEIZbcCjlOdeHsMUXtJKxPjtPIrjuYM3wE/j7tEqT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMfvlIXDYRkRDyWU23o3JFTBvayURr2K8ns0ANLAvrk=;
 b=NWyVkudBslDHYVqxDvXIqsafSjBYjriU8R+unyaCy6efc/iXJTUbe29RrrVokmIS1eVaiedrxQsIXtBEc5IyFLW1y/eY/f3r+sH4XCuBG8cMBw8+4af8Uz7/YgBVGzxWEGfveVgRUcxsuX64vYO7hnpVThkNzLEBpWoYEELC2OY=
Received: from BY3PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:217::33)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 03:10:41 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::2) by BY3PR04CA0028.outlook.office365.com
 (2603:10b6:a03:217::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 03:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 03:10:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 22:10:37 -0500
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 20:08:40 -0700
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amd/ras: enable uniras via IP version check
Date: Tue, 31 Mar 2026 11:08:32 +0800
Message-ID: <20260331030832.1608735-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5d48ce-7507-40e6-ccfb-08de8ed31662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|18092099006|56012099003;
X-Microsoft-Antispam-Message-Info: MELG/b6flIbwhuY7UNI/ImY7x+zmE1PUOdolnud1iEcqSq4tWvkeUD8e8FtUWifzCoUu4qkP+DxQscMOctrF71/IeVN6IsOkRPUPxb1m/rlCJ5iyoiHnYxutjqavoFu1LdKmC+0EGkFrRA2d56LOaaiHrzfN1i32sfIcRxQjnt0PXKkFi0J5zSsVvvaWLhsAv84a+WVQhXGq06zWL4c1MxOr+HoTS/HedDdTcetVUeVhf0o0K/4G2QCOtl6r195h1B7re0Flh6+KBJzFbbA6sJOBx9RzGeG2TeUA5FXYTF1gBgU6HvdM8x7LxqPtv9/WoU0w3VBXJr97k7X9mSP6SnV1kskOyZ7rGzpFPdtk/OnvPeQOEcZSaEuSQd4MpJXT7MXcHrjD6hf3OvHr5RA3GogkIyj1X03ENbfmX4VgEtGXTitvK56qtmwe7cN84vr5LS1gcfpY/6TrejIXshHgTMeFZn9xxZdCh/kbcLS1hQyiI4TplD+JGRufSwilOMmAjA/3fBv0+ckcUl55bwAINsOISMXakFg1bV6VRy6ep4uVSLOFD8G3QkbOwdaTQrR3gb8QguXjkAmumCl37HOFjsTCLumd2UQCGfzam5MfttotaX3Y/yPMOyuO8S2BgxaK8QdFv9vs53UyyO6G5EHIbzeRl3Xgd6RLJ5RhDJAu2lJjBpmN+iSuH1msMC0doT/ir+J17lhywoWY5eZZFilJKYjBwAgDDz8fLJJ1I/bab/Xy3+BFLF/K+6+AvkVmFIrdqzW1GAtGcfWfZNFd4bWHTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(18092099006)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kQZatNVLs3b2pdq1vfYRtOB7XfPBSbddyc8tnJAbLES0xdklmcb1TRYjuL+vCPPb9sg1dUvSq/y0jkRaa1FWJ2Mj/wZ3fy1jyxhuahmI+Skc5J7ccrHCYv5EYMAxCIrnd+kL3K+TSkuKHYV+1WbS9jrrLPU3le0kkr8laGW3O0Rn/41GtxMDdpcxZVUOKVfvjSWBP6VmGF/O5fxHMfzrpIk8u5d3TGOjCYjXsa3P/xaxa+B2XXKGuTnW3O/YqDsJMXdeqh34P70snzGnVHxJySefzedpE3m8KFu7SMT/f/QdX53z/I6bGMe828Wo0d5MEuSZ4psORO09rSdsmUn5oWnEM15MCmnpFjPFNQd1XMMvuwgrBlLn/BlTRWyWMk+GoRj91qVYW39ooZPPUFP5k+WjiW9Vw6scfd8DR1Wk4rMV4Qs/cr2Z54a3DcpS/Bwx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:10:39.7177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5d48ce-7507-40e6-ccfb-08de8ed31662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

