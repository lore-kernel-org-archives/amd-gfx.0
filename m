Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70213C47089
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 23:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DD110E0C9;
	Mon,  5 Dec 2022 23:45:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7BE10E0C9
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 23:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA/NqFV/HfLzFdzZOW81UmbYD0wIW00a7JZmoxThVtr0hGqSC4l2svjtuuGQ5nKyyyfybk7Ws4n+gesdI+2bn2vhqfl/GjEblTU92JhU3/EMvB54qqfnYcAIVtcoUEGtAREmDr7Oe+hCA7XHK801LpCWt9jY8VgL/IA4mABWaKLtecso7++8EUN21W29NKszcPlisf3EULyeaJi8Z89MegqDeFJiad+pvTiRWtd9EYBEDrrzNHG7nYfcNpMj4Xmddf8Vx2E5uYK6E3lJVln25XcCRr94UrI2mSGZH5gVExkl2/eQOIEQ5tAdTSj43dVs6yuFYWhxhugNp6XOpokhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTA8ZOYSjg5RG0V4W+Q0JCfb2mcJuUIylnlUDLzCuTE=;
 b=YKOpbOhmOojlGJ/S3GaRfrhkwOoEZkSbOkaM0kizUSqEystGWa0OTJWRgK+1c0Ans9ghgipfcXyZ0dKBGg+xQv3ixbzSYw71AAx8KdqnO0cMPnX5v2ul6Vmic92Xbv3OEwlFgF00f0EcAesmgAAgB968u1rLY3AyVzPlwB217BOad97HtREJUsGzpLgPHk1loEvMeYwApS1eC3k5K6Im8WnKsTPX6zpratwP1si2Jg8VJIkbyOuPzBS8LZfBHL9nIbAHmjhtCI2bneo6yci/cMJrT4V/btyF8orJV4NjHYDtDjtgnAemKQbuStsjLnanNuSRMsLJSgS+sg6XmaMVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTA8ZOYSjg5RG0V4W+Q0JCfb2mcJuUIylnlUDLzCuTE=;
 b=jqGdkZ2Q4JRsuszmpR3lRhbSF4h/3Os5otZqcHKHixoZ9Stg5wLy7ordTocSvwhlSNCEUBD5GYjFH72mS6ZoeIp1NMKVhEy2+Gh5KvIWdB4vFSdH/gibx/Zucj6Jcz5aZ0FRkaR0M/GZS6GkIU+vCwfDJa969V9ku/PsW0HSWgg=
Received: from BLAPR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:36e::24)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 23:45:42 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::35) by BLAPR05CA0019.outlook.office365.com
 (2603:10b6:208:36e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Mon, 5 Dec 2022 23:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Mon, 5 Dec 2022 23:45:42 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 17:45:40 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix mmhub register base coding error
Date: Tue, 6 Dec 2022 07:45:01 +0800
Message-ID: <20221205234501.875319-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 47054e18-8fcb-4b92-0d32-08dad71ad264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMe534mhSJUpnl7lcAkv8XZe5cjnx+Kt7SrNjp4lP8YhQ4T+T6dbHcc+cswgwLzSDXC6+XI5GG8H6kPQ1C2FDW2QitNyzaYxU+9lBLujaBcE7ZBFxXFKwdsIqyS9bgxnG/nV4UJWyA83kvxWmUIxQvuwgb5i3y9X4h7oLdAgJz4VvgL6XofvgI4+TwIIC3uareMGWYktoNV3xuXnAmvIk8YOVI8XH5a5jkqHpZUQ/KB76hGiKMrXDgmDoE2JhhRB9V98Qg+yxO+PHzAG9C3zIHtQq64JLM1XouIElvV/EKpuUmeYtCgC76Ez95m/iu/+BlAKOh4PfKmHmlnhxuhtkj9Bq46my1sY8AtIiZBBgF9WtN4zF1qb0pHNrQEtQR4WiDheNVILr91BoAYweVYCThrIGKxqQoHZdmc70Pv/1zZW9YtU/DTkH717Ohim0DPMrKLZ6tTty7nhAvvVnd30OT7XYmwiJ2T91Miajx295EvS6nmsLZ6g5wDdWhlSrA752NS8pfuHnmBteSLxf6Clz0T1+DSa40t3RybqbWijPQlXbkk16Hd2j0QmepMCqwKNcO1+uS/zrV1w4BpJcJOXwEAh73yz4BmRE/RTCX+aqGQ9JyP2m1xZFP+vFN55PeTIOqdqrr9TXl0wxJmICUxE/j3D5AC36nh3spPlA0oo7kntqcU4HGcoz1glmMrzZZ2WOZcxDUHgEedALjJng6YNWLUX01+hQE1yP4qMFMWLmdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(5660300002)(40460700003)(6916009)(54906003)(478600001)(316002)(41300700001)(426003)(81166007)(83380400001)(82310400005)(36860700001)(82740400003)(47076005)(16526019)(2616005)(7696005)(40480700001)(336012)(86362001)(6666004)(8936002)(356005)(186003)(26005)(8676002)(2906002)(4326008)(70586007)(70206006)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 23:45:42.4771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47054e18-8fcb-4b92-0d32-08dad71ad264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yang Wang <KevinYang.Wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix MMHUB register base coding error.

Fixes: ec6837591f992 ("drm/amdgpu/gmc10: program the smallK fragment size")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 998b5d17b271..0e664d0cc8d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -319,7 +319,7 @@ static void mmhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
 
 	tmp = mmMMVM_L2_CNTL5_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(GC, 0, mmMMVM_L2_CNTL5, tmp);
+	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL5, tmp);
 }
 
 static void mmhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 1b027d069ab4..4638ea7c2eec 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -243,7 +243,7 @@ static void mmhub_v2_3_init_cache_regs(struct amdgpu_device *adev)
 
 	tmp = mmMMVM_L2_CNTL5_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(GC, 0, mmMMVM_L2_CNTL5, tmp);
+	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL5, tmp);
 }
 
 static void mmhub_v2_3_enable_system_domain(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index a1d26c4d80b8..16cc82215e2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -275,7 +275,7 @@ static void mmhub_v3_0_init_cache_regs(struct amdgpu_device *adev)
 
 	tmp = regMMVM_L2_CNTL5_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(GC, 0, regMMVM_L2_CNTL5, tmp);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL5, tmp);
 }
 
 static void mmhub_v3_0_enable_system_domain(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index e8058edc1d10..6bdf2ef0298d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -269,7 +269,7 @@ static void mmhub_v3_0_1_init_cache_regs(struct amdgpu_device *adev)
 
 	tmp = regMMVM_L2_CNTL5_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(GC, 0, regMMVM_L2_CNTL5, tmp);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL5, tmp);
 }
 
 static void mmhub_v3_0_1_enable_system_domain(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 770be0a8f7ce..45465acaa943 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -268,7 +268,7 @@ static void mmhub_v3_0_2_init_cache_regs(struct amdgpu_device *adev)
 
 	tmp = regMMVM_L2_CNTL5_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(GC, 0, regMMVM_L2_CNTL5, tmp);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL5, tmp);
 }
 
 static void mmhub_v3_0_2_enable_system_domain(struct amdgpu_device *adev)
-- 
2.34.1

