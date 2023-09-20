Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0325C04AA9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 16:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5552C10E518;
	Wed, 20 Sep 2023 16:08:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE6B10E4CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 16:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrFAu80fOgbnxIvZ6r/9PzFyoTVuBss9MCUXboHNVDd6aDNNHsPZtNzP75Sjx48ZpEgz/NW5ItOZw6FFnynjOP46JTBr3BQZVkwrHfAVaYcu6VLGoKFU01FJSrYQvb/UGCwYLePhiy9ccj7Si3YuKpAm1U8ga4DEsL9KrSGomevUxwFNO7DXEf4d1gd1Cflrtv1ukZ/I1SG4jPnuhwExUmoLwYLo6wOvi4gVjlWvpRL2HBEdo4biuIeObBER79s1VRdSnb7CUNuTigussHfEX8WiPWVsFOqSmQHRxPmUeaWQk4u00JW1uGJkBzHG4ZlCcwklinEthbp41ctz9tjm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6ovUn3vc4XOFyuM6Zj2FXCklJBb+XVvSU2oVo5wVGQ=;
 b=jQn/73YL4hHZGjTq8zFL3LJIVNkhnkZgcsKiK5jeITMSoZoKFsrGa76JGRfQ2WRX43ck782xHrCpbvdexZEG7f5EnNTqI8rErP7I6SDXY6+3cm51Pd44VcFfWswssxZOOuTrBJTcaA4LvsLXiMaL7riM+DZ918hQRkoqzpvwlj8541bzdmTj9xQWJoe1M+00elvHZYAJFWjn5bs3cJL0uIgD84so4SHTDM28/iSH+52uooASy+H3aGm04yUmdCblWTEbQz42YfqzKKgUcbFHPZ/JhXOfBuQaJBIlKJMhZk2n4GmbFAEUOir3YzOjVNU3w2fiaHJO3wor+KzTL0OnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6ovUn3vc4XOFyuM6Zj2FXCklJBb+XVvSU2oVo5wVGQ=;
 b=uGB7nlzXlU0M9hC4ylsSxG1qgMM3OJPt9OotUgbCOQUbSfDohHTvBY0JOAv8gnrULdzZC63vWyIoeZS9KguGlau93pnn/QsEM60syAyTpeC74bqPvfcyLXXjYWn02RsKv4ukYZWF8TJ8XU2BG28tOysX+ZduZcGFGU4qwn4F9rk=
Received: from DS7PR03CA0106.namprd03.prod.outlook.com (2603:10b6:5:3b7::21)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 16:08:31 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::f9) by DS7PR03CA0106.outlook.office365.com
 (2603:10b6:5:3b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 16:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 16:08:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 11:08:29 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 20 Sep 2023 11:08:24 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: fix some race conditions in vram buffer
 alloc/free of svm code
Date: Wed, 20 Sep 2023 11:09:32 -0500
Message-ID: <20230920160932.12067-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7daa2a-970e-4527-6b50-08dbb9f3d50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXRKtJk1d4WMZ24n7NIX0PsBPMxNsjITfW8nq+6k12OAKweHxbtwioKT5Cl6lfjFkpu52IGXq/8eyMcwMS989xm3HcMOi+3IxqpUJJbV0xjAURU4gfTjCnw5Gj9Z1DfpYyHwD/XWGfmVkM/+ogCQQ+DROSCI7lNodcSGXjK7HPUEzNICoJ8L6LM2pDYfB78ELEQc2O60JnKqZGvJu8EPnsSzpl92uByNr1C3IY6/T4TVaQzDdZ82xYbT7ZHQ/zoeopnCiq5qWLCrVOrPmIHfCjVD/XP5uSt0Ds4tVSUoHwcFHlcaLoCrH+NE4ePk3mZxfuGGf67P09lHksa6h6lFbm1PJFnXW7pdn1du+iBwKMXCjY61K5oJOqiDKXg/ffL/9Q1GYqThRxVHkUsW6urmLwoWeQUA1sP0YKNTwQyg1D/FSlQ9atRkpB6KgYDi8jTYwJWEh3PAzQIwYtAtPCaPK2yxL8DPbzWY2yHVrmKz4RYESHayxS0zl0uleXO8h6tKFVsSem44/gpEzb2UtUdbuxiVWg1U/faVCwCKRNeK/HVH7vPAnkAGEoJ+IeK+kFtzBmEGs/wyvYVbdQeAY8K7VuoEePlB7aomiDCD0Ww6XVcooXQ0TZxBw9EuWuxg42793Klf5VwewP9psMgQm0tGB58cpk7yo31qSD8G99AYe0jLMG+TTYycKS49WrOCI3VJ5nw43rzhYMQTuD/GhIZ9vcY9MbHqb3GSkEtgnQctPMvpWE5fQQp5zP5m76NrCQD/RTtPBOTW+jPd1h4QMTboDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(4326008)(5660300002)(8676002)(8936002)(41300700001)(54906003)(6666004)(70206006)(6916009)(478600001)(70586007)(316002)(2906002)(26005)(426003)(1076003)(83380400001)(2616005)(336012)(47076005)(36860700001)(36756003)(40480700001)(81166007)(82740400003)(356005)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 16:08:30.4540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7daa2a-970e-4527-6b50-08dbb9f3d50a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
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
Cc: "Xiaogang . Chen" <Xiaogang.Chen@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

This patch fixes:
1: ref number of prange's svm_bo got decreased by an async call from hmm. When
wait svm_bo of prange got released we shoul also wait prang->svm_bo become NULL,
otherwise prange->svm_bo may be set to null after allocate new vram buffer.

2: During waiting svm_bo of prange got released in a while loop should reschedule
current task to give other tasks oppotunity to run, specially the the workque
task that handles svm_bo ref release, otherwise we may enter to softlock.

Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bed0f8bf83c7..164cd77af62d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -502,11 +502,11 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 
 	/* We need a new svm_bo. Spin-loop to wait for concurrent
 	 * svm_range_bo_release to finish removing this range from
-	 * its range list. After this, it is safe to reuse the
-	 * svm_bo pointer and svm_bo_list head.
+	 * its range list and set prange->svm_bo to null. After this,
+	 * it is safe to reuse the svm_bo pointer and svm_bo_list head.
 	 */
-	while (!list_empty_careful(&prange->svm_bo_list))
-		;
+	while (!list_empty_careful(&prange->svm_bo_list) || prange->svm_bo)
+		cond_resched();
 
 	return false;
 }
-- 
2.25.1

