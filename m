Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E98C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A9C206F7
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kz5wcyKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A9C206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 745976E5C6;
	Tue,  7 Apr 2020 08:14:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190C26E5C6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 08:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5Cr2ylu6V9VvERMJVqrPtvxsQgrn8rP9eAwC2IFsrIABmelB/FgotAhvUy6PdCidZD1O+HLio9GSNbjnrthqmlGwPVlKkeR6UDPsai7/QAwgjuKR1CkdBAh/6uRocophyQD3XvVdgbIKGHEgPYQTC33Q9FCrIRvLc9N2iA248Sqwe0xKJED8+sx+OE4ejRXS8OfRRrtWdDxdCabl96IUu8OjW6smL+qwuHWl0xGUiEwlw/IXmLDfNClzpgK/cibAPbt1SprNb5m90ZBDoLA06B2GOdLehd2Hn/9d2eKknQQuC7vBiWcgqzr16mJSCSUNxlGXrIo8M0pFAVW9XtySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyCFn3/9aJhwEDUeVu86aRiSlzmPQLgpgDqgHE3d3p4=;
 b=j8UF5UzASf5+GiolX7p+iHIUcq0MeYZciIr+YzgrzKPUrK4G31GYfNI/3jRQTRDrn+oCguJej6LvG42mjLjE2XRkNBCSYr+IYL1nPFjMQijQCWDJqgAkTcWmLgBa3DVKGpxfmAAHwCKgk/17/WFgbrFeq4nsE37rPtH2jdVeBLHkX6FEESzKqqpj8/fkugFl/igLkiz6Z1SnB7WiX36PAwouyg8P13xabK3sdQBIVfk2CVTJskK4oFuQ5+FebUBnor68/jy0S50jYnv/vLOygfbHf1eDWLOXC/ckqKICAEiP7r0QUkdcvkk6mwW//8Ta1uJ9JlzcJTxfqFy1v7DTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyCFn3/9aJhwEDUeVu86aRiSlzmPQLgpgDqgHE3d3p4=;
 b=kz5wcyKFfQpqHdQRaHLCtfWxIpC2dFxKhmav0P+5K3GT7vnXLKfZuzwpP7wcRhlonPnvzVOhGw7Y5fcVV4H/siqgOGs9IwUswut3h7MoKLca4UlSg/+HTkOW/OvD+vhWvb+WvPiFP976HaVeaulFHhFKkoTwbq/YBD9GYGlhgE8=
Received: from BL0PR02CA0068.namprd02.prod.outlook.com (2603:10b6:207:3d::45)
 by BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Tue, 7 Apr
 2020 08:14:00 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:207:3d:cafe::fb) by BL0PR02CA0068.outlook.office365.com
 (2603:10b6:207:3d::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17 via Frontend
 Transport; Tue, 7 Apr 2020 08:14:00 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 08:14:00 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 03:14:00 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 03:13:58 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd Avoid destroy hqd when GPU is on reset
Date: Tue, 7 Apr 2020 16:13:55 +0800
Message-ID: <1586247235-778-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(428003)(46966005)(86362001)(7696005)(2616005)(316002)(186003)(6916009)(82740400003)(2906002)(70586007)(6666004)(356004)(26005)(70206006)(8936002)(81166006)(5660300002)(4326008)(81156014)(478600001)(426003)(36756003)(336012)(47076004)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 807ed050-3a2b-407a-caee-08d7dacba0cc
X-MS-TrafficTypeDiagnostic: BL0PR12MB2436:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2436F2CC336F06653CDC9345BBC30@BL0PR12MB2436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFx0zmbgOSpA3jJSYYVP/xGUip8PpNGtEkRhfnxl1wbtXz1NQt2lHrypn8gYEVf+kdmx827LT3oir37j7qR2vKuDD0VOW3V6dFSuuBZ7eD3IZjU6ML8h0Sb/P92wRWkHHlCn2xvuX1kcAbApHtDoqv8+chCitoi9Gc1hXyNssLXzB3HSXNeGh2IMzXQGSouPE0oVkt+x0INR3bjBW8Jm/4f11y7XTtZqIqgWyAt//cxn4fobpM0CqMdg6I+oPQAZsLb8FVc7zcqzxkYQcpUZNV2hBTJNAOAN4YNWnHYqQXAfi1MQNYdBQ/g9BhYjIAHRUVpPewbbBFXN806Z3EbLhaxAEBv7dnPbVSoKuRIrsbbRIoZywbEZc4fEI+C38LZBM1dRaHqy59NWEgsyFZj8PLvNb1iyPJzeStSE0rkIZIYC/JGRq6wzMDRzXo3VjAF1yfW6OerPht9xKUwjDb5VrBjTDVNNjLyGRt8Fa78HymR5DFOZnZt8B1jKOyB5fH1L+OgGJ8nDYFujm2PrANz/Uw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 08:14:00.6756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 807ed050-3a2b-407a-caee-08d7dacba0cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 8a468ab2d in order to split it into two
different patches, and this will make it easier to understand.

[PATCH 1/2]
porting to gfx10 from
commit 1b0bfcff463f390c4032ebe36a4d5fb777c00a4c

Originally, MEC is touched
without GPU initialized first.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 2 --
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index bdc1f5a..691c897 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -543,8 +543,8 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
 
-	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
-		return 0;
+	if (adev->in_gpu_reset)
+		return -EIO;
 
 #if 0
 	unsigned long flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index c2562d6..df841c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -541,9 +541,6 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v9_mqd *m = get_mqd(mqd);
 
-	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
-		return 0;
-
 	if (adev->in_gpu_reset)
 		return -EIO;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2e1f955..d94eff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3852,8 +3852,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	amdgpu_amdkfd_pre_reset(adev);
-
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
