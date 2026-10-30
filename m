Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D8606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b0Ccr76U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2067411261A;
	Fri, 30 Oct 2026 02:48:15 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013068.outbound.protection.outlook.com
 [40.93.196.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D1811261A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 02:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcFIFERw6BkgocBkf/sRRhuRhz9wnHT51ax6+Hubjhxu9m/1xnYQdKXl5Q1OrD0WNZ3SvfIDp9k/R+jRtHY2qSzFjO1m3yvDKpNFJm4PbkAimzPCp3oGc/U2YWXEiRu2QeF1taDYFkQ4XgwwBuYoPcVIrkkBIndoIl6+ngavFlkCIcRRu6yDZBVCiX7ni3j83X5gm/UkK2rnUyqFq3JCS8qivmopuPPyC0qiO0bMW1mjs8xo6bM/erjmYayz4lKj/FtnnB96Fdx3XDK4ucQeMHxHta0TPyrDrRX233m7QPvx+okaUQ+kM/xLXfzL37MJDpHblHYECpM0wy5/uz2qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzgJ3cuPxeJZzKrk6P777Hn6gTV6VFoLTqtssIPnK58=;
 b=AFtT/7rl92u52EESE+loZpS5ChyOGhgvgg1Y6nqiKOkLUbXp41fP7WIuxD73io1HqS3h5aipv1GTLs1VZ5sT/4YrItqjddfaHyMXMBpIZ0Qa0RfXDlHsITJtiUqPX34XtLkdhjiEMvnQ5IAz51wSfj+eL64I88EiJ+tobdAKsArxfohYX55J/FxMFGYw3lVv1ZFGtLMYZo9bTK9HsahseG36nfVLSORMLW5k1cge3zpFANHdPp6frL8BZkCU8ghlp9KwJNwJuBYRWrM6NZYMDGwL/ZOdccqa5Ht0t3I3hA4iUJyngdnMYUfiS4rlBCvaZYPxauoUsbdkg3dYGJORqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzgJ3cuPxeJZzKrk6P777Hn6gTV6VFoLTqtssIPnK58=;
 b=b0Ccr76ULmiLXrnW+4mR7dmG3btxzsFHSM5vsS2c/ZZU0dt2tqNmH+z6JpX23XLC2y98wQpQyT/vpItJfj9a7E8lhCDLek0V9Km5Im7S2JZdLCcRQLJcKHsUowh0qseiFX76+H7fMgMAfBOEBrjIp/1BQvPvjsKIHdrWeRCwrEo=
Received: from SJ2P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::16)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 02:48:03 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:5da:cafe::20) by SJ2P220CA0013.outlook.office365.com
 (2603:10b6:a03:5da::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 02:48:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 02:48:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 21:47:59 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Sun peng Li <Sunpeng.Li@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: save VKMS modeset state from the system PM
 path only
Date: Fri, 30 Oct 2026 10:47:45 +0800
Message-ID: <20261030024747.3083509-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f6b59c-cf8f-4028-c19c-08df3630379d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|261009223027099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|56012099006|10067099003|261026121527099003|18002099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: oaUeJayLUbNaAb3Sp0dJoqNkDqh3hmBSRVCsBJecJWcn1ulwPfkwCEoa7/4XzqmOa9N3KyfJ+EUq9lIzK3DtYjXIc3t+rGF2PxB/Cakb8/99uHUH70PnP2NvSzghSmhaT6IOm++XU6HqjPeDlZB6jxCuJPp1jTou2GsEcp20HWwM3rxHOjjuogL04nhminAPt/f8TE3paKjGqa29ptesLPl+f5UcABtkh1zTHeRNwNuFWeHacFlrwDJwHgxr3IrqlGx7mq8XKe/Zwtzs7YJz/k1RqMjSmDcJz/HeDVkhLNwOvsf3SMKrBslOow12V2QKR9jL46n4vVwffD8HcWqoIUyfOl3XZkokJzg5CIbLm6xxll1hkA+KKqXY0dYohgZ6HwZ6mNAgWmj3tycOG70pYFyPiwgVMVeAa7ie7+yIy3fAv10LDalwpJ7C79WthoaSyEZCJ630lyros02xRDKojnflCnJ4CQMmJWKc3DrritBBHPbYCLJbfCiOD78WFl4lOYk9BFHwO/cyKt/kHfT/B2Je8bvZdyETnvRlaePC0oMhlPUQnyAAM+zKA8Z+p53sCjDzr2h60dJcYj1QUyYCHyIHATejBOeom5FUdIcHwoYLsTH1y2Yea/jVIXPx4yTC06GSzM2Rvjj0XKbslK3N8CfGaDAfZki3BHyhJPwtnkkKede0AEYFVSI81mLBOrllL9dJfrCW7IA6asTACckvew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(261009223027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(10067099003)(261026121527099003)(18002099003)(11063799006)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ceyF89RmU8XIFHreHmKqnutJnoOSWfp3LzDRpFG9TBHN40TT8rnSktHz6KHRYne13u62RVJEGKt/ktk0fhFykln4kV+qP1E4DmStVMZx8G+O0SuuSxBVAJpBq4Pkt8f+X2yAfczsE+y6GUWdr1JE4aDywy2HKbwds1remc/O7nXzeX8SJGUyNqwwzsUPmco/BpVZMittWs5AhnJ65Hg3eB3EK6+oAq8uWYXO7TmYLMdxG60++RD2sW1rH2Zs7i5DHt7vBJpygldHOimjEHYQ3lrL9pe/bmk7vwVo6s8yrZdtjXdg6zjuyCHqkco80jiH43EmzpeQDRqDQDvkthVOBMG80ZbU1oBWH2Aw43djjrE/gsavWOP008pCceN4ypFGbYoyooQfN1i4VxdvvedjkBb+ZiLK0KP2pCspTKJ2CeCDxT5U6XMfW5r6YEODuLX3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:48:02.8013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f6b59c-cf8f-4028-c19c-08df3630379d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c   | 14 +-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3ced5c18daaa..65c60b47189f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4570,9 +4570,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
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
@@ -4620,6 +4627,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 		return r;
 	}
 
+unwind_vkms:
+	if (adev->enable_virtual_display)
+		drm_mode_config_helper_resume(dev);
+
 unwind_smartshift:
 	rec = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
 	if (rec) {
@@ -4719,6 +4730,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
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

