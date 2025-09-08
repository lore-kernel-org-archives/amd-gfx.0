Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ECBCAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF5D10E47C;
	Mon,  8 Sep 2025 08:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WsoIrS8V";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0448110E47C
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cakEpFNHuII7fOjI/oKinhvWhwILdM4/MAqMBR/If/WvaLyxoHIHQp3UQzgO/Oo2pagq2+2P4VlEyqa9GOJf6PdodE+nrt6L+HMkom67UUqe70mJ+Lx5tUd9VP8bHQbAlLEDWfjwSRkkDjj5XhiToDddWqqdOkR6xdCWid0j8/IDxXkYHMTAsr6tkffx6qMo/VKeWSaoaN7+Nby4Sep8/vC6GJg9zJp6Dnc9ZKbCY0BXgnsRYppCNsR8s5ybM6DmzwYayeL0NLyWthnM+d2cTci5SoaUXOOO1JYhOYgjdeAi3fOkmHlmjx19e3zvLexeP4hXpUzcloadZqH/eUFXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSQ0a4aaCk2NnsvLTWBBiYeJ4AXZFSRj/haAyPo/oxA=;
 b=NYlonnelsOuNBgxCA2eVurxtGcgERmWroLgT1Wof6S/hF8NkxxSLHYTBkQk1sNfJMTYvCYS0DtBuqPmHJXpg0F6Oz2kEcsRzJ21OFDNaBtJXIJoPc06Am8KvxK3XiMDSBFHdU0jecE1/HvxXMaSMDUBibT+dODyzfsMIgNd8om9Z/QZdgHW6F8CmdfasvBycXxSswx5JNIO4YB9z1oYaPkowmRlAETxKfew0yBxXEnNXrZfez106sYD1hVg2PiFyE+PoNTTk6xBQa+4Oyk7SSWT0llbLjQ/kth76TaHExXWcNxDfF/eyWS+ungqF5XR/mRja2S7Tbtm8z9RQKpM8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSQ0a4aaCk2NnsvLTWBBiYeJ4AXZFSRj/haAyPo/oxA=;
 b=WsoIrS8VZoxqdTc6lmcUwjg6am+LO6eCyhXaal80L/FZpW/w5D8xgeoTPQ/TehxbqgFKcjLAg2xNLxV1lcTO5MgEV4uKICNsO48moK96g/dIKj9zHtmNKCFAfdgK4VDw8xFUV1u+6ELntPnWMdUzc27Hm03l7Z7CdPLseteWHcM=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:15 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::9e) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:04 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v10 04/14] drm/amdgpu/userq: implement support for query status
Date: Mon, 8 Sep 2025 16:48:36 +0800
Message-ID: <20250908084846.1873894-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 52bf2dfb-97b9-4843-6708-08ddeeb4968c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MP6OmbjSN2zzu4qYF4xTYd5t53i2grd4VoOSjyAedJqq/ql15HVU5jCSmWCA?=
 =?us-ascii?Q?qnWv9WimrPN3njSbajCN3CQo0sFuVYLfDCbZ5owqDy94WnzoC7oiNrA6owz0?=
 =?us-ascii?Q?hmdTP8xI9LBDJrTa+Ej6AD0jY3T51HUQpS0Hhunh3OiSO1RQeRx/MoMOwo5T?=
 =?us-ascii?Q?Of1pSmE6Mmlb1J3Q3QGZAGB1q2VVEEonhon2+MWfFalo2vhpaPprb2rS5Vf5?=
 =?us-ascii?Q?TwqflvluNELqcRuLSBiNuzdpJvlpKMhlIWWV2FXCCxy3fLYc1u7+AfC2NCD3?=
 =?us-ascii?Q?E2+/lVmUZE+DXH2g/WZwt2O7dfTSpbSpCvXaNVuS7qeOVQ/jqSWj9T9b9GvZ?=
 =?us-ascii?Q?IkVSA5SArypUSbVJ110VJ9DzZEd47oihgptGpMhgswQrRIStSai1BNVichlU?=
 =?us-ascii?Q?WzWqYiH/5aSpFEe4EIwmsKKcmzNhCTHDD0KtzFfM68fFnwZBip9RCp2OCjd9?=
 =?us-ascii?Q?zdGQ7TNlnrcSQ3CDpkLLMK7ytl4JwuyR47LHZLYhIuru6Z0PZiQF/6pjofkG?=
 =?us-ascii?Q?nQO+SD23lf/QW/HKA066mCJGjjHxRrhRjyXVKbaFOukzm7sxzAD3MdTfr06T?=
 =?us-ascii?Q?o1lOTtRW89rWTQ91xniNTxqAY5a4BSa/hPLeLq07k/btymZkTCeD+0BSj/01?=
 =?us-ascii?Q?m7OcmNYIft8+wcD5R3PH1rvthRRqwdlV7b1mKMVNODHi0OumCCS+a8x+RqTC?=
 =?us-ascii?Q?f02Nu5vDPLUi/9zed36L+3e61wh/YMe4C4QLGEp2VhHRaFoPYZ0Tr5viDgLf?=
 =?us-ascii?Q?hozXFtVuwCO8Fw/8pbtDH8pLl3wQTsWfmc2KG+zuETxknaVJnMvKmQ8GGEzb?=
 =?us-ascii?Q?gzUFsA0qRf7ZRV9Daaomb92EDVknmU31KgHJ4/0DWH6v0pz4p3zgmFmNDWWc?=
 =?us-ascii?Q?Rnm1qS3GUdaxnVhoaZKK28st9WSUepqbSklshgvUG1B+545WrgwNiofzzgJY?=
 =?us-ascii?Q?7XH3/BFrIDUI+jKU5o+LEW+FlskzrcQJNGcf8edt4llrLaZDXSy69YitDdX3?=
 =?us-ascii?Q?ANzJ+kJfJ7LckRIvxdv7EmFpQr/oc4reTfQUzGZsM2c5yzLDlR3qy3MFGaMl?=
 =?us-ascii?Q?3EwQG6dWyWUwzRjCjjcMtWP55SkMm9q5RY8sl/03u3vAkIXo6arnAdvlqHjl?=
 =?us-ascii?Q?MJy43wqlhrc/LNuKNnoXDRIavVBjcBm76j6OHfc/sLxzL0bmrUoqe/M4Zjck?=
 =?us-ascii?Q?+wCI3+zV6Zq8hdprJ6ncXx258m8DldWnScVGEPEQYierHfKdlTQ/IeFdsFpk?=
 =?us-ascii?Q?ozsdN2kVpRK3mPj+0BpeWK8+/sxCrbAgWFHididebugb8FXuFJcSi92AM434?=
 =?us-ascii?Q?oUSwTrR4QyYW8fB8YAtAWazgSmYCAiiC6hvGCb7cTbnXg6nBwvUClu5p4DDI?=
 =?us-ascii?Q?fCQxZnz4niBXbs61S22DDbtCZA+xywbV4pmyyBnsYS3vwLvWycqsyGj0MndH?=
 =?us-ascii?Q?EqyUaCTCtJjHB9yzM8uJxKBZrfN5qYCi9ZELC4HOcy7ycggrxcgraB/ivZcA?=
 =?us-ascii?Q?B5BoTsMXCBCOBGwVMfHeNyzdyxxXkNqR27Mh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:14.2886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bf2dfb-97b9-4843-6708-08ddeeb4968c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2b35198608a7..75b7e39ee576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -403,6 +403,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -473,6 +474,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
@@ -554,7 +583,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
index ec040c2fd6c9..48722936ff70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -65,6 +65,7 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

