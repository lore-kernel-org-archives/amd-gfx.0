Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5CAC33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 11:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908FB24679
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 11:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4XsCcXm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908FB24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A79E6E37C;
	Tue, 14 Jan 2020 11:43:23 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8146E37C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 11:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePn3HcpYoMamd8ON5EjmFobSAJRDlkrAoeiRWjq8RxxVHNRFmmvxSN7fY2fRCqSxRzayAnCJvIjddoLPq3zti3SY575VEkg/KrDI1XNW47M2EpMWiN8ngsftyhY6zX6CmzR8YVzGEGotp6eLgDWVToOxi1TdYt4f3LHV8QNRArZs/mkhaTWxcX3hg+yoTF29Z9lQ08NWNKcIqpuCpSFgkq9Q8HIwUph936hOQLuNKvBo48aiOTC1NCLSelqL1JkJnXMBBFbDH46jHZScZnzg7fqO9iok2UJ97dcUq0yszbNYz71p8TbeJLCWqfrDCIXAJYn6fYrRbcBz0a+//NfXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+FJMTwWjCuQ88QlA9xuibKAVsKfNC58tPSNCpKkAPA=;
 b=aMbdd9/tAh1jyYLPTzXeKUgS1UMLXIkZ8FQ3/80o4lPTpV0raavsMz7YiZzScslbZKnGKp/GzVhC2pOqy2UxSTBYFfNFE84dCdDOrjerVUsd/qpkQp/pzmjmwOwpWuVP4pw5rJ182t7a/W65hhMoteyrcSzIfD7NMm+iUYNnwLE8pSV8xuGIY6x5gCw58MVJHtoEM0D2W9UCdao4urUcY3tRFxbfTqpZRixS35P/bVwk/XaH1sfTu6MapCt721IVa0elauUzr4CHNOSny2ilG5wphFZpR8tY/4nvebYcE0DY1ujnh5H8H2Nd7lagNHYNqhO9WNJZItRZy2LZCx5ukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+FJMTwWjCuQ88QlA9xuibKAVsKfNC58tPSNCpKkAPA=;
 b=4XsCcXm1sAZ8YmJ/fGqmwvMJnYEeCnsWkkv1lrOGBBkSD2cI3oJcoJTToSHclzJnWuMEinXeXg1pyMi6wufzZpQayAphxDi9q4FSXd8bWNrf6PUoXtOi4myCO6D0LIYhkGILlgPXdCNrom7CIhvm+q7s+01Cho319PYrwH6wcL4=
Received: from MWHPR12CA0027.namprd12.prod.outlook.com (2603:10b6:301:2::13)
 by DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Tue, 14 Jan
 2020 11:43:20 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::208) by MWHPR12CA0027.outlook.office365.com
 (2603:10b6:301:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Tue, 14 Jan 2020 11:43:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 11:43:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 05:28:45 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 05:28:45 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 14 Jan 2020 05:28:44 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings
Date: Tue, 14 Jan 2020 19:28:40 +0800
Message-ID: <20200114112841.17148-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(428003)(189003)(199004)(6666004)(2906002)(356004)(44832011)(186003)(2616005)(426003)(336012)(7696005)(26005)(54906003)(478600001)(70206006)(316002)(81156014)(4326008)(81166006)(86362001)(70586007)(8936002)(6916009)(8676002)(1076003)(5660300002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2668; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60065bcb-0d94-4a90-630c-08d798e6f449
X-MS-TrafficTypeDiagnostic: DM6PR12MB2668:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26689A464A0F5E6781ACED2295340@DM6PR12MB2668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 028256169F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1h/N+352uAbgygs2hNsH5Ax7BiXZQ9fLN2fQp6FN38KPwsjsVqNOWKnJo/KqC9aOkZDkohOvVYwy0lM4bHiWi7Vehv06waKwMA/ZwYw3UXszkKue3/fjRh0n38A73rOreEt1OyS3/vUNa4PpJk0Os9TzfDtq8Pem8sxzN80QveQQtQrVaW9B8ewLvXwCZe6YHDHZ8Zh6MR15xh1vvd1pgitxMcidqgxVu7dtHZ1pCK1X9BzjMAPew6ToaU7QazMAznvORhK4tL9cARzn/gaU4SBxRqoNPwkr0coz6XlDjq05fDyaHi/Jh+5esTVKgouqzOgjyibvH4QW0clXWr/mc/dsOYQYo8DGkE5VtUJFK8ndTvSMVr4UjDjRw98XjRQdZRichT2MteMMMaXhR9XTU7rd79ZDlxsbxebpg9x4Q1JHtA4c3hYTtU5jIn7e5v5V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 11:43:20.4134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60065bcb-0d94-4a90-630c-08d798e6f449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

remove registers: mmSPI_CONFIG_CNTL
add registers: mmSPI_CONFIG_CNTL_1

Change-Id: I8d1c5d0a0553d60a6e419d6acb9750e5b2634e49
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d72b60f997c8..4f6ffaf3f9be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -121,7 +121,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000800, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070104),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0x001f0000, 0x00070104),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000100, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
