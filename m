Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09CC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 06:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A5C20735
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 06:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g0niNi10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A5C20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C23F6E192;
	Mon, 13 Apr 2020 06:58:30 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700049.outbound.protection.outlook.com [40.107.70.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0E46E1A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 06:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFjIHzMw0eGMO4lCJmnT3t1dd+Bh9kDca4wDZzh2Hku321RcXZoqAlgUW9DX3PpmmXmhxV5Uww1FmBBmkJLKjz6M8pc/gZPMazto8WYT6RFDvuJ5OgSazWpq2Pxzy7a+d7H+knFTAfkRXX0a99ewFOUEGP0BRL04UeLnaEEPUEvymuPsPSgJxx7fTpIqVGGEkUcN/tUyP+nqUoGnASP/r80ovQ9k0FQ2tW5A7VM0NeMX/sEcwhzjOgm0e+rwTPf+G/CVMEyHi54GahHpBDva3XfoAnzPriqzaGzWMSvNipr+hg5YxYyOHWu/D7NS1zFHCfoDDwDQDr5irBnMcYiNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc3GWKAlWgXZGH9kWs7dXIj8Zr9QUynipRNiW52OYYU=;
 b=jJMwkadp9U+UDCSyt2InfK1S5bK/pUc8y/HwPq57T4xW6Zft7TCtGT6c89CF2N9T3abkWhhYR1z+EtmnrSVFB03bJ+7vHf3wprUdOwY421uILNzrYPt9QVVUVmCHFAyhjRbJkO89ic1Y98X/CZfoa9NCY/ovcb15lo/iGHxdr7vr+pefca22bPkBT5HD10QZ1SQk/ZDmltA/OnM/7PFxx6ZTb0IYBWXuRrncuShg1+lPgQjqszy1ZWaTHSvNlmM2XicQDgRqeQnwnxXCrV5YRgDvIm3rZuo4NmX8cfOOOYhbnbHmLNxCbxUIXXuADaF/wLsnzIpAuUDEGnF+WGfubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc3GWKAlWgXZGH9kWs7dXIj8Zr9QUynipRNiW52OYYU=;
 b=g0niNi10VWrVGUYf4N3xuuemfTUTmzGzumeq6egHu0xTHzyx+Y2oJiIQfD2TlNm9DU7axIuNo7fs3pATeTmJqGFJvDPBWnJShmmedQp5U1TR6Mqf2/sMPVg6+3Lew3m3N8j47uzDRIOB4CWNQhDPiMAmRJ/f7QH5tzxq0lcitOM=
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by DM6PR12MB3722.namprd12.prod.outlook.com (2603:10b6:5:1c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 06:58:26 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::c1) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Mon, 13 Apr 2020 06:58:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2900.18 via Frontend Transport; Mon, 13 Apr 2020 06:58:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Apr
 2020 01:58:25 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Apr
 2020 01:58:25 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 13 Apr 2020 01:58:24 -0500
From: Yintian Tao <yttao@amd.com>
To: <monk.liu@amd.com>
Subject: [PATCH] drm/amdgpu: resume kiq access debugfs
Date: Mon, 13 Apr 2020 14:58:21 +0800
Message-ID: <20200413065821.7409-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(428003)(46966005)(478600001)(36756003)(5660300002)(81166007)(47076004)(356005)(82740400003)(6636002)(6666004)(2616005)(54906003)(37006003)(2906002)(7696005)(70206006)(26005)(81156014)(8676002)(186003)(426003)(316002)(4326008)(336012)(70586007)(1076003)(6862004)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a753c40e-eadd-41f5-4a5e-08d7df781027
X-MS-TrafficTypeDiagnostic: DM6PR12MB3722:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37227D8D0029B331F400A9F7E5DD0@DM6PR12MB3722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 037291602B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/BFYxtgZr24DGkuX0iabOdsnVq2A3Ri4i3RCAZFuTE5Z4ykq37OnVAz2mNjNqF2bNo45/zM9ptGC6YrQn7k4SvVf4ii8QZ+sW6RMPZK5QfpLrUuuc8Rvq4xwBbWwKnCHEKDT8WRxCJFYJ6v3L/+Zp4+hAbIdJY6vvZpE/aWqI2+gb6XCCCaNlckyRPBAf1QCSHhRd2GQLWbb1BZUIFKJnILESv9PDhaNb6dPzbxLho2AFJGysRzYS5xHCVfmr9KWmVK1iiCMEnMaQ15f0FjYGXgckpCyQNzMHbjUDTC4lVoGDs7766eCen7SiQWe8lAz0The94dNB5JjWeqqPF+GBPWcr6t9HNYFu6KbX/Mq2xiO+1tXniMnbsVxOsr9McgirrT067RU2kSh8GpfKk/hVUlTel/UsWX2fc5HAA4l7P38EvgSRLNlhmne1KQR3sCfG/cillRDqfAhHbxFdkC6XeVK13UJZ+aoVzxbZeudYeg6O+nNhBgs9mZkvsIpK4pFznkrWPZEEIepOsgLIxRVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 06:58:25.5854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a753c40e-eadd-41f5-4a5e-08d7df781027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3722
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If there is no GPU hang, user still can access
debugfs through kiq.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6a81c2ee7c7b..8c10084f44ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -335,17 +335,23 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 	}
 }
 
-bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev)
+bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
 {
 	return amdgpu_sriov_is_debug(adev) ? true : false;
 }
 
+bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev)
+{
+	return amdgpu_sriov_is_normal(adev) ? true : false;
+}
+
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)
 {
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev) ||
+	    amdgpu_virt_access_debugfs_is_kiq(adev))
 		return 0;
 
-	if (amdgpu_virt_can_access_debugfs(adev))
+	if (amdgpu_virt_access_debugfs_is_mmio(adev))
 		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
 	else
 		return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 8f20e6dbd7a9..de27308802c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -299,6 +299,8 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
 #define amdgpu_sriov_is_debug(adev) \
 	((!adev->in_gpu_reset) && adev->virt.tdr_debug)
+#define amdgpu_sriov_is_normal(adev) \
+	((!adev->in_gpu_reset) && (!adev->virt.tdr_debug))
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
