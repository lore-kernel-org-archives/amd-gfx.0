Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB58FC10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2BD10E159;
	Thu,  7 Dec 2023 22:54:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E759E10E14B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADgbwdMM2g3nTA38VpISukUSnBdJ66G1gIN7biGbJ5dzRNACABeDYE7uYnBphS2NvLnVjEQELctlBqFbcaGxG+pVVbbqxlE4alx9kWd/RGHhuBc+UDFShpySKCgPf6bFOheDdkQQpWmuBte1zrwxROtumrBlYCBR5d/zc7EKffeS2azmXEkreKa/Gzn2845SiQWjdDuA5hl+BCtqIU01zU6L2jzE/T9YZBrU4hWNxDKmJ/TLZMthqZHSkXngYi47APBzFo6oLJGJq/zvYl1QuYfRVVL0Rn+YFxQQTOpqBZF8bEO7nHsAO81O6jw2GdWAxveIx17VOtSya4UKK174xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1/tBPQpanhIfHCR2D/o5QT2089qWS85qR0LUkVov48=;
 b=WQdzczmKBFjq0B1IYibw0/rzPVJwkxSG5AymoyB4oBunSYOzUery5xbO0I15dpdDI6sjroZeAHXJLNt1yYh7fBtJrjTgNgOUVPY7WNjjFsD+KobLQg1jBhKHYS/wRLDbkXRYQ7TLikUiCKAO/7IllMFJMcHVT1uQE1lWUdbctxHog3VxuTwxdILRV5LzZ8FIlmUy0HcTMZ0nZh/lL7znFUVKbtlurMuBUOcsmesVfjbtohG3+rQcxnwzQliw+x94HOjYRTDUq+gKKj6ZWt4luIwXtcSh4roVBCm9Syi6nL/MsjgkPmqbJNqpxmDowi48J3v/t5mLANEwRB0BuLVgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1/tBPQpanhIfHCR2D/o5QT2089qWS85qR0LUkVov48=;
 b=Q1CUeAW3pPE2WyZzmpmB8e1kB99bnRGfo06nenvMpxaTRyrYkYf709zIw+hbPSOZ2F51VWD/n5LH/Tfx2q6m07IWtS8PI9Tz9r/esDGBoYJSwuasBZgdhbVuAUjHDs2FxGaLRtvJ3fYVV0FGNOfCfLw1QcLanxk3ER6ujfV+ZwY=
Received: from CH2PR20CA0001.namprd20.prod.outlook.com (2603:10b6:610:58::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 22:54:40 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::49) by CH2PR20CA0001.outlook.office365.com
 (2603:10b6:610:58::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:39 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:37 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 06/23] drm/amdkfd: add trace_id return
Date: Thu, 7 Dec 2023 17:54:05 -0500
Message-ID: <20231207225422.4057292-7-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: b12d5bac-3a92-487e-9c27-08dbf7777e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlFt+LS7HkyvxY+96hYvPvicxid5lgEoGQG5F0ZR8KO0nRc+1Hk6/V5lojyFDOJWkKxTz+8i1z500hVU9N9aiuA5PiJEt+9dEl+EOISCwZER+VefXqjgNW3oqZ/bNi+jMb2+ABbPwbrdTzVhGE5r00Pp1XTTCp7D4+eD0jZtGSUzD82Q1PMEPQatSNBJcjsFtrQiVoiEggbXnmXWslmVfNIWg3WcIF4rc1Byv2aJLk4Qn98wMYZbz/tdDv5U/EHgXBze/Bb1pF5+j6p5cjiHXI/hMo5F/AqaqxOoKaJWHSVufLbUR9tawwIdiM9HJ5lBKWWOw0OiQFx4HtAI/B7MnLfYn6wNpN/pVYkF+fysQ105bJTiyso2x1S2CjIop8vhjL8i3wHcBoK4B3yt1uLWK4Ttzc0MriKh64MVWzSMEkqArR8eISQy2vHrLnAFTmgqlk1vI/G6Bp1wrKg9dzIh+SF+6RiPZ72h96kqtq6dH6jT3nG/h1QfkLPFecsD11gROJqr/VxrOQZ2j8x3X3hLN/87UiPB4NJBfKxjL4SMNDtfvwuK+PSevobXnMpAoNYnfByhU8NRtFayj1fqHQxSm6Qu0IMGilF/9ywWJz4tJYEcV5RyEPs4OyYQtt76yZ8CnhtBe8GfAGxFUvfSj76mnfm5km+7XMUYa9B81jzXQwiTmmLdt1WXYQFYeUHRzhG2SecQY/eeagZU/jpPaCN2liMeSkYfDUAA0VOgTArbIDxMfG+8nlWUXnNmEu8q+D4UXD257pbXtJUBt7IchgyOxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(8676002)(8936002)(7696005)(5660300002)(6666004)(36756003)(2616005)(54906003)(6916009)(70586007)(316002)(70206006)(478600001)(41300700001)(4326008)(2906002)(40480700001)(81166007)(82740400003)(47076005)(36860700001)(16526019)(40460700003)(26005)(1076003)(83380400001)(336012)(356005)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:39.8589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12d5bac-3a92-487e-9c27-08dbf7777e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add trace_id return for new pc sampling creation per device,
Use IDR to quickly locate pc_sampling_entry for reference.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  6 ++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0e24e011f66b..bcaeedac8fe0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -536,10 +536,12 @@ static void kfd_smi_init(struct kfd_node *dev)
 static void kfd_pc_sampling_init(struct kfd_node *dev)
 {
 	mutex_init(&dev->pcs_data.mutex);
+	idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
 }
 
 static void kfd_pc_sampling_exit(struct kfd_node *dev)
 {
+	idr_destroy(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr);
 	mutex_destroy(&dev->pcs_data.mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 7828a6340edf..b44dfea15539 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -99,6 +99,7 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 {
 	struct kfd_pc_sample_info *supported_format = NULL;
 	struct kfd_pc_sample_info user_info;
+	struct pc_sampling_entry *pcs_entry;
 	int ret;
 	int i;
 
@@ -140,7 +141,19 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 		return ret ? -EFAULT : -EEXIST;
 	}
 
-	/* TODO: add trace_id return */
+	pcs_entry = kzalloc(sizeof(*pcs_entry), GFP_KERNEL);
+	if (!pcs_entry) {
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		return -ENOMEM;
+	}
+
+	i = idr_alloc_cyclic(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
+				pcs_entry, 1, 0, GFP_KERNEL);
+	if (i < 0) {
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		kfree(pcs_entry);
+		return i;
+	}
 
 	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
 		pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info = user_info;
@@ -148,6 +161,11 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
 	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
+	pcs_entry->pdd = pdd;
+	user_args->trace_id = (uint32_t)i;
+
+	pr_debug("alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x", pcs_entry, i, pdd->dev->id);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index db2d09db8000..7ca7cc726246 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -271,6 +271,7 @@ struct kfd_dev;
 
 struct kfd_dev_pc_sampling_data {
 	uint32_t use_count;         /* Num of PC sampling sessions */
+	struct idr pc_sampling_idr;
 	struct kfd_pc_sample_info pc_sample_info;
 };
 
@@ -756,6 +757,11 @@ enum kfd_pdd_bound {
  */
 #define SDMA_ACTIVITY_DIVISOR  100
 
+struct pc_sampling_entry {
+	bool enabled;
+	struct kfd_process_device *pdd;
+};
+
 /* Data that is per-process-per device. */
 struct kfd_process_device {
 	/* The device that owns this data. */
-- 
2.25.1

