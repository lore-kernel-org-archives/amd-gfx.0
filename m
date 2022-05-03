Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADCBC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D619310F377;
	Tue,  3 May 2022 20:29:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF1610EF0C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgNTd+K0KPKqdtFF15TQ+ywP/o70zUsOFO8rVI8aTHpodqe4ONGDHcTHwu6LkNpZRO7sUvmzvqnG4PbcNCCFMnoWFYmVAf6LNXrWTAgFtD0baF1imi8H1HHaOQWQQ9KsXnkhnf+jRGOVcIZqgZ2g5y//Rx4Nf47mtsRA5b1+19r6+w7kzY4bJz1mJD7N8Gu3U1yIXJLkbuhvlnfo73MKNTc2QShmUrVkB8LB7bK4lOXG6xIa7fxquR3aO70eAHukKsC7CZ3FI6qbB5ih23FNKkK+MJPubLpPo3IdBiQHm8wg7a7mKE2uBiO5sFCe3cQheldFQrdch+b9CZzaISf88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PBMqhj/4d+vfBVhYNopgt4//05xx1K5VeZ5iYPsh0A=;
 b=SzStL4tHAGHG0r2MZrYW0HbSAWJLv4MLpqAmsHwaRTwUupqo0ZmyvwHIShM4+XFlUpdJ1XuvNmobMUaAOZn+jnLobzkEzbGENvIGuON9Uy/qdNX3cPtI9ypXo9YG31w8/pH2mdoWFZKm1kmFEDMUuNDobkzA0loZ8tcseccyKTVaD8LMcl8uwAoUezxhXFSoYtwomhrn7sTQU/vTwFh6kbqW8W8yaClmpK9gW4hvL4uiNF02r579SE9O6w6vRl77ZRvqie85eSWqhnqMRAWI2cb7y4ORw7lTLOVBoFUm9bsP5IkaFkH8Jy+EboGkmvK9ThoVl9jRanR4q1/9ZsXgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PBMqhj/4d+vfBVhYNopgt4//05xx1K5VeZ5iYPsh0A=;
 b=jF7QNX0grsfovv629+sE4D2bqzC96ORUXOFHlaCnLp5f+bXJnUtagBGenDviyO2hfz/GJ1ySnJc8vQLUG6OgX0eZ2EgDp/9eYzw1koDmlP+y7kswYS0AJ5aSKZg+PDA9uQHEYzQqZZYYmLUTKfavfRNwafean7rZHST1idUD060=
Received: from DM6PR13CA0013.namprd13.prod.outlook.com (2603:10b6:5:bc::26) by
 BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.20; Tue, 3 May 2022 20:29:29 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::61) by DM6PR13CA0013.outlook.office365.com
 (2603:10b6:5:bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.8 via Frontend
 Transport; Tue, 3 May 2022 20:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/jpeg: enable JPEG CG for VCN4_0_4
Date: Tue, 3 May 2022 16:28:54 -0400
Message-ID: <20220503202912.1211009-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a7ba8bc-184a-424a-8f99-08da2d439f9e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2711:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2711872E22EE49F580328119F7C09@BYAPR12MB2711.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ro3uQeNut33sG4VkV7BC3K9+FcH6pi1wVZRsv4EXT4RCGvXNuWeizulVuuPtpfeRQleuE5XmTFEhcpXW56ESX0nsf0oLaj2wDp6Y0SgDPh/tJ3eh2QcovJrmR6w4v81ekO9OKJs82+yRSOTX5bcFFu1N3GRi1jucwcb23iRPDrkSx5njuaSwktCEl6qkLaqS0IaC8t7vw/ZqedHCxbJdrxSDjTCODnts4gZlLTJSTSedWH2QCyEz8WzuBIQVkfKeKfpMh4Mjxu7mknboG/FabkFJH0CfQoyYkZOuliiyEnppf6/U1EiL7uTu2GZyuLIRtzKqn1WvMI5xoy1cQXqShZM/dT56ZpNR0uujY2ac0ahJEVYCZ5/mJcUbA4iDtZ2WE332O/XOtt6FZhe1nioe31IfZiHQ0WK2HzkKFS630UP/ggeEGXguWw3YD4lk2rjtlWTBmbicBwyDvl2OyJpI2+2Ix2LWyfWPSQ1Rfv0CQHcG3BKv+WOiYknbPTeS+z3qN0dI7fyfCyhaWOj1BXMYJau8C3A+tef+acgmFAM4+8ex/a6qBDrcXBPR8UTVl53DR7stxQZ9T5SndiPQEvhF6tY5CPiLr/0n72rSXKwITGLqIhVFGi8by2maVZY1m6GfW6O44fgIgLwYcKhbUOE5urlHYLczQG0UtsujXgC5E1kJP01Bmi3KQjXybyoKOzxKnAvdOTPLnf8Sj7Ynq0b2EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(70586007)(8676002)(508600001)(70206006)(2616005)(8936002)(4326008)(36860700001)(83380400001)(86362001)(356005)(4744005)(2906002)(81166007)(5660300002)(316002)(6666004)(16526019)(6916009)(36756003)(186003)(82310400005)(47076005)(7696005)(336012)(26005)(426003)(54906003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:28.9436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7ba8bc-184a-424a-8f99-08da2d439f9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2711
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable JPEG CG for VCN4_0_4.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d91bd70028b5..6d6aca7f64d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -548,7 +548,8 @@ static int soc21_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
 		break;
 	case IP_VERSION(11, 0, 2):
-		adev->cg_flags = 0;
+		adev->cg_flags =
+			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x10;
 		break;
-- 
2.35.1

