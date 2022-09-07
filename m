Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4E3C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 14:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0181810E77E;
	Wed,  7 Sep 2022 14:22:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B4FD10E77D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 14:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK+5Jhl+9kYpxJL3Sy+Cg6pCJwbmeUSDrDTehJuH9CglRTcGJ6sZvLoRvvj9ufQyYviDVCTl0poVwKTeQgg41XnJCSAvoJojwoZq1vPWryVV7RNMj29NNeEP14aYfRjjZuc8hpYEMAZoI/S52UwtNTW5WOf6v+eta/CCeT/RMYGqmS3xLMLKUlk6tL939WeMYqo9qvsBuEp5B9kSSezdS14l+V4/y2avjHbtYKkP4dqNvzWzWkxniVhWvvnIhHgBGMRP8oNrfOnoWlexhjkxPDx9aoPqYouopU2AEKvZ5cqWjrW8mAYYpZ7n0BWTP7PCWFo6LQiYR+IYsaZMayO3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yKwT0li9f3qh4BBddEhqm/Me9GrvBcO8cn32hVx6Tg=;
 b=TLKTYeR3xee3bTVR6JlwSoF78wXvZUgCWebIw8KPl+Zp1FxGPJJi9bLh5JOYxfK5EdQbOyzW3+u6/cq0tI1BSBoLQ3aFwq8UjiArKJl4GLxkHOtEKCjvBDG+wKqVDRGY9+sr+0duAjuY8DVfMyg4ug10lzcRhXFbHQNSnENgEg3loM373e2g0oAYc8d5oyPrEC5VUNso2VE6QTIbYJucwKvFbBSTJQjYlTJ7q5vahLbBYavLcKYo6dWYBHfmHlkVQkhrgAM+fjX9mkQmTVriXAZ86PSqOnI7ndkXp/l8QHs/vae2niq8vH4uBKxd9ck1MvyZX5X3Od4D+6JvQSBY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yKwT0li9f3qh4BBddEhqm/Me9GrvBcO8cn32hVx6Tg=;
 b=4uAaTX/+qNQGCnXlQdnsHB0aQXIaiShJWXvw2tsSJaf6XOXcYO2i49PCYMj6QwrhKfHKm0jvH8QDezYMOdxFt0OemTJ9S8j7nyNfOReo885FDR7YjTXt85IOZ4zPLmmMPRvKILD0iTu9t/KHO2ukpQmKrbXPSUk/vsxMSg0GuQ4=
Received: from DM6PR08CA0050.namprd08.prod.outlook.com (2603:10b6:5:1e0::24)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 14:22:39 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::3b) by DM6PR08CA0050.outlook.office365.com
 (2603:10b6:5:1e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 14:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 14:22:38 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 09:22:37 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add missing CGTS*TCC_DISABLE to 10.3 headers
Date: Wed, 7 Sep 2022 10:22:29 -0400
Message-ID: <20220907142229.818384-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|PH0PR12MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 06268ad6-8279-450b-108d-08da90dc6b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHvf1CGVbpn2uAs7R/x1jWCLQFrtMcDdFRCipbE6FHw9vWbyKj1zv4mILwvOgbB1gSkEqMd3+K4+Trwvxil9+cuKO/oyCq4WLZ6pG9GyEPQIT6Mjh2WGkerfxCr89YW75iVoV085Gaos5PsCM02MrcbXWviN+aN8NlFKcVSfdonjvZzsI1v9s2UUkiflJ+mz3IxtXtU5cMaDuVRPfcefSHH0iUfc1jn/s+1M9hGbXlL2a9zrf9yA6MPKNRNA5SeNTQfxPIuRN5oqhoKupp0cMmA2NoDBVkJjXqP6MhXUQ3Dd+sJTkXUtNNgl7sqVpFuYVWOWpkRAvOu4/wTNVC1JY4tuZgSdjNP34BL5hnGZshkkLu1xP0ZwUCjmnZT8VIFpqQVpa1s7YR60N07gbB1E8KhhYMpNU5iaFVP+NguCMeUR7tkcia5bylLwMtf/wpt+CpmnoHupTK85VdvcQKgaN5li53d3EIixlbDLyUV6XTrQ9VbHZToCyEcpbMKlABsLMt0Q1PMaFWEOZhBrJcZhSxkzfjXQwE6ZK7Jk7kqiC0LUAb/+eE6W0d4wwexc0G5MmGrp3crvNwkXJtB2ui1rmC2AOhAIxLQa3FHEwbw3yTYFmic97pTBpTmcVZ+rz6F8BN3XAWxDfrMMJ5EklNkxa0sex6O3fZvRXEOV2miNVdXBWLO6ltwKkFX6rgxlB84+8WzqlcHKiutSOSPHbthcPwrCoczffkx61O2xqHrh9Tz9bR3oxnF7yfLZkUMxWTNcg+3brRy8aajzKxAV3hDmTYQrDljmV/BaexDbkWhNHys=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(40470700004)(81166007)(40460700003)(82740400003)(356005)(36860700001)(70206006)(8676002)(4326008)(70586007)(6916009)(316002)(82310400005)(2906002)(40480700001)(16526019)(8936002)(2616005)(1076003)(186003)(336012)(5660300002)(83380400001)(47076005)(478600001)(426003)(26005)(41300700001)(6666004)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 14:22:38.7624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06268ad6-8279-450b-108d-08da90dc6b00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The TCC_DISABLE registers were not included in the 10.3 headers and
instead just placed directly in the gfx_v10_0.c source.  This patch
adds them to the headers so tools like umr can scan them and support them.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h |  4 ++++
 .../drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h    | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 594bffce93a9..1115dfc6ae1f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -9800,6 +9800,10 @@
 
 // addressBlock: gc_pwrdec
 // base address: 0x3c000
+#define mmCGTS_TCC_DISABLE                                                                             0x5006
+#define mmCGTS_TCC_DISABLE_BASE_IDX                                                                    1
+#define mmCGTS_USER_TCC_DISABLE                                                                        0x5007
+#define mmCGTS_USER_TCC_DISABLE_BASE_IDX                                                               1
 #define mmSQ_ALU_CLK_CTRL                                                                              0x508e
 #define mmSQ_ALU_CLK_CTRL_BASE_IDX                                                                     1
 #define mmSQ_TEX_CLK_CTRL                                                                              0x508f
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
index a827b0ff8905..83faa276523f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -34547,6 +34547,16 @@
 
 
 // addressBlock: gc_pwrdec
+//CGTS_TCC_DISABLE
+#define CGTS_TCC_DISABLE__HI_TCC_DISABLE__SHIFT                                                               0x8
+#define CGTS_TCC_DISABLE__TCC_DISABLE__SHIFT                                                                  0x10
+#define CGTS_TCC_DISABLE__HI_TCC_DISABLE_MASK                                                                 0x0000FF00L
+#define CGTS_TCC_DISABLE__TCC_DISABLE_MASK                                                                    0xFFFF0000L
+//CGTS_USER_TCC_DISABLE
+#define CGTS_USER_TCC_DISABLE__HI_TCC_DISABLE__SHIFT                                                          0x8
+#define CGTS_USER_TCC_DISABLE__TCC_DISABLE__SHIFT                                                             0x10
+#define CGTS_USER_TCC_DISABLE__HI_TCC_DISABLE_MASK                                                            0x0000FF00L
+#define CGTS_USER_TCC_DISABLE__TCC_DISABLE_MASK                                                               0xFFFF0000L
 //SQ_ALU_CLK_CTRL
 #define SQ_ALU_CLK_CTRL__FORCE_WGP_ON_SA0__SHIFT                                                              0x0
 #define SQ_ALU_CLK_CTRL__FORCE_WGP_ON_SA1__SHIFT                                                              0x10
-- 
2.34.1

