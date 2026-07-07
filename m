Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA98C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C897010EE27;
	Tue,  7 Jul 2026 15:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7oZPI58";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C10010EE27
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpMphJN57gvkzsBpkqJfhknfUTQglpuAv64KJQk8VNdXbls0xS2qj/xnTBsXhc9fv/g3cCz7Ebx7Tvf4w+8AbxpXIqMTU2qyuyNJT7BXLYOkBVUOJ6hSMdDlPkDdGQLjZWJKSitYw4YTF5wYOU3NqXrDryB/T8JB79UdiU/qtS7YrlfU4R/fydbPPVzqlsNCx9+8aVlK4GnhKTYpFE5SttJQQcvuTxEadM4k7rGUvOmlblXY1/pGGh9hY7M+d4hRq7friR2q93ObLFWsBY6HMw4iRyyIOcR6dko1MpJ8C4qcM45mlyLpFQyLP5qSzI1mha26wed/ZbgIKvathhGrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8oExMhw+1HTcU0yZh0rhuqVW22Ebt7EK/SsDUg16Vg=;
 b=j5ytoH5LmKuKvhXMBpgiquVsKvXe8j1pgeT8ySeMZj5jAnx4EA24+tOEjhvrHtHeEBDxHhpwMgYyZqgz+oNab8G8ttuIiW/8sU+F0VMc5QTrpjhrehTCL6HtN3fjF9wYC3nPHwAMgV+6WvGgBpFHQwxbSHXVylMMDPb1OpyRz3qre/xROqCHyfxUQZgCAL1b/pE87RmqB0Pg298oRe8VN1DKAqvXpJ1otWFfdjN9+o1cgAByLTAcy/qR354U3f+gKMRMRWSTIBao3ipOCJxZDea0mKhYLwJMZncHn9FBQ/42gxvhp4Ern2ztKiu0n6yEb5L3MkAKgkptb25J5EQqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8oExMhw+1HTcU0yZh0rhuqVW22Ebt7EK/SsDUg16Vg=;
 b=R7oZPI58EMHzLUZcr6MWXtx0sLktMhwusrzu4lkcCDFhC63hEj4Lhql1VQzkkrOrnewGfdbrfc8RWsAAzDlTtzWOCKspSSp6AVpSv9KzrpT33EBVzKcbEINi2n4F3g50GEL5GMa3GAvs82+H/yF3CX9ZVP/kXj64Cs1ewnQ2WmA=
Received: from PH8PR20CA0013.namprd20.prod.outlook.com (2603:10b6:510:23c::27)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 15:42:46 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::87) by PH8PR20CA0013.outlook.office365.com
 (2603:10b6:510:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/30] drm/amdgpu/gfx6: drop all BUG()s
Date: Tue, 7 Jul 2026 11:41:55 -0400
Message-ID: <20260707154203.2603209-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: fa191d20-cba6-430e-d638-08dedc3e63c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QA/fOWaxfJ9J9F195aeRyoy4uKG9PtVLELvIVvZV2suIS51hf0jlV0tZ/rUJeMyuoPrIfqZRo76gyEXN4LbiPF0+78T1o8staDr8CIbMI1QVQ3yktAjyCv60gKdhxctuaB5iSXzEbc01vl2lgJK2r4HOTvpF973g5+unaqeA6wXLjU6ymJsVMYYk4xsV63ykGLue7WydrXb+rdtsQW02BkYwQhWPwdCY7YqTrr5txJRwAsQ4qrwyDvGaKmNYHL09Arg/9PZpUvA5qgbIYf28pvirzfNnY/qWNxJ28GzTqK7uwRy8ZYfqbq97JR2h3fOkp1zK0V1fLt2Cwx7A64UPFY8SS1T6zOPoHrUzAm18YEkg/7HSj/dYcich2/wyWOAxpTuM7T16yJMygU8poEmqXVrOsAm4F5Gvv/H49MJ5eyNEGHqORrxShscDpOcUEE81Idw1BCE+NrhF+NMUefaFSeF+rEE4wXG8x3GkWL96+LC8fYfQjsSJX3T+xMj1ozRiIsbN1XaYrQIolFI4woPBn3hv1CDcmQFfF8+lBZ/Tjnq6drwkkEeOReyfIicugnZxocGW2J77EH0eMBz1a4+5Ncexn7X1zHoVT6Z8ququnguPmyEhnS0HCvRZx+nv21xUgrvQVDtWTrbeEZvbbRH/cozndQaUACLDn+0Z56RC7Q88MVdJDkkBMfnK0WpsrB4CZz5ad5xUEBYqFuFcTriS1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eU+xRia3owDrccaGRvMfagL3q3Qknf0TqzlMDijk9OlEMpy0nH36kAsu1R2/UDCY4ehfy68a6FqNvHLsWH0iSOHKubFy4+ipZTvofDKC3S1/3xzQM6zQFGRjNEXKhC0B6BReK0xSyqCOFUJ9G6qtifNVZzh4mnOY73jvNw4dkHNyUw95Agv6aK8MR+5hu2DjHAlUiMuyYHcfWvS9n8phgbJjfiRCzU6/+mxBhU1mRs1PBA9PKx5r4pE5CrCkXt4LLx0OCnC4vUYeyjusUP23cm74RV2+Uw2i+IuEWhn5I8HVD4j13a4ZqgZSDjLlyMGa+ngAyxoXevaCJUNg9/TL8DK4zoRcZWxRlUqJ3l3YdrfRtikaiSpCvW/fcFL2rUFlRd5fbyrT3F99iUDBxrJy1fN61vCmSS1qGb8Y/2m5qw5YlRDkUVEo2YG1VJ6mweyG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:45.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa191d20-cba6-430e-d638-08dedc3e63c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index ac90d8e9d86a8..4ba9ff7c3b3f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -347,7 +347,8 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_HAINAN:
 		chip_name = "hainan";
 		break;
-	default: BUG();
+	default:
+		return -EINVAL;
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
@@ -1736,7 +1737,6 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
 		gb_addr_config = HAINAN_GB_ADDR_CONFIG_GOLDEN;
 		break;
 	default:
-		BUG();
 		break;
 	}
 
@@ -2202,7 +2202,7 @@ static u64 gfx_v6_0_ring_get_wptr(struct amdgpu_ring *ring)
 	else if (ring == &adev->gfx.compute_ring[1])
 		return RREG32(mmCP_RB2_WPTR);
 	else
-		BUG();
+		return 0;
 }
 
 static void gfx_v6_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
@@ -2223,8 +2223,6 @@ static void gfx_v6_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	} else if (ring == &adev->gfx.compute_ring[1]) {
 		WREG32(mmCP_RB2_WPTR, lower_32_bits(ring->wptr));
 		(void)RREG32(mmCP_RB2_WPTR);
-	} else {
-		BUG();
 	}
 
 }
@@ -3310,7 +3308,6 @@ static void gfx_v6_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
 		}
 
 	default:
-		BUG();
 		break;
 
 	}
-- 
2.55.0

