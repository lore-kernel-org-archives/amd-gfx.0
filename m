Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E31C25B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 09:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9FC10E5EA;
	Thu, 23 May 2024 09:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mqs7Y0y+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FD310E6A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 09:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbh6THYS97j4ZUTJ7hF2nmOquyPZt3VVUxuNJ70k6fGr119srQEPdPRxmrfAwLhgBwuo4c8KPxRdrgDajSVXt2Oqqt3Ld0YajD01iORyJ1HKIE2af/WLo+WjQY1G2IM3i2YJo9bNRL633DKkSeiGNkfHbyjcb3KOv4vsSthIi7FgYjnJ578Bzs8k5sniFAiZkdV3vzzm6DOM4UfDJrMrFZUDn4C3CkGYJaP0BCTE91Z4JlXZMtpRBWUMWG0z19iBzZTfHz6aK0R0u9/8Je9ZqjkExm5LYjOLM2ZB72jZ716ynDQ7XBhTjokXUNz9mFbAJ64p/wlrxtbUOq1t+Q5G/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FDVzNHpay0heFGxTVXQLxl2bkYSgJf0BDzrzbbtQeU=;
 b=UDQkVNe9NSOkr9ahGZ1zDu0RZTxATu520cMn18mrWNaTqiyIWn3sGUyvzo/a3Am7g72+y8hk7DdtWE5+avXEqAAfDNf4JHKrhHwK3tdqth7DGFTAZ2imreporb2P4y4/pdK3HYyUpXTsf07US7IAHXdzNTboWeWbOd3g5+H2XRN/hHiCoipfAXfRrrXTvSD8jyaf1MuJGt9GGSB/7bIkiggbwLe5S9L/V0XZSEvYlmqJ0E4ASC1hyVnS5noDYjy+qkfiVO490nuTID8HbssVPHX4BRJtka+XXhQH2n/R4B6f87ePZzaKAkn0I0BiAeTVvfmhL4MIiPhGwM/HCoYbxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FDVzNHpay0heFGxTVXQLxl2bkYSgJf0BDzrzbbtQeU=;
 b=mqs7Y0y+DXJ+uqY1GUSXMng6tt9PFLxrdM7BYoks4/Mw/vJIZc9lE80lalOm/0cWhySs9wA5QT0S9kFraZMwdLxjUVmy/MdPUu222SiPNinf8x177stLvN/jMrJKlxvpXzy1LPzuzxBUy/dmqLCQ/Oapgjkt3R0DlHiDC6E+xhQ=
Received: from CY5PR19CA0107.namprd19.prod.outlook.com (2603:10b6:930:83::25)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.40; Thu, 23 May
 2024 09:17:02 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::5) by CY5PR19CA0107.outlook.office365.com
 (2603:10b6:930:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 09:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:17:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 04:16:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 04:16:52 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: fix dereference null return value for the
 function amdgpu_vm_pt_parent
Date: Thu, 23 May 2024 17:16:51 +0800
Message-ID: <20240523091651.1425735-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: d7264a8a-be29-4997-de3a-08dc7b091a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WndnRlZ2MisxRjdiOVFMVVVXbDJZNGNaZ1Y0MVRvUXVCME5VcmxabnRIeHl2?=
 =?utf-8?B?OHlXbjN6dHF6cGVsSnVTUFd5WFN5Ti9STkszNmNlNTY3eENJTDVVemt5SmhR?=
 =?utf-8?B?QkpPa1F0ak5XNld3aWhhLzAxblU4NjRNV1dLMXlQcU9KdUNUZ3c4VGRkb1RU?=
 =?utf-8?B?d1F1dGVpWUZlbCtwODhhUUZEOHhiTTlVTjl3cXlSTUQ3Szcyb3NQSTN4Qmlh?=
 =?utf-8?B?djNYMkhGNi83VTBLR1hYQUFuVXNSUkFNMmlzSzNkTld4eEk4TTNLMGd1SytU?=
 =?utf-8?B?enBrZ1ZNNVQrL1ZHMWtwajBjT3AwQ1BmOHg3a1EwcXhlVkRIaVlad3BGQTFh?=
 =?utf-8?B?SVEvQlVtdUxtM09vUXRNektFejZVRUVTTGo1VUhKdklPaE45SEpsNjlpZWZS?=
 =?utf-8?B?NDhEcUFyNVpGQ0NVV0IxRVNBSVVjQnYzS2g1ODVReFppY2VqQ0svc2gycDFn?=
 =?utf-8?B?cDV6ZU9nRDY5a0o2NjNaeW1WR1RhWGJVbUtNNzJ1OVMwWENsT24waVNlZ1k5?=
 =?utf-8?B?ZjBkWEIrTGlhdjhmSU9IUzZ5ZFBwYllvbVBBQnVxSUdVZlFGNVRrSTRIYlEy?=
 =?utf-8?B?N0RCTk4xTHo1cXlWb0MvS3lFVTIxSDRxTXJEdGpzbC9CbDI5VGI1VUc2YUFx?=
 =?utf-8?B?WnZjd3dkTWtJQmt6K1B1ZnFiVHFOQkFEV25UKzRoU3htSVVHQWx6YWduYStY?=
 =?utf-8?B?QjJ1K1FqN1ZLL0VyQXIxSklCaXJ6MDJCeUtnUnZPQVIzYS8yeEc3RjJLR1d6?=
 =?utf-8?B?cDBXZDVsVlUwUGpsQUp4SU45aDBGNHNqZWFQNHYrSjNjcWdjN25oM3hhL3lS?=
 =?utf-8?B?V3JGRFMxUU5HZFFrcC9ReDNTZFcxOERPa0N3clBmcklaYXhGZDFIZGYrUHhJ?=
 =?utf-8?B?Q0RsVFpla0ZzbWlUUzdiMlV3cysxMDMvbktPeWJiSS9ZbEhlYmRTWkpPNGFU?=
 =?utf-8?B?aUZnKzJ0emZJcGFEbE4vM2I1ZzlMZEFtNmY5QW4xM2sxcXNINHlFa3lJTzBV?=
 =?utf-8?B?bHVXTTRLMVlVRjloaFpvQnVkREM0OWR1VVoybEVwc2N6dVZGYTZpZk5uUVl4?=
 =?utf-8?B?ajFZa3ljcmNyNnJBRlo0bjhHVHNqaWFLbi9ZZTNGYkxuU3htVHo3cjJDbVFl?=
 =?utf-8?B?R3F0SXNRVExRVktYcnc4cmcyeDdDRWppNDljZE9FUCs5dTFLRWRUVDBHc0pU?=
 =?utf-8?B?b0VseGIzbENqT3hreEtGWFJlOU1pVjl3Yk5JMkQ3QVlnelFtalk0YWZ3MjlQ?=
 =?utf-8?B?THVHVlhkaTRXTW9xdlBWaUw2dkVXUGthZU5yUWl6ZGJWT3QzL09VVURIMWoy?=
 =?utf-8?B?dkg5UTI2TTVjci9OQlpqNS81bENtRWZJYmtVSWduZ2U2M1BXZFJpWWJrdWhq?=
 =?utf-8?B?UUZadTNQU24wRVhTSzhzOFpQRmYxaytvYzVZQ3FJZ215WFMrSHZGdnBLQlI1?=
 =?utf-8?B?VklDMlNOWWlHbmtjOHIwRzg1QXVqaUpJVUJHbmdVT0g2WUpXTlkweG1zc0Zj?=
 =?utf-8?B?UkpiT01OYXBNUmtWR1RNeEsyVkNYRGZmMFU1ZzJDRUZBTFg5OEhtYllXZmMy?=
 =?utf-8?B?b0EzenZmMFkxNkZHZzlvSlRSRll2RkI0aWlUZ3RiSitGZmNvU3RXNjhYb0ZX?=
 =?utf-8?B?TEJUMjVXaW5KSGZ2QXkxdXVmT3dkOE1TK2x2OW4zSm9CazV4Q3h1SnJKc3BT?=
 =?utf-8?B?dXNkNkdFbCtsK3VYbFpSMjJaY3BPVm4rSHBxZjdnVU81aWNXMExnNURpb2h3?=
 =?utf-8?B?Mi9XdnZYd1hVNUlUSW9uQkRlWCt1UHdwM0oyZ3VXMWRyOTRuWnArVk5zQlJB?=
 =?utf-8?B?UnVCQk5iVUQ3cnQvL01SVjl6OCtOVnAvZXdQWGpBaDN2cVpjQnh2VHNWNTdT?=
 =?utf-8?Q?E1HUpqKCyVyaP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:17:00.5715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7264a8a-be29-4997-de3a-08dc7b091a58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
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

The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
To make the code more robust, check the pointer parent.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 0763382d305a..e39d6e7643bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -706,11 +706,15 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 			 struct amdgpu_vm_bo_base *entry)
 {
 	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
-	struct amdgpu_bo *bo = parent->bo, *pbo;
+	struct amdgpu_bo *bo, *pbo;
 	struct amdgpu_vm *vm = params->vm;
 	uint64_t pde, pt, flags;
 	unsigned int level;
 
+	if (WARN_ON(!parent))
+		return -EINVAL;
+
+	bo = parent->bo;
 	for (level = 0, pbo = bo->parent; pbo; ++level)
 		pbo = pbo->parent;
 
-- 
2.25.1

