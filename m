Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA1FC021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2562510EBF5;
	Fri, 14 Feb 2025 08:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HoJUuLY2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0112D10EBF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMOOS833tHPJsrxDnhAmWuklCrVooz/Rwr0OTZn6A4lbWXx3rIGaYjJxyVdBemyUsXAyWhN5zn6LdpItwWeaHCxVgxMi6XbzcS5Ogf29CI+uFJC1rGpXNzRrHJTJy3ECeFZvumVyt/AwxW3cD4ttp6uV8xQui+WivXhEEOWeJnKAxaG4V+W2HYBs7ffT3X5bPll4M0ovQus60KIJHNCZEEI4zkTYE0qZwLOjnx8uKQOJ63gKTy4vJRZsMCUafTyJu4X4s/kMyCrLfA+Q2GdQP1s4I7wqRPbcTwgYy6ImfuihF+6Kyq20mslhqNpp+zGpzEq7sdxrDZJ/R7S8kRKPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMazway/qRHAsYNkN1wUxvZb2Lfipb51ZHvjTWJghmI=;
 b=mym4y0qqMXjQCzkjGDhQadHLUaoLw9sxA4b9EkquAgugNefh83jeCtK+2vuMjBfLqsTJxn1nlcgMEKlxkOMa3i3UO6fEgnzraD9ZETiqvJyVsB4fJIsYvFZBUXzj69XsP2U3JPL1hK0d7mrOK9KdW1NDlK856EsHiw6VD2oGyE+J2RQm1z6utE+v52L/xHrrYZv5kXYDnyYIvZFTHgFfDiQG+3m8kqB7K4+WAVnFKTFRW/Cz0nWbC3t1UysgErcgShvs6OZHVGyYXV/elviY0CPADgiDv7g7ygoLUFb1e7aZkW5G+X7HVYFGQAjKbuePwoWi6GVox06BOo3mkzM9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMazway/qRHAsYNkN1wUxvZb2Lfipb51ZHvjTWJghmI=;
 b=HoJUuLY2UtW6DttR5kJtbgT9+R2pwfyUbChPSC3nZGEFblItJ8hW1cB6KGkAfmfY+zSYNqzgqXvI8yMY1KhvjsyvYdZvua/67p+tJ2Z9GAonPiKHjaWiDw1v7sEP1VtNyoXBNmhTrywcJHftQ0tP3fqbX5rBa4xticohVN91DKk=
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 08:08:00 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::c8) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 08:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:08:00 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:07:58 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v2 07/12] drm/amdgpu: read CPER ring via debugfs
Date: Fri, 14 Feb 2025 16:07:14 +0800
Message-ID: <877f439da08ac14af05f116c1f89c5577f5f79d7.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 23521529-043c-4a07-bdaf-08dd4cceb2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sjstIjTqMwC7suJcwVUCOMf1Ad3jGF1lBRZPYnD9+lACBsBJEupF9k5d2vUc?=
 =?us-ascii?Q?YC6ViJgUoSB8IqQG/LM/2/KFFLwGAjNT4oVCw3V29Tfo9j7NfDEpQalMakFq?=
 =?us-ascii?Q?2UKrsKxsPlTRMaeVnjGoKnGMcq/8zFpFel7z+oyKpW3aDNSw6bhtsqHGCJ/X?=
 =?us-ascii?Q?ahF+vIzcB3wvTnux7QCtDSYCjZimg9xGIDLiV1+tD37/GvQSqszKAHMNDPm0?=
 =?us-ascii?Q?kce8tyi9GHA1GSSXoVSVZMTByGT5HiR1x1ZX9iueN2v8SsxipLJEW21Jh95V?=
 =?us-ascii?Q?2PveuJwRoNhnndOy3g2MspRHZkQsdf74UJFiwQvQi9FT1GfE2zwGjAi8Asx4?=
 =?us-ascii?Q?/1GSO1ZRbIF4YHTUTgqPXtTpNNo46Mi9gn/15GuULAOgXT3F4WnF7Yi89YFd?=
 =?us-ascii?Q?uzhotkMCgiGuwFq3gKvF9ezaBmH7pijYW4Dp+fxWhab8qe4EqUnDKK4hncb6?=
 =?us-ascii?Q?gR+UoXRRONnsJBJtphJj5of6160NMSy+etG93sVRE26n+Wdw7Njff6x5Tus5?=
 =?us-ascii?Q?11rtdRRjxsRo2mLfBbXYMcfGUVa7Ul5bghYr9Yu3+9jOlWZPzmvsJQSuOCei?=
 =?us-ascii?Q?fewvwspsgd7QOenRop+lH78D1sYB9AT0dXcE4VjMkmEjDhVIhI5YhjUvlclr?=
 =?us-ascii?Q?z0J4w1soCqli5/DfwfsGGDbW3BsJOJ3xJaTsAMB13wybBHadyTfAXOMptZH0?=
 =?us-ascii?Q?u2/KK+D4ztqWqBRsvTYajdOlj0MgefR1Ot+GE7wDz83c3/DJeArBO/9u52wl?=
 =?us-ascii?Q?VRI9hsIsqskg+x8bIRkLBNlMscv/5Mf7L+YNWckI+9pTaofuRPPbkvtiQiVW?=
 =?us-ascii?Q?DJT6Y+X6qWHTvjHsvfkiu3BH1xdj+uogODWHPAvJBtKr/fW7XgkB4pu/pr9c?=
 =?us-ascii?Q?iY09SmWZCEq9BGjd42swBq7p1JDNdF6M85edvjOS4zjENZUSCcfDl7VFSQrR?=
 =?us-ascii?Q?8LGQGICLe3Pkkim3NvtfXJOMJf4QCQkH5jdJrkSNK2lNDq6r9nP7Vzr1xj5k?=
 =?us-ascii?Q?y62NRDJbcrouB697Kr0L+kHAuxSGYa08x5/qh+w6WgFQIBkFyoNTdpS/96P/?=
 =?us-ascii?Q?eXiOUDVi45QtCLiwkoux/iOprpdhzvvWc1T8zaQ9lKWnFUoyds5WpRRd5HN5?=
 =?us-ascii?Q?FKGGSuxEpiBl/sN4lEnXeoNW8vqC/pM44wGfVE708+YBDR0gEWu1HyXpbq7/?=
 =?us-ascii?Q?/evU4GLIzGyUbT/MouKC8ZnhtY6nQ4pX+t16NzeuM0gGU5RoGJFjl3GQ6wvs?=
 =?us-ascii?Q?rFYx1ChQT/JdVrbE6vsiXBUbx6ahyz5hUNETrzLFKgGEkndtJ3KkSERLuN+i?=
 =?us-ascii?Q?tMrEwBYD2V3ACATqOe5a4YMpD5thZhbEKE/AcA919Wk+rMQDLspN2Qoj9SuP?=
 =?us-ascii?Q?VSLyDbEHSBfMWh0mvSTO4A58ovv8IReC/iC0R78dLl1ZgR9HBV+FrjffuoSX?=
 =?us-ascii?Q?FTjp+pJlNzuiX8Wywd0irgI20BqOHh3FdTDX03TuFvnmHYhrTZRIcE5X6ciW?=
 =?us-ascii?Q?H3teKHQXpVhXacw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:08:00.3900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23521529-043c-4a07-bdaf-08dd4cceb2e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
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

From: Tao Zhou <tao.zhou1@amd.com>

We read CPER data from read pointer to write pointer without changing
the pointers.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 47 ++++++++++++++++++------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 005cdaee9987..510fe1ad0628 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -500,6 +500,7 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
 	uint32_t value, result, early[3];
+	uint64_t p;
 	loff_t i;
 	int r;
 
@@ -523,18 +524,42 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 		}
 	}
 
-	while (size) {
-		if (*pos >= (ring->ring_size + 12))
-			return result;
+	if (ring->funcs->type != AMDGPU_RING_TYPE_CPER) {
+		while (size) {
+			if (*pos >= (ring->ring_size + 12))
+				return result;
 
-		value = ring->ring[(*pos - 12)/4];
-		r = put_user(value, (uint32_t *)buf);
-		if (r)
-			return r;
-		buf += 4;
-		result += 4;
-		size -= 4;
-		*pos += 4;
+			value = ring->ring[(*pos - 12)/4];
+			r = put_user(value, (uint32_t *)buf);
+			if (r)
+				return r;
+			buf += 4;
+			result += 4;
+			size -= 4;
+			*pos += 4;
+		}
+	} else {
+		p = early[0];
+		if (early[0] <= early[1])
+			size = (early[1] - early[0]);
+		else
+			size = ring->ring_size - (early[0] - early[1]);
+
+		while (size) {
+			if (p == early[1])
+				return result;
+
+			value = ring->ring[p];
+			r = put_user(value, (uint32_t *)buf);
+			if (r)
+				return r;
+
+			buf += 4;
+			result += 4;
+			size--;
+			p++;
+			p &= ring->ptr_mask;
+		}
 	}
 
 	return result;
-- 
2.34.1

