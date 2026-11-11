Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DF606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=el4g8z5G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FC310F8F5;
	Wed, 11 Nov 2026 01:45:24 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C412510F8FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRmSHAbOmXzMHhqv5SL/rLWx2xuDXB7TNVAMrNHs4WCMhldv4JjG6F/aCXV+K0EG95C1fVGKnfTuXwDRLNLg8uGyAjCDmKLQ7qCnkKVLXR9fGf4t1Tuqttj8trVFOThnGEObWo+brBzE6fl2GDgSTFn9FOG8H+cx/PoLXJT6g3LsLjabjHNi4ghHDE0o1pqaBfjpSPEfityNhGKsIlZv2P732AhSdfXOeY3z0Qv/uegwIECYz/AA8lti0RbCHBWuY1kzvICPQZKKFf34pZJoeVJ062Y98E6Fwvcb5r5nZuiAcndzQDybLP8kIBUDyA25TB6YTNmp2dWacV/eY8WCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+ftVZzKLHEqfwSval3HmlSiOP4mccQJaw9BUHnMP34=;
 b=muTMKxuEXNOGFWwNOITe9QBfdGFOculnVeZA3Of39ItTTNNF2xUuHcJg0zqRyrB5DOThYiagRThtmThJ2R9YmwO99jFdw4kK9E75d09DpT8VngI4Eam3bUOFchhKDRHQ7Udn7WxdAdEMNJWCOjORpeZpEcecSTJl1n3pa3Ric+KOXMtUG1C0xvBcUe1rC3SwFDwQMde9R57LipoyCOgPKo/g+6tcxvqCn2kIk3Ly5vhY/T/k4VlIbSzVA+vowA974BNQ3vckc8gzUVPdpsz/Xxhs4AV7vg9U2cJUfGaK2kis3dSAnoS4BRS4BZSj1aW9nPGrK75LMkDVJdllaYMviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+ftVZzKLHEqfwSval3HmlSiOP4mccQJaw9BUHnMP34=;
 b=el4g8z5GjJi7nmH6O4H/b64vTNrlbx5WYElrQxRUOJhlWod275AGa5P+j2NdYKOkroH3yeThsiIsdIo1dsFUghwaYaXqdRWmDEWOqSeNGyQv49a4poCsr8e1kzJjVTZUx4OO0//QC6nDT4gwYTASY+MoXR06DXKlLf/1dyTNor4=
Received: from MN2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:208:239::31)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:45:16 +0000
Received: from IA0PEPF00000044.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::89) by MN2PR08CA0026.outlook.office365.com
 (2603:10b6:208:239::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:45:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000044.mail.protection.outlook.com (10.167.249.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:07 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:04 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 66/74] drm/amd/display: Limit VRAM aperture retrieval to DCN6
Date: Wed, 11 Nov 2026 09:29:12 +0800
Message-ID: <20261111014100.3596072-67-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000044:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: cce9019a-d711-4461-2f93-08df3f956f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|261009223027099003|10067099003|3023799007|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261102130727099003|261102123227099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rpexS9qt6MZyHA4vpjuaz2y8Cj4WJFK+PJraviF4T+ViNRAHipMXS69ish9t7tkm95PdTiOthUIQSSmPMkXbvfevyNTfAx1MJrycICZ76T686F2+La+DzwZ6icUPiFA1lO0ewTEOvkp5Zt9lcDtmphGpdybGgAjK4W6wJna5ck5aaJVUOPKhHKmwODLIrZXxRT54vznoXqqBzMh4uSIqEuolRPkjojOgC2f1SrHc7BKJI27B7tiAU/JijUkgl5fIV+KOa+5CPkN794hzayrT30+gu2+66uthBWX3pnoNKGjJmgE4nWQr6pz0zkaMcI5gcxIlkHZqDPV/SI67bkNhM2dwOT82tLJFOxj5Nhg0YARFNyXxcHm1ZgnLrCnrJdnJFFF9Ckfj6NoB7SrQWh1Q8I7s4B5MGkixb9y/ifTB3K0/hXCI2d/EtAi+9zgBz/TDNSkQJzWtcNb49Ee3DOT2DsQ6IyXESANlKEHUh3WiZCgFLje8aI8y3wvlkO1aSaWZff4nIBhVHc1zqUPFJrB2GQUnGTgLvyrov+heFR2aAhaVzosYNaDR1pENWG5FJMWIepjA9SWa5YBl3pvzk/WbrL6/1SPD4T/ZDBhtIdLERNxlP41EDKbldp1IV00aAn6v1Phyv69+VXH6VbL5vysVzV4LYRmyK4ZVncOqEa++pGZRALFbLbHoxlnD4WAOQWjNMGpLq2nCDQ5ROf4BPp3Tgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(3023799007)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QFZYpQ4+A/dO8esytaScPQI2q3eoS0JH5LFDyqWNw5dFiCEOaMcunzOFxuxdZnQ7Lv2M2O8Vc1Kfy+xD8TXjUevtQ0bURQuQpGAQch75exyDlMASNtzKqGRNWbb2nvQHL7cb0PmW4hdCjxdda+FPZbon93QWJs3UtisiWvoiyc+GkGyMgMfDP5tSbaUowbs1BJ7nsFyLAj2nKO0jyJ3JXt7omqv8xJ2HdD43PY34HzQQhhhC7At9RyqNrgIHYhJ71srfG0QDciCeNnfDkuicabu5iIwLZT3TuYHBf6V/tGKLEKdU/iOt0S369G7UVhVpWbE6YO5jeqFFU9mhHppBtrMwei9+PcoGCjvOcY8DgsJJZSYxgbbsLiRIUBDwUvh0aBIC2DD6mZfmu6ol+LAy0A+BxE1JU7DLa0gX93K/JBP6GWhhEURfyYC0YO7ngO84
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:15.8891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce9019a-d711-4461-2f93-08df3f956f43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000044.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Only DCN6 currently supports alt channel pstate switch, which requires VRAM
aperture configuration.

Return only dm_get_alt_channel_pstate_switch_aperture on other ASICs.

Cc: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index d655ae8bbb52..ebd8130cb04d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -168,7 +168,7 @@ EXPORT_IF_KUNIT(dm_register_dmub_notify_callback);
  *
  * Reads both apertures before populating the DMUB parameters and DML2 config.
  * Translates their base addresses into MC space for DML2. If either aperture
- * is unavailable, the feature remains disabled.
+ * is unavailable, the feature remains disabled. Only DCN 6.0 supports the feature.
  */
 static void
 dm_get_alt_channel_pstate_switch_aperture(struct amdgpu_device *adev,
@@ -183,6 +183,13 @@ dm_get_alt_channel_pstate_switch_aperture(struct amdgpu_device *adev,
 	u32 i;
 	int r;
 
+	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+	case IP_VERSION(6, 0, 0):
+		break;
+	default:
+		return;
+	}
+
 	/* Region IDs 5 and 6 identify the p-state switch apertures 1 and 2.
 	 * Do not publish partial aperture configuration if either lookup fails.
 	 */
-- 
2.43.0

