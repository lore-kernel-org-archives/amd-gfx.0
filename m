Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF244C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785A461250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 785A461250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F6C6E20E;
	Fri, 24 Sep 2021 19:09:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78466E20E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYn2RuI+qr/eO+s0aZo8iFU1D7jC1sPXXK1s4S/Y/S+Uu0Rk4nTb8e1wwG7jd+u/v0K2rbrvS1lUaQBa40h3PHXlF6zk04EaSPRxDF7L8AS7BhS00Ibe+so902LXyqL4ySoRE7gyitRC2I0gU6o/AUdHOht6cQ257KrJUhBmM0RcI8WPKOPTpiivu8SzniO2rB+kT0VNJRol1SbB3J5NFJ4UNL7yrRNT+eWtIA02GUi3p8mdncGiz0HDblGsJ7E0kj+kewPvTKFC+Gn/3uYUUr8XypyVebDDFWfHfU8Eq7xgok4cP75UrF9clfvZtrepnwoJSTa3tw4wc+3Xq5YLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=K47i1ut11uj0qkfiOFPjRQT1rKnIs/EdXNP2pTQtc+w=;
 b=Zohavqb404xPpFjdLuv7tejiVbTO8p94h5w+NEJUZd06nZBJDaLfbSpnqXGC32VGI9QBDSI15IXdIATNCm9VRFw8Z9j5y5ae9JpOATBNgR+adccWKVQOlI6llysjUR3PQ3OSfPfyF2/ZJkCDlWsASxcfijHSF+wL0JA+9HJbGRHQ/NkhBB+B1x34MNR5pviDrDT/qPgZy355lbjYCVS5tAf5cNwxu5AMfSRrWHDnTd3rbUMoxU4z+hHbZMWRZabinlnCACV9OU++GdfHoC+vADkzTaWyNWlD9mUqGbhyBdjQKG2jzrIYyGBSuDjXn7FWqOwoS4gFvyVmUmJykcgxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K47i1ut11uj0qkfiOFPjRQT1rKnIs/EdXNP2pTQtc+w=;
 b=O7nHmvqQmeD/Z7eTZgvjOmqsqc98lUNCe0KzMqOxV2zmSgs0/HfY2PZ1YB5GmEtPvkaY2IxAhHv1jufd2aHa8/Xc0YvBL0U1O7jiRmTSsQlStq3HCyyxX9nwAg+M2DzZ492Wpd/yDDjRuSlR7HKAXnOPMNaES2z53BhMsrTvcQk=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by DM6PR12MB2953.namprd12.prod.outlook.com (2603:10b6:5:189::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:09:53 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::d7) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 19:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:09:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:09:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:09:50 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:09:48 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 03/24] drm/amd/display: Don't enable AFMT for DP audio stream
Date: Fri, 24 Sep 2021 15:09:13 -0400
Message-ID: <20210924190934.1193379-4-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd42c43-9212-4c5a-d654-08d97f8ee368
X-MS-TrafficTypeDiagnostic: DM6PR12MB2953:
X-Microsoft-Antispam-PRVS: <DM6PR12MB295376F79818137B00459606EBA49@DM6PR12MB2953.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxWqS+TYb0SQ6McC1awRB/eItwW3sBF31TDqBdRGrhbRjbmOcfApF6HCA8uYxGHnrCdkdLaD8XvfiwemRGUOGcan0yemSxq73Echl9PXJKfBzhlbMGLDDLGF6FzxigtPyKC3G9E4wGmkaF6IXqLqw4GAwWuT0dSTjL0JNvy3aMQ6xrp+ibpdeVBXuKOimXRkrJtVXbwEpZcNPgWtThl8Uy2qcQOrwCPz47r6urrgkquBtrUOLTVN6ep3ny648UK6J6x6syp3Y7+nDndJowH5FOLc+Sy+5KCaGqQ6NgvanoMitFnZVbs78oHMoUQPv+NYzeb7odXyhoTk89ta0U1juPeKRg4PmpkZy9rZiMLDkl+SiDrPWhJvcGouRUX7ZsqGQ6nreoEABy/EQgtx/6AeXmWr43HqcBMfNdFOWQc1hWOvwDFvJOJ8gd84pm9JXcPVxq0lx/4kk0AHxjirhhS02eYt1URzwgFJLjxNd+/QXyvqzxjhT3lNso3ovwT/4hiBGW2fjkpyLs3yUqqMHBz1ncCDtqS23WyvnNX3m9CGShUxucA80ObtQvNNN4vHXMWvDW93l05a1RGBTVv6QU690K7acCBPgoD7jU1P5DHsekMWwq6IcmL6A2F3ApqhiEWeBR02jLFV6dd/1eE0OsTidLWEYS8A/L4gFBxwMkeYo3/NWkdJy5utIykwgzsO+4KS2rDZxhEMTgOZVwL7Op3uj++KNNktCU9yUxo4DcR86ik=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(81166007)(1076003)(356005)(47076005)(426003)(70586007)(82310400003)(508600001)(54906003)(36756003)(2616005)(86362001)(83380400001)(7696005)(4326008)(36860700001)(8676002)(186003)(336012)(8936002)(6666004)(26005)(5660300002)(6916009)(2906002)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:09:52.5498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd42c43-9212-4c5a-d654-08d97f8ee368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2953
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
AFMT is unused for DP audio, so powering it on for DP is unnecessary.

[HOW]
APG block should be powered down instead, however HW defaults to shutdown
state when not enabled so no further work is required.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c  | 5 -----
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c  | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index a97bdaa54f73..687c3c6881a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -1402,11 +1402,6 @@ static void enc1_se_disable_dp_audio(
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 	uint32_t value = 0;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (enc->afmt && enc->afmt->funcs->afmt_powerdown)
-		enc->afmt->funcs->afmt_powerdown(enc->afmt);
-#endif
-
 	/* Disable Audio packets */
 	REG_UPDATE_5(DP_SEC_CNTL,
 			DP_SEC_ASP_ENABLE, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 3ea6dacec80c..ebd9c35c914f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -710,8 +710,6 @@ static void enc3_se_setup_dp_audio(
 static void enc3_se_dp_audio_enable(
 	struct stream_encoder *enc)
 {
-	if (enc->afmt->funcs->afmt_poweron)
-		enc->afmt->funcs->afmt_poweron(enc->afmt);
 	enc1_se_enable_audio_clock(enc, true);
 	enc3_se_setup_dp_audio(enc);
 	enc1_se_enable_dp_audio(enc);
-- 
2.25.1

