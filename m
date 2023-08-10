Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20579C001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 03:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EE110E635;
	Fri, 11 Aug 2023 03:40:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C0710E631
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrmfilnuOyqNXc930dSfXhlgni5iukxdKOiKbySSIKVKI5JPH4emtwPUpCzeeqyPoyMTnwxUt55ylyNCTUqbHTv4DGiw/VvbYvsrVYE/v5sBE7Vthhep9hJ3BM8DQegOFcysM10gaUTjSpIbjrKT72GMDDfTN7qFi8eLcBAXWwau49PR7oZPRu4laY3nvrdxZ/bddHDAszBC0uMAJM36pQ4pldUCFjW1W5fxVYSjp7YFxFOkFAIC/AKarB2PoRAsOCnMROImtdJzjn1QS5mes9cBMX2fG5bvH+cHCdS4Zjbi2H4giaaLWNm8JLR1tDL48vLEkYPz0C5iAulpmL54Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeS6PTMqZj4N3/MCfGCGn4X3q8/lMY7ssNOpglga3y0=;
 b=iKCXTXgkMGN+VkNnxMz8+AcaZHMdp51ZRP1iFjnxa7ftE4jSRArPiJidYVi48+W85UR/2pTJVq3/jkTPf+UKW+PsYG3+FW5/3MBHaiNTZfZhnV33QhgC5BDH5OMVzolA7n2gYaOkOMj7cP0Qvwk4sgEbBNDQ+1B1so0+uXzB+uJA5rEUY4tj5E/Sqem6FEOnLkdUP0qm0iPZqYUiSNRv67kd/wvVECU5E94XftaujDfdkBUJVFDklsqwr85qiZVAd5SczOGC1upr8Emxf43lXwJRbRYAE3XkzqDuZnsmtzSZg2yJoAR5nxlCaN8wY46sFFCMPrXO7KsKo2UpfkCB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeS6PTMqZj4N3/MCfGCGn4X3q8/lMY7ssNOpglga3y0=;
 b=oxoEPgO+92CWWHR+W2xG3u1SVOBkKiA42yqgUKi+Hb6DlsscijEJVxjenKpzKMX/oBV/ogtr8VD2G34I4f31iwJcxELK2FVhGfrOkFN8gU1d37LdoaZfVZhArX/RLtJP1+mVMXopISYkxTCAm12p94DOn6q4hZHyErEaumGGPlY=
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 03:40:46 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::bc) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 03:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 03:40:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:40:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amd: Drop unnecessary helper for aldebaran
Date: Thu, 10 Aug 2023 05:31:58 -0500
Message-ID: <20230810103202.141225-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103202.141225-1-mario.limonciello@amd.com>
References: <20230810103202.141225-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: d0be91e8-39a9-4653-4366-08db9a1cbf16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZdMJK9SoHmQKON60iIILhAAIO25Za77iU1UIwyp8VorAhBLcHw28kq7nzqzRzxqo7gICL1iIG0g6QVosRmTCB1RMY0lENsi3lZ2Sxg2TsoDN+qbXDAdMxrumwe0KDlI/jTRx240jtohG61F0EHyAv4781QNXiCnxfjIvYAPCh2jwXso8+DKX/fQkPMIUVAaLfYStp9r5fKdJEtCzYtfP34M2qp5Sgwqgb7txssryjCS1whmaSuwQNSjtbPAqvFVa8JDvAk0H6qeal1nw8wgM8KHUEx4qfUtU5n6wfZ3AszpzUS3evECG4kbN3ZNxfA0ONHz+2oxUecOgHFKVAq++RMJaTWinZec3D1ZIKTNuoFIRhKJ8ogdjvBcLVyuv31gCi2pRjQnVNqX2XtaXhXfTWZ3cgMANhrIJ9uVQmjeWlKcdwnPvC7Z1a4oqEIOrubh9HF1cNc8hga0qBHnK2jUcbgILg+98L4yJ3g4+klMVjM7SM9IHXdVxhpDf7uhot/IwGsR8REchyAmJHvSlDf9yd7mMxEeSCzP+GZ+uGuBXjzI/wMvW0BE0yC2SF+GhJuDVT/Bg4ZcLOfiSniSH8KOlqm77E3qL4lfJ0hlqLcxpyWNjx+a34ejWrQpyLkCG2lwg4VyyGXH0oWfsaZLe7dGcTkyDIjrSqbHOFOdj2ulRzaAEUygejka8NNQtpHhnTrQsx3mdh6t/6nTCJmTWa66iKV2AAuqyWfO0hXGI2cJVyyUA288NQmpgXVw1kwYZX4Fkembdg3OU+kjR+FIpgfZ5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(1800799006)(82310400008)(186006)(451199021)(36840700001)(40470700004)(46966006)(44832011)(82740400003)(6666004)(86362001)(478600001)(1076003)(5660300002)(40480700001)(26005)(36860700001)(316002)(4326008)(6916009)(83380400001)(8676002)(8936002)(41300700001)(36756003)(47076005)(70586007)(70206006)(7696005)(426003)(2906002)(336012)(81166007)(16526019)(356005)(40460700003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 03:40:45.7007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0be91e8-39a9-4653-4366-08db9a1cbf16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aldebaran_get_gpu_power() is only called by one place and just calls
aldebaran_get_smu_metrics_data(), so drop the helper.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 4e5043b6ce40b..0dbb1a1c25d24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1094,16 +1094,6 @@ static int aldebaran_get_current_activity_percent(struct smu_context *smu,
 	return ret;
 }
 
-static int aldebaran_get_gpu_power(struct smu_context *smu, uint32_t *value)
-{
-	if (!value)
-		return -EINVAL;
-
-	return aldebaran_get_smu_metrics_data(smu,
-					      METRICS_AVERAGE_SOCKETPOWER,
-					      value);
-}
-
 static int aldebaran_thermal_get_temperature(struct smu_context *smu,
 					     enum amd_pp_sensors sensor,
 					     uint32_t *value)
@@ -1157,8 +1147,9 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 							     (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
-		ret = aldebaran_get_gpu_power(smu, (uint32_t *)data);
+		ret = aldebaran_get_smu_metrics_data(smu,
+						     METRICS_AVERAGE_SOCKETPOWER,
+						     (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-- 
2.34.1

