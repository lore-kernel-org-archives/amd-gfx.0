Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71390E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 20:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9A510F1AC;
	Fri,  6 Dec 2024 20:07:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T8L7X3mF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B0310F1AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 20:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMlgy7Fqkc+Pz7iojFUEFT+a2Y5pWB4AqPG7RfOc+0EjWhrkK+rvMPRjmOAla4ugzAIp0/drlC0cM1IrZY7F39fyihyzD4nQkJkK51XmNkJOOt7a4lxdJt8BQv9UX4mj4HVOzxTds0CHNqxp9zmGuh1kwv07jYZjGzPNGM/4J/0BnE2QLZSI/e3KjgCzmcufMU0sB4ClPV9pGbaJMHpbwQbMdEalRPzb+7g+8wX6fBcUnXKrQFk7N6ZZlvWhLIrYzlG0UXwuoiPeJuuvWIt1vm872D5ERStjN2+qkhzkPhCpiGzt7tT3Ts4GKVr2A4S3TcaK7M8S+wTMwKxUFV9NYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIlCaexli15jnJyKZgNJuGzCN+fiaXuzNRH0bupAD98=;
 b=t91GCFGWWsIlmzWMZkRoJwZNxiVjsnijw32kygG4avcSDuWxoevlkH3VPaQCmBhxU7+bGivhQtuvfSv8trLLhAulw0Ofx4WfY+gqn1QwKHiFvv6PnDMeJEsnl/YlG7Dwi4KA57JrXmVpNebB6CDyEUfpwJJDKQsQBi3gb1fOubKFaXssj3KxIk9TRGql1xKIRpXWhL3KGwXHz+wD6X+oVfPtIpaTEUAxeoDpcgkbrOkuMVnkgf7NXUd/SNM8h5P8618JnvmlfaZho6GHBmgC63MCrScOf15YBAIO19nzSfYJhcFfQ6AlNeV0kXO4GnZW0rUqdK2KNriN/5QU+uU42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIlCaexli15jnJyKZgNJuGzCN+fiaXuzNRH0bupAD98=;
 b=T8L7X3mFFd0lwG06jloZ3eDrao5xqzz38vVbfnd6J+ZhxWfjtIyRdjvxARCtyi3pnahnh5IrfLxMBNor/bZGqQGvtoWYkWrmO/UBxAYfHGitsC2AuLDoIfNgJGi4CHXCVX1dJVurtj/KwL7rzyFZ6ko6M4D48o4jRUnM7Bdd2Hg=
Received: from BYAPR11CA0082.namprd11.prod.outlook.com (2603:10b6:a03:f4::23)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 20:07:44 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::e1) by BYAPR11CA0082.outlook.office365.com
 (2603:10b6:a03:f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 20:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 20:07:44 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 14:07:42 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexandru.tudor@amd.com>,
 <andrew.martin@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH] drm/amdkfd: Uninitialized pointer read
Date: Fri, 6 Dec 2024 15:07:26 -0500
Message-ID: <20241206200727.2771144-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: c0135224-e765-4017-4e04-08dd1631a5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yiij2oDU0CPo83x06pKLZmLu7OGvEnoig/ByNmBm7Kc84xdP9IBA6uYIO+NL?=
 =?us-ascii?Q?Wtu/kq9UcHyconC//yLXwqKJfdtRK2kKpGype9P4tGRgbnv9Xkw7zyNrxxxT?=
 =?us-ascii?Q?/C/NfJGOQavQlcN9XHyOVNN0yNrklTnKHZeMC8IHPJgEMN9QukiXQD5ha87/?=
 =?us-ascii?Q?iy00rJjUPqPTpU2mlUXKo4PGi7lgJc1fJRT4ZxRiDCfOe4LPTJlEYY31bMeP?=
 =?us-ascii?Q?OBua/BByqohukE3rKy+zA1ynd6Gz25VRc74oG+daH3aeHD2S5xE+NF5Reqlr?=
 =?us-ascii?Q?0PEQ9cyg8yKaSqrGg9gPGj+ms2FTbBkCP440Yw0JqWXDdMK+Fx2ePkKHgG+C?=
 =?us-ascii?Q?sPt9eeLJisIxZ2BDW3qAt0Gp7L05762wWSUGzbA05QQoHKLUCSAbASbSiE4E?=
 =?us-ascii?Q?8sItJqqiKUHF2u8GE3MZKwtSS3+7RdkkePebWSrjMnLDY8fTkYwcDftdFSw0?=
 =?us-ascii?Q?d0iP9BpLqLozbeXev1Im07/2zNLgbNlsIaChrm9gZohjcyoKxZ+apowIH8eR?=
 =?us-ascii?Q?lpu8ZFEogwLVrABqZR1c0uhmjUsIiktFxx2wf/dq/IcuamxKIesU1ZQIKrbh?=
 =?us-ascii?Q?OTTm6AvWkDlVVK6junIQB99utKjAy0sQx8myTBzzFj8SiILfGFMriOJXJ9GN?=
 =?us-ascii?Q?hwHbxlkp6C7Vz/Wngy7kAg/aoyeUv4sxwozxTaJHbJOQMKoMJ/0tUFJ/7FI8?=
 =?us-ascii?Q?pH0Hp2joOQFfxMeFbEGHc3ohEhW8hy1e1Hdw7V5x9M/ehk6CfFHqV+3t3+KS?=
 =?us-ascii?Q?0zz3Nmc5FQvjbSqPxb9QiCFoqSKvxS1Z+zS7kJaeO4b6BMEF1K208CvnLYIZ?=
 =?us-ascii?Q?Z0ZSMrM29+Fswq53xhUCyJS5UUOwaiwJAzzgnAmEhaS4dEiXthEfHl94b9HS?=
 =?us-ascii?Q?EXwf+r0tK6PewBsfzXMvgmbN73yDbIHkc5wa+vgopGDutbJW8uUww06sijVX?=
 =?us-ascii?Q?M1Gq7dvuOS51FQrGAmmvMr7J+pTR6qN5ALDw7nmcti4d6JWskfQtZbwBmdJh?=
 =?us-ascii?Q?Nzz6uSUZSMLTpRTbjdENam3BReeFz+UmN+Fud+Lci0fHWOhRXC5LQ7XnCt2D?=
 =?us-ascii?Q?bIWzr4ZWlBcgn54u/wkJJubYI4HwjYdgUlJbrNGTOpNAQ6BhnrMeHKY1PmCZ?=
 =?us-ascii?Q?oyu1jKOyV4P47CzZMGnqZkAA8Mii5pteJ/O31j0LyvOxekEDgiwgg4BcrxCr?=
 =?us-ascii?Q?lW/Lbxy6NCkOCNrrs/kd8r7dF9QvjABweGLiGEviNlUNwDAfmIjeR8xUhSd/?=
 =?us-ascii?Q?2leU6f+S6rMEVqYAxwJPFSxsTmdEcrJSrXdaFAohrIGuEERkZxv22HqHg0yd?=
 =?us-ascii?Q?hxteJirvE6xoHeqg3Ye0AUPzfd0ShLFOrZs9ZW7+djLDlFynAz0MzjE7p6KE?=
 =?us-ascii?Q?Yt5GSpwfvh/DGyTQbjv4xKjh+esbqzBac20hf2rdlZ+s9mvf4V+A7xDO24LR?=
 =?us-ascii?Q?7YGdIDtXCWlOBwlot3uv5m5MM+Xb4N90?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 20:07:44.2351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0135224-e765-4017-4e04-08dd1631a5a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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

This a pointer that is being passed into other functions, so it is best to
initialize it to NULL prior.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 52c6c5e9d264..ceb9fb475ef1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1777,7 +1777,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 	struct amdgpu_cu_info *cu_info = &kdev->adev->gfx.cu_info;
 	struct amdgpu_gfx_config *gfx_info = &kdev->adev->gfx.config;
 	int gpu_processor_id;
-	struct kfd_cache_properties *props_ext;
+	struct kfd_cache_properties *props_ext = NULL;
 	int num_of_entries = 0;
 	int num_of_cache_types = 0;
 	struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
-- 
2.43.0

