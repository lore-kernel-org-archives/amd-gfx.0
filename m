Return-Path: <SRS0=THln=F2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB109C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 11:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6795322516
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 11:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6795322516
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D368B6E187;
	Tue, 22 Dec 2020 11:10:51 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17006E187
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Dec 2020 11:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaPmiOk9t3XpkPATWSjTfdrjLUstdZW/7MJ6Lb00ebjcuhNdp5hWsW4Y2YIE047l6Z3uaodMNXma2/6WWTxzSgD4nmQ1tVx09z7lKz4dlmNixsESZ1T/X5ZKP+I09yEWx3p57e8DGoivEmhUGuUCTwtjYKNv4cOZ9cyG/td/OeoUo92fXvLCRFjzWDjrwz5JON/ouWalKowijAC7w073dVegFkRu6SG0RKIBBC+hfdIkvTCNzDgS2c/kOZIYF+TNfvqoItcyfFcqh/BuAjQl6N3ArpSUI61TWVqFs4Ns2dpyyguTo7w12Iu6uXgwXYaoNKWYXZCwxA5LPNkqa3E1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew6N/xmWEpQIgkp9JnhQOMcJy2dGbQsyRavY+IB6KvA=;
 b=GkiCK5AVAG2JYpDrLHFzF6KHYlFVCfUE5ZvNFTGVCn0k8sPg5MmIb7AHOKB66UOhBwGOgNvw4oBs7ma4J/MiZEwnLsBKUWjXZ/TbuYZx33dgjkGE+IrhY/bzkGspDh8TeTDoaDLA501wEO2aXns9nic/0HEfQ7JrRsK41d8VGilM3PKGGtfS0sZeX49mxUmSMAApbnKMupfdFeP2Eqmb+jdk9YygEBzjtQy+Z3fZf4PEdEG82i4cFXnfC6VmTm5xBUwb7VfzUFLBZ111Afnvh4v8S7YZlY5nVgZdJG5rIksKqIphFc1NUMpfk1nAC+ys3L79nfltJ+Ib+PhQmdU35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew6N/xmWEpQIgkp9JnhQOMcJy2dGbQsyRavY+IB6KvA=;
 b=NaOk3EaMFPJijZ/l/dAUImAgQATyBnbrGfT/W9k5veZlt+CmvU+THY4dXp0mPjgwhsAnTuWsjTIcnJrDsQIL6MkVg6HkAAwwKTTadUuh/SJ68cLrDhJCG37u7TN7nhLjzpVpN3AW3jm125qJx0Iv9vJxjHxXrddqTiMveeSOfG8=
Received: from DM5PR15CA0054.namprd15.prod.outlook.com (2603:10b6:3:ae::16) by
 MWHPR12MB1488.namprd12.prod.outlook.com (2603:10b6:301:f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.29; Tue, 22 Dec 2020 11:10:43 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::61) by DM5PR15CA0054.outlook.office365.com
 (2603:10b6:3:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Tue, 22 Dec 2020 11:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Tue, 22 Dec 2020 11:10:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Dec
 2020 05:10:41 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Dec
 2020 05:10:41 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP
 Server id 15.1.1979.3 via Frontend Transport; Tue, 22 Dec 2020 05:10:39 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Sierra <alex.sierra@amd.com>, "Jane
 Jian" <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: drop psp ih programming for sriov guest on navi
Date: Tue, 22 Dec 2020 19:10:37 +0800
Message-ID: <20201222111037.31281-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d8ffd93-e059-48fb-7b34-08d8a66a38c4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1488:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1488BA8780CF0A9D4AFDA70CFCDF0@MWHPR12MB1488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50Via0yZBlI3NnxLIv1pBz2wvzI8RpiDv/JY6ZCRsahl6IsvZX2SAYLqrUGPBB6gjDQTKqlX4C2WvTMHrcbovtHVkKw5kapAgEsnP+vrLXW4ZgAWfhtm0nNmd86taUQ8JpsaFyPriDgBIMoWPxeT7q0F3IlzNJvstwGOCqmNtMIy/xjrfXLNmgSkjis8TvEr+vZ6KIOnwsr6RUn2NI/tcgPUeYaPnvGUQk2q6WrM5jzQgSosVsMTxzZ4+d8QsvPDBDUKgG1EvsFOG57p31bH/Mg66P6eG9WJAkoepaXRiDAxflq/ubDaOYuYMvsjC6Fjtke8PEdPhWQJhNQKxF4RTRKCk+CjPZK0E5PSHfTLY5H8W2cJSMhfMpDjvcYbV0JUOiU/M3A7udMiTN1vbFVHXzg70gIpKfgJmKHNm8bDX8Bz5QI3VzZqoRtpfOJ2/lNPBwprGqtdsJqc9yzFd8BzcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966005)(2906002)(478600001)(86362001)(110136005)(5660300002)(316002)(82310400003)(426003)(1076003)(7696005)(4326008)(8936002)(81166007)(83380400001)(36756003)(186003)(47076004)(6636002)(70586007)(70206006)(336012)(8676002)(26005)(82740400003)(356005)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 11:10:42.1110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8ffd93-e059-48fb-7b34-08d8a66a38c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1488
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the psp access ih path is not needed in navi

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Ib68bfb1b13e1cec03ec27bc9a867e2b37fc2fc8a
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 060357625504..f4e4040bbd25 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -151,14 +151,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-	if (amdgpu_sriov_vf(adev)) {
-		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
-			return -ETIMEDOUT;
-		}
-	} else {
-		WREG32(ih_regs->ih_rb_cntl, tmp);
-	}
+	WREG32(ih_regs->ih_rb_cntl, tmp);
 
 	if (enable) {
 		ih->enabled = true;
@@ -268,14 +261,7 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
 	}
-	if (amdgpu_sriov_vf(adev)) {
-		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
-			return -ETIMEDOUT;
-		}
-	} else {
-		WREG32(ih_regs->ih_rb_cntl, tmp);
-	}
+	WREG32(ih_regs->ih_rb_cntl, tmp);
 
 	if (ih == &adev->irq.ih) {
 		/* set the ih ring 0 writeback address whether it's enabled or not */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
