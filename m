Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA53DCCA473
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 18:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD9411223B;
	Fri,  3 Jun 2022 18:51:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11ED11222D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 18:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5v4g1vga/As3mvJM7wUrpqfe3aU6DK0qJN8hhK0hiAa5fy4LaO2UN8zbWwUoH6nSm/Tn0hWewmvibqivKc5FYyOK+VjKGFeXa936GdGeENrNw7k3hogn7b0ht3m2+XClIWV3kx+vaoXfixTVxzqVUtGn99tqr54+1OYj+unM8O82jynD+p50GSg9F9eCjTYNQGy00WRnVV2TqZ4/YU0mgND9dbbWIvql9K6ytQ0ik9WE24D1Mid5Vkkqakbdgdk/4HVIF7uiJshkSjE/sOEZRXqFhu+WxZVXDHQjLMkgromPYck2sK2GfYPMKH/VBUGJahITf/uyOXh2TU2SlEkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v4ySkUOVOVFS1Ur+bt2OWqeOKrirstv6FQnL61t2gw=;
 b=fIBNxNKpI7GYplWe9o53T3+Fi1o4d4eOIS+tMWWzqrvTpLupYj2ytbVdbzV9zCK0KIBmklinFSeFv9DEpSGTH/RDhJMJ91op5McsngjQUObeGbf7vALnWMYVIbNBIqYgcb2FIuJmaIeBzXGmrrMf6vqUsWXTdnwrSaeyRlli7fBkby+7dq79+ic2fOnUg8X8X4l6+qKrScFmtesebhk8aa8rcRuFV7AIKM0nkF55Dkb3ANtW5YvWn9BAeUw3osPgmH2GhIErG/p2yuU2VtKlTRZTDgKnOL+BQ2YxkJtxr57Tn2J2PsK73m5mOeF6iuWTKcubwE8M/MNaZY9Bt9oMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v4ySkUOVOVFS1Ur+bt2OWqeOKrirstv6FQnL61t2gw=;
 b=rCxuHoMdnKp1/vsnj8Gd/dLSaS8+MZBdM+GSqn+ECFPGQ+lJZkTTA/QfIUWvR6qkertKm08exAbScbhMGaKPes4DV03upu4bR2HVK7MSttAwPeqo5uix2v2cLQj26G0Ram7HGQkicuTL7UAofti7sLFUxyuxdG6MEO2x0yHgWPk=
Received: from BN0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:141::26)
 by DM6PR12MB4988.namprd12.prod.outlook.com (2603:10b6:5:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 18:51:05 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::f7) by BN0PR07CA0026.outlook.office365.com
 (2603:10b6:408:141::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 18:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 18:51:05 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 13:51:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] Revert "drm/amd/display: Drop unnecessary guard from DC
 resource"
Date: Fri, 3 Jun 2022 14:50:42 -0400
Message-ID: <20220603185042.3408844-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5589e8ce-298c-452a-9544-08da45920379
X-MS-TrafficTypeDiagnostic: DM6PR12MB4988:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4988B90B654E82007E18B8E098A19@DM6PR12MB4988.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLxAF4JvAaA8NqhvnAscnkDUTuEjPplQQzW603fZPrh38TYUXdFNfcL88VoyMONAqmZfart5Prv8RWipL3n/kU0QXt8xYx7V1ggTCytOeX6e/admeCkA1/yFrhCMP+4De29iwwEqpM3QX4bwS+E2vzMxChHocx1BXV9DXjK2FdAEHkT1zhS7mryMs/zhiwUXDizeWhfEf8yFtCSg3QNWvM+uyfuA0r1SVYonFq3F0q0IYW5tVGhhhgYIQbYB/OsxQMHooB+vgVNsOSiC4df0qzyFeLkVTmLUE0eZ/IrWA8rkzO5PdR52LirippXVZEn+D/3UeD3glrkej4yELiBADN9QQzLrMCE+A40Mx1cROlJ+zJHbTqopWYA4up8xxd35ffB7oz6ToDvm3oHkeBWqeGg4BJJCwXXpmgXzpZnxXbncj0gye9MY/+3XhAnOntBCzshWmiZtLt0x32QK9mdaf6e7Kgm+ym6N2K7GYCSxc9S4XcCUAygpNF18gR/Fo2ePZeyn3+wqxm7f+yVh80LfmBqiIl1MaAgNq3wHJu0hLD5QoGM9oF75VTSYKP6r5Qi6dG1+StTJFdHWpIPUrJs532PJKuBoVL6uwRW2rH8NuIewR5ALFw4LO5qGqR8eG+05+VYjcLk2ZYd0WWOZUDVA1f8+YZBRz0IvQ7C50RSuuzXTDdX0WL124JB8/loOqY+lxgoUbZnpHlqOXVzP96otMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(81166007)(36860700001)(8936002)(186003)(6666004)(36756003)(2616005)(40460700003)(356005)(8676002)(82310400005)(70586007)(70206006)(1076003)(4326008)(86362001)(508600001)(316002)(16526019)(5660300002)(26005)(7696005)(336012)(426003)(6916009)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 18:51:05.1562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5589e8ce-298c-452a-9544-08da45920379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4988
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

This reverts commit 78baa3c4dfff4375b109bc5e19663a2f7fad1190.

This commit introduced the below compilation error when using
allmodconfig:

error: implicit declaration of function ‘remove_hpo_dp_link_enc_from_ctx’; did you mean ‘add_hpo_dp_link_enc_to_ctx’? [-Werror=implicit-function-declaration]
 2010 |   remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |   add_hpo_dp_link_enc_to_ctx

Fixes: 78baa3c4dfff43 ("drm/amd/display: Drop unnecessary guard from DC resource")
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7357efb8b439..9bbdfcd6b3a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2002,6 +2002,7 @@ enum dc_status dc_remove_stream_from_ctx(
 	if (dc->res_pool->funcs->link_enc_unassign)
 		dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe->stream);
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (is_dp_128b_132b_signal(del_pipe)) {
 		update_hpo_dp_stream_engine_usage(
 			&new_ctx->res_ctx, dc->res_pool,
@@ -2009,6 +2010,7 @@ enum dc_status dc_remove_stream_from_ctx(
 			false);
 		remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
 	}
+#endif
 
 	if (del_pipe->stream_res.audio)
 		update_audio_usage(
-- 
2.25.1

