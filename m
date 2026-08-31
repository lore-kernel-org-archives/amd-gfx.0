Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F297C624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EEEC10E5D9;
	Mon, 31 Aug 2026 05:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MsXloJqp";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA35710E5D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvnUqOu2v/5goWtO6Iem1Drm4KEQ4wjdA1iOhuGtbfskBYTHw45loTZ1iE1xmOtTfgxdl3H8QO8vXPr0D7ap8Wvi07FmOxuv8MUKTGPi5LF3nMkkXD1cw4Ir4Ia7/iHtWBm/ZluoCEy760hNEDxRzmcyMK0jrSpiVO8zuMBcycHH+x9eMSAA+fiOzbZ/9vPi+6sSbx5P4eBrz4k+3hhVnxrqAEAfnJCUHla6YrPTdQvis+gKauaWUgZTqfDbY5xJ3LzSbkBb2xa1rJ36nQ+pTPXs8Aiq4mSyd7DdEUqPCQ+SdtRl9GTmuPvQimleQbKNbNEwzM7lMEz5vdDt5QkwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5CsSOt/7v5IadCgNE6uKuoFaIaI8Pb/rdXJ5o9fya0=;
 b=XEoYriubElP/4Rjo82v2j8P4jFuviF3enBtfRJUQ+o1Dx4K6lV50bx8ZG+OEpsw7BBwhqy6LefntF2xepz0d19wGVJTu9xYABL64W6DJz0AMMK6EKMo7Qg0xcQfwpb6qblTit/jdyCsRWmIehGueMajBfOCwV9Ep9kDXffjakCp2Bqe24kgUC5N5YM42j9sMRMhhLj+BruYVWUlSojctMzWVdqlXoqOqp9GvrIefd/lSAJ/m6ieWSK6lk58bj52pdoV3BGUhzhrSJRoo5NmaSECWeElxAifLSLPp8zGXBU8lYgCbXgSywt0RIa3+eO5uIppRBGbaJnkIcMQvEj2KBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5CsSOt/7v5IadCgNE6uKuoFaIaI8Pb/rdXJ5o9fya0=;
 b=MsXloJqp1NF5nCfuSDNPPTAhDyaWp03FHzQA6WmCMxiAT8MvbRQpyXQJEb+LTKW1oqjGpQc7ul2zoa9ru0nqDZN4q8zeVM3n0CbiaW664SAc3IAJt2kABZ7yZOOXBPz3I6GtuOj2WHdKYo8lXoeMYGu3/yaGKOzxXO//OPg24QU=
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:20 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::6f) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 05:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:18 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:17 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 03/10] drm/amdgpu/gfx11: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 31 Aug 2026 13:24:15 +0800
Message-ID: <20260831052513.1518180-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed240cb-6506-4d69-1abe-08df07203fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: q83HOkrGlTOMDesFApum91nadCB1Z5INqu57L/+7w08eFliIOI2NsJZ5A50lUV+9IPJXgEOTefb/qP0I5l9uHlTK5qzpBpuiAtpQhoXZw9iz/LpbHGG6i3mU59N1yvtKhLG+AG9cqDqj/lZExbQEHVxj/57oyAPuRdMdLn4xuMrXmWoOmaSR8cJ2wSENFTLjFqO+jq+1+T9Mf/qXbug8qrtx2oUZxL5l2htJNhC6Atilr51CPUJLiMHw3vVvOHy6JpXE9gbbLBl0RWprJ7c7rKKGckowlu+LLj2ApoyAm0tlnXSmqGz8ftijX0X+27bEURTAiBTMihEM79+R7Z3389Ommfs0zsAclv2sO+P254dNTKd7IWTNj7oW6N7L7RHjdGQ8Oc4BBaEwUPIBChXilofdn119NYTDIYNfnxTNmGVk7/K2vLTpeiKTaTuXDh0D1RdrBMU5z2Svw0vZaRs9bmVV+FldXVN1x4Nl1Kw60QX5u+ypfnZvY0yEcixsA0rWzl4b+JOibXAr554FPefMl+LNgrOSCXs7gWssycgBLe3vS9Naf1GG2ZN82MyEPdWCzZ+Ah1d5djuWuaJmTDhas49wVplKofYwKQ2gBGacMHwUbxtW0fIe6K67v/6erYZ1b9OXTzWXH0aitrwITCCO3ODbD1FeqnJkI3DmxYQR6VJFFpcBhgdjybLFagukkkef6owvruUQymyv6e3HOly7UQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k4BpB7A5FQCF/t3T8TY/cR9x0GZUTve6AxkrHBRQqrpB5uxSnQfQncYszmgN/SRHar/uAnkTLode3sxxCKx6YKS8raGckULw2VJRLDB6lrD5OLf06rEEriY0Vm0L6zHRcThFhMsDhevAdstwEbfkfMV6va8AWximncTb/61ceJQRkg/bh1tsVEu5jF2Sx+UDV7GRP+aTD4VqRcmhpzF0zauojazmweKRajtspgUwxcwBmagj5JKSOvSCggfhdJkVRx/BY3tEGkse/dNIhhkctJWmJ5HclV7CdTDZJR6j1T7QJ+uYEu9UV+8PDrX2RDpXbKc4coj8r/XTxfRUEltR7gFhS9BAW2+0dkV96SW1u3k0sYxok9VusLNa6XiV0kGNp9OSRn0lWTCWLy3Swlyizb6Q+ouPZu/ezSs1g7oBShlhkcGcV37XMyEZ9hThi6VK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:19.8146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed240cb-6506-4d69-1abe-08df07203fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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

On a queue MODIFY (prop->modify) the gfx11 GFX and compute init_mqd keep
the context-saved rptr and use prop->user_wptr as the wptr, so a
re-enabled queue resumes at the first un-consumed packet.

v2: rebuild the HQD via init_mqd and save/restore the rptr, matching the
    SDMA update_mqd style, instead of patching individual MQD fields in
    place. Keeps all update_mqd callbacks consistent.
v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate gfx11 update_mqd callback, per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 33 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a447562977ab..238b8339213c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4167,9 +4167,14 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	uint32_t tmp;
 	uint32_t rb_bufsz;
 
-	/* set up gfx hqd wptr */
-	mqd->cp_gfx_hqd_wptr = 0;
-	mqd->cp_gfx_hqd_wptr_hi = 0;
+	/* set up gfx hqd wptr - on a MODIFY use the live user wptr */
+	if (prop->modify) {
+		mqd->cp_gfx_hqd_wptr = lower_32_bits(prop->user_wptr);
+		mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(prop->user_wptr);
+	} else {
+		mqd->cp_gfx_hqd_wptr = 0;
+		mqd->cp_gfx_hqd_wptr_hi = 0;
+	}
 
 	/* set the pointer to the MQD */
 	mqd->cp_mqd_base_addr = prop->mqd_gpu_addr & 0xfffffffc;
@@ -4237,8 +4242,9 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 				    DOORBELL_EN, 0);
 	mqd->cp_rb_doorbell_control = tmp;
 
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
+	/* reset read pointer - on a MODIFY keep the context-saved rptr */
+	if (!prop->modify)
+		mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -4379,9 +4385,15 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	/* disable the queue if it's active */
 	mqd->cp_hqd_dequeue_request = 0;
-	mqd->cp_hqd_pq_rptr = 0;
-	mqd->cp_hqd_pq_wptr_lo = 0;
-	mqd->cp_hqd_pq_wptr_hi = 0;
+	/* on a MODIFY keep the context-saved rptr, use the live user wptr */
+	if (prop->modify) {
+		mqd->cp_hqd_pq_wptr_lo = lower_32_bits(prop->user_wptr);
+		mqd->cp_hqd_pq_wptr_hi = upper_32_bits(prop->user_wptr);
+	} else {
+		mqd->cp_hqd_pq_rptr = 0;
+		mqd->cp_hqd_pq_wptr_lo = 0;
+		mqd->cp_hqd_pq_wptr_hi = 0;
+	}
 
 	/* set the pointer to the MQD */
 	mqd->cp_mqd_base_addr_lo = prop->mqd_gpu_addr & 0xfffffffc;
@@ -4442,8 +4454,9 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
+	/* reset read pointer - but on a MODIFY keep the context-saved rptr */
+	if (!prop->modify)
+		mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
-- 
2.49.0

