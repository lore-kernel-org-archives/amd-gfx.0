Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D89DCD11C2
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Apr 2024 14:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB09D10E26E;
	Sun,  7 Apr 2024 14:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cu7CmkzW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D253D10E338
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Apr 2024 14:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb3xT31jdiG7UwbQORAuj+37B4Ng0gx3II+DJ/OtgegHzOLD09O7vK9sjd9lgUs3VeJV6ChDHU/ZnOqtX4Rc9nNgMPwcpYbQTMDr3J+KyJez8CwJO0mKFbtsRFQPT1WZ4PGhMYdjwhoOA3chd1SPOQU1VqFF/MRAQDAg9VQeHpNeCJmH2EO3/9u1nwki1WEW5z63ZHBbPidBXstjgdJ3TxnWSiGVyj607itLX0BnzQx0j8Mnm1gfepQ/8LgbpUX0BUD14zJHAaycYXLjas+f6TslhFt0J6zkADaGsM9S5J7H34VcPbDOcYpJG38QuCg4hUTmq7FVzCU2g2Z20V3vKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnvYmJ5umGFF7gyZQqBH2gpsh6PgIqWioY1YSUB+Pzk=;
 b=Yu6g+VjGnvUOi7CACwFMfBggkXHiZba3P1rR3XijmRY+ZfJX0Gcm0s8UWPu6BLXX+wYEB+1NaVMwXHpWtop3UkKEoIEay0AwhxLilvwg821fkLsCW9H62fZg1tsnpwS6QzpAUic7+eUSuq97nqVnwtQ6uwTgt9ZH0LGhNsStaklqMPHaz9xpXcqsCJhhQ0OlczJ5lhwTvGytEh7R+SqeeeHzIcCrmgbAZ+QVNCcFXA8SMgwQnE60d/nJmkKSJK3lvCT1rdODLQ2B7FQyFZm8eFpOgAFM7PXFVknHY25HvHrRKkXbmF8y1griyg3/HpzXZnx8saquSMfiKJQ4NYiYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnvYmJ5umGFF7gyZQqBH2gpsh6PgIqWioY1YSUB+Pzk=;
 b=Cu7CmkzWUJuATbCksZmOVzuIRK/jli+mYaBafXWMlVohBoB4EeWRBqV4Hophuet66hg/5RIAz1qkxnDac8a1QEprW0L8BYXzGREr65/ZwLQDiyS5VJ0HW+9VHCSWJ+FrJQc3ZpWJ1wydpTfpRiUnqZNvj6EyCJmaBibKis9B+s8=
Received: from MW2PR2101CA0033.namprd21.prod.outlook.com (2603:10b6:302:1::46)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 14:10:35 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::ff) by MW2PR2101CA0033.outlook.office365.com
 (2603:10b6:302:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.15 via Frontend
 Transport; Sun, 7 Apr 2024 14:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7495.0 via Frontend Transport; Sun, 7 Apr 2024 14:10:35 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 7 Apr
 2024 09:10:32 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Tim.Huang@amd.com>, <li.ma@amd.com>, "Yifan
 Zhang" <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: differentiate exteranl rev id for gfx 11.5.0
Date: Sun, 7 Apr 2024 22:10:17 +0800
Message-ID: <20240407141017.3831131-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa29d30-687d-451a-d618-08dc570c7e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8cSM68qKxIony9cAHZCU/hD6k2FXloYX5ihBh5zgAm8Y5zBus5rkug5y517s9Yh1iyxw9BNCgU34g4Mhe7ZjtoCDc/9rZIWv69oMSnSr/sLus2YCwKY2tlTEKH1fmmjJY8XIlfhlUG7enWaqo0iJCqFAnRpc6HDHL7bWQtns7EvgqFF1wyfsscf81HD5SLzUDHLIY/bD9UIK0sdBh+spet5qmUYZy14YfgUA5M+vc/4eZbALKAio0C7SmlWP5X9BeT8CrtSmCHzeeusJAdncgvNmhrBkSheqlkAoqwkuZCq0OuW+X27/uCv23DincjU86dN9EsaN/gOOWTBS4ZFtbb6vR4W9f0CT9CXewq3g9/IzA6MHndczrfumUq5fSodxJe3p7ei6R2jNB/8i5IH2nB0hKQwFupoZ3HZJizvt5gSP5atWPwwpcYBYpXMU9dntkqi0Ddq32NqVDB6VIiZmg8dEB0KXP7VR0//J9d2tpGrC/OofC6EUyOZM2WfzxS3KbocGFyA2HX2SJtt6s//6nDP2pmmXgRX7lIKiSObTELsFcm+dDZ+d4HV7cm+LyP7TDSlASf2yDLROyyPQCcKWHaZ97Q327i6+NSbDGerim0hX1vq/qeFRGDLo5fUqTBLXxvTZo8ouzgHmznxQykAs7S29PePgi0z0oNbAMFerqzN1YKytpIx3QyRTt+IunVaRkUAriYRZH1YCfJeN7kppBe2aq7YA+JGBl7+5U8Nn+dtm6eYLcADyPiE0JfzX4uw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 14:10:35.0581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa29d30-687d-451a-d618-08dc570c7e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch to differentiate exteranl rev id for gfx 11.5.0.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index abe319b0f063..43ca63fe85ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -720,7 +720,10 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_GFX_PG;
-		adev->external_rev_id = adev->rev_id + 0x1;
+		if (adev->rev_id == 0)
+			adev->external_rev_id = 0x1;
+		else
+			adev->external_rev_id = adev->rev_id + 0x10;
 		break;
 	case IP_VERSION(11, 5, 1):
 		adev->cg_flags =
-- 
2.37.3

