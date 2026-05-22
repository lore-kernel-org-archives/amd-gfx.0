Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3BECD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB61910E58C;
	Fri, 22 May 2026 00:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="euUpSKnK";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BE710F47B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcuIHGuR+tYnASfUDM4eiY2kz7lIqjbU7kvwt6iVPK+30dajT6Rg6mSTHwS7DV+tb7rroYqfWAPWC13VNeEZUC2a8cmGKjVbRL81gnB7tpqkeGwIJR6pQm6iUugX/nUGXYXoUuhyXrEAdZ8EwY0MSGD9XN6fn/P1Qt8pO3VnEi5PyBLnDYFWNh95bSXM/Neilrj8ABV53uihjymvxL+E/vn+Iupk6HZaiRutFEwnxJBim4afZuDsiLC2SnPX+ICzEcNN76HqTcc1j0VF9Lex1PBA0dOYYkFt37Ff8Sg5bxzHe2AWnjxrEqlGb/R18dl6QG9P2Y77TraHz1k0dZbBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHbrTrOpVRlyh8bGeVXVfedTYw4MogN+w+jqQ9usX14=;
 b=dnpsIUTJWZKv/9rLEDxydtts1aQrrqzGvUiggOWD0UFwYMFEl2+4FSBDy7NxNqqPwXehWnT5IIUavLgUVIJyieo6WxI8YAa1JIUFkOQPcc8O8NZ2T82oZAfJon0b+pXdugYJFOte8ZNvz6/I/SijiDIQFuzhhl/uoT0/Vq1ivvA1GDMsIz2UwSHIO4deJYZk1YupIStd8BuAVNnBe1ffrCvlVByFNW878mBp+kL5FSAwcZkooqIz2CoovTqiZqdxkCOdrYMFAIW8A1AZG+5eqgrK44XBg2FXTqN5XPE2S5/jrj/liAB9/ss8zzjQ/MkgFpGGWX9gcTzd1eKAkitVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHbrTrOpVRlyh8bGeVXVfedTYw4MogN+w+jqQ9usX14=;
 b=euUpSKnKBMWyst3u80VF6X+SorLpfaB4iL3cBNvPlcNuH9wmwAWw6IABxQ2CQ1cWj4tlufOtJ3x+Hiv2oQXF/mG6hy4j84YQkxFkR96FhL2QHs3d8gaKjdnil009iNzGNuBjfHhQekYMjB1/P2ets3J6vErYk53IdnS3Q/hZrOU=
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:22:11 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::af) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/42] drm/amdkfd: rework MES queue reset sequence
Date: Thu, 21 May 2026 20:20:32 -0400
Message-ID: <20260522002048.98506-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 191e3b18-566e-4498-2cda-08deb7982b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Oszth4n7A4kpnAvYwHTLO1nd4puZY4D7XRVeKb3Lj4wg0itwblR/+b1nBR2nAdacLL+fBtEuycuzfRxhLhlB6DZ7+LCxXXz5FVgPWl+lPU18Fex4tcWI0sLN96+TcX9ip/OazDJ8ob7RP4SF2gebDdfNJOBTEEV8m8tVZ/lIgxKas5H3ykxYQPnWspGCJ0jxmTYVd9biLqeycNtRoI2KU+Yt+Finknlli7f9afsKcBkROn6tBsRJ3P/8nH0sVPunkKWLwN6Jl0dyRnSgPMiWCWhNo81tigjz0GHvj9k8SZRuOwkKFktmIVEP9FMxi30yZmxC4Ot8o4gZBigyO6Q/Z9scQ+UO3Yxt22DASRUE85cqR94D89WDLsmKR8uqGsiosnVGtdqPEXr4mtwlpnqzUsJqfJfrQwbTUqhthdW+9FvdkYl+r/HpKSXLoDD9u8U6XqyLcjGtTFzpEOEVOBqj/66BaG30iVcVY04Il1yLSrDTKqTgHIEELzoA/scK77rNwypN8bXgMq6oIFKrCmfL7rGPyuxyk4MqkJpTIi81IDzdT210eVrxP18GAynOV81rxOrj/awJR/usvIhWLTXN3hPqZV3DB4c8Mz8lSN8IkRzreaqTElvgEPcbi/YnTCQfWIaP9/MbFWBAO6hQjJbL7o8cMQzCd9PNGW87Gd2IAg3LUKTpfeuOJjHq08fHsR9TfdI/chlZsSw3hK4DJLB+GzoSzLTJSlgmJiMHpopZ8UQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tUjm0KHUGK9MdmJsvKfpZpeGPMnaGxEnYk2nPFnQWSkd02a9J2qkbYqZqApa+N7auBvx/LRBo+pzKfzsJ8FEHrngwSDaEW4ySAB7ESHF4dDHNqzEI4fqXg58ghy0b/j7mi+iPxzlrkuHdC5PybigFoTZMLmA2WR8XAjgdH6nMrRopkRkqNzH9Y5FUHEbLQJLz8Xs+u9MQ9Od/KK6WoGhLv5eP43BfpWJYUvbnCl10PemI90xoSOnSDzNU1hP1YZGRGVOf7w9cE+gbj3rS+zEjQU0PPw7bPL4N4y6wD1rS7mGt5FEEboru5dzVtl5mIovP1TZOZ3iq0iVh3r+F+SzMy9gltjnCOY3oic4Mm32fklMC82ZqQcNtocwu3guVN8kWeHuZRrTwxfVIzEfnrF68JQbZlrbzDB3qZlBpTkXImIXhCd8tRJxbhPZaChp5rNM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:11.7386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191e3b18-566e-4498-2cda-08deb7982b06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
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

Call MES with detect only to get the list of hung queues rather
than detecting an resetting.  Then loop over the bad queues
and reset them individually and finally remove them.  Skip
queues not owned by KFD.

v2: always call resume_all after queue reset

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 08006ce8126c9..e323658f972cd 100644
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
2.54.0

