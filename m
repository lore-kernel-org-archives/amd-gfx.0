Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5534BC369D7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2A310E996;
	Fri, 25 Apr 2025 18:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3QRsYWu9";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4604A10E993
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2e1FolQz62OPFn2mUQktytVMi0Qa/SFTH/a75S1jPY9Evp9VE6ZoQHsPQm0rzznxkJvm6NhYIGtwqQ8ky/GWR7oMkNf9xm/Zd7h+2yviIH6KVTNI8UZbP+CdOc791FiBjkDdbyDYrLlfx5btw+l4BkErAe6qTXWSHPne3Lg2eSV9vSTMzvOatwaimNjAmVJOYgN0uSoi7bQK/LytkGvuC0VR6v/of8v3UEUodbw/RDrhTZ6Xcf9fC3AXOmeuM1PGdLBM09tUnF9mEHIyi8QWhKzuw3/zMLzQsErrpkLOEbI+6EXzwa05NW2aO3N6I/3Xv7wr1pFVMCiE+f7jxPI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz7EH0Rqrz8abJ07Z/AAld1wQqTttzgP/H9bgTvp9A4=;
 b=MzJ3ykEna5JLYa3pSMmY5WSWXVyK/F7zZo3a26IC27MqiCvwb7r2Lbs0+c/EpniR4AvZBdaKrU7luwYApK6uEotAfd9k6h8amDE8vzNGS6JX/2jspyn7pebX+eNZ3PU3ctHRiql1QGoWrBW2v7imqBW/xywLuBwv3PsAZ+PnNdMYTxc2GCE0QUyjykQJoptHqmVzMSeVBDUFICUa0TunllMtW77nuEQaQCKreuPMppk+ChuljDsnb6rqrKkJKp54w2vcCAwuq4T4RJa56BDhTeTOPPl3Q56+0L8ft2KQ2baxxuJIX8TJL8yO9pwuMPnBP5dTHOAZnReD+OhxWn8Ftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz7EH0Rqrz8abJ07Z/AAld1wQqTttzgP/H9bgTvp9A4=;
 b=3QRsYWu9lMM4mEx7xJz5wzlG1a7S28AjkEDSm+NkvxDHJJTrx9f48MQDW/VkHrrvl738Sl2makBGj9txk+IqkVcH6suYctRAgxtbUC4RWLk3ZasMz2u9FTX66r7TfbK+3Zu3UTtIhCCkDAdGVWSaYFl+/6TBvb92CPcwOJt6i6c=
Received: from DM6PR11CA0049.namprd11.prod.outlook.com (2603:10b6:5:14c::26)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 18:41:46 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::c0) by DM6PR11CA0049.outlook.office365.com
 (2603:10b6:5:14c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Fri,
 25 Apr 2025 18:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:41:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:41:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/8] drm/amdgpu/userq: enable support for creating gangs
Date: Fri, 25 Apr 2025 14:41:25 -0400
Message-ID: <20250425184125.166270-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425184125.166270-1-alexander.deucher@amd.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 652dc394-2873-4c4c-2127-08dd8428d542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SR//bxxv8CFUt5PxthtbSg1efnNIzVRhWW+Zwdl48R+f+XWlD5SW0XGCWwBx?=
 =?us-ascii?Q?fdHR+ok06cLoV6t+ejyNWEmUmUv/87ZeKSzuI2iF4axcnKgR8z+TPxPdxsNY?=
 =?us-ascii?Q?sUxR7q+2h4RHNun+tlIMrll2zrhS6+6vYcUr71TITp4+rewvNfUTIk/GQjhc?=
 =?us-ascii?Q?7jznZJ7uPdCHZC5ZIsmdQmrabTJsB5B8UPX889WyZyuIi0MW9ekWvWgd5Lgf?=
 =?us-ascii?Q?b4yP2ix3X8yKbtgm0mbbgO2IA3gemF6cjhRwG9vfNXlCPYVaZqboJlpFhJnS?=
 =?us-ascii?Q?ASfAg0SIoVUKk8JmM5w/gWjpWwDxUIO2CFxX8+E/8M6mhNas0ZyPQM7vkj+2?=
 =?us-ascii?Q?VsjSatcBKOR+WZEbkl5zZyunkAKy90MdaYpPlqbV9C/vcIZZfTUKDwFJrqMX?=
 =?us-ascii?Q?wGliVrUr2tTho1B74daj5AQeV2ia7oYiqMiVXmXVzFyeTiwCItPiis4JeCWp?=
 =?us-ascii?Q?d4Rphzg8Ao+71iMz1lbwUJ0YKvZim3l3wYVa333eQfbgEmimNNz9O0VsSif8?=
 =?us-ascii?Q?Axp9Ui8tLetfABVmpPiUbX6eO368dj/0uoJCl89tQHAd3Euo08RhwV8AEC0x?=
 =?us-ascii?Q?VDziFXX4pefiU5NqWquoUyq1Wg0GRynRlii8x4HOBnLUpDf7vscL+CPY5aR1?=
 =?us-ascii?Q?3xr3HufdSOancRDG/hhcFYdXBbrlUKWDCSxzzYQYV56Yc0qqDMVratMrN21Z?=
 =?us-ascii?Q?o6Q5oTckbzwX8o1o70DX5YiVnQDMOaJ7Px0vdkfQEEP1fxkEpPCweK/qQX3j?=
 =?us-ascii?Q?o//I92uMsyiANla6MRKMQA0xL9/pOHRjVO6PTwJ+m5S5Aq4CqNsoXLqzouBn?=
 =?us-ascii?Q?UoZabdQmTFeDtuHo92pxyvWvlY2KTsGMECqkOQ/CcI1M2LA+hNjw4Tr6abaI?=
 =?us-ascii?Q?49dqwpqyY5aHi4ej6+SCqxrCrFpsehdgCfd+UexrnXUvhrQE5+geQNHrQThi?=
 =?us-ascii?Q?9gVSAK+yQ+bZCQ7LpvzQpIdNd5IB3ePfYyASfYWccoMWZC5BbJYNh3L+7Ryy?=
 =?us-ascii?Q?bkq2Je+/9as8jHHmK7n3mJC/TE4iIBfYFQAJ4oZwShvCKgKPTSg9X9Lfp3Ly?=
 =?us-ascii?Q?669aKvbc7eXVBiKA2XBu4Jo4GtfEOCvsqvPaQlPYcNwy5knlE9wDaLHBLWon?=
 =?us-ascii?Q?AsRwAdDZSOMLNhECM2UempvGET1j1bIzMZKqsB3TTBRm6XTwt6rQ2FYXSW6T?=
 =?us-ascii?Q?WomqqqyKrrC+JurI1MnEaKzc4PSXvJRLrgGVIzLu1lI87LXmgan4oTexWc3M?=
 =?us-ascii?Q?69qxXPYh85SqC9PcHojFDB8KOuO/enJpKhXwQG3sm5Hy27N0gWm0q53hPb2m?=
 =?us-ascii?Q?b56hUrwrSirmG3stE9kdqzM8Jzib6H+z7O4/C1ErHn8aJzhvLMnMgG9FvK8h?=
 =?us-ascii?Q?O7uttpzKrsZyfjnf66bRNDHNAIUFTbqTzLzWe13S/aQHF9dA0Jt4tjDD+vqV?=
 =?us-ascii?Q?exJmJb/l9jgedgv1gGylQH1QcfuzDO8pigWOY07Z2l/DHf3/qneLbNl45N17?=
 =?us-ascii?Q?CKZ1ei7bNXYj+v6SdY/uevuAW2o+3RwOqO7o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:41:46.6980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652dc394-2873-4c4c-2127-08dd8428d542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
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

Gangs are sets of userqs that schedule together.  You
specify the primary and secondary queues and the scheduler
will make sure they always run at the same time.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 52 +++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e56fae10400db..95e1495d9a24c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -561,6 +561,51 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return 0;
 }
 
+static int
+amdgpu_userq_create_gang(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_usermode_queue *primary_queue, *secondary_queue;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	int primary_queue_id = args->in_cg.primary_queue_id;
+	int secondary_queue_id = args->in_cg.secondary_queue_id;
+	int r;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	primary_queue = amdgpu_userq_find(uq_mgr, primary_queue_id);
+	if (!primary_queue) {
+		dev_err(adev->dev, "Invalid gang primary queue id\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	if ((primary_queue->queue_type != AMDGPU_HW_IP_GFX) &&
+	    (primary_queue->queue_type != AMDGPU_HW_IP_COMPUTE)) {
+		dev_err(adev->dev, "Invalid gang primary queue type\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	secondary_queue = amdgpu_userq_find(uq_mgr, secondary_queue_id);
+	if (!secondary_queue) {
+		dev_err(adev->dev, "Invalid gang secondary queue id\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	if ((secondary_queue->queue_type != AMDGPU_HW_IP_GFX) &&
+	    (secondary_queue->queue_type != AMDGPU_HW_IP_COMPUTE)) {
+		dev_err(adev->dev, "Invalid gang secondary queue type\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	userq_funcs = adev->userq_funcs[primary_queue->queue_type];
+	r = userq_funcs->set_gang(uq_mgr, primary_queue, secondary_queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
@@ -611,6 +656,13 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			DRM_ERROR("Failed to query usermode queue status\n");
 		break;
+	case AMDGPU_USERQ_OP_CREATE_GANG:
+		if (args->in_cg.pad)
+			return -EINVAL;
+		r = amdgpu_userq_create_gang(filp, args);
+		if (r)
+			DRM_ERROR("Failed to create usermode queue gang\n");
+		break;
 	default:
 		DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
-- 
2.49.0

