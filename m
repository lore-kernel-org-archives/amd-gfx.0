Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9EEC88E43
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71C510E1ED;
	Mon, 26 Jan 2026 03:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Q3ZxaPD";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8337910E1ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py5zCSY8YahHsME6h082Iak23lHfvOaQqJalZ2hUQD/L/EpSq+mzmboAEWROdF13rG/bdzRyNYmAm16nlP1Doa43eEmqDptaY1doYMubog1QUS9PSM43Sw4h27J6z9qw0yBwu7BLOMJmQU/tu+TcL7lAgYLeFA07hqkM6NoMzAsAPXdCcfeYjkWLyExqiZWMDdirWgFtJ7inR6Df2dDlyGIsyWCm66eMASP1j5JHEqw/bRTGjQya0y8RX1ZslGtDX739phLWQb2I7DKEB16U9UVV0Mb9aKi0Ms4421aBrI4q9J/KknEpQ+eiwlvoQgzC3UYK1nTcQcgQn7yb+1/3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr3mkCMz/UKDtFai7fPcDsdGKC1iSVO3eVbVqGxwqVk=;
 b=e6DPnBomeYIBwrJul5oPQYpoib2jb+GgpuSxUTzkV2mxSZR6tIWIxXg58WFhpo3P3+hoQz67pEDM22yxiYBf4Gb9BSffZkU3N+831O3lTmFrQKBEWL845Egt4ZPNRmAS502lLZS5nq1MpbqTGodFXnqZb/R/xZf1DoWlNJL6WLEJ2xtW7NuHxJEHeAoYvnQcucFmF3kdc+rvyBHDGMc+Yf3654PTkHUNGigjKGzz3biANtlZ+A+IJKR0ZYGMoeDO+zeSjWMGzZZTrhrXjk36AekAa9LTUW6nwKNb67qd8mZIGmk3/AXYbGVi+47IZKXlckkwqkQKPPbY15npiQLXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr3mkCMz/UKDtFai7fPcDsdGKC1iSVO3eVbVqGxwqVk=;
 b=5Q3ZxaPDGP8tRR53RR5PyQMzrUOA//CSmb1n4aEoQmgdkmacTrql7YaA1bA3l1Y+UQjz2Yp6JL/kDXlyyqWwN4gKYC11y0I3e9ZBP1FRu4lpQtwHKNsGup6+twsuA87jyov2dgycUOcUJLlVZd66vEIZP/MdqD1trHKcjhZ2xcU=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 03:55:49 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::73) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 03:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:55:48 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:55:46 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 02/14] drm/amd/pm: add feature query interface for uniras
Date: Mon, 26 Jan 2026 11:55:15 +0800
Message-ID: <20260126035527.1108488-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126035527.1108488-1-ganglxie@amd.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ebaf75-d57c-4196-2096-08de5c8eca5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NU40Y/ctq7ME8+iB/1Lvszuqb/XKCjbY+7PQs5lYp6E5ikLRfYTeVJsbAJXG?=
 =?us-ascii?Q?jRiP0beufH/Rf/y9/7arT9RsbRhi5+2LM7rvA6Ax2I54J2ppGoRVuE/+mU5t?=
 =?us-ascii?Q?eSXY53HGf2tO2jCkPqOaqdyrdb/PjfWQa8XQtM8Vkm9ZZ//qkOitHn3q9P48?=
 =?us-ascii?Q?F4vjQx/1Ke7XQYsLF+YZOPfh2DinUtG9E9t1WKHSY5wrBTjzxRFzT83EIgRl?=
 =?us-ascii?Q?LfkUDUlNUMKUlpOVbUVkvCjMnYhuuSf0LfR3An965bmgl0f2OWJfa4+7NAlT?=
 =?us-ascii?Q?+MufQx9UcOeV8EOMJIum7vT2H5bKsw1sx8NXusbi87fGL+tp9hzV6I4WB/qe?=
 =?us-ascii?Q?eTH59tD/vkzDyOB+eA8RtpZy1tNPu7sEgcbESRJo/PMj2Ej1O2DQdK0vodRx?=
 =?us-ascii?Q?hXdJuFCct4dx0YPr1fKv0B7mglnDgQS5Wxi42wY6S82DVtqFYSnBZS3iyzA4?=
 =?us-ascii?Q?Y+NFp9cdaI2tlH8GaYmcQ5RnVeRf7jge+84iTbeuz55TWX75WbzzKz6kPCNL?=
 =?us-ascii?Q?BuQom6/cvdMFrkr9z9JdxBzvWW80UWM2dh66GUk4pXkAH02M0okVZI0zuVle?=
 =?us-ascii?Q?imzbGf/lYkUMFoMoQnumgLmsFQAqQ33tTESGmo5kzg84u15z8GHsc58S0IHp?=
 =?us-ascii?Q?SOQ/LX5D17FxLMXk1mKZEObm8tuLnxhQfPNZhybUFCL3FK5MWaRJLF2rB9ql?=
 =?us-ascii?Q?Sl2A42W2bAdd9d8ItZoLHC7vnm/IHYBg+Bc7gBh2A/3fb/71WEPA0zA+FafM?=
 =?us-ascii?Q?0YB1mhVZkfxP2Uh4EJi2H2T2wEGs7j71Mh2w3oYdvI7o3t1MvzS35ndCS1NI?=
 =?us-ascii?Q?BGX23Q7Re9QHC+oucI21zLDvozq4xvwZOhQ7JbBbPpErhezlqWf3+E2WjyRI?=
 =?us-ascii?Q?voV9+9FW61jO8BqA5Hbu5VPRcLfExIDNWREf6Kn33YOgsUPhaFTiZwPkEa2k?=
 =?us-ascii?Q?0sdfn78dvOe62tf3aKhaa0Y0Gj9j1zz8FFpeRXqlhEsLjoBOCavunuwgONeR?=
 =?us-ascii?Q?ZYRwLXojOl3w/MaxFP5d2rliUnluKWIn3R4aHmzKwanMssIB2PUZnZu6cQOk?=
 =?us-ascii?Q?m0yJHxRCXgWhXSY89MMBrA/NQ1AZcPcKeeetPM9YljiK/kcGjosjKjtOQWuH?=
 =?us-ascii?Q?AXiN4Z5PhYqAEzI2uxwR5bQ9EbJnKYZaA2/9HUzniBMQ69J1QQRAiI5vkl11?=
 =?us-ascii?Q?rW/qcJQQOCqnVnsrtj00nJRbuNPPIRUEGiOCYtKn96ypyQZYRLsv+iKP9X2r?=
 =?us-ascii?Q?zYhAwvJQjC04nVdoz4CMuq340cgJr8NPEJ1D4VUJDYHnA1F8VIOjqRKXb4Sy?=
 =?us-ascii?Q?PqHzFlXrLD76pJWrkwsw5RnmKrt+JOPV0yBaOzDMexiwRMgozPZlW7RPYjB6?=
 =?us-ascii?Q?dUT0ns/5/3eU4Di/0mLiqULiNAgaz/IBC3kv6OuaOIe0gQsm6mXS63Apypjw?=
 =?us-ascii?Q?GLClbmv7ovTfFQhsHFPKtQBHGarI3z/0U2RWH1to40mD6Kc7qEw9JojVz+Ot?=
 =?us-ascii?Q?dWzZz8C1LEkKcrNJdJLLnmc5Qe9UWsl2HBLF65kH2erWe3MtwiCoSMTow1TM?=
 =?us-ascii?Q?SCc17v9NDQavWj3LvYMpTJe/socjBrUx+TKUrQq8Rl6w3P+AeVnuOFiLx5wO?=
 =?us-ascii?Q?LRcqjCkaQRRIkPrzXuJ3UFQV0XSIk4fbTNDgZQCAxq9ag7lCycIGOEsg33Up?=
 =?us-ascii?Q?W/zV0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:55:48.2713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ebaf75-d57c-4196-2096-08de5c8eca5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
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

add amdgpu_smu_ras_feature_is_enabled to query one feature
is supported or not

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a15670e561b5..e2bed345128b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -624,6 +624,18 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type ms
 	return ret;
 }
 
+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+						enum smu_feature_mask mask)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->feature_is_enabled)
+		ret = smu->ppt_funcs->feature_is_enabled(smu, mask);
+
+	return ret;
+}
+
 static int smu_sys_get_pp_table(void *handle,
 				char **table)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 4d5dfd936ee2..ba8c85f7c90c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1843,6 +1843,8 @@ void amdgpu_smu_phase_det_debugfs_init(struct amdgpu_device *adev);
 
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
 			    uint32_t param, uint32_t *readarg);
+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+						enum smu_feature_mask mask);
 #endif
 
 void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id fea_id);
-- 
2.34.1

