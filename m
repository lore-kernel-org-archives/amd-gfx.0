Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0500DC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 07:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B4010E343;
	Tue,  9 May 2023 07:33:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AE010E345
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 07:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQa+5Hta5uWXmopbwD2mTmghp/+j2aDCrJtmOuubv2LYRGHV3dOVBRCsGftUEDT72CS6dA2oCNKBuP4pkDkPbYK3FBv3csg2O7flaCmadYx4BuHRK3Z++qJcnI9QINUWElfACINSpcDXEyqjumiWvWcUrhCZLRtxQOiyUzOPfiuZPt+Y1PDvKJHJH/yYilKZREeirTSO/E05igl61gSZQZCZyVIN/X0O3cBQPcRuxAcq/t+wgYqXNsK6CpgcKoDRbR8Iz3zvl0TkEiPVggC59eWYS/lqfWK2lO4SSzANZX7jp1fjQLOvy7Nt5I6kJACe71nIDebwZvU2JgW0Z8aQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLuzTr1yNdlhXFEhgToLs0W/Q2qkMEGt40pAdjXtSGU=;
 b=n2mb+JQT5R6z929q8EL4ggOlbbXLUWXxEjvSLAoP/Kc53oKaEjUtagIE2Mjzr+6zrRtFpv2RZJPbnBwZntzJ3l18mp613sAxrGyR/eiUz3iOXAzbkPCHA9+K/FAiquel/hEuOEc9rkK+uMjfupeYg7NLKvXskZqlOKRzEF2jdNgJ7yydpna8NlzRwCJmEWPOtljFdnPhQKN/zUyt8yO3Upl4emtvlmQ9p8WGj1TDKc575EVuae0MWVh9IcaK8FLR0wYylLVu9Zcy85VbLEEAHxiedqbaDD8Q2EBGiN3bVIzHYUXkNuWcQyrg6Ik7u+CHsyV6syt8ewPtURZbn/uElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLuzTr1yNdlhXFEhgToLs0W/Q2qkMEGt40pAdjXtSGU=;
 b=X7p0RxTI1IXBo2M3aBmQzrH62rmsJnbg/ar3Ol4Y5+oVOCSCsJI4K915a/lxsU2Z7h8MNJfphXRhHQ2THLO+BLtvtQwT/ocOrL4VrzX60yXdH2I4b7joZQomFuYTR+qOL52JUqwvEluvEAxPv1LlCSuJ/ZviIbUzVP3m9E6VhD4=
Received: from MWH0EPF00056D03.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:d) by MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 07:33:04 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by MWH0EPF00056D03.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.0 via Frontend
 Transport; Tue, 9 May 2023 07:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 07:33:03 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 02:32:55 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove IMU ucode in vf2pf
Date: Tue, 9 May 2023 15:32:29 +0800
Message-ID: <20230509073229.957867-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: bae4879d-fee3-4c28-2ea1-08db505fa009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8poJ0F1HGdttOVYYtHDMwvIAu1HSZs0LdiWxlOqjT02FKKaPSSIkPbQU3p0ZFQ0jgooa2xvymTPP2DCwoPUMdIM02nrfudFBLMNVS51E2MTCsS4dssLOHXLT72QHRHCpMf+nIUon7ufZbrhWqw25t7meFcgH4iYLd2+cpjW6QetQqtMO/Dkqh+6CLaLjhbfcMWe9t7dsf3Azf++2cmRF3Cg+1OTqVomeZDEwNe08bS99vRsaGMHZgIVH/X0/9SnaGdj0GBnYMs6Szvr1BUv1JIH4fkC0cWSqdoYqBUNmw/JdDyqC+QytyKpX9EHfO5D78iZkoU/9vOsJDG7i6cFGFAvQ27FSK0Kvg0B+1LAiCzSxHnQB48Y53xNX460s2CKDUKNFddIxYYk7ScxNR76VD+OlJ/8g86/xrbl7nO/eN/Y7yh8OKgaMG3WI9lomZ89CKefFRGAqirAvz/v8K5Ija//WZPJLDFcflmdB6DI7ERWHx+H2axeOO0zL/UuhOGpvCY7sY5nhE1TMg9H2K38Y5ZfxzGmf1eNqBefRvIzD6NHcBT8q6gEpGQs7+12cC4GAeULPWaZUvPyBSMVPxYZwuSS4uCq1Q28hOzWP2s1d7IWoTLoiD96NhLYxOynZ4XT+YGZyNrM6pP6NrWk3j0a4rf5Y2JcgAmsGMNgSSPgNxKRaUNF+Q/RTq54LHAoNgVqbdZvy1TSwbRS7imyJboI2ZLaZFkOxanG/BlCARrx7Rlw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(2906002)(8676002)(8936002)(5660300002)(41300700001)(4326008)(316002)(6916009)(36860700001)(40460700003)(70206006)(70586007)(83380400001)(1076003)(26005)(186003)(478600001)(36756003)(6666004)(7696005)(86362001)(82740400003)(2616005)(47076005)(426003)(336012)(40480700001)(356005)(81166007)(54906003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 07:33:03.8566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae4879d-fee3-4c28-2ea1-08db505fa009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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
Cc: ZhenGuo.Yin@amd.com, Horace.Chen@amd.com, YuanShang <YuanShang.Mao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The IMU firmware is loaded on the host side, not the guest.
Remove IMU in vf2pf ucode id enum.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 1311e42ab8e9..0af871735a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -557,7 +557,6 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_IMU,      adev->gfx.imu_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
 			    adev->psp.asd_context.bin_desc.fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 24d42d24e6a0..104a5ad8397d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -70,7 +70,6 @@ enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID_RLC_SRLS,
 	AMD_SRIOV_UCODE_ID_MEC,
 	AMD_SRIOV_UCODE_ID_MEC2,
-	AMD_SRIOV_UCODE_ID_IMU,
 	AMD_SRIOV_UCODE_ID_SOS,
 	AMD_SRIOV_UCODE_ID_ASD,
 	AMD_SRIOV_UCODE_ID_TA_RAS,
-- 
2.25.1

