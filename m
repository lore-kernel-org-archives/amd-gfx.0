Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25245CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B717B10F774;
	Tue, 13 Oct 2026 11:18:31 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F6F910F770
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYGWhtZ2Vg0LqX/B0SjZzaCatKzaNphmqgfPCfY17xfhJ9PEqWspPlcDSSXrziMFOufOEG0au+uTuWFwZb3BR+LNw/EiU8rDxpd66C7MUj4rCfhZIzGc+7NELHV4H0ALNnExK4NszYYKb8Z4+PoolyJB6G2D42Oe1sfm6vmnLwSJKhgkefavgSmdkdEW27Xh3KxymNL1d/0e+KqrHhQtvdBK/LzYAlt/YljImL59/3I9L7VsQ9yMemEJro25dTytXmj6++gB5YscpBqo0f5rsFlM8o9L6bnge7lCtXKqldr2cqPEPJfilNhoEvCFml07BeP4QbL1fS2XFP2wXqA65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+sVYL/yICjXRCVf5bRdw0JSA32dFHikcXzFQwdZFjs=;
 b=Xx/sZ7py14LMSFn23s04jTYD77uSMEDyCcn1KPtnq3wmH5BlpsOtIZC94LGnQY5txyIaLY9CKE0y1KF4Oz8biyJZtiNylnudXxUrNQcb5p9XjLMnc669MvHragcUVGwCWXb3kxepjC/wo9aUNleJy0K2v/aYi/Ot5YvLn5C4w8RFxf9ID+8Tm6mA+zMXxzh0/mFb78mnHPct1sShk0blrc9YW9kPrisFWktxtqZGWbLK+x/ysEr+O6L2rL3LM1flZrT2q724eTuOHL1NmM1ciG9I/g+ZfU4o+M04RrtvaKwED67lkNPDHv1KRNNeDMbMV18ycLm4s39gW+CJyC+qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+sVYL/yICjXRCVf5bRdw0JSA32dFHikcXzFQwdZFjs=;
 b=N/mHwMrQuwQN5aEwNeLhNDnhgHI18vUZ8ar4Jrdf/yMNvPipQAOKNk9k25klj/kQ/xcKfQ/PW6R2jldJxErCqoStbY3jHObFw61IRmg9QQKTZHCYZw+hfKIiUe0ztNjgMreLIuMCeYkN61MX3VIQ2Sag15WSwXa+AJ70NURN9ps=
Received: from DS1PR03CA0005.namprd03.prod.outlook.com (2603:10b6:8:450::18)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.35; Tue, 13 Oct
 2026 11:18:21 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:8:450:cafe::6d) by DS1PR03CA0005.outlook.office365.com
 (2603:10b6:8:450::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:18:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:18:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:18:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:18:14 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:18:06 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 16/30] drm/amd/display: don't WARN when removing an
 unallocated MST payload
Date: Tue, 13 Oct 2026 19:08:03 +0800
Message-ID: <20261013111616.2267344-17-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bca0bd8-4687-4277-aa62-08df291bb059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|56012099006|11063799006|5023799004|10067099003|22082099003|13003099007|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: pN32i4Sx72AiOBjsaEico5kTRAqJvp/RKwVFSMMNjnxliuivhUAHcU32gzD2wZtHgxEkNO7VInbx7X3Tt6ruMztGUuMglJP5398Br+HIuph44cvveQfn6o8Q73sNpARLEBz3q/RAbWpppBtJG6i4ZrDm3iJr7ebjPVE0BcX4f8bcPUVb3SEDqQRPhHyLG9/Cs8Ea+9fpjKbkb7QTIbGk5y38Auyj6AYBD1om/uWGhsXayyzQtfBQg1cWyzv2+YV/NAK+p1zTkHCGzgkPOaQenqkIxuPuxWm5u2Yq1rXJSCbS8Vu9aVD+UW3thttHCninVjfeTkiy6bFHZ7js269SEpN/AvAvpZKNAFxp0teAyEW3l/yOmZm3SkamVxzstM7TaOMaqltiOHrT71AFzpsTjKqVY56FmO0wBNnl02bNZPavOXb2WCNXmAUGf3WqsbzrU9MJuYlcx4tfaAepCcdz9gpMfMdhPZtqDbQJDCm3V6eGaylj31OPeUa8trY51T75ffmpzVGiT8T2blxTBiuBYJM+LA9pODVh7iJsdDmEAsJdk6SKO/hpd0vr1Q73vFD4H9Q5qwzoeOgE/KmvCS9pbH1TnnklQN0T1NtCAIZ0yI9CKVaL/eU8ymvaLruM0BEZoCST+Gg1+mVKU+m8eawQYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(13003099007)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0izzdURYC5H2GjTlAfBYE+kOoTdqGjlKsJQXYHxEu/uHkesHkNJvpRkFHj/TUCZgYr9YVfnmApbv4iJnVJCbSZk4F6HTfpb/WegOnZ747oVEQVpSD5HAtcbfJoFSi2RT0nbcAAMcYRYBWYr2a2J/rFyb5E+i2MrHu22yyuNHZIH0UDnvigB+XFMxYD4B7XZf0mjx0d73m6vJXYmQj4AD4TG1vJehfZFk9Yv+FoiLxAh3Xeuuo7EnhNkhLe0IVbIA/e5psYGXRkORMng4JpqdQyulYaxisriQBfdun6BlOHebVZjznpaKOV0FmfADlYF6Tgw6u6FJv3+AUIevxSuQja+S7XIMLPUkRgsY7/gW5g7WY4xlmTGpU/ZfeNm62Ym90Pz9AL5S1EasJ+fr0Eyyg5RcXvxCv7mUmkecCFOSLdT/S61IfsoUpr4h4z66nRqo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:18:20.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bca0bd8-4687-4277-aa62-08df291bb059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
On an MST teardown that runs through the reset path
(dcn31_reset_hw_ctx_wrap -> link_set_dpms_off -> deallocate_mst_payload),
fill_dc_mst_payload_table_from_drm() is asked to remove a payload whose
vcpi is not present in link->mst_stream_alloc_table and trips:

  WARNING: .../amdgpu_dm_helpers.c:275 fill_dc_mst_payload_table_from_drm

This is a legitimate case, not an error: deallocate_mst_payload() can be
called for a stream whose MST payload was never programmed into DC's
HW-maintained table (a new stream created for a modeset whose enable
never completed, as already documented in deallocate_mst_payload()).
There is simply nothing to remove.

[How]
Drop the ASSERT and fall through to the fill loop, which rebuilds the
allocation table from the remaining entries. The table ends up unchanged,
which is correct: the payload being removed was never in it.

Note the loop must not early-return here - the caller passes a zeroed
proposed_table, so returning early would zero the whole link's table and
drop the other MST streams sharing the link.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5875

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 2f9c98a89c94..9774ea33272d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -309,7 +309,7 @@ fill_dc_mst_payload_table_from_drm(struct dc_link *link,
 				break;
 			}
 		}
-		ASSERT(i != copy_of_link_table.stream_count);
+		/* Payload absent from HW table when never allocated: nothing to remove. */
 	}
 
 	/* Fill payload info*/
-- 
2.43.0

