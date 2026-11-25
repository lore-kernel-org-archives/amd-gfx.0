Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B8606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zzW4x8yA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F23010F979;
	Wed, 25 Nov 2026 06:59:15 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B5B10F787
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+XxJLN12hKbYo2NFV4LuHm3p4HSj7Jw0A/+OicnLq5smY7GJ5LYtEPSODDHPXjmE37L9bb7wl1/PbZXND6EhvFpQatk/6xDAD1yBxpjGiPO5+RBIyD0L25mJ3LkCWo9niVvdUGGUHSKWzOgCZGA95LcOiCKCM9XzDV5XyWfR7fOF/iW8r6EkMdBrNLAqMi3oC+OW3KWfThUj3ubV7pm6TZMcodbVXo2j7Ufy4i3lR5yaLlxSoJ+3udZOrX5MS17H4kTFM+T4v3hiaFxT9hKske5QRyG6mGH4KHoV9LzmDzqCvv4konCo36KK6OoQGPTqtGd28Gp1c+IsUl1DSXXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkuuZQ/NK5qwzVmtJLCg58iTAgPNzb43p3ComaJPkjs=;
 b=I1s2JnvlZdQjv/JB3kOftCBkgNDyA9+LebkesqmHH6R9+A4o4le7jp/1lcn8jBHLPdx8X6XaAbmzkPOJiBInaVIT9lCicJl4IO6g2kahllEzaIFuHmHKY/Rk4HsEb7PALIYGRLHg/4r8ZxQKPTyjytFjuBQ98CHr10cx7PiAw7WZBnbLypZg30IgyVhw2W75y2+sQ1nz6LE5z267Ihs3youA9K7X+jo3vJE3vHZVwK8Ml4grwYRNDvJfgvp2JwcjGYcgahWN6PCVzuTRWy+otYaVJR64FqiOq6vml/J/H7sUcL1WZ4TpWN66tckkFysNaWUaoU5eZfft1pyrLSR+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkuuZQ/NK5qwzVmtJLCg58iTAgPNzb43p3ComaJPkjs=;
 b=zzW4x8yApayN3vMUDPJkpXRpB4vHpHMwHEDG3Gk6QmprUeR96RzEpSEFDRI+e6R0Dmlq04qtv2MUCq0635rJMk97VOzNzLGsJQjQyVokLQfpPpY8sI2EvM4cncnlgHo50BfzLxizw2OFqJnr7B2ZWlgOg721ZpcaAk2piEYlRpM=
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 06:59:05 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::63) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:59:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:59:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:59:02 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:59:01 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:58:53 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 25/27] drm/amd/display: Count planes, not pipes,
 in the surface check
Date: Wed, 25 Nov 2026 14:55:14 +0800
Message-ID: <20261125065631.3889665-26-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: a5738dda-675a-43d2-ed53-08df4ac197c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|261102123227099003|261026121527099003|261021123027099003|10067099003|261021121427099003|261009223027099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Z91JofkxG3InmrER9N+W4sLhW9BM5T/oMR41qyW/Nxi+wsVPXt7C+/dw6KB9iAT0LwG4+DmO2/ifVae7JmlxdSq3HItFh0FR7Finy5BgbDgfC7EYm4rCv3XzX2kTGnJVci6ep6ND6njJdVwNYIycllUJ6tpAzUZfV6vllHm/FblEWiZ5xdN9rvFeOIeRgUZxLYzyDix/8Xbju4C/yI3Y2Rm/DCMf75SzrTWkFyVfAG2nmxhXIA+zuuFc5U1qbYPG13yVMG8/Coh5gM1hy3J2nlmABWI9JBUr75HQl7VlXfPEmLAQ8qjWUw+4GO01rtJwlLZCUnoaDJ3edfr8Y6ipBzmiSBKleMqEBjdKSvZxf2dlB6KVmW/jIqyThXTVob8S/OVtL34nZk13op22JJfpYEOB+FmJqxy0LAq+Av/0IeqxUJRdYvnPjORQdhC0I+h4b7JcLLCuKtnKtj2mFWDnigpkJMsMs8TXYouvORP6rC0mwqRobUp3XiQGzPp7R99whFscSqDYX3IFeuoCG/0OFyoJkl/ULiebHu6W9RbXOr1ThLYskUHd8fbL0ElL+u3r6iIfMtnbU7rPyxZOUQN3PERD/xFJVpNFV1qdGtbcrZRYXStMLQf1HnF3QQxQUsr+3vwO2evmtwRX4NdvUJsbMic+K28iQ0Xdq50Qm6uoSWc9c/jqm8gawXZp0GIIGaIuev8kn9RMrJ13EAy36ze8EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(261102123227099003)(261026121527099003)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +IA/gCQvYV0t8LbTuo53qXPNcGGuDBILuqgYWrGA+wpz++CXcBayk/xPl1Vw873gKdsnfDPj9faG0g1P9y3gQfSeJSP9XlIXKXeo1NnnrvAw/t87ID2JzkoCiWZJr0lB332jviiqR1qrHuCzy1SRT+2s7aGsr0U+5r2TeDh/62hZ26+uHJknIR0Fscx3XN7jWjlsmo3FSmgFTzW6wE8M3cFqN8TczD6m391yofYOwNjEhImgNeOlNSxDsDAJlRlk/6zaNAwY+HeIpjEkqeOBcTQj+MayKK4846lm9mtmt3M2fHkKvsu3Kwxo536aY8qwiNrIPmY/tIYQV07D6jiH3d78q1tKLj3WzO5rmeQFVovulaIJbZWM1jg4s0b4a+fQ4FKVO8XbB+PRw64ZcV5iAHkpb0C7eUDdj/vpQQZ3aK17ZKtBboIFQSOkIpMhI7Yq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:59:04.4329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5738dda-675a-43d2-ed53-08df4ac197c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
core2_surfaces_supported compares the number of DPP pipes of the
stream with the number of surfaces. With ODM, one plane has one DPP
pipe for each ODM slice. Thus the check rejects each plane update on
an ODM stream, and DC does not program the plane.

[How]
Compare the plane count of the stream status in the new state with
the number of surfaces. Each surface must still be the plane of a DPP
pipe of the stream. The vsync flip change to the DC2 seamless update
added the pipe count check.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index ce2d4f0c89d6..1ab1f0ec2e41 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -337,14 +337,17 @@ static bool core2_surfaces_supported(
 		const struct dc_update_scratch_space *scratch)
 {
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	struct dc_stream_status *status;
 	int i, j, n;
 
 	if (!scratch->surface_updates)
 		return false;
+	status = dc_state_get_stream_status(scratch->new_context,
+			scratch->stream);
+	if (!status || status->plane_count != scratch->surface_count)
+		return false;
 	n = resource_get_dpp_pipes_for_stream(scratch->stream,
 			&scratch->new_context->res_ctx, dpp_pipes);
-	if (n != scratch->surface_count)
-		return false;
 	for (i = 0; i < scratch->surface_count; i++) {
 		for (j = 0; j < n; j++)
 			if (dpp_pipes[j]->plane_state ==
-- 
2.43.0

