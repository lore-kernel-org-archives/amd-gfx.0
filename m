Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB877C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5668B10EDEA;
	Fri, 14 Apr 2023 15:55:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1CE10EDE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktAtNxpWIh7IPMvlMFKVNqJcCKzYomcVGSV0LN9xYQttPB24OUt3pJaiecI+Mi/ZFnaZfpg11VHGlkGL5uIaiLcdEm/C1zlCbtE+tHxq9rbIwbIwUkuIc9ivhz9saY6AqjBaZA6aOuFudjHg406MLcjAmDOm5BKFnRbOjDqyM/07OxySwHMuUmnDoyUmWDkmjT2RztL3Ig9Off22eNpIpwyifhuoF7L+G2xaKtrwCi5PwJysW0bt614Or3xkwa7eUpBJmVNLBIeemVtAqq+BSx9MdP12A8W564gNWF8F3Opg8b5jQdjNpbd9IuP3Xi3Y7fHREDLlNmW7WNTN48Krlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fuxtLvmlkVo0cv9vhWnVfXgx8R3DH/k88Ei8QRU28c=;
 b=CaIFnJiG5pXwcv87C2g0Hwj/Q1+DCGAZuki2XxVAX7/nynnB+MtGy+H45+H0fH0P6NHHftIyEUzSkSxo0GFM9/xG9dVfXcEsp5iUlQpbXLEjRPZwK4fkupxy3QNhewFSCJ5ahYcI6anHJYYa8MIUalD9Wj7gOalxZkYPdOp3qAiOXmeEH3MAGUVsMyVtGhDUsotI9olTNJhuYZBe3jG1W9W31DnY4lkiS81I6LBG7YcQiu7hRdZY639UQTsb669Un/FDd/KoNEd/3Q5j5OorONmxGdCVNrd476jy64snsFOq/3Hk8ttfai1qQQXdPLBDeJwu+DCjL7zHvwc9KkvOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fuxtLvmlkVo0cv9vhWnVfXgx8R3DH/k88Ei8QRU28c=;
 b=UiPvDh9mBE0Ja0edLP/acBVsX6qBAfvWhN8dT0kY0fp7Okf1WPPBg2UuzvM84sbzf1hguda5iLInRm1kBFt9GrWVzSJvz4uTwpuVYsinaEVSa90bqLzFEByzTE5VJakar3w4JjtUTlvUU8JwBOmHVBvEDjYRHhwgR1quFjhpn1U=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:05 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::38) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:55:05 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:03 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 51/66] drm/amd/display: Add check for PState change in DCN32
Date: Fri, 14 Apr 2023 11:53:15 -0400
Message-ID: <20230414155330.5215-52-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: c74d1c16-1852-4090-541b-08db3d009d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Avgi1rUzvtsqUVbjwIpvFCrPMXv0hgEezgtzRIOXSYqmgJzRslHnQyKHYpaXbo+D0ZzMdzICCvfljRLIMcUb2lcL68boO2TkYbMD4DFbas6FM3zkwhH9NbeHza+DkJdhUfZLpksQrF5jKT7RHjyWaGxCR9niFJIkoDInqTCydJy/OY5+QIi79eN83DMmWBd2Ox/qXQBUIYgmjnScdjv95idhlWGYPlithFAw+nKDs6+xBj5lWKHG2OhRUz8HDl3UKzkuEGWTcK8B9d1i5mbra0zPg0zKx6Hs4GbcIqZ1CvDgRKiuMBHi2BRvTPy6N2pPU7aztkKlqDmXBJ9eYDMiBJhSveEtbUjhERQ2CjPlLK9QQwu0rsqTnEo1ob86+IMx67DHcT7y1GZ1hRzkdlawXe5RdRLfh4F8QTOCAIkIGdShlNRJ/bLX+4dIIg/dyei6fqChuTeOoTgT8f63hQ9Uf2DSQpqFliPzAE4v3F/GJwQ04kBEMInn5hgeC1U7FtxOLFNcfkFilpWZ0f5kd2n6x8EUCF0i3yKORm8PjIDxSfir9V4x2Umk3YRztA5aNqvgK2xB7HqFCyCjLBK20lhm01NE1EEoRsLba7bwp17Ig0jo6u7hYWHR+g7SLaoRCQO0sDMWunUpeX6ATaINdW7jFfOeacmRNgDdFq4rsRGFK+hEjh4GASRP92xNx47pY2x3SqqTF56MZ0wVzFTHgzOjx+dgy7DPLeVHsD/an6xMqsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:05.0907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c74d1c16-1852-4090-541b-08db3d009d4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

For pstate change, allow DML to loop through
all possible prefetch combinations so as to
support more display configurations. Set the max
and min prefetch modes to enable the sequence.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index d39e77d95fc3..a50e7f4dce42 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4656,6 +4656,10 @@ void dml32_CalculateMinAndMaxPrefetchMode(
 	} else if (AllowForPStateChangeOrStutterInVBlankFinal == dm_prefetch_support_uclk_fclk_and_stutter) {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 0;
+	} else if (AllowForPStateChangeOrStutterInVBlankFinal ==
+			dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
+		*MinPrefetchMode = 0;
+		*MaxPrefetchMode = 3;
 	} else {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 3;
-- 
2.34.1

