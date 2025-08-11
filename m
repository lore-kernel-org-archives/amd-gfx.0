Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F2FC87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FD210E40C;
	Mon, 11 Aug 2025 10:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tc+5LxMM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1754310E40B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5vMDarqU+/k03sd0bxex1Fnt7CiSAzcxfAg0KSemTOEzBR9qaTsWHJDbfAKf1HtLAeFt8xe/hYsZaT9dRc9AU4quiX4O6ISAWoMZXdNREoWyqG8vVCcb1duTR88614wAZ7anaW0Rh6fOSpphdK7lJlPx+jkfGJWiuseWZfjiBEJqP6sHbnBHi7w2kXu++XEeR4JTLqO0MpaX5lwYw/j4SGurJlsq+ZX6C9kusibtWtvo1+BEh+KtJk/dXnY4yPmIQbIm79r/RtpSWJjg+iBmwsfKA0jkBFusAXZxTwHnuEC6TCRU4/XOwFp8vKzCq5B/BpQkjmyGLyDWtx6CBzdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=MJv8sWlKsbL/sydc5gXNCKO57kp+sbJnPASGtJkmw+KDA5Xt/rYokhY3k3qxhGX0ZnBy5ASzWm2qD43WrvcRZC/unOS7fGG+fDSZ9PBo7oVVmv7pfAYTRmC2gerA3dRo9ir1x6Kzc6RU5Le/PV3LjBG+BIWSS4sKjunysxoHanaifqDir46y6ldOu59YnTW5D48tdFzMcQYcWJwB1+7Y25Y9cQB08+JH4dlZp4phZeKHv5GrrOGzKzT2UaO2NvL/SqytEA2cqRs+JDfinjheh8F19PGhVybajEI+3Kttjr69IDSGvZHyGH310Xx9uyeGBj0CftPwuO/ZKMZiM1O1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=tc+5LxMMF5sc39g3G2eb2VNwPQ1Yiui1OVm06yaQGHdsRbfwlQBhRAXHbw5nlMuwQd2Q2Rg5eiPoL9Bl1r9uW50gGLl7pqBaAhvzyVUdOrVkSbrEhJxTlpKySoRdcfyiCKjPUuHJyaISGNZacjeK2KyvFNb5yqCI/xE2VzDMVBY=
Received: from SA9PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:21::21)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:00:28 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::c6) by SA9PR13CA0016.outlook.office365.com
 (2603:10b6:806:21::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Mon,
 11 Aug 2025 10:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 10:00:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:25 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 05:00:19 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [v8 07/11] drm/amdgpu: add user queue reset source
Date: Mon, 11 Aug 2025 17:56:54 +0800
Message-ID: <20250811095937.1978747-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc0204c-dfc4-447e-bdc3-08ddd8bde59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THJFdTdhbnBpMHJLY0drZmlnNFM3Y1Mrd2QxWVpkQzlJMDl3M2ZMcERuK01t?=
 =?utf-8?B?bmdkc0xnZ3R5T0lscEVUTWtteVhGZi9XdkIxZzJOVzJQTzdLcldUL0RRbnV0?=
 =?utf-8?B?bFVHdnlHbnVUMUVzOHIzWVJZaGFUZHhWejB6RXZiMW1obW1EbnhMb25rQlZX?=
 =?utf-8?B?YjUreTJsbmxld1NUUzJoWTNXTUJNRzZUUUFuY1VFeWdTcFcrUWoyTUhkOFNY?=
 =?utf-8?B?aHlPVS9hTytaYURUMThQbUhjWURFK0xMNm1NNHl2UFBLR0l4RFhzMXFvYUZq?=
 =?utf-8?B?SEVkOHV1NGNDVHRLTVMwN1o0ZmZSNnBtUjlaZzAzbG1oUTR6VU9keFhYK0Np?=
 =?utf-8?B?bUVKOFROaUFKU2ZRS29oVm0vU2dwN1JjR0NEU0Z4WlM5amdIeU1uRzV1T0lU?=
 =?utf-8?B?cTNrOVZWbkxzaUlYRnpvbENwb00rRTBJbnBucC81YkRNMmtweDZJODZWR096?=
 =?utf-8?B?VkNrcWVhZGtXbis0MzIvVWJScXQ2ZGlZeTQ3NDIzYWlBZklZUVBNd3hLK1h0?=
 =?utf-8?B?TzdyaE9VcnVKREdLVEE1eWZ2b1ZRTnRhRnRzNmcramg4VHB4QjlJcWRsVWJk?=
 =?utf-8?B?WHQ4U2dTMTlmYVU3TUhEWUdEYWtCNmNVWHplZnhYNUhzeWdoUFQ2Mm43NkdF?=
 =?utf-8?B?dWhGNWNwMmJsM3ExV1hmN3dySFM4MnE4RkY0MFVUazBzWXpYS2VZMUhnRjBs?=
 =?utf-8?B?bXFJbmh3NVRnNHowUXVFOVFEV1hHTFgzOHhwVGVtRlFWM0RkQThtUlNuc08z?=
 =?utf-8?B?Z2JpcGJEUzhOYUM2R0ltcXlhSER3RnFSTVI4MVNzOEZYcEs4NTFCZndSU1Vx?=
 =?utf-8?B?ZTVaTG52NGpIZGY0bGMvSUNBSjN0VXF0V2hSSHR2M29oUnc3L0Iydk4vbEE1?=
 =?utf-8?B?c1ZaT0FQalc4aExLM1JZWm5GZFJSUkZ3QVBOQ0xmM2dQblZ2L2syb2tkOG9n?=
 =?utf-8?B?NmU1dFRVSDVoWmtGbmswZmVwTmFlL2N1STNXaVp2RHo2d0YrbXFLR2tKc1JZ?=
 =?utf-8?B?dENnaENFQWxVUmF5QWVCUndtcURBT3NGVFprcmVPR0U1Rk9DcW1WUXBXMkw2?=
 =?utf-8?B?eWloVjBLNG45aXY3czNzYVJzZjNGMHFOZDBBa0R2TU5qU0pNYTFFTC9RVmVD?=
 =?utf-8?B?NXYwTUo2N2RiMmVPb25TaXpuUER3Q2RoV3lRRWg5VE9SU0lqYVJkbDNLNWFt?=
 =?utf-8?B?eTZYdGkvWTcwTEJQTm1HZXVjNXhrVjhTVENjcktWNTJmS2xCU3VyWEVaTExy?=
 =?utf-8?B?NmZSb2d0S05Mbk9SMFA5QlBKUENKY1FCaDFrTUhvU0drVTdEaW02aHQ2RU5z?=
 =?utf-8?B?VHZJM1lUNnR5bFFzK25SWmpYaWdHWDd0QktSUGhTWVc1T29RKzlNSHZqbWZB?=
 =?utf-8?B?ZGJVY0tNcWF1bWZkSWI1NDRlNmppNDN0eDlFcW43LzlQMWR6KzB5TXhTa05P?=
 =?utf-8?B?a2hWRkFqNXZxWDlnbCtQU0VIRTFON2pEb0lQcTlKNTJKUGFwSE9kbGg0Y0JZ?=
 =?utf-8?B?VExjVFRHaWR1Q2p5b0RUL1FGMlFmNFdkU2M3bXpvUmo5eFFEQUNjTTR4K1Va?=
 =?utf-8?B?Nnk1aE5rcEZveU1YbFMwazZnMGsxQUh6Zld3c3piMUhTcm81N0MxM0VpTXZ1?=
 =?utf-8?B?VlIrZm5ROXh1TW4vdHAvRlRzTjVpKy9mVzU1T2tzKzlsTnJOT1R1OUl6L1Mx?=
 =?utf-8?B?Nzg4QXNPNWR0M21kaFdLSUYzc2hzSy95aSs0VUMrZnQraVpmOFZ6MmlYaUl3?=
 =?utf-8?B?eGwrZXFVdDFTM0pZZnZEL3hFWlF1R2huaXhIRWNTQXpvcWVxZmZpbDNpMUk0?=
 =?utf-8?B?NHo3YUttTnFqOXBVSEw0bndiN0NtNWJVMTZqaDhEdUd0RTkxL2hpcy9KUEk2?=
 =?utf-8?B?Y1luUDh6NFhOT1A4ZWI0VEx3VlZOWEVHZC90eG9ZZkFKRzB6eHB3NCtVU0Jz?=
 =?utf-8?B?YlFPK1ROYjVtRWpoc2l5bkdpNFp2K2l2SkxhYlF1YnNlY1RUZUtaU3hxdm52?=
 =?utf-8?B?UnZ5VEs3YU1hOXMzU1RhVFdsMWtmbkVqOGJ3YmpNR01hT1dIRW5QOFp1VlVj?=
 =?utf-8?Q?21yigm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:00:26.8285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc0204c-dfc4-447e-bdc3-08ddd8bde59a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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

