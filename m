Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FE1CDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 19:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E9510E321;
	Tue, 17 Oct 2023 19:37:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B959510E321
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 19:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7HMaPJku9F3T4vYqoqwuXiH2JX4qdqTvSIUaVCmGlKST+Lxg3MKQEBbtooAM/AgTsc8Axtz26e2f5eai79VVEk2PhHj0q8uOMIPX6Uc038lcCGd+gd5XXySRFusX6RU5wTdA9o4lGEhut3wqm8KxaPjk2uzses0cz19+Q4+o5A/fnqCW7w3t3WOhKO80lOrBry5acFc7KBEaNKfG3FK8MuC7CBtRroCaUKSloS9zyJxG+OKKWot7oOyx0NVISEsH9q/69+OHtBvEyEAf+/pBjkMFqTXbfHIpdGreDSp6wHf5dftSCljxG05k3aAg8E2abybJMPaRbIb1eAaBa4Iig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+o/OpcWezk2r+ibXXhtWwK9sOai8SsXb+o/Mer4mUzI=;
 b=aAssMxgr7gPTBfSrmvlwf7dKhqjnQy6Rjozx3xcXi+BTRDySCLy2tfmFnEpsX6BV0QNaWs3onIgjxqnqlr4DXyDYCajhbXtFTblsN7431YYMzTOlFGrSiSG8JhnBbAo4KVvh8NMUORwz2kj/PnYaieR8m0yRWZ26Y1Em3zgIIhGEaVuL9h8FsNg89fKSzzfNMFYsisDA4X+3rgW/XTSqCEyuhQgvVEZb2+3w/xLbUW9fObu13AJfm/RRoz10gR6oJlLhFuIVR924/CRsMfEe/2MTl0lof/SSwYEY/pAGmUu5O0fGI76kK2GdJWXZUhjbyPt7rr6otGuX8nX3FCpUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+o/OpcWezk2r+ibXXhtWwK9sOai8SsXb+o/Mer4mUzI=;
 b=4AEo+8klufKpUZQerE1XH5PQ2155ZQZgpEPT8824q4fqhHJoUs2l8fOXMtDoLdZiuff8VGCUEJZz/uTKMNvCdgOXAxFxH0nhegzhBIZrbo6pM3K6+XaWMjpeJ/87INh1J9mWbOUf/be0MzHS06rapsSGEeqYtUgLgk8Tp6eQ2LU=
Received: from MW4PR03CA0214.namprd03.prod.outlook.com (2603:10b6:303:b9::9)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 19:37:55 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::f4) by MW4PR03CA0214.outlook.office365.com
 (2603:10b6:303:b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 19:37:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:37:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Add missing kernel doc for prepare_suspend()
Date: Tue, 17 Oct 2023 14:37:43 -0500
Message-ID: <20231017193743.35821-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dff81bc-d1af-4219-8a90-08dbcf488f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VU8JCCH4jatl/Y2cGb9jPx/YvAlGdCJLWJN+EOr1JqV32UuXLH7tYyhL1eREZ1OCj5cNu9iPHM8M3qhTNh8yYO4AmC2+y291vcoUqTAQOcdbzVG9ynN8ZcLf94M0W59eYYFAinOxIXq4yC1jK5T5N+OnpMWWTjmIG+X/8RRaFMhUMJtiOPasCuyfL20a3LnK3MlqO6bZFhw/WdiSrtsQzE1uTxEf4mGQLXnf3yLodTEfPq3doWDjK8ngZFk0nvnZ2/hw8ZBxwrQTntZ6o8B4iK5fes8lWX0DtXtN+mdl9lDmZMHSVoC3xNCE3GoIiuq+d628Dqa3TI9ZbbtdQY4/i+40pOsILjS5K/x6VHPVgj6v4ihdBRWS2lQNIJGN5fJxDxF+pKWSLAT8TFeUpO2/3JpkRvJfpE7vsug5De5hAAxwkIVED9G/J/8Kg1uJgg1vE8a2d5uPAcOcrUjYBav50RM4BI4lmz22Y9cCyBCC/nYEKzRfbr1Am7yVpXwAeXQrJOy44Hpi7wpt/Py5uwij/GCMm+mr4gmpI8uNZsfbrVkokvzASClgKLz1089NlX9VDRDAoKOdlDN4KjnGb0efdejJtz+8JlmLkMza00wq4fezrrQiDcDcX40VsX03orQH6n5kVzLnjArYFLLzN0ZPLflLPfh9QOMPpxBAyYUXcxKaWbDEXLXFJAdaenE0d8AViNXfSjKkzRJ6/9+vO4b7V7zBrtiNJZgmiznbvIbrbXQNUShfRfs+0VE/hpFivvCIWAPQxIJRpO1UrkbdZ8M54A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(47076005)(36860700001)(7696005)(478600001)(83380400001)(26005)(16526019)(40460700003)(426003)(336012)(40480700001)(2616005)(6666004)(966005)(86362001)(2906002)(6916009)(5660300002)(41300700001)(36756003)(8936002)(316002)(70586007)(8676002)(70206006)(44832011)(54906003)(356005)(81166007)(82740400003)(4326008)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:37:55.2521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dff81bc-d1af-4219-8a90-08dbcf488f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

prepare_suspend() is intended to be used for any IP blocks
that must allocate memory during the suspend sequence.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20231017143555.6a6450fc@canb.auug.org.au/
Fixes: cb11ca3233aa ("drm/amd: Add concept of running prepare_suspend() sequence for IP blocks")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 98e60bc868dd..579977f6ad52 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -271,6 +271,8 @@ enum amd_dpm_forced_level;
  * @hw_init: sets up the hw state
  * @hw_fini: tears down the hw state
  * @late_fini: final cleanup
+ * @prepare_suspend: handle IP specific changes to prepare for suspend
+ *                   (such as allocating any required memory)
  * @suspend: handles IP specific hw/sw changes for suspend
  * @resume: handles IP specific hw/sw changes for resume
  * @is_idle: returns current IP block idle status
-- 
2.34.1

