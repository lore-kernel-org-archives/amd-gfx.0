Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB2D606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YBwTa0My
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468E710F8A6;
	Wed, 11 Nov 2026 01:40:35 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9F410F8A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoHNGZWaCoTiiAupNvWIwKjPpMZQN8EpxCxq54w9yfd2B5z+UIdP2noqvxX5aVxqdr9d5sIWJkngrnDZxCaPeldyUp+G8vcEhj2oJEG0/KVH45onrBgTHsXwOjCVv/JuJlwoUSNxAcTQaoQQScXFwbO6PEmZ3Uewy7Bo+roEhl8pR1ghnGLEZ49NVb2AI/iFN+SeBqSUiVO0WUmlPyS5PeQh2DiZ771Jk4tS2DmBbbROtxfAHuhryUUbb3JnQZgUMLT98iwQfuhhVY4URnLomPEyia9MeddgEJKkjviMC0Qsb6c6doiiTnV+aLD57fWY9ug24MI+aTbHaHcCNnmYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYgWxXwMSyQlEiXhjslYlUMtRGr6phCp6nHcd4BRnoo=;
 b=T/J+kTNAEuWhXC1+uR0rJ10fM1x1BQbv3OXlewoe0Ruf+qDPMzusaBFhJ8FMNIm/6XoBriLj+FPy47WuuRotRIQ6pXBwP67nQojMdPIYsz49+ADk66PffC1spWiFQuTBo+yq2F+xic88YmGQfkAkBQZVBXm6WpdaneAsm6dtBQ8gt//yKk8qx8nneR+VgH89MznY4y1VjOQ/O3fUXCk6FEywhekcWgdSRohsz1z2JyCCwq9vHjSZZAWowbrKIg5mHi8j8AmAEKdRimHvSwqyJxmYuL8MnSOx1TG7eDDZ6REY+GhmQSVD4zca+SEvCPtEDiozXTYzOgbRpDWba3AOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYgWxXwMSyQlEiXhjslYlUMtRGr6phCp6nHcd4BRnoo=;
 b=YBwTa0MydEFeUKC2650p8FdRlk84cmrAmJ0aJ4DnsdV95b4C3zKpIQQUtK00STGwtnjBuBtCKflvajy+6/uSfb2cNlKAe8XGOUIuGasTCykDWnGpoKJEfpqTt8RXyiC2cGyKK/KoaJz7KQlDX99l2JZ0Mw2f7lcKc064w6PLadA=
Received: from CH5P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::27)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Wed, 11 Nov
 2026 01:40:23 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::46) by CH5P220CA0013.outlook.office365.com
 (2603:10b6:610:1ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:40:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:22 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:22 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:19 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 01/74] drm/amd/display: Fix elapsed time indentation
Date: Wed, 11 Nov 2026 09:28:07 +0800
Message-ID: <20261111014100.3596072-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f479b00-254c-4747-9c12-08df3f94c092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|261102123227099003|261028144727099003|261026140227099003|261021121427099003|11063799006|261009223027099003|56012099006|10067099003|261026121527099003|261021123027099003|261022105027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: oEDoDQ57DEiiTHusvscaoeD4mS1LtzhTyQJtvydG2bQt7YE/nbCWoIH5/vXEPJmLZSamZ8nesFZw9KI1oTevwu51MdPKORZIZgbqUa/NeYMr82bCggoGJzYwbK9vmo7mKcNjV4n3EM+47fBWjnZBcoP75DgD4YK0f6jHdbC1yrGqKqaIRUWkY6CfUzBjrLB4hXlr31I2Y0tM8e3Lk8VcpO+RH94W9dmdLSNK1oOlMy2/72FpSXpiBeqPSWJgVKVRNvz8B4PF2x/b097XBiormSWfiRchyuKWDXXAbR5uBQQUFnjqwQzksq+hLysFPGL82xcP8+qi7GXRYorsFbJcPyiUGqATgeLpNph4aTkxqt3HogzWAVB3lBay0S2ods2Gk62w9LTQhdT6J1MynvhS/DDf0B8vCZo0Bvgt/oG+oj+Wz4oCqHNlw7TjHftwgNksTUG8VYZwzllCmLO8a+mMz1uQbrLK4jVIHY6PQNsKVAQgFj1SDUViexjeuErQeRcdz1E5sase1pFdzS1VFz5OjfQLv6tZuTM0nDkFughpRn6waCEvLcVozIfG0JvhLpAkFv+1VpONrhoxqJLQoVARvUyyrWxEVPRBOo86PIBWSmhk5CP+CjC/VWJEVC6Y8JGOfSvxQlETx0R7+9M+JLocnfaj01u9u63SRb/xoyLt2wz1YvJilYoNDTZuDZJirmjAiIXVWCnS4Dyk1MKY4ScT1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(11063799006)(261009223027099003)(56012099006)(10067099003)(261026121527099003)(261021123027099003)(261022105027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2WLjr1h1p2NALZF7+mjN2nYEO8xHCxwoqJEFKghehsi5jqTxqLEn8Tm2QBgExSZPtdwL9R2gzz3edu2KeZiErdldNpPu2hUm0KL/CkADvljQQgWu5FZdHiBAkE9n5g0GA7XhN8smCjdboSGaTjp64JE8IHib5YlNVEOwf7+kMgab3bRtXqkECiT8okjK4du03HBA6c+3rfNU0I/F673vcM8dFtwKwk3cXykjWj0x/2sEkUyQcRoTbQRG6iApgitzvtGSeoQhQqZRnPzJS35nfkIv/BdqRO+FiFNL8lFy0+02BtRX2mFU/2+RCIBa0rwDxgJTnqSJMFu+oku0/B76uR2PWCLU4QQ5VS6VoKMQJEPHCUbKASMrG7GWqWg6dsGcKXjYoNNpsmCXGYb5Pl72g9mx+LGlK2z5ctY2JgNYlkevA8kMsyA1ssRoyg5rYDro
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:22.8000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f479b00-254c-4747-9c12-08df3f94c092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Fix incorrect three-tab indentation in hdmi_frl_perform_link_training.

No functional change.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c   | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 960f18fe275b..097df185a618 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -514,8 +514,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 
 	do {
 		flt_poll_curr = dm_get_timestamp(ddc_service->ctx);
-					elapsed = dm_get_elapse_time_in_ns(ddc_service->ctx,
-						flt_poll_curr, flt_poll_start);
+		elapsed = dm_get_elapse_time_in_ns(ddc_service->ctx, flt_poll_curr, flt_poll_start);
 		if (elapsed < (num_polls * wait_time_ns))
 			continue;
 		num_polls++;
@@ -622,8 +621,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 
 		do {
 			flt_poll_curr = dm_get_timestamp(ddc_service->ctx);
-					elapsed = dm_get_elapse_time_in_ns(ddc_service->ctx,
-						flt_poll_curr, flt_poll_start);
+			elapsed = dm_get_elapse_time_in_ns(ddc_service->ctx, flt_poll_curr, flt_poll_start);
 			if (elapsed < (num_polls * wait_time_ns))
 				continue;
 			num_polls++;
-- 
2.43.0

