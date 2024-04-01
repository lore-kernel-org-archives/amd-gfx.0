Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA0DCD1288
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 21:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD8B10F5CF;
	Mon,  1 Apr 2024 21:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="olqr3rsk";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F3C10F5CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 21:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4/5bEGpjpJqURHjLleo+YDYDOn+9ymvSkVP7vkwuIaHDXPVaR5kUFMKX3DZr7Q+WjtxSSbE+uEOIeBRBx037Nht0gBhnqnFEhD0NPp4A8Mnhu9eNc79+8WVd9kxbZDAeqz24OPQOHJBwpdio1k4FStZGMIMP5inCRZnwJbodZ622oWCz2vAiurAMvXGNSpY9pBUsiDqgCHiIz5/3llS3P0AYWZYBIUQAB1GyrleaUKZJqMGZQDrqApjiBOdQZPiGZApmwKqArh0wUfPPWwbqsImJEqE21VmJNCbOkEZVLf7LKzWzXt8ISG83FY1z6vHoGo8rSOSFWXF6nkNtjx9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/nAMqwImTAapF77VZvkTwhPwFe5i0c/B5xajqnevg4=;
 b=oO2E1dK8hohOP9O5G9TTjAj+B+hb7Ju/1avACyhi9hUkkwXNiHoSrRprsbLUdSpIavO12CRGu8AwEA+6MVJ6H4n3uR5LE3QiCg8/IT38cMhwuh/6s7gCZITRSVRhFVzzHRo+GxylImxYiRBYVZo9i8tol1KCrjRkXvX11AmubaKFmcAiaPiVuy9n/Fo6XP1bZ2VOeQ9l5LaTMfbrba+HDVq0XumeMi+8l6QvDHqagRdrjbmwPqp2T7gQkQRD5gc4+DC017BerEc7PMDeKcIzVjkFIYU1oAQcQ1VFV2V2E8Px/q16AnzQHyFuamWDB2p5LWhTIVlkjMX8kS2SUH8dIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/nAMqwImTAapF77VZvkTwhPwFe5i0c/B5xajqnevg4=;
 b=olqr3rskdD1S8ziP6hmWOMimLNDoDiVAhaYU5ScGVOp2jQou9wCLQWALwhYgKkbdwT4x2bue6klf3feQL6FuXg6gshvt4R+FDnqa+/f4aEfairxtHbgCjXinC0R4F0p9CKzfuPhIyEETRKfeOps2c2UJDMhZE/kDZMAPAFHq13Q=
Received: from BYAPR08CA0057.namprd08.prod.outlook.com (2603:10b6:a03:117::34)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 21:54:04 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::73) by BYAPR08CA0057.outlook.office365.com
 (2603:10b6:a03:117::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 21:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 21:54:04 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Apr
 2024 16:54:03 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, <felix.kuehling@amd.com>,
 Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH 2/2] amd/amdgpu: improve VF recover time
Date: Mon, 1 Apr 2024 17:53:49 -0400
Message-ID: <20240401215349.23361-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401215349.23361-1-Zhigang.Luo@amd.com>
References: <20240401215349.23361-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e50bcc-8fc1-460c-272c-08dc52963f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivTWxJCBtmEsIXcKEs0HonbKbOu4oCX+DCbcZM2VlyEZKgiubCOwado//G+m4d+AaoaeHohWRjqwL5QABMLVSviefjccFKyivpy7ZGZ9wvmrCWLtgP9/wxsboePfqxC63jYcvvyCXEVMtfF6L8cKI8OfkFwOnat1Waqkp56NfOsa+iRri41fqodsZ+uKWkLoiRIXPV/gBMVJc59BWLcr5PJ46jM9A2i4uQU5WH7SGcA/+UFwsTFQg/lwSmMeM4XR+n9HbXIvrtbtEOgHzmWof9/xcCT2C7W1OT/bWFB8nYomVlBOl0CfzLTx/9aLBK928ACvE53hvhTfJ+S8+acPDfkRlFTAUObdWg7jixbgxvaUw3WxDm599H/pVL7invziXnc9b7pvRiIdPZdqzmnzVOdeeIN8NVWC56mJSPNBlvRcNGnuTNXK64QraWsYEKCxq4ugNKfTAvGMMjCaCWy4JuZ6cEAs5invFUskLT5rvWR96uc6icfWKfBXKb6ObDPl8Sav4qnWd7nXj+30EQ87l5CYR++bmLKNrDVf1TGJOi5C2cPk967kgvt1ZCsAiX4/O+TY0jEexFW9gHT/os7Nu/oQUQlFNHodFwCavbeX9dSmezvOeqRnP/Mcg2R87jhZbt3JP1e45ggu2hJx/oP2yIV4LmDDD98uWkjWCnOB9jWwS6dAx1PJ/O+mUyCS7qSmVaqXs8DqzUkz8DoKVkOQjjBq5csbU+afYi8i8JKV95n8j5NIUUHJT04Uskyhax+r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 21:54:04.4328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e50bcc-8fc1-460c-272c-08dc52963f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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
index 70261eb9b0bb..5e88f6f6a481 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4982,6 +4982,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
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

