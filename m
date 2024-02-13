Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7CEC4829D
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 02:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D093E10E490;
	Tue, 13 Feb 2024 02:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LRR/4T9k";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B9610E490
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 02:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUcK68peilNC+UoMoO3yNBthodr3reEiDhIkWhRwFAOno5IDK2j9NFL8lZifKubm7qa34VnNBRrsg/BAfJVebI8865qdC6ih2cBG4nt46OXcOB/kC3teft9OUH9jB++/VLbwSNZZEDjhduMRw9+ifBZZyLKlwHyBiw+WQn2LjwOi96RYhzkQ7gB3Ru5yY8nAVdPyP9yfjhtjOsfxUsLYO1UYL4TPRzAUC6jJPtrjO1nyId/m1yGii6VEIGBUUSdbEVIIZXz10c797qh471moiadvzVyduaS1XFlkI20A50dqCMgJMtsVEU5W49UD35ibdnXAxBSnVDQNT8rgAfJuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPV5fx4ZJtiD+PH0RHBHFDG4/WmaAfPG65m7mThr7lw=;
 b=bdxdsEQ63FwbbW/BoG7rsV+unAhwQNz2ejlDB3kbfa0DmKZycstGXieNoYaKdeXNvUAjJ+sc5aiSAonmEz2NSy5TrWAv/LB6aR8SdYckAK3VqTkLJ9qEN9uv0QGgwT6FqUyn4P6TX0NOl6/mMkuZdxZ6/jzPS90bDt33b/9+17Y0mOzK0t3WZzVSFzg68MF/+An7jUACEfXj0iqS+9TkU6wFin682AxFyERifkrAkRwQ0jEHlXH5O/7ncUKizb+PZq83cxnje4Wzzdf6QkPcCwc8EoSRff5CXk1NVli3OhkxrfHgs82ZwQ6eONVY64EN+1ldpfE4gBVKjkzdZWdqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPV5fx4ZJtiD+PH0RHBHFDG4/WmaAfPG65m7mThr7lw=;
 b=LRR/4T9kYLMeBChmbPXH4Jc/imLfTCrqG74jr2Oy7/pbZIbB9pxpLy3iXydaRKX2twEwofMqNaepSubmdIOI3XyOH082zus1VpmdWDmdh1vNGnVG2RxxuN04tBPO3pcx8DNKpgpiqFJNbys9l+mtQaLYuNkPvScYg1+zSljm+0E=
Received: from SJ0PR13CA0095.namprd13.prod.outlook.com (2603:10b6:a03:2c5::10)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 02:36:33 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::f2) by SJ0PR13CA0095.outlook.office365.com
 (2603:10b6:a03:2c5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24 via Frontend
 Transport; Tue, 13 Feb 2024 02:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 13 Feb 2024 02:36:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 20:36:31 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: Drop unused function 'static void
 amdgpu_choose_low_power_state()' in amdgpu/amdgpu.h
Date: Tue, 13 Feb 2024 08:06:13 +0530
Message-ID: <20240213023613.1420317-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7029a3-a499-42f8-8a14-08dc2c3c97ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbtX0N6MqnFHT+qi68HercrQm1dParqC4GxsUm9BlLxntWMC3zH502rJIAJeW1xca5wVjHxSlVkUD/w7T8ADLFvyl5C0SByalE3DFY+UgiFi75mW3CZpSfRP/rkKTOQvv5/LQX3hWOPn+I9IeYtOu03WvHwK7ytpBeLX6oj6Qc2b/q0uj5uIAy6PWRuM5kmMRJX8PBbMhXpzO72edVsEZq77FXIMsYnoKcrV7o5XKPGh7j3ufS4LFrGmttQpRUzJ9iZ2+oSJbXgvXDhDTtyYUEE9sm8k7n0iBWl277/6jb6OawrLMx/gtoOlroGNNwhC/oHmhdenevTw79yrmshJE78Z/jU5O9G4+7yaWozXMqTwAQObCOUbqGj0wiq7X8C79oBYLByupYp3l3QVYMRBgmTgSIL4yFpZomyG1r98kWIz8fgevcgWc7/+CTuSHPjASpg8+VS+OwwcGEJ0qsRv4lzmAawKADAQgSjL4icffj4inG8A24UoPvaDusBi31kx9QbdWpdQMokMJc0w2A60jY7AYdskhAHDIu9lWWXkUwAYvvYPwpOHDJDoJL4Vez2mvAmuISxAUVIDcX/8CoGYf35naWqopGmQeEZw98V3caQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(230273577357003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(36840700001)(40470700004)(46966006)(8936002)(26005)(16526019)(4326008)(8676002)(41300700001)(356005)(36756003)(86362001)(83380400001)(336012)(2906002)(81166007)(44832011)(5660300002)(1076003)(426003)(66574015)(316002)(54906003)(70206006)(70586007)(2616005)(110136005)(6636002)(478600001)(6666004)(7696005)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 02:36:33.4810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7029a3-a499-42f8-8a14-08dc2c3c97ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'static void amdgpu_choose_low_power_state() {
}' is nowhere used, thus drop it.

Fixing the below:
In file included from
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1559:13: error:
‘amdgpu_choose_low_power_state’ defined but not used
[-Werror=unused-function] 1559 | static void
amdgpu_choose_low_power_state(struct amdgpu_device *adev) { } |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cc1: all warnings being treated as errors

Fixes: c1251e31ec25 ("drm/amd: Stop evicting resources on APUs in suspend")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a3f12bae823..32ad5c49ab74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1556,7 +1556,6 @@ void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
-static void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
 #endif
 
 #if defined(CONFIG_DRM_AMD_DC)
-- 
2.34.1

