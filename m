Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA800C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7602E60BD3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7602E60BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D3826ED0E;
	Fri, 15 Oct 2021 18:39:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6466ED0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBX25y6hK8PxN2W8/7DxycCg6tfxgGzB6c1BtiXsP8Gw0tdJvS7cWqDZHABDR46aiASzJo0te1007Z2p8fdY1/esx6SGanaQ6WN/WEzL34j9HjfUQqgfVHneysUTNsaO+tw5NCSXwK3qmRNfQbEl8Bw/y8RQWj3AAxLnoosqhoxxwsmNr0Dz/4Xg+6I9AXYeMSbdR95tjyE/kb47RUe4BEOsXbmJexc2hziFHisbhDVrLroSnw/W1EE7wv8ESi69TbM52Vwmc8wqpL5YPP6eCxJt5YhnqKdwJK25TsTDT6yVqpvdUUhE9e/dsuV6YFXq32/eg1D9zqDbECOwYQNjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjMiqHqRGBVj373+R//3MZX3OHEmxs4LiFbkB3j/gGk=;
 b=OnCvnfm7cvWxnRzN+acV7BzZqyX1VHVTdQUsxB/JPCbnAOB7ZVzfP2oGNFcR654eNpsfWda0d5umo2NoAvRi1hVQHk0qv0AzAW9d/XSq4z89C8fAn1YO6plHazOEDQGG3tXTwwADMUN/57FCnV3TT+SPjrzm7la1OdAbKm7YW9hPLsgiLy0w6cG59yyegSmusjT710sE/P/UmPNJCoDcAFpORKynS7h5IZFDHyrRBDACH6hmgmkpZkfW81KJYeT2Mj2xbq6Th1CgRG3TYNgUkgZH1lKD8k5Ri/dWYuPv8mrwXggUuh4WbDy4nr8lSJe7INiCxjtA17lApE40TduA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjMiqHqRGBVj373+R//3MZX3OHEmxs4LiFbkB3j/gGk=;
 b=YPf8zuTzoEiy9goDREnFU4A6ZoPtF6xM52u2M3gFkR7lxLcFulVwmgGL+XY3au0o3LPJGZwrA8ZCGTysaP0ewyTrl0qslmSpKrQ+v6TlSO1Fm/QJZepRp3zFJvznUsCvqRPfjIVYpbdL2P2Yup7NiKOUYyZzOwoyjLxzIATq83c=
Received: from MW4PR04CA0235.namprd04.prod.outlook.com (2603:10b6:303:87::30)
 by MW2PR12MB2377.namprd12.prod.outlook.com (2603:10b6:907:11::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 18:39:16 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::a3) by MW4PR04CA0235.outlook.office365.com
 (2603:10b6:303:87::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:39:16 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:39:13 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, "Ariel
 Bernstein" <eric.bernstein@amd.com>
Subject: [PATCH 07/27] drm/amd/display: correct apg audio channel enable
 golden value
Date: Fri, 15 Oct 2021 14:38:25 -0400
Message-ID: <20211015183845.220831-8-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015183845.220831-1-agustin.gutierrez@amd.com>
References: <20211015183845.220831-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adb52a21-0ac0-4205-87a7-08d9900b177c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2377:
X-Microsoft-Antispam-PRVS: <MW2PR12MB23774B735A8328A283B4F943F5B99@MW2PR12MB2377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0bso3/j88DEFnqY+RV6xrFFebtv1AhhgC5tydoTUfELQarn+GU3ms4JSzXls1DxNT3vP6iXjeiuB6gy1f/FkBEX88Qeijs1V8PeYNpzxMVK0aSxhr2T7qbqJY+JnrYxDff3v8Ap3t1gc4SIRmjUVX3u37VQYsaneZbxsd4zji/vdjAPtaIwnP4AWy4OhjedD20AZzy6VUPq2p4QZuituNrQ8FsrqYjgpV6cPzoOZI1NzaY49OLcCuwVhZiOgKlVWf5sTZczjVkkqoHlAhRU/4cPvSpM4CFnOGIeseshXp/s6+FrQ/2ysUO5Et5owxkIxIt6IOCd2rv5VsCFIu+N2SF2N8urvPZuc+CBvS19cN2R1DBNyoBl84lVp/zu9pfvw4y9WtZv/t8jw1RXBQ8H87iGbSCFRoQTUOxUiUg5fBN5l7g3eol42g0Wl4ySp6hobmPJassM6W2nnaOcTqosuNg4c67rQpSUYJayTrpZf9QYVEyWAQMrlAXSxZqBE9yL26eVlN+PgeMzRPheJYqscgGNOuqcg3cZrIV4Ppc/iq8i3uKRAuvEU28pNYw671UsqeXmyfsqkGY9eOVBHVghuBCZTYLZ6tPTUUGtWsxbjgWK9ZLObU6WXWMfdGkXJabgK0NvXPKvvNppsckpyXl8X62FHaNM9/HdurdHcgLVvcV2L25g6gA6sHumLalP78aoX3QkJNTRLayoK9y6C4wMuLo2lRkI1TI2jxNexBLc3MI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(4326008)(356005)(36860700001)(86362001)(508600001)(8676002)(36756003)(47076005)(82310400003)(83380400001)(6916009)(70206006)(316002)(70586007)(26005)(2906002)(6666004)(5660300002)(336012)(426003)(44832011)(2616005)(54906003)(186003)(16526019)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:39:16.1096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb52a21-0ac0-4205-87a7-08d9900b177c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2377
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

Hardware team has recommended to generically hard code this register to
0xFF as part of the effort to eventually remove this control.  However
we set it to 0xF instead.
This causes 4 of audio 8ch to be muted.

Reviewed-by: Ariel Bernstein <eric.bernstein@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
index 6bd7a0626665..de5e18c2a3ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
@@ -129,7 +129,7 @@ static void apg31_se_audio_setup(
 
 	/* When running in "pair mode", pairs of audio channels have their own enable
 	 * this is for really old audio drivers */
-	REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, 0xF);
+	REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, 0xFF);
 	// REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, channels);
 
 	/* Disable forced mem power off */
-- 
2.25.1

