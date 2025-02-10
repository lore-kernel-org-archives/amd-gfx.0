Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26D4C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 16:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C6EB10E5BB;
	Mon, 10 Feb 2025 16:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4oS3x2YH";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC1210E5B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 16:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KknpMB8Vlw+oEiOLUyiJOhDSc8zUCJlLVSndTIU5DlyJtV8FZc8BWElXaWrFLUzgssVX0tdpHWSkw0ke2qrcVP930JJLagB4UXazK/unh8FK6+xQGsbPe/53qhUPUOaqT1TXZihkgiffEUbPdEPQN1qUm6Z7wCSUYzcUTfGKk4Axx0wecStDTgZyaDlSepAXyOLNnc2gyhjuQmlX7nALxJpoVrJRNTKT5MdI3FbkdZ/m5LrDDlcynLxdJGOOFs4BDNwvxtS3aNeHAdMZnlOyAAF7Y1eGoAw9t9CGQ32GlxMVaQbnAYwe6aR5yY1Qrv2BnDg/ea7dOhJ53q32sMltJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2WvJrIXVrdx/fwRrC4zNphK/YcsJt3GszXvDZEViTU=;
 b=RSoJhBJH9ePHXKG4QTqtR1MmPLDXEzj8HSTfPSw1LoXCtFMHETu+TMwmtWCIA4u0Gg1YHPTe717I4MlkkW2ihvLS3iytQFvkZn/4wT279ClhMUnwAzxzXmb3VzVM5P7+HL8LwdLSLe3+/xcMxkfQmBmXOROvNoa9oBvoDuMKXBb6ReDiaRx2RsYNDWNz0XurSaHb3rFsjWyUCcrkFVbH6KusUVmWFfiVg/A/v/QGsC91ICIo19kVdOWDdL/K2dk3OR0w/tGSppMZx8mPNHMeKzLvTDyHG2zr9OG2esCTodn9L+IDmu/qCvDk8jUIfF9taRK7eNUFEUo1rUFRpEAWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2WvJrIXVrdx/fwRrC4zNphK/YcsJt3GszXvDZEViTU=;
 b=4oS3x2YHOz5tn5mmJNqTSLF/Bc5NP4UX+DxnCybMEpoElLWSciOQmYtp7RJP3v7lFEtN/gjGql1VkYkQKwZZR9rKj2uK8h/y4+uVYQHJnJEyJb14xpJm3otVUVuUSYJTJgpVzqeByD6KLcRhSCUeVSEvsZ2SHMQuPxmmrGq2N3k=
Received: from CH2PR19CA0010.namprd19.prod.outlook.com (2603:10b6:610:4d::20)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 16:28:16 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::1e) by CH2PR19CA0010.outlook.office365.com
 (2603:10b6:610:4d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 16:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 16:28:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 10:28:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes11: fix set_hw_resources_1 calculation
Date: Mon, 10 Feb 2025 11:27:53 -0500
Message-ID: <20250210162755.2488728-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: d34912b7-d0ce-469d-64b9-08dd49efebca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXl3OUl0VEVsYmI5OFBxYnZiSzl2N2hpWDE5ZnRPayttY1MvdXQyK2tlV2ht?=
 =?utf-8?B?UDlwMWVWSW9tTW1OMlYrTytwcDVQaU9yNVViRHZyakl4VXJNc1lGNDZEUzIv?=
 =?utf-8?B?b0dXK09KelQ1dFJpbVhtb2pwZHcrU294cm1xNlNibXJ1ZTRvRHBNNEhXK1lu?=
 =?utf-8?B?eTNuUURRRitLcVdaWXpGV0p4K0hKTkRsa1hya1NlV2UyNS8vNkowUTdseHhN?=
 =?utf-8?B?VEhFRDRRelVhc2ZOWHpnbWlXZ3FWcEw5Y0twNXE0elpaTVRtSUtSOS9xeGlt?=
 =?utf-8?B?S3FjMnZjZ21zWWlnTEw0Ui81eVJGK3RSVVQveGlSbGp1Ynd1UmF3SG9zWkN6?=
 =?utf-8?B?NFJSVGE1d0hCVmxSekxsMjRHMmhIUWc5U0JsQWZEL1gvSnIwQTJRWGZwTlRE?=
 =?utf-8?B?eitPVDdFaVJEUFI3ZDZNYWJTck1Tb016b21XNitvMlpoZUJvV0R5OEhnR0hF?=
 =?utf-8?B?MHZoZU85bFMwZWU5aHJ6TTJyKzNYa055c2UxcWRQTlBHYWFvQkRtQVlQY1A3?=
 =?utf-8?B?VmN5OEpOSjhhdjlZUVpWL1lmYVI2MnRoT21ocVg4bGJrMUpjNlV6MHNYMmZs?=
 =?utf-8?B?SW1DMGl2RHkrYm5hbk1LUXA3MWVQQW0rZURkY1ljbGxJM2xnSDUxb1RXbW5D?=
 =?utf-8?B?eThsQWVLek1ScHlyS0xBR0FFWCswNlFBN2s5a3owaEdtWjVNaGFjQzh3ZjY1?=
 =?utf-8?B?b2tyT1NsU0hIa1loSGZxSktqdm1wcVZ2TzZBTUl6ZW8zazZuVGZSWDBUSTRU?=
 =?utf-8?B?K3pjVzVnMm9tb0ZPQjV1S2hiL0phT3FjKzBzU3IrdDd6aVlaOVBtT0ZYMEI1?=
 =?utf-8?B?cHNTSlJUdzZaWG5hdnRhR1FBZzVqdVR5OWJld0Q2S3V2WDdjQXJHd00xaWd1?=
 =?utf-8?B?T1JKdUlXb3dsTlRNdFVvYmdPdjlEakkyakZueEJIc0NsY2ZnTldTRFFJSVhQ?=
 =?utf-8?B?R2xUaEJFbjNQNTU4RW5iZHhldEIxaytzcTlMb0Z4ZkxyZUNoQ21uV3pTSExh?=
 =?utf-8?B?RkF5ZnNvMk9pQlBSRGphVllDaldibTJEckpEMndQQXk4WjViRTVoZ3FWenBB?=
 =?utf-8?B?Z2t3ZXJ3Q2c3ejhoUGZEcnZQbVlrUlNIS3R3ZEsxcFZIL2Y2cm1wWkpSSm4w?=
 =?utf-8?B?akRSVkdJOWNRZXM1VXhYdzIvb1Z1azNOejlJTWc4aDRYaTN4Mnk4WnMzUFBm?=
 =?utf-8?B?ODdDbG5ZS081SEVkeGM2RGtULzRNZGVGK2hockU3aDkveTFZNVdaRkdHckpp?=
 =?utf-8?B?dTJKTzZBbnNsU1hnY1E4Uy9qbHFhUkJ6M0g3Vi9NNE9mS1M2bGlPeHJOY3lm?=
 =?utf-8?B?cnlRZzRSclpkOW83SWY5bER3NXYwYTB5UmdWZTRUak92ZGFTa3daaitXb1VF?=
 =?utf-8?B?cWh3MXhTcUN5bTBlbW1naGFUeE5MWmEyVzYwdTJIVUMxUkRRUHIrOWNQR3dm?=
 =?utf-8?B?Ulpia2J0UWM4V0I2dkliMjBnd3FoWWV6cENTK0c0NHJMc2ZUNjZuN3RJRXJp?=
 =?utf-8?B?UVd2Qmp5UTYvTUR4TGtQNEhqUXc3VzZaR3BqVzBaZkJZWUJiNk5qRlhoWlZi?=
 =?utf-8?B?a0pPeWo1MWhhY1g1NUN6T2MwYTU5Y0UzdzBQVFAycVZEV2dmNHphdXZkR01P?=
 =?utf-8?B?MlRkcTFEaGg2SFhSeFZQY1czNUViOXZuWnk0c2JTQVpvZE9oWTUvWUYrdkJa?=
 =?utf-8?B?eXVGS1ZFNmV1TmlGenRYL2tsTzVZUXBRam9KRWg5S2FCcmpsZXBFQm51dWNL?=
 =?utf-8?B?RGhNNm9PMTRVNzJXVG5jZnlZSUh2ek1yY0hZbEJSbzc3ZTEzUW9FWDJXcThh?=
 =?utf-8?B?WkxsbkJRL3Y3U3NPSVc5eVhjT1NTays1MnJzVExWZU1NbHcwRzhJZkpNK1pP?=
 =?utf-8?B?WFBab1oyZzMrM2xhUlZYS01acnZkZHdFT1RSMTVHaXIvODNkZUkrNjczYzNK?=
 =?utf-8?B?NjBBZ3FJV1BqS2JhYW5VZ3VsSVcrcnQrMEs2Z2hYWHdtMHNsUzZvcWs5MFdu?=
 =?utf-8?B?VTZtTW1TeEJnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:28:15.7305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34912b7-d0ce-469d-64b9-08dd49efebca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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

It's GPU page size not CPU page size.  In most cases they
are the same, but not always.  This can lead to overallocation
on systems with larger pages.

Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index bf51f3dcc130e..e862a3febe2b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -743,7 +743,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 
 static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 {
-	int size = 128 * PAGE_SIZE;
+	int size = 128 * AMDGPU_GPU_PAGE_SIZE;
 	int ret = 0;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
-- 
2.48.1

