Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D01BCAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50B510E962;
	Fri, 19 Sep 2025 08:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I1VGomG1";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6033D10E962
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKhZUNfdBlkkyfh4SU/D7PxJEELxkTH08iGwjsavjxUaNzth+ghEmWccHYfxNK9hTXwRKenBYYxouvnOzUq8JZ24Q3X1DWUlRoakYydvaflMAGL9w9LzFUfCBk/ZYb3bAAEdnsyjSnhDaSoeyRfa3RO0ti0DMZ0lksdqt0uzjrUv1BvZiRNSU9ZfNI1lVOSlBH5eO77wotVS9KbErC40mq3PKjbwEYgN8EP3CQJJHRTWRNAeth5zmpKXxYm4b+wBDiL+5ExbXPCX+FRpx96ME1g7kV9xskowsihVWYhQKT2A/iVFIHKAdp41RAfIgTA1IT5VOazbOq0rd2EVf79prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08Hrcj0eMIbaz7Xky61N6XXh1Mhl2dLzbZ4ZgQTy8qA=;
 b=BkxEPHL2p1WthQV0SUlGNT3GNmNeFf6qjiQWJljPZJwRB8/Oh1mSu/XNUMdXW5VBWgDfDXRXjmYQyMhwjDHpA7xDmVKY3hlMjRb9E/tSiFhaRLnxR/G+MU4GwBJnCpKKXwVAecsfZvTpTWrURdSC4u1efDyuwYYln5ueo2Hg/SeUj9wdDJgh6UhkoQNEtaOAiFeDVcWanfjHPTFtgyCI2k+qmkWFrAbQrY/yawO2hFShT7ncuFdH2rbtK7CjEMTEtGdjomwiOYnqZ6mIxZCaEFYgFs3FXm/Q9+IJLI8ho9xlkaEFj2XuGJWoAJhGBAzN83/qBQ6iIA8FO8w8P+9UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08Hrcj0eMIbaz7Xky61N6XXh1Mhl2dLzbZ4ZgQTy8qA=;
 b=I1VGomG1+OLv9CUnOOXv0aw1Af8llNi0kk6w9kVSDAfPMcnXUkMlPr2Cr0OfUBcT3Xg1vqvUqrnRxd5/tLVOn1aWuxk7PzjHsOLHZxZ3oHUvfmGeFIxuxxGnMlycdBn1bnZ6TYO/o7OqH0Cmz+YqxVniDbabaa+nTwqBKmMHnpA=
Received: from SN7PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:f2::16)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:11:46 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::9c) by SN7PR04CA0011.outlook.office365.com
 (2603:10b6:806:f2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 08:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:45 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:35 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 08/10] drm/amdgpu/userq: implement support for query status
Date: Fri, 19 Sep 2025 16:11:11 +0800
Message-ID: <20250919081113.2797985-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919081113.2797985-1-Prike.Liang@amd.com>
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e23498-8f32-4092-f42d-08ddf7542cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tWFSlV2X/rMnakawUfLbP9SkI8SRO8oYDf/PmZj0A7lVXzBJ3I94Wxjq8o4B?=
 =?us-ascii?Q?tIfNeJnayxLvlX2qXSc9b1j2SjnwiDUSRjnmn6opDWu+Zff4vmZEW4VxpjRw?=
 =?us-ascii?Q?AKBCrjMt5T2IjezJ4Ah2f+YMbpEaaQx1/2fU9VsrBzep7OWYU2Sr1z1eFDT9?=
 =?us-ascii?Q?u/CPhR3uF05WVmHiU9UXgHX/xepxVGgS1yCV4CBxlAboDDUSmK/A7iZVMnaq?=
 =?us-ascii?Q?gZRHjEk4+UYiN/nJDufanzTI6xM/54/R8IxIaK7PBOiqRE82wEk0G84Tj6AN?=
 =?us-ascii?Q?a7cOvQEv5KmoMFUtfGJ+tEZwdvdV/gDeeyPMLM3ZpVkh9nSD4581aLs9btzN?=
 =?us-ascii?Q?5vuMMOx5JJ+/SUmjzDDzZpJZzSQft1HBioJM33rfoSSOch4gXWe8l7xf8b0q?=
 =?us-ascii?Q?GFkQ1q/cz+43fS2lYPnFvo2+EznZljkcjFw1jUD4KSWPibJZv4mhQhuqgAtv?=
 =?us-ascii?Q?1awvMWkMSjx0Ibwp/50mPD1icmKDicX2eDoDv2URMwuvyyrlb+Hk4AGSOTXG?=
 =?us-ascii?Q?+l29TYcWAKbyVfDlfuLrcASoANs0BEfMegI91HV9gBJ/woK7W5vXvsjkKiT2?=
 =?us-ascii?Q?6/7b8xCqRDcQhm1J1ZuIEEEjgYFfue3y+AYv5Maz1pU9H1riKIQVMKpaJ7On?=
 =?us-ascii?Q?OSDc0052Xyd5vkcbbVcz4vFYRutHdqhjyRyjhYQ3v8eovTuwQQzC2XC0YCGB?=
 =?us-ascii?Q?YN+/4L5ntwTxn57IatX2yc1VwlQJmjuy3VfLn8Nyc+KYLGyZEsytE5SyL7eF?=
 =?us-ascii?Q?XjG4KMaesnMlCG+H1CpAugLCYU/yxb2NfFsr9SX0jHn2O7NCXZW84pPo7mpH?=
 =?us-ascii?Q?ewZTG34O1DgYOOdeF2ZQQJTrvzJJKXqNhNG+pqbgk6i86yCHoJBh/YTCH5EL?=
 =?us-ascii?Q?7Nxej9Y1N06FEL15fbNFK7f1NissKAKoEAfYH8jQtFlEwXH9MFCTI19evdnz?=
 =?us-ascii?Q?c6ZVfnLCIHFS5pZhXuZI0deUELmnpu3Oo5L93nvaGfZDBu5U3q0ln8kCbJwy?=
 =?us-ascii?Q?NiivXKBYn6Le0OToavmxKKv2Fkf19qFl4nkPYXqhJWThlLcYRFvWKPpWZ2B5?=
 =?us-ascii?Q?FKxDTZiZc7re1lJTJd56CO35+vbt0MQdacOxvvQ1OFZ2XVDcupeXLIRU1Izf?=
 =?us-ascii?Q?t1uHDLTkoUYlfA3mo4P4v+tlF1qspgGNppYibC3iUvh7sfDQwT4p/Ifk/n57?=
 =?us-ascii?Q?3s0Bn9SlvNHlHLGXk56+vbjc4gifU4pWZIIBFHBZwu6wMDxGcpqrkzux2jwc?=
 =?us-ascii?Q?Ho1AbnVM8berL07gvhktDXkUWFIx5V4Dzl++44ZOS4QzCZce+AxFcqOwhAO9?=
 =?us-ascii?Q?1bENWvNdLECxqGNQ7PfQi2iO6aM98Yv+t7hVzdEyoyLHGURt4SjdMTfreeg5?=
 =?us-ascii?Q?gFwUXqQzJ1lHcCR9lAm/bSCOg6ss40A0boOvTWgqLVxCcT2iUcYAAwAmWt5E?=
 =?us-ascii?Q?Y2n/qD9fvP87YIXMuxxPWlCDYf8aGtLrohllKP57MI2eNILUd5+lJrvJB1yJ?=
 =?us-ascii?Q?tS6No/1vg3jNxx8e2ypqe74EJAvrWlyKB+RZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:45.9684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e23498-8f32-4092-f42d-08ddf7542cfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 224d09019997..8ac7236091fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -610,6 +610,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -699,6 +700,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+	queue = amdgpu_userq_find(uq_mgr, queue_id);
+	if (!queue) {
+		dev_dbg(adev->dev, "Invalid queue id to query\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -779,7 +808,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			drm_file_err(filp, "Failed to destroy usermode queue\n");
 		break;
-
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to query usermode queue status\n");
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 7bbbb5988fc7..e0ca466681f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
 	struct dentry		*debugfs_queue;
 
 	struct list_head	userq_va_list;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

