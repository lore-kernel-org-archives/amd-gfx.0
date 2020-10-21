Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AC5C55178
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9096222C8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CqKeWDxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9096222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EFC6EDD7;
	Wed, 21 Oct 2020 14:23:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A432A6EDD1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPyodhplVzjXhlW1B69AhlkGQ4lzhwZqmlAgdooUTxfxSfJIY0yM86+1oTtHeVKOf1PqPL/P0JibNPNsBFusLDwwQjs2aHjIUHFQZxPvBqQCI7PuSKpbv8a6pkXDj/lI+mHCxIc3jExanSmpApAVwn8LyxafXej808FA+N/k9C6ZlOsoL8WvI7ZGoqihudEp5XJYlaKNTUk0uuo0LehkJVA7OfOLyinCoCc4t1GVKvtf+CSpAoOrDZ+sYu6qDr5tHITBEu6BJpWuQDbeTqivwhOa6Me/jtrFDU22wjuso/pLK7hMilRCDXhYdenWoM5oJCPXXWv/lOpuektGY7skVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNiTMqZlKG4viOMpzwPlp+ofiQ+I+n8PMgxFZNPRFr8=;
 b=J0XmU2VIVYTeVkZZApktlBCbIOLG4iWdaG7FIQwQBtcn+TBloLRIB9ABtTyuXwb1DouW9Bpx08mULJf3WK3G5J7PJRHEFo1D7khtqAwkCefCEROWkJ0kKCKVRKzbaYFkguuZtqzIJV+5OTnwnyxzlVvBMrkotjggW2+H4x5rgiP+LR5aCZE5TWamNqsyYLlcbVTc1VF6yv3Br7hT8QLnoUw5xDi2Zo04QYo4lgTDw9nzuAw+ZL8xxKt8tUoTafWqHhfAnRk2UOeVLZ8biGP7bbIxAQTL7cuGJv8roPfgelWY5Dd09luxE7Nf2u8zH+pjpVNbqRzB2X6HGBhovlCJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNiTMqZlKG4viOMpzwPlp+ofiQ+I+n8PMgxFZNPRFr8=;
 b=CqKeWDxfWUA7Ftn2ycCnt8nxE6KPnDvp1LdtW4qvAA1HlDcUCxW4Cm6Aa6PTr38Sis3brTNmjQQvxYr5ipzQQZ7Uw9a3b1IE0sPSXvy4AHHi1pu+WolaYww9QXmSYwQwXl2Bg6pZ4rjnzXwCk5oYQEI4uNlLsH/0e3M+Z3q9JIk=
Received: from DM5PR16CA0035.namprd16.prod.outlook.com (2603:10b6:4:15::21) by
 DM5PR12MB1466.namprd12.prod.outlook.com (2603:10b6:4:d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Wed, 21 Oct 2020 14:23:24 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::49) by DM5PR16CA0035.outlook.office365.com
 (2603:10b6:4:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:24 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:22 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:21 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/33] drm/amd/display: adding ddc_gpio_vga_reg_list to ddc
 reg def'ns
Date: Wed, 21 Oct 2020 10:22:46 -0400
Message-ID: <20201021142257.190969-23-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9e6bdc1-56c4-455e-93ab-08d875ccdee9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1466:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1466AE1BDC38D70CCC4A22CE8B1C0@DM5PR12MB1466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qWOgvaBXBQ5v5J3IoWL4+sFprQJtcdmQI849ciy9lFoggKFMQkbKW43AgA02BxrFx2kthb8/sIMGCEX5IXkWHhtfBzoGW89GW72lNciDl5hv//wahIPP5qDWC344fB/2UYUHbGhARjdExpys1JS8/jdLeSNfcWuwuAjELx0i/FpBcEsAU8UkARQ5qg11khZ2+4/VZq5rRVbxnDil4x6RH/5fpdPuJ3xL/xmi46J5iIP58SLughHFNxtXZdBbSnZcbU6yLPIQlWVS+B+7nV9lGTG8C7I+I68OJ4QWMBfD41lHujGtOL1BKp2cOE8JYrfvMtyZxhRhor+bbSkqQ15+/8pXXVVdnSqqECiMBLtrZHliAgM3rWAiWxST0FQLvse8uF87ET2Q4RqS8N3Vluapw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(82740400003)(70206006)(5660300002)(47076004)(316002)(86362001)(70586007)(8676002)(81166007)(54906003)(2906002)(36756003)(44832011)(478600001)(426003)(7696005)(82310400003)(8936002)(4326008)(2616005)(356005)(336012)(6916009)(6666004)(1076003)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:24.5563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e6bdc1-56c4-455e-93ab-08d875ccdee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
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
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

why:
oem-related ddc read/write fails without these regs

how:
copy from hw_factory_dcn20.c

Signed-off-by: Martin Leung <martin.leung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
index 3be2c90b0c61..21583699f992 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
@@ -117,6 +117,12 @@ static const struct ddc_registers ddc_data_regs_dcn[] = {
 	ddc_data_regs_dcn2(4),
 	ddc_data_regs_dcn2(5),
 	ddc_data_regs_dcn2(6),
+	{
+			DDC_GPIO_VGA_REG_LIST(DATA),
+			.ddc_setup = 0,
+			.phy_aux_cntl = 0,
+			.dc_gpio_aux_ctrl_5 = 0
+	}
 };
 
 static const struct ddc_registers ddc_clk_regs_dcn[] = {
@@ -126,6 +132,12 @@ static const struct ddc_registers ddc_clk_regs_dcn[] = {
 	ddc_clk_regs_dcn2(4),
 	ddc_clk_regs_dcn2(5),
 	ddc_clk_regs_dcn2(6),
+	{
+			DDC_GPIO_VGA_REG_LIST(CLK),
+			.ddc_setup = 0,
+			.phy_aux_cntl = 0,
+			.dc_gpio_aux_ctrl_5 = 0
+	}
 };
 
 static const struct ddc_sh_mask ddc_shift[] = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
