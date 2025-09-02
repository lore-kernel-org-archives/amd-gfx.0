Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43191CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E476510E5CD;
	Tue,  2 Sep 2025 08:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n3R7qe2M";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEA410E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K27bACIICHKOxErrMtzZKLv+3iJRGOHHOnE3vle9P0eQ7OO906VPWMpWr8IP67z/w+nn/aquwqKLAKhEmD3CaYy3+F+1ySIxufIYJ4M9AmRcdX0p9iqtEzRbqhICBEHrQqvudRyxlJ3BEQlqcWnaDTVeTJ8k3giIlSeN/4Xsjq45uSaqUSSq3Kbblt/1lX6QJwl5zXw2LzqAnrS1FkKuvjc9IJIJrXUwo70NCfdH8NjQwb5J/zNcn2svMySKdT8/V0SBsd+bw1z0AdoFCJNt4b6HmDI7ziyyuZTCsnGzGPSH/v+w4DdFMABAVLkO+01cWL6lvJ2EjOdlHHCDTWwR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=pLUu2TGUZsfXFucWvDfXZw4Ip2qrCfAs6lFF7WlnHQNIvgPYbdvEtUGpH+jT6h0omEmgwTyZFoGWU7fAV5kNBKP/AmcKrnhqA0Ur1sEv+V9M8qB1w1EcEXH57v1CZGUSARM6PDoS6aJcsI4kCQJOipufxI9PZ2XdqlLzWU3yVES/KDOiF5e73j6MQqvYVNet1+YUqzAFyiZ1MQhB0P8NP7D2iBgP1+fvDDIPY4SzYojHzsOQxT/L5pqkEK9g5816f9vMLY0H5jBCe3Zi5quJqGuKxSXEV9Fagh0orlBo6neYm2X8LnoXeEqATcgAFee/C6UTjQqXZ2SLM/G+UFB8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=n3R7qe2M3C61/1Xa9DARXHKLfBGzFk0IkXYC63sjxyR5O6D7ykj/eecopyA3I+oCCWEjjL7pEcioJETFIrz+8x8e02uMXvhO5Vl0fKkbQ9gf6tn4ocTjKgbe7S/pqTmQqfZG7z19L5h88WqEahW9j7dypHCkMuAx50mVfAoL12Q=
Received: from BN9PR03CA0402.namprd03.prod.outlook.com (2603:10b6:408:111::17)
 by CH8PR12MB9816.namprd12.prod.outlook.com (2603:10b6:610:262::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:08:04 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::e7) by BN9PR03CA0402.outlook.office365.com
 (2603:10b6:408:111::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 08:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:08:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:08:00 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:07:54 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [v13 07/11] drm/amdgpu: add user queue reset source
Date: Tue, 2 Sep 2025 16:04:08 +0800
Message-ID: <20250902080712.2515811-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CH8PR12MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: f1096ad9-3739-4373-2c9c-08dde9f7d75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEF0ck1hL3ZIbi9xTzBJNkcxWWtBbkMyTEZQMjZuSldWRVJ6bGlyeGozVGc1?=
 =?utf-8?B?ZFBZbHRRejJ5K3pUdEZSTGlrUmlGNFM5eVlZUXRlc2RuZWczMmlWb2diSW12?=
 =?utf-8?B?T1VCQ2YrMVFSM1Y4aDA1WktaUXh6VGc2ZlNZbUdrcEFwSG43am9LQkJ3Ujlp?=
 =?utf-8?B?eHg3NGptdXF2aDBCMGVJaTN0ZmFiNTZjYmI0THlJQ01aOXpzSEZYU3pBNGZh?=
 =?utf-8?B?UVVzTktLdmJrVEhtL2E1SG8yVXNnVnNLUXZDM3FxRnYzdjBpMWIrMnpVTTNE?=
 =?utf-8?B?NjVIc01QQnNOb1I0M2xUN0RaUTJkOEdNdDlJRktHNHNOUm9XWlFEMmFUb2NH?=
 =?utf-8?B?SVlUSVVXWWs3bU8wd0xvR0hnNVMrajRhL3VtcFJ6MmN6amdlVmhUNTcxM0cz?=
 =?utf-8?B?QXQxVDFKSm8wM2JqMTVFM2NuVTVqS0FwNzRkQkhDWHhucVdnV0wxcnRzTXRq?=
 =?utf-8?B?MjBoNzU1My9qTCtyVWZtVG1sRkxUMWxSNmozUHpMT3ZCWEV1cTFscFpTL0Js?=
 =?utf-8?B?RmFtUVBaQ3p6Q0s1cWt6RWNUNlBobCtpWng3MTJkZldDT29xNkhGUTNKazVi?=
 =?utf-8?B?Q2U4UFhoaENzaktkKzg3WHBiVlBmL21YcUR6Q2NVRFEyNjlRUEZTdEtNUXRs?=
 =?utf-8?B?MklYZ0tENE9VbkRmbTZ1V1VMdnhtaTZRVnRrK3h6ZVE4Q0NaU0VsN0FBMHJL?=
 =?utf-8?B?SEtCRDB3SVlxbUxnMHBLcU1xVkVmRnpnME1PNTVVTXk5U0EyUTJHS0Y1dWFk?=
 =?utf-8?B?bGU3amMvRERiTGV6NjVXOTVPRkJVdGt0M1pzS1lEMWszTnlzeGYwd0F5bzV3?=
 =?utf-8?B?OUkzS3RCcDM4UmZrQnJ4aTFzbzBYY2VhWTZqZVR1dmFTTis0WGZNZEMyOW9n?=
 =?utf-8?B?dmhmdXowRzRCcnlOdlE2eDFSNkdxaWE2U29pZWMvUWplQkM5dHZGMW1BZmRa?=
 =?utf-8?B?VjhUczlkdkdEZ2lwRWxBRktLa1VMOXc5by9BalN2b2lXdEhYRXgvMW9yL3VG?=
 =?utf-8?B?dkFKZmV6Y2NJbGV5b3AyT2tyOFVhdkpRN0pvMHlWODJmNGl5aTlaQklNeTNQ?=
 =?utf-8?B?aFFxNDduZ3JmN2duQS8rWDVmUVV5K0VGWUdITHRDQTdZUnpRNDlWVXlsSlFM?=
 =?utf-8?B?em5jbGpueGs5eE9DdkFWaXl1Q1ZyTnB0NlpsRGF3S01USVhwbFdpYmxhdFV6?=
 =?utf-8?B?ZCtQenpraENpamVYby9ObXZHb015V2M0Z3F1QzJSQm5YVnJ2eC9CamNWczNE?=
 =?utf-8?B?bUdtWkQ5bzlUVGk2Z3BEbWlBUzZwUzhMV1g4WHYyRENSa0s2aFNWOHc4QjBw?=
 =?utf-8?B?YUdXVmZCZXJOU0VoM3hLd0ZuNXZLQ3kxT1BUb2pYN3R1cmd3NDEyRWR6dWxB?=
 =?utf-8?B?YTQ3dWEvSlJNUFVjU0pIeUFFWFNMTnkyajBGbHdVSFFvUUI4OUI0V2RGb1lj?=
 =?utf-8?B?WE5lZTBOVUFhT1EzYVNnejZid0pYZnNnZVIvNHpSd2QvMDY2alJEYkY2VW44?=
 =?utf-8?B?b1BnY2xDWUZTNVpHMlUzbDluVy8zeHJlMlNOVENjODJ1V3BuWHlsRFp0ZVNj?=
 =?utf-8?B?YmE1NTc0emo4d1Y3bFpYS3JyK2FIODg4cWxITzRvOWVod1hHMFNpamp1NFk4?=
 =?utf-8?B?bGRWbnFnTGc3MzJVL3I3b2l2N0NTTHNwNnJLRUduVmpVZ1AxMjlxQi9TZE93?=
 =?utf-8?B?d2p1dUJhYUZEdlZCLzUyN3dtVGxKRHNpSEU0TC9YcDBHUTQ5UktBeS9JSitK?=
 =?utf-8?B?d2tpREsrYXozMTVBWWszdlZuZUgySTAzUkdtNUFEd2NYc2M1RlBqaVEwcGM3?=
 =?utf-8?B?cTh0SUlxY3RLMlE2NnpBVGNsNWEvaTVqQ3RqcFZpTG9COGJMbVhGb1Uvd00z?=
 =?utf-8?B?VE9WS0sxOHRQV2xodmpaejYzUFpaaGF0amNsS3NiWkQzcE1seHF4MHBkVlNr?=
 =?utf-8?B?VnhvSi9PZlZkNFp1RmJrUmpPSHdHU0RPZzJnV2FKVEJjOTRWbjA4Q1AzVWU1?=
 =?utf-8?B?WFVrcG9KWVBUbXJnWEV3ZjBRblFmNXp6QjBhamRNY0VZdWRmZzFjZmtWRUVj?=
 =?utf-8?Q?VH0Ool?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:03.5314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1096ad9-3739-4373-2c9c-08dde9f7d75b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816
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

