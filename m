Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F36C41513
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB74F10E419;
	Wed, 17 Jul 2024 20:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="34g97HKI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7960010E419
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7ibK2Tm6toI5VR5/dWh87frgJm+55VfOXftc9y2rGEGhMqtmXw2/bYzQiBBP4KmCmeYg/6s32r6i1l962pvOzcTMpjNQvq1JMEc1+eNnF54VLC5foXtWXni/z/QDZ90+sAh1A8jH4gj8FfZlvx7aIdb0j5RhPp5C3khgbLQ3bud4pjhjvFyS8MogakNPqzdAWo9l7o/CC18irdTSI+8LRHviX9HyrJMPS87+jreehiWOtcsEunuvhsiVEUZUucaJ6eUSirf+R2uZMeOtf4zdFtb0dzyt9RDRvvmAf8L0hPU7Y3KEHlaT7/JtTmbOuZR3aQw2fwJD0v4/zqTlDLiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN1CMUCNgQxrEDQI/S7ymdKcnUURSZBnIZ8aSU1UXuc=;
 b=t5UHC/X8SYakN0YS/HI+DRYysqZWmnYVla+4ob7TDd76oKPEd0Q4c7GFwHdh+K95Jlvpoi95kATIwWZG1FnIvwbqkeIu/RDQxYK2UI3x1mxaBlIsLQ047nla6RnjR0Wc1mw434uz8YBKx9k3XQ9tt8bH520DxoKvx5CkV0CbtoQKUjPvViH8EUUxyvPEnxAH5IjxTLL6SC6b2utlr4bkUYuDS0oGZbbtWEg/CgCF855pSYMQZiH+7y1l5PA6SLOUkUb2ev3fxbxmecicBA85OdMLjlz0/ETJb2JfGutuGtqYB2S7uRLq81hZ9gc3Lqe+V8tGQ8Nk85L9QWBe6XM+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN1CMUCNgQxrEDQI/S7ymdKcnUURSZBnIZ8aSU1UXuc=;
 b=34g97HKI5KZ8idG4NOt0Ke1rgwFapqjLfz9qJ5PGjNEbOc5VigrgOyj2kyRDt8Gcr2PVOtr34LXFQWVK3PiurABYHQK/Rpn0boTNQKbAhwuQm0uOFPvy3dXbhjEzS+9G6IFXzFfuJow5OSyuyilMc7KtJN4yiUo5CgbSN3D/vck=
Received: from MN2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:208:23c::30)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 20:38:03 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::e) by MN2PR18CA0025.outlook.office365.com
 (2603:10b6:208:23c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 20:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:38:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:37:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu/gfx11: enable wave kill for compute queues
Date: Wed, 17 Jul 2024 16:37:39 -0400
Message-ID: <20240717203740.14059-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717203740.14059-1-alexander.deucher@amd.com>
References: <20240717203740.14059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 89eca70b-8465-45e9-6e49-08dca6a05b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2u4BFMnl+tHVmKXA9f2CWPU5bqj8rkesJxOGWaH6tMEf3VY4jnr0gqVomp+C?=
 =?us-ascii?Q?ZMNT5yiBxVMuC7Om692F/H+IViKHSP2V5wCZffBUx3XIlfiWf/you0NQ48Ln?=
 =?us-ascii?Q?6jBtJEAnVeI3Y9vIXWMV4rxdU3xnzzcahZYR80l/hvVjUPe8bqwSauejJAKG?=
 =?us-ascii?Q?nrrGv1zxzZxMbwpIHCcLOF5W27bjPmVeTQXd9i+GyYgKwx//D8/BbhzmtEDB?=
 =?us-ascii?Q?2I3PyDUwVyas3mdhqbhtbxSZKuKVCqHOAWJqjnOv2NDhAZS1S3jXe2GMXfJY?=
 =?us-ascii?Q?3P3fbZE7dlIOkIQvF6bG9ZhnNi6t5B63IDPnic7b3BhNfMzDv6tgoVGdtlJV?=
 =?us-ascii?Q?FGc2XOrB31vTzE2Xeju3ruAEJ+uQJlju4jmc/DnCQwdlocvZdzPaVwuVthZF?=
 =?us-ascii?Q?8g8VmtpCi2smTfBo9VBs843LPDKfkKqkI6/vKvz6M6OAtdk3Df/EsyHGvvZX?=
 =?us-ascii?Q?LpF42/JF1dBOeHbI6XeyiIZypJsnkS2E0gWoH18zrsbcDJEXIZhCwQjqoG3K?=
 =?us-ascii?Q?iUvZJtM2qRY1vs1ddKBdJcyB4627tCresbUPcItCnOlWd7fh5/dtzKx9fzyv?=
 =?us-ascii?Q?59R4oWk2rYspi03Gq7wIQCqDP+9FW8BnVYTp4jc0VGj3benJ57YdsZGVwtiu?=
 =?us-ascii?Q?zpyGjsIynwO4qAUk7Vb813daE50DYOGduB2t2I5abaiPu4VTMABXUwhO3fO+?=
 =?us-ascii?Q?zLBoBwkbB7VS+lTq7QUomor3MOVtUmj421racDeyhdPnwZjb33POs6GRdDFp?=
 =?us-ascii?Q?+f1IhB43Weviv9CkwlfnBBxhaxaFCbSP29Da589MHHtK8YXPfTBwWMOe4sUo?=
 =?us-ascii?Q?n9K/C+TnlhQueCh5vE5dTQpaIRRvmiQ5sHj6gkudaRtTHS0ln/8oHRVm0Kd8?=
 =?us-ascii?Q?fJLzj4PFU9JaLKLSJwvxV9N+m9CQpLGtzDferhhBIe4fRxkiqrS1UEvhC7nA?=
 =?us-ascii?Q?EXPuwESgQ2Rs1AY22QgZWcP2LRva/tXGIVI1DxztFuyKaA9RMas4hhBzM+Gk?=
 =?us-ascii?Q?mVDzQP1DVeZRG0I0RqagNfJeKjsaiO3fS2ADuu53lvy1dTVzBQ8OvYb1LcMq?=
 =?us-ascii?Q?Js+ry0UnGcc3wkWwJBdCG/abbwL5RGEbedwcD8iRC6aD8wInIxfGpv4tlrpL?=
 =?us-ascii?Q?nXWtyR4SS7V2Y8aPKePqQOU8eWzJqRCsxAlSynorZDHtFJOo2QCm4rTAYjVW?=
 =?us-ascii?Q?VCOdMe1hilzdnwOXog20/8F2xXJSdgcKmDe7LJ9cmXxG/b5DMVdTAYbLjX2o?=
 =?us-ascii?Q?pfR191IxnQzhbwu2FgMEc3/oBItWd0sHf3gV+BsinRXgt4o1T1doqVYecv9Q?=
 =?us-ascii?Q?uCpM4whv/tG1X6lI74sOSKoOYMLAz4QdX2tSMVTrZsYx0UFyyWBA6l+GrFtQ?=
 =?us-ascii?Q?B7cVfolLTYMKCQglegZf4OQnIi2sY9XkDU0/23vzHbGfq0laFz3Z2OlDyT7W?=
 =?us-ascii?Q?pvNinBb5XJhUl+AZaU23O/V9USYvOFEN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:38:03.1047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89eca70b-8465-45e9-6e49-08dca6a05b05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
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

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index dcef39907449..554aae995f41 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6603,6 +6603,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
+	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 };
 
-- 
2.45.2

