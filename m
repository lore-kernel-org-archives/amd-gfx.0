Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46740CA0EFA
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 02:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA20C10EA47;
	Fri, 22 Aug 2025 02:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lGTtSxVr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EC810E310
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 02:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuPdV00uhN5pKcYU1DU62WTed4w+s1sPdUTN/E+RkYaIQ8echZw2dhriLq3fNrgXQ9WYQFafs5B596Jin4WsuUQ4TNm0D6A8J01VbYhjmrPDkv6QJViehT5ZJ+/IbczWr5TY19gWJc8UsBNMzNni7XfjiAX8lRMrgxbiJB3C6YLaHnW7AZTbuJjs39uTf0mYxSeH8rSV4vSg9a+iPK+d7DNcjOIad0AwjDYyPWSn+sd/HYKuGFi7MGTWvMnz9DT0+ggqFxWFmSth7fvvkHlsZmcxQmigbL/2JXJ1qo5o+94jGhl9QmHCc0sI3m8U8xbIoWaKlQSHS5R6sTfybCpo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWFJRUE1fxKdOHC7LUF7W231oNwV2PKFl3Hdn8lVGuE=;
 b=y+geCAcgwXcJd6OoDH9oCEQomz8IQzApnzgBUV46fXyWeBB0Vf1g243flarMQjs/JudveQMEJbUNjcU22qUT+Av2lCHinp7PlpI77unaWy+FZTCk+iXe2PHXMobZXMssZX+Ado2A35E+dOEfDLF0ewRSqILGt3+2a/3CNCCcMK7KW4ZB/cTMUJ4LUjcK/b0G54rvaEnXT81uOUx4ZmOaN+fMIYKjVVYR6PbodiplqKpDw2oGMRni1lPTWFt0lCw2bzO2xSC5Z1R8qjhYC5BRk765kuVi4hcMV77aYh6BwEufFF/IsTvh3H07vLQmM4j/Ok1/cAkhXMs/NPg+KHUFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWFJRUE1fxKdOHC7LUF7W231oNwV2PKFl3Hdn8lVGuE=;
 b=lGTtSxVrBUa9w3WNXk1zBXJWU/Pg8KyH3rffXvFTBp7ZWvL32D4XamEIkieg424m31Kp1ePgyklwgBdFAl1WnWtmo8lnH8O6SpC0gOxxJr7VOosGDQ4symZk2D25XmUyMPGSAa0ak/n9YJmbiq318jpx3jA80lV5CFSFqGl7x1w=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 22 Aug
 2025 02:18:10 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::a4) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 02:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 02:18:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 21:18:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 19:18:09 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 21:18:07 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v4 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
Date: Fri, 22 Aug 2025 10:17:32 +0800
Message-ID: <20250822021801.630568-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1173eb82-df71-4d1a-cdb7-08dde122237e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8IABdl7+8jaIO19rSkSihASuQwQGAbzhUPEnQ7f1/SW3gPZK/HbORbj0J8Tc?=
 =?us-ascii?Q?pMiNfJzgUKVq2Bfjbo2SObrJQQKSnpsJ9p94e9YdKQ8dA+mJBKs6Noz2Xlz9?=
 =?us-ascii?Q?f7Mo+/10h++X7GkeXOXbPkfnv4m9FqVZSMwpdQXM5shAgLg5TOgA3Rihw+6V?=
 =?us-ascii?Q?SNSo8eqWQeEr2RmXEFnO/PXl/Itj0avyRpLF9eC2yLRAKxpiZltD7A2QT6OC?=
 =?us-ascii?Q?Pt0PFcVLfAgkvE2a7vH0/18Uv8SS9zIJpkPlqHtprReyp6y8bhF5TUmDOJ9T?=
 =?us-ascii?Q?sG1fdiarOd6TU3U30bMO461KyRV0SuMD/k/BzWIW83XBzkFveaLy19EBwik/?=
 =?us-ascii?Q?eooLEuWSEGX0ZSyzQQV6h5tS4290r8RYF1G8FqKYTcrqoZLz7o3pNriuRYG1?=
 =?us-ascii?Q?dBzU2S2l+3ulw2V139iL7JddvZ5fdfjNiDqUTKH7R55tX5qDlPDd30M7egwL?=
 =?us-ascii?Q?gxvIJe15E/FNLLJ9DpJB9LwA+SBCMmUhyf1wqRxbIuwOuwXbFYHYdc6mj+3w?=
 =?us-ascii?Q?n8+j206sP7z22LthwccEA8+q3UUcuhDM6XQ1hHzw5QXfir+IAvIzDsdmavLC?=
 =?us-ascii?Q?wPRcQNdMVMk26Lnvb81x0Cst0xyUxRQJ9k36MLZYQU/YC/vzj8HtxsJl5dHx?=
 =?us-ascii?Q?wC1OB0D6E3bK5MT2izHkkrxS12rhZrMIM1Xz2MBJ4/pvxoo3eESL5WZvrR9f?=
 =?us-ascii?Q?Ywj0HePLttslOCAIfRFN5e3sD0sLhjrr3YgmdHygWqFdxztHpwa2gjHtnLx5?=
 =?us-ascii?Q?XMzLISRXYa0HXansUP1K3UEYWnnpVB0ckCB8kdyct4al5uZVz98PmJ5iSLXo?=
 =?us-ascii?Q?IHICpL9oTJk2lgrZjmHSaGnxIiQrnP+5XJC/dEXzZajZZjBTVi5w1kwXipGc?=
 =?us-ascii?Q?GjhutTAc5shqIrUcH8a9YO7yRjbYbr3nNHUWE7zLzJbdP5ClAXmBzQ1rloZf?=
 =?us-ascii?Q?DRcfRC2E13/BHWMxoCSctkwbwUgyD0dXZKOAFzNFjvAuoF0DLGUB434Bpkc/?=
 =?us-ascii?Q?J0y/xqub9+SFVrUsx9qEUudzV0TYy2w77v0h6kOVvn7I2R6Lg+3Fz9c58i7N?=
 =?us-ascii?Q?FOelYGC6JLkUfZhNMgOM5PnIVe7HG9LtZPh60UD9wBK/Xdg0qVoEUP2DwIRp?=
 =?us-ascii?Q?2j0sFXlj/AxOLztTJ1KE2cWBQ3w/6gQiRRl+IHpHSrN/rngZLPxP9ivnYV6m?=
 =?us-ascii?Q?QBqNq8kIS/BmlZVcfqGNPvF0st0FFn6NkA2vLAK+QmGkLe/AaTSg+vJmdszg?=
 =?us-ascii?Q?sItu4e/RadxYCezZZ0/OUBH1f2TBDhRxsMle96OQdicvoeJkffFxShrU7WNj?=
 =?us-ascii?Q?Da+FqlfvMOw0uRSKf2PVMhNNjTY1jeKF46ouKaZjnShr1ZObVrXFDB0jYWJJ?=
 =?us-ascii?Q?4Esh9RIFrXPHLFRZLuB4j8Ql+g+fmzCb3iufF5RJ42t93LWc4ct1CP//Fbm4?=
 =?us-ascii?Q?zgY25W0FRmLlz2Nx8Es7Zghe4zycRGFEeBkbRmXYt86QM58oV1Hq6/0PMdLO?=
 =?us-ascii?Q?Di/yJSw+9OHIzDUksKCUz/UBJXz5umQnMioR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:18:09.6699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1173eb82-df71-4d1a-cdb7-08dde122237e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164
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

Split the per-instance initialization code from vcn_v5_0_1_hw_init()
into a new vcn_v5_0_1_hw_init_inst() function. This improves code
organization by:

1. Separating the instance-specific initialization logic
2. Making the main init function more readable
3. Following the pattern used in queue reset

The SR-IOV specific initialization remains in the main function since
it has different requirements.

v2: return directly from amdgpu_ring_test_helper (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 36 +++++++++++++++----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 7cb21e2b4eb0..1b5d44fa2b57 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -256,6 +256,26 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v5_0_1_hw_init_inst(struct amdgpu_device *adev, int i)
+{
+	struct amdgpu_ring *ring;
+	int vcn_inst;
+
+	vcn_inst = GET_INST(VCN, i);
+	ring = &adev->vcn.inst[i].ring_enc[0];
+
+	if (ring->use_doorbell)
+		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+			11 * vcn_inst),
+			adev->vcn.inst[i].aid_id);
+
+	/* Re-init fw_shared, if required */
+	vcn_v5_0_1_fw_shared_init(adev, i);
+
+	return amdgpu_ring_test_helper(ring);
+}
+
 /**
  * vcn_v5_0_1_hw_init - start and test VCN block
  *
@@ -267,7 +287,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r, vcn_inst;
+	int i, r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v5_0_1_start_sriov(adev);
@@ -285,19 +305,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 		if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
 			adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			vcn_inst = GET_INST(VCN, i);
-			ring = &adev->vcn.inst[i].ring_enc[0];
-
-			if (ring->use_doorbell)
-				adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-					11 * vcn_inst),
-					adev->vcn.inst[i].aid_id);
-
-			/* Re-init fw_shared, if required */
-			vcn_v5_0_1_fw_shared_init(adev, i);
-
-			r = amdgpu_ring_test_helper(ring);
+			r = vcn_v5_0_1_hw_init_inst(adev, i);
 			if (r)
 				return r;
 		}
-- 
2.49.0

