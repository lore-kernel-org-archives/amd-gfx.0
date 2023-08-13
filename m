Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA29C001B0
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Aug 2023 08:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B367310E075;
	Sun, 13 Aug 2023 08:46:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E238110E075
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Aug 2023 08:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD1uPZyxWC9ADmHYz+nPVR7GDtB9xke7+0+1yeUxKDJIeirDI/AM0C+vYz6ByvvW7Ea0+6dNeK3pWLn3RDW4+mSvo0TJ5bQHHUzqY/SZAPjJAAv+eqsRXdlWRLCqy4mND+diLK1TzCzH04FTc0XZnMxIV9mEzIzWjsJmsR9vvvAUJfrQn55IYOAw2COzIADSF/rmLWM4zxWMnKB1135oweBZ5nU8RMFNVfpEeHPp0/xVwMM5aRMFvo2xx39kYNw4SWCpahpSUuNp180uIgBb7H0Yx550KAf8lY5YBIRwIbhALkJ9re9I5gme5jnDmkTrnShDNSUtZ/cYQSM08wldIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSqf4eIjTn3rE6qPDg/YJzm94wHtPJmKTeF+Q+s1u3c=;
 b=R+U4zqDCuNE8PjhWk9/vMSqDQra99MFJ8fBtgrwaQhd1k5dNZ8TgV076dXYUTPCRk7P+ijQBk/qoq9b1+zgmG6Oxd9Bh5DxomPCc4eyCjoxXF9+B+PZKrnHBgh/+Zm1lBoN8meWt4vEYQR8zprFTPQJrJq4O/G37ijGYZaoI1UMz8PnKdOZF/+CUQsVBu81Z4rAXdhIFE/5WOyPWi/zj/ZAT77g5nw20/xhPio0q/Rmpbx39wl3m6uT8mwK5blQSxmOeubo9YRcg/bE1HkgKEeKASsxLz9+R+0Q/xKXSQNDw9ifEZsyG49WHV5o018TYtS08ZMrBWhloe6/29Zb7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSqf4eIjTn3rE6qPDg/YJzm94wHtPJmKTeF+Q+s1u3c=;
 b=csAdSm4s+MThudONQ+u8ljTTT3egKe6818SW9uOvRQ4/NnLwflHAusUUnTHh6I7MPfVDqVKTIs3EKUku+gVu9Vo3UXmOoRT4VBc7N+xh7SHW/2rcb3I7fhKxD9l3Y559nkDwPztShjzaFDuC/ziBs5PVUFpQgiionu4X7YBwIjI=
Received: from SN1PR12CA0045.namprd12.prod.outlook.com (2603:10b6:802:20::16)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.23; Sun, 13 Aug
 2023 08:46:32 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::a6) by SN1PR12CA0045.outlook.office365.com
 (2603:10b6:802:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Sun, 13 Aug 2023 08:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Sun, 13 Aug 2023 08:46:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 13 Aug
 2023 03:46:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Replace ternary operator with min() in
 'dm_helpers_parse_edid_caps'
Date: Sun, 13 Aug 2023 14:16:11 +0530
Message-ID: <20230813084611.541381-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 02afd053-fe61-4021-b126-08db9bd9cb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iq7v3Qp7I7LBKvdfLqy4W9VJvp9XRbfOLjqKMi/bv9sxkGSrUPD1DdXuY8WbGZ78rrzAWq9JV3d53c2g1jPZfOiF1+81/wM8nBmLjXErpIe/NoT+ppDQXoukWnebmHoG8tjFnGn1CJhO2StbYGOqxLBWOcCYL+HV5VPjzCbYMeYlXElamtsPP0EOpHapYo+pUvmGvASSYx4JYST81J/e4t9ECOTUJ1/x64GXUGIrPbhyf8/fp5WInk+nCRtcvZbeYfLtmjlwRmqgvT4eM6HVUgovdvVgJtRaVlgY9pYiJDR6Ac5PpH53r4oCEzcKDZkBffzILcquSO8oW4JkwUOms3TX8QDJ6slFZ+TEvddJAR6dj3PrwBe0RZurQTl3bVwnovtMtWDDOXZupBpekZnkDUhHeX+1Hb61sFvFB+QMzoj/ebbdI97Nj+QAwZaNaMfptkGYNDCVJoS5mPXV8qQsLNSb3uMl5eBAdm7QkC9GJRXpKXRKMczNIGMCIRPi7C5vaV4+k50k6aUzorv6P0DJdklm08u3Kieo4vGinueyIyqxYtn1xcSc6YthhMN3F7epdMzcr+76YR0rB6fEizKWastPyXBputX6egqyNbNlLJyi0uBZjgndYaNWm9Fqm3H6KQg8/N3yi6A+tqaAGXg2cLlnXLGtgfoucNUDFT1q033n6Opsy3MIKXjA5SJyhzxKgWw+Hs/UkjCJwXe/l/8Xb/3HtM1JctJrB/2JYLPteGWWDlnPqsj5X/4OxLEUtCkffpGdtSoljaBa33BFpILLHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(186006)(82310400008)(1800799006)(40470700004)(46966006)(36840700001)(7696005)(6666004)(86362001)(40480700001)(54906003)(478600001)(110136005)(16526019)(426003)(2616005)(336012)(1076003)(2906002)(4326008)(316002)(70206006)(44832011)(6636002)(5660300002)(8676002)(70586007)(26005)(8936002)(41300700001)(40460700003)(36756003)(47076005)(83380400001)(36860700001)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 08:46:32.1959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02afd053-fe61-4021-b126-08db9bd9cb33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following coccicheck:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c:120:41-42: WARNING opportunity for min()

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index e94eeeb97688..4b230933b28e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -117,7 +117,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	if (sad_count <= 0)
 		return result;
 
-	edid_caps->audio_mode_count = sad_count < DC_MAX_AUDIO_DESC_COUNT ? sad_count : DC_MAX_AUDIO_DESC_COUNT;
+	edid_caps->audio_mode_count = min(sad_count, DC_MAX_AUDIO_DESC_COUNT);
 	for (i = 0; i < edid_caps->audio_mode_count; ++i) {
 		struct cea_sad *sad = &sads[i];
 
-- 
2.25.1

