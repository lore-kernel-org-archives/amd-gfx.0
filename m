Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D11AD3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30FB410E49F;
	Mon,  8 Dec 2025 17:17:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pPzcNq8S";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FE110E46A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CS9aI/xA9oxj3ZjiiQD43d6i7ROrFu4muO5zQxkEAh7vmgXIh8wjpfCDRuoLr6naFE4RQ6kYGZvWR48de6l5ReTbxP6ZpHASOwS5NbtbQ2Y1pWB387AhC11zBGlDh9BdBg+Q727vVzU+EJi4fUtw6K08zQymM1tpoazyB/EYatJ3SCh/w0AUnC0YZyZRi/ilQXuQMq+qYuSpAjnxhUxa9flNwgYYBNdpdC/CbvbIdrJEjycBdjlsK8HpiwycxhJkPgNG5//5Zr0tkxgavqUEnFIUbSbRIrgOkm3jz+OClm5/KHRhzZ7TptN95u58Wv0/zIAHQsyVyGtowzFgAWs+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7K74U+STWCaGQXPEgCQtgYAvnKg73K8oJT5KQskzuw=;
 b=LM7WLmfF5jYOmLxdLDEekMIr+5F65XyDmszeNbzc96wPlEdrIyjsGsGk3BTR6iUQjnznjC8USnvXEVzHXYyxWa+d8dwB1hjYFwfp2v/NyCrvJJqW+njEFBD86xsYKYY5PQxANGxf6LTZ8v4ly4CKZhmHM41LMBNy76sfGmiisBErgYrsHvFW6COEnU/np2xv2E1wmcfuO4WT0dPyKboudMPcRg0v/+oEVq48HE2SHFuJsJVASpbees/B2HxC/mtDqWK+QZ3Sgc7M7SclUH6047zNg2mVIFXJvPvpiET9Zd6ggsn1700sJsUBxJ+uj1wwsWUu7o4MqxVF3GdzhaC5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7K74U+STWCaGQXPEgCQtgYAvnKg73K8oJT5KQskzuw=;
 b=pPzcNq8SA52J+4nozsVKcKjZx7v55nSPej4Rj8KGomZPD4zLIiRpIgMSAvIHJAWbj9A/iy3YFapNGsB8fXmrW3jzrlvrpVdevVF08pzb8YVe4gfdXoT+ONtVxv58pwel+QeaxH4zXU1w6fFRp/TzcFeM3kaLgMX6UAZJjsjTHdg=
Received: from SJ0PR13CA0228.namprd13.prod.outlook.com (2603:10b6:a03:2c1::23)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:47 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::c4) by SJ0PR13CA0228.outlook.office365.com
 (2603:10b6:a03:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Mon, 8
 Dec 2025 17:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:46 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Enable atomics for all the available xcc
Date: Mon, 8 Dec 2025 12:17:07 -0500
Message-ID: <20251208171720.153355-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d2cf74-600f-404d-4a25-08de367db516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+vDVtFAlgedoUDTrYVjxyzht6rqLOeonpMPlEQVChoCUTSzs8Gmf7Dvbnm4N?=
 =?us-ascii?Q?9uE/eNaUkAXctOsSd0NlVfzlDl/s2BJbiOz9P4af5te7b7yg1On4axQ1NHTy?=
 =?us-ascii?Q?LFw+kPaKxZs/hl/RMOl14dhQVdrXwJzXhtDXjEpyi+0jwGdlr2lhJHL6KZrR?=
 =?us-ascii?Q?4rnfTWICQ+hwveaPcSYo4NuzpuSDazZ9DrQxtETs9v3DlUMmrdLwitTJKdXE?=
 =?us-ascii?Q?FOW0R3zBkk6md6GhwW5164XgPFppgK6r7fpeBLINSiv7gIut73cd8Xn3mxIu?=
 =?us-ascii?Q?y1c6Ac4CDGdiC8RwFuu8h+UbCQWrVjGHsxj2/Rc+oIp+V03AHlyr27b1EWpc?=
 =?us-ascii?Q?xB50ZyOKfw1HDlOqulGnapa/01pCqGGjpejozAuwK1zKkEjseUs9p7JM6p/H?=
 =?us-ascii?Q?YswVNZ/AmlSle0jM7MyyAzdJBZl5qygoRjorPkAQMhfuX+qDeSqGl1mCUp21?=
 =?us-ascii?Q?3IjC3XbR2Pwwg0CMg55VIDzWHsnU6RV1qC9x9jlWMnRJSTxtgjlHuA9IT1N6?=
 =?us-ascii?Q?rlHio8e1DEwaKYTdn+lKhygUahSvxxhigMIy/ACsASmmk4orzFy872UpIgtI?=
 =?us-ascii?Q?eHoO0xOay07x1dm8lMBp0loDwIqyC/x7vjrKo3dc5nMMXGQBMEoW+rbQE2vZ?=
 =?us-ascii?Q?BM9Ahsttc2hhOlitmbfu036nAgd1kuF31UjJAmFDa0gfwNORlTQc+RsVSVJL?=
 =?us-ascii?Q?heJEt1DlojxlXd2ck1yi+IJciugSsRGnriRUEN5OqJSy7S6UiIh3oRugnYtX?=
 =?us-ascii?Q?qB0pgB5ztm6JTVCHVRfU4Bulw6OlrUqCYcB31mSu+H/sQhZTzQ00vFfUnjqx?=
 =?us-ascii?Q?SnIZjN+YRTkBaw9IfK+7y8vNpVorRlULTQg3k0wV5uUyHnPQMXOGUdz2ebFL?=
 =?us-ascii?Q?p9M2OqUq9aFA+C+nF+1aM7M3wfQYcx/qfyElI3H0ekPseLhow1Y0ZMbLQBj8?=
 =?us-ascii?Q?dEZbfUwkLlgjzYIMHMsvXMdBGGYQntsc5R4yr4DImNhmplfa2Lk8rRHc7rOj?=
 =?us-ascii?Q?1FZeL1W9Ja+k3IC+lndFrAwRZ1IsgPvnrAhOkjnvWAiAfOu2vs0bSEYHrv5Q?=
 =?us-ascii?Q?2s2eIFUex7rlmWzsJxLCg+uZPb9z7bvj87SlMqQNsWTNyp7EfUZGGpDu5LaJ?=
 =?us-ascii?Q?d5D4o/t9v4bLmClhsNXueIOKmvnvSu2e30g+J5uB9n1IV8FTm+KipoTvtv4b?=
 =?us-ascii?Q?q04I5c1yzWs9cDqajetZ7bEDFmsHPK0A4xh/xfBSy49vu4JjOe9JbZITw1EH?=
 =?us-ascii?Q?m7IVPCCfuh3ueSEEu9WOCjkAIe1D4H+ekUKIzOUJgYYJq9tvDEBZVT37cY7o?=
 =?us-ascii?Q?84uu+lHk6RJNBSBj5zJreCXsiN2D+Y/rvRhLzwZJ0GJtL81pa7ibT+CNYoOV?=
 =?us-ascii?Q?t+igUdu0S2+Jnl6I1pd/Lt9KqKXV4FAhvCKxLHEnsV6KU5wWF9uR0fZIQLte?=
 =?us-ascii?Q?no79aJSmgcWu85TWG2XT2rVlltTQaXb5RR57xITR5+40rGzmf/oneGqmFD8O?=
 =?us-ascii?Q?lP5tHbT6LnC9lXAZ1oOTK4Jh207ZIikfMZV3j8XTV1RFI9P9TYREXILyDNy/?=
 =?us-ascii?Q?MfJSwoRiMjJYBtqWLqk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:46.8783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d2cf74-600f-404d-4a25-08de367db516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Apply TCP_UTCL0_CNTL1 settings to all the available
xcc

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d9af479bafb78..285bc37846ded 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2511,15 +2511,24 @@ static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPG_PSP_DEBUG, data);
 }
 
-static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
+static void gfx_v12_1_xcc_enable_atomics(struct amdgpu_device *adev,
+					 int xcc_id)
 {
-	uint32_t val;
+	uint32_t data;
 
 	/* Set the TCP UTCL0 register to enable atomics */
-	val = RREG32_SOC15(GC, 0, regTCP_UTCL0_CNTL1);
-	val = REG_SET_FIELD(val, TCP_UTCL0_CNTL1, ATOMIC_REQUESTER_EN, 0x1);
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regTCP_UTCL0_CNTL1);
+	data = REG_SET_FIELD(data, TCP_UTCL0_CNTL1, ATOMIC_REQUESTER_EN, 0x1);
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regTCP_UTCL0_CNTL1, data);
+}
+
+static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
+{
+	int i;
 
-	WREG32_SOC15(GC, 0, regTCP_UTCL0_CNTL1, val);
+	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); i++)
+		gfx_v12_1_xcc_enable_atomics(adev, i);
 }
 
 static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
-- 
2.51.1

