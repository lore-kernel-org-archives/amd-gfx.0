Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5717DC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC50610E4D2;
	Wed,  7 Jun 2023 12:16:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B0110E4D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGPT25pnS7rueWgingTz6nMDGDex0LkBCps3PvcCC/H9I0gx1Ps+Qq5F8yDLAPYkp0APajINsrfUCWoqHl2IiioWhXbdzTnt1i0E3xvxgVmlKRbuYdsloQprNZJoVGCfI9K00y7KmSFfyqW/TQ1e/oKTAMGZ0hWCwPkq72cxrykYQirfB5/YFkjYp7VigHcVFLXbM/Tvo1bE3mtg8r0LKhMdFP6C9wKglO7TT1svaCdg/66AeVDSvqE5wA/dY2rgURowSQD/Nw5CpnPw8RlfP1kkEeZvE5gnPb4OYPxN997YEtMwh0dB8Di+gqdZKqwUpzo+xLmtEMxFMqfevOleUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ09aAjyo8RNqiegGOqbDy0EcFw0zfx7aC8OWXKpZlM=;
 b=WbWNCfHFxd/i1uRxyQqq39h+xTYrNZni6cg3hFoiJwKfWh2sY7Z9rSRlSpen5PPEi1aYx50r+jWU2M+v5PEBbDxdWEstF2k4SwjbmDzD9JaZYINYokGmXNdwTBKISfnOsSdaxW1mB2WdVqooEZNBmNyqzeIX5im7ESnZb+NO7b5hrHzJGpBoy6Zo85eibhKpsocy4axiWSXXVvXokWQ6qn7UDVLqeZk6PDmoitKpJU43bcmSLmluH9VjjTD4xzEh/oj6661xhd1e8zY0oad1amkjle6mCTjaV55YdTSIxFr7VA35QCJONBZ0V0Me6YyyXIofWACgd7YzxsdgLo013w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ09aAjyo8RNqiegGOqbDy0EcFw0zfx7aC8OWXKpZlM=;
 b=PkIENrES/ikSPTf2Hon2t3ayKP2EDaL9mRJ4H+AiAMAxIVFV1HrLS/s4KR8QBFSv9ZvGzFZHYbrqGw8G404oDW9JFhpOfsDgWDWppe9bHibEb4/nyZyrl+8+Y+rXtC1HYRy8jnDqIVD8FjK/EW29+EYK8IfTQVUZ5fbXWpgHpuk=
Received: from DM6PR02CA0119.namprd02.prod.outlook.com (2603:10b6:5:1b4::21)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 12:16:40 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::34) by DM6PR02CA0119.outlook.office365.com
 (2603:10b6:5:1b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:39 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:35 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/20] drm/amd/display: Fix disbling PSR slow response issue
Date: Wed, 7 Jun 2023 20:15:35 +0800
Message-ID: <20230607121548.1479290-8-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7e5b55-46e0-406a-320f-08db67510c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrm5qQDT/UW5fk96g4NwbMEe3OGIMYMMaxSQG4F9uVMAKkZo6g/rO3epbIU47Ati9VMBLlzh908vQOrXkZ5B4Y8PcpJeYl+ee7XcMChH2i9qBCN4p4+WMQHAv5Ss73BYEN2tOQq4PhrDxFm77BaH4YWR3bsTyeF6Cx3dT00x76Gia7eFox+0vLnEuR8oJ+HsDFQElahz8nyfSsHIf98H+8E1PpQ05QMOcboAJfCqFJyeH3bTE9WYpJjVjGT7yr+MD5vT6EvnmGpvGRduRD8oRzv/7cYpwohE4rKtqahUGKbfeuVtvz/geZ2RBqJY4zpn+pdN/yHvBQbSdSQMzkUdRuInl7XFpp3nbTFb68GXbkdfGc+a7O0C/wLCVFhHgtwqOOG1XMoeqqEPu6jgGwqUTBnwZKRwou5Ctshfjl5PzB9GUhBhk2/2tEQwGSohjFlPz4wBrbd1iT0ZryOxaqtaRS0Ms1mp2AYzKRikDpA3SBu40yMRUYfnm1BP2rFcFSKQ5Sbct7oQUnfTIqAuezyXJ5fHsBNuwyu7TCvV7muiKyT8CmuUzr1s4pWgu1FBYiRcrZt8FeGQIERIVp1Y8HmnECeXfsDMIb7nIfvVzaVls1+t0IUsph1yvpTtQFI7+hmTmohRoEzfsK0Klm6WgpSOs187cs9nAXRiia+8h+M4I0k/8bKxKdSt9OO+bRpE8DIYqMI5UjWDZs04Tn9+peMnoM/Pstkg1AL+NdsRrj52OhHUWFLGLxhNamoGWObIzu9QpZCcYYjjIutwKfyWm0AnbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(8676002)(8936002)(4326008)(44832011)(70206006)(70586007)(6916009)(316002)(5660300002)(40480700001)(41300700001)(54906003)(82740400003)(2906002)(478600001)(40460700003)(356005)(16526019)(26005)(86362001)(1076003)(81166007)(186003)(336012)(36756003)(7696005)(82310400005)(47076005)(2616005)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:39.8058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7e5b55-46e0-406a-320f-08db67510c46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
dmub_psr_get_state() return an invalid PSR state while disable
the PSR because convert_psr_state() doesn't recognize the state
that return from DMCUB.

[How]
Add a PSR state to make the dmub_psr_get_state() return a
correct PSR state.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 6b4731b5e975..0ce7728a5a4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -597,6 +597,7 @@ enum dc_psr_state {
 	PSR_STATE4b_FULL_FRAME,
 	PSR_STATE4c_FULL_FRAME,
 	PSR_STATE4_FULL_FRAME_POWERUP,
+	PSR_STATE4_FULL_FRAME_HW_LOCK,
 	PSR_STATE5,
 	PSR_STATE5a,
 	PSR_STATE5b,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 4000a834592c..0f24b6fbd220 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -87,6 +87,8 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
 		state = PSR_STATE4c_FULL_FRAME;
 	else if (raw_state == 0x4E)
 		state = PSR_STATE4_FULL_FRAME_POWERUP;
+	else if (raw_state == 0x4F)
+		state = PSR_STATE4_FULL_FRAME_HW_LOCK;
 	else if (raw_state == 0x60)
 		state = PSR_STATE_HWLOCK_MGR;
 	else if (raw_state == 0x61)
-- 
2.40.1

