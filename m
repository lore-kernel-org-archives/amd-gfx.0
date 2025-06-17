Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6F6C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 16:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A7F10E702;
	Tue, 17 Jun 2025 16:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mgFa5Jj1";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09E310E702
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 16:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbPdOHwEXCeYn/lziV44ux+l1c2u8f2OfASPcF/CdUnneJ0rU56vJDlQ/xWaB0rrceLjfLj2Hm8JhWSmIULKugMbEd0MHbcVyNlKESR5BLiDTVcjlSbduqkip1BT7hGREArPkqFw7S9UZAsDuL7iry8LBhmlrmgHfFgZO4YsdIEUgxlLP+rHET9sErZeq+B6a5DX3c+iKTsmXCvNEZ3boqb/wRt44k5shgubF2PRdvZb9Ilb3sdTTKZ1UQLkCyEEdzik+Q6WSxUq+ssSPpKqrWp2NX2lqevdKXuemSyMCdcXRN5JqBzgGqUCpn1xqDE+uR4H45sG7fWMn9CC5ew4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoHk05I1B0iwNMROq5wY0So6wp4x2IeNxcfTH1ILRdc=;
 b=vZ100jy/8BYlMhL6XYHIXP4mw8UDRPIvhBP1tY0U6ROqJX1pif3IoeqtGLagIlr5odDE5OJUirizKdWCsBhmccdMI1Bjio2iF9RsONnbQc7XlP41Kx6DKY7sqc3E51OuN30UL2+roGytd5ylAB5PJw4PiyZiI6cSqZCMgmtHUPIDqDTk4roII5T/80nRgl4uBTX0Xv0xa5e3dKikpoqr4IK4fEQrRSwXwzdK1X2GnCy0V8oWH2FQZC0YJLNCJ4epTEEp77VTqb8y8dkhiFVrzBPnGlInaDUmTDc+LRr5FfwhtMShvtH+U0eymaM3PAEZ+MCIM6vZNSB9s/wduAppTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoHk05I1B0iwNMROq5wY0So6wp4x2IeNxcfTH1ILRdc=;
 b=mgFa5Jj1dPMeg5K72yqptWiW/nu8iIe5n+448J/y98WZmCYBm/PW+CHDKPYAMtIvhfvwSasFZsTEQWYk5H61wE7vvG1RhnO17WEMzEik5QUIrCJJp1l8m4ybkd5fivy7FpTA2L3L6D6Ug9NjvfAKG7AgVHVsxFb4icA9PQ5Ao1E=
Received: from CH0PR03CA0309.namprd03.prod.outlook.com (2603:10b6:610:118::30)
 by DS2PR12MB9709.namprd12.prod.outlook.com (2603:10b6:8:276::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 16:35:49 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::dc) by CH0PR03CA0309.outlook.office365.com
 (2603:10b6:610:118::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 16:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 16:35:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 11:35:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu/mes: add compatibility checks for set_hw_resource_1
Date: Tue, 17 Jun 2025 12:35:34 -0400
Message-ID: <20250617163534.68610-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DS2PR12MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: de5c4cfa-8e62-44d3-8c8c-08ddadbd043d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VXzszSuVcIYoGh8YvfFUhTidh1dYob6J/b8kQ5XUDvN4yZvBMPE4HJJV4tOX?=
 =?us-ascii?Q?l+dYBRwT1zXZCqUqfJje3YQgCFLsFKtpdBQ4cr2aSNRglaE5wc3Fz4ZVEi95?=
 =?us-ascii?Q?mES+l2zcnwDrCb4QzngYQegYlBFVhOmrlWBhvNdI5FFq0ZGGiuUlmToq5kn5?=
 =?us-ascii?Q?ruUho7WqJS3m9fAk5it9bpEjrXq4XiSaWp5egizbzyxbu6iBLcPWemGekSi3?=
 =?us-ascii?Q?ePe/WJ21GFS+8FuX5kFtUzEmF7qdExDZMErT8NPyNvkGyY1G25M+uvZ5owcX?=
 =?us-ascii?Q?uM1+VC3Lk/nErxVYK+car1uYyDyUPx0JNpiTv2x6Gk/yZHylZtojil2O/f+I?=
 =?us-ascii?Q?IRb9Ud0bFtBVSTNZP3iojIUhhSHDhD0VHH0gcVnPuRwbdBwedxhZ35ru8hBC?=
 =?us-ascii?Q?NAmc5Oi9AiIA1ZoFBibr/RcYHx+hRrnF2niroOboGCuU/WO09DEDI6q8KsJh?=
 =?us-ascii?Q?zdupe0CuKggzjF2UWGzBnGJq4XWG/yuEVSguccEB14XjKUO+n3wbV7gcv9VS?=
 =?us-ascii?Q?TZaZr8Swbd5UZe6lnP3uIByyREURoVBXZ2cp9C+6/AXDPAHIMMojYxQwswfG?=
 =?us-ascii?Q?Qt9vxWJCzG1ANXwZGb7+dQmLDpcBepZ11YRwtiuyvyCZQrPxTOSxqDqHT8nc?=
 =?us-ascii?Q?y/gSmFAnr0oT18VPVm3aKADtEVhJQVoBUS0DzVva/Bzz9bdi6iWAmQZ8nYqY?=
 =?us-ascii?Q?d8aUK6bRJuR8o5I8mqoKhMDBLZFDNkw1ODrDafSs+jG3jbY9ldbWZhmVLaSG?=
 =?us-ascii?Q?RwJ0m49/n9gzwjk4tDnBa3I2t2taHvI6TbDToOf/4eQC5JmPRG1xN8n82d+R?=
 =?us-ascii?Q?169yWOmrBxmARol/hskXXHMi7sHhGzBFfM2MoQlmg4eOHO1aglrC9mJAvzKa?=
 =?us-ascii?Q?sTwznieXS4+7HtuwE9jVjPyr+35FYF3qCCV/XzCz8AKZsqsssez9VfZey45J?=
 =?us-ascii?Q?I8lYgsETTs6dfnANNlWTHWxds36jFSALK7wHR0a1fFr4KukRhKRSta1YIBBj?=
 =?us-ascii?Q?PKgdeiZEJ80DjPoIyVrTppsZVEHWgGDmuMr8aSiMxFObYAzGlcwE6+Ik8YPF?=
 =?us-ascii?Q?losWiigBafLRgWfP7f1J1oMivd5B0603uzs7yVFf0hg+ksWW+eyPB62MBOvo?=
 =?us-ascii?Q?xPNglf9AmVC0YYFJxqM42J69nFG1OJ7YetETMPQHGk5GywErp9lyfy6zA7E/?=
 =?us-ascii?Q?B8Zov7GYbbv8LRCtvKXOsG9nKB6SKzT505xpyBLP1Z6F6CnrF+kZmpqKdOHd?=
 =?us-ascii?Q?fxIJqdwBF9LZM7FGcTLAaSE3CcwzHKEt+SsqLWqWIVFpEa2tuwYLw49yZLnp?=
 =?us-ascii?Q?A2dELi/gytqfm2vzaT4Ho/x5SDQMfZvUYanMTF0McnMy3uGmGaKvm/OjSrfd?=
 =?us-ascii?Q?YEdC6Y5t9Cijm3+8EGJj8VbHWXi6e2aijgjDCMcbOLuwhF/wMUIPnME2ksPp?=
 =?us-ascii?Q?5T9cWnPY5ZtsEsKh1hC71BoCEzQg8elVY0S4TxvKb1Og78VEACf+HA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:35:48.7498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de5c4cfa-8e62-44d3-8c8c-08ddadbd043d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9709
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

Seems some older MES firmware versions do not properly support
this packet.  Add back some the compatibility checks.

v2: switch to fw version check (Shaoyun)

Fixes: f81cd793119e ("drm/amd/amdgpu: Fix MES init sequence")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4295
Cc: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c9eba537de094..28eb846280dd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1630,10 +1630,12 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	r = mes_v11_0_set_hw_resources_1(&adev->mes);
-	if (r) {
-		DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
-		goto failure;
+	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x50) {
+		r = mes_v11_0_set_hw_resources_1(&adev->mes);
+		if (r) {
+			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
+			goto failure;
+		}
 	}
 
 	r = mes_v11_0_query_sched_status(&adev->mes);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 68bef36aae3b8..4b78e05a4615e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1736,7 +1736,8 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
+	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x4b)
+		mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 
 	mes_v12_0_init_aggregated_doorbell(&adev->mes);
 
-- 
2.49.0

