Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 17:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164AD10E41D;
	Thu, 28 Apr 2022 17:41:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DC310E41D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 17:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIASsPeQDeA1SS7bWmEwKbLC8HsRcNO6PWpBmugyebB/WuH8YzWK82ouUGzRf8BxkU5i9gJMCj9W3cIErqb9ibFrjwBCL++ISq8+Ds4S/sxP/Ry4OtA7v+16BzNZ9XjMDNzj5qxgkhWMpFirHMWw/V9axJCqhJkQOnrk1lkImEhOWUVWUZoFoyhlLIn4d8xxh5+ekK+45WbrU/rilJ3HzfYdByJE5tVw+6Dm0UtZMZq8zcjAsdIyht1BPb5afSUJ4pRC6AVDHXeFIbLP+6NiGRlgvHHciwO28iyJnQRy7go4t3K/F4Wi3gDyNEBh2iut6hc8HXxQofSvlyXMWVRX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9d9I/z2yQnsWgY1ZQQ/AN4eIRXUCBObBw3y7wM0HMU=;
 b=M681Vy6vW2xnS1S1mhEdMZg8d5ttDbduSly93aIaynxXDSNQ76rBzHlyYVI1Ors2ZB73BfkS3ahIYBt2nul5u/fyMS+LzWwghUjBO6cO3rdUKf308i9ZKSUTEWIeOTzLdRb7w54EC8xta2Ft+C9y2IXCRDczi7hwmVZVCASeZpin+2w1NShTqL5nWpCyXHuI7sYfkWF8tpAYHxNHAdqun2vqNhHPEAFXVSvShx8xk0YmVC3YtKUE6yzcVM9Wg5xLcfIc3iW/BGZiOoxB9sjsuj62A8Xx/07TZS785ZQZ8kQXGVBPckG2lmhQ2/rNjt9OWFcWanMHhNpBo4C7ao53Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9d9I/z2yQnsWgY1ZQQ/AN4eIRXUCBObBw3y7wM0HMU=;
 b=CCHkFF2BtUL3nHJGx5H/nFM12GgSAzUDlqIeqg+0SDEc73oj02TicOaf193D35Pk3l/qXhuTFJb1WwhQMxiV/WW23TxcrUIHnYzjxeoCa3texRRV/BWCSHsNFL+7ggDCOWL37xKlBfpHy5nxQU3QbO8IRNuMsffpYa9kAC9beJs=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 28 Apr 2022 17:41:29 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::59) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Thu, 28 Apr 2022 17:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 17:41:29 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 12:41:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 10:41:28 -0700
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 28 Apr 2022 12:41:28 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Avoid reading audio pattern past
 AUDIO_CHANNELS_COUNT
Date: Thu, 28 Apr 2022 13:41:18 -0400
Message-ID: <20220428174118.131226-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b90f55a-50e8-4e56-4854-08da293e539d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4249:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB424906A5C4CEDCE599F8C19D8CFD9@DM6PR12MB4249.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAaOlNFxjFQZ1KLkkTZuywlrSkWUZLYSqitfzBT9AI7c1TaptrmhwwHvfc0bBK8C+kmqnsNhvic6ZvxNUHllWGTh22q5+hi4pz0E2KPzpZfhiwKPixSd3Bjw9ZdJ0lTYKjW8YI9+E9nAYwh2VKw9Q19vCPEIKwdu7dfVqApSlQEGEgM5CvduchmTo9UgtE8xQFlaTuRjtVJSyYmzFQ8vhhSABYCW/3OGu/fkzySasCaoXg/Q0tmaSjKRojyTaQ0vweLTt9yHo4jlozsT1w3h0+U0DNZzy7XfazOeyZ81kNYyKm//EAc5erTjrhnmKsP2mFvrqObZBZfaazWdiBW0kP59VV+e4ULgDVxbC2N3/WxZfQ6UKcviSygyQnPlcV4eRJKyXhILaRTqtF3mggQVF2nzJIdyhpsXph8RHSmtATt/vAPZaiokF8otvdB1KpvLJxmMrXOM5GKH78NnBz3GA0OuxICQAkZTIJcjhIDswrud56KNoWVegdKPMuQklcHE53cupZgFtEuuZ4iGHmopspxiOYxmKlOy+jj+ff6rC0S6hjoa0X7cz8YaS3vHb8eoMiaP03IP3950Pi8tGfaog6ZiAGqdeb+0Q+qDaxiDVA0W1Kc1Cf5i9vdXh7986Eo+Z1i2vtR7Opsf7drWAVfPujlyzgJzD130kwCv0YStZFyrRfMayN/LVMGXkkkWHysfHTFrryEbGfoiqZZGXo0Omw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(81166007)(40460700003)(36860700001)(356005)(82310400005)(7696005)(2616005)(2906002)(70586007)(8676002)(4326008)(26005)(70206006)(5660300002)(44832011)(47076005)(186003)(316002)(86362001)(8936002)(426003)(36756003)(336012)(6916009)(1076003)(508600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 17:41:29.2780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b90f55a-50e8-4e56-4854-08da293e539d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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
Cc: Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A faulty receiver might report an erroneous channel count. We
should guard against reading beyond AUDIO_CHANNELS_COUNT as
that would overflow the dpcd_pattern_period array.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c15c46b81111..55a5a6a49fe2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4464,7 +4464,7 @@ static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video
 		&dpcd_pattern_type.value,
 		sizeof(dpcd_pattern_type));
 
-	channel_count = dpcd_test_mode.bits.channel_count + 1;
+	channel_count = min(dpcd_test_mode.bits.channel_count + 1, AUDIO_CHANNELS_COUNT);
 
 	// read pattern periods for requested channels when sawTooth pattern is requested
 	if (dpcd_pattern_type.value == AUDIO_TEST_PATTERN_SAWTOOTH ||
-- 
2.35.1

