Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDFDCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C1C10E5A4;
	Tue, 26 Aug 2025 01:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZQHrqd6K";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F3710E5A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvHEjYEU7uppJcFQdcKe35P3BAmm2kQta1ZojEb54oFI078qxTPQYUHeru7bnrAe9WWeNuqeQ/0ozxm7mLopGvv8vwzoX0Nnv3FjUpmU6XS/SZRxUWOxfqMifmz6M0xw1OlMyiG7Zz/b70x6bpaRztIixrQZ9CrU+YWWr74U9Y3lWNGVPXBExkpg+u4q34O6x6RS1ZQDhsEOH5wWZSYYsXTpBuCNCKnN066YbJ66MqQiB7pSvAwkF7U7p1tMUUtnwNBb2+BlNfFmXQ6P2iYXUDRwgcXoOowwNrd2DvQc4NFmMK4tcyWPq7uLYEfx6r8cYUgHvHUtqydLMvJ4+ZELXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=WU7Tk4PqJ3QLfxEufTstHofd9tNmppnDLc46/m02ShKXwYnIYh0mhTMTLgFFBxAVQCSAF0xEkGP5B4+NBnZUKL//d0w6wDNfD7M7tjERBEgRpNNWiyn/eK+w85iR7Ls4UIC4DM24Z1xK0wEr7tygiOLQtohXdWwQUcziVrLI8Y2kLumA9fuJZzLQOyBDbnnOvlOgOvJMSF3844jpyo1STMuzCa6JWBGoD2z1uERunOsiRKQsbXUEpv6r/cAm14Zf5lLjPR87Nw+YP/3IIJdjIte7X35MQQaIbhHVilbRfdjBKveaFhkcYqJtP3hUfLYfVYQDz7ECeZRHT0QQWpjT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=ZQHrqd6KZVII1YGF0Y/SC5sVDYYCzQM514Ct6oom2yupXPP/clKQ/qljPbjAvJt5upghhuosgfE6IoSv5IGNRZC4zzslmTj0HhhtpNZLM0osIF3qUhj9Cg1eFCfk8K4idaPd+zLBbwaWbKHi5QGqClgie8gMC+t8XQqlBS0XeB4=
Received: from CH0PR03CA0340.namprd03.prod.outlook.com (2603:10b6:610:11a::28)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 01:47:42 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::d2) by CH0PR03CA0340.outlook.office365.com
 (2603:10b6:610:11a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 01:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:47:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:41 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:47:34 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [v12 07/11] drm/amdgpu: add user queue reset source
Date: Tue, 26 Aug 2025 09:42:17 +0800
Message-ID: <20250826014648.1711926-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cda8d74-1d86-49c8-8b2b-08dde4428bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEkzTTVKNlN1TjlhdFdWME1RSmIxaHI1UUpvKytRS2h6MDFnZ0MyYzFFN1FM?=
 =?utf-8?B?U2M5b3BoYkg0MHEwNnF0Y2JxOUxWZkRySGJ3ZFg3eEJjZzVETTU5VlZHYmpO?=
 =?utf-8?B?NVNJN2tYb1Jwb0F6TjlGZ3FYT3Y3SkQrVEFWd3NwOG8renlNTXV4bGNzMkQz?=
 =?utf-8?B?QTlwaGN4bTRNMWQycVRzKzJyeU9DZ1Q0ODRYdlV3bllkeEptaXZ6T1NPODVj?=
 =?utf-8?B?dkR2cllSWWFza1p0Sm1JcmlvWjR0aG9hemUxaHVnUnlUbXBrMTVLbWJiMDRY?=
 =?utf-8?B?SHZ5NzBJUG9INlFuRi9zNmNPa1B0Y0FxeVJlSEh1TE1aL2NCbDRmbjdla2Rw?=
 =?utf-8?B?aEw5V0RZMWtSVEYzUjNRVEw4TDFTalF2NmR3NlVKSGJmNWpLQkY0N3pjR3Fp?=
 =?utf-8?B?cGpFdUJ0d24rVTFhNmpQcnZTNmlxQXlyZUZJTUZ5bnhIenpTZEtYcnpqZTlo?=
 =?utf-8?B?SlQ0U05TRTlza3ZBcDdqd240elRJNGRnUXJnYkVSMkphOTNBNEZiM0lTS0pt?=
 =?utf-8?B?WXpBUzlqajVYajY3aUYxN2RzdC9JaXIreDZSeGVRalhaaVU3OGUzNXZWT2Zl?=
 =?utf-8?B?ZGJXWkFUS3E2UXhpU3puZDhEREJBdDZOWWJQNnZHYzBoYVVKUjJQbnFUam83?=
 =?utf-8?B?ZFk0bE9VaXF0QjJBT3VwcFg5Vlk2ZlFMQVJha0hFcGhCTVcyVWJRTDR5MW5D?=
 =?utf-8?B?d242cTlIZVRRcmNWNEwwQXVKcDk3S3VCYkNUSUk1bnBqNTNKYlpCZzdKamw1?=
 =?utf-8?B?aFNmUkxOOFdUajRFM09VSkdWN3NuSFd4VjBodWQyZnFacUVnVnhWVTg1bGd3?=
 =?utf-8?B?cEovKzFGdWg3UllObEtUSkY0YXZnUkpVbytqMGVEbzZ2KzkzemNkN2srdVBW?=
 =?utf-8?B?NnRYS2d4QWdlaFVVUGltQjdpOFBoM3Z5N3RQNjkrb2dmUndjTGdnSVMvL0E1?=
 =?utf-8?B?SGN6NjR5cGlHK2kydUV6ZldoNjRxT0ZYVnB2enNreVR6M3AxMUtWNldCMzMx?=
 =?utf-8?B?Q1RwbWZXdGNKelpzVTVvL0EvVUh2Wmkybm5Yc3IvLzdXVUZkcFVrSUFnNGRS?=
 =?utf-8?B?dlMvR09heWlEdlJFMENjZFc0QVRURnV3K1NHUUxwa29Fc3VoWXozdlBwcERR?=
 =?utf-8?B?eWY4MXhlZUJkaW8yVUlXS0tJY0FwQ0JBcmdLNnNzRFV6TW5ZVDJXQ1lNakt6?=
 =?utf-8?B?ZysreGpZNUNUV3RHV0h5RUxDZmJVYzRIQUtjbHp0cXZUVUZCOGdsRGR2bjZm?=
 =?utf-8?B?V0NvZEZvUTN4R0lLVE5mZnB4dWsvSGVmdERJL1plNEdHRjFPWUVUNXYxMGND?=
 =?utf-8?B?OGM1YzhTS1J1Rm9wWjhSRWRvMC8vRmxSbTZ1TERPUGFTT1FBdGxYTVAybFpC?=
 =?utf-8?B?dWZTUmV4OTNHbW83blNZTytPVzJXcTdia09iaEpZR3Q0OWtmOVorY0s2VDBo?=
 =?utf-8?B?YWdKMERTOEJrcnJpMUVHNmh3Zzl1MGM4VHg3MkZJektHc2svVTY4dm16dHNV?=
 =?utf-8?B?dTd6bXhTK0tDTm16eG93MFJlbG42dDJiNmtHaW5yV2JiSk95Sm5SRDZibjhL?=
 =?utf-8?B?ZU9IeXpCUjdka09FR1M1T1Vqcy8rSWdtelNOdkZHYzYyVDBDZGlnQ0RJWHNI?=
 =?utf-8?B?Z3lQdXN0N2F1TUhGMDdJNDNLL05PSWRnOEJEZlF3cDRxaEtwVWJIZTVyaUNJ?=
 =?utf-8?B?dzJOWEhFSUh5WGtqTnBIK2Z0bnAxNHFETWRkNVdrT0RFVTNqY3lNdEo2ODIv?=
 =?utf-8?B?WHdJTGZIUlhYbC9oRmNNK3FERGFCMmViWVI5ZVQvaVZWa0NlSkpaMmFJR0Q1?=
 =?utf-8?B?ZXIxTUN4MC9GYy9xNFNXMS9ZMU1QYXlsbTd5Z0ZwaTBtdTV4YStjU3RneDVX?=
 =?utf-8?B?a0NqQ3RieWhCWFZLM3hIR29kdVJ1UFFkRGlaZWFYTmpVNElnMU1rYkZkenZ0?=
 =?utf-8?B?N2I2a3BlSmxuQ3RMc25lbVFVWEdmcHNhMW5SSDliVjFoaHNacGQ5RCtkZVhr?=
 =?utf-8?B?blRuamNHS1ZFUmRmSzUwWHFRWjA2cjU4VUowbHlaM0hRTWFtTlJ1aDF6UjZp?=
 =?utf-8?Q?8aF3FL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:47:42.0403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cda8d74-1d86-49c8-8b2b-08dde4428bd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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

