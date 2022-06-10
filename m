Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F89C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A7B113FAF;
	Fri, 10 Jun 2022 20:53:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3443113FB7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK10iGMa6XSjhkVGSBLtFSvAhScefOBfMuvS+Z6F7DwBGSsH0Nehrv2rj0Hw6MFoTASiHWFvNudOFMBCxFqaKhiyIQlXxgZGHn69EyAkKSCXaAzi+k19nOw4OU3wJUsWPOBsoN1e/dAV+1bJQqZzUmfaYQ0KJvh46VkGu+oDEtz7cBLegaTNA0k/M/Vb4rz4J1nhO+S7EvYYXH6vFDJOvgJ5V9Wb35kbfwnZ8t3G+p+yO+EuMKZMR4ox92SS9nKl5YUTDh2Ip5NlONdrEFB1Rq6xt9OoHnxowt0h6HjXhsrBPIIbj3ggjTODItCr+DIEyXZeuDewTCAhJdiuxGwxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwu+21LBLHOwsP8FOTjFHTXFZntruA5dzUg/B/TlX2w=;
 b=ZiCcOqGalWv2nx3qKiM4mk/KPn2DpY0n9kYsEm/g7sg1bhtEapEAdh7VGG+ik88/EAa7E5BVXxbR4+aYZt2LfMUb006Mcz5ZiD2uPbDZjfDyju+7PSWd7pWeJ5ZWQibW7RXaqvYMebO1coNZsHuoKj70GRvTqFkEiM0gIV2cQLg1QPQyiNHrzlgha0/QAikBw4TtvmiR+pBnZSQKFFEk4RC6RdDuKIwY+2kzIHW65RSHlc75S9DYzYqV3U7sGdsnqCCXAhkC1hxmlEi+wo8mqccQrNXgj8ZCd9ZVjJlIdOC8sX9DTEQg4nCFdS9A3CJYPquNE4TK6vW5Ucjtw+MoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwu+21LBLHOwsP8FOTjFHTXFZntruA5dzUg/B/TlX2w=;
 b=RHn22OnuQ7hqw6lsm37SEkuH93xVWqTQF63q9Z/kKgahGlhQDIT1XLlwmf4hhELWqN7mi6OE1QHu/9+jZOIEoVBSBk0WrQI7Vgqo9FYFyec0UVPe+GdDUYt5F+OM/F4nFu6X36z9xtw+hAKev+wOLZHbAsgg9FrNk2xJNvftJgs=
Received: from CO2PR04CA0122.namprd04.prod.outlook.com (2603:10b6:104:7::24)
 by SN1PR12MB2495.namprd12.prod.outlook.com (2603:10b6:802:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 20:53:01 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::c1) by CO2PR04CA0122.outlook.office365.com
 (2603:10b6:104:7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:01 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:52:58 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/23] drm/amd/display: fix build when CONFIG_DRM_AMD_DC_DCN
 is not defined
Date: Fri, 10 Jun 2022 16:52:23 -0400
Message-ID: <20220610205245.174802-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdd27e20-2cf6-4d8e-60ca-08da4b233519
X-MS-TrafficTypeDiagnostic: SN1PR12MB2495:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2495C575BF06BEA01B7A98C9F4A69@SN1PR12MB2495.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlQouvoL99uGGCICKT3abE0jZ+umvxnDzo84mXN3gCJceUP3l9j+D26zjw9P+No9nMCKkHvtuQdfGDvax6mgogJt5C4jUIDtChE+4Jfs1SCPfIIA55kp29kh0znLpDeATUHvKEp+omNaBG0jc+f5n1tfxL8VWSPBpSf9mQwKLwaQJ/c1wdsKR3/0AbEQkxhbLAshbGb+2zG9vbye+bhNZWi/kGW/+zaoGyt6MdI82jOuBJPh9FqauKwhE2QHnJJksZHkcAa0SSsAbun/UK+GwvT6mE+tzGRLb1Hjc+w7mpH4NhwPDukOVMmUkFfy9JzI3SkxQxns/xMeA+vPDj4omFzGPZi0WwMaZSRbsZ8d5S4hVYRglVv5xvZ1IdCrvB7vlm9VWta1mnmqdpwdlF/IccSEaT0+d0rwicbH8Y1CQxAlc3vUQnX+3SoTA5jyGPjZDdJ1gI5QkinBWHWaLJiHUmQworItKKWo7batjsonMbDqn8hSZ1Hi6o+72M4fyWLPVomU4qS0Fb4eP9kvJnw5Ys61TElO0abu0s9LLRBCEsentFHC5wMa5oc8M8iwH2HO3gWPrSZORBvX9RupxJXVpp2TL8DW0bph5yV8YlxEi4p0QGXjTUfxcnAV7s+zZI2G7LVEjqnIQ7M0qdthtaUh3Ncr4eHczuwStWKUZP+FIeqsTmV5Ua/pQM3SqkR8vZMLsYV2V0U9h0DCuzZ0D9WGNEMP0U9/OEjwtQUxVW6a8FarP23wvBSwQlhi678i7Opx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(70206006)(5660300002)(44832011)(82310400005)(2906002)(186003)(316002)(26005)(508600001)(8936002)(336012)(1076003)(81166007)(6916009)(54906003)(426003)(356005)(2616005)(8676002)(36860700001)(36756003)(16526019)(70586007)(40460700003)(47076005)(7696005)(86362001)(4326008)(6666004)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:01.1422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd27e20-2cf6-4d8e-60ca-08da4b233519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2495
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c: In function ‘dc_remove_stream_from_ctx’:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:2010:3: error: implicit declaration of function ‘remove_hpo_dp_link_enc_from_ctx’; did you mean ‘add_hpo_dp_link_enc_to_ctx’? [-Werror=implicit-function-declaration]
 2010 |   remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |   add_hpo_dp_link_enc_to_ctx

Fixes: b109b1468223 ("drm/amdgpu/display: Protect some functions with CONFIG_DRM_AMD_DC_DCN")
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7357efb8b439..21d217e84192 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2007,7 +2007,9 @@ enum dc_status dc_remove_stream_from_ctx(
 			&new_ctx->res_ctx, dc->res_pool,
 			del_pipe->stream_res.hpo_dp_stream_enc,
 			false);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 		remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
+#endif
 	}
 
 	if (del_pipe->stream_res.audio)
-- 
2.36.1

