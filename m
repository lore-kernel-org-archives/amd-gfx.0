Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6CBE81A40
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463E010E3A5;
	Mon, 16 Feb 2026 15:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D4ufieBz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED10E10E3A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArF0Ka0vTWuq6hGFIDsqxeBUQZl6FlMaXO7HsQJLv44XFIxO5M/eG1TIC9pkDE9QVyHI4Poj/Vg40JlKN+v8BjgdVbcGqqOqUffs3D3nH8C4k77RNQT4pmBrnHZBqTLKyoxPw2E17tTYZqPu1DLVqKtjnmLtAbdeJVDvjwidlG/B3z7opQHNvOvH69o04zoPGo3zu1JOFOtx8MHr5u9bxBaxqXHqXWex3xSYjETGwXyVQFBbdX096IR0XHr3ddWXuOb49emjySjq/DXyWixbMAjntyDiZe8ssMB7Uk7U/imnsgd38dYanh3m9yjO+iD1GumyCJCMJtCihjIpAcfxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMYrO1kuAcHh6csI5FgWgd3z4MyBcpWPedVC+uJcJgs=;
 b=aQ5CDJlbF+HAwYspNyrt63d7pX0wvcHrhVR8KDcR2Evns67oeGg4hZVlDQDB75p7YSD/Nsw6NDQFlACU9egwKEjDfjRMMTPxxME0sRsX6+yD6BFSzcWcsWVI6ui+H7sFzsWVEg3xHg+iZN5pImUMiV0V/A3ooKamfgwRtSLpQS/fGP6fCwpH5DgMSwb9R0jSi1/+INn7lkxuaOaIJQxyh9EBNPVsKxpqKMTzKSyB5QKIMXRfV3OV9yV56goAXO8k6RcvtIKAUq4RBSZeqQL5l3EZG0B0EiPcv46orRM/UZ/QDhLGYwFedK/rm8E96BbXXOM/Nl/E7lKPJIeeztaFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMYrO1kuAcHh6csI5FgWgd3z4MyBcpWPedVC+uJcJgs=;
 b=D4ufieBz83osvtAvwxIgjoqZY2OIoYm+yesAEpCZJrgJToZmIYNeDfQwG56ubRreLwLyqNw+rEx5QUikNO8xzyb4T+dyXVG8eLzSuhH1DqEm4Rlo7mCZ5lavmCSV1x4Ay6L93auphf50HgUl89e3gN1B2M5v16De4sTmvs8qjGk=
Received: from BY3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:254::16)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:50:13 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::b8) by BY3PR05CA0011.outlook.office365.com
 (2603:10b6:a03:254::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 15:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 15:50:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 09:50:09 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2 5/8] drm/amdgpu: Add PASID->fpriv registry for KFD->render
 eventfd bridge
Date: Mon, 16 Feb 2026 21:19:40 +0530
Message-ID: <20260216154943.1582412-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: f103e05f-9dda-4f21-41b8-08de6d731261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVByRk5raHF6aGhjVnRBZDAxOHM3OXY3emF1NmxPWFcrZ1RrczU0SUhVdFE2?=
 =?utf-8?B?MUVZcDA1KzZoaitqRXlVL1MxOXlCc1pFRzJ2Qkx1RU5aeTQvVFkwMEtCcjVn?=
 =?utf-8?B?YnB1TWxCQnpwUlZrSzlCdTFGaU1VZjVGQm1CL1RYa3hIUS82b1YyWEJZek5p?=
 =?utf-8?B?OEdPMENzdkt4akl6RVRCanFtclhFZFR2WnE1TUFoaUtmL1h5WkFWL3VKQmli?=
 =?utf-8?B?QmdSU2FrZjRXWVEzNVllQ3JqajhGMWhmVWZxcm84MGM4YmVyaUttc2Z1dFRq?=
 =?utf-8?B?b1JDVEZuN1VaS1h3MWlHaWdSUkZ0OXB0K2Nac3VkTi9QUkdVeDdiNVJKRk1o?=
 =?utf-8?B?cG9uVXBYYTA4eXhRYjgvcDZtbjVQYUpmb293QTVuMWI1Z3hseUlKWGljWk1v?=
 =?utf-8?B?UzFUVjNib1hXNVVLT1BFOHBjMUZCUmxvY3M0WmFwdDJsWlZIdFgzLytldFll?=
 =?utf-8?B?S2tSRzNpQ2J5SjNPaWRFMkIyOHpLSTY0bXRnSFFVSDVIR1ZsaENhV05sdjdW?=
 =?utf-8?B?VFFqUzFLUmk4TVJsTjhxQXpPNU0zUVBieCtBdnc4a1NqMzlkamZ3eE9rUTNt?=
 =?utf-8?B?QmpxSXk1Q1lsZmY3YkVwbVFZY0QvTlB5ZWdVNGZZaDhzUzlrTTFMSkhOMDdW?=
 =?utf-8?B?c0hHL1Irb0dld1lDbE5RMitUY1Z5Q3ZOYTlIa2JXYjFvL1N2RlFIaExCQWkz?=
 =?utf-8?B?cUFvTjVaUys1dnNBc21qdmJOc29vRE1kNmMrRmpvc1dlT1lpcTQrelFvRi80?=
 =?utf-8?B?K0FPTXVWRndpUmEzbitPUDJ5NXVsZnk1eVRiTDZuN2NiN3crZzFkQUxaQnF0?=
 =?utf-8?B?c1QxSXFlR1Evb3NYS3FFblBObERiMjVUNEJIaXhRNTloR1lvZTNTWDczbGtR?=
 =?utf-8?B?RW91b2l0WGRRNkNad3J6by84eGtkZ2VNUDhhVHUvejU4ZWVaSzA1WUhoZDRT?=
 =?utf-8?B?M1FoRWJ5YjJPRFcrS2swWm9jMFRXQmN3SzMwbUFSTzZtc2dYM0xXZFBjNG9X?=
 =?utf-8?B?MlJ4bWZXdUZSRUF0SzBiSUJBSUlDUUdtY1hDd0ZMelVqUXQ3anB3UVVPR3FC?=
 =?utf-8?B?UVkxbWFDRy9uOU05T2gvbENGRjA1UjBlMzloZ3U1V09tdUlyNlBpeU80aEc4?=
 =?utf-8?B?UU5xOHB0Y3duaC9WN2N4OC9EWUZYYkVaOERuT0dZNHJxTHg4Q3lzdHZGc3Fm?=
 =?utf-8?B?cDYya1N3ZDBVN0RQVm14UVNldk5JZERYZWlBL1plYlNNRk5zWnY5TS93R1Vp?=
 =?utf-8?B?bFlNclVyRGRSVy94Y2JVV3pLMmVuazIwNHZSSjcxWEdVVEYxais2c0dkWDBN?=
 =?utf-8?B?bFpaWXN6RHpYTHV1THdvcGJUc2lObmlGUW53QTBOVktJSUMzMkRNc2I5YzFY?=
 =?utf-8?B?WEliTWY0ZnFUYWk3Vk9KbzUzQzFYakNKTFV2ZTd0RThMVnE3NnV1enlLaTh1?=
 =?utf-8?B?Kzd0ME55aTNIeGlLdlRJRWpSbi95V3AzNGt1eGVQT09iYUN3NVBKbWp0ODEz?=
 =?utf-8?B?MjF1U3p1ODM0OGFJMGsrQ3puRDc5VTdTSkxIWlJWSCtyS21lWkxVTG1mV0FN?=
 =?utf-8?B?QmYyaFRscE1FeWdxM3ArWWJ4WHY5bzg5aTdmTGEvdTVPWkl6Z1MxZGxNYXFM?=
 =?utf-8?B?SzdvaFl2NUk2bVpTcXh5Q0hOMW4wd1grR2h2MWVDOWhqcU1DQlhuQVlKWjli?=
 =?utf-8?B?c2VaczJ4V1I1MFcxSUZFS3h1U2sydFpoUklvUkU0OFBQeWVZYjBMN29PejRo?=
 =?utf-8?B?RExIZkV0TlQ1SGprS21jQ0pXTXFXUFc0Yk82eE5MUTU5VGNKK1lBaGRtL0tX?=
 =?utf-8?B?QUIzd3JmckV0bEhOdVZzRE94WkFPVWlnZ3dCMFJWYTZDalVIYmF6dHZBejhk?=
 =?utf-8?B?amZPaUo5V0I4T0g0UUxjS2t5WWhWOEV3YTZjMlNiWGRDa3BBaTJYSmpBUDBm?=
 =?utf-8?B?OTBXeXA1cDBXamkyUmVQRlBLMjk2R2pheTFGKzczbms1dUNIeTZpSXBkbnBh?=
 =?utf-8?B?RDFrRU5OWjlnZTQreTNjaWlEVlIvdUszUFZMS1diV2tOTStiUldrM0g5V2Nz?=
 =?utf-8?B?TkRHNlZqODNIdjRlZ3RkNzVyOC8vb1RvZkJIbHhqTHluSml2Z0VvaTdCMVoz?=
 =?utf-8?B?cEZmTDlzeHBwb0ZmamlCUk9RMFFuNFd1aTV6dGV1RFNONEpJK2lqd0hlckYv?=
 =?utf-8?B?WUhIT1dsZm4wSHlUSTR2N3owWnBYT3JwZWthL0ZydWpVOFRoaGJVTG53dXUy?=
 =?utf-8?B?cExpdkQ0YW1aTDZQNnZzVW1STEhRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v3VTh/kWj2u0twIf/0NMYeT2DecEzJ//hLX+0rT2DJ7thEWgChqQ4FkZR2hQN9KTowWuhu/A4hi1WTp47EwZaQLywlq/rUdSjG4R6zpVT5y+JQHWlZz9TglnscDPSa3hOHZVbJW+caC260wcIJRcKVudhX2tjjolm+dholYhm/8FUnaHLfQmq90HtQ086ScwpZlT8KYhqB7AQODSyOuFuualdEkjQIqkkhbOFS9nGVJK7je8592ZU3x/FOjf9RVeaZfEVpeETd+V3TQLp1X1G0PjZwKA/s1hGWx6wwWLSwUAhrOpjYEFQkmTC16cs4RgKQlMp0NBZGAsSW1t4Edt7mTHlT0nvjzc65V8CdMxFCP69odEFVvOQ5cCYqiCm/H6VKhaE5UhBgHF7mwUaVnsj/eDiMjY/Ep2ogEia4WChjT0abs2nA77lH3GvYu//ZZu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:50:12.9122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f103e05f-9dda-4f21-41b8-08de6d731261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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

Add a global PASID->amdgpu_fpriv registry. This enables a later bridge
entry point (called by KFD with just PASID+event_id) to find the render-node
drm_file(s) for that PASID and signal any registered eventfd.

The registry supports multiple fpriv entries per PASID, since a process
may open multiple render nodes / files.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c | 114 ++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8e22882b66aa..0a5ed8984ada 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -67,7 +67,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
+	amdgpu_eventfd_pasid.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b0e9b7ff2f80..4faf908d5af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -477,6 +477,10 @@ void amdgpu_eventfd_signal(struct amdgpu_fpriv *fpriv, u32 event_id, u64 count);
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
+/* Global PASID->fpriv registry for KFD->render eventfd bridge */
+void amdgpu_eventfd_pasid_register(struct amdgpu_fpriv *fpriv, u32 pasid);
+void amdgpu_eventfd_pasid_unregister(struct amdgpu_fpriv *fpriv, u32 pasid);
+
 /*
  * Writeback
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c
new file mode 100644
index 000000000000..770ccc0be70b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c
@@ -0,0 +1,114 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/hashtable.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "amdgpu.h"
+
+/*
+ * Global PASID->fpriv registry used to bridge KFD event signaling to
+ * render-node eventfd subscribers.
+ */
+
+#include <linux/hashtable.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "amdgpu.h"
+
+struct amdgpu_pasid_fpriv_node {
+	struct hlist_node hnode;
+	struct rcu_head rcu;
+	struct amdgpu_fpriv *fpriv;
+	u32 pasid;
+};
+
+#define AMDGPU_PASID_HT_BITS 8 /* 256 buckets */
+static DEFINE_HASHTABLE(amdgpu_pasid_ht, AMDGPU_PASID_HT_BITS);
+static DEFINE_SPINLOCK(amdgpu_pasid_ht_lock);
+
+static void amdgpu_pasid_fpriv_node_free_rcu(struct rcu_head *rcu)
+{
+	struct amdgpu_pasid_fpriv_node *n =
+		container_of(rcu, struct amdgpu_pasid_fpriv_node, rcu);
+	kfree(n);
+}
+
+static bool amdgpu_pasid_fpriv_registered_locked(struct amdgpu_fpriv *fpriv, u32 pasid)
+{
+	struct amdgpu_pasid_fpriv_node *n;
+
+	hash_for_each_possible(amdgpu_pasid_ht, n, hnode, pasid) {
+		if (n->pasid == pasid && n->fpriv == fpriv)
+			return true;
+	}
+	return false;
+}
+
+void amdgpu_eventfd_pasid_register(struct amdgpu_fpriv *fpriv, u32 pasid)
+{
+	struct amdgpu_pasid_fpriv_node *n;
+
+	if (!fpriv || !pasid)
+		return;
+
+	n = kzalloc(sizeof(*n), GFP_KERNEL);
+	if (!n)
+		return;
+
+	n->fpriv = fpriv;
+	n->pasid = pasid;
+
+	spin_lock(&amdgpu_pasid_ht_lock);
+	if (amdgpu_pasid_fpriv_registered_locked(fpriv, pasid)) {
+		spin_unlock(&amdgpu_pasid_ht_lock);
+		kfree(n);
+		return;
+	}
+	hash_add_rcu(amdgpu_pasid_ht, &n->hnode, pasid);
+	spin_unlock(&amdgpu_pasid_ht_lock);
+}
+EXPORT_SYMBOL_GPL(amdgpu_eventfd_pasid_register);
+
+void amdgpu_eventfd_pasid_unregister(struct amdgpu_fpriv *fpriv, u32 pasid)
+{
+	struct amdgpu_pasid_fpriv_node *n;
+	struct hlist_node *tmp;
+
+	if (!fpriv || !pasid)
+		return;
+
+	spin_lock(&amdgpu_pasid_ht_lock);
+	hash_for_each_possible_safe(amdgpu_pasid_ht, n, tmp, hnode, pasid) {
+		if (n->pasid == pasid && n->fpriv == fpriv) {
+			hash_del_rcu(&n->hnode);
+			call_rcu(&n->rcu, amdgpu_pasid_fpriv_node_free_rcu);
+		}
+	}
+	spin_unlock(&amdgpu_pasid_ht_lock);
+}
+EXPORT_SYMBOL_GPL(amdgpu_eventfd_pasid_unregister);
-- 
2.34.1

