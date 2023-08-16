Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06BBC25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B58E10E3CC;
	Wed, 16 Aug 2023 21:31:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F5610E3D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKjCg3dDBGChj/W5vSNbXh3w2EuaUB//xzDxg0a6lWfS1LAhArNLTEmEktTjJqfMLCM4I0y7fsO7vSkOAGtys7Ox1ysVuxbiJXjVQgiAyLd996e1kDUBuDfP8QOJLEdGJKl1XJMS7XM4IYUR6Rd3Of5Sm06faNSbyZpzV55eSzv85zef6v01dx/TF+o5A+Y7MaqG5m1JlAeyCxG7EINExmX/SGUnFQ+I36VBBXFPfh1ToFv+6zKHPGO8Ix4/2k6CHQBy0cBL7h79xAdAR/SYe86WofTML6Ycs5CR3hgJgp7wM2sjcbvdZBOVlKyNTjSujRd0/dwUeD9cEAzd265dMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S1ul+N2Tqjq47vdvAO97VCMcTUdJfQU7+lB64bnTQA=;
 b=DbZCFzLgy2WefoBkNMyl8xQiHjuhXZ8ixynmu/hqT5+KXzq08ZN0Qsa5p6BHOpqR/phEUVEuWQvFGHC2SfdAtSLHYS/cRPZFVoG+8MD6NDeAFBVJ2hwVbjGyYIXJBZDoomWZIbGjH0kjJDvMqfdL1wb1ZNarCGaJZsfai6W2ozCxDd73EyF5f1CxTfJipF4SOhxyVGj4OJKs0vtWSFUg2VfbHFzS/C/N1aZJqpmoHNyxzz9uOinSqG3mCpIFmz4BPbfmgB41HljvgdeRBZYTEVHl8a86LJV1wFrRk3qVFXHQJVYxdti7JGBpJG8m8saUW0+H/kEZF/NHwU6Gy11fQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S1ul+N2Tqjq47vdvAO97VCMcTUdJfQU7+lB64bnTQA=;
 b=KW+jh/Py0Uj5GOGM3olZ+D1aKHJDVzDBgSo0pM74Z6uf0BsRwc4EM+plLE3VT+stKqDzmS6oz6hyXIHIIYyi21oalcJAdFkRWCRIdoDFE9+fWUR3pDg5WTx+N7o8BLnWkx9VqeYzjzcvg4nGIGze14/9yFdOnFvjHBc95k8xxZM=
Received: from CYZPR05CA0024.namprd05.prod.outlook.com (2603:10b6:930:89::29)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 21:31:17 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::89) by CYZPR05CA0024.outlook.office365.com
 (2603:10b6:930:89::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 21:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:31:17 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:31:15 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/18] drm/amd/display: Validate hw_points_num before using it
Date: Wed, 16 Aug 2023 15:26:21 -0600
Message-ID: <20230816212626.987519-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: c351b9dc-4c8c-499e-8e8f-08db9ea02000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgy7L6dj0s39ZXmTapnctIjqb+S+1P/v+Hvhp0jpytwxK+XhidEr3q6VL9LkwjEpguLtq2X2RwQEJ8CS3DlRbs4GWFzn4AE0IrzH3xoISTp6wtQz4ApTLXolC45nUgUjwzY0bth9S5XJy34VdqUSxGweRXtgI9LWN2mGZiE7z469nw1ILazSCMAltk2bn96NUSWJWH3FLHDm3MX6uSn+fdxzm5rqs9yiPHHgcQhaAYwhep0Dtrir5qet6m62C/90RdCqtlQdRwWRjxfnn8Np7AtMGC/04qHEht/kIWGQNYDcR978Z9dwCYNpf8MZjB8ug8RG/LoI/DTh5FdwAX7VBQAla8qAANr/yVGS3B3Od93xJGnV43+6aijM+oPsZGTLxIEbTjaxuMYaSPMaqk+gIltnT0Jdf+yi/GrXLfcIeB5chRkpnMlzCq5IokL0zViu1/q3pYxXmBDuA/NLht2KKc4Z1DHGM86PKqHSc4V4yOBKjmQaDZZ6qU2u0kxEcBKAXrEwmRDVfF+DnJqK+7IOqrob/dVHuAyJEwmsMFfNIF9XxAl4F0zKJrDA3SYqxxW0RuEJDoucDoph9KkLjUInYa6J5/9nDvehQ/oX2upQNgnEchdCM4kWic1aR3XFGbd9uVKzAViqhjtOCWLAo5TwS9uhBMb/A3rbftaUTps1+HjJgv1z5stqSJC2kArYh2VFJ22/WFcWZmZct213/c0fEvpM4R8ZNa54YIPFxXDKcp7Qtr3myy4ZbOC4TqUOoBwbkAWTynTBp9HiB+4dA92T3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(4744005)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:31:17.0983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c351b9dc-4c8c-499e-8e8f-08db9ea02000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHAT]
hw_points_num is 0 before ogam LUT is programmed; however, function
"dwb3_program_ogam_pwl" assumes hw_points_num is always greater than 0,
i.e. substracting it by 1 as an array index.

[HOW]
Check hw_points_num is not equal to 0 before using it.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
index 701c7d8bc038..03a50c32fcfe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
@@ -243,6 +243,9 @@ static bool dwb3_program_ogam_lut(
 		return false;
 	}
 
+	if (params->hw_points_num == 0)
+		return false;
+
 	REG_SET(DWB_OGAM_CONTROL, 0, DWB_OGAM_MODE, 2);
 
 	current_mode = dwb3_get_ogam_current(dwbc30);
-- 
2.41.0

