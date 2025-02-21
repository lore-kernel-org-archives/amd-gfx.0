Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3296BC021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 17:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D8A10EB07;
	Fri, 21 Feb 2025 17:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3mZO2fS";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACF710EB05
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 17:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRhIBTlT8Q0j1GpLEvaogFBPa3ehJ0PJjbFidZnYn9pBBK3UyU1mKyZw/6hdg1j7B2lkI7y+eM6G/JzPwEPa63yOxVJlOXrpVX4JG7xb3cB0Tml/9LRkWdsQR7WlRfsu9fkHhv6/p9kcXw9togbfWx6mtWKsAPcEwJlTX/+p6AHYgIBWSnBKJCi2KMWtVpx3puy/z6U2LOFk5GOZ/8jj8aHDcAJJp2+sBjMWvOzB2+QpyT2uFfsbxjy2JxGFb7rDTY/4bUxySG7AQapidOz0USA2riovLpGcvOb4zNZcSKn5z215zPwv+jYa6xxXdSsWQnUpWkVXV+xsKREOICfTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neUJlBhS1y8F7+X7yoDNS/u9mKbHEBxhMTF1H2TJlck=;
 b=Axv86d/wMVOBS8ZYHgdJwFh5c25QZtbW80akPuShXdhn8MxuRcLfqfo4xG5OGNezOdx9iT/2vMsH6TyIDpf2mvSM/7YSsKrROo8Wu6zmgt8bPd/fR6tis7g06UVIumZCnBBV9amVbTdYxIwAUrHdJwR2F9VNL4XlcQxUNijD6D0N3B9ZRlXTHa1p++e07awMFsMHPALkWouqBwLzx4ym8c7MUqcfInzVzhR+BGwyhMz2q/CAEeKrn+AokIGoPpQP1pYNmp4OV59R2ddlGTgql9HaSq5/qs5gmrEYTB8pd2/4w6fI9qFEA6UxNAMdJ9djo8mVmj4kpWiWU3r61flZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neUJlBhS1y8F7+X7yoDNS/u9mKbHEBxhMTF1H2TJlck=;
 b=C3mZO2fSYULyKKZqciOJmTarEThEHRKcx5fx/c8EpRp3ghrcn7TAjUPhPvCJwh0v3gfsx883j/jM9bh25uRh8/v6uOr4oT9p+oZ1/zLAvpM7ff7hyS/l67+Ty92buJbG1bjRjV8qjUqXxfP5sEi9ffYRJ16misSDzWhtfeg2TsQ=
Received: from CH0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:610:e6::9)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 17:10:16 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::57) by CH0PR03CA0274.outlook.office365.com
 (2603:10b6:610:e6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 17:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 17:10:15 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 11:10:15 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>,
 Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <Harry.Wentland@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 1/5] drm/amd: Copy entire structure in
 amdgpu_acpi_get_backlight_caps()
Date: Fri, 21 Feb 2025 11:09:58 -0600
Message-ID: <20250221171002.209895-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221171002.209895-1-mario.limonciello@amd.com>
References: <20250221171002.209895-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e21b16-234d-45b9-8d7b-08dd529a9c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vQXXACPatJ0K7ZRafByu2codvjOMyJDEA2bt6dizwv7wKBwu/mU3oQJN5RRR?=
 =?us-ascii?Q?EcAwOjdrJ9PFTOpIyrmUVbhPosXYGMd2Ln8wPoSz+8NehWCtEmjhoUhhiHI4?=
 =?us-ascii?Q?l62awZRxWWWI0We23bBdlGa/jQjPioCoWcPtejQ3xcRQpwD6qJ3kR5kQAFzb?=
 =?us-ascii?Q?pwiWTVuUYbyKFTo8jvROlVH6nGmcEQCCcomqflme+SseOreJHc5sL/ESrtpX?=
 =?us-ascii?Q?ZdZ9Kea/4b8eo3KkzYy0pf/4Tq9NDoWmyO0UnN4WGPIwzLzy492nZKtCVmFZ?=
 =?us-ascii?Q?JBgD2bMHplX+sbprr1Ch2D/G2XDPglOOxkvoqhMolIHr7CZoXozVwtjbMFbu?=
 =?us-ascii?Q?8zel1yr1716n5O5smEqShk975COfSY9Ab+5eZ2WY7NJkXZ30Hk1XMgYlmwZy?=
 =?us-ascii?Q?W5Gm7fqb9HplNux0yea9Mo353EhlFB1gKh94RHv7QbICZ6IgH5eb1nwsJC4P?=
 =?us-ascii?Q?JFwn5Zzun9elb9hHQvMN3DQ0WwHJ8N0FiHPvxiJAGU/r1ZaBrqFYbeIlrlB0?=
 =?us-ascii?Q?KDnfozKg4wi8Jnq3qNynuOd9mITVrxtlx0jRDkmzoLiBUdv6CDTMtNZOmGmL?=
 =?us-ascii?Q?SNNQG2alFsiGqiVAiQy4ulL5Zn9608U4IZfES1iMFbu0dpkhi2lAZdhLEON+?=
 =?us-ascii?Q?/KMdRaZVkIsVTubhb3so6O3TQ/IWb/51EjKvny8z4qDr7qBp9bSU6HL0qeKw?=
 =?us-ascii?Q?6rcIM8itQvH0WuwcFPLek84NfcxT+SiCfy73isEPXygvJMm0ZW3T5h+bbm9W?=
 =?us-ascii?Q?oo0Hz8EN13OH/vrhI11EC+fptQPrUKFf2wcRldRj+OsYDES1yWG2Ha4kUMnH?=
 =?us-ascii?Q?5IbUShbc+68dCyORFE0lqO0etLV1wjH2AXR9W+kFgeEddB4+YQ/whYkarqVV?=
 =?us-ascii?Q?dFfgcrSDXJNgplLqLz0IXetLZdfng0i6Y67sTbZqpNXsTth9SGbeZGBFSCAt?=
 =?us-ascii?Q?orqH7dDhVrhwQk9/5OdNn++l4B0W3FyXrSeX+DY0W8mzSUHY2fxMUBluret+?=
 =?us-ascii?Q?c6tresyukzj/IHPD+XJbfkJ/XMs1HU8JG7BWUF8Lvb/vgmfhLA4JsIYvfXua?=
 =?us-ascii?Q?tEESiIo14zoK0B6jg/LvYVEzh0BcGsPxyQqn9Gtn5aIKbEcdZmBPm9Ja0wVS?=
 =?us-ascii?Q?7xuui933FCuxkLYOnApPZD51hsrlKWJ3gY0pbj0Q8ciMgW1B+YunQjwFnXn9?=
 =?us-ascii?Q?RRrK6oxwIsGefx/WfBvAEUNMXqEU0NBr/n/n6DuKPw4mXeCQnHyknepELJfX?=
 =?us-ascii?Q?hkLPUv8jnD1vEu0dNkRnuaDUSfTD9brfHOO1AYitvIu/ger+uOL7Grutptah?=
 =?us-ascii?Q?qGNESi6pisDPcKopNQpWFHp607tnTlupoFpJSIgRcMnJ8Svwr/nXyW5ioDgX?=
 =?us-ascii?Q?LaK3HXCk9LMrjcFem8HzKzxiS43DZVKhjAjnFxS83gUx5+GHk7EdmE1DHfjU?=
 =?us-ascii?Q?3T77GnKDleD3bRbJ7BRvoynV6WMXr8+zaVe2rcPhrk5EMIqTwBewK1Bx9A2I?=
 =?us-ascii?Q?ctJlyD/q0/2Z2eU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:10:15.9637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e21b16-234d-45b9-8d7b-08dd529a9c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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

As new members are introduced to the structure copying the entire
structure will help avoid missing them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b8d4e07d2043..515c6f32448d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1277,11 +1277,7 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
 {
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 
-	caps->caps_valid = atif->backlight_caps.caps_valid;
-	caps->min_input_signal = atif->backlight_caps.min_input_signal;
-	caps->max_input_signal = atif->backlight_caps.max_input_signal;
-	caps->ac_level = atif->backlight_caps.ac_level;
-	caps->dc_level = atif->backlight_caps.dc_level;
+	memcpy(caps, &atif->backlight_caps, sizeof(*caps));
 }
 
 /**
-- 
2.48.1

