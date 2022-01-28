Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE829C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 06:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABF110F923;
	Fri, 28 Jan 2022 06:54:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0C810F921
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 06:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrmLbliA2TVXD9mcAJf5j+hAQ7+V+ZbPvYoX/qSNmbnTRuC4+ns6P0UKzXGfAzif75T+xm7Mj1Tj1GSdpl3xMsc5ZIWyX41KtSH8ZmGkQMme1EbT3ZoX3X0mOV5lTpX1kewA+Vkdbfjmfjzz5PizNj8LFU+hqj/kuMqCnKyWhytToacwIITvQg5JciA3CPRtUjEvm011RxROwykoxR666bs4h1jZrYvmXtXNc3kASl6ZiT/CjycfyFMuohC5IKZADBoewFTfUhrpMBtb9gbsWN8L5GB7h+aqA70WwmMlfbz4NZfyzfEKRaU7eC8RvIsme/8ELMECw2WgOby/FRD6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tFCNV8P1li7xIhMtxCN44RHN2tM26CrynJfi5Ezgn0=;
 b=DSBx7zWgoSjfAi954FUnbRfu8dQvAAZn9D8bF4zsLssrAbwXSWRFM1R430ZwjAiO1y/xLP5W6OENHh07tJD7C+gn/rvbT/MqiwbW1GZY8duYXI1DfcgO9eyHdYQ6z+THYU3ZzrsmjTEHcS0mDEEAertNgWmY+qyA6cszJk0WpWZw9u+dhTD6+YoykkQT+rQNbweSrNST9QOtG8JY/wvMZmF13qlmx5TNZ96UR8ihTN2o7qVZbCp8+Ts+HeEgsbTUyFP2Dw7QxpD8cb0wraLx+UrHFOm5Hr1yNKZAv3s2iadgLQNMFJvO44bToS+A2H3UwODhcOU36RyBDxWwl3Adwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tFCNV8P1li7xIhMtxCN44RHN2tM26CrynJfi5Ezgn0=;
 b=S7qUwT8JHU2JgnEMFhDZg7/juyIHkXSo0ZSeHcX+vyxwaqBzYbV3L9SqPdit9sPYIVRguy6nw/BBu6jqWBu6+X2seKoyzVrBw5leFa0cigv4do8YpBN9JcBnMAgJpj1QmsRcIfyXfcb3cLjukYKTUQFEZ8KOjuC013p2sOwGaO8=
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 06:54:38 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::8a) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 06:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 06:54:37 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 00:54:34 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: add safeguards for querying GMC CG state
Date: Fri, 28 Jan 2022 14:54:09 +0800
Message-ID: <20220128065409.1479854-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce837c85-e76b-46dc-c054-08d9e22b0cb4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5029:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50298A6AA2545E7EFB7D6648FB229@BL1PR12MB5029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0dYXfcvS8cQpZVBlyv7Nj90WmFu8Z8gublOejJZR3IUk5khWlsS1EW11OYQO/6XVKoXeRv2Miyrgld4UCjkVMfN/n8DKUEFg+w+2QHEK/PUOJ+pxS0P5pi4znoSH0SVpinquO+Y3lopRlKo7rht7/rOHR6RNhC9ezNzmoPUNanDIJZLe0Blu85mQYCuP5Z8bB1fGyt6jWTRw/z2I5CsWUM2GskoZZ8ENLD5ABRhMAVjfH98WVhMnXZOjqg945MDRhYuu3/9/8jnm/o71ExAIBHItawZzR11AU3XZMdgBvT5Oer25/3mjRtoCOUsEEYyZrsNnTblWWqt52heUTsXEUO+4BAeodUD+fYw9aiwsIaZbZfZJ9/Wk6gdMSet5y2DcMzDdI8KYQnPwZzXwa9H6+4Uen5JCR/LTRqV+4cMrZ67lse79Z2ldZ6aKr6pGQJpAErG3im3MuW4wCufDdj/14wJWuPPRWH/ze518EeJtm+BJetErU8el2D9Eqid+hSiV1MTj7SaLiXUj9skdrjN/4Xp1s2rQkyCBCBsa8N6/oxDoI9/R/QAV6szkE2QVHn87/Tkja27KPiYTahZjv6xxqMUWDjX+J+3qwAnvPj1J4HCvi/k++lfjpnlrP6RUG+v0GlnXOQw7pcOwmZgD9ecbteWJoihX81jltcKuuy2wlp9yZFr9zd63io0allTMZM1dSQpYGepHf4xbhG8bYjjvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(6666004)(83380400001)(356005)(81166007)(186003)(2906002)(336012)(70586007)(426003)(2616005)(1076003)(4326008)(16526019)(70206006)(26005)(36860700001)(82310400004)(86362001)(8936002)(508600001)(47076005)(8676002)(54906003)(5660300002)(36756003)(316002)(6916009)(40460700003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 06:54:37.2404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce837c85-e76b-46dc-c054-08d9e22b0cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We observed a GPU hang when querying GMC CG state(i.e.,
cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
skillfish doesn't support any CG features.

Only allow ASICs which support GMC CG features accessing
related registers. As some ASICs support GMC CG but cg_flags
are not set. Use GC IP version instead of cg_flags to
determine whether GMC CG is supported or not.

v2:
 - Use a function to encapsulate more functionality.(Christian)
 - Use IP verion to determine whether CG is supported or not.(Lijo)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 +++
 5 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d426de48d299..be1f03b02af6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -876,3 +876,13 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 1, 3):
+		return false;
+	default:
+		return true;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 93505bb0a36c..b916e73c7de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -338,4 +338,5 @@ uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
 uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
+bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 73ab0eebe4e2..4e46f618d6c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (!amdgpu_gmc_cg_enabled(adev))
+		return;
+
 	adev->mmhub.funcs->get_clockgating(adev, flags);
 
 	if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ca9841d5669f..ff9dff2a6cf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1695,6 +1695,9 @@ static void gmc_v8_0_get_clockgating_state(void *handle, u32 *flags)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
 
+	if (!amdgpu_gmc_cg_enabled(adev))
+		return;
+
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4595027a8c63..faf017609dfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1952,6 +1952,9 @@ static void gmc_v9_0_get_clockgating_state(void *handle, u32 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (!amdgpu_gmc_cg_enabled(adev))
+		return;
+
 	adev->mmhub.funcs->get_clockgating(adev, flags);
 
 	athub_v1_0_get_clockgating(adev, flags);
-- 
2.25.1

