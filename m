Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A14E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 11:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A3110EFCB;
	Fri, 13 Dec 2024 11:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="csg3aNDh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F5E10EFCB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 11:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4uBdB5eBlPK4jXwUXWJWSFtEXfEpTW+phFRLb0qnEBK+SiNjSDjdU0Aj3wPGEVg2OxykBoECrDD4LXyVpFcTLLP0gtjgaNLxNF3afLvOFDVX7BTswnX4cwyUNgf4ioSBUoe378ROzO0xRKOLDVh5s5/kSGQgpMkGYf3vFN5i1ZPzEoAalUuD9QOrgYxmfDkg/DtIflpbobvKo1mBo57jiMBQeeh+w+XOkpyz6BKnidPI9gX3aVpS2HNWjvQfJ4fCA4EgrdtuBWuvAarZQKnWGj81+mfklAt5GaSB5A2OMV+EM70WzSBcadKEFXeC7gXlseBaKyEMi8VY1Sy09lTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57Yzub9W6vU4mf0dhRmLipGchVCXeFPtaUPUE+y8ltI=;
 b=mCAWyI1ahG4IneN3a4yHWwWetaLVVDRqleOxtlDafp2Rfh/s6cnsRl8Lti3sRKJ7UB/oURZPmj/ZlzWslCcvxwVYvruUqj08xN8CYc6ZyYtPGXv3R4O5lCWdPACMvdq1mmcAvlF/bWJ6s7nPFdZ37tG/10ypDWL6RwXZWaG9//HNC8rTXT+PukWrCAF7+6nljdO2bfZ1gg+CWSo+TrDi3Pmu8jxCvW389lCM5V5H/AYHVmJmH7IgqFsMVJC7B+Q2hRuLNjZmGhQVwqgDz8MEV6pRSo6NBwflFWEgaTa1uB+EMIuMKivLBozI+zprOg7tC3BFDBVOZDTYjL+cAUOdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57Yzub9W6vU4mf0dhRmLipGchVCXeFPtaUPUE+y8ltI=;
 b=csg3aNDhxDK9asCRZPXqHNNOC0zPHYQJj1QSiEXLcnqMqvwUgOCEY3BVe4JPLmYdSfQuKFeZ+tIWmm9a0OWx4uYpOJhnaWUkpBhGXIJRri74UPnW7qN6kr7lI+SCtEZzJUa+CpsV6SgeYoeZIkXbhSgMLajtfHzLVhf6sqtW0Kg=
Received: from SJ0PR03CA0106.namprd03.prod.outlook.com (2603:10b6:a03:333::21)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 11:41:28 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::33) by SJ0PR03CA0106.outlook.office365.com
 (2603:10b6:a03:333::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 13 Dec 2024 11:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 11:41:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:41:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:41:25 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 13 Dec 2024 05:41:19 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, <Tim.Huang@amd.com>,
 "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue for different asic
Date: Fri, 13 Dec 2024 19:40:59 +0800
Message-ID: <20241213114059.3170033-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213114059.3170033-1-jesse.zhang@amd.com>
References: <20241213114059.3170033-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be0f747-c462-49f0-3703-08dd1b6b1417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wwspfbpAqp3s0JwPhaIXg3hXYPk3VBiuVDbQ0OZdydV4f8k4XCRrdyr+63ag?=
 =?us-ascii?Q?w0H3Q9rO8rs1f8nS0qD/yzOUc5GzVtyjY3QuNYPu6vCVRGAdgmJ+nmgRlv9T?=
 =?us-ascii?Q?G2vS/MAYTejbXbPFV4Wsd251oNeOqgv5dJ6TB9gcuaGjxx3YDkmFiTDC4uiC?=
 =?us-ascii?Q?uUPRgFqtldCcMYiYzfC7jJZhh++kuh87Rnjxg8vjTHgNV8Mv3+fgJGUpNeGQ?=
 =?us-ascii?Q?MPxmApHI5Va1JlKnwmavyhG5iPDjIlG1Pgo34pKmzc1LeNl0HBEuS+dNWWUx?=
 =?us-ascii?Q?wtMSGSvXM5zxtRgsHm2WOeZnEeYi0H8GUW1aUfN+x5A5L9kK6HjlVNNJhgsj?=
 =?us-ascii?Q?U7oBsm+1Wwhq5BdsDf1y1PWCtX45IQaL7PZdUWrCzhRaUuIv2a6hoqOLKUsw?=
 =?us-ascii?Q?L6SttCyCuKTJhGAGyZjW8phwmaQ9jp6w7bKBy/XtFd/FuPPjnNf96qzgvnvT?=
 =?us-ascii?Q?98ZFHb0qVmiyzj1GtTiO2I0pODIctfN9mpVHeluQIBuvkQjEsVBTvRX33ag2?=
 =?us-ascii?Q?WSKdkPeTXfkMC2pyhjT7Zn5x2zoqJu17EJ0gv7J4n6MJKGnm04BggcSOwK/U?=
 =?us-ascii?Q?qzza1KwdhpOYhMnwSCu9Mo0UEcEI1elJwEkPgmSUg+OchiE76gt2ypfZq3an?=
 =?us-ascii?Q?rHQIrdadGKU7TjIkKgFkjWBx7jAzAQwvQ78JjxAnsyLTHkzuhBbUSf1dMWAi?=
 =?us-ascii?Q?1Khxx2gXIsbukVFlZBZaZQs2gjVck3H3a52v9eJybvBvijaO9wE8tQCg0QsA?=
 =?us-ascii?Q?Dv0YQd7fvl/W0qj0xcC7qORoY2JUJGGJID0C5uhWx7i/1RaQsb1DuVree0sD?=
 =?us-ascii?Q?lH/xeRQNBtE7ARx5DcVtP1ruehobNBdUBLNpLFKEHD6IIhP9dGQ06hDBx6Nu?=
 =?us-ascii?Q?YhjsqBMLN+UT8+UrLaF0YlfG+u4NvpJyB3WqgrS+cyLMFmnOJQ9l4iOxh6PP?=
 =?us-ascii?Q?XZF+wf4Vdq84h784U6Cgp5LcjBKjyAFI9tTfqXufRHSVeesu4ZN6Egp4fSPc?=
 =?us-ascii?Q?rt1Y+O+0PQoA7C61bZ1K+amEK5/fJZFjf+hkmgN08vRDLAShQrwnMMxTfKyh?=
 =?us-ascii?Q?LtsDYUnj8Ve9AOSbslQYDgMT9kdACMAVfmdFILa0giq9Nhghfo/lCOTQuPJS?=
 =?us-ascii?Q?KPQQrLmp2/vpBRgeGcyI3H/m2FmoOOI4A22rOnpcxNSfzTFwkOj1WHAKOdFh?=
 =?us-ascii?Q?3H4xyY6fVvKwUB8ZFONK+bH4whfEE78gAA5LZOnwm/ScBdlAOJ3y7xoG/qMM?=
 =?us-ascii?Q?B3HU7VCXfN4qMCtyUBvDaexj0evGSkvLynJCgSLAaBjtSV+sFVz2lOaDXses?=
 =?us-ascii?Q?UgAnII5WuPc6zvCk4e+h570oP+RsX0dij11rIVUd7LdnMl4FKVLUgEAXlgD+?=
 =?us-ascii?Q?E521u+7bgbHV0tVWDzOeF4+pFubHZ2g87lh5bw9jko6F3rnqqMDGTrVHCPDg?=
 =?us-ascii?Q?xIPkqj6YWknkE0DOA8bxDOLwUIA6V8a0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:41:26.8057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be0f747-c462-49f0-3703-08dd1b6b1417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Implement sdma queue reset by SMU_MSG_ResetSDMA2.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9222e7a777a6..e57d83099f4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2724,14 +2724,28 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	/* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and above */
-	if ((adev->flags & AMD_IS_APU) ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
-	    smu->smc_fw_version < 0x00557900)
-		return 0;
+	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+		if (((smu->smc_fw_version > 0x07550763) &&
+		    (smu->smc_fw_version < 0x080000000)) ||
+		    ((smu->smc_fw_version > 0x00557700) &&
+		    (smu->smc_fw_version < 0x01000000)))
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+				SMU_MSG_ResetSDMA, inst_mask, NULL);
+		else if ((adev->flags & AMD_IS_APU) &&
+			(smu->smc_fw_version > 0x4556e6c))
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
+		break;
+	case IP_VERSION(13, 0, 14):
+		if (smu->smc_fw_version > 0x05550f00)
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
+		break;
+	default:
+		break;
+	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_ResetSDMA, inst_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"failed to send ResetSDMA event with mask 0x%x\n",
-- 
2.25.1

