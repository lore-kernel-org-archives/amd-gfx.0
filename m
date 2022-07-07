Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F754C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 14:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D662E14A57E;
	Thu,  7 Jul 2022 14:57:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460B118AB54
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 14:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBBwfNPcXd4LV0SINmbN8elXz/050nwB4MQAu/ieS9IFU9kxqHGMdYPSV/tCXkUFBEF8gDaUj0SJ4Fpc+Qx/b1yEZ64ImyBP/UlPo4YHXbhOnjoDweKaVvM6cyAs1JxoCgvqWKTrJ5hpUo4WhMugahpTbxnFCGr2/4QGkCyrh+fbO20Jl3Ry37U6bkGCe2Z9heLMztVZ37Hu7CMcyJdj7J3fCWKteeQreU/VcpomJzbOAcYCewqoS9URNQ2xjpaLRFFrpaiy/P35ZP+0m0BbRS9c1dNCHMmYW1/3gMc+maYRRQ2OYFNI283t/inUhH9baBUh6jGwciVzTqvkBUHNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UyLPcJ4gkAwe7x/fKWt6UeuWW6AuMvHoK4U8jFphDs=;
 b=MTRnnDXW2LYn0cS2SjaCoHDs9NrXcBcHr7W8+jf7KQ0dJB15UuJV1sFasuq4o+KtTl/djjWThYAj51kYGU9qZKOLfBk6HD+NiqxUczGyUq+AdL5LNUheTWuoO/c7aZi8IR/3+StGZH7QDFU/TYQp7voN9I+DPu6uQE1k3jGh259ud5OTstAjukqOrCar79vwrxejhIePndl181O6fNBZcMRiz7mUJIVYcMn8OyMyxqKotEWU/+vRu0HZoPOjDd3r3mEQflPO14aFMSn9Nxyt+p7iFvwOPObJc/3NGucQXGcgd2MrOHQukna2mdMjcIP4GEqesSfFeiIm3VW9xntkrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UyLPcJ4gkAwe7x/fKWt6UeuWW6AuMvHoK4U8jFphDs=;
 b=19wFNWBNuI8OFk0kPT0BFHe1Fo25dn3vVNiYZNbd60dPnj2PUepjEB7gozIhKR7GJ09YjBNlcnmJ0FmN6fpJHITiqBKbNcrLPLo8JSrk7CFM62KkCA9Twq8vXsBfDO3GT0CeUZUtBeIhher1D7/QTjFVDHF+lpK/0EaFQvi7/3U=
Received: from DM6PR02CA0044.namprd02.prod.outlook.com (2603:10b6:5:177::21)
 by MN2PR12MB3440.namprd12.prod.outlook.com (2603:10b6:208:d0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 14:57:33 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::58) by DM6PR02CA0044.outlook.office365.com
 (2603:10b6:5:177::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17 via Frontend
 Transport; Thu, 7 Jul 2022 14:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.17 via Frontend Transport; Thu, 7 Jul 2022 14:57:32 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 09:57:31 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Add dcdebugmask option for disabling MPO
Date: Thu, 7 Jul 2022 10:56:56 -0400
Message-ID: <20220707145656.565627-2-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220707145656.565627-1-sunpeng.li@amd.com>
References: <20220707145656.565627-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8df8180-ec26-4584-e00e-08da602905a2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3440:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kh4Lh3H7+RkNog2gteiuWcNiurZPSneuQXYOY8SEimkVGCTbo9ZQf3HHZ9p57/5fMzF9QW717YWxvBuR+UcHPCoj1j9QJ0sjnLLeUvZsQElQk9x3cMcXu/2umIbed12UflBCe2zF4bOz1GKKCVs83Qoy7TosNfpHvGpUD7VqC0nEhZSo1xG3rHYQHfHAstPwxhR6rfxyVSZMDdbfvD30L8dnAEMlv/njFr35NsOz6NMCRkSinQk0YrUtYnO1GG0t61/6K1/eIQv6a5SHXO1T2+a5MqsOwPR89/NDtwJA74KCLRLax4vw0mX0QqEnXdICce3DqRzisbDGFt5jPknNvI2QKOxU+24L+yWRc4MwupKQVuaSD+veAx11fgmqKdgu7V9k/uIKfsSQWoZmG/NhgAfh80d82+Imh+vEQkM4OfjoOU/6hBT4La9mTPSt9v/P2h4jo1Aa2HF3pGWgRZhNRV56Yx5epV3ZH20dc5oMB5SNN0GH2gwkvi5uEKvC+qbU6afktxZf17r/lfTKSoaY9d7FsxOBo0R8dpTKYhBwPDvHjWHiXegNmw25r//9ZmgkF71lSJWvrgILq7kHqo9KDAVOyy/6ySw2ONRJMXZvj23QlLg8zF8xc/BXN9b6pGDawtJItNdMQdXCFa3uTuagyZ134PYzzs0Ne0O/WcPfS3JRAn5qst7RD1pW+mGD2OFnFDL/6uMDaDAFmPb35dtOMUM6nfHjYC+KTDF9SxqCnirZa87tARLz10PTc+xdQbUr630R9MRXc//+jE72Vyx/GQtUmNSVLOJNA84iVydG8k2ionDUsZHBUm1O4KG7mHVtsfMWBpvXV/MhSmW4XKpipfNo5JsC3iWbVihWCIZlNcek8oxDMcBQqW6Wt8JoFjCp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(83380400001)(8936002)(356005)(34020700004)(36860700001)(70586007)(70206006)(478600001)(8676002)(82740400003)(4326008)(36756003)(86362001)(41300700001)(81166007)(54906003)(6916009)(6666004)(47076005)(82310400005)(336012)(2876002)(426003)(2906002)(7696005)(40460700003)(1076003)(2616005)(5660300002)(40480700001)(186003)(16526019)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:57:32.8801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8df8180-ec26-4584-e00e-08da602905a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3440
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why & How]

It's useful to disable MPO when debugging or testing. Therefore, add a
dcdebugmask option to disable MPO.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d7208c0b76b1..4cf11bcc01a4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4194,6 +4194,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	for (i = 0; i < dm->dc->caps.max_planes; ++i) {
 		struct dc_plane_cap *plane = &dm->dc->caps.planes[i];
 
+		/* Do not create overlay if MPO disabled */
+		if (amdgpu_dc_debug_mask & DC_DISABLE_MPO)
+			break;
+
 		if (plane->type != DC_PLANE_TYPE_DCN_UNIVERSAL)
 			continue;
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 1db21d13726d..f175e65b853a 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -249,6 +249,7 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_CLOCK_GATING = 0x8,
 	DC_DISABLE_PSR = 0x10,
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
+	DC_DISABLE_MPO = 0x40,
 };
 
 enum amd_dpm_forced_level;
-- 
2.37.0

