Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3570CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 11:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C1E10E299;
	Wed, 11 May 2022 11:47:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0B610E299
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 11:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPVVMHE/XoK9d/u7ZogVCbIsJdGYibck4hF8bshEzFEkChdFlcMmpvUc/8Br/AC+3AUNwV/MGeP+d6WZwq9qNlFoFagzkoVt3YCyLfhLa0TN+mbJkez8E+iUR9U/tc+l4xeW8GsfwH4WNNFQJsTrKRW7ET18geTAaMpYEwtSanQtJSSfgnXMgnnkFny4fPU5+np2D/tP3QDINXfMxW1+0GNdkJZLVqWLbAxQ8237XWKVCNsFp2wCUpDwVQ0/kl/u/76jWAy4f2rMjC1qorbaRRmJmkWvOi7DLbw7nQwjuhbEcEzayhitJkJ5awuFGKK+mjWVZwNRF1elrqtPh939Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgoXrQ242kRzaByChC6JgtgMbJlSRSxXffw3GcLBfcM=;
 b=X8a1N4+UBnn19bk5oLOv+WPI9LCj+LinTaD6r2vJQVjq6BFE9figwQS6T68OTdG2/Mt8WN3zUk+aQKyABSPzXsvbeVKnaKHgyjTeP/9Kg3+Ij8l+qLzG/4uYugb9DIRTuCDsCobLwUL7cdKrQcGHH8ahG7L3bpjOqufodD+u9eKKyKdrw7SxLPS0SL8ntd1SiO803WTzHr+I+HJ8VQnwP/BHeoS9vdb8gJ1HCqgVUNPUYqOwFTvZiaDXSGTzjZC1FlA1BRlqNYM4ZUL1cU2dHEnaOnUoxvhLU5xkv8CZ/WKf9GwOZ4rYjiJBjo4xTQPF4l8PJjO1/9GyppG+DYdHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgoXrQ242kRzaByChC6JgtgMbJlSRSxXffw3GcLBfcM=;
 b=P4GUsg4+jGQad5XgPncLSS8jlqa2lwu5cFcqW7gWnp6P3PyZuXuWYdpAx+FWXBXayXwSLE50RV5RntnhqDv8OGuU9Bpg9yMxujrgkaHzXMQVTsmccDqpbDitDmzbovZkd25zja9hzaNAewrPao+73ywPKRUKuK9r5wah9QAhjxA=
Received: from BN1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:408:e2::23)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 11:47:20 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::f1) by BN1PR13CA0018.outlook.office365.com
 (2603:10b6:408:e2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 11:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 11:47:20 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 06:47:18 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update smartshift powerboost calc for smu13
Date: Wed, 11 May 2022 17:16:28 +0530
Message-ID: <20220511114628.2542190-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 156b96c5-eb55-40e7-f3df-08da334401db
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB45035625EB272F64E3A54CE39DC89@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJkqDSMQLwR1lfRdS+D55V6p3IRlujgJMzZ0XfMTamrWUrnj85yoIddVJeLNj7/5v2xND7Mo6KEP5RWkzWWl61g0EjPcXB3JHtjXpG0R5sG6d5tK+qtcl5EU5XnUkn3cpUroJMCZZbYj91xIosCRkVAViRfB1+TLWLrTolLU6XHN9XbxQwnyifNzBZEkoPrNCkIU3MocXVke1RqJBjOhOOMQYA8ob2TX8B/pb7Ke3/Xg7KeyARDDAw93Cd+b5I4oX3p1gMxen38dxzSAAsbbOPxKwTrYrz0ZE1Git5At8Wx3kSqVkN6EhFxVlpN2n7uFRf5oxm6p0/qCCBTRn9e2XbyQNh7d+PBRJD2iY3KYxHjVXbV8kJhtk1q4cdDnmOFYahBcI1KSh79+IVx/qZGRcFY7Aoy5MfikI1YI31pBdlocHYZSTrOH7RPv7WP5Ldx00stRtZRkCfzMKg7OqgTCPoE5w8CTiSaflfPtIUmXSLsDrdfycDM+KAqBMUBP1w5KhoPn/YqrkeNTqUAs/tJnYkfxVrgY5RcdWQUpC2icyvGqErvA8Rp6UGwutUOvJFYv50IZ7bS/jR1KSS3/Ej59E9TWL1UpaCs0eCcw1a+pXHiOYk+77VXf1ienCrsMa/iqDEzXHk6vs3h3w0erLVxx2tGZIpDLT9Ss2HPK7V7bkta23ph7uyWr1IAHvXqPRTm1llTVBT44tvEbMyAz2JIEkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(356005)(82310400005)(83380400001)(36756003)(8936002)(70586007)(70206006)(54906003)(4326008)(6916009)(8676002)(316002)(36860700001)(426003)(47076005)(40460700003)(26005)(336012)(508600001)(2906002)(5660300002)(16526019)(186003)(6666004)(86362001)(1076003)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 11:47:20.7706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156b96c5-eb55-40e7-f3df-08da334401db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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

smartshift apu and dgpu power boost are reported as percentage
with respect to their power limits. adjust the units of power before
calculating the percentage of boost.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 60 ++++++++++++++-----
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index e2d099409123..35fbeb72c05c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -276,6 +276,40 @@ static int yellow_carp_mode2_reset(struct smu_context *smu)
 	return yellow_carp_mode_reset(smu, SMU_RESET_MODE_2);
 }
 
+
+static void yellow_carp_get_ss_power_percent(SmuMetrics_t *metrics,
+					uint32_t *apu_percent, uint32_t *dgpu_percent)
+{
+	uint32_t apu_boost = 0;
+	uint32_t dgpu_boost = 0;
+	uint16_t apu_limit = 0;
+	uint16_t dgpu_limit = 0;
+	uint16_t apu_power = 0;
+	uint16_t dgpu_power = 0;
+
+	apu_power = metrics->ApuPower/1000;
+	apu_limit = metrics->StapmOpnLimit;
+	if (apu_power > apu_limit && apu_limit != 0)
+		apu_boost =  ((apu_power - apu_limit) * 100) / apu_limit;
+	apu_boost = (apu_boost > 100) ? 100 : apu_boost;
+
+	dgpu_power = metrics->dGpuPower/1000;
+	if (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)
+		dgpu_limit = metrics->StapmCurrentLimit - metrics->StapmOpnLimit;
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
+
+}
+
 static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 							MetricsMember_t member,
 							uint32_t *value)
@@ -284,6 +318,8 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
+	uint32_t apu_percent = 0;
+	uint32_t dgpu_percent = 0;
 
 	ret = smu_cmn_get_metrics_table(smu, NULL, false);
 	if (ret)
@@ -332,26 +368,18 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->Voltage[1];
 		break;
 	case METRICS_SS_APU_SHARE:
-		/* return the percentage of APU power with respect to APU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
+		/* return the percentage of APU power boost
+		 * with respect to APU's power limit.
 		 */
-		if (metrics->StapmOpnLimit > 0)
-			*value =  (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
-		else
-			*value = 0;
+		yellow_carp_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
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
-		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
-			*value = (metrics->dGpuPower * 100) /
-				  (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
-		else
-			*value = 0;
+		yellow_carp_get_ss_power_percent(metrics, &apu_percent, &dgpu_percent);
+		*value = dgpu_percent;
 		break;
 	default:
 		*value = UINT_MAX;
-- 
2.25.1

