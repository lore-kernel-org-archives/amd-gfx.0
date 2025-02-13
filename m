Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15900C02198
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 03:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4EE610E9BC;
	Thu, 13 Feb 2025 03:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eE034/qr";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FE310E9BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 03:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaJ7e4YSrSplYl6yGdL84VuMF6TRmPqRg1YIrKWk0rpivneM3Avih2jnewBYdT/FSnq85KVtYBTkhOxehxRE1qpr/5R1URcBXVPhsHTg6KNf6IpM/cLa4RDJmRizy5MuWY2Wx8KPjDt+78q8dEccQv2Dzo+XhZYXaOehHsHCFSFAQ+oJo9R4TmX5fxunsu4d4By50eRMFd7/IIwIjngQB7cmRM/EyKZOylRQj4szb9YeV6e+qns4ay+KHcJAhwXrEqIBQK5G44zQy+AhQhjmwDTwaSlviuuXxYZLYyOyxMt0cmbLMB0eanNHXiAyPwubMqQ1mhOJWDZ2wR0JvPe24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDx008YJCVI/gsD9gZAK443x/GVV3EQJYbvJ4N/MyPw=;
 b=gnPqj0E0o6wYXPpalnnDnucUgYgxwy2ycU/WschNkBhb2n7JTKsQmZaRj451/Nj1fRoGnMogAK3XkVRoV7zg10MveKyjjoZ4vLDyOW02xVHZBDSE4kO4H3WxOCUlqveVqN69Kp4FamdY4X08QwO7fsp/qLODc4ZZe5hs9FKvMiKc1PJvyk5BU7aWNHZUkyklN2QsuugOh2hlZF5iBFoc9HkPLeQ3J7DlOSaSHmVjLG54EU6lbiS33r3GZ+oZ4CLW1Lx1kT04mYqDrpZWBPVjKa7eu/rhT8W8agk7XGQKIDsdp4EURZmGdNDvlnTr6L4jGbEq/arJENIarM/EzqYy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDx008YJCVI/gsD9gZAK443x/GVV3EQJYbvJ4N/MyPw=;
 b=eE034/qravXDDEmc/2wDLhGgEe+IhM+5GMIFzmwc6V3fQpejSk8G9Y0a3VPMgaDP8cBJXGTHc2zWhARIztiWDltcifNretNER4tg9ysG8iKfXGivJsuqf6eS0iUyyeIw5URfsD11zEWBscZrgGBeS538fSHQ7X00ZmXLqP+ygnI=
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 03:05:50 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::ea) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 03:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 03:05:31 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 21:00:23 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 3/6] drm/amdgpu: Add ring reset callback for JPEG3_0_0
Date: Thu, 13 Feb 2025 08:24:05 +0530
Message-ID: <20250213025408.2402828-4-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 844cb198-5c76-4bef-ab6b-08dd4bdb51cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmpUV1ZBNEdSMDlVYTVOV2Q0aktQYTdSeWFyenpQUU1qWCtyZDI1eGhoYkVL?=
 =?utf-8?B?d1JJME9TL2JQaUI3RWVRN3VyRkhnTGkzbGpiaVI4bXR1MUZPUGhUa0t2QStv?=
 =?utf-8?B?RVp4ZlBCVTVJeCticTZUcUlGcW1kdlJzRHNpc3FEcmZiQ3F5VTN2VXUxMExY?=
 =?utf-8?B?NmpxcnRvUzRqMGJ5SDBSZ3MzZEt2bkxoaWhtb2NDdVdGV2EyMTM3RG0rZTBU?=
 =?utf-8?B?QjBJOG1oTGpFeHI4SmRGR3JDWWlhY3FqR3EzSGlma0VtUklnZUhieGdhNHBX?=
 =?utf-8?B?RHpoMEpsNkxwcWlJUjJXbzg5VW9EK2k2SjBkYzVmbUxqeFZ1TDVqWHg3am83?=
 =?utf-8?B?OHRpaVlDcXlHRThyTTlhMDNiZmg5TnVka0x5MXp1YVR6YWlyZzloM3VlTEVx?=
 =?utf-8?B?Ris4Z2REUWtmZ0pINVlzWWw3dEFqZi9wV3ZWM0U5b25hOVJSN0JuRXZ4clBT?=
 =?utf-8?B?bjFCTjQ5L2FBYnQvY0c4dHlBczdrczN2NHFyOFNPRHphaTBybmIyY2JOZ1dS?=
 =?utf-8?B?R2hrMXd5dDlPdW1LWjRRNm43YjZ5YWJMa2sva0tLK1VxRWhPTzFweU9lWFh2?=
 =?utf-8?B?ODVXUXRyc29GVDYxVE9pVmNxRjhtMTZwTmpNWDh4YXd3ODY3T2F1TytUOGIv?=
 =?utf-8?B?S3hsejAra0FnUEVKMnB5OXE2WG1JWi9HNkRVWnh3NGh4WHdEUTZiNUpQbUhu?=
 =?utf-8?B?OUNFODJESVVSTFAvYjRERW5hMDlCVmt2T3VSc2pQUUl5VUtXajI3NVNyZnZy?=
 =?utf-8?B?UXFVUmJmN1h3dXM1UDBXSFl2MVlvdGhBc1hVUTJMeFh5K2VhVXNYNytrWXdo?=
 =?utf-8?B?QmFKSVVnb0xKTUNmWkMwWDVJUzhxOFlRb0tHdkw5UytYeWxEK0RpZUdXOEI1?=
 =?utf-8?B?NTBQbDRhOVd2NFJBTXN2elZRN3pjenozQVp5TlRtT01lQUlzZ013d0Y1Y3JT?=
 =?utf-8?B?cGpvS3RpZlR1NWVSRnQyQWxqR3lsTUN3QzVnTXpkZTVjVkxkM1pmOElxd2tG?=
 =?utf-8?B?QVpBUTJTUzZXdmloWjhtdUg3a1NMaGQ2SmRseWNaa1U3UWtreDVnNUNSaU8y?=
 =?utf-8?B?VUVpRWVjRVVrT3R5ZkVvUFRKUjB6MkU5UStNc2dBdmhiZ2lRMm9ZTHBIek5L?=
 =?utf-8?B?QzEyREhGblB4SW5pZHNCTlVRYThLOUw2Z0k1NlJGSjRNb240akxDNEowVTRw?=
 =?utf-8?B?NTlTajVmaE82ZnVyOUxxNVFZSFpLTFQ3WCtwb1NqU1dzcFhxZktpODdKRG5E?=
 =?utf-8?B?bE52bjBselh1UE9LMytSYmpOSUhqMnprTHkrckJGaXFsUDdMRkt0aDg2enU2?=
 =?utf-8?B?Y3J5YUJ0K1ZuSm80YTVYTzNPUWhGSTJpN21IUUxIMnpZRVFLVW9IY0V2bkxJ?=
 =?utf-8?B?RDE4REU0S3Zueld1b3dZd1pSaURzaGZVNE9JazVWRC9pY0VWclFINCt5TW8v?=
 =?utf-8?B?Rndxck40OWc1dXhDRnUyWHVPOVlTaVAyV3F1ZGtBaDBTa0xObmtoZklhQnV0?=
 =?utf-8?B?ME1VbEM4OTJmS1U3eHF3STlMZGd4clpKNXhRNk1zS2UrNE1DQlYvZzdRQk5k?=
 =?utf-8?B?UDJWKzNGK1gwSDA4VmZwTXJiUjdLTnA4cHJLZ2o1VnRrNm5FRmJnRzA3NjZG?=
 =?utf-8?B?bTN1MjIrVzhhMHdIc1RRdVVicWZIeHp3ZXAvUjJXa1JuNTU3MWtHN0NldTFT?=
 =?utf-8?B?REpPT0dRS3RDZlladzVwMjlYOEhtSm5TZHhobmhIUHJDNEJSU1VFc2p2YzhH?=
 =?utf-8?B?T1NiY3hxdUNaTjR0UkdRUm8rdjdtR09GZ3ZLaS8rendWNFV1UkdIQlFsY203?=
 =?utf-8?B?L0UzUVAvUFFNcmNHVVRPMGpTWFZLVzFNMmtMN1hwbTFZWWpBZXd2cVE4WU9l?=
 =?utf-8?B?VElSMm96VFE0YTlBc2diQ2R3ZTRZMi9jS2loVzM5aXJ6bzNoTENqYytZcXE1?=
 =?utf-8?B?WmFpWVBKZFp4ZnNjMkZTSHlac1RVaitzWFkrampRQkhGbHk3NlY4Wmd5dk1x?=
 =?utf-8?Q?d8qRXejQl9Ua8z9CNFULS7sUD1Eerk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:05:31.7892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844cb198-5c76-4bef-ab6b-08dd4bdb51cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
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

Add ring reset function callback for JPEG3_0_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a4acb7cb7ea0..9faa9c6809df 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -132,7 +132,10 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	return 0;
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+
+	return r;
 }
 
 /**
@@ -151,6 +154,8 @@ static int jpeg_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -550,6 +555,13 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	jpeg_v3_0_stop(ring->adev);
+	jpeg_v3_0_start(ring->adev);
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.name = "jpeg_v3_0",
 	.early_init = jpeg_v3_0_early_init,
@@ -595,6 +607,7 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v3_0_ring_reset,
 };
 
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

