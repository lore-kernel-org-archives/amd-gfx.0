Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC700D35693
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 10:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D58C10E655;
	Wed, 28 Jan 2026 10:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5NHr6SJI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F5B10E653
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 10:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT20dgZ8XpZjhRooH1RaOTjpVN0OnA+c+vHmFKWg4/ZiI4SozVdeobl0DBVFt3Tn6fxxZU9y5C8dmcqWLvyZlA0C+65O9yDDAyN3TMddX+RLsRQVQ5up3amDCTAxUWWrYbUJy4r9Ex97MLSiIWR/wIQJglMVxAR9p7tc+BUEMpYbvvH1UGQAeBO595rr7mRAfmJCk0vL7U9Y7StBuSDNwORyrDP62vh9XDnDOXWesYorqWTdrcdv5wbQG/7Fm+QwkJvwLmVWXX2wcDRCTfl55CqPH7/ClYaxdAMgbtYwVwE2gfwMkwA3Qna8iJPfkGHL1jtYbVELVsacD4U7c8HnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOUk5WqUQoduptM+GsDjBur+yG3BUaVCtI2Zdnc5TcQ=;
 b=ZsVWDxmSM3qlBYsUF3G+EaWaAXkLTF5p5XSAEOmNBLQyXcALhISEeO/2wxCtSCU5zbKG+GEP4FUCOMV8lpJQNGs5iu5fxpYyBHfyunTVTK94PiT/I+yujewVD9pnSWHXvkEvwIpE0/YYy4o9iw3nPmvLk3PcLGTxekQz52KKWlr6ZqojOispGNDyBJ26jokvML8RBguXyl+a8ueAXpxMnhG/ymcJR/y9wgfvHlRwf0xBIVV2Uy1sn7x0cH7ccvh8R0QWXRNvhiW+ltQ2tX6nNFita7/eZ8b3mS5KuzjqUM+C5C5daQD5d1P5k2jWZP+x8oGVXyk+sXNXuhvICJ+I8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOUk5WqUQoduptM+GsDjBur+yG3BUaVCtI2Zdnc5TcQ=;
 b=5NHr6SJIF8SV4hpusgUl9k97AeNGvZW0sRuwn0cA1HQ+ULSMa/32a6p4FZR+5HaGXPNjJnsgMkwg0eIMneh9BZlO0StOYHSfpuZA6EVpb+Jba0HxtlMiNk6uXcKtNJcs0xGcJr1xV6CnKSa06gsqECVPQRcPr8Ld+pWxkX+aIzw=
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 10:59:37 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::16) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 10:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 10:59:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 28 Jan
 2026 04:59:36 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Jan
 2026 04:59:35 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 28 Jan 2026 02:59:24 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v4 4/6] drm/amdgpu/gfx12: add CU mask support for compute MQD
 initialization
Date: Wed, 28 Jan 2026 18:58:27 +0800
Message-ID: <20260128105847.2898288-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
References: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 3171c56a-2d36-413d-9fee-08de5e5c53c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RdZourdAAWSiDWztwE2CQYM/E4q3H4S7K4/egZIli9PVzolMmglw4dYZUIb0?=
 =?us-ascii?Q?q+Ki7qVlh5S/BV/zuuTCGszYdYUu016fj7yNcnwnwPQH2iU2ABVzlvSSqkub?=
 =?us-ascii?Q?VfOns8M+H1y9++LOIO0BhQsTuw77NptdRYYIxSwyqONv+X6kcB+TPqStg+OB?=
 =?us-ascii?Q?gkAvz+DmfUmI5RZBftN1ZdMnOqqU/D0khach9Su3WFL5+u4uog/VV0+csCrS?=
 =?us-ascii?Q?MypvMiF2BxRoxOyvqTeSPqpJ1O/SrYlZ7udZIu35bOaxNCXAu1nScHfCWmH3?=
 =?us-ascii?Q?FIWu6d+4d0+sLaH7HRnZjV8AyPAERPQqXSeePkvbNkNtj/17onHX8dkT/tGK?=
 =?us-ascii?Q?qTdEP/8EG8WF8punxLaoSzQPZNQhj+m8XIniVwGNtZSg79jtuJYxKhfGaweL?=
 =?us-ascii?Q?L5TX0r2KstgNCw5WuErYKFMGfzN8BJLy3ec/ck1xKmEFt1ZeXDw6xM28DC1v?=
 =?us-ascii?Q?12O7sQ5XOceGonMq6DkpEgvM4fOsIEaD7cYyCLHiSQaQERHEEBWlntTwu4G3?=
 =?us-ascii?Q?Ul1Bq2D3fkf4Djx3upnBZ+0XeLoSQkjt4Q9pyCT+BEqETZirPTxWx4GbIMGG?=
 =?us-ascii?Q?3Ix1lv4Wv6leTn7zDI/5oMDUliCIpmz+A2Y/DQpn4/k8A53UidJfX6TMU5y5?=
 =?us-ascii?Q?qIt1l9EoUGwjefZOhWDFjxY9pFXFmJ3j5+XI/y/8yzXpTAN2lsx9iXjn21l1?=
 =?us-ascii?Q?99SPnbcZrQHe04xizZW7ChknNjwmCkQk6JcII0EExCx8fMwzoXEm49ZPcbHE?=
 =?us-ascii?Q?WqyhvYdkOa5nOp4tzigefmFsHlWhlVshHHRQYkq3Vgng1Ze1WH1mvbpJOH3P?=
 =?us-ascii?Q?9zj9vcsN5KxZkCT8rGQbUlkcmDdI4YNDNmPbA8q2u4xau/HeqP6V1aA/H7lZ?=
 =?us-ascii?Q?NhLevzi1Nv2wAN/CiUWnxb/IXK9A2YEsRx/QszHA1hKBt9eV71rOly9Aiw4G?=
 =?us-ascii?Q?WLcaBZGWJgVnc+/z7m7lboyymyGwya4o/AWK15tOfibISQsoBipSbhCF4CXm?=
 =?us-ascii?Q?g0gLy6KRHKL/6NAt7I3gkb1fXjvdVK199WYpVpV9G0YXWddRJWdBBAIy/57f?=
 =?us-ascii?Q?S6jUSwhO2Z7k7PS1d+gLQXGZlaOFkW8aexEqO2sRIIYmHNiMNX7prGprmjN4?=
 =?us-ascii?Q?UIBQEGxiPgt86CqgYZEaddr6Klh4K6AU8IAZIZlY8jwX7IxPtfOjyFygrcTq?=
 =?us-ascii?Q?uqIteDGJwJsSHyIQ6U9o9mMCOKO74bBniqoUTpjDu9lVWFrnDFUITmAVN1PB?=
 =?us-ascii?Q?e2PkZD85q6Q8sKG7dhm4xRbT9rXedZt2VMK/8INAw5JsAx0DJkFgSYC+ee1x?=
 =?us-ascii?Q?UVnx2Z5CUcdtfSqWVqYTRVXpuFu9e39kRtye6ckVj+Urans/0v80LCmFi+ra?=
 =?us-ascii?Q?rnhtVvs3fAm4MSug/oPRpMt7tyfVBOFgsbJ90AmIDZVLlFQdLTBoVuvfBQhS?=
 =?us-ascii?Q?+fbXrl1nZFOf3vvkNfWcPr3FKab37j0J7c0G/A3Unj40K9TnR+SwUCdQOnR0?=
 =?us-ascii?Q?aorx2qyKMybDTCzCW6X2bIqOpZL5Bz8/QeLTRApB7kFnV6GkKM122VrlGwM4?=
 =?us-ascii?Q?z/m2x2Fj0Emnm7bLuBl6QF7HekokTr7L7uFfIkrVw1qSUdlPg++dZQrmEkAh?=
 =?us-ascii?Q?p9ZOqVza0kbVa+pcVF9rQKqgGszT3PPbEgz7EOZto6AumjcD9r7eN22b44aG?=
 =?us-ascii?Q?8ulJuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:59:36.7850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3171c56a-2d36-413d-9fee-08de5e5c53c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

Extend the GFX12 compute MQD initialization to support
Compute Unit (CU) masking for fine-grained resource allocation.
This allows compute queues to be limited to specific CUs for
performance isolation and debugging purposes.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6cd16f016c37..73478dd0f6ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3110,6 +3110,37 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return gfx_v12_0_cp_gfx_start(adev);
 }
 
+static void gfx_v12_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
+					      struct v12_compute_mqd *mqd,
+					      struct amdgpu_mqd_prop *prop)
+{
+	uint32_t se_mask[8] = {0};
+	uint32_t wa_mask;
+	bool has_wa_flag = prop->cu_flags & (AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE |
+					  AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE);
+
+	if (!has_wa_flag && (!prop->cu_mask || !prop->cu_mask_count))
+		return;
+
+	if (has_wa_flag) {
+		wa_mask = (prop->cu_flags & AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE) ?
+			  0xffff : 0xffffffff;
+		mqd->compute_static_thread_mgmt_se0 = wa_mask;
+		mqd->compute_static_thread_mgmt_se1 = wa_mask;
+		mqd->compute_static_thread_mgmt_se2 = wa_mask;
+		mqd->compute_static_thread_mgmt_se3 = wa_mask;
+		return;
+	}
+
+	amdgpu_gfx_mqd_symmetrically_map_cu_mask(adev, prop->cu_mask,
+						prop->cu_mask_count, se_mask);
+
+	mqd->compute_static_thread_mgmt_se0 = se_mask[0];
+	mqd->compute_static_thread_mgmt_se1 = se_mask[1];
+	mqd->compute_static_thread_mgmt_se2 = se_mask[2];
+	mqd->compute_static_thread_mgmt_se3 = se_mask[3];
+}
+
 static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 				      struct amdgpu_mqd_prop *prop)
 {
@@ -3243,6 +3274,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set UQ fenceaddress */
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
+	/* set CU mask */
+	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
 	return 0;
 }
-- 
2.49.0

