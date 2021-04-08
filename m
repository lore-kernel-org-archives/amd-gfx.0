Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F7C43460
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 15:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1E861107
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 15:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1E861107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BC46EB58;
	Thu,  8 Apr 2021 15:48:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C2806EB58
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 15:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z//vlWAG40TkmDnDBQ+ilErkKh7D6fnLiPfMaecXrBVmw1bbhks1v7/Jc35nsNa3biokU7646C2F/wo8/eNoeODDMG2FRX8PNRB9H6zscsFkoxAtOxNmArQkPJf4wr0vvYi3IwBIPEbHYXsp8KG/Ut7aQM7Xz0LsANVX2IjbBaJpBOKjwbxrog2xT7khtEJz3n5S8d6d2nobJm2TItj05sY5fCj5b00UF/Od6ppiSu26Z/8L52GJdwnJzRbszyUPk60N62rc7x9HMoNaTu6aCrQB4QCQ8UIGo1kp+pkAbLqSDo5uimnocZgpmpnSHM6UPVVl3ltSs/KZHeKC/W2DgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HTCqlC46Mz66G5wJZ0Na1w4jg2glMsJSxiAbwMGVb8=;
 b=OygOKkC/p09vYBM8Oo6Ctpg0nitQGjYBqkPk0w7Ou9TWxsELb5mwUgjcfuHqjSz3LMn729Aob6UHJclpg3817QNO6DL/514qGEv5995bv/58/a/X6kqKHTxMSel1ZgvXCvAcHWYM4KOS+CEDUJ5F1eVSVbkoZHlRT67SGFINgxq+G0gPIGp6/mr+QyuxIIc8jbkkT3y/QgaxXRoROxK4J+P8aDsITehdZ0PCmLxhmA5kz+wOQk+AQiQIZmIdnoecVinyJONusHx04KOBZpAb9ZuUN91FfuAbDomGcNxokyleLWmtNAmtXqfShA/wtH4KKUSzjOF1i50mklyh6wuerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HTCqlC46Mz66G5wJZ0Na1w4jg2glMsJSxiAbwMGVb8=;
 b=E8Yoz/3OKzcgOcQrLugrHL4DsZbGc7ufhnNTNQOjO9qMAVdR9skeIWn0ckwh2qGB8VvgBGN6/fefg6YFRHuR8dhRTPxjr2MHjbZ5Oqz0Q8TlDWVm3THnOHnF8b6wdgW4Do9U8C8E9FwLnTXKYY5gexfnLIa7R6IM0uJ8ECb5Bk8=
Received: from DM5PR22CA0015.namprd22.prod.outlook.com (2603:10b6:3:101::25)
 by CY4PR12MB1573.namprd12.prod.outlook.com (2603:10b6:910:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 15:48:23 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::6e) by DM5PR22CA0015.outlook.office365.com
 (2603:10b6:3:101::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 15:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 15:48:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 10:48:22 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via
 Frontend Transport; Thu, 8 Apr 2021 10:48:21 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Update DCN302 SR Exit Latency
Date: Thu, 8 Apr 2021 11:48:21 -0400
Message-ID: <20210408154821.729834-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a5d6f2d-3c69-49f4-b19b-08d8faa5bd90
X-MS-TrafficTypeDiagnostic: CY4PR12MB1573:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1573E28CF30BC9F814C016878B749@CY4PR12MB1573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GU4vNxb8o9CYOLnfmBcxAAC/2PQDX8ftlFC1GCz4FZEgFah7IIlOiiKEntTa38/VV05NpzHnIU1VuqaE3Iy8edJHEQp3XBwOCBnRTosC+c9hWmSsYSoZq2HVvNG5G/gB9aOkbXHTEBNtLs/MT2bHZ3EXE/iAWTlSCAKRKRfoPOegIoGDNQa4d2rmIBIBL4quLWyaW3t8HkNhYHG8jNQvoSqBW6OnW3losTleX6hWMLkeMsMoikv6vA9/XVscvGEYa3l2I2IxOOu/PWTXAgFx+YRNpifj8itIbbJdVKyKAQ1aQk7+ZQMA9sLHYw/ETNmsd/LZM3rIeAL9URplzoUd8uyJ5VHZ+t6Zz7fbhTfNCEA2xYEexzXrwrBCIq/zE0yPSu65vMTd/sj0XW9JH64hQg20mDfq6trZ7GAqnvSuk/tb4OPEAeL/3erEBOeDwHD/SyvQ9yo718Z3o0zwiSLjFwyGrKsUaIM7CKpZDEZZkRoSXEuJPIFaO+upAC1O/hmJXVVEgH6tby9RvP/opnVcQZDDGCmORDUGeEahJXMF+K6oBTfw92kpjethP8QykF9yPPrKLE5K1cI+y5/Wji/HLVm7A0HAdcs52XsIPQ7m0T+J86YhBkMQ9uk69jEDUeHBYW2lTsyaF6UDo4pY4iNj6Tun7sQEG3mxdicA44HFda2KFkUZyPak2DIFTQ2Q9q7h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(83380400001)(81166007)(2906002)(82740400003)(70206006)(7696005)(70586007)(47076005)(5660300002)(4744005)(15650500001)(356005)(36756003)(1076003)(426003)(2616005)(6916009)(86362001)(186003)(478600001)(8676002)(44832011)(36860700001)(4326008)(8936002)(336012)(82310400003)(54906003)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 15:48:22.8770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5d6f2d-3c69-49f4-b19b-08d8faa5bd90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1573
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, aurabindo.pillai@amd.com,
 Bindu.R@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Update SR Exit Latency to fix screen flickering caused due to OTG
underflow

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index a928c1d9a557..fc2dea243d1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -164,7 +164,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc = {
 
 		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
 		.num_states = 1,
-		.sr_exit_time_us = 12,
+		.sr_exit_time_us = 15.5,
 		.sr_enter_plus_exit_time_us = 20,
 		.urgent_latency_us = 4.0,
 		.urgent_latency_pixel_data_only_us = 4.0,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
