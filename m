Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72E1C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Nov 2021 00:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F157C6E923;
	Sat, 27 Nov 2021 00:58:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F1E6E909
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Nov 2021 00:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/ZqnVRTrnH6W9lThNN3X9heyfkda81e4DOAsvrxaPnZ/fSEB4a+snSSa/yOnMsHHnJeRdqkpDlZAzaREr4i9fAAwru83vdtGoK0WElTB/KZLe8ZSTT2beFZLSoJCHasduD7TAPjsKVrE1M5Cdg3vcGc1ObTDq4ow5BTVKaXzMA4EcMjeP+WzweBfvwUXkmsXRtCrUYEutK3iVcsyw1aL4M+h5bp4AwjR5XUfF5jgumMFwDL8MMl5gby2OlPM+JNzw5EyyQC5UHO+lSPSRvzQiHC/yOnLvCtIHtITdAKYxOs5y1ExFCn93/TMm+aVGY+l4YtGB1yPOTuEAdo3lZO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq19wV5PNE8dli5HX7e6+vFBAw4cZ/H7fB+yzt+6HZ0=;
 b=JmvFxzuIdtR13NGYvUCF/3ltbfn++kk23N5jeiDQ5UOAvWiJW+Q1pu3PFkhcxjXhzjktXXydumYug4zy8kK8iXEqAfZG+Mo3mIF0Gs2c2w8H9fDdympLBQVvr7MuVFkiIs42ZEd4SsFsZByMsg3CCnffmX0+tUy7eDYAUbt85K/Bv4WGBqWGVVEZcmHCLwryYowcOvRTsVqF/JLZxEt+/KMJikMqdkvJ8kWhafvNgqaCVitfhEiZtP+w3Hxt+JAT1DciRwexUp0+678qpq8cRMDnLALQnGkXpwHMnps+GIqmKzWhJfi1nty5yO/yR4vtSxxlHDR/ksP+vi2pKBtaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq19wV5PNE8dli5HX7e6+vFBAw4cZ/H7fB+yzt+6HZ0=;
 b=oCJVcepbEMlykLJgl5+YZImLmBMnBpWu9lQljo13qKSnXTw4h/X6+P2NBwixxXDccpaVCcsbkT8a8q8MiLkECDhylUNDvp0pVRRG8ahn46wfPKbV4Yv7GmM7OHDllD47bCisFMqlkdbLLXtPSN7tp53RkdwPB+6qnGUqdfdHEu4=
Received: from DM5PR13CA0019.namprd13.prod.outlook.com (2603:10b6:3:23::29) by
 DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Sat, 27 Nov 2021 00:58:13 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::c) by DM5PR13CA0019.outlook.office365.com
 (2603:10b6:3:23::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.6 via Frontend
 Transport; Sat, 27 Nov 2021 00:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Sat, 27 Nov 2021 00:58:12 +0000
Received: from ubuntu2004-NV21-clean.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 26 Nov 2021 18:58:11 -0600
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: use advanced TDR mode by default
Date: Sat, 27 Nov 2021 08:57:56 +0800
Message-ID: <20211127005756.41687-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a38259d-27d6-427b-ea6a-08d9b140fcd7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5038:
X-Microsoft-Antispam-PRVS: <DM4PR12MB503879DC4E833DE4A0FF2BF6F4649@DM4PR12MB5038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJ31hxxzA0Sv5hCEk8KQdjjLSMZ8BHxt4v5FsZ7ofh81sGJgPY/v3moGWxcc/fvuuju1m+Bt6CQk7YexJHG+fjx78XSGPuhIaPvO+cqkgvdH/fr02OClJcVj1kBTzE2aoDWAkx/CZy0/HaSyFOI7gE4flTifkf3mRXuo/EEnjMCOTgvKctY6h6/l6SA60olyjHMGbyJ4rcBy7uOa5N1BfzUTWYwtgNie0jy6YhiNLQZxUH5ESkD9SZCV5NuJI3IlTky2ms0vYtexvpzHqKpfJFEviZm0Ma5odQZ9+qvgLW5cr0cusJXk4bOeWQTqpgg7jtU6J/bEKxb1LSF8Xp1fn9b4iFa8SGXVhxCafKqcUl49Y1m4BXOsuQbNPV3pmKalHttuDFiEm2Cvq//nFTwW/8xg+oV74+/7mkG8Ru5ALz3wL9s2kYJun+lKQEDRnkH0ocMQhABphSNhe2u9Lau34IQa3WoBdUUp7DJLZVMpzl6yJ00CSCyHG/w3yCLcu9+o0MBu+WVNR5g/dqWAPUhWBTxJLgn3B2niO/0lphswLqa9ooMhiHREbVvTxwhOolnhJWWHDO60IihgV1jqIJCo5i6olbzB+uQ32KffU4umBOuM6AZZXxicHYyHJjvvIDZ/ITeUDwTuknuka/bi4MQX44GWrCIuhqQzIdhbqqnGjtAbzbEi9jK3mz8K6E11r8/xwHG5QxMbhF3FXeaHxJGKwBKKPpV+YCU+B0gV3C+FLhE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(1076003)(508600001)(16526019)(4326008)(6916009)(47076005)(8676002)(81166007)(83380400001)(70206006)(316002)(36756003)(26005)(2616005)(186003)(5660300002)(7696005)(86362001)(356005)(336012)(36860700001)(8936002)(70586007)(6666004)(2906002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2021 00:58:12.6598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a38259d-27d6-427b-ea6a-08d9b140fcd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
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
Cc: Bokun Zhang <bokun.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bokun Zhang <bokun.zhang@amd.com>

In the patch about advanced TDR mode, we force to always set
amdgpu_gpu_recovery=2 under SRIOV. This is not ideal, since we
may want to revert back to use the legacy TDR routine.

Therefore, we only set amdgpu_gpu_recovery=2 when it is
configured as AUTO, which is the default value (gpu_recovery=-1)

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
Change-Id: Ifae78854b53f124d2ea53f401919ab5e403ef822
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 93af2cd2a065..62ec484a35aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -64,8 +64,8 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 	adev->cg_flags = 0;
 	adev->pg_flags = 0;
 
-	/*use advance recovery mode for SRIOV*/
-	if (amdgpu_gpu_recovery)
+	/* use advance recovery mode for SRIOV by default */
+	if (amdgpu_gpu_recovery == -1)
 		amdgpu_gpu_recovery = 2;
 }
 
-- 
2.25.1

