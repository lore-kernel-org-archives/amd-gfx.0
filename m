Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA99FE9126D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5919B10E7D3;
	Thu,  5 Feb 2026 06:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ILZTQz5J";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013047.outbound.protection.outlook.com
 [40.93.196.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9AC10E7D3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1WxCw0i9YPf05ODTsglc5XBsLh5wUbFlE2onhpefzHPnYHmFIRf63iAmZw4HdgPFvs8KQdnY/5kDnLLOHpm4qIPbhrbTX3bqhIrvxdsvlJezLNoj+EtMdB9idC1gfvPmz1t7S4COUnlL0Y9aS0/HVWCUXljlhGCDEszpbwaTBLZScY79W4sfUB6F5l//Dj9G3ZrVDULThsIfAc1Fa61NVJ7v9qYaSADbI9ZKXtYvkKJcxswx9QKXysdxW8qrr49lUF9+K9BtISpZs3tSFwvwC0eX7/1pbjBoardxKWTleLfhy9+pUuryicsKMz8H4EUUN2gpx3vg8IssKbk0yMQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvgBwGmPks98COscHuQ6cEAgh3iAEzPn/7k0aNwsu0g=;
 b=ZpWKwF+Ki0zhA7WHDHUoun3Ckm7AiFiRIlRC60q5Uv5XJ+OxvdO7+woSWYFcBEgLql92x6JZWlgWNrnHTmP5XgDkFCCDtKTo+ynDsMBbcJa0W+rgZwAxwwuFB0fpbreEfOl3SZEjVA30izrEIe0CWgIw5KCq9jtYDgw2N7u1vqrWdH8N2mvVlkXhW2hbU5NcK7Mye58S8hrQ5XU+obtLxH0qOBV4FS73m93gIntxB/DEr6Da0WzXMDPcujCM2TIIhwoes90OQ5dMGObYJ0aocfjUQLezY3OWF9ApC5DMZ48sgRtRoxZE6o2IHq29VB2LL0UzBjmal4vNkm/xHOV8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvgBwGmPks98COscHuQ6cEAgh3iAEzPn/7k0aNwsu0g=;
 b=ILZTQz5J6z+4T696XmzKyKjcjjsjtYtjXdOuo6az7K/YtnHMS6Rc23HV54l1h/ypy58LfeEQkLPlbzVVYomtNDIfqvIB+Q3dgMpYmi0OVMyzSua+mnHrvxJDeGWCu+8M7ErAGMRWEyojhCUc/IEbafdukV7uCeA33ikYg0Ge1SU=
Received: from PH7P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::33)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:52:14 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::ae) by PH7P221CA0046.outlook.office365.com
 (2603:10b6:510:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 06:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:52:14 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:52:09 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 21/22] drm/amdgpu: add new data types F8 and Vector for PTL
Date: Thu, 5 Feb 2026 14:51:29 +0800
Message-ID: <20260205065130.654921-21-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 229289c2-547f-4d53-9b98-08de64831848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KZxcDc8DCFJn9f+koMd6wVhfQ6iwc2M9OOxDOLsiowZ1h9bnZlkg43ALxoFQ?=
 =?us-ascii?Q?hKFfXj9Mf/9eCRdgOPODjPQ7JyD54VO7e6eINfJaIPsgnIozK99B0Nw+cWmK?=
 =?us-ascii?Q?mMOGiWdKHHAOlnq+zVZ+V1h3rRYVRHTzMm1NosQn4Tr2jGKuqRsvX8SkypDp?=
 =?us-ascii?Q?wPdRArIYAobkV4ilCByyFGna/aVFHvqTqiEEwo3Ti7eoAV4cqFbztzZ0VWVC?=
 =?us-ascii?Q?1+kuPXxvODs8iot7ph62/ahUXkgmUbAraieQbVOBRiN/sE7GfknFpvk7oy5n?=
 =?us-ascii?Q?/xFettrGpzjkYK9o08W06dRC1oh6r4t/mHDt+50leIU9w7cP5Xw06a/8bPBp?=
 =?us-ascii?Q?awPlA/LQuOcWwV/o4ypOPtUxgRYy0L6yD8oPo3PQQZ+X/6vU6YS7RIqHYyCL?=
 =?us-ascii?Q?vYb0aW4DPOlpypskGjC42NcKU4rncLJJ+InnQgIZ+9tNUBf6RAwr7VgXM3L0?=
 =?us-ascii?Q?B+A7fMWVqWahe+fbTMxfTV/LHyZD6IfNN+ccDGCfgGFcK86brrzdM+ukpjY7?=
 =?us-ascii?Q?mOrAGiH41PK6LQxmzFiJeTL3R54gz4G2S/zPDfOfpUYEz/x2jKK/YmYqrLqA?=
 =?us-ascii?Q?qEA4Gxq3z9hKi84ZE8amXkkdJkTX5gHZcU22rC7592CcRpn8RJ/ix8VgPDgh?=
 =?us-ascii?Q?Q0bAoUUNdG2coptbVKdw9wyPW2u4wZqkhuaqyPgTmZbCjJ8uFXos2Qm2Znn3?=
 =?us-ascii?Q?NXsRvCab9tNdGLNRqw+YfTk+m35as0PZlk5lA8o66quXfYuNKvpfEibzRYHz?=
 =?us-ascii?Q?lOMb+10Gc6eniI3M0nglmITFuf6jTiLsacigUpFJCLan4Oc/yS2cCTGTdzwj?=
 =?us-ascii?Q?A4Uwquvru2XBRCu4bsfZKaGi/VbEpIU9Lrs/i5TmYgRrbwYK841wm73N3AyI?=
 =?us-ascii?Q?P+LMRuv34nArddAs3TI48TISG7uAz44RNxjc9UEAVxh8ogx9GeMcTIWm1SjQ?=
 =?us-ascii?Q?hzx0Zlk1rkHyxZEqCyXwL7VsAzvdXCeZkcObw3gYM8TGWiO/GxJyLlMZOccA?=
 =?us-ascii?Q?dyvuiKG79xukE9FrrQujBqxD5p9sLCxlpPuTG0u9hVxVkdysq1Ln7lKAq63Z?=
 =?us-ascii?Q?7bfPAaTJZvsLNDz6jQfI4CHOFSHsAgy5omnVYFp8YKMUuUghhCUlMshRcCGD?=
 =?us-ascii?Q?q5cOeygaWDstNQ5VN5WjqJZenLbf1IEIg7mgyBy0/aThtzGTWuL4YNZRVqG8?=
 =?us-ascii?Q?78fRKAj5jz90NySkUH3/BavoOZ/tlfeKq0Jvd8QFB1h0GE8LQsFwU32hnmPk?=
 =?us-ascii?Q?BQCxKhTotldEMkEYyCjOdBYGBHsgpcziYYTKkzjfOAN6ZIrC4rcytORn93tJ?=
 =?us-ascii?Q?7eQyuR+NTxQ0/jECjKBCGvEmrMBDViBnc8cRqNTsbCqhQWTV3YS4lqzthO3u?=
 =?us-ascii?Q?9Eo9vdG4hSGBnwne0EnceUg4INPD69C/lOwr6lzf+AQaWZxrPgOVVXiQ32+1?=
 =?us-ascii?Q?YPjFAOAK4ykc7wB7+I7AnorAjC84rOzEQlG0GKaPabVCyez3YZLQkECtw6lj?=
 =?us-ascii?Q?nG7dmDAxYZTWSh0+ZiqvuK5QU26C3H613HSwFZeQF4G+Ec/Q2kg/ckk3rc+G?=
 =?us-ascii?Q?I1poHBOAdnD1bjvVnFcJ3Xczj+N+DDleTT+NMn9CmFQSoP7m6qWu04CXXwks?=
 =?us-ascii?Q?kottPDe7Ujc5JZsx2ksNA03D4yySPt7QD9DP3UsHXVlTGP4Da7p3b52UMxUc?=
 =?us-ascii?Q?lZOLRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pb2OSkvXlR+xW0ewgpeTRqfPoxB1r1Gsc9abMAyordNLHIakFRQdZYnwxrbF6lv+Mu0i06VzdloKMtVrdkPFzd0a8M5Akwj9MBXYJ83Ne/Ft+E7io+/4k1z+bytyR7foAeUg+FSqO+4X1aRiOuA6/IpzXYeOj6auLVU4x+uDd2KKWwA5H003mwFuNV91VMDehrDyJaxtnHJmFGNFppK9LbQYiKEWZHLR/JIw8nAtC71l8pFi8lrG2G+loDEuv1Q8YSejG/cyZxmhTZsRAaK7ni7x4Rdl94QuPwMjhDYLCeDjwnWG+X8JEfY/oX2P+KUi4892GtnBCMWepd2RS/5pEcTgP+SIlOzRie98ZM2ngc5XdqRw1XPUV3SqYDI9p5s2/5B4HMU4iEk0Z3OvgKUKm29yxeXDlbLsqZxtEWEaPy53mK1zwiCDNw2nRzUYM6e1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:52:14.3221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229289c2-547f-4d53-9b98-08de64831848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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

Add F8 and VECTOR to amdgpu_ptl_fmt and PSP format mapping.
Update PTL format strings and GFX format enum to keep PSP/KFD in sync.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ++--
 include/uapi/linux/kfd_ioctl.h          | 4 +++-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dfda694aefe4..d033b4227f3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -58,6 +58,8 @@ static const char * const amdgpu_ptl_fmt_str[] = {
 	[AMDGPU_PTL_FMT_BF16]    = "BF16",
 	[AMDGPU_PTL_FMT_F32]     = "F32",
 	[AMDGPU_PTL_FMT_F64]     = "F64",
+	[AMDGPU_PTL_FMT_F8]      = "F8",
+	[AMDGPU_PTL_FMT_VECTOR]  = "VECTOR",
 	[AMDGPU_PTL_FMT_INVALID] = "INVALID",
 };
 
@@ -1232,6 +1234,12 @@ static int psp_ptl_fmt_verify(struct psp_context *psp, enum amdgpu_ptl_fmt fmt,
 	case AMDGPU_PTL_FMT_F64:
 		*ptl_fmt = GFX_FTYPE_F64;
 		break;
+	case AMDGPU_PTL_FMT_F8:
+		*ptl_fmt = GFX_FTYPE_F8;
+		break;
+	case AMDGPU_PTL_FMT_VECTOR:
+		*ptl_fmt = GFX_FTYPE_VECTOR;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 1d4e53ddd38b..c6a896003596 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -373,6 +373,8 @@ enum psp_ptl_format_type
 	GFX_FTYPE_BF16        = 0x00000002,
 	GFX_FTYPE_F32         = 0x00000003,
 	GFX_FTYPE_F64         = 0x00000004,
+	GFX_FTYPE_F8          = 0x00000005,
+	GFX_FTYPE_VECTOR      = 0x00000006,
 	GFX_FTYPE_INVALID     = 0xFFFFFFFF,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e0782ed149e2..3e8ee34f8c54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2381,8 +2381,8 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool sta
 		return -EOPNOTSUPP;
 
 	if (!ptl->hw_supported) {
-		fmt1 = GFX_FTYPE_I8;
-		fmt2 = GFX_FTYPE_BF16;
+		fmt1 = GFX_FTYPE_VECTOR;
+		fmt2 = GFX_FTYPE_F8;
 	} else {
 		fmt1 = ptl->fmt1;
 		fmt2 = ptl->fmt2;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index d48c407e9ee5..905acff01700 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1564,7 +1564,9 @@ enum amdgpu_ptl_fmt {
 	AMDGPU_PTL_FMT_BF16 = 2,
 	AMDGPU_PTL_FMT_F32  = 3,
 	AMDGPU_PTL_FMT_F64  = 4,
-	AMDGPU_PTL_FMT_INVALID = 5,
+	AMDGPU_PTL_FMT_F8   = 5,
+	AMDGPU_PTL_FMT_VECTOR  = 6,
+	AMDGPU_PTL_FMT_INVALID = 7,
 };
 
 #define KFD_IOC_PROFILER_VERSION_NUM 1
-- 
2.34.1

