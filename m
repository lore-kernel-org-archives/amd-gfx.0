Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432D9C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 03:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0804206EE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 03:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lxbAS+zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0804206EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824E06E119;
	Wed, 18 Dec 2019 03:25:25 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690055.outbound.protection.outlook.com [40.107.69.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC57F6E119
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 03:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIUyS8ZUP8+F2ABMV2Op07Oon2wtbZWjRnNErEDfMyhu4fYN/wCCD4mwLixUGUBzyWVxLgE1ucR4TCjMhPobsSvTJgeoiy5f4TFa6Vsmg6q1zmsGVqi4wyKoGOtpd9W0wxOO385hsdx6+suMrrx2a/eWgdXotKi25ukycio+o6hGAIS1ZPYVPUsjnr6Ue4qn99OYuEbv9RQDu72U9qJ/cAnE/mcrt3RR92y7QdpBmLzsTL/bISriCly+pj41ZOaaAlRUOZ8PXG0GWKbrDmuCYwj4R/m/UMnPY5m2kPTcpJ6BHjXJ8uAZLRS3bvtOkkm8YmSxNoFLcLbACggRWQpuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHVb/IXua4ibMBwHSqc4BPPRCcgGOIz56YaZfuvadCY=;
 b=WT3EufPnM0vhdq7eA8rc13e/QtizpePwqg4PRXCwhxEkgmczRdinhbxSUaAxmnttZdRqmmIPdTK9FO0s5f9kUUxqzuPGvY8FXqnCMI1zv7bKMapdN120yTJpeHpLTpjYAPHQ8ouTbksNABpP0kP+1dXnRKDsu0GcTfkoeYHvLNvuQbQchcFAi7oBp1/juPbFqmJfF1tTa8oO+0RHXj1vckNLzfD6inZLGcOWRMnrOYFcBzwhOAUAYnahuqe57iGFjl0u+qz8g+XFg8FfhjelGSwgMLBoUW05jRs5l52rIFqloEIQ46mhRlTuxK/lUyNBzg81FFYyq5tg1+JoE2wg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHVb/IXua4ibMBwHSqc4BPPRCcgGOIz56YaZfuvadCY=;
 b=lxbAS+zW9telawc9LatFSI4E1YddNPGqDDXcVSXdalvD/9dck6F6MVOMOjVyfdX9q1gClCf5Ty+nVV6JfayeMnhWBoZa+q9sqo5QL1wD6IDudyxAfp80falVhm1CYInLv00aJDSgci6j9oPly7ktF3Po4s19Vwr/Vp9+gs6s7WU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3662.namprd12.prod.outlook.com (10.255.236.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 03:25:22 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 03:25:22 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: no SMC firmware reloading for non-RAS baco reset
Date: Wed, 18 Dec 2019 11:24:57 +0800
Message-Id: <20191218032457.28424-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:202:2::34) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0401CA0024.apcprd04.prod.outlook.com (2603:1096:202:2::34) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Wed, 18 Dec 2019 03:25:20 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4ed2b51-92f9-4df7-654c-08d78369ea23
X-MS-TrafficTypeDiagnostic: MN2PR12MB3662:|MN2PR12MB3662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3662958148D0FD70FCB6484AE4530@MN2PR12MB3662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0255DF69B9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(2906002)(7696005)(66476007)(26005)(6486002)(956004)(66556008)(5660300002)(86362001)(2616005)(498600001)(52116002)(66946007)(186003)(81166006)(6666004)(1076003)(8676002)(4326008)(6916009)(36756003)(16526019)(81156014)(8936002)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3662;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wo4c5seYsqqP4fu7oi2KbDfYplBxo8gGJEqLaVz//7HujX6cWeyNC5CeNgnE/zbWyRnd6wqfzkRyQtHQ5yOI7hPLewghlQ/3KsaJHcCF0qJMJqzHdyZRFTkXf06nlxoyf+Hi3s4n9EK+f7wB4y15FSzpMe8E9Mn7LpEm05Le1kO31rJQtfJFGnopAsZbYkrY+qtHAGU5FtxqgzV/a9lqwMDVbG20lgDLWQdbzZOmOkkAbzExb9mcWAWm36HCTk3Qs6gBfqvDBCqBcD1BSq20M6H0Qdq8nZm/QYI7F3gggHf3EYAgTvS+9nM9uPf5HuBvq0PIYeOGnfOpXgeewzt25pF4cd46T0dNeZfc65swSvdhb8s6h0IH6LGkl8EEI/IT5SEQGB6zsBua4a7cJ2GzLV0dWtASFFu2WI+vrqKo29SqEsxo3/cTDzRvhr0LGjPz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ed2b51-92f9-4df7-654c-08d78369ea23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 03:25:22.3385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMG5iq8ViLPm/knM9hzCTQL/0msTwuJcw+2o1m/KxQrvsNkqXW4nXHYttNtE0N29
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For non-RAS baco reset, there is no need to reset the SMC. Thus
the firmware reloading should be avoided.

Change-Id: I73f6284541d0ca0e82761380a27e32484fb0061c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c14f2ccd0677..9bf7e92394f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1439,7 +1439,8 @@ static int psp_np_fw_load(struct psp_context *psp)
 			continue;
 
 		if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
-		    (psp_smu_reload_quirk(psp) || psp->autoload_supported))
+		    ((adev->in_gpu_reset && psp_smu_reload_quirk(psp))
+		      || psp->autoload_supported))
 			continue;
 
 		if (amdgpu_sriov_vf(adev) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index c66ca8cc2ebd..ba761e9366e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -676,6 +676,19 @@ static bool psp_v11_0_compare_sram_data(struct psp_context *psp,
 	return true;
 }
 
+/*
+ * Check whether SMU is still alive. If that's true
+ * (e.g. for non-RAS baco reset), we need to skip SMC firmware reloading.
+ */
+static bool psp_v11_0_smu_reload_quirk(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t reg;
+
+	reg = RREG32_PCIE(smnMP1_FIRMWARE_FLAGS | 0x03b00000);
+	return (reg & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) ? true : false;
+}
+
 static int psp_v11_0_mode1_reset(struct psp_context *psp)
 {
 	int ret;
@@ -1070,6 +1083,7 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
 	.compare_sram_data = psp_v11_0_compare_sram_data,
+	.smu_reload_quirk = psp_v11_0_smu_reload_quirk,
 	.mode1_reset = psp_v11_0_mode1_reset,
 	.xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
 	.xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
