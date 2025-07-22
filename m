Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09424C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FA710E300;
	Tue, 22 Jul 2025 03:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LWnDwVnr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA0C10E300
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOaTUexcVYzKoEI2LByPVDNOLhrCNIauXBx7Y4DIvBENxYShSm4UsjNAjAhZEZsoFFEorPZ7L05PfRJAc9lmbLXniSovd4UDeJH/6NQ4poUI6MKCieIdhi6P8pgEtfgDpZN0GaRCXjWFm1AL920I3CrbzPe8TSNVOwbzKsYNA7wjlIYbAW0jNrkexiVKWZdwbThHUblvFGCmcsGTVmBwqDc42aO3NT9CPmzQeouRqCmagsTwcFVEWKrWkaQree/KcYt1gjJgu9jf88FndV7F1+qQudOpcP328+hnLKMs30UmQxAIivNG3FuMTK4KWFhJlDCTeD03OyCXEn51JW1b2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJklsEgcxSbNHArK1Xj7Rn3U4hb/gYA8740iaU16bWQ=;
 b=LC04u+zCqj/kgt5Hcbl6ydxJEfHwytIa6yQ8wkLhFDtx3SqnJ5VU14DArgRv86lpBonwZqv8PEVhD8p7ZSHkm2cRk3qAB6L5ThPNs3T3hToI1l2LDe9M/qE9dTkaFvHiTJdpttawxMbhr9uSslWbgBMae4Z4Rw7x+xDyiw1H91CQMzwXQJ7stCHgHhQkPfBEYzgn78t89qohcIokjsOCyI/solDfc8B8xt0qRn9ZWHgf3nNRafOWxNd7MjWvlIdSobmTrgozc+aSpu6K4MUp7Gl5m/oXNGQyV6vRllkGyirP0NwZCV1hLqD4NP5SAtBsueDBmshye7rLr2F2IF/ztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJklsEgcxSbNHArK1Xj7Rn3U4hb/gYA8740iaU16bWQ=;
 b=LWnDwVnramuMA44S5W0ImukaTbAgpEPWB2b0Zni3yNCkfmzHLo6tg2bsbxJygJWAk1z4bqPMtbBpqIEgjYkTSBInW+HAMVFTIvAenCk8VbALfQbcu0WkivZ4qGjGxCr6y8uS4M/gWcXzrTGn0JB6G6NwLsldPdNkxF7CPNz2giE=
Received: from DM6PR12CA0006.namprd12.prod.outlook.com (2603:10b6:5:1c0::19)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:46:28 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::30) by DM6PR12CA0006.outlook.office365.com
 (2603:10b6:5:1c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 03:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:46:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:46:25 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Mangesh.Gadre@amd.com>, <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Update supported modes for GC v9.5.0
Date: Tue, 22 Jul 2025 09:16:03 +0530
Message-ID: <20250722034603.1579566-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 165991b7-eed2-4d87-0456-08ddc8d25679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LAUMuS3U/9INR8T6dgs/gNqSPbdsEBa8kFSMmFPNljErjXQJWeumtNoMtMkI?=
 =?us-ascii?Q?NBaEoQaSqsF9RZQ1r2exp8di25xhyTtlk9L4bW4+8H6ZJlTW1ke32gc58Ya9?=
 =?us-ascii?Q?KiGPI7WEDxIa1iPYnjG+Ku36Zbp9TCumLwZh00gSwp1G/MxGW4Wt7dcci3oF?=
 =?us-ascii?Q?EVv9GOgtb1RVbUalMt9NOcNEONyw3MDs4vCYRXw9PJM0F1mu4nux+48CBqJD?=
 =?us-ascii?Q?edjzxiOqv4kw575RPkS+OcMeiN01BJkKN67SGLvJEwkMi87KJ1u9AqmbJIcE?=
 =?us-ascii?Q?DV2AeN+rDDJaGotbhYLoPCqrXlqbo1u+SNtfH9o7NHYeDIwdUF3u+ymRDgoo?=
 =?us-ascii?Q?Eu4S2RKma1APflFHSlkOIQvRAdI0+rgb5/jcjvxfMDajB6jm3ZlIljD8wfOD?=
 =?us-ascii?Q?BOfFr4IKn2zwuRQRhmZKb412vQfxMXrL338uruO0JDjTqRY31Y6apPbUywtK?=
 =?us-ascii?Q?mNtnlgHlzIWi/TFjlHxUvqXWwNbz2QGqtju3CEIAZlCDjFBs+9ju8n6gdvfe?=
 =?us-ascii?Q?A+tkZzF94PtZAUwZ6Kna4mUe0jfLRGMD79fsJgKayQ22adibCXsb2OpN8EHq?=
 =?us-ascii?Q?6durFb6EoXLv/5MQSLN0xGivCxizH+voL8y51DzsvN8eKMuerufyBjOJjsHs?=
 =?us-ascii?Q?ovA0PgSubUxhmX2NU31BJusQjBvfjpEGF9xXBe6LijwNRlzYJ9rbXdAul7O9?=
 =?us-ascii?Q?EN3yiIVMJK7tQuhrMNn8hFX/7PbtNKZ7hEhM8Xjsi9Zr3Gq3qNgSggrKuMNs?=
 =?us-ascii?Q?xjjSuhtX3M8M10EAPSchbL/U7SbM3+33OKJDZpnNZTh8ueeEQbg7FZorNcF5?=
 =?us-ascii?Q?yjfKTjVg9sb3W+ei5JddNAF4zwIA3rXcIm0NOYgJDLkM2O0p9WWqnzt6/1a4?=
 =?us-ascii?Q?GaccxBo+e7SSmm95GO8js1YmHnovlC/RLYmeRX5W7msK29t9vl63CpsGEgbX?=
 =?us-ascii?Q?PuF9X+yjUUVasfYep0GuHSq3qRMGAGVTUbrHOTiQktU+yyHD+Eput7nBe7sX?=
 =?us-ascii?Q?HkDl2nDzsXhScq0egQ6lz/EffZqFecZsg/gAG8i+B5Jk0k/hBEkG+07+VmS9?=
 =?us-ascii?Q?YCArDPMMdM4FMp5VjUmzlZlnh7an4uwhNv/3dGyScYF66MF9r4FbIdi+Suqj?=
 =?us-ascii?Q?KQ88QmhUp3mJcpyD4Fyf/ErwGekVQLEOdXNCByO0knFNG26ThKcJepRyFnG9?=
 =?us-ascii?Q?I+UgEIyB38zRUMMSsosfFuqnnXcP9PSnjIDCrCIHMlPhhQna1XdQ5R5gx7Xt?=
 =?us-ascii?Q?6HzB/g8Wy/roq3b8SeuUMWFtwWx60qrCxitekqueWgCDGIDOkhRtfVD4oH4+?=
 =?us-ascii?Q?mmT0EsLa65eLqWwR4eW/W2qYcvH7E4l0zkS3d4o1mcfbZTvmgy5AD+D27zDg?=
 =?us-ascii?Q?jpKc+x74lRWGaYhOC1MNRyC319gCQwxMnfjj0+w8airXxytGrrU5gbJvEkSk?=
 =?us-ascii?Q?Lt5AIS25plbJu6oWaqtBeWJ3zYg3luU5xX8Lef0znoWoUkqpz9iMDTUIuiPm?=
 =?us-ascii?Q?UzpjXfkGeVGKpu+5/UZxCTIHZwgGK50fxDjA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:46:27.5176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165991b7-eed2-4d87-0456-08ddc8d25679
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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

For GC v9.5.0 SOCs, both CPX and QPX compute modes are also supported in
NPS2 mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 914cf4bfb033..811124ff88a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -227,6 +227,7 @@ static int __aqua_vanjaram_get_px_mode_info(struct amdgpu_xcp_mgr *xcp_mgr,
 					    uint16_t *nps_modes)
 {
 	struct amdgpu_device *adev = xcp_mgr->adev;
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 
 	if (!num_xcp || !nps_modes || !(xcp_mgr->supp_xcp_modes & BIT(px_mode)))
 		return -EINVAL;
@@ -250,12 +251,14 @@ static int __aqua_vanjaram_get_px_mode_info(struct amdgpu_xcp_mgr *xcp_mgr,
 		*num_xcp = 4;
 		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
 			     BIT(AMDGPU_NPS4_PARTITION_MODE);
+		if (gc_ver == IP_VERSION(9, 5, 0))
+			*nps_modes |= BIT(AMDGPU_NPS2_PARTITION_MODE);
 		break;
 	case AMDGPU_CPX_PARTITION_MODE:
 		*num_xcp = NUM_XCC(adev->gfx.xcc_mask);
 		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
 			     BIT(AMDGPU_NPS4_PARTITION_MODE);
-		if (amdgpu_sriov_vf(adev))
+		if (gc_ver == IP_VERSION(9, 5, 0))
 			*nps_modes |= BIT(AMDGPU_NPS2_PARTITION_MODE);
 		break;
 	default:
-- 
2.49.0

