Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487A1CD5BB7
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49EC310F476;
	Fri, 22 May 2026 00:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zbm2hdxZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1FE10F472
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2Vqqa9XwjaQwxy1wLBtUlIm6jI+GI/7piq3pM5tP/2S6ct2EZc4vHoRinvpds6Xei2pBs2/rQuRZWXxFbxQz+F4nDtmNgyhOWZQy9yQOSOwh7YX64km/0jKt47zrQVxftvl+Di8QKXbkfoFaQFpN9GM9Kc41+C5ISMKzYWS7NtBuI0eG4rez9CELEYnK8ZwB+7yeU9OHPy8M1kqIzhwRufLrwJ5md8ouGZW/eZ7634flCM/+e9Locjpag5bfNpx2hEB2mGfvYA9QntxyOBAFpdp2NkH9teZ0oGv0GtV7JWW1bv3lLKTRDw+ysKZh45s+pIV2SSQ8meHzXdnw63xOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCsdpHIn5DctndILxPtdQbmFvTK7n50RcZDPLwerxGk=;
 b=OLch84xZJ+0ri5TeARBzcWbvkJa6SQueOa5WJHaKXSNWnG2x6LuLV83b9DQPFAGBLCDXucJo20F1Ahy2gwpD0KKa8zuOhXy8PLnuhGUuoL6OIZfB06xaOfSLyTlS9IlPKaTuBDQIYt58ut065+NZSGji+IXHkQ6HWv6tkBXdrvR/43mS51u+Gcd5gtKbBC0RWODqPjoluzA63Juw1uuDhOtJIIEyi6hb/lJF+tOf2klHtelEWjMjyFTusVgbf7jJ8GEHsdb2RuR+FkQhCizr0O2PnRlsYBaGWG+TH+q1RdHwm4Lq/Eg27CNJyW8oz3xBMCGkWlDt2Q0JlB6OXtbNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCsdpHIn5DctndILxPtdQbmFvTK7n50RcZDPLwerxGk=;
 b=Zbm2hdxZfx2+n2WlFqvpPvHmAhQtxhGJ4raTSZY2S3PV2ijHCBslDc7ErNlXMNAV4usAWo3YsW7pnSyq9qK+w6vSK/4cyfTDtha7p3YwmtNw3rFERce5cwnZzSfdUCZfiuMcqLFL6LWNRSGhsHVrXLCanxhwQz0Vgw5ccXRvdUM=
Received: from CH2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:610:51::34)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:21:57 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::e6) by CH2PR15CA0024.outlook.office365.com
 (2603:10b6:610:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/42] drm/amdgpu/userq: add per queue reset callback
Date: Thu, 21 May 2026 20:20:26 -0400
Message-ID: <20260522002048.98506-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffd287f-99ab-4f0e-0d90-08deb798227e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: bxgXgMjyvm/I4DvfI0v4jt0/A9miX9yREFGXI2P8Kt1rcKCplzaJfPYieWQIdNxxM+u1cQB1NiUz8jkZpeHGo0jGpE5CLtINx4gsLk03ZH6KXkBfd++GGsDBHGEJQHD7k/uaBwKVlQFAMLRXvWq2zr1n9H7rz2lAdTUvwf4IjxjrWiIvcHgAahk4IFzmh1HV1tJbMzBE4F1avp2yf5fC6fi1vl1GQfL25ao+dCAaNYQ+2pHC+DE6e3Ba8ITtbJydTjtgBpzqRTWaauO6PL6dh/MeY5JNAKGPqjqheSyPgcfehtJQGmxt1ZvpZl7vxTCu40kj4KxTkCc2b5TVtam7bNOM8E7qTgK7x1FQK/wJUphxI97B6Imfayw0fKl4x4t4dUbm4zJZy3iz3axJTD0TOn9N6I4d49OtT9P/+8DyTF3+CRuyi7Xd9ZSRrvjHVYBdUMWOGY6aZMbOfXeXAlSW0tApfaI7hNuYj1FwPmsNDT3jkwIxUVFiCcfMVH544JOyq5CZjQSsKO9nLISS9dNZaza/+6/uOwPs0HwGfW9GkCmUZ1IGflRnOCyS2VQRCsyMis9lS9Zt2FA38twtHI64TVXAGauarDJ9ApOE+aHyM8ZWxKwIxJHAuwjsOMe0pxpmzMmBW0rGjj17XEn5bcvirGQBTPrX5IDgt/kXTzvogtaHf8JX1RNVciA7GPeWnxtXtA2zN4BrdU5qRKjPiETTs2DbkSRxBY6rCmwwsgVZle8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o52JYJg8p8eDA2+HelNJVsIm3jUP+H4cwX+FSPMCFwziKj+pn8AiamAq3YjsC2zC72KzAsXVXlHIC0RcNNekk3FCFWK6l3L/Kb+gVwYsHh3x/QoViuSB+sVXZ3rnQCQLasi3ztPXuztAnaDkF5qkMyXb5hN0rBfL+uwvRXAiYkDFigGkHr2S2fCMaSEbWDV1SZFitntK8EDk/C3Chn0T0mPhYEsZ7bB/hQSuL5c2d0Jo4rNK3bWXKpcUcdkTJ5x0cyVK/4E254w7Naqb3LnsVDWCGzumdQSNc7tgj9PzphjiDYgqF21Uzz8qMdinvNHN6ydivBgW8Ta/xitzDRtzvzyuUPNuw6qGXOgT+2S2G/BCKv7GrnT8sb4enIBTVoWGZOvwScVlnax/5RdscUd32RSh1INsxc6DgAJVpbMczRWEUBTTl5a+pFt4+4uYg8D9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:57.4048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffd287f-99ab-4f0e-0d90-08deb798227e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
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

Add a per queue reset callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 49b33e2d6932f..2403a5d990f23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -108,6 +108,7 @@ struct amdgpu_userq_funcs {
 	int (*restore)(struct amdgpu_usermode_queue *queue);
 	int (*detect_and_reset)(struct amdgpu_device *adev,
 		  int queue_type);
+	int (*reset)(struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.54.0

