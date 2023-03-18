Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBAFC74A5B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B86310E24D;
	Sat, 18 Mar 2023 07:57:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C4510E1FB
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7bpq2fh5AINte/cojJev7koROzHMhiZMnUxwC87CZDbEyVeRR6BYe372iZh14jd9AQOpyduhIbhbsSVH2kRR9RzvbIsU3MxwQEusXR4fmbWgzaulL9WyVBuIppKJyyGAmEGVzqm58OmkqqeQ3lbwJker1pMru/4V4EI0GWa2NnehNVbCueJQas06ItUuCcF+ocnZp+gOpVe+O4CcIRdyWABO+Lzw7JqhyRtI24TLq55I29JMphhgbk63mevXFIUC1xOjeyYXf1arDlcoDciqz6cBXXuVQmg6UZ7ynDd4064GK8ra4Z8TbAofK/5YS8lJYk2xvmISkq0klRAMCg8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNHMImW+QawPhURHWhOJQUyMMM+ttDxqxjAJBW57Wkg=;
 b=h7o2sslOJx/T5FOcu0gR6MUebuY/O4du58y82CokWqflsyW5efRDcKubQDlAqoNVIs4UWgSu464oLal6/qgIP+0nwA8x5Rj+nKUPm2wezRthgN3v4+/sjc3hR3Vts2vnMD7KUPA5RUDi6MS16axaS6jCrn1Ahc4jTHmbv+y6X4M3e5WdgJk8RJL9mC8UrykRdrnbQOVQGB3fCf5CYLclhAtMxcxE/Nsf0+YAodGreIaMm+5SZDA9sMPvWmgWHzUZinMJws3tOr3CXigwweoD+304BGOmMAnIUvLnpOVPgA25zgNma22GxvtNUWHwSxLfrsvtVdwisyqKg5XlbuSYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNHMImW+QawPhURHWhOJQUyMMM+ttDxqxjAJBW57Wkg=;
 b=WAd+bkzCHqzqKreaeISpg5Zlyq7zIgfdvqr3Uoc3BbQc+NJ+U3EUjhtmbLBDNgGPcOScVK8IlCFMSDXxBnHUDJwdNep5RvU4rpc6VWK/f9mjXG1nchG+qMDROX35j0QfKya4rGygrF3Cf3eD7mKqLQMWLhDdCQQkXk8bdXpRHb4=
Received: from BN0PR04CA0177.namprd04.prod.outlook.com (2603:10b6:408:eb::32)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Sat, 18 Mar
 2023 07:56:56 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::94) by BN0PR04CA0177.outlook.office365.com
 (2603:10b6:408:eb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:56:55 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:56:50 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/19] drm/amd/display: Add const to a function
Date: Sat, 18 Mar 2023 03:56:00 -0400
Message-ID: <20230318075615.2630-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b6c569-ea63-4e05-a869-08db278657c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaHmdEmvw9OegLLG3Q+UFMjKtcRd8M/U6WUGSxaQ3iwT8NX/UgxxacIm7V7zI3LXvnURYZ0f6Usb6axuW98Tc/Ght+7zWHpI/KdzBfvCJqilg16QFB+3UZ5LdEnDh18GNdb7DOesO5kQrU0zRj4aMN7vs1vaQ16hBtuG8wwZfsqsObKUih2xJoZKheUA9id8ZkkV/3t1TQfyrRb1Z0uAj/g1XP7Ih/Z6Jd7X6F9RoTJLCkaxHJF8G0DP+Y2vdBVImmVLJ1L1Wv9UyZJKMss9B17mzZB+ZHo4Kz0HAJ3BKwAVfVSPYQr4aIE7MGC9cHUQu09ghuooNRP2247DDtvRUZf7tAMmawTkFcT3wSSYN+3kc6j828Pgx8zLhQt8XQ9FpZaQnktYa1qGc0Y38cbRwccIh80sq6BQC2OHAGz8YLlX0Uo0KHTb47JFKBSOce81aXqa1cVzhqew3GFILiIpp87X+MiFkWODpBipKhNZA1SlddABZymonl/VXo5oiDw94QH9qe+e+kAXgUEM9O5yZM7ZhHNgz1Qbj3iF0dcG84yOh2BHUEgbnrU5BsXtL8XULUukYpHXO/0kDj6k/LQ4ELIDDpUJ7Dj/saygapzkHfiUxqaN3JEswpZFJhveo3dS2bcYzdUSxuVCezbMXp6wyxt6lPSL+5ac7/oKXNlqIVGgE/3sTjDb3OpQjY76O15NSewo45HJAVNoQu7S3sz9uEexZYib6LsEV9/UxTX2vPc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(26005)(1076003)(6666004)(426003)(40460700003)(478600001)(70206006)(36756003)(36860700001)(336012)(6916009)(70586007)(81166007)(82310400005)(5660300002)(83380400001)(8676002)(40480700001)(82740400003)(44832011)(2906002)(316002)(16526019)(186003)(54906003)(86362001)(356005)(8936002)(41300700001)(47076005)(4326008)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:56:55.4391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b6c569-ea63-4e05-a869-08db278657c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

When calling the dc_link_bw_kbps_from_raw_frl_link_rate_data from
amdgpu_dm, GCC highlighted the following issue:

  In function ‘get_conv_frl_bw’:
  error: passing argument 1 of
  ‘dc_link_bw_kbps_from_raw_frl_link_rate_data’ discards ‘const’ qualifier
  from pointer target type [-Werror=discarded-qualifiers]
  997 |                                 aconnector->dc_link->dc,

This commit fix this issue by making DC a constant variable since we
only use it to invoke the function
bw_kbps_from_raw_frl_link_rate_data().

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c | 3 +--
 drivers/gpu/drm/amd/display/dc/dc.h                   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 58fa911b1417..d24bc0a0b1d4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -285,8 +285,7 @@ int dc_link_aux_transfer_raw(struct ddc_service *ddc,
 			ddc, payload, operation_result);
 }
 
-uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(
-		struct dc *dc, uint8_t bw)
+uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(const struct dc *dc, uint8_t bw)
 {
 	return dc->link_srv->bw_kbps_from_raw_frl_link_rate_data(bw);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2818483964dd..624acd402eae 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1768,8 +1768,7 @@ void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
 bool dc_link_update_dsc_config(struct pipe_ctx *pipe_ctx);
 
 /* translate a raw link rate data to bandwidth in kbps */
-uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(
-		struct dc *dc, uint8_t bw);
+uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(const struct dc *dc, uint8_t bw);
 
 /* determine the optimal bandwidth given link and required bw.
  * @link - current detected link
-- 
2.34.1

