Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7A2EB64DA
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jun 2023 04:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0519510E15B;
	Sat, 24 Jun 2023 04:49:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B5B10E112
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jun 2023 04:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRjxYZi3srmDyCoIljVtMqYxB5lNGnSfIvWdMcrWgHgqxE/snVUE5I9Y+DroPIHVlW2c2FCCKkLP8ZnC5oxDLbrR6LzGkoi65QeB18SXl72fBMEGqPd0vi4lb/ucRKV94NhHb9hOSQwQYNA8lfsiZSjjaaZ5XDslq1P5bq/HHPISBePvZZlxQfEc9sDZTh0ql7NVpBhWDaHsUMR8oiu2BM+lWxLJJPwNhssOkKhRIUBBZpqgGFW2weoUviFJOin25TsM76+j3cJwHBgQjhNK+YGZnsiT4NS0jEvaRsetLw95tOD7UFNyV0twIz8QYwVsuJAUA/uEdcRdRzZy5rtx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFpIn1l3H06kTpovR5ijCiw4bm08pWvOU9geG0yj7PE=;
 b=Cs9Q+mTRhILLR75sAvnQpozcPRocdmw/fpwtKeeZsve/XAjs0iu+jcIx3D4dagmhuv45AowpM+3tdpYWz3wQ2Ao+yEMCuj1ROFz/7KjdctHy4F06Z7hpiKTozSCHEMrVFjeIwvbdMcUin+McnmvV+JacC5J4xefH412jd0rNWzqclF9KkXAUSPgDBnDCqDrvt78/ZLOGnkdf0YQ1tVSSprvg14e0M1CF1sTkOb4SteizVXvwlPPyvWXWgIwo6e6iw5NCzVOzNOddfBluGniPMu8R5q7zPKZ7jcMRLlaBYmCUGKy3U4TT6EARgHmq1V5GV5bdyBw3LrOWUPZRCwvcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFpIn1l3H06kTpovR5ijCiw4bm08pWvOU9geG0yj7PE=;
 b=VwAxz22IpEwsfaHw+6zDFoA+IeduLFIqayw+1ozHND++v8EV1hfQ3JjfpD/iNHbTZXtLlbXWnkg453a7HXW47WbPJKBFJEnJEsNc2Kyrks8VUJx9udt45n3m6XfZu45SNKPFi12aC7yra1un67fPeT3BsyCQnEjJLQe8YMbb11c=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 04:49:16 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::5f) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Sat, 24 Jun 2023 04:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.45 via Frontend Transport; Sat, 24 Jun 2023 04:49:15 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 23:49:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Fix warning about msleep in
 amdgpu_dm_helpers.c
Date: Sat, 24 Jun 2023 10:18:57 +0530
Message-ID: <20230624044857.1233479-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d6f200-3ef2-4d65-9083-08db746e5ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVgtmb14GQsv1ctTODbqiIJuI+mKpHT1vP8/+Nn/3B33kgjCMIC6/+yj5TOVGHu5nUT/516G6t/ESurD2F1vyTko1622BJ5GeCGBzwdW9WMU4HnLng+Fzn1Y7k+gsvN2MiZ0pKgwxWfJcEI0DZLt0xgkLKh0bJ6zrMEnOvTtdFGm3/naY8INEx8VeC21p9ZrYsXTxBtS0TZbyjoV3lLG2cPnurlNtLc6e6DFTNT4paIpQK4DiOPLyauAs8ieXDZoC3imrF4pukDVNoturbgpzjdsV2NK/xdhPQEkKIroFAyW9Omz5Y/T92EdilJzRupl1kfJ1K4dq/eP54pPM2crqrdAlYx9mcmP/434r+JnmcGioYsx5ClJAvOc+r9ikwMglPvvtrqUOGhSuNZuPoRs/nvgUGIqra7sJZc/oX30/0ig1ZbNr351UG13mZiUo+Lh86uCMzIL2vyi5/LBazJIha2MBb1izCXsQH228LcvEaFTsOV2KZZTnVCkZdGhQ6JKWMCdYf6OH957B2I5RbocansP9A+SkMXjdsSga5f+TsIikOgjpM162kuGtm1XBkxaYYV6JEwdm/bSOW80B/ir2K1JUyH0D5UQCPc1+ZiDslDoVkk6KcYLYemTRWVuzJ/lqx6k7Q9kkRZMm8Pgdkp8+0oq9u8tEFeGiX5dk+wI4HcxnyZxS8fOUsMrlsXDrSUydMSqwPhMvkEMT9BFK1m1tCHLM0mPdOUkQXL23tW8sGaNlf3s+Dm/ZVdebYgL7B5hm1WoahwfJ1YnXMFt2uzqXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(356005)(81166007)(6636002)(36860700001)(4326008)(16526019)(6666004)(82740400003)(110136005)(186003)(26005)(54906003)(36756003)(2906002)(40480700001)(2616005)(40460700003)(86362001)(82310400005)(44832011)(8936002)(70586007)(7696005)(336012)(426003)(5660300002)(4744005)(70206006)(1076003)(83380400001)(41300700001)(316002)(8676002)(478600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 04:49:15.5136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d6f200-3ef2-4d65-9083-08db746e5ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following category of checkpatch warning:

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst
+               msleep(10);

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 12ed5a5800d0..d74b8618eed2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -618,7 +618,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		if (rc_cmd == cmd)
 			// active is 0
 			break;
-		msleep(10);
+		msleep(20);
 	}
 
 	// read rc result
-- 
2.25.1

