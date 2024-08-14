Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C186C531DC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 23:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBB210E31D;
	Wed, 14 Aug 2024 23:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yF6RxoBD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEED510E040
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 23:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddb8x3boUvB2QCs/lgkEVt/jJTBfepXyEQiBY0z6UVwZMXVSEA96sYcCVImbsc4myo7A5dk0k0uC+0cDwctsC7Py91ytjWXRcIB1yLocL18/cFlscoHhPbVAasOpAwUCfGCEymdO6R2y4mfSGcPTTa+1fIMWe14RRZXPErzUFUjHlv6uuXXsgctrXVW49gRdeCHtevRK6FJ6YjsKb1jkCd7kyj89FtNPeO/pmJkuP4T99RynU8IkXKpVVY1OMuWZ47Qpv9i/65aBBypSH6HxgZhc3qL6JJ4kOObb5IUOaZSvEjD5r4expbN4Ix91TOTIm5cLbytukmcwwS/hbSwqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03ODyGZQKTdVtVjmpt67J/9Wa1el4FVTfor+rQYXDCE=;
 b=D/Ko3d14JkDrmeME7+pPuCRsWsYQKbmFejtHwHBScqGEL6Y/RkMeayY583VuQRyBWeErzHz2bCXfio7Sm5iuMVFXqDOMCGlEtGPw1LxDVBkSfsy54+yFvQqmRMGXUW+etTZZazyLLV5tIcqcE7wI/dEEyxwB6/0befBPixYSJ0cFHG6v67wsr9TIFOlBuZlmujq1FmwX5sdRG58rHKt7nfkpizuP9x3FWMUHmNexDgpQAW2BUY+CHxQlvb92LQRYwg51JuCDHiu5B/I7ZH+4gQvguLfZhQot8gjha3Da51k1Htqf62fEjCM60yg25aPVIi/+H715icKjQ3ULO3YeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03ODyGZQKTdVtVjmpt67J/9Wa1el4FVTfor+rQYXDCE=;
 b=yF6RxoBDPWRe6RJUew6zK2cMQl55w2I05++BaUdMMjwrELlATtXTWGbubkGPdPTWIOOHpc9XTvGcQgq7pC2Y520+KqJwjppbVfI7SQ95UPwuKTAFyUDG33X5r4HvNWSoQoXljfZFgqSztjzyfLMQGjPuAraS6IxxITqMaqkY4hU=
Received: from BN9PR03CA0516.namprd03.prod.outlook.com (2603:10b6:408:131::11)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 23:28:51 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::cc) by BN9PR03CA0516.outlook.office365.com
 (2603:10b6:408:131::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 23:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 14 Aug 2024 23:28:51 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 18:28:50 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCHv2 2/3] drm/amdkfd: Update queue unmap after VM fault with MES
Date: Wed, 14 Aug 2024 19:27:53 -0400
Message-ID: <20240814232754.1119319-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240814232754.1119319-1-mukul.joshi@amd.com>
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffe4d72-d4cd-4e13-1e0f-08dcbcb8dae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XYjScXlEfqjCoQwwmNg9hGqHS9Sh8YDg0bKZ+Acasp+vvf11wpg+6lXVS7mF?=
 =?us-ascii?Q?4SaRUZo580vxUGlT87Xfr4S8ImTmuv28b7yWQN50K4cSe+RWzt6e35lwxClX?=
 =?us-ascii?Q?AJvQ4TW/ReHlqawNx93dyDn4ZHV2rNAF8uDByLjjq3uQFiDZb3u9i+WG99k3?=
 =?us-ascii?Q?DgiP5yXsquwLFAUt6rGlkHIj96+cHo7ZyiyxDELiqug6ivB8Oel0jKgvmCIQ?=
 =?us-ascii?Q?GFAIolw3LBUf/DK0CxOj8+k3Nnr8q8wVlQKurHQ/fynyDX4+1WtF9YTXR9FP?=
 =?us-ascii?Q?wUG25WbeATdMLHH8mL7Tuw5a8vMyO/Sp/0n6IF8GkDWyFJiq/2wCeYRi/ME+?=
 =?us-ascii?Q?WjEXXW4F5XFG7gkg+sL8Fvlogu5McstlBGGfpn7iQSbJyRAh/WGuWh/dLnDY?=
 =?us-ascii?Q?wrieTafxH/Sxh7PRwCaFln8J+gbnJwcPlExxhwP8Dhl3yCb/CgkruKRcv5l/?=
 =?us-ascii?Q?Kjx9kxr8mE4fg+HgI43JZG1ywxaZtfdpUsvTu+mlxV8gW9DkBIt6bxk+cgZW?=
 =?us-ascii?Q?5XKbtctVu6kFBwd1I5Z8deLL4AXmr9aoZKTKRM8kEqs3Rs3n3yngnNjTo0ia?=
 =?us-ascii?Q?uW0QeAN2r+xKlWhAOjxYhWl4X9qF9sJECpilkBOPkunysA2rhWHATahCGgN/?=
 =?us-ascii?Q?IcH5E581K38evYiUHLIWasNg2CmCCvTJqx8GTitjcxsFyfKCiTTJMV6dl1SS?=
 =?us-ascii?Q?S+vN9tXhwPbqYHfGP3Li4RZq5YSi/SsTm0UhuOV/yDo/PZsngMy39ByBdeCc?=
 =?us-ascii?Q?ZNOYCO7gcIfN48m3FL3Ug9TYcsQbdiw1MlFYWiL941hODOpcF32kwMPLsSiJ?=
 =?us-ascii?Q?t87yMf/KNaJ1WlT6fc4kaPt63c8veGdqtNYAClZqZAYiwE8QGL3P8MiQ9JoB?=
 =?us-ascii?Q?HYFu6Ng74LwNI5y/dSOcephpt3AI0hGQirgVZ1leh9cvZ/w2P3wHTD8/RV5w?=
 =?us-ascii?Q?Gy+PVjzTanGVFh73olNbKaYMWX4xkU93XYqdInkCGv+B7GNuFK98cT5hD/Gu?=
 =?us-ascii?Q?1AFPlEhYBP1r0f/idxr86lrmRKpK2PA8LT9NtKSabSYM4FObGB2iFIuYoDN2?=
 =?us-ascii?Q?vYobye1RdiwQ3kES7U6jFVHo0UwDIPr9mUqt+vJ4z/1rz0QBL9mHvHoMT8rM?=
 =?us-ascii?Q?F0i1eNkz1uUfuu6hv7v4nbhiSYU+FmVEOaVmlHSt0Ep5gV8RnZn/+Gff43fU?=
 =?us-ascii?Q?eDhLnCT+wCRSYmLLbTgIAJXThoVaKqnm9thjdbwO5gDwzjvisJ9BtroJBEjb?=
 =?us-ascii?Q?m3R5aWoURtLRzmHgb83FvP6IXBkj8IpUmjObCQ5ZtyHJYS6Mgk3uJuRiUbXk?=
 =?us-ascii?Q?mapQ7veZriZtn+C8hFx6AI8GvN/ad16NFSX3Oy/bPML/J1dntVpQL8JiGAaY?=
 =?us-ascii?Q?yZ1CO2V6lmL0Zd5IjZqlSFhG+jp98sMtpqe4+fKTnqJ3jccbsHr/22krF9dd?=
 =?us-ascii?Q?oJ0imjmTmIrkomyDNl8hYa/YwlvuQe2l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 23:28:51.1373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffe4d72-d4cd-4e13-1e0f-08dcbcb8dae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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
v1->v2:
- Add MES FW version check.
- Separate out the kfd_dqm_evict_pasid into another function.
- Use amdgpu_mes_suspend/amdgpu_mes_resume to suspend/resume queues.

 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f6e211070299..cb5b866eee3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -319,6 +319,42 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int suspend_all_queues_mes(struct device_queue_manager *dqm)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	int r = 0;
+
+	if (dqm->is_hws_hang)
+		return -EIO;
+
+	r = amdgpu_mes_suspend(adev);
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
+	int r = 0;
+
+	if (dqm->is_hws_hang)
+		return -EIO;
+
+	r = amdgpu_mes_resume(adev);
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
@@ -2835,6 +2871,40 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
 	kfree(dqm);
 }
 
+static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd)
+{
+	struct device *dev = dqm->dev->adev->dev;
+	int ret = 0;
+
+	/* Check if process is already evicted */
+	dqm_lock(dqm);
+	if (qpd->evicted) {
+		dqm_unlock(dqm);
+		goto out;
+	}
+	dqm_unlock(dqm);
+
+	ret = suspend_all_queues_mes(dqm);
+	if (ret) {
+		dev_err(dev, "Suspending all queues failed");
+		goto out;
+	}
+
+	ret = dqm->ops.evict_process_queues(dqm, qpd);
+	if (ret) {
+		dev_err(dev, "Evicting process queues failed");
+		goto out;
+	}
+
+	ret = resume_all_queues_mes(dqm);
+	if (ret)
+		dev_err(dev, "Resuming all queues failed");
+
+out:
+	return ret;
+}
+
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
 {
 	struct kfd_process_device *pdd;
@@ -2845,8 +2915,13 @@ int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
 		return -EINVAL;
 	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
 	pdd = kfd_get_process_device_data(dqm->dev, p);
-	if (pdd)
-		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
+	if (pdd) {
+		if (dqm->dev->kfd->shared_resources.enable_mes)
+			ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
+		else
+			ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
+	}
+
 	kfd_unref_process(p);
 
 	return ret;
-- 
2.35.1

