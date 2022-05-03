Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEA8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D6B10F43F;
	Tue,  3 May 2022 20:37:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E5410F43F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nyc4BMs4sB7NTQSfjafBwcsLtDRTKi0UQyn9gqGI5J5YqtxtRY66V6p+zRm9nIT5CzJhZnJ1iATt6TcnSV+Bn4onHtQGK5I5bYaI5EmRm51lNJcZ2wAO+YfKUrodsnjo2FUCd98hxzgeqV4k4CPuKcAyjbaflPOs8VtCIfgI0X8CYfrJbadiV2ajiotPhYk+4h38BVKCNIiwaE6M44g0aTjmHBEuAypz7SrfFd4Ut9d00bKDFWQp7OgSWSyzWf23k4RciFqkZ9k4d4afZmMcCxm7f0osGHSola3K3tuEVK9OxF7hXbs+NE0UzC+zt19BbM5Aomch/BU3K9I4FvALcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiB5dmiDyqH1i+io/nSUmVVyHuuCn+RB+CbJerjvKE0=;
 b=DaEppJTyD9YpDQstSJVA4oRnp++yTavTNIPCG2rsUh/5+fx1E9aNJwNYK/PajgRQebl5kqPzh6tPWuwrva7jFOnFHnEeb3Il2dSXrkdSDRaiBBi50aDVi0T3KSO3jZCv2nm0iQAux23NLAq/DYsDegLBqMiSBXujBpq08DMHqU1tzQc8MG21x0uYqzPChd6AmoI10ah7mg/1oRsuDmcwQUk0weSe/ZT6S+lJG2U+aoXlgrVPrOKbNoxVdB45KIqJuSb6TGKBD4J/gOAEhbGxewQrrbXnhZD3KqGLAYuyvhd0NlU90KAWx0XXu++j8oB8WrAGFy5zZD1DLBhhu4GvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiB5dmiDyqH1i+io/nSUmVVyHuuCn+RB+CbJerjvKE0=;
 b=PGhKSVV45+ilMSK+WbkTLamEvgDHe4VxX9gbRY0z9ZQRqXt8i3H2QRZYFqv7AyebCu+RFVGAIkcf3hGg/RW1wK2RXK/qytPuy5wlj8F77BPhatOjQljq1NL0puU2lpWrcos/npQYl2hdJzsXF8/NwdKi9q5D20ro19dQxBQhHoA=
Received: from MW4PR04CA0144.namprd04.prod.outlook.com (2603:10b6:303:84::29)
 by CY4PR1201MB2486.namprd12.prod.outlook.com (2603:10b6:903:d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:37:34 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::35) by MW4PR04CA0144.outlook.office365.com
 (2603:10b6:303:84::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/26] drm/amd/pm: add mvdd and vddio scaling in smu_v13_0_7
Date: Tue, 3 May 2022 16:36:57 -0400
Message-ID: <20220503203716.1230313-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3d3671-e02a-407a-f4e7-08da2d44c127
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2486:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2486B2F334C7D2E377303B6CF7C09@CY4PR1201MB2486.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k3V9THxDa/3Hah0CctHcbr/nIwvgBjuNDP8Zw9jy87rET8ymSEwlI+XaM/s38QRiRCQxARnefiwjFEIW0sW+cSA6hvWiE7YGwGg1gm4d78/wr6XX0sxeEBeXk4J3Ri4OCi8q6cNekctUCfyeaVDAbXVWQ7BrXIYJXYvKJnCmgO0Z+Bc8rzvuNaJh0GfstXu+MI2egy/qL8gt0dmxjKenKVq1Zmc9U/0Pv+yFed6sc4xd4w0XDiJJtkv81qByCqyaZ9eV4Dl2GFsGk9t3VthPWCx9A+M8Q0D5lct8VtQGdJkDQSyF0sNxDJAAKMb31XIcIw/vesmMLtSwrP4MawW/WneW2bE/CVpN6X27+jcAS4mCLyjeQiyHSG3FnqG6yMH0hcFYMOVL1+8bFeyC7lrTdYN4mR53CRyN3wYihscMecoUlCQvx6Lf8EGs6UQB2Qpi/Hm6gk1KvMNypMSu9ru6HEEEzEo/V22V9XlCUvO1lFB1PHLCH7yOLWmYzvJ+MhS8rqyeAwFJSyORQiuB089iIsx7q6KRu308t9d5eSY8+Fx5/3zem7wBBVgbLvRww4vyXkNWiC/23+6jUNzpNota4T3u4lEYOiviRZzlnpBCaFx/CBifCVLKyhhQRg8JDvCkZeLMCTiEx9dBW6gBTTlxj/c9UeJEo5U0zjuUU73HYBYWkXbXmxZDIQVdX5oIFdmA494V2CB5QpOpmZiTtpaSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(81166007)(6666004)(356005)(26005)(316002)(1076003)(6916009)(54906003)(47076005)(186003)(336012)(86362001)(426003)(2616005)(16526019)(36756003)(40460700003)(508600001)(36860700001)(82310400005)(7696005)(5660300002)(8676002)(8936002)(4326008)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:34.6119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3d3671-e02a-407a-f4e7-08da2d44c127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2486
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

add mvdd and vddio scaling in smu_v13_0_7 to follow uclk dpm

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 76dd4220d59a..7d994145d028 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -166,6 +166,8 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK) {
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_FCLK_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VMEMP_SCALING_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
 	}
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
-- 
2.35.1

