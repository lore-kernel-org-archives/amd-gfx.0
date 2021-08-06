Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB64C432BE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523F861181
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 523F861181
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2766A897F9;
	Fri,  6 Aug 2021 16:36:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761146EC2E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyTT7SQJLhNO77QV2C0ZfGH3sKRg3AckvXo4yeO2syusm4nPhUQRQAY8e0w14uwLF7VI5HA5WtPFdYWDFGkSfpXV01Ut4EwxPYCD5UdMBVBXZElL3GzytdlkjzglNbXJMIFEj4WDUrLlgtqVM6gLHsuh4+Uj6vrrOiacjVYlmIx2tEaat7iZmybTGjGu+uqtvconHFew2b48m5LbJer0gNEE47wr6qTfpmBww/7wbTrcQ2XipbzT+kasAGWUxUWC368iqwvStq3q9bPv+BaVAWyN8Kql2l5KyllZdZSHWG19rcdR2Molu8V1iyLyufzJ8ddqMD7w3MpGfNkfeYwjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NYDf+TRZUM6Ocm+VrpO3E221OxHnZZa8Ruwn9uWUKk=;
 b=LGqWrJ9LAlUUI9bdcZwa3gVAjKZIIGqX1alouTn0PPukbVFHqm/5ly6XsEPUzbdbGHUNkxLnCPp2zx9x8Gfpf2Qp1rdhUTa2maDH0WEBfiwIKEgJMNFGAjLDF1GC9ubmA2gxC5S3GHhOMyzuGNeBNxk+/W4GXyP0/GMXiE/a0R1kXPAJAbum2xyvEFqaGJYwefbo4qjQdK7iNvV2RsN3IqAQeTyghUWvyg+tRLUxV8Lg0d0B5BuY+wJnMzJN+MirM4FkcoJF8vzz6wtCtEkEOPMos/XjkCGGGytloAEuhJuzykIvmVSveGvEF3VvDNDUYJSBt900ma8lpqUSFRfv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NYDf+TRZUM6Ocm+VrpO3E221OxHnZZa8Ruwn9uWUKk=;
 b=gUk71NbqglyILtQ2n48hc0oXz6CW/eY0VeMNgURz/prnETw7r52/dfOG1+ItYK/9CaAigOQl9yyhsWDxoDVwL5LwOwumXaKc8aIsTrEliBhOAPtSjO8O4jb2mmAQQdzRZN32si+plWCjLhCnN83I2z4jES2IOa1Y3IU4jVMdF3A=
Received: from MW4PR04CA0314.namprd04.prod.outlook.com (2603:10b6:303:82::19)
 by DM5PR12MB1164.namprd12.prod.outlook.com (2603:10b6:3:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 16:35:57 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::a) by MW4PR04CA0314.outlook.office365.com
 (2603:10b6:303:82::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:54 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:51 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Wyatt Wood <Wyatt.Wood@amd.com>
Subject: [PATCH 10/13] drm/amd/display: 3.2.148
Date: Fri, 6 Aug 2021 12:34:46 -0400
Message-ID: <20210806163449.349757-11-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da403d3d-b5e0-40ca-2e3a-08d958f8445a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1164:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1164E3DEA356C9624AF7D8FCEBF39@DM5PR12MB1164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKYq+rOjirYlQB69BlUGRr+yhE6T7TYWc0+DCReRhb/gcXx9albSP+4Y0CeHrrUdyvd5mmoLYrWWO06ENaMFlCmrksajVJY0JVh322L1SwlsiEfovwVtfs0Xvd8yqvdHYGU2VI8QlOwjg2AqtutxMWRZm0DcC8J7WM+QcjUNeX9BzcZF9zVvhUFRMaR78g7Nd6dY9I2WGp3VomlcNKkHlKum5vLuNXd7/ZgR17CCS1a3yjm9TTF6+X17o6M2UZ5zKnJ6xrHN0KJGKxyM7S1PQGtri88oBJIBQgniJ7PGMI9P1jmfwQBqBSbdJI5fRdyOzoiO0SzIdFF4MtmCrtORQsaJIvZl4zT/Kz3MaUD3cI39PEduEiwgmbHUuJ3pwm2Xp5OM6cPIqHk61ZiU6M8Q9utxXbeEpnQoNRVhz90flSoVp6rlJtG4c+oolrp+TsvxE/uK9WqMWDOvDJpjUh6n41KUG1rEuMfn63PC+8zArzHb9ejsR8QLBxw/N3qiLLcwq1hzMB+S1fdbXyuJ98pQtrKM0h9wejkinnTjz5jmEkcI+eG2QCXuFflM3GgICuL/r3RFnlwdBzqsubbmEWm1dxaujJmQU4mJ416cGlXfgy5ecoFEwnbGFKjGX1eClrDypJdvTStMYMhuOlsY4faroGFl2KKAW7noPKXlvxh62enANEWJEa37oop18WFzR/joTtQ+daEuQ9x3GjZSfiWvyDJIdZk0emMjL9fL3Sx2VpY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(426003)(4744005)(83380400001)(478600001)(356005)(54906003)(2616005)(1076003)(86362001)(336012)(36756003)(26005)(82310400003)(6916009)(82740400003)(316002)(6666004)(36860700001)(5660300002)(8676002)(81166007)(2906002)(8936002)(4326008)(70206006)(186003)(7696005)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:56.9951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da403d3d-b5e0-40ca-2e3a-08d958f8445a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
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

This version brings along following fixes:
- Fix memory allocation in dm IRQ context to use GFP_ATOMIC
- Increase timeout threshold for DMCUB reset
- Clear GPINT after DMCUB has reset
- Add AUX I2C tracing
- Fix code commenting style
- Some refactoring
- Remove invalid assert for ODM + MPC case

Reviewed-by: Wyatt Wood <Wyatt.Wood@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 62c222d0402f..03b81e5c5d67 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.147"
+#define DC_VER "3.2.148"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

