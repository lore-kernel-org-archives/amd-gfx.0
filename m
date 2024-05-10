Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7487BC10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4141D10E04A;
	Fri, 10 May 2024 02:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5o6YWRNz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B9410E04A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2gErFIwXEpXCogxVUX7jphGPFZHPFwCrjHAc6s+A3AZMtj+m6VWkbrfhVF00p2mDKQZ1RfrfZvpJj9Lhwn2oRrSJ/e4QeTORp6hvOs/8kFXwXvcQLjKBJSy6tvzshaE5SKJgqM5XiAFGh8XlWqht3O2548m2G1Cg9RFmqkW+89GsKkzqDaeEwjE3vm1rN1BRpnLKWM7najyCLCNHMfmygx2sCTth5ffSADW3s/ZDyRKQX0nyGuPq4lYy+nF5Pe64NzVL/CdMybt21ozbVIPIN4W0IrYxBrHuhq1Eulet8c7DhF2K0a5zkAfHT6cxdfJNqsa9a8ZHkT7dZ3hU7rsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SbLcdOk3sA4svYEyKXUMLuWcMjaHZ5IWVXUB29wass=;
 b=cd54eZktceTXCZlIVEBaFX7mABTfeUoxwGJD1Zv357/uob6PtQ1YGdnsNOEZeDpz+3AVwNO7VGAjRJKbSM1BdirqPKT5kbpWUV+mK3Kgi/C7Um8T9Kpe8I2uFKq5fAYvrJWsUFOSrnaBEEz8qWG1OxldVnYwS8AKKB1j3/m0WcQFeWGk/+YhydEMaT6VvTVab64pwcQfFhllxaY3enThhz5ELxrkFP44XPNgvA9RBBU0QuMa4fcPrE0L652XvQKZzIjf41M57XBOFhrB81aUKzn27eiooKvBAL8+D39HIjTpHFpcobwaMK4OgOy4oX7rvbxjYJbuffbaMmrmtK6chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SbLcdOk3sA4svYEyKXUMLuWcMjaHZ5IWVXUB29wass=;
 b=5o6YWRNz/Y/qV9Vtsl1WtRlHFDx/oFa8jI3fsJHiITeJyxLfIs2vTOV+3/UNm7a8efS36AkzKZEb4tfzeUJHkD7pUryVNjB2L6WRpmW1GboxJwBuKl3R10lIDu4Eeg8CEE268J+xvY5TuE6bT8OhTPBo7Wt/yjtKDWavkUQyftY=
Received: from SN7PR04CA0213.namprd04.prod.outlook.com (2603:10b6:806:127::8)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Fri, 10 May
 2024 02:50:59 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:127:cafe::73) by SN7PR04CA0213.outlook.office365.com
 (2603:10b6:806:127::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 02:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:50:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:50:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:50:39 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 01/22] drm/amdgpu: fix dereference after null check
Date: Fri, 10 May 2024 10:50:17 +0800
Message-ID: <20240510025038.3488381-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe80369-8257-4b64-697c-08dc709c0584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ORef/DW8Z5wLIRLl4/qRnsDgwzH38qiQW5SKQJyuwXsa+E8Oiy4Yr5EXsQa?=
 =?us-ascii?Q?/7lBwPPSK8TCRdei0gCavBSYffnEi6OqdjA/1kq9gXbKTzzzhF5B6JM7U+Oa?=
 =?us-ascii?Q?ukLmo5cWsYHu7t5E+6VUPozCeA/MwarXhTzdHYx+YihNSQ/uBXwoZCQcBD7Q?=
 =?us-ascii?Q?4FBnklQAPGIMPJLCZFO0ZdBNOJ2LS7nkIAnOp5uwWFFfrMCzZCrT78M7HbVY?=
 =?us-ascii?Q?X0kao6HtjUJFjZqJmHRq4fcF4lDD8ukVL+0X6/EdUcSSEdw89dNB6/+TJxc7?=
 =?us-ascii?Q?DQX0+Cf+EammIUs9t/OCaLuHmswucJpcwfR2PV/e+9y46amxrkqWcsXb/y7J?=
 =?us-ascii?Q?CmTox50GM8mFPDR34G9HXap/Z3tBqq1I0EcixYYvI7lwDe8VTJ/+yAkOdrRe?=
 =?us-ascii?Q?jdL82uoB7Gr/RThd6/pQ3bHIEfAcziv8lhvVxfSLpQu+wzJynIE2jruoFuEF?=
 =?us-ascii?Q?+Dx/ITgnyxyACOdjOo/AGa2yCVjkmFHusvMGJwk3CD7RUhYcsaIyy6XmVIE2?=
 =?us-ascii?Q?adiMr63b8VgBwJhakyQuhPLWM359sEBnKSp1gBhuicK6BiZ19QQM0sx7wOmu?=
 =?us-ascii?Q?7VRxvRlDQVEsGlK3ycKs2/YCF5OgCTX/HK8rAdbP8BnDl+sbAn4A6cE/WIld?=
 =?us-ascii?Q?2BeTBjmHYvZ74nEes2wyWtVdsFdz7+rHJ4rekOs9b6jQQIco6KKM3/DqJ05A?=
 =?us-ascii?Q?lkLlKmbaOcb1f6vexHV5rAacr9is6msRuGvCqAkQzpbFKT6i+wp+l9W5FMTG?=
 =?us-ascii?Q?V2/LCXHNFbj7+iolqP6LP+leydYNGowti7RiBfnQJIjN9+/tQqtedMnG1Yn9?=
 =?us-ascii?Q?WsFRMsIk8fgkUoQsj7XJX7NsLF9tec+jvx50fUgE4RGCLI76wU7Z67t67xgC?=
 =?us-ascii?Q?s1c0z9x/wBk7wBeFRLV9bc5nBQjW9id4+fa1kolZLSwXrAR7BRd8jmHotMPM?=
 =?us-ascii?Q?U1YLfENpUGnsitiWaIhd3g4H0jBrvYC0+eQxR+y+ZJUmovE+seOTwOWYhmaj?=
 =?us-ascii?Q?g5/8C/O+XZd8iuVWumkRJmcPNqGl7AdtpMEz4WuQTI5/giVpT5X5WILbpy7X?=
 =?us-ascii?Q?ylFXaIv9gasZM0Nss80JBIoxFYGM6v5lb/kekqV+YLssplFRa0X2pSpp0Wbu?=
 =?us-ascii?Q?mAq/9GNdC6rGGOBh9NQH8zpKEvKR/NoGUPZaOMY/nOsMQ7PDwAI31Xtra7w8?=
 =?us-ascii?Q?Bly+f/qPoqqmEXsLA6y9xMr4SVXPMqMKBHdTQj2YV9w0n39KcI6Xsgvxmu2v?=
 =?us-ascii?Q?1WctZQSSI2G2ZW0uIVFrFLxB+coEXdQL0fufE++m8CB3V3Op2uO9DPmPdEql?=
 =?us-ascii?Q?oJmQgdwZFk96DKRGUOFaxM+WfOgZ2Il1JoiMIgCC8QiVQ9w6vO/qfZ8NWnrD?=
 =?us-ascii?Q?OWO0aQLLDCnnHfotbVd9OvOKq68U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:50:58.8915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe80369-8257-4b64-697c-08dc709c0584
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
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

check the pointer hive before use.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 77f6fd50002a..00fe3c2d5431 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5725,7 +5725,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * to put adev in the 1st position.
 	 */
 	INIT_LIST_HEAD(&device_list);
-	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 			if (adev->shutdown)
-- 
2.25.1

