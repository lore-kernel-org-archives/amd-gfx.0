Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC83CD343F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 19:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A5510E5B0;
	Tue, 12 May 2026 19:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jT0wTUQj";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7628E10E5B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 19:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLiBNmaSkjnG0r0E5StfHXMKTH1+ilbyrLDOC5FrWtv9meurdppAMiCEKJDv51EFUjSxuHa4bxK82GbrLVRyuV+q/MoAPIlbFqCtTHDUGcrXUlFvdye1msoXJja6Z4gCfXROgXdHOwuyaw1CxEs2dDjjc0yE+XqC7jBu/0GEmls7/EYG19Xu6PnzznQFXmVWicH5pscrrb1akoC46xAqpcKMOhAaXLCSSydXMsgTd9D+htzsT02YFclbLb9sdNW/nRMCwt1ZqwJIHsBGuHVs/4ouhyDFNWtlCc/gIwTs5JDkLViNoCFJGkB9kQBwVb4T/TMifoA6kmM7SvKnZ8B0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9VU9moG81LgYX8THyIyW2hhUwqzQrZf1hXLOw6qNCY=;
 b=asoBAEc8NtmZYln31DQEi6n3ZOrSqaeduwfSVsEQ1Z/a+qyo13MwmLW8mpWS8MCgIQ3ozrQnsDJ60cAqXgrYNyhf/l0O7YNOGWv9HKNqCYn5fj7gbc0Z8gi+Bkfs/IZ1Rb0o92dxyKBloBMvwY7ujoq9AClwZAlhUjIDwfPQm5qVOEY3+mbaGgddAaUkTuFILOm/7f6Hn5hGaRZBxly0LPg4aDx+RNh8smCcajfSmF+LM/VOwHuQfygoQfynDvkMgCEjuIdvIj7zGkbCU7RQopGrEyH9+PnKqCkdzY/kbxc8M+W9P8q8bPpFJmW8MGSy+bbwJPFqKLPvL7u7x+uxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9VU9moG81LgYX8THyIyW2hhUwqzQrZf1hXLOw6qNCY=;
 b=jT0wTUQjnrIwb6mG39jkeMaCBmv2RiC34xXIAZUGg2We90wo3u07o5h4oWdFz8RFaRBED1zR9onbKOsU3Zfd1zowXYrS7eCMrDJWhogJLyZc+Zjz3lDzgYmRn9kRqVgBqa91Hi4JPRONVzB81iFtpHo24KEbl/VklJodg7F5eNQ=
Received: from BY5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:1d0::21)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 19:28:42 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::a8) by BY5PR04CA0011.outlook.office365.com
 (2603:10b6:a03:1d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 19:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 19:28:42 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 14:28:39 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Check bounds on allocate_doorbell
Date: Tue, 12 May 2026 15:28:23 -0400
Message-ID: <20260512192824.3682569-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 049f6137-669a-45b4-fc58-08deb05cad54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: h+2HJViA7GfHQg8L/fm7KXqZSg5wyF2d4WdS4VKluVxE4MgNWhqGmm08joe9RlWNidHzJsCtl09zh6vetcrlhHpMVtt2TKG80dKg67wTsjJQSg1BLH4qv6urGcvBCnMOQGwce9pg9bH0DUQjr/Rmi52PBsub4H27yVn15G93cxm/+uEVN0icJ7/jKACg3x6N/9JmqjbF0pvZ2JzwS7gpAB1ZbxoSOcVkS6RVCqvZHOx6yRXF9JxpFhoMUq9dk2xQkjndukruf7JYNYoFnz0G5uiTqt/DVTybIz51TLmcSPgb8JZEzyox9qoY4g8EtHamELY76Oz22XivIHp/GxJc5eudTakPPsoE+ixffNV5RGHSyiJqeLB63ahc/czz4SpSxVMlSEzw6UDOWHrtTZNyQ8KoLNRiJ6IF3epC7v6fG2s+bP+EUIyO0ZPLPATNrkr5m74Vw3ArWee7yFntZN3wZKo81gQKPgg+q/vBbEBH/tKWFUKSMpZnHWdvxPpdmxrGA3rpJ1C/u/pOA3ND1ryckHuWAOzLEj2GrVnH6/0rKmsgYlooz3d5mZVIhlAp/icYrk/W1wCxnigVj17wYYIGfNZTv9W1WF1RbjpnuO3Ca5HqmgRY1KDOFO2g4JsRg5YtbsiO/4ebkCHjMfKIpWz/ldeISdptprdc8RA6YK7HAKn3NicJxOtttSGfQA0UAD+xGQxehZhp7lShv3i3p5b8By71lIkipQVw9jhQdvZv7UA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HxYhTT0Ij1xSVdzL1s6NjSNe26KSshGZenX+zFpMHbrGUMo87l6khwKMiKPUqQ482yP9qRLV2CSmMlZTq4ICf5S0GyRx8Fwdj5xV3lqgJwK8AQfKZ9e/YK+OSv7gZjUDQIeOMSGkED694Otxuher8iYoSDvdDBBtRYawxb/buAcUbQ4UIiFWlXS67iA01PtHS4xATfssPv1RpbkteYudFNBPpyVnqWhD4hHLa1BCpLEM5dQca3Hg4bV7Pp14Mv5rN8sCrh/66DCFtuf/h+E99wN7/sZwfCeIz5IrkJ+KFrYwgyW1/ys6ZdZ5DOjZp771pLrXwIoNk5Y17JQTy0ir80x6hcabVG/OeC+eRFD3k2aGxHmObqyCkRrVM3xBmAZ25wrzXxK363UefMxXnvPqvYFLcE5TsK7mJ0ndv6LToNKzsd5QVZaWDcfR6XKyawRf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:28:42.3353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049f6137-669a-45b4-fc58-08deb05cad54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995
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

allocated_doorbell has an option to set the doorbell id
to a specific value (used by CRIU). This value was not
bounds checked.

Check to confirm it's less than KFD_MAX_NUM_OF_QUEUES_PER_PROCESS.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2e6923528342..b4cc74138f1e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -612,6 +612,9 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 	} else {
 		/* For CP queues on SOC15 */
 		if (restore_id) {
+			if (*restore_id >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
+				return -EINVAL;
+
 			/* make sure that ID is free  */
 			if (__test_and_set_bit(*restore_id, qpd->doorbell_bitmap))
 				return -EINVAL;
-- 
2.34.1

