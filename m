Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD469C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203B910E5DA;
	Mon, 31 Aug 2026 05:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xGfNwZm/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6976610E5D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8N47DjPSZBZF8lAz1SFkSZh1TdSJQp4C5SpWq1Xr4f0+3V4qU2KYcznYQMSdaWZvU/eEahEynHN9+mJLhcPlvMFsro/fNE67/gb/f4ASRsYyb0S3EyYAvKMntWc9dtN5jEJNWEnG+5u9C6g7mKKGBh7FZKT8ZtbzU2ll4WsIeKobW/Mghyg+4X5oFanEbbAZSuoviNiyyNjc/oHjncIDkssoffw2bVdaT3Die8qS9ul/yRwwnvgegASoh/os0qboZjHHygzFPo3fNLdjVlXF9De5Ua62QkGiBxdZ4dwVR/kCnxDggWdqRhqeKfW0vSITYz+5ZZHfxd/KqkzZMRSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u29Ru/0lPnymrjZ3OrsmOcstlXbpqqz3WxsZgEXudgc=;
 b=XFlPVKUGNnG4y4gUbtRMZCdyvIWMMnwxVhJTSAoTBPNXGQZpQqjMxmKBU53OSaOuk32w+q5QQZOctq44cVSc+SAYC06pW6CDTuiKX9CJzRsZJXAOrgJmcw97z22OnK1C4zLgSBHVE85zKq8Y1OPh5BTfviMiWspMokAICmIuxDtpar67B0nmUP7cD8QsMWQb3EMX9y6NEs4xFfJbXjuA6FBUZG8zWttUe4qWQL4fcDZBL5hI6+QaBCM12f2xj5yY1zgDBDbeljtpTWxdBFM4viXpXR9XkVNqZ3pnjoI4FqxACFZm6/VW0FTfSNDFCqyqu9mm+teRc+pgUiWFojk19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u29Ru/0lPnymrjZ3OrsmOcstlXbpqqz3WxsZgEXudgc=;
 b=xGfNwZm/uFkohyqe3UKYJp/z1Acdn9vh5BDrK5AyEWMIWbluREr8pGZitR7LCojkEgStOuRHXUNPsXojX0c+jfie2v/g4V+23DYSwQopv3GL7gCWTDcoi/TLwcpi7AygkNIU47IIXGBQbB+eL6uIuKIc1sIkUVrhzbL9cD5zgp4=
Received: from SJ0PR13CA0211.namprd13.prod.outlook.com (2603:10b6:a03:2c1::6)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:22 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::5b) by SJ0PR13CA0211.outlook.office365.com
 (2603:10b6:a03:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 05:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:20 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:19 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 04/10] drm/amdgpu/gfx12: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 31 Aug 2026 13:24:16 +0800
Message-ID: <20260831052513.1518180-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: b551a973-51e2-4f0d-2393-08df072040c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: wWbobNjFLLcYxexwdfwudaiapV5zDMa4Yj7XzJOtLbxQgW19E6uVpFmc4zISwmUl3pv/NtMtV0Bn/5z19rIf/QOFZdsheOSvWquOMHcr2uPP2GMjAexnz+AUls3INcssSR0JWe5yNkHkzpPhosiMiwb8wVfQRFPg1ruyQBPCxAamRVZiE5r0HJG8sEiNme4nG/W2MUJQ3eJFe+tqbMLe/U3TvUQFZEv1lmyY+RRM/vwmyR+idYCs6n5NDcLo4QeCM8fDGCAOjUJ5kZ7jDjOOMnbWKxmWAyn7IfLg0aq3RIcMuVsNNCtLd5eTA5+YkJGDkuAPqf6Mas5vaWV8Mwii4Q36ms8hIVKaHrzolyGIvwn2Cs8vY4Qry1uLgDhVwi0yftJ5E8v5RFe+LNBLKSQgaXFTdEALYvZhPORIr8hPDz45NNdBBBJMcmtNu2su70aBwn7Trled3npmrChajj7rJgOhg8gC3YwZgOshzmgDllaAalo0BMFlD/8Ms5dvWs39Jd0i+eTAtt9mLQ9n6NZBYx4pL3xnMsJ0/Jp70iHpsAv8ZUjNfh7el0/0H8gLBz8d2TOcVXZ7H1lzdEHNVJNVikAAocynzlwtMjtCW+vdJFxLHrhsyMziYladJNvIUCCxtZRNOuik4OVr+qtSpRfC0r1aZlJXL/6Wks1Zy7PnlWqhIMuEy+ESbvJzNL0h1XPy0CpCkh21+P/dWPfUOgMeNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N2dy/u1cFWoJKbKqX9NRDmzj7xLRzQwudZ/qrdm52cyXN6RmythiYwP/cCWsQdXsRN81jHu8CVEtCvjcbcsSMweqPki63xgSdX3ZdGr26jfAlds/A+OEVpjPl6hLSZ92s5gcnvjkN4xOHLdFEQ4e0YIknSMrXBBXNEHHmUpQSUaIxbaIdgPFLtYUzWMh3RrZSU6GppRqtqDECpp4LHWtOrMB12MR2w+G9L8S1kIqEtsaTN6D68g64KWH3t4O7br+ZtebTIIMHATfQfc/27VZQTjfFJwIiueVFgS7wyIeO+nlVqWP5eZ6OvC0XtJTVmpFoZ4jORcUwiyhbYSjRP9kdzBMYIoGfMJ2vnG6kblJszfxN5u4gksi0zMGSWdxVr5RUm7MmOLaOgh2lBVCRNmvt0qnjG6OVLBSCGB9q1XUpFUKVZXHIkls72eN4YuBToys
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:21.5767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b551a973-51e2-4f0d-2393-08df072040c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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

On a queue MODIFY (prop->modify) the gfx12 GFX and compute init_mqd keep
the context-saved rptr and use prop->user_wptr as the wptr, so a
re-enabled queue resumes at the first un-consumed packet.

v2: rebuild the HQD via init_mqd and save/restore the rptr, matching the
    SDMA update_mqd style, instead of patching individual MQD fields in
    place. Keeps all update_mqd callbacks consistent.
v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate gfx12 update_mqd callback, per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 29 ++++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a434b665d913..86fa31bfdad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3006,9 +3006,14 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	uint32_t tmp;
 	uint32_t rb_bufsz;
 
-	/* set up gfx hqd wptr */
-	mqd->cp_gfx_hqd_wptr = 0;
-	mqd->cp_gfx_hqd_wptr_hi = 0;
+	/* set up gfx hqd wptr - on a MODIFY use the live user wptr */
+	if (prop->modify) {
+		mqd->cp_gfx_hqd_wptr = lower_32_bits(prop->user_wptr);
+		mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(prop->user_wptr);
+	} else {
+		mqd->cp_gfx_hqd_wptr = 0;
+		mqd->cp_gfx_hqd_wptr_hi = 0;
+	}
 
 	/* set the pointer to the MQD */
 	mqd->cp_mqd_base_addr = prop->mqd_gpu_addr & 0xfffffffc;
@@ -3079,8 +3084,9 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 				    DOORBELL_EN, 0);
 	mqd->cp_rb_doorbell_control = tmp;
 
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
+	/* reset read pointer - but on a MODIFY keep the context-saved rptr */
+	if (!prop->modify)
+		mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -3212,10 +3218,15 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	/* disable the queue if it's active */
 	mqd->cp_hqd_dequeue_request = 0;
-	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
-	mqd->cp_hqd_pq_wptr_lo = 0;
-	mqd->cp_hqd_pq_wptr_hi = 0;
+	/* reset read/write pointers - on a MODIFY keep rptr, use live user wptr */
+	if (prop->modify) {
+		mqd->cp_hqd_pq_wptr_lo = lower_32_bits(prop->user_wptr);
+		mqd->cp_hqd_pq_wptr_hi = upper_32_bits(prop->user_wptr);
+	} else {
+		mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
+		mqd->cp_hqd_pq_wptr_lo = 0;
+		mqd->cp_hqd_pq_wptr_hi = 0;
+	}
 
 	/* set the pointer to the MQD */
 	mqd->cp_mqd_base_addr_lo = prop->mqd_gpu_addr & 0xfffffffc;
-- 
2.49.0

