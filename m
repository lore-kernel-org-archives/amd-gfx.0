Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52171F34C5F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AD710E4B0;
	Mon, 13 Apr 2026 14:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K3lPHnd0";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEF410E4B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 14:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9tVxrKMpxfMioLtWHX8eqG45d37jp+c7l4CwKcmhhGNb0Ro8b6glDRBc9Ae85rhVR7D2JCB22G6RFn0/JaLwUwObpHBx+G1jttLzJg41j5WOl1uUH5EszHABREuVnSL2xbJwRQbpV5kYm9//KZD38j1cKnEGTqhpyMt3kTIOGdkpiBv/34IDDUFJcKxr37JjqjI+AqBiSWg/wrN4cWoA56kG8A9fidkFrWZVKPf0j2C5OLnJEJEBXP/nT+FzV6Rh7V37akB8V3Lm3EfF6K1y3E7Xv09hLL1zJH+DgUitGrnKyLh+voyvUnMiWI89vW/Gqymki56qiwHdvTz7rLKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJWG/tdn70sGsEGK4wmeluz7/KY8DdI+AXQfrNRdJxQ=;
 b=Y/SDBhYfjqBaPISvWMdmSz4uihG7ECbigdVSntukaoSc4FGrCLKxHXeAg1WODDxYJPNYOldZNnTLUMTjU0SGRhkLxMw1o5Now+NkK3y/xpNmKB1KZyBsh1rY99l7G+vm1AW0Pk03MlLH8D6+j56LVZ1KRiM6ynsIzGgSZUBdD189hpTizy9NCeQpqSdDEd/CAXlnoFFYJAY4NlxGaZ6B3kgszt/qMCude+y24UM2mdhy7g+/y5lhVE/hsphTrMW9jddrOB9clC82jgZWIJu5FVZ1ugaFC5K6E7sMwdZvpsvcjDAEnx+aBDPJAAYXaylBa5mWRad0FOQaIXZOFc2R8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJWG/tdn70sGsEGK4wmeluz7/KY8DdI+AXQfrNRdJxQ=;
 b=K3lPHnd0R5a7hRckROrJg7i8xWjspw9v2XXkdJTrSDnydNRW/KraCnr1WYIhqH23+hpVYISrSa4OPa8PCFYqqvB50nAcVZprWN8JF3HSohCAjHIYFuBRRLdkCIMw6znBdqVijH1toLZ9xv6mqBmJsNi0Ld/QnxcBNGmY8XzX8u0=
Received: from DM6PR08CA0050.namprd08.prod.outlook.com (2603:10b6:5:1e0::24)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 14:58:23 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::c7) by DM6PR08CA0050.outlook.office365.com
 (2603:10b6:5:1e0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 14:58:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Apr 2026 09:58:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 3/4] drm/amdgpu: Register WAIT_EVENT ioctl
Date: Mon, 13 Apr 2026 20:27:44 +0530
Message-ID: <20260413145745.2326236-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413145745.2326236-1-srinivasan.shanmugam@amd.com>
References: <20260413145745.2326236-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 52bfdffe-9ef3-44be-f189-08de996d19f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f1TibXWEEIWUKlCoGsgX1K/OXWFLqYJOywyT/sAl09LW4saJmOZXuFH0Zd2Bm7cD5QaaOoyUK6LdmlNniMwvm6t7rtxie7eOvFXgcobr7rJb/QqsFuvI8fOhZoGLC+Jh7JPRBUcCy6r9pHPNIzGPXYSfzcVydATjiStrngbOBE77ExiKuz4SzlJ/Womva+d8C2U8A29xHwVTkXvSKg/WzcpjsIqf0RDI3t+LPsNcM+4Kjt3LepylOcye3xjzEE/zw4alfGXLa8QMDNZkmjvyMBPCDDmmIaVvNkgjHMTiHzeylykpxDOxvl3LTUQhP6QRPGitoD7qjxzy3fw9fw84c/TwYWAI1y0X42lUqj9nasEDmdTKQZ+NP4P/qBnf1FzGwuVLJJ3IWdgc5I5hZLQlcqGgNykN4lXjK4XBQ2K9OcENSjKNp1kAauX4n7rvr70ly2ZDgg3wSQDBJFphMuJx8j3Ke3qQaKs5y9s+z0aUwFAZOywn3zzKmwp2lBzKQ2AGRc9kSa/1C4fFAxNTeOBL3tZzwMKCyVamLkYvB1N98q54tU/yp/O+IOiGed8z13tLthp2Rhy7texwZj1etiyiWJYkueIQxv4iXCtDn1IPEKwGXAzE9CvS1KFv9mwhtsvMt9vLbOfY2liRYBs1tNXx7TC0ok+rAKYqnCfoVyrC0Tw6smeGREzMcMjI2cNNiT3/OE2LjvanjGxKoEhsFwUC5nGYQ3zjrr7lPbWCObmrLzfTXaOKh6xoBD2vdDVPj3gbnefuPjAQUKR9MtcUASz8GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TMsKmcLFiP4a/51Ay4SDMDV86jNbFYAkIgXNvl1vCBYgQ1+a3xzZUgGCTJILxL4jw1ncXpsPGDuHZT8iLr6X6F3JZDeEYIyguF6AIpL0vuHIkI9D+yrFBoGzLbQf5Yg2UN7Pfppakn6AO5x9aNpoyYQh0IXV8PQy5op3aqlchcM+ecfMIfyh/EOX62Gn4P59cMEq0slUSEgPbAeOXJo3VBoFkXxWk2hYSZ7fV3BDiZGQ4qDAJPqvFswsB5eWT8lxKTtnifJGePHNAuzGsq9WnCag3J3zOvn5HEITwUPpQSXUPXYoRKTvS3LPLyuD7CvyhHRx/Oa+GM4+1/ecYee94c3QyuDVAp0+emSmAgqDPrr2IOp+5yIyS7ovCXeADEjozL6RDylm9fPjMHwMlRxltZKnR+/Zt1RB1z7+xdZ8mxb5ObOH29PejA4TkX3HzePc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:58:19.9039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bfdffe-9ef3-44be-f189-08de996d19f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665
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
index 7e5cf9ada14f..78896283f389 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3066,6 +3066,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
-- 
2.34.1

