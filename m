Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D566C54FCD
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 02:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3945F10E0CF;
	Thu, 30 Jul 2026 02:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3t+Bo0ez";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CD910E0CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 02:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meVWdH+bcQhgPCaK+6/W5GnhCm04mt/RikX7BWcTgHu1tfdebhfTuYVdnkia03pnwLeoQ6fR+9+sEejw/axXJQAbMzi4IR9xV0VM2/NTNsgBhKH87pd7JT/fvvimNqn2m8DNGzm47cyisDBoNoB94TaAFxErq+ZWOH/JuFKMHxNP1PW5rD2VEy6N1ViExJ1MYhgCra+rln2lBJcL3F3NI+SduElxZG4OzdGthCe1c5BdZrRyCfleseE6hTEGQGpB2IkNkft9ccqZ2jg5GjKdu+UhFT3hR2thJPJZAs6pLy1sbwK6G3Qa5u8N4VvicVA9lPpRe6NlxvznL9E74UpQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiQ+iZX9wNdjl40SU36d7Mu3U1O0Ezct0Lg6QIBDT+8=;
 b=e4bgiarTX961l2Gr671RCk00FWM+XgzsdFNP1QTw84t/Slc7Lm5quXY8nXmL9q9hwk6h234uG28IzC2hBs3XQBWlfvmcP1rRr9MZCmDHMH8+7vi/a0m+lWOvX/Uj4zFLkncN1LpeD3W1Cd3dYRRLzQp+EP5fkWbnkGgyOTu4yTTuilFAP1y0WO7gIcm48Zwk+t6LXd1a1AJbpQ/cW3EkMpFW4X4uTJq8SeiJNOt84uF/d+d+tcXYZhYliPLi5oP+avMouXRWNh45/LY6HfcDVH8rH6sYXWxRtfT0puQqm1US+KB2zHfGWEJtmpjXqKEeUiHlQjNzzjwe7UUfNMKTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiQ+iZX9wNdjl40SU36d7Mu3U1O0Ezct0Lg6QIBDT+8=;
 b=3t+Bo0ezXvaxNvXUbDtBnWcMChLXihHvotm6+3u+4ks02zuurAnDV0FyKVXkiILmHIVPURCnuBQErTbAlmRv8IDVvz7KL/yitj+O/nKaillNS+nvdqMHUlrXALdmqtT7EMOUeTDuAFWHcqNFGd5X/jwyTNxbJqEpVcwj1A6EyCA=
Received: from CH0PR03CA0119.namprd03.prod.outlook.com (2603:10b6:610:cd::34)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 02:59:12 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::6e) by CH0PR03CA0119.outlook.office365.com
 (2603:10b6:610:cd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 02:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 30 Jul 2026 02:59:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 21:59:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 21:59:10 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 21:59:09 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: track faulted gfx user-queue slots
Date: Thu, 30 Jul 2026 10:58:26 +0800
Message-ID: <20260730025904.1993364-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 25529dfc-9824-4538-cc12-08deede68837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: o/qdUlO/G2HrXMwG27nU2V+3RASuLVEXazz2gmMe1ZHQZN/SeFvIxBAouVJy4SY9AgynsSQrmgiaMSOQuXGrvRVLcaQ6mk0OFg8eV/8nOsom7fqd0htaU6LUJ7euTdSaVyGgN33Ss7e1h41fi7/MO8FXq5ByvZgrgZbaB1/w83Y7vgfAPJulsCmIkpIPQhcNwFOxhAWPSDmonXUmGA0YcdPsfG5i+zqOQQ9f1cW6XEsdd0IgJLfFppeE996k8uUelt5xa6UK0hEJAmBHh+bC0EhS9v9AThsi8O75vCi67YwxLw9nr97Zz5lDk2h1UVl152deFRUeUlvUJbV8nFM+jBW5njhXwbNID7UOD8hh4YtNUxtaoi6b2bvEZ6WARKtk8tRVLGhMXY8aNtyi1L8QRtuuYtT9FHrztyRzY8vIoEuYDdvJtG3At2YAFDndvYf5f+rJv7FDGaGdFfFCMWlj4Nq8d1rIJT5iqa2ojD6pLfjx9VbjCWTAeYWouQ4eloCQGKfDLRyyT+dH3zG0+vATP5aaueJLIgYAsMGxo4CPscH0ECbpWL0RWMDbNVia5ptJJoeC/r9tHT8wSoxaRZkfTh/dnvGaHDU2r7nPWLIlqkXwgtrDJDdhGAA7rQVL2+mmeFb2WA6n+zsWABvp72XZ+b2+IBADPYCYZw0GE9wrNUwEOyJLWFCLmYX9KoLJuZDv9k4T0lGfavI7qBhR+QM4dQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BL5i11OeOyPYZGHdbFlo48n+ERWXwvfVoBfQATYj0hkthmIUKp+UVG0ELXwmwUa8YnoF6Thq6M8EADyJe02P6ccnG+KSf98wuEGX+N20eopxLjKTzN3aSmy6+59P1ZKOavwB9eTKl9ceRXwj6ZQGFLbNXWrp8E/iyUFBYfF0L2Ln0w6EMesZDFovvf55TZUazoKTXcvxxx119f8dIMTjSq7hvNiDOCOdTa2kPmhElolWM4+tBC8YY+v5lQitaGDZC0M48H1yuyEQ4eFoCiCAFfbHAz5G5NlA8vl2WrUkpwJ2HwnONVVqfL15oTV7V2MuYwh6RSXNsu5Doh/atkAB4gZjMdOr5FWVyoErFk40oQHm8yziR0pjxGBo8ElM+w/rQ8/rcoXPo2VfKcL8lJUEnC2pIZTPtZZtS1fpfEkt97mwkNAKNndSU+kETSjILcTN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 02:59:11.6260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25529dfc-9824-4538-cc12-08deede68837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
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

A gfx priv/bad-op fault IV carries only the HW slot (ring_id), not the
faulting user queue's doorbell. Add userq_priv_fault_slots (an atomic
bitmap of faulted slots, so concurrent faults are not dropped) and
userq_priv_fault_work to struct amdgpu_gfx; a worker drains the bitmap
and reads the doorbell back from each HQD to locate and reset the queue.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index aefd4f03b443..f83afa7e0aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -535,6 +535,9 @@ struct amdgpu_gfx {
 	struct mutex                    userq_sch_mutex;
 	u64				userq_sch_req_count[MAX_XCP];
 	bool				userq_sch_inactive[MAX_XCP];
+	/* atomic bitmap of faulted gfx UQ slots (index = pipe | queue << 2) */
+	unsigned long			userq_priv_fault_slots;
+	struct work_struct		userq_priv_fault_work;
 	unsigned long			enforce_isolation_jiffies[MAX_XCP];
 	unsigned long			enforce_isolation_time[MAX_XCP];
 
-- 
2.49.0

