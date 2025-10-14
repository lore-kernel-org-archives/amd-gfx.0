Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEFCCCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 09:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5016C10E587;
	Tue, 14 Oct 2025 09:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exn+KhHN";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3090710E521
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 09:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg1x2mVuMdiXpmMp4gWPD/5N3Ok9PlUWXlED6AINkok0YYnriFDz7WTRRDvy+dobeLR+tL0T3QHyYTnFNHf5py2pwwelZ8vMNSmi90gT0DErC/NtLM1OlfJBgU6jlgsA6/Q6YdT7rOdngBTVI1KyyDqX6zqwctP1lXgw2+8Uxm1o6c/mF0MUxLKEnjD5rSu8TUNMLpMO+zQFFGUTF79+llaYeU1fIBaqVSNprwSB3g+IuNX26ETVbgHHYaQF4aYMu0tAfZl41Xivoa87JGFrWY+9KVBPz3K6VMTN5uvKIUhnMWAJ2QnKii6a8/5HlvREAcdoDfZYQ7s6ClKALrmvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ih4s6xNv6aifKbTgurQpUzJ+qYS55ZhDola+kmGqVU=;
 b=XEGVd6YsbAGJeeILpGIP3QhFZAFX7Y8K39yjOq2jyLYyVP3drVyGndnqshFgUfuRv2YePoWM1wkGWjDSGssSxL4CQZDroj60dpLHJl+qDOsptsPy2yXzT11UF9RFrKZoRqMr26AvIO9Bjg3BWJ46BWOdWBSM9r8fVnAVfMtBfrw5bbqrZa6BjA56MgFuoo/g9aedBIdSf17klMQyRGYntWF35nzzwcuqPYZCRbhDdyxnvMk/lHu6Zvri69Uw/rrQfGHCguSBL/bi9m2bb1TgnxT2taXhrajCP76sKD/W56FVwRldM0krpUSMg7+QlQsI9KxJ9nOMpv4hYaUYoJl66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ih4s6xNv6aifKbTgurQpUzJ+qYS55ZhDola+kmGqVU=;
 b=exn+KhHNhW7Q9lL16Mmi812nQEW84RACDcLzgheLNFYjUA4ssFVtICSd4zVrxX61ZN+0RBOn15k4JDaRJV2diTI7iuyBRLa8Q6X9PG0bESDoe+bfDLVk3f5gCRvPuNOn8wlh0euVbPRSbRTOpC4C2deMs5YGU6qrZ1wOWOE+U6k=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Tue, 14 Oct
 2025 09:37:23 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::73) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 09:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 09:37:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Oct
 2025 02:37:20 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Oct
 2025 04:37:19 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 02:37:18 -0700
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, <lijo.lazar@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: Add kiq hdp flush callbacks
Date: Tue, 14 Oct 2025 17:37:10 +0800
Message-ID: <20251014093711.434989-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ed29cc-dac1-4b7a-d7de-08de0b0545f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MOgLzbzbyF4vHlCU/ECxKQ8R5Sk4IN2ka2g+R+GUSFjsUSsPHowCDq0CkRPN?=
 =?us-ascii?Q?4qLp6OD4auV+1mObT6SYiaPjxsS7byAtkKlJyshkP9dYKSZwuhCrfviMKyYZ?=
 =?us-ascii?Q?loluEevR4cngUqCslod7TCHyzRALhnT1i2wiHMHV6N9YL/KjmJwPoTo7Zght?=
 =?us-ascii?Q?W5aZ8OGvbp4Ny+MYfgbAEnEAfllxdx1zpqn7ygOluznDV6T7Qi1GaC+vkxRC?=
 =?us-ascii?Q?k4Wysmgl4Cqylh4TaHXqx4jKX7XZPbr3ujz3DaXmOdxSqnkZoZ0+7pApsUUn?=
 =?us-ascii?Q?3+Z85KNnQHh2tSZ1AgF8cJj93n8IxaF2eJoAFXOE9z8K76p04uqrLegVS5Sk?=
 =?us-ascii?Q?EWrxj6PcNXatnFL76M4el63VikulNlT+P4vEpJdy35LDO1E+r7o3tmnKstsf?=
 =?us-ascii?Q?tCD01ZVX6wf/QmARxjZCdFY6cBN4O4HXzNB/zv4b3NmWUQRGNffr52Zb73Sz?=
 =?us-ascii?Q?qy5+6LBe3QyZsHIzwfn/qjTM1+JaOpNFJ9+tpx/crc0agNcp5PVgiWia0kmY?=
 =?us-ascii?Q?63TJ2mFPECjLlhoagqFUcKeuJhp8crLxeWmS9m00RWVjXBStg3VqIa6nk0kH?=
 =?us-ascii?Q?HSXExko/5nWakYVWPMMJxp+GhhxmrO2pxHblhhxlY224RTqs/0BeQuLn/IB/?=
 =?us-ascii?Q?Q80Cyrvl6vP8STcxUQAUcsTgWzTVqdqZoCAaktaSAUwKbDDvVgmGFd2aq9G7?=
 =?us-ascii?Q?1S/0pLiEWVSf2gz/Uu9jfqVpkvjPgo+icHI6CIoLbqnOy3f3V4O9CQYxOup7?=
 =?us-ascii?Q?davr2juJXkUQ7xZzQtAW6I4bNFJRFlIx4Md+iTl2mhouIrb8PZ9kTAIHpoX/?=
 =?us-ascii?Q?u9xQ+bsNr/atZXeBSUhkUsjl8KUWi0kLFgatNoN/pQoSrrgbUgR/i89CWCs9?=
 =?us-ascii?Q?a6hZZFMVgrENDheuad6O4P0YQiWH4IslpW4AF/H1C3pVF9GrvRA+Pe7k5K+d?=
 =?us-ascii?Q?XBd3lmArKidVR0QqjUvfyBVnNtTAey/fLXtg0Ffc2Kdf4uMAa8C1qcv+ZXXL?=
 =?us-ascii?Q?7y7EOS7PQ2JxdCd87yUhDbmokbsEdc0D5CnS+1+CMkucx5qOEpXgUWeTIwkW?=
 =?us-ascii?Q?IFNPJTv5e6rg/OgRa+9AYPirGtfMRBfsj8RY7d6anFsqrEwfe0PUbLxE3z7T?=
 =?us-ascii?Q?RlN1X1W+950Mfswub+j77UT8JU1wt9HN5UfrSvGQiUNhIW+g0VGBpXHdf4Ma?=
 =?us-ascii?Q?jsErj73yWmoMSYdfI2KnQAO31Bg+yDDdWo6yYhUqh2TdZw83DWr92UoA5RUV?=
 =?us-ascii?Q?8tiAdIOViGF/0A93SBaxK1Z22umlxy+bcwLSXtGwVUmQKAT2sQAnUsqZJMaO?=
 =?us-ascii?Q?wkPbE52RWeNykUUuPY0ALhgRMjargQeU1DaQA/sEs330egba2yEpV7VXrcg/?=
 =?us-ascii?Q?hZ594yqQW48+eU1/yXOCSkkTBWfOY5EsH/pGBlZTWaDCWd8/kPCtGdonk/Pn?=
 =?us-ascii?Q?djpDNsr9bJbJUQk162Y+igVyUGFaIcUTwdhUt7WZb1ErqLH5f2sEeymF6RKi?=
 =?us-ascii?Q?fGyrmWAeBL0QGOW5UMkZQL54+84dciQ9HrRCoaAHQXGlNleJ8euhPpUEkDnV?=
 =?us-ascii?Q?xkh4mWyys/zISn4+A7o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:37:20.8525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ed29cc-dac1-4b7a-d7de-08de0b0545f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A
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

Add kiq hdp flush callbacks for gfx ips to support gpu hdp flush when no
ring presents

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 6 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8841d7213de4..751732f3e883 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9951,6 +9951,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 66c47c466532..10d2219866f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2438,7 +2438,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdgpu_device *adev)
 			if (version_minor == 3)
 				gfx_v11_0_load_rlcp_rlcv_microcode(adev);
 		}
-		
+
 		return 0;
 	}
 
@@ -3886,7 +3886,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	memcpy(fw, fw_data, fw_size);
-	
+
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 
@@ -7320,6 +7320,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 710ec9c34e43..e2bb8668150d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5597,6 +5597,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 0856ff65288c..d3d0a4b0380c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6939,6 +6939,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_rreg = gfx_v8_0_ring_emit_rreg,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
+	.emit_hdp_flush = gfx_v8_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index dd19a97436db..f1a2efc2a8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7586,6 +7586,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fb5585ab52be..e0b50c690f8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4792,6 +4792,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_4_3_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_4_3_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_4_3_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_4_3_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

