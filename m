Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F558C531DC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D2689FA7;
	Thu, 15 Aug 2024 00:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KA5mSCxg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8339B10E32E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdAoCFprQHPLUjBx3RJtSAC5VrZu4M/4RGwnecKr78F+YsJogd9/N4npZjR7IuMbejF2NoyjlY7PVpNGPj/U6tAN3WcZviA/uqZ6PLOkQdeIrzkEigS9qevVpFGin8+S3nctYWtXxB471lbn9trIUCxU8fpA9X62N5y736Gj4rSPOGXzjyvAbagmTEF/EOGIW1PcWhSmijA+LG+08dX3Pjj4mNecX3nD2/OzmegXyiu+uVYSN3XwXz1YZ/+RmnMhGXwPhyv777oEF+5GTJYmaa8HSx5zC5RJGrZQymk8IjWoQKKtTwW167GisVDAp8FlWtNG1sKOvYjeselz4Kgr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThhZ8vle2T68/VxohDNWymi2tkkkVNoTPpo9GR9N0AE=;
 b=sCYpm+yORujtYl9nlIJTa9k7ncEtjDoG7yuqhR/H+1oxZh07RfYjEdUr4vq7xFyke9G5evyN0aqUGUV3ltnzDrxV2otULVIga4o9CyH5MkDhhcWxzu8H/QkY8x94NcNykzxt08e9fGWji8Rv6HZ7wLPXV3GWavRN9sNIe4U5znRtVDgXOhhaRUKpQPUTk9ndfnrhZcSQCTNtxMvDSvALTDCws9386tRWt6FI74B2X2dHIJMvyPyUwCRTkap0KHVZ+Fa4QqFJ1sk4qVihwXA4D4Tpryhuftfaxjnvy7QIHswC5YhJWjQmhn9+Bvrbns23S4W/T5WBv8wDUd9T1H9ONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThhZ8vle2T68/VxohDNWymi2tkkkVNoTPpo9GR9N0AE=;
 b=KA5mSCxgYUtaae/udiur+tsaUhOjqu7KoouTFcWgcNxascvwU2oITWEgEGcduR93pX2PbN7qFsH6NxkP/eipUclPjwyUbhTFyg5aqV9kNwCPknzMo5rgAnfL35qOLa6vHlf7SFK9/PaT5NxdDk4N9y57jR5i2MaYQZlKKU1PB3Y=
Received: from BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::16)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Thu, 15 Aug 2024 00:05:23 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::7f) by BL1P221CA0022.outlook.office365.com
 (2603:10b6:208:2c5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 08/17] drm/amdgpu: Add PACKET3_RUN_CLEANER_SHADER for cleaner
 shader execution
Date: Wed, 14 Aug 2024 20:04:52 -0400
Message-ID: <20240815000501.1845226-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2fadfa-fb0c-4313-501b-08dcbcbdf54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG5kOXVmS0JiTE0xTEJOMUxzN2xKcFZuR3hEYUx6L2JzbDYyZ3dkQm1SbXp6?=
 =?utf-8?B?aW0vM25qaG4xLzVsQXdnRlcxUEQvbGp3bFUvQllsdXN2TXh5Yk9BYVBkSWJz?=
 =?utf-8?B?ZHFRM1RKejRCc3pxZCtPUnhsZ2h5ck5IM2hybkEzaURLNnN2b0NZc2FFQzl3?=
 =?utf-8?B?RVFFQ2g3bWZLeWYrQnlHcHF4UWR6OXkyekowNTBJSVR6aEM5b0t1aTErWUNw?=
 =?utf-8?B?cmN5b2FOZk1qMWdvRDJKZklkRFhITUJJNGQzYzViNjcxQXdXSUNwendrTnVn?=
 =?utf-8?B?R3BJbkpsYXpFa2RHMmZXTGhuV09uMTZLdXFicUZXS0p5RUVQS2hNWlV0dGhm?=
 =?utf-8?B?endOa200ZUNhQ25iTFNyR0tMUGR5M2tUcmRzbU9ydHNacDdTaHJsRWhtMTE4?=
 =?utf-8?B?eGlubFlwbVlWWDM4WEhMcUNOcmpnS3A4RzdTUmExRzhRajY2MnJyZzFSZ2xF?=
 =?utf-8?B?NXhqOXlBV05ibTZoRnVTczlQamNETnArZ2d6S2hpdUJ4VlBGNUJHeTByQmFl?=
 =?utf-8?B?WlZYb2diMnhsZWxNU2orcUJVTUhScjZ1aFNEblZ6ZmRvdVJRRU1oNk5sUVN6?=
 =?utf-8?B?UTFkdkF0Smprd0tXblNXTWIwWE5lS291cjJON1JvY20zb1k3Qzc3WUQvbTVm?=
 =?utf-8?B?MkRVa1IzUU0vS1pwMncwQzAwL0s0cmFpRCs4VVo1K2dtb2ZYck12aThsN010?=
 =?utf-8?B?aHk5SWM5cUxXaEpCRjVPNll6Q1A3TXVJMXV4K3hyZ09oTHpRc21QdjlKbG5n?=
 =?utf-8?B?RlMzWUtRem9MVHZVbmtBVVZEWlptN0doWE5mc3Vuek9qb2ZpaVlLdEJzN1h0?=
 =?utf-8?B?U0NObmJhWXRqNjhiMEdyVkxMQmRjMWtzTHR0M0pFT0RkdFZDa215OExHdFdB?=
 =?utf-8?B?SSs1QjNsUEF3SDgrKytTbHRBbUxPOFlpdE11aHhkZ1VHN3pQeHNWczg5dXB0?=
 =?utf-8?B?eVBlZzIrYll3dU1BckIxa1dOeHQrdm9FclIrS0I0RUxhc1A5NlVWcUlremY4?=
 =?utf-8?B?RVFENncvUWVmdlFHUzFTMStuMC9GaGRub1hURUI1T0dQcVFUL0MzQVpCci9o?=
 =?utf-8?B?SDZVRVdLMFMwazNMK2JWKzcrRGJ0QjhrZURIRkZmTHN1UUxQMTdUd3ZDbGx4?=
 =?utf-8?B?a2d6ajAxeDMxZGpzS2NxY2pLNU9odHRnMW5zenprcC81Myt5VlA2UzJaamJ6?=
 =?utf-8?B?SFFQdWlva2VNMUVqYTk0Snh3WnVEb1hOb2JOdHFycW51OHMzU0ZaS1BWMFVx?=
 =?utf-8?B?Vm96dkRpVEpPekdxUlQzYTJiOWZOdUNDNkdHaDU0bXNoYSs5bS9OU1paZEI1?=
 =?utf-8?B?L1VvZ2VTa3hKUXhJUmZiSm9wSHRJQmVnT09TT3dmcEdXYXByZGlZTTZJSzFC?=
 =?utf-8?B?V1BWWDRUc0MwNW4rTFNsUWpaSC9GOE1mend3Mk44d3pyemZqSEkwZ1JtQ2do?=
 =?utf-8?B?bG1jSnVsbEw0dUUwV0tXSFB2L3VhSEJENE1lNDRaaVdXUEVHTXVWWUdUc1R0?=
 =?utf-8?B?ejZSbHRjRDdHeUN6YzRmMXlBdXIyb2ZkM0lmdm45UmhUM2dtYzQwcDVkb3Z1?=
 =?utf-8?B?Y3Z0TG80VXhUZ01NY1JNTlBYWVZRZ1EzY01CSVdMaVl2NmxTMUowWlpwZVZG?=
 =?utf-8?B?a2xrcXNLZnlCMk8zTzllR0NIcnBsaXhhd2JSSHE4b2VZOVFBVCtjQU9OM21R?=
 =?utf-8?B?blFjbUU2RENZMHl3bUtwTGZTUUFQb0xkSEFoTmovaG1nNC9uQ0NVd1dEc0dn?=
 =?utf-8?B?VUFNbXN1ZGM4OFBLZ1JnQ0RZSklGMU42dEpFZW1hVDJFYmVYK1Y2ZzdxQjBQ?=
 =?utf-8?B?bXJJQ1cyeUtYTlJoY3NXcVliN1EzUlZ5ZHhRTU5IdGozVG5RZ2hUY2NPMm1v?=
 =?utf-8?B?azdZdFVrSGhNRTd2ZXp6NkdBSEpBZ1kvckNoQzFJRngwUlRsTStPdGlEU0RP?=
 =?utf-8?Q?RoXXhcMNF9SU+ekjHNxRNzW1WlHgxJGa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:22.9533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2fadfa-fb0c-4313-501b-08dcbcbdf54e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit adds the PACKET3_RUN_CLEANER_SHADER definition. This packet
is a command packet used to instruct the GPU to execute the cleaner
shader.

The cleaner shader is a piece of GPU code that is used to clear or
initialize certain GPU resources, such as Local Data Share (LDS), Vector
General Purpose Registers (VGPRs), and Scalar General Purpose Registers
(SGPRs). Clearing these resources is important for ensuring data
isolation between different workloads running on the GPU.

The PACKET3_RUN_CLEANER_SHADER packet is used to trigger the execution
of the cleaner shader on the GPU. The packet consists of a header
followed by a RESERVED field, which is programmed to zero. When the GPU
receives this packet, it fetches and executes the cleaner shader
instructions from the location specified in the packet.

The cleaner shader feature helps to enhances security and reliability by
preventing data leaks between workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15d.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index e74e1983da53..b9cbeb389edc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -413,6 +413,10 @@
 #              define PACKET3_QUERY_STATUS_DOORBELL_OFFSET(x)  ((x) << 2)
 #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
 
+#define PACKET3_RUN_CLEANER_SHADER                      0xD2
+/* 1. header
+ * 2. RESERVED [31:0]
+ */
 
 #define VCE_CMD_NO_OP		0x00000000
 #define VCE_CMD_END		0x00000001
-- 
2.46.0

