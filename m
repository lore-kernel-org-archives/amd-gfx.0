Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF0C33CAD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 10:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA1B2080D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 10:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BPNjSAyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA1B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E15789F85;
	Mon, 13 Jan 2020 10:17:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7724389D9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 10:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH55eFGSMYjS4JcWJoxwIx15nagR6gxTP4U68j4eD7lb2yAAWI058WPAGeXhT9tT/AdTIxDohygTdslC7oHBJKjBcidJjSDP/6J97+2emZp7MdEXNKRrOK0m2WBX3rScF40auwlv7OBgag3HdUX8RbfjHAtEqzgCuwA97sljHccdhKwKUlbJE1w8QfLkuh6Z9VpidlGywLjsw7gZWJzb9KskIvjhJhsQFpILgQ7qgEwtSzV13c7KQlzXeMbZ18lWV6ujfPb0dIGiKeFamtoImMldOsYkodyfexy2yN8U1iji/GU33i+FfqIxlnXcy2I+D4NEUXwR1R8GkE0mJIc0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hehu9yb0rDmsecMVeOP/w0VCrJd9dqKgQzZCcwbUGqw=;
 b=WkAzioY6fgbUTI00BELuk2LpYY87fr1RwoAsKkpeXxkjpebP0FK0+RpxAN7mLzsyAqceZuCDFwwSuKrX3sEV2y+hKsvQLwPgcYoEK/0s5oMmw+uYyb0U8usP5Jame5j8ssL3jxNAeyaZZr9WXeTOUjTnw5Upb/r6QlyKtVeYLT/8BOyFH4kThK/nZYSVkn5VsruCffLM7ADHxF63LhhctgZfZY2lXZjHiZJ5+wPLSKYL2EGkIA0JHO6GrP+lxNvzBHli6/xagxyXb41y+cE1vESmxHXlJxqsxWo28OCb6EFwANq8CRdE9n097KaFCUvaHnZxGzdj5GrzJHnshgKepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hehu9yb0rDmsecMVeOP/w0VCrJd9dqKgQzZCcwbUGqw=;
 b=BPNjSAyHXOITZWwY4gIKgIyKPvK/5x/YkQVoyJaSt0kTfua8XI2T3zwNhSaVNj3yG2LFROf8/qzp/1Rk7IgrzDb/QwKxZlPZ1aDj9gdrJetKPLZte53EPDwnVbaQCnep7jpAZzmNdKCbvCIvJRgI2N0+82YUtjCE0VagmZ/TgUE=
Received: from MWHPR12CA0061.namprd12.prod.outlook.com (2603:10b6:300:103::23)
 by BYAPR12MB3159.namprd12.prod.outlook.com (2603:10b6:a03:134::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Mon, 13 Jan
 2020 10:17:41 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by MWHPR12CA0061.outlook.office365.com
 (2603:10b6:300:103::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11 via Frontend
 Transport; Mon, 13 Jan 2020 10:17:41 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 10:17:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jan
 2020 04:16:39 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jan
 2020 04:16:33 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 04:16:32 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add kiq version interface for RREG32
Date: Mon, 13 Jan 2020 18:16:21 +0800
Message-ID: <1578910582-4505-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(428003)(189003)(199004)(86362001)(5660300002)(8676002)(336012)(26005)(426003)(2616005)(316002)(36756003)(2906002)(186003)(6916009)(4326008)(6666004)(356004)(7696005)(81156014)(81166006)(8936002)(70206006)(478600001)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3159; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd3aed5c-1b2d-460d-ab56-08d79811d2a6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3159:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3159A0691191D85960D8EAFE9D350@BYAPR12MB3159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2iMI1SLsuTK6W31ijKRPEY9ahCoZhHLeCvUzc/4b1nbeeTO+LUzQ0/pjumdZrzWYn+xo3yfgAE0XJHJLIDmoeOUiJrwIjI2+0tkTdqWXp7x+WugEoy3qtwjkV9xFLyHcie66T6s+UsXEpC4rPo0Fg66jZpiPdFTURg2AmGgWRPqdqKb/Es2a2lloZ3gp+Jx66ACPly8w0YaIJQjWoz9YKs0txehlrQtKeRfGj3sxruvbf3VsAAr5ksvU/A3+9vnZg5HDgDVuGR9hekzAnUOtQQ2FU2MSQDHUFu3yop/dkHNP8is9NGGJI7uNqDbPCpbp4leS6RVGDXJOjnpkTQMOYwHUYap9/c18sQ5fMRkydbzjBYtUFE0ne6SkBKfwLWeuUROOLcf7wVuiTbfM0YAofiJLMWHqafqLOGFNUjam7WDH+rfNt4IkyiOky5Tb0sZi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 10:17:40.9797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3aed5c-1b2d-460d-ab56-08d79811d2a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3159
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reading some registers by mmio will result in hang when GPU is in
"gfxoff" state.

This problem can be solved by GPU in "ring command packages" way.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 63eab0c..92c5ee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1016,10 +1016,13 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define AMDGPU_REGS_IDX       (1<<0)
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
+#define AMDGPU_REGS_KIQ       (1<<2)
 
 #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
+#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ)
+
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2c64d2a..4045b56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -217,7 +217,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
+	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_virt_kiq_rreg(adev, reg);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
