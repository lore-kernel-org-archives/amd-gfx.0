Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA5EC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A86910EBDA;
	Fri, 11 Apr 2025 14:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dTV7T4xT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D628510EBD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPYICfn2jNv+DjVjglO45G+eiIGk63q15W4q5H84EOwVRYHtkqwYUjgtOb4Ss8kb6ISLso7POzooMXIGnxMe6vJcddP1qfOeTbFwW43lqPVt5Lg5DNQyA004J4WOKIPaCjLmqjMrGkpIZ/rPnkds/s053pLAGu7kZ+ZuH6k8wWV3tWwmtB1V1adkFUxC2NuiSGZtX1FyVwtTQ/QEGcGjcH2wPSCv90JtiPOpm0qKMRiPCkUTXL/D9L9FonwR53Oh/VCen4Hw48zlZDcfqU6l6hzsZjQMj8RZzZbwiEOjfnENxks+th/iMOBGVtyL1VFvZapuINnLDda9YoKXv28oWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg/OyfK4Tcfy6h1mH7pkBQtFqueHs/y03wXCBOYKAio=;
 b=NoHEFXAz4J1vPoXKclJ8T0dcF0lAw+W76Nlb++OY2O4FFZCA4l801DGBmHWMz+VoCYSQHvP5GhZ81CE2QTHiYtKMiZbu6+BFIp4EsI6DBKIrqkvBE4kUhZU5Srd3CpxlVdmxbKLJdh0kPr5KJDyiesO6E7Pw8e9UhhPUm5XA3gQ1/ptCVRhBJ4c/cIfud6drcQjT4Y57w3qIMwkpDAy5mxn1t3stgTnkG9PEfNEV7eHa4xW3moum2nLDMn1hjbH/ciNEo5qtvHUMFc8EhTmRGU3sQDZsJBK2m1Ndwlv45zsG2E+zWh/Q17svnrzoZATWgHqKceOKn7Pl9uFkoTFNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg/OyfK4Tcfy6h1mH7pkBQtFqueHs/y03wXCBOYKAio=;
 b=dTV7T4xTMUzYv36cTk61PC6eYjwpTwq5JAzzrICjA9Xjur7wflVdoYZDuhKm7FAQ4KN6iIgM0Wo98Y9lwa9kqOdNjqkYgoP26TtuXNml80bXlygRlYiBt4aOzh23q3Bz3iMCyJkoLZgYPik5OCGP5gU1dwq1riX/cWOREkKKbZU=
Received: from BN9PR03CA0648.namprd03.prod.outlook.com (2603:10b6:408:13b::23)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 14:12:42 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::ee) by BN9PR03CA0648.outlook.office365.com
 (2603:10b6:408:13b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.29 via Frontend Transport; Fri,
 11 Apr 2025 14:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 14:12:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:12:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/userq: rework front end call sequence
Date: Fri, 11 Apr 2025 10:12:21 -0400
Message-ID: <20250411141228.2722962-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411141228.2722962-1-alexander.deucher@amd.com>
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c8d0fc-be23-4521-3928-08dd7902ec7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KmaYwqq6vZdbl2Y8DdNzOl32y3GAqBjZOFrKTC0nsuK13uNNiLikJ+Ryjjou?=
 =?us-ascii?Q?q9tHz+QW0aSq80vT8gyiQiXUgK1D4+uCJAXC6p+SaRBfJp2aPQckW/IaX4tJ?=
 =?us-ascii?Q?rVbfqNFvLxWrkzGjarJTfLra714zO8YTsj08DBOdy+/z5NgxfQhBj+bGVYcX?=
 =?us-ascii?Q?BQp9sFAzkWLLFqBWhXD2wbfsRcXR0wKdyVzMKVb1u3AbK+4F5nHHIAG5aokY?=
 =?us-ascii?Q?WnwlmUW0EkeZlY99AYXpIN9TvBnSLAebXe4DUVuyAytU0Ii4D1zUb68QHnUn?=
 =?us-ascii?Q?ltABt33lENBX5hOc5Fx454qg7eKp/JIuGPppW1B5rsJlEneLyRQemUiO4sN1?=
 =?us-ascii?Q?ZKPSGMZ91amVLUP5PpGgrCHcHZIDtgkvq6iGJR1KTrfPXQRfrOKakiPh+rp4?=
 =?us-ascii?Q?iY9gAh3UlXxVBRRbXxrwfa76BhhJD3SRSpS8QGCGEPZ1aDYgtkr4AveIBJ82?=
 =?us-ascii?Q?cLmRCr9zO3md4UwmmDSXRjfKCXS994TXm7LJqd2vgVcvUltebuk1ohiNETVd?=
 =?us-ascii?Q?4tXMsvd2WTgkBQSf/JpUlUdj4eUOd0WHf/yMpR58qO0Ns3THi2QmvY1IO+bt?=
 =?us-ascii?Q?oJjq3nqAYZIydn0cZDRQWyU046qF8ImAONYR+mCuB3tGNlkML6pVBbpO2ElM?=
 =?us-ascii?Q?k1nkv9bzeSnfZ8fKYoht7MMeuyRad18GWoFMT67dsjg3K5iV4DoZrIMORMVO?=
 =?us-ascii?Q?/3HZXV9rb/ecxFXBlEpptNnrNhSlFOGS/oITCffr0qJySZIH7WhqhpQC+NYQ?=
 =?us-ascii?Q?pfZx1+vrEBOoVQxX8qI0ZMohAAQmWYsbLkOa4CYKA//+uZW72gwTk9W4jGoo?=
 =?us-ascii?Q?yQ6rmcfVuuhsm2BteeBQY96H0LLwntTRvARsi6WRqjFrTtAgxvIZNT+8XRxg?=
 =?us-ascii?Q?KWvwoWXXtsuriB9xqiYpIteJRY8/czFrjRKXLZXug6aqer3fBpXv5+lkfOqm?=
 =?us-ascii?Q?EfEjZSEVk39USyvGu2+s6zdiIUPkWpxaFbPp4zcQbUUEzAadMEeNq62rRu+X?=
 =?us-ascii?Q?4NEx8/eNPCRmrmF8g+Q1+Ns3+fjx4U8yJwyMSUZd00pT2j4c7n7n4JYa4HeM?=
 =?us-ascii?Q?cPxA+GKWEMFZNWpO+7/mVeSSPXEgsS5DFuWpltiJvuofFpYx/TxCGeu66X3J?=
 =?us-ascii?Q?nFthGSXTq0ki20yPLRWiFNu92yVxR67YqCAKXGx10zUtuU56vG2CXDV/obPz?=
 =?us-ascii?Q?Un1cRJNttVpn1qiqb4wT5l5bfPgUWo2TXmNWnrGy65m/tae3ZjdMQTuIsooM?=
 =?us-ascii?Q?BSnULygsRZeBddoWnEL6YEnJ4Lh6MXQYjqrUQkfMkxlDywZfgUlQ/6e4bhK3?=
 =?us-ascii?Q?7GWvWxRH67kJ4bHPcnlBfwAFo23uFyPKXjsi6Y0v1QJNjgsyJWLPQcC66aCR?=
 =?us-ascii?Q?HfcRtG1bthUwsV3qeOdmeAHcUiLpuEVkz9gHQsSmhY6Pjgi3h6WcENGWOd99?=
 =?us-ascii?Q?aTN7o0GE6BZmOehYbVWfm13dTQN9ifRgZWnM9aQAlfHEZmyLCacCQgs0gSPY?=
 =?us-ascii?Q?ZJVDH+DD18FnO1Q1j4TkaiP+iJcacGIIFWkg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:12:42.0822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c8d0fc-be23-4521-3928-08dd7902ec7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
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

Split out the queue map from the mqd create call and split
out the queue unmap from the mqd destroy call.  This splits
the queue setup and teardown with the actual enablement
in the firmware.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 17 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 10 ----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 2be1e54b78997..c3873041ec942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -263,7 +263,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
+	int r;
 
 	cancel_delayed_work(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -274,12 +277,13 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-
+	uq_funcs = adev->userq_funcs[queue->queue_type];
+	r = uq_funcs->unmap(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
-	return 0;
+	return r;
 }
 
 static int
@@ -364,6 +368,15 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -ENOMEM;
 		goto unlock;
 	}
+
+	r = uq_funcs->map(uq_mgr, queue);
+	if (r) {
+		DRM_ERROR("Failed to map Queue\n");
+		uq_funcs->mqd_destroy(uq_mgr, queue);
+		kfree(queue);
+		goto unlock;
+	}
+
 	args->out.queue_id = qid;
 
 unlock:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index fe6fc3e0a3204..e3c3fc160b799 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -320,13 +320,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_ctx;
 	}
 
-	/* Map userqueue into FW using MES */
-	r = mes_userq_map(uq_mgr, queue);
-	if (r) {
-		DRM_ERROR("Failed to init MQD\n");
-		goto free_ctx;
-	}
-
 	return 0;
 
 free_ctx:
@@ -350,9 +343,6 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 
-	if (queue->queue_active)
-		mes_userq_unmap(uq_mgr, queue);
-
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-- 
2.49.0

