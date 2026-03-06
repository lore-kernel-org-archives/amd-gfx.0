Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C167AF513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6139410E2F9;
	Fri,  6 Mar 2026 03:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lE1czgWj";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F4910E2F9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:25:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9dWlNLBpUE4GnwdStWYLzrxbsHttyODDo14wllGppkFPJ/W2s2Xn7EzDyVBl9l67N2wugMCcalXvb/scvS1G58dKbWfIyHSoOwwXSdFXTKLcrWFCG8AQaRl0TwI6PaoE01QVChjSy0K8xZGbg3InTG1YA+YAl0DdSPnf/dXR+oOE+KpN3LU+EhIeZsDbMAGp5btOHRAITc0rcompHKRs+rjmp9ILLfTAZwlaRoL3h+ADwDQLu6DzoRdUdYaLlfKIBsePDUpLkxc3se1iZGLZzWPZmUnrtP6oqdWFKPuvYNxNwp7+y9TiNcbUFWEgkDPVWI03vwsvR5ekJkbiLWVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBI9imEzl0rUvrVojNjoAa3RpHHVmhhoADIIuXLJUnQ=;
 b=CfZnt+73WycPKFZeP+Vc0N6DLKgekW4mdo+1vuevGuu7hxTFSMqgTl/R7fZklk84hfS0LYWtv3CwDcP7Nzk/JCar12gsOEUoQ11nALvJ7JbOOlFrdPg+9lVnv5fiumeExyeFpT5LPGDd1Zb7svdKuUR2Vhkmt5uU/Sg3+V4PiJ+OQg9xTSAupAp4I2eJww4LYqREUvPbP8byOrXC+8C7p1dK3ld+aU/OQBQQWjhbZ5KF/gvck5JGvuNOjLt86qjMUXJs8z1MT+ScQVWOiLAFRKWoDoLjqyoa8DEXAbjGX9t5tfMrXK6sSShrykjPH5j5ct1ijWhEKtYhITUVrWFW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBI9imEzl0rUvrVojNjoAa3RpHHVmhhoADIIuXLJUnQ=;
 b=lE1czgWj3Q93XvfA4Md4nJ7eiRnzKRriigfxzPNzIXG+LdVT4pDCkiYLCJOD7LzDzsNOW1CHBkOFJ63RXThTU4s3OYHPWl6HEGEV+xGRai+6Fsw6ZBedYkmw9iW9exTITzghkvGUP4f0Bgy0fJqL5unA4kWRgO9Yku8JDWxr2Fw=
Received: from SJ0PR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:334::11)
 by CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 03:25:06 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::34) by SJ0PR05CA0096.outlook.office365.com
 (2603:10b6:a03:334::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Fri,
 6 Mar 2026 03:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:25:05 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:25:03 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 06/21] drm/amd/display: Add COLOR_ENCODING/COLOR_RANGE to
 overlay planes
Date: Thu, 5 Mar 2026 20:13:32 -0700
Message-ID: <20260306031932.136179-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: 1577f0ec-ecd8-4f23-c4d5-08de7b2ff65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: B28Dw/qMXwWScN+daFjbTECv9hPOOegVOtoWxHoZWd6OjohaFe1XdLpUBFKgJr1uRKWNo0RAujkufWqyql10Qs3ZJ6NPDHelh2ZyZzI0muOlNiSZzGkzmMbaZ9ybdOwfvd3cvPLvAiUTOdqaBjGJO6OCpn6WSuXfX9pRT7231VUKszhBDMEh7O5Xhl7Ecm1Y380SQ0yWIxaSquajg7127ZWRb/rIDJpRgUqXFsfIe7Zz92cqmzqOEy9sQRRxIrFGBLLnMkd5MnrQrePvwv0IAbn4x3Vtxdzsc1yMb6JV2DAB3F7BjQv1NZ5x7azOx2k6jPG+GoIvkmgwiSq9LdM/LknAtBlImAW1zAxbPgZDnOxfu7zvXfF/zt4HMct/RHp2fpb3CmZqHzVQXwtfRivyHIJ5tjJtpv6z5W31T6UvFaB7papFYKao7VIzK13uEGhFNVHHy/tzTJvtyQL+r1yn2h/65KxenbZwNh2T0mZxOG38qbntyPFCiXbcFMVpftcCktv+Q+PkSME3dSVZr+WFmFOZRjRv8YBSsYZmhBwn5JOeV0QkkiiCUVEIsdXWVcJ5ggVH426UiIBwsrhDmvCH+ee9kBHwQsK6+qlj3FbNaJXDjrC/7E42arvBHwQJmV6xQWBgp03G/rHSef6ec6TSLyWPLw/bPyST2tyG2fpesmOTOnhwNpM5w6ZR0FXn+xH2+RagMrnA4J9FRdj7DuEfvum/kozETVc+KQUsjS6UO+Vxa5eEzz+ILr5EV0Q1BpGj/T5gYJzPWqlCWIjdWm69/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uxcuyjtJ/GQb328fTDKBr44SSycPtsplp/PznIYuQw8UDhCvBcGBfKUnuKwYxNATKVBP+Espt7Z1BoxfdPxmgC3LTos/wLqiStKV6jWbLo/UAuvW8mZRfqEIk+LcREEWFtoZ6q8B2sO8E+cnXL2oGGAGDk+omJ0iKG+cBtW5mhaNpXw6yYSEizXXH+czDEZ/tnUa2l1xgcrwWLwZRA/URy0hD+K9nUmnRQrEM8/i6Ol8cWLa3QTalR5dE3JbABn5z/ogm8N5Ce8hrAcY4iYeXTcJLgegsvi6YEz/Mx+gvKryfPoX9UFlwi6j5teQIl0k3BB1lE3LZe6SZlbSP+osiaUnDBcRmyYCtrMAadm7lb20BvdJES5hItb7aodK3hfDnDkl5/3yQbqyQRQfY/iQ+CVoALtJXpintn1FLpIaLGrwhwedw8q/bR8aaV8eIGCo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:25:05.8777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1577f0ec-ecd8-4f23-c4d5-08de7b2ff65c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558
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

From: Harry Wentland <harry.wentland@amd.com>

Extend COLOR_ENCODING and COLOR_RANGE property creation to overlay
planes in addition to primary planes. This allows overlay planes to
use YUV formats with proper color space configuration when the
hardware supports NV12/P010 formats.

These properties control the YUV-to-RGB conversion matrix selection
(BT.601/BT.709/BT.2020) and range handling (limited/full range).

Co-developed by Claude Sonnet 4.5.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index c7f270626715..0464def3fdb3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1864,7 +1864,8 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		drm_plane_create_zpos_immutable_property(plane, 255);
 	}
 
-	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
+	if ((plane->type == DRM_PLANE_TYPE_PRIMARY ||
+	     plane->type == DRM_PLANE_TYPE_OVERLAY) &&
 	    plane_cap &&
 	    (plane_cap->pixel_format_support.nv12 ||
 	     plane_cap->pixel_format_support.p010)) {
-- 
2.43.0

