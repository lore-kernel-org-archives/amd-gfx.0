Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAB0C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 11:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B757810E230;
	Tue,  6 May 2025 11:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lTfyP1Sk";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970C510E230
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 11:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwKRYADg58YuRQ4pvrB25VUJTyZ8hukYmm/de0e8BTyjlkZ6cOsmG5HfYSq+KvHHuxpMtG1vXaHa1cXyi7Or7cOOxidpWDMMBgyRd3r8IImB9V4fu1zgohJaGZlLC5HmkDd/yBHcmrTRGuc/eDNgWtJmhVo+cB+azdQqX6M2+BOtAPoMhf+mwX3iWqNOFgHmzZYPCSXfNxp94ffhmXWDNyy5Ax0shxt+roQKTInhQp+IM0tkz6Bqkbd7n9Tj62V8GXF6yJ7J/2B7kWDRPMfRM0bDzjfcS98J2+bRJOi2Hr3QavkcD0ywVCCgrFyIfTeTq9WP/gY9jBAqdM9BKigPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlTCi2yzdkBdyCJOmMvla17P7eH4ncfeR+mHF0zjW2A=;
 b=xudo3JsXxeh3fFI/D6JcXj6Hl4kXc98Ak8/0lZYX1u3Gn+Q87YoQS1BDnZdgyPIHpxycqnrMfJeZTBE0Ykeb/OzFegmk37XEeAAvsCIUZf88kGN5c/xM9lEYZW/XSH0D83hVXV9X29MrZ1pnRZ9/26p0zhdQMinpPBIRbZ1sDYt88C/g2kaqGYzENfveK4my+W5l/TXjMdSpdN37h9kfhco6Z4NoeA0RKrOQz50E3/1nLuiRlKTb9EaGQDCoBMhhEFM8oTYKPpSp/MFOWPmpPHpp2Y4rsw3t4uoh56RWNKt85tiUEr6Ko4VAtHqPfw3YZxHMQKED6qfUgnC+VzFKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlTCi2yzdkBdyCJOmMvla17P7eH4ncfeR+mHF0zjW2A=;
 b=lTfyP1SkABduRkl2k91F857m3kpm3PeJryEYUQkJmywJJ5asdDXORan8D7s14yjrloaYjOPRmUHyfObsCqj4lUWed6m8/07kpHL8VC7i+TR13SMMHmTMIo++Kbv1o9Ab2ogkCiHQ2FSVPsOwgCTyr4Tlvu0VzHlaAvxfRUtWRgU=
Received: from CYZPR10CA0013.namprd10.prod.outlook.com (2603:10b6:930:8a::21)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 11:15:30 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::a6) by CYZPR10CA0013.outlook.office365.com
 (2603:10b6:930:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Tue,
 6 May 2025 11:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 11:15:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 06:15:28 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Log RAS errors during load
Date: Tue, 6 May 2025 16:45:09 +0530
Message-ID: <20250506111509.54645-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 964b59e0-265c-4ebc-010a-08dd8c8f4fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hZxbHnGZBG0NoE2pT/mROPQWEHO194hw9dhG/Pxnp2/EAsjZa4og4BiWxdTo?=
 =?us-ascii?Q?v8jwDHh+3F7M6hzLrjEppIh9XbGDvrOMc1hzXhtd4iXfb3rHBssTxk9je7PG?=
 =?us-ascii?Q?NJ07wUMhYHTX+FN0gQBu6VCZH68VjfxN2RaGXsOD88uPJTmEVrH9PoulBcxv?=
 =?us-ascii?Q?2WaTsjiTeIMiCxWJ45SVGc0suRd7QA+fyuT5+6BJZr3ksXXS4J5Ym7wW4bSj?=
 =?us-ascii?Q?lSGOI5Vx6S4G/sQG9UwwX1ViIfRqIhdGciYQCvOzEcJ/WX37Fp+sJacr0lr0?=
 =?us-ascii?Q?5J6/GlHv9W0UvX3oFX8QXOE5BpciX5N7EcyTRhfN0EAB4sl4ejx9EPBfI4f3?=
 =?us-ascii?Q?WgWxuXljXAYpsHjpcaca3URbh1B3UagmlhCh1meWBxnWArMZ3tCC2sLIYWSN?=
 =?us-ascii?Q?yAVDJokRlTX8L11avE5QKzFeqltan/VLxQg4J/O3LRY0AMma8cjJbKpmuzd2?=
 =?us-ascii?Q?hEv/aGB0qF3oDv54SBP9zRSFKWTOWEdnSbd+a3Obr5g8qwXOUi49APHV/f7I?=
 =?us-ascii?Q?jbr6p6JKZvaec6/Ylz7CcRi+HFU1NEQUtFQOnI1GkQ05qhAEMETQDAGzbpS0?=
 =?us-ascii?Q?Qk6NawYpZGIFhSIIgq7X2yBVSy3iLzugisTSY6H2FNr2yZ/mq5OVGbvC7YTz?=
 =?us-ascii?Q?BBfxjzumjoPRABJdmAOvx/zvUgC1AqJCrtu/ll+IHVfTQb8vBkGhVaoiTMkr?=
 =?us-ascii?Q?PtLnGmqyyA3eGrs67qdwZovsJpyWx0DemnaUdd+a1JhZmc18yBKE4jreiOTc?=
 =?us-ascii?Q?+AqKds2SC+KKDUyRDYtr6EanUHZ7Fq67BQ0Q61aYXqHpPsp+4p/2of38OWrX?=
 =?us-ascii?Q?e7ASonwDbS3xrx6N8Suz/ihPaUJfQomsNp/riy/Z/XFgkm6tJrElMxOPWUCP?=
 =?us-ascii?Q?LG3LdiTVcLXVci85rog8dTvCE7bO47lPuy4bKl6OR9fGyHFEkPuUbaM6NiiG?=
 =?us-ascii?Q?Oy4Sm4a4Sa5abKD4fSJh5gzpQ+M3860TEnaSgEI3YF74OGmHOCUIschClFJ6?=
 =?us-ascii?Q?pL9i6kPuBqr9qWANhTnaHRMCciEFVmowQca1t3TzQTZlrgq66WG8X/QnH91v?=
 =?us-ascii?Q?enKAgJKNAzYx7DVBK388aagWDppjOKPTYQ1lnWBWBtgXuqxlGhZA69V6yh8V?=
 =?us-ascii?Q?l+fE8sMuRkQEQAjPe7cy5REgqgCW1BCMy3lk6FjMXqGsQKVffZVRoPrhW/Ro?=
 =?us-ascii?Q?UifwkFvOtd/yXsDojXis2y28TV9AGUWv04Dv142gwLxKlguG3Z6nMF7iDz77?=
 =?us-ascii?Q?G6ShCdP4kohKuhHI8uMIHG9vYPecjzfsALYZzLghBnUzzCf8V1QlHJ4fbGLr?=
 =?us-ascii?Q?0mQ/6TA85Gt4jHicPFJ7WVaAViJz9lkkjL6uEnRJUxec7Q+P0SdmJDttfy+Y?=
 =?us-ascii?Q?xAjflkvfUbTThUPNLbxF/jZvW4F1/oiR7w4CR3nGuMjOWsCTA5unxZyGrX8K?=
 =?us-ascii?Q?JjY5NkPRlwFAAy4td2L0yN3UlMIMrsemc7xnwx+NVNvtSiniozFD+Qmnioi8?=
 =?us-ascii?Q?mqPE7zjvoepewMpinjU0PnqJIOUQluBVbYnx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:15:30.3675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964b59e0-265c-4ebc-010a-08dd8c8f4fe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
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

During driver load, RAS event manager may not be initialized. This will
cause any ATHUB event during driver load to be skipped in dmesg log. Log
the error in dmesg log for easier diagnosis.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 82013b495436..85a70b646840 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4485,8 +4485,11 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 		enum ras_event_type type = RAS_EVENT_TYPE_FATAL;
 		u64 event_id;
 
-		if (amdgpu_ras_mark_ras_event(adev, type))
+		if (amdgpu_ras_mark_ras_event(adev, type)) {
+			dev_err(adev->dev,
+				"uncorrectable hardware error (ERREVENT_ATHUB_INTERRUPT) detected!\n");
 			return;
+		}
 
 		event_id = amdgpu_ras_acquire_event_id(adev, type);
 
-- 
2.25.1

