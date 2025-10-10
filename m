Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16471CCD187
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 21:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE9A10EC86;
	Fri, 10 Oct 2025 21:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iAhYr3E+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D61410EC83
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 21:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDOKoskUbr4qSXHWsTTWOZW/OFuNkjAnlipX1/5vb0PywHZIATaGP9efMmiOpfz3QE71enJ41pxlclCqOpzNEi+ccway0tT45WvItIU1VISeoJejc8OEdBx5noLJK/7zvpg5ll2+PVwgyvy5FprD+iQHk59Id3KbAsZ+vrHcc8306b7jh4VagEIWb7Ll11ghtUX1QcSBv9SNs8TbzIunKXuE1pZSEa4Bs4MWUqCxiJvLRbvnJPegIMNvnxFXTY9sBuIw/fXMr4aaipuchQ739qIeDzBZ2nXQ3Jd0lacECccTopXv4UchDRNntjzQBDR4uQlOPXexB4wxw3Al9/iOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWujjCicbiX98/7zAEJDSR8eD+en2vNd2MOLTX2ET8s=;
 b=LAk8xldwhbFu4ecnyeuREdylqlrWloJLDMBeHrxDxjLElHXs3mBZBKFmCobzljf9z03oPUavpIMwjhO2A514OXs+8GZM93to1T5iOz2HrxHh09/nV9O6yoKd56IYV/6NpvZEPX2VQlmP/huU7vCmGXtnGCC6BQd9bXOv7kwiTwoQvSmaYbi4CWC0GFyYJXYv1B/y1rD0UFfqKLWD6DULA3bbY1grX6awaUjC9wye39MMHUDQ4amTIDyuV48pmNRTEfMi2HdCkQ794WvuNjBBxSZ4OkFwAI5ap8wd4U6pGGsUJLylQqdijny2hswh3xbZ738D0acXJlQHE1V41zOriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWujjCicbiX98/7zAEJDSR8eD+en2vNd2MOLTX2ET8s=;
 b=iAhYr3E+taGZhQ2fLxnWTSJ5vB76L9LD129u19czoyUYJNUOL8mj4WyW1tLZCba8ZGeoH8OUR7kMM4bPLgrpWlGGoOpGJpr3zEvQbrOAgY+4AfDtEHV4slwki/kImqlCKhV43Y6zER6oAMH8Pq8TcVFTC4yFAik/jCH9RGCmGQo=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:15:42 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::17) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 21:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 21:15:41 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 14:15:37 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for sdma
Date: Fri, 10 Oct 2025 17:15:09 -0400
Message-ID: <20251010211510.1528572-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010211510.1528572-1-alexander.deucher@amd.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc7ba78-3360-4873-197f-08de08422b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ql8fVlgy+vJpRZJBc5jwLeuudKEhv2f/FKyTG/bSNtJKMg4wGcBreO+uYvDH?=
 =?us-ascii?Q?Fx7XxgTWneiOKKGvRP+l+1gjqJ4fqXCvf9XHiXlOxI974LzTGM1FC/P/Lj7r?=
 =?us-ascii?Q?bCaBreJgKPUWz4ab96Ao0JtntUOsqm/lVHooHiRei5fUngn3lbijMDs7t4m/?=
 =?us-ascii?Q?GjuKIA0blzKUipgyLSs70ZAX2VyFQhFYcnPpB3vwOPjBKYh81Rd2Qd2Llgeq?=
 =?us-ascii?Q?q7Q07pE0jeGT0N/Nda8objTySiFLzAo10G6YR/kyj2JMXQ4d24QrWR64I1C/?=
 =?us-ascii?Q?S7ffeGcngms35tTl5jmD06m/bD9HGwuDaHSmxVwjTjuuYvFYNwy+i3HL7d95?=
 =?us-ascii?Q?eZ+cECsuUZQkKjvKygXsycLOELYe4Iwz1C/k8ZGhy4qZO+qVon5XVkHRQO9o?=
 =?us-ascii?Q?6uBDZZtg5Y0T2wbMv3VgaMPZPRB5dpafg+qzC/Hj6ZCzW5iC/PFYf2G520C6?=
 =?us-ascii?Q?vrlK/OiM+ZtdtgJl3izYI9EFv13yO6+B2TlqPJsDGmyUiuzSx3ZtsFgwaT9l?=
 =?us-ascii?Q?YLG6orAztY7kMaclLHNgmu1Wuj+GR3KjhVY6FVRlFqnf4S2UYga/tDVnxelL?=
 =?us-ascii?Q?8WtiZ6wlRcwTLtwy+a9iYvXjWsRTRox4zpYdVEjEA9LFs0ALeNzILZ+jlTuC?=
 =?us-ascii?Q?qu+QN+WLGBH6biy6FHjadrTw1/JmYXxgch4OrCeZjhqBhcFZDyeayNmaIdWK?=
 =?us-ascii?Q?UTl+H/bOD6FELKr08S9Bxmp+0y9ylbB7hn63+PxeQSR82qNj+btG6mQ4f5lo?=
 =?us-ascii?Q?T5vneVTyma6273/tySCpxE64B6ljjYW2OqsEEpYpqi4KpX28NrDfCdWLs+lt?=
 =?us-ascii?Q?W1x9VVvStOiTN89gqivrU1C4Zi26zM/oTvRnfWKpBLl9oMz5zOZORYiLJZFS?=
 =?us-ascii?Q?5Ig0RUgzEhJpxWUIddbQ5c8kvVeCr3k1UsWBT6Cr7yQkqVEvfwucHjaG/zZ/?=
 =?us-ascii?Q?YYdJe6kS7RqwE4qKykGIk2sEpAlIK86wwMbstqT5lVqgJK6/QEE2hxYeG1iN?=
 =?us-ascii?Q?awF8BKAzktXRBPmxiRCRzGMCZUGkIlRc/Fv+j1k9nRwP+rKA38U7rhYm1/uP?=
 =?us-ascii?Q?odZS+KQDVh8gbXl0fZ3EHIym9ekAy7UfWrDlWNnfaBXKrHGGwFCj88EXU7Hz?=
 =?us-ascii?Q?lBDWlkXh9OTMONP6BcZwcl+Dgtu5WgxdGQ9Vm0JOXqvfVCLZX1XZnvXBwxpt?=
 =?us-ascii?Q?bXukfHxEIs5xet4yhnNi5lRsTUR+r1GG9BlRRryrHFt1H0Tza4E+LgOMJeTi?=
 =?us-ascii?Q?q0g7wRgYBD8zhxCseWfTdJKBrrLURjdfxJfHx9CCzvQit+fmIg024ptThX1A?=
 =?us-ascii?Q?Glg1/U7Zi71v1W5RILmfIFJPKGA/RIgW+igIFFYlhjsiO2TDTXHlZHFt82Tn?=
 =?us-ascii?Q?nq4KXnAHsKcL4QyuwRhn8/QZX9TNA02C03rSZ5KOaRG4ClpayHk0Tt3czo7L?=
 =?us-ascii?Q?WK6wEK8YNb0M05N965VjiJbCgn6oKCPtYM7vKWq5mFQoqwcQ//cIgE+7ixew?=
 =?us-ascii?Q?GQ4k0UeEww3H1b0Por78+bX/gLXyuCvB4xI5mzUc4Bi5RqXkhmD3QTV6LBNw?=
 =?us-ascii?Q?49E9kjmA7IUf5QE+vC8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:15:41.6934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc7ba78-3360-4873-197f-08de08422b1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
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

Add a query for sdma queues.  Userspace can use this to
query the size of the CSA buffers for sdma user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 26 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f368bda40be41..51af7b893f482 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -409,6 +409,24 @@ static int amdgpu_userq_metadata_info_compute(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int amdgpu_userq_metadata_info_sdma(struct amdgpu_device *adev,
+					   struct drm_amdgpu_info *info,
+					   struct drm_amdgpu_info_uq_metadata_sdma *meta)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (adev->sdma.get_csa_info) {
+		struct amdgpu_sdma_csa_info csa = {};
+
+		adev->sdma.get_csa_info(adev, &csa);
+		meta->csa_size = csa.size;
+		meta->csa_alignment = csa.alignment;
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			     struct drm_amdgpu_info *info,
 			     struct drm_amdgpu_info_hw_ip *result)
@@ -1385,6 +1403,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (ret)
 				return ret;
 
+			ret = copy_to_user(out, &meta_info,
+						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
+			return 0;
+		case AMDGPU_HW_IP_DMA:
+			ret = amdgpu_userq_metadata_info_sdma(adev, info, &meta_info.sdma);
+			if (ret)
+				return ret;
+
 			ret = copy_to_user(out, &meta_info,
 						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
 			return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 881e8cc986e2b..021ed8a49600e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1645,10 +1645,18 @@ struct drm_amdgpu_info_uq_metadata_compute {
 	__u32 eop_alignment;
 };
 
+struct drm_amdgpu_info_uq_metadata_sdma {
+	/* context save area size for sdma6 */
+	__u32 csa_size;
+	/* context save area base virtual alignment for sdma6 */
+	__u32 csa_alignment;
+};
+
 struct drm_amdgpu_info_uq_metadata {
 	union {
 		struct drm_amdgpu_info_uq_metadata_gfx gfx;
 		struct drm_amdgpu_info_uq_metadata_compute compute;
+		struct drm_amdgpu_info_uq_metadata_sdma sdma;
 	};
 };
 
-- 
2.51.0

