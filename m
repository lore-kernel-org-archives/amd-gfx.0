Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EFFC52D7D
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 18:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E4F10E3DD;
	Tue, 13 Aug 2024 18:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F3HLe0uN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0677E10E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 18:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGwt3eitUO+ARC4ids4Iim6FgwOxboXUqJNBk1VxNRDShkIchaNV9DAAvtmJuIDjeiiH0oE+I3X5LLwo7237Si7i575apLEQfb3Go3D4/83Ki51NzeHdyAGTDr5ev+4LYxqpEzNou+1HJcUgVVcxIf2kNzaeL0uUSMCpgpuW0Y6EXDVgQgq7a/yg9yuHFBJu9KhWtTsHliAJq9BBZem0bhHyGQlL0/iEnffyG3uuh5oy9BeZR14GO3lQ374f4FmDymmhKwk5J+hQRSTvNG0am7a7Ncwxkoxt0jrsA52GoAJ1O1jIpsfKlNwyQGkTplgV3uteCvy9Pa118BMrRf1Eow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaQYyZb4+Yy+MxRpIyHxYZhjGWlGcyMK30MCuQiT9YQ=;
 b=dSaNW6tuFLzGznerUsvEB2sS+5IJV90gOHNxerqLEi9QqM4dc1bEJc4bt1VUvr8OTJ+O4rO60RqS5FoFaxtNMY1BL4B3tHCvq9+h0aUrNNQn6tYuexdPJsoUlWmYO1RyNjSSplFoT68VsldsRjEuSVOLPOjEV8RjsmL3fYjcM0ciFR//fEiQmp9UJ8E83i5b7rogv1fp74Gdy/vc0MJ5TxzoGFEximJcr1jdf9ijhV1Fm/Hdqad9IO5Xsl3jZSMMhzVQvMyxQ4f0QsWryntntGyCVWIwUc2z6ySc+h4fHIa83vcrkh6z30tgdfg/nCZyIOnWQ/uhybpjmIp5mnyi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaQYyZb4+Yy+MxRpIyHxYZhjGWlGcyMK30MCuQiT9YQ=;
 b=F3HLe0uNBm0BZlZv52sbESxbd0x4z0D07vlIopwMYUwPA3bCrV5rl9wFQVgz3XjqU+xiaPujAPedWekgh5zcTb/nYTP89N4h4KfL0pKvPlXYZ++jsvYTL+lMm2CtTTRhcQJKQRDez7j1sXT2zS86a94N9QHTAzEuzJZUJfSC8Ps=
Received: from CY8PR11CA0007.namprd11.prod.outlook.com (2603:10b6:930:48::15)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 18:57:25 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::7b) by CY8PR11CA0007.outlook.office365.com
 (2603:10b6:930:48::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Tue, 13 Aug 2024 18:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 13 Aug 2024 18:57:25 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 13:57:23 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: Update queue unmap after VM fault with MES
Date: Tue, 13 Aug 2024 14:57:12 -0400
Message-ID: <20240813185713.942012-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240813185713.942012-1-mukul.joshi@amd.com>
References: <20240813185713.942012-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7511d4-3a5d-41b2-ec30-08dcbbc9c55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4L17NdRbu/BCra7S8F/X8W7AMdLbuRJyY1lcB883YMkZ0Jr8n4AT1EBOs7vZ?=
 =?us-ascii?Q?fJsSXVAnRRvVOhn/wFiL4c2smcAuul5UdJGBgPE/Q0mumQ526329q5PwiE53?=
 =?us-ascii?Q?7lS5gIvsyPFFcAMgAdD8D/3zqYOokX8+ER44Ff1+QoYiftxU3jTxc4cAhaam?=
 =?us-ascii?Q?hydgUcBlifbjFvM1BhfAIzzWp3zbb01pAqoainSyCEmpPpnTTkDCV53pFihu?=
 =?us-ascii?Q?jwxen3ZVilhC1QMW4Mf0iMS7LrBXBv9GtsJVa4/LdyZDUha0dd6zH3isdDKw?=
 =?us-ascii?Q?cgBSN8zr0/sq/i1PYDdcURBGecdvKd0wE1gj4bOVeuxNE2PqdX5MNrSkPHWU?=
 =?us-ascii?Q?sC/8/s9Y9lKCxJKB0VgQ+KhqerVH5EkVIM5qfW2H1I+CVMH42i8LQjMgeERF?=
 =?us-ascii?Q?Jz055rxR1GJgongg4KWmcwrAHq/s1P02NK8+Xbq8HrnI5MvnUP+cv6Tg4PPL?=
 =?us-ascii?Q?02R+RctsnbMRdc2gt8tkuzCePk3X27AasuLJdQatU1qWNqBYGDaoHviIJdOd?=
 =?us-ascii?Q?aYOZKvqrh2pA5N6wGZ6j+I6DMuf66CSGreaH/wnP0D9ltVR7ltHy0Gu1Z1o0?=
 =?us-ascii?Q?99g8bXA1wiyH7NKPzSuEvtnK05tD6KJk9UTNgvPaLjSKVdNNU3RMlfsn0LhX?=
 =?us-ascii?Q?FBJ8u48JiFkNPrEa7wd2hsxS6g/JABf7fVKAt4BrQyfhCmkNxFMRIGJnZ+8P?=
 =?us-ascii?Q?Mma/eofns19YKlpqKSrFujQE+8koHRXN4BaMzlquGwiS3v+C07dZz089Cc3l?=
 =?us-ascii?Q?Rhed9cf3EohyteG7rJ9MRmmFpjdWUtI6XMp6wLYFCtHKFfMedOV8PrFPbMzr?=
 =?us-ascii?Q?ASB3ETtT745dUINSb++qwJRg/4etZ/Wa6lXTaP6uRAPOrB+SeiH1xPbi8Iw7?=
 =?us-ascii?Q?Nd05SJXsMqaA37Fq6W/XEqnbNMthoDkavcZ/Zb5z1MrVHlIy2mBDetrUWXqU?=
 =?us-ascii?Q?nC9y5rml+mPYpbCbIfWyyqsp84SnmPUiCDxqtEyprC7XzZFAg8DrYtyYqgpU?=
 =?us-ascii?Q?T3VgfIVRzsfKMNDkGMD4TEBitIJSuprV5c8y8BcC/ByZekXr4KbytDkbt5aR?=
 =?us-ascii?Q?6vdsS4i/Uj9VuGlDLlOJ1YYluxyfk8+CN+tMPrt5Lrr4Hdn+O5TY9RtTFCfx?=
 =?us-ascii?Q?99FRx5gD07L1WiIh4Gxku3EVB60WSERRGVW6vRVxEnqzlG/rgT50ZVWAUucT?=
 =?us-ascii?Q?P+VtwjELQ2Z2jNtPs6T1IH8M8CFjLlFWupBxHaJ9chvTYpC02Ky+2kklovHC?=
 =?us-ascii?Q?3EAgd7wgpQ9P25LgOZkMDJkViUyEEE1Tqocb35QK9AvZPhmXHIzD4Z8ZRzfD?=
 =?us-ascii?Q?vhmM6Oi02/2tfIDkqRuQbsAX0Vrfx99yKcRx8V+kgGWcCjUXpeWyzFmgIikQ?=
 =?us-ascii?Q?Jk8xDnNOzAfUoTg9sACR4tsK9fRcZshbCwEeYrrU4CDmAbew2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 18:57:25.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7511d4-3a5d-41b2-ec30-08dcbbc9c55e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
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

MEC FW expects MES to unmap all queues when a VM fault is observed
on a queue and then resumed once the affected process is terminated.
Use the MES Suspend and Resume APIs to achieve this.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 75 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f6e211070299..e16b17e301d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -319,6 +319,56 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int suspend_all_queues_mes(struct device_queue_manager *dqm)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	int r;
+	struct mes_suspend_gang_input queue_input;
+
+	if (dqm->is_hws_hang)
+		return -EIO;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+	queue_input.suspend_all_gangs = 1;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+
+	if (r) {
+		dev_err(adev->dev, "failed to suspend gangs from MES\n");
+		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+		kfd_hws_hang(dqm);
+	}
+
+	return r;
+}
+
+static int resume_all_queues_mes(struct device_queue_manager *dqm)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	int r;
+	struct mes_resume_gang_input queue_input;
+
+	if (dqm->is_hws_hang)
+		return -EIO;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
+	queue_input.resume_all_gangs = 1;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+
+	if (r) {
+		dev_err(adev->dev, "failed to resume gangs from MES\n");
+		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+		kfd_hws_hang(dqm);
+	}
+
+	return r;
+}
+
 static void increment_queue_count(struct device_queue_manager *dqm,
 				  struct qcm_process_device *qpd,
 				  struct queue *q)
@@ -2839,14 +2889,37 @@ int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct device *dev = dqm->dev->adev->dev;
 	int ret = 0;
 
 	if (!p)
 		return -EINVAL;
 	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
 	pdd = kfd_get_process_device_data(dqm->dev, p);
-	if (pdd)
+	if (pdd) {
+		if (dqm->dev->kfd->shared_resources.enable_mes) {
+			ret = suspend_all_queues_mes(dqm);
+			if (ret) {
+				dev_err(dev, "Suspending all queues failed");
+				goto out;
+			}
+		}
 		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
+		if (ret) {
+			dev_err(dev, "Evicting process queues failed");
+			goto out;
+		}
+
+		if (dqm->dev->kfd->shared_resources.enable_mes) {
+			ret = resume_all_queues_mes(dqm);
+			if (ret) {
+				dev_err(dev, "Resuming all queues failed");
+				goto out;
+			}
+		}
+	}
+
+out:
 	kfd_unref_process(p);
 
 	return ret;
-- 
2.35.1

