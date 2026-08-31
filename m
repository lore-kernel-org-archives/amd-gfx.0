Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EED3C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999DF10EA0C;
	Mon, 31 Aug 2026 18:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ckUAy61u";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012008.outbound.protection.outlook.com
 [40.107.200.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E5F10E9FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJtyNVyFXpHJ4mpX/NKUhnv1vuybPR7CPEEiggS7uciFeHvYOQoRNnPRL39a+LKASen76bXGITeTJ6EVx055NW/LjVK6t3oPpRazkXF+aRTnjjF2f9SWB35SumN4+cZMdkM86wM8Y+CdmmEhOpy0IkJm9EEKPaK9JB8G9cRbTel0q17lcx4HOyhysQ8wqyDkfj6C/Bz2tdGZPXwsG8L9RhNE1udxYldzyvsEKF45rMVmVa1El7cNwapLyJSi5eBrwmqaBiicyH11fOZLkzFZSZJ9n7ivsWFczV3bu5ohGmvNwvH0oriZfRTikS0GGDlqamVyOUriThbrHyv+b70P9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MCAXrMBQS0qB+fPwLlsTgOwz98FvomF7O13jcszBlg=;
 b=yarfSE4LNlxJVOAAD2lKsft/Q7TpxEE7an29e49IN+9zSUv/u9Ca17IvqmaY1TsZOA17A9RlNS5/feW7HSib6YKmen2e1sOQC1Tr+81Gk2E9pIVrhaEGaUtohnVMw0pM0LMnwIu3tzWJ5tQZkYfUaUZx1DN39biNuVd5WoMlTTGtmGkFexUbx39ruyO7uLZuOcm0sSjqpfLXjkWc3vUncVK6IlZVVTR1qHj6Q2EfFhgrwBcHvB30fZUwalojuAelZF39VMsYSCt704AzUJcMOZ1nBbzJlZX1l8XC6btAPAuKNN3UiN1rtBZIrMFVbX3KlObhi6mZJyFALFcKQdYqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MCAXrMBQS0qB+fPwLlsTgOwz98FvomF7O13jcszBlg=;
 b=ckUAy61uVVjbIAameNX6EGvdp+N8djdgyhUdoB0c8isKSKaoCn9y7bQwywKHdD4+baRsZSHZASPdG/gofBI4O3a5nhyiSnFC9GV1LTzyMrPWh4swjY0bnw8QQcHpbD6hmaNpgUfDv7jaf3YIO+IrRbMnuj6k37Jr/LuJGBYNERw=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:31 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a8) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jinzhou Su <jinzhou.su@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/95] drm/amdgpu: Fix NULL pointer issue during ualink init
Date: Mon, 31 Aug 2026 14:26:41 -0400
Message-ID: <20260831182754.1089811-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b9ccb4-ae8c-4a7d-0498-08df078da6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ca7PeIvIZpEKuEIszn8yPan8HG4XQR3xbRKxAQ+Gwaf3YORq4OzV9wjsFYlJ5MR9zzpjf61tDSZJ/a94YoR9S6BrQFA/jbz8XNIQ5UFY9PgqwaVh/bJhUMjqxQAwa09u+2i7ar9ooBqXdYPOi/fcWj568rmZ68s3Lfm8LBZQ22lT5Q8fokt0zty4G8/8h6me+lp30+hey5h5F1NXMQnDQwx1ewnnilYOc74Vyi+vreakYvWqMoMKG29IL0kzWv2ebj1LkFTuf7nTnq09kG4IGVk2eeYHkRyfL7L/gYn9KZ1MmlQuKGQwZwcoe0TyGd10gEjovgkLntRf1rVpj5OnDQo1SpWOPrCoIgygsuTLprdsrgXDPYYYHbLGWxxkYz4Kh5bJT8LSs/MkIEMH683a4rh4c09JW2Myi4Hy+AB64ug7C3ipRDQ1flRlF/euyV/7OXbOhTXVBMqMjhNaNGro0kCx43p8d6KU4rYQ6NhkaAPzUDdgFqiOK85beAjI2PnmcaMulyvMgtXC+h4XuiV3ykT6FdsJKbmp16TcPvln9JYf0pPDGWbt9fT5fvaou1MFmjZNmqrKvJneh8Vs78BFQMzUyFwUcWrk6p832EjHuP7A00HdAI1ROuKKz57mS/ee/3VlFrMcV+0IcbS9pXCBqzOuL0m+eRkq3W4oKqzuYOdM21GiDM3EmrwMN8llYWrdCSzdfkx2Ll2iGYXWvNhSnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wx9/qzfgU/Hz04nS/T7O9oeiKLBcbXG0lH3D738FEK9NRyV7Ul7ThJi+4VTyRVeg5EEIBbaOrabckmWn2L2kwtT+h9NnzfLI1zPNr8Bp9FQgTeYbA1hPzxzMn3A1JO/IlgIzVUZ2eA4KN/cqxvKWwnpf/kWAhPFMIWV5YV/n/My6mHvPGSjHz8XoY7T/VG+dilh5YuSCn8LvWwItla4mFInD30WS09VeaBf6IjB8vzW1/t1KmpWSdUJLxKGiHlZMNTZxy2T8H7VGkQv2TwpgseEcFOMPXBssG+6iI8UmUh0oOEAID7VpL42IB4JbfDFnhMSLM3m1tNgZLdBs11WjKUTQtKB6WmhozTOblATkJmRso3z6p5CkFZUV/BaiUU3ybH5uxGvBk740CuYybx8Ywv36PUCjrucpoqJRLKUf72iR9N9D73bca31pTNotZnrn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:27.9827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b9ccb4-ae8c-4a7d-0498-08df078da6cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336
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

From: Jinzhou Su <jinzhou.su@amd.com>

PSP may be disabled during driver initialization. So psp->cmd
is not allocated, so any psp_*() call would deref NULL. Also skip
if sysfs_init failed and ualink.info was never allocated.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 428296e5cec6a..76aec9eaa59fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -33,6 +33,14 @@ int amdgpu_ualink_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	/* UALink relies on PSP services. If the PSP IP block is not present
+	 * just skip UALink initialization.
+	 */
+	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+		adev->ualink.psp_if_ver = 0xffffffff;
+		return 0;
+	}
+
 	r = psp_ual_get_interface_version(&adev->psp, &adev->ualink.psp_if_ver);
 	if (r) {
 		adev->ualink.psp_if_ver = 0xffffffff;
@@ -920,6 +928,9 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 	struct amdgpu_ualink_info *info = NULL;
 	int r;
 
+	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP))
+		return 0;
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.55.0

