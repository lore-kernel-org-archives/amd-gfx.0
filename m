Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3DFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 05:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0BC6E530;
	Fri, 26 Nov 2021 05:25:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC396E528
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 05:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5r4HJ0xG/cxD5lIgtoPJYHugn0KT+gwuthY/vlmFxGlqPlkqBdIDnE9yohk1noR9b0zODHqoBGajm2KNY4HfSrImV/q+tPefaMEN028+P6XMbpHwW+lpka6tLRaJkjq5ZCX70TISv7mQHoV1s5QqifTV00x57HH1cbPHtNU/+O3DDOxIqDNG/aGVk5kSe2f5MmSKBjxvIDgYBjuvA4CgbP6UJZ1o0G1E08oFsUxKADgacLttbtehLNV/2AhhlLTLHXm9jMZbZiqmh2Ll5oF8n0oq+8VsdwfQj/4QDlvsP+XUgDhXsAxrpT0HfSKbo24IPnRE+q9mJKg5NS2/An2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVosNKeIWnGGWnCEI3qF4g9U2HtRx9eYI0Exl0dBHQA=;
 b=gqFyDc1rSlKzHap6d/JwYfsuufWWOgKtx0RoyieGHOEryJWJoON3kFRiNR1FuV5mBtod4E3R466y4BCzM7ktZkzW4U8Sts0KnMasKVc+FeiuBj0M4wiha18DBTf7s9sWIQK5Xm28Qwe9XQLZ6A0Lbfz7wKg0lZSUcwkjn28naKkAFb2pd/9kKwfar2HEfRT8sAfdfq5nel/uB+X8bKxqFW+lYBoK5eNa3KWRFlsx0o+kLGfruMr3lAy9HlIZxPytgNODQHUIMBtyDef0DUxXLs8Z5H6q4CQQUAC1x5AHopCzM9DI6kylOq1wtRR7DHgHgsxYteRAsdIrluTv2laXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVosNKeIWnGGWnCEI3qF4g9U2HtRx9eYI0Exl0dBHQA=;
 b=2NjxTdmne4fXgeXAulUkd4pmetv9vO5bU2ScUINwyEk56rZUCvNzyY6r5zG/jk/rhRBb1c9oUDSkDw2THblJXgodNtB6+N5WdKxTKXvuJXZRPZeATvv4/kAHo3vbj1lnwhLEqGSDpb5UK2wblRH0zCj9cgb5UH1dXwezCzNYtRw=
Received: from DM6PR02CA0067.namprd02.prod.outlook.com (2603:10b6:5:177::44)
 by CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 26 Nov
 2021 05:25:24 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::55) by DM6PR02CA0067.outlook.office365.com
 (2603:10b6:5:177::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Fri, 26 Nov 2021 05:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 05:25:23 +0000
Received: from lijo-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 23:25:21 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: Add warning for unexpected PG requests
Date: Fri, 26 Nov 2021 13:25:02 +0800
Message-ID: <20211126052502.134980-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aa1b830-2b9e-4442-287c-08d9b09d2582
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3990E81C33B756F33F49F52397639@CH2PR12MB3990.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBynFBQQ+FdiNxOwiVnHwOxNCyGs+YkY6RrlMRW7Emg9iYG92d4L0JeAsrDbhahejc8VXK1BZHF+y2G4z8O0oaVHttBLGpZQ16d6CP3pTWQODN9HFDxgIn6LFRenMSsgulMzaFDgbM4xzHRKR0qBLyvACw0FtD3mAj3SpvGpiahV26bX8JxUHtNRYtQyuLY/elNMV6BHQHn/EEDARjHXEjbEfVtBwylMrSorOHcDvTBGm4HhqPNX59acHjWrYOBB/knAmoHdtC86zuznBqiUdoh5iwGF8LOq1Gj1DnauiXsUSbJq3e5fxTh9emRas7bgmgySaC+z+T1pqUq+avq2Yzpnbz4tU84XPSQkfo4NvTLqQybS7fjv10VbbPzX3LnkZOaeRs+7lSy1ePv9coa6UF1HbPlZGOjl46MpZKP6e0anr/9XsRDg9D5iuGKzULWFFtiFRdi5kf7It+KOxfk6JQXnmb9HcJmNZHy1vCki6CaflFfvpHNbNh60BqMinQBbiA1WVv0rG271Mpp43n9Oah12PnJ21/xL/ly0hf+jzO2COtraHF9ZKcALP5Ckrb90OjCWHS6ChnoFWDGivSkph70WGCs3h37EjgFNRYcJ4aSO0WL7GcO1XHVmjkz4d2m/neFPCgDzk7uUwxLz+2T8ZpqOs6rXBJg9HmRsH5Uu845XlQ6eckjmyKqPHXhvRxsq3Weh5nnY8A79js+OdK/q3zFDYZLv8gGAoIMn9qSPt6E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(6916009)(8936002)(26005)(83380400001)(7696005)(82310400004)(356005)(6666004)(426003)(508600001)(47076005)(44832011)(16526019)(8676002)(36756003)(86362001)(336012)(36860700001)(1076003)(70586007)(186003)(54906003)(70206006)(4326008)(2616005)(2906002)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 05:25:23.4217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa1b830-2b9e-4442-287c-08d9b09d2582
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3990
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
Cc: Alexander.Deucher@amd.com, Mario.Limonciello@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1: Ideally power gate/ungate requests shouldn't come when smu block is
uninitialized. Add a WARN message to check the origins if such a thing
ever happens.

v2: Use dev_WARN to log device info (Felix/Guchun).

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e156add7b560..ea99afb38d2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -277,8 +277,12 @@ static int smu_dpm_set_power_gate(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
+		dev_WARN(smu->adev->dev,
+			 "SMU uninitialized but power %s requested for %u!\n",
+			 gate ? "gate" : "ungate", block_type);
 		return -EOPNOTSUPP;
+	}
 
 	switch (block_type) {
 	/*
-- 
2.25.1

