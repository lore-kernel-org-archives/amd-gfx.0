Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14149C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23A210E324;
	Thu,  5 May 2022 14:23:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D8610E3A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpPFf5srldvOJD/sPSj4tPSqfZrPSgGgFrfey4msyOGe9D2SXbBzhGqkDi8XnscAn+c8QA7U+oCqMORjOP2nsB3+LUgjEEpip+5hJ5ibl8vqoStgh2kW6qp8OQ/exxMzu/l0kuql34+ONJvZvA6xizJ2CEkygj47pEGvp27x9JFSmhTpTOkDUPg8dQkcEV7SrEp9QLPh5eBbo5aM7Du9T2cHR3eXKjWVO9MxB5l6V1hXM1od2jT5wt6QQ4duGZhVo8bmvjxVWL7hRk4/q+YGCEI2iA9QKJvs/USKON0QNIMqhAJwEw00RnoTk+ZGqn1JrkDfmk3naM1sg+7Gx2IFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHGkrcDJyc5k1m7RmbJMnJp9Ygs2r26W92MdnGS6BKY=;
 b=XaRe8SiPtW2YZBPqNlXePT7PPDA3Q04cYpqLB5kuB27Fg35r6Ftyi4JL2erHv8miFvnI4Swooe7ICMoYIXBk0FQYVXf0120gASAxzcu0FMxHOeaPyYaRIrfLXC8K2KM+BKY7Eh1Uq6QYnixdzd7L4vAjyr+VVmSCJ1+y6SSORd/8XJfRENrifzzLks+wc+25yVDm0Gk5/fYxdLw/xAuycRTDFUdNnpTMI+CBQ5cHyIIUwUcoxdd13BtK6uSG/YgA6uYHk9HaYhTYMAFv3u/uCBr7i32PVPcrNqC0h/U3ff2gjTxMy9hnykuPg3w40EddTjR4TucHJJO/dWOJABulYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHGkrcDJyc5k1m7RmbJMnJp9Ygs2r26W92MdnGS6BKY=;
 b=quHK/LZbI7ovYpx0+vseIVnqmLlGk8EPiNNmnzbjroF905qqmJQDnQpWlN52QnvS5x7H9A/oftnFYcp5NZ+7HekUXyeP0z2vfCAXMFesYtBpQQyj0IkMGEuvzJB19iXJghRXZczNlefI3y8XVUnJqZZtMFDUIT7gGBbSRJvZdZw=
Received: from DM6PR03CA0006.namprd03.prod.outlook.com (2603:10b6:5:40::19) by
 SN1PR12MB2590.namprd12.prod.outlook.com (2603:10b6:802:2e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 14:23:54 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::32) by DM6PR03CA0006.outlook.office365.com
 (2603:10b6:5:40::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 14:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:53 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:50 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/17] drm/amd/display: add vline time in micro sec to PSR
 context
Date: Thu, 5 May 2022 10:23:15 -0400
Message-ID: <20220505142323.2566949-10-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac79cf1-7fc8-409f-1c1e-08da2ea2e220
X-MS-TrafficTypeDiagnostic: SN1PR12MB2590:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25909DE430CF121D5EE50BED8DC29@SN1PR12MB2590.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+SR2JEoEgpdzAbgvbwWbluF/1ObE0IN1B4HQ8eLoiRPzHziYV0i2koYBap010L6YbPdBDryX4x3NHJPjrD/8+L+XZyf9TanCb1zlABBOlMnrFDQCmk3eD9bUlwidA9Hl9Csabl+pgwVIuS78/OBvtraJ1xgYUhUDFy5MWPWCOwwRNaHY2YDoRbIgwcEW/cKRZiHdtaV6M7hpZIyUaEXAgPafHw9/9XEmapiaHLfaNO7l6iSJnVeUVgsPSYS4L4rnATsvcigtOzDsebgBNBZAY2JcjVYmIhU9nbi4t0vwmCJ2C95YwqtBRk10Gp03Iu7GzLUy1BLr0E8C/9uc1FiKGHj1IFwVB+bplC5wcwept+gEzZfsHaKfTolM/s62q9xmBH92QcIu3dLXQqQe4dBoD8ZE7mic/PJ0t4oJvJPgHyJgIm0B8X4zjd9fTDhtKn3pXvAN7nuWKapQD8OI4lReDoTE8J8m0oviyjLYa0v/DH8xfYw8lhiDVy59bnOxyLu33DgUx0seo4XtZPH4lHbV/I+0kSTJuyssGYVmfXA2YRqy5jo7At3DQ2wJlcAPo1Vp7L+LaTa0rXPplyMcFh5uvWT7ZWTxytgB9G+BkdeMKw/rEfp/ZmajYwxPCHbY20TIGn/NqzhabkCVXVAEB1Fz9hmITKoH+GuK86R0Ue0T8blf4JCN9C35ya0+0D6jlOWk3jc5f5c786D3F5fMQsq8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(426003)(26005)(2616005)(186003)(16526019)(7696005)(47076005)(1076003)(54906003)(6916009)(8936002)(70206006)(70586007)(4326008)(8676002)(86362001)(2906002)(5660300002)(316002)(508600001)(40460700003)(6666004)(356005)(83380400001)(81166007)(36860700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:53.8743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac79cf1-7fc8-409f-1c1e-08da2ea2e220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2590
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
The current PSR SU programming margin is fixed base on FHD 60HZ
panel. If the resolution and refresh rate become higher, the time
of current margin might not cover the programming SU time.

[how]
Notice that the programming SU time is the same among different
panels.

Instead of fixing the margin with target line number, change the
margin unit to micro second which indicate the time needed for
programming SU. Then FW set the margin line number base on the
line time and margin time.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 2 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b750dae0a33b..0abb4ef65f43 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3249,6 +3249,8 @@ bool dc_link_setup_psr(struct dc_link *link,
 			psr_config->su_granularity_required;
 		psr_context->su_y_granularity =
 			psr_config->su_y_granularity;
+		psr_context->line_time_in_us =
+			psr_config->line_time_in_us;
 	}
 
 	psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d61ea3e2bfbf..119ce8b7a555 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -676,6 +676,7 @@ struct psr_config {
 	bool su_granularity_required;
 	/* psr2 selective update y granularity capability */
 	uint8_t su_y_granularity;
+	unsigned int line_time_in_us;
 };
 
 union dmcu_psr_level {
@@ -783,6 +784,7 @@ struct psr_context {
 	bool su_granularity_required;
 	/* psr2 selective update y granularity capability */
 	uint8_t su_y_granularity;
+	unsigned int line_time_in_us;
 };
 
 struct colorspace_transform {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index bc4943205bce..c2d65756ce5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -340,6 +340,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		copy_settings_data->su_y_granularity = psr_context->su_y_granularity;
 
 	copy_settings_data->line_capture_indication = 0;
+	copy_settings_data->line_time_in_us = psr_context->line_time_in_us;
 	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
 	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
-- 
2.25.1

