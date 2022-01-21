Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F57C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 02:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A9010E5EB;
	Fri, 21 Jan 2022 02:47:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D25710E5EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 02:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grWAPfq0dw8MW9uCVjuNGRJnfAG6vEZen+6kVrBzGTVniczvZR+tVCCoYTN8bBwuyAGESLA929INZOgLdmX5oVjBlYl7hSnNAgDT3M/fM3JRdw4CuHv5upE7Juku9tod6kugj5Ql8VdHQDjtq3KkFhEAWRbc5Ks5P6dn54TfJRUBOlonYxp7JKC/Mei8MxVV+MAcVotpeYDdjfYcMZDyus2iXCMiKsKt410R+XJu0uuWaqe3YSS4m1yBVlqYC2cEAPsVjVtmeSIA2yeoTP5+nrs3y4A6ZnvvMrYmZaXf+8gFL0ZdX9JZ5E89EbF6m6n2KgiQAM9geF+q/hAiUjK72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpX0BV7NErIGvbJ4fzQGb8fcJxLCvuoB+rOUTMUTQrs=;
 b=Fssl3Wtn4W/r/D39PhbxpzdktJVgVIfY+2Cz3zL4Qct/m1Tg6J/FWpLtq4pUj+gNhnVbZWFAjtPt8xk7moCn0tiX75q5LHrRvNyFYa/R00Xi4vW5CT0+6EmmHN87i/kxZQWWLeifrQVfUe90IO3jXWKCmFT3tiBXa4/eXyPH6ioDHUDGZfN+Qb/pvKN2tnHL4+5JAo3yXgRKbQGauxfYNeYSfpCDSktQVoLm9cHL7aQ7TkTaqBht8yO4crtLuWUhTC1HAbtQtaofY0BKpH9HmUlCCsyOTfMeoRWN+eODg0GxJV1htjCeJcSg8E4KaqVlXPar/H7xaABxdbpywkI6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpX0BV7NErIGvbJ4fzQGb8fcJxLCvuoB+rOUTMUTQrs=;
 b=qOhb6TirMCB4z27BlWJjA6vnfnLILksFih+UujC6NbqISYnNHb4LuHVvu4UNdia4PavCaltBkguuQBbL/Q9YNM91oVC7SpO2gz15WnbKwLwEGT3ioVvHVzYBCaHPO738AnpTiwemmaOPI3eCtf9jgJ1X8EzzqyHF7/fpkrXfdp4=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 02:47:14 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::1a) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Fri, 21 Jan 2022 02:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 02:47:14 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 20 Jan 2022 20:47:11 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <evan.quan@amd.com>,
 <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: use dev_*** to print output in multiple GPUs
Date: Fri, 21 Jan 2022 10:46:39 +0800
Message-ID: <20220121024639.810-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e891c6f-7f76-47ec-1e3a-08d9dc88548e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1145BA646F4681DEDAA34016F15B9@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPRZ8F4K9gntO9i1TDTPZBQHIdFYhvgcv9uq3i2IO99GdBLi7BXioHfgs1zaHfhx0w7uxFy9jHX7OKUgTqZ5HpD21BLbivBctyogLSMZ7QYcUt+pPZmsNrHbHjIAeMScKtMIX0qwzHzJgEeBJadtj75cEmlvJB5SNsQowb9Yv7880My/wzOuxYd6we9n39bcvSL4EMGA2RsVLEOZZUfz+zAVOSNG+v7ucU/jExYkAv1zImtyx33BrrFy7PmC8ow+Hj8KXikcigQwHrt5U15SvjJpLPxqvTe9uI7XAw9gdkduiDBAkNXbCFJN+XdZQjBkz3eOOYLfNZplF+kttypNrYm/pXZdf47m9znfXyxN+LnRXwIK+o7TKSWmC7jtpGU3G50/4A8zrtjNou/uSE7zDCgzUQS/fsIIoiNZ51vwTVE1WhsCK1xJV5Gg3/6gPaoemD5iSLBaXBiUxOoJqX583Lo6z/uEk+fRzjUwayssfwdR60mPv7Gcn08yhzFunn/Zy8tmVzRq6kkSYlO+hiVW2kNG53GylwO/BSR3/tr99nBSBVQ3X3lt14j5zgKb/O01l6MBcJ5wCoDGpftAbD/UwVyAQeytiekG1cFCTAPSteWyT8JTBfyYh+ZV7zk4IJ2u5uOy0gtWhC8IzGSSfxr1KXivRgAq6yJIsvNG283pLIlQhoP0GKaN8MU1NNfRCU9w7M1T1V0Mt1bwgKkcjLMSyKAGJ0eQtj5JzwpEPfyrYV5858l7EAgwZV9MGEd1k8zKEH5gTsb9Dzr2ljw58piRWS8CqW5UCrkzyg9wH/vBClAqpZAlXML60YaEH7amS2p9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(16526019)(508600001)(8936002)(426003)(70586007)(44832011)(36860700001)(70206006)(86362001)(2616005)(2906002)(6666004)(47076005)(83380400001)(40460700001)(4326008)(316002)(6636002)(336012)(1076003)(5660300002)(8676002)(36756003)(186003)(110136005)(7696005)(81166007)(82310400004)(26005)(356005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 02:47:14.0336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e891c6f-7f76-47ec-1e3a-08d9dc88548e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In multiple GPU configuration, when failed to send a SMU
message, it's hard to figure out which GPU has such problem.
So it's not comfortable to user.

[40190.142181] amdgpu: [powerplay]
                last message was failed ret is 65535
[40190.242420] amdgpu: [powerplay]
                failed to send message 201 ret is 65535
[40190.392763] amdgpu: [powerplay]
                last message was failed ret is 65535
[40190.492997] amdgpu: [powerplay]
                failed to send message 200 ret is 65535
[40190.743575] amdgpu: [powerplay]
                last message was failed ret is 65535
[40190.843812] amdgpu: [powerplay]
                failed to send message 282 ret is 65535

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |  4 +++-
 .../gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c    |  4 ++--
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c | 11 +++++++----
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c |  2 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c   |  4 ++--
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 93a1c7248e26..5ca3c422f7d4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -208,6 +208,7 @@ static int ci_read_smc_sram_dword(struct pp_hwmgr *hwmgr, uint32_t smc_addr,
 
 static int ci_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
 	int ret;
 
 	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0);
@@ -218,7 +219,8 @@ static int ci_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 	ret = PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
 
 	if (ret != 1)
-		pr_info("\n failed to send message %x ret is %d\n",  msg, ret);
+		dev_info(adev->dev,
+			"failed to send message %x ret is %d\n", msg,ret);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
index 47b34c6ca924..88a5641465dc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
@@ -87,7 +87,7 @@ static int smu10_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 	smu10_send_msg_to_smc_without_waiting(hwmgr, msg);
 
 	if (smu10_wait_for_response(hwmgr) == 0)
-		printk("Failed to send Message %x.\n", msg);
+		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
 
 	return 0;
 }
@@ -108,7 +108,7 @@ static int smu10_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
 
 
 	if (smu10_wait_for_response(hwmgr) == 0)
-		printk("Failed to send Message %x.\n", msg);
+		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
index aae25243eb10..5a010cd38303 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
@@ -165,6 +165,7 @@ bool smu7_is_smc_ram_running(struct pp_hwmgr *hwmgr)
 
 int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
 	int ret;
 
 	PHM_WAIT_FIELD_UNEQUAL(hwmgr, SMC_RESP_0, SMC_RESP, 0);
@@ -172,9 +173,10 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 	ret = PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
 
 	if (ret == 0xFE)
-		pr_debug("last message was not supported\n");
+		dev_dbg(adev->dev, "last message was not supported\n");
 	else if (ret != 1)
-		pr_info("\n last message was failed ret is %d\n", ret);
+		dev_info(adev->dev,
+			"\nlast message was failed ret is %d\n", ret);
 
 	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0);
 	cgs_write_register(hwmgr->device, mmSMC_MESSAGE_0, msg);
@@ -184,9 +186,10 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 	ret = PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
 
 	if (ret == 0xFE)
-		pr_debug("message %x was not supported\n", msg);
+		dev_dbg(adev->dev, "message %x was not supported\n", msg);
 	else if (ret != 1)
-		pr_info("\n failed to send message %x ret is %d \n",  msg, ret);
+		dev_dbg(adev->dev,
+			"failed to send message %x ret is %d \n",  msg, ret);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
index 23e5de3c4ec1..8c9bf4940dc1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
@@ -126,7 +126,7 @@ int smu9_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 
 	ret = smu9_wait_for_response(hwmgr);
 	if (ret != 1)
-		pr_err("Failed to send message: 0x%x, ret value: 0x%x\n", msg, ret);
+		dev_err(adev->dev, "Failed to send message: 0x%x, ret value: 0x%x\n", msg, ret);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
index 741fbc87467f..9ad26c285ecd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
@@ -115,7 +115,7 @@ static int vega20_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 
 	ret = vega20_wait_for_response(hwmgr);
 	if (ret != PPSMC_Result_OK)
-		pr_err("Failed to send message 0x%x, response 0x%x\n", msg, ret);
+		dev_err(adev->dev, "Failed to send message 0x%x, response 0x%x\n", msg, ret);
 
 	return (ret == PPSMC_Result_OK) ? 0 : -EIO;
 }
@@ -143,7 +143,7 @@ static int vega20_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
 
 	ret = vega20_wait_for_response(hwmgr);
 	if (ret != PPSMC_Result_OK)
-		pr_err("Failed to send message 0x%x, response 0x%x\n", msg, ret);
+		dev_err(adev->dev, "Failed to send message 0x%x, response 0x%x\n", msg, ret);
 
 	return (ret == PPSMC_Result_OK) ? 0 : -EIO;
 }
-- 
2.17.1

