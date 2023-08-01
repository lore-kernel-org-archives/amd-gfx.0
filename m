Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA51EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 07:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B75A10E313;
	Tue,  1 Aug 2023 07:39:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1423010E313
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 07:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQap86RwRUfT3LNcJfdzDx+aBrmaFfRRoWnXBppVsEjJXd24Lfue1HsQAWW/2/Pp7dAWkMT057rPnq4ZoguL/kyEvglyDN9bpxlT0DXgwsTen5Hhyd3Ck/ETItEVo9B5st2qY4415srAUKLPRadb/NqKtgBI0GXiirRRCQMpYk4qg8ZiIW/juimTEuAsQ2lOYPn3YzEcrTt0NhMwMZxNuTGNbt7/GzxnJnNa4XgXHU/83kNAPChdwWq9tl4qlYUmP+s2Rjal6mJ+ebLcOBSVwseWyp/oI8ZOdfW5XAlOcJWjVxIBliYwHfdtuhZtqI4sKdG2MY0H6K/bcI9B+20OLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgaIzVW7y/aMkT0R0MTTlYTqMj7WcGgW31YLPIAgIVM=;
 b=e2BRMkiz7dgTxZx0igrk4ISVipTCILbhn+iNyZ7PRpfhEfVR7OUUft2cqQE28XPzRf9B1jpYtfzA0HC/5Mhqjy7+5Xj2gDbSfb54GXkaMvc1ifnt2LON4Zb8ifZmxePEQxS57ZtdDm/pepw1wjmntq5SarXI2Tc154qdw/wLYKqiMcFOlcpGVYxVJgh+OWMxKQuTe0DSo1Ovvm/E6JE4irFJYabPXu3vGIJq02fATrGVDGQtCKJv2XjUgr0PhtH2CPz1sL3EWllTvCv6BZsnSMrSolPlCwHozsbBWMEUQ7Erf8fp8FjAuS3iJcPFcoClWSMKuJag8eQQDDKtNjowLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgaIzVW7y/aMkT0R0MTTlYTqMj7WcGgW31YLPIAgIVM=;
 b=er/nCqyE2lpIRNrMbZLJztYEvVxpzmLr/q5C0S4dX9zN3gC5Dw/EQVDbw9rLJw+VSJf+zxjCYrqNDy9r41x49tNhSHSxAjTf0quChlLfBuWmykQDFEu3ssbtCB+XXtFUqUL8sNtKmVfIsfc15eKjSvERJO5pCYgVfuTtQD/mPec=
Received: from PH8PR20CA0011.namprd20.prod.outlook.com (2603:10b6:510:23c::14)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 07:39:07 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::31) by PH8PR20CA0011.outlook.office365.com
 (2603:10b6:510:23c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Tue, 1 Aug 2023 07:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 07:39:07 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 02:38:55 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add support to create large TMR BO for APU
Date: Tue, 1 Aug 2023 15:38:32 +0800
Message-ID: <20230801073832.2133509-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: a5491f8f-e9f0-4aa8-63b9-08db92626343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyKbL708i8oQiPe+rfXUYVo21CDsAsUcv65594IZr1le+Wqwd/AP9plvWhJTbPZMYUB4bq6bOy+b7bA/ln3ebGJ8zzjEJPH7m/Nirc8YyuYofeaBxqaZzNnkU67CoFjvv5/84lB5kXnYo804H7wmKV1PcN7HA5rUmZWWGadmg7LsxdLbWrka1ACmyd59CQNV59uCi6V92iHzf+/H0xh0kH39TDXPa4sbDT433t17/vHl/aTbvk2GA/PlvHYHi4h2/VovLK7MhpsRBA0BmiDcVP6w2D2OEA6gMCHVJ9fXhjQENITnOQqMG/qt8djwUGImAWkupFslpxKKFjLU2oeK4VPzU6ckx2At1Cq57iKcBm4Tir/+1FqkMPUn7j/Uisatbz0nNyHVT1b+C/7bDvP8TIGPeV9W0//JLZtr+/LZC0MFqBza9/YLlH2ediVopUfDaS0z1/uP6G6MQCBIPa1G04GL1U/YjA6/ArdmXI7xC7LV8JqHhefzQURRB1RgJQUCrXl5tpJr1lTPYTreGRKRZMXuKrHz0Mjzh8tPf3VkMloms4Sj43HciFZZacvAXfhMNW2FIs3TB9fBUY9SxSeLqkzw4x+WnHWtiiW9UdnEd28NNQ6HZAo7WOz/4aF6nziJtp5WUfBdblN3N41UdSW4Jlf8ykcbZ3n+sRM9G+1HFPGf+Xk4QBUjCbqxnu1xFzZobI0PhnOOOHzeRrlDBp0yyIAP+MBd/8XgwIJnTvaVTrKLh+slK8AnsDVpVxMtpGEH/vx1Avw69JYOnkDu2ZZnTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(36756003)(478600001)(81166007)(356005)(82740400003)(40480700001)(86362001)(40460700003)(6666004)(7696005)(2616005)(336012)(186003)(1076003)(26005)(8676002)(16526019)(8936002)(5660300002)(70586007)(4326008)(2906002)(6916009)(70206006)(41300700001)(54906003)(316002)(36860700001)(426003)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 07:39:07.2243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5491f8f-e9f0-4aa8-63b9-08db92626343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Lang
 Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TMR requires physical contiguous memory, amdgpu_bo_create_kernel()
can't satisfy large(>128MB) physical contiguous memory allocation
request with default 512MB VRAM on APU.

When requested TMR size > 128MB, use amdgpu_bo_create_kernel_at()
to create the BO at offset 32MB with a step 1MB in the VRAM range.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 38 +++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 15217e33b51d..3fadfaa63b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -783,6 +783,34 @@ static bool psp_boottime_tmr(struct psp_context *psp)
 	}
 }
 
+static int psp_create_large_tmr_bo_for_apu(struct psp_context *psp,
+					   int tmr_size,
+					   void **cpu_addr)
+{
+	struct amdgpu_vram_mgr *mgr = &psp->adev->mman.vram_mgr;
+	uint32_t rounded_size = round_up(tmr_size, 0x100000);
+	uint32_t start = 0x2000000;
+	uint32_t step = 0x100000;
+	int ret = -ENOMEM;
+
+	for (; start + rounded_size <= mgr->manager.size &&
+	     start + step <= mgr->manager.size; start += step) {
+
+		ret = amdgpu_bo_create_kernel_at(psp->adev, start, tmr_size,
+						 &psp->tmr_bo, cpu_addr);
+		if (ret == -ENOMEM)
+			continue;
+		if (ret)
+			return ret;
+
+		psp->tmr_mc_addr = amdgpu_bo_gpu_offset(psp->tmr_bo);
+
+		break;
+	}
+
+	return ret;
+}
+
 /* Set up Trusted Memory Region */
 static int psp_tmr_init(struct psp_context *psp)
 {
@@ -813,8 +841,13 @@ static int psp_tmr_init(struct psp_context *psp)
 		}
 	}
 
-	if (!psp->tmr_bo) {
-		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+	if (psp->tmr_bo)
+		return 0;
+
+	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+	if (psp->adev->flags & AMD_IS_APU && tmr_size > 0x8000000)
+		ret = psp_create_large_tmr_bo_for_apu(psp, tmr_size, pptr);
+	else
 		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
 					      PSP_TMR_ALIGNMENT,
 					      AMDGPU_HAS_VRAM(psp->adev) ?
@@ -822,7 +855,6 @@ static int psp_tmr_init(struct psp_context *psp)
 					      AMDGPU_GEM_DOMAIN_GTT,
 					      &psp->tmr_bo, &psp->tmr_mc_addr,
 					      pptr);
-	}
 
 	return ret;
 }
-- 
2.25.1

