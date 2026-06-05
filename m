Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C57ACD8C85
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4F210E561;
	Fri,  5 Jun 2026 13:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Myw1qslj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BD910E62D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojSjZG3FnaX0xw7cqw7INL67laB04cUKEx2Zr8MEsVm/6vPDvmR+0vM40tXrGB2w2WNwdV0PkdIsVqYfqMIqa9TWcwT4zqt2pZy2aHd1TZE+dR9gGpIRNilE0P/KjlsC/VwTlUgykU+CzII7AVuAq7rTEmfXiPkkaeLhxZzlNW7/yjG6iyCv1D/qzWy80XQhBrLLDXFlQY4Z5BlB9165WR8j0Om/lVkh4227eXbGI4IsEEuYnOfygiZGboLqnSFYsDe7E6BgR0NFqrcEz6rCEOTczAjoV2pM2bMxjYzjDo/ujwpEZJceVh9QvndwLIeRsNj36XXPGxQ01lGqB5/h0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiJlP1KRyeXZjBUHlvZgYc+y7YIOfyyp7jePJR78jcI=;
 b=JW4RqX0ba7d/z2M12Ik3bPxY+oDR99cAP83M7fNQTnMHx8VVK8CIEc/I04AEiwPnmrQ9TePSkjqtNTOfvhaEs+nbG/tkssIYEwguP1IQytujt6Y24SGTWer11VoUsx8G4c9h78+AOIIqSUqO/DRGnhb3FyAnSIYL6GtkVa0t35XIcS8u9zhfdzU/XzNB5fJNf/XhO7yQO3A7VmJdGgRqb/pLdIjYWT/67B01p6I9VMZciUHB1MjfUQI59fqzduzuL3FyZTJFeDo9ZvZKs/qcK4fnXRw06+rLSZACNOA3sDb5qq44zUN7hjPdkLWhA3e6goVfHN2/CRp2IjMp1GgDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiJlP1KRyeXZjBUHlvZgYc+y7YIOfyyp7jePJR78jcI=;
 b=Myw1qslj+NjXlwohJZkP3bCWWNcujmCHzLQvERrZrYSuj6MaCQdA1FC74TQTaHZlG0AuBC9Sd+q5CG5JnwnPOAPZb8lYNVF6vW8K5qJcHoVqZ7DEPzdXOmYfWL8UyHjIbniQefj7QkSa2/TAkBYNspHRw7zD/0Ze1X+q7HoCgiw=
Received: from CH0P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::12)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 5 Jun 2026
 13:44:22 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::1) by CH0P221CA0037.outlook.office365.com
 (2603:10b6:610:11d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 13:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:22 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:15 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 08/11] drm/amdgpu: move struct amdgpu_clock into amdgpu_mode.h
Date: Fri, 5 Jun 2026 09:43:20 -0400
Message-ID: <20260605134400.956791-9-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605134400.956791-1-shahyan.soltani@amd.com>
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 946c7b4c-5075-42b2-6472-08dec3088d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AY6wr4N9OrI/ZI6N1VwwW/XJ0bNxDDix2sDSM+QT91c2rmIXfWBVQSPb+O7niTRK40GND9r7NNdJBQZso4IDaBCr8yGOqV4J8DC6s5Z/rtm5c5qFbo+xS6VDLJkVcCoD/telAdiaCfxQ0fQNysVL8ZgtJoxByLoQg6wkydPLvpLHFv/rgocaWVvUkWffqktBVhYRg+B7LjAJtygBR3QHS5PQdLPSK1D56/4VgoUD9J0aWEUwTOn/8FmNBrnIVi2qhxYzIPOy77SiT13CW2DrDHvAgHaMavlAhWYshzLktLv5evJxwmuRFEk4DylQW3twSe5gDK9kEwNClmdRcqEUsxUOAD6Ua2iIwbk7tIH9gXz75ttODm37p1RmC90JrR2SSNFVo6sViC3kmbZYd6lE+9mRzEl188z/D/p4hGelVYkr8FHpdrHBqlnrrwAw7EQZg8giSG2vdQ6lw1Yv+PJRM9XTbZX18vqIWZu5BdVWSBFWV+3I7OjAhZmCCTWPcUzmEQX3mLWsB7184P18B8NtrsuHDdNawkAbMRNL0UCqJaHZCeXqH14Zp8NbWVwm27zECZShAk11PqPt5J1S3ok0Y3eyLcMrikwFDjmGr3L0zkxvPtoTBJzKtbXO5UGSX1p0plXCQpKZKnmbYbATaE/z5RWT56J4G3PkNMNdLnKrWe36qX9PiSJU5fbtBGK8WocEZpDYEtxQjmm22M4iBBPoE95K5uL5sNoeUxE2AlFn9hE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ys7lB1mwvC14F45KCXJxYyt7ta5AhZz5AoL32XKmJOsa92o0KXR2EbK7S4P1/32J08yivuapIAQuuAztVZ4AGWxi+zJCUq36WA/h5KNiiVQ++zb+GEKmo4gu6T/t+Ap4ZFtcl5hcLz7QFMPjdedEcenFkS8UGphQKwAgonOfkEqysBCeN4fBiwXaTA3QQo6bY6BnK4UtTQzbm7rkETXoGdXW+t9wlxWigV1VbutlO+UQ0I7tVfKKTNSWrPOdh23cMbD566AoqkNWwD3iQa5SB6/O3ANXQiTmAc4nSMoK5kbZzLSV9JnrYUIq+vkVl6Lr6fmSrVmgUOIjyaE1fzRG8A9XV/OoeRWg7ki902jHd8WaQc3b8SNDzmY1d1rqF1W3piSI1FYvuf4nxLHhabByQkaaSTwM/NavBlE9THJyr+HkOSrmZV08ch7z1k/UC8Xn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:22.6801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946c7b4c-5075-42b2-6472-08dec3088d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

Move struct amdgpu_clock from monolitic header file amdgpu.h into existing amdgpu_mode.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 18 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 85d040184d13..8a6b6f43a320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -368,24 +368,6 @@ bool amdgpu_read_bios(struct amdgpu_device *adev);
 bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
 				     u8 *bios, u32 length_bytes);
 void amdgpu_bios_release(struct amdgpu_device *adev);
-/*
- * Clocks
- */
-
-#define AMDGPU_MAX_PPLL 3
-
-struct amdgpu_clock {
-	struct amdgpu_pll ppll[AMDGPU_MAX_PPLL];
-	struct amdgpu_pll spll;
-	struct amdgpu_pll mpll;
-	/* 10 Khz units */
-	uint32_t default_mclk;
-	uint32_t default_sclk;
-	uint32_t default_dispclk;
-	uint32_t dp_extclk;
-	uint32_t max_pixel_clock;
-};
-
 /*
  * IRQS.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 8069fc41cc7f..f741cb407012 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -221,6 +221,20 @@ struct amdgpu_pll {
 	uint32_t id;
 };
 
+#define AMDGPU_MAX_PPLL 3
+
+struct amdgpu_clock {
+	struct amdgpu_pll ppll[AMDGPU_MAX_PPLL];
+	struct amdgpu_pll spll;
+	struct amdgpu_pll mpll;
+	/* 10 Khz units */
+	uint32_t default_mclk;
+	uint32_t default_sclk;
+	uint32_t default_dispclk;
+	uint32_t dp_extclk;
+	uint32_t max_pixel_clock;
+};
+
 struct amdgpu_i2c_chan {
 	struct i2c_adapter adapter;
 	struct drm_device *dev;
-- 
2.54.0

