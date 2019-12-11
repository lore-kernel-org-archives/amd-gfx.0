Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3556FC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 11:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CFA208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 11:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WMnzXMwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CFA208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF776EB1C;
	Wed, 11 Dec 2019 11:59:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284A66EB1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 11:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RN18AxDHk89HFDO6bqBdrI+TKgFIOhr0ouPWQQ0rVLqYTbmnX14NUXe1wVqNXRhS6mK7DJy8VKPOtmddzEcf1HTXk5lSjvS6Mbav8TyxIWtU1yPlWnrcir8rp6kIk/0vGft0DBQW8UT9Ak5p3/aRQQZg5J1hGfUMrUkWEyvDIqvAQEoNXPATfRw6FFbZE8N901ziZLAJkBIynturMupET8xLB7WwUtNAwaFAvCNJFz1H5xt24C4L1f8Zw0UM8ZNLrmXVmDPh1gSFHmLTgWge+mzbQNWIYMd91zAPq57dmSmtYJ5VLRBQMKG7Fm28KhEAB7vWi+5xqad4oi00EcufLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br1IvGhxx/k0hdslZtBd6m/sIKGfSUnFhmHgUgL40Mc=;
 b=Wxf7Ec4nt45dw0SZOWWHG04BJTQcPg/OcCGQMJBtGLQqUnyLNsxC8GDdEz8yByVBSJoyCwnRGYhHZWqrrKEXJbA+7iLkHVjL2xoU4FzeHbxnvcEwKcBxnZDtr5pzaEz7wxN2q2PAyG3xUKWSWJ+L32IlXttmwh2JMy605Ck5EUPWoKzSJciLA3T89Hacn/CpZeZ5B4nHLQVEdNScsMKUtPzmMUkiKa7cheluTUy6J/tXIeNAGwAnuaQ9Tx1CbReUGx9xsN6M6bewxLQ9YH7RJDm3RsjgUQu61mLvEUk3d8BIhVYghiKLHi1EYE73qhU6/uvkgPSwsTmDHB41FCS+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br1IvGhxx/k0hdslZtBd6m/sIKGfSUnFhmHgUgL40Mc=;
 b=WMnzXMwY83E4Bhjc4s2wDIoknRtIeOEuDPnAVTFQTqUMAF2dD2Y4twDZAodRkcwgM23pmL0HH7Jfm0Nuq+g8BoZUCoMZyLQvHilhE5o3LSxOBh0n0eA06BDq+xMIdQSd+leDSQYdqbL/+0YAGEz3ephFPZCbF9GuLp/svU4rLWM=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Wed, 11 Dec
 2019 11:59:50 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 11:59:50 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 11:59:49 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 05:59:49 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 11 Dec 2019 05:59:47 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings
Date: Wed, 11 Dec 2019 19:59:43 +0800
Message-ID: <20191211115944.23206-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(428003)(199004)(189003)(70586007)(1076003)(70206006)(86362001)(26005)(6666004)(8936002)(5660300002)(81156014)(44832011)(2906002)(6916009)(8676002)(186003)(54906003)(81166006)(426003)(36756003)(478600001)(356004)(316002)(336012)(2616005)(7696005)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1708; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9d0c388-3833-4fe1-313b-08d77e31a000
X-MS-TrafficTypeDiagnostic: DM5PR12MB1708:
X-Microsoft-Antispam-PRVS: <DM5PR12MB170870E1E3DA5C1359B70E77955A0@DM5PR12MB1708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiWiT2lawEvkFl7fzo2Y1FAE53jbbS1zZ2/UDXW6XWo4cJGjOYcnrnNktH7/NqAZQKVpyoLlzYyyCXA1USVSt/dKWt+S/ZYr3geRQ7/Pj7Ua7RViUS+qOTxWS4xcwNjhFP1rQ4+PcTjJp1+IFrYrJMhqtpsdfiFB5y9D8rPzOxNFILUYnmgL2xM64YVD2q+8dvTBsL67FdOvFA67wL5jaRYFUUdjV+wO5Yf2gl3F7kcdJuPQl0vCV55HQh7VGMJxrEucwGk0SImFincaaH14t0adJJe93kXrpOxcMGJW3mr3Lv1AK0ggw3r2FwsNBjwxfHRuATv22QRQY6CpUy8nAg1zXkpWodus0Z+GX85NRuPeXsckJVuY7st9rvgAEY3Onzvz8W8iCq2NcD0wkjh9Suey520O+W1opev/MvC/yDTqjYElV9o1mtoAJPPIP1HW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 11:59:49.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d0c388-3833-4fe1-313b-08d77e31a000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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

Change-Id: I23dabb0e706af0b5376f9749200832e894944eca
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d1e0a07060bd..e5637a6efb05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -114,8 +114,10 @@ static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CGTT_SCLK_CTRL, 0x10000000, 0x10000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL2, 0xffffffff, 0x1402002f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xffff9fff, 0x00001188),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE, 0x3fffffff, 0x08000009),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_1, 0x00400000, 0x04440000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000800, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070104),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
