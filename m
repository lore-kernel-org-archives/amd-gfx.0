Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA5CC3DA6D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 16:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31ABC10E915;
	Thu, 15 May 2025 16:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DbjkO/K/";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC21010E910
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 16:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnvv0EYUWuwETzAcH/N7AmxZMiw3N62IHIKvzTCrqmvnIUQgpPJwrpe1rW24RdlJNGvuUsMwIT29PV/nq4Y1qV6yn/5K441GyKF2+VD6tRB6o0OHe//2J9LGr7aRa224I4NwJRIAipLy5BMdanQQvbOshHaqo9UrEdjRQCs8PpByOcN+rUYNSfIaX0AyuI/xfEtFqgobePOrwfNTJSFhHz1dy7Iq8jHwjK/WA89MaXRm7bNIHFpEIVv3M5VY+Y0CmHPaLsrMm17iMZNQ2xOcTjODU2mAyyyFCve0ZEgwhGRWJD95Dw0OshgPvY7MXsTg7A4E+sg/6D6JxVKG857+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDyvvn/3HRZiRI/vsZwMUVXfJWcANyoUz1giQ8d/FCE=;
 b=IRSP5t4oTmUid1J/aegKzBL9idTI5p/r8IwdaQh33YVbOPHVyNY3nJd04DPd0uUs0C7a//e5UIbBHHMhxPfyaAXCP1I4fXO2+wUvrgCXb3z1ZzfZ0sGm+YAeCErGyUGX8hhbaIYcvdq4to7820+4cWYWIQEdkiemvAfYRFeKK1JE0svL9oOzULw4tp4Q7k4xczC9gHCewVgcMCg8krM7rCtGZEMSxqqyorTVsCW8N6xx6Abd8p2jcMFpcEbp2d7MsD0P8AhYTjNCrDZ3orkb9SvwY/zzoS46+2CYC1QzWaOwbLXnLdfO4jtHB01RhP8kxlUa/C9NgnngXlfEL0ITdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDyvvn/3HRZiRI/vsZwMUVXfJWcANyoUz1giQ8d/FCE=;
 b=DbjkO/K/Dst9lvaIdUEPbgPLQE+RMvxKv7AcKVu8lceWhpzl50W/dpDQ+L4TOavlco0Z41gAoPhT6BhrlV5BTMre4CtaHCSFUwIO/3AhysEn+makPRKkBLYeLxyf0OxWdf0XjJOHemnys4MFNbD2Yn2jb59s62ZAwpVUendBrrA=
Received: from MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 16:41:18 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::57) by MN2PR07CA0004.outlook.office365.com
 (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Thu,
 15 May 2025 16:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:41:18 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 11:41:17 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v2 3/9] drm/amdgpu: read back register after written
Date: Thu, 15 May 2025 12:40:56 -0400
Message-ID: <20250515164102.808954-3-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515164102.808954-1-David.Wu3@amd.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 16827498-2aec-4ccc-e89f-08dd93cf511b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mp0/J081Ih3tHSt4+CBaRpdKJG4nShOnHPyEpNuMGPlJ3WLJOzJrLHUBm5is?=
 =?us-ascii?Q?gfIYv/pcOqZhL078v1ZwA4XZnskltdWwCxhUHMgUZLVvHYmpM/3iknTdCjsU?=
 =?us-ascii?Q?5JktWRD21EQ6rxS6DSmho5qkb2ezGcFxhT3eoN3QZEHOpeZGHlKh20/KLpaS?=
 =?us-ascii?Q?4sMMHXxB0GAKrdXOPNraR6k6WWTMj1zqg8EPtwE/ooMPluXC0xVOW145BgfN?=
 =?us-ascii?Q?mIHjiCD73m1VoHQqF54BZEq8ecbj2QLmo6Vko803OGVrBQxKrbmx4D4CwKQA?=
 =?us-ascii?Q?FlIrZhCJ5UDrsBLZbAlI95v+3xiQwN/aK7z84F867ajDn+Tdlgh0y2p/ajAj?=
 =?us-ascii?Q?B6ERb6Suz6sb5VcG3Ug6dpKvEdp3/Al4DgqkJVGvqOwI8voDn5ZAa42trG0r?=
 =?us-ascii?Q?DcmBSJVkOa9PKciW4kXO8wtP3k91eds3OE5XTbE9t0wQF57MnL40v9rrbuvS?=
 =?us-ascii?Q?sYvfL22sgYaTD+R3sNxpzDJoNr5gCbLUh+g10a4j1QamUVta58ghuS47TpEK?=
 =?us-ascii?Q?ABRQQ9jvxtLv+9xfccbgBNlpIwjlqd13cO3esfrM3exYuvu9ESM9Nzpf0zg9?=
 =?us-ascii?Q?SBJXrt0/6RPO4KorOq0Vc5cEb7ZkbGunnNnT9hy2UzywzsibUIUIz2TIkQBL?=
 =?us-ascii?Q?a2raZ35mR4FevU0OitP+ALIWHj0iAOo6Adwe5hw38sWuCnn/1JEyxOfgcqoj?=
 =?us-ascii?Q?YBmLjcnAyYzFCNIviGXw53+EU1ga013HjT1ITb/zLR/stHXmG2hMhkqwCEYi?=
 =?us-ascii?Q?npZjnNJYpkiGMyOfd8I9igVRISogYMqZCLrt1+6wYzKFuKl7V6lhtXL82zZS?=
 =?us-ascii?Q?KWzlzKC076vC9TbvGCUxHbKaZ4JgJ2d2U771RBrgaG8hzoIeh8/Z/OwI5qW+?=
 =?us-ascii?Q?Goc5+Pe8HHBK22RFFmRDOe6dTpzcRh6ZXGYYUMVqwNFUJqWWQJr6qc6GOsBv?=
 =?us-ascii?Q?Dz2pOJfvlCLwGd+tXPHMSpLIW2w/4NW58SIl2jK2lpNmlqJ800H+Gg5X1zUc?=
 =?us-ascii?Q?iZmoMmsW+lpjE5wxgBgE9fA2/VpTuh7VkNTHrCQv7GAfoOV9Nh1la3cmHx47?=
 =?us-ascii?Q?etAiEqUUPbgeaxS8UqodqmdwXdNdA9Z+Igx0RMrDkBEGYHECYIiQ8s+0AiHT?=
 =?us-ascii?Q?qg4hApm/Ws8QmiTEYeIUA/dbCxd4XMsmaT/jtUhxM/iJc9WIp+8mxh6UJQAI?=
 =?us-ascii?Q?UWMrFnljHkAq1RqzSR62jMNMenMtjMnfiGQBz23QmjSe614MWqOAyn/nVv2E?=
 =?us-ascii?Q?lV0I79s3T3csMVdo8h/hhM5qs0ryYhNIE9gGyMCwa5EOEvwtWr3YrCXuEU6Y?=
 =?us-ascii?Q?/jrTuzxMjMMnsH2wwh07Xpeq0nnEgYpA4jrJubW07aOXWojVELji+etNZE77?=
 =?us-ascii?Q?puspU1S1GTN+7nYsMc+JbcYvK1y+mv9Zx2J3FFviD31JbBUrLtaPk9J72NiG?=
 =?us-ascii?Q?YSpNwTrjXHAwlrgf+x0yOf5Uagc/DKHBBXxCBGBaaCqjS04ly4tIKrqXfzFQ?=
 =?us-ascii?Q?egNexQI+1F31MOJ534FPYIA6SkwCSpZBxDxY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:41:18.4266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16827498-2aec-4ccc-e89f-08dd93cf511b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
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

The addition of register read-back in VCN v2.5 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3eec1b8feaee..58b527a6b795 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1158,6 +1158,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1343,6 +1348,11 @@ static int vcn_v2_5_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
 	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1569,6 +1579,11 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1635,6 +1650,10 @@ static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
 		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
 		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.49.0

