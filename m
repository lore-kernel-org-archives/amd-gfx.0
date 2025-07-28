Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFFBC87FC9
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 13:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C0210E505;
	Mon, 28 Jul 2025 13:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HM09IXrB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E457A10E502
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 13:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYK5D3IjAsKNfhugfKkA6vmc4dDJRgU5/n6wGG5VuE9Q4nB+y3WPWxYFNN1A8EiqvKumRL0++Hq5Y4zl03PvCGsG4BoNwXsMvHkfdn1FaR97TIEJ2eXFFl4smg2zPI0pFinwXEGJrU+hjqR1Bi3rTt4cMKDrb8wbBdYMPBZvxH3C5/Knluki/xcub3QSXJ+7zKKK4X9x0FsWmQipQ3iTXA+tb7/H43MgQByog2+gf9hDOPBJB47hcfbDYyBHQ0KKFJot9fdky275SKMmCeKDgIQnE0fmLebVVBc7FUCpy0wMUrpme0djkrC/YvwgsIG7GssS/MJyCkFyjDvm8dpRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1ZxdtKMgN64mMpH0vF4bBs63/pmXiZXtw2s0zP+eZk=;
 b=sanuCyPW/hHGaIjMtD6kFUkLsBBBnByAXzph3FSRJHYaMjQIR/v1HW3TTAEY7ekeJI+E9ENCFx+u7AuXyEYtg7cpw1r/nZfv0IaLLR8RK08E3UYQ1QNyYXRG+vKYxdKJLnOXxDaY+yhhzFJSx22M/Wb6muFVS7bkwmQMi/4KglNubU/ArIVO1sBPdapVv8uNF7RpeALeh8winxK+5AwYK10HRhs0uy1OJ1H7mhT0xy2JLgKBrMBOgzVp54CVKRKc3tEkm0oL3rRuoPb/c2wf1GNz9Q3hxoc6enAMjC2VR2tMXJ2W+DfuSuRSamc1UoQGlo0a6F/fkU25pJ1JVPa5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1ZxdtKMgN64mMpH0vF4bBs63/pmXiZXtw2s0zP+eZk=;
 b=HM09IXrBQI6lTfGwToPJD/mZfcrivboY6FC3bXXazA+J2EEVu4OYhI4nz6RTqt6P8X9KzRCbFO/gk/hVrIP6cmG505Q1N0Nq/mYvLkGalqbLwXv0cwmnaOckyBFDK/sTIS5nNL7D7efEicdxYn3qWHQ3G8buJi/mCmxxS8XWCEY=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Mon, 28 Jul
 2025 13:01:56 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::85) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Mon,
 28 Jul 2025 13:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 13:01:55 +0000
Received: from MKMYUNXIALI01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 08:01:54 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdgpu: skip mgpu fan boost for multi-vf
Date: Mon, 28 Jul 2025 09:01:27 -0400
Message-ID: <20250728130128.875-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: d1dba6a8-b91a-44e4-2144-08ddcdd6edf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xUvN1p2A6CLZY3+gnZX+GYcU9FxP7Vg20qf+uau102HGZHyzwh2WOCLMFJVy?=
 =?us-ascii?Q?+k44/VoUigbNgxjYMVRS9mvXnLSOgxzUtzJhudVvezVHaViUHxIcEnK7BRiF?=
 =?us-ascii?Q?DmDOktslUuprBHwkgMRRQwKa3m3AFjsHZqQ7AyClqZNv1T+lA9WKtdjhBWaP?=
 =?us-ascii?Q?gdKCBTNbELq/zYKkW1/VmenHV+6Uqg78V/OUg7px2BXLXSp8TFvoRH4cPdzN?=
 =?us-ascii?Q?XPAIKCUwApppnHyW4688N9RyJ0Ep5OXlRTbXUmtjfiWVHM4YHKbJjv35gn/m?=
 =?us-ascii?Q?lVOeI9lb7Qw01sCYVEgueLPPhinqg+ZrFRC1//RCsuNThE3IFCMWJCZXxHvl?=
 =?us-ascii?Q?xFCxtyuto9XiGz30Sw5KjX8JCv3IFH0BWFfmzojx9jfz9GIZ6Vo0PvMHFrLD?=
 =?us-ascii?Q?4aLN/7OmaZ0tNnNQVhceAjtG0ONFZsZ078TGbk9wFHwIVMXvesyQrr44O9WD?=
 =?us-ascii?Q?UKw/KLVBlwgZNZtYnYARp8cEUaDinNBvEug0KVcif0dS508wb/SiXJ+uhI4N?=
 =?us-ascii?Q?fv6s85YAkBLDjbzkBod+bYrxs/NYdiqrqk+eoREPUROtDQa2epoign1zUnF2?=
 =?us-ascii?Q?N2Ma8CTxu6IWYstKTLPII6eRuHw6kk8lOqRTEl2vuVusGUmTTH1txeXgPrPj?=
 =?us-ascii?Q?pzyGa4IMjSn6vmg5mYRxMh91KLipSqnfJqfhiKDV9xtNPftxn07nyNWP0nxy?=
 =?us-ascii?Q?X0iBbUC9oNlJRgWXfhEabpIWC1HIeMkV9aMwI/RQY7xCqUFiH/tpjk6jOgRA?=
 =?us-ascii?Q?cwkj4tUrCSm5hadysb66v4kq/uN0qtABy7fSvns6j2usIm+ReeFrK69xH8gS?=
 =?us-ascii?Q?h0vbWRyY0CHtmMx6rpfDaCYPv3925cO2RysvinXtIwC/uRr5y6L+SLMN7FSS?=
 =?us-ascii?Q?7/xM6a0KrQRAZ68myGT/iKNIXCHM9yyPFuAAuMw4MTMBFdWpkfAhB++gt84h?=
 =?us-ascii?Q?fjiUeCvolxSXlFzE4HP8ufSY0Bbrt4CxrUThsfo5TonYjgYMT4Q7qeeG5BFW?=
 =?us-ascii?Q?i9faWZ5NKD2Qi0n0OBHlivFAg/hVLcS+1gFbaKJsRdvdBG0pP5PPU3KbQx3Z?=
 =?us-ascii?Q?XfPsQCLX0r8QvPoU1SJuCK38utbuR2FA+PxFCspA1BwYvzK8fucmdxJD4qK1?=
 =?us-ascii?Q?u82JdMhttEz0E4BvEIMZgpiI69y8RHDl/AWFtXOlc9dvsGOSMSIYspfoWlsm?=
 =?us-ascii?Q?6Rhzgg9lBkMu3up1fCyb6nd7mypgx8MWtE07p/pNW4s6JNGs17xTmPQHUc34?=
 =?us-ascii?Q?gy8qjq2HeVy7YqAY8DoqMZ9mAMIHEfzw8HL3C4lYHxu6TSGdTB3khtyHOR1z?=
 =?us-ascii?Q?ebhlUxwjwEx/GWFKQBJ2bwEvBTBU4uvRpWCJyxSf9o3BmrCyymB7Mi0IE8um?=
 =?us-ascii?Q?pcAMr/nTbr73dRECl2+F8PFNn7Wk/OUDRqBzsm6OU30qkbLcDZBzFFIEHdqy?=
 =?us-ascii?Q?/AYveG5nNtq2+aY3hG6NTBVsaw3GRLoa86NgSz6aVD9X02Z2O1A1nX6abiLg?=
 =?us-ascii?Q?7NqYoyem9p43ovw3NiROErglFTIeVXQQLmDa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:01:55.4724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dba6a8-b91a-44e4-2144-08ddcdd6edf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
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

On multi-vf setup if the VM have two vf assigned, perhaps from two
different gpus, mgpu fan boost will fail.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 684d66bc0b5f..e0faf7200ec5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3389,7 +3389,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(void)
 	for (i = 0; i < mgpu_info.num_dgpu; i++) {
 		gpu_ins = &(mgpu_info.gpu_ins[i]);
 		adev = gpu_ins->adev;
-		if (!(adev->flags & AMD_IS_APU) &&
+		if (!(adev->flags & AMD_IS_APU || amdgpu_sriov_multi_vf_mode(adev)) &&
 		    !gpu_ins->mgpu_fan_enabled) {
 			ret = amdgpu_dpm_enable_mgpu_fan_boost(adev);
 			if (ret)
-- 
2.50.1

