Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC72BD59F75
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 22:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F1C10E79B;
	Wed,  6 Nov 2024 22:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xu9CSgs+";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E92510E79B
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 22:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTLwpVgvUidFUwcHqRMBdKvl9ayblFXuLTaoKVB96s2PATV7Ef3HPywANdoEdYeEDNZ1ojHnkE6tTjvhF/qZBnrtClUuTQFBWV4rKN8Fg7vNDjy4rMeqpgUcfii5gyhyRKfkV674P4zt+frKT88FArcnqXASRLLABz6ulY6zX/bt7PRaxSlFBmzWFZcfJk/f9voLpIKPAluWTz68XRenOU1S5da2mbLjV7QIbdYNP1Iu+N36uhheQlEQROcrXrKGW9snFuReEVeFdI73Vdd8PAftin4jXK81sGj8vqwHDrHvMcVjS+QdNupMiDJusxj+YfG1cXuo9Cuuqi/bB1EqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ5CqjJg/V3ZNnQItZT9ai0I4r/sLT1QrJoEjK5Sut0=;
 b=crjk5KvgAddJLplw7SBJSOiQ59O32MkJ8ZaoD9AVcaS43QCcLQXfXsbTNBp0D0lvQkoLHbZB6o36eQPdMHCg8ZWXxKAjv13fTwh+eoTX0A+J4+pJDe+fugz3GI7ivFTRAW2IssWYvfaHteQKXHEShzK9sRkYfDjF4fEuCGnm2vxZO5aLcbI4ZgAnR4F4gHxwLn7aB+0BkMduWfOjplFv4QaNAbRrI+R1P6bPKOE54xtLuvog15fYmTYViCO8kfpfmlVAjWgVkeKxGrKEvCLy2kR/IiJdUQ+Pwk1hKcFDCrnkO77i2aHEDS+ncFBIgfjpZ5u4CV8/RodJfi3h8qIEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ5CqjJg/V3ZNnQItZT9ai0I4r/sLT1QrJoEjK5Sut0=;
 b=xu9CSgs+mBfzVUs3Gl5lNZ1atDZPHR7Xv8dJuhFJYCDqu6ZQnx0+Z5xrQL/673PXNQVeM43TMfSBxk034K+C+NkkhHrY7gzr+p2nwFInEpzTJqQ+Mcdi29PvpMEJCYmzHEvnc4KJ5x0g3zYdWyOYgYNrcf55scQ2GOWyeVN6KQM=
Received: from SJ0PR13CA0134.namprd13.prod.outlook.com (2603:10b6:a03:2c6::19)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 22:54:40 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::76) by SJ0PR13CA0134.outlook.office365.com
 (2603:10b6:a03:2c6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Wed, 6 Nov 2024 22:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 22:54:40 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 16:54:38 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH v3] drm/amdgpu: Inform if PCIe based P2P links are not
 available
Date: Wed, 6 Nov 2024 16:54:29 -0600
Message-ID: <20241106225429.347179-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: ab075820-55e2-4de8-1372-08dcfeb5ff5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RzoCnh7+f2ftbdrpnOPP1XfzrvJCR0O0NPwskHB3ZtNi8mIyhWKFlxjAmCen?=
 =?us-ascii?Q?aApVS9Ho/Sd5MP5+KRZBCaZDRJDYiyM7cU1LQFXOAK+/tZA4bv1fICxBTdlg?=
 =?us-ascii?Q?DGh8KDGjR3abSECdijxHVpmMWv5Q3FlH2YARbsiE36+BDyERB5uBZhkw3wFD?=
 =?us-ascii?Q?Bm7BVuABBkp2UhmmTTFvHbCBh0Z8ko3e/D2NaLD9ndHqbQ66VKXiJMOWzpyf?=
 =?us-ascii?Q?ZnDiOTGWwWNwbHGyJoyuipKbnQ/RilKUFpSTSe2NBdUczf+QLwBwOT3zz2Eb?=
 =?us-ascii?Q?yZtyvn2Xlq+mZLaivdZmuBj+RzDdSlXmXvQk9fwI/FwlMtojsXGfHpjhrEXT?=
 =?us-ascii?Q?Bbt9LhXUHBgZai/YT6nvT7uVRLy7KPx2YgbH+UB0vb1etwYfWjoKsXa6XTWC?=
 =?us-ascii?Q?d+5WzMqZrFg4/5E9DZtr+0TtE981b4Sd7N1eEA2Utcdw4/9PUOaS3qYO9JJM?=
 =?us-ascii?Q?gwz5RpAE2PsWErZxsF7BSlpevtC5Dw7UraFnKmtcj88ZqqHVcixhcmRRRFSk?=
 =?us-ascii?Q?lO1a3rxV4JKAFqABFP/ILx5JimGLpGV+3D7kd+lH4cIQbu+cN0Eyt3B6tJla?=
 =?us-ascii?Q?FBwQNvS6X3llOvzQimrWEXZua/+xsA4+HHfat52dydFHbJpbrX9aui5fbF70?=
 =?us-ascii?Q?FEyG6WIMUrWfjZVRl7cvaKAVRZoJ2ZiI211OTbjBQ2/g7NDvxFZzv4x9UxEs?=
 =?us-ascii?Q?MXJ1fX06lPG0pMbtnIfAcMdqgg7HRkHcnn0sYeAhu8sOX1lWrlWcsrBnyjNs?=
 =?us-ascii?Q?/QbcHR1fMrp3/80hG/AqiNIP+QipS8pSZ7EJjY+h4mGPYLmcs79MRs6SQlTw?=
 =?us-ascii?Q?T3KFmRHrmkwXVTSAVYLS6YpcgnWr4hqxcvSbhqj0PuAF6hgWEfFrELpH1ZeB?=
 =?us-ascii?Q?zUHT4mk6+LR5eP/9pxqdkMo/BSX4R5JVL77mUXLszie7MtKnewv2HXiBrfmK?=
 =?us-ascii?Q?qFsHj5qK5O4I5ZldoD8seSy0Nqvi5tA9LradWkvqUzFhBCq4K1oqG0ICE2EP?=
 =?us-ascii?Q?SCgmpnqRtaJSCtdEzWs1nCA4DxToLLITqtcX27Yb7TutO/ZaMCCe0sF2kOxq?=
 =?us-ascii?Q?PMmVqBRps2mQLAV1YulJM+rUYO76f+xPcJT5fAxXUUTphVFWJHaQt9jM+0yX?=
 =?us-ascii?Q?NcBltpqW6gnnlfmHjQd/rM939rSUtVJEMPzwYfjGCfwwThEArbzNHjwBYBvA?=
 =?us-ascii?Q?tgVn/U040kwlOTzQaAvivAIWZWdYKsVRt6kllZwcbNKYc8kKlflriXAla++F?=
 =?us-ascii?Q?1YtoOw0DbH3hfthowXI6gtwNIFS62DXMGXND1m7ngo0hWRxycFGfQlnOheGf?=
 =?us-ascii?Q?6k1Xjt7xHUOojg0ON6l4vyKaXoxJrTymg0FG/S8f1qyetwv1/xJVvP+IfUmN?=
 =?us-ascii?Q?HObH9kjNDaDY2XvxV0Y02BVD+yoKyxpDxGE9DtegoledlUdsug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 22:54:40.5096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab075820-55e2-4de8-1372-08dcfeb5ff5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672
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

Raise an info message in kernel log if PCIe root complex
determines that a AMD GPU device D<i> cannot have P2P
communication with another AMD GPU device D<j>

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 230c24638a34..76182d5c719d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6222,6 +6222,9 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 	bool p2p_access =
 		!adev->gmc.xgmi.connected_to_cpu &&
 		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
+	if (!p2p_access)
+		dev_info(adev->dev, "has no link with Peer device: %s\n",
+			pci_name(peer_adev->pdev));
 
 	bool is_large_bar = adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size == adev->gmc.visible_vram_size;
-- 
2.34.1

