Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D2606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=00zepLcU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15D210E06D;
	Mon, 26 Oct 2026 23:03:19 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE08610F1BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BffnUgZ6GnnotgyMxnXDV6UEaShLJXXUyy2r79DE67+lOPagozSub1sBybuDgpYuptQBAqCRKphc7Na/0cIaVEGyvyMrVrilCFkruzR//PH6h7JmGD4F+tKLLlHp+NoZ6FiMiUWTbwJeWVCHuOl/0W0PR0jQm6nPR/mbMLk/sLpyRcghQwF7e6v4S0NV8pLdXTTkqQb1EHMpEqlERSQ6UA9HnQqq0yUjKlKBiR5ySlMkSgJCdV/fghMD2+1IGEl7vdq3IemgElzueHu0PyfvhCtgoiGoxza6eLDk4gBgF5FrPM7oPP6ktwqcGk1H8GTvka6latwqxQ7IjEntLkQ0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4QgDLbW34vVLsKYj/kz8NVBO/vGgwUWGEfb0llgunQ=;
 b=mqrF1dG8Qw1iDDEIwOAAcXP7n78cgx83nrSNT3nPoF07wDfzixtGfYffp9ibO767HSRQ3OeAWmLIqOQ6wZEjtVaVzl2lU4KGxZgH8BpO4zJOreM6X60EpU/1LjU5IAn1A46EYun5Ttjh7Xa8/iydfasSse/mDmzRHYNne5uWYzw2QF2CGjVzDT45E3JXikSwHWTjSKE3WhAMTMqfJJRxb+ycefFEmc8P+EcIYi3u+lpA9n38pfe3uw0ldkl5Fy/FgqrQV3drNIAzwJLSK+M97tbunElFoundQNmCgkz14lqM9UHQX3n97AD8pgc3blGY3XW5Fn36hD87nDH3vAugAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4QgDLbW34vVLsKYj/kz8NVBO/vGgwUWGEfb0llgunQ=;
 b=00zepLcU9zUOEKqO0weCanE0aUMi0qMF0FhNq+/GRSEseh7kInKH+BotGpm+8Qqik6KMzG3DwWTDZcqHoLAtfBR8eyHHiBwj9EijOYDpWeRsxnb00iIIwUfk6uRP9GdbBMX1ThQHkeVrseQKvRIPywzJBXFvZ6BmM6gqo65bGnY=
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by CH1PPF12253E83C.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::606) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:03:08 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::7f) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 23:03:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 23:03:07 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 18:03:05 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: Temporarily enable UALink loopback via module
 parameter
Date: Mon, 26 Oct 2026 18:59:30 -0400
Message-ID: <20261026230248.1597606-9-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026230248.1597606-1-mukul.joshi@amd.com>
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|CH1PPF12253E83C:EE_
X-MS-Office365-Filtering-Correlation-Id: ffea5dc1-eca6-4ff1-0133-08df33b54cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|11063799006|56012099006|261021121427099003|261009223027099003|261022075727099003|261021123027099003|10067099003|18002099003|261026121527099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7JvbsNf+8e0YGXrSUX3nrt3YbhJE7prDVQ8U8x11yiUlDIYXx546mOF9Xdah+f2gJE/rqFMEHDuT+HX4Bkk7GiDu6TQBkXpLhxdtbLghdM5ctnkgWcfx2NtcaGR5DLSVrN37aNvYotsWhuDGoQZ0sH6yO2ew8ViDlxVgyLNkFl1dl/g+b98tQouZNrJCSai5UDehQiTUqHokf99WEOwryTqrz6xCiN8Gqpb3vS9h/gIAJNMrgslZXaSia9vzL3t8YOoUc8GVoVWo+DVRtu25+ilwXV01ShWkw0nt7Tc6/dn3Fmsm0XdQgij8v0KHx3U27FI0BXxpJSGAhe8wog9HK8Ocm08/sCXkZGoHlmaKq4qlOuPvOoRj9xYkj5X9ItBfmuX0fC6gfKIYeIu0UbW003yFM6x93Ha6aJX3b+Wd93j4hAYcKWbAYtMYnbfuEzxv7MYNcMIVuJ8NpNW5VSdXEM1LKPD1ndTwYb5Gxz4DDYRAmTQq4ewwrHFLLWtJWpVNA4aZ4q6nOcW0hz9ar/YNgHEL/VxBx1LijLAJFR7tB/PZzJGraEG2BAQuya2Ix5L8fx3IeKhIHKck4xm8rmaSPzX2L8yHe8C6ht5mqNcgI5k5Ek/g8YILxcY4FPPRhRYES2HGB0FnIzk9dC/4H4YDojV8SbjaZDS8iJeS2N1IvqPoS7YVyu3Fl/F7hkkC9Nrv0FJGhNzQJkILiP5tV333NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261021123027099003)(10067099003)(18002099003)(261026121527099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d25vlPiTwx/HoHF1wpy766mkU6BUA4indUo4sH8dFMr96RMAmN52qQNvP5AAoQF19JjdiGP0JqGdzgHqhCCUsdOapicLjyvnI6d30Sj2jQ3Qlf9qZrL76/+kV4eOAXBaCcFzrHVSIYvAn3hsVFYW7QMIqvVnZ4J9ygxsDN4KMPDddiHpj0CpbtL6wy9c8G/714JjYsNg2zhy7rQ+wN5BVg7gshTZuXgVw+jpEKnPUBKynAXwEqUW/2hYAij/Ha2ZLBegg9+JkRJx/OWn9c0/PlKj2OdmHDIJ+hrSGbpUokR4gKH8aBc2phr9LjLyZFsTa8kGr0SKNjzlqMLBMTUJ4QniCW/VkKOxaHF9oecyk3VWSdgqYEJ4IqybMFJqYJfSTox66ihH9OeZuGqCcQh4RSBo8SaORWEGdwmEQMpG4E8WtpeQBZV5WkVcu8AiI47V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:03:07.9547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffea5dc1-eca6-4ff1-0133-08df33b54cc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF12253E83C
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Temporarily add the amdgpu.ualink_loopback module parameter to request
UALink loopback mode for manufacturing testing, until the final
mechanism for enabling loopback is in place. Loopback is disabled by
default.

Only amdgpu_ualink_loopback_requested() reads the parameter, so moving
to the final mechanism only needs to replace it there.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  5 +++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bdcd64330304..429b0c8c09d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -271,6 +271,7 @@ extern int amdgpu_rebar;
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
 extern int amdgpu_ptl;
+extern int amdgpu_ualink_loopback;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c636c9f7396e..81d178503516 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -257,6 +257,7 @@ int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
 int amdgpu_ptl = -1; /* auto */
+int amdgpu_ualink_loopback;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1195,6 +1196,18 @@ module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms
 MODULE_PARM_DESC(ptl, "Enable PTL (-1 = auto, 0 = disable (default), 1 = enable, 2 = permanently disable)");
 module_param_named(ptl, amdgpu_ptl, int, 0444);
 
+/**
+ * DOC: ualink_loopback (int)
+ * Enable UALink loopback mode for manufacturing testing. In loopback mode a
+ * single GPU acts as both the exporter (accelerator ID 1) and the importer
+ * (accelerator ID 0) and loops UALink requests back to itself. Possible values:
+ *
+ * - 0 = disable (default)
+ * - 1 = enable
+ */
+MODULE_PARM_DESC(ualink_loopback, "Enable UALink loopback mode (0 = disable (default), 1 = enable)");
+module_param_named(ualink_loopback, amdgpu_ualink_loopback, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 204758c0fd50..8d81efb28774 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -95,11 +95,12 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
 /*
  * amdgpu_ualink_loopback_requested - check whether UALink loopback is requested
  *
- * There is no mechanism to request loopback mode yet, so it stays disabled.
+ * Loopback mode is temporarily requested with the amdgpu.ualink_loopback
+ * module parameter.
  */
 static bool amdgpu_ualink_loopback_requested(struct amdgpu_device *adev)
 {
-	return false;
+	return amdgpu_ualink_loopback == 1;
 }
 
 /*
-- 
2.55.0

