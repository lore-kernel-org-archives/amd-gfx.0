Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A20C3ABA3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 18:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB9D10E873;
	Thu,  1 May 2025 18:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXHpM9bP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 541FD10E873
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 18:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJDy/PZFyL1jqI88C3pKRFvwvx/QgvAOjW/CPg1leozrbxuxggV9bVZeWSnXJYlVOG/Xo74DBEljDfkhxWCavwdlBp28vuexpl56PiFEhCKsSZ/oClze0KGDSV4ny1pIQZAz1YOBtq8w7kHYApsAcXzCbm6pko8lIgpt4fzG2XIqeUNM/+hCacJtotwPELG9YZhrPGoqTryJzTWd29peoeJxny8iTQudYVAKmowgZHA9Apn33DH8mtP/6wVq2ohqw+b1F7XVV6CGvyxbQRMQv/BEhXUcP6LZzMMW4efAD/PFs18xEqLFobKhrcxJfBf6wWRuWPzfF4JcuGlxuFgziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfmpNkEVfc0Xg6X/fcvb2hG5ZxzGgpVDPQI5voGAHrc=;
 b=i2YvcRE0loqsoWg4xdzyQW0OBWzE07+1eyNvDMRM8M9lk4LQ6m/S2iO5IujeidKRc3tHYuZB027QRR46RllAt5mOfD2zu3pWDxo34ANUbgcFZLA6XG1s6ndBOHIyqvMte7coz4JdKHEaKTQ+kodBgVpQp7847DBoHkiBFAQ1MkZv3hHW4PBp85TFEE/b+DMR5J1eA4/CXOzOEQs17hNknLOJP+g4oH7re11YCEBaK+pwEsg58sgD6Qjd9vmAc/qqHSfsBJESYEmWCwGj/ysYBRruc3KyOmMW0nenPoCG/OvcrxaXKV9jw4hmYOaFucev9Thxq4RwfYqx0UGOhDYmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfmpNkEVfc0Xg6X/fcvb2hG5ZxzGgpVDPQI5voGAHrc=;
 b=pXHpM9bPYRWoXB6SwBNiCTQPUy0i8xXmmo8tauk2ZNQw8/Se6f+6sM1aj6tI/Je2SL/bwdiMsnY2AMOlSXQcT1X3i2ekKX8hqzDXgxKG2PbPtG/mq9KnVEQ5BBqiD4eJHy99DDmJ1beo1OKFBXhY1Vt/jmU77ejd6aMt+/9XVT8=
Received: from MN2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:208:23e::19)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 1 May
 2025 18:35:12 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::a1) by MN2PR14CA0014.outlook.office365.com
 (2603:10b6:208:23e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 18:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 18:35:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 13:35:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: drop eviction in pm notifier callbacks
Date: Thu, 1 May 2025 14:34:57 -0400
Message-ID: <20250501183457.4123584-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501183457.4123584-1-alexander.deucher@amd.com>
References: <20250501183457.4123584-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: adad7e80-3659-42ca-6ffe-08dd88dee824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kV+9/8bEcGqIHUpbvOm1bxfrOSZE8ZygUdBg0HyQApDxFnaeYtLFz3DAIznu?=
 =?us-ascii?Q?ZvjfThzKGxkLUNWEnjfP6JCujQzkjELM/cTo2A5Zw25Y43ZoSVEB0lGNaaZA?=
 =?us-ascii?Q?wP3JmeqHNcqfCMVOhwKrZCW3X1ZdptPnIc0qdO3YqLpEGVWE87gg0fO2hM/o?=
 =?us-ascii?Q?LCJXjN/SOYyKZwRcW4NPg6MU4sf++PgHiLA3lkNePBejEETr2XNheKbKj6AN?=
 =?us-ascii?Q?6pFYVGJyOrjij2NQ5pUCort+YreH+IptwPclTD5xv6ikAiajKAX0QjCgSevG?=
 =?us-ascii?Q?MM6I/03RNdqtVQIf5vq9iuQddYhE5gdN98gmDAopA4dYQQrGqgybF6nW7y1N?=
 =?us-ascii?Q?C3nzEQx1LrTmsYOj5LV5oB9MOV2S5Knb6j268wP++jski7WhoOxwxOz/GNhm?=
 =?us-ascii?Q?JScwHM1oALVsGN2cnI2g+NmMtUBz1SwZ4hs/OKyMA/Fx/4CjFsyl2Jr4enM/?=
 =?us-ascii?Q?+xcoVIO32oywlIA4NKqo45fS9pUIq5trHnDoS4zJXBauCk1f0ZqS65TqR394?=
 =?us-ascii?Q?XLGv5JJGPBiCwEiE8coIhNptsmE8zXpqLyvLli/SKnw6mQYOiQjbjW994qeF?=
 =?us-ascii?Q?VGNNcIIqQ9d9Peexx5m4jINTFdGw9yJtlzNSOuv/2FFUCAcZNf3zgPCn1std?=
 =?us-ascii?Q?QOm5jy7XeabITPXCRPuXxlGr5BvHDIFTgcOhR1hkaM3mxkqx9AevOhyq/zUE?=
 =?us-ascii?Q?PBrDQYKjP1pEb6lp/AI8LVYfJZCb0cEDwOKM+aYsaHVKwF1Jaz/Act3wOZ3Z?=
 =?us-ascii?Q?DsLvnYwtXTCd4hQ68zRO58O/c7ccFmEo8y1zhWPDtkNjt2GrO16gLMLzen1D?=
 =?us-ascii?Q?Wtk3zhGK3sxdbiHunsI2UPCYQK5+C5TzBV1gS+H7UT2ujQWviBQE7P/bR28M?=
 =?us-ascii?Q?/ZHJurHbpqtff305JWwCGBSCXjqRuU9n136Q1FwwOqefcbqz2VKb1uMWuzqs?=
 =?us-ascii?Q?F/acunT8TCR4qx6rg4IjHu4ncC3TkPpqqkF2XriBxaZoM9WY20uUZgAZAhuX?=
 =?us-ascii?Q?4Qntf/W7cbLJl+n6G2Z82hOEEQmG11HF6dsRerjCuYAVMOGsw4IsBIgDgPhw?=
 =?us-ascii?Q?LDH+P/IqCdDsefb/PFJ3eXK+9vyiFczj5djmtqxtfzGUH85k9ZEg3N+AiFVx?=
 =?us-ascii?Q?7pRb0LY+McGmjc8KyAfB3J1u6+eEIvwlun3skyPn8Q013vZpmAVf87IiKj4S?=
 =?us-ascii?Q?wEE2a+/JThzk/1KMVpCTS/gL6LrDcH75kZo8V3ylYIiKKrw+HlNuwOYAVEKQ?=
 =?us-ascii?Q?0O9BqbI+Sc2d/iOkeK0wvAdb0O2caCNccJfhHGsVMVqRr8ezEMH6WIAhjjVi?=
 =?us-ascii?Q?guIFcCsNV53ABGhXBDUU93Y2gB5FzPWCUTB8l+en2LQ86fJ6fUB9tP0muTlF?=
 =?us-ascii?Q?nU6PbEiIMDBTxSwla2F90E9E84MxjmDz0wD9RWkiNS44h3BfmQDVbLnGjVN2?=
 =?us-ascii?Q?R7rpDhKCxzZoyg9WAyRFIU6t/pSW6fYoNQZ01i0g55XCN0PQGuAcig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 18:35:11.4850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adad7e80-3659-42ca-6ffe-08dd88dee824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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

We can't evict VRAM while processes are running as they
will continue to submit work which causes buffers to
get pulled back into VRAM.

Unfortunately we need a way to still have swap while
processes are fozen if memory is limited.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a3e9f289e37c9..dd2a557f97634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4907,40 +4907,23 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
  * @data: data
  *
  * This function is called when the system is about to suspend or hibernate.
- * It is used to evict resources from the device before the system goes to
- * sleep while there is still access to swap.
+ * It is used to set the appropriate flags so that eviction can be optimized
+ * in the pm prepare callback.
  */
 static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
 				     void *data)
 {
 	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
-	int r;
 
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 		adev->in_s4 = true;
-		r = amdgpu_device_evict_resources(adev);
-		/*
-		 * This is considered non-fatal at this time because
-		 * amdgpu_device_prepare() will also fatally evict resources.
-		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
-		 */
-		if (r)
-			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
 		break;
 	case PM_SUSPEND_PREPARE:
 		if (amdgpu_acpi_is_s0ix_active(adev))
 			adev->in_s0ix = true;
 		else if (amdgpu_acpi_is_s3_active(adev))
 			adev->in_s3 = true;
-		r = amdgpu_device_evict_resources(adev);
-		/*
-		 * This is considered non-fatal at this time because
-		 * amdgpu_device_prepare() will also fatally evict resources.
-		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
-		 */
-		if (r)
-			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
 		break;
 	}
 
-- 
2.49.0

