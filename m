Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E845C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423C910F545;
	Tue,  3 May 2022 20:51:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A754B10F527
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isgL6o49rvPOLEuMfEMoCFz6Wv77dxXm+7Xu8eJuf4pf9PwPr0ZB/ZAB3aHLiY//WIeBoMIjgatcEvcYmDKbkF9gdeINwhceVvAnuETWymGNv29LwFa2ZuiuAoAPxUA3oQKhmvM3Kvzk6fZkfpKa53LeMKt5iedG9KKfKuHs7Ha3uCuQ+ip4ES9XFpCCTPV/jP7QjC4QwHLvu9r1jEBxWjAf/Fv8DxaOs1evUyou0PO8oFMBCMzeao0zki1Mgk2j93H9h/moHJRgLriYkgm81Kj2khW/vs14lkVEninZBO/YWg668LoXhSFMalEuKeQOipvmwXJiPZJrXofHwH6kKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qquRRtMO3YBsG17qCTMB5bDHL6TKrtiZ01NlriInt7M=;
 b=TZhw3zE29iTi0xcAWzJkRFFqM2X6xnf7LIolBXgdyh6xOfjvCfN1OgdPtws63+6HJyfnwcI6gRyhQBt1/CxnUE7Lixq2Qa1PtI/gX9KKiUl0gDcCiI+Oaz1IRpmDw3tGGKCs4C2OEwy/qGuKAh//aqbxoENtIrt6OA7+qsgKwZnoED4xg6QFFXT7LdeJZjAdnS1uOCl9gWjY/OVz4U8uyamfGMrpHhL6BH4SA0/LaJ0OQS6ORffvG5CUHzwyD6QzY6+e079gsAxpZ4EsVrtp1QssUGz5RMdBYbFLKwLee+bO6yRpxnYudYCB+ttAevlUDTYuQ5GkLJUbsWPMiWr+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qquRRtMO3YBsG17qCTMB5bDHL6TKrtiZ01NlriInt7M=;
 b=vRyltGo6pawWRaUd+UdDcgMyRcznIdzrZdVH8lGKPtbocf/hwqvKdXPbtqzBj8rCGgfE/A+YqQcLXo9dsFjegy3pC7ofq+s6qopMgCzhCQYtPcL4vO0c8l1MQgizWxTAHfE4YoQ9Iy6js8mJtN22BQ70lYzJEcEsKar3PcL2Bps=
Received: from DM6PR08CA0047.namprd08.prod.outlook.com (2603:10b6:5:1e0::21)
 by CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Tue, 3 May
 2022 20:51:33 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::81) by DM6PR08CA0047.outlook.office365.com
 (2603:10b6:5:1e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 20:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable imu firmware for GC 11.0.1
Date: Tue, 3 May 2022 16:51:10 -0400
Message-ID: <20220503205112.1285958-16-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ded1ec1a-a59c-4009-6680-08da2d46b503
X-MS-TrafficTypeDiagnostic: CH0PR12MB5058:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB505888BA2478993BF8B4B68AF7C09@CH0PR12MB5058.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CDHWPfrRH31TQ9yzCKbv0cjZjm9XhsXBlDgrQvzLc7NPE8b+agc0kYdj/taC8u6+yTQzM9XvkLZF3kdDhNwBcKPmQx6PfYmk6tKkQdWVHs/sLhYEpmJzK7TIO8JgdCLdQOzxLno3QraUSYkxiqrLrANWSDZ1h7RpqCw+A3B91kY+oeWuVa3+oXQSDWLGmJJAt/cSmeHuZcP0ov6Shk207cUmyRmwtRFxjOENLPc2sSxCVvi6D2qCvyV7V4Eri3Xc71b87Wl2pfeeTfTywQJLeQVcFptpVgz02f1igqtqNoubaSVNqoFF1HU3GZCyaSereSb4gH2xyuMDm01IeoQOtWzgTNscGODgqRFVnuT9egknkF6n0AEbCacv86LNoia+5UBWVIDRDnHZrxwIQkdT6XYOF53gLozZm7aY7ZnQzgoBGvBXcLfNUduUjUDZlxQHohhK/3+2YuHAhvc+7TKA3n9Cn/CqBMexJFQ0W3aZabATXUK6cci+8CDGBgD1R3dbO6qf6S28ldkyC4Oyu8VcJ5qfZXa2LWKXDP/k2KZ0hFipHEA9BK4ZS/1x28UQwuQAgcZ/RkfAUYv8LcadGiSWN5zpheaM3n5k4uEIfjkTX7kH2cIBexo4nDvEmAmnQDa06lK20oep3ip2DCfetsFX9xauPLlIhElqbNcZiZbjLe+XMmKUTVJQcDVLlpiIFwRexkrI7ArihYjEvj9FAmoQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(70586007)(8676002)(4326008)(1076003)(2906002)(5660300002)(81166007)(508600001)(8936002)(7696005)(36860700001)(16526019)(6666004)(4744005)(186003)(2616005)(426003)(356005)(36756003)(40460700003)(86362001)(47076005)(26005)(6916009)(54906003)(336012)(82310400005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:33.3268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ded1ec1a-a59c-4009-6680-08da2d46b503
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

The GC 11.0.1 needs load IMU to power up the GFX before loads GFX
firmware.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index b1964cc26aee..5d2dfeff8fe5 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -29,6 +29,7 @@
 #include "gc/gc_11_0_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
-- 
2.35.1

