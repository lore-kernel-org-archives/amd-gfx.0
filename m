Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D64FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 05:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC60E10E1B6;
	Fri, 14 Jan 2022 05:34:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E44110E1B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 05:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwxG27TlrpeosjmZytIdd6DHY/q0iNT/oejRAw18HSc8zmaNC81PB3X0jL+7RoRCwo2d/bHcEu0JRWPpifkAP8N6+EIzVy8sdMClJtJl+4MCae8fIPokru9dddba3C9Tmu3VfLpEbjJH0N56NeIzeOJVUe8dTUsxXeuWKexzIMj4YhgPr/0dVcJyXTU3gyYd/v2DCtoXTbBU2PbaSQF/1+6O+xpFGvK+PYdE231NFy0XMZfq+r2akZXc6a5yi6fNzYD/JChCFrqQ4kr9BjknFCTnDv9Ar70hvBMlTDQLcx80OW0lllKsSEYWXJBq0tyqBBPe8d3jwDjqMJNY0mnYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuJ4s/gqJi1bOp14lA/M9Rg1BSkm2C9Pi7I4rukBFzo=;
 b=TZONtc/rVA9boDkjdHPXaf0wipJeQhKeMHISv1ry+YzeogdGkeuakBCr7TfvO/9m5XgQyhi/NoGLm+6/UP6JNoYjveeRAL2CJctkNii8H/d8OKEHIAmS71DKWVW7AouZCeM1Q5CppEKNuSM+jA7vcqX6uAIJRFfjacEsbYa1iGxq7+EXfs23ZD7woY3j5D/ch5C9CfSjU6T1bJjFectCjq4sD2CRsv315vw5u0pgZxuMNcb3IcW3I/BBQNjqxilN39T6ITuYXDtAePBuNZSOpJBgXZs7zOoC2Bv0U9mThotT9M/RFheFrHvk0gk2GXYQSfFC50kKIE88WEsUhKIFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuJ4s/gqJi1bOp14lA/M9Rg1BSkm2C9Pi7I4rukBFzo=;
 b=A1xup6T4MrYkhr008E30RsPeNHmBK1KIKbaJs5rpfk51GnDqiC6m/1q1W2mn7itiTRYY7XB5BAhyJmEuFFz7q8WR3Im9wwNHee2ldvs7LDTuqrZEezrB2OvePzSTMuZ8tS2EUUdSyzb+WuvMpCWErtwTyJtOSa3SCjb/AHPYuPk=
Received: from DM5PR15CA0035.namprd15.prod.outlook.com (2603:10b6:4:4b::21) by
 BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 05:34:57 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::6d) by DM5PR15CA0035.outlook.office365.com
 (2603:10b6:4:4b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 05:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 05:34:56 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 23:34:53 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/5] drm/amdgpu: Fix the code style warnings in gmc
Date: Fri, 14 Jan 2022 13:34:05 +0800
Message-ID: <20220114053407.4035049-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
References: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff3af4b0-5d9b-48cf-0e7d-08d9d71f992f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4934:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4934CDAB29D4BEA8B739A400FC549@BY5PR12MB4934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zao3DwxR+NlB2F0zNdp5otVHVTTmToxVkUKIl7Ivy72vsU7C6jMWHbnS90ASfQvQF++qC3Z/a/R94/XymXjrf4bHd43Q8Xn824on1hESmS/Vix5Tip6R3QZ55mnUCr2Kfe4owHg+SANJ5w40+Udhw2yU+LB97TX4FvAaqiqGJ7ROYMhfzTEkLyjpv0ZedRqnLOdgnPv94I6qwFL3WN4wxU5yG22b8jzahyUDGiVkya7cSidVBSumdlXE7lVi6N1VQtqG0H/D+JRe1x2xW8dKyRclBXT8ArXenT75dv+vS2w1ZZ4cUGkO7WO+kxZNmMMQjA9K7TIXtd5z0D/JTN3OYvy+4nVoChy5NVIT48RhQL74yYqHmjouCf9RkxMqV0U0I0VZZLqLaC0MV8uMaM+no/uyVyg4DprjNyW8S3vcrnHsoc2SaXCWkWMw8j0hhzNpV96nCnoeyjBWg5QfxMiZagne9sFBCmun84cJfoAHz3k3OVxfZbVf533YuXFELAxgMvYUTovnq/FXvh9PWlYYgyLZcJx60xRFjJX2dyor6nrlfNYgNOcdTLtii7xMQYUzbu4mk8NtpNL5itwZ+x/akVePGuRn5F4MJtsCLG8UJoSpQLxZ52EovHL10VgZ1rno901ndOaNTdPho13lnxegdlMjSVazQE+FY7YjMlUizR2i55GSYwymUrzcR+GglBKFVStj58DWX7a4Z2ykVMzJ2+aNk53vKXjBA1PPXz/afC0+tXlcLl9vmh8gcau9FHCKGR3QjjJALJ+RARdz3gDCCiXAQqFLEnAPODiTdeLJk7jp99BCtOLYNRoIhE2uBltj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(6666004)(8936002)(36756003)(6916009)(5660300002)(81166007)(83380400001)(356005)(508600001)(70586007)(70206006)(336012)(2616005)(426003)(2906002)(1076003)(186003)(16526019)(4326008)(54906003)(82310400004)(47076005)(8676002)(7696005)(26005)(86362001)(36860700001)(316002)(40460700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 05:34:56.2810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3af4b0-5d9b-48cf-0e7d-08d9d71f992f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the code style warnings in gmc:
ERROR: space required after that ',' (ctx:VxV).

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5ef4ad28ab26..4f8d356f8432 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -672,7 +672,7 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 	if (adev->umc.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
 
-		strcpy(adev->umc.ras->ras_block.name,"umc");
+		strcpy(adev->umc.ras->ras_block.name, "umc");
 		adev->umc.ras->ras_block.block = AMDGPU_RAS_BLOCK__UMC;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3965aae435f8..c76ffd1a70cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1231,7 +1231,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 	if (adev->umc.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
 
-		strcpy(adev->umc.ras->ras_block.name,"umc");
+		strcpy(adev->umc.ras->ras_block.name, "umc");
 		adev->umc.ras->ras_block.block = AMDGPU_RAS_BLOCK__UMC;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
-- 
2.25.1

