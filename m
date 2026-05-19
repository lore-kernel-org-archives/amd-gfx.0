Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34218CD4F5E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB39510EDFB;
	Tue, 19 May 2026 18:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RFCCh7uG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDD410EDAA
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IURmiE02kWhoTq/r/abAXl17MIzhJX6wM711horEMVfvWmDunWU3F9JXhFnBpnwnEd5kgF8e5jhSIHWtUUQASFwd3Z09vfqa0CSWL0sOKKWY1tHyll4+TzBYCCz0/FX1jIJX60jPOyRYNJRUgWigiKwM2a9viKjvAAeBTwIpGbGrpSLlgv7V32RbfAjlcxyLTAbAWjIlgF3gsvWUbmVtx+seq18CoXwCM/bQCJPB6anoIzmN+gLGYpVAA19qibmCWpN47gjbAOkFZdSJ4VOBAw9semTXVTtjBlEcXYWkgXePrzP268rl2gQ76qsSD8XofGO0ZylomVSdxIPMLzL0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i/BYWC2YPOt0i+JkNiRZFiNlu05YFYjRA+eZdOMmkw=;
 b=jAXI5yveplwiGZGY44vMOt3o5suQ5nSqM4X72iz5v5JSb0WUQPzOUGdPJQOrhrdp/IbKD2cqtadw6XPT1ygqcZlLr1arIX1bUQi/4/8WJLfaGAPFLPZkJey8I6eqJ8nKx4sMCEBNbyJX/fhlOpZBUj3bLdgYfvCZZHLgccY7Q8liGlZdfA+2ka874v04jJryVJipprkzM0n4OzdW74rusr1I5fWeVFzPo+rA3LrGAdiJb/sGqV2T+2H815lo0aYiETzJG7fhf6rnQdOMRamem4uq5Qr8Dk2+Fyem8zC9ijSMQYm1Z5xLwrCbNyUDnRJA0D1QCgyyTTSeD3G6urr3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i/BYWC2YPOt0i+JkNiRZFiNlu05YFYjRA+eZdOMmkw=;
 b=RFCCh7uGUZPsDhLginKLz9LeTnBQxxcEzt8LMDTzSDDj9c2eONjvVYMC/IA21uR7T5sureurnhk8+mqwpOopG8ahc/6+it2qCMX+7X8OgXnBmSjK2J8GCJAmHHWE+44U4jNLySn6F9w3+lZipQU1yeMVrOadaMJVARpWGFfghl4=
Received: from SA0PR11CA0137.namprd11.prod.outlook.com (2603:10b6:806:131::22)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 18:30:05 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::8) by SA0PR11CA0137.outlook.office365.com
 (2603:10b6:806:131::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:30:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 19 May
 2026 13:30:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 May
 2026 13:30:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:30:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/vcn: handle pipe reset more gracefully
Date: Tue, 19 May 2026 14:29:52 -0400
Message-ID: <20260519182953.21967-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519182953.21967-1-alexander.deucher@amd.com>
References: <20260519182953.21967-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9616ac-f89f-437b-734e-08deb5d4a5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: luTmYZNhqxBiHe4DYcM/d9B8LD9+m7fcZyrUVg6f+LCKaXIKAHZ9BJtOCJBj1s4mCYkCJVsLgBAZ3OIGUCTqD3zWGki2/j7BYvDNT0zCRmYYTAVnKynyQ48HtqnsUAGSJOmGGDGw3m33Uiy8/o81HOgqQc3RRMPyMGjFvkinjvO7B6kdnGI/1JzOjEtoasucpbr9FDloxZUwClX0HYg9B+yYDCW+mwH9DUS8LpOHB8CFHRgaBKE/I3um1TzYkzNfF9w5O5wc+uUWE/KpttrvWcEp+Iv8tscsNE25yyBwjF7+fNSHiC7MiXMlfrdhRdVFpOko3dxIC9wwNPMnI0qGg88b+PwjvCfqcViA7MOv1KLjfCQlgJDTnRaA67x8fg6NPEixb1RGKLvQi6LV6oGte+VNk7WP8dDSRVQ0ZJs9IAu1T0BW0mzUm0ID/AK2tpGoLeCM0Eq49QfOxd3hE4+jyEH1ry/q1vJn9F680dPwC56b6ROdQqf9T9gAH0nEJTlXi4ik8mxV74PYppUNBRCSs4h7UaHkxoOH+6RdusHAZnpj1Cr7pBMlWIHgrcHwMKbKG8vGNW0vfxEQRPwEIzeUALhLiOnvFtzdu3Z2TxEciD/V9WGnVPimlibinXcmDj/rG3b3am9Y3fdU3cbEOSWWsJ0rzGehxm/nJ4xUhg2GYxyImywtykbzuIwUKrY9HNSG4C6OfIFFgXRgKoug/ZfBoqCCTmKrD571CjJMO2uODV0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bxugTtsiV+ZZIJEWlK0hAZL8gmNg1wl2J3YLoFmS3cOrcWbG+HiCJ797mL0i0YJznvNaSALGO/XzYnMsJnL+UxUlD+LtCqcv0ookouQnsT7ZO+JjjjlBrii0ljoa9FJB9om7PxYb7jiK5MWeulwz6ieafSWzzyZFBUoALgotQlvv9FEkKjok+BoeBkyuYWXJz8QJEM6S/iila/31x1YQwLYUVMNSVoD3tvyq3DkliKHOD2IFO2loYnybhM/bh9qJkz8MPGC5PGXEsC3bPGlSDr6btoFziSMrp0BFTAYygo1etBUJZHDE2G7h5TqbYsxzENWBEl6UGxz0z0deBnSOUL6h4L8xaEomCUX7kjbVuc1BqXWNGj7o2wZmo6VGxzBIpfVM7P+EK1tzWby9nOm47TE7MEb8uKQFxvWjg9moI+luf50QC779xGpJBxukC1bI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:30:05.4152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9616ac-f89f-437b-734e-08deb5d4a5ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715
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

Save any unprocessed work in the queues using the
new ring helper.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 64 +++++++++++++++----------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 616967519869e..e4d435d4a629d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1485,6 +1485,37 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return ret;
 }
 
+static struct amdgpu_fence *
+amdgpu_vcn_ring_reset_begin_helper(struct amdgpu_ring *ring,
+				   struct amdgpu_ring *guilty_ring,
+				   struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_fence *fence;
+
+	drm_sched_wqueue_stop(&ring->sched);
+	if (ring == guilty_ring)
+		fence = timedout_fence;
+	else
+		fence = amdgpu_ring_find_guilty_fence(ring);
+	amdgpu_ring_reset_helper_begin(ring, fence);
+
+	return fence;
+}
+
+static int
+amdgpu_vcn_ring_reset_end_helper(struct amdgpu_ring *ring,
+				 struct amdgpu_fence *fence)
+{
+	int r;
+
+	r = amdgpu_ring_reset_helper_end(ring, fence);
+	if (r)
+		return r;
+
+	drm_sched_wqueue_start(&ring->sched);
+	return 0;
+}
+
 /**
  * amdgpu_vcn_ring_reset - Reset a VCN ring
  * @ring: ring to reset
@@ -1502,48 +1533,33 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	struct amdgpu_fence *dec_fence;
+	struct amdgpu_fence *enc_fence[AMDGPU_VCN_MAX_ENC_RINGS];
 	int r, i;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		return -EINVAL;
 
 	mutex_lock(&vinst->engine_reset_mutex);
-	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
-	 * This ensures that no new tasks are submitted to the queues while
-	 * the reset is in progress.
-	 */
-	drm_sched_wqueue_stop(&vinst->ring_dec.sched);
+	dec_fence = amdgpu_vcn_ring_reset_begin_helper(&vinst->ring_dec, ring,
+						       timedout_fence);
 	for (i = 0; i < vinst->num_enc_rings; i++)
-		drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
+		enc_fence[i] = amdgpu_vcn_ring_reset_begin_helper(&vinst->ring_enc[i], ring,
+								  timedout_fence);
 
 	/* Perform the VCN reset for the specified instance */
 	r = vinst->reset(vinst);
 	if (r)
 		goto unlock;
-	r = amdgpu_ring_test_ring(&vinst->ring_dec);
+
+	r = amdgpu_vcn_ring_reset_end_helper(&vinst->ring_dec, dec_fence);
 	if (r)
 		goto unlock;
 	for (i = 0; i < vinst->num_enc_rings; i++) {
-		r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
+		r = amdgpu_vcn_ring_reset_end_helper(&vinst->ring_enc[i], enc_fence[i]);
 		if (r)
 			goto unlock;
 	}
-	amdgpu_fence_driver_force_completion(&vinst->ring_dec,
-					     (&vinst->ring_dec == ring) ?
-					     &timedout_fence->base : NULL);
-	for (i = 0; i < vinst->num_enc_rings; i++)
-		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i],
-						     (&vinst->ring_enc[i] == ring) ?
-						     &timedout_fence->base : NULL);
-
-	/* Restart the scheduler's work queue for the dec and enc rings
-	 * if they were stopped by this function. This allows new tasks
-	 * to be submitted to the queues after the reset is complete.
-	 */
-	drm_sched_wqueue_start(&vinst->ring_dec.sched);
-	for (i = 0; i < vinst->num_enc_rings; i++)
-		drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
-
 unlock:
 	mutex_unlock(&vinst->engine_reset_mutex);
 
-- 
2.54.0

