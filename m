Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA5AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD60710EB0E;
	Fri, 14 Jan 2022 01:38:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC0510EB0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtkrEz2njkca9dGrHsT/OHsECoIqTsi1mp9amddWRZ9Ep9bi7hmklhE7wUw8ENY6WOPbd+O7WILAKKy/IrUBh27o6QWrl6yDUNsT+LrHrZAe5jUVYCTeJH0UKCYgBUz+OFqnjlzNO80iAi/66/bTeC2NNdBtVNeA4kfoYP/qButJmZOF6uwoZe7Wi/CFD+3D2w6QKxDM7r/oSJlETIeQfkstHAyPx/EFL2HTlCJZoMaY27PAVzcLaJ8Sg4+zGxaQDt3BPGDy4xIyc8s1cOSqfcRIuIQ/+zx0RkB72SqMKPzOwtHE32olOuWClK15qAyepFPW9DPUpnZmvIGfYoDxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjifeHyG4ZwVdYDBO6HGO44BfvyIJmhFX2AiqImcLkw=;
 b=Si2cV3T4J2hyUv5+TPdo3QWjARSTDdZs1psQ/49xHCKoibDsEo36ABmr/OGD/FZ0OI6Y4p/TfpD//JdKI8fGqz5Fn/FkyXSWQXbpraSlCeIPH4hpilADvV+gEJkEdmkzYliL1heaup2iyOzmUpC2H9xlGGahzqL5USsKKF3IFM9f9xQQO4zzxOfUpYtSD98trqJpPAEosoPSV7gfovsbqDiW/D1RDfqyRlbcAF/e4Rz1Ijx4OZxYydj7S42VSetsCqUU6ykMh6zflJv99dQwTgi0eaCWnB92u8o084Q4yQo58kvz4O5wU1AdpeEaf3A+4vUDMy5DGxfF4wLsfW9Thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjifeHyG4ZwVdYDBO6HGO44BfvyIJmhFX2AiqImcLkw=;
 b=sBURP/vF4GIFgDwCUfNkdXpQ7nqxTW+qfe441JIAqctZNzEIUZz2HKGKYcp71pT6ykgkUNUvmjF+9FGkGh20lDxjb7LP6S/lXDz/mQxSgidePJZls0fYTamsQ4MqfCoA0fEFcAHdR6zKHwfi7lMt65p3aFyfF9+fKpY9AiTC0tQ=
Received: from BN0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:408:ea::32)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 01:38:22 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::86) by BN0PR04CA0087.outlook.office365.com
 (2603:10b6:408:ea::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 01:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:38:22 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:38:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 17:38:21 -0800
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:38:17 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amd/display: 3.2.169
Date: Fri, 14 Jan 2022 09:36:57 +0800
Message-ID: <20220114013657.3119627-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc2a6164-7232-4c90-5162-08d9d6fe8cfe
X-MS-TrafficTypeDiagnostic: BN9PR12MB5116:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5116B6475B7D1AEF24BBE698FC549@BN9PR12MB5116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q25SBAc7nlKMAXuO7/yhXUU7HazULLT1C6ZT5CsnLn2SZUnR9w+NcJBjvGnnVPUCeqPrUjGSb3OvnAUEsWcZIpXyA12GEqCAVSWHDOkVNr1gXlLiRGMdaEJYJgjjHy77bI2WzV7dUzsCMEzkonTfI6b6JP9YLhf/9ItGBP7JSXSwjXRYnuTHn5FzAHrtZVv73EGO31aRIe0dTPVwGRhux3YprDvFzZ7LEJwfBzuB1/1CfBM+K/+O5wk+PtierHlzMn7eTtePN6CxN6vlXoxnEAObJnTnPvXinhpjxUBUX9uIwev6vTKlGsvzj1t02nwTk/qHtXFzomaK5iJx1X09haKjrNLcfLKIaqZSlZmYbMw+OSLIBKKhfjmQa1H3RxH/SZwC6LtqmdBarzyRjL8AxxQwOAcVE9sp8M5dXo5JqRBfxWUnee+myDKpuaws/KkSDMkbhnIgcSlvao2Hqw1hiWSv2qtN3dcAihOAg3vHIYMWW8KHm7fk1WEjBxeYNTv26pkkyi/dG5BCtxGTt7F8RLcJV78EqEqU+0dBQPQV+eS9IbD/pVwQ+WbQznxFWFLYXkXrs4iGu3n8/N8PM6OR0HEEIFOB8IxLWd6Y2RaCbKADQSoWFuZ1IajP26uaA2ijTXvq6YHgH5j89v7Lhq5y1SBWaIIY3cG1xehyWPISL58itV73oOSBchzEx63gLIV0TY4e8z2wlCngM9B6BVV6B1AFeivsl1N8pHQHGEcA37gJlj9/vo4k1/C0G9DGsje5UEGZS1JttzLDetuTFiSPmqFKGzdkY7i9F2E8O2DpxAU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(47076005)(8676002)(426003)(81166007)(36756003)(70586007)(83380400001)(70206006)(6666004)(7696005)(356005)(316002)(2616005)(40460700001)(508600001)(4744005)(336012)(2906002)(82310400004)(8936002)(54906003)(86362001)(186003)(1076003)(4326008)(36860700001)(6916009)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:38:22.4681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2a6164-7232-4c90-5162-08d9d6fe8cfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
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

This version brings along following fixes:

- Organize FPU associated code to DML
- Modify SMU_TIMEOUT macro
- Organize dcn201 code
- Address DS stays disabled problem under specific scenario
- Fix black screen issue
- Update DML to rev.99
- Address problem of eDP hot-plug feature

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1c6728cf2d49..235e33f73913 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.168"
+#define DC_VER "3.2.169"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

