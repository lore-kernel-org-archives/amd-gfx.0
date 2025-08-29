Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7881DCA0FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 13:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259C110EBC5;
	Fri, 29 Aug 2025 13:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kht8K+5U";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9301610EBC5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 13:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B05RMSxHJAmF4Cv4ODNnVyholzid66BLBFhs/4H796Islu4wkCGkl/8mvwtpkwF6wNU4dV8pLMYYn/MnXmpDHnnWgsKfnaWFHyL+eT8lA6Qq+K8n5c0FyQEvXfPFejqHfA7GQV0+EhhaxtCVN25VRd0HTepLsnHV5IRpCHbho4uDFLrTVzkDTBgzcpsoX+zOYGA0w0l8sX9g4WBQgRbdbkfNGY3HS1Slw9qoBNnNqAgu8KwyXgPb+4xwQJasfDvQ4ffd5gWIDNSODBioE/83nQMkT3BUnWNb/UVom+iyeITl/MnU9xcrys0BS8ed+Ob/yEJoYBzEcijK9r0shezVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG92sdH+KCj1UzsRtMx4ZBxJmKtLhPYrd9IvKrVuNaQ=;
 b=DIYT7Yct68RlrJXHM5O/HbYTlvcRFA870mrrkI+ZM6q6c7/InHvmpKceGhQVe5OJ1lvA6b0KTmOdsaEzDJ/PYOPO1WHsS5Fh1s4Zk4Vo00gCxCu3f4hIwvXZkKfj9UOX0IZ5LuAkw/sSrO3SmlJ6YAf+COE2O2qqo02lRHPURO5AIhRPIvaflYlGGZBpzqybhcEOo68qY34/mhPHm3cNgyOFycZDhQh+JjWh3Y0iQzqQy72azLvsPlBulHVOxkMl+LDW03G9o+Ryx/p3WWVQ7Xpc5BmjPZswsNqn5UwiF6AL6mBSoZnd6DXln8TdcAx8k06qB8h2bqcp3FQ5DPLKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG92sdH+KCj1UzsRtMx4ZBxJmKtLhPYrd9IvKrVuNaQ=;
 b=kht8K+5U0bNgRuTCeGpT/CF7zstZ/U4MjpnL+u16MYncm3Q4O5WINiFAShjfSqSPAnvEQVpT9WBrcxeBwrWKKhM5X/wxJyohUPPa6d4ahQz/uvwRcpboKuBdIDjeWsYW8BQJtz94aZi/7gsEWE2cvcNs/ubEbnljD4m2hgRHxzY=
Received: from BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15) by
 PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 13:57:58 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::67) by BYAPR01CA0002.outlook.office365.com
 (2603:10b6:a02:80::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 13:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 13:57:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 08:57:57 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 06:57:56 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 2/9] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Fri, 29 Aug 2025 19:25:16 +0530
Message-ID: <20250829135523.4032168-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 471f8a30-a9f4-4064-9cc2-08dde7040fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXJjNFM2RFVMTVV2akttUERCVWNuT2xQVkRWRjUvcVRDNnJCTlJKcmlTUlB4?=
 =?utf-8?B?YkUrWmQrdnlRTW1COEdzZHF1c0Q2dTNmMUFCSXJjYWJqVXltUFJjQUlBVUox?=
 =?utf-8?B?L0krS3hTMXNFUW5WYS9SenNzMkFBRVk0RGdXT0kwbXVCN1hDY3d4cW9jTFhq?=
 =?utf-8?B?ajdBWjVjZkY2NFhZVERya0R0bkxUaHVnbEIySlJYVWlVR1JGRityZU9CZ2RC?=
 =?utf-8?B?VGFQU3ZTUkZXcXN0c3ZZTVhYOW11eDNTcVJUTW5lbGo4dlVJaHVreVFBcUlQ?=
 =?utf-8?B?MW00aUQvS1o5TEFhaFhiZTRtWnYzU0E1cWdkSDJ4TTJvQTRHMWM1aHhyWDV0?=
 =?utf-8?B?aFZEZkpoUUJYWlh4MTYyNWZ5QklzTVpoQkFWdUpjc3g3OHVnTlNValNra1VO?=
 =?utf-8?B?WVlidlZRTTc4N3lwNmVNd3MyLy9yZHM3VU1maFpBRWhMaUZYK1ppNWh0ek1a?=
 =?utf-8?B?dXFLOTFhU1Z1eWJuV3Z4azg2d2JTRDBxeE5zYVFjUEt1VndUZGl2akdkOSt1?=
 =?utf-8?B?MGlhTGxMY1hVNzE0d1VHMTZ2Q1Z0S3ZYckNJMW5ZZnFBQ3hLRWViU3d2anBL?=
 =?utf-8?B?a1RiNmpNOG5vSThOSzd6U1FHMVdsQlQvUGZLeStQK04vUzlKWmlKY2UyQW0x?=
 =?utf-8?B?NklPa3hJSG9XRk1ienBQUTlTNHRSNkV0QjNCSERBZS9JaFlLbjNXYzZMQmNK?=
 =?utf-8?B?U2ZoRzk1NUJrUFExWExId2hzWXRCSUkzOXpwOHBIc3REaWVsb1NtNlR6UWM5?=
 =?utf-8?B?UGhMZUhFSGgyWXhCajcyQ0puS0kwc3VvZzI3WmFZazdIdm5Eaks5TnJ3M21x?=
 =?utf-8?B?NVhDbUk5VjhKZ3lvMWswRzZ2VnhRbk1NbUlTSGVDeWhEOEE2US9jd3Joa09H?=
 =?utf-8?B?bU1Wcm9RR1NncWhydi8yeWtrQ0k3OTI5eXZ5ODVGUjl5YkpQVkxHTE5uQ3FO?=
 =?utf-8?B?SWhmKy9sL2hDaURvekd6bW9zc3N2cmlkZkR6RmJEVkV1aGIvZFpkeWpOWTRG?=
 =?utf-8?B?Y3hUM29vOElwZlpDQWdBSjNkSzFyODREWUthUkVmNy9xLzg0S2xIYjE1WXp1?=
 =?utf-8?B?a1V6RGh2M2dYUUhpUHBkUXh0SS8zMU1NRXdOM1ZtZCtyUXhieHp1cVB4dkZs?=
 =?utf-8?B?amsrQVZKWERVajROQWpibTllWEpEaTZkYm5CZkRQU3o4bU5sR2d3SEdoNDZk?=
 =?utf-8?B?SjE3azFqa2UzM3FnWGVDeFZSOHhIRXBQY0VJbkFXeExnc1V3NGhkclFOTExV?=
 =?utf-8?B?dTNUc3NDVFpRazd4cG1iZS9nQ1MxNHNtUGdJVDJ5emhDWHkrWldrM1NXYzU0?=
 =?utf-8?B?STRRU2c1SytMNEpuU0h0V0hwSDBZdkpkbDNoZ2Vha0ZNMkVrRjlXVmZOaWtQ?=
 =?utf-8?B?WjNrZnArMGY4THZMWFRkcDZTalZkbVFrbGpRZmNsR2JxZWU2aXJHQjlJTkpj?=
 =?utf-8?B?Sm1ZRFZHUjI2RVR5alpuYXdldWZxZDdhNndVeGhqN0tKT004NG9MUGNPZE5n?=
 =?utf-8?B?MkVBc0ZpTGMvT0o2dFFFa0ZxOHdvRDRlaW1qa1M2N2I3ajBvNTc5UDExMlM4?=
 =?utf-8?B?VWovTU5FSFpqa2VpL0RTRVhrUXo3YmFtcFp0TzNvcUN5TzF0MmtlN2V0SWF3?=
 =?utf-8?B?SUJFaG9HdGI2YjkzaG56ejZHbERISnVvSllEYWNqNllNdFhqWmVEUVM3TDNt?=
 =?utf-8?B?d3dTSnlhUHdmeFkrcmh6YzJnc2ZPeWQ1MEEzNUlGU0Z2R1NHYVpkUlVhemlx?=
 =?utf-8?B?TGcwNTBqMUpiL0s4Y051MHlNSGFDMGdWTmVNQXRLS1ZNS3NXNk5nbTJPM3RH?=
 =?utf-8?B?cE4zM2FTbW1ERDFVbWdYNXpRRHlOM1BETmJMSUFwVUtGUXFUZHZrM3pNOXd1?=
 =?utf-8?B?N1k0ZHpUdW13V0FPNlFBOXZzOTExUnVYSDRSQ29qcWIyWW1nalJ0V21PY3JV?=
 =?utf-8?B?QmkxUEwxNXFoaHNHMlpyUFZDdGR0d2NldCttTHBZdGZiemVFeVBtOVYxb1RY?=
 =?utf-8?B?ZlU2V1ZoUDdOcFcxdVJWcTZpWCsxb0h3ejFrd1ZicUJkT0JtMGpkcDJMV1R1?=
 =?utf-8?Q?LqY7xe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 13:57:58.4781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471f8a30-a9f4-4064-9cc2-08dde7040fb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980
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

