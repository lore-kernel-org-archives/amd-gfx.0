Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C88C02198
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2025 03:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43EC910EBCF;
	Sat,  8 Feb 2025 03:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1uyeRMZz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B0B10EBCF
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2025 03:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9VgEqU6pONc7sdDwQK1Jjq2pcW/WOWTMTJ58ZnqFKGrLBb9FzwwwWy9BUUHY4Rrd6qm2HDS+P2PS9f3rlQ7D93BBGloTklqFuu0VLc/76/ELpC3AcaCAZjZfb+DOYy6OzQNs6MMlQGeGeCYnKiALIZqOSjWeYp5dK2yRPmXtXoWkpW5MrWYqMjn/ViQ54V7LoBnxo1X2KUcfL9ag4DXZGwzuOI8P6oPTJK69pYVxRdxhrqvnTZuaR6vHw5I4L81BUcVe566dQR0IQ4aBdGOtD7MiBe4lVpePzVVdVjhmAY4VkqGqPu+FdZiXukKb9IZSnnbDdJZOIwqfyX+YP/CgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djC1UeIYB6qPpdSU1Qm9w7zUBRfvZYtYyLY32a7qA5Y=;
 b=XrtgwAR767hGc4FTwjUEfysHUamK5tJuz+gxAkzkCm3NpkIE105bMVmULEldWxD/xkVBebGXgrZfCdXuLTY1f2OEeGstNp4H8EsvA0xrkdngWZEgjisAjyQb+cCBfAsgcf60z3wi6JgMoVBz7tmSw6pDN6gaiBPaO0Zn/p90BPTBaxs1um5fKlfQI/byEFE4y0ILh6I1k89vqb14hT8oObFNUsQKvEZByrOwBseapGb0opFHgUiWjbgys/h6QrwHG3IY4oKQg7HnagFswMQjrdEzLKzcGcyrnsmiItOOrE9mTdNq6dXT6Bm0M03QIDRcl4VT7hXCM2KaG6KJ5SF8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djC1UeIYB6qPpdSU1Qm9w7zUBRfvZYtYyLY32a7qA5Y=;
 b=1uyeRMZzL8mLQnOTzksArnh3DclTEAt2djvThmG7jSnYDwhx3qKkP0OTxIZdI70vFQCu++/Z0r5FrdDs4cFdzSu2NiToPRymKY0IovgW8merzueWJRn3dKocH2QmzZy4vk0dsmXMPxsgj2T/jjLDZa2LN/M7skn3d7xp3c1aEec=
Received: from DS7PR05CA0003.namprd05.prod.outlook.com (2603:10b6:5:3b9::8) by
 CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Sat, 8 Feb 2025 03:58:05 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::f6) by DS7PR05CA0003.outlook.office365.com
 (2603:10b6:5:3b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Sat, 8
 Feb 2025 03:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 03:58:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 21:58:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 21:58:04 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 7 Feb 2025 21:57:57 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/sdma: Refactor SDMA reset functionality and
 add callback support
Date: Sat, 8 Feb 2025 11:57:42 +0800
Message-ID: <20250208035744.2455413-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250208035744.2455413-1-jesse.zhang@amd.com>
References: <20250208035744.2455413-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 766679cd-2017-4971-65e9-08dd47f4ca91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mit5l1E1FyjFOKQumW1F0Fpigp+9AnsTFIXXz1lQ2HmvZ66N+K6bR1YENLGf?=
 =?us-ascii?Q?W9Kl93kWN8DOt8j1sQbAon6e4ktbjkzw9la1FPZDgbt4SvLhmPLiQ79jd6EL?=
 =?us-ascii?Q?nX8oN6HX8gyoTaE4ecdM+LRHb8bN8R3UQKDtW6vZNs1UlfjRjpxqr2X7H+lI?=
 =?us-ascii?Q?Kc0Ywsz6nf25ETpWCwPGLgx/oxUiSo23ogiVAhPhd59am4iVX7rnuH2Sqa29?=
 =?us-ascii?Q?c/BCtfBjo6gl9gaPQ7xlu7vKOF6DtbxIB2B93kXVRrPPD8+LbPgyqLTcs9Oc?=
 =?us-ascii?Q?HI5WWG+GrEvZ1q2M5cJRHK8wsleL69LS9o5VSa30GPhEZT+TCxj/v+EN5dGk?=
 =?us-ascii?Q?G9rNvFoZsAqhUp+gJzjXKb9+r5qnNQbkKYg8HegPFDsM+Zzet/AgLKOOHaPM?=
 =?us-ascii?Q?UMNuQ4Ja4jgFdi9CiZ9/eCCpOgt+X/0r+y1FoBgT5d5UrXKy8/XLBg1SYBrs?=
 =?us-ascii?Q?g9hbXwC1YSA8bmROMK3sUFqUj3LaA6sXVyElKp4TfhQpywxeDglAVWu7OdBp?=
 =?us-ascii?Q?wZuexIyfYnrrqXOlH165leB4JZeGYQD6hM0zSd26flzWGMABKwHN+bbsT2D6?=
 =?us-ascii?Q?pKPelSWI1VKjyb76oipz0iVyWqg22rE3LQib9D9h854/KaYZO7j2N6QadZSv?=
 =?us-ascii?Q?pkzBlL/AwVqovVtEIPYvweIdnJfET1mg2s3aEcO/ASPkVvIsYzEL0WLmV/Nl?=
 =?us-ascii?Q?4jWyMzK/wiLPsT7j4qVkYvL6g6S/ARvNpu/IpfeXvoU0amaZzgCOLsZCf3s3?=
 =?us-ascii?Q?jJS9LF0knI8JGBZQAXwlWs/OlHn74xzis+KeZDa/yPBJTGEv90WPdHv+qULP?=
 =?us-ascii?Q?zQlQ+lffAPAKjsfdYzo6XRPd/kzoAxhusCowxLeYlSy3EaNCRzLwa6YunGu0?=
 =?us-ascii?Q?pGss3Qyf8mDk4napjgcLwxfjmiZBw+GiegCr5SiCQOoDAPRiB2dnZtHnUNUm?=
 =?us-ascii?Q?b7a7+r5er+I0BrQvQtvyEMpSlLsrPlumqPsQQCu06oMVDXeDwaWfoaHXOWzo?=
 =?us-ascii?Q?ygmgRUMBoK/+glgqob15pckCU0DbQ92BrhcgYbaZfANKV21CYoZUY03aw7m+?=
 =?us-ascii?Q?aCKGha6s/J41hIojdtqMCdNcHlPu2zcTK898ikDWEnw1X2zmjZbXZwgW9Xi2?=
 =?us-ascii?Q?isPQRx6uzeJB1QEP3yV20BN/wOrenTtHAwfUwASvthnE7DZxGu+obMipBC5H?=
 =?us-ascii?Q?joYgdNLGyMMd1S8TDeXx8maJ75cyDOENBHYM1sxpvK1Z9rmY65LDXvEfi33u?=
 =?us-ascii?Q?MDQefb1M9Jt1R214+qqAJFSTrgnIQ8guyJdOJ8kvExt1M6pXs9pIcleiEh6M?=
 =?us-ascii?Q?N3NluG18NmwNOS64PlMa+WwEeGJqUvzY9u7e3rdkaZXDCIG/l1J5FTcTDFsK?=
 =?us-ascii?Q?hqzDghb6pAk2I7x6HUVdK+GgQVoWP9dBrjMi7nUdsa6F5JX274JRLo9HYKJA?=
 =?us-ascii?Q?BLAhO5IG5dUmiwNeS0wx3mMZq33MTpd2VFGw1/2UbKpB5Gd/Aiad4oI4G+F/?=
 =?us-ascii?Q?wmSt5PU4DvX6daw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 03:58:05.1503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766679cd-2017-4971-65e9-08dd47f4ca91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the SDMA reset functionality in the `sdma_v4_4_2` driver
to improve modularity and support shared usage between AMDGPU and KFD. The
changes include:

1. **Refactored SDMA Reset Logic**:
   - Split the `sdma_v4_4_2_reset_queue` function into two separate functions:
     - `sdma_v4_4_2_stop_queue`: Stops the SDMA queue before reset.
     - `sdma_v4_4_2_restore_queue`: Restores the SDMA queue after reset.
   - These functions are now used as callbacks for the shared reset mechanism.

2. **Added Callback Support**:
   - Introduced a new structure `sdma_v4_4_2_reset_funcs` to hold the stop and
     restore callbacks.
   - Added `sdma_v4_4_2_set_reset_funcs` to register these callbacks with the
     shared reset mechanism using `amdgpu_set_on_reset_callbacks`.

3. **Fixed Reset Queue Function**:
   - Modified `sdma_v4_4_2_reset_queue` to use the shared `amdgpu_sdma_reset_queue`
     function, ensuring consistency across the driver.

This patch ensures that SDMA reset functionality is more modular, reusable, and
aligned with the shared reset mechanism between AMDGPU and KFD.

Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 32 +++++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 64c163dd708f..3e60456b0db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -105,6 +105,7 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
+static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1330,6 +1331,7 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
+	sdma_v4_4_2_set_reset_funcs(adev);
 
 	return 0;
 }
@@ -1605,8 +1607,14 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	u32 id = GET_INST(SDMA0, ring->me);
+	return amdgpu_sdma_reset_instance(adev, id);
+}
+
+static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
+{
 	u32 inst_mask;
+	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1617,10 +1625,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (adev->sdma.has_page_queue)
 		sdma_v4_4_2_inst_page_stop(adev, inst_mask);
 
-	r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
-	if (r)
-		return r;
+	return 0;
+}
 
+static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
+{
+	int i;
+	u32 inst_mask;
+	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
+
+	inst_mask = 1 << ring->me;
 	udelay(50);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -1638,6 +1652,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
 }
 
+static struct sdma_on_reset_funcs sdma_v4_4_2_reset_funcs = {
+	.pre_reset = sdma_v4_4_2_stop_queue,
+	.post_reset = sdma_v4_4_2_restore_queue,
+};
+
+static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev)
+{
+	amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_reset_funcs);
+}
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
-- 
2.25.1

