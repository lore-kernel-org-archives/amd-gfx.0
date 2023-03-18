Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A77C61DA4
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F6610E45B;
	Sat, 18 Mar 2023 07:58:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16ED10E456
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1HfrDQnqGHwJyssDDTD8cM0qSji/FkIBN82jpSo7O7GJ5Nayd5ifHgilvKqA3ol43GgnkU2FuHPTlbIu6PCLudnGEbiYYypG07Xmb8zLN58MzrJuQrt0t4jzREc5mlCMbdToaDO9UiayoeBY49M7HHkf6tGE86bS4fD0F5lLEfCfwkepW0mUgfWuDwpT/6KnJVlCutSzQWK+EwEYiaqyuAHe1zd7nOxouBvCwZtLMYq1Z5srxsTPohH6JzP9b0HM585m4NcklqX2l0A0UEob8TqFP+i+DTcXfJojCPFD7hO/CXWGkR5mUmg1zWNqbw2af1LHIK6jpT8XqLxp9x/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQgP/uUotadGY0J/3B1ZCsN5yu3zJ3MfIoiQG6pqvmE=;
 b=Vb2llnL5pnu9x2/gLBb6Mzde0HE5Y7+HD8iLBg31yWfvlZkEMYYuTC99A/PdmBSL7WRk8p9HQ2YLZ3JcwsUnguJ414LnmyICia1n9g2Ejgpg73lVWave+ijss1OkytAucQBW1HOJiAnIpxmTyJ4spwTShI9qhuhRyYoE8rzVWLhw2RFatWS1yJg0scgEpo+I6XAJxnLer6m5v8uujJBpjNSSl69pFufQnOjUY1SZM/1kJfCv08mOGPsWST4Hqf7bdPGMiD5KbXTrrRl2b/RZBKqYJw1nCV4pi41dtadrzFycaen4f8rbs+UeaNoanovK/spwr/Z8vQ2tdqH/zdQMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQgP/uUotadGY0J/3B1ZCsN5yu3zJ3MfIoiQG6pqvmE=;
 b=ckWCfYXTc9fKOMzdiUvIN2rtcqzXx9SpY4r6C2L9ljJNkYJQwljd8WvNXWP7jNHeosLjMzHyTr3Bg7CHjWnpyFucLuehaVTENbRsfj8PJXBm9mL4OOfNzFG2LJ8dtbqK749pc+hwm7k4YEWi3SwU9In7twHmiFxu6XN2Sm2CSSE=
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Sat, 18 Mar
 2023 07:58:02 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::54) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Sat, 18 Mar 2023 07:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:58:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:57 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/19] drm/amd/display: 3.2.228
Date: Sat, 18 Mar 2023 03:56:14 -0400
Message-ID: <20230318075615.2630-19-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: af2aaf5e-82a0-4df8-6ab7-08db27867f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qx7wV7u8Lc1zJp/80KqOr1+BwzqMl/+ADQYt2nFBGZHHeAEO5ZUi91PevTPDnQBknn3zAU3FUwa+EmsybdYFh/+zZG20+vb2Jj3jgXoS/hRuX3x6K7BBMUBjvlw+fq0xndPoJCUEhFO+fUXEWMsZDF3BduGnPUGa8jZM6gkpGZjm6KhVqwkL85S7L3AtIzJbRXpIygNNz0QlyMNLlMRdszozGaAjVgAUEJftKgQ7wsFjBDNTihoPGts8kzGE18kt9U/wgexMj+E0h3DBoUcghXfHdtBWWFQUBz7Su5Rw3qTMNsmW/noW25aujMppoX2v+AXYE4CBSR6+H7AJDWmhMJvSUeJ6sjFdQr6Ckr/H6zxBtuE7Goh5R7VGEJjSXc9ucwPiS0IfxuH3zv8Uoyyo3EGIXcVU4vFAmFCu0LSHcCcqmqu0Dji4bGVmEIP3xTZ5AVC+NiIc7vHfV9Hscvh+VVEhA7t1vFR6NqjyscFVTbev6lGXKzPgBM3NGGNeOtPWn6i5lXYH7+Q0C6uSCwLzHRCkZKMMOFsstXS52rSoe9ATMkG8MdSiTzTYV4ibSMTFq14dLz853a9xFjhe+lbTAaWSyHKbQsEE83LQEWMQHimPu9MrdPLewcnGXCZ/hI+nCoXPq5gAMmpsgoxI3u35AXV/O7zqmA/eJdgHdwsMyOdOdeR8e7CVnjke8MRQgEs+kdbuCNNTotjxr+90vh1Gq7sboanQUAJ7+IdvsYRzKs4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(46966006)(36840700001)(40470700004)(356005)(36756003)(82740400003)(36860700001)(81166007)(86362001)(5660300002)(44832011)(41300700001)(8936002)(2906002)(4744005)(16526019)(82310400005)(336012)(40480700001)(2616005)(1076003)(83380400001)(426003)(47076005)(4326008)(54906003)(26005)(316002)(186003)(8676002)(70586007)(6916009)(6666004)(478600001)(70206006)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:58:02.0443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af2aaf5e-82a0-4df8-6ab7-08db27867f78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC version brings along:
- Power down eDP if eDP not present
- Set MPC_SPLIT_DYNAMIC for DCN10 and DCN301
- Initialize link_srv in virtual env
- Code cleanup and alignment

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1e6fa2d387f7..475128db02bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.227"
+#define DC_VER "3.2.228"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

