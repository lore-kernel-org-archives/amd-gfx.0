Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CD5C76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 12:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9118A10E2F5;
	Thu,  6 Apr 2023 12:45:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6A910E2F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 12:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmERfNw/4xUhSW4uGY/8A0Jzpts83I55pR6ot5LeK77IBUJKPrB8RC46M7sbZcpJ732XZcCQUAcB7z+isk/BHRB2nHV+8kq/OdsrYm388M9GCBJfWpDxo2wkvRyMxDWbtu9ewxcSLbwQJ31VfzYfcPTrCm6Spn5ZM0oJYmbTiRDf8XnA4YFpgX2lz2Ty6ei0FBs5VUX9ZojmUly/y+eARFZsjmT6l87pITOEUPMFnNckGa8QJUNpSKXdF4kS5w1xi260P7t29MJ4ANWuuc9cWEwS+Y9/8fZHBgx0C3MUrYjsfp0H/ztq54uhLFy9I3/rkgV5ki6MCubZ3KrPRizWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XC8Xa1TlzbsHZptxJ7BbtlFf2xwTU6/84uBs7zoNhxA=;
 b=W+UVZSvSFN3xd/Qdl6QqUxg4YMxuPkIUCYuBJuvmLFCTk1SHm0rKITEFMRhr1whsFQZIQzfUTNOuPhMzHUm+dzMSeSctHowGwLaIEsvKJzIvvBXglD3SHhh7QEw5IxlD7TZrv8Q+yPHcWBFDaMliEMH0+jiOCwcw4XExXfFblTJzleMUsUqc6aUyiHqaJDTCGvqjPsjcm6x335tRAuBsxu5zaNh6/yZ9Jd91754PBEfuLeLbQx3TBEetA8jBETNNH9ZknISjimhnZLvni/LTfLOZNiL7RbbD0WpHdWSg3LdcqEGChO33/6leMrmW/D3W42U1kXdL70C1tMm6MBBTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC8Xa1TlzbsHZptxJ7BbtlFf2xwTU6/84uBs7zoNhxA=;
 b=oegFVHcGIenjPAhzbxQJOaq7sNGURGGFilfLJWqSZUUlT83klXKoHRh5h+TXlfpAT5ylSWqcEld/EmVcD+PrlYFrCtSr0H8DBccrv/jMJc9j3ZqWLHPoQ44fcT5cgaFqi9puU56QCuP3QQfO9JHo2FNSihqrwF5sLdKK/5Vk2p0=
Received: from BN9PR03CA0600.namprd03.prod.outlook.com (2603:10b6:408:10d::35)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 12:45:22 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::fa) by BN9PR03CA0600.outlook.office365.com
 (2603:10b6:408:10d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Thu, 6 Apr 2023 12:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.31 via Frontend Transport; Thu, 6 Apr 2023 12:45:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 07:45:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 07:45:20 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 6 Apr 2023 07:45:18 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v5 1/2] drm/amd/pm: Add support to check SMT state periodically
Date: Thu, 6 Apr 2023 20:45:13 +0800
Message-ID: <20230406124514.2906870-2-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406124514.2906870-1-WenYou.Yang@amd.com>
References: <20230406124514.2906870-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: a147c834-77ad-4ee8-2282-08db369cc8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Og6ugeN7gUf4HbYbG0u5iyyuhwLLEeBmRaobCLsdR9iV6IjzIRP3Oy6aix5JnpDgZTKW/54gMejENJWs3VoCnB9bx6wJZ40BJdOyr12GNEhLuAUYg8za//zRDuF3pqZt/HEwZfNkb0fO9rSOXZsBE+XYvZ1DWvDCsm42vKhOt44pdM4nt6Arv8Q/Rq139FmCzic8LH6alpMQrRnSdmhnXNPRzs6yOpOpduzB47bkuyrB7A9jviA6zQ2eTPGc3xPv0JoX+XSw/tJFjpVIUTdr+DpuYc583W0hNMX+ayj55SDJTnYE5eY7SteaGg9N5NcGM6kgfSqAHfHIVag+L+91p2PnQfsLLTkMvd/wrQxe3ZP/PBYTJU4Q+kqgWhAq97LJrWBxBopuLOXxYPYEITH64Idirpkhp+tF4rs3Ws76anSKX5G39lEpd8KX2d1AzRkAlGL0ZRbcwBrsBGJXFXIRDtAZ0ILlqWXb/CzwDgWHHGz0PDUeVmTKaOkzwex+JAgkfgNRgS/vdviHsm43yyIxAndfBn7guJJtYdZCiTFWa+dK2Mj9SZ8q8h+bbQ65OdKMgPODLhcAPo2JS1Ernc1JQICO05F927ZTAUo10Fnd0FXhI4ZTAX3zdCKotSCNnhl3vDsAd31G2yZ424D9K2NtDKOQcuHoas3lWbROPKqJCAdTCrb6sUXPokvUxODQFRB9iw9ggrvwM/0dIoBhBayQbiI3rYEjAdp8MxAOxn+QIyA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(110136005)(54906003)(6636002)(316002)(41300700001)(8936002)(186003)(2906002)(478600001)(4326008)(8676002)(70586007)(70206006)(7696005)(47076005)(6666004)(26005)(81166007)(40460700003)(1076003)(83380400001)(356005)(36860700001)(40480700001)(426003)(36756003)(336012)(2616005)(82740400003)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 12:45:21.5715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a147c834-77ad-4ee8-2282-08db369cc8e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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
index 3ecb900e6ecd..b0e0c6664ac3 100644
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
+		smu->last_smt_active = smt_active;
+		smu_set_cpu_smt_enable(smu, smt_active);
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

