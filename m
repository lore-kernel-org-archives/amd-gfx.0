Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22E1C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 05:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC4210E9A3;
	Fri,  7 Apr 2023 05:39:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529E010E286
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 05:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNJ0Cm+DQXghFayriKt9MbjvPQvOoFcQ/ODX0t0GKRK9IC7fXT+SudMW4XjgKjz2x/DrWJ4ZzsI2EfcGRzAWQTjnFAgLdc2w1GgTbN/8ZW6pgu4jweazf/+tMkWu8dJZ+dYX4EXUGcVAm5usgBur+pGFchk+XDhHh1uL4buTFceBFlSYSDZgdGJIfRYY7OEzZ2PaGfNFmRKELg89yHFN9ps6mom2dIl19FVAkjqzimBjy/IejGRb9BkfvmLs79kW1FSING7bTUCVs81K+iX3Pr3pdoVuf5pYyTluRRJondTd51pi4GnoFs9Yg6O7GmewRNHtENmv8EnlAKSraBNxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ql1kKurxt8slY0t8UlGlx35Qkoyh8brgjs8rLc5XPJE=;
 b=lvlnybqWdQFvCCwGlyt0qiNNISye4lwQyTR/fJGwKuOan7fcYrrZiq/9BdpmUNz0u1e0LK8Neb0zWjZDT5FbAX3wYIDarx0KeZAya8EXdiQeqxorL6gtM9A0e2pu0Jwogv/87Ebtg7APAEDRTk+TJWjPR0ttThjcLf++8v42cRaPfxX6Oj5MxheO03C7sC6yC7YhL0ru11vugIHOnRCk1DMC++R9JG44+wHwzRwPOGRkfHvtJfJcNeVJP+dnTySRb0Zje0qpJRARpDMjZmDyN9w0uiMyNL2RavJCLEn7yar4jUWLlhhHg5lELc1ERS1rEhcTVgPA1OyFWP6xR7g9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql1kKurxt8slY0t8UlGlx35Qkoyh8brgjs8rLc5XPJE=;
 b=WflGCpzRpt0tyclm1Y0AEDgicTeKec2JTVVFVuJRmnSuMygYRsA0KXW4BXQIpvbvUE97ZQzRQjv9+nwAV23/f72T9j5/BHlcqD7bT5Gn6jFnTHuG9WI2a6U6bNtBBBtz3VygM5DjCYWJBZjY/z2JmpKGDNkIYPUMYUukueWiwBQ=
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Fri, 7 Apr
 2023 05:39:11 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::4b) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37 via Frontend
 Transport; Fri, 7 Apr 2023 05:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.33 via Frontend Transport; Fri, 7 Apr 2023 05:39:10 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 00:39:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 22:38:29 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 7 Apr 2023 00:38:26 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v6 1/2] drm/amd/pm: Add support to check SMT state periodically
Date: Fri, 7 Apr 2023 13:38:21 +0800
Message-ID: <20230407053822.157046-2-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407053822.157046-1-WenYou.Yang@amd.com>
References: <20230407053822.157046-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 1230c6ef-539a-4ff4-1847-08db372a69e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cX0BXqI5TUXuSdYB+taaNvg0WVH/EZmcz7Ga/nCBTdruAGSIakIEmjUhAp7z2tS8VLNOSyXzML0GDS962CYHshVhXRtVqwuIRxVLsnm8EVBUG7zCHoA6LSnfCEEAPI1DbjKvFwuMEBWqAs/EenK87ZPhfRKalUAfvx7OK0DwQEw6w7YH/+/zZbhJoc31vrBc2S2EUOkyN1+538Hs07bc/kieAKClLP3icHUZOQqz8TNAz3Ipn8RjK0mVKrwatmdCdSMglV8rDA4Dv9X2FPZ/2FE8gahIFoPHXS63kS4dMCVlxIgz0btQzxCmJnbKQnGhuAzAjR+vO+HJW5Q76l/6WDUms1TJ7LcfAGj6Yu6ccV1MSF/htJJ1YEh5OX0tXPdriCzRRg2dGVkk/ShNU4ZkZSNxbI5JOQiycHTsgxiY7yNeHtz9WRPB1In3RgVgdnzI1qWQuHTuJ1y0TIKvTOnE0wmWd2zJwuf1XUwawoh0rQyI/mmI2rLPDP/U9R6FG+gOVqny8hSFk2lY2DrmRzBlwEffxtSer7tmtc2w9lW9m51V5xUN2IMKxTTX2umYMhxx4o5TgafNORWCR3DEzc3rmlZI12nscvfIU7yunkx/Gk7KQ3h3yeTXnxup/qi3o4PHc8wV+DnpOQR+dIyiVuKABEq3qVtujxAqr6POhFNY1PHvJLAuDKF7hTlJlhYGbAzQtlvnohkJKLQKYMx4v+/lQx9qmWK+4o7Ka1PgvohGY4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(336012)(356005)(83380400001)(426003)(82740400003)(47076005)(5660300002)(8676002)(70586007)(2906002)(70206006)(110136005)(41300700001)(54906003)(6636002)(4326008)(81166007)(2616005)(8936002)(316002)(36860700001)(478600001)(86362001)(6666004)(1076003)(26005)(36756003)(40460700003)(186003)(40480700001)(7696005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 05:39:10.6789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1230c6ef-539a-4ff4-1847-08db372a69e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, kunliu13@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a timer to poll the SMT state periodically, if the SMT state
is changed, invoke the interface to notify the PMFW.

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  5 +++
 3 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 09469c750a96..fc571c122e87 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -566,6 +566,9 @@ struct smu_context
 
 	struct firmware pptable_firmware;
 
+	bool last_smt_active;
+	struct timer_list smt_timer;
+
 	u32 param_reg;
 	u32 msg_reg;
 	u32 resp_reg;
@@ -1354,6 +1357,11 @@ struct pptable_funcs {
 	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
 	 */
 	int (*init_pptable_microcode)(struct smu_context *smu);
+
+	/**
+	 * @set_cpu_smt_enable: Set the CPU SMT status.
+	 */
+	int (*set_cpu_smt_enable)(struct smu_context *smu, bool smt_enable);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3ecb900e6ecd..81c547a03f97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -26,6 +26,7 @@
 #include "amdgpu_smu.h"
 #include "smu_cmn.h"
 #include "soc15_common.h"
+#include <linux/sched/smt.h>
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -1058,3 +1059,46 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 
 	return snd_driver_loaded;
 }
+
+#define TIME_INTERVAL	200
+
+static int smu_set_cpu_smt_enable(struct smu_context *smu, bool enable)
+{
+	int ret = -EINVAL;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
+		ret = smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
+
+	return ret;
+}
+
+static void smu_smt_timer_callback(struct timer_list *timer)
+{
+	struct smu_context *smu = container_of(timer,
+					       struct smu_context, smt_timer);
+	bool smt_active;
+
+	smt_active = sched_smt_active();
+	if (smt_active != smu->last_smt_active) {
+		if (!smu_set_cpu_smt_enable(smu, smt_active))
+			smu->last_smt_active = smt_active;
+	}
+
+	mod_timer(timer, jiffies + msecs_to_jiffies(TIME_INTERVAL));
+}
+
+void smu_smt_timer_init(struct smu_context *smu)
+{
+	struct timer_list *timer = &smu->smt_timer;
+
+	smu->last_smt_active = sched_smt_active();
+
+	timer_setup(timer, smu_smt_timer_callback, 0);
+
+	mod_timer(timer, jiffies + msecs_to_jiffies(TIME_INTERVAL));
+}
+
+void smu_smt_timer_fini(struct smu_context *smu)
+{
+	del_timer(&smu->smt_timer);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d7cd358a53bd..928dd9e30d83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -127,5 +127,10 @@ static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset)
 
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
 
+void smu_smt_timer_init(struct smu_context *smu);
+
 #endif
+
+void smu_smt_timer_fini(struct smu_context *smu);
+
 #endif
-- 
2.39.2

