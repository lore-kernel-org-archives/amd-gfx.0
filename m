Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61B0C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 764B310E942;
	Thu, 28 Aug 2025 09:16:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b15JCZtI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A7F10E942
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PETq1F36tlvOqYVmriE5vcJBWawG/zwKn5fuIDjKBVAWeMQ+9nGd31mb1/IlwsS3hNRFxPKdSzp7pMs7/APhW51x5tgtokY8GN0qxYCx0yf7moYmv0wUMcBdsFTgJrzMjGutBPU/d3KrYFp6OwF5D7p3QNUJBIVRulcLTNsQ40equjNg4yD0gtmLYWjcSWY9mC8sDtlXxlbBBQMTgg3MkucOUiKHdDFdYovN6P2A4rKko3Tguc/yhnO+fb2TMkxTwL/S/4khDvzacHdOifNyCuLTCWVCrByQS/dbvfPUz/GHe85DDpKNnIoqFYz0p91TeofhBtcExw3N0jR8kBjaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KihEqS3qAlY9Bc1+rihompldm1hWvMJ5M3ZDDqQVhyQ=;
 b=l+VgKmnCs4se5Zs3krH/TLbg3onfPCrghhm0OfGVnH0NcHND/owzHgKXBydwrnTCBbqWM4yyVxhfnBjPQlXg5mVifEfQoXw0SOscEtkSh80F7Lq7sFbgNOP97nu/2HNAXPtXZKYEHMnjsmXXBMNkZTk0+hyZPV8RGoE9Ifzh+PnFakmd+lsxchPPtwAZqb+JvhpWGTroNoj2JAl8tUsguxNowcIppkyIDovj8RrLstLUd/CCwUPKvLHSzKtCU+S4GZWM+zVjbNmyvFqcubSmwYnL9R7qB1DLB+gcfqvBou9wwpKQaP+aebY0hKL4fVmJKJJh2ajgdFcX9tPrYIgWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KihEqS3qAlY9Bc1+rihompldm1hWvMJ5M3ZDDqQVhyQ=;
 b=b15JCZtITIKGLrp9PKJ5EN5qdMD/tavq5vIY49DpZ17ek7nPkarfyBUZA0FxX8CXfUELdXMdlilMpSE/eTFI8GD5CitxtuIrSw5WqXreWWRmn6AqN98gJWqXtJZyKNFOQc2iBQrtPbV/Do1lhSBHNnZGFgPxn6QO2V2Qx2QtUXU=
Received: from CH0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:610:e5::6)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:16:03 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::2) by CH0PR03CA0241.outlook.office365.com
 (2603:10b6:610:e5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:16:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:04:32 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:04:30 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 1/9] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Thu, 28 Aug 2025 12:34:12 +0530
Message-ID: <20250828070420.3948568-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828070420.3948568-1-srinivasan.shanmugam@amd.com>
References: <20250828070420.3948568-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 21678653-b498-49d8-c0e1-08dde613831d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1V4RWczN2tZQ01JeHBFdVozT0hrMDhvc2NjNTFRYWRVYWFnaXJPMWU0ZzRs?=
 =?utf-8?B?eEwxWngxVjk1c1FZZHdxZG1OcnQ3T2ZBaTRMVEVLSytNdWoxemg3OCsxNkxH?=
 =?utf-8?B?N0x5VERMZkxDTTFscUdWN1B3eVgvVlZFVzZVcnRSN0Ruc2NaYjlvTzJNKzlm?=
 =?utf-8?B?YmpUcmVYZkQ1R2xWbnZ4OXVVQVN3TGo5VjBqRFE0OE5aOUFVcHFzV0g4clN2?=
 =?utf-8?B?dmYwcjFKT29GT29qTGJlN2FuQ2NoNXd0bXl6R2lpSnRWcmlyOTBzRzRzeDlM?=
 =?utf-8?B?T3EzbjdkY3RPNTJzS2YveTlnMmQxZEJCY2lPSk5tY1BTUHl5Y0hJVy8zdE1O?=
 =?utf-8?B?NVJQaFRZZFdXWnNEMzJMeFcrUHpVa1hSSFVrdUlWQXArbWtEaEFUYjc3cVNt?=
 =?utf-8?B?c1BKQXB5K3pUK1hGcmNEMnVwOEwyT2o3bW5sTFVZMmErZFpjclpVdDZWbG9t?=
 =?utf-8?B?RFBsaHU0cXZ5bGxJRTZZZTNwbU45L3QrbXR3L0plK3g2OXRlZXlWZDRqSE1C?=
 =?utf-8?B?WnVqYWNMM29ETXNOd3ZhbXhPMDVwU0pJeld2eUMzVXVjd2RSL2NsOWRTTkti?=
 =?utf-8?B?WGxkZ2kxYjkrU0FySTR5MmZpQ3JFY3BoRjlMNHV3bVZGekhTZHprMElqelJ4?=
 =?utf-8?B?ZC82eEthelNlNlhyYjhvNmdXV0Rzc2RWQ1hWdm44L2dJQThPZ3hCYUNFS0E1?=
 =?utf-8?B?NTJDbG1CTmNpd0doZ3FKOHhSMWdyb2F3bkNoQVNsMU1CYjdyN3BNMkZJdzFV?=
 =?utf-8?B?emJNVlpMcjFRYnU5cnJhSGFIc3hRVHpDaHRrZyszQm5vNGhGckkzN1ZJYysx?=
 =?utf-8?B?QVVYV2dVbGFyMlJDbEYxOEgvaTVpZHI2UWkvQ3hkZE1keUdqYy9xYUVGZ25E?=
 =?utf-8?B?M0NVQk9xcGRjRlM4UENQVlhiSlpmdkUwKzJQTEJ1ai95b1J0b2w1eCtnemQ0?=
 =?utf-8?B?WlFHR3JPUlU5TnpDTVhNUXYwemJZVE9veWhWNTUzRmsrbm9NZU5FNzRuNmxI?=
 =?utf-8?B?RXFjcm13U3REMTA2d1lIdVhBVUlrK3p0bkFNWDFScGFmVU5ia1lBZHdwaHZO?=
 =?utf-8?B?cEx3RmJNN2lnc3Nrelg4dnlTRDRBZnp3VXpxRWthVERYY1d5ODZDQ0thSnlG?=
 =?utf-8?B?WnlNekNKb3lqblh1YjI2VWYyVmY1Y2FvTThGNDBrZS9LQitZdlRMcURzOE01?=
 =?utf-8?B?QytpcFJTWXREd2ozRnRZRGdnczIvNW1LU3phcmpIN2RYTysvVmJPTExVeDc2?=
 =?utf-8?B?Y1ZIbmtZSzN0YVNqelFBdHJESkJhL3lGOFZHYXRBbFBRazZmV1FaOVB6YkFh?=
 =?utf-8?B?Nmt3N2lwZUQ5VVFYa2NUOWVkL3YweTE4c2tIRFNZSmsyYTAzYzROWkhOU0c2?=
 =?utf-8?B?Zm9ZaDhkSlI4eUx2dmVURFgvcnNlRjRzNm9IUlhYNkU0b2lkbnV1d1VHMzI1?=
 =?utf-8?B?cmlKenhCMVRVNWJjZTlhMzRBS2ExV2hOa2twZ21paVd6SG80aFJ0eGx2Skhz?=
 =?utf-8?B?RWxqbGpzb2ZnbTM3bmNncmlLOVZqMTUvYlJERGtyWlkvaE80aHIwN3QzVzdX?=
 =?utf-8?B?YWs1Uk8xNU1yQTNNZXdNR0VaN3F2aUpvWVFKck9vSUZVU3pRLzI4cnE1VERl?=
 =?utf-8?B?SVcybitwOFVZcjhTMWgzV3k0bW5VMStEUnh5TTZRU09rM2FQZnNhR3UvQjBn?=
 =?utf-8?B?cC9RU29jSHU3NTJaVFVvVDJuS0ViZXJFZ2JSeDRTdlB2NFlISVB0TVVmK21o?=
 =?utf-8?B?RDdNT2h4R2tCalRXL1NLZHBINzdxWnpsb1hxYjRPRjFzS1QyRXNoZGtDTTdI?=
 =?utf-8?B?MnNIOUlkZ3BwTStidHdJZEljcHZDUTJpYkdrWGhYdjRRSDZFaFFkSWp6TlF6?=
 =?utf-8?B?eTNMMVpHMmJwV0tpaGZ3c1UzWnBhSE0wdmhlQmgyL3lFNEdsQVYrY1pFQitQ?=
 =?utf-8?B?cTdSRVQ4dk1kOGMrbnVNNm41TUU2dXVZbXNJR25zMHpTdHRXeU0rL1piQlJJ?=
 =?utf-8?B?cDBNaWRqVVFLbFY0K2gwVkxzWGxJSDRGS092YXE0UDR0aVVORFRtZ3NXR1R6?=
 =?utf-8?Q?xgxFHN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:16:03.4457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21678653-b498-49d8-c0e1-08dde613831d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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

