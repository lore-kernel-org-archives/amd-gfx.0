Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DB1FF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB9B10F3B8;
	Thu, 30 Apr 2026 16:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UWn/wCUy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D50210F3B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQa03SyxInk0GUpqNRxuoB1wndM1AXpw33t1781+DdCNr+taUyA6AgBbkYbivCFZkwPKNJ1ST9jb2Kr+GS9aZOVQRPM3O7HNQVSSxjj2bpsTvql57Ir96Pq11XCJg5/jt43wTFTasKRAONdBnAcx94eKamO3M41pCAE/OcbIliTpEAtLemzAVP6FDP+qtGeXiA+t/e1HYzWw+4yEdyf6xyq0y+vjV13ZeKWKdAak9DyMeM7ogP6GkwevCa9KQOBT3jXKxa5bQiEMKQFKLvtUhZfjbqRc9mrwHV2mH5wWXwqJUf8IbkHf8FU3jlJ3fL0AiXA8hlcH3KSGiuWlAjcZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq7I3Qy/slJib7eUKWMGcA04DiYoSSB0TfU0hYruVEs=;
 b=gvWK74Jss4OsHrsi8+Ul8xUpPUTZJMj8QSlAzubMxEI9lP/w/P/ObQ1UhwPjfdNMdXu6kmwcaRq1o4ABQlIq5SGwJRMQmXn8HSNVckYgyiEBsussVu6LKAz3du8XuhUP8Rln734BhXllUxI05xpHqJacaCubW7xMwWjMNi795ml9LpBGvojx20VzkuqNi3XzMnzDY4sKXWNqgd0bNxFkl4XtymtdQtvTDdM45ipW889N+RBeR6PqV/R0RySUI4iyckZu/+LpCE3hfnUTFUwAzv5CaCjvYITMb+iXgdahDfWtbAAN/l6thjNLHJD76PWrgCKV86l8FYs+Et665Hb3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq7I3Qy/slJib7eUKWMGcA04DiYoSSB0TfU0hYruVEs=;
 b=UWn/wCUyntFOB/1NrgINnbG7wBMHvD+aeYk2BhA+Z8Qs9T3dFai0uviWkgzytMVluELZM0BKkeDOGT8cHk98/x9KZm4vHSRQ8WI53TlFj17TgVKOVhzL1OuIaH2Ifz8UU8kFpNAa2kl1mKZK6kSfxHVCIPfdWobZwgdg5YddixM=
Received: from BN0PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:143::21)
 by CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 16:12:54 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::54) by BN0PR10CA0026.outlook.office365.com
 (2603:10b6:408:143::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 16:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 16:12:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 09:12:53 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:12:47 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 09/10] drm/amdgpu/userq: report SDMA UMQ doorbell info via
 AMDGPU_INFO_DOORBELL
Date: Fri, 1 May 2026 00:03:37 +0800
Message-ID: <20260430161146.2851078-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdfe5b2-dbf2-4183-7055-08dea6d355e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pS9tRJaqLzPFgBlU731ehIppKZiCi9zcT5fxhiHXFW4BcXIEF3Ium8x4/lDncCG45BHYH/jvt0cexJJovjH9CUFE3QlVzBJz3otH36mtN+YShhOOVcvqe3W1wPdW6qmkgqcx8aof/QaUbh+aWdO7M50UNIG/7vV6aa7eRAceJGSVJ/Ei3h9JSftjqZo0dC2snJjiLrLV35+/MA8vO9MHkEdZdJbkCyXjGXkWNjDEN7G+Ir90IimHbVGsqVJ9YFyTwwmcFAsy1yWY4+DB8TjA/N81hucaZJESPMZ2ZmIkAe26qHmu+vcJrS2xT9Sq6oSK1OMWzKrEZ5p9BtMhNg1RWBRjMsHVevLnSxO/IS69+AOBdy3zIX355a6fh3ziJQkfcTzDbenT7dOhAjGePy8+38TLUkGn42ycGGggJ2TnHV1MuzjP9zDl4on/Cp3KMFkxsBMM3Wm08b593Z9fK6XBK4AGbRJSHMBRvaMr3l3JIV/CkIm1XYgt14pIv3y+s0edXK5Izrmyq9X8PO9l+4tyrzs4rmpOYheTuxXGHhm/UDSuUNxrXs3NzWGUi2194q68ArVsEMxMjzSSdAwfmMV1Tb1SolQ0vk6XgfbFjkFTKYzvV5XWiwEAVPAo5V7ryJjhfPVh0IXc79kQ2DBrn2OC3r5Y3oGTDcr9feTsTSEU/UcEZtjRR07hxjaKc9RVex8Tv7C56wkiEmg/61HutRxqpDWWkzXnfphkjn8hBcFqUwcVPLvPjHpFN9jhPARWwa/2WwYZFmD32Jv3brY2ssKJBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IEqdAcQGyOLF6AMsfQiVABPWPsJfw+CUO8Eqk7u/iKXWGC49EhuKnJP9jErOTCqMqOZ5vuKHaNJR8l8hd0bUV2MEq9377df/fdLtUsXno1/IG6sWuMtoByqQB9o6PPFM6ga5CG10StcYhlewLQx70fVsiuDuc3SRvmnh1/rTaujx0pmHUW36KYPeSn2TR1TmXOD8k3KhJPIqD9kwaAW+6ry+nBkxtPtfKzmQ9CDggY06P3m50FvWIuX4z/AET5S8aFBX761FLOz4jUTiCQGykON+6gPn3ZKe/mZt7tiW9tWBS3ORzLXvgcnNXvNkaVrtWypH7FyHs8JmNoieQ5alVIj/mHkFkSnJdOiT1pZev1yuOP1y6I0BVhUL0FBzJLHRc7+0v5s/yymT3NCP7NmZH9Dlw0XMLTuJRXDC12aNcIdggzI1DxRv1NGPnUU2GXqf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:12:54.1838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdfe5b2-dbf2-4183-7055-08dea6d355e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Extend AMDGPU_INFO_DOORBELL with an AMDGPU_HW_IP_DMA case so userspace
can discover:

  - The SDMA UMQ doorbell BAR range (index_start..index_end), used to
    validate per-queue doorbell offsets.
  - Whether an aggregated doorbell slot exists in adev->agdb_bo
    (agdb_enable) and its dword offset within that BO (agdb_offset).

A user-mode driver opens the global aggregated-doorbell BO via
AMDGPU_GEM_OP_OPEN_GLOBAL with AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL,
mmaps it, and writes the queue's 32-bit WPTR at the byte offset
agdb_offset * 4 to wake MES — bypassing amdgpu_userq_signal_ioctl
entirely.

This is the user-visible half of moving the SDMA UMQ wake path out of
the kernel.  The kernel-side wake is removed in a follow-up patch.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a3beeff800bf..1c6368d25b7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1437,6 +1437,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			doorbell_info.index_start = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
 			doorbell_info.index_end = (adev->doorbell_index.vcn.vcn_ring6_7 << 1) + 1;
 			break;
+		case AMDGPU_HW_IP_DMA:
+			if (adev->agdb_bo) {
+				doorbell_info.agdb_enable = 1;
+				doorbell_info.agdb_offset = adev->sdma.agdb_offset;
+			}
+			doorbell_info.index_start =
+				adev->doorbell_index.sdma_engine[0] << 1;
+			doorbell_info.index_end =
+				(adev->doorbell_index.sdma_engine[adev->sdma.num_instances - 1]
+				 << 1) + 1;
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.49.0

