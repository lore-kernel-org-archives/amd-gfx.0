Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D62C2D0E1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E3B21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Iy5qiC09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E3B21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09876E93D;
	Thu, 10 Sep 2020 13:47:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAE36E93C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIF6bciQ/mq2evXCmr5C+IfYDoIkxMduyK/aGi+/iQGvYTvHG4BelMbIrLcfj+X7VA+9aINK1u4gsLdHYFwFhBR/NS0LkOhuMjMXI9+rhF/UCfKlz6vwrxK6URGcPLX0AAr775eTzMj8qoqoocJneLptSe5s/9TexgVOZBrQcbGJDCF+TcJCb6ItyhDBTUwJkfU1CYny+3d4Rmbg2tJIn8SjZPORGPGqn8FYHk3F7k6UyUoDrA+FYcdNjRMoOmoc9TVo8TACiSMK2OjfgIj/oGmOkDn0sSQJ4fcecxuZc2bSrR6ctJ2BprjcEoUxWT9DFZSskY1kI6OlQS9/vTNXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM7SHfYYpsxyMhrrOoERI/nUwgTGGc080qgxN8f8/CU=;
 b=Su1cCLvD9xq5hArNvl2aaumJ//PKM0/XK0lWCrN2uUOo5nu4BNMM0F+IMzd7vAHLp6xRx4JDc9ardMe/szTy4qw16DFYzTrA8xflYB2+0+1GdidUATp7VCPj1YHqaUV/wYIMmkRiHpxgN//EGR9GJL8JOuRMsLBqhTFoUMm+Jq4Ic7y+TE/oS7Ryqp49PobVH7QXNlN3CET69vJII/zsV+slrjx/5c3e48dnbvXowqFwcdhI31FU5T1TmrBmjicsVWNiqr+GHfKoKOWNdCRmngas6wrStcYrIXGMI5XspHT5hdst1khhBZ2UgdyPhi9nqw/LhUthPKTUL03sZqbGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM7SHfYYpsxyMhrrOoERI/nUwgTGGc080qgxN8f8/CU=;
 b=Iy5qiC09ZK4Ttdi1LEO5MWe0AWgncKYNqaEGZ+5PyXudMWEadG4nHeHc3RN4iPrthTKXSCszB5pRajJGAycz131/QuLJQCG5hPJoYF98D6D+/KFltmX1xbc6rbH7EzI/UXxt6uCt+2yzBzRPOOHgcdGxofeYGwYS1TLBxnAErYE=
Received: from BN8PR07CA0013.namprd07.prod.outlook.com (2603:10b6:408:ac::26)
 by CY4PR12MB1719.namprd12.prod.outlook.com (2603:10b6:903:125::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 13:47:31 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::64) by BN8PR07CA0013.outlook.office365.com
 (2603:10b6:408:ac::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:31 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:30 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:30 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/42] drm/amd/display: [FW Promotion] Release 0.0.31
Date: Thu, 10 Sep 2020 09:46:51 -0400
Message-ID: <20200910134723.27410-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fb75798-aee0-4872-5296-08d855901076
X-MS-TrafficTypeDiagnostic: CY4PR12MB1719:
X-Microsoft-Antispam-PRVS: <CY4PR12MB171999F8C024DF3ED968719E8B270@CY4PR12MB1719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sGALPT/a4ZqRJ+u6SrI/7iF1TYVlRKMz6unG5F2ybAKijMss5VTm/jNNbrZZf4nEuCetvXuO/5mt6jamYngGERzPMUiC+iSMdD0Ofi9X6hkmjpLG3bZQljVes8T6W2SM6PneNZn/28GYGXFBL20lnbR2lzz1F/lBAVP4L0gbiwj+J/WvK70qGG/tkFzJhBqXhewewF6JXR0Aj9bHy4uwV3bel4v3o66TC5466KdOP63AECg8cpw2sXJPePMuOfLRNvRjvCTnJI/hHp3D0434Oh72MMkrXDJyT6MkZz7o4EsvwKzjriXclStFyW99w67A21GFEMwU80ksoUZuOZpAdhbBr2oUNXauFgay0Tx/+Orxd6Z2qhmVXxDJlopk32W9D9n1wCIEfW47qNj588Yiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(26005)(8676002)(81166007)(54906003)(6916009)(82740400003)(2906002)(36756003)(83380400001)(86362001)(478600001)(8936002)(4744005)(4326008)(5660300002)(82310400003)(356005)(336012)(316002)(186003)(47076004)(1076003)(426003)(70206006)(44832011)(2616005)(70586007)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:31.2336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb75798-aee0-4872-5296-08d855901076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1719
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5eb642fe9315..3f84060d79c0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xb18f2464d
+#define DMUB_FW_VERSION_GIT_HASH 0x08aa15e57
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 30
+#define DMUB_FW_VERSION_REVISION 31
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
