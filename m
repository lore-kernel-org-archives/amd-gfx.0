Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3D60A383B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d5DnOMs7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71BB1120A1;
	Wed, 18 Nov 2026 22:37:41 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0806411209E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWSmSjWuQqyfASIOD+nj0kcnEw+Qm05nxscQQYHeKSLFhu1ePSYcWThlgPcf9XUUanR+mTAkj4YosQ2bfdhtaBPR/BFOd0VHTY5LPe2tnQSuWjajsGSgMJ632VgmuGwKkH74p57T7dv0JDSFPy4n+Z5pFN4NRHwMIXyKA9ko0FVc1X8P4cv18V3rxggFyXfW9uB8WJUvNZQZLVXDkIYhmYP1vsgg2YUdwB7WCFljBms9M65U3rbk9ZGNNg4HaRGT3yLUUQJk37csQaGxpH1qT4tDqFMkd39mVnnX4o+AXtfv6AEEJ5mxjWO0kr3x+GrCBDM7t1S4CrO28H4xXTe28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6YcI/viNsS0KO3/1xfzySnnlo94bwE6fkTt9wCCOBY=;
 b=CZUe1a/YgZ6QbCABo1EBpg7QitNjC7+DwILM0et3QPXW3IU3F6WLvgFSbRCf8RxibSf2bGpUDWECZkNhxTrnooncuUjSs803V9N6cAJDevkh4cMalKHGrgLH5Gu/2CgNQznSVZZH7ghZ/70gIpm3OifXvPvuURZw1ZyBHOxbAKDtalVW29dyC0sxJOteTyP1EydqJzJi6bSfbWcgGI8V2WG+8DNqRTvj+sJFTO3YtHHuLnqt+5RRq4C7QXiZO7Djgw6dPSze6klIye0rwOm4OBk2S65qiOMtM4+BHASi51saARf6elISiYbNvD5maeGMX5F+7+Oxj0uQrvLtqtKL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6YcI/viNsS0KO3/1xfzySnnlo94bwE6fkTt9wCCOBY=;
 b=d5DnOMs7Q5kJcVnhIEqyHsPM9Bn3p3X3kbOItdA1KT7nldBS152zlU4L3TsD42kkPdPv4tOpsm3DcBw8mwIcUeK3MvQ3TD3HD4vRZ3fyY3aw5NJEJEeqyAXQZdZJ3WeZ1PnXtCpZNIQjnNhqIGos9ByMJYZYpcBVlc8Gh7oivLU=
Received: from SJ0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:a03:33e::18)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:37:29 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::2d) by SJ0PR03CA0043.outlook.office365.com
 (2603:10b6:a03:33e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Wed,
 18 Nov 2026 22:37:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D894F.mail.protection.outlook.com (10.167.249.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:37:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 06/11] drm/amdgpu/userq: add callback for gang setup
Date: Wed, 18 Nov 2026 17:37:07 -0500
Message-ID: <20261118223712.2518580-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|IA0PPFA19DE7612:EE_
X-MS-Office365-Filtering-Correlation-Id: b33a45ee-410b-4fd6-7842-08df45c486f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|10067099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: e0jBerfUzbXjdGHNj2PakeoJE/8bCVa8AV3BAsewYy+obMspCSX+QbCLMKYHzgzSkQucOntL0pTBMaGTmmN70x/MxDyjdTAuus0ABXtTghw+boRxPU7KtLjwWugfGOVmZ9pUS7Hah0sb6VCTwOqkJdlgT6f2cE25J3OWipJict937Rh16+G8JvdidPfOY9YWig/pb9aW4TMgxEhFlYcPZ1ViF84tQkBWcJb+PYHfwCSp4+qXnvxLIYyJY95x6brwAxv/sT26XVK0LXxNww55aHZPb19j+JRN5BsYn22jBCelgEyI4sQlZn/sINzyubieAQZLolNKagsqj/ynV0n06lxEIQG1jLbjtYKoKUWIXPzZT7FNAog0ZRSsgfjYyWt/cvebjeBSoy3jlijjKKGUUVNdclbUfbeiF5UYePaYgfoWy94x4jF7ld0a0UTg/O6xf/xl6lf0n9aMtowyhwx66dzXrgjAAvuRVTuMXj1OyspINY3oxbhpDjEDV91x+Z8HJ3wb18WAqSYZRLPsFg7kZhVG8OHeiTHkvhYHWoEwsGx8yRPddxQpWl+CKdNYRmV0HUu3uwEy9xccqtNXn3LH5N+xMc17IwIJ7RJfViB9QZhceqSA9Lq0eEPIrWEOITLW29E8FrLuXnIWjIgg/XsbRbrxcLPQL99kwbDwtgVslo4R3MNsGkqKk7DpIrBQ1E0SVX6QiCKeSVWOIAAyJFb8Kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lHgsF9v/b/KsIlf5a10PeHB122U9KPOGo7ijQ9TUYtAo3KBEmM7SN8pEipDZsUWT2nn6M2rsFwqN5mME3PLvEt2VU5+ALycBHDN5pRAk0FoAXn3dErL7o1qegT0n+RptuUXv7Ttl0+j/OVakaqsoMljaY+xnkXynzm1qeMqQCXTXFtwHrlEkh64Xz2mUM3dB15p3uf2Eg0p1C8ZiP6FUduyLOjmE97F/ppJpdel9r8U49O/wk7OIe+ylK7uM102INKX+XEEXW5nW8gI0RJHTx1Sj7hzUzS6rK+njkmr6WsHdFz+wbOVraOcvdAql2HtzdkI+3UPwsaSQAG9BMc/Wpv9IBWmbTlTbypeNIet6auP0BQUpZFt7Yu0zA3+REVgSaxqjkcF00qT2L+5bHFPwo9dA1UEdjXPzsQl37juRvy6PxxZwY0xCKiUbeSguGwlR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:28.8803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33a45ee-410b-4fd6-7842-08df45c486f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two queues can be ganged and will schedule together.

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81b..efaa658a26a9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -115,6 +115,8 @@ struct amdgpu_userq_funcs {
 	int (*preempt)(struct amdgpu_usermode_queue *queue);
 	int (*restore)(struct amdgpu_usermode_queue *queue);
 	int (*reset)(struct amdgpu_usermode_queue *queue);
+	int (*set_gang)(struct amdgpu_usermode_queue *primary_queue,
+			struct amdgpu_usermode_queue *secondary_queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.56.1

