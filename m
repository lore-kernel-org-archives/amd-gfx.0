Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569C7103E18F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E929010E832;
	Wed, 18 Mar 2026 14:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RmvJkJWL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3F410E82D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ0ebFgq+YYxBmoTWBeXCssLpo6mdphHEjYv846lhwILxO1VK/StEf0M6RvkUg4u4UoCeki7sn91lRxNyLJh7wxG3XOGqjijnWASVTfqJzfcNKbGia4k2pyOm5Dj2GKepD15L0j8mY1RbpnjO8m1UDAlRjFb3XxUZdNSMAnCPo0wRGPc8Qo9k60Q1ccnexoLHaElsANpVa/jC5U6nG5yiMy5ksgSadXGeFBFP3ZoR0hPKDrITVfQ1//0zsmZD5zBLKAb2PuFaqwwRPceSpDksh1aPuBW+Ds46Z0wGI+b/cuOk2JObmpi23qaJgHUtKj+BUn545n9P7q9JZ6N07BbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu1v2JI/DLu5kSSBXjQbX6pWL87yD3tuUJJSac/IMl4=;
 b=JxyuqOX5cPMlDkTTJPq7UtKE/Z84KdD5h6cJH+hNP+ckvEHv6axixV4lFoAb2NSB+Qvs3BsD3pSX3dbas30Z3KRptHGzpsjJ+K+rXHav99e4n+OwkuAH7lY+wqkvzurK3tACC87MCbv61CW11IHrY6yb6xNoqVgQ9ylCLPCVW9B1tqjhPD1dXf9jju3AbJoxCB2VPGN+NkfUBAy60n/wMPPRm+F8SEfRQa7IM+Ba3+HXLUsb5glDL3+l5Y8e8XKSeB6cLO0FPAEB3TRFwY9Tsx0a+1aV5CVEAgDLaVFOLsUCq5CjZdS8bFxrTTQIpn1Aqm+e5UCLjRYbjtiRDyi1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu1v2JI/DLu5kSSBXjQbX6pWL87yD3tuUJJSac/IMl4=;
 b=RmvJkJWL3y7t5C4AulK/Hjh4qPl/uecfK8DijdJ3NaZNireex85/cHac5IUH3VJ2Gkz50tO9OZIhiJGCcDJ8wWU+cZWMh3WybZ8lK2CWkcq5PdaXGR2RSj87GRV89Vb7doqBc3XZkU/U2FYOZ7WvOHmxXoXCs3bhPPApJRBjAmk=
Received: from BYAPR11CA0100.namprd11.prod.outlook.com (2603:10b6:a03:f4::41)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:09:02 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::30) by BYAPR11CA0100.outlook.office365.com
 (2603:10b6:a03:f4::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:08:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:08:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:08:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:08:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/16] drm/amdgpu/gfx10: align mqd settings with KFD
Date: Wed, 18 Mar 2026 10:08:26 -0400
Message-ID: <20260318140837.582776-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 94846c2d-e708-41bf-6f2c-08de84f7e640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 74dUz2fqtl9kqe4/PKonwPt37AiB+Y+u817g6S7q+ZmQimrya7874x3B3SFanhB1hQrKst+R++pZJH93DXAq3LQGIIHtzHRrAakVZp7fJSOPvFsvY6Q5CUvElymtjQAaByvbNhGFObYPI8tscWKfCVocah5szZsq2d/Qw25oqffUNtsszE1Fav5tcbLwqv6wsBDDeomhJcy9V1cZt+JCwJ783/B59fTpTLRrocWuYxKsYwNeZhRWTrm1LN/zeVNJeKu9yi87xcBgtenAmlVT/BqjvRE8q3WTBi4o28QKc2lGHrU+DpxKT5Ig5IThz9UK5OvM1j4bWQoN5NeXzYfZyzvTG2p6PPzbUbhLe8fZGSXUXHvltau2r0JJEeiq4lrz1bKV56f7d4LjGuBBBRJeSnR/EI8HRwHkhfqh36dHmfHDNKGPpiFlPlLMhCRfUZoM3VvToLttkW194PuOPvT5o6dqgyuNfWVxMuXBd+Qy+rtCJLCdSHt42KcmSU2LMuLlbb+g+PvkuFlbkzGsDTgpF8bmeXSr6qpd9w+xJXQEvHRbDslkDLyUkqYqWVzFCSFhWKiFMZMdpygaT5x1pG6KEYBcbiysf4eAg4kpocHyscAa7w8wFZTQsNWrIOBdFZgYw+khn1snOUva4XMjLBGQC7sNSAgmRrpmvLjNot1MikIv9C6eHtXVDJJ1xFZGg/9jmq2GUEuu5RlB+du6W6uJsNmxCfOVTTpZN4ik0Uv9XjCSPykC6T/0YiLAOQGOj+OSJyq2pgK/uuqAjtJy9QcgbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nrEZFd/8wVOasxXde9ReJdJdeJcSWDLNUWfSfKDGAF0WZ/VgC0M5rA13I8o8MnG/7dYEL94oEQgj5hrFPciFVPYJ9/cNPZ4yCId9PcihGL246R0e0kk2gHJ0BlIMiMNSr1Xf2Q5/wvVJ73BSwvwQMmipjDRjYOBnQMmhJ9uoVFKZ28O0y2UwvA/S62FFhupwNs18C594++gh2IeSMffQnHIGNxG7ihKbYeoxdnuthKUeCbIfWiCODTso1o6wj71N3b6UTopgnFj6q11H8As8jHPgkaJtlObyeZEPNJRWvkUUv/XsmZ+OOTa1dr5umDjJrhK0+GaoAHuWuGcrNuh8lsxiudFQ5QZq9JpzpPEJhIMOIIFymvCKa+KocN0KwuUk/CA271eRV4eEzMN61k/6Mz2DJvW791nKN/6wOkqJXh5wVBiyj+HeMp+Zva1CryTw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:08:58.7113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94846c2d-e708-41bf-6f2c-08de84f7e640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8b60299b73ef7..58c69dcb527f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7011,6 +7011,11 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
+	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	mqd->cp_hqd_quantum = tmp;
+
 	/* set static priority for a compute queue/ring */
 	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
-- 
2.53.0

