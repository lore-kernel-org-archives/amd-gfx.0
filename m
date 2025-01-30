Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD15C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 06:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C547210E8F1;
	Thu, 30 Jan 2025 06:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpACUwhi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1931A10E8F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 06:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsU5dGhvvmkOrMzLbmnTuHdxo9kEQBIKeCO3MthkUZbFaaWFp++PjemhvYfiMt4OoVS2hhDREMAKGSKAtE277rPM00ddooPWxw3oIfy/Vvi+a3JeB9xKngLcU6IwaQmlzIF6bGv3DFkfb1TsU4Ti9sbPr7eqY+rz6p/gsqNgUqe124m5uZ+X1q0D351xfrsSJDk1Epk3XKhx/awTahgl4EUsRhmj6CmChH/IutyBeQZ0TisO4k6EdOdU6TLcI4pylZ5lTjoFyFIc2rVW4WvgWffL0HCP1uVqAXxtqE9b+GQdwlLAcyXQsIotiF3wq45Vv2zk+Wty7XrciQRGsZKvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaTVaNKJg+vv3lxPWgHPJ7d3bDSoKFfzqkHfYHBwP9E=;
 b=SOkz57vJ+tJG9eMwzNWKXtHCVsJVqoMqP+NEPMHM7kS5bvgSM7mdfkHpE2jGCHtNfjmazRCzckjVsaNYJUIGbj+9n3hMaYoj7rKcoMvGSabvm4cJVUnOTezp5wy+7ryxlDAFPoGRuCeabPEZvOKeO5WpeMi8qF3IDo/vaTyzwSgM7jNpRr1quE2ExxSIBXN72QQ1yLw1DYWoRx/C5vV5WuZzKz92CLWQ5r5PJqRNa37Yo0N55MCs855mpff+iIetz02Z7fmg+5kKx5VpDIdPcsSlj8EvzlcZ2xO4qNq/6d13RUsouPHj93xJdiYptmtp2DcOlA458TBNJWwo7cnUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaTVaNKJg+vv3lxPWgHPJ7d3bDSoKFfzqkHfYHBwP9E=;
 b=YpACUwhiF/HopZ6j5dtcYawbTnyoQJ5E6dh8oX5wlhQ9sT47zLj42GF+SMa7iV+lrpUXRYwnJqkHlMMQN5NujXww8M4ua+ovPCGbUpjz4NT1nBzLYsUrbmCZwo56gofY+sBWqA9LpSF5NNUv5Nmj73BSqFRUnPrFYR5aIeHl3xA=
Received: from BN0PR04CA0149.namprd04.prod.outlook.com (2603:10b6:408:ed::34)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Thu, 30 Jan
 2025 06:46:05 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::d0) by BN0PR04CA0149.outlook.office365.com
 (2603:10b6:408:ed::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 06:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 06:46:05 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 00:46:03 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: update ip versioning for nbio
Date: Thu, 30 Jan 2025 14:44:28 +0800
Message-ID: <20250130064429.2215628-3-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130064429.2215628-1-Mangesh.Gadre@amd.com>
References: <20250130064429.2215628-1-Mangesh.Gadre@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ee73eb-7c37-49f1-6b46-08dd40f9c50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7dJ30ECobyp8mjX00pzye6SoF0AE5+9a59xZTvjN5LTwXseZ7lYt/6Vvz8Y3?=
 =?us-ascii?Q?HNuf/fN21ZoRkOnuV8dzk1J7Lg3xw7NvIRhqgg+lLIJzShrDJXunUNxOH7k7?=
 =?us-ascii?Q?63uQk3Ufjo2UtU4JtvpYYDnioM6ePkTEipdX7+mNCxwZuTczMKV0Lvk7/3Fh?=
 =?us-ascii?Q?5IiKF2bqihY5HC4J+a23Rg4XT36fxF7J87vm1M4LMqgkHtr2OoCIKpD9JmGP?=
 =?us-ascii?Q?9jTsAZz2lk1dgBEEaWnGjjEwcTH4mVu+MkyoxUDp5FrcINLg26d/BcprEwGA?=
 =?us-ascii?Q?1zB8lgHZqGZ6JPVbMD1XXmdJy/5N/kZhX8Ocww1yBFsHUpxu6WOjHtjdDapG?=
 =?us-ascii?Q?/ffCm7WRjdidUL/H+POkDb1YFeIyQ9vIo6kEF6wwpw1th99jlshHZZYYPg/Q?=
 =?us-ascii?Q?hlcxxMC4lC0I8sihr31pBCK6WwGK+Rbjedcy/ET9M3qognxRuVmuhPoUG9n7?=
 =?us-ascii?Q?rXIdEZNMh3kLelyftJtCRW78pOY32BkEUZzgmUCy3i+USqBNpnRYTmOnLrek?=
 =?us-ascii?Q?h0ksSrS3qliCscPgb1oTIa1oM2t2TBELS12y9JmE5Jr1//Nzwg0S8jibgNG9?=
 =?us-ascii?Q?byA3lWleFoX/WlWegcdEYO/mutCpZp20GrSFtH6rz/clt14U8mbfqFQDhbFA?=
 =?us-ascii?Q?Nmc5tlaWPY3FaiQY3OVMcdmPOrYvokn4nzzj8HJCv5Iv3J1Sa+PsEUsnpSCE?=
 =?us-ascii?Q?iuNdiVJ6UW04iv8EiA7u8EX7BeERRHAeU7qF4UdPfuXgyjZIfnHzLDxcpQR1?=
 =?us-ascii?Q?+EbYW/7JqrJAewawaOjDgVMQ5bPyAzyErO2mAHN/Bl/+ruSf+QSACzhLsEp/?=
 =?us-ascii?Q?j6aB8mS/2Mg5WAb3/ON/VoiZlQ7bL1SnbHMYD99Mvs171EkyNik9RUK9W9y+?=
 =?us-ascii?Q?RRpbIJ29myva+mE6FVC2T2AYNJZVLOFBwZdKzkD5XevneXX24+IkqdKvn2rI?=
 =?us-ascii?Q?SNj+wii10yTFldssa00ySWKSDQY21IN3DGUqPnTlux86CW/PwIusYqbwI8Av?=
 =?us-ascii?Q?2/OTjWOBQ+wA5vBDFOyyqBcv72GO4JSmoUzcUfp1Fxa94Ua427SxjhgMJUDF?=
 =?us-ascii?Q?b/P3uQ5UVQ7M3eOSZRMnGcBmlNT8+jqowolK3F7um2xzEAgJDOQ4EwbhFbaQ?=
 =?us-ascii?Q?UPNEsdVODM7dEuo3JuSBog5XIcXp94rtcy2KaU4cQ/vAMSzD27zjzurNNDAW?=
 =?us-ascii?Q?ypazyZJt1cyiP6yzuIqQKk/wOXwgo3dL4xBnCrmHUU0KMqImscoDY7K9WMfS?=
 =?us-ascii?Q?F9Plq1RF/w9y6KqqnicOKF05+JzRSpVPqCyEgP5WBqKqQj/Lf8GrNnvpT3QK?=
 =?us-ascii?Q?sSY8kwbNs2a5RAO3KY1P4NuSxSfF9J/G213RSOZ+1BPLcdxGbTvc+xKoZvS7?=
 =?us-ascii?Q?0Ji1lxWnP2ikdU2joGURvsqhuk+mN1XX5rQ4vxRkAf0YqrjmxFp6ZHgJUidb?=
 =?us-ascii?Q?5a1xRfAXREYvRG7eVGkwxjjZFnIJUvHsWGmnyGxOZxy/ki4Cp3WMPgzaPcWM?=
 =?us-ascii?Q?rtHNejh3BqeKEVo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 06:46:05.2682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ee73eb-7c37-49f1-6b46-08dd40f9c50a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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

support nbio ip versioning though ip discovery binary

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 32b809a4b658..3981b8dbd73c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2777,6 +2777,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
 		break;
 	case IP_VERSION(7, 9, 0):
+	case IP_VERSION(7, 9, 1):
 		adev->nbio.funcs = &nbio_v7_9_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_9_hdp_flush_reg;
 		break;
-- 
2.34.1

