Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34D8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 03:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A42310F3C5;
	Wed, 27 Apr 2022 03:02:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16EF10F3C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 03:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrSc5XvmkxUhoFZz0Di4WjCx2+RBQqwnZwQm2+BIqOjtfy8BgFVUvrj6NoeX53b7C2Xe3gDJ/bz5m49lVcE1OG83aYTOLbFhV5WyeEfzlbXydvACN9/EaMOqWIws9OJrJIZnFyj14WLVteAvGw5aEPsO+9CmyZAptygi53Wdlkdgx5juVRh/k6r2P3Dt2vPi4NpX20LqOxrP4jW9HoxkoQIDkMQcz1/E2sHhGdGK0ISBZw/cflc8Wjxp7wfbopYLUKhD2FLM8SgOSidetURJiKgfe5FaF4TrNOuRRLwwd8wfsf/LJuaar/BGV41rN9xIyB3Ao9p5HFWfJeSLtOVWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97F/aSHYNtDeC/fUPeEWgovqscvno1ccDkDWpCmz3z4=;
 b=YlTH9SBJA/v6M+ZRnXh4RrNN0l/nJHKWZAJMS5//bsRBBzAhRWk+zhgsT91W0GtE1U5A4l0WKPQV+6DzJX9Lp4Nd+LWjiCLje3AKdIj1xNMFXeaPoDYrzZI64UxTK581QxJdNyBG2j9H+j9eBZT5Z1u8WgnlECgcdNJaIAXU+aMPvUFH2ppOTZae3A0/jXHwfPIt7hzt8k+cD03sml4mcfYNGcqspnvv5Gan7BrLso1SYQaMzuoqAeEbscdIE2LWO6IVU9fmqf8aSnNQAgf9GVtOgmCFx6yhseErkiCod0/4PT60/TMEkZ54sj0Ro+H7Ie3yrWgphkia3TrQuJspkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97F/aSHYNtDeC/fUPeEWgovqscvno1ccDkDWpCmz3z4=;
 b=k+i9Yto6Rm+RsxXNeQQIEmNhtZebVxscPZZNc1HOjtmu87pgh1EhRh9GPnEH56G43NgYL7hsSzV9AeTlUJwVbPMk2IVC2uRgjK2y8JSIY6JIrKV2Ik5+s80+QHlg1N6SZ9jXdAsGnNrtivT6kjfvRzW/FVd1P+qKfaWu2lutCYw=
Received: from MW4PR04CA0080.namprd04.prod.outlook.com (2603:10b6:303:6b::25)
 by MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 03:02:03 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::5) by MW4PR04CA0080.outlook.office365.com
 (2603:10b6:303:6b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 03:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 03:02:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:02:01 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 22:01:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amd/display: Clean up pixel format types
Date: Wed, 27 Apr 2022 11:00:57 +0800
Message-ID: <20220427030059.1242868-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427030059.1242868-1-Wayne.Lin@amd.com>
References: <20220427030059.1242868-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a538ceb-591e-4bbf-b8fd-08da27fa4df8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1248:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB124850104D83FFA64541A67FFCFA9@MWHPR12MB1248.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuukU1gGNcso8hRCVO9SCkGr8G80evxudMXEgEFRKzDb5OHDqvKNGL/QTadL8UqcBk/3h1A3pKiAndIz4Jl03UNfl058VZoyU1VSjXblWVmYnRba7wpgvkxa0iJinuSQfcBdi4zub50k4+3llbO3CSah6qTIg3z/B+McwtZ5Nn14TAOcGMUzB9M445WajE0Kt39+rAZtaqo27Q4Aj8kX9UCPESG6YsRsSGkSeV9KkzpkMRdUixN62dB3YmJFHOxi1GCegquMtww1d9l5pzhKt1ayqGHLD7cTWqIz1LX44wS3z0dvv7a7hjeIRWfUfw9QhYFpS5gf09iBeN3EmHtvuysbPCFLl3FPvopnRqEsyO5gBzF4CPKzSqXUHO1rnhN1fwsvpJH9Br3MWoDf/l6CDIHaBSyJAEjNPl4MVg+ahwrr+e1RQWLKnYLhLNKat6lJyA+z43X9f6FvLq4R7uQDrDeAob07YnDshkUZ5o+yIUznADP/tGfdrJqTHkTlF3vmZAxrzktI9TP6MGClJvoMIy9yt647+4J38XvyrbDFrtQmYDmXIYfsBeNrGcDokPY3XlApj+3nqfWEWoxXFm1TnQ6Y/9+29M/5D6bhT6m7pDlHFbBWRJjStH6DJ7I9ol0vgH8qS0lx2qAliNwIScjpXQuk+4GuyGohAw56T8XjOz4BnkFJ5XqytSfdcIr1TOqkHQVJT0PxXme5Ryg8KiPJZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(70586007)(186003)(26005)(82310400005)(336012)(5660300002)(4326008)(426003)(47076005)(1076003)(6916009)(54906003)(36756003)(36860700001)(8936002)(40460700003)(81166007)(316002)(508600001)(70206006)(83380400001)(2616005)(7696005)(86362001)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:02:02.8081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a538ceb-591e-4bbf-b8fd-08da27fa4df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1248
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why & How]
Equate the first non-subsampled video surface format to
the enum SURFACE_PIXEL_FORMAT_SUBSAMPLE_END since it's
not a real format.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index c964f598755a..0c754cb0459e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -201,8 +201,9 @@ enum surface_pixel_format {
 	SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb,
 	SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCbCr,
 	SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb,
+	SURFACE_PIXEL_FORMAT_SUBSAMPLE_END,
+	SURFACE_PIXEL_FORMAT_VIDEO_ACrYCb2101010 =
 		SURFACE_PIXEL_FORMAT_SUBSAMPLE_END,
-	SURFACE_PIXEL_FORMAT_VIDEO_ACrYCb2101010,
 	SURFACE_PIXEL_FORMAT_VIDEO_CrYCbA1010102,
 	SURFACE_PIXEL_FORMAT_VIDEO_AYCrCb8888,
 	SURFACE_PIXEL_FORMAT_INVALID
-- 
2.36.0

