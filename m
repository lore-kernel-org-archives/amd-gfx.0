Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55123606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XFkDJz0U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CE910F8D8;
	Wed, 11 Nov 2026 01:43:26 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011010.outbound.protection.outlook.com
 [40.93.194.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC8010F8D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7PxGYoKxM9SFdUN3ygtLc/5kOhP6AsoyiN5aG14wfKAS+c2nmbDgA/RCrTQwHJ7uVjvowZqmMSuhhCTBkbrpkxUu4Ley07PvlicwHKuvI31cTmQd6krTterkOF8RDNba5355HzhwmN+rR0uLbCckuH5fr8GOMPA977zFM+SjMtlGUClb8HwV/0Uykf+w89Nfx4YfLFYjFb7gzRfpnNcMDWnsvl26WdKKfZ5891zfkZnXNGJIMrOsdW50iCA3u/jiuL4iKcMUV+8JC3uA6078AA1s6NWgrv+ZCJ3Cmjl4SKWziy5fDMJ9Ybbr1GyZcaDmlwZH5O7+r9mFBCcQb/zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkpSNd6gT2ZlJXWVOqIIJ5rCAh/bsZdaDMTV3P4nBlU=;
 b=t2wUm0bzCRZ1CN5uc7UMm7ZoW0enJ/G77rqMdf0K/m9ZIn3F9MW32MRXZjNNbseqZfyxREhqAibISMs5lbbb6peBpnRAMlJtJhYUwdCaH9fHicQ2JIsKsWBI5vYF1/Pr1T45t470jjKS7ibrQ/N9rhu4uCDPtb8bRpbhYcG84ey5Mlli/v1FHPxO1nxWgNGd1IJwIB256Mr9iLDq8/pPFqGexbBRYxs2CpE5XpJVQNOQ3bgMH7fuJPfOhS/JpqUpCqrWc5/5i/lMJBASU/R4w1YnYFiZBbui0k7gyTNZ+D7k4cCRKtH+BSJ06xDY0kVt7qbYkZHctoz+Gw84qieP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkpSNd6gT2ZlJXWVOqIIJ5rCAh/bsZdaDMTV3P4nBlU=;
 b=XFkDJz0UCSvyHBeJrjGo5Gx5w6oF99kexD4GxLkFLfkf0xoWdo3WBCDgMGiY1WKP+aYOL7EF0RdpQ14IIRGFzu97WjWdSpNPrlP6fu+U3gn/p+FT6Iak0d0Bq9/wz/3EWnX1W04/M/SdWtFmlMTv+c/yfmcGpWuIP+fBA7o7qYA=
Received: from MW4PR03CA0189.namprd03.prod.outlook.com (2603:10b6:303:b8::14)
 by DSVPR12MB999286.namprd12.prod.outlook.com (2603:10b6:8:41a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:43:16 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::6f) by MW4PR03CA0189.outlook.office365.com
 (2603:10b6:303:b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:43:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:15 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:12 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Qi <haoming.qi@amd.com>
Subject: [PATCH 44/74] drm/amd/display: Fix KUnit tiled EDID size
Date: Wed, 11 Nov 2026 09:28:50 +0800
Message-ID: <20261111014100.3596072-45-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DSVPR12MB999286:EE_
X-MS-Office365-Filtering-Correlation-Id: 7195fabe-3d21-4c32-9245-08df3f9527f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|261028144727099003|261102123227099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KChSsDSRYDq2r4j5mbZwU+jMr6e3+IhLQaN3+o8rdRnRXxAvWu/di7uOVKTM4OApnQS2nHfTGPPvDPSypzt0ixEqBRh6y26oGjAksoWRPNWSgSjJou090K7aypSCiSVbzRlrNCisY4+otyvLf9CJrRmaP8tC2g1TSrs3lyU2C7SDK+IPRsp++9hYMkNrgPscmtLJjIGfUPFej4M52mxg5m5XPSHwUuIVSKPsIifE4bK+srcIQ8Efp83oAwALSyr+Tus4Las+yHcj7fon/mbO9cq0pD210wZjxC5q8EgFMdUAUFqLSOyZkmxH5szixoWdeihiFNfj/UhCusH+bbdhGZXU897tVvAMwil8/4kjTOmi52JFwqHmclH/U1ITCdOVlTELt5tdq2LEbyaFtMZSm4MrWVWs7YOllWP0oomhDcaXlqlkGXwHxdJiQKKpZ701AsAkNb5X0pVj9qQZfDfy0kyQr9xKBu0soOt/zsP2mlgzBF50sLqQaiFvX20qiTGpXaAljOTk8CMg3Yo0NE+PflR/nkIgZBM/E3ptNx0G18vf3TCmltz1rtApKjyNAHhQTKfdUtcrGadbpivFgsnH1y1fDDAbNuVkeh58m7uNmL7jlwjNFDB5nzrZrLQOQGWGCBJfL1ye15IeBK1uuYOq/QZRjmoCmXkup3b2AcZ8ARzMwFpNrWCcjuWHowRP0dwXCvVYJ7X/ZE7lenpqW/6HuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zzic3Y7P/lfjVobzVVcg+/fRsSb0QxBtEuMTOcCHAD0up28ZSeieOu/OF6IxJAKEYxVkexYABdtrPxJkI0CwSQfLJpo7NDebrE1WDQYk54NeYgFa4SJmosVGTNlPKyjrmDdbbDW4y1gkJPjAAKKLUAFjXpp3vEtt3kDV6eIHVwcWvx5zm6/xR2rQzfEcdvxuG6xultEC1e5IgXo7w24BrcgrFu2cE2IroqawW0vHKfGBP1EiZXh7y5P6t6kh1X4314dVOaNb0V490c8LnsBRloFG62XRqKglCaogojzk2soRosSVsAche177BlyUDYmQSHV5R43rnC8zRQrgHQt6zQcPDc/MxpJxManNisHbiDMIiDTIIpLi9XesFWaG06LsG8uWG6tM32czLjK0MRgNJF/K+x5w2emevv50uBsdQUk86g6+vzApqP/Dpeb0ciVo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:16.1851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7195fabe-3d21-4c32-9245-08df3f9527f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999286
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
dm_test_detect_hides_secondary_tile fails because its synthesized
DisplayID tiled display block is 21 bytes, built around an 8-byte
topology ID. Upstream commit faaa1e115583 ("drm/edid: fix OOB read in
drm_parse_tiled_block()") now ignores tiled blocks shorter than the
spec's 22 bytes, so has_tile stays false and detect reports connected.

[HOW]
Grow the tiled block to 22 bytes with a 9-byte topology ID, bump the
DisplayID section length and recompute its checksum.

Cc: Tony Qi <haoming.qi@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c   | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index addc407841a2..805c1bc2ad9e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4894,7 +4894,8 @@ static void dm_test_detect_no_sink(struct kunit *test)
  * A 256-byte EDID whose DisplayID extension carries a tiled display
  * topology block placing this connector at tile location (h=1, v=0), i.e.
  * a secondary tile. drm_edid_connector_update() parses it to set has_tile
- * and the non-origin tile location.
+ * and the non-origin tile location. The block carries the full 22-byte
+ * payload (9-byte topology ID); DRM ignores shorter tiled blocks.
  */
 static const u8 dm_test_detect_tile_edid[256] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x10, 0xac, 0x00, 0x00,
@@ -4907,10 +4908,10 @@ static const u8 dm_test_detect_tile_edid[256] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xc4, 0x70, 0x12, 0x18, 0x00,
-	0x00, 0x12, 0x00, 0x15, 0x00, 0x11, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xc4, 0x70, 0x12, 0x19, 0x00,
+	0x00, 0x12, 0x00, 0x16, 0x00, 0x11, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x8d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x8b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-- 
2.43.0

