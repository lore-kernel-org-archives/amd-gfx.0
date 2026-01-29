Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B390AD3569F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 04:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CB610E7C5;
	Thu, 29 Jan 2026 04:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uEpkfErc";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A717A10E7C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFgJi8tJz7TUY1SQbDDAdRK8HEACpxRyDd8J2YQDONUlODwDiAXzhGBkCPx/B5zl/npvaNBDQZrSBUXjxw+Xaq2Sw+fSjch0eyAvhbAhJWrYj5MfU6vmHMGsN5eXuuCnKwLUbkmfxNeFR26ZmnZ24Hn/i/+7Yi73Uo7Dvy01dJQyjGPQsJO6CJs2P1onbAugdUFBmS2IiLwb4O/SEXCez/VAx9HKi5skQk4L92V29JDrvGMIA+Qjxd17qetm/lDd+BMLN+SqwYd0bGAZo//hvxr5u8ePnMkJSDp5AuLiLk+m1wWNWq6rgHqNZ9BEFeufaKNHkuLGTnVItIXrmeAUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL2/WI/bJFEwIHrFNWTNHhxzqfYMvl7Q8aFAglbVXMI=;
 b=lRHJ1h6cAv5izluGFP113AH4TDRZ97/m2aVZaYywz0h6bcRfT7o7p738FiPkeJcPNzgdIQCy0GV39M1lh9djde6M3A/MdCjHojMJcMnLgb5f83QaI3f18n+WoPJgL+SVC/HG10hhxBzEsFm45lPUO761e6F0qJOnitKovaGwBGLbJIzvXQ/oAOKKospsqbo5dRHAL+nNy3Mt5CltlKZBrB/NwUc/nD6ixM5eMS0DAjNHCVqy6Knz+vOoM3VBrh+o2i69bKmRB1pM7tTz4u8gvNUYIR589Z7QvBWSF+eecC2/DrAoPOyNpkkPnZyloBXxyQ8W6RdvFm4xeJPF87cDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL2/WI/bJFEwIHrFNWTNHhxzqfYMvl7Q8aFAglbVXMI=;
 b=uEpkfErcfe1cnYV0okedEPDYA2hJbd3cez9oxVpQOA4cEQ382hyaEp34N8O6Krx1vxL+I+cWntzBmx38/Zlow9Pct+Za8rwCBXL918p8LebXE2khmPMOsLReFtuvI0gtUxz6C4mm64s15qCrLaB+SFX143gfng1Uusb2Az4R6jY=
Received: from CYXP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::7) by
 BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.8; Thu, 29 Jan 2026 04:39:47 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:ee:cafe::3c) by CYXP220CA0007.outlook.office365.com
 (2603:10b6:930:ee::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 04:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 04:39:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 22:39:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 22:39:45 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 28 Jan 2026 22:39:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: adjust KGQ reset sequence
Date: Wed, 28 Jan 2026 23:39:35 -0500
Message-ID: <20260129043936.33607-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f3584f-c409-46aa-2bba-08de5ef06e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6qF6diApJjdRb09HoYqNvRitWS82J6Gb3IU7Z+Sk7SlH8qOPmLRgU55oe/iG?=
 =?us-ascii?Q?eXSkhH+QPBSEYh+pmdkK00fGOxJr1OMS6u4uH6pQ37JSsGNA1ZcSlmPHRHfW?=
 =?us-ascii?Q?kolApDrucy9yWkuvhBADzrf8eGfyD1gsrRGs5nLu0HOCOJBAol66WbZt9F1Q?=
 =?us-ascii?Q?Mu1eDgs+SlTTVAGci06KYkYNv/Q8lXDFQ3ETaKoM+L9N9tkidDmVeFLfRYqp?=
 =?us-ascii?Q?oN11Rb4zYWJlH6nAUOTfIfsZUKNG/6F9TaTur+BXFZr56f8/IseVhcQ5FXRY?=
 =?us-ascii?Q?WH+TZitmEhINBnZxDQz1gN0D7kIFBddgGey70Op1wbsIUbjIqs+gAdgt7eAO?=
 =?us-ascii?Q?NRmE07FzPd3s8k2tthnaoz/BZ+1u8A6LfTwOzV1ptOb5EzdfDNObOrDxlWg7?=
 =?us-ascii?Q?AOvS7M+d7iqsylQEAbTOPEmFXAFlipVUmJqV2LSgbMXkDeUrfCZrhzK7iuWr?=
 =?us-ascii?Q?nK/7+/QWmE+o2I8hUJwwf/DkThBZa8c/VnM/OBxtbBfAyUyUE8NalSqlO20h?=
 =?us-ascii?Q?/e5XQpJNofOZ2UtLA0WHuxeJwoNvJEBKeuMS1d9rUcSGgIw+RD6UAnzV/c4U?=
 =?us-ascii?Q?8H/aN0hiddX0wk33tOIxM2XmND9sgMpIdkNgVz00r9BHIr9LHiX5JDW2xVh6?=
 =?us-ascii?Q?0ccDr3np4aj5Q+xuM62vE/MJtzLwhoZcDkAZ/tvNSi6/2jun4qXiNKP3MxdJ?=
 =?us-ascii?Q?flcPu4lOTXIwhLIP2f3nYkUUWCFbMPMwlm492+WFHsSpiRygv5vLWxbeRP9X?=
 =?us-ascii?Q?irodJeNHdPQGGlYsC1Hqs6yZVAoGy0nlZlki40hBKwA1FJSBgwlLN90XiOpD?=
 =?us-ascii?Q?CusAlvCWi0/hiHig83tRRqNGL4lFRzJeNU1/wfZWuSEKx3vGyX3trSGr7Lkx?=
 =?us-ascii?Q?Htb27C9WP0Y5aU7UhQD80CnCqbLjxHSGYlswEQx4oFjaVPpeP8Pa/l8dgGpy?=
 =?us-ascii?Q?SaBHtQjq2XlvuDGaLz6rDg0bPvL5xTMTvBmNijTu8dX+PGt48GQAOZMvibqE?=
 =?us-ascii?Q?8lj8WTpI+XaQLfobfFS5WPGww05TalzK/HSDo76PAyqZD/7TgzC2/Wvum5om?=
 =?us-ascii?Q?ZdQm00xCVPOPObDAqRuDHPzIcbBeX6OJfqCN8XT4tUKL2ubW+56/FPL0dNj2?=
 =?us-ascii?Q?+yQkbcUOIlGn6Rb5EA77sNEqgTI8AgwFHavaQuU4LFxtsbY8K6SMzfNumPPJ?=
 =?us-ascii?Q?2LvCurtrtiouvupZ2XqBhp8svvbZ+K+Ui6HO0lriAAIDDp118hDXb8fA/4lS?=
 =?us-ascii?Q?UpMz0umuq578FXvKQamQkD5gfPBj1zSYg9PDYuXqtc1Vr06np4R/PvRI0WL1?=
 =?us-ascii?Q?P6DOpCvVIMs4uZ/HApu7Y43t/WToHEReVBX2aPy0L88FYJDMWn3LWhAhdcE9?=
 =?us-ascii?Q?/CdnENa5Y5rKvyJWC6kFf61YhosmYlVGEZerdChcrT6hrcAi9L6m5JHtTC8A?=
 =?us-ascii?Q?57xUIZe0ice8K5ku3oGMoFNwif3MbWmpFrLNxhDprNO9ZGlHuxXM2QtH3/qL?=
 =?us-ascii?Q?vqPKfzNZFLd9Zyin18fbMr/SqVXeTaVUrdkt6Bv8PLeTSBSrtFYCoFvuE9zM?=
 =?us-ascii?Q?fU2Nb/0YUKBY9BMr3zbwWq9YlvemSOaNHfL4cCwXg64pIePp4n5Qfg4MndE6?=
 =?us-ascii?Q?LQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 04:39:46.3391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f3584f-c409-46aa-2bba-08de5ef06e13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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

Kernel gfx queues do not need to be reinitialized or
remapped after a reset.  This fixes queue reset failures
on APUs.

Fixes: b3e9bfd86658 ("drm/amdgpu/gfx11: add ring reset callbacks")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4789
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b5a2d09fc3469..489edf517f91c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6854,18 +6854,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = gfx_v11_0_kgq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kgq\n");
-		return r;
-	}
-
-	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kgq\n");
-		return r;
-	}
-
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.52.0

