Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B0CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 06:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED9C10E736;
	Tue,  8 Mar 2022 06:50:22 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2555210E736
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 06:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq2fQ3dUl8/gxenLl0g9J4s27gpUoEJ/yDmc8NE63KjKCLlQEAqwJoQ+Xl7Cg725iyNdUCC0/WeKaq6Riwk2nCfS2G6vLMUMjLe3Odb5cL4AI0R+Rb6RQLdUu8Ps2EMLEmq82yAIN1cZiJrJJT8z4XQxK512QN5wKSyKhA3aDt0U/+C0xOy9XiLO93ZWRG5kUqJzXsIygLbY2LXSKSOaodB29Em5aKO/x7Y3I9BCi8N9Zv9Fmh5uUAs+q9J5W7znlT5rbAQst36ZXpiyJv99+D+IxX1D6iEUSAP/10o01zTpb3aN1kmLzCRJfT6wa9bjHk8LGlwzOgXDZjvZbCBJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zNuA8DS5xGcMH2Npy2D1gSego0TtKRExYJSw6+G2jA=;
 b=RXEgySdhx4AtEz/RW6MfQdx167uc8EqAsjoFyPMk+4qzUcktgvLf0WQmaEyg6OPvkFuGEAAqzBaai9lL38Dih3UHHdcQquFynDYA+l3H2EkK0onlM+oDfw/cyStmkCoJdjjrn5MNLutsR6IvvOLXz7H9mg+tni5DaWHzPAYnFUnqMFNxKeS+cx167CYFRKZHKBAQE0NFerpsSRr+FJKgZxfCHUNdtLNQ9ma4HuwQJI/0H7lnGU3YyN/JKuE+JXYyiZiTKxv4L4gEHkZu1BUoSIlEYe1tqG2KOlN87wJlD1PomX2PpWksh45G3pU0ICQMEwcNa35d8kS1bkwezQnUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zNuA8DS5xGcMH2Npy2D1gSego0TtKRExYJSw6+G2jA=;
 b=uA/K1tGOlRe6mwxWgnZOP6zlN6SUFS3J+JG/ozDhpHq5V1bAG/IxaCIlrf6aU+2LBf5IaGobWFgACXejYn/QhR1mFU9mjMkCN6j+/e7EcIjPmJEsWiemao62GfdmttSQERLXYCI/1QSaq9tHWr0s+AT7JUjJskOnunPoiAuJRmo=
Received: from DM3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:0:50::22) by
 CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Tue, 8 Mar 2022 06:50:17 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::b) by DM3PR03CA0012.outlook.office365.com
 (2603:10b6:0:50::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 06:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 06:50:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 00:50:16 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 8 Mar 2022 00:50:14 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix dp kvm can't light up
Date: Tue, 8 Mar 2022 14:50:06 +0800
Message-ID: <20220308065006.164101-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a57476-b4a9-4480-e669-08da00cfe79c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4310:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB43101F885B539FBD2DAD86D495099@CH2PR12MB4310.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTZS/7JC0nOubfhQfpOeLEGubNLod4G42OQwKSzTZKosI+nj2KbGFzMy3pKhiMa4ABp4+y9DQDp4kKEb9eNTgBwc56AFiIN4sF3yvsYpuQcqpVxUHiTk2mWj18rGSvkdYGLQX4zKXST4JaxGEX4Hu5RdB4+NONtPiUqBZ95INHxsof02YbFqvyyo3EdkenFruS2pJBt5ty7oJ7v0lg8tkZmwxJR6HDMWy9FhtZR8LXSjP+HIgymvCx0xOtng0uhyQJCXXJbdHpiTUCb9cvcHd8QliaTiD5ZAXQjgO+XU+KpvsiueOwX72+mUQiO+bc0XrYmBHMMSTTmWRQSfm2gLNMI/sMgY+XKJII/9M/vr7nckSy/qho01C+en0IIuDJouTuWbydzrW/zL+cGaGbCWvBYPqJAsRI/lM5bIQScQesHZxPB5aG2WH52KK6BrjZUyIBX/DU0EeQgFk/LOCncYykBGJCrShRPXBDFgo5SmAMVHvuFOucZUZFgKlbIWdM2bEqjXILY6iLAY1PU/ciPG9ssUqKzHQutY4u2Qddxzto41fk1OI4KGCs39EVtaOvtW69ZfHcAk+up6ePAhezYkX4rWDQijTDq0pVLZznHegx3M5hZ/kNIoGa1UVqWTR2WPpfvMgAv0CTj/LdCSQRAEojUj0ljJuZ9LutQke8dbxe/bhwcH89sZ+FZJRkya+lxTgRxuU73j8cNN5pmn/hsWxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(47076005)(40460700003)(316002)(54906003)(36756003)(6916009)(7696005)(508600001)(2616005)(186003)(6666004)(5660300002)(86362001)(426003)(336012)(83380400001)(82310400004)(70206006)(26005)(70586007)(1076003)(8676002)(4326008)(44832011)(36860700001)(81166007)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 06:50:16.9302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a57476-b4a9-4480-e669-08da00cfe79c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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
Cc: Wang Yu <yu.wang4@amd.com>, Zhuo Qingqing <qingqing.zhuo@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Liu Wenjing <wenjing.liu@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
The DP KVM failed to light up, since the lttpr_mode is not reset to
default value when failed to read LTTPR capabilities, and the
variable max_link_rate retains a initial value zero, this cause variable
link_rate be assigned to an error value zero, consquently pixel_clock
get wrong value zero, and kvm can't light up.

[how]
Reset lttpr_mode to default value when failed to read LTTPR
capabilities, so that the link_rate fallbacks to the minimum rate that
supported by link encoder and sink.

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5688b15ca9e6..f9ae06103241 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5101,6 +5101,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 				sizeof(lttpr_dpcd_data));
 		if (status != DC_OK) {
 			DC_LOG_DP2("%s: Read LTTPR caps data failed.\n", __func__);
+			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 			return false;
 		}
 
-- 
2.25.1

