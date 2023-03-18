Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF1EC74A5B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC27E10E356;
	Sat, 18 Mar 2023 07:57:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2AD10E356
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5mVRdIA7qXi9UiaS/qPG46eOQG5txvr+5zEpzubXLvU/wwXrFNHYHzE6NkyVDCWmHsExs6gD1DvS3BeihB7yINov/knQ/S+Luc43TRlKxMAsHOITzd1EIpMUBUmpDe0G2Ugxx+jfWLi++99Ly+E0QL1SPEtQBgfjCyNgJBDHDe4U1pheCIexTkPAJyP6DgK38qr1nEaS6AAhkoCpPxCpM+tzjTE2nv9Nvrvxv3XwT6bLcKqlDYWK7AaIN8t1QAShlZvSa3uaVfQ3+q0TkSvsnf6x1icGp1hzI+NVzeN+7e+MVO3MYnhqnozO57jH1TOe/osCshkqdwckbCKwcdrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDizuY5ekB87TOmdFaxUkgQUhYoBdjg6M50ppeEfstk=;
 b=hK7AeYmSg8O/VG+ABLwtQY/aRXY/R4qUZQHuL5jt/XlOOqiB2mhgvhHQU4uiB8uHQTQ0KflVpscs0nhzqUVG/fJohd3TIUMR65SVdEk6eSwywbgnuFBcKzhwSTV5fOAgAnU6fzmk6ejOVC+WJHgrsU+XAHS8vAZmhrgEahlzYkTmGZkDt5oPK4xkxjbsP8LVSNl0m9jDfjbeZ1IIwHi0gDs3DM0Ws+wPwcDMqkiGv8J09hoJZapS1Zl3MmPQ6q+bpuLgUi1lfR5iS7z4HxvY51NJw+HmCOGEVXxATC7RUP/qEhpMUIiJCpbAFZ42SFuYdlzlvIVWSCsbRXa4M9xihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDizuY5ekB87TOmdFaxUkgQUhYoBdjg6M50ppeEfstk=;
 b=0WDNykrAADFQXWGyws2J9iFJre/N20CwzRCP4UX++BMiCaOB63b2RfnwvB7VTZg0DDAgl1fnT+LIdJa2D7rYCKsOoHUlIMkx7uJi0/dDU5rRf5QRQUJf3qDz8aNyi5m7DFXfmwiFPDwYFJ8qQjQvtgqI1y2VvR2HnFxqdJgVuQ0=
Received: from BN0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:408:e5::12)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:57:36 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::27) by BN0PR02CA0037.outlook.office365.com
 (2603:10b6:408:e5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Sat, 18 Mar 2023 07:57:36 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:30 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/19] drm/amd/display: Set MPC_SPLIT_DYNAMIC for DCN10
Date: Sat, 18 Mar 2023 03:56:08 -0400
Message-ID: <20230318075615.2630-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 2342c011-d358-4130-e546-08db2786704a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnMeg4PCF82yiCKh/kCoEKeWdcdeW+DRCv+UTZXO49d8ujUb9PkNMZCBrhWxGk5ohNI2KIwhVx6acNZE+R9yAXfm3c20SSA8u2MgG1sr24nmmUHvBKRidmKTE+WLIAEw1jgQyt7Vxb7QGWhDp9NoYw3GleAFUsW4iXhOF8LJqhQmuB9UfbJrMLB0pGktbtTw9pOe//m+w4QXBSpL56y4ke3Hiskj+nATfuSXGoIkB9hKAPOs7sDWzATqiA8FF4lo5rTsiyCzJ6b5gIv8Z5ZI/xgQXCUEoLzRWqGSTqdSbxs4Vb0MloVVzZhWVS48PY/6vbKb5+UCRjDbm+t9Ps4KX8sWNpPRfW3bjjnaRW2Rzyj6HAjXixq967RpWNJMJXjkgPS8TSiPyxXkb8vRoRugxjtRHhkd+jzFVM+rKRNc9hupCbxtiPwQor4E+R2E9ilyLEEDsRPc8r3HCNtmZKYmyVOYZnQsT+wyxU9dUdMWnrEBqGAz8WZWkDpa/tTM7zN6MPdECBw/bZzdEmxMotobiHvLfZXxlQtQdYzOWRwm/y+06MPniqN2NDDFW0jHF8XPmHQK+Cu8MqQs9tWPO0ZNocfH1bKBxBe6QXCEob8RzQYpPAw8RH7e0YUS8kKRyIC+8XUNFFstScpQoG18Yn1bcW+dxr7RxyVcLcgiRlqr5mM06I4Sl7H76xJiA5sfnIHWH4FoHEzwh5rWAxQB/T8+x/2WYJ6U9vXuqnDhg/F+7sM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(426003)(47076005)(186003)(6666004)(478600001)(16526019)(336012)(83380400001)(1076003)(26005)(54906003)(316002)(2616005)(66899018)(70206006)(70586007)(8676002)(4326008)(6916009)(36860700001)(8936002)(44832011)(5660300002)(41300700001)(82740400003)(40460700003)(81166007)(2906002)(356005)(40480700001)(82310400005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:36.5645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2342c011-d358-4130-e546-08db2786704a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Since DC version 3.2.226, DC started to use a new internal commit
sequence that better deals with multiple hardware constraints. One of
the improvements is a more reliable sequence for pipe split. Due to the
transition made in version 3.2.226, it should be more reliable to use
the pipe policy as MPC_SPLIT_DYNAMIC, and this commit makes this change.

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 2bb8e11f26e0..21ec1ba5ed75 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -542,8 +542,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.disable_pplib_clock_request = false,
 		.disable_pplib_wm_range = false,
 		.pplib_wm_report_mode = WM_REPORT_DEFAULT,
-		.pipe_split_policy = MPC_SPLIT_AVOID,
-		.force_single_disp_pipe_split = false,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.force_single_disp_pipe_split = true,
 		.disable_dcc = DCC_ENABLE,
 		.voltage_align_fclk = true,
 		.disable_stereo_support = true,
-- 
2.34.1

