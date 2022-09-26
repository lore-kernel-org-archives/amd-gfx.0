Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D78C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 21:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304F110E7E1;
	Mon, 26 Sep 2022 21:41:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 002DD10E7BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 21:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCi6+qM6Yylc9vBkDaXD3dGG+f9YZtQSrj65tRTQPzXeEBlryccQXI4ymWqNh9MHPbsfDliP2zwXMoCdQbh5utaBMeQy9jAb6ni2FWlUwzlm5LF6WwHsUJ7YleLbxS4wzrG/ki94VP0tSnQL0Nqt1953UYBOAIzCSXPut8nc3+OPCjt1fLl1fL1tNscrrXWlo+7QZ6B8h+seysfC8U6gvcXsW/o+aLs75lnIcLgLxiHfG0yz51rmrATNdiRYhYULf6k5EHq6PxZOhceN32j6Rbg4hleDHvCcIww3dRuD3G5R7WZk2E5MeGbH/P7MvmPm3FGB2kybqfxEylGjUu7m5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOJu+gPL3/OkNs3wk4IQNg01Sh530Z1/1QBrTzsiX64=;
 b=HNUv2Rlpw0LIm6Gnq9jfhkfXD6tIPUWzQ2Jyn6JqEV23/zFd+uEOOTQT/7YKv6SaGYxsnCVwsxB8hORVNDAelvjhU9BV8WX0SFOdj0qPyKluwev+2KiT34ggfyR2M/vpEV8JzyGWPDuxM2W6mFHtoshT+2mifIiNgMYOl8+cDt2BLaXqoFa9GZePq2QrGX8LaZgw5tLyMbe0wxZ6LRO4UCNFUO35vNVmR/+Lpi/DipF62+6I/RQJTHJoEah2xBO8GGhj4m9fAoUI5tCruFkVSma0xFwCWxLhMu+PwhXY76iSxLV9duSdBnGR1VMOzRnj7/OOcZnGTu3Wxbnzgln72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOJu+gPL3/OkNs3wk4IQNg01Sh530Z1/1QBrTzsiX64=;
 b=AWPSOYCJVTNR+pdJJ98zsNLj0vXw69tBIlHnEvuHdTE/pGEaTEEhvvk65uRfKuVV2JR5A/4N7IpGGBUb0Kx35ZMb8UewZRqmKXoKx6jphiY1+9lScMnCVGprnJ8d+xR9vFycZdJ4TJ7szSvrTac920OAKbjjVUPTsACAZ1ZUBr0=
Received: from BN0PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:143::28)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 21:41:15 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::e1) by BN0PR10CA0027.outlook.office365.com
 (2603:10b6:408:143::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 21:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 21:41:15 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 16:41:13 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Date: Mon, 26 Sep 2022 23:40:14 +0200
Message-ID: <20220926214014.5450-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926214014.5450-1-shashank.sharma@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fdd5c6-d954-42b1-6664-08daa007d689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJdEbACmgciRRWhBOB2pm94/C1U/9SIU5FrDOl6sYQk5Gn7OwlYhgvVTQ8xmJyZXK6r8KWDa3gwQ1+jTfkSKAJGm9D7gZ5bFcuPAi8eQC10mHDiQUR35ON40Y1wsYIHFlEdRRqBa2q/r6uwV/O5g/X849B/exV5+Jk5N2I3ORWPd57uHZnE3G74fJ/5Ir/Tk2Gb7N5vaEZoWdi3QaiLfDTExcZn48LgPuGkIY1We/ys2Pe2AUIdQHiO01czo5Zk8hjOAehe7piYtoAWVAzQscQVh3vKWaJVsS+q4skA3MahRRs/otWqIWvmr+ZgSFtcGT9r4sv0KTbZTIHVtXa+ErzyKTDiO7YpQJs4kOswOw9cshmDHvOSAyMkxcoMmk17fp4qR8mcI42/nWdn4EentH7dGsvHBrmZp3dPp7FcqRchM/gvsJN9LplyIXWTjvHIV1echaPfIqjvSNX3T/ruxv8VZYmCOd3ufwf2HiZRN7XqDLjmy8wMq/RdvkGUquwq1EoQ+n+6XncpOcZWOhMz1pWpcSNxuUhJcOvQ9lalJcvL++G/ld8GlhvqO0iwysuWYpaIajeR/le8sRr0xGtlYf4cVQSCtePP7zAyh7SBUKoL9N32boM/oGlTKCz++a2oduTpBjkUuSyWxZUC+9XIJr8ZIfTrDI3D73y6FE1Z9OY6azSuenjgE9BzagjzpVv5XuZf9TntwbNnOXn5pml6GsiJKDntKqi1OrLEYQNd5SKXY1O7uLC2eZcFdEohu9x9ET2ux2T5+IdcO9jHw/O8QGEH2P1kP56BLkxWXipX415Bmxu4s0Pt9p9yxerB5hNwr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(44832011)(356005)(81166007)(2906002)(7696005)(40480700001)(26005)(478600001)(82310400005)(54906003)(6916009)(36860700001)(8936002)(40460700003)(5660300002)(47076005)(2616005)(70586007)(41300700001)(8676002)(316002)(16526019)(426003)(4326008)(83380400001)(336012)(186003)(70206006)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 21:41:15.0265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fdd5c6-d954-42b1-6664-08daa007d689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
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

