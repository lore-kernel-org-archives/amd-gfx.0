Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7DBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 06:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC3710F097;
	Wed, 19 Jan 2022 06:23:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22AD510F09B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 06:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyX9V6Y1/LQN2c+CdsRMkHKf3bUBuvD4pL9r1j8AIVODay/IwoBlf8rifcKTAbxgKlcjJMYdDr89ed6eUzoD+xGDbFfmqAk+QixWmkSuDAvBncixjsaSsUyXuAqiK+GMRVUm0lw+xya8qUI1khRzHZEAL1Heuvd3+XGFC4t1GDIktI913I5hqFYmHboSBU5JbhZ/CYq2tNfTObT1n1x4hFRA/pLlsZLpS8aSN0bvchzMq5ZlUkyTOiEi6TYgI9AIbHho9JnZsF998DfdCEebRsLAPBl7tastydZZ0tmu/RrH0BlA+bxM2cDOX23pxJ8pmh/7kNMsVOXNJlOnpqRTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgMLClHAWtdceoFiMsi9322LM6LsH3Pimet9itYpEh0=;
 b=XXyoTxO7KlsprrNmPQCO8RP5ko2G9g3L0f4rFrRm7sulu4mpg35KOJEq79zwWAlLndIrBe5mBEM7mTYau6e5yPU6WDyEIp4qdjhdN6cjWJxCRsyQ+J/uLhss2maDdQtwgu7dKwzXPIQm451Oj6pZGB2NhusBSyiRMHAUKBb6w6vfTWEOPo5umq87hQInDDqkjLM7TYMbO7daG+8ZYwo0m4g9tK5QeaA0+M73aj5L8eWAZavkIJlWkYv5HNtG0b+2JCRysdBSHQJ/qGw0fnrF3oRbwG1zUEneD2NZCKhDw+QQWg59k9i93COJEwN4zju+b8nolQrKTxfwRFbMsAamUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgMLClHAWtdceoFiMsi9322LM6LsH3Pimet9itYpEh0=;
 b=MAf5Hzr6JBdQjqGX2E1+vqEBtfcClQkw0xELoHMBRruCu8OS7TFnhAFLzwp4vz7KHDrsghkaN8B7HZ6RYVxDNxMwB6ok0SCP2WEp5oWx2WPXfDlbwL/9mnkNJXa4VBILjz0jXHazWf5eBhn2y7zIS7cl1fa1FItQ9fTPL1TiwTo=
Received: from MWHPR22CA0072.namprd22.prod.outlook.com (2603:10b6:300:12a::34)
 by MN2PR12MB3136.namprd12.prod.outlook.com (2603:10b6:208:d1::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 06:23:11 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::7e) by MWHPR22CA0072.outlook.office365.com
 (2603:10b6:300:12a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Wed, 19 Jan 2022 06:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 06:23:10 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 00:23:08 -0600
From: mziya <Mohammadzafar.ziya@amd.com>
To: <Hawking.Zhang@amd.com>, <lijo.lazar@amd.com>, <john.clements@amd.com>
Subject: [PATCH] drm/amdgpu: remove unused variable
Date: Wed, 19 Jan 2022 14:22:51 +0800
Message-ID: <20220119062251.2788108-1-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc706c4a-8e2e-4346-7d9d-08d9db142aaa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3136:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB313605370F9DA4EA8204DC4998599@MN2PR12MB3136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZzwWa5evKj/JxeGNmyWK3RYb2cQJxDVzKxADpBIq/KShXiagC1dyhyAOrlL+S1kv9NfZ9QK2nYanJcRAE2/P/jeIdy6XBt8bxVlBcGCGrQgNQWLz2o/uc+FgLYfZO19dDeVXO/aY9g3QG1wob73tK/6QQu+jdmnTFamKA60a6JlAONvoyZj7zCuHTG9y16dfYiVvHErf64u0QlxOsCSOHVQ8iXrs+i3Jc0XrFmJm2g0B+ZXx0+mtUzISIySifXqyU7wxgbydl8mwlCwI0lin4zP/4nE92AmogfGHXhaYHjuTeGzOQU25tK4G5TIs61R9Vf78DtT7/8xAPgSv7jjy/NH1QP/nguWViVxoqgxNsY/OORuDEvDhOLkjYqlTFn40i8twkZ7uSKPOl2zwB+NrJGJFO8tbxONDUxPm/pMDtZWvm0qms6WudbeHXtMyp00xkXjFkiVa6nxHruNe7jY8/AsHidWZZyZGtFPu8Rxa1VcZ1ejA+0kf9DWpEotPPsYr98IgtI1CyOKl2iazELUnNrIR1LYO/Xy4xdkd9z3uDhJxGFD4SW7mlp/TLjgpCwVT9fAK3vHdg3FEdMLOo8Q4Gi6412ZomoOpnItS0ht6OnQDmVwfFMR997e+KsdIbQLRCNQNEzAlWFqo1WI6s5Kp1eNh+E0GDtX49HasO1eerb2vQl0g4b00iDKGA2LCKXjIEEDTsUbV3uAmvxknXFZWFZmFQVBFCNeoBBm9EZ43xqsYb2sj5pJYOuSsyGS7U+k2GyD2rIwGJn4T7Zu+FlvdPOJBx+7dfWhGvaORMwV1TRXqTVfES9yA1kIsiQywBT2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(2616005)(70206006)(508600001)(70586007)(2906002)(4326008)(36756003)(26005)(8676002)(16526019)(186003)(36860700001)(47076005)(6666004)(426003)(336012)(82310400004)(83380400001)(5660300002)(40460700001)(356005)(81166007)(54906003)(1076003)(316002)(110136005)(8936002)(4744005)(86362001)(6636002)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 06:23:10.9562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc706c4a-8e2e-4346-7d9d-08d9db142aaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3136
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
Cc: mziya <Mohammadzafar.ziya@amd.com>, kernel test robot <lkp@intel.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove set but unused variable.
warning: variable 'umc_reg_offset' set but not used

Signed-off-by: mziya <Mohammadzafar.ziya@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index 291b37f6db4e..05f79eea307c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -94,16 +94,12 @@ static void umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 
 	uint32_t umc_inst        = 0;
 	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
 	uint32_t channel_index   = 0;
 
 	/* TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC registers. Will add the protection
 	 */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v8_7_reg_offset(adev,
-							umc_inst,
-							ch_inst);
 		channel_index = get_umc_v8_7_channel_index(adev,
 							umc_inst,
 							ch_inst);
-- 
2.25.1

