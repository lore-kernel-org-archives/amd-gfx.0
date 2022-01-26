Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E266FC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 04:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022DF10E517;
	Wed, 26 Jan 2022 04:09:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E0910E512
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 04:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkSjIKGD/XxFzFPz39UtEaxq112k0cZajajYFRMJpEnkcU7EziXj2SZySQR8XxXfLBCBvfoyDVsyXp3mmECah6QZCXGqgeL0wbrnjZG8Dju0Mssc3ToB0A5jUBnEmd4IBrbSRSK7QKpPH4Y9j/nt2FJbSQAiMTWaQ53jsDGnSU1rPOpvE2hjJFQ0ZfA5SZNg/rbXN7oUYJ0P9kJ5N0jx4hMih4nTvtBt9zZDkXF3rnuCmpfyuS/TIV4YG7W3a7LpxTA+CFJohjT6qAdumZhrHW9/72ZsJm/Et2aGSA5u2b1WUQPNE+3A5kYwt8WrDVuyuqSWR4zBwyQTxiWfn//WHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvxY0Wk1inb8c8Ax/RU7oE++pYRNFoiBEda5jiJnj6A=;
 b=ajQD43Wck71kYCnqdCjLBD5cpmFO5WV04cHlnR7e7C5UvGe5fFHq4uQR/+PnrY0nSczcumgkI7ZdnmpCYK6LRnkJyC0YIve4DX8IUupyg/ggbJpzAD93K63aGWApMN7PCbKQoSDbiB8yYgs7XaooRHSL3xm0GZqekOTei1o6N0rzlrH2xTTOVf0HGsnh+7nuVc4wKerPHSA/Ye/2J4cK9a9eCQ1zk7Fy3NVZyN5qugLMIcfREg9n4waw/LEqQNAL0tN3QBqmlTpvLJjz8D48QQaGCEpnCP394v/8VnpafldA1DvGC5KN1t0V9ugutDN+gZ3x9+bDkrqTAV8sSjdZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvxY0Wk1inb8c8Ax/RU7oE++pYRNFoiBEda5jiJnj6A=;
 b=e1SVA046yhAqB6AA2QTb2BhGes0J9jjj91SuAGHKqaEikvokhtqL8a6KaGCE1v30ANHXMgj3UtlwhRe7rRPrVpOx9UtNDTd7LU9b+TIGvhjRLjKeSqqCThvyCYQEidcDLNOxtzh22hb8ixmQpE11unaZzVJOcUu90Hnn3XrP77c=
Received: from DM6PR06CA0034.namprd06.prod.outlook.com (2603:10b6:5:120::47)
 by MWHPR1201MB0013.namprd12.prod.outlook.com (2603:10b6:300:e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Wed, 26 Jan
 2022 04:09:43 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::5b) by DM6PR06CA0034.outlook.office365.com
 (2603:10b6:5:120::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Wed, 26 Jan 2022 04:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 04:09:42 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 22:09:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 3/4] drm/amd: Only run s3 or s0ix if system is configured
 properly
Date: Tue, 25 Jan 2022 22:09:43 -0600
Message-ID: <20220126040944.4324-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126040944.4324-1-mario.limonciello@amd.com>
References: <20220126040944.4324-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b47cb12-5ced-4e08-7a2e-08d9e081ae28
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0013:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0013DB659A287AB203513FBAE2209@MWHPR1201MB0013.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0mMhGoy5qqCOF4cRAD44ClFEQRKadS7s0eF1Rp12hbxlao9Rf5aSjJekUO08oB7gCfntqm8SDKAy8sOQkhb3cm4DGE2NW8EvqI1JeXpBdfuO+P6vAzN++atvdyNFQGbqQCOaD3eZW/EI5df8bZ3r/gBDkzsqw0l8UVswupu8vAwHUVgzhoh/ypxkqVLkjhR4dFEsG6UJEkRzXAEVbGyefkxnj8fWT5usxCXry1A+5/krPfjm20ppJcR7KCGGCZIbqCt0qtaoO9bF+uLhqoL5QMzkCe/ZBc2G17MrcdJt2n6vu6MBw8XJF+nXF1j5sGKngULqySz+M4/gHxR4BZy6PGXsFOYM8FZeBc1TtayIAolvqEpFLUZ7Y9fouO/cyGfxx7g7dtvOGHEo+bpFbMCYc2IfdDhL/gASyQtXXLcNCO3qtWWW8ImxNOJxWIm2YdkXz8u0k0QBvkAnoi35fksughHEcVxSgxbtqdNYuanvfaxcTbCu/RQAS0y5EJzKnzVB+clnFbGG0UffnztTesI2OTMEs3EoyIT5pnJDZMiNmrSomQ1GKsdyTzVB4rsv061bhx/li+dMM6UZ3ecIxDfGIYKhzo8Kk19LRMPJtfDFemC+c1jVEk6gcZN58LwA61MScWbyBuElhckTDygplKiqTOjM8CPM1uJ8x210cdX9PZ2cWfJbIiybhIXOhIPk4ssEaOQhNNtB6knI3z7sWyz25s6kqakStusjclqiEt6RONrYBTGArupXTqfXJ8bWyYLE4KGa5ls9g+XNDdeCAYA36qYsyhxPKNPdSMmTHNfGaX5LrthblFK77RNnqoV+wMy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(6916009)(86362001)(356005)(81166007)(70206006)(316002)(2906002)(54906003)(36860700001)(336012)(40460700003)(508600001)(8936002)(83380400001)(4326008)(47076005)(16526019)(36756003)(186003)(2616005)(82310400004)(5660300002)(1076003)(426003)(8676002)(70586007)(44832011)(26005)(7696005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 04:09:42.6145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b47cb12-5ced-4e08-7a2e-08d9e081ae28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0013
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
Cc: prike.liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will cause misconfigured systems to not run the GPU suspend
routines.

* In APUs that are properly configured system will go into s2idle.
* In APUs that are intended to be S3 but user selects
  s2idle the GPU will stay fully powered for the suspend.
* In APUs that are intended to be s2idle and system misconfigured
  the GPU will stay fully powered for the suspend.
* In systems that are intended to be s2idle, but AMD dGPU is also
  present, the dGPU will go through S3

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b0a620c26ae2..123ec5a07dd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2309,17 +2309,19 @@ static int amdgpu_pmops_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int r;
+	int r = 0;
 
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
-	else
+	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
-	r = amdgpu_device_suspend(drm_dev, true);
-	if (r)
-		return r;
-	if (!adev->in_s0ix)
-		r = amdgpu_asic_reset(adev);
+	if (adev->in_s0ix || adev->in_s3) {
+		r = amdgpu_device_suspend(drm_dev, true);
+		if (r)
+			return r;
+		if (!adev->in_s0ix)
+			r = amdgpu_asic_reset(adev);
+	}
 	return r;
 }
 
@@ -2327,17 +2329,17 @@ static int amdgpu_pmops_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int r;
+	int r = 0;
 
 	/* Avoids registers access if device is physically gone */
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
 
-	r = amdgpu_device_resume(drm_dev, true);
-	if (amdgpu_acpi_is_s0ix_active(adev))
+	if (adev->in_s0ix || adev->in_s3) {
+		r = amdgpu_device_resume(drm_dev, true);
 		adev->in_s0ix = false;
-	else
 		adev->in_s3 = false;
+	}
 	return r;
 }
 
-- 
2.25.1

