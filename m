Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85817C5CFCF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 09:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08DF10E240;
	Tue, 11 Aug 2026 09:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cvWulueh";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06F410E240
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 09:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yL+b9/H/wfkhmm0MhRsiAtJKk9lFnWAVezYco72p0SACAg34icz4X6w0llU3VMu8ASeiVPKgkbIM0umAu0+10QLiFuZYZ+C6sOwexAKTonbOnd87p7ZcMelMNLIajD6qtNMgtlPjPiPRAr04i7bttK5laxwPL3HL9Zhfk1yZBpq4Enr0ll1FXZunpW/5TnV+y3B759sccicJHRDZDrYG5U7SpuU1U0o2ydwn/yDnI5wdY8ZBTGiBuf4FBx2Xsi4PAUkGktADyZdsV8/ddRX+5oysoYy9LhMowHFZvKt7HyZH+Su6Cgrp0mZMnUfMZ1+K7bIOuxIOQdeqQDPhZ4tMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJxsi05EmlIPhQqGJrzr8jw9mTdEylYbtZ6za9D9+hk=;
 b=hyfMuIboct2nzMXm6YY1yHrqGZELhL27Zuei5CPM78C6XhZASSs5DflISx6tVFgr0X6YIme5s3EBGyHQ5+bvvYv2xNLWr24x8olZby5brnCkz5wt86kYBPQxv6zBFcytqqFCd//EiUmrDgC4h6Y1Oi8P2BcFAan6UdI5wQLTzjVQWpJzMjU+3mVW30+6yX2ZmN0XTFGmVagHxORgh2fKEc1ljP9zMxHyl0Xr+47Ddlwury5meQK8hxf14fk8nDEkc5D/C0+tSkXkRRTDuk1TYWX1AmnQ56XABsoEH1FPXaYLQEaRK735yIdlifQQ86K9xSKvhXQuVU2qADXiWFCapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJxsi05EmlIPhQqGJrzr8jw9mTdEylYbtZ6za9D9+hk=;
 b=cvWuluehg2uVp/z+xIiQF0jRjEQJxKF49a0xyI1aG/J3NvRotWP+VmxLEJ9wauYtIsv5rP+c9M6lGgGsOa/sMRAVEOgaSh3fQ6V30XjstW1HS//PcxBeojoPOtzOBb18mItc6M1UsSiypeOouoPVBSVW4gsrIV7XpH7gVjXUo3A=
Received: from SJ0PR05CA0187.namprd05.prod.outlook.com (2603:10b6:a03:330::12)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 09:10:46 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::d) by SJ0PR05CA0187.outlook.office365.com
 (2603:10b6:a03:330::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 11 Aug 2026 09:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 09:10:45 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 04:10:44 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: Reject UVD message with invalid number of h265
 refs
Date: Tue, 11 Aug 2026 11:07:04 +0200
Message-ID: <20260811090702.95235-3-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f9942d-5aad-45d1-2520-08def7886d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: ZVl71eP3tF8jIm1j5nkNmUzT3ozKaVhbJl4BDm71fBZIhyGj3M+5jjBDWflQqyoxnPiBzJzJq8SnoO2i23yUD9DK968BCtP37FAvqdNm9NZpr5hyAIBBzgmSpFBUzIYxlddo9QXc3h1X7xDgRU5fRlMGHHawugqFM8gDzA8BQXOlbManWs8qm1Hwn5vnVD/JZuYW0ZFZYeKeIMzXqBfMDrsMi2E4QDjwxX5btk8R0LdRInSkpzHeyuqAiNnVzGiR43tUVS8LiAmL8jT7OCKx8kzqbOQDpyydL+uNq5OlO6QBowmdPcFwCfgnE10y2ZmRfH00Wb2lXTeYEzhey/7sOqre5s6iaY50YBhjgoP04iuCTquFUlG3/UeRo54T2KchH4ES15c0AQ/up0KNDDskjGZOFeUq7CZDqHUTDJn4MAVa2mnwuLe8vs6p8D2XYvmZNush8G6Dgvj+fO6+JzZl59tTbs/scoJb+TEqGPzCkIONp+3Ny19IDNyiPOo8o6DmpLQbbXdGThuzexnxoSQMdLOOJPVxQGGMd1W3RQJwJdOdvc/zStoDPOUm0N3oHaCSULXp09oiJLtoeRCJpOTMRKamu/h1Yl5gbB6eEoBEF7JJ2NjJGr0yRbmrjme9ka1JcfJ6xA4FnGC50ARxR6harMzDtfdPgsKFT4PGnG4z+OdegGqMA0Y6v930XkWyV6Z11wlP+8QQuJlnERkOt5QWKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BA4x7NLhiHqgfbc1OIrM5nhPiHavojYoLypbnt77RWkSDDcB23d52H+ARGO2429lh4DE+th8EvReibh4ecFIHNMuNK5926+eKKoKG2Ym+1cFfw2nKBiG+1B9yft76CI61RIus62lVEMBWvvr1xy6/czXl7BUWU1kukofVEBP33175g7npboh2J09FZLUQOmhKsC+GO+TQyf3BkGk3AkjUgDIgC28go3p2BOLyfhKfpJVGZTcW+ZYmA2PBSaaOARZLqMuB5XUHS/uguSXXj2fdMhZPFEeakc2+ehTBK1LDfKCo9uB33TWtm7qU5M+ErAZTndsyMA6yaN6ZP6XoEcBonySXp5G2AfCjWxe6JDgTorT6rV5Fraz5sQaD7WgkSElgCjCz5J7p5G5j4VJ8xH52cGZuT5bc2gVvDNCQacfOXpRACKoCyKqZ+GoE82UoWSY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 09:10:45.0615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f9942d-5aad-45d1-2520-08def7886d20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

Same change as for h264, avoids overflow later when calculating
min dpb size.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index e2d0f23d48aa..228a405a94c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -749,6 +749,9 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		image_size = ALIGN(image_size, 256);
 
 		num_dpb_buffer = (le32_to_cpu(msg[59]) & 0xff) + 2;
+		if (num_dpb_buffer > 17)
+			return -EINVAL;
+
 		min_dpb_size = image_size * num_dpb_buffer;
 		min_ctx_size = ((width + 255) / 16) * ((height + 255) / 16)
 					   * 16 * num_dpb_buffer + 52 * 1024;
-- 
2.43.0

