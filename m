Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E26C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 09:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0795910FB2B;
	Tue, 15 Sep 2026 09:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vo53yK4T";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F9A10FB2B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 09:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIkH6JfAFSZAws+4AD9Bo4wEffCnRHHq5kqmEGH17i3UE+naF6lwMZDc39Gi+G6G/yH/CKuAj5D3YAD9QJIc8ymYxkF9lSQ7uN9Eyv5M83OMjclGzb8MlY12kswXOoSfcN1CqK6Qo5Cl0RXtFERS1GH2d73Vt9ojEMfExUCbtBDT9ajneIpNnATTPKBhu7uFaMrsx0KEM+pbgVzEX7L8LephMebNTqsamu7nsfyiz/KBhKPojNuUj9Q6THn+6NWkTqC7TeZNnNlH2kV7zLJaorO9ty8IXEPuigbixi7oxAPrHrvKhspZ91YckZPFFFvvs2MhrDobPyR/hSFgJFUTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9BLjJQsB9eMmFXHd+fPF1gvWXwBoCMB65JAV2XqDyI=;
 b=HTaWQB63i9S1ynTSIh2/FGlgfk7UzIybQfCoU+2qU6iSGNaR5OqDd1pDVXInShVNuNg6O2YIYzHUdSrB52b7P+dj0ZmJPMsjqzvGeoKcoor3NKR1OgFoJeBcUz8mJ4nzIq157b4PcTq/BPQhVTNcEUhgB/958XUmZOeq2H3SoIFEhQEgn/4TdDDfbGkpm1M6VMJYK49hMGhJD84U9PC5UTdvSvmdkQmdliLAqS08w6eeXz3OnAZSHEaCKCCSwjVrbjri29G8xEqNxv4rGnAhDoe8ya2jxcn77cckUqIjQHqXdtdI/J7RVJM09CFIulya/fLYt/p0CdUdM7l8ofHi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9BLjJQsB9eMmFXHd+fPF1gvWXwBoCMB65JAV2XqDyI=;
 b=vo53yK4TbKgVBg1UDxOMzSkpXImXdqnC7T4FzJ+yEWzFsGA6xG75+6ph5COYgRlvk8CDdxGebtGaeofFdp2cRvjIvHRiKiYDDVhAfp/6Sb3Scb1BSP2LDiWpmHbIL0qwTiCDySYvXxt5Gqvo91lmj4vn9CBpqjzQLtMkYnOcD80=
Received: from SN7PR04CA0234.namprd04.prod.outlook.com (2603:10b6:806:127::29)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 09:44:54 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::42) by SN7PR04CA0234.outlook.office365.com
 (2603:10b6:806:127::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 09:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 09:44:53 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 04:44:51 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: skip ras error reset in gpu reset only when
 uniras is enabled
Date: Tue, 15 Sep 2026 17:44:42 +0800
Message-ID: <20260915094442.108755-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cf1de3-9f2d-48f5-e2e3-08df130dfeaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CxeiNN9+4MbS06r2cX5Tj7+5ALhcRO2gj0AMLZhaGS/1YG77mYt4W9X+NmC4z4k9ZvNb6410ynCciO4VQlduSGR2gfTo1EXHgBFmb2HXBiynt4mxwZiAzOuCOzpkQ5Y8F0VyncQ3MezMdJ37dMn24xgwNr1aX8CdbGfkJdsEOU79zknaCD3QGyk94nWQy0GLp29UhflvKtN1+12jejNSdEbDIFTTjUkSR1Censi1Tn3vIdtAs9Q/gOPDkoGodxQdIc8bNdFQmlMprIwvWmsB4/ozvTwy22zrqq0YGH26IOBsrEkPasklvHzZe6xuzsmtdSKO7dq7LoRy6dIB2UCHctZeg8weTi+noMnf74hmufiOJm1aQIzk9UirVU1IZAMkFCA3Oz9V7wK5DhXF/TfUW+XyybSXa71gQUdjcEV6N0MCzLOWjcjH2U5f/+NpR1fQ7g3/X02s949/qpXKpi7wEiRoXuGsqxxix/4yO/ERSk9teX710rbAeiXJOkkYL8Dqaw9Ssc847j0NXPJFn1cVAbMXvHWJvwO6c+uQ+R+DCOFQVVf3z1XXrGIDoswNxfWS4uI+3KiuOym6b77V++cguoABBsvxiJECfAIMD4zT5HnkOOi11m/K3RYX6Vo8wu1nb3BY115t68hEZyc0MUbfpjUD7fQ/sD9LniB3dRZ8Cfo6/trWja6YuJCXOspJoZscqrbsWt+vQHFvuBb/3EW8hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FDD5QwA3QOESJ6MV1Q5iERt20SeLfA66ApPILxGM8E9HL/sjZQSK/fgdH2XuSaycjkQ4apcXV3aLlPAcQ/mBMoDO8tH7XZNvBOz0gJcwpPpbYcZUdsAftQo1KQsxVFuL/a0YxY4CtoIwWIUoxWdxCwJV9olSu0qG+LFdfU/SjfM+19U3+EzxUBZFFZIpxfpY+ppGmKkiiSwvM5obJl4fCqW4+KYbQgAE9bTkaQWaZGPJ+E8T/f777cXVvhLpJppZbjU9K4QQI9r4E6JYAgmHH1sI3JquCjbI4WLmsobtUWrGuoY3aeupNDDRHqIq9jYFXyiBUAnX1MydRYXsYsABi4R1FiuMqNl259lqTVwJ+8xNiEHjP+qBttb3SBKHF2wqImr6mzU+8nXou4X4QOHtCPb4Hu1o7aAS/HkFH0QAqo3Q6/P3YHqqTddYkWG35uoE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:44:53.7368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cf1de3-9f2d-48f5-e2e3-08df130dfeaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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

The original logic skips RAS error reset whenever GPU is in reset or RAS recovery.
This change adds amdgpu_uniras_enabled() condition, so we only skip the reset
when uniras is enabled. For ASICs without uniras, we still perform RAS error
reset during GPU reset.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6b2b8acdbf9b..c65916d84683 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1513,7 +1513,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		return -EOPNOTSUPP;
 
 	/* skip ras error reset in gpu reset */
-	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
+	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
+	     amdgpu_uniras_enabled(adev))
 		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
-- 
2.34.1

