Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5237C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6091910E210;
	Thu, 30 Mar 2023 19:42:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F6810E210
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhuTrbUDQjLDahsgWeo/CKGfhsNqtk8Y/kba2CS5FbMwiURoytB512oAvrPQ6BJiCB+wwXCSGwCAD3LQM1rKOoQgRQVOLRbaxHu0mhvTJXIxrkLCUpjrWxOkkAZqijwvpWxOwFsgAxrcCnezyfCt/tXbsIK9K30rffV7QM2sIVH4dwIACxDzTAkAfePYOrEGEXxEuMQ1uycmxAZ1uOlhJzrg+pZoYQTKdQ3NZvYtcJB8bGlHp/fnbJfnpB0GBWdxBQrbyk++ijNZuVsOTBc5APcXNGxJba4LZF9YXJDSn/u1cBebQZNyiDToLc490m3pxScaZSTb3rcThsDGHV6CVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+9N5GIh/BXCiWZ5Q+wrZKjusVyNtW+2P+AEsyOff3c=;
 b=acGThSHGPHm3PVbmpgTykb2X2d0nCtEnYM586BmxAXRRam4t+egSQK9tfeVHGC+5prnkqndLqIKUPMIVb2wCxLczgZWoY77QuFLtmWH6DY0VFTTBCaTwrV6YAaxq0dPQUm7gNpZDRJVSm7MfueAgVIDmKmN+jXj52gla1mDG94S8f1vdnqcO/NyOpAgV0hpWI12IFHZkHR9trmiWWlHNhM2d+kTGmChXDWxBB2N4PkIyTtucEoV+3pmsBLIg9zwt8W3zIiqxC9xdV9fsgp0Cfva+NKv6/59a6rEuB+hXgAQe0UYWIUpaKzNsbpgfKLEz6AY96b8bzuLoQ7IFBk7EBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+9N5GIh/BXCiWZ5Q+wrZKjusVyNtW+2P+AEsyOff3c=;
 b=KcQf0cC/OTPj88mrbnPSd4BP2H5ETH3UkGFnPGS6jBkLSMDQt9LaYUAhfcdWFCuaCVrdBWvsL3iTikBSPcxcl8/zxldVTQ292BLQxpy7LqHGRaKe0I4KwE7qcdeHiXrl2n9yaemRA8Jfe7GMgavvCix6Oy9GSz3fpy+TggWm+tA=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:42:47 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::b6) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.13 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/23] drm/amdgpu: Skip TMR allocation if not required
Date: Thu, 30 Mar 2023 15:42:12 -0400
Message-ID: <20230330194234.1135527-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b14df2-5151-4dd0-24ea-08db3156f06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/Tir+gmkZB1eKOa1E08gciSuFXpzzotFvKivzywoI+Kg/huFm2co5f0CI2+yJIPDkNwPUw9JCPtgaMwPh181MvwuDGABK75kzmCQv8ltj0QaQUSmk2+2DC05pUnWNHRUQBpWuNpImUDiOPtcGgSUzVs/61bDMzvX0Pu9c+MDeXbMoaYsLJK/E+AXyBE29EP11NDYPnuF8lVJD/mL5RYaSgKp2ztGJu9EhIDMtSWzk3pwJVu3gRJjUl3vwP50Z8WRFJQgFJ6+XaEadZf3tR1zYZmkT7giqDS/Z+DOgrzDp+2xollZrz/P/VBTfeONBDFIWOyhfhRAibKCvsEpdYJmADlDjyCTQmk9oaWr+mKjHH7upSXYIjYJzXVN5BSWsVF43cBtv+Ug89WPCCaEr8OQPKEOKXG0tWLK+DWcRhNO9Cjr9LA5FxktFHftpVQQZWHAxtHHyqJ59n0XSqLqXnfuS4oyRZ/YwMkcMOi+He3DJBKm2itz7dqavFQU8NB5LnPWQejLIfveVbqhgdjER/p0hPm8wHhj85wtZKNVgUlr9602ADMuynyJUfhChoWLJvxVvMhXbJWZHzzFh3ZHtm722tQfMcgqDp+nOqW+DjAVi1eyiHTNnKNcQLoaXU+acii1c2VHt1tHwe/YfN/k/vN0+vbqHy87/D06d8YLlVA3RDqQENbEPOGDlXuryBnaS3+rrIf9CXNXOlorbAWeJv7/tgwk6y4Cpi0baJPGvB5wFs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(82740400003)(356005)(426003)(81166007)(2906002)(47076005)(336012)(2616005)(82310400005)(16526019)(86362001)(186003)(40480700001)(1076003)(36860700001)(8936002)(478600001)(26005)(316002)(54906003)(6666004)(70586007)(5660300002)(70206006)(41300700001)(4326008)(7696005)(36756003)(40460700003)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:47.2909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b14df2-5151-4dd0-24ea-08db3156f06d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040
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

