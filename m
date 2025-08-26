Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0622CA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A9B110E5F2;
	Tue, 26 Aug 2025 07:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KO4WfuJN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70DCE10E5F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3jK3Cfw5BwRimZTRcqIz8DgszVGYFwtpJUbEN/DCpmK+foXdkv7UnU4i8+aZ28AD7DjxS3m/DXlLUBLXAUclrY46BT+lZRjYHQj0+4pzRVChLpfVYzzXyLf5pffYhltBYUiLYUzpLGsCs0U/djuoS2zixFiPqw1Ml+OCL7cXBUgWsHGT43SvX2F0+lp3fbkP/rqWs6Kz+GJtBT/sbKG4kfO4zA1z9t6D0yzMB2UuR7JUwLPVeXU3HFql3mokyzFRLa7Vy8PRQd2BZXYM8Lwsnld5MxhC4sTvHFOXA1wdppEgUl8vRiltgHwnZ3FiI4sloFzTDSVjqIGKxLks9HHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSQ0a4aaCk2NnsvLTWBBiYeJ4AXZFSRj/haAyPo/oxA=;
 b=Y643NLa0Bz/Zsunfv4SdVC04hzb1TwnZE9CZDSaIgl4Om5Z2JXGoSRlACq3la0v9riKrEsIwBlBmR50skQ2pW9xaz+my4BcUvUKc4UJFToL0pfiiX01FShdMAT7Vk8F6RNxytxtRmuHxSyvUWQ5nibZxr9YzrCYmGM7oLtgDi0bz3dGwsiu6teG1hBBbelYbfQYbKSvrAhUy7jP2gph2m2DLNQDgBtem8+3szgoEZG70EB64DTuNvgX6wDfkOp64/Jv2tyR3HuJxhDze6t1HuPo5ofs9WoSP2r5USFaxgfN8sl8CzbsqTEQLweR7ULP7TCCfP6k3W/R0OX2jqioqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSQ0a4aaCk2NnsvLTWBBiYeJ4AXZFSRj/haAyPo/oxA=;
 b=KO4WfuJNKa4du0Xf9kDLrFB2EC6hqXqoHBy7/4Kg5cPN84nXoXK0c7OWZfJc8XC8RZQv/6+NkleqQ0eeRZ0OSYNWuzZ20R200QSx6StZ3tqg+UStiJzDID0T1BamgEayMGqyN8o2BfMZY/d2LmXZ1aPYjM9o2H3ZZY/fGize/Fo=
Received: from BN8PR04CA0017.namprd04.prod.outlook.com (2603:10b6:408:70::30)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 26 Aug
 2025 07:47:07 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::93) by BN8PR04CA0017.outlook.office365.com
 (2603:10b6:408:70::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.23 via Frontend Transport; Tue,
 26 Aug 2025 07:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:07 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v9 04/14] drm/amdgpu/userq: implement support for query status
Date: Tue, 26 Aug 2025 15:46:36 +0800
Message-ID: <20250826074646.1775241-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b50a12-911d-40ec-0490-08dde474c18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tHcFYBkBB2NyrHSdsahQspf4Uwj5xngvXSpOPA9LkU/4DnIaFwD1AujjEt8t?=
 =?us-ascii?Q?fl9EiU3Y+A5YHs/xzoi9mKfblv5jjGCxQfzhWW8AOJnfsAkVcGSjjnggzsb8?=
 =?us-ascii?Q?CgdP2sxO7f7IB4zcm0JGLnkxJe2ShZAdR2/aPX80TUsFBPcMMyvqUj6d9aiL?=
 =?us-ascii?Q?JwF3Os8mB+8wxs/zkgXcfx8l3SqD67VCPgHqCh9lqtXuPQJje1OMk6V3G2kr?=
 =?us-ascii?Q?2rkSzYNseOk7MIqNFAzIlZKzJ5UxNSzLcUtG1/IxSsTmR/x5kmkJ20gVT6PH?=
 =?us-ascii?Q?hTYSNcZO4Zys3il99PVuQ2Q2FTrNdbaOSjdnByHGx8tLBYXA4QKY/gVF+osa?=
 =?us-ascii?Q?rYKlmlA5T1x/aEJOZQjTrsSF4fP9eEye0uSoGX5O7Z+4oPyYpvXsPqbfSHkd?=
 =?us-ascii?Q?g5VLBnI48aBCW32A828ik0Ab59s4rTdtpIY1NuvMpccsJgpmamEkONWVDpNq?=
 =?us-ascii?Q?dhuv5e8R6KJsMQfSD3bANVwRm1eNTf8/Njn0EES7fwMl/ofEftLak2uEHn/D?=
 =?us-ascii?Q?l6I9ky4V4DyyaxmArGN81gtfed+B7YxaG849U3JwLRiV+NMgftXhkKlRSB44?=
 =?us-ascii?Q?QPRbuZGqO6eklGYExCcds2SBsWEaqEaA9zy9ddNQ6ebNIRdQz5Rwz6yWOICN?=
 =?us-ascii?Q?iTpvgdcPsCIoLCm6oD3d6ViDc6iuIjQdS1wxHGHOotnJ1HdZQUVPwOFsGFIx?=
 =?us-ascii?Q?DCAQSkNCHoC3MBitiMlWNXxf4TNcksePEYw67oNGpGLpSC0VCEGHEmWEUINT?=
 =?us-ascii?Q?fKWp88H4Rw/TsS4k60DoFFmESoDxb4fIBHGCKSADDxnCNyJZUguQ1y/XuotT?=
 =?us-ascii?Q?y4kcbCHkrvKYNt0xbweO3ABdS4fmbIKXFqvAqHQJGQD8eXVxPhsDN2NBWMRq?=
 =?us-ascii?Q?IOtJ53je7ed2hDxjWLF92k9mm/hR65MwO91QLgtyAwHi9sx6TBJuzMpVMwav?=
 =?us-ascii?Q?3u2qFlScikZMbjaWZWiJpWK4HxVTKNzQBhVO59zWvlh8Fy74i+2a8DKrejC9?=
 =?us-ascii?Q?yvc7SbP/QZgWklVP1sGbbktZNfXmk3vbudVQx08ngIXE2wV9xOfMMi5Yptut?=
 =?us-ascii?Q?Rn3+0TEhvk2Icah+FliVsE3b7GBasUrPIelVCLkvaN/GL9C88nJgJYkq+0MA?=
 =?us-ascii?Q?Oy+jK8K1rE5yE0hbGfajB0t4cX7QeQCgvyfYvH6HghNBK4g0ZBBQnA6/Wy5K?=
 =?us-ascii?Q?j4U6Jj+UAABce4GwV2eibrLi7x+LeBxZA+LSTqne7IE51un+ReaMWeq61oPM?=
 =?us-ascii?Q?yxinmbGBnSsTQoGl1tNxavQaOxqMBxt5j0HYaYeVXuW8X3TSKq6qFnwORn9U?=
 =?us-ascii?Q?l7s92xiLhOg+DeO/FGmmggErrw6UAWOqxhzJrJfg5Bkm/UNbLQBV8qMYiFhN?=
 =?us-ascii?Q?GQmRBqvx59l2xny27iASqxId0fMQQ1DUd/JhzJUfhE9uikfmiHEY/Nbz8aYu?=
 =?us-ascii?Q?gg9s0uql6TIikfOqrRSo+Feg9/8omxLIaw68WnRVKXwsUjeQQVCwVkKudEOW?=
 =?us-ascii?Q?A4yKcsUzBNTvES2cG/ohCGYkQ6Iaml2w+y+c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:07.0693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b50a12-911d-40ec-0490-08dde474c18e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

