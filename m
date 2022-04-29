Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD81C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E972910F25E;
	Fri, 29 Apr 2022 17:47:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436D010F1C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i54KJigZheylG3fwjr8235Skkipo/QQSs/UwrrxqGYH37MQBrmk94byd9hWNiZip119qnr9TfFqrp+kLXTe0VtSHleo6rdngjveTOrswSX7TQu+F4DKfBPBS8U9sKD/xzcKi3I0ef+2mQELsqxY/WJdx6CRP91n0W5RRenwMcdt5P0pDXIY5k7VsS5z7JFZRWm9xVnlbffwR0V9dAvk5+FdAXFM1/WqusXmnkPiE3K0Ul6caFB352TegbDY7hKnkvMxVg0uxu3kec3K8tMj5uLNjIkyndZvJAOHFjG+IKLKL5mvOPBGeS/n7U2NSU5BXywDoT2RiilBlqmoCtwg57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHzHXWr7l8bR252N5TOBYtK8BKr5g0SbNecLjLHlyU8=;
 b=IaWLxVibrE2FsjHXiHZ2HRQ+v2cszy48D0QNr3zs9A3YuE7GPdmDrUosmk84Xq2tmM/oM3kKMK/iA4DbNx4jYURo2qUoqJf3Eltpw41VgWcDr71HyMHLZ80d59h+2RJuWHAemRFcgYbKskWnoA+qyE4fqHyxCQ4rMQWoB/Jr7M5MgzQ9qxgwSndKc5FZsOsx0PyKjFfgbKU1jWjDki6MPijGKYlA8qzJVFQoHVEVvOgmj3yk4+/2T3SI1x1h7RUPlcxmLkqmHGxYt+q7PAYs0MP+X1Uww//5oQewQH4Tg96n3jF9iWAq0nPk8na+BipMMPK6FuvOVPUNlyT4gJlPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHzHXWr7l8bR252N5TOBYtK8BKr5g0SbNecLjLHlyU8=;
 b=BOJJW1Bvq3dk8saVnSjJvKBvv3Gx4Vahi9D+bjHJRmXOOX5WActvgAcY4HfkJzgku7Nglio9PweYX5QIv56lHcUv9LBwNtKeZZ1Pjxgf750h28WxfFCsYth2YrfJU7v9SCyBvCjCZqrP9oXxYcW5lGDk1vdG/fO1YsTZXtvHIgY=
Received: from DM6PR12CA0036.namprd12.prod.outlook.com (2603:10b6:5:1c0::49)
 by MW3PR12MB4505.namprd12.prod.outlook.com (2603:10b6:303:5a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:46:48 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::5e) by DM6PR12CA0036.outlook.office365.com
 (2603:10b6:5:1c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/73] drm/amdgpu: add mes_kiq module parameter v2
Date: Fri, 29 Apr 2022 13:45:29 -0400
Message-ID: <20220429174624.459475-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 142cceb5-139d-4535-141c-08da2a083c54
X-MS-TrafficTypeDiagnostic: MW3PR12MB4505:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4505648BB0CB4B9550E0340EF7FC9@MW3PR12MB4505.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXngKG6DLxcaVnYakg0rcRa8NXuQ1rXJFTfLjSZkT8dNrdPF4uEdVLl5BxKqUMlUz0iNSn89NkDrJP9IJQLNQD8tABU+VRXlBM1+uIaDK9comPtGUV9qFY2dc2liB7WJJyjmVMlVhmXhGa0FnN9iDyn4VuqQxktC52r3Bd2GzacXOjKVA2WgLikFsOVC+fDPQimKa3xR+pwSkhfoeBkjQR6BtEsmBCexJFjEvNMc1dc9A0zPeTtlA/n6BNwI27KNqRebYeixGnhEU/NnBc4ELQY7NGY/dAIWtf7wmAZ1JzAnBYS+VVNYytbnQEPuUDm8rr+IRTc7Dz3MCrJ3B8JDyUc9lpkOFU4sr+jKi8pKzrvQw1BoMFl9Nm9O97G8RgxYS6sxFn7m1fUnuVmUrBbhlgJEkvGFAaW83oGzGMjXDe4McYdFLfNKAeEZ8ZkezKHRZ52kenq8OrERsqcLoXDZoNtK4z27U57v8OLK/8R5iaL4WaAHK1OjV2d2uygS04Mect4E9PpQhh9UlwS6qbWYmi1+lfiIfWVQDgR9oP1N2jTQRKYmMTm9xAWg10q9PUirZpsnbK+I1ypeZRHrOzv7mOigdMeN0d38ByzkjIgsXIpowGGH+Yz/rAcUfi4+DbeAcuZIR6e6qU22b094wL+sFA9v5TkFIkXuEf1n78N6XHsCaLHndQFebCYou4h76oC7spvYofaJQ8na5eLOPE29Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(86362001)(16526019)(36756003)(8936002)(40460700003)(336012)(5660300002)(47076005)(66574015)(426003)(316002)(36860700001)(186003)(6666004)(83380400001)(7696005)(26005)(2616005)(82310400005)(81166007)(2906002)(1076003)(70586007)(54906003)(4326008)(6916009)(70206006)(8676002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:48.5657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 142cceb5-139d-4535-141c-08da2a083c54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

mes_kiq parameter is used to enable mes kiq pipe.
This module parameter is unneccessary or enabled by default
in final version.

v2: reword commit message.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 10 ++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 24bce7e691a8..4264abc5604d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -208,6 +208,7 @@ extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
 extern int amdgpu_mes;
+extern int amdgpu_mes_kiq;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
@@ -940,6 +941,7 @@ struct amdgpu_device {
 
 	/* mes */
 	bool                            enable_mes;
+	bool                            enable_mes_kiq;
 	struct amdgpu_mes               mes;
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b9844249d464..b2366d0d3047 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3669,8 +3669,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_mcbp)
 		DRM_INFO("MCBP is enabled\n");
 
-	if (amdgpu_mes && adev->asic_type >= CHIP_NAVI10)
-		adev->enable_mes = true;
+	if (adev->asic_type >= CHIP_NAVI10) {
+		if (amdgpu_mes || amdgpu_mes_kiq)
+			adev->enable_mes = true;
+
+		if (amdgpu_mes_kiq)
+			adev->enable_mes_kiq = true;
+	}
 
 	/*
 	 * Reset domain needs to be present early, before XGMI hive discovered
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 80690cbac89f..9e72b3ec5d4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -171,6 +171,7 @@ int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp;
 int amdgpu_discovery = -1;
 int amdgpu_mes;
+int amdgpu_mes_kiq;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = -1; /* auto */
@@ -636,6 +637,15 @@ MODULE_PARM_DESC(mes,
 	"Enable Micro Engine Scheduler (0 = disabled (default), 1 = enabled)");
 module_param_named(mes, amdgpu_mes, int, 0444);
 
+/**
+ * DOC: mes_kiq (int)
+ * Enable Micro Engine Scheduler KIQ. This is a new engine pipe for kiq.
+ * (0 = disabled (default), 1 = enabled)
+ */
+MODULE_PARM_DESC(mes_kiq,
+	"Enable Micro Engine Scheduler KIQ (0 = disabled (default), 1 = enabled)");
+module_param_named(mes_kiq, amdgpu_mes_kiq, int, 0444);
+
 /**
  * DOC: noretry (int)
  * Disable XNACK retry in the SQ by default on GFXv9 hardware. On ASICs that
-- 
2.35.1

