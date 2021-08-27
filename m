Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FD9C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65F660EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E65F660EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD7B6E9D4;
	Fri, 27 Aug 2021 20:45:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5691C6E9D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvQPmTrcazITnfuV5n2D9OcPutim6e8nGF2Kfy3k1or50G1gdIvuF2GXgTeM+031JA3W3V/qqZHVAW628knupCWBH7nguODYhgCLpLkNXOXv5u0HvEWNAwtIIT4uXB8NdBKtSczrhbFxBXi+0qixXhmDTOWrAnTT+/G+RJvNGLV0dT+xeMd1xcBrKikTwydc60Mqf3IMmn6r8u1pqur6EvL6xrjSfH7k+UZbAw+c8KMJKOGIUjtfhuINR/52TR4uWkFRuxUHHR3fc5o2hj35fPJOxY0cf7qEMWgHb4YwrwTIa1aMkkd5AQPviKN8GjiuRGohhkotFNkFj0gzrht5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgapLI/LKbGyXfkf1iRDX/OOGsL424c+t0Guvxd/I+Y=;
 b=g/HYuzHM03m+17RBg8MocBcr01NGNp+aGHrg87miiiEdxa8uQ5+M4gjAAS3WfJRP0NDHV+yBEy2LkKyC4fZVwmwDnncA8jvm7h9jLTZejk2F1gjojLbcfONhcMskdn/QyKPedwsoGu68oinq/RxIpn8lo26QUFqUGst4GCkHSRFKwpRf04/bOgcj6+/uRWk2FTr1/dOHJN4dZsgz6hONLf2uosRPxDuc8H8Vjh+21zcm+beCVhUpNyZcNks5yX6oFJS+k9+9pTRAUETCoEqkjrWg420GY+flbyOW6qSH2ohSVTdQLUCTrqc5yK39kBKo08hQTlhbfMzgtLxxui0YKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgapLI/LKbGyXfkf1iRDX/OOGsL424c+t0Guvxd/I+Y=;
 b=un56WG48308rjIhmvk/O8GDxBSBXklhANc43G8mEoLkXaf3fyKBj6ZUzd4WWq3zRN2Y1CyhHDp2SVStKJ+1myuShVEZ7ssLtdgnOTTriAj+YeSZvacCErMB5bnjf1TwV3Pl3ZO6WMPc6XiUHJgsDfFTvKRMaAydUDmbOCD3ihw8=
Received: from MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35)
 by CY4PR12MB1797.namprd12.prod.outlook.com (2603:10b6:903:124::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 20:29:41 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::c6) by MW4PR03CA0180.outlook.office365.com
 (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.22 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:40 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:38 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH 14/19] drm/amd/display: [FW Promotion] Release 0.0.81
Date: Fri, 27 Aug 2021 16:29:05 -0400
Message-ID: <20210827202910.20864-15-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 470a9356-4c09-4c81-bc3e-08d9699965bf
X-MS-TrafficTypeDiagnostic: CY4PR12MB1797:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17975509BCE7ED43E996627DE4C89@CY4PR12MB1797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XO2CNaxT5zNITk0d0xhnQL+ZoV1HwwWticTriZyRoEfKzwFvOCtceHXuga/9jMKFijcR+oYQbluDWRUUyh75CuX0P76o8f1rPI6z7qdP33OoCJ0KB1iypXm1KZVQzXaS9tURKaGvV56YG3D9sJuVmqpcu0fF/CeVUZno5ol9g0ltju1th4oFSiIchsEH/RhwZm69psSpkB+P+04D7U3NiokhZGm3joHs+ThD7X8q0fiAh62Kh4hhM5SW/IimLn17agUjIm8VLnXcuh0iIT0th1DnM2KJl1kbT4qoNK/fwdhLSSZyPgKQkBnFhJSSRrrzY4jadX7e7Ki/BK8/A59seXlKGUUwTRj/YVP40pP+q+a7CTDBDtif/y2zClPG9QP7O6dq6rMGtEXJPFk6/f4DJRpuJs1zlrKklcNI1xO+d3ZEx88a+VIilx6SFJRPVzhOAwoBQ4E4u5uVI2JUvrUWJupVF03TFhp6AoBIShAk7+ACInNFnvc51fqosyeduil4OUJZShmlZYEXtRzGIXcS8k/ASGyQeYzI9wlwYK7Z9stjVEa3YehHD05e6BYa7dV1xQzMTM5UDU9gkxr5f2SKiIJcbDd7dKTApbHxcCNVJqgWwvi8kelkBcgrGXu+bO4UBL167lzayIAVrW54HklZYeDBELZ9hRN1e2tGTVB79AQViJQ0RrbCiG7tj/l7cQodxYqWYmOZtKpthCS4mC6zZIS6oF3mYe1+6x0fvObpL0E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(81166007)(426003)(6666004)(36860700001)(2906002)(70206006)(316002)(8936002)(336012)(478600001)(8676002)(47076005)(82310400003)(54906003)(44832011)(36756003)(356005)(83380400001)(4326008)(70586007)(86362001)(186003)(16526019)(1076003)(2616005)(82740400003)(6916009)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:40.6023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470a9356-4c09-4c81-bc3e-08d9699965bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1797
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

From: Anthony Koo <Anthony.Koo@amd.com>

- Fix PSR1 residency to be captured per panel
- Merge VBIOS DP AUX change
- Pass panel instance in dirty rect message
- Z10 bug fixes
- add detection required bit to boot status
- Match abm_state to interrupt event specified otg_inst

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8b0b4d86986c..df469a73a1d5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x2d2f6f51e
+#define DMUB_FW_VERSION_GIT_HASH 0x8ebc06e16
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 75
+#define DMUB_FW_VERSION_REVISION 81
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

