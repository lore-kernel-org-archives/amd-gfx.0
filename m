Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A783DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 20:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1810310FA15;
	Wed, 15 Dec 2021 20:45:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A9D10FA1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 20:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEuT6Arwt7uyN3eRd5RosKvbu4rESVgB2DGqvlhBGp2urhPqyxIWvxUk+DKiJhMeyX2n9MTSeVFdLR9MvHmtc1M7MJ5J0C8joozZ4D0TTdTrj8Cyf/JQkmKzt/yFyH5bQ3Ml9p7UBvJxgyJAWag8xrBW85cl55atzh5snDok5ANhGUDz7BsK+oETJwsWYw7pyYf/ZI3jOYOi90Ca6wKIkGw6myCNR7fTdtd+98QXzSoBQ3En18XUijrV7zPI8MJKSraAtg2oyiafYliwcjsMSwvVumi9EJAG4PO43IXxIJgzziL1upGm5gqisjHIJNK7ZLmGphhOAvFkQo+jVjltxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CVl4dP6+/nyWDK4eb2VsNkp8AutsLvDHwzbS7aHVKM=;
 b=i1+hc1O7ggkOeBA3XMV7ZClxt6lczoMabY70V4q9tEGaDe9Oq/0W+4NrLYcyx2AIZCaWUYax1y9wzjQowtmg5h9mbt5MLZKRfVw71M4rWBnvHAtRxZC/gHMAdUVBmnb2ACCVwhgE8aQQm2me7d0Tq2DUawNpIpeMA0004LZSmtwk6q5eJyAs/3/1lGnjjZ1p0hW5Zx/4oGD9nNR3YeIra3AdT43mXX55zXVsQHx8p7bbFhhGLi0BeJEIJx2xz7PpQ9IxMrnbe/luqdJ7nXvC6uuHdVBcst8rRd2CMhwpZGw1RRR+DMUhLzWbmxko7622SdZ8yIRDlF3d0T+XxbXOXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CVl4dP6+/nyWDK4eb2VsNkp8AutsLvDHwzbS7aHVKM=;
 b=Do6O66qDYJLnIdbWYmmrj8HGewXxTtC8kJu6krUAgKdgdpJx5VAqyCjhYnYmMHKL0//aKTszPAWsd8xeaD5Hmfb16Q2te2S8rF/SKWWqHoq9DHiKbU1XLyCIGfdYk+wG1mqb0YNpT9XnGQOLR/eNiaUeV9gEi+mn6+IVLAqO5fo=
Received: from DM5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:3:23::15) by
 SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Wed, 15 Dec 2021 20:45:04 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::2c) by DM5PR13CA0005.outlook.office365.com
 (2603:10b6:3:23::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.7 via Frontend
 Transport; Wed, 15 Dec 2021 20:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 20:45:04 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 14:44:55 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitions
Date: Wed, 15 Dec 2021 20:44:35 +0000
Message-ID: <20211215204439.7216-2-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215204439.7216-1-victor.skvortsov@amd.com>
References: <20211215204439.7216-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16fab872-842e-43be-c7eb-08d9c00bc5a8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2382207D3ECA030A05AA3CC98B769@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nbrfj+EPUBl8lwVc/wwXTuNdsnpINyUtAPnl2UEmQdUD7GmImRDRqCGoCwqTtg9hVzaeDxDHOom7Pv5L5Uo7poUtjBf6SQCiWx8RdGQOgI4RJkpg0KQ63ZoaSj50fsTB/CzvQkz/dccKLL7U0Lx4XPPS3Hag6FjXU/MZJVRepkp1u8RRk4FfPZdIXb/kwq9lIJmnBDrOuQiz8wDyu5SYQ7yqhY6hf692P84XmWkitgfjhIJptwa5338xwss3+qXFZCbdLjCactwj7CszvR0W7bA0i8r4e75ZsD0HGrOxA9grIMN2qqAImx5FXyFRPQ+Ut7/9XNxohuWj2PhZzDiH/JQ0Cu4yJ0u9zytf1z1NCfxTFYmVmqHl0N2b7HIW+fUZC1CzflM9Y5jnQZpW33uur3yRTcSepcNF2fPH7fqizgGYqdP3KbrTf0+bwEu/ieUUVvKfPkXx3YkfAaaG2eLuvqjQZPuhD3LNRk/aq+S4HYGa63oHcLCzWYXF3Or/9X9E/N9/xkLkVwYwwE+OBQSBJR9TKt+w4WyllZeOIVCj3XeipbQx1MXhhn2SKdCRy9P3vtvFfwlQSbRc/3j9yKV+jmWOWg4rPHrnvSmbKC/mJtqtimibcxQmIQxNONjgj9MkSYtnmV8X80MhNfJCi6Kbw/r/eZ19tKazbghJ+Cs1ruMp6heMWGfwWltWynKD72zaZ/+AW94OhaWaCUE4YY+c2Pr/IA8ozAzEahpICW/lw6nAFslE6fId7divKgIYW3jyOkRpUd+dUfV13J2nhNQLVDwmN2fyphAeYXNgpomN7jo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(16526019)(508600001)(186003)(8676002)(70206006)(426003)(336012)(2906002)(26005)(70586007)(6666004)(8936002)(2616005)(1076003)(5660300002)(36756003)(36860700001)(81166007)(44832011)(83380400001)(86362001)(4326008)(7696005)(47076005)(82310400004)(356005)(316002)(40460700001)(110136005)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 20:45:04.2118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fab872-842e-43be-c7eb-08d9c00bc5a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add helper macros to change register access
from direct to indirect.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 8a9ca87d8663..473767e03676 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -51,6 +51,8 @@
 
 #define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP)
 
+#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
 			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
@@ -65,6 +67,9 @@
 #define WREG32_SOC15_IP(ip, reg, value) \
 	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
 
+#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
+	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
 	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
 			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
-- 
2.25.1

