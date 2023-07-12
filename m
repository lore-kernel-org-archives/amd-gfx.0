Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AE6EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50A710E5BF;
	Wed, 12 Jul 2023 17:14:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500CA10E5BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7TGjcCVJKIqCsJqxh+UJaGMlh9hangbPxmil3k76EQn+eLB7bO4Tg/8kOeoG7eqeEAEIrDIaVPKTxJZEqECBe4/+Mi7R9L7LWKQ5l+koh/nruEBGJ48lhM1YFMwcWI7OLGLGa83el2iVBdUGh/rjfFgttCRPi/Ik5ZCXFSaPpwuV6rheSekAOwJzrjDjov/9wIIkBz8cHv+cUj6UfJwMH9U9Zc6lnu4z0+bUBsdnjOY69nKPILBUShVZTawLuMkyFoC+BROr7VMN4FLhCXpPymWNHJ7U5Xzqo5M9u0FcW0ZwV4jmWEeRMOVKMDXwHi+WYJXqk3bxnygSETyCbO33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf0YSfE+zR8yz2SeAcFdeVUDKcUaLfO/iZtBdhNERrk=;
 b=MKu95F0RtCYTGGlNMSbgty2ed1IPuvbfII9bY7jZ965AnFkXz6jxfhdZUPgwCnJSCaz6ouM836yl4w6Jxn6mU3IRMM8oUCy/UOmgroA+zpi3KRhfTogbJKySu8zQe1tnFYjM2MwM0/MtR+KXX8vx+zHUmHjCL0LOytelLU3B0k58SATefpXPMjn2aEKR8NnjaXFHdfDiq/4DU9NDQphPfDbYy+DjpDkuuMfq8KgD87hNPscwZ852uvnEn0XMokEaeneDF+asbPDI/BYN8V7QHAVMDkHIMeEEYIfDL14vkRUFofen0fNhZBwQG1FTpB4CbdUGH7+ruCunv7zK5GB3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf0YSfE+zR8yz2SeAcFdeVUDKcUaLfO/iZtBdhNERrk=;
 b=v/bBZzM9maBvZuMpa/IzIhDxm7oHM4vCn1+wmqrZmioL5mszdvZYTMt8F5f5gJ7XDH9/8KqFP1qnVU866kIRRBrQ7qTXmu+0v/wP9CKAsKzW0vX0BSPgnoxjbJqkB2eIl65ThA6WGCvsrOOGlFSULfZnjtUF5ru6uGuiORgpiLM=
Received: from BN9PR03CA0494.namprd03.prod.outlook.com (2603:10b6:408:130::19)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 17:14:51 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::37) by BN9PR03CA0494.outlook.office365.com
 (2603:10b6:408:130::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:14:50 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:47 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/33] drm/amd/display: Promote DAL to 3.2.243
Date: Thu, 13 Jul 2023 01:11:37 +0800
Message-ID: <20230712171137.3398344-34-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a48382-bc59-430b-2751-08db82fb80d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/ZrkYWnQDi7vCIzWIxRco63APpp/vkoXQl/iu6x65Li4EUBREHkzovggGx5rIPnA/8WW1lrDTOohPYecvUhupyOMkHPSFIJkoL5uU98rFIFaFf8s9LTeXb95jMo0IuZNl2odrqqkSiEvV9CXyJ5X3Jeq3Oe6kIoweqVXmq0A6GvKdVbxEWg2UJM+UiMKyZ35uXTFYKHeyOkJ4ZLdKqhMns4KrMBlmc0a9DvJRyZA4+XdWd2ogQ1orFuhjDeNTjueWHrGXwDWWOurGW1R8zjoWseeZUjZc65z1dzL5hbx47ILpIZh9hmF0niaMCyN8F1wiTxkWb3I9ltv0i+dLNqSkmQU2yQ+c2932NV7YSU+AdiWqY3dP+Spj5CscGDzM11BiHRy7h8NYiMfZX90fil/kJfizeKtrlN/M3AbVBSm3ji/BP69zDWll5RlmZ+Jay80+bg35QDyGzVCa4j1pSRJUW6Xnn0yDAlphNVvMhN0yITFX6dDyZ3/tWsLUJO44hdpMHiSCAR2Q4Pwy4tB65elMnglGO+KQmAJkSw8GF7Ru1c2b9WvGFMpOc2oLWxuyKbnvtgYdAmnJauwpF53mjq846SG0XP/8309nIXYYbrUpdZ5nYUm7W2Ap/S5ZKK8BKIkLGjvPGvsYJkO7GL0d5Rgmj3b8ErkNUzoZH6W1LtsgfPstJlRlr4bplvJtRBQCMQRQcxLXYtKswF68CiYelVEepXQxbrICsXkjpofLpdH9e+CesHaVj9Nxewzl7w20lzgWCqRmNOROWJ/3mCbBO6bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(8936002)(5660300002)(8676002)(41300700001)(316002)(82310400005)(2906002)(70206006)(70586007)(6916009)(4326008)(81166007)(356005)(82740400003)(54906003)(83380400001)(6666004)(478600001)(7696005)(36860700001)(36756003)(186003)(1076003)(2616005)(47076005)(26005)(40460700003)(336012)(40480700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:51.2443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a48382-bc59-430b-2751-08db82fb80d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Update 128b/132b downspread factor to 0.3%
- Add helpers to get DMUB FW boot options
- Initialize necessary uninitialized variables
- Add stream overhead in BW calculations for 128b/132b
- Add link encoding to timing BW calculation parameters
- Prevent vtotal from being set to 0
- Fix race condition when turning off an output alone
- Keep PHY active for DP displays on DCN31
- Fix ASIC check in aux timeout workaround
- ABM pause toggle
- Add missing triggers for full updates
- Disable MPC split by default on special asic
- Add additional refresh rate conditions for SubVP cases
- Fix DP2 link training failure with RCO
- Reenable all root clock gating options
- Cache backlight_millinits in link structure and setting brightness accordingly
- Refine to decide the verified link setting
- Update SW cursor fallback for subvp high refresh

Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ec7edb7087b4..41e68d694c17 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.242"
+#define DC_VER "3.2.243"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

