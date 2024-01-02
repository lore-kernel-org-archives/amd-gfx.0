Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2734C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64CF810E10F;
	Tue,  2 Jan 2024 03:44:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8629D10E110
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC4LJv/1jN6foEjXUFcbLZAoPOGKSMDyIwr1tShn55fFMULFE/kNJGalCYe9PgYLZzs7xk4d2VULWC79Lz6Ux4hE90zT33AyMtmIe8ZKydxdndCsZ32uSJDZhMkCwveNz9OwOT4i/A3oX/kkha3MQOWb/l4/5Sn5wj/rbLtAol/96Am2uLKDhyP+UeYxB7wORWY8blBHnin1F/q0mpEqZn6jXRa/+e2JkRwxts6p0drI4D6z6nO6dPDR9qEPlKFS1ConOQbvZpE9BLG6vqrFhC/IPPbGMJnn+9kq36ibQ5oAFN9oPCaeqkQVSX0HGQFfN9KNjmkFJaxp+sWaMS7qPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgAVzo6NDr6nRRMPejbzkZ5VRVp10MgvNxe7KLxsi6Y=;
 b=EFqCdt/xZMS0YgVNhKz76aQjfFLqgH3/ajacZfWC9t1+wqLFdJ9QLvNoN3APgq7wnyb37o8Y4tKPlCh0KuciCkpuYCUUI/WFuP0+FbRzhqZAFGR389XQS61Qg9QoYId1sZPcLR4X+CCJv/Dz57eVbwkLL7ABvDUzN4edEDWSZsWel/y8xHlPrDtfRiuaPOOfj/cxtu6mu1Pmu0yie19ldA/KoZ3hhDIwA1vdSuuRiCfaLnY9MKsPxCloB6LJ/mbFAF5YbvXwP1RrhyRFxUXwWN3lxvnwvqDw4tIVEeK4i2o5FO7zlZRX9zlHD0IT6JGPwtFmJIF8wyb/FLLmZekZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgAVzo6NDr6nRRMPejbzkZ5VRVp10MgvNxe7KLxsi6Y=;
 b=QbdiSuYTdYsp/DH8aEFg+qOFi5qtjTiWhcKVRVNzH0vg5Cub5bqsm+HlT2sLbK7cewawB+8qWmXJh/qkB0HBHAiI1F7yrgNYCpIYjCrWZOkCZ9LLDAL02StNpke7i+RWAG7vwb+YjJKX7Hv9KOe7ia5wHcmCIXiBQ3ixVss4pCc=
Received: from BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15) by
 PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 03:44:27 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::f8) by BYAPR01CA0002.outlook.office365.com
 (2603:10b6:a02:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Tue, 2 Jan 2024 03:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:44:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:26 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:44:23 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Query boot status if boot failed
Date: Tue, 2 Jan 2024 11:43:41 +0800
Message-ID: <20240102034341.16321-6-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102034341.16321-1-Hawking.Zhang@amd.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 2958aa1c-0e60-4a9c-9ac9-08dc0b451e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6v0cQq753yumRiwwDXZB7S7hIqPEs9fBvmtLRZU0/9pNyBT5NiWRAtHia2W4ZzLOQuUpxqFOQdabKmMT3T89EOLNuh7RFIuayb7vUT3ycr9iVQ7JIYPjZRM6hceo1iofh82yYln173LHqgQ4wyS4xg0+cWSJQnf2ANbiBf/BXVz/sY9kD561knOysVL/joK/SCyYwS8G3tXFmyXYuLImRAMwj/BpLnDaKQPEJCO3FIau+hDbBbQROpKRZS2ohnB6h5mdHFfzMpNVTkpxweOwJPdYdIVyElm6cl8VjcaEh+4lvM2Tgsgx8J4ZaCIQnc6AYYRqxJZQLhB77SAirAPcwYUDW5Nml7FrD38mp76Q/LpsyGHxu9N7PP4ksp7yukSLH6w09mN5Xflm+W8K8v/ruOiGVcRtmcmGnt5IExmOFvOmaM90js9KBMnqhl7ZL/KUxysfcF2FFZUa1Euxs9voSdhOZIcoEBbGQbMUdJf5rmWSHyGxOaKUXfJxZ1NqyQl43/d3X4/pMxsKhcyjCNc1lgZNZ0w4sigbuSgAY0o0ARI6At2zJEckbbBaPuxv7xdf1ADAEHG2s/k1ZkOPvkF9zodNrPRUcK3OrfuNR/H8GOP34LcTxNaCY4/91jiEZspuPEva86EIT8ATV5eHmw31L0l6a/zZF8+Jl2yZ/YVf+OwzPPP8tJpfX6WpUC5mXxnIhb3uOms6YjuN5lwKueuwrrmEAVGK8n1OH5XRmMxmPqJhbH5L9mWbmF+EnVpLveY1e2yCxAexmq+8AVJJWivYBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(336012)(1076003)(426003)(83380400001)(26005)(2616005)(6666004)(7696005)(36860700001)(5660300002)(70586007)(47076005)(4326008)(41300700001)(2906002)(478600001)(316002)(70206006)(54906003)(8936002)(8676002)(6636002)(110136005)(86362001)(36756003)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:44:27.1541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2958aa1c-0e60-4a9c-9ac9-08dc0b451e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check and report firmware boot status if it doesn't
reach steady status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 6fad451a85be..676bec2cc157 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -187,11 +187,18 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 static int psp_v13_0_wait_for_bootloader_steady_state(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
+	int ret;
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
-		psp_v13_0_wait_for_vmbx_ready(psp);
+		ret = psp_v13_0_wait_for_vmbx_ready(psp);
+		if (ret)
+			amdgpu_ras_query_boot_status(adev, 4);
+
+		ret = psp_v13_0_wait_for_bootloader(psp);
+		if (ret)
+			amdgpu_ras_query_boot_status(adev, 4);
 
-		return psp_v13_0_wait_for_bootloader(psp);
+		return ret;
 	}
 
 	return 0;
-- 
2.17.1

