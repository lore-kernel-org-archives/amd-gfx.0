Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4449CCE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 04:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A19110E1C8;
	Mon, 25 Sep 2023 04:28:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDD510E1C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 04:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjRVaSUbFmsb2se+J1Nk5HrQvrvd0ZrPRt5nz3T3V+XKYrydasxHcXrIGjIFQiM6lJV9opYoflu44LTkYk9YWKdD5ySQH7C1ZbYqaUaJ3UvUl8FQD+NwUCsvpF6PodAgQSa/3dyhkiYC+LY466zvKpDAmzmpXiEEEnEyU8kFCD7VuhRXS7DIuURLu7cWmJjMEz8nB9v1qRdPugxMLtidPPi60R1aOcPb4bRG3ujT0SuMuGpto+OiWxwzoQTvRGdfJnWKerSdJvyjn7F+1+KrRuTnH5M/ohMAYF9yXgUwtBx1UpLExbdlcNX4w5uXGWi75d18WZaeeKD6tGiZM17BYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkvg9an3iKAYRZ2MSdqA6f+k85CliZpQx4lfOOdADYM=;
 b=dIYchIDVjXlNP9YQN+5S8GLFCD/NalQBc5k4+RbRy3rVNokHlIjLXJx+UzM0Khzp8FxwRz44G/A8QY5WzFq7PSSFrM08UvHnGRdjDx2wMSmQ5kDNtFXg7DmrtpwZigr9SA+NrHby/VHffuE8vA7FYVRwv2XVZW+2tnSB7wriuFM4xtFsoKRyYCCGbbi5BIT9WGEh/q1opu3wE1DR6WjvJvPU5laYiXr5Pia9AM/NXqaqVZNNASEulDEmAcTXms0xXfdpUU2ze0MuY9f5Crljipvb2XTuxlzTHGN4c5CLBhlIgXhIigh2+GbK06wNrrsBo5USvLsTyzBSwD9i8DVpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkvg9an3iKAYRZ2MSdqA6f+k85CliZpQx4lfOOdADYM=;
 b=fQIBBntbqnH2gDWN4Mm+9+cEQH8UMzhekDDCHZdZO8oYfREkgGCKAOJ9OtN14gwzT+F8VFsn1AcrsxPV3yqOjjL2O+aGbHpS4XXFdrEnEQSA/vHD3uv6GRUXN0pLJSVRqSKo9JatY3eBCfbAzl4YN+pp0lrAJSGNb2jY3z8bEtM=
Received: from BYAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:a02:a8::17)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 04:28:43 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::ed) by BYAPR03CA0004.outlook.office365.com
 (2603:10b6:a02:a8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 04:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 04:28:42 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 24 Sep
 2023 23:28:40 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amd/pm: update pmfw headers for version 85.73.0
Date: Mon, 25 Sep 2023 12:27:46 +0800
Message-ID: <20230925042752.3847-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: c2170387-1350-448a-93c3-08dbbd7fe665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpMc11gA5o9jrEFOykMD8zUAsZ6f7B58EkxPu1j5V2BOgh2u8bnpLBMUwWHb7XaR18VVixFbYMEGvZgx2VvdkzvrelTYrSK1caelXxn5/9Knk+jHfe/sO4xqUrz4G51yQSJoAmx5czxqOzvD/lTPwWcRKmmCckvio8oPtQ2POk2DySmW3kGWdEd+GvqU6cBVSEL3dv3rMnylpyzN+rLuPUF5dVVlvA93g0AswX5Eizm1/4H/L4segKiOimxy1Nf/n1xaWxyFuuLlC/32S6g3ocolWc/tyur+FO3HFXyEsGC/MFO4WQjY5Pdwn8bF/9nq/2hWyeh0dPs0MWvvaiUQ3TjUa+/vmnA4ZOb5xw82D7mv67bubhU8sL3HPWBjY9Fw0+dvzb3LRXshSNvlFzIcjNBi9Gf35opzy5uFSxI+29RENFfOcVjQu/z3Z3aqhkmqIKcP22Gt34350hIqs1J4MJrJv+6diuoGYVn/rtKEenlk4ykmtQz4np7Zw8DGRk+5IiFK/ixYR3iLgr6w/kZ2b1Xnuys27DVXo5dZAAqRCJyrKy9wHzK0LutVnp+GY3tcj0XY471588bBOowJcvLUCkpVOW646hOR4JCO9uQ6ZwsFHjfZZJnrFRM4YCFKunTzHhBhCW/lrh3RI6w7iQT6R9EpDBsdXLAcA3JWPfkkF+lxNrWTEZL2TsybzCtn/hnURsH881hbDSXQKRMQCYPSsfwtrnUQ47ABmEv4oDgBKCcz+pCL3q9lPee3jn8dADfSTA5+TEYw7zXRfmU1smWv0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(316002)(8936002)(6916009)(41300700001)(83380400001)(40480700001)(44832011)(15650500001)(478600001)(5660300002)(2906002)(70586007)(4326008)(7696005)(70206006)(8676002)(54906003)(1076003)(2616005)(40460700003)(16526019)(356005)(26005)(426003)(336012)(36860700001)(47076005)(81166007)(86362001)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 04:28:42.5407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2170387-1350-448a-93c3-08dbbd7fe665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Asad Kamal <asad.kamal@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To add message to select PLPD mode.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 021dcbe58473..509e3cd483fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -90,6 +90,7 @@
 #define PPSMC_MSG_ClearMcaOnRead                    0x39
 #define PPSMC_MSG_QueryValidMcaCeCount              0x3A
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
+#define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_Message_Count                         0x41
 
 //PPSMC Reset Types for driver msg argument
@@ -107,6 +108,10 @@
 #define PPSMC_XCD_THM_TYPE                          0x3
 #define PPSMC_HBM_THM_TYPE                          0x4
 
+//PLPD modes
+#define PPSMC_PLPD_MODE_DEFAULT                     0x1
+#define PPSMC_PLPD_MODE_OPTIMIZED                   0x2
+
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_MSG;
 
-- 
2.38.1

