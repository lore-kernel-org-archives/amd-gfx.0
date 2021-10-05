Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B165EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B12E6126A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B12E6126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3456EB3F;
	Tue,  5 Oct 2021 07:54:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0636EB3F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY9x6KQti03mu03vfeuy63VBkrQH7HZusLNddnSLuTeccdMNucQ0QkfxfbY2kAZ1GbpFcQ33NMb1XV6c2yi3ENj/5nnFLz9UZ++m4ELYQAR0nFXoPcOfMx76+hisEJ3mf61tSj9m4BzI2WZrIq8jJiRUun3XwdXtBeQpTkWfFMFV5ZgiQjaOJm9CuGNdZNX9jIinmUcv07LvE4Gp3JqAuSfOsjsPEARAhhIxxF9ujDZe4z/w1rhlwX/C12S+A73Zkwa4/SSXcFzpUuIB/wcZQ97j8N7NwRZ5perzrSMrxYHHhaWRqEp9NUp8tgoPUvfR2XGBUY9qJLKaRmyhMrwBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vZx7pr0vxSXMCsTAI8ytWGdAiGWfCvhiZx5RBeOw6g=;
 b=la31q0Q3sjiYyHnxNiWpZ9NfSvv/gaP5fXnye2QQ7g/iT9ZLaYHyBW5PDaNvUoiCUT5YUeKvHi80mlnDNhHlbwBJ+lNgPtMesPcT1qATfr4LCFcgsCrNqWGuKskG825RwlFHEjxBx8p6x4ZU+Cr9CZj656gFf4CH6EWKo+VBMQeNHYhiNRncJk9FttR6NGZvwGi97I710mgQKWYwkLFw4izRR0xhsm7PFOrxuNqXfVmpGYAz0psglrB1Y33wWEjdI+q9FCvEpD7sbXp6BmKIafbb22lKCbSta2rfvDGT4Eo2ki+hDm1M9V9hKs9WiSi1nMPH/ftynojYQGKAoYK58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vZx7pr0vxSXMCsTAI8ytWGdAiGWfCvhiZx5RBeOw6g=;
 b=c8CunRv/+ONm+s05QmmNXSroFhleyez5dRBUZVG2kBHfdHbUkf+8B9iiry4CYTMeabpSw/E8OJdbU/Q67aWGRgHs1GnShetLdbBuOIworXf1yXj7uCbPJhQ1+afaVpI/4srzgHz5MIpyP+JFromA3tobh/VuhbuOCm3OYHDlLN4=
Received: from DM5PR13CA0018.namprd13.prod.outlook.com (2603:10b6:3:23::28) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Tue, 5 Oct 2021 07:54:23 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::75) by DM5PR13CA0018.outlook.office365.com
 (2603:10b6:3:23::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Tue, 5 Oct 2021 07:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:54:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:54:21 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:54:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 07/23] drm/amd/display: Update training parameters for DPIA
 links
Date: Tue, 5 Oct 2021 15:51:49 +0800
Message-ID: <20211005075205.3467938-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd3cabfd-2e15-49ec-4384-08d987d55873
X-MS-TrafficTypeDiagnostic: DM6PR12MB4043:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4043417674BA159120831440FCAF9@DM6PR12MB4043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLg6zBbWG+yFq+J65hye/MRPM+Q1TYC5yw9hn1fGVB/QBLVL63bG6iZKrK+0+deTp/wrUlTWz58wDJfkStCIZiYnlnwKwHhGAk2XY6xnc8oK5kbHiuRrLtl0uOn5hRYOvU4bXNNzxUCGKCBVaKO9ptIdtvEPHImXDq+ygwMPpGZ6ueFIN8KgTz/RgzQ1GLkY6SrxKNWc9p/McpEnl9PGp6rE4XVkNr7lz8Q+pwgltxtNAZ/d4t3kRv0x4nChagqrId0chpYj7cNgu4ORqTSCpqVm43bnEYMhnz/zzURgUj05Wioxn0SVkW5rapNmhvpBusoX+LNJApr51RssPpzeBDfdAg/hMWJF79OMM6l8lZIMGPB43ETyimxWEmkUI1i8BOVRRn41jzFf0M8wD7K55mrfthYZ/j97isMNgTY05gIfpk8RiGKo7W1ERBOu/RPjMHkTNvRkvA9hSzSmKr8YLrScYvASHpruV9SzgDspcDVDFwzAXarPnaarfoct62T9Qba5NKkeXJoyjk5twjIhkVjt6doNUn2uUZZ8b5q/q8ABMcWU0WhWULmE6hDhBMnmqLHmZDXUbm/GPmdbfU0W+Tnhf9e+0Y4qAwD/xW3NnBDOvTUrye5cfrkwHTzOxXymh7PuTo80E0imoCdMSW7L0C7f+SdSUbCLoZyGrs4nOqzjrqktYkTzm2aRt9a98ipr7jFDzPgMn+XCHEpIks+LI0lnwYN6ofvBYvlNRBUn7Ro=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(81166007)(54906003)(7696005)(2906002)(26005)(36860700001)(356005)(36756003)(82310400003)(186003)(8676002)(316002)(2616005)(508600001)(6666004)(70206006)(6916009)(83380400001)(70586007)(8936002)(1076003)(86362001)(15650500001)(4326008)(5660300002)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:54:23.0509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3cabfd-2e15-49ec-4384-08d987d55873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[why & how]
Add codes for commit "ede4f6dac99e drm/amd/display: Update
setting of DP training parameters." to support USB4 DP tunneling
feature

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9bc5f49ea2ec..dd1d0262ba40 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1777,6 +1777,13 @@ static enum dc_status configure_lttpr_mode_non_transparent(
 
 		if (encoding == DP_8b_10b_ENCODING) {
 			repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
+			/* Driver does not need to train the first hop. Skip DPCD read and clear
+			 * AUX_RD_INTERVAL for DPTX-to-DPIA hop.
+			 */
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+				link->dpcd_caps.lttpr_caps.aux_rd_interval[--repeater_cnt] = 0;
+
 			for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
 				aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
 							((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (repeater_id - 1));
-- 
2.25.1

