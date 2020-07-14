Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B8FC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269F121582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H1R6GTKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269F121582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EE88931E;
	Tue, 14 Jul 2020 08:07:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 451318931E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZnwHuu81nUO+fFsGZIfkhOnxxT5LT1Gw7dVXVLGcdmErmXgPsLfDrsOj2G+hO2kbrWqDSRFZMjY2ZcTuyTEo9x53U+nKp/9HFrBQBwg910mw93yPACKY0KB6OPdBGDVa8eKj2SH8aalLM8o81+c/UcLj2eThq0oMO/ZAhpgxDEhVgkP1pfXsjCUgPNIj+22OOFRUibeREEcZE6FA3V02Zs/4SY+DNsRv7Ee5Vqc2Wf5LyOjqm9MQb8u62DkzwDL0m8FTpdnKAeRIoG8zlvIga+Abz2an3z1di4Kc7jRuQy+Cut9aud9QGJWNBuG38p4B//+WfSB5hzEa/CL+7YWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dm5ywUouxl6zk462sJSHH4yw7bdYACN6l3hvf47U6w=;
 b=greuSKJMcpaDWQx2/h6sHd6tDqxu/GPwNDF9gPBrAkVDpikDT3iCU9rmf8OfvUSdU8f/8nKMK1yW/UTHVRpmBdwkzdttXM67gB034n92Mh8Cb/oMsydE/GG6jqOcYRLD4bm5CdukT+Z84ilC5kqT+H7ZbS1n+WWzcj8qGwa/wdIhnwOcsouL82dSgetHBE1PNoO85tMAaNyRT57s6pt4++KlqMp7s5dj8ZsAVMCn8K83AjSFya7q7zEOiyuNZkUytXK211ew7la8+vfuJ6snlLiLn6qNm6XZ0/FcEmmzHYYA1UwwVtEdhRRiaFW88d512NHd7aEcsuYfw7tbJd4GpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dm5ywUouxl6zk462sJSHH4yw7bdYACN6l3hvf47U6w=;
 b=H1R6GTKczY7Kmj8JKCYjodRZXTPkVmSgI1Wcxkwy39sSAVJURzmALmwGr3hnp+V1mzrZCqwFKy3Dx+Hd703YVcz8/jyN9Lr9jMRUs5zBqRrVLwcezNujuTJSW28IVV1D5pUSRQurJ28+qdxYL9tgQ5PgpLgkKrdu8ZSiBBobIhM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:07:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:07:22 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/17] drm/amd/powerplay: tag swSMU code layers
Date: Tue, 14 Jul 2020 16:04:16 +0800
Message-Id: <20200714080416.6506-17-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714080416.6506-1-evan.quan@amd.com>
References: <20200714080416.6506-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:07:20 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ed0b72d-f9a9-4f33-619f-08d827ccef53
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355C7D84B06DC39B3ED8153E4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVLqDMVPHmpOK4bKhiCd3fDCTms4FlATOet6jseVS6abDLdOX2VP8pnQdPbJ1Rf+4b/VwC0Kgp1GxyP+HoxVmM8U3kDoaNFaCytfj30ipFtXaZRzqJEArpXbCsX/nT4lXcqPQlEZMyH/ZAZaGmkn8vBivJxYshUNX8Kr+eizHZs7D7kjfv4O4BVmTzhKCxCOoWcmPbnQPLpFKNpjG88T53cLWwLs7n/Vkk9FyE80G0wElKP464ArH6yh3JuBrhJq+VfsKysqdLhlKJgdEgyC/3lGShYrCEpKF/0VqdBMczVuAc8JXAnIWHxylCuJ3Fbv5OPWO4NIS/CRBgBLnBF7iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QxT4iPCuK76Ocx5k5f9muyUI8w3vWfJkZQVU2bKyeaW5WcNh8IUPActJE9gJAoIun66D1L8nGaSeXPxfljB00cL+fPvjt5F67aJZbO/qrqfP+QAF/VNkxefJp69AcslCivyy4epNy8G0oWuCYF0FTRACpSCag+9rHPsarBDogIa5LfpoWue5aJT9XxyuSxp0Rn63URyQvirpIOk/bkf+weXmU/U3fVbQyivKORLYRgU1Cr6p1ulJr4pc35pMAnVZ9tbMkZer0rjP3F/jwAcLDDNKpPJJ7pLeF1TS6KVJvLaG57M+91kqyjDnIgT6gfP4RFtYfC2T5Mpp5V3GEv1Y1W3OrSpgH4aY3Q6wVRnoW9v5d/+lLxXkE5KmpgrGkiullyak+IdiJoNu7k87fVya6ePHUqaFguYP5zERxPv8EYwzQvzjbtb2n3ldXSmmwVJCVAiHkEcd9AGilxI9+vH4hhcZeRArP91YJ/D/D7aKveP6DE3RopfS/HI2hVK3SvPa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed0b72d-f9a9-4f33-619f-08d827ccef53
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:07:21.8733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Gu9N3zrVCyTjqskr+i4KzvMHw4Zh7BNBnxLfqxHI4CwwsWgpdndjHb6PH/PNsnd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Per designs, the swSMU code is separated into four layers. And the typical
calling flow should be like: amdgpu_smu.c -> ${asic}_ppt.c -> smu_v11/12_0.c
-> smu_cmn.c. Compile errors will come out for any violations. This can
help to prevent cross callings(e.g. amdgpu_smu.c -> ${asic}_ppt.c ->
amdgpu_smu.c -> ${asic}_ppt.c) which were common in our code.

Change-Id: I70e717f4527c736d6263680c69eeda96d1cf9bb6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 4 ++--
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 3 ++-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     | 2 ++
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      | 3 +++
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h      | 3 +++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 3 ++-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 3 ++-
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 ++-
 drivers/gpu/drm/amd/powerplay/smu_cmn.c            | 3 ++-
 drivers/gpu/drm/amd/powerplay/smu_cmn.h            | 2 ++
 drivers/gpu/drm/amd/powerplay/smu_internal.h       | 3 +++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 2 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          | 3 ++-
 13 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index ebf8928660b8..f246589cbf30 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -20,14 +20,14 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#define SWSMU_CODE_LAYER_L1
+
 #include <linux/firmware.h>
 #include <linux/pci.h>
 
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
-#include "smu_v11_0.h"
-#include "smu_v12_0.h"
 #include "atom.h"
 #include "arcturus_ppt.h"
 #include "navi10_ppt.h"
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 59859eb4796f..fde6a8242565 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -21,10 +21,11 @@
  *
  */
 
+#define SWSMU_CODE_LAYER_L2
+
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
-#include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
 #include "smu_v11_0.h"
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 05bd6c0d6d7c..812068ba1dd6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -650,6 +650,7 @@ enum smu_cmn2asic_mapping_type {
 #define WORKLOAD_MAP(profile, workload) \
 	[profile] = {1, (workload)}
 
+#if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_load_microcode(struct smu_context *smu);
 
 int smu_check_fw_status(struct smu_context *smu);
@@ -783,3 +784,4 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 			    struct dpm_clocks *clock_table);
 
 #endif
+#endif
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index e9a3bd294876..6a3ef497c7fd 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -133,6 +133,8 @@ enum smu_v11_0_baco_seq {
 	BACO_SEQ_COUNT,
 };
 
+#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
+
 int smu_v11_0_init_microcode(struct smu_context *smu);
 
 void smu_v11_0_fini_microcode(struct smu_context *smu);
@@ -264,3 +266,4 @@ int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 				  uint32_t *max_value);
 
 #endif
+#endif
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index 52cdd6a0f99a..02de3b6199e5 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -31,6 +31,8 @@
 #define MP1_Public			0x03b00000
 #define MP1_SRAM			0x03c00004
 
+#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
+
 int smu_v12_0_check_fw_status(struct smu_context *smu);
 
 int smu_v12_0_check_fw_version(struct smu_context *smu);
@@ -59,3 +61,4 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 int smu_v12_0_set_driver_table_location(struct smu_context *smu);
 
 #endif
+#endif
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 9ed2377ababa..edabf4730655 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -21,11 +21,12 @@
  *
  */
 
+#define SWSMU_CODE_LAYER_L2
+
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
-#include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
 #include "soc15_common.h"
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index fdf27bb90777..fc58adfff0ba 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -21,9 +21,10 @@
  *
  */
 
+#define SWSMU_CODE_LAYER_L2
+
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
-#include "smu_internal.h"
 #include "smu_v12_0_ppsmc.h"
 #include "smu12_driver_if.h"
 #include "smu_v12_0.h"
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index ace46022cf0d..771a666868a1 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -21,11 +21,12 @@
  *
  */
 
+#define SWSMU_CODE_LAYER_L2
+
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
-#include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
 #include "smu_v11_0.h"
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index 4084c707c04a..be4b678d0e60 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -20,10 +20,11 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#define SWSMU_CODE_LAYER_L4
+
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_cmn.h"
-#include "smu_internal.h"
 #include "soc15_common.h"
 
 /*
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index e07ff6330c54..98face8c5fd6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -25,6 +25,7 @@
 
 #include "amdgpu_smu.h"
 
+#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
@@ -79,3 +80,4 @@ int smu_cmn_write_watermarks_table(struct smu_context *smu);
 int smu_cmn_write_pptable(struct smu_context *smu);
 
 #endif
+#endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index e221bd2c466a..58a4cbafcfb2 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -25,6 +25,8 @@
 
 #include "amdgpu_smu.h"
 
+#if defined(SWSMU_CODE_LAYER_L1)
+
 #define smu_ppt_funcs(intf, ret, smu, args...) \
 	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ? (smu)->ppt_funcs->intf(smu, ##args) : ret) : -EINVAL)
 
@@ -94,3 +96,4 @@
 #define smu_set_pp_feature_mask(smu, new_mask)				smu_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
 
 #endif
+#endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index dd45f271d2be..69762f94936e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -26,10 +26,10 @@
 #include <linux/reboot.h>
 
 #define SMU_11_0_PARTIAL_PPTABLE
+#define SWSMU_CODE_LAYER_L3
 
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
-#include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
 #include "smu_v11_0.h"
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 7855e8d88af7..31456437bb18 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -20,10 +20,11 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#define SWSMU_CODE_LAYER_L3
+
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
-#include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
 #include "smu_v12_0.h"
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
