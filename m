Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71E8C02190
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F7110E3FA;
	Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4R8HMW8e";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC5F10E3F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExZUUD3y9vwuSqg43eUztaDumnDpChn7nNjYc5fE54TAd2YYog2XkmghbOz94Q8E7s7UdFk5IZSvdSlNgiz1fALK3SfhqKV1+fJbsypSYoQgRN2IEIFpAcfkR0Gq3NLIK3mYVDogQoFSuo3EHbUE4hkIZ7jGG3JREYh8hltom9aQVIvzVnt4Qz+1ssxoPBASBKFelvO3DaR1pxl8UCIHcwHR7vS32Yz8SNG6FBBpNeHSiiFxNCMQaIUmkP2fLh4k+WuqnMYft+Emk1XIqmrBNwieD8vKQ8Cyjf2PT/u6g7i/JGnZbvfL+/dtfuX+ImnCbCaN/YxOj/QcgZ0lEwgv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZI3WOG0KhUriNuqXp2zHJyfH2Vzaobg9CZF4iiNZUQ=;
 b=gyOBSpJjpzHsjhj2XI/OUtWBGQsUEuISZbfN7QV/QSgdH8ZiTl/myIuJB2tWVKCZkI4/qqVNn9U6Xj9+mREAUxW68Jkgjjz+DiJx8ok1UusyB6AzKtAGyptG7SFRKdbLBQ/ISO+mvcnEKM1qa4fb3Y2oELN5pQ8fV166QZ9vEZZEegFxeDEVy9ccV1zUpjgN2bzJoFyaBNEsm/2Q19FPiQs8avr8pGuR/E5pknv3zGSI+s6K+q0cTuckwY/0EL0Ch0mTwwM0OSF61MlaAP2brm+/bNOjvRRP1Nm28HaJVYkoaMRWmyaR9VrQG/7xbXkafi0oSVPW5relI1chiSybVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZI3WOG0KhUriNuqXp2zHJyfH2Vzaobg9CZF4iiNZUQ=;
 b=4R8HMW8e3LjG3xsEoKIiZ45X5N2uNCI/o+zBn2SBj9J6AsfB2u9O9Tf4dZy+ONZSsyXsKBa4ERwWQHyk7E1ANFK+hGCwgJPdUe/FiC5KWYQ1p7hcB4ol8gwdKHn3dUpnDdaI7u3kiPCpgNV59AueiASj9y35gyUgtAsvJCSWA6A=
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 31 Jan
 2025 16:58:27 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::1d) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/44] drm/amdgpu/vcn4.0.3: use generic set_power_gating_state
 helper
Date: Fri, 31 Jan 2025 11:57:35 -0500
Message-ID: <20250131165741.1798488-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: db55464f-8bae-4813-fa2d-08dd42187b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PD4sQ3PuJwSO3ihR1gHoPUYzsclJtqH4l1SS2s9/fx8qIr04U8EbFzMJoqYP?=
 =?us-ascii?Q?dxJQVOTAkPbj6pMlp0hvhFeVyt4J8o4VOMDFPWvhO77nSF4hNne5qpdtzDd9?=
 =?us-ascii?Q?h9gdLBcAbUxPvEsQwt0hgZ/s4EIAIUUyuUlqUK4UV2Vsib/iLGpYQ14OdBkE?=
 =?us-ascii?Q?vYcJbVhEF0Wgzv/WF60rlom2JrRLI8AdgyuVgavC3jhtcuyCWfxL5L0/ql+T?=
 =?us-ascii?Q?xupoLaydYYnRghYkZ8pVfWr0knfPMvpcL2y9jdvol1hltqwfCOjV9cqfu7ZJ?=
 =?us-ascii?Q?6yZKLhYKqcOA43vk5Lua5zGishmyMdMOMrKkh8iGw3ubP/EnKxylfGM9TQ7a?=
 =?us-ascii?Q?r6ZowlSRy6yJayzWhKfHpi/wPEeXRcAIGPEDpCLhNjr3uwkie2p8p1my9LYt?=
 =?us-ascii?Q?cK6WtARQ6fEeHCp/M1RCE35Rqp8O04drzETwDkb57GX++jTzCYi5eDFa34Ii?=
 =?us-ascii?Q?Azwk9whhEjck9eMo8WD2zrv9VvosXsVNgN+CPxsXWK7GrzeZRRN5qVIszxB1?=
 =?us-ascii?Q?E5t4ReUbvr4wikrcsjWtPDGHy7nCUePWkQKQ9BCdv3wApnjoTe+5Dc2pilE2?=
 =?us-ascii?Q?kMMDS/T091w5a2gKBBKX3inPfZ2QQ2BWQg7w+sQPC3za5Dng4gicrRMnfF4F?=
 =?us-ascii?Q?MUyqWRRxLcCFLKkVtrmUO0c4G23pJW5dsD55LNijQyNDVUwFpL8tttbgeW2p?=
 =?us-ascii?Q?eroDnoTgcdgKU0hTPIZ5Mg+RAto9ztmZU6pwIwCmc02TrxLEtJb/B/7fUlh0?=
 =?us-ascii?Q?8TXtL41Jz3aTVfULpeKGKffxBC1vN+hHsNDQ7j7Mxajs0bQTXI0m2hHd6C17?=
 =?us-ascii?Q?S9lm7MDzxhkz5j1lkYYYD7Ay5MShLxZ4OdBQ65EYch6FHfAF4g3FC+SHUTyL?=
 =?us-ascii?Q?XwSZmMoXLjl8y5s106puwIsKN1Zj9OfnaZzhExN5355fPTEZ/xhe0wIV3Zj5?=
 =?us-ascii?Q?rtDWYk+FQcbfxGkMt+iRdZ/gi5r9pb5zsDeGzd2CzMTuS95Ws5jmW3ZK6mKy?=
 =?us-ascii?Q?F6ytFU/I7XeaseaLoMVvHN/qdUK5FZVngnprWSvNgEIpl04W4ZjokJPt/pBm?=
 =?us-ascii?Q?SOwc1DEg6Xi3xNXHjGq3OekFqlivTk8uqlk7lmIW4TM1rPO23aOWwcvR1bVu?=
 =?us-ascii?Q?7lngDlK8EA2uQEUaIioD0Rtf0sAmN/1h/ZFzQLOjfx3Nx7v/pG9y+ZAD9/pM?=
 =?us-ascii?Q?etbYwu5s8sEv+I/BqC33SRFooMOKg3EDIDFkgG/7SexTSVNOcer4CtMxaUyX?=
 =?us-ascii?Q?Sf5lR3rcd2eSn/2utjrN2Sb8lPb3Rr9Mj8wruvBY/7Y9rN0BI6Qy9BQ9rG/i?=
 =?us-ascii?Q?CXmo2aW7L6OaeEE59HfYvhByI05TmSsnCpkvh+aove/qUpKuEy6wjK+X4W5U?=
 =?us-ascii?Q?xrbQNTsGJg1rxr2l4/KA+usiMZnDvmTeoroL/29m3fiNxoEBQB5oHunt/IqC?=
 =?us-ascii?Q?bbtyA5nwqAlDQebCVC5gTw8tffcJJHvFEz7jOJIPf2iTbC4L5Rtbsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:27.0806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db55464f-8bae-4813-fa2d-08dd42187b4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 27 +------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 219e95c1e35ee..7f4120b372df1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -89,8 +89,6 @@ static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_3_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state);
-static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				     struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -1719,29 +1717,6 @@ static int vcn_v4_0_3_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-/**
- * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v4_0_3_set_interrupt_state - set VCN block interrupt state
  *
@@ -1899,7 +1874,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.is_idle = vcn_v4_0_3_is_idle,
 	.wait_for_idle = vcn_v4_0_3_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
-	.set_powergating_state = vcn_v4_0_3_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v4_0_3_dump_ip_state,
 	.print_ip_state = vcn_v4_0_3_print_ip_state,
 };
-- 
2.48.1

