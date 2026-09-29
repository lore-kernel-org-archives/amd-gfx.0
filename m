Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71711C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E0510EC8C;
	Tue, 29 Sep 2026 03:47:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QuWXvraN";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0DFD10EC8C
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9yUZ66XDhgjZzDl0SZ4dOHZMhhLcIj/PKJDiFBjykfC8OQOHSKjcI9+d0R4bFxInI5KLNHfMEVZloV9OqpyxPvxrN35V8iGiihWpKP2kI+TGTGlNkpIaYV7AATxTmqtS4u1gi5FgCaqlZ2xjFAt+nHfmQT4WynesNQmq1GL/4bOCFWWK83RyZWLzhAzBYHaMhox8U8IBkcZgcE+FtQDO+rdE9futeZg7d7V2hAmxjHAHB52BK6OFRHBrDHMIv/lUsllu5bU1X1NDNB/kRw1BMuuXpheMCeF7+F63oE+bTb06dGB6leZDig/lwe4o2mxnEGF4IqiRwLyLT5tEVqOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeSGb7aZGgKblRZyRn1c3BCHE2JiwtslLNVZJxVuLvc=;
 b=Epo83EhAFP7kUdnThTfFPXlAzbED4W5OoO4LGd9MRSpJOOMnP0UROWmLdLCBGNbLvYlBXapLgu9AFan215s6leSevtaJsTuhxJO53txcEzqH03koIvwrdVIlcoPSxBiHAQT0wc/ejyYZUqH2GM/w8urJQYW1ulbc1y6LIiAMGVrJgcYX4HoO8qhpueKl4NRWUZkdt+n4Ebd5z+KLT08+d+RfxVRnpA8IuZMU5OgXIXJU7xKki8i1hZMM9/vUJVz0LDWHhUcm/FjrJ74oyEEHXttv/jKh5cV3IMvPu4iOSq6NDcBLgqmgoXh8e4GPfYYUzjeE336Ffqht+PP/lfFRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeSGb7aZGgKblRZyRn1c3BCHE2JiwtslLNVZJxVuLvc=;
 b=QuWXvraNpfEjv7Hnegal045KrkEo7TbB38frhvjObglrddkyQgHQ7TFC1sBdHk8lT+3EwwQdLI7EBttul/7ew4Dju/6FxbrlDcT4KUd7ExUWkNNflngQFuvHKuGx6ju0Z/EPvpTKJ6mUjp2mVlxDVZds7TtloQ/1BNxklXv9ogs=
Received: from BN9PR03CA0544.namprd03.prod.outlook.com (2603:10b6:408:138::9)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:17 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::39) by BN9PR03CA0544.outlook.office365.com
 (2603:10b6:408:138::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 29
 Sep 2026 03:47:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:16 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:14 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 10/14] drm/amdgpu/mes: defer unmap notifications across GPU
 reset
Date: Tue, 29 Sep 2026 11:46:46 +0800
Message-ID: <20260929034650.2393125-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b09a438-3be1-4fa9-e28c-08df1ddc5b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pxG2xBrFFNI0fs/2zIACt3M1PRhcmeBh/6Pzs/fIiV3BZZmQC2Al+rkql/aIbXgMIKAIQzVsQXzlBkr5aYBm3C3zKYe0QLnRtdY7hcO3bfANgew6x4HUukc+ZtBrfKNiTorBK9fbBjiJMZH9Tr3WzsS4ayqoxI5/WTkkyiYmy0YexUyFtwVsNR1NEyDutREYqhD/4tkOr96YTgT+eJ1k3Vby/XPZop/0ZJQJsXWJ+V/1A9Rw7H6lSuvLfRkH3S7aClBeG2lJGiuL9C0lIKb2MWNM+fWZWR/FoBPLbsBh3DPtaWX9kpMeYcYJ2MkmJGxUnRf301iHgQFSihyulbGgVJpcu7YgUsGZFzGGlMxwcmMGJLR+txIC3nSkUE4UXLtqbmkQN/w+25x4oaG8A8X5PXAwWxxtC0eTvDMFQfI6igk4FMXUfgv28oO9YIlKIaqzbddz6X/sA7KqIIvo+wYgJLFNTV/xVYQaaaU6CLP/vaL0vWDKsChN00s/Jkl0JlwHtDVjSRt3zBSI4YCAhS/1aR3dsN4UkqmZ/FmoH1gwCEqrziKJhMNnrjbOdgKjnEG6aPAHfPlppTWeZJiMoXSWhrAKBQJa6ab6DhjwVnunurfpaJIKmzt651/rHd6zINlPU9YJrLEbJxnviYHI2D9UXvq7aUPk3Uwh3O++65iaUKEVEVDrGtF8GuI37nOBz/qi5mL2xuGJdDfdpb+FRVKTwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4ZtjcOcnhEbs89lqRzECyzmjyBt4iqJFgtjTjJ4h3+qzAt+kGxKP6jxv7wrEiCZj/UbbnqTKn4YNcReY1Xz550KsyV+rHQLCK4GTqRC07VIdfBHJYNOGyZP54zvdWAoUjI1kJZizmwZxnijuUA2L60GewdzVKqlQbeQLq9zctue5oKM8IGf/nyzX2GPGnyscdsPYsuSLN0QG6TEs9JjZ+Rh2gyWSWm7eBsAeqV6wKSUeto5+QAbYLcnHT1eZVyCr/qN/DPy+d+lYLKV7uFDmowf3zLqSa7vyjfIW8lox5D+NRb5voUjSheVx0M3p+dwJEdFCWdfoIuU8h8otR0+nq6vpeOlEwy+wLUOr65229acDWtyxI+pjEPUM5PxnFTy+F9iVWzbLyK6Xh+eCtZlZFg++OSNDt8czdo0cPiPne3pXH0Eob9HStkTVsUkiQ4Bx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:16.7774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b09a438-3be1-4fa9-e28c-08df1ddc5b17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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

Acquire the reset-domain semaphore for read with a trylock before sending
the MES unmap notification. If recovery owns it, skip the hardware access
but retain the periodic rearm while queues remain oversubscribed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 4cb37cdbf821..4138080edbea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1192,7 +1192,11 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
 					       userq_notify_unmap_work.work);
 	struct amdgpu_device *adev = mes->adev;
 
-	amdgpu_mes_notify_unmap_queue(adev);
+	/* Do not block reset-time cancellation or lose the periodic retry. */
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_mes_notify_unmap_queue(adev);
+		up_read(&adev->reset_domain->sem);
+	}
 
 	/* Re-arm if still oversubscribed */
 	if (atomic_read(&mes->userq_hw_queue_count) >
-- 
2.34.1

