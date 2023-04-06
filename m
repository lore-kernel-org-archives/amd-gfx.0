Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927B9C7618D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 12:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD15110E20C;
	Thu,  6 Apr 2023 12:45:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4571910E20C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 12:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUA121wJeP6Wf4iAH0SRc/obRKSoCqWvRJASsshaaw1xSPcCixqgyL7nQA1+RkTpQ58A5wJhJ1WmMJ+/kzNPWsD3CYzWYuKgLjmOguiLWo5VzJ+BxI1E4BE9zsub3iR1YesmfbTsxUA7Cam86D1dGRD4jgt3GLbyVAR6d6osmrssTSQVi7yi4A7Mz/ctjwG+faiafat9JN2OG5ncJ/JulVbQngZm2QRlvYfA50VHFl9Sh7vDy3/xYnHIqgSXP505akPN/T+Y05TkwRI4+UTAC7ZH7jvFLvp7ySd5P+0sPLpeCvC/yJfxONeBynsLkL36CHu6W/Hfw9fQigldTzLyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBJTevGK/t/JWBET8UslobDCi1f8jdO2iHAuj/YJqck=;
 b=j/vsjX/gMJlZ/6Nw3OLSP/pIzpudQCazsf12TGk06/1PCL1wGQa2MN3KxKy+53kZ86QUtbr71SF43jHlq6njncA2TA+iY03OvcuRrI4RVxLJDAU8DIRMxuv0vPBSLb4Rjm437oBu6E/h6AMNa5qBi+NqqdidHCNOELo0s64BsFpwzwK35FyU8OwOI//R6D5ahAS9HBrHKr88VI0duxPDUFFj0iAkVn1QEMOp9+iqW4gXWpFhI8Bk6jrhDDwsU7ImFXWRIYc/KS6Nv9gL/JTlu+EVs/JY2sGEwIlNxxdWQcz4eca7zTp6o2Q0Djb8OfI/oDChFY1/m4iPy5JeVfTdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBJTevGK/t/JWBET8UslobDCi1f8jdO2iHAuj/YJqck=;
 b=ByCjtVvP+EDPBIBvU+CF9eYcLCpWN1HJ3nmB7P0YdsZQhndXDKLQyGKsw9xLf/rkeFHvdlmgTwRoz8ZElaqzlfcxgiJqvovD8IjzyM8cvDIFP/reETtZ3uwzjFcMHTlPhANyTt8/FOKY8E9djWTDTJEmgNRaIy88qRrj0uKQH5s=
Received: from BN0PR04CA0178.namprd04.prod.outlook.com (2603:10b6:408:eb::33)
 by PH0PR12MB5499.namprd12.prod.outlook.com (2603:10b6:510:d5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 12:45:18 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::41) by BN0PR04CA0178.outlook.office365.com
 (2603:10b6:408:eb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Thu, 6 Apr 2023 12:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Thu, 6 Apr 2023 12:45:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 07:45:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 05:45:17 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 6 Apr 2023 07:45:15 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v5 0/2] Send message to PMFW when SMT changes
Date: Thu, 6 Apr 2023 20:45:12 +0800
Message-ID: <20230406124514.2906870-1-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|PH0PR12MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa1de67-f43e-40d7-31fa-08db369cc702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aowXtMcgZuDxHUdfz323f/uQngtRHyKZYPvEsQU4ZQuaGHyLftB86tG9ylSkEaseU/Gz5P6W4Qu0exoz5PXELTzVMoFSO91UHIkt1WH/6t725gpVF3Gop8XpkxXOTH5juOi45daQJQmWleW1zjx3o1qmJljc/ji7R29KtOxZe5LJMG6oJFOql5SkPnZxRHWOMXGvs5arwlDbnxU9POD4782AGYsQEicPiTo5yNMTfKz9QeX1aIIpZJr65bC0LQTLkHL9bp8wWos1j7uUyDfeJcfb+j3dwKzVfGy2ufRhzCY2dZzDE+Wy7Lw7NZAK4SwIG38sd91ylstVBgPci85ofcuSxQPYI99L23ReYl1ESqBnPokWz6fNp0JbLOk0IjfmxeB18x/NcqLCxuptWaRX9XY0VzgyVdWepZykfi8PPLrkqXAVX9o0PUwKQZHKUrEoQfsY4l3uMtUQyeIoejQP2kye6dMk+30nHJQqGV7cADg1rvv97F/P0lhEB6HIvBn9X54CY7uY1Kml5WErynPqaZDWjIHHy1zvv6n5jJZyP9EQtTxRNE94I2vOZiE/HFJgS7cO9BvJzep6+H44BiQC09AkJPKOZMq/vmE6yIGrqQGyZhiUy4pReQAdSZD12B2dQiTT5iG3Dhhc8RZ4AvbC8gUm5GVVuEAGmtD5uaG4PtCNzuzmljxo7d13Ge2A+FIF6CJHuU24Wi/PUxw8iDC7X4TuMchlx79D4aX1qQLYn5I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(8676002)(478600001)(41300700001)(70206006)(36860700001)(4326008)(81166007)(316002)(6636002)(54906003)(8936002)(110136005)(70586007)(82740400003)(5660300002)(426003)(83380400001)(7696005)(2616005)(6666004)(186003)(47076005)(26005)(1076003)(336012)(86362001)(36756003)(15650500001)(2906002)(82310400005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 12:45:18.4196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa1de67-f43e-40d7-31fa-08db369cc702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5499
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, kunliu13@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the SMT changes on the fly, send the message to the PMFW
to notify the SMT status changed.

Changes in v5
1./ Add a new vangogh_fini_smc_tables() to accommodate the timer fini
and smu_v11_0_fini_smc_tables(). 
2./ Move the version check of SMU version before initializing the timer.

Changes in v4
1./ Since we didn't find a good solution to handle the case that
manually offlining all the SMT siblings using
/sys/devices/system/cpu/cpu*/online to disable or enable SMT.
Come up with a new solution, add a timer to poll the SMT state
periodically, if finding that the SMT state is changed, it invokes
the interface to notify the PMFW.
2./ Move the generic code to smu_cmn.c. 
3./ Add PMFW version check for this feature.

Changes in v3
1./ Because it is only required for Vangogh, move registering notifier
to vangogh_ppt.c, then remove the patch 2, and the number of patches
decreased to 2.

Changes in v2:
1/. Embed the smt notifer callback into "struct smu_context" structure.
2/. Correct the PPSMC_Message_Count value.
3/. Improve several code styles and others.

Wenyou Yang (2):
  drm/amd/pm: Add support to check SMT state periodically
  drm/amd/pm/vangogh: Send SMT enable message to PMFW

 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 ++++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 32 +++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  5 +++
 6 files changed, 92 insertions(+), 3 deletions(-)

-- 
2.39.2

