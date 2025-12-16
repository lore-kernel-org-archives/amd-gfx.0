Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30271D637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B55C010E710;
	Tue, 16 Dec 2025 21:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F3nZznjs";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD5910E710
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlxmHhlX7KxD+w7q8S0aHRfSuyWEqziiUq6BcN7KCBHSC2qZ1hKOQ3aUU0/EEQboSCyHmj8JzgcpztAl03Ot1m+LsVtKIiuU71gzqXm8mwb0lKoGSJqFIRBfkObQSE5HWBC9C9yuB/7e0RHdR8+RVZXEXm6iMj8prSQh40qbNByh6AcAPPGmwALuj402CXI5oEMxFuN0zo1nN0WyIIvQzE2XCXemO+RCwewa5QoliYxGIj5kbiwqjx3dA1nEodd7KVpZgrrlycM3fAYx6As7JV8HedKK9nkFcPANSJtttpIrtJm2S10OMr0aynOvNnoTnM5lESN8jY1auiSMfdsrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVHLJlcZo02z6FfALWT9cPTk5CzVAnCSN1ulzAwPNlg=;
 b=qcsH74edwaMh6yyi055wP+fpXLXZ5jA14kwtKAVP5okVIVSrsbY2rLF1NiIG4/BeDhKRdOlzOOcYs6FK/Nik6AdYb9iA9ZhF+2UMNExigwbOQL67Ykk0248ElWRdn6PxnRZjji03PdCeokSQoFFsBIMG2rfH69Hj7EdSJmLZDg4WHS2pMaVywvx6BWR+/RIeSkGkBomVa2ejW4KbVnbYYLM3kEFZQ3BcvbpLlWZvRrRHa0y806VX9BYGZQVYkyBfzSy7RYvR+JmuHflnL7w+FRQXvEr6kFgLXeasFauisaWBv9rRfKi3cffSbaTqyXDaZN8OSo7wk8mLBnQL5ubF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVHLJlcZo02z6FfALWT9cPTk5CzVAnCSN1ulzAwPNlg=;
 b=F3nZznjsH5a97q0Yjg75LmhZeQeZSUPwcqAH/q0kOOBjeEEIoBtkJvQAZosn3Z1DdsMup6HcRO1yMAEsVnA3kRZbdyHXSK7MgOsngQ8OkrkyGwR7YfvxufMLImetPKCqb7xjgTv0896M48pRQ+v3yWfGXkvuzZVVx3idohXLiIE=
Received: from MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::34)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Tue, 16 Dec
 2025 21:04:11 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::cc) by MN0P223CA0019.outlook.office365.com
 (2603:10b6:208:52b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:11 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Update TCP Control register on GFX 12.1
Date: Tue, 16 Dec 2025 16:03:39 -0500
Message-ID: <20251216210349.1963466-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 486aa26a-b45b-4ec5-8ca0-08de3ce6a947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/TkXGgeFfHlujVal803o3s4nZwjwFo/iYBDlU59tojTjKK9yjwytDRRueBC1?=
 =?us-ascii?Q?yJhlhuUUTotVUOnmfb7ZuG80ctYPX6IePbDsdmiIHMw6KP5zs6TbH0Ajrx3s?=
 =?us-ascii?Q?MTtJ44rzncGQm8A2C0pxb7DhfdbPBFusgFEftL8lEUverexCfIclhd+v2gXz?=
 =?us-ascii?Q?KKT2YB84VetVjwyrgn05zLRYTKDgjPz7HDwINdejb/g+66Y5LbD+bs+Nmxv+?=
 =?us-ascii?Q?eumlARNWJi0YQFPl+MSoP5YWgs12BCzFdj3e0GAT1VgNd9qF6m7QIbdPmIte?=
 =?us-ascii?Q?zSZq52zLvFd/pwEBDULnYb6MKNnRvER9u/h1SkjXr4yVuqd7e8cwMfO+kkaM?=
 =?us-ascii?Q?htLLI8wtGMaTLbPeFpRj8Ya69IwaHbcbr+boSiHlt7RQR//2N+pTsTSwavlO?=
 =?us-ascii?Q?QUQgqgAlPSw5ubZsNjEBGmpb2M0FlEImlgclNCRwhTczef+w4ooFPYYN64b+?=
 =?us-ascii?Q?Rm1FRuLSzdQaV2R9FkUjYGKWiCHdgq1wdDqnUTEeUW0+q6n2yS9bd/ks0Qd7?=
 =?us-ascii?Q?JFKpOuiwvlCgO5zy8w7gYo0VhV81kwB5BmIT3EBX3fK9I/4o3sH9bmp8yZQ7?=
 =?us-ascii?Q?V6nVrscC9My7XvWPoc4mRdLHuAkYwcDtp6SJVdW9m79Gyn0qjoOp9mrIivSE?=
 =?us-ascii?Q?i0Kan5GP1gHGa9arBz5G0Skmsr9v73NRU991s+p/1EVywZ5Z+MkPV4Va2g75?=
 =?us-ascii?Q?ML0iKwgfjNH8dv/Cehu133q1yAyD69I98tXyQ2bBH/UeAB1EZ2/TeUBscS1G?=
 =?us-ascii?Q?CewLzC+PQAjz05aX5Wb65p2p1lw0UJHcNtKDq+jxXVT31v9VafrfG2yYwD+w?=
 =?us-ascii?Q?XsYzQgqhsBhON52sByePiB+PX50cDrmjVSsGrlJxM1Jzvzws+cWoz9iOwGy/?=
 =?us-ascii?Q?R4joIBeG5cgTEsxnEf/CiZEPicSUr6Oj3uVk2ifJstnU0KfiaQhWUHe5xvVa?=
 =?us-ascii?Q?1QdIGwxzrGGLTLdn7IGDH1uQ7oQcb5oBKWvDVy8zWtVxB/qo0fbCVvqw4kyW?=
 =?us-ascii?Q?jgXHIks+PGErm9BQ2Glp1HQpn3rSG228CUujKM+9JZmH7u3bSh+nc7PjL+hp?=
 =?us-ascii?Q?GdCqajDN9H3TdSkqnZ5GqC9g/h3oork1okQpa+jAeNoGzNeofhFL1c+DzyKY?=
 =?us-ascii?Q?YDQcupEbNpYqVCaedNBwNDRjYiOqtLE2iLdSt/UhyKy2SMbO9yqSOj+SHrkl?=
 =?us-ascii?Q?DX3ByfrXKn1+UjJCGIK3m2DTzgmnPS5h9yhDm0HbRMirwkXd9OO46O+YRjZE?=
 =?us-ascii?Q?+GU20rFhCRHqUSi7+oN7SRKg7odoT6gpd1kOZY84wErNKyzfXpl3knJyxcPC?=
 =?us-ascii?Q?wgMRwsL71lcqDr+AifPik32kyvZ4N2MgYChCEZZCxBqGGyIVRTfJ9PY2JBOb?=
 =?us-ascii?Q?glZlXK7FV9tP45if4xsdVip3+4LbGLbOYONbdixqTp+6I10xGuuVwh0OZzxd?=
 =?us-ascii?Q?k3EnwITA2SUhdwAMZ2oBfzpQzp6Usdtvw+rotS7a6Moiz8U2aNnNsH3HLGpE?=
 =?us-ascii?Q?Zd6WqsJ4x1ca6iTSS++ZvzEsbc3IhZCxTQ5NxMXAc7Y0PV5SUo/toZdpnVXd?=
 =?us-ascii?Q?8sfp9XjeCvNlL6IpwZc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:11.2934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 486aa26a-b45b-4ec5-8ca0-08de3ce6a947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
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

From: Mukul Joshi <mukul.joshi@amd.com>

Update TCP CNTL register to disable some features not supported
on GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 6196c679f4edd..2251a2b1c5bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2668,6 +2668,17 @@ static void gfx_v12_1_xcc_disable_early_write_ack(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regTCP_CNTL3, data);
 }
 
+static void gfx_v12_1_xcc_disable_tcp_spill_cache(struct amdgpu_device *adev,
+					int xcc_id)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regTCP_CNTL);
+	data = REG_SET_FIELD(data, TCP_CNTL, TCP_SPILL_CACHE_DISABLE, 0x1);
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regTCP_CNTL, data);
+}
+
 static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 {
 	int i;
@@ -2677,6 +2688,7 @@ static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 		gfx_v12_1_xcc_enable_atomics(adev, i);
 		gfx_v12_1_xcc_setup_tcp_thrashing_ctrl(adev, i);
 		gfx_v12_1_xcc_disable_early_write_ack(adev, i);
+		gfx_v12_1_xcc_disable_tcp_spill_cache(adev, i);
 	}
 }
 
-- 
2.52.0

