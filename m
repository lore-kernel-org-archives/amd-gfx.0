Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA6BC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A80F10E84D;
	Thu, 25 Jul 2024 15:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C9bvatjW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D465B10E855
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xW30a5tT2uPKqGxYlzqOeWzvTI8OD/D+TZ7lieGiadACvj/0398pQcIUhUtbaegEYff6qlPUGm5Bvem7QwPvHk3HXoR5sKKbZJKxazOlVONCjdYM3WlhwIg82tW+lHOrgmaxgqfhXVoHN2a4Si2OHUjxgg36mTkjLEHQe56xdsQAhtzxwWnbj3Cy1pjOm+7gtNhD/Z27oGfh3zDlEE6D2KaVv6tFCq4PA+j+t9y+SQlXJV57ssG3D516M2HsqvXEqodFg5FBbvpTkp2TG0GWonLjC6UQIZ7vMt/iqof0KUWvlpapksziPnwu/alXRsItAl/9pZAWUaGKk/jbzW9UqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL33bltk0N26Xb7xjG1QAePoE9Mvbkg3sT4Ifm36rgo=;
 b=XWbWZy5Ts0sdrWM8ERy2KijQmdRAFFVtIr93ZvM6lvExSYRYVEXf+Rp3xdwDpdsV2ZYWAMO73Uv44c2f12ziJrvfqN1eUZMqtyUqi4BJZQ1nIUcajxhXjPjOWJ642rUjFf3tE2iu7MsVins8Cbp6IrU6qiFQAtB1Zu4tWNIs7Q2sD5u6XoaZ7Ik3sljWVEBcCaBkLYfxGL5fItMPCx1kvUVM9Ya3xnSunqRMBJ92Z0plJLR0XU4z29uRFAQm7m17wZFUV57PGqr9YeKE7J6fk7NOQhhBJwuEd52SeFPJlPnIu8xWrXCUgWzTeeCkLYB3riD/3IAHS7eZdfiXnFJ96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL33bltk0N26Xb7xjG1QAePoE9Mvbkg3sT4Ifm36rgo=;
 b=C9bvatjW8H1Du0sH6ICe8tcghF67euOClyFtggJ7cl4PWzA6ykg3BTyMAk00Wgx7y4dMc9fA+99yBH39S1UmirvkTh2Mm8BenztMdjvJACBt4KbBFfvq/7ouvRtpVuuA/rxNgfxSz0abK3anBkkcfr5b2C0j6jQHTYNNo0DHx3k=
Received: from PH7P220CA0045.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::17)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:39 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::2a) by PH7P220CA0045.outlook.office365.com
 (2603:10b6:510:32b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 52/53] drm/amdgpu/gfx9.4.3: use rlc safe mode for soft recovery
Date: Thu, 25 Jul 2024 11:00:54 -0400
Message-ID: <20240725150055.1991893-53-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b66596-1ce6-4133-b8f7-08dcacbaaf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UJF7+AaBxsV1gmeRujHODH8gV+KPHueskjb0hKaJCioMvzsXslqZYcZmsE/T?=
 =?us-ascii?Q?YzID6ANjmK57nF8vjf0y92H/S/G2OP8CJs5139weAtGfMX27u3XQ6aWmdW+q?=
 =?us-ascii?Q?u03T/cDgt8DK1U3RxD2YH68T0mWeoNijjTF+w7zaAQ42At4dQoS7bvWWKeIo?=
 =?us-ascii?Q?03cPTPAAjJccSq6+SPmBch3nXPW1oCymR1h+2uhWjWTm1ih5M3R9ctAI8dgh?=
 =?us-ascii?Q?OafyFiQ0fGr61aCwwsT4IDDaDtN6rs41qzfj8fuGht1pkoQLVeT7N2anmXI8?=
 =?us-ascii?Q?0VpN+7a564gW3gu81kxfVR3cs+/iOeKoeZcvzgVYEx6M4D2rb9A7a5N74tPh?=
 =?us-ascii?Q?xzjtxpzJeQzZnH9Lg7oozzJi1qmf1t0LWbTjWE1WaEOEvclXILK7y4oSe7jw?=
 =?us-ascii?Q?ZHDKpMvbI8nRMqNE618jrgdHWh4lCJ2+H1n8WhvqEhJm1yzezqqeKawEba1v?=
 =?us-ascii?Q?iLMdqw4m2MMYnenSpuQDtmsFGe0k6u36B1Bj/69udyPGLD4jLM54Pq8/NaZ0?=
 =?us-ascii?Q?YsHI3chMARHBVSn9KKVaN3fgZpnbUsjJUBF78jNGoqDMoEgeMz5BloCzXZdC?=
 =?us-ascii?Q?BK1BzG0Al8X61CX65rz3S5zxHFJrVC4d3R54qRVvRUI1e7iTt/rTDBrX/gVE?=
 =?us-ascii?Q?c7enqF9VG8mxv3ZJCnmfOaBlf39sDe1NWRgQYa8B7Da78Lgedu2DdrBFOaEm?=
 =?us-ascii?Q?chFtXHmbKUE16BLNBZQz3VTsnPBeHCbJ5+Gir3PtAwZzXnh9Uv4GczFB9h/T?=
 =?us-ascii?Q?ooycD5aOtI7Rhqgh7aB+3IjRAHYJ2q4OPr5L4q+wXTHUrpSLJ4xnr5q1KbtD?=
 =?us-ascii?Q?w+jsGk7F1VCYFgtd714Z21u3VJzgIHRKSmWn7QwlHJtd4ilZxZr/nuNikTSt?=
 =?us-ascii?Q?Gef6QwDhvoYJZRxf8spNic5I06jA7DMccwm9+3lhgQIu0gyv2uwaeVQvZPhW?=
 =?us-ascii?Q?d6lSoBwYRjxWgLLgmd+d//iSix1E2tdbKquLRmb7Yxh3VZqvIjYivkn+Qofj?=
 =?us-ascii?Q?e0u0DN0BwsmoKPebu7QQWpuyI08Py1I7m2JP0xWaobPRAES9ToeE7pelxeLK?=
 =?us-ascii?Q?h1lwdXR3D6nkCifgoUbLU4zkxKjfzcom7ULIpnfrgAmIqEDYb8fS0OGxFeer?=
 =?us-ascii?Q?WeNPHpFqQ5pCFFuUguKp1WQVUZ4c7NTuH7L5T2mdF0DkQ6adqmrKZ9j6wAMM?=
 =?us-ascii?Q?AVDC36v91Sy04OAMqPlfDVZ11Hovkl1fbjw/4c+OavtL86y1/lobQdb9XEFr?=
 =?us-ascii?Q?QwswyyjPeHQEJxzFcUf4ItoFlTKCYBOWu1J5cZ/w4El/K9aAuWl50mNIZctr?=
 =?us-ascii?Q?7aY4L0jwL/R0hDzHTfhL8FqT4s9WbRNuUYakeDmKiy8m68DXfRhgDFYACNNt?=
 =?us-ascii?Q?mgP7wckIOlbxq8+5TSL+zkDTCcK0AJL8MC/e8u5NHRP1nxXi2xVK17VELMrR?=
 =?us-ascii?Q?jcKCt3MpmluIoXciP3bZgbHSen37IR3+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:38.4632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b66596-1ce6-4133-b8f7-08dcacbaaf5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
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

Protect the MMIO access with safe mode.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 797de64cde74..c1a17bdee6cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2891,7 +2891,9 @@ static void gfx_v9_4_3_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
 	WREG32_SOC15(GC, GET_INST(GC, ring->xcc_id), regSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
 }
 
 static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
-- 
2.45.2

