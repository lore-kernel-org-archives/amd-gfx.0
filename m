Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D7AC369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F8D10E7C1;
	Tue, 15 Apr 2025 15:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z3mi9MUM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F8110E7C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV+hJhJB64v8ivfnSMUeXUEhC/elsOycvxpSbKEqYiVbgxERZhl9Dm4QGDOSMPB/0y+llhcuNCgCEVKxgjoi9ArmjX2OH59IRcfjD4XmETD4TqqSaz640B4+IStO7ERK4OFyvUtcKMKh41q50h0Ou7nbY3FadkMm+XdVhAwRAlBVi8N6oTVh33niLfpVJc+iwBQrT6nJbSBQYv5Uo/3F1oHeFWNeyPHeC0bXhKwT6FMpNyE3ec3qd/pEmE+H53fMZz4ea8u6WGB0ap45viPSRpvMtPLFE9aLzqNLMgqK4CAPV/ps424HJs+LvAiEdpDZ88QgQCW9fkitqQI7nQ1lOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3EElrsaQIz7d2Gb1rMhnmOchdZ8cDHqKszSqmLAY0o=;
 b=OWbV/2ud7wH0N3q8jyINY8OXIw/K0Ej8Srn0mCkbFJLo0mqs6ci3yZHjEsyBUgnuTPF7Ph7gP56e600xxcGnY7yOCn/GhSNp1jP6QkCSFWFA52r3o7306zqwWJvkbV9Kec3FypWsoNI4u9reHZb9DUZzZZXAGO0HfoEnrCkam8+hsW0eJ8v6/uML7mXS/v4AHr+T4EhTrMDFDtumufsCGN+FCqRXgcnTMvTCm+gbgR0NcHTdUjtUSeZ2bYwqlp/+lt1kI37Xj4CLYM9gcKxSndrPY246OqIvUYGZxB6UR/RwVxDlf+NPsbqx7B5AC1590lYEniCyBh/4r2KDHabsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3EElrsaQIz7d2Gb1rMhnmOchdZ8cDHqKszSqmLAY0o=;
 b=z3mi9MUMq93k9oS8xvgauo54mNcK+O/+Jf6O+O7KrS5SI8VHEkuUhjBKpjYLkpE7/5vH2bEhJ7zd3VDdWSAmQnhqQgklDxs2P0+ILINig1ku61IR/YXP4S8o7Q5xu1hogmc7GzOXaHr5HII2IZnBW+rI5SQsjORijqv115blNZU=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Tue, 15 Apr
 2025 15:00:15 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::a4) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 15:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 15:00:15 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 10:00:08 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Gergo
 Koteles" <soyer@irl.hu>
Subject: [PATCH 22/22] drm/amd/display: do not copy invalid CRTC timing info
Date: Tue, 15 Apr 2025 10:59:08 -0400
Message-ID: <20250415145908.3790253-23-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: af9a06b3-b44e-4054-cf00-08dd7c2e3ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?09rdpu5rMHCyupUsKs0b2KWt46ge7EJ4Qrozi/nPcxAUFPXTYDa/MHBMj7sX?=
 =?us-ascii?Q?2GGEKq01XMwHOTsO9jv94aFwx2uWyK+9kzqHfdgqIpbuEUGRvwBymKlH2ecb?=
 =?us-ascii?Q?/SQN4WhcYQhiYuNZIbBKeFYcVuQpHzo1hwcOn9rzqRKHsQwGKMMTUdugQiZU?=
 =?us-ascii?Q?TOOzl8BwFdQAD5MCikn5f6kfdqwMvyM1s+TYWLqzuyt74Wwx9Jmd8XYEVYq5?=
 =?us-ascii?Q?QTWtLl1sSyJOdXz4E57y9THnId2KjLbrBnCBuD0UIZbxWENMAWbzCSW64Nb+?=
 =?us-ascii?Q?7HhbVWd9tFSVocwov0/zPyDAqo5BVOMDuL3QR6B8LIo1+NMR0HROVc0X0xL1?=
 =?us-ascii?Q?hWMc7ac/I6ySG5PNCNJD1jWYp/06omiPJ3yY1fUFJqH6alwmw14kzGxQUA62?=
 =?us-ascii?Q?7l+iHvoc8yLMfslB0ATUKHrKwDRl3zZcCXcJr0iyfnqDFLRrxT8Pw7YRVv0D?=
 =?us-ascii?Q?axdhu8jssaABuRp6ZYNupeTvWpK1egM5esBTRCykeW8ookIAsaCa7BvbQp7d?=
 =?us-ascii?Q?CFJdLQk2ucAR1M6D6oKZgODOu4CaGSEpwscyqh4lTDxvYqzXvkrkaDMGIneo?=
 =?us-ascii?Q?b+cfmr1jDvfOxpdccyqP5oQIm3bDLZx6Bq7ht9WY8kXoJvZLpnV4d8wYULW7?=
 =?us-ascii?Q?DBAxqPTKyE0iduZ7CFlFrJ2MvcL9NbX9v6jT1VMFcIWAfbvYvXTk74B6QcEO?=
 =?us-ascii?Q?iSRQ8l5GQTjT4LcZT3ZFi+zbj0k5fXeuG3azRlEeeq+1o5d+KbTAFFcHqW00?=
 =?us-ascii?Q?iyrnywUEgj4jrtsoY7DgpTolSFk188MkZxdP4+8zO1sINalQdbCS9PmZwIJY?=
 =?us-ascii?Q?R5Gbx195XOMVas4rx7qPSr8gRYCr3eVyB9NGOjAwqD232qSLK6hpUJwnQDQm?=
 =?us-ascii?Q?777k/zy+r1TtObCh9KUWcaay5jEv8Diz2rZgS+O1nRzcop5uDqSmlxnrEBZf?=
 =?us-ascii?Q?ez7/vHCZzHKxApg3y93TCNvfRfmfhtvkUcVLqA24e2IyYiGq3zIVWyGe24Bp?=
 =?us-ascii?Q?pX/dI8WvIN75pjG5WQvhfYBe9sP6Ayz83vokjcdQZN6w/cd0ewink0va3wpH?=
 =?us-ascii?Q?d1BmXHO9toHbYPzNeGysGSvn6cJzXbVjykE7h7BZRPfUYMVLtDEdF6C2WBqj?=
 =?us-ascii?Q?ftViSHalPryXPpx4yY1TwtJuJPWx8/P5il89o3uGf5twZPpJsF5F8sXCFsCh?=
 =?us-ascii?Q?rw8JVpReToxfRZjnLWbO2lPBNvx4I7JtJk954QeVvohsAUJjckEZWZKJHfNE?=
 =?us-ascii?Q?xYOGb8WXGQHbPTdhmWnwqJgkBBA7dQih94cSxbBmrODNdfe+GuMAFsO+h9c/?=
 =?us-ascii?Q?4N21aucstp/OrzMPQexqbdLKOx3RoKxAT3Tol87fePnJXi6xEEjoaH3Xrmz6?=
 =?us-ascii?Q?/zEgXpnRm+4QsftAc5ZYLHVmk18aC/7FUitbXb5otL87kw2jnrBem4Wu+q+k?=
 =?us-ascii?Q?xry01HyI5Pi9tfJmHVw3NOKUpZWP0b6o3s/oLkB7xkskrPvJkfhzMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:00:15.3279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9a06b3-b44e-4054-cf00-08dd7c2e3ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
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

From: Gergo Koteles <soyer@irl.hu>

Since b255ce4388e0, it is possible that the CRTC timing
information for the preferred mode has not yet been
calculated while amdgpu_dm_connector_mode_valid() is running.

In this case use the CRTC timing information of the actual mode.

Fixes: b255ce4388e0 ("drm/amdgpu: don't change mode in amdgpu_dm_connector_mode_valid()")
Closes: https://lore.kernel.org/all/ed09edb167e74167a694f4854102a3de6d2f1433.camel@irl.hu/
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ca73271035aa..c3088a2cf87d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6583,12 +6583,12 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					const struct drm_display_mode *native_mode,
 					bool scale_enabled)
 {
-	if (scale_enabled) {
-		copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
-	} else if (native_mode->clock == drm_mode->clock &&
-			native_mode->htotal == drm_mode->htotal &&
-			native_mode->vtotal == drm_mode->vtotal) {
-		copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
+	if (scale_enabled || (
+	    native_mode->clock == drm_mode->clock &&
+	    native_mode->htotal == drm_mode->htotal &&
+	    native_mode->vtotal == drm_mode->vtotal)) {
+		if (native_mode->crtc_clock)
+			copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
 	} else {
 		/* no scaling nor amdgpu inserted, no need to patch */
 	}
-- 
2.34.1

