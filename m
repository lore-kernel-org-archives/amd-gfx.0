Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D65BC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 05:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EFE10E300;
	Wed,  1 Jul 2026 05:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xETgn1zw";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650CD10E300
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 05:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrjw7lrnnQV3Ot+JZRzwaLdIBArnAAXaXjzpp1NaYzxzC80ZOe0R7C0uklWxFrUbo7rrVCRccbGuuMWMaQIc3Ir2X1RqQURPUkU2Z8lUoARC025RCDKdtEJepEP3YKCkLozp4KUUC52fTlquBfJvZxTMMPlMlUVgbEHuu5TSC9M48853dp8CIqjNDMH8a5ZDWV5zWT4xdKzGBGmOmGcvYZUrP1E5KzHDxPUakst0Mu8oL+vKp1H39MpI+YNt2fJ4dGiw5Uh5P7NJHP1zrin0IGyMsOGIbEn+0EDEcsYfXe68zLOeus07cU8SVeoBzBlIMpikT3opgWsdnNyqfELxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVjeBVPmoLcg/NVKiW+z1wQki6SOy5TNGOS6rDMlZok=;
 b=FFp1QxmJnp/WTu0AgWo5RfX2J4FwssYrgbKXUFdakM99hIhYFMOscDdeNv8dZpx0///ydSRBRP0CrZu4+4/DQY9vUHCkFBJtaQ9hv9qLQLpPPc/dhjIievOrZPWfJZW07QAvXKaCPJCLIZezesA2rJAFvE8jdcc2lB/nPawluppnxUpqPiqPz1PpsEK3Vm+igHPMeeAwFqt5sLC5oJOF+XnlxQze7/LqowdztQjEQDj1hYYfDfbQfWi+ljRELFS0nvjDnyc8X8SmEXyUnVd0UMMkOL8iQPahMH8zqrHXiyoouLT41dMAnYjiXXyKWUn+MX/u6lyo/coNM/LgQU8BqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVjeBVPmoLcg/NVKiW+z1wQki6SOy5TNGOS6rDMlZok=;
 b=xETgn1zwmrdAz1UhE+NT74xZQ1b67MsXqBbX3KntCsqPW2YoqVtSXLtKdKHwD7ozIEqPwSsnyfiebbkCfLtUCRpey3ZVuE/BQOO+eCwxOZrzzhVPhyZF+mB7pEld+3FnR7xiPu8lgKvUqxnM8j2dYjONFbBT2TxLrtEsyqoKdxU=
Received: from BY1P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::10)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 05:54:12 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::5) by BY1P220CA0044.outlook.office365.com
 (2603:10b6:a03:59e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 05:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 05:54:11 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 00:54:08 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, <Emily.Deng@amd.com>, chong li <chongli2@amd.com>, 
 Cursor <cursoragent@cursor.com>
Subject: [PATCH 1/2] drm/amdgpu: read FB through BAR0 when aperture is
 unavailable
Date: Wed, 1 Jul 2026 13:53:54 +0800
Message-ID: <20260701055355.20478-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: b20258ec-4078-46fc-37d9-08ded7352cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 1BG5h1cxByu5ChaSJ5jft7EGu5p4VWDQGvKt6uKY7eRdDl4Y2ib9x5CQYv1icfYUrhjwECb1Q6IxkPTTLEQhvnLccgSXPBx5Hm4OWQSOWVxwBDK6m0aF7lHsUMY2696eMWT3ucvwi3JpeWyExRHUNs5bEQj5yViyAGe2wP18KhmDoThWxuiZdYZRWjGcWGWSvlWr/M2ZQnQABwz31WlvZX2awM6IlrsuZRfv1lKr8yuu19uuZADzNU+3/EM/xAFm7NHx1JfrLvg5MpKHFSmwpEKlcNbXVv2D9UnEoxukcmnuqdtThAXXaTLYt7XsMBGgDCGziOHwB/Jt4CzqSAg44faJp8/XHj8Gi2iKTj+gpNrsN324vPJfJdNL1BlWcblPzu2RLtPCkr5LuI+Pu8UZpPjPgL9TTgOkl8AhkCCKIZBQJ1l/irVhPoehEEJq96DLg3vQalquaJdy65QS7ZLHsQRbMAgICGxS0ITvMxidIOPXKrq4+W/zmaTynVtKfgASKhxS6cr8Lgd5D+E845jXyxku255xFoKlvah2aQRf6zjK8Ehq7DzkryN1cnSNvzw8nJTn+LjCd7p9iaOsLqNTW2BWZ/CPV/Db2E9B64gUEaVa1iZHHVNu/1IkZbprxzat84vpfX4fN4OB93m85GHoQCQ1oD3EQ/eBWIKHqB24a2XhTEYLBc1LP36LGvhKFASRYr+wFi2gIUwbBZDtRf81wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AOwZLpwq4aI2QD9nSUfhLwqd5Q0EYEden/kd3i+pmXTO4OXTPAJwM2e7D7YnabYmxGHbLBnWVcwGhAwi+kTBbaW4noVwFc0U63NyJXsoQvfPjYKkg3d2337GcjYk6lkN8Ln1Ulr628Iyf9AT01/6Va3h0dk3ekBYF19ZI9vvCJDHkHJ7Coyd1Okjwk1DMzoxR/iguck7DhahgWs9ohx0HIf0hC+8hxPshyM197U3H9JpkwNrVqvy1QdT17dQ/gQji+n25+8TldvbfNzU/7qvVZy/SpDA4gOdC5m6XjkYgzifTkONByMywavTQdLKXc7uhjZVZiOuWbzdL7qeSELz06fXfhlM3I9dBebc7fe/yWSFFEvFt5JXQwojAXd8iyyAh8Jmkqx1Ccs/ob31DX5pZa0pRQeYICHeDwt+PiRiRALvv6LO/iVqehLUPlbAARfN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 05:54:11.5224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20258ec-4078-46fc-37d9-08ded7352cb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
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

Allow early VRAM reads to fall back to a temporary BAR0 mapping
when the normal aperture mapping has not been established yet.

Signed-off-by: chong li <chongli2@amd.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43 +++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5442a1fc1c37..610d82b79de3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -743,6 +743,44 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
 	drm_dev_exit(idx);
 }
 
+static int amdgpu_device_read_fb_via_bar0(struct amdgpu_device *adev,
+					  u64 offset, void *buf, size_t size)
+{
+	resource_size_t bar_start, bar_size, map_base;
+	void __iomem *vram;
+	size_t map_offset, map_size;
+	unsigned long flags;
+	u64 end;
+
+	if (!buf || !size)
+		return -EINVAL;
+
+	flags = pci_resource_flags(adev->pdev, 0);
+	if ((flags & IORESOURCE_UNSET) || !(flags & IORESOURCE_MEM))
+		return -EINVAL;
+
+	bar_size = pci_resource_len(adev->pdev, 0);
+	if (!bar_size)
+		return -ENODEV;
+
+	if (check_add_overflow(offset, size, &end) || end > bar_size)
+		return -EINVAL;
+
+	bar_start = pci_resource_start(adev->pdev, 0);
+	map_offset = offset_in_page(offset);
+	map_base = bar_start + (offset & PAGE_MASK);
+	map_size = PAGE_ALIGN(map_offset + size);
+
+	vram = ioremap_wc(map_base, map_size);
+	if (!vram)
+		return -ENOMEM;
+
+	memcpy_fromio(buf, (u8 __iomem *)vram + map_offset, size);
+	iounmap(vram);
+
+	return 0;
+}
+
 /**
  * amdgpu_device_aper_access - access vram by vram aperture
  *
@@ -762,8 +800,11 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 	size_t count = 0;
 	uint64_t last;
 
-	if (!adev->mman.aper_base_kaddr)
+	if (!adev->mman.aper_base_kaddr) {
+		if (!write && !amdgpu_device_read_fb_via_bar0(adev, pos, buf, size))
+			return size;
 		return 0;
+	}
 
 	last = min(pos + size, adev->gmc.visible_vram_size);
 	if (last > pos) {
-- 
2.48.1

