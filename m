Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504F9D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CEE10E083;
	Wed, 10 Dec 2025 07:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2GrpG56i";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A4C10E083
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdtAoP2PGrwzb9VgTdaMUdyEGlqkGzU5D6v2p6q36ufpEJTh9Jfe534wn2bUq5ikHaOlvY8nTcyZX7yqwHD6BdKon+pQMVRzEzg1jQMXqQBtpRvJM2qKMq5c0NYGTMcLSLbYnQO9hUEtoCdUv3UY7qrsXlNDkpo61WitGKeo8KwAncwrNfTULaW4IjgaAke4CaLv0ZUjkkqToBHvT9SBz+1nMOPg9wKcPp8XCbV7KAUJ2FSQgXzD+7N8TLbG8kHpn8xfVSehL15nbex+f4IPjC9+et+E2/JuK7wnd+thnw7NggSrcPnWYMjMYgqA+FUCV11QSxTvnz0zLEnK86Id6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucnaSE5whVC++DrNZUDpawhp20WyOaKbGRDxYqAy394=;
 b=Fd0DB9o5RKYPB/pLS1tyJc5nBlPKz2czCYcAcMxzEizXERj2Ph0IeMV9ZxZcJpTCZkCKg06H4MA7lV5tAaSZGPXzohYRuXxqmp59mGw7EuqtcgNCA2y0ixdqGkoMkQyJZlKe91j6x3egozXuEljSq199J1h9l1USiNyC7tjojPPbFnCtql4eTIqO7HS4BbKi/7BhDBnVBzY8Oa/LAcyQcbVlXcSC7/4wuep2f1CJKDtMQCy+9TZgAlnPwYDtdyp0TP8LbFMxAeIKtOMxZK1eSFpljsv4G4hO5TJXawOrPrVloMcqcPrzN4rlKA9JR6K1Y/HreM1v3x7zFWYdHTG+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucnaSE5whVC++DrNZUDpawhp20WyOaKbGRDxYqAy394=;
 b=2GrpG56idbPJcT51t4ZE3qfEAMYjqQEq1dUEd9HasNO7xTgB4qQwC/8h6kKR7SDWB3flbHppgYa20ii2Eq40J1H/+vxqUY6Q3rz4x1BtCn39ybK+m3GuLH00tTh6VTkSjvXF1zw76abf2n/deIsqpT4EAiU6Oj6F5wiUF1VGLTc=
Received: from SJ0PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:33f::23)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:12:47 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::c5) by SJ0PR05CA0048.outlook.office365.com
 (2603:10b6:a03:33f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via Frontend Transport; Wed,
 10 Dec 2025 07:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 07:12:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:12:44 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu/userq: implement support for query
 status"
Date: Wed, 10 Dec 2025 15:12:34 +0800
Message-ID: <20251210071235.510182-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: b27ad615-39de-4572-6286-08de37bb8525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SuNaY2mBuM7BZpTAH3LpjfY6wEcxnwqQYZSin7CL4oyaWB4VI7Kf3c5n5W30?=
 =?us-ascii?Q?S/i8TGMzxDMuH14HU6AHh7V8Dp+krEsIQeqDKn4OToFhdFOyjJfZjIhAxAb1?=
 =?us-ascii?Q?vFPHW7MDfVxzcdSaF8dp7lSLumV6gnHUl2Ou7zWZiyymJ3bvFuDxSouPNO7t?=
 =?us-ascii?Q?jR4q5Q8HJhOI2UTu3VXLYlc+hUj9g4XNitHrlUIy600L1Z5bXqOaP+sZ8Lvp?=
 =?us-ascii?Q?nx55oImPmySuA2RgoIaGg0PT/Pbo1zemtLBA3IH6o2Vysdim1prrEn0nZhOx?=
 =?us-ascii?Q?9WVG6/ItPOpKXGvQR918ODUbQvsFHrXDJSmadujyUMyNyfK716ldIBk0G4b2?=
 =?us-ascii?Q?rtkKNmEc5065P90CrnHyOvfa2GhzhxdFLSDPFXKHlek0n5PcRXLaVVeYTNVP?=
 =?us-ascii?Q?4ERmp+QrutpgBGaUwTZUsepZuIS/skXGTh4/5C4qnxnm7mE7R6t10WZafoZB?=
 =?us-ascii?Q?Y2xcIvlJtPfJqLzUWsiX57CbOk2YbYJG5OFy8cKzff++EwNrOULnAHEoeOFK?=
 =?us-ascii?Q?VT/EtLajgijvY/wMZl0gpyu3DxLANjDF4bWk3bPcxSbsydBG+UE+3ktiEdfS?=
 =?us-ascii?Q?rzYYO/3+9LI52NWfg/cOt67Bylex6pjExa87usfis8jZuO0rR40a663Kc3i8?=
 =?us-ascii?Q?/M9PZp2fWILbUiemz6CH8ZDRiPHhCoKzK+FKwf1idDLwa9x5FLAt9qkIN0fF?=
 =?us-ascii?Q?E0JT304XvzPgCZK2KyattPDzl6TdRJycZHSagsQ6IROpSPZawkhRPuFjGFqe?=
 =?us-ascii?Q?o8wUmqklqUMvPXbM7kcTjq+YEKzAgSLWVZL3qt4HAACQnHBwtMGpDKEKyt2w?=
 =?us-ascii?Q?M/rpOm7vTCyYqYR1TC2istAydfYRLPbJA+dIBpMuBpjJuf7VfhQL69tCohrj?=
 =?us-ascii?Q?fBXrbizScxVRUMRpJjH1/gJMfLL23l3mBWK9FJYDSaOtHk53iqwcqYgIld9k?=
 =?us-ascii?Q?AWg+HlAs6pn1ZRS2C86wMyrlIZ0b5RLzB8e4IwQDWvODHKJicSEsv/VedlOm?=
 =?us-ascii?Q?RN5r00OfBCP8ReaFjtPJJSHhlL8mQbjQF8vA2ul6D8bab6998/aHsjsbM0br?=
 =?us-ascii?Q?7OzEU9RlDrp3Vn/byOSbjc0Tlwuh+zFDl3Vbatb/ZbWRR4TAk6brnOc0+rEa?=
 =?us-ascii?Q?egwyI/kpnIQQPJtfJ5cv2xnyEYBG5KgYqe0XMbGCuMRTnLtWYAUt4ppB1vhJ?=
 =?us-ascii?Q?pJgXiowdEZETRDolCGdbcX43jnIi7uyPCTM9BfxIq/hP1XBbyk1hsuERgW9b?=
 =?us-ascii?Q?TKm6l1u64trRhSyxh+h6Ov58qI/K3NZdpPcJXf4JlmGpEcH6yxNXEnJbCRT+?=
 =?us-ascii?Q?eWRGLpnvz2NdXcKQjrSseRYkHom6DeoCy/vzXZoxQ9VKL/ag9GVynlsUOD/w?=
 =?us-ascii?Q?kFkRq6HMWY80RRYW9fi/6rq6bzPwrWskPdo5CxQ2OyjE308Bx5usXv3Jy9Xx?=
 =?us-ascii?Q?e4RDzq6U6aM8sBH6vit4hEGCpvgO4ei2dUXhxSAOeC8RS+lniVBNP8jTYbfu?=
 =?us-ascii?Q?H95W5fwcRm2jgppQSycu8LoW8pImH7CwxmkqbsgHYKYngdMzJ2itPZUnW/aY?=
 =?us-ascii?Q?/r9UGjVvDL8djPEfWtg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:12:46.4074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27ad615-39de-4572-6286-08de37bb8525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

This reverts commit 4784bc14c0977d1c23c182c60c172f72025880ba.

Hold this patch untill the mesa implements the AMDGPU_USERQ_OP_QUERY_STATUS.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 +----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 -
 include/uapi/drm/amdgpu_drm.h             |  2 --
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index bff39dcb4068..2f97f35e0af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -719,7 +719,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
-	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -822,36 +821,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
-static int
-amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
-{
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_device *adev = uq_mgr->adev;
-	struct amdgpu_usermode_queue *queue;
-	int queue_id = args->in.queue_id;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-
-	queue = amdgpu_userq_find(uq_mgr, queue_id);
-	if (!queue) {
-		dev_dbg(adev->dev, "Invalid queue id to query\n");
-		mutex_unlock(&uq_mgr->userq_mutex);
-		return -EINVAL;
-	}
-	args->out_qs.flags = 0;
-	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
-		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
-	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
-		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
-
-	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
-		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
-	mutex_unlock(&uq_mgr->userq_mutex);
-
-	return 0;
-}
-
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -932,11 +901,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			drm_file_err(filp, "Failed to destroy usermode queue\n");
 		break;
-	case AMDGPU_USERQ_OP_QUERY_STATUS:
-		r = amdgpu_userq_query_status(filp, args);
-		if (r)
-			drm_file_err(filp, "Failed to query usermode queue status\n");
-		break;
+
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 670d282ae158..1eaa94f8a291 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -74,7 +74,6 @@ struct amdgpu_usermode_queue {
 	struct dentry		*debugfs_queue;
 
 	struct list_head	userq_va_list;
-	u64		generation;
 };
 
 struct amdgpu_userq_funcs {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1284f026158b..986672e7378c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -352,8 +352,6 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
-/* the invalid userq VA unmapped */
-#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

