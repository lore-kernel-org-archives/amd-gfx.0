Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59287C433ED
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D191610CB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D191610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7276A6EC7B;
	Sat, 10 Apr 2021 02:05:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83DE36EC79
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFkc2tAHOVXgRiN855/U2P0pprL19CsVXK9Zfh/EuOPAaJg9GSyVVYZQBwok+zMFy7J5MScc4ghOLXwRTMq81qTJHOxCEIYb2YtWjlS05qc0KnexIsE9G6isVlP3XGG8e1oJeq5xEkfk4qcE77VzCXxh4NOR627bOtgC/WK2suHCHpscewFNthHEx1KErGfFC5JRzdTo421EpPcAvnq3czWa6Lkbvg4u3WDokfBPmPobxZdijS79IAlbH5vPAjZRlQ7DsMsbSpvSQLF5CXtTrXBhDjjtoaGKITnjA8FbcE3mCJroEjDIPTHPYoRJmbhJzKoAkWXw6ophCDS3B7tVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUGV5VGF6jH9HUx453Il97EOMyaORPV+SA8BGo7MiPc=;
 b=WFaokIUBANceGpiG1Nil0su7ffL9DyMinshC3aPdOFW7Q2iHpKC2uypY2S6ZTpjGC4ZPpQjzmFl5ibKNtSnS2Y3bhFFwLNr8DsvvaTNo7udHTcy7FJOrd6uWnwn66iHTmsxIsXRZn/qVXiwSiiOfoxuVZtJ6Neg3sy5rS1+xH4aINQ9e71K6K3Qmo9ukv2PF8Pbkhl8S+KvMWCtYdUOAaW/qWUbwvp0v46bCzAjj//5o32JLvKTcFaVSMXpFy4EwgNhCC5YePSrBQYADigI6+I95Ey6PPXRkjBLFnw4uvtpbPm3CvAgW7pmcPsLOxFJcjHOKNws/hzNZHElXoDKNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUGV5VGF6jH9HUx453Il97EOMyaORPV+SA8BGo7MiPc=;
 b=NaH+/2t2JXGrDGjOR2cKQyIuRtlKQkJzY+tQwKoz/DBt+4JHXHZlF2H9ef6VR64ASIuYOCiBJvcyTTq8FLXVxszy+CjcpksMufo8P8UMUkj5MRXZ4ySzH8dHy0OuvKGz91MUfEAAWs1hs1Lj3ie4gzpHoTohCzWa9/oGhf4xiws=
Received: from MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28)
 by DM6PR12MB3754.namprd12.prod.outlook.com (2603:10b6:5:1c4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Sat, 10 Apr
 2021 02:05:04 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::d4) by MW3PR06CA0023.outlook.office365.com
 (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32 via Frontend
 Transport; Sat, 10 Apr 2021 02:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:05:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:05:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:05:02 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:05:01 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: [FW Promotion] Release 0.0.61
Date: Fri, 9 Apr 2021 22:04:01 -0400
Message-ID: <20210410020401.1100228-17-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f9f461a-fe2b-4f3c-4981-08d8fbc50e54
X-MS-TrafficTypeDiagnostic: DM6PR12MB3754:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3754F597CC25297E75657CF4F5729@DM6PR12MB3754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vpnysti+EUuUhZbTNLHW0KYiQP9oSJ5nCduPusS22M9z8ovkrnnBVCtm9DDzwUWzgoEvdydflghtGFwBLrvXur8cXrnMYwFQebU7g1Bf9gSk2g+uo6VaTwbXgb0JYMzhwYxVZSVz52VqBZI0RWhCO6EugE7tgz9TnLO/GS7kYCgSIijSs5b3Ix6yivZW9jMyp96WZ6qTi2BOLGld2tIuDce4hbzIfvGybT9hxTq8zTbkBfJa/XKFzC6pL1W5umXkc/dE/Gma/C1oEPlyj/lSch8/Mh26PcIg0BS1+GDYGSxkNgIpCweMsE6IonKIWydibCa2d4MdCOPqzh0hWeTc3tqa5b2kKoRbcERD1NUPRlKtM8+U18ewQ75wTJtA+lRT2E854PiLRhjJiNOL4UhsYJYl6+ZzsyQhOkn30krcUlN+JzUqhu+noEVfg5LbdtcZa/mYRLR+Tr8hQfVYQf+1ej+uZWIdZrnb1Lhz3LGievw8NIn4x0IRd12ZywR3UaWSWVTX/cjR6S4i8ts1dVtuJclA5dY/RWN/hl6sn3wla6xZVuf2DFs6capu8R1zkdjNpI8yuF3uVwK5u82vXjq+07RJvPnhp5ss/b8JY1Z0P0YRnCvLi02GpqkYEMjwuaveVZep8cUSRmgComa28eFBOtPgaNfe6D5MW4OKX4zT/dcx9d8Yr/M2Sfu8C3mTiuak
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(426003)(82310400003)(81166007)(8936002)(82740400003)(6916009)(4326008)(316002)(478600001)(4744005)(2906002)(54906003)(336012)(8676002)(70206006)(186003)(7696005)(36860700001)(2616005)(1076003)(47076005)(83380400001)(26005)(356005)(86362001)(36756003)(5660300002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:05:03.8770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9f461a-fe2b-4f3c-4981-08d8fbc50e54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3754
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bindu Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index cec1ab91274b..ba93e139a47e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x2abb8f41f
+#define DMUB_FW_VERSION_GIT_HASH 0xcf6f1711c
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 60
+#define DMUB_FW_VERSION_REVISION 61
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
