Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC7DC6FA91
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DE310EA0E;
	Thu, 22 Sep 2022 00:19:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AB410E9FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR1IS++tjYY0zExp1eCA+McTv95+hPDuqeTCdtSOhbs5f6euJRkAME7ChbVJm4lRjsFpW2UACYB4bqMfu8YGEGIiwTRGr2zNPwUtppkVnOPuuS69C6t02TYcigBR2/ijsHzjmNjyoKO6Rv5HHxYvpNVSnSeqV9ChukYi1wku4BKQP5znVKXpDz7RgEuokU4x6y3WdG4IJF6V9EK8mgZpn2z42xMtZsFBuHp1d+xtCeMf/I2QzFkWpnRYixXQvnjg40+UJUPbF9Z0uBvLGFgpZLzcN1gqYFn3u2a2jU5hcXAWsdDbosCri2n/8LOiyiN9b8JUfn2KGTYdLF9RRq/Z5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9pmdA6Ky1xO5u8zOFVkpOdgodOCAopm7eXs9gKsQLE=;
 b=W1ZOd4sCOuYRaGjnxSY2y1CWrLuEGbuELMGcGwxW7Q2ea2ehkGSarIthHInwbcmXO7rkTYcn5WXghW5Qb+tcdwdCzlgdpPNpD4/ZDyemSfIEvys4fdHkRicjfhpo21c1D3KZAY2jRnWWqrOoy+Tr0goTsHoCFUF4f5mB7ue++ewKGHyp3jV/Z2GhsGWm0Yoaf57KA3judD53O8bBJslk/MiXhJeWF/HAWwanGzVBnGYmKOX3al/JEkt+/9seo+yAKRjMmfOZ32gywuU+mXpEO2lLBoQKpdXWPW26Chqw/u00IHOD8Q1pmTSjXuTbGVJOrfrYC4umz0Rwj651xtfQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9pmdA6Ky1xO5u8zOFVkpOdgodOCAopm7eXs9gKsQLE=;
 b=T9ZjXFCwO6Op8nj6Vna+BR4gOLhSpTu8KuxOfkJxGJFn2ggj9luGFvzbxpsOY/OKOEruMADF1FZKJ36AbCLBU8IYV3ZwnejkSyT3T152zh0bGmFTu+TD7ijon9bg4pA3zA3cIAZ21USrF3uiNkuKvK1WUAovt/S5c8I3Frv8sFs=
Received: from BN9PR03CA0173.namprd03.prod.outlook.com (2603:10b6:408:f4::28)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:19:26 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::e7) by BN9PR03CA0173.outlook.office365.com
 (2603:10b6:408:f4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:26 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:23 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/31] drm/amd/display: 3.2.205
Date: Wed, 21 Sep 2022 20:18:16 -0400
Message-ID: <20220922001821.320255-27-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|BL1PR12MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: ca478ce2-c832-4f31-59d8-08da9c301bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6M9RvwbSHtbwtBVP51xmqCHEh2N8v4oPJ5SXqkEaweRcjaRFYFnHpejeZgi1j0IizSt83/811+VFvB0zqJa4J+/Hu/IABAutwEwGE5fA29knO91teqyWDraVfJQeCtGdTqQSzAokj5Fro2vLDiqmYmRdSGQMKvLULjt52lSNS+it9jFonXk2cyr+RBH3LowbIz4HzqpbRS8qTCMzfdzPP0slUEA9lMGs2i1Fm5hasWX9X0NX9dtxtIfowjR6WYK77UT+KKDoCEvzzE4f7ccMMBBwoASg0y0UCWxe+KekrAwa3Tn9oFLsU7eSTzhvMvHdXt50X71gqRCs7mGUrQcHk/btr8T+g1MRMqxxMFkD+09UXo3FcOHGvg0cG3zQep+Vz2rjiZhDyYv8iq5uoF1Sxjw0FTC0u1nH0UoPnSysPgDVQjrC/iN31L5QtIZ/QXQasdQsMMCf+7AFHNcdRtvLs992ya+V8eeu2rydqlhLYMVw1JcpYSEEnc69fCO8oF1Furd1XwrUrRCTJIyynhVG1V4XEXlWRDwGw2POQBRV3uk3Y+9v+c1sUJpg+3XK80+x3b324YJgIok+rZEmwgAgkcjAqzMMfe7+Fv6mOYfA1wnEp7JMfxKgOas/EtR1XABBpiWNGKitcfpB7fiE2vNC/W4uQCQ6EyzIeNzGewxV5B3OS8a21JRPeS0VYgIsose0ho39NXCG1HdR+A7apR8nZy3kv1cEU0b/NQONbVKeQgwvN0gGiVF4gUSDup+aoi9ohZi+Hm3Hq3j8Q1We65kaQZ+NBbvntNFIBzF92RNovOZEadfQT3/rSj97z9Xld/H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(6916009)(54906003)(8676002)(316002)(41300700001)(70206006)(8936002)(40480700001)(4326008)(47076005)(70586007)(82740400003)(83380400001)(40460700003)(6666004)(36860700001)(478600001)(2616005)(336012)(81166007)(186003)(16526019)(1076003)(426003)(26005)(356005)(36756003)(2906002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:26.4764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca478ce2-c832-4f31-59d8-08da9c301bd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

    - LTTPR mode can be be dynamically changed
    - fixes divide by zero error
    - features able to use same interface to update cursor info
    - fixes for llvm compilation issues
    - Fixes DIO FIFO underflow and other FIFO errors
    - Partially valid EDIDs handled properly
    - Phatom pipes are skipped when checking pending flip
    - Fixed audio on audio on display after unplugging

Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7db7929a7e81..2ecf36e6329b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.204"
+#define DC_VER "3.2.205"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

