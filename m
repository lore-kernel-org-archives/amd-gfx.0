Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA3BC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 08:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8960610E45A;
	Wed,  7 Jun 2023 08:03:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A2E10E45A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 08:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktFgLnuhq/32y42GclC7sBJSWBiZ+JLF0jYih1Nyx5EdDClFyfbHGQjMJHpAFYaQRA0WZgiEHLdGGX54wZ4OOH8bwuuIIKUmjXDfmy93hLTEtnuAWE6sRJ8BwgJwbG3s+CurlkJyJphoVUXXSi1OfAWz6aIZNrOOic18GKqdPvhP9hIKwYbft42jBS1o6tgXmq52JUDy5BpSb+nbaATcI/Rzp+PrpmzaZ/Q9rmgirhj18Hz6AzXgO+fNw03HMr6di1lxzGutAdlbIte7I1zPUo9fEurS3in2/QBA9nQR6UHqDs6aikwKKyjUmPmnV2UCuB7M7qhMIWKaOyKZuQEA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2+MaKwBCDP4Ak5yko+911qzIBInQTPg9bjhjRl313A=;
 b=jKYexIiZqzi+84l+6RRvQXn+bXFwpJyvkVwXPfPASK8RzRFrQBDSYqJwvPHqZEFBo1aStzAg44dG7G7W2UuvD/1ujGUkfEevRpbW8CcdWAkLT5eAE0qAbdVbDKSWpmHaCTNBmOzYFj3oAGSwQWc9ZCBRnRrBzQmKFrdUXNk5StrZltB+83hYo9LRfTgCdPGwNUXieguaoF5FIVG6k+KHKKfelawhZaYU39Y1uaByYrdNvMGEziFZrjVGKeCaUNfaJZNoeba3fGL+hS/9EVfnIeuZgkwns6TwJN/lwKnjbgjdJ9XhmMJoWlAsm5+pQ4n9i7GLl/HYpjWkER374IAn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2+MaKwBCDP4Ak5yko+911qzIBInQTPg9bjhjRl313A=;
 b=OcDQsgY/qjiNG9tUV7Fel4jK89zRdjpAPXoS4tRLwYDZ3lJ3pLLk4ItX/3OvdOu3ARpUfVL3Sqa8rHvuCIcb+Qs78QES86MB6qMMuinWMQ3mih/AIRzplaMM7Gi6tgqW72bwBo6YVstMz47LOF8EDLkv49QF0TMXRE/aiVHnYbs=
Received: from CY5PR19CA0054.namprd19.prod.outlook.com (2603:10b6:930:1a::15)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:03:40 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::4d) by CY5PR19CA0054.outlook.office365.com
 (2603:10b6:930:1a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 08:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 08:03:38 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 03:03:36 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/pm: fix vclk setting failed for SMU v13.0.4
Date: Wed, 7 Jun 2023 16:02:28 +0800
Message-ID: <20230607080230.3867810-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: bffe4bc2-159e-44c1-6328-08db672db3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sn5+1OR7MQWXuOksHdPC6LV2m0kchSJsBqcx2uHTenVWcVpdWnGnt2CKiJxP6UDGxRtFdWYKdah2U4bFSRfLRumjdwSVdH5esoeCfWD8JXZWSiWoSPWsL35kxvn/soDGsEYS6XIIIJWLmEOvHTeYgWGs2b5oc2h6KC86zNyz4maAMm+TOH5muxOqfLBRF3GcUqCyUz/Jhk6YH6O2eG2D28SclV3oZLBuJc5d2a4nfkl9oosQFuvvqaq7WyYdEdNmYlySWXIhwZD867uoAkzVcmFHegJFMv9gsyoVorsfqPdFzAAinAmBDv9uJZSr9PTsYg8IvcQU5PE6vsuyRDkp2bugjl6+ZGo3VPwaPf7uxCkkDitfzA0/6pR+euwyNTnL2NNe18bbBlrwjlfaBKuNv4G4o+VCFI+y60UrousJvxRBFSIejC2/NWJWq3W6HNnbPwhKBF2wTaxJkaesnPVli+z4L/kD+FWHeQBYF59rHttmIB0x4VgBn0MqCVCu7mfbh6pQeXaO5tMt96VmDk8K1ea3xy3bYiTY9nOgNumceok40l9coBGUi1YNvc8lE60rxJ28PApS4YJd/3UUYklyEOA+WjYeqP0g7myvntnYoNrnSE0HwLIMLBnWrvu67OpylpGKDhxdgHjJMo4hflCDFo9VHYMM2AwyLKr2kB7mpME8KGNbsCyCEqF59264FjQ3Yr+7iYbPT52eY7AMoxsAs9Vp716w38kvRMIGquUAaXB2n5NXn5mvsMZkb4KuYSQv7GgiTaNLxXAoAi2Vdp/QKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(2906002)(40460700003)(7696005)(36756003)(336012)(82310400005)(6666004)(83380400001)(47076005)(2616005)(36860700001)(426003)(86362001)(186003)(26005)(356005)(81166007)(1076003)(16526019)(82740400003)(40480700001)(5660300002)(316002)(8676002)(8936002)(70586007)(70206006)(4326008)(6916009)(54906003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:03:38.9406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bffe4bc2-159e-44c1-6328-08db672db3c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, aaron.liu@amd.com,
 Tim Huang <Tim.Huang@amd.com>, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW use the left-shifted 16 bits argument to set the VCLK
DPM frequency for SMU v13.0.4.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 5a99a091965e..6a0ac0bbaace 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -51,6 +51,8 @@
 #define CTF_OFFSET_HOTSPOT		5
 #define CTF_OFFSET_MEM			5
 
+#define SMU_13_VCLK_SHIFT		16
+
 extern const int pmfw_decoded_link_speed[5];
 extern const int pmfw_decoded_link_width[7];
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 46a8a366f287..999b07db862e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -831,6 +831,8 @@ static int smu_v13_0_4_set_soft_freq_limited_range(struct smu_context *smu,
 						   uint32_t max)
 {
 	enum smu_message_type msg_set_min, msg_set_max;
+	uint32_t min_clk = min;
+	uint32_t max_clk = max;
 	int ret = 0;
 
 	if (!smu_v13_0_4_clk_dpm_is_enabled(smu, clk_type))
@@ -859,12 +861,17 @@ static int smu_v13_0_4_set_soft_freq_limited_range(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+	if (clk_type == SMU_VCLK) {
+		min_clk = min << SMU_13_VCLK_SHIFT;
+		max_clk = max << SMU_13_VCLK_SHIFT;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk, NULL);
 	if (ret)
 		return ret;
 
 	return smu_cmn_send_smc_msg_with_param(smu, msg_set_max,
-					       max, NULL);
+					       max_clk, NULL);
 }
 
 static int smu_v13_0_4_force_clk_levels(struct smu_context *smu,
-- 
2.34.1

