Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27C606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UJGK824+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3B010E48D;
	Tue, 27 Oct 2026 19:59:52 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1312910E47E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 19:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqXEsCoLrHcXeu2/stdTMWyIoCdj1Te/wK+kaM8euFDiTrULb55kQFx72ReG2lfBGpUfV+orkVs9s+E1UUvIs4/N3i1UnJhAlN+ZntlRhQVxcHmvjR0ikBufIQjSoVt+cPQzcT9Mlxn0vwCwLE3hHRXixgr90gV4e1OFF9Rs6IzHw6AKY/QFfQwo9B71aQBmUQBlEPuGLziAL+t/VQTlfol6+DsqwP+PSXkMlpfoJMRXEq2xSqudySJfEkI2v5zy1cqGeAfLnlHMo3zPYgkFdEtjX8SJgOw9F6ypod5ybpON+CKyZVh0+9W6PYz2RWvg/RnOXjF+TbI/rjOgU2GIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN8FI5kneRApBevSrP9QtRvGZdA4F6LmMzqxYzAy1e4=;
 b=sAD/20UBTZI30JyLt+gDDswhWuUHc9s6zkcZDTPhkr3M+dVhCcqwVjdKeSjBNrb+LRYX0nVCEXGt61rOF2QlrTjSIrF0bnTwB8belMoPMBOpHMVxtjXdUoKrgpVTz1OI1j6bEMPFQEcuyoYpzHKEbqH6C5gN8O6gEw3QKViCqj1EQi8ZTAyHjYXL+coy/xNOtf7wVtbIG0Jt/OQh510C90Tc2ZM1IIM42sodh3CZ3qIYPFC39ukbkJQ4CICdn7YSdisJ1ljEzaq5lNq8vnIeMyD9vcucggPQcWIPvw/aq9TNy/ODLKY1cpeajHoHXXD7Ga0wNPCNamL58umsq1GrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN8FI5kneRApBevSrP9QtRvGZdA4F6LmMzqxYzAy1e4=;
 b=UJGK824+EvtbG+31fziwiwI6HEbEdMIyXz0cYEc9Bu7nPhfkAUPqh8iH6LTFaf1UJjjzzB7nyVfU/9gQ2w+p4YOthDiUxVxkZML9cXOja1u1EtpgBjmpqBYOqCN77y6Sh1occpaRDFsWYhNLRbgj4++dCGP5gSDE086WFiCrKbI=
Received: from SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31)
 by CH1PPF9C964DBFE.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:59:39 +0000
Received: from PH5PEPF0000002E.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::46) by SJ0PR05CA0086.outlook.office365.com
 (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Tue, 27
 Oct 2026 19:59:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002E.mail.protection.outlook.com (10.167.243.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 19:59:36 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 14:59:32 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 8/8] drm/amdgpu: Temporarily enable UALink loopback via
 module parameter
Date: Tue, 27 Oct 2026 15:54:21 -0400
Message-ID: <20261027195913.1794477-9-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027195913.1794477-1-mukul.joshi@amd.com>
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002E:EE_|CH1PPF9C964DBFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a80952-5228-4ca1-74c0-08df3464d3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|261021121427099003|261026121527099003|22082099003|18002099003|56012099006|11063799006|261022075727099003|10067099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 0yoPVcam4jqDi5+fq/NZwwMiciusf4qwHU8Z5JegmPd/uQpXsqy7lkMiq48VpaLJ1NUCIZdzXgoYdmURX+pNZKdKLCbC6CQA/fAqQhUxeW+gB6cE+m84glFITlycCahgj3dBm6LywrjxYpYlyV+o04L/8bERIinsOO8e7snpFkO8T7Hik0WKDil34CepUx8eXSYB5Iy9hKhAInKPnBOuYhKBmpnbSweHNbJC3djr+C7vGe+eReX3VbOeeqTC2ivfHWTZ+Idk+uth6OoJ2JZUJTT02H2vGa1vONB0i+bgPx7apTEaWLQ6kLeS6oQI35kmn3RKdY3/m+iPuqntRDyYHRnpY1T5N56WrLZ5YglWSYT8H4/VfZIc4Mhh0XL+i4l5XaVCEIuPX14uXhkfjO/fjwe52yf4cHAEbdFWTfFTXu6ZPhRzY4nEpGq4g8xeXZ0m04T/cd2jBsWrcBLaCCvYDzhxoYhCNUZd3wkSU1r06w6Z1/pGLp7dwKMQtv44Bw645nYK5IXjHD6Mq0Ya/LYjzmpKZpS6OGiHcxu7HfxDZ6jhF8xjl2DPQBNyQ6uLleCacgtvzwTapTQSJ8vQwswRn/9V36FSTCiU4qEZ+iM1yxLq8XXQ4ZK4Y8MvU9H3N7TpuMp40oUcmTYHEfl/w4iFbR12YsbYtmA2w99LiBI5iHK/GDlM2rj6PjKgrKjWiWf9NPLOH47CSt/oQctEQboaPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(261021121427099003)(261026121527099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(10067099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v39NBzsVGLEqHVDWI416UCWRmM3v9OZFZM1CzphTr9mX6FGOUkRZoxHIzjnY4m2aDHwk+DzAiYv85j2c2hIB8l6zY0oUf4UQcnP9jJpknme4VGRVk0h9HXYGgGC3JVje1WvjAkozI/i4ibSESjFz1ohizrVzD91n04tTgdcxtqCq+kHtjlSmfl/s/qXP33CuCA4cCuxZ+wz+CFs843OIP0ZJFIBh6qjOUB4ViLV/40LTE3U1B0VFhIINmYFX+lwVCRZ4inwdLDU8jSlhFO+/V+XXhtsIFM7InBqdrAdW0VQeZRZhBb1e0z27gE/0SGkpHH57xY4QnGVBs6M5R8IAAE2bXO0Axno59eia4yQbvQZ5un40uX2hKZJEOC/uSmJyVhKgyx5qyzPb+yXHioLCMGg7t6DUjJzXo4FISCQalTKrogfg2frusq0yqVsMZn6g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:59:36.6823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a80952-5228-4ca1-74c0-08df3464d3fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF9C964DBFE
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
index 5a32b54b1e9b..b8be093b8a33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -270,6 +270,7 @@ extern int amdgpu_rebar;
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
 extern int amdgpu_ptl;
+extern int amdgpu_ualink_loopback;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e5634de077f..e0cf40f86194 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -253,6 +253,7 @@ int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
 int amdgpu_ptl = -1; /* auto */
+int amdgpu_ualink_loopback;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1165,6 +1166,18 @@ module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms
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
index 1c2203ff175d..a98fa5f970b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -96,11 +96,12 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
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

