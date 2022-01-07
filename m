Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1684C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 12:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1419910F3F8;
	Fri,  7 Jan 2022 12:07:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C3010F20C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 12:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO0mba0VCucTWd/szLnPObxs9+amOK0FNXUJtsafGNBS5wSy3H2xUxaHhxODlkw5EEpOfyDKUq4N1XT2qIiWb7leGgnCGrp9ULagvcvLgidNe4v3QnTloPnqW1Issmp6R3HUXQOIl6E+PoFTUHnD+cu5EGSFQy6DmmUw9ob4Y47FW5eJUeAUN8AZdeiwiT8J9jcuZ5lFDc10SubP6oS00pBt/fsAkMmd5W1pqfiIFWyHw2Odj4PE93Yl+qKnZhNJevBHNJr138f09Rxs0LcjXHGaZ94UVc9Co7ZUKQdrIWtQtffsjmvtFaFVSxKuZb+WaIJF5/mAPy1NCM8Fjrn03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM3EzDAfjJwuyip3mK1t987n/lGPsc0dYU6/QhRNqlE=;
 b=bQZ8dhC/d2oPtD5N27Kr6X9ndQhimeSFe+kmsAXTmOCgFwc/MC5x9izv7/zh75EaCMsIgR1gaPULHyaZ3GITkgJD16YrKrBRwTOu30Lj4yIR/0yORxvTyyHyp08kZe/Y6LROnc9kOjab+6ixLuDyr/QpKoQesz157mlfXCe2EEYprTYl3/tfXgHEhdCO2uiYqzLqypXwCMM0CtK07tM/OOea03zsMAsMtnG70svhRrnXf7/S6QSrvv7vqkVAWZV03QYprdZ84Q1AnvoX3Yqwo9qzWDub1EmSHDfX0mwcYH5uVaSFwgEqKCW75nFsigAJ5PPTn9GmvYZ0xHF+mj9ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM3EzDAfjJwuyip3mK1t987n/lGPsc0dYU6/QhRNqlE=;
 b=QaoPbTKCQeWbSDMp3haOGmr2T1i0HIKNFltcSjhw8XazY4Mge4/HNEvoKfsULFNYr0gyIuVZ3tPh+OYvOWVy0ZfCXtRvPQ/n3GtvWioLuEd/vJG2a1ER/EmYHAvEUAqAl+Xd1TVlJ9W3UKdGRpGdLujZTrDAw/bVAJuXbMORBRw=
Received: from DM6PR07CA0078.namprd07.prod.outlook.com (2603:10b6:5:337::11)
 by DM5PR1201MB2521.namprd12.prod.outlook.com (2603:10b6:3:ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 7 Jan
 2022 12:07:49 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::f) by DM6PR07CA0078.outlook.office365.com
 (2603:10b6:5:337::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Fri, 7 Jan 2022 12:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 12:07:48 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 06:07:47 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add pcie indirect support to
 amdgpu_mm_wreg_mmio_rlc()
Date: Fri, 7 Jan 2022 07:07:40 -0500
Message-ID: <20220107120740.1041489-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a194d69a-2dc1-4658-4f72-08d9d1d652ad
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2521:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2521067CC5264528F4B9F126F74D9@DM5PR1201MB2521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Wbpdm9BkJH7WrlrNsKASjXosyZG9yokrN6nQGt4Az2rrZ1IUnBURY0YhqgSNMHrfSH96Yjn4ef0Ju95yluO+tY19ZuiYgvqjPQWxfxzwChB8synY83UXHC9KfxqAkySh+lxVsAhyDwNEkrRwIYe34Hx4qlUZrYKT4IAsQ5KRODMxh/3E3/JH8AFC/rmZMalXc/Mo+/R42bGOzWFb/+YcTyoGFHBW3140l142bApkFLoQOCq5Wgtw0Yd21JlY5HUXXL29aQWAPEUgRcGmk36RpGaShq0TNAwBtUScffS/j+eUwXX0ssYwR05LVVl0GJRXcAUc/XQjCT7nKDbNwszY0QrisHdJKBZ8en6A9kOR1QES1k+mfMOSqbm5t3pi+w1uXKp/SxUNDVau+cIuce71NLEkBlAjnnBVUZj5eTdjj26G/tqvCxl/AYp4TDlgP1BiJfvngPmkSH7L173PTuHQUKbNK760bBqy9hdIGDkSSeb6hBTpU9SRQOPj97HLx7x9PUPUMGUm3RFUdq+IZJxI11jb1fOa5AIwxTI2rCaipcKJQ5tULhsZmkVSsDlVC5dF8QRj+Gn9gBIga93BHzwSEoEPj7DBg5a907VmP3hYokJeMuLXTnwFwb12oUIFpp+20kd9losFPMEBiOtXMkUIbsJfCFMdgQmlILfkYAK36/CnJGbn1yh4pS5y7a95NDBeILMuVFjy9DTFlRx4KEZv5Wv5jIEjk714RnwRENYwfQQZ7GXDTTZB4OSsAfq2KeAp6ruFlHWlsrmL/EG805J3oEqIjelpzHo9akZLtswCfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(83380400001)(86362001)(81166007)(2616005)(2906002)(336012)(356005)(426003)(316002)(6916009)(47076005)(4326008)(8936002)(8676002)(36860700001)(6666004)(1076003)(70206006)(508600001)(70586007)(36756003)(186003)(16526019)(40460700001)(5660300002)(82310400004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 12:07:48.8994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a194d69a-2dc1-4658-4f72-08d9d1d652ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2521
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function amdgpu_mm_wreg_mmio_rlc() is used by debugfs to write to
MMIO registers.  It didn't support registers beyond the BAR mapped MMIO
space.  This adds pcie indirect write support.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c38e0e87090b..53a04095a6db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -552,7 +552,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_mm_wreg_mmio_rlc -  write register either with mmio or with RLC path if in range
+ * amdgpu_mm_wreg_mmio_rlc -  write register either with direct/indirect mmio or with RLC path if in range
  *
  * this function is invoked only the debugfs register access
  */
@@ -567,6 +567,8 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
 			return adev->gfx.rlc.funcs->sriov_wreg(adev, reg, v, 0, 0);
+	} else if ((reg * 4) >= adev->rmmio_size) {
+		adev->pcie_wreg(adev, reg * 4, v);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
-- 
2.32.0

