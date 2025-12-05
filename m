Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1502D2F7E7
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 12:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E33B10EAFA;
	Fri,  5 Dec 2025 12:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jBp0IA/+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C4C10EAFA
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 12:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5PWA6/8dfpEkxoJzNEwcXHkFBWxoc0F5KhusY4OodnmmlOI/6tpLCD/VPrMGHYcapzuSWM+t9oZ6P7u59ILnbnJVdLKufscpW1asx3/7cC23WLIz8UNiApZ8Z2sNtyyp0HrgK5ZF7yAMdBQgNMfnLbHoWUjmmIPLZOMArc5zzZb14eJuY612GMoSqDRUpxxvEU7hSlWAdkEcksoV/dQZg+TtfmCd3ytX0/8d94mRHUo6s0hEzslK6VfHiogol159xj/PkBKdOfRhz/J+uCOAdWKftKeUAV8vtstK2lINuJAWOgfBxayuvM3eBF9y6R0OS9KakL39oEC+3XSbsPd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbL3EDUY2QA7zPNTKm75IyWB3zTkPOmX63uSCvmKhRY=;
 b=UVW5iD0xVgaLuGLKWHJkC4pkjzQWQbRHzd+hx4wEDPSa5Wha+nJwErK0sUeStVrQjJLWviNb4Iqufw2/Jz1CfJ04ZnW4yiQ3KVxCiOtyf4iUdbMGKLrCm0TqoRfcdrWxM66QCbSEesQ6ZN3SglMRG3ndiL4+beRK+ZlVImb5Etxk1JF/xPkPfHdZb/CfB7yLzwIxfDtAj/XDqg7QPPGWYtTY7lDhPjfcjrTE7f+gyK6YDJ1DWJrJphbjVqCpV46NzQuZc8j9qXGDRe62veS9TNCnrb1uBGNNpVKsRKZ22yAAJTqv/1ZOSVYfrqqX7Mt8kgyOyIsBWoYasaZZe+LlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbL3EDUY2QA7zPNTKm75IyWB3zTkPOmX63uSCvmKhRY=;
 b=jBp0IA/+EkOlJAwoJbr8Y+7Wmt4uBcbYQsAllScvMG6DJoI66/pq9jDZxHOoRfVQh+B/fJbRlETqcg/XiViflyQWWff71L3//huoqwZVJ62gGdHo6g3kcrbork38RVdI+4dd9AZxDiO4F8PDH5jcPPH0wlbk1WG8U54j79sBhi4=
Received: from SJ0PR13CA0184.namprd13.prod.outlook.com (2603:10b6:a03:2c3::9)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 12:14:05 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::e0) by SJ0PR13CA0184.outlook.office365.com
 (2603:10b6:a03:2c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.1 via Frontend Transport; Fri, 5
 Dec 2025 12:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 12:14:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Dec 2025 06:14:02 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/acpi: Reduce amdgpu_acpi_detect stack usage
Date: Fri, 5 Dec 2025 17:43:45 +0530
Message-ID: <20251205121345.408427-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 227f0be4-11c1-48c7-b428-08de33f7c83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dExBSHFPVnorcFViU0R5U0g5azdGQUhGTitlZjFSMGplV3FIUVpBK2NHS2xj?=
 =?utf-8?B?QjdKaTR6ZHdOczF6dGFRZGsvYUpMOTcxaTc5TFhiRWNDMUJOcXUzNk42L05m?=
 =?utf-8?B?V3hBTHRRMWUwa0szZnRKY3lIeW9Cb3h2dnNhZHZpS0g2R0tUT3l3VEQ0b0Zi?=
 =?utf-8?B?L3Q4QnZEczBJdDRrUXNQZlZEeElFRGZGanhYWkliMFQ3QmZYbjdHdmpRd3A4?=
 =?utf-8?B?NkFhaVF0Qnh1cjA2ekRtWHlJWG02WSthWWc1d2J4ZnFZN3BXZk0wMUJqNUJj?=
 =?utf-8?B?SVhZVUxzSW90eVdocjhpdzJoMW5zZk9mVXlNWXZvZ1ZVL2hVU05EQVp2MUY0?=
 =?utf-8?B?eC8vWnpBUjIyUmgxSHB0SDMrT3E2NWk2d2lRcHBtenpDYnM3YnpsNGhsVnNV?=
 =?utf-8?B?U1ovaHV4NVMwOTlGYzNmL1c5RzMyOGJqMjJ4Q0k5aEE4MndscCtkY0lNQ1ZL?=
 =?utf-8?B?NERYeGttMzA1SUhkSHJNS21ycGtZNGNYM0pUaFB4NmNOakFmMnRDRW1CRkxI?=
 =?utf-8?B?dDNjMjVmUVZZQ1NsN2pxSXFrWVVmdlFORFR6WmFNeWxwRDY2d1Y4emd2Rnh3?=
 =?utf-8?B?TVFjam5pcmVwbk9tYnUwemdBaDhndWJ6OFhMZThMa3NJYzBiVVovY0w3Rnd0?=
 =?utf-8?B?UWZ5ekdmZlVMM0p0K2RtOHM1UjcwaCt6Tk9UeWRiWGhqZW9uNlpHc3lCSlFG?=
 =?utf-8?B?Qm5OWHNQM0J3MFBqZjc5bjFjS0NYTldVek1SSC9zRTloZ1N6bUFIU1Y0UG5x?=
 =?utf-8?B?aGEreU9qdGpTMkZFUzh4QlU0R20yaFpSSE5Tb2xtaHBnVlU1TWpsQzN1a0p3?=
 =?utf-8?B?MExadVNHNGdMbWF5ekNnVm8rNVgwL3lnSCs5c3ZsRXJtMUIzWTNZRjYxbit6?=
 =?utf-8?B?S2k3SlgwbmhVM1V6ZFRtUmY3cE84WTBYM0tsS3dzK25xNlN1NzBTSHZxbktl?=
 =?utf-8?B?TDhpYjlxaEIweGZxRlRBeHNrczNiQTRETSs3QnhOMWtZaTV0VW1PS3UyWWZN?=
 =?utf-8?B?V3JDQjhOWGF1TGUzaGdZOE5qd3V1ODVvNThrRmRBK0R5dkpmSDlONFlSV2Zs?=
 =?utf-8?B?Mmhjd1FMdnY4N3FVNFhtOEwvYmZ6UENxdzhoQmVlUW1Rc1dBSWV6bkRMaFEv?=
 =?utf-8?B?VHJBQ2hhREFoOVBZeXgxL0hmU2FxaVR5UC9jcWRjOS9OTi84K0w3SE9Ga0V5?=
 =?utf-8?B?WjJ0WkFORE9EbEgyVWNMR1pYOHBrSHNUTk1KbCtFSkJtbjFUdlk1ZHB2S29w?=
 =?utf-8?B?eWdaMlQ2dzdLYTJoTWV1cmkxaDd4YzM1NGE1QUdIWHdBNGcvd2xzdGdRN3lN?=
 =?utf-8?B?ZDZWWGJtUnUxaHZTdFpOK2d6ZEtralRMRm8yNFJ6WHdHcGxucVFBUU5RTS9K?=
 =?utf-8?B?V1duT01laXNUUjgzVE1SdzU5Rk5PTDQ2amNGdEZralV6TzdNUzJKVUNpeHdq?=
 =?utf-8?B?YUhhb0pyZ1kwTnJhRnhLZFFkTzlPbUR3MzY4VjNKZVJhK0VZSS9vS3FjNklC?=
 =?utf-8?B?bXdaTER0aE8wd3NEWUNlclJ3UlFUK3JISFlPcWJhT1F3SXk4b0N6STN0ZW0v?=
 =?utf-8?B?QTN2dGs3Nms4cVFCeE1HZnV5QzR4ZUdPM05YaFo0bWRTd0EzdmE2MHlmeVpT?=
 =?utf-8?B?ZWNKOVhMK2NPUzhGOEZhK2UzQkNOaW05VDdXRjJHQmFqOWhTYVhMOEdoL0hx?=
 =?utf-8?B?U2ZEVGNmUzRDNEJYeEFROHFsM2kzc1h3MkdaOUoybm1rdGJDQ25zZDBWdmJC?=
 =?utf-8?B?R3BvMnprbWJic2pzTTlDd1VHajVwcjFLdlBkSFovM0l1S050bWFibnR2aTRU?=
 =?utf-8?B?WWlpR2hzQW5PMVhUYnViOFJVcHlETlhxN1crVUMzakNIY2szY1A4cjB6NThn?=
 =?utf-8?B?V3R3Znk1cXdaSVR6QzVvOEJjUmZzdzJsa3E0TG8rak1YR0x1NmNlQktra2sz?=
 =?utf-8?B?Mm9nRU9RMk5mZGptSDRZL2owTi9ZVkpqSVljcnJMNlRYTVp2T1dPeHJIdzhk?=
 =?utf-8?B?RlkwcnVBMjdCbHlwSlhLL2pMVTlQektXZGppOUxuMXVDakVpOVo2SlNPRStG?=
 =?utf-8?B?WGlHb1JXdEZzWnRML2o2Q0tXQnc0WWdNblZyeXRiNlZhQ0VaaGt6T2tYUUo3?=
 =?utf-8?Q?OXUw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:14:04.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227f0be4-11c1-48c7-b428-08de33f7c83c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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

amdgpu_acpi_detect() calls some helper functions it calls have large
local structures.  When the compiler inlines these helpers, their local
data adds to the amdgpu_acpi_detect() stack frame.

Mark the helpers with noinline_for_stack:
- amdgpu_atif_verify_interface()
- amdgpu_atif_get_notification_params()
- amdgpu_atif_query_backlight_caps()
- amdgpu_atcs_verify_interface()
- amdgpu_acpi_enumerate_xcc()

This keeps the large temporary objects inside the helper’s own stack
frame instead of being inlined into the caller, preventing the caller
from growing beyond the stack limit.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:1403:6: warning: stack frame size (1688) exceeds limit (1024) in 'amdgpu_acpi_detect' [-Wframe-larger-than]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index d8a4e918846c..61aa0ebec63e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -241,7 +241,8 @@ static void amdgpu_atif_parse_functions(struct amdgpu_atif_functions *f, u32 mas
  * (all asics).
  * returns 0 on success, error on failure.
  */
-static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
+static noinline_for_stack
+int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
 {
 	union acpi_object *info;
 	struct atif_verify_interface output;
@@ -286,7 +287,8 @@ static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
  * where n is specified in the result if a notifier is used.
  * Returns 0 on success, error on failure.
  */
-static int amdgpu_atif_get_notification_params(struct amdgpu_atif *atif)
+static noinline_for_stack
+int amdgpu_atif_get_notification_params(struct amdgpu_atif *atif)
 {
 	union acpi_object *info;
 	struct amdgpu_atif_notification_cfg *n = &atif->notification_cfg;
@@ -354,7 +356,8 @@ static int amdgpu_atif_get_notification_params(struct amdgpu_atif *atif)
  *
  * Returns 0 on success, error on failure.
  */
-static int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
+static noinline_for_stack
+int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
 {
 	union acpi_object *info;
 	struct atif_qbtc_output characteristics;
@@ -601,7 +604,8 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
  * (all asics).
  * returns 0 on success, error on failure.
  */
-static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
+static noinline_for_stack
+int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
 {
 	union acpi_object *info;
 	struct atcs_verify_interface output;
@@ -1090,7 +1094,8 @@ static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_info,
 	return ret;
 }
 
-static int amdgpu_acpi_enumerate_xcc(void)
+static noinline_for_stack
+int amdgpu_acpi_enumerate_xcc(void)
 {
 	struct amdgpu_acpi_dev_info *dev_info = NULL;
 	struct amdgpu_acpi_xcc_info *xcc_info;
-- 
2.34.1

