Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13A6CE7A89
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 04:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A96F10E1D0;
	Mon, 25 Sep 2023 04:28:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422AC10E1CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 04:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL78y36gWZ7+aQ++khpHFyTm9CqPI6U7Qiby5jhxsmKJCrSXvKRSg/h1ItmC4uUb9e1+09Ni67MCfUerN4pHif+8wNVZgFBbvaTodu/lksvO46UbQo2KMHaFslG/4v8bHtdRZF3emkdXb03tEjCYTHH5RGhhha4+0vyDl+6GCQqjDbOcv+yTld2VuV/aT1cJM5Dt87BpFSVcOYFKgPM2z3cDsCe7RmCvum5g8W7Jeg8LPh+WinShylR3PLZ6+dI0S9vuOAaGFg4k4OWiGkV/VGpBnj2mjL124pUzxsIOXbY0ORbHoXhEiob73OrTczbTIOOmHSYrc5y1+aXu0jhAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtPMVwFkeTFGT7FkKy4dkBvwGzXAB1gk5zsDuPFr3Ak=;
 b=lg8feCM0baGV0oiW0yiW4POmrNr9Zuzicq4kEuwyKQDQiZMty7woofM8kEKNEE7kTZIPMCuwei/wu/gGhdRSlT7mBg74CrpnJSt8KyIzITtg38B7QAhKJgF6x1NxEjWkuC/Z7H1FoHyO19RelrGRSNR5eBxdufaQAmhy9jOWzy6mXfYsa1PnCnNnsf0MarOv1fI4X18XDeKMlipnXNJPaH/6Ylk/ik/K4fTvZS42OZnjsF6bUfJXG4RQCng5e8T/vw0UcS3oz4CpdQxGHHMXn3eBkvl3g/khIvoEAcRpJKagh3wMTkJAs5lq5FQfRRCtTNPsd9AUoTKKsVkjVC7tvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtPMVwFkeTFGT7FkKy4dkBvwGzXAB1gk5zsDuPFr3Ak=;
 b=F0VH0Le2Ua7eHjnYkZIFanuYfCMAY+9gOpqraEtoY0+W3NYpd4GiuNm78YZXYUfvZ691RPF8I3Q4wXORPEQ1y5stYYc9+rVQX+86JDM4diX88WiPLsNUSSGUg9KBaTvvV8z8PpMWSkb/CXca6C5zJzCQatNzxg0wSTDgQ+wEaM4=
Received: from SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::33)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 04:28:50 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::17) by SJ0P220CA0022.outlook.office365.com
 (2603:10b6:a03:41b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Mon, 25 Sep 2023 04:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.17 via Frontend Transport; Mon, 25 Sep 2023 04:28:49 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 24 Sep
 2023 23:28:47 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amd/pm: init plpd_mode properly for different asics
Date: Mon, 25 Sep 2023 12:27:50 +0800
Message-ID: <20230925042752.3847-5-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230925042752.3847-1-le.ma@amd.com>
References: <20230925042752.3847-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: eb978399-c089-4539-96a9-08dbbd7feabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RiUeRLFs98eoXqhZbsG73DjsPgRNouqAhfgUPt56Tc27HPMEf9i/rzNJlM9ayxLk9KNIs+wS1eG7DPkkS4v92BzSSo/6ztL39zDDmILmDkRpVoqQlXzvDAwfO2cEytulkl0dEsd/rbo5EcH0C2ungaUytopCZhD223Z2sCn5g1wVUz/6O5lkSyxVICBo9pr2SVz0iRROkulQq/wflO4kuDfEaqS0ZwuBvAhayxIxQ9wWUcdkdRujDy3h9oDBec68amEoVwWt37aU0vDUQqRRZsk+xmI6mBoVTeJH5XAi0SZQMjtkwI/jXCCE5pKA0C8OsB3YJK2CtjRlM0JX7do3T/bYPwLMr8hjIoLQtPyKnyCjzNfcl5xnVSBTg9jbdNteUSNqAXbA/Z/LZQmMjqEJxMydOern+/OBm01cDXStVNFrGTMumJ1yZiORV94kiqCwcNZOgKDwEokxq9R6kDTZ886M0RjIUbvDCMri7V/bVAVCbipsDdDNtHphvjApZk2uDVCqziToorr81h5wu5HrElX3nQZGvsoKPEJ08yQuNDN1lHFg3BtkTPcqjJwDOfjQyri9vDMrKluP+ofskQCV7hh4R329ttwHmuAo45uzss9uzVesgMM4OK+YKuax7B6jOtVwhdhGjOIjlUgxOd55uvstAoucYEc/4VDXfuLwn8mSGDGZfxSi5TqMztN1Aof1ImB8JOPDpvNotvLxibdLUWQEoK93xlKU4GE06HJTqXtY4Gjpts+quqXso1OjlxZ3b+OcIFZ8DZmHHWjFPv+scg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(70206006)(26005)(54906003)(336012)(6916009)(70586007)(16526019)(426003)(82740400003)(36756003)(83380400001)(2616005)(1076003)(40480700001)(86362001)(7696005)(356005)(47076005)(36860700001)(316002)(40460700003)(6666004)(81166007)(478600001)(8936002)(4326008)(2906002)(41300700001)(8676002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 04:28:49.8349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb978399-c089-4539-96a9-08dbbd7feabe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Assign DEFAULT mode if it supports plpd, otherwise keeps NONE

v2: reduce ip version checks

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 893359b26418..1c6b22638bf4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1130,6 +1130,21 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
 	orderly_poweroff(true);
 }
 
+static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
+{
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 2)) {
+		smu->plpd_mode = XGMI_PLPD_DEFAULT;
+		return;
+	}
+
+	/* PMFW put PLPD into default policy after enabling the feature */
+	if (smu_feature_is_enabled(smu,
+				   SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT))
+		smu->plpd_mode = XGMI_PLPD_DEFAULT;
+	else
+		smu->plpd_mode = XGMI_PLPD_NONE;
+}
+
 static int smu_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1361,6 +1376,8 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	smu_init_xgmi_plpd_mode(smu);
+
 	ret = smu_feature_get_enabled_mask(smu, &features_supported);
 	if (ret) {
 		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
-- 
2.38.1

