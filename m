Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE505EE49B2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0F210E450;
	Wed, 23 Aug 2023 15:51:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E8010E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7zb7Yb+qzUONoxxCjCHfxB/xyq3ePuGGBHYQNHwj8Sb0kO92NCSps2x2SorPN+cvwr+mlcUDtLZXE6tJsMjOwoRg5tOIX6ixdgHyY2YqEV5g+tqvtPVX8GGHk6Mdl4YJH4yQi2ZsgCjucrjXS5zziNeFGHwa9T4LZsMVzY6aEeU4UJ5fcgDmlpSnK8TI57WvcPpXJfT+z9IxbRDD8pmvH0F9wHKuirdcQBH/IWmar0mfzMBEQozDIl0+aJ5lgC6ub4PXvPl/UrSDpCZpd+CV9EtktLpyHORBDnNYGwnbvS4JCbAKmXwAWOrpBEoncs4IcIML448t3262V3M8nszpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhdI3UeuR4wFZRP3TnIeot/9MC8XL+makKwFlu5n1nI=;
 b=fLJwmBhBCFM8cguwkirGjTkVxqZBldEL0nNiYhye1Yzt5XpDAi1Qa662PHO4HK/aEaKwhMfMhCs3zu5acFtm4EoNE2JmeIFsQUgu//PXDjBgPOvcoBBg9JN9sGOhmVDwop74cH0WfcDZIHV1q1yJoCIqgpnmkmC1icRNJMWnYAUJi56hmxjOxugsinBOjXAIcXxevcl6DStfx5nP71FBdASmu36Mtlw9noEZkM2YKhjddphDkUiJVPBfscHRylD6KanhRrcDIJHzpwcbKov/Y6yB2xxIRL/DqUkf+gFYlJJnfOxQ6jDPJ3Yjx9ohpIEsy+MQbB6YylMghkpe3bGUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhdI3UeuR4wFZRP3TnIeot/9MC8XL+makKwFlu5n1nI=;
 b=mRB5uq6wrh1a6D9k/4/QP+/ri0JnNxXlESynbH2eHUF6f4OdTILwdPmgW6kOqNobbMmFa75pSAEFfFT5FljmckKZhdVMrQF9JyqP6MrT0f9NiUyarv1waudveGaJ+tmVicryMoXL1CiZjHCTRwURp61iLr3pEJEs9yy37neTWdY=
Received: from CY5PR19CA0033.namprd19.prod.outlook.com (2603:10b6:930:1a::35)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 15:51:27 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::e2) by CY5PR19CA0033.outlook.office365.com
 (2603:10b6:930:1a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/35] drm/amd/display: Add DCN35 blocks to Makefile
Date: Wed, 23 Aug 2023 11:50:45 -0400
Message-ID: <20230823155048.2526343-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: e0396824-b619-4a45-81e3-08dba3f0cfc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltTWwrJ65FBqeacJSyjaFupmrr2QpeawAYxWqXy02rn5lXmgdSyzKnK/3WPIZtoo4vi9rqw9X9xpE2z9kzlwDvjbP2Vsg+0GC2I1EYn9E755/fPKEaAjkN7sqnZb+b1Ih6sTrGiyerMjKKurEFYjgNkSDSghfyv61a2sUOwCw/Li2MBLJ4PhdSd5+2POYi18C/0vYXu6ng1+hI3eKMV4Hg1pWmUpw3HrIdLy5JQXzDPsCiSEcPqASqC1LvWoe2Ai6Z65waCBh+qAQJ3gKD1iPDgtdZ2eKUJ/BIAd6YUNGannGgdU4Gnq7XgUf7fs9YQbjkTkFHqIj8u8hEXCHBVP30wyfdnGtdvn9XcFOHXHlZgdtXkWUqKiee7/eRSa1GEIL1vmBxS22KrAApIR1IYi9HSLc0gVj1vqtlcQRyKPQjmuuUlNQ8i0wrFhUM/iN0u8TvilEiwFJc42WbHNhXHUBrtBUw4tkkDV4YLtvPonocRBG/NS/vHpziWP2XMSju2JTymRGetc2cqehjP4cpBQcwDBlEDCEvozdaJqJaSsLiCLWHvaMdLkhKT80U+RsTpkhr1UxsopHZZwM7oq8TCV4fj5pXt0R3kbSc5U/eY1emL0U/g+GXhfGBmvx01JVMmX4k9mQIlMh7D3IjxIPxfbU1Ylxei2MTtvuERHICdHu3/OKp7FAGFd5rhxMigHBHK44ikYGZiZenCHhwOmCtMLjX+wTbTtXJ8ilDTWkm4dfDs70MOeOV/7YHDSkTQdyr5Bz+VdNPTSWMVZ+k3kxrosug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(40480700001)(2616005)(7696005)(1076003)(40460700003)(86362001)(4326008)(5660300002)(4744005)(2906002)(70206006)(70586007)(54906003)(8676002)(8936002)(36756003)(41300700001)(6916009)(316002)(81166007)(478600001)(82740400003)(36860700001)(356005)(426003)(47076005)(336012)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:27.5072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0396824-b619-4a45-81e3-08dba3f0cfc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Enable DCN35 in makefile.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 75b5a416933b..56662316cd3d 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -42,6 +42,7 @@ DC_LIBS += dcn315
 DC_LIBS += dcn316
 DC_LIBS += dcn32
 DC_LIBS += dcn321
+DC_LIBS += dcn35
 endif
 
 DC_LIBS += dce120
-- 
2.41.0

