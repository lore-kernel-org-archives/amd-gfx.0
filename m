Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07F1C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B0C10E4AF;
	Wed, 14 Dec 2022 22:17:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2F810E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl5qTEPA+/1bYR3cIKuclJsrz23T1/9L0LsmkJza7sIuFhzVawKA8XeNUVEP0QH2pdafvLjYsT2Xyp+XSBSM5etdTiq/RphT1FIk3JEVptUXKAH3hrKzcIIDSc6ZmNK0UVdBw5Azb5WOpo6zFoUlo8tWFJGYXOvqx7J40uIstE7/eFZ4Bx0dD18gAF3rwcDszCkqvoOiOretyGRvp1/q+3FBlQGoKc3uDJzua5w9gLn2acHHiGi/982TZ4Shu/zLl81jKabqihtmiMDlPvUNntkIAFQAhSDAaEk0+MnIPHgtAM/4Xk6/nncSPHgmkJFq/hofI78ubm2OoEe+qPZkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBTAeLXqXTae8JC0LqZVRjPs0PS5bXML3dYqexpSN2o=;
 b=fcEJTZAyoWGtE37teA9E1cNX/8a2EJkTrYcoBheI1CVSiv5CnQjWJDKOl5RZeA76xPwlOWO4e5DVB280Iv0JHXmX1TQ0xc+1j1VdA8uN0x+HXwWmo4GVEmu/miqUuRFFNxMbzKTIc3ll7YNvZa2znkJTVC5UVddunss3qhv8Yg+JhvxVkh63AX5uhSQ+VjDPSiWJGCvoHlhN7Sap/YnPj0AmGFiulDGs2dsDrUFZxc8zn0nRbCmgO91NURS1ilkvLXSi1BootH/v1yRymrqcSAHOLeeKY7U7Cc3h2eybnJrPAvNZK9F/UiFHXiADlHu1X5L+Q08Qg/hO7drMnXhUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBTAeLXqXTae8JC0LqZVRjPs0PS5bXML3dYqexpSN2o=;
 b=c6Dx3tyVvjPhCbc8asy/cUyup/xsxf7wXTcpl0m3HrjQsOuAeuIbXLKvvp82wk8FRAQPUG29JE/eeyIZPjd5UJaKvsIS9hfdOM7zxTwOL8VLOlnrxZmm2LFvMC6u/LhLRDm6gailLSYtVs+CbTkgQJtbjgdmf/Zh/BUHsPw9EqY=
Received: from DS7PR03CA0311.namprd03.prod.outlook.com (2603:10b6:8:2b::23) by
 PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Wed, 14 Dec 2022 22:17:12 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::52) by DS7PR03CA0311.outlook.office365.com
 (2603:10b6:8:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 22:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 22:17:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 16:17:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu/gmc9: don't touch gfxhub registers during S0ix
Date: Wed, 14 Dec 2022 17:16:48 -0500
Message-ID: <20221214221654.1625194-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214221654.1625194-1-alexander.deucher@amd.com>
References: <20221214221654.1625194-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 0494b681-c69e-4300-a54a-08dade20f2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vz8er93OLixLHS5SQZ394cH//yNO/s2zFuh5y0DgeS8qmhDiWhgPeid+wsgcr9ggdWHBM0nJlFLklZyNoNUye8BzPIIoTtspC8EP2v/8HRy6aRowMF4pswLISuoTKnyZ0/0w7hm8n7RFuOMx7FFjwLqHQNzMsCWaNVGL4IYaBRYY6nfDRnzuRQ80glt163o6/IcP91bhmroSSShsoBQKGm4sWVKgiiP24MkUqa3nKrPxyfxqqksf43HMXy+TWWrK0JeLsKLqPyz8SvQExis5KZ1HI0YYw8l/5Eq2z4Xc9hQKduZAGYtXpyj3bgK0ZSSoISc7Moq3+Wdhj3++yQs7mfHuDc3y0PV9mmzoY4CBVzL04YxkTi4sy1XqOLxMMvanXmmN9GgY/1iBg1swUYpgH+sAIbrHmkDE4vPwx6sPRLOeXJG8gnwaFeol6jThiQ/9v5212BZktmzunSHtEAUK5P/QmY2TNpML2ujmO9dhYfOs4sNL4JQfyEXB/rG35HpN5GTyU49BNVn57nOSv+srqQ3EbrTxQ2cAi9VaLMlcNLF4tpqmIc3ahUo3WhQG3bZ1U0h5W6rC4PqvnxvugxSlgrG1fQnDBvEzRvm6KacfuquOJS0XPdXpZI5/o0K2X/NkARfaQdaQRhoqycFauEZqP2a1tO1upbWcZjzybaWi0nl3RaiMOixLuGdHhBLI6LhEZ3OLqs1S4bRtfDk6Z5XDW5f+xH9/1wr+6wSQMc1hD6Fl4Kpswwdl4gZthCrk7rZftg11rhbZK4+zAsvKDOzmHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(356005)(8936002)(81166007)(2906002)(36860700001)(26005)(82740400003)(7696005)(186003)(478600001)(70586007)(6666004)(70206006)(8676002)(4326008)(5660300002)(41300700001)(36756003)(40460700003)(426003)(47076005)(2616005)(336012)(82310400005)(316002)(86362001)(1076003)(6916009)(83380400001)(16526019)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:17:12.1414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0494b681-c69e-4300-a54a-08dade20f2eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfxhub registers are part of gfx IP and should not need to be
changed.  Doing so without disabling gfxoff can hang the gfx IP.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 08d6cf79fb15..5f07c85bf729 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -484,6 +484,9 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
 
+				if (adev->in_s0ix && (j == AMDGPU_GFXHUB_0))
+					continue;
+
 				if (j == AMDGPU_GFXHUB_0)
 					tmp = RREG32_SOC15_IP(GC, reg);
 				else
@@ -504,6 +507,9 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
 
+				if (adev->in_s0ix && (j == AMDGPU_GFXHUB_0))
+					continue;
+
 				if (j == AMDGPU_GFXHUB_0)
 					tmp = RREG32_SOC15_IP(GC, reg);
 				else
@@ -1862,9 +1868,12 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 	}
 
 	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
-	r = adev->gfxhub.funcs->gart_enable(adev);
-	if (r)
-		return r;
+
+	if (!adev->in_s0ix) {
+		r = adev->gfxhub.funcs->gart_enable(adev);
+		if (r)
+			return r;
+	}
 
 	r = adev->mmhub.funcs->gart_enable(adev);
 	if (r)
@@ -1911,11 +1920,15 @@ static int gmc_v9_0_hw_init(void *handle)
 		value = true;
 
 	if (!amdgpu_sriov_vf(adev)) {
-		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
+		if (!adev->in_s0ix)
+			adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 		adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	}
-	for (i = 0; i < adev->num_vmhubs; ++i)
+	for (i = 0; i < adev->num_vmhubs; ++i) {
+		if (adev->in_s0ix && (i == AMDGPU_GFXHUB_0))
+			continue;
 		gmc_v9_0_flush_gpu_tlb(adev, 0, i, 0);
+	}
 
 	if (adev->umc.funcs && adev->umc.funcs->init_registers)
 		adev->umc.funcs->init_registers(adev);
@@ -1939,7 +1952,8 @@ static int gmc_v9_0_hw_init(void *handle)
  */
 static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 {
-	adev->gfxhub.funcs->gart_disable(adev);
+	if (!adev->in_s0ix)
+		adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
 }
 
-- 
2.38.1

