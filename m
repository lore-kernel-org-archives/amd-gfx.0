Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74A9C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 16:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB08810EB26;
	Thu, 29 Sep 2022 16:51:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5418F10EB37
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 16:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUgaQT72dFWV5A+96WhwWr02ewy32qnx2e3ggVx2LsZ4MUc0YnKlclkLQ17Zhkv3GI2V/ED8rw98Ch+0Nc8T8+zMkd2aWPJRpqA2a7xflJyS9Ijs7wkUOWepPLNeNRPdy/QDqhmHkyPYz5XMdUy+MAdEVunPm7jVwXgFiVU9omTTWkPeUKUrwRLnfsH8wB72HS2uVMojNYeeO8h0h8ZoDU05wLd+lNkEFtF6Gr05o3jEqYY51nro/OzhTWdFApu+HqrNHcEht6GWpBnlv4a4yRqTfiFkgZcXoSlNPWvD/T1B5WYiOzVxLY4FP8BUInd66apctkEAEAslk2jI+/O+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow5CuJxlF+z5DvMvg1Ao6N114/V6NtwpsR/izZCy3II=;
 b=QrmDCthTUR0hMYMiDYM1xkyUwuJ0SyWLOdbdB3cvfI1EOfuQMrnvIdScV5R2OkqitWgf9QMpCOw+b+dofMNq0e4t2PyEbI5ruy4vdkA7sYpU6lyiM/AewYphjuxo4QkvtqmxyWMMvj/fplEixGHz8gWPTqPcIHlYfg69lQ9GIwmhLfyNRImk0l82kb/L9DajIqyNU+Fj/XVuGGqSRQolYqnfo58agOxr6psBFTlMjtCSbpEHL91cXCOIunQlMfxmm4II0wk3GCNi5J8Par814PeuqGwDFMVa/F+ibQL341KPKSRFKt8olwpR+2miP7FKkVJ83QF3zMJbRgP2oq64Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow5CuJxlF+z5DvMvg1Ao6N114/V6NtwpsR/izZCy3II=;
 b=QqzueQH4Q23PpQU4z8jIicoBCKVADuwmXXPZl2QsZT37VKRdbdFkm9iMU0iQhXw4eHSyfq+znEGTKSIJdrLEaqYy+RGUh/BwAC+lfB+325vzxNVSox67aJTi8mgoCUKevwpqTuMMY1UW3FtM1zEZimyWZOTIB76B114eWXBeNDM=
Received: from DM6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:5:174::17)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 16:51:01 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::52) by DM6PR21CA0007.outlook.office365.com
 (2603:10b6:5:174::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.1 via Frontend
 Transport; Thu, 29 Sep 2022 16:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 16:51:01 +0000
Received: from sonny-TP67XE.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 11:51:00 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Enable VCN DPG for GC11_0_1
Date: Thu, 29 Sep 2022 12:50:22 -0400
Message-ID: <20220929165023.103134-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e62fa2a-0634-4090-5c10-08daa23aca50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XvKbScXrvq/2eaXypwmJsZjzHGkYPxW+X4EidQkYGVSekl7+esYIkyWBl/T6eA/qRJLoGm8xj7G1Lli32e2DGIqoMHuzVHDKrC9AT3yC229e/s79qMjedUTP2AHxG+y4mS2as5XIhhAwNweQC5XuMTh77Bpk4A+6GSYIL6L+e2pI97Aipu8FnPLM8SnVw3Ik07g0Ce+HqZJCsQ2kvwwdT2Iej0dlj9IBDN0sIxvuF5ApcANvkSJLYXqa1pd8rsYd4ooV91kuMZgOgxD6XZ7J+YySpmIAlNbwk9DpYtCz1G16hWadBO/9iZd5+CrBB08KUEoI4Ol2chP9TqCdzv6RLpEUGEZ0zu7d1x5gg53vJ40XUlZJgsfnrpYRiU1i9zVE7eY08sKWCyAqU1MSZulsCD/vAA1OSiB1M+K+YS9M5dXX2QN/4fhRXXmqL66cfzA8oICVnuTi0fmY7TsJ8OjRoTWgWXzB2nbGADq15PX1BP+dipA+7iD6IMN1MZIfnHibglIm0SjdoCmeXOSf/11Gc5MDRz/nsqGoPp8S/NC1WK7Xqp9EgEczSB2km+xiDJImfKKFbqeNbgc7GrfaG2+BtYRfENqP1MJ1A1TH14G6rNo00RFj/Ia0lBlZ53/WbEeQjqB1PCwonJ4U4wVwMEEhlPh8XRHiGq4l8xavDVWKHzJGR4YgrOy0MB8B63/i6vyVy5pFj2GpKeH1mQB1xu3cKqPoT5ZfUHY90GYfo7bCtLqBZEV4m/pcY44sWYwPW6bjjujycl22Db20sX76emXG2kcWqObBk/WCL3qAaeCe+C9bfqjDmgLLn928t0YvGEM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(6666004)(81166007)(7696005)(478600001)(36756003)(82740400003)(316002)(2906002)(8676002)(4326008)(40460700003)(70586007)(356005)(70206006)(86362001)(82310400005)(44832011)(40480700001)(4744005)(41300700001)(6916009)(8936002)(5660300002)(16526019)(2616005)(1076003)(186003)(426003)(47076005)(336012)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 16:51:01.1319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e62fa2a-0634-4090-5c10-08daa23aca50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable VCN DPG on GC11_0_1

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 5f0d6983714a..16b757664a35 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -629,6 +629,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_GFX_PG |
+			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
-- 
2.36.1

