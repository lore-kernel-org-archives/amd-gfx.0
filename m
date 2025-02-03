Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901F4C02198
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCF510E577;
	Mon,  3 Feb 2025 21:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="26uvo5wA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB0F10E1A1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQPIN6Mlczl+DLMTuy2m8rJ/axaXwmxk5mhl7t3M4KSAVdhsWOVU72UZynH8PRa5XdtIJmOmvYj3YxIdTYCOnZ4t+t4oJ181dYprgbxcuENwymXMCu42vVpLOOVlOBNtmh6YbxfaL59G3JnyPUXCulHUP7TjZh7wm5adbH1bD8s64/P/w5cP0ms6e9I7czROGT1eEptp6yueKpNNnbKZQuuRyadWGR9O5GWpV5DMNep8QrL8GQwOwAzzngTOy81PGgquzNIA2rP0lVVoh0oC7IXGrcis0RqSo1DZsCMmPJ93MrKEk4dNXtCVVjIPjMEc3ORBJ89GPGM9QijQcOOvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A9cLUtG0hio9azf53flsTwgTzlzg5CxLjf9CKwQtco=;
 b=M1geAFFnTGwB2jv/5Tw9hYWa6x95Wk7gBIwBuXLRIK/GBrgg5sZoXy4IHo/q+d77LcdbfkmwnmXAGueycU+l5i9BMxDSBbSS6EJ+5uaDLhL89VXhNb5KIKOBqi9CY02ipsn410iko6s8KyoKUmguOks68P2flRGEbE9vIFBqNExNcUuG3XxmTCHC71AG/Q8qI7Yk1agTfaLMHbTZDPZtf1vwMqD/ycAH6aFAEDxhZ1M4N/6qr/ZOEis9qwX19cv9ez3WRGmRcV5pzVK0cMvh7rvlbqdsYEw2fI2ILAW3yoahnXljAhkOPRWo/0mZ/Djt0G+3PuDRBMrmrbjo2g6csA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A9cLUtG0hio9azf53flsTwgTzlzg5CxLjf9CKwQtco=;
 b=26uvo5wAL08P/TE6kvDqiZ6vJx+rIG99X9jR9b+8Z0PNqFymMzxrzhuuZaawNDcNpsBpI+jm5ecbdOIDL6/2MIvZlA7BNsVDp9v6OCfGLyEN0DCRJr1znj9I/wqgK66g9CsZvmpal90RKKJ1yJ2COkkeM6GPbl93uyi8KBhRBlY=
Received: from MN2PR06CA0001.namprd06.prod.outlook.com (2603:10b6:208:23d::6)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:44:09 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::f6) by MN2PR06CA0001.outlook.office365.com
 (2603:10b6:208:23d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 3 Feb 2025 21:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/11] drm/amdgpu/gfx10: manually control gfxoff for CS
Date: Mon, 3 Feb 2025 16:43:43 -0500
Message-ID: <20250203214349.1400867-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 2292aeba-7a09-41bd-5cf8-08dd449be42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UCW6/oFSimomGEj42v+tm72Swye6MdPbAioOYI+oUy4eFeDRW0jUevDmNIHH?=
 =?us-ascii?Q?AaAN//lrCt4sZy9oUcpv+kev4iwxhd2KkIdcKIfx0yUG+PRajGeM/9hNwos9?=
 =?us-ascii?Q?jnxH8O64QlGC2un8rbvjjvsI0oseOctAEw4p90+tHhWsoUq0cc8JMfHWjEsx?=
 =?us-ascii?Q?yaxS6XsayV5Rd9IqGCDKTMh3QR4GOqc3qH3uh7ufw7GE8xjZ5ZTm1gNBd6PM?=
 =?us-ascii?Q?BniHlT38aYK7yNanHOj5CxHZn4iPaiqdDWlMQ9df5oMEG5WQFIrlOqCH8o5y?=
 =?us-ascii?Q?iCJVXDj0ZVRHUNJxlNS5eqn9jTjgzjrp5nqgsIZZJedBJsrRKqGi88DZOMDV?=
 =?us-ascii?Q?xCtrAmIay/+dCu3zcNGmMvQu1pqX/PT5Os1hBo9LuekX88/lCU9ePCwJDMsl?=
 =?us-ascii?Q?F3zq9dsMKjOP0Nkt1VoxTgh9Mk6124lNbFWdrdzjgi/tyEDTHoxRiXDCs+gm?=
 =?us-ascii?Q?ZWqyu08AhLyo3tWpcd3ZXms82ZCy8GQ7portIvPCTqRi/WXMlf4kMQT4mzom?=
 =?us-ascii?Q?elmnC6VggOCFZo+/qt897yW5Ih5PJOJ55Rvxb2a0Iag6W6a05Acfuygkp1dH?=
 =?us-ascii?Q?rBGjraD8wUiYrAQQV/XZFnSmYy9HiKbbO2gk+CoKKsYdLm60JgiWedv5DuZA?=
 =?us-ascii?Q?V5WzZ5qE6yViRx3qTjVuy6X1luPIIWfBJffM9tT4GwjiWIi2KI75fJmHJpu1?=
 =?us-ascii?Q?RB1P24V+JPhx2x3cIyGdUk5J6Wnvv/KhQjcTu8r1rxkESURDIb0kYBUzrn4x?=
 =?us-ascii?Q?7dm4xTwbs7jcQfhFfz68vEoW9Dd+VSz1vlNFeyGIKo+yIz9FYJRjqZXd5axY?=
 =?us-ascii?Q?axAFE4lqdJHXWJ2L9/DtCD5TKcdqiXtwlW5TU7vh+ZM1Jqj3lvDYavtZDVZb?=
 =?us-ascii?Q?j9RcGfYm0G462M3hbrp7WXEOdcmcNajUp51MMulOoou/+2NY9uo+doLWh1bo?=
 =?us-ascii?Q?sOPfwtFZGkeWNJtCRqx1nRB/Y5U2a+d7CinUwBQPObSenwefqdS2Uzje7YMy?=
 =?us-ascii?Q?pF6+N2gVVQY8r8YL1KdrgixpxxmopAcTNJO+AJdtiVRUIfSxKkq5vXCeU2OF?=
 =?us-ascii?Q?Q0tvwYFQWhAcejP5Ef8aV4UYGdtPwy9YsxGC+kBhXNzxrfbrHd+cwN7OQoXB?=
 =?us-ascii?Q?r8oCVBPR/CJnTsC4l9syFxWqPTy9ZsjBJOs6MN3DzxlpPvNKUuEV1/vwBLzH?=
 =?us-ascii?Q?cFyYclwk3nzs8u5NXXsF3hwJV/H1oJQTxfz9+Toy9MuCt1QwjHhzdY2oHc1+?=
 =?us-ascii?Q?fn8oU9lgUA7+juc03Z6Fdhb3Tr6PGjgAzBI5KtKc+a2O4up3eCV4/feJXGrQ?=
 =?us-ascii?Q?YeDSNlmu3sexh5mcdSScpKSYA20DJ/5uQr+yu2DS57oQ7JsUkTcMcwdV6oE/?=
 =?us-ascii?Q?oM5xPl1kciPeYGyQxXkcl0mMABZF5S4j06ri4Y2ZeythihvxBpKhpxgQJbIJ?=
 =?us-ascii?Q?yOE4Z5rkT+r6roObmkSAOIxFjbX2A1lU5CR1ss6aHAsKCto0tYyyaewCGaYS?=
 =?us-ascii?Q?YYAnFtehVvVuaSI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:09.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2292aeba-7a09-41bd-5cf8-08dd449be42b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
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

Manually disallow and then allow gfxoff in begin_use
and end_use to avoid any potential FW races when
ringing the doorbell.  There are no known issues
with gfxoff that this solves, but it shouldn't hurt anything
and shouldn't affect power usage since we are only
toggling it around the doorbell update.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7b01828eea8dc..96346a19950b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9826,14 +9826,14 @@ static void gfx_v10_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 static void gfx_v10_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	amdgpu_gfx_profile_ring_begin_use(ring);
-
 	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, false);
 }
 
 static void gfx_v10_0_ring_end_use(struct amdgpu_ring *ring)
 {
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, true);
 	amdgpu_gfx_profile_ring_end_use(ring);
-
 	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
 }
 
-- 
2.48.1

