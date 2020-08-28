Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93CEC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3F8207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nMBf6l8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3F8207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5CBD6E4CB;
	Fri, 28 Aug 2020 16:06:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A616E4CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 16:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzseWx3b/DJGMBqlkveiKIOJ+BDBcLu1E5H+AGdaYhd/VCXWSpgaFlUaZFWXSHifmBa+3mLmDrZza+c2JrCkwQidvQT5Tj+fU0zRs0ich+0MmOol3K7VnHh6B1ISujfHxEqQIhFIrjlPtXvNDNdYtqfWyUAmdL/eyB1FLT7J5O+z4Vcgus4564iN9fmemQoXyRxJjji6A2JZhAgFLnoIXFnppH8lvXC5+IM+qEbxlozT3qNQkUmNLbe3Kya0dSEB9crLIsA2LQu7dBT0bfc4HoVQ0u/MqMAVR5rkqbvJq43YnRquI7ke9cn0KVNzWM1cHWWeuX/mcr+PMKZeHIPeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho4zidE3NOg6Uh0RuNDG/KNYxn2HNDOVTc5qCC/RMYM=;
 b=RrEIU/R8Z3Bg72U9sQDxCRJHhkA9StcEst5Z/l3nTya0fmLqa6a21LkW7JSY4aNMXeHSDVKOf7ByXNQ8jntdJLyGZT/yzZGZjpngBjYutgoziyOCxBbfZqw59aOMsgnDFzp3o8SZqzYmgGZTDzrCe39H7iqbFSCFpVzQ0Ma0SOqvJhUAocpTrvOCWsyYPY7lO8wKIUwVpWOz6mwRIez5bEwvclPkbr4BpuicNphz5Pdci0vWpweh9gNQ+X0og3Xtwd4Ga81Vl3eNUpxIv30HoqnbsBBMOd+UK4O+jPB2BZaTdmXcM+67sENTDXqMt9AogQ5vZPscdFweDJz8PvAinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho4zidE3NOg6Uh0RuNDG/KNYxn2HNDOVTc5qCC/RMYM=;
 b=nMBf6l8FOR0vD5eOSZnRgKEHtqGjfcXO6UDaeISmj3HGK1O+px9tQD29WYBM/mznFfs9tC0LgyQyFxd5eHnu2U9hzWhY6hmA4sejga+LdFS+xYwvSgYv4ClV7GzMSZ6bT6MIAS8d71n5LhQpn2VGUnEaG3e2pvP0lvTb4rFqLZk=
Received: from MWHPR18CA0039.namprd18.prod.outlook.com (2603:10b6:320:31::25)
 by BN6PR1201MB2481.namprd12.prod.outlook.com (2603:10b6:404:a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 16:06:01 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::a2) by MWHPR18CA0039.outlook.office365.com
 (2603:10b6:320:31::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 16:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:06:00 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 28 Aug
 2020 11:05:57 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 28 Aug 2020 11:05:56 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/7] drm/amdgpu: Fix SMU error failure
Date: Fri, 28 Aug 2020 12:05:40 -0400
Message-ID: <1598630743-21155-5-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f8f2508-841d-4311-321b-08d84b6c41e1
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2481:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2481183B2948EB555EFE4928EA520@BN6PR1201MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZohIxKS57eVcxoF0UFfN3kZv673a2bzJo0xwzHV5urR1S6weVkbdmP8gwIFvnVS45Y/kqYIEEq0jFNmctOG7Jb0s7f7lfZ3YZ7JLIKdCf1AF3u5DRUED9n5bMsk1CE1GdqQ00IdXSsju8pCHv0MpvlIBdELKbdB1Yo6+rKkTHL1g6Hy1C1oi/i3RkpHEiVPa2zvBIra7wwnJd3PoiOaGwfaMpPnrTulCvrbSKvn86q/y4W+onJ2BkSarXHq2n6COd3c5VBJnjvcY9icvFs89Ho5LlVO10fW4r5zTz3QOCPkGJv0AGeBkpPXud5CQkF41VJxfBmfFYyiDmm9PCasqvNJXjzgxr/m4Fz3qLt2lhoEsVzV09TniE6rGIry63NiqZSFP26tt9b6CC14y5rGJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966005)(6666004)(70206006)(186003)(7696005)(70586007)(26005)(82740400003)(4326008)(86362001)(47076004)(81166007)(6916009)(44832011)(83380400001)(2906002)(336012)(2616005)(426003)(8676002)(82310400002)(356005)(316002)(36756003)(5660300002)(478600001)(54906003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:06:00.5184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8f2508-841d-4311-321b-08d84b6c41e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2481
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
 nirmodas@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wait for HW/PSP initiated ASIC reset to complete before
starting the recovery operations.

v2: Remove typo

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9a367a8..06664a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4844,14 +4844,32 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
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
 
-	adev->in_pci_err_recovery = true;
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
+	adev->in_pci_err_recovery = true;	
 	r = amdgpu_device_ip_suspend(adev);
 	adev->in_pci_err_recovery = false;
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
