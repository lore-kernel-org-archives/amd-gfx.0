Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D2BC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 07:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B5F10EB24;
	Fri, 11 Apr 2025 07:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zjhTRIC0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27A410EB24
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 07:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqlUE39fxPIXTz9p4bDqWy3L/PMow9nq1fXppL97G5qIGr7MmFPuQcuUfPGZ2wprXv3PRcauoT+hzj+aU4LQfj6uwYF3eDmaSknVbJnu3vhGhBZF9QmtshYXvFf2MbjgwdSjESaW4dHTQBug4hdnl+4R3uBTOLoXK4l5SApQIfQlaYqSsZ6uJxQ371gNCd0F4PbuCMJXt3T6rbPFHobSdT4nPoqvv4qXSbZUeWkEym7/2IiXop3+srjOtOr0xtJ8xlslEYLFisjlx+Bk8vqASRZngCduxek5QBHSmXX9XaecPKqNcB3frQsFRkl9fT2mtpGcLuMf6C9vHjP1Inxy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYZIhcsoN7jaYSyJGhJBc9CAmol3yGSZzn2afyX0xLc=;
 b=Rs0V6DlnI0sCiXAZzJj3VurBv1Y86IpMBLw5WJtBo2/D4haBr4AxEY7ZcP3IoWMyhonPMBqSJx5Ly+NTH7EWVHjZxGyn8coSntjFuieHSX7hXV75MAJSk9yxXR26xU5PDmodZDoKw4cC/Ll3G7ig/iINibJhEYCkBVXhPbSIzqb72g+l4BhKGf0hm1vsalwk6h+3H7wP1JCa+yEjpiK9nh+sc8QjlcDNlExRD5hCFfaGobDgX8WJ4lQxCGf5stLcshzoJBz2wj0JXdqv+IagsksqaEBLN0ERSlYVFXMpxDlC9BC3NJFgjNcFxrvI8qxvUd23571zxEqJWZoGHxF7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYZIhcsoN7jaYSyJGhJBc9CAmol3yGSZzn2afyX0xLc=;
 b=zjhTRIC092pmnR0sTJNsS0OtO9+bShqdHPx6AdwysYGD32NTfOXrO0t6+pPWeRs7nD2GyA+tIFfm9LsrV/7a/IpME45PxnKnjMvMI9qhQm3Lmq10f8XNboqRrAVHFTb6Yu7ismtS7703TyGKKlG+SVLtgQCqVmVQLWKm0EJmil4=
Received: from BYAPR08CA0038.namprd08.prod.outlook.com (2603:10b6:a03:117::15)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 07:42:27 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::ef) by BYAPR08CA0038.outlook.office365.com
 (2603:10b6:a03:117::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 07:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 07:42:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 02:42:25 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 02:42:24 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Clear overflow for SRIOV
Date: Fri, 11 Apr 2025 15:42:22 +0800
Message-ID: <20250411074222.1055228-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e1373a-a192-4201-34e4-08dd78cc67ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1UZFLX1OeNgyiq/TK/oaE6wdPANMStENj/qHt2ptG1nz4eJD+khDs7Np+9s8?=
 =?us-ascii?Q?HC0I2ex9uYuzYL74JSEDFD6s4fMre5LkGMASTAOLn8Vq3pLXnT9/nACP426O?=
 =?us-ascii?Q?7cnUq+5o57YCEn9dkLYxrqQFquBQWkqJ6wgj4FZRcxrGCIm4rPyCGN3Kz8vo?=
 =?us-ascii?Q?dRVWLP9Tmb4pXvZIvXRq88zAAmXTWpwYktr81Yz2tDrFkQ2tAQhApXdDCdh/?=
 =?us-ascii?Q?uW5nlM6UrDFiH9ccxFWTS307pnHpJT54UagSEwbG4JJ0kziw1I6qP+z4j4u4?=
 =?us-ascii?Q?GfsABlQ7uE0iJ6SrPR08AqPpvzVBiDf7EUwf/vh7Gmeo8P7Tw31kc0o8ceiZ?=
 =?us-ascii?Q?aolbs87D7txq6dfaeIBQHZ6xJ7dfvyak/aFRH7jwGUuBuKzfHkRmWhjREtG2?=
 =?us-ascii?Q?w/upo/08v9IBYKVoQV1P/EjgVqWKnzWDixgyXbmOApbrlyBdGdNwLlfzsYqZ?=
 =?us-ascii?Q?gQfg8Ymh924djcbXCyKz6deDMuCVSMxaby8dOJ04CNjeArb6zpErzXdlQTRu?=
 =?us-ascii?Q?UYzLnhn54fc7tfkja1570yvd02e5TyDwco50AVwEEfPCIX6GW2fvF1b5yK+i?=
 =?us-ascii?Q?BjRi/xxw6DHOlg2Sp0w4SfZVnb90PqWZmOBZG95toR5woqlKEvW42stax0RB?=
 =?us-ascii?Q?kgfdiom9+uN59ADomRj+8xWXxVNRNUIIKJ5r7Gp7GzvUi5kb+Rb+pISw/skF?=
 =?us-ascii?Q?AqK6gLu4Kj6+9mjpgpGo5EipfbKZidLJFZjExyPvCWbacbh9oBhdwvwQapft?=
 =?us-ascii?Q?OEza601kBNPksWqbCulGWci6r6BAHCMXhPqUFMp7uizi+n3Hhm/jGQ8keY4x?=
 =?us-ascii?Q?YJURLwPN+KH9EpVfFIaOPYr8aP15erA1wms0kElZghiq06NiD383IL9JFP5s?=
 =?us-ascii?Q?HHRlrUzbYMGYVKN4/LOniEJdeME3ZpLBf/nj0y9+I1fFjgaL8MXl9/Dz9gCs?=
 =?us-ascii?Q?JogY5BwENu+1MciACcCDFdsCMHBhV8XCII4KXcuxqRCoeT10B08v+V7w6rXK?=
 =?us-ascii?Q?ijzfxHafumQN/3a07K6RVXG2XoXeECUIUi3aSxCjzBBm2PCnFEWyz0zNqOIT?=
 =?us-ascii?Q?0rQk8JFQMmXLk3TEKof5e4yJc0Ra+2IX+NWC8yJ6VXqjBJVSGcmK6hT3QYRh?=
 =?us-ascii?Q?wm2vqlDojgiHoNQLnoZxzugxFoo9FOgOeg7RoyM23zHQtQoO5Pi/VxaUOZwD?=
 =?us-ascii?Q?704jJtn7mjR/kMi9Ob6Onq+ivfJMQKdoiQG77r386yTCcAXhbVw5HzglvFRM?=
 =?us-ascii?Q?Lc5lHaLU8c3fPgJ/SUKQY+VkrsUuX8u0DHX/Rn4Kggtkmo43FmQliPTtClRp?=
 =?us-ascii?Q?GBmjYpRlmad674Tpseh4chbuvYwyYyxb0roG5sr+pacwnn0xy41nbWrXiOtf?=
 =?us-ascii?Q?cIBGc0GnO77ltlBflf4XqARa6H2UmmBRGQQj32AhaNliw4waC81bMIdCZ7Y6?=
 =?us-ascii?Q?jdDhbkTxAu+5nvO6ctttc50RIHvB1faZKfhpq9neXvWMCkfunJ96xGrGY4vt?=
 =?us-ascii?Q?XvxktNnozA0wNGN+O01AJQ92gxNu4CEjZgbq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 07:42:26.3007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e1373a-a192-4201-34e4-08dd78cc67ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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

For VF, it doesn't have the permission to clear overflow, clear the bit
by reset.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  6 +++++-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 901f8b12c672..1c8a40d579c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -227,13 +227,19 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 		ih->rptr &= ih->ptr_mask;
 	}
 
-	amdgpu_ih_set_rptr(adev, ih);
+	if (!ih->overflow)
+		amdgpu_ih_set_rptr(adev, ih);
+
 	wake_up_all(&ih->wait_process);
 
 	/* make sure wptr hasn't changed while processing */
 	wptr = amdgpu_ih_get_wptr(adev, ih);
 	if (wptr != ih->rptr)
-		goto restart_ih;
+		if (!ih->overflow)
+			goto restart_ih;
+
+	if (ih->overflow)
+		amdgpu_amdkfd_gpu_reset(adev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 7d4395a5d8ac..ff76f02d3e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -72,6 +72,7 @@ struct amdgpu_ih_ring {
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
 	uint64_t		processed_timestamp;
+	bool overflow;
 };
 
 /* return true if time stamp t2 is after t1 with 48bit wrap around */
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index f8a485164437..8d3ae88b96a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -349,6 +349,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
 			if (ret)
 				return ret;
 		}
+		ih[i]->overflow = false;
 	}
 
 	/* update doorbell range for ih ring 0 */
@@ -446,7 +447,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
-	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	if (!amdgpu_sriov_vf(adev))
+		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	else
+		ih->overflow = true;
 
 	/* When a ring buffer overflow happen start parsing interrupt
 	 * from the last not overwritten vector (wptr + 32). Hopefully
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index e9e3b2ed4b7b..2ad209406d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -350,6 +350,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 			if (ret)
 				return ret;
 		}
+		ih[i]->overflow = false;
 	}
 
 	if (!amdgpu_sriov_vf(adev))
@@ -437,7 +438,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
 
-	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	if (!amdgpu_sriov_vf(adev))
+		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	else
+		ih->overflow = true;
 
 	/* When a ring buffer overflow happen start parsing interrupt
 	 * from the last not overwritten vector (wptr + 32). Hopefully
-- 
2.34.1

