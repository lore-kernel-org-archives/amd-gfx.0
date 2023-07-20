Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20933EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 05:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A182510E041;
	Thu, 20 Jul 2023 05:40:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED96710E041
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 05:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEErZ9umHX86hd+vZQHqZ/K76mvBSeETnjnYED7x4W8DW5Nek/JV7FUWnD9C71H6mKPdhMf501A9m8cAccKJp/mUNWhaULdxrn9D5NiY0t3VWmeRHD79KDQespWVhs7L+F9sD1m6JGXirhz27MtiYr0azXD6I+hQGhsVLHIV7bok8f87LyUwD8Zfw7YTMrkUdjeYyzZ/NVYYKgpCECwhjtFPYxi12Qa+Lcj4XeHRfdYtBCYbugzg3/VNbGv+Og0CRiURej8YKa5kbamb07PTOHZsbhuhIFrZPjLd+xm3fzz7xKgC+4+gaXr9EasUnzoet/iBGXt3E+8YssEgmITnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHbsWxbEq7QZ53hpberLgQ72CEtcbB+bcwwc1Zb933Q=;
 b=iVgd9jyV4+KtZ88tVpCzYcogpd+b5jbBW7+kf37gZNykfGE48fDz0sddVaeaBYHVMiiFR+J/m56irOwh83roJa8ReN7X37Ev66LIWTS21lsSJ9hBgg/cJZWPbQvcD+bBHwO2MUbdoeQFGNNVO8ZxQZHo+UNOmD2KNI7BsFC0bmeYGgZgeEoWUrXEsBtCglpPCPLD4+vZZFQ2dJyliNVWfr/5i8p9ObayaDc1FmleeQKFstlxuGOAepYKwpK8YltX52tClVhkBRq58socnq2OWSWzJDhHq25D1XsFF1iLD1etLP7yscMzXnc04YUgZ24KLBYsDO19RjnpYEk38CFkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHbsWxbEq7QZ53hpberLgQ72CEtcbB+bcwwc1Zb933Q=;
 b=nLlVXXNVkQM9EB3BXzK619w2Tv9OkJCINSpxh9TJFZIuMDAhIZIoCs5pl7ttfiIxg6+22Blcm/UZ6hdJI2UWA8SdtecC7/qIriOiJCWUzV+L5wAcgOPhs7a3T+cJnL2AqS/jRXEfMsh5qvuEsqDKyNS/WwICTeNw2HIpEQ61pVM=
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 05:40:27 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::22) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Thu, 20 Jul 2023 05:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 05:40:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 00:40:23 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Program xcp_ctl registers as needed
Date: Thu, 20 Jul 2023 11:09:55 +0530
Message-ID: <20230720053955.3059635-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720053955.3059635-1-lijo.lazar@amd.com>
References: <20230720053955.3059635-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c91dd3-7507-403e-272b-08db88e3d27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsAFOMYLO/rgSDO8FcasIVnlP9zYSv6VuP3SY1VD1nygGNkfCbA+HFpQcPMMVhugs+fjwuDzQ6S98AfIGdQ478xbUfBVLH0m1TmcxnPaVqPIKcLJZQRlF57Y6VpeFsjqILSSQmBKe0mEfavlBqir4cmMUJO2IMdd7zVfGlnuLEFUT32h2mCEeWUeKTRqt953ogGSUwQ3CFVhNTJ9vTV4H9IPvREfLuS/YHk61oeZ/SHrCdiMDeHduxFbr56AUKKX98FIzfGakO0ZCT+jkoEk9bFk0ZCB03dERPIL/f9ELS2tCJEjDNXiQ7DfE4sFKjCL6S0tBs3pik1mj7GoEGNW+lIAfbbWDaBozGDnAUlTPTHHHLVzpcLELQDPuDHI+7qATR8x7SpG355bwQIto3m2HU1QhmhXnZ6FL2h3n7p6XxiYdvCZvXGy5f6iUSSAJgTTix9FdKpR61qoQmpQ5uR1dGP4YzltMg9xbQMIVmn3PeZ1aViZlJiKhvq1ZUKERWwiGRzc33+/bzBaU+i62ZNyy7+16DNGRmslNaQbM12QFYiXEeZa1DaglACRSdVCUGx0buyYaDWoAL8HEJm7Y0zWfVEWmb7HbdWU9ZaVOQvL+rYiGMa17TTNWxYLn2QCwrTzltD1uPSWgS+f/s3el9nSxqJcKlB/YWss00GxlV4c7ugDCwfOp4A8wtRfh6ZAIpr9QOM2Zu3BIUEe8rvRZDkT7QwRfLY7EjbknspYCKp0Y65JIy7nQS2ez29f2+swjzpZglDZvJh8lmRdElMypXU+7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(2906002)(81166007)(82740400003)(336012)(426003)(83380400001)(86362001)(47076005)(26005)(36860700001)(16526019)(40480700001)(186003)(40460700003)(5660300002)(2616005)(8936002)(44832011)(478600001)(356005)(6666004)(7696005)(36756003)(6916009)(70206006)(41300700001)(1076003)(8676002)(4326008)(70586007)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 05:40:27.1644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c91dd3-7507-403e-272b-08db88e3d27c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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
Cc: Alexander.Deucher@amd.com, shiwu.zhang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

XCP_CTL register is expected to be programmed by firmware. Under certain
conditions FW may not have programmed it correctly. As a workaround,
program only when FW has not programmed the right values.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 28 ++++++++++---------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c0855c3769d4..084ba50924e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1037,26 +1037,20 @@ static void gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_
 static void gfx_v9_4_3_xcc_program_xcc_id(struct amdgpu_device *adev,
 					  int xcc_id)
 {
-	uint32_t tmp = 0;
-	int num_xcc;
+	uint32_t expval, regval;
+	int num_xcc, i;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	switch (num_xcc) {
-	/* directly config VIRTUAL_XCC_ID to 0 for 1-XCC */
-	case 1:
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, 0x8);
-		break;
-	case 2:
-	case 4:
-	case 6:
-	case 8:
-		tmp = (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
-		tmp = tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, tmp);
+	for (i = 0; i < num_xcc; i++) {
+		expval = REG_SET_FIELD(expval, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
+				       adev->gfx.num_xcc_per_xcp);
+		expval = REG_SET_FIELD(expval, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
+				       i % adev->gfx.num_xcc_per_xcp);
 
-		break;
-	default:
-		break;
+		regval = RREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL);
+		if (regval != expval)
+			WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL,
+				     expval);
 	}
 }
 
-- 
2.25.1

