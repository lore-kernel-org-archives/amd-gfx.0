Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5F9F46139
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 15:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5C010E3E5;
	Mon, 23 Mar 2026 15:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BdhmXDdJ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE21C10E120
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 15:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVdXfHLIiMEq3PUmTJMWvKoGliEnuRZZfzXWkAsOnTfelMuAyoD0NAfoecI9DR9nP4Lt2OCNXzFIAM0S+2C4TELkzWShea8bXA6AtmIJRERpBFzzolmOyROtCkuko73lecGrHJcptxNCd7vfEJhx7mcwHpCjyX7CxgdBvnL4dp/vd3mgE0QrxGFfeQiz8k9aCbCHKf3izu5lri1ueCj3KT9Q69Ik9NYwgdPZ0O/SIDtHdFsWISfaInFVx4qi1pY5NYoeV92WdETlUq/UzAxLUuUp7ReHywJPF2vnezKO7TcrsLbwQKVh5w8/grVI0cqfkLciHtn7QRRSrNq1+Po19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWEnGURwke2KL5FeAc577eJzCmWSDorzhAqdESdS6I0=;
 b=dNyrXGCEp+0r2kZG58/WQl8U1t2b1F9c0k7vZHktqntP5GzcOmvYc+pbhljPBFHMWsg1wAT5a8UlQV+Q8ksbnFdhJFdPI3H5EJ+eVaST+VYtY1DlsbSn1HsNb1uv0Co9stCyqGccET3+x5oTK9iLoSlfaa/oUX2rM6KLhbmRl6kpEWzrgt/ic0lQCKNgM7RqvQQoQTB9h4nOJEf8BlCskHWxM+Ctb3a0C60kW9g7rmjdVXRye9KhYr0qt+Y3V2r/RyP+sTrfTVrqC9gj9cz9Q6bxSN7O+3J50WL3JA7wnLhePYjMV2FX2FnSMIvBG15skA2CsQGYZ7CFszviYUTRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWEnGURwke2KL5FeAc577eJzCmWSDorzhAqdESdS6I0=;
 b=BdhmXDdJmUCpzEg/+oPsWb5hgabQFJBQZj3FxIp5jBRMiKuJo8g4327UZNCGCWYhDNSzzM2Ior8aQ/4Jj3c89CVcFSpHa8xviwUmFSLd7o1bWO11h10YtDBkK+JN/Ulu5ZpluykWhX3Lvr5kgwFXW0oPkCy9KCbQAzWlJfNSMQg=
Received: from SA1P222CA0147.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::11)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 15:41:29 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::f0) by SA1P222CA0147.outlook.office365.com
 (2603:10b6:806:3c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 15:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 15:41:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 10:41:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 08:39:34 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 10:39:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>
Subject: [PATCH 2/3] drm/amd/display: Fix DCE LVDS handling
Date: Mon, 23 Mar 2026 11:39:22 -0400
Message-ID: <20260323153923.1055788-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323153923.1055788-1-alexander.deucher@amd.com>
References: <20260323153923.1055788-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: a242bab1-3141-42f9-c4ad-08de88f2a692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: SRqUfpvI+EbyDI33NGasGozC8ekWl2RH8eqyde0JDcnga72zzY1Hx3UU3CVPGOd5thkDOyJgXKN/GEntmFViznUXV8Sz/9ZG9Y+7PoigLainvRdm/JAX0TKRb4+9+BWmNdPq5v0/mWboV53FU4r75BZh1kpj5MbBkzg8S4FdEmL+5JqQaNveKTXyXgyYReWtbCorVyJOKy//4a7zVA3znP9EZNcmsy134NsDGqhy3F0v1dYMXpjpDDlYH7hrgj/cX+8aI74ATpi+I3fgN3UQVMEajwXPeMQ1iwUetqqZSTs5HKoOVJYtrHGplhM/xVcwkYe/w0cnPFw5vh3pJxlMNKtsvQ+AdROb5Jurd5mhjNNOFg8fI/zbgnnGTf8Z+otczB4GMaZTK0+X5iWSbHN8ayMqiIQwvc4jSr5g/z2fgJxUG0dYFXDL+K0W+6r9BILEKjQGEpQ+JaNUUZPPIy6XzyCSRlA4+UPmCZKYdGJgEw4Ok4i9AgKb5tiHhS+9LwQDPP4BCGFstqB74Uj7UjgblT8BkMdhuMO5Mxd3p8nmvLlihW52197KBUiR3B3zb6wkEzSGp+iQ/YC0kIamhd97Ay6yaWDHVdnB9dfTgQnK/sgWZjJaWGdLGxSF+m399Z7Y4U3QlJXKO+BkvynjQQQPMKt0JwRxx3BHJVjp6YKPVUesF720QUYfQxqENFvtpVQa0ZGnJ6d9GgPh+Xu8eq70PQ5TYzmIqcZghaZYY7tkDHs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6iAkLjBXeyV+FS3SQfdCNYctngEo1+eLT0Y54K5O0J1Jq9bmaEqFX2EANlLJAiIjO5HcBq4fAlJ+tORmTEX6ZvGSthR2PKSDDFUtXt0Q/k4kpHPGqSJ4B9i0k2Oq09hdGNOm6YiInxIeWHTCrtPkuXbjFYYMDgAtpE7k1o7ljq3vxpcnJJwzopLjv3tlG5mRowfFzBtI3ISsr9/zjUg/T0Z118cVnCCKTU3S9mmL/cM0tSBzPHzgD2PIPzEEpzuuAuja47ElJiqRETTBAkYoUqEjZtS9DbHNFmZcMGqf9onF8AwMAlrgsEWdcjmxWQ/0+pylqmRCFctbjpXn6YxwK5xhYT3/3xzPAYsWYQ0iNtv8e5UYGKYRVlsctdoiQj7TAwnGHuoquSbE6obeS0qGbNVJ2LJbpbR05eWhukvaQltdDQXkxKvNJHV+CQ80gvFy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:41:29.0870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a242bab1-3141-42f9-c4ad-08de88f2a692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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

LVDS does not use an HPD pin so it may be invalid.  Handle
this case correctly in link encoder creation.

Fixes: 7c8fb3b8e9ba ("drm/amd/display: Add hpd_source index check for DCE60/80/100/110/112/120 link encoders")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5012
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../display/dc/resource/dce100/dce100_resource.c   |  6 ++----
 .../display/dc/resource/dce110/dce110_resource.c   |  5 +++--
 .../display/dc/resource/dce112/dce112_resource.c   |  5 +++--
 .../display/dc/resource/dce120/dce120_resource.c   |  5 +++--
 .../amd/display/dc/resource/dce60/dce60_resource.c | 14 ++++++--------
 .../amd/display/dc/resource/dce80/dce80_resource.c |  6 ++----
 6 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 05f7ff60f8f5a..2b884e28727ba 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -651,9 +651,6 @@ static struct link_encoder *dce100_link_encoder_create(
 		return &enc110->base;
 	}
 
-	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
-		return NULL;
-
 	link_regs_id =
 		map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
 
@@ -662,7 +659,8 @@ static struct link_encoder *dce100_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index 7c09825cd9bd3..d957598911cbc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -672,7 +672,7 @@ static struct link_encoder *dce110_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -683,7 +683,8 @@ static struct link_encoder *dce110_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 3f0a6bc4dcc23..1cce903d477aa 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -633,7 +633,7 @@ static struct link_encoder *dce112_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -644,7 +644,8 @@ static struct link_encoder *dce112_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 92890784caa6e..8b568be20a77b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -717,7 +717,7 @@ static struct link_encoder *dce120_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
 		return NULL;
 
 	link_regs_id =
@@ -728,7 +728,8 @@ static struct link_encoder *dce120_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 
 	return &enc110->base;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index d41d24b76c11f..2f5ee9d8536af 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -747,18 +747,16 @@ static struct link_encoder *dce60_link_encoder_create(
 		return &enc110->base;
 	}
 
-	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
-		return NULL;
-
 	link_regs_id =
 		map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
 
 	dce60_link_encoder_construct(enc110,
-				      enc_init_data,
-				      &link_enc_feature,
-				      &link_enc_regs[link_regs_id],
-				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				     enc_init_data,
+				     &link_enc_feature,
+				     &link_enc_regs[link_regs_id],
+				     &link_enc_aux_regs[enc_init_data->channel - 1],
+				     enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				     NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index a68e799d58854..406705fac7d64 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -753,9 +753,6 @@ static struct link_encoder *dce80_link_encoder_create(
 		return &enc110->base;
 	}
 
-	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
-		return NULL;
-
 	link_regs_id =
 		map_transmitter_id_to_phy_instance(enc_init_data->transmitter);
 
@@ -764,7 +761,8 @@ static struct link_encoder *dce80_link_encoder_create(
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
 				      &link_enc_aux_regs[enc_init_data->channel - 1],
-				      &link_enc_hpd_regs[enc_init_data->hpd_source]);
+				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
+				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
 }
 
-- 
2.53.0

