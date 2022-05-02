Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6039DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00CBB10F356;
	Mon,  2 May 2022 19:08:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E2310EA99
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZvih9H11rktbm/1TeLNnsobtdsotoLAcxaTuBw8vEOvToQ1CsCN9/IKfoe/0iNJtqOUiOLh6UOzbRmG9wt0moPAs3qQN/SVOPb+Fd+UpQVmbTF/oN6uqTgZ/hbHaU7P0e3YoEDoIep5B7MiCroeZo7QNiiQSiGh9q930QiR2XdKkzQmTJxrcCro1+dRJf+mD61Xysfkdz09KqvrBmiqkd8DUX08x7Rxrc3LejYGCzUok2bn6KsXl6Gjdwl2sclUYBdhaLRWsR7E8ILjELk+pu+LdgG8DeRzDWJV2wc2Nzc2XWFASa8PUBv2DeDG5UkupAMsvvisRDCQU3mOCvOwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sEV4zzSiAb1FvQjtbUdnq+AvpfmiQIbyCM4ZKT5VIY=;
 b=LsZPKpHbuFOp2lRnG70qjQ4wBbrxjCDFrxsvaeP7uJnWIh48OFhgSG8LfbUvVeYEUL7VxZkg6qe2TAKD7ptvL91C+o+haX4wPUOGFLcGluVqnR4KRLkg0KDA+IKkE0GmR/cudfuETeUM6lEH4NZdiwu+EoI2qVTv7w+o1+lbD3FAp6v609BLTci0rspwEZgT2DJG8YsGxUtcEPsxiD7rk/EEvw+VOTQbzQQA2/yffldzYXrSnJKW35+idGfvOcgAVoRlBKbwsui8UXwH5762P8FDIQkwgPLxzO81GRYzKpsEIwISCjCpG6s17bN/7rUEJfVMxX8Qsio0V/lw+I3AUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sEV4zzSiAb1FvQjtbUdnq+AvpfmiQIbyCM4ZKT5VIY=;
 b=LOJA2Y/vXWsY1MjiFb/6QMPuNP318jY3CI5G96irMKXr1k7b35gowrr3m/zjxBQ217KfSqTzkfAPTlIproihbW7YLk+oOFXiuz5nFWdWc1TJXX/VpqxpOiC1jk9g6Oi8IkLoIW481Q/iT3VP3LqbhsW7EIv397022fashUZK034=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 19:08:23 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::c7) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Mon, 2 May 2022 19:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:08:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:08:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amdgpu/jpeg: enable JPEG PG and CG for VCN4_0_0
Date: Mon, 2 May 2022 15:08:01 -0400
Message-ID: <20220502190804.784271-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502190804.784271-1-alexander.deucher@amd.com>
References: <20220502190804.784271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b88700d-df29-43ba-c9c2-08da2c6f20f6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4421:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4421712E8CC3C1C12A494140F7C19@MN2PR12MB4421.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwbUY/iMeKbnpHnmr2wlvwiyLRFNTXX5zu3/dGyVag1yWcW2dP4aN12EB2Xo6GkO6EccNn3SzVzu05s3YGE0DgipZZEtlAucAl1jtco6kx0fWPJwgg7dwbN1UyN38nkAn7IIktVCsTXT2wSWcXJYI1YlIjvWhlcmHj9ALy/R0X8qGxIUqmjdTQ4gKf4u5Xp/37L5hce23yVJYz5OqDdfdHUESstjHXCmoLT7BPsff/m52zrM0JdbVx5/vTzqpjgetkABKGo/TjD6I1dKI0egGksgDWm/M2HbCo7gH5DHzjI2IcFcXrMmwoR+XzuCZtmXPbS8baaZueJkEBaOYhoKcnmZirftcj7u32+kaVd3bnetwxjVdesMJ+HsSJfOz+UOaQIjIlQjw6d3cgzJxakUAulUoK5dyjEJX5WNuZyr1EVRnjgL8w8Zg2spK9I5E+eYu1/vYEhyAwCXo004mkKO7RXGKHa1K3urw1y7q8BmdlhcHZ7SVngr/w2npS+ah46z9yZhPrNlV61puBo0b46wlsKFSBm+wJGXlBKDCMSGa5qRrcZsRxAt6znQ5wSzf5lDBiPdzRbqh7NjipY2opZdtwOm+VKqyyyGIw7KxqNAuZqOtYgfqCeyDWnjY/lhShQHUBrISdJCZjalfwWQ2CracSN0tUTHytGPU7ngOFh3OWtqRaq0BJZ/2aaokn5OpCmjo0Lu/REiX+2Qc7SrlAJKVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(2906002)(186003)(82310400005)(36860700001)(40460700003)(36756003)(356005)(6666004)(316002)(7696005)(6916009)(26005)(336012)(508600001)(426003)(54906003)(8676002)(5660300002)(4326008)(86362001)(1076003)(2616005)(83380400001)(8936002)(16526019)(70586007)(70206006)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:08:23.0508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b88700d-df29-43ba-c9c2-08da2c6f20f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 James Zhu <James.Zhu@amd.com>, Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable JPEG PG and CG for VCN4_0_0.

Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c95dcbb1d5a3..66309992f9c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -483,8 +483,10 @@ static int soc21_common_early_init(void *handle)
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
-			AMD_CG_SUPPORT_VCN_MGCG;
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_ATHUB |
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
-- 
2.35.1

