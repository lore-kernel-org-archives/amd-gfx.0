Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B9FC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C8E10E4EE;
	Wed,  2 Nov 2022 16:04:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771DD10E4F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZiYeLwpmW1s2eXJLpFERTUyWRBHg/o1foW9h9QJIqHCeSdbUbULoUHpWxo0E8lH4rCEykYJr9Lpif6g8kdNU93DSfKTzGWIAXBH/nQWI0IY2ULRNZ/2vc2xByyapVmCRdZj/rlxDp+Ie091mQRnjGa9lyl81eDHT1NKZNa25dbRWpLcdQp5EaWk2HXtWfbdHrLtXXBGFJqW6n1at70ImmHZSgn7jWEYcVom+sbyWkp9wiwhlBiJB2CLJpmowFa9CjM69w2AiEV56htMN65wlEVrbTvls2LPP8LJ2KeOQkyrt3FJitHu5gBn+B9QnClYurQEn9rg+nHa5RTlZl9y4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=184YOMjGuGbojxUN8bk8v+5uT7K8oPS1IHT/28lwjMk=;
 b=b19jRy7MYtwGfL94RY3EHxV1E24W7CNuV3Ay0ZkdO2raHtoxjLg8ju6tjToFY5YMtwyDwxdylanJjg4F4n577KPAGH6d8lsXLv5pRFlLWe6oOAPrSxo5rBhQycEhZdlO0EFw+lm4S4NPdUh8ZuioBqPBkyfFN6uVgtgnPg86lWJS0fPmoLiCC/PnJjoi1utOC+sZnerW5iZQP4X43j/GozA9+aoJXEWuxQYpkj/2W/NLEsArIliFl6RjwmRYgwSM9+VpKxM4Uj/U52phUDMB3Oy9cbm8VAoqdf1QjAOtDETRb6uxmPlEIQt/5jE1yOPRoUrSOgycHeBsDL/2hxiqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=184YOMjGuGbojxUN8bk8v+5uT7K8oPS1IHT/28lwjMk=;
 b=dNtYguLTySJqR2Q/Z+wiQZN3MAzSB5wD/HftNKyiVc0zTnbRogYFNAFxd/uisqrpeut6C5POtSG6vnzpK9bgCPooj5wxVeXGALTj7hhBVvcxnyu1zpdtXvfzE07UHyMakJp/iZJC8AwJYsO8bKAE5cUAsV1PWSLka2JEDQJnGuI=
Received: from DS7PR03CA0198.namprd03.prod.outlook.com (2603:10b6:5:3b6::23)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Wed, 2 Nov
 2022 16:04:34 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::17) by DS7PR03CA0198.outlook.office365.com
 (2603:10b6:5:3b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 16:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:04:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:04:34 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:04:30 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/22] drm/amd/display: 3.2.211
Date: Thu, 3 Nov 2022 00:01:17 +0800
Message-ID: <20221102160117.506511-23-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d051b05-c35e-4d45-4750-08dabcebef76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ejrfpGy5dpOXed7hpe9n2p2JOqY3RucUZpfkuJKDnYwZyK4mFjKHbSFfEcf2kbFL46gxw+r4yttAy9e7ORJzmGZemO8Fn8dazt55MO/YY6Jv1udf7A6qIvF9owMrUq54edo1VD9nhCLNpOI7TVsi3b7fbMOWTvwCtfyQMsOnOu7dWltZqelt4vZKkuzqeqqGJ2cOqXxUtVw9Sqts6BZ1kMAgrIK9BcRULkWg5uAdEa27itbMHUOmq/yO3zIoAIVYISpsLTd/s72aFO1YAQVBVE5MJqqElf87BArz45WdXhSL7aUNKweq4zKP9BgSCxZWZzG3rGCXU5sSuTtcbwz1K2z51htaHsfBEoT4D0OfsegDzIEjOMh/RTKFQQ7ffzsPiM5OBN0Q3PX3i7hOorVYl/xg8kXCNEedWPAuz7YE32LtnCtbWDDSe/0YpLZgUkG/EibSjBTgC94OaTDfcnweBDrZMRFSOMH2oO9u5XjsWjt3PlCnX/6kH2O+nXbB3UZKHdtNje+MhkG0QKDVRMRFK/s8CwzxjYHurh9UdSUoXhGjhPq9FeAvGTvERaD7PUPp9L+wIh5t/6cKwWKJpccFPj1IFTYkcrGamxy1hFbhO1qq8BAZTDcV42KL3jHqiuepuYan65oSyxegWDSR/y2QyMiKy3CIAmYRrW2VJR+E9yTA5Cr+iMAV4CBccMjCEFrlabJPLyOJQj5oohdVYlsjCFzpRNbupWUdy/pUPlHQSMyOm5socFBla/S9Bbk4rV0l/9oy08M53z8UgZ8gU/Wc5LnaFVvhFjy12Tt0DS5njp1pJDFCZw7Yqpv9uVHAe56
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(316002)(26005)(6666004)(478600001)(5660300002)(82310400005)(40480700001)(40460700003)(36756003)(7696005)(54906003)(6916009)(8676002)(4326008)(2616005)(8936002)(70586007)(70206006)(356005)(81166007)(36860700001)(2906002)(82740400003)(86362001)(41300700001)(47076005)(186003)(336012)(1076003)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:04:34.6407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d051b05-c35e-4d45-4750-08dabcebef76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <Aric.Cyr@amd.com>

DC version 3.2.211 brings along the following fixes:

- Wait for VBLANK during pipe programming
- Adding HDMI SCDC DEVICE_ID define
- Cursor update refactor: PSR-SU support condition
- Update 709 gamma to 2.222 as stated in the standerd
- Consider dp cable id only when data is non zero
- Waiting for 1 frame to fix the flash issue on PSR1
- Update SR watermarks for DCN314
- Allow tuning DCN314 bounding box
- Zeromem mypipe heap struct before using it
- Use min transition for SubVP into MPO
- Disable phantom OTG after enable for plane disable
- Disable DRR actions during state commit
- Fix fallback issues for DP LL 1.4a tests
- Fix FCLK deviation and tool compile issues
- Fix reg timeout in enc314_enable_fifo
- Fix gpio port mapping issue
- Only update link settings after successful MST link train
- Enforce minimum prefetch time for low memclk on DCN32
- Set correct EOTF and Gamut flag in VRR info
- Add margin for max vblank time for SubVP + DRR
- Populate DP2.0 output type for DML pipe

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1ec1b441d5cb..caed5597d1dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.210"
+#define DC_VER "3.2.211"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

