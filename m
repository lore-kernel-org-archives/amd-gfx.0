Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B664C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 05:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAEB410E0AA;
	Thu, 13 Oct 2022 05:47:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB9A10E127
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 05:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFjCaD46c3fxPwwSNp0jxsghdY/UCN66dy5XHLFmk/akd5ICWw/eG81QC5uNdbj1yHKA5eBHW1QgafvV/8EX48UNew5XhfCxM4MDYoJyYZd8IQJ1/d3sWgRP3g3HFOqWb/WrTW0dhr9Jd6N1kHYxXCML8sf4rUXZMaHcNCl5RZgubTV1L920Ni7mgfFcI7CgbXixh4Fj7lMoCBq86TvZtftyljFqucDAjQdAce9pFifOYUpAHCEwhUCTTYIYZv+vpvyAYD2wS2Nx0CuN62Oyggk6unWymqKYEuEOxqPooVq+twrIEBHfaXuaCatea1btawGv4lPgwRZPy690vXk+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VAKkCtHopa/wuiBZfsQZfJt1qR8cKvnUItCvhlWKvY=;
 b=jKGOCy15lNOk72rW1N6uhpE2Jp9TFBLXfd1L1sP6YNGxyQo5wWXPww9UCAYp9GxRDNhEPhCNWbGVE+kodXA9mgTlk5xip61BRWl9W4DwUFFL4TkwUAuzCju8mEFrw6QHSf5XJjvwjVn9qT6pp7CBljHp+2E5puisH6kLU+Wd4IpyZdBB18QY0Qq498z4XV97F2pExEBIuLdt6IuFGBDOhgEoiplzHATPjNH/JE400H1CoZlV/gWL00UWH+aWe4wUC+QcVUuMZ9Pm9rG2n1Bo3N7L7oUq0JLmOt2/8hQz+CwUpQ1mLvdbbjlWV5ETFwo3VLlCGfUBL8C3LcIsAw6LDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VAKkCtHopa/wuiBZfsQZfJt1qR8cKvnUItCvhlWKvY=;
 b=jv2GWeiiDt4QX8/K9HPf5sUbtKDa9HsrIzLkfVkjRwstCjA0MTmq86uyruHsoOHPIlsLwZoYmhjNNh8oUtZ96Pvyf9GRZOTT3bSRZJSPSqcHvxU/kc7r0I21QDCKQTHBTf9BYfAAvCnQGe5y9eYl3GisBwFN2Hrp2Xeiow63GYE=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 05:47:27 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::6) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 05:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 05:47:26 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 00:47:24 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: add SMU IP v13.0.4 IF version define to V7
Date: Thu, 13 Oct 2022 13:46:19 +0800
Message-ID: <20221013054619.3979464-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221013054619.3979464-1-tim.huang@amd.com>
References: <20221013054619.3979464-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a73314d-145c-416a-4ab3-08daacde68f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuCqF5vYPKVDWesz9QD934LFCJXFafV+kKLXDEdmDeo64TLIcnblP1fl2eG+3z5uAhvID4QC/PZB/0ZQsVobhMgJ7F/kfvS9aFbtIkHPxSmmOj662e157vTC8+XMYNY3xi46DUtkEG4TCWOaOW0Xi7rOKfKa+qmyYriAaXQ50F/G7Hd3s3v52byf/CMw2LdFPfy89f4Tcg4taIJJLx17BazhVbKXII2/0wmdfuL4X8V77xdNMSw2KjprZP6myaVA48FAqo/I/aadLxg8jDV9bHbn8+m3E+4S8MbkbNMreuO+h3nRk5omj2vTw6KALg8c9obIMgyPHbPD9pvjPVTn46bn4TePETd15v/GE5sd4V6FZRgQ4/41jlwxH4L4X+n3AdHwC/EG748TQBNLXJOaFXvuoMyehD9j4mId7GVBTBZxIPHgBk1Ed51UQGV64GYNfT6d++rvQidLIQMe9z6z1zaxRWFc1u5xRA1v6/eh1jTeNsf3Z0qabWm57vqAicNB4SBINRkAs9na1TWldMqvixtJIfq3Zek1wQ27rFyCD6gHo0ia7fOK+NAF22f1dk902rKtRbqkW2thyXQzBbcb0TUm/2qk7zw6jVM+7+bGkGq+MTn1JDS7Z7HXcXTc4/mAGXE8dmu6VzDr2MxuL3mRvipLhrL4GpWaWU6Rc8Vd4PG32wv85eCGgfKmv9qHH6uHCP/ndKBZSS9wIewa/gM2V5bkrq1Lxhv5vZR9fVXg3y4Fh47cVI6oGP8dxxT45F44/nkhPz0/wXjf84TjjfECz0Cq3drWKWH9QMhiUjx8bq4BntyPMb0dt0TP2LQC6VfM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(336012)(316002)(81166007)(1076003)(356005)(4744005)(47076005)(186003)(16526019)(82740400003)(36860700001)(5660300002)(478600001)(41300700001)(2906002)(426003)(8936002)(44832011)(8676002)(40480700001)(40460700003)(70586007)(6666004)(26005)(4326008)(70206006)(7696005)(82310400005)(6916009)(36756003)(54906003)(2616005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 05:47:26.8185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a73314d-145c-416a-4ab3-08daacde68f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The pmfw has changed the driver interface version, so keep same with the
fw.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 9d62ea2af132..8f72202aea8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -28,7 +28,7 @@
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x05
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x30
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
-- 
2.25.1

