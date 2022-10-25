Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B95FC38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 07:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 844FD10E244;
	Tue, 25 Oct 2022 07:56:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B22E10E226
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 07:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDb4DU3cTAJa06Nj3sSOcPbyByOcAHT4nOsLGNmZtazURyrcW63j/KbRQ4SeyM9ced5dqlHOfIbqn8skE/sfvnFFdM7PABsGNRJvRuxIpX/3/S7zcSEGLsSS4yMpDdf7+1V8qAplqePWnMi8tQmTzIGyFeFXhFGsVaXQDXPT3Wu7NrP7uf/ATAIa1TgN4eKenLmydIvdPHcagUVPtJyLwUgYDcEQxHJ0cU3hX39MV05S5uWz2uD1ylHiLwYw8499VNpLT4BBRAtNfbFewGqqkHziNha/2tRYCpB09WZqzoEh5GIQhCp5jt4rB8Loj8z+yKUxxaInzWDA3ELMVjD2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtEwXoMAyR5QoJ1Owj+DbgIE21QCuuya/SaUiu3e1oI=;
 b=O95WElitMx6jWgaU0b80IDO5hIe24t7ymWSijE2/XVnAY3n0WVkrZr8t+CPtbGXqWByV4L75ZcWaag9TxtTm6h5/OUgkzwEezKMHn3wVbT5BNtj7rVWyRYjDW0kvhAnaLC7zp/foanwMxfPsV4Dx/KkuQB4pDNDAA+0C3WK5fIc7XGh3MjgtxBokbRTQxzZN0SKw83Tx5WQBqwbSJEuQXUD3bYe4vHn5B7u2PNpgT3UJLDWn/0lL216DwntPtxZdGxsPLLGuZAwVG0VcjPv1G2eryWl9RfAGBjoGfcAhCnQ5P6egqTyUKXjF20Y+gYfjl77nGEbWXqFMC/ibt9qrlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtEwXoMAyR5QoJ1Owj+DbgIE21QCuuya/SaUiu3e1oI=;
 b=WJnSrKBUockaxGRf+AbLZ+Z2AYO1HYdyKLfxgwo3HSSjdMZvTIuLSJ+t7jUOYl9p5Tzqiym6paiA8nYM3GlXVPnsJr3U3jgoLaKauACwLqdWwzfZLa8Q99dw0CWGUCURZpTaAikA12HFCM/fhqXZWbh/dLYeCgy+VU2fYHENZTM=
Received: from BN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:e6::17)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 07:56:50 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::56) by BN0PR03CA0012.outlook.office365.com
 (2603:10b6:408:e6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 07:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 07:56:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 02:56:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 02:56:49 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 02:56:47 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Skip program gfxhub_v3_0_3 system aperture
 registers under SRIOV
Date: Tue, 25 Oct 2022 15:56:28 +0800
Message-ID: <20221025075627.1408720-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: c5331cd5-d70b-434f-df91-08dab65e7909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4x+lupqP2xFl1epiPNnGotMmZN68htGxL8owSbQ4jeiA5s03+otDJ/ziEWQSR32AOA4xlkDGxr5yKj5HbEx1o6OEmwCTUIDiSs8z9mPt3RDHQubA9ve/bMnJezcxq4KQgWCAsPKeTdEbbwtgKz9wGbmkNygEUBR8fzSSVxlrnG6cCszjUIFYMfBIZSwD4McZjYnZle5QJgr5sAQuGGSzXhpsFkM6TUsvhqq2oeaUmTQT8pfuz1VdXmliIqACLefCHYX6WC6L2pgFqIXUjkWjq8H5Hh3pveec/JyeuPV0Dv5YuD+N3lzGPV2/GdhgMcgXv3Xrvvd9vnTXnxjnZkrNbh/7eaCu69sKf5E+4yBx+u/QoI718ey5rqSj2pNxEARBX/6XuYfHEbI+bfSuGwqWDMKEraKnHwMIjxjCYYu6RpEzRM2kq0VnYuYx10q7QhCcrxy02xn7xrtHPiWor5doygSfzfjBXK5au3xGndXMhzfZomoFyKSv+jl/EuENFkAFI1on2h/XnpW2es+8xsORUxs83Gd8AElzA0kO8n0beTzlLB8HOeuZ+NREsKIrw/vGblAs6qTBZ0wF6rZQ39SwWt0da+zm3TF2hrcYMWNFOqlu4cqWVX5Jq4uObjNQuWrRVRfD0MG6EXLGDikO1TQeUpQMMuGvhLMTGuxyR7isHvC+1a0RIXS8Z4/1gbq2rLjhgg5sAXTvzYgBwynEcnJ+4wqNXXXi8AiwcvuE5nMuSsIT3c8IQ/Nk+GdPFh+SAcnj4ihUoq0EKO3njgt37dT7lxsJ6nbYJgo9etLmiZYIdShe5Cj96ECGZHa9gWRoUd3LFGNsuKKWKJwEJ5JPq16hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(8676002)(82740400003)(47076005)(6666004)(83380400001)(426003)(4326008)(36756003)(478600001)(4744005)(110136005)(54906003)(316002)(26005)(82310400005)(356005)(6636002)(2906002)(41300700001)(86362001)(8936002)(40460700003)(81166007)(2616005)(40480700001)(186003)(5660300002)(336012)(70206006)(1076003)(70586007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:56:49.9749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5331cd5-d70b-434f-df91-08dab65e7909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
gfxhub_v3_0_3 system aperture registers are removed from RLCG register access range.

[How]
Skip access gfxhub_v3_0_3 system aperture registers under SRIOV VF.
These registers will be programmed on host side.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 5d3fffd4929f..8c5bdf25df12 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -154,6 +154,9 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
+	if (!amdgpu_sriov_vf(adev))
+		return;
+
 	/* Disable AGP. */
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
-- 
2.25.1

