Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E03FCD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE16A112DD6;
	Mon,  1 Jun 2026 05:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHvM2rJR";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C2C112DD6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvAo031MbI5LlVls3lvjL8xTSnVJpSwcxH6WfYXdyr+wLUHPX7eHLxd1KeFpxVKXs53tC2SLfdHqw3IQIvAKvfh+jRYlExsPikZ/rnMCJjAguRvSfSS2E/YcGe442T0zs2nVpCCc0UHTqQm17p+26MxmA+2jkS3fTS2KalXs8tQfnBfI/IOqmHDBqoZtJ5N6GHvcIO42+GK4oIMV+RyWd8bpRrUWr6dSEDlonGQGMB+DFBHzEDRE5t/dFzbccTodCmDN3XFJtUbObMJc0BnaIPJIw39SQeiNMW+fKo3jvP1uyMnXvztvURC8A7F1gSKfrerZNVkzefTAs8QbXQ1pPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuD0SUkm1AH5rXUotjXAOS93bk4H+nZqQGU9iWw9kuI=;
 b=mahXxjinZsPRZGZe2P0yQzAjTLMwmsWfplzjUzzABM6Cob7o9gpwulCcwT1Q1BVi9gP8TJa5yr3LEV41dV+s8F3FO5NiWk2yEv/+9R3G8PTWxIhGOodRnIDOIt5+8FKEdYX3NpGAkzBO9f+sFYaUFpD5wB5WMq1pdwXpzqGviUHaBJcztNosJsPVRmIPSh21IR8I7e2DX7pqAIx/chU01I3GsqbY5UbBgxVr2F34N7w2EzrWSDTuccqfKKO17SGAoYzMkOCP3wWqaC8poLwy7+y4BFYsl5cZiuDNvbtv48MmOfuuU3axduEbOd7zUMY5RveltRbGL9UrXfMk/YOKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuD0SUkm1AH5rXUotjXAOS93bk4H+nZqQGU9iWw9kuI=;
 b=ZHvM2rJR9DPoFYpsCjmxO8eynuS7YWGdme06FNK/6PAwF2AVP5yffSFswe5N0dR9jtgc2iMF9mH6xwgY2be263TJD8SxSlYdtCVPudVBBw4T0UDDXkSFQ7CNQHG6J/0m0YkcLmlbMRAfweXNsym7iDYNNZNt05V92KauFgmP1DA=
Received: from DM6PR08CA0058.namprd08.prod.outlook.com (2603:10b6:5:1e0::32)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 05:54:28 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::a7) by DM6PR08CA0058.outlook.office365.com
 (2603:10b6:5:1e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 05:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:54:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:26 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:54:20 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 31/42] drm/amdgpu/gfx12: unmap the queue via MES on reset
 for MMIO path
Date: Mon, 1 Jun 2026 13:49:17 +0800
Message-ID: <20260601055034.3700921-31-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8c6c11-5d1b-40c9-6bee-08debfa23dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o0JS/ztJyL3jME59ZER+zRW/o9MEhC7POK6Cbibk/YUjJsDFLjIbH5pPEIiPCXSf4/rdfOQpXbOBjYurR3vEdbnX5xeNZtvLv++/O4UncbNOxwzhoAAZ1JR2NtAP8kVDibhxlw4kISzqWMkH/lL244/7R8kirPW0uZCDXmYa2kW4Y0dBCoVnn3c8polDuYOTqTr4R15ZB8gSaTtU+6WzddflilHbNsmpSxwJ2folvjRt9TOqMBkrcmJHtqKw96PA1K6z43K5kB1lYAQZBWbOhJVAIB4gOBARROHvd7dIdTJvZJWz+E40EJC4LD0cwZYssONSJ+XvxVXy3Ljy1AwdtOiYWLs59I36CgnyxeVZnoMqPdkkEg93f6rCoR7p5dQ+oZo5ckyJUxqMMVNUIZJGLGhkIZs8hU78GBIJ7icbF6J7tG8OMmWjtoUhUzB4hUJtMg8miSk7r1Mc6DJQCfvD54bbst3EY9M3zFUmoiWI8bN6d6mkwaiCVOpbx/prSbS/Mk6xfGF2/I4G7I/OzQCcxaiiIaL5YUtyMW+GWH/h03jKSd5yjel/xFEOOB8LpZuKCBcKwVkA3QHpc3wgC5vcpZ9VUe6ACXF5rMJyNs1l4km7TQA7kPzkq1rkQK9jTP+izxoMKyD0uRbnmoqZp7wYR4jTm6pfc1QBjuYxTyQU7QdRtkcNPpXlaY1zqsaTbM3wIcPJCQxYNd2Fw/e2y7QkPc+e+nDkGzEjibzPdxWwXQI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TLLOJgmLQmW3r+aIfAHFVA0wATLxO5D85wZb62BclbeKYitd6xfXjW6D9m3pAgpM4Y+QIXqV/39dceWmdVt4BQee4UFFYfoI70GDIQ66oW3mjZLnWaL3tf8w21fCFR8EefC7OXqAu6+Vnayf5HFfftDB4ww4nUF4YXNmRdQBC+RP6JdvE4YMTCOeC3z82ppnm5+0rL4muYcz+uejIl2ZB/TZIeAoCdrqPFWkRM/Md5aVN7Mogwiq0OODDMUvcgfN5MIjXDo216j5G9ZhmTZtqX/MRorrpSreu5wiKPMmwtFAieeFj7n9bNJzbB2EwlaCdTbrcuDTFTieBpm4Ek3kUOfdYL6n/3MjpQdU3SgSRDWZfD9wmeXlb/3637n2QckOrgulmI/R73NluGIQpJu3Hz76aaXmUxDe5TOC7mTk2w0EyB+c8POthE4eiE++twrW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:54:27.5742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8c6c11-5d1b-40c9-6bee-08debfa23dd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
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

From: Alex Deucher <alexander.deucher@amd.com>

To keep MES in sync.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 375621f657bc..3c6f234cfb29 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5226,6 +5226,10 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
+		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
+						  RESET_QUEUES, 0, 0, 0);
+		if (r)
+			return r;
 		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
@@ -5253,6 +5257,10 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
+		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
+						  RESET_QUEUES, 0, 0, 0);
+		if (r)
+			return r;
 		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-- 
2.49.0

