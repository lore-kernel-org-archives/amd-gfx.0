Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FB3C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87FC10E19B;
	Mon, 10 Aug 2026 03:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zqomv2zJ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3981210E19B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAVhLDgIhf6OkzLiO2UEcgZ0gqwogbiTqxaYCk2eTd33hJbGi4WXcj15kCmiU3wU8rD6L9Z9qS/kX7L3/rf3sLl+t74fye7lUbBrM01xazZO8/L90SaCRS4Z+PT8bRoLJ2+14MlPYFe3YJbrak5wsIrndWYtTYJSW3FInQqEmJHlBJoYG+YEWvtp/SJ99YzY6QsBO55w8+lEEarXBk9PAEc4KdMeHt2muVQx57ilnP7ialPAzVCupJvzw8rQLpASDQ4TGWIqIbWs8FUyjT5AXwAQvSmGj4mKPgOh7goFfHnP2v34NybeiXcZFIIjBYvRcX4Eei9JHsaxWlCR7PyC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eU9hg92rmD3fi/d0SNcJTy4vNaCtAc2LKVaeXsnBS3U=;
 b=ICYVCxjFKVZ1Kq6POm4Q8bmsVRU9qHS2ophCkGsadjYqbpWlYDaCIuB+Ol8UFwkp9qumI+r3XYec6d5UKP0ZR30IgzJbDwScGXGpl7NVWtXmuNDYt6eJEHHb6SY3Ahrzx07CwhXreWKbGd3SNmCSnCBJuk7yT/BzLp9a5miYjIevEMIRCO9N9O22nULHP/BeFZJA+zHMmlWYEXk198IeE0xiOuxWh5OQlIG8XtaIepKeRSae62io//+HhHfQY8sHD0BrnGikr1k7c6jxQdI8FpV47w+n1E5GRMB0k1pbbLE/5vkLorGGO6IYGWQT7hssz4a4ItbdLlyNcMsGUYs4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU9hg92rmD3fi/d0SNcJTy4vNaCtAc2LKVaeXsnBS3U=;
 b=Zqomv2zJ02s7Ppwc4Rza98FSlIszyJYEfeAOJgZoa94rZNrO9B0L94/UZ9Lo02ut0xp9PNiTLub84pGXrlxTIQwNpHXUUvwuvkl1h829No7m3DYBXJxk4ebWoJXaut4q4DJ6zQ2ChWwDHlrz3/FggdmOoF+ZmlxMmTrQqjT3AkQ=
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:05 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::19) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:05 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:01 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>
Subject: [PATCH 02/13] drm/amdgpu: Config JPEG instance for soc_v1_0
Date: Sun, 9 Aug 2026 23:36:33 -0400
Message-ID: <20260810033644.118194-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 3816a57d-831c-46ae-8d3e-08def6913517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|22082099003|18002099003|6133799003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: fBmAbew6112oQiV7UkCmJqI3mBuSYVEwaaZxmZWmB1Lz4+Vx5em9WWkWI9H7+ZaCYcBX9l2N6/jUmhd+b1YUxaA32EeHQT5FRZDonyfXm1+8AKLgEk8JTshlU1VV9ira6eT+CMGGLedgQ8RVNPmI2FF/0LCA/Kaa1WqQzxht2q5RJZEYSFGsAfIlRE3Iv59FQexyEnQTAme9WGpAuFDIVKVhh6XLott+JaG9b+4tN/P8CnRlydySFxzHxS8CzFG1W2GAFMwf9xh9VAa7I8GFNHnDaVqBnuliuHER+pLV9BFDQarc6X8QtFe6Io534/sgIh5JkIHw/+oRC2xmfEYq63hyQGvwJphhI3Jyw7bYacKLHZ1EmbLuaEfkegxyK4xAmXmNRmeB8qUVDV2rla7zcrDzXYt2w8KOf2kgWPw04l485o/LVJ4Cei1sQTmQhZfvASRNd3pHk33wMoCLZysHUBlDU9sfvy1rpHCiAWgd7ISLxe8j/cBz4fiHD0VqBlVgMhbNdnO5Qu4D60cYk503EPlkXLP4h/HODvLd+TqurQ9cj89pkC0kj+ZsMKkS45gCPaKs3tZgvddPdecwu2XAh/U8f2HlHFlZ4krNi8YsTyEK2F/lXjewZ/E3Jv/eBfb3eUJ0cvtwXI5Uk4nV4vZQYbRtLB+i6nuFpdKfKjEm4pDynt8o5s5+KpycRQIFkn5jHoUWGUNZfFqS3Zzu79NrBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z0LrjkHsdOi5TluIMsdJYZtJXRN0Z1pCYu/mrG3b31vWRvxr2g072DOJHukxh/7MYis2oal4MpuGqXU+AWv1AXi8u2HiUX/6lDXG5G3O91lABX3f2/XJWDKiYzAi+oq0kWqf3CwQ8KTYwD/93MNMM+qyN/1NqKtN/AJsOBH1SjPEQzjpeHj+VDFTLWxoddqPkoAMcRgMhsZRMTHUnyRfW7X5MKEjReW92S6GXuTVawJ5YAb9WuUobVBVyAlEccl8pmTy8AywHtDna9Op8lHttmrplww7bLgy5bgSrIa8F44OlehYtCQ7EurOUSGlzwXgXf6MafWu07EZImwb10ksuM1LT7N456vV9mY1zi+L0W+QPCGq431TTiIPegnPTEyR7aElyzdZ/Pdv6SniprYX5weNtwmJDEbdNluoilvC9XQxJzvQlLHBoV1+0kCXsqhw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:05.3748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3816a57d-831c-46ae-8d3e-08def6913517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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

From: Sonny Jiang <sonjiang@amd.com>

Set up the default JPEG instance mask and related instance counts during
soc_v1_0 SOC configuration, before IP discovery is enabled.

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 37e2068b6fda..04c49e23d79b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -854,6 +854,11 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 	adev->vcn.inst_mask = 1;
 	adev->vcn.num_vcn_inst = hweight32(adev->vcn.inst_mask);
 
+	adev->jpeg.harvest_config = 0;
+	adev->jpeg.num_inst_per_aid = 1;
+	adev->jpeg.inst_mask = 1;
+	adev->jpeg.num_jpeg_inst = hweight32(adev->jpeg.inst_mask);
+
 	ret = soc_v1_0_xcp_mgr_init(adev);
 	if (ret)
 		return ret;
-- 
2.43.0

