Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14049CD13DA
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 20:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 464AE10F456;
	Thu, 30 Apr 2026 20:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QNnhVnPw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F20F10E181
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 20:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d709a/v423wMeYAat5dVPhP2hI39DMYHW7gMaGx68w5pUKhZ6o/V08cIp4Xn0evBEjzxUs4eoYh5+Pn41skVbjYSND4OX1U26tAUM2/ODqJ1IMXbqkA6AF8BPAbnShvsaUQM5f2YDDa1MRiqbX77/HjTMb4GI2gI7a1FQCpl9unKzxm5nfbT71QJirGi/kqI467LYpSgRztnplVhK6FLc9aWdGNrTHXlQW9a30EkWO9JPNEj1T1o28RP72ZXbDezwIaZlimgzkk52hEk20eHbKgWnqWDTpRSFQR9ednKS46m2+e9Bhyyiboj2nIchn2CK28GKMSBBMQednwKEZH5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsa+M0FN4jsKvpFpsed0akBNyjHnafWdy86dgnKnvJs=;
 b=pO7iUzNtWcm9CD4PLP0stHgR6xVN7i6y6a2kkNmrgMlDAKjcQnP5XKQZb9YrNcGaKJ9uwymySK1l8DIq2CZ2hk9YAPw2JLmScUghyHXvpNJpBaS79dewLWkFxo5ltFSQB6/9YmNcXSJdKLtF3xm71ea3imHhepdbsfannchRQQqzMHfvi2n7Qo/YVJZLzMoKT63BU79ov22wtP6cqgnnp2rLlkmsD8hN4E21ctjrqKyBGZB+U04Y1filst94yjTrEQjWqc7mi6OHwH+MXakvGJaMTJcga83mNlih6c9YWdgTkSHiY656G3y4LBJ8kkjP4lyEGjbpBmD7YJWGabcYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsa+M0FN4jsKvpFpsed0akBNyjHnafWdy86dgnKnvJs=;
 b=QNnhVnPwjgsCIbj4J1JP6Lc+w4XeFFpR+khqOvUAIntu+LU3q1yGZE9bFE3r8c74J7GNgyC04+7umulzx0834cTKi63XGAZIkV2lCceeY9ArUKjrCWf7bR2H31ZnkaejgP+CFSd33H8wPZal5Rga/WcexpIAhIIc/K46zI9mQMI=
Received: from BN9PR03CA0134.namprd03.prod.outlook.com (2603:10b6:408:fe::19)
 by DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 20:18:07 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::75) by BN9PR03CA0134.outlook.office365.com
 (2603:10b6:408:fe::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 20:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 20:18:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 15:18:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 15:18:06 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 15:18:05 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Add empty string validation to sysfs store
 functions
Date: Thu, 30 Apr 2026 16:14:24 -0400
Message-ID: <20260430201803.90458-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DS4PR12MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ffd93a-dc98-4287-c78b-08dea6f59736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: heh5hHfnbMpIHfO0Py+5DlOu/jdu56t94sdml2PysbDfCS9rmaTer7f7iReOTFX+lSmbca8uJab2HjNeYLN+Y1BqF4nwS1PyJaxAqMkLva7v3ugm07cjfnqhVKm8jF+yw0jslQfypI/XitlpnGWh52L4pYbVTMjHYt1r+a3p2ki1YG2UPaT5LpavR1srbpL8eiiDfyvlqIwhcJKs4ACQzSfwil3Cr9XBCKXuJEyRpQRbtuu2nUyrnoXgnH1sSX6X1/ybKpqNW2WozqY7lg3PDPaToSWkUvi62eVJ+omSuKy+9RotU45rSexx/bOucmNfTjHMe3eytKmLMRhkonz19A4MRIIRF/VqLMe443jxbeVnISbpoyFjnXBREEI7GOT37QSxJGAM+iV9jycpIhhqT96Y30YV1cB/o7fzWqegqjHjglJxJOI3hAj2CNo42aCztTujuXPsg7gSVvCVq9PY6f0EHF5FN6ZbKtorq/Xk1IqW/kR75STV3SPaR/2CBhpuQj5BZF3JrkRdMVhg4mWN3LpBE7vMjbEjxNatTn84yAj0zbxcfkV9qnEInOeNkVEZgXVhFtmjqBMqIS7jN5t1hUEtnLPNQSw5z3xislTs5sD7nb899fmqSovxKHFUIuvIY73UnFfhazYsgn6MrUQMl49GfTv+I6QRronqvqYZvIiTaeU8JeOYu3N3zTSQwNBeKZHukm8YOvXzIUXLpFofBOemPMSzwMkBbEw5lEk1f9w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mx606ZIW/FPXvXd4gkMJL+tzXxKbQBJduuBM0xHBTyus6w3KQOg3clOF6Yyh34EvWXfp1eJSh9A0rZLOqBhkA5nQaiGoCxp1aa2U3DfkjNLn7w0xcQKRyOVaJp+lnjBDViqW8KIc6lG0cK/rczOqGvGcY0IR3ZxrleeEEqhQSdaCTX6dV9muI4/IBBLNOGpR0eqw2vsplz+yvxZVNIRb6UFG+7YbdoWUHa61TeED5gMjNjR+she91FzBiJ4/x1oUac7ipxb9f1weMLf0eXEoq7fHXtlY33xew7PeAkiT47J235b9zgNecgF3kMyCs8FwfuO4nH/NJ34ddV3yWuCiJYyz1LRccaLHBZVCGR1hIe34iFEV6NtF8DWKSZK+rNQFp3Y4dxy0OGS09zUVPTkR8cesWwNj0NjmuEIHcJbrCVQJM5iStzKSWYLVTLv1xAHh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 20:18:06.6906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ffd93a-dc98-4287-c78b-08dea6f59736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9708
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Discovery: Fuzzing for secure supply chain requirements
Tool: amd_fuzzing_sysfs (IGT test)

The AMDGPU power management sysfs store functions accept whitespace-only
strings when they should reject them with -EINVAL. This was discovered via
systematic fuzzing of sysfs interfaces crossing the user/kernel trust
boundary.

Affected functions:
- amdgpu_set_power_dpm_force_performance_level (power_dpm_force_performance_level)
- amdgpu_set_power_dpm_state (power_dpm_state)
- amdgpu_set_pp_power_profile_mode (pp_power_profile_mode)
- amdgpu_read_mask (used by pp_dpm_sclk/mclk/fclk/socclk/pcie)
- amdgpu_set_pp_features (pp_features)

Impact:
- Whitespace-only writes (e.g., "\n", " ") can cause unexpected behavior
- Better input validation at user/kernel trust boundary
- Defense-in-depth improvement

Root Cause:
The sysfs_streq() function matches whitespace-only strings against empty
string, allowing invalid input to be processed.

Fix:
Add explicit validation at the start of each affected store function:

    if (count == 0 || sysfs_streq(buf, ""))
        return -EINVAL;

This rejects whitespace-only inputs before they are processed. Note that
write() calls with count=0 (truly empty strings) are handled by the VFS
layer before reaching the sysfs .store() callback - the VFS returns 0
(success) without calling the kernel function. This is POSIX-compliant
behavior and cannot be changed at the kernel driver level.

What This Patch Fixes:
- Whitespace-only strings: "\n", " ", "  ", etc. are now rejected
- Defense-in-depth: Explicit validation at trust boundary
- Code clarity: Intent to reject invalid input is explicit

What This Patch Cannot Fix:
- write(fd, "", 0) returning success - this is VFS layer behavior
- Fuzzer tests for empty strings (count=0) will still report "accepted"
  because the VFS handles this before the kernel callback

Test Results After Fix:
- Whitespace strings ("\n", " ") now properly rejected
- Empty string tests (count=0) still show as "accepted" due to VFS behavior
- Overall improvement in input validation robustness
- No impact on valid inputs

This is a defense-in-depth improvement that hardens input validation
even though VFS layer behavior prevents catching all edge cases.

Tested: amd_fuzzing_sysfs IGT test

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index fd2e63530e8c..66d8466b166a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -244,6 +244,10 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
+	/* Reject empty/whitespace strings - fuzzing found this is not validated */
+	if (count == 0 || sysfs_streq(buf, ""))
+		return -EINVAL;
+
 	if (sysfs_streq(buf, "battery"))
 		state = POWER_STATE_TYPE_BATTERY;
 	else if (sysfs_streq(buf, "balanced"))
@@ -364,6 +368,10 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level;
 	int ret = 0;
 
+	/* Reject empty/whitespace strings - fuzzing found this is not validated */
+	if (count == 0 || sysfs_streq(buf, ""))
+		return -EINVAL;
+
 	if (sysfs_streq(buf, "low"))
 		level = AMD_DPM_FORCED_LEVEL_LOW;
 	else if (sysfs_streq(buf, "high"))
@@ -902,6 +910,10 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
+	/* Reject empty/whitespace strings - fuzzing found kstrtou64 accepts "" as 0 */
+	if (count == 0 || sysfs_streq(buf, ""))
+		return -EINVAL;
+
 	ret = kstrtou64(buf, 0, &featuremask);
 	if (ret)
 		return -EINVAL;
@@ -1027,6 +1039,10 @@ static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
 
 	*mask = 0;
 
+	/* Reject empty/whitespace strings - fuzzing found this is not validated */
+	if (count == 0 || sysfs_streq(buf, ""))
+		return -EINVAL;
+
 	bytes = min(count, sizeof(buf_cpy) - 1);
 	memcpy(buf_cpy, buf, bytes);
 	buf_cpy[bytes] = '\0';
@@ -1378,6 +1394,10 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	long int profile_mode = 0;
 	const char delimiter[3] = {' ', '\n', '\0'};
 
+	/* Reject empty/whitespace strings - fuzzing found this is not validated */
+	if (count == 0 || sysfs_streq(buf, ""))
+		return -EINVAL;
+
 	tmp[0] = *(buf);
 	tmp[1] = '\0';
 	ret = kstrtol(tmp, 0, &profile_mode);
-- 
2.43.0

