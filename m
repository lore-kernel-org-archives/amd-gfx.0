Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DD2D6DDEA
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 09:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5119410E831;
	Fri, 15 Nov 2024 09:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xJ38b12s";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867A210E831
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 09:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djgldE2/3EfqbOfnV1ckTMPgR6sD7FRimh/bt/Zx29xuheMIl/ZU0e8sEoDyjl5T1DafmrlYzsSXx1z7KXWf+KE+UWugU6BGlvQgvuDrxSVQZKMhM2aKFwpaoHP0nD3zddEXC2QLAYn0GPtRp/32G+M3cdVGQlVrNer4hQ+dGC4bKhJuTy0Etyg1MEVLr2bVIWCmzuC0/O5xsJ4hF4cuhd6UBUhJGOrvtKHE9t8NwuqIcpzFvXiNMAN6G7vQC0TiG9Gbu1MCoKSMX9r2v8ymd5xrWOPBkCzgnugyrqMs00IAyj4hDtc3Uf1NZOx20OnBeV75wVG2w0Z1j+2wXbx/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttGsqHrIWD0TJBrK6zBtz8d/nF/2vrr9Ay4+9eirt6Y=;
 b=HEyajrbDcpo9GURUzWpgYD12NPEiDsHc/ejMIWt0Cis/upGIGmlpRqX4xJ/Z5GuBv5wji9OU2WVbA8vFcMwXLDuFIX87Sv+j30kkGhcCmfgk70Mp0CSi2PKCwqpgp5TICXLJ4sDuUB/up4CTo58CGOm+gNeygXwkPzZ7Rdm3NEhYG/OxgMIcUK8rWJJttH9gJokHXJzDQ0tbGQ9OEP1B6ZbjNdATHLES6Y+hvfBxBphFNqn+oGwAp2bhBs9UkG75LMZG2N9NA8Z/6mKZzfpxENtDkuyHNGjYyh6uCt5PsWtICmqQtPj22AADEJFxo4yPFK6w2KgkJCaCd6xt9/QCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttGsqHrIWD0TJBrK6zBtz8d/nF/2vrr9Ay4+9eirt6Y=;
 b=xJ38b12suXspKLs7bRlnAnD8KJ0RGmryFYS4a7tbKscF5ygM5OP/VrxcIBocsC5vGONY8QVRQEwJdUql/n1IpleQTNA14KM8PQA3TuKvwquS7Cbp3pecTmV/rGvMxlCPhQZCiNSYMYjIJ/ohYe7P9uoJAk+r6iO0OfytwZSFe68=
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 09:59:04 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::23) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 09:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 09:59:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 03:59:03 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 03:59:03 -0600
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 15 Nov 2024 03:59:01 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <christian.koenig@amd.com>, <philip.yang@amd.com>,
 <felix.kuehling@amd.com>, <alexdeucher@gmail.com>, <lijo.lazar@amd.com>,
 Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdkfd: make sure ring buffer is flushed before update
 wptr
Date: Fri, 15 Nov 2024 17:58:44 +0800
Message-ID: <20241115095844.1487807-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 70be1bde-0dce-4cd3-a2ee-08dd055c232b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pKqlmtqRWYxhVh8Z/dg6OlJQ15BeQu/IJ84K4a6bwvIn4q76KR4hsqFuE9SL?=
 =?us-ascii?Q?4JXGKTJ79xtzQCewkpnXvde6xHhUMLi9ehBVKEI//scc/DrBsp4i5QbpzogX?=
 =?us-ascii?Q?4IzLaSqt6Te5heby93lkmO+QjDiBwZ20aWJ65jxOsfgn58fy5GIsBLwhWUnz?=
 =?us-ascii?Q?nwWiOSGwrTfmyQaDHQinv8mFwMuPkZTXsGTrFIwkWrEo23b+1eFYFYNxN3rB?=
 =?us-ascii?Q?pJXVQkM+SLEdmLRgDQ1bsHMFa4MhkOziUW8VO5SLmb8NrK0Ch4NSieggcl04?=
 =?us-ascii?Q?7dJAOYbvZGoHrMMU7mmFepBETCf0aOJZI7FiNaQpkagc+pSFUbfuFufL8X5v?=
 =?us-ascii?Q?pSF4L0rqVuBFnfQcC/tGWs2MXCTHq77LTAoM8FwpBJWXolS80iC0K+IriPlO?=
 =?us-ascii?Q?E2f+K3IpP8DrrX8Afg/VZob9+24blLQw46P3OKoKB1Oo/Plm3ogEozl1Opqi?=
 =?us-ascii?Q?M/nhS2GF1wDM3vvthYWi5HsTfKJ65Oj77nLoEeU7s2yDI+4hDMFO60xFA3tW?=
 =?us-ascii?Q?p33lHl/O1WhCtPaO3Nr752dgdNWIZwsYh+zwg1SXuswMwV2Y4d0JZHzRKnOM?=
 =?us-ascii?Q?hvOBZD7TersbzZzIJtBN40FwO5PdtvC1cZ2tvLzX3jShzqvMNwq9D2tHRU7t?=
 =?us-ascii?Q?cCeXOWVQyc0yph+QNbdAmKh5RA7gUVA2S/jbQ5LuqPC04Jii8SSlYeadas4h?=
 =?us-ascii?Q?kmG9kM/po9TAaLGYHq4SawoHay54c7SoluqYWzAYgvz8/hBbU2f79CiAXpLx?=
 =?us-ascii?Q?5uaZCM+++rh0R2goVui+3djDqPd5TDDeyhLsRuRgIFqjmj539WXEwBaVDa9q?=
 =?us-ascii?Q?W7h4cjmpoSIzLVhQnZQ4MPckqFk+IOpqMfToJfD+bgR2wETVeTTlLVsf8uTK?=
 =?us-ascii?Q?5bZaOf/jd+Tpe58cQc+Gh3TBDmP/K1NH7ZYknFQW/oNHI9qFF3Yh7GV5lcFU?=
 =?us-ascii?Q?Y3W/zz1hfp8q8bto3Eo3u4E775p5ZNwzgKd6IEu7WG1B7H66kAmhGCZF9Ztj?=
 =?us-ascii?Q?rUKnrWNEKNMFTTGe89F2p8kCUoG0P9Ba1i2VIHnkBY5K9yuujynSCVhlkZZf?=
 =?us-ascii?Q?wl0ApBGPPAKTpZxvBaPlqsovCG8ly1o60WGuMhMch3UTf2EuB7wgiXeOi1be?=
 =?us-ascii?Q?6pcqtVNN5tD0xxHh2ayfSyeFm8VBdqC9XNmQI7UtEhFaP4qHA7o351wWaq0z?=
 =?us-ascii?Q?lMBN3KBaQ7w+BuEHqeEHsxj3sY5cFO83cog9o/kLvTML8wiUw6gDCBkJcCSu?=
 =?us-ascii?Q?o/6DhLA6v8inryeySaN+xv1ueZbXAl/l6SnhCmWTnwNLG/MWfjnCqECVMCRm?=
 =?us-ascii?Q?0BXA3KVOghiDMPtOAWYBsdwiifwx4X3v4aFDcO1z+OzzCT8dx261qNOPgLEj?=
 =?us-ascii?Q?5q6vr0cr5afNOKdNPqdGIGGv4KRoxLoiFgYr7LAdPiJals6m1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 09:59:04.1045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70be1bde-0dce-4cd3-a2ee-08dd055c232b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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

In a consecutive packet submission, for example unmap and query status,
when CP is reading wptr caused by unmap packet doorbell ring, if in some
case CP operates slower (e.g. doorbell_mode=1) and wptr has been updated
to next packet (query status), but the query status packet content has
not been flushed to memory yet, it will cause CP fetched stalled data.

Adding mb to ensure ring buffer has been updated before updating wptr.
Also adding a mb to ensure wptr updated before doorbell ring.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 4843dcb9a5f7..55d18aed257b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -306,12 +306,17 @@ int kq_submit_packet(struct kernel_queue *kq)
 	if (amdgpu_amdkfd_is_fed(kq->dev->adev))
 		return -EIO;
 
+	/* Make sure ring buffer is updated before wptr updated */
+	mb();
+
 	if (kq->dev->kfd->device_info.doorbell_size == 8) {
 		*kq->wptr64_kernel = kq->pending_wptr64;
+		mb(); /* Make sure wptr updated before ring doorbell */
 		write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
 					kq->pending_wptr64);
 	} else {
 		*kq->wptr_kernel = kq->pending_wptr;
+		mb(); /* Make sure wptr updated before ring doorbell */
 		write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
 					kq->pending_wptr);
 	}
-- 
2.34.1

