Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6F0C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CB910E8AE;
	Thu, 28 Aug 2025 09:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YOOeONZH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F22010E8A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URdFvE+XHiswA0ThI7WIKM23Avw/kQyrWiniRQxuRYbawZfNzFGsP84VS9qOWd6kOiqY12YYSFUDzhEgnRhfw/QFOtswMXpl/lCIQ+OXTxGJLCndrQI7/Qcw5Rf4UuZNRFW2RdOrbo+7+JxDzWvXi0sqfgiGAzA9LAYIkaAD5Nz7zAaUbELAURM5ZdN5WA1MiPmxZQHGRiPEhDbbcALlVORsm3fQ/U1ja4T7L90VYPaYY6ooX+i08q2LkcXcr5ubp0bvI92rROwU01CJTZzVRk6Qpb+1Zvv/Mqf4eN0hH48Kwzpn7crqPmZZKAZnIU6S+eHCwh+EnB2PWEFic02lSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KihEqS3qAlY9Bc1+rihompldm1hWvMJ5M3ZDDqQVhyQ=;
 b=TFscdVEcxaOtKWuP+ssML75u6CBm7lt8wQYsoUa5n/hn2vkQa4k4yERxn75e2a072fFpk3+01huR+h/+h1+nuB+5FjaVSxcQVD353UR+ksXhTD3Z7X1I1oCouhL5YjPJNmAocasAysHlTSgZN/O5z1RZCEvU6k5SO5octwPrIQbmTG7BRSHs5yi2NBsJ8sX7z5C8TdlQs3V6EZsPDod77wEd/Cbn2W4GtdGgfzfRLmfdqqNdZymudzhCsQ4JkCZrdLHZfoABD3YNd3PGIiqT2hswCoi9ZqEy+UI2s5QRLcX7ZyK16ddOOZx3XdK28mDMS1moClPqUW24AxTIRa3x2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KihEqS3qAlY9Bc1+rihompldm1hWvMJ5M3ZDDqQVhyQ=;
 b=YOOeONZHlX5AG2tBJ0LqRN5n+xc5rHXeeu3YxHT4FasKSRhTFX2WzrNoXq6WsyfYl9DOxYSByXyJuVJBtQt/CcvO+AX0cbX6nv7VjmSMPkqbXLWjJWh9tMed75UCoxrxKk32/DxygorJ8B/XA8ukDlU6DkRnxVM/gjtCbnHFYc0=
Received: from CH0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:610:e5::28)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Thu, 28 Aug 2025 09:15:35 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::6f) by CH0PR03CA0263.outlook.office365.com
 (2603:10b6:610:e5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Thu,
 28 Aug 2025 09:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:15:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Aug 2025 01:45:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 1/9] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Thu, 28 Aug 2025 12:15:22 +0530
Message-ID: <20250828064530.3948378-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: dd224d60-6338-4a42-cc06-08dde613723f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkhSNGF5MTEwTHV0bVgrVFpRV1lmT3Y3TWlwMWlXUlpaUlllYnZ3RHF1VERv?=
 =?utf-8?B?KytzdCtMS2tpRWt0eWp0RFNpTnBVcmlZKzlQcE12NDBZZnRrdFdHRDQzN3U0?=
 =?utf-8?B?U3FGRVgwa0xZSzltS2xGM1NiK01BMFoxNWtNVGZqb1A4M0VpejUvSEVZNDdY?=
 =?utf-8?B?Nng3cUVwUkFkRTlkWnlNZ2Y4bktqR0phUFJCZWRsYWw4NmM5Tm4xeWtZaExF?=
 =?utf-8?B?ZmJiQjZTOWtUN2xFbE1FNUYzVWo5S2IwMk9DUDUzaHptN3RETm9RVlZiYWcx?=
 =?utf-8?B?MDV1emIxY3VWMzEwcllXSXBjcEx6Q3UwS2dPeHVyM1dUWWF6YUZCWS90NDIw?=
 =?utf-8?B?WEU1MTg4aWp5eHhjM2dsbGs4SzhkVjlPMHkrUFE3dTRXbStzc1BrUUtnMEtJ?=
 =?utf-8?B?ajFXN1hTTTBqVmhzS1B0L0V5cHVERHdIeTdPbUtuYUlXbXA1YUF2ZnFTb0dL?=
 =?utf-8?B?MUV0R0d4TzVZM3FOUWUvc2k2TGcvQ3M0eWJmNm5GZlFOaGxIc1RycDZGelF5?=
 =?utf-8?B?NkpVYkQwdSt6dks0bDdlWVJSQXFReERaMFdzR0E5WWF4eHVZSllmZ1BSQ0xs?=
 =?utf-8?B?S041SXNFa1Y0RDRoMElRYWJmRjd4eXdxVkg0ZlVGNEZPaXV3OWtRWFNEUzU5?=
 =?utf-8?B?SXBrWFFMU3k0RWJGWWk1T3c4c3FlMGJuQUEvOHViSUQwWk95ZlFTTFpwNDRZ?=
 =?utf-8?B?Y2Zkc0Z3WG05bWlUbVh2c0dTT3p0SnRXcXA1M2J3YktuNklCQWdDVFV6dDNw?=
 =?utf-8?B?MFY2VkptZjJuL2JSRDdoeXRUazFZOERWeXJYbWQrUHR0cGR4WXFhemNaT3dH?=
 =?utf-8?B?VTFzL1hlOXR2WmFaaWg5UUo5MmwrMTVkQ3AxYjFLTHNVM3ZHK2ZSYTFUMS96?=
 =?utf-8?B?MzgzMkFrclZCQkZXQmxZSEdRbmdLd1YwUmZHdTdaU3FHTGdQdy9iNVluaGpJ?=
 =?utf-8?B?Ym5GWDVwVFF3dm41KytDM3pCbXh2ZE9aZVNHWTY0bmsyNm9WcDlPbVpQUnRH?=
 =?utf-8?B?cTZuKzl5WG5XUExOZnlPRVFkRFZlbWorMFFUcHd0OGxvalRrMVVLM2xsR1JR?=
 =?utf-8?B?eU5Ndm50WE9LYzBuOU1zNVIwT3Q2VUVnUHQyaG9xTjhNSFZIUzZSb0lodURs?=
 =?utf-8?B?amc2ZTROTnBPU3FSRUxUTXVjNmM0bW5IYVl1UG41Y2tJcjRoVk1wSkZPMXlW?=
 =?utf-8?B?cGtFRjNtSkJNVEgrVUNzVWdKQnp0SXhMZUxVRFk0N2hLOVR5SnhCRnMrNC9V?=
 =?utf-8?B?VEs1SVRWTFkvNldiNHc3N00yRytSNDR5ZVEzbVdLVXMyV3hVY0xCSXlLMHBt?=
 =?utf-8?B?ZzR6MDBCZFc3WEZBNlZnbUlLMGFLTnA5L0F1U1k2cC9zVG5ISXBEcCtoc0VF?=
 =?utf-8?B?K3hVUEtTcnh5azE2cjNFcnA3WjRGK2RwS1JnU0lYNnc4TEgxUFFjSnhySUFB?=
 =?utf-8?B?NWJFRWxDTU5RUjNEYVZtR2lrSkJtY1Q5U2xHQ3I3MS8reGFHS0hCUklvcWVD?=
 =?utf-8?B?MVBRNWdnTGpDWGdOaFYxOEdPRERLM051U3pVNXB3WlVzVElwN0ZDUFBlOUJx?=
 =?utf-8?B?VTZSQ1pKRThabnJqR0JOMVdVek1GeFlGUmNTVUxZanlQY3BnQUtyd3J1cjh5?=
 =?utf-8?B?WWsvdWdaUkltR2lYTUc2L3NsY3ZzUjlNZ3E1TnQ1MGszcUxiTnFvTnlnZEpC?=
 =?utf-8?B?SWlPSWRXMUh4V3krby9GVC83U2pYd2hyZWpFcEJFNU1uS2lkUjQ0ZXlHVGg2?=
 =?utf-8?B?M2dVM1VsclczZHZ6UXlSUGNESSs0c2lIWThzVFlWMmVGeDM2SE5yQ1VGczY0?=
 =?utf-8?B?YVduLzk5cGlIM25udWdRV2F2bUdtakZuZm5NSW5IMmJDeWR1TER5M1hQSEhM?=
 =?utf-8?B?S3UzSEswSExWUzhJTHZwcmI3Z2ZQdlQ0dEljZ2RqUXJqV2lBZHpUdHY0eXFN?=
 =?utf-8?B?K0g4Vmp1OUI3SVIyRUhSbTdWcGM0VTRLUEZUWi9rQ09DZHVhVnlMUzNJMGI1?=
 =?utf-8?B?NUV2cjJGUUdaOEhWVWg0RWF3bFNCZmwyQTZzZnkyUlNIZmd6QjVkNC9KWTlp?=
 =?utf-8?Q?YpcnhO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:35.1467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd224d60-6338-4a42-cc06-08dde613723f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

