Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF601CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 525C5112DD1;
	Mon,  1 Jun 2026 05:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B1V0QA+3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4198E112DD1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3r7GzMpHbWk9J4MY+AYaAVBhkiGGjA2h6v+lqMxwPrBsd9jY2eDgxRXuIvghJpyJxBHJTMAppykZcv04Oj5JE8wfTAFoJFxT9fYLRFpzjlktZTm+yt22OxtyguEHmwUHhc3EHQnuiQa08a7wGbKHGheg3KKspR9td9dJbnr93eibiMbOtF+eIW1KJwUrmtyqnF7p7H6TmC26XKwFe/R2B2ac1MY7Wi5Zpcc3dzRLOZumuZgJmmLQCAlZtx/cg8YJANONVJKG4zDnCyc8uPo1u4vanzN0MKC85cZOpW+XauT1ej/rTDtpTK1043gysUpU3iSsRh5ue25dbQV464Cfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcfnAyKJXRS3ruA1RqrtYM/KNMD0VbR2pUi4fvP9AEc=;
 b=XydLEZ0V32vmH2H8rYJpkNhs5tDqamczXoQv+hgXbIQv3lCu8O5uKnR9uzSGT8K/4aJnxxTrDQEEB5hKCITZ8U7/bAQLuI53gPw+2FIWs+qq5U08z/rNej8l9IEX2nmK2hajMaoj34j2K/BuGO00LkvCvGMYHlYMnFjrbYF1waOWf40zHtgykZ6oxdIOfG8gr5r1SBs4Yyp5MJwLCpGxk0CGkrAXtD+xT3npqxSXq5rlLGqXJztPk2LDWi/escKWNOAtAWZp/sSIXgFyCvOYXhf1fu3nOZb9VwhJoZvMIsxL22P0s9YN2yfp9y1Ptx1xgusaJlA8NmXe5MXjcaEPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcfnAyKJXRS3ruA1RqrtYM/KNMD0VbR2pUi4fvP9AEc=;
 b=B1V0QA+3bU0mUMmBFThPS8Nv/zuJR37xvVJTIzljLB6BP5iki0SeFKMETZl70QkOeg166+0g3euiuOALUncCHca5lx3+jgeZyS0et3sw3Jh+d4VL74PTr7AFSKT48kNxrPSkcOjae3UBJaKF/ghpGuZVgLdjHfGDmrri+FJdVR4=
Received: from BN9PR03CA0526.namprd03.prod.outlook.com (2603:10b6:408:131::21)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 05:53:56 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::15) by BN9PR03CA0526.outlook.office365.com
 (2603:10b6:408:131::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:53:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:53 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:53:46 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 26/42] drm/amdkfd: rework MES queue reset sequence
Date: Mon, 1 Jun 2026 13:49:12 +0800
Message-ID: <20260601055034.3700921-26-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c925dd3-191f-4754-f297-08debfa22ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ep2uZ5ccQCwFVkjWUTG29NCTAC04Wy2smCTiXcYu3JLCHTRb9InlY+KY08CI6mLJXDM9IKpXhF3/ExTK8KGm8qMk7SGAZMj4/n+Oir/wDn6qqnxVfSDvWjP/jekYITrzOn/xZOvwPDPaVTCDdBV2P9SxiH81jgq+XtvPtkzyyuBkC1iLfp99MgdZkuGHSY6WSDLh/75LE6x/s52gRg3mYQcFHDFFHuEVV/C99bhnAbZ6nngP99JRxc2SM/InrnES95o5pmF6cqZLOfyKstYI8BOKmJ4hyr5l2XZnBK5wL+GGgNv3SW86cicgUEDxF+isvsth2+eGXfeug1bYFh/ucdPFUoJcdjyzfUs3lNR4tKkn/AQqeAF76IhxwE0DPZA3rAAeB6aCyJsh5QP5RQVeGRI6gsd5AJTZGSxaJ04PyUJ8Eq5jbw5oSxyQHyD4x+pVlmJwrU6y3mFpn7hZWHalGfJSDI0DMVtoFHHLxoc4qsT+9aOy9wj4AZHVt4DTmnXa2BCeBh1/RvPE474hvr+D5giRPgoAh+oQGx5KNNluyNpjPyUwhu/yQwGR8tpjSA4O503afv/S8r5ASG4cZFcXsNFiedosfFzrLC6Gmf3wN3Kj6Uu2cXr6GxfpXc0oefU3zY5lgHx4nNaedgSKqN1VZQC0OZ87fZzGJdeY4f1pTQz1Wy5UCh/1SnDvONL6kmOnmw0gF9K07lrX/8VBbVi2XIkdcqXbZ58Jm8GTZgX2XSA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2hhQWS0NdFcwbvEMKvJ9g9M8hpx8m96zBN3HRZoqlEKTeuLuL+wkHBuVDLTC46EuwuJ3H36MGJCLcl6v8P6/nD22A4z7SNj3TvLg6xZB+MtGV8C6rt53tIIXWeUQT6lkR/xtLrI5kVhDZskOxjV+YAjyCNpIe8UvtMOjLtVhAshdRrn/1DCBE5Fkpl3fiAvqrjqPpBQ2IW7s/78PX+g3X49C4LeRmBrmYbOPtO6tMlWE8V/3UEU2GXI83G5L+6dNijxvVHoffyr/ab/uTHlkKCqCJLL67n0LjtiHxU8ZSeanwxmluo8YGPsun7NeX1heABAnTFgSEH/Fq00Bi7EwnOEM5blOfgXJdXCJyod8ufJabsvKwVmgFFWLziEAqE9AaSo1CmkDM3tDnQYHXszeFu5xh23yc2sEnSAJdi7U9VmkQI3x75g7Wp7erOVXvxaR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:53:55.7778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c925dd3-191f-4754-f297-08debfa22ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

Call MES with detect only to get the list of hung queues rather
than detecting an resetting.  Then loop over the bad queues
and reset them individually and finally remove them.  Skip
queues not owned by KFD.

v2: always call resume_all after queue reset

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 08006ce8126c..e323658f972c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -445,7 +445,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
 	 * Passed parameter is for targeting queues not scheduled by MES add_queue.
 	 */
 	r =  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
-		false, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1);
+		true, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1);
 
 	if (!num_hung || r) {
 		r = -ENOTRECOVERABLE;
@@ -467,10 +467,9 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
 		}
 
 		q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
-		if (!q) {
-			r = -ENOTRECOVERABLE;
-			goto fail;
-		}
+		/* skip queues not owned by KFD */
+		if (!q)
+			continue;
 
 		pdd = kfd_get_process_device_data(q->device, q->process);
 		if (!pdd) {
@@ -480,6 +479,10 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
 
 		pr_warn("Hang detected doorbell %x pipe %d queue %d type %d\n",
 				hung_array[i], pipe, queue, queue_type);
+		r = amdgpu_mes_reset_user_queue(adev, queue_type, hung_array[i],
+						ffs(dqm->dev->xcc_mask) - 1);
+		if (r)
+			goto fail;
 		/* Proceed remove_queue with reset=true */
 		remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
 		set_queue_as_reset(dqm, q, &pdd->qpd);
@@ -505,13 +508,17 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
-		if (!reset_queues_mes(dqm))
-			return 0;
+		if (!reset_queues_mes(dqm)) {
+			r = 0;
+			goto out;
+		}
 
 		dev_err(adev->dev, "failed to suspend gangs from MES\n");
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
 	}
+out:
+	resume_all_queues_mes(dqm);
 
 	return r;
 }
-- 
2.49.0

