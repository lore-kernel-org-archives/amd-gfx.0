Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5227EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2775D206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bkKPGJPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2775D206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E35616E954;
	Thu, 30 Jul 2020 19:12:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4206E954
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9wq4BdZPuUXVShzml2kphFiLA4I6cIGM5VErTYAJvEwWEbfawTKjUyLLub8C/nnOwGAFJsu+Oo+vpjJjgDjuFWhv36XnmAAvNcAH598GnG6C3JdjRsRx3tx+ysQyUZoxdUd7oto2PbPyVnO3dMWJveFu1ObLR1kXjq+IhCvlfNo8iNW/jZyaSPL3QYvY4VCYMix6snA2m+yST5tg5Yd5R0rlPjhrhS0M5rECXPvYsm55o0UmC3s76OhJNW1VDHRpDDfdo/wZF1YyF6aiW9eNyXBk89qiH49Tqcxg/cTV6iC+PYWIzNRuT5B6MEryLco/MmGOCUJMvkpLyhQ/HHYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u5c4n7J8cDeiruY0hAhZ69qfGeH2mEh+VpORk+8jS4=;
 b=lTKdo3vS6Ds6iSjaHsQYZsGK9O/BxI5GwF6lFypyTJIi+11y5nEtEBzkqD2gXanf5tpJMvahuzgyPCAehGrHi7T7Ya9fsaNiamGubAe/vlCUotsNBhE1mQatSsT97hCujgbzw8XNVGkZgNrCsmgo4vmqSbd86MkvXiKbIsRlxYvaGZm9pzYfj5dKrhwolT4coR3CvMiVyC2qJaJPcOB1t6bW6en+DBaqtzXed0wvlXiYiy/3MITv1W1QOQ7eLuXNnnoGu+HCgfolWir1nx9tdJUv1+1Vn7KunbXZjyVuIy8tuGdwH1QTH6wxhvB0jTYoYsr5LiyEYMWykHhGqGpWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u5c4n7J8cDeiruY0hAhZ69qfGeH2mEh+VpORk+8jS4=;
 b=bkKPGJPgPN4L2bWTwv/fp+NjU0sR3SCncGmAjz7k8MgGIZAhMRBe8sf3nRJKY7X6Wdskyz2ewF1NNOygPlcxin/lhtTDh/X+eh1b4OKyCj6f8iSV24QOPEuW++Yl0SfCqW3csvNM0ckocV/ayLksHQlbPk9kAd+Xwd52Hs7rrb4=
Received: from DM3PR12CA0051.namprd12.prod.outlook.com (2603:10b6:0:56::19) by
 SN1PR12MB2383.namprd12.prod.outlook.com (2603:10b6:802:26::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 30 Jul 2020 19:12:03 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::e5) by DM3PR12CA0051.outlook.office365.com
 (2603:10b6:0:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 19:12:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:02 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:02 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:01 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: populate new dml variable
Date: Thu, 30 Jul 2020 15:11:35 -0400
Message-ID: <20200730191146.33112-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c2b6c11-b4ab-4bae-59a6-08d834bc7161
X-MS-TrafficTypeDiagnostic: SN1PR12MB2383:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23833664AF547A0D1E7482E08B710@SN1PR12MB2383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RP/KfB5/SvH02EeCFXqwG8kvU+PiCLZdK/WiJh3tnpayZ8Annz6hjn2O59A/uBa3rm7RTX/UMvt2s6s1B14TidnyUyywKlyvCRDTCXyjH35mRyzKKfiwx4wCQ6573N7rzJRJ6lPnmhUBWSDhAWR2EFYolkljrKgAfkEyY3Wce0wUwZXSuLkkhMYJp+B5RIJSOTTyOM/aTW5zTW3huUhXyqYvWgmLXXgk4HZCE1sROW+jMmndQ/Lh4cyJXhH1cB9lefEzCqmwY9rwqNcEoD+qQq/3PDa7oPDKgpTSJ66yo5siZTpkD6Kx+SXD+50aWUTFCh4cdJxX/r3gnvmLhJU3jfOiR330NKTMrtwTTZutDTBEwNz/BNlWPbEii5vlpDPXSq9kfGfmnZc+j2jwi+qrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966005)(54906003)(8676002)(8936002)(478600001)(316002)(6916009)(47076004)(336012)(82740400003)(6666004)(4326008)(186003)(356005)(1076003)(81166007)(26005)(2616005)(5660300002)(83380400001)(44832011)(70206006)(2906002)(7696005)(82310400002)(36756003)(70586007)(426003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:03.2786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2b6c11-b4ab-4bae-59a6-08d834bc7161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2383
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index b0064087b9bb..afdd4f0d9d71 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -467,7 +467,8 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.AudioSampleLayout[mode_lib->vba.NumberOfActivePlanes] =
 			1;
 		mode_lib->vba.DRAMClockChangeLatencyOverride = 0.0;
-		mode_lib->vba.DSCEnabled[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
+		mode_lib->vba.DSCEnabled[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;;
+		mode_lib->vba.DSCEnable[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
 		mode_lib->vba.NumberOfDSCSlices[mode_lib->vba.NumberOfActivePlanes] =
 				dout->dsc_slices;
 		mode_lib->vba.DSCInputBitPerComponent[mode_lib->vba.NumberOfActivePlanes] =
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
