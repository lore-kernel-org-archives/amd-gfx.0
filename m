Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F660C25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD8910E57D;
	Mon, 13 May 2024 09:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h7OcHLws";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378E010E57D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4LxgHD8anXVDKEEYvLZyg6Am1K3ry/Ctchbd9E+ZExOyS199jjk0OHntgNOefUx9WnnCfukLgp/Xw59ljk1zWmYFXjSQDrZYd+FkJA5bW00G2pM3GAqr4SavZwv6FwDszdlMvovh+UfHmpKJSMgk/r4p5VqeuNK5GzxPSbdTtyfTzf7VhneEo0VfZsZ/v1OkEGUkszLsNj8JS4+oDMkxs73RnOuLiB+KXG+Sq1KCEwYoPxeo9sY3X6pHaGpGouQkwKm9WKdXczkZoD+YGaYosLsq4qI21VL75dQ+zwv2fogn/k6CqohbAPNA5nUMY5g/Nc5PRu06kI3PIprD9ImKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54JrI6FOkPlbLM9+JVF8w8X8wYwNugXtDfDF3d+cOL4=;
 b=gNcfyNEfolcADZnZstoAgU/1XDlNgFx87DEB+mdK/24t3T8nlBbwE8pvAIE0fOEZjGASpCl9XkU6U+ETbH8D2ZsELfFXa+sMVM6ria+pL/0kelcZxE/uN8fT5rpIUnr8kKENhVCB/8r81wt3GtBcdxtJUV+Df0YvfuFFj6/mnjsK2t3rFylJR6kEonQVpVy9YyV8HJ9BSLxDfsLwbB3i6jeEcO47VNt35JTFkz3naJA8S7FLTFW0i0PqQUsKBzgq9KUFA8KPmQYrk725qny1PebjjjfCNQoTy6pcbyPvSOECYgZ1GKMEWBv6B43vUn0dUibLYZYfusNPmwsTAmz6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54JrI6FOkPlbLM9+JVF8w8X8wYwNugXtDfDF3d+cOL4=;
 b=h7OcHLwsZEso6zcnXga6y4wDib7xvfzTegC/DSKY5VlVfcnoVvsPj7m8PKdc03gHKuB9/vg65sUtR7VN1y00mN4EoAB/q/NIHd8XDG2ubE66iH2cJT84FOiPs4xX0Go0XCqd7gWmsl1YpTieXpM2YhUwhO6aqbzJPWCSLMJFweY=
Received: from DM6PR06CA0035.namprd06.prod.outlook.com (2603:10b6:5:120::48)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:36 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::c) by DM6PR06CA0035.outlook.office365.com
 (2603:10b6:5:120::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 09:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 04/10] drm/amd/pm: Add xgmi plpd policy to pm_policy
Date: Mon, 13 May 2024 14:51:05 +0530
Message-ID: <20240513092111.341168-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513092111.341168-1-lijo.lazar@amd.com>
References: <20240513092111.341168-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 39290de3-e319-4f34-e1b9-08dc732e166f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aEn/nGhUgV7u8mI4VP16kLcqgCkmO+ydYGmOVafjEZRMdbcgKDlMuh+/UDgY?=
 =?us-ascii?Q?F+3O8r84oOt/Oc6O6Jn2PZ2m2eOx9W9b2QeOxkKwXmuKoyQjDKgp8TACjwX5?=
 =?us-ascii?Q?t1uRpuPe2LtrOGvyQc7pKPorX0dVLS8xEXvScxTTYMwWS3WwxQi35cPuEtGw?=
 =?us-ascii?Q?3xSq4lp7nV6E3gFbL1CYpGIQWB6WlFzQlTQXylTkmEW6lWNUOBp+6JuXvl2Z?=
 =?us-ascii?Q?K/etJ9jtLtoZoXeRPcF+9vf+DJTU07PwgPCWOp8bA2nHzgf9EAO3CSWY/KhD?=
 =?us-ascii?Q?h83/bybFHEjeXycfTdHiLZCaT7W/FYuVQjlQnKlq02gTqea28/UctxEAKCeL?=
 =?us-ascii?Q?cDMW4qExkSwan6OsqHN75jzwQjdGtkMEYZrS9xD/PEZgTiq8/RE3JwjKdidx?=
 =?us-ascii?Q?2GHZQwH+UWdpXJXA98QN/ugLPf1Qn0G8/RA+ueV8sDOA3yuIzkCmdjDnux5g?=
 =?us-ascii?Q?T9ThBMWD5q13sAM5foQXwaoURci91hRZHGbkPPYVct3FS76A6bAtXwKkLCvt?=
 =?us-ascii?Q?MQLthdKq8G0vNItrv/c7HaqVz/xOQpLVS8E28Wn5kdOxNIY68MlpUHbjWWO5?=
 =?us-ascii?Q?lRWRjKhMGJxm0h73g5a5nWJfrJZv3nOsr2r6aEbsRj2GtUV3jn7QccuwC+q9?=
 =?us-ascii?Q?J9bBph7HxgWgn8ZV3wj0In1elXoJxNirOSFBQIXL8eD2dmz6ymEgLTOGwMWC?=
 =?us-ascii?Q?5r1wB4uh7Z86cOjWBN2Pe/AO3d32TtFDlUnWcgSg7w14IIB6Y+EbsKslL4Wu?=
 =?us-ascii?Q?t8HkJ2DCsyiPfnJ23UIj+bZiCZec6srDnXuOL8bdEWpz/JjUdn1UMKeNt4z6?=
 =?us-ascii?Q?CVyZWqNy5ccQeuHHnmMuw0ZzAfqL5Ka+qA+lOahCmLAnGdYZyYr7a0ithiqx?=
 =?us-ascii?Q?XZg8aWRItyR7i8g2Ee2RbkE7BcLHLjcJe8jGhH5Nm0q0w5IBhokQOqQztbmQ?=
 =?us-ascii?Q?stqyM4lz2wNFXELHKVkWnRWPA+dqYir/4FdJRVVfJOvAHwVshhXvBYrQ9HMS?=
 =?us-ascii?Q?5PCamkpe5uePkcIOmY9NnIkzMeSfFT4rPJopYRCM/GaImgeoozc3rUUe+LnU?=
 =?us-ascii?Q?YUxb9srhGLprpCuogr428gW+gAaFjT4lbMtI9K5gzexi12Sysrbv0oFqhq5H?=
 =?us-ascii?Q?WwYFJjg/toowGUOi7mhXNUkYjNki9cpn/d9ionqVwyXM+/ggAFHMnDuDbLwT?=
 =?us-ascii?Q?y9APrJ9XECj4/2GD9j8APDv4oSXEm+U6bFC1qDNifqvfT7gmQYA7tzGqvo/h?=
 =?us-ascii?Q?QmxCNBj123vxaHFGUHD8hUHUR3uNWlp9PqOVgPWgS4kXy36R0ik9Iua6CJUf?=
 =?us-ascii?Q?jM6ezo0BS/dy9T9NqXyIdOnBUubQaa9131gjNp3Ngxf/ABoqWy3kngLkWz8h?=
 =?us-ascii?Q?EhT6yM8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:36.1107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39290de3-e319-4f34-e1b9-08dc732e166f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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

Add support to set XGMI PLPD policy levels through pm_policy sysfs node.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 8ed9aa9a990d..4b20e2274313 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -276,6 +276,7 @@ enum pp_xgmi_plpd_mode {
 enum pp_pm_policy {
 	PP_PM_POLICY_NONE = -1,
 	PP_PM_POLICY_SOC_PSTATE = 0,
+	PP_PM_POLICY_XGMI_PLPD,
 	PP_PM_POLICY_NUM,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d62f1d1d6c84..48da662da005 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2318,6 +2318,9 @@ static ssize_t amdgpu_set_pm_policy(struct device *dev,
 	if (strncmp(tmp, "soc_pstate", strlen("soc_pstate")) == 0) {
 		policy_type = PP_PM_POLICY_SOC_PSTATE;
 		tmp += strlen("soc_pstate");
+	} else if (strncmp(tmp, "xgmi", strlen("xgmi")) == 0) {
+		policy_type = PP_PM_POLICY_XGMI_PLPD;
+		tmp += strlen("xgmi");
 	} else {
 		return -EINVAL;
 	}
-- 
2.25.1

