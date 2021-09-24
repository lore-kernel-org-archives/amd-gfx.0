Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF6EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F69661250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F69661250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333386E214;
	Fri, 24 Sep 2021 19:10:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4218C6E212
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNmgXasRr/PaCygfUSWlG54hWBD3mobFcxCtZjKvVpEyJ0Gd9edjtWifAS6jjtjZ2PmqnE1H0OknHkIuxDTnlYxmow8x8fge6bUaszJ7mEdZ/+czlUUlaSRskOWdA1bqIrZbcKhRBP67YKSZdudpKyDl5EuO0n5uYOepoeK7ymGsSdQNbWSqawAxlC5CkscvYV26NjupJW0gBMwf3lkkjRgUgwz+AQvf9ubMh9Rr+cssxAtxlZ4+ABsnkbsP+KV0kfHbNkiBHdsQcQwXc22ja7K4DXMh43csrm8POzq8dzqdGx+lYgywPnh/WMZ+MD1UzTiXXsbJ8GkbOCgSp8EiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=jsM2JzF4yYSiEcAoOMvNou6BhhnGUZnX8iLaSWitGYo=;
 b=EZJTsrE88bRjZWRhtahXT+KQUVReFDTxJJlkrYD1UFqzZrnwWLaiA/aPi/aWh7bGT0VzE6ZA3EEhcfXpGDyektwoJ1MTr3C5a7ImcxOkzPVia7pvJ+pWHKYYJHDX00i5qxqWG5fzDrtjBvM9fqAGqNZ8lsUNbfmBXh26OZkkoPd3eLvjb9pbN709HMIsrtHlWWJ6kEr2gePfoMTqEeOs4JQH8fIu+MtBA3D9g/rgMIV1FaHE0XA3g3dEi42nhJEzeOVzM2420TDuqQGlwBf+1NPFVi7GosNAael0XYITcNF2Wjylk/fRT+/jzBKlNHuqDS5azz04lTZ7Ldc9dCGCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsM2JzF4yYSiEcAoOMvNou6BhhnGUZnX8iLaSWitGYo=;
 b=TxGb+nTFPyVoIZdEm5T0nPG+x7kUVnPtzVC4Vhwc7dDg+qznIYJqT8TfsDGx3e8viY1u79DmOOBMcA4J2WH0vIXV1pkoI6k8UXjhkSCyLF5Oz1V8vekyw06TCZghxgqWwJpVs1iVMx+USPrZznfmh9Q6M8dAgs2B2Rd9qtXGsfE=
Received: from BN6PR13CA0057.namprd13.prod.outlook.com (2603:10b6:404:11::19)
 by BY5PR12MB3666.namprd12.prod.outlook.com (2603:10b6:a03:1a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:09:59 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::f) by BN6PR13CA0057.outlook.office365.com
 (2603:10b6:404:11::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Fri, 24 Sep 2021 19:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:09:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:09:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:09:56 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:09:54 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 06/24] drm/amd/display: update cur_lane_setting to an array
 one for each lane
Date: Fri, 24 Sep 2021 15:09:16 -0400
Message-ID: <20210924190934.1193379-7-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42f8ea99-c9d2-4cce-e094-08d97f8ee67d
X-MS-TrafficTypeDiagnostic: BY5PR12MB3666:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3666BCD946BA5485666A1BABEBA49@BY5PR12MB3666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxiYGcQ3RUblOUPCVmkN8QULdclcK398gKkWjFGm5COTVYUhyxF6fN09AZzRJAxWhWMg7623Fubf5vvG/hw9uyFC9w2mtYAnoJAQPduGFENJ90QeW+7/z1Bm3jN0RkxgWMmZtjDFhXOUWyo9et9QgKU8nVdi8h5cxjjNLM/v8lz8l+Q1vPHJAUWDVrrPMiMKYfgPdn/9sopHLLfnUKXeJv4bwujanqmfBYVH51mUWE0y3H8pMIV/oB2jOAttepdtyqbWy2DpRl3/dGkHq2GAKGfqeZF2zGjM3hy+t4VS9aRl5Al2SlEiNSIVf1BRY6cx2reu8R62/tPi5f0UAEbfDobjYjhfBdPo8eC9QhVJFibjybK8PZGgooYYd+D+bMhG+rXwgWctGZu+nRVzhDUt0tykSy0pYEpRK1rx3Bmp+9Y/q1rrDsurR3OM65QicPjgCrepv88yOY5HwnbRbS57QCNI6FrRn/bpqKR11PHTZq+jWwIZxivIaB79MsvppZOTYtxsWO66QhCDjp79/SDW2RppszZaiQjjyjf+uz/8QIO6PHGbknpKI3V7soMYQcdnRBGCpO2nZxlQBprxyY2htrz5ZnGWzZYhdbdPkjuiYM06fqDMTnkGmRMz6AHlTOlv+TV0r3l066Py+orFf92ZdEdI5YBEybj5HCmpRwQhwg4YFH3s0WjpZ3p8CevTgPd+T+5eRu1aoB51TETM6XBMRcLLDc+gYmNnmz7wDpHdxzA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(36756003)(83380400001)(70206006)(508600001)(15650500001)(36860700001)(26005)(86362001)(356005)(70586007)(8676002)(316002)(81166007)(82310400003)(47076005)(186003)(5660300002)(6666004)(2616005)(426003)(1076003)(8936002)(4326008)(2906002)(54906003)(7696005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:09:57.8298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f8ea99-c9d2-4cce-e094-08d97f8ee67d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3666
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
To support per lane lane setting adjustment, we need to change cur_lane_setting
to an array one for each lane as the first step.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 8 ++++----
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c          | 3 ---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c        | 3 +++
 drivers/gpu/drm/amd/display/dc/dc_link.h                  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index f3ada9b6be5a..814f67d86a3c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -379,9 +379,9 @@ static ssize_t dp_phy_settings_read(struct file *f, char __user *buf,
 		return -EINVAL;
 
 	snprintf(rd_buf, rd_buf_size, "  %d  %d  %d\n",
-			link->cur_lane_setting.VOLTAGE_SWING,
-			link->cur_lane_setting.PRE_EMPHASIS,
-			link->cur_lane_setting.POST_CURSOR2);
+			link->cur_lane_setting[0].VOLTAGE_SWING,
+			link->cur_lane_setting[0].PRE_EMPHASIS,
+			link->cur_lane_setting[0].POST_CURSOR2);
 
 	while (size) {
 		if (*pos >= rd_buf_size)
@@ -733,7 +733,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	}
 
 	for (i = 0; i < (unsigned int)(link_training_settings.link_settings.lane_count); i++)
-		link_training_settings.lane_settings[i] = link->cur_lane_setting;
+		link_training_settings.lane_settings[i] = link->cur_lane_setting[i];
 
 	dc_link_set_test_pattern(
 		link,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6421c896f2a1..750f1ae268c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -676,8 +676,6 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 				dpcd_base_lt_offset,
 				dpcd_lt_buffer,
 				size_in_bytes + sizeof(dpcd_pattern.raw));
-
-	link->cur_lane_setting = lt_settings->lane_settings[0];
 }
 
 bool dp_is_cr_done(enum dc_lane_count ln_count,
@@ -1145,7 +1143,6 @@ enum dc_status dpcd_set_lane_settings(
 			dpcd_lane[0].bits.MAX_SWING_REACHED,
 			dpcd_lane[0].bits.MAX_PRE_EMPHASIS_REACHED);
 	}
-	link->cur_lane_setting = link_training_setting->lane_settings[0];
 
 	return status;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index cc4b28e94727..368e834c6809 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -372,6 +372,9 @@ void dp_set_hw_lane_settings(
 #else
 	encoder->funcs->dp_set_lane_settings(encoder, link_settings);
 #endif
+	memmove(link->cur_lane_setting,
+			link_settings->lane_settings,
+			sizeof(link->cur_lane_setting));
 }
 
 void dp_set_hw_test_pattern(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 56340a176554..a73d64b1fd33 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -121,7 +121,7 @@ struct dc_link {
 	struct dc_link_settings reported_link_cap;
 	struct dc_link_settings verified_link_cap;
 	struct dc_link_settings cur_link_settings;
-	struct dc_lane_settings cur_lane_setting;
+	struct dc_lane_settings cur_lane_setting[LANE_COUNT_DP_MAX];
 	struct dc_link_settings preferred_link_setting;
 	struct dc_link_training_overrides preferred_training_settings;
 	struct dp_audio_test_data audio_test_data;
-- 
2.25.1

