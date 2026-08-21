Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB07CC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2F610F36E;
	Fri, 21 Aug 2026 16:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SUuYMmu3";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FE910F36E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSiJKglfFkkML9pceR6LfMyS6BH/jSzZZQ1W+Ht2q6o5B6H8iI0XVZw7sgIE6J4RsVHRQf6//4JsQVtf5xahE6RVivLK9Pr67KoSmsuVNE878UNMzceXlsxNUhWnt5gffrEfLKZBioCWyo/9K8zzjqWQX/KmTecqrYTFhL1miJspB8+C9v2hbxMg67s1HVLi9fWgByrQ5ybC2ghUnkMLEmA00sM6rQpqpxdLdGUo3U/kHozGyxPEAvUyt9V66e6/HUOky42tLozrF0rpJ0NYRXP48TBNKOtN7/+KOYRVFcAY67V44pjAWG5FJKhEWFJZKn9mpU5lkqOjPVtfR1Z+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO6FJYAQHmAjAYmfmZg6vGKHzKbIt6w2A2Ub8P92ok8=;
 b=Ify942i9xbT4m2hJi28GMsw1mARUTN6KY1xkkLcoZro63sKClk+rMbiai81PbqpQDItbLQVq2DMc7MUEnUq8UBjY08Hivy59xSl4DdoS0zi/O7fdamak3AP1r2fz2VxZXAtLplfv0TTnDEnr2TFmnwAUjhwWx6Bp94hLU5u5plVMdIAjj/I3dwiEwIDisycwKrj8j8LGju8TZH0VMTHAH+5vJfgcOX/zgjVpCeWwSulxq3Q/2hjjjQwUDjYseljmCGn007eW2U1Gd7QqY3aGrh/o87SSHCbqKvcYXByW/MHbRQjZB5HbuHuYzwZg8ZsTZOxryuousFNOue2IibuIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO6FJYAQHmAjAYmfmZg6vGKHzKbIt6w2A2Ub8P92ok8=;
 b=SUuYMmu3Oygou3tOBUQZSL3ooP1wVMRSiU8kcAVWu7eoIqf4iXrUcKxXRunTnx2vQDeUJN/myj2QnkUAHq78/uH/wlsh0M9nLhjWzek3Xdm/ZDgB+4KmgQFZn4Im8sZge/J9t0YXy4VVVrhj4QAFNO6DOIlEjR/a8IwlBXGQDr4=
Received: from SA1P222CA0186.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::18)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:12:01 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::5f) by SA1P222CA0186.outlook.office365.com
 (2603:10b6:806:3c4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:12:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:11:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:11:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: add 5s custom timeout for unload messages
Date: Fri, 21 Aug 2026 12:11:45 -0400
Message-ID: <20260821161147.753435-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161147.753435-1-alexander.deucher@amd.com>
References: <20260821161147.753435-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b579816-369a-4ab4-1b1e-08deff9eeee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l8PpuyCLgLOBbbXHcDqsrifkRdbkD0qxgqYl9k4C8jjmCkX9Hs9OQO2BEhrZDB0KcpU97W0AA5DB1SBNCKc4BRzqL8SPoUSzVuPryjkf9Xt2dZhnfxzo8VcmV9X7VAAXxFrACy8es4J9gmzXIzC/Fh7l5uFe0MqKBk9e3EKqJioT+BQIi1shWSmfpRXJ3NscWzjFoWbrZSfkkYn6n5Io++wkgo5zCH4DOteUUg2koidCmm8K6ewIh0je4fucZ8TGS/TGsVeu+Wt1xsE2fII174wUirlQLB/SWjCuVkct7oqPmegzbN4bRr77kcCPJ+eicIhZkK5+cKbO+gMyvQl02hvSJ895pPWzQv+d2wK5f2+3/nhAo4LuazmGpIXRlWJK2IBd6FDtEvinKmHI3UuvyFOlxAwvT4vwgpWDvQiyhWavTB2EUjTC4idMNMBY1VWd5bjOkcxHGOnBLvDNujKnEn7WzP8leG3G3I49hcilKPKXwQjjMgS3P6bqg0BfFyrxmK+aqxq3876mVx5ZLWqtTXuKWceOTtuN3ynPlZHuX1FRqIkCqql7c2M6DmWEeH4ah0bNx12wEBfORxvotMjjN9ONJBs8Q00REgzwyOg+nxdocUhUzvAsCOTXciyQmOi1fyAAS8snSiH+n8w7YQdJ94M1HMG4BpeTf3rKaOBU6bqTdjVj9vH+mH1PaAhhLeIKb7OaklvOJkmJ2RH4vwTgTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AMY6+sBlzCdncXaxn4oAgkPy2df7Ww5QQMLgMRC4J51Dc4OpOeogTok3P8NGs4FHsXMa/Ti/f1BolrIvZra6DyuMK6eI6GyNJb40MOKqHbeRhE0oOs/lfowHNCMk2/sS5lb5pG17uKKFJkjo66TunZKPLkGQ3deEMKS+CY651av7nmoxZuVhX3ia7G2SLoBB1d4TDCKLy1lUgd0zkQc0t2v3A+Js4++0B+WluVpdLUdlM7HBUYVuFMPY8UKIVmSJTuSXQlendcSBNC56uahb/7+MURSLM6H/hKTps4sIQ0I8M2aZqHd8J54wu9t9hmuqEbEZIZKN9khdQPZbz6rRQFbpyN7l6deG1qthfgZQfT1tipshLHSdwTVENMoUN8g6IT4MS7rRui07akX2x10xDoC60XWdmPGtmdXTC/w/af/ZLokaDb05XE2ykYgIaRQs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:12:00.5533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b579816-369a-4ab4-1b1e-08deff9eeee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155
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

From: Asad Kamal <asad.kamal@amd.com>

The default SMU message timeout may be too short for the
PrepareMp1ForUnload message on smu_v15_0_8, leading to spurious
-ETIME errors under load or slow firmware response conditions.

Introduce SMU_V15_0_8_MSG_TIMEOUT_US (5 seconds) and apply it to:
  - smu_v15_0_8_notify_unload(): switch from smu_cmn_send_smc_msg()
    to smu_cmn_send_smc_msg_with_params_ext() to pass the explicit
    timeout.
v2: Use c2pmsgctl and args directly (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index aa4daf8f7d6f2..b886208ad93df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -72,6 +72,9 @@
 
 #define NUM_JPEG_RINGS_FW	10
 
+/* Custom 5-second timeout (in us) for unload messages */
+#define SMU_V15_0_8_MSG_TIMEOUT_US	(5 * 1000 * 1000)
+
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
 #define SMU_15_0_8_FEA_MAP(smu_feature, smu_15_0_8_feature)                    \
@@ -1279,12 +1282,18 @@ static int smu_v15_0_8_register_irq_handler(struct smu_context *smu)
 
 static int smu_v15_0_8_notify_unload(struct smu_context *smu)
 {
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {
+		.msg     = SMU_MSG_PrepareMp1ForUnload,
+		.timeout = SMU_V15_0_8_MSG_TIMEOUT_US,
+	};
+
 	if (amdgpu_in_reset(smu->adev))
 		return 0;
 
 	dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
 	/* Ignore return, just intimate FW that driver is not going to be there */
-	smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+	ctl->ops->send_msg(ctl, &args);
 
 	return 0;
 }
-- 
2.55.0

