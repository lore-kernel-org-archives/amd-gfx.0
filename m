Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AA4C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF2D910E436;
	Tue,  9 May 2023 22:21:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F124510E42E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJPxOLbjTVbhYCJhDaxPFAZVLwbSSRLg9sL6VciRp2cSKwLwAVFENs37Ld+yjSbkxjxJUUNPExFtnDpO56xzZpSWsM68GzizQcF3MCiN7N++RRDNbPquh/SvnhlgbjSAuQBquWtsqMFBl46KE/I5CpZTlkCQUvjB5aqr6cvwtJoAKsoo0GpbGGpPKgZ0Mpo18A+9v4pyPhi/Zeer0FsyySG66vdwquZKCY50UPkqJbbCBmRwXFU87SeDHXpQ6uRGpdxhyAraNCT2gIxs94XBXOcaENId9PvSrHSICPAACFJPTzJ3YgnnnZ4b8KDB9Tk3o5MnQ3dJq2QwIyn59RionQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87LxMeIw106hDqGevO//VPz473fPJIUIhLKUBjXXzxY=;
 b=YKizhSPsPj34s/Js/0S62kxnHrLIwO0VZgQmNspEtd55wRNXoPylXq8fjDKcqaII2CQfxTTmkCJ8Xh2WUSQb2ZS0jwJGxRiz39bOnNOSqf3EIrqhivAaXBS0pClbHKksWMjeRN/mnAEhKF3Fngj7Z+BuKrxake0V5iixWtCOTgf717Pu5S3RDoCZRHOqS3GC1pnuyuU2wpERiz56pun/KLHmYVbbWUu2lFUjS91UPO+v+RQEVfrRjf9T2RsuTQK1EHrDmMEctNAIfGXeKr1j+h7yp3f7wu2xcJC0AuR6qmA8c5Qazu/PrwKnRTZoimvUIUxj/tI08J2WVtBCdqHSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87LxMeIw106hDqGevO//VPz473fPJIUIhLKUBjXXzxY=;
 b=fRZTbDC0T9EotuAVIIK56nKSqob+bT7fiQztDljycH2dTpYwOIQdmK82wJUmvG7VIJiv2AdIQKQ7Qbpf7jM0rmqvCkSpqjWiXEVQUuuM9xmo3ofjkFBAXxv/qEGdPM/WKJ2MBsPwdCb+o2AJupI6mm0qeRaaHeZACDMh0Zu4rAk=
Received: from BN8PR15CA0009.namprd15.prod.outlook.com (2603:10b6:408:c0::22)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:21:42 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::b3) by BN8PR15CA0009.outlook.office365.com
 (2603:10b6:408:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34 via Frontend
 Transport; Tue, 9 May 2023 22:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:21:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:21:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amdgpu: Re-enable VCN RAS if DPG is enabled
Date: Tue, 9 May 2023 18:21:22 -0400
Message-ID: <20230509222126.477847-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222126.477847-1-alexander.deucher@amd.com>
References: <20230509222126.477847-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b7eeee-cdfb-4942-ca12-08db50dbc3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtW0vZlPrq7wNMacJHfVMXvfMRqg1s7Rnd4StdEYOqevc7ohuGz7T6EC8dvvCXC7r8xp+6obqU5TpSMmHm5/cray2GC/TpmLyVWl2Xv2jgS6RxUZwym7ayp+o3P52HZAZ2RGWTB7TOlRHs7qqDKumDG5g2Vct3BfOvfUfetLLYi4OSxMDW3YFifttu4IgZ1KynXAKKWtCqOe/E1Ze8CkAppSn/KtsHaHkDFN4D3nwsOZyBKt+R5dEFGK+W6de7zJBVOaOWOsadRtSp0jwnluu+Pv1mOYnqHKJHeHMPTQSwIBDCcSXPdFHKbvaYpUkU1bxOsAqeMFlY/mc3fTs0yj+6HpxNFAMZugCs2ZAasv5kHrJjxQxzAW0KmQwjnXyXVnIxRCeM8+79FHcvEZ9Y4LVYKyAYhr5yL1wXv6k+CqypcyQvPGmHY4HBCUc6IrWXJzGPi+5Vo/YJhMmRuDAESQqTmfd/eCCA3BZ7nU9yiDksEfMB7hGPZgd2BBV6/mmrIgRbOQazcUa8UNePsl7/8f+vUQhQgZHpyAlnEsEZp7l2R3hhZYdug2RtYDD1cGqFI9e/SBuWUhmkmHwOELBzBg6M1IXIOq1AYq7GIBQUa/ceq/o89Ub3iubZ6PAlz+gRpobpj/2B0fKfHJ+zfUohuiJfCNCKE+oGMV8aK08WFf1Cax7xVAVKG/i4qjuFqz6dBAu9BGQPhuTKI88rFYK/lH7YSyhhO1PgA90uwyni3abQEDyagULQEgvbVnpMscnT3sxUQAciaj/iUeqxNEVRH3rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(86362001)(47076005)(40460700003)(36860700001)(186003)(16526019)(336012)(426003)(2616005)(26005)(40480700001)(1076003)(81166007)(356005)(82740400003)(8676002)(8936002)(316002)(36756003)(41300700001)(5660300002)(7696005)(6666004)(70586007)(4326008)(6916009)(70206006)(478600001)(54906003)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:21:41.7461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b7eeee-cdfb-4942-ca12-08db50dbc3e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

VCN RAS enablement sequence needs to be added in
DPG HW init sequence.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 27 ++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7558095ecf6a..c77ceaf53dcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -52,7 +52,8 @@ static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
-
+static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
+				  int inst_idx, bool indirect);
 /**
  * vcn_v4_0_3_early_init - set function pointers
  *
@@ -769,6 +770,8 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, regUVD_LMI_CTRL2), tmp, 0, indirect);
 
+	vcn_v4_0_3_enable_ras(adev, inst_idx, indirect);
+
 	/* enable master interrupt */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, regUVD_MASTINT_EN),
@@ -1514,3 +1517,25 @@ static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->vcn.ras = &vcn_v4_0_3_ras;
 }
+
+static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
+				  int inst_idx, bool indirect)
+{
+	uint32_t tmp;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		return;
+
+	tmp = VCN_RAS_CNTL__VCPU_VCODEC_REARM_MASK |
+	      VCN_RAS_CNTL__VCPU_VCODEC_IH_EN_MASK |
+	      VCN_RAS_CNTL__VCPU_VCODEC_PMI_EN_MASK |
+	      VCN_RAS_CNTL__VCPU_VCODEC_STALL_EN_MASK;
+	WREG32_SOC15_DPG_MODE(inst_idx,
+			      SOC15_DPG_MODE_OFFSET(VCN, 0, regVCN_RAS_CNTL),
+			      tmp, 0, indirect);
+
+	tmp = UVD_SYS_INT_EN__RASCNTL_VCPU_VCODEC_EN_MASK;
+	WREG32_SOC15_DPG_MODE(inst_idx,
+			      SOC15_DPG_MODE_OFFSET(VCN, 0, regUVD_SYS_INT_EN),
+			      tmp, 0, indirect);
+}
-- 
2.40.1

