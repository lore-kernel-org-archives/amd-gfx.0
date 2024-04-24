Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DB7C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4717C11395B;
	Wed, 24 Apr 2024 08:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xQPKYTnm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A463D11395A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKBkCJoRjicdDuY8uuPPKisNx5DLNjBvYfNEUFQS7eRTCpw/mgFgTFx76s2n9pv4MEqlEWINs9CoPrgHryFgVsR31ODFHt40oF5x5cyshEmW13kCe3R7IAGn8mFv0ohOB9TFNVwh8uaI0LFu8fMbXM7zOPdAGCmU9/qzZTyi4OCqSfq9UOmdWnCTT64Tfe2FZ9/D/9A9rlKQt1iCbJyXLfSdEdvZvwF6qcxD1aXSq0bFRgnJt18Z7GsRlGZYmWyFfuoOYYARQYSVX6n+uqxhnfDBR1rwYyOa1vxjgDvoXy9HWPXSQGgsiYCVgrYqYeP27iWGytzlD7X0Uf35U1nE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipuzVxtr1BiNvmxGdKiHzJVOPVHG8FQy7BMcRc/nDIE=;
 b=MdJcy2mPLqxjFD14QatvIejczVcVRAM8pkCx6L1/mhPhvkvr9/+eUbQEN6jK4TDpNqipQnGfXRFZrUQaK0IhIXELhSmC03eaxjRqhin72vPkhOVPYVJ0vYhS2P0I9R10l2dbHDF592E/xiGwd8TeYePTJHTX6i+OQ/KmPKVF4RTdX965L+h+9pHCT/F1TjxZXtVk95+9sXwl5TJnKn5UhYWHv46Otiu3mnl6Y6vshK+mbKjBcQ5XQMNfyqARP59j0IsjqCinLfG5xRob65DZoBoc8dONUrvpSKCD0xna/eEBWMUaj0qeCDDQF7YBjLbrmSQyhj3B/0K5mVlFNHtjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipuzVxtr1BiNvmxGdKiHzJVOPVHG8FQy7BMcRc/nDIE=;
 b=xQPKYTnmZgwR4g5+S1NixvyUsmRipdiJ3EJ9qExnHhuk9Hx8Z4O1LRZK51JJgkpf9rwvcBOSRht3z+c5fgVHzDrM4+F65o/PS+PPX/OXqmHV/ZHZU1iNaFf6uVSHHVjA/tkR6WIHOiIvLbiRa+T8aZyNkcccXaS9munENr4Ofac=
Received: from BN0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:e7::26)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:51:35 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::e5) by BN0PR03CA0051.outlook.office365.com
 (2603:10b6:408:e7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:51:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:34 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:51:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 11/46] drm/amd/display: Improve registers write
Date: Wed, 24 Apr 2024 16:48:56 +0800
Message-ID: <20240424084931.2656128-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c852c43-b750-4980-9c76-08dc643bbf2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WBeGl5AV5t7lXwJHMpVaLuiWfi6UQNuAu1JjSvUib966jHGrt1PcyiP38Xuf?=
 =?us-ascii?Q?NCkWF68CAcq/d0K3J6rPFv8Il3mYK96wfzJOceTztmeQ8PbZQAhoKwwYWnpE?=
 =?us-ascii?Q?YsqeAKmOoNeEEipDboCtFEpQurj/J5lcLgn2YW64EUKj7zcHH4qb83HZiMa+?=
 =?us-ascii?Q?FceuC0ZZ48naZqH9BAyOIp1gg8VZnz5zer6VFo31jgV9YL00L3DPISgaHToS?=
 =?us-ascii?Q?IqJAMos/bVh1ewrk29iMqArrNNO71xoK+8SLKtSfIEI42nwCNDd/9VTOv48S?=
 =?us-ascii?Q?BydywWD29USCbdFo4s2+5b4vsEyjIoYgkh/Hh0OZ8QTt4MO7wW02N2HHubRr?=
 =?us-ascii?Q?4CYnILW6L8nYazAucmRYsq3NF0vUUy9g2CsPigrxHdfOxhup/cAZUEtw2Gzc?=
 =?us-ascii?Q?cT4xAnXlXZfw/+kvnAXy2US82lbB3r1wzD7vvyvjKhvM7PJAHde9EqOnEXoo?=
 =?us-ascii?Q?0yV2aw/smV8bTwL/Hy5TUoABjnoF7rCpjXQtxwXFlbz/of31IkhH+Rsd37/n?=
 =?us-ascii?Q?y4BhSJ899/idLu1jCPhwHSfzAYd4RLPgsnp3NiAtJu78CxEy7ndqaD97RfhN?=
 =?us-ascii?Q?CL2og8lYBKfMe5KEB7dcxF7pWBZzop8PUuoIC7HxM+yjOTcaJ0GUMzaw+3hP?=
 =?us-ascii?Q?/od7uR4oxpShUPDCf1dWB8sotlmCGNVsP5V5W4IileL0cFR9xfD9n9HIIL94?=
 =?us-ascii?Q?r3BcciJAXL7rPmApnGslTPsdxfwmRDVkC2uRf4bMKtI/2Q1gUY+KTuiLuPeo?=
 =?us-ascii?Q?OsqOX3cgcfHXomHa0RdWCFHbPQE9AJqstXsKzIemgQ8dzZSq8oFEMhMLO2YF?=
 =?us-ascii?Q?jTO5h7+jeU7Opw9eVHTJxQD+0d1mXtNzALUfTtpGf6nh4EECHrBhZkMHAERn?=
 =?us-ascii?Q?1Wuzt9OnccK5DjorOlJe2XUD6TXTaWzmayOCVf0nBLdmaWGpS9SB+oOn4QIJ?=
 =?us-ascii?Q?meh4z3jJh4odnHJCzrp3eOln3TVlaLol5luVA0LBQjNm/Z6hWkBkNWb6UsLE?=
 =?us-ascii?Q?Z6hWNdWdlf51mR0lbX63cI58fGA+nriB/a/JruNWc9rPNWqTDBkq/0IO4f/Q?=
 =?us-ascii?Q?l5xm6ZQsa696YJuGYo/3xZgSsIyAfkicj3qacpE51ReDYSXCTURWRSLn0uwJ?=
 =?us-ascii?Q?sMCATczbhEyMr/8femzjspWDsf676iBRAFChxdMFua8sK42atkCu3Vs4/edR?=
 =?us-ascii?Q?gOMD0W3qUwtnszqwV8igr4SugaTIzHhMDSTQ5o9yf3rhpX1+0Wv70ZWbfOFh?=
 =?us-ascii?Q?nRFdlRLTznR53ow7zNNqN4OAdkIcNybYWOAce7JA3NqSa4xcDjaWHX4xckyr?=
 =?us-ascii?Q?O+lbOpvC4OpnV8oEsda4yU6khIbs1nSScvjk0d1QkKD1MqtH3Jpv5oc+Bv8c?=
 =?us-ascii?Q?lTfnWco=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:51:35.2387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c852c43-b750-4980-9c76-08dc643bbf2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Add REG_SEQ_SUBMIT and REG_SEQ_WAIT_DONE to optimize the burst write for
the regama lut.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index 20481b144609..2d5d64276cb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -410,9 +410,10 @@ void dpp1_cm_program_regamma_lut(struct dpp *dpp_base,
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].delta_red_reg);
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].delta_green_reg);
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].delta_blue_reg);
-
 	}
 
+	REG_SEQ_SUBMIT();
+	REG_SEQ_WAIT_DONE();
 }
 
 void dpp1_cm_configure_regamma_lut(
-- 
2.37.3

