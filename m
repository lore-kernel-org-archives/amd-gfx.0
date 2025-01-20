Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B3CC02188
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 07:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C919210E32D;
	Mon, 20 Jan 2025 07:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pC5ou/KD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A081210E32D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 07:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCgxFM5XcZyNx/YLePmsfHeHZ5XpBm+EnbIVKYrgnIozIC/JbX597fad5nAJIeqQZcgJnkRL6SHIW2M4LHUbKHxLbfgnDOT0Lut7LeV09anntTutTmUcZ16qY3Ik3f7U+rzT61kKtw4ge/9KNv2Azjr9Q7+AOL2C6cPDbs29TASLYQ66YARevmCJLvyKQZlGi2ZiSCuBynbFCvlPn6Lqm99QUyqc/LMTS8AeJmuqvetbfLXCzwvJNckbALR30UjUMfm0dAhIqaGPU40gW+K7nkjeF3bF4qZDLcrk6dQuULk4goXhrBQYuInY5mR2KFocua0I+gFWI7yJ4Iishyxa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzKYiSTH1Pa4tISS2ZaL6LnIS/MNoYZxULpqcJzmW64=;
 b=ZsHrOvpK62E5YoZL814gSJXViY9xj4cyb9oos0wkIvkHa8uQpX1PqogfA+SHk5enc0rnB1mEYygIocGPMKlnH4U7iHrGxrIZNHsATN/6Req4CrmVZ93v/L3rkp/jPdHQuImkr5YcpSdrRZqKHg5nBYJPxBwTg+CsgRmLmv3eOteYeaCxeLDIAB8GdR+juO96AsfFkbxHthUFVYVwgwCoaisDok4/8ft7c0PX1ou+GQDK+/I6zgLB9FwXAnPxDyshWVROSGQCITw3+7QnxhkOM2zGopaUAHnloh/J1B6fmHsXepfdfHpyk+oApfq8cEfQPjRJDHWHe3MaFobl4ZeX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzKYiSTH1Pa4tISS2ZaL6LnIS/MNoYZxULpqcJzmW64=;
 b=pC5ou/KDWCrG3vNl2+qe01Fo0q6FXlW9KhsWYFWgcCPdQSuyi4vRWAM7EmopxnuIMcN9r0GrrApTMb7O1bLqe8uGTsnYtGdsWvkkd2K1t4W5xpEqA3WfZhFNTvldrw3j9kMX2Rs/u99wzou80hD2YNN8frohY2e3z7gIcPjQtmg=
Received: from CH0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::24)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Mon, 20 Jan
 2025 07:41:50 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::a5) by CH0P220CA0022.outlook.office365.com
 (2603:10b6:610:ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 07:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 07:41:50 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 Jan 2025 01:41:48 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <flora.cui@amd.com>, <bob.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Fix parameter compatibility issue in
 amdgpu_vkms_early_init
Date: Mon, 20 Jan 2025 15:41:26 +0800
Message-ID: <20250120074126.971042-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 4896910c-4285-48fd-596e-08dd3925e6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlIrMU9ZdklXdEc3Q1BoT3NJQkxJSktaakhLSE16cFFteXRBWWY1LzlrRzhr?=
 =?utf-8?B?cVpoUWpiNHM4M256bkFDYWYzRVV4WGthVVIvK0tlY2RUdlZkSklWTmlsd01t?=
 =?utf-8?B?ZXF6QkR2ZVYrQVlXRERzYXFsNGRNNGNzeU45TjZ5bkgxV0RIdU5lUHpiaEU2?=
 =?utf-8?B?NHhuQzZoeFJ4TUpVVlExTnpyN252cmRDY0d1S2ZpTHBReEp0OVlmSjNpdFds?=
 =?utf-8?B?a1ZwZEg3ZFdqbzgrV0hDcGliVmdsdVc0T0V1RXFjc1JWUDZOVTc0ZUdXeGVW?=
 =?utf-8?B?QjNZRDN1eXJKakRUZmE4Q1FwL0FtNElLREU3a2F4UFJkbmxvQ25RN0R2dWRj?=
 =?utf-8?B?RGNSSUVQNTcxZjhpQ0FvM01hNy9RcC9wV085bkRyVHlDRjY1N3N4ZE51M3FK?=
 =?utf-8?B?MWdrMVdvb3VDdjFpcEloTHREMDdGVXhZTm0wUDdWUzh3UTNhYmRJbXRSK0No?=
 =?utf-8?B?aGR2MVRnZ1ZoUGV5N3J2dVN4cW5XdUJKN3pKT3IwSW5kakxNdmtjMFllbEI4?=
 =?utf-8?B?dCtUR1pCTllES2tSQ0kyNG9vUnNMemtabi94bnh2QS8ySTlSK2Z6SnJRSTNC?=
 =?utf-8?B?Z0NTMFhOWWJZWWxScDRqQ0hpQTZCTk5QVkorTkJHOFR4d2dsNWhaMi9QOUR3?=
 =?utf-8?B?ZVdBN0FhK1pmT0M2dzNldFBWVTlqNlc2VHh5Q2k3M3RyRnREL0VkRXJjSHNC?=
 =?utf-8?B?K1RsdjB4WWRTQzgzWGlFTjFKWG1XRVhiVjVTUHJWbEVETHFSbDNyQllWZ3hG?=
 =?utf-8?B?VExBQUFYQnZxK2c1RVRvYkwvUEl0WVIwSS9KenJMZXUyQUpPK21QYUh0MDdy?=
 =?utf-8?B?OWs1RC9EVC9ubi9pcGpFTkttVUVITVpxM25mQ09XSUNZZmVaNmRBRGVSUHVC?=
 =?utf-8?B?dXNxdlEzR2h6OEVBSklHSjJpYUUrMklEVDNibC9xcUFVVmthUHNTSzVEZkFz?=
 =?utf-8?B?MkJBaUFQUXFwQkxBSUpyaE51cFJCemx0N2hpZDJHUTJkS0NLSzQrRWtwZ0ZU?=
 =?utf-8?B?ZndpeE5oRkpJbkdYS0JCWEd2WDBVVlB2NjkwYUVzZ2dSRzZiQUVWYlJCbmc2?=
 =?utf-8?B?SVJzdkp5dFc2Z0tRTE5TMlg2RGtRRmEyb3BuaS90NHVwTlZqUWJFMmkxaTBR?=
 =?utf-8?B?aHFpZVhxblA4UXh5TFVTZmhoMmhqZkZDUWJIeUQzb25GZHBxa1g5QkFzWjVr?=
 =?utf-8?B?NHpvQ0FMZWJYdWYvcVlWWWVUVEpEV08wOFJyamVneTg0NXg3TkprekRWQmFG?=
 =?utf-8?B?WC9tdStPUWs0Rnk2ODV0QlN1WWVuYy93bEwyMi9qWDlrY2YvUEJ1NkRldzlT?=
 =?utf-8?B?VG94ZjM3eHZXSktvWlZnME1qYU5YejRZcGpGTG1LZTA0S2wvRDgyWFo4K0Zw?=
 =?utf-8?B?akRjRlVaUnJpWlRaYjFrS04rRk5PQ284QW9tVU5ZMTdZMTZaakZUZlppSjlD?=
 =?utf-8?B?c25jK05CajdoWTJuTFhieEVCdzh0WkNuQVFMQk54TmxrTm5sZEk0dmtNaWJu?=
 =?utf-8?B?dlVWc2JHR3YrU0hFYUtCMUF5bHdjUXIxMUw5enVQd1NqTXdrNjdLWU1KMGhv?=
 =?utf-8?B?RGdIQkFickxaNHB3akt2cnpPK3VjZ1BYanZxV0FJRHFuR3FKZC9HcDhiTzZ1?=
 =?utf-8?B?MmltRERFcGlSWkxxZmxpWHZYSk55M1o2TWFvY05MKzdHb3gxTS9ScjNZelNO?=
 =?utf-8?B?TnZpeGVTSnlLcFdxMmJlOUhKTDB4dDBHN3NvNk94YWt4NlN1WE9DSkxJbFBG?=
 =?utf-8?B?d3h2aHhhUjdpdU15WUlSKzdRYld4Mm1DMGQzL0Fab0pXQTlVbUxmTDhCbWZr?=
 =?utf-8?B?MTkwTlVvMW5PeWpyeUZiU3lIdjBuV0c5dTAzbndFRmI1UTlpWFdkaGZTT0hG?=
 =?utf-8?B?d2U0RG1pVTV6UEczc0NhMFkvOW1sV1F0YVJucldrU2ZuRi9HK3FnZkdIOFND?=
 =?utf-8?B?ak1JbTJuU1BlYXh6OXVrOG5TZ3lpU25HUkxpNWtMK0tLQWZYaFNyejZLY24x?=
 =?utf-8?B?ZjVyaVloSXVnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 07:41:50.6191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4896910c-4285-48fd-596e-08dd3925e6e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GCC raises a parameter compatibility error log for the
amdgpu_vkms_early_init function because it previously accepted
a generic `void *handle` parameter. This change updates the
function signature to accept a specific `struct amdgpu_ip_block *`
parameter instead.

error log:
/tmp/amd.fwXY79Rm/amd/amdgpu/amdgpu_vkms.c:805:16: error:
initialization of ‘int (*)(struct amdgpu_ip_block *)’ from
incompatible pointer type ‘int (*)(void *)’ [-Werror=incompatible-pointer-types]
.early_init = amdgpu_vkms_early_init,

Acked-by:  Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 5530d4ead536..e958e1cd85e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -617,9 +617,9 @@ static const struct amdgpu_irq_src_funcs amdgpu_vkms_crtc_irq_funcs = {
 	.process = NULL,
 };
 
-static int amdgpu_vkms_early_init(void *handle)
+static int amdgpu_vkms_early_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
 	adev->crtc_irq.funcs = &amdgpu_vkms_crtc_irq_funcs;
-- 
2.34.1

