Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8144C7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2937D10E52F;
	Wed, 10 May 2023 21:23:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3625310E52F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdhpvvFkGSz5gomjZPnuLVqy81H9W44LF7wDn9h83vtEe+ydNBIoz5O9YqtaIXRrk8dLAyPHe6/0lRBpsSSN+aTEbAmdmkNf7dlHuGy8kpy0XrDbLZVB6WfjnrCYtBYXUlSLpi4CNBYB3hMzvUXpSxyN5W6fT7Qme/NtD/o/Ywr4vrF5g6d/kr45t5xT/Z/6LRgeT9liJQCQRQ72dK00DKendrIiCnKap8nlYr0dG1H69kH+66ZsSEVimGvQ0OtdheNnMbdomNeMca9mZlvIStrgzSCVIWls2EI3Yli0xjFhFsMQaUUmgFC9S22Ka/3OPdQ4Vi7wmHcRSLy+9QgViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjVUKXwFnwIZ2Am+6htM4PsLSjjJoI+9xyBySfVKYf8=;
 b=cq1RarJ5ioeMaiKPkXjjnvlYkMqs6jms57l3qxGfTyIGZklrmGCT0d/v/zJuVIfq+WxYP7tfUkhmDx1MdlIpWOV3p3ypeyf4BV33p6wVksSDY1XkHu3uOrsxhRauEBVIz1+roH5oOnzggbf+de1lo/LuAjeheBVGAbGjao2rrbL10d+eBnI6e6++Ajhe2pUTGjaiU/OlrKbAXzMEtBoABT2sqSyREtXfuVQjwjrF35rKtzyOnvsma9tVizU2GGrV1m3v6/sEhWGmf9cJHEo2UhE64CTZLZCVMqw+jpJM1IApt/HVk3r4InCf+dxfclOgk1oUs2Fbki568K2bliN5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjVUKXwFnwIZ2Am+6htM4PsLSjjJoI+9xyBySfVKYf8=;
 b=OXN+rh2Mifm1alzkxHYyOQa9GB2x45BJg4jsunZP6L+6CIOH0lsvkRDGpbxnEgv3Jhjpl2LThzyfon5rWvuj2gkcneKnUie5DJRy66GLZn2NpiXg//aQIEO4dL4P/5vB4V74tGy9iAQJXxyoT/5dhONDAzHYMwmm5Th7JFHgN+M=
Received: from MW4PR03CA0077.namprd03.prod.outlook.com (2603:10b6:303:b6::22)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:23:51 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::bb) by MW4PR03CA0077.outlook.office365.com
 (2603:10b6:303:b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/29] drm/amdgpu: update header to support partition
 scheduling
Date: Wed, 10 May 2023 17:23:08 -0400
Message-ID: <20230510212333.2071373-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: df182d79-820a-4e9b-8a0b-08db519cd973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pd9/rsJ56arxy/9pBsUGLDHFlFUB9ODu6sMnSm0j4BxUaFTwRGBZXg9GmsBB/oaIfYcwaQPx4nK1ipc2UkbGbEOcxl9/dSn6wO1sPa6HgTtq3SgbYrm6pXHqcbkhEUTLlRS3Z9jHILxZ1MDVug0/r/Zr6mWqBU44Dmi+wqOutStAyFaL/zYVUsgEB1xQ06caP0PEUNE/UJVguYichNWkIG3IvUlA4lTD4tEm65kmqIhOMiF7YASRmAXMBgry24gZsIeJZWikpdbZsob8UUIRKCzGyR7LRimPeNTwUQM6GL3/txB6w6RkUGvU2s8TRujo1SqvqNxRrILGvcd8bSH1OIm/Ct4P4IAe4gp/GU3DZMIAwDaEPqVKed4Rhp9jvgEuGAdmHEQmKU5JbcNU7ZKcIKz67nNaivwu8C7TOcBbGrusacBOvDHaACqoZwY2OKQxDwa0ih/ObItUrZMSRQtbd+6sQV0jGgEK/8RBAPyyEmPl2WWef3vGju1CihuDXZYjgu1otzokRrOdMZGQDAvS71vFuPSKm6fn/fykXeVfsposu/meRMa9nMRqA4suaiup1ePaPg6JRFUHJY42Z01EPtDV/AdlKeIcuDmtAGpqQPwF3FpAIrC0NZSuig2Mul5LGVsSF/GsdQyllDUuU7kPXljsEcCtkGe2URF6rLge6qyLlbJsKAkdqCPDfAjTHP0MHJ7zyRDmi/bmNnbRPGPYP3si0bxtgt4bhXJfmT9q6+I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(316002)(4326008)(70206006)(82740400003)(6916009)(356005)(70586007)(40480700001)(336012)(82310400005)(426003)(83380400001)(8936002)(47076005)(54906003)(81166007)(26005)(36860700001)(86362001)(41300700001)(1076003)(8676002)(5660300002)(478600001)(16526019)(36756003)(2616005)(6666004)(2906002)(15650500001)(40460700003)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:50.6470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df182d79-820a-4e9b-8a0b-08db519cd973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Update header to support partition scheduling.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index ad60520f952c..cca06d38b03d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -70,7 +70,9 @@ struct amdgpu_xcp {
 	uint8_t id;
 	uint8_t mem_id;
 	bool valid;
+	atomic_t	ref_cnt;
 	struct drm_device *ddev;
+	struct amdgpu_sched	gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
 };
 
 struct amdgpu_xcp_mgr {
@@ -97,6 +99,10 @@ struct amdgpu_xcp_mgr_funcs {
 	int (*suspend)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 	int (*prepare_resume)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 	int (*resume)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
+	int (*select_scheds)(struct amdgpu_device *adev,
+				  u32 hw_ip, u32 hw_prio, struct amdgpu_fpriv *fpriv,
+				  unsigned int *num_scheds, struct drm_gpu_scheduler ***scheds);
+	int (*update_partition_sched_list)(struct amdgpu_device *adev);
 };
 
 int amdgpu_xcp_prepare_suspend(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
@@ -123,6 +129,15 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 			   struct amdgpu_fpriv *fpriv,
 			   struct drm_file *file_priv);
 
+#define amdgpu_xcp_select_scheds(adev, e, c, d, x, y) \
+	((adev)->xcp_mgr && (adev)->xcp_mgr->funcs && \
+	(adev)->xcp_mgr->funcs->select_scheds ? \
+	(adev)->xcp_mgr->funcs->select_scheds((adev), (e), (c), (d), (x), (y)) : -ENOENT)
+#define amdgpu_xcp_update_partition_sched_list(adev) \
+	((adev)->xcp_mgr && (adev)->xcp_mgr->funcs && \
+	(adev)->xcp_mgr->funcs->update_partition_sched_list ? \
+	(adev)->xcp_mgr->funcs->update_partition_sched_list(adev) : 0)
+
 static inline int amdgpu_xcp_get_num_xcp(struct amdgpu_xcp_mgr *xcp_mgr)
 {
 	if (!xcp_mgr)
-- 
2.40.1

