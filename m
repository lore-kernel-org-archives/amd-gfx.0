Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C046C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 04:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42A010E613;
	Fri,  2 Jun 2023 04:15:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 910A210E613
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 04:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P202E+Qy82iR6wBRwoFezhf3pkwCIqU0XIa/9sIxZHAmoYx8PSakzJv6epItsw+bkL+EePL9fkDOButlHZ/BAX5ejCmUE0kW/LFVZvebQ2hPchQDueRFrLrqOMerb4nU255GtRFnDaLik1CBKHPnGwT8t9kesLkYI/2BVd1jEYh6NXl3smafLl8mZ02Cp2+4z1CEkhH+pmdBM3HZm1nt1L1/Sz09VhTmxF6Lli9ZlTNwiulMr3SazRkLeuJ4AGugdo0O7ZAtDC8VBQCv2euQ4rfxDyThKApXmy+DY5DOw+sY7Jkolx/3DxWm1gtr5YDm7OwNU92DB2hsC7F9JCX9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqki6RY7s/FXDkWn9gshUraXnqHoWdO15jGs58eDuvw=;
 b=e88JP5SjfJC9UW1EqifWV7xbrSaDXwpnVm6Fezz7y0F/pzJnSEqExTPDMy+v0bgz6G8CxCnfbtDscStf0sAg0alTB/glOQd1NvjDF09GBzcfrLNGbbWxqOdE7nQKroueC/I/87OOTB2HFsvDSxADqmVtoe3hEvNJBgaoIDowyIefyn3rr4EuEXUsd0TzcyeDMkl+rEJKc8CTB4PDszJIoDsAJb7swF1FPNgBbrJe5x3OrdVErtUbnXCCnh/bFlPj1oa5SpCSTYOlYEEk5MLZof6NqPCo/jOow3MvLk5qjwB3Ug914PCFJXli+MzwWJmkKHAJAnFujpElKNMXtxwjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sqki6RY7s/FXDkWn9gshUraXnqHoWdO15jGs58eDuvw=;
 b=OSNuUnKjQHvtWALWJFUeSSoLYSsPBUa51afJn1lQSo673dFWR73UjZgD8rJw5rRhL+gq1fBhWuGsu3y9bq5MaTmOtm6ZgHwRh/phjLoPE515Q3VWURzcsFdynCES08MoySk3z3m3e6DJpN2ZReVrffrXJ9MqiTLyus2SnQGHKUA=
Received: from DM6PR17CA0006.namprd17.prod.outlook.com (2603:10b6:5:1b3::19)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 04:15:02 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::2e) by DM6PR17CA0006.outlook.office365.com
 (2603:10b6:5:1b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 04:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 04:15:01 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 23:14:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH v2] drm/amd/display: Avoid disabling GCC specific flag with
 clang for snprintf_count()
Date: Fri, 2 Jun 2023 09:44:44 +0530
Message-ID: <20230602041444.1432649-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bc8a20-2198-41e2-d0a2-08db631fefbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P92UZsfjhIaArhRW3Zj0qjqhslpeeCelYrDKyctLZkLTt5ohZ+C+Hr2UZhvBxl9mhzEAu8g8Zdu3Fa3mbpYv+5F9jJS7I3LFmbJPzfwGHykTvq10cknXlCCuSYgwy0ltGPa4tVbzXqE7HJ5Za67ZWXBfWaGvF/iVJCPZGaHnls7l5xCOuYS58byf3oSFneiwHXFkOV7ucnf2s31w1xIs7IOAJicyV5JMQSaI8qdyESQatgSiiR+Ua6+rH1OlTniTTMsBRV5+VdlaMhfnko8Gv++8Y6gxveo9B2jQm4BCvtOLB1DGxhCxMNbMDnPQFwk0Zg0WW8qXvblwQSCDQiHpE9txcWi99ENLljs2JPKlUlk0L2QBC/fGn7PbL8N4RhAUrZDqe0Th+ddwSDL6mr+lsAesScRPCr03fiRLF9vWZaqPuannfeRm/XfdtBFXKtvCHxSkgj/yjhZnKm94O7cPGVcwBdrldtkIMTdWe8bv5NNXb0FX49xisGOsKQASoBqfGTITJ524aJ5iBZCsTcDry/cSf92IgZ5krfBsVCtoWGNW4vKGgZquTdt33NmqgGfoa5Xo7WSgjo22tItdn+vFG20yECyxqGB6XJHDlN0Kp56VgE5FZpMz5jL23tz5SqALxJdIpmgOwUjyaLWUUX7ndj3J5B5Ea87uB1Zdouw1lKSTqU/tZvIWSvbJc/qq93vfK8OAt3iYfsmJyT72CDk+shnXrZ0grmPtUk2eqXh1iZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(16526019)(40460700003)(83380400001)(426003)(82310400005)(2616005)(36756003)(336012)(26005)(40480700001)(86362001)(1076003)(186003)(82740400003)(41300700001)(36860700001)(356005)(4326008)(316002)(6636002)(81166007)(47076005)(70206006)(8936002)(8676002)(966005)(70586007)(6666004)(110136005)(54906003)(44832011)(478600001)(5660300002)(7696005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 04:15:01.9737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc8a20-2198-41e2-d0a2-08db631fefbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These warning can cause build failure:

display/dc/dcn10/dcn10_hw_sequencer_debug.c: In function ‘snprintf_count’:
display/dc/dcn10/dcn10_hw_sequencer_debug.c:56:2: warning: function ‘snprintf_count’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

The warning being disabled by this pragma is GCC specific. Guard its use
with CONFIG_CC_IS_GCC so that it is not used with clang to clear up the
error.

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - Alternate Solution 2: for proposed
   https://patchwork.freedesktop.org/patch/540285/8, suspect that
   code is in DC, to see if it compiles even on windows also.

 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index a0f8e31d2adc..e14b6747bbcc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -45,6 +45,10 @@
 #include "dcn10_cm_common.h"
 #include "clk_mgr.h"
 
+#ifdef CONFIG_CC_IS_GCC
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
 unsigned int snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)
 {
 	int ret_vsnprintf;
-- 
2.25.1

