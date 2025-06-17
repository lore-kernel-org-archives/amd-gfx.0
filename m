Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681FCC7115B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D9D10E535;
	Tue, 17 Jun 2025 08:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YSTGKOVq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123A110E514
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skx1CmYpUnzl8lnSBR4LKhTHF1HhguegUrz5wtDBw1S/kLxnfM+qlD44QgSxUWT5IOrAsCGq4KigmHrZUm+u2ZO9UhFqvUV8Ky4r/YO2BWBUqFP6AVrjgoHW0quIuXcSwmwQ+Mn6i0L5kZiU1KTtcTbOprqvZYv+t2zsAWhWB6yvynhny1GvlYbZvNmbso/qtgnMvqPk9NRzKHXC4bhuq71e+0AERX0/8Pfaj7t3OTh8NYInZdjjBi4oabKmCfHEeQL3aPcXqgBoZDRfnGEF1/gfTNqDY6DpvvBTv9bO0a7fZ6TWpWr/IIHKViP6EfwdpnAvuFhpHwbH+yjYlV+3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1jKFB9OGvbXjm5o4WUUmSLQE/RcqE4gIDrq7VjvB/U=;
 b=Hv7sq0MvNje1tlbeLnydeOlFyXP6KRWG/shgv5TSs2k9oZOO6NY0jjPkzyyzw3vLkVE9UDSerId0thulehVlnJstqxqJEkpAi9YbyTJ6fyLDn5iTwI3To9PYeWD87QylZoJlSll1SHyxcTSDrp2C8UfzH3OK+aGyfOL2v0KSERprlDk1FGgbCSGLC9gkmgVq58ZqO5P8KIn8T8meNlRTTu/q7t4iwyKNE/M8AZcFlPGsSuoAyArEJgtj+J6agmWIjN42JkMcv9D7glSOxqh4YzVGFSA8RhS4HyqsgywCxsnw13WOYtBvF5RFhs97CXDFXn6Im6DK1FAzgVRQg6gdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1jKFB9OGvbXjm5o4WUUmSLQE/RcqE4gIDrq7VjvB/U=;
 b=YSTGKOVqfW1Ju+ADQGDTHxqTqJa8hiV+NsMQuLmmVKE2FprmTQkzPLV+KJRXYCdk7nqe/qeUm4ThSojSCqtS4O1ZB6RRLDZ/D61SoqPIZc/tJT9vSXv2HNn9RZIiQdW3aV5gZg80xoAIJm4xLkQHW6puvLmVZ15POX9XtXzM0+Q=
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 08:02:20 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::47) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 17 Jun 2025 08:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:19 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Date: Tue, 17 Jun 2025 16:01:46 +0800
Message-ID: <20250617080151.1093481-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: d06b69aa-1c82-4eac-7de9-08ddad75493a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8t3/rx7x4BO63O/sqdqtCnvUh5d10RIqB+4TTIvlAh6avtF7EeeIS2NF6kb/?=
 =?us-ascii?Q?FvTsdOM7Y1tLEkbQzoqaKsjFxn/qI7juQhLkY5/oge3URfxRj/IYYA0dUv+D?=
 =?us-ascii?Q?F9g0iebSKMxVf4wfV96n3nxPPsTHAuPgXZSJSUvgg1FLmgpEN2eK4BCCni+X?=
 =?us-ascii?Q?AenUbAyxB8v3kvddf9TZ10/hOrz2+X94QlMn6iV0vcZqIZDpdu+2bTXOnYQE?=
 =?us-ascii?Q?c6OEj1HchrMr7JlDNulRQCNmnvYY+6qS28/1PeZZaLdI8vijc8q/TkcrRsWs?=
 =?us-ascii?Q?ExvHlGar5U9tOel7ygKiryO6PJsGlUSnBurbvWkOlmgPF9uwIHq0W60+O8k7?=
 =?us-ascii?Q?lsaC4Y9GbnaJNdgBa8ars2Z+yhFxp7cKImL7W0kXp+TQFdwVKgqC4fsL62Nm?=
 =?us-ascii?Q?lr0dzt2tFigy6hpS46aKjLCN1MlxItrizb5e5Qoc+jsfy3MevUsHaXDmUe7w?=
 =?us-ascii?Q?KTn9xkOYrf9LM5iZEZvHOzse2eFwlRYGDxQ8luMr7AEbD4EJWK3/y0H27Qu0?=
 =?us-ascii?Q?UzNv7NL28AprqnRuNKsspDciWw+R3xjbDljqpJpoV1KIrXd/3DI8DRMs0MJK?=
 =?us-ascii?Q?hAeRCFmYOFRSPq+OQHhxpQeqBMygPEX/HEqeXnu3jnZqiy/57zy4bzKtazp7?=
 =?us-ascii?Q?u41jhH+3O26iXAZLWuL3N7pX0vcHbYnHc6ASwYFhljHZTMniubN8nT9C3NHi?=
 =?us-ascii?Q?6JKygl2tOpmuBZevsjnNtpVyzleib+JBCRgjz8fsrBHzvif/KPnUqIQohAed?=
 =?us-ascii?Q?4Q28Cszo4wqYLGKvA/sx/x6vHTgjCox+WUNC04QMVfAtP9gUF9EuWUI8fRhn?=
 =?us-ascii?Q?9CM3rFnlzwfD9aJSuNsb2MN71PF/n60bE8bFnsptbek0HZeJ0nnUYWg3XpS3?=
 =?us-ascii?Q?Or9dJ1uyOsW3lsPeT5FOvg8JYC99OER0GZdQ+ad6TWkoYIImuis6O/Mkak8B?=
 =?us-ascii?Q?xBOZJyKPfEeWztGNho4XCmFitfhQ2QeiN9RyagqbNJ6mQkvAcnG2QO+vjLza?=
 =?us-ascii?Q?U/IdRbh3/s776e10VprJw8UcOopaFybFDuJsNZtMa8BV5nzJgZLV9nASXRQQ?=
 =?us-ascii?Q?tYmIUFV+0YuiR7yHwFX7xmYb1xkBOBvdi52bNFY795YXlK4EIovEYiJem5M0?=
 =?us-ascii?Q?V5IT3dN27Uup98nqvPZQ+zEqAYqczzqapq3dZVpAraI0mlvkMFOZvMNrwXUo?=
 =?us-ascii?Q?me4o2+1rw9pDaz3L5rcFLdJk7ohb7p3KAf0JiJQrU1rZ/EOA9gNRoNOrSjnM?=
 =?us-ascii?Q?JX/tWOpg3MwWjnUzeso7Tc/pBQUZXDg9E/PMzfkagIg4KKeNc8f+0315fQAx?=
 =?us-ascii?Q?YgLjHlkNL49OT/3rxpHidSiOChs4EfG7raOAnRQh2aYzUzyHf4mM0GvqufiA?=
 =?us-ascii?Q?cImAel05x44La2YCBwSwyU4XIQcdg5WrlL8hEeGYjhiSOgTl3Som4nyNvR5X?=
 =?us-ascii?Q?hcoFz+rqJB+XtMqlL/wwWoe+YvrFXOSQo0t2oP6pYE/k2CsK/r49ZSbjOR6B?=
 =?us-ascii?Q?b9RkH0poR9ZXs2LDWnWy4pOY10Sdxp12Y4gz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:20.6495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06b69aa-1c82-4eac-7de9-08ddad75493a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
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
VA has been unmapped prior to the queue being destroyed.
Otherwise, the kernel driver should report an invalidated
error to the user IOCLT request.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2882ef8fe719..2a7ec7daf3da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -459,12 +459,24 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unpin(queue->db_obj.obj);
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
+
+	/*
+	 * At this point the userq obj va should be unmapped,
+	 * otherwise will return error to user.
+	 */
+	if (amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va shouldn't be mapped during destroying userq\n");
+		r=  -EINVAL;
+	}
+
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for unmap error*/
 	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		r = -ETIMEDOUT;
 	}
+
+	amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
@@ -585,6 +597,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* refer to the userq objects vm bo*/
+	amdgpu_userq_buffer_va_get(queue->vm, args->in.queue_va);
+	amdgpu_userq_buffer_va_get(queue->vm, args->in.rptr_va);
+	amdgpu_userq_buffer_va_get(queue->vm, args->in.wptr_va);
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-- 
2.34.1

