Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B71C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 16:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5CF010E621;
	Tue,  7 Nov 2023 16:58:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD4C10E046
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 16:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2yTju30GiVyw5Vm5+NeiFxoocf8+1KCHDaZ0ioKfU7fzEKyGFJ1/kBTpf8l8UcSCWcnbjKbNxhQQ0ASMR5Z/Pd6Pm/C1zB3C41IPAmR0AROzcFeTWKFsNTqV2p7gLcLPx+8Q0Gnp5q3zwm9oXOQNP7q2QdMel30zLChiUezCxRpaFhEBQHiZOzcRrcyNCluLCQKn8jrJGB15BZryc8HMKqmqEu7ydx3ty35ROAwfXqS/S7vbGgWmD98g6RYByfY/rBFaTusuoqOiSH3V1lg+KyLx7aTvhOU4+V4oFY6V9fy9duAE1gIi4HMuqSFxSNzXOgVcmiEAfNQrvUfYgKmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5awVU+TVxAh8pKJQbTYGmFCdfnutzD74QR4AFJeVI68=;
 b=FH30K2RUtKx2a+kyFllsPUp/1YPh5bqEuoXpnNiKWK1nKlwciMlnG/HNv/64Ocprp3TZJBuuq4vYIXmb74L6yMoTP0UcZ+JIfUwiy14bps8cX/B9ExXnvDM7OCFjtvHBlPwQOTJPE3QueAFkwRxv1mBmwBWB+Ki/hlFu50BeJO12ta0lBhSc6XjMF+zK0LYAiRwf9UhQ/cEhoisYuttkHHyimTHmBdBiYKwViZJ0C5q1uofmQb2SUGNO4u0CDUeo6a9df6gsSnZ4uV0WzMwcAa6e6/daJHUYC/TzRw3syerNqBkFRSQqwEfujuIXCIgADNyroc0RNcY+tSsB6unH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5awVU+TVxAh8pKJQbTYGmFCdfnutzD74QR4AFJeVI68=;
 b=aBgD2qewGeOCVDuqJKF111+9PltQCMIB3RUw0zNIU+6JsXjAfYiJZm+uoUJmyDMe3GbV3ZDQGgKQl3vIpQIdcXvCv5qPMdxa05pYIpvPm9bXJ9dHY/nQbiDZka5/pvipCW9poeYF6YC+Bydi4BM6Jwmvy1Aeh2VQCmHF7uo2E7I=
Received: from CH2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:610:4f::32)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 16:58:31 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::82) by CH2PR18CA0022.outlook.office365.com
 (2603:10b6:610:4f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 16:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 16:58:31 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 10:58:30 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: Fix possible null pointer dereference
Date: Tue, 7 Nov 2023 11:58:09 -0500
Message-ID: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bba617-4faa-4b27-e516-08dbdfb2c576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADGlWl4h/nqfNENyzMuCMgZPMjg8iQ7Fpz6lGRBsYVTQfFJNP6BlYPOTVBrzrCFV0Z5qv91DtiVYM0mvcLWJaPB9XEAUsQwj6NklxmULgz5+cBivoz1YDoNtB4z4qMP83JQ4AEP98IM1NmEH7F7jZk0Uxqdf8jp3gpwcBPIrmUrFgTZ86Lqmi2z8YjPe9WKsWYCRpnxNkX4c3MC+rKWp11yEIllcnXkvawYa+JhEBHaYjMbaI4ljumfNCB/O+kjSu4K8EPzTTpvdnqFfbNMRAbQmRrgc5QDrbg2AEiFA7BY9/dxvt1DkMStD4MrWqsh61pqgO1DdgTj0zMF+fgMuflv2K/2HoG5dWXJQSTgpSnG2s7fR8RozCjVY2ZOhSC8kjIjGBE0bg1eBGvS3tlLLQgp4k7sfxm5D5uBwAh04TtxI8VGaltM5H1gTbCaN6w9R1XP26VKEM+zwbTXKMI+M8PEolZWyCDziJQ2IpYjdevMCjzN/3e626uqdqMTPNMC2SKnIM+J39f4odRB9JDjzY6Yr1eaog4by4EPRTRkb38SPlCKm4U75SVbOqTCVAN+eiumtUMbAALSGhd8oBZ7VanJHMRNlOJ8eWHOvCLIKt0GH7HKEeWXAISUM3GECOmk8A3zBo51hwZmkABvlaKzLb+lKMQf2XleAgrQ5LqQwikK5saTASn4jLdq5BA06wCBiQ23fo83EjLdew1R2vyrZc8Me9Sem7Wi8O0Q9DnAPJMLJHnuCE3FouAaH1Ev73d3uSfpSZQrqk/Fo8aIVwD1T2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(36860700001)(83380400001)(4326008)(36756003)(86362001)(8936002)(8676002)(2906002)(4744005)(41300700001)(6666004)(7696005)(6916009)(478600001)(82740400003)(356005)(16526019)(5660300002)(81166007)(316002)(426003)(54906003)(26005)(70206006)(336012)(2616005)(1076003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 16:58:31.2352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bba617-4faa-4b27-e516-08dbdfb2c576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

mem = bo->tbo.resource may be NULL in amdgpu_vm_bo_update.

Fixes: 180253782038 ("drm/ttm: stop allocating dummy resources during BO creation")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7b2a7c9156f0..1442d97ddd0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1015,8 +1015,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 				bo = gem_to_amdgpu_bo(gobj);
 		}
 		mem = bo->tbo.resource;
-		if (mem->mem_type == TTM_PL_TT ||
-		    mem->mem_type == AMDGPU_PL_PREEMPT)
+		if (mem && (mem->mem_type == TTM_PL_TT ||
+			    mem->mem_type == AMDGPU_PL_PREEMPT))
 			pages_addr = bo->tbo.ttm->dma_address;
 	}
 
-- 
2.34.1

