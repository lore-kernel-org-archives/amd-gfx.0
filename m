Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49D7C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 11:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95C5208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 11:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HqhjST7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95C5208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557BB6EB1D;
	Wed, 11 Dec 2019 11:59:56 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921B96EB1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 11:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzqDBsE4VUU/Gc9DoZzw+z5UQWnDiPaSPml3GNyD2CuoBOEasklZsm1Klop6osxvjZ6Hd11kx5tnHe0GTEiPGOfx6S9MJDNEeehvN76ul2HbM2Skhk5qssilwLqR9NtyCg+9oSwq89b+97d1nff0li5/ejEwFYWk/7DRzAuLasg49IZsxb8EPUMxKvQYV7AYZwnDJSwH6xnSfRv5jqNf3cM5VtZG0d0lu7OYPeRZRJxUoSxKW+14bcET6PqMIi0OM9Obqhf7JyWHmGXFtjPTEvQlyNFVoDwWeMvqC0pd1ojr2D47h/1PiFJE9Dzft4W/0hmqz0qB3PwBTNxSK57l7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx6AOJKGMX/s2KEX9IJLxVZO+30bpuz5lWF5Y1xh12Q=;
 b=a/gX7ZHq/09Dxn02l/aXQhh6auu+YsmtWR8mKAktPsMAbL0RuMKoL/7DNQp2UZX9OaQWufQqlggUSO8jhcaL2BEc6C/NB4T6JLqHOgtcGZTL/q6Sqh4AlK0mo/tUUYCIKMt1G4jXIOwoLNpyL3g5pWVOwRApNWFfVr+uMycuXWs8Rygw9kMKPu2eGrFqnwH1rd9s0YRZa53TYyA2naR1aJCv3U5xjNLvEc5VoaohZPMUfADjH8PAILmGINLbE+AvwJkAhO5G1/Jx0QQnINEexCy9DgYgiChIFeFpFOXWXRexXDNi7DqiIGufO7n/K/+WLq9i919/ZOjtn/YWxzo9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx6AOJKGMX/s2KEX9IJLxVZO+30bpuz5lWF5Y1xh12Q=;
 b=HqhjST7h2rkJYMSaoxfPUeTgJjnaIO+iGG0dDASVaj6t7FKO7xAjtxLpTySMmTZhL4FOGRXHPZHlOcaa0DObehWvhNU/pvXo2GuzlMfun5GBagax2x/4wEhaLxmcyyQ1yLv0onvnHWSSxATQhdiwNnosN7eBcDxJPR5dqcdxQ7M=
Received: from BN6PR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:405:4c::15) by CY4PR12MB1288.namprd12.prod.outlook.com
 (2603:10b6:903:3d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.18; Wed, 11 Dec
 2019 11:59:53 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::202) by BN6PR1201CA0005.outlook.office365.com
 (2603:10b6:405:4c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 11:59:52 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 11:59:52 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 05:59:51 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 11 Dec 2019 05:59:49 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for navi14
Date: Wed, 11 Dec 2019 19:59:44 +0800
Message-ID: <20191211115944.23206-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211115944.23206-1-tianci.yin@amd.com>
References: <20191211115944.23206-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(428003)(199004)(189003)(81166006)(426003)(7696005)(5660300002)(4326008)(6916009)(478600001)(86362001)(2906002)(1076003)(81156014)(36756003)(356004)(316002)(44832011)(6666004)(336012)(2616005)(70586007)(54906003)(70206006)(8676002)(186003)(8936002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1288; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf296626-836e-47f2-e409-08d77e31a18a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1288:
X-Microsoft-Antispam-PRVS: <CY4PR12MB128828B7C5591F059DB3AC9D955A0@CY4PR12MB1288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKP0GtFIQYSm2I+YDd9pi1uxhB4xZhYAr7yfr/s7L88C96BGQjLQ7LF1jGZ3MdtAtoIwhNT+d7XgsGWOL4p2QnkG8lhsL3MVj7VB6sZkjnEBpZVp4oPrV1OJmkd4IABx9lI1JXa/Tz6I+APkjn9L5PEJE6qzfOcz4n0fDAYwbg7ZCHa+2c5qmsr8uLHSyTxUtMJbAIGiNQIBRd3kuGTzygVJSgMwNinAKH6zLCgf89InfYu/EliUoH1Y4Nc6VGR6F6Ddw3Y+XW/GwtP9bb0r8XcJ8uyci7OAcO+zfvjY5hZ/9bA5sZVgzembKhF8vDrpO2PGV6gWgi/mabipS8UZwTpeXhzLKM6smsVSUltQ8TCAROtlRrZaFBtrWDPDZPB+0aa/CqL6gis10wgtfLVXuec4308MqdXj1xmp+bNKWC8Hvdt4NyWYseUqxBDYXJVP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 11:59:52.4515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf296626-836e-47f2-e409-08d77e31a18a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
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
Cc: Long Gang <Gang.Long@amd.com>, Pauline
 Li <pauline.li@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

add registers: mmPA_SC_BINNER_TIMEOUT_COUNTER and mmPA_SC_ENHANCE_2

Change-Id: I1fc3fb481b2d9edc482a32497242a8be6cd6b8d7
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e5637a6efb05..8cdef79de9d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -162,8 +162,10 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CGTT_SCLK_CTRL, 0xffff0fff, 0x10000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL2, 0xffffffff, 0x1402002f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xffffbfff, 0x00000188),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE, 0x3fffffff, 0x08000009),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_1, 0x00400000, 0x04440000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000800, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070105),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
