Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129EFC021AF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 06:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D4710E475;
	Wed, 19 Feb 2025 06:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uPbtkpu2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86BB10E46D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 06:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNNPD+u25o1BTbmfmBXemj6niodV9unoNPIt09ik+UasEqq8m6nbK8khCrwqGhpF4meFPqNyRx4MUCD+uNsXT1rgekm8rz/nqbdyPAFUkvtcGIRmz2wkGSd4SC/f+NwQTN9bzuP+XfFKVAD0yBP2IL7p5tbJBS4nq+rl4f23N1xilzpDCfkloQRtiAexTWsFULEWX1Eq/f0iP5iVRKvTXDlVmMIzv7pFGkP3vuob2P3MsFFJy4Z+at7aXnpQkN5mIcMqKgiGaMkpo/+nfHBGcW7DlBgQaHV9N9SwHibDZbUdtl8E68TJrGvtOFX9SWDCBeppsTj/xnbBXhp5xDuy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDtJfvzaGa3ndploLvSZMZDNibcbsDpyzXCX7Tdo8ZM=;
 b=gwFQ8rYpJLVnQCc/Hpi03DB/quj4MPeRMjQz7MO58zoalMFoktDxJBdPiN7nDwaiR99T+D5rBxKyci3jo5eSYNAQhxHnyyLZwUYmaFYeFIM4HmLyfD95Zh2pXTzIQUt7x1nmvG1KwcbNIsCpI9aqKbN6yeaP2I3MKfrq/+wS4Cj3C7F/7FOHq/Bo/M3JxLUA4/2I0+SXKgTWZrghCSbe7IT9QVdFtAj6ug6GJzIjyGXGuJOX9c3eWjeR0DdgTlEcAwQ4vFWMGdyskrEvjgaZFiRT2AWwFZ0mhYMFTRZJi6V+thZQKjBPSNE+4zWy7wcdk0BX1dJKAizz4zk11NcjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDtJfvzaGa3ndploLvSZMZDNibcbsDpyzXCX7Tdo8ZM=;
 b=uPbtkpu2AQTlHPtkdZPKopVweKwws/yZEcJEjqCbyb+AJwmpaF66xmVkyxdTUjkuPrMM0Wkt/uHL7BVbmTi/87K1LpyYEZFvjxPOk7jpI4zvEckeOUuQ/n/JPC5LEa1bYBC7PwFiOl3IburPEihGiWo1PwBZrKgvwiR8oURNpgk=
Received: from SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::15)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 06:20:51 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::c3) by SA9P223CA0010.outlook.office365.com
 (2603:10b6:806:26::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Wed,
 19 Feb 2025 06:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 06:20:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 00:20:49 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Feb 2025 00:20:48 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Optimize VM invalidation engine allocation
 and synchronize GPU TLB flush
Date: Wed, 19 Feb 2025 14:20:46 +0800
Message-ID: <20250219062046.3530422-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219062046.3530422-1-jesse.zhang@amd.com>
References: <20250219062046.3530422-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3645f9-1244-4b65-593d-08dd50ad8eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E4oABTTHo40FMYsAbq9tpqLqED6YEh9302GoZ+s0x1La7LkedvysqPoThNr4?=
 =?us-ascii?Q?GNoBMAcQnJ7jGKh/DWRDQ65Bd1ejPZH5SmxTVJ9hRfLJLKr6PAKDQR5/Nbhm?=
 =?us-ascii?Q?7RHW3gQ3W23S1+nvs2J89Q/c74wu9Ctxh88HPlCoSU3AiiSzoiQ1guMP9qab?=
 =?us-ascii?Q?4TCRG0t1/Br626szYXyN3S/27VhQYCmmtF6BdwGx2aVclVREwz6AdGaprKKI?=
 =?us-ascii?Q?U/wEEBi5cZkFdl0/zOa2bmIW/uBF3wMoxKetQ3jUpDBWeFiYU8Nw+Qr/3+IO?=
 =?us-ascii?Q?wR/vJ6Rt7Ro1+CHbo49vpLoKiaPXsQ4+qFKZjYGKDY8ACcd4Nv1bg9NiVWFD?=
 =?us-ascii?Q?K48nA4d4yqVfwRX0uSoXdrtOE/kEsJuDTDfDKITTUHd56QGNHfqrnXUrHRTf?=
 =?us-ascii?Q?EeWCN1gveSxcUEgTVbtsZX3Vo5578B/yMDPlqn57AZ4loLIqQV0TZvyIPoyV?=
 =?us-ascii?Q?+C4zmI/YzBEG02fLZCRZig0jhIkoJNmlnNG+0B0UirNVMptqeee/Qy6246Nr?=
 =?us-ascii?Q?C1JYPw7TOngeOZIRIr4OGV4kzz7iH3BvXDz7Ud91OHupR4Hxde2b7PgNITsX?=
 =?us-ascii?Q?h8qFLY0e9PfwiECt5Ae/AdpNhlDNB40FJGGFamRK8WtuPZI1naZsDXEEe+rx?=
 =?us-ascii?Q?Ka1f8bVErLqx47Yqb3ohMMyiZCHGTuSB+giEQfoBGzUYLAjkusFexyQaOLTE?=
 =?us-ascii?Q?qanR+gP8Uvoln/+HSDC0kQ4K1SjvQ8W+0cVDdsDYxT6TV1fL301048XDMDSm?=
 =?us-ascii?Q?uYkJf583iX8NgOJ9j3ir5x/ckmLdEOMZHJf7Lod+oXKztS3ekgHtrxPMozLa?=
 =?us-ascii?Q?YSWbWGW6uat6wLXscCg6f01ujdVeNX/7nol3rqVdkLbTbmug3gNk+ArPpfrN?=
 =?us-ascii?Q?EdGU0FfCnmfgYbYdO12lj7ek8wa8EqYEyErpNh8gt8YJS0TxFTi4JkWm7U7G?=
 =?us-ascii?Q?LByUSBB3I24etTELjnOo8rRU/Mlh2B84QAjSja/fETCfYpMSyjBuZHzXXNXQ?=
 =?us-ascii?Q?AFilN6AQnMFf9tStixVVgNasfK+kDBMucHAmde3lF6K+ZGBh8D0YGpQiimRy?=
 =?us-ascii?Q?MVy+Um932+++CtgirrMTzMjsAee8Mpfq1HzeVnzzMv0sBggSO9+mni0P+bPG?=
 =?us-ascii?Q?/aTMQUXuaRibajYjGLSDSeUrg+qNZ8hH8KCZEKcCcNPur/sHqJYJ7+XFQKKL?=
 =?us-ascii?Q?S3qvfJ21wrlrR2GaCUa0lAraQ0/x+xUkbZYWxarqIu3mYw1E+SsNAUocTXjP?=
 =?us-ascii?Q?f1cwAEo7mU36C1xnVY/mH5jK9lzwZWCVUl+0MFG1Gjj0dOddNPqpA3ty1Tnm?=
 =?us-ascii?Q?IyIzJaWQW1i1kWLUcqzp88mZyJx0jQLNOfHmkgKldm9xc4fhKk7o12NxN3TM?=
 =?us-ascii?Q?cpc4hu/K4FbPxMyQvzlDXEg1YK0+YA0NCSyY0peQBscp6Tf/ik9Lz204+Net?=
 =?us-ascii?Q?1X7eZEkeeH4EgCpZLUab6sW0hOXMNQK4W8R5iGMkIJnhRcAALkhGl4Pg6VVh?=
 =?us-ascii?Q?swSyqIzFJqYqlDU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:20:51.2984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3645f9-1244-4b65-593d-08dd50ad8eea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

- Modify the VM invalidation engine allocation logic to handle SDMA page rings.
  SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
  allocating a separate engine. This change ensures efficient resource management and
  avoids the issue of insufficient VM invalidation engines.

- Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
  Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
  during TLB flush operations. This improves the stability and reliability of the driver,
  especially in multi-threaded environments.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index cb914ce82eb5..013d31f2794b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -601,8 +601,17 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 			return -EINVAL;
 		}
 
+	if (ring->funcs->type == AMDGPU_RING_TYPE_SDMA &&
+	    adev->sdma.has_page_queue &&
+	    (strncmp(ring->name, "sdma", 4) == 0)) {
+		/* Do not allocate a separate VM invalidation engine for SDMA page rings.
+		 * Shared VM invalid engine with sdma gfx ring.
+		 */
+		ring->vm_inv_eng = inv_eng - 1;
+	} else {
 		ring->vm_inv_eng = inv_eng - 1;
 		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
+	}
 
 		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
 			 ring->name, ring->vm_inv_eng, ring->vm_hub);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2aa87fdf715f..2599da8677da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1000,6 +1000,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	 * to WA the Issue
 	 */
 
+	spin_lock(&adev->gmc.invalidate_lock);
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore)
 		/* a read return value of 1 means semaphore acuqire */
@@ -1030,6 +1031,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
 				      hub->eng_distance * eng, 0);
 
+	spin_unlock(&adev->gmc.invalidate_lock);
 	return pd_addr;
 }
 
-- 
2.25.1

