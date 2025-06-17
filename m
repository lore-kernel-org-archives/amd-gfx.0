Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B369FC71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535F110E526;
	Tue, 17 Jun 2025 08:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vv7gztSh";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454EC10E51C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/8JQ3zEF7OB9jtk4q3nR5Eh4dnqXvVeIqL6zXi6KcbpvtRsZapKUnZ3fyA90hCcV/m24dWyGAme0+O+9VbBjIuwb9yx1ydza2P2dX5znUnDWn/m17aYqetNWw3WSiEZYXv8P2dJTy2WUQM7/pndusamp5Zes4t6choL+Kr4K8/hbR8264JPE+5DE9mvVivoeTyw44q2e0bx7NbRiG6GUTpBKS6yhPXHMZIn3+CM1glmNr1R0baCm57zqBJCdvaxbnoEReC4XMLfzeWqBg1hA8v3t+OSSjHsWOZE8P7Sg47GFOx67pZ/NWHHQgVZKqygBNlc2Yf3GE2AdOavS6v5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91K3rUYbYtH1aMnu5YMfAn5jZ3DjOcZrqkXM9uK0JXg=;
 b=phVeeyhrQBvckCjTz/6tT5fGP7N6b4MgBmV0ir9J766Vd/8qlNeH/qtEpomdUqHXOKSR8rM+I6MmTxhiyF3NOgNuacI/BcrykxyGqKTL5Hp0hp3iU839wNDqR3oylAF1sgwuaOFRNHsAGiEyfksjgLEgQzvN476QaCSDtUXCN/1Cb+oP3VZ2q9WWGrdRlgdi4YnrIJvFlC9GpXGO/0Wwtboxp/9/W2aUgWYlSIJEIkkOX/JLhnOKaE8KMvc6+B0rrBAvrTybeYV+zlra6PiYykMp+JuvcpC6quW9xTfQYNmot+R6066GMbGYkljbpcvvGjZ2VCSu1nFK1h5uwIuBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91K3rUYbYtH1aMnu5YMfAn5jZ3DjOcZrqkXM9uK0JXg=;
 b=Vv7gztShmSPR6gD3lElhW9SYIgt7DFhfd2KwSj4zbfK7ziSJ3qjrQsDaiBcMJJHcaMqAJP1Ge8r5pcoAEokWfyTYWFfIQFObK2qfry1JVCwHh66SDseh5+6WWYkB3m6DJ0VvqXjkZEBlKm2yBF8vCJ+8odwj2sv+v1QCx/GSFeI=
Received: from BLAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:36e::14)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 08:02:17 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::9b) by BLAPR05CA0005.outlook.office365.com
 (2603:10b6:208:36e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 08:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:16 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:12 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 02/11] drm/amdgpu: validate unmap status for destroying
 userq
Date: Tue, 17 Jun 2025 16:01:42 +0800
Message-ID: <20250617080151.1093481-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bd334a-44ab-447f-ae72-08ddad7546d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SxgmjQRz0xrcIumEwsP4j3UkUrM8q8VLswIUeA7nuWOR0M6obnWbeJozLurs?=
 =?us-ascii?Q?rw+yDHCnDjF5og+U+S+dHsPvOLog+ZRaIIi6blyxrlvBRQVtlIVlKzuKxJIM?=
 =?us-ascii?Q?jYGUl1YAVWGYRuth46xqM1aPduDooyF/JLF/vJ7+bQ+u3Rhx626QFb+ZNUU/?=
 =?us-ascii?Q?acGTB916PwiqN0DyK8JeTvIMMTw0h08aPZPeILYPKyh0pp7kvgJOBxPW1iLt?=
 =?us-ascii?Q?yds8mmNytZrW3ckGuYU2v4Jt/DZDCzYuxbRtu9pWnLEZCQQLZ9tshhmkgKHh?=
 =?us-ascii?Q?54ClEbodnEHgeELKZ2VxGveeW3osXkm4OERZqLHXTEumbbJN40XXoIjMyOae?=
 =?us-ascii?Q?glF7JCfycWf7xPj9/STBfgkZY+bon1oo3pB9/P48v8OjyCpYFpKIuhaD4ttp?=
 =?us-ascii?Q?XYpqw9w1LqvI+ijiA7ZaylAcxwqiqSCSk28EJOBhn6k6WyQB6nOBeTEuDPsd?=
 =?us-ascii?Q?M+XCprKaMBPq+Gx0mrTYHBMwmtnfi4zvTUYxQzkuz/QmKEtR33Cg6NqVxxHh?=
 =?us-ascii?Q?21s1u77tExsqd2Op8ccSs9moOVmUomr/k0APEDrTzooEoeOIbuboR8JavSFO?=
 =?us-ascii?Q?Pr6RJxOxuhUiAUHIhG2KPkllJ6pxNNXTrjMFOqA9S5fbBIw7SZd/PGkRHYO0?=
 =?us-ascii?Q?lvSyFR4/SqJR6/WiW2XrWWy+8URTmAvZyVAU7bB9rLJSm2dEuC7V6hKC6AdL?=
 =?us-ascii?Q?wu3kWqCL6EHhmAjC3Ad3Avbb64R3vIbCk1pwObaU0IVpRWmk7u0wmc3dkIzI?=
 =?us-ascii?Q?snEr1HE1qJfNlv7+IDZGPw7O3mnzVRN+aU668bkuK6KT9cQeS5v0Yr8zlWbk?=
 =?us-ascii?Q?BZuqKroM/ERXfApWr+0vOKdsbQke6We/Zw2xyM3DOWAEWKpDyxApFWR7CNGc?=
 =?us-ascii?Q?WWzjHlVvNfGOd/3NOZeKI/uhi2fM0WapQmYHZFPam+5sn1nV3SeThW04fkvK?=
 =?us-ascii?Q?KnD/mBmRm1QlfdWD072VoqL5X/CNrig5N9CRroUPnHHNIvUYq79HCVzL+7GI?=
 =?us-ascii?Q?bHQS+j8KXaXgSnNteHL+mFrjoQpttNRog9ztUrM7cTxgniW+UJmls+7KT5F2?=
 =?us-ascii?Q?3R2JmX4P6SaSTpldo5o8vUAq1G43x+OjuUdcBGH8xNy5sPmRgBWSqCKcFzzG?=
 =?us-ascii?Q?WTh/sYz4yRO3GVp7bYSS9+orld62QCUUuJ1CNt0IgmnkCZuDgHLLw9H2QxyG?=
 =?us-ascii?Q?l2EbzHbQxGlLI6JXepz9rfA2/ASGvtQ2U1iPFqeHReS/JU+5nrEMU3Mb3kD8?=
 =?us-ascii?Q?N7yUf2tGhNs5+l8rijw6vyyuemuNP58K/Fsu6oOxwmNHJWfD7XAbatiBG9dy?=
 =?us-ascii?Q?lFbGM08/dQJS00cIWIWGPaNLZqdMmNGAfUD3q/AIgQ0fsEV19BFBO8rDWG67?=
 =?us-ascii?Q?Zg6YnsGMvgPbldMl6gxyZrVXGBreukLyhbsUMUr//huqeAL2sJ2kerT7soYP?=
 =?us-ascii?Q?Z3i0hNdantZKfy5C47gC378w8rjPigup6yIHd8UOpz4tp6rFY+pJcW+trAKU?=
 =?us-ascii?Q?1eMRzcQp5vFNHd9tWcGbRl9rAx2jc1xFJ8D3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:16.6949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bd334a-44ab-447f-ae72-08ddad7546d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
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

Before destroying the userq buffer object, it requires validating
the userq unmap status and ensuring the userq is unmapped from
hardware.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f67969312c39..e3cebe532c7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	/*TODO: It requires a reset for unmap error*/
+	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
+		r = -ETIMEDOUT;
+	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

