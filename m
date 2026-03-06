Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F31F513F3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8406910E313;
	Fri,  6 Mar 2026 03:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Dj6uuj8";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B649A10E313
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccGrD5ObSQIYcRhD7JOH/NLtF9671kntKBx55uMincVNAreSOzGl+y/qklHxXs1OgUB0rIXVNO3J8I/KjOQQSmdCzH/Y2gUQCNgnPpd2UJi4Er+ZLsIUKR20biVU6P0KY8bqRB5VuvUik1tw+W3eAX3BgEGxE6JvGuuKIFXPNhfK2AolN4bmYwwY38GOKAdgjIbTT6jl4qDPpivu4ZocIyDEL/1trWjGPcB0/IS5nCtPardiCqIhiD5bb470SkrJFzx3UIIk2CeIDtv+UbqxWoK6nTdnxPjSStNCzqh0TuC/3I/9akVgu/F1/co8lOXBvatyW+mYBvTGttd/UYvDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BZCxpxhZpBFM1xk/0h1FSRTVr6OjDhQaI3ovsMEg+0=;
 b=abh3pRxYYlQprX8iJkdxfSfw/DXX8HWkrUvxHeV2BxlCSkRo30jxamxGSEZuxZXU9CtvQvy6nssg/uig/2I1rOo5iE/NWPfV6g5ZMBLKqgRFHUlnS0gamdrtH5fB5lRIrXERC6Sz5skHd28BwVGcHYWehjefVCGXjExg+z1eF720ckUOGhQTFi1ALIRMcZIuAiuBI5of+5dJyg3fGBX/KLvdV7C+FbbZ3xge5duOd/0kecye3fz9PqlN1v2jp0+JUWrxv03xx/3pYitnYhKJ6Ddlf/wEluUD9U3fQqbPaqLGSJtGJdb0p24bE0XTDbMHeqKmx22t/XD/sJAhV5bwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BZCxpxhZpBFM1xk/0h1FSRTVr6OjDhQaI3ovsMEg+0=;
 b=1Dj6uuj8ZaIxQJvFTqVbvpaa0oumgxL3kobTfw6FCnhtMqUT0jQ8y6ros2lBOrreRqUyzoKHLalzrG8QlD0FWwMF+WbbsrnwDtlB+Jl+8V8emjBqVg3Mfkt/Dz2HQ7qLGyABmC5SK8d+474soBx6zMk3IifMGVo8HsGAdXzP+8E=
Received: from SJ0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:a03:2ef::32)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:43:08 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::35) by SJ0PR03CA0207.outlook.office365.com
 (2603:10b6:a03:2ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 03:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:43:07 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Mar 2026 21:43:06 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 3/5] drm/amdgpu: Wire userq manager to fpriv eventfd manager
Date: Fri, 6 Mar 2026 09:12:45 +0530
Message-ID: <20260306034247.1783347-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306034247.1783347-1-srinivasan.shanmugam@amd.com>
References: <20260306034247.1783347-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfd1387-12bd-4c90-e033-08de7b327b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: updfX0//9RjMdB8Z4OX4x2Hv9qPOoyy2jdgKupA7vCoIjXKQXJK783SrWYzrpK/lirr0hioR4JxZ446op0Ux1HWpBolbzvinjVeJNpZubP4CAq5qqhyczjWFm5meLnUGM0pmyy5IUVs5Tby1DilTRICyshG/wXEEuOAAIZOkznFDcvR3CsNwlSI4vQXz4pC1dkcvOr+6YdaBBKHBGwADGoVkvkz4HRK47VSiq+4c/jteGgSw4FXGL7RUIfPSd6yX0K/b4fx1zXa406y9RVymR6CKfCKxZmSVPxvIYbYZipJxZQa9aMgw5asgjkX2lwA9yi3liTutZKvhTNEQL2tPxtAt1opMjZnwX2rkuetj5McMeIufGuLjDMJKG2Szdk6ILFmkTWNFEfZO0/LYNXjaY8ebaBmFH4Bamk8OIrZHwlnT8fnDEPFkAsq55vD9BGW8Bliq42bxyVh4bH/lwOPv+nleTR+YRQQiJZww/XLZ8lEcW2QQVt0czUgYTz50pGHs4MimhDTOveMgMNyRqYzQYvdsjukTNvoQuJhaLE66ErKF2kvzGRrjcakLQFvedjdcalL79PvoVQN7Y+TJm3+tgK74M4fMuRsBT2tX/KGb8zQFl4IMRSnRI6+6PA57GdB3pZ9VjIQZPaZE2Zc9X29yXu1kzr5DcFf+MFmy0pFFgocp65IiW7lQ9Cc8JsQT+HFxTHRiGfMyED7mf38kh6OVCmL6MTwD3QVpz7FzZjwSLXO7E2x7r20q0FDBtSBSMVV+yv1aCZEzA1nAb9D97tJmOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t2/IJE34D8FhRwsiAc616kzsk1PcIV92fEeqVgxMJKAHmARlU/GHAMarYip/Aph6Q0qZ8BJbeFyTtgEAMoM6RGiRMrMCj2gVBdeIDlRayXu7JvG99I2NrcYzUca/EAmo4CM+fylPnfPfzxsKUEXN8Uck5GNtX+XuFccrh6aHsXKPV/3peex4BMe4x6SfkG+XIEV43QQhOZGxN9BdeUj37v0Z8arDfYBcDcOl274trdT/oN2nilMXLYV5ZgzNzJAwrAhiBpha4wh3JTD3C5SYwj82Fw8F1P+Liah8JFSkBivSfRw9sLw239GPYXzhg1JvwXy3v0n6H0lfkvjV8J9f5Em1aWtA8z4irURghKP777j0yq+Mk4qpna3omquv17IHUDI7xyqoARfWCer3GzUD87hvqAkttSI/y8+EKbZaoCTyA6UAIJvMuW2mve34WPLC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:43:07.9282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfd1387-12bd-4c90-e033-08de7b327b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
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

Store a direct pointer from amdgpu_userq_mgr to the per-file eventfd
manager embedded in amdgpu_fpriv.

This lets IRQ-side paths signal the correct render-node eventfd manager
directly, without walking back through drm_file -> driver_priv.

The pointer is optional and may be NULL until the manager is initialized.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e07b2082cf25..fcc9d6a11924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1349,10 +1349,13 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev)
 {
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+
 	mutex_init(&userq_mgr->userq_mutex);
 	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
+	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index f4d1d46ae15e..86c4a2d4748d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -104,6 +104,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+	struct amdgpu_eventfd_mgr	*eventfd_mgr;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
-- 
2.34.1

