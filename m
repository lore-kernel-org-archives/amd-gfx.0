Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF71C369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CBCA10E348;
	Fri, 25 Apr 2025 18:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dPhye3+n";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B412410E33A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnmKhaDGsliMn0H5TQE2zrXw63mQIhrJvrXYoyg65ZuZW6YiEk6HsFMRkVUtKILrh1PISIYzACF2BYY4q9bJ2+3fedNVrkJzIhH3LD/njkGcREAvdTR42f64+LtarlbEfx2vqDnWUoWTzQifrb5k7laAjlqlVYWw4iZXoXoZm6pxNROY6gyDzYniLqBujL3z2vIGn5AtbanZN4vFN0/BCBU9Y4HQ5lDncGLGxAOXRKx72KKqBQmmDupU8Ks8w7eVdvHLI/EiZbthOm0jOzxI3lfc213FE5xrrC55gKEJPZySULxIigpixBvBTXI9VdYYa630MSszzYwBV7txryRjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTFwqgOiTcHFwv5NeoPlBxDa2dymanKOkErVJ0rVKgs=;
 b=ECA/ipQgwmJ8eRdtOlBuycgXLG6MCXuunMZuvTJnbA+sAQlwsS+km7sjmYjNn8thbPjmJv22CVYjnUx/pHQN06Gq1tvCDDWYEPMyd3I0p+YslpqBjeB4s2Jk/0S6gxZzShd1Ou4iR7cljQEwZw38t42qiiJWn7GcEx8pSGtGg00ePVV3OFq8os4+ZlhgCHptBuxtO/bn/4jBez9AtClxZsVq0XPe8LyGQgIYAMxo0BkLFJvPVzajCYhSNbSB8ggSN/oAsms/agbtKwiqbjnv/CahrDjm20uhXyfW99hYTbJpa2wlZpjPOAWTvNd2oNescexJMoNNU981po2A/vhC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTFwqgOiTcHFwv5NeoPlBxDa2dymanKOkErVJ0rVKgs=;
 b=dPhye3+nezv75e7rIBy8t7QFlTL7OF98ajE7T16c/Y3Hel3fIf8O1aaMflXfElZJMD0Uc7J+7YW6RdwCrF5Qynn+8qpT5nEom6h5mNXjRO1JVGKeoFsvKI/xRMhl2N2XuupuqOeYcak1Ug1hBA/FjRJ3gvUa2aIX/bR0k+7WoiQ=
Received: from DS7PR03CA0319.namprd03.prod.outlook.com (2603:10b6:8:2b::27) by
 SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:39:09 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::64) by DS7PR03CA0319.outlook.office365.com
 (2603:10b6:8:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 18:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:39:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:39:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: add user queue reset source
Date: Fri, 25 Apr 2025 14:38:49 -0400
Message-ID: <20250425183855.165199-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
References: <20250425183855.165199-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 74258158-d67f-4fae-9d98-08dd84287783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+xB5u+IxaQQxf20MSOONe+QI/OlESqeiMoBGjMesSkunmFj867+E3O+OWFiQ?=
 =?us-ascii?Q?rPXwIOGXLqxhIGhFqaFyujqNE3m590FMNolWv+76JZDZwAxUT+BPeiGcFRpI?=
 =?us-ascii?Q?sXUVgLdSwf/0IfMve0MxeDrqCj/9ptY3sNz3X7ylPEUHZbrSRnMon4HAznAP?=
 =?us-ascii?Q?Q22l7uuUeF7I+g9YjXUYqZMhJ8RsOnrR8ChcY3aQrly08cM42TpCNQaSv+D0?=
 =?us-ascii?Q?eIBrV3mS6QhGL1q2Zbxs1Rpt1qORaLhnYG8BCra5GVrnJXE+ZQmFSqWbhp6k?=
 =?us-ascii?Q?n6HlctGG6djquOkT7+8HW2LHr5mG/xugdON8/gw0m4YyL4ITi7RpvPQLsAf+?=
 =?us-ascii?Q?S7gmFUhLqHBv3KQCvHnnPXtcu9AzHtt26kt9QOt373pYWoMdpC0zqgwDOvPv?=
 =?us-ascii?Q?wY5OUR0kCgOMdzRGwdEbHJCDSa9oESGMBGQMO8xn+gdqNmVyUCYl8Cev48ma?=
 =?us-ascii?Q?OmrZWT2VpE2pDSVRfysjWLANT0P0bUA0o4E5Le9F/IdMcEuS/F6iXaeJTi3V?=
 =?us-ascii?Q?8U/LpGVYaemnhs6gfbu459d6pM4GHHcg2zFQm0KuP1nuIhjXFAPwLlQ9Q+wT?=
 =?us-ascii?Q?sgNZfP7ahwUbu6NOOXlC7R78S9nqfA7LpuCzCByCjnjXSZOPC2M+sb/D6hx1?=
 =?us-ascii?Q?YnsxQrYgJaVoHsGcd2HwT+aA0RNXhlaVwWhp90ygAgUUYPx52zkiCfmWtZju?=
 =?us-ascii?Q?outNlrxV98vm6IpjkpCLPvwILnox5404jwkZ7JfBEmjn1X5/PsDdTifcmLUf?=
 =?us-ascii?Q?kTKErhTJZAiftz5kCR8JT1jdyRa2nLn8wRDadcIixgpYo98rbyfEz25khwaI?=
 =?us-ascii?Q?GXGZ9/f+HaJ7mHbuciOZSQOsrLE5tW4Q5feFn7X63doh70XVn4eHUPxKu6hi?=
 =?us-ascii?Q?McLhs4Mkc7pz897XyWwZWGtAg+oKOS12QM3ao1zDMiYRtjQO+o3luS9oaOZ5?=
 =?us-ascii?Q?fVddiIb97pnPmL+ErcjPzkuhyOqx5AKhFtXBFW8L3J5+Fsv6DzBqdhsnWx2C?=
 =?us-ascii?Q?4uusql3Iu2MCE1opJIuduYUFqDjF764yWjyXDLTfFdx4xWRQxnLWQmIwLV+4?=
 =?us-ascii?Q?kgHIJODqnZko0tV10qxJF1gZaDPDAoIWLB/hBJI5Q8OpvY5QFbdmIbz6CnPY?=
 =?us-ascii?Q?647xoTPfh+knarTDMirSZFrOmnpwHG8pyRh2TDxBNQct316AFk4DgOTaBsQE?=
 =?us-ascii?Q?3i678nRgM+BXGEq5NRkT9TBsNiYZ2oa0JVvMRLcj4QeVLDe4D3WFlpHrGfJg?=
 =?us-ascii?Q?DazdJwU9KGsp9+SLxu4tB0alzHnHgPhiRf6dgz7adaZfaAubcM8rTo8kGmb+?=
 =?us-ascii?Q?KGaPgXF1QZjqE3bqJCsTPYpglaeZqqMZTK6G/kJzxiEZY7m61GRTjLb7zSgD?=
 =?us-ascii?Q?Qp+OdpoSElpqoAQuCY9LPQwRYfVqVosyM+GsoUMBZj8+xyl5YVStWzF+OSFv?=
 =?us-ascii?Q?OWy8S/XTBVog1fSgHLpTwh64ZRaN5yWYWn3JRPlsZhHaldrQXx6oVcQhPbP+?=
 =?us-ascii?Q?STd5l3XGCgGJEtXZpF3g1iut+9Dk8P85eAO2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:39:09.4213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74258158-d67f-4fae-9d98-08dd84287783
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805
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

Track resets from user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce6..28c4ad62f50e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139be..ebcea44dd7437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

