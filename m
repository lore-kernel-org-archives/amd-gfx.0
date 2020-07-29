Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB65C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 04:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D182070B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 04:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kjw2BP2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D182070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450826E433;
	Wed, 29 Jul 2020 04:02:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8748F6E433
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 04:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itgrPqQGivz4fRgcx62N2H4a9zN2zcmCGDugKpHq2x/MS73uy+mXCCIR3WXRvTcJ3j4415BE5SA/vBMyEK7l89ps3cUYZN2RJU2QZHvZjIqm+Mc9AR+FpJ8iZMaWd+6aRtgc+KB5mwA1kLSSTmO9+RnYrRrP9LnW7RrqxMLuMU6BWZ8os8bsoFUqdSz9NXeB6ZuxMA7uyajMYK6IArFcloJSWk6HJdpGyLBa9caHTbSxrCSCMMlGiv4pVwmUjlW+KnzWMBT6xnUts3asdqs9hOi0bpq5j/fwjWRzN7rhAjYtQuFlXxOuDloH35ROSit8oXlBcKy5leFQKxy/uyd/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt9TN6HOoTrCBJsjxS9wCtClnC6yf80o9ROh02tP1Lw=;
 b=n6KyuiylP65vNWjUQcrnZyT1RIdF1Y/5WswiLELKrrT07W4SMQTexOYFvzsK2iUOq9SUbOIx+dBPxyButKQ2pn8MOgLU9lDTfhP6/J7bAUpd6u2Wzkf2cssCAYXcMhb8Vm8qK2AsOhrrAanAPkZClafPClkaDLsxGXHUqraDHt4dj5+3UZH+hUZFZA5ToXz8ztUPJLwAi3+np12JQfsHQUfMQ+6Bd8Zn2BJ4Ywoz+DMcGuOFeCwKO5pniM0sxwwf0mCf+CjzEIxR2mLy0lRCXBlDimt3fiMmuRSYCSbbibWsE1XOpskWF63pY+FucnN8cL6uiwjAiH626Hau8TCBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt9TN6HOoTrCBJsjxS9wCtClnC6yf80o9ROh02tP1Lw=;
 b=kjw2BP2LUebyEIoosBUiPlcj4PcvbDy8kI3Be0wXB1I1+p+EofaqUUhWGUgzWEuuXLLznV5SC0AP5u4f1/B6kllAA0RuXYRGDqOnMTr+swM7WXPEzHEn1liddIXm7pmqkSuVh9N3lHGEr54rD8nPqvdvLEyXUoezNadKhGB0ds4=
Received: from CO2PR04CA0194.namprd04.prod.outlook.com (2603:10b6:104:5::24)
 by MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 29 Jul
 2020 04:02:36 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::a0) by CO2PR04CA0194.outlook.office365.com
 (2603:10b6:104:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Wed, 29 Jul 2020 04:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Wed, 29 Jul 2020 04:02:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 23:02:34 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 23:02:34 -0500
Received: from jiansong-dev.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 28 Jul 2020 23:02:33 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update GC golden setting for navy_flounder
Date: Wed, 29 Jul 2020 12:02:24 +0800
Message-ID: <20200729040224.4832-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae05d3d1-c358-4aa3-cfd3-08d833743a31
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2941C50F8CA107D1D6E3D75BEA700@MN2PR12MB2941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgoQ2AKyidkVuoBm2cxN+zFuZ/MFJI0YW2WVONPfVlXEJ5+dwe0lhqok8+hVhAzHZFeBt/6ZWlaj9tV/gKD8krTpWxdC3K3JtvDmF1zrMxjTgRqz4VGKSWEnOsP4AACJUbFcnTYPyU4ECWBdv9sD7w0U4i0IMP55mGsnbBP1lIALD9XAyuxfkqAic3W/r8d8vLOrkJuPt2cHsJQ/Rmh/SffqIgKybjxjSvpLrj0OKgCO4cBZR9mXomVPLDfaG+sk6VuQVQwcnHvtt8pU3j6CQeFgzSOl3zXFCI6VyQ08e1hLLMsNo92UxRUOgqRdvwuhV064KpRriNzowbz2dLKn2C4CrWMwHBujb/2qnmhgfSuTFmXzy7ZsDoHhE+27u5r36gcj6tgNXKXqS9ZN9/38fA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966005)(81166007)(82310400002)(70206006)(5660300002)(336012)(86362001)(478600001)(2616005)(356005)(2906002)(47076004)(1076003)(82740400003)(6666004)(426003)(54906003)(4326008)(8676002)(8936002)(26005)(36756003)(83380400001)(70586007)(15650500001)(7696005)(186003)(6916009)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 04:02:35.6782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae05d3d1-c358-4aa3-cfd3-08d833743a31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2941
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
Cc: tao.zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update GC golden setting for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Ia7e82616b0be48f397c73b015823ac10ef907f08
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index db9f1e89a0f8..ca16f01956d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3127,7 +3127,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xff7f0fff, 0x30000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0xff7f0fff, 0x7e000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
@@ -3158,7 +3158,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xffffffff, 0x010b0000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000003ff)
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
