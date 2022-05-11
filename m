Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908F8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 07:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B4110E049;
	Wed, 11 May 2022 07:01:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31AF010E049
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 07:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5rKbiATAFFOtlVJVhE9gSDNs5NKBpS7jmchhaaZu3pdJHf9lRD2bIYBS9X9LRijbrcJ/7K/kQRFNa45cRsnP/FGpELG6cVaqr98V8xUMHUfNq7Lo8zsipr5BKCyM+OR6b0Ta170T4LPetK1hydZ01hXH4SFuDkARXNVEyMA5TjAqvprPdfsSOgOnXsZV9NhDmTwP1TvSL1ueySK33NWrcnL1YWiwrByiJ3S7y5afnPQIHSBe2Qe8caXIQE7lrorMzvVqQCktxyXjvIK0iz6pkgWtIsEzCKE+/I+bf2ZMOqrQArni0/xeqBV1cddnCXr08uWWoy2e9TYB3Q2UHeWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28UYEJtKTLy77JGP4AxJLtjKRBt//aOqap1Og5u2TEE=;
 b=iOeSg8yQyXyuKkWt2Grlr/m9/w7QZHWPNx5v8SkoLCe3K7SddVe3qH9rfC45WBG8uGOvx+5Nsn5e0wXvAyivLo9NtiZVxdbM1BWlbNr5/wPcjyzfPGESs44R4WsAziiSlfnKGbyk8bZaqi0y0FHapdKJwmNEWkaHXU72riTO3tBjfP71e8/IBriAD6CyBmuGkCnzql9ZXUk9XvyBgiD8djeuV5FZCtF9oJwiJwr75AkjNb+cShVSy7jKYPIslw+lVVILEj9ldCsXm13lBlQusRv/fHIaHgEVDIj684TqeZZFPWewn6/RMVE6B9XfS0vRQUJMwe+1d3vXaDIvLlU3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28UYEJtKTLy77JGP4AxJLtjKRBt//aOqap1Og5u2TEE=;
 b=d6eDLUwbRJCZQCaRFoXYQeUw9nBkyrdpGR5HduP2tXp9BJRHwoYB/C17E86FERL2Hmgamw29uF6usUuX7Xvq/85BSWdQXMsDqAg0nsKKhGQxeEAPkcs4UGgv8+J5EJuVA7+IjULxJG0nBf+3s48wRIXnzej7lluWU6U5Tp4UgX4=
Received: from DS7PR03CA0135.namprd03.prod.outlook.com (2603:10b6:5:3b4::20)
 by PH0PR12MB5499.namprd12.prod.outlook.com (2603:10b6:510:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 07:01:34 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::a1) by DS7PR03CA0135.outlook.office365.com
 (2603:10b6:5:3b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Wed, 11 May 2022 07:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:01:33 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:01:32 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add smu power_limit callback for smu_v13_0_7
Date: Wed, 11 May 2022 15:01:21 +0800
Message-ID: <20220511070121.809540-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1438859c-3387-49c5-6174-08da331c1561
X-MS-TrafficTypeDiagnostic: PH0PR12MB5499:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5499CD09367B3CF96BCC321382C89@PH0PR12MB5499.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dzbfq09LbgIoXbdsMeX0OSuE7NM2UuBwU/ss50yBERztUyPhPkZHG+JLvSRzOGVJcpS/xrh5mQe6D0d4XRa3DRbLR0kNTbuwjAe6euGCjwbRmkVoSztyFD7LzOWO+KIHhxrYAq3+1rR2DZFy248OOmNdTIirflKv3W/l6NtZ+fj7sS878+/pn2hJGQbjhrYm8HLpHxbC30oTxLAIeeLodGxXHX2iG4tFQcXt2Rf2Oxwd7GGJyxAcDCaqbW0zGSTsquWBEO/HRywAoz0cTWYDVWlxHsjztaMSCnMxJ7qwjJ3DPmkTCxT2vUpIcWyll7PY4HOKOVG1/1CyRUi9u09yttbMl6UqtJMHt+6v29i5Ed9/ixb2XSmP8ncIkwt1o87O6LijGFFV35b86E6NDP7KmB7yPJtyV0iJv6fMOXmQPsV30ppol1pBMa/GsLvt8RaPoDyduKWKQ3PGgfdmn9PlT9KoYhrhJKf/umMwIA/fquWL+6yPqkuEzbXnbyn/lF7Y59ZH0Td5NKfMcZ53qUgBd76YL5f3oukvZLQMJawdH7dNbOtclHVS4/IRrDXrI5a6Aaw/V91sItF1IouREfHkdA3pVQxe2cYiPzzsY4RC5NkkfgOnKyAO19HDtw0656IEPJx0M8E/PQn6TU50dQX39tMX8kwu1Zq/OxYbuvb2ZVZn+Trn4PHdvkXvZnz3e9xn+fp4rI5ikUWEkANO8Rykug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(36860700001)(508600001)(336012)(316002)(40460700003)(426003)(47076005)(1076003)(16526019)(186003)(6666004)(7696005)(2616005)(86362001)(2906002)(5660300002)(81166007)(356005)(36756003)(83380400001)(82310400005)(4326008)(70586007)(70206006)(6916009)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:01:33.6213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1438859c-3387-49c5-6174-08da331c1561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5499
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
Cc: Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- get_power_limit
- set_power_limit

add above callback functions to enable power_cap hwmon node.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 7c9e0ba7ab50..4e1861fb2c6a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1367,6 +1367,43 @@ static int smu_v13_0_7_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
+				       uint32_t *current_power_limit,
+				       uint32_t *default_power_limit,
+				       uint32_t *max_power_limit)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_13_0_7_powerplay_table *powerplay_table =
+		(struct smu_13_0_7_powerplay_table *)table_context->power_play_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	SkuTable_t *skutable = &pptable->SkuTable;
+	uint32_t power_limit, od_percent;
+
+	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
+		power_limit = smu->adev->pm.ac_power ?
+			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
+			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
+
+	if (max_power_limit) {
+		if (smu->od_enabled) {
+			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+
+			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+
+			power_limit *= (100 + od_percent);
+			power_limit /= 100;
+		}
+		*max_power_limit = power_limit;
+	}
+
+	return 0;
+}
+
 static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external[PP_SMC_POWER_PROFILE_COUNT];
@@ -1539,6 +1576,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_fan_control_mode = smu_v13_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v13_0_set_fan_control_mode,
 	.enable_mgpu_fan_boost = smu_v13_0_7_enable_mgpu_fan_boost,
+	.get_power_limit = smu_v13_0_7_get_power_limit,
+	.set_power_limit = smu_v13_0_set_power_limit,
 	.get_power_profile_mode = smu_v13_0_7_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_7_set_power_profile_mode,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
-- 
2.25.1

