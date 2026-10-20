Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9816606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=houo4Gs2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F07810E23E;
	Tue, 20 Oct 2026 12:01:13 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF8D10F518
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 12:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJZ/h2t1tXUcgGpDlIwMQfBZCk7ay4CAyjbeL2GtBOqCUa65YSZw+Hod3e8Bz6UeTIfa5g5yVMLHr9XPL7dFS6NY7M0Ss6RrNpAPLNRMtuW2juxbARW0rDNXSu5lt9vjB/cOskMVCW+JFfb9YORUQ0wSP9hMSELbA8J2LX49xdIaux+BoLbuXEKgSkqI/VE2Ir83liX5eRimYYsJECuJqAwt/HIO9N/W+O3q07W/9I6OrveVJLAXkivcmEzV3GwsjyxGRY+ZlTDp+x1ZpvhUbAHDWcCqw8rJTOvUSimkLCyDNcv5aSiu2s32XD1il8y7rmTRRuN+IUU6YAEHee+vfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FleG3wfK8Qhj8E66cG1fsiZCcWTKkqQIDLaJKv3TDVY=;
 b=SHYEXhLBIdxIgjdDN/Xo+M5/UtX8QuuS+1Q3neSTlPoQzvUjxHZIbNMm0rDjX7oQRzCAEx8gverXWdorAkTTWKUsQYRFU+2fC9SMB61/qIO0jdE6CiI/0HwNreYLwJoiARSClCI91wg/cdsZZmCQUUbzKWrwuGki6NKFPmEzzk/h2yEgpFvKBnOpZGAwk4G0vpqaSm2Lk9LBfF/cabtaukM8UL4nbQ0zKn966RZzexNineDh4IJaVOrZn2ZIfHdT75BmRODtfY741IOJve42K9p149TPR9jYRtaUOrMk3/AuwGCCYMW07Cix3WsaP1Ohl36LI3EuVVR4wDKd6fQ3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FleG3wfK8Qhj8E66cG1fsiZCcWTKkqQIDLaJKv3TDVY=;
 b=houo4Gs2C4wE9T6x+Ja/wFFMZAlwqcQbO9Us55elpIeKOCzysmghoKXqhP03YeGjqWV6/EOtrlKjVCQ7cGedNuhZRkIOcq0OzvmFmHCAvpbGOiMfVPZyKkRzIXIFN3xy9COtNtT4qnmLvRFL6cMKYvTvy75+zCK98pARDjXXOec=
Received: from PH8P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::15)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:00:58 +0000
Received: from PH2PEPF00048915.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::19) by PH8P223CA0003.outlook.office365.com
 (2603:10b6:510:2db::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 12:00:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH2PEPF00048915.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 12:00:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 07:00:56 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 07:00:56 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 Rosca" <david.rosca@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v2] drm/amdgpu/jpeg_v4_0_3: set only IB_RD_VMID to 0
Date: Tue, 20 Oct 2026 07:59:01 -0400
Message-ID: <20261020115900.115381-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019200726.15262-3-benjamin.cheng@amd.com>
References: <20261019200726.15262-3-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048915:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffe46c8-8fbb-41ff-e8c9-08df2ea1cd64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: aiigegvTgHateG4bxYFWMX9MorKhJA7fXlre2wiBVIMbGKebhRcOCU2/bd3RO2lYDn4pmA2TFKxVBQP2QJm1hjNloMNmDS/0qTe5dKDoJGYqkuX71fdDPXkjS/nk9dfyImiOwNCsel2icv+b+fkW/35ksyNuMgC00xl2EA4JI5ucMnl/uoP4P3dNktfEblasBu8251sRA/C3kpYA8x1w5CM93lk/8Izum/mpS/MBDg+D474Heb/MuMXD5x/tqIikhe+cfGU2ITB6F9a2w0/EggKDuQtMBMVemSP39hPPFQJjU7GRVq5ODIf1LBmqArzqQbi0ia34FONuzY+QQ8dkAEsHU9RJ4aOftP2MsenjwctU1sGSvT/Rb89pp/987xX+nUzS5oEZGzB5VHW3Nyp4WuSi+ud1x7itKDpLEQW97QviYwyfx6NaT3hPEZA0VZAZGGpVjPIT8Dc4hQRna8WsGBGdSCzWIbxkWZnDWi+Fh0QCq2ILzzq9qsni60aSk8/TL0Cf3VXRRKvgY4JDilBQO785JLFrSCN75Rl55MpqGCMCzHd8/KPkG6DC/nfMcdfKo4+waX9XEEzmzJaFJcUmY+bc1BxCN5dwkF7GCGANmmKZsVN0R3qDIXGlnL6YCeBjRnOKxlqzqOo/8r0zotCINhBIKkGcmCEkF7CaIrKef1rJreT12L+3uvo+hUGDiJp5AIRyHipMDk9EP18ttzpF+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kac/frBLxUIku0Upv2xuMk1Xn4g3tkpZwTgproLacjx7QcrOxqh1YBPlUo9+oHS3BiyKCsn9e9ZBo/xAHto0Q9RqHNRrMwcbnYAiip73iYwqkgM1dmD6XJOk5hbAAKfRmTHqNriCLlWlEuFiu/+MjHi9Aa0l0IPHnI31dR4tZx4hCSCt3pylSsCnB9d2PvfhCsFRtnflM+0jQ7VEyiMMRgpwTtjHD0tb6NDmAJTYPcQapoDXszHCRHKkkuL+wKVr8ABws/iGgIWpP6rFoAThWmLQLpP9ZCXnQVQ7xJp576GWN5LeP6hl15TzXbwsHMVQxZCAH2sTCQE0p+forJ2OFITVPhCTQMVraFu+21NjQJH/TBm8ibGKXzJ9L8h792PN9R0/BwEOSLmz6T9C6DtofyPIqCLinyzQMgrBXZ2Ah05g5vXwoYyy+LBuspoS88k1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:00:57.9334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffe46c8-8fbb-41ff-e8c9-08df2ea1cd64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048915.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If IB parsing is done by kernel, the IB will need to be read from VMID 0.
However, memory read/write operations from within the IB should stay in
the job's VMID. This will allow us to enable packet type 4.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v2: Fix accidental removal of LMI_JPEG_VMID_INTERNAL_OFFSET as David
pointed out.
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0343a64595f2..49ed2b3a7dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -892,14 +892,15 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 				uint32_t flags)
 {
 	unsigned int vmid = AMDGPU_JOB_GET_VMID(job);
+	uint32_t reg;
 
+	reg = (vmid << UVD_JMI0_UVD_LMI_JRBC_IB_VMID__IB_WR_VMID_MASK) |
+	      (vmid << UVD_JMI0_UVD_LMI_JRBC_IB_VMID__MEM_RD_VMID__SHIFT);
+	if (!ring->funcs->parse_cs)
+		reg |= (vmid << UVD_JMI0_UVD_LMI_JRBC_IB_VMID__IB_RD_VMID__SHIFT);
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-
-	if (ring->funcs->parse_cs)
-		amdgpu_ring_write(ring, 0);
-	else
-		amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
+	amdgpu_ring_write(ring, reg);
 
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-- 
2.56.0

