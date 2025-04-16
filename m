Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05687C369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 08:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4A610E87E;
	Wed, 16 Apr 2025 08:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rcDNMPq5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA9A10E87D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 08:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGtCZASWfaAMxN7DZDRjHcmCyOL0AXPpwnvJDHHb1gZM0S5zML6hTtKp5L5y+8EHD1hYMjUzAX20w3sfT7pra3gU+SR1qO0uBov5kGviaDPCjZhx556wW0gkpc1dbS5N0v71tBafb9/qWB3LXIh/WXtlpX979daDwTsy2q9i+MZ/haPajCWmwKybQH1E0uMQ91ttndWi5infgqLXZejmGc18zr7ZJq9Ql4f/hMq3RcgKEymmo6BV34sm/5/s8rpS73Wvm4iuFK47b26wmGmJqyjitmHIPz6jK+sSS0HwyzQgFhC8DT3WkLCpy1eKo+JwEhGu/OjwatGhnvOFSMNOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaOMbM+VgNVj3huRvbDCPBng2+BLtsGhomzTSp1vbqI=;
 b=g4PUdb9memt2/NsUdf20NLTfTdGZxKGsrAFVFtSNqmq0zgHWwNTY0uctT5CeghejvcJufPTAeOR82cOY3BJyHbD9OLfmcahJkCk6trk2rIE06abMDT/gtCyWebW/KP+FIPBjo4w/i2p8iPaiscd3VDM8ALsZ6FawIZUYPfBP7DPs44anCHjLEVnnT6d08YIgvX/+7O87DNMuTNrxB+dColMXB65neLtpanj7Bf16hjoFUAieoY5aAqQyk+dk+GFS9hPLiGcQbHXZhOwUlkArc3141Z8jcL7TPUy4s38ZevqNLy7AhGY8B/jqcqoBdPCej931c1CB7ODSpdSNEWAJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaOMbM+VgNVj3huRvbDCPBng2+BLtsGhomzTSp1vbqI=;
 b=rcDNMPq5tsdHrs0Lqv+xp4cLqQS60cGtf0jwKsbl4iEZbLSs2R0We1AzIIepjIr0i0Caa3QkYhMToX0D6tNQ8jzu+KVd0U0O2orzzbIuG8YKsC0BdS7nqhvGmoKkFqrYxwlKY4HfRKGv0ctad1WlsNKzTu7fpPrW4a/mij/JJIg=
Received: from MN2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:208:fc::39)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 08:11:52 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::6f) by MN2PR02CA0026.outlook.office365.com
 (2603:10b6:208:fc::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Wed,
 16 Apr 2025 08:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 08:11:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 03:11:50 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: Disallow partition query during reset
Date: Wed, 16 Apr 2025 13:41:34 +0530
Message-ID: <20250416081134.850454-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b40c0b-64e0-4c11-f5f5-08dd7cbe57e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PIEZrp6HpsHOm9uLZHDRia5JKUBXQO6iYvW+DluDqZ9G9vdZH6e48FeGax9R?=
 =?us-ascii?Q?JpkwDlKjAbQDXyD4I3ETX6YEjzNYoJsKh+NVSjg9K5gSKhWWdK/V3jiTRnLc?=
 =?us-ascii?Q?YwXG9zRmEVm5i6+wdjJ7BuRkZpjP8ZOp4fDDHjLzsgPV2G3pdK8ym4rn5QXJ?=
 =?us-ascii?Q?cvN6CnTFE5t+Gt4GKhlpsNOJA4AmWV4A5vdrIhRmWq2CqIrfBWqKIE3/mu8s?=
 =?us-ascii?Q?sF1TYVol/mAfh8iSFqCSpLpPteSgaaYtvvom/2gZ7XmR2XBh74+4obhS0W3W?=
 =?us-ascii?Q?cKVhH/3WZxcfzO1q7c4woM+8ZxzBK3CebL++9vPfV2KCjttjIhAXMWLWNM4E?=
 =?us-ascii?Q?q8DN00iKtpIQHznNpfQpcpl5FFNX3460vjZkDyWOAgniWG0Phl0eKss2jV8U?=
 =?us-ascii?Q?8WJVSbWV81gpwxR7A/Zxqn854Urgg9tHR5x2JOcF+HM6Q7OLNjwfO/mhNmHC?=
 =?us-ascii?Q?hC9ejhDTPqThQQC8xURt+z81/L6D6CLweD8X8TnqsfGYRNwOeOASEGKKcjzE?=
 =?us-ascii?Q?mIhI+VISWizRcXDJNhtJAUjfWuLSbMW7caLK/zS82BYgJVc6hl1cOpAA2+Az?=
 =?us-ascii?Q?MXFKn5gWomfpYOvSmBRYJClBUAVg/+sKJN0SS7EpHA6EBLWO+JCOSKe4whrZ?=
 =?us-ascii?Q?VFIua6OrYenHsvoHlsQIfGe9kF+jYIGfdbUf5SrMQRexFKmSIt3EYbhFdNdt?=
 =?us-ascii?Q?xKed9NPzvnibFwZecr2U7ojf/liTC9HjRAmov2Tn4rSYN7bmUDUBHK+Wh+o/?=
 =?us-ascii?Q?z+HMLnmeQbzsFXU2S9ZZay7VZVRyaaFcFqzdZr8k01GWmk5cKBNNgRx0JPxZ?=
 =?us-ascii?Q?X5RotJNb6LArnkLxR3gKYFruJKAW8lBPv58evLB4PNI41tCB3l0KtL4fAZuL?=
 =?us-ascii?Q?ICmMmyVHfoa1L25fhrikR86e7mIIt+BnfqqotbPdXZwLyv42+HWAm7yfaH7T?=
 =?us-ascii?Q?orukWHfdQHAJr+T+KUHS3rPEfLbMFdudshWTCMHev0LNRss4KL13hmZgODnc?=
 =?us-ascii?Q?d7Bm0n58ozuQLG/XLpCLOX2p2E0t7hZTkfYVUammAVR8wK3TQx7NkQS9RNRB?=
 =?us-ascii?Q?ueRPrNcRz0aDl6bKlWI7WyWbjmVd3ftcOZwGp75f6GDRtjINS3E/ilqYAgD7?=
 =?us-ascii?Q?ZnwYAkRYkdUpuzBEKKew6tCOERjD6dgB5dWVx5mQiLRYzY8QcjMXlD6EqceD?=
 =?us-ascii?Q?Q0P0TpVpn6GQEAUwMqfuRGtL7KyiMa48sqGL61y/VElMGzRQAF6W4Sw3W5jX?=
 =?us-ascii?Q?Cmqnut01uovXAlKY2NR1ZKgTucmQZTS4tqd7hgLHxkoWwquyUfJ0DzlilNWw?=
 =?us-ascii?Q?HlrtwSFToV0nbfJIOuR3gfWavq//DGo2Q91crctzYTKTV5TZRrAF/OcldtkN?=
 =?us-ascii?Q?Ei6jer4f694aexy+LiJAsUC+1Nab150qy/dryshmmE3cgeQMxJ2hy7GWx+Yc?=
 =?us-ascii?Q?2eoPiAp5xg6+rXnlEqIH2nVqsvbvrjUPkK4NWcmV5ViKg7bqwg2YfWIrzgZK?=
 =?us-ascii?Q?WjfblPrekqYEgw1+fcd/Wj1tzi0HDTRBvSNL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:11:51.6383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b40c0b-64e0-4c11-f5f5-08dd7cbe57e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
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

Reject queries to get current partition modes during reset. Also, don't
accept sysfs interface requests to switch compute partition mode while
in reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Keep consistent error code, return EPERM

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2c933d436e56..67ebeed77d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1353,6 +1353,10 @@ static ssize_t amdgpu_gfx_get_current_compute_partition(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int mode;
 
+	/* Only minimal precaution taken to reject requests while in reset.*/
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
 	mode = amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
 					       AMDGPU_XCP_FL_NONE);
 
@@ -1396,8 +1400,14 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 		return -EINVAL;
 	}
 
+	/* Don't allow a switch while under reset */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return -EPERM;
+
 	ret = amdgpu_xcp_switch_partition_mode(adev->xcp_mgr, mode);
 
+	up_read(&adev->reset_domain->sem);
+
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ecb74ccf1d90..6b0fbbb91e57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1230,6 +1230,10 @@ static ssize_t current_memory_partition_show(
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	enum amdgpu_memory_partition mode;
 
+	/* Only minimal precaution taken to reject requests while in reset */
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
 	mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 	if ((mode >= ARRAY_SIZE(nps_desc)) ||
 	    (BIT(mode) & AMDGPU_ALL_NPS_MASK) != BIT(mode))
-- 
2.25.1

