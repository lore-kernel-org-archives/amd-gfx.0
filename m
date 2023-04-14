Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C4C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF6C10EDE1;
	Fri, 14 Apr 2023 15:55:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83F910EDD8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is0RZUyXV8t5RFBTEydyiil0+JxTd/RseEjQPweNFQcp5BiADr2x4fQ/pTTs6um5ErSIq6T30/ESozM7kQTxvc8M+KCuJN7s8RM2F0QU8Xh/VBMeuoZfS1ReigiNvioPdlDF4xYu/QkDDDhsQ05N98yzD0XZZTpd/dZHlkqtrBHoLimemsrF1dddpTGnIbqZguvA56mkjVXXLFFeBpC3ahsrSeYnHSb1PiO0GD3bN+6P4GOXIR9tOQoBQ4W06IUp8qOS900WvggFEY+SuiyzGIRnjUfIM6EiXTuYA0MrkkIjrHyah1ScrD92qwOZymKJIEg++GQ+nHE1BaXkBUqSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ77tdnDeOJ2feDHH9lDbkP1X69QQM3zVkuYxwnhZZM=;
 b=eUcQ3RezcAVyfxuR/ppf2ekASL3iyYPse7bjtSfXtgTZEA61Kh7QOJM7LzP7kXdzfAOcKt2aMaduKF03nA9jfngRnCz3/Gcnrks+VwCZ1uloFZTDu5xEPfTKUDdwLVFeGa/05EynLQSOKeRmAWUhtDeM5Q8NTJFqwS522GO97sYSjXQ5GWy6L7rRVoKG6lnl7Sx4iue/Jy/0CAHtBqYyM4C4PaoN3MWvu5YaSSMDVGRlCB0EqLFaEuWCWITi6BuN4sA+qX96rihCV/wieZLOKWJev8znj+xoC/vIFT7RXR75eTW7Os5Mk+BaskV3yeLf+5ta6oQ8HePjfFyHKWqRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ77tdnDeOJ2feDHH9lDbkP1X69QQM3zVkuYxwnhZZM=;
 b=fRKMtGFtV5FiuCI9z5qrWkIIuu3/bZid175rX5rZFScE2olu2+TYRGb0uDNT5WdTC0qDCzOqoVuxHNb4ZTV0EnxU1ELNCl0pZlKNDNoBp07cLep6+U77sENYAuO722XITuCpoijqbmsKRHjSmZ2sdiujcNFozTgvewbQ72lnkMA=
Received: from BN9PR03CA0223.namprd03.prod.outlook.com (2603:10b6:408:f8::18)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 14 Apr
 2023 15:54:57 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::6e) by BN9PR03CA0223.outlook.office365.com
 (2603:10b6:408:f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:54:57 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:55 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 46/66] drm/amd/display: Reset OUTBOX0 r/w pointer on DMUB reset
Date: Fri, 14 Apr 2023 11:53:10 -0400
Message-ID: <20230414155330.5215-47-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6a054e-917d-45ff-42eb-08db3d0098ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mFnIBnHWjGPu2a+9Y1a137uZA+PtVQON3Mb6wBJkC7Eir6Ljh4yTEOtFHadsktmhcdHNiRurtMue0FBH9IP2j1jSptaDeTKcuNztgoJrB2U4oSz5NE9GJCuCiSsgDasQdtCdxMOGSVQ7iBdHfXylaH9IMsniAAlJVVzuYfiHhllmJlhREEphmYaRBOkcrlSC/MmKhsY7Y0Yx1OvvlBhNkU0lzCyws7aFIz0/IvMbfGkU9qJVFduZ2nPtCki4ZoYrLu44p1hXYWdugJ1eb9qhzTGOIn0nnkRidzqVsuWxtRiouIi7HjVXrT3p+kjW2eWGsSNwkoQmM0M0yDqcyAHaFzLMi7R562Ho1IVytkFQdDSZXljqhmbgdxK3LIUqxlulH4Ryhu5PkMkwCLUFD72EBn+JASKNuVRt1Uu8nDY2UuBj9N/Yqq6an5KKDOvs++OfuEnW/jpUabBdhwsi90Qt6PUcm189ejwRoHsKBXkRKdPNwSBAcm72X2vITgQPTq/2MTpX2ViMS8PGI2AzMQAwZScyGC18nPOwyKRSPJ48A4fhbNBw1n7nIu0TKTrVPCUwShYcPd9l1CRUB9C/p49dr2w2Cwjo1ybdcoqhhjO4jo2QcwqM6ljKVHv20sB5S+ZyVi3LPwGaPCJ8I/UClKMx22lN82xBzjec5p6bTJvojaDCVPcAJ20CCmkOjKOl25eZEpGj3ED0S3ABOWcAjDIbV9eZZ5Uwd9o1xm9HqkWxJU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(86362001)(36756003)(316002)(54906003)(41300700001)(70206006)(6916009)(478600001)(8676002)(70586007)(4326008)(4744005)(40480700001)(82310400005)(8936002)(36860700001)(5660300002)(2906002)(82740400003)(16526019)(186003)(356005)(83380400001)(1076003)(26005)(6666004)(336012)(2616005)(426003)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:57.3439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6a054e-917d-45ff-42eb-08db3d0098ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Cruise Hung <Cruise.Hung@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <Cruise.Hung@amd.com>

[Why & How]
We missed resetting OUTBOX0 mailbox r/w pointer on DMUB reset.
Fix it.

Fixes: 6ecf9773a503 ("drm/amd/display: Fix DMUB outbox trace in S4")
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 568a2702d5f7..b45ac31ba555 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -126,6 +126,8 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
 
 	/* Clear the GPINT command manually so we don't reset again. */
-- 
2.34.1

