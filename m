Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1666606FB59
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i54UaPPC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7983610F03E;
	Mon,  2 Nov 2026 16:03:31 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984F110F03E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTucapKnvYSn8iZAdnfbe87bI9OYmtxPCBZnbSXsvgrZCUJHCRGjB5xlPQh6zh6XV0Olh9U06j3HGUKv0e4QjEfu94fPEyAlcr4+YUSyPggBQ96TpfRi5Xn29fckCM1TMBtil9MH7E3CAAQy0R/GH4cjDOByv/wqgD7rZ5aWK5sGammPemXjHk+lZluNhAANm5On2B/oHScqJMiy2X0aVpdfMbJ7Ld/G13vm1nBi0/FkJxMbk5y13WycrHLgbKwpKRPRvpA0sZjpifdNjmYO3U2LG8/hTx63foUug/erx7Z8QeT/LhZ/GdiRJOJ7i8TuHzoHNX7reA/2Wzb7a+C+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4ZtO0b9Sf4rklaiaK7EXOw7B1+EYxpCLW6pezPfr7Y=;
 b=OhdqVuKaxCP4zWrhHkpDFb6KmZW3IsY5rQa8u3LdFkq8ChEmOrB89HaaqW6loIK+P/5n62PQw9/cv5yqG2xJ80xT+7cj+mnNTmpxLy2Yo0iYF2kIuIxjCmfwFd8py+rP4Eu9NvkPg2HytMT6jgJMxu9Sa6MiZt2YrFl9USv10RVGSEpHuYw9Ib8Z6b//b08QUOeX/4hljVbLnwZO6yZwdef+gwtOQMP9e+8U9umq4ms2+UaFkQUYNr4S6ssfwKsI+hxNl36Bz9/k3UQ9ASoWDCOp7JK2Yovsjyf355710uIhkTYIKYE7CrnP3oyvQAlAZ2qIL8zLtLW7kysbhhoDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4ZtO0b9Sf4rklaiaK7EXOw7B1+EYxpCLW6pezPfr7Y=;
 b=i54UaPPCTUKVp7Yj3IpMGIVNVvF8GF9f2bGkoItnpSdoxtbP9tJhf/L6lwD82T5JARK1neOhlutIA+Or26dtm/gFYuiRwnMlKlo52Kb+MlF7zf3oyEaZJ9FESUTAF6NNFMrwp2V8nhMQ3VMc8dmgrDEHKT9IREoSrpi2WhWoDiw=
Received: from PH7P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::31)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:02:23 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:338:cafe::4c) by PH7P223CA0026.outlook.office365.com
 (2603:10b6:510:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 16:02:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:02:22 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 10:02:22 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCHv3 8/8] drm/amdgpu: Temporarily enable UALink loopback via
 module parameter
Date: Mon, 2 Nov 2026 10:47:54 -0500
Message-ID: <20261102160125.2743750-9-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102160125.2743750-1-mukul.joshi@amd.com>
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d42f4e0-d9a4-4766-3e7e-08df38faae78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|261102123227099003|261102130727099003|56012099006|11063799006|261026121527099003|261022075727099003|261009223027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: H9whbERXjgMNxiNRZgMmT4tHOyK7sUeQIM+XoARVjRDM1giMJ+YIftBOrJe2KqLFH/ISvewHGSRzSxhFQOvc932BJUSIJyImJYW89n0OfbVynLiFfahmZRqWQT6zgMMn4NWHpcIItt0ZX2kH5JLrZemoTfd2Jf4pqw5Tq3bFrB4lMAu0Q+DOH4uPVnXBfU/o4hWo4STB4PUGy68i9AnnUysTJqmGi4Qq9tXJm9Cup7euXcRUkUEXf0H2zS+rIZb4CjAYYKQZExnui2ZqSmAZT7y1jaz5nQADNi/i6aKwB9sRr2l3fOMPrmvQKouKXXUP2TF3i7VlK7uPqvo92fmDQlyczcm/EZxpnut4l6aTKsyNUd+m0kOxxltf6hN23RDF7LaczxSfbb8k5yF6nSwTVu7gXZYUUh+UF9fbTocHruM8huAjJCMKcArVZWY6LRmMhl0dWL01JqlYUs3Y0QCWfi/puR3XAu8tZg+geD5CACMiFS08C5sjKJ+ArQWnroyz4riv7x6PKi37T/oTax8YTFeU/d+txtz7FqlnVZ+98x3grlhZ6a8gQQwxpVrkhJY3Ue87q7HgD28gb2zLFFsHtio+Mxl3mP8/nShRNsXXQJKZ4Jxtf5JbsCdy9vLBEw7XjkMqywmZ2FniJKkowjp+ioldti2qlCZ9vPMq9+9oV088rAUijOm2bu1AiM8Ndcbmg9NxLo7YQudzrhlrbNwewg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(261102123227099003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261022075727099003)(261009223027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AaiFmFk/sV/Smo+wBQlcULmv15crcX7ais6IrEfhGw7bZ1XlcM16oLXjUeNkNu2uxKH+qoz+Q4cnILegERfyEwjfWw109/FN6e7v/IbppP3E2u8ShTlcabsAMxSplVPaoqrn79rVl20v/jlN7hlYVuCbjvapcndFbcEwb+N50MBDXte+aukDEIT1R5tH4VfXTDH0YtRTQ0WZb7bJJpvKzHsfkiIbJWiL7fvxvF81mUFS4nmcMvt4nLhqTXKm3OUWxMmUW0GOrLRAPPq+//XmodQQfA5jTu9TzmErcoNJy9+bqP9UUfj3Ibm+wFWKIYwJh5IzvBp+pXcwJNS64YSy1Rk/H0Dub4geJbhU64RjLLqLjcFMdRz9NrQXHRE8cSET8xgyQ/tWF4O7D6l6B13ZWCMZolrcnQ14UPANyM4V6pLnX/X4/6cDSZAdYdzPYNJD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:02:22.8870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d42f4e0-d9a4-4766-3e7e-08df38faae78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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

Temporarily add the amdgpu.ualink_loopback module parameter to request
UALink loopback mode for manufacturing testing, until the final
mechanism for enabling loopback is in place. Loopback is disabled by
default.

Only amdgpu_ualink_loopback_detect() reads the parameter, so moving to
the final mechanism only needs to replace it there.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
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
index 5e0029530b79..b4aca2def27a 100644
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
index cf2c68cf7115..410222354bd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -97,11 +97,12 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
  * amdgpu_ualink_loopback_detect - detect UALink loopback mode
  *
  * This is the only place that decides whether loopback mode is enabled.
- * There is no mechanism to request loopback mode yet, so it stays disabled.
+ * Loopback mode is temporarily requested with the amdgpu.ualink_loopback
+ * module parameter.
  */
 static void amdgpu_ualink_loopback_detect(struct amdgpu_device *adev)
 {
-	adev->ualink.loopback.enabled = false;
+	adev->ualink.loopback.enabled = amdgpu_ualink_loopback == 1;
 }
 
 /*
-- 
2.56.0

