Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C81C33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 11:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9831E24676
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 11:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pZqp/jUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9831E24676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F03836E388;
	Tue, 14 Jan 2020 11:42:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1393E6E373
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 11:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd1ufhOtjjsWWyf/YIPuyQz5jlFrbevt/LpAcm6O+l8hiAMyJo7w5V8dtfG6wsGXU+g1JswrNmks6/kbvzktOzpnrGkFuKO/p9vs8kSisenuQhB9LRzh4NH036mZDD/+joVKgz0ZROgjmMapw4v/VY5VTHI03CTbCSgcpevcNlSCSERyLihFoVnZSli8ZCMVX8ik605xJGdCqW1fYxt+ilJAWl6TS7/dpqbIAvFG9haX/tUcJRS3rrBMoymZFo2Mhny9zusDj9aHSWdDzSf/fpgcmrS+DvH+aEjcPPBw7Ty4xO1BjVOSBv3ZWkuHD0p0msdX5hbwCZ3TmzyXXRyfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ65WbY2XnYdfU+E4MBpEE9FftSWbk+8IFyoTnwkWr0=;
 b=j4Httmst/vH12wB7hMuctOQdPdpyuBB9b4J/F/gq2zeYJ6K6X4Ss4aLJ+ptdwat9zmAsKLN+IZFKFy9ZcxTAZ0PELA7ZL0a7EE6TkucbKonh4N62+bVCGCsgFcwM8jGBJt0pERoXaD0z8x47ZzzXILYEcn6TLBlp13Sx1mIoPExN/lTbWCrYlJzJ2Oyyw7Ktvv9qFUymr6VJxmURw/D7Ri9Ej7shSy7fJ9qCc4mChxAClL7SHMgwXCtnkZPGkbgTEUwWFi78wjm/W7GftBxEvkpfk3ARbQxskDwgEo4/kTvG403RY0vDRo8lbwsOUtiF3VwDRnhEDtr4w6ajhNOHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ65WbY2XnYdfU+E4MBpEE9FftSWbk+8IFyoTnwkWr0=;
 b=pZqp/jUOrheXyYYuFdJpZhO6qdJgzHxmn/FCu+Fqi1KMhBJzJ4D4yMKCOkrV1KwY3QrXzfyzPMj4PD16ucJKPSGDRmnWAFsmuhJwdVhm3Y5wU8MfybnAfbUYeC+49JGiPv6V5B6I+LL/+j6YHHZsSgBADcGMuglQe6WnvdMUWUs=
Received: from SN1PR12CA0100.namprd12.prod.outlook.com (2603:10b6:802:21::35)
 by MWHPR12MB1839.namprd12.prod.outlook.com (2603:10b6:300:10b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8; Tue, 14 Jan
 2020 11:42:26 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::201) by SN1PR12CA0100.outlook.office365.com
 (2603:10b6:802:21::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Tue, 14 Jan 2020 11:42:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 11:42:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 05:28:47 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 05:28:47 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 14 Jan 2020 05:28:45 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for navi14
Date: Tue, 14 Jan 2020 19:28:41 +0800
Message-ID: <20200114112841.17148-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114112841.17148-1-tianci.yin@amd.com>
References: <20200114112841.17148-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(428003)(199004)(189003)(70586007)(70206006)(316002)(5660300002)(26005)(1076003)(478600001)(44832011)(36756003)(336012)(2616005)(426003)(2906002)(186003)(86362001)(54906003)(7696005)(356004)(6666004)(4326008)(6916009)(81156014)(8676002)(81166006)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1839; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceaed8e2-44ba-44fd-df44-08d798e6d3bb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1839:
X-Microsoft-Antispam-PRVS: <MWHPR12MB183984C89125B25A710F0A8E95340@MWHPR12MB1839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 028256169F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7PF4M3Rs42TbxnczVqXVtd/wfPXbZ35/2O8mq9LwA367u0/rqBPCbSHvse/x8doPInkMpQRcSec3AY73TKwMzzWfJaUoXZlCciwOExu4o1GUhfQf2ewWauxDs+TLv61IgobEOPTtE4axp/FGLZe132ZaoZQGYwNAfICi1bEqrnApcDJd/SzwIryhleJKEymBGOHIHmFGvOdn2LspcQ8XO6yTxso3Zon765bVUPgaApsodMv3fmpTn6zqb69t+4dy3Emi8t1o7WB9oQdmWa+JUFU6QvO7bPFxz6aaToU8rGp2HFBGJhi145PvQscdPWnBjZRdglb4B7nWBvlfPPFH+X89cU4bWlkTmakWhTGqGmmeUwutOBZE2OKaKcHIu8EOH0XgWu81WoTg4QTPCj3UG2a/ewFmWjuEc+xHmGqXf6c4B/mC93DcxYM52/yu1Zj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 11:42:25.7989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaed8e2-44ba-44fd-df44-08d798e6d3bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1839
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

Change-Id: I0bbaeca184e7dc85463d6c5740151d6ba1b08c06
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4f6ffaf3f9be..3c9082b1eea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -169,7 +169,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000800, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070105),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0x001f0000, 0x00070105),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000133, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
