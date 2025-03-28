Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993E6C36013
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 18:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF8110E11C;
	Fri, 28 Mar 2025 18:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f+ZDxYP0";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C6E10EA66
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 18:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULpBCDtTv9jehuNTtUdEeqkJZSS9OXctK8zqszhyRT2wqxd01rmymmbxghKnEXL72jCj9EH+uBnkrPjoyod+pQrod5Gupeu3YeLgKJG+BE1pQ9ZwiCSnKuikQPqsq7nEtTqxM5L/sqRrih5ma7TN9i2HlyG9cCrX8Qu/Y6uZAgAfB1676yLo+fk5hQd1pjaF/ZcXPc+uMjj8fSSKym5VNXJSh+sSAKvIlidydXoPgSXe08KnydXfnISSxjAzq+RS6kQtxTDIxvqKNF8M92UtVb2G3ShKFC2ZPO8fOMo+DgkIxfTIUegbaMCie1aDJxKEklFMWF6aHJfuQnjcPp6smw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcxY38yV8J5Ii/Ouym66NucRwmtiU+J1j+ko4sNzjtM=;
 b=andZD6M4nVglOg51qOr1O9udpCA/l4f7OMzmSy0KVw4ftxRitCpVee5pY0Q//VPA9h+Zh/yshiQKp9doOI/FvA5sEqknyc9Lvdgf5QoJKBhWrbLhumlxpxqNw+o5Am0SpNNXWUkvlktOc8iOmQW7eR2os2TP4VOsdiMTV2hn+kBqc5MKmTUmTZY/uPU2ieZiTdsGS0JX2FYRnkf0N+KptsG8L+d1lZNMmOaBX9wPhO4WcO/RBC1bMDzAh0Nb7hAgLZSZ55VrM2812NWx+4HIoepHCGNQ9VHDg48Ep65qhfHkwVp1a7LFz9VBaMoKUwYBNlSKOSddNlCyMC9ODKOhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcxY38yV8J5Ii/Ouym66NucRwmtiU+J1j+ko4sNzjtM=;
 b=f+ZDxYP0mf9d+3oKKXknl3D+9Wl7fmd+sNjmkPgvrr6DIiQZ9OQU/MMNKrjeH6cA2gbCclBBAlzReDa39ctrqIcVW+VUUaVg65uQnp0+wKMyVr8UaVJ3pAJOBy3A+A2B1pOAlHU/oRUm6XAMNEiVAvthiXLxfxWvYZoOIMftkb8=
Received: from CH2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:610:4f::29)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 18:07:14 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::68) by CH2PR18CA0019.outlook.office365.com
 (2603:10b6:610:4f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Fri,
 28 Mar 2025 18:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 18:07:14 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 13:07:11 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>,
 <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>, <dcostantino@meta.com>, <sruffell@meta.com>,
 David Francis <David.Francis@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: Allow kfd CRIU with no buffer objects
Date: Fri, 28 Mar 2025 14:06:52 -0400
Message-ID: <20250328180652.2108029-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328180652.2108029-1-David.Francis@amd.com>
References: <20250328180652.2108029-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: f965ef62-017c-434f-41c4-08dd6e235e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oTFr04Vf1mA83ltaVob/DiOFXf6LjDIVMz82n4DGO9BSMniWlViYgxiexRzr?=
 =?us-ascii?Q?bBb5+4OOVLThb2wB5x4QLb+0p8+FgPyXEd+N1OVj+Zy13k9KpkBjK7+2mQtl?=
 =?us-ascii?Q?O46QgstkGSvO7XcwxKkF940tCKqEo12ain2mnsYqnD/11Wv88K8ucK2wGDeu?=
 =?us-ascii?Q?IU08ylzLuJqlIuqD9Jm9fw4jgGhQWCTEFX1v63UpLWTpn6M5ZaQTMO6lItDu?=
 =?us-ascii?Q?GcsOoWBwY3COmSkm8tAoHeuf+0HVnS2bsJFkvXz4CFoJ1jHG2V4EIt9kL2LQ?=
 =?us-ascii?Q?hisC9zWiP2eUFVnVQmpaw6cKkVueMFYHSiWMASFHycnjrKo+fWslJhuWBuGs?=
 =?us-ascii?Q?JsbJKYPC4GJRDqDpcMm2z5fWGzqKxOiduYdwCAGUQzP/UIFv2M0N0HivM1ZE?=
 =?us-ascii?Q?eA/Xsgbfm4UohFuaq7xV9r+MgksFYuNPufg+u3EU4Cs3EQ4acfbLnTfBXnFf?=
 =?us-ascii?Q?WUDMG1Va1Fr1h65Qzwpp+hfx9xR7kqxAkWYkmul3aQmFG9P615aGdossjzl+?=
 =?us-ascii?Q?9VbgCDplICsqIzwX34qD6MyH+rwbit3KMNcAzG7ZKQMFj+2LzdTqRpnOnCEe?=
 =?us-ascii?Q?2IeB7NM6AJQnEqJD+53kkdmIojFOc2W7VyLf2rX5dXPq60V1OXVwCqkufLqM?=
 =?us-ascii?Q?fvGSRwRBe0cie9C08v3EajJxy0trXvSjfoFOGObTQj3H4vtI9DWMOJFrmnlX?=
 =?us-ascii?Q?Rq9C6UtZUUOUSOBL+EmCiB8KcwnR6DMxtaqyI7fHSiU+5fBGwBxeR5tmbfaY?=
 =?us-ascii?Q?5cxnvnnLiBg7h9wu4Eh8YN8QSVc2bXXrb6xv5jELwMNTlLivULV9KuMG8I9X?=
 =?us-ascii?Q?KvrXThyCoD6GiIpS6FOjhM9gpRnwjpgtplqLYLZb+URuz9sjuVwvCz7f3oma?=
 =?us-ascii?Q?I2SsJ+06VhhCbFaKhF5Rkg8QXUgEEuFuRhzmdCQEbS9y4hJ7GUvHp0QkDm7O?=
 =?us-ascii?Q?96dESzEvbl5A2h/Ef2XcB4DtdkJ39bQq/YMRPHkX+FmfE4oyhkCHcWH4boVu?=
 =?us-ascii?Q?Rk8cs0qdZPmiCHlY4+RyuGKj2rYyLEcRJre0SwfBWjOy8VBVQjBUxfhhS4+4?=
 =?us-ascii?Q?IMrZEaw3b+Ac4ED+aqgHYj0AImW1brLDM2kBWiLEobaM+tbZIkA6T1GIsVQR?=
 =?us-ascii?Q?JqQBeXrVFiim8jpZOopPlRm6TT9yJpteKtS275S0ag/FY+fAYxG6sOXzLdxN?=
 =?us-ascii?Q?41n/9bgp4mG0K2K1cF+04Ky8T3EyK/zEPPFv/fidHVnMr022qwS7WITa+FoR?=
 =?us-ascii?Q?XF6Q/DDJRLb3n51oE/hZei5KSoH36LRYezHZRqlbe0ftFOJ5LDepK+lg9QM7?=
 =?us-ascii?Q?rQVI5ei7m22OV01vQlh79qnj8NLQNPzotfnReHPOeoZNOktH3naW1F05OFvd?=
 =?us-ascii?Q?69lZNpkgNczGVNZmtSWxQG8pTj6thjYihLYR48ieGWGUYKiWrZjrHrnM7lN0?=
 =?us-ascii?Q?tyMypHLebbbdUZbcVgq/mG3V8nmaslsPIEUoPxiy6ngZHVWNKInwXxss2iuV?=
 =?us-ascii?Q?lK7ZontpyG9eqBI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:07:14.1868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f965ef62-017c-434f-41c4-08dd6e235e5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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

The kfd CRIU checkpoint ioctl would return an error if trying
to checkpoint a process with no kfd buffer objects.

This is a normal case and should not be an error.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9c1e4c2ba110..798b956f31da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2560,7 +2560,7 @@ static int criu_restore(struct file *filep,
 		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
 
 	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
-	    !args->num_devices || !args->num_bos)
+	    !args->num_devices)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
-- 
2.34.1

