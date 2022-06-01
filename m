Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D19CCA471
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 14:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B991810EE2E;
	Wed,  1 Jun 2022 14:14:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F5810EE2E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 14:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZoCckK7BYkPjebFcKxC+UZJp0BOLt4y2oFef0ebvshRlXrP8y0m9iLneUnpLye2DPzN/xWjeZAiTFM/lf9tVqGg945HGdZn7CJ0dQ2QS3COPsnLigKPFtOEHXTd/sjOau9f6FbwMzlRs9f/qzgZgQ6xRM0ocyGohLjUWvNikbACZZaM7hKQNrKvthUfaC4iRHHm9hPRHlimsr0jXtHDj6Mly/vSG7TnW/mhiNtNeXxX81W68RgnbOUJJysVy7sRkPGI53Ra6mCpozTdS6F4Arxs/I6RKppJ+q/1PLgpBD6bIqBa9QyUWowbpC/BXshzh3tu2zKMWaYc7IAhCZWbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dyE0turPxrOqjCvQgwSKEEl7kOYsU2sl30lXDgOHTs=;
 b=J3y4XVj/Kq4moQlVtMyYgnnnJt8SRFUZIvNHOTCREO+WFt7x+TrA3wvvufFgCtwoEmZu5Q2iAXrWd6Zdc6D5/Vzlvh63bc0swjbFjWqbcduUrJObAB4Ibe3ktY/rf3I6uI1LsNgulF/CxANNnjX/RHJk+z5ZiMF33tC9fcuqYgYns2D9vr+dufRRYkSV1JFCKSJa3eTj2zEGTaBYKH8vcKISNfEr3jinMr8JNUYoxhO+GjJNuUai5qW1oKS11rB7hFPHyZNWrAYNFy/ZSnBsLlfR3a6JijTomKdd1OALJQcO1uWEL7uYOrP/0vl1RvCOMBDCS6Eaht/MiqnDSBZEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dyE0turPxrOqjCvQgwSKEEl7kOYsU2sl30lXDgOHTs=;
 b=r622H9RbtIesUgj52FTAMvxvmTxPSOSN00eE5cjBBrTqdWLHSPMpMkNlc19THefweUXNwqKrWLRrmXfJNmZzk4mmy68Aei2lyZxEhFJRzsQQBG5Nu38bXUBTzmPG+jAPCsp1fZZd9yrm77S74B7LmFVAu2QknAy72LkYr+qq+R8=
Received: from BN7PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:20::15)
 by BN8PR12MB3122.namprd12.prod.outlook.com (2603:10b6:408:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 14:14:47 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::e5) by BN7PR02CA0002.outlook.office365.com
 (2603:10b6:408:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 1 Jun 2022 14:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 14:14:47 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 09:14:44 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Correct if identation that causes GCC warning
Date: Wed, 1 Jun 2022 10:14:00 -0400
Message-ID: <20220601141400.889921-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb79af6-9118-4480-9614-08da43d915a1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3122:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB31226C8A8E6D1AEBDB7ADC3298DF9@BN8PR12MB3122.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V89sDmzG0UuT+SQ252+GI11aoBgXVJK7OWi+/KtUFebEktkF1QHvYZlLg/kE1LhK83ugdELUTSZrpU/UzdK00JDoGT6GXeRjVmJixJA92JJXyFnHjEHrOjHTJueAODdjh/1xcsEP+75jUgCExgzd7h8rMzXvru/4xHs7aOByrz2NG46HGtF8KJ5kYZZ5X4XUyX0auMF6irM7lddsv9Rwr4gQKAv6LTmm7tAC61w56VtKMavnLCQLam1sPfEE07w1uY+ddlKUXRoCumEbL2AIn4enDbo69pixBPFbRImjTCHvbxvU1C4XWqKP9g1u//oSD3KkH9yqTZguJ6a0PSDo5Z8P8ucm0UejP56oUwhO7bukP8Nm1IIs/5gy3WkIGY6WhN00IRwS3sovFDKrbvkx/Zq51VSUTM7Emm36IDK6rXKMNvrUO3yImZ6TJgpRc+aYEyujdmm41EzxsmoXhJNgAEg6B4APTsJZ4LTrLkWdRBZwS11OBO/uqJrWQMftPWs0Iyn/WbVvd2B1SxcYqvBwLyP5uOTea1Uksze77GVlRnt8AYe++41gclUgSzPaHNmHTAe3sfO9CtHNR7QuF4VBiMono9s9Vhr9BT7SIFl6UQtph6B8SivfFerWEJY79M1+5BXQ7BAgq2uiO6gzDdG/Cnyceh5GZU6Sl9Doa9qKkwjM3KfcKPd5zqf9Hr0ueNVW81vwwL/uxRljpqZwY/dsKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(82310400005)(5660300002)(36756003)(47076005)(8936002)(356005)(83380400001)(2906002)(426003)(336012)(7696005)(26005)(16526019)(186003)(6666004)(2616005)(1076003)(40460700003)(508600001)(316002)(70586007)(70206006)(8676002)(4326008)(6916009)(54906003)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:14:47.5440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb79af6-9118-4480-9614-08da43d915a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3122
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Candice Li <candice.li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GCC is complaining about misleading indentation:

error: this ‘if’ clause does not guard... [-Werror=misleading-indentation]
  603 |  if (r)

This commit adjusts the commit indentation.

Cc: Candice Li <candice.li@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 99c1a2d3dae8..e1f4c5f30645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -599,9 +599,9 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 		if (!amdgpu_persistent_edc_harvesting_supported(adev))
 			amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
 
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
+		r = amdgpu_ras_block_late_init(adev, ras_block);
+		if (r)
+			return r;
 
 		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 		if (r)
-- 
2.25.1

