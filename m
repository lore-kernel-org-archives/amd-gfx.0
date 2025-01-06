Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE79E7719E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B8C10EA01;
	Mon,  6 Jan 2025 20:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBzMMemG";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B6010EA02
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vt4YvFqc1DoHTYj/2g+QYw4Qb7d2ql+XGfNYcBnVDqSSn1eR7KNDYhgH8MbS9JKjeqQ/hjqVybBZAmyWNzQ0zmOtLXZBrmfFm27muv8xXhLBv32uN/JMdsRuW5T/HlwolYY3kaPj5d9eS1BBAvdcKjHLFF9bxd7s/UfRaljJRMKAm/I4Dn6YQlkM4WQ9o3U7i0nZOPznT6UXMoU/+7BjMUzbftaV4Xm4to83CVJ9alfCqMssbXQdg11F3PcPnAzU5n0x/ucHmg3kbsDoz9dGoHGHK4mSt1aXmquUK5of2Cl1/vFQOPCSbv3DklRfontaD46K0BWEVLL9N4pFT9dpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1J+NgNFqx5mdm3lTUVMDq2+Hd5SGve8N51UjIRApSY=;
 b=IHPZNJh3NFktgUJmjrng9WyhYNl8gNXBiYABKm/c8FFIES0626b7rkhVhjsSnbjScRgKRpk8yOPygEiWbHRS3G83N7ji/OuUSS3RzEM5cpiCH+G1k320ByqkHKnQypKjaT0d9V4daH3uB6betLJP5J2UJ/i/+6xPmv7ZMPZSMF32rU9Y6rBv4w1NUTXNAjENtbRGTtiW1Yvza29BeDZXJ0ouRARaNAy4od4KLq8Vkm6APkt3PrsgdBMkqzF9PjQmJqGA+UyUiiGh+Qc6/FJTLFxJ2haCoOwiUnYPTj1ern7INOmOF2jvbgsC1Nj5fCUPqNSjEQmfhbtZqfWUf6xrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1J+NgNFqx5mdm3lTUVMDq2+Hd5SGve8N51UjIRApSY=;
 b=XBzMMemG/D1RDc7OLgwMvrIrt7lTV9FuYkSbdduTyGm/flRnW6dgkqgPtjDBFJ6QyZMOiZjpWgaPqTiGyGK0Fep2YFNTSzmrjqgUH8iZtCYtgI9e4FOqRW85g4Q9FgrPMk6eEk9lXCNIv8kwIC46FQPVcUUpvtzRmk575yL/FkA=
Received: from CH0PR08CA0022.namprd08.prod.outlook.com (2603:10b6:610:33::27)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 20:33:32 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::fa) by CH0PR08CA0022.outlook.office365.com
 (2603:10b6:610:33::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Mon,
 6 Jan 2025 20:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: rework i2c init and fini
Date: Mon, 6 Jan 2025 15:33:09 -0500
Message-ID: <20250106203310.3349585-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: e6acd077-b67d-4793-2402-08dd2e916323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g6iJa6GhbYRj5Si+6aBIFn7IDWDRyUXazQJJdwjbW2JBfspZ5G25VXRwW8Uh?=
 =?us-ascii?Q?NESxPTgaU3IGhyDS0eqftN/YG9BAc2rlBFeL9h9Kihy00BTUItqQVnCC4X6m?=
 =?us-ascii?Q?bL+TWf2ifJgr+4bqvyrPWpVJNk6iGLE31kkxGE4bPYay41ZFyAzGxd7iWapi?=
 =?us-ascii?Q?vmxXvw6HbeUogJsPB06j8pWYFvonK3emzKpLpGZEGGJv4lcUKPvPSTCeJm6+?=
 =?us-ascii?Q?+i+AyH12AdITp3fr7wPuGkO+UKRx62JQM4If5BI2zaeQgRKwvVkdV94zprkx?=
 =?us-ascii?Q?HDP4lEJn3qopFfrDBQ5yAnCi4CP+tKttq9BwRq0oJXnprp1oBXej6bkxESiO?=
 =?us-ascii?Q?1gAjYCWN9S8u+Ws5hYtT4yRJS5kGMttWBMWRnHbx9l/MJTOYBmjBUYqAdt30?=
 =?us-ascii?Q?+4UTHUZ53EdU9/X606r9u+MeoKPdC+QftYSVyiNgNGsmzNXXV5Vanbj/k6cA?=
 =?us-ascii?Q?bk8yNC/rF0NpuXDfljVBrHd0pD6vzjICL9R82L+qqcRPDRTqiDSCvTgPCQjp?=
 =?us-ascii?Q?lT7ORmKujKiaRUoDNWm4spXMDLsoxsDVD5OnmdxUoqH0y5l841pJHhXfyhSz?=
 =?us-ascii?Q?mNNGJ7F41Tvd6SqUvdcrthps+hJY4W4cU87TIyU/xjLlk7Rmnbtl1NdGETZV?=
 =?us-ascii?Q?vHPG8Nt7uUeCYKG6inh/jfbZrok8zocpvxNESOVTR+B/UpBfS/QNuwy7pTvV?=
 =?us-ascii?Q?B7asxpHy+OIvImpCdCpIC/ylZCCqmYTm509XQ0MDpv/DbqO8K46VsythQR4M?=
 =?us-ascii?Q?U5UoVaYs6OYC+VWjOOcIHxi8rC+93Vz1HhmZO9OpgCNJ2NdSZyvCOZq5yDjA?=
 =?us-ascii?Q?PTpMkTOAi1gtnvwNc8l1P3XBbunkKKkw7uWGOa6kkte0y9OIw17AJsRa1wrz?=
 =?us-ascii?Q?Ae7LwBGGzb6EekxCEwcvJpUJs4E4aGFkHe/R3y9ZjNkpLOjS6xPZVzQ2z4po?=
 =?us-ascii?Q?QG3k2QF6HGqVXw2ul/ouNSILg7iD5Z+8L4TrNYTUSzLhITDyMLDLnB4Sj7Hd?=
 =?us-ascii?Q?SY3pYd1SiWKMmNnH1Xn5R8YOd1+CvLbGbKS7jawpwyH62vtzFHcrabuagbaB?=
 =?us-ascii?Q?y5jcHuH/IRH2uckB9t06uwch07ZriABbJlDmk0JxfgvQZkvHvt1OoVd0sHE3?=
 =?us-ascii?Q?yHVAlS0R50qqiTgAwFxGBscpIg/kmacB7tSyDO2Sph/IGtPnrhR42HCSzXoa?=
 =?us-ascii?Q?TiDxxhVQySM9gR0Nd56G16YuYFm60gxcA/2IFGCAYzIZjAsdlARjVjG6I82d?=
 =?us-ascii?Q?qnCXSndMzTDA7zRZSddtaTRfq2bGunVT+TJRs7ZP5bTEQaLh3hbv0VgTz64M?=
 =?us-ascii?Q?KjSF66tpD9HOoIvcWlroDs4aeDAWeWFIZyFzZowVYvRAwpOw1ThGL018HlQ+?=
 =?us-ascii?Q?KgiIFUkFBxX8sPt24FIoqmIywNRVHZn2T0832prDk30y1qE+cJiE38GMhLIx?=
 =?us-ascii?Q?LUFSnFaVxxPQIUcBeaf4JbbrP3Q8Hvu/l+on47A/ckY2f0GMinhgrWr0rTKb?=
 =?us-ascii?Q?2VCJZHcW4OMhr7c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:32.4080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6acd077-b67d-4793-2402-08dd2e916323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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

No functional change.  Rework the code to allow for
adding some additional i2c buses in conjunction with DC
in the future.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c    | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h    | 1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0a121aab5c745..d6b473217c8b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4467,8 +4467,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				goto failed;
 			}
 			/* init i2c buses */
-			if (!amdgpu_device_has_dc_support(adev))
-				amdgpu_atombios_i2c_init(adev);
+			amdgpu_i2c_init(adev);
 		}
 	}
 
@@ -4737,8 +4736,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	amdgpu_reset_fini(adev);
 
 	/* free i2c buses */
-	if (!amdgpu_device_has_dc_support(adev))
-		amdgpu_i2c_fini(adev);
+	amdgpu_i2c_fini(adev);
 
 	if (amdgpu_emu_mode != 1)
 		amdgpu_atombios_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index f0765ccde6680..72f73a186dd94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -225,6 +225,14 @@ void amdgpu_i2c_destroy(struct amdgpu_i2c_chan *i2c)
 	kfree(i2c);
 }
 
+void amdgpu_i2c_init(struct amdgpu_device *adev)
+{
+	if (!adev->is_atom_fw) {
+		if (!amdgpu_device_has_dc_support(adev))
+			amdgpu_atombios_i2c_init(adev);
+	}
+}
+
 /* remove all the buses */
 void amdgpu_i2c_fini(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h
index 21e3d1dad0a12..1d3d3806e0ddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h
@@ -28,6 +28,7 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 					  const struct amdgpu_i2c_bus_rec *rec,
 					  const char *name);
 void amdgpu_i2c_destroy(struct amdgpu_i2c_chan *i2c);
+void amdgpu_i2c_init(struct amdgpu_device *adev);
 void amdgpu_i2c_fini(struct amdgpu_device *adev);
 struct amdgpu_i2c_chan *
 amdgpu_i2c_lookup(struct amdgpu_device *adev,
-- 
2.47.1

