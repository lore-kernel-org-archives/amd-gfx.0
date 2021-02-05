Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A53BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F7164EEC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F7164EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0CB6F507;
	Fri,  5 Feb 2021 22:03:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B3F6F507
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMkdhMzO/JQgVyi0dnREY1ov5nLPxEBhc7mQmcMdsz+XYn91n/G33p4ptoUdfiAfwWPfVhQijC4Na1DmE99txJduhvtSC8Rxe4WHGVekCznMkjNEUycLI6dDB1j8aGlfFKNVZODKBzIC+hufh2dKgTHPv4tj24zAH2kSiFRwXzSeKgVtgmGIBs2Qpw6rfDjLPKSqIxm6IuEBP1M0a0h2vJkZfl+UPktb6tWRRC2u4V8j1l6utzP5KOBJBacFq6o1IiztMIu1pS3stxqRweBT+ECeFYHVnLQC1np1ZPqTTyb+Cp+PjVQmoqYyoM3HJZrDIorO7foIIZwsg6F1o6EAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLsS0Spxp+iN4fhM8duMvEPgKPnxV1j6ahPMLWMgmO8=;
 b=f7HICS/oByF1Ex+J4nG62w7jmU3KHG1FKOXPSzoyPtLv4HoCIyFGso51ZZPQEnpsD/svXsjfs5a8LX1//AYzj9UyYRNqwyknio+zQV4JQKD42FT01sUZuxEX9iO8ppPfvqh97ydoWTlNLNGNFiT4IrJqKdNUQiuFyskri/QBFUCdkruZriNWkosfMixMBSGX8Jj/3Y826WfEeoYaBIYKmcTupGrYSKI2z31SzrwCtqhgPIBnha6QCyu5dqNwxgyeDYwuQC5YMUExuvyfcuybvQUt4AAnr+AvyqyrpqpoXAtkCf5Z+GgeR9EbUwiBZYLQx2TfpOTzmRfhaY6zVUn2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLsS0Spxp+iN4fhM8duMvEPgKPnxV1j6ahPMLWMgmO8=;
 b=ZR3ZI8G4NoSpwz9yT5asYGlZD38pi/C5qzyNnAUnRktaFLduPlt68VUXg3vJN72zr5zzPTXZjxIOMDsGDLfkxFoUN6Z9F9elLXGybNbI05dxG1pNxz9h2cc3GobtjBC0k+NI8XmDR0+hLJogkb2AE6zctrCcb23qkUT3ygIyvCw=
Received: from CO2PR05CA0066.namprd05.prod.outlook.com (2603:10b6:102:2::34)
 by BYAPR12MB2616.namprd12.prod.outlook.com (2603:10b6:a03:66::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 22:03:35 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::29) by CO2PR05CA0066.outlook.office365.com
 (2603:10b6:102:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:20 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:20 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:14 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amd/display: 3.2.122
Date: Fri, 5 Feb 2021 17:02:50 -0500
Message-ID: <20210205220250.1871069-12-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f3ce81f-8802-4bb6-91cd-08d8ca21e1a5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2616:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26166F8C23673CCD34ED8006EBB29@BYAPR12MB2616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzAFRIO8xhdHm6O/VFZhmk6mvhgKPjZI08giUn13wb5nSQU7S96DVKEi3frHE1Yr3PZ5OnIcf33EUgLLGntxCCIypx/Q9rTRfCQKwz1mLnzvIahGvCcKzakon16iZH15KPJm9wxmwwEViUBK/MdfphcqVzV6jDIcaCPE1UUAn1mKCt/JfFFM3jtN2l90kgYNIONOfU9lWHWYZ+a3qW9J5qQ6NiwIz0fvAhumbaO+7OYazqvleEPp8ny+2WIyxqsVeoRifbdJmU5Z3Vjpw7ixQpxMjbREuyQUzijYM5/6GrfrOjE1C5Trq8OuROfFSsIgGioTOM13o2fM8N67Gu4fInww6zWtds++6HgE2oivH/SZdOdqbdnPSSOBviE68nZKbo6usF3qBAmi3fxibrzs0pfY6yoRzRjJV0epzMX7SG+z2WMb0bei4Y9j1CTEDOzO0lrSeT1gKDgrfLb2+mpdFfARDaxh2MX8NegGoa6Y1d0PnGbvxYBqQVh0vsO+xopA0E2LvAKEpbYP8v75TVOV0dWbIcJN0EBZ+ALkR2YZ3ydlINP3vU1jYW4zYdAe2/04bc3Q/RgxDgXaBL0IXqESmJboNJ9MCLn0Y61SXAmitH8hNCCBvSa7SMsRYLxQYeSNMWCxmloYkxEmKZvP5uuGVTcrUJF1tX/Ajv7lqAPqqG5GKtpBHNiCp4k2gOWHinwu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(6916009)(1076003)(82740400003)(316002)(5660300002)(82310400003)(336012)(478600001)(54906003)(86362001)(2906002)(70206006)(70586007)(4326008)(6666004)(356005)(83380400001)(8936002)(81166007)(36860700001)(2616005)(426003)(186003)(26005)(7696005)(36756003)(8676002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:33.9721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3ce81f-8802-4bb6-91cd-08d8ca21e1a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2616
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Fix error handling in dc/dcn10/dcn10_hw_sequencer_debug.c
- DIO Supported for virtual displays
- memset dmub_rb_cmd to 0 which fixes issues talking with firmware
- fix 64bit division issue on 32bit OS
- move edp sink present detection to hw init to fix hang
- reverts a patch that caused 3x4K60 displays over MST
  with DSC enabled to not light up

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 739a39eeb941..4eee3a55fa30 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.121"
+#define DC_VER "3.2.122"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
