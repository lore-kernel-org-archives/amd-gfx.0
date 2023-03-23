Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD86C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC0E10EB61;
	Thu, 23 Mar 2023 21:41:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EA510EB56
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YItmLqXcJXQ4iGCZI7zgwR+f6v6WH5buOwh307mEpwRr2WBQLzn02c7KusZkTFehPtQOKjeA4ouFaeSkON4PU2RFJTdG65bR7WMPDZrwJYHMjUz5Vz1QDko8Oaxh9K/0Q4I8mYIW72TrWQ/QyhPvEiXznI0ok/B1HAAOly+iStkqdcq9dh6shr/2qvR2/QOiED1rRkeao0vlIhrIy7DUixt3YefNudKusrpDb4DonX6g2NzPBLM872bw1kfiRskKxvHovvDKDSExcZEXYLQY0+Z90Inrm2eILCeUEbMw1rrfi14CjTUlmn8nDT4Ai5oir/EpClIhQsaqGdv1F6xLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+O4JRDPJdgeLUHaIFQ4tYPN3pKyI42nDVPMzNvoBTY=;
 b=UoDfAjJfU4/X0X0C5plfjgP6jAodhqNe0aB6b7VbJW0txJ+nbe0O1Gy1EOP8+U/9LbA1z8ScTfdRdUJzKzMx+nQq7EnmAqFRJ5yM72Sw4zh40X05QWZVtr6ZVYwc28d2GnCxAEt4dGS7xkEWgWpAoDd31UZi4WfQkfiZC8VQBIyO6uxSPiUaUfRLVPi+iASBoxxwXoHF96x2svgNpvxTcXk+FOWqQXz1clUatV/fiXwCaEiHZh5kbXQGpci5loXyl39xZCJlTgRa/c0ygUgt3vMQ+6qQ5lOTsuSACJqlYOg2bzCcjK1vyd/A3TsWv58W1iZf4E5dMnYSEaJfcTmqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+O4JRDPJdgeLUHaIFQ4tYPN3pKyI42nDVPMzNvoBTY=;
 b=Us+ycbdK7BxgRQ5X78ZHGrGpBPd+kM6yoaqnUcPfL0Kmk1C2RtVJqlYBlFuY0nKFPPr/sOjqkCjn3pETC0Y9K4LYXVuesat4rzgNRG52CFWdfY7vwBE9qp/lY4IgU76b5vh8Q4NT+nY7nvBu2G5W9ivX7ICT1GH2xmdaF1s7dt4=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:40:53 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::5d) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amdgpu: add gfx shadow callback
Date: Thu, 23 Mar 2023 17:40:29 -0400
Message-ID: <20230323214034.1169310-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 88370bfe-2ead-4f8b-52c9-08db2be7471d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSNa3WSAWdhlXDIFcQRP8KQR8pdXz8LbVnfazPLkB3UDlHBSyiso2JcK6Oy1/5BjqJIftHIerv1NFoPYeR5Ghjicnm5gYTxHGajgEet4k7DemYiAn6NE4XCmVma4uTkldeZxmIobOUez9TsFnp99Gl39Dua+mpvnlbaNNQLFHaw4ehm3eyLjSVOz+wi9Qx973td7EHCJ8gFyoH246xwZRwQlk90iw4U3cHfFgl6JzqZ14mMDtGm7LNSduX53mcdlvhpsxS0/Ra4WOebUxM9m4sOhf6jzqJiTnOiS+eNJBZMIq4eR3K0mcGJvr756vxxxixJpXLhfQt8gfi4tIjWClwb24xQVHAMTdmyscGJ+LqXQTMaDj84tUl0ZIX5TMF2U7TJN7iVMhQ6hq+1cpwFF5qliE/JZbyyVGUxLWh2GB32vhQ2NlwSrJjc2OG8YS2otdsC82Mf7Vdcwn50mCQeqVgJ8Fu2CuEA9wIHJGgiJJ3NpgED8wssBwDhv+pyNaWu8aIeTlOV5h1giCofOp6k+bA24Mr4pTBf664ebwQE0dyA4I28/Pt1ZpGsCpBCxn8zFMxxn5yHyVEiAiy5RHGCYc+O7w4ZRayobxfdk3HoE0Ve2R9rlMsQIU+pRw51ojmmqlm3m7Iw61CWft0gzTNC/mSrq0hYoqtfUKKDrA1XGT59V9BoY7wZxTz7u1ygANJiHBqfztvGA0M/LXukVNYCKZkLO8ES30jAvtlxIf3m3h5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(81166007)(47076005)(426003)(478600001)(1076003)(5660300002)(6666004)(186003)(16526019)(40480700001)(86362001)(26005)(36756003)(7696005)(2906002)(336012)(40460700003)(356005)(2616005)(82310400005)(8936002)(70206006)(70586007)(8676002)(316002)(6916009)(4326008)(83380400001)(36860700001)(41300700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:53.2819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88370bfe-2ead-4f8b-52c9-08db2be7471d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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
v3: drop GDS (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 4ad9e225d6e6..62047a541c21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -219,6 +219,13 @@ struct amdgpu_gfx_ras {
 						struct amdgpu_iv_entry *entry);
 };
 
+struct amdgpu_gfx_shadow_info {
+	u32 shadow_size;
+	u32 shadow_alignment;
+	u32 csa_size;
+	u32 csa_alignment;
+};
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
@@ -236,6 +243,8 @@ struct amdgpu_gfx_funcs {
 				 u32 queue, u32 vmid);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
+	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
+				   struct amdgpu_gfx_shadow_info *shadow_info);
 };
 
 struct sq_work {
@@ -372,6 +381,7 @@ struct amdgpu_gfx {
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
 #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
 #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
+#define amdgpu_gfx_get_gfx_shadow_info(adev, si) (adev)->gfx.funcs->get_gfx_shadow_info((adev), (si))
 
 /**
  * amdgpu_gfx_create_bitmask - create a bitmask
-- 
2.39.2

