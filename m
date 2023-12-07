Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD79EC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2381410E22A;
	Thu,  7 Dec 2023 22:54:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66BE10E226
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jipWeUFEOf/o2bF1pkB5Ucgp1cj4p6emtljPKm2Bz3HkF/JL9SY7nEDG2EanWvq4s/oLu6Pu0dfDIWogwzuNOmrpzZ3Y0/F0wzZc15Y23vYVs/Wsx3uNEy4foitPIEzKTuc01GJW3y0dXRPzehCZZrxtLFeKj1aSfQbv4DC7Q4UT6hiJUJlxWPT+zUGB6LhsryfRsiwrqbxGhJAd0JZESYvthSeEi16A66wF2zMLXzaBXM+eKFJj0nn4wdZ0ZF3iOS2uhLBH8sdUVjxuAPZ2AsM5ekr2anPTqzdEod3+qLkgan4c68dR2yTSu2wEyw/QrGta5Bg2WnN+WuvhtYv4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZFsDykLvslfaxEXyPQ2bXAQsS39ULj2HA6RKmm89Ds=;
 b=YEAeB2BCMHd9g5xgD60PLiG1sya6y95ZUDhibWBgeaXkoz/h6VEhzIElv5hrxeMmWm3cfWBOn2cPXz7YEksHRbxvjBEMcDfpi6MNtXlBOXY0U2O4uvtV7nmdKUU44y/BO0kAvKg0wosC1M6SfOeijhBBlGl6yyitR7xl0HSLRC0tv60XFBgb43QHRynVgz8iztbZU9cYbec75l4N7h1EI1Qlji2jdEIooUjP7Ok0+EavtsmAOJa4oj2iq8uHLABCrRJlLLreIN9ykCYHrZNxqDgKFt5zAdzP6U3LYTULA7IrxGUpX8XZzX+9xvqpv2/+dryozG1s/7CZV4oz5+k4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZFsDykLvslfaxEXyPQ2bXAQsS39ULj2HA6RKmm89Ds=;
 b=Nl95hT/d77NjvEIoZqWULScqjvlS/C7nDyZenbGQHo0TOTOHGUftWUbUUdJzECzEJMuCGIXe2bjdOKPSRBmae8gSL0M0tioVEknQDLx3EPZJ+R4tQkhe9HClbZhl+krX/geoPW+BDwEZloIiC+7PUJT8mwHqdgTAYQR9EQGIvZM=
Received: from CH2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:610:58::25)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:46 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::61) by CH2PR20CA0015.outlook.office365.com
 (2603:10b6:610:58::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:46 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:45 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 18/23] drm/amdkfd: enable pc sampling stop
Date: Thu, 7 Dec 2023 17:54:17 -0500
Message-ID: <20231207225422.4057292-19-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7775ca-7c49-4476-93f1-08dbf7778292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqkCGsYN07/rcxGS12DICsnny55g7itaV3mrFN4/ZcBo0DXGG144obPDlhUnf+SgZrnxHm07zBsjN+9AwQzWKdwq9laWyMOWLfnMOK2rVTlew3VuZm1z4cGofGvGQkVgwpWZNaNCI7I0aKnZUb1je8OPrqY18TJOBbfdOPZ7jvTUddfK9NjB7YYuN69FF6+ItKb3wKVC9oorJsDvZoUX+rBHauubWlVu4Lbjfdi9gzzoscPp8Il9nV1Hvbawez2JpvZCUKoRXpqQnOrElE+TwsFrITxMXa/GmB2OrQVnPfs0xojVezE9ToclMuAUFo8XqcZz2CvCmI2mUZWVjAGqIPijGk3Ff3wJxChIRRoO01dBaMYxS3vgc3uEUndKvfcyoPhEXf/t0rE+jGjKZgWa2xSNJMu+TN1HVPQwA5ZSwALUaZisk+UrHKLDUaUQMz+eqvS19zadR20qdPCiS5nJXmVW/Xl5+QeHL9e+na4zPTTLWaTE8Bd7OOfBlgIKmM9+z7bhco4NoUFhV2XB/c5IOEk5m55BQ15i5rv+xSpBnFHqgx//r5A2rg3Ns8Dkl3yZ2Ppva+EoonEBK03autcT57whMmYchi1shqrpSTbvNhyWhyCZJM0h4iSZjU6SmMyrHUi0oRbKgkXYsnhE82/LFnF3L/7o/LKf0D9uzvcmcbO7AUMoym1GaVXKraCfYUAjXnEA/kO3pPN3TQGN+cDJzfY0Q3v0HLsW2CDJqhu1A5zeLZsV2jcKo7kU5YvKqIp3lsL3YLG/YQKE53lYykdsmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(8936002)(8676002)(4326008)(5660300002)(316002)(54906003)(70206006)(70586007)(40460700003)(47076005)(36860700001)(6916009)(2616005)(1076003)(7696005)(36756003)(26005)(336012)(41300700001)(16526019)(6666004)(478600001)(82740400003)(83380400001)(356005)(81166007)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:46.6089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7775ca-7c49-4476-93f1-08dbf7778292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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

Enable pc sampling stop.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 28 +++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  4 +++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 18fe06d712c5..29a6f9f40f83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -88,10 +88,32 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd)
 	return -EINVAL;
 }
 
-static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
+static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	bool pc_sampling_stop = false;
+
+	pcs_entry->enabled = false;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	pdd->dev->pcs_data.hosttrap_entry.base.active_count--;
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count) {
+		WRITE_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable, true);
+		pc_sampling_stop = true;
+	}
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
+	if (pc_sampling_stop) {
+		kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
+			pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
+
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+		pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
+		pdd->dev->pcs_data.hosttrap_entry.base.target_wave_slot = 0;
+		WRITE_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable, false);
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_create(struct kfd_process_device *pdd,
@@ -233,7 +255,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (!pcs_entry->enabled)
 			return -EALREADY;
 		else
-			return kfd_pc_sample_stop(pdd);
+			return kfd_pc_sample_stop(pdd, pcs_entry);
 	}
 
 	return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b9a36891d099..0839a0ca3099 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -271,6 +271,10 @@ struct kfd_dev;
 
 struct kfd_dev_pc_sampling_data {
 	uint32_t use_count;         /* Num of PC sampling sessions */
+	uint32_t active_count;      /* Num of active sessions */
+	uint32_t target_simd;       /* target simd for trap */
+	uint32_t target_wave_slot;  /* target wave slot for trap */
+	bool stop_enable;           /* pc sampling stop in process */
 	struct idr pc_sampling_idr;
 	struct kfd_pc_sample_info pc_sample_info;
 };
-- 
2.25.1

