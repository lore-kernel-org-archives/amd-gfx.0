Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86354C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 02:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8E760F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 02:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B8E760F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C6266EC7B;
	Wed, 28 Jul 2021 02:11:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1905F6EA7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 02:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJjFiWMBTI5rPbiYqYz5Z3sh79v9oDFNRH886lwrJzKlbDM4mbSSAiy8CAZTSHa4LHd20pxU0k8CUDn57YnV9QTlg+velcd8X+UWyCLJOChxitsjXa17U4+d2Kmvt43Vw76eiUTai0+3WD/ySJ5MhycGIZyHxNGbfCDoyE+SIA/fDCpgr9RD7kaJmdA1IO1GgZZ1Kos1ohTlvhjUfMRe9vD9H2gYFtRkihbLDzIgnXUIkeol8fdidfDGroUM2y8kcKotoas0d6Cs1YmsLj4sUWBlTRvWJVhOXeiy8vXuvFGDTFa9ka+iRY1M1uWtXb9FDMl1u+CuyFE/mzqdnreE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqIOSAeFSA/4jNsY80XQTPrXEumFzn+kWvYye8dxZLw=;
 b=H+CEOVsl1jAGi9E79Zz9KpVd4BN4+GQkgr5v6JKj0DjpJOysJeJgkbpn+tI3L8MigLWxuLD8hXze05gM5jzkDd+94YOkpt4g0lntDmdmuIbZSjDMUa8/GDjxLcuIqXTtRvh12mnfEEoOGA2a65GiQk5AVKCmGm0i7TLWvy/lDFVKIRD7pqeBxqDjXKTRzyK6Y5tp2VJAtLPfnR1Cmzw3qB4z+slxuIbLk+zq1wKo24G6QI8I41OhZ89qA7kfsBlgD/I0YuUy7Tcko/sFBYCzb8xNpChfEPLEqLfcLvB3c9XY8swOXLynDa7qXuMLgTCN1Rf6daMx4KuTmfrjgiL7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqIOSAeFSA/4jNsY80XQTPrXEumFzn+kWvYye8dxZLw=;
 b=b6TJyOcj4eE5wvBIdh4ljp6es0SrIp29fkYbIvCE9agmRFZBXdkapL4qAOR9qb7u/BrMmMf4nbL40ohKLJVDf2v4TSWCkoj6xi47OjPmPIYv3XHgT3tMlQFHeeeZ9dKpI0Hz5xk6heNSkd+AV7yyNWICRYcBdjL7sI0iJFxUZag=
Received: from BN6PR14CA0023.namprd14.prod.outlook.com (2603:10b6:404:79::33)
 by DM5PR12MB1212.namprd12.prod.outlook.com (2603:10b6:3:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 02:10:58 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::6c) by BN6PR14CA0023.outlook.office365.com
 (2603:10b6:404:79::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Wed, 28 Jul 2021 02:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 02:10:58 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 27 Jul
 2021 21:10:55 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove the access of xxx_PSP_DEBUG on
 cycan_skillfish
Date: Wed, 28 Jul 2021 10:10:37 +0800
Message-ID: <20210728021037.446968-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6209cb0-7305-40b3-4e07-08d9516cf0ac
X-MS-TrafficTypeDiagnostic: DM5PR12MB1212:
X-Microsoft-Antispam-PRVS: <DM5PR12MB121237D59CC168A33D1BDB6DECEA9@DM5PR12MB1212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLP8bw5JIwsxDgTnioBrf5TA6QmisfV4wG4x9RD/zX144wSKZvNe+dEJ/SXArQGULh2zHx4eOCP65aQdu3nHhHdxdl9E+CIbZY1hl0jSMt3WZFDKJA+4ERTG3fvLR4pGickpHdn+hM4Xg6zxRVHylHnp/AKcFC+ElzvL4FNn2zXdH7PA1cz1rWP7Cqw6heDlAgGE9npyFB+MF1aZ8LStKfHyiVbXg8Tog0HmhZ3TP1+Df3phwzktOmjFbZwht0mwooVvmSX55voLuRamphPaS4nOL06oPnoyisuGG9sfJNeOeMGBrdu5+Fu4OcZOWmVOT9j4W+p5DJowVliGgFYRHMlIKDnkzQeBT0sybmw1Vc7Dp5NI7nscpoDTM4lPc1yYTbIk0r3MksmOVXW0vWoYY9U2LV9aUFkjHWAJEeHThVxcMe45WnzUO817xwwUz83Aae0NTPHqf7fi5lQeMctl1xpu22jD6/geIRRSjylcM7PNQ6qpqM4Wr1lz82xnFpvjwxhMdtqO7q/FxvGCqaM+tuTObge/kh3rTLjnI/oGRYFVm9wQK98ZYx3X5Wc2/Ub1qsawOdGFU9PlmDRvxathb9txZ3Twka1Y6nWisUI9veQ24WrTfP91ynzPLff7z3NSgRn868O+18jeljBTr1I+6ccmG7OVfq+WWXlr9Q0XkNvgTTsvhfAx6pGB0tUIgLTMNYMO46/Joqk0PPOLvGD42TVwfsvsESJulFlXIaTsxCN3OAO19pYO4D0YkF50NxCN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(86362001)(26005)(4326008)(8676002)(6916009)(83380400001)(82740400003)(54906003)(7696005)(6666004)(5660300002)(356005)(1076003)(47076005)(186003)(36860700001)(478600001)(81166007)(82310400003)(36756003)(70586007)(70206006)(2616005)(2906002)(8936002)(316002)(16526019)(426003)(336012)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 02:10:58.5337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6209cb0-7305-40b3-4e07-08d9516cf0ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1212
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
Cc: Chen Gong <Curry.Gong@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It won't need to clear the xxx_PSP_DEBUG registers, because firmware
will handle this change.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f94ef15b3166..24b0195fe665 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3541,8 +3541,6 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_5[] = {
 
 static const struct soc15_reg_golden golden_settings_gc_10_0_cyan_skillfish[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPG_PSP_DEBUG, 0x0000003f, 0x00000000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPC_PSP_DEBUG, 0x0000003f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_FAST_CLKS, 0x3fffffff, 0x0000493e),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CLK_CTRL, 0xff7f0fff, 0x3c000100),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
