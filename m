Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4888CEE0203
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F13810E246;
	Thu, 14 Sep 2023 02:02:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BCD10E244
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NISVm598qz5NxLJQ4FIRyZPHk+p6yvEl74/mi8/Iz8eqE5zFjl4JFRzwRyReuQ9Xib8zJoLGqgnPNJHHeb3Vg7yuKmf5oQd5gC4JmgTM/gZoFoG2oGUiMujMrrdrWo5xbsTWvob2pJoQTeRX7o+cpXD9W/bsdbP3It7/6dsIV/xhDGs8nCZEGeszrr+I+ldTffA9yy6udEYFRvWRgdD3/AffxnukKMdglqUHO0QRnSBIqy7p5D5yX96IJ0hrNHu7wbTu5ViCZ88AWnRzq3GN03AobgFYCQrSPUKb/uSWbFYqk8ABcZ566hEXFSx0QKce7s/fpxuN8i6ex18miUG1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEpDRmwk8FP5IWa942PauSFZCMXwryA1UT7ohFDb0n4=;
 b=PzzzgxE/3xifER3R54R5XX16azb38QWKUWXFCO4UYyhoeG4IxEaUg5iMMVFAndK+P6ZmQogT4UmaBKGDtBfEYOMO+muzCqDBf4fcZtYpRO9p5k1Xcb9WRmT11/s3WhmvUy1t/3quat3AKepxouqJHp4wqlMfldEYKnX0lP7zwSvstYPtu4HVaMGHElujjW2JkIfbzfdUpwA6FgdMfJuHWOW99RNDw2WdPJLU00+Dnv63NH4H69HNgTzcmknkZQ5WjatTQycS7a/SE5oZ+sz6GXYrO0NypLL4ej+ObrrgiIiN9iDon+8Y9DGcB1px0ZwdKBKsts8dA4AeMR4gnXaM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEpDRmwk8FP5IWa942PauSFZCMXwryA1UT7ohFDb0n4=;
 b=bhyyIkZYH+ypvdK6tdEG+f+tF7TxXFyMxOUunuiIPopuWFn3v5iyUMRJbCD11OhPRohlv/fSBMXfun8zTC38oa+Vc9c3sTnjV7P3KyqfG+a/22KztGEYLzXhKAQK1ywpK85M8yp/msCQjCfgJQ8YLjyFaz2jy0FgqCa/qf/SGas=
Received: from SN6PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:805:106::35) by SJ0PR12MB8116.namprd12.prod.outlook.com
 (2603:10b6:a03:4ec::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:01:53 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::25) by SN6PR2101CA0025.outlook.office365.com
 (2603:10b6:805:106::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.6 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:53 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/28] drm/amd/display: Add option to flip ODM optimization
Date: Wed, 13 Sep 2023 20:00:10 -0600
Message-ID: <20230914020021.2890026-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a26bb51-2fa3-4793-f6db-08dbb4c690f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zThD/NHm/EmwIIcROfIPI/I52q2tdc30t0r672vy+7lZnTqpp0Xt68g7gueh07LWvsFFAv5enj5Njiu8XvCDmRgAZmwAOIYLjIlMTT+Q18deuuGXdAaqdYmIA9cNGR6cZpY7VVqo3S1zNeNgiU5tsvWtFOCF1Q7rr82F455+0CGpgQVVtye0qujGYGbudmzf3hch9jB9P1HLbJ9r/TS0lE5B2TuNT6aplukhiU6eeH6x4roaRqXnhb3DstimHLL9y1iukglobYc8aJj/7kFOuZ8Ra3VBfcl4flYc5RpDHo3lV6+cATNETesKzkz1Ue7Tb4JLOH+B6YneMXSgbY5Cfy8vhavH+XH1hA+IamX36U4JQGyQgZluOlt6S7+powAErTvwchpUzB8SnQ6McHAaO6qH5cKji87IO+LJoSi55OLfNBFIo9vo55qXZUy2rqEWOvxbS0UrZAdBByVi+HxChE4HAzw4XeFxTF69ZSUE9RG41d1XufRbr2SDxwuGQ5xrsrcKc2m1QlPpX1K7VQeqyEbTVFQMqE1aYponJZq+Wd1fPohaCl/wzjMsDigkrvYIHXJGj9RDYs4p5r9aJ+myVMlFPhIMtfkVvW2yCjadTeLNKAtvtzUWWKqg5C9YwOHH0pR3JUWAzvbRy57uQAPBYHoeDXOovqZc7jHIqGhZ2uL5/oQEnDae7/V/iMrcDZENPnuaHoR/a0e1B4SoKJzSCCQ4jwb0CLjroh5/sNH4BTuDcCIHgKFYY+XQoHV4DgWCw9nUStx9VQV0akSsGrVumQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(86362001)(40480700001)(5660300002)(4326008)(8676002)(8936002)(40460700003)(4744005)(2906002)(36860700001)(36756003)(356005)(478600001)(81166007)(6666004)(82740400003)(16526019)(26005)(1076003)(2616005)(83380400001)(426003)(336012)(54906003)(316002)(47076005)(6916009)(70206006)(70586007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:53.0838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a26bb51-2fa3-4793-f6db-08dbb4c690f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Gabe Teeger <gabe.teeger@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[Why & How]
Add a config option to disable odm dispclk optimization
for debug purpose.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bece61d2508b..f7e207efddb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -420,6 +420,7 @@ struct dc_config {
 	int sdpif_request_limit_words_per_umc;
 	bool use_old_fixed_vs_sequence;
 	bool dc_mode_clk_limit_support;
+	bool DisableMinDispClkODM;
 	bool enable_auto_dpm_test_logs;
 };
 
-- 
2.40.1

