Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E4CC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 18:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD8E112230;
	Fri,  3 Jun 2022 18:51:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3370111222D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 18:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obNuNS8n5M3ZhBwUAp8qaT8ziHCjmdRWfuVUu6uEc9ABhJqydANZvmi+5W0U780yvsdEAXSyv//iTu2WS8n4Bwf5LRkraYPTT9KmFGfVP4rmFUPGF9Qwu+OCUSfAhCg836gKRCg6ciKnNCr8OhP5pGAi183mGdB/nCueyisLnpY4S7VZIC/xo3dljt+NiIis02jqzB3kL3/GB2SSf3Kv7zyFMG9grbP5LuEEpsEXE0BXc1eYbqX8sx8bKqgwmhj1siO2uzzZ2pCSdxLChft0hwdZjdCLJoEgf4XmnVKzu84l2qaOmGwsuiVGuMOZZh1wfSeg9mTDDJkqMqMFsKRoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Go3J24iF4NKZ2sM0gYVWysFyfcFO3ODADQXyQfrMu0Y=;
 b=BRa9m/QO8KZVwcY4Oi9HUUtQTjJ3eWMqO+6jRr62HoTJ40h72gVX5ZeINGFH06rMFst9FBeqFoYwgBDQa9JPYDqvSRvRpXAHpVI71iE/KoZe+TADJkWp6NjGVs4LwMbPrTak8DEqGzYrELwH4fee7lnP98QYStA9SCwp5nIZrTCJXAL+gELyUGaJyq7L40FtVKoPujKiCKdJ7Fm+yGIpKO269l0UunosUzpBTv5mX/g9iD3UuAkG2Q4MoHLRlNzRbBJpJUUZAFX6qGeXjq6cdsHK9yoAHQjowokB0Xuscv6iV97kbhWCqXbo0OP6EngZUGwefOgZMutOTy9yUqAtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go3J24iF4NKZ2sM0gYVWysFyfcFO3ODADQXyQfrMu0Y=;
 b=dWfHvLvhyu8+hd9DsZ+kBvzaY2RyVCjbDdVnH/oM/1Y2/xvK7h7EkgLINWJhS4lrn+5Vy7zxKKH++HPcr9DRXqTbQBawqstLaDoHapZ2IuyvcUSU+dYLUMmy3/7WlRg06wsmqKImJGWTqUMDp0omo2jlwaWldqePdIFL8VDif/c=
Received: from BN0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:141::32)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 3 Jun
 2022 18:51:01 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::b0) by BN0PR07CA0011.outlook.office365.com
 (2603:10b6:408:141::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 18:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 18:51:01 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 13:51:00 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amd/display: Remove duplicated macro
Date: Fri, 3 Jun 2022 14:50:37 -0400
Message-ID: <20220603185042.3408844-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a8cf413-fdb0-4d8a-b557-08da4592016a
X-MS-TrafficTypeDiagnostic: CY5PR12MB6454:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB645414B82B62976815F684DF98A19@CY5PR12MB6454.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uU15JgDV1DojDvicayXRHgptmoFJP1W9bYYu9q/4hm1yiWv2mQarVI9ANaYDihHmNiW2eNv2hv7N7A73i3owGgBCek0mYZSDdQFlLOFnuxI9a5J6NGm5cKd322xIMjo5xCmx71hB3hWwD3eCFXPT/GA7+sJIsFq5UMT3Xfl9joDglzsqvm9JrvfOuMMLSeDf7vUvXDnIdn4tJpU8GjUr/nbmVExWYz41TvZ9NNJp2tRAtP3NFLdju6/CClLyL0GUmmBVaA403NKzlVwbTO9Ecu9JrxUpWXcuy628hszso8WqrEXyVgJj5TLISTKVjufRmxG6Mzb2/Iy+z1CS7mb3TdBvqFylMRSCujrIPhwZCLyaMTliNhhRCn57iHojHjHVZMV68a5PQr1uLKlNDcLglTM6pHKxTUF3dHt61OwM54Fy4Z5n3S0DOj5WbRAJR4AxnFTJdxt0f+B+A0VolVoC4QQxV0OOT943xyAUE6A8uUU12zDIKbE3OWT2WkX9R8FtJFr4zp6hm5X9BIZyNkuVgDqBK7x6iCZWMZizDO12X2n3dJKIzXwi1cMtp7OwZpeEjB2O7WZleE84dv+omgn+t5/GSxRTJOZfR7sLtyNG+jkaI4Wy5rWJ8HDpIlwgza5XaVHPo6tO7AHXhkWvPq7RCcgMu6VRQLE4LDiQMh2g0ksskR0m8bHeWBzS3GqGi/lm/iw0Dln7LZc0soyHFZzx1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(1076003)(2616005)(7696005)(36860700001)(186003)(16526019)(5660300002)(36756003)(82310400005)(8936002)(336012)(47076005)(40460700003)(6666004)(426003)(316002)(86362001)(508600001)(83380400001)(26005)(70586007)(4744005)(70206006)(4326008)(8676002)(6916009)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 18:51:01.7033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8cf413-fdb0-4d8a-b557-08da4592016a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 11391eead954..a0dffe30b394 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -221,10 +221,6 @@ enum {
 #ifndef ASICREV_IS_VANGOGH
 #define ASICREV_IS_VANGOGH(eChipRev) ((eChipRev >= VANGOGH_A0) && (eChipRev < VANGOGH_UNKNOWN))
 #endif
-#define GREEN_SARDINE_A0 0xA1
-#ifndef ASICREV_IS_GREEN_SARDINE
-#define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
-#endif
 
 #define FAMILY_YELLOW_CARP                     146
 #define YELLOW_CARP_A0 0x01
@@ -288,6 +284,4 @@ enum {
 
 #define	FAMILY_UNKNOWN 0xFF
 
-
-
 #endif /* __DAL_ASIC_ID_H__ */
-- 
2.25.1

