Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA6DD10F37
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 04:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7911110E25C;
	Mon, 18 Nov 2024 04:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/Mlx6Ft";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB4410E25C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 04:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3+BrOXhniJC/SPXSBpotS+BZdLHpU8lOZDvk8rQi+zjnTY1F1fsd8N+p3mgg95XCdAILRww4q8yEUGi/DcNXkB5JQpchBsN4X1Lf6j+FXKGZhk1hZ7mgeVqBSMOIFdEr1aOyTwdoys8BbvQ0PAA01Cpk56A4IXockauGBoqIUFPtVYOsW77XXAiaXzYU6QdvnGVn933VPBEV5BKQm/4PgsYqQAb2aOw1vfPgBAoPEgJWkCoze1gRT1bdeA86UIxs0Jt46EemO5+0fR9ekRKmuwYs7Pv8MRY+wTwz81gIOYugpZ2pOjhbD4YO7AdU1iqQVdHlbajCftA7X7qOKLreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHHdOIrnjVNkOyKyZqTUz9OntZ+1tMQqk1TZwStAnTA=;
 b=yKs8bFPT55Ox0nNfjuz77pvuL8jny/KwIDygfYpWGF1rg1k8K1ExEz+fcJBvPBw6lI9xE3X3PcentwOmV/Or5KCbY/YH7EYo7DIMqfeBfyf0cSZibOqXN8RarRqbRCJH0de/lRkooy7Xmp7QZG704c33fDhZPjO4RGAVmZ2zKXWENY9N4ko+KbrfFzihvwqurec1WwqroR6O//3sykUtq4YKm7qlXd5EEZdkFB01l7uIX8V6BWHJTxUUPGGDj7rY97YEEwj6/ewvfWxcUtSWFa74gNIMtGOSD0yFhIi75FI8W3Xpr0/Fk+G/KUzt/kGWXOplGFiG0idU/8efyrKonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHHdOIrnjVNkOyKyZqTUz9OntZ+1tMQqk1TZwStAnTA=;
 b=h/Mlx6FtoyFMz6FrECOb10CPcXbhkIJ4w2/TW0mKeLb6GW/Z3F09dYtpi4nXFNeEaj0HBpukK+AFHUhiz2RNG+e6Lc7R6P1STnI6JUMY0I7n+I9A5VL+/eIMRmLbFDA24T/JJyn9M/GIpXCXbEBJ+nm9w9f0EspVdmzghEOTt8M=
Received: from SA9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::14)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Mon, 18 Nov
 2024 04:34:01 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::85) by SA9P221CA0009.outlook.office365.com
 (2603:10b6:806:25::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 04:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 04:33:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 22:31:36 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 17 Nov 2024 22:31:29 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: fix a mistake when removing
 mem_info_preempt_used sysfs"
Date: Mon, 18 Nov 2024 12:31:26 +0800
Message-ID: <20241118043128.3834919-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f65839-a23c-426c-8858-08dd078a39f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?84ysGIMqFCxaAu/lrvvmZQYbz+WpIK0LZv0OPwkcsxhXEfmidrbwPb9oqNDz?=
 =?us-ascii?Q?91nARfkfQo6/VTdF62OT3aPyu0qdjJO1T+RmJpCa7VY8ZdQORqoGHWwE81fZ?=
 =?us-ascii?Q?zAftGC3wAR2l0/oRBRSMbLJjkhe09cVbokfL0J4RqY+tVv/Fek3S/CW3/y93?=
 =?us-ascii?Q?KmN/5BG+Op8j/65tJD+QGuerG+iRx3PYtRAKVYxcuCjF56/c2tkPAim4GQEm?=
 =?us-ascii?Q?MRiGS24sG6PClcTm4cWikJb9Hvmr/1uyTYTG+xUIiaM1gnn3JFBNj3nc0KQv?=
 =?us-ascii?Q?h7eBQnACJV679rzg6TQAfVtPJf12wuziG4wLlG5B0f+NutZftKoDM85DlW8m?=
 =?us-ascii?Q?bgFGDqx/ew5Kri7Gi5LSAy10Ij47yDTaR1QERl7u2msCwCqbKQqbZxJpMmRU?=
 =?us-ascii?Q?U2JlQFntJCOjRkX9cysOplu92p8t6Exk8rYDeppeNyIWVW+IfOabu2+kdWca?=
 =?us-ascii?Q?7XAETRWzM8Q3S2BhcY0+v0BNDC4mGbo75s3CS2Fb4UI7IGYMyuTrZTYK8qAv?=
 =?us-ascii?Q?JKIqhGn38xMeKv3K95NXuTpiz3fIDlPddtHJvdt20p+THA4zwqyCxagtNv3/?=
 =?us-ascii?Q?OMcm+u0nUNyjng7PW6sI14hNYpWQLVJzicya5hw1nR5c5Juix6+9BIx3ivuR?=
 =?us-ascii?Q?uV7HplSnhhUtUXcEyN7/1+mVmVshtFNOS8nEUeG/jc+ayVxhaag9AuXKwEz9?=
 =?us-ascii?Q?ahed7FVoU2xiA45CFk+hHPqucPw/h1nqaanwB3jMp4TIo7hprApY7h0ldgZP?=
 =?us-ascii?Q?7rbsrLjd5yUwr84UqghWvxrGxg8gy+qg11tYC+GOdq6KihJSFJcEuu28eXq4?=
 =?us-ascii?Q?p7DWOyyn0M7jr0Jz0PUqA8qY43hWBicXOWRgKr0QLE0W17WzbB+QdBjPKpG+?=
 =?us-ascii?Q?vK5Dwpceh9Kj0l2D6rQcMEBJ9qEfd+HRwLmy04QkCu6N4PhP92R7AjFdeLHt?=
 =?us-ascii?Q?rXG9kSlSvOZWyBObUrymmaSSVJUvWVrzzp0cxyh0z49M8klryqVnbNfYQEa3?=
 =?us-ascii?Q?BG7RC3+GfimFvWxfoGUWB/9r/CjxNf8WVe2OeuaW47ps0GQtFpc1bxK2W+p1?=
 =?us-ascii?Q?scptwzy+i28b2Bs6cP3NbHsL56VYVmYIvrVjOx4jL7/oWGhQ5gGN4zvWiPUB?=
 =?us-ascii?Q?zhEgx8P0a/BBYGnTnZgftvL5MhLIfh2BqF/J0csY8z8D6nIhTc7ciaSEITaR?=
 =?us-ascii?Q?jIHtcURMG/jYvi3adTchjeJgFg7YP4tyBkxg5qs+wfv1FEBD/MwYCGFTouoo?=
 =?us-ascii?Q?Y7fxn6gjEWGOSKW2wEa7v3Bbv/O/ebHZzgFth315T9bMHRyIvlOQKOyBlfYC?=
 =?us-ascii?Q?tBfxl62dL1VAjsE0XTkPhntXEluvGGpewuZwHwWs4vxUKJD2xGThbT7Vw1NV?=
 =?us-ascii?Q?JgqEbusXlAZh7N7N7bT2+hXV3UsMnjfzFPoMwKPuFRU29BGXEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 04:33:57.6195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f65839-a23c-426c-8858-08dd078a39f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This reverts commit 10aec8943bcc5123288ded8c97e78312bcf17fb1.
the dev->unplugged flag will also be set to true ,
Only uninstall the driver by amdgpu_exit, not actually unplug the device.
that will cause a new issue.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index 9a0346ed6ea4..33a714ddfbbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -138,7 +138,7 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
 		drm_dev_exit(idx);
 	}
-- 
2.25.1

