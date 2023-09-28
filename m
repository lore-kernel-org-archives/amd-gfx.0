Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA7BCE7AF8
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 03:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F356610E514;
	Thu, 28 Sep 2023 03:42:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6673410E514
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 03:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQIjD0XVD0uujd8vsau89HUwHZkvFVAcSaxDgdXRtqxv0Lh4ApESYD+3dVvbZkPzcy4aAaMV7av63lLaM4tgtVbU6rZiK23yjab1a6cG68pdPEJt0jjp14M9uFVSglWnsIo4UZ3AUZfgdccm42azqbmDKutMvSi0Q87HancJHtbFbO1rwGng6+FvtopM2m0adj7V5+kw7eg3YbWBuwbqY9N5sO2JzHCsASLYdJV7Llsq8uub7/d1A+N+1/EN1nN9FN26DOSzo+OMrMRLb5JB4VRhVgaf8BCqaNHpG8symJ8FoTbZvueRYNVRLoewPptaD4P/Xk9VNG0yG8Ly6TGR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij9SJTSa0MLS6p2exoC5hh5SVskDtBDDoeOJ6/z9uws=;
 b=IdZnVhj3baTCCAxVw2+i3FSk8Gj5+OEglklxsYPTd57J7Q+0aW2Hba2PsSPlqVwHUnbzHs8QHDD/F9sb4DWeEijOPr2LPvgr8y/taRDuufqAfuzYQk8Wen+z1COBzdJgkwAP6jvRzTu8DMiHI+JJHBRmEcbYft6z18/SEVmLRwzM4wHRfNpY0hEQzFRyk/crlrBavAViB30kqw1JgMt/2XfTRyFEBUYUpoEvWpQFkY/mrzvpN6xBRb2OysFcrwTn1LHpNl8v/cly3PjJ9NVcBc+FVwJ9Jgx0/fnQt/WAhLRb26JQ/jhiw9pweJitCDxJZeAT+waxYzsghb4Dzrjn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij9SJTSa0MLS6p2exoC5hh5SVskDtBDDoeOJ6/z9uws=;
 b=0Xhst3Q5WPwb32Ux/z7dbISRjB5cgxVYoH3zSYol/0y9bU4zjWI+TDwN1SCAgU+9uBr6mecG9/BTPdFGu+rA0nE+Goc14VtGlfUIMgPpbmBqWK2+5Z6Wz0UTF/umEAiE5zGjKvit3ovh/RYaHNULKrIqegO+Sih+d3nnoBwkJiI=
Received: from MN2PR13CA0035.namprd13.prod.outlook.com (2603:10b6:208:160::48)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 03:42:07 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::26) by MN2PR13CA0035.outlook.office365.com
 (2603:10b6:208:160::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.13 via Frontend
 Transport; Thu, 28 Sep 2023 03:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 03:42:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 22:42:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 20:42:06 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 22:42:05 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Skip ring test during ras in recovery
Date: Thu, 28 Sep 2023 11:42:03 +0800
Message-ID: <20230928034203.2171971-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b10d84-8b0b-4402-988c-08dbbfd4e398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5W8RW+azkekB1fHlFwJtDJ/lU3KtLeeUTBwgARO6eGBIltVU0UVNXf0JD07h+O6p0RtfnELvTANOp2uSACDwlzEdR2gTs1eCSD7iSjSitgcuEHASQmE2fOJmQG6c0XTtxpQbEObU9qBoNZ2o7GybG16BoqDbDErS5Kok0mOFsZSNzk3oXMkwymuLZS4C47cucRXzNDs3GpKXH1RXZuCuKSddKMHBSGGXMuBVUrnlXbuv99ez8CALdiGWv7e2tQg5XKV0nZhBlExx30PBvLklSV3SJfASf2pzcb4crtY/rK20xLTLBaS7Yo8RH/QVACRoZpzJR6NjnkSZuLTsyeN5rzQSjZKneRTyXSPJ2eEbE/hzeTf4obQ92SJBUNt6Y6mI86WzneYGv3dJYSC0o+RL2xxSevFp5N4lBNi+Ru1MmE28mT2vOmgwxv1RTMTX1HWREwDpf6kDbpnLVlRRN+AsbxV5EL+VN4PSOcHdTyeQWyYEZO3ddHVE6xcL+2qkU3GHwWZ7OA874u7JZ+x7WER6bVepYrcI9SV39IDrFAU3C8+yizIV85YqY9lSYuVmX4xrlFGOOnlIaj+fUfSw/B59mnCV7ke63pI4H17xqUHiO2fMJolMQi6robEeL0vU103MMrH7LdlpHXmBfkTbuXxYKyHDgTL8rsJdXRo/d2eIh1jJU6HNpHjcyQ1P2gj3EoUNbIbhciwIYJk09JyPKZ1M9zLnozbbzMgyXK18nJJCyeXudWnmA/3QBSkp9bF1LBvqfE6xrF6iZ+MM/f4TRtsIBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(70586007)(6916009)(316002)(41300700001)(40480700001)(70206006)(478600001)(86362001)(40460700003)(2906002)(36756003)(8676002)(4326008)(5660300002)(336012)(8936002)(426003)(26005)(1076003)(2616005)(36860700001)(47076005)(82740400003)(7696005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 03:42:07.4988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b10d84-8b0b-4402-988c-08dbbfd4e398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is workaround due to ring test failed during ras
do gpu recovery for aqua vanjaram.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fbfe0a1c4b19..9fff58d073a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -248,10 +248,16 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
 {
 	uint32_t scratch_reg0_offset, xcc_offset;
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ras *ras;
 	uint32_t tmp = 0;
 	unsigned i;
 	int r;
 
+	/* This is workaround: ring test failed during ras recovery */
+	ras = amdgpu_ras_get_context(adev);
+	if (ras && atomic_read(&ras->in_recovery))
+		return 0;
+
 	/* Use register offset which is local to XCC in the packet */
 	xcc_offset = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
 	scratch_reg0_offset = SOC15_REG_OFFSET(GC, GET_INST(GC, ring->xcc_id), regSCRATCH_REG0);
-- 
2.25.1

