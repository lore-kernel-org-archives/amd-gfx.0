Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C81C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 13:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7451D10E599;
	Wed, 20 Dec 2023 13:56:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A9CA10E599
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 13:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNg16SbU6AURHpTVFG9L3aKxfC6z5eD8o5T5Mn206LrjC+090ldjdp1TPqo+J9jkZ4zZbhcVAhFLKUS5ByQx1oOvVlPTSZqxE3UAY7WOtczD5kQX5JGUmND5nqB7/1eEQ5TyPV1oGYZtcNApWe0jqPecIx2YheShISf0A2dDZffVtKLS2IWPQkxPgfRQtrz9whRp+50MLAjz18JmXwwmLBjcw1zvL22bxp7xnq5tuXS8bnX6BPbvGlWzHPUvvTlb2t6RxNdBd7av8tjkhkTjMy7098AK/fhHtsTya3cWG2jGQt0rMwmlQ0ogxCwZl5Unk7UXl6ZVd3IllbD0N8cHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tmCTZ6z/49vEJW5G/ETtTxQR0BMhXd2POklp+lPNn8=;
 b=ngukfKjZaxN5ugjWHXbWhsWgt/zHJDEpGCZzERPPk4Sn/tRf89UX/FgDLgVm+Lew6IA5pO3tnDy7hOw2bqUvjGRWMpy4wKpjoh5cr+wVGyVKW1NBJ6LcFRp9RCbqokBm72GJhv4qm4GVBIzIMEk4Lwh8fr9c7KO2ToOC1RyNjftUlmEhN/Uok58L1mnh2eoNMSyBPl7hG6FBR1yOxbMwTgncPnefv1clYybu7+9fhbjBwbulHqHBgg3F8zg7VTnIrLvHgsXR0NaxN28fuhyRTjDtnupB17a/DrPLoacthaHB1X2NMML/vNQyzsGxmpKrwXM1N81YOo9PulAmA2x4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tmCTZ6z/49vEJW5G/ETtTxQR0BMhXd2POklp+lPNn8=;
 b=LW92ePBQnpyaEIEEkVWChUXYAHqFFFXuYbCBvTjFXTEEONhSqGvkLSwhSDjLR/8481/XxH/eA7hiT8c8rrrkZqmAq5IHWAY/rhZ3En5SkguJTOZS/aMeoVDgVBhSRCytLWwln1mD30sV/YxesvIbWRHPD8kKQrKywsi7+6m+cfE=
Received: from CH0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:610:11a::16)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Wed, 20 Dec 2023 13:56:19 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::c8) by CH0PR03CA0342.outlook.office365.com
 (2603:10b6:610:11a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 13:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 13:56:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 20 Dec 2023 07:56:16 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Remove unreachable code in
 amdgpu_xgmi_set_pstate()
Date: Wed, 20 Dec 2023 19:26:02 +0530
Message-ID: <20231220135602.933841-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: a3422ffb-fb02-4042-2c31-08dc016370ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g83Fbitf/5wl3tL/byo9boUNDwk3BV2GcpPbzdN8s/NncdwkAh9zZKGee9KbCmXI9ERh79P1NtEGeMoIxbs3Y+8lQk8i/n+V9+SvCt2o4WwmH1MHdM+52NuRWdS8uVfIEMj+pN9DvaYmFEVOTcW4rKWXhdEvupKAcr80xhkhsiaSQTh0MOuQr1zgFnSCNbZ8Jw3cF/Nc9AwSznlrFSNJ7D+5iOExEKFHS9tbhIDEloKOcZtM7DqzSVI4AI0ZJrz+1uUh2i1qEM5dmoRTMRrt+O6pNSmhKySgbblk+Qig2NyJIqvCywHhSHA+/lpvOX0dgBHi5XE0SvvAQitUn8+r6dejv4tumh4pIJvJXxSKa3eFzNKrhTGNsPhWZvFxK/TJjEYPaUumOgQ0mCLNzWuQMNab9bXvglgYba1v0NHCr1CKuEv/JPO2+WAWdUgb9GKAFTSJ+lhKg4P9QdHvMXCyMq8X127qGat0tVuANkomH2cZM9ODtCpQyW3zFw85J1lNpYUcmit8XoBa24AjAo1XpuD4amQxu4NQHLGzDs3CFsm66rL1xrfX+xx1E/rzwqkKs+JlzsRZ6uD970NEpJb8yXJW4B3//+w+l0OYSboPkiQlQESx1GCVLsmlrXNfCjdGs+YmJox2krxnhHO0B6nlU46uJ3QxHO6659i2hD5uljjgnOOzgctVqYVJaOKoMWYlSkuz2449wRqkTnJFCtVtfy+A4oftmeGk0VLXr6fxHXlZpS7htxl9F0IC06mBg37sgKkvNhecgVhAWwuo7fH3wA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(1076003)(40480700001)(2616005)(6666004)(5660300002)(26005)(16526019)(6636002)(316002)(426003)(336012)(66574015)(7696005)(478600001)(83380400001)(110136005)(40460700003)(70586007)(70206006)(54906003)(8676002)(8936002)(4326008)(47076005)(2906002)(41300700001)(356005)(86362001)(36860700001)(44832011)(4744005)(82740400003)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:56:18.4936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3422ffb-fb02-4042-2c31-08dc016370ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
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
Cc: Felix
 Kuehling <Felix.Kuehling@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:

drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:706 amdgpu_xgmi_set_pstate() warn: ignoring unreachable code.

Cc: Jonathan Kim <Jonathan.Kim@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index a6c88f2fe6e5..4b756f280c38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -703,9 +703,6 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
 	/* fw bug so temporarily disable pstate switching */
 	return 0;
 
-	if (!hive || adev->asic_type != CHIP_VEGA20)
-		return 0;
-
 	mutex_lock(&hive->hive_lock);
 
 	if (is_hi_req)
-- 
2.34.1

