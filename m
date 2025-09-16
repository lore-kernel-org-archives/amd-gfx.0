Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D0ECAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 06:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E97310E672;
	Tue, 16 Sep 2025 06:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OcEq9+XI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3920910E672
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 06:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyfKbK1CWeARBGiTgXy/ufIWQpqka0WCkiVctuRxlHHBn00dXYjuhMm+yA6nuSo5gvwbhY+apyZJqC/Y8ggj8IFqTWHkLgfX2j3HMuQB8B+60BWD73UMMObQU2Id9EMo5fZV0gMftdpZnV90LkK0lObIBZC0v79RCK70hkVole8k+woVeuqaBny85iGTVJ3GnoaA63KFqIGmutg3X9Qt4dHYxRnmKxRGReyZJa/RgfCFse0J8kN0ITyx0Ri9eiEkQFlTAen2bLRqfKc5WXv173QkLvF7gPIuWFyjIxbqkRqXKur9/mRAjExqAfqN6MIrf+FCBKo4OEwczUBQbCE2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xQ1lEk9neohm/YfzFuGrQ1RxFQ8k/U+DpvYnuAmTKc=;
 b=ogKlv+gV0C5kZvjHLPYt1WtGuG71DMULk6s/7h9CGCIlKRPA/HutIkv4ZQ8xTBbF9i009j5MGTpole6GeoHbu4B9/QGw/H+4W/6GY3/x3gCvVRb1d3ARQ1UyUhqvDi1wkTSRZ+lOc65VAlBBrpJOjIZJgATzk7dHE2R5i0hihpqx/ZJruSM0ztgN5mEQIcagS+MJ1iBGGJGXP2uB+YPPMYmqVwQmDVhd2rQg298HfsEzRysaGrq9M8eVwd5W9z15L0iUg6xHkmRLRcTZ4M465ROjbuyn3Iy69Eib0AYgwLrUj5uZ6FCtDH2QZ86Bmc4TM0AZ/6SPpZXwd76XHEWJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xQ1lEk9neohm/YfzFuGrQ1RxFQ8k/U+DpvYnuAmTKc=;
 b=OcEq9+XIjtCcFd9y8v1IbxDPK7VAFHhvgsv0RWpdXo4kr7SfuigAdheewknTiXw3BG+88At8aL0s/lFCmlmAj9/8jrCQUg6oFIIf5dyEJH0RsWU6YBRSnP+Lp/79+1/NOcHSCOoL7o+j4Z9SyghlfRn3NmPHpE/hVhD0SQr71tQ=
Received: from DM6PR13CA0004.namprd13.prod.outlook.com (2603:10b6:5:bc::17) by
 LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 06:24:28 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::9e) by DM6PR13CA0004.outlook.office365.com
 (2603:10b6:5:bc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 06:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 06:24:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 23:24:27 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 23:24:26 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 15 Sep 2025 23:24:25 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: Add fallback to pipe reset if KCQ ring reset
 fails
Date: Tue, 16 Sep 2025 14:23:47 +0800
Message-ID: <20250916062424.926083-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: e4621fd0-6eab-4121-f25c-08ddf4e9b020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h9tiFSrn0LT983GDLTh1grnnLYYz34FYYlWi0YEohgXd8oYgv+b9M4sMh7az?=
 =?us-ascii?Q?l5j0qbzE4fa5oh+OX+3o7fh24eUTGxuYuhXSDaf9tD1PT8MytDMnM/2eDyHe?=
 =?us-ascii?Q?+RTuQ2VA0h0aLM5Bk3UyChkiX5kQqnWZufzfjUbh5o3iBqVP5fJy+Wmki4JD?=
 =?us-ascii?Q?NnP4C2KKxfYFML9hDT1+c1p4JgWW3OBjSUTMNw/PHQTjPcont0KLDVtpJ1Fx?=
 =?us-ascii?Q?1e6Y9pAfkVeWHVY6AJH3CXA5TVedBds3KzrBKeUdqrNZLhd4HbWkreFIVybG?=
 =?us-ascii?Q?g2w3OM1YcXl/aP8QVd3RVrlD6XctDHYRhhYJetYd7ofpH6Z5Nj2rDrQaNdw2?=
 =?us-ascii?Q?K2Hvwj5anF3Jvn87ywsucKc3XjXIa8zSqm5WdwKpSt/vYgQqAIlBOz3SWAp6?=
 =?us-ascii?Q?6IebYJa3wq2rb0capkba4skjTGmLiirZlFA6SdAPulkkwQncekAyyadt8AMO?=
 =?us-ascii?Q?ylVY9PVNLUTosuy4QhKDZUWl191ejn4LZMky3++gK64u7JsNzhcAXC0srRGb?=
 =?us-ascii?Q?MhOZ/ePP0LIC/zCiPVWI3n/AetSsf+0e2SpiCYFqWIqez4hvxTPvYk+qmOSn?=
 =?us-ascii?Q?bD6CNtWkf6nbxDw15dE+EcUV6LhlysuR9RjvcL3/jiLCgbOtzC6zIcMU/gfd?=
 =?us-ascii?Q?OkqKNQU+crV7ACwKc05aOQ3vKhd3sFyLTrZB/3VEA95vFaYCgIxSgoUDLgl+?=
 =?us-ascii?Q?UuVBpgb2088Vsb54StZG0HQC93gv0uFI51nHtxU21DwluvzsLtbLgppRo8/j?=
 =?us-ascii?Q?yhiopUDcKbaFZFpJtTqvkWumaiANQThPwKMxyC3wsbv6bEsYJQmyGPiTWjje?=
 =?us-ascii?Q?k1SjtrunGnv419pI/kAuKDxERFqZl5EeCUGEeRlTb4mNzzBwyWOPGcDNQ47h?=
 =?us-ascii?Q?xduPgS7VLgDpDGGYWo4ICJExCWAmC+RsaiLNIJ6b1baumZSMVsJ9GmG4MI93?=
 =?us-ascii?Q?p6XsJAUABvgQEZS4Tn0Tb2iSXDamd4pka+DODrhcAAEwSoDOG1a8E3d/bKkZ?=
 =?us-ascii?Q?5KTkCo/MtJhv/AZA44CccxmXDJTEHFMjat3dSTaTMGgqVxlUxa83iD8lh2bv?=
 =?us-ascii?Q?buRj27EiI10oFw54wRtOss8drZc/iWunzgbR4W+3RM8dB2dmh6HyG3U5hR5P?=
 =?us-ascii?Q?Hgioj66g6aQU4ynp9w0ozI9Q5N5Pf2sYDfcqdJn+NFQYQYmDQ0fI6OJ7Md+n?=
 =?us-ascii?Q?/LUCjcBJu8InEyRC6tCx9g5V7d/sndipb2C161iKPmxdb5WKH9/MVDvO3b8Y?=
 =?us-ascii?Q?GhNedVJ9kdovJJBjdbqkqC9XG+UkxEn4QNwie57uFZ3TOk5xfjw1YHBSOq+c?=
 =?us-ascii?Q?299R3xio9KGazKzwIA33gKPQfp6p+p7TQwRTM2j027tqml1+7EjB7jNTl+q5?=
 =?us-ascii?Q?n29k1F6dZcroIIJZt91gikoQmjtuPpcybXwX7miQDf/3mBZTH7ohpm6cKOQT?=
 =?us-ascii?Q?n8xk1msgvr4EBxxITaGx6gk1XnHm1IkLtUezNTtYWGSrGj0mc3Uuf/vQjz9o?=
 =?us-ascii?Q?xRDQ9MK4YkmxILo3U4Qqwr+rqV0BRpG22XFQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 06:24:27.5177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4621fd0-6eab-4121-f25c-08ddf4e9b020
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add a fallback mechanism to attempt pipe reset when KCQ reset
fails to recover the ring. After performing the KCQ reset and
queue remapping, test the ring functionality. If the ring test
fails, initiate a pipe reset as an additional recovery step.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8ba66d4dfe86..8804c5844f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3560,6 +3560,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	int reset_mode = AMDGPU_RESET_TYPE_PER_QUEUE;
 	unsigned long flags;
 	int r;
 
@@ -3597,6 +3598,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE))
 			return -EOPNOTSUPP;
 		r = gfx_v9_4_3_reset_hw_pipe(ring);
+		reset_mode = AMDGPU_RESET_TYPE_PER_PIPE;
 		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
 				r ? "failed" : "successfully");
 		if (r)
@@ -3623,6 +3625,13 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
+	if (reset_mode == AMDGPU_RESET_TYPE_PER_QUEUE) {
+		r = amdgpu_ring_test_ring(ring);
+		if (r)
+			goto pipe_reset;
+	}
+
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.49.0

