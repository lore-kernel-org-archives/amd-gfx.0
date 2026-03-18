Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B177103E189
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8271D10E823;
	Wed, 18 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kolng5Ae";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20B510E06C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJ8N+47Nrj7QfGMGmYF0yN9zXzVpUUqG+Zpq+jRcRs9q8lhIRRFHcVXh/pAQIfHrwRAjMupioUTuVq6NbmluTrn9M4lNwnAzw8S+dl5w/IUWht80bIp/2pYBg2Eq1yzCYmfZf3YLyKycn8YT3WBl4a9MmbgtUKfpGm2Aq2JIqtouMZPGpxZJzFB+zs+oZVuQNV7SbZ/ihGZEG4pURxDJRYq9/0rOr1QUUXuFHVmVwLdukUpKyjCxfqZ5eQ2mepufUyYqoiHQMaIm41CKaX/0IMD+vAycP1hxNHooATFvx2d4tdjMzOouXry+spFYPY3+BfFqj7whzFQzGs2WDUUG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x1a3hFDkD5PciJZZvuitsNn5IDm6etaWB1byhUVf7w=;
 b=G9PtzGeg4RznvwnEBs9dPIwG+wshHlBzBu+NgpOZG75nupFvJorK8Y09L4cSxaPCKHFtT7yHgQAWbCuDMjYqC9B5cLalTksvf9NpaoUjIhBBN/JvYscp/SBBlkfKEuihetIZBY6HxLS9sYCN6e6jzHv9VxolhrvwqQ86JcNfCsZASXnHAIgQPKfnZpHBrF3OKxdcwVKHZJUioC1ihuzNXn3vNWNYz8QiyXN6snGF2Yys7qT7dwkL9Ya733PYpId2QtGaDbvsD59nCzW10rU9GTMULRhHafCvVEVJ/ocaiS8WQzYI7mn7NdZT5AZdENMG6qrNfJR723uRJ8FI9HHSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x1a3hFDkD5PciJZZvuitsNn5IDm6etaWB1byhUVf7w=;
 b=kolng5AeFOELvKtomdNQKdcZuhem8dtB3cC34QJ41zDr9OSsSHZNH4v5nu/DPiNnO8zlWQKZrVO7gTH4+u6KPEtk6+WO7ZsRj/lts0HrAn4NssbrLCbJMfxV6DErzQFh59rYy38Qt6MCueHX70l+EsUGpI8oIToAcmuv6rLtD6Q=
Received: from BYAPR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:c0::30)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:08:58 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::95) by BYAPR05CA0017.outlook.office365.com
 (2603:10b6:a03:c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:08:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:08:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:08:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/16] drm/amdgpu/gfx8: align mqd settings with KFD
Date: Wed, 18 Mar 2026 10:08:23 -0400
Message-ID: <20260318140837.582776-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 08993e6b-95ae-4d5c-3731-08de84f7e59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HZmtNNo8Ya/GooWNhxz/iKc3aFYIPZGrYf7o45PES+S+HJiC2bbdz1q1sK+/xFq8zkibzCUuotDHCRbZcqKLTHYyCPEmp5Iq9YBMHmabFBdIXN5rdp7GMYlJrHwQzyBVmfYcseIV38T3gFr36oArzH993RyTlKnV5J3OY30XdEK3FR7Ggsj0uomfI1pyR1nrpusZUmHygz/+5zjm+H3jmoZNregev1Ld94kWtYxXaY2cKnHHVrS6OkyNzMZH4fRhqgq9swW7iJQdTbrloFKIFU8U2DgVB2Jk2tNa7fnrRRotCOmzTPBMpb00787LTs1xFW6Cgq4RmrNnetHsvToywznJ+whNDOS1+1LY+CIsnfCVItswDwXRBs0oCeQ03ODQ2K9UPmzee2fXhzX06fCNd72ot1SJ5XZgb90x+fOw46epulNP9GdTF9ablu03djzYp7U2+YHFWH9E4C/4rbN7b88uiyPtMPNZ5qqKi7fVn185zQa1aHrMp1rqVBhgox6obA4NqNwCRcvlteOIhb1ZTaUTorHkX2nOYZCR7FEoywo+yl9eamQKwSfmJjmaBuaFa8BpdObvPUcyfA2oljl+jfaLF8YtPWdxGloJB6+18yDxkx7CGfskMPYdhEh2cCrhjzAm8d8oK4GywmRjG9R7SJZ2exhCO71aqDxAMGGvxtHqNt3UxFO2ybh1DkkavWtK6J6bSBkm2LrLMfrVApPY584H1paOCQFnG7EwkzTS/eVjcL7M99W41ndlb9q4uSVug5DqOQIZ6K5nBL7krLEUxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B7KXN9idrzJGM7oYHHHpWvYBi89HZ59gKKLqfRsvCPx/CcDHwtqae8sEFQyR+LGr1A0bpxz935p/YH3/z3FSh/BbCGAAalnWF7pWLbX2LG+mWLl0XeSARJdFbc8Eow5r24hUX3jWs9+PZNxLtY76kWk9S63IbmHJlpBOY1Fg1qq9h4lM3PH37wVOhWf5IZMEDsKRLCj76KpCpYXx78riMfU76Cc+gHJJIOPWqUANxKoAq3V80tCBcjKtkL5bY5i4VAaOm9j5/7flzx5hxTPJy/OT0XpS40+D0DqFKJx7BbyAHldr5FzFmsc1ws4opjjqXQww0qtrZnQeamJOft5fcyCDC83M2gb4a6bgkn28Ofa5OLFqiWxGD6Ebwn0IS+8R8CBFbi4AT8uFDT1LhuWniOSvieICgIWteiTJ7s0Zl2/T36PBCN32sKun5K0ex3aO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:08:57.5898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08993e6b-95ae-4d5c-3731-08de84f7e59e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Reviewed-by：Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index a6b4c8f41dc11..130196859ff3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4532,7 +4532,11 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 
 	/* set static priority for a queue/ring */
 	gfx_v8_0_mqd_set_priority(ring, mqd);
-	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
+	tmp = RREG32(mmCP_HQD_QUANTUM);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
+	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
-- 
2.53.0

