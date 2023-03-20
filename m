Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D49CC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AC410E61D;
	Mon, 20 Mar 2023 17:38:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAEC10E617
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqrGIhVgddLO3YmH27H2+JFuGgTXAuZ4A4uLaonFnRUF9qBIPoUTUCUAMCsEHlJn2QDUKbys/7gPuH4cXCz9zD/QVLLr/s9UdMUbLr9ZnaYSEygtzs1IjXauRHw/rBVR+3blnsslpIoBbUFbfDhp5rE3jMFxhsNrFZS+U/9I78jrNuTXJNxmVoUOkeXSMQ5eHElEZHxwtxFjenKRhgMIH34lcDnUas0z3nD1NMFGHX3Ysnll8/zcSkZ7Iew6nTqbJoVFkrBkpquC/XC2YWVYHzNdQ2lIzys5eft3hXL//cKW7uOhJ4FRg0QoEmXUZ0KEItdR4/kFzr1gMwg5bHdH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYWyFP+GbileEfGi/O+wailOb1YjlCjlZKaOVinltGo=;
 b=a3NHbQRoyKk1suA1RUEooFSPK5Zzq4prY+QHCMzvvfJJBNAUDnRBN53naSD9rbAMfpXndREscQN2OUN1zC2IkePrQ5YWxHR8N4U0zBnM1QIxwl8DGhd7zYFMuFd+Qet1G8VQzlrj0CTj1tFnACT21u5t9oQ9ia+XOzkmtKbyuL4NyN3BiV4wQgyuvkYMfqUs5+0SNFt3ri4HrhHMELAEOze2z/dpMeVjGYmPWR7KAMPX1n8gjA/yyXwqfMmgggCs+y0ag7iZRKsy0bai/xkNh+ITGV+3iMf5bNUjEvNAjfR30wNZi91QxuAnSGcy4GkQHNAbim0VdMC0rsaCevJJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYWyFP+GbileEfGi/O+wailOb1YjlCjlZKaOVinltGo=;
 b=CRaeqD/xrpPWy+ULdHE3e/S66I9rdBOrcvgAuvnTU9lf1qUqxgdFHpgnfHBfXnzCmp7CCGmeWNhVzDucSilfhNOTQ9S6mo5vlk0cl840UkPVSVVqGUyNb01wiAfLzFamS5dXSWNeCOe70CuV2hOOVoyDcs9Gj/YAXMTlmGCkB2o=
Received: from MW4PR04CA0316.namprd04.prod.outlook.com (2603:10b6:303:82::21)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:29 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::61) by MW4PR04CA0316.outlook.office365.com
 (2603:10b6:303:82::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amdgpu: add gfx shadow callback
Date: Mon, 20 Mar 2023 13:38:07 -0400
Message-ID: <20230320173810.250835-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7810002f-49bd-4fcb-925a-08db2969ed1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fn98l3CzhIVeQxe4J8hPIWHkZwr9YKgzmSAC0CIPFKW2Z3mKPDdwHhAVs+gYteJIqIPXAC+E8ZwPzAiIgOSdxEmxqOSNfKD9VYCoglVjYj6T61kps3zCki/YGi0muOpSRL1J1+IWa8D9TEh+r6NqseS9uuyxDjlMrO9bUnE2Z/TmwSxATsd4EXRcnTF8z8CXFlrsEG0fZ+SZi/eBMOOuyz/KGvw75kG8XIYLHFU/cbDKV1atNtXRk6VZmCANYi4qEXagzsdG5Op0V704Ba6NCSNLoXiYf/2u/B1/Q25qG28kUz+U0l9mfk+3ZUKsbmOnv32SUqlAlQBYodl5Mb4M4X2z8XZGgCsMi/K2A04qsTMd3tV+dLbNNk4ibUmwSU3ZLX2lAN1RXF8ZFXFiYvHpKzJTIR4GqoWNW8RqDR+FucFJHnVPuLxvRAqBOji2lnzjfaUy561t/vIPH/wVwuwnoeEh6+8dWhtolsPAa6mskAI9dEyxtO4+eLx0L+BhzIvmQBTMTMa+dHS2SdCQHjGewj64v2YHu2ExgkejeCpVtTNH5qTgGqlyohw1oCfQBNwGzsqYq+79KKrRTm2AD6vsBNLPnYN54gMSO5OB6uK3HjrsSwrokLnhbznJQSzxNeon0onywIiON94gmAc2oUTwWyft7/ufmqltf1V9aoSQ/pJJu6/7vk9Qx+38dfIdYSfv3ZZnh8FeoL3jZAp5hYnoNESR54NmwyeQICipOC4/JvE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(86362001)(426003)(83380400001)(47076005)(40480700001)(7696005)(316002)(8676002)(40460700003)(5660300002)(36756003)(70586007)(36860700001)(4326008)(6916009)(41300700001)(8936002)(70206006)(2906002)(478600001)(82310400005)(81166007)(82740400003)(336012)(6666004)(2616005)(356005)(26005)(186003)(1076003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:32.7741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7810002f-49bd-4fcb-925a-08db2969ed1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

