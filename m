Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22952606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WI5INLIf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B841F112400;
	Thu, 22 Oct 2026 08:33:51 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A0E1123FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvXvLUkANO1GP0SZU609kKQX7DU3VZkWCExfk0vzRWpPPLyH+yVYKjItsu91V+/3nZIRjmb965ES2JPEWULu0z5WxmUGao5IT8WyFOxop8T3KwmG9Hxjn+Uhbk8bJGR+bogh6H7HUB62Xj8fzgA5z9rNZUHqgW5BExJrW2dGT9Svb0sijLIQQSQOYbUjVPkoYBCYuavQXorz9apLhsyhzv062mMxoUJ6wPaTjDfy2GZQxaJ2Aevjf28dzwtSWtT1NasdTBiSZGty7rYjtDMA1ku1dBjegATXwUEkSU7IyrKFm1Dtm+sesx5PsT6euNSGkMF+DFyu/EUYyb0OS/XPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LR3rLzmDTlqHFhNV90KOCWcTJsofY2/BxLpb3qtgnw=;
 b=xhwr6FM/FI6yZjibMWJ2C6bolZIdafWW0Kk3aNnxWz2JruAE8Dy3iVZ4OOgcF0pMp70OcjBpTGapmDh6GoKOpTS4iD6kmZwrRjbuiDKufTTpCddsDM7S1N8S8HCO8wiXGGclMoT8dUj9I+qolMcjG68lAzaQoLutLDz367cHO84LKaD1VhZwCxokoFpCpQHW1IzQIXNGVq7nwQZme86pF+PLEarXlBNC/spliX9675uYINijXKWrU2ta0E+/X/BLpQVUElrCvlWeEfzDvibDEFWUjLlSvFugGip7oGjV4dBfvshJ3vJWoF5Wa+aIQFP/jmJmywRzCR6GmxR6v701xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LR3rLzmDTlqHFhNV90KOCWcTJsofY2/BxLpb3qtgnw=;
 b=WI5INLIfxv0GjrY66X3QL3LRwASvvJ6Yb6/8Y0Xk8ITwa/MwLcyz2cxLQOrGDzyDghQmR0257DXvQnNZ7kiVavaQ1nqUpciQEh0wboL8i5L6PMh607Hz2RNgRymwwVRVAnZj3YEE7mLQiWXtvl5qk1wWt6hUolz8bU+TRuHOa1E=
Received: from CH2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:610:50::32)
 by EA3PR12MB828978.namprd12.prod.outlook.com (2603:10b6:303:308::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 08:33:42 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::2a) by CH2PR16CA0022.outlook.office365.com
 (2603:10b6:610:50::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:33:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:33:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:33:39 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Sun peng Li <Sunpeng.Li@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: save VKMS modeset state from the system PM
 path only
Date: Thu, 22 Oct 2026 16:33:23 +0800
Message-ID: <20261022083331.3019779-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|EA3PR12MB828978:EE_
X-MS-Office365-Filtering-Correlation-Id: cd28a51d-ca68-4916-b8db-08df30172d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: M/tbug6wcZoCLanoKcv2BLR8lrW3wHBcVSJP6rb+HY3cQAhwTe5QUk1lcEx0cLNKQ77/5OMInaNWrUNKppiRgWw5p131S5U+3UrcuNGFJ5pfGPWJQvmR0xWBAEtHhl2+KHfBZX++tpsJBr/j+x0lxVHuPdV93isEjtslcyG6yT6E0smx5ZkDCGDCKXk1UHkhBSRLB3NDHsOqYa1xGziU9KY92/cCqXt5HgrBr8cu+vWQDFHEQQ9j/6/su0eSVhyqgwFmTiXxjxdtFJGl/zO1xNxESO0sQr3fa5RgrZ+zY4HfPkce6csXdrGhJEvrJB5HIoc7aZWO0l+DD4S39Vv4RjZ/aw2xgvPvRodIuO3hVVe/Gu04WOqxbqpejLVTSQ7vNM1LMhDPGAXT9njDKDU1tt7lvmNxK2VOtP2O8hX7pJqyVZ1YYm91EObdfM5vr4j5HTlmSi2kzc2yzAlawe2yF+LunJXuV1s5UNFj4W8QtYD2hB+qAMndHg+KIrEH2s/8OTYBwx01yOMKdYsCmWaPU4PS6X7m9/8Ud6ROWqbuVVxyw41TYxmKoyjxI7zqEexa82JvCVq9WIJXcoxqClFVgqabsLyTfeIkJv6cv4JD2ZCyDr+zr/B4sNYFgTqwCSCjd+WKst5/fDs01ewA7oeh+6BMFUk4BukuBEuWSqO3deZJl0vCfnZ819Gw63l+nQUqgSrNfdgelwVoyvsrZpU+hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6pxwcg8BCcPF6tOgeFKhv29K9m+v9QwR7MYRpeGsTilh1Cwf5Vuef3sWCG982wPD+T+bEN7aECpQi+2NU+EGbGine9NTpGVtMT5EKmok1OgRBDlw7Q5J5wzNTGETaqsdIxwAdMr+F47+jaNdjgqemh0eOzu+0fphX+ePC9h9mTwIidsDKvtuQkN4Im2FO/HM5I6rN8t8ruOXS5hX/mO690sAkJck+R1555ZB2pJ2NLco6Ly6eeLhxEYFpYOVupYKDOdjittf9DIt+vqD0ktOyFWVh9D5J7IXbOLI5U3Rk6Lw/gL0B3cXuqqW2o2H4T8X3FJJPx0ab1CbnkgHBDPNKD0msBIaIxTD4EPleOUXO2vd9UYd96aCxaq1Du+tUnXWZl3tqGGe/l7pnJ7dTyt57KwpFnYjpGEMlVVHsurTfht40TNYEzeCw5k0qw0IszVw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:41.6910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd28a51d-ca68-4916-b8db-08df30172d9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB828978
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_vkms_suspend()/resume() are IP block callbacks shared by system
suspend/resume and GPU recovery. Calling drm_mode_config_helper_suspend()
and drm_mode_config_helper_resume() from them makes GPU recovery take
clientlist_mutex and the modeset locks and duplicate the atomic state
while holding reset_domain->sem. Lockdep reports:

  Chain exists of:
    &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

VKMS has no hardware state that a reset can lose, so the reset path never
needs these helpers. Call them from amdgpu_device_suspend()/resume()
instead and leave the IP callbacks with only the hardware init.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Cc: Sun peng Li (Leo) <Sunpeng.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c   | 14 +-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b74f9136aa2e..406c5f2fbee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4568,9 +4568,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_ras_suspend(adev);
 
+	/* VKMS modeset state is saved here, never from the reset path */
+	if (adev->enable_virtual_display) {
+		r = drm_mode_config_helper_suspend(dev);
+		if (r)
+			goto unwind_smartshift;
+	}
+
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
-		goto unwind_smartshift;
+		goto unwind_vkms;
 
 	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	r = amdgpu_userq_suspend(adev);
@@ -4618,6 +4625,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 		return r;
 	}
 
+unwind_vkms:
+	if (adev->enable_virtual_display)
+		drm_mode_config_helper_resume(dev);
+
 unwind_smartshift:
 	rec = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
 	if (rec) {
@@ -4717,6 +4728,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		goto exit;
 	}
 
+	if (adev->enable_virtual_display) {
+		r = drm_mode_config_helper_resume(dev);
+		if (r)
+			goto exit;
+	}
+
 	r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	if (r)
 		goto exit;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d6b51b3f216b..6de33f14d909 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -488,24 +488,12 @@ static int amdgpu_vkms_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = drm_mode_config_helper_suspend(adev_to_drm(adev));
-	if (r)
-		return r;
-
 	return 0;
 }
 
 static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = amdgpu_vkms_hw_init(ip_block);
-	if (r)
-		return r;
-	return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
+	return amdgpu_vkms_hw_init(ip_block);
 }
 
 static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_block,
-- 
2.34.1

