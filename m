Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3DCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 08:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A885C10EE15;
	Tue, 25 Jan 2022 08:57:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C5410EE11
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 08:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyO1VZma+671yYwIIQJwnPIm4Rql55NXQIklE6RUVbzlHaNxxhooBM9TKDCvZD/5S1bpLYXriJ+FGrPnZOsSIXGhe42p6eusYAKR08OoCfRDtoyzge7LDxwydKZeJaqPjlPNHQBEkP6z5WRoiRHRi2EoDgU6Qd/xmdGQ7cW/HTYegSq1oyuwIZaWrAV3wb9GqVtnQ/Y6vn79GRmkuL6RjkL9iPESuCjdO+sD0xwZwNdNCy2SABwGA9t3OUNAXM5ssm5uj5UclieIsv6d3TKykzP8ySq7Shxl8CMVhFACASWNh2ygGOuWFDXY4KSRZsJoWkr3NxO8zVppDaVDsEx1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrRdkpgZeQZEoWJDtKY7Y6uenIwMg/mdwJp9tW2dKl4=;
 b=oc5rXle2O1ZuIMJvi7VxcdnixSUnKsSbw3l31+LCfclLDM4gJ0sPpT8DGSeLYfjzJNWml3XyIPEtew0VzgBBkwuGKTiU/2pue9WiKS+onG48P36wIUYz5O9Ny3nU6XIQK9lFdonNjdOcII2Fezu2me2NxfsYMqfcJo7XbzX565R75jkvrEhtvKbH3iKWTWUlRviCM8tjwTqeWoelNS1G4PChWD33UpQC4H23qjqx7VrMg80+IbuY4tgz3jwWuvQVmTtnw73S1L+aFu84q8SpbsEiNDkoZQflNGujK1synyHLj1Dm1HR5HtgkQDkAxn5Ndhx6snLokiO8pClYFpj1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrRdkpgZeQZEoWJDtKY7Y6uenIwMg/mdwJp9tW2dKl4=;
 b=byQ61jxrdNcBW6unO+Ggv8ra9cXDDh/fqUsGvrOZHFgYYnu+195mGe33l66HMGdI5FMT5BhJl1Nh698fDDS2i7adavNDT3aqpyjshblvX464flRYUN2oIEUa+yK0AhxeJuwiu8J2F1krPEmHyknNMsxnMy5CQBvzZo0RzWc3up0=
Received: from BN0PR02CA0053.namprd02.prod.outlook.com (2603:10b6:408:e5::28)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 08:57:10 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::8e) by BN0PR02CA0053.outlook.office365.com
 (2603:10b6:408:e5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 08:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:57:10 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 02:57:08 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: correct the MGpuFanBoost support for Beige
 Goby
Date: Tue, 25 Jan 2022 16:56:13 +0800
Message-ID: <20220125085614.101348-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c3fe45-c35e-4fdb-b25f-08d9dfe0ac4e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB524637997C37B16C539E624BE45F9@DM4PR12MB5246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJNp4TuGv04waBAb6tMMou98c+ROetXNNdsVcTbtaIgJRPmlgAEq2/wvDCWkodXbuzDXolTxxy+4XAi0tgbNPYpdd8/yUCsQFPOMapfFPpI9LPiPuoUUa3VSSi1Q0mw1oRukfa4fr8cMelHISCDMJ7wwPMYPXq3HJTKfdipnse+XlNqGc1tuaWERz+/fIY/iC3iDG29lSH70yqOJRN2zQsGVxkkzcTNWCCqPM/e1vOhYPPBlnLk7HA0DNQM6XX4Wofyhek2KXaRnZkHUELPtcAsr3OVa99oWanNm/P5t2pbmwa+tQizUXRsB9iFvo7B6WnwB6GHY9+GTzkevRLojdXD1KcXxRYJr3BlkEYeYDTSVt+MuEXO9SgZQftkQymocxlgeVykmeFyatjYYR+gSuperW2OO4b5MqlZnoPPlbAknvp4Io7iZGrUJfazHfSFCNwfYxuamK97uQ1eZIJ70sckWEfrIgCmFeptQRQe+2dQXlJIWGovoaAssshsqYu9eK0MZZ7ihH3hZF+pQaaRdbgnofQVELC0h5WWN6OvFPMhHebxz7qpC840NUUZ8R14ylgNNZtfi2IUmcIvxtEa0QnlLzfi2d23xrTf9iGoCtZSO4JpiqM5SzkdjcfqmbkgFjUtyUmme5P7SWxEQvsc8bno2ZbcglJTtF4/JfNsBG2sGV0Jw0UE11Jj6p5UvqZowaOQN9GUjbJ0DdGoCnx1ObPcmS9QUkJgtB/rFwgSLplVSs6+Z4xJtfYk/ITvJFPqAPs56t94lHk7ItP/kPwbcJMc10EV2zYNpHS00JXyz7jA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(336012)(1076003)(316002)(508600001)(16526019)(186003)(86362001)(36860700001)(44832011)(4326008)(426003)(26005)(70586007)(356005)(8676002)(54906003)(2906002)(6666004)(70206006)(81166007)(2616005)(6916009)(82310400004)(5660300002)(8936002)(36756003)(7696005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:57:10.5830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c3fe45-c35e-4fdb-b25f-08d9dfe0ac4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The existing way cannot handle Beige Goby well as a different
PPTable data structure(PPTable_beige_goby_t instead of PPTable_t)
is used there.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I02208c011e93c4d37769bd022e65e9084faa97e4
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 651fe748e423..dcd35c68e59b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3729,14 +3729,14 @@ static ssize_t sienna_cichlid_get_ecc_info(struct smu_context *smu,
 }
 static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 {
-	struct smu_table_context *table_context = &smu->smu_table;
-	PPTable_t *smc_pptable = table_context->driver_pptable;
+	uint16_t *mgpu_fan_boost_limit_rpm;
 
+	GET_PPTABLE_MEMBER(MGpuFanBoostLimitRpm, &mgpu_fan_boost_limit_rpm);
 	/*
 	 * Skip the MGpuFanBoost setting for those ASICs
 	 * which do not support it
 	 */
-	if (!smc_pptable->MGpuFanBoostLimitRpm)
+	if (*mgpu_fan_boost_limit_rpm == 0)
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu,
-- 
2.29.0

