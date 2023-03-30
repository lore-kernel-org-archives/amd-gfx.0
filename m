Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C2C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337B010EFE5;
	Thu, 30 Mar 2023 19:38:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9179E10EFDF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTG8oFPIgIeBSujvKKv8xCGDVASqfhqjY0dMRfRnRNyPLD09yF3oOGD9WnkLO87r19gzFo8LfOW3dXJPVBE+Q8qHublExcSMxJRAY1fXBbrP01X0oIHrg+TPGFiXuDUheTKLsts08KQYrgHJTw1prZH3sORWn53j+a9RoDbg9M9GHokSDr+aFlVMnoSMCH924fyW8m1plu3i7oZnRmXwj9Wagq3uWauQaEy+vlRvGoHrpvhn0IC26kfzYTrSDnHIdXjql8KEo5aKWuuaFc8fW28Nc8XdRfHS6P8R0bQW2i1DRVHNAJBh751sB7yydADKp2RuS+1wOg9uucckNyCkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+9N5GIh/BXCiWZ5Q+wrZKjusVyNtW+2P+AEsyOff3c=;
 b=l1cRSpldGs0MT7kqVLLbMJt0yvO4OCLFbrJrnYFohXC61UES9VhYvcEFt0vjvSOYpAZ7kHpA9pBWA7Le7CJGAZFq2dfIQiTLLRlTuUkADYTcS4ZVT3QN8Pd3/eRr59o7sc0RHlJSnZwY9vLJbJBYDvLr7vCn2smdh9UUNmcDnQ5fVWKfsL6V9p8mFjWZIBFEcRXIbaod1naG9CnzYuwuLhgEWC2I/ot2fbOQwVZ2DW+j2Gn16PQzTPOSTfhwNKEuMhb9hZ4CO4El8+Ttl264As/MRr62vc1xxM+53p6RAskqNI8qRMf3oFf2lE2kjUbefxc6RC1SW0ZBf8nufsj+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+9N5GIh/BXCiWZ5Q+wrZKjusVyNtW+2P+AEsyOff3c=;
 b=UhiyHMwkgekiO7fZGS8M7hKFUIEYxSUcHnqGqraSBsVUsaaV93D59/6n9eNsGjyibtFeiADZV74AbByRJSz30AGmjslpv74Lg5a9mxppNhR5NwB5SlaD8jAvYBmXqABPamvW1JNULRMH7TwYKYgC7bQ7dIFwsMoLGpJqSVm+APU=
Received: from MW4PR04CA0372.namprd04.prod.outlook.com (2603:10b6:303:81::17)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:38:33 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::50) by MW4PR04CA0372.outlook.office365.com
 (2603:10b6:303:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Thu, 30 Mar 2023 19:38:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:38:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/23] drm/amdgpu: Skip TMR allocation if not required
Date: Thu, 30 Mar 2023 15:37:58 -0400
Message-ID: <20230330193820.1135411-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: f464749a-8458-4111-a8ad-08db31565930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayzKc6SrPIGhtWxw79cb4oXGdfcasjQiZZ6onNHSIUzhTQGECM7bN2+caWOYD+XqDFk7Z8IkMmy+nrSpXK/KEEpNwwA+u39eDUMuAPOcxx93y/M5vrJ4KcR82/YffOd3tyaBD7OKGCMQwI5+vXeTUyW4FU7CK7d2D4p10cMkq77w14mQwp/zlXY7ZygQNGtYwkXKQg+cHdqpjk0SduN8A4Gwy6kPJ+mUCFgXD/U5rnTenE8Lbnk8XCb1VMdAP8eXke6KUvg7Zy7sPoKybF/hvFe1WR2S+qJEd1NHtkwFncpE8Y+iDuuAvZlAJPYohsTlXupR8SqK0bMV+erdxeNoDsSxzUb0080qRV81zr8FVZRE+jjul8L7KtyIqpiEPvJr2iH23TCcXVBgmxwGlPedhRaFoklv0n6zR2N6pC9OMS8M43Jbzt+JnNZMwpS9uKdErGJS3PjePyxzCTrci7pgJ+jIZe1UqUQc/IDvLPoZEi63iTGaOSubcQzmsjC03I+21X9g7TkAg/J21ELXoAKAUsbz/5bs+YXtljebHp/Wts0fuw26HS0nPyZOuS/RQ6cMfCEL/w1km0gDMpKBfWPTXtngJLzCpj9rZKjlHus7jfSb8/5JBanBi2tSXpPjshvVgNZCxM+Gz9kuxpBi2+QTO0iw4CniZzFnP4ArS6O28vwmpYfDahNAxYkLsaRzrwMvAwMcrVEvXNHuTuxJW7uo6z+sgQDTT3E5yfZ+s65Cx8g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(6666004)(83380400001)(336012)(2616005)(47076005)(426003)(40460700003)(86362001)(40480700001)(26005)(1076003)(70206006)(41300700001)(316002)(8936002)(54906003)(5660300002)(36860700001)(8676002)(478600001)(4326008)(2906002)(70586007)(6916009)(16526019)(186003)(36756003)(7696005)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:38:33.4804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f464749a-8458-4111-a8ad-08db31565930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

On ASICs with PSPv13.0.6, TMR is reserved at boot time. There is no need
to allocate TMR region by driver. However, it's still required to send
SETUP_TMR command to PSP.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 34 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index da89fc460309..c4a70da0e5df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -702,8 +702,13 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 				 uint64_t tmr_mc, struct amdgpu_bo *tmr_bo)
 {
 	struct amdgpu_device *adev = psp->adev;
-	uint32_t size = amdgpu_bo_size(tmr_bo);
-	uint64_t tmr_pa = amdgpu_gmc_vram_pa(adev, tmr_bo);
+	uint32_t size = 0;
+	uint64_t tmr_pa = 0;
+
+	if (tmr_bo) {
+		size = amdgpu_bo_size(tmr_bo);
+		tmr_pa = amdgpu_gmc_vram_pa(adev, tmr_bo);
+	}
 
 	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
@@ -748,6 +753,16 @@ static int psp_load_toc(struct psp_context *psp,
 	return ret;
 }
 
+static bool psp_boottime_tmr(struct psp_context *psp)
+{
+	switch (psp->adev->ip_versions[MP0_HWIP][0]) {
+	case IP_VERSION(13, 0, 6):
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* Set up Trusted Memory Region */
 static int psp_tmr_init(struct psp_context *psp)
 {
@@ -819,8 +834,9 @@ static int psp_tmr_load(struct psp_context *psp)
 	cmd = acquire_psp_cmd_buf(psp);
 
 	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
-	DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
-		 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
+	if (psp->tmr_bo)
+		DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
+			 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -2083,10 +2099,12 @@ static int psp_hw_start(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
 		goto skip_pin_bo;
 
-	ret = psp_tmr_init(psp);
-	if (ret) {
-		DRM_ERROR("PSP tmr init failed!\n");
-		return ret;
+	if (!psp_boottime_tmr(psp)) {
+		ret = psp_tmr_init(psp);
+		if (ret) {
+			DRM_ERROR("PSP tmr init failed!\n");
+			return ret;
+		}
 	}
 
 skip_pin_bo:
-- 
2.39.2

