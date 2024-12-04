Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6797BE7716E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16AA710E4C9;
	Wed,  4 Dec 2024 15:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5uoxlTv8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FCE610E4C9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ccqx/lem6Yjzrwe5VLfza4xmPSTcsFJhHLgnuxKPlxqyjDyHOeA9XPBGJRzmOMyz3mRKQ6TG03nmnnoZGxTUvKJ/UZ+k1SVXmnrsFj88JkcF/A4UJA3yalFtfxOg4rIAD3D2t25JkD8Y3dcquu4wCLeZDZgTKA7517VvSIr72niVzAOcUyJ5UMMONUMXL+FVhEdajMjKRNYCzYWXq9PsBuoyef5DDzwSrEbMsBlJ3sLceqPvv88X+yqv980bd7RhavRdgT4HdVxtl9e5c4BVUx6Fa5kOSObR45sgGdb5CI2/ZneWrMi2pDPaNh0pP+TrJ+ehkIpsyiOCGS4XnSG74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LQrIEzTKiwljCWrbAXkgLPoVNgw1liscc9O3yzg++M=;
 b=QwYvfHNYgnosfaxKHdSdgz82X47upq9eT1sZAmihxCLGRit1XrvnhFNBoECKA9k9I+S+1NT++Yx0TjI8KpVo/CHx6u0pFKSzOYhTRbSQqr+rPrOVRdoaAWCg/IWHNaaD7CVJqCqe68jCkfQ0kmPKhpd5rQ4yX2+RBbT2b/jbjxhVSo6cLrwRji3pggIGci2b38+Jvqr+O3XTge1HNDmQOpUSndjPTY3ZgeR93eJkHUh5eIAbIUlMw6BU5SN9kwJKsb9zIcr8iftbr7N45vKH0IXx+E1ol+lJBLFeAWS6V1HjQbQR4MMU9VJd+Em2KvhPSzP95Jmq37akKyVi1/rAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LQrIEzTKiwljCWrbAXkgLPoVNgw1liscc9O3yzg++M=;
 b=5uoxlTv8UjExLkiJfAD6u0W/ML6TDQDlYqZmRAbUhhDmng5XRG7ZcEP+iyEQLUf2OcsCQsQrxC//piX/gwMEdFwvOhcNSlUhrXwf9mcXipCDAt5vHhROMSVVcKqZlu0Ugmf61lOXt3pPdhp088Nr3wueyt/Tfsi7ULKm1EegEkk=
Received: from PH0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:510:5::9) by
 PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 15:08:41 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::bf) by PH0PR07CA0004.outlook.office365.com
 (2603:10b6:510:5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Wed,
 4 Dec 2024 15:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 15:08:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:08:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Enable RAS for psp v13_0_12
Date: Wed, 4 Dec 2024 10:08:21 -0500
Message-ID: <20241204150821.3424757-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204150821.3424757-1-alexander.deucher@amd.com>
References: <20241204150821.3424757-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bf201d-e29b-4671-ac4e-08dd147589f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jJCnr0UpIqGrBBcLOy63OhdJyA6okfhXZOO7xuwmRjzN92ZxJAcoCK867Sd5?=
 =?us-ascii?Q?WOfgA980iff6patEdNXt2nQ+9Bj114g7VQSSc4crBUjxeHWlMV989Cume/jr?=
 =?us-ascii?Q?z6eDpCAQiBYlBwWW9nZnnpbkNCPCV5fIWrGwDmABQWxRljmSUh1HOsp5oTMN?=
 =?us-ascii?Q?KfTmFBoPXFr+g4yz63T4QmWXVu4DBurZnHo+ZJkZRHrH1BloNStwWT/KsWaR?=
 =?us-ascii?Q?HOxoJcUXnhDAdIRQ5pVG5hrAWcPxQbxxuum3fDKj/1B+6tHgVmsmvjxTE7on?=
 =?us-ascii?Q?JM7NDf7uW6RY+mUHH98ga4cSlYMQa+iALMlKg74OVWd+OKj43EBt6VMs5BNA?=
 =?us-ascii?Q?/aFtu666oWcCcROoLaRuHet12vFzLEee4KYHFc5QN5M4AXJQWeVa6vSlH9tF?=
 =?us-ascii?Q?jdeTzXCIPgGIm1rv1y/fBpTdcHQSgXKLlL8PFAD+7AEewx2UZlrwcLPZehYv?=
 =?us-ascii?Q?r5vojicZ5Lk9x5zX2+R35JQqNZLr8uR94uYeTsdqZCI7dcr5FTEXFLXVXWtd?=
 =?us-ascii?Q?O6ZgLd11UzPy4D7zJAHknq33kxjJ6fD1qBab0kdKgxG1TVRV6EOZnL3e1Y0w?=
 =?us-ascii?Q?ugvF5Vnbb4mGzcUyX8w+5d5aGEdjeyiJmQ5+rip8z4apNkdtqnymRtq53+pd?=
 =?us-ascii?Q?TXV9mYYxP9BqSSrx9thoGRitbnp3UUAifhf8lLoxMWNhGU59rGXrAaOJTbCc?=
 =?us-ascii?Q?qyWFYhMalTBzhRC8D1NfvfCvQCwM+/HzbWCQbCUt4MaHBJvUGlpwyCo/MtuW?=
 =?us-ascii?Q?50CnvvEZoN9twBCw9QsDL+0OaPwW3SCqk89pJwBFjH49qZxfZAnEzfJewPR5?=
 =?us-ascii?Q?UtCdR3b/5p+lNnOe06WJ90cQv8Ik9CfO+pg7XrGAIbTgbe0yN9HgQwL//EJU?=
 =?us-ascii?Q?tpj2I33NDiZQMNTmRgNDnH+ykJcI+J1CJoubz4QIJHo6ixgBKTbnh86S2IoF?=
 =?us-ascii?Q?rw4WdNC5ygSJkpg1Re7ZowWhnbAqoPZ5en54su3Cw6qxWymf6cNlVc+4avl4?=
 =?us-ascii?Q?E4f2o0QWfGL67e1kadUcae6RnAoFb2eT0dsB5tEUEh5ZmAFuf7zci6bzM6Ui?=
 =?us-ascii?Q?f3aY3/nqLLjFh0q8QZpoqqNkxxUGLSwje4xapwglXNhIKOAvlfZN6RsPvhG0?=
 =?us-ascii?Q?5KGArFbsxlUFsPIUXDnDBcyf+BOuUKh2n+ZoXZwI+193/jKzPl+8te/4UCjq?=
 =?us-ascii?Q?oyCHh1x9Tce3A0APJ1vfYXUOQI1y+Ca5zW6MuV+owMLNK7L9odCSORlPuqrH?=
 =?us-ascii?Q?vczBDePMhGWuNADgo0kgYSBfjV63BUZPPwQBmFBBk/A5yY2TNG/gKXZZLVjD?=
 =?us-ascii?Q?4VxnTZ7ElN11uZjZUVQhKX0lHfCQ+Um/fRzvlnyG28PT1xuiW8W4py2lWscd?=
 =?us-ascii?Q?x3KQ8Bty62lL7iNouNsoqoWTqf2xH8LcU3UJyXdlLqK7rXeRkOVSJb3MiJa4?=
 =?us-ascii?Q?qq6AMsF6pCoQKIGbgSvYoHpy4LK6p4Hf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:08:41.2896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bf201d-e29b-4671-ac4e-08dd147589f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Enable RAS Cap check and initialize RAS funcs
for psp v13_0_12

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1de934cd5764f..9961ff6c29f66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2015,6 +2015,7 @@ static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		ret = true;
 		break;
@@ -3568,6 +3569,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 		case IP_VERSION(13, 0, 2):
 		case IP_VERSION(13, 0, 6):
+		case IP_VERSION(13, 0, 12):
 		case IP_VERSION(13, 0, 14):
 			return true;
 		default:
@@ -3580,6 +3582,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		case IP_VERSION(13, 0, 0):
 		case IP_VERSION(13, 0, 6):
 		case IP_VERSION(13, 0, 10):
+		case IP_VERSION(13, 0, 12):
 		case IP_VERSION(13, 0, 14):
 			return true;
 		default:
@@ -3831,6 +3834,7 @@ static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		con->reserved_pages_in_bytes = AMDGPU_RAS_RESERVED_VRAM_SIZE;
 		break;
@@ -3907,6 +3911,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			adev->nbio.ras = &nbio_v4_3_ras;
 		break;
 	case IP_VERSION(7, 9, 0):
+	case IP_VERSION(7, 9, 1):
 		if (!adev->gmc.is_app_apu)
 			adev->nbio.ras = &nbio_v7_9_ras;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 49f5d57b3bbff..cc621064610f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -808,6 +808,7 @@ static bool psp_v13_0_get_ras_capability(struct psp_context *psp)
 		return false;
 
 	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	     amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
 	     amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) &&
 	    (!(adev->flags & AMD_IS_APU))) {
 		reg_data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
-- 
2.47.0

