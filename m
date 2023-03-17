Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA25C76195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDD210EF6E;
	Fri, 17 Mar 2023 17:18:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0CB10E3D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA0BezBotm2TrLSmtFjHETTm6Ap/EsdvsyB3nV/SJ7HxmCvSwdlEH8V3BO6NHXqjrBBJBLrIb92Zb+Mlxdfvh29oGkcoKU518tAX4qwEN751DDagTUO0Jr04FemUoStT78a98HswSCh4WmbxlOD87RtFQ1lz8v+NO9hCjTxskkV3Hd4DnEQAaSA7GvslJiyibSDx0L8dP2hRSD8tQdUB961E5HFO7DAXxcw/TwFQOiHl4+/LTkE1+UCaSe2GpSrNiL/6Rp/u5E03E9AejBZ0Cc0fAoC8s1EeIHqf4RY/z0gYXfnMku+aouzoYi7/y+jcIBwnJWD4L2wlFQaa5px8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYWyFP+GbileEfGi/O+wailOb1YjlCjlZKaOVinltGo=;
 b=iI0l+4FkZBivrUk5MNj/Lh7reBowMscw0KHZTyxCt4robRuoCDNS8WvK5V5FjfK+7hU66725icXrjN666N2wg6Hs5mybpCrl4pzxkFRaOva7mFcVQrFUMMrA0ftK68qrRHiy84alsnlZwWlmlaPtjgooq1OpZAhQmXKFamJGs8InU/V0N49bfhZB80QU7E9P1u2ZcZZLCyp/EVQOa/qpm/xG6Iy+cojJn2R32++t0PVTX25Ndu7JnanOBmf3SaEq5EwwYOxeVOUHloQiyt2HbZ64bb2Z4QRJt2DhvPHWwjMANmGF/qi4tG0cIT4LKL0QbvUfv3FlqxISomC0SmWFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYWyFP+GbileEfGi/O+wailOb1YjlCjlZKaOVinltGo=;
 b=eFn4xyTrMDzQ7TU8Mci3AHhWRLras1pMOCGdNUYN/m03XlVdxr79RNc1HY7/kDdmgV5XSEt3lbEetUg5/kwYhM9/MlaQERXinwhe/ji06/6SRw3K+O88EsvEECtexKRNtJ+hft6sDypufX878efCFtRQy2OLfKLEkT11jLFzeUE=
Received: from DM6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:5:80::46) by
 BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Fri, 17 Mar 2023 17:18:10 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::ab) by DM6PR08CA0033.outlook.office365.com
 (2603:10b6:5:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Fri, 17 Mar 2023 17:18:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10] drm/amdgpu: add gfx shadow callback
Date: Fri, 17 Mar 2023 13:17:45 -0400
Message-ID: <20230317171748.682691-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f536218-cabd-46f2-dcbb-08db270b9542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IfcbSy8PsdzPJx3VKj06bA3Yod0Ng0YYbFARKL8sO2pK9LtLigFnnOiCmv2Vij+ZyjEc0d48/h8RHZUP11w+Pa90ausQaI/8aogrmd0ieO9lUGsaS1ofFz449VUXwzo5jvl2/0JmLMf1bT0TgUVF/wtNHUG8vMZPR2vNL+M/dtNYFZv3dLt/uCOGQ6DpFQGxUJygbwwAXqLZsmZgNymljZcqR/ZCzi1xw4qdHSkOcCo/TfKdHTEL/xjGl3Dha7xcBl4AU47mXuPgt2k/JluJIo4d+S2/Ikn+ue+3W+zVRpmfpdOCjNPszp5dVQ7iKChUrEi/9ChbK6DLQBDq6KMkmEkKXPbQQUoY17McAJW7ulQPsSVjEK0Q7m+v7e0BaWSPzZ9Q6v71k0+WwGih5UFN3mX5dn4sOY86zzSUTEZqNQ27BBqC4j+zHVZ8x3sUAKrSRdWsigFnyv0AQSvnQgmT4dCPSlqtH3A+e1riVjq3t/n2knp1LPRNALGlP1Avwh3xftcxOvmClW9TMSLCy3zlAgtfQdYZM01cje0SNbkc/Vup2KFC1vq3E0WxwTY70iDRSmdRBx0fRsyu6kMgx1muAeFA3sKLDgHi+eDtOvniQmKqIaX/2/Rc9A0K2Z9N/aiYTk5PHVoxfsoJEdYRlohvSYDOUe/qAyKM5/JTa9ueMBJACpuCcE1CjFKDYu+VI5BYfggPixf0JCG6Ks0FFlrM3Kifrn4Ewrt2z8ZPJoVNFY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(70206006)(70586007)(8676002)(36860700001)(41300700001)(6916009)(4326008)(81166007)(82740400003)(2906002)(40460700003)(5660300002)(8936002)(6666004)(1076003)(26005)(336012)(47076005)(426003)(2616005)(86362001)(16526019)(36756003)(82310400005)(186003)(316002)(356005)(83380400001)(40480700001)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:10.4742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f536218-cabd-46f2-dcbb-08db270b9542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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

To provide IP specific shadow sizes.  UMDs will use
this to query the kernel driver for the size of the
shadow buffers.

v2: make callback return an int (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 4ad9e225d6e6..8826f1efc75f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -219,6 +219,15 @@ struct amdgpu_gfx_ras {
 						struct amdgpu_iv_entry *entry);
 };
 
+struct amdgpu_gfx_shadow_info {
+	u32 shadow_size;
+	u32 shadow_alignment;
+	u32 csa_size;
+	u32 csa_alignment;
+	u32 gds_size;
+	u32 gds_alignment;
+};
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
@@ -236,6 +245,8 @@ struct amdgpu_gfx_funcs {
 				 u32 queue, u32 vmid);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
+	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
+				   struct amdgpu_gfx_shadow_info *shadow_info);
 };
 
 struct sq_work {
@@ -372,6 +383,7 @@ struct amdgpu_gfx {
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
 #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
 #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
+#define amdgpu_gfx_get_gfx_shadow_info(adev, si) (adev)->gfx.funcs->get_gfx_shadow_info((adev), (si))
 
 /**
  * amdgpu_gfx_create_bitmask - create a bitmask
-- 
2.39.2

