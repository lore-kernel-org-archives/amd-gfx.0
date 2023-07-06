Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BEBEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8376610E4A4;
	Thu,  6 Jul 2023 18:55:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188BA10E4A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+xNgVOyd6fiRM/EdWV8Y0mGqIZ1dxF6UcyxVV4WxT7EwCDe70mTSZCRDN2AwV5Q5Oxrr6bYR0DdP2nbDlx2ngn8x7+lMSZMaq3t47DJ1tV/MF2Ge2Mh36NpGJGFvSDWLhY6ReG9q3GShiD0XwgDbl4VF611xQB+8PSQo6xAz7/8DlJgc+ZqKBQ7oFEhPDVfEVUWSfMVX/Fd2mFSbjboc019G3ngiDvy6Pqw0EsczSr2XHvXDXvW3CHK9gQsZkH8Cw/eNwFF/TSR2qwarfUMU0SUb6l7a/eY8Clb1HroFZUut4UqvJ5rhN1E4HPE1mdZstM0zTQpvJZLSOT1p0Duwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/cgQ7d40Gc6ANIdl3822HU3eC2TXtx5gNlL3Jnpw/A=;
 b=AsPgadeXnUPQd/dafpLIbe8aKFuRE1MJt5a/t2VnZsqubNoVLXOrKmoqIMumXjsq//P+15rb7iCglh5V7UwkwublAMwVCJhB/vuKczwNG9D+64FtBY09cqR4cpnXGR/SCsJrAD7SjJHqUgt0lEnnYDRjWcJwsB4qv066AaSlcQOFiB1ZNF94IdNwlhM0LgQzOtgAfzCjO/VXCdiUDX1ZFBWkmpeD0kLMM6gN6SMtvlWiKptPeTE91WtwtVkPgllW7CqKR+RYemb5cplO1u9gkgyM3W4QHUzaoxeoV3q3fuSt6EV2s+Egqnk96aPtKSK4yL2g919VaW4rkfe/YLF0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/cgQ7d40Gc6ANIdl3822HU3eC2TXtx5gNlL3Jnpw/A=;
 b=i/q/lUjDWpGawAlxybS5S6KpV0yw8SRy+mEg8Drvtah79yjhon6tiVWwwr0L7/aiDGJG1yZYRgt7wU0Ke4Lcc66s4H5AJJmt8bNEhOF1BbLIRXJtRsr6awpl6R/jCpUTlyT4bMaKhWvBaqW3h5r7DGYaRb/RUe7+fwyJUni1g9w=
Received: from BN8PR15CA0032.namprd15.prod.outlook.com (2603:10b6:408:c0::45)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 18:55:18 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::41) by BN8PR15CA0032.outlook.office365.com
 (2603:10b6:408:c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 18:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:55:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 13:55:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gfx10: move update_spm_vmid() out of rlc_init()
Date: Thu, 6 Jul 2023 14:55:01 -0400
Message-ID: <20230706185501.7471-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706185501.7471-1-alexander.deucher@amd.com>
References: <20230706185501.7471-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fff4b26-6874-40e1-a2b9-08db7e528ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cz11hN+IeBOl8M8KLsonpFwN4777TYUwKc0BqRpYbLlNbkAzwuZjuitbTo3HlDsEBm731lfc9xyc2LeFG+tIlSlpkMOsO6EFSkHd0hAVq/07/pRDnU/X+5/P2ZL4OMNRQq+m2x8TWRRjDruRcyltXslRb1sfTYHrdfC4D7BDtahKOVd5C9N/YssfsrYWz9XrWCzsZLyGGf9cG40pmDF4pTezJNRe+sDydblC7oHwUb2tOgLBZDoZaqWyr02pF6uCvkKf+3qGA0tvcp5DMc8LSUrcrIBNl//tyTuwwUaI9xmRFkqmdRwTr1nroqnWss9ebk4SGDLyCq6wZKn0ec9WbyDNVLhR8p0hy8can8e/RJjQsUmkgs8ZC8ThHlKkxUSm0Pb7kq17Bzmq+Jn2RWI1eBowGPxX8jVYMd0r5I7z2CWLGj78Fov91QwlnH1RPdv0S1MIIbP2qRzAOvi18XdaQAFvchhtyKVnExCuD9Xd3QnPAyYwIunNrCBYbqxExkB3S82oMjt2dSFtFhJeMcdSZQoRS3XLE7VFvQqvAZqEA+IehjB2MywLrNWzebfkYopypX5OuGR7KMQCy1wnd4GZ6QVzbgj2r5Sx2gJVubL3VXesSm0MLS3cer0xFe5mnkYqEL2oGyuBjxmAKR+4Gd5xEOjemWN4JKtqZuEth49DbGJmTtq5TtI/ChbcsZbEmtD/ywb1vZnRiNfiIsBV9IMz6KRPYEKQMpMRh8Er4sY/jD3yqdGNIv02i2aRkpY6aIXPbLWx/NRfMes4vWwyDu7qxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(478600001)(6666004)(1076003)(26005)(70586007)(186003)(16526019)(70206006)(2906002)(15650500001)(82310400005)(6916009)(41300700001)(316002)(4326008)(5660300002)(8936002)(8676002)(81166007)(356005)(82740400003)(36756003)(86362001)(40460700003)(47076005)(36860700001)(2616005)(83380400001)(426003)(336012)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:55:18.1450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fff4b26-6874-40e1-a2b9-08db7e528ab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

rlc_init() is part of sw_init() so it should not touch hardware.
Additionally, calling the rlc update_spm_vmid() callback
directly invokes a gfx on/off cycle which could result in
powergating being enabled before hw init is complete.  Split
update_spm_vmid() into an internal implementation for local
use without gfxoff interaction and then the rlc callback
which includes gfxoff handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 91261ed489257..1b188aeba6515 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3506,6 +3506,8 @@ static void gfx_v10_3_set_power_brake_sequence(struct amdgpu_device *adev);
 static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 					   uint16_t pasid, uint32_t flush_type,
 					   bool all_hub, uint8_t dst_sel);
+static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
+					       unsigned vmid);
 
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -4187,11 +4189,6 @@ static int gfx_v10_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
-
-
 	return 0;
 }
 
@@ -5169,6 +5166,8 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 
 		gfx_v10_0_init_csb(adev);
 
+		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
+
 		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
 			gfx_v10_0_rlc_enable_srm(adev);
 	} else {
@@ -5199,6 +5198,8 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 
 		gfx_v10_0_init_csb(adev);
 
+		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
+
 		adev->gfx.rlc.funcs->start(adev);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
@@ -5207,6 +5208,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 				return r;
 		}
 	}
+
 	return 0;
 }
 
@@ -7907,12 +7909,11 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
+					       unsigned vmid)
 {
 	u32 reg, data;
 
-	amdgpu_gfx_off_ctrl(adev, false);
-
 	/* not for *_SOC15 */
 	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
@@ -7927,6 +7928,13 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+}
+
+static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+{
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	gfx_v10_0_update_spm_vmid_internal(adev, vmid);
 
 	amdgpu_gfx_off_ctrl(adev, true);
 }
-- 
2.41.0

