Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515A0C677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 07:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF4D10E354;
	Wed, 11 Jun 2025 07:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYNjVXh7";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 548A710E354
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 07:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hN3rFAcfE9BlFB4PfEVKNNWU4IwYz2QD5DAnJreOnygY/1BWfyC2D5fOq1pLwbRx9Yyh7IUE3fsI+xyA9odnYCVSpfZZmBTBi96UtbsPOU25USxW3DMqZBcHgKKncYP4SbAjBWwcBBOjbKC131vatH9znmWZGZ6t5Kkf6msNOAb5JXToEggDhEj1fXJ1jaozKaAI4kbNJkfOc0ji7/qvrznEi89u4mEK+e9TU6ehFkJU28SVtnjw9zBuhK4rzit9dDRnGOqjPH34du0Eh8V8mEWGfDwCPofOkcCJHt4I7/R2VKkuuDEiBLffP2Izjtv4UHiVs6MLyI3yFuVPgQs4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2/hR6615rjjp5DhSR9pjZS/FwplU0FLRte/oOf9GXE=;
 b=CoNzMTRNP552AEB27vfTYX3XwLF3hqAPHVCV4gkLq9bjRcQ/LKZOI4HcgMDPzwNgYw6VVuIUcOvfLEuR8L4hMNX/oX4BVClTxPlNA2TDdO5z/ssgt1D1Ou4E5hJgnFo0I/lmnKLNLV2WM8KuT7+/M/FXcfVXmlckloPTRKpzTrjbN0DQH/vVTgSA3beGt3zpXuVlGo+Y7/zIfEhdu6RcUYw82aMDom/8VybjOGf/HLcmfXmx9Y2YPFaXcpDhYO1Q+mhG0+ihd55H+mW5puGnzAAJR+BHeS2LrIs5CQtoG/L4HsThhhOLLsvhRh6eXAJieF4jX3v+HVLcx+iMe3LYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2/hR6615rjjp5DhSR9pjZS/FwplU0FLRte/oOf9GXE=;
 b=CYNjVXh7vb83/nnUMTFNkHifm7qDv7CC+6iTmE+vL+p3EfK+aSgta6u5ztHqW08PMjyX1+L6JsszerclaKFBMs9Wv87lM9qXaum4A77aa2afoZJKBGZ69AHZFWgIpS+ihqpeu8zln2qp96knMYItqN2VOnj8b8riE1iFfYcq3gU=
Received: from SJ0PR05CA0194.namprd05.prod.outlook.com (2603:10b6:a03:330::19)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Wed, 11 Jun
 2025 07:17:02 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:330:cafe::a) by SJ0PR05CA0194.outlook.office365.com
 (2603:10b6:a03:330::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Wed,
 11 Jun 2025 07:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.2 via Frontend Transport; Wed, 11 Jun 2025 07:17:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 02:17:00 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 02:16:53 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2 V2] drm/amdgpu: Fix SDMA engine reset with logical
 instance ID
Date: Wed, 11 Jun 2025 15:16:52 +0800
Message-ID: <20250611071653.3311129-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e3c9cc-35d2-4cfe-b17f-08dda8b7f62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qFS/nX1jWVCE3pbGjv0Mm5H6LzhcTEkubInZzN1PK+ZhNW2MR0KmDHHl8oLI?=
 =?us-ascii?Q?xHvbBkHW5GT0iJK+KXzIFL88tSi/+EN6jmFvtgCya9j3QbRHRtl2f6mKQtIs?=
 =?us-ascii?Q?4dAyphfCRpojgqAKCq4zfC+x7yuztAzWlGqxWJgGg4ArU0OLU9ARiLzF2NIL?=
 =?us-ascii?Q?Amin9yklno8xTzUArkmJGelheUwk2BeHJ0xPk71bui5jE7/UT0DpLuXCgOai?=
 =?us-ascii?Q?TOUKHHp5M0DQ3WSj2kzG2l/xNwRCPJVNowiKgHy+o5xPFUTOIYnh2ld+MhrH?=
 =?us-ascii?Q?4jqHG6O/5ihLRHapJMdLHpWOfRitF/3FlqZjajYs06KWaCYajLz8oz8HpV1Z?=
 =?us-ascii?Q?D+5pNgtsgvpoMt6LvNfqsiHxI3biph8d5Vm9+q8whiOOweY075E2l7DhOn4S?=
 =?us-ascii?Q?vRe2P5lx4FTz90d2Mll0Ajx6QN0jDMrUtGVYoynFxlq0V/y7kYNKbCxLbCDq?=
 =?us-ascii?Q?jjWZb2qCF+KLfaJM35CL8KmB6jSq075SJHl9Q08BKHBGqkGwsGYZZ9O7H/DL?=
 =?us-ascii?Q?EBxCRNYNOMxx79NVOjCsA69J0de3RDhhXcAc9KfGE6AKw61REGh37R97GBfH?=
 =?us-ascii?Q?cwjfwQZg/Wb7BREtu3Bb/+XTsVFqVX0y+nwGATloUkkBUytRjgk/3B0cAwqn?=
 =?us-ascii?Q?hiTeDdv/YBWzQePqa3SfZak9U/sDgH4zSoZL7po1XxtuS/b009AVqUFUmGnq?=
 =?us-ascii?Q?Ch9xhtO0qLemxVwo2Jr6bqMn0ANHfp2rD6QO21jKI3TZ7nm1mLveSsbbLbR4?=
 =?us-ascii?Q?S6upi+d5xDEM5ikdWhHwfqN6WU1M8GWsxvemMJC1qaDW0VtNsrwKacyhTYVe?=
 =?us-ascii?Q?Hv1riWXP1NRYFaJQtiFjuwf5AjHwFN7X+rqjOGtcIso3tWTDCuJsAO/14Lmz?=
 =?us-ascii?Q?X79BdOUHiZvXh6CpdCRCNhFj8wJEqapOG54yxxSFNvkU2gG/1yZMSuwruB7u?=
 =?us-ascii?Q?TxkTNr3RLicfZeNInQFPbxwf+31I6RR7mDChxvpf5WfBs4qn6DbcnVENQEAI?=
 =?us-ascii?Q?ds3IefISifXJ+9Fwbr2RvOO5P+RZFe4iOr7+On8lkuNb7S7uOvL9wPQvCoZ/?=
 =?us-ascii?Q?uURjT4K9fxIEg9ZHVMutyVdUPEXPB8SI9j72ZoOmvJ8FdIpuFxDsfTi1I+AU?=
 =?us-ascii?Q?EzW9PAMmzze3RpE3SvZV37yHgmydXtACJ/ttDY7oZhI8puwgJizUAotzbEKI?=
 =?us-ascii?Q?ZCbXsm/rqkxdDVYXub9DBnopTwGffVbxpTqkRvtuL/HRfOq16gpy824hiCKh?=
 =?us-ascii?Q?wsG8iGdisj+kKycUgWUjsL+N2ZtTdrdcWgUuYUQXepxX1HDFp0+O40UH3Ucf?=
 =?us-ascii?Q?N5Kcgn8tdxjqsLmcyEDN00XbOe2z916QaE056bgZ4f4jmZGSSe3JDQ7dtqhs?=
 =?us-ascii?Q?kP5CJ14sc5JlB6d2GD5lXjpVyX9ixrqfYEUSsANn4CglEyEGcALRkZdkQnll?=
 =?us-ascii?Q?RaOLkm4mOahIi0fT0uPeYNDkNDuELUt2qxOXW7yp6VmjoMwa6JvS/ZCs8lDC?=
 =?us-ascii?Q?id4WRLdz44wJCew=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:17:01.7605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e3c9cc-35d2-4cfe-b17f-08dda8b7f62d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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

This commit makes the following improvements to SDMA engine reset handling:

1. Clarifies in the function documentation that instance_id refers to a logical ID
2. Adds conversion from logical to physical instance ID before performing reset
   using GET_INST(SDMA0, instance_id) macro
3. Improves error messaging to indicate when a logical instance reset fails
4. Adds better code organization with blank lines for readability

The change ensures proper SDMA engine reset by using the correct physical
instance ID while maintaining the logical ID interface for callers.

V2: Remove harvest_config check and convert directly to physical instance (Lijo)

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 6716ac281c49..59085e208044 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -568,7 +568,7 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
- * @instance_id: ID of the SDMA engine instance to reset
+ * @instance_id: Logical ID of the SDMA engine instance to reset
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
@@ -581,6 +581,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	bool gfx_sched_stopped = false, page_sched_stopped = false;
 
 	mutex_lock(&sdma_instance->engine_reset_mutex);
+
 	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
 	* This ensures that no new tasks are submitted to the queues while
 	* the reset is in progress.
@@ -598,10 +599,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	if (sdma_instance->funcs->stop_kernel_queue)
 		sdma_instance->funcs->stop_kernel_queue(gfx_ring);
 
-	/* Perform the SDMA reset for the specified instance */
-	ret = amdgpu_sdma_soft_reset(adev, instance_id);
+	/* we need to convert the logical instance ID to physical instance ID before reset.
+	 * then perform the SDMA reset for the specified physical instance.
+	 */
+	ret = amdgpu_sdma_soft_reset(adev, GET_INST(SDMA0, instance_id));
 	if (ret) {
-		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
+		dev_err(adev->dev, "Failed to reset SDMA logical instance %u\n", instance_id);
 		goto exit;
 	}
 
-- 
2.34.1

