Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EADAC88E7D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E824F10EB9E;
	Tue, 15 Sep 2026 07:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LTofBr3L";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499D210E6E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYIniyJJ3KkGJBIJkGSeSaDn6Q1ub1ENEdPgk6YyDQAtDKAc56tV+sGswAbrH3VUdAXY00emlcj4i3XqoT3vnFrfK/3/Y0ahS/2Decqp11a8hjSB/Wf4MZDNSNoe6EWHRCL+g7GqwtR5Z/dJP1/VjJp7ilQ6GoId0I75+7MH314sXeNAQ4lS9H2ZeErTnw2NwDkaCYxtadX0wEdOWe/Yt9H3nbKLShk3GwX6Fmnd18MjJoIuO4hrn5czHqrCRtEdDycHlsoalH5dEsMDqK4oUWDH7WpN1dWwk+zuD9pTnF6S5XwCHsNnRzPZWGtDC2E2oSJ45kdCBaKxWtoD5Q+QjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24xvyT2/3losxCu+ZYviQRSJ/C6E8mC2V84Nt7HnXO4=;
 b=xdfVrVYO56JPwpSWKqgDWPfWG8q+8ls9fhEttiYpsypQ4MH1FFzOS2SAu+QTbThL8hTgKFSbX7ivDIKdZffJdqKZjI9sNHXzC7YhYVaiqy929PEkaPDtiZSNzOX9Qw7obuKzfVAdPIIUIVRFMxv6IeKnCQA0cGE5wwNkxloIEuUE636HE52D6D/POam+NW1lvXepGKWKbZp3wSjZNGRSnwoYZjsS1zC4OxSyx8tTcVGErv2qbTUzcc/zaXashshIm2Fc+QVF/634ROIvtkq4yd9iNot/V1/b/qUyaP+e6hpz5shBYUkj/XmNJ3Nsgj9eKFq0h0OMv9THJpHn7Q6zxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24xvyT2/3losxCu+ZYviQRSJ/C6E8mC2V84Nt7HnXO4=;
 b=LTofBr3LI39HfX8Kkdp4uM1ZV9VdLzfn9/wuIJwu+u0He/3hFM950vJNNLRxXhtXAg0BH+5ft+kyiUR/SH5f+b2j43H46SvGmjVX4dMV70x0ABZD0Z+6DSJC6VQkEG/fJ1em6Kf5Skf21+jVaretGJeyGThnkRlW64fcrxGmOlg=
Received: from CH0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:610:e7::25)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:20:02 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::4e) by CH0PR03CA0230.outlook.office365.com
 (2603:10b6:610:e7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 07:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:20:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:19:58 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH v2 2/5] drm/amdgpu/userq: implement support for query status
Date: Tue, 15 Sep 2026 15:19:43 +0800
Message-ID: <20260915071946.710846-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915071946.710846-1-Prike.Liang@amd.com>
References: <20260915071946.710846-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7573c9dc-a19d-47b1-3ae4-08df12f9c212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|18002099003|10067099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: loP0ch5s3WJRybiGFidxGbjNvFcjJBNwDbM5wJhO3pFfcR8Vel3WxVW1LiPHzn2QbFdvjj6mofE2luaKWrTi+XRNwWTgY80+uKlLWrCZyTWMQIY3RDpW3Y4Z8n6x1wBl+97cA0X844hzy95buQtSifJvBTuv7eyuGdCTB/qXw7yqhHvWs+GN0ysCv7qiJO/tz+L8YGF7bkY7pt0YhSE1mDgHAVscCpgCCJqFr0hOpzDZ2d7bn9NQ5NXI2o28d+qddoIyQmpp8X+lzY4Bpb0QOxVuRzVqSByf27H87RCoyqC0BOxPGXsUmlg4u6kS0THFB+OoDF0+pux5ZeHUcus3CjxGiysPB8qaESrPkSocaPm1IdQepcV2kODfL+h2c4XI3SHr3XWHZ0PwEAKWJOnXhV0/Eb72FHsWy5IBER0uddmD1vio2fkO+B9ijBRYswVWiJJqqy8GtT+/35EPexRDGQT/VaTo/1RJNuqpoP6PTLQB4ByThlrYKu3D2fHOiiN1pAcvbUfJo/Exl6K2oiELJdyS8Rp62VWBI/JTtYuQfJcitKhX4N4kDs8mMsxPA+HfKbczLA/NFXRyKmg/St9e4olLq+QdNOLdOs5e2/8szet3q71JpaEnLxdgCvpJZn8DheBfzb+2p4Lk/gU1W3oj7llEDmEN3uavijotgYkIsNHIOmLVrfY8T5rMNYGBO0Wgc+m9PidighsH+BMwVYjyZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(18002099003)(10067099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E6F664wbk8hVUxriJSd0tpOe/4XRmWtdMnZEy7bhxiLt5rr7w0SR9elRfj1DDCphFTR82kqV4yJV7TCCe2JaTTOdxZ6G3Xy2OTHl08oZ6A2MsMnr7Bg5tfBxP8xtJjnKn0cnyl1M4dyY3eVmOfUfuDwTFy0Y89JDSCtyAaJMZWEx7XNzOj4NK27lVDP6e4Zm9f0XCzPBemkMmxUIBdmHEIt9mCI0Z+QV2z68iWPv5OQgi+uwhMF2Ew1i1plKXvQZlhfKFE3x+ebnOjW0Ekawxos76cnEBCRK1QxL5SLERg0vjcDyrxXoptiGeYqNHK2IGO3OcaV/rNb1sBLHFdwZ8ocMImnCAEFJHqu6YNmV9f/ioDzkejJxnNicMiib+Zehlqipsz3okIDTsL8LK9u0Jti8xOvDsYDFLobbiBhtkDncFbVA/vVI0a76lnLCb8xF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:20:02.1615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7573c9dc-a19d-47b1-3ae4-08df12f9c212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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

Query the status of the user queue, currently whether
the queue is hung and whether or not VRAM is lost.

v2: Misc cleanups

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3938f7b8ec4b..1be5e70dd4e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -692,6 +692,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv->xcp_id : 0;
 	queue->userq_mgr = uq_mgr;
@@ -812,6 +813,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
+static int
+amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id = args->in.queue_id;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userq_get(uq_mgr, queue_id);
+	if (!queue) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	amdgpu_userq_put(queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -933,6 +962,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_dbg_driver(dev, "Failed to query usermode queue status\n");
+		break;
+
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..40228c60a1ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -79,6 +79,7 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	uint64_t		generation;
 	struct dentry		*debugfs_queue;
 
 	/**
-- 
2.34.1

