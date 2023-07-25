Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D606C05051
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 18:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8119610E16B;
	Tue, 25 Jul 2023 18:16:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311B310E16B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 18:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUJkWxbPCxiJT6wBo2SbYr8reVYt1PFSa/XJaupShuyOBtfHnQh2l2lxiNydvIY4vwaP5kRQrCnG894+9XMwiDtjCzv0AtUYwaRIHopPrKAXbTYLuo09HpagPfy9vNvmeaNEJ3eQo2N72ls/EQmqaukEYz36egGP6Q5FuYAN03oF+nulBtoFlKSqXP1/swve3h47g9XTWx0rgMYYmw7jDnSLUBtu9AK64ljeyIsUWCX7U9UBDVxAMR+VDgGCCGbig17Oujy+qvr4g10HfWPOvqSE7W4+ESa3Zdgj8/EdiuazJfOPYu/nW5kHnlxah0gHW1ADHIhBACfuYJ0V/vc/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f66ZGEVc3NDpDWB106wEvmOFoH+hiHVypPELw7YFgK8=;
 b=gJBtoijZ0/5O6IUgDQxzShzFzaKg0E5PM0ffoF7yHzuRAHBzxeMbpJS02wji3wg0ShbCSsTRJL9R8k86t/m2jQK3Zt1sM0FW23ar48V24/5tX0fHkQ6POea4suZZtuzIpDe82b5do3G94CmcFylLBmItHCDpud6e0S8897a4emNwfODMv2I8Mms/c5S2JFo0p5S2sBV7SWeScTsecg4wkSQiLzvef/DnneQu1K+cLJPcPan0pDYRv4m17QSEjCQdD28dy2p5GKOglerh837rIdVcCOA/JYQEQBxvbn/xgBOzPyL7WInN9eIe0rvwSDPoklpyEX5C6LaJPLSNgypCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f66ZGEVc3NDpDWB106wEvmOFoH+hiHVypPELw7YFgK8=;
 b=B5r99XYnFeewEL+XCJS7YL+SObcAUSH39it1kgxUrSX9fbGatDkwo7PgucbNKCpyyZzN2dtvjNksf0UwQyA99gfEl4A3miCvxDVH81KRQWgp+SDEmYUqTMqiJ8PfjL9ryTnoreh45rmaqot94rz10BAvFSRm/MG5g+2UarAZjh0=
Received: from BN6PR17CA0037.namprd17.prod.outlook.com (2603:10b6:405:75::26)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4cc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 18:16:23 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::93) by BN6PR17CA0037.outlook.office365.com
 (2603:10b6:405:75::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 18:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 18:16:22 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 13:16:21 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable trap of each kfd vmid for gfx v9.4.3
Date: Tue, 25 Jul 2023 14:15:50 -0400
Message-ID: <20230725181550.254371-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: ece079b6-3eba-4c8f-2c38-08db8d3b409d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdz/WfN5FFt4JlvA3R2K1ZdjJGCzlJ68D5agB2+Me8VyNRkUfnrsLl+vxVCRHHPR0JGWwpqCHwEee4nSOanG5hoIFr3iJ6If7Abk0zaGv5pe5ZV9TpCT8Y/YcRJqfGF95p7ycbXV99stqU4y/X/2UqK0nlDz2slu4goMFyKXeVVzDYzadFi19aDoKubxxhH0GDyUDg5THL/tXFusBb8zannQRmIB6vS9jMX2NQkiMTVwSHFbK10h5+f5M3F6W0jQAfAYndluGNiZA8hkf9kT1Ny2zMrO+R/WdG3Xnz/xMVkwXmRxprpZ1AdDJvuGdBhf1XgIHg2lcNujvDQ+syGutQjvXUnmxXoGToLfcWVR8w3d7MyuJGhuSyWXsX7HGCdNPYL2LAKwI96Cqdq5+PwZ0+wmzey8DUTzWeyA/V/iy9v+Hslzo8+ZE9dwlOaq/8p7FvFRolGWH6bxTwLdKUvbzYDixWDFjmakm6NG1u3QGR3WSt3TXiZRehrGNjZa9lEaofhmqPjjbUz8fdSmkjz0FIi9/oEYlWqAN7HMRqWTfR8P/zs6NN2OEaMTATZAiw0tBoOiGiEgRRcM5WOyM5QUXAIiWMMe5dIMHx7DsAinTiLxlQnkHtxfRKO4kOQ9Hd7jAJw6F1VYq/zGGNTtxY46u5cpOIKAYBWgbYkpHEVifFMhM0RAVHotr2Q8AfERcALhm1nCHCeUDLhpb52c3J+uEPXEjFKBnu4nwz6CSHl3Qev52hBD0FRrs4tXbLyo2CNXSpgpYH04BZvnQk+lh9oKUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(86362001)(82740400003)(40480700001)(356005)(40460700003)(81166007)(4326008)(41300700001)(478600001)(70206006)(316002)(70586007)(16526019)(6916009)(54906003)(5660300002)(8936002)(8676002)(6666004)(2906002)(7696005)(26005)(336012)(1076003)(186003)(83380400001)(426003)(36860700001)(36756003)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 18:16:22.9217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ece079b6-3eba-4c8f-2c38-08db8d3b409d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To setup ttmp on as default for gfx v9.4.3 in IP hw init.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 86a84a0970f0..9a90fd187909 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -898,6 +898,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	int i;
 	uint32_t sh_mem_config;
 	uint32_t sh_mem_bases;
+	uint32_t data;
 
 	/*
 	 * Configure apertures:
@@ -917,6 +918,11 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
 		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_BASES, sh_mem_bases);
+
+		/* Enable trap for each kfd vmid. */
+		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regSPI_GDBG_PER_VMID_CNTL);
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSPI_GDBG_PER_VMID_CNTL, data);
 	}
 	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 	mutex_unlock(&adev->srbm_mutex);
-- 
2.34.1

