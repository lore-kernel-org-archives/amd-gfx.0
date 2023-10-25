Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819A2C0032E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 03:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DA010E545;
	Wed, 25 Oct 2023 03:58:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE3310E545
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 03:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCj4PX3T49glIYxQQ9jZk3aG5xH+PNp5CVqGwLE9k3LThEIrlWs3ZaqKuYggA2taugJ6ofkZWJOJEi31x/uiMe1ZrLUVh89o5Zm5+b7D4IJtFhqf6Ihns6oudijGdB4XUfysmVSV8+5kW5+iOa0wyEOpoNFCzbr19WxFJH0bFFXzmMjO5WIe+g0V30d8Ls5lGtp7iA6FVAfpI9WrS+pJmmHeGSWm3bbzXmIe0z7OsG2z4KqLuplg3zDdvYcnhgEfWT8dcq5KvKN7DAsV3w6tK2pYdHBKzSXcCZzssFTAQ6azzXux+BvIPMvOzGn1TWwIYdrzNZ9TieuHjm08sbESCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PHMUwc4bNiJrs/LpMaoLfCXzTPbibp+iUFO2rMPWSM=;
 b=gOnKxHJwm5NYZGQXedi44NiHk2bBK0oeNZxVHwUk+BhKcKdV9W9+8VXXCVgXvjDzyPW2474CSfAzg+vYQiwX74FLjkikhgUq4GR61PNp/TS/F9GH0q/Hcew6K2s8844gL7idLVVOIie4AVNi9DVaEv6EMahRxrs9QfavNVyKkn1vlSJpxVTxSU0aSxDyQBuGYUwwGucrD8R/pzEcP4AHAhzd4+ZzTuZM9V/DJriiFtewOydby+h6HVeLLvzImqBJ0mx8AfjhIN5yxX8WWgUZqpWLX2Ssg3ImqjPjVQ0I9q+jESIufpOPSQQds7HTfa7KjgeYnNGmobUoiWVymwlvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PHMUwc4bNiJrs/LpMaoLfCXzTPbibp+iUFO2rMPWSM=;
 b=bOUwD9aJs3NHCw1e/EBpq1RUHtrUjZtnoiGaWWKTesWR08Jb0t7KiSY1c3Ir/L6BTHD1UvNGG3uckTgnKEX/g1kgEV4DnoI/vPZVIV5ILSs9mhRnQCL8gHEQ7zxxJWFZuW2lQi2gCycMiVDcJXos5trplajdcusx/TGSikUe6Ro=
Received: from SN7PR04CA0116.namprd04.prod.outlook.com (2603:10b6:806:122::31)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 03:58:52 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::12) by SN7PR04CA0116.outlook.office365.com
 (2603:10b6:806:122::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 03:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 03:58:52 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 22:58:51 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: check RAS supported first in ras_reset_error_count
Date: Wed, 25 Oct 2023 11:58:41 +0800
Message-ID: <20231025035841.23300-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8d1545-e0e0-413f-3d05-08dbd50eb3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pk9yfBeqSXVr8cnvxIr3Fx2r7mF4SYEh/BmcELYc31VJeX/NRq39QbBwtNc63+8dYYeuRUtBppVSbSyPNMi/e1VWx47XRHMKnyomnc3/j8zFriH5wwNjtXM5vbGBeS0HpoQetXCtUxMPstF/FOtthstdNy/g8OT2LjBCC1R324mCa/cxMASQRLHpUZBpEW4L3Vl1nqAHZisS6PXwmVPgNOhpggDLqK9M1fJxNidLgYQChOJ2/RTuDxS7jjEcczq/pQhXKa5NKrXCAUet7cHhG+pduRH+6loVqmxLfGc+oByc5uF6/Whw2pLdVdye7atUCzMxeg2NCaClW/+UYs8WbRkJmPcs3xCxesDQCoX2RmGpCip1Ns4DO7aPEAdu1u6cMOEx/x2kq4pmEwvOTPBU1R64mm2yDlSgvm0DhpvE9FP5EB9Mh77lbl0W7gT4wlny/7fB6tfoULN/kGHeest8zUFVzOvEx2jUFAE439BCanS7b1OTtvSSF9SPTZqLSxG3khJJZqQMVVU7DdG815FStsOhGY6S1LGzYcj72hAtfjvpEezmxrgBPyWcgnISotJEeoRw/J/mqUvQjixIkvQBXoJbPRq4DYjcey07MVT/bQYyE3g8yZRtKnJmg0BEFXVN1lBvqK+uODzEqlIXl+MDyD7djiDwN8LUJwzIQ1n9SD9OyszgjNOZSXzFdd8wUYxXYorlyK4t97jRP3ccWRZaRFipbQ3UuxPphaPErX+kFs8AyAmPDpFMugLZvbvT6TBJn8kh6GozlxxGzbs1IuxYtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(26005)(16526019)(2906002)(41300700001)(5660300002)(86362001)(40460700003)(4326008)(316002)(81166007)(8936002)(36860700001)(8676002)(70206006)(478600001)(7696005)(1076003)(2616005)(36756003)(70586007)(6916009)(356005)(82740400003)(83380400001)(336012)(426003)(40480700001)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 03:58:52.3034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8d1545-e0e0-413f-3d05-08dbd50eb3ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not all platforms support RAS.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c71321edf50b..a6cff4a31c54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1233,15 +1233,15 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		return -EOPNOTSUPP;
 	}
 
+	if (!amdgpu_ras_is_supported(adev, block) ||
+	    !amdgpu_ras_get_mca_debug_mode(adev))
+		return -EOPNOTSUPP;
+
 	/* skip ras error reset in gpu reset */
 	if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery)) &&
 	    mca_funcs && mca_funcs->mca_set_debug_mode)
 		return -EOPNOTSUPP;
 
-	if (!amdgpu_ras_is_supported(adev, block) ||
-	    !amdgpu_ras_get_mca_debug_mode(adev))
-		return -EOPNOTSUPP;
-
 	if (block_obj->hw_ops->reset_ras_error_count)
 		block_obj->hw_ops->reset_ras_error_count(adev);
 
-- 
2.35.1

