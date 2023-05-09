Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ABEC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB94710E3F5;
	Tue,  9 May 2023 22:07:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E16DB10E3F6
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOmQcbcQDHqHDS+svTKHipEkFSsGdRdT6KpnJTGzHIOeh5MDa3nKCK48Wxr+tfgY1f1eu2sNVc2EnEPOO6ljYPfAL2tOsEZgAkBonjDGACcYWYPnqDWu0Wj55DUp/yKmE8zisPuEE5VhN4HAPLuAL2iKFUpbuPadl/UAWCGgHHawusWUe4FbqA/hWHU3dQM0Sk97TU/tvhdsPrBzQcE7TAsePqn1Uf520xK+XLZ1ie2irUxENOE6SZ+Ija9ikGuk8RqVDPe6lrXINY6KJRbPDE6K7+iC/vydwhOGzYyjZ2jITH5oIhve+ZamSeutjPkPbHg2e7/VuG7raRfy4X4oGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB+sBg/wxWVreoUUKlE7bPWDfJsdT/86/j2JmGOMPuw=;
 b=DB0EwLjw/nzMXByUOhX9O5or2VqN+MSR6VCMKxO3PDQKCARkIfXzhIiM4HhZJ7Hv9VA5k46ggtLj4R2Q18RVRFiJD/Kh8i50h65eAKLxwl6/VL3zizjgRW1AQBKLWZQHaJfEP/lmeJ2njWqRGmSaw8QpO9SFW80OkVi99I9OOq1Ja34XxWygm8Ei22pzKnDJE08Osnt9Y+7Q1I2+EGb5nre6pYKgc1qHq3SYj+WWZrIIzPj0ThOQKvRVscU2qFzCi2NUqro1m2bb3RgVkCX+4jsdXEolR0siVqic+5zfLM4TBxJhfyPuCGY21dqBI/JgFKSg0XMIs2IS/2ry4cmCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB+sBg/wxWVreoUUKlE7bPWDfJsdT/86/j2JmGOMPuw=;
 b=TAADyU2YObjwvFtJVzHzQ40NifFBIh5ECnMj7fmk1REPfH6LwjbHDIKltm9QX+zxz2fQdVRJdBFcYmej28WCqwmV4ayGwL/1DJkfkqoZVYzuVfC2f4z4AiAs36gHpgyGnyU9BTE9az9ln8hbtCS69OUArqXz5cRaZ2lcCf2+4rE=
Received: from BN9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::31)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:07:28 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::8d) by BN9P223CA0026.outlook.office365.com
 (2603:10b6:408:10b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 22:07:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/pm: Update gfx clock frequency for SMU v13.0.6
Date: Tue, 9 May 2023 18:07:04 -0400
Message-ID: <20230509220714.475369-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5f342e-c379-4de8-7dc5-08db50d9c6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HsEPHp+I2J1XN+v/9e84z9FFyleTtF1KDwJxriiRVdUfCOF1DFLKfNAlfK8mrQKb2XdC9NYEFWnXVu72usxDG68OLlXPX1x9R88IReIMCF+KwksJRrJEzZ5oBxtliObA2UXa2ziNw+DyHHz863w3Wzq5mjg2fRHoZ2rA15tQHZc4cmWI2nq8uruzrhoj6zXLZJqjfIVk3fiFca85AG+Q++9TuOFSf05D38/4Z5TmoNIt4xk3xx5KcR657sDCYiX6t70rwUNsM+z/TxLK12bfpEyZc40fe1da4TZ4wSG1cV+DjLrTTgItGH3Foqt+cucS9X92fk2x72po1xRkYAFHrKPiD4bn19fmNmX9/AScZZTwIjLYZ7dE/Sq1MYwDpM0xv89ohYD603QatKpQa/jg4FbZdpoTUWph+sXSba0G3aZudkyMnY7PrhUHoNlQM4XbMUIJNAxM9MpEn2mDcNH5Qj/wrhC7S6w03y+i1/OnxUBHOAYs0VMzUUFA3u4z9To5J71E8+BDo0rCDqjEsk44XlStNsDuZ2lHJbIWtD946xklZTknqb8n4Ji/CAj/V445moKWIpipvm1fGXxVYC8Q6ro7euG1T0UesGpXjs0kh7v9h4ilcAKeDAtOyCREataJelLSQ+N22fnrSosbB0atATFy1S+uEY00YnHNWPVDcaFKG62Hf9WC9H+qxS2fvBObrSVsaLqRmVAsSq4fmdC9d/cluGQxxYlrlv7VQDMdAU0PBRPWJiqDw78X8vFt885KiAqh7RKo3/F4sZ0E9yqjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(356005)(81166007)(36756003)(16526019)(1076003)(186003)(26005)(82310400005)(7696005)(47076005)(336012)(426003)(2616005)(40480700001)(15650500001)(82740400003)(54906003)(83380400001)(2906002)(5660300002)(41300700001)(86362001)(4326008)(316002)(70206006)(70586007)(36860700001)(6916009)(478600001)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:27.8756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5f342e-c379-4de8-7dc5-08db50d9c6f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Asad kamal <asad.kamal@amd.com>

Update gfx clock frequency from metric table for SMU v13.0.6

Signed-off-by: Asad kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8969b3ff5c8f..d0c49e8883e7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -660,7 +660,10 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_version;
 	int ret = 0;
+	int xcc_id;
 
 	ret = smu_v13_0_6_get_metrics_table(smu, NULL, false);
 	if (ret)
@@ -670,7 +673,13 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
 	case METRICS_AVERAGE_GFXCLK:
-		*value = 0;
+		smu_cmn_get_smc_version(smu, NULL, &smu_version);
+		if (smu_version >= 0x552F00) {
+			xcc_id = GET_INST(GC, 0);
+			*value = SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc_id]);
+		} else {
+			*value = 0;
+		}
 		break;
 	case METRICS_CURR_SOCCLK:
 	case METRICS_AVERAGE_SOCCLK:
-- 
2.40.1

