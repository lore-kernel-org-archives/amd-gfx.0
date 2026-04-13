Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F739F34C58
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 14:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A28B10E41A;
	Mon, 13 Apr 2026 14:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jxjTy65i";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9F510E41A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 14:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVrtB7Jnk++el9VcWSZsTF/Dp7DseAODr7YpC+ZaZGgXkIMP0Hm5mP72SZZOtDRiLqu3laAXDuVSfs6TPx4PhXOSmnVLrhBsL5Q2vyafdULL7T8r2DdOVyMw00gQHuD1MKZ/bOc0YoqMeMxNqiKL+7M7enU3oA8dD3ogG4L/vaaua7hQCCBjOEhGCvN6vzsCMyEBBu/ZJPkd6WBrMJVlQgBm92gw6mToPaAWkRx/sOJqk+UQSZY0lCoNO/LMCeLNDc+pxKicxhdMi0togki5hSzEMMCiH1UgD2bbTHfxbRixydRsxJHD1SlKg+vKlyGPmyfbe96/6BpDfzYpTpFojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZvIiXgqGAf2hyyLQjFRQLIyW9ZtYGRZgbsBhkdW8gU=;
 b=MD2yxQU9UmkpjxZmyA6lLehmYljaR7kgG+Nx1aFddZXLCwu8c0ote0aPK3jLoiST7z2kzaKOUJ8FAeOPZWZLCZFsIcVmQJfud5pbINf90dFtoZuL0OFu9zf89K7BL1tnSQDxWSQtJ7df5gfOSxh9ka3wo6Nooh6TyR94DhVbl4klUG3EetgLmKO4vxsD7+jz7R+xjEd4+d31eeOX7kvrM8RnwdHIiRTs9zefcMeDL8obvGBcgizge1iYbv8r4JMtInl3qoV/r0IJctougaFIdeUGBlte79w/Yv+k5OjOYvYkJ9K7Zg0Ez4X1LWqIIjo3FxuWy64CkjPMvUXxHi1feQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZvIiXgqGAf2hyyLQjFRQLIyW9ZtYGRZgbsBhkdW8gU=;
 b=jxjTy65iYJk7g5fdmX3V7Wb5vVZx0FVcv0ySov79FYOzs7ED0xaY0pVMcx3g2QDeYWlN4VznszoJniJRFPn7hwXbTd+LSNxStpwEVUH5eg6ewdjBduvIGcqHR6D/MgUge2LirjmYK4IgSvCyF98qtCd1sfFUhZNees7ZQbzvdD0=
Received: from CH2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:610:58::12)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Mon, 13 Apr
 2026 14:21:04 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::d6) by CH2PR20CA0002.outlook.office365.com
 (2603:10b6:610:58::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 14:21:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 13 Apr
 2026 09:21:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Apr
 2026 09:21:03 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 09:21:02 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Leo Liu <leo.liu@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>, SDL <sdl@nppct.ru>
Subject: [PATCH 1/2] drm/amdgpu/vcn3: Avoid overflow on msg bound check
Date: Mon, 13 Apr 2026 10:20:36 -0400
Message-ID: <20260413142037.1039073-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b040f96-8dfa-42cc-56e5-08de9967e58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: oM4z0FjqCSjXXC2ZUuxFn9Qj76Yp+cpz3yLaPiUnOfuMujEhZfvmB4B1lb+n/bzjFIWw8xj8PJ3XGWvDSB8OvvdtmvZM5n5CpXtKTXQnvZGjxvpR0wz9EbxSZGiAsPyEcQ79ku8M+1j1277t1UQLVIJmQZvy3Oc558+6Yy9IKPPDiDNRJo87wftYZ3uJDBqU/C6NPQ8BQU8VWwLhhxzZsi9sddQWa7pjgxqh+a5pdUUl1zRcj8ixZfDC85sEMAoJD6NLzvIVxY57uQegsq5aUcUacBl81q3fJ9DWFNhnmzApKgQvqIfIMxoslWdot14UqlJuLBLXVEsRDv8SSCF+wbM0FyLf8zc7MlAD6x68wThlkZ5SXVrly2YgZUVrm9iW8iOu3f6akWuJvJVdPpAxiVyIoR/HWhxu20eVaTnlXnHkiiSeyjV5/jEaAd57jxekE/lZTf24wJcx/7x6AjYm+iJ5iORfP5LA9JtVHiSD6kGwEY8h/+KV2Kv0cmR0Hl2Sk5J5IX5mWpEW3QkeDvj1V3JNKN5BeJMOaiR9irmb5r2hvXuy8nwKgkG1ksR2q+jiC0aNpsIIgK/pr3X09E7vKF9ULamH9QHkakooXNkzPv+HVNKeRxP4CavKYKfIfgqvOF56WoHRKj6lWMRc34jql10DYvDnGgTN3jh1WIi1uESBH49x0HyrwZ3pZkJF+/ODPVdIjqgbo2C/MugdcIRvyLVtNInUmHz2DwzJBuSByX4KMGt7js/iqZ2VnIg0lFjG7NI/HTgojp+IjY8E7BMO4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kHpKgIzc4j+1t6e+UAR7E3dYty+mBYl4gTxCSjMIOOcHYZgufwcRxgbEBQNPT0Nn1Vf6vfBtCdS6PvxkrLeGh9OlCw/1090ufHHbi0rqfPtQva7CwBhCdDsbeYbsva6La841Bl6dmgNU1rUq6jvkxSNjKly+W3x3n472yUxYXtVQsK2x+xhpzC3ZMt74oEasU94yCeBYKDFOU5Zzlu0/qW6wYYe9ctRpzYk0sAn+P8hUBYK4OeWa09w6tox72jcJTV6dCm2qFhU7VczrE2cAFomV7k0BqF9K21qGGXYkTsLQfU0+prCw1m7MSlaHbmfw9/GxazCnibOE2YwNUqHBSsdj9E+2zgvcFSfA2xE5+/wv2D3TUyM+FO25m/FcWhmwNOvaY7Eo0/UBxX/GfqT9BMzo1l7Zo7eir3c4eUupgdPfoMCAno4qHD3i4MuWg9jI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:21:04.4443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b040f96-8dfa-42cc-56e5-08de9967e58b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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

As pointed out by SDL, the previous condition may be vulnerable to
overflow.

Fixes: fbc309508fae ("drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg")
Cc: SDL <sdl@nppct.ru>
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6fb4fcdbba4f..2fe5b3fe287f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1972,6 +1972,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
+		uint64_t buf_end;
 
 		if (msg[0] != RDECODE_MESSAGE_CREATE)
 			continue;
@@ -1979,7 +1980,8 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (size < 4 || offset + size > end - addr) {
+		if (size < 4 || check_add_overflow(offset, size, &buf_end) ||
+		    buf_end > end - addr) {
 			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;
-- 
2.53.0

