Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42800E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 03:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EC710E983;
	Thu,  9 Jan 2025 03:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uBU1nzaa";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCD210E983
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 03:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcFVFfjrNtATkIvYX5DDkWNerjR3VVFvc8rskcgLWXHlQ5gYj8R0lBWkIUrOhviD4FXUyPEkaaOPQ5L+pDKNCeeSYSG6zpGJpuTBQMtgjzlGJn6SaANXiYjQmOClaps2AzUkMTvOpyNMg6rCXkFiIFv5mIIVbfSHmRCU7kwlXJjGQFs8vzfESvNsbYyDVkNljcaLaWFus6npRVTCCdN5ALEfrMwcuE1KYOk60geGGyndXzvWYsJgiNbmK7K6tcA+jmH0G8Bbn4bT8PPjQb5hza+lsLcqWAMEFB8zZU1HNTAN1HijZ9RICNlKJb4c9ujpUw8X7MR07eiJ5oC+Mnym1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kZWIQRSe7rdankau0bL9ScsBc8JhB12UMDBp0VMd9g=;
 b=GVaGjvCntEhNdaaWpOBR2461d6mHZ9KofekPurMiMJFQPQxmGzeql/O7ybugBSj8N1qncxiPesEloAmO0UOQIo1celZMeZNV04eolx2R7+e7/1QNpArcbwslQDfo3EA/oADK4X1HGWP5AQ7xeQPzWmaa5kirQagXdsvsOe2m0OXV/+GhmmOurlYnp8CMqnRtjBe4C5dXgcJQBuBA5GUQK3yRTdNoonYV6oeWHjUaR5c5XvI8/7Iz7bCgkVRyV/K1ZPA+82lqfjFY0ua+osxsm5UvDd1GKbb0/M7bCt+7YsyyiX62HTV1lX7g8kVK8V7aHNcfoL15PO0FBGSLM5/dhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kZWIQRSe7rdankau0bL9ScsBc8JhB12UMDBp0VMd9g=;
 b=uBU1nzaa4BGZPuI8ybFYvIfTqOrd8VtnoWFA1TSq7csl3Huw2vFB1t0fr4U56wFhrTxYg555yyRCAa8T+YLdA08x3DsvLNsIrdOcwG02Hjyc0RStP3AnYTOAuH0rTkTHGhzRATNtgK5azF7DTsPHRJgHNtIzF4X18ZwCKiy1Tuw=
Received: from SA1P222CA0075.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::22)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 03:06:50 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::c1) by SA1P222CA0075.outlook.office365.com
 (2603:10b6:806:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 03:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 03:06:49 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 21:05:37 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Xiaojian.Du@amd.com>, Tim Huang <tim.huang@amd.com>, Saleemkhan Jamadar
 <saleemkhan.jamadar@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: enable VCN/JPEG CGPG for GC IP version 11.5.3
Date: Thu, 9 Jan 2025 11:01:31 +0800
Message-ID: <20250109030133.3887086-5-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109030133.3887086-1-tim.huang@amd.com>
References: <20250109030133.3887086-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: b42a1557-efeb-45e7-0680-08dd305aa90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D2VtS8pCRQfu/Gmwhngx/KQD5MzIlnAG/8LByl45l+oDZuGQ92/24AQUzY4+?=
 =?us-ascii?Q?H/qt6smcbAa/kEgnKfUfyrhdn8CBZe1mPtdsCdN08k+usNQhJP0yAIH9Mb2t?=
 =?us-ascii?Q?/X3X4+akJwr4bYz14moSsRaJxB9xAc0eicozNSRSoXvFcXNTJHXHbFED350v?=
 =?us-ascii?Q?wyfFLy5jHTiwv6CKIIb4Kc056zEUP5JBpg4SXxsVDWXSIp8DLmEdxlzqimuQ?=
 =?us-ascii?Q?92HXlLR23CAh4pj+OcS1fm+DHLKTspoHcXPl2ajHj21myIOVZNRjs+jMZIlm?=
 =?us-ascii?Q?JC7QLVvISfT4G8BB3tEHjW0V2NHBe6Fd8+t3Rp4PTDW6I8NqaR2okSBYA9g1?=
 =?us-ascii?Q?d15qyhUnoZDJtM6yQYndi507rVhnQZ1oxGdWWFmGxHQWVvNrMJ2L3QkBfeTW?=
 =?us-ascii?Q?fX0w+cbVtIrEg4a9TRx98sgrrKBM1zKMgg1dNdrpF1r6r4dOXXhm5Ix0vJsU?=
 =?us-ascii?Q?3wbuBpxzcWKj54q+6Kcyou7J3JVRxqfKu+4l2kERzgiWo/jXPZVjoU3Dq8Y8?=
 =?us-ascii?Q?7+5ny1k/rECw/CWHtnscLbRm9SwCJo+Q3Dex6OZHxX8tFPSL5BkAvyHVLXU1?=
 =?us-ascii?Q?WYbJ029ES/5acn5oMh6KvrTC6sW1g5l+tpFHhWfwv97vMrRcMgbLWBM8/EWr?=
 =?us-ascii?Q?YyyvSiD42PbtVgkMixklqMinQvbxdeF08JQhNZUOEbGRsfMqoyPBKxaXwVff?=
 =?us-ascii?Q?PqtVf1u7GQEqEovnZRMmOB/1EZYevopsLV3daUbFyv5EkAU6Cl/p4fqNA+8e?=
 =?us-ascii?Q?68tW0kOjyuSly9sqJx/jT+5uJj7IUhVz7peTEWD7xCzwSrf9WtNZR3Vtjsqg?=
 =?us-ascii?Q?YHGDztMmjGIv3mIUalO56oyoyYNTneMZogdjB5f4YUJbDZnS49bk7mfiyxdU?=
 =?us-ascii?Q?RRzth2sSO9SPWfRGAMMdP4fxUqnWWnSoEYNMd+jrpIUCTeDPTohhSKtcwMT0?=
 =?us-ascii?Q?qjBzg9SisXvw51pSNlMFNC9bAUoCbay1MWiHJXbeG3rz0P8pOdhTrkev0kXX?=
 =?us-ascii?Q?llCmoTKdIG7M3h9tn3jV6LyFOh5zSjOCcWqTWxTeSPQ6E2boh2uxdK+jDGDe?=
 =?us-ascii?Q?jpmASZYzzsp5QCHrJqnl67hp1tLG6+WM++vjJ6JmKhFQszesJTAXIjayjOhm?=
 =?us-ascii?Q?1xQcOmUubrnu460kY7TUnNr2nBvFi/j4Jdf8HwGXkazXJrbIhhWCzW/eF66F?=
 =?us-ascii?Q?dPNPV/8k5g8JWqDeYPy4LAPDqWbLWiqYV1PelXRDCkx3XHD6Kfd42GZKQPEO?=
 =?us-ascii?Q?hP8+ttQtGVSORgO79fNpnBHCGSbHzyJo7CV8Trt00gmiCiOzoYtvqfQsa9nm?=
 =?us-ascii?Q?6aZs+eDc/0UtIegbqueOBypbwUk9SY5W+Gw8O2aML38Q7UVC9tyVYmtF96Ip?=
 =?us-ascii?Q?21wdvwROjvWXLl5+kkRFT2dkRqkiKlS+5nmDa+Q5/OLzlCGlLt1ApC8FzI4+?=
 =?us-ascii?Q?48X8tiGygQBH7HPoTlioz3DeC6zlC3zxgrB4ngB36xcJ0JLK9g1Q0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 03:06:49.7180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b42a1557-efeb-45e7-0680-08dd305aa90c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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

Enable VCN/JPEG CGPG for ASIC with GFX version 11.5.3.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index e1dad7ca5b5c..2e86c730d192 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -782,7 +782,9 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 		adev->external_rev_id = adev->rev_id + 0x40;
 		break;
 	case IP_VERSION(11, 5, 3):
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_FGCG |
@@ -800,7 +802,11 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_BIF_MGCG |
 			AMD_CG_SUPPORT_BIF_LS;
-		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG_DPG |
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		break;
 	default:
-- 
2.43.0

