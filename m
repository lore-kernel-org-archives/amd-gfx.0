Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F18F53D8B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 19:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA09010E359;
	Mon, 16 Mar 2026 19:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="heAST/6I";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013014.outbound.protection.outlook.com
 [40.107.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7419910E359
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 19:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5aIATzmpJwlcd3tItdDzS4jPxGd6EF1mTav82ExUXNoPnBRC5X/3eSCOMHxCsA0gXwWjnzX9Jw4j9EClnh3e+uwW2qXBPFHqbc9QxpIrPLWd0S12WGyTQtxEq8zT1Y47wGlWZblKxqinTd7smo0u3SKUXiNLlSm8W7Egz3e9x+1LVPKjTCQtVMnLiwRC41y6A6ofTpXqwcwJQsFjWJsWJKxcfCij3mXIH2vGNisYhZndFzHMgsxRoT/IgLHxIAdswnuTfhtnyI6288oK9xTukmBxGNXfCN7NKqEKWUZGVe0Lo+ZXcLt5QNrLm52oGIjtf5hmplAXum+tZbeS7Qcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaY6oB2t1h0O4H5N0305+zrkJYLaiklz6qVOHP/4U7k=;
 b=tl8H2cfIRziCpEsYJF+wXC0cNeeYmdXjJTygWVIU+f33T1EC8W7PV+HfKQHDjS0GRPqOGY2JEIZ8Hcd0oGAsl+HRdj4P9bqBD8Hj0lRe73j10fFah0HsMUPo0BCeW5vKg7rn3IwPn4NhmsTWnr4O0xjl2Zk21QCQJBPWhVUDYrvkeFNBu4eL9O/4qanutG/C4CblXXT8SIrbg/n6beOh2aHORiSExOthd9GOPzCEyXhRbFEjA6lT0ETk1iZF+a48qtkkfZgMFWtChBQCsOhDR+XzbxkVmL3mjHa7Ee3IK120EklSTBvCpWpuADqwslBeKKrTWrj9ljNlBnMbMi9hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaY6oB2t1h0O4H5N0305+zrkJYLaiklz6qVOHP/4U7k=;
 b=heAST/6IZhxq+tU24rgfGL1FxMSYUu4Z81TUD7k3/06UXxBlgf0Q0XRkfWb6ubzFwdoXklMcHayieemav/+mDbFqobCvWFIrQpEkz3rLBHU49JPb7mRnaVY/IZQCUO2wE0rOExBTTgYFlTVYoCNA4tbwDAymntgX/qdb/Jzdr1Y=
Received: from SJ0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:a03:33e::9)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 19:53:01 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::7f) by SJ0PR03CA0034.outlook.office365.com
 (2603:10b6:a03:33e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 19:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 19:53:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 14:53:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 12:52:59 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 14:52:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH] drm/amdgpu/gmc9.0: add bounds checking for cid
Date: Mon, 16 Mar 2026 15:52:52 -0400
Message-ID: <20260316195252.2027784-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: e92bb534-dd1f-4ee9-f75b-08de8395a126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Os9Gm+UV64kxxB3iKlG6+JEiXYqbuSYs+dH43Tuto7GBJXcfwDW4dyi0K9/wIQeWZrHu8IR+PPRVtqLh5YYcM1IdbDP2dmRmjEr6aZgoWLpQmFycq9HfEU/WwEeEIQlDoH3Mh8uRgNicDi0qXhhy6S0bHowJWSOQxJchf6d438KRmXSNmaHFG7JASwat3hbMu19ksFKp03yI2iV8+yWZs+8ckowAwiwkvDmL3TZwfe5jBusl1/Xe3ClDRW8Vm9pzhUdbnapOGIAANqFvjppN4RxXBtRcQhPkDgiqf9MTTl3mIjuROkDlwWmtJVUCayj6pVYQcI7Uv7V2TyY01OmZoRGesC/CkPIR5yjSAHwHRXly/MMSQGJJBNtyZvamikYbxHDdRC2iDTcfEGXHbTTiLJ6N5ZC9g4tKsJrUqQnt/CNZaYYSEfU+qn8hQjIGYD6SE8LXz/aqIkIbz9NLU54gcgh9h6l48r2awDRForh56096fbYgQeLRfyUAz/ldefa4SJ6dtzWfSbztiIjjENYAOSFzswF/WepgCo5ugcSsqjGQP2Te7ZLBo27mB0hrCVS/oUiarc0W83pPfhNHpgR2oOeIF7i329qV3IN4in9snXVLxebBwAsutIdaIZj82Dwv51qH0YjhlGoASLiHywPI0NcrduiU47qEoK+Zkm6YVAp/ul1WHuCFbXrNw0S8IO2BOj/S32ijz5yQ6jb6q0GoD3b/O+vzvjBwqL5WTsZXcbl5RujCkP4WF3TzP15Xy38QaN/+Pdp203YzyYMQFJeVpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: osqPUfCI0CXaX+sjG8MxYG4O0PygSLi3ZuRVUrAHZwJ96Lq+BmK2zsDFqoCooWdtcSP9oP1x9leCR7As/6frxrsQq5V95AzQgIP90YRzafut/MdT4aa851XO9d7JaBjBjxJLkv+tqTPhfrTUhwgSoQy0IRyYN5jaEC+uU5BnaHejCf1ozSEl9NiJrN0IsMqq75V3xwiUppJ4xvUDyBB9x8FCoGcP+cSWPnkjVyKFA1VNslFfs3IvokDZWmPpgSDaIXfRa5BLp9/Zgqd6jqYZ3sJa6oBcLndgfJdzaf8O+UfP2I2HybztVVdmgfIieDSD+2n2GGiqnjGhC3VlNapBv6DelgjzJ5dSTi3bpqzsDzxMiBRcMyusUhNcp1VNPU8plLRZqNbBN/hIolFYKmO6S3ejIi1mqutdlogLoKYQIjow28mkItpCfh245gTvRe00
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 19:53:00.9437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92bb534-dd1f-4ee9-f75b-08de8395a126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852
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

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Cc: Benjamin Cheng <benjamin.cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e35ed0cc2ec62..8eba99aa0f8fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -662,28 +662,35 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	} else {
 		switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 		case IP_VERSION(9, 0, 0):
-			mmhub_cid = mmhub_client_ids_vega10[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vega10) ?
+				mmhub_client_ids_vega10[cid][rw] : NULL;
 			break;
 		case IP_VERSION(9, 3, 0):
-			mmhub_cid = mmhub_client_ids_vega12[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vega12) ?
+				mmhub_client_ids_vega12[cid][rw] : NULL;
 			break;
 		case IP_VERSION(9, 4, 0):
-			mmhub_cid = mmhub_client_ids_vega20[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vega20) ?
+				mmhub_client_ids_vega20[cid][rw] : NULL;
 			break;
 		case IP_VERSION(9, 4, 1):
-			mmhub_cid = mmhub_client_ids_arcturus[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_arcturus) ?
+				mmhub_client_ids_arcturus[cid][rw] : NULL;
 			break;
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 0):
-			mmhub_cid = mmhub_client_ids_raven[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_raven) ?
+				mmhub_client_ids_raven[cid][rw] : NULL;
 			break;
 		case IP_VERSION(1, 5, 0):
 		case IP_VERSION(2, 4, 0):
-			mmhub_cid = mmhub_client_ids_renoir[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_renoir) ?
+				mmhub_client_ids_renoir[cid][rw] : NULL;
 			break;
 		case IP_VERSION(1, 8, 0):
 		case IP_VERSION(9, 4, 2):
-			mmhub_cid = mmhub_client_ids_aldebaran[cid][rw];
+			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_aldebaran) ?
+				mmhub_client_ids_aldebaran[cid][rw] : NULL;
 			break;
 		default:
 			mmhub_cid = NULL;
-- 
2.53.0

