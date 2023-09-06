Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F98EB8FC0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC9410E63E;
	Wed,  6 Sep 2023 12:51:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655F410E63D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvlDek3waHVtA/BNHPxf4dy1ns01YlhCXZU8HdiCKAlQo3ccKF9SR5XyUWuhApjHtsVTQPEbZPsc2qDZBb8nbe9XvBG+ZMVfHfth/AsANqCft69V8XZqVoCzGl6pt4OOSZ+j8IVSb4r0QiHdpK0pfH/IeFkDtSwInBmkkeLQLVtNERbrMP0kCG+5Ik8nb655dlLnRF1QkXSZZmLuNp+FJXk/gRBIpUxXlnSBf15G6osYCOJ00f0/Xi8HCGiJ2TCkmexI+kO4+Xyl2EVBn7NhNZIkD1OTbpyumOppKz+Ca+j0FcXU/cX8CChf4jkA2epoGvZR/LW87YHZjEhVy6x49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bf+NWImYB9K8miHxPyL/wVZkwCPKxXbU1w+C2BxSpg=;
 b=c8dFh60BHxYtLkRnGlvVlGrX+QshUUyMi7n1LpkFF47o0nlMUtWcEF2obDLew7xV+piyiaIhoEDQB0gWVhon9cz36iJMv5i7waosWf5JJTbZjwg5DLKc96tS/I6vS/Im2lWwOQvQxyCpQjlfZV1MWW3qgdlgTAoww8CAFpxn0i1ps8McQYP2N9350lcYcai3ZqUuY/wrnktrmREgUH6Pw+tTEzWr02kIacgRcyS/TD1HMj9BfJxSZQV/qr4YEaDeXfefHGJ1TAt5AHlGiqBWhSvFDZi86If0tbUS4W9EnsqyEnjld11962Z3oS6uH+lqU8q3in69xh8pjAHK0hn1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bf+NWImYB9K8miHxPyL/wVZkwCPKxXbU1w+C2BxSpg=;
 b=bZ0Sb70IBDmNwwVLTTa5jarmv78kCCqEO9NuonIHRtEvIJY/uwWwHHbwvlzEM/RwXX2uWdstsyQLgAW+a46odIeRwac7ORRkhe86khtGW9NUvkWPPh91AVTs0jRMBKg6vT/m8a1bt0xaqcGOxHcUAV4zNpKVt1rTDUdvB1Jw01k=
Received: from MN2PR04CA0035.namprd04.prod.outlook.com (2603:10b6:208:d4::48)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:51:23 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::e8) by MN2PR04CA0035.outlook.office365.com
 (2603:10b6:208:d4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 12:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:51:22 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:51:19 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/28] drm/amd/display: Drop unused registers
Date: Wed, 6 Sep 2023 20:28:23 +0800
Message-ID: <20230906124915.586250-19-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b186be2-7dbb-4b28-202b-08dbaed7f964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRXDNtXd7sNoRZVLwdN+Pmdm53N8XkMWKC8p4aIIuu+sSxzNNzGhfPNmC6Lhb/wlW3YxygS47xZwpbSTjthHxPe4q19dxckCiek7bcqFs6xcckDukhV5XsgNJQM6IagPdQ85OtYesSxuctkObYaywPfKpfELgShKL4IiCeYMDs5CZuLAVpxOJ89naSpNerfNNXkfzHPVSor8NG4ds4nHSsKR59+oGo2vLN0MX/7uL0av1MSuag/2SEXkut50tn3DjAN3qPQrU934ONAR8WlTHthahnYOSBFcIqKz34OOd7iwoErq108vtnaqWovoXJHrkE0oNNKOtOgmY3OLqCO8qOYtlmcEXQlYlokmdwrOMzf0Jewav9tV51QtptjaXp7sxo16+C21xYPl8VzrJNiQIizlocLue/+C1iMF0NtJNsCf7mgrGR2CiAAhczHJR6ggfaz9Vz+zHsZpARUTXEmTcCf9B6wv8efzd80gm9BoEnpqIeu+UQ8smKlvm6G7iDBe36hX4LMn2e06cTkm+cVzy4qfvM2JhnYpxkUU8AlYjvixmgst1DePeW1R4KMHp5OIf5tHncykXKxuabhpN3AdVImvRvuY7d7XtDANaFwxJb8VH+hhYt0q1Sg2QSXD1dSLq29m8g+fMt7RFdLw2ZQPhyUuwFej3T+k4INB32uT6rRqRDhekXpdwfKjV6PY6ZwaG8at/hW2vfJ3WV5dgahiE9MWs8W/eCOrcr1ihWoYX3gdPzo9GuDrVkX4hfwbqmlsV7B5sbPHix/oPAIvlUulXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(44832011)(2616005)(83380400001)(26005)(16526019)(336012)(426003)(36860700001)(4326008)(7696005)(5660300002)(8676002)(8936002)(47076005)(81166007)(1076003)(6666004)(356005)(82740400003)(478600001)(54906003)(86362001)(41300700001)(40460700003)(36756003)(2906002)(70586007)(316002)(70206006)(6916009)(40480700001)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:51:22.7878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b186be2-7dbb-4b28-202b-08dbaed7f964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why & How]
Some registers are never used in the driver
but defined. Remove them.

Reviewed-by: Roman Li <roman.li@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
index 013029f2e257..dc7331dc3b65 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
@@ -37,8 +37,6 @@
 	SR(DCHUBBUB_ARB_SAT_LEVEL),\
 	SR(DCHUBBUB_ARB_DF_REQ_OUTSTAND),\
 	SR(DCHUBBUB_GLOBAL_TIMER_CNTL), \
-	SR(DCHUBBUB_TEST_DEBUG_INDEX), \
-	SR(DCHUBBUB_TEST_DEBUG_DATA),\
 	SR(DCHUBBUB_SOFT_RESET),\
 	SR(DCHUBBUB_CRC_CTRL), \
 	SR(DCN_VM_FB_LOCATION_BASE),\
-- 
2.42.0

