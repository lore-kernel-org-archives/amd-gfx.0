Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B8DEE57DF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 19:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD6F10E06F;
	Mon, 11 Sep 2023 19:00:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DEA910E06F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 19:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpeWn5UZrFVsRe7vfcksf1//Z4ltkAF9bHghimwJhqPj4ERbmmkRS2Zm8s5K7QQ6B8d59jCo+0o5oKlVSHIuGtwaRuyzYfvM2OYB4aJSmrojCA7qsAIW2ctvxQVLSeUapBTGMbB9vCRYNWBJA39zhqk6w6dDJggr+1GpK0VQd8ua2Brw1Wsx/UoMtyt17IEw5cgq2y4s7dFWPPLH3kQt1mnQam4s4wUwKXRu8TVnSdbijDhgVmk6Jh+UMLYE1spdxeaVs9T2MpXDmIwsxNd7LVX+SroCnpfTbdDYphTFHZTuoCuXz5A5ricN9RFfzWpuFIUAxFEtIuKHCKE6alJBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jsic+/UZKLGg1k69tWZeyWdhlVeTE7ZxK8/vvx7YKc=;
 b=RrjVD9uzihEqCawmhu2QhooQfJFQoyof2BoH/Cs6B0Ihw0Tv9O2nd3pama5IecqEGTf+wxWHv/uOgAotO4AfzupG66J+RqpQlQJscG8LixoAOqeGu+KT1ejBGLSrYFlodEHfIhhemX55ef5uP4JUrLTTrHEf5mutsMtfts4LQUUct3fMoOR3Q9TC3O1E9PA+etUun7rkuO35AzIEXohAXc9yDSzs9/dvHSS3GjPyOE7siuQFlpPWy9kvWQbxXCxj/yFFLHPeoG6claF0LLBx9c+5RKsenRhS7Y8Zzz4PlRsJ8GJbH56GW375xslUohAcfb7zP+sYjtUZ9qbAn0SR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jsic+/UZKLGg1k69tWZeyWdhlVeTE7ZxK8/vvx7YKc=;
 b=ZLG0lwO+qNKJbXzgV/id+YFFOB27xlxUx2uktRyZJpxUEzKASH6y/9DmN/IAsfkcaSTwI5da/rFAxgR5Alw1B0u6d2isX8px3xVgeXMIQ5Bv18du3Yrp9KxRoCb18FebBJ8NeoWGL4KCX4l7smE53Xj8aYFbQzXqQmnRiAAjXgc=
Received: from SJ2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:a03:505::18)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 19:00:40 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::94) by SJ2PR07CA0006.outlook.office365.com
 (2603:10b6:a03:505::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 19:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 19:00:38 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 11 Sep 2023 14:00:37 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Insert missing TLB flush on GFX10 and later
Date: Mon, 11 Sep 2023 15:00:23 -0400
Message-ID: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|IA1PR12MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: b919f84f-ff3c-42fd-a0fd-08dbb2f9638e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgPp3Z8Oldj6SELpzxSEt1fqaWGXqcKfuEpNC83zGlcbFUuJtm4tAqcV3zjyIxxhuYTijjmndQskkABw4rmnMPNQ8xwX4o2p4/+ZgzTGhN/Nw4kYNjeUiFJhK7KtrhVQ4goOaQ3BYmFiMf9R2IQhIf7mwZZNqEWFrj+IJXV27HxybvclmOJ+njJSAMjpc1ChCm9s38d0Z0OeEWjzbgUuJKeryy+1zAk+btkfVXoMiK6UElm8rDQj4cBQTDwe7BoxVG3IN5D7Ydd8TFZ7JWyJzY4LNKtctRFjaFDtBhYAQ2F3pG4c0NHxE+VaSuRg/1RQTP3EOxv1FcqoeXm9FTFDsGfPpJV95uNryCJpFCodN2cAxgNynPsgSx1S4LCovnFzVi+/g+FLGsyC5qeyI+K+tewVokJBp2Idk+CZsK4TLkRFrDv9g4PgH1hWus0CD5wUki8O1Y70Os/BAnTowhscKnefMHFkd8JtJAm79hHKG1oj9zp2CW1vbjmx323FOaKo45IVOrQcxKJU1nA5rZx9wLT/9bzIvEMb1DHHyS4om6LecfwlgoRinarpcS9X6b/WBLVpwmhsgOaDF8kB7p0A8yQt+QU/4Caw3+4yq92ZqMzIfuNF3JEH2+mwWzoGZOeXNtklXbC9L9JfdaIk693p6WUPAd7boLTL5ZbVpe+jQoVEwVfavIeWKNwBzoGlTBdF9nyXgj4GhnyY+ENGfcGx2UYBNQ37eCKH52aq0QyNEF1teL4YwRimHHcCrLS94M5SwTxETfeLmLrqLOaaEEg+jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(7696005)(478600001)(356005)(6666004)(81166007)(2616005)(41300700001)(6916009)(8676002)(5660300002)(70586007)(4326008)(8936002)(316002)(47076005)(36860700001)(70206006)(426003)(336012)(26005)(16526019)(83380400001)(1076003)(82740400003)(86362001)(2906002)(4744005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 19:00:38.8387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b919f84f-ff3c-42fd-a0fd-08dbb2f9638e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Heavy-weight TLB flush is required after unmap on all GPUs for
correctness and security.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b315311dfe2a..b9950074aee0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1466,8 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
-	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
 	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
 	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
-- 
2.34.1

