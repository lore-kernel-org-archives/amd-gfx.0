Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A366FC7EE25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D9510E53C;
	Wed, 10 May 2023 21:24:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1019B10E531
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVXX37yCnRE/hckyySCTd6ISZIATDpc3BRp/FPsF/K2jMencFlKMd+J4yuur+OlshOL7ICDL2aeO6Ho4yWPIZpf9TYpKp1WBrpzL0pESXMdauZp+HTknO6dTg/0yogcGu/p4na/mndxMZmYJpMXvY5OpiwFMGN5XjZ2Z2XMsC/Dp0qBU//w6t8Vbu9RJCf1PbVtZLB93QNLBAZsOC+YD2kpGlKdZigqV0gcoo9/hDMgVQZkCg1DQH61K3P9CzRK5yeBayfKkEt3NcBLu9O6XGy7nShUvXMsuDy55sG80VxNPEpBy1YUfEnjwVXRCoFJhC+YD6rrQ5RAfzw45MaJRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kID54BFuKrRVjdRtuNV25e6TMeV4hE0L1s1SQk3mOKQ=;
 b=L1J+/NVPP4N1Y0YajpDgPTk+W5ZQ3iqsV6S3VXUqGpya0tTtxPf0b5of/r8Gufq8WtAkf0je53PDAXnl6Tmzgtg1a1io1jgrlCzzgKUB6K3MHtgTWnQYpvpN4mXH7+659ktyDLnZ+nydqTf2rN7vn4eCIwt5Yt1z35nTNsTFOJ0fUvHFNf8q5deUY8UmmxUysocT5TZDxpfIgQKxckL0oHdt5VdWVW4OP27LkmZU1frXG09JCLjopQ0/J+8ESpVmpyYaigAkOjHbm7ykYMt+Key748HWydRkbBzIriOGfoM9Mk5D7vUWDQU96//5/cIM6+wsQCJn85A+amUvPEexsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kID54BFuKrRVjdRtuNV25e6TMeV4hE0L1s1SQk3mOKQ=;
 b=db6dVsizcZDnl9mdfz2FtQq03cPF5jyqGe6jkSGwVe0MwOllIGLUlv70JwcV/lwBzX7D/faLEbA/2DQ/cjQ2JMr+GsONgltbeFlfgywa8dyFgBOh3UXBGpKPrDn/VKQ/Vg5FLqb/kurvOjqFLe1akPRMVAUeb15RTpr0hBWJCVE=
Received: from MW4PR03CA0069.namprd03.prod.outlook.com (2603:10b6:303:b6::14)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 21:23:53 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::ef) by MW4PR03CA0069.outlook.office365.com
 (2603:10b6:303:b6::14) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/29] drm/amdgpu: run partition schedule if it is supported
Date: Wed, 10 May 2023 17:23:12 -0400
Message-ID: <20230510212333.2071373-8-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: c36ccce5-344a-4a1b-e809-08db519cdb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wib3xYGlxV8nhmMamoQ9JzxzWbQGPwgz99gTthtu9qYxH98N/CN3zZM84t3y4A93tl/5QLQmjye62ZC3hBgKxZcJ45OGgowad0ldmC7phHAyTf/0o/kB4IvIB7Nf8AO9R8BffII3+Jw6HnrJirp4hRbSWYhqX0SnyGTrgdUd1CwY/9oJdiW77mej5nS+hlZcsVyBitJdOwJfxuSkZPIbS33Rnuqlbqt8mgEmL/GfQ3eFizl6yRmp1eIjOS19uqQ7lL9gqvDsrrJq9bgXyisG68KF4sNfaBOAf54mPbPtVDKj96jio4GDKkNIH93DO3BIi4MrAlSaTGW6Al3lm45O8oEferY5PcaNvd8hCx2sMilU73FaVFEWTd6t9aPvy3jp5dxmAq/xWAWuc8KGzUS8sUtPUMzM7hzkJIGJuCXsYw5w2e1Jm8nLm03KmP8wCZe4Cu8+dZiv0i9ZVmGvDlbG3ErzA1s7m7EVaKyEhcs/pzIQfVAi7LEGa/a9HY8vkdtU6aNQMN7x3YCulun6ZbwwB08YdjMbuK2/cokikQUk5JUogXb2c2K+qHSei3zyVwkWv5NUZZ7jZlOwnkZTd5wh2von8USz13qD5K9pch6U6eYwT7Ob5eww1LGn0Ec18F7eBDenmU2gHbejrlYfwrvjEPdXzkm718mcT581UvOGvqi3Xms9PwnMV5SsvkYqwhWKdWJ+X6bayjza/6n790nTQLwbZTeCcl1PNDIJVq2PPwGqhWRs3OsIs3y/SP+arKt7tgeq7KYTbBGMYBBQBkcllA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(8676002)(8936002)(41300700001)(86362001)(70206006)(70586007)(2906002)(6916009)(316002)(4326008)(82740400003)(54906003)(478600001)(82310400005)(81166007)(6666004)(7696005)(40460700003)(356005)(426003)(2616005)(47076005)(16526019)(186003)(1076003)(26005)(336012)(40480700001)(36756003)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:53.4281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36ccce5-344a-4a1b-e809-08db519cdb1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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

Run partition schedule if it is supported during ctx init entity.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 06d68a08251a..e579bb054a58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -222,8 +222,19 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
 
 	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
-	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
-	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
+
+	if (!(adev)->xcp_mgr) {
+		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
+		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
+	} else {
+		struct amdgpu_fpriv *fpriv;
+
+		fpriv = container_of(ctx->ctx_mgr, struct amdgpu_fpriv, ctx_mgr);
+		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
+						&num_scheds, &scheds);
+		if (r)
+			goto cleanup_entity;
+	}
 
 	/* disable load balance if the hw engine retains context among dependent jobs */
 	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
-- 
2.40.1

