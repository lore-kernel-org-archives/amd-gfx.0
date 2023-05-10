Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4124AC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3C310E53D;
	Wed, 10 May 2023 21:24:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B1110E531
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+lsjz4hzzKEeLXN4dazxrd4/uePFeTCLxq0vBKHFKAJkLHgBviPXBb8aRPWB3ZvP2hyvUKyHsTDuQAYBmeAoA5ST3Jd1dknt2LPlbn3SFG3k7cBI/tquSm9lJyX3Risg4U2mxJuJ/2ohV0G+gaC9/yppQuUC/8F7IiLkPZAkxNh2zW4n5UG2qiVJ5V6XwmISEMVUJnS59QqjhL8nFJFfM6ogjHGp/ZwE7wu4DWRPLlmzWz8h2+u4gw+MpVrdfVv3W6YT6H47NUVA+6zaBvGJIDSZSNdsa3RdLvwB/YaHeTty/Y3+Y5RIkGlRC32fIjuVg9KR9Vcn9B+XTIE27XkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kt0FBRXeHYzeQMJE3Idnj++XydfNqbH0bc3PRdk2ksg=;
 b=G/9lIGlJ6GWW9EEpY5KmzjbiBUngi0kh7vjX/boIQl+45b9HlOlTU048GLhR9utjZSlLUL2381du68Q6vUQp3op7ot6qMZTfXBH3NIOJxx5dmWmRe6l1bFEHZCD6gfoD7K3T5GR4zF1MZC2lgR7AptK9EDsgg9tuxRY3Hj2ESiqMoRC9KF1TOrx+TWM/R3QRmB6uSp6/uYLYO5JhE05/5tBxp5R0PvyaTiEvqNZKfdaYQoLVkEa+Qb52/QQ/qm7afM/mdbEqq/ygaUI69fBghhey2n+LslXI8vg+Az2XWgczTJqEE2DXQXpsbd+8teCTJUl/VCxhPengin8jztrhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kt0FBRXeHYzeQMJE3Idnj++XydfNqbH0bc3PRdk2ksg=;
 b=dtfLg9cvmvIw6fSC8DiqtxKn+VhaY+vEJZa5ZUcLUE4DedrXntHKn5+J4lGQgf+A6vHptGhmBOT492zwHND44IGdhBLnkk3Tit/FHo9de1+POS4t1tqyct7UGNms2z2ivrCRa0y/Cdm1kUgQTAQYUc5ALCJhGhhX8IEM3D/u5KY=
Received: from MW4PR03CA0067.namprd03.prod.outlook.com (2603:10b6:303:b6::12)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 21:23:53 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::cc) by MW4PR03CA0067.outlook.office365.com
 (2603:10b6:303:b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/29] drm/amdgpu: add partition schedule for GC(9, 4, 3)
Date: Wed, 10 May 2023 17:23:11 -0400
Message-ID: <20230510212333.2071373-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c420d5f-5b1e-4a75-4fa5-08db519cdac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/IRemuhSTMLk3PnZb5agQ1ItrPyIyZgbg6Vp1dadrWw1XrxWlKyVBOmTF21trRcUUh0Acap4XmqqLJcJPB13E7J4JlT5Ov1Unv/RnCetfKfjw8ASWz1A63YECuftRQbFi6zjuqPv9fNYGtcQG73lILm3khx+v3cQ/fH8LEMB4kiIEetV5MKlAr5t7Zf5h6aULSoq2uZaYpUXsysMxeErhp8ZtuED+2mXffE+jAWnrMKhO0gOi5zG7r8mmBiNjJPk4O+G0rBk6nXET5jT0PXmzx8ipBZMGj04qUaQFKZcSn7HSNZdihxveWCp2iU0KV9pzyFathWiKtUtSW1PCSeh9MKKTeLBbJmX7bbRJSxN7429ivIQn+MdPkjD8UvyodH3cvCuw7mQO88S1y/buS+PGQh7jvzoCNX7F4wB14MdzbznGnsyk+uyfbulsiS5/mdiWIXqxoR3pjDHjBEQ7EaGyih1RUJdjCNeSRcfA2EWz+VrDSa0AR2DVca1DXSqNhrbaDuCP13NjQ9oCf3k5sjqN/7HUHACXpyWzjJgYagB3T+k26z1q+APP+d0fyRAuIOmX1Ivkg3V07sX8MLDq+OghFojvUfGE8H4AJZeCxf9lS2fKQMAlHnguo52X+wfrgQOb0smaGcu5hQJAd29FZnPYLG0Q1N87LcpvZBJ/PZ7v+F6ifKfXC+GfFGE+a2ryJ+c4vctIss8blydKGMheQA2RsXpJx+wZuwxyWCV6LaeJE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(426003)(336012)(83380400001)(2616005)(16526019)(186003)(36756003)(86362001)(82310400005)(40480700001)(356005)(82740400003)(81166007)(2906002)(36860700001)(47076005)(7696005)(316002)(8936002)(6666004)(8676002)(41300700001)(54906003)(5660300002)(4326008)(70206006)(6916009)(478600001)(70586007)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:52.8344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c420d5f-5b1e-4a75-4fa5-08db519cdac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
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

Implement partition schedule for GC(9, 4, 3).

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 073ae95e6dd6..4ca932a62ce6 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -166,6 +166,46 @@ static int aqua_vanjaram_update_partition_sched_list(struct amdgpu_device *adev)
 	return aqua_vanjaram_xcp_sched_list_update(adev);
 }
 
+int aqua_vanjaram_select_scheds(
+		struct amdgpu_device *adev,
+		u32 hw_ip,
+		u32 hw_prio,
+		struct amdgpu_fpriv *fpriv,
+		unsigned int *num_scheds,
+		struct drm_gpu_scheduler ***scheds)
+{
+	u32 sel_xcp_id;
+	int i;
+
+	if (fpriv->xcp_id == ~0) {
+		u32 least_ref_cnt = ~0;
+
+		fpriv->xcp_id = 0;
+		for (i = 0; i < adev->xcp_mgr->num_xcps; i++) {
+			u32 total_ref_cnt;
+
+			total_ref_cnt = atomic_read(&adev->xcp_mgr->xcp[i].ref_cnt);
+			if (total_ref_cnt < least_ref_cnt) {
+				fpriv->xcp_id = i;
+				least_ref_cnt = total_ref_cnt;
+			}
+		}
+	}
+	sel_xcp_id = fpriv->xcp_id;
+
+	if (adev->xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds) {
+		*num_scheds = adev->xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds;
+		*scheds = adev->xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].sched;
+		atomic_inc(&adev->xcp_mgr->xcp[sel_xcp_id].ref_cnt);
+		DRM_DEBUG("Selected partition #%d", sel_xcp_id);
+	} else {
+		DRM_ERROR("Failed to schedule partition #%d.", sel_xcp_id);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 static int8_t aqua_vanjaram_logical_to_dev_inst(struct amdgpu_device *adev,
 					 enum amd_hw_ip_block_type block,
 					 int8_t inst)
@@ -548,6 +588,7 @@ struct amdgpu_xcp_mgr_funcs aqua_vanjaram_xcp_funcs = {
 	.query_partition_mode = &aqua_vanjaram_query_partition_mode,
 	.get_ip_details = &aqua_vanjaram_get_xcp_ip_details,
 	.get_xcp_mem_id = &aqua_vanjaram_get_xcp_mem_id,
+	.select_scheds = &aqua_vanjaram_select_scheds,
 	.update_partition_sched_list = &aqua_vanjaram_update_partition_sched_list
 };
 
-- 
2.40.1

