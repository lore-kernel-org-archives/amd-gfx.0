Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE812C54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 19:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37B0610E416;
	Tue, 27 Aug 2024 19:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TLLRUUxC";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D7410E416
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 19:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyjUcXgfUzhO72FIkJw7GDx7HwqwPNAkTrb7KM9HNPVzzQog6YGv9R40qKJ31n2PUo8OUpvCYN/jaUcvLwc+sHAoW0syiT3LbetGEVqna84JSgOwbSTE7X64XOIJ89m1B6Tx6C5RkNn9h+X5f7r6h9/SBTYFa5MkVypfNq0WiBbAdVidnPVGNCQJ+wL1DbbZnTEUdT4zEDMAI073BO6pDHlbRexG8jXJlMWFpiQ1+tlCAgJNTZkO4KfZFaiAUgV/3a7RV3AA3K2+ejQ4nTuju3pYUzMr85z/jVdrwMmxKdOXF4cRRyCsrupO9dVkHUuIckMbZuVBVSZfYlKlabu9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfc0gIPC0OoS4bPGyniLL2NDSQHtOrUtSYoHO1s1ynI=;
 b=G819QYlVCuDGYB9jMFpAISPWjZQrP5EU1RVFbrTmq19KTplFf13ZQU8RR4NgAL3lNil6XwsFJjzSx90o+nV6K626sOTNe8PQ6x/B9Nl/wa29b2sfL2yrTymKu8wAXP4m/0jDAsn+pnV4gCyadVxmmHFTipeFti/FlCsi7rij8LXQDXeI4ZydlAm5s8kp2mCH3btOrO4sBoFOD7nPAHzpm1TqU/kK9ssiFHNGZ/JuKD/a6Ne0qs+UZ2dnIPaSDJq58ywjRc6su3K90pqH9UJhWxMIGnyLFuYx/hct2aqMv51aD/5mQo/m9QLyEz1R/laqFsgy5bKEzkRvNwuVu6ilHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfc0gIPC0OoS4bPGyniLL2NDSQHtOrUtSYoHO1s1ynI=;
 b=TLLRUUxCctC9z24dRrmAghWDvcy4BsQFui8zzZcn0WgLOlUYowmvDy1GpjEHIw21i8ovqCRx+fBfbcQHPdwlb7iu1EuQyn4pwGg2XSJ8XpV+dnqnwSWMCRfj7mZ0x6hW37GQNbicEeeGYkvu4+Pny4YDJX7l5DIpu3l+L6mnhSs=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 19:53:33 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::1f) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Tue, 27 Aug 2024 19:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7939.2 via Frontend Transport; Tue, 27 Aug 2024 19:53:32 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 14:53:31 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <chiahsuan.chung@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Determine IPS mode by ASIC and PMFW versions
Date: Tue, 27 Aug 2024 15:53:08 -0400
Message-ID: <20240827195308.92171-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 18562e4c-2f78-403f-242d-08dcc6d1edf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lCwAqxdrSraZkOuU8zB6+JickazWZdYgPZpe4ywz5nBncbAWgzAYZpM533By?=
 =?us-ascii?Q?D5R0dXMuaWG0qCP/I+ewxy0J+FhskyQunsSL9CvC4fqNIJ9fGQu0OW+7xyHE?=
 =?us-ascii?Q?OSRn3OgM5Vpm9soEN1EiuwY3ba6ZNywK+ot+USN58sZU89GNsce9+BajILSd?=
 =?us-ascii?Q?BuajUvcWBS9Wdg2iH+hhUj/npEOS27nUTZr78zBIrxFm0la/Pa45uyjo7FL3?=
 =?us-ascii?Q?9oGjlFba+CpzhRTR2z3a+qYiGZVhAKa7e+qVIRNUOYCDSgTVpfhQwVcB9In3?=
 =?us-ascii?Q?dNWkSmqfydg+v3PwdIF+W4FNuCBAIiu7RbM9mfqA1nJVuR85Ll+np0OUb9ty?=
 =?us-ascii?Q?5VaVv/vUHuUPosxGyGfKPjtffZrP0TnA2llCn+HmQOKHah6ysU+Gl1A2DmkG?=
 =?us-ascii?Q?l1/Qhbn8eout2e45tYkPevhzWIfuEYXp0syWfb8kOCaordFrCqPpgACDN7ir?=
 =?us-ascii?Q?Lwx6Ayqs1F7zvPOgTV2pm52qtRIbH8YnVAwwHSNkS2BsKmyv9q+UV7L9eEJ6?=
 =?us-ascii?Q?0tZV3bE2945fM0j97we/4/I2NaKV/Yl5Eqey6cIbCctNgCNkjDFShVf8qogB?=
 =?us-ascii?Q?z7CuCiCD1HTXas7zGh/fhnBpELLhJuClaiY2az2UeGgWijLbHHWyimzLVtVp?=
 =?us-ascii?Q?umjwJ92zxzynkgAtUWudcphOavpejic2MobJgKYrKjz6uyxI+m2XM38RqPB+?=
 =?us-ascii?Q?xOzKhoTllxkqAeYquuKSGLhQ80in63r8G104VPm3FsLs8Yvs0V83d208z5jq?=
 =?us-ascii?Q?YBovpBL2So9zpncKMU6hARtjzpxisv2UNpdQEY3JnNFNk0YjITm0awWLPIiu?=
 =?us-ascii?Q?lHELp2FJH1LH1KWGl2e7qeBW7Pi0yJeaJKR5fp+lSAgiZyYYBdizOzp5MB6t?=
 =?us-ascii?Q?8rPv0bj3s4GOl/S6peiOHb0YpurkkWsxnDWK71+ECFc+9mRc5c7QVR69yLYh?=
 =?us-ascii?Q?LRIzs/eD8hXx+ib3PkKUl1HFzMMtnjoUatjHf/ZXeGmug8joGb6B2C+r16D/?=
 =?us-ascii?Q?+/lEKJpe6KpplBKvttZvLlPx1ifXmb8zIVp4Rju45jHW5JDJ7CKQtRcc6cS2?=
 =?us-ascii?Q?GB8qTpMi+sgmkOK9ZAKitgvbb0y1B+8r3mMGwn73UOkSmDn29f7/lw+iuS8h?=
 =?us-ascii?Q?3KHZOPF5HzanaMP9DG49mFUoFAN61xHuDu7Eeh8pxjSCA45pnZrhm7zka+dv?=
 =?us-ascii?Q?4Fqn3ba2IxBaN3QwICFUfVHh83pLk0F73PnELn0RWuvx/fIMMPwl8IC4LKVH?=
 =?us-ascii?Q?Engo/J0M4Y8V4T9lQILX0nWtIL5S/XJd5wq1qReY0RFyh4fUHY9QnwXMYPUQ?=
 =?us-ascii?Q?JvUZB716C/uie8QIdYlobPC7ko5zbW8NmbwjpOIRP4Y4NnNDU3RxyD8VxlVY?=
 =?us-ascii?Q?3BLTjdSKcsTtuMFaSImD3o9BQ7NttGZ6whtmU5w9bOn30UR1cSnwa31hyyUn?=
 =?us-ascii?Q?1+kCVY4TJYhWuWo0VjNV9Scn2q6rkney?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 19:53:32.1979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18562e4c-2f78-403f-242d-08dcc6d1edf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

DCN IPS interoperates with other system idle power features, such as
Zstates.

On DCN35, there is a known issue where system Z8 + DCN IPS2 causes a
hard hang. We observe this on systems where the SBIOS allows Z8.

Though there is a SBIOS fix, there's no guarantee that users will get it
any time soon, or even install it. A workaround is needed to prevent
this from rearing its head in the wild.

[How]

For DCN35, check the pmfw version to determine whether the SBIOS has the
fix. If not, set IPS1+RCG as the deepest possible state in all cases
except for s0ix and display off (DPMS). Otherwise, enable all IPS

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a18ecf8607232..a2e4973a4f6e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1754,6 +1754,30 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *
 	return bb;
 }
 
+static enum dmub_ips_disable_type dm_get_default_ips_mode(
+	struct amdgpu_device *adev)
+{
+	/*
+	 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
+	 * cause a hard hang. A fix exists for newer PMFW.
+	 *
+	 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
+	 * IPS state in all cases, except for s0ix and all displays off (DPMS),
+	 * where IPS2 is allowed.
+	 *
+	 * When checking pmfw version, use the major and minor only.
+	 */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(3, 5, 0) &&
+	    (adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
+		return DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
+		return DMUB_IPS_ENABLE;
+
+	/* ASICs older than DCN35 do not have IPSs */
+	return DMUB_IPS_DISABLE_ALL;
+}
+
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -1871,7 +1895,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
 		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
 	else
-		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
+		init_data.flags.disable_ips = dm_get_default_ips_mode(adev);
 
 	init_data.flags.disable_ips_in_vpb = 0;
 
-- 
2.46.0

