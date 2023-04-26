Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEA5C7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49EB210EA40;
	Wed, 26 Apr 2023 21:22:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4B610EA29
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baUQGZ/5kojD6ByR3+HIpIcjcfsHUHKzRXT//Y2HAGvc6HL1i9hXh2xqaB/QxWOPsXzLW/HH4LrP/Xj8pOjOugiOTtXSMO/M1lADVVe1Rh01xcPKDfVnyEQ00ryEWJmnPPgsviAP9cdQ9w589an+x3UM3zfiO1PX3AAZ3AjgNQdQzxDnM4rgAUXZh23wBxJ/ZoDmwj+5sQbt7lGVGa8OcNfPuBeSbSFEEEZvxnod1WrHtn4BT6a4QFAfB6H6WMF8EhrAZ8XmGRUulqbfdLxXEqC8GHGgv4EyLI9ZjjUhwl/NcMfuIrRV01iDXHdBTK6tspw8Phlw/JE45bGrnKHTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guMCWK+zXozuenlXrEYUbErfptCAUqx7sfFEIMQ+BzA=;
 b=iKjcCddBrcQHdBCd5Dk83Nvg3eqh9hC2K7PVjfc4+anDL05/JpBrnz7Nir7ufkcZFj2cZgnxIKRlOT2fa0CN7pG7rF1XCmAFJjJ6dZH3yDL20JV7Q/rSQax9cxsoIP4H3+rFDQlF9/kMZJhiKNmyRok4vuD+ohZowVKru4jGUqTOfCLnW98x3PNHR3m3I/kkcD4I0f5e0M4RkDN9ZpE7fnMq9zcSKVDKyoWyXbJJ1ZsWDey3UscSg68A3zTKXC1HIOVv4aCv7K2vQ5bE8YkIKST+nXTnzW8bsXTKygMqI8j+HTL1ipSdD0BM7Gkp8wHixlPollPZoMANBHWG8gQMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guMCWK+zXozuenlXrEYUbErfptCAUqx7sfFEIMQ+BzA=;
 b=LqYsbA5dUIV7vD3dV+NG7ANMTpxt8GlgVa/n1ijSwB14g6+xyNH6Ka5UZpFzIkdf8hXdC3AS2StKDRVXabsBzQ8NpsbOcyBfEsnRP5CWWTL3XzUhSB6n5xdJoFBRLF7m82giEJ0/2322n20nx7TJZh7FGf7UpT9YmVl80+KkhrQ=
Received: from DS7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::14) by
 SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 21:22:03 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::81) by DS7P222CA0004.outlook.office365.com
 (2603:10b6:8:2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amdgpu/gfx11: drop unused variable
Date: Wed, 26 Apr 2023 17:21:38 -0400
Message-ID: <20230426212143.7696-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: d66b1326-7078-4691-d7ae-08db469c47d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0N4bAkWqeE0avCWf4OViYFhqAbS52PJaYvmslim2jlU3GYID5lJA942iY6RndUdLpkQw3f57bQJw0Pmx/XJKDp3q7HuoSr24mgYL1wFmEOTulmlSsm+c3zCmkxqU/MItDWN0JfZXflc+5dvcF70I1ZCN06owXVJ7lgw6BMAO2r6kcoOCvEmgH6CVUnwAMzwrXTAZUOQL1hi8Bohb8DOh9Jz60trbWAxN3/Ao0kzrnapFOMGQOd1wc3bD3L2ZWm+OtVtDuL2CcBOm/NvlZEL6660CGgKNrxJr6bdyKpMVIT5m52VMF96qfcu04bGxsBWfup+L9uSxNGdC4YSXCnFlcV2RTuL2XGqV5rXMeIizVTFq9qb7T+AsEpV6QENPjwHBqDRw+hoi5IQQyFrcwA9535efhzNY5sEfkPz+j3eXYJ8OMuf7/6q0dokHglgfF6jbvOFbWIqwrKCpXazlGip/zmPdMAau9anb2RVSEvXe2+gge9Sj8GLKulzRoliwdmTdFDoe62lpCNscYvcMC2ASnTLAmaWeHrkfK65SmtH9GQHBbSFNu/VzzGy9r0wf0pqc0ihiotjZThwivRkTTGLebiGzKfeAs5FgLcWtgjIemrClfCC+sMdZJRBTpXgltT0bq0/kzR31izYat7bQqXpTRpfmaM5pblDgJp8A5l66K8v55V3HGRP1YHFPoh+d7w3D287QFY6u1sXxJcuKK0XHLFztrms1oNhyRervOrkp7z0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(8676002)(8936002)(70206006)(81166007)(6916009)(478600001)(86362001)(70586007)(82310400005)(2906002)(41300700001)(316002)(4326008)(6666004)(4744005)(5660300002)(7696005)(26005)(1076003)(186003)(47076005)(82740400003)(356005)(16526019)(40460700003)(2616005)(336012)(40480700001)(426003)(36756003)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:03.6446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d66b1326-7078-4691-d7ae-08db469c47d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just check the return value directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d36d365cb582..256014a8c824 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4373,7 +4373,6 @@ static int gfx_v11_0_hw_init(void *handle)
 static int gfx_v11_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r;
 
 	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
@@ -4381,8 +4380,7 @@ static int gfx_v11_0_hw_fini(void *handle)
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
-			r = amdgpu_gfx_disable_kgq(adev, 0);
-			if (r)
+			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
 
-- 
2.40.0

