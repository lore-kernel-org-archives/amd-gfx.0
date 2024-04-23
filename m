Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4BFC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 15:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C712B11345C;
	Tue, 23 Apr 2024 15:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0oLdIAFi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F5E113459
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 15:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAfaE+Sc5Dr4rOqP3tarjn5det/9QXmij79KVq0P9LpX2nXUpnhAr9ig5wBns6HCMyQG09HDVfZ5tC4QJV4uy8hJ5NSpQtGdmhuthEN2Ob/f9CDkfYqElbV+7IFe50qlFDjiRF1yLnDizvum+axH2mBw2mfqvu6Wv9pN71dCC9gXBkrbuzNgqjCAz5IfemRA8SmyaVwFHZkbDq/3bOPv/10G9qoobMnDX4/ecwIcwDUUBfgW1YnRd1d2gbSxN01YYKjUYJjOqqnx98Z03Kk8frxqBZk9cZac0KEdxvYYmglAQJdIKSWYiiW9d5MsrU/Gj1RgQGrMBdfHuLvEzmRrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKUDDe9KirG2+gWOuw5cy6LoOZeXQLJth0ruXyfu8qM=;
 b=SuvOvGuF9S5cfJbh2qKLVA7TnZ92Z/H699XmhrENPKWPSbetCJ3V10LpY9G29SEAhVvumv3n/apAZ24e9EbY+Tqcro1d2iheHv9eq/fDOIrmumLKccopApkUrWbQbn/PO0iqAg4xbCPtjq/vhrFKv6z9Vb0oY4AfYAjs20RICmS1JEYTr1cDjWBwWTISxIKhn6w8eIyvdGAyPpaWMdWiBK6JimrLHTk1cvcUkeS2XlTlEQe5zrDiDHgLps59lKIfuhnphW3tXzpSwIwW49QL6rpymxVYmZ44OgV634FCzmXU0iTao/XwDg5Hp70f+vqH5eVnv6oZ+96q3fA0xJBVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKUDDe9KirG2+gWOuw5cy6LoOZeXQLJth0ruXyfu8qM=;
 b=0oLdIAFiIwb9V6qkuCuJsl9jHlapm9XI71nmz7tGhmd22Z9ZnrIsxgpFx8lR5/7cRzvNpVIF5XJ1J9iOiIrsqDTqiCQROiyfj6GAHfHkGTAT057tjX/JZWViCqN7l1sRo/uslXkUS+GhRsrg8h1NSKekRIUiauumE9UfaIk5rpk=
Received: from BYAPR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:40::18)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:29:33 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::80) by BYAPR04CA0005.outlook.office365.com
 (2603:10b6:a03:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Tue, 23 Apr 2024 15:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 15:29:33 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 10:29:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 1/6] drm/amdgpu: Support contiguous VRAM allocation
Date: Tue, 23 Apr 2024 11:28:55 -0400
Message-ID: <20240423152900.533-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423152900.533-1-Philip.Yang@amd.com>
References: <20240423152900.533-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf129d7-17e9-45da-96c9-08dc63aa2d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OD+PqCCmaNn0UThPCAYlA1CFpoyB8UZ3AbuTmYkTuyq4bD6kMoAJ8vxDZ1je?=
 =?us-ascii?Q?LiDZJgxpYzQxKn8qvM3WKxOHO81Jq5veQmwAHcycfu6nLYd7BCgtAWR5IAXH?=
 =?us-ascii?Q?nUIOkcVPxmJ5ISz68T+qCl6I/nhhdzhenyAAatRBq+VNCujmDkIlNruqZKo3?=
 =?us-ascii?Q?2Tss4o80+0RkN0YC6xbk0tybfadmUBvtsANOnlAyW/jv2R2vX9YfguKTd51C?=
 =?us-ascii?Q?4RA3O9TTvvlPiONewYHejF9B5qGGfVF7x5n72bEpimaO0V6tjnnCtDHezi5l?=
 =?us-ascii?Q?T3WH0ivAKIdtRdXs2h3w4k1LfAOqd3cCDqruyVt17Y+TL9TymY9/CYneBHt4?=
 =?us-ascii?Q?2v0LBldBSgeKEh8RYtKXAlnkaX5OzUyKtzVt7tODAxeetivDBkwRsvykvH2J?=
 =?us-ascii?Q?f1v9FkzdGm5ZtsK6kxVst1E0fuCTVyMzkNauFZPQ0yY2DGUG1KyfvM90Yef0?=
 =?us-ascii?Q?ps7dNFXRMnEEwDC8PiSDsQryDWyc0yzHdKAvHmpigmmW5OLZVFtfrZjhnB4Q?=
 =?us-ascii?Q?JS9B53BUBcz5JKja2wD+m+Qr3kya8vGcaPq2d2jjs9TN1CcKnXWWJ2QGfXII?=
 =?us-ascii?Q?d35ePjKoEtTY673Ym2uGD2xjtEdv0tGj/ztYg8fMD5wxBBrP7RsHoqzSSsbM?=
 =?us-ascii?Q?Q68Y+gH9W/wgDZYZmHD+oXvlCq1mcey0cLgkobGkhq6rHjqmWujCI8UovUE9?=
 =?us-ascii?Q?VD8b1M7SaEJsxUgRU/cE1T3+1aTCrr4zBrj8Sa3z2+ek9qR/9Li55Po0y6Cs?=
 =?us-ascii?Q?RU7PpHYQI1pAWP5N/LpIiY32og+fwkMXhd6RiOn8EESOULwqfQ6NETHDMgNe?=
 =?us-ascii?Q?jw4Qz0BM1jw3qw6G1GuGjFOnldc5vk4Zyobmk350x/eopWRZXL9senEkkcLR?=
 =?us-ascii?Q?BuARWEpDBBhiGcyBP5m+isrOlmOpDGWrK8CXz6HLxU72ZgGn5vJ2Zs3xkR1/?=
 =?us-ascii?Q?duZyH4hRP2sboMFzP8sR8qoTCAYPBGY2CiUtrWxE+KaECVM6SQH1u4TPs4sz?=
 =?us-ascii?Q?/+aCzc7LCc4gxXBNAil/T2MOV5omkWwO3Nzz7brvHNE6SdkaC9NdhpsQIUzK?=
 =?us-ascii?Q?aa2A6PKXG23ox6XsTTxPgXFL31usnWNLs6Z3ULw20WrkW5OYhuI/m8WETlbe?=
 =?us-ascii?Q?3Ijj64TjcJIdSXAHfTVuE1/KsJNhSu0Lmkyj4i27/AjrJyuuzyD5Th5gvRbZ?=
 =?us-ascii?Q?VpG1AZdnSfP7Vf5owuBvw/nuxJkvWNTa0JmgKBkXTdBkuQ28MPfJdAxIlfTv?=
 =?us-ascii?Q?DZRrmPQVrrT0DWZL/bxub5a6V4k9lxs4l4i7ynWUbWkkAUhgBUsR/6Ahh8fw?=
 =?us-ascii?Q?O5KiVvfXzP2FH5XscqeNt1jIHGqH1HQRk3WFdgEMRSGtKbI6sQDGSJ39wy6C?=
 =?us-ascii?Q?/FQUoKjcejXek3k5LNx02a/dpaow?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:29:33.4404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf129d7-17e9-45da-96c9-08dc63aa2d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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

RDMA device with limited scatter-gather ability requires contiguous VRAM
buffer allocation for RDMA peer direct support.

Add a new KFD alloc memory flag and store as bo alloc flag
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS. When pin this bo to export for RDMA
peerdirect access, this will set TTM_PL_FLAG_CONTIFUOUS flag, and ask
VRAM buddy allocator to get contiguous VRAM.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 include/uapi/linux/kfd_ioctl.h                   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ae9fd844623..ef9154043757 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1712,6 +1712,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
+
+			/* For contiguous VRAM allocation */
+			if (flags & KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
+				alloc_flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		}
 		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
 					0 : fpriv->xcp_id;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2040a470ddb4..c1394c162d4e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
 #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
+#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT	(1 << 23)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
-- 
2.43.2

