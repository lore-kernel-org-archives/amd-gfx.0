Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2265AC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16AE21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jN6pc0+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16AE21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD8556E937;
	Thu, 10 Sep 2020 13:47:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3E16E933
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAjs7J79Oeq/rkDdW2uzg0kXPj0mrZIANKN4f6sXiOkgVEJ/aOdyEoPua6hwx7EyWL29kusY0DVI47Bi9apHM/V9E7Y1qyqaPxmncmDVTx9wj9JJQr4jaw+v//yl0mnq1WM3Qn21ZlkPHIfH0aIi7fOeyLgsfFW1zG7X2WOX4okm2tKvqZZXpdukIsOjGz/Gfa6d4Ek1JHEXv0DhERNbZjitq5fKjjaGzQdee1Qt8d3beUbGP02Rth67nHDjNZAiHjEvAnDHZIUUnQNJsBbCDSrtXIYaSpgrn6Qc/5En70DYbzi+2/NtV/6GC4w5AbIm7Mk7zGHOQKOD5o9vQwctYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O30F8XeEWghcUfcep0vT1K6c0Fr2RtuVh2Yi0/BzjQ4=;
 b=XdWWd9PYJM4UDABiP3lvsA7uADGyRX2FKFY3hLzcKnt+xcPA+Gr7/8bJPhp8nB7gUio+EpkVyaRuFuWaO8OhqmIQYy6q4CbTuXu50zNTBQLNvZwE4ZM+dZ8XwWQmp6PCK6QT6VBnze+6KBp2itN6GjhI52fZdpeMg9pUCV9cvCQh15H5XPUqXqxog2fw23t6cdeynVdGqTNHIswLw5bPVoplCD0ebSK9yyVzedjR8kbz6cAKpKYIe07x1LUFYcKsMK5Z/gJ26Y0OLs2j0XJvlnlzWnVCii9gm8zF0nK3kKPb3MnKxNvQOZQ96G8XyK9xbQX5YVSjv0nbtB12C428vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O30F8XeEWghcUfcep0vT1K6c0Fr2RtuVh2Yi0/BzjQ4=;
 b=jN6pc0+kdYMqT3aGNayQI0o0hvL8pxeJ1DTTUX2BN8B2qcDJd06/cKvuW+cuuTSPnR/pOkM6deQYBBRPPIYo14Mowb379rxMBBQYpRJrYUeChzzq0mHpXmMLscSaUCAz9XfiR/o0EzGF4+KBKKyXKc4RavfF58+8/UKBzYuo7CE=
Received: from BN6PR08CA0050.namprd08.prod.outlook.com (2603:10b6:404:b9::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.19; Thu, 10 Sep
 2020 13:47:26 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b9:cafe::30) by BN6PR08CA0050.outlook.office365.com
 (2603:10b6:404:b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:25 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:25 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/42] drm/amd/display: 3.2.100
Date: Thu, 10 Sep 2020 09:46:43 -0400
Message-ID: <20200910134723.27410-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc740e46-9d0b-4440-19a6-08d855900d3e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28584173F61173DF5AF1C3088B270@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +P8RXV4KiwC4GsjyJg9r+Hhhzoflf+1FbtvfGBme8hL8UHEXQXfVgaw3fIR2pXOigd21nlf7vZW2mT3lmaE4hFWpHOUiGocxWypgh+zcsDzLyMneX5ngQ8tzTNKRyrbPIPSHRqabDlhD3DB1/exOlFxUNVABZAPwnOVXA81FNTQjsHO4meZCnfs3KAC+y8QjK0nV8ipaxuAZrpidRliulNRnMIU5K2AzKGO5J1eWS0PohkKha6SxzNBHLw419FyjgykixF+batAqIX/m/y2KFM9R8Glf1eY5Q60Sv1QjRaRw5K8doEbF9o68g1KO8imDaDf9m0wHb+XHjV1BMFzm3QTmq5LEwwBDw3p7+ax8T0biRgD38NvQesrxCAIbt2lV9fFGDxYAF9qZweeD5EAGSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966005)(26005)(426003)(54906003)(186003)(8676002)(356005)(7696005)(82310400003)(82740400003)(86362001)(83380400001)(316002)(47076004)(81166007)(4326008)(478600001)(336012)(6666004)(5660300002)(70586007)(4744005)(6916009)(2906002)(44832011)(70206006)(1076003)(36756003)(8936002)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:25.8310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc740e46-9d0b-4440-19a6-08d855900d3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
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
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1d9c8e09c08b..7416fd37e7d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.99"
+#define DC_VER "3.2.100"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
