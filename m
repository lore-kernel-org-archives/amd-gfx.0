Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162C606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gTg2xbXr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD0AB10FA9A;
	Wed, 11 Nov 2026 15:46:36 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419D910FA9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 15:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGfKm/ibfHs3ob7eglS3AKlR0rmDwYPwx4gwaa1wNMy8CDlsWAdcgRGIc4qyMtgfdCibEQfg+oMaV93Er62755+fZZ9Ev7i7AhdlvLwEczcj4m0HWLAxFKWC8QQVrvo9j9byPcJxR9zwFr67tXRBGDk1+gpabOi26exojDHlHl3LkeHE/VAKxr6JS/Zlv+xArEdWXDrdhFNAiNEfNmjbugFnKacYJlF0VQW3o08kjPXZRjAavaTM1Om9Tv9hXme3rTEPJJMUcIyufi8lkyqM7w/szYvruZ84gZ+W0Vx3itbT0z2MvdcQU5ofBZVPkTNiX7cJwvFtCltXoNaRNyc3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy2wlNKMXLZAEtTNp06AZOIxmTi/ubQDWT8/cjuSXM4=;
 b=Vc9mYokUsXU+2QdvX8aK5MsNNspRncHFvCZBx1lg1rpy/Eu+tbHZ6uRtqO9cMEXKK3kP5VJVaSs4KJIqU8LfNqx4PvvCh9Qn0LgNNdr+v7IlLJ7mbGljNcF4IXITdQhowA2pwl9vrR6pwX/v9yC9Z/9GYLyvQwnYsBDscPYJdNH/srr9P5Zi+3O5T3EStuES+aw63rpo0V3r8U1Ld0O/EZKPw2oyCa9fxU4qT2CFXivsWf9ybYcHzQq3FwbcQKx3f9W/V7UUrDMZGYKc2NDaYMaIML1bYECUHFyjw9LteMsvGPtyFMvkdO6iH62jG2aGvszpN1rjxiT7XX5ZqcSp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy2wlNKMXLZAEtTNp06AZOIxmTi/ubQDWT8/cjuSXM4=;
 b=gTg2xbXro5PA2GMArV/tv/Tk+MTrzJXCf+9P6BT9k7wisT9l3IyrLjFCl6HYE73Vavt7UNknQ8DCzF6nvbatXu61mZA/3Uye9uhRebYThcHU0+QioNBfTaSsEe9GDce6w3j2ajQO2sh3QILoOrwMglC8vruWotcnEJJ3w5JUg2w=
Received: from DS7P220CA0125.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::12) by
 CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.9; Wed, 11 Nov 2026 15:46:23 +0000
Received: from CY5PEPF00000E79.namprd02.prod.outlook.com
 (2603:10b6:8:25f:cafe::76) by DS7P220CA0125.outlook.office365.com
 (2603:10b6:8:25f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 15:46:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E79.mail.protection.outlook.com (10.167.247.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 15:46:22 +0000
Received: from SureshG-DevBox.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 09:46:20 -0600
From: Suresh Guttula <suresh.guttula@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <suresh.guttula@amd.com>
Subject: [PATCH] drm/amdgpu: bypass IMU ucode loading for GC 11 APU
Date: Wed, 11 Nov 2026 21:16:06 +0530
Message-ID: <20261111154606.1172642-1-suresh.guttula@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E79:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 191f4d02-0ad8-42f0-7777-08df400aefbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info: +i2HBoI1oslkipSQU7KLbtgBKySNqweFB0OQvTxEjVtsJX4XjYLdfCJrGWAcccH8d6m3/Pt+E1wsVMEMYLJoA0Azkrt/8Oz3bbzOey0eAQrdtZG5TQRA+9hrGDAgNaGWTcgSvcM6mdLuKn8js/G6WlsPxofHXUufrNIlHgyZou1FiAtIOOJaj83o5k6sRJGAKeSG4nZi62Zfk0W3pcob8ahwRvk4AK6Loc6lZ6xtP39c4Mo+5XsbUoG/ZOmpnpMxQgOA7Q7veKUzVO+n+nBkLYwZoAszhp3xakJXYNs8A/4PbApae5OGuwRoViVsiyVQxSHkykUdF3X1+CtBtTWL7itrF8Sn4dBJMUF3BQydTqpJCfk/zyuTyLztv4MaCxG4Wtdem766EYCbd7TYCASHSy7FEgQMzYiI+KahF9gfeRETB+sjCQIToClxVK71FxXDDPsHoh8Use9hntNXWAhOvsjc7kE6bGi3PGbHnejuFTMkZfZP11bkvlXzhLuY61TCgReZyUTqhTUzDO6VUHq+uCms6VlLqJXAfa494N/6v/POr7QWZgpVgRLxJB4pq9Exi7I7aDgsZ4sXiPwuZKOHG7t63Dj/VNIFISR2ftjL6n0jxxRG0QerI5W2BWieDiLlfK4g37zQ8szdPzNbRKpwxwajbY9193cYOj1mdypFIskfXyJ0RSTy5c+jKatW7z3VHK32Hz09AfjtvwZp9qC3Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d6XFuZY1yKiSfh6JMQJNd1ydj2SnR9r5abwTXvDwCnq6MvPfYbPPKlFsG6P7LgbxkY0qKQmgv9TqANbHU2lSoiyPtz8O11R2V4wpu2PGthwhRhctgffX5LQYgvkwCxl15eoLur87GHPQOjzBgpNF2JmMXcgAoBY0I/JeEJOFafBcWMspdHJkgZeNIm20Dh99OnbqNLEt2i5QEqXHpV+pb2uQh8Kb24b9ZhlnIEz062qQvUHFYliF6EHcs55uGTicIWOFHJqVRtyTq0TpkeMLKSCJhbH7L/9ljq/nzSSXa0aIWuvCKFlzxl5+5wG7LCb8Eqhg5s7F/4dgtCYF6JQjfjXQJmq59bAonJu+suVdu5KGebgGGwOf93R7EF/dwhIbDIBTddhqHELUIPGEqpeMb7/xzZU+aGAAqfZYeaQ6xcuE+9zlTD/evI/nha1KxSbf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:46:22.4881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191f4d02-0ad8-42f0-7777-08df400aefbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E79.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For GC 11,IMU ucode is part of IFWI and ASP would load it by default.

Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 09dc01a425d1..e2b3f46bbc64 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -52,16 +52,25 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 	int err;
 	const struct imu_firmware_header_v1_0 *imu_hdr;
 	struct amdgpu_firmware_info *info = NULL;
+	bool imu_in_ifwi;
+	enum amdgpu_ucode_required required;
 
 	DRM_DEBUG("\n");
 
+	/* On GFX 11 APUs, ASP loads the IFWI IMU ucode by default. */
+	imu_in_ifwi = adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
+		      (adev->flags & AMD_IS_APU);
+	required = imu_in_ifwi ? AMDGPU_UCODE_OPTIONAL : AMDGPU_UCODE_REQUIRED;
+
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	if (amdgpu_is_kicker_fw(adev))
-		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
+		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, required,
 					   "amdgpu/%s_imu_kicker.bin", ucode_prefix);
 	else
-		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
+		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, required,
 					   "amdgpu/%s_imu.bin", ucode_prefix);
+	if (err == -ENODEV && imu_in_ifwi)
+		return 0;
 	if (err)
 		goto out;
 
-- 
2.43.0

