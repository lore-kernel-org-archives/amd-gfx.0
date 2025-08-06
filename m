Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDCAC87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2223D10E70D;
	Wed,  6 Aug 2025 02:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wo1iqLyi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D3C10E70D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=my4oM+cW9dF6NEQ1v//fmCQ1n403NK4ExDiP368pzWyhENnvFeGZIfFJAImf4QLHR4h4TTsF9GloFB7rhY/iepBriWoWSYNJIvPy1Hdn8/nYSvAKF1hbBzmfe74M97fURVZSpzJ9L1ZlMOYTW2du2qyN/vF671G1raNg/9mTethNvlD1VQlmhGmcyUVghcICaTc/UJrxdgqT8brsyQkLh5G4YETyoxliO/hqFkGMf3mcTtHyaw6kcCg/olcf5UprUyY38PRuS+KdzpYsfQ90tNoyfZknGwY1G02TFM5QW8hLc9YxgA5I0It7rVsx51gfReN3qSUcCz4FXmgxuR3yOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=S/x4WdG3LAusgmLeYSNWfbkRRA64trhm3IzOlidpZh3qHxHPpdw28nI3ldF2K27aB7iCWSjxM27tFGzzTuh4HtYlDtTXq6po1FX1YeBmtK8J/wbtf8h/YBmtboROEA9jzLUT3i2cNs4VrdU7gmmiJdCfv/gDitsatvjXMhUk49AcrFGAy4Jp4sB+Cl+TzGTJZgaHDu2QW1GOzGMuVEGBJVbxBtMJrZcvCAMKJ6UiCR6sHLl8WAoTpgSTj7lpHZYPgopGc2mo3bQRo5M4EP0d3agVpfoB+CbQY5BDyL1WmiORf1Ve7orXw9/kZboWjEod+B4pYZoFeqLWairjvrpTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=Wo1iqLyin5r4I1lAa5PP6ClXZxnk3BCNSzk8D1R8ujgDKySFXnEpkPn/vDNBCaJeaHvuaiFnEZIJllKCU2cSUAGMEhrFNrbRy5Khavjzn8vECHlSQgxBqcLme539ZCesg4dfMaQhMnFq+wOnneB2MBIAI67OuQU4u+2uve8v0nE=
Received: from MW3PR06CA0011.namprd06.prod.outlook.com (2603:10b6:303:2a::16)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 02:29:23 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:2a:cafe::1c) by MW3PR06CA0011.outlook.office365.com
 (2603:10b6:303:2a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Wed,
 6 Aug 2025 02:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:29:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:29:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:29:17 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:29:11 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [v7 09/11] drm/amdgpu: add user queue reset source
Date: Wed, 6 Aug 2025 10:24:54 +0800
Message-ID: <20250806022816.1050823-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: f3419e27-f00f-4cad-f977-08ddd4910e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDEyYlNmUTVLZWlQYWU3WGVGL0N3dlFwOXZPQjgzR1Z0Y3JyZ0hKZjlCZTBt?=
 =?utf-8?B?dC9McnR1WmozbVJSWnNGQUR4SEdOTXBsZDZReHRDcUFnMCtZZzRqWG9EbDdH?=
 =?utf-8?B?REQvYm1ranVSM253N1MwZGNFQURkcjBZTmNnQzJ4NDZjaDFoQVdDOG83Tyt0?=
 =?utf-8?B?SmVhcGNVZE4vTm80YXQvMHAvTXphYlBkclIzSURWUVQ3ZDQwUUI3Yi9wWlBB?=
 =?utf-8?B?L1k1QmZ1eUxoSEwwS3hRMk9rNU5WVUt5SnQxTEk2RGdRSFBhc1RSKzEvb2px?=
 =?utf-8?B?SDAyUHF2a1dPQjFNcUtZcWFwcFJyeERmcjF0YmkwV1dmdmM2dG9zWjRCLzhZ?=
 =?utf-8?B?RVA1SmFmOFBiYW9KZEFWVkdlZy9Fa3pjcmJ0L3RYUE1KTUZmc2xKVlFMd1pw?=
 =?utf-8?B?R1BDUnJ1NVFWQm5PUTEvTDB6UE1rQjFyclM0SGJMaEIrbGFFaWdoRjc5WlJK?=
 =?utf-8?B?dE5MbVpxSndHUHB4RlVZQ2NYcmRtNUZtL1pJOWpYYjh1Vnd0cmV0NnZPU2FW?=
 =?utf-8?B?a2F0SXlpRkdBMm9CT0REVnFWTDZPelR6ajdLekc4YlFOalQ0UHBqbHQ4T2VL?=
 =?utf-8?B?UC9DalB6dTRxc2pTTi80aU85STlaZkJwQWM2M00yRWgyNjRyRTMzVlFDbkw2?=
 =?utf-8?B?SnJMV2xmNWU1WWp3YXBjUWlKUllaRGI3a0FrR0JHRlUyVHpUUlk5MWVhSnZx?=
 =?utf-8?B?ZHY2YXBMdHBPV3JjdHNOM2dQT1VheU9PRUxpQUk1U3hXWFl3RzEyNTFtVWxi?=
 =?utf-8?B?bStPbEJUOU9lY1prQ2pLNVN3a3I2TXlTRFZTMjVjd0dKSHFpdG9hZUZDOTE2?=
 =?utf-8?B?enNydHcySm5wVnFCK3I0TS8wUmR6QS80RS9udmJwcmNBZHVhU2xiVWc3S0RH?=
 =?utf-8?B?cnBBRE5hUHd6QklXNmlHUmxqSzBUQmdVd1FNVEpxaHp4eXFQUmxWRFFZUERi?=
 =?utf-8?B?ZGpzN0ovdjhsS3FWWGtDbTBLN2pGY2JYZ0x3cnZhVFRNcGx5ZVlaY1AxSWNm?=
 =?utf-8?B?VGg4Qk9HZVBnK0xKN0g2L1dWSldnK0pXL2xxbHlJcnJkbFdHcjNtUEdMcmlF?=
 =?utf-8?B?aSt3UkpidFJTK2JpM3R5UUlJUU1BbVRkdFBlSXVlb1c1N0JjdC9WaGlFTUJW?=
 =?utf-8?B?Y3hKSURvY0VlSTFuNlF2eG9CR2FYdHBiMDlYbnNwd2s0QnNIQ0xZdVBsaEwy?=
 =?utf-8?B?L08wMzVuYTRZa0ExdHhlTUZQaHQ2MVZibHNwZUJHbzlxRkZMK2ZFT0tFWEQv?=
 =?utf-8?B?aktiWjNhVTQ0YnNnVjlNR0dWQ0tKVHhuTzU4S29CRjJEc0FzM203MXBzeC82?=
 =?utf-8?B?UkNkbEcvMloxUUNLNGt5U1lSdTdFNlNFQllSQU1KZXN2WUdGUXk2WTBSUy9L?=
 =?utf-8?B?OXRmZEtjL0EyZEF5Z21XZHp3bHBCbTZXK1QrOExJOUNENG9jMDRBTjhWOHFM?=
 =?utf-8?B?dmtaY1hDbDZmSnRadWtFM1lRV3kxd0E1Q3IxRnVzQVgyaG5PbVg4VEhLY0Nz?=
 =?utf-8?B?VUhNQ1RHYUxLazF5SmNwRDAraHBlS3hVb3JBZEtiUGhOMnp0NXRFWlA1S2pn?=
 =?utf-8?B?eGR2YnYwbmRSV3pLQlZjdnFwZ1B6WTBmMEFJT2p2ZHBjcEdnVEtFd1lOeWZS?=
 =?utf-8?B?VW9VY294UloycXJPaVJ1Z0NhdVVLS20yMlVwUmplOENCNXhMbVdzK0FqR2lX?=
 =?utf-8?B?U2ZJKzFrYzk4VFIrYjRGVkM0eHNVU0VWQjFHVEtoc1ozYmhlaTNBQzdxSitq?=
 =?utf-8?B?OVZRYnFOcmtselJjN1pkbVBZVGk0NjFWc1NqQWFmeEtsWjA3Zm5CaFZsODJi?=
 =?utf-8?B?MlBpdGNWZjlDMGhxeHBsWFNxMFl4S3ZXZE5LRHBRQS9hU0tTRmVRVzAydVhi?=
 =?utf-8?B?amNZQURRaFZFMWJhanZPeXJaQ281TFFPQzJQQVNZR2x3SktrbSt5ZEFma200?=
 =?utf-8?B?N0swMzIrZW5qSHN4aXJBejQ1QlNaTUhGZGUwb0R2NnZRdG9wRHZ6VGNiMUdN?=
 =?utf-8?B?NStxMlRCQzdOdzVVbHhmVjhxN2x6ZDBKVURVQjFyOVhycjU2NjduWVhUVGhJ?=
 =?utf-8?Q?MaLski?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:29:23.0093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3419e27-f00f-4cad-f977-08ddd4910e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
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

From: Alex Deucher <alexander.deucher@amd.com>

Track resets from user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

