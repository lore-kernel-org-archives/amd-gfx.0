Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CA0C19F4F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A715B112415;
	Fri, 26 Apr 2024 13:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WGs5d+PE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04005112415
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAxNVJ4PGoMUg7DOJFMW+r2oHV/aaedSU+j4fUzgqQA8jDAFRezxLvbx67HocLKPoCiGCOz9n+pnAaCQBoE0zotpj2EmxXmVU6yaGF/lmlSo0bgaf8kMkSIFrS3QXHYkn1/hUckqgoD+LuNmJfjvefS+c2YjYoqBSvxNJ4lJ5dd5pE3rtkEF19bflzAekgmplLENnkIA1dHkaOqX/7IWlEqeASCxg1I5iZWUPAcgY7mcpW7qSVrFa6UcaCEPWVsneyGrCWyDAo815Fk2bZ0BRFtsbu26WpjnjPaYbf4QWnRDcafIb+kpAGNSCbHxdhLhbNHe+lETtXXqb/M72jdNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VwIcfmhi+MHl1bpIwBtBnDjpjCVMMC5fYzL2U0GqVQ=;
 b=KefPp42CmfWlhxhE2alRsOOARDex3F0+V0YUsbeRqg055Znwy8osWTzVrFMnmBnAyT32bvJ+jnJtqurP6QUeo3bKvKxJQ+X32t6hZTrfeMLb3wVC149nDhVwsVi+SHJHr6qE4Qdw6jxcyKltqWL4Dv6NbEGpgCfffgS2mn0FlHAhMFRfM7HPrSH0A1L9FU6CfO4J9gWauDnji1ofaNs5vhzRBoyW7AhWLrF9e9EJRf3ZnYJm5yBPNF27X4DL24ovIB2PwLOo0H1+k2yv7lDJESGR7gEF4kTELc3pVv4o0L/RmSdphx12Q3RqiLhl7Mb0XLkvJJv56LwyCqhM2lXGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VwIcfmhi+MHl1bpIwBtBnDjpjCVMMC5fYzL2U0GqVQ=;
 b=WGs5d+PEzRcFyHuGb6FS4PVLQaztN2Jvu5u8aIehlkCp3iyn1WdxJwEgJumysX3mMmsWCbFOkkStKdZq5rEkn9Hdh1g5LRZ18k5kgWewB9GIePFIbGQIFahdYgPexlTC8aX0iHuHIneq1JoRzFHfsKEtc0KuV0TgpjUJK21sBOo=
Received: from CH0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:610:32::15)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:48:57 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::72) by CH0PR07CA0010.outlook.office365.com
 (2603:10b6:610:32::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:56 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:54 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <Christian.Koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 12/14] drm/amdgpu: enable SDMA usermode queues
Date: Fri, 26 Apr 2024 15:48:08 +0200
Message-ID: <20240426134810.1250-13-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fae70b-766e-4dd4-6967-08dc65f79e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVdYZDloeFUxd2hPRk9iN0p6WWV1dHh2UFNKMytsOEFKcys0a0Y3NFNJZERZ?=
 =?utf-8?B?NHBSMWswbkZLWWpZd1VqZHpWZWVpMzFqQjdpU2NqcCtBdmpQOXVYTFRiZ2g5?=
 =?utf-8?B?WFVGQWFiVndtNG0vMzJGUVF2N2pqclUwKzRlVUVIalpHeS90aElNdUlYVDRP?=
 =?utf-8?B?YnZ3OXBKRzNMVjhJVjMxaTJTMlJGM1JlL0luNWVTbzB5NEo5QUlJakdtQkJB?=
 =?utf-8?B?TTJLeEV0LzFXMjRwc0FrR2xscjNBOGcrSzZsb2tTYlVnT3JodURmWGtVZ2tH?=
 =?utf-8?B?WVNJT1FkdGFiMytZWW83bFNyR1EzbFQrYUVOSXlUeGFKQW9sYmJWZjRCQ2dZ?=
 =?utf-8?B?bkFaakxTcldlMUFwMDhYdjVYZFNyYmdWODVEWmJsdlZZbHQ2dUZvRzh6MnUy?=
 =?utf-8?B?bEJ3K0ZWbkZZSDFweFA5dE9tYU9ZSkNZTmdKdVZERXNKSDRzM2crZGxlWVBM?=
 =?utf-8?B?VHBrdThxWlltR01ZaDZKTHVTT2RPWTk4RWVxcGlCbzRFL0svTkttTzNVbmtT?=
 =?utf-8?B?akNFUHRCeG1DdW1ia1RNalFQUDdzeTJZZ0VoemZJdGk4eW5PemlQQmxYY2JW?=
 =?utf-8?B?MHgrOWw1UlBIZ0wydzNNYjk2OE5vQkxYYkJiVlNQSmdpRFYyNStXZjR6SitS?=
 =?utf-8?B?SVdKbGl5VEhMeGVLMlIvNEY0bjIvSktQYmprZi93SnJoaEp6dXpWUi9xZDVk?=
 =?utf-8?B?blZJUWVCYS9LVXFBM1NTQmQrdTRMUWQyb0dUMVFBNUkwNFkxdURFdmxvVVlk?=
 =?utf-8?B?NGNSaURTY1BESGh2YnF4QzBUaEZuelNtaE83RFRCbyszS282RXJhd1Z5YllP?=
 =?utf-8?B?NjBXaHVhbVhCc0l6b3N4bW1sK282SkZweDU2RTVQNGoyNmUrR3FPSnd6SElN?=
 =?utf-8?B?TXpPd1E5c3ZGYjZzK0dYOTdSQnlGWVJqam5mbGFyUjdUSnV4NEZWRTRyMGlM?=
 =?utf-8?B?ZXZleTVJS2k0V0ExblRXUmJlTnptZzNuQSt1bTdmRmpCOU1KVURTb2ZRQkly?=
 =?utf-8?B?SVNtL1ZuaWlZR2NjWXFlWEJhZklpWmZ2UHQ0QnpBUHljRmVKcmNjZ05OL3Zw?=
 =?utf-8?B?dzc0Ulo0TW5DQzRFSnN4K0Z5UkIwZE1JWFluZ0NXUVFhWDNGZ1RscE01Uitp?=
 =?utf-8?B?aU1nVm5FcGMxUzRZRjA2bW9ML25HZWtpUVFTeWJqT29GdEV5Rlc3MWRFY2wv?=
 =?utf-8?B?cmJUSDBtdUJqY0hLL0g2YXlSRUErY0txREd5QzlBWFhHUkhzU01VVWRCS3BE?=
 =?utf-8?B?Qk12NVhlemZMLzF3M3lmYU9DUEtqY0toUkJSZGFjRTNDV1UyZjBiVytvNmY2?=
 =?utf-8?B?QUxEalNJVEVBUHhxZGdGdFJUVGJLaURlcGFEZkhjamRBOE5RRThQSk9acjBm?=
 =?utf-8?B?S2FsejhtczFGZGRZVjl2RGxDQWgxekZHaEUzUHU4d3NoYmZ6bVV1YnRhQktL?=
 =?utf-8?B?VVBYU3pkcmRvZm10UVh2TGltY2hlUzR5VFBhcGJFSVlvYmEwaWE2S3AyWHVL?=
 =?utf-8?B?WGJNU3hEVnVLc1NuYmJBYm1pKy9qUjF5ZldTR0o2NzEzdEllbTdHWE1DNTZQ?=
 =?utf-8?B?OHZHQ041eDROYzVHMm5CRThqYlRiNlJQMVBQNlBSRTlLUjVRNnJkRlVqNmEv?=
 =?utf-8?B?bXFmL0pEaDZMQWk3Y29MTTBIMTlnVWRVN29nVW5vRzd6OHl5VG1ndkdNYU5S?=
 =?utf-8?B?V3MreXpQVkVHOHFmZHBtSm4vcE1wcnpwd2tVOWFQMWNaeFVueUo3UGNaN3dH?=
 =?utf-8?B?elVUdDE0YTZZbGhvTDdQOElQeEplMWRYSjBsdlhSdW5CNzRmZmpYdmNvUVBh?=
 =?utf-8?B?RmJTdkw4ZWNpdDZUd2xRZTRRQmlhbEM4eWdXVkY2RHR5MU8ydXBvbmJKU1h0?=
 =?utf-8?Q?rwSl15ysV9mrO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:56.5099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fae70b-766e-4dd4-6967-08dc65f79e97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
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

This patch does necessary modifications to enable the SDMA
usermode queues using the existing userqueue infrastructure.

V9: introduced this patch in the series

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c           | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 781283753804..e516487e8db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -189,7 +189,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	int qid, r = 0;
 
 	/* Usermode queues are only supported for GFX/SDMA engines as of now */
-	if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
+	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
 		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index a6c3037d2d1f..a5e270eda37b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -182,6 +182,10 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 		return r;
 	}
 
+	/* We don't need to set other FW objects for SDMA queues */
+	if (queue->queue_type == AMDGPU_HW_IP_DMA)
+		return 0;
+
 	/* Shadow and GDS objects come directly from userspace */
 	mqd->shadow_base_lo = mqd_user->shadow_va & 0xFFFFFFFC;
 	mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 361835a61f2e..90354a70c807 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1225,6 +1225,8 @@ static int sdma_v6_0_early_init(void *handle)
 	return 0;
 }
 
+extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
+
 static int sdma_v6_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
@@ -1265,6 +1267,7 @@ static int sdma_v6_0_sw_init(void *handle)
 		return -EINVAL;
 	}
 
+	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
 	return r;
 }
 
-- 
2.43.2

