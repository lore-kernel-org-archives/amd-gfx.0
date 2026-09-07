Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3224C79F8C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 01:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32ADE10E0BA;
	Mon,  7 Sep 2026 01:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T82so//y";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0558510E0BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 01:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPIbNkCGfI19jAH89+xqFiTXGgyWYeMv7ZU4NlUxScdh0jcd3T4IY9aQSjmj5NzS/yfDisNENGfodQqk4g4smbiyuT8wr4X2viWg/+kn1qmFJ4pgjxZ4P4MPFcqM6uXzCX2d/A8VtkE871OVADt/quarxvj+RegrQe4jG7rcksOHaBA3w8nZ0auuiFQ2LnOd6zchhoST1MNPgcjJQG27Or4yP5UyD6oZJK1kUnThBzfyun/w/m+FAjlEANhPWG68mNT/4As0sHinE8BbDwoThajvn+/lr16tFI3li8Y6PDCAnwjc50LBTk753JKhmJF6EuKd2oGjErNW+0xtck9tEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Givvezic0qdydWQynUtrz78nQHo4p1azdg4WzP2SQF4=;
 b=ET4g3JaVzXLhlPqIbp2lxtGojWCAbwGOJTPUICnEylW4SfF+OKETnHY/7g8QcYIfsgxFIRQ/QUFtTmw4ivvvyBwm2zLkfDd6oHuX70Tecy6sGklP7d1WZpiS+CZCt9Q3my1kV8x+ujyTpBaefHbyU1eMio+mA5GsovMGKAv3PT+hYxCrZxBIbe3zaGNMwkRmZyqfdBvh9S4Qa59JxdYmmLhAeVYFgK4zvyg7qj2PaGx+8T75//yKt7TI5lLSi8AfYxOhv6wwL5YQHj374Nd+NP4BENqPziLVET8hKXB+P9EhWSYhjn8llh3CDA1WAGjh66+8FP7MzMWPe+LZrwhDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Givvezic0qdydWQynUtrz78nQHo4p1azdg4WzP2SQF4=;
 b=T82so//yN2allZEh6bHHqbbu4V7Pu7WC5eveSxJ0kg7Dlv8pm9ujUGP+iXJz0GEgD3uHn4Jq8MVUeoA15lQ2yGs6HpS8x5xGVz3Cs56mMvgia0Y0OZEnARkix5UnSkSs0guu7kYRoerhm2YDRwpXkSCSSCmY49CSAdXzeIsWwhM=
Received: from BLAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:32b::35)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Mon, 7 Sep
 2026 01:46:41 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::66) by BLAPR03CA0030.outlook.office365.com
 (2603:10b6:208:32b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 01:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 01:46:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:39 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 20:46:38 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 3/8] drm/amdgpu/gfx11: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 7 Sep 2026 09:45:30 +0800
Message-ID: <20260907014629.2186163-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
References: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c38f2d7-2162-47b7-dd91-08df0c81dcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wIc2v56w2quQNoauqoCkFHk1wyqyFftdwzv5CMFez3dNfyVhEkXacMI+RImlLXV4t0PG0sn5Ny77yeV3PX1BUDwhN8BUlj2L8nx1lLOzOElQjQwFA2ItR2314aKUWL7AJUwzAT59NGwu8uZKueK5AjKc3klxmvmVJSULADr/hf0C/yXlAvlVfk/IURUSRkpFX5kRyKuB6Kuje6sScyl0ulDSbcVSPbAwyZdnrCTNh9q5uN/dTL61BB2CljKZjehxtBhql7kKD0EOINPpkFPsq0T44eiYlBQVjgmm/Gpid6+QN2O7PQQ5jvUzkBw6NiO4ai93SAwDM/8uOk+F4Wtf9giiG/f5Eu1Ltaqym0n0L6GD5rrAs/Q7JUNlqT7jQRtC57mc8kTUFwz7BhJOOKv9WWRSqI/BJ4tt8D7+xcZz7pBHq3SiJTXxJlvsf4fMFocNuMCD10PQ6N3tQYnxYH9ytMX8p/2ZmbTgiQhk5SG4IgZnWPhbqED5NbajkMBOD5HquRNFZoi2ukqP7Xnj3SPeA3Cbjj/pbbYNlTXkwxqrnwzPc+k4JzR5Z52Pz/QqVoFF0jxSdP6jAbL0LprAE87cBU+YduiwX78yUJxSYFg7ZYUawwokuyRjvJTxezOaYdCj2hP+g6VjWpRtdn0Qy/f8K0Ez1/w0urAU8HDmGlOgdYXcOV1C91mhYd3jh8AI9kJ53ocTarnDL6G1Hynz+fwcAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AiLUeDNqGFPRw1lNLwotYhSjaes4vfk4DxDWnhdVSOs5HyFCD8ZEq32LsNMWL7crsSmLZr8mVbpBWajjHLNfJrcXMKspGdiWapS1BrjK+q2hdZ9LC16mkE3E1Ibs/HjDgSymWcz1cFs0DhY8hZNz5+QkS4gfhYfQgVoD+1pTetoRSce7LmzTuqfVuTov0y9cfcqr9mrTdTGCOc4TVWFx9ZRMgkud+XYFJN80VHIY8ujb2okxw++n99pPVuOceTFxEXdBxuPO89xC6rtsxMz2V3GPOGz1VfIp5VHPAX4xOX6m6XKUwzcWXJH4Pre52dfbFokY/MpO+pbtt11hV6vXboOYK5SxF6FxOBbqaB4fHQNBcSXHAjd/VYTMQtUcEiI6tdyBKJ9srXbKNQgNnFSGFz99U3VhAZNatkrYy1D45LyUSFwOgmYhuhlGVipnh/Oj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:46:40.6515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c38f2d7-2162-47b7-dd91-08df0c81dcf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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

On a queue MODIFY (prop->modify) the gfx11 GFX and compute init_mqd keep
the ring rptr/wptr that firmware context-saved into the MQD, so a
re-enabled queue resumes at the first un-consumed packet.

v2: rebuild the HQD via init_mqd and save/restore the rptr, matching the
    SDMA update_mqd style, instead of patching individual MQD fields in
    place. Keeps all update_mqd callbacks consistent.
v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate gfx11 update_mqd callback, per review.
v4: also keep the context-saved wptr instead of programming a user_wptr,
    per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 27 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a447562977ab..301f7ab30bdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4167,9 +4167,11 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	uint32_t tmp;
 	uint32_t rb_bufsz;
 
-	/* set up gfx hqd wptr */
-	mqd->cp_gfx_hqd_wptr = 0;
-	mqd->cp_gfx_hqd_wptr_hi = 0;
+	/* MODIFY keeps the firmware-saved wptr; otherwise start at 0 */
+	if (!prop->modify) {
+		mqd->cp_gfx_hqd_wptr = 0;
+		mqd->cp_gfx_hqd_wptr_hi = 0;
+	}
 
 	/* set the pointer to the MQD */
 	mqd->cp_mqd_base_addr = prop->mqd_gpu_addr & 0xfffffffc;
@@ -4237,8 +4239,9 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 				    DOORBELL_EN, 0);
 	mqd->cp_rb_doorbell_control = tmp;
 
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
+	/* MODIFY keeps the firmware-saved rptr; otherwise reset it */
+	if (!prop->modify)
+		mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -4379,9 +4382,12 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	/* disable the queue if it's active */
 	mqd->cp_hqd_dequeue_request = 0;
-	mqd->cp_hqd_pq_rptr = 0;
-	mqd->cp_hqd_pq_wptr_lo = 0;
-	mqd->cp_hqd_pq_wptr_hi = 0;
+	/* MODIFY keeps the firmware-saved rptr/wptr; otherwise start at 0 */
+	if (!prop->modify) {
+		mqd->cp_hqd_pq_rptr = 0;
+		mqd->cp_hqd_pq_wptr_lo = 0;
+		mqd->cp_hqd_pq_wptr_hi = 0;
+	}
 
 	/* set the pointer to the MQD */
 	mqd->cp_mqd_base_addr_lo = prop->mqd_gpu_addr & 0xfffffffc;
@@ -4442,8 +4448,9 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
+	/* MODIFY keeps the firmware-saved rptr; otherwise reset it */
+	if (!prop->modify)
+		mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
-- 
2.49.0

