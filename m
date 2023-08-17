Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFF4C3DA58
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FE610E553;
	Thu, 17 Aug 2023 18:11:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C07710E545
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDQXDamWpFIv/S/JL8EfXDnSj1INWMM6J/KGRockIvRkKawNahErSgH24fM4Jm5H/k+o1vdvG8Aku7hjXkE0hgyhS+733LCNMj8u9jzdYFJa/bIOnjhJ1jiOVIWpKerrYUi+wbm/qsj0/s517IgvTfNXFH6/+WiZILJuv5NJVEY87gxg0oNJRt0YUOeGygaQPMaKj3qwP2Sw/qpWJAscEmTdngrGp3o8pbsL/stC918RWngffrrfft7B8/Vh/uLRaE1nPIehvBbGADcinSNZ+22keWVos68cnTbreFukKncGbdVyFpqEhlUwuMWEJJBRPb2wRf3DnCoaJJULTKXjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcluMH7YP9kQLYNiVZ8++hlQtW2KaK/S78Bvl4vO6iA=;
 b=mA3YBlmhMH0bOA9uIP+pVt0q/+SZ6zr0FRg26uSeeM1lY7+/7yURNbkIiobqnhIstFFRT7Z+DfXqmzBsUVlF47rvug83dPQbNe0xaSbrNykww3GBjz2jNYs/9s97ukA2RmY6vLycL9xYYEtS9FjqNWiyIS1yivdGZSoQT6vNOvk9T4w3uqjmkHzAS2YONfba4siZ1D6V5sXr5OgtAYKGxXKNSxAeH6KVV6FQecyKWSnxOOlZT+LMubc3p3lHCgJoLOzwxrSHcxRTawPBXnnMSqkXDpVIh2+2Rbli4fKygd7KJqPeFysetbXoNhdq8bxZmOqfBB3940dPh2XyXCq1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcluMH7YP9kQLYNiVZ8++hlQtW2KaK/S78Bvl4vO6iA=;
 b=zon1ph5AsCxMEiAugL2s0cxORuTDYJRUX1RlUnrsfJjDP8L9LY5Py1FfDZ3kzHeU+nvWwQNArUpPF0R1tjpROT7DMvkmqV8fIeS5yLAkQ7Gisb/ZNrICsfXjsm3ailAKEZoj+jh6+Gn+3iNNwjBGT2IP89xH7ia78SPqCxAGDjo=
Received: from PH8PR21CA0020.namprd21.prod.outlook.com (2603:10b6:510:2ce::27)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 18:11:44 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::e5) by PH8PR21CA0020.outlook.office365.com
 (2603:10b6:510:2ce::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.8 via Frontend
 Transport; Thu, 17 Aug 2023 18:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 18:11:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:11:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/9] drm/amdgpu: add imu firmware support for gc_11_5_0
Date: Thu, 17 Aug 2023 14:11:18 -0400
Message-ID: <20230817181122.1543473-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181122.1543473-1-alexander.deucher@amd.com>
References: <20230817181122.1543473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf8b6e9-03ee-4e77-d268-08db9f4d69dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6xDYA5rI/bWNV7cjgTHeqyCz+qqlSan4TgZ9Mo76Wg2vOZk7l5tqBy/3TdCNEZFZrevN7SZTJTQqM6rTprz2aIY2KKqRxV8vZepkRdQ9VqWobmMkmob9EueyJR0z7OfduGxWL362hN52It9zF5Ql3HgNfMwKI+VD5y1UzbLnYGnxgqrOkummhZBkfjcXqRe9FnXn1mZIUp04E4VjupqYsbjAbFiCT9m69ZCDTatRLreeDdJh83bWnL1S5Oc1ckmQu3v/3erCJYWqclfEoPxMsagjoYmEkV5PRjnSaQgIM+OJEMvbh7aYPm3x5n+tXKWhZiy2s/72MpmVMpukF9LAWbD2laictf90Hq0IueV7wvwCxqKUu6ZgZWFH4qb8vWsfiNxFkaj38LsxqrzOBRPruODHsTiKVBxOauQqgbDlqB6tLCVMk+jXvxJ+wX28Oi8B1YjCIdRhH4Pcf/rXc0oATTNuFV67qm34frFoDynNFn6H3RmDKqIYeuj92QX4WuYr6ECA/1lsldPHWiwCm3p0m0RbjQ2irKlRLbKTxALswYokjxSxGR4n6NOdJhMFUCeZIUWVGxgzPK0+uDGvfxxyOyQ+y/Fn02VxT5hnA3vBMUXP2CTPWSRbGW4dzKShQYoSEnX1DuoNGWTarc/6AuMqEoGszteU3j9JbJfgFGQtrFEQPfdjRJvaMCxvoxGbdvVADAK01xYlDBJoSRY+i+e/AF+hNlZ73fuROasYMx/IienG28+mLDURLNLbt3pqDqmlzL8F35SQ28LgMR70W9NYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(6916009)(40480700001)(40460700003)(70206006)(81166007)(54906003)(70586007)(316002)(82740400003)(356005)(478600001)(41300700001)(4326008)(8676002)(5660300002)(8936002)(2906002)(47076005)(7696005)(336012)(26005)(36860700001)(1076003)(6666004)(16526019)(2616005)(426003)(4744005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:11:43.9809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf8b6e9-03ee-4e77-d268-08db9f4d69dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Add imu firmware support for gc_11_5_0.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 4ab90c7852c3..8f954c737c48 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -36,6 +36,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_0_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-- 
2.41.0

