Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6F606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fNFivNFS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C6310F8CE;
	Wed, 11 Nov 2026 01:42:32 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44DB10F8CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsUc4j6NEkojHBBC74kVy6w+emdADMBcOHnojQS0sPGxhflNZR6PInBBkZHNcwT5XgoMG2mNaP2S2SbwPjjUxRr6tThS/ElBJktEe0irWZDMsZs/C4ePnO76PjdpObNvbf32P7+ZcrX/wqB63OaJDZwZ71VNhxgoatoccVqPbmeK5xpqaILGAV9d2aivTnyv+bOcxxg+UsbSu3l5mJkX4L4TRaV4TrHBg1r3By91nfGb0HsuEIxkbY2IFhyTy0wljoRR0NkTC6wi2DU3tx4BsdR4s8a9ncpCyxWJii0llT5wE939N5MEPTdkUR/xa+kaq4A16Ue1uozHwetsIIRjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4XxkyhWoyeDhucx9wk7/vJs3QlANhbPb5QPnDex2e8=;
 b=EPmt7o7Z2qh4bq8FXrMXoKDlxo21A7XcwEMY9Ss0sQKHz11NnEGmJgEkLAu171d4ENdXUG1HOCEhSnaeZoX95CoxZYSubhfyE5rTeUTuU+xDzxhL5CbyAVuBuaQATqXw500gBjVUhojQhpux++t19q23w/YRf1S4n1scUGpuP5VNb0cSe8ZhW+NB6IxAI6kbRgT9dHlOyz3MUG2IPHStPOLvrJZGLpm1HoI1h7OFoLUbJkMrieG0dDI1mi73oH075acHXqo+ECHnRL7+9MayZKZY7MuBU/Q8WmrQCApfIcWTQZy1bEOxrLhW6IP4QSLokgu7nSeW+cd8bftg/dHpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4XxkyhWoyeDhucx9wk7/vJs3QlANhbPb5QPnDex2e8=;
 b=fNFivNFSVLkBlHT139MLalxBFGXOpd+BZ1T/XSLklI7Nbukf3F1jTiOCwcA5pKH2ZoKbR8sYmOOVqrv4NNbQ9YFrJhVuvVhKvw+Myzfnis6Lza3qIYYd2srJgcwvjnZSXVdPmDfwPj71e+gnUS9hSjLD+QHFmmVWh4lQnQlGFaE=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:42:18 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::e) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Wed,
 11 Nov 2026 01:42:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:17 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:17 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:14 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Aric Cyr <Aric.Cyr@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 30/74] drm/amd/display: Ensure exit IPS before checking flip
 status
Date: Wed, 11 Nov 2026 09:28:36 +0800
Message-ID: <20261111014100.3596072-31-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 1519be72-6bfa-4dfb-79b6-08df3f950575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|261102123227099003|261021135927099003|261021121427099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GB04C4VjN2dVaCQi8VmuGNWdmuZHww+yMUEuu/FJBmeuO7QcrNrIMixQJbESYOs7G0PRqQ7BCYQ7rj7PDLkmNaBRwuuIAN6EF4NkM9+QGXZKQlxNuuLwYZcFJAwLe6Xr/BQZ33j+r6e/kbCPsVxF8F0UzFVPLTaF3zX5jQvD0/FDGX3wm4vntQ5aADk1KIArg5RN1Nc3mlg1n5icAJTpsPb4YVjx8yJDF5CFrs2PZU69fqCSoOKPDEk6YsenAigFIsoBtAaNE3+sFO775C+xysoF1wSwwIe6VNz5TDhzZhhj+59RJrmVb6V3h12vTcG/p7OtdT2wrD6DTk6cfqfQ/3C0NzcFcfkEEytYcFGq5ZSRoNFWIjx5GH+e+JnDa9ueIb8QnYnHjMDsJFX49S67+NXrLrEs2N8XBHmmSKp2i/8TGRzqP1K67NYFgP3GfXnEvlRiwEsxZrQMR26p6PHZmCiydBPkBgFV9DFJmuf2UX+Jul2w4xax1XIm40cGdLUKDWng5K0UHl5ega5wFMWS5VciKNOse9TOfI9VUP3ksGEwDI+Vtku+3qTSLuPgMBuT/rcOHoR9XL/ovjFMeFd0Hq+1BCk1UQVNkir9AZeZlIpdmbLYHryE2dWacsW/lz9OtRFzkRlp6eq6h/Nn6Xq2B8xjwJkzTr8OgK1ASXwK5dIbHQjh59QbTHhhiH4w096iZ9001/QAjkcKFi4PFRCBNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(261102123227099003)(261021135927099003)(261021121427099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YvByhwCmE3dwIS6TdGArlCyi52gJ/RmeEbsSlBmWRyOCOOBQCp3vVsDU0FltvSoCu195GofysXXFpVgiq3AxDK3YHb5HcZpgY2kLx0yVLSnzfu+Z7vnn4i4vy5MZeL4T25lnTg1LcXffrlrR5YAJjT/osV4Hg4BQXbyIbczNSn3zatCwf3OVEPLLsnPY+rNijEAJAApaoKGyg0wPCL0ziw5F52a6wjfhIVB1Ao78w3DR2AfRt/BYsfJVmoWQ9yepPEwvuPqvCE4Ducx/NJZ5F/+qWecY1uxF3+duMWXDsUBvWkMcO8x5ve6UXBF/sTgxgDu4Pe7VOZ/FHQj+hZp/0wOg+//EW1bYA1HHZ9U2Rry77NKHAmQ/7JTfl+dZS0MlnwJbj9qwHjX38lrCisRlyrYRcdRmJJ1q8dp9B3MmiMLey58m13t4gF/OdxzWfu4r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:18.2890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1519be72-6bfa-4dfb-79b6-08df3f950575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
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

From: Aric Cyr <Aric.Cyr@amd.com>

[why]
In dc_post_update_surfaces_to_stream flip pending is checked, but HW
could be in IPS.  Accessing it could lead to a hang.

[how]
Enforce exiting IPS before touching hardware.

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 85de12c558ad..fd382363a0ea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2850,6 +2850,8 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 	else {
 		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
 
+		dc_exit_ips_for_hw_access(dc);
+
 		if (is_flip_pending_in_pipes(dc, context))
 			return;
 
-- 
2.43.0

