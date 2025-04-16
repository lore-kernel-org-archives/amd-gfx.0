Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BEFC369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 08:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256D210E175;
	Wed, 16 Apr 2025 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cU48UHmV";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34D410E175
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 08:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wn1HRlruPkyk9ZY1WxHeaX9uuMLkQ0sck4dy4tFS98hjPjYfQaO4wr5JAUVB+mtnA1RdLDELZ2AstBFyiyTuko8rQ383e9jS5NKFZFYXdQBNRljBuNsX8wUjqz7FJrpvKDA16nowxt3LDMlwTaFCSXs6gk7sBd3MOpmEx03DYU/pLFm8rXdhTJu2XmgZfRtsjCQFJ7jq+IlHerRLBNi9AkuGhVnHAJwa2JSg9Cd5g6/kw1E92U2h9EcRmMTWD5TLVYMPgxvK/7HgSKwa9QeUcbBxt+Y6GmeycS3pm0AW0FX+dLjOWnM9CxTXWD4JtO3O7Gqu8ObHAGLOFhZX/JSepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OKSQmRyHWzhHGGhd9E35/j/e9eiO09yw/ajbYL0gYU=;
 b=sVIRm0+RWfCWYJ7pnm4DqBidNrZ6+OH5Z8BZ8wcxsDvTDx2oWrk0sFEtPny7nOqT+iHpxUMPSlsQ+nwQEHNKFiJqDI3XzdEAu6+ZJqPFc+IZtgKuOebPpXtsL4/Krt+gC/OfOHNTiFAA+x70OmQN8cFKMMACqdH3EmCXdsyCRyqmY3IrT3EUme3NyU0kt/kyrakNtqNZzBobfOQ2CcMk/yJiXlaw6kAjvRUa5vN7hy5EFurZUYxC64NFD3MmkBkFAtKHSusNkhLyax7IWkppAGw8RI/H/Z/Ibegbv7xnft1KxnHcMXsZxYeYwLHQjLiG0eVf+92DwaQy2KmOM/Pqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OKSQmRyHWzhHGGhd9E35/j/e9eiO09yw/ajbYL0gYU=;
 b=cU48UHmVphSVhP5bT+YAbEIqF7bBnQKJmgw0y6g+keIr58o6KfR7fkYgP0db8zHb0NvYRrjJ7RkGa0L1eI2ReMW5fS+fDS4VrpzSQKBi8q9iF0q1hGgMFA4Q/biCvgxIzUjOtAq3k/06g4kxmEp0pTaTltuHP679Jry8R3Qx68Q=
Received: from CH2PR07CA0052.namprd07.prod.outlook.com (2603:10b6:610:5b::26)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 08:05:02 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::ad) by CH2PR07CA0052.outlook.office365.com
 (2603:10b6:610:5b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 16 Apr 2025 08:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 08:05:02 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 03:04:59 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Disallow partition query during reset
Date: Wed, 16 Apr 2025 13:34:42 +0530
Message-ID: <20250416080442.849968-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a8c165-a614-405a-0bed-08dd7cbd63ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u3iWF99nKRHDrzSMOac00F44UxZ4b2DqznQgvvZ7pbLg3aGCHmGJnZ+SYRUl?=
 =?us-ascii?Q?poam8AqeTtBwTvfT1g00pxLz4KvmubBeiREkJ/IxjC3MagYSRoHYonXIc0x9?=
 =?us-ascii?Q?BsFjktxe6uTqje/gueoPhcWQLx8HKYI2pyf4vyWO2qUqcNU5GvaC20I1xJ/z?=
 =?us-ascii?Q?gle8dLC2xh7U24/DNHw0rs7Ji+owiRbmTCWtOotB+doANLrMrCQZ+eyQHvQA?=
 =?us-ascii?Q?PO8L9LGEKwX7jz0v88mkzvTTCX2Gf5Y+xAkUWOkpOcqRc8n185AM8Ucmt99P?=
 =?us-ascii?Q?YfXwCoj8TpOhGipEJf9iXodcnIZOQmBky152Z1ww6Khgj/ep0YQvz8QNw6NC?=
 =?us-ascii?Q?ZbJiBqOSdbeWaavy/E5t8NndeW5wKIcsrma9kpG+holTJsrU9AgEMi8Ar2la?=
 =?us-ascii?Q?79asyyFTvA1teynMc8UndEaJXQzakBnXpgUUKDc3/IvX7lZMMtwhbXDpEYv4?=
 =?us-ascii?Q?ec/u2FxgkudbSU+Z5jdzqVH4tI2aGRTQc8KdypNj0k3ucPY4emQ40NC2uhxG?=
 =?us-ascii?Q?9U5EqK58PuzJYH+WfNys9QsUxeudRAjppNJeStRlOwQLGyKcKSeRHd3f2oIC?=
 =?us-ascii?Q?eWRnPHqsnfmQbfps8cFk5sUo0GEvad6Qz4xMogpdTQVRCPFeOeO7JQl7dVOH?=
 =?us-ascii?Q?Y4swkIurI2vx2wmvoiIi0WLCCOeg/qwRV8KcV/sBei55U/mlx+OUDZJD0iTP?=
 =?us-ascii?Q?AjrSQ/2+wePATAeXC6C8rT38FiKYI5gnZi1MBCgqo0D+WhbygIyWSR/V4bgF?=
 =?us-ascii?Q?+LlP+gGnpNUrL8AgUQtmrwAO/Jj8mMLodlJFpCkbzONJEY9nLzC+DhlCsMQ0?=
 =?us-ascii?Q?ppSbIM+ffPlVdBBN6K1om9xsWvjg0EnljpdGS2SrJh4f2K2x0J9Xyx9t3S5m?=
 =?us-ascii?Q?7sZxzUYiggICbJEPU7j3WVCMtpDansOlX4MC2CdSHVYNrI74hI+FjqHKeUsg?=
 =?us-ascii?Q?BoTGVP931guRPSKnkU+PjfAivKwm9y4KCHZcjAeb/oNDMowKW9BW+3v4Wj4F?=
 =?us-ascii?Q?95MXptfhI5BhVfmTSu8HdZbq5F4rzK0V1fQA4cDChH7WTaCYZq8GvPZjFGUh?=
 =?us-ascii?Q?WXPZI/m73FxavyHaU6bSYPn2KUk+r7F2h9Z6dl/GgZiugk3N36IG0iF9kP+x?=
 =?us-ascii?Q?v2KK3wH3m+cPMVk4FEkyxkFLbfOUmgJ8H/Xj4F/9iWCKhaGP0o1tMosC46XM?=
 =?us-ascii?Q?lfklo8xSuIbmw5jwY++sYWFGQJrK99RuU4Jm1DmMYz1NosQt2UzlCwXJkfD2?=
 =?us-ascii?Q?hY37dDUaQYbE7dJiTFjGlAiIXnZkbynx1yp+DdcPmkQCHaoF+k0BJ26Ch97g?=
 =?us-ascii?Q?RnR9/9vH5I+XuACN7m13lrBQxXE0VGIxAPe5cGrJzIulYDJ0Ev35If0DzpVK?=
 =?us-ascii?Q?+bQnnN95OKPO+NBOphM2dlW3+Zuys+j/S/SS5JUyMvfMttMKghT9KmmvoPbm?=
 =?us-ascii?Q?bHMmc4ogoC8PTqbr0zUqSFtVeN0Fja8PK4QRcp5DtefjZvrNuXCc7K/ZOEPz?=
 =?us-ascii?Q?Wq0PpDdJSiFPeFObxhDOSPwshBGkWMK391vv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:05:02.0808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a8c165-a614-405a-0bed-08dd7cbd63ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

Reject queries to get current partition modes during reset. Also, don't
accept sysfs interface requests to switch compute partition mode while
in reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2c933d436e56..f21051b82ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1353,6 +1353,10 @@ static ssize_t amdgpu_gfx_get_current_compute_partition(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int mode;
 
+	/* Only minimal precaution taken to reject requests while in reset.*/
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
 	mode = amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
 					       AMDGPU_XCP_FL_NONE);
 
@@ -1396,8 +1400,14 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 		return -EINVAL;
 	}
 
+	/* Don't allow a switch while under reset */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return -EBUSY;
+
 	ret = amdgpu_xcp_switch_partition_mode(adev->xcp_mgr, mode);
 
+	up_read(&adev->reset_domain->sem);
+
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ecb74ccf1d90..6b0fbbb91e57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1230,6 +1230,10 @@ static ssize_t current_memory_partition_show(
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	enum amdgpu_memory_partition mode;
 
+	/* Only minimal precaution taken to reject requests while in reset */
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
 	mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 	if ((mode >= ARRAY_SIZE(nps_desc)) ||
 	    (BIT(mode) & AMDGPU_ALL_NPS_MASK) != BIT(mode))
-- 
2.25.1

