Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53181C2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252CE20672
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EfuLPqEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252CE20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C97886E1B2;
	Fri,  3 Jan 2020 09:59:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6376E1B2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlCpoF54ZCCpAFw4g2FpjULAddjWsO5XLl1lEo4jQsW9FfI7jwsloDwY7juaMtCRTSGfWJ42avVlO7GJcFaw/L6L0x5hA7idR38l7VvXA7cV3NH6t/uKdr1K8KFWDV0HOBux/I3dQ9kK3BWvWrQupM9hnFmApVj1VGaOUkqTyGdQJCRkev3Zir0A3wigJ0FuxjIstBdff0v5UQUMeEuf1nfbylLK/GSBDK6SSEdgorXDuqrIL8KuZxRlT1jUB4Ptclbgg7IiJKJ90Ddnc0idV8CyBKZ+gpemv7DUmKT8r1i+BrJhFvLdSt52E7g0Epi0sZ4qUi5DaPHEZ0y8RH4nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMMwg7jgG/QIF1VgVZ4zDzK5aWQPfcWM8prignye4XY=;
 b=T4g+WAM0S2vSEdvzTqaNXhWT+rwYi30yMR1mNa4kM1btEj650wChOg7jWLem5hlvBNpBbu4LslMvfVmDZ1RSwU1puZS+F2LT4GX9IMbF33FaZz3Kv2RuogU5kZLfgk3gVIqzXd0/34s8sQkAGPeAenFVNEcTycOP8BLUSrL4nf/ukxBfLjYSjICFLJqXNNuITb9abZx0gBPUt4F4U2Yc+6yJVtPD9DJvz/Ww31vC1pYsfCcoyStNucOTahk3+G0GQu+ZvZ724d565m7baXdH7cIRhHNxqKEk6TzNDqEWsYpC11GB5UO5NQuRM7JHyZCSefrnS5D8FQ3HNrQgQ8satQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMMwg7jgG/QIF1VgVZ4zDzK5aWQPfcWM8prignye4XY=;
 b=EfuLPqEFk/EYnPXetcAEatoZywVWtoT8WhWcYxigiqNx4VFyjvJBgVCIo+cWDiyCQS8Zwdpu605AIRxbnzV9sogBJsH/13ZmsRyPWJWKx3Qv3lto9Cb5L9vahhGIvQZ5eQuyle3pSG5FXz1LlXar6nmYIud2OzAKL+LCHjE00NQ=
Received: from DM6PR12CA0022.namprd12.prod.outlook.com (2603:10b6:5:1c0::35)
 by BN6PR1201MB0129.namprd12.prod.outlook.com (2603:10b6:405:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Fri, 3 Jan
 2020 09:59:03 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::205) by DM6PR12CA0022.outlook.office365.com
 (2603:10b6:5:1c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Fri, 3 Jan 2020 09:59:03 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Fri, 3 Jan 2020 09:59:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 03:59:02 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 03:59:02 -0600
Received: from guest.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 3 Jan 2020 03:58:55 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Leo.Liu@amd.com>
Subject: [PATCH 4/5] drm/amd/amdgpu: L1 Policy(4/5) - removed
 SPI_GDBG_TRAP_CONFIG from VF
Date: Fri, 3 Jan 2020 17:56:48 +0800
Message-ID: <20200103095649.5068-4-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103095649.5068-1-Jane.Jian@amd.com>
References: <20200103095649.5068-1-Jane.Jian@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(428003)(189003)(199004)(356004)(81166006)(478600001)(426003)(26005)(316002)(70206006)(186003)(70586007)(6666004)(36756003)(8936002)(110136005)(81156014)(54906003)(6636002)(7696005)(8676002)(5660300002)(1076003)(86362001)(2906002)(4326008)(336012)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0129; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15a7a2db-3c02-41fe-3e8e-08d790338fd4
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0129:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0129C8556164F8B2AAF4B610FF230@BN6PR1201MB0129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXtI3HgivLETfSvxQs8ld4CiRNaC3Ybnqd/s27woF0/VWA7RPoOSZZH2zQ9ABd62ZyQOr0oWJ8Hv09SS1izfOGtCgbFYqKh98indnQOl6pSUXmrDXNAcDa06Nnnf6r2qtrg7JoMbKyLCQUSoZWGqom2eGOVwtOw6ePy8z9bn5pThZ2R3mmoYf6Ls6svY2VT2WLrtAvanNdpxFszuNLz/Q/++C21qnzuZpd5zhFpvnNTREORlLgIO2U9A5rqIvgxVcod0XR99WujFZqrxB4wz6g6A3kfC31TrNk8H/MhI2ntY899uENUKGdEykNAfXAMj/qzG6He7PziRa2ZWozjjkJgdHjNZ6q0vlWmdF+QlBt0J7gp/nu5FaqzYfamNgehrpdvd26PFw7QS78SmEx0m3e+jp5Wkf/T6V3bxPLBGCQNGsItigf7SO6zG+pENX3MD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 09:59:02.6577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a7a2db-3c02-41fe-3e8e-08d790338fd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0129
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
Cc: Zhigang Luo <zhigang.luo@amd.com>, Jane Jian <jane.jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhigang Luo <zhigang.luo@amd.com>

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Jane Jian <jane.jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 35384f543664..bf02ca198283 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2252,6 +2252,19 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
+
+	if (!amdgpu_sriov_vf(adev)) {
+		data = 0;
+		data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+				VMID_SEL, trap_config_vmid_mask);
+		data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+				TRAP_EN, 1);
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
+
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+	}
 }
 
 static void gfx_v9_0_init_gds_vmid(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
