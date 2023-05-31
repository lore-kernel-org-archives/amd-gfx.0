Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12176C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 03:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C1E210E462;
	Wed, 31 May 2023 03:42:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B309710E462
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 03:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCVBH0llEHVXg+ADFGW6Eqo6eftNtJIzGqtcOv01bzEhDHdAlyst9kx6m9pTatfNvNyopqHxg+laZ33+lY53b3r0k4JPZmMtf4mTtyuVu1vTazDtfGk7p0p7Y1dXEyZRKXOAAyXp5jnPpFiVrHWuIxZqIWcUTZitpipmQTo5PKaSNhfnwptOkIDwG00FJIDaIJTJsAOX3u7bacvAZMjjiujcYFxLLLdvRS3UMxpkdCVpkP0/lUt0iKYE/nUaOfJyua+7PMhtts1laorMYkL1Md4NHKIHZnsE0cnitiYYhB+N6b3/FgaoMeZ5eo2Q93yLRSCsd7G+SU1ozoGHyLA4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxmipnz87QemubHVH+DJWrmgaPnqweJaNkg6f9ZXsTY=;
 b=jNIsJGuit7VWH6XI1nP+onyZT8+WYLM4V1pq30Zw89g2o9A4NpuDv5lPWq3d3FREv2UW7gsAx7gLm6ZmkU30DcYqgyzJPgAl+lAvj6+53h8JiFxMTdzNGkYiuVa08K3s+oaTgM8MqTI0qRe1vBLedvpTp8DmrjscxEtIn66GRAgH2IpQZvMk5c5WIF4un/DLXADN+r36EYN13L3qd9cj5Wwlenvqw3TnRdf3rCIjWGJ51OKZTLQ23rfQbqBKG1ONrDvBczLccDflkmE+JE0RULSujVOjvfnl5Pj6uRNgZpR+OsYDceN489t2+0/u6mY9xVkjxH0dKrdm5B7Cbk99wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxmipnz87QemubHVH+DJWrmgaPnqweJaNkg6f9ZXsTY=;
 b=3hWpfbNlAtxD2VKXk7UKMIN9PkVksVI4OhLJ1usHfCdTzEnl9dROG+sQ6CQuQyhC8YrCKnyMVhSro+T3CPqVzL+YwnhckO+cx5eEmc1SPw3jr4MOceUmNcc0oeziyRBatBovh4M38NhCBPFU4V627aXIc4gnR5GCP/lorrLmqo8=
Received: from DS7PR03CA0342.namprd03.prod.outlook.com (2603:10b6:8:55::14) by
 DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Wed, 31 May 2023 03:42:10 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::52) by DS7PR03CA0342.outlook.office365.com
 (2603:10b6:8:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 03:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 03:42:10 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 22:42:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Drop unused DCN_BASE variable in
 dcn314_resource.c
Date: Wed, 31 May 2023 09:11:38 +0530
Message-ID: <20230531034138.3203857-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: a9606fa4-c83c-4e77-ac21-08db6189038b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IU41VgqbgjQvoPoZ/CInGZljxn69RlXKMYe85hstZ2WapCdgBslSWYgrv6Y2YNeVOFLW2FNrAXc9fDL2Z46hLIdFRN+aWgwQBO+0bRmA2FSi2rOZPvPzQY7O3ZDb2s+wpCFbuhHnZs1Kej9nhGuRADN6sVaT+S7gbnWSxA4l7D8MGkvAk9VYd9uNo49qnMLG/Igx/ZlI1TKtt/U2kPtmA8YREWLjkJa+eD+l644VAspDHfgzreK+WxzAwd4QZnM59uMv/cI0oGR4Xlg7whQxg08/UtRIV3gZ2+yTjfbqxTBuzTp0SfIoOti8gbLymU+Dqn1PGvcvZzUUzfT9sKByrhr9QeJatWEzCU5sP3gfqSDaqTjpd5NgHML/nW+M+LF+sEuvQ4NRY/Me0FVF3d/JvYSBHkyHr+8f+0T1MmwYo/jqgJo4QZwQJpDagxherGO/8n3V5eQgXGCGnFloHULiLR+6tXJyl21ZaTLUkiPP3CaTQ0FVW0Xduv+ds4zaGA0p4v4mXskiPO2Z7zK0FrjQdjBV1RQKydrtCjQMkkz2zns/m86vE+4T73c3M3BiH3Rmqdxfh90CM7VeB/NhOfWh/Z82GZbx3hIhaX5AAiDrnmGaDkUwgD+0fo0bhc3q2VNE/QDD8awWHnMiazNG2tfyKHeTYFTHs15uYIaRO7n7qfdV/DC3bO2tV/pwrJmPiMMMenctKo3wqKERhBUuO5kaEgYU3iZzAU/+RHJ54WrzpDpmhYjnKrfCE6ozVeuhM0OPlleoTnFxTiHckmV8gvQT6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(4326008)(6636002)(44832011)(8676002)(8936002)(86362001)(316002)(41300700001)(70206006)(70586007)(110136005)(5660300002)(2906002)(54906003)(478600001)(6666004)(82740400003)(356005)(81166007)(82310400005)(40460700003)(7696005)(83380400001)(40480700001)(47076005)(186003)(1076003)(26005)(16526019)(36756003)(36860700001)(2616005)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 03:42:10.0174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9606fa4-c83c-4e77-ac21-08db6189038b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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

Fixes the following W=1 kernel build warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:128:29: warning: ‘DCN_BASE’ defined but not used [-Wunused-const-variable=]
  128 | static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0, 0, 0 } },
      |                             ^~~~~~~~

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 3592efcc7fae..fd0510d8694a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -125,15 +125,6 @@ struct IP_BASE {
 	struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 };
 
-static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0, 0, 0 } } } };
-
-
 #define DC_LOGGER_INIT(logger)
 
 enum dcn31_clk_src_array_id {
-- 
2.25.1

