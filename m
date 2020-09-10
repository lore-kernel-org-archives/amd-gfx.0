Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF10C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E4321D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R3LkBSzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E4321D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2267A6E938;
	Thu, 10 Sep 2020 13:47:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFB96E934
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKpsfirVyYtoXBNDIKoAs87XXYb08awfYasBMF6pSOOTvfE1RH0GsMDzVNNz/zvEyBmVJlPHSZHt2AW1zjvMC7HlJYyMkDiRqWNOzahDQEQsgKOQvdM/ZEDQVGQ/0GuDTYcOUBtFNl3IOACLE4o6MSdXD6xJXSh4Hf/aRJRysSzySppCue4iEvJDAP0f6yunqqzDXtE4XFX/PFgXEerkqCFCYdsoCyBR/CGFnp+LT49ImfIz4rSoVhcWNc0UlaxmUnPuI5IyL9Fym/M0v2WLvYJeXyaKqRYhGjTC2cxgsEXqdz+B4Rl0KZQS2ywo3mxcwhMPPZx6KPldlRvkTaslBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luBQYareLimzsK0SQtzzroOL+vHohh6BqMrETDV1KtA=;
 b=VsQU7Uoxe7Ywl5N+3InT6FO+iNJEHbSm+gmyyaYQqsJK0ZTHZHrj5XOe6MxIb1mwlbPK6APvZBmLMagBG7I2YpQgBQLxgP5pChFudyQalOnpX37+HRGZmHbtWEkzuNKdkfcgW4vwO9JXqr75Ks29suBZJLs8TB4haNPRcs9RX41ENBDug4dkGxTg8Ota7Num/WBI8K6/IYC4E6TQdz980QKeRNO9i7YvZ/kYxuYxyLUWiO0ddmSK6IetPe+cg45NyHNjfVZD+/g3hXU4hft6ELZpxXYb8ra8KAI7F9dMt7k0nl58BMf2KoSUTsaQB1QVbJ6FKMCHJ0R2QP6ZlSz2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luBQYareLimzsK0SQtzzroOL+vHohh6BqMrETDV1KtA=;
 b=R3LkBSzmaiSPctmpdK11uY/nV47o0hALhuFtNYR+bQeUqZii6TsSYxhaJbyZxN1pKJcZHRPru6Q9ge+IWpio4Nj0tts1NZF++e2JwfUXTbzHCJbIRa/nqvJnARezL4JeR6IFmrd8DihKTa5ZNlS9WLOR3JY5eJEuq74M8hkA/H0=
Received: from DM5PR16CA0043.namprd16.prod.outlook.com (2603:10b6:4:15::29) by
 CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 10 Sep 2020 13:47:27 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::8d) by DM5PR16CA0043.outlook.office365.com
 (2603:10b6:4:15::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:26 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:25 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:25 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/42] drm/amd/display: Fixed Intermittent blue screen on OLED
 panel
Date: Thu, 10 Sep 2020 09:46:44 -0400
Message-ID: <20200910134723.27410-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc250772-90d2-4918-802f-08d855900e01
X-MS-TrafficTypeDiagnostic: CH2PR12MB4117:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41172589F4F339514548AFF98B270@CH2PR12MB4117.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eg6EqJkSzuN2+rpubmzKNi4trqW1FVUUAppjO5i2NvqWDJTawOrQzwoJgZVn/bavW7m4gXZhBFNMQqt1Avp/6jx86dxnwPTwOuiiCxr9K/IgyCPvOm6vDnmkW8Teo/GpplFTUgmYaf2iNuI2BxwLW7OeS5AZGkaOxqHlg7KYgA3mrKyzaZG9AF1KBF8o9ST0aeUhRunW+QIhvWGyYM7u6ajATo7krXXTwXsWUdxUVlgTu+bCYlAfiRd4VEBYCJYxMUeq4pgLjAYpYyWGKrhGBZ/nVEHL0LwhzJz6L9DmF3m93TiZmWdeHOkFDLNHcorLWx3U4W9QXuCwPrSzCEvcXQ2AmXbwR3TvyWlnPefck7LuVKWae9BFtjHrkFK3uERl5VahZhtc3QHfvLmjpZbYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(6916009)(5660300002)(8676002)(70206006)(44832011)(8936002)(426003)(336012)(86362001)(36756003)(70586007)(478600001)(186003)(26005)(4326008)(82740400003)(47076004)(54906003)(83380400001)(316002)(2616005)(1076003)(356005)(81166007)(82310400003)(7696005)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:27.0716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc250772-90d2-4918-802f-08d855900e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
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
Cc: Naveed Ashfaq <Naveed.Ashfaq@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Naveed Ashfaq <Naveed.Ashfaq@amd.com>

[why]
Changing to smaller modes on OLED panel caused a blue screen crash
as driver reported dram change during vactive when it shouldn't

[how]
Added an extra condition to prevent incorrect dram change timing

Signed-off-by: Naveed Ashfaq <Naveed.Ashfaq@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dml/dcn20/display_mode_vba_20v2.c  | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 80170f9721ce..860e72a51534 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2635,15 +2635,14 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 	}
 
 	if (mode_lib->vba.DRAMClockChangeSupportsVActive &&
-			mode_lib->vba.MinActiveDRAMClockChangeMargin > 60) {
+			mode_lib->vba.MinActiveDRAMClockChangeMargin > 60 &&
+			mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
 		mode_lib->vba.DRAMClockChangeWatermark += 25;
 
 		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-			if (mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
-				if (mode_lib->vba.DRAMClockChangeWatermark >
-				dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
-					mode_lib->vba.MinTTUVBlank[k] += 25;
-			}
+			if (mode_lib->vba.DRAMClockChangeWatermark >
+			dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
+				mode_lib->vba.MinTTUVBlank[k] += 25;
 		}
 
 		mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
