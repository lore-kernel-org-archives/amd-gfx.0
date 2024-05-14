Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E12C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 00:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842DE10E075;
	Tue, 14 May 2024 00:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K+SCGWH0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D9910E075
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 00:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If4vTR+QMV0sphGMFr66xUfaZN46k4CaVbIU+e/d/qxUConLaQol3yx6smyimXw8N+1CFP+u+uLBeDsOjMJIZRiZuLVBFgG4kelqwHM4YmXdezoANYip4E/kMZP+pRc/DWzYYZaXCgvhELbe/o+bsq44l4ijSfMQpsLi29cGB7jU7DuOF2eAhMZ3wmGBFNzPAtBj41CqVM62k3w7QiE4ZpNAzq+58yacNMVkuv3a3XUdhPZPMOnwvMDjHKy9kgpZNMy4my9cxSntK/Ez3qnaVA6Nk0qcl7eXfZM5EV88ZCaHXrlRRIlzSItlO0FSKQNEQohvgquPcnomyBAw9D1DEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pm030Z+jVo0TteY+wuLCLqirtncdbkRAJmi7n7/pM0=;
 b=cvKEe5pajUuTpN+nEUR3aGFKSgidfNaJePUA44PiIC+gcMeGeZ5e++sBzIjAA99DfPkhG/fmW2GJSLSvoo5/QV5OM+YxuSbunDKYjQ82J0gIs4BBa6BDlu01zOr/SwfLTIbAF5rCkreaPwBJybBtnRkalQpsy0MhXVZ1W2IbQrJGcOq1vNo8itSgFwqG/zIMRXh3btah5gXABmJB2DHkX3ZWK5JmgTx4ER2eHDrDKklS2uHXPMv1m9Jrpjg6rVXOM2mjaXVVYY/JhhkulJrJ+VJd4k7YvUp7XoWnPwMhXRHHZ8Xd7DdETWXCttLkRrA+2ViKuwhFSYWplNHgk+iGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Pm030Z+jVo0TteY+wuLCLqirtncdbkRAJmi7n7/pM0=;
 b=K+SCGWH0oyXiMSIuefzQuD7Hz+wQr3Y9zIgmc09QieUpXCDGxETsgWA4O8G8zDTffBHWtImCV0kpIx8H7H71rKQDHgJK2kABlOE3/S3esWXfW96nJdSMXiOJXe3P6/uKKCy2BG9FfF3ku3pEAoBNmdD4wNxMsCnYn/VpAA84Bp4=
Received: from SJ0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:2c0::10)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 00:04:50 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::35) by SJ0PR13CA0005.outlook.office365.com
 (2603:10b6:a03:2c0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.24 via Frontend
 Transport; Tue, 14 May 2024 00:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 00:04:49 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 19:04:47 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH] drm/amdgpu: fix compiler 'side-effect' check issue for
 RAS_EVENT_LOG()
Date: Tue, 14 May 2024 08:02:53 +0800
Message-ID: <20240514000253.4028096-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: d783e78c-f86c-402e-abeb-08dc73a978fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0FFUXIq0I8UseGiWO0xfPGMIAVKsjzA/m4lZsza5A05Fn9k0v1WGNXKsvhte?=
 =?us-ascii?Q?j/EhwgIevdDrb/93x3dO49fFu4B/GF/L4EEPH+/uENYXre6OIyIr1NYq6sJD?=
 =?us-ascii?Q?e8kXUNHFOsBj72naEclj8xlZS3PqeHP5JmpyhkDfIcR0eo0uhCXgMW8AXoF3?=
 =?us-ascii?Q?KFS5h9RomkyPaFmsu5xkLGuVlQj3cEf5j+ugs48ppEXJysX8rWbjtsZ6dVo1?=
 =?us-ascii?Q?SQgcfEZQHR0hi+6Gh97kxyO8UXKG5dLI6HRtaxQzkalxu6mGZ7ZLYd6xDDBy?=
 =?us-ascii?Q?KSuUCAbHNKDnc5Rr2E1LcIxg5q7jCFDLUne7CXEtt+xaWXKcPttA9gVeIApk?=
 =?us-ascii?Q?yIc+xxzyZOm6+nAV2eduCKLNKaEvvX4YL6G2yaugAQTfjMWm2lWQTQ1cceq+?=
 =?us-ascii?Q?E9ORJhZuw3cpjX+vdFaoCFqVMRJ8wMXmZkdf6MWmztmKuB1Z10+ZRUgB4mc8?=
 =?us-ascii?Q?3QQaqTJM4j3MKmG+CCiqZBd3fasQSO3NL03EeveI9E2qhWPthv0lQCUkXeX6?=
 =?us-ascii?Q?J7bRBO9dHsbibq5szUfbJDLl5PYaFAzz2xzZmY0mjY+Rk3aUbPJiIFrc3qy8?=
 =?us-ascii?Q?u5EKRiwisTEH/FOU3WKa2eWZTIf0odXDBFs0lfiFmM/zlP3Xp/qG6NpkQHHp?=
 =?us-ascii?Q?gZbTWdA4AVPzxsJgeUD0U/zEotwHG6ER9TM5pG0G4Q+UV+1kxiQXObQZEaGs?=
 =?us-ascii?Q?52UA9eWbFN4vacwRslF9pE8ZJu/i8z+FSISwPycj7czreA5cUC8UZOyXs3xZ?=
 =?us-ascii?Q?uXzZD+fcA7zrm1RAl6xokjtqMBv5ome9VoA7YTrZMrVTOu61KJfNdfMm9+h9?=
 =?us-ascii?Q?YhwdKdFd1zAwoizJ3uOmiwfnvZwDNXMTNLMsTO9m2lwHFFJpiRgFeyXECzjZ?=
 =?us-ascii?Q?SQT8ydH60LuXQz6gbMT7Yh69ePNev7BBY01sgFmQQjOxDUQNuqEdhJzVukOT?=
 =?us-ascii?Q?DVi+MjfyTHKJHcuTR3jSHHGmOrSesE0EGzfvD+VtYNrZV629XFd563FzkV2w?=
 =?us-ascii?Q?wCxwpP7VSk3PhQ7p1cP8VP5OTgStBTDHCxFoRUZcrtEdcrhk5moKgSuBqymN?=
 =?us-ascii?Q?MWCaEFn9Gf7GbetLlykwCHJ+dIr6bOy4nIEO6q7ZqFuqilm4foIHBP7dGQAL?=
 =?us-ascii?Q?twWJ1ALgt4EGb5uF0gucdcIqfiYmaMxIX5FhSaCXfBK2x/NK2X06WyI+73hW?=
 =?us-ascii?Q?R+bSamTCw3ajqGK1jSMaIngKrRiCFGFTciQLv8FSoBpPnF+MzgYjkJITaU5H?=
 =?us-ascii?Q?uSFNWdeMU7oabTpTpPVRdFLqXE2FsohbNB6/LdpoLtS1To00sS4S5nQ6Ek7U?=
 =?us-ascii?Q?dho20V4RLLatUag55jV660DKJg1X15w3Yqeye1Tdu4l6ApAqH1F9o96x1JJE?=
 =?us-ascii?Q?sdofndl9T+DUEzQAOEIjGV6r//6K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 00:04:49.4878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d783e78c-f86c-402e-abeb-08dc73a978fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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

create a new helper function to avoid compiler 'side-effect'
check about RAS_EVENT_LOG() macro.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 13 ++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1dd13ed3b7b5..c04e6ced1af3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4504,3 +4504,21 @@ int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn)
 
 	return ret;
 }
+
+void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
+				const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (amdgpu_ras_event_id_is_valid(adev, event_id))
+		dev_printk(KERN_INFO, adev->dev, "{%llu}%pV", event_id, &vaf);
+	else
+		dev_printk(KERN_INFO, adev->dev, "%pV", &vaf);
+
+	va_end(args);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index c8980d5f6540..6a8c7b1609df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -67,13 +67,8 @@ struct amdgpu_iv_entry;
 /* The high three bits indicates socketid */
 #define AMDGPU_RAS_GET_FEATURES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
 
-#define RAS_EVENT_LOG(_adev, _id, _fmt, ...)				\
-do {									\
-	if (amdgpu_ras_event_id_is_valid((_adev), (_id)))			\
-	    dev_info((_adev)->dev, "{%llu}" _fmt, (_id), ##__VA_ARGS__);	\
-	else								\
-	    dev_info((_adev)->dev, _fmt, ##__VA_ARGS__);			\
-} while (0)
+#define RAS_EVENT_LOG(adev, id, fmt, ...)	\
+	amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__);
 
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
@@ -956,4 +951,8 @@ int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block, uint16_t pasid,
 		pasid_notify pasid_fn, void *data, uint32_t reset);
 
+__printf(3, 4)
+void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
+				const char *fmt, ...);
+
 #endif
-- 
2.34.1

