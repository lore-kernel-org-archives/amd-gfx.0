Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A39CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583F7112DBA;
	Mon,  1 Jun 2026 05:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lxKhRE84";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F006112DBA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnHMFke12qrOF9MxER4aO0MVCGI6ay6z0DVKZB/lcq8o19JqXPNU1dx1sy41wQdu+8LKCx9T4yPhZLogJ6/dcv7PK3zD7pL5QsMXiq6el/wPxaKMI51FvnaewizYkDvedwEgBtVKF0us0Mil7/+HX8H4wXRjyBJGXPZIu8SK7E/bYntf/mqbnqP/++0Y8g3/9S1EI6pc+dtiA4d92GJ7Fy9+JdpoA01HUrGp++fcBNaSyVhwpdDvoBt+mlA4cNZrdbn2kAyhCpEqHD4+cMlpzLGmgC7MCHXZM+ox2GFcbl5nGx1g03R14EqygoBv2h2fwSf8TjPRV7CiqR9O62X4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TxmdgOR9Q/0YWMx79JgG5QKd+gEUpy9zG1xoX2tYJE=;
 b=MHWaav9o94imJt/nfjxlzwaW64vdzmVvc6w2A7i+W580ORvJXalCgeJ0U/NhICRitbfuHXWRNdALErdbs1h704R3bx8NX0VODCZCUUFdhIpeWFDr2rXru8xNgXx7tXvuzIpeDEbZcXZw76pKX0vjPNbAO48Bcl1fGEB1mUcycw+Vd9PWnkMmlhv5eWRMNjTcSdcP4MzqwvQ+t1ik23rlCZxgkyj5w4LGugezuiEq5TDCkcqrKrzrfDA4k+u8pF1mRoUIu97+9v7Ged35/4sIyhSDNqWXTg4fCdZ65bt3mVdWKc5MwkHLzu2DNfL2SoDkDYpe0oDu/lfnGb6E6d8qtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TxmdgOR9Q/0YWMx79JgG5QKd+gEUpy9zG1xoX2tYJE=;
 b=lxKhRE84/aTtVb+MzkduXim/ENioVXqmPQ2z5IO8eNWX3A2UIIUZFIr0A90jqwbkkBPyHUGNB/nezevqaXuet7dEaOIBa2r9e9gyHppmy5RRZ9X83j2jf7z9CxKuMs8iVBYMZlNIIEOjld3Fs857TNxS+W+mncdLORwSJTa6niY=
Received: from DS1P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::15) by
 MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 05:51:16 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::aa) by DS1P222CA0009.outlook.office365.com
 (2603:10b6:8:454::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 05:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:51:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 31 May
 2026 22:51:15 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:51:08 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 06/42] drm/amdgpu/vcn: handle pipe reset more gracefully
Date: Mon, 1 Jun 2026 13:48:52 +0800
Message-ID: <20260601055034.3700921-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc3d1cc-c48c-414a-86e7-08debfa1cb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7Ahw19hoY2chRkozu1SMBs/xJTOSy1z+j04K3NG6xedqVdfA43kP5RchVX4zDY1/U6KQJ1Pa4oxU9f6GVkS1dTfZM6q7nW+3Rxi1abZKOJKw4oVx7+nEKooIY6+V9qyOQyII02MMBwosdYuGwaEqHBUSwSnZlK4bfyVHApLFwNP2vciASLkbOoUIuIehzuJOWts8oyYiQ8WTv8EvCxO/nuXEtPboFo+xOShkv8mhDZdYL+LHrtFpcF+YouXw5+raGrFfdAIP+UmNNhxW1bWKG7PoJrThg2MOeiEPx33MD0X4OjKms3pIwpAu2yq9SXH+TTb8oX75hw9jlpG3oeYTo7yTjAa6MfENGn+7+EsM4es0KgaF5/EwM8ioGrBUB41pnSAdPyv9ZFbawN7AIKbw2KjGoZ3kX41UxTcrsZaL9PVphltbMUqurUPVxyIJOMdXxAD43NsvmTGQOgy5WHdX4h3fLJRDhPD11ysehhG1gwidV64ShtNQdfvEfwCAMfyYZPyIL9w9VtzdRvHFibJyIORhMw0ujHEJbJmxdRvyv4Gk9dQPHPXw+X4RmsjWguv906KRsr+rx5MPKp4JA8e5fqFTbjLsbeQNHmb20K11vTi9pMkp/KilLsrzjBJd2CatGcOjFi3G7PyGFOjh5nyDPxZUiQfY5g8tio+Bit/2egDUEajief8PRO8IvCtiEK8NiGPruyYj3kedOPrihRLKZM9MdX5pNeamXI2bl8j1OJQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K/6a2J02gBMMG3YxX5n2aLdTmR6zMqZwOn7gIV7hmrd+lk4uVNgXdBMeS7qkzPz5BlJhldcwe2sm3eXTkZ/06ou2CXUmlhuIh3mZmd1yFXaoatgnEKUvLX+F0vyafu26D3NMDcr2Bjoq5sLhEOUlDGOw54x9xs8JpbQUWpjcGhux9XR7Fl4i8K+3zneBD3Lg/iFhfKMELTHUdvkBOGbya+i/0KUwxuVzENUn7ukwnbFcL+8YSqtjS008fRXRdkEEe1sQN2spzol88VomigvL1KlDRGlbmnJVpfQhqNzdhK/7Zknr2PD6o/0DcK99e9Ds/Hrp4mB0j8Ha6pOLdfZJFEk7hNTYqP2MamrUPvznOh2/av6oVK8bocW4+o8tjQIxjZpksP6U2nQwsYkkwpC3i8i9SK0sjKwS7h2qxaSJ6UeSEvOSYXXUshyhiShtK4RF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:51:15.8079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc3d1cc-c48c-414a-86e7-08debfa1cb8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
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

From: Alex Deucher <alexander.deucher@amd.com>

Save any unprocessed work in the queues using the
new ring helper.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 64 +++++++++++++++----------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 616967519869..e4d435d4a629 100644
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
2.49.0

