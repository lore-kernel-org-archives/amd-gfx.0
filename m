Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24B2C3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 18:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A650E10E214;
	Tue, 13 May 2025 18:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qEUnrf2R";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB40F10E214
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 18:23:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHmLGVOkyOdfiA8qxBv9SWNGhkN6OKzRHfbiFdLp4avlKTuSAw9omNXP0TlGAAzwM5omEUD/t2mTKcLdrITOhsq/7DcQDKTDHF/ipGmtiesjfuLMy4yExOK4ZbuY1xOQaQiRWioBk7MTtrApSWyo/aa7qRfcBJboXDmJLABfcv3u0xMMOOBxTS/D/dFClf6sqAqZmExP/vJ9UZo5aqwkDlYKPIWMHK/BoLfCb9WbtX7uCQsqnBqInj3qsMDEjXnTOY/arXN7GRz/1DmFM08aPlz68x4bgDBghM2PfNpZfbcPgZ1jBXwZ5zZP5FeY2A3vIa6hN4RjmVGSNEnVvvX0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qO6CivGvllevYAA3m0nSkIP9NODWiRSkAc9yweGcY0w=;
 b=KqUdIWWQPtX4QxQlGUjaBSIvTMn5YitIMNZhqzKebV4P4Hv8nK8izedoLbn1dqpS22C5nowcN3inS2qCPOUS/9NgpO4KY8fKTDaz1EqMfxC2WYpvNy8DhgPQOa7p47NzNFN36Y1AY9mAsJPUtgwEBFvYLxQkDntc7YsKt5Q8R1dQIm0lOjX+8xv5BXsPeXzJA6fEVL81fGWGf5wUaEgPZV9PDR4cKuB8xGFSnV3FtXdmLMcCqROo1Uh8Ao/BffWgWAyhcEDuUiDYf/x9zz+p1SMEGivw4QBH5wBK5dTlTm3A45k8vyQNTPS37qygCGUZ+8UVYPSsk1XiKSIG4OvVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO6CivGvllevYAA3m0nSkIP9NODWiRSkAc9yweGcY0w=;
 b=qEUnrf2Rax0BCK9a09Zqb8D/Vn8Bs+uTW6VK+qoxiPnLHVBJehKdKEVkHQPMFtR1GdvjIBAsn6EW0eEyplfA6EDw79CbrITYAXe2DzlaZk7hk386hXUR1LkWue9nIXy1yOt8nf6E23yoSkOlu5DGCNXkgnF0/V5uuGKjvSORPNU=
Received: from SJ0PR13CA0199.namprd13.prod.outlook.com (2603:10b6:a03:2c3::24)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 18:23:22 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::b6) by SJ0PR13CA0199.outlook.office365.com
 (2603:10b6:a03:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 13 May 2025 18:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 18:23:22 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 May 2025 13:23:20 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu: read back register after written for VCN
 v4.0.0 and v5.0.0
Date: Tue, 13 May 2025 14:23:07 -0400
Message-ID: <20250513182307.642953-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513182307.642953-1-David.Wu3@amd.com>
References: <20250513182307.642953-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 932e0e5c-3710-46b0-b618-08dd924b3e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?74O3ZT9vl80g4GMzUiQhSUycx4C55n9jn4RNqBvjdgv5tupx3MTvgQbDrEYt?=
 =?us-ascii?Q?lur/wOe79j+PWqs+fMxHAZORgnS/WnczvAzf8Ht9RNSG2n3gIjtN4zXOAGoR?=
 =?us-ascii?Q?QZ24TlKhxumriNHQ5pgyqUO9SrUC/C+ZBFNKdX+v0h0rRcxJXsJLQD9hesQ/?=
 =?us-ascii?Q?6p1sZRkPYDtdXxrpn49+oo1QobugbXo1qpNgvETROuIu9JyOx85kLW+iGU1N?=
 =?us-ascii?Q?Dz435qs7yXpHT4WvEYpdSUYiv9fF/PPl4MotmuEnQp2YTpz9PZejVwUjrn2a?=
 =?us-ascii?Q?CRlNrFGrwlXDrhLrlB16VgYGsK+xT/PEGQPs4+cTZGvrXqm8CNqJ/IWHjPa0?=
 =?us-ascii?Q?0zk6xW2Moo7Ova4DKaSX3oGv+VPL+1iTujk2ChJKRFnvb9zUFSSVP1n6b2fX?=
 =?us-ascii?Q?+dWqEJHODeOaeo8xwAXpn//PaNLJ4gFy3G2/eZzryGwoSWWSQpxQxlh6H/x6?=
 =?us-ascii?Q?eTRKivNfZS/wMGUIAyWUQtuPFlBoGTcHmGLOuSgxp95IdwfJ1Tv9oApzBvhB?=
 =?us-ascii?Q?yCD9tdhkDiIGkgL4MS9uUO2G9jRrnkiy9eeXvuAcP3+zkUquOuLshiu4JgBw?=
 =?us-ascii?Q?k+vNYrNmIkgJliaUqp5frHQV6WDssh5sMhtydR+7FKItuCJnzGWJL3gyOybL?=
 =?us-ascii?Q?WpRX++V526NxccnoTMGM0rXR5IyZdhWX6fD8p7I87DEXinYUNGTilIntL1vv?=
 =?us-ascii?Q?14BmWnZoQ5/Dt16lAEzn9H2SlcJkESoeRvjOhTOtngmvDQg9B1PbClqSbfOQ?=
 =?us-ascii?Q?aRTK8eVdvDnHLsXRDmJp+w2fv5hPkRYA/9Dwr8rYOddqv2YP5bXajgusDh13?=
 =?us-ascii?Q?GpwFQFg0E+Dm2/ZJLoupPr7UlYnsSa5urhkzkxJHR11949ovm+cgUCVX+I+J?=
 =?us-ascii?Q?PQa/TjuKHJE64cfM5HYowqMrhcWHFhYHH/3wZ8IQ561UTC4CcERLUpnvVLR8?=
 =?us-ascii?Q?t/UX8k01Y7oqVMkgj0xIJ2MnrUqgLqzk7T9qSn3ffTIZgAYigdDczZ1ZuuND?=
 =?us-ascii?Q?0VKKJJhtBYf9LV1MLDlmQJZ9VHEBXkI4tCGOk4C3ymQDCAogpqAuEcWWNhBn?=
 =?us-ascii?Q?OcNwyUgR8EjK0V37+Am1Ih967tr90FLxfGPgiqYsCTT4eSznuvmzga9d1yCZ?=
 =?us-ascii?Q?tnzyYvf9+KBJRzfTmNXG1J4FolwSnhDIQLv1cIMCXogSdchPpZlO6007Tu2K?=
 =?us-ascii?Q?VxwQTPIOVvYcueXOZ5mxYUENOjrdGHu+XhPX3Scle/kMVg+EhMFp2n8KtZq/?=
 =?us-ascii?Q?obQqhrqwvfxqsiBLOigcvn5+92fXQthYjk9AAPrxLhR0DRr10MpcFjlFCSr0?=
 =?us-ascii?Q?2mSVTjHtx++RQP6I4ArpkF7fOITNMcUgyODMFOsevDspSG+JflHfJfqIFod9?=
 =?us-ascii?Q?gi4o+sAhuRYajFmCTroORsyckwCt6cRUaltRnh1+T+5aC54CSmhOed+fBeLF?=
 =?us-ascii?Q?rJ7HaShgZt3b/fh06qVJ0nalVLSkxK6DjwTxjwcPwiwjMXpObxMNtQBhs4G+?=
 =?us-ascii?Q?s8SGhCM8zPxOFa1sGGZf1E10iwC8s+iLbLzM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:23:22.0684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 932e0e5c-3710-46b0-b618-08dd924b3e4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193
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

V2: not to add extra read-back in vcn_v4_0_start and vcn_v5_0_0_start as
    there are read-back calls already. New comments for better understanding.

Similar to the previous changes made for VCN v4.0.5, the addition of
register read-back support in VCN v4.0.0 and v5.0.0 is intended to
prevent potential race conditions, even though such issues have not
been observed yet. This change ensures consistency across different
VCN variants and helps avoid similar issues on newer or closely
related GPUs. The overhead introduced by this read-back is negligible.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8fff470bce873..070a2a8cdf6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 27dcc6f37a730..77c27a317e4c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
-- 
2.34.1

