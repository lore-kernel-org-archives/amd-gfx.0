Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C206CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50D010E948;
	Thu, 28 Aug 2025 09:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DCBtR1cV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3DE10E946
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeC1krrsCpIewmNx/DiSF69knB+HrVR5GaLgtMc0+c8tJq7S+SuZlhVCWu48wqM6yP1EPdeepcKLWqhxt41kJg9e92tc4a8tqKPfoY8nzzejxEVudlyQ70EL7hjbc7aWVeggFzUHnjsd/CjTjTLIGpDYkC2zRnPaW3kJ7nCXHg3457deo7Em1kUQU5bVL7WBIulwAjaTtyOrVg35fVKFVOWZ0glRo2MrBzZ/JyRsSaNNR1pwVmOporvAoJVNCIg53R1H+SmMIbZ7vMCFe5M9k9ljeSNWHMbIhsg8aFt2zfpNdU+dsftwqfTHAuQ6ij5fE7Kc934kxx0MqBUe+tAneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=t4RbNpiHoCH5JjDlF52UACRqiYOc0pygbOrUdD+vC5YLeWDQ4BMSKPcQqLCPJ/pmIOg0O6aOuD/8FAdnWQjD8hlWyK9xA8UqzxQd6qV8p2U+oYwsQVWYYdNMxqTE6JhG2/wlI6ncll+DJrs6xF/qZ2gPGe6MbHnhYX9E8y55yQI9B9XVw8VfeMnbxLw1o3WY8BtKxFNCdy9qp60jUcCHkbCx+GYkPH1llTmli9yG/pnB7boGfRpPcsUkaLojNzGMgWsX93L3ocvdgoNbFrn2WmNFhnkO/oMRW1/aOGqv0s8dtwTy0z91QL+odNLWqCZydbNK6n5ZRiLGgF5iUiX0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=DCBtR1cVxqlc6AXSVUpdk9iMXWLcCCrZ+Gl95wJZbDLLtQ/c+90yAT13HCI8sW9uGxYrwc8m38QW2jHLjyGRRXN+zjX5fj1Om/6dMBu6stAN3x24P5S0bCkOpOrmy767YTeJUztWxi0MK/CqNz7GU+qdITOBo9yVLucvb36E4eI=
Received: from MN0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:52c::31)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 09:24:45 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::4f) by MN0PR05CA0006.outlook.office365.com
 (2603:10b6:208:52c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.8 via Frontend Transport; Thu,
 28 Aug 2025 09:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:24:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 01:45:44 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:45:38 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [v12 07/11] drm/amdgpu: add user queue reset source
Date: Thu, 28 Aug 2025 16:42:13 +0800
Message-ID: <20250828084457.1999535-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f21a11-b611-4e91-73fa-08dde614b9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2hlYWkrZlBkZTNBYlgvelV2SzAxTkcvbWk3dGhIWnVkREpxMkFaRWhMbnQ0?=
 =?utf-8?B?V2tFVk51c1FpRlY5ck5Tb2MvTWxmeXZIRjhuV25PNXlYeVN4Rk0wVjlvWTJ3?=
 =?utf-8?B?UVUrM0o0QTdlNk9lUkhoTUQxdGQ1a2pjRCtBNXJCUTAxUHROaUxzVzYweXdQ?=
 =?utf-8?B?ZmRjK3RQWkI1Q0pUVzRLWmxlMDJLUW9wNGtiM2NNUlRVYlZHNmI5eDVDL21J?=
 =?utf-8?B?Z29ENllhVGFaNXR0eHFFUnNHUmIreEd4c1lOaHNUN0NWcjdyNVROVFVXVXcv?=
 =?utf-8?B?QVJ4T1l3NmdmcVN1aWVIUkV6aFdPLzFxQlA4bktyTmRVUjAvZ3lRanR5dEkx?=
 =?utf-8?B?cloxWFVXc1R0cFJXd0M3WWM5WUg3QjNyeEhORnBhVjNjRnpxV3NpaThaTHpL?=
 =?utf-8?B?V0tKU29CSE5jVnNueDNNL3piL05TZnQ4dHlEZmZab0p6UWFmSUZWcjlYRDE0?=
 =?utf-8?B?d2dFR3BFTmZFbGlDZjBkdmhiNlpETnFJVkNCZWhlMWFxa1Zwc09xVkVyN1Bm?=
 =?utf-8?B?KzJ2RzJIWGdjZGFYbHZuWXI2amhMZU94VFFndlVhQWxHaFBmVkVGWnZ4WERp?=
 =?utf-8?B?N1grelN6UVNTRVNlSzc3Nzd3bEUyK2N0cUxFbEtxZG9qS1hpWCt4aGUvZ2xW?=
 =?utf-8?B?UG1EeEVSTVF2dWpKUDFFUVF2ODY2aE5zRHhzaXF4S2dLanlVYnRpUjUzMDlj?=
 =?utf-8?B?dndFbWpwM2lCYUJoTkdjc0lpRElKZWpNL0Q1VzFxbFk2eTU0cXVEQmtJcXN0?=
 =?utf-8?B?NVhpNUc5dDVJY0dLNk5FL3Z0L004NFBTbm82UnVhbU5KbFgrcEdWMEdwYzE1?=
 =?utf-8?B?YWozWUZBNDJjRHpDa1FQOGZsQmhMZEkrWG54TW9QNWxFd1lzeXF0bnNnNkx4?=
 =?utf-8?B?NTUyVEI5RHVFNGN2WGU5MjVmMkJUUDFuUlhzcHBSUlZHTVlFS2JhSHMwSFJ4?=
 =?utf-8?B?Q3UvQWdidFN1R1BhS2xVaG81a1ZEeERoaDl6dE9WUzA1aDkwOWtQWlVmMGJ4?=
 =?utf-8?B?OHkrK2JzWWVHczR0RzEwa1V0VEdzc2ZwWmJFMVhRS2h5Z0ZUK24wZHBGd2ZX?=
 =?utf-8?B?WDY2Qkp2cjYrV2VGdEdXVjRaZGNzZFQ4SVNnbzZvK2J4UnFKQTRpakk5R2hw?=
 =?utf-8?B?U1VNOWMrWDZPTkplTjJIU2lLRkt1UUM2MDRVZWxlTlduVXlmQ0VrWk90SWpP?=
 =?utf-8?B?c1ZYNGFybkF2VGtZczNLZFFoaEZhQ1Bjc2FqNlQ1a2V5ejZYUkVhRFNJdUlr?=
 =?utf-8?B?enVLbGgreXdiK0NSbkxNMDl1YldYU1FZamx1TUh0Vmt0aG1GUVN6OEZSdko4?=
 =?utf-8?B?T3FzMjN6ZjZ5dE1yQjVWMWhJemZ1UUU1NDFhc2lLNlZkbDBJc2pDRkc0Lyt4?=
 =?utf-8?B?ZlhmenNPcWlFOWlERUwyM0pmeHlnVE1iT3FzVVBPQUt5WmZPVE5vWnhSY1pz?=
 =?utf-8?B?NUFhSWlqejIrcUNDa0RUS3JGZG1IaGRtUDF3ZE9JUTR3UnlIclZoNDBqOTVD?=
 =?utf-8?B?MGVXRjlCMDM4ZHo4cVU5RkZ6eWlPUWd4L1VRVVpvTEJ4eGQ1NUxKdkQ2QXNk?=
 =?utf-8?B?RHNhWmt0UmZzVmQvVTlaN09Eeld3Sm10VlQrSVFGWkNOclhQbWZtV1JYV25E?=
 =?utf-8?B?eFQrcHNlMjZXNHAvQ0VzelJwbXNWSmlIQnorUGlPSlRQclVtdEhjZFhPQXA5?=
 =?utf-8?B?VVVrY1FpeUtONWVTQmpRNEJrU0xaUVgyQnBGb0pBT21IYm8rLy9EOTM0MkFw?=
 =?utf-8?B?elkwNWNkY2dlL0dTVjRSeE5DOUJpblNFbTBSd3I2emZLYjFnSUJoN2RadTNF?=
 =?utf-8?B?eGNxTXBHbi9tbStPOEovQlk0NjdyZTZXSlFLZDBLd1FWTmxqU3VYemdSSWx4?=
 =?utf-8?B?ZTVWRlpiZWd2VWlyY3daNjZGczNjR3JoM0k2U1A3RGdPQ01TNGp6V2pmbjNU?=
 =?utf-8?B?Wkd4RHBpdWk5UEc5TlVqS08wQklnZjRqY1JjR3ljTi9QUG14WTc3Rmlab1Bx?=
 =?utf-8?B?NktENjIvejBnU08vc2NDdFVzRHJxcE8wWjhjeUR3cGRwNHNsRXhLd1R6bUFr?=
 =?utf-8?Q?iz4qAk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:24:44.7343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f21a11-b611-4e91-73fa-08dde614b9d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664
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

