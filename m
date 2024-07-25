Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BBBC49EA1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73EE10E874;
	Thu, 25 Jul 2024 15:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYCDWhCI";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3BA10E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEXDbDlPB7pBL29qtFWQhA+2GonKYHvGMjyzl8c5PND2xby036NNVIhp91G9s58ps63iNqh5WkiV5gdUfCQEwnpeFVgi1MbBUNOnWIByCEPLm6yk1K4q9Co6TceF4IeLW99U6WtJ7qM5FRuuJAxRbq59KgbqgxCPekZgL3NM7+3QhgMfZKtpYKdUODiFusbsZznhPVwNS3l1dTsSQiPsMw2lpSo1hsAXTtuALkTvy5vBLpqqY4JWaUbFuIbg8Tor9q7XgLUdBtueHwf6zUaqNzcERbLyH4kkPAJYD63V2pr88QTUzlAWnXgAO9TrfY3xnNzZTzfcwIMdUwdsCBPP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1vmSHuxbMnwE5C7RoWufniJcSPxUyvpC2Po3vMjOfY=;
 b=YWsEvaM9i93Y6ad/9wRjW3jNXdzIJhj3MCwNox+eBKnfGXs/QpYAK4gz2PJOPtZu2IIyEbMtXSDenGbC50KKkhQfS4f5xkLRGchFvxrvgKxocZefJEnui30zJZmWL6l954O57flcMThaGKOnQsLnJfY09AyQ2b1iO1R8aVonxHzt6gP7Iwf/QM8Gp3k7E1r20xAWsrl45IuOIR7ZGuiBaL1D0tAiUXpGf5U6GKJDkfke/XTJ6D6pLZgUW+Tabd7L+OHvG2V6oWEOZFtho+2oeI/2G7ARfSPDI2E5qdRWXHjo/gWQIA+otF7tET4meTnLTW3hqpFdjul1vr1uuM+LIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1vmSHuxbMnwE5C7RoWufniJcSPxUyvpC2Po3vMjOfY=;
 b=ZYCDWhCIXKjm1fNOIVys4mOnZCzw13gLGGLtMK2tlSISoHDsvnUSkui+T7dv5/tjEp+mA+7zmHp8rCmLLcvt4cMdgx/Omv7ymoWxHNhsZHBq1FGJxM/r1YnoTEVkbF4fL2wgN7u+lnBinRnxDU7OLdAdZENNnZ53qj4Mc76qYs0=
Received: from PH7P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::7)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:01:36 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::fc) by PH7P220CA0034.outlook.office365.com
 (2603:10b6:510:32b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 44/53] drm/amdgpu/gfx9: use proper rlc safe mode helpers
Date: Thu, 25 Jul 2024 11:00:46 -0400
Message-ID: <20240725150055.1991893-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a499442-f172-4a9c-a64d-08dcacbaada5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UDLIda3271Ly7xvqXiCw/rcvFcE3qE4Xhbj2LkYVkSN7wJHsDHxfskIAC1bc?=
 =?us-ascii?Q?KJgRY4/pC/5tU1ui9p1A3+YOXBSJnRLCcYO0S6jkhQwNmH87G09SBAN9gAvH?=
 =?us-ascii?Q?whatYub6+LHh4LEpUzr3vDCrL1ewo1dO1DETbDMjc21SOqvwFimACfUez87J?=
 =?us-ascii?Q?Heh9bQdA0VZfxm1RwBlvJsRaRl3KtNHePElftKQ5toC7YJ7L2d/nFoNwS1XJ?=
 =?us-ascii?Q?faJ82VEnxxmybjLBAKJWAejjECrylfQXC7X2w8lejsjTSYZFFVc36Y+eIxHK?=
 =?us-ascii?Q?Uc0+nlhWfGk3wvTgDNSA8nXLWDEc07u8Hk8XgDuOfFC1tT3VsItcqDEshdTc?=
 =?us-ascii?Q?aCW0l0IKgtMfibKG/z+u+pZpHdv9OwLFXk11LqlF4ejLbcL0WE48/PXZvf2T?=
 =?us-ascii?Q?EZPLW38bOELL5lmLclVA28t2Cdy3Ql6Eb10rdQjBY/Uxt0ZXSmMH3Vmnu52Z?=
 =?us-ascii?Q?Ebb1Fa2vBB4wE1EgJtE46CYQlngOhBZk8NQ35nsbwgIIWACJJ6dV707OfOw+?=
 =?us-ascii?Q?98Jw/4e33ONp5LcGWI8GY5mOVc4HRLshtBI/kDBNyRAGtZAE1mh9N+/ZjP58?=
 =?us-ascii?Q?+vi/dIuz5uMe99BWVIiu2G9qXxZI0GA6QLdaIvms6MneuaBVM+Hf2B7dy+oa?=
 =?us-ascii?Q?XlWoo8rlr5paLX4QzNdOroAfyd2ESGqCYJ6ITK7Yaq9MszCN/njilgOENaZo?=
 =?us-ascii?Q?HEZF2dEPtr7ZPfelhkVRJaXqPnBn2DSqWCSRGvW+gmB/6GV13YGqJ4wLWBth?=
 =?us-ascii?Q?nXeMcLGNC0uwofF3iIaVzvBgZXkXBOTwOqe5GtWn7seAEt9BYvKD2ySpf00r?=
 =?us-ascii?Q?mFvS9OefncT7vv62+/qbdN/YH/hiSAM/fzZurJIusmunqA9BKAfycTf4U1Y5?=
 =?us-ascii?Q?8+ENDjP4qdK/TOaA7yZzExIFFdi2Kaj6PlaogOZlv8dokY4udg7ntwcBd8Yw?=
 =?us-ascii?Q?kYEsnb15ot+8i1pn1S8vNe6laFnC0ZVPqgQia6Uz/NQ3uGxDTRWHY5Q++M6X?=
 =?us-ascii?Q?Lpl92vRmccYRmVYALmUs8Hj048i2GQI+ieotF/nlua4SnKc24G8J56bDohdZ?=
 =?us-ascii?Q?ECaIQUn4cSfiTWHw0v1wPbamgTPkZY4f8T3DN89j7L1EmWfBK+0AS2H+kZL1?=
 =?us-ascii?Q?NhQ67iG9kG0KlwQqYavU1Wmm5JJcL+cGNUSVSeQ2pkxPOSU0Hok+yl2g/uWr?=
 =?us-ascii?Q?G4mmTxetMvR+c/etvbj5FfDzUEbQgMdcTxdZ3dFxjZSmgr3XSgzNOlZIMo+S?=
 =?us-ascii?Q?m3QRmprEw978OIS43q4i6IroHcwiaCY/+gjyX8MqCHyBg2RgSQxdmTemmUj/?=
 =?us-ascii?Q?LBCseP7IjlNfR01gyESrj22nWWsXPNBDbyv4VF5poLJoxtvMvGsooWPdUGz3?=
 =?us-ascii?Q?h+AKbjAMJJt7qVLw9IEUwX1nFRpsT23k8eHizlZ32f8kVFixyajNAjbYmx1X?=
 =?us-ascii?Q?fQD10YMixl1/qCHtFlK57/P8R4cyw4ZO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:35.5726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a499442-f172-4a9c-a64d-08dcacbaada5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
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

Rather than open coding it for the queue reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 82b38432071e..77e64987bb03 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1015,7 +1015,7 @@ static void gfx_v9_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t q
 	unsigned i;
 
 	/* enter save mode */
-	gfx_v9_0_set_safe_mode(adev, xcc_id);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
 	mutex_lock(&adev->srbm_mutex);
 	soc15_grbm_select(adev, me_id, pipe_id, queue_id, 0, 0);
 
@@ -1037,7 +1037,7 @@ static void gfx_v9_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t q
 	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	/* exit safe mode */
-	gfx_v9_0_unset_safe_mode(adev, xcc_id);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 }
 
 static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
@@ -7216,7 +7216,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	/* make sure dequeue is complete*/
-	gfx_v9_0_set_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -7228,7 +7228,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		r = -ETIMEDOUT;
 	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-	gfx_v9_0_unset_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	if (r) {
 		dev_err(adev->dev, "fail to wait on hqd deactive\n");
 		return r;
-- 
2.45.2

