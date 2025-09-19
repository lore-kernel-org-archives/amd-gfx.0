Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D83CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B7410E95E;
	Fri, 19 Sep 2025 08:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Raj13D6/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D68D10E95E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWCxQjvN72Bxq/aRinUS6w57wU3dBzBiYu7krzSROg84a0MiG6tUGLPUJwHBrQYuZLvz1Aujq2XEduaysc4/1C5ytP5wzH86RZ7uMJNdTIrK7GBHdWACGFI+Mtpai6X18lJS3XUXWQCVfjEkpkmrK3SiceNxaVGvUgH318nIVh1Ue3jtoB0+HtMT5MlShFZcI11rzGriba6Hkmdk1N5jURbssrxNsju52QVyPdFs0xkBEROov4BGoWdIBZgvqOt1qw9L3JIEmytsBcjibIrLnGLwH8xBlTfyDtEM50zdpb/reab7BTINCVS4z1Ow+/Vi6eX4uwko08+DFjqY15Oigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXzGnuQJXntgwXPGrRXmSZ7gx+nU0hL9JjxcMKh3cdE=;
 b=GM01Z4dmhBxNiVgZ+TU9wykVEiVz8ZcPD3ML/igY66lqEPKPtzqHo6CpGL+InkMANs0rWPZZ2drPNz0d2bYoduCfB9TdS5s0dZDCxc1YVv5Qof9ZpL3DBf6VcDeoo4LQbnFxSh5Eq+qLNmsrppeMYvW0e21zHSItitLzbkS2OT9yqBqZB+lo2qbBhiRNPW2/uzz/7nJv0waeSwzSMUwBaAgdHIJLMTmlmMGhl5/y2fO2dSjt4jUfrwMjblR7/d9/+KHKNiAnzEv/9Y0aK8y69Awo839SyvdIQpJJrFhRgIOdOMiwc2/8rAorYp0pfsQQ/kZPeVvDgv3zBqKVNqGtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXzGnuQJXntgwXPGrRXmSZ7gx+nU0hL9JjxcMKh3cdE=;
 b=Raj13D6/33ofYpd4B6mNpBwlAxOcR82fOowg71aoAy0J+eeLbcalXMlfOeEx6Lk20IPmwlPVL6De5EXRorZN2bRBJfK5BPeq38augvyWOFs8I274PdJoCnfPOvnmYVzJG2oyYJ56aRQSx/d/AAKHs9WPyScNkISMWYRW+hpylws=
Received: from SA0PR11CA0062.namprd11.prod.outlook.com (2603:10b6:806:d2::7)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:11:29 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::cd) by SA0PR11CA0062.outlook.office365.com
 (2603:10b6:806:d2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.15 via Frontend Transport; Fri,
 19 Sep 2025 08:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:28 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:26 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 03/10] drm/amdgpu: track the userq bo va for its obj
 management
Date: Fri, 19 Sep 2025 16:11:06 +0800
Message-ID: <20250919081113.2797985-3-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 77da44ad-7abb-48f8-9c52-08ddf75422ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sH1tlUFybgtcf+Mz9pq5FSQ6kcYICGQZ0RndE2RLQPVD/WBZVix5S/IP6ByX?=
 =?us-ascii?Q?dL6ChkqC0UfPj+kYYwyX5et8X5ENMAJ0A9Q3+6RWdsFafx+LNbzuDsmQdv3K?=
 =?us-ascii?Q?iWK7kYmbe3mmgyscEbt3mk74U5eQrZPSLFWcr1tZEobdfkQ2Lx0+mKoqnFsf?=
 =?us-ascii?Q?94CKT1KAWwZxXzUwMWwrttvx98SRUq3rIo+jc+mFWtPX1phWJhY6qKy+JFF6?=
 =?us-ascii?Q?DXCvEHf0vSPKmO6AxVJiLsBH1F7CSFAlDBSimdz6dYe5RF0ED37CD1RuEq5f?=
 =?us-ascii?Q?EY4kFkJkrleMp6Jl8iHutfSMz1zQnnVZp+sdY/mEHoWejeKtzbNkp1OeO619?=
 =?us-ascii?Q?nr+B3r3BM4aFucFMyALYhx2bJTbohP5uKCEstCHHN5NEJy/GXjNF/14vtvWL?=
 =?us-ascii?Q?kinQczNX/2gS7b53FS2UqtlBJSjw6LqXC4uo7d1I6vWvzeo4k62ga6QIt6Bv?=
 =?us-ascii?Q?iKKhC9xR2/aJkbq/HVMTUjbI1w2h9jvx2ftYLEAy9tinwLswaM8w09LKInLU?=
 =?us-ascii?Q?TDTR3cfnwXvVng0CDbUp1kcrvtklKcR3Ie1+0bmAYvlkt+aPLMEKgn53MvBj?=
 =?us-ascii?Q?O1dHwLUExSvdHDYXAUG3MIzzlU3LxAM1eM5HNszmbG05nl8xNi+0t6kir1h8?=
 =?us-ascii?Q?aFH4iFX/5H+ImedVSt1rO+SwjpIlppy1Ehsw9lJEAN1/hZDPvko2SP0TSnvp?=
 =?us-ascii?Q?7KD0gJ7bcMlgeB9map2m5ODAdlUsVoYE+xvWVXYXfu5JqGt0/DgjyFbtWBGk?=
 =?us-ascii?Q?MDuqyJPju71fWPDMAB4vfrhoUivS9VKT2Sa6CQVtiuE2XD3tdwRWU11O7QTL?=
 =?us-ascii?Q?+EZ+iL8I0qPhgsb2eOlE+qFWR2IwgColkEK2kJ7MTJ+yG+2DqpQiJ7wfMJ43?=
 =?us-ascii?Q?KSbBiV677VgeC6xIRbBSb5fU+5s+3jR9fMMNa0YYMipUxnNdPqIbeRKqpdd7?=
 =?us-ascii?Q?W2th72MIHtHiYzMwxWIoHSWN0sgCkQjn4SrxqfFAD4mFZ3SLXOQFA4DypZdD?=
 =?us-ascii?Q?tLfO/YFkni5izqEUudbD5wR1NjXvOJYKTpn+NswjiLssKOSc/SNNmPDYwHuN?=
 =?us-ascii?Q?rcWEUKNQJOlXcOuqtsq8U4ujL9XYWyh+egX0BQD9f2gAyk2leUN0qJ09XCcy?=
 =?us-ascii?Q?yGLZe7miUrLXMw6TXdGJHANvzTfmZMHt5R5Z0pspij5R12SmqAckRNi425Oc?=
 =?us-ascii?Q?I5v2nbluUjgfv8uZCelGo9i5P69eijPSKQKhxeXgv4b0ACBk/3TzlBvpQgUZ?=
 =?us-ascii?Q?4mXA6vdsyinZNSky0KzmvB3xg3z0DjD46XuZthZ+z2YD6mW19St1zJ6mw2rD?=
 =?us-ascii?Q?cangbAeJkosJuLa2BYVXDvH7sNziL60mRptcgyJBofzQvVGWVPaUuUfBi4+s?=
 =?us-ascii?Q?KZruTlv99S7EWfCrJWZcvo9y/Xl4q+k0YYD90OvPWh3v21L/DDadr6asjJj5?=
 =?us-ascii?Q?E0NPAI0NK24mLiS0w1TLzMH2i+eefRSb9Qb73XrcyXu9j/hx/YmHQRRSsW9Q?=
 =?us-ascii?Q?2fJQFf2t6kQ/eUAO04W6Fm7uOZmXPs18rMMN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:28.8875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77da44ad-7abb-48f8-9c52-08ddf75422ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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

Track the userq obj for its life time, and reference and
dereference the buffer flag at its creating and destroying
period.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 99e51a8ff62a..790f51d2b8f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -124,6 +124,32 @@ static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping
 	kfree(va_cursor);
 }
 
+static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
+						struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
+	struct amdgpu_bo_va_mapping *mapping;
+	int r;
+
+	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+	if (r)
+		return r;
+
+	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
+		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
+		if (!mapping) {
+			r = -EINVAL;
+			goto err;
+		}
+		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
+		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
+			queue, va_cursor->gpu_addr);
+	}
+err:
+	amdgpu_bo_unreserve(queue->vm->root.bo);
+	return r;
+}
+
 static int
 amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -229,6 +255,8 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Drop the userq reference. */
+	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
-- 
2.34.1

