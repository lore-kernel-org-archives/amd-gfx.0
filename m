Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AABDC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D31D64F10
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D31D64F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D852F6E87A;
	Thu, 18 Mar 2021 04:06:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F856E87A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR+uob1V529ePnMNzYiy7vGCfpIQM5yoqZTfK7MvTvWht3Tn6DCrzWJ+pKams3pFlS7iV8XzcXmg2giXjhYW+OAlyEUbQqfD1o9/+49v8dGs2oeEXdm8SvXw/ItuDSvc3bOU6GF31Y4Rf7oUWoIoIN9MdhXEGHCYytBhTVej8ZhUc8jgzlgaiut0rrMEAOVz9e3Sk62st2Wb9x5bOs+bG7AhQHs7F2H/VtGOH3+euncDRDQL0i7csqx/4hDFGT0De07uC6FVuJ4FVxZWgBl8C+lkZ3hiE7ttgrRO7+O8BJk2Emo2Iw0ib7S0VPqqsypvc07JxXrGx1Ux4P2slWPj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLVg7sNVBAndf5s1SKHBjaHtROhH43NaLxloBhntct4=;
 b=lCbGHWI5+71yTkVEgjDoFobfgdduBGJKlElwSu2J2sx7/vcsZzn/ZLFNTEjLdYrn+SYG56ahtFf0hFbrfnNntbSTlJkQSiuFGt/2EoSbnLUm8hsYm36OWuWNLOEtJzmcT5jevfpqgycN0x6/mke9owYx7whHETuy7/RZLiT3JcT97u466con4eguz4M7wjeSTQSEBd1RDdkG8ADY+2Ckfq73xq/xxcEVokg/x38LkbMdriOYZOdTDARe/P8Q/9ONcwhOUDocL+6kqLMSPz54EEkFGwNXudZzDN30+Aa9tWSkVhzBTNwPPghlrczpNUxvNlzShKJGalQNx6a8e5cZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLVg7sNVBAndf5s1SKHBjaHtROhH43NaLxloBhntct4=;
 b=IlaLHUECqe4ZSyuCRXxSc5U22sXcT8wsNZSGV9nBp9ygD4sgbmawLDHmKxp8k/GaBGIygdWxflDTMaTgQhpcZavjT2DPHtvgNVucBgS8Mjcc+bDASAf24//tMGpAmkyiJ9DTJRVWsVz+vA8IA8/h+rWMx87Ipnv5VDHtLhW9FrE=
Received: from DM5PR15CA0070.namprd15.prod.outlook.com (2603:10b6:3:ae::32) by
 SN1PR12MB2461.namprd12.prod.outlook.com (2603:10b6:802:27::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Thu, 18 Mar 2021 04:06:39 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::94) by DM5PR15CA0070.outlook.office365.com
 (2603:10b6:3:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 04:06:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 17 Mar
 2021 23:06:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 17 Mar
 2021 23:06:37 -0500
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Wed, 17 Mar 2021 23:06:37 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: bug fix for baco reset
Date: Thu, 18 Mar 2021 12:06:34 +0800
Message-ID: <20210318040634.2848-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c7e363d-3835-4d0d-e01f-08d8e9c33ad0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2461:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2461E712A403AEFDE35520088E699@SN1PR12MB2461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttdb6+PjGHnlj67Lkd6YrzhZOt2EAJbBtzos4IrwzWV0PbG6CNpmNCKt38rPAe+lH1tZI084R63lUXZh0/+2kHJ0TFQmHhOo/tPS+g8jl8bXZM15Q1zlJVoAS9b4sfJhb8s942KiQzlIqVlD6a4uOUQngDYDSGCnE3bbdYEnQl2yKQo3y/9diD+se5yj7UK9MOxhan+mHzdb50sB18g9/njBs7wrtNtXoqMQThrPWUORyLdgEKvP16+vwAlXKAHxrh0A5XbeyB85W/bxI5F3x3reKCoX2S1Qh8Cd/hb+OHYeMpuQFgqbjw0i6xoZgWbZjvE7wMvHLXgWlPMxaBuH//dQm4ZGAh8Yt6mzK0reWP0D0weuqAiKat7Uy4m+3VH5kb76771ZSqkmdCpde+YAjKl++5PIdzCplfIhD0fJhirzSW6ez22ktTkE4qOQGZ9sUvcu6+In4+l7P75Js+J6sjdDsbaUT9/J/qL221naLf0AKqWRHWasgosM3TQCBhmLFuIIGXdkErZZVj4dHDRPp3arzFXK3EEOVcOdRVS2OF5SKhs6zolKVkmvXFmi0aAfSYLlIvpeSiZkQ9bJ6I77R21j+A6vGYRVlW5HiUZrdqdT5JpzIoqhFv2tmYPDsdMNR280lVDUzZfBSaP+/o8pkpnTGoHMFeoBddWITAk09v0mgiCJPWNvD0NNW1A3aaVU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(36840700001)(26005)(82310400003)(2616005)(336012)(81166007)(36860700001)(82740400003)(356005)(83380400001)(6916009)(44832011)(316002)(4326008)(36756003)(2906002)(426003)(478600001)(47076005)(5660300002)(86362001)(70206006)(8676002)(8936002)(186003)(7696005)(6666004)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:06:38.6567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7e363d-3835-4d0d-e01f-08d8e9c33ad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2461
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On vega20, rocm-smi gets the wrong gfx voltage after baco reset.
This can be reproduced as below.
:~$ rocm-smi --showvoltage
GPU[0] : Voltage (mV): 737
:~$ rocm-smi -d0 --gpureset
GPU[0] : GPU reset was successful
:~$ rocm-smi --showvoltage
GPU[0] : Voltage (mV): 1550

Root cause: telemetry is disabled in the asic_init after baco exit.
This fix targets to re-enable telemetry then all the power and voltage
info can be fetched correctly, mp1 firmware also depends on this setting
for dpm arbitration.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega20_baco.c    | 17 +++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_baco.h    |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index 2a28c9df15a0..bb58097a925c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -28,9 +28,16 @@
 #include "vega20_ppsmc.h"
 #include "vega20_baco.h"
 #include "vega20_smumgr.h"
+#include "smuio/smuio_9_0_offset.h"
+#include "smuio/smuio_9_0_sh_mask.h"
 
 #include "amdgpu_ras.h"
 
+#define mmSMUSVI0_TFN 0x2
+#define SMUSVI0_TFN___PLANE0_MASK 0x1
+#define SMUSVI0_TFN___PLANE1_MASK 0x2
+#define mmSMUSVI0_TFN_BASE_IDX 0
+
 static const struct soc15_baco_cmd_entry clean_baco_tbl[] =
 {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_6), 0, 0, 0, 0},
@@ -120,3 +127,13 @@ int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr)
 
 	return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_BacoWorkAroundFlushVDCI, NULL);
 }
+
+void vega20_baco_override_telemetry_parameters(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	uint32_t data = RREG32_SOC15(SMUIO, 0, mmSMUSVI0_TFN);
+
+	data &= (~SMUSVI0_TFN___PLANE0_MASK);
+	data |= SMUSVI0_TFN___PLANE1_MASK;
+	WREG32_SOC15(SMUIO, 0, mmSMUSVI0_TFN, data);
+}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
index f06471e712dc..9ca39569ba0e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
@@ -29,5 +29,5 @@ extern int vega20_baco_get_capability(struct pp_hwmgr *hwmgr, bool *cap);
 extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 extern int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr);
-
+extern void vega20_baco_override_telemetry_parameters(struct pp_hwmgr *hwmgr);
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 213c9c6b4462..12830a8dd923 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -503,6 +503,7 @@ static int vega20_setup_asic_task(struct pp_hwmgr *hwmgr)
 		ret = vega20_baco_apply_vdci_flush_workaround(hwmgr);
 		if (ret)
 			pr_err("Failed to apply vega20 baco workaround!\n");
+		vega20_baco_override_telemetry_parameters(hwmgr);
 	}
 
 	return ret;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
