Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34107C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB7F10F6E9;
	Fri, 14 Aug 2026 21:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0zOV++o/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B0C10F6E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mG3OlMp0S4tOXhFebAUrDdlcXFNhcvrixaBH09/R02L5maeQVG6krcsTyIM8xduJSo8ycD+xyKIp5GbB+wZQufaWxoDTMn4Zsv/N8UZLS8Mwj23eVGi2sEANcxqNtGfzipD5Ydd2/EjIdPwWuPgS+UnQMHbEwOTwogeCO5RGcA328zjp4mULbjYk54N4qBF/mmQQhPxOsJSG7RmqYjEqW4oE7w3te/6VMns3vYNVqXdZgTVIVoMT4f04NYqRILQEqQDEAs2NiVsEAr3+c6PVP/VNQMoZxxEB16ym9Qzde0DP00deAsobeHawVCXgi8H3q6NSsU/P0ADttKMYgWRs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQzLxwSW9TFVtGbUAaYxlxMRyvNBFiyEg++XPq5aeY8=;
 b=hgUBD8j49x3MCM/OnRrfQWJL88VQxDcZ9wqirS3/ZuhOqYlBd5vTqSuRPeNTqgufNIPdvsCdzXuaTzEOMRWuG9h8mKSOqxJx0sRrKshie6+jfkCi682bewBCh7oShv0REopvNB/Bg+4HWOd85Yk2xeg9j2SpjFVKAjUg9a5IK885QKDCZnGPuHyLWByW+MMdjCKPXs+oV6M4ZzbwKscBD5/15khkxjcH+AnG1Thf0gxoiQT6hSWmDfh+u2ntt2tZesCKXDufxU7kx/VlFN5gsQT/pHWUzis/woeWNF/twAkmHjWr+WJWIiDJrnU6j4YioH9VJm+u7zVk9fQqMmsDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQzLxwSW9TFVtGbUAaYxlxMRyvNBFiyEg++XPq5aeY8=;
 b=0zOV++o/vseumF/GhUHXjhgOXGmdP+KxRugyhCQqPrmJ3E7q2bRdEwz4pp9/RlDOzW0FzE9gp5e70Q1hJQBp0d4XZg6MQYRaZmC4inbobZDRACXU82zKSrWPLk8UKtLiiCTF3sUSpbXOFdJrRgsTG1O9RXFfCfUNeBPPbgZv+PY=
Received: from SA1P222CA0054.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::29)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:14 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::70) by SA1P222CA0054.outlook.office365.com
 (2603:10b6:806:2d0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 011/109] drm/amd/ras: Optimize and remove redundant code
Date: Fri, 14 Aug 2026 17:01:08 -0400
Message-ID: <20260814210246.3067612-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: fa48da09-5cd6-4024-f58b-08defa47746d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 4FJcOLzqmkEFZZf4+KdW5FfMPTw89XKm5ncA9BWsCAbWzf5hhte6S2gqepdRRF6TrcgbAld3UlGcmZDzjk/Kt9ls7/Ji1h1dlAW8Vrf0FSGZLnj7/ieab1oWqVTaau4B7XMfk2s7afx7K5PfWoxHco4rtYhv0pOnETKb+Ai0JBbnLS5bvj8qgG/6bxMy/qBbVaWTh53BDWKf4f+bUILe1SwVOJa0KNi4zizzDqvWXy0CiIKVaSWH6zaWMp2spKpKEjywNdFVOKbZ9eILsp2RFfEKK5WdvJDsw3k8sS2DHtiKOJtCKn315Zs7M/O4t+r7DrgsEBR3V8bkaFGV02wZimelEdbnrNvm7dJrtgdf7+4oMliLw+vsGPOojhvLlyZCorHObEw4J1FaL9cMAskFM6Vtqo7Uq26XG6af85F6k2/FKrb0szWbRurNE042JD1RlD9PCk8cXp30MMc+NYe+CThrSsErM/WrAmzBny32EmMl1tQzgEwRrf7y/480lXIuLhCQU5fBMpoi86L5Tyysyyeik8S4jhY56Z3AI21GYPlxkPncakYXHTOzDLPdKsyJV0nmK+8CrbTFmYxKEa5Jf8OZ0TrnUCSI7NaZwvAaqnjiLhqJRQdNTMNc1C2Cm1f9F9hsO3VkmUMMTu0oJvhketEMAW6LyQo3/dEXZCGORwCXwWJQZ/myQkbnFldYOzSgOQI2Ok+JHPdCHyOAhql71A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5RPMdpLWKT242sGNOQlvwcb73C4+68mtWBTgiWA3s1YkqfwMS1c7tAO5cGC/WDXw/fnAFsOPYSCp/mEPgBkFdNY2RfgEBmjI5mr7ukjW0UqEf/AU7179Y+KmoPPuUNsWkGrCrIkgYg0j4GoekJGxSs7l5kcRc6k+ORWRb6O5QrEMxBj5bhQOrNdNQSmyLn27lNlCS1CI2Zq13+tkzO6m09hI+NTXUopjoUcoWEjemdn+AGQNdgPcesimzbaQ0DD9v0rQhK4fWE2MweiSI4Ot/4Xn77+DyBYV6Z8h41T+2kMs8Hvb/2VJQEFRfDe55606WTRLfSGm/jD+JBRhffQzZ+1iIqKwN6LstBdjmOnqQ8X5WN15j7My6PWNoNX1FpGiOO6ftYW2zt3glyAldc5kOINmCzMvA3svT3GKZCyv2p3UA9lXc4F8QeA8ZSjYqzti
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:13.5797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa48da09-5cd6-4024-f58b-08defa47746d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Optimize and remove redundant code.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c | 123 +++++++++++------------------
 1 file changed, 48 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index c8eb1abaccb06..da06c840cfc09 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -420,43 +420,41 @@ static struct aca_block *ras_aca_get_block_handle(struct ras_core_context *ras_c
 	return &ras_core->ras_aca.aca_blk[blk];
 }
 
-static int ras_aca_clear_block_ecc_count(struct ras_core_context *ras_core, u32 blk)
+static void __clear_block_socket_ecc_count(struct ras_core_context *ras_core,
+			enum ras_block_id blk, struct aca_socket_ecc *socket)
 {
-	struct aca_block *aca_blk;
 	struct aca_aid_ecc  *aid_ecc;
-	int skt, aid, xcd;
-
-	mutex_lock(&ras_core->ras_aca.aca_lock);
-	aca_blk = ras_aca_get_block_handle(ras_core, blk);
-	for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++) {
-		for (aid = 0; aid < aca_blk->ecc.socket[skt].aid_num; aid++) {
-			aid_ecc = &aca_blk->ecc.socket[skt].aid[aid];
-			if (blk == RAS_BLOCK_ID__GFX) {
-				for (xcd = 0; xcd < aid_ecc->xcd.xcd_num; xcd++)
-					memset(&aid_ecc->xcd.xcd[xcd],
+	int aid, xcd;
+
+	for (aid = 0; aid < socket->aid_num; aid++) {
+		aid_ecc = &socket->aid[aid];
+		memset(&aid_ecc->ecc_err, 0, sizeof(aid_ecc->ecc_err));
+		if (blk == RAS_BLOCK_ID__GFX) {
+			for (xcd = 0; xcd < aid_ecc->xcd.xcd_num; xcd++)
+				memset(&aid_ecc->xcd.xcd[xcd],
 						0, sizeof(struct aca_xcd_ecc));
-			} else {
-				memset(&aid_ecc->ecc_err, 0, sizeof(aid_ecc->ecc_err));
-			}
 		}
 	}
-	mutex_unlock(&ras_core->ras_aca.aca_lock);
-
-	return 0;
 }
 
 int ras_aca_clear_all_blocks_ecc_count(struct ras_core_context *ras_core)
 {
+	struct aca_block *aca_blk;
 	enum ras_block_id blk;
-	int ret;
+	int skt;
 
+	mutex_lock(&ras_core->ras_aca.aca_lock);
 	for (blk = RAS_BLOCK_ID__UMC; blk < RAS_BLOCK_ID__LAST; blk++) {
-		ret = ras_aca_clear_block_ecc_count(ras_core, blk);
-		if (ret)
-			break;
+		aca_blk = ras_aca_get_block_handle(ras_core, blk);
+		if (aca_blk) {
+			for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++)
+				__clear_block_socket_ecc_count(ras_core,
+						blk, &aca_blk->ecc.socket[skt]);
+		}
 	}
+	mutex_unlock(&ras_core->ras_aca.aca_lock);
 
-	return ret;
+	return 0;
 }
 
 int ras_aca_clear_block_new_ecc_count(struct ras_core_context *ras_core, u32 blk)
@@ -491,29 +489,6 @@ int ras_aca_clear_block_new_ecc_count(struct ras_core_context *ras_core, u32 blk
 	return 0;
 }
 
-static int ras_aca_get_block_each_aid_ecc_count(struct ras_core_context *ras_core,
-						u32 blk, u32 skt, u32 aid, u32 xcd,
-						struct aca_ecc_count *ecc_count)
-{
-	struct aca_block *aca_blk;
-	struct aca_ecc_count *ecc_err;
-
-	aca_blk = ras_aca_get_block_handle(ras_core, blk);
-	if (blk == RAS_BLOCK_ID__GFX)
-		ecc_err = &aca_blk->ecc.socket[skt].aid[aid].xcd.xcd[xcd].ecc_err;
-	else
-		ecc_err = &aca_blk->ecc.socket[skt].aid[aid].ecc_err;
-
-	ecc_count->new_ce_count = ecc_err->new_ce_count;
-	ecc_count->total_ce_count = ecc_err->total_ce_count;
-	ecc_count->new_ue_count = ecc_err->new_ue_count;
-	ecc_count->total_ue_count = ecc_err->total_ue_count;
-	ecc_count->new_de_count = ecc_err->new_de_count;
-	ecc_count->total_de_count = ecc_err->total_de_count;
-
-	return 0;
-}
-
 static inline void _add_ecc_count(struct aca_ecc_count *des, struct aca_ecc_count *src)
 {
 	des->new_ce_count += src->new_ce_count;
@@ -524,6 +499,25 @@ static inline void _add_ecc_count(struct aca_ecc_count *des, struct aca_ecc_coun
 	des->total_de_count += src->total_de_count;
 }
 
+static void __get_block_socket_ecc_count(struct ras_core_context *ras_core,
+		u32 blk, struct aca_socket_ecc *socket, struct aca_ecc_count *ecc_count)
+{
+	struct aca_aid_ecc *aid_ecc;
+	int aid, xcd;
+
+	for (aid = 0; aid < socket->aid_num; aid++) {
+		aid_ecc = &socket->aid[aid];
+
+		/* Add AID error count */
+		_add_ecc_count(ecc_count, &aid_ecc->ecc_err);
+		if (blk == RAS_BLOCK_ID__GFX) {
+			/* Add XCD error count */
+			for (xcd = 0; xcd < aid_ecc->xcd.xcd_num; xcd++)
+				_add_ecc_count(ecc_count, &aid_ecc->xcd.xcd[xcd].ecc_err);
+		}
+	}
+}
+
 static const struct ras_aca_ip_func *aca_get_ip_func(
 				struct ras_core_context *ras_core, uint32_t ip_version)
 {
@@ -544,10 +538,9 @@ int ras_aca_get_block_ecc_count(struct ras_core_context *ras_core,
 {
 	struct ras_ecc_count *err_data = (struct ras_ecc_count *)data;
 	struct aca_block *aca_blk;
-	int skt, aid, xcd;
-	struct aca_ecc_count ecc_xcd;
-	struct aca_ecc_count ecc_aid;
+	struct aca_ecc_count skt_ecc;
 	struct aca_ecc_count ecc;
+	u32 skt;
 
 	if (blk >= RAS_BLOCK_ID__LAST)
 		return -EINVAL;
@@ -559,32 +552,12 @@ int ras_aca_get_block_ecc_count(struct ras_core_context *ras_core,
 	memset(&ecc, 0, sizeof(ecc));
 
 	mutex_lock(&ras_core->ras_aca.aca_lock);
-	if (blk == RAS_BLOCK_ID__GFX) {
-		for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++) {
-			for (aid = 0; aid < aca_blk->ecc.socket[skt].aid_num; aid++) {
-				memset(&ecc_aid, 0, sizeof(ecc_aid));
-				for (xcd = 0;
-				     xcd < aca_blk->ecc.socket[skt].aid[aid].xcd.xcd_num;
-				     xcd++) {
-					memset(&ecc_xcd, 0, sizeof(ecc_xcd));
-					if (ras_aca_get_block_each_aid_ecc_count(ras_core,
-							blk, skt, aid, xcd, &ecc_xcd))
-						continue;
-					_add_ecc_count(&ecc_aid, &ecc_xcd);
-				}
-				_add_ecc_count(&ecc, &ecc_aid);
-			}
-		}
-	} else {
-		for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++) {
-			for (aid = 0; aid < aca_blk->ecc.socket[skt].aid_num; aid++) {
-				memset(&ecc_aid, 0, sizeof(ecc_aid));
-				if (ras_aca_get_block_each_aid_ecc_count(ras_core,
-						blk, skt, aid, 0, &ecc_aid))
-					continue;
-				_add_ecc_count(&ecc, &ecc_aid);
-			}
-		}
+	for (skt = 0; skt < aca_blk->ecc.socket_num_per_hive; skt++) {
+		memset(&skt_ecc, 0, sizeof(skt_ecc));
+		__get_block_socket_ecc_count(ras_core, blk,
+				&aca_blk->ecc.socket[skt], &skt_ecc);
+
+		_add_ecc_count(&ecc, &skt_ecc);
 	}
 
 	err_data->new_ce_count = ecc.new_ce_count;
-- 
2.55.0

