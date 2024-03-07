Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E71C54E49
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 08:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7704610F2A5;
	Thu,  7 Mar 2024 08:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NSMKxx3A";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16931113713
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 08:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmLG5FqeITYrD0cC4xNbEJygMciuqSqOVh4d8bI4JNK8gpy80oQrIPKgUH15OF0yC11OWycPH7dWnQRulACYnOkhRybQo0e6c+0IKpWqK/VYkPDThB39XmI9iLZwv6PFR/3Gj2iJWZJTibZn7z53OVMPnCPIvRyYJguHhtbRatjjkbBPz8ULWZbq50xKwvUU28UKdg+zqXiX5NKkggVM728UOtvjrC/1rmkNIIPulo/41RPtv+s/DPT8XHe8Zln2jPV4TdNuHBj7uk3gz/t21UyhnRrP0m8GJ/s+oltc09wM+jnH5A7viOSjMSm2Iy7FUkEAtsMD20UBhmqX7jLgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9h+CTUUODOgH+xLz1L4PMdAAlQgnDjxkglI5C+4Ix8=;
 b=E/sZKYAMzA08MWcDgdOJSff73eHmfI0Suw4n7PARorMYL0Slo7IsmjXbGHxs6s82i+mEw94vSHujKg9Dl9xTamxCFWf4S4/K+YMDdT5oaDxaCrSDCVlLexFKRGTXvpCMZXsaxjxO7A+oLyvveweOutOnKmAg14bMAbasGmmg2AKFlA1NTwjAzum15TYTD+ku5euAgckSJf/s2WyzlJz++mYHLjEcCNh8HiEr0mykv0IkNgr2gaa9d6rO2t9MjlW+EkwR/wZwJ6snC67XfOa+Har4n5PNJeuqzadgKC6tc6SiUCJaR3o6tTcjl9poije16i2oYUSuso3xGHFriuP3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9h+CTUUODOgH+xLz1L4PMdAAlQgnDjxkglI5C+4Ix8=;
 b=NSMKxx3A5S6yeOtefhNrySUSl2zWFvQg8dfRdXp9HdBxVKOCHvKwyLydThqWMCdcAq3NMBkyW98JD7L4R6qtckZgtJ6+zKewTRY564eOnKTQoukpONKEOa6NcyfNygvG4/pcxgiHV+NLnFHe/yjoDCXCWx16pZoIznlOeEuLT1w=
Received: from BL1PR13CA0167.namprd13.prod.outlook.com (2603:10b6:208:2bd::22)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 08:51:58 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::a0) by BL1PR13CA0167.outlook.office365.com
 (2603:10b6:208:2bd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8 via Frontend
 Transport; Thu, 7 Mar 2024 08:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 08:51:58 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 02:51:56 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add VCN sensor value for SMU 13.0.4
Date: Thu, 7 Mar 2024 16:51:24 +0800
Message-ID: <20240307085124.354075-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307085124.354075-1-Xiaojian.Du@amd.com>
References: <20240307085124.354075-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ab7bd3-2000-418e-e680-08dc3e83d8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTH+gI6q4FV2+0HZBjh6k4jKNeww7XGxgw2A5nqdD380wEH0TA4r8azZaCVYu+85pwe1FeMuSkU2wtyEHyScrZWSetFRqhWwM/VVDGmCbr1WCCCOm7ZvureHApwJ1ecsyUPFMml0iGS3YZGYqiiNdeqo45y5Vf3kYZMDJMqlzViwiXfZCge0hlWKuvdLp+TI9kecVDldm3I7IRjRcXdozfyRlMqRZtmVYur4fi4POB86U+x1lMC3DjhiXpmO98n5flP47cnJPmyFENHOKB9L4h/a8IwlKBsyAaMOeNZfE2TCtKuuJ2GoD5dLRN1L+JkDHbipQIvhPLYRdrDZQNioRwhaKPUhfKzYty8q/KMujCr4Rh+dPKJxI51KaGGHDARVaXwIp1NkLmnojZ+FZUeVg6h/S7VMiM54nFQ6BrqnI/hX0e9ktBtTB349eN/FlrGToTOtOMHDsqRaQtK+S7s8llTIiA5Yu835OosODP9WEzh+4OZTwyvTXC45JKHMMBxP3sj5LWBt6aVgfot8MjQln5kPL3XIMIAJs6dG7PvELMc19G1gv7gRK9F2JtF6oQceBZqb1EaCMqWp2nlFpT604YB6PrgKUsNSSQtlUbkldPj9YgoV/aSZbNM3M25p9DDEuIgFznzHIJYqVNJDeJw6zBfZwcjqxe6HC7xbYRuOqStuph/pevwo/WuJ1prNFtQSuMQlGvVIV0YJ8DJ2Tu/aquuMKGCcUIlBtRLDD0hxtCs3Uchhjlhc6Dyf8XdtbmjI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:51:58.1193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ab7bd3-2000-418e-e680-08dc3e83d8f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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

This will add VCN sensor value for SMU 13.0.4.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index bb98156b2fa1..e8119918ef6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -318,7 +318,7 @@ static int smu_v13_0_4_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->GfxActivity / 100;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->UvdActivity;
+		*value = metrics->UvdActivity / 100;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 		*value = (metrics->AverageSocketPower << 8) / 1000;
@@ -572,6 +572,12 @@ static int smu_v13_0_4_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = smu_v13_0_4_get_smu_metrics_data(smu,
+							METRICS_AVERAGE_VCNACTIVITY,
+							(uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = smu_v13_0_4_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
-- 
2.34.1

