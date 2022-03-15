Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846BCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3553D10E45C;
	Tue, 15 Mar 2022 07:11:41 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1131910E45C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:11:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SipvM71yKa+miuKfCwxbO2u/LraklMEUWNSE7QYNW9ZIJxK0EyMwE5LP5R3KhmpPTrF24gPHbyZcFIEV5D9Zq71Kt6NO26vQfauc9RUBSY6azoxoC6VWl/CEbzi5y82bWasonmhO64fUJrSznu1I387Px9R9PJWAnT0aQ1NO2EjGYbJqlcUcQFotuk5N1LTVnsWPUi4oEJD43M78F69W5AShD6nqyU45rWFGd86mkW/dUEqERbocZnP3LOSxCjDCENpSHG3ZMzCIWugLygVUckrEelYa4gDc4Z8lRA9kaIY5DBY2kb+b/ccL9XbVcw00f7ORDv0B1ISlOmiKJkuRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x28/nmgEmwq7HCjdSnGz9zbLTDYj7HcqUm73v9/gHRo=;
 b=nTmsjN7ZtHsMHshCHWr8p8JO9Y6CokjYEGk7wZE/+OPQHlOSw2gUwkmBgfDXGgvn/G8JryRdwGRs/kYEZn3kVZ+pRJfsINfK6oFnK1VVkzrfA2pWFzPKQzpyGUAT5unxigEqhMPFAv1PltHQk1j2QDrK++4Ww9uzyYRjlmgk+UpIPV8W4AjkZrHVM5EIWe46AJVKEewK8/MDbY06tyWed3sNGcCgXBjP3DTps92TQGk2wkglbMZ82H9+ntv50SdOC1PN7c8ItYoe6zRcg3yrPcQoGCnva1e3+/j1DXMyxWmk+mNhcUxEy8wpw3L5nIbiaLXcnyiSYzgMs7eOp1tP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x28/nmgEmwq7HCjdSnGz9zbLTDYj7HcqUm73v9/gHRo=;
 b=bLP3ZcNfQiWnGka99sTBhNLOOOMMBy/p71wE0NhOzwRPmb/LmxMsE/fNumpd+scZ0MuJ52tph9QG0h4utA8v2q5GGplG1tBdM9JEaMObvE/HWM666duCNP67ffwyU/NkbIZw2UUd3uxUv4L98FP9qCNwHfWA8J//Pv3cFWI3uqQ=
Received: from BN9PR03CA0507.namprd03.prod.outlook.com (2603:10b6:408:130::32)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 07:11:36 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::20) by BN9PR03CA0507.outlook.office365.com
 (2603:10b6:408:130::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Tue, 15 Mar 2022 07:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 07:11:35 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 15 Mar 2022 02:11:33 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix pin count leak of PDB bo when unref
Date: Tue, 15 Mar 2022 15:11:02 +0800
Message-ID: <20220315071102.9773-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5255a89-6eef-4592-5010-08da06530ab4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1620A0475DDBDFE86CBA2830F1109@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bGfCuXN6hFgRf1s6qOCQHeLrzooejjdJUepDo4py5Il6IG4AjP9rfd84eww21Tz9K5RnTRTcVVIFJbVdXRH3L2AfHkZMKtN/wVg4mWhdIHbS7WjwHomo1XfCf7RXBFEdTekTVdRj7UiY4xqB6mPRdGy+uM4FUwxBbqTUyOkipTO1CHNi1+vz6OlykRv81QLOEG2IM50kO0Pe7HoTFC49iOnO+S8zHEfiB1J1HSq5xHQtxTQA5FgtWow05WBrXHU0dJI4Ascr6ZfD20b59jqwFixsIG6HpzohcL/ktCK8jDOKiUwnWSWycZVy0JUXcMlGdH4zDyv+mEdM0kSYqlad7pPfGyMYV6hKIDf7Ziw8W+/nb8553Qdfu2lh9UVy0nYMn49WAvsn4Y/JsoZQy2rQQQyHMFbwXHWFCjAc86llm/9BF+3yrCwHIWofS5O6duDAwJsCmbBhIQsnASpYPSLZUeF/qzKQD7LfK8wPaUfimMEaNV8rZnW6eU71493iQ+UtWYLLMOwXLWOuULErTLALXCik+7gG54JdKXlcLzTsmesIRbND8TTf3B/IJLlrHLGzyYAxSNDGEMWT5CJxtyneN9RfmXpaMjZn6X9csKSGiD2uDDQTQOqgZyMqU6Msn1uPepVGZlMrGrQj33/BMEjXo2BoZYQWFiRHhK1sNpPfuR1+x8DdNDrQn3R4y3TJgPSVJhuhkTftOOyC/Y8gBZDHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(186003)(16526019)(26005)(83380400001)(1076003)(336012)(426003)(8676002)(36756003)(508600001)(4326008)(110136005)(70586007)(70206006)(6636002)(316002)(7696005)(5660300002)(44832011)(4744005)(8936002)(2906002)(82310400004)(81166007)(2616005)(356005)(36860700001)(86362001)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:11:35.7206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5255a89-6eef-4592-5010-08da06530ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdgpu_bo_free_kernel instead of amdgpu_bo_unref to
perform a clean unreference job.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 431742eb7811..e4e7e6dbc6fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1721,7 +1721,7 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
 	amdgpu_gart_table_vram_free(adev);
-	amdgpu_bo_unref(&adev->gmc.pdb0_bo);
+	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, adev->gmc.ptr_pdb0);
 	amdgpu_bo_fini(adev);
 
 	return 0;
-- 
2.17.1

