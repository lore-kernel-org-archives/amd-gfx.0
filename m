Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AFFC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E682078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j29mKtCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E682078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 466FD6E9AE;
	Wed, 26 Aug 2020 14:46:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA536E992
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 14:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuDcD8NtVTzovwFKK5Tmqgd/W/1JJlkr8Dmeh/4qlEQph00H44gOdwBa3XEOB/Ru1cjCW/mRebSuNXttTkUFgQT0rwalfQOkjMr6R3fZ8X+UFA/A1Oop87LnlmIk8Z3JgPdZthZLellGeLbiOCqZr+1S56p3wXaK+ccietz/dFGx0PPJkNiKLPfCKRjxiZ0aUMrwXHlX0y4OKRhdqvBwax8ZFp9GG2pTgb6zy4u//FJB6wRTkrvuuWsjWpJz5kf5RzLsFM4CwFk9HbsJXdmEmhUgO7m80Jk/MAkOzZMeFJyxiQLx8XJdeb2juCMeDcT+rZQG9IfXacjEmk5hyTNQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFxnF1TE8VXtLp6ssA2D12yw0EFkS2c7kK8Sjg0RWjQ=;
 b=Npmb9iN3EUkOsCAvQOX5ELZOHdCBbatbBPeh1v9Dabwix8mKnbUzQnd2H1QWvndriZ1Zch00CPTllv379M5XQRmRylH7zQ0F/8uC2LRv7Xmd/GpP5EUdfTtH5dY1fhfTdqe10UXsAmG5u0jmfr9VbrKg9fxNKLaSxwFVVScilgyOIZsafNAHkGitawUJfDhg6UNvWNUpnJ5jLFWFX3JHvh2FobyahlfFo7h9cld1l8miQNDvLy29pC0KtubAIemQwkdy8nm3igKeStF/CBd/+DJoZhU+mllnZJsnifxmCW3Tnhw8zPoC6uIGb/jtqu3ZaPQDV8nveuAYTAJjkQ8aUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFxnF1TE8VXtLp6ssA2D12yw0EFkS2c7kK8Sjg0RWjQ=;
 b=j29mKtCOhunGqgHoq/bXB1bwSYNxlZOBlwWYZmCtft1OQkTht9I73g62UhPJKwman+UAm//+W4i85GPKWDrpikQSeH8YBK1yLDhte9Q28RcMJw+FrIzn1LzOcfysPAGRvf9rv2845HyllugzxZxG+5lcuWMD73LlMJHAV9pVWMI=
Received: from MWHPR22CA0042.namprd22.prod.outlook.com (2603:10b6:300:69::28)
 by MN2PR12MB3919.namprd12.prod.outlook.com (2603:10b6:208:16a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 14:46:37 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::ee) by MWHPR22CA0042.outlook.office365.com
 (2603:10b6:300:69::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 14:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:46:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:36 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:36 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 26 Aug 2020 09:46:35 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: Fix SMU error failure
Date: Wed, 26 Aug 2020 10:46:19 -0400
Message-ID: <1598453182-6946-5-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b55c81fa-54a1-4d55-0b16-08d849ced590
X-MS-TrafficTypeDiagnostic: MN2PR12MB3919:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3919587906ACD49706A48BA7EA540@MN2PR12MB3919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cn4YDDxjrW97NETgrJnSQWpOnS0QWipP8K7U/L3FIyagwUuRIv7yf08OW3mjKtAu4rtUglohhYKbwEnfSmVNRsTlII7OQKujN49BIDBTtuLCQAAtsZq1yFdAtG6Jrf9APECPrhdaCAUeoj3Mt3s0mTWgDmY5zTOBAls0bsej66Q18mEYVMH2EDy5l095TZWJx9ZWKh/Xcm9faxayV3jhfrtYSXE9cgvOtZ6aE7R5jBxo+kMwY/0ixId+IfS78JkH6XSxaUh6SsNUuQZxoNoZKyK/6PsvO1R4SD/YrTAwgghyRkWPgdioXwmZppN+y3BAxYNR+/a1SuFbJsV0VbG+gRhAp/0htOSgOofJRQFTlLeSVSj/fYNld9G1FLq95OzwJqx1jfMp0Bs+eU8kq9Ghow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(7696005)(70586007)(70206006)(81166007)(336012)(2906002)(5660300002)(36756003)(83380400001)(8676002)(4326008)(8936002)(356005)(82310400002)(82740400003)(186003)(44832011)(47076004)(26005)(2616005)(6666004)(86362001)(316002)(6916009)(426003)(54906003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:46:36.6213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55c81fa-54a1-4d55-0b16-08d849ced590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3919
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wait for HW/PSP initiated ASIC reset to complete before
starting the recovery operations.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0a2130b..d9e3994 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4846,13 +4846,31 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r;
+	int r, i;
 	bool vram_lost;
+	u32 memsize;
 
 	DRM_INFO("PCI error: slot reset callback!!\n");
 
+	/* wait for asic to come out of reset */
+	msleep(500);
+
 	pci_restore_state(pdev);
 
+	/* confirm  ASIC came out of reset */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		memsize = amdgpu_asic_get_config_memsize(adev);
+
+		if (memsize != 0xffffffff)
+			break;
+		udelay(1);
+	}
+	if (memsize == 0xffffffff) {
+		r = -ETIME;
+		goto out;
+	}
+
+	/* TODO Call amdgpu_pre_asic_reset instead */
 	adev->in_dpc = true;
 	r = amdgpu_device_ip_suspend(adev);
 	adev->in_dpc = false;
@@ -4882,7 +4900,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 
 	r = amdgpu_device_fw_loading(adev);
 	if (r)
-		return r;
+		goto out;
 
 	r = amdgpu_device_ip_resume_phase2(adev);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
