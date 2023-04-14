Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C574AC77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1681C10EDCB;
	Fri, 14 Apr 2023 15:54:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8100410EDC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csSLSQuUa0iPhTAdyhlVcopfgU+hi0b0wsULrVXH/v/KwX/olr6PUYYO6RuekVVr55uELl2HLRMnK3VVpa09K/2zfmiR9hBrX8H74wt7M+A980cvoZyaw++VP82L3Sb36/LKmnJK9tUrsyz/5bE/VQuiiJ1dBr564xq0gkrGT2yuASHMBD2Q50WunusLhAzYXs+MANmdW0KWtatnaRZB6i8xLuqhEcCzn6nOZNvl1lOkc/5NS28HbjHCK7/dMY3GFVUui7hJ96C8GFDJ2pt/4Im5dRyrMffUkhi69s1Dt6Ol6CGcN+g5uAhvAgGP5qaeO8A5Oe3KWXE0F+NA9J8/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsCFTu/VqPGMznf91hYFChMN/SVH6s0ApPNB/FdO78A=;
 b=O+I+jiNCRqIQp1Ef/mzJw1Cprl5KJujNO0mNnE4qTR56VvgktJRGfwHYkz/79Ffsi525tePphziqHFifD/iLh+0DWELUH0WS2jiWVqYY9MvGhopmf8W1iQws6TprafBCnFw3mxSIUr5lFQzahcNm14PlNxa0AEP0WjzWsogwEbzFG2ou4o3+DpZB4A/Eu4YW5ntDg8VLVb2bOkX95inA1OfL3f52Eo8kyMxjfpT1I6RR4fonrYc2D/mm9F0V0v4eXPKyOtVYCDciznoe1yHuHURbV9POfocfNcjkhkKDIPKb7+zqnMO0aO658eFb6GIkplrhiNiMhcovsMMdLHRNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsCFTu/VqPGMznf91hYFChMN/SVH6s0ApPNB/FdO78A=;
 b=KxtZm1yrBkIPTl+CDKy6haJCEJTXBaWk3izdT7iBrquRUQxX347zXjPMyszW0W/rz08EyGpvc03UqANko7f5swK83dbwJKLuY5n3LtI5RZgX3MsmGueFs2UXmB5oWMjtgEVXYWDF92E5mMrQZKbkQFKWLsHWN/IDajUrXJ+Bqkw=
Received: from DS7PR05CA0013.namprd05.prod.outlook.com (2603:10b6:5:3b9::18)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Fri, 14 Apr
 2023 15:54:08 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::a5) by DS7PR05CA0013.outlook.office365.com
 (2603:10b6:5:3b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.7 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:08 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:06 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/66] drm/amd/display: allow edp updates for virtual signal
Date: Fri, 14 Apr 2023 11:52:38 -0400
Message-ID: <20230414155330.5215-15-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: a8049f28-d7c7-40fe-d975-08db3d007b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oqCJG309Br7fHBl78G6LFlwQwUpvuLO9NToB6Z9h3wssvLz+6OjIvTcDExsLTI+EahqnvKgJiCUIDxqGFCPqify2jB+1szI5o/DzbgnhT4Vb6B/37V7J98eebhj724an7t3DV/WVX+LhZijyJrU8LIWU6uIyRFOs1ZGw2PnVj1CWD1jUkmKE+iK8S+Xo0dYujlmy0CO3K3vf4ZOGOfDrGc4IcXdE1sRQYUXBU8+237lP/YFBQVQ+c8NY6utZGSFHKGwmr6KTv6hFg3o1rCJqMq3g5gpSRy1uuJj/Ny7veO9nJPMRK0mkmq1SdPvk/2M335Tl4+YMPltavzleNPc+/x2SdZNwKp/L+VRBRyedoLwgpLFY7rabaCfG3fth7j09p9QQT+Vx/M/RZU6lSMwwi3pF/xpZbjfuI4fc0DbMBcFht5JnDoROYwh1zngQKMyn/UV7wQoni2joi4oXnesiecvN52eEIVvE9ClIVQL6gPL6JjbFt87aaMmNWYc524d3ww44LHGrRRSaUevF3i2oYqFcDuqdZ432MbjspqzJQGnZcUJjurMEC5jUpRFI/zTggrGOYjDwoQFlRuIbmOWQfZjoHAed4dk+WVoju9U+4X6Wy1hvUAwfdmduHJVQbFG8Sb+4yl9+nNEBpbTxGDCIOJ6fUmH6WqHZWEfKybdaiWFhZ+Ihh9D6EoyUYb8tngoByVgur5ULLxJ5r5eN4rLN+xRdIvkaZ18ehl3lhHLbqc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(16526019)(5660300002)(26005)(186003)(54906003)(1076003)(316002)(2906002)(82310400005)(70206006)(70586007)(6666004)(4326008)(6916009)(8676002)(40460700003)(8936002)(41300700001)(81166007)(47076005)(36756003)(83380400001)(336012)(426003)(2616005)(36860700001)(86362001)(356005)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:08.5512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8049f28-d7c7-40fe-d975-08db3d007b9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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
Cc: Chao-kai Wang <Stylon.Wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Wenchieh Chien <wenchieh.chien@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why]
When IGT's kms_hdmi_inject forces EDID for HDMI audio, dc rejects the
request because virtual signal is not in dc_is_audio_capable_signal
function.

[How]
Includes SIGNAL_TYPE_VIRTUAL as audio capable.

Reviewed-by: Chao-kai Wang <Stylon.Wang@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenchieh Chien <wenchieh.chien@amd.com>
---
 drivers/gpu/drm/amd/display/include/signal_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
index beed70179bb5..23a308c3eccb 100644
--- a/drivers/gpu/drm/amd/display/include/signal_types.h
+++ b/drivers/gpu/drm/amd/display/include/signal_types.h
@@ -104,6 +104,7 @@ static inline bool dc_is_audio_capable_signal(enum signal_type signal)
 {
 	return (signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
+		signal == SIGNAL_TYPE_VIRTUAL ||
 		dc_is_hdmi_signal(signal));
 }
 
-- 
2.34.1

