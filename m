Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1B8C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C5810E375;
	Fri, 21 Aug 2026 19:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G/nU/n1e";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B12B10E34F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgdXM7vpK74tsWqwlH5U+POG/Hb76FA/1juYk7szcaLgevn4gbk9tKtVgqWKsUGnuY2K2n2XFQMnFr1j1r7VCrZCSSrKT/4nSLjMXyq8e/05sJYTa7DWRKWcsTdJPi1xdqGAdbXXRI6Xgar9yXCpwTjEVS/llGwVBjCm8CmfUs2j2PeZ+ORHTMlKtRNuXH7aud0eLR8YaTJjaR/2lJmYFkH1Pv6+KvBS01FdpkQAGIXPhOrfqZuV2bodT7TrioLHGvSWMStpqSLKalMugC7A55eRZo+N3zRbRq359fKl7fPbbezu1opl2VH1SeRER54Gg2NPttWBU+z5haz0dVH6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXJ/lyudMdwYK5Irzq5jSHUxskFyVFW9h5n3v8izJ8A=;
 b=gbQM93t8lP7PnxAkC4bW9uGMGghDBzA69YUXooJOC9Et4kK2jFe+7qC1YruxiLkYJOSEVt/q3BvrrXBeXXIutFrfLecQoLz+dFC8oM7Q4y5qWR8xKjcA4mJbt9FkrcSD4EaXtQ7TXYQTXXSV+oobUZJEU6HYSnbQYsj95TrJdC0kjZC5FiAkDy9px3CIFysIii/DBhrogmNH2Z8JvsyhdnI1cfyiLZscZL+xOyR1NfNQ7OjmTR4/F57fhoWnvvQrOGOh3u+wQjZAIApBGbrGqWa80fnp1Kg2n1lM4fmmR87DF/zT/xZolVJV6RwA0Tc3T+W+exPc7S81aKnCSmsXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXJ/lyudMdwYK5Irzq5jSHUxskFyVFW9h5n3v8izJ8A=;
 b=G/nU/n1embn0OcXJYhuaRsIO/IqLuxsTsBBhfys1Tl6Xo1a2ayzMVGXDPu3aB/9MbIqU3593TZ4LnzL88z5TI9bYanPoMGnR4MKr0vZG7K+iCS9x4qVpsuh2qBomotOBgs4xjXoRx2i0nz4b42XnWb9ECCLExkOiB285gOi3Q8w=
Received: from CH5PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:1ed::12)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:49 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::aa) by CH5PR02CA0019.outlook.office365.com
 (2603:10b6:610:1ed::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 46/95] drm/amdgpu: Add ualink handle to BOs
Date: Fri, 21 Aug 2026 15:34:09 -0400
Message-ID: <20260821193458.808626-47-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: f41f0bce-9a3c-4595-729d-08deffbb665f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6mKGqXKdtHkCuLvSSj9cuLu84KOAX7FbMnjbQxLPrCGgJ3fWxq0YffJ1oFe5BCR6u4rVQXHBeUfSwlkHU378yHwUs2S3q7Bt0TAFoqBlvKf5tOe7/oFBEJVf/v05sAh8pQzZQ35uDs97I6aIY1zHIn0K+XA2rD1Q5RL9uEAbUQAlh1JB6rx4V5gtfW32AcRygU/USsBV51Gk7yVQpu0epZ4KnBidVfPlffVEJbsoxtw3l1Ywh5Nbmzn0bCx6e3VtrfSYlF+M0BckCOFAYLzKEhfbcrcR8lRo3+t4s1Jyy5zPGcrsWKD6J9tf6bjwpnr5m0+le21dftl/fYv5AIOqwJpqavZPSuAhvSde8W0J6dE2rHkgV8adQ/bYuiE8L0aHxaw+MiE5UaYer1g14K/qHVJxENqjXzoAoziogZEGNOaQABX3rtPFFm4vo56r5MD2K2NGtO1uGSeyeKp2S6oNt/LRt5P4gTZpJUAr/r+YltxFrhe+DOdRk3H4jdzh9ZDCCzaOF5YlHWQymJD1B2gOKaR7qyh2oDTu87KDhsnB9a0TT2pJBWgUo7TGlSR40PvDhaMhQGur7h9i5SF5nqq624EpeD4EOOCalxsr5XPvqQrBjLx2t/drBvWgfx1WARBWLCS3/rftFHsYMhM/2XeqSVt/tyh70jJlXbhmgsBmUyg1XOAyMPIOQ9GNPb7cUbsfaNjOM+m6QNMUtQtRPIojgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iY7GC66n/3lEvbu+nPzwurIaVhjxKOc97OD1NvpnEMRY9Y2LGqLiR/I2DcuNTm25JZpk/zjYj3ZKQt0pPfOL1oqwB4ErFKPIL/2OgY7m/MinUQivUuJebv8hSIjL9R9Qme5y71UwTp1egVGabUbdAF6x+6wSNl0hhfUVIBzNiwvuLlIsdiZu6h3KceQqA6h7REZaV+gD6lDmaO6ucGUIjxVOkIXEpl0RQs9PHpkscBrgvX3akcVU4LHjs9XMv7Pix13E4fLD+J2w8zYYEnd0qEl5sZAKhhAKaG/obrfcCHIJepUNd0gWSI4k4o/BITt2Z1kEuZOtcgxGO/CJmRoq1+CWxqkH4RyGqKXR+12cgOXEkZO0IKacWdK+ziOx/X2Nem58jDkbWBG/Z77qZHgeMa5sOVjlgfDk/57QhJ2UV/K6cZxnnhmChQwhTJtKj6qo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:47.4102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f41f0bce-9a3c-4595-729d-08deffbb665f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add a ualink handle to the amdgpu_bo struct. The ualink
handle is a 128-bit unique identifier associated with a
BO and is shared across the network to facilitate NPA based
memory sharing across GPUs in a rack scale setup.
We are only storing the low 64 bits of that handle in the BO
struct as that is gauranteed to be unique.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index b41767c7913ac..2e6a8e6f577a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -125,6 +125,9 @@ struct amdgpu_bo {
 	 * for memory accounting.
 	 */
 	int8_t				xcp_id;
+
+	/* UALink Handle low 64 bits*/
+	u64				ualink_handle_lo;
 };
 
 struct amdgpu_bo_user {
-- 
2.55.0

