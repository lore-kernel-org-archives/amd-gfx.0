Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25405D35E5D
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 01:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B061910E112;
	Wed,  6 Nov 2024 01:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uuxg2g/i";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0857F10E112
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 01:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4ejAa9Ruj+ls+eHIArM3kpxNNHNZUPgHYpnOofGKZlX3JojRQXqDh+4sk604u9YtPdBt00jDjeX38IoOZTosgA+ouCW5SUngnbe7PBS6JWy1/LMdiMpePkJUSOewFTzlfihHaWJOSl5gWQ05tOyPljRGhAfL8/lnBOrs1RCNKLGjwvI/ErQLCCOyMRJCBub3K023/ADrD0b7/SHEYtajg50DLRH0pbLXFY5T3Put7RA9MtYoiXhgTypk5OaLgS1GvP5WZcgl+cKpaAE6XE1evHp1pDoNbQYPPfsXkYGYljUX/mSYgD/fDNGD80JwYqHDLq92/TJuZaGVK1bYYlNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd011PhYonYtOe5TcR7FSbEnNVUjjzLW3TxS5YVtIFQ=;
 b=CzyDGDEa5p1wJ1YZ9DkAodTt7eXxDQZuv4mxFv2jQlCL4fvOjX1ER8qq50bBjSas5T0TlTNPOQvpxSrE0ZXfkxwhX45NUSjHHih7mwpSSSUZZ4JKgCg0chETyZykiVug5jYwOacj0YU1WYXzXMkf/UEmxWxnAKzxMSoVFL0bYcXv49btpeWPvWbrfgaPG61zMJNqsHS59VHeVKKc7r6KUP2UuqsohOlly0gdLGK5eiDXnMqSAUznEc7+Xudx+YR/3lb2wq+dn7GvsaFHBk1Iwq+GPUnFWe/mrECmi3i2nVzAXR3lo+5IHSUDt1v+p4PJqsCr3tngff6F566aozwqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd011PhYonYtOe5TcR7FSbEnNVUjjzLW3TxS5YVtIFQ=;
 b=uuxg2g/iNTU/ezcXfFklxDop/Y1p/0GFHSmRVl9osoDVTWWyTuDXHvzakq0euvnn/ihlmb4sDP3O2UBY0vYqXOMvZGf2ovzMiRriCJrJ1vQfrnpCPeUyMplgskPFA9Hy43XjkX7g8tuSwPz4LSkJU7fPgJwRO6EoZh0Y0HMH+HE=
Received: from BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 01:19:51 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:208:2b9:cafe::e3) by BL1PR13CA0091.outlook.office365.com
 (2603:10b6:208:2b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Wed, 6 Nov 2024 01:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 01:19:50 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 19:19:50 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Inform if PCIe based P2P links are not
 available
Date: Tue, 5 Nov 2024 19:19:42 -0600
Message-ID: <20241106011942.319058-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: cf100f10-12bd-4fbe-24f6-08dcfe011cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jngh3NXVn4pUKGW1bistIwa5xfIwZ3z15t2LT+r3p0s90D9zqasHr7i/s6vm?=
 =?us-ascii?Q?qjgsQb+gRZtHxZjNvwsBEU01sWsHijsd7pGwRmTmuUeKIAQ3lbFe+jDg9wv7?=
 =?us-ascii?Q?awXo/AjOHdNzwWqamoWRWB2obHpuS88p3u71BUG7LkMmnDM+MIgYBt89cZ14?=
 =?us-ascii?Q?X2X/3bqwVEi/PDR1fghYrP5BYEmwO6kaMp4FBlAC8eKVQ7r/NxlKfHtL8P48?=
 =?us-ascii?Q?RGxUKy6kQfoj8IqKv2eM/U+yxYvSx4gCQnfT/lxsBPmr30FWQwZI7nqLf0vM?=
 =?us-ascii?Q?O5A8INpB/rbx4Ab/WIx2LUKAFr6c7pgHEZaLuFmHJFPmzKb+pKSKEIt0pK4b?=
 =?us-ascii?Q?4hSEEcVQ7gty6umjvKlSHtDseX+KZUbHFa8fzrjvNQVRO90KUDuXGw4glUA/?=
 =?us-ascii?Q?GC7X1f8+x77TqVdEqaZ8SZyo0ZtGb3fyjnpb/BVTbd/pWkPhTdIMwyjtWi8Q?=
 =?us-ascii?Q?R0C61o4x4ToWVsP0cw8ydLKZlaUs67wKLzfICumwGIS6B3gulXMQ/0BbqsDL?=
 =?us-ascii?Q?t8beIKpnozHIfp9qrQnDUXmO5+xHhFK3TrK0c1KyGqo3IBFTMdwGG6JI+tyw?=
 =?us-ascii?Q?T12eXnOcn0H9kULSMiVT2aRCQgfHbfywnVWCbAkYdIXtwx5rJXxyQbyOdQg0?=
 =?us-ascii?Q?9l8qKNLysakKamaQG6hGdixuNkSAohCEoKQrfbBEyhMg8SXt0qviCurRh+h5?=
 =?us-ascii?Q?6WgVz4ZyB7AU9S71uBTJ6icBOCfBrSvSTrT0MiBnm5fKihf9uZhsietpWHnd?=
 =?us-ascii?Q?bkgchNnWb80+vcolMYuvbUY2SwcsQmAQgoLlo45uHgpF+sy+GnC6U2Z6AkAF?=
 =?us-ascii?Q?OKHO/qr0gDAcHT86tjv6WS3I0axYgilC8pcVLdfb8rMBvANmDyztX+69DygS?=
 =?us-ascii?Q?zuZryZ5giPaHyh3aj8q0BDOc+Oh4ZgnmDcfpMpswAMXyl35Zh5snF+26KmzN?=
 =?us-ascii?Q?MRwVkgAMeZSCCW1ywVbJFbXABBMV0if1B8Hy68QNCtIxeRNATBZIOpPy3SDO?=
 =?us-ascii?Q?iMnSBu/HULjqBevymhToElQy5Jorg0HYGypo07jP+t4NQznMwKVW5NFPfHAZ?=
 =?us-ascii?Q?EO2IXpuhRo9PpASZl1zvqNzJmSLWNuTOcSuPZpnAu0yAanB3olu0Cv2We0W6?=
 =?us-ascii?Q?vQKATDPJQEodpZuBTv7QqsPZ4UDs9XZ/1/PPa1WGBfYo61dM2/pXGY5wbEFt?=
 =?us-ascii?Q?3tcqYTcI4qgKmJFnf2/GfqV7PJvE05eLtRIiFqgluzWc2MdypiNQ96r696qK?=
 =?us-ascii?Q?hW9F5jUeL1Tk6JKMJVT6BVM0ETxHpqYfuSsadBqsc/ZujKBYS5YMjd4vnmjq?=
 =?us-ascii?Q?DrFVQWW49mklG3c620c5ttFEL0M1SPeKMXm9KhmTHKzhsc99xSE6bWTVHFv5?=
 =?us-ascii?Q?TyfKDch5GJARGiTY5jqFWuJsQsIM0MwHj6pe8oodjJL1HjqQQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 01:19:50.8740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf100f10-12bd-4fbe-24f6-08dcfe011cae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445
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

Raise an info message in kernel log if PCIe root complex
determines that a AMD GPU device D<i> cannot have P2P
communication with another AMD GPU device D<j>

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 230c24638a34..ab304a2c4aaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6222,6 +6222,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 	bool p2p_access =
 		!adev->gmc.xgmi.connected_to_cpu &&
 		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
+	if (!p2p_access)
+		pr_info("PCIe based P2P links are not available\n");
 
 	bool is_large_bar = adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size == adev->gmc.visible_vram_size;
-- 
2.34.1

