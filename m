Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CAEC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BB310E6CA;
	Mon, 26 Sep 2022 15:03:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A05010E6CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ1qD3W2ufuZU07g46Q37wuREYtEyTwjVmcVwG/MuGHeh3cRXGuGnccMHx6HRdosf7JirFjoM6xCyK2MEUvF8nG4tsWckSWq2xMc7eps8oMdKRreS6HLgpXCSqfBD0EPl7BBzZXzXKZ/YEBZk8D6mDMiyZ4fHiCZ+v8mXRoqgKiIHbBKyCxzhBTn5BDZFnN4pSPjkdHAHb4n8SElm5YjoXIdNT+4E9a4UpRLNgGM7mDRUzlGlXCJ4K8BH39B43nEWEXobFI4CkfzPQCj6Erq75xHQ/g4eLT34N/GZqzaHTPOTPB/8sqq1ldVMMXXjlX0mRevzFNJ5wvX4t9+XdcZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOJu+gPL3/OkNs3wk4IQNg01Sh530Z1/1QBrTzsiX64=;
 b=HhAmzYcwvjwcbUF4XN3UZPGsy7j1yud1/B+kh2s24Ix5fD20exQ12+u2po/LMAQ+ms4WwLxLlOBeoK1/MJf+9qTNIwaQowV8p8gYX5MOJhDf/c55e++KMp1/0J4uuMUNvVLeNmC0SAQHJNioJuub9GjkEuDfk0suFg1MKTH8mSIsHoIKwO9AWOFxK+uJU6/M6O3Ovujx1SajVRR4bno09mRbLAyp0F4dTKH+lvUN2qGdKTJAQo6fX5oo3yGYek4hlhtv8ezUAuYR5WsCJI/N6X/OA8l+J5xctYViyKnasHKJnEoGUlBginCNEXNcIP6yatOXCDqKSvjbekaBN8dgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOJu+gPL3/OkNs3wk4IQNg01Sh530Z1/1QBrTzsiX64=;
 b=lfc7k+fkQoTQWUGiRm27PyzM5aizL6sdKYDkUnddgMkv2GY/c13XEgIlDruq8T7DKAq78wF1UC1mmMLDm0e43ob1HOpOohjtd8em7v6xpWY/lRjqFY/LCpm9LIFBv4PDtoc+KjwPnFQyEdP77duhCQ6QBgpRgxWcmverAAwDEFE=
Received: from MW4PR04CA0379.namprd04.prod.outlook.com (2603:10b6:303:81::24)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:03:49 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::42) by MW4PR04CA0379.outlook.office365.com
 (2603:10b6:303:81::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Mon, 26 Sep 2022 15:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 15:03:48 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 10:03:13 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/5] drm/amdgpu: switch workload context to/from compute
Date: Mon, 26 Sep 2022 17:02:52 +0200
Message-ID: <20220926150252.18635-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926150252.18635-1-shashank.sharma@amd.com>
References: <20220926150252.18635-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f3dd36-72d6-42bf-fe5e-08da9fd05138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJJEQ5U4VTSabgrCwRPEYa8p096hmzBqtTYyh8iCTXuoAuX+vm3wqyavvipgSFJq751qaA4uXrl8JOsZ1p2m/y3AXeY14LKn8R7PQ09FUl9QRyqh+t0sITXmL3uK2c3Jy1Sv7qF+zfRRkJtUSlxeOzV3j0Ye8qZ4rTzih1lQT1zRLFthyaKTOOUgATKHn6I13YH3CbT3o49gVx/Hgf5k5wr/9CrKIj7P1s2r9lzPIngXqbJWNakiZwU7U4cMkZuFRM3fK3MNojC+5PriCbxyizu+tLIBMqM9e1W9jioK9zs/tSkGLStUaXHfXb1gn5wrzuIFpKOZIdxSzy37da9zgw6zJCxFyCEn9HEpxdrt+JvtS0flHfJ5r68fAhAV/ude6l0uduWWBiS0K+WUU/HC/k/evTxxdvtDEiWuz5lAhAY7D2/IKCSqM0m4tUBQuPnqkhp1b80ThhTX67UN5qbPpf2O63g2o2dpJLkUGGUGAqnOYzA9GWwwM7PisL0dNhAanmArzcMvC7FAhfjl5ALomlpZlKt9BWDRMjXY0jL0wHAz0sz4Ow6QummkZmFImHtfsUJ+JoJV/lhBsSRtjU+E4V2tpycX8+fmKRnQrg0hdGLQXIFq2G5lMNEu0wNTnlL0RQPZnsRyjnqiwNvlTJqV7gOfytBjC7S3D8ZfZdf0wYs7MbMfoGcQhhSlqYqhnKQYOhjxlNjVOvW++x3n1E1/5Q0xMMEPDbHwUQHcY0S6Ovo+g0IcYeT8ZcEmwUPFmikBzav6f1NwyCIZIGVtU/PQRkdrfyeFVkUqDOZ+nn9dLfpnqbU6XbDBwMhUAphq8xZH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(7696005)(41300700001)(6666004)(426003)(83380400001)(47076005)(2616005)(186003)(1076003)(336012)(16526019)(26005)(5660300002)(40460700003)(2906002)(44832011)(82310400005)(40480700001)(6916009)(54906003)(8936002)(70206006)(70586007)(4326008)(8676002)(316002)(82740400003)(81166007)(86362001)(356005)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:03:48.9175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f3dd36-72d6-42bf-fe5e-08da9fd05138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch switches the GPU workload mode to/from
compute mode, while submitting compute workload.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 5e53a5293935..1caed319a448 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -34,6 +34,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_ctx_workload.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
-	amdgpu_dpm_switch_power_profile(adev,
-					PP_SMC_POWER_PROFILE_COMPUTE,
-					!idle);
+	int ret;
+
+	if (idle)
+		ret = amdgpu_clear_workload_profile(adev, AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
+	else
+		ret = amdgpu_set_workload_profile(adev, AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
+
+	if (ret)
+		drm_warn(&adev->ddev, "Failed to %s power profile to compute mode\n",
+			 idle ? "reset" : "set");
 }
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
-- 
2.34.1

