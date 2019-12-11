Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ACFC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E460C205ED
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uMAaNRn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E460C205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A1F6EA70;
	Wed, 11 Dec 2019 03:21:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349726EA70
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 03:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff6HXnvjN7kHUWHFU8BUw/Sz5F7WVlzOGGjIFL7UZiY4iv88glPB35s5V1mUYsOlegwu3RQQxptQ8WJcnjr1Kv4ZI9CBL37OiOVSHMfS9MJwkL9qGYaKFF+g+ts7w8ld0+VZ/3XhCShNtE82vLe/CofTWKNspg932wRwkNlUDIdgQaMrptPtndgE4JmkzlmcryE2W/JGR4HaFKFcA61r1shl5n/jvwkZq2CeLYr+sbfrAQaedAUl4dhkc/fjfnz3j8tJWnw1oqlWsFfGuum5qSUE8s1O70hA3CkkMmLpWV5HhfPJQZRQY8jmw1J1UU+L63FD/WoJ0GsQWI+uhlRbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr6RyxC1tXsSQpYq0v9SpRpzm5qQip3J6bUoScok5Ek=;
 b=Poz/ZlBLSdMpY0uRaAT6F9aVl/ixeKp7EaVHS1hSF4Dy1n6kz96q/JriWSzz9Z/BYGkKFN6pm9BQAx6msB5V7q2JpvnYow9I2ZmOQf7ukfT+r7HFOUlBGfxAkt0pxwFAcWQo9JUJUnZnS3MltNHKK3xOMJS264GdseSV1joE3oZnsMxLt+OkfnjWIQDc4YrpNzg08HPd+mvx0eb6wN20lqz0YRpEePqgjBh8p8hjBPxrLEi6Xj9pZzL4pofc/vTg6nT8i2VHme8pAqmg0AXhEgFpijCHddeQnX8dUGXIgIMnPafCNteYLurZPMx0jwi0MkaqWDOAV0BXaOfbdbgS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr6RyxC1tXsSQpYq0v9SpRpzm5qQip3J6bUoScok5Ek=;
 b=uMAaNRn+pwZFTEg9gX2zfljRBJ1znWZu97LeaJRlIzFhr0KFSS9Q/aRMq1tgzBw9ihnoLu2uJbFH06/tCW7yD4fQBLamOOZ5qBe5kVQeX51zxDkfp17WnK8c1sP0exd3GY0ZyyazFh5bYmvcG+jhXrAIfsF9JLm2K7fqp1MDe4s=
Received: from CH2PR12CA0010.namprd12.prod.outlook.com (2603:10b6:610:57::20)
 by MWHPR12MB1888.namprd12.prod.outlook.com (2603:10b6:300:112::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Wed, 11 Dec
 2019 03:21:45 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::205) by CH2PR12CA0010.outlook.office365.com
 (2603:10b6:610:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 03:21:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 03:21:44 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Dec
 2019 21:21:43 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 10 Dec 2019 21:21:40 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for navi14
Date: Wed, 11 Dec 2019 11:21:33 +0800
Message-ID: <20191211032133.7882-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211032133.7882-1-tianci.yin@amd.com>
References: <20191211032133.7882-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(428003)(189003)(199004)(54906003)(81156014)(4326008)(36756003)(81166006)(70586007)(8676002)(316002)(478600001)(336012)(44832011)(186003)(1076003)(26005)(426003)(6916009)(6666004)(86362001)(8936002)(5660300002)(2906002)(356004)(70206006)(7696005)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1888; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e52117aa-bf04-4e8b-0feb-08d77de93f9f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1888:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1888CDF528DEB1F527FD351F955A0@MWHPR12MB1888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xo4z5sDzZEnfcrYUC7jFvrpq5r2xikIj2zoPxPCanv5eFDfH77xODXM8TJreEww4/xWKF436Z3I1GeRA8BSv4TD3DdxoPrVoof3hEuKn9hRQgjl+5LmtqX26fov70fKzmCCTiyND/UMxLjn/tyU7Mr0F5qb5mix7iR3XxHAZwE2Az7BzFewBi8O3ESUmp4qEkOCRGpttksDbuQvTg6Mk3Ew5L6/S3nu5ouxnP5CrnHksCu93z/eASk3T+1S3ILdcfIobxZuhmFFZTAHz2jOiaH0Jthl6HJsK0M2QKvPPs+CF0Ytjo05qEoWrjT0GgOh5Vg+VovZFMOlb2jquz7KvPIRiPBpgTLJ39kx5AOOfAc/4oMU9U5e+42fqjKHtEooDg6e4UDRn83VujyXfvzpM1Zwc/vI9/8LIEiuqjpkfeC8nmJb+S8e1ZyumSR5HLuWz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 03:21:44.3995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e52117aa-bf04-4e8b-0feb-08d77de93f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1888
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

add registers: mmSPI_CONFIG_CNTL

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f3324fa4e194..db9b8bfb1c3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -160,6 +160,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_1, 0x00400000, 0x04440000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070105),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000133, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
