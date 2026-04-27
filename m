Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFFAFF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6A610E7F9;
	Mon, 27 Apr 2026 16:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="26fHmcO0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010013.outbound.protection.outlook.com
 [52.101.193.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE2910E7FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCkOQMSDBaH3gWnYFXHiAo7hquxQaruInoyQbc0sMK7jW1eRZ6IsGXiFNSv5e7GgAB2XBheiadCBsl9ZvXPUZrNnZbJxJuAj7lLcNZOPSbwcDr+pXFZUD+2CALsg7CC+uGWXUiEP/RukQQjG0TBS0/0CfgsGge/GBYBJX/GSjkQx7Ny+S3U4/9vIX9lUzrpgaYk4uMc7XVvFYMsAyzmIUaj+aNABoIw1Q+OW46ZQHytwSmHBapBZkEbqaqDmuQJAA245Hxu8YGn1tvPe0D5Eh/I2dXtJ5kLuUikmDp8DKUWxg6QgT5SzWCNeKAWNEVFyie/B/A+8FWmQ9VNKCVfd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuFpYo00fnINH9IM/beLdL63kyRjVA4B+2NqlzSZKt8=;
 b=SmCbUnJ99ukjp/rcId9M5l2NQBnqe3feSCToFo7YmSRKLUq6u8PULnWfjRyG3OMIRsOZrog5/vTk17qFJ+bJi5N2bybApuZgr6nj6v91AkJptj77oHiN4k2aGn8hQS+16hh4xm2UUBpjS8/XK0sudJsTNe4NdVIjv/39WfFEvdtwI7ZCaTzoCup+D5NrdLACT1SK8mxF0M1p3vQOYX+yQj4QWAgm8gtk3ZSV2+ycs8YO1wytp2FvCAu2y3E5ct2uwpHDzSVprvqJp3lrQlLgJWhx5oRuVpmgznk7khMbgVTyQU1ZeJ1Y8vauyZWmT3z/wQTN+CnSH1HQVFdUOXXmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuFpYo00fnINH9IM/beLdL63kyRjVA4B+2NqlzSZKt8=;
 b=26fHmcO0zSI2bwMKKPMz5fEmZuYCwyIwR33www1io6p5oF1MmRJ/54hyYWJMpjIZ91dyyIC1iqhHvVYzKmKVAIgCoVli+m1cS4aQDaS319ctB26ifkwsTMimCTvfBt5PMuE2VCLyyrFlYKgbOaqu1SWtfE/nb/4Ajn1ZfwZYIDs=
Received: from BN9PR03CA0764.namprd03.prod.outlook.com (2603:10b6:408:13a::19)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 15:59:57 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::bb) by BN9PR03CA0764.outlook.office365.com
 (2603:10b6:408:13a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:57 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:53 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 11/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
Date: Mon, 27 Apr 2026 11:58:49 -0400
Message-ID: <20260427155857.1370151-11-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8b14f4-b792-4fda-2478-08dea4760771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Etre3QcScGmKtf8Q0bkLdKfxt5T1qUxC8HU2fC9f3dHOewJKLJG51jjmNmLsLv+s9Dvznqlurm+iLRyAAr2k88FkVTJgLxV5IAGLYg31o4F53kOiIdNfl/X1mO4CzIwD7lbz0++g+S6AOPYPwjIydGTp+bUXyF+yw3yNu7ilzgKxJZNO6HihtiQftJdq900S664xJGdQkEEwh6Y+OCNY1vCMtxd97dpYJee6xJ5+droGPdMGxuMa92dmzFdIommal131owcilEF6y+faHexG7EypiXH6vBEAL2kWxJF12o2LYEG1RAmU+0/2y9QLjDdIl/Pq+GPt1yOpTbqvrcRa0p3t0QlJLCkiCat2bUDqPan4fWZqw1ABJ/5wFth7A+54inE1xnrudSOy/zeGrFkexbOpnl8DRCmN93s8jA8Z86N2DMZXo2ACSTb+j6Dn+Fvz78UtyKbhlMFUfWfKB2on3IB/uI1FfJQh4wQNI+nIvP8j0mvFXXEkTWGkKGlhirmugrGN3r0Hj44v25N7GuehHDu5NOrZVYk8iIgN8pIC55jCYiL9h0hdlBSYPP2fo06bHhD2VMYQzX0klGsdJzCh7Kaya1GBpnFJHSz/0Iy154pqA3lPgfANvawECqh6fnXF4ZtbCqXn/XEpyybfiMICyTFw0jqpI2XeYS72f3HNLtK92BQGtZM6gmjwh4/rVZcm+GedH0KqbqWq1EPgc6g4soD0wu8p3Ul2qimmVJUeOwhg+BL81z+7Gvedqd4h12vwwlABRqXiWdVabNKKcE828Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JEcnEl96ZCEFsGmj4OpGHswpTIOwVcR09L96Na69DXIErsl0MsKrSB/vS5VDlJTg2oFtmKQa4Olfi2mapJYtyRE9HPqcIxxihfjfndeE95dT7wT0wajx91w0boUrXt0qx96EydKCxewNaESyURZPIYO8TBlNiD2v75Bj/Tltav3DLY99Jk7iOyV2VoCkwbDXpZI51yfmbTUxnHWoo04efR/YEd2Ba5N8rFiT9tEZKADkuqay0axRFOZczyAxXBlj9lnneG7qyEXwNc4f6rN7Lqzu/XdkOu9RDnO7ObJU17OYYb3yH7RmAHjjIpgQ5ITHYkUwEFgukJ60zSvwSDdROZbuSRM7OBXKSJW/CK7WcRKfb+IDEJRGvtLtPY4iUxUQgaURmO7ysy2+48v7nICZ0aXUl2YXtKNVtzPAJklFi5XOOy2app3Qu4MU/De3rlZL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:57.0698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8b14f4-b792-4fda-2478-08dea4760771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 14f43e8f88c5 ("drm/amdgpu: move JPEG2.5 out from VCN2.5")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index fe2b049afac3..5208312e7017 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -693,6 +693,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
@@ -724,6 +725,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
-- 
2.43.0

