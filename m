Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97105ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F152A10E6DB;
	Thu, 27 Oct 2022 18:42:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB2910E6DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1N2CuG7oQIfLGy7LsAAbfBBX2eg0dqgh3jRai/+e53Ip1AyvUMW1j59ybdfnNUrcwIWNyAjosRxibfJwWMBL2WaP8c3SMQky4czzKoZi8Z/4ZZTPaww0GKBYkz4rzNShU50LX9eMZwMUNLyuZwGh0w8VGYuR+1ufhsQwUZJLKrylDCmDaelrSO3VzPb4V+1GleRCmlqv6Kw5bIQRmjCvBgP/9a3nIVNrbdyJOAO9+fCQJ1ChYleyfBlb5uKDNOcHcSbyaTJQWryOlKpWkrOWfGuUidcWTK1u5B73uivlknYlsJ5/WZ0C8dI6l1NYrqEc/Xo8aF+q+FwEtmNKBpvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU2Em0n1y+Pi9DVLicQJjzwo+TiZJf3RnN8jlkYhC+0=;
 b=dAMPBur7kxjSF7ZayqhiLUnCcFoTGm8hEFik0IyJCZxiZOSDbsKBycNZJ5/4rHFf5CZphZ62/zx2bre7mvOlx25x19K0FzrfVuRFWz+z9JexbC5TeLM41SkfsEVAT1Qn4HYxsNLqbFl2ZL6kj0dYoUVehqFaxBErkmVyI4APcqcC+y6oxe0P16+RLN39TIAooDfVHgf7iaRXZnBDNQllk2ymQKYBrHzHH205ZVilLvT/JqLYQox9exAfyj5JYvGk/WllVR7UztlGQqHxYGiWbuwQl72a/A8yN4FAR5yvZ6pGc8cuZAMLrzyKKKIX725nq4RB/sxA27DQntScBqLn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU2Em0n1y+Pi9DVLicQJjzwo+TiZJf3RnN8jlkYhC+0=;
 b=4SJh1QfgvJx5rzL575B5JTHEdIOPMTKHQMxXkCxCRJHlPsNo8gY/q2GuwnFS6y5nioVwUFeo6n3ePxv5mfwK+ZNeRooNV+8lSbdCyOXK08a56JOmH1UYi50t9ZDIK2GQd7pFsGnKN4oKAauzSFJH1HgQ69sWGuR4uGCiRLQfw1w=
Received: from BN0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:e4::18)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Thu, 27 Oct
 2022 18:42:48 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::d2) by BN0PR02CA0013.outlook.office365.com
 (2603:10b6:408:e4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Thu, 27 Oct 2022 18:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 18:42:48 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:42:45 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/18] drm/amd/display: 3.2.210
Date: Thu, 27 Oct 2022 12:35:43 -0600
Message-ID: <20221027183543.1117976-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c83459d-81c8-42c9-474c-08dab84b0ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rY65HeioATG/L2Q+CdNB7SUWNrtV7K2EcXoEqJ2fOh0O7n7gg0wFUuznYHPL0rlNNA4ujN1DureEwwIxMxQFLFEj0bLbRSR29PHlJBUTgqPK5r8kb6KFlY6RqoZoV4pLLU4t0KePUmVkIpxSypElyRA1/XRqOjB//Feru0tPjfQDYtcyctn15DDj2f8M/wuWS8dDZwUkZEhoxNK9SW66hDVfj2wB7l/PipZ5JDfrJPV0+CI8qr9Kx3BBFX8kcPygWdbdjAQvwJ8wE2GdvmHrOZ6n4Ug97eOcgPJR354VO24sfj9hL2CHQ4eJcJoYi3Q3cul43YoqqHDCy1Oq7B8RwZS9nqGPqS5/8L0fNPOIy72eC/YTmTzG5LODvs+PiD4XXADFd4NWtBQCASaTdAwgxk8SAOlKdqOE+KkYqCA7qx8Bae0qFvt0nLYdwdbuVW3tBnbY697Nc6wIe7FRiOZRyfk6aVEH/ufdJ6g2AQBRZ1gzzaBwsF/2/oztVyA5qaJl8JfagIUpcWsY3Twr5CccugtgPdlXGfKeYBWVy0SOAkuWrYi5a4Na1aFXn+AJMVVSBTbB41UUIFhXPmoJgJ1LMJwNY6j6LDJkD6TvxlTleLNG7cz2AjNzy+ThlASyp8rJXdtBLclrZOeP1scQJE9+kEqV91by1jMwlLzmEtDbvf7owEpSEpQwCljX6MCPsPyBrRoWfzojwQUSQ54/3mQeM7J0yir4klM+R0jIS5ZGX7LWSHEPc2Xm0nP2VC7u6wT4eNwXjfOIWWB/xYVcYpXCbs7JHpS2/QoSri+mbGdFn+vDoiqGC94RetGrc5knuho7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(316002)(70206006)(36756003)(82310400005)(4326008)(70586007)(7696005)(54906003)(8676002)(6916009)(186003)(426003)(44832011)(1076003)(47076005)(40460700003)(36860700001)(16526019)(40480700001)(26005)(336012)(86362001)(41300700001)(2906002)(83380400001)(2616005)(5660300002)(8936002)(478600001)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:42:48.2898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c83459d-81c8-42c9-474c-08dab84b0ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC version 3.2.210 brings along the following:

- Investigate tool reported FCLK P-state deviations
- Fix null pointer issues found in emulation
- Add DSC delay factor workaround
- Round up DST_after_scaler to nearest int
- Use forced DSC bpp in DML
- Fix DCN32 DSC delay calculation
- Use min transition for SubVP into MPO
- Add a debug option HBR2CP2520 over TPS4
- Stop waiting for vblank during pipe programming
- Modify checks to enable TPS3 pattern when required
- Remove rate check from pixel rate divider update
- Check validation passed after applying pipe split changes
- Update DML formula
- Don't enable ODM + MPO
- Include virtual signal to set k1 and k2 values
- Reinit DPG when exiting dynamic ODM

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fb33540323bd..223c0a920f2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.209"
+#define DC_VER "3.2.210"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.38.1

