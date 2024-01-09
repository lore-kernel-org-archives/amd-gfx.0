Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5744EC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 10:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E456810E407;
	Tue,  9 Jan 2024 10:14:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE5510E407
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 10:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BppRhz3hSpB3KleSorzhVlpGbkVwhO5ZxXNShfy/FTx6ydjWdLfZ/dMwt6S0P7ZbtFwSI7eBEcfqAdHFPJZ7uqN6oeU5J0IZfDfvwfP4iGGi7gzT5io7GgchqauKSimCqqsqRk9MYjn3Ot+S6WZI6CnKo/sReQskzJGJHca9FM4o9/1CKTZNoE8FPgZh3qYxtBKnXR9kEKxZ1xbEjb3xXml8DC2fb5V2KpG+u4b954LnfOc+j1qx4Jk6YDAD/io08X5hLbIVGBgxPAvOvoBXWS/RgQoGCpQIW98HFh98v1eCjHUd1k8wqi8QdGvV2ZG+W69XLyZuYTpvS/7BOcl6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqjFyBlS79tS/yDmIQ/eqMtzWYx0wroKt2hEafN6VoU=;
 b=hnLPOIMjyDnG23shQD3p6WAuaw3C9/EZRII2M/urZ4PPZ6mnkY3IyKBRD/0heugW/UKPI/mg7s1iDGG7TvFGzJpfmZIbVGXVLEqYQNMqzgby7LM48QzKqkae87+bE+fpZc1PNFizEbOF1v+lGGde91liiOEjYe99oF5GphWRandPw+8CuFMZ9eSCccDQnQLodXIY3bghpBlIkaZbPCHdzqZ7YAzLtsCiKFrk9YENLwErz4/FEM2bPWqt6g3N3sxbEpA/imSIcW80u7pgapeyUh8eezchj39KPJUJqYaK1iUoLK2Uh/cKzT/sVx5nKiA6hYPd8hz/xFWISRHwqAiBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqjFyBlS79tS/yDmIQ/eqMtzWYx0wroKt2hEafN6VoU=;
 b=3GGaVuR5Use/HdMuxWtef6HswlxDsmFzzdz/DUURGmMOtR6mIHzCIHXrpytK6CTjWz72yQItAPR1dl2jl4iGbxagARjabXPBdIxfyH1u3Zc8+W1v4u5CiUh+nep0ZgDtqPZhiUIvX/a21h9zDTv06JsS3THbDHBMDwinhQTMfK4=
Received: from CY5PR15CA0205.namprd15.prod.outlook.com (2603:10b6:930:82::23)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 10:14:33 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::a3) by CY5PR15CA0205.outlook.office365.com
 (2603:10b6:930:82::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 10:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 10:14:33 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 04:14:31 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add debug flag to change fw bo placement for
 frontdoor loading
Date: Tue, 9 Jan 2024 18:13:58 +0800
Message-ID: <20240109101359.28362-2-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240109101359.28362-1-le.ma@amd.com>
References: <20240109101359.28362-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 909d116e-c1ad-471d-1505-08dc10fbc6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZ0MGMnHzeYEe7U/kN8JJB8adnBRQLwnJCxas/+HYcxXbr0JHEmaJNLsh0R1QqwoGMRc07e3Szw8J/kKzPprBUipwFRY/L58xYEnNMUNWFK7ONOiAREX2z+W0+zHSurZvERsJolsPXurKJw3MdBEuMVMvkSyqReDDTachjROidgp2rx0nNOtwumkoEsEnHBvGQRIOYL8HXBIZLbwXFgT45uu+2L/wXadEdjKaSILjRlHdxXBwfwQN+sTVrHdfWKyXVRO3UQaC1kKCHQ+rRqfUE4O1A9/sQhjxQSIW6vrmzzF7aWvk0o6iQb55cNpG7SOyweAbz91d/i6/dqe/eEQ+QJzk4fmd29jFhBIKn6M/PpcycaCpsBrFeKPnvilNv9ALDQmN8pIb0/KtA/kXESveREGSv8CP84joapwz5vEoGrS679cCIfKddkOhy7eiaDajhWUE1BY9P8eCAWi9KI5opTw6VCPYoy5yd7F6zKwUFVlDbv3BPlPKI4S+dr20dfahNQH0iLtEYLI2IjWbWZPb41uWxmWiH8CNdpnwGdhLX7M9yNLSKZslf1skHi3IBW7ASFm0WQU8hPh6CEu1Xr/nCwOXtohSRZFkEqiOKrWJDw2mzwA2bWYJRsEH0jacm+7QnVEhR69ugw5PwOYGpoRfxDNFiBVQo0mIQFnze4rvbNYMAqvAk/Hy0sB9YKIsFaMCJM7T2/A6k/90H2fgSg3fRDBvX0KcDZs+0mY4Ocp2ehZhvC72lXPpP51JM66BfWb/V3i46TKWdiZmaGLAuv+3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(41300700001)(81166007)(7696005)(2906002)(5660300002)(82740400003)(54906003)(44832011)(36756003)(40460700003)(36860700001)(86362001)(356005)(6916009)(40480700001)(6666004)(316002)(8676002)(8936002)(4326008)(70586007)(70206006)(47076005)(83380400001)(336012)(1076003)(16526019)(478600001)(26005)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 10:14:33.6470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 909d116e-c1ad-471d-1505-08dc10fbc6c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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
Cc: Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

se debug_mask=0x8 param to help isolating data path issues
on new systems in early phase.

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 616b6c911767..c740825cf5dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1144,6 +1144,7 @@ struct amdgpu_device {
 	bool                            debug_vm;
 	bool                            debug_largebar;
 	bool                            debug_disable_soft_recovery;
+	bool                            debug_change_fw_placement;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 880137774b4e..3e0e39a1b5ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -128,6 +128,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_VM = BIT(0),
 	AMDGPU_DEBUG_LARGEBAR = BIT(1),
 	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
+	AMDGPU_DEBUG_CHANGE_FW_PLACEMENT = BIT(3),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2117,6 +2118,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: soft reset for GPU recovery disabled\n");
 		adev->debug_disable_soft_recovery = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_CHANGE_FW_PLACEMENT) {
+		pr_info("debug: place fw in vram for frontdoor loading\n");
+		adev->debug_change_fw_placement = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51bfe3757c89..a9f2d33fa54b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -467,7 +467,7 @@ static int psp_sw_init(void *handle)
 	}
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-				      amdgpu_sriov_vf(adev) ?
+				      (amdgpu_sriov_vf(adev) || adev->debug_change_fw_placement) ?
 				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 				      &psp->fw_pri_bo,
 				      &psp->fw_pri_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 0efb2568cb65..8d36a7c1c789 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1062,7 +1062,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 {
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
 		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
-			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
+			(amdgpu_sriov_vf(adev) || adev->debug_change_fw_placement) ?
+			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 			&adev->firmware.fw_buf,
 			&adev->firmware.fw_buf_mc,
 			&adev->firmware.fw_buf_ptr);
-- 
2.38.1

