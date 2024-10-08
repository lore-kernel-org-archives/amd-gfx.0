Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AA3CEFC55
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 20:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623EA10E22E;
	Tue,  8 Oct 2024 20:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XAipuO5h";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35F510E22E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 20:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKDbWgpygA77pQAeXK4zMNYO0bC7+ex8tjwRlqn0F1pGZC/Sb8W7VzjWKJw4O/GUT0iuBgeQS627p3lRT0fk8SzbC53sTzMT432Ukg38jNrm3V1Snp7HqLTcrRib7PMdpiGdCU+5ypnYoOF6q4N2E+n4p7WEaJYBvIX6G5Wi5bAlrXLdGC48ROQY4XTmnunVXCse0yknzIo8I6WQXKPf/RZXAfsZ72GguIxi/I7Yr+y2C7CXTEbr3653weQrVrC/AIMq5FFEs06i4KNX19cQUlwHemN7HOwqT58g7aG4fGEdmyFiseYCFiu2niUp1dvDRCbYgLHeLyS2tSidgeaCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ADIYU8UGqu0Ni/TjyP8NW7MXFlfe5tpJK+SFarO+xg=;
 b=Z8f2spXDqljH4ghkqgG5AII7xzl4yu9yCfUU1ccXC7xhGuQhuINwhXq5YicOeJ2bd+w0axj2Hzp7D7Go8O06RwzusNSr8otCZr1hpZJ/uxeEh2fV7siAoo0b/u19DUYU7NwWwoBT1GqF4iSMpJaTfMFi2BphhxS7Pxgiu/smjONjF/4xpjdrtTkba1p3c8eULkHNkHBL2iY4tZAHZdmha1R92PjOQbyor0DLyzDUFs2a3T5FoYQPebT9V4SAA8RONg6NAJCkOUPVgxHBrQRat4jFJttAkrwptAYX1NUYviPyEREzew+hyvIr2Lkt6X1ksOZcE9Ryb7yPc7MAt1FiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ADIYU8UGqu0Ni/TjyP8NW7MXFlfe5tpJK+SFarO+xg=;
 b=XAipuO5hAWbQkh+jmX4IA9ncc/kGvKhgRzkoXtCuzHzpE3s2QpzmOxM6BfUt4fSAaLdZW/ySz5FJrEBgBuj29IeQhOSawWbxuFbwHQu1pKLGhKSA+RffL59CAcqBQXNrH5mQp6lg6qNmryJwuzajbPn5f1d8hmsR7j+TiSzldoM=
Received: from BN9P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::27)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 20:06:02 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::68) by BN9P221CA0029.outlook.office365.com
 (2603:10b6:408:10a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 20:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 20:06:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 15:06:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: enable enforce_isolation sysfs node on VFs
Date: Tue, 8 Oct 2024 16:05:42 -0400
Message-ID: <20241008200542.3891752-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8590356d-cee2-4dd5-3766-08dce7d4a24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6jEmA+7rWBDan0gYfqyVWeVjRbK+HZ0npXbnSHKzh23HsvhU9iWleJ/mL+uw?=
 =?us-ascii?Q?OGLhgyH7fVjDbK0YiXWVRQJm9zPlYXegIiEEdunkKsHsgGGIDr3K2JwyKgTD?=
 =?us-ascii?Q?0W9pSQ4sxp1e0ZS0HpxGsDN3MCpuvKUtC8y11yhYyJh6bjS/oSeOPUDzJs6U?=
 =?us-ascii?Q?B0vsfbx/GGhLpP5h5+EIyCbnuf52/ix0YgR4nPHvZphgQsQ6AYVNMAncPPxc?=
 =?us-ascii?Q?n8BBp0aOC7p3ZYoHlpFceXOJ1gTC2DKdwN+ExcH5mCZkc09vwNLfbce+ffur?=
 =?us-ascii?Q?PTfSEbxmtlYsHzSqT4EG0rqLa74to3zc6iZKCKKotXZUdKCoxjO1MSV3tDn6?=
 =?us-ascii?Q?GtQfY/RLbjOE0cTLF9+7VWD9qntf0+/PTizViV06HKBWm24WdZ+cziziH8aI?=
 =?us-ascii?Q?cP+rX0KpYIiBTbfhTS98YtGgLIvl8SKRcztrNNfmGlJJQU3m0LFAwxzY9sq/?=
 =?us-ascii?Q?afkpmucD6TN8qUPEmuJOj0G94glXlE2LH+LHRYSd/uK9PbmwK0k75lX2EA2w?=
 =?us-ascii?Q?x7Csq8RKle1h25VA2AL3G99vsGtx/Zj3E4yVOiFv9SqhrHpPedJT7JE3AGG1?=
 =?us-ascii?Q?iVqE3oV/2WP4U8abdHNyk3QAJ43zUMaFzxDdMx99t0GIlCONuaJu7g7YB6hm?=
 =?us-ascii?Q?SiNer8aWU8TRLDBN/DcOlIrwuKJOOd6sKHSsSIk1TIaG/b7J7IlnN8s8q+tp?=
 =?us-ascii?Q?5OpZ8e9gYS9KiW+Jk4jfLR1XJ0FxHaVsVtBV242k10RUF6mCne6gSfjnQeri?=
 =?us-ascii?Q?GWth03TE43g29pCh5Fn+R8crzPUmsKB3G36RbrRDTpT8dLoyon8bZHdYf0bU?=
 =?us-ascii?Q?mi3xem4/1zb3ObO7iW47plN59KtJR7wx8r4iXioYcrXQwGxJlJ0rMIi+qcEk?=
 =?us-ascii?Q?osEvRzxbO0oeXHGHwtkkprGCKokbIPJt5dbCUmuF57MgX57KUoE8/uh6Z1ir?=
 =?us-ascii?Q?o+w2TExx9gJ0hLvAnK7bVXXK4xUpoiBnD0wI/dGHO2Jqf47snQAxSaqHc27Q?=
 =?us-ascii?Q?5V8oCX4hbMn0J4g53k2MDGNDrckxKRlh5hiSLeJZigPJFPpVe/m0nm4CWFd5?=
 =?us-ascii?Q?RQpvPMd8O+CMUyWhhOGKeQWTOzVGs29jY2D7mIjUSp7Oyic57F4rzUVc84VD?=
 =?us-ascii?Q?125RZRDgkOR4hCTpZwCEqjYoHaP2w/lWG0dv7Bhh0ckE9CPRIieQ/wirxOGa?=
 =?us-ascii?Q?HMq7ML+xxXkQf3/l14oJ+gG7RW+V+pe8r4FM9KT2IdfYykEvD5eD5QTjLrUb?=
 =?us-ascii?Q?qQef26g0t+9IaAOMo1tFUSJxRlhSqIuxRUbXAU4Tjw/V6Tmo5lScrRkFgKqi?=
 =?us-ascii?Q?nzDY7bOC9eAYVVCcMrOpue+UnLtoTXn592Ru0gMK4fCLxsteIE8ntkbvqhgH?=
 =?us-ascii?Q?TFtLBgxAY16XlApPaXR0p2YiU9/Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 20:06:02.1104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8590356d-cee2-4dd5-3766-08dce7d4a24e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

It should be enabled on both bare metal and VFs.

Fixes: e189be9b2e38 ("drm/amdgpu: Add enforce_isolation sysfs attribute")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2fe75c920a73..ae692d0591ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1625,11 +1625,9 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
-		if (r)
-			return r;
-	}
+	r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
+	if (r)
+		return r;
 
 	r = device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
 	if (r)
@@ -1640,8 +1638,7 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 
 void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
 {
-	if (!amdgpu_sriov_vf(adev))
-		device_remove_file(adev->dev, &dev_attr_enforce_isolation);
+	device_remove_file(adev->dev, &dev_attr_enforce_isolation);
 	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
 }
 
-- 
2.46.2

