Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3843CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 01:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A40710E270;
	Wed, 27 Aug 2025 01:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5t1BA+lE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3815910E270
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 01:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss35jBd7wAzZ1jSyJ+7Z6XsoWyxWRPA9/FALNCnUThaT8TgBqmRJH+aou0ZAH01Q3eisxs2MaVKftGfXWJuWtbaVJ7cs81q48MkRsqO9Z3azCwppta/Q/BwWsskqEePrsxwrDCDdiZm63BbJK9HwVdCPrEoArTYdtvjPxbflWFx6k2NjAwi1n8mJMlpib/xLA0mZViz5weJ/Ab+/bIv/AyYga0hlEHbi5urYt0kvv8UwAS8mNbfbwSTkocYGxIzpk5l1/nk+8FbvRI7Z3bY4Foj+uC16HAOqjRSvIba/TSgkPOH/MOVyt9KDteajwcuf8uxy/7B41q7huvnfbzbiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRF6HyRv+M/XsjyRN3HJNYZdisrprr7buyozx+2qSxU=;
 b=qT69np8n4k35pDCj8Hoynjro0r85P/SSRhEUk54bGUPQUefou/DPPwr2+9/hv6kjcRoyqevD6tR3k11OpuAaXNI4KQsn+QiCqmR+J/Qu1sB2WL3fhNB14lHa69Ddx0Z0ZXjB3uBfwtgIcTc/vgM9Fy/0aIQ8pJsTR5QMCnyx30GR6NMldZGaJOISWPV3u+kvYn9XxCMWnzxUozpB124rMGuqKGo4W7QuJi4ZhWUO9+wFABHIMreXmiPlbYase/gUWuo6VIffJIuH9xyRB8FsLqOHgQSzeCcSjXZ9sr1P+tGoJlVZK1C1Hqk390E3IqZSk51EcZAmWlUA0hKqnbezmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRF6HyRv+M/XsjyRN3HJNYZdisrprr7buyozx+2qSxU=;
 b=5t1BA+lE7VkrQ6BW5vkeb7sMWnbXsN930XwU5SA1hQGSTPLfW2EqOuV/BSK6GnaZ7bNSALj38KZLI6/w/Xz+0GY9V5tzakz7W/Xhy2SYWlDekUDa5WNo7jtw7HezycdBdQW87fmKWsLlZynkyVEr77H51xkenblpDhBpmVUDZxg=
Received: from BN0PR04CA0179.namprd04.prod.outlook.com (2603:10b6:408:eb::34)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:47:17 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::c0) by BN0PR04CA0179.outlook.office365.com
 (2603:10b6:408:eb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 01:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:47:16 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:47:14 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Notify pmfw bad page threshold exceeded
Date: Wed, 27 Aug 2025 09:46:31 +0800
Message-ID: <20250827014631.39110-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b92b2b-5b62-4a0f-f9de-08dde50ba6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?smT+lyTEQN/aQvopIgUUfubOkgtWrNDX9zK0TCWeNAzuofo87eQUraYc6+km?=
 =?us-ascii?Q?0osSI+cMS6SzPH7RokXTYk5TSeLfNC9u79JtX/9Wxjnf144o59OmKPxV+Fnu?=
 =?us-ascii?Q?SyUrWTyIsaENd1UoxvlBuv9j9j39LONwLX9gzlZ5LpOlvGvgj5WQyHegxnC1?=
 =?us-ascii?Q?uxTeK+wQViT4PjKA9g5K7d70RrsFu51727MSXZRvb8Vh0l6rbv2senS5eU4A?=
 =?us-ascii?Q?d/I2GTgoBxE8jlkkEwisgbvdQsVAx6L1p48VY2Z0cxa8jQ3A2+ox/67qpgZQ?=
 =?us-ascii?Q?OqS9Aw9tEK1/sBBZP582n5GSize6rXABYwK0yV0dV/ThNUjPsX5VLUwJzI29?=
 =?us-ascii?Q?y9l6rrd840cHh2bEPFtFcZ7WLG+UyJmBjV0YzJMwpUX4ddaF5MHFLC+hylqe?=
 =?us-ascii?Q?3PfiYF2idP3MBjx63nARyWUOCQxRq8xRv53GgL6U2NzXJ0SkByQp3cDxYwUq?=
 =?us-ascii?Q?WwI+8clZkUJJbUjdvRgLWQnEslpsPjdXHBOd9uwyKy7GanTltKi9/7X/af1T?=
 =?us-ascii?Q?JpwzS2rrFMkobyQ7KaA9DlO+BdciWgIBU5VkrfNvpphooIAT2CG8VZ7JsrWw?=
 =?us-ascii?Q?qw/JdKNlvr0A1h4BQjIXyjrjvJ4bLN07WPNN/lTFUh3MDCalZQFL4Dp8tHF1?=
 =?us-ascii?Q?q0m1CQrazaJzvEXrMW7UkDMtgshijPEO9Jf8wLT3DPizXFaIoA1jGJrpm+x0?=
 =?us-ascii?Q?F3g+OTHL2LWM5V3V4gJZxS2/xcBFSIdFI/V4dQh6Gb3jrJuT/hi2PlgW9roy?=
 =?us-ascii?Q?2U7Dte32Qlib9XGYgMYf3yNK+RptZk+KFiXkYii7MWggpSd0ZUwjSp8SKCLM?=
 =?us-ascii?Q?NizLoUQ20LFiKb2ypgjdT6I1HWmtrs3dTK/j0YgOw3DGfgAIvAGtnJNNTvZu?=
 =?us-ascii?Q?mfGX+Au1EAUgQNPn35AJgR2oJW5A5XXMOgryR2mVplNaPHMYSdXMWu33elZ1?=
 =?us-ascii?Q?NYvIuaFIvs2tPQ0Wcq/tiNEN5cbczBp6VW06CkaOtlIyInwnuRqZchggI3px?=
 =?us-ascii?Q?KApwGDxLdYzNKCqnRlno+0PA1lOMNWWRL7XT+MyGpOSjzn5RZtpKYQ3+hDI+?=
 =?us-ascii?Q?Sqxak3VLxPKbs6LfHMMQhsE5KHNte14cP1D/VuD/JdC3hL1vU2MZxFLcU1zM?=
 =?us-ascii?Q?r5ByF8Ppj2cPAfq82MGJeQ0mKXfzf3onxPXC5HUFWt9OhKOkVcASSIDUa/1s?=
 =?us-ascii?Q?2xUocja24s7nNp2/ahXOBNOJ1GVe8oydMO1VP+5UmV6FIgEiXiny40UOMOH2?=
 =?us-ascii?Q?t+lVjx6hQCUnvn7LjPjIl2PzOUwdMumNeu4NE+3TF616TjdfiHTIeFCAMMy4?=
 =?us-ascii?Q?f9AZXJFXh0RGdzKHch2SFunoKXPQkm4ouDgG8nsX088K9A7JlF43NAlZZU+n?=
 =?us-ascii?Q?JVHOwtohwChwaafb+OpFI1W51SbkKKJREFyOS60/55NA08oC5KYrbycN1U9V?=
 =?us-ascii?Q?M9yWnGC9u0qPTF54V0EbDZvKBJ9IFtkoaOqHXyrEm0UK1/xCC5ADJChA4qas?=
 =?us-ascii?Q?LQXawT0gh7/+ZKizC+jKOtqrAbKj4SCjkz3v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:47:16.1969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b92b2b-5b62-4a0f-f9de-08dde50ba6cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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

Notify pmfw when bad page threshold is exceeded, no matter the module
parameter 'bad_page_threshold' is set or not.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index e3d7071b5853..5d5ff95d7efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -775,9 +775,10 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 				control->tbl_rai.health_percent = 0;
 			}
 			ras->is_rma = true;
-			/* ignore the -ENOTSUPP return value */
-			amdgpu_dpm_send_rma_reason(adev);
 		}
+
+		/* ignore the -ENOTSUPP return value */
+		amdgpu_dpm_send_rma_reason(adev);
 	}
 
 	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1)
-- 
2.34.1

