Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB509C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A7A206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="28vsGW4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A7A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AC989E1D;
	Sun,  4 Oct 2020 17:19:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4551989E1D
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGijip9kCOpHI9D/v85PCMmHNawY9oaHBtTOuhyrEbZFyFqsNlrNbySpSntIKIWe/bXVXBK/sEGCDFOmIOeEKKWzRE5aMompkC0COW2Vad3nIUoRhnvLfHNNKnm7mCc+GcQG+6e+XsEYfgZ80QuB/APQSy6SidbDlczmgqnQ7BC2YNgnhievbPG39yvoi3UoDapJCE/oqbQsLrRQpQwjYWUtJwwtZ+Y7CVANVDSBK9ZmEdFz2Nui84MhoqnubZZbO4OdgUbz/dRaGiG0oFkyQ0c8WV6ng3ddaXFmLiNw/cljaFusFyPCqJmYXIwyME8ezEcF57xEDe47Cu13QDfWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B+RH9GSyZx1ElcHugOol+TvS/H/UEOY7Ocomb0ahjQ=;
 b=CU2rI7qLVNR2z4rvwf+pz4JXEw+6cOIemtKx4BkDKoSdYaUmGS6oSeCpiqgErB3kv3UuHCzhJ5S52jH8yWkAhxU7/EZRYTmOgEC2lbJp5Owcrli/KoR6ts1h5QDpp9VxRo1Rwb8KkD3evtcRDHz66P7OW7agwtLCUC/TQuW2saucbcARjV9ufItpdv41b2rKLjK9fhrXmCeIAxI0eY3JUeTMhXz/VZfETQjEJxY/lReOGTZxfWOSH9Hha7E7VHTXcNgW829mwh6TorK6+BqPsuYJXcGoEHsUcj+CoLCc2R4doiSFx+EDFgavV0obyS3izw7qSbC9ke0aAt1428m5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B+RH9GSyZx1ElcHugOol+TvS/H/UEOY7Ocomb0ahjQ=;
 b=28vsGW4cdbAQ+5NIHRSiix2K+ABVcTsENOYCud9fEnY4rwsWwYMk5mZUgZMu1LVKm3Bhs4PmzY7wUTUsFVkjhfkG6xkWGqzCsLKpPLGbBwI2J0ISA5Y4mOlz7MXfDQET7mTVbUnu8OWtKMwjDfNAVjeBzFXabcRCOoSueukxPCw=
Received: from DM6PR06CA0028.namprd06.prod.outlook.com (2603:10b6:5:120::41)
 by DM5PR12MB1385.namprd12.prod.outlook.com (2603:10b6:3:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Sun, 4 Oct
 2020 17:18:55 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::7e) by DM6PR06CA0028.outlook.office365.com
 (2603:10b6:5:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Sun, 4 Oct 2020 17:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:18:55 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:18:54 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:18:48 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/18] drm/amd/display: Don't allow pstate if no support in
 blank
Date: Sun, 4 Oct 2020 13:17:57 -0400
Message-ID: <20201004171813.7819-3-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35f3f8a4-9858-4008-88eb-08d8688992a9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1385B1DCC71A04116D4C5A73E50F0@DM5PR12MB1385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnjWG7XwiDL0MOMFXD4RqkIbUZiARj+2ov+bl5izViEJYBGFRPlHdyUsmCD3CcJHlVr+dldNmFX7NcJqPQR2DjkY1mRic0ngOgkKCxTHjm45fJsM7NI1p4SgCvEBMZ+/BVzEDDu/LiMJUbyXIpA6R44X/LKyOV2PVc36m43c1VM9UNgDM7DnqhdVvzFfHICJ/Q/LQRr2ITfbF7+b+nnfWfORmfbi++QCGaEk3Wma8fGVfNxYg0to+FK4lvD0hBU03K15+poJceQxVdYLNOKeNs6roACBw5p7syPchcxu2z48d2Q5NCG4XNup3C+QiJSYXqgv0hXlyBbN/Zo/m1TRnNFRzY6NpteCxD0UeCbJqeS+LNFRJuZkRgGRuS0P56NF77iKSfAiVgIutqDem88H6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(136003)(376002)(396003)(46966005)(6916009)(6666004)(86362001)(1076003)(426003)(336012)(47076004)(5660300002)(2616005)(44832011)(2906002)(70586007)(70206006)(478600001)(36756003)(54906003)(8676002)(4326008)(81166007)(316002)(356005)(26005)(8936002)(82740400003)(82310400003)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:18:55.2338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f3f8a4-9858-4008-88eb-08d8688992a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
We will hang if we report switch in VACTIVE but not in VBLANK and DPG_EN = 1

[How]
Block switch in ACTIVE if not supported in BLANK

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 50b7d011705d..9e0ae18e71fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5558,7 +5558,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		}
 	}
 
-	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0) {
+	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0 && PrefetchMode == 0) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vactive;
 	} else if (((mode_lib->vba.SynchronizedVBlank == true || mode_lib->vba.TotalNumberOfActiveOTG == 1 || SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank > 0) && PrefetchMode == 0)) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vblank;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
