Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79FBEE20AA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E7988DE5;
	Fri,  6 Feb 2026 14:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UneNlgSx";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4640488DE5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWBTIBBxZmQnu0I9mv9Awgwq9f0Y8E2IZaDq/4cSvs38KvLA02OOSPaek6S+hZWU8sNlWtFOAYR9/O8t1LSXNFWBckuC1x1tl8FFl7y+QxiLIsiaH1i3+VockNR5vpmeT+OhiFP+9efWDYZEGjXFQ76lk3mISUlEdbqUhwDGydZEEzkD2DRu2tUASS9o1VLG62MIxRaa5ATg4PfXQ7ywp9Lf+vQjUuyJM4Z0wOdWrIxObKHTwl9ZWFUYUcbKWre+0LWhufwQtXzWVtTcyDIcJe4sk+89EsDqkDUCtU76Gxgp8V3L5F1QwMK8XzYYKnNbTTTl6wvBp6B8cMW/Wo/w+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORxPc/xWilVrOg96RueMO6FEjbFmvDFqUWbjKuNhfmc=;
 b=JPazoQtDEBXAt7oyaxk4rJuPjxqvOya2z3I1G7Nq10SkHQ7VmaSqAJkisVDltpHANTV2OAzRVNoYGSnDTXPZ1X/6vPGRrwx/1xT7R8PxXMHMJuvDqjw/5QigwFkZqthl1Hhtrvr7NUMFqZsK6QSmHeDuk/lq2SphJgRhSgOqd7YpkaypIR382KTJnPlKNx7Pto3vtw6GkCYTmQzqSzKh0ucLT5Ke2uPJVdN2JXEo61DpxGXI3u3ZMI8/HK3daZsH05HbHSxgQ3UcwZAK7XSYz+Cu/3XcZ/s43718n5NG3yy+hpXLvbsqgcOV7G49gacB7830t1Y9T3K9RA/UMDBuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORxPc/xWilVrOg96RueMO6FEjbFmvDFqUWbjKuNhfmc=;
 b=UneNlgSxJvxE4KlNUnWc8ppWGV/lIyP+hsyR4BJnlWnblXgEKD+CrB3mA7xoivmo+waJrW7g2x+v2k/r1tzaVLbNg2vWjMcsqGP80Md6pLvqkI8bFLDnWMigxrrTeSPWjAR6UQ6TydWPoO85DJOvvwr9+Scm5kytp2XNnxOoLpY=
Received: from BL0PR02CA0116.namprd02.prod.outlook.com (2603:10b6:208:35::21)
 by DS5PPF266051432.namprd12.prod.outlook.com (2603:10b6:f:fc00::648)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:37:48 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::f5) by BL0PR02CA0116.outlook.office365.com
 (2603:10b6:208:35::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:37:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 08:37:44 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Harry Wentland <harry.wentland@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>, ChiaHsuan Chung <chiahsuan.chung@amd.com>, 
 Roman Li <roman.li@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amd/display: Fix dc_link NULL handling in HPD init
Date: Fri, 6 Feb 2026 20:07:30 +0530
Message-ID: <20260206143730.1477825-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DS5PPF266051432:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a74e49-9716-4bb3-2756-08de658d4c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGVScXlURkNMb0VUZk5xalRPR3FPSkFYMmxYdnZEVjdoZDhoV203U1NuRGlu?=
 =?utf-8?B?dXFCYkFCQkYxYVRWejZ0U3c5MXJLbmxWWlpKR2F4bDRLNGt4NFA3bDhpV0d1?=
 =?utf-8?B?OEUrUGJsSGU3ejlQbEk5dk5WaUJzVkFPNitoTGRSclRKSDNLOFdYRWhRWTRW?=
 =?utf-8?B?cllxNGZ3enMrUGFzMkkyZDRmL1R0MjRFZDVKUkxTUmd6SmlsamNjcko4VUQ5?=
 =?utf-8?B?SHRRWFdNZ3c3dWEwYUxVN2NoeUJtdzVvTkZmSXFCdUcyMDFxa0QwYWxzV2Rq?=
 =?utf-8?B?QkRPK1NxVFJla1dJdzZvb0h3UWJjTFlCQXFKR0N3ZzNFVDEzQXJYRGk1MEJo?=
 =?utf-8?B?ZlVvTGtYVmpHaXl4WlJIVWJsVUJmS1FmeER4cVY4S3d0ajYwSUUrVnNCY25o?=
 =?utf-8?B?SmxOYVNCZkErOEo4T1pEeW9FT2FXbVAxd2xwRjZDQTVXbXVkaThKV2oxN0JT?=
 =?utf-8?B?TzY5TEY2eW5MQ253UHhXZ0pRTHYvakRCZlNzUnRWWEp4bEZsYk5YT050OWF0?=
 =?utf-8?B?WWM1MC9wOHU2REFDbE9sSGw4bEVQdjljNjB1anA1N2JzejJScDJDYXZRNTlF?=
 =?utf-8?B?Z1hFZTlWSVV6TnUzY0pHMXJQcmJHeWFoMFpBSitkdW9xQStGTW9Xdy9CREI2?=
 =?utf-8?B?dWlOT3RXbUtmS0IyTW8zM0UvcE1TUmVmVGV6OEJoa3pKVWlSSmNZVWlPb05P?=
 =?utf-8?B?bVBvbnRONnAvUzV4QnBlUnozQ08xWGdoOFhiRXpENUNIdXd3M0FhNWpFM0lw?=
 =?utf-8?B?Mm83SWp0RGVhNmtxaUEvMWUvTXZVeDRId3l5UVZ5Q09leHUwa1dqb3hvbTRk?=
 =?utf-8?B?eXpqcXZ6c0VOZkJ3bmRDWGZ2TlhxVGVSK0VvZkxMN2xzaEU0Vnh2Q1pYZnhI?=
 =?utf-8?B?QWlTOUc5ZjJCSkoxYndkd0pnbWJqa0Z0K051dzhNbE5pVFprbWducEJuWDgz?=
 =?utf-8?B?Uk9ESFZkanAxNDlKSGd1dzc2N3lONEJXWStuVFNSdm5WcEFLaXJPYWNnMFpM?=
 =?utf-8?B?d1pjTWJlbHZTcUZlZmFMUTF0b1FRd1RhcVk1aTJiYU5hQ3N6TldPY1dobkNy?=
 =?utf-8?B?enBXODIySFppcmt3d2ZTOVhqY0grZ01pTUtnZXMzNkpVRlJYUWEvcDRtSjYz?=
 =?utf-8?B?dW9FSFBSSjJBTTJmcGlNTCtpVktkcUN5d0hkWjk3S29qblQ3MGFwakhDaGRi?=
 =?utf-8?B?VXdabGRRcEJQWEIxeXk5VkZmK1h2MEI2YkZ0ZTBOUnllS280VVNtRTN5LzVC?=
 =?utf-8?B?ME85b2lOeUxUNHJYUDN4dmNHZkYxZ1BWT2lrd082TGlORUNuai94UzFXWDJJ?=
 =?utf-8?B?dzE0NkFUcjBpS3ZiS3pxUEdGWXh1RVJKY0JUZDhwSWM3a2pBRXBrOWExaWZI?=
 =?utf-8?B?UFkweDlaZ1BWUVErMllaK1M0bFp0ZzNrZmtybzZCd2ZiL1FGdVB0Ui96TnFu?=
 =?utf-8?B?Vi9MZG4xRUxKZGNydVd1Rmt0VzNhcE5yZlBmVThCSndGOEZORE0vcTB2Y2dI?=
 =?utf-8?B?eXoxSloxcEdwdWdybGtoMnF1eGcyODRDYmc2UnB3bjBWQS8xWU9DU2VFQ05B?=
 =?utf-8?B?TFlFTTZBTkxoek9zem5oeGFQM3czdW9mdHNmaTl6YTRFV3RSejRkNVdyWDRE?=
 =?utf-8?B?eEFnbitQMXZraTArc1JIMDdjYXBINXdKVWd0cnhaT3g2d0NqSGlqdUZ1eVF4?=
 =?utf-8?B?RWpvRFlLUFdPdW5QVDkwOHJGeitnTkd1Qkd0b1dscFBML3hpcVc0N0NMVFVF?=
 =?utf-8?B?YWxnSk1iaFBtQmNIRng4clNFOHFiQ3NpOUYwM3VkOFVrRTZyeXZrYnByaVFB?=
 =?utf-8?B?eldhTGpqWURkalhUT3kvUG41cExMdWIxV3hoNEo5Rkx1RnNvTWR4UG5OeWFX?=
 =?utf-8?B?dVdSQXhsdTFhT1ZyWmNLbDdkbjlZV011enVoOVQvRGtGekc5ekttTHU3S2hN?=
 =?utf-8?B?T2g0VGNQMzJBR29BTG1Ld3pRZWhuK2dwS0dudXF1ck9zaEJUMWtBTnl6U01l?=
 =?utf-8?B?NHR0anBPaFBvQThzVGdmRUVyc0VnbnQ5eTdmK1c3S0FyMWhWQklXQ3o3ZDUv?=
 =?utf-8?B?U3orc1YrdUwxR3VaSVN5cU5FV2xCZm91UmVscGE3Tkhsa0pQNENBMFJiUXh5?=
 =?utf-8?B?K2hCWG5DTWw4K0gvK1lwdUF0RVZaUlRtK3FZSkNKZVhNUi8wVmhET0JOWFRo?=
 =?utf-8?B?TFRUSXU2d3hUakM5dzVXckEvdHo5VkQrbWdmaEpPV3dyK1NkbWpTV2VFVm8z?=
 =?utf-8?B?MVZyamFhTVJ2ZTQvc2oydThkRVJ3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DalBqQ+CKiv6a3qFlXmR5dxW571BIKtMhJOSIWZqWIWOdRrNaVBeh6wrNOIQWEtOit6UgWkDK9+feV5bzeZu2FAgbZIRAwG+lrqtpctFO2yK8YM4CoZdvZF5ZBCqpth6xvg7irHjjC61yBe5FnxXYWhDdvgCM+PpV+24v/hWuVqB13g42opVQaEt9HKvEf7iOa0quXSQ4/dMcSFOE3C3AcA0yUp0Zc35wu379dRHFELPIC52q1uD8hay2IaFgEK9lhj00VaihwC0rge7GwSorwu4R8KQfMNJELawgNU1N/095E3tT3KqkG8c2b1pgfmxCTPQBY8fWc9rnUMDlCB46w1nuaSTomWKoK0qKgH+FyDgIsg5+mvNW2pmyo9V6toL/0+EIGBc4LGkmo/aNwL1W56RmbA2uMt+gSogSl9g12QJcZAPgPslweJcclWQQeRC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:37:47.3744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a74e49-9716-4bb3-2756-08de658d4c10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF266051432
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

amdgpu_dm_hpd_init() may see connectors without a valid dc_link.

The code already checks dc_link for the polling decision, but later
unconditionally dereferences it when setting up HPD interrupts.

Assign dc_link early and skip connectors where it is NULL.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c:940 amdgpu_dm_hpd_init()
error: we previously assumed 'dc_link' could be null (see line 931)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c
    923                 /*
    924                  * Analog connectors may be hot-plugged unlike other connector
    925                  * types that don't support HPD. Only poll analog connectors.
    926                  */
    927                 use_polling |=
    928                         amdgpu_dm_connector->dc_link &&
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The patch adds this NULL check but hopefully it can be removed

    929                         dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id);
    930
    931                 dc_link = amdgpu_dm_connector->dc_link;

dc_link assigned here.

    932
    933                 /*
    934                  * Get a base driver irq reference for hpd ints for the lifetime
    935                  * of dm. Note that only hpd interrupt types are registered with
    936                  * base driver; hpd_rx types aren't. IOW, amdgpu_irq_get/put on
    937                  * hpd_rx isn't available. DM currently controls hpd_rx
    938                  * explicitly with dc_interrupt_set()
    939                  */
--> 940                 if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
                            ^^^^^^^^^^^^^^^^^^^^^^^ If it's NULL then we are trouble because we dereference it here.

    941                         irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
    942                         /*
    943                          * TODO: There's a mismatch between mode_info.num_hpd
    944                          * and what bios reports as the # of connectors with hpd

Fixes: e07945681dfe ("drm/amd/display: Only poll analog connectors")
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index e7b0928bd3db..5948e2a6219e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -919,16 +919,15 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 			continue;
 
 		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
+		dc_link = amdgpu_dm_connector->dc_link;
+		if (!dc_link)
+			continue;
 
 		/*
 		 * Analog connectors may be hot-plugged unlike other connector
 		 * types that don't support HPD. Only poll analog connectors.
 		 */
-		use_polling |=
-			amdgpu_dm_connector->dc_link &&
-			dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id);
-
-		dc_link = amdgpu_dm_connector->dc_link;
+		use_polling |= dc_connector_supports_analog(dc_link->link_id.id);
 
 		/*
 		 * Get a base driver irq reference for hpd ints for the lifetime
-- 
2.34.1

