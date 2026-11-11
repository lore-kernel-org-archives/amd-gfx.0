Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4C606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1k5YKMXV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D352010F8DB;
	Wed, 11 Nov 2026 01:43:35 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCB210F8DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kB6ffeqWdrrOwJv1OVxlWflXE+ZDsk/8q8MlC2oahkEpDXIf6IA/sa4HQT+BNE0V350gb9LCNLif2jKUZtVPfkArg9dzIlOQ2iH+rvX0dn08digQH7uQLjqhKzRmyQTH5bAIbLjVne9gDY09+kg3MDY4EXHiNjt+pC834diDIyb9zaEJl3GsAtjm3wM/PPk06KaIgMGf/BaARJ2sMtblNSJwxwwIJP3I08Iqs0jPpYi+gx2XIe8Z3Z40fC260DEmqxuyUbK6pJovGj4t5+G4jmM4VtDjzvV+GgqpYhsTkOjoMjXNgprqU35pUcWBub7sDU54Z+t4T83bG+kEH6R/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/TkHVuv/pdNsZ2rH4FCgQmnRnv1zK+wdqv7G2I56OQ=;
 b=vISUfAkbf+85PCwVuKsiK6zPLpePquQ6jCW7bnGT3n9A6tHnjaN2mQ0/4lxDCtB9oMZGONuPrg6yCaEDwTANALkQeZ8oNKIg0eLcVZLT71iH01bfc9t+APgCl5a7G7xDPDB0mFA7blGj06+P/GD5dyED5l7qrbesXBhn4muNuv7b2LrdqTqniDV527kZQpSTncQYnzZMuqARjKFFKh3buP4WribZ9qJ3mEkkkDLWRE28D1VDpc3YZemuY0Rbp0w1ndAjMQW0ja034pZBSWPk6H1e40QJbRcvF8xngvSEBDunJPScNYILLx2b4+HYOJVJqE6JcBC7vkMg7rxQdvlzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/TkHVuv/pdNsZ2rH4FCgQmnRnv1zK+wdqv7G2I56OQ=;
 b=1k5YKMXVqm6uDDgIWfi2/uO/LJXHG/uaBVgcCGACLYPLsEmafPA3lJ2U4swuSM5I9ufIEyp7F9CdbOeK7OXkqEe2nOnt6aIMEOrpoEKIdYEc4Thz8pF4VrykOU9Nvx4YZYvQo9/7dztVM5v91JWFDecC1ct2fqB+APaYu/BQtic=
Received: from BN9PR03CA0858.namprd03.prod.outlook.com (2603:10b6:408:13d::23)
 by SAWPR12MB999166.namprd12.prod.outlook.com (2603:10b6:806:4e1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:43:26 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::ae) by BN9PR03CA0858.outlook.office365.com
 (2603:10b6:408:13d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Wed,
 11 Nov 2026 01:43:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:23 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:19 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>
Subject: [PATCH 46/74] drm/amd/display: Keep panel power across link-loss
 retrain
Date: Wed, 11 Nov 2026 09:28:52 +0800
Message-ID: <20261111014100.3596072-47-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|SAWPR12MB999166:EE_
X-MS-Office365-Filtering-Correlation-Id: da034b96-0a62-4b1f-d7f2-08df3f952e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|261026121527099003|11063799006|261026140227099003|56012099006|261102123227099003|261009223027099003|261021123027099003|261028144727099003|261022105027099003|261021121427099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2bXW+pN0rM0rwcypixr1/ewCMYe0BNroclFvM1Wy6K+J8HiKFnWpKUVVX2IqikqUFsj6ya6SpJZBNMU63/STLV2YrzLk7ds+lHMOboYnXWw4jfOEMFYBY510tURibjmJGNNcwZOWv7w8J9DGbdXLLOhJ0Thx12LnB/wrYGTCw6Ozp5FF5q+xFfRxt+8QTpj7rc3aEeX0uE6w2b12iQILmfwGSwk8d29bVkW/gJIHqpEXw1p37i6ZsRGGVMo1LDtkIBg06iNmVkjHMzSZB7UYnwDygF+6hLDLvlcg4el2VuWyTwTdQDSfWJDcwpX7Nez9+cBdlaTKxWpg+YCtNhvaHRA8ftBfDS79hgPhWV9xvVH/Rh1soEEH42P5+13AwYfVPz4oX8lrE+YWvhoQCIIkYWeCQJO/AP7RZYhboYGje6RFu4xmpOOL4Gt9K7tpXMXI2glZLBRao6K7E588QEId5YMH9u5Ut4GO9K8ta6xE1mnGZIrqbwMLptpqosYU9UYDCPwOPDHOAQu4VxDrMFaZRlAEWlCSeHYUSfdpRB2k45GkUTkulQcXflvpzFK8cF+zr7r6zJiZlhiPnIJOpi+hpl5vTcdCMvk+H+btvCtSspTPVIZxdWapfhFHmk89eMbcapgWAXnt0jjjtJDx3bk0ly0RqvdaUB/bJDGqxjiSPJX43GX4eJgTeAuAVTOq+FAhWoMEvbfTzF2D78kf4QU1lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(261026121527099003)(11063799006)(261026140227099003)(56012099006)(261102123227099003)(261009223027099003)(261021123027099003)(261028144727099003)(261022105027099003)(261021121427099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wcSO83MCcCdZVbYDlSCIcvoQB+uNOj5AMAXZ6VhcZXHeTqKIkmYj3Gg49aag+1GsYnhL60U+P4RdmNslF0vXEmz/WaUctB5zi9B5NKEiy1MPAUAvQdQ0EeqL+GvLIUDtiAwCPd5q8DDI0fUtXwBA+B5F7dt/gzR6Qwt6eMUJpOf/DKOT3eNkQpz2SuU87I9nqyzTZVWLwqgmZaSuIaIdX8dP33wuCqEYlyJVL0d/zHEaN77lTghKPSzR8fD0DUHegUEPYvvGss+QiayztvUPpgSZxqlY9KyjwGD5zvVX59DXvJjP5cQv+khKVA1KwQ1KATl44DFhLOOltiB5RFAIXRfDe3q31REA7ELLS8xYWsta/wfo6DHg3SLmjrQffbPBHQMKTn5XZfXG9ervt96c2hj0dSUKWa+elqUlVvaDt5SapVdKdh+GYsbRCqxU9UHp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:26.4267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da034b96-0a62-4b1f-d7f2-08df3f952e05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999166
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why]
Link-loss retrain turns the link off and back on. Powering the eDP
panel off here drops LCDVDD and the panel must wait before the
picture can return.

[How]
dp_handle_hpd_rx_irq() sets skip_implict_edp_power_control around
dp_handle_link_loss() and restores the old value. The flag also skips
backlight-off and the DPCD sink power-down. The path runs for non-eDP
link loss, and for eDP only when replay ESD recovery is needed.

Cc: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_irq_handler.c   | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index da679fb7d89c..59f9150edf30 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -576,8 +576,14 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 
 			if (defer_handling && has_left_work)
 				*has_left_work = true;
-			else
+			else {
+				bool skip_implict_edp_power_control = link->skip_implict_edp_power_control;
+
+				/*skip LCDVDD power off for retraining*/
+				link->skip_implict_edp_power_control = true;
 				dp_handle_link_loss(link);
+				link->skip_implict_edp_power_control = skip_implict_edp_power_control;
+			}
 
 			status = false;
 			if (out_link_loss)
-- 
2.43.0

