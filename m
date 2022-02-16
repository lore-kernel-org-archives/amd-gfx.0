Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4D4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 20:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D22710E270;
	Wed, 16 Feb 2022 20:03:21 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22C710E270
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 20:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFFTGr+Ilk6g1/mjN7KTVwhB7np0AycgGnNwC7Uu24GwDlcd5IlwqTKVqUOJZDfjAybvswI1PbpbHXvZKQgZhYF9iD+gA0MbevAGm33eqM+qkQ0GW+NOS6H0C0N5wFJcg14ma7U4fJWQjDd1TzdOadxKIXhpBpQW9X9b1uGgwf+hdz1jWdQuiTmk2q4c2KuLgzrwlCK5PxMlNH7Trry2B0uUhslGkMc4d0CbYI+6nP4KmsBqifj1bkhIgscaE2I6G4t5ssKk9lYlVKVSS8eBueBsRSMQUkgynHeBJSHGeO0BaVpUaJLJHVYy1rp4RObr7IoSsmkjdFNLIrVkmYoesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIKl52ORE3LjSfSnLWWWC603GMXutvj5IbDHktoLtho=;
 b=YBk2I5yqUPYq6N09VS+5sOXQDKlX0oe4mklSUTssKXLQayGPUwqQmmj4ahEghDBqhOt0wf6hp6jvR/TblB7dXARf4EmM6sJwq+RkuVyh8YkjVEHoSoVyVh6or/fle3ubZVzbCtEan/qea4ItahnEICUuWYLxtKzm/JoTyWdQYnW6lcsp791NKFjfpsy9jWGx4N8JVvTwUEycCO5rfg6w3h+N0M8+CxJ3IYMPRqevwYw9szcvP3xdN6Ovn4Ew5YW+TpcHkmvHoFmMOPXSTX421eLvW6W+5V8Yg7RNTh2C0U8Lvn82PgNWiSCBEaxWPZ/lfAMSC3ungLjSicHOvanMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIKl52ORE3LjSfSnLWWWC603GMXutvj5IbDHktoLtho=;
 b=LyON036+YLx4kv5BwhuyttS+i6C3U/0lDuVbyIVt2J5eTFnKbILFZPNLCO7rsjrgbp4D0DjQsnr0T0gjuXVdZFXsApWi0LMezKEI3NCLQygy6StCbrStq1+tke1VkJ+ZQTLlIv0WEj0f2G8aPUCn9Zobik16Dy7vPHp7O8bKCKo=
Received: from MWHPR12CA0048.namprd12.prod.outlook.com (2603:10b6:301:2::34)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 20:03:17 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::60) by MWHPR12CA0048.outlook.office365.com
 (2603:10b6:301:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 20:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Wed, 16 Feb 2022 20:03:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 14:03:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add Clock and Power Gating support for gc 10.3.6
Date: Wed, 16 Feb 2022 15:03:04 -0500
Message-ID: <20220216200304.2693207-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af094f4d-5150-4b66-a8b4-08d9f1875f65
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892EF38A935F46CDC5298FAF7359@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgjChr9goJy6z/4smkPfxK4YkbVeVi5h4kfQCXC6lB2dltY5HhiBhIYrBK96GC6FPGUOVAcFn+aw5FvnN24Es3U4T7HlHpRWhgcqz52pI9Tzj/5ObbHM09Lw2d/a5ILm2DZfI/8uweyy76Ef6J5uF0CNVdtXd94IieegdbELWCZv8Ip6LULwr7R4F6v84UpXDBAqDU5HY5ZsohD7YVW0ASo7oK8x7qz1IAnZjvmpoDGRd4rPavw9xKDph/9XTVvhnY5KctGcYRZmuasQC0GM1/6bwV0sHKbxZXMWG5XQQ4Xkh3Q40vFyGuhvsajDQj6kJiCZ7nhZ5XZQbYk0C5Hangd7OUs7ug01ruwTXTg0Fov1jRLHFPWC48DSm1xSRh/a4xMG+UJh2PISWNQfWjzIrdXZO+qkJJo/wWYmuR9nopKnS6NyxkQ4wWwd4liZUd6nMxT7gwyjOkIRpDC4Izm8aUSSEs+Hx+a1jTotAtaLCKtj1LzwM9ak1Dld/qIb9DVMzPiZ6em9lhs+ybnH4mamO96oUjQMmY0xzUxCgDihECi/uls2CI0XnDRtAitqKmKLX1J1D3oDCAHaI72IN+aus2CXcO3K8m0iR7gAOjnZ7s+jPgbvdgGvAuGJ3CFjavmKgaIed6vXCKs/1E5jCFecdwG7I4k4zPP7mSwHo4i8kh3SBzorsA06YkdPG+wEQgAL2rNhe9SnkVHRgJlZc4QyBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(82310400004)(426003)(1076003)(336012)(2616005)(186003)(26005)(40460700003)(70586007)(6666004)(508600001)(81166007)(316002)(356005)(6916009)(7696005)(54906003)(36756003)(36860700001)(70206006)(8936002)(2906002)(47076005)(83380400001)(86362001)(8676002)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 20:03:17.0981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af094f4d-5150-4b66-a8b4-08d9f1875f65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

Add below supports:
GFX Coarse Grain Clock Gating(CGCG)
GFX Coarse grain light sleep/deep sleep(CGLS)
GFX Medium Grain Clock Gating(MGCG)
GFX Medium Grain light sleep/deep sleep(MGLS)
GFX Fine Grain Clock Gating(FGCG)
RLC MGLS
CP  MGLS
MMHUB Clock Gating
SDMA Clock Gating
HDP Clock Gating
ATHUB Clock Gating
IH Clock Gating
GFX Power Gating

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ca8d808756b8..feb8a0a123b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -906,8 +906,24 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x82;
 		break;
 	case IP_VERSION(10, 3, 6):
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG;
+		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	case IP_VERSION(10, 3, 7):
-- 
2.35.1

