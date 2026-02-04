Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC93E9D403
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 15:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5917010E68E;
	Wed,  4 Feb 2026 15:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sa6fkb/k";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028A710E68E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 15:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kovEvqxAC5UczqnS38fviegismp6TEowBpI7Prk7wQKyilhxcwc5DCSmWs/axUXzfHF5Iw0QMeQzvfkXF95NOqHR55scrGqd8YTbiWm3uXSb+feuIOECrRxxCWqaWlbaMuOHivc/53hGzyi7KGcRZd88/SNm4xwdhhoSg3DgfKIhPPXFgEjmVkxl/qNTL4jtRmj7tQgogvKYbDxSf2GbULbDLj0AJhYSzZ6U4o8dPfU94xl1+45BtryEOPe/qYCo0vyeVrprCiQ2qx1+jq6qqqo1ZEBrtr2GkPQuYlfhxHaj9PFBTnF/4yMEIfhQx4NLtsUnQmla2ftVGEmcZNSQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L04LgcRsGsr/GQr/4uhO1NtNmSfx1uDpWPFMSCmwQ4=;
 b=iZEbURha9ja06u3+Fbao6JZ9f5fnUwfScQ3K6kjxAdV1PXY9Gz88jeui3V/PUBzgoqx8EhCyCz4VJsWHU5A6/oSk+pe4QgvHnlKKzZFZsduDUcrnGjM1+xIbupV6xQklvH9+CwnloGi5aWdH5j6pQ+gOdf56R8xrUCAVSo7uCBOzYcDuDOIcNs5Z9gxt34RbOYj7L9SvU6bx8L4S4puc5aGy1HeCy+59/foX0NRQQUYOM+mFH0GV0jmy2FXCstvbho+MiglvTvieTTpYrvAKLPYaLyFF56T4tc/yQqVgQqNTZm6JNU9Qb6Q7xnECcBvnDGr5pHww4zL6zpMKxV1Fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L04LgcRsGsr/GQr/4uhO1NtNmSfx1uDpWPFMSCmwQ4=;
 b=sa6fkb/kHljwsLREaFQfLD24FFCvLa4PJWCTqQzUC1H729jCJhg5aBWg1A0rvaynGQTIyWXja4PRi+2HatmcTKKdsp+3ngCpE2OyjsBPYwm2gBYbUSecN7KGccDphq1H2OhKBnXKUcpg6wfB5kFeq8OEzzrrBNOfglSiAYAgtCg=
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 15:38:39 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::e9) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 15:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 15:38:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 09:38:36 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 09:38:36 -0600
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Feb 2026 07:38:35 -0800
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: avoid sdma ring reset in sriov
Date: Wed, 4 Feb 2026 23:38:28 +0800
Message-ID: <20260204153828.753680-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7d0a09-af03-40bb-b4c4-08de64037700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sJNyQUtQUTwmqBbdSjIpmKn2a3nwB4hleJu8cLoBKmtmTZwH8MCRh5uIRaMf?=
 =?us-ascii?Q?eiCbJ7unQOYW3zPQK+W6/U4o8Nh068WFVDKsu+qxpMediU7D+8z2bMj0NeCp?=
 =?us-ascii?Q?CZxRN8h/CYV2miXR84y6rfTG81vEAvXZ1aAjBt8rCZpEWb8/bg7ddTjnBh/Q?=
 =?us-ascii?Q?AIAf32ewQCJMkEyMS0AhPgEepcG5m3ny4N4rlDg0XOZhKNeMLk/au+PtpKj5?=
 =?us-ascii?Q?v7ReGN95n/C+9nsWEtWWonAX0iAi8EwWherXpEDtgugJqr+Q1e5p6Aw85T4/?=
 =?us-ascii?Q?Ru+Jmvke/2Y0Lv1Nc2uEEa+EeP6eAu0saFqaH6AoHYYbDEQzecACTqodqqS7?=
 =?us-ascii?Q?zTk0Hg40gsbH6v+3vFLSmTZQ3OnlLAzbYg2UhGYyj63xCEJpVLDxsLGOR4q/?=
 =?us-ascii?Q?J8uNcf0g8tQsmiGFwbewMKdM6CZiSUV53UeHgit1JBSRUenEMeokHySG0I7j?=
 =?us-ascii?Q?SMDqHYEbl5prYNFEYM+zvUX/1ydID/DA8TJAkmHOChRdc5JkkX5e3xd3468C?=
 =?us-ascii?Q?dTF5QxMf+D/8+SeRPfFBqAtcizbWsgwW1AmUFSwWbMUFGFItRoI6wJCHIUrm?=
 =?us-ascii?Q?sp4Z9gw2jPJvkkEcdf3zwk3FGBV1UMz+9m3YVkDQMkF5b/L9UtSBw8iyQzGK?=
 =?us-ascii?Q?Nfm2u3C37iRM/wAtbHXiRkFlz/oZMAt715MjAZBPFgJ9yuwETjJMqmTUjevE?=
 =?us-ascii?Q?0+HGMEJGcKtgQrCMhX5sbPhSi7R0bul03Ua8oH2S+kn66Lx2oNKwi157bB7z?=
 =?us-ascii?Q?IrBqmeovq9HlsEQHv9/lIKjJqb10f9WfhDU7aLC6+9n9H70knjCdVM6z0Oo2?=
 =?us-ascii?Q?PEVajLsX8Et6hfkWZRNd1eocjZGU+c+Jy+/Tvu3ifnEgawq4TGtIZEvFrRf6?=
 =?us-ascii?Q?10Z1oI0MnPJpotCwY/C86pzUYZJijMb5oGdvanmIjmbCZ7M+AdDPKvA4/t99?=
 =?us-ascii?Q?ByWSD8cbGdV7URVTNiXd3jDLeYmO64fmWnm9OYvLqVxWH/zXu+l9j7W/nIzb?=
 =?us-ascii?Q?kwGSOaIMgmVpBzbDbSw1nBZZbkTLEfRdKuXyYOjA+oHNPQf9NcbF7cm94kNk?=
 =?us-ascii?Q?LA0cPS8yY738AIU6poX4yvA+QsVzWSZMK2o9F/lcgxPZUqltWpiZSPakl58Y?=
 =?us-ascii?Q?IPuOhxI9qIHqOkVnRx5XRmwYovaWWTFTzuddlstH6DFE/eQdsU4cY2Ua8MjN?=
 =?us-ascii?Q?AHS7EFcC/PaRdSVEToOfh6w7AyhzQZ+Tc+m3UNubX7kw+Gb7H4HQnOLYpVNi?=
 =?us-ascii?Q?qDXpcpAGIQAmp7Dp8/kNou9JI9LCkMGREyXgD2BuKkiAS/6UuyZlhDj1oZt8?=
 =?us-ascii?Q?2PzaQafdF+IFvQb50o31ACIY2JOMp8C8kWEqEiuqInu6hlgPZBZIJpaneokX?=
 =?us-ascii?Q?CCBeTFXryGoCLRwFFiQj2r80ik/eCdnbWBo8mQe1NlUOYZFrYzDZx4qn2Kj3?=
 =?us-ascii?Q?+7Z25SPC8t3HlVBVUe6XHLY6FUbISZJiqmKKXmf3A0z8T07GpvP/0gjZMSgJ?=
 =?us-ascii?Q?DFlIXUrlg1xx4wSxiAlI+4yWHPPNl662/PAgM9GylxWU9L/A/NVPvOSieYFQ?=
 =?us-ascii?Q?m83b6kXvu/y10bIHLrRT7oMpaIvUicv+1Zvj2cRHh3Ii53anyiSsZckrwccr?=
 =?us-ascii?Q?RsKUgf4C19XaBSfYv3Q5U0Z3uDhiIoS9GWvVLee8t+oWsRzpG1vzXQwOuz9V?=
 =?us-ascii?Q?NZlAPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oezVCAUq9XjHB9WBUlzb7cpscyBM0WgZu1MOtRD9HgnVt/ZgfwR+27Bq8z/zAcDMexTWGtm76oNWjjrh8/BggxOUA/jcb0OooQfw1YtpBQfr30gTlGtVUDYHc00y3XS+c0NYuakxgbSpHpDv5GEveeGzJg0P2lxbRyVG0HBAQe6GOL9AP9vJUJ1pZaY0OztiiaESwRHtU4goCc2dKuUXmkCaaERg7sZpYwfSb1dPUvztzE/Ygw/P03i1IVo6ICku+4VAOZNcfW3c6dpDvYcupLBNNkmiHPp7KLIuSacaQbdukc23OMSJ1PYA9ApQPcFRV8YnT6gAQFVHD4Cl12mPsuff5Prd3a/tP0q8xTOa9ad5XkXxh1SuEIxtvqluN2uuP4V8jxHSR7dozhDNFVfDnywX1Y+z0z912nH5Dh4paW+6zKY4PTYsWKCwcEGEYFCJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:38:37.6038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7d0a09-af03-40bb-b4c4-08de64037700
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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

sdma ring reset is not supported in SRIOV. kfd driver does not check
reset mask, and could queue sdma ring reset during unmap_queues_cpsch.

Avoid the ring reset for sriov.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8b8a04138711..321310ba2c08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -558,6 +558,9 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&sdma_instance->engine_reset_mutex);
 
 	if (!caller_handles_kernel_queues) {
-- 
2.25.1

