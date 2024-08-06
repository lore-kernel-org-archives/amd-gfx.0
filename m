Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C289BC49EA1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 12:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE0410E102;
	Tue,  6 Aug 2024 12:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fe2w1CGc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8A610E102
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 12:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rk2oonMpUrVQ6ZI2IK/pv5jrvhODX2nM9Y9m8sUwmZzg1U5VFrv4Hdi0AEGGXThsRj+fV+TfTBdxfG+lcJhhOmASoiyqZ/7KiNa/Sjo1erV0riv7EeMDonWsYjwcjQ0j1DJS9ZPYKWnTH2hw0fCuaRIeILJ0APEyPOzdFzZ5G5z9bG5x4oo0RhqdoDPHpVCiiyvD7uSjXCWs3QByLhl+1BvY0fEZsaEJrQMRkGIi6drOXftq+vnuspRKf8fyDsiKocOBSW8wds5pB+2Y522d/02a/6oqLkTqw7ST8caV12W7jZ1QRIak0zvrKI6QNwFMLcBu40i0TpkB0g2iXMUQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBvwHwxRp/YRrrYv3aSqxWtSHeIJ9cmPcc9I+CB0A1c=;
 b=IM3EAmRtl9v148I4xP2nTT/67CEBQSX8PG+ZlYZ6oMc57jlgyc5CdIy4KoPX3K7V2bGBsO2UALLv8VhsznMUlePJRnjgzhUz8Fn2wHwI5DrNqAJsUxV1YETUA/UlSB3ihJjJZ0LNKkIOtm1U5nT3vqj8RxOmqERbOqY8wMA8CIaViSVBnD8mW/z56w9cMhad4gcvKz4wakqOlrF9cyV7tBmgxZ9WiC8phS9ma8nNjRadC/IfUprNvZFOMxp42sY+Ewa97PPN2mvqp+dhA1e4hZcf3wAYyb8BGPiqQz5ScgeEo1YZxL0lJoZFhJXBLFJbd+ZxmVt7cy+08aIFCMN1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amdcloud.onmicrosoft.com
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBvwHwxRp/YRrrYv3aSqxWtSHeIJ9cmPcc9I+CB0A1c=;
 b=fe2w1CGc+GpN9j2GRxSSw1No//Zl8un3VNaiuO5Sgu4yt5YwtRSuCRgchQjqlwlHAhhJffYF9Ate8G5Gp+ENPnPIkhxBGuvZyGDZtkqMhKaopijdzZR4VXam7ZcdAyNDADoBivVEZDVGP3IFCwT0VHICCGdBY3PEMcgzw2fX074=
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.25; Tue, 6 Aug 2024 12:42:57 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::90) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 12:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 12:42:57 +0000
Received: from mkmvskvorts01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 07:42:56 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <Vignesh.Chander@amd.com>, <Lijo.Lazar@amd.com>, <Yunxiang.Li@amd.com>,
 <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: abort KIQ waits when there is a pending
 reset
Date: Tue, 6 Aug 2024 08:42:35 -0400
Message-ID: <20240806124235.444096-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <df43ccef-651e-46c2-8d33-8867dc75a02e@amd.com>
References: <df43ccef-651e-46c2-8d33-8867dc75a02e@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e62dc9-9bc9-46e6-626b-08dcb6154c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sJDwCC9nu7pefULmtFF6HbJp2T3GwnH1WpV2AW2W5sk60iNoSeH2EHXh/aQp?=
 =?us-ascii?Q?1NPaHT2a8YJTF7xbHMDlX+YjgTkDJpO2ZB4sNZP0jeEfEuqLpxO2/E/uJ+wA?=
 =?us-ascii?Q?1y4V7WLaAtxyjJsXGTLZxgj9tdhx8cb67EOY4WW92M/1s7Qz0zqsOA7tDKcG?=
 =?us-ascii?Q?bGhyAo93h2c9+iZPaY9Nn14IbzxCBRmpJn1GAF2Cr6wk+DUGbDnsxb6gEufC?=
 =?us-ascii?Q?lo05hznpG8sL8NeR+vBKUrGZrg0o/3sKKZFfZ3gVDaVDbDB1psZm3OcbsKgW?=
 =?us-ascii?Q?mEd7Zu19ZHhu+QmlD4ffK7hrUFPyfDX0O58ouFz8UtlXdxWFqgS+53VkUtH2?=
 =?us-ascii?Q?69sHZdkfjP0AOwiL0LgUfv/6csUqcsUlsKaQVx9ZtNjWOIHK9MgYEEjWJUJT?=
 =?us-ascii?Q?Dw1KNEyPXRu01bWhDhnXzHDONxnpNrg2NR14twxbvt5GybkdRRZvt5T8kHte?=
 =?us-ascii?Q?s91e7mrxHkZAL/CYr7+YGdVnaHsGvjBlkEngNtOOXtgvaYuxzNkbbc/omPwR?=
 =?us-ascii?Q?CHFS+jerdqnWoiS/KbFzNCDVqNc/drUUbzdg67fzict/Ob4M4PsQqE+f70cO?=
 =?us-ascii?Q?288WQ5Zd6pE8cGnba5UExiwT9dw+i1xIHq9igDIlPCMDLlGbYevlS0VePvNP?=
 =?us-ascii?Q?Kc5P2FwNRffwR7sqhWz43UkBHm89ZIWEkLELcE37DhtxshaJKjikP/ihQcFd?=
 =?us-ascii?Q?+k/FlCKTMxNMDeM9Xxoh+IvtRx7mqvzVtGi/19DVKHA8YPfnd+7BSK4gjsD9?=
 =?us-ascii?Q?Lhbd5jGySlPwBOyOsq12ChuiTjqOoK5ztCTec1HbnuUsjXf5QFoP7GY25j2V?=
 =?us-ascii?Q?wLHmBcUowOV7KHhpAAYf9132Rq6cRUmNnZJz77V2YPCUpzNxcJVARyhZR/WU?=
 =?us-ascii?Q?eF048DHq5w5C8iHjORH/aOATW7hFHyIXuEsIaXrC+rRK9Cv5rLkd1jYFxwo3?=
 =?us-ascii?Q?4G1rHJibe54cIcAyyDY33v/2bdENXBxsDAYB7DB9HyIBh9hu/Swj7In9DSP+?=
 =?us-ascii?Q?xdsG3pxhGBN/J9Qkted9bGPaG1hDbdj918VzduLr4+FEvT2xxTxauRrEkMOH?=
 =?us-ascii?Q?GleLPeR1dSkf4Vkhml5FXXU1UrM5sGiFQdtywXkYXzjNutNZ8Mml1oAH/cVD?=
 =?us-ascii?Q?mwWzGaRLZn43dUEyimKl3BRssZIuw92m0aA/+XAMIFPwrujhGhUCChlc8PC+?=
 =?us-ascii?Q?UNrgdQR37rjiHpUchD17Q6NCnPSE5LUvyyC+8xe2zYR7+6Hg0JrbhF3xH3lR?=
 =?us-ascii?Q?eJ15+5S68pdyh5nVDXMvCBfugX6ZoL/gDGfs/iP3bmWb1/tjCFeEI+egUfT6?=
 =?us-ascii?Q?hcnH6JA3GxQKZrrNAx+rEEK7Vr9K6C1cQgN652UaaUCX2s9QF813LqSUWxQr?=
 =?us-ascii?Q?CjbSnt+i+yEFGcKU0IfbkSG7BKgJzjpaB1wop56sjTFs7+WPWqN9evnoe9Pd?=
 =?us-ascii?Q?EWTHcT4O/9OPeKvAHBigXFfBO65mOv49?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:42:57.2971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e62dc9-9bc9-46e6-626b-08dcb6154c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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

Stop waiting for the KIQ to return back when there is a reset pending.
It's quite likely that the KIQ will never response.

Signed-off-by: Koenig Christian <Christian.Koenig@amd.com>
Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Tested-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c02659025656..8962be257942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -785,7 +785,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 		goto failed_kiq;
 
 	might_sleep();
-	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY&&
+		!amdgpu_reset_pending(adev->reset_domain)) {
 
 		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
 		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4ae581f3fcb5..f33a4e0ffba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -136,6 +136,11 @@ static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *doma
 	return queue_work(domain->wq, work);
 }
 
+static inline bool amdgpu_reset_pending(struct amdgpu_reset_domain *domain) {
+	lockdep_assert_held(&domain->sem);
+	return rwsem_is_contended(&domain->sem);
+}
+
 void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
-- 
2.34.1

