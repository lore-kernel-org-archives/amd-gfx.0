Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B2C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D074521582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aRkvFWK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D074521582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6C0892E6;
	Tue, 14 Jul 2020 08:06:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798FC892E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cetoSDcLxxf96Bq9EI1XZn2X9Rxudl2B+9IwvYWbN0AZXncMJNxpMPlagKKMw0Zt/Ghp0g2VdVHQP3apPshp3FnEi0yXbbZfN4fAAhUsbHiOVvW93QVt16YP4qUZ2C9eVKTLNvCtaPidKfvYdJ2UkUGCJOk7SklXI93oX9Aowwl9ydIcSjeXrhasMrRXIbvJUHkcmiWA307eSdTOw3op31xVaadSvcFEW0CKNgERvNVwFqQPalKdMdpXYFIcVQxG3QHnwjWhWujGl45tX/R676E8TFXCTPo0G7C2YbTAdTOXKswR72SV4wzis4fGPNoNGGPUC+fnPPJMFOuD6pf/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydJLqp0kMCfgSG7YyxuXgGajY3pyFLCqpluPA2BsILg=;
 b=jOeEuAZ6hXEDmTg1Jm/TIuF1gDG0VSNuH1uKx0/byvl/PasvkD/anmpegu0z3T9NIe7KG5Jkk6JZaCZntwAGvi3W6yznZI3jSBpxBsqVTjCpZm0Fd6LDzU8FNq9mYoxXDbNBOK1iiWvSE+nfVFCRWIN/K+1U3uW5X+4xhe8UvYkkiOnf9hwbKb2Jk5MusENrlD3Fa/H34LLGiTLCLXxcF21UwKIvhAcxAODpvD1TZxix3t0DbtsX0rIf6j8FQ3lbcWTIspcHRWqebKlI3lncLHpbcMxqDB7/eG3FzDllA6H2svtD2dp4ILy5lgQMpMQOvPFcUIUzchi2z8fRZ30rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydJLqp0kMCfgSG7YyxuXgGajY3pyFLCqpluPA2BsILg=;
 b=aRkvFWK9JJdixw0ph16X+qS86h2AcSeT3jyEXg7KjuyAl90S4SoCtlzzA518cEc/6R4Z7VnfuG9Bp7yN3uDSr/Y3yPu2rxu01lKG8Ar9sk0jVo6HFE1EFZQJY78pFN3NzLSNiW40nxlT4eZqTDfD4gyDG6ZfOpcEZ3DPypiKf80=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:06:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:06:29 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/17] drm/amd/powerplay: unify swSMU index to asic specific
 index mapping
Date: Tue, 14 Jul 2020 16:04:01 +0800
Message-Id: <20200714080416.6506-2-evan.quan@amd.com>
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
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:27 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 256149c2-b99d-4819-9e65-08d827ccd015
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435553C6C6E1B7B9A1E11F40E4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qISmsSeIu37M0dhVFdfAFEKwwm8NfdpwT3UetjRSdpoNH2T7fSJSfhWgNzGmS2VFOesDeF9JOm7C+zJdFfCAFAJmaF03RDQyYVBhzvbtZGmPFtAeGk66jrPNMRZBPvyqyi3ymFME2K/NHY+EHc8jPNkAclZjXMZjD4l2Q0ZP8Irgvbx3wNDR4EmGS/jsF2X0qwFoMuQ022XvkEEFP1fT/BedQd4n+DdP0s8b3DTuoq7E7r/SQuD1Ak3vWtKIiCNrWBV/oIGTpyLgko09dSKSeODb0rl/PbtNzyhtPbH4EumeXQtfXK3yvIX1IHVoVRPOWZgxjHeqFcwB+kKq9oW8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(30864003)(86362001)(7696005)(16526019)(26005)(6916009)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ik2bCLIXl7n4/rfLbrN/tBSJUlYF2dP4qDIs5HxeFoC4fyyGWUo88xJGxdUodBRBQ8RpjzbXUxWYdDBNuOkWoN2sDZgrsy5TYykREmKeGwTHHLRXuHB/SfSzR+1MxkQwJIQd+EBV5lOQjx1BsrPCyPBBJqNb3fWZ6+51FxSc8LwaZmcN9FiqACfcVjS6WK8AM23Hb/TB6XG4WqxDLVOU9g2eu6xnELudkyjuRI1YBYbehm78cxoqeDG+zSNQte7FESaXEYMhix83gSKxECQFkf8l0odRhJNpCReRb8uwO6jJfSE99NQsykGh4Iz7KY8kUw1QmHig1t2EzsVRQ3DqlxOCVS+C4kqMj5CWhRxfNPYIRrOO2ygbP5evAH7+0ZYFsn954av5PRwRNo8y9gnpRq9nNjIr8C9AQV1Tw/5KdiWU9qGPtivJ72qQaC+mGJM/hxfwx2G2N5lY9/BpIXpjPNBF4JUUxXb9cudUVajplvgqVSFbiemYbMCKUlYfnLq9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256149c2-b99d-4819-9e65-08d827ccd015
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:06:29.5022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGFHJ7o9tv5ywD2gpoMH2BF6e6IKcK7Q9QAF0Cbs93YSvhXmn5l8kTw+DHaxM6Wa
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

By this we can drop redundant code.

Change-Id: I2b29e948296729afa5d4f157b9f86b376257a299
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/Makefile        |   4 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  29 ++-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  51 +++--
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  50 +++++
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  15 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  56 ++++--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 174 ++++++++++--------
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 156 +++++++++-------
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 118 ++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       |  32 ++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  36 +++-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |   5 +-
 12 files changed, 526 insertions(+), 200 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/powerplay/smu_cmn.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/smu_cmn.h

diff --git a/drivers/gpu/drm/amd/powerplay/Makefile b/drivers/gpu/drm/amd/powerplay/Makefile
index d27a02ac5f53..e9c48f99f71b 100644
--- a/drivers/gpu/drm/amd/powerplay/Makefile
+++ b/drivers/gpu/drm/amd/powerplay/Makefile
@@ -35,7 +35,9 @@ AMD_POWERPLAY = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/powerplay/,$(
 
 include $(AMD_POWERPLAY)
 
-POWER_MGR = amd_powerplay.o amdgpu_smu.o smu_v11_0.o smu_v12_0.o arcturus_ppt.o navi10_ppt.o renoir_ppt.o sienna_cichlid_ppt.o
+POWER_MGR = amd_powerplay.o amdgpu_smu.o smu_v11_0.o \
+	    smu_v12_0.o arcturus_ppt.o navi10_ppt.o \
+	    renoir_ppt.o sienna_cichlid_ppt.o smu_cmn.o
 
 AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR))
 
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 0daea412d0a0..f9be6df0d4a2 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -34,6 +34,7 @@
 #include "sienna_cichlid_ppt.h"
 #include "renoir_ppt.h"
 #include "amd_pcie.h"
+#include "smu_cmn.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -94,7 +95,9 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 			feature_mask[1], feature_mask[0]);
 
 	for (i = 0; i < SMU_FEATURE_COUNT; i++) {
-		feature_index = smu_feature_get_index(smu, i);
+		feature_index = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_FEATURE,
+							       i);
 		if (feature_index < 0)
 			continue;
 		sort_feature[feature_index] = i;
@@ -392,7 +395,9 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_table *table = &smu_table->driver_table;
-	int table_id = smu_table_get_index(smu, table_index);
+	int table_id = smu_cmn_to_asic_specific_index(smu,
+						      CMN2ASIC_MAPPING_TABLE,
+						      table_index);
 	uint32_t table_size;
 	int ret = 0;
 	if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
@@ -533,7 +538,9 @@ int smu_feature_is_enabled(struct smu_context *smu, enum smu_feature_mask mask)
 
 	if (smu->is_apu)
 		return 1;
-	feature_id = smu_feature_get_index(smu, mask);
+	feature_id = smu_cmn_to_asic_specific_index(smu,
+						    CMN2ASIC_MAPPING_FEATURE,
+						    mask);
 	if (feature_id < 0)
 		return 0;
 
@@ -552,7 +559,9 @@ int smu_feature_set_enabled(struct smu_context *smu, enum smu_feature_mask mask,
 	struct smu_feature *feature = &smu->smu_feature;
 	int feature_id;
 
-	feature_id = smu_feature_get_index(smu, mask);
+	feature_id = smu_cmn_to_asic_specific_index(smu,
+						    CMN2ASIC_MAPPING_FEATURE,
+						    mask);
 	if (feature_id < 0)
 		return -EINVAL;
 
@@ -569,7 +578,9 @@ int smu_feature_is_supported(struct smu_context *smu, enum smu_feature_mask mask
 	int feature_id;
 	int ret = 0;
 
-	feature_id = smu_feature_get_index(smu, mask);
+	feature_id = smu_cmn_to_asic_specific_index(smu,
+						    CMN2ASIC_MAPPING_FEATURE,
+						    mask);
 	if (feature_id < 0)
 		return 0;
 
@@ -1300,7 +1311,9 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (use_baco && smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
 		features_to_disable = U64_MAX &
-			~(1ULL << smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT));
+			~(1ULL << smu_cmn_to_asic_specific_index(smu,
+							CMN2ASIC_MAPPING_FEATURE,
+							SMU_FEATURE_BACO_BIT));
 		ret = smu_feature_update_enable_state(smu,
 						      features_to_disable,
 						      0);
@@ -1868,7 +1881,9 @@ int smu_set_mp1_state(struct smu_context *smu,
 	}
 
 	/* some asics may not support those messages */
-	if (smu_msg_get_index(smu, msg) < 0) {
+	if (smu_cmn_to_asic_specific_index(smu,
+					   CMN2ASIC_MAPPING_MSG,
+					   msg) < 0) {
 		mutex_unlock(&smu->mutex);
 		return 0;
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 03361d0194fe..53bac77d0f9e 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -43,6 +43,7 @@
 #include <linux/i2c.h>
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
+#include "smu_cmn.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -56,8 +57,6 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
-#define MSG_MAP(msg, index, valid_in_vf) \
-	[SMU_MSG_##msg] = {1, (index), (valid_in_vf)}
 #define ARCTURUS_FEA_MAP(smu_feature, arcturus_feature) \
 	[smu_feature] = {1, (arcturus_feature)}
 
@@ -78,7 +77,7 @@
 /* possible frequency drift (1Mhz) */
 #define EPSILON				1
 
-static struct smu_11_0_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
+static const struct cmn2asic_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
 	MSG_MAP(GetDriverIfVersion,		     PPSMC_MSG_GetDriverIfVersion,		1),
@@ -141,7 +140,7 @@ static struct smu_11_0_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(ReadSerialNumBottom32,		     PPSMC_MSG_ReadSerialNumBottom32,		1),
 };
 
-static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
+static const struct cmn2asic_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(GFXCLK, PPCLK_GFXCLK),
 	CLK_MAP(SCLK,	PPCLK_GFXCLK),
 	CLK_MAP(SOCCLK, PPCLK_SOCCLK),
@@ -152,7 +151,7 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(VCLK, PPCLK_VCLK),
 };
 
-static struct smu_11_0_cmn2aisc_mapping arcturus_feature_mask_map[SMU_FEATURE_COUNT] = {
+static const struct cmn2asic_mapping arcturus_feature_mask_map[SMU_FEATURE_COUNT] = {
 	FEA_MAP(DPM_PREFETCHER),
 	FEA_MAP(DPM_GFXCLK),
 	FEA_MAP(DPM_UCLK),
@@ -181,7 +180,7 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_feature_mask_map[SMU_FEATURE_CO
 	FEA_MAP(TEMP_DEPENDENT_VMIN),
 };
 
-static struct smu_11_0_cmn2aisc_mapping arcturus_table_map[SMU_TABLE_COUNT] = {
+static const struct cmn2asic_mapping arcturus_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(PPTABLE),
 	TAB_MAP(AVFS),
 	TAB_MAP(AVFS_PSM_DEBUG),
@@ -194,12 +193,12 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 };
 
-static struct smu_11_0_cmn2aisc_mapping arcturus_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
+static const struct cmn2asic_mapping arcturus_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
 	PWR_MAP(AC),
 	PWR_MAP(DC),
 };
 
-static struct smu_11_0_cmn2aisc_mapping arcturus_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
+static const struct cmn2asic_mapping arcturus_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,	WORKLOAD_PPLIB_DEFAULT_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,		WORKLOAD_PPLIB_POWER_SAVING_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
@@ -209,6 +208,7 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_workload_map[PP_SMC_POWER_PROFI
 
 static int arcturus_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_msg_mapping mapping;
 
 	if (index >= SMU_MSG_MAX_COUNT)
@@ -222,10 +222,13 @@ static int arcturus_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 		return -EACCES;
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int arcturus_get_smu_clk_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_CLK_COUNT)
@@ -238,10 +241,13 @@ static int arcturus_get_smu_clk_index(struct smu_context *smc, uint32_t index)
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int arcturus_get_smu_feature_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_FEATURE_COUNT)
@@ -253,10 +259,13 @@ static int arcturus_get_smu_feature_index(struct smu_context *smc, uint32_t inde
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int arcturus_get_smu_table_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_TABLE_COUNT)
@@ -269,10 +278,13 @@ static int arcturus_get_smu_table_index(struct smu_context *smc, uint32_t index)
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int arcturus_get_pwr_src_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_POWER_SOURCE_COUNT)
@@ -285,10 +297,13 @@ static int arcturus_get_pwr_src_index(struct smu_context *smc, uint32_t index)
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int arcturus_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (profile > PP_SMC_POWER_PROFILE_CUSTOM)
@@ -299,6 +314,8 @@ static int arcturus_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER
 		return -EINVAL;
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int arcturus_tables_init(struct smu_context *smu, struct smu_table *tables)
@@ -730,7 +747,9 @@ static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
 	if (!value)
 		return -EINVAL;
 
-	clk_id = smu_clk_get_index(smu, clk_type);
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
 	if (clk_id < 0)
 		return -EINVAL;
 
@@ -1300,7 +1319,9 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
 		 * Not all profile modes are supported on arcturus.
 		 */
-		workload_type = smu_workload_get_type(smu, i);
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       i);
 		if (workload_type < 0)
 			continue;
 
@@ -1424,7 +1445,9 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 	 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
 	 * Not all profile modes are supported on arcturus.
 	 */
-	workload_type = smu_workload_get_type(smu, profile_mode);
+	workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       profile_mode);
 	if (workload_type < 0) {
 		dev_err(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
 		return -EINVAL;
@@ -2401,4 +2424,10 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 void arcturus_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &arcturus_ppt_funcs;
+	smu->message_map = arcturus_message_map;
+	smu->clock_map = arcturus_clk_map;
+	smu->feature_map = arcturus_feature_mask_map;
+	smu->table_map = arcturus_table_map;
+	smu->pwr_src_map = arcturus_pwr_src_map;
+	smu->workload_map = arcturus_workload_map;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 28894b8bab67..5bcc52ee579e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -366,6 +366,17 @@ struct smu_umd_pstate_table {
 	struct pstates_clk_freq		dclk_pstate;
 };
 
+struct cmn2asic_msg_mapping {
+	int	valid_mapping;
+	int	map_to;
+	int	valid_in_vf;
+};
+
+struct cmn2asic_mapping {
+	int	valid_mapping;
+	int	map_to;
+};
+
 #define WORKLOAD_POLICY_MAX 7
 struct smu_context
 {
@@ -373,6 +384,12 @@ struct smu_context
 	struct amdgpu_irq_src		irq_source;
 
 	const struct pptable_funcs	*ppt_funcs;
+	const struct cmn2asic_msg_mapping	*message_map;
+	const struct cmn2asic_mapping	*clock_map;
+	const struct cmn2asic_mapping	*feature_map;
+	const struct cmn2asic_mapping	*table_map;
+	const struct cmn2asic_mapping	*pwr_src_map;
+	const struct cmn2asic_mapping	*workload_map;
 	struct mutex			mutex;
 	struct mutex			sensor_lock;
 	struct mutex			metrics_lock;
@@ -601,6 +618,39 @@ typedef enum {
 	METRICS_CURR_FANSPEED,
 } MetricsMember_t;
 
+enum smu_cmn2asic_mapping_type {
+	CMN2ASIC_MAPPING_MSG,
+	CMN2ASIC_MAPPING_CLK,
+	CMN2ASIC_MAPPING_FEATURE,
+	CMN2ASIC_MAPPING_TABLE,
+	CMN2ASIC_MAPPING_PWR,
+	CMN2ASIC_MAPPING_WORKLOAD,
+};
+
+#define MSG_MAP(msg, index, valid_in_vf) \
+	[SMU_MSG_##msg] = {1, (index), (valid_in_vf)}
+
+#define CLK_MAP(clk, index) \
+	[SMU_##clk] = {1, (index)}
+
+#define FEA_MAP(fea) \
+	[SMU_FEATURE_##fea##_BIT] = {1, FEATURE_##fea##_BIT}
+
+#define TAB_MAP(tab) \
+	[SMU_TABLE_##tab] = {1, TABLE_##tab}
+
+#define TAB_MAP_VALID(tab) \
+	[SMU_TABLE_##tab] = {1, TABLE_##tab}
+
+#define TAB_MAP_INVALID(tab) \
+	[SMU_TABLE_##tab] = {0, TABLE_##tab}
+
+#define PWR_MAP(tab) \
+	[SMU_POWER_SOURCE_##tab] = {1, POWER_SOURCE_##tab}
+
+#define WORKLOAD_MAP(profile, workload) \
+	[profile] = {1, (workload)}
+
 int smu_load_microcode(struct smu_context *smu);
 
 int smu_check_fw_status(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 8a4053d8eb8c..739f4cd83b91 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -51,21 +51,6 @@
 #define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 2
 
-#define CLK_MAP(clk, index) \
-	[SMU_##clk] = {1, (index)}
-
-#define FEA_MAP(fea) \
-	[SMU_FEATURE_##fea##_BIT] = {1, FEATURE_##fea##_BIT}
-
-#define TAB_MAP(tab) \
-	[SMU_TABLE_##tab] = {1, TABLE_##tab}
-
-#define PWR_MAP(tab) \
-	[SMU_POWER_SOURCE_##tab] = {1, POWER_SOURCE_##tab}
-
-#define WORKLOAD_MAP(profile, workload) \
-	[profile] = {1, (workload)}
-
 #define CTF_OFFSET_EDGE			5
 #define CTF_OFFSET_HOTSPOT		5
 #define CTF_OFFSET_MEM			5
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index ff717b800086..ad2618dde837 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -41,6 +41,7 @@
 #include "thm/thm_11_0_2_sh_mask.h"
 
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
+#include "smu_cmn.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -63,10 +64,7 @@
 	FEATURE_MASK(FEATURE_DPM_LINK_BIT)	 | \
 	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
 
-#define MSG_MAP(msg, index, valid_in_vf) \
-	[SMU_MSG_##msg] = {1, (index), (valid_in_vf)}
-
-static struct smu_11_0_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
+static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,		1),
 	MSG_MAP(GetDriverIfVersion,		PPSMC_MSG_GetDriverIfVersion,		1),
@@ -137,7 +135,7 @@ static struct smu_11_0_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(GetVoltageByDpmOverdrive,	PPSMC_MSG_GetVoltageByDpmOverdrive,	0),
 };
 
-static struct smu_11_0_cmn2aisc_mapping navi10_clk_map[SMU_CLK_COUNT] = {
+static struct cmn2asic_mapping navi10_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(GFXCLK, PPCLK_GFXCLK),
 	CLK_MAP(SCLK,	PPCLK_GFXCLK),
 	CLK_MAP(SOCCLK, PPCLK_SOCCLK),
@@ -152,7 +150,7 @@ static struct smu_11_0_cmn2aisc_mapping navi10_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(PHYCLK, PPCLK_PHYCLK),
 };
 
-static struct smu_11_0_cmn2aisc_mapping navi10_feature_mask_map[SMU_FEATURE_COUNT] = {
+static struct cmn2asic_mapping navi10_feature_mask_map[SMU_FEATURE_COUNT] = {
 	FEA_MAP(DPM_PREFETCHER),
 	FEA_MAP(DPM_GFXCLK),
 	FEA_MAP(DPM_GFX_PACE),
@@ -198,7 +196,7 @@ static struct smu_11_0_cmn2aisc_mapping navi10_feature_mask_map[SMU_FEATURE_COUN
 	FEA_MAP(APCC_DFLL),
 };
 
-static struct smu_11_0_cmn2aisc_mapping navi10_table_map[SMU_TABLE_COUNT] = {
+static struct cmn2asic_mapping navi10_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(PPTABLE),
 	TAB_MAP(WATERMARKS),
 	TAB_MAP(AVFS),
@@ -213,12 +211,12 @@ static struct smu_11_0_cmn2aisc_mapping navi10_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(PACE),
 };
 
-static struct smu_11_0_cmn2aisc_mapping navi10_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
+static struct cmn2asic_mapping navi10_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
 	PWR_MAP(AC),
 	PWR_MAP(DC),
 };
 
-static struct smu_11_0_cmn2aisc_mapping navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
+static struct cmn2asic_mapping navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,	WORKLOAD_PPLIB_DEFAULT_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,		WORKLOAD_PPLIB_POWER_SAVING_BIT),
@@ -230,6 +228,7 @@ static struct smu_11_0_cmn2aisc_mapping navi10_workload_map[PP_SMC_POWER_PROFILE
 
 static int navi10_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_msg_mapping mapping;
 
 	if (index >= SMU_MSG_MAX_COUNT)
@@ -244,10 +243,13 @@ static int navi10_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 		return -EACCES;
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int navi10_get_smu_clk_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_CLK_COUNT)
@@ -259,10 +261,13 @@ static int navi10_get_smu_clk_index(struct smu_context *smc, uint32_t index)
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int navi10_get_smu_feature_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_FEATURE_COUNT)
@@ -274,10 +279,13 @@ static int navi10_get_smu_feature_index(struct smu_context *smc, uint32_t index)
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int navi10_get_smu_table_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_TABLE_COUNT)
@@ -289,10 +297,13 @@ static int navi10_get_smu_table_index(struct smu_context *smc, uint32_t index)
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int navi10_get_pwr_src_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_POWER_SOURCE_COUNT)
@@ -304,11 +315,14 @@ static int navi10_get_pwr_src_index(struct smu_context *smc, uint32_t index)
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 
 static int navi10_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (profile > PP_SMC_POWER_PROFILE_CUSTOM)
@@ -320,6 +334,8 @@ static int navi10_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_P
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static bool is_asic_secure(struct smu_context *smu)
@@ -917,7 +933,9 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 	MetricsMember_t member_type;
 	int clk_id = 0;
 
-	clk_id = smu_clk_get_index(smu, clk_type);
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
@@ -955,7 +973,9 @@ static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu
 	DpmDescriptor_t *dpm_desc = NULL;
 	uint32_t clk_index = 0;
 
-	clk_index = smu_clk_get_index(smu, clk_type);
+	clk_index = smu_cmn_to_asic_specific_index(smu,
+						   CMN2ASIC_MAPPING_CLK,
+						   clk_type);
 	dpm_desc = &pptable->DpmDescriptor[clk_index];
 
 	/* 0 - Fine grained DPM, 1 - Discrete DPM */
@@ -1483,7 +1503,9 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
 		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-		workload_type = smu_workload_get_type(smu, i);
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       i);
 		if (workload_type < 0)
 			return -EINVAL;
 
@@ -1612,7 +1634,9 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_workload_get_type(smu, smu->power_profile_mode);
+	workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
 	smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
@@ -2426,4 +2450,10 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 void navi10_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &navi10_ppt_funcs;
+	smu->message_map = navi10_message_map;
+	smu->clock_map = navi10_clk_map;
+	smu->feature_map = navi10_feature_mask_map;
+	smu->table_map = navi10_table_map;
+	smu->pwr_src_map = navi10_pwr_src_map;
+	smu->workload_map = navi10_workload_map;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 19bd8b630414..cff855d2997f 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -28,6 +28,7 @@
 #include "smu12_driver_if.h"
 #include "smu_v12_0.h"
 #include "renoir_ppt.h"
+#include "smu_cmn.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -39,83 +40,71 @@
 #undef pr_info
 #undef pr_debug
 
-#define CLK_MAP(clk, index) \
-	[SMU_##clk] = {1, (index)}
-
-#define MSG_MAP(msg, index) \
-	[SMU_MSG_##msg] = {1, (index)}
-
-#define TAB_MAP_VALID(tab) \
-	[SMU_TABLE_##tab] = {1, TABLE_##tab}
-
-#define TAB_MAP_INVALID(tab) \
-	[SMU_TABLE_##tab] = {0, TABLE_##tab}
-
-static struct smu_12_0_cmn2aisc_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
-	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage),
-	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion),
-	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion),
-	MSG_MAP(PowerUpGfx,                     PPSMC_MSG_PowerUpGfx),
-	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_EnableGfxOff),
-	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisableGfxOff),
-	MSG_MAP(PowerDownIspByTile,             PPSMC_MSG_PowerDownIspByTile),
-	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile),
-	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn),
-	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn),
-	MSG_MAP(PowerDownSdma,                  PPSMC_MSG_PowerDownSdma),
-	MSG_MAP(PowerUpSdma,                    PPSMC_MSG_PowerUpSdma),
-	MSG_MAP(SetHardMinIspclkByFreq,         PPSMC_MSG_SetHardMinIspclkByFreq),
-	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn),
-	MSG_MAP(Spare1,                         PPSMC_MSG_spare1),
-	MSG_MAP(Spare2,                         PPSMC_MSG_spare2),
-	MSG_MAP(SetAllowFclkSwitch,             PPSMC_MSG_SetAllowFclkSwitch),
-	MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq),
-	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify),
-	MSG_MAP(SetCustomPolicy,                PPSMC_MSG_SetCustomPolicy),
-	MSG_MAP(SetVideoFps,                    PPSMC_MSG_SetVideoFps),
-	MSG_MAP(NumOfDisplays,                  PPSMC_MSG_SetDisplayCount),
-	MSG_MAP(QueryPowerLimit,                PPSMC_MSG_QueryPowerLimit),
-	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh),
-	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow),
-	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram),
-	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu),
-	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset),
-	MSG_MAP(SetGfxclkOverdriveByFreqVid,    PPSMC_MSG_SetGfxclkOverdriveByFreqVid),
-	MSG_MAP(SetHardMinDcfclkByFreq,         PPSMC_MSG_SetHardMinDcfclkByFreq),
-	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq),
-	MSG_MAP(ControlIgpuATS,                 PPSMC_MSG_ControlIgpuATS),
-	MSG_MAP(SetMinVideoFclkFreq,            PPSMC_MSG_SetMinVideoFclkFreq),
-	MSG_MAP(SetMinDeepSleepDcfclk,          PPSMC_MSG_SetMinDeepSleepDcfclk),
-	MSG_MAP(ForcePowerDownGfx,              PPSMC_MSG_ForcePowerDownGfx),
-	MSG_MAP(SetPhyclkVoltageByFreq,         PPSMC_MSG_SetPhyclkVoltageByFreq),
-	MSG_MAP(SetDppclkVoltageByFreq,         PPSMC_MSG_SetDppclkVoltageByFreq),
-	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn),
-	MSG_MAP(EnablePostCode,                 PPSMC_MSG_EnablePostCode),
-	MSG_MAP(GetGfxclkFrequency,             PPSMC_MSG_GetGfxclkFrequency),
-	MSG_MAP(GetFclkFrequency,               PPSMC_MSG_GetFclkFrequency),
-	MSG_MAP(GetMinGfxclkFrequency,          PPSMC_MSG_GetMinGfxclkFrequency),
-	MSG_MAP(GetMaxGfxclkFrequency,          PPSMC_MSG_GetMaxGfxclkFrequency),
-	MSG_MAP(SoftReset,                      PPSMC_MSG_SoftReset),
-	MSG_MAP(SetGfxCGPG,                     PPSMC_MSG_SetGfxCGPG),
-	MSG_MAP(SetSoftMaxGfxClk,               PPSMC_MSG_SetSoftMaxGfxClk),
-	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk),
-	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq),
-	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq),
-	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn),
-	MSG_MAP(PowerGateMmHub,                 PPSMC_MSG_PowerGateMmHub),
-	MSG_MAP(UpdatePmeRestore,               PPSMC_MSG_UpdatePmeRestore),
-	MSG_MAP(GpuChangeState,                 PPSMC_MSG_GpuChangeState),
-	MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage),
-	MSG_MAP(ForceGfxContentSave,            PPSMC_MSG_ForceGfxContentSave),
-	MSG_MAP(EnableTmdp48MHzRefclkPwrDown,   PPSMC_MSG_EnableTmdp48MHzRefclkPwrDown),
-	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg),
-	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg),
-	MSG_MAP(PowerGateAtHub,                 PPSMC_MSG_PowerGateAtHub),
-	MSG_MAP(SetSoftMinJpeg,                 PPSMC_MSG_SetSoftMinJpeg),
-	MSG_MAP(SetHardMinFclkByFreq,           PPSMC_MSG_SetHardMinFclkByFreq),
+static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                  1),
+	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,                1),
+	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,           1),
+	MSG_MAP(PowerUpGfx,                     PPSMC_MSG_PowerUpGfx,                   1),
+	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_EnableGfxOff,                 1),
+	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisableGfxOff,                1),
+	MSG_MAP(PowerDownIspByTile,             PPSMC_MSG_PowerDownIspByTile,           1),
+	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,             1),
+	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,                 1),
+	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,                   1),
+	MSG_MAP(PowerDownSdma,                  PPSMC_MSG_PowerDownSdma,                1),
+	MSG_MAP(PowerUpSdma,                    PPSMC_MSG_PowerUpSdma,                  1),
+	MSG_MAP(SetHardMinIspclkByFreq,         PPSMC_MSG_SetHardMinIspclkByFreq,       1),
+	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
+	MSG_MAP(Spare1,                         PPSMC_MSG_spare1,                       1),
+	MSG_MAP(Spare2,                         PPSMC_MSG_spare2,                       1),
+	MSG_MAP(SetAllowFclkSwitch,             PPSMC_MSG_SetAllowFclkSwitch,           1),
+	MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
+	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
+	MSG_MAP(SetCustomPolicy,                PPSMC_MSG_SetCustomPolicy,              1),
+	MSG_MAP(SetVideoFps,                    PPSMC_MSG_SetVideoFps,                  1),
+	MSG_MAP(NumOfDisplays,                  PPSMC_MSG_SetDisplayCount,              1),
+	MSG_MAP(QueryPowerLimit,                PPSMC_MSG_QueryPowerLimit,              1),
+	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,        1),
+	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,         1),
+	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,        1),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,        1),
+	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,         1),
+	MSG_MAP(SetGfxclkOverdriveByFreqVid,    PPSMC_MSG_SetGfxclkOverdriveByFreqVid,  1),
+	MSG_MAP(SetHardMinDcfclkByFreq,         PPSMC_MSG_SetHardMinDcfclkByFreq,       1),
+	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,       1),
+	MSG_MAP(ControlIgpuATS,                 PPSMC_MSG_ControlIgpuATS,               1),
+	MSG_MAP(SetMinVideoFclkFreq,            PPSMC_MSG_SetMinVideoFclkFreq,          1),
+	MSG_MAP(SetMinDeepSleepDcfclk,          PPSMC_MSG_SetMinDeepSleepDcfclk,        1),
+	MSG_MAP(ForcePowerDownGfx,              PPSMC_MSG_ForcePowerDownGfx,            1),
+	MSG_MAP(SetPhyclkVoltageByFreq,         PPSMC_MSG_SetPhyclkVoltageByFreq,       1),
+	MSG_MAP(SetDppclkVoltageByFreq,         PPSMC_MSG_SetDppclkVoltageByFreq,       1),
+	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,                1),
+	MSG_MAP(EnablePostCode,                 PPSMC_MSG_EnablePostCode,               1),
+	MSG_MAP(GetGfxclkFrequency,             PPSMC_MSG_GetGfxclkFrequency,           1),
+	MSG_MAP(GetFclkFrequency,               PPSMC_MSG_GetFclkFrequency,             1),
+	MSG_MAP(GetMinGfxclkFrequency,          PPSMC_MSG_GetMinGfxclkFrequency,        1),
+	MSG_MAP(GetMaxGfxclkFrequency,          PPSMC_MSG_GetMaxGfxclkFrequency,        1),
+	MSG_MAP(SoftReset,                      PPSMC_MSG_SoftReset,                    1),
+	MSG_MAP(SetGfxCGPG,                     PPSMC_MSG_SetGfxCGPG,                   1),
+	MSG_MAP(SetSoftMaxGfxClk,               PPSMC_MSG_SetSoftMaxGfxClk,             1),
+	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk,             1),
+	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,       1),
+	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,         1),
+	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,                1),
+	MSG_MAP(PowerGateMmHub,                 PPSMC_MSG_PowerGateMmHub,               1),
+	MSG_MAP(UpdatePmeRestore,               PPSMC_MSG_UpdatePmeRestore,             1),
+	MSG_MAP(GpuChangeState,                 PPSMC_MSG_GpuChangeState,               1),
+	MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage,      1),
+	MSG_MAP(ForceGfxContentSave,            PPSMC_MSG_ForceGfxContentSave,          1),
+	MSG_MAP(EnableTmdp48MHzRefclkPwrDown,   PPSMC_MSG_EnableTmdp48MHzRefclkPwrDown, 1),
+	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,                1),
+	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,                  1),
+	MSG_MAP(PowerGateAtHub,                 PPSMC_MSG_PowerGateAtHub,               1),
+	MSG_MAP(SetSoftMinJpeg,                 PPSMC_MSG_SetSoftMinJpeg,               1),
+	MSG_MAP(SetHardMinFclkByFreq,           PPSMC_MSG_SetHardMinFclkByFreq,         1),
 };
 
-static struct smu_12_0_cmn2aisc_mapping renoir_clk_map[SMU_CLK_COUNT] = {
+static struct cmn2asic_mapping renoir_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(GFXCLK, CLOCK_GFXCLK),
 	CLK_MAP(SCLK,	CLOCK_GFXCLK),
 	CLK_MAP(SOCCLK, CLOCK_SOCCLK),
@@ -123,15 +112,24 @@ static struct smu_12_0_cmn2aisc_mapping renoir_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(MCLK, CLOCK_FCLK),
 };
 
-static struct smu_12_0_cmn2aisc_mapping renoir_table_map[SMU_TABLE_COUNT] = {
+static struct cmn2asic_mapping renoir_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP_VALID(WATERMARKS),
 	TAB_MAP_INVALID(CUSTOM_DPM),
 	TAB_MAP_VALID(DPMCLOCKS),
 	TAB_MAP_VALID(SMU_METRICS),
 };
 
+static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
+};
+
 static int renoir_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_12_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_MSG_MAX_COUNT)
@@ -142,10 +140,13 @@ static int renoir_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 		return -EINVAL;
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int renoir_get_smu_clk_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_12_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_CLK_COUNT)
@@ -157,10 +158,13 @@ static int renoir_get_smu_clk_index(struct smu_context *smc, uint32_t index)
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int renoir_get_smu_table_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_12_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_TABLE_COUNT)
@@ -171,6 +175,8 @@ static int renoir_get_smu_table_index(struct smu_context *smc, uint32_t index)
 		return -EINVAL;
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int renoir_get_metrics_table(struct smu_context *smu,
@@ -542,7 +548,9 @@ static int renoir_get_current_clk_freq_by_table(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	clk_id = smu_clk_get_index(smu, clk_type);
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
@@ -792,7 +800,9 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_workload_get_type(smu, profile_mode);
+	workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       profile_mode);
 	if (workload_type < 0) {
 		/*
 		 * TODO: If some case need switch to powersave/default power mode
@@ -970,7 +980,9 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
 		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
 		 * Not all profile modes are supported on arcturus.
 		 */
-		workload_type = smu_workload_get_type(smu, i);
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       i);
 		if (workload_type < 0)
 			continue;
 
@@ -1073,6 +1085,10 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 void renoir_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &renoir_ppt_funcs;
+	smu->message_map = renoir_message_map;
+	smu->clock_map = renoir_clk_map;
+	smu->table_map = renoir_table_map;
+	smu->workload_map = renoir_workload_map;
 	smu->smc_driver_if_version = SMU12_DRIVER_IF_VERSION;
 	smu->is_apu = true;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 8a25921d28a9..39712574e656 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -41,6 +41,7 @@
 #include "thm/thm_11_0_2_sh_mask.h"
 
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
+#include "smu_cmn.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -62,63 +63,60 @@
 	FEATURE_MASK(FEATURE_DPM_FCLK_BIT)	 | \
 	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
 
-#define MSG_MAP(msg, index) \
-	[SMU_MSG_##msg] = {1, (index)}
-
-static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT] = {
-	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage),
-	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion),
-	MSG_MAP(GetDriverIfVersion,		PPSMC_MSG_GetDriverIfVersion),
-	MSG_MAP(SetAllowedFeaturesMaskLow,	PPSMC_MSG_SetAllowedFeaturesMaskLow),
-	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh),
-	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures),
-	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures),
-	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow),
-	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh),
-	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow),
-	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh),
-	MSG_MAP(GetEnabledSmuFeaturesLow,       PPSMC_MSG_GetRunningSmuFeaturesLow),
-	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetRunningSmuFeaturesHigh),
-	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask),
-	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit),
-	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh),
-	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow),
-	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh),
-	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow),
-	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram),
-	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu),
-	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable),
-	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco),
-	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq),
-	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq),
-	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq),
-	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq),
-	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq),
-	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq),
-	MSG_MAP(GetDpmFreqByIndex,		PPSMC_MSG_GetDpmFreqByIndex),
-	MSG_MAP(SetGeminiMode,			PPSMC_MSG_SetGeminiMode),
-	MSG_MAP(SetGeminiApertureHigh,		PPSMC_MSG_SetGeminiApertureHigh),
-	MSG_MAP(SetGeminiApertureLow,		PPSMC_MSG_SetGeminiApertureLow),
-	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters),
-	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt),
-	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource),
-	MSG_MAP(SetUclkFastSwitch,		PPSMC_MSG_SetUclkFastSwitch),
-	MSG_MAP(SetVideoFps,			PPSMC_MSG_SetVideoFps),
-	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload),
-	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff),
-	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff),
-	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit),
-	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq),
-	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco),
-	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn),
-	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn),
-	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg),
-	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg),
-	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME),
-	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3),
+static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
+	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
+	MSG_MAP(GetDriverIfVersion,		PPSMC_MSG_GetDriverIfVersion,          1),
+	MSG_MAP(SetAllowedFeaturesMaskLow,	PPSMC_MSG_SetAllowedFeaturesMaskLow,   1),
+	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh,  1),
+	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures,        1),
+	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures,       1),
+	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow,        1),
+	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh,       1),
+	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow,       1),
+	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh,      1),
+	MSG_MAP(GetEnabledSmuFeaturesLow,       PPSMC_MSG_GetRunningSmuFeaturesLow,    1),
+	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
+	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,             1),
+	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,                 1),
+	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       1),
+	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        1),
+	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh,        1),
+	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow,         1),
+	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       1),
+	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,       1),
+	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           1),
+	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   1),
+	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
+	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
+	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
+	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,            1),
+	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,               1),
+	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq,               1),
+	MSG_MAP(GetDpmFreqByIndex,		PPSMC_MSG_GetDpmFreqByIndex,           1),
+	MSG_MAP(SetGeminiMode,			PPSMC_MSG_SetGeminiMode,               1),
+	MSG_MAP(SetGeminiApertureHigh,		PPSMC_MSG_SetGeminiApertureHigh,       1),
+	MSG_MAP(SetGeminiApertureLow,		PPSMC_MSG_SetGeminiApertureLow,        1),
+	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,      1),
+	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       1),
+	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           1),
+	MSG_MAP(SetUclkFastSwitch,		PPSMC_MSG_SetUclkFastSwitch,           1),
+	MSG_MAP(SetVideoFps,			PPSMC_MSG_SetVideoFps,                 1),
+	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         1),
+	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 1),
+	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              1),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 1),
+	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
+	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    1),
+	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,                  1),
+	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,                1),
+	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,                 1),
+	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               1),
+	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,              1),
+	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       1),
 };
 
-static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
+static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(GFXCLK,		PPCLK_GFXCLK),
 	CLK_MAP(SCLK,		PPCLK_GFXCLK),
 	CLK_MAP(SOCCLK,		PPCLK_SOCCLK),
@@ -135,7 +133,7 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] =
 	CLK_MAP(PHYCLK,		PPCLK_PHYCLK),
 };
 
-static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_feature_mask_map[SMU_FEATURE_COUNT] = {
+static struct cmn2asic_mapping sienna_cichlid_feature_mask_map[SMU_FEATURE_COUNT] = {
 	FEA_MAP(DPM_PREFETCHER),
 	FEA_MAP(DPM_GFXCLK),
 	FEA_MAP(DPM_GFX_GPO),
@@ -178,7 +176,7 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_feature_mask_map[SMU_FEAT
 	FEA_MAP(APCC_DFLL),
 };
 
-static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_table_map[SMU_TABLE_COUNT] = {
+static struct cmn2asic_mapping sienna_cichlid_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(PPTABLE),
 	TAB_MAP(WATERMARKS),
 	TAB_MAP(AVFS_PSM_DEBUG),
@@ -192,12 +190,12 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_table_map[SMU_TABLE_COUNT
 	TAB_MAP(PACE),
 };
 
-static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
+static struct cmn2asic_mapping sienna_cichlid_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
 	PWR_MAP(AC),
 	PWR_MAP(DC),
 };
 
-static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
+static struct cmn2asic_mapping sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,	WORKLOAD_PPLIB_DEFAULT_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,		WORKLOAD_PPLIB_POWER_SAVING_BIT),
@@ -209,6 +207,7 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_workload_map[PP_SMC_POWER
 
 static int sienna_cichlid_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_MSG_MAX_COUNT)
@@ -220,10 +219,13 @@ static int sienna_cichlid_get_smu_msg_index(struct smu_context *smc, uint32_t in
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int sienna_cichlid_get_smu_clk_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_CLK_COUNT)
@@ -235,10 +237,13 @@ static int sienna_cichlid_get_smu_clk_index(struct smu_context *smc, uint32_t in
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int sienna_cichlid_get_smu_feature_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_FEATURE_COUNT)
@@ -250,10 +255,13 @@ static int sienna_cichlid_get_smu_feature_index(struct smu_context *smc, uint32_
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int sienna_cichlid_get_smu_table_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_TABLE_COUNT)
@@ -265,10 +273,13 @@ static int sienna_cichlid_get_smu_table_index(struct smu_context *smc, uint32_t
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int sienna_cichlid_get_pwr_src_index(struct smu_context *smc, uint32_t index)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (index >= SMU_POWER_SOURCE_COUNT)
@@ -280,10 +291,13 @@ static int sienna_cichlid_get_pwr_src_index(struct smu_context *smc, uint32_t in
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int sienna_cichlid_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile)
 {
+#if 0
 	struct smu_11_0_cmn2aisc_mapping mapping;
 
 	if (profile > PP_SMC_POWER_PROFILE_CUSTOM)
@@ -295,6 +309,8 @@ static int sienna_cichlid_get_workload_type(struct smu_context *smu, enum PP_SMC
 	}
 
 	return mapping.map_to;
+#endif
+	return 0;
 }
 
 static int
@@ -885,7 +901,9 @@ static int sienna_cichlid_get_current_clk_freq_by_table(struct smu_context *smu,
 	MetricsMember_t member_type;
 	int clk_id = 0;
 
-	clk_id = smu_clk_get_index(smu, clk_type);
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
@@ -933,7 +951,9 @@ static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu,
 	DpmDescriptor_t *dpm_desc = NULL;
 	uint32_t clk_index = 0;
 
-	clk_index = smu_clk_get_index(smu, clk_type);
+	clk_index = smu_cmn_to_asic_specific_index(smu,
+						   CMN2ASIC_MAPPING_CLK,
+						   clk_type);
 	dpm_desc = &pptable->DpmDescriptor[clk_index];
 
 	/* 0 - Fine grained DPM, 1 - Discrete DPM */
@@ -1272,7 +1292,9 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
 		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-		workload_type = smu_workload_get_type(smu, i);
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       i);
 		if (workload_type < 0)
 			return -EINVAL;
 
@@ -1401,7 +1423,9 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	}
 
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_workload_get_type(smu, smu->power_profile_mode);
+	workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
 	smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
@@ -2536,4 +2560,10 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &sienna_cichlid_ppt_funcs;
+	smu->message_map = sienna_cichlid_message_map;
+	smu->clock_map = sienna_cichlid_clk_map;
+	smu->feature_map = sienna_cichlid_feature_mask_map;
+	smu->table_map = sienna_cichlid_table_map;
+	smu->pwr_src_map = sienna_cichlid_pwr_src_map;
+	smu->workload_map = sienna_cichlid_workload_map;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
new file mode 100644
index 000000000000..5a76b6b1ac84
--- /dev/null
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_cmn.h"
+
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+int smu_cmn_to_asic_specific_index(struct smu_context *smu,
+				   enum smu_cmn2asic_mapping_type type,
+				   uint32_t index)
+{
+	struct cmn2asic_msg_mapping msg_mapping;
+	struct cmn2asic_mapping mapping;
+
+	switch (type) {
+	case CMN2ASIC_MAPPING_MSG:
+		if (index > SMU_MSG_MAX_COUNT ||
+		    !smu->message_map)
+			return -EINVAL;
+
+		msg_mapping = smu->message_map[index];
+		if (!msg_mapping.valid_mapping)
+			return -EINVAL;
+
+		if (amdgpu_sriov_vf(smu->adev) &&
+		    !msg_mapping.valid_in_vf)
+			return -EACCES;
+
+		return msg_mapping.map_to;
+
+	case CMN2ASIC_MAPPING_CLK:
+		if (index > SMU_CLK_COUNT ||
+		    !smu->clock_map)
+			return -EINVAL;
+
+		mapping = smu->clock_map[index];
+		if (!mapping.valid_mapping)
+			return -EINVAL;
+
+		return mapping.map_to;
+
+	case CMN2ASIC_MAPPING_FEATURE:
+		if (index > SMU_FEATURE_COUNT ||
+		    !smu->feature_map)
+			return -EINVAL;
+
+		mapping = smu->feature_map[index];
+		if (!mapping.valid_mapping)
+			return -EINVAL;
+
+		return mapping.map_to;
+
+	case CMN2ASIC_MAPPING_TABLE:
+		if (index > SMU_TABLE_COUNT ||
+		    !smu->table_map)
+			return -EINVAL;
+
+		mapping = smu->table_map[index];
+		if (!mapping.valid_mapping)
+			return -EINVAL;
+
+		return mapping.map_to;
+
+	case CMN2ASIC_MAPPING_PWR:
+		if (index > SMU_POWER_SOURCE_COUNT ||
+		    !smu->pwr_src_map)
+			return -EINVAL;
+
+		mapping = smu->pwr_src_map[index];
+		if (!mapping.valid_mapping)
+			return -EINVAL;
+
+		return mapping.map_to;
+
+	case CMN2ASIC_MAPPING_WORKLOAD:
+		if (index > PP_SMC_POWER_PROFILE_CUSTOM ||
+		    !smu->workload_map)
+			return -EINVAL;
+
+		mapping = smu->workload_map[index];
+		if (!mapping.valid_mapping)
+			return -EINVAL;
+
+		return mapping.map_to;
+
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
new file mode 100644
index 000000000000..fc70645196cc
--- /dev/null
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __SMU_CMN_H__
+#define __SMU_CMN_H__
+
+#include "amdgpu_smu.h"
+
+int smu_cmn_to_asic_specific_index(struct smu_context *smu,
+				   enum smu_cmn2asic_mapping_type type,
+				   uint32_t index);
+
+#endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 416aa536a57e..2f3b318e9629 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -36,6 +36,7 @@
 #include "soc15_common.h"
 #include "atom.h"
 #include "amdgpu_ras.h"
+#include "smu_cmn.h"
 
 #include "asic_reg/thm/thm_11_0_2_offset.h"
 #include "asic_reg/thm/thm_11_0_2_sh_mask.h"
@@ -107,7 +108,9 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
 
-	index = smu_msg_get_index(smu, msg);
+	index = smu_cmn_to_asic_specific_index(smu,
+					       CMN2ASIC_MAPPING_MSG,
+					       msg);
 	if (index < 0)
 		return index == -EACCES ? 0 : index;
 
@@ -947,11 +950,13 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 	int ret = 0;
 	int clk_id;
 
-	if ((smu_msg_get_index(smu, SMU_MSG_GetDcModeMaxDpmFreq) < 0) ||
-	    (smu_msg_get_index(smu, SMU_MSG_GetMaxDpmFreq) < 0))
+	if ((smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG, SMU_MSG_GetDcModeMaxDpmFreq) < 0) ||
+	    (smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG, SMU_MSG_GetMaxDpmFreq) < 0))
 		return 0;
 
-	clk_id = smu_clk_get_index(smu, clock_select);
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clock_select);
 	if (clk_id < 0)
 		return -EINVAL;
 
@@ -1062,7 +1067,8 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 	if (!smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
 		return -EINVAL;
 
-	power_src = smu_power_get_index(smu,
+	power_src = smu_cmn_to_asic_specific_index(smu,
+					CMN2ASIC_MAPPING_PWR,
 					smu->adev->pm.ac_power ?
 					SMU_POWER_SOURCE_AC :
 					SMU_POWER_SOURCE_DC);
@@ -1718,7 +1724,9 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 		return 0;
 	}
 
-	clk_id = smu_clk_get_index(smu, clk_type);
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
 	if (clk_id < 0) {
 		ret = -EINVAL;
 		goto failed;
@@ -1750,7 +1758,9 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
-	clk_id = smu_clk_get_index(smu, clk_type);
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
@@ -1794,7 +1804,9 @@ int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
 	if (!smu_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
-	clk_id = smu_clk_get_index(smu, clk_type);
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
@@ -1923,7 +1935,9 @@ int smu_v11_0_set_power_source(struct smu_context *smu,
 {
 	int pwr_source;
 
-	pwr_source = smu_power_get_index(smu, (uint32_t)power_src);
+	pwr_source = smu_cmn_to_asic_specific_index(smu,
+						    CMN2ASIC_MAPPING_PWR,
+						    (uint32_t)power_src);
 	if (pwr_source < 0)
 		return -EINVAL;
 
@@ -1947,7 +1961,9 @@ int smu_v11_0_get_dpm_freq_by_index(struct smu_context *smu,
 	if (!smu_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
-	clk_id = smu_clk_get_index(smu, clk_type);
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 4e1b11d07438..05e3870c13d7 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -29,6 +29,7 @@
 #include "smu_v12_0.h"
 #include "soc15_common.h"
 #include "atom.h"
+#include "smu_cmn.h"
 
 #include "asic_reg/mp/mp_12_0_0_offset.h"
 #include "asic_reg/mp/mp_12_0_0_sh_mask.h"
@@ -95,7 +96,9 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
 
-	index = smu_msg_get_index(smu, msg);
+	index = smu_cmn_to_asic_specific_index(smu,
+					       CMN2ASIC_MAPPING_MSG,
+					       msg);
 	if (index < 0)
 		return index;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
