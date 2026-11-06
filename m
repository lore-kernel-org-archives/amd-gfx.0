Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8205606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F1zbPRtb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9A510E4A2;
	Fri,  6 Nov 2026 22:46:28 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A94310E4A2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 22:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+PuSk9YJuizKlvV5AoE1GuBzaIww681FyM1DaZRDGDBhiSDxSwuvotOCRXZh7AFSzL0c59+nHMynX4z6ORY4MV29Wrw7I5cxjc/+8UzUFCTOu0Z84AtzaIavN6QWmkrCZvGtAjs2W3hzwUOnNMlW7XulUr1giit4xJECn99k6YTQR9ynYjilxbURDR9Y/zdfDwEulYmpWfnxGFjY8az4vYwShk03EHJejWOouJ3J7HtjIKngJFAfQumVuSFpEmnYrP/eztxU+e4pvnmVNF2D8Mb1I4TDJUfZZeRdDNf0HgZ8z3mX00eRn4gv8LlfIw+9v9vokPcOO9qZa5cK1dbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZxr4RPKcuKFMy9Je7w++tNr6P27TL1JawX9VjHBSDk=;
 b=k+B+cNAMkJcfoYAkksoz/kSox9H4N4lsnNJNHNofLtQh8G8rwiqwXEYMfPBirbDmlnidb6+yU0dRi/Qxrgh6qtqBOoZ4UOPiwR+ySYdfUwyhrajd7ShcX+Lx9vCBEtKlrOyUj5UI9MZ/dfbLz7ItDaj2ye5Yljm8DBntLgY2jrgrBxSjzQEl7LrYjCgP8F+r2rjlcit5PEt1/LkNunY9zeqGJvkWsjD476ig2ljHaSQKdsMzyA3tfeK52eCra3dYVnvoHyGqxx1tqwicTNbFVqP0WkBiR2YRWUxAbZlJHso6FaJUWlRM3cioqRqG9hG0cGo+NMCVBMi2lSs8pPtdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZxr4RPKcuKFMy9Je7w++tNr6P27TL1JawX9VjHBSDk=;
 b=F1zbPRtbn0bFpon4bkaIxPW5z/3Cw+srO6mBY9OOheThjebr/tVfTS7h2GDe0zISAkJe76nLfdUErFA36bpQUGzRT8MGL5i6qOOgKf0J+s+JiqRajQEm5aWh0mGpOxPbnAlib8SpCr79BOYC6WjniJNk4aDoUbSDRozZFB8A2gk=
Received: from BN9PR03CA0334.namprd03.prod.outlook.com (2603:10b6:408:f6::9)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:45:42 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::8c) by BN9PR03CA0334.outlook.office365.com
 (2603:10b6:408:f6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 22:45:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 22:45:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:45:37 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:45:36 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 16:45:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/discovery: Add soc v2_0 common ip block
Date: Fri, 6 Nov 2026 17:45:21 -0500
Message-ID: <20261106224521.3568803-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106224521.3568803-1-alexander.deucher@amd.com>
References: <20261106224521.3568803-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff4db1f-4578-4e3c-133c-08df3c57af96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|261026140227099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: Avsun7AoUhWSgyCi+sH8FOOm7ySj1zb4IYCLxIkAJDcsXkeIpW4Pph1oJJwQkeqTya1iZwkGlkh6Hsj1cGtzJrbKhQigMfVR+M5o1jCEk5qB/lA8a9E51oGyqn33K3G+MmCdpEbjW6leoQlMJSId73c9LZ+ibSG4SMcupxDXVv5xtOOhtpbKMVL98YdelWMKcYeLdhB7zCWO/fTH2lWOL1BrITk/KFi93U2VS5OM+WOMuRfcXK4kWijOiCV85pY4WLX5WXeicHqf5VMrdbhWhTvZbOlXy94nPwGuum3zxNd+Mt0oUgPJvhVZh8AesZOO2N/b5hdVgdZ5qIoVlTEanK5hisWfKsFn9hNigH3visu1TejzujB5p/DHvLSdJk5VMONnPm447y1uz2axw5FJOUDeXakYw01z/bqIKs0oQEU3wMl4p5Y+xlpxz1umX+7UG9oss/Xzlhx+jD7mzmjd975hgdceUPQJAhYpnKESmtaOPTwgqVETagoTdSuzSFh+qxTJmBl32e5jALaD5OIPDxxO5tZRDgd4gmqR+IqMjRH/GvJXDWRfTbFmIv87xH66zh4yqiczXeh0RoKaFvB/o0FFohALE3GOmQ28qQK3vdH9yPMG3eEdITHNSTxlRx9eJ6/XSw4P0wEthfwbGYpha8NfP3YYqDjsFqstOQ1nTimk2AmeshRj9/ftvMQ9HEulXqFIApPLhgQBYFahHerujQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(261026140227099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h6Wzm5HFMEO2TtCs6fsJVo2yIsHdS5sNJhedCM0XLJTUZwY4/qdK7pyEndVtn57ne1nOpFtbHFJAyNtjwiN6QxtBlqOYxXxSVtuCM4IISfxehIn8ELFf4Wiqi70os3ezZrKDk9T1C67lf7XM8DVyeRFZB1k9yuHTXtce8FBrIH9+JgDXITbNm6J8SmZj496I8/tXJR20/0+s9bqSePc23UPGRX8hoZyZcdgGMp//QX3Xqp+5P+yfw64OHeNjuj+IUI0birYcwq7QJ211jf9d47ipekTHxus7TkUjN1zCgwIiSyDS09jFFmRjcvz+n9+qqrHBPLmxrYKryO5wr0+jEkZsb81jNixTx29bsiefZ0wl0k8ZbFuNr1DZcuzEIYa1nSkpOg3E0WfH7DiUUr1M8SOzNc2mkASmm8dqbKjVyb/z4/r0fWIyKxISQYwhp/Vj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:45:41.5142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff4db1f-4578-4e3c-133c-08df3c57af96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add soc v2_0 common ip block

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index cd5e447d78e15..bcc400d021105 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -80,6 +80,7 @@
 #include "soc21.h"
 #include "soc24.h"
 #include "soc_v1_0.h"
+#include "soc_v2_0.h"
 #include "navi10_ih.h"
 #include "ih_v6_0.h"
 #include "ih_v6_1.h"
@@ -2740,6 +2741,9 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(12, 1, 0):
 		amdgpu_device_ip_block_add(adev, &soc_v1_0_common_ip_block);
 		break;
+	case IP_VERSION(13, 0, 1):
+		amdgpu_device_ip_block_add(adev, &soc_v2_0_common_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add common ip block(GC_HWIP:0x%x)\n",
-- 
2.56.0

