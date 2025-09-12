Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED32CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDD810E43C;
	Fri, 12 Sep 2025 05:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OIQ0vmn1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA8F10E43B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 05:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUd0VyFyjOaqJ8PZQy9oNMxRvzHWdGBRnckhntZhn9jlrx2H2+p+6V0hiE9B/uFVCtKPcmWry8Xg1PJ6GYAUQenblZ53RjAp8VUz2l/iYdjOC5pVsJ/03EkakJQjU+WG6HW3MPGq5zHPBAXf+Zm1uXEKStRKyHbBbHoXUV9nFuFZcog9XiZtVE1SudqjIP8AgPMfAKjUXJD6flyRYkMhuGACr3em1nrNBxb0gqON6q1UqaBq8qAydZCcTv6hGDFLwvLEIyDWSi2sp6Ql0IzI9kzLEWdqe0hliE0iVKBVxypYAgyi0/qVxr4NOxwu3xN2YOhnSAonRg6P9oaC8akbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N38+9NtvhBuUbllgf1dUdOAf04Po+Xm2COeJSffREo=;
 b=cdFsWogh1SmEssuw68WM12eBgTDYmWvgfOvfTl/v1J0Lk3RLei4B1chBP2WbglHcrfDAW81e113Q1kvI6b973BzoETHTOEtG5xg0JeQDUl7mlp3ZWsWTvO1qOWqZcmb4kh3n5kygF8exL6xsEqEDZfnEN7/XIndOxyoK4dtAFr9n5JBsS4s/OwwNBAJdGQptM1FCiDmKkHnr9ia34QmL7LDRyCu1yaN6xb6PheBABYD37gB38jsgaO8R/gYV5S5xPZjyfGFyfZ9oguBPBnfoUx6ELnGDBtKv2IHAGvHmrPBRKAFXuB7MWoA5eYdpQruNi6B5eYZL72xMKSu+uMh1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N38+9NtvhBuUbllgf1dUdOAf04Po+Xm2COeJSffREo=;
 b=OIQ0vmn11HU75uj/pBpHXnR5EQLdTvySVyOqDTi4Xml4OBhIRg/g7Sic+h1f/NEfr2tRrIMr/rTGiIOOiHMTtlvJEDhsTgtkMdhjaW+azBm74jzQw6fPt73EH21PUoegchQn5b0JDHuEO8t4U47VguE1NGjEQU8q0bKIZNWIJkM=
Received: from BN9PR03CA0720.namprd03.prod.outlook.com (2603:10b6:408:ef::35)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:55:32 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::e9) by BN9PR03CA0720.outlook.office365.com
 (2603:10b6:408:ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 05:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 05:55:31 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:55:30 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v2 2/9] drm/amdgpu/userq: implement support for query status
Date: Fri, 12 Sep 2025 13:55:11 +0800
Message-ID: <20250912055518.2719533-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912055518.2719533-1-Prike.Liang@amd.com>
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 40574c5f-6790-49fc-482c-08ddf1c0fc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l4jONfx8LSsBIVuWLuqaqiuTe0HUByP+LX/0vUI8kXiaeiI3I3xfnNuOeNpq?=
 =?us-ascii?Q?zcwwnyVdQsCyVh1RzjfphWJgh/OezGslAT1b08qR0tH/A3RczZEiNGCdRsLu?=
 =?us-ascii?Q?+uQRCYl0quy8gIDP5jKyq+HkpOZM5hgiD8S2SYA6AMIVDeoNLgc65J1+9/hR?=
 =?us-ascii?Q?wxexgM8fmniQ0T5vDhHQadNo5JjLsfUcpEcvHysrVlNpsxF3T0HSw+kkzugC?=
 =?us-ascii?Q?EoQehVbLhwvBYhkZDrIP6Ify6bGoS522WDX2+6dZHA5I6aOpVm9TDLYRHLZ8?=
 =?us-ascii?Q?j6h9pzq8MUjew0nRG3dzJAMSW46Y9Bu/Q9tbPikjpr2rp/rpxUUGyTZXaRiq?=
 =?us-ascii?Q?yojJq2CAZ9tue5GQr9t4lDPHVNuyKQWnfsq/Qg3JQAaXcjK85DT+MhUGQBDj?=
 =?us-ascii?Q?5aDbygOw4FwTmz+Xo8FZ5qRIbR6AJ8/4ioCuvDVOT/xW220BjWw3pjhULBfA?=
 =?us-ascii?Q?qM7spQIA8FrgUmvZ5Am8+vtBK03ws4dDbp2ah2y403Iis+o2BlyhMVQuG3PQ?=
 =?us-ascii?Q?677/6/EgeBZyl39LRUgrqBiAALptZzIcDLZMi7co48hn8C1EXCJfBnGfF2da?=
 =?us-ascii?Q?KWGWNKTQEJ5YDopDLVeVtdf680aSCBqBJlGDeSZHQV7ENM2MlyHAJm6s2PO8?=
 =?us-ascii?Q?zwdVfGMtWBeE906jvNtpi4jf+aOwb2tQQwu6crWBAK96uosQa0AwWmul5Qdy?=
 =?us-ascii?Q?Lj3IJi8we4/MLQ8YWoIqoNm7rMecv+daGwRj4YxnLf4OsGzqUD6ONOGtX5pQ?=
 =?us-ascii?Q?S/S35VRskuQFsD/uDASdbxba9+tUuHimeaBqGyfi9UYkhtLJTWAze5Z6r8Lz?=
 =?us-ascii?Q?dJJ5AuGlLtnamTrUpPsRpg+OwpkkaHQtE+LBZ/grPszRtD5YrNMUJvVYJGIz?=
 =?us-ascii?Q?t1kF5hp1nR+jlXQEe5RBRG/bZN7IQi6pmGRbkaLUIiG1lzUq8ng5DilnsxQl?=
 =?us-ascii?Q?FjToanmi76HdmB36+OIeKpI+VCqKDznSIPJ/hqwdUcnKrNc2zObH8QKoTysr?=
 =?us-ascii?Q?WkQEXUU//EJz8kkTSZ/UbxbFaiTnm95aZXJCXiPmKu8BOQoCl8MApI71BVoG?=
 =?us-ascii?Q?Q9TT4WXCk0DUwKZwvNYkcffaGDqA0oxTZD7vC/Uy97JR1FZqr0QfWyElxLCe?=
 =?us-ascii?Q?UnhWYhnpBD2tnARANhYO9/Z3jRoAh2slWalp99fQOaFejdKyoCDpG23Ei4xU?=
 =?us-ascii?Q?dtJhlgyp17KH02dDg0k3FgTZTnx87Fn/6Ov0rsE9ZA68jFaU+obEu+MBBQEW?=
 =?us-ascii?Q?CX72DfCil8EhiFSFbnTBFGsFddTjg6kbpPdyNvaVWJAMsPamvrYsKqvHuasK?=
 =?us-ascii?Q?fyD2kvnRffOz7TYzfC4f0MZqHJhJnPLUljp0QnahVR2+ywEGL3Qj7P0PELkb?=
 =?us-ascii?Q?Un0YhuCBMxTO3mLK7BqIyB9Um3w2BZfnuZY3jMYDj8WPLPH8YuQ7BeKRZVVX?=
 =?us-ascii?Q?7rxkou+9eU9BpD7sNByzzvdvWAp8VpTOLRKBxS0NzIQrhsO/ffmaZ0d5V7w9?=
 =?us-ascii?Q?c3FwMnAv+s2mKle3kHflAPztmF9O3kAxF6I/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:55:31.9963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40574c5f-6790-49fc-482c-08ddf1c0fc00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
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
index 9608fe3b5a9e..83f0ecdaa0b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -472,6 +472,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -553,6 +554,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
@@ -633,7 +662,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
index c027dd916672..2260b1fb8a22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -66,6 +66,7 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

