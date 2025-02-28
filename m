Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846C1C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 10:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB4A10E0B6;
	Fri, 28 Feb 2025 10:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="deOPNy86";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9EA10E0B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 10:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOmc0m+dBYQjQe9beBR7BXZkEIivTXGNCM3wyrdnuUv284bQrfZO80++L3L1uRxvPSRnBn31frkmhAlWeWB6wTlLNlMklLro8q0SsLnJ1efqehh4LsLe/F6HBOYZO2SqNO0E0/WXWcZYpVNDMvNq39skDv9PE2CSsefVZDVkOzmrpneHtD+UbOfW9y5gOu8IBkyufLavDgB0KmIUtwpvJcZ6iR4BUq6IqeBPe6iiux8MjYVCSnjCYhU28oBnsYoFdWdW1EFZ//WYc8B/D3e/4ekm9giLhE1OFM+h/GoR8PlJ9rP4Pj8eGyP6BdueTzD7CK7C9J9lmLtLyWKigkB84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4XIsLcNViRrN6l1IdRgXReVzAG9ujYjIaufZuCcL6w=;
 b=xYmOFvAUj4fLAJ+OG9rQhZwQ2YNbcQYRy+3sfPCc1nBkkx0iwEzxbUqNCUrL3bLYpSzCH/Wt+h3gIgKrCC3wAdDlx9xsZUTEjQr1f+m9OxtQVH6tDQQuwBboxyMfUHzvfFLlMZTtH3DVu7EBOJP72LR0HQVfUt0YN9WXhtbLUqkwl5ELnQuo/WgVdlqxP92HWyErx6eEdnSu9xzPuxKKSIGfcJw+HKJ02zyYQsDYGkGQSHrkkfw+lwHDTzIEq8a6DVDZylRKP6PT+MITk8/FuGULXZ5TGroUDfyca8C1T/Ik9zRyU9GnFXu9O8oS3CESkuY+qP3vN9HxFYvWGk14Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4XIsLcNViRrN6l1IdRgXReVzAG9ujYjIaufZuCcL6w=;
 b=deOPNy86wofP/8C4DRtMPsk1BwCi8dttKUD1uNbF8Xqv/iBKrZedjBTW4t/PRanFJl+5WjzkZoAIC6kkueH90Ns6vKDsJj+uTJg8VlMsKZpz8PK3sy7KVz7Ew/3I5sJlKF713tNAo+7RrTke2tXHTKAfj+Q4l5vclAHgZEBymwQ=
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:27:35 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::53) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Fri,
 28 Feb 2025 10:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:27:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:27:32 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:27:19 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 28 Feb 2025 04:27:12 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH v6 1/3] drm/amd/amdgpu: Increase max rings to enable SDMA page
 ring
Date: Fri, 28 Feb 2025 18:27:09 +0800
Message-ID: <20250228102711.832036-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: f5283590-3a71-4010-4dc9-08dd57e28456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2pJNoI2dArBJe5TETacC88YUczNJb+GyjG3PXC0ghaR39jECImwttOCnaMgG?=
 =?us-ascii?Q?trXaQcEWKXNFfLlZEoaBSsO5MaY9u13Wd/GjJFy26Kr2vNUhQUSy/DUipHTl?=
 =?us-ascii?Q?/5WEiAnJNob6hSFUArWlNczwPGOJYP2tC3/eiTRR1OT3aZ46xxR2fxT9bAxJ?=
 =?us-ascii?Q?7GIIS4o4UUlfphwXS2xkr7kJSSZYNJtMgJ4AnOV1AOTdSmFO5nWH40EGA6Ut?=
 =?us-ascii?Q?nTQkrIP81xCQK+mHz5O4w1+w3ANn0u2soqFjk003QXW+PtpEalwEfu1D5oBQ?=
 =?us-ascii?Q?gcX1ipb4jGm2oTj3GiAkZW6pqx6NguIgx0XlLbHGV3PPmdrFF0dNpTu5hMrG?=
 =?us-ascii?Q?2SUhj2PVb3tYrbJ5ikMJj5bIUJFCDwB6KVMAUqyDsAQQlGjCjhzrg/8zR75A?=
 =?us-ascii?Q?rsZ5eHU5fbls/j8KZuu83bwPr4JKoSlfBxQ0qSreRx2yU5ynRYl8Lqhl9rnq?=
 =?us-ascii?Q?Kt3cFtKLE9f0BZZrhw9TyXWTDICGAugf+B9CNlkuToUsBj0q3BGK1jNYkmSm?=
 =?us-ascii?Q?A3ln8dFQQkjW7fyTqRpwGhcO+Eh1PaHs5DwMk/cc6GKHUuqvR7HKidbVmsJd?=
 =?us-ascii?Q?53TspH/kEwA8wtuqhL9+S9Fn6FfykjSojIxQyAFnBQkNVAUrxLlX93qCRC0S?=
 =?us-ascii?Q?I8ms9hYSfWeobNIkI+dmYDIGbHv1rHHvSDKP9usuE75ycRLnZU9zi1vsl8kv?=
 =?us-ascii?Q?QnprIEEQnI/FvuUv7K1KME0X8henSRFiUCYqeGrjy5jzclBw0ar70MBv4cac?=
 =?us-ascii?Q?AesqXm9QySeYydeXIKrmT6O0v8CSzTaBrgQzITV2pV0d+tveujWP7ijgw0M1?=
 =?us-ascii?Q?jdzDcrGsVelA+7C8gELBlDGIDvcqcG4cStyaKowDIKRyLr0jDy9HPWcMEFBW?=
 =?us-ascii?Q?qVfyu5ghVMdjSmdE3ZQTEYXKf31J2XXPGHVc2CC9uhWQv0JwnDAl/E6B/sJS?=
 =?us-ascii?Q?zRNSm+7KWcxwtEVXvwZnJzrDTUVnuVbTaNwUjGWAntqyIR0WbYCr+pWqG/l9?=
 =?us-ascii?Q?g15K2Gplpby4UuhpzdQdeXZUvU9SUhQWfnZJ/WzUe2hXMzOICnvZ6T4WoTtJ?=
 =?us-ascii?Q?OWTCmVaFgSH5vQ1MSE8pnH2z+9rRaMxeA+Q0bhofJ2en2uDB7FBiItxGxQqt?=
 =?us-ascii?Q?7GSpIo3bJxgVHNSR451jY7nH1pZDarCQ+KB1lkWWS++u5E0erR9WlkEndPOl?=
 =?us-ascii?Q?naBkh1QVEjASrsMstlvqmrmUtZ+a1Dt/AF9iZR5UiudzojpuQOSRQBFzAb3K?=
 =?us-ascii?Q?VHGOCsR4K9Z0pwDgm0D8U4xP7PvvQLdHrWLOHL5uFKhMzo64U0GEGNGAdMY/?=
 =?us-ascii?Q?keiASh5PuY19EwwBIOdRWh4J0Af2306FJLNe/O19eQQTPte0/c6VwLkPBW8Q?=
 =?us-ascii?Q?Qh7sMv7qyZHzMq6u/3pPSL7mdSjtojsbb28BjpY7zq7TVfdGl/+k/SuFwSAM?=
 =?us-ascii?Q?4y/KhXrIByvGb8g0Vlqs59QUJWtUeY8zZhZbqJdsC7ivQjPs0Tf82+iQV4z7?=
 =?us-ascii?Q?NhZY82U75XZApcE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:27:35.0639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5283590-3a71-4010-4dc9-08dd57e28456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Increase the maximum number of rings supported by the AMDGPU driver from 133 to 149.
This change is necessary to enable support for the SDMA page ring.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b4fd1e17205e..bb2b66385223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		133
+#define AMDGPU_MAX_RINGS		149
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

