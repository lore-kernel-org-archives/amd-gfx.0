Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3A4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 10:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F89210EAE3;
	Wed, 11 May 2022 10:58:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2B910EACE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 10:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMZR/bTprKU782sJTolGuw8bLey+s448yXnD7YNqhdwxdmXWR21yEdiJjcRzLtEH5chDI/f6YEEO2qGjtvsD0RVlCXbDAgd3mZwXn7K26F7Z3eRNeJuYsz8VpSSqo4G3ua52J+vdHGGPAXeoATy9g2RPPqQxWCpoBj0fdN0RfEOujgrBGYMkyvtV7JNZY63+kf4vFTOSHSRK55ufrgUCDU2m1tUmjusJEsqh2UqrR2iMmdIaP1ULLD9CZv0nAuJEEIVcko7WSapPO8oPXtfyHyNV+TtcvmMPYnHSYSzkNPo+7PWx7YatJBhWG/aEqD4lyK1hMfkgGVkNUZtlTPJRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjBiViN3mNijSJt3xWP+gFRoShj/nqypiigy3ju3Bz4=;
 b=L3pkHoqfQWri3DgttEPo764Yf/eJp495sP/5sV9bhneYEElMNO1vmfi4l4SG5zvrLerzZgtp4t6d6yWe7tVKKtBTtin9EGgsxDdiLoTsRUdO4k5UEssZps7anzciWh1e17cAC5NmdtmUQ8Ew2aa1vhc4Ik3KKt8vv4twgRc+UGCcTZQkN0SBZOsZhdB20NQaTPYV48pgPJtaI/3ITyv1oK0CKkjlKcf39Bn+kj667xwuPBdkF9g0Y2pGeH9IeXNmFWRhtZr6SoUOWabjjJAi4ADVMqQ3ChqVsl7j79Xjhw1bGZlWT3PxnB6yoeyqts0a1lgWjdtNl/Mvm1JteUmHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjBiViN3mNijSJt3xWP+gFRoShj/nqypiigy3ju3Bz4=;
 b=qnD6PtOWD+EiHk473PUM8QuLoxact3bJaTcTEX0DaiHV6ykqKhdsdaoc/2j9YClai21yepB4T/E+3Wl/esHXfsji491edOPVxf84uMdrVLxWo2OXULIVu+Z7qe5IdCvrzZ2UqJSvz+pmW42hXiPM/sHUBEINQSW/qNlJVH339aI=
Received: from DM6PR08CA0016.namprd08.prod.outlook.com (2603:10b6:5:80::29) by
 SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Wed, 11 May 2022 10:58:11 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::a3) by DM6PR08CA0016.outlook.office365.com
 (2603:10b6:5:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 10:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 10:58:11 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 05:58:09 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update smartshift powerboost calc for smu12
Date: Wed, 11 May 2022 16:27:55 +0530
Message-ID: <20220511105755.2335000-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38983a4f-8cbd-4908-70a2-08da333d23e5
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB26385AA8D8E91FA78E61DAB29DC89@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6LB2Rdnv3WTu9i2+PaHu8oL8dZBOlEdonYzItCERhvYv+7Dh21O0SQIWjpBoCUM34yOWmGTrXEhOpzpclW39Bx4Qcwf3Yj9KACSNEhivWNeEXbx7/rzTviUuSs+C7PjC2Hk3eRz31nI84k/uZ1mn5GDWPV14A5Or+f+L1lAqA2NRYyLExg2cD6wIka6TbDmomWIgQU/6e9rMnJjRGOChfoJrYlO0wPFTutVmsf0PMI3uWpAZkjLF9X9iAS1lWGmXloLxxw19oRMsxQRRyn58LFAgdDFqJCgrYxD/L97D3rT6UEboFYAwIlrVoCpPzX5XgoIkr392g3icy2vPn+fuihbDprcfqty8bgMJTgCXpoD9nku1rEBPQXLLXWUtbxAtfjeGLgtWscMKcX8RyeM3fV/nz5kn74ai0wkiNqpEpLTtQQybGYqB1PFsxe+NnDNuzKceug2e1x4Je5/ZsmOzzJtNmG/4KRWSVUtmcCsru1EqKLw61EucCz/5dASUHapmw+HGHEnb7KlTEppnmw414qVaXQj3yJCo5gWsuW62CHPXoy0V3p8x3irTGhPZNdKYt82PLiPLQ6BlAZiwWI7nfSZ+KQ5FClVYrWcOOz7RSSDMJuG7Dp6dahcYfkyeuOqYuV+AWJveTxr7xtUw68auirCezf5F8MQWYRsD0rC6iOVUh1Ms7pfhM6qmzdSs10oeeNOT3EaPjQYifYP/4hKmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(36756003)(1076003)(2616005)(86362001)(7696005)(6666004)(70206006)(81166007)(6916009)(54906003)(316002)(70586007)(82310400005)(8676002)(4326008)(356005)(2906002)(83380400001)(508600001)(336012)(426003)(36860700001)(47076005)(5660300002)(40460700003)(16526019)(26005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 10:58:11.3513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38983a4f-8cbd-4908-70a2-08da333d23e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Lazar Lijo <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smartshift apu and dgpu power boost are reported as percentage with
respect to their power limits. This value[0-100] reflects the boost
for the respective device.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 60 ++++++++++++++-----
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index fd6c44ece168..012e3bd99cc2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1119,6 +1119,39 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
+static void renoir_get_ss_power_percent(SmuMetrics_t *metrics,
+					uint32_t *apu_percent, uint32_t *dgpu_percent)
+{
+	uint32_t apu_boost = 0;
+	uint32_t dgpu_boost = 0;
+	uint16_t apu_limit = 0;
+	uint16_t dgpu_limit = 0;
+	uint16_t apu_power = 0;
+	uint16_t dgpu_power = 0;
+
+	apu_power = metrics->ApuPower;
+	apu_limit = metrics->StapmOriginalLimit;
+	if (apu_power > apu_limit && apu_limit != 0)
+		apu_boost =  ((apu_power - apu_limit) * 100) / apu_limit;
+	apu_boost = (apu_boost > 100) ? 100 : apu_boost;
+
+	dgpu_power = metrics->dGpuPower;
+	if (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit)
+		dgpu_limit = metrics->StapmCurrentLimit - metrics->StapmOriginalLimit;
+	if (dgpu_power > dgpu_limit && dgpu_limit != 0)
+		dgpu_boost = ((dgpu_power - dgpu_limit) * 100) / dgpu_limit;
+	dgpu_boost = (dgpu_boost > 100) ? 100 : dgpu_boost;
+
+	if (dgpu_boost >= apu_boost)
+		apu_boost = 0;
+	else
+		dgpu_boost = 0;
+
+	*apu_percent = apu_boost;
+	*dgpu_percent = dgpu_boost;
+}
+
+
 static int renoir_get_smu_metrics_data(struct smu_context *smu,
 				       MetricsMember_t member,
 				       uint32_t *value)
@@ -1127,6 +1160,9 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
+	uint32_t apu_percent = 0;
+	uint32_t dgpu_percent = 0;
+
 
 	ret = smu_cmn_get_metrics_table(smu,
 					NULL,
@@ -1171,26 +1207,18 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->Voltage[1];
 		break;
 	case METRICS_SS_APU_SHARE:
-		/* return the percentage of APU power with respect to APU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
+		/* return the percentage of APU power boost
+		 * with respect to APU's power limit.
 		 */
-		if (metrics->StapmOriginalLimit > 0)
-			*value =  (metrics->ApuPower * 100) / metrics->StapmOriginalLimit;
-		else
-			*value = 0;
+		renoir_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
+		*value = apu_percent;
 		break;
 	case METRICS_SS_DGPU_SHARE:
-		/* return the percentage of dGPU power with respect to dGPU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
+		/* return the percentage of dGPU power boost
+		 * with respect to dGPU's power limit.
 		 */
-		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit))
-			*value = (metrics->dGpuPower * 100) /
-				  (metrics->StapmCurrentLimit - metrics->StapmOriginalLimit);
-		else
-			*value = 0;
+		renoir_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
+		*value = dgpu_percent;
 		break;
 	default:
 		*value = UINT_MAX;
-- 
2.25.1

