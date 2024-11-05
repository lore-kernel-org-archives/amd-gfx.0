Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5C4D1CA26
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 05:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6A610E50B;
	Tue,  5 Nov 2024 05:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rEZkuuJW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8534810E50B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 05:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd/k7Q7Mwd8Lz2yDxwTCiVUbPJXYx+7F0j657vNlVmIXv5JUISaRkMhsJCw9ItJK+bBX3i+e5SSg2j0Mfo8va0DoN02YlQKrokSyud55QtPmLbBcQt4FRxFx5NOgqLNsrMAoEPNT1CmQXWCu1yfFv+oPQ+kR8uvavjVKan3rIcdRlg//cAqleq9q67UKkq3enWvGGezExQaIL6TdBQgm+t031VDpTEH/3f7u/2JHCWZs/REb9YC14ffv0jQfxGlOxP/U3yf8kkeEPuOjSDClYBnhM1Z7qE66FBdUlyDvO2F4HscY6549KcUaeOQJlW1BmanhPMGqHfVOJxNUWVlgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aazyqvyo5tusSoFnYINaktd2O6Nqt+NfhvrJ1HmE3nA=;
 b=Rqk59wKdN8fR7w+Btlt5ZxudvDGpjxjte6IjXVqUFd77A6uhbB6m1GP/999ynm0r85newLsFp5/K/rJuFiTxhzJ5fIJEkN/ClQorS5mzKzOqhIbQGod9NqKn6hiHfBz/kmaNgI+4ta9DWnWaQf1R9CfOCjeX8/DHrbwxX2R6JB89odbq/i9GBBkFCGPua1L4SDFWEvo4jz2JSHkgJLL+LNiZz+1/kTaySLV5l8WzInri2mekGeIdXqzR5TDg5KPYpCOjpRcsNNQc95RwxyBw/N7ndKGi4ZkmEsqPmOjImjUP+p3eQ4ymIt0YjPaqRd8oKZFlgtTMmZhtJzsfYk+C0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aazyqvyo5tusSoFnYINaktd2O6Nqt+NfhvrJ1HmE3nA=;
 b=rEZkuuJWmxGuy2GOZcBejSruVrDBFCnd1Ey8Jo9eCSWCN1AcmbgkSYQdnDjMG0yFUm79RbL/KJncmT2+Psm2eTbpPgBjIvZOpsxyVFk01r6c3I0nt4voUD4Pk9/fSUQiqyHQjuk1rT+KgfGCDmfEetGTTA8or8lDF+25nHA84mE=
Received: from DS7PR03CA0074.namprd03.prod.outlook.com (2603:10b6:5:3bb::19)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 05:39:53 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::57) by DS7PR03CA0074.outlook.office365.com
 (2603:10b6:5:3bb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 05:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 05:39:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 23:39:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Avoid kcq disable during reset
Date: Tue, 5 Nov 2024 11:08:44 +0530
Message-ID: <20241105053844.3242241-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241105053844.3242241-1-lijo.lazar@amd.com>
References: <20241105053844.3242241-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 64556db5-d5a9-4ccb-dc06-08dcfd5c45c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3x+tOZGo0i7Y7h2xlB/etDQjbEQUAVJm4jFdEPz4f/pyh93C1ty+QX6bnqzC?=
 =?us-ascii?Q?4CbgJQPAo0Ggw2/4UjROgHIPEJfdfCqf8SCswfnlginJe7HRC/NgtupvOhdf?=
 =?us-ascii?Q?aUIEze4GMsAZZX+GwTfoKGwkg208IKI30OOOb7ozB70zJDr2GtyaJB644Eik?=
 =?us-ascii?Q?Yiz0J/ChPvKfVMyI2n36LO7R7P1mQPyV9jSicOxj4Jt96uS1GYXRZNDDn7bx?=
 =?us-ascii?Q?zQPOxecqBfElU6vgdhLo3PFYHKDimVgifV/TGE5B8+l9UVBbdr3cnUtcAMha?=
 =?us-ascii?Q?Q0edemcS+WdnFTNYx3LOJ0FjBCvwOgVRyNetxXia92CgziX3tMM5k2/GEafY?=
 =?us-ascii?Q?7Sx7Rkyk/fk0mZq4mjw0b7Mqj3gpssC3CJPU044uyQDPOrZR+5j+/x0S/grh?=
 =?us-ascii?Q?S0DXYKPqfzZ6IFYwAek8xiJDrSSmd6jnPO9iIywtRopq7s6EDuSetdFxJzUf?=
 =?us-ascii?Q?9+hU9yidOZfWl6bEOquN4dimAoDjMrGAkdI7QUgEpb/emv3k9gYjPK5HTQPv?=
 =?us-ascii?Q?LHgRy8R+9/X+v22eqyMuEUn2ojqGOgonRZykqr2amTyC5ktdVWMEwP6pGg+O?=
 =?us-ascii?Q?SXF8oph1NXbrCZajufMcGHUi9ZeVSfkQSH5SjDKYIVI3U1o9UN/oD4UiqIX6?=
 =?us-ascii?Q?4C+JJMAVpc6pf4YEUAHwgZN1KHyoHIkRfYNcFjFEmC/E0oA9NUlabS67+dPi?=
 =?us-ascii?Q?qh+CanpKnX5JdL8CIG8fqAzmVEVVN6o5vrohri7/iYAtF5sc5tMxFVCNcCnQ?=
 =?us-ascii?Q?ZrPzDdhh4z+6ioRn4yvWJDBHGI75rsKhn6dQ3MBVZjGeWXQl3vKLE9lpxoV0?=
 =?us-ascii?Q?EuU7UZQioaFwB142Bx6SJfbP/ci7JR8RSIQHbQZ1L1eCPhm3WcG+rAUeM0cT?=
 =?us-ascii?Q?/g026nqZ0iG2yX20YdxGWNbH1XHIv6Gzc/oKVMWXtOTv1gGsOSeotag4b9BW?=
 =?us-ascii?Q?aQxlfBPKQL146xpS81ls3q0IQnjVEndVtVc+hbeQVZSDt06wjPhRvTsvdSOK?=
 =?us-ascii?Q?+6fZm3P7jkSPaiOyPD6OweT3+ilKIzS8hhkozplNAYmJHzxXoJQHchJ5hb3K?=
 =?us-ascii?Q?Pg32Q7/NCj99MFQ2IjA3n8Z/LsNS2ssertrOl39X69qC9jnsa6KxBjC/cyLF?=
 =?us-ascii?Q?H9c+RCFsk8PYozpQNXUhaLCkpGu0ijkMYtZrzPtA6W47kr7OOG/YRQ56B983?=
 =?us-ascii?Q?WVWi01BeObcSZ7FrIE6hMCx8XsArIKmdZSMpwayRoFT47Q1IXZ0WnR5n1RA0?=
 =?us-ascii?Q?oC65/HH03za+ukw6+9gLR3QAxe0Bkv7Y0zFxo4/3MYIiMor1vC1MKDdZvZ+w?=
 =?us-ascii?Q?NpgmI42fwRJtA5iACyxE8BkXF0WZvPoc5iyIS4s/3cOFBGn5wfpbrNJ987qH?=
 =?us-ascii?Q?lX2lhY0ou6PFr7xLiGdFgR/tDXJkE8sz5xbhbyIzitLuqPkFmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 05:39:52.7659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64556db5-d5a9-4ccb-dc06-08dcfd5c45c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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

Reset sequence indicates that hardware already ran into a bad state.
Avoid sending unmap queue request to reset KCQ. This will also cover RAS
error scenarios which need a reset to recover, hence remove the check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6733ff5d9628..074626650f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -515,15 +515,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	if (!kiq_ring->sched.ready || adev->job_hang)
-		return 0;
-	/**
-	 * This is workaround: only skip kiq_ring test
-	 * during ras recovery in suspend stage for gfx9.4.3
-	 */
-	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
-	    amdgpu_ras_in_recovery(adev))
+	if (!kiq_ring->sched.ready || adev->job_hang || amdgpu_in_reset(adev))
 		return 0;
 
 	spin_lock(&kiq->ring_lock);
-- 
2.25.1

