Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DACC5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8CA10E98C;
	Tue,  4 Aug 2026 09:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t4yfRS4r";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968FE10E98C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4hopnrNGd565rBixSNyjiw0xRn6nD3hc5vdMyQai+kTja2p2Awb1TKpczMi6r7ABRAsIO21eP3J4mLPux+GHCWX1/9MzFRAdVEp+OPpNFmBoSmPdvrVQm6Q4aOqUlh2IpkcaK5dNzDWnP1sawvuMsYL80BxBupdoP8Xc78dnAjwMxhePOmnSvY6IwIVdZo8VIHGr6zhttOB3pj8kx7TEPe8RJ9sAm8fZ5QKi8dpDPqGxOGzlso6RxI+EmrJ6N4yM2vpbVvRtvRSle9K7sPPXW4E0wOauY1IUrxbarnz+j2IPFO9WuAl1QT5WL6u7dKawwfokE5STguaWJ/tnFtDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3kXaKToEIQUr2ksxkyRHP8F2SzGjtGuYlzrkLZ/jLI=;
 b=wCRzTVr3iZ8O67UdI7yf79Iiu3n0yMxcmXM9k5/gi2Ydw1NqRaq7yqpp+3dnjnlnILStre6+zBJz+KKrO8BhDsZU4rvc5ay9lPMH7hKwUOFCkJY9kJEaXX0+XfrvfiPgdYDfeB3SukWu5FdSkdYsMXeTQFXRn9pv4AWGVxDiViFkEZwRNMLfi4yFuV1v3gRfzb5E6K4haUEVAPhSetaRr5/QFjX678wwSYiXHrt0tVGCVrTfVEAz1/tjAXZNoep0e0m/mbbvoXGoGhyDaVgP6p+HxyPWNjXKa0fv4p+8fBJlbp/1mwl0oTVsxGANt8n1aVnvlJzi4czr1MBuu9wrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3kXaKToEIQUr2ksxkyRHP8F2SzGjtGuYlzrkLZ/jLI=;
 b=t4yfRS4r3mE+3V+sxKQKuBjyU+t4mjwJAZSiLPYw/rRwmv/KGeKVfXEXbufWzEmnW0FyJmOLFF50ceF5OiBeGfpfCBu1FnLrqjjeMVV6z3uzYPTx6SCcDQyjjgZYe5zovv6Bo3WxqSqTOH6BCVf93Wp+qPZEWYz4RswKNyShru4=
Received: from MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::9)
 by SJ5PPF09E5F035B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::988) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:57:03 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::94) by MN0P220CA0029.outlook.office365.com
 (2603:10b6:208:52e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 09:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Tue, 4 Aug 2026 09:57:02 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:57:01 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Alexander Deucher
 <alexander.deucher@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: validate GEM_CREATE domain combinations
Date: Tue, 4 Aug 2026 17:56:20 +0800
Message-ID: <20260804095620.3899975-1-candice.li@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a178ce6-cd98-4f8c-a18f-08def20ebbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: QrWa35C8Hz1k/pfiytfan91iA+iI3mRqz6LqQEqZYFdHP40+csT3bncavuQE7Oj2QTXMB/VcwpGgB9DsZMrhn5i4mykHeVGP51K3hjI++VVhDQOb4iC5aRMSQHfvl6Z3swNI/CajFaus9aIKDzhN7mfWrknYGsIbN6lvCI5OF2YhYFZteIWHrgt+6LoW9EfeDTXjBQXeE+Mtct0BSduLHVkdOGAMOTDuihdveKYm9lW8QTbmS94bPEuhMVs3oBPMB4Xmmk1FMSxHm8BIrzg20NcYRqLbbc9twFsCnjR/YyV2vJkfBcB5FCySPJUa+/NsGgXomZHJvwCA5GLVc6ltKY78lYFMw6EqFFb0Q7fKZzg/tjo2pYNoIF8xBPbu6iPgYEQ7kYXrzO8cWjHhgAzebPQrSnEiIZp+/ii0pyCUwqvcR0IhDqJKNWO4XYRftkgQlWF7ufPB73IgnMoUq5ljA7nqO8ZHq8gcPqqAFq/X4WorERnZnjcNXY6a+MPDMy4geox6Gnpt7Pd9rgULFEc6UPWPoBqA6zmw6ZT+Qk/Puyt0a1LYOsWB1+QN/2IGIvAramciJ8fZJA2Kw72WMjqfYE+lr2LvNtDNyiIuZRwwNdYo9rc6397bLGckIqORvjVGA5CZoJqOj1ku7FauC6L5Slq+JT39vKT5aR/OkBYrY7RJUwkrUSYsF7mXafPq1l7PPW/vHluR8yBtwAOFNFlHkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X4bk2UA81JBizsuaUBa2F7c5JRLT/Zj1gOB1ofZSVTl09Ve3pS4CrNL2OW7uX7lZUnF0zKa97phVlR46O9iP7YTKwdme+P9cP29wCeQ+gl5wW4Hg8xQWfYJdHleiETuJ1yp7hWy5btvzDSv/oYzLrIqFWs36AcTEGmBeu0NX+0sLSYGS1QcX7nDSVF1aJfPDIMSRCPLNEJ+GjsQMmY/ETv2WbmUU0SKirAB10rHzX2aBeYV1iq2kxOw7st2Kaz2tAFxgsd4U83OZfnfVMubGkTaTEfUK5Doi4uOBlGnMVM5sourT8pbPCovLheaWm0YXYbJ1vFxiT0T8iRPfGi1oMMPqAclRDHvBlFfRsXM1fFMUB5QGcLvFT6FtcnX4K9bQ7vBDmaVdhDslkKpR1aBq3st60pVZJJZXWAZv6V/uWf3pDwKzR+P6Ifks8dJhBYCW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:57:02.9372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a178ce6-cd98-4f8c-a18f-08def20ebbf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B
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

AMDGPU_GEM_CREATE checked domain bits against AMDGPU_GEM_DOMAIN_MASK,
but did not validate domain combinations. Userspace could combine
CPU|GTT|VRAM with DOORBELL, GDS, GWS, or OA, making
amdgpu_bo_placement_from_domain() exceed AMDGPU_BO_MAX_PLACEMENTS and
hit BUG_ON().

Allow combinations only within CPU/GTT/VRAM, and require non-CPU/GTT/
VRAM domains to be specified one at a time. Return -EINVAL for invalid
combinations in amdgpu_gem_create_ioctl().

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6a0699746fbcd6..8fd0a63af4a135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -397,6 +397,25 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vm_ops = &amdgpu_gem_vm_ops,
 };
 
+static bool amdgpu_gem_domain_valid(u32 domains)
+{
+	u32 normal = AMDGPU_GEM_DOMAIN_CPU |
+		     AMDGPU_GEM_DOMAIN_GTT |
+		     AMDGPU_GEM_DOMAIN_VRAM;
+	/* Treat all non CPU/GTT/VRAM domains as special domains. */
+	u32 special = AMDGPU_GEM_DOMAIN_MASK & ~normal;
+	u32 normal_mask = domains & normal;
+	u32 special_mask = domains & special;
+
+	if (!special_mask)
+		return true;
+
+	if (normal_mask)
+		return false;
+
+	return !(special_mask & (special_mask - 1));
+}
+
 /*
  * GEM ioctls.
  */
@@ -421,6 +440,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* reject invalid gem domains */
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
+	if (!amdgpu_gem_domain_valid(args->in.domains))
+		return -EINVAL;
 
 	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
 		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
-- 
2.50.1

