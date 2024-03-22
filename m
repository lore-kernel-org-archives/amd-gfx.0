Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B599EC47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 19:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6311A112743;
	Fri, 22 Mar 2024 19:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ApUC5fUq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6DFE10F98B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 19:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC0DWaSWIrl+4v1yokiOtKDNmaiJP5Q5A3BccLJHtGHNbZEzwIHugjHEUGESPQeKnULPopGxhvJ+iHVMtRLyVh8bPcIOvOMhwmtwk+B/oNiArxc8TfpgkHDcfPE0jWRuUwMGe+rQEPNp+zgNX6BKKNxKeuIdoWcEHONN/F2Yswv2MRkmsNxt2on7A7M3mIVRw9h4s0Ix51hvfH0zxj+ZQCYIb1LOM5snwlTYE9VV83UVx+nyfFuec+KV/k5PKYnImP5WkvD5+mOuhaKC73EhpodEjgtPY8XsaR2wGFJjxRHeyJ+/O/74BfIedZ3R6p05s2tVvJsWwe0k1iyk6noDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiUbjbkvqBEfmnp+L9XgmSpIAEUerjV1IqDvbEStlbE=;
 b=DyZGrwHU+VH0J4Qfvkh0BGK6cmtZ8VMLvHazfhiW7YVHTlG17v+L70qSDEosW6R1zKNKAsfmDEEyidnPgt7zCh0K0t45ubBPquEf0berU1ucAtBU4Mpu4ZzTMJ/vciDdteCBFFAUr6OEbUv2iZ2OvSu+V/z/vjHhTIIIrzPYhFT6h3pMfrhCmEtfSsT0BLA30P0JpknC+nkT8N/y2PaBnHOtK62sKw0fHXvJ1KW2irtQdoc9kPlIZ+//CY+BZqFTq6SdW8/eYj86oGscRhehxDjL5NUxxEgX4Mm7NnuIAuZYLc0BSVTY3k2E9jtiebR+SBhr2WKM+EBAfHISdIr9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiUbjbkvqBEfmnp+L9XgmSpIAEUerjV1IqDvbEStlbE=;
 b=ApUC5fUqXEAvdDzr8OrtppE4GfhsX1XboJIPrElvEhm+7gkEvBm1oh+pYZMSo5PHT6Z+7qknaJcI5rbWH1ie+dSvxpRiiwTR2btczppav6cQiwFvr3liE2dfC1D2o6Wn9XpCINnrQ4iPwZv8vsjMYg0ektOvubE66GAXCHm0bLQ=
Received: from PH8PR15CA0014.namprd15.prod.outlook.com (2603:10b6:510:2d2::17)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.24; Fri, 22 Mar 2024 19:57:59 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::76) by PH8PR15CA0014.outlook.office365.com
 (2603:10b6:510:2d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 19:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 19:57:58 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 14:57:57 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>
Subject: [PATCH 2/3] amd/amdgpu: wait no process running in kfd before
 resuming device
Date: Fri, 22 Mar 2024 15:57:36 -0400
Message-ID: <20240322195737.30795-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322195737.30795-1-Zhigang.Luo@amd.com>
References: <20240322195737.30795-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e453d97-20e8-4adc-2c5e-08dc4aaa5fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkDA68l8Ffj1Bo2f5SGPJ8fxsJED0IjPtZPkqgzZNSdUjSutcaJcl90ErWo9LTp7e7qMip5XXxN+A22BWaeNjNyHId0Nbb/FSZ/FkmhKCWqzx4YUma2pgsqtATOSD0tolUszlokU1oFrQq0+nSSZwfz+zmuoaPmWj/pGjIJGR4XVjTiDthZjnHrFrPqq0sxaqFYmSbR2PUrFdrgYv68/HAmrZppfhebx+XwNXMWwhQ7FioWR1WaAMLw/EVR5N/trRbZBu+rav3nykDDEC8v1Zt711nygtVLlG/q+Pb/p/8xxOzScBHV6heNKLQIDUttL3RrdVZINFcjOENruFZPAVTdmpM0SoONs9BAFpY+K9glgJJrh1tEY6M/J2unxHtWy0X99jqvLVKPT6vHyKGh3hlmrDa1N7FST6v786WblXaHX8wCfnBh3ucRw+fVV3wxEy4i6NrnLUAyjQ2YDT4IttXkzaeZ5j3K03esmPKPRRLaOC4F+oSmtODIAgPLLaUg2EqaOc/QQmVUYaQiPfYbiglkQNpeD3Ef3x4kqRlfpGDjUPEL/tQkIsRMMbRlRrPT2WzUjRnXA4JYrGMr71uOX/Uw8Ygw8+7qYK6O1v4AZjY38oOqAJWp+K5Y8GdfgrWl3DWYb6vT/H7FKSw62r1Ty9M0i4Hec+r71G7J/aSzFdeUH01wrO4xD9NKDXGRHr4pje7K/7o+H+ldTEQi/nwSR47kChqEY8KQBMqUZlwNgRF6aGdYQBn43d2+wBXPBUJzs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 19:57:58.9422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e453d97-20e8-4adc-2c5e-08dc4aaa5fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043
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

it will cause page fault after device recovered if there is a process running.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: Ib1eddb56b69ecd41fe703abd169944154f48b0cd
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 70261eb9b0bb..2867e9186e44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4974,6 +4974,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
+	amdgpu_amdkfd_wait_no_process_running(adev);
+
 	amdgpu_device_stop_pending_resets(adev);
 
 	if (from_hypervisor)
-- 
2.25.1

