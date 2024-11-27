Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D24D6D231
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2024 19:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A310C10E300;
	Wed, 27 Nov 2024 19:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1skYylDI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B1F10EBD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2024 19:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRTn7elLLgHTww5L6EMtEP3qb6s9J99MDQ+D190HvBSvrE2a3xwJqZmg8ZIPx/cXeavD8v4349Q/LznYoY3Yiq+O0QewH7oHBI5DnSh4XaU473jHXbRa3cCbb/3egM6jZarROImPBR/XBdiCFBM8MQGdbKZW4Gq7GyQvyD2Oi8vgVsFFMNbHS6AQSrpXGWhTwtAyNkty4l1y8PKyvYgHqn/tFBdwIEXvc8Wwm9JqA9Qewc8Jnmi5cCioszAbWhMa5RJ0QAjMD8E0eQ6YBpBwhv8OU8TKEVrN2rSPzVqnjDrzPsaD550pvBmkfMP3ThLGcRI6n0qQFiR6amOfg0tyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdQ2/j2lgfJhBmd4kjXYGopmtKG5HRiRskzPkNu/dkw=;
 b=mst1yBJGdCR0BNMdYKk1J5z/qSLLRntZ71RHwJCOkgbbGrQBJiY0+E/XFoa9onSOhbsTpbHuRwEMFeVD3Ouy+gA1eFV3NgPwP2v3QjS5NlooRBsieNn1PETrE7cK1Rslh1jvH1ZQYZxbGl3nJHKy5m3T712Ntze4M2fsFCIvTz+DQuF9tmSsLVZhQLA38rS3Cb117ZVqDy2pc0GACbEct7SWH3/KHmqIWrLqt5I7Mmipglu6g9W4JgNH1tgZ4SkRWVdriwGk4RxhlQFneRGdFDIeQLaIP9czoU4UsONzEJQWFUAtKCNWcEwrEElvmXgG8NnG1LvsXcitXmDxhzXj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdQ2/j2lgfJhBmd4kjXYGopmtKG5HRiRskzPkNu/dkw=;
 b=1skYylDIF8MTr8E21WFsXgXm2v6+hHwZGyyBMqgIoFMiy8ZtWRQQ0mw6Ks0IT43G2AqUPkwNUfu6K+JuLh9B16TUOVC+Wz+pm8tUNBKoQuW8N0HzkScC7q/MyvwpOl2+aEGwrRt0v8jE6tCVSPdvL8n5yJDEB/3LCWQrlM2hjwI=
Received: from MW4PR03CA0359.namprd03.prod.outlook.com (2603:10b6:303:dc::34)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 19:44:06 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::7c) by MW4PR03CA0359.outlook.office365.com
 (2603:10b6:303:dc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Wed,
 27 Nov 2024 19:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 19:44:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 13:44:02 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add Annotations to Process Isolation functions
Date: Thu, 28 Nov 2024 01:13:50 +0530
Message-ID: <20241127194350.2085774-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c86b606-2420-4d87-0ea6-08dd0f1bda8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGp5T2FFVlJWcmpucUZwejlISjN4MDNtQm51RStwWXo2RjhjSFRJMGpWOVNm?=
 =?utf-8?B?ZGNGNzBRRjhBM2hjcnUveGtUZTVIQzBpOVI2U21vNnp1YTJQQnF0a1RyOGo1?=
 =?utf-8?B?UGFxWFBqVEZGYWlPKzhyUndrZmJZTnRaZy9oeUFpdkRpaDRZWXFKM3c3QzBa?=
 =?utf-8?B?eUpHVlZoMEY4c09kWjJZL2hsd3VQRUxtYTl5QmcwcXBUN1A5M1psa1dBMXBk?=
 =?utf-8?B?OHVWdkVSeXFZb2oyYmVRMWhjaC8xV09tUEpEYzM1OWQzVUQ4aDhwYytaY2Rx?=
 =?utf-8?B?SVFBTmd2akJORUg1Y2w4bXZPMUltaE95RXVqVis0cVAyVC80c0JOcHBJaXRw?=
 =?utf-8?B?aUtTdFNFR29jMGxDeDd4SEh0MUF0MDZyWHNiQ21TMXE1WHpIL0JQUlZGRW02?=
 =?utf-8?B?c1ZvdXhycEkwVUhBeFZxVVBzTEhkOWxVQW14NVN4ZTJxRUFLVnhaZm8zUktt?=
 =?utf-8?B?SlJDSDBWS2o1ZEswNkUvVkVkd09MVHpwY2VSNXFZYzcvZm9yWEhNb2QzNGRW?=
 =?utf-8?B?V2M3R0l3OGh5NTlscEhsYTlSWDFaSnlaQUo3aWM0dlRhTW9wU0pJVUZRU0Nk?=
 =?utf-8?B?b0JrclNvWm4veUNpZGdpTkJGQUFTdWhwdlRmK2lmSFdwaEI1NWM3TFVoMmg1?=
 =?utf-8?B?Zk15VzZuVEZwdnU4c0NEamtuYjVUQ3gvUll2ZUFKeU1oK3doRHhpcHpKSC9l?=
 =?utf-8?B?LzdCaWw1NDlHczhiNVhOZ0p2alh2L0N4dVpKckQwbkxNY3BmbFNOa0dzN0Jn?=
 =?utf-8?B?Uzdya2REcUZ1UDhTQ1hKMWpESXNYZWlKU0piNmhuR2hzdzhmeUgyRWt0L01Z?=
 =?utf-8?B?bS9HY1YvZjBIZFVwQVEvNzkwckFpVXRQNWJyYXhOcG94bkg3RVBvdmpGZzlE?=
 =?utf-8?B?bXdvM0ZrSHNuZUdhM3A4OTl3NzNTQU4rakNPRXFmeDRtZitJb3NaQ3loT3Rz?=
 =?utf-8?B?dllZRjcvT2phNDBsd01EeHNaOGJGaE4xSlpoeGxmS1l4dEY2SEhrQVdTaE5h?=
 =?utf-8?B?bFY0alRySkhKUkVzeVR2QUpNMklpQmNsbk5VYjgvSnpwSzA5eGFObjYvaVJI?=
 =?utf-8?B?MmVEV0tuSW56ZXVDUjhqeWt1RllhVWJkUVI5MmtoMHlQR1V2bnptYkpXdVMz?=
 =?utf-8?B?MElNcU50b3lRWVFSaVFHdHE5Q1dCUndHRUhJemZCTUhhdHhUeXp5ak16Q2V3?=
 =?utf-8?B?a29sbkJRYmpQWjF5Tzd5Mjc2dnU3Z1RpWU9HUzRHTUViK1MzMlF0QjI5MnBC?=
 =?utf-8?B?V0FYR003VlZWeVFpQ1FrYTFQaFlqWERNSlVGMVE3TjhWdTI0L01OdVdabEdU?=
 =?utf-8?B?RHVsakhERkl3RGplN1pHeGJVN0FobTd1ZllabDBpS1pscGovNHYvWHBTVlZX?=
 =?utf-8?B?UEdkc050S3NXQjRWZ0VJcGxFQXA5anFNVVVJcFpKZFFYMDlSY201Um4yeHZk?=
 =?utf-8?B?VGZCek12UktZcXdBWXYyZW4yazdBU3o5MzhHYU9kZEdjakZSc003Q1VoUDBT?=
 =?utf-8?B?K1k1ODVUK2RlSDRxcnQ3bElUTWlyNTlZNnZ1b29wRU44ZG5wQWIrRlR4bXdN?=
 =?utf-8?B?WnhqT2hLQkpxdkxmaVFENVdrcnJsOEZ4NDVsL2lNK3U3NmlZdmdiMFVEd3NF?=
 =?utf-8?B?eVJiNjBOZ2JlcWVRZVJOenZxUGZHVUgzelJaNFY4a2JJaE5MNVNWUzVsZHRF?=
 =?utf-8?B?NkZWRDRwaDVCZE5LTzcvNFNEREVrMUpVeDBRajdLcFdZa2lEYkhoWWtNdTRo?=
 =?utf-8?B?L0dBckZkcjdSRys4RU5WYW14Tzh2Yll4RUR3ZFJGYW9GVWxtRjFyT01UQ3lM?=
 =?utf-8?B?WnZ2NW5JK0d3MkJFdC9nam5qWnBmdXRGZEdmamNHeDNGM3FkeE9Lb1QzNWNp?=
 =?utf-8?B?TURwaEJMa1AvUjRWTjFyWDZFVDNpQVR4Ujk4L0Q5N3daMlhpVE5QMU5xZXA4?=
 =?utf-8?Q?Ob8VNTBKGcr8ZwIUo+S9xOw5UGSFPNgO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 19:44:05.9930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c86b606-2420-4d87-0ea6-08dd0f1bda8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

This update adds explanations to key functions that manage how the
Kernel Fusion Driver (KFD) and Kernel Graphics Driver (KGD) share the
GPU.

amdgpu_gfx_enforce_isolation_wait_for_kfd: Controls the waiting period
for KFD to ensure it takes turns with KGD in using the GPU. It uses a
mutex to safely manage shared data, like timing and state, and tracks
when KFD starts and stops waiting.

amdgpu_gfx_enforce_isolation_ring_begin_use: Ensures KFD has enough time
to run before new tasks are submitted to the GPU ring. It uses a mutex
to synchronize access and may adjust the KFD scheduler.

amdgpu_gfx_enforce_isolation_ring_end_use: Handles cleanup and state
updates when finishing the use of a GPU ring. It may also adjust the KFD
scheduler, using a mutex to manage shared data access.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e54f42e3797e..ce9ecd1fe748 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1940,6 +1940,19 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 	mutex_unlock(&adev->enforce_isolation_mutex);
 }
 
+/**
+ * amdgpu_gfx_enforce_isolation_wait_for_kfd - Manage KFD wait period for process isolation
+ * @adev: amdgpu_device pointer
+ * @idx: Index of the GPU partition
+ *
+ * This function controls how the Kernel Fusion Driver (KFD) waits so that both
+ * the KFD and the Kernel Graphics Driver (KGD) use the GPU one after the other.
+ * It decides if the KFD should pause to let the KGD use the GPU.
+ * A mutex is used to ensure that shared information, like timing and state,
+ * is accessed safely by both drivers.
+ * The function also records when the KFD's wait period starts and ends,
+ * to ensure the time-sharing works correctly.
+ */
 static void
 amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
 					  u32 idx)
@@ -1985,6 +1998,15 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
 		msleep(GFX_SLICE_PERIOD_MS);
 }
 
+/**
+ * amdgpu_gfx_enforce_isolation_ring_begin_use - Begin use of a ring with enforced isolation
+ * @ring: Pointer to the amdgpu_ring structure
+ *
+ * This function is called when beginning the use of a GPU ring with enforced isolation.
+ * It ensures that the KFD has had sufficient time to run before allowing more work to
+ * be submitted to the ring. The function acquires a mutex to synchronize access and
+ * may control the KFD scheduler to maintain process isolation.
+ */
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -2012,6 +2034,15 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->enforce_isolation_mutex);
 }
 
+/**
+ * amdgpu_gfx_enforce_isolation_ring_end_use - End use of a ring with enforced isolation
+ * @ring: Pointer to the amdgpu_ring structure
+ *
+ * This function is called when ending the use of a GPU ring with enforced isolation.
+ * It ensures that any necessary cleanup or state updates are performed, and it may
+ * control the KFD scheduler to maintain process isolation. The function uses a mutex
+ * to synchronize access to shared data.
+ */
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-- 
2.34.1

