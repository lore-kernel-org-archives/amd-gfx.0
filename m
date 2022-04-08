Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5172AC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 21:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D898710E680;
	Fri,  8 Apr 2022 21:05:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3664210E680
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 21:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNAqpf4GUC0h7PjMhswbUUoDZ3BOwBvBJLn8UvGf8YuiEXxmHt9pSoF4cHMc/hp70L9uv9VhRZ9cYxZEWGAAYRi2GqelcBnmgB6OLwIHSfDkaGe7mCZ5nUVjr6/l1YHqhb9z9cg7gpbTa8t54sj4/sYYDfeu80pdnLi6vTHvmgXQc2eXx7K8UdNOBxezNz1IOVzaUgHcgUQ6ctcLow5X/v3YD+04rQapkOhMBQssfFcL7YdVqF4CiuBPUJ/ox8Vse3wMAnMj5gd/h53Alw5JqessulEteoY65NnhJMXJ8SB13xzuZjULGsYkjO/yd/pWoWN7YGwyDROJ9yL0VBYwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gFZ8kkYL7FXSttmsT4Q9siUd61sL3LsYDF26Z9zcWg=;
 b=FQ2LEQYkl5Q5UDGflcXjb9r9+6G/2psU1AsEnI32tUPSB5VVxYyNr6wpNzxF2GwxvkzqHNTRwxOkIPQTUl+XX1ujIkg5x0gEqmbJ3gnRVJTeBmAqOkgEvt8yOdttwFAusF5mJioHD17KiWzVIX1zEEVBxh9pAQ/sZhTkw63f0QTRvAG4ZSafs5tN+5iePRzqn/om5HT6aekGSdR51/TCoibNer/wA0illuaEXJqTi4S9hd4CNW3UcY9m8xWBCm+pywmsZmNkGeIjATZ3LCe6fFokHJjC31+eSSzlsFMIuOAjawH0Aw6PUToVQ0hODXuSRcxtx/dp34Q5i4meNiS8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gFZ8kkYL7FXSttmsT4Q9siUd61sL3LsYDF26Z9zcWg=;
 b=ZRiFAYx0wa1CrtzHiU2ff9csm7R9/gScgupFhCAtM+EMHwKW1nW8lOrK+jhWfoSxyekL8dMsM6UJ2gnR9NJyd23zGlB9AAKLFjL4XXROX6tozmqv8dLpiVdDXA6zuDzyW1F+frtKK1fzxP+CPKxGqN/vSy1OfcJkb8iVDuzt6VA=
Received: from BN9PR03CA0075.namprd03.prod.outlook.com (2603:10b6:408:fc::20)
 by BL0PR12MB2515.namprd12.prod.outlook.com (2603:10b6:207:40::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 21:05:11 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::d7) by BN9PR03CA0075.outlook.office365.com
 (2603:10b6:408:fc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26 via Frontend
 Transport; Fri, 8 Apr 2022 21:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 21:05:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 16:05:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix 64 bit divide in freesync code
Date: Fri, 8 Apr 2022 17:04:55 -0400
Message-ID: <20220408210455.2603691-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32c4d8dd-dd7c-4613-a855-08da19a37857
X-MS-TrafficTypeDiagnostic: BL0PR12MB2515:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2515BF7505C8CF85D1322F0FF7E99@BL0PR12MB2515.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjqP71s8RehLc5ndq2CkijQIMyF2QVLUbDoV5cafArC+1/pkPx3ilJSEwAWO2nAaYaO+Wx1CSXXeWGk2oYkzn+6tfIh3p5gsmvP1cu9hZ7juN+5RA7Rz9KJtyM57FZbS8gcqTJXE9vPQwhT2oY5rT24lK1WDmYKkJMB5VlUJDQluPF0z6Y8jRDPtz/bwEJ+3P9pZ82FGXAYRfaLLKZAcKtuzgYc9pgS6K73GxWEoNTao5F/pDfHThLSHZhOneOXMyLlgA4eFevTrVGO7FgggsXSk2UjltldIoAN8CfTfkv25g7jzm/6nfoQBU1/OKNwdvMx7DCaPOSSrYDMku5JM9QFeducZ4aqInb8bNebn0a5qPbGu5/fdlh5bnihmzgiSBVFiGYJYF7ywUAkZDGrKHVXZP2zkR7LJwC5OzCeo8ZHrPfAWrhcRqssBR5VL+dXIwQYSwnnjL1AWANc6jFPbLtxPMABNyOMsloq44nmYqOqBfF/nwOPIdgB95iTkfv29Fv6dTdDrInFU0EKmDI7UzlYM0D3DlUx5R8l+1//MeziusRftNfGBj1Co7DChPhE6tcxDFnuawHmJSwMAQBf0FeJ/a1O0Z0kAdyVmF4LRoXO73CsjsCYAaQbTN5D9N7Ek2C47gjFImTRQTRPcOhZkNB1BdkgGVcv/SkmZ6BH52Ct9Wq4Xbw++AMcH99M6Xhkwh3ydqhqttrm/z7KvUW5CSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(6916009)(36756003)(508600001)(1076003)(186003)(7696005)(47076005)(6666004)(8936002)(5660300002)(2616005)(26005)(16526019)(2906002)(54906003)(8676002)(70206006)(336012)(4326008)(426003)(316002)(356005)(40460700003)(81166007)(36860700001)(86362001)(70586007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 21:05:11.4314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c4d8dd-dd7c-4613-a855-08da19a37857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2515
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, kernel test robot <lkp@intel.com>,
 Nathan Chancellor <nathan@kernel.org>, Angus Wang <Angus.Wang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use div_u64() rather than a a 64 bit divide.

Fixes: 3fe5739db48843 ("drm/amd/display: Add flip interval workaround")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Angus Wang <Angus.Wang@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Aric Cyr <Aric.Cyr@amd.com>
Cc: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 0130f1879116..d2d76ce56f89 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1239,7 +1239,7 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 	if (in_out_vrr->supported == false)
 		return;
 
-	cur_timestamp_in_us = dm_get_timestamp(core_freesync->dc->ctx)/10;
+	cur_timestamp_in_us = div_u64(dm_get_timestamp(core_freesync->dc->ctx), 10);
 
 	in_out_vrr->flip_interval.vsyncs_between_flip++;
 	in_out_vrr->flip_interval.v_update_timestamp_in_us = cur_timestamp_in_us;
-- 
2.35.1

