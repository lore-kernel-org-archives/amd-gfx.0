Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F6ECA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A997710E34D;
	Tue,  2 Sep 2025 14:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="St8sH6ms";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4738910E34D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgGQCQ8XkoIvz6f7ABh5VSRch/M8w7Gk4DWyyq9yckaV5IOc2J6LC7f+/z7Awgh24PqwJy/hMtIZjKvbcTi/4W9fLggjjkOoQeHuAaTYMkSdyAHtNiNUyPISJ81wcLORrkJHYpSGJUGHFrLuiAmRwvgnsBSLz5WxYA9pP7nqVAfUhFNzWfaHWgOireuwMAP7GpoEBkadQf29IAILU1rUNSdU/xPsj9HMK5VnCF6iHo1QGX7NGAx39MlCDUENsTCmMSH05wH5Wat9bYRxsc7EwKEBF3/bDismMT23IXj6tZgHo4HdrhNwL6Dmh3bzV9QUEeLavo3veyB05Vh8LtzSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG92sdH+KCj1UzsRtMx4ZBxJmKtLhPYrd9IvKrVuNaQ=;
 b=mh51s1xvHKtpXaqOmwDAUwjTbWUKywADJZS58IIvh8AevrIw5nA2pg6r/dT+y87JTu8QFwACSKqZ0XbGYe+CRP63rsvfsH0aWLJlRLHZuONWtKHmEYW75zpvj1ZF0Sw0Zdk+wtxz2GgGY9ocnlcrjOl1a+31ERpiXzuw/NsWKfXbNY9/lj7/M5ujozE7igoZsYWDDTiEAUb4OOL7gYHNK5K8MG4WFJLeaYuwarhpRdta+cyXjy8cLNT9gotajbVxVvgbieiOkHjjZ2aNxBHxaWihzh5h9+3+47E0SO8jB9IqTzQIjTDTguyiAXPM90JmxCdvbFSklQ5yk+GzePzZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG92sdH+KCj1UzsRtMx4ZBxJmKtLhPYrd9IvKrVuNaQ=;
 b=St8sH6msdBhvCXXzne7YxsN/u//PhauEwIBiuYkrhXnp3PHpVPh6h5o131Vz0X2+9bQnNSowCsWjvT/1sFKO1I4i59JkoQxYMre+yNnsTUBdKn91iempvvDnVTHkfV8ip2gEhLno+IVki9hfimwt6S9aGtiSyWmxlsQa1dblvxg=
Received: from SJ0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:a03:331::22)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Tue, 2 Sep
 2025 14:54:51 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::88) by SJ0PR03CA0077.outlook.office365.com
 (2603:10b6:a03:331::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 14:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 14:54:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 09:54:48 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 2 Sep 2025 07:54:46 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 2/8] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Tue, 2 Sep 2025 20:22:07 +0530
Message-ID: <20250902145213.486199-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a7f366-e7e3-430f-c631-08ddea30ab7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW5pSzBEeHFtWG1pa2EyWWFpZFJzZ0EzcHJQSU9yMGo0Tm1Ta2V5TldzeHpL?=
 =?utf-8?B?NmI5V1hYY2NnWUZkcjJaMXRZd0RJKzFBd2xJYjVKbitOeE9PKy9QNUtLYngz?=
 =?utf-8?B?YWNIeWs4ZXAwMGlpKzZCMXI4U2RycEI0OWdHZks4OTlSQ210dy9nOWtPZy9z?=
 =?utf-8?B?NVRGTytiNjRxRDJ6bXRIQ29XN2ZZdStRRG1vNW5uWUR3bXBpMUIrU1BmVEIw?=
 =?utf-8?B?V2xxNDF4c2s1YURNTzVtZ0FoWktwUFgyZUh2a0I3SmVKNmdsZkJEVXVIaTlj?=
 =?utf-8?B?Qi9UNUJydHQzQkJSRGJGbU9TZStiYmVwVVNFYXN6cDF3WXphZ0dKSEYvZ1Yz?=
 =?utf-8?B?bHFMYnQvVm1kRlJLUW9WWUlYNUpHZUN5R3diemxCRFNsalZ1djkyUi9BTEQz?=
 =?utf-8?B?ZDNOVkp6WWV5VUw3dllNZ2JxOVFhTE5qSDNRcUdFdUtubWU4TmpMaVBMbDdQ?=
 =?utf-8?B?bEpsaWE5SmFxWjRBejJwOHF6cGI1WmhDUkpxdGtVNlVxM1VSNFltMTRSdWJC?=
 =?utf-8?B?NlNKM1pPZHdONXcrVXRMM043eC8xMU0xb1FmYzdYZVBSV3laNDJ6TlVIZzBT?=
 =?utf-8?B?UkhqTkxuaFozOTg1VWQ3TFRVeU9uSlV5aVhQMlI0eUdvZVU5dUt3MUp3dFp2?=
 =?utf-8?B?d2djL3drNHlDUUkxc1cyYXBDRmRFRGRGb2lvb3pNbTNxUXF0K0trYkNmRGRZ?=
 =?utf-8?B?NVhkNEh2VnV3QWRJYnk4aDQvS2Q0b3N0N1JkVXpxTVNLYnBCRE9zQkNMOE9j?=
 =?utf-8?B?dzRDSW9tOG9RSnlWWDZqb2FQTWxvYktYdjBDc1JWWkFqZzBVaEpyU05lUWRv?=
 =?utf-8?B?cEY2aG84VnFneDlFZXNMd1NmT0hLcklZWnNhT3JUU0RvOStFbkl2a1pnK3h4?=
 =?utf-8?B?NTlEK2E0eGE2S1YyUVMrUzhlNytMeWhNWkpFcThXVzVZWHhJeUlSZG53WlRG?=
 =?utf-8?B?TjRFdFdseVh2YkpoalVCbnV0Nlp6Z1BIRmRsNU9HNE1oQ204ZDBGUFJMSzUx?=
 =?utf-8?B?UmVCUFVERHhyYXk1RDJ0cGlkWktoQXlncUx4V1hkaXRHM0FjZ3lDYTRGOSt2?=
 =?utf-8?B?MW5KYms0NWl6MVpOQlFhdHFHalFzb0NqVUMwOXR0U0NwRStQM2xPZjUrOHJB?=
 =?utf-8?B?dGN5WFFXUHlFR2w4RXFTUmhuM09FMmZtdXFoWndjWWpaM1VLd25sT3h2MnBZ?=
 =?utf-8?B?T3laaHo4NDdlckpYM3QwMFBybWpQcVZJYkRMYmp2VnFkbDlVcjF6YS9uZVQ1?=
 =?utf-8?B?aEtFTDVDc3Vnbis0TXpTeHJCejA2KzNVMDJCRklnbUZFajQ3a2pUbVlrb2Zh?=
 =?utf-8?B?U2d4aEIvQ3hvSm45R3d1Sk9MK0syTk1nL1Ywd3ppeVE0eGpPVVpTUFYxUkVk?=
 =?utf-8?B?M09wYVFROGZsNEJ1QzkzMGRFb2xzOWdFMWZJNjdjTDU4dkJ3NWRnellzK25R?=
 =?utf-8?B?eEYvc0trZUVnZXMxQ0ovYzhicHdrc3dXNk4wakdmSXNFd3NZeUpQY1lOaUtS?=
 =?utf-8?B?K082MDJkeUV5SldNR2g3UHFkNmg2OWlLVWc1K3h2ckdsandyUHh2QmsvblBJ?=
 =?utf-8?B?UnVRemxKMC9MRktwRGw2Tk4wMUtOa2FJZjhva0dFQzFTSlZwRUJpM1BIVWtN?=
 =?utf-8?B?SW1TQ3l2WkorSHRoSXd2NUk2OFgyNWlGYXZzVGh4VFdQTHp0OHpqczU1UjRZ?=
 =?utf-8?B?RXJ0ejFMQjlWUm9pb2dhYlRQREl2RTNzR2NLZHJ2UFREZEhTaUxEZzVyZVIr?=
 =?utf-8?B?aXpNQkt1dDBncXZZOU0wVXRackJ2RW1SS3k3bXFPZytYRkwvNWxVem96Z094?=
 =?utf-8?B?dTZ6OTlrSGZzSGFTZG9vNm9qTnVWUzdUTEtlR0dPSVk5bmZvMTFDTk00ZFlM?=
 =?utf-8?B?WStSVWpxSDFNMS9CcEVielUrOVgwSHFRWVo0cUhSNDJUd2lPSnpabWg4L0lP?=
 =?utf-8?B?NGxQNlFJdDE5QWdBYitQZkNyVEN1Si85SVQwODlVWkZzZmxqcHNVOURkN2R0?=
 =?utf-8?B?cTdvcEU1ZmhXeWN5dDVyUWRIaFFWNk1NVThMbnRnZ1FabUx0TmdTMGx4WkVq?=
 =?utf-8?Q?j1C2Zj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:54:51.1692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a7f366-e7e3-430f-c631-08ddea30ab7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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

Add a new GEM domain bit AMDGPU_GEM_DOMAIN_MMIO_REMAP to allow
userspace to request the MMIO remap (HDP flush) page via GEM_CREATE.

- include/uapi/drm/amdgpu_drm.h:
  * define AMDGPU_GEM_DOMAIN_MMIO_REMAP
  * include the bit in AMDGPU_GEM_DOMAIN_MASK

v2: Add early reject in amdgpu_gem_create_ioctl() (Alex).

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
 include/uapi/drm/amdgpu_drm.h           | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3f65977eeee..d3c369742124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -465,6 +465,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
+		return -EINVAL;
+
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..fc44e301adbb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -103,6 +103,8 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
  * signalling user mode queues.
+ *
+ * %AMDGPU_GEM_DOMAIN_MMIO_REMAP	MMIO remap page (special mapping for HDP flushing).
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -111,13 +113,15 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
 #define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
+#define AMDGPU_GEM_DOMAIN_MMIO_REMAP	0x80
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
-					 AMDGPU_GEM_DOMAIN_OA | \
-					 AMDGPU_GEM_DOMAIN_DOORBELL)
+					 AMDGPU_GEM_DOMAIN_OA |	\
+					 AMDGPU_GEM_DOMAIN_DOORBELL | \
+					 AMDGPU_GEM_DOMAIN_MMIO_REMAP)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.34.1

