Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8A9C25B5F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15DC112CAA;
	Mon, 29 Apr 2024 14:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35zbuyZu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE21010E70C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifMSG4BPadGs+6Sdc1ymyN47572ol+XiqL8ijkZuEEkXKDEbrYqQ0VYf/XnJ/12DxDJFFXFB5pQKEVsWghmve2uatLCdkxQYSHMHRxt4t4TTnJ9D+Dr5lAA+JXZiXOwWlqfVz/NNrP41cZ5QEOzSaSrve68d1L2DtGOUvN+O1g8Y3uW4mAmlWvVyCqPKApXzEgXDy302UixiTn+sPi2qXIrr3YWY5g4NxOcM/owQV7i0Ccin10lkK8ImMilts2hmz+CxBFTpLYWHA8sWcYCluPSR8BeVv5Byv+55/cnXEjVE0E9tpUeX6ctpKI92FBCSHUPdYyOLIPoLh842jkxxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXcQyqvMHx+8XyfLxPTy1MnNrLunXpZChJu9CXB97sQ=;
 b=Bd+RcXzN+6O001WfdH98eLsnhPbW7ma0mWnGgWEoxcAwW0um9ZFES4u9tqOiRgfzvVhl3xRfMz5VhmYKnzKIRtMPKAhBjO1s+fX6gYbHY7XkULL2HBijWwyKgB0mz1NRSfDimko5yowWWRUH28txcxXRLgz5pYNyhwpldkobjbBdfIlin2hFM+0FzeA7qok/KrBOHRmMJTRjkHKYD9GcUILwFPd2AanSDlNyd2Moll56FsN7n9RRycN+8wPMqdKKIAEeSNx/uX3mmgRPBfBWPcmUKMe60KlrtN0NbPi7/sH2fB7E4woRRm2xkBUbRUvoalBUOsyW6nrM8mbwMYigxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXcQyqvMHx+8XyfLxPTy1MnNrLunXpZChJu9CXB97sQ=;
 b=35zbuyZufygp3jiRHktHwa5uMjK1IHOIa2tGVE54grMQb1Ao1TSbTIpNmag3LPxlIOrFyYbPRIMvNCiIupRLY7L2xRevkoXfYQmyD4IPsWE7KRXEx7sKfguCmsnKzqbFV7mJRQQWD1jH2yobZr76eQ++l8W8j0wULt2GbMOr9PY=
Received: from BYAPR06CA0036.namprd06.prod.outlook.com (2603:10b6:a03:d4::49)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:20 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::3c) by BYAPR06CA0036.outlook.office365.com
 (2603:10b6:a03:d4::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 18/31] drm/amdgpu/gfx12: recalculate available compute rings
 to use
Date: Mon, 29 Apr 2024 10:33:26 -0400
Message-ID: <20240429143339.3450256-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 87530532-697e-42f8-ecc6-08dc685974b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Fh5gY2jWcJgIXyOYGUefxMLmrTZ3ieMn0+D0TeFi1mID1XWIk9lrNHV7+Gn?=
 =?us-ascii?Q?MUJofhiLJT2kHUXp0YMm2iDA14OE84y1g8kG6HcDr1UrH85NjBgCd9RRLM+/?=
 =?us-ascii?Q?iq0BUBjIqnOXXLMsBTFwBdhAjoFqFJyiMD59mE69xEHJgkUVvZ4ryHpnjG9i?=
 =?us-ascii?Q?nqsFGiQ/mXotsa5Dx7OyU4oWEmRk49kZfoYJFIgxU+gaxHVieZ7hCGV0IHN/?=
 =?us-ascii?Q?aXiKyuccJXmGU8oVKZ9b0kfKWnbHrxO5QU8AkP+9YL0pKG1CYsgIf0jO7G+3?=
 =?us-ascii?Q?AoEvv6M+wBrNnFFG57tqmod48x86dQ6S7UGj3mBhPvranwc7Zu2OlZAUnM61?=
 =?us-ascii?Q?9w9kk4rdSkYeJ9bFFVTkh9F4HjxMPsXfDvoeZC0uy2AWrxnA5sunIW6Z/Uss?=
 =?us-ascii?Q?ArJvJHqgCvFURN2y9SQmOcVKZ8m/iE1SDvzue5pCO5POH3LTYinwkk982oFK?=
 =?us-ascii?Q?31/ApSWDSh9+BLNnZpBPl+Tz6JkLb9X6+cuA4HaUoXm6iANOfip7EK511S2D?=
 =?us-ascii?Q?/Pkiquk7JsOhpEO5Jja1sTIt2uEMvoB2yvopJs2qmnL/zgTfQQMStsv5CO/k?=
 =?us-ascii?Q?zJIBs9yYGRZCqU/4970+Pve89CnH9oJu2zmWMJArVn+9LNwK8nRXQ6sUOBT3?=
 =?us-ascii?Q?zyAC+62DAraYYabABRlifkzBuBhugphy/rB74uTjQDfnY8Ugc9AC9gkpKTBU?=
 =?us-ascii?Q?5tSnkA2ANIcvwNksA/nv7S5ISOwbRmoBEpXMOPiFFxc6omzWtlr1HOzF/Iq3?=
 =?us-ascii?Q?ts+c2OFyVGztU+573aT1vh1LrY2UMByfUeZqP/sH/etEoRFqfV/iWOH7LM0G?=
 =?us-ascii?Q?7rCUkQQ35vS5GFgY++6S/LpugWTCEFC+6IwK8wBY7SSBfrZ9wdkm5KtL2B4Z?=
 =?us-ascii?Q?3IqQ1KlBJcvD/dgMBi5JRo5AgAwvBYge7NtjzCRZbzn6UgPUgrKgQLhceUFy?=
 =?us-ascii?Q?hYd4gBl8cmGFA4MeNrXRloI51ckQwIHZzdsB4id7DcD4ziFKGc+G0FsExiET?=
 =?us-ascii?Q?fDcfCW+89bezTLNCqoxHMqaM36xH3HP8000X1OGS5y0ctn3bs9Youd0dHOfE?=
 =?us-ascii?Q?Q1QLtTHNB0IxueNm9SOT8YzDw7dOY5W9B75HQ3a9yKR+IrQAuCocuIQYvCG1?=
 =?us-ascii?Q?8Xd9nfa1pLGCjaBtKUd/jZmw1048nIhmaV/3TOHutoqasP/C9qZINQGKTSze?=
 =?us-ascii?Q?p46bzGWuz/qgUkdngpiAjAt4ikghOouLZSqOhzOp4D3gnKyEvY3bNRYlq8/Z?=
 =?us-ascii?Q?RgX0iT44lrMxrs+RyGrm+kKySfH7ksvKFMdP7Gv1H21acuHGp6fammr1ry/g?=
 =?us-ascii?Q?OG2d5tVp9zCEnH3QqLm9rnRT5io0LLMkEITiIAGHA+v2bRO8gvfqox5mxbeE?=
 =?us-ascii?Q?x+oak2Byd/1+D7pN0piv2rW20nMq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:19.7950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87530532-697e-42f8-ecc6-08dc685974b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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

From: Jack Xiao <Jack.Xiao@amd.com>

Recalculate the number of compute rings to use based on
the gfx hardware configuration. As needed reserve half of
compute rings for mes, kgd can't use up all compute rings.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f3f8601d6e184..06244d97c2831 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1103,6 +1103,7 @@ static int gfx_v12_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 static int gfx_v12_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id = 0;
+	unsigned num_compute_rings;
 	int xcc_id = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -1126,6 +1127,12 @@ static int gfx_v12_0_sw_init(void *handle)
 		break;
 	}
 
+	/* recalculate compute rings to use based on hardware configuration */
+	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
+			     adev->gfx.mec.num_queue_per_pipe) / 2;
+	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
+					  num_compute_rings);
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
 			      GFX_11_0_0__SRCID__CP_EOP_INTERRUPT,
-- 
2.44.0

