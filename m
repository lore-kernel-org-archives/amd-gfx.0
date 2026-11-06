Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6444606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jKQSroqO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D6510E00E;
	Fri,  6 Nov 2026 21:10:45 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA82910E00E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 21:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrkWqGgrG2orydAcSjzaPJzsT4syByDIEmf6CWCKO5e+JCc6S4Of9eK0USSlbJ3d7Z37yYzEK49wy0Y/qlnfo7MqK+3SCA7npr1pndDZMkx18Y1bpzDvrGQtkQSZdBMtDWCYzI9jpkIZjPfRcSwX3Kkre0XZwUi1yUokv/nB2DrZUzVy67bbfgztAcCWj4mc6mjn5f7m2x4U20TQCJXZ5TyihqPQFArfWd2b+81zRXIOrIf3rWrzXh9uSr6U9jNGyzqy0BwPwr9CIWLvqYrpdAMMAWeHEeizCbEGKZ097AKfRfZvLZAR2JXBOJmnLr0qsuPy4AFnP1YSHBCUxnSoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecojZfK2bpBYmDnmqb96aULhEEo1/9eIG8x2f5LKDCA=;
 b=ZXzwn0/nfDRJmI5d4GMMjmRnT9Zxvw2zH96ydVZk6bnluI6gqSOb1EHGY5mttLWJALDBaH44Edslo2J2BDB+F/pN7fYKV5CYmtJrfzd+00VxN2K57H9y4gBzeQO2rDhuYE+Ls9Ulv7lm8kUIj6S1NmwR/0vk4RYMQWxh45ML4PzIZT62M3MjlW4gWXe7wCq0/Pn5rmMQUXbpmNQUA6emy3mBY7uNahT5ys+ZbJBXHCQ9F/Oxx1dazLEI1ceOwDKuAG4LZJDrgNHbsye+lR/Q5Oe9Lbr8kMF1PSfjCSvTeuEht0+jaEbKuw1BNp2dABSSBSIHbRp7aXEhHucSJIWvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecojZfK2bpBYmDnmqb96aULhEEo1/9eIG8x2f5LKDCA=;
 b=jKQSroqONT2Vgz+pCvokEsoNEKrFTn5bsIV7UjX4PhO7aubOFtVfSLSAqwy/PNI2QBnQQFChPatn2hE9f1LQ0se8IxuFE/oUyfrIZiWYvgmHBv962gUnEUEaPfQfl+Jf/VPpy2nsGnWVf2p+5CxV/khx4f/wt3GwWYAn+Oh6DTQ=
Received: from CH2PR17CA0013.namprd17.prod.outlook.com (2603:10b6:610:53::23)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Fri, 6 Nov
 2026 21:08:29 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::9d) by CH2PR17CA0013.outlook.office365.com
 (2603:10b6:610:53::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 21:08:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 21:08:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 15:08:28 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 15:08:28 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, "Michael
 Strauss" <michael.strauss@amd.com>
Subject: [PATCH] drm/amd/display: Add support for more PSP footer sizes
Date: Fri, 6 Nov 2026 16:07:38 -0500
Message-ID: <20261106210738.668372-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 987140a1-1cb0-4c8f-3203-08df3c4a1b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261102123227099003|261021123027099003|261026135527099003|261022105027099003|261026121527099003|261021121427099003|261022115727099003|56012099006|261021130227099003|261022113327099003|261028144727099003|11063799006|261026140227099003|261021133027099003|261021135927099003|261009223027099003|261022075727099003|261026130827099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: RvKJwLIm3uvoE5yyomxUXW1oKDLJvhdOY/pWpRMGcWyhR8QxCSInJiZyhuuUnQ9e0zooQMo41Mn/ufn4HWv/vYPQOqhEGcdqE0F7eGLiybGyF2FwLgqUIZQY8YSnVBe/EFDmFflVbUJtqoCNGNJ+EjrQlbaiGPeoywwKHlyE7gODSwHC+VTMnQnj+0kYaC5dMPmD7Hwkc28RZKuygYbFKDscKSHxit7xPLt+rGWOktn/fA4nP+16ptNJFmpUyUR6MUjrS97LS8ZrhCkBBX4AcFFjwJohDe8SLwOYZNd5lRzZaZ8aU8mTFokcBurmRr7QKKh6/5Nie/FOIz/s36MlTFZWKjPXPZK8jEDKrd0yurHFpRKBfhWM2oxUG0VG/QiCjasaRxgHNpTZBlZHHpzhIkOWlnNgtNvauZY8y1E/TVsPJRdiT7nc+uSfR/wY+vAOMI1UGkDiWrU4evqwAEn5sJnNoParYguDkIjFNjwOD/mbhdVgZtcKW82zQ2LQb548C29Z02e4KfrTc9+snwta1aXpA02xXrrSw0crrRcPsKN+MU78RHScztT/qYf/UY/VTThe9eWmPp45VfxpjDF+AoMFqeuBFgINbBhwLZVh9Cdlmo++Np61tSE95tslUydUXeL5GdVYltM8DJ8u7ckzB14/kNDz8fATYy1aLDJwlSV4C/HHsR8Yk243SXWrSUsUamVMg/zG1EJFzzJADEiw7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261102123227099003)(261021123027099003)(261026135527099003)(261022105027099003)(261026121527099003)(261021121427099003)(261022115727099003)(56012099006)(261021130227099003)(261022113327099003)(261028144727099003)(11063799006)(261026140227099003)(261021133027099003)(261021135927099003)(261009223027099003)(261022075727099003)(261026130827099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tg7Jk7VoNodo3++zYJ/OSZgwJ8ifQ9z8WZEbELxkEffifymrXorPG2nK8meh52bmhN2l71Lw8XMR1fpMB3Hb/ezRjFr0FEekcGMdOU3XH3KbhSD2wiX6cw6VtLofhL/+GXlbS7yBGZC2f1gd74rAGaNtDOJAhSQyL4wBVWi5P/yfpRsFpWdoraTlnzGJv8c1IO1m50vsnsPlNaG6JllRg2mDco5mro5s+wI4O+XOTIkGOFpzzOl3oq1Rsf0n63VETxXMYQKN9hBAuT+wm306/VWDf3/qy98R+Yyq6T/tSLZxHUKz8s5zFJfUjkxbmlGyI/N0QR2NrPabn+JsXzXias9006hxKeHdCQkiuRykc5dg/ChcUusE107gpAaGIFk26yi5BQMc8NQGnXGikwwuz9escgdDPhVK0cLTCMOCs5WDUO93qhzvnJ0uXmf/JCMn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 21:08:29.1316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 987140a1-1cb0-4c8f-3203-08df3c4a1b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
PSP footer size may be as big as 1932 bytes.

Add a check for this size so that the DMUB FW meta can
be properly located.

Cc: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  2 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 41 ++++++++++++-------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 17579ff2e1bf..84f825c924bc 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -76,6 +76,8 @@
 
 #define PSP_HEADER_BYTES_256 0x100 // 256 bytes
 #define PSP_FOOTER_BYTES_256 0x100 // 256 bytes
+#define PSP_FOOTER_BYTES_512 0x200 // 512 bytes
+#define PSP_FOOTER_BYTES_1932 0x78C // 1932 bytes
 
 /* Forward declarations */
 struct dmub_srv;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 41b14b137643..72fc28feefb2 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -173,30 +173,43 @@ dmub_srv_get_fw_meta_info_from_raw_fw(struct dmub_srv_fw_meta_info_params *param
 	uint32_t inst_const_size_temp = params->inst_const_size;
 
 	/* First try custom psp footer size, if present */
-	if (params->custom_psp_footer_size) {
-		params->inst_const_size -= params->custom_psp_footer_size;
+	if (params->custom_psp_footer_size && inst_const_size_temp > params->custom_psp_footer_size) {
+		params->inst_const_size = inst_const_size_temp - params->custom_psp_footer_size;
 		fw_info = dmub_get_fw_meta_info(params);
 		if (fw_info) {
 			memcpy(fw_info_out, fw_info, sizeof(*fw_info));
 			return DMUB_STATUS_OK;
 		}
-		params->inst_const_size = inst_const_size_temp;
 	}
 
 	/* Try 256-byte psp footer size */
-	params->inst_const_size -= PSP_FOOTER_BYTES_256;
-	fw_info = dmub_get_fw_meta_info(params);
-	if (fw_info) {
-		memcpy(fw_info_out, fw_info, sizeof(*fw_info));
-		return DMUB_STATUS_OK;
+	if (inst_const_size_temp > PSP_FOOTER_BYTES_256) {
+		params->inst_const_size = inst_const_size_temp - PSP_FOOTER_BYTES_256;
+		fw_info = dmub_get_fw_meta_info(params);
+		if (fw_info) {
+			memcpy(fw_info_out, fw_info, sizeof(*fw_info));
+			return DMUB_STATUS_OK;
+		}
 	}
 
-	/* Try 512-byte psp footer size - final attempt */
-	params->inst_const_size -= PSP_FOOTER_BYTES_256; // 256 bytes already subtracted, subtract 256 again
-	fw_info = dmub_get_fw_meta_info(params);
-	if (fw_info) {
-		memcpy(fw_info_out, fw_info, sizeof(*fw_info));
-		return DMUB_STATUS_OK;
+	/* Try 512-byte psp footer size */
+	if (inst_const_size_temp > PSP_FOOTER_BYTES_512) {
+		params->inst_const_size = inst_const_size_temp - PSP_FOOTER_BYTES_512;
+		fw_info = dmub_get_fw_meta_info(params);
+		if (fw_info) {
+			memcpy(fw_info_out, fw_info, sizeof(*fw_info));
+			return DMUB_STATUS_OK;
+		}
+	}
+
+	/* Try 1932-byte psp footer size */
+	if (inst_const_size_temp > PSP_FOOTER_BYTES_1932) {
+		params->inst_const_size = inst_const_size_temp - PSP_FOOTER_BYTES_1932;
+		fw_info = dmub_get_fw_meta_info(params);
+		if (fw_info) {
+			memcpy(fw_info_out, fw_info, sizeof(*fw_info));
+			return DMUB_STATUS_OK;
+		}
 	}
 
 	/* Restore original inst_const_size and subtract default PSP footer size - default behaviour */
-- 
2.34.1

