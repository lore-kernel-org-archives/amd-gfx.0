Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A51CC54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 19:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4EFB10F98B;
	Fri, 22 Mar 2024 19:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P19tYoHw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F214910F98B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 19:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfY6uQf1MkUUTvgSmID6RJoQBOVzQm8inn3zj0L1wB9Y/ss7wdLgycwJZSq7mQYEi7KEAuVGNuMi9PynvvUu9AILeS2Ew22srTx4b3CEngvnivNc2yAMkNlsOIMI5HS/Vc6OlfE6Tx322ke5/E7fE8LbKHHmXYiKD9tJhOue9LzwA0wv4NuZA34kWUjeNzh//6UIN2jxVjfwYfx7mxkz9eeJ5J6Ga/deayaPfqsHFC4XSiQiBqq4S2VaZ6uFtgA0Iu6Urh6712K0Fmheatn2iHylJkV/40xvpLyDYefYbjEnhIDFFldbqm2k2SWSaR/HJuKxiN4KYs7KFY98YcZxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAc459+GcxQdi+rP2OEKjg40Az96T7PLnjchyLyxfm4=;
 b=G1eCO6ljx+afGVoa3mp93OgyVtRLBLX+1Q0EI4CLMoT6Io+OlFhh36UnDiJZnMeJ72ZqUuDM9Q87ueKNYs4X0gTc7uw21FeTUoyteejzM5OzTaNrGJznSc9gVs99ekcNmDS0+wCf9/vVR9xT9uwHsXqgwqKX7LleLgfc8fGm/dNVLmVBTrJp9ztFG7DK72W/8o+JZDb4IcYV+g2AShln3M1NyzfkCoE8L1JhFfQcyStuiWP7dAmAml8zwNvEKDR6Zy8TkVI5i2QSCj8n21Efe/zJJYvpPLJXTPNBPUlQCafNfFCSxMKvfLe9dIq8KalsJFarlI95UjMKmOrX0Po6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAc459+GcxQdi+rP2OEKjg40Az96T7PLnjchyLyxfm4=;
 b=P19tYoHw3cVA+7MeeNJf82Egmdcw+wr/EcWYhr452kulFeDT/f0uvRTwSM5XtjPP2Utv929OYiERS1Aoq8gsXFb33zvaHLhBKzdIcl/1YjDw2rujwo/8qRhtPvlHBGmtvrW5SPeGYlVOenBDYp/xStJSgp0m/p45uros7pM9NVI=
Received: from PH8PR22CA0008.namprd22.prod.outlook.com (2603:10b6:510:2d1::20)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Fri, 22 Mar
 2024 19:58:04 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::da) by PH8PR22CA0008.outlook.office365.com
 (2603:10b6:510:2d1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 19:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 19:58:01 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 14:58:00 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>
Subject: [PATCH 3/3] amd/amdgpu: improve VF recover time
Date: Fri, 22 Mar 2024 15:57:37 -0400
Message-ID: <20240322195737.30795-3-Zhigang.Luo@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 7057becc-864c-43fd-c2ca-08dc4aaa6174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frHrQ97CkE6m9/N3H/nu1lhvSxOHiBXxHxC2KBzih3TtQeLcsXnXUwTlsm7+UwYkQDLXMqRgT25LUv1c04wmPnS3xV9EA1dBE6S8lm2nX0kUhbFO26h3AcTbpCAQDR/Mjxd4AKqBdYZK1/TFLd60JdXLqlEFE7fktHqk369fIN+D94qQN4IhcxcABk2JcHtaspRHKaN7rGxbj2krapsUZjeDXlAlGs/i4YBTRGsWS0B5R8/G5wDuAj26dWrzIXJ1qQ7EQa/fuLUIVBE8Qs8o2meNIMolkj5H9Be7bkenD4uL1rpwQDvV6/kJSaqgDlDqDUfnU0wLCK1tFQz2uaRIgzGLKe+b6PY1X8IW7wkrvECc2iikmTljL2ak8gXtDYrtfOXJURZe6e/+SGSGNVERe4YXDjmq+I5bEh7e9vr67rvUjJgsCes2bulOmpU3Ltbs/NWB42v9qf0dRzBevjOSxkUFFHfgnzO+XW8mhLmAvrt++PalriKUk09UkxEM6Bd+GJOtSI0prHm+b3sZoU7OHTWxYS48tA0V/y4ZVYy+yiQKoojH68KHK7dfF6iHu1fkOOkvWiwcFyZLLBWilvOVxaJkBvcfumN8JGn9q6GRGehFE0kzvP/pZqZOnvVR1h6Oh0Ez4b2NsACyYRXVgdvENgf8PErYkjwzgyg40qvqx+YfZZYunD7zSGFfXpG7DyV8KNQsjSQYawbOfxuvxD1CWF8M29Xrefv3ayFnPQvI9avDu+PAO6c6dx/n+rnXR+qs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 19:58:01.8613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7057becc-864c-43fd-c2ca-08dc4aaa6174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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

1. change AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT from 30 to 5.
2. set fatel error detected flag.

Change-Id: If1e0357deffa4549d4e83e925c8d764f7f8c9f42
Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2867e9186e44..50f87fff778e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4984,6 +4984,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		r = amdgpu_virt_reset_gpu(adev);
 	if (r)
 		return r;
+	amdgpu_ras_set_fed(adev, false);
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 
 	/* some sw clean up VF needs to do before recover */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index aed60aaf1a55..4b6e50cfba08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -593,6 +593,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 		adev->virt.vf2pf_update_retry_cnt++;
 		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
 		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
+			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
 							  &adev->virt.flr_work))
 				return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index a858bc98cad4..0a57b637c4bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -52,7 +52,7 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
-#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 30
+#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 5
 
 enum amdgpu_sriov_vf_mode {
 	SRIOV_VF_MODE_BARE_METAL = 0,
-- 
2.25.1

