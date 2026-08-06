Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD39EC56208
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 10:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E1F10F17E;
	Thu,  6 Aug 2026 10:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Acp5iqW";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972CE10F15D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 10:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vj6DogIu6wcXAJmVr0G3GgXMcf8/tvTr/NJWG/7cd6imUHfB1Wj67u4HlA8W+7yPa4G2GZKXBC01W9jI9JX39OQ1I2YxVnbQVTew3w8xs2vGyj6NzbHwDJcvlf8scD6fvvaixvJ4Dv0PBAPBBPu61DZ9pUMF43Sg7Va1OK9VroNZATTOanS+AXeXG2fxpVlJA6snlojZlFGElWwRwuQjuwuhBV17gfLOzsUr3xwqZlpDek9bLPAJl6TmO4EyRbEOcGbEQm4ijOwWgreTFM2YfU2bsMkjv4UJ4+heG5d6ztihFTFg1rcPrhpSR2pN+2HQiyz041plS57re4WYI1yUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRCfJq2LwDbLhrw33Eu+6GWC42XXtSNDwFBKkYTkFv8=;
 b=Kuo9ZMckeiqF70NyBMBH2NDwAG5PAgEpcr3iKw7KmSXXNgn9mkrpiCXUePdxxPXfwZRtbvQK1ViB167lhgiLWmXB/5DnoFeTxrr9TIM/mdHEOJBi+haWuzv58oP/ZV4k4yNKaoI//BzPapLvdIBiOpuRLOIXA0PHc66GPoQcLBAxSh7wamnbEG0BHvrpFEzKV8tKN/S2KVaEb/18GL9ONrcgwVyECLQfl1dfqBWgvePmjCx/4fazeimAwL7+nScOZaEnp1ANMPj8mgU8dfIJScZb/mFRWcYWJLL2ptXRWoknITxgQ6rY+n8BASCbllohpci2TjNNSWMJ+VveCzCmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRCfJq2LwDbLhrw33Eu+6GWC42XXtSNDwFBKkYTkFv8=;
 b=4Acp5iqWEtlJjDIaJ03A/C1RyYkcwhq5k1zOWERcDC5qayT2G5A8EgCdU/hnOICsWR7L314jbmF1wLpPHLrFVpZYZ6bd9MNuAgWZC3h4QQBd07hmJyAn+nsUASYoJ5Gibid73cwFzMI/OpWbod6OVVdZHQB4rr7tSPURK8/m3aI=
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by MW9PR12MB999208.namprd12.prod.outlook.com (2603:10b6:303:301::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Thu, 6 Aug
 2026 10:00:26 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::d) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 10:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 10:00:26 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 05:00:25 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Alexander Deucher
 <alexander.deucher@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH v2] drm/amdgpu: validate GEM_CREATE domain combinations
Date: Thu, 6 Aug 2026 18:00:10 +0800
Message-ID: <20260806100010.50587-1-candice.li@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW9PR12MB999208:EE_
X-MS-Office365-Filtering-Correlation-Id: ac428615-0fc9-4bb1-0b15-08def3a18a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: xjRSVuA3evAbExbRHI8BfGU2+ekj3jgzp4i0+uzaeI40+kYX0MOLCjg5N5FWtaZMpXY5GOofueLLQ/YhIWs4AO9sQxmWYr0eeG1yOC90c9iSTm6IjhiKP6jq57h7FhS8kois9yKbd2dPtKr7cU98Di5HcQDdUfJ8OIrPNVJsiGiBzov+UN/yGIbh5SfDNq34DH4MikNDBYiooAekw6TTVix6u9Q2Wt/LlH9Zh/JsVLlBoShkLksLGl7H3U+BBCgavpeyUXuUSBne/y5m5yuFYciqW0+bIHwa7QhFwIRR6NuBnM/wYzmE8bX+gPYoftSoD6NSUJSQXBhj69tTxbJ+YmtYbiLQ+wlo6mE05POyhvRFh31LGeHXFTkrcCIvf77ngo+hlMQy2VdGrVwfdQIQqbwo95KUiCichradhpKTh6A6CQoAK33Zir0Sffd3YZoNItGCj9SrDpXPxT701l6BbX9UUyVk0/qllxEktPkOClHltHUOYA6b4/ZtUkmttP/QB5MVpPvQBVMr2BzuKcc2cBfiahMdPqV/gMC/T2KeOZVxTFp2EkAzgH0TxTtoCQbHG48LQ/litiiJPyV2zOlaSvDL5p/Cn4/nUK/bcJwocKMERf0boKgpy0VKxIpfiLD5Z/tQP2pLu2zec/QZ5ruBNQofajeXD1cg/0df2ZfUCuGYbQbFtL5duDu3NYjvvH2qt1/+6kbxmnSZE37unn5Jhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: smJJ5QKiu/bu+7C33pIOhFoG5s4u7CMhE8nTOwli1pw2uS01rzVSaDCPaaxCp2l1RBUQMd1WZAT/o2CBy8DMOs7xIr9yeKwFvPa/4UZ/zAQ+mnuQ7ZCat62famW2kysc13+ZvCWDZ1VN7tbbfJuE5XuIn3+bu66CNCZ/prbWeHWGk+i0r0Fr6vplaUTCkXUmcE/N6dSQ92/OdJIybtqwwM0t6LWPUR2xWiOWvUc/YEv7gGtJ3arD64rs5yw+DevXJHen21CB7vYPMhVKGEYKscHjqqojWg2YEDdEzzQRxISyWB8/Cd3YJijZaWns2JB8+WNaRZMG4fxVOHP1lQ/vkGDiADzIDedN5SCYa8Xu/cJg5pxtkQXU1Uoa98F7cHB4ExuEdPlpV+o3al0zRk0KMoFGV0gYfvd81CN7cEQiE7XxNxaBN58LPMuGF8Zkfnz1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 10:00:26.5256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac428615-0fc9-4bb1-0b15-08def3a18a28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999208
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

v2: Rename helper from amdgpu_gem_domain_valid() to
    amdgpu_gem_are_domains_valid() (Christian)

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6a0699746fbcd6..f754a4a3a1c22d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -397,6 +397,25 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vm_ops = &amdgpu_gem_vm_ops,
 };
 
+static bool amdgpu_gem_are_domains_valid(u32 domains)
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
+	if (!amdgpu_gem_are_domains_valid(args->in.domains))
+		return -EINVAL;
 
 	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
 		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
-- 
2.50.1

