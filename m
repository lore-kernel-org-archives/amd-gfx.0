Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A68C43217
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECC510F864;
	Wed, 25 May 2022 16:20:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B05A10E625
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0ArOqDYNZHjyqnWkB7cXgu72Bq3vf+G398NbH/XwW5zmQPd1QX50BgzqC/JUP2QaWa/6uupNCGp7c5PPTKXhBztLEfClNizi9546IJdrwNmODsycJxPYDYOUU3TTUugWBBxwyh732KvRvawpXCPNrYuywYFCJTRs74cI+m7XloO82WmDfF+VdZAW8/YPuEEbtYy4IR57zmDW3U53jztDwjH0dxtny+C57nR+uUh8rVRrwBfRLaXHP+SKzcOhOA7TjpWEjVlsGP8CD90ET9WxCH7HssMXyW6GQhmh9yIRDpfpIp/+O9wtLF8DMms1A/qwq0QoDOZHaxFtk+GK5TcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zqvpIXJ99CJVbGQ+fI3UPmDwgTvdyMNU/eVTTiKhVo=;
 b=ftUcl5xwMFWq+jcXdLO58M7/NAfajcTR1n6lTcvb2I9f406VtyIRlcsM3B5gHuCZiuWJOjzYV89A1549VVLyjaZGp/H9BpOczYQ6VByfg0WWTPMnfrbkjPxniwh1sQvwdGJ5gKwRScTyQEpnbddX4uMzkm8UsTNP/U3psv8jgeZBldBZYbR85CjF0QkwMeP7FOE2nMoIHcqlIuTf07qe/lZxsylyPd4pPALCbeQWlyjhZG9MMIjaxoJ5S2Q/eC54SWf3nmZktBh6+OtmY/fvA/MnusOWpSgHfLo9hZ+7SKL/fEh2dK5iapyDLJUQsbJ1ql2OKCGnBER93jbJGoTuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zqvpIXJ99CJVbGQ+fI3UPmDwgTvdyMNU/eVTTiKhVo=;
 b=qT3KLBaNZJX+a2i1dRdHEQF7DFpuZzFBJci3QMrk2LpZYoPEwPj/WTZ0Ch7G8klZuBvdikhDPWGYdi/n1fFIyOYoNnJs5ZJSflHw9vcsg6DxYC1ztuolzH4xnVqdv3UFVY7aILwC0aHfoQ/tr9A6t+rdse5jE6oguMSSCQqtEdk=
Received: from DM5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:3:d4::22) by
 BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 16:20:18 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::ed) by DM5PR05CA0012.outlook.office365.com
 (2603:10b6:3:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/43] drm/amd/display: change dsc image width cap for dcn32
 and dcn321
Date: Wed, 25 May 2022 12:19:28 -0400
Message-ID: <20220525161941.2544055-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e35931f-aec3-4512-c69b-08da3e6a755b
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB459937752F5BB83498203F56F7D69@BYAPR12MB4599.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2t1EpZZjSvsz5mqSUPY2gjk+ex+91QAVQUuJuC+s2phsWAE5mozkTRIpaQ9YTT7SC00s3ZdBvvla7qhzHZ4IP5gePSATjYwexkZwx6AvQgPpWf2wACHjoXyEQwwweEyO7TvxYVAwmvBKXyvqMCZHwFM+USTJOa1AoQydluapKP+jnXw1FTFPLD/U6Nr5gaCN2sXh9T/2wUc5jF1E2/3me7RrgnU0LCCFUiuON9EWsTSSIww1T4ZRFElmbtmpbJdjLvtd+Vf58lhuuXvvzl3xUe9YRYHzzWfPkKayNt83O8H7SqQ0NMqhDD8W2b3tO8PgGuQcr//QGqKIPIqTSeOZwG6bTAth/hBY8umaAgrsSIAaYQSwRJI9U1D3PgzEl2CFbQJgsKcDZQZ39Nr9lz/H9BQFBgVHoRRGu6bHSmn7AhGiOw5SBQg2A73qtamZiIzzpoEXzJzreXxnu3URP7ExIMVziLh8S5d/8W4GjJL+TzvJjbLa1tDVyJinqVSa3KAZdgG7fPMnOO85PXEYqhYgxj41Tx9MHbCru2Ih/13stc1NtJOvzVyegxQ4wj1dX12n8D8I9mxcxv+TKEGr+AhkR/A/gRwgN2S+qbhs5khw9xjTRwiIhA+fX2ElrYvz6wCKIGvDYqt63cfk+CV1QONTEoqdmIDxcKkFA8ikz/8FClInfhhXxfb+YQPVDlhIfrna5K0iOHDX1vFHK3UCfQv4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(508600001)(8676002)(4326008)(54906003)(6666004)(70206006)(81166007)(8936002)(316002)(356005)(5660300002)(36860700001)(2616005)(1076003)(6916009)(336012)(426003)(47076005)(36756003)(70586007)(7696005)(82310400005)(16526019)(186003)(40460700003)(86362001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:18.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e35931f-aec3-4512-c69b-08da3e6a755b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4599
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
 Dillon Varone <dillon.varone@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

Set appropriate caps for DCN3.2.x.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 3f93b1f2d872..f2850071478c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1695,6 +1695,9 @@ static struct display_stream_compressor *dcn32_dsc_create(
 	}
 
 	dsc2_construct(dsc, ctx, inst, &dsc_regs[inst], &dsc_shift, &dsc_mask);
+
+	dsc->max_image_width = 6016;
+
 	return &dsc->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 27d3aa7d751f..376dd586b643 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1679,6 +1679,9 @@ static struct display_stream_compressor *dcn321_dsc_create(
 	}
 
 	dsc2_construct(dsc, ctx, inst, &dsc_regs[inst], &dsc_shift, &dsc_mask);
+
+	dsc->max_image_width = 6016;
+
 	return &dsc->base;
 }
 
-- 
2.35.3

