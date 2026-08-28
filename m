Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66B1C61DD7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2792810E488;
	Fri, 28 Aug 2026 09:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pf4GP3cM";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CE910E3F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyFvbsK75i+Wz5OP6lAX29h8yBYHlS9CnMl2mJzl0OMlEIQfCdnnQiUh8eEJp/2pRKNJoid2Muzcm6tsht2I4fe2DjSGTiPmeptl/qyJFbNSNY0ohist5GjJAFkI1Jg8jST07CVylCEdDm07+Q/5xzyx2np3NZf92c+jviUdnmxbGC8/98rAYxrUMMSW3yPIuHFiVTbxNxjOyaAQPUV9yWvdyJhB2tXl+0Bl1YI3p15KInUHMNtxFixVZ2XrlyNXiottv816dUyHHH1ohG5v/kdiwJEOgOx2J3JdkyULAdl5vIf3dYxVvpge/g0z4XplAPtgxxWYEvHzkVe1LtKptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXT+glQd78gF6KOaDA28kqFWX4Z/8cfCdFZKnMErVAI=;
 b=QgGPDNpwaf6FDPYjm2N99urOORhyjsfmDMhel8WyQVBaz3N4WfIrWyXRBbm+vum9Qm95yyNqxE64PoT+vDRDaGXHCy5uujzPKa2m5sE14IFQyfiVCQxCwN6lp18901tR/+oUb0KDpyds+QBs36QAgrakrOK/3TSOKAxTzQ8Xqs4sJDQp9hIAjF67UsuXmowq8AGla/lwGLO9rciDyTfKclMm/3umPl5ch/whzGlqbL3W+RlDdO8RPZgN9DnOirz3w+stLNAZ9DfHC11IB3Rs0iK/OHR+hcaAvSPexLpZ3z+RsPlEVDMXkSbPNT3s9VzgWWF4N5BOPYyR6a27lONkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXT+glQd78gF6KOaDA28kqFWX4Z/8cfCdFZKnMErVAI=;
 b=pf4GP3cMLB+jHQ4xRu1vwDyScmaBfYyvKgKcqWcWHFVDEhdGLvr7+NKRN7q6TByzqwZVrL1dZ0J7gp7/wEjOIVsp/SRNEFRAnamFk4FOOHL7I7ncCJIkUYGAKJfXUpyvOL3hziDkQTn0QrHepnrf+qzTA3TseaA5L+rO6ZwBlIk=
Received: from DS7PR03CA0188.namprd03.prod.outlook.com (2603:10b6:5:3b6::13)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:53:55 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::8f) by DS7PR03CA0188.outlook.office365.com
 (2603:10b6:5:3b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 09:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:55 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:53 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: hold userq kref during suspend and resume
Date: Fri, 28 Aug 2026 17:53:47 +0800
Message-ID: <20260828095349.9797-9-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828095349.9797-1-lingshan.zhu@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e85357c-6547-4879-a975-08df04ea463c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OLuVhllU69SSHVl8LikOv1CQ2pZmd7H1YnVXPnnZoX/SUvuCjK4uUjh6tlt2tfQR7ldSQEVazqRmIetyNzOZrHyqsh7NdMH6bxYVjH3GiOmH9sPqNYKG4t3IkypE0vvkI/BMJ/kHjleLb9ww6SjhVlXedQRrhdPjNvqUNcHl66BRBpoeXbUhVeudgZ3dCf9SndLfT6DiyuPqNPzMkh4CK3n60sHFsTTnWDaMpoPQ2FNESz/rXcm25NutUo1tzeqzwk2/fIlcwcy24YdlaLYN2wfDT+R/bDAPZy5xuYCeafLpCnqBm9iC7tWL+s6bFSfVHIJA89VApKeHaVADsChu+QH341EELCvdk3j+K8AnlUdxwup9npz5pVu/a+zcROdHa24pArK5noG7d5FwMb2th/knYVKRVH/6P0amlLnpf+AI3kRC+hMUWq21gq3+vfeW9jP+6dYgG6d/XD/BIrBIkFYk1mjv/8sLo/T9sM0cqgu+0lYxQu1/+6psv8Pd6JybNZNHY3ca0RuyYTcgDjC8KNR+F4B8PKrohR0Ch66Rf8vBGNVts2iBqQ9/RTBQ+Nsg2daXeG8/NA43cETGefCIk+GTsnPZ3XVZLck+aUkRcqcSxHrWORnZkzuz00po2IgJUqUk4J1MeBItDbuQD7G1Cqp7h0uvpSNh3FBK0u41ein/W2sYlv+dHF+BwEOD6uQEg4Bi/iBSUwdKrfwXOdZC+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GTR7m2rU/1Gy0WoacM3ckHf+MTQJq8z7uzL2HaxFnw0jbVO9raY0/iNcFMnGFxGcopsacBbnpfTNi1ser21T9XVPwDptEPrIORI6NB53YoX9MICO2BWWhdH2ta9huTj9XaUQrL9/9wqHLRu84rD/ZwxsasgEmCA8SmKED3lyf8YJohRCCLV8sT3E/laRqqmrKyAn0fYeBhIhifLnoURBce7Crr64+CzBSzkUT67HZdig2yT+0Ahyxft0Jbll6RoGTwoeuKc2aJ1nhIx0tBglWNdohfVhAV534Fw9G8iNDeaaaiiTeQbf1N1C824szi1SViOZidJPaNRzOAOhM8EJP7jAGC5e5AK0YLZ/RSWR8LanK05Gg2thlDH3hD2GbKyWIRpYmUZuU06K3982sFhLp7QgyoJdNx0nHG7c8FNejmQbHknUulnVqJRYbYVOaaSQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:55.6334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e85357c-6547-4879-a975-08df04ea463c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

The userq suspend and resume handlers walks the doorbell XArray
but process a user queuewithout holding its kref.

Therefore, a concurrent queue destruction process can free
a queue before these handlers finish their work, causing
an use-after-free problem.

This commit fixes this problem by using
amdgpu_userq_xa_find helper which properly holds the
kref of a queue in a loop of searching for queues.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 +++++++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1427ff175dab..0dab395ef0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1493,23 +1493,35 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
-	unsigned long queue_id;
+	unsigned long queue_id = 0;
 	int r;
 
 	if (!ip_mask)
 		return 0;
 
-	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+	queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa, &queue_id);
+	while (queue) {
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
-		guard(mutex)(&uqm->userq_mutex);
+		mutex_lock(&uqm->userq_mutex);
 		if (adev->in_s0ix)
 			r = amdgpu_userq_preempt_helper(queue);
 		else
 			r = amdgpu_userq_unmap_helper(queue);
+		mutex_unlock(&uqm->userq_mutex);
+		amdgpu_userq_put(queue);
+
 		if (r)
 			return r;
+
+		if (queue_id == ULONG_MAX)
+			break;
+
+		queue_id++;
+		queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa,
+					     &queue_id);
 	}
+
 	return 0;
 }
 
@@ -1518,21 +1530,32 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
-	unsigned long queue_id;
+	unsigned long queue_id = 0;
 	int r;
 
 	if (!ip_mask)
 		return 0;
 
-	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+	queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa, &queue_id);
+	while (queue) {
 		uqm = queue->userq_mgr;
-		guard(mutex)(&uqm->userq_mutex);
+		mutex_lock(&uqm->userq_mutex);
 		if (adev->in_s0ix)
 			r = amdgpu_userq_restore_helper(queue);
 		else
 			r = amdgpu_userq_map_helper(queue);
+		mutex_unlock(&uqm->userq_mutex);
+		amdgpu_userq_put(queue);
+
 		if (r)
 			return r;
+
+		if (queue_id == ULONG_MAX)
+			break;
+
+		queue_id++;
+		queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa,
+					     &queue_id);
 	}
 
 	return 0;
-- 
2.53.0

