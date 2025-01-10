Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395F4E7719C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 16:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBC610F13C;
	Fri, 10 Jan 2025 16:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XMpJGd+r";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45EA10F124
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 16:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+5Xy1/m7RlEvldLBTNjhqq/PtHH6/e19sm3xUD+iRC7OKuSUg/Z/h4hb55B7SXgdWFUaEajPEESI6JpAySIUtmo4/7djDpTQgjp9/AiCYyqi+mqF234EBdSENPAaTmSYO6N2N0LiMt3UN6zmimyugFmn+8knHjzn+5N7a34MyD+PjG3r+LPqtfdhz7tqxIv+hIftJxrXJp+2TCjE4T6ji8pvO4dXzuu+6nn1nsXglDdOUrUWM+BoFKsj6WBaHAWY3cl4gkduwT0jr2NjS/zKFI0xzFwj5tIVnbbTbvEHXCjWLTYq20QcTkm02Gl7VsDNjjESbIJAMkRFiJfAxLjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNAUOn+tLud0/60qOiKnr++uMRbaHQtZnx8IOUi5xJc=;
 b=GDfde1kJxirFrHElYR76dCqfs1UXscdm3C28kkrvT09I3CGJySxygg5hE9goYegdkgDJY3mAJuqhAlce+9CDxQS65R86SFqfCrHX84MN53DPT6s6kXWZVCijuHzedpiTzdOvdaj/2qAkBo+QILrn2Aeod21v6yen4k9fMbcWUByr3uSTNwCuKro09C7Xx6j4r13GJDHM37AoVV0OX4Q+AU6EfkqhEXik/vUSMU37lyv0lG5/pFPG0dn6OqL9SOueU5HZCuh6w7knFxGXAJfxnHQkr1W+UwxfJlHcXBLvszfQCMfoq1X9knyhcB8RvV+Ah7GOMXKXCvuTHxKT2St2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNAUOn+tLud0/60qOiKnr++uMRbaHQtZnx8IOUi5xJc=;
 b=XMpJGd+r+sE3tdkaxgIHOriZJO/dg/5eB1AOMGycSf6WxTYUcHEGbV8E9r29uK2LUyaszk23iTibQ1VEkr8+ENGKEXdZuuxQRZ5svgX9c0OjizXqqv/BLqWHy9rIlRn5JqRxK1NGNjV1TFQ1zZANnmllS4KojYeabdIAttcr1mU=
Received: from SN7PR04CA0064.namprd04.prod.outlook.com (2603:10b6:806:121::9)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 16:36:08 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::9) by SN7PR04CA0064.outlook.office365.com
 (2603:10b6:806:121::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 16:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 16:36:08 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 10 Jan 2025 10:36:05 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>, Leo Liu
 <leo.liu@amd.com>
Subject: [PATCH] drm/amdgpu: increase amdgpu max rings limit
Date: Fri, 10 Jan 2025 22:05:46 +0530
Message-ID: <20250110163546.93573-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: d18d93ab-aa74-402a-b02a-08dd3194e295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGVVV1U5cTBaSlduM1lnYWNUNkhPQTNvQWJPWFBUNi9ZRmk2NTJtbHU4QmNi?=
 =?utf-8?B?NTFQSkl5S0dabWpOTys1T3ZMckNzblhzK3JTOUNzUFF5dXlvUnZwbU1LeGg4?=
 =?utf-8?B?YTlmQnVvWFBQTnJTbTU3c2xjSTBNdVh6eGl6OHZPK2pBc0RyQWZsRHBOd3lN?=
 =?utf-8?B?YWhqM2NmSlk3My9lMUordm1YNngxZmNMWVFnQkxRSVlsV2FvdXVkeXMwcmRr?=
 =?utf-8?B?OVA1cERJamVPRWxrS2g2T04xYkJZT3dJYUdpOG9tWC9aNzVEVnNINDAxblR3?=
 =?utf-8?B?RnkrTlUwUHpHU08xQUkrbEZOU1FOaklrZVRGMnVxMHlaaldVU2NOTlNaOFA1?=
 =?utf-8?B?QldpK1hCeXhrb1dSTEF5TkZ5T05wU1VXS243YzIrQnBuUHZUM3pMMmNFNnVQ?=
 =?utf-8?B?b0trcXBlQjhnS1d6VU1BbFdWclhqeXFYTmFMeExSaWtjYkdPMTAxU3lIUHZw?=
 =?utf-8?B?OG8xNk40SXYvQzNkQi9valJwenFORWFwUWhlRmhKc0xIQm1ISnVtRkFUeFFH?=
 =?utf-8?B?aEJxaEppOXpVZGJNdnBKNVk1VkpDOTRWOTBjNlNja2NwcTB4cFpRZUs4Yjgx?=
 =?utf-8?B?WE4vOTlndkxHd2RIb0M4UkhSS2RFOEdsT0pLdmtabmJIeVVZbW9MTEdUTkJW?=
 =?utf-8?B?c09IMkJ5eDZNcVdSV0NSc1NqN00xYm9kQjZ2S1Vwd0pCSnk2K2wxOVNIQzhX?=
 =?utf-8?B?eW5IRmI2ZzJ5eHNKLzZVY21WR0p0Y2QxTGVTYXM4YXkzb0h3KzVFQUYxSVA3?=
 =?utf-8?B?c2Z0MGE5VG5rcy84NTN1M3N2UXh0Z0pmSVN4TlM5R1g3N3cyQ2VOSCt0dlVi?=
 =?utf-8?B?K2o1L0ZGRXJZL3ZKdlJZdnJndi9oS3JZZHlSWVZ2S0dZRFBwQmE1eDErYlU3?=
 =?utf-8?B?eTUrZCs3cGpRK0hlWE9KSWYzWmxwb09TRk9rRzhCUGRGZm9sb0J0NzdqOE5j?=
 =?utf-8?B?TCtPUVhkUEd5YmYxVnY3TVJ2YjVvWjc2SWdlY1d1VGxuZ0t5Y1RJV3RrV3VI?=
 =?utf-8?B?VmgySU5Lc1dGdC9rZlAwY21LK1JHaDgyVFppWkRSRXhrOUdjZUJCZFNraG5H?=
 =?utf-8?B?c2VjTlVya2I2RmJtYkhacTg2a1VuQTJCNmhQVmQxMFFNT3pSOU1KWkFjRUp5?=
 =?utf-8?B?eXczTzJmNUFITER1UDEzUFk5N2FtUm92VDhhZzFiak9IdjR3MzdwSSt0dlMr?=
 =?utf-8?B?cFJVTE5TdmJGSDVRcjR6NVBTZU1qWWdpa2VZcHZMWDE0UWdJbWtrOVAyMXdC?=
 =?utf-8?B?NkF0VWQ1dDVXeVRIc0N6K2hUWUFLSHlXb3diQ0EvMHJOQ2ZtWHRxUGtqOE5n?=
 =?utf-8?B?V3Fwb2Y3VFBqK2xrUWJQdkZRQStJeEdyUTE2ODA3aGdXdmFQOE1uMGNlUnNQ?=
 =?utf-8?B?T0Q4S3ErSjNleThjRHBWYzJ2bUl0OGoxV2hsZlY3Qy9oSDdaMlJEaTNWdnJN?=
 =?utf-8?B?NGtEanQ3RUxocVdkZnhEVzJ5eVpkM0dXdklYRGQrRllXRXhzMWd5NGJHWlpZ?=
 =?utf-8?B?ZEc0Skt1UEw3UkswTkFpRlY1VzEybGNYQlgxaWU4R2pjK0syMXpKMXNTN1R4?=
 =?utf-8?B?R0tWMGI1NGx6NE83czJnbTBMMm5KejNEcnBMRGwzMkFTcm90MUdBSFY4SFVp?=
 =?utf-8?B?cGM1ZExpeGtYSzJYaENsZTdSekp0RWdlVURsZGdNR1lmdXM1dFd6aUhXTVBX?=
 =?utf-8?B?cytkMVVPSTZJTE5xQTMzMU42eHUydEVNNGg4U3V6QXJRZkFqMFd2NzBUOVFh?=
 =?utf-8?B?TXNRU29IWkVLcU45OTFJbm5jSHFNR3ZZOFVtRzg0RWFhVU9XSkxUM0ZINURW?=
 =?utf-8?B?Y1E5SFZaSllCcmxsdmJWYjFzMFpwZ0dyQmh2cjAxZmY4bnNqRmdDUUhUdzRH?=
 =?utf-8?B?TUlxMXRDYlZ2UkhXMVVUNlNwd3Rrdno2ZUVyTmtoVGlLZksvbEtDZmtHWWl2?=
 =?utf-8?B?MENoUkpSQmVDOGhDNVZiRS9rQUFHWlRVaythU0FCZlBHeGpkaHR5dngzMDJk?=
 =?utf-8?Q?85Z6DOV6SO6nQZPLUlEG6KEZOUbaNE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:36:08.2078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18d93ab-aa74-402a-b02a-08dd3194e295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
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

increase max rings to 132 to support all JPEG5_0_1 cores, else
ring_init fails due to ring count exceeding maximum limit.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index dee5a1b4e572..04af26536f97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		124
+#define AMDGPU_MAX_RINGS		132
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

