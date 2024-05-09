Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3132DC25B74
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 19:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A67C10F1A4;
	Thu,  9 May 2024 19:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="171HGd6l";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D3810F195
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 19:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrIMvDk2q9+frnQZSe/x06olguX1+bE135W7gZJbu6JcYmQP6m37W9XZMJget/Uxwpgd5Ji7gN46QFvlILyCvAVfKP7zv6wa5Yz5lYQOd3a9EC9wnnjTsx+CgjqNSzAOpmA9eh5Edmrk6UWyjzmu69vMQv7dxlbXDGU0UkDXnJJvrxaayDDYaBLk93AAtiiXULnZP/5m5eI464/7wV3fY4TdrK0u/QFInXU0axEiMQgIcpIkVGUo92AHPfnu10B14p2UFcncsxJQpnLuTebpnKvJBGSZxQPey172HfegyqwXBYkaEXNl9xW5OTE7uRJ9YutOyi+BOwYxGZIO/LUtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9RPAQFblv5H13ABAMwsPRzzcmWCCAqbK00Lcw1wxxA=;
 b=ZOMgIdIka2vWE0y1Nl9ea5HaWK8aeqFAxEAt02DSxtPGBJt0906Vibivdx14d1e+TKpr9bhm3bHMii2AoUgnbt1orQgiCq6YDwUPn7bRRAVal5LAn4ziAADcwg4nVrT3QJnPtMGhwyvJ7NnUPAAMKpY6iUU2Qn1eiyEaLZYOatmkxtOdG4UMB77IEaiY2wQXflw4gM+gCl7WYQ16BT9jF4D/K6zfYeDw8OFsKcvUgHLVAOrRKUZIMKKW2+MOO9AoH2j8QZnnMWgrPUUP76evgPw8bCKCCrqREa7OrxcDkRUc0bXJ5x95VTzfvGVT8OzMov9nNMI+PwFkWFhMPYHjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9RPAQFblv5H13ABAMwsPRzzcmWCCAqbK00Lcw1wxxA=;
 b=171HGd6lilSz1EmU3zRQr24XYcivh8d0A0rRaa85YIj8W7X9aZOXYyHdL2qdDLTE8KIilwpwA+B9BQMTYWyrV1rpb0aE1M2TKaTH0LzQy4TRnLlUhFlIxW/A0z5bWxZ108ioWXyd6GhUXloCSor9hcyUyxZMjver8cam1ZqpN3w=
Received: from MN2PR12CA0023.namprd12.prod.outlook.com (2603:10b6:208:a8::36)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 19:35:50 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:a8:cafe::42) by MN2PR12CA0023.outlook.office365.com
 (2603:10b6:208:a8::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 19:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 19:35:50 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 14:35:49 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <mlimonci@amd.com>, <benjamin.chan@amd.com>, 
 <king.li@amd.com>, <bin.du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH v2 1/3] drm/amd/amdgpu: Add ISP support to amdgpu_discovery
Date: Thu, 9 May 2024 15:35:29 -0400
Message-ID: <20240509193531.129092-2-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509193531.129092-1-pratap.nirujogi@amd.com>
References: <20240509193531.129092-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: b47edeef-116b-4e9a-19a6-08dc705f3b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oEVmIzqNHEoy+rHI9EKwZXJ/2A9ncDQvVAPenkiKGBCh+tf1H/4JX/EIkp+g?=
 =?us-ascii?Q?E/NVaJHDDU6YQcLML9LauKJUJOuTKidoSM9zgO7UsgzRZoH/geOR7QeGnzW3?=
 =?us-ascii?Q?J654VoZ1dmRrlb5K6BFy3dG51mOccBuzBeoikPk+riLqj49QvmG4ie/y8khu?=
 =?us-ascii?Q?ryCHiyKwLyp0pcR8P2TD8zuDSEMKa++vE5C4wl0HfOgglf/KBuC8633Etre/?=
 =?us-ascii?Q?invpN4Jg5IqJK2E0BNcCT9CEsmmS/yFfEjB/ibKIoQAzAeQn6XXQQcn9ZdOP?=
 =?us-ascii?Q?FJJOp3xJ778/uQ2cUwW9kLHs5N6uZwV4rhRMfIkHQw7Sybzj/WPsyUiZuvY8?=
 =?us-ascii?Q?LAM0/IrajRM/74dqS9Gat56FPJhuYdjHbKtLYWjJsc6MnDji9GVHc2U3TAoe?=
 =?us-ascii?Q?uIG/DXTyD3CN9kmenOsd8t75DCLPZpjKQZffyS2jDQv0vmbKazQhfgEtB5pT?=
 =?us-ascii?Q?MK4pEJCgCK2XRo+y0077zmQAUCS68pqCNCEd+TcyDnY9T6LotAmc9K++SgrD?=
 =?us-ascii?Q?7Rqjtd/0qvaAExYwkG9fVKpPkoTx1l6xQoZhkkDc/RpPC7yQg9Yegd2D2uKd?=
 =?us-ascii?Q?RUj01rsoECO8MXrZBx0J1k9z6VQKOGuRet1CuwOr+dI28/WkCm657nbYDD2y?=
 =?us-ascii?Q?7iEujVF9W9ZWEdivHvAFNjOLppoDkQkD5EDPtkU90D/2GLzhQR+F1Kpwe/Sx?=
 =?us-ascii?Q?ZXTB8JrBhmNp/1EGhCzT95AcM4BmUetVHeOnP/LA5r230xTeMwqxZNFnrhVF?=
 =?us-ascii?Q?6J6UV9KX9RmXhlkFqRA3AZrDYQcYRVHxkiC5KkhVk/sCq1uXABGnBmpE9tnc?=
 =?us-ascii?Q?rjtexiHx7JJrAYXyJoi49IlUdNCMMwhSDS0gvxcWa2zcBaQx1fKHbHlJEN+8?=
 =?us-ascii?Q?N+dMjfqbblcmPvAe/VZvJyXFuZYLHdAJeMIWW4kIYrVxgfF1V0VAT66IHbzX?=
 =?us-ascii?Q?0DCNuEtjNZdC1b61XUZE57VZuf6MFJg44H1u36Dwo4J4EYGqdo3UMFFDAKCx?=
 =?us-ascii?Q?VJTqAj4CxKxLWxlqAHxEqzg6Xj6NfVgJx9HOnMdW3ibad2IE50onDzKYhKFI?=
 =?us-ascii?Q?ErsyybYLulzzSgT1ye9y37PbfpKOahu6qeoKHsnGf/+ChPWDWH8IkMU4lS42?=
 =?us-ascii?Q?W19RdfhYRlZfm1aaRM5kJmjQeuRRWsgQG1U4WiGIH3dd9rm6bzjV/Gy2bI9F?=
 =?us-ascii?Q?PEVgYGfpVGbrSdStTNIKMalRRS7taUQMf98LYeix4x2UYK06tdumISXMsnnU?=
 =?us-ascii?Q?Q3iYnN1CBlpqjwDi4hzVVng3e2y2nN+5LoDC8/vDbQAnIJWKwKl9hBHpoP4j?=
 =?us-ascii?Q?YGbRs0+Vlf3JG6XJtDi2RzV28G9AunikE+ZKrpBynVAqRoKD+CESdkkC6nIW?=
 =?us-ascii?Q?NPGA/kQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:35:50.1754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b47edeef-116b-4e9a-19a6-08dc705f3b80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
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

ISP hw block is supported in some of the AMD GPU versions, add support
to discover ISP IP in amdgpu_discovery.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/include/amd_shared.h      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8bb8b414d511..eb60d28a3a13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -718,6 +718,7 @@ enum amd_hw_ip_block_type {
 	XGMI_HWIP,
 	DCI_HWIP,
 	PCIE_HWIP,
+	ISP_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ece462f8a324..6586feab8c2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -226,6 +226,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[DCI_HWIP]	= DCI_HWID,
 	[PCIE_HWIP]	= PCIE_HWID,
 	[VPE_HWIP]	= VPE_HWID,
+	[ISP_HWIP]	= ISP_HWID,
 };
 
 static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev, uint8_t *binary)
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 36ee9d3d6d9c..8bc2134cdd6b 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -105,6 +105,7 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_JPEG,
 	AMD_IP_BLOCK_TYPE_VPE,
 	AMD_IP_BLOCK_TYPE_UMSCH_MM,
+	AMD_IP_BLOCK_TYPE_ISP,
 	AMD_IP_BLOCK_TYPE_NUM,
 };
 
-- 
2.34.1

