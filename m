Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B2FD374B2
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DCF10EBC2;
	Fri,  5 Dec 2025 21:49:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qLO3TcUs";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14DC10EBC2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn56JG2eFtophkbxonU9oU4xEfM43HfNRDCgoSvisI4l71orpsU+RNSwU19AkMKuw1UXQTKV39wFsL0i9QAZqLeglkbjmPjHnD3teghu6ar7F34asbkC+oYgPHMuqUU9TiYL/mqV/bQedmoCq4A09frpY2t3awUbY78/qen/WLMje3SCj5nUqCWxzOwQ3wkhWE4h6Exm8IgAYNAQqQV+2kWSh9OBIEjhmZavROXd6MXeJABRvhR2DdSFYNGJLVmSGjuSkopCFUiUPUuhvJQyM74FIeqw8m5w6EhInGu/lcG+eAjDOXhJfBzTbGda9WAkOga5Yqrs/PhpgEWMS+rqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYa1L/+Q0Eu9TYCuPe6kK32J/tjhYNP6Rxdtqi94npo=;
 b=AVJEX7LeZVvGEeUedq6OYv1pBS/tfrD65PSq9Wd4nMraIo6VrtrniakTa4O3Jg1pQxUkaHRkNeeH8s8n7oYo6euD/38bXy9VPshkfgu+0qiLOZg6UrW8M4yfZlG4k4VWmcuY38eQs33bCc4TO4xSugMdFDFg0KlUv5uydgTxEPydy3SElerZtvCD+nOMaFz/pZGeEnOfsN1ldE9L2XhbiDA4YVqrbjzxNUdNQ8/t3cjJ1TQvvWKR3PDhNU6+bJrgWFs4n6LqIz3Hx/JKiENS31vhC+4b5yF4LLoTyK/Kaqu80vwOeC+IR43ZsIWnXElewxQcAhz4xQ1B63FolURf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYa1L/+Q0Eu9TYCuPe6kK32J/tjhYNP6Rxdtqi94npo=;
 b=qLO3TcUsj780nIWv4edsM4fqVFTvpyX+IR+isKIQmsR+w5h3z8JXYGnX0po21Gl5eKEgyIYD/kLUJ1h6ZpZme5QebBNx+5c4G9CT5HcfHsUT4rCpYPkO2fStnAgDPR5K9Xlm0CQvjRZ5kbhGYllZh7qWk+mnCgigsyQVshUym1k=
Received: from DM6PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:40::43) by
 LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 21:49:47 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::95) by DM6PR03CA0030.outlook.office365.com
 (2603:10b6:5:40::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:46 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add get_xccs_per_xcp callback for imu v12_1
Date: Fri, 5 Dec 2025 16:49:20 -0500
Message-ID: <20251205214926.146844-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6ef268-74c0-4628-643c-08de3448352e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M34oxR2UU+SXG/itJZi9jcpL4GqsOgCKGXdhgZwkoiaY4/xyjvueg98OWaVq?=
 =?us-ascii?Q?Pnoias3dSFymL6m0sV3IqINEiTFmhPjUTZVPfd6vKhpCR+933hGRQ+X2/k9j?=
 =?us-ascii?Q?pIOLMlAV8VC603NetaS87j9QRCtl29Zy68hNs52sPoHGaMWDWC4wiPwRHvJc?=
 =?us-ascii?Q?6f3sZ0tuOAa8zqKGqdeN9+FeNz6sqHQiiinF93/zFw7isFAg/7ZCJqfmUD99?=
 =?us-ascii?Q?ImtPWOdntJWIPmMpYIvenH3ac9cXobTgfGcwTdhXA+p+fp9Mio3D9bmWRcvL?=
 =?us-ascii?Q?au/P/s8yso/EbYbE7DgaBTUxttMLoSSCZsV7gYt4JJHUG1oXdndsVNiq9OF6?=
 =?us-ascii?Q?P2hEBUXOgFMYsdDWHXPXpqFKmSo9+gieSbxp1arwKHhnD10W9DRgbsC0Arm9?=
 =?us-ascii?Q?nY5gAt+Ms0V5DDw7AA1LL24BWXL6DhvyZ4FtbgzzizrfXknpqW55kNt3Le4o?=
 =?us-ascii?Q?o+2mu6L9E058yB9JeBbumol44KKgevuPTQJFy71m/785YIu58ufZhcMwT4HK?=
 =?us-ascii?Q?3GhkT0cwMb2DuWKRW9SYg8e+/pRbjiBxOSFcuU6kpCF1CieYh/yZKogKJGuz?=
 =?us-ascii?Q?Y/IMhDNMzRgsNIneILkcf0Djz+Rla59nEekrgfItD5GpmgDAfGEV1HxzLFPa?=
 =?us-ascii?Q?VSe/2jt45v9C9JF4GBn7iO9zc4TeDkSMRplgQhjjbjKkzoOal4k1Uun7dy1r?=
 =?us-ascii?Q?jBSqCyrABgB7ZCkfIwjRJsg4Kdp2tfhHN/1LNMrrGRFtFqNru1HvHoC1+Rdr?=
 =?us-ascii?Q?sHE5iApHBgFVGAyPXYSR1wN81PXCPqSoohH/ZCrS148dhSY03Rhr/pxSjODi?=
 =?us-ascii?Q?GWHf4YaXkDm0PGdm1sNjkHmkJS2/aEAAIoDTsmNiYiNiZ/1IhuwAKV7IvPsu?=
 =?us-ascii?Q?bSe79wANGzgQ161y3qASwKHlhmKLWsfVb/GYG+ZgCZOxotYvndAquBFKyXUA?=
 =?us-ascii?Q?NDONha5ri+S9z/w7uZK4VogGFuVVfeGT7Ag5ZRKZ3xl8Pm4kmNuoitf2g9xq?=
 =?us-ascii?Q?/EHPuLhGRlcPOkYJ9Rwy/37C0IH0EqKJ3r7p8W0DqfqLClVRf3/335duhfA+?=
 =?us-ascii?Q?sBx/osIP70Vy0PnFuhem01W8lgCdDuPUlmuR/idi5xS4SEo4oDDuDmoEPY3p?=
 =?us-ascii?Q?Tw3vyt88tGPIg6A1KX0pNc7w/cg+MfIKIXCtjWrBVmOdV7Unj+iTYfrLx2ai?=
 =?us-ascii?Q?irqyL3faV7v08Nsvra7gUumf+mq12+SSiMSsOZValVkFgNRQS8NGhcKTzxzh?=
 =?us-ascii?Q?vmPqfVZm21aiQTNLIsnm6Dddyed17hBSyX49cJ9GzWPTUrEONimq+559wfqV?=
 =?us-ascii?Q?K/N8IdJ9XtpWVFMx/f5wba4Q1nCP2XG+GEH2iqHI3pWN2jyosTUHFacJuMlH?=
 =?us-ascii?Q?xrrGWYhXshW2+HfOvVhVqBFYUdI1lQ5fFLRGEyz6xF75IgEPmjZywRGfxXDd?=
 =?us-ascii?Q?6+eJkdDA/VnbVqOMyBdGlhe689dfKK/RvhIigH6KEdwJgCsUMyovoQg2wVIJ?=
 =?us-ascii?Q?nw/FXo32gPzpmAyOcr7AS6V3uu+D0ZcPt2MjmAfN0DeECgZDF+BPFWhrH537?=
 =?us-ascii?Q?QDj19mI4ZG47v9v9GBg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:46.6920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6ef268-74c0-4628-643c-08de3448352e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

To enable querying the total number of xccs in the xcp

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h |  1 +
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
index 484e936812e45..932976b6f391d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -36,6 +36,7 @@ struct amdgpu_imu_funcs {
     int (*start_imu)(struct amdgpu_device *adev);
     void (*program_rlc_ram)(struct amdgpu_device *adev);
     int (*wait_for_reset_status)(struct amdgpu_device *adev);
+    int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
 };
 
 struct imu_rlc_ram_golden {
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index 28932604d986d..13108fd4584c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -133,7 +133,18 @@ static int imu_v12_1_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int imu_v12_1_get_xccs_per_xcp(struct amdgpu_device *adev)
+{
+	u32 reg_data;
+
+	/* the register data is expected to be the same on all instances */
+	reg_data = RREG32_SOC15(GC, GET_INST(GC, 0), regGFX_IMU_PARTITION_SWITCH);
+
+	return REG_GET_FIELD(reg_data, GFX_IMU_PARTITION_SWITCH, TOTAL_XCCS_IN_XCP);
+}
+
 const struct amdgpu_imu_funcs gfx_v12_1_imu_funcs = {
 	.init_microcode = imu_v12_1_init_microcode,
 	.load_microcode = imu_v12_1_load_microcode,
+	.get_xccs_per_xcp = imu_v12_1_get_xccs_per_xcp,
 };
-- 
2.51.1

