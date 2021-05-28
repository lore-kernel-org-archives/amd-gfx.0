Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028E5C4708D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF62B613E3
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF62B613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54ECB6EEAE;
	Fri, 28 May 2021 20:01:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2E66E8CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJxxXcjq36ORQZ+sx7LNgeXOtH/IoLd3ApzOCP+B9xR88X/AkOYKsK3rIAhTC4ErhdGukM+fpG3d57pMEfEUpfHXhBX/KsSQj6TDDBT8EbWitYLPGx3ogjttdNSxMM/A3HaInoVD6nHDr8MSw27oy5Zq03eyegR0Q4HNMdCa3Ho8Azwspwf8Cg/1pKdNfg823uKTyWcChTrEJhZxsXPotDiCarOccXMWWcpn/t0DuWZOj453ipzv3JZEh4zQpU9v5YIysMENe+jjUyzeZNBxHwVnlgy0uDVMB22HbCjw8kFbkaUYM2zE8DU0qUktQMyJnRB7ridqZrk88IskS+b3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSx8baIE0HccZvS77ggFB+V4Q1t6SZLWmDES4eUAR8E=;
 b=j8y5FbkkQ+SF2aue5cxxFSK+Q+rTTkUai6jUbnwKMjEPpxSxSXSwoqrwyPsmglIc66f3ivUm3IVN2pZw+VCRIM204jtzPdSiu8yAPqTWUE5GLsaEmNJBCOCfod4hZx45wtdY/j8iuF/BLz3Xc4yOOqADt3gy07hpK0mJFwu8Hc8EkWF5ygPoe9fldpLhS1PRBJQ4442uHGrHi2w2Za1ptfIu9PS7fXu7uhR5sjU7g3it06Ko329WjjKA3VfOqGxK2XjW2Wo1FwBdUVUe6bloptbWInJhYl0zG4Et81280RaQ8AHdRd8aDf7r1UjjNsvm8JnaLNdE21wRRH9WwwG4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSx8baIE0HccZvS77ggFB+V4Q1t6SZLWmDES4eUAR8E=;
 b=mhz/VUCTuq1Mh/yAVyn99MEQCdPCBbPo1MR1ujecsKRQh6xufHMGqZpUHlwsFAO4KROfSQRRrDJB9XgojNnPz3tzZoxhjsSVvrgZj/M8xU5nPmhI3CaNnfDKCEjVlPgIbnnST2rGI2QNmsgQUDClJPvTJHUi7fZWYpa5OFGF1pw=
Received: from MWHPR03CA0024.namprd03.prod.outlook.com (2603:10b6:300:117::34)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 20:01:18 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::75) by MWHPR03CA0024.outlook.office365.com
 (2603:10b6:300:117::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Fri, 28 May 2021 20:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:01:18 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:01:16 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/8] drm/amd/pm: Add navi1x throttler translation
Date: Fri, 28 May 2021 15:58:11 -0400
Message-ID: <20210528195815.2615-4-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528195815.2615-1-Graham.Sider@amd.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8de5ec95-2c72-4cc1-2c24-08d922135bb6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28110B0D5E1D31D9CDA7D5FA8A229@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUJzjhGDb1pU/VwVdD+c6Sv0llsPGjsYh5KR9pVLNxHfKWVIE23EvhtLIsQrIjvIK3y9Jlo7F+aasrM6MQrFE/HLWZkd0+pVuqs9Nfrw2scCBqon675VQjwxG0aTwAiCv1ZMP2RHXjC/OCNuC7pSLhCdbEksJcRAfEXdJYk+21L2N/UHYrqJxu8kypALCqkcO2un37d2mYxD/QDLMpMZ9Ocnfs2RLosC2iFel+AQSR84CGmCjF98MYBbV3LWeIiMkxPkIoF4Yd4E4dz94VzVGo7y7nGd0zvIOIDyVlsmf1FCeMaPVojvDKWaHvkbCC6HoyRYvUTI1UIzfBVwXrTDPjVmBJskC9mgFfObkBcK8su3hypHF9vLqHhMlWst+vHtH+G7/xO/fmW0et8DTaFyf0Zs7XlGDTcO+Hop8wUVCo0q2n5QzFB0FFjd3jAKlGouvwKzLJ/Au2qhnUCXO7E3NKFeCx1R6wPrKx1XCYS87CqhUYVusR2mrTEmsEgbGw0gqNV1PzzlTkPzlEQS9VX9LLjih/eLSvxli0M5YtNOJ9UqUztuRpNcNm/zhoFY5yRvzWEXNUwkHwLLPxx1sdKeJNC4TdXjdZtNK9+fJa6pnhLVmrUqqT0FgOe6ZJXBt4tt3CF9of7CHvAv301Z2X3Afpw2Q5LtDF9TEWcM+VihC2/ZsAYbC7t+tTc2cuXhyem26WyJIiStw1OSiDl3gA9YzuSXjNWAS9iB9UqhulvJeEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(70206006)(1076003)(316002)(70586007)(82310400003)(6666004)(36756003)(6916009)(54906003)(478600001)(5660300002)(336012)(2616005)(356005)(426003)(2906002)(82740400003)(16526019)(47076005)(26005)(83380400001)(4326008)(81166007)(8936002)(186003)(86362001)(8676002)(36860700001)(32563001)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:01:18.6375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de5ec95-2c72-4cc1-2c24-08d922135bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
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
Cc: Harish.Kasiviswanathan@amd.com, Graham
 Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform dependent to independent throttle status translation
for navi1x.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..878ec698909c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -524,6 +524,54 @@ static int navi10_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t navi1x_get_indep_throttler_status(
+					uint32_t dep_status)
+{
+	if (dep_status == 0)
+		return 0;
+
+	uint64_t indep_status = 0;
+
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_EDGE_BIT, THROTTLER_TEMP_EDGE_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_HOTSPOT_BIT, THROTTLER_TEMP_HOTSPOT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_MEM_BIT, THROTTLER_TEMP_MEM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_GFX_BIT, THROTTLER_TEMP_VR_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_SOC_BIT, THROTTLER_TEMP_VR_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_LIQUID_BIT, THROTTLER_TEMP_LIQUID0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_LIQUID_BIT, THROTTLER_TEMP_LIQUID1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_GFX_BIT, THROTTLER_TDC_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_SOC_BIT, THROTTLER_TDC_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT0_BIT, THROTTLER_PPT0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT1_BIT, THROTTLER_PPT1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT2_BIT, THROTTLER_PPT2_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT3_BIT, THROTTLER_PPT3_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_FIT_BIT, THROTTLER_FIT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPM_BIT, THROTTLER_PPM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_APCC_BIT, THROTTLER_APCC_BIT);
+
+	return indep_status;
+}
+
 static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
 					      MetricsMember_t member,
 					      uint32_t *value)
@@ -2673,6 +2721,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2750,6 +2800,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2826,6 +2878,8 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2908,6 +2962,8 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
