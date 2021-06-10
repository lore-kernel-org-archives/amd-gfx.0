Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E133AC48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 08:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD73610A5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 08:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD73610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3326EE47;
	Fri, 11 Jun 2021 08:12:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B186EE47
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 08:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZM5e1Lc3IRw9e1rGATouogQq0lxmnxJucAFx2EfIcv8FduDyZcxhiOZ2S1Z0JMYV7NF1hR5I6RcrLj58yfo7eZ+rhBw2I/C32JUPXokiTVR/9MDABTJMwO0xdKEEgBNfBI8m8xOUIH/HQcgRBUl9kaT/mVM5QltulJodIsdINpp1IdgBqFhIbfqbqGQ7IMaqQpT2xpY98eA5kj7XGEwus2QuKAIxiijG7ez0K609TEODgHA3rW2oWblIxCoT2OzyJlB6w62k+9rqn0QzD7N/uA/KaCv28Tisvee4R7wHlvi1FwEoANROY1f4Q5RtwuVXd7xtY7FRt3diEj8uQ/pmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yG6uhcqUoLDGkkTWuxgOfZB9RKjGFPmLsO6b4YFAj4=;
 b=lI+qgXWdzal44rhvcjs/Yu/jgBQR+go+eJCxyXxM64gTP3NydyUL/PMXg4t2oGnLtaNxn3bPNF1a2IWF0TolsCRu8EpY1pGdj2GjgEP8U7BWoH+RWA46+l2bhT/bE5M1usfqSK+QpQsy5Sg3HKmySmWfk28nXWZN3BulJehAWYO2hneAp+b6/dTbUI1Pvhy/H6SN7s/v4DeMHjg7vkPyriN+vF+Yk94eIvjeEkJALpeJW0t8otjFSsl4K62vuxBSdsLUTLQVkwNy+076Bhp1F3Jx8/bmKe4tIw/CsGQG/kwzkmQN8qkcZEjdvSJwhBLCGwUfWuxfTG9762pbgcSUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yG6uhcqUoLDGkkTWuxgOfZB9RKjGFPmLsO6b4YFAj4=;
 b=xTcI9uI+RXQnt9JG15kug5ZMi4YtYtLRDiHoR/3NNyK8MfOkiFukikVQHFLvou13AahvmURCUOKuEjstfwjNEFo7b4rVIMF7wFECsVdCFTuaiNjgw23Jn7B7Tjez6Wz6bmkMkJNI8ORgVHuvJJ+SwsqfQg9w++uZSOmuVZse/pE=
Received: from CO2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:102:2::30)
 by MN2PR12MB3248.namprd12.prod.outlook.com (2603:10b6:208:a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 08:12:49 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::e) by CO2PR05CA0062.outlook.office365.com
 (2603:10b6:102:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend
 Transport; Fri, 11 Jun 2021 08:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 08:12:48 +0000
Received: from arun-Mandolin-PCO.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 11 Jun 2021 03:12:45 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: support ss metrics read on renoir
Date: Thu, 10 Jun 2021 10:03:58 +0530
Message-ID: <20210610043358.14997-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aac0289a-37c0-4a2d-d35b-08d92cb0b330
X-MS-TrafficTypeDiagnostic: MN2PR12MB3248:
X-Microsoft-Antispam-PRVS: <MN2PR12MB324848517835F481375EE5FE9D349@MN2PR12MB3248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5l5J9msyfU7Fkre32gMt496d0Aouoxq5JOsgfvMvd1t5vpgTvTmiElONXfYvmXNqwWHsuwdWunDqDy/3+3UV1xNyRWtB5aRQl3HUbKUf3CxJn5mdLhDClQUJ+tbUd6pWv6YK1gxOMOdgloMcNIxWoBdXBtB/crGvyz5Ha0Y3N/gNVEecp6e3EWDHKCv7GI15AmgMSi5IH5QV98PVjJKCoDYqgLTaeJ1FibrimkhBLfGDp4YtPZVUGUhTtf3445n8WLdaPpIWaI9rsMei7dzK/vXrKkqpT3hsskqI5Zmqx/gPjefL5pnvPlwmpKb8TJV77o/6CpokDwiyk+lR7oHNa0YJQSMBmv6WNUx0AaP1Pq63TMtSGNuiCUvz2KOdqinM5e3p0TcjTydl3aihh/na1CUcH7DAATFZ3snV0RgMJh+63K58LOWv7bdcJIzrAxjHBsabq2vMQ3VVIrlPV19Ljad23ncmK5ucFQtFUTr6efq7RAnqtTqi38b8kW/vF3WeVQm9P1FZKl8UanfMNCFuV3ZW2cW3F7j05UqjmeJeAL9kNc0On59LlEk+GmRuyuUJVo79fhotoL2kJG6iIUzsjydHD0ojsKuw/Bi2kX45sMC9VxtjhE3E8ZOe6VZ2rb8OMkpoGtIEbYhm3UTAiEXU34XZnlunOXhlzQVT6VtR039pVnmCTCwTh5Kc57x7akO3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(46966006)(36840700001)(47076005)(5660300002)(70206006)(81166007)(70586007)(7696005)(36860700001)(6666004)(83380400001)(316002)(86362001)(1076003)(26005)(356005)(36756003)(2616005)(186003)(82310400003)(426003)(336012)(2906002)(6916009)(8936002)(8676002)(4326008)(54906003)(82740400003)(478600001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 08:12:48.0254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac0289a-37c0-4a2d-d35b-08d92cb0b330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3248
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
on renoir.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ccfcfcf18e4d..9a9c24a6ec35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1180,6 +1180,28 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_VOLTAGE_VDDSOC:
 		*value = metrics->Voltage[1];
 		break;
+	case METRICS_SS_APU_SHARE:
+		/* return the percentage of APU power with respect to APU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if (metrics->StapmOriginalLimit > 0)
+			*value =  (metrics->ApuPower * 100) / metrics->StapmOriginalLimit;
+		else
+			*value = 0;
+		break;
+	case METRICS_SS_DGPU_SHARE:
+		/* return the percentage of dGPU power with respect to dGPU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if ((metrics->dGpuPower > 0) &&
+		    (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit))
+			*value = (metrics->dGpuPower * 100) /
+				  (metrics->StapmCurrentLimit - metrics->StapmOriginalLimit);
+		else
+			*value = 0;
+		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -1251,6 +1273,18 @@ static int renoir_read_sensor(struct smu_context *smu,
 						  (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_SS_APU_SHARE,
+						  (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_SS_DGPU_SHARE,
+						  (uint32_t *)data);
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
