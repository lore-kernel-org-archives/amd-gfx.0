Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957BBC5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 15:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAA710F39B;
	Thu, 13 Aug 2026 15:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UC0xwjDc";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013063.outbound.protection.outlook.com
 [40.93.196.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BDD10E064
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 15:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO9jUix3mBaDUbrIaVcjMysRL9Pi/tKk6XeEqOrkDsIsugrCSmmeFNHD6VOgLMxrq5BSpyfG6XKu/7FyYtThYHo9pP1t1T0irnqUqaO86DeWQvTuuHtGrD4yJbLnutXQGrbWi0H9kz9wq/wrsms2ySLKzP+7+dM2kb94Hm4i88cZinJAn5O4QvU+4C7mar++FOvbWd4efPdXoKwu7JeqNITXTTMlEwqauGXkw1+DRTingQUUpPtBWPap77CUk3eEoIGaGNmbpM0R330y+RwhHXNuGiuUcJ4hq46cpsvBwK0qzuvKjY+Dg3b+B8KDj16GtAamRjw5nyYpz+C+IILd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3DMKcelbhakvZbVMv8b2eAy8G5n4sCISfG2hwnuuJ8=;
 b=REeJnH7zUfUYcat8+lWWzMI4/mwTtgY+uTejCFcIAmg3DIq0DvRK06cjHKPBFyLDg5k2dOwStc1KchKcfRsonm4OqI367BTZF1M+MZg1O3kdIGA5vIQUqgicw7t5wOly7g2Bf/Be46rBBxAYJjCHttBW1RZQNDWsXTfLgw+4f1aACJy/AjF80oKhQ5BPGhZEaduaSbISWmOCgwCrYRocWn0VG9BgeeTvq86YPQfut76SuP9mBEJshOlmlDn/G6rKkUjLEOHyi6Qcwq7ma0GHtj7OzfHCaEjz+qQMV17itLr2L+bRPqKZz7o9o0Lu177S1F76eqd7p8VvmDAFqceMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3DMKcelbhakvZbVMv8b2eAy8G5n4sCISfG2hwnuuJ8=;
 b=UC0xwjDc4S74wHYu26ROBaUiPLp6O1DZgbWjaUfRRdfuev6PGmT+BI+0Ch09DidwsdmZ7pkodi28vSJuaL7XcJfUXQ49+RlLUuLHdlLXl/6Z5qqksfOtRFt9OSR7RT6FKUqMm7QohoG7XpiGPT4osPOdij0f9YMJM3Yi6xhUjyU=
Received: from SJ0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:a03:39c::28)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 15:11:38 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::61) by SJ0PR03CA0353.outlook.office365.com
 (2603:10b6:a03:39c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 15:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Thu, 13 Aug 2026 15:11:38 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 10:11:37 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <mario.limonciello@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: fix sysfs ip base addr for 64bit in standalone
 mode
Date: Thu, 13 Aug 2026 11:10:43 -0400
Message-ID: <20260813151043.1206885-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aacbe80-41b0-4578-e8d7-08def94d2c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|56012099006|18002099003|10067099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: Vl0Haic0ZvE/4EWuoMoVVXKOwnLtRdFPWi+0wb+eSng0ie47ZbQQ+yZUrgSUaUOSFcHLqdcqrYa6rIycTDnFihMfXlRbt28QjH0JUNWK8fem2HILQPn6JFuKankbnn/ZG/uqIP+DFk1YgALEt6ckXD7et4IfXDIW7jlBz2MAkKv/8JgeJ1wUAQanlMNAU2ZZ0lnPjM0dBouWQXZAPyqGZ4B0A+7f6FJFvAWerpT1LsA81ohtxY0M72+YyAilzt7Y+wOXYLUm5Ew8TonUTs8ooJT8Y4yj1y/Lxh93a06rTBIzl3J7/Jy/iZLWDS+tPKbhVNoVK8r7eEnD7oLJ0flYTqAORDLiHM+5NmqJsdlIx3VS2LSGY2hS9d+5ryhNhx7FlRbwlLC0gySjEDWC4wdVvyYPJ6Dq0TLx1ulohn04M3zSeOmQz0Ipc28J4IYiKkPAvBNddkXrkZGfKVba3sSYKh+V2cPsQ3Y2KeX8rTjvWPg8j7z6xwM220LXrUraJYqXBx24wIyq8k9/4Pc8TQrmZ/1YcUDHE/NbanYcNovsVUC565sjxa4DK2BUFYkrwYxAAnp5VEJNpG6lQPWOHmadJDVdJ8U9hCTJpNkEfyerdhIt40ZFpjk9mZ1aECgd0URKujW64Bl6Mecs6drgEZ0/qud2nzAw2J+69+hUxemEZJU2agm3/O+P/QDW5RlcnEnNrYsEwIFND7Ti9aNw8z6IAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(18002099003)(10067099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LH8GElkiRb6/SmCUODC3A7HPpvsZFdBonhTsA97KYAoiiNXgrV3IyHTb38whPFN+gssbwAWuD9u5U2cB7OlYzGY7sHGPeCF9+4Ut7TIvyDUPovevXZZNDpotJXpEGjqGlojKGpC5efpg6oL+ms46tvUw0Cc51ws5/MWUj2EZ/ANZeJnOgK2FTKplPtgS5CVVkZdJetQr7FxP2Zok7LfZ18aqU1pO+9VcrStVPLIhm46B1cGAeuFRG3XvyAts/DPybKSHVpbn2RKAe6s0HFnSVZYeCss5IZn8AcpmQOThw99kMunQt8dhI5bWCOwACanp3QHO3wWYLXOFfHOXPlpIsUavWsZ/qCUqOQ3zPgPQ1m6wZCurDU5C11Smm9LPtfBP3lgyRDYUQIWX2dht4Q6B8uG+93H1mnJ7KbBKs6jHed1YhHDRWYRkn+8w/Seti7dc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:11:38.4324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aacbe80-41b0-4578-e8d7-08def94d2c62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
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

In standalone mode the ip_discovery sysfs tree is built from a verbatim
copy of the discovery binary taken before reg_base_init() collapses the
64bit base addresses in place. Decoding as 32bit there yields interleaved
zeros. Decode base_address_64[] in that case; keep reading the already
collapsed adev->discovery.bin as-is otherwise.

Fixes: 3ee1065e9830 ("drm/amdgpu: Export ip_discovery sysfs on probe failure")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b5bc0d71653d..8745b0a66f1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1308,8 +1308,19 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 					ip_hw_instance->num_instance);
 			ip_hw_instance->num_base_addresses = ip->num_base_address;
 
-			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
-				ip_hw_instance->base_addr[kk] = ip->base_address[kk];
+			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++) {
+				/*
+				 * Standalone mode uses a raw copy of the discovery
+				 * binary; decode 64-bit addresses here. The shared
+				 * bin is already collapsed to 32-bit in place.
+				 */
+				if (reg_base_64 && ip_top->standalone_mode)
+					ip_hw_instance->base_addr[kk] =
+						lower_32_bits(le64_to_cpu(ip->base_address_64[kk])) & 0x3FFFFFFF;
+				else
+					ip_hw_instance->base_addr[kk] =
+						le32_to_cpu(ip->base_address[kk]);
+			}
 
 			kobject_init(&ip_hw_instance->kobj, &ip_hw_instance_ktype);
 			ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
-- 
2.54.0

