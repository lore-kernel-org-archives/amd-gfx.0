Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D640FC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287BB10F4C7;
	Tue,  3 May 2022 20:51:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E8B10F4BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C86YCap/Gkf0bB7u5i1pqB1GvWYqABtzdZz18bxclglKGWHlLlfDXzjf3GAj39oEJfw0DjoHkFPjo7S+AgyLfFPul5W5YlE0eSzIdxgMor41R7Ec62NojpSDg6JOsKXdQRvMUS/APNfpLcA4jsADg73y65J+eZRWR8s7YYlw74VO1Ecpd5d06KUv7S3PdSec3SpdXN/8LQVf0ZtCnjm2WEAXSAz1ievJcA/9rW0kVp8ekwmNIVWlIRi9E2a2geTO5e5qbWF+XadQUXe4LtsYLAq+o7OmuJ+JAbAfXO8p9PPl+IFdy9nR4sM916/ZKdw6GNmbX5vMyZWd2+QUKpVvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Witps9Ycm1nNN82dQ0RQxJcyqJZGCUUL/Z9bHY6i/Q=;
 b=nbdPfDzUHH4QWRpcHMLE/8WMHZgHPc2YBdQ6PjTv/7YRjmYTiho7wzTKQcAz3uJhCXaBKVZV6uOMunldBMxy5Phurqnl6i9hOd2ROPLoI9KHZibgZPrIUeObfX1dji4ejO5bgBbgwmCEp9jb3X6flGf+emXaIqcmKT02JooHE/CIGew3dkZ3mFyAxEpoFnJlC3wlrNSluQgMNEqG6bSWNGuHImNcO+7ybqOEOBbhS+f62TV3HHt6is+XAh7EBLlMoMwfIxq/Hib0MylsSK9VfZLhGkXHM9JJPURb3CmxIWCGYdySmqL6SMsFXC11HrHfd0y6rdK4MCwNjRE20tNG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Witps9Ycm1nNN82dQ0RQxJcyqJZGCUUL/Z9bHY6i/Q=;
 b=TNKJapbOhQTLMzQ/7xeuXS6DgLLoQ1VcmHU0tvFq/zjbV4RmhW2e4xjwuCxbkLYwcYQrl5QagcSgWiGiargK7CSzYF4HAY6Z0Ckubf1I4148NVMeQ2vqu47tl8qELFNRLKOdRc5AKal8zZSzCLwl28956oy2VploWaswv/gM8rk=
Received: from DM6PR08CA0037.namprd08.prod.outlook.com (2603:10b6:5:1e0::11)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:51:26 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c0) by DM6PR08CA0037.outlook.office365.com
 (2603:10b6:5:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add gmc v11 support for GC 11.0.1
Date: Tue, 3 May 2022 16:50:58 -0400
Message-ID: <20220503205112.1285958-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d001acb-e8d2-4381-aa9d-08da2d46b0c6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4093:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB409317CB7AFC2CA8589FC78FF7C09@MN2PR12MB4093.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wj4kH6XJL/j7AhPXOCVnbfkNe7rC5wSyD0PchdTfNLGyYn5EwfPOAM9BS4AAOXAKZGULjfxYs/LwCn/0l3xvIdcQc6HDKI+JB419XlOkF3a32vGvXX38B6WVQ4YCFq+Z91fGly005q2Y+quXcjX1fMlT/yksW8fMe4qu7xX5H5jfNSE7oxwfo5SmbPlGNWSiT2F2vi5sLeApTz1KNR+VjWplqa1cvLb6UMsyk6/i0ncXH0yW4NkPHa2ZW/LxBXYkaDJTGA8BJu40LY8dyeOI2CMUIBeiWHQvy/RXuxkz4HClFrIiYdCMTmNmu087164hC/FqjezLKj8kyscewj8/gk8nwGHWAgFaffg3DMTyyiIk0wBjIsIr3Ki3G9qaRNHC0d2M3LzbWP9fJQzHxgIoSrmUx8Sdvw2W2/4mdL//1gQqHnjz0C3YH+EbmQYgGUNo8rL8fpUduwEfNfS3xFZI2T77dxwSbmHYV9NebroiPShLBncATuTJYuDDu49KmLNSBMNvE/+MDDrcN//P3AUeue7Za6/yeaRBoX3MyzNFPDNDixLq27DrLEdXb9HiMhDg2UyZUeJZKQTNx1YFpgOFyN4vcdbMr5Ng9ia4OHeqtm7Si7aRCBp4ziq4up2B5iesrjaRNj6FJ2K2Rrhba6y/nV2HQfR177zBzAt17xNphqsU31vEQTHOoNnvZIocPen4kWH46T8o/a3zxLzXUKlV3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(2906002)(356005)(81166007)(186003)(2616005)(6666004)(7696005)(16526019)(86362001)(8936002)(36860700001)(47076005)(426003)(336012)(82310400005)(40460700003)(5660300002)(8676002)(4744005)(26005)(36756003)(4326008)(6916009)(70586007)(70206006)(54906003)(1076003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:26.2023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d001acb-e8d2-4381-aa9d-08da2d46b0c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add gmc v11 support for GC 11.0.1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 2f3debbb1a52..84593414bf25 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -747,6 +747,7 @@ static int gmc_v11_0_sw_init(void *handle)
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 		adev->num_vmhubs = 2;
 		/*
-- 
2.35.1

