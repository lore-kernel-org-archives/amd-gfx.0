Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB1DC55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 06:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C0E10E1A4;
	Fri, 31 Jul 2026 06:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FDxQXTCv";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05FD110F15E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 06:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8sxqa2AUrm23WjxGLIHtAdo3LcTrhlMSZfuru6nbcgVSkDc8hi+M9OBd75uDeC15FFDnwEElwuJVief7YraaNzp6/8lr+rIMtSQxZm8xJZ9raIiQnMKLXsHc8ea2A0pFU3vTgRSfhC9JIzdAoyfpyZRDVF4Cgn01f9/kc8nK0BjNipY88N2C64CJScUZ1XV+pTs/a9oq+1lKPdUGnM48bUPwBTXNT+VFfTPlm2PpPBVX+L+YJsFrN58w0KitpZzS2lXeUZV+7Ol3w0or+idTeRVq83HTv+0SY7ZEzkbXjgrp/URIuNofsP05zcQPb6xLmfjnhGfV0D/BaSW6fSQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7omhVo86w/5pRnZ9Tj9OmWyI4IKzeY3roNJLj6elgXQ=;
 b=bEsbDwwoJ+ZVXadxkBEoFSbwctsaz/CJJ/JkRVZCed+WjHuR866IGBleEgJ2gRcpu1X+JvBk1RfW5RZ3RlUQk1h9IuE8JB/p3hD11MQs4+NTSeMbz11uMXMImIVqyziq9dsmAdfHPvZpG3U1c2uhNO5GYx95yEWFbFqSOhDZd9ugLpG1OgLSKglMF+a2SyOmRB+uBEey2bMwov6wth7Si0hfoHuh/l9TcC+FwTok7kpfWaHwjl0akCdXo4GxtIyOJcthO+V1iw0VJcEh2G1ptPhcLjPcPtzXh0XaMbsUclwKH3z3a2ky1uVtOkEOBK2eoyj4KhZuzfRLkDiCHzSTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7omhVo86w/5pRnZ9Tj9OmWyI4IKzeY3roNJLj6elgXQ=;
 b=FDxQXTCvkPduLEMQQ1PYPDN0cDTLR8JzLnZFeQqYiS3Cme2fKPoSaebKzLY+6GPQ0pQfEKwsPe0tDqDPD1FQRtd6uUUx6wgAAUeOKe47amzcIAv13RfGnf1NjURgIh9BNsgRakeKwEpPa8IRLybVGaMQ8i0NIh2fA1hcwqnWEcQ=
Received: from CH2PR14CA0027.namprd14.prod.outlook.com (2603:10b6:610:60::37)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 06:31:36 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::63) by CH2PR14CA0027.outlook.office365.com
 (2603:10b6:610:60::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 06:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 06:31:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 01:31:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 01:31:35 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 01:31:29 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 1/5] drm/amdgpu: track faulted gfx user-queue slots
Date: Fri, 31 Jul 2026 14:29:53 +0800
Message-ID: <20260731063128.3026783-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: d244583c-1c42-499e-ce2d-08deeecd5f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: r/cuBxOXanmKIZ/vWBu9Q/pTL2e5ifOcIL9C+pFS65aIDZYUxOeYll61TREfYmZnSHcLedKIMxtPPT2b3B5jNyq1XW4qq3qZzmJ79oo3x3et5mWZh6656CSTCkt+XYZL/B/wkWsspwg8Ah3F+rGe8TkC72IhFUzIxnAlkwcegzYvUpfmsriYpT5LJY4/4THLHklwvgKv6CgIUdutBATDfR2g6kvZ+SQMyR1ljCOqbHaP/IY1z5Y2P9oeouZWfvcPjL7XjuDtqjqpdvk6Oy4B1O/e0G9ZcZkKWm84ckdhM3FjEwQZ1PN/7xdddrdy5byZoaoTYZW10IT9aaTRdCqn5Rcdnsl1wA50R4qf0h1FnbVZcqs3SahU1rBxhvIVXnnHATilN7WI5V3OJ/x9p2KNBLtsANz4U9q7f1zeR/VBGi+iH4SiD4YSPUMdnsrLchBF67oyv8Gz6ybt/8MEFzs6X/QvSovbuhFh30O2mJMXX+Wx+lQLzM00qcM+eFo3GVHpWCFdudotTdQEIafmSow7NAiAiZA8ZESQVx4Tyoi0G9726jK6GH6Sq9o2XANReOX7Nqg9FFCVuuQGYFbPhV/OFtMguwTBewFqlsGcDL7fqdYbFFuxcqt4/FWDLrHjpbrIZgFzhRzR0cr4cwk/a/+jcqMMmgdAMbR1wYAkYb3TpIgEvT9Ous65XlhCadh509uCi4jZYT0V7n9mu4v/ckN+lQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bAvUUkYNln5wbuI6rSOO8DUWwYw5kBQ8vwVqKBPhNBj3816ofMGZHjK/XY4/r7im6trypEAgkl7CZWWNrHCCSRg+Wnd1O17yMBS0M54MXJt0Y/sInVvZizxQK9wW+1Yy84dXrrjEEW8zPOMf1DmJusBV9i3r5iWT1hB2MHw3nhUYomR35zCCYlaHhJmK2fYeh9MqYBsL2r0coReOa4s7zcp5gWG1lidaM3CllBiIx20/OCls8UDP/NGo+bjWoZTNADselx2th0AnoPysUD33UxXfSsKxlwXZrl389eTd5Er8J3XEdDyfB6ruRdfd+I+XcncSgEtcAy/Te0+eHWQiKHyKLTpr97bI5LzzHY3oap3jWj2qwAfAo/TWYufvfIdh81NfA5WIATnsPO+uBWY1Ka4MS+qaRM0mB3N9Fvl+iGaAGTCFHQJLrh8hAOYU3wiw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:31:36.4618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d244583c-1c42-499e-ce2d-08deeecd5f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index c15f45a7347c..1023719c18bb 100644
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

