Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B89C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 08:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4774B112B93;
	Thu,  2 Jun 2022 08:16:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BE2112BA0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 08:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/RNlYMJL/s0jkqGTPViK2BfriewK6ETrKhgMo9eenqIX/AEWDY1Q8DDYpdqQswlpz/U0mS2ty8rukCiYJiQ0ckcIGZbkkBk/m/snE2uWBtZ5sl/2W4UFi6po/JBMfF+2izTiyyvO2THEqiRs2rE6nnhXY8H3pj4rU4aq5lSv6pmbX1OEoL/yGSM7zkMSlzGZiF61nxeTZIXkGVYmENcVTEpWyxUbMz9Qj+cN/5QGHEc0e4qk54pSUjCztJAGkgyXc3Ufnptyv1YifZm8e7eIaGDnSKQZRBal/+WrDiUOTfSQ5AVx1Rzqa8B9VwQVouaV+muBrP3iajqEpNYzqALlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJvVnqBO/UYzBbd+nSWUAETgfBhZE5p28s7ysxe6BfA=;
 b=ayC1JbgKbv5kVrg+CcMsOzx1CWb1glAEJZ4TzkWo1KPcEc/1TntcSCyRISjYgaMqfETa2cozGVW3Gjy+g+XW+VtBAfU6W9IOYe+L0vV82An3rQQ7VdLlPTpaSzXN/Ao77fPKUan380UTADXlx+Bhx/IG5GSYIc4f0INyeKrklSbNfj9q0OdRa3kWCN94RQYEAXG+4F9Myl1tqKHJp3Ikor/5gsVccdJYQGgS7OhGz6Dk8SQGc/i2vXirhgdNud9KozrQ9gBY95Ft62AsPPULq6TBUdFFv+NzVbZU0kEyOcVhw/sm+F/NQMg+vQgjPBIp4GrysqWDiUt+1MnMzVKxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJvVnqBO/UYzBbd+nSWUAETgfBhZE5p28s7ysxe6BfA=;
 b=zHzQrXxRooRa8TLjzMnL/qx8w4uCU/I0X2dyX/6qeZ8s3bqTyS122ryd0OYFTrWjLUrSGY/NCgBY9uQH8EVFnnO7IUunWh6Pqzw1nQGjX0BIY5zf03oXuEMTEZ7pj4WxqK+tqCuBLFTsIu08spKTYfeZZcSDxnyCMlyiI6k2b2A=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 08:16:01 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::24) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 08:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 08:16:00 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 03:15:58 -0500
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Date: Thu, 2 Jun 2022 13:45:37 +0530
Message-ID: <20220602081538.1652842-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 503e2bae-bab0-4f5a-279f-08da44702124
X-MS-TrafficTypeDiagnostic: BL3PR12MB6593:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB6593F9180BC2ECF70532393FF8DE9@BL3PR12MB6593.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hx7pOuyWxGkWaataQdIt5ec/pAOfcp0IjpCnMjpz8FxZVN0C96IjzOzi4sfBn9TiiYg0GKjjcBp5teFwA1mML6el13xBV0J3+pdb1VcjMpcErAsxnZpeMN+n/gLGxDH9snCrsU3433iNKyJ/X3C41176oJly+OngYx5y1X8ulsRC1rUFKCPyZ2Ct+dEj1NXES+Fj2Ped/ISwxoBfNoCUBQTPMu8yXYAe+zMs9dMT7cAj47u8GL8GX11Tpeswu9qZPVxegjMf4Yf/aViWwKVTgdtRnORXG5E69JY5LtQU2t+R7blB0XIqZ8rOKi6VEtGQku6dfTHkhkzFqscHmv/SwPRxrnPtxRqp14ax5Fj3TyLH3eqLLHlPM4GCqX5G1FG8NgETWKMLW3OIhyLLqNEB5/3hyFHL/6U7cxlIFWZK7rzXkGqB0yrwnnO174I0GPWuHX3VESkTpGG/b0LmbLqLAE+ZvaQ2WSusorHsY5Gld4DUZbqcegALoAwJ9oJQ5wZUQtZfBwv5ngIXIfMUSG+WjQYU7aYAGc8pVFoary73gFJCbdvv003u5ryOa7wjiM0ZHmoREezjwzgySlp8gN/ezWg6NbSFXeyMAe157steS2+wOi3BrHd9i3uweD6z4J3RclRqOOPzPgKZ919AxrUJvtZQWNaloyH3DI1IW2HF6rDEVie1NwSQKwcIe3lP2gjdhuUPHLv0Ub/WC2EbahNNbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(1076003)(40460700003)(7696005)(81166007)(16526019)(186003)(356005)(336012)(426003)(26005)(2616005)(86362001)(8936002)(5660300002)(508600001)(316002)(6666004)(6916009)(82310400005)(54906003)(36756003)(36860700001)(8676002)(4326008)(83380400001)(2906002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 08:16:00.7671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 503e2bae-bab0-4f5a-279f-08da44702124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate memory for register value and use the same values for devcoredump.
v1 -> v2: Change krealloc_array() to kmalloc_array()
v2 -> v3: Fix alignment

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 6 +++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 76df583663c7..c79d9992b113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1042,6 +1042,7 @@ struct amdgpu_device {
 
 	/* reset dump register */
 	uint32_t                        *reset_dump_reg_list;
+	uint32_t			*reset_dump_reg_value;
 	int                             num_regs;
 
 	struct amdgpu_reset_domain	*reset_domain;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index eedb12f6b8a3..f3ac7912c29c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1709,17 +1709,24 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 		i++;
 	} while (len < size);
 
+	new = kmalloc_array(i, sizeof(uint32_t), GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto error_free;
+	}
 	ret = down_write_killable(&adev->reset_domain->sem);
 	if (ret)
 		goto error_free;
 
 	swap(adev->reset_dump_reg_list, tmp);
+	swap(adev->reset_dump_reg_value, new);
 	adev->num_regs = i;
 	up_write(&adev->reset_domain->sem);
 	ret = size;
 
 error_free:
 	kfree(tmp);
+	kfree(new);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4daa0e893965..89c6db03e84b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4720,15 +4720,15 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
 {
-	uint32_t reg_value;
 	int i;
 
 	lockdep_assert_held(&adev->reset_domain->sem);
 	dump_stack();
 
 	for (i = 0; i < adev->num_regs; i++) {
-		reg_value = RREG32(adev->reset_dump_reg_list[i]);
-		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
+		adev->reset_dump_reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
+		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
+					     adev->reset_dump_reg_value[i]);
 	}
 
 	return 0;
-- 
2.32.0

