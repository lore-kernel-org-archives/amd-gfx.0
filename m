Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1C7CCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50AF12A90E;
	Thu, 30 Jun 2022 19:14:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6033A10EC70
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKbqXnVDGNRWAEVdqF6MYie3Q9spkSP9bln87PF8sEtUk4gpbLYLB5gS72iKSiLSTNuKUf9Ba4VdKDTgY35vEpUPZ2BmPXB2esrC+dGXccrLso9llCvriN+iPMcSN6COAxh0KFdScLWoH7tEcogg+ZL49vkyjEeFqrKRKfSreU/xhqd6LoZu6N/CPYeVnT4ZkfQCdFaqZDyzOJtOz19AmB1HfMZpoIbaxC+lju3OydFIpSuXN5IRRoZCJs6A+LZ9A7uZeoSy8LrVBojcHQjSRvxu5Vidmgj2dLqR2ajjNTYiYmERbZ4u/MEdIqg0ollrsk3ypBdJSgBMebAR+Sj9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt1avEBFCWQvCSpTUNcAxvKQ88VHOwq81A5WRW5Xq5Q=;
 b=Y/lhgl7B0lLnzXhBdw2pPziFk0jlA2OfzSqn8Zsb+fWih5wnXBvxZF1xaXRmGEcuGTj0YqDuQGdSerbXJWHzrZ08BJXjyliU+Au3qvxLPDC1Lm0byv4eesWr/CQHUtygPdfGkR69ns91yCQtJ4HT3J6nPev3YJl0MtddFSkUxdMFQidD5q8fG8Im74ULuYLktIen7kVrNWsrxSpE12Fe8iyta4jGki7kHTtn7c9N630ZRx2sEDsA75L+gsJQqQuZyTfkHCEVEM6irowCROMqGsPQUrt8s6TWuyMp4e94ve135B3oLKyYoR3WQzbCEgutCc1elmT6eWho9xUdGLy9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt1avEBFCWQvCSpTUNcAxvKQ88VHOwq81A5WRW5Xq5Q=;
 b=Gl8VISCGLFDl70fwyYx1rZuuCdeSOhb7dmDVq+eFqsPJ600ynCLBPNGbBIr+KazTpkTPyYZLWP6YLn/iC7MHD02OnYGBh57iQ2osjh/Bmyjtxp2fAXwTBPnhaxHmMqgqzo1H0zgIDzrYAD9uScU5/zHMqPNwa4d0mbnIkjOmh+M=
Received: from BN9PR03CA0142.namprd03.prod.outlook.com (2603:10b6:408:fe::27)
 by MWHPR12MB1680.namprd12.prod.outlook.com (2603:10b6:301:10::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:14:20 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::23) by BN9PR03CA0142.outlook.office365.com
 (2603:10b6:408:fe::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.17 via Frontend Transport; Thu, 30 Jun 2022 19:14:19 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:18 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/40] drm/amd/display: Disable TBT3 DSC work around by
 default.
Date: Thu, 30 Jun 2022 15:13:12 -0400
Message-ID: <20220630191322.909650-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a9b2f0f-5bce-4bb7-6342-08da5accbbd5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1680:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpbLbPWGImlJFk+TSXx+9gyV9eY3fbQFlmAtotIR8Nu6/ZWzVtkQLlUEAZZb4zLLgq9VxQ7dLQ9bAPdkSGq3To25QfKSdvvWzP2BJOAF3L7xpoUbl1a/NNB4EW8Yuhaizl9OQWxeBcg5nZKeaRTuLg8GqGHr/vb/XzcU43/Izp5iTM8o2IYvBlXk3iikDijYiVc6FFYNISj9tJsG8yXASnUZJ0JMLzdimTSGTW8HtQNY70Xbt0+bTz/rqnZL7MskSGDrPASxS7M0t+iFPPrNSyYxFXTdzGZG/pqd1R6Z4gAFoSGxgtPnUqQYrVb20FaZeUAlDtGt70RgbdorAuPidM1+XgrjRl4zgkSnqzNq7Kw4uxX0GeOtuBDpibsCgbIUFNs/KkDxtUH/G2xmZ4B8cKNlbZ7LaD81Wj3AnJrpLKMTianAS94FPNE2nmkdRYIucl3Ewhn1Nv4JQ5yhW3b8VE49TDf5r0lRy6/86GnLBpgdwySNtQUfUYa5mhNlc5tStUk2+9q9P6Z1JST5odD2QpUOWZ+XPnUE3FtCYp22QYxn9vRWROMX3W2ZeeYMchE9uD+e8HtMv+axnobmiYhenUf6L9Fk8hSA46yLUjDqrN09rXX1EzA3TZ+ENQsYgLfJbDrZI5HKv3/qm1262XA8kknOUeSW18V1FzbvDo4rj7IWOJDUGOUdt5vGPxO5qcH+96N+fL1Yj60zF/Zu/g2zc5Wg2ZXFL2cCN0LsDAR1UapfrV7B5IffpIgp6EI3XmjaeO+vk28QEluouzOLnw/J5z8uJriHxW4iGL2sztZXIyKw/L1ysCu/OzIx8bDT7884wZe6YcAYuPq7jsaHAAR726+2/YIYGr1a2Ptu4g9R30E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(40470700004)(36840700001)(8676002)(4326008)(5660300002)(8936002)(82740400003)(86362001)(83380400001)(26005)(70206006)(6916009)(70586007)(36756003)(316002)(54906003)(478600001)(426003)(40460700003)(81166007)(7696005)(16526019)(82310400005)(36860700001)(47076005)(186003)(336012)(1076003)(41300700001)(6666004)(356005)(2906002)(40480700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:19.6717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9b2f0f-5bce-4bb7-6342-08da5accbbd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1680
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
 Meenakshikumar
 Somasundaram <Meenakshikumar.Somasundaram@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Some TBT3 docks have DPOAs which report USB4 capability and are expected
to support USB4 DPOA features such as FEC/DSC.

[How]
By default, do not override FEC/DSC capabilities reported by TBT3 docks.

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dc.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index e0660e7356c9..07e5b316fbde 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5553,7 +5553,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 		 * only if required.
 		 */
 		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
-				!link->dc->debug.dpia_debug.bits.disable_force_tbt3_work_around &&
+				link->dc->debug.dpia_debug.bits.enable_force_tbt3_work_around &&
 				link->dpcd_caps.is_branch_dev &&
 				link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
 				link->dpcd_caps.branch_hw_revision == DP_BRANCH_HW_REV_10 &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 30379e5ff898..337bbd4c6642 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -542,7 +542,7 @@ union dpia_debug_options {
 		uint32_t force_non_lttpr:1; /* bit 1 */
 		uint32_t extend_aux_rd_interval:1; /* bit 2 */
 		uint32_t disable_mst_dsc_work_around:1; /* bit 3 */
-		uint32_t disable_force_tbt3_work_around:1; /* bit 4 */
+		uint32_t enable_force_tbt3_work_around:1; /* bit 4 */
 		uint32_t reserved:27;
 	} bits;
 	uint32_t raw;
-- 
2.25.1

