Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB103C369A2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6882910EA0A;
	Thu, 10 Apr 2025 18:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IdCMpvRQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2984110E392
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lns2ey7ky+7SoljiWtOKXkuTdx/1J9J5Lbn+XRLNnojgb+H1Nro7Ms48IwL3s4ftnUjKGUEpK7iqFGjA2C49hsidx8a18O5hZzn6rEJSuD5AgW5N4lXv5MwOFTg4XB7RErO+698WItRn6YvCkGnSRtRke2Xmn9tJNSU025bU+ITso1raMV569DbzxNOnU+yNLFt01o8ovSVf0ZTslx/bA3xPjLAqQatjdsg0zm4dTA+FjxfYV5UpWGqBaj9pLnugyl4EaL+oMkfJ7vbknRiJR0DMLyiuhXxHoW8fdPUPT1mbMZgf5I+vFDfe9+Hx6pJ2u0w9XQYTEMhPDnktSfqy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoGolanrwxk+j1GdNNT2JR/gEqzcX8xxkCWRYP29dm0=;
 b=RXmXRAm+z+iuORE89fU1pUAblcHcnXS3i5pC3JPCK0dHkUFBbf9UAHdMUZSATktloELgcHlOzMlwaK+JfYyWfKAdAlCKaZeIEx+TskQrJSekIry9MAsdynaGv4XU591ZXFP59KHkvl6MyIHtol3UGjM43+8ScqjSA7ZZEqO0hZ+beiU8M9JO3xJOcTbb0cQ26y2IEwoE6XT7dJ5qRz+Z5wePODblWPX5WvuDPPl7jkI1R4IiYf48JbhqcsknnKYN4buc8c1uwRO/CLSCtkfFBOq3F4Hd+IK4isfnzbevAAGhAl+unTCZfQXLFVwTPDDVKI04GaOQM9hLJMqIcab27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoGolanrwxk+j1GdNNT2JR/gEqzcX8xxkCWRYP29dm0=;
 b=IdCMpvRQ4sdv5XPaMU3TheG/D9sFgpK7dLwZgKQwAQZFECxR3eCRlmxQ+9MKdtuNrHguQM8RvOdTlBQIoTAyGwd1FninjrYczXOYoplHs1cXRwRybdXFvUtGvsRePL/giSeBHdNjrl3FJ24tkxgnm9PTIFxhIyXvOQdkjyk4ppc=
Received: from BN0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:e7::35)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Thu, 10 Apr 2025 18:54:17 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::cb) by BN0PR03CA0060.outlook.office365.com
 (2603:10b6:408:e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.25 via Frontend Transport; Thu,
 10 Apr 2025 18:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/13] drm/amdgpu/user: add priorty to user queue structure
Date: Thu, 10 Apr 2025 14:53:54 -0400
Message-ID: <20250410185402.2352109-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 865f4058-2c54-469b-a78f-08dd78611872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QUU4zgttNYUhvsIwhO8OgTs5q/GfjmzZ/XhEgX8q34wir0jfqETDrPoDl3wN?=
 =?us-ascii?Q?fDVma1MbYNRudCcQJDadkOQ40znuxGo0LnuWvFIUGbLc70iRYytnSnOPo/fE?=
 =?us-ascii?Q?Zi/9qh/FKQx2mCCsKYS9RBu6YJ7QoXIMnPDoTQ1P5BgfbKKgSVW7R8ApqlLL?=
 =?us-ascii?Q?pbkvI1StsET5LQmQzhctFjuHThtmPhdHE8Dk2bZSC/c+awpYuIeJIYiwUA/K?=
 =?us-ascii?Q?IcVzxIyKkg9hLz4M7mC3rZupA0cY3yC3WI5VRCAyl2bEh1G/LigJHa47I0R7?=
 =?us-ascii?Q?pAKfTJLQYelwzHj0rkTlsNtJAgFQlmG6/e72HYfNBKL1l1OUjR8bAoaSPJwv?=
 =?us-ascii?Q?eTPPEfv4GDBp6JsyLi+M0yNH6oulcTX2ednXwr0OBo4OtS1Q8musZuH99rrx?=
 =?us-ascii?Q?J9ROZe+xJ9O6K0eTJUr6Sc9YaeVTx72HH/wFzkWckUOEvXLBkgXrPgCTmNxc?=
 =?us-ascii?Q?NF7YxAzjX7PuieHXNYrEcz7Rrv0IC1W3FrXDQmhshjkO1v656kQ5WqlvC+IY?=
 =?us-ascii?Q?TsKtjEs8zKORslbcEsbB32GxNMcMHBLeoT3yBjmpuOfqKdrY3gz/lCSz+3cy?=
 =?us-ascii?Q?lSNLHtBO5liTLJVyrgUuZAp7VDZEinlZrBe5/fZesyN8encVlEHy7Tug6x+Y?=
 =?us-ascii?Q?VAUND0b2Qhyy42fOG3FcRzpj/y6o+l6xPV/QcxbCNiFEe/ljfODnoP7uMtyg?=
 =?us-ascii?Q?2RetszRhmJoPuFL4sRnUMcB2rLGMqFmskkDTpRGqPeY3n4A77cObE8DKJSXx?=
 =?us-ascii?Q?5ZbyN+T+fjNJPizn7KCtb63jaUUFBDV3wK0TphoXKsLt2iBpZCD+k+atgEPI?=
 =?us-ascii?Q?EClXqI+V7GXkdAtrPO9u1ak/P453s6jVhNz2w/k35FAnvxwqanZ+oYwHUEd+?=
 =?us-ascii?Q?frWdE9dJ6UJxcDynqZhBWgrgtca/Wdq/xphEfubTiLtXreqbEBgX2cVLiN5H?=
 =?us-ascii?Q?R9Oo24/RxH1O+/K3EtiReNhZa5TAl5GmiPzuRKgi5idYlJEs2gaYQ3xDFi58?=
 =?us-ascii?Q?nLe3XllqOH8G3c9KR88SSHOZ2fxDJu2zoERIxHdYlhwZr2dQcjqiM0IwZR0l?=
 =?us-ascii?Q?gKnXrFN+ZfJY2eWF9IQ/9ub5+e6ORhZab3d6L60M3CW4CFwDCs2geO7Np3l6?=
 =?us-ascii?Q?w7mCOu8B4w5is5JgTUO5CiAgWxwpFcOiZyU9CXCach1utwU5p+yVw0/TYZ6p?=
 =?us-ascii?Q?yNDgOp7AzcVPPLdWyxCSg8wYnDudIaKc1fC4A1RJ6awzU1/wjvl5w8PXpGLA?=
 =?us-ascii?Q?3FRMaC8XWYReRfez3enOjs+Lg0j+S1N+Q0EqNQXOl5TjIq1zqO0levZNO1Se?=
 =?us-ascii?Q?BtjkT1U0sRfrpm0IxOdhdIGEdJGkMnF3unavA2dhex9Xbasvihb1x0ZiT4z6?=
 =?us-ascii?Q?6by6bkTxyXUzGBe5KXrgc8JtNgsmtKdaJzvL8w5meeWcsMhCIWedYsEw7RNK?=
 =?us-ascii?Q?L26v5RyanOSZoVO0Mx6eeiJ5jngWWOQ15WdrHgq0knMZRtD8UD21V1tj7DEb?=
 =?us-ascii?Q?zj4947/e8CgsdX2V+KHB6SZfNzFsHwA62yrb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:17.3383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865f4058-2c54-469b-a78f-08dd78611872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
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

So we can track this when we create user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index fd0542f60433b..e0bc45e36dbc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -56,6 +56,7 @@ struct amdgpu_usermode_queue {
 	struct xarray		fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
+	int			priority;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.49.0

