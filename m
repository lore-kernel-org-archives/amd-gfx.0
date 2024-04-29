Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD180C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CDE112C9A;
	Mon, 29 Apr 2024 14:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uLoWHnNT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CC4112C9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2DaRx8UUYH/LJrwAmMv9KGgCF8WaRtMYaPLPYim0nCrwOl7lwlrL4Q776M/4H9PEf3589n+8cHe5qPSeI+XwmxXsum9ZCuErpLkxdelSAvyfyBOvQ8Yle0ruxl5+bd+HebqB1BRtDx1QdmhyYvROghdMwWNMhtqErc/t7kCf/jgk8THxt02qHI8G78LLFktJjxN9khPxBIbrxS0+7wc3wKtbXp5i3JQKsO9CQlaNFaGqpru2HKFYqqG8gAntoVCGbLQzkaPwL4hFbkjMsamtGNnblbQYjgLwtJdQ8Kic2wxhXpChjEMfZcegeZ2O2YiyMK0gp9mneDv5Arh5TrXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZQqauxJY/wnh992+S4GILTuwFDyLRuPXuZEM1GwTr8=;
 b=i88e+SCiVkiNEmGAw6MKvxxiGWfAO2ydFMN7/+3CqOimj6/wBQl0rZF0iq6emYyHYvvLPn2v4TAuGtTjjGgIgk3nUkjg98Zkh8PVzp8Wtdl/snxJNyvVg6g/U1a5hGWEVse2INMe/hpXtivot2QaCDQ9QnFQlZIC1KSEGhL2/Iv8tJocCCkP6OOHBedZaBGmUNW5UNJu+v10J0Z01Lkx8L6bPVJPVLXHYEkfJ8rpUsCDoqoS6AZjgmEkPTALq/mCm/cp6mthrEReu6evAJnz4kf5wJeAIH7v8bbsKdmmpklmyCC4jZm/ldDqHKWbf/wZH2eFBXWWPTqVjp7hW1U7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZQqauxJY/wnh992+S4GILTuwFDyLRuPXuZEM1GwTr8=;
 b=uLoWHnNT1ekFzvNlgfb/+FAI7JaYclogZKgdfhJ/nkXqoVtcCI7ybL/7ek6cAPF9G/r9WJBAgsRQjAagrKXfFZGHhY/yDXE94fpKfHdr3SPqWg44elZr0OhjaDa7m4NzUmmBkJA8tDzWp+/UmQR6qK8j0n2XyVO3lx/G6mjHH9w=
Received: from BYAPR06CA0011.namprd06.prod.outlook.com (2603:10b6:a03:d4::24)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Mon, 29 Apr
 2024 14:34:24 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::e) by BYAPR06CA0011.outlook.office365.com
 (2603:10b6:a03:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 27/31] drm/amdgpu: skip dpm check to init imu fw
Date: Mon, 29 Apr 2024 10:33:35 -0400
Message-ID: <20240429143339.3450256-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9da72b-4574-49df-544f-08dc6859778a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fng696X2PDz5+LGHx6ixd4DD4bXfwnI6HLeikOTToahEg+eKE86ln4vujd6e?=
 =?us-ascii?Q?fKr5GlpCfKWLX4t+0N3B92tqCtI+6Wa0QKgz02OuLM4tJ2ew3d6afTj65iGg?=
 =?us-ascii?Q?H+QJyvNMdy+Pm+agiHRaEC9jw+4rUruer7SznPGskglw3jk9VQW2/g+1F16f?=
 =?us-ascii?Q?Ta32eCO0VOKNLEAj4WNPdQuoahowgAf0RLolbk12X64g6z3+9Ic3W+VT3gNW?=
 =?us-ascii?Q?PDL+/t39frxZPMfKwBl/urvMVj01COjEPRIm6zBdFjE1Iy3keOD5BqeWD/v2?=
 =?us-ascii?Q?2zEOPYbO9++1uxCgTu6NwRL2zapQndr0PfJy99U/oG9NBMEJ4UKEp3KUl8IG?=
 =?us-ascii?Q?X4YAGdiNpkE1Rt5N/mx7fuvfQhPrOJVTm1P3ly6yQE5Edp1Kbt4sNMkov07X?=
 =?us-ascii?Q?wN6DFR6xA5jpx3Ti8zXRHjIlRkbY43x1Un3aIhbxQrftByH6s9wcLNfYQWLv?=
 =?us-ascii?Q?S0elsVgC9RnJZY94OqY/6Ebg4Jd0tlZ3DEDu94mgaMMNGqG8wEWpSIN+iDav?=
 =?us-ascii?Q?+eGFmV3HrKb5yEv0F6k9s8MwLR0Zzc+u3ZqaIjpE2+LiJ7LSvoru7NB2AFnk?=
 =?us-ascii?Q?sApxOd7DFLrOUh261YgPc1t+zX7sfeb1bMzHsQhQ/wCIdwGwtJpAS14SMzyr?=
 =?us-ascii?Q?1U8hei5R/n7PokjWlImr1wkVX5ac5jgoNoSke7BOawLYRWqLyXoz7i0qbDRq?=
 =?us-ascii?Q?ffrNu0C/+ARdcobj8uybap/qM4h7oneOk6YPJosnKvvvi2PIt0bXbznQjrb0?=
 =?us-ascii?Q?KZS55/ievKrYSp4g2rgrlAYBO/Lmp94U6tCMM8sgWXntbKnJy1QYwoyQk0/c?=
 =?us-ascii?Q?UCFeCEgYeI/jfR7Y/6Uz3gwlgTg2JKx4wa1jSghIcO8SSG9EkYmbFj0K0YQm?=
 =?us-ascii?Q?ose6Zkh48e36IvMoz6hUx84KCnwu1o+s0fXr5ZiFoTry5uBeBfDuFCqAqJFn?=
 =?us-ascii?Q?Oq45j4T3kbpNCFmqX2tv6bZQe8lQcI2NjHupJ7zbrwIoRiEmjT1POemkgdi8?=
 =?us-ascii?Q?rBMCzHoaAT+k9tbjn8c1XIOAz0n14YKO8S2wlkxot8oQeSzMeldbcofF1zd5?=
 =?us-ascii?Q?/+WsU1sCyiYruyRV627H0jYBU+o7KE4xx79BZAa9MDTUyfjvNoKIHLDoZNd/?=
 =?us-ascii?Q?ogilji/FrACgJ4VYnmpx4pSuWd7JSuyTRW5+A3xdljVIhMmJZduogxop7JNV?=
 =?us-ascii?Q?Ua55aoj6qEVscYLQ2b98J496dJkeuj9Kiy6+2jXUYXgZ/BQVBJVjmipNKfa5?=
 =?us-ascii?Q?m1VDV5KOLazV77OnVyOcGZgaIGT+DoNiQJuySgXUc7HkkAqB5aRUOueuYWcX?=
 =?us-ascii?Q?DVzPnZbdMfa9qgbs8q3XYzisLPvnTPxREGEYaN+QUiTx7B0ESBF2rk2sBrYU?=
 =?us-ascii?Q?RTe1GG0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:24.5293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9da72b-4574-49df-544f-08dc6859778a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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

From: Likun Gao <Likun.Gao@amd.com>

Skip dpm check to init imu firmware for imu v12.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6a2af12b5e29d..33fe519e617d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -461,7 +461,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 	/* only one MEC for gfx 12 */
 	adev->gfx.mec2_fw = NULL;
 
-	if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
+	if (adev->gfx.imu.funcs) {
 		if (adev->gfx.imu.funcs->init_microcode) {
 			err = adev->gfx.imu.funcs->init_microcode(adev);
 			if (err)
-- 
2.44.0

