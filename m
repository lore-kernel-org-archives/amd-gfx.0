Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3108EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 19:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896C3112DB9;
	Thu,  2 Jun 2022 19:31:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2FE112D36
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 19:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrkjRKIUa+U0gALwpkq4Equ5V7vgA3fyvKAnP/7JgjZKywMgbdt9JRP7rJF+sL7J9fu7/yYsX7541lfqyCvkDmdjEs1POxC2+U9DNrP8JAEKungofd38QVXr6KQVBsfS79EegNWTCmj3vENnQACob2Fur38Q9y2hpk5AaLgpP3NEb8O+zG6+P/khTwfeE1DNdeaQHuUgLM8uXBP7XU3O05yIhLuN3WLeBDYN9A2E9Xa/ae69c7bqsuYPKGTNemB704keqHxLmvInYzO6YaQEVBpP0s5LfZw7kJi4apwmaSOMWkkXizoz6ct0+JR0Y5pB3xyVAip7YxHB15r75DlU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcNXhNriQ+KD7NxnIGOQLlAzb9zSJ8/V4udRQyuPIDI=;
 b=NDqcAXZf1+6H4Pm+oywxZjfWfnxtyO0yZl+2vDAYP0zu5CCHE2qSuq0kNNajEwYV6lhi05q5quTZx2g2UJVI7REUvJxANbdIsF4nFqItZ05drTgjixw3YxwxiadDARpsO4Hs+fHeNSVqUgqO0Zu1KrznV8vpAYhLh94GZeg3qSqQg84Q4UIHE/x6BUPqtjm+eazbZs+hgfq1zcIdmxMq0nlBTJedZepIf+Jfi5GGX8wuzIyZFYCBw3aPbnDC0XT6hc/a2MTbeT+zSiwaw4A4iCBpabBRyRIx1u1Yu6mEiIslJV1CtdD2gLW/H8joSlG9/ABLzCdToPEEwJx/aAspsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcNXhNriQ+KD7NxnIGOQLlAzb9zSJ8/V4udRQyuPIDI=;
 b=l1oLucAgXund3+ZyEt7MPtXbYatg6o4s12N3sqjWaA6FCbDNW4V6mlCaqLUlDaES4+bjYMVXIWnu4K7VVW6CJZgUuj6iZy3EgWtgAHyIQTCl0kUYDTSdAd1MLyEDhnhRDcXZMqahHItmQpa7XMLSDqI0HXuzyfiLJGcFw8BkzBA=
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 19:31:32 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::f7) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 2 Jun 2022 19:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 19:31:32 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 14:31:31 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amd/display: expose AMD specific DPCD for PSR-SU-RC
 support
Date: Thu, 2 Jun 2022 14:03:44 -0400
Message-ID: <20220602180347.754067-2-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220602180347.754067-1-sunpeng.li@amd.com>
References: <20220602180347.754067-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8932fb1e-f3f5-4abb-915b-08da44ce7fea
X-MS-TrafficTypeDiagnostic: MN0PR12MB6367:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6367E54A2020840CBC5183CB82DE9@MN0PR12MB6367.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEdqjrkDZwelJVmVK7EOCCXtjrJNk163NiZiz2sGTG4ahNLBL6rCJ4Wjfo1A5Jzc6i/0GllDHO9RksX89rvLY7MV6OR9Ac9EGsNHg7Ul+OstYGbbO8bEY/cpWa/ugvFOdV2MGT7VBb+HgyOJ4zxDO8R0x4d/zzoab2cWhW1yPRCwzZEu8R0T9MBngoDzFgl8HM9/e1glSUu7SE/SD6R1B+EaI27KwsYA6Tpte4PRtPcNveJlFRTUU2+UZuSSRKlHDQbDzBrtLasVX7KMYqnzPcpobt8B32YX/be0ex8OPYw8ILrxyB+PhdWPS8V2nwyvN3+fJgI0f9VEdQ6UOSwaN9Fs6No9GIPOzXigbr5cVp5dlCqa7IH+HWdUkosA/xf1focRyGRcva6kis/HjPXs8oL5+JxhSIO9ikYmnZrMQQsc/Sd9Awmpjm04x3J/KWI9sI/wh82C5ixr1Tx6nZshJdjT8iIsCPnj0j9af/kiUpY7Z4BuX9RDBD6wPKpq1FHuPXgMrXUr40VDPTU7WBytB6u8fd8wxTNbb/XdHOTwWR5GIxnCF61+XH92FPmCt5AY6X0+YuWQue5HZZO6jEGCnMB/QHOGeVsBMt5LL5G18S1ou3Z3tFhWXEPDssleOHQgw0ihboPV5+JOazasMHp8TXr+Y83Rt5BkzlhafKWUbSSFVWUWKmzuIkPv0BtqKYbvvaEyl6Mi13k5IeOp0sKFWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(2906002)(81166007)(40460700003)(26005)(5660300002)(82310400005)(6916009)(54906003)(2876002)(8936002)(36756003)(70586007)(508600001)(70206006)(86362001)(8676002)(6666004)(356005)(16526019)(186003)(1076003)(316002)(47076005)(336012)(7696005)(36860700001)(426003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 19:31:32.5283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8932fb1e-f3f5-4abb-915b-08da44ce7fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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
Cc: alexander.deucher@amd.com, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, dingchen.zhang@amd.com, roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Zhang <dingchen.zhang@amd.com>

[why & how]

Expose vendor specific DPCD registers for rate controlling the eDP sink
TCON's refresh rate during PSR active. When used in combination with
PSR-SU and Freesync, it is called PSR-SU Rate Contorol, or PSR-SU-RC for
short.

v2: Add all DPCD registers required

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 20a3d4e23f66..05096c644a60 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -41,6 +41,10 @@
 #define DP_DEVICE_ID_38EC11 0x38EC11
 #define DP_FORCE_PSRSU_CAPABILITY 0x40F
 
+#define DP_SINK_PSR_ACTIVE_VTOTAL		0x373
+#define DP_SINK_PSR_ACTIVE_VTOTAL_CONTROL_MODE	0x375
+#define DP_SOURCE_PSR_ACTIVE_VTOTAL		0x376
+
 enum ddc_result {
 	DDC_RESULT_UNKNOWN = 0,
 	DDC_RESULT_SUCESSFULL,
-- 
2.36.1

