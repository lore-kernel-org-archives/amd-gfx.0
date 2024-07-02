Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE72BC3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 11:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8063110E5CE;
	Tue,  2 Jul 2024 11:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ekGPwd4N";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F7B10E5CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 11:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOBWKB1oRT+R03f8Qh69qGP49LNo0xvwDVuIHD6X/n6X+UD/d5OuWQG6gsCFpuTQuc6X+agIlTtTLg+esQ5Yv3Ndm53nQ8l8r0JMeb2JKRwQJQgn7IFAdNcPhSPF7hQcd13qgRo8UDe/EZKjZ+Bmy6gLCXwx9BUIIMacfdqoNpsCMoxlFOMQeFADbAuEm/GPo/KpctnYYzlJO4lcrLV6RcBzKmp1Inr7gzr+Sr2oAdFJjmYKHJwR7EufmS5CcAZjfTdvaVVgRx1xTF6oLBzF5paqRhnIqkly9pFbrXniorPbQb2jKx/q47Ki77bQ1tlQuUpfmS6yOnDfPvkXkW4eKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHXIVL+j0FVSU613sCv3J93QYFlzLhJxM/Dq1TwQeK8=;
 b=QHiegrk9HQMlvWvjZnS51cCaJXc5he9IykxDtnrTFdEGThbpeO8Gv14aTER2IhdomD3DGO+a8qUK9u5K7ZoqFsDgFLt9E9QyQR9jcykDyhipHjTAjnpQ+mUrH7xuZvkYG+Lw4dG3RLQ/sJKIs19MpTfg+0xD/rnChIKbaTsNUKdGlJWvl5zgEhY+d4fe/kehSBJVSf8R/W7PRTqiTVApf4vhDCC03VURF0phrc9tUUlnxW3yQprEk7gGt3dq69O+RLdlvNYE9sMjjhSdDIYKwk17G9QkjO14D7ODclo/HOOAlKi4ZnNYgk82u7EL2UDEpGMT4iGUfurOe1m//kdLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHXIVL+j0FVSU613sCv3J93QYFlzLhJxM/Dq1TwQeK8=;
 b=ekGPwd4N7G+Moa7bi9Jb58M9ZGWVb8fiIB2EL6WNi2Z5Pd9PcG7i2Dh3hhslTKNBWIAYZ3pXGMRRc6FHNDlLw0ai9te2qU2fqNyfrFPYYItW88uTucucRgm3acE15ZhH5+B9pJQumTo09tSb8wA9x9WD+bopEa+NIO8HrRlbAYQ=
Received: from SJ0PR13CA0132.namprd13.prod.outlook.com (2603:10b6:a03:2c6::17)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 11:43:41 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::37) by SJ0PR13CA0132.outlook.office365.com
 (2603:10b6:a03:2c6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.17 via Frontend
 Transport; Tue, 2 Jul 2024 11:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 11:43:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:43:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Add checks to prevent buffer overflow in
 mod_hdcp_dump_binary_message
Date: Tue, 2 Jul 2024 17:13:14 +0530
Message-ID: <20240702114314.1341221-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 994a9f5e-c072-46ee-6380-08dc9a8c3850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0F2TkV3cVpKMjlCTExzUlBMc3Nmem1RZEI5aXNVSVdUdmZqY2IvQU8rYWJo?=
 =?utf-8?B?Qyt4LzdPanhocjU1QUlpUXFGK3dKbmhuWGtWYUhOdTlnTkI3TzYwSWdtMGhQ?=
 =?utf-8?B?RzFjcXRUREw5Z1B3NHFDcnBRaG5Sb3IwNGVYNlc1alJvMkZ2VHBYNHRCM1cw?=
 =?utf-8?B?TWNwQWRsM1N4SDBPbE5yR29PQ2xIY2lycW1nVjNHaXloaTRjNVpUaVlGQmta?=
 =?utf-8?B?YkhrMTRyL2lNN2didFpkT0o4OVk5RmFLa1ZTaTloSURVYmtpU3NhWHNOWU53?=
 =?utf-8?B?NG1LTU45Yy9ITHBtYWZVdFdKYm9pTWFQdWVwSXpScXRMZ3FQTGdqaTZpRDgy?=
 =?utf-8?B?WGlBVGpNSmRpa1RxTmFxZGltdUI5K3hkRXBodmdoLzJIeXpXaEEvNXQzcEdN?=
 =?utf-8?B?M3hXQnhRL1BPSmUzbHBEZlpDVFJyNFVkWVB1aFVhN0hYZ3A0YlhuUlBkcVEy?=
 =?utf-8?B?QS9pMEhFVTc5cC95TUtYSUVPQVgyakh6S3pRNVc0SG8xMHloaHRaMUV6VVY0?=
 =?utf-8?B?RlVQMXJ3dUlKMHJuRmc4MzZNaUd1SWVlai96Rko5c2E2T2k1UW9UcDZlL2JW?=
 =?utf-8?B?ZUlFa1BQcDlPN2pEVldvM0ZDeklxZUxENXMzTWMrWDJCUmRBb2FnUk10TkRO?=
 =?utf-8?B?eDlQNm9xYkk0akZkaXRlVWxzMDkwMDVGWG52QVpXWmN0TnBJZXF0ZjM1OHJk?=
 =?utf-8?B?U1VTMFAzSWJmb0JFbHFGUkEwMHZxUTV6RGs4VTkxMkE0SXZWVUFJVjNiank0?=
 =?utf-8?B?UzhkMEJ1a2pYSUNIeitqTkRzK1AraEVLa0ZFaTB0Z29Bc2Z4d1Y3dWo4ZHJm?=
 =?utf-8?B?UVdaUmRFeU1KcXRNUmlHNzBQYWhOU0hwZTFyNnpBbmFtYk4xV25Bd040SS9m?=
 =?utf-8?B?bXNsVUUySEpneHcyNVlaVE53TWVGdUNIUkhTczNTUVlFSjA5TTRlaXB4YXlF?=
 =?utf-8?B?MjJiOTJwcnpBNm9YNWxHaVJwbHpnMjdaQXJNbFFDYmtiNDBkOVJoTmZYRVdj?=
 =?utf-8?B?WkNkTGt6QUs2OW5xUXlZZGJkRUxRcG11WWRCN0pmYWxmNjFEOGRnMWxJa1ZI?=
 =?utf-8?B?UXFkVU1nWkFsTkhuKytCU0hFLzNkRVBidDJxTWVXaS9QR0lZMEhPZlFoVlZQ?=
 =?utf-8?B?NHVsQkVmNzFYM1lrNC91WXFXUDBuamhTSDBVYTNFZlNQZ1lONjVXUks4ZDhu?=
 =?utf-8?B?RThYQkdFRFNFc1FDYkFQQXcxaktPR3V3WDUwcndRUGp0eS95dHg2blFpQlFu?=
 =?utf-8?B?cVc0Y0hWRFcxWE1CMXRETXhPRml6TWVjSThJaVlQUUVORFpGKzZRWVdIOWlR?=
 =?utf-8?B?amhlWURwOS9sWGpoZEYwL1lSWXRuU2QrR05OQjMzRTZEYnNjd2t5dks3bWl1?=
 =?utf-8?B?WVA0UWVhc1A2NXpoNkZhdlNEQWJITUZ2cldUNmxIMGFuQ0gwaG50MTI4ZEgz?=
 =?utf-8?B?YmtZTVVZdW5QTzZFSG9ocDRsaUwzNzczTEEvTkc0eXd3WHQwekJ5N0lDdVZF?=
 =?utf-8?B?RHVHM1d5ZW1QWDhLV3h1TkxIVWt5VkdybHIzY0hFR3VWZWg3eEdKL3F2VzNM?=
 =?utf-8?B?VmxZdXplSDFiZEh0d0oveUJIckpNck9ZWEpMc1lTTWdJcUJ6WEw2T29rM1Jk?=
 =?utf-8?B?dVhEV3FmMUJPZGZFbFVCYnhBNkR6ekw2cVRuSkJPZEZYeGNGZXJuTjJ4M2RN?=
 =?utf-8?B?QTJPRU1QVmp1andUL1NXdytIaHVPZzg2elpSWWZ6RG5kM2pMLzlFUzBJSFhx?=
 =?utf-8?B?NjBPWnFqNXpWQnhEZjdSNzNwS2FLSVlHYzNvWmJYY3VSTkRTbVh5Q3FXdmha?=
 =?utf-8?B?WEF1VFFxSGFSS2R6Z21QTS9aVGd6Mm5RdlVhbVN5eW9Qbm4rNldPS2ZVM1Nh?=
 =?utf-8?B?dVo1SXJiTGhTOXpGR1krYk9nZFpWV2hsWUYzbFdDUlF6aGMwQklpVW5wcU1F?=
 =?utf-8?Q?9qDCmOSqL2rPkhar1huAx0QDsSzsfM+h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 11:43:40.8940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994a9f5e-c072-46ee-6380-08dc9a8c3850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
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

This commit addresses a buffer overflow issue in the
mod_hdcp_dump_binary_message function in the display/hdcp module

The issue arises when the 'buf' pointer is NULL or the 'buf_pos' index
exceeds the 'buf_size', and is passed to the sprintf function, which
attempts to write to an invalid memory location. This is leading to
undefined behavior

To resolve this, checks are added to ensure that 'buf' is not NULL and
'buf_pos' is within the bounds of 'buf_size' before it is passed to the
sprintf function. This change prevents the buffer overflow.

Fixes the below:
In function ‘mod_hdcp_dump_binary_message’,
    inlined from ‘mod_hdcp_dump_binary_message’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:29:6,
    inlined from ‘mod_hdcp_log_ddc_trace’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:107:3:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:47:25: warning: null destination pointer [-Wformat-overflow=]
   47 |                         sprintf(&buf[buf_pos], "%02X ", msg[i]);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘mod_hdcp_dump_binary_message’,
    inlined from ‘mod_hdcp_dump_binary_message’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:29:6,
    inlined from ‘mod_hdcp_log_ddc_trace’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:122:3:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:47:25: warning: null destination pointer [-Wformat-overflow=]
   47 |                         sprintf(&buf[buf_pos], "%02X ", msg[i]);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘mod_hdcp_dump_binary_message’,
    inlined from ‘mod_hdcp_dump_binary_message’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:29:6,
    inlined from ‘mod_hdcp_log_ddc_trace’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:61:3:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:47:25: warning: null destination pointer [-Wformat-overflow=]
   47 |                         sprintf(&buf[buf_pos], "%02X ", msg[i]);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘mod_hdcp_dump_binary_message’,
    inlined from ‘mod_hdcp_dump_binary_message’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:29:6,
    inlined from ‘mod_hdcp_log_ddc_trace’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:70:3:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:47:25: warning: null destination pointer [-Wformat-overflow=]
   47 |                         sprintf(&buf[buf_pos], "%02X ", msg[i]);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘mod_hdcp_dump_binary_message’,
    inlined from ‘mod_hdcp_dump_binary_message’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:29:6,
    inlined from ‘mod_hdcp_log_ddc_trace’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:73:3:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:47:25: warning: null destination pointer [-Wformat-overflow=]
   47 |                         sprintf(&buf[buf_pos], "%02X ", msg[i]);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘mod_hdcp_dump_binary_message’,
    inlined from ‘mod_hdcp_dump_binary_message’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:29:6,
    inlined from ‘mod_hdcp_log_ddc_trace’ at drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:70:3:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_log.c:47:25: warning: null destination pointer [-Wformat-overflow=]
   47 |                         sprintf(&buf[buf_pos], "%02X ", msg[i]);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index 6b3b5f610907..285251711a2d 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -40,9 +40,9 @@ void mod_hdcp_dump_binary_message(uint8_t *msg, uint32_t msg_size,
 	uint32_t buf_pos = 0;
 	uint32_t i = 0;
 
-	if (buf_size >= target_size) {
+	if (buf_size >= target_size && buf) {
 		for (i = 0; i < msg_size; i++) {
-			if (i % bytes_per_line == 0)
+			if (i % bytes_per_line == 0 && buf_pos < buf_size)
 				buf[buf_pos++] = '\n';
 			sprintf(&buf[buf_pos], "%02X ", msg[i]);
 			buf_pos += byte_size;
-- 
2.34.1

