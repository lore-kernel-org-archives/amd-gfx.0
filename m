Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E977CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F26510E4EE;
	Thu, 19 Oct 2023 13:34:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD7310E4EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JS9pejO037iBySX1oYIE8iFoUDu6IL6Cb7DiZVc1t7VBX5Hp76GPllTNx0H8VbPaNHPjE97PHJOu3W3MPVji3ZCCuLCv21HR2HiJ3/UTl2FHDm8cCND9qBN74Dld6rjreDgZhDPRM8wXr0MKkDghd6N0XGVYg/P+75iIGygnby7HRo++P9qTbgEi9Q8IGjGZ0r86PiC/LFqfWmWRlIDFzchG6O3VrAr/9NxB1Befp4S9F/PxNEiGOO9uTIPD1kWS2zqtTEQPKKmfKZ8scdvljHJyogIUEDSAWY6Awx80FJXaFoDR3wHmrDOsy2XnP98cF2zvzEYtNWo/XO8ST43iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmVpHqPFS/mUL45RycBUiyWY5pVdKPg4CddLl31vYKo=;
 b=Sbb2CcjYtakUC0IVqs5a5uT6YCfYUnrojc4zYzc837LK3B4TiIWWN0GTmWag/zO0QzWtN3UotuPu+OkmCm/aad67i/wkFK1+v8SEmpW/isT5qzUee5eGd9HEFdhYcZzrMBXNM4VKKLxR5y41dASqBg5FlZf7Grh6Gj2afegDeWeVcYq0olunBKZtkaKXj45IkYM6emh5nxDy6o5ndanV2QMVJWdOQkW1Enc3rMui94u8AqbQBz3iKhTLcV5nBzA9zlQSVrAoBlIVzDVZZFlshBDbU/r5+YfY0XF+ZXXuUOlL5sCfbytkhjpDSjSEMkTHK8vKcT/h7eklAAVNU8Tj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmVpHqPFS/mUL45RycBUiyWY5pVdKPg4CddLl31vYKo=;
 b=uLNxI7xcGPwrSCn1mxUSzvxk68eSdqEK19lCtgGhnsJ7dWcO8ZKGi75Ia5k4w8/aNIGpDq4DcOALK0rXtSvh46fcV3zvc1s28AkVU738SWKwrtMpRe5DV5WuGryxfuaYizj3is7/kqsaaufh90h96XoVUk3YgFMGo+h/FZAWNhQ=
Received: from SJ0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:a03:333::17)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Thu, 19 Oct
 2023 13:34:46 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::27) by SJ0PR03CA0102.outlook.office365.com
 (2603:10b6:a03:333::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Thu, 19 Oct 2023 13:34:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 06:34:22 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:34:21 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 22/24] drm/amd/display: Disable SYMCLK32_SE RCO on DCN314
Date: Thu, 19 Oct 2023 09:32:20 -0400
Message-ID: <20231019133222.1633077-23-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 1944dbe9-1f03-4ae5-68a8-08dbd0a82903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5gIeKogEoQQ8CEj3u0Q5o+zUCVedGJv9hLXccNRwkCfxfFTOngpWqL3khYQQb0T+lbuna0OtS0xXj6K2IB+DUTbGrNkqoauA+pV23GQ7zTzqrb7prgLL+oA5ijlw4sv5Rpmhlb8AEPvl1UQ9DS8b4O5szYmevzbkvKmfRpJnAeeMXROAt0xo/wE4a4gDh1/XqHozTMaUJZbdouHd6Fu0WHMq+NX0AK0jtmt082cAznGk0MJtaz9TjmpomNaEhuiuPEuUWu66WTh1g+XdX+EmaXA5UN4ubIOsxzWq9HN+coNM/tMLLG8oPN/d79hquvj58y4NSHRcyztF0q/oVwgVP+wvSEZULL6um5ai23NQKlsznKwe3muWNBGUJm7jzGOpGCu6XIdxp1NfU7QFpDsU70fPHVBnQnM5Xj/Bv0xox8/TLJChoCoCRj2eSLbHZS6hFNtkF1t1GVcqlInQnra7L7tw3gMc2ZrwoCvx82ssAPlt+4fJkcTX3+K9TyaZ/ap4cLR4Gyj/SHialWa5RAgrCPybsxOu6ub8IePr3x/MU9VjBV4zHUx+fVU+3ZbpHipQoxenV9JSg+S0XvtvJh1N+K3FB+pkMn7xWKw/BMr6gwp8SMWKIfpuD5x+4Pt9s7YjuoKDE3953wNg0i8ADyxp45VAQS+gEzF6l6K8ikuQnHjNjZlEz8jvtwD4McZz/auLqlaAqnUq1J2N2NBDxdO2Z4s/VhqW9uHLA4JiaBUyX7GRHm/yda8PcZunrm95XdZV9sYjQHrf9NZX3Om0FjfPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(26005)(2616005)(426003)(336012)(1076003)(82740400003)(8936002)(8676002)(4326008)(5660300002)(47076005)(83380400001)(356005)(81166007)(40480700001)(2876002)(478600001)(2906002)(86362001)(41300700001)(4744005)(316002)(7696005)(54906003)(70206006)(36756003)(70586007)(36860700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:46.2510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1944dbe9-1f03-4ae5-68a8-08dbd0a82903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Currently causes some DP link layer failures, backing out until
the failures are root caused.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 2d7436f2ea82..48bd56ca729b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -916,7 +916,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 					.hdmistream = true,
 					.hdmichar = true,
 					.dpstream = true,
-					.symclk32_se = true,
+					.symclk32_se = false,
 					.symclk32_le = true,
 					.symclk_fe = true,
 					.physymclk = true,
-- 
2.34.1

