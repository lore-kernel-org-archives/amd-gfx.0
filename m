Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842E3C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 02:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE71A10E04E;
	Wed,  2 Nov 2022 02:39:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4971810E04E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 02:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLIZxpV00WNtMGG8cbRSiiVedZ1YpYH8jR5fwT4doBumOIaKOWENmq1cP7kTQyAE/09lpiJRhE3atajKKxXVslU4cFNb0Q/g6My4aKref9ajP4lxETIp+XD/TI0VJvAm29857CA6ZA/g+9xkF7TcCBeDjOHpL7tF3FIyrMluugfUA+QOj80IEUov9X0QW1ongCL3UNpWUAH9HJWxEOwFZOQNcUqfyuPizKSymOO8MUvRJkLSi2Sk2fFrK+iWnF/GIjedVuGhTOIDyMeCws2eFyDgJm6E/oNREka/9jcMn/K3zg9w72qkvY6E90S32cKtDDigxkNPJLtX5r6yGTMWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMrQDhoyKc5NsKAa2f47ehiIWHcX0KvOm/TW/XHnu+Q=;
 b=TCPYjckDDj4W9pXdYEQt4YyQuMl3+lkVc6XHwypC626DIL9t+pofhhB8Ogn9ZhELMByqk6RePO58vzAEo+RhUmWMUB3vLDFAoyZvYftsrBdOuQkTgB0OAKhDBdCnanpA6Zq2kxqjthuYCooBFt4DlfUAlCRmSX2fXLwTrKL/1v2UibSVeOGJlcVlzW7p6ekhzf7tQk8wdTuKAKbzKpUWBG9OTpxQmWX8HNDSo6aq+g9LJGR4GvCbph6Nq154QEcMLszUqyOAE84qB/oPSHBG+sA57r3NfpLpyS7AuKzPJn0b3ntLpdboOmHuAQoQMGq+DA2BaXVC9a6JnO/sWH2Opg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMrQDhoyKc5NsKAa2f47ehiIWHcX0KvOm/TW/XHnu+Q=;
 b=VC2V3uUJDJsanP5+oGHgp4cLhHksbDVojpQ+ORWjHkltXuA2HQlRJZMkEgk4BV9a5WLK+NoCcwEX5ss5u720ylcMqdIgI6p+Li1f6fDMVpLvbHEauWraqPy8amU6lYubJiE2S/ZyDON+geF7BzqEd59t7o4ffM4fcF9c85Ja5hA=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 02:38:59 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::fa) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 02:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 02:38:59 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 21:38:29 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: enable RAS poison for VCN 2.6
Date: Wed, 2 Nov 2022 10:36:08 +0800
Message-ID: <20221102023608.17242-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221102023608.17242-1-tao.zhou1@amd.com>
References: <20221102023608.17242-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|DM6PR12MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 46730549-31a3-402a-ed0b-08dabc7b654b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SyIakQgCivMhHO3/QUIxt5Wp58GcdXhbtN8VhHgBF681BG1ygoO3gHUVhmPq2R/qP0OligL3+NTBpztmEgXMjms4DpaqEIBSOGj3ApbUvT14HT6HBm3lZbA124Ib/nv5Or9KjuikAawByHWSpfTwgtv7RpirnRaO+TQspmadD+B84idhXiRBOHOIgXPTbBnSks49PmOkA3nPXlLG0ZhH1CtQCJjeMoWhNaKQTsaHd0FkPNrqmFMflk47zsVGUcDeQkz8ygSWi90S8PxeaPyUXcAWnrD50QMiHUexqfho7J8YX2J12rl+yrPsPgrC5UrXq2m8WUtry6H7659BY+RN1G8wHXHQSjkBRWxpRQsxreDnD48VoCv0apU1xJtsK80SYIB2fi7Hru/DISyr6btducsolPshJbhSvnya4jzcGouQpBI/M0SeR3b9rauqnATv3R8wZyCRrIVOk35/xRJBtUH/1NKoanKO93QUgicLdeq8WfMnkAZlgNU73vzuA9MXkLmzAWTvttnLNWvBoe3KeskUsJO6gMkeYvyG5px+MCyZ+5H7L2RZ55abuDAzO7gdYUi7weSxSvqK/rB+9dzXdmAlxH5ridAaJ+YQk8s66a95MaN7eFt6WyIP84xJmpv2Io5q8krwYBgJBt/HRgb1i8kfrP7lAlFV0IAnwoM9/0TakZW0jVIoAe1fPBiHqFAC4qw3GCSnMLZmetGGZ2C2TOZiuUMEk9vnKxSC+lEZUB9IvqWpFhzjvChtPuxG3j/aXdjMuM6arjvWU6TPhgkXPB/4xAfzX5e/4Vwmk+QdCnnglUuU6onyuk2EQ8Y528D
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(40480700001)(70586007)(82740400003)(81166007)(2906002)(5660300002)(36860700001)(86362001)(356005)(83380400001)(47076005)(426003)(336012)(186003)(40460700003)(2616005)(1076003)(6666004)(26005)(110136005)(478600001)(316002)(54906003)(6636002)(8936002)(41300700001)(70206006)(8676002)(4326008)(82310400005)(7696005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 02:38:59.2351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46730549-31a3-402a-ed0b-08dabc7b654b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Configure related settings to enable it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 8a7006d62a87..43eefed30057 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -770,6 +770,33 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
 	}
 }
 
+static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
+				bool indirect)
+{
+	uint32_t tmp;
+
+	if (adev->ip_versions[UVD_HWIP][0] != IP_VERSION(2, 6, 0))
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
+	tmp = UVD_VCPU_INT_EN__RASCNTL_VCPU_VCODEC_EN_MASK;
+	WREG32_SOC15_DPG_MODE(inst_idx,
+			      SOC15_DPG_MODE_OFFSET(VCN, 0, regUVD_VCPU_INT_EN),
+			      tmp, 0, indirect);
+
+	tmp = UVD_SYS_INT_EN__RASCNTL_VCPU_VCODEC_EN_MASK;
+	WREG32_SOC15_DPG_MODE(inst_idx,
+			      SOC15_DPG_MODE_OFFSET(VCN, 0, regUVD_SYS_INT_EN),
+			      tmp, 0, indirect);
+}
+
 static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
@@ -849,6 +876,8 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
 
+	vcn_v2_6_enable_ras(adev, inst_idx, indirect);
+
 	/* unblock VCPU register access */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
-- 
2.35.1

