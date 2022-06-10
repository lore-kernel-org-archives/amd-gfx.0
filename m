Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83690C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C42112F33;
	Fri, 10 Jun 2022 20:53:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EE8112C65
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipiDGqL+2TM7MJbLuM5G3PlErsklp4zhWpxrHfKJIKcotaKA8y4VCtNfaIp99Zx4cv1IE7EzB80okaUDx22eggB2FCyKPdGC188KTtTZEfYBFP9gqJr3ve2OS/V7qUky2BAi03AXt6GBg47qcm59CnM1QpVlA/ANg0StK5gTpm6/4vsiYcEoJn1ug7S7hw4zKK9hMzKbRyRVRgyFJTx9nv0MPvwV6Zbx3xjxtZhFn4T1Wgnt5NwWRCJZRWMZrZTa/E/Sr9aGdTU+yt9jYbZFTMWE6zp9Fr2NJ/SQn6QRzsJvIaxCGr0wxsxACU2cpgQK+ujP0+yPHX4+cZfUjLjCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Nd6eMpYWM7ONDXHkikTxHWdHAMdG0tpWlrBkR5+FgU=;
 b=KSVgDNh+738RKKCnGWuetFOpSSPCDXxvzsWCqUuA5MSv6MsiI4OY4hNc1ht9MOPZZjKYScr8QU/Bo2e7xjWJAOWnXrygevhsn0HPDwyxkoJrMaJCIMNZ1QA0IPVxq/rC/xF5jfR+PeR1ABYipkF3U5RS/v2IM+kmBQRttu6vNraAtXuMCyZ7n7btW+UnCInr17ETeMk/rCyKZYTU5kDMlJ7A2muuEuWh4c1ydT8o9h1wwrh1Gp8obhbRYhyv5UvPkXsyvaDbG6CDvu/tE/KXYfccFKYvSw50iw/ASY2v5BxyzF+NeYlohoHg/JYK8iciZZ5t9ALdEyLmdGvdMKXHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nd6eMpYWM7ONDXHkikTxHWdHAMdG0tpWlrBkR5+FgU=;
 b=MIsSCVYJpFYER4LiE/DSIRXrvkgpPPdSlpkSRG2kEIO/GSHLVkRcXbofA6PlKD0CC12ZTei1mbk0J/RGYsUOcpdD+IoDlAzFTkdpiwaPcLesc9yWVujkUnigQkQHEZ7zez6BiqjNe4N5ZJHX9CH00RvthdrTVMUQGrOR9cYt3M8=
Received: from MW4PR02CA0007.namprd02.prod.outlook.com (2603:10b6:303:16d::33)
 by BN6PR1201MB0051.namprd12.prod.outlook.com (2603:10b6:405:54::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 20:53:45 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::bc) by MW4PR02CA0007.outlook.office365.com
 (2603:10b6:303:16d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:45 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:41 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/23] drm/amd/display: Add null check to dc_submit_i2c_oem
Date: Fri, 10 Jun 2022 16:52:44 -0400
Message-ID: <20220610205245.174802-23-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5438ce89-d540-4378-1f6e-08da4b234f88
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0051:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0051D521E203C9D23C7F0D4CF4A69@BN6PR1201MB0051.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRw+A9hRh6v8+1fQoAb3iwtnTe1E0E55zc5omfclQUxbdTelNVgHtgVBDinvgk7sf05iBP1wSTnv4d/aY+eqoIaCwAs5zve5uVLQnVC4mGyEsXzsGYq0GOhd7eoptcOCdM8DSWoVZXEqsmPwi6+8X0lUYdIsQKlzlJw+eQBv0gYRSFTfQCfQX1XHUSLH8nvGrndw8XJ5NkNCHZGGJ6M4D44EwDoLJ9VykZMLZmUUDVNEYKsQihURfJ3K8MKcMwPLMLlIpvf2WRhlz/aaDDb7qVqc1nqowNsOvDNTcabLztd5kz3eJrLsDoIcEDXdr9hyL62jDnroIYjtYgZ8Coh6efATjYYwR62QvU43VY3GoZtKNq4WmV2/zCmkw1n08VtJOB/dRQed2LxsIQMq5/3Vgo0oPttUayy+dSfiW4PUd0HVOEAxFaMnE3Fl1qR50rbsDhp1eP+jrtDtXv53KIBDItuliFYsuQG2Sx8/Rd7wNQajgu0f49ifmEbOCLnRoQSg1/yTt9WAjwynOx8yiiozju4z7zAujxVwMT1G0/BZt+zCzhyTIJwqZy78l4kdU8+Iuvr6luFPQyfgakZ6KR30JSrVVntgzwHASJdtAj8w1YDZotf3suoZxyaRXZs2gFghJNjQqL4ifHpYziE6gQ+j+lq0oNfitNH2Upq3U+MViWhWDoq1MjOkgh/sl49xXVLV64/i1Enb2Lw21GStHdT0p68s8ial6AOnaCwC8eP/sf1Cc4uj++K+tPE3/q3lHTuVemFJhOE/Av4VO89xtNia9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(316002)(4744005)(356005)(2616005)(54906003)(36756003)(44832011)(508600001)(6916009)(26005)(1076003)(5660300002)(16526019)(186003)(36860700001)(83380400001)(8676002)(4326008)(81166007)(70586007)(2906002)(70206006)(40460700003)(82310400005)(86362001)(7696005)(8936002)(426003)(336012)(47076005)(70780200001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:45.4887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5438ce89-d540-4378-1f6e-08da4b234f88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0051
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[why]
dc_submit_i2c_oem could be called with ddc null

[how]
add null check and fail the call instead

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Martin Leung <martin.leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 49339c5c7230..258322c39e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3477,10 +3477,13 @@ bool dc_submit_i2c_oem(
 		struct i2c_command *cmd)
 {
 	struct ddc_service *ddc = dc->res_pool->oem_device;
-	return dce_i2c_submit_command(
-		dc->res_pool,
-		ddc->ddc_pin,
-		cmd);
+	if (ddc)
+		return dce_i2c_submit_command(
+			dc->res_pool,
+			ddc->ddc_pin,
+			cmd);
+
+	return false;
 }
 
 static bool link_add_remote_sink_helper(struct dc_link *dc_link, struct dc_sink *sink)
-- 
2.36.1

