Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB0CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2E610E4AC;
	Wed, 14 Dec 2022 22:17:21 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F13310E4AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyW2TIEDYoA4AiAGcFHq1oUbfK2U5z1r+rQREpVbmxkjES0OqNlBdRZeD0v2NGlgycsDIobDeQax6MnloKApyWprdCr0/5p/56UuNK2Kvz7MM3x7raMGWhA5Zi84Gk3c0lyXJG3O7k6F7Nx1TTJhnAhw4to19lLTqCjsc26BA0qJnpch++xmBAKzgQwOMnRz1AOjwpHdPRb4C7EkSHRdPjTHlaY2XZ3/4D+HyST8OGzbKqFowapnIe45SSWsdIq4yuFYNoMbWR6oXyleqodB7O3TK3y/l0U0ksxTXQvp3nauc2eBiYU70QWU/DCTGZu0EEU6XQKlvTGphOoagSY+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvWEdsZp69WinuxgqNIMQmBLfmiOnNpUiH5hD8SG9v8=;
 b=Q5ugHm9gQgc1tOcO6iI6/BrMH22fY9ZeSkQwkgV6p/GgfjG5DThe5OAk7ajIVZyd5HpmNDT4WZGfjP3nRRiEqSrrvqWAmdF/IeOMxVaYbO3aG3K+ShTwrgNW9bzjzKeMsDjHpO10Fv4EQGZ2ME/5Df4SkynvxehW9mlrRB8247Y+6j5sKdPmFO0Vzi+2c15wkSG+oFZgnMleLumVFlfAW4Wx/SCCrC7G+sE9RR0f69FT/H0H+xbuLoBcemiW68a/Dtuq0NTsM7Wr2Nd8/mb0pSq7pOGTw6XotyBH0AKOH+EMd5GG1vCOwboaBRW5vDq2k4T5gyoEwuSHLmUaHJX/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvWEdsZp69WinuxgqNIMQmBLfmiOnNpUiH5hD8SG9v8=;
 b=ZT9py3wSwmydI5ahjO8p9+ZvyE5Z0izupQcdMscHtpK7d8TX8BWXmQ1sDygG9iyanKxX/sFJAWDHkpKurDK361Amz60+Q5RPoUxcUpL78WpSawYDx5Whsdg6O7ATK57BHs4vByr271o5pSqxmtouS4miIIDPtFlda5nsUNBOuYY=
Received: from DS7PR03CA0311.namprd03.prod.outlook.com (2603:10b6:8:2b::23) by
 DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Wed, 14 Dec 2022 22:17:13 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::74) by DS7PR03CA0311.outlook.office365.com
 (2603:10b6:8:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 22:17:13 +0000
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
 2022 16:17:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu/gmc11: don't touch gfxhub registers during S0ix
Date: Wed, 14 Dec 2022 17:16:50 -0500
Message-ID: <20221214221654.1625194-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|DM4PR12MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d30d9e0-0972-4c8f-ff6b-08dade20f369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hA853fbnEFGEMpvhpSxPhMVkWK2Fl2Wef0RyW0iJ9zN1g6rfmYbjo1KdW4SrYAl509FyY2q4Tx4y37ERBbaRtf6Pa3OUs7ruPHxt6MM2aoze3FZOJ1KVq0VeBJJgES8+DQEid5ev1aK7xsj4M2K9nkq0X5yH+WbAsdo0GTSJdsjBoGo+O/JabdR7oQ4GpgfpqctsVp3FBx4nKfb1zR2M83wbj/U4dbjs/20QSBt420cfL0kSbOFhcJBqZCixND/RuFBLawLHENGRpEOtTMHSiO29Kn17qdDFUhnNz/kwZ2vm5a1ty6nAVE9m1RZhYeagO2FypwRkNBq4+oUnBYS24Q7tLrz22vS3F/YmxS+e66O6Ush5WZCIyFhhuQqdsD/w7TAM9s+qEVWwjL3MyVZLhsW5UxDfkg455T+zJ2O1oMPb2HV5477WXYT3QMBQBRvGw7ed+PXKNh2B9yT/N7oT1kvtbqnv0h1F+dt2OlRbxMrv59dbFR1FndCWOKfEUOpYIMaSQCr5bNKNme94xWYBExnjOxN9ezsSIS4P2FeYBE80jrR1JD99q0DpFw3+f79UjwggX937zUWizsEDF9QYDBpUQ2RvfAMwNNhdw1K0O0K9EO+yl0Cl7ZSphcxXyROJ6fE0bJhB7M31Be+hqGm5208scv4IPAx0j51JKSTpWVupFARqHt+DOgV+/oOIvWDC2uVPdKs2sPmgN6NiUSohrI3Q3cqGyg2azR5U4eWAs13ocQ0dR0P3DcRDvP1ulh0O
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(2906002)(40480700001)(40460700003)(36860700001)(5660300002)(336012)(8936002)(86362001)(1076003)(2616005)(81166007)(356005)(426003)(47076005)(83380400001)(82740400003)(6916009)(186003)(316002)(16526019)(6666004)(4326008)(82310400005)(41300700001)(26005)(8676002)(70206006)(478600001)(7696005)(70586007)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:17:12.9695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d30d9e0-0972-4c8f-ff6b-08dade20f369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
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
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4326078689cd..7e7188a06f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -64,13 +64,15 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		/* MM HUB */
 		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, false);
 		/* GFX HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		/* MM HUB */
 		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, true);
 		/* GFX HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
 		break;
 	default:
 		break;
-- 
2.38.1

