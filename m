Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36218C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4263D10F4CB;
	Fri, 21 Aug 2026 19:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2pB0VsRF";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA3F10F4CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohCJJ5O4dSrU+RFNI5oo7wZhIqhGcHbGZTvbei1wKuhs0QHMxo9MTx+fT9dct7Dc1eAd7xtwjM8wp/VdejIhdtLnJNttwh68c0J60rSLVKPrH7S1YQnkt1ejh02tuea9ncXtwNEwXdGRF43/ZjyQntT25Uy0YlfEEjdw7FytWGpoAoiyciOYQK2zPiqJnX7Sqgvuzu1mwtetS76hvwD/s4chAjfRy2Ir+SvPa3+NH02ggRToGbRYl+9Jxds699UGppiNkWmm0CJOqzOt/5LOSs4RBDknNVwUmkwep3UOYW5scsZyZn+NDvkMdW6Wrm666BSGSBYqqzaobjkC9KeaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYxpq3E7rrau+23ify0mktVcxMpZqJo1MlsJi9nPb0w=;
 b=vTKEpiCNbZeiXHIfVqy6wi6lxQoSupbBixkysQi0atG+9Rn9+f0hKMPjltXa9Vk/kPH1IctIIAIS8fWyPpDa5CzvyqLjuRiEAE4igb6W49+/4lCti6SXQHo92/Qe27wLA2qv6r65fWEoi1TzC9Ig5XIfyMq8JTjad6pCrib8D3J4MNtUiuMEWYDU7tfVhc3GeYHo0ynSdar1hobhqCEQHRbo/BLap5Xte+Q8XrYQXfa3TOCwIYWW3M2hu1CODLIFB4aFgYeZrg8lnjeWi+bCSBymGreD1qhEsVWdruX+Et5MrX4yJ9zZBLA+BedCBDiD8VRwk7LlubsAbBke4blRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYxpq3E7rrau+23ify0mktVcxMpZqJo1MlsJi9nPb0w=;
 b=2pB0VsRFi0jkWgVcaWVz5wqH2Z4ocQQ6f23f7nGP+/H/9IvEhQwZhWhGNv2cm1wYRAPnsUHV1PTxChJWH8cjUPyjXaReigx4bC1Kn27tb7Q6e2l4ac57nByeG13vrSltSoygdQDVaK3klBkXgCdpRWVlM4hLi4Scjeb9JDdK4l0=
Received: from CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::18)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 19:35:30 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::7d) by CH5P222CA0022.outlook.office365.com
 (2603:10b6:610:1ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jinzhou Su <jinzhou.su@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/95] drm/amdgpu: Fix NULL pointer issue during ualink init
Date: Fri, 21 Aug 2026 15:33:45 -0400
Message-ID: <20260821193458.808626-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cfb2c0-8cc7-456c-84df-08deffbb5c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: EV58OS05b2G8cBgvRYMIuqiJhzBXyda9gXRPU065W0esQP9JFrzD5l/xW3lEtCIqtb/fjVa9NOW3LBx9Rozna7FQjuCu09qiK+DL6pQL0rZiR86IS5hOmchqQqMRzO+58BrXLoEMROI5nJYFvKBuzJHBqZl21LMPh8M6mA3YuYl7QGTdNwJ2z8LB96aoeQmmGzjHu7jIWdKXGOiCuTRxeEfMixKE3EBEnyGKZC0ZVZxLKMl2ZM1H/ccEjoGQ2qASTYkhWzj6QW6By0yAZ6jfe/JNHMwzFK7yMznn7KXvQat/xstnXnImk5SnG9gMjQ9l78Xcj7+YdePA+WpeuyhA00gu+7ay/8Rtv9mAZRWwQVxK4x9vSd4v1dDeuRKY5VxhjbLu2vVTJkhagszhKPOPOJhX/aUUw8j4RRJeNu59CpvAcId7uNksXFDtydKbP7KTl34hf6yJW7XFlQpvL4OP1qM0jnHZAcerEr25sI04dA1X0Ji+B4zgKmzXIRdaqZzB/V69Tmw0REZwW6s4KDqCQPiuedsdgUrd/zaQ5qQwzsb+5vwxbjDhCk9CJkhJ4unxfN/k+jm00qbpWIezSmBRcLlNLbXegUkpQDhX+6JXFN3q/NgGuHzxrubWVOmmNOQLYUFq9aCejDnO1Yeu3e/lCM1GvjJgismNXm16Shsq+3liN9hT2Y8wo6vR4IxQUo2slIiiGkZr2KVCxDVmktWsaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UArzuXnjjwApbJB0b+GyuhWx8VT2IZmJD5PErseQvJtwuDgWQs1FoM+sQ7zFHTJdYARyf+j81KpBgMdnXF8ohpnhF0w72DJicGuv9IpnNh8P1TkvOHOed0kqZ1+yQWRE4Lcl2OAokCr1BGlHbQA01tEwJKxm+6y3FPy0SRSE4CtmcMeQ72MjbYT0MUA831q2agND9ydt2Irhm3KwQM92CcpvRa3uADIss8xrbRR094LfgWMCEK3qr+uxQIPU81kIAddaMll4ExPX3ggKDgLCxTpEqcnMkmI3DXkccS5jEvZth5O5o5HEIyjMjcMlJg9udewiR1ztBl+gG1B0jE8MAp2qsIiSV9tOAlRhfsurD0G3IPZZNHWbbAxdSdEhMKFDKWBZTsL8LF7zaHptDU4dPFZ7onQ1+WD1lZVgLtv3zkFzXlDYYqX2iau5+fVwK2n4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:30.2074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cfb2c0-8cc7-456c-84df-08deffbb5c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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

From: Jinzhou Su <jinzhou.su@amd.com>

PSP may be disabled during driver initialization. So psp->cmd
is not allocated, so any psp_*() call would deref NULL. Also skip
if sysfs_init failed and ualink.info was never allocated.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ca4b34ef1a49c..632825e975b27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -33,6 +33,14 @@ int amdgpu_ualink_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	/* UALink relies on PSP services. If the PSP IP block is not present
+	 * just skip UALink initialization.
+	 */
+	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+		adev->ualink.psp_if_ver = 0xffffffff;
+		return 0;
+	}
+
 	r = psp_ual_get_interface_version(&adev->psp, &adev->ualink.psp_if_ver);
 	if (r) {
 		adev->ualink.psp_if_ver = 0xffffffff;
@@ -893,6 +901,9 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 	struct amdgpu_ualink_info *info = NULL;
 	int r;
 
+	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP))
+		return 0;
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.55.0

