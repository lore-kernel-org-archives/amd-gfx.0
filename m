Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422D9C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB70310EE4B;
	Wed, 26 Aug 2026 23:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="omWMOruL";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A30B10EE4B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur6z4pbqGhai+ZS41tvqty6RDV+gXX46VAN4fO289avg1LPqRQXOYF9AFwhuq4AYqwhGYkBokKJYUQpqIz5v3gGnUTxOnqsvWV8S0rQt4/z/JfBMa9iVzJ4G8AqJbIeIYFiQaDAHc5uYBT2LbDu4A7scJNSkK+xQbh/Pmb3Ol297Rpczf0J6X/0RjttFlJg4AM/aTVjO+qNF0KMcnZHmx5yt+Lh9PFHRCyNN54JpYzzOSN6Kn4Nj+7tUtaKHAXGO7YFb82XVJIHc+/9Qj1VbPj8lZKYUZSZWMErmcmWQIXMA8AG52kNIFaxeESjFnh7C21kOFBsfqt2moLFPh5mtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNXJB+v+EuVbpkvzWtJe4P+xJxQUvI1x8oTnj6XFA9U=;
 b=kMishSfvn4Grds1as0KLVva0ooWzxvXFAL9YiFhR1KVyo5zEJBbZIhSw+i/KDmP/dKAf7aYrvlzU69fHIBWP+DTBJ4hUE+Mq9TWj2El5R22DXLxZKUPi1PGVQx5g6Nnkf7P9OR1dG9otbWrz7ewUm16WTpPMY48ViTbpYnhC2cD7eyFxam0LQNf9AIp54WvmOaL7B6Q+QvLjTBAZ5ZAbE0FbkvbIUuTaHBla+NfnYHmhIytQyJq/xvma1BzR2416XpULfuG1ZCdInTgsyL4AMLmUHC+/5n72y9xckxr53ckvq2mfNlpOAAc+l4ttU4K9AosFdEC9i2snPeqMN2h8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNXJB+v+EuVbpkvzWtJe4P+xJxQUvI1x8oTnj6XFA9U=;
 b=omWMOruLMkVHbF+UaqUo/LW4z8N47evwZJynk6LkF926gRRbk11/39nbclpVs8MeVX4foJIMOYLadlwLdF+HOQhx78BKM6EPGk6mvi9I0zWrEF8j0tJlbRqqTPRmz0BCaqOYKpZiirXDP0cFsOBxCG6ZAZIe22K5o4tGDDjXxxY=
Received: from SA0PR11CA0132.namprd11.prod.outlook.com (2603:10b6:806:131::17)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:25:15 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::7d) by SA0PR11CA0132.outlook.office365.com
 (2603:10b6:806:131::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:25:15 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:25:06 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 28/59] drm/amd/display: Move DML Wrapper into its own Component
Date: Wed, 26 Aug 2026 17:04:59 -0600
Message-ID: <20260826231519.881949-29-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ce2498-9c38-40dc-18b9-08df03c948a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|6133799003|3023799007|22082099003|18002099003|20052099010;
X-Microsoft-Antispam-Message-Info: /fHqEj7ffPnop9IAQ3tEvqW1Ne2hUH+n8UJCZnq2LtJiokS51q9bGiqf/xTqfmCZhvDZogbSr8W5hX9S63IZsEAIMwkA9zQqdH8s/M0NJPqFBO3o1NG81j7e7vCgmtPdyhXy7ouq2/uav4oh4hwPz5mScbV7fZSfC9jhxXlN/eV9UNOmeZi+BrRPjMEztqA3uMOYCvMqmyuNzzdxgs2ocTCHcwECpkRIew20ZlfY3ku7vm1TC6kfcqCLN97gBQ/ELBiwysMxxNVs9egvVR7rplLiv3mBkhdGqVdbB0+ljLVjTz2rWJptzOQzXY8CJaUeQqqPMQJ6jM/fmL39uypeJEigkSkKB05f4rtyfSuvpYrAhNw6FNGo+CGMam9ZP2Ow8QmrOJT9zso1tDyXnfG0sb8u5VM9rMnlresY/FiNsteumB1FonIjMo44/ToJZ+PXXpWk1MuJhT4yK80gVzsRs3G/QH0Ezlukz7tYOPbb22Nv1RlX89+3B5L6nQBobXmHik1bPCpCdlYxXukqgl12fl4zoUT+UblRwdl/hbJG2vCGeHR2LglR5nxg5IJz0xrAbQ4JpGjWA/m+L/yjL8yvA3fMGA6zVWIBCn+QKs7le6XKkwZIM/fkkgygcdl0R8Gboba5T6wqXYj/S67ELUZE/FFY93utUoAhERd22bsxAwyNdK3RLLlEF6yXXI27PB0tw76UEI/EUbMeQ9JXHwvX7Q==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 52pww5YvtKunyjrrcY2vXAjXJBHgLu9hzMLtMsHJoOXheKGRYwu2fjYvuEWseoYskeimhhD/N7O5wp/nOH4PiMefHTp2Nj7IMvJ4vwuSOFCccwDtN040AK+kvIcmLGx8JxCokd7QveFjMBxrCFOuCZMU+9ZFNecBMvD5jsLpG2eM2gxJ8X/wSseIRCllY81TRzfa7Qe0Ucuuup0nfYeYuemvXWXkW6+FfkFfvlNXOPsDClQgl126+4O0mInZICh993iDtTx2pD4SfaLbxzq91i3KXO1txhG+6rMamGF+9ETv3fl4EakKv5Bx7ha+Fm9S8o7KrNjZvqwSAmgeoq0MLqTiAkirNr7TjmK3Z4SejcNZLn07ERpB3aAqi8IozfRmgXpeyDlaBqalVQWQF0fumtLLhu83PQkMavZV2tJTwBSUnYPq4njcUK66UorTCd3q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:25:15.0835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ce2498-9c38-40dc-18b9-08df03c948a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

From: Austin Zheng <Austin.Zheng@amd.com>

[WHY/HOW]
DML wrapper is used to bridge between DC and DML.
Put DML wrapper files in their own folder to help
distinguish the boundary between DC and DML.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |  22 ----
 .../display/dc/dml2_0/dml21/dml21_wrapper.h   | 106 -----------------
 .../drm/amd/display/dc/dml2_wrapper/Makefile  |  61 ++++++++++
 .../dml21_wrapper}/dml21_translation_helper.c |  15 ++-
 .../dml21_wrapper}/dml21_translation_helper.h |   7 +-
 .../dml21_wrapper}/dml21_utils.c              |  11 +-
 .../dml21_wrapper}/dml21_utils.h              |   7 +-
 .../dml21_wrapper}/dml21_wrapper.c            |   2 +-
 .../dml21_wrapper/dml21_wrapper.h             | 107 ++++++++++++++++++
 .../dml21_wrapper}/dml21_wrapper_fpu.c        |  19 +++-
 .../dml21_wrapper}/dml21_wrapper_fpu.h        |   7 +-
 .../dml2_dc_resource_mgmt.c                   |  60 ++++++----
 .../dml2_dc_resource_mgmt.h                   |   0
 .../{dml2_0 => dml2_wrapper}/dml2_dc_types.h  |   0
 .../dml2_internal_types.h                     |   2 +-
 .../dml2_mall_phantom.c                       |  70 +++++++-----
 .../dml2_mall_phantom.h                       |   0
 .../dc/{dml2_0 => dml2_wrapper}/dml2_policy.c |   2 +-
 .../dc/{dml2_0 => dml2_wrapper}/dml2_policy.h |   0
 .../dml2_translation_helper.c                 |  20 ++--
 .../dml2_translation_helper.h                 |   0
 .../dc/{dml2_0 => dml2_wrapper}/dml2_utils.c  |  28 +++--
 .../dc/{dml2_0 => dml2_wrapper}/dml2_utils.h  |   0
 .../{dml2_0 => dml2_wrapper}/dml2_wrapper.c   |   6 +-
 .../{dml2_0 => dml2_wrapper}/dml2_wrapper.h   |   0
 .../dml2_wrapper_fpu.c                        |  45 ++++----
 .../dml2_wrapper_fpu.h                        |   0
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   2 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |   2 +-
 .../dc/resource/dcn60/dcn60_resource.c        |   4 +-
 40 files changed, 366 insertions(+), 260 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_translation_helper.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_translation_helper.h (94%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_utils.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_utils.h (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_wrapper.c (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_wrapper_fpu.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_wrapper_fpu.h (95%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_dc_resource_mgmt.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_dc_resource_mgmt.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_dc_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_internal_types.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_mall_phantom.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_mall_phantom.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_policy.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_policy.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_translation_helper.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_translation_helper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_utils.c (98%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_utils.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper_fpu.c (93%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper_fpu.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 93d02956c5eb..6ddf4cbda714 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -37,6 +37,7 @@ DC_LIBS += dcn301
 DC_LIBS += dcn31
 DC_LIBS += dml
 DC_LIBS += dml2_0
+DC_LIBS += dml2_wrapper
 DC_LIBS += soc_and_ip_translator
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e40bad702f0f..ebbd81995c38 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -85,7 +85,7 @@
 #include "hw_sequencer_private.h"
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
-#include "dml2_0/dml2_internal_types.h"
+#include "dml2_wrapper/dml2_internal_types.h"
 #include "soc_and_ip_translator.h"
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 837af136464b..ac558e715b72 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -102,7 +102,7 @@
 #define DC_LOGGER_INIT(logger)
 #include "link/hwss/link_hwss_hpo_frl.h"
 #include "dml/dml1_frl_cap_chk.h"
-#include "dml2_0/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
 
 #define UNABLE_TO_SPLIT -1
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 666212cac105..1e4fe2f941ca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -36,8 +36,8 @@
 #include "link_enc_cfg.h"
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
-#include "dml2_0/dml2_wrapper.h"
-#include "dml2_0/dml2_internal_types.h"
+#include "dml2_wrapper/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_internal_types.h"
 #endif
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1ccd10533e0b..c7d5d60ff4c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -43,7 +43,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#include "dml2_0/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
 
 #include "dmub/inc/dmub_cmd.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index f3427e83126e..5ea79e8d84db 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -81,14 +81,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_sup
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.o := $(dml2_ccflags) $(frame_warn_flag)
 
-#Wrapper files are being moved to their own component. Use a flag to transition once files are moved.
-ifndef DML2_WRAPPER_STANDALONE
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_rcflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_ccflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_ccflags)
-endif
-
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_rcflags)
@@ -102,12 +94,6 @@ DML2 = display_mode_core.o display_mode_util.o \
 		dml_display_rq_dlg_calc.o
 DML2 += dml_frl_cap_chk.o
 
-#Wrapper files are being moved to their own component. Use a flag to transition once files are moved.
-ifndef DML2_WRAPPER_STANDALONE
-DML2 += dml2_wrapper_fpu.o dml2_wrapper.o \
-		dml2_utils.o dml2_policy.o dml2_translation_helper.o dml2_dc_resource_mgmt.o dml2_mall_phantom.o
-endif
-
 AMD_DAL_DML2 = $(addprefix $(AMDDALPATH)/dc/dml2_0/,$(DML2))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DML2)
@@ -153,14 +139,6 @@ DML21 += src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.o
 DML21 += src/dml2_standalone_libraries/alternate_pstate_shared_lib.o
 DML21 += src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.o
 
-#Wrapper files are being moved to their own component. Use a flag to transition once files are moved.
-ifndef DML2_WRAPPER_STANDALONE
-DML21 += dml21_translation_helper.o
-DML21 += dml21_wrapper.o
-DML21 += dml21_wrapper_fpu.o
-DML21 += dml21_utils.o
-endif
-
 AMD_DAL_DML21 = $(addprefix $(AMDDALPATH)/dc/dml2_0/dml21/,$(DML21))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DML21)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
deleted file mode 100644
index c4813c51251b..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
-
-
-#ifndef _DML21_WRAPPER_H_
-#define _DML21_WRAPPER_H_
-
-#include "os_types.h"
-#include "dml_top_soc_parameter_types.h"
-#include "dml_top_display_cfg_types.h"
-
-struct dc;
-struct dc_state;
-struct dml2_configuration_options;
-struct dml2_context;
-enum dc_validate_mode;
-
-/**
- * dml21_create - Creates dml21_context.
- * @in_dc: dc.
- * @dml_ctx: Created dml21 context.
- * @config: dml21 configuration options.
- *
- * Create of DML21 is done as part of dc_state creation.
- * DML21 IP, SOC and STATES are initialized at
- * creation time.
- *
- * Return: True if dml2 is successfully created, false otherwise.
- */
-bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config);
-void dml21_destroy(struct dml2_context *dml2);
-void dml21_copy(struct dml2_context *dst_dml_ctx,
-	struct dml2_context *src_dml_ctx);
-bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
-	struct dml2_context *src_dml_ctx);
-
-/* Structure for inputting external SOCBB and DCNIP values for tool based debugging. */
-struct socbb_ip_params_external {
-	struct dml2_ip_capabilities ip_params;
-	struct dml2_soc_bb soc_bb;
-};
-
-/*mcache parameters decided by dml*/
-struct dc_mcache_params {
-	bool valid;
-	/*
-	* For iMALL, dedicated mall mcaches are required (sharing of last
-	* slice possible), for legacy phantom or phantom without return
-	* the only mall mcaches need to be valid.
-	*/
-	bool requires_dedicated_mall_mcache;
-	unsigned int num_mcaches_plane0;
-	unsigned int num_mcaches_plane1;
-	/*
-	* Generally, plane0/1 slices must use a disjoint set of caches
-	* but in some cases the final segement of the two planes can
-	* use the same cache. If plane0_plane1 is set, then this is
-	* allowed.
-	*
-	* Similarly, the caches allocated to MALL prefetcher are generally
-	* disjoint, but if mall_prefetch is set, then the final segment
-	* between the main and the mall pixel requestor can use the same
-	* cache.
-	*
-	* Note that both bits may be set at the same time.
-	*/
-	struct {
-		bool mall_comb_mcache_p0;
-		bool mall_comb_mcache_p1;
-		bool plane0_plane1;
-	} last_slice_sharing;
-	/*
-	* A plane is divided into vertical slices of mcaches,
-	* which wrap on the surface width.
-	*
-	* For example, if the surface width is 7680, and split into
-	* three slices of equal width, the boundary array would contain
-	* [2560, 5120, 7680]
-	*
-	* The assignments are
-	* 0 = [0 .. 2559]
-	* 1 = [2560 .. 5119]
-	* 2 = [5120 .. 7679]
-	* 0 = [7680 .. INF]
-	* The final element implicitly is the same as the first, and
-	* at first seems invalid since it is never referenced (since)
-	* it is outside the surface. However, its useful when shifting
-	* (see below).
-	*
-	* For any given valid mcache assignment, a shifted version, wrapped
-	* on the surface width boundary is also assumed to be valid.
-	*
-	* For example, shifting [2560, 5120, 7680] by -50 results in
-	* [2510, 5170, 7630].
-	*
-	* The assignments are now:
-	* 0 = [0 .. 2509]
-	* 1 = [2510 .. 5169]
-	* 2 = [5170 .. 7629]
-	* 0 = [7630 .. INF]
-	*/
-	int mcache_x_offsets_plane0[DML2_MAX_MCACHES + 1];
-	int mcache_x_offsets_plane1[DML2_MAX_MCACHES + 1];
-};
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
new file mode 100644
index 000000000000..f8a17d622c32
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright 2023 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Authors: AMD
+#
+# Makefile for dml2_wrapper.
+
+dml2_wrapper_ccflags := $(CC_FLAGS_FPU)
+dml2_wrapper_rcflags := $(CC_FLAGS_NO_FPU)
+
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_wrapper
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_wrapper/dml21_wrapper
+
+# Add FPU flags to all dml2_wrapper files by default, remove NO_FPU flags.
+# FPU flags step 1: Find all .c files in dal/dc/dml2_wrapper and it's subfolders
+DML2_WRAPPER_ABS_PATH := $(FULL_AMD_DISPLAY_PATH)/dc/dml2_wrapper
+DML2_WRAPPER_C_FILES := $(shell find $(DML2_WRAPPER_ABS_PATH) -name '*.c' -type f)
+
+# FPU flags step 2: Convert to .o and make paths relative to $(AMDDALPATH)/dc/dml2_wrapper/
+DML2_WRAPPER_RELATIVE_O_FILES := $(patsubst $(DML2_WRAPPER_ABS_PATH)/%,dc/dml2_wrapper/%,$(patsubst %.c,%.o,$(DML2_WRAPPER_C_FILES)))
+
+# FPU flags step 3: Apply FPU flags to all .o files from dal/dc/dml2_wrapper and it's subfolders
+$(foreach obj,$(DML2_WRAPPER_RELATIVE_O_FILES),$(eval CFLAGS_$(AMDDALPATH)/$(obj) := $(dml2_wrapper_ccflags)))
+$(foreach obj,$(DML2_WRAPPER_RELATIVE_O_FILES),$(eval CFLAGS_REMOVE_$(AMDDALPATH)/$(obj) := $(dml2_wrapper_rcflags)))
+
+# FPU flags step 4: Replace CFLAGS per file for files with additional flags beyond dml2_ccflags and dml2_rcflags
+CFLAGS_$(AMDDALPATH)/dc/dml2_wrapper/dml2_wrapper.o := $(dml2_wrapper_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_wrapper/dml2_wrapper.o := $(dml2_wrapper_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.o := $(dml2_wrapper_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.o := $(dml2_wrapper_ccflags)
+
+DML2_WRAPPER = dml2_wrapper_fpu.o dml2_wrapper.o \
+		dml2_utils.o dml2_policy.o dml2_translation_helper.o dml2_dc_resource_mgmt.o dml2_mall_phantom.o
+
+DML21_WRAPPER = dml21_wrapper/dml21_wrapper_fpu.o dml21_wrapper/dml21_wrapper.o \
+		dml21_wrapper/dml21_utils.o dml21_wrapper/dml21_translation_helper.o
+
+AMD_DAL_DML2_WRAPPER = $(addprefix $(AMDDALPATH)/dc/dml2_wrapper/,$(DML2_WRAPPER))
+AMD_DAL_DML21_WRAPPER = $(addprefix $(AMDDALPATH)/dc/dml2_wrapper/,$(DML21_WRAPPER))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DML2_WRAPPER)
+AMD_DISPLAY_FILES += $(AMD_DAL_DML21_WRAPPER)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
index 79da467ddb5d..3c25de54d55b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
@@ -44,6 +44,7 @@ static void dml21_populate_pmo_options(struct dml2_pmo_options *pmo_options,
 static enum dml2_project_id dml21_dcn_revision_to_dml2_project_id(const struct dc *in_dc)
 {
 	enum dml2_project_id project_id;
+
 	switch (in_dc->ctx->dce_version) {
 	case DCN_VERSION_4_01:
 		project_id = dml2_project_dcn4x_stage2_auto_drr_svp;
@@ -54,6 +55,8 @@ static enum dml2_project_id dml21_dcn_revision_to_dml2_project_id(const struct d
 		break;
 	case DCN_VERSION_6_0:
 		project_id = dml2_project_dcn6x_soc_var_a;
+		if (ASICREV_IS_DCN6_VARIANT_LITE3(in_dc->ctx->asic_id.hw_internal_rev))
+			project_id = dml2_project_dcn6x_soc_var_b;
 		break;
 	default:
 		project_id = dml2_project_invalid;
@@ -179,6 +182,7 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 
 	{
 		uint64_t min_refresh = max((uint64_t)stream->timing.min_refresh_in_uhz, min_hardware_refresh_in_uhz);
+
 		ASSERT(min_refresh <= ULONG_MAX);
 		timing->drr_config.min_refresh_uhz = (unsigned long)min_refresh;
 	}
@@ -307,7 +311,7 @@ static void populate_dml21_writeback_config_from_stream_state(struct dml2_writeb
 		writeback->active_writebacks_per_stream = stream->num_wb_info <= DML2_MAX_WRITEBACK ?
 				stream->num_wb_info : DML2_MAX_WRITEBACK;
 
-		ASSERT(stream->num_wb_info <= DML2_MAX_WRITEBACK);
+		ASSERT(stream->num_wb_info <= MAX_DWB_PIPES);
 
 		for (unsigned int wb_index = 0; wb_index < stream->num_wb_info; wb_index++) {
 			const struct dc_writeback_info *dc_wb_info = &stream->writeback_info[wb_index];
@@ -705,7 +709,8 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 	plane->composition.scaler_info.upsp_enabled = (scaler_data->upsp != UPSP_BYPASS);
 
 	/* always_scale is only used for debug purposes not used in production but has to be
-	 * maintained for certain complainces. */
+	 * maintained for certain complainces.
+	 */
 	if (plane_state->ctx->dc->debug.always_scale == true) {
 		plane->composition.scaler_info.enabled = true;
 	}
@@ -821,7 +826,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 
 	plane->composition.rect_out_height_spans_vactive =
 		plane_state->dst_rect.height >= stream->src.height &&
-		stream->dst.height >= stream->timing.v_addressable;
+		stream->dst.height >= (int)stream->timing.v_addressable;
 }
 
 //TODO : Could be possibly moved to a common helper layer.
@@ -946,6 +951,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 		ASSERT(otg_master_pipe);
 
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+
 		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], otg_master_pipe, dml_ctx);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], otg_master_pipe);
 		populate_dml21_writeback_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].writeback, context->streams[stream_index]);
@@ -1004,7 +1010,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 
 void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state *context)
 {
-	/* TODO these should be the max of active, svp prefetch and idle should be tracked seperately */
+	/* TODO these should be the max of active, svp prefetch and idle should be tracked separately */
 	context->bw_ctx.bw.dcn.clk.dispclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.dispclk_khz;
 	context->bw_ctx.bw.dcn.clk.dcfclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.active.dcfclk_khz;
 	context->bw_ctx.bw.dcn.clk.dramclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.active.uclk_khz;
@@ -1169,3 +1175,4 @@ void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_s
 	min_clocks->stutter_efficiency.z8_stutter_period = 100000;
 	min_clocks->zstate_support = DCN_ZSTATE_SUPPORT_ALLOW;
 }
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.h
similarity index 94%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.h
index f51d3d8a52c3..ceb50a94f7a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.h
@@ -1,6 +1,7 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ */
 
 
 #ifndef _DML21_TRANSLATION_HELPER_H_
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_utils.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_utils.c
index 125ca619c8ab..0aecfa8b909f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_utils.c
@@ -14,6 +14,7 @@
 int dml21_helper_find_dml_pipe_idx_by_stream_id(struct dml2_context *ctx, unsigned int stream_id)
 {
 	int i;
+
 	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
 		if (ctx->v21.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[i] && ctx->v21.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[i] == stream_id)
 			return  i;
@@ -25,6 +26,7 @@ int dml21_helper_find_dml_pipe_idx_by_stream_id(struct dml2_context *ctx, unsign
 int dml21_find_dml_pipe_idx_by_plane_id(struct dml2_context *ctx, unsigned int plane_id)
 {
 	int i;
+
 	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
 		if (ctx->v21.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id_valid[i] && ctx->v21.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id[i] == plane_id)
 			return  i;
@@ -120,6 +122,7 @@ int dml21_find_dc_pipes_for_plane(const struct dc *in_dc,
 	} else {
 		/* stream was configured with dummy plane, so get pipes from opp head */
 		struct pipe_ctx *otg_master_pipe = dml_ctx->config.callbacks.get_otg_master_for_stream(&context->res_ctx, dc_main_stream);
+
 		if (otg_master_pipe != NULL)
 			num_pipes = dml_ctx->config.callbacks.get_opp_heads_for_otg_master(otg_master_pipe, &context->res_ctx, dc_main_pipes);
 	}
@@ -196,7 +199,7 @@ bool check_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 
 static bool is_sub_vp_enabled(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
@@ -377,7 +380,8 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 
 static uint32_t calc_svp_size_256kb(uint64_t addr_bytes)
 {
-    return (uint32_t)(((addr_bytes + 0x3FFFFull) >> 18) << 2); // ceil to 256KB, then return bits [47:16]
+	/* ceil to 256KB, then return bits [47:16] */
+	return (uint32_t)(((addr_bytes + 0x3FFFFull) >> 18) << 2);
 }
 
 
@@ -505,7 +509,8 @@ static unsigned int dml21_build_fams2_stream_programming_v2(const struct dc *dc,
 		struct dc_state *context,
 		struct dml2_context *dml_ctx)
 {
-	int dc_stream_idx, dc_plane_idx, dc_pipe_idx;
+	int dc_stream_idx, dc_plane_idx;
+	unsigned int dc_pipe_idx;
 	unsigned int num_fams2_streams = 0;
 
 	for (dc_stream_idx = 0; dc_stream_idx < context->stream_count; dc_stream_idx++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_utils.h
similarity index 96%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_utils.h
index 7312c33143c6..c30a5b2a99a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_utils.h
@@ -1,6 +1,7 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ */
 
 
 #ifndef _DML21_UTILS_H_
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.c
index 8bed59e976d1..fb7c1759dc09 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.c
@@ -13,6 +13,7 @@
 #include "dml2_wrapper_fpu.h"
 #include "dml21_wrapper.h"
 #include "dml21_wrapper_fpu.h"
+
 #include "dc_fpu.h"
 
 #if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
@@ -38,7 +39,6 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	(*dml_ctx)->v21.mode_programming.display_config = (*dml_ctx)->v21.mode_support.display_config;
 
 	DC_RUN_WITH_PREEMPTION_ENABLED((*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming)));
-
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h
new file mode 100644
index 000000000000..46ea67c1246d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ */
+
+
+#ifndef _DML21_WRAPPER_H_
+#define _DML21_WRAPPER_H_
+
+#include "os_types.h"
+#include "dml_top_soc_parameter_types.h"
+#include "dml_top_display_cfg_types.h"
+
+struct dc;
+struct dc_state;
+struct dml2_configuration_options;
+struct dml2_context;
+enum dc_validate_mode;
+
+/**
+ * dml21_create - Creates dml21_context.
+ * @in_dc: dc.
+ * @dml_ctx: Created dml21 context.
+ * @config: dml21 configuration options.
+ *
+ * Create of DML21 is done as part of dc_state creation.
+ * DML21 IP, SOC and STATES are initialized at
+ * creation time.
+ *
+ * Return: True if dml2 is successfully created, false otherwise.
+ */
+bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config);
+void dml21_destroy(struct dml2_context *dml2);
+void dml21_copy(struct dml2_context *dst_dml_ctx,
+	struct dml2_context *src_dml_ctx);
+bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
+	struct dml2_context *src_dml_ctx);
+
+/* Structure for inputting external SOCBB and DCNIP values for tool based debugging. */
+struct socbb_ip_params_external {
+	struct dml2_ip_capabilities ip_params;
+	struct dml2_soc_bb soc_bb;
+};
+
+/*mcache parameters decided by dml*/
+struct dc_mcache_params {
+	bool valid;
+	/*
+	 * For iMALL, dedicated mall mcaches are required (sharing of last
+	 * slice possible), for legacy phantom or phantom without return
+	 * the only mall mcaches need to be valid.
+	 */
+	bool requires_dedicated_mall_mcache;
+	unsigned int num_mcaches_plane0;
+	unsigned int num_mcaches_plane1;
+	/*
+	 * Generally, plane0/1 slices must use a disjoint set of caches
+	 * but in some cases the final segment of the two planes can
+	 * use the same cache. If plane0_plane1 is set, then this is
+	 * allowed.
+	 *
+	 * Similarly, the caches allocated to MALL prefetcher are generally
+	 * disjoint, but if mall_prefetch is set, then the final segment
+	 * between the main and the mall pixel requestor can use the same
+	 * cache.
+	 *
+	 * Note that both bits may be set at the same time.
+	 */
+	struct {
+		bool mall_comb_mcache_p0;
+		bool mall_comb_mcache_p1;
+		bool plane0_plane1;
+	} last_slice_sharing;
+	/*
+	 * A plane is divided into vertical slices of mcaches,
+	 * which wrap on the surface width.
+	 *
+	 * For example, if the surface width is 7680, and split into
+	 * three slices of equal width, the boundary array would contain
+	 * [2560, 5120, 7680]
+	 *
+	 * The assignments are
+	 * 0 = [0 .. 2559]
+	 * 1 = [2560 .. 5119]
+	 * 2 = [5120 .. 7679]
+	 * 0 = [7680 .. INF]
+	 * The final element implicitly is the same as the first, and
+	 * at first seems invalid since it is never referenced (since)
+	 * it is outside the surface. However, its useful when shifting
+	 * (see below).
+	 *
+	 * For any given valid mcache assignment, a shifted version, wrapped
+	 * on the surface width boundary is also assumed to be valid.
+	 *
+	 * For example, shifting [2560, 5120, 7680] by -50 results in
+	 * [2510, 5170, 7630].
+	 *
+	 * The assignments are now:
+	 * 0 = [0 .. 2509]
+	 * 1 = [2510 .. 5169]
+	 * 2 = [5170 .. 7629]
+	 * 0 = [7630 .. INF]
+	 */
+	int mcache_x_offsets_plane0[DML2_MAX_MCACHES + 1];
+	int mcache_x_offsets_plane1[DML2_MAX_MCACHES + 1];
+};
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper_fpu.c
similarity index 96%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper_fpu.c
index aba7dd65c539..a1525f7e0e61 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper_fpu.c
@@ -69,6 +69,7 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 	(void)out_new_hw_state;
 	(void)pipe_cnt;
 	unsigned int dml_prog_idx = 0, dc_pipe_index = 0, num_dpps_required = 0;
+	unsigned int pipe_count = 0;
 	struct dml2_per_plane_programming *pln_prog = NULL;
 	struct dml2_per_stream_programming *stream_prog = NULL;
 	struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
@@ -109,8 +110,10 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 		if (num_pipes <= 0)
 			continue;
 
+		pipe_count = (unsigned int)num_pipes;
+
 		/* program each pipe */
-		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+		for (dc_pipe_index = 0; dc_pipe_index < pipe_count; dc_pipe_index++) {
 			dml21_program_dc_pipe(in_ctx, context, dc_main_pipes[dc_pipe_index], pln_prog, stream_prog);
 
 			if (pln_prog->phantom_plane.valid && dc_phantom_pipes[dc_pipe_index]) {
@@ -302,7 +305,7 @@ bool dml21_validate(const struct dc *in_dc, struct dc_state *context, struct dml
 
 void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx)
 {
-	unsigned int dml_prog_idx, dml_phantom_prog_idx, dc_pipe_index;
+	unsigned int dml_prog_idx, dml_phantom_prog_idx, dc_pipe_index, pipe_count;
 	int num_pipes;
 	struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
 	struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
@@ -342,8 +345,10 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		    dc_main_pipes[0]->plane_state == NULL)
 			continue;
 
+		pipe_count = (unsigned int)num_pipes;
+
 		/* get config for each pipe */
-		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+		for (dc_pipe_index = 0; dc_pipe_index < pipe_count; dc_pipe_index++) {
 			ASSERT(dc_main_pipes[dc_pipe_index]);
 			dml21_get_pipe_mcache_config(context, dc_main_pipes[dc_pipe_index], pln_prog, &mcache_config->pipe_configurations[dc_pipe_index]);
 		}
@@ -361,7 +366,7 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 			mcache_config->num_pipes = (char)pln_prog->num_dpps_required;
 			l->build_mcache_programming_params.num_configurations++;
 
-			for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+			for (dc_pipe_index = 0; dc_pipe_index < pipe_count; dc_pipe_index++) {
 				ASSERT(dc_phantom_pipes[dc_pipe_index]);
 				dml21_get_pipe_mcache_config(context, dc_phantom_pipes[dc_pipe_index], pln_prog, &mcache_config->pipe_configurations[dc_pipe_index]);
 			}
@@ -383,8 +388,10 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		    dc_main_pipes[0]->plane_state == NULL)
 			continue;
 
+		pipe_count = (unsigned int)num_pipes;
+
 		/* get config for each pipe */
-		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+		for (dc_pipe_index = 0; dc_pipe_index < pipe_count; dc_pipe_index++) {
 			ASSERT(dc_main_pipes[dc_pipe_index]);
 			if (l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_prog_idx][dc_pipe_index]) {
 				memcpy(&dc_main_pipes[dc_pipe_index]->mcache_regs,
@@ -398,7 +405,7 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 				dc_phantom_pipes[0] &&
 				dc_main_pipes[0]->stream &&
 				dc_phantom_pipes[0]->plane_state) {
-			for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
+			for (dc_pipe_index = 0; dc_pipe_index < pipe_count; dc_pipe_index++) {
 				ASSERT(dc_phantom_pipes[dc_pipe_index]);
 				if (l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_phantom_prog_idx][dc_pipe_index]) {
 					memcpy(&dc_phantom_pipes[dc_pipe_index]->mcache_regs,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper_fpu.h
similarity index 95%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper_fpu.h
index e5d9a456645f..570129229ae2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper_fpu.h
@@ -1,6 +1,7 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2026 Advanced Micro Devices, Inc.
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
 
 #ifndef _DML21_WRAPPER_FPU_H_
 #define _DML21_WRAPPER_FPU_H_
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_dc_resource_mgmt.c
similarity index 96%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_dc_resource_mgmt.c
index 6b78334c2554..4050b0a47caf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_dc_resource_mgmt.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: MIT */
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2023 Advanced Micro Devices, Inc.
  *
@@ -332,7 +332,7 @@ static bool is_pipe_in_candidate_array(const unsigned int pipe_idx,
 	const unsigned int *candidate_array,
 	const unsigned int candidate_array_size)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < candidate_array_size; i++) {
 		if (candidate_array[i] == pipe_idx)
@@ -355,6 +355,7 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 	unsigned int last_resort_pipe_candidates[MAX_PIPES] = {0};
 	unsigned int num_preferred_candidates = 0;
 	unsigned int num_last_resort_candidates = 0;
+	unsigned int idx;
 	int i;
 
 	if (existing_state) {
@@ -366,13 +367,13 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 	}
 
 	// First see if any of the preferred are unmapped, and choose those instead
-	for (i = 0; pipes_needed > 0 && i < num_preferred_candidates; i++) {
-		pipe = &state->res_ctx.pipe_ctx[preferred_pipe_candidates[i]];
+	for (idx = 0; pipes_needed > 0 && idx < num_preferred_candidates; idx++) {
+		pipe = &state->res_ctx.pipe_ctx[preferred_pipe_candidates[idx]];
 		if (!is_plane_using_pipe(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			ASSERT(preferred_pipe_candidates[i] <= 0xFF);
-			pipe->pipe_idx = (uint8_t)preferred_pipe_candidates[i];
+			ASSERT(preferred_pipe_candidates[idx] <= 0xFF);
+			pipe->pipe_idx = (uint8_t)preferred_pipe_candidates[idx];
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
@@ -395,13 +396,13 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 	}
 
 	// Only use the last resort pipe candidates as a last resort
-	for (i = 0; pipes_needed > 0 && i < num_last_resort_candidates; i++) {
-		pipe = &state->res_ctx.pipe_ctx[last_resort_pipe_candidates[i]];
+	for (idx = 0; pipes_needed > 0 && idx < num_last_resort_candidates; idx++) {
+		pipe = &state->res_ctx.pipe_ctx[last_resort_pipe_candidates[idx]];
 		if (!is_plane_using_pipe(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			ASSERT(last_resort_pipe_candidates[i] <= 0xFF);
-			pipe->pipe_idx = (uint8_t)last_resort_pipe_candidates[i];
+			ASSERT(last_resort_pipe_candidates[idx] <= 0xFF);
+			pipe->pipe_idx = (uint8_t)last_resort_pipe_candidates[idx];
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
@@ -424,6 +425,7 @@ static bool find_more_free_pipes(struct dml2_context *ctx,
 	unsigned int last_resort_pipe_candidates[MAX_PIPES] = {0};
 	unsigned int num_preferred_candidates = 0;
 	unsigned int num_last_resort_candidates = 0;
+	unsigned int idx;
 	int i;
 
 	if (existing_state) {
@@ -435,13 +437,13 @@ static bool find_more_free_pipes(struct dml2_context *ctx,
 	}
 
 	// First see if any of the preferred are unmapped, and choose those instead
-	for (i = 0; pipes_needed > 0 && i < num_preferred_candidates; i++) {
-		pipe = &state->res_ctx.pipe_ctx[preferred_pipe_candidates[i]];
+	for (idx = 0; pipes_needed > 0 && idx < num_preferred_candidates; idx++) {
+		pipe = &state->res_ctx.pipe_ctx[preferred_pipe_candidates[idx]];
 		if (is_pipe_free(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			ASSERT(preferred_pipe_candidates[i] <= 0xFF);
-			pipe->pipe_idx = (uint8_t)preferred_pipe_candidates[i];
+			ASSERT(preferred_pipe_candidates[idx] <= 0xFF);
+			pipe->pipe_idx = (uint8_t)preferred_pipe_candidates[idx];
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
@@ -457,20 +459,20 @@ static bool find_more_free_pipes(struct dml2_context *ctx,
 		if (is_pipe_free(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			ASSERT(i >= 0 && i <= 0xFF);
+			ASSERT(i >= 0 && i < MAX_PIPES);
 			pipe->pipe_idx = (uint8_t)i;
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
 
 	// Only use the last resort pipe candidates as a last resort
-	for (i = 0; pipes_needed > 0 && i < num_last_resort_candidates; i++) {
-		pipe = &state->res_ctx.pipe_ctx[last_resort_pipe_candidates[i]];
+	for (idx = 0; pipes_needed > 0 && idx < num_last_resort_candidates; idx++) {
+		pipe = &state->res_ctx.pipe_ctx[last_resort_pipe_candidates[idx]];
 		if (is_pipe_free(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			ASSERT(last_resort_pipe_candidates[i] <= 0xFF);
-			pipe->pipe_idx = (uint8_t)last_resort_pipe_candidates[i];
+			ASSERT(last_resort_pipe_candidates[idx] <= 0xFF);
+			pipe->pipe_idx = (uint8_t)last_resort_pipe_candidates[idx];
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
@@ -526,7 +528,7 @@ static void sort_pipes_for_splitting(struct dc_plane_pipe_pool *pipes)
 static void calculate_odm_slices(const struct dc_stream_state *stream, unsigned int odm_factor, unsigned int *odm_slice_end_x)
 {
 	unsigned int slice_size = 0;
-	int i;
+	unsigned int i;
 
 	if (odm_factor < 1 || odm_factor > 4) {
 		ASSERT(false);
@@ -749,7 +751,7 @@ static void remove_pipes_from_blend_trees(struct dml2_context *ctx, struct dc_st
 static void map_pipes_for_stream(struct dml2_context *ctx, struct dc_state *state, const struct dc_stream_state *stream,
 		struct dc_pipe_mapping_scratch *scratch, const struct dc_state *existing_state)
 {
-	int odm_slice_index;
+	unsigned int odm_slice_index;
 	struct pipe_ctx *master_pipe = NULL;
 
 
@@ -769,7 +771,7 @@ static void map_pipes_for_stream(struct dml2_context *ctx, struct dc_state *stat
 static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state, const struct dc_stream_state *stream, const struct dc_plane_state *plane,
 		int plane_index, struct dc_pipe_mapping_scratch *scratch, const struct dc_state *existing_state)
 {
-	int odm_slice_index;
+	unsigned int odm_slice_index;
 	unsigned int plane_id;
 	struct pipe_ctx *master_pipe = NULL;
 	int i;
@@ -819,6 +821,10 @@ static unsigned int get_target_mpc_factor(struct dml2_context *ctx,
 		get_plane_id(ctx, state, status->plane_states[plane_idx],
 				stream->stream_id, plane_idx, &plane_id);
 		cfg_idx = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
+		if (!disp_cfg) {
+			ASSERT(0); // disp_cfg pointer is expected on DML2.0
+			return 1;
+		}
 		mpc_factor = (unsigned int)disp_cfg->hw.DPPPerSurface[cfg_idx];
 	} else if (ctx->architecture == dml2_architecture_21) {
 		if (ctx->config.svp_pstate.callbacks.get_stream_subvp_type(state, stream) == SUBVP_PHANTOM) {
@@ -872,6 +878,10 @@ static unsigned int get_target_odm_factor(
 	if (ctx->architecture == dml2_architecture_20) {
 		cfg_idx = find_disp_cfg_idx_by_stream_id(
 				mapping, stream->stream_id);
+		if (!disp_cfg) {
+			ASSERT(0); // disp_cfg pointer is expected on DML2.0
+			return 1;
+		}
 		switch (disp_cfg->hw.ODMMode[cfg_idx]) {
 		case dml_odm_mode_bypass:
 			return 1;
@@ -1082,6 +1092,10 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 		DPPPerSurface = (const unsigned int *)dpp_per_surface_array;
 		disp_cfg_index_max = __DML2_WRAPPER_MAX_STREAMS_PLANES__;
 	} else {
+		if (disp_cfg == NULL) {
+			ASSERT(0); // disp_cfg pointer is expected on DML2.0
+			return false;
+		}
 		ODMMode = (unsigned int *)disp_cfg->hw.ODMMode;
 		DPPPerSurface = disp_cfg->hw.DPPPerSurface;
 		disp_cfg_index_max = __DML_NUM_PLANES__;
@@ -1110,7 +1124,7 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 		/* After DML2.1 update, ODM interpretation needs to change and is no longer same as for DML2.0.
 		 * This is not an issue with new resource management logic. This block ensure backcompat
 		 * with legacy pipe management with updated DML.
-		 * */
+		 */
 			if (ODMMode[stream_disp_cfg_index] == 1) {
 				scratch.odm_info.odm_factor = 1;
 			} else if (ODMMode[stream_disp_cfg_index] == 2) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_dc_resource_mgmt.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_dc_resource_mgmt.h
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_types.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_dc_types.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_types.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_dc_types.h
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_internal_types.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_internal_types.h
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_internal_types.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_internal_types.h
index 55b3e3ca54f7..cb301c116615 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_internal_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_internal_types.h
@@ -33,7 +33,7 @@
 #include "dml2_policy.h"
 
 #include "dml_top.h"
-#include "dml21_wrapper.h"
+#include "dml21_wrapper/dml21_wrapper.h"
 
 struct dml2_wrapper_optimize_configuration_params {
 	struct display_mode_lib_st *dml_core_ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_mall_phantom.c
similarity index 97%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_mall_phantom.c
index 4543a60a0683..edc4dcdde952 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_mall_phantom.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: MIT */
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2023 Advanced Micro Devices, Inc.
  *
@@ -40,7 +40,7 @@ unsigned int dml2_helper_calculate_num_ways_for_subvp(struct dml2_context *ctx,
 	uint32_t bytes_in_mall = 0;
 	uint32_t num_mblks = 0;
 	uint32_t cache_lines_per_plane = 0;
-	uint32_t i = 0;
+	int i = 0;
 	uint32_t mblk_width = 0;
 	uint32_t mblk_height = 0;
 	uint32_t full_vp_width_blk_aligned = 0;
@@ -185,7 +185,7 @@ static bool mpo_in_use(const struct dc_state *context)
  */
 static unsigned int get_num_free_pipes(struct dml2_context *ctx, struct dc_state *state)
 {
-	unsigned int i;
+	int i;
 	unsigned int free_pipes = 0;
 	unsigned int num_pipes = 0;
 
@@ -228,7 +228,8 @@ static unsigned int get_num_free_pipes(struct dml2_context *ctx, struct dc_state
  */
 static bool assign_subvp_pipe(struct dml2_context *ctx, struct dc_state *context, unsigned int *index)
 {
-	unsigned int i, pipe_idx;
+	int i;
+	unsigned int pipe_idx;
 	unsigned int max_frame_time = 0;
 	bool valid_assignment_found = false;
 	unsigned int free_pipes = 2; //dcn32_get_num_free_pipes(dc, context);
@@ -272,8 +273,8 @@ static bool assign_subvp_pipe(struct dml2_context *ctx, struct dc_state *context
 					valid_assignment_found = true;
 					current_assignment_freesync = false;
 				/* For the 2-Freesync display case, still choose the one with the
-			     * longest frame time
-			     */
+				 * longest frame time
+				 */
 				} else if (stream->ignore_msa_timing_param && (!valid_assignment_found ||
 						(current_assignment_freesync && frame_us > max_frame_time))) {
 					*index = i;
@@ -309,8 +310,10 @@ static bool assign_subvp_pipe(struct dml2_context *ctx, struct dc_state *context
  */
 static bool enough_pipes_for_subvp(struct dml2_context *ctx, struct dc_state *state)
 {
-	unsigned int i, split_cnt, free_pipes;
-	unsigned int min_pipe_split = ctx->config.dcn_pipe_count + 1; // init as max number of pipes + 1
+	int i;
+	int split_cnt;
+	int free_pipes;
+	int min_pipe_split = ctx->config.dcn_pipe_count + 1; // init as max number of pipes + 1
 	bool subvp_possible = false;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
@@ -361,13 +364,13 @@ static bool subvp_subvp_schedulable(struct dml2_context *ctx, struct dc_state *c
 	struct dc_stream_state *phantom = NULL;
 	uint32_t microschedule_lines = 0;
 	uint32_t index = 0;
-	uint32_t i;
-	uint32_t max_microschedule_us = 0;
+	int i;
+	int32_t max_microschedule_us = 0;
 	int32_t vactive1_us, vactive2_us, vblank1_us, vblank2_us;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		uint32_t time_us = 0;
+		int32_t time_us = 0;
 
 		if (pipe == NULL || pipe->stream == NULL)
 			continue;
@@ -378,6 +381,10 @@ static bool subvp_subvp_schedulable(struct dml2_context *ctx, struct dc_state *c
 		if (pipe->stream && pipe->plane_state && !pipe->top_pipe &&
 				ctx->config.svp_pstate.callbacks.get_pipe_subvp_type(context, pipe) == SUBVP_MAIN) {
 			phantom = ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, pipe->stream);
+			if (phantom == NULL) {
+				ASSERT(0); // Not expected to happen
+				return false;
+			}
 			microschedule_lines = (phantom->timing.v_total - phantom->timing.v_front_porch) +
 					phantom->timing.v_addressable;
 
@@ -440,7 +447,7 @@ static bool subvp_subvp_schedulable(struct dml2_context *ctx, struct dc_state *c
 bool dml2_svp_drr_schedulable(struct dml2_context *ctx, struct dc_state *context, struct dc_crtc_timing *drr_timing)
 {
 	bool schedulable = false;
-	uint32_t i;
+	int i;
 	struct pipe_ctx *pipe = NULL;
 	struct dc_crtc_timing *main_timing = NULL;
 	struct dc_crtc_timing *phantom_timing = NULL;
@@ -473,6 +480,11 @@ bool dml2_svp_drr_schedulable(struct dml2_context *ctx, struct dc_state *context
 		return false;
 	}
 	phantom_stream = ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, pipe->stream);
+	if (phantom_stream == NULL) {
+		// Defensive: should never happen, try to catch in debug
+		ASSERT(0);
+		return false;
+	}
 	main_timing = &pipe->stream->timing;
 	phantom_timing = &phantom_stream->timing;
 	prefetch_us = (int32_t)((phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
@@ -524,7 +536,7 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 	struct pipe_ctx *subvp_pipe = NULL;
 	bool found = false;
 	bool schedulable = false;
-	uint32_t i = 0;
+	int i = 0;
 	uint8_t vblank_index = 0;
 	uint32_t prefetch_us = 0;
 	uint32_t mall_region_us = 0;
@@ -544,7 +556,7 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 	 * displays which are synchronized (in which case they have identical
 	 * timings).
 	 */
-	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
+	for (i = 0; i < ctx->config.dcn_pipe_count && i < MAX_PIPES ; i++) {
 		pipe = &context->res_ctx.pipe_ctx[i];
 		pipe_mall_type = ctx->config.svp_pstate.callbacks.get_pipe_subvp_type(context, pipe);
 
@@ -594,14 +606,11 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 		subvp_active_us = (uint32_t)(main_timing->v_addressable * main_timing->h_total /
 				(double)(main_timing->pix_clk_100hz * 100) * 1000000);
 		max_vblank_mallregion = vblank_blank_us > mall_region_us ? vblank_blank_us : mall_region_us;
-		const uint64_t required_us = (uint64_t)prefetch_us +
-					     (uint64_t)vblank_frame_us +
-					     (uint64_t)max_vblank_mallregion;
 
 		// Schedulable if VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 		// and the max of (VBLANK blanking time, MALL region)
 		// TODO: Possibly add some margin (i.e. the below conditions should be [...] > X instead of [...] > 0)
-		if ((uint64_t)subvp_active_us > required_us)
+		if (subvp_active_us - prefetch_us - vblank_frame_us - max_vblank_mallregion > 0)
 			schedulable = true;
 	}
 	return schedulable;
@@ -627,7 +636,8 @@ bool dml2_svp_validate_static_schedulability(struct dml2_context *ctx, struct dc
 {
 	bool schedulable = true;	// true by default for single display case
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
-	uint32_t i, pipe_idx;
+	int i;
+	uint32_t pipe_idx;
 	uint8_t subvp_count = 0;
 	uint8_t vactive_count = 0;
 
@@ -679,7 +689,7 @@ static void set_phantom_stream_timing(struct dml2_context *ctx, struct dc_state
 				     unsigned int svp_height,
 				     unsigned int svp_vstartup)
 {
-	unsigned int i;
+	int i;
 	double line_time, fp_and_sync_width_time;
 	struct pipe_ctx *pipe;
 	uint32_t phantom_vactive, phantom_bp, pstate_width_fw_delay_lines;
@@ -743,6 +753,10 @@ static struct dc_stream_state *enable_phantom_stream(struct dml2_context *ctx, s
 			state,
 			ref_pipe->stream);
 
+	if (!phantom_stream) {
+		ASSERT(0); //Phantom stream is expected to be created.
+		return NULL;
+	}
 	/* stream has limited viewport and small timing */
 	memcpy(&phantom_stream->timing, &ref_pipe->stream->timing, sizeof(phantom_stream->timing));
 	memcpy(&phantom_stream->src, &ref_pipe->stream->src, sizeof(phantom_stream->src));
@@ -813,12 +827,16 @@ static void enable_phantom_plane(struct dml2_context *ctx,
 static void add_phantom_pipes_for_main_pipe(struct dml2_context *ctx, struct dc_state *state, unsigned int main_pipe_idx, unsigned int svp_height, unsigned int vstartup)
 {
 	struct dc_stream_state *phantom_stream = NULL;
-	unsigned int i;
+	int i;
 
-	// The index of the DC pipe passed into this function is guarenteed to
+	// The index of the DC pipe passed into this function is guaranteed to
 	// be a valid candidate for SubVP (i.e. has a plane, stream, doesn't
 	// already have phantom pipe assigned, etc.) by previous checks.
 	phantom_stream = enable_phantom_stream(ctx, state, main_pipe_idx, svp_height, vstartup);
+	if (phantom_stream == NULL) {
+		ASSERT(0); // Phantom stream is expected to be created.
+		return;
+	}
 	enable_phantom_plane(ctx, state, phantom_stream, main_pipe_idx);
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
@@ -845,10 +863,10 @@ static bool remove_all_phantom_planes_for_stream(struct dml2_context *ctx, struc
 	struct dc_plane_state *del_planes[MAX_SURFACES] = { 0 };
 
 	for (i = 0; i < context->stream_count; i++)
-			if (context->streams[i] == stream) {
-				stream_status = &context->stream_status[i];
-				break;
-			}
+		if (context->streams[i] == stream) {
+			stream_status = &context->stream_status[i];
+			break;
+		}
 
 	if (stream_status == NULL) {
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_mall_phantom.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_mall_phantom.h
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_policy.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_policy.c
index ab2964811c5b..7b043ef3f2ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_policy.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: MIT */
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2023 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_policy.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_policy.h
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_translation_helper.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_translation_helper.c
index c82886323a51..a0130bbfc12a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_translation_helper.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: MIT */
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2023 Advanced Micro Devices, Inc.
  *
@@ -720,6 +720,7 @@ void dml2_translate_socbb_params(const struct dc *in, struct soc_bounding_box_st
 void dml2_translate_soc_states(const struct dc *dc, struct soc_states_st *out, int num_states)
 {
 	unsigned int i = 0;
+
 	out->num_states = num_states;
 
 	for (i = 0; i < out->num_states; i++) {
@@ -1096,7 +1097,7 @@ static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out
 
 	/* Current driver code base uses LBBitPerPixel as 57. There is a discrepancy
 	 * from the HW/DML teams about this value. Initialize LBBitPerPixel with the
-	 * value current used in Navi3x .
+	 * value current used in DCN32.
 	 */
 
 	out->LBBitPerPixel[location] = 57;
@@ -1292,12 +1293,12 @@ static void dml2_map_hpo_stream_encoder_to_hpo_link_encoder_index(struct dml2_co
 	for (i = 0; i < MAX_PIPES; i++) {
 		current_pipe_context = &context->res_ctx.pipe_ctx[i];
 		if (current_pipe_context->stream &&
-			current_pipe_context->stream_res.hpo_dp_stream_enc &&
-			current_pipe_context->link_res.hpo_dp_link_enc &&
-			dc_is_dp_signal(current_pipe_context->stream->signal)) {
-				dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[current_pipe_context->stream_res.hpo_dp_stream_enc->inst] =
-					current_pipe_context->link_res.hpo_dp_link_enc->inst;
-			}
+		    current_pipe_context->stream_res.hpo_dp_stream_enc &&
+		    current_pipe_context->link_res.hpo_dp_link_enc &&
+		    dc_is_dp_signal(current_pipe_context->stream->signal)) {
+			dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[current_pipe_context->stream_res.hpo_dp_stream_enc->inst] =
+				current_pipe_context->link_res.hpo_dp_link_enc->inst;
+		}
 	}
 }
 
@@ -1330,7 +1331,8 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 		current_pipe_context = NULL;
 		for (k = 0; k < MAX_PIPES; k++) {
 			/* find one pipe allocated to this stream for the purpose of getting
-			info about the link later */
+			 * info about the link later
+			 */
 			if (context->streams[i] == context->res_ctx.pipe_ctx[k].stream) {
 				current_pipe_context = &context->res_ctx.pipe_ctx[k];
 				break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_translation_helper.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_translation_helper.h
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_utils.c
similarity index 98%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_utils.c
index a3ce011612f7..8688792aa956 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_utils.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: MIT */
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2023 Advanced Micro Devices, Inc.
  *
@@ -168,7 +168,7 @@ bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 
 bool is_dtbclk_required(const struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
@@ -196,6 +196,7 @@ void dml2_copy_clocks_to_dc_state(struct dml2_dcn_clocks *out_clks, struct dc_st
 int dml2_helper_find_dml_pipe_idx_by_stream_id(struct dml2_context *ctx, unsigned int stream_id)
 {
 	int i;
+
 	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
 		if (ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[i] && ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[i] == stream_id)
 			return  i;
@@ -207,6 +208,7 @@ int dml2_helper_find_dml_pipe_idx_by_stream_id(struct dml2_context *ctx, unsigne
 static int find_dml_pipe_idx_by_plane_id(struct dml2_context *ctx, unsigned int plane_id)
 {
 	int i;
+
 	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
 		if (ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id_valid[i] && ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id[i] == plane_id)
 			return  i;
@@ -218,7 +220,8 @@ static int find_dml_pipe_idx_by_plane_id(struct dml2_context *ctx, unsigned int
 static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state, const struct dc_plane_state *plane,
 	unsigned int stream_id, unsigned int plane_index, unsigned int *plane_id)
 {
-	unsigned int i, j;
+	unsigned int i;
+	int j;
 	bool is_plane_duplicate = dml2->v20.scratch.plane_duplicate_exists;
 
 	if (!plane_id)
@@ -228,8 +231,8 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state
 		if (state->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < state->stream_status[i].plane_count; j++) {
 				if (state->stream_status[i].plane_states[j] == plane &&
-					(!is_plane_duplicate || (j == plane_index))) {
-					*plane_id = (i << 16) | j;
+					(!is_plane_duplicate || ((unsigned int)j == plane_index))) {
+					*plane_id = ((unsigned int)i << 16) | (unsigned int)j;
 					return true;
 				}
 			}
@@ -293,8 +296,8 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 	else
 		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
 
-	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
-		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
+	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < (int)dc->debug.min_disp_clk_khz)
+		context->bw_ctx.bw.dcn.clk.dispclk_khz = (int)dc->debug.min_disp_clk_khz;
 
 	context->bw_ctx.bw.dcn.compbuf_size_kb = in_ctx->v20.dml_core_ctx.ip.config_return_buffer_size_in_kbytes;
 
@@ -304,7 +307,8 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 		/* The DML2 and the DC logic of determining pipe indices are different from each other so
 		 * there is a need to know which DML pipe index maps to which DC pipe. The code below
 		 * finds a dml_pipe_index from the plane id if a plane is valid. If a plane is not valid then
-		 * it finds a dml_pipe_index from the stream id. */
+		 * it finds a dml_pipe_index from the stream id.
+		 */
 		if (get_plane_id(in_ctx, context, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_state,
 			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id,
 			in_ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[context->res_ctx.pipe_ctx[dc_pipe_ctx_index].pipe_idx], &plane_id)) {
@@ -371,7 +375,7 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 
 	if (dc->config.forced_clocks || dc->debug.max_disp_clk) {
 		context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz;
-		context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz ;
+		context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz;
 	}
 }
 
@@ -449,7 +453,7 @@ void dml2_extract_writeback_wm(struct dc_state *context, struct display_mode_lib
 		bw_writeback->mcif_wb_arb[i].arbitration_slice = 2;
 		bw_writeback->mcif_wb_arb[i].max_scaled_time =
 			dml2_calc_max_scaled_time(wb_arb_params->time_per_pixel,
-					wbif_mode, 	wb_arb_params->cli_watermark[0]);
+					wbif_mode, wb_arb_params->cli_watermark[0]);
 		/*not required any more*/
 		bw_writeback->mcif_wb_arb[i].dram_speed_change_duration =
 			(unsigned int)(dml_get_wm_writeback_dram_clock_change(dml_core_ctx) * 1000);
@@ -500,8 +504,8 @@ void dml2_apply_det_buffer_allocation_policy(struct dml2_context *in_ctx, struct
 			dml_dispcfg->plane.DETSizeOverride[plane_index] = ((max_det_size / num_of_streams) / num_of_planes_per_stream[stream_index] / in_ctx->det_helper_scratch.dpps_per_surface[plane_index]);
 
 			/* If the override size is not divisible by det_segment_size then round off to nearest number divisible by det_segment_size as
-				* this is a requirement.
-				*/
+			 * this is a requirement.
+			 */
 			if (dml_dispcfg->plane.DETSizeOverride[plane_index] % in_ctx->config.det_segment_size != 0) {
 				dml_dispcfg->plane.DETSizeOverride[plane_index] = dml_dispcfg->plane.DETSizeOverride[plane_index] & ~0x3F;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_utils.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_utils.h
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.c
similarity index 97%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.c
index 1772e74349c7..2fe3c4643f58 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.c
@@ -8,8 +8,8 @@
 #include "dml2_internal_types.h"
 #include "dml2_wrapper.h"
 #include "dml2_wrapper_fpu.h"
-#include "dml21_wrapper.h"
-#include "dml21_wrapper_fpu.h"
+#include "dml21_wrapper/dml21_wrapper.h"
+#include "dml21_wrapper/dml21_wrapper_fpu.h"
 
 #include "dc_fpu.h"
 
@@ -24,6 +24,7 @@ struct dml2_context *dml2_allocate_memory(void)
 	DC_RUN_WITH_PREEMPTION_ENABLED(dml2 = vzalloc(sizeof(struct dml2_context)));
 	return dml2;
 }
+
 bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml2,
 	enum dc_validate_mode validate_mode)
 {
@@ -87,7 +88,6 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
 
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
-
 }
 
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper.h
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper_fpu.c
similarity index 93%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper_fpu.c
index a14e3004a7b7..8a31986bc299 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper_fpu.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: MIT */
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2023 Advanced Micro Devices, Inc.
  *
@@ -33,8 +33,8 @@
 #include "dml2_dc_resource_mgmt.h"
 #include "dml2_wrapper.h"
 #include "dml2_wrapper_fpu.h"
-#include "dml21_wrapper.h"
-#include "dml21_wrapper_fpu.h"
+#include "dml21_wrapper/dml21_wrapper.h"
+#include "dml21_wrapper/dml21_wrapper_fpu.h"
 
 void initialize_dml2_ip_params(struct dml2_context *dml2, const struct dc *in_dc, struct ip_params_st *out)
 {
@@ -65,7 +65,8 @@ static void map_hw_resources(struct dml2_context *dml2,
 		struct dml_display_cfg_st *in_out_display_cfg, struct dml_mode_support_info_st *mode_support_info)
 {
 	unsigned int num_pipes = 0;
-	int i, j;
+	int i;
+	unsigned int j;
 
 	for (i = 0; i < __DML_NUM_PLANES__; i++) {
 		in_out_display_cfg->hw.ODMMode[i] = mode_support_info->ODMMode[i];
@@ -120,7 +121,7 @@ static bool optimize_configuration(struct dml2_context *dml2, struct dml2_wrappe
 	int unused_dpps = p->ip_params->max_num_dpp;
 	int i;
 	int odms_needed;
-	int largest_blend_and_timing = 0;
+	unsigned int largest_blend_and_timing = 0;
 	bool optimization_done = false;
 
 	for (i = 0; i < (int) p->cur_display_config->num_timings; i++) {
@@ -164,7 +165,8 @@ static int calculate_lowest_supported_state_for_temp_read(struct dml2_context *d
 	struct dml2_wrapper_scratch *s_global = &dml2->v20.scratch;
 
 	unsigned int dml_result = 0;
-	int result = -1, i, j;
+	unsigned int state_idx;
+	int result = -1, i;
 
 	build_unoptimized_policy_settings(dml2->v20.dml_core_ctx.project, &dml2->v20.dml_core_ctx.policy);
 
@@ -191,13 +193,13 @@ static int calculate_lowest_supported_state_for_temp_read(struct dml2_context *d
 
 	map_dc_state_into_dml_display_cfg(dml2, display_state, &s->cur_display_config);
 
-	for (i = 0; i < dml2->v20.dml_core_ctx.states.num_states; i++) {
-		s->uclk_change_latencies[i] = dml2->v20.dml_core_ctx.states.state_array[i].dram_clock_change_latency_us;
+	for (state_idx = 0; state_idx < (unsigned int)dml2->v20.dml_core_ctx.states.num_states; state_idx++) {
+		s->uclk_change_latencies[state_idx] = dml2->v20.dml_core_ctx.states.state_array[state_idx].dram_clock_change_latency_us;
 	}
 
 	for (i = 0; i < 4; i++) {
-		for (j = 0; j < dml2->v20.dml_core_ctx.states.num_states; j++) {
-			dml2->v20.dml_core_ctx.states.state_array[j].dram_clock_change_latency_us = s_global->dummy_pstate_table[i].dummy_pstate_latency_us;
+		for (state_idx = 0; state_idx < (unsigned int)dml2->v20.dml_core_ctx.states.num_states; state_idx++) {
+			dml2->v20.dml_core_ctx.states.state_array[state_idx].dram_clock_change_latency_us = s_global->dummy_pstate_table[i].dummy_pstate_latency_us;
 		}
 
 		dml_result = pack_and_call_dml_mode_support_ex(dml2, &s->cur_display_config, &s->evaluation_info,
@@ -221,8 +223,8 @@ static int calculate_lowest_supported_state_for_temp_read(struct dml2_context *d
 		}
 	}
 
-	for (i = 0; i < dml2->v20.dml_core_ctx.states.num_states; i++) {
-		dml2->v20.dml_core_ctx.states.state_array[i].dram_clock_change_latency_us = s->uclk_change_latencies[i];
+	for (state_idx = 0; state_idx < (unsigned int)dml2->v20.dml_core_ctx.states.num_states; state_idx++) {
+		dml2->v20.dml_core_ctx.states.state_array[state_idx].dram_clock_change_latency_us = s->uclk_change_latencies[state_idx];
 	}
 
 	return result;
@@ -230,7 +232,7 @@ static int calculate_lowest_supported_state_for_temp_read(struct dml2_context *d
 
 static void copy_dummy_pstate_table(struct dummy_pstate_entry *dest, struct dummy_pstate_entry *src, unsigned int num_entries)
 {
-	for (int i = 0; i < num_entries; i++) {
+	for (unsigned int i = 0; i < num_entries; i++) {
 		dest[i] = src[i];
 	}
 }
@@ -239,7 +241,7 @@ static bool are_timings_requiring_odm_doing_blending(const struct dml_display_cf
 		const struct dml_mode_support_info_st *evaluation_info)
 {
 	unsigned int planes_per_timing[__DML_NUM_PLANES__] = {0};
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < display_cfg->num_surfaces; i++)
 		planes_per_timing[display_cfg->plane.BlendingAndTiming[i]]++;
@@ -270,7 +272,8 @@ static bool dml_mode_support_wrapper(struct dml2_context *dml2,
 		enum dc_validate_mode validate_mode)
 {
 	struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
-	unsigned int result = 0, i;
+	unsigned int result = 0;
+	int i;
 	unsigned int optimized_result = true;
 
 	build_unoptimized_policy_settings(dml2->v20.dml_core_ctx.project, &dml2->v20.dml_core_ctx.policy);
@@ -383,7 +386,8 @@ static bool call_dml_mode_support_and_programming(struct dc_state *context, enum
 	 */
 	if (!context->streams[0]->sink->link->dc->caps.is_apu) {
 		if (min_state_for_g6_temp_read >= 0)
-			min_state = min_state_for_g6_temp_read > s->mode_support_params.out_lowest_state_idx ? min_state_for_g6_temp_read : s->mode_support_params.out_lowest_state_idx;
+			min_state = (unsigned int)min_state_for_g6_temp_read > s->mode_support_params.out_lowest_state_idx ?
+				(unsigned int)min_state_for_g6_temp_read : s->mode_support_params.out_lowest_state_idx;
 		else
 			min_state = s->mode_support_params.out_lowest_state_idx;
 	}
@@ -463,6 +467,7 @@ bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_state *c
 
 	if (result) {
 		unsigned int lowest_state_idx = s->mode_support_params.out_lowest_state_idx;
+
 		out_clks.dispclk_khz = (unsigned int)dml2->v20.dml_core_ctx.mp.Dispclk_calculated * 1000;
 		out_clks.p_state_supported = s->mode_support_info.DRAMClockChangeSupport[0] != dml_dram_clock_change_unsupported;
 		if (in_dc->config.use_default_clock_table &&
@@ -499,8 +504,8 @@ bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_state *c
 		cstate_enter_plus_exit_z8_ns = context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_z8_ns;
 
 		if (context->bw_ctx.dml.vba.StutterPeriod < in_dc->debug.minimum_z8_residency_time &&
-				cstate_enter_plus_exit_z8_ns < in_dc->debug.minimum_z8_residency_time * 1000)
-			cstate_enter_plus_exit_z8_ns = in_dc->debug.minimum_z8_residency_time * 1000;
+				cstate_enter_plus_exit_z8_ns < (uint32_t)in_dc->debug.minimum_z8_residency_time * 1000)
+			cstate_enter_plus_exit_z8_ns = (uint32_t)in_dc->debug.minimum_z8_residency_time * 1000;
 
 		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_z8_ns = cstate_enter_plus_exit_z8_ns;
 	}
@@ -527,8 +532,8 @@ bool dml2_validate_only(struct dc_state *context, enum dc_validate_mode validate
 	build_unoptimized_policy_settings(dml2->v20.dml_core_ctx.project, &dml2->v20.dml_core_ctx.policy);
 
 	map_dc_state_into_dml_display_cfg(dml2, context, &dml2->v20.scratch.cur_display_config);
-	 if (!dml2->config.skip_hw_state_mapping)
-		 dml2_apply_det_buffer_allocation_policy(dml2, &dml2->v20.scratch.cur_display_config);
+	if (!dml2->config.skip_hw_state_mapping)
+		dml2_apply_det_buffer_allocation_policy(dml2, &dml2->v20.scratch.cur_display_config);
 
 	result = pack_and_call_dml_mode_support_ex(dml2,
 		&dml2->v20.scratch.cur_display_config,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.h b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper_fpu.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.h
rename to drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml2_wrapper_fpu.h
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 7c2a79015f4e..c9eba16ef359 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -97,7 +97,7 @@
 #include "dc_state_priv.h"
 #include "dc_fpu.h"
 
-#include "dml2_0/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
 
 #if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
 #define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 52826e96c184..6f095500afd3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -34,7 +34,7 @@
 #include "include/irq_service_interface.h"
 #include "basics/conversion.h"
 #include "dcn35_resource.h"
-#include "dml2_0/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
 
 #include "dcn20/dcn20_resource.h"
 #include "dcn30/dcn30_resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index e3fc71307c91..c40d4800194f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -87,7 +87,7 @@
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
 
-#include "dml2_0/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
 
 #include "link_enc_cfg.h"
 #define DC_LOGGER_INIT(logger)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index c019a657005d..593eb1d2dffe 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -12,7 +12,7 @@
 #include "include/irq_service_interface.h"
 #include "basics/conversion.h"
 #include "dcn36_resource.h"
-#include "dml2_0/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
 
 #include "dcn20/dcn20_resource.h"
 #include "dcn30/dcn30_resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index aced8ff657bf..34e218bff078 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -78,7 +78,7 @@
 
 #include "dc_state_priv.h"
 
-#include "dml2_0/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 3c7cd3ecc687..bcfde21b6d79 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -87,7 +87,7 @@
 #include "dc_state_priv.h"
 #include "link_enc_cfg.h"
 
-#include "dml2_0/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
 
 #define regBIF_BX0_BIOS_SCRATCH_3                            0x003b
 #define regBIF_BX0_BIOS_SCRATCH_3_BASE_IDX                   1
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 8b1ee45d9c13..b7bc24136f79 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -88,7 +88,7 @@
 #include "dc_state_priv.h"
 #include "link_enc_cfg.h"
 
-#include "dml2_0/dml2_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index d7947105af22..8228fb62a350 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -81,8 +81,8 @@
 
 #include "dc_state_priv.h"
 
-#include "dml2_0/dml2_wrapper.h"
-#include "dml2_0/dml21/dml21_wrapper.h"
+#include "dml2_wrapper/dml2_wrapper.h"
+#include "dml2_wrapper/dml21_wrapper/dml21_wrapper.h"
 
 #define DC_LOGGER_INIT(logger)
 
-- 
2.43.0

