Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90726C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3490310E9F8;
	Fri, 11 Jul 2025 09:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FlyURLZi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E0610E9F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3P4CtQxuAkNiUY009FstUXl+Rar/fAImK7a47kiqNf0d7JDmv/HM6rjJ8PZwpNdLBZKXrIiWl5f9flcGSfqjjOt+r4VszNY4K9qSpLgullWoyCK1Jh6E+8VAaU8eoCyp32pE5itoKdLK2DsTdDmzrBcOu4XybmMBtKErfW9wT4ohK6aaaqoY8QrRIV0p5P5UZxm5ZvVs3Bc4SdSmxDevXGkUwLq8X9Hl+uS/z0KBJPC2tRo+NbMqBl34dStL3d8yCW/b+sUZZD0NwmdTQRSROzMXGgEhl4/8kQsgACdtXFVrjn4vL2xXYXWrJvbWEcW45dNJ/Aiuml8SzzjmeuClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOktIS1KhTFHpTllkMoErvygJdJiHvc3adiLyOT/SyQ=;
 b=rHVcydSCb0kpNKLsAjNrf7QYqMA//mJkwkoM+gag6dY85Unh3SSaEVpjfObu9GqX/SMr279VeoURaTMqt/GWJD72fvDQE6a7shayD460oPJXs7fsET89jbhhl6npi+T1AIsYpSs0D7h6njwwa8JN0cBfDdSoZ9541jcOWf6tK+9ZH3EfMRPDwIBP+pGjk/u+0SVXR0DDDaBHOw5GlUSbOcmTyepWI0SASvnoOEqTbXizW0gsUWXgiwowHTpP4zY3KXuJ7gH4o1l8FhhYJp+3sBg/NhMBiyZg82/Gg/+mGxf/JV/6IpBfdhVb+KbEr2YZgrbP/TP5/gEdA+FMKooxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOktIS1KhTFHpTllkMoErvygJdJiHvc3adiLyOT/SyQ=;
 b=FlyURLZi+aAkqGxBguCqUYijSSWeSlyYqYRH3pHbyIpZ60/okOGd4KX3UH3TrFu0PpG/+dvz0z7n1rSIIabpRmmdwX2qe1H521aiK39EAqXJ4iRMr0oI+tdoexJEJ92/9LCBJpL2aHWnKnMXtHbqjFEvFvlAWRu7nG+SW3VEjs8=
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:39:46 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::85) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 09:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:45 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:43 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 03/11] drm/amdgpu: rework the userq doorbell object destroy
Date: Fri, 11 Jul 2025 17:39:22 +0800
Message-ID: <20250711093930.1411470-3-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: fef0237e-2928-4108-d6fa-08ddc05edef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZmqG8HYjcQevRxfrfAbbUgfS5Dr9bhwKVx/Im3lvUMJcK9Er70QgQyKBIGio?=
 =?us-ascii?Q?blIggWZ8fMy1Q6XAO2nWw/qvCMCb1PB3rLcG1+gdkdkmFsuJQFTuQnTrKjJN?=
 =?us-ascii?Q?06rUqngTd/3qaB0UJhO3MBXfu+qI0sXbYQRnYWzDS1EG0re4vQ8Oh46Ep1Ek?=
 =?us-ascii?Q?34oeXhPKXeOds9gLy05+VIAr4d7d0tf9OjAe4wj/ycUwUvpoQ7OScdzKvbHD?=
 =?us-ascii?Q?RV7bEK+8wrKgkDcN7gjX/C/qnspga8gGbsvmLT7HotMe91+tMb28sG05USzl?=
 =?us-ascii?Q?yGiTdHNBDTy+CrDpDkxVK2jfLk5WN2TZwLyQrwpy71pq8G06E3d+rBBSDUcr?=
 =?us-ascii?Q?8o/XFT/im0Tf4yWjZPUU69X6NNF3CM4+pVvDaVJbqNY/Azl2XI8jxc0mIkfG?=
 =?us-ascii?Q?7WuznDAwJ29NARH25laD+iSGh6pTxMWur9NYl5Hf9TD2ee+asJaqBHhU6wky?=
 =?us-ascii?Q?wmGzLNKKMWrIQYR+usV0KXbf3gEopcWsEbra+4SHdNjGMEHe+Yepfx1mS/of?=
 =?us-ascii?Q?lDQY51j0xgBbiNKHrgms4gYvkCCmZM3rox3rCgFRGKEn/JjB8qWXtSyLJoTt?=
 =?us-ascii?Q?sywIbG1jmNwCrzDaR2KxVYydCVpUnnBNuThwwRTEpBrUrNQjNPuk+acVilzz?=
 =?us-ascii?Q?subHWHZyPLhb3UoWRiovIT9jvbKGAkoUveuBthxVksjyH+ngdUatAWKNU2wY?=
 =?us-ascii?Q?MjVxtOcWG/ZcI7Q1nnSocgOpbXKp9bdyji2TBPGbyPqxG8ZEaBbMBG1j9W+K?=
 =?us-ascii?Q?yzu4Ef2Bt+yN9V/fs7KBV2g+8b42jgpN9bwp9Mks64jTJ6dogyB9ImbKpn4l?=
 =?us-ascii?Q?AGdDaqQVk5gp10BX0HyYI51IYPdmFtAw79Y/AZRk8MdfCPWEGHwCYRfYO16l?=
 =?us-ascii?Q?9dA1206ZL6CikpUUidP9UX1AORO3jMEopMGX5xAD7oVIsM36VgKe74IJDW1g?=
 =?us-ascii?Q?BVcmmZagdvyUJQIp0fVmoXm1Ld3r4wJXLvgvNyQxIhGBmg30CnGtGKJBI1VJ?=
 =?us-ascii?Q?XI89xQx4qb8mXp/2gbTXZ02Q/0O6vB0FzwgXqlTEaCFfa/bVU13xdFjCWZL6?=
 =?us-ascii?Q?D71q9MMw0J+uA69nQn1GB1btZMcMzSe8CW7nRIpo3s4cvTv2OI1rOpMPDYHc?=
 =?us-ascii?Q?kCO1peyBQ7/QpzbYSOQYrsJR1oVK9S/dljRj0VxECFr9zSJ4+OpOM/B+lTwx?=
 =?us-ascii?Q?uPdKPeBDtcQ+Z6C+d5sRVIEfawEgrYr07ZrUTXFge0yr58xNAyHv6Q2PDe+u?=
 =?us-ascii?Q?pCD5IWJf/EKOyhoaWI3muCjbfS2fKmN1Ynu+mrSkHI63Or805BdAY9TEiXTY?=
 =?us-ascii?Q?hC1Fy4+WhQ/FOMxguo5wLR7jvDJGUIp+/LWCroEVFfj8L/Qk47yXVcPGr/I7?=
 =?us-ascii?Q?70kB9zlGoy2zJ7edr2ithG8QU97e4y5xBQDHbj4ealW9Ejdrs5uJyHpwKm+i?=
 =?us-ascii?Q?x4NPT5KXdpCygmsbffHghkhl1DHzPiceEi8mrRHTagYGxq0mQVFIfwaO5Vjy?=
 =?us-ascii?Q?aViJHQ0Q1Syb6rliORVXWhJU7o58bHlbIzja?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:45.4918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef0237e-2928-4108-d6fa-08ddc05edef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
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

This patch aims to unify and destroy the userq doorbell objects at
mes_userq_mqd_destroy(), and this change will also help with unpinning
and destroying the userq doorbell objects for amdgpu_userq_mgr_fini()
during releasing the drm files.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 6 ------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3d2a7f8946cf..15e833b1b3e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -312,12 +312,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		return -EINVAL;
 	}
 	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
-	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
-	if (!r) {
-		amdgpu_bo_unpin(queue->db_obj.obj);
-		amdgpu_bo_unreserve(queue->db_obj.obj);
-	}
-	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1457fb49a794..15aa1ca67a11 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -336,6 +336,13 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_usermode_queue *queue)
 {
 	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+
+	if (!amdgpu_bo_reserve(queue->db_obj.obj, true)) {
+		amdgpu_bo_unpin(queue->db_obj.obj);
+		amdgpu_bo_unreserve(queue->db_obj.obj);
+		amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
+	}
+
 	kfree(queue->userq_prop);
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
-- 
2.34.1

