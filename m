Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C285ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 07:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F58810E5B9;
	Thu,  1 Sep 2022 07:31:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A65CA10E5B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 07:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+yDU4rVKVH2mKif/R92of0HI83SeI+7nlRW/mD1lxNRc+mjhgxqb5mKWvTNHs1xCiDg19oFaa2B/PA9o4mHgo6uhZy3PxoHSQ6OFGhaqzGvJTPzXLQ57ddh8Er/p4TOS+aCISYtfvLFC8tLsf9PmXMZZs6fbBJhbxcHBat52O7BZYQg7loAvwwHwMlU01aZRZIM9RLi3OSxaZiZFr45FM6XLBJ56A47cs0HWpHEccDms72au9OdkoewGIaaAAEWLavh3sokooWeaOU0rXTrPrrLEAmLvmsXwyhiQ2awr0LBeRDoR7vZFpCFtp5cv+UANQkQ5rK3E1p/eAb7BudKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrYdROL1PwlB97hYIYorYnpp0kpzXzjI6+WIXyEfjFc=;
 b=NkmA1lNnCeW6ZpH9v2ne+wq3dnJfMylcps4ayBqpUhxIH5I7RdRLIf/hHZET/jBYGdGCvw/JNAEccU7FgyRxxc8qy6ApB0c8FZCWZfcVe8EQFhHMdCE2IagHzSqm0qFtDpPZlhmILZJR9PhRmkc5soHjib7LQ+if4ZvM+ZvslnzYML+YL6AhRDEWwU8VHyX3BW5kJy1e7QhQDv3omJWzsOVvrdwTBU+85lupngIlM9gANZW/knib0eUNKiz0SyHMxH0kHX7qInCadgHZQ0yakE3UBjMmeocf9KZE3RT7r8cVCa4h5V8iVKMNzLUw3cT4g9ppLMAgJk0LA00S0n+hSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrYdROL1PwlB97hYIYorYnpp0kpzXzjI6+WIXyEfjFc=;
 b=1aK7Vc/MACuenJsjNuVyC0CZIw0snTSurCXYPzp44ywCmW9Nkz2eaCeRX7X8WRHK+5XTVqjI8ehbbMm+e4y3gJIfFsSDHRavjCjHnVaA527ZQganAmXKlTSKfnyl4t/z48k+0AmemFY31V+7pgoF1Gofxp4zuUpNdg3Qd+zQ3Zc=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 07:31:08 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::5e) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 1 Sep 2022 07:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 07:31:08 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 02:31:02 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Date: Thu, 1 Sep 2022 15:29:59 +0800
Message-ID: <20220901072959.4085193-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 337ef0d1-fe16-4b77-e063-08da8bebeff1
X-MS-TrafficTypeDiagnostic: MW4PR12MB7165:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUCYErT7H2vH+Radf2LAyCopjl66ADOTm+qfIPid4Z2+7N+wYbfoOecZenAoHMt0hxQfj69N/0eTrRYs6hLdp7rHAihrFIR4Ly1jONntaI2HibxJQ/TLhBRfuKX0W5U26+rSdyv9H7+TksZJxS8nPqUbrb4t4VlrmS73np8uOiFqCLgpWB16enP3FbJjPM0Q3jdPPXosoMNQCeOY2YK73NYK6bgzyuznGyjBh1e9RTVmd0/EjzMVJUj2PYWf0yK/+rlrxxxgITNcZjW8o7eGEndhy4Q69Ia7TG4+Xf274pAonXYE2CotlCbg+xek7g3emmrp3rNM9FXe9j3L7wG5JnWgacbrqCOYZxkS9qQeDIAagD7oa2D8TBCtrQ0ujs1vLivGGv1YWuawSlS0yeMqMKFiavwO9oG6Do9NhVBP6ONMQxIcf3HVncgVz/eU1VTqqw1FeXxlXnp+PHs/XNawkNPgQJ2Y9gCevBbZkgBvgH8g6UMthtP6vrLXI0juS3fL7ipA61hEk3USL37PxidyIItXoMveuu+5ujiY11aCHo6J8zULm66TI2l1BxXGuGoQs56p0x7xxuzG2EbZlz6Djsk3Fv1laIm+YKwKgF6CICXihm8GieSKW65/ThQifubISxdCxEY8aH+PKtMyS9grOE9cqXYJO3q2GS9p+revXIOtvzVh+mN6NsjBWDkQ4u86QOQael0wpXLsKzsGOmh2hWNrlMey7C6otoOnS4Xkpr/Xn401s4szbxNX+jrPYxx4WP0o1Mx7LcGL+l9Y/og4A5WF425pXSOa5aG39G60bCegpBqVbat0nzdOT6iYsMbS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(316002)(426003)(8676002)(5660300002)(336012)(16526019)(1076003)(47076005)(186003)(83380400001)(2616005)(40480700001)(8936002)(70206006)(70586007)(36756003)(81166007)(356005)(2906002)(6916009)(478600001)(86362001)(7696005)(6666004)(4326008)(54906003)(41300700001)(40460700003)(36860700001)(26005)(82310400005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:31:08.3653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 337ef0d1-fe16-4b77-e063-08da8bebeff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Current discovery table doesn't have cache info for GC 11.0.1, thus
can't be parsed like other GC 11, this patch to match GC 11.0.1
cache info to yellow carp

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 24b414cff3ec..1c500bfb0b28 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1516,11 +1516,11 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		case IP_VERSION(10, 3, 3):
 		case IP_VERSION(10, 3, 6): /* TODO: Double check these on production silicon */
 		case IP_VERSION(10, 3, 7): /* TODO: Double check these on production silicon */
+		case IP_VERSION(11, 0, 1): /* TODO: Double check these on production silicon */
 			pcache_info = yellow_carp_cache_info;
 			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
 			break;
 		case IP_VERSION(11, 0, 0):
-		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
 		case IP_VERSION(11, 0, 3):
 			pcache_info = cache_info;
-- 
2.37.1

