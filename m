Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407CBC5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD5810E6B5;
	Wed, 28 May 2025 17:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FWFpBJYB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA52A10E6AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxQlZz2WJrxpv3FmY7Iy2qAQfbt5bX4nEhcvGe/eTIa9IGvyCJw/yQbdhU4JyYXxGb7LEqzzqSQoQzUqIQ5Rc3op6Hnq4qeDH/A1SgYARe1u35DtZjyrZxNGbsOlmqUGYgGgIrrTLuNoyHD06/ZcQPOZvCpjmi6RJpfZ4GSxmYcJbF95hr8k5lE6xLPCyk2JBaclrKZg7omSQcjS3Xq2HxKV0E163X072IzZx9B87LcqQY1NWQWqOhcPDTNPHHO76PR02lTh1fYKncF1dinH7gpcbEmAGWLTNADbzbwPndFgoi9B0im+dsg9yWqL6dTILlVT/Ht1zka2FiAbXYFS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F1NUq5kbbjmVOcP5bMYv+43Db2/AkN2VOnSlRaqTfQ=;
 b=MWoEI4ChK0iIsdIO+NpdVLNgIU+JBOCr/XaVjo8Anex6O1DY80u13l8uu7Lhh4SB/lcz5NzZKceL7SKhUifrONG9onayoPOAr29FrGi/GbADTzbqNAdpHxx7JEPW4XuJZwVDyjooBwncaCztKIh7o7iFQTJBB9AOU9NdXDjPPacBEAdoZ69un8j8jtd9x8wixfXvAOGgZRYQflqoWAILj7xj7VtxikIb8mlgtCC2wjO6vGsagLX3zBBMeGm9c5PwhSuggxQ3BlIM+E8sqeJWTVPyaPDLCGc2D0uW3eNpbyqyrvo/2+ubKTwtGm2RCP5pcM8mgER/R5sTfOt4DrC64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F1NUq5kbbjmVOcP5bMYv+43Db2/AkN2VOnSlRaqTfQ=;
 b=FWFpBJYBMXWc5GYpHIDY0t3MVcWEZdhngzgHLzDpgCE/i370NEkR07r3R9P1chE6yUr2fQqu/S+XnbhPpn5MjVsD1N/f9Rueh0tKD7VYZf35/7bzSBk1tRwHliUrnIdUhcD13xPo2lrh2RJBchzwysKlcWDj92kKrnZ23xOmTPI=
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:28:18 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::2d) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Wed,
 28 May 2025 17:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/16] drm/amdgpu/gfx11: enable legacy enforce isolation
Date: Wed, 28 May 2025 13:27:47 -0400
Message-ID: <20250528172801.34424-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: c4555c96-2de9-4c6a-e922-08dd9e0d0888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3QefGxL/OtUbXWF/QzhUNnnrE1hdDM7bEgdavGnlDoOVX2lKjaeIh0QHQl+J?=
 =?us-ascii?Q?ISM2iLAi+RXUiwcyBmUa6Uhuqhyq8EkK1BWqr5BxEDKkA7ZtD2evxhKEP+lq?=
 =?us-ascii?Q?xcn63x+uLPYotj6DG56bYK5FfJxpNGXDn+H5w4nSgQp4xDKnM9jxoF4a/g7M?=
 =?us-ascii?Q?s3c0SkcVRgvm1zANtWlo0M2ZEWYDvVyo5q3wyL+AIVliD0otfg/K7CW5t+gD?=
 =?us-ascii?Q?zCBomjG0H6vp3rjy5LTqLah60bPj0PBaEOmXE2NzfMxMM8nxs9N2xmCmCYd2?=
 =?us-ascii?Q?zLWsxGE+uH7hxN1dJIeEdwn0QKrbor6zE4dJU7XhjTYtEN99uoPZpRMRuW9m?=
 =?us-ascii?Q?1PzCeFNVgYkUrl/BiyNy2uplKByUfdDp+13W/TeBFyMWXbiw57X4Fz9DdYI5?=
 =?us-ascii?Q?5jNCVuNIgHBg6bvgOFarWnr8ftfJ9cJxPVeINUljiucdwYZsq8oLcEIbtnYf?=
 =?us-ascii?Q?y200GkE64vSy5KZNPqUPo1u6+hQK7uu/mWLsONSscTfhG6zrqQsL6d4/mNrU?=
 =?us-ascii?Q?6yHL24pBesamGrg7zxgRtLYl+5joclgE3bgz63DSS8pNpCk5IdyqPXlcCZvH?=
 =?us-ascii?Q?WOG0DBv86//Cs8F/Ug6l3FI6GLzfUgwVn59L5TG0K4Vr0vZpXPAJIxM/9mmY?=
 =?us-ascii?Q?aOYpzUqzq89UYMUc9keeNOV+qgDj4zMtVRRNHH5jBSLEr+0J+UY9xSETqDpc?=
 =?us-ascii?Q?GkoYBhf8pmEMLizo4aYXRPhSd54mVVYG2pJoLgHtex+zi/BNNQDgHiH2WktX?=
 =?us-ascii?Q?1hWspVHTHmlLHp9zPFU5+22v6hUd/61+VNBzHpC6rJ618pKum1Lw+8suiHSZ?=
 =?us-ascii?Q?nQ8RkBPj9qh854Z5AYpRRSY4gpozXEpJU6MdrKElNhC05IS+zU3saZKmen1N?=
 =?us-ascii?Q?o2OmZm1ch+mYlBwwzWOlqeGcDjuCR3ycMVkwQflfRULUWsp3CGP1vX6ShuTo?=
 =?us-ascii?Q?OGXN4eW4VqfODZPInHwcfpNQ4j3ObHnnEqqcQOKc4JBO0dt9Fhzrb7MFik5f?=
 =?us-ascii?Q?EC9didjUMUaAFn9OFtLXIoHUdacCd9eCo1xhiiiDjXJzCTPQqsr5oQ6dVEC8?=
 =?us-ascii?Q?P5Q3QqecAvPp0iQR7BXDikOdBrUcRu6u9ZzieiDx1KO7OaLrvgVlDYDI2hV8?=
 =?us-ascii?Q?qgtX3sC8SORooU6YB34XG5LqWmCEJt8ZJ5binElCam07ILslGCk2EN1wIWKK?=
 =?us-ascii?Q?IFJRyZRw6sidoaYTitAZGQvkZdqAKYWwpqCb5EfaAuYW2lMN4hf6ifnM/u4d?=
 =?us-ascii?Q?YCynojvRhdg2ZdxClAUQV3xRuokIcrsUcdL3XtTL8ENXlH1+UZ12H3CEas0S?=
 =?us-ascii?Q?p+tiWWm3GUPHgzxAkoQURWGBrw3mK3CKOaP76Ddu6+XeGBg7D6wmzeDaRCXh?=
 =?us-ascii?Q?czkaNu+lAaxewHv8mMrWXIkSUbTt1liTIMcCSzNBcOpdSosga9un0xLBwdH/?=
 =?us-ascii?Q?xT7IAA3PE22RDMlvy+dUy6Cuxu+bLR34U+ho02LbvNCWQicxCqGXAq5thlJ5?=
 =?us-ascii?Q?q4mJnmt2S2BsExTq+R0PbfJ+0mhEBakM9CUl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:17.0863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4555c96-2de9-4c6a-e922-08dd9e0d0888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index afd6d59164bfa..39374c87738b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5189,6 +5189,15 @@ static void gfx_v11_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	if (amdgpu_enforce_isolation == -1) {
+		for (i = 0; i < MAX_XCP; i++) {
+			/* enable legacy mode by default */
+                        adev->enforce_isolation[i] =
+                                AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+		}
+	}
 
 	switch (amdgpu_user_queue) {
 	case -1:
-- 
2.49.0

