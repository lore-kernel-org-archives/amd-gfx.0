Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74892C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE0910E9F9;
	Fri, 11 Jul 2025 09:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukxr+K3r";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A1C10E9F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLjpePs/6/D0Fetfu/Oxj5T/XLUleEPQySUTv4cWa98oIW0PLQFnfGneLAuHb3JMWagLJD0xR8t0oW1INxXY2oVLFKkub3EnLdqLUw37mKbgwhzyNBeAzbD59/bWpOaGDTOS104ze6pPbord0VlsQ8rBOyYWdTNbR+66y8KDDTnA9o4VLIo4fuL13iNl+fLqNp48PvMH7d4h2xXx54h+wkqu41vWrPrLw4wbqbvALtTNvgDIxp9ZMwYiJ5sD/gTkhN6NceFxr46mt8Z1XEJUku1JIQqCeWoodbCpsRkDFO4ISZpUZ6qF0qRqBZHoZk3/cex8clv2QOcomrK/LxnCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubv0LtIwZsdIkRz+alPGpaANlZR8lw5FpUj31+3VLIY=;
 b=HR0QJ9DeB9JvLPM6RL71LDPI5ZiIWv38M5f9nVKKH/piuTnNR5m9ciirtCPeeR1cjDfNXeXNLicCKZg6g8o2Ss85o6egAusBRDUorUgWBwhGjV1LdqpnKen2qd2H+ur44NEarFL9ip24eDq7lHMcXYa56pDyIqA4tjtc8q/EZHmHadB5zbo/q0ndx4bfcYLTqyimq5WcShMRIuLU3zPrnZpWYjsihG/gTRG5LxEKUB7+v2BCF4kvH9zU9OFxeysE92IWuaFgCDVyvlMDTpjHKQEF099UPGcdMeRBx/isw+vkaArukfKUuKLkICV5Vu/gt4VxknEwik4Tt4iMX92ESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubv0LtIwZsdIkRz+alPGpaANlZR8lw5FpUj31+3VLIY=;
 b=ukxr+K3rWjRfzdv6EN/sC+ynDkqQtGOQWnrbacxFsL5/mkIMkVx7ynauiw6t6MMIM+WKaRAjss6cX6C+puAc6EjvOZvoWIcKB8S4iVkX5ax2lG34BiWygFqnQaAzZ6y+evbnCiDivFtETIF0ZKlYvZiHhV5hR9o/F5QFVH+dJHI=
Received: from MW4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:303:16d::18)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 11 Jul
 2025 09:39:51 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::21) by MW4PR02CA0030.outlook.office365.com
 (2603:10b6:303:16d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 09:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:50 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:48 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v6 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Date: Fri, 11 Jul 2025 17:39:25 +0800
Message-ID: <20250711093930.1411470-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711093930.1411470-1-Prike.Liang@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: ff577724-bc26-410b-36c8-08ddc05ee1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rq2dqjf4Asbh0aOob2gfwfRSY50YWEQFEal0KHuSJAaopjyJWc0uboH1aNKj?=
 =?us-ascii?Q?/pHAvHGcgT2Jk/Ysjd9RUYOREMbXzez+gOQeQ6AnXvag7bZRoMICx9Nwwio+?=
 =?us-ascii?Q?gxoSCv9gD1f7BpnAqGuwq7yXYP2x7da6oGezZDMxw17xikScY1hHwXwvb96I?=
 =?us-ascii?Q?KzyRJ46bPQnonRml3TdO8X/S7kQpADV7yoHmfiqCyON0R7wCiujo3tds3t3I?=
 =?us-ascii?Q?BpH9e+JsqME+3ms+zdkhLGxMtzWS6NgwhqbldPo4d/AjRjn0yWksuvdNEUJD?=
 =?us-ascii?Q?zkHKsDhTMLSCLLF1w1jyE5rXDhdzI9tCm4xIzJTpt6RremlZf5CrtKlTbxEf?=
 =?us-ascii?Q?TqFSfA02C4E9OccG26XAZrRjjXODEPMEKpC1HOD3ud1NvpW9b3KReN/SbplR?=
 =?us-ascii?Q?iZxeiDGJ2gyVt5OzqJyd8sVd/2WfqvkNZ9p4iHtEReS02pqbwxvOG+QpG9T4?=
 =?us-ascii?Q?GOJeDFf7my/aCb6ax6ppxwEj/h54KYYJD/FNseAIv35Hx/J9owOY9hHVRr7c?=
 =?us-ascii?Q?MuDFWq2A09/w+2ByzNBF4MVeTfuyZqpVjoW7wM0sDsYrjDE15Gg068mnNBHB?=
 =?us-ascii?Q?+SaoKE978V04ceWXrZmJw7KxAnN8cKYAs9t1XOHtV7Pb1KXT/yv7bKnAK4bE?=
 =?us-ascii?Q?FFLgiLfCq1em0aqe2aqqkObK8d/p0Y8KBUdtHGZ9glhIJwqsnGoMExhhYTWM?=
 =?us-ascii?Q?bfu5Tq6miybIhLnRymadXywMxImXKwbqzuW0UxVw9JagSQD8RgIjdGruspEW?=
 =?us-ascii?Q?fY9Of5VceZjEeb++l3q7WgnYAlHDgXpk76z+vF9RoFL2mKcNmWVcV25KF9GJ?=
 =?us-ascii?Q?nod4VWuqIlPJ3JoyC0lwZQ2VUvYE3xfdIuvgOe6tYhXKERflXZYWR7+1KTvm?=
 =?us-ascii?Q?dRAsnpCfBt1R4tXQlC8ukYcqJfqHeF+VXYsNYsXXzFScq9KnE2ZOvRoNqOGA?=
 =?us-ascii?Q?f2ULvMrzEhM3Z1GPZ+aNOTRQWZiF4Lk6MMK5zCaer4SCljjSPP3AUbr4P+FM?=
 =?us-ascii?Q?reo2qBV7J9l/c0FQs1z780T2o/RtLQR3g88D+SmgOcIQvnPqXqgu+yxXpeym?=
 =?us-ascii?Q?PG0Zx1wLS774SJC5/FOMtOnmZnmFTgjOAYqV29ScmYs8MTygvnQjpoBzoaQn?=
 =?us-ascii?Q?zMYlMD4IKZqC2VwUnFifvOWPK7olTc5EUQi3+vPrJbkL7bd9XVUu/s7Rjv5c?=
 =?us-ascii?Q?qEFTzzRwwlRheOEKn5maObpgaufGQYyVWNENex19yEr/nECG2QVydy3jSx8O?=
 =?us-ascii?Q?aMZ+VbPb62oUiieIGnH8AnN3MD5VhvrzkC8L5ZOypXLMhykYGZQ0JMAZqzjT?=
 =?us-ascii?Q?x0rReOkymSMFSGwY68jlKxHFze5jUmVya0qaYUbhZDQHR+N4TmgNT4RAbQsa?=
 =?us-ascii?Q?fInCyVudku+Iz7rj7o6S16ZFQIpF38pR+Echdrk3328IFdle2ZYhLPFdhGg3?=
 =?us-ascii?Q?RzyP0KOJm4Np/aZ+VFcnRCCiQ/dRV0jrrSJERWCoP0RKqVgr7phCSxWwoPCx?=
 =?us-ascii?Q?CRauvy3kfKOV8rZDzgDdrfsifcZeEm/i/ODR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:50.6001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff577724-bc26-410b-36c8-08ddc05ee1fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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

The user queue object destroy requires ensuring its
VA keeps mapping prior to the queue being destroyed.
Otherwise, it seems a bug in the user space or VA
freed wrongly, and the kernel driver should report an
invalidated error to the user IOCLT request.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2856c2506bee..81fbb00b6d91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -510,12 +510,24 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		return -EINVAL;
 	}
 	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
+
+	/*
+	 * At this point the userq obj va should be mapped,
+	 * otherwise will return error to user.
+	 */
+	if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va shouldn't be umapped here\n");
+		r = -EINVAL;
+	}
+
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		r = -ETIMEDOUT;
 	}
+
+	amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
@@ -636,6 +648,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* refer to the userq objects vm bo*/
+	amdgpu_userq_buffer_vas_get(queue->vm, queue);
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-- 
2.34.1

