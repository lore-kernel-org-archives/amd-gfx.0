Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EB1EE498D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 10:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6542C10E03D;
	Wed, 11 Sep 2024 10:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CSZJ2eEC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E88A10E03D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 10:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8+NZC9wBFDkd6oO0RzYAGGZVYOEz2VAl8wb7Rtnrz0c441mVteQKfq4bw9FOWyp0Kv9vBbJav8aEzSeFv/kDJJHCKqYRbftzrJ4b2WW57Zat6NCYi2NnlOndZXK6RQp99tby0iGR5pssHDp2khLDOnjAnyYyrpserjJ9Ce3x3bc6RH7KoyGf9lFU5KQIeD/KqQAKtBHShkxXrJbA4BUO7Ll1shwr+b1NxsRJ3CO6h7VpTixeaM0DJHdpZAgpsKv90OE5C9pA3TO/157C1aKXMKPxMNcgCCLbXVv6eTMYn7LBh01Pp/f5yyeX5gQNpPaq+8M6PM4fBPzjfxweaOt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaRM2G6fgGL3RDWBM5+1FisW3JbpRoqdr1FngB1xaWk=;
 b=xMANg5cNIgwjHqRkvig7BaSISMZkHkZcmj8Of3ONctafOnfB9Xbp7v7ojlnxBa4G3/YWEGXQOPlexXWspLYQOyq+KLC+osMcN57FMZ6smlTRhsbmrGds31cKN4VIOToS31NeAmPPoRnBGK2XzR7oEuBElwHVYSt+537oBfslXs8FqzxTc/0vQbHe3M3NvwVO/l/AntXG2SK6GlokiX41J2AxxV9nITVIGbnfc4oHkZ2N98OGjesjEXEw9WUlKXEZll3KIvGxY9ik+txeUBCioRT/qvD7wCkkI4dAaJnAWq+gsUXh7B4XGd9QpCruzxTTHfpaLcThWZeTWaby+LbFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaRM2G6fgGL3RDWBM5+1FisW3JbpRoqdr1FngB1xaWk=;
 b=CSZJ2eECS1QE6xiuyE7rVpERLxaJivefdz/kdWiNLcPv37OnSFa7VAyms9xOVqgF5MsvSYwRaZIOEqLmxWSxP2JbPbgH+51TnH52Lnd3maEi57c+RchLRQ5Q8Rv6ugqMKjMzYLjTp+G426BCwW3+A44blI38fsr+m2X0K5ALn48=
Received: from CH2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:610:38::26)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.31; Wed, 11 Sep
 2024 10:21:34 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::15) by CH2PR05CA0049.outlook.office365.com
 (2603:10b6:610:38::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Wed, 11 Sep 2024 10:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:21:34 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:21:31 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add helper to get ip block valid
Date: Wed, 11 Sep 2024 18:21:16 +0800
Message-ID: <20240911102116.2179936-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 867bbb7d-d4ab-46bd-cb29-08dcd24b8316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bBDKUBXfe5PbgDwqpnoBgaaDKUr4INN2mT8UQMCCI5ht066FCtL4+5mjC2ff?=
 =?us-ascii?Q?N2aq4Aq3zj9PIzlskhAVeeWDrNtYBoCXxuN49KoY1WTpauKIdwLWi0cMc9XO?=
 =?us-ascii?Q?9SkNy7AxGlXR8dM9qfDggTW+J1sIjqd+ojFcgGS5Z3ClPq5wPjswYWkJXalr?=
 =?us-ascii?Q?jAk6M5qINN00Dj+siIaemCAVuz04waqjQGDc/EyDb2Azhq7PFAuTlv1KAyWB?=
 =?us-ascii?Q?pn8QlRkhHkW2UpnRmhAOL3VOYuM0giTgMrWdoqZP7Qtr5/Nj2U80lVkw5sAG?=
 =?us-ascii?Q?MZahc37cyvSWO4Ejoap657QrldbSN3OuTqmEdk4cNtDb0V6fZHTshjTuwjyW?=
 =?us-ascii?Q?875BIO5Fm0GUMqfN1o2rmAuH4To9vEZFbqbDvgOyhQImAvcfsB5tLyWoHOaE?=
 =?us-ascii?Q?aMIX7Qhk6TvbeNTfYpIi4SgcxW5CvxiFpDHdj4T/Snz7TsvXoAeJhgEuvKK7?=
 =?us-ascii?Q?JNMsuPtv3QxM+pVM7s8AZDLtyc8BUaU2HUZl6nPK5keSYVE2FgwK/vVcHwgl?=
 =?us-ascii?Q?AcbrGYS44KntjdMWnccod1Uqz3PYXTDGH2MNfhLsqfRL0qLNz56904+HYT0t?=
 =?us-ascii?Q?ZH9LSBM2vO17JEUudGnWNfkIj+hhKwY6s2f49nAb2zY74lPqylQeEZtaksqX?=
 =?us-ascii?Q?RNBl50+vf1N1q/CUwG9gvtty2ruGn7YkzLr/PHLosmNkFl1wqJywApwC+YZc?=
 =?us-ascii?Q?2V7XPD7Qlxd330eetxUN1W/TOEV15A0ZQSGaVW6pfnLkwTRABsQnFD6/m1DX?=
 =?us-ascii?Q?McC8dPsbUcFVDLjs1fNkTTCJTr6GvQzSF4aIvKmza/iWuGgRmbveYUts2iW4?=
 =?us-ascii?Q?7WcmtwjBuNvNeG9uUr4Llkd2wsm70p4pkIFpTePMjJolt846QyD79RETSxk/?=
 =?us-ascii?Q?KGYQeoUwT68Jtdl1THhejWAg45sUkgXynBnalz4LwD1SItJCCHJz33ZlGshx?=
 =?us-ascii?Q?Sfvp4rlE4aNTLHLIKT1k+pU3H5uJgXMYAQVDtUOH3FvsBRs9ao2cMC174TRG?=
 =?us-ascii?Q?4A3ZVhfv+QTIK/K6gmmrWXaWFS9jU1DHRLoVpjzhWR5KeiF1dGsShsqnfdNI?=
 =?us-ascii?Q?G+lGY+ZJD2QaA+2BzW4+gaLXmgW340INzpJ1xEQqxc19YClyFwn7uMmmrHdE?=
 =?us-ascii?Q?QqaefJbkJkn/gJTGy6Lz4zT072P3c21Vd1aCCaPPp+hJ9FiJstjmlhaArMtC?=
 =?us-ascii?Q?PsYtYf07f7qK2SB1A74Q7af0cRE9YHFb8zzFIIMScwva/phy7NRDi4yv+VhX?=
 =?us-ascii?Q?iG/J5IWxK7qDjguUILezDgtHgeZmGK21E3fvwvn0DjkyZh75R11iUwLsDDmY?=
 =?us-ascii?Q?DjsK6gZkqpHrXqk6okhvvJM/PPWFV01eu4vTOzoqzWfnH7UfxucFJLPQSbeO?=
 =?us-ascii?Q?mKdey/fOtk7jRZ1PDQyNUZcyv+DafFQx+6RYKJGVeCIHhGcRmhq4hQeYYwmT?=
 =?us-ascii?Q?1tDNm7RmzO+pfZ7DetxhHa5mnsXHEwC7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:21:34.2363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867bbb7d-d4ab-46bd-cb29-08dcd24b8316
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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

Add helper function to check if ip block is enabled

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c6cdabd60a4f..e21122dac1db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -367,6 +367,8 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
 			      enum amd_ip_block_type block_type);
+bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
+			      enum amd_ip_block_type block_type);
 
 #define AMDGPU_MAX_IP_NUM 16
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 61a189e30bcd..22585f970f43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2193,6 +2193,28 @@ bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
 
 }
 
+/**
+ * amdgpu_device_ip_is_valid - is the hardware IP enabled
+ *
+ * @adev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Check if the hardware IP is enable or not.
+ * Returns true if it the IP is enable, false if not.
+ */
+bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
+			       enum amd_ip_block_type block_type)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == block_type)
+			return adev->ip_blocks[i].status.valid;
+	}
+	return false;
+
+}
+
 /**
  * amdgpu_device_ip_get_ip_block - get a hw IP pointer
  *
-- 
2.46.0

