Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993D3C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 16:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4339210E225;
	Fri, 25 Jul 2025 16:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ihBCu4+E";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8736D10E225
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 16:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG/IWLeQolsxa6UzZhrE3NSYvaH++oilf4QVNsQdYrq6XPnIIE1+oVAxzFC8KXQiR3p6jee/GgcPFlaTQla7lqKgDVfWiKCS1BoABxgSBy0oERa2CtGg3gFLlsfwRp3A0ZEo1lQEfGWb1iZbGnEvHfUum7P80uCfsf2Ckn2Ur2/hHotlHS7pqNLndlG4hWcwxp8bqfXF4M0glv1GETuuSUxBaN0UqvFO4KXxrAsiuB1SumHfJFlvlcf2060/QW4M3Mw9HC3EXX7bmnSmzUJnGfPyEu6cFvbWQFBfu00DB3h7M76T2+NUP8MpE9GdOAoUh3QoBXvRCkIsq8Br72QU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujWzJrVhkDd18Gt4MPopVIz4w07B2zOIsXNMdU2jIfg=;
 b=oyZQ2R3wJ6vpWppqtUGapb9zQXPWgewd94uKs1c8zdKRufMrx2u4rO0BZPZMvMraCXQs8ZL/OknfmuHWXbiTdkC/jLiOojzVlVvjBp+Vquci7DxU6Ht+7pBVtD2WrgL9zlMX7vhXmpmK85QSby5hGLDqY9Pqs4f4X0De7UnvmBqmFdvRPJeunj/2YTVT50YkpFtfgsYCjD4bgigDmVo2+OnTp53vEYTPx9GqApopPh0cBRVLjGBJpUq2/LTEQZd+2DfpLlbdpatpdD6vEMylm0trzqEwGOyd/fbVnjYUCU09wRLnG9hA3q9AMk84B1tgIqFWYkjY5kOlJieYmEgNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujWzJrVhkDd18Gt4MPopVIz4w07B2zOIsXNMdU2jIfg=;
 b=ihBCu4+E3b4hOg4V4xDB4pbigEP7a6F8W1qAStN0xVYUGjbq6qi9Wfx6SDL6aSyafedXhGWFFV/HkH9nRgDaCuAKgRnhNcvfj+JA9uzPpJ18vzJD+OVDTf/XbZ0bTUjm+hfc1Rt1qelSYNqEa3C83sgj+Dvb912Z4vNDEns6dPw=
Received: from SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::28)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 16:53:20 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::d1) by SA1P222CA0146.outlook.office365.com
 (2603:10b6:806:3c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 16:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 16:53:19 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Jul 2025 11:53:19 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix incorrect mask used in gfx12
Date: Fri, 25 Jul 2025 12:53:03 -0400
Message-ID: <20250725165303.187520-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db3f1b5-ef1f-4157-e2a0-08ddcb9bc248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d23ssNU03ErYBB2Q3M8BTLUkIJoA3ESj/9VieGHmOG50sKeCkvx+tAWrpPAK?=
 =?us-ascii?Q?qzf4Wp+cVoRZnVLiX44n982Mn9rZbWb84VgCNOWXRV91YRskzhoRP0PMzzE8?=
 =?us-ascii?Q?YPBfjY2Ztt2FMi4NRsh+VvFe9UCgpcYmBxc/ysQe07Dv3j59gGd683waL6c/?=
 =?us-ascii?Q?+fxYv3W1PBQ3YD1//q1zJQMCJQY61d+2+lWSgDJMOJ9ISFzfbDYiFTAVRdAe?=
 =?us-ascii?Q?KBspypAuEnrlhEz/VJoLrli85pjvHJXhIeDHL09lXZ9QGS9zKemH9M3DOqA1?=
 =?us-ascii?Q?rr95+2ZmP5deF1VKOlwmGzvD6108gkBW/5G1Hee/uePuf++FM+8BnoM2Owv4?=
 =?us-ascii?Q?Tyc5dDZ02slAblyIJ8Po0y1pOwoTn1Hthmjk3p4XgMJvkgFR9mzyn7YmkFSS?=
 =?us-ascii?Q?JrXo6NDhB7D0FURCG9PzAY9Pm5qPj8L9O2g/PM2jppcqQUb6R0+gPRo1zEb4?=
 =?us-ascii?Q?EWGhTEU3HbWXdjU7UtEEznpvcxXhLsqB1A5mDXxJ+rZBbwLjLiyFvOiqPuYi?=
 =?us-ascii?Q?L7tQ+Rdgpyw35baYqJa6Rf7fDZLoGQjOUB+3hJB+y3hQZoDMN4BouY2WD04N?=
 =?us-ascii?Q?xpryh3Eb3iilamICSV32mgzQQy2wBSo+g77ViGZ+lvkhydNq5p+1IcDw3SIv?=
 =?us-ascii?Q?Dlo/Usr3QhwXRceEi5cYCyQ3whOLPFXZD3fjE7reokeUrDXh8q2J2X0O5aqq?=
 =?us-ascii?Q?uqxA9EAnS/I30ChsT7JidHCqGOSTNoeIZW6kdScdS0fzWsSgjPK/cgbFTRGZ?=
 =?us-ascii?Q?jAjDlkTFrtrFzIiQB2+5/kRZanLNOpP5dkF8uPTVIb0Cq/iu2/ysh4IMeBcF?=
 =?us-ascii?Q?5zcfwlq94hZ/VSlJ5PRm3nguY1kDCqsncsIdwmXB3frJqKJkndfK7spruSLF?=
 =?us-ascii?Q?Jj1Ty0TFlxdIaPUahLfpqkVQIeYTm4vHFh+8PSekQJKVU4Ty1uQIrs3wOkk0?=
 =?us-ascii?Q?VlvXh5NUN7Os79vmOwC+KeuQ6aLJMK3v5mM8W+2VwPfYksNrqLUqBEdRkn3s?=
 =?us-ascii?Q?5Nuw0kdhg3boHeZpFXzUh3c5jsGe9npmMjBhbWKKc5h7Nr5OQghm4MhxR1xD?=
 =?us-ascii?Q?vo8+cmrYnqKMkL4tL3sKdxti3S2jaVNiVHN1V1WWcc8tGhUo/T0s9Zj/uAm1?=
 =?us-ascii?Q?/BW8gemU6wr8mWM5jbCY6wacbzChmIZlDpbX80I10//S1lfzPIQu1MInS+K7?=
 =?us-ascii?Q?xv3DsNeUArEptqvH6QlIeJeP7hSGED+vI0OKXLmiiKJ+p/yOdrG4ibim8xX1?=
 =?us-ascii?Q?EQYjCZlpbCJL5KeRNe0edRlmrsIv3M3FzZD1m4QVAJu0tWH+GldFCxLF2/Qs?=
 =?us-ascii?Q?dTlTBmRlUtSAL3GR+gsB/F3CQiF2KO5DgaRftb/EqLLWul5MQQhu3ypCmuNu?=
 =?us-ascii?Q?Rz/PhoZ4oPEjE0JZTL/dqY0yyyHJsyvUuCS3CUQafqNksufu+Jx1nVUXcTjJ?=
 =?us-ascii?Q?/e+WxZElrK3Klw/aq2+qgyJ1v2KJyMr2CgZ+JSNWfyztJinwou8B4LEi0prE?=
 =?us-ascii?Q?kH/SR493XlA32Asz8hkbvDCbgN11oqDShuxC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:53:19.5743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db3f1b5-ef1f-4157-e2a0-08ddcb9bc248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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

NV10 mask used for gfx12. Fix it.

Fixes: b8c76c59987a ("drm/amdgpu: rework how PTE flags are generated
v3")

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index fb3fb31724a8..6260243012c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -517,7 +517,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
 			       AMDGPU_GEM_CREATE_EXT_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 }
 
 static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
-- 
2.34.1

