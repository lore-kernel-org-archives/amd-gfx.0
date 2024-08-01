Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9481C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 10:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C40410E8DB;
	Thu,  1 Aug 2024 10:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dxkU3bjI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FA710E8DB
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 10:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvV5ZSqNwIo9RIqSO9hlT7FuRakN7iuDAvySZ3yQaBfwcmB90Ekq0/UWjqAWyAkUINMq46GQ8ZGoL8K8peRZbM5RcYRo++/BMmU2AOX2lQUlqEGWKQGwDyV5Y94SiF+33RvTsbePdMkc1OIFx+sXkjn3qonJPkb7QhGGgYhdAY9Bi5n6j7YvYhmiaJpbNmZTSMvqzFf4XfKka2jOVXJmAA0l95xJRjOcbaSNcyNyGYewHEdj9XUU6RkAID+kNJ5rCg8GR+LIkbSdbyMOmpAyuYvdzKCepri3V+/3fYAvQufADsOu+g65D5K6fFDZExmxouBCJLjX1bjEhZe4OYeC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW9brDx6NcfqzvuRdYqDGVS0r/rECJF1IVMWTOZ8JCs=;
 b=cZ619I6B4bE0bAxioCFUmhME05ObtAQFHAvIG0MqDdp132KEk3CyRh6KUzdv8NYmcUBAZWVtwKDH9qpHSakqSj4qtm8a7vzON0g8IBQYuCaACwshre7H9AaAja7XkXqH6SLRnS+TiewMAkyJhHrg0ziCwFQtxmxugVsD07MvtC2zBA6wJxOKiN+Jxdfjs4JQQ9lHtkW0tBcdLE/3fzxntLAaEMdYIzPXCqlw9di2r5Xo/zlNaZKPShvAkcRE2x6QB9fuS3xebnUWMLMl1TqtsQj3gWqM3YFLYVTHkVn4XP4X4wgv0UkosQgA5T+7cQv4l2lVdUVOgN7ebHr3p8OyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW9brDx6NcfqzvuRdYqDGVS0r/rECJF1IVMWTOZ8JCs=;
 b=dxkU3bjIi/gNohGnGUp4E81rvmlYCA5qy5SrnfqF16OEoX1dQOWpKYEvjpWQ6nHhzZHp961tWMDkHP/nRhHwLGfQ8xHfV2G+jzjChUR3m8Kfg8BWGm+YLu89CSc3oPyzrYYWWpEiF0L6/0DCOddA48VVy1B376a0qnXwDLJUYtQ=
Received: from BLAPR03CA0156.namprd03.prod.outlook.com (2603:10b6:208:32f::29)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.30; Thu, 1 Aug 2024 10:00:07 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::7d) by BLAPR03CA0156.outlook.office365.com
 (2603:10b6:208:32f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Thu, 1 Aug 2024 10:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 10:00:07 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 05:00:05 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: report bad status in GPU recovery
Date: Thu, 1 Aug 2024 17:59:53 +0800
Message-ID: <20240801095953.35625-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801095953.35625-1-tao.zhou1@amd.com>
References: <20240801095953.35625-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd8f93a-b67c-4b56-a3d4-08dcb210b930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CEU+0guVeOj27K2dlOGlzLtQOTedO/wF0+NJgNFsbYxj0hjcxUxkV+XKgkwt?=
 =?us-ascii?Q?IUcClZV6DKkokpskiTQNd2GekujwLUT4Iwkem9dFE2OuOmyuAHHG57XQdKWk?=
 =?us-ascii?Q?OWgBFU6k4LXoNOGddaEIz9opeWS4j2qPHAa0DAY+idqGiFN8K0p3MIM2ZlOl?=
 =?us-ascii?Q?C/kFO/+aOIA3VbsQwJ0R98qYHop42aQYifouLJN+45kq104GtM1oMS45aTkI?=
 =?us-ascii?Q?Dofk28WKPrAktYWJcWN6GabzuDXYE+BxaqStTsn3sgk35pYuNabYCszATdsw?=
 =?us-ascii?Q?/dxhFa6dthKni1ATTWTnIrx2+R1hl9fXcc/iQew6on8AUVJZjdacYYVdbbOz?=
 =?us-ascii?Q?nK4yY1vbsKN91sGf3cBS/HqIP5sMeMbFIgZY85e0EN2hk4sWhZru39NpxCtX?=
 =?us-ascii?Q?GmT8zaY+CoLOxo2nBkTwNfJ/BCzxcWpUjc0mmMZZesTM7sIDsjEAW4jDRltY?=
 =?us-ascii?Q?JsAyE5IkNdoY0ZJlLbhPhdR5xBQZc/+8bMQ3nIu2y0SW4JLPKNyS6SkhdFPO?=
 =?us-ascii?Q?FTl5cKqQWn9b+j051yw8Tzy2RSM2TYQB+kQ8iMWTbs6FqqLa6hAOXrXQXEpZ?=
 =?us-ascii?Q?MLT3Ri6FjJQ/0UBxeD+dZilsKIP8Cmpgt/IjB3hug5seXcfu3JJPhKsVXT6T?=
 =?us-ascii?Q?pb73v/siauR+C4XpbRixJJc/X5BRxx4ByatZRKooj44nvO5XybSflHxYfXTe?=
 =?us-ascii?Q?LHtzr1fy6yx1d1pkOwDk0309fnrGq5zGBoD3/OtWJLhu525hqQvVW7ZNHm4I?=
 =?us-ascii?Q?oyvTmQpa7BMq/z51PJT0JbTuXLVhVkZmyzQBa2+XgFO9wAg2vPBGbceRtSXp?=
 =?us-ascii?Q?w3I8JsFXvFc6N7AlClBPgtTOFkOaAdIbkWmD9wz4J/zK5Fcrbpgb6TkK/QE4?=
 =?us-ascii?Q?E51vP1Vxt3+wYWm+556iTlHcZ9Nr6gaN9QtqU10WipBm2rRTs5LFr+IZzwEM?=
 =?us-ascii?Q?7a7a06MitBDhHRvTCBkLtNyaW0beTHVa/f+CxGxPqPqi8f62tVNuBhGGPvzI?=
 =?us-ascii?Q?SFhYoYIpaghJ7NILO0vtL0U85jK+cK0sgqLsizjiKAystbiBUoBZSny1DH7t?=
 =?us-ascii?Q?opd2yZYB973S2MCAZtInsHe1Q5VrijeHq396lq78uewy6dABYUv2nlWey1sw?=
 =?us-ascii?Q?p+TVCvuthjRxOcXP1WV43kw0Bjt0KRPv+qwH48e0YpaN+vtSIkvXjviaoHg/?=
 =?us-ascii?Q?1crH4BaiDcN0xRLncfohBVvnM0IMzjGm1OEiCBH4mPtKafK3Cbw2RKucJYK4?=
 =?us-ascii?Q?6/p7KLVoQI+cLTcwYuRHFcUxudQumxNjR46/hPlQrj7i9jY3q235Kl4LYCfI?=
 =?us-ascii?Q?gXOFJgXXoOb5fHJ9uxLC9ncwLhqzdagBFyaybJJOZ8U0gyuOLH1zqaoywLAR?=
 =?us-ascii?Q?jOLmgbTra59I2wGZe9roORqq6DwMFiyqiSDSDhO9TjLCPLhV6iwsrZeSvRFz?=
 =?us-ascii?Q?/kLxOOnahIYZ78UlZH3B9LAn52CHYYQa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:00:07.5180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd8f93a-b67c-4b56-a3d4-08dcb210b930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
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

Instead of printing GPU reset failed.

v2: add check for reset_context->src.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5d49f70704c6..7b21243c7c55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5921,8 +5921,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		tmp_adev->asic_reset_res = 0;
 
 		if (r) {
-			/* bad news, how to tell it to userspace ? */
-			dev_info(tmp_adev->dev, "GPU reset(%d) failed\n", atomic_read(&tmp_adev->gpu_reset_counter));
+			/* bad news, how to tell it to userspace ?
+			 * for ras error, we should report GPU bad status instead of
+			 * reset failure
+			 */
+			if (reset_context->src != AMDGPU_RESET_SRC_RAS ||
+			    !amdgpu_ras_eeprom_check_err_threshold(tmp_adev))
+				dev_info(tmp_adev->dev, "GPU reset(%d) failed\n",
+					atomic_read(&tmp_adev->gpu_reset_counter));
 			amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
 		} else {
 			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
-- 
2.34.1

