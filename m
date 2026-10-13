Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DE8CC6B1A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 19:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB67C10EA36;
	Tue, 13 Oct 2026 19:47:50 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6196B10E974
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 19:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i79aKkhF9MnZhzOygPceFLMwMZdA7lZCIAW+JwJPv5Z0XddYO+mQa8uDS18c5VRgUjGMK2AXNOrxPl6oHo7DE/R7AeU4X13vUdvieoMaku+vKhMZHChrSr/jg296+cCxU+QKq0aMUQJjkx1RtxVuS3LudFBL10t26SqN5Mn9QV9GvG5K8hoRIKQh4DvhNCPY7fAPFklAdPUBpVzj2/HPoOD7jtEwJnWMAk2j4QHKrAKa7HvymBrCNC4whtFgtuL9FgHEzYxac7ZXNZ2fBMi1q3T2InJkhYdzAG8yraWpFOjURwT7PWJCMi2dd3zjf02xeXa8AIdxjT6ozVDPi8TFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcMUrPet4WeCHv1+XiwSX4KGjcWN7Rgpwi7PX7OPmmY=;
 b=Wzpq3LNIwQURcnt+Pc74OZciD0A/P8BABHeuEJnqVxUYqD2Hclc/VvlBAgYLxSPHTWUlYTnYWZuoedqnbno/Cf20LGda0iEaF+wUeDD3fugIuoSrRs52oyCajDAahq7ijknDk+YwFnoL/oeSy2Iix1uKSblK483xZVTRQ2Reve3tOlY1OhSQMbX89yWDJNz2DStXM1d1G9V4sbMz7MDxIZ0KXDaRNRM+3mUI2KlLtW/7pNnEncqvyx1p+bV72KKbKPqojiSvh1/Rn+Mji+A6r3HCXqFi4uQPQGDMixXcPFEkORsJwKvaZC4l61l6fJGCGvA0/58X5qPE/VpJw4fgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcMUrPet4WeCHv1+XiwSX4KGjcWN7Rgpwi7PX7OPmmY=;
 b=PXqmxmlGkjKCVWv4vZt/IRR0AH4AIBHJc4+v8LYOrVTn5YMy+oj+q7Gl/m/Eg8C5daQURAPALwhhc8cIQ3Vr1XnJVjT3ae1pisMZw+PX0TtwztH/4hm6P1bSFgr6B+ogQ+uMK6xYntOzdhzMkfBdT8ErjD47kc7Y3StrjfbOVRk=
Received: from MN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:52f::7)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 19:47:31 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::8a) by MN0PR03CA0010.outlook.office365.com
 (2603:10b6:208:52f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 19:47:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 19:47:30 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 14:47:22 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: Expect one MQD per XCC when restoring a queue
Date: Tue, 13 Oct 2026 15:47:05 -0400
Message-ID: <20261013194705.3687960-5-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013194705.3687960-1-William.Palacek@amd.com>
References: <20261013194705.3687960-1-William.Palacek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e0125f-339a-4621-a2f8-08df2962d179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|22082099003|18002099003|10067099003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: eWFC1zheE+N666XPHiE2ty/T8tmfmLuqbDhYIp0TIDMVx5wFS2Q8HN8hFTEmkexMM5kA3vrQAbmJj7KJ/0s0COs66ImDUx/kRrFhL01WKVtxK5WZdusjgeZKviFbsTu+ckJhh9lxkZ2hJPVqcGV4FdlUmr1WMPYd5pwGm2c82Q3bU/UrVG+gwRYbQ0v01xnR0wtxxrBpMOdGl4Fvhi3fid4uPhJMf0Dp0gaBMv+Oqy8RgrtUWgiJPu4y5/JLvYZKXhqGqSnVh5Ru+/Y4r+CmaMOKNBFn3IjayEAtUftrujzOiTXO3kOCn88hE0L13Sa62YN+qKRQ9G4KUQCC3Mex3xjekuosLLaxAYkM0nZGJ8yVmc/enpyfEz4VKrIEFE3aux6QhPxVqvKqAVd3SSDsoO8+5pUg5d8JPpE9eOvE/eJ7RrDIooMlT5tvbYz1gD1a2tTnpytHvXCqHjpSm9jtp38/ggmXCOO+BDQMPKxlEj3Hk4r0+XzYMZ4zpRUvbFv4OXTFDaw7lPUfOsuAFZKbicwa9RiRasMsVickK2+7GxZL+reYyFqj8biG9yC+fm1ERe5TNysPAL9TAJOrINmUtiZMbOrBhoXdfYQ2+4amqi+h59/lvjvj9ugUCmSSzWTqyKa7LHRjRXTNDbtaR9InfP36ByughWuli3CdEbRXXNE5AQGbJfoNf7FQBKU7CfD/bCBkI0h7U7u/Cb5v2Y5WFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x2TcpWxRsyaxvqcqCBL+8jIUdYeY+UdlmKtNyE6OfPqroaaAHODub4bfMrGKJDcpXa/mZAWwBl4/3WIkNylULmfsznG6GfatX0pN7fDG+wPNYdYZ6nWqjuZX7lw9YSKAYz+ZOfd1eph3JFm4EorbLyD/NshHAtbCJuyxH5UWESie36GzFtXZfuj3BEKbRCB9R4CfWvotSPWSDMvYqybwr0bT5WIKYHRGWepiTTKEeiAeAzVDrF9yD77EPLdc7pgDGR1n5nrXvSy+xGCIg07H9Z7MzIJM+5yw4HcwfdW1MZqREzQ5BRxyf1MSUZxvrKYPstUU6PNkhBz2YcaNAAgS8zQUsC3LAZ213OfrZQy6ByOtr/IGMNNessMdOFJPcPMN5vttiEWwVTeY4yDwEdoJS0XWiVZ9vE5H0IDFKOzwV/+D2+BpFObhze9DOO0m7FDg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:47:30.7416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e0125f-339a-4621-a2f8-08df2962d179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

get_queue_checkpoint_info() reports mqd_size as the per-XCC MQD
size times NUM_XCC, and checkpoint_mqd_v9_4_3() stores one MQD per XCC.
The mqd_size check added to the CRIU restore path compares against the
single per-XCC size, so every checkpoint image of a queue on a multi-XCC
node is rejected with -EINVAL.

Worse, a single-MQD size is the only value that check accepts there, and
restore_mqd_v9_4_3() then reads one MQD per XCC from a buffer holding
only one, copying up to (NUM_XCC - 1) * sizeof(struct v9_mqd) bytes of
adjacent kernel heap into the queue's MQD.

Make mqd_size_from_queue_type() return the size checkpoint writes, so a
restore image must carry exactly one MQD per XCC. With that,
restore_mqd_v9_4_3() must also not keep the image's cp_mqd_stride_size:
checkpoint and get_wave_state() step through the per-XCC MQDs with it,
so set it to the stride of the new allocation as init_mqd_v9_4_3() does.

Restore only MQD types that have checkpoint_mqd(), since no other image
layout exists. GFX12 and GFX12.1 have restore_mqd() but no checkpoint
yet, and restore_mqd_v12_1() handles XCC0 only, so a multi-XCC GFX12.1
image would now pass the size check and leave XCC1..N with zeroed MQDs.

Fixes: c76bcb1cfce6 ("drm/amdkfd: Check bounds on CRIU restore queue type and mqd size")
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 15 ++++++++++-----
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  9 +--------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  1 +
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5e57576fba21..88bbef08c39c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -816,8 +816,9 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
-	if (qd && !mqd_mgr->restore_mqd) {
-		pr_debug("restore_mqd not implemented for queue type %d\n",
+	/* Restore takes the image layout that checkpoint_mqd() writes */
+	if (qd && (!mqd_mgr->restore_mqd || !mqd_mgr->checkpoint_mqd)) {
+		pr_debug("CRIU not implemented for queue type %d\n",
 			 q->properties.type);
 		retval = -EOPNOTSUPP;
 		goto deallocate_vmid;
@@ -2399,8 +2400,9 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
-	if (qd && !mqd_mgr->restore_mqd) {
-		pr_debug("restore_mqd not implemented for queue type %d\n",
+	/* Restore takes the image layout that checkpoint_mqd() writes */
+	if (qd && (!mqd_mgr->restore_mqd || !mqd_mgr->checkpoint_mqd)) {
+		pr_debug("CRIU not implemented for queue type %d\n",
 			 q->properties.type);
 		retval = -EOPNOTSUPP;
 		goto out_deallocate_doorbell;
@@ -4123,7 +4125,10 @@ bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
 
 size_t mqd_size_from_queue_type(struct device_queue_manager *dqm, enum kfd_queue_type type)
 {
-	return dqm->mqd_mgrs[get_mqd_type_from_queue_type(type)]->mqd_size;
+	struct mqd_manager *mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(type)];
+
+	/* Checkpoint stores one MQD per XCC, see get_queue_checkpoint_info() */
+	return mqd_mgr->mqd_size * NUM_XCC(mqd_mgr->dev->xcc_mask);
 }
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 79e0d6250720..4eac85a654cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -670,14 +670,7 @@ static void restore_mqd_v12_1(struct mqd_manager *mm, void **mqd,
 	u64 addr;
 	struct v12_1_compute_mqd *m;
 
-	/*
-	 * GFX12.1 is multi-XCC capable but this restore handles XCC0 only.
-	 * Multi-XCC CRIU restore is currently unreachable because
-	 * kfd_criu_restore_queue() validates against unscaled mqd_size.
-	 */
-	if (NUM_XCC(mm->dev->xcc_mask) > 1)
-		pr_warn_once("GFX12.1 multi-XCC CRIU restore not fully supported\n");
-
+	/* Handles XCC0 only, unreachable until there is a checkpoint_mqd() */
 	m = (struct v12_1_compute_mqd *)mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 948415908551..d95a28a80917 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -864,6 +864,7 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 					(uint8_t *)mqd_src + xcc * sizeof(*m),
 					(uint8_t *)ctl_stack_src + xcc *  mqd_ctl_stack_size,
 					mqd_ctl_stack_size);
+		m->cp_mqd_stride_size = offset;
 	}
 
 	if (mqd_on_vram(mm->dev->adev))
-- 
2.43.0

