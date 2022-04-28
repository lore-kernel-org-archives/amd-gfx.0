Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2941C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 22:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C72510E650;
	Thu, 28 Apr 2022 22:12:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 170AD10E21F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 22:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaRPueCr3IaUXLkzonmhHzgKBaR0rvjFGfAyZHHOzC8jlZspvshRg0i8pm5w2FUmyQnmGP397F3Y7n97EybICIyDTb76ASVvN7anoi6KEJ6gfP/FCn7gIX46EXoIxkM6OPYK0D+zDpeLOdgJSVv6GN5zlc9zX4ygLWhi3W9dxs0+cg/Yq64osKEGtqaCSMGxXqwlJNvgPK2Vt/MT9JozvXzKhYWzz4vq4GTysYXi8HeBogl2MZ6snDguqpa4m7BdlwiEc4wX59sLwQlnWga8bNurasUPgKlRXNcEYlZlYfbRbFOV7SM2Ewe4hYWkvazqYkM9mu4oYu8gy6RNS9mHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn1J2oETOeLPZ3puENG1Ju4GLmTXgFnGeoZF0Dikso8=;
 b=cNkEgCO2BFwue3J4/ma0zUbiOMdQmnPYikTKEbWhcVf4wp/HgDdxPL0sibNwINcfNKZmbJD2mkHRpiwvVhlkdrG7FzPvKb5ub6QdoehKr6M1IpTTlGDP+xoiS/7lWwgFEA6r5bofI2TqIjX7bwirdVKQyVyXIWTARST4+LEaNQ5u8YpejXiuATrpVnW/kyaL691zkxEh8jd/mLYTfRYqWb6+rKR8B+bchMeRJhw00QBGsot3FrtOMrxCc4JmC6jPFWXQRuQX+97VhtWwVtQ1ehvzDjMPKiOjUfiJ6ZtBdznKc7/XKxsOZu1DVoNxI52vKgtWVkbIKYWXWusVavbPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn1J2oETOeLPZ3puENG1Ju4GLmTXgFnGeoZF0Dikso8=;
 b=ev2AXPbgn3Bem5KBbQsEY6+eUbdYFRlk0HCZNs/fedwQXhUxnh7yeDqADlvBPK2s/b6DUZ1lLukyo6iv23if4Upby/MgQQwIWK40Eg+viDZZV3vleF3WKQOBQnuBAscjeQzy9ln6sdwN45QKwRU0RKYI/TTS4/Bm+bLWBbHNArM=
Received: from DS7PR03CA0255.namprd03.prod.outlook.com (2603:10b6:5:3b3::20)
 by BYAPR12MB2821.namprd12.prod.outlook.com (2603:10b6:a03:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 22:12:45 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::10) by DS7PR03CA0255.outlook.office365.com
 (2603:10b6:5:3b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 28 Apr 2022 22:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 22:12:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 17:12:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu/psp: move shared buffer frees into single
 function
Date: Thu, 28 Apr 2022 18:12:30 -0400
Message-ID: <20220428221231.1030104-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428221231.1030104-1-alexander.deucher@amd.com>
References: <20220428221231.1030104-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 027d2790-f053-4b82-555d-08da296438c2
X-MS-TrafficTypeDiagnostic: BYAPR12MB2821:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28210D55FF4A59BB8EDF265DF7FD9@BYAPR12MB2821.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pef0V1s6p8P+m5xsiQbzuNLqCu0TaVacsJsgol5QsijywYywnbpxDT0JUtLB8vvz/0srG78w7UEiNc8QyhqZF+w2vuF7Ro1PW3Idr1LtKGNbm7+UtkLIYru88xvRu55hRppp63G9YE5j2D57wqkNV138tXDcItuTDnh0uijCcHUT214NywNu/OvMl/c42+aT2c+fWlY+Cj3Gu810jLum5BIGvYI7nE+Y+ZLx5BhQFiomuJ/kw4CZbJlnrUgsQriNjQ6wK+Go7TTROj/Q1T+NCtQuTrwrPFg5WsGZgQIO1PAR63Mw09t4jFns4z/RIZ71iCxma9jjW49MKOeNmT0MQoriH7jjIukP6TUthwvSmfsJcE4d3tr1OAQg+dgUOBKqyWgEJCTnnC856rIOLlAEZHcgyQTpozS7Gvh7kcY+sKVrr4Dua3TtAzGfPQuf+i3c0ACyT+fqf3g7ITywM7KGqb/tWjMqgsNDRMMC4wiq4BgOLajyFDRlwwoP/ZLk43APMPSfdlyPcNYcuJHNDnBtgEII/So5RStNEAw9gzr0N7RTQLjpxi7igI3R1jIaED5Pg4o26fwsUNRQdvMHxWzhRfC0VA+p9CXY+TgA6HG3JIUrPJ790osHqlP41IgUo1U6dfEI1zwuYEQvatO8FAzrB7eUJ2MyidORB74j1yQ6xIvgC1A/xZO6dfzEWfBrlewRycZLTnKE05LoQcKpRwLBtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(82310400005)(26005)(2616005)(1076003)(6666004)(6916009)(508600001)(426003)(186003)(40460700003)(356005)(81166007)(83380400001)(336012)(316002)(16526019)(36756003)(47076005)(86362001)(36860700001)(8936002)(5660300002)(2906002)(70586007)(70206006)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 22:12:45.0981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027d2790-f053-4b82-555d-08da296438c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2821
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So we can properly clean up if any of the TAs or TMR fails
to properly initialize or terminate.  This avoids any
memory leaks in the error case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 114 ++++++++++++------------
 1 file changed, 55 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1ef2aba2ac3f..b1b6f5dd35dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -153,6 +153,36 @@ static int psp_early_init(void *handle)
 	return 0;
 }
 
+static void psp_free_shared_bufs(struct psp_context *psp)
+{
+	void *tmr_buf;
+	void **pptr;
+
+	/* free TMR memory buffer */
+	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+
+	/* free xgmi shared memory */
+	psp_ta_free_shared_buf(&psp->xgmi_context.context.mem_context);
+
+	/* free ras shared memory */
+	psp_ta_free_shared_buf(&psp->ras_context.context.mem_context);
+
+	/* free hdcp shared memory */
+	psp_ta_free_shared_buf(&psp->hdcp_context.context.mem_context);
+
+	/* free dtm shared memory */
+	psp_ta_free_shared_buf(&psp->dtm_context.context.mem_context);
+
+	/* free rap shared memory */
+	psp_ta_free_shared_buf(&psp->rap_context.context.mem_context);
+
+	/* free securedisplay shared memory */
+	psp_ta_free_shared_buf(&psp->securedisplay_context.context.mem_context);
+
+
+}
+
 static void psp_memory_training_fini(struct psp_context *psp)
 {
 	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
@@ -747,17 +777,7 @@ static int psp_tmr_unload(struct psp_context *psp)
 
 static int psp_tmr_terminate(struct psp_context *psp)
 {
-	int ret;
-	void *tmr_buf;
-	void **pptr;
-
-	ret = psp_tmr_unload(psp);
-
-	/* free TMR memory buffer */
-	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
-
-	return ret;
+	return psp_tmr_unload(psp);
 }
 
 int psp_get_fw_attestation_records_addr(struct psp_context *psp,
@@ -1102,9 +1122,6 @@ int psp_xgmi_terminate(struct psp_context *psp)
 
 	psp->xgmi_context.context.initialized = false;
 
-	/* free xgmi shared memory */
-	psp_ta_free_shared_buf(&psp->xgmi_context.context.mem_context);
-
 	return ret;
 }
 
@@ -1465,9 +1482,6 @@ int psp_ras_terminate(struct psp_context *psp)
 
 	psp->ras_context.context.initialized = false;
 
-	/* free ras shared memory */
-	psp_ta_free_shared_buf(&psp->ras_context.context.mem_context);
-
 	return ret;
 }
 
@@ -1650,23 +1664,13 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->hdcp_context.context.initialized) {
-		if (psp->hdcp_context.context.mem_context.shared_buf) {
-			ret = 0;
-			goto out;
-		} else {
-			return 0;
-		}
-	}
+	if (!psp->hdcp_context.context.initialized)
+		return 0;
 
 	ret = psp_ta_unload(psp, &psp->hdcp_context.context);
 
 	psp->hdcp_context.context.initialized = false;
 
-out:
-	/* free hdcp shared memory */
-	psp_ta_free_shared_buf(&psp->hdcp_context.context.mem_context);
-
 	return ret;
 }
 // HDCP end
@@ -1727,23 +1731,13 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->dtm_context.context.initialized) {
-		if (psp->dtm_context.context.mem_context.shared_buf) {
-			ret = 0;
-			goto out;
-		} else {
-			return 0;
-		}
-	}
+	if (!psp->dtm_context.context.initialized)
+		return 0;
 
 	ret = psp_ta_unload(psp, &psp->dtm_context.context);
 
 	psp->dtm_context.context.initialized = false;
 
-out:
-	/* free dtm shared memory */
-	psp_ta_free_shared_buf(&psp->dtm_context.context.mem_context);
-
 	return ret;
 }
 // DTM end
@@ -1785,6 +1779,8 @@ static int psp_rap_initialize(struct psp_context *psp)
 	ret = psp_rap_invoke(psp, TA_CMD_RAP__INITIALIZE, &status);
 	if (ret || status != TA_RAP_STATUS__SUCCESS) {
 		psp_rap_terminate(psp);
+		/* free rap shared memory */
+		psp_ta_free_shared_buf(&psp->rap_context.context.mem_context);
 
 		dev_warn(psp->adev->dev, "RAP TA initialize fail (%d) status %d.\n",
 			 ret, status);
@@ -1806,9 +1802,6 @@ static int psp_rap_terminate(struct psp_context *psp)
 
 	psp->rap_context.context.initialized = false;
 
-	/* free rap shared memory */
-	psp_ta_free_shared_buf(&psp->rap_context.context.mem_context);
-
 	return ret;
 }
 
@@ -1889,6 +1882,8 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
 	if (ret) {
 		psp_securedisplay_terminate(psp);
+		/* free securedisplay shared memory */
+		psp_ta_free_shared_buf(&psp->securedisplay_context.context.mem_context);
 		dev_err(psp->adev->dev, "SECUREDISPLAY TA initialize fail.\n");
 		return -EINVAL;
 	}
@@ -1919,9 +1914,6 @@ static int psp_securedisplay_terminate(struct psp_context *psp)
 
 	psp->securedisplay_context.context.initialized = false;
 
-	/* free securedisplay shared memory */
-	psp_ta_free_shared_buf(&psp->securedisplay_context.context.mem_context);
-
 	return ret;
 }
 
@@ -2524,16 +2516,18 @@ static int psp_hw_fini(void *handle)
 	}
 
 	psp_asd_terminate(psp);
-
 	psp_tmr_terminate(psp);
+
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
 
+	psp_free_shared_bufs(psp);
+
 	return 0;
 }
 
 static int psp_suspend(void *handle)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
 
@@ -2542,7 +2536,7 @@ static int psp_suspend(void *handle)
 		ret = psp_xgmi_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate xgmi ta\n");
-			return ret;
+			goto out;
 		}
 	}
 
@@ -2550,49 +2544,51 @@ static int psp_suspend(void *handle)
 		ret = psp_ras_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate ras ta\n");
-			return ret;
+			goto out;
 		}
 		ret = psp_hdcp_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate hdcp ta\n");
-			return ret;
+			goto out;
 		}
 		ret = psp_dtm_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate dtm ta\n");
-			return ret;
+			goto out;
 		}
 		ret = psp_rap_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate rap ta\n");
-			return ret;
+			goto out;
 		}
 		ret = psp_securedisplay_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate securedisplay ta\n");
-			return ret;
+			goto out;
 		}
 	}
 
 	ret = psp_asd_terminate(psp);
 	if (ret) {
 		DRM_ERROR("Failed to terminate asd\n");
-		return ret;
+		goto out;
 	}
 
 	ret = psp_tmr_terminate(psp);
 	if (ret) {
 		DRM_ERROR("Failed to terminate tmr\n");
-		return ret;
+		goto out;
 	}
 
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
 	if (ret) {
 		DRM_ERROR("PSP ring stop failed\n");
-		return ret;
 	}
 
-	return 0;
+out:
+	psp_free_shared_bufs(psp);
+
+	return ret;
 }
 
 static int psp_resume(void *handle)
-- 
2.35.1

