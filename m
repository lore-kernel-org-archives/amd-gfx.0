Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4439C55185
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D672076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QKGYmcyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D672076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3110189EB1;
	Wed, 22 Apr 2020 22:08:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E944789EB1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqklDpb5Dxa36D7d91EYRY6CDh8p5o561q61kaeU3mKCZ3yk8Ac2k0LJNOA2gMvXfKTVpbimEBg3djG4sjD6AtXvCsjccwTCvTmEySip6+vCLe6RXDX5zwxy+XSMuyhQ5eOk04RG/CWVmvl6dduy9DOMgZAjMOP2Mcq26Vb+GvVIvpfZOfnCgsi7uUh4ACBbuIgtD+X5jID+qJsTHFNEWj3D63GnHjZsOSN91GdHPh3B71rvJOZ0MhNmh1NGIy6tiYUeKZd6WEoUszqpB4B/IiKHFIermHsxWrp8y9Ad8NO2BxK5h6sy7Sk6pu9Y2rcm38kB612vsLOVBHX/FdcpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jKRoM6LKRoEgfbE6+7v8ZjC+C7+hUh7UX3er61b0oI=;
 b=Yvxgzj6ZwpmKTI/h6kbRL+opL0mmrJlpSxJ1LjLUNRwkEb/3oTuaUxePiHY7DWz8gESjyu8iGUqAAX7OnbQ0DI+sE7aYVi3m1cyO8JUWZoUX/x/TDeiY+hwZxrHxUjYG/ZlLaI3EkAsXZ+Kpep85D5po/47FexddXHDu84sUC63t2pbBIuOWndYA+fj0Fy3VdE2tv4NMGixyvl81iKdwQqcCEuD85TW8/wUuC1JifriUepSvkNcxrnoooOb/spPgILwYVtGPEz79jnCJB3stJ0CyyOjfLBCEjH8814FcrTHsU8B88lMuyLSswPmC3HX8WSNy8GdotSSnF53rzyzXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jKRoM6LKRoEgfbE6+7v8ZjC+C7+hUh7UX3er61b0oI=;
 b=QKGYmcypmanvKycYW83IpsyI8BTLf86gnNilFY4tu6ybbAQjmr2PqFwkx4pmDT4fUuOenjlWywr3Yihds8YW/3jkWi2JlErF+FfXIhdC4hWKpcOUW9c+f1OevTMmmp44MEwawwmseWQ+tfBKhWsmhX1Jj2U7MUr3uYu5XQtCQzc=
Received: from MWHPR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:301:14::31) by DM6PR12MB4204.namprd12.prod.outlook.com
 (2603:10b6:5:212::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 22:08:17 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::4d) by MWHPR1701CA0021.outlook.office365.com
 (2603:10b6:301:14::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:17 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:16 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:15 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:14 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/19] drm/amd/display: check if REFCLK_CNTL register is
 present
Date: Wed, 22 Apr 2020 18:07:52 -0400
Message-ID: <20200422220805.15759-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(428003)(46966005)(478600001)(26005)(82310400002)(1076003)(86362001)(5660300002)(7696005)(4326008)(356005)(47076004)(81166007)(82740400003)(36756003)(6666004)(81156014)(8676002)(316002)(186003)(54906003)(44832011)(4744005)(2616005)(426003)(336012)(70206006)(6916009)(70586007)(2906002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9025e2d1-250b-401c-2821-08d7e709a88f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4204:
X-Microsoft-Antispam-PRVS: <DM6PR12MB420472B9B57DABAE738717AA8BD20@DM6PR12MB4204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gDmd9Y2KVhwaI4tWiiLlgrRiO3Wx9pSNb8I2NNCQmsQe85sI0+DdQGrY6rnRqscYusmdF9zwyT139+WRXWci6Q4ENsLYGbbLBwpgFZLkv2yfEtaM7gkf/gtE/c+rQUjo/M253USLi8CCi0kjWvajSoOX2LlbEaFB2VXcfMKEFqdGfx10CopjjcnezyhcbC0trMHmnH7mDhaYF3X64IOMGkWb44JGwiaPLFQezxp4rrEojlovuWurBfTT9F/0Bmq30lcKC7V4b+/BYhzOV79PKtb+yUYbfLoaHPwFoPXILrpxKTQIHpfwLJOoIqdVm4NMZMt4YpjlB7tlJN+v+mIwiUAlCu4uB6ms3YOd0Ts24H5pYgXJQYst+/MsXp99VYon4XEWK/7bSFVZUoANoIbxaglXk2Uk841ba8u5OHBbvhua37urf1kHSvel9PgTF2jrOeNNbFo3LfNF0vYErB2VxD6/dqOjAxbNxHZySwHXA9Rad92F9DqiQbaHV263ppO3Z8uDEfCXIurbIVGfwEdvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:16.3251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9025e2d1-250b-401c-2821-08d7e709a88f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Check before programming the register since it isn't present on
all IPs using this code.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 6ad4ed7da629..bd2ccf8eb9cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2304,7 +2304,8 @@ void dcn20_fpga_init_hw(struct dc *dc)
 
 	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 2);
 	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
-	REG_WRITE(REFCLK_CNTL, 0);
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
 	//
 
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
