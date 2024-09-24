Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA2ACF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 05:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E026D10E4CD;
	Tue, 24 Sep 2024 05:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VxJPwD6+";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ACEA10E4CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 05:57:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAwOpPl6Ud5q/jCMsU13e7DB5WJFB9pjRXLoQNty1IYpEZvqct8vzt46JxlppD2ifIpVgebg51pGb34C0caSG/edzl9UGTS36tBNwydvGrYZ4v41ej/QNm/kp1pToJyZn+C2Vt3QAMHZITWrWZId3u6H4zRpIAAtqLI3qtvGWQoRon4wjttKQYx/9tsuxWQDKfzKLF22WmzFoGoE7TxniWJaCj5+Eb3EXR8LoEPiz9JpZgf3eR9PgJmQ+HqT8yFZdnibOAkRHrQd3uICcLJRq4huF9P8mOjsJrV9Jkj8NfLVSw8w5A4QekP9xuJT27JbFPE0BEeLGXraNCmSna2IbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5scO1fSR10hPsJNyz8kYzESVlVHQaoBhFhack5k7U0=;
 b=UbdFg7dV3cF9metIjT7acPvObqTyu87xq1zjAuekx8A4u8iLCX9ci4l3tsJfBZAfn3k8y0D2oT8pYeIy0pUCk+BmGs5H/mteN6Tud1VeAeGSAIV+R8nYZFES3+DKQok+Xhk/FYKwsHElS/G2Vpfvxt5m8f87pQt2zDEpjVG/FIrTo2Vc/R+nyQDqsRPiOyNRQNAFC1mD1zgmWuVmjclvl7oI0YHLGK+qC1p97jvqB4ePaQ4J6A7NiyReHRoe0TRdZIeFMWdtbYFsB/MPrJScUeoaL6c9nmnv78/Ltqw5vL86MP0JmT74SKLXmJ2zwpNiObX1kfs1E+bqwEp1wr8SUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5scO1fSR10hPsJNyz8kYzESVlVHQaoBhFhack5k7U0=;
 b=VxJPwD6+Slqcpubnd6DNuCY6TLK8Gzohkrc6NFt4Bc1PPSoye4H+4wFdp2Kln/xEgs5QGfxaLaAytss/xLpVhLtMHk+TmyVSlLkho8KR27KvuqHNJxTl4D/sHxsMyCzRA1srBcvixEKPMyY1ifLjxnoqkVISzgTM5eUZ5S5Qs/E=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Tue, 24 Sep 2024 05:57:22 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::2e) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.16 via Frontend
 Transport; Tue, 24 Sep 2024 05:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 05:57:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 00:57:20 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <rajneesh.bhardwaj@amd.com>,
 <Ramesh.Errabolu@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: Add sysfs interfaces for NPS mode
Date: Tue, 24 Sep 2024 11:26:49 +0530
Message-ID: <20240924055652.2678433-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924055652.2678433-1-lijo.lazar@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: b88c93ef-8f05-4dd3-2943-08dcdc5dc235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vtml5TF+dN5eypMqxQ/Y3JZ4tEitmyK9xEToR0m7cTmD2drknXkq/qrKtTiH?=
 =?us-ascii?Q?+QiLU6+PQe7eheabI0RyCi/GBlykAyqRrHslbroPT+OM8TW5faHhzopkf4/B?=
 =?us-ascii?Q?80SUjAzjlU8KlIl+WPQSZYHxLJ/tgePHH67417eKOAWK2OFYYz5BjZon0Thr?=
 =?us-ascii?Q?x6WonDcHlMU0a2doG8GJbcLiLreHD2YZJCyNIeUgE52ps4sjO0q7b/TUCcpn?=
 =?us-ascii?Q?DZUDq87CCOeQOpgtk9455z4UYOlr+1TmIKULNqY8ZmqePQtn4nlRw46P61Uv?=
 =?us-ascii?Q?JpPgb68x1sByPUiXrE8XDvdl8s5l3vj3X0INT8m99cKnbXEzIJyP4mW6SDvX?=
 =?us-ascii?Q?fWMFhCB2ctW6fW1o7NtMnYKJfpUeeihDAXvAUmohGJhxsHB9LOrEkqt0wtDf?=
 =?us-ascii?Q?WwXI0gFKqXaTG60GxtfDmbFVmfok7hbA+RmcoB3LhaW4V61iD6XkYkcQXDKS?=
 =?us-ascii?Q?OTn/Dh0rSUnEovwRWphxPoO+Irz0Tyt5+w8jZMjzXrptrxa7nr9U+791D7uL?=
 =?us-ascii?Q?q5ZsT41uwqG2vuTaPm0X/2yJSTT3zRdh6VuveTVW6NHxahNzoIhYxg4iAJ0M?=
 =?us-ascii?Q?i3VTx2imdd5T9EkPceM3P7s5CMm1KeYjhr3E8qWS02gdF6rZk6TQmrzXZTtl?=
 =?us-ascii?Q?JPXZ5aPEsFDrpGpVnSCuWqcV2QQ8AGYbRgweF+jigircEu88tsox8U1R1ZG/?=
 =?us-ascii?Q?BjQipd0Q60rJ9rqDeCGEx800dB29tE6/8LYKf3vFCdyEzF7p+s8N3tNhmAT1?=
 =?us-ascii?Q?3DoY4kqT73CKtP0JH6BoYnXya8dtCsvqYmO/4YN0rukOsGpeTYTOXD3nYTi8?=
 =?us-ascii?Q?ca+XLfZvwX+ypqhX0vYGxXu2rDuGErUufNuNp2iwgloYsIbNPrp5MDDwtQef?=
 =?us-ascii?Q?XM4tFAAfG6cHUmIVR8KLVnN5Sp90Dv0mLE1/acgyZQ5t9lb3nKJwrGfdOCUA?=
 =?us-ascii?Q?eINI6Ha111K/7UElcVeSV4igWLM9k1ddZO2GAH2vlNB1buECuWsbW5vn4KNR?=
 =?us-ascii?Q?+n0MZHIn2blos7tqlFsrCqHiLgLPrZpeuhZZ2ps7q4sJu4h31dJ8K1pu9Um8?=
 =?us-ascii?Q?1v7RpT2wZ+Yty21FSKz0j0ZiRNEMb5061kd58d7o890BMcCD6u01KYnzpjOm?=
 =?us-ascii?Q?OugJAcW59QFgoSg9WpXzFFU/kXHYlp5DqZ4KXp9r0PHCxkrSO/xkYletDNKP?=
 =?us-ascii?Q?HPD+I8R6F4ZJ/l+TQbqAWNJwYngnKUsJRkRasgtuZ2znDde772W7AeXPxqow?=
 =?us-ascii?Q?pppjlu8rGRtCmJJv8+zwv96+HR5/07pQmob7m73P4SxmEUi91pqRZF/q7WTl?=
 =?us-ascii?Q?FWx4+PAjn/nk7occDJxVjzLhkbHWbNQibWOQ18YxP1RmiXFicKCIbj7NxY8w?=
 =?us-ascii?Q?6/bGaS4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 05:57:22.7007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b88c93ef-8f05-4dd3-2943-08dcdc5dc235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
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

Add a sysfs interface to see available NPS modes to switch to -

	cat /sys/bus/pci/devices/../available_memory_paritition

Make the current_memory_partition sysfs node read/write for requesting a
new NPS mode. The request is only cached and at a later point a driver
unload/reload is required to switch to the new NPS mode.

Ex:
	echo NPS1 > /sys/bus/pci/devices/../current_memory_paritition
	echo NPS4 > /sys/bus/pci/devices/../current_memory_paritition

The above interfaces will be available only if the SOC supports more than
one NPS mode.

Also modify the current memory partition sysfs logic to be more
generic.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 114 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   6 ++
 2 files changed, 104 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 758fda4e628f..24a1f931d9ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1130,6 +1130,79 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 	return ret;
 }
 
+static const char *nps_desc[] = {
+	[AMDGPU_NPS1_PARTITION_MODE] = "NPS1",
+	[AMDGPU_NPS2_PARTITION_MODE] = "NPS2",
+	[AMDGPU_NPS3_PARTITION_MODE] = "NPS3",
+	[AMDGPU_NPS4_PARTITION_MODE] = "NPS4",
+	[AMDGPU_NPS6_PARTITION_MODE] = "NPS6",
+	[AMDGPU_NPS8_PARTITION_MODE] = "NPS8",
+};
+
+static ssize_t available_memory_partition_show(struct device *dev,
+					       struct device_attribute *addr,
+					       char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int size = 0, mode;
+	char *sep = "";
+
+	for_each_inst(mode, adev->gmc.supported_nps_modes) {
+		size += sysfs_emit_at(buf, size, "%s%s", sep, nps_desc[mode]);
+		sep = ", ";
+	}
+	size += sysfs_emit_at(buf, size, "\n");
+
+	return size;
+}
+
+static ssize_t current_memory_partition_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_memory_partition mode;
+	struct amdgpu_hive_info *hive;
+	int i;
+
+	mode = UNKNOWN_MEMORY_PARTITION_MODE;
+	for_each_inst(i, adev->gmc.supported_nps_modes) {
+		if (!strncasecmp(nps_desc[i], buf, strlen(nps_desc[i]))) {
+			mode = i;
+			break;
+		}
+	}
+
+	if (mode == UNKNOWN_MEMORY_PARTITION_MODE)
+		return -EINVAL;
+
+	if (mode == adev->gmc.gmc_funcs->query_mem_partition_mode(adev)) {
+		dev_info(
+			adev->dev,
+			"requested NPS mode is same as current NPS mode, skipping\n");
+		return count;
+	}
+
+	/* If device is part of hive, all devices in the hive should request the
+	 * same mode. Hence store the requested mode in hive.
+	 */
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		atomic_set(&hive->requested_nps_mode, mode);
+		amdgpu_put_xgmi_hive(hive);
+	} else {
+		adev->gmc.requested_nps_mode = mode;
+	}
+
+	dev_info(
+		adev->dev,
+		"NPS mode change requested, please remove and reload the driver\n");
+
+	return count;
+}
+
 static ssize_t current_memory_partition_show(
 	struct device *dev, struct device_attribute *addr, char *buf)
 {
@@ -1138,38 +1211,47 @@ static ssize_t current_memory_partition_show(
 	enum amdgpu_memory_partition mode;
 
 	mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-	switch (mode) {
-	case AMDGPU_NPS1_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS1\n");
-	case AMDGPU_NPS2_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS2\n");
-	case AMDGPU_NPS3_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS3\n");
-	case AMDGPU_NPS4_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS4\n");
-	case AMDGPU_NPS6_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS6\n");
-	case AMDGPU_NPS8_PARTITION_MODE:
-		return sysfs_emit(buf, "NPS8\n");
-	default:
+	if ((mode > ARRAY_SIZE(nps_desc)) ||
+	    (BIT(mode) & AMDGPU_ALL_NPS_MASK) != BIT(mode))
 		return sysfs_emit(buf, "UNKNOWN\n");
-	}
+
+	return sysfs_emit(buf, "%s\n", nps_desc[mode]);
 }
 
-static DEVICE_ATTR_RO(current_memory_partition);
+static DEVICE_ATTR_RW(current_memory_partition);
+static DEVICE_ATTR_RO(available_memory_partition);
 
 int amdgpu_gmc_sysfs_init(struct amdgpu_device *adev)
 {
+	bool nps_switch_support;
+	int r = 0;
+
 	if (!adev->gmc.gmc_funcs->query_mem_partition_mode)
 		return 0;
 
+	nps_switch_support = (hweight32(adev->gmc.supported_nps_modes &
+					AMDGPU_ALL_NPS_MASK) > 1);
+	if (!nps_switch_support)
+		dev_attr_current_memory_partition.attr.mode &=
+			~(S_IWUSR | S_IWGRP | S_IWOTH);
+	else
+		r = device_create_file(adev->dev,
+				       &dev_attr_available_memory_partition);
+
+	if (r)
+		return r;
+
 	return device_create_file(adev->dev,
 				  &dev_attr_current_memory_partition);
 }
 
 void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev)
 {
+	if (!adev->gmc.gmc_funcs->query_mem_partition_mode)
+		return;
+
 	device_remove_file(adev->dev, &dev_attr_current_memory_partition);
+	device_remove_file(adev->dev, &dev_attr_available_memory_partition);
 }
 
 int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index f5be5112b742..1a50639a003a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -73,6 +73,11 @@ enum amdgpu_memory_partition {
 	AMDGPU_NPS8_PARTITION_MODE = 8,
 };
 
+#define AMDGPU_ALL_NPS_MASK                                                  \
+	(BIT(AMDGPU_NPS1_PARTITION_MODE) | BIT(AMDGPU_NPS2_PARTITION_MODE) | \
+	 BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
+	 BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))
+
 /*
  * GMC page fault information
  */
@@ -308,6 +313,7 @@ struct amdgpu_gmc {
 	uint8_t num_mem_partitions;
 	const struct amdgpu_gmc_funcs	*gmc_funcs;
 	enum amdgpu_memory_partition	requested_nps_mode;
+	uint32_t supported_nps_modes;
 
 	struct amdgpu_xgmi xgmi;
 	struct amdgpu_irq_src	ecc_irq;
-- 
2.25.1

