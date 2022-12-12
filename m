Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0F2C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 17:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81FB410E22A;
	Mon, 12 Dec 2022 17:11:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D6A10E227
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 17:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwbIa0fHF9r6ZZg9zyZxnWvezoyXOfYaGMaL3HwCIjd81IUWEbgEjGDVsDE3vrcEpxTjPIRNyeGuxw0DEV6U8Ba/O3xe9drkLOBJ4gZ1FihW9J5btryA2kZWZPHXKyPir3cxhQ3g3m/V2KAy6o0BYJjXMKyUS56+Y4EM2kishMGWDai/yWg5lJm3XHGJQxfINGffIUp02LIYUJ1lOADtIAvv9QZWwc0BHvmeJdYi5Qtg7zwCsymxReLamGj4cenz46G0/c6Smf0wAtkpera9LfFwx5R2pmS3a5cdwHra/evmbs1TdC2/7i2DcknXOFkb5jfm0X2AEbiUD0qbQs8C3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFWvifVWj0OdIatK4gWo53EBa+fW+aEGR2zJ5NL2tFc=;
 b=MXggv1zwBW5c8HJqAWfvkE13oEqO7mJCtWG2OD0D8xutIZvl2cnjA2AAyt0E54KMIhw8jgXbtz3EvPHKXI6qanxN0KLsdYaHnItUyfqusB631hO4rJyRLbI5ootOzZuKGtdIEKMqUuZtPc5/8rX5mbZNgfUqKc5CSzeoEOTLZLfZkYCoDvDFWd33Njssv0upqfPJCQmj1nnPdAbHdJopjK2WOnf5zNKVvzYN0GR0f3KTbE6TOCb0KVaW4YdbzNYePNDUzB/3MzNIKKVlVXhJwnxuy+0K97CN0e9/V3CigZwlqUGTB349YswmI1mlExPFd7YTtjhy0aREIIaI+NDwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFWvifVWj0OdIatK4gWo53EBa+fW+aEGR2zJ5NL2tFc=;
 b=5EmIvdTHBAB4Jl8W3LSnk+GIyQtEsP+dXrNXvuq9tRLyw3sXSe+GdU5KAbMliilzKeBZOgRhlEY+FMMyp3UkeXQoxjNG4+JWDU0jdzTjTeVW8pa+FBPKLnm00/LQsY/w0eO7c3B8y8zphdyscS8sj4rkCVrSCZi9ykQT/lJQHJk=
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 17:11:30 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::fc) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 17:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 17:11:29 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 11:11:28 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Rework retry fault removal
Date: Mon, 12 Dec 2022 12:10:55 -0500
Message-ID: <20221212171055.999548-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221212171055.999548-1-mukul.joshi@amd.com>
References: <20221212171055.999548-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|BL1PR12MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ee23fd-8693-4b09-d8a8-08dadc63e930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvAk79M+rOzhOh+GCcFawVRorpyO7dypDqFq/wnOHG4AHKr4nJfzJmrrMfknhjR6hRurVik3pmocsp8mALI3IrE0DR59D/M+5iT0/sR89p92x8pGeu2kgvFKEkHp5qfTGpv48zz0Vx0IvEv6KRGZAuWbIINHiLVG57ytjRKu2kaW15mhxHsmx7u1DqRXvESNnkbIPWnVS+PUlJCRdk9VyKjTuB4tY5BcgUtwEsL+OCyCCCzQXMTQiBsKHrXykZYJqisvPjpcTpFl04N0BTj1bzRxtL8xM5m51VyxvnI1h8oWZ3H4zd4HVB6G9VexBzitXeRM3sPqP2Uh5Dg/HWywd2BOq9GBHM01+Lb44fPOk5Mw+9zHxeD3JmSikQGKyQwlJH4FMi1d3y6Tm30kjx3mgCbnoXFxltmDFYu4xht/FDESsQOxdZ2DCZYOlPEQ/tqXtCtC85vUQ0NZzuI6Dp1cW5ZGHiHL86zvXAi347DUoPfXYbJ468joakEshqO/ZtGdMy9GaFwmZDtGXONf7ukJobenOWXgJ/MMEqqoDCwXimYALaewHs+lWzEiPRdJsKwJCSVK/8UFHjpJo7QEdeTIR9h3ZFgByFzvIpsHwSA4crE5ARQmiMaJQqnGSwFOdI5xtQY5cSPsZ6Et7F5B5h7+6n4FFGKxnNU4nI6TyKBxkTbLQxdC3ySd4FzjE6bCpdAOc5QvovoHTA700hc7Pc7uO1I022fQyxbBRrEc8nmktIM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(44832011)(7696005)(478600001)(81166007)(356005)(82310400005)(47076005)(82740400003)(16526019)(2616005)(40460700003)(1076003)(186003)(4326008)(70586007)(70206006)(26005)(86362001)(8676002)(83380400001)(336012)(41300700001)(426003)(36756003)(5660300002)(8936002)(6666004)(40480700001)(6916009)(316002)(36860700001)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 17:11:29.7887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ee23fd-8693-4b09-d8a8-08dadc63e930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rework retry fault removal from the software filter by
storing an expired timestamp for a fault that is being removed.
When a new fault comes, and it matches an entry in the sw filter,
it will be added as a new fault only when its timestamp is greater
than the timestamp expiry of the fault in the sw filter.
This helps in avoiding stale faults being added back into the
filter and preventing legitimate faults from being handled.

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 36 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 02a4c93673ce..fb811bc7214c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -387,8 +387,21 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
 	while (fault->timestamp >= stamp) {
 		uint64_t tmp;
 
-		if (atomic64_read(&fault->key) == key)
-			return true;
+		if (atomic64_read(&fault->key) == key) {
+			/*
+			 * if we get a fault which is already present in
+			 * the fault_ring and the timestamp of
+			 * the fault is after the expired timestamp,
+			 * then this is a new fault that needs to be added
+			 * into the fault ring.
+			 */
+			if (fault->timestamp_expiry != 0 &&
+			    amdgpu_ih_ts_after(fault->timestamp_expiry,
+					       timestamp))
+				break;
+			else
+				return true;
+		}
 
 		tmp = fault->timestamp;
 		fault = &gmc->fault_ring[fault->next];
@@ -424,15 +437,32 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 {
 	struct amdgpu_gmc *gmc = &adev->gmc;
 	uint64_t key = amdgpu_gmc_fault_key(addr, pasid);
+	struct amdgpu_ih_ring *ih;
 	struct amdgpu_gmc_fault *fault;
+	uint32_t last_wptr;
+	uint64_t last_ts;
 	uint32_t hash;
 	uint64_t tmp;
 
+	ih = adev->irq.retry_cam_enabled ? &adev->irq.ih_soft : &adev->irq.ih1;
+	/* Get the WPTR of the last entry in IH ring */
+	last_wptr = amdgpu_ih_get_wptr(adev, ih);
+	/* Order wptr with ring data. */
+	rmb();
+	/* Get the timetamp of the last entry in IH ring */
+	last_ts = amdgpu_ih_decode_iv_ts(adev, ih, last_wptr, -1);
+
 	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
 	fault = &gmc->fault_ring[gmc->fault_hash[hash].idx];
 	do {
-		if (atomic64_cmpxchg(&fault->key, key, 0) == key)
+		if (atomic64_read(&fault->key) == key) {
+			/*
+			 * Update the timestamp when this fault
+			 * expired.
+			 */
+			fault->timestamp_expiry = last_ts;
 			break;
+		}
 
 		tmp = fault->timestamp;
 		fault = &gmc->fault_ring[fault->next];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 0305b660cd17..9441e530f1dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -70,6 +70,7 @@ struct amdgpu_gmc_fault {
 	uint64_t	timestamp:48;
 	uint64_t	next:AMDGPU_GMC_FAULT_RING_ORDER;
 	atomic64_t	key;
+	uint64_t	timestamp_expiry:48;
 };
 
 /*
-- 
2.35.1

