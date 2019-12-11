Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B207C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9F720838
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GsHP5MHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9F720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1DF6EA6F;
	Wed, 11 Dec 2019 03:21:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA0F6EA6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 03:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4/JEIL1ZgZAzTTRJayOFpb51f98h6/6Ti0J5BjGzLe41hCVtvKJR9dYn4uplEaSwgHLIRBNXmfkBymZXstfTGKSbJp427ZgowjBZ07U6Yxda5Iz7po4S3/rkL/P466oPpA69xaepF9jGGPjKXueQkoLlnuR4vKYAY7rUzKb5so1oqlEQRKvFC8pwlzpHcXZEFj7sbOjnPHw40VKSpZdntlA0vBerzCNTbhLHgxcRYBZd7fVyMDEoRe1kRWPgkivTIfkUkmV2W6X3qyQNzEtodbL8s9HwNch+SNP/aC6BWvObNh6O+LusGnnpaeo3J3XhBpn7Ba8atgjxPeO26Wv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5niFVf0GetDIa4ER3y0ysWUrXQ1vHe+7cdQJFWFxqeM=;
 b=OMzzf+Sz+/ZHeIW4OZaYGAoqTMFXaL9eHG/jS/qLEgAPaf7FNwsQFi8U3fN/vnyr2qZO0tct+7EgJVQSvmkiB8qPBITvZjBLXlT6Ga3VcfMWfJj5mVwXbOvhhMPTy2T6/w4Z3loW9lKHKpB4a5nz434n/1G2ye6Q2CJJ7bd/nl+BEJKWRw0t2mW5wu+9M1KfItNG5bBntT1mLvWiwDidqi7xzMXZtMHI4lxJxwtsJ6Ks1j8xLYNCNfT+SACLPyimnKCA3y7T0icgjz+YaT0ILFWKxuzaA2a/jqIIEVzpZ3kE8/OxatPIC4qk1KmqeFiDFjTnsheYQBzf6U5/hMdvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5niFVf0GetDIa4ER3y0ysWUrXQ1vHe+7cdQJFWFxqeM=;
 b=GsHP5MHLCltu2xEP5q/iQbT8zdOVweH32s3y1VD/qmC4nRcZ266tuZFNIxVhEDUo6mWvjijNGdph3EXCakNjvAkKb/oqUPHvq77od1d4cO4Lc4EnfE+c6fQ7j5sD92Yd/1f8vS5byEIXXE0TSRJEk1z4vGCn+iJx44hHgQGYvO8=
Received: from DM3PR12CA0043.namprd12.prod.outlook.com (2603:10b6:0:56::11) by
 BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Wed, 11 Dec
 2019 03:21:40 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by DM3PR12CA0043.outlook.office365.com
 (2603:10b6:0:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 03:21:40 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 03:21:40 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Dec
 2019 21:21:39 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 10 Dec 2019 21:21:36 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings
Date: Wed, 11 Dec 2019 11:21:32 +0800
Message-ID: <20191211032133.7882-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(428003)(199004)(189003)(8936002)(81166006)(81156014)(6666004)(36756003)(356004)(2616005)(26005)(70586007)(426003)(86362001)(316002)(54906003)(4326008)(336012)(5660300002)(7696005)(1076003)(6916009)(8676002)(478600001)(44832011)(70206006)(186003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3777; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6134771-6239-4755-715c-08d77de93d33
X-MS-TrafficTypeDiagnostic: BY5PR12MB3777:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37775DC417A7E710CCF3DE01955A0@BY5PR12MB3777.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5SIE6Pu4d4/3nSu+bg9T1Fi5gaXbuQD8l+2GSFOl6Cjyd5Ul3LyQzo41E45PutO+3tBHIRhQbbPvmT6ZMU5C/OioDvutQroIsKFFiZnYanUaseB9EkKEfagZbhmyUgDSpjxtq4AMR1DXCuapwNEgz++FSpSnXEZnAHt9v8O+jVAHC6rqaALa4yq0xNYE6odwF12wNalIRLZuuAgk/smN3bakgE3JMKG2147jh456Tv7dkzD5OgSA7ghZ3say+aomMfBenuC70EhphwGnc/Aqd+GHJuc/Kl/0yzu1r0LuKQRd+5CWd9vMtznEjXI9yInbgmcDcoz6Rxp1fe4uD4PcQK32hxkzRIc86C7AEKoiGYfplkEh2n5KQHjCyUKRhwvNTFm9vH7Gh9OG7dCAu90L1JtXyvGlBS9cj0VGOX+AxjOr1hau2Hu0/8y79ymuhNV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 03:21:40.3387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6134771-6239-4755-715c-08d77de93d33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3777
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
index ed630d37c32c..f3324fa4e194 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -114,6 +114,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_1, 0x00400000, 0x04440000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070104),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000100, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
