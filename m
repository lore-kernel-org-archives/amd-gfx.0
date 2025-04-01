Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA92C36010
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 03:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87C510E4D2;
	Tue,  1 Apr 2025 03:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TJABlqol";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E0710E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 03:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCjn9tLxsnUEO9pvp+SKLinIZgG16uTPw1bdDlYe/UIpSArukSaV18/dGnf8OtSJV+vqjMl7JUravZGVGdzYNI6tFR5qQtctEWDHAfwIBojrWHK9Ab9ZjjRZAg3I6vaw1C7h7BNw/xQKyEUUTeNoT2RPV/++OjBbMZlSND0HEbmYHkjeum2VajeB5bYqQHsbk6sYOkrwJ/6I+MUrkHso8wO6maj50oMrGTd5GnYzGKzrEQW3JI+CHXvlkjKn0U9ZQCBBsKjWrf1IFlO/tX+Bn6L6EXn+5shgxrkJpJ7ce15Y9DaLe7NaoivJS9SqlBDgfbVAsLsuba8g3zSbuDkcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y237qbPCoOXsgaLiKGrXlvyl78uxjPSzHd9sRCRCFk=;
 b=xeqZvrwISoLW5cAB8/ctsYo5kSWmZpP1foTcb8xP3+O7/Ctla83hTsLCtOsx4/fJLpWGlAZYr/iHFMBnoYxqW8qe4y9g0RXDjwpEKNYWWgEFGwAa3ON4jEFhj2FhwU1RBKzq22ZDsQJF/W/Jqd8dnD+W9isPsSfnA5sKsjGyMdxDTHEYovWivhUBizCJbiO43v/bvl68uzQuqvyy+7yEkW87D7mG7NX37WZPNT4UwScUtnYvLfhApUP8b/YYkdivy9SEaz1CXeQacjeEKX9G01D4JeghOTFneklTLdv+tZSq8xCstpFt3ZiLMbo5WqZvWR6rVUzOM2e+KawrfGiowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y237qbPCoOXsgaLiKGrXlvyl78uxjPSzHd9sRCRCFk=;
 b=TJABlqolffB/ahsmOrcquFEii1pvAiTncEBqeXnZHjZCD5qOLM0uMAqD9h358C9JCNsPp6OALsIhfq832G3rduprCENzhhKqpmBNnnowGMVEyhdEWwYnBQaFewCuc8omsnXHgxGr1pPqZ4kzFYXgBq/VtcdpeCjc866mA6MVHlY=
Received: from CH0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:610:cc::33)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 03:05:50 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::99) by CH0PR03CA0088.outlook.office365.com
 (2603:10b6:610:cc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 03:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 03:05:49 +0000
Received: from ruili-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 22:05:47 -0500
From: <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Leo.Liu@amd.com>, <Sonny.Jiang@amd.com>,
 <Shimmer.Huang@amd.com>, <Jenny-Jing.Liu@amd.com>, Ruili Ji
 <ruiliji2@amd.com>
Subject: [PATCH 2/3] amd/amdgpu: Init vcn hardware per instance for vcn 4.0.3
Date: Mon, 31 Mar 2025 23:05:33 -0400
Message-ID: <20250401030534.3880347-2-ruili.ji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401030534.3880347-1-ruili.ji@amd.com>
References: <20250401030534.3880347-1-ruili.ji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 275ce3d6-62f2-43dd-1f83-08dd70ca1b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UI5Y81zkRHlWbI5i4ayA79WMcGGwMGroPhlwfkpr4n1tR94wQ7ZBiYfrxJcg?=
 =?us-ascii?Q?gmYLp4ja3QKII/ZaKNH4ybNPkN1ObMVOjHepOFBZCl60v3Ihh/tOXlMch5U7?=
 =?us-ascii?Q?s6yYarF2S6L0QlLIjJoTf7MGhFWUWGq93mQPwB79o1MS9aWyZzicl+ty9M6P?=
 =?us-ascii?Q?CrtJtkkOPVSsFDteS/aYwvwiuMWsvrY+tlVLoijIVndP9xAZDUaM7hNk90tj?=
 =?us-ascii?Q?F1FbLyRp1VsUFhR3bcxaBLBDbP+d2b1RWTqdF2OcPYsbgpMGZ2Zl4N3LGJN8?=
 =?us-ascii?Q?AOM4RwYIgkhFHqQkV5ij6QBb2wi6WceCi4B6N2Wjf0dnBrEedZHIPNkLwqvA?=
 =?us-ascii?Q?+W0Za13W2ec06T/uihEbQpEddorLyulnNrexjNK0Q2HBz00UMd31D6HMqI2x?=
 =?us-ascii?Q?vOsg7BFrwyuyuvLEt/cAsuhn0uxc/Xr58ASf/caxMqPEhcxJgV5xiPKJe32/?=
 =?us-ascii?Q?hzi18XAvyK2NvHlNFxU6ZoYZaSIwwLI09bI5HckWLXD+W1z+L1bBDDWh972O?=
 =?us-ascii?Q?JCRFXToQmzUiC29LXYcyVUBv10d9PbvIf0L2Kb/XI2dxX3bXb0jZpdUL8oz6?=
 =?us-ascii?Q?2XUxjRW+zxoUZilD6peeyRddVZuZc6maFqKObEGYPgabd2TQbSpApEpzRu+E?=
 =?us-ascii?Q?Ug/sSgXj4ZU6M6gGD8kr1UYwW3U8MI+/3q+Nh19OQQcxtt/pxGHaR1nB5hKn?=
 =?us-ascii?Q?XVq7WVjRcp8KQQIuHzenlDua148+knWKpWEloxke7i3cybnhhNIP+ye3lZX2?=
 =?us-ascii?Q?ot064aWtz2JCcaQS66F74918zXvJxIHLLGmprcPjZnbk0ndkTpvxn5YK6iWc?=
 =?us-ascii?Q?fSpl7oipfykCzhTT0EGvepyCLV8/BL/TeMspZffFlA6n8UzlEktWd87KLY8h?=
 =?us-ascii?Q?IakVCjTJaSbUmA8My74DgHIxNb9RsS0sPjQ0opnnrEamav2Y9P9ezvEjFKSt?=
 =?us-ascii?Q?sR1OXWAM9AtsiPkZKsQQ+NVGNum6WbO9Q2R6ecH1nfihRT0o+2VTGF/MnJKU?=
 =?us-ascii?Q?1ILHMW8rHqsivNXpSMA8Kvia6bokPcx6mDDkWHWUPzwQKcLwVtaqaEwXbqOY?=
 =?us-ascii?Q?TkjxLhn+14KwAejsHONg70/NADB4DSoNFOYkfQmOMNGkXYORZFK17ZylM0Pw?=
 =?us-ascii?Q?FflLecq20ntFE+AACgA4MvAmLL4f8ST1NGQLzdhxwyEhkKoNVqHznGDcb0ZE?=
 =?us-ascii?Q?995n3/3WSNCcHcy595Dddsj1NV3XALGop7vV2EpexASgsssiYoPgbeEo7XVt?=
 =?us-ascii?Q?A1FtkH5+Z8pbwWuLmeMBVwgo9W75mJUo2ZZn6SqjTuJCBXVPj8ASJ+mdK+Ok?=
 =?us-ascii?Q?1IYScKJLF3sToAqNwc1CaojuE42FCyzjFdztgM3zkN7CXCVkvWlGwnezjB8h?=
 =?us-ascii?Q?TfllXxGfA0GUv0/GwtCuZCiRwOIlkNZo4yn4of6FZaUHETsGH5AhFzvrkKuG?=
 =?us-ascii?Q?/g2lbHpGEo9nyUKvplevgk4XsOf9YA2Fhb38im7Wx7XFfwS0MTsHBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 03:05:49.7711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275ce3d6-62f2-43dd-1f83-08dd70ca1b35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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

From: Ruili Ji <ruiliji2@amd.com>

Add interface for hardware init by vcn instance.

Reviewed-by:Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by:Leo Liu <leo.liu@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 53 +++++++++++++++----------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7446ecc55714..b27e26e21ca6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -287,6 +287,36 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v4_0_3_hw_init_inst(struct amdgpu_vcn_inst *vinst)
+{
+	int vcn_inst;
+	struct amdgpu_device *adev = vinst->adev;
+	struct amdgpu_ring *ring;
+	int inst_idx = vinst->inst;
+
+	vcn_inst = GET_INST(VCN, inst_idx);
+	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+	if (ring->use_doorbell) {
+		adev->nbio.funcs->vcn_doorbell_range(
+			adev, ring->use_doorbell,
+			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				9 * vcn_inst,
+			adev->vcn.inst[inst_idx].aid_id);
+
+		WREG32_SOC15(
+			VCN, vcn_inst,
+			regVCN_RB1_DB_CTRL,
+			ring->doorbell_index
+					<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+				VCN_RB1_DB_CTRL__EN_MASK);
+
+		/* Read DB_CTRL to flush the write DB_CTRL command. */
+		RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+	}
+
+	return 0;
+}
+
 /**
  * vcn_v4_0_3_hw_init - start and test VCN block
  *
@@ -298,6 +328,7 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
+	struct amdgpu_vcn_inst *vinst;
 	int i, r, vcn_inst;
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -323,26 +354,8 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 
 			vcn_inst = GET_INST(VCN, i);
 			ring = &adev->vcn.inst[i].ring_enc[0];
-
-			if (ring->use_doorbell) {
-				adev->nbio.funcs->vcn_doorbell_range(
-					adev, ring->use_doorbell,
-					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-						9 * vcn_inst,
-					adev->vcn.inst[i].aid_id);
-
-				WREG32_SOC15(
-					VCN, GET_INST(VCN, ring->me),
-					regVCN_RB1_DB_CTRL,
-					ring->doorbell_index
-							<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-						VCN_RB1_DB_CTRL__EN_MASK);
-
-				/* Read DB_CTRL to flush the write DB_CTRL command. */
-				RREG32_SOC15(
-					VCN, GET_INST(VCN, ring->me),
-					regVCN_RB1_DB_CTRL);
-			}
+			vinst = &adev->vcn.inst[i];
+			vcn_v4_0_3_hw_init_inst(vinst);
 
 			/* Re-init fw_shared when RAS fatal error occurred */
 			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-- 
2.34.1

