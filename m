Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91193C4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 08:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50704613AE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 08:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50704613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B575E6EE59;
	Fri, 11 Jun 2021 08:11:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19AD6EE4E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 08:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBs70GVeIY5F8tvSUQUwE4EZMflLiCyu2l33KjEVNL6GnbySYmM/53QZyXVJ7vom11+gR8E6439+lcMc/mNcoUO039efElsPfX3YFeMGH2cVu/x+wuGt5qgVN/+yF5asGYY4hDtqLJ+yYR4SW1Ae8MzDP9PXZ/POpqFOCyo3cEHiBj9b/U9upJvz6HE4H48UzAwED7dCEQmjGjngKPyxOZkZonlBJVzGp7a5ybXxXUXJiV1WI35TGM+FMZCeMN1re9tDwoP6QbPZRl8kW5lUFwAr4tmsDueda1+rs4oHyhayp93zIcn6/nnFCJnAWO2An4NQU1dVdHtL9tTaKuuFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBmLG/A9gwHxGEpsirb/h8RyKjr0+kbVsEj+PEktf68=;
 b=EoDKLHf4W7VjVIih8nUis5yTfPwxzARoXjj3B1ffGxBXc62Dw1fzYJZSGf+lbGywniaoGYG3A74RAD2aeOtYDm49SbEjgsmetKIYmgsziWy44UvZXERbNfCUroQ5QdorKUhd+L07oBhqi7emHkDdmFdNfpLKkWoLgb9MBnwPdvP9H0uh8KFEh6c4256U8Kkz8qnikczvfPOoZ4mXeDCdofHOUBb9kgFi8M9eL5y+0YlffLF/w0uWe5DDfZPTlW91jc+c5yJUEltYGE+9ViAo2hZPU5I11+AIzMEikvEvmT51BmzIQbROBuM3gLahJpxRw15VIQtaf76drp4DMyPTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBmLG/A9gwHxGEpsirb/h8RyKjr0+kbVsEj+PEktf68=;
 b=yd7o/+dg6LYmsIzUxIEavk4T+CfJOn/UTupFqKpmZZ6RRIKX6R9P5LwlLd13/H56ajWQEJTS46ZvhJ+GMFhL2nUb0ikBnIRRHGIRtUm1dgVDx2/gRdNeQlRCyoERcKQKCQRzf/uz6k5JK3ACcFJu7O9oERWgcVNXFzVIqcIwxU0=
Received: from BN6PR1101CA0004.namprd11.prod.outlook.com
 (2603:10b6:405:4a::14) by MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 08:11:01 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::f8) by BN6PR1101CA0004.outlook.office365.com
 (2603:10b6:405:4a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend
 Transport; Fri, 11 Jun 2021 08:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 08:11:01 +0000
Received: from arun-Mandolin-PCO.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 11 Jun 2021 03:10:58 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: support ss metrics read on yellow_carp
Date: Thu, 10 Jun 2021 10:02:12 +0530
Message-ID: <20210610043212.14875-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c39d3a-3cc1-484d-844b-08d92cb07389
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3775714F1B2441FBFFDEA01B9D349@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdkJSAIP3FovOQWMb1QB3So6wfP7zdwVn9h0no5gARMNg7CA2MCcHsPYMfxqleEoDcPpqB7sLzAuMKIZV0Chztx19UM/m8ReRqQ608ZyFdtEK9ouT74QIiGvk2FAvVIh36+qJ+9u+SVyZCyvSAYn6uHOGHy0MaKsrm0fGymCTh+8eID2F8rs3I9p7Z+q5H2fo289bei3V0mLRO9z4dBPpCCRr6NIeMS/Y8l4vjoQt9z+Ez6/CiBebVDyYxbQmjg1nZV/kFoQgzlHsmXKWkLnVI0zFyx4A6XCKuKNDpp6ihwozJnUwMiE6Zn+Qhdh+uGjdbIMRfTfNCaExmU2xyycjEZL9Zpntak1uz6+kaq4Rdct4+vOJf7AyeszZFb/lS2+GqoqSRqsOibX4pxMGCm7mmLYsAD3fabvRGB2LPK/q+mnaLO+G4gpRAEjzHV75S/VbsL58aKJXqtBwBa43IECmMbe3LxijQvH1H947ywNg92457h31K5OsDCTY9KniQafOJaNCmD59BORrB697h+8/KuiEK58n1UAecPgy53IpOuF+RedFY8hc9xIUWEbqYJmMVI1RomLz3RE5tHwhg+m/PTPqf2/pVJt3f9J368IhkIBemmJFTNMJHEJK7jightl8SrzCCHnldhy3k27fK60UQ9uyD9PixcmYmB6dOME3pnbhgLXTN1Zh3M1vhXq24fl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(46966006)(36840700001)(70206006)(6916009)(8676002)(81166007)(47076005)(316002)(82310400003)(1076003)(186003)(8936002)(426003)(54906003)(36756003)(478600001)(336012)(70586007)(82740400003)(6666004)(7696005)(36860700001)(2906002)(4326008)(5660300002)(2616005)(356005)(86362001)(16526019)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 08:11:01.3464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c39d3a-3cc1-484d-844b-08d92cb07389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Lazar Lijo <Lijo.Lazar@amd.com>, Shashank Sharma <Shashank.Sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add support to read smart shift apu and dgpu power share
on yellow_carp

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 0cd7902d5172..7664334d8144 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -356,6 +356,28 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_VOLTAGE_VDDSOC:
 		*value = metrics->Voltage[1];
 		break;
+	case METRICS_SS_APU_SHARE:
+		/* return the percentage of APU power with respect to APU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if (metrics->StapmOpnLimit > 0)
+			*value =  (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
+		else
+			*value = 0;
+		break;
+	case METRICS_SS_DGPU_SHARE:
+		/* return the percentage of dGPU power with respect to dGPU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if ((metrics->dGpuPower > 0) &&
+		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
+			*value = (metrics->dGpuPower * 100) /
+				  (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
+		else
+			*value = 0;
+		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -427,6 +449,18 @@ static int yellow_carp_read_sensor(struct smu_context *smu,
 								(uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+						       METRICS_SS_APU_SHARE,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+						       METRICS_SS_DGPU_SHARE,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
