Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3686FEDA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3BF10E636;
	Tue, 17 Mar 2026 20:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jt0s+fGl";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0390510E5FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJhRdmuqMiKVztdPb61hUi7qNx2g05oKrsSMlFcndzN3C+Zw/fXzP9AECFk3YQMbbAZQfyqSb8GuXv6D31q9KZW1n68kIKhmvBQTovltS8KW83e6Lv6jFlh3RCyZz8OUaiV2Fl7bS0eDm7qkT8wxcldSXBePVuBl6h18Mor9NWWRTvPnplVxpjcRcrZi6XQgsiOuzPihN5YPWM5kWYhKb0YDzKChZQswFnh+AfEitslib0ioodG1G99+lWPyFE1q36GFBK9QIXXuRC6j+OTuJHnJFXvicDOnqi2gHFqOEe0wBseRaCDyqZTBd9UBN6tBOY8McUlmZ10w6KFaI0wrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qnt+asC21ey7BCJ8ylK53wpoWTM0ZmZW3ZpyZfhTS4=;
 b=r9kwyL1thMd7x8JTVIn6jf6/h4DNEdHLdMOLtNUt0kmfmn92nBV3o3J5otm+tnXGGx+g9cdDW95T2KHyKSXCZzCeNAj7lWwiRcQHM8WZ+Hn2tSsFt3BkQI9Z0jqpRH/aU1h8zcdCsHgtmLp4+2j2kMZ9gN8Ybp7iwVBvUiQGCnHARZZIltu8fyR6lfMhCyktyXthown970Fw7u9PjXi/G7DpM2ee2BBgJtjBaqW5EdCva6OW9h3rrMx+yDnMMfXXradin6OOWqhChlC8tjJSendBzEekZYpzBKs9v+ROXggOkx/8GqR2/ZCgmeu1ou+/HWB6v+gwKMtNdVhThcs56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qnt+asC21ey7BCJ8ylK53wpoWTM0ZmZW3ZpyZfhTS4=;
 b=Jt0s+fGlHfMBT14ifSbGbpfSw+S5tFG4dGRG9Jr7H0tEJq3a//2diO1caM34DA+lwZx1KqlfZzgLN8pHNpqDQbD3jAh3Y5143uCgiyvSICJHAMXo/aeRPnNt5eHDElQ8Lh3kC/IiMOc7/dN1QudhgWBeXPdpPDRzxfzJsye9Lbc=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:12:59 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::88) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:12:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:12:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:12:58 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:12:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/25] drm/amd/pm: Add mode2 support for smu_v15_0_8
Date: Tue, 17 Mar 2026 16:12:21 -0400
Message-ID: <20260317201242.3808136-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 969e1131-1dd0-46ff-dbd2-08de8461960c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: iXZt1QtWmkKG70WB2PIM+XjxTX0IIoKLrW/0a7kDjrEugdu5J7oI7/nMKwgNOuMPzjPqetbsQFpJAMd9VFFbABamljt23IofOgNDKoFLtWOuSxivApgYRRn1uJ2PJlMxiSJMjTZSEVlpoioh9MbgrprPyA91dL8UxkCAWGb8lyOKvmXKhoPCI/bw21tspDaG+hy55BFocISLsnUWVdrqTJwQE83swMgACg9CVCNnVXVemd1cAUfUQNoD1Xr9vWdNLUzD16SPKCcFYy/xgcLNdn0iYTiCTpsz8HVMTfXL7flBVnXRMlrsKpu35AC611m8/QADHIfjYMbSIXtXVk4V73xrF1Z0KpRhKfYXCBDmvIhj1EEIOYGjB4CxcXoJSMUxxjnph6DDNn1knHdZ4OyanHfX7wXEvseZ+FeTg+//9zt9dJ/i/9s2iyvT0EIr8kUl27S7Cgx5oLB18okdUft+9YtNHQIiymPu1NRbincOZLnAyXNjCVzgl3AnCzmYRIJ2w9Swo0XJGFVbm1hsuH9E0tEkrGyO8AQQT1xaF+lyrcRFqucxfZ64Us7HNgOZJhCge2AkIggANrrLIuEeOocgej/+lxKi++P7Oq4DmfCt9+Ri4KbUT6AeQ6HUmo9u4J0/7N3xx+FT6kxYttbAPcdWN56AjyAZ6mqaKsv5qVQ15UBIPh93UT4hSzxLdDyG5asO9t8MaRKUcGGwg1LIMzvQ+bupUXdIlr+9NaxyBJ7c+qTZzGtDhYnQuYeDNKZuRrLM2s3jYA3grRdCTQe0Ft5AeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2lBU6mYibSYS1rLnv20qHYfxa+fN3ld/CBTi2S9zMwlSVeTt+bsBTt82mNcnC+pTyVIx5+UWn2hmw8lkIprpdHT+1h7D0DqmZIXxYgWmnpjkxeCvReBjdRcQ+DvIO1BVjNNboVXW9Q1X8+yT3eiaXkZgQZdasdt8rew/JY3aeQpA4VnkUGIsFwdxaA5AO5cegSc9E5sHgThrqUVVhQUjqGoGYn7RmIzHGLGJIZ8kSzhydI3XvQ0lw1nj1Neajansa3hbP00NzZdKG8sydVmPoRFxVipGVepmGdvIBhwXTCXkNP/Yhnqgtl/qBIuqs7k1F+VFpi1gsVt1fhFwhdZdE5EmfmKaVOenkJ8QBf0TuKpjRWvXqJNyIkn4Cr9ZKJD/AI1qll2gF2pTOM37dsMNQxE/cVEhAUtbLnu9hFVxYUxPdoYgYU/p99/f4iY/7ZYt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:12:59.5408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 969e1131-1dd0-46ff-dbd2-08de8461960c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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

From: Asad Kamal <asad.kamal@amd.com>

Add initial mode2 support for smu_v15_0_8

v2: Move out non smu code, remove pci save/restore logic (Lijo)
v3: squash in updated msg (Alex)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index c4da0cdc1222a..b3dc04ea5e713 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -430,6 +430,49 @@ static bool smu_v15_0_8_is_dpm_running(struct smu_context *smu)
 					  smu_v15_0_8_dpm_features.bits);
 }
 
+static int smu_v15_0_8_mode2_reset(struct smu_context *smu)
+{
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct amdgpu_device *adev = smu->adev;
+	int timeout = 10;
+	int ret = 0;
+
+	mutex_lock(&ctl->lock);
+
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset,
+					SMU_RESET_MODE_2);
+
+	if (ret)
+		goto out;
+
+	/* Reset takes a bit longer, wait for 200ms. */
+	msleep(200);
+
+	dev_dbg(adev->dev, "wait for reset ack\n");
+	do {
+		ret = smu_msg_wait_response(ctl, 0);
+		/* Wait a bit more time for getting ACK */
+		if (ret == -ETIME) {
+			--timeout;
+			usleep_range(500, 1000);
+			continue;
+		}
+
+		if (ret)
+			goto out;
+
+	} while (ret == -ETIME && timeout);
+
+out:
+	mutex_unlock(&ctl->lock);
+
+	if (ret)
+		dev_err(adev->dev, "failed to send mode2 reset, error code %d",
+			ret);
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -450,6 +493,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.setup_pptable = smu_v15_0_8_setup_pptable,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.wait_for_event = smu_v15_0_wait_for_event,
+	.mode2_reset = smu_v15_0_8_mode2_reset,
 };
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
-- 
2.53.0

