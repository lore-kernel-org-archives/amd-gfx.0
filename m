Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0FCC433ED
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E94610CB
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E94610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC616E885;
	Sat,  8 May 2021 11:52:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4A36E883
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn/zIxBpRY3Dz1uctGplfcK9smv2Tc4C+uaE0WOcUZwvp2s0ZPeOEd1bncCt/pGyY4aRr8PsDZ1p3Kfu8Z3VAxUe4gFbt68r8HFKEVkAaL3l2auQvph+DisJZpCtn8TP6J1rbCH98msxi3nLpyt2jOmfuMVbufpiCg57e+c6Z3QaHwPe8B2f9JWeNRJ7bYaCQe2crppUyRXfDg96FtE9w+f1jMXTaQRUVocomC2xkRFydaqgzaXWmEY1JQnzVKoWiSdQQoqFoxuG/2l0+0K+LQOZhBHxjyQjuM+xGPaDcXt++y4KmxZqWhxIR99FsnnX00dIu/DprUkbvOEV+LxNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpptAnVKiSXOJUq+hCCqxP6vAG1zDxOuUfbfJIpBgxU=;
 b=ifl787kH0+KinywScggGjlvquUB6VNlv66gJp6s3NZWcASQkpSGACmZHTlkvvdjFL4abQlMzXh9cpBDfMfuot0OxlxeUCJxOeoIw510f142CmQHXDBb/JKIRNSsB1ysz3/LkH8YXFHN3w/Vkc1+5tYVmN8UUm69LgERNX/c2RwVLji7tEmd9QJ9mDIHaUCWmRiDwsxOxozlkNeQSWnOdCJUdkT8UWW89pTfGMlUnkabTWNzclriIm10T4tFNiwN9laDwDyjbqYtsQFJP5/4T8pj/dEysDbnsUYt3UBVlgRvl4utFyzSGzcloorDAViJHLBjLbU3UKVcxKh9h0JiKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpptAnVKiSXOJUq+hCCqxP6vAG1zDxOuUfbfJIpBgxU=;
 b=KpTdYoDJJqNErEHyRgRHXcVNQ3Y1SvVyhjuYrLH0VGKhpxj+nDia/lqH7urxVT/tK4lYKF8SjIdf0dN96hZliyNLmgDcft/Er2YFjDDE5lmQqEPmdBIDdL7tRXZVi4HAz4aeGVpOATz99sY6Zj6kWbaaILsR5H30cHtcrWFj8aU=
Received: from BN7PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:20::42)
 by DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.27; Sat, 8 May 2021 11:52:04 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::1b) by BN7PR02CA0029.outlook.office365.com
 (2603:10b6:408:20::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 11:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:52:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:52:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:52:04 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:52:03 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 10/13] drm/amdgpu: Skip the program of MMMC_VM_AGP_* in
 SRIOV
Date: Sat, 8 May 2021 19:51:42 +0800
Message-ID: <20210508115145.758-10-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508115145.758-1-PengJu.Zhou@amd.com>
References: <20210508115145.758-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a20dc1f3-dcee-468f-f35f-08d91217b324
X-MS-TrafficTypeDiagnostic: DM5PR12MB1596:
X-Microsoft-Antispam-PRVS: <DM5PR12MB159660D9BB01A3F55A03E71DF8569@DM5PR12MB1596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRtCnUkoysoz0OnAPjBK1NuZmJVLtbtPA3UDdzrHS0/4p4h8bW3UxcIvrrdJoKUDVufS2fouy/sv/sLsH7zApVgb6kRcywvxnUg24mzfKH7I4zh65cRwY+FDcxpgDeO6UH8unpBUF30DqtFYWfFQvc1dS9lIgAOyn6EzjuAYB84xugC/S3A+7CGGoxIHl5Oi4K4Sbaa4luhV6qtP/PPHoztmC0bbKmDfCx8bachS40Zp9GQT/ArA2LahShz21XYot66wANDSu+UVnosmfqCMDL7bhCpPB20bxHixb0TR/Z9lUrhZZLZnfwV/PqUgNhWKmREpackhjLJJGDCB85LLSPvB2qEHeYZ6MO5Re5etuImgpUyZ3U+08vIY07U0cLp8Axgr7e3HbMcR1AmUESKg9nUZG63IizF19FHx3+wVMI1PqNFZ8wiPovL/TL6MBwQEacFyYb71FC3e2HPainf5mtKpfYyGkOrmEKUJWwHXSK8YuE2N7EcGy56xt7o9OeOT+sUCYp15W01kWL5P7c/u6manoRXSKLZZu5waDJvRxUsGSrctxWYIHZFx6TZOPBecZRtnKxXeEzQBBh4t144eva0AqPcpokp4/JSqtpaUH6yWAswS6m7JAvNTarEmwtm1Vd1Awop5reSBtvEy2Xsrtu/kYuk6qVyeFhoDXIE6lenZ1w1y/jCZMwORZt0FJ5fn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(36840700001)(46966006)(2906002)(26005)(7696005)(6666004)(6916009)(47076005)(8936002)(82740400003)(186003)(8676002)(316002)(5660300002)(36756003)(356005)(86362001)(81166007)(2616005)(336012)(1076003)(70586007)(70206006)(478600001)(426003)(4326008)(36860700001)(82310400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:52:04.8277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20dc1f3-dcee-468f-f35f-08d91217b324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KMD should not program these registers, the value were
defined in the host, so skip them in the SRIOV environment.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index e24225b3d42a..422d106a650b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -197,12 +197,12 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
 	if (!amdgpu_sriov_vf(adev)) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
