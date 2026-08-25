Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016A0C61DB9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 14:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9111610E1E3;
	Tue, 25 Aug 2026 14:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VuieWONt";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FFC10E1E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 14:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLTQgR6SkTPay8stRhU0Ot5mS+wGKUfOcATc3HyTAXxqraAX0x1b/Xe+E1JT0K5K4JnRWgOjFKmsvmJ88t00n+P6Nl7WCth4KjOjHmBAfBNeKm5BiN6PS3wBAaFKK4XM+SANwaR1IKW95xW1XhPFI5MgAUh6m2K6Lv0eZgvQZAppv+4O3f2xmM4Jqj77skOAs4Sd3QlM5Ng2zCK69Ns0D7GrVCJHqVT8m9PBJYnDv5dGj1zy5XyhTvqTFdEJJox3PgonoxQB2EgBoAQanXoz1zdYkimnnPLpxFOXeKZryLozEKQUcmOal+jN4z7C9OBwS+IOrlDazrkXHsizjmq63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+OUJaNG7D8mSKkBRue/YxwJfbksYehrPKwZdFQvTe0=;
 b=hzPrBeKsNchWgnQPwERDWU0vmoI2TFKGfGdOKd3SaKUQ+HLFq1ldt8amohC3RYuyhwdut2JkaoSUKmjDfWz4iqLMbJA9TDnigMD/WngurGKxpVr0oqKdeRhW+VPeLgMpAc1U5UYkaCbH9liiNs+UMTXS/JjIgLjF8sCREipf3NzIm74qi2V9UgxjSKTUr88IA9izmmrg36TWtRv5Ipn7hcbwxdoz1+mrpR6B3mJVjKD18dGFwGdjncxzJqAHy2nRFEsAEXRJxcSI/YUaz+QlQWdDqWeS19LhIfy860stkd/7XnmYKHMDa5BZDmMGxwZLUSR6FZOfPwzQ6kgP3JVHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+OUJaNG7D8mSKkBRue/YxwJfbksYehrPKwZdFQvTe0=;
 b=VuieWONtxHdunhNYJC0Ja6NVrHVOCCFi1iqkQb0GlHN5YpsLNXbZUHBjkcIZrPftUNy3lhDJaI028ZeJu7xxffd9yz9wdUFU5Q5nzJfVoHwfaX4Lg+1JVV4UpkZhj34RG7+lQjDQJd/yuqd21MDmiJPJ4groXDbFcW+7xKn+pf0=
Received: from DM6PR07CA0076.namprd07.prod.outlook.com (2603:10b6:5:337::9) by
 DSVPR12MB999150.namprd12.prod.outlook.com (2603:10b6:8:388::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Tue, 25 Aug 2026 14:58:37 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::82) by DM6PR07CA0076.outlook.office365.com
 (2603:10b6:5:337::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 14:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 14:58:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 09:58:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 09:58:36 -0500
Received: from RSB-IT-SPARE06.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Tue, 25 Aug 2026 09:58:35 -0500
From: Filip Adzic <Filip.Adaiat@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Filip Adzic <Filip.Adaiat@amd.com>
Subject: [PATCH] drm/amdgpu/psp: support CONFIG_SQ_PERFMON on MP0 13.0.15
Date: Tue, 25 Aug 2026 16:58:27 +0200
Message-ID: <20260825145827.56199-1-Filip.Adaiat@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DSVPR12MB999150:EE_
X-MS-Office365-Filtering-Correlation-Id: df60a48f-0c3c-432c-ea2b-08df02b957c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: isCsW+C2dUUbpDhhJuwEAIJ3MXi/RnOCJlLDtExT+a/1WrBWA2jWSlbHzuVLOx3Z+5wyDpQn9BZOUzRvZzqPtkgo8xPilv/0b214DcUWTNTcJwEiKrpXw5V5O67rzYZ+oEXMrciYAwbcp30sfzxIM1FRlXpaJqzrmh0lR+earCWnsZi4INkHO4d1CygkT3/csn0pgpJAXRwhvk5FtG1Wwmde7Uf+Yjo8+L2SX9TJkTCM0RXsEk4PAKGEzH0ifLdBpvCqDYbMgaamC/hCccGw8jMmr4YPHUAnDHgaa78Tpr6q5tyYqJ22qGjUV3yr+26PxBviFCgz7vPkAoCKiLqen3IBrdHzt/1H7nhwY3twSOn1edwYcfzK53aocy+TFPY2WsE6EAiLumgFyZx5/1q+gyFXtarDIDE32B5EnVJExat4WKEq/faaONQLN008DbXE58sQXaVULe45rr0q6E4c9yLJ4KvUSCddVLbZMd5YSR5lfaTIjaOXD2ly0zoF2+YukXD4A9mLLYnAOmcTU9pe/I+W5Wd0gmEKYAL/lLFEW0ZIu5KBBUvMk7bVnrYi+CPJqxMzOMa8Gs+1jFLZPq6/6q6fYXXvkxwWhLMETQqPRNmbF7TKsvGv6cknP4iwr1A36v4apevuvGQOBE/p2EgUKsaqKU5/J2no6ge4mPnRUElralSrwgs4dVzDkhdPMajAms+NluWOrOWuhE7uJ3o+EA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CwWHiRAbd+HVQSlVU3VXVbCTzreW+PiYTPxTJAJs/0NsdpucRJeM5epr4cqa6NLj6HyBOWwri8KirHZnbYpVYEyp6WXYP+E8u/I8N78kjAerUwBv+JTTDfP24grzkDvyn/qQeXHLKTqqPu2I/GvRO0Y17bBAyUTpwI0EAoqXRJnbibJOYjGmyVkC/kU7Xb0gI7aJdsym70q7FVQdmdGG37Y68Gpq5ACnZdbhi30SWFxDdbnZqGkIqj5DP1YZqB4n1NrJ9Y7UOg8rReR99SCdyQMfQtmUp2vEr+oJQI/4IbGXiL+yR3T8EIN7ZuS+3cSDKhvazUmqHETS25BDKDpd1kB0fycTibweOEXweb6hwSTaKRGsk/0yJs5HtXwRdz060oUcBBJzA+DXhyrnCsb4Mt3pxpkDQIBqYalJ7FJ2JRzGsgSpgC2NRFv9WoV7Yz8B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:58:37.3532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df60a48f-0c3c-432c-ea2b-08df02b957c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999150
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

Extend the MP0 IP version check for CONFIG_SQ_PERFMON to include
v13.0.15, matching other supported 13.0.x revisions

Signed-off-by: Filip Adzic <Filip.Adaiat@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a0f6df5067e6..9784ea5488aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4708,7 +4708,8 @@ int psp_config_sq_perfmon(struct psp_context *psp,
 		return -EINVAL;
 	}
 
-	if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6)) {
+	if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6) &&
+	    amdgpu_ip_version(psp->adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 15)) {
 		dev_err(psp->adev->dev, "Unsupported MP0 version 0x%x for CONFIG_SQ_PERFMON command\n",
 			amdgpu_ip_version(psp->adev, MP0_HWIP, 0));
 		return -EINVAL;
-- 
2.43.0

