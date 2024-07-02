Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDBEC3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 08:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E51310E565;
	Tue,  2 Jul 2024 08:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVIwD5J1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D702A10E565
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 08:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSvQenSHaDbORozKUq8cw10qBh6hj+z0iujONvrxOA3iKvOiKBUbCOTkCGsSWQ6yOwrCb5yTjreXm296oSooSiz89b84EEmUqeije8LJJ6jv3OdukFn79YvXk/pAbCWwG3C4bYuzw4BugNtJAJlg/RNJxZ4rpnZCgXo/svKua3xxBxdUB4lsObL/hXHYbjTeqiAXsWvAHxOMJBDeUcoDowPYQAFjjuqOOstLUc43LOkpXVvLpWMi6TpxxNtJ1Re3BTIn6edIV7ZT8yBoodIb0wLgx2kHBW1aKe9U6QGzi3vyxlaaRFlyh8nnGeNMXYcqD4LU5WeQsk2SlZc1C2ldVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utPQBD85yAW1yrJOwZzrDNmxN1t5KMGaWEcxRO0gZ0I=;
 b=lOMM6jWgCq9YNeTLzk+lkFpWeSugeKgIPeUpSorGyApUqD8WevpS0veaQOfunyVSV7rYH84adRleoXw/e+0W48FHXPD54woZ1Efm07z5wLvpwj4NwF1IgBQU7i2ZyFFgvUPg28cZgTYeJM7ozyNY4fMJMVP9VAG1Tsd+Dt7OrwdkmNiG6lXtQfFgu8hDOvnSjdjDirKsDxLXfWAzNoL1kzXuQW6PI6iEUG3XrQYBwO0JsEthS/cO3OJuRiEBWWfnqoCrLeInxI4pxumZQlKZy+Jk9ohkJWqQgsinrTc/IvAsIXW8tuw3wmy0AZgftFdokmQwkhOHNNB9UBOEfYh65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utPQBD85yAW1yrJOwZzrDNmxN1t5KMGaWEcxRO0gZ0I=;
 b=bVIwD5J1yJo76aCBKoMz9T3eKXi3BRSyxiytKaIwnoUVQmSyHzbEFXYiGxulFQE+Ezoo6KE31voyoj4we8xYfPKkj2ZhLQxzxGDH9dB7k8VsEByYr0/x3V+c8CpQSPymcBNVI+xEAF0fQ3jR+tvbf0byXhjXPkBNKV+FXSX8bws=
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 08:41:35 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::56) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.15 via Frontend
 Transport; Tue, 2 Jul 2024 08:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 08:41:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 03:41:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/acpi: Add NULL check for event->device_class in
 amdgpu_atif_handler
Date: Tue, 2 Jul 2024 14:11:16 +0530
Message-ID: <20240702084116.1263774-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 948b613a-8f48-4a20-f710-08dc9a72c6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUdqR2poVU00WXJFeUVlUFVlbkdmNzcyY040cnNGdTJkclF4cnRGR25oanFt?=
 =?utf-8?B?dUVmUUhyS1ZGZ0JERUl4eXRFbGIvTUtscWp0ODFEeDdyRzBiazJXWlh4TGhG?=
 =?utf-8?B?V252U3VGU1RXWGJvM3RuR0Y5V1dSOExOZGNNeXViOTBUcTBwb083ZENwWlJG?=
 =?utf-8?B?MmJBUWlaMEQyZDRRZzdMZllmMkQvQ2M5T3JhTGZyTkdWRm1sNEZwUDEra1J0?=
 =?utf-8?B?U2daMHlNZ2ZKd1RZeUo1ZkZoWUZmRUJGeGRJNTVFSUV1WjZCblFtS0ZFOGIz?=
 =?utf-8?B?OUVoanNnSVhNbDdFc2t1T3dvRUFGVXduTmM1L2RyT09ua0dua2pFNGNVU01R?=
 =?utf-8?B?QUFyQ0hoZ3MvVEJCeXIzdE5CZ1FLSlBoN1ZlNFdxWEF2T2hqZm5vSGd3aWpy?=
 =?utf-8?B?QzFDTjNJc0JYWCtWY0tFNEt5a3Rod3VETnB1Mk1nRG11b1Nvay9jZE5ia2V2?=
 =?utf-8?B?QzlxQVdpdk5sUk8yVVo5YXJnSGhQVDY1QkZsTXV1MnFFdU5IUzN6S2pDOEhI?=
 =?utf-8?B?dlFQWHgwWXFWSGJMc0ZLSDNTMitNR0lRRExFSzhLY3J5aG8xbXB4bXlMdU1E?=
 =?utf-8?B?d3BUT0IrdHlUVndNVzZ2SDRRN0pBalRWaUNwODZwck05NGVjYVdlMnRwM2xn?=
 =?utf-8?B?NzNSWGkweUlrMm9mczZFRlovRG5aQUM2VGhleUI0TklZR0xqZUJaYXJOQStZ?=
 =?utf-8?B?eWRNMlRKci9FYmRlNkplWHFlc3kxT1g3QnJQMFdDcG1XSXpGYWJFTEM4UzVQ?=
 =?utf-8?B?VjRxdTZtbmhTMG5EcXBZOFVFYUtoclFhcjd4d0xQSlU3OVU1RElMN1V2ay9k?=
 =?utf-8?B?NnFOTGhtdUgreXZLUml2bjhyRGdTSkkxRko1OWFWY1R0ZGxrQmpKZWxnZ1Ru?=
 =?utf-8?B?T3NESWlwR2s5dFJocGw3R1Z1eDJmODBQNTV5R0JtMFJXRlM3MFl6ajg5WEV2?=
 =?utf-8?B?WFBUcklGNjVXQkNmQkV2VDMxb0JzZm5ib1QvMk9HdE5wWmk0bHNoQkJvRWlG?=
 =?utf-8?B?MzZFSU1WUzNnUi9INDNySk9jdEcxc2tCcExPdjY5dStMSUZRM2VEelo2Zm9U?=
 =?utf-8?B?SVRaNFlYZXduSWJrK0FPOHdYVmFPbUJ4bDZyNElPZHQyNGRXRzJDejcwb3B1?=
 =?utf-8?B?Mm1DZnpCanBrZ1o4cmhkSEpaeWJRQVJTM09rRlJJeTZ3Zkc0REVrTEo5UW5K?=
 =?utf-8?B?YUVMNEhIM2wvYVZCOEQ4RTFyWVdpUDFBMnRHYTNZZ2daQ0JTYmU5WFFDanVP?=
 =?utf-8?B?QWg3U2J2bGlpV0VUSlArZUwvZTRKZENIUDJObnJ2Q0xVZkpuc3lHWVhMODZa?=
 =?utf-8?B?TEFrNG9YYlQwd3NVeGhmOTRkZUNHU043QVIvTFFVekw5dGQ4R1hWTWR3elJN?=
 =?utf-8?B?TDdHU0VYR1RsUGZqdEQya2Foa0lKVTFSTnZMUWFjdlVqVjk3LzZoaFZacHpL?=
 =?utf-8?B?OStZSFdYblZJYUFZeUh3L2ppbzgxZ1hKaDZkcFpCS28zUjFFSS95MWlsWE1w?=
 =?utf-8?B?LzM3aFEwRkt6TDJnMDdJaHlqbkw4eFR3cGJrQkZDd0s0NWdnODlPMjgyNVNh?=
 =?utf-8?B?Yjcwa1VTVTZ4V1c1SHpSb1lualdFRCtxa0trVCs3aG05d0F0VkFyVHRYN2R2?=
 =?utf-8?B?Y1h6VytNa0ticFdTUFZHRkYxSzdjdGNsazQzVGEwdURrSlFXUU8vbkpWMTVj?=
 =?utf-8?B?NUdHSTZFZlFNcEgrWVFrMFJtVitPVVE1UmhSQWhoL2Y3M2kxc0ptR0EyT1N6?=
 =?utf-8?B?VXJqOHY5d2FUM25pN1NOR0RSaFJhc25LRkdRNHFya2h0b29Mc2hyT2IxaFJz?=
 =?utf-8?B?bVRCeXJPNzF0Y3U0K0k2bXZmTWpKaDNFdTNSa2EwSDFpWHJpS284RWd4a09D?=
 =?utf-8?B?ZnNUYzNWclh5MGlPSDJXMVNiVTEremNLc2ZyUkVLTkoraFRSeHJQSGVvV3U5?=
 =?utf-8?Q?L7ITmFn6WHfqbZ+DnDirWRH1C1rl8uQ8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:41:33.2941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948b613a-8f48-4a20-f710-08dc9a72c6f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

This commit addresses a NULL dereference issue in the
amdgpu_atif_handler function.

The issue arises when event->device_class is NULL and is passed to the
DRM_DEBUG_DRIVER macro, which attempts to print the NULL string with the
%s format specifier. This constitutes undefined behavior.

To resolve this, a conditional check is added to ensure that
event->device_class is not NULL before it is passed to the
DRM_DEBUG_DRIVER macro. If it is NULL, the string "NULL" is printed
instead, thereby preventing the NULL dereference.

Fixes the below:
In function ‘amdgpu_atif_handler’,
    inlined from ‘amdgpu_acpi_event’ at drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:1215:9:
./include/drm/drm_print.h:536:49: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  536 | #define __drm_dbg(cat, fmt, ...)                ___drm_dbg(NULL, cat, fmt, ##__VA_ARGS__)
      |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/drm/drm_print.h:582:9: note: in expansion of macro ‘__drm_dbg’
  582 |         __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:452:9: note: in expansion of macro ‘DRM_DEBUG_DRIVER’
  452 |         DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n",
      |         ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: In function ‘amdgpu_acpi_event’:
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:452:49: note: format string is defined here
  452 |         DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n",
      |

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index f85ace0384d2..27131ff30579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -450,7 +450,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 	int count;
 
 	DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n",
-			event->device_class, event->type);
+			event->device_class ? event->device_class : "NULL", event->type);
 
 	if (strcmp(event->device_class, ACPI_VIDEO_CLASS) != 0)
 		return NOTIFY_DONE;
-- 
2.34.1

