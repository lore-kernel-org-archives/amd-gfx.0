Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F165C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 14:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E799110E4F8;
	Tue, 15 Mar 2022 14:08:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C1D10E4F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 14:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq49djMMX/RiiHWEQhe5sVM8lO6z6EVwgYEiuCQsmWr3mW8YgJ8IaHWBwLstibs3KWKgfH1JTHM1xTXQch1cIFwZ0C+FC4DJvupLeoSZ90ISt0u+NUyQzyd1g/QAOYBvPOsu7SFeeLT3cNCmN1jAxtdk1X4ULbDOaxY7uGxcEC9kd2kg74BTE1Y+uxH0YmIC8d4oY/G9UFaj999AZPmsP/qfuKRE30CEnXeVcV5twWnhxVUhlGTPf+Ot8CDODiCcyk8PeAKz9Ug0beiAzFL+xUjILldfKk+m+rdXyAfl//WFRrP7Km4tupJQth0mJQ36TyeqSL359Tx8hhDLwzIvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7FZpkznYB4KI3MQHzArPgIkR8F2POTKh1cyGL4JGPg=;
 b=eCU/pKnUn3jj3tT9DjXqnfN9zfNdi29yA2eu+6O+yK+xqbu5Y+s5FUUPMLFNVt+nna5/lWbXXIsJ9O6ABUqy/L55iRX/1XF/nLv/f9nx1bfzwBJ+wJZ0JjYugc8n4UJqC0UN7evrTgau7urM6rXi/4aPykXx0NJeDq0l0jILNReb/A/LliSbgHm4hilGsXqhD639aGzTgtEYh6kuakVBDTDR1S8abUsVtj4jdCB/dkeHDsV43hdFtoGCWqLAl11ZSv8LJaDDtaMg0aPq37V3tQR8bF1oNhXvXHeYrOIvRzTxmgTUBsIVemcrCsQpUim068I28dtIEywT3CHh0fgjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7FZpkznYB4KI3MQHzArPgIkR8F2POTKh1cyGL4JGPg=;
 b=FkwzgkFmdHakvLpg3UyEISu/+N4cAi1q8eyWL7w0BZeUjIasVCJ9ql7VGr5siaranPvlSKKHaTuuK9nCl5DGeNcC+HmwCLlOSx5pmqfHW8aCTi6P3vTQltAlUbv3J3ZRGQl5oqZ3f1/y1VPxs1NlNJh+esFEelDsZAjgpzipOd0=
Received: from MW4PR04CA0383.namprd04.prod.outlook.com (2603:10b6:303:81::28)
 by CY4PR12MB1653.namprd12.prod.outlook.com (2603:10b6:910:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 14:08:24 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::eb) by MW4PR04CA0383.outlook.office365.com
 (2603:10b6:303:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Tue, 15 Mar 2022 14:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 14:08:24 +0000
Received: from elenaKubuntuDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 15 Mar 2022 09:08:23 -0500
From: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Disable fan control if not supported
Date: Tue, 15 Mar 2022 10:08:05 -0400
Message-ID: <20220315140805.1025021-1-elena.sakhnovitch@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d68a7b0c-d698-478c-0884-08da068d4532
X-MS-TrafficTypeDiagnostic: CY4PR12MB1653:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB165318F41D95B3D011A52910E0109@CY4PR12MB1653.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5WD4qBWUshAFUYA8iEETiCcWnoHLgn4/QUwlmIVQmChn4WkS7VEKRS8yLIOjcEl2qA7n0FqEtysg0To3p3Gupspmqm72vlD9sPJia9L4BYLrPGAqgd64DS0B+Tl9A/gUt3vmh3q0RO0v8mUmvP07k8ainJ2OhoF6LM5+CLtWRvGhLijrucJZtqYP331lb+M9Tkn0qQnvT1LF2HgzyHDa7LFWG4dQoIkZcm0knCkOftBLvIAIiyetm23D5sg1UGpFPuYLVaK3nsGqNe98g/cj+vxQSnAV7DtXJCOYLaTpv2xdF0QQEUFjuy0BF8CnCfMsyc1/yNv5LCA//GngRP9HC3MR1sROjogm2fXs2hvdfshrgPmVcXVbgjhwGH0TB9YtTxYnP05JwWas482lBcgQENd7APdJQp9YuwJYL3c9i5++sNd2sD5HS0XK0tamfoDxy5F0Q8QKbrYqXEOQL4Oakft6XatWNd0G+yzV8Y7WcbLyLLY44JRQgkxfPlpqGqd4Wzd+s+Yrt9oy/NKCwZjgZJ4MOvRoyIdNoNNSPqG/thlI/Ss1c29Kkw1toM/YvgNYZIAbe0e+UJjkYoSC8AY9PiiWFs3rAw5K5rXbY4/CEvOeJdlLnaNBE/jqeKaqoCD4CS+E8JyTGbKvGhyOX293YJk5FT4A0TpnpHVdORMrWdNMsJfH44F/DfiUhRLLALyDvEWnMF4JqMLu/pc7SxDIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(44832011)(508600001)(86362001)(16526019)(186003)(1076003)(426003)(2616005)(336012)(47076005)(36756003)(8936002)(5660300002)(26005)(4326008)(2906002)(36860700001)(70206006)(7696005)(6666004)(70586007)(6916009)(316002)(356005)(40460700003)(8676002)(81166007)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:08:24.5533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d68a7b0c-d698-478c-0884-08da068d4532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1653
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
Cc: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sienna Cichild, not all platforms use PMFW based fan control. On such
ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
knobs for fan control also as it is not possible to report or control
fan speed on such platforms through driver.

Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
Change-Id: I42f9eb971a61a5ad63327607479fc7e9d9d6914d
---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 38f04836c82f..23abb1d1f677 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -371,6 +371,18 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 	}
 }
 
+static void sienna_cichlid_check_fan_support(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	/* No sort of fan control possible if PPTable has it disabled */
+	smu->adev->pm.no_fan =
+		!(pptable->FeaturesToRun[0] & FEATURE_FAN_CONTROL_MASK);
+	if (smu->adev->pm.no_fan)
+		dev_info_once(smu->adev->dev,
+			      "PMFW based fan control disabled");
+}
+
 static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -381,6 +393,7 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 		smu->dc_controlled_by_gpio = true;
 
 	sienna_cichlid_check_bxco_support(smu);
+	sienna_cichlid_check_fan_support(smu);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
@@ -410,7 +423,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
 	memcpy(table_member, smc_dpm_table->I2cControllers,
 			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
-	
+
 	return 0;
 }
 
-- 
2.25.1

