Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E604C7EE23
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 03:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEF310E099;
	Fri,  9 Jun 2023 03:41:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA9110E099
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 03:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTsJaPAucVFCB+HYKVwMO1VM6lpncAkeoJ2Vto1bhEqtJNFDk5V4fieKi7wbYZguRPhtIRPBeyPZDnF5BkoOO/UCMpVkveIuIYg6LrDnKN2y4Na1PvvarrvV2VjjwBChfpy2iRW7mAahpTM6Pok6/yq0GjzPq8XJ6BHNepcXh+nCCGcqXkAgjxp8B+g/6M06VkIFMDK1oj/dAo3Wk1ygJP4skBvQaT/iIHYCoM42OiZPSV8gYDZxeYnoaAPSyxFscP6T6bOrLKYHFWNpM7OtgZnKtrRd8b68eh7zmCmqpAu7cnwEMgpJbsOVE+DuyHcQ8lubR11/61WEiq97b04LgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmndNEq9x4fD4P21IHenRK6UxE+UYTJ9EVrv5AX+Tqw=;
 b=UpwRL23BoVWaWCd1LOIj5n/1iaX4embhsojW7jS9SE8MFUMD+gyhtkgvbJWJQB8ipCNqBvcazzWISW2jqXNwo81SducUpTNuQBGoyv078BIUloV/eqcC/1hjK2Z38ozgYoztGNgTuK5nr0ZV+FOLSzomjIOaqtXEbwLwfS6lhvywDozCy7Z8sqvex0XuYCjlml65Kcly8PpExo3oAsqwcSfXKItlAb/m79NsGYp5F9D4YA6O630XslrwbSuf1nYpzsXR08D8Jb54NRlWUSRhK9T5nUCh5XgMt2H8yotg11SfjdE/i2tipdAgiNihtMdMyNGoN9XplWXj0VkyAlGYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmndNEq9x4fD4P21IHenRK6UxE+UYTJ9EVrv5AX+Tqw=;
 b=R2aQVfcUKxsa75qupdJxvseAsu4tyqGWfQ3SsJh2MleQvzUuLnJ1MVqhK/vMualPjZABr35a9KimMmOPE19+AKeoNGACCyvYSyiIIZdLnoQqSEx4/qPfl4I9n7y/7rJrSDHx3zts/PjKY+0DNyPw0ukoiYcmdZ8TYDOhxhuZxJU=
Received: from BN7PR06CA0065.namprd06.prod.outlook.com (2603:10b6:408:34::42)
 by MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 03:41:04 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::d8) by BN7PR06CA0065.outlook.office365.com
 (2603:10b6:408:34::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Fri, 9 Jun 2023 03:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 03:41:03 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 22:41:00 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Align eccinfo table structure with smu v13_0_0 interface
Date: Fri, 9 Jun 2023 11:40:48 +0800
Message-ID: <20230609034048.2974488-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|MW4PR12MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: ca156532-92f2-4098-6b2c-08db689b59dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXvUjSTN4g9SjASSxk8FQ2V6xpkrncwf6VTg/lKUhtYW+wnbak+auphCivp0GCR0Isg8QunuHerh/KZQMkczkzOcyc4jBvtcz/6BOZKoExpoaVSM/xr0700rpXa6twjkyj23XDeuOUWa+b5IXLykMRWI8ureJ91i0YSqeVr/bPEZa7uUNiGeHtsLdRPdI/ruDcnBtSMWjxJDjGxYAsekbanfRSLtoOuBt0tNex2zixjYs/bgRy4nhEvvbKJ4IZXPQT47GY4dCs/u1Xnu9mv/WheZSibO5udEP9oPuaRNYmTnzF4me9M8MfAcwMPIdaPGqn+XE83dGft8Pct1ZckZkpAz3HAYP6gmHAvhfrYFDA8hUHvqCnoSPtYZ8mkySoLUt4NvKttKXvJTsHvJSl89xfukuW8AbDg9NDODci0BQ5Ixi3XsCPzmYDPcbFi8hXhgZ98R5PairZC8dufGd9UDC/R87xa9IWYIZPVUGoJSvrnzmnzimMtyRyvzU6qPdAsKFZ+udWc4zzvpa/tCxdBNgg7YziEoCvxJ/10bF7f1NkExi8Mo5YMn3OwkvC7321hxHhBa80ytvLiBfTlIPNLHfFfFy3Lj5C+6dp0vWXd5D6gvts5N3JKLiBNeJqkPJdoPvdwQADWXLkweeee6SaVUKCmpD3P/Mlghbleujivjak1IS9AZIBnESv1zeezbZN6pGWrSyLouGFLUxYvafd21M73U35snaHyu/I976wYLK7oXIdFtVA0INyjwSiF24FkHY1s6TGCb7lRy1pqCuowvBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(82740400003)(336012)(426003)(40480700001)(478600001)(8676002)(8936002)(4326008)(86362001)(70206006)(70586007)(81166007)(356005)(6916009)(5660300002)(40460700003)(41300700001)(316002)(7696005)(6666004)(36756003)(82310400005)(36860700001)(2906002)(54906003)(44832011)(16526019)(186003)(1076003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 03:41:03.9425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca156532-92f2-4098-6b2c-08db689b59dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432
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
Cc: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update eccinfo table structure according to smu v13_0_0 interface.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h               | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
index c6dfd433fec7bc..2cdaf746e8cd4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
@@ -31,6 +31,9 @@
 /* number of umc instance with memory map register access */
 #define UMC_V8_10_UMC_INSTANCE_NUM		2
 
+/* Max number of umc channel instances */
+#define UMC_V8_10_MAX_CHANNEL_NUM		24
+
 /* Total channel instances for all available umc nodes */
 #define UMC_V8_10_TOTAL_CHANNEL_NUM(adev) \
 	(UMC_V8_10_CHANNEL_INSTANCE_NUM * UMC_V8_10_UMC_INSTANCE_NUM * (adev)->gmc.num_umc)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 413e592f0ed611..90ea15496879c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2580,7 +2580,7 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
 
 	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
 
-	for (i = 0; i < UMC_V8_10_TOTAL_CHANNEL_NUM(adev); i++) {
+	for (i = 0; i < UMC_V8_10_MAX_CHANNEL_NUM; i++) {
 		ecc_info_per_channel = &(eccinfo->ecc[i]);
 		ecc_info_per_channel->ce_count_lo_chip =
 				ecc_table->EccInfo[i].ce_count_lo_chip;
-- 
2.25.1

