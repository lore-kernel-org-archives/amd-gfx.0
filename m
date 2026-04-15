Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FF8F43857
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D6B10E715;
	Wed, 15 Apr 2026 16:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AyBsRUnq";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB6710E24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPny5lVisu9DfoowD0LDCp6HnZ76uap+WxxwGonKKRy+6qkdrPHdkj7XIeKqUKnCAiHgMz/eW5LDmCil54kE0jy5TDVFWB4wGfrxqUQeWyqr5M1KMfitPEt+TFK/DHgM9nPMX9llj/4KnKKfBo2qBrgD/klCBEh82fgT0kYpFCUmuTP2mgtO8KHWIJkNF1Nrkb7K+efXENkECUk4EzL0qCxisO3oTArjRe1/4Lx/RpWfWMEoWPz+pmVhxePCSA9eItCBg4CMU9ZGNk53DAMGyhYTRaUF8302RpJ3ewDQXSM7KGAzZHeKVp9yiltvT6r9H8hl5jKfEsFduzNY5Z944Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWFt/RNUMCwJueL8ehlf9O5NMLfkbg6H+pbGP8GPM6Y=;
 b=SFtaKRHa/xwEVblQExZMeMrv6/IfstMYgEnLYiBtvX+uYyOjnISnp2HHgCZlyZPB76Ev+ehiWZjREzFhmUoNrC5quHnlkIwOUAjhXxe0uI64B3b5WQ1WoGopAfCIZ8M2kSKwshJ14IkQsNW1xeZqB9M5iYUBmvN7x5zoNyifTCUFQWCkSxfoBmpl5nfCZwu3MDD13sgcVoBBovWRPLGA+2C2keIUSI5V3GXHqDu5zT6P4neE6R4aTcW5TyijU/jixSVdFgtFeZaaDufoCkDw/6jwO/eZa83l8NPhvBkLOg8cv9J/U0r2Zx2oTeYiwD2yKdXRUwtWknPE9G56NIpCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWFt/RNUMCwJueL8ehlf9O5NMLfkbg6H+pbGP8GPM6Y=;
 b=AyBsRUnqGP1loI34U6oChKQMIOj4M6PGWsd8Zm6j42q9PaQRyekbPkE3WH2iNWSvDZfgxWYZ1KpN9NnAWDAH3YS3cXPDpM/XLVkfoXtssXiJL+4cs8o+4/3GQZ/FNAlEhp+S+bwKp4IHWCGTVbGIqlqiHhhfkEP0jlPJocZLcmI=
Received: from SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::16)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 16:07:40 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::1) by SA1P222CA0188.outlook.office365.com
 (2603:10b6:806:3c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 16:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:39 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 03/10] drm/amdgpu: Register WAIT_EVENT ioctl
Date: Wed, 15 Apr 2026 21:37:04 +0530
Message-ID: <20260415160711.261553-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
References: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6ce0a4-5aac-476d-ff4b-08de9b091e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: enSOlLw/2vUrMaIRFpn7DgJ3LL14J1hpUjPAXs+rQfUzlpDCbuyHkfnreFkCrSvOSBzP+HmUDh47wwOiJtiO/vHpY7emrcupjwpGoqoMQO7MpO03FxkhJQMxDbx69lNWBfb/+t6up/AbAe++khCFHQ7jjmsGI+7oopeXtitTvip9r6JrnBwVVtkJVQI9SFrIBKZ4jNRW5mkbxbJrjKemkbO3qJ6PfZKNrelW5ICStmeOAYA9szrWam5UpK6YmGlrVA1kDmlXPnYIkUdw4ezlazLxfFDWTuernKeg6lgdBiTWPpFjoDDf+zjMhFiq4R6Rn1cj6f8hGmrQnbLJ9ph7dVSt5ebh8V6pvk/EqWU6orUekPPjbwxNBbSAgDeMsjwQ3GpK+jEX1sUF5UsbTWB+ofLtav/KniCa6zdaPXEamTfpzqdcwdj0w4WDACjUfzQYaGTunCY28nMCN5++jlJR5SiWPSJZ7Hv6V/hHGCSMFlWy7QGS73oTejhjgLsSRRBj6GbPj0vkJB0+1XPC04yIeNjSmPOfpMszqjHABR+WIkn9aqobiD23iovnypcB2Qqugx5UHkUMcnizEf0h3xWru9mmtHBu7bDTZ3UWICbIqH4Y4CWXHNriMHjSByXmgTxQuqn2qeTnBMnrGVkTWWN06s5KoYill+YejvVwXYFP6Hh9xH4PAlNkIKNbAARbMT7CTegb19IPoh3JqUdZEATadWR6E/jCOt0f4aVvZVVwFyDkpQ8SkWW6iUYlb0G7HcY5DsBRT1vFqTPAAKB0oAMkNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: px0hdUd9wFxtgxKaiWtXUyNW4A3scdPXU9FxdX0LLXNR/rpJSFYpiobZc3ptVeqNTvH5hZE7pbEugqh5TQudsdN86mJ0w+W1IEtBNJPR4l/dsWPgyVX54AeXIvwJd4vwuuYhXa7PTYHqS8azzZNIaytRCioIJFb9iBCXZ2QSJyerjDSyzVR3gssmgODz18tXyfMkwh1eriNmV8Y4q2bnn8LWipjz/ZhH5ee2WV145NgwJ8qT29O5rH+o1dc+B0ME0qjyTNZsRQks9nzHdx7cVvQNbZ3rNUM6Qgz09Finu1wsPICBFtfReuf06bZgnih3RO+Tgju1qJN/Y84g28I5i7aIwUVLlptLnYz8Cb1G7Rsoe5bOv1yKAEsmlW3UkNKsegMCzkX96YQdg8ZUvmlsOEDh4+vEQFMpG8e5TJ4YBYAZP1una/lHVAV9cbWCTeRe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:39.8146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6ce0a4-5aac-476d-ff4b-08de9b091e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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

Register the WAIT_EVENT ioctl for render-node event consumption.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f4acb785b3fb..91b143c3683e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3079,6 +3079,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
-- 
2.34.1

