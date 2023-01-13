Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF31C54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 10:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A6710E1C5;
	Fri, 13 Jan 2023 10:56:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A439A10E1C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 10:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwuXzYjjpLFqNaP4Vey7Cxt4saDZwRh+GPGmpZofvhmD20QjXrHmRAHtbD5+cbzdJsD/odum5Cc7gDym9x2oGppYVhOyH9xOBlE6ua5kPzLSB3nXMY+1J5l0yUjcP3nZzmFfZErB5X2yYAJm1UvhNqj9cgJRTH+cQiJdg58GIQ4exc1uIyiTWGpPZ0zutXTLKCYGF+pbLUaSYLdKyCrXLCdqpuRzUSGuaE8AICCutA1GQrXtnNk5rdVeBNdYdcfoFomkfDOQ0aqwW+MjRLN/O2vux5eLZk7eE6oADxTD4jV1TYzJ0znZCQCsta2RbBLc9FjwcAq+RdPyPZsTuUrRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9LFmyMGgOCB5yXYq7VvCYURar6OMhnuPoJepni4HCs=;
 b=IscL6viohDO6dyuY0hFsprMehwDHP/DVg8Ya0iBXgvqzaHN5rnWIMej1Ypb/oxgo5sRVAGKcP1XVZY6tSzM+S834YjNqG3WpnNP+NuCMlGOxQds0IXfmM1ciQo3Mif6wC33VIxZfFvTeAxvX6jMUhPmFcAY4mCydnidh02nV4glsb5AzaMeqPVqM7mB6M7cqlmfX1FXL2T0NYNrB7X8EvGVxTlwei+64Th5Phr1a8XI0bJl4pR6mK0/+tqAGaWRP/mZNy/RZMEprDSBvrech64nImDGRoNQ8jvg6dFGDTBhBoZXwSs/LN+Y+v1MUw47mya4ZfkeKwEj/YRP+F/jU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9LFmyMGgOCB5yXYq7VvCYURar6OMhnuPoJepni4HCs=;
 b=YKbYwQI8E6G8vWs/qeaSFjtTbSpVi7jZBRvi+GR5AIxUk0Sk1tdxM87DtjMi3SuIs93ccV4I2TSO9LERUVWvnWq1OcDvHmEUQRcb51uaCX5qEGyZ1Y/zJi9pabZVDfef1CWWpuueTvab30QBcKuJp08/FXFvC1Fuqc0pZJOY81I=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.21; Fri, 13 Jan
 2023 10:56:31 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::53) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 10:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 10:56:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 04:56:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 04:56:29 -0600
Received: from jane-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 13 Jan 2023 04:56:28 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/smu: skip pptable init under sriov
Date: Fri, 13 Jan 2023 18:56:24 +0800
Message-ID: <20230113105624.3477-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: b6262cf3-3c80-4175-54aa-08daf554d3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsWItVHMyGl7j8lTDEh0P9SXYz10yrjs8sle/r5wIE+ciYzEXZNfVxFUPelZ9mYE6uX64N17vwYpqDoA4wSD35dgwZzAb53SZcYkBZhwyh4twodK6hVaS2yAPXx4P5CU3BgF1qqsnQAAaaiGzgNutCVHhMRM683FscfdN4Ofut+5QoZRDo7+U9WRqG3BwhZKMhfMfBUedyfFoRf9zhcboEzeAVA26fj0XZbLEsN7q4vHfrhqkRAUzT3ePKd/kifpN1jVoVArKYhR6ZEv9vhM7n1ymgtlVO865ypUjizn7lOTt2E0Gd7nFZWq4ubyrt1zqK/yMdwcxJE3wO7ZQeIcyaICWb8VfZRS20DeFI4E6N4SCUV/IcBPv+ms/4klgDjli7jNhD0M4nMKg0MVNvNqha/lkYArerGjGyxAGTCSoH1UYnmCfNgOJyl92ngbrDzq3mXmLcu187vF16iTzek+oxnDHo3mFGVHLimtxgZzax4GRUJw2nEnPAf4PgIKnFL6Km1ajJQk1RwmAzlOcBLKxtWNrvWuR2wfwRq2F7qhaobTyPiI1nQQcxixKrKJDITBE+44QnWzbTfznNWxFGBljiJ1G+zgqkdyFNkoUVlytQZ+0wVc8Nzjjo2tWWzzu8eBhUHNhQ9ZnA+M6i3sEuJQb8f779yb4TrAqoNwrmN225xkpKh1K9yAdbM5npGw6JGnM/mQc5LK7w95E1qRl9zNuKCM5e/Rt+GRbM4B3bAeccc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(5660300002)(316002)(54906003)(36756003)(2616005)(1076003)(82310400005)(36860700001)(336012)(426003)(47076005)(7696005)(86362001)(26005)(40480700001)(81166007)(356005)(186003)(82740400003)(478600001)(6666004)(8936002)(4326008)(6916009)(8676002)(41300700001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 10:56:30.5445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6262cf3-3c80-4175-54aa-08daf554d3e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
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
Cc: Horace.Chen@amd.com, Jane Jian <Jane.Jian@amd.com>, HaiJun.Chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sriov does not need to init pptable from amdgpu driver
we finish it from PF

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d0cdc578344d..d07b0cfe23b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -407,6 +407,9 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if(amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
 						&smu_table->power_play_table,
 						&smu_table->power_play_table_size);
@@ -1257,6 +1260,9 @@ static int smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
 		table_context->power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
+	if(amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	if (!range)
 		return -EINVAL;
 
-- 
2.17.1

