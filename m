Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F36CD5BAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 14:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B53910E4D6;
	Thu, 21 May 2026 14:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c1Ki/HnR";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37CD10F356
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 14:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEUzCVX/1iATdl1Alpx2J6UMR3Z16Hok0FPnPrj4MpoIC1zv1sYFiLsGsRe7ZqegNJOprfzLbMyrjiFR2kM8nc4y8TZDu4geFdQWP6dwO077O1aKBOulT4dyNT8KSSMqeXeTkhDd3odoYSam5UjFmTjR5Ut8IDQtQrGTYECPLTSMCc6qgmdbWoQi4NzeJO/XmpTT6enKmTD9MIbyaJ4ww5OQ0Be8o10Np62l12pSYMnNHTxuwOY5uEFyGC95wZlN1u97kogp8MuzPEiv+5XQo5hsvPHpTsgtBzsh1nmN+lEaEc0LXeOU/4kBQCoa0cCzcK3M4+CfmGWPxP7bzhSkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJUFp5FO9+ySkLHGz6ZrKmBCENvpNQlsyty0Nxe2qg4=;
 b=EJ85HNAUqJgxDbK1mBckg1e8Ha4V42LR7wLphp+76AKd7+2aQIRrzO/Y5b0HBjc5fMQ8Be3VcFGBHsSQTih6eXYZIyQddtqPGGwkNTaD9ANoiJxIowYxiQdp431qfxdYNRglw63Q1jsBYdrwGRYP3JmrKHa+JryCgoK6gQ7edfDKFyoZLwBrAomqTGLEdum6ZltAf5G918/3c75IAwkkUA9tKIfq9D9AV7nQOZSbY9lwHAH7n2P3LeKTKU3EW7kRBFAuGtg5rH7HRnu19iF/Y8nuDg7tVMO5l6bm7eb6efeVtcMC/jjhtsfnQVEcz6A1pp3bE/r150Pr8GKLu+s3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJUFp5FO9+ySkLHGz6ZrKmBCENvpNQlsyty0Nxe2qg4=;
 b=c1Ki/HnRH9anUTxbApAIrw9dMcflck+2Ph/hwubLY54rhApkCA8r0umfw+/610vS9iyXJM0nkIwEGEPHHX/3XxBoToMoJ6YJKDH94OBRv7IMA2P73KjzOdxuI6jQ+LMd+We/lWOKawxIVsADY6qTPxcPDfojTqGh0Y4nJedY8lA=
Received: from CH2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:610:51::33)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:41:53 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::f8) by CH2PR15CA0023.outlook.office365.com
 (2603:10b6:610:51::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 14:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 14:41:52 +0000
Received: from SATLEXMB04.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 09:41:51 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>, David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu/vcn4: avoid rereading IB param length
Date: Thu, 21 May 2026 10:41:37 -0400
Message-ID: <20260521144137.735538-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d87aaed-a445-4c01-0125-08deb7471968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: sXkr6chaoL1Z2jFA5JmfkCheXjtitqX0u02hXwkQnBL9nIxfydpLUlJkuouvRC0sNfhtJ2IwBCdyDk/Nxkolk8e58o7DrUXcc45os28oUvWTTBOn24OBZJ7MSm8zbGThS1u6xtU0Ru8rjJz8GNhvAvlDk1CiXrCU1tXE2lFdXsc7ECQx1M9ruCkhXL7gUG19GTQkIn1HUxN9Z27B9rMvpRJJHnqWSIS1WHiIdNid5v0R21M2VbTN98GQ/z60h7udlvKamat04u1UchzVPFcpLo55Gadlo34nFKwhnnManx50H7W5I9KJaejQLtPkgh7WY/yXLskWnYBZi5rbyMy+K4Cwq5jYwUZWZIiHZujtSwpa0g/eGSR4ITztOQBF2kfIg8yF+vhjrwLaRjobOBfMlnipmC3ft0wWwdLMpMpLZjrWzPer4lwMtPvF2BfFdj28mKzMh4WAU0mfdInW5hmzzEdTFRlUVeeG1yywjElnSWn/qGJh+zk6+lccsKeopOEBETmGnS5fBEP2K9TIZozO3X3wsFkkZR/iluvd+ITd/F1uSLnwj2hkpbt1tfPzm50lZBicr7Q447JP7vTRbf7PgdwmiANFsOqDPJpyLiU7viTzbeWY5LdVGQEYDtQgna9VYjaQKc0kkwTKmIwwCIfWLUV5v5dClcFmVIkOyJfP8Dy8WUQv6DB4Y/3Yi4Fg5maUqYN1/5wzL+UHzar2HM5FlbRS8t6rbk6ZgMvugnzZnZM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FnX35GYB2DnSVp63mz5PJ2oZ5aBCT4fq1Qs74JhE756TLI/0XugTKrcbiW4EkGK9RaWk1ygfMKWsZA/U9+F1WS+hRo9jfwLwNdIyqcHkFBZ3tVv6h2WBqf3Nlpktzxb2cyZwjnKXbhn4R6XPx7WLmAhTM7JSH9/eLlaYM1uD97Fc5vZWxsVzRtgcTQXay1xDFbQEidzXumehwuWSLDNn+7QZ9MZnWzZ96W2w5JdBXXGCzXzYwk0lsV6b1d0gqTmD4VAkui/URVxaGe0QBaVSHxbCgr7nk1LCIQ8qzovyqTtxChjszJzLU6qvrzi+qm19kU+vp6vh9u65x3LELgvHUznlnDY/F/5Z7yJukuIgGpcmJdc5AePXDtsmB2xa2rcfapfio0cm4yI7EoNueShDaKHYF7SmPKrXSsckGCstoE9PbF83sWqC79i7bPU/L0Jd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:41:52.9194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d87aaed-a445-4c01-0125-08deb7471968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Reuse the parameter length returned by
vcn_v4_0_enc_find_ib_param() instead of rereading it from
the IB.

This avoids a potential TOCTOU issue if the IB contents
change between reads.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ff7269bafae8..894780669f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1927,14 +1927,17 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 #define RENCODE_IB_PARAM_SESSION_INIT			0x00000003
 
 /* return the offset in ib if id is found, -1 otherwise */
-static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int start)
+static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int start, uint32_t *length)
 {
 	int i;
 	uint32_t len;
 
 	for (i = start; (len = amdgpu_ib_get_value(ib, i)) >= 8; i += len / 4) {
-		if (amdgpu_ib_get_value(ib, i + 1) == id)
+		if (amdgpu_ib_get_value(ib, i + 1) == id) {
+			if (length)
+				*length = len;
 			return i;
+		}
 	}
 	return -1;
 }
@@ -1944,14 +1947,14 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_ib *ib)
 {
 	struct amdgpu_ring *ring = amdgpu_job_ring(job);
-	uint32_t val;
+	uint32_t val, len;
 	int idx = 0, sidx;
 
 	/* The first instance can decode anything */
 	if (!ring->me)
 		return 0;
 
-	while ((idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO, idx)) >= 0) {
+	while ((idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO, idx, &len)) >= 0) {
 		val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
 		if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
 			uint32_t valid_buf_flag = amdgpu_ib_get_value(ib, idx + 6);
@@ -1964,12 +1967,12 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 				amdgpu_ib_get_value(ib, idx + 8);
 			return vcn_v4_0_dec_msg(p, job, msg_buffer_addr);
 		} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
-			sidx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx);
+			sidx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx, NULL);
 			if (sidx >= 0 &&
 			    amdgpu_ib_get_value(ib, sidx + 2) == RENCODE_ENCODE_STANDARD_AV1)
 				return vcn_v4_0_limit_sched(p, job);
 		}
-		idx += amdgpu_ib_get_value(ib, idx) / 4;
+		idx += len / 4;
 	}
 	return 0;
 }
-- 
2.43.0

