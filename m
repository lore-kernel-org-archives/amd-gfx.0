Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035EAC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DC660F46
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5DC660F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811FF6EE61;
	Thu, 29 Jul 2021 20:37:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2B26EE60
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7ZOwlsDBdEnVdikytfBdKY5/FICDVU8EmJyCTJAZJ8nXpaviQ7qOaIQ2bqLrtZ6oQv8EVUD+uGtbWGqpmQmSH0kHmKz++/UuBzeJnO8v81eno+UB/jq5VaAsTt3MmjC8IGxQ5sdV5w8owxlsjg0+9ji0BFmjzhrx9X7FHcs0B6H07yLPXoYqWAjA3VA6tm1QgK90R3RLru4w9E0NryN2d9WDTRuwByoBVl5PO6aZjIW1gEKBwEPa0ZNksK1lXKKmKFSxuBcPOioHzE1uUiyTNceMpYfbsEDZhBkMYVe79XwULFwrRx56yTEaqK1xSScd8U8FK/1S1beNGOjMNDAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O/Hry5MDYYYUje96sNslEIWVZlUkpfLH5370rbxKP4=;
 b=MLtVam48d7V9jxtChR1WbuJIxTfrrLcdyujtiQ4MFqH/eso2BlkDHraeVl+e425RXQovYiOjnRBkabwfMYs7TNmMNP6xSAaz/Ikt74Blo5adF+i2CxvCstJF1DMqRRms6OZK/OTjcxQHs7wi10Ixwl4/RAJQq1wXrAQNZWNgaItGvYf42ZgQpLBzdB5reDO3JjUmKT5dD+1Z8XUWK9MeOtxj1JcwSwQjYmVupfM2bTQcT7xKy6ppdelENgZgi4jVS/6m6ftB2sg0ofd+EBVNQB76uPCrLp5K/y7vSQM5+lVDvnk7/acYN7JOSjpcXm74lfZFG8SzArbAX9FVtbpEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O/Hry5MDYYYUje96sNslEIWVZlUkpfLH5370rbxKP4=;
 b=bi3Ou24uMrYounpOFlI4LIty4JHk6kpVmm2Cgz87yIXcub39jU4bTSFDwFZDekvviz65Bv+LGryFKQ8nZVR6kaMl4n5l5k7SMieDdlEeQN586zVKmEZQdeqD3sHfB9AabckHjOM6YSL5ziO4ydiNUBatebTMR1X3sAccmhdVQwA=
Received: from BN9PR03CA0201.namprd03.prod.outlook.com (2603:10b6:408:f9::26)
 by MN2PR12MB4640.namprd12.prod.outlook.com (2603:10b6:208:38::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 20:37:22 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::1) by BN9PR03CA0201.outlook.office365.com
 (2603:10b6:408:f9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:22 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 13:37:21 -0700
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:20 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amd/display: Remove redundant vblank workqueues in DM
Date: Thu, 29 Jul 2021 16:37:07 -0400
Message-ID: <20210729203712.1566129-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
References: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e4eaa8e-0388-4b15-591e-08d952d0aac3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4640:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4640B9FA64F65E9984FFFEA68BEB9@MN2PR12MB4640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4KZqOvQD1bMxsPHXwnndNyqdR//WRk3A8AVRWG5ui7LeuY0zuP9us6q0CD3ty8T1+qK/pvieylUrosEYMHY35Uy6a8nU1FpCE5MiqwKZdJ7XIe0JHzeAX976hF9I3m9PZIti9GwTMI5AZgUA+7m3+gVGnczyxikf+M9sz/XLFC2ySPJZv7eeiyCsRgdTHhiQjN88YBffLd0wGPZFbEzATIkR5lhUakFFDAQV7LQxfaFEdi/6i6rVy7In0UtQ872Af1SQbI1yd2x7YaFw+3FyPL5d8NeL6MwQ4lnXtG01Yi3FoBdj6dGs7tlk7xwRjauiVUoBXL7XKq9+/DtIfYTwxebpa6eZowwvX3Q5Q7w+r9EHIJ8TidYcfTXFcdFlYLbHGlfc49/jEhnr26vsqswUMrXAJlJrQ0stzKbCizjGsrAf+k9D8E8KxMpLPqR6o5brW4bmTJpfGGzSZUJfxLxdHiyFnWKhS838mSUE9kGqKGMX1QLxUKHhg2QvHos51xE6eu4bKSZSSdAEkA+OY7JQthU0j0sBTmXa12KzWDi+WBW0/dSM6LOxgv08MR6NYLBum+VOIagdOaO4GxY1s8fACVWmE+lNS/c7QaE4nJUdPcznnN9fntpWBNG/Rb2PCnveG/FSWlFRpfbS1LKJzjDHStBxoFlwq5EJryvtHIzh3jze+fSFvP71v68l9N3DHzuLBwtJzUshjbYQZhaxgAp5xH1+/jeZIKpYOqoVJGz/W0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(8676002)(47076005)(1076003)(82740400003)(7696005)(2616005)(6916009)(81166007)(83380400001)(356005)(86362001)(8936002)(2906002)(44832011)(426003)(6666004)(36860700001)(4326008)(5660300002)(36756003)(316002)(82310400003)(186003)(70586007)(54906003)(70206006)(336012)(478600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:22.0800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4eaa8e-0388-4b15-591e-08d952d0aac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4640
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
Display Manager initializes array of vblank workqueues, but only 1 is used.

[How]
Use single instance init instead of array.

Reviewed-by: Qingqing Zhou <Qingqing.Zhuo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0a1dd25e567d..a05675b84c2c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1066,19 +1066,15 @@ static void event_mall_stutter(struct work_struct *work)
 
 static struct vblank_workqueue *vblank_create_workqueue(struct amdgpu_device *adev, struct dc *dc)
 {
-
-	int max_caps = dc->caps.max_links;
 	struct vblank_workqueue *vblank_work;
-	int i = 0;
 
-	vblank_work = kcalloc(max_caps, sizeof(*vblank_work), GFP_KERNEL);
+	vblank_work = kzalloc(sizeof(*vblank_work), GFP_KERNEL);
 	if (ZERO_OR_NULL_PTR(vblank_work)) {
 		kfree(vblank_work);
 		return NULL;
 	}
 
-	for (i = 0; i < max_caps; i++)
-		INIT_WORK(&vblank_work[i].mall_work, event_mall_stutter);
+	INIT_WORK(&vblank_work->mall_work, event_mall_stutter);
 
 	return vblank_work;
 }
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
