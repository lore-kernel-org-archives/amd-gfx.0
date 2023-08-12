Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF2C001B0
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 14:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF3010E064;
	Sat, 12 Aug 2023 14:52:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F7110E064
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 14:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtn4CMiiixRCIKkB0rZCKcf765HnM+TpUNE8pvadI8Yvr5gGKHg5bHJLOcwBAE8DS7ltVC3L5OhOjZKCRWJrkV7e6WZqfoGf0NSJNG6BxUg7M+joBK+DJSGKcoEPzK4738VSuNTQm6f6OioaryJY0BVGBIiggRfQdZXpU+cJPE4gd85GUtAfD4unR76Kk8ZIfYKA8c5deEKpuwIifSqlSGrKhR6TYSfxqM9Sga8xW4abeUxtu8R0qqCiJZ+BkyKWCRpvLYaDczFh+r0hCs6/xFUGod2dg77Nr+l0iOSBobCSDE7N0gLIYnQqYpB17NOA7veBBJTS5cI5Irc8uLa/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6hMGR6tZg98WHg1tK4xqmucZo9S5+gLCdo5biIZ2PQ=;
 b=lHgQWGVo4bhu/dpCeefVD2gFvUPYjC8aCDpUhusk9FcaDHUl/Ce3tdSZ0eJzyQwuTHSLQDmSFQWw0UnPYA6gZ8zgOE4JEQsPApBrijeP4sZTvgnNxmYCEU7Nf/w9e842Ehk0sCX7bEv/s04b6lCUjpVhbAKb33w/TRKiPi5R1V+gyZacQg+cEV2yGn3moXkIjL0oZ1Gk7ZZrrwOkeUuhciGAEn3ybM5EcaWOSGeGZPbD4FB0Czf7DhkdCgvoRdWBTBPmEXBeWItXLo+Py7xopcsB8nPFYz7Ij3hdbfPdH6nvDdnl+1ZIR2UHpEmHnhiaTN517YViudnb3Es6NUzLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6hMGR6tZg98WHg1tK4xqmucZo9S5+gLCdo5biIZ2PQ=;
 b=t0/dSQuDKMhQ13JfWy9grSM09E0kal0JgUaz0hrXSvTWhvtfN5VOZwGkCeFZkU8oglWdQilQgMdsalU5syuw+dKKqcDjGGKOT5YHPB3krAIY2jkj2OTFnGT6wbSb823Uqnk3v2KWWVNZlrwf1VBKvkCbL3AivTW1KqKw36XjPZY=
Received: from SA9PR13CA0006.namprd13.prod.outlook.com (2603:10b6:806:21::11)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.23; Sat, 12 Aug
 2023 14:52:35 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::5b) by SA9PR13CA0006.outlook.office365.com
 (2603:10b6:806:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.10 via Frontend
 Transport; Sat, 12 Aug 2023 14:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Sat, 12 Aug 2023 14:52:35 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 12 Aug
 2023 09:52:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Replace ternary operator with min() in
 'amdgpu_iomem_write'
Date: Sat, 12 Aug 2023 20:22:19 +0530
Message-ID: <20230812145219.469901-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b78cf63-b735-47d1-3100-08db9b43c3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRj6uGUVp2LbWOraWmD9fhbmN9p+g+liBRnTPru0EPSlnTLvKU3p9+3UBF7fyOFAMifnZnIxy+GAUzFGEjJcbFdSaJE7HUBaroWGepdIjTVSGVuRrV5ytpkBlXJ6zgvrtD2yI2spEUJkdd+yY45RR/cZ5oaT1q3GMWni19IK/uipODnWJRiOY893FX0FTH0XjWOarfEvIBuJYzPxtZP1V5aIkCrPHAGmrnkSG9buXTRULbfsbRGUudMdBLUBgPlWNPWel0iFXaNyOLAsk2DVzV+Yh5A6SZSeIT/nbIhzGkerRGHvd/SABnRCsVFgIY+FzCBBMkQmGWOvthUakzo253nbcGMtx6sTX5klYKMLXfMAkcx5z//A28ZHmdvBCx6FXnPDGI4o1yTYTz5DrnSenKG58oS4g+GKiBunKlPp29p/hpVEk5wbHFqT66ydSF4M31yGPxDaFF2bR4KosxGtBd/2HajJ7bBhhvRY8MAoragHMc9+hKh4H0sQvbMo8oXLFnOTEgtQbsEaA3A8+YZPz7NlqbvUmkdK9jb7yIe7AqqvN1cH+r5QVvEw9A/vzSv2AXqDzqGOd6yQjs947HsJ5z/5DUcgVHoMnxNw2sAHNx8xK/rvFiJuVsPqxKpdsDToPhISlKHfmPNKu/sQv+kU4GQt3qnTy7RhFkQRAeUT9ncWxO6S7CSa7ppR5QQPgRErIh2t6Z15wM1xq6u1qnNzpGRHxeb535mWqZRP+yArGQ89tFzRa+9Ho3I2ju+bHC77tI8NvYBT8ntiAX/E/zYaGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(186006)(82310400008)(1800799006)(451199021)(36840700001)(40470700004)(46966006)(16526019)(26005)(426003)(336012)(41300700001)(316002)(54906003)(70586007)(7696005)(6636002)(70206006)(478600001)(5660300002)(2616005)(1076003)(44832011)(8676002)(4326008)(8936002)(2906002)(83380400001)(6666004)(36860700001)(66574015)(47076005)(110136005)(356005)(82740400003)(81166007)(40480700001)(40460700003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 14:52:35.4214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b78cf63-b735-47d1-3100-08db9b43c3e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following coccicheck:

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2482:16-17: WARNING opportunity for min()

min() macro is defined in include/linux/minmax.h. It avoids multiple
evaluations of the arguments when non-constant and performs strict
type-checking.

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c03fe7ee555b..00c56d84f137 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2479,7 +2479,7 @@ static ssize_t amdgpu_iomem_write(struct file *f, const char __user *buf,
 		struct page *p;
 		void *ptr;
 
-		bytes = bytes < size ? bytes : size;
+		bytes = min(bytes, size);
 
 		addr = dom ? iommu_iova_to_phys(dom, addr) : addr;
 
-- 
2.25.1

