Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2E5CA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 02:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC45610E0AA;
	Mon,  8 Sep 2025 02:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQo4bnJl";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CD810E0AA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 02:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQKemT/gM2hZHLptxLDyMekY71P8YUujvP3cIcavjThrb4fjZreC6DQ8osxm7hpixCpZnrQD+8SlPz9LeRSVU+VOKvccjhUZtqH8bNcKKHc8DdE/uDQnVJUe5LEHEG99ohFcfoppPrLla0TSnwn9mHEGvFqi1yiHAoz+y/99M56OYfhU/+Qzt6wJdgutMWBeXCRUG+GKl2Z8xT8VCxKdqMw/zPgO4Dff/cXUfLQkXhIcbA8wqd3E0p0WGncWbBmULv7jeXDgJ2QL1ppih8KcD1BzsK1BJUOvqzCX/RpmwHlTXMAqWX2iWJ/T5cssomsG2aKSuZ5Ju7UqUIxeVdlzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s6cIiDgT/4qyfJARbsgpeGqEvYE30iZeAD6MS1+Ft8=;
 b=YbwSuRbg0PfUlKtJ92r1x4LZwLC8NjkZWhKLNHl9vZr6opM3tOPsdSFQUySKvlHkA4qeH7e7qkO7HBGD9kKBvJ2Vd9VU9YKR2FVgBmZCwKA8V77z8pihrmP5jKLi3p9CTgpTTlYOhcpKwM1KX07DwI970PaDzrrq+kB+5Mur7ehGq7f4zruQuY3pepnNawCvJVi8iZA6OpkGDSeMmkeuWSTc1mH8yXKUs2eSpW6t4K76yRhrQJs/wXx6lc00NEJXAuwOUg8L6WSIu/sj9GD5Ld6FDpqd+1L9UdlZ7oEXDRksFg/cKS0IixmVyFlTZo2IKbsHujixHDaWfNdEW2QONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s6cIiDgT/4qyfJARbsgpeGqEvYE30iZeAD6MS1+Ft8=;
 b=mQo4bnJl41ZAiPLiyos80XCjwzYLpML2L0Fyu7eNlobO7QC7hQaFBEAj0DJXVNYslBekjCGvPCbUngMT8oOcovQN8mJlC05lJb4eetIY8NNR4VrDR+wgm5UbdiaUrhyOyQPNGfO5RsVhjMlVleAso/zsgVvXrC6UDZulZVbRb5c=
Received: from DS7PR05CA0034.namprd05.prod.outlook.com (2603:10b6:8:2f::35) by
 CH1PR12MB9672.namprd12.prod.outlook.com (2603:10b6:610:2b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 02:40:34 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::fe) by DS7PR05CA0034.outlook.office365.com
 (2603:10b6:8:2f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.12 via Frontend Transport; Mon,
 8 Sep 2025 02:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 02:40:33 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 7 Sep
 2025 19:40:32 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
Date: Mon, 8 Sep 2025 10:40:21 +0800
Message-ID: <20250908024021.1857440-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CH1PR12MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: e96b1f98-9a79-43af-2b77-08ddee8115c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eAg4I7DwytU2ZMQSTSQbGxqe51jnPHaxmE46SOJNY2jBt2TU2oNB8MiLE6lI?=
 =?us-ascii?Q?xlHEen1r1Ci98o6JFjlbrUsza5RGAWA0cI0nTzkAuL3OcfOjdCbuF6RFpLnL?=
 =?us-ascii?Q?7ulpUOJPvsozr2vI2n+jlvPyjjHOiDYrO7r0K+TxTx42Luz/11PSr4RE1AeN?=
 =?us-ascii?Q?zM3Qg7s/bFAgfbGTsDOrKatejdIjkaKPjPxGBDXwP63qSOMGDNhG7Cub6Sf/?=
 =?us-ascii?Q?jqwYkMobDr+omj0p+xbhO2AKq7VckK6yXWcvI0PXWvwFYvijfDWND2mISBKL?=
 =?us-ascii?Q?NGrg2Z4Q0SMDfdP4pSPL4yGFX1+ga+HijvLg8ZM4bpkAVIGXKev8/Zi5Du9q?=
 =?us-ascii?Q?NUbmKeIJkzRD8J/zMBMM4EtG0eWfKUOhxy1+w6sCaWZILM0KtBpOlM/RA8Us?=
 =?us-ascii?Q?QFYlwN9F/S+Qjih7yFB107SSvpYQLbD5z0u8T9E81pbpzOEgq5PNJ6Q1BQ8H?=
 =?us-ascii?Q?x0AQWHAdVZ5+HeXZvaZoz/q5WzCQSgeh1RAJWSRzgKfnXOnXkfEc+Upws41U?=
 =?us-ascii?Q?5iPFzZhYiVO4tQwI7dxW4krqf8hxmW6CKyJFeHmHmOhlr41dOXgFGeahqQlU?=
 =?us-ascii?Q?0ucyUUl00JCqMFPtzgphoj3UuJ4YTL4hTgFkmRWUS5B30533RGV9pRraMEcE?=
 =?us-ascii?Q?/+Pdoo4OOTyTs5DcAf4tPRt5xI5QnoI4RJd1pcNZYf0OH1g6B7d+FJnUpXBD?=
 =?us-ascii?Q?5baB+dAflh7L/HHmtk5F0nbKat61gABpo5vPjiMn6ehUk1AVqb4YkEH34Kdo?=
 =?us-ascii?Q?1aMGc3kp7HwYvrAx1wCGfcZR9AJHP4Y/g6v0tMMWsGYD0zwceKEzxTVo97qf?=
 =?us-ascii?Q?6qN2EHFq/AeYY+LTddI+OgFFLtgqnPT5Ap8y5iq+eWPUIWTQSQK1RhTg9yCh?=
 =?us-ascii?Q?X/Jd+38GX+KxVANQRo3Iza7zkCjPm8hXzq+mWJQQRp4NgxH1kfHlqbIrz6Ni?=
 =?us-ascii?Q?NfdkZvDqRQWiUrYM9u/dTNy/of4uuyXoaG5a7xgP+UVDS6kbQ8z1eq1PXOg3?=
 =?us-ascii?Q?IjBOeQ6SteA+4ASTGVg5H5K8cACaPpMBxXlGXGSXkWdpQC4IGsC7LFa550/Q?=
 =?us-ascii?Q?6CdnphLJVIYFIoiyiknPri4E4dMXD3UBH9eK1oDyLXgD5LAw37slTo504lwm?=
 =?us-ascii?Q?mChpFlK0UvGbTTuAl82ccTJW7hWhtlgfLznjXiSJTOPi+9dcDgZ/OK0aqc0U?=
 =?us-ascii?Q?dVcXqcHLmGJ5NHo2eOQBKCkDv2KHBgi/ZwYRFQ3wtSLU2jzQNKeOnj7HRFYr?=
 =?us-ascii?Q?HGMR8qviITQt/KlQ0vWZpQl1/Pv2vyPjcjkIKUSNvGZur2O2NW2w1zLjgG0d?=
 =?us-ascii?Q?K6OIcnSys/FiZaqrj/xm8wn1P1VOehhEGm5oknRZHrSh6fFCqxbeWorBWryJ?=
 =?us-ascii?Q?RFX3O2g0JX7UxDexjec7reoFHp9qRbDa3wa/OCLutd2cEkbK1oB+fyP3GlhE?=
 =?us-ascii?Q?ofFoepoWB9IgLMc3rVM2HuSXZCC3gUEtw4WNNttShj/cTGIl1yI360Xn4NDe?=
 =?us-ascii?Q?8192q3liryc/mpPJud/BlUzzQoGnd0nfeivb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 02:40:33.9381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96b1f98-9a79-43af-2b77-08ddee8115c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9672
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

Since the PD BOs are assigned at initialization,
the placement stage can obtain the PD physical address
(PA) directly from the PD BOs without additional lookups.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 260165bbe373..fd9cbbebbdf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -476,7 +476,7 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm,
 		return ret;
 	}
 
-	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
+	vm->pd_phys_addr = amdgpu_gmc_pd_addr(pd);
 
 	return 0;
 }
-- 
2.34.1

