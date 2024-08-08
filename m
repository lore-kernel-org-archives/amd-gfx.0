Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA9EC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 17:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F3B10E7B6;
	Thu,  8 Aug 2024 17:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jhp5HH6B";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EDDA10E7B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 17:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWc4m0wafRoGwjJjNOVSuErnQ586C4GcSEa0HrneHd68W3QpDvsq6uzGqt9Rt5nH4wQp0KI69OUmyqFNgAVR2L9LMz86qf4ipZVgsUmfI36AyS/ftJbpw6+MkyeAE3ZUdl0Cb4D5R9Yq4jfDdH4POi3i8hKMlN2YDL4Tgf5ZVxgSL5BAIPwGsrQOEjx1+QujQE8CKeqWV1OIuoL8Y9R3v+mSz62crYqVnR+kTGtxqEVjGsX3uiAB/edlmp4paVHaddHxXKo5olBbSE1bC4s/usXN21arnOz+dWFbESChtT/z48ePGOqIMxGKPh3ARjkh4NKApOSlYyS7dwJJQPWM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hk4cgXtcB/diHF2Hw6cgGh7OsMkOj7WGxnfVEZgXVQ=;
 b=GbGhYIZIvLLxbMESu2sM7bN8O41aXnVoDk8aNZkwJVDcpyF6yAJW2pDcFYlyrd/ng5tlWajJrPm6AGV9oSo7gABC57zQGq3hLyiX1D1LMCxZlbjJpp4r+z/3TX/0d3nyhxsdAx9HPxt/k3HVF5iF4FX8GfHrzLUgh9s++SE20sdGIS4ghIgtjATE0F0bIUCs1vrzcwr2fU6W8X0I3raXU8Su9OhB+4HM4Z9SUYVXp/sYoj7WMg/5F9eKxtJ0yjWzM2+OHdDhwgtAdts9C11mVsL/4DuZWB/6vsvkg+rJIkdffnP5PzYtQZc3PfMuqAscM/2uWmIWgds4yKUnk0+dkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hk4cgXtcB/diHF2Hw6cgGh7OsMkOj7WGxnfVEZgXVQ=;
 b=Jhp5HH6B/qLgk+q4Palp/oZHPCf1pioh2v9SnSX0RJqeD1DeU94Z9bD7/Aj5psvyphqcHxAikfLrpam8CHWb0cLlUWApIvxStg2GW7UiIzggQZJp1Dtj4RyaYgAi7MpUIDIGpXwbVNpGNfoVAkR01eXjgZRJldHfUH6tmiSR3WQ=
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 17:48:22 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::b8) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Thu, 8 Aug 2024 17:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 17:48:20 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 12:48:19 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <zhigang.luo@amd.com>,
 <christian.koenig@amd.com>, <lijo.lazar@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Block MMR_READ IOCTL in reset
Date: Thu, 8 Aug 2024 13:48:08 -0400
Message-ID: <20240808174808.854282-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7a5554-7c76-4ce1-6e08-08dcb7d24b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?12NzeI8uXck1thqjjWgdvrM+NX7HFOwhPtKSyi2I0RBeyxZWCvR+QhsZqfeP?=
 =?us-ascii?Q?BlOZ3HRI0PPK6rroxcra5okRDHQYUqSETrO6ZhtCfKuAkHlgMnJrN4fNmJzU?=
 =?us-ascii?Q?rgpcGRSxvE03g1/ymTQfBlJi03PP6wYLGIuU2l1RscOOMxJlcbR9n3wzTuF5?=
 =?us-ascii?Q?nBs1DRvZ+WG82PJD2Mz1OZhn3LbIOsFBVXY34VQnWNelEQKJio/DW8J9hVGM?=
 =?us-ascii?Q?iyomuyHSvLEHIe10YKZKvyTS6415AnlOLdLkB8WwkDx9ONkqWc3B4Y7oNyyg?=
 =?us-ascii?Q?VAm9HqIOptL4GKM5828XexApsoWCdzAqH+O+IrCsCsthc75wjj9VwC1lo9Mz?=
 =?us-ascii?Q?aHoapqJvayWdzADKX2GUDMfprsOWnI0uMoyGgxFk807hrsUQugtrlGMGFq6O?=
 =?us-ascii?Q?hE4Anh2vRs1s4G0V8b4JYlG/tW2/+G/rhiYh1Qylwd5DNVq3jzy2xpKg372w?=
 =?us-ascii?Q?tzbNiySsbYdrCYfhZC4Ndj4TvU4IeZ5QwdVMl7kzHYpQQdKtmtoNEzIB+99K?=
 =?us-ascii?Q?P34BE5rLynbPs8ob5nHNRlzRsrYNCpMA6ICl3v9fYIUNsm7vS29RQJmhOX/i?=
 =?us-ascii?Q?jsvbxUy+QLnfVCntpl/AYtqlIiWN7WA2P3b4kxMaRrgwaYh7AicHNRCfgg5b?=
 =?us-ascii?Q?OrC9BlZ6v2N+y9VtULL9ng5/nN9Hl2/88va4kQJ6DYfNuOED6RFBlt8hRt5F?=
 =?us-ascii?Q?UcgrCwu5AQ71ITzDu4iqx0j8guPUkbqwMyNtoPQUGhap5jsaR1MorirR3x0F?=
 =?us-ascii?Q?WuD8l89bE/Han0AM1GgPCEUFp+ZgEq4132eFAS/ImPtUZ3AU0x3EX4U8G2fO?=
 =?us-ascii?Q?4QAXQp/58BwmO0zbTqOeMBguTA6UPQ4f31XXOihyzdrRHbLAuoEzqWedLeMA?=
 =?us-ascii?Q?fZ7Y6S5uecdWlx+V1GCv+ihyGbMXU+fJ2HF1Y6W1pkcJIvVwBep+F4z5HkZs?=
 =?us-ascii?Q?VLrlcy7+NYFvoX9QkiSHxx7Hb8M+EjAc7rWuNiSWnFPKKNFDQwGWyAHsGWSW?=
 =?us-ascii?Q?HJ6QsojNkVdK3Jp276Up4tchPPa9HeGeqqUEMq0WIu2GsgC/43IFrk5UFg0J?=
 =?us-ascii?Q?47GHpham9iirUnh/0PDeqA/lD7VkGzxmRK8lod2TRdjf7qllqkPWzaZTAEkA?=
 =?us-ascii?Q?dlvd4qA0pjRc8ELb95QwJgfv0U58QTJQYIA3RzsqNLDXonAYXVXipzVyRiib?=
 =?us-ascii?Q?Nk55b5smyd0rJC9grv9P0rF1yAOSIrq1ZUbHw3BNry8KeyV6lm4D1h0EBNjy?=
 =?us-ascii?Q?y8v25jDm5RE+bM1ql1Nk5QqexfXndVakQgTQQDPvNh2PtfmEQov6Eul7/QqT?=
 =?us-ascii?Q?vlm4Y+SAK0BbIGUd6wra8FJsCJsPseo0/Nt/KciAlTj/3n5pEe3goFUv4aCq?=
 =?us-ascii?Q?KGON04j/GGW0dYBJAkCUujWTIXyE9qZP0qyPYF0nxUhg0bGdEPFbDFmolx1L?=
 =?us-ascii?Q?lzdeuH0M2H5JATXIzpSyVwJ6dq7KeUpJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 17:48:20.9531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7a5554-7c76-4ce1-6e08-08dcb7d24b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396
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

Register access from userspace should be blocked until
reset is complete.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++-------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 260cd0ad286d..038b400be437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -778,6 +778,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				    ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_READ_MMR_REG: {
+		int ret = 0;
 		unsigned int n, alloc_size;
 		uint32_t *regs;
 		unsigned int se_num = (info->read_mmr_reg.instance >>
@@ -787,24 +788,39 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				   AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SH_INDEX_MASK;
 
+		if (!down_read_trylock(&adev->reset_domain->sem))
+			return -ENOENT;
+
 		/* set full masks if the userspace set all bits
 		 * in the bitfields
 		 */
-		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
+		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK) {
 			se_num = 0xffffffff;
-		else if (se_num >= AMDGPU_GFX_MAX_SE)
-			return -EINVAL;
-		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK)
+		}
+		else if (se_num >= AMDGPU_GFX_MAX_SE) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK) {
 			sh_num = 0xffffffff;
-		else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE)
-			return -EINVAL;
+		}
+		else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-		if (info->read_mmr_reg.count > 128)
-			return -EINVAL;
+		if (info->read_mmr_reg.count > 128) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
-		if (!regs)
-			return -ENOMEM;
+		if (!regs) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
 		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
 
 		amdgpu_gfx_off_ctrl(adev, false);
@@ -816,13 +832,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					      info->read_mmr_reg.dword_offset + i);
 				kfree(regs);
 				amdgpu_gfx_off_ctrl(adev, true);
-				return -EFAULT;
+				ret = -EFAULT;
+				goto out;
 			}
 		}
 		amdgpu_gfx_off_ctrl(adev, true);
 		n = copy_to_user(out, regs, min(size, alloc_size));
 		kfree(regs);
-		return n ? -EFAULT : 0;
+		ret = (n ? -EFAULT : 0);
+out:
+		up_read(&adev->reset_domain->sem);
+		return ret;
 	}
 	case AMDGPU_INFO_DEV_INFO: {
 		struct drm_amdgpu_info_device *dev_info;
-- 
2.34.1

