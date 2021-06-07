Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CABC47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3465961159
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3465961159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A716D6E8D0;
	Mon,  7 Jun 2021 13:45:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28BFF6E8CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lym+0A2AQoiRVLYMe508RRQE1+k+UUV6iDg2CEDe3H8wlcQepZLxJk5PUwYgx6EqeEGzLimP5YXMxVYI3DLS+Vk6Fv7dmYQ8cNnFQNAKL4cwyH34xuNdczrsCHG5juUjG2l3TQEt9x7QsU2sAWd6kkvCQu9ErwYW7ldQ+asub1zB0UeQvx1X10a8O3/YbinqTsZRu20YV3w0bjg9w2DVg6HoLByDCFtTQz11oWiXxLQt9wEeAoxcfTpfFllkVATuSzEixQq+TjKp9GryfwcATlQw5kapIehVQyhoGjhKNheRQYQGjqpjIipK6xuwkBhLKWDb1+hqBNt4M6XYC0w+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orOpUMkPNCYcyPLk0tCQ3mFmbCMo8dwEapmHPMCp5+8=;
 b=jSNJJXaSpBoFm+URGonQJus42z7eixiyVyTYr3WeLW8bpK/c9z9VuOeSmurXvI2sCUfHXd16Ym6zFTSylTCfxznuXmWzeCG5NPO5KXqCpy3yXwW9kxmwyJduYKNEgdK4uCq5ElMfB/8L+a9wOHiGyqsSzJq1aZbmLcMD6jFA1uXQHZuc1Zyyd6OWNCVZQlBcGAW3fhiYPZI7dHhHF2nwiN6R3mRBatzqBsR1sV2q54bULBAhl/Lb/2tQRvC2L7FAzOPyJsiATaw9Qta7m8pD5zhrd5P4HQFwm8MAPnOFUEOD/EDX92KC94VQKOS21iNoy4jr8tQFMRoHRor/mlNZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orOpUMkPNCYcyPLk0tCQ3mFmbCMo8dwEapmHPMCp5+8=;
 b=oMZPZM0f+o/QdcgKW5+lBUgudH5+vxGkHSyHzov+QLoCdzuoPfzjtDavHPIXSJ6W2MGNdJqyfZ/7IhSkOMWMCoPdcsmfi/DoqtfpWguM+Floh2B8s3XgG3cbDJgXxcujG9l0fX1pxZHjPxHxpWtpCQ6VLcwpM3vicozz4+4H7ok=
Received: from BN6PR18CA0002.namprd18.prod.outlook.com (2603:10b6:404:121::12)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 13:45:18 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::af) by BN6PR18CA0002.outlook.office365.com
 (2603:10b6:404:121::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 13:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 13:45:18 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 08:45:15 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 5/9] drm/amd/pm: Add navi1x throttler translation
Date: Mon, 7 Jun 2021 09:44:35 -0400
Message-ID: <20210607134439.28542-5-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607134439.28542-1-Graham.Sider@amd.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0e8187e-bb39-4e87-be90-08d929ba7cb6
X-MS-TrafficTypeDiagnostic: BL0PR12MB5523:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55237D5EAE49179F5071EF198A389@BL0PR12MB5523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEySzp4WhFZ/BjeVmVbPQMHVZpw3+nlVK1+pbU9AYRk1J4p9QFklm3dnj2YWeKagiDOWvE0DXnrgoXLO8yexLizhmDsS+4XzwAU73RdzSXoRwIB1LjWepE2hdj+ySaU5uhIuALNvQ3ZPNNyf2Qhx80Unkv0HYYRvmkQxBlAntxrBSrBc/fYEPAzpF+md1IetZyXVXL2/IRjdG3BRLGG4F76WQ8RR9B7srCAd14vKeg4fftQp3kdybl+BVWXD6AAfREyHHmqLWMQ7I+9SzmnjqiVA7GMpACSL/Oc+9Zt43I1q2J/liEeUGAGSqOJrat1u7KsU6OwiWAl9CcIO974WlTUBKdeWzcbKUQ+87yclM5557tXJwlDChPSxdijfFr5qAEWryy03xVOfaSmER/4zE0H7HVcZtsXgZSS+l+z55/ZBAK7teuOpLnNyfURPUhVM60GIXZaW8DJUq1Eht/47OC1dCiXSky0Cy3pOeD+7BgGK6GuZvID2AAp2lMwRW9Nv/EIZdi19+chNffwrnMBET0ZSaMP4S2z4fUxEeNf8kBNR4jrgXnY9PZdQ7t1iVC+2elTcSCW5eYr1l/w8vSPb1laOyKuHhEPkyeNOfp4F97bYES7Z4J0hwC1jhIJImys4dpCW4kGQNVv1GhrF4CEphD12kFwsWrVhkKXcj2+qcDmvDz1YVTPeYgwcN/f4WVor8X1YN0ffaPgaYCzB0RemBOdVgrsZEDvkuKL3m8Zoiuc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(8936002)(8676002)(6916009)(478600001)(83380400001)(81166007)(36860700001)(426003)(356005)(47076005)(336012)(5660300002)(2616005)(1076003)(82740400003)(2906002)(26005)(186003)(316002)(70206006)(86362001)(36756003)(7696005)(82310400003)(54906003)(70586007)(6666004)(16526019)(4326008)(32563001)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 13:45:18.2213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e8187e-bb39-4e87-be90-08d929ba7cb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
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
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..9e679912cd3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -238,6 +238,28 @@ static struct cmn2asic_mapping navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t navi1x_throttler_map[] = {
+	[THROTTLER_TEMP_EDGE_BIT]	= (SMU_THROTTLER_TEMP_EDGE_BIT),
+	[THROTTLER_TEMP_HOTSPOT_BIT]	= (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_MEM0_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM0_BIT),
+	[THROTTLER_TEMP_VR_MEM1_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM1_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TEMP_LIQUID0_BIT]	= (SMU_THROTTLER_TEMP_LIQUID0_BIT),
+	[THROTTLER_TEMP_LIQUID1_BIT]	= (SMU_THROTTLER_TEMP_LIQUID1_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_PPT2_BIT]		= (SMU_THROTTLER_PPT2_BIT),
+	[THROTTLER_PPT3_BIT]		= (SMU_THROTTLER_PPT3_BIT),
+	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
+	[THROTTLER_PPM_BIT]		= (SMU_THROTTLER_PPM_BIT),
+	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
+};
+
+
 static bool is_asic_secure(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2673,6 +2695,9 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+							   navi1x_throttler_map);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2750,6 +2775,9 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+							   navi1x_throttler_map);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2826,6 +2854,9 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+							   navi1x_throttler_map);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2908,6 +2939,9 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+							   navi1x_throttler_map);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
