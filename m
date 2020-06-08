Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57026C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4B120801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dydCIm99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4B120801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82186E487;
	Mon,  8 Jun 2020 04:59:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AE06E486
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGzMBJwEteDNZDJDw1OrF3lT3RSAbHOP/qb2Dkv6jFws6blWaEer2on8o1TNnq5THAuS6NV4ujVO8fpB8GQTLQqJuwzPZDo9QlrjBGSHdvhGsKlzBGboXNkYLtFSsmwZ/M7VZ+rymYeW43Q6POdAnBCe5v7frzIUkr18865584NMwMqyW+9eFJHeAragjisNf9fS6o/9Hw82TLdpkZp80AUxePNN6vAxfYrQNtFGzsVwSAh0Qh2nXoGVSwB3aX1COZpI24A2IopNReq3tQPKbTcRQwl81ViR5WD/BM7LlmU8MB2lzUowhKw9i8gwuaaAwu6cXHJop1G/JqWXW+u6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J8hk3C6AJZlG801evVlcIwV8bAgCh63hu3DaPGvxWc=;
 b=WRGRLI6uIgMbOPK9ZpUu61z+4T+CKWIAuNEQKXay2foZNTRe8KhbM4d2zAktCgVpuXOCnUcZ9/TMx0s0AOVIOXLG/vTvaFrthmPURjjgIVy1Pg0TtprPGSp0m5UxifkNxaxUAedSMOexmCFOsJvIwZqfG4Iv5D3CsQ+jZay9RuHfpeZ1c+mhevbBYWgbGX3zxa1inIzznAK5mySKEKpdDpL+HAeGgz7Dq6LXB8NvZ4MK7BH9SPa2XYbSdWZQxE+XSiC5IRCV5xhGFz+gbxLbXTaAVbcBf11nivVd0LyMgupAFSLZ6jhpiJn2kFukAHP1NGGisXGNPez09yMu/aj7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J8hk3C6AJZlG801evVlcIwV8bAgCh63hu3DaPGvxWc=;
 b=dydCIm99/dOVIVQNtR/kjZV67zPMROcX1LQrAclaQNUM+E+sRlF/udRFVChpK/TFDzzjMyAcS+vEfqoc66OnhaYStlRV2ejau9frw14xHhEDACfkov21SQf55S/POn2SIF0vJsnphc0JQHD0Mr5wSnOU2K1wssHDGQGe8PE+2tI=
Received: from CO1PR15CA0103.namprd15.prod.outlook.com (2603:10b6:101:21::23)
 by DM6PR12MB2713.namprd12.prod.outlook.com (2603:10b6:5:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 04:59:38 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::9f) by CO1PR15CA0103.outlook.office365.com
 (2603:10b6:101:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:37 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:32 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:32 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/28] drm/amd/display: Remove unused macro from dcn21
Date: Mon, 8 Jun 2020 00:59:05 -0400
Message-ID: <20200608045926.17197-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966005)(4326008)(186003)(36756003)(70206006)(70586007)(6916009)(26005)(54906003)(6666004)(478600001)(82310400002)(81166007)(356005)(44832011)(83380400001)(8676002)(47076004)(1076003)(5660300002)(82740400003)(8936002)(86362001)(336012)(4744005)(2616005)(2906002)(426003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddbd9568-4017-4db2-721f-08d80b68bef9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2713:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27132844FFF3E2526215595BFB850@DM6PR12MB2713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/4o/tuk8jFzPOwysgFONmaWigpRhdOLSNNRgHz6W7G6A+j6PloZIjX0ynnhe55sys+mWAMhFZEIpqxOiuIZhQopy6mZm56e1U8uOlLofs9s71xkkYhBkaCwqj6WHJHMC5ifzC/8XF5kXmGA26h6vWRCfq2S6LoGGu0LA+UPvRs18XVE22Pb7NoDk4R4MphXqW03cQSW+lNNpqySt+AaZoSLNcFdrziWN/PuOQ8Q2ZGxBrdveeh5g/HHUUKXxFEGhFXFaD8kpPE+8viF3aNvEae7fAlJa84TGPz6fC4rdzGKiUiSiILjRVzHca/XBU4XubHeNF6K/zDPfXNOdZypiA93pChMQo0f9a+Ki5m4cpfBRPVMaBa1Eph8pswB+74t0rSdcWiZoGrAB4FQFSh8NQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:37.9849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbd9568-4017-4db2-721f-08d80b68bef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2713
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <Roman.Li@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
SOC_BOUNDING_BOX_VALID is unused and not required for dcn21.

[How]
Remove it.

Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 00436654c584..24aa3f1db031 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -88,7 +88,6 @@
 #include "dce/dmub_psr.h"
 #include "dce/dmub_abm.h"
 
-#define SOC_BOUNDING_BOX_VALID false
 #define DC_LOGGER_INIT(logger)
 
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
