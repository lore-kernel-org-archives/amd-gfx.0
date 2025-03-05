Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ED7C282DE
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3745310E324;
	Wed,  5 Mar 2025 20:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vejT+lSV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A89510E324
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMRP8I3vjPBkPW3eAbWCPzEElnFk6blcWLZb0aCvbpJx2Oi9m2TpdegDzhYbvWKfGkX85Oq7khBt6Yf7/lfDmK2rlePawNNoIKPHKcT0DXHKj9WSSBfQucY2dNzDUs6N8jMIS+8MRyBQ9Kw5ouWzs782/jlZSSoXUJLpO3W9xPWtQWEjMqibPhxEsWE2X0Zui8FmntduQrvc2VgTvjI8b+3Id3J0Vy1yse9rTkU/6LEFQrQdzCshSupHlAU0y1HqfODRMa6hQga1C68bGIk3qnasJ26i/djutd5UdACHF/xbGtiAP32rZBzkJ7ukabWgg4924vxFazcFxBZOycEJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmUvNb1ldd8IhH9N/+Ywv3leYzAn65ug5YGjerywkfA=;
 b=D7WNKWWoZtv4OYYdGvxAUDFDMzSzfMKu7WdiSp/GxA44815y2TTtOl0cqDJI4ZCq50ulzLlSer7N4SU1QO5W4BE2EuiIPEH0nQLI1/5hEIsCp2AFTxD/qPGaLbRMY9Luv+8jEG5H1gR9HzbPVxVlFIqQYjbaLrHcmeHdKIVX1qJUemRlWB7sjjoNn5fP4h/o7KdEY3uqT6ZUvnBwwIgTJk7tpd4Of6zuQUozOprdAVx/gkqvYxUf5df9sEjbB9br+nm1BLZL/ZMFULQxC6KH33z8ltjcXRwkXwgO79FPziotJM13020FfkQNPYxcvf4FP+OqMFO7+UYDb7/6gU5qUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmUvNb1ldd8IhH9N/+Ywv3leYzAn65ug5YGjerywkfA=;
 b=vejT+lSV1uJWj0zntqXGdAn3W3k92YEhseEYQop0Gi/4U45T5Wo1l2USOF97vT0FuflDl/HAtKkSw8rPbq3/wT3TocVsggdeaoimevOv4mTlZXodXfbkAzcUTa4BoC+KDdS70Tge7vl9n6ZXRbtKT0A/Kj9YfjcEEOs5Ofb0gLE=
Received: from BY3PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:217::21)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 20:47:37 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::9a) by BY3PR04CA0016.outlook.office365.com
 (2603:10b6:a03:217::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 20:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/11] drm/amdgpu: add parameter to disable kernel queues
Date: Wed, 5 Mar 2025 15:47:11 -0500
Message-ID: <20250305204721.1213836-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e113573-6578-40c3-f8e1-08dd5c26f6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8po4EZqZondkqTxjqGyh7csb2gEPIHD9GGtjE1kdoVSED+eB6J0OZG0eLMUD?=
 =?us-ascii?Q?3Fu4Pb/ZfEMhBkTEZJNiNnyQu/DqWt0rsNT+mrt9BqVQvS7wSYO9jv8nMoLs?=
 =?us-ascii?Q?GQat1ZY2FRPXKonU0/jHfDBT6hShxAPg548GuQChRuhQ8QbNtqa7S4vszTP7?=
 =?us-ascii?Q?vsiGMSSTst40i3Mmt44KppaHqSUOOusgVybb+Nr6Vm8FFnRPFctS8OHNZBSY?=
 =?us-ascii?Q?usAeO3IkC2N0F/JtJOil/kfJZ+5K74NjWmAYZciKaUsh6+QeHS4OQjqqIgrZ?=
 =?us-ascii?Q?D91LAu/GEnS7bVS3QrJXTFzI0fK0ABIwgfqr4W7Cyp/Vzw9YSsAF4np9xOf7?=
 =?us-ascii?Q?yN801ysBtIGNsjB4Q8APYiztunROjCiyFZCE5NRYhwAc21C4LOK0/I9sCNBY?=
 =?us-ascii?Q?hl4pd5EXcn54Wa39aJoH9ipeBOfAoGm+0WF1sm0zCB8Gijh82qjZX5OoSdK+?=
 =?us-ascii?Q?ImTfkIvWadFElqgXJT7uys0R4lBAkbnK3/W4bT9DX72yw5QJZ9qpupMkVJ3I?=
 =?us-ascii?Q?hXQ3l4kIALfTLNrRytogVc6wWB+HYXMRIcKxnrmfe/JfN6lIunMvbDMMOswW?=
 =?us-ascii?Q?0HGA59fthYGNtH3EJ7YdEowJytBQXDb1fQVdBLSBSVbrgf9piMUkKxpnUlvB?=
 =?us-ascii?Q?dqJ6IZk2Vg9RuR6XV6z3s+K+SYQ4JtADzUnlQ1UXaihWMPGGkadKxGwK8EpF?=
 =?us-ascii?Q?lFxR6cb+yIviJgKQImNqOC3SpsM9KhlDx7ymnOGWohJg8Kc/aKcSGKYd/ynG?=
 =?us-ascii?Q?iqbB2l0pA0buevZ6isXS5EbdroNMumZtDRZFKNPxzidg+pFhX8FXhLjYLCNI?=
 =?us-ascii?Q?d5SVYY4XHZkqIxY9OJ2P3lJ05VddRpny7xaUQ6Y/wPPSa2sPFgw/xPJ35VZu?=
 =?us-ascii?Q?SQDk+EYhnRAofcLQrmFahCXYvj1dp/ayOude9Sh7iY7UlsAN8qZnd/KdADER?=
 =?us-ascii?Q?L3JzoN2YQE7jZ1Wzo5KGwjGdJ46oCgpmT7X37HktEaPdQN4U+gOgA/Gaxbio?=
 =?us-ascii?Q?rynWDv6227wQoyt8SI98jaCm0O1JLDCSHaXaCi9+bumGRj2QsRtX+SJ1f/h9?=
 =?us-ascii?Q?MUwN0wQPeo6Q5JM7W4TdBtkinAD/Ax75HH/bJIiPTtfNrYgdldnIHUGxaloc?=
 =?us-ascii?Q?Za7jhLbhXRLemQIojkCU8uaT9w4ey+e1AkViMNm2VNEj/Qcd4iHIrO8i6OEy?=
 =?us-ascii?Q?Xokwy2MuJklRcCluevbhSSrPIrhuqobDJ2F57wo9gqaHwzrCZXYqNHb5x84G?=
 =?us-ascii?Q?E0Hymu8N5uwG6XfIjhZaWrnxYluRrOJCDRH0Rfktis9/Pg9g015gUNyeAJqy?=
 =?us-ascii?Q?31l6YpuwECWIedMTwrNg7C6bUOiOmui7tDR+IYoAWi7YwKp87iwO5ogl+O+B?=
 =?us-ascii?Q?yKMcV/izp/WWnAnz/F1NJ8fMwcyTUFf4j7rlA941W1BhrTDLKan8xGPoMkrr?=
 =?us-ascii?Q?/VcHfRMP2hmLkmr9RPY/P0WjW6fJ4ddH9FG6cuFikZW7pHqArzaNmx5zUPEi?=
 =?us-ascii?Q?fqvAWpIh1sJu8sI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:37.4071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e113573-6578-40c3-f8e1-08dd5c26f6d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
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

On chips that support user queues, setting this option
will disable kernel queues to be used to validate
user queues without kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 87062c1adcdf7..45437a8f29d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -270,6 +270,7 @@ extern int amdgpu_user_partt_mode;
 extern int amdgpu_agp;
 
 extern int amdgpu_wbrf;
+extern int amdgpu_disable_kq;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b161daa900198..42a7619592ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -237,6 +237,7 @@ int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
+int amdgpu_disable_kq = -1;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1083,6 +1084,14 @@ MODULE_PARM_DESC(wbrf,
 	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
 module_param_named(wbrf, amdgpu_wbrf, int, 0444);
 
+/**
+ * DOC: disable_kq (int)
+ * Disable kernel queues on systems that support user queues.
+ * (0 = kernel queues enabled, 1 = kernel queues disabled, -1 = auto (default setting))
+ */
+MODULE_PARM_DESC(disable_kq, "Disable kernel queues (-1 = auto (default), 0 = enable KQ, 1 = disable KQ)");
+module_param_named(disable_kq, amdgpu_disable_kq, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
-- 
2.48.1

