Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA78F589D9
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 14:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE9810F17A;
	Thu, 23 Apr 2026 14:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AgMI9rmI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85DC10F17A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 14:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMOctboqYXNEPd+lOzQCu8ifslZDPYZzYEp9fE6rk9D4xeiKoe69C58onkZIoONXnmXaBlkamjjWRBcbn3DOpH56NP4WW2bY4Hji7t4nFG4ExKJmjjnlSl1pYMfvVLemdTfXIcMOGG5AoofucCc5pek/8iSXEmjCfBszojm5m4+ZFpUX6xh2gidfZJuyTF/1cA6KlxkoAFMU7iTcqxtYLwgl/iPPWmlF0N58Cn6bypizJzTqcHT6MoLqL19ze2EDqR5GIz3/yxPmDCWKYR7UOLWDaS7Pec1eQjICMges6eL58DP+z+xDEbKMQPZnz0UH+zMAM+dOrPu3MibvaDGzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc+EiKWe4USrBBanxwk4mBm+tO+YHQTQsiRIS8D1HeU=;
 b=XAJt0cJPB/jZuUUYMKHrRayzfAFX0XGy6Y/hNlv5P6yFs91eEaaUnf12DNJpta19oMFSb1MIOMCQAWQJfXIhKLvEwI+KXgJeayhpHSG8ojPSmWJSD7FpsIqJPqLkniGCC7gR62989dFWUqW3kgD1PLULHJsbXFNs4/e0au8hJoojTtnAQWgI7ExJF+5wRhGw29w0qhqVURqd9nkRNwRxMY1JtiujwVfzLcbSoKOPGUYUFiqv3u4LB5TooOxuH0RVtNLF+AYL19nFXN2udbLSINPFoPG9ed6CsGjgXAcNu67HKDiP5DYvFfsbF3P7G1+HovxiwfdzM/C785hW55UbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc+EiKWe4USrBBanxwk4mBm+tO+YHQTQsiRIS8D1HeU=;
 b=AgMI9rmI/jSDA/y3bzUa/dKM1xq83tv5OBXgzNFN5bZpLEjRtFCrhMoJTP4+qXPo3FdrHqY5n30y8zdOmGsEsceqjtMGW68ocotzSCieeg0oz+RZKg6f25IOHU5SECAWf1KWwly5Iz+yEibWbU+yz4CmoTgjoYx5vjqSH8WmdAE=
Received: from SA1PR04CA0017.namprd04.prod.outlook.com (2603:10b6:806:2ce::22)
 by BN7PPFA8145BD40.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6de) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 23 Apr
 2026 14:38:17 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::ba) by SA1PR04CA0017.outlook.office365.com
 (2603:10b6:806:2ce::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Thu,
 23 Apr 2026 14:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 14:38:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Apr 2026 09:38:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Dillon Varone <dillon.varone@amd.com>, Gaghik Khachatrian
 <gaghik.khachatrian@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH v3] drm/amd/display: Fix unsigned underflow in SubVP vblank
 schedulability check v2
Date: Thu, 23 Apr 2026 20:08:04 +0530
Message-ID: <20260423143804.2445292-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|BN7PPFA8145BD40:EE_
X-MS-Office365-Filtering-Correlation-Id: e49c96b3-17b4-4346-0249-08dea145f4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qEJ5Yn9uNan7qaXmNGFsqfTj7kHVgF29QkPdTDf6MpB3GIVaA6ZyisCR5W9Tj1fS0wVWBfREMfpsLpUJroKh5B/d6p4ip5B5ct4EPRtYoDaxQNOPXEF4etr9NB8CimBWvVtMovydW3BGg+RkM7iea+YzXBD0WcQ0jNNJTmLo4c5IXd9TltybNi+tQ6P7Cgzdvp6RZVgtD0+ZJUqpxIZuA31eVNSDHbbxdk5LMKZp5nxicQJR3PuMpzO8dzPvqqhVdIwUEW4hX0K/ynvJbncKrw3uodqho6oZBZQ9UFC6s07ZZcwg3+UBQRZxiIBovvxWe+rx6zIYcHd1/T1soOoFfmJ+Kqxuh4Q8Ul3JyVwI3/zBNiZb+CA/cvZNGAtXRTANdDn2KtSf474MegRzTzQbAvs/FAXbr7R9219A6KX4pjVmGD7tDhfk10+lOszqwGbferJJLaLefxJeZNzUJrUsc1Wp6rbrYgmyRKvni1s0CIz6n00/GzaPGqcDidzRkOdbvupVuig/eKJ9c8sYEQ57RcCHcqAI1sO8shfzC/EyRK6T+oILiZx7WtJ5zUHEEQoaiIfbIjxMDIs7HOr12k8i8cQ2b/INl1v1VBkkkfUsfOV6cAm2vJiYzPZ0tjK11UYvpuPiQJD9SMlMtSwbTi9c2FtGQv6G+Rd/njJdv3EA3nKK9UA/VkvSCU3PPKH81FkwjaBi5KbZo3BXWHh/+RJIWod+k1hhFmIDNWGoMAPK5QYgyUVLu5V9XDMQDvxmJURTYKKGUccjJShAE9YdurZ1fA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K92AHB+a08CBVRWtlaP9CMSCwhVmCtbS5pbLJow9SfGJT31AndiQZ84JrvRnkPyaTY1LygIX1kwYE0hng/xp6HCFGpdT1nyt2Y66OFzx0e2cSgBDiy/Vr0JotVhhzStBtE6GOhWH/oYIds7Fb33bX5NaXaGiQqGrmfTBCQepTZnuTkOrIr5cMvM4beu9XZI71gRwltGnMbglvYa9OXgy4Fc2+ZEjdjwqsS/Gf3dr1F8S/95hXQu/7VeRh0mOc7fm4wMUo7wnuuOSRbCiFoJ11zGYzRUGNJGTJOFzrwcxF3CW/2uZ6DsQPLpQPa+BUkI7LWd/qOZ4rJ7zZ+2iIk9ltVCCb0jAGEWG07jfEHlUTpRuNIr/JWXGXbAkxzpcrMve+6SfBy93cWIHbJRl2vQ/H3DLbew6mPrAic6lCB2GYw89et2j7WQCKLezeVpBxDpF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:38:16.5131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49c96b3-17b4-4346-0249-08dea145f4d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA8145BD40
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

subvp_vblank_schedulable() checks whether the SubVP active region can
fit the prefetch time, vblank frame time, and the larger of the vblank
blanking time and MALL region.

Commit 06503cda03a3 ("drm/amd/display: Fix dml2_0 narrowing boundaries")
changed the intermediate timing variables from u16 to u32. After that
change, the schedulability test:

	subvp_active_us - prefetch_us - vblank_frame_us -
	max_vblank_mallregion > 0

is evaluated in unsigned arithmetic. If the required time exceeds the
available active time, the subtraction can underflow and wrap, producing
a large positive value instead of a negative result.

Fix this by comparing the available time against the required time
directly, using u64 for the accumulated required duration.

v2:
- Use uint64_t instead of u64 for consistency with DC style (Dillon)
- Make all terms explicitly uint64_t in the accumulated sum & use
  single-definition form for required_us (Gaghik)

Fixes: 06503cda03a3 ("drm/amd/display: Fix dml2_0 narrowing boundaries")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I02bb3461afea3c34bcc0dda2d0a0c1d6a193e05e
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
index fe667aea6ec8..4543a60a0683 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
@@ -594,11 +594,14 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 		subvp_active_us = (uint32_t)(main_timing->v_addressable * main_timing->h_total /
 				(double)(main_timing->pix_clk_100hz * 100) * 1000000);
 		max_vblank_mallregion = vblank_blank_us > mall_region_us ? vblank_blank_us : mall_region_us;
+		const uint64_t required_us = (uint64_t)prefetch_us +
+					     (uint64_t)vblank_frame_us +
+					     (uint64_t)max_vblank_mallregion;
 
 		// Schedulable if VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 		// and the max of (VBLANK blanking time, MALL region)
 		// TODO: Possibly add some margin (i.e. the below conditions should be [...] > X instead of [...] > 0)
-		if (subvp_active_us - prefetch_us - vblank_frame_us - max_vblank_mallregion > 0)
+		if ((uint64_t)subvp_active_us > required_us)
 			schedulable = true;
 	}
 	return schedulable;
-- 
2.34.1

