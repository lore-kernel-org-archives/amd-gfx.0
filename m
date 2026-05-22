Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE079CD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2B710F47F;
	Fri, 22 May 2026 00:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="axNzfg0h";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0802210F48C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPrto10o5TQn6gz/4DY5skQ3IfZ2nQ51eCCws2pGOYIjg2OQnD8IhkiH4OEXRBN3RVYtW8DAJhNLXzXIZe3Ot9H6tOBq6Gri081bj606rrMByZm/D8/Zw5CEMyAWrW5K8bwJ86onZTiU2XuXkRygX8kPWmk6bldmnjSgpDIppONXo0+9tPJ0pMLph6P5nfRJgkHXPfbXwlmJfFH7jQLvjw+JDi67euclfZWQDBonVA6NO7UAtA+ger2s2anbP1N6qupbOjBJ3k7Ne8Y0CSLFvI2TQfTm5LOvHJNd6H2WZMZmAaMFrZK3id1TqUSm2tzg3n0xqkWFEYK20YOo5kBQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0MBL8/X4ZWI1I1LktDyGzxoJ7MpPfd0gv8J7iSHdg4=;
 b=AiOoQnt5fqvvWwTLTyLBK4YMJYNVUgkYstNd+QrCkPHrhlsa/vsB/IMfhUwqVUGnCoZDW8YqQRRLVRVKEd7PVSQ2FBtaepRVI7n2ZvPOpk17yOmG8FanBDmD/I5CxxgeV5t/HEeoB7BljVSHAHio7yxA2wRADFPsnTOrdQIlU4D0CscCmhhjqmB4FHXPazC1VmAWCBdzlWgXFOGJsMBfGNuiT5VY9vmQQr6NMWFmJl1eaAvyJ28lQwzHgKdVWlPv9Sm7zNLHmcD+QCPD115Vs4v29QL5Na5Jl4A+vGPgi6LeRgtUpTwtkuem72V+pIP6tlbHduiMqHTZ3SkCSAHMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0MBL8/X4ZWI1I1LktDyGzxoJ7MpPfd0gv8J7iSHdg4=;
 b=axNzfg0hyqL+Ubq15NJ0OM79s8UO3T17z8kl9bFkw1tSYTXBqVfwhFqs7lWYsKsk75bOmJCWT961A3l1NJXKta+h2Har5NyHLpFeZYrkJ0RwCek/qtPL0M/vqW53NYWcZOhw68Cf1OfDXYIbueCAg6ZqWu7fEvPb4rj65+al/GI=
Received: from CH2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:610:51::38)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:21:57 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::64) by CH2PR15CA0028.outlook.office365.com
 (2603:10b6:610:51::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/42] drm/amdgpu/userq: split the queue reset from adapter
 reset
Date: Thu, 21 May 2026 20:20:25 -0400
Message-ID: <20260522002048.98506-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: f574bebb-8c7d-40d5-b461-08deb7982227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|11063799006|6133799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YV4zyW+Q/+b7sLJ/INMd3eXfvhQlnOyf8w6Qdcszx+hw326sRUjLF7UlczbKecDIGjgMZh5Ru/jgtuSB40sqvwAh3Uc7pqicqtcqR2zWDZXXr2jxke8CR5MGdZmMx2LLGUtthL76kxZqoweRdrQWcTPPM6RQTz567uFTrmFx2T34zrsVbp7henT3Yitmb5JFhyJoGwESQJ3V0xWlI9SxLkDJSviUyvw54sgwOnYn/dMe3KHlv7+n0V0id+vIZJzBc12cMjDPjSo9tqq568cm0+5j8MwAgei5lw6GfElcbR1xFRh3weK9nNkJHuGXvW+np6WiZ1eXAD2DpnBC7HFaAkUPTFm8GzIrrdFo+6lpfCDeyrShU80atG+xZHi5OIumkd2VtSNCF1cOiEtrVCuRqMwAgGE/f0uPP9ds5R09LOcloHDYMeSNcy9aug741hQp7WzQVe4pBFsxOAyhrns7TCA98dtYbOZ7bbAP8E24gSVNTlUDK2k5T+849sXQ1tSkLxPZEecF9Fd74UZppUK/0A3UEijn/SJ2/2wp8Wu9K8Q8+BfM+GkuY65jx+kcNz6PZ4CJiA4WDqhce/H+AqjOP5//cvcIbbdOKQ3kg6eEKBuAxYMdZIikJHeTLQQfGcDge/HcEfpFyEBrjfbLdUasOpekdez4afURKjtBpQzKtM9aREng94MIgsctYl4u4qyNzfJfsS/MCvVxC65dhKCoGHqQ4UuCdgdsCQbuTdiBBYw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(6133799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mm/jFkSlRtGgMtNkaog+AiI8mAlH9x1Dvqvfc8QYjGIG97+l254EyvKDg/IfdF9Kj+dQsghHd/KsANQJy6IBTXk8AztbcqyqiuCDaX32pmBSDBs0/uD2b/j0j3sZgjTn7HrAFTAJLKnmJYhWus1cFbk9vTfDjD/LccMwmlPTERCTOgBe1F5UOeI7x4WrtKys+AmpPzQuXYinUnMlfOq4qa8qk0xoTU5FO00PFdumhneWT4JHp1Z9mZZu8icAWFVEjf3grUsOj/xFcIscH8NYprBxm8v/EDMoJusvgkoF4vw0TxPadRRajuqtsGLz2MvctYsGkQzBoO5elj/xlSYubX5Mm0QUgF1vHt3b7lbWl47E5sEvyn7KC5ZwNjEYX4fNHKPPJe+u7xfIXr9uzg/cYWwaaBBGwVoNPTmkU91m9Dz72SyQuhxorwU7rDykhtpf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:56.8377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f574bebb-8c7d-40d5-b461-08deb7982227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
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

No functional change intended.  Separate the per queue
reset handling from the adapter reset handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 57 ++++++++++++++---------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 154742bdd5a6f..7a09e30912324 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -88,6 +88,38 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 		container_of(work, struct amdgpu_userq_mgr,
 			     reset_work);
 	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_reset_context reset_context;
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+		return;
+	}
+
+	/*
+	 * If GPU recovery feature is disabled system-wide,
+	 * skip all reset detection logic
+	 */
+	if (!amdgpu_gpu_recovery)
+		return;
+
+	memset(&reset_context, 0, sizeof(reset_context));
+
+	reset_context.method = AMD_RESET_METHOD_NONE;
+	reset_context.reset_req_dev = adev;
+	reset_context.src = AMDGPU_RESET_SRC_USERQ;
+	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
+
+	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+}
+
+static void amdgpu_userq_hang_detect_work(struct work_struct *work)
+{
+	struct amdgpu_usermode_queue *queue =
+		container_of(work, struct amdgpu_usermode_queue,
+			     hang_detect_work.work);
+	struct amdgpu_userq_mgr *uq_mgr =queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
 	const int queue_types[] = {
 		AMDGPU_RING_TYPE_COMPUTE,
 		AMDGPU_RING_TYPE_GFX,
@@ -131,33 +163,12 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 			}
 		}
 	}
-
-	if (gpu_reset) {
-		struct amdgpu_reset_context reset_context;
-
-		memset(&reset_context, 0, sizeof(reset_context));
-
-		reset_context.method = AMD_RESET_METHOD_NONE;
-		reset_context.reset_req_dev = adev;
-		reset_context.src = AMDGPU_RESET_SRC_USERQ;
-		set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-		/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
-
-		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
-	}
-}
-
-static void amdgpu_userq_hang_detect_work(struct work_struct *work)
-{
-	struct amdgpu_usermode_queue *queue =
-		container_of(work, struct amdgpu_usermode_queue,
-			     hang_detect_work.work);
-
 	/*
 	 * Don't schedule the work here! Scheduling or queue work from one reset
 	 * handler to another is illegal if you don't take extra precautions!
 	 */
-	amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
+	if (gpu_reset)
+		amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
 }
 
 /*
-- 
2.54.0

