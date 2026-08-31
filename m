Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D6DC624D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B1110EA60;
	Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EylxyJba";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9821110E9FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym0e2kb9nNWLRy6EtT61Inn+HccEoqMUnOaeY0kXpEhKLLSqoe+b9OoX5F1Bajg/2vYIqNeZOB41AGl+AfyVV7yeehQK1LyKqq8hUuGIzVSd2tsJqzHI4uFPWTfUVG4azX6Vyfokgk4i6ZVn9ZyieilQtRzqWMxEZg+tinFZzK3MFXskW2k6wdOyGPiDzJkqziglcJ29BdJQ90/wqXrGh7vpGv7rL5uY0YOBG2aF2dVrNTGKg3rMwUBApEG0rV9aG+ZGbFLQ2PDf8pMwwm+WNnb7Egs6SWTuUKzdSHC8q8hqhGVgFq7jKyShTAtQjIUQsd/wklPojYq9la7Dqf+FiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gosg2bAfUV950zxaKykaWE7eQCKGJl8azVN9noglbE=;
 b=BfBpVoMbLLLgxtZCIUPzKJ7Kr8LZ6kigKZpCaY5PporASTh7qGWnkdh2I/474WGqgSPnRKh+7nwnMAsaE/ot909H+c06fUJtrbkeBNV46PX1eSY2MwerKpjFujNjSrLDuXRwr1JIut2Awh/PjwHtXUSEEnDdPQPWQfaUWhjwODKoC9uPADjBAePlTxp4Vn5lDnMZFGpvuKApzYBNZkyzPJP1sqnlD0mV3vqRJMLZ9Q/5W1WxAnx2/UR1MZfvFsv2swB5pzHn+V6E7AK/mlfgtIkMdoBOxKAlUFnLA6WVwmzjNzqH7MbB1sJor/6U4yqnktnCF3h0F1S+RlcED+YPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gosg2bAfUV950zxaKykaWE7eQCKGJl8azVN9noglbE=;
 b=EylxyJbaNCPayvaBt8g8TkD2ahFQV1YG7ZqPSGLAsIXye3oxWwsUgYxQbPCTY6mArYNbQjv9J/kwRck7k+NlaU00K5JiCYNK9x1KRB/ecM1p3zbQ850Yb5uUhvoqrmMdAwJk1G6EUJ/YV91nbi23m04RDYtvYJsYjY5ZWMi43Rk=
Received: from BN1PR14CA0001.namprd14.prod.outlook.com (2603:10b6:408:e3::6)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Mon, 31 Aug
 2026 18:28:32 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::53) by BN1PR14CA0001.outlook.office365.com
 (2603:10b6:408:e3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/95] drm/amdgpu: Enable/disable NPA address translation
 using PSP
Date: Mon, 31 Aug 2026 14:26:36 -0400
Message-ID: <20260831182754.1089811-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 97955e4e-f82f-4c0f-b9e3-08df078da967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rfyF4njzP8/0P/u1LE8Fd4/HU1KYFwGsYiimIZ5cuHBOB1dMtQMbRsxzgF7vhn0f/ynreLLAMrjrBtTiuc9UuVPRarRbtMzI7BPYfQYuiUoIxXUaM9KHWqn1ZW+BlP+Acw87/nCJaZRPhX51cYTGMoV26ESolh3zOAmwS61xl1d2Pbr3fyxxnmnLNCvK+NFPMlGDe6c+kY++iTJ7B5EJspYcOFsPYHN93BUwTAHWgl6aaKycKstTKG3WPOmwjoYP4rI9V7Ne3BXxxEmYJes2vEfjGuo0HY5OUiXnboCWNznVjDXPAL7ZVUyitmu6YY1g19GtoZKWhIxdc4rHKbZn9ESMRp1GqhUOe8smKuwbfDWiba2oclVPpBQIA68lozl0JmCUi5fc6FeedbPhl1zTDG0/o8ZDAva9sfeXdFynOjazE2ht+tCdAqDlj27LHHJsJvVrxt46Wx0FNB/mIVA4FvHLX0jAQ8xeEUNcE6I8ke95B7+ZQ3iVq3IeyHZA3XOJdeBNjOoScGwfzZ/m3B0gYGajyz+Nsjv+8AvhcaJZuIoA2mjfVDQCdPgE6UiAPTJa08JctUy0q6JkH8KCPE0XfqM7hmTAFWBlw3clrXMD2DtEOZWrprb1AWrNcB4KvcPLvIr2KN2fbSMmlA65QrrMXmptrEJNs6nzzgnJ4i9uN9SseXfu8S2vmtUuuEF0NZIsrN78TjE2rLOYw5sXTbpCmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xwrEEvEolcVNo0sqU9dMRZ/mGGCX60DNePof++5cAzmcc4fjl/UvXcNynygyh/cqF1J6kLRuCc/KnvOvuTeiSSSd8o86TNuOS7WuSqx0B6i9tDJIIYVjB51QFni6fRms9HiHG69WI6AqdpStig9TL5D21ix3xvkP1IsRSCEblsVioy6kSeFr6US++11tqLNFxxK6eUBOyI7c/pQlW5YdU99/RncesfGj3emR/DF4y4Kvjv0sQ3e3/Dvc3IfokTpdykCE1siKxV9qwS1z7v6vS4H7GB+z60t18Mn/NmZUewnSvWDuhySgEyTsCQlIaqzHymezhyHH8U57Ejlu3yigkV4s6mLN9cKGOjqUpFfY9FXR69tykOnhJzpNlAyD7pTfjLJhHS+jk32mP1g/B32kh46pBWq1j+sPrXuOjbwsg7U4PjEiz4+oD7ALdLKYprf6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:32.3389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97955e4e-f82f-4c0f-b9e3-08df078da967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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

From: Felix Kuehling <felix.kuehling@amd.com>

Enable or disable NPA address translation using PSP during accelerator
state transitions in and out of READY state.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ce73657a363f5..428296e5cec6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -663,10 +663,16 @@ static bool check_local_vpod_integrity(struct amdgpu_device *adev)
 
 static void activate_accelerator(struct amdgpu_device *adev)
 {
+	int r;
+
 	if (adev->ualink.info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_READY)
 		return;
 
-	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+	/* Enable incoming NPA address translation with VMID15 */
+	r = psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
+				   15, true);
+	if (!r)
+		adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
 }
 
 static void deactivate_accelerator(struct amdgpu_device *adev)
@@ -674,6 +680,10 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_READY)
 		return;
 
+	/* Disable incoming NPA address translation with VMID15 */
+	psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
+			       15, false);
+	/* ignore return value */
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
 }
 
-- 
2.55.0

