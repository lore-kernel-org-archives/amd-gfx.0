Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AF4C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 15:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7D910E12E;
	Wed, 16 Feb 2022 15:10:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A488310E12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 15:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz9aztpT+GMJR59bDNOE4abKvRwlpcrX3cNeSbc0dSrO/7sKzrPrgVcWFdxifQWj9Z6zDzZqpta/xWO0i8RrsmzlhN/En6KNAbdFZxyUjeeU+xGNyKUFwNBsWxB05nGP43gF1K2ZRyaoXyT14nplFkLQgV0z104DOX4SiWt3Xu1QY3VW1fQMcs2BWBOG3oQqdFgsTn9Vr6rSYwYAyusmMjV5Mec3oNaN4sQRX+3syLJOiYlO1Y2CoBZSrAE0Xuj195Xz2QheCAfyFo7idz8Jdk7i1seMsUf60HhxU5Iy7ICoc6UcQt/a4qR33ofSeLD3TSuztp83MH6BPqsF56jCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psF+BZDfcRuw+BDOlIBMD31lPssEAMiUYO95zswad5o=;
 b=CKCyGn9BIPxWSvLnV4Pj2HW1bNa3CsunmrlMLAbd9bBi55HgdVigZBwYDg67UjPHLNN2eQmrLYG4GPKNR0n2YjWTw9TDFw38XIHB2y5Q8fFy/UtnTiVTOuoaYuvTnqiWluKmIdc7RqhU9TKBltDk3SVvbgMcWMQF1HdAInsRu7Oojz54zlMUEvhrlSiJQ37z66Y7/PVzRuonA7CBXjzueRFxkKFQoIEZso+L2NFaYUeF7IST5K70Ljjg4pJgojzJJUKXhpIlGo4uwcWPNZjXyAgLaOtjuBEvqZqfvfs6hTT07b5eUS4ImQbaEd4z1HotIFQiGLlWFrkius2VU9JSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psF+BZDfcRuw+BDOlIBMD31lPssEAMiUYO95zswad5o=;
 b=FG+OiXYvfoQLr7Gttja4usudK4pBBjR1NWE7zFez+nSYPe78pJQOU28kktOAyCcokcFMZqm7L8uRYpXYrgix1asqUJ7Yrg0EBOXgYcrt0xYAcf86frrbUhFJveS7rIAD2d8G2jP5/fF/VEFcJ5CHEXYCOp18eGCfoZmJ4MeaiBg=
Received: from MWHPR14CA0037.namprd14.prod.outlook.com (2603:10b6:300:12b::23)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 15:10:04 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::26) by MWHPR14CA0037.outlook.office365.com
 (2603:10b6:300:12b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Wed, 16 Feb 2022 15:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 15:10:03 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 09:10:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: smu7: downgrade voltage error to info
Date: Wed, 16 Feb 2022 09:07:55 -0600
Message-ID: <20220216150755.2770674-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e38419a-7a28-4005-8a3d-08d9f15e688d
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5284E4CA15166DEEC9327260E2359@CH0PR12MB5284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfkZGBXmvd67/0BDR3rcwfnggS6nm9indp5Pp53No6lIHsL+k4lU45Gwek/zXNtNFxfw53Q/WkvZk6ml5EEk6meq7OBpoLyyXzhNsKztHxdEhEt2Jxz+JFYHWttUY4jL/+YU0CQan79phkHaGOwpLnC68bbXOyVujcVfli1U7UC6TPxTQ5JuMv790ANClNSJ3f3uJkkvhjd2oGl0t23hR9DyMuWiWf7gFJL1nXQcl6EJQmIiI80pgC7BZLQAm+xRa0mqss8GSWQpV4Yy9FuIbvFVYCfg8G2a9N3oXlCS54+gFllUkTFszzjmtIHaJDzxn2XH5WsbuANYPm4cP2ciztzTSKEFRcKmOBODTsKTV4W9K0+pASsA01hpxQTXz1k2FtUmigsR25FlSkcb56oUG76IEHH14HQQHUSlByae3z4t3Gb8290bSrJUhYdQJL2fPyIgRQcOSpyhf5UBgUn64fuyTMlMmnRmQKK+qolpk7yZMG89tiEYEiSQha4ZnGwYrmNSut/ej33hLJrkXJ9IH73MPm3ru/FQUsknqEiAbFgCqDWUYPDHOkQRzfqDJwEyx6R01+oQkPwPsfc6mmT6ADA8tqsnhZ+kJV2VAWMqYHCoJRhQkE0VBrlb23Wt+/KSokMylgysqHP8BZca4xiACznYGFXI0oWYDdw5SRXm1Xe54a0ly+kcgRV2ThGbUqfNfF3ECR6FGjj18nv5S6FbFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(36860700001)(316002)(36756003)(8676002)(83380400001)(966005)(4326008)(47076005)(86362001)(6666004)(2906002)(16526019)(70586007)(356005)(336012)(1076003)(186003)(508600001)(2616005)(426003)(26005)(40460700003)(6916009)(70206006)(5660300002)(44832011)(82310400004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:10:03.1087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e38419a-7a28-4005-8a3d-08d9f15e688d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The message `Voltage value looks like a Leakage ID but it's not patched`
shows up as an error on Dell Precision 3540.  This doesn't cause functional
problems and should be downgraded to info.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1162
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index a1e11037831a..e4fcbf8a7eb5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2109,7 +2109,7 @@ static void smu7_patch_ppt_v1_with_vdd_leakage(struct pp_hwmgr *hwmgr,
 	}
 
 	if (*voltage > ATOM_VIRTUAL_VOLTAGE_ID0)
-		pr_err("Voltage value looks like a Leakage ID but it's not patched \n");
+		pr_info("Voltage value looks like a Leakage ID but it's not patched\n");
 }
 
 /**
@@ -2592,7 +2592,7 @@ static void smu7_patch_ppt_v0_with_vdd_leakage(struct pp_hwmgr *hwmgr,
 	}
 
 	if (*voltage > ATOM_VIRTUAL_VOLTAGE_ID0)
-		pr_err("Voltage value looks like a Leakage ID but it's not patched \n");
+		pr_info("Voltage value looks like a Leakage ID but it's not patched\n");
 }
 
 
-- 
2.34.1

