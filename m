Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB551C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E00110F1D3;
	Wed, 23 Sep 2026 21:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eV9p3veT";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C3910F1C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5qVM/e010bzlJpmxtMfaOmRvA+WuIUpC+KUEz6CqCndxy21PWjIcte8JfoMz0YJ/b3tNcBQbqu0HvzWRo9l3vSBHfNzxet5jSF7TgsjvLx8hYjz6CBY/4mzyr3iv6922Q8HjJ/FJwnr5W9Qe/AJGysaH3l2z+PSgZLNSRuV2RoXgpue2WywQCh69EctSRGG6sS9C6c7XdF48h+jAEAl9BCZhU8iqkhD1CH621yD7x8JmE/XXicXXfuW9LQaS/LCNlB0kEIkTmes0M4BUJiY0N1IT5OSSrADNQkgRSDBLruxwKuLr+QbC+NyNo+Mb5zZevUQeUP4eml7NZJw5cHc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq3ipOTPVqAeOw4BJRTzPrBseuSXQePYr9tJ7/Fnngo=;
 b=kRV47PG7Yc7dkNivrkOu/5v3RskUK5P74MZLA2GVQ+ttp4QmIa//4kODODEGLkh0RXsIXlTV7oIlfoh+dgN3KL0fYwkZOT0bWmZl3hgrXNB+PkVa23pDmi8m6quRq3WAeN8CAAHK5V24hROR00fyoxScfluKoKJ4cXr20RhzQeiz8ufVuriKtJsSJVc5UkSX924JmY+l2Pzy/yBHo+sqx5AkmKwxgXudhp+JRPcSkaPFtkimLcCTztAGv3usspM3e+xXc2Zk7wmN7x6UfR5Q7MhT7qPmnpvKoe2KtpF1NI2kerTdsac06BphqDH0iflAsiMBeMMaeNbBJIgxEtqTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq3ipOTPVqAeOw4BJRTzPrBseuSXQePYr9tJ7/Fnngo=;
 b=eV9p3veT6LJ58gFoy+jjMZMLn1c9MV00LLlaJJjcN7QxglyyoQZ62emYVIjRhsz9ryZqkLcp3YjHVK5OdRkR1TbgmKG50r6vVuxXzhUgU3mVJXgMrzUbWVaCPBARD9RqGre3b7TZujJ7H2H2ku0/8hInvyEb3PxSk5U+D4/tyyw=
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 21:25:45 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::1) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 21:25:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:25:45 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:25:43 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Sashiko-bot
 <sashiko-bot@kernel.org>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCHv2 2/5] drm/amdgpu: Fix BO reference leak in UALink export
 error path
Date: Wed, 23 Sep 2026 17:20:00 -0400
Message-ID: <20260923212515.1420047-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923212515.1420047-1-mukul.joshi@amd.com>
References: <20260923212515.1420047-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: b0051ef3-0b5f-4db8-c486-08df19b93a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sFPuWXrfhl3XhvUASPkHy12VNrUG0IpaBzBnieuepVNFhlKYPwvtfB4UzoV2Oyng/ZU+rHMtmvgQKC4kZU3z0/a2SEkcd02YfT/IUqJRNDNfiKAiosShDKNKbRA5VQJiWujC/zzTM+gmYNnLi+sKUUUOUJi16HF/F28VEZ+5a15IiUGKfG+s/2+i7L7oP5+BW3a9WzlSLU5pk9xthd0pfIimrXUDL+8pO6TQ9h5/VdQEkQaEYT5/P7XCes0Ivu/7JpSntFIELHvT4txmz6+CFbOcuTAFO4TgkB4hKivFBGDtd58SKbhBI0Q5Tbt0PUeuZyW70f/PXXLP7O2lvFQ/1URiK5miaPV6RTJlKLv8BnJjLSnWZEIIIfe2XF6p6d2Sc7fUL8HHYwgHu/jmNTYZL2JEDI/axyGuSiMzuStPZQEIVEabq+5LQKS9xKIzABQErCjexjxBPOwKr3JnCN9r3BjQ8tgY0Y/KI4OV53hvP9pSFo8bKHWgcVgubnDykk/LMyHRmexQCpx2hQSwUFItVYS21WIyc10cud81qKXGdQMAz3f7DurfYmXFHoGRtmKx4qH0zkny8FpbxCDG6xDhIlS3EbFARWQL19nv8o5U7oUKpgadCoKcF54JzWTXmHJkKFwWh+GrDmZXpu+HcJTfYF9swEe52xWuLzQhY3f3MqBlslrghwRXMhi8E62Ge99Dib8CYziHh/PcwgWQVazUnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Aad++UlUam9OCMckFflVlPFcrSqcfhbmy3qlywR+2J4q+LsJwlFAyRhvavBuoD833v79o/tpcF0R3QbkztGQo5MKiC6S6h3W9aCRCZEdD9knfXrEHCjY8CiSb9qclInugof8FoAhp6hu2oIjd0NIDy5JOpOSRYVFzhBCFPHrqDKgoHZJAwESamtc9hU87vlK7YD1fMPAc3kpZRLbgSuAuk87WFNNiN56JEVuXUW/W4Wm6fgybbIfGUXskIz+QVL/4ltfFdYRRMYV0SNGOHu3n6PbGY32dAqGeRvYtjJ54rFd5liF48EcR1GwQis/lPKTQzkmSIla61yrr/NcKrpvTghCP7H6mErHiYc+aaCqheAWEZIHmq4j0z9GqESv8d7xs6oedrFuFUpj0JLS6IIs7CZZ0ejDq4IK5kY9vnbbNcjGzpH34IKKK3uKYp8YbFo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:25:45.0432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0051ef3-0b5f-4db8-c486-08df19b93a8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
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

amdgpu_ualink_export_handle() takes an explicit amdgpu_bo_ref() before
building the exporter node, and the out: label only drops the reference
from drm_gem_object_lookup(). The xarray insert failure path unrefs the
BO, but the drm_gem_prime_handle_to_dmabuf() failure path does not.

Userspace can hit that path at will, for example by exhausting its file
descriptor table so the dmabuf export returns -EMFILE, leaking a BO
reference and its pinned VRAM on every attempt.

Fixes: 6b1a5ad90778 ("drm/amdgpu: Implement UALink handle export")
Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
v1->v2:
- Update to using exp_xa_node->bo everywhere in the function.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d55570d083f7..6e937f31a5b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4023,6 +4023,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		if (IS_ERR(exp_xa_node->dmabuf)) {
 			r = PTR_ERR(exp_xa_node->dmabuf);
 			dev_err(adev->dev, "Failed to generate DMABuf for the BO\n");
+			amdgpu_bo_unref(&exp_xa_node->bo);
 			kfree(exp_xa_node);
 			goto out;
 		}
@@ -4036,7 +4037,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		if (r) {
 			dev_err(adev->dev, "Failed to insert exp_xa_node into XA: %d\n", r);
 			dma_buf_put(exp_xa_node->dmabuf);
-			amdgpu_bo_unref(&robj);
+			amdgpu_bo_unref(&exp_xa_node->bo);
 			kfree(exp_xa_node);
 			goto out;
 		}
-- 
2.55.0

