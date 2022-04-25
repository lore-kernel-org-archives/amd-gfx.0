Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFF8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 16:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB2910F0D5;
	Mon, 25 Apr 2022 16:11:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB20A10F0C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 16:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEiPo02hYGqAfEc6s/QOTRi3h5cDVzX0kWxyJYZnY76wFctzYjyLILXAUD1qlYkVEtdoSxy2JgN6Guc6wGLp0uamBmCvLPfqEP8BLu2o2TFFMjXlHq6VGqJ9nJ+2FfLyCe4x4bXQi/8pV6EJj6l597PhCsjZplfmxyLO1WPnQQfis4WrT+v2Mx1p6bps0WozWR5N4SYb81totdDbk6goPIGJIykWVvuERynyzncFgWn5HsefeMR5WQWtiKm+HJyR4PU83XfV5Kb8/iYu1wZelQHGItXGFZWZH67izJ5zBQDfTCRVPOh1TlvWfQNSOjPnQ3ZpBHHuNNuIxYMdECzL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKLT8TYZaVCy0Db4tDB+T0AyMNNkqcTa80hyodKEBe4=;
 b=Q5OUDcrpA/fK9JGl6TgUKj3H70cSMSZVVOSP/qtAEWzFm7GwRaN+YtPBIVU40SQQ7Qb0GDawRX5Fj1vEIZn40sGUpvgyixgqvEokGzSo//KvGU/8v661xPbeTPz30SQYwvaKOPpJQbC2/4pnIEry16P4Egr3SRXQeTOUplZzU7mP5QpgouttcbXYGmE7tM2HfdMqMF+Q4ODlkR4K6Tsf6Hsc7oCSehAOz81pKmR1tGgLhFuU+ZgZW5hAZQzq8x8RYDn8qLZuD3P/guFZHs1nFxzhb5XBp8S5x1Lva/vadewj6cbgDFSyra5tBZRT3fgIoGokAgaM7VuTCa7KJMQ9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKLT8TYZaVCy0Db4tDB+T0AyMNNkqcTa80hyodKEBe4=;
 b=x/HZs7EqBt7+b80aAWL9yaUOlKzSEdaeagVc8q3oI87rQ2LFSk+2AtU+2G27DvSEPp5cILFRdQ+9TlJU6U6TqCSEAH67zfqxQlkCRDvT7Ai4l8pClumbb8vir7FRr+noQcZTDU1lsoW0iobmHccaJFAlHSjGllbOXRVw3EjAGm4=
Received: from MW2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:907:1::41)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 16:11:49 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::49) by MW2PR16CA0064.outlook.office365.com
 (2603:10b6:907:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Mon, 25 Apr 2022 16:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 16:11:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 11:11:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: Make dcn31_set_low_power_state static
Date: Mon, 25 Apr 2022 12:11:35 -0400
Message-ID: <20220425161135.1025420-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e159cd2e-b7e3-44ec-09bb-08da26d64d9d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3020:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB302086D5F618B1AE7DD040CEF7F89@DM6PR12MB3020.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piYqiPaejH7XQ/UyMhO8oP4SVjGal5FO/YlIDpWEIdJhYVy1G/8ZNcA+SSv+wtz4XEmlbvSRPRk3XB90RdGBiY1afdNhZAiN//5NaqHMtngo1It8/wqMcPHE3HXdnh50m3jMFqjJ3XYINHDU9OyrkzeMxBc1ur8EAC0Y0O+aMg1WRRFVLEyfhYylJHT4w8NDF6Axtc+wA5qgRwQfSXDrypTSruU/hqapNmOX1V2euSloWtwY1bdP8pa+b4+WrIYwkth9/ErZ0KwQ8nU7A9Fb39n4X/C/VuFc6z10ry3I9HbVmcNLAlINvAPoEqY+7c3YfyiqGLyaFcLiFDJgUeVjcmloMlhs/+hDAu7AeKjXPHYR9pDz/uwMMCXHdpemkqC/O+YRKvJNFqYS58F50JCejXBad9W4cBCH6HV+AipF9GwA7hE8kJATW+Lx+Hxlf4EHLoXq2Ss/+Z2jd+HIqIRAk0EbrUZolYc0oIqJMyO9HyJQ9ut5TcXhVHVce9mQX94xHfsiV3w8haFP03RmfkPB5En30/HM6KRnL6U0WfY/7PPwb4lYfo8ibQdKpp7EymMWtIX68f3Re621RpnlO6R54/7vE+kxVm7TGYz0Lo/KjpSOWtqp00WZ3QJYVP6HNVVACm9rjCwsBpvPJ7X9IgjKLu/LcfUkptJR3mUkvnWUbET+6yu6ksVL285M9Tpc8apD9zYRbx/mDO0gGaVm0k4Y4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(426003)(336012)(4326008)(70586007)(70206006)(82310400005)(5660300002)(8676002)(186003)(36756003)(26005)(6666004)(316002)(7696005)(6916009)(356005)(81166007)(54906003)(2616005)(1076003)(47076005)(86362001)(2906002)(36860700001)(83380400001)(508600001)(4744005)(8936002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 16:11:49.1621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e159cd2e-b7e3-44ec-09bb-08da26d64d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not used outside of dcn31_clk_mgr.c.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 969b40250434..ceb34376decb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -615,7 +615,7 @@ static void dcn31_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	}
 }
 
-void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
+static void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
 {
 	int display_count;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-- 
2.35.1

