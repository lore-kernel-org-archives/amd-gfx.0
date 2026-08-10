Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C13C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211CB10E153;
	Mon, 10 Aug 2026 03:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CGLbaOj3";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7942610E153
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQlyPpvQGXkKyaDgXm1/JdZGEFzc3OApibFurCUTO2v3hqdAQL+aQhCu3d5PxfTFZADAZziDAXISzhpZVmMmTiHdzZsfjWgB6djpz2jGBmBuNSHOMPYYiiwNfe3UndyUvCE/cC8ls6/bQcIFzPLrytQApVoBnuAt+2toneqXzSsVZpsLGuiozYrbuW74EsDlQMAko6doaBkF5pYYZp5fVGwNd07JjlfFjY0xFojNSNwuti92sopvaFbd0Xgp+Ws+W39+9dHluPLv3HDcnHGPrUrfL4zEtQKHu2nbGl0BdgOpVEP2+TzBzeRZy1aXSi4pZ2OpES2ktL2MyVKGJLfsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1IH2GCuYKuVrBqathWEBn/LWK8S2joYvI85fHz8Zto=;
 b=xlP8HZdTtQEFv0YXLrzS31etYWSkG/RNNS8kmcU92oc6XqZCiQd3WQaKQBhip+kF3nCQAfTeu7bFBZTl0UWRYKZKQvGxTTOZSPKBjRZw9KpzqfK/MZl93B3h3T/BII0d9KfTAKjpVXawehtFW+jI/vYtsJhCja3/I6atKeAuMC7HpVvGwPZ9rw9Bw1XtVTR/xBIdpCJVsUuHMugJHomXnb8IREfkl3H9XwvaVHhTyDDzVCuo6ulIzWDhrfF1WfhdTOYtpUAkdTpjLOd7hIsvcK89KBjO60KAOSdCS0sWvazFuy85KWab26yLtB3SBaOj6HsJid7WDNhVlGVzEazK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1IH2GCuYKuVrBqathWEBn/LWK8S2joYvI85fHz8Zto=;
 b=CGLbaOj3KU+9RazsV+2C2zlATeO7BZeqlCyVbXV2+eqOmQaYA8Ne45dP0IKxt9wmI6khaqKr7pEubyW1ICKiBYqe5D9L8WyhmB51l4iTocnboUnJliPgfOsMBBzc8LrHlDQABcWtzdBfdCwm2/5jFfrjnCCSgN2WEC+s2ZazE+8=
Received: from DM6PR06CA0079.namprd06.prod.outlook.com (2603:10b6:5:336::12)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 10 Aug
 2026 03:41:00 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::72) by DM6PR06CA0079.outlook.office365.com
 (2603:10b6:5:336::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:40:59 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:40:58 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>
Subject: [PATCH 01/13] drm/amdgpu: Config VCN instance for soc_v1_0"
Date: Sun, 9 Aug 2026 23:36:32 -0400
Message-ID: <20260810033644.118194-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: a59651b2-dcff-41c3-4669-08def691315b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: D9nh6qC91nbimdwQJg85F7epg3Jd6RZoKTes60or1GhkUi5G25w23DwzhDyrpqoRo4IjL/oo55hedOoZPIKODEzOZx22tOjgRAMlR5bPogJoW30P8JDbcNfB2FzFtSR4P9BWpVSC1l/fT5+VzHOOEkjzrcUbM8sPVYFKnpiX6VQiCMScC+qJvEGLxmCwOIRI6QZpHmMOkbSRjcCJcJHHu01wqhzvQL3jtDeGna3GWzhJlJ48wSUSkHMXy4n7DaFy5iT6s9i8pRsJnw3pWh/ZFk29rBMLkxZQSkWpcUX2kSOVfl3wQZUzXoonCR+zOPvO9oGcX16NgYrsSaqeaxR4eKtHn8E1v7fihfDvS6W8YpBdBGZx+G7mssgExtNK0PYkT+wml1pzq0bNzI3Tlc4eL5CMqwEdgHwrAGVk8c5b21K9m4OPn+luQK6m2/d5fwoWCaJaXd+j/BOfC0w0754HzuMRzi3EyC6EwQ3gFAaUbfvONDy+Nvjr8RRmktEqQ+29Wx5Ypdp8A3nxhku2qwEsfI46SSvZ7bUrbrgv/HJ/il7ReilVSCzlvZsGsubx6a/lyDdej9+KQyDUwgnTzWHCajGE7lwWpq95tLkJbqfMcSeusUb9wNevG7sngYMpCxM3pG6X/2L+ldCSC7KFh5r1a/r3qfBzrI5pPpvn7uRxlq0aTkMSaVsQZolqZlOCWg9mJpt088JqagvXgk+DhylxTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I4rGPSSteNmADgfdlXk9lJ9E7X7O/9FPjBdSodWGrp27TxrkC5FCMZlzCNUtaaHNa66mMrmInbF57YmQmo2GM/wHtIBkQqfvZP3XYAXs5XVaKtBd90I9lNOjm5K1paRYYmDU1p6FwQGx+LGGhEECHcSkjK9MKw5K95WuBREVF6Dx4LuEfjQGyB9JIqCNaFgk1k9af2FwaAhrgovQXE97bb5CB3gPxpbk1k5ffRPlMKW9ZJWOOIgQjG3jcH4M47UAtVXwuXKwEwk9rEonQ4xkf4cuvPeCHgzgAUyvyKazJclmMFTdKj2Pe1aVUmdhLzeGOw7PgOghs20vl8lM6AXaaHU7jDKRCD73/MwULM7N0DukQFBAAe/ASjlalEyK8zQ4UXp0yyaY4Rup9nArwC2OXIJ98UkGK9dn+eme2Cv7qLIv3mdxdoE9qhPxFWC7mtUS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:40:59.1540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59651b2-dcff-41c3-4669-08def691315b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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

From: Sonny Jiang <sonjiang@amd.com>

Set up the default VCN instance mask and related instance counts during
soc_v1_0 SOC configuration, before IP discovery is enabled.

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 43e92e2a85e8..37e2068b6fda 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -849,6 +849,11 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 	adev->sdma.sdma_mask = sdma_mask;
 	adev->sdma.num_instances = NUM_XCC(adev->sdma.sdma_mask);
 
+	adev->vcn.harvest_config = 0;
+	adev->vcn.num_inst_per_aid = 1;
+	adev->vcn.inst_mask = 1;
+	adev->vcn.num_vcn_inst = hweight32(adev->vcn.inst_mask);
+
 	ret = soc_v1_0_xcp_mgr_init(adev);
 	if (ret)
 		return ret;
-- 
2.43.0

