Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDAECD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 07:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C1710E6AC;
	Mon, 18 May 2026 07:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T1uKkML/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B33110E6A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cC9CZbVUypSJuF7D2r2sA9ViEEwwjPtW+GuxCqIkPDVsxEAOii7VTh5QJymSvUlXv9ZCauvlokrk8RRy0gcUtBdbVndxrtzH0CDtiSsmeSpQBoKKgm2V/p+cLzTqdEX+xvFzKS4WQl+zdvNj1ujS618l6LFQDTtD+8y8PkJd3E7NCZnU/uh9y2Id+m1dcfUvaTG2Surd2p5V8SI6PYd11D696YLJhHVVhgQbNA8KC8eH34ChfzbNjFMeWUpjQrMxNWjSHFG84cIx0Jtnqzw3kfaTDWqc4lRcgcepfWFPaDwTot64EtoUdwM9EaOP5wh5dnALuYYA9uJqy5ADwiVXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXAPUaVEh7fwPe3k1SqVp/hGA4jVZM/R1rXnOrZen0k=;
 b=WMe97jCVHNF9QJJknDoIJHBsNuY7utpyDydn7YOLSr1/aFSE+JO5xNfGdJDUrTTLlMsVW7Zjwxvw3pnZmgBaXiIxN34FhLKS16hHwyKQBEB1Jf0ab4vP+FRR1Hk6LldlNMC4FGqU58n3fZ5Q3y2ofI8WdfbfeQ2MPABzoRAzD0rgbxXHT1xYeGpDNXWLoQdXqi8iBUAaodwEEbkwZae/n39ucHCVAeQ/KZBSFk5qLXLUkp4Gkkvrt9WgEsRFQvWNrTYtdXoZMovQhf8+EHfg3mIVZrJBCDbOhMnUI17/gYBQBG6ybPDlesaqDKDK3iR8+EFawUOhwfnE1cFY920OtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXAPUaVEh7fwPe3k1SqVp/hGA4jVZM/R1rXnOrZen0k=;
 b=T1uKkML/C+HDufr7tXaOXRcCOK+bK3SKjV7Nn3Z0RLoHBrvCGHWJ1MqEpuCh5wiGvuNtIxElJheFBEBpHK6MgpTP+js3SLg6N12guXNQm+sqjG5QbOG1HYhLgrohxqyLespVs6atCzKiWF/Y6+yEOlnsku5NWHp/P2hgqHypMr8=
Received: from MN2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:208:234::18)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:23:15 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::b4) by MN2PR16CA0049.outlook.office365.com
 (2603:10b6:208:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:23:14 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 02:23:12 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 1/7] drm/amd/ras: use mutex to prevent concurrent access
 conflicts
Date: Mon, 18 May 2026 15:22:09 +0800
Message-ID: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 426d825a-659b-44f4-c8c8-08deb4ae5349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: 2Vd/PEqvH9M7SVsvpxYrBjhZRh1iw2sh8SGLbjAB6LfUPbYQET0Q9rttn3Bm/0+1+YHorEAjU/33kaIa2xP82zDKIs8FTJrNemdq2udQvOq0+AK/VsRZ+8JB2947J9Wk6Wh8Lu4fi/nZoZZpNVzIu7e9h8PYTL9crGepqod8j549/Ey6mPweXL9EQVALlcWSTORJMX8Czu9Z+QfK8om7MsFfJMQGmWDA5igcQSYi10ffZYFl5sa9xDxtWWxFGeAYsoJ5wfZ1oI355Tof8YYRcaqtsJL6oP84tO0zYXd+JToqPAEZiE2fY2v1DnkTeESOATIiKFSrRWCGkqDWYkOIz530Hx7FGhpbHuK2atOLZNgG40w8evLxjk4pc++I4WC1Q+uU5Jk4ypUQCCYVv82Egw8+/+rU4gnQJF4eERTcC3L/CrbrBIpzSteSlbnYg1WNsC1JNjVluImCq70MiGU6agFgeCTpg/telXYY6EnMcwcnm+NcYIk/Smb6d4cba/VBlqw9+smFcaWPTkwE1mZ4R7ecjotEpErlouJj/NZO6y03tu6X7KnMoKYca7+8Fd1iMOG8tg+Yx39dx2kZrKQ4464csKzMXkcHD0Rn+zKfu1nzk6aOlH6p1n/DUf6IqmhVN+eDh/TxsAYVkOTuju127YsahfRiS6aQ1P0R+3wE4tJ6Fbe3e75gZq2qvOUPQKG3drTws6iBSv4awQ7+4HTpUIsDACAQdfMUiy8g4Sq2EvY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: osnJNQ64tR3HNV7NqhN7VE1ZWpvn4bACxr4O5l46mr90JNzTKIUxQ6Ck35if+8P77EC/4MJGf5bgafApTaieswyhwyIzFEj3BMpt6ib//rwDZdYqvlfsSOsFE6PSUurPHN+OahqCQaRefVujL5OsL/sivSMhEBEiPDUFC60tqps1SIet9IFkulCk7x+1rAfPAc5vSXWu9biLl0uEIN/qujhKqyt6zwRNe+kvebzYaApTezl7cd0t3v3cTIofihvdvXxHg3v+DcDMZavdIdH8voFgKRAMCfCDlEzH4uxizNOsaFyxzIVd/F63OLDKQ3F9NJMpDIALacHxci6F4BdMQOMSHPQz76otlPaKfW0jZhfB8Y9JdxuUarYlaclA4hixOWc8j98jXF5vuhLiG44Nneu+rR7hZuiZvNnFX2aPjFu3P4nz1F6jvTjNgr4AX1jC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:23:14.7412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426d825a-659b-44f4-c8c8-08deb4ae5349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
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

Use mutex to prevent concurrent access conflicts.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
index 524decb16ea2..39136db34bb2 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -87,25 +87,31 @@ static int ras_cmd_get_group_bad_pages(struct ras_core_context *ras_core,
 	struct eeprom_umc_record record;
 	struct ras_cmd_bad_page_record *ras_cmd_record;
 	uint32_t i = 0, bp_cnt = 0, group_cnt = 0;
+	int ret = RAS_CMD__SUCCESS;
 
 	output_data->bp_in_group = 0;
 	output_data->group_index = 0;
 
+	mutex_lock(&ras_core->ras_umc.umc_lock);
 	bp_cnt = ras_umc_get_badpage_count(ras_core);
 	if (bp_cnt) {
 		output_data->group_index = group_index;
 		group_cnt = bp_cnt / RAS_CMD_MAX_BAD_PAGES_PER_GROUP
 			+ ((bp_cnt % RAS_CMD_MAX_BAD_PAGES_PER_GROUP) ? 1 : 0);
 
-		if (group_index >= group_cnt)
-			return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+		if (group_index >= group_cnt) {
+			ret = RAS_CMD__ERROR_INVALID_INPUT_DATA;
+			goto out;
+		}
 
 		i = group_index * RAS_CMD_MAX_BAD_PAGES_PER_GROUP;
 		for (;
 		   i < bp_cnt && output_data->bp_in_group < RAS_CMD_MAX_BAD_PAGES_PER_GROUP;
 		   i++) {
-			if (ras_umc_get_badpage_record(ras_core, i, &record))
-				return RAS_CMD__ERROR_GENERIC;
+			if (ras_umc_get_badpage_record(ras_core, i, &record)) {
+				ret = RAS_CMD__ERROR_GENERIC;
+				goto out;
+			}
 
 			ras_cmd_record = &output_data->records[i % RAS_CMD_MAX_BAD_PAGES_PER_GROUP];
 
@@ -115,7 +121,10 @@ static int ras_cmd_get_group_bad_pages(struct ras_core_context *ras_core,
 		}
 	}
 	output_data->bp_total_cnt = bp_cnt;
-	return RAS_CMD__SUCCESS;
+
+out:
+	mutex_unlock(&ras_core->ras_umc.umc_lock);
+	return ret;
 }
 
 static int ras_cmd_get_bad_pages(struct ras_core_context *ras_core,
-- 
2.43.0

