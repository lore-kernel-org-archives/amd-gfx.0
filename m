Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411D2C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E806C10EA1B;
	Tue,  3 May 2022 20:09:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209E110EA27
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzAuNV7f2DnVyc6DTEUdTDxbYzlM4Td/oRDbAUcvqWYuePVWYCh/1gV2M9DcDypbpfEahITX2CC9aBQBMKuU9QTcGoXzMmssdPhBSPhFEgtbKW7JVr7OkJhiuF3IKvjerEYsdeKqrmC7kxS0rjVxYg9DRvZqh9weNKzkwg9DCplc/r6NXeI41nd0LlJVwE7VNpVFsLKMclwTFmTSqEZz9/IYkhwkmSKEf03GLY588Ra1QSD9UYdUsoasihfLA03CkKGTi49BolsLNT9bFk+cRpE8U0QzTMUuE2kFSZ4JvgyMqZu0LFivtdth8FT+2CyP6AxQatYfxidgiDktyv0Low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnAai7RkmuDeNOT/UXQElrjxMpd1iBSMSZ4BMmGXuvw=;
 b=Fyn1cTCW35oqPI5hE5PdHBzei0pU+bHtys/m8NdqXPcZnSpuVR/5IfmhBi2kBmXV4U7hUUb+ypS8PP48G76uZHzFAIs9xipnEz/uHTQfemZCc6qxO1Dw+XTyvuOqaX8YKZljUgU81pdvQ/gt0DbwnlymPKQic5tkns5qSYoU/J/uLuflMV2YiucBUqMW5S9GYYPGG2vsP/nXxH6+yoEw8xsF9JqPM2lD2evQXghL0l/NGFJrSAll1QC5qVOE9BymSkOr/0nQkwNNHskrRmZB6Auyt9yJm2sKRSHFkysY5D7zEadwvmdtLPXPUBYrG+juQiZvDnkDw0aTyvW+2FRYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnAai7RkmuDeNOT/UXQElrjxMpd1iBSMSZ4BMmGXuvw=;
 b=KD0RsY4HMNxjkFI/JvC8w4A1fyrHsK89YsKrd585wppeNWKhJEaSID7P0fbBnKX9wwTW04uXQuTGsgg5tybzEbqH8mJ+h0q16tr0Dh9BnGGl31VZJc9Pu03kHSTt22Pc+E053bqRHyoxJ7OVuFPEcVuoEmVwi26/8DhXHliVb7g=
Received: from DM6PR06CA0038.namprd06.prod.outlook.com (2603:10b6:5:54::15) by
 BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Tue, 3 May 2022 20:09:18 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::22) by DM6PR06CA0038.outlook.office365.com
 (2603:10b6:5:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:09:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable clock gating for IH 6.0
Date: Tue, 3 May 2022 16:08:45 -0400
Message-ID: <20220503200855.1163186-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74a8d4ef-73bb-496e-6a9f-08da2d40ce2d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4129:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41297D1880C292269348DB1BF7C09@BY5PR12MB4129.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRljbQ47NJIlfQnwoLnewta2DrZlOozuN59uh6G6xaYf2+QxW2DDPjCa1OVKPjn30pb9eW/KLc4nM8Ah5a+POWzUPkpAh1RmM3zszocryGmo0pEYLewc6nMcbIQBo8pnXoKStfHxOvBBhn/Yhuijciq8muYO3NCP8nV9sQThZzalFAhCuWzvgpoi+yawDuFwAbbnykuVhm0CzWwBkuJayckkeBg/cvds64HbYUptnK7MZpBE/R7eA3HpHLKvY5Fd+/jVXPeP/oaKqkaVcobczqPB9euKlgW0Ers3wC+Q7PH63xP6w5liz2xoXHH2Yh13qX4Lp8aNXvLs1GjhJnwITOo46qOFvWwanq3JOQzr57nOHTusWdYzRNZp0Fg+0qXHVyKPqyqiRqBmygzOylbChEW8P5A3lSyCrFx8I5yPu/tuYBeuc6sTb8V5rjjLF1WbCT/oL+Gb0apyPl5NZ62e5HkjUzmrhCDum+I0ALw6zsw6He9i/Zj4/2lCnSDVRDb4QEEHuE144htISBSoWcPdG/HkcOAN7NwMUV8pW9WRLU5cjPXqkfgx1eDojG/tLBmH8LPYosz4VlMThcoiZi4HtOTMHMFmxWa9n3LBzPO2b/0w4/xnHbrKTCIymgE4wyAlYe7RriSjwNJLHWxOVfxnt+uhmyZBpWSF3ti3Bst+GGLjLd6iG1eO4U9/R3M9OCWMoKLH1uO8Ow2UGIEJbvXYlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(316002)(1076003)(2616005)(8936002)(54906003)(16526019)(6916009)(70206006)(86362001)(508600001)(70586007)(4326008)(8676002)(26005)(7696005)(6666004)(82310400005)(36860700001)(40460700003)(36756003)(356005)(4744005)(2906002)(81166007)(83380400001)(5660300002)(47076005)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:18.5492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a8d4ef-73bb-496e-6a9f-08da2d40ce2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable IH 6.0 clock gating.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 2497e2f8b118..24ba5e36378f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -537,7 +537,8 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_MGCG |
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS;
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_IH_CG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-- 
2.35.1

