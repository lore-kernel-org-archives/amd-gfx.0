Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891CBCD37A9
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 20:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B3910E66F;
	Fri, 15 Sep 2023 20:19:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA90D10E66F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 20:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwP40ZBDAUo5ZTw2I9tIDncox05sWKKqNOARWBnDZRQp7pyfwmE6wveZRQAxI3nJM9yCcX8CSpkpC8OX1NlH7N73o5rU2H/vw7Eb7umY6YE+i15Uv0bR0okPUTKjL1wbnsA68G+K6yad5XkbUB8X5P4NNi8iag8h4mEFl1VkT/Q0eoZfsxr6vQnpa2F8ZqvaOVDDwenGySs+RCAx09DCcGpCyF4+EIeZrKFPAOWdRk2aBvFyd9PdLVsTeSGL3cVImIPSULr3JosMNjQLTMXXM3B3y0A5m7epXeJ0A001llfGwnBfru3fousCZF/ITMY+9y13+Crly9UPUYGa1njyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz12/MWjcfr3XcnoqbwY+EOmZNjyakMQD3gqlWoDDVQ=;
 b=Kg8/aeIYhKXo3sxaWvnO1/eYcgA94XHqhe2QZxEzyM3IXgo2A/nG2hrPX08VtQWN0+OhOzY+IQoxnjA9LkKG2lIJM8TLDEiRTbLny07mmwZeWxp2C2DAxGM17zzkeCsBM/ihYhCmPGSB1yIFDHebicBqq8jnB7twTID9YbeWl4xRqL8Dj4RLf/gp5C0zvhqBbT4P2o0hhnAzafP8vOFxSAefomfh1JbPDm8Osylf1q8OM5rbqiMgzcJeOedd2tia+DENRRq0iuFxpFYneEeumtWcIclz1uimmIk2zqfoewfS4f1LrOYYA2WJNDu9f9HD4UeP3QtwlDVn81J4DKD48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz12/MWjcfr3XcnoqbwY+EOmZNjyakMQD3gqlWoDDVQ=;
 b=OEtKPgdvBsrHg0iaSC4Q8S9VRCSA7jYPJRNfz3hCKUPYtSaFPU+V6bdqgyNW2caz02obbP2pxowl84pBVWRlzTuZCOh/8/AUpc+QR4Kr2+bndX2G87tBg/PELqEuv/oZHMI62W783tY3RziE0r5YlLliAwBfF/A2xtgj/ba6e70=
Received: from PH7PR10CA0004.namprd10.prod.outlook.com (2603:10b6:510:23d::22)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 20:18:56 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::16) by PH7PR10CA0004.outlook.office365.com
 (2603:10b6:510:23d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 20:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 20:18:55 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 15:18:55 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Remove svm range validated_once flag
Date: Fri, 15 Sep 2023 16:18:33 -0400
Message-ID: <20230915201833.30416-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c55c352-d768-4f40-3148-08dbb628fce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yBpuBEKfG3JqHkNHSvWQj2487+EvLQEG7kYLfqW4QD4Ex/1kdvJ9gXh37EN8HhVuS5GNhdHlGPO02PnPS/UAP1gbTly0Jf2akZkrcnSEJ1BKMK9oF6shZLWMWlXdx9QgWGPQ9wYJCKAgz+3VYTfgiqEa9eIjk0bur8936JY8Oj1ZAHDBbgbXD23sElQdBHmBuNVlaq7gZf4PeVbHWnWFBhVL/I27DZUXPerRUasjK1E0uHq/U4rJ/SaImm71BQy13RR86b1iAgYw63Ro3ETjTguq1Hcvu9n1rwZd68iIRh4kczk2rOHluZcid6TEYI3uP1PWxxP007c74/9qsXcfRNnh4EergV+CTCTxuLFtZ/B3PdflGeI9PcMBTdDv2hSzrgGf3HSINb7Tj9iCTj50G+Z0Ja7I6oNbLWZIglzsC1t4/364jEr1M3qIyfR+NIQ7Yb0vOh/YorQrSvD8Ife00tNQwISuUIccIYAz+EqjvRYSeEakZEn3KiGg+khscRqv5+8y4zyZqgy+5lJFg9nZIz5e9fglv6ButXv7E1olY8o4BMmB1yOkFMH9uZ4B9Yub5jH/0FQ0VUrakuoJh9TvzXW6yKYjpdAk3LSFXu2zMbn2mxDzmSnhNpgWa0/3+eWINprthWjoKpyAUPhCXPOffMmgPnSht9x6wBQZ2NNB0vholHhCIjhLTsqA6RxA+Gnhe4bW/3NQih8aFq1TQUXEucq9wDsVsBOOPEyT9gqeR+G6Fy+Uq64WAOJ6f3VVoQvJNZpYRlsvRSM2nIPfEz+uA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(7696005)(82740400003)(356005)(36756003)(81166007)(40480700001)(86362001)(36860700001)(1076003)(2616005)(26005)(2906002)(15650500001)(336012)(426003)(83380400001)(478600001)(4326008)(5660300002)(41300700001)(47076005)(8676002)(40460700003)(8936002)(6916009)(70206006)(70586007)(316002)(54906003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 20:18:55.9930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c55c352-d768-4f40-3148-08dbb628fce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The validated_once flag is not used after the prefault was removed, The
prefault was needed to ensure validate all system memory pages at least
once before mapping or migrating the range to GPU.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 26018b1d6138..562da3c40515 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1730,9 +1730,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		addr = next;
 	}
 
-	if (addr == end)
-		prange->validated_once = true;
-
 unreserve_out:
 	svm_range_unreserve_bos(ctx);
 	if (!r)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 91715bf3233c..25f711905738 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -132,7 +132,6 @@ struct svm_range {
 	struct list_head		child_list;
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
-	bool				validated_once;
 	bool				mapped_to_gpu;
 };
 
-- 
2.35.1

