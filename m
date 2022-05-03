Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1DDC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F8A10F280;
	Tue,  3 May 2022 20:29:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32F410F280
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWpCIUCgjKXUls6LANgcSE+3CMHH1xaAR+dPxW6pUaV895TAv0C4vOhijiUTOwyVX41rZDMxPn9lFSuxO0dAAtI1UeoWGfMhrsZGnQasgSrRRlFZzKwpUj0/G4YN3OHRJTV99wx1BmWVj4vcm1SCu9b8sdC694uz5CqJgR2H4GIFeynpo/8VU/tOZOPrAtF2aTp3TGN2CCgf8erCwjwjsNjwPQlOS/aBa87rnYGqLkSCzi8eaRKLIxlHH2DQVkK03KJ15yp84kIMVUj913gmrNGumPNsoH4lzgPyXKYp+sbY0QUbNjp1py07lVYeYpSM2ijpGOWKAd4TIkUwffWYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoFAd/40jzQGq04etmwRyArai+DnqZ+uVI2oDNpDOic=;
 b=dKSFpDZXt2bWqbqQBlUk+ZgGXC7QvCpE/gOjkjvZKr9H5wDJy0alXqefuuGLs/FbbLxxQ4rJ1c44xTX8sbEwfv0QVDfWLOOsu2lvAE6OgsVpsr7+9+kZwF9kt7Hcez5ynyUO3O0bfRvgTcPz7k54SDsXYxRT7x8Q0EllbiMxLR0RGhkNKKQgpKU4yrQdxLigbMkuFYntoLucFn7tMSxm8wEdXFNWH1XMcAtPQ0o+iYbvaA/Uu/lU9xZ/0YIBzqL5HLR8lu6TrYhxXqXdyFUIAbdfXC4DWfKKwZyfpUjsyfJ14iFXvO5qsMFKnb6CaJmgnP71zuFBuudzmfijRsgW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoFAd/40jzQGq04etmwRyArai+DnqZ+uVI2oDNpDOic=;
 b=4X6sKEB3ch2FMJ5z3IkWAoQ6FSH181zuKmjAxWAJ2eIZ9kvc4hBEDx+R9PjiO+DhT4aEpxfC1QdFn9MinoNDCoKlfz8N4mZqhRpm14olfNPcN1S0poJdMigoNlHVmaciRIZyGyMJ7F5szl6TZgGCQmLgsLLXnG5FYADbZJcD2ic=
Received: from DM6PR13CA0018.namprd13.prod.outlook.com (2603:10b6:5:bc::31) by
 MWHPR12MB1136.namprd12.prod.outlook.com (2603:10b6:300:f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.20; Tue, 3 May 2022 20:29:31 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::29) by DM6PR13CA0018.outlook.office365.com
 (2603:10b6:5:bc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Tue, 3 May 2022 20:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: enable VCN PG for VCN4_0_4
Date: Tue, 3 May 2022 16:28:57 -0400
Message-ID: <20220503202912.1211009-10-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dbbe4a8a-6ef2-4395-6a31-08da2d43a0e0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1136:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1136F18B26CD2213408ACFB1F7C09@MWHPR12MB1136.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxXWxbcqurqkVykCoHuuCn80goiv2IwVrCPsgFxD3ZSkUesTJGpTceNrJ5xI8AzXgKfGbGOH5oLM4LjLSNzmIf7pn/3CcJb0UkvoNx3+dHln7D1OzLMSYntb9cK1mTSl8rjTjcy/fFB5qjk2bxmEJxUIxUfBUNoPd64Mmg0REy0Gm1xmvYT5MyW6mDs1JG1sFS+D1ZPkxXgt94AkKPqlEaoagFVoJ+oT5MMx90HNEc7M0HXUYOzfIjHkEPSIFI4H7l7o0e/R555Sl5Qp1SGdleCR7o//R2FJMpez15N86ElrYFuXZCkD4yWqNchYk1f72fo3hVKqFmv2/5oSaqcEkQfhtx99Nkw4FTIdoohZDinYM3L4f3Q/I5x5YS2oS+f8XjJ+QkuKx7GLl8Uk8e+ZCaRtWqqui3OYgYpnIDT4/iNzF+FLn0vuph8oSSqJhkXmFfO/7wOFjVJAwV+UBkyvOXAq8OFAPUcEa9jTsNjuyObXEPOEei7WudUpUhd4Pm/Tczti5xRdqUpJX6Z5eG4ne9AximCzvBS/d48Djam2RyKSR+LQiREbG6tM0XacCZNg/HYbUaiPbetK0sRNdZMg9H9i1TrxXRRODlfvl+4Ywq2UDFReWo93AQ8wjfeC++3oJLyvDXTPA7EZohPxaREp/51zUL/YXZ+arXUOb3jLpW29O2Z5meYbKCvlbr4RmyLjx317OgM/aBFlYj80xRESzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6916009)(2616005)(86362001)(316002)(1076003)(47076005)(426003)(54906003)(336012)(186003)(36860700001)(16526019)(508600001)(7696005)(26005)(8936002)(82310400005)(6666004)(4326008)(8676002)(36756003)(40460700003)(2906002)(4744005)(81166007)(5660300002)(356005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:31.0529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbe4a8a-6ef2-4395-6a31-08da2d43a0e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1136
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

Enable VCN PG for VCN4_0_4.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d2ea7db18141..b72bbad753f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -552,6 +552,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
+			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x10;
 		break;
-- 
2.35.1

