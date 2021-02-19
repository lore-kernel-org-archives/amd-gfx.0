Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF66CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915FD60C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915FD60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1E46EC50;
	Fri, 19 Feb 2021 22:17:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D3D6EC50
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjAjzspzj3zMZeR2Y4z0LryYoCxHlNaTDiljSNs+W9AdiN0nkFQw9OsBVG/AqXcQ3QKZnagoHxGRZad9/YBJqOwZyZ4Jt4FBeT6bM+1Enbt/WGslcpjNcymeIejqDFb6j3oXhlv9YIQFcSnts5jroZlZmGEHhaZalrpa6RFu9LOz788uL0t2EC0UHkioMCwecoqWf9QoCMWfeJxYYTxzhzVbJ8cLeeQZHn9qjnm/gGBJz9oMOya8CqrCiV8c2JwSB1SoPWQTwxccwDs9ESmJxX7TA1uzwM1DLnx1jOs5Dli7XPdW/mn5rp8/V5uEXoCLtnlvWIA+tpf4/p2TqFV27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YudVZ9aFAppJBd6qxyEPDlB7tYOI4B+vUL/W63Xg6G8=;
 b=R3+K4dypaSOnlY1/Nbwcx7vwAIi7BqVgBqf0bjxAF2tOaKlFMMDSHwd7N/od3WoeayfiKDQX459Ney1xHZrULp9W88nc29e/4A/WgEoxrvBN07ZyDcS5YPAIAycuNiWIVXrsaJHj+C9xsP+RPqBfKimRsesy9JE9mdHzhb8IUiBN0ThxUMk8QqB3cAdQtPn/EKyCND9zanp7MY8/99TEK1NRWeYoIeQyexznCoTGE3gjrWCTS76J3wJ4p5dBUt97XYai8SWzlMJ7zo7StaTDXI8j9+zYqlCpW1L4H4IfWs9OZgJiqaXVFtgsmGnZvo/XySsn+j9JOm6gvNgc0erAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YudVZ9aFAppJBd6qxyEPDlB7tYOI4B+vUL/W63Xg6G8=;
 b=ur9DGMEdjRz+Cx0tXcjphHqk5pUc62U17aNvn/b9M3hptF3jOTZYYR0FQNQr30NC+v392SVARM5oK76qAm/Sii/q0t96c8yuAIjjxKa3ahN3+jTUwBv/xPneIRpaMHtyP/37i51lXJBelideEvuC95lVYtqtMBUynO5DaAkHbPA=
Received: from BN0PR04CA0123.namprd04.prod.outlook.com (2603:10b6:408:ed::8)
 by DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.30; Fri, 19 Feb
 2021 22:17:09 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::b4) by BN0PR04CA0123.outlook.office365.com
 (2603:10b6:408:ed::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend
 Transport; Fri, 19 Feb 2021 22:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:17:07 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:53 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:53 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amd/display: 3.2.124
Date: Fri, 19 Feb 2021 17:16:11 -0500
Message-ID: <20210219221612.1713328-13-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 903ec657-1388-4a1d-5ea3-08d8d5241869
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2810D80A622C86079E9166B6F5849@DM6PR12MB2810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFSKiPaEPcd5NPnggI2iytCwzxGuW7QBDbf5Jjc84wp63ceMzFsPl2sIL0UTDoRMbErAovQxG01hJofV5SeDi0OVpTDG3rBxIWjy2gx6X9lHx9RRvoZZERBe/vDBmxgrOHmBbugWNP/Z90MxAnxtAVX5LKKdYw2tS7DGcBZCt1kRTH7qED6yhGhDDrAsUzH0J3muVvyeOCYSgktaMEL3wFt3kkc2J3fM0ibZAB+P5BIC89tM0EgT5EDV8jjGuTqh5NuK/7Nstahf6ofboC1+XJ2gzzo3WSmL9+BnkdZVXmEe9IR2+bPtxxN6dTFvIR6PxxrTj32NVWGQszCiYnRywbcaMGMdy8oIv6K+mnL3xWzZ8O4cqw8gxfcPv36tIJ2BxpujiUB8SiNqt82gfdS31eXVKDiQDsn9ahihPGP4b2wvVpD9y+YhVi5l9jzV3qoEkQ8l4aN81bopyRAUBHtu0mANT7JyO+7bEBas1p9lFb8KlGgrTZ/IGDZcZ5wwm4dyWFNBDI7jZbTBocVYcYtkKoZuV8D9+COiexfF1uejdyNI3dAToWzr4xvyWoQme0SScf3pXVXGJ3mqO9ynrUuWKKd33tVjX4aHVyGB2Ts2XaNM0CTw6sEayXIoRpRpwCIN/FUmRsm1cfP4VKQtgp2LZYC8zsLrsq+hBBCnSagc4Fzv28mWGjGWkOAAOslQgocN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(8676002)(2616005)(81166007)(86362001)(82740400003)(83380400001)(478600001)(4326008)(356005)(6916009)(8936002)(5660300002)(70206006)(54906003)(26005)(316002)(2906002)(70586007)(1076003)(7696005)(82310400003)(4744005)(186003)(36756003)(426003)(36860700001)(47076005)(336012)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:17:07.7573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903ec657-1388-4a1d-5ea3-08d8d5241869
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9e631980fa1b..bd1cb665a585 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.123"
+#define DC_VER "3.2.124"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
