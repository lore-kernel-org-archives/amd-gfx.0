Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09ACC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 427F610E5ED;
	Thu, 20 Jan 2022 11:19:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A307110E5ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErGFYgWF2tKwhlBWcBSP964nxVZufmv6VK9klScMzOiuJTN/16WmwKRb44xQb0TCiOi7yq5IthgZN9btVfnwMF/0xbMPO/cJeoaS15915uAVuO9b9LHq0Jcwzqr9401YxPj2NKC0+J0ZMGuls4YommQQ3kA+8vuBQG0d+ZyuLBbdlFmtVjzSs3QrDt1/ND7QLgzJ1Bnn0A+NA9GGMGmOYtz/7YhCRFjpUTiJg8jEqMN8p/AoIcSStXqQ9Fcsv7vUrKINspuQFi6uKgOAR3PkRno2XS0YVEC3JVIS0RdoGg2aCC3NQAIXjxeXrF2JoPpRGckaPNYkX/e15ur6uxXYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7cPrWgqO3cudy5waJSRgYRYodUIPf62Em8w7Gj2pVI=;
 b=MBHbDv+v7lyi0OMDyNiYvbain96l4Xc3O/kvrWqdffxla0eVAmIyLEqeddo8ywJcTFUp0P2Bxrq8+DEwjkY/bseAugiuXCbaxhJi8HHt/IfWrjlnqHcaFC/YiaDM9anWW4UyAgcVnpWuVJE4LFQm1byhL+9K8oXgzjcWjL9ZQDYg3Ihm5b9s/0/w6WM+8FAB2obvMHQ+bvX459cJxr1PovkspIXgmWvcQEteBAIVBKTRBeOsGFAj+9ocDPCwlvGKAhi0l501+ydas3gVF4kdrdUiTGeqfE79NSaXgN5lS7xueKdwt34uczUfosBv089NRjsuw0/hrxdKFkMEVDfAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7cPrWgqO3cudy5waJSRgYRYodUIPf62Em8w7Gj2pVI=;
 b=MoUzEiML0LnKUfZcqIuJgbNnkYhyPTKyrKjwhDtgNawYQa4ogkjv755c5qd785ma+8fVFIFm9EO/Ok+3ob5HJ3u1zaOj6FM2DHsGF+PPq/U6jV+oeOPV4XOf8jU7Y/ePOh3AZVPCxw4vij/efG/R9O0XowWFba5YkboTnCxfkag=
Received: from CO2PR04CA0064.namprd04.prod.outlook.com (2603:10b6:102:1::32)
 by CY4PR12MB1301.namprd12.prod.outlook.com (2603:10b6:903:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 11:19:02 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::3c) by CO2PR04CA0064.outlook.office365.com
 (2603:10b6:102:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 11:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:19:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:00 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:18:59
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx9
Date: Thu, 20 Jan 2022 19:18:46 +0800
Message-ID: <20220120111853.11674-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120111853.11674-1-Hawking.Zhang@amd.com>
References: <20220120111853.11674-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfeec427-5861-4261-4792-08d9dc06a94b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1301:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB130191A5D907129297DDCF71FC5A9@CY4PR12MB1301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g78M0lphpCtQmd3hwW0TE4m1QnukqohuFHoaU0o4pgq25DzMjSxTMg+bW2qIi1s+HDKR4mzF6Fa7yEvACro1usjnI383a8FSsuu1ZdC1Lawl7MmmuoFn8SQViZlAGoEN/trARjR4DWSbSbEsxBqx8ziPawMaBmsnDfaIYb9ZbTC91/QLNHDN7XJjDxexQsTbxPiwhKTY+IcM97AcF5R6WdmIBLb5zFpb5/DGUBC6lK3dfKkxiSZJ0oNFV37JinNHHOlajLHhuF8rAdjcoBHz3DYWxGnVzljBs8fdwFP4XTUQUaZ+w6AbbVPA+EZBvDAAcvEygMDtd9YXaZneOdahM/EITbplYjjlKiMt6O3MnA1DdpOjuzZ9uA5OEaFsgVhQfvOSqv6H0LMqPuR13wirrsD6NhQIqdPp/XsMo3xCmOvbjN7iFQSa79/h1ooBCpCs6BEzPVMXkVmzUMHSC5A+JQIMSi26h//ti516La5HLiBh4yXkYuuaTgkDcPtv5qnaU6nNsSjj7hHvWRsBTPuO2OByNR4WibPL7GIQ+ixoV8LRieDXy83aeE6wufU1+khZRHsq1GFxe2WX/pGXhgflFbY8IXH0Zj52p6oV5m8bOGP7sabS+YWr1JDsih16weNfgtG6xaQhMR1n0M/krct2vHW1AOto5ESCzmdF+Cw3CDjOmTnnvjV3sgDAJbdv7c9VRmHsZfP2aXrXE6RXsTbh5+11nMM3kPw/cgPBCOo2pciMjLJuowePU6ptF6CPyFVSvafTAiBG79kVgUHYBnP3bMVdKcYXa3BfW17hIzJ2Ch8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(66574015)(8936002)(8676002)(6666004)(6636002)(356005)(36860700001)(82310400004)(40460700001)(110136005)(70206006)(7696005)(86362001)(316002)(47076005)(70586007)(81166007)(5660300002)(2906002)(2616005)(1076003)(508600001)(36756003)(26005)(186003)(426003)(83380400001)(336012)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:19:01.6270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfeec427-5861-4261-4792-08d9dc06a94b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1301
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch to common helper to query rlcg access flag
specified by sriov host driver for gfx9

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 33 ++++-----------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e12f9f5c3beb..17704cd99aaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -63,9 +63,6 @@
 #define mmGCEA_PROBE_MAP                        0x070c
 #define mmGCEA_PROBE_MAP_BASE_IDX               0
 
-#define GFX9_RLCG_GC_WRITE_OLD			(0x8 << 28)
-#define GFX9_RLCG_GC_WRITE			(0x0 << 28)
-#define GFX9_RLCG_GC_READ			(0x1 << 28)
 #define GFX9_RLCG_VFGATE_DISABLED		0x4000000
 #define GFX9_RLCG_WRONG_OPERATION_TYPE		0x2000000
 #define GFX9_RLCG_NOT_IN_RANGE			0x1000000
@@ -815,35 +812,12 @@ static u32 gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint3
 	return ret;
 }
 
-static bool gfx_v9_0_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_flags, u32 hwip,
-				int write, u32 *rlcg_flag)
-{
-
-	switch (hwip) {
-	case GC_HWIP:
-		if (amdgpu_sriov_reg_indirect_gc(adev)) {
-			*rlcg_flag = write ? GFX9_RLCG_GC_WRITE : GFX9_RLCG_GC_READ;
-
-			return true;
-		/* only in new version, AMDGPU_REGS_NO_KIQ and AMDGPU_REGS_RLC enabled simultaneously */
-		} else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags & AMDGPU_REGS_NO_KIQ) && write) {
-			*rlcg_flag = GFX9_RLCG_GC_WRITE_OLD;
-			return true;
-		}
-
-		break;
-	default:
-		return false;
-	}
-
-	return false;
-}
-
 static u32 gfx_v9_0_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip)
 {
 	u32 rlcg_flag;
 
-	if (!amdgpu_sriov_runtime(adev) && gfx_v9_0_get_rlcg_flag(adev, acc_flags, hwip, 0, &rlcg_flag))
+	if (!amdgpu_sriov_runtime(adev) &&
+	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
 		return gfx_v9_0_rlcg_rw(adev, offset, 0, rlcg_flag);
 
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
@@ -857,7 +831,8 @@ static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
 {
 	u32 rlcg_flag;
 
-	if (!amdgpu_sriov_runtime(adev) && gfx_v9_0_get_rlcg_flag(adev, acc_flags, hwip, 1, &rlcg_flag)) {
+	if (!amdgpu_sriov_runtime(adev) &&
+	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
 		gfx_v9_0_rlcg_rw(adev, offset, value, rlcg_flag);
 		return;
 	}
-- 
2.17.1

