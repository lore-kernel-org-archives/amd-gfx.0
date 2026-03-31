Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B3F109B47D
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 14:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA8510E97F;
	Tue, 31 Mar 2026 14:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DWLCY4qf";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 408C210E96B
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 14:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/+fgfNpRLiD0elaVIrIlkOgICr+QZjTRCj+VVM9WXCmlg0EBCeXR4YV1I7hn2VTbbCyWYQWStAZJp7crfCy2dqzAQTM6Xrq8xW2QMo/K/YKXUxWDBRteCnpeCsOunGybWGXhxHVGXGv2FRk/BWNQc7YS50FqkGdzc56R0yHeccZuf1Lrx8kI0/J4+H212xrvh1tOVqgL6OMjZgr3SxKI88ORl92vHPbpqlue1eZx8TMJq6hEJmLDDQrYrunGZNe3g3CBo/eNNlhP3Nmi8zn3Y3+ekdDZcT2UAnUY7M1TJzfe00pamvWcXoaerLJLufV1ZvzCW91GP8RAAyQyKz26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXTtIJbGeS5ZAHgFXW5ebPicVbdAFIextTMD4GdF+rY=;
 b=jTxMus9uTXSUu3hTDH0zzKT+8VmegTk/UXiGlCQ2nTqjnhG//g9CV55u/MGCP0xslbJcYDGlU4NW243ZFydE9dknhMEQQ8HJYvyY+7aYGwa4b4FPr+rQ1wIugsI1gKWX9wGzYXgKTv3vYOCFVsvsITGMIY90XdckUbO5i1zx3+Wx5tBT8pvCAL/2Ne0NseTmavqJ3ACMxQ0ft5i9iVaCIO1tEQ27sRo2Kp+ACm49EkJyBaKR+rcIUuT7gKMSHtqNCnFtwfS4rAF6R9uwNASlOljXU+o3PzgRPX4dlynzlkqxZLW7iPRItL3/axwPQsmhFTTLO1YHmYAAGpL+Cat16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXTtIJbGeS5ZAHgFXW5ebPicVbdAFIextTMD4GdF+rY=;
 b=DWLCY4qfE8a+Js55RUvn8p9UT08E8P3NBITLtKLL/b17yN2vxQxZgGYHkbFH/a/qLNYwulWPNfSBYUesDbNYqQJ5Jihp+oewDeQoVD5TWS+ugd1MNZ4JlF4oYxRRWdNXiL89vM+7aJPBB9LoE+mSeo52tQvl0KpXuHfEOS/1578=
Received: from MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22) by
 CH1PPF989868826.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.13; Tue, 31 Mar
 2026 14:51:21 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::9) by MN2PR01CA0053.outlook.office365.com
 (2603:10b6:208:23f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 14:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Tue, 31 Mar 2026 14:51:21 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 09:51:14 -0500
From: Alysa Liu <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH v3] drm/amdkfd: Add upper bound check for num_of_nodes
Date: Tue, 31 Mar 2026 10:51:06 -0400
Message-ID: <20260331145106.10925-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: 495da8f1-a322-48ea-7593-08de8f34f8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yJNHG4ManNkCs1qk1KbzqOLTjmBQjNE96tF1FS6+u/CdCE/HRkwMPqP08v+gMywOXUa5h6ibonJ6Kcopd2uu2aoCpcau+HLTIxsI+VUZPWLsoDuVRYYqafcp4rn1ACfKoIeByIjxGwvbNOONxgQ2vXF4iKBJAHQcEOuruWU+jaZ7M31SlRz8hkFI/WTEbZ82HsjMN3wKLnmbZuXGZfe3xzvBHdABY/H6q3zZtcO7PI8FWyV4HEO6JN0chjbau+LqSGVXq1DlabvIKgKsWpDad2kQ4lCrgi+7qctbkZ0zoppvwsLVv9OwZyiqGyHBVqAR2t0Dnm7E4GPhjPx/D1Fpty0pHnPuuFHBuOBko2CQE86KD1vqase9qCaOh6cAX1clwi3K6dv7B/+DzyfvE5cmAXHXFZjNRZe2qkhUQlenVkpx4nw+S40ZFqwB9S0Ou+xgWipIfUMguAlOGWmCFkxfS3IXUduNcVy2ZEDvZgdapCMQhsNByXuazib+d0yC8jKdQhq04hC0UIrBoP0/O+zRYkU+P8RN2ZwYatg/KgbktIxlznAzMJ4an3YBXYJPX68Iei6ppNdWU3VehtSHA0T07AB+QDo/UCif15L3BcWJYYSY2S5q2xk+PYnYhq7K3aYr+S2S5/19HoZ78pYYZJe2ff08p+LyrAu6GND9OMDBJ1XViWs0CGn3oTFpzHTgQfi3pd7Tsi3V7U8m4mmijG0hcLCPfs8XQQ6f0wvyJ01ZCZqvk5K4it6RsXN3EZn0DY0q6Zcejehrue8WIT+9ErImcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XE7favWKbYgMsdZBQopGVID5DFIZkc1e9b/n4mSyOh6UxpOfJpeCmr9/UgDI61zf4GzdhEsWWg/rAPfhZpypHdPAHTcwO9Bku3zuu+lW8G/c+LoXUgYRcYEe7tVmIGgFzNicqdLCTyVHw97bT5Ta3N8VnX3bkY70Ew+UpWO1hnwJ2m9Kpl5P6xIE1lmkSJRjPzNxsiHdmzbq/hSdj+SyHUL+eDflt5ky2iUX9eZy+JSDy5nmIni3aAM4XMa9xeFg/kd6Af6tMsfPCdeTTSCYFUvZ/VY9dbFupbbARArEsMmqtnHhfR/ypYIGNIaKEe+Tw5rj8Dn1eOJEmvCe3nH8tCXd4FzAmmQdzVOqVJp98lry0K4UDrswZy/N9oHCJ/jEGu8EIDJs1QHlo1Jx2qycoYScUMuVWakLeUHO8wFN6l65zE0IsmHqUJg+6NPlNHHw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:51:21.0653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495da8f1-a322-48ea-7593-08de8f34f8f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826
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

drm/amdkfd: Add upper bound check for num_of_nodes
in kfd_ioctl_get_process_apertures_new.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1db565442c48..5435419a7bd9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 		goto out_unlock;
 	}
 
+	if (args->num_of_nodes > kfd_topology_get_num_devices())
+		return -EINVAL;
+
 	/* Fill in process-aperture information for all available
 	 * nodes, but not more than args->num_of_nodes as that is
 	 * the amount of memory allocated by user
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e7a8f3e17872..af7b687d729c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1191,6 +1191,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	return NULL;
 }
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
+uint32_t kfd_topology_get_num_devices(void);
 int kfd_numa_node_to_apic_id(int numa_node_id);
 uint32_t kfd_gpu_node_num(void);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 1ccd4514d3ee..453b3577ea0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2297,6 +2297,11 @@ int kfd_topology_remove_device(struct kfd_node *gpu)
 	return res;
 }
 
+uint32_t kfd_topology_get_num_devices(void)
+{
+	return sys_props.num_devices;
+}
+
 /* kfd_topology_enum_kfd_devices - Enumerate through all devices in KFD
  *	topology. If GPU device is found @idx, then valid kfd_dev pointer is
  *	returned through @kdev
-- 
2.34.1

