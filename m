Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA635C0218F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 06:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9E410E0BC;
	Tue,  4 Feb 2025 06:38:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HcJ/oRBg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2D410E0BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 06:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBQU1UFO0Wq4Cqi6NPqe5jcPrisxKY+pFwKCvn3ozV2MUjyOjFKvkuca4q7BUss0NWX7Rf4aaMemGG/8TLzYii//3AcfR9gUZP6Ac08zHCJEpSqOfr2VebjnyvNtTd++cxUmn5d2sK5mBmbuanztjlbtakvkvG2LG95E55YcaHcQvMUY4w66w4FHZ9pEKk8DNAKs7oO4dAGeVpcFLvc3a6reS2vx5CGXg73xPuVG6J9myPwwUijlVbxfqmUcGbe9x7X9c4LZl0Q8XXwpnMkVfbkZoyiqDdJSde91kQbfraF4blu2vuQwYBcCj0ms7NW94qoprNiIuDfw7RKW7+Hmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyVgLV+p4ShHJ8GtF4di1eUHIq+WadW1wnelAQd41cQ=;
 b=b/kzgIlHTYylcPKVh1TyoYRAXnCvXpz73r93uabddg1obg4sKODpLxHwyOZIWyLk7hD/pg79t69BmR2nh930UXXQg7yYPJ6QIIJH1IMjORYTGU+3YrQN2CCwrTvz66y++QsdIWqJYB0JdMWo01j+Gt3GIvk9/Y6MfW5ajpzmVTx06asWuVqeBeR/mwhDp4raufwn/vXH2yDqG6L+E0MaRKzIucEcV0pgx4tTZ+9WLSW57v/YCiMejgRA+MxZm9292JH/TXLen/jhW75HIwqIpoT2V8t281Lzoc4rswh+Bqv71tE8/7pfJGQw8WC0F4y7ggC8PIWotS27LwYgStfppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyVgLV+p4ShHJ8GtF4di1eUHIq+WadW1wnelAQd41cQ=;
 b=HcJ/oRBgm/KQLs/vt4vC9ntq1chKq1RFnyjRcxYalFUbCB7Inioe5eVKqAFyo2hg5G+FVRtW00vw4MlIOJ+nLyQ2NmHhKQPamNUP/u7cN4CbhyzZ5zbhqzobSuGxjzcWAn2jaxJcfNp2YncT4cZJUvlkkSw6j9mfgK55NiWrI5o=
Received: from BN6PR17CA0044.namprd17.prod.outlook.com (2603:10b6:405:75::33)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 06:38:41 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:405:75:cafe::32) by BN6PR17CA0044.outlook.office365.com
 (2603:10b6:405:75::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 06:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 06:38:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 00:38:38 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kenneth.feng@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Fix get_if_active usage
Date: Tue, 4 Feb 2025 12:08:16 +0530
Message-ID: <20250204063817.1865562-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250204063817.1865562-1-lijo.lazar@amd.com>
References: <20250204063817.1865562-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: f95df068-b465-4656-6b8c-08dd44e69047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6FFRX52gXN/SIDw/+Suxrr15Q/CLfpg4XKh6mwjcBPcktAac2LHnGmD+KM9i?=
 =?us-ascii?Q?nbyccBSniAHQVsXKENqG45EY++JP7cvAaf3IZdEIlKUgJsadQR6n9lZedf/H?=
 =?us-ascii?Q?Yej1xGWhEquzlLlevkz4IYQq7/CqgT9Qo0Jc4lPZL7/P58UBSDZbApuE+v6l?=
 =?us-ascii?Q?ndIkujV/EeI8Vc77OIZhiBLkLKQmsxvhEjLdZmX9gqfibP8106gGnbye+5Rl?=
 =?us-ascii?Q?Wfw5mVXBGkLQfXXGpoCMWs4HPgvdo6CCMLZeJozsJwb5k7NSbYLYn7gAdrw8?=
 =?us-ascii?Q?Z5yrHXp6Z6IN3BMX2G8/QOIdglnxDQWpSH1j83LJvqfRZLd185eDHTjkG06o?=
 =?us-ascii?Q?QmY8a+T3qoI5ru5la+4/crOSEtx5go1hpphvyhLmHknvSevp1k3I/EvroxU3?=
 =?us-ascii?Q?OMdAk8/JSZ/QkrbGi2pTGfQlQ3ItUWlDMsD+OhQSysjGz5b2d4qo69AxUz4S?=
 =?us-ascii?Q?OTf1BJbhPdzDWRK9qmtSdCGHka03D0T0gxMvsFTKncn4+8nP5ZLwlfgzsvpB?=
 =?us-ascii?Q?X0EMjxYdrYADE9mQB+dVeaOkkvmv4n/FrN3lzD84+UByNvYC1NxmLEVt1Rkw?=
 =?us-ascii?Q?AhgVOjASegyS0r5p0xQapVNcsovf2p9ZWtCfJkEnR1QkEEwvjW3S9Vyw+9fr?=
 =?us-ascii?Q?ReVX6VljHhi/ZVPFGBMlHCY7TmmYWpX22MZXmfctklwGwV/QxLdlVfCikR7n?=
 =?us-ascii?Q?mhrNEJWw/HXaKWv/zKFYy1/3ekmniveD5kch97bn6IdYM1t2JTCB57eYEit4?=
 =?us-ascii?Q?qy9/R9hwhH3ckBE2MB10jfMvP8/ITaB9E8fAM+8wEcERXDD8vgrf7Alulnw2?=
 =?us-ascii?Q?uNq9hIOgXYg+FbEFeOSmBA6qvs3qGVavONhL4fDc7isRkhTN/5fecX+aJlw6?=
 =?us-ascii?Q?vHrsy1uMBIqcqVmj34m62/dAqsvqCKuyJ+uvrY90hEq6CkaoZuVOPhgXlsik?=
 =?us-ascii?Q?4BAn/kFMEfXihwBi0cEgxoxxWfCKb3P02pUeg6QQZZlS2nJcdsatlDcK2p6M?=
 =?us-ascii?Q?/Cg/JyoHz2W1s5s+E7Ax4Oaybcrcn0UHznH+cqrYyj6+PYtm1WMcZvajD6wm?=
 =?us-ascii?Q?b4k4rCDRJQ/8ygYVtTRiGjGVOuBGmWMBSAspKrjvySnye8NiIVIS9rXM3aML?=
 =?us-ascii?Q?SxLAZr/tPWSRdMSqEXz+tcLA20blQIfxocglZ2YP2k5aBvMlbsfbD8uiMaoo?=
 =?us-ascii?Q?xvrKU9aKRXylSFAu/C9AGX8DEYEBUBwxl2td5x28mWivMb5xSRRa/xEN91E1?=
 =?us-ascii?Q?p8WDOP+318MluJud0+HXP1eqKxzLr3IhsXG2rOfWVnUi+GvMotIJrMB1MLv7?=
 =?us-ascii?Q?h7/LZudT93jn0kPq5ge4pcPcTwq+J9+GpgtBnl9Kkl/XmbmeruZcW3BBFYkg?=
 =?us-ascii?Q?vE9cKJ/EoPWGAdm7qWuORZ1BYXyJgzXcfOlFQAd8SMw/Ck/WUznGGYmlzY3K?=
 =?us-ascii?Q?HoPoWuWxD/8ER/Br3OE885jVnvqO5NHVVyGH3FHhrRMherjpfqJzbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 06:38:40.9620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95df068-b465-4656-6b8c-08dd44e69047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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

If a device supports runtime pm, then pm_runtime_get_if_active returns 0
if a device is not active and 1 if already active. However, if a device
doesn't support runtime pm, the API returns -EINVAL. A device not
supporting runtime pm implies it's not affected by runtime pm and it's
active. Hence no need to get() to increment usage count. Remove < 0
return value check. Also, ignore runpm state to determine active status.
If the device is already in suspend state, disallow access.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0fe0b798f559..e4ab28785bd0 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -100,15 +100,18 @@ const char * const amdgpu_pp_profile_name[] = {
 /**
  * amdgpu_pm_dev_state_check - Check if device can be accessed.
  * @adev: Target device.
+ * @runpm: Check runpm status for suspend state checks.
  *
  * Checks the state of the @adev for access. Return 0 if the device is
  * accessible or a negative error code otherwise.
  */
-static int amdgpu_pm_dev_state_check(struct amdgpu_device *adev)
+static int amdgpu_pm_dev_state_check(struct amdgpu_device *adev, bool runpm)
 {
+	bool runpm_check = runpm ? adev->in_runpm : false;
+
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend && !runpm_check)
 		return -EPERM;
 
 	return 0;
@@ -126,7 +129,7 @@ static int amdgpu_pm_get_access(struct amdgpu_device *adev)
 {
 	int ret;
 
-	ret = amdgpu_pm_dev_state_check(adev);
+	ret = amdgpu_pm_dev_state_check(adev, true);
 	if (ret)
 		return ret;
 
@@ -145,13 +148,18 @@ static int amdgpu_pm_get_access_if_active(struct amdgpu_device *adev)
 {
 	int ret;
 
-	ret = amdgpu_pm_dev_state_check(adev);
+	/* Ignore runpm status. If device is in suspended state, deny access */
+	ret = amdgpu_pm_dev_state_check(adev, false);
 	if (ret)
 		return ret;
 
+	/*
+	 * Allow only if device is active. If runpm is disabled also, as in
+	 * kernels without CONFIG_PM, allow access.
+	 */
 	ret = pm_runtime_get_if_active(adev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!ret)
+		return -EPERM;
 
 	return 0;
 }
@@ -469,7 +477,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int ret;
 
-	ret = amdgpu_pm_dev_state_check(adev);
+	ret = amdgpu_pm_dev_state_check(adev, true);
 	if (ret)
 		return ret;
 
@@ -1562,7 +1570,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int r;
 
-	r = amdgpu_pm_dev_state_check(adev);
+	r = amdgpu_pm_dev_state_check(adev, true);
 	if (r)
 		return r;
 	if (adev->unique_id)
@@ -2150,7 +2158,7 @@ static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
 	policy_attr =
 		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
 
-	r = amdgpu_pm_dev_state_check(adev);
+	r = amdgpu_pm_dev_state_check(adev, true);
 	if (r)
 		return r;
 
@@ -4674,7 +4682,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
 	void *smu_prv_buf;
 	int ret = 0;
 
-	ret = amdgpu_pm_dev_state_check(adev);
+	ret = amdgpu_pm_dev_state_check(adev, true);
 	if (ret)
 		return ret;
 
-- 
2.25.1

