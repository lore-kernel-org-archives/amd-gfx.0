Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F99C43460
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6265A610FB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6265A610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD2B6EC76;
	Sat, 10 Apr 2021 02:05:02 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680076.outbound.protection.outlook.com [40.107.68.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C5C6EC73
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdY1M3iMXj5Xi8nVhioCuSSf8dompDxl7gkYPU5EtGU0P+BbZxGTZRBWLYhLENL6KQbkF5gxr9HeT/txUqQJVb7W8rKTJVk3+EcONTdTJJKsAkElB6HMM+moTp9ILDLzGsCVUte2TaS9R10IQ/rtUJ/tXr+8TBpQ5wMpuFJcHFxrjsLLka8Vhj1z+f6C4bRKMN4DxSdBC29K8hn560c66XRzEIWgu34+7kaSxRGr2fIpngUN55y3s3dpmG1A6DRUpdfTRpBjmjFZPtFV/jYGNjGhUzaQSXnygn390z/1MKZuiDQWhj6b18mkMgsjgJld5/2Pjmn3x6xivXeGHaKtsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqew/2v1uIPuSlKGd9E4j+ItFhfMK4ac9CwbBAkgkv0=;
 b=JqLIclTItXoAe3d505VscrXA092ij56sTm01A15q/FbsxdyxEZzPkzFKKwybgJ/7L40T7FeHuGcackIbRAY47ud4t3wH9904G6ums5HgWTENjZ2yQkWfX2me2Eyk+W01dJSMK0694dyxUQiAidFE6hGVgjsv/eDIsmKQaP7W+lkl9wszNYcAvEQmiFZvWF28l45Wup51WNaaMbFetgAiytHMnIRiEYUB4VyPZAGLymdWlYU8UzPSxwL68dMU/89xCOYfb//3uanDYeYOxAW625RnIOTSMxtgKDp1gYtTXeGkSuGCdm4qu953Hq5F0o3Z4gvT52384dZPbEl3JNOq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqew/2v1uIPuSlKGd9E4j+ItFhfMK4ac9CwbBAkgkv0=;
 b=1inbxHzd2SDYyWUhhBgQqizUXs6dnNmo4y8l7DvW/nqbAfThayQ8w6Pia2hTfYkJDvdfb7GOfqv48JUwWf4hwOHUVALfXixgZZa0VOR0MbhwC0krI8MBlcZwqJdxI6otP0DV17TotXCjedN9JROW7OtzpjCMPZdw7Ya86OfMr7U=
Received: from DM3PR14CA0147.namprd14.prod.outlook.com (2603:10b6:0:53::31) by
 BY5PR12MB3858.namprd12.prod.outlook.com (2603:10b6:a03:1a7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Sat, 10 Apr
 2021 02:04:52 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::a2) by DM3PR14CA0147.outlook.office365.com
 (2603:10b6:0:53::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:50 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:49 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: Connect clock optimization function to
 dcn301
Date: Fri, 9 Apr 2021 22:03:54 -0400
Message-ID: <20210410020401.1100228-10-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2819ae9-897f-4061-7a43-08d8fbc506f8
X-MS-TrafficTypeDiagnostic: BY5PR12MB3858:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3858C9DA808A9E80719592ECF5729@BY5PR12MB3858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4Y1xQ0S/WHe25OaF5M44k4VACZnKWFBWVwis066H4t3GtNPajEBD+rwcZih5QtQF+uuw1Ol5Gl3/ZAesE07H6BLadB2+ldQB0pb2VC6pdcez8W11C6ExI7vQxpv900I8ICIK6ejMjwnJssuspE7p5UeFpxAbV9q2rJAE4xiAYwTzI+uzDmAGvaZdvqXEKGpo0ot/EhtHsmJkfWuxNz55K128H5wBjxB685RM61SNKhQ8/bOcYT1XHLucztkZYBtT8/uszvJMibiCFi6NHfoS45pdhXagAMEqOactDTWat8sF+1e2n+iY0FyeNcXJTaViYezgALlZm5y/U47L3r4QlQuhntgWsQAnUKA3gCl06gV1rthMnyUS/UwtoFSCWy6QLIIICIX+1lHb4f2ET8JDni7e0Y335SZ4q7u9AnH01dt9l+euiUgS/sSW3R/BDR9rcWyAzRgTLr7sNpK3JSXsTOP/hTpTVvCmXJ070E2Q9JEYymEy7PSms52LTGIokpkPd10DjFCFn/G3lE3yhIANpEfHTE2R7sryFwzL75LzKkjnnsnttzniwr5svfxrCxUoIG84/xQTx7Ft9GCfM+Z7alrOEqEXPrLRVuqOTYy/EuKrQDARh87Cv2DsadDHWpxKmeE4ywS1g83D1wC1d6S1Ia/3ygk3BUIaMlv7rhCLEndMoNMdGb+TFPtzVN7yc50
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(54906003)(70586007)(5660300002)(70206006)(186003)(316002)(356005)(81166007)(47076005)(82310400003)(2616005)(478600001)(6916009)(8936002)(336012)(4326008)(426003)(8676002)(7696005)(36756003)(6666004)(1076003)(86362001)(2906002)(26005)(83380400001)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:51.6062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2819ae9-897f-4061-7a43-08d8fbc506f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3858
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bindu Ramamurthy <bindur12@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why/how]
Connecting clock optimization functions to dcn301 HWSS
to enable power state enter/exit optimization

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 0d90523c7cdc..70b053d9ba40 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -99,6 +99,8 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
+	.optimize_pwr_state = dcn21_optimize_pwr_state,
+	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
