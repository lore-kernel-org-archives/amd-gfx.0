Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653DFCA9EBD
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 02:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8AD10EB4F;
	Sat, 10 Oct 2026 02:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wG1EaEpr";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0ED010E9E8
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 02:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWCaGpp9t4bkMG8sfw3ljIDGHB0j8Sc0zd+c9rEvRCOVoKojmvmbZmmhs7t2s3RphCDPmIMD+HpzE+6GRugrHKselvxzHnld8u1c96CU+w7unTWKTjSfOHfZj7EdLP3a9JvUJ1eyMHGTxaEfTiZ9uyHFxIsYrlsm+B51+dnATEWOUmDjrYKPAtL0avU/yQYQpJpBvfDtFQzoE67ofLvWmvHOPfQo+Bedhj+VUd95hrpp8THiX9igV2FnhlLcHy0gt/t+xv/oc9U8f0KJW7OkAq+o23Ww39JR3RFEp86NdyK7w7GRvhz+oB1n6PWJFAOZltspE9zkY4Oa4/N0GD0Rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2H7j+KDbD4VU3orNfVGRHLuFdNNOsl4h5v6xdV1t00=;
 b=uF6WXrODGcG1YyxyVtwKd/67uEA35NtDYOK+UZzWnvAOa4QlXfaU/SgRVVfVZEFOeJ23+HrmHdkh8Tot9f6ts7CbonM8BdRMkOpDeYRS3hfXIyKmaHrwp0Z9gA4S2zI356aWyzk9nN/jZqnXR3NeeLgxpa+1EdabUhuNYuWgXHxDD+Uk7cOGfO/PMRWrCWFyQQL8eyltXeEPdd/jI7ZCZJNMqJzn3N37/9LWGHqxnPPPhEFCfR2ycSKsScgr0HqjbuxpUTVZ8L0MxRRMq4qc6L4CYWba7QViovafwDxQkyGnr97fya71TKJUCsE+cvzRlHY7a0fgpXVHwED+VC4/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2H7j+KDbD4VU3orNfVGRHLuFdNNOsl4h5v6xdV1t00=;
 b=wG1EaEprfX6BtdWqF8XdQD/FkN1ii32hx1gR1B0PJP9wibjCVOinBZUxNY4karpKcLQTHk0fqIEdGwI4taL3xj+Kby2uZ/TIDm+ES85muVAOnTSYFDJOTkSx8bB4ZfAZPu8Uc1wcwe9lAwP7c24/FQRzFg/MT1yp49wsy11WFdU=
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 02:50:38 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::2b) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.3 via Frontend Transport; Sat, 10
 Oct 2026 02:50:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 02:50:38 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 21:50:30 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH v4 2/4] drm/amdgpu/userq: implement support for query status
Date: Sat, 10 Oct 2026 10:50:22 +0800
Message-ID: <20261010025024.2453900-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010025024.2453900-1-Prike.Liang@amd.com>
References: <20261010025024.2453900-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac3f8c7-6305-4ad5-2f0d-08df267943e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|261009223027099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rdctZvjvdj6jXGgPHGC+XXOFhF+l4+ATYB+NpKokskwTs9F+XnNLZF+7m65adL3lFyOfTUFttMiKk2FZuWnpJmY3zl3JJdh8UOpYbeH/T8K4mvU9FP6Wn9/u7XaURv6HZtvT8dClcP0Umz0Hf9KKARHnQGqN2hL8SkqNR0tQNq/tF9SGqW+WQCp0W2J/VonhftQWeagEQa5sUpnxXufNTJuR/1EqpjCJ1THlaas0k1uV/nXp2iimeDDFz0DQgk3ujHmD7h2KneDM6wFfLQy+AGKlWhfCU6wwLSF48VjAv/K3uCvzMXNR71W5vkkAPtnmM/rwEB5DpS2L3W+p4QxZoPDyPqft5TU4JyISbJIgUSdybQFzMBxjAU3UGwNydBP0CaS7+gz1cr9n2I+F2BmXO49H7abq75UdUpLSaHaMx62wfyPpwjt+7vU2PK39M9PlYN3V3UMEmJ48g7r+4AmMItW5LvzHvQnh6T/hrfGtzZiZ5kFFbFb5EEnN44Rz6ghLAPbLbZCh4sjP/PEPqGidhgX1FaNBUWInB/of5yt1606inI6cCU4NLfzSEBG5RaMVXXZHqH9+CaYaoYEZbfb2OCp4ZwWCRU60YMGqrHErgOQk55ZowMbfCHHq7SLFfQbsx9aj3nzrsGiNWwU+DXfCmYjAWekCGu/iKe04c/0SVQRlWsnAH5VIW5aTAiqNuwTvJCMXsxwiWsDxybG5Sbh+7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eWcWhKcyJ7pjqbSllNeXODD+BIXd8vIUXAA2GLvYvPueDVNgImtyH609AdT6ytSYQV8Ofsp6MrkXfn/Yf6zY99QWo9DJT/iAYAjXwWMrqb7ii3ledRM1w+Udu5KkkvYrbewCG0kZbU86qH7MyEeMSKtV6rfLqT4nCtFqdhMYYZyKTuGjmEI1GtK8EKw2q+2u63FCl84oDz2JSTeyQDonpMhewtRkA415d4FwmWGr3MtGemmQFe7S+BOYbar+8VOsCgzgyYAIqfGkkHzYtpdiwb2aaSdolGKhJzbCTxNKW655mp+EN/Fw7U+6yhdx/rOwCddsVbjVgRfXnilwx9FCsANCNNhS04/Lu+pA8d9qwuxX7xzRaYrJCpJzPBYA8Rcn7v+J3V3D8AI8gJLSfDQbg8Y4XDM9WkXUzYcS7jA8Hxjhvg1AJBgNc8olrERMXccd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:50:38.0576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac3f8c7-6305-4ad5-2f0d-08df267943e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

Query the status of the user queue. Report BROKEN when the queue is hung
or its VM generation indicates that VRAM has been lost.

v2: Misc cleanups

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 34 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75d5ceaa53c6..b99fd7acdc1b 100644
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
@@ -812,6 +813,33 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
+	    queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
+	amdgpu_userq_put(queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -933,6 +961,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
index 488dc21d7c81..d1a2e2a45861 100644
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

