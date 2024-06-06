Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E264C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C144210EAAD;
	Thu,  6 Jun 2024 21:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ViSgjVu+";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C314410EAAB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta04X455YLNK/k++GoAMb61NBE8Mb/H6R9nrc9dGX4A3FV9xUf69Xt6OWT46sZk0G41rduq1cIAL1dKHP6B/uptM5z7R+tKXO5jD/ZM1OmWK+2PDaqXQK+27CXvRcj1s5HP7VWL1SvJ7eWbzaY//t9G4rz0i4HMwmX/bhnSAogV0GC1kHkEY/oBCebXvoaGaJ3ekqQ++FJh6XE5O38lJO7iFt8iGnLGGZXG2Bf+HpNw61E5YmfA1cUC2ZONxuXHXtjehy0IPc5KBOmXOSYSnQ8IBKLGyAl5C8Z//igcqGkS8bvcga4zE7Pr9zxCPq2sP5Dg5DiDCvE7/mqKIBx6p4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7bLgjPFnL8V9tAG+NIlGQw/hb2xzLkADwhSSyzfpX0=;
 b=hvsRiB7h46VDyG0W0L1v68O2LzLDWalXTRRbCGgx0XjT7LM6z/m/a1c7vQF90H6j4TeNiPGb2i9tjy7jq7Zc/YqKb8SiYfk6tjlN46hSP6q44Zk+31L5QhS1qV5EwgX74wKHc5WOdpwVbHQu/lZ2VxOcACj8c4i+j3/E7yGP0zoUO6OJD4WG2oMbaILbAjVju0e60MnD1Nk4mePVDpM0aHDuIeS/kUCxCaL+cPEPEs4OtuAgpiaLepwbJ5bDDXvTHjAbRNrrA/qgmk72+OYhEtQuIZ3J8eQndS5YrIPmgGfYHpVkHRptaBHe9GUmbOrvDhL4AxoG7FhCczHCjKNV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7bLgjPFnL8V9tAG+NIlGQw/hb2xzLkADwhSSyzfpX0=;
 b=ViSgjVu+kyrg37jx+ZCHsfwUpiaN0zP+/gWWQeXG7cquYqDa2BAIm7NX+HtXGUn8SaIFiF1VZ8Wp7rbDP0xJY6L8tId/BJCizHiFaegLhsWF+RE+z+6stECis4BCnKMIl0dKlKhViykr/c34CF8+8eTHGK0smW+tmGoXMp6voyA=
Received: from SN7PR04CA0060.namprd04.prod.outlook.com (2603:10b6:806:120::35)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Thu, 6 Jun 2024 21:02:06 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::98) by SN7PR04CA0060.outlook.office365.com
 (2603:10b6:806:120::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:06 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:04 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>
Subject: [PATCH 10/67] drm/amd/display: Remove redundant ternary operation
Date: Thu, 6 Jun 2024 16:58:31 -0400
Message-ID: <20240606205928.4050859-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f5732a-12bb-4fad-e587-08dc866bec86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QV9VEayAyqF/8CwYFjQlJOOgaAAW5XG3uYcVt+iQPVk/5xdWf7bqjZScYqYQ?=
 =?us-ascii?Q?LmD4Xgmyn3zYNjpyiyvTYCzTk4XmoP3Ndnz+9ZuAsfDfyQWNcbIfWs9v0i/G?=
 =?us-ascii?Q?bVcUP4jIu2s0UfpJ2j5jBDAf82UMyhoD9b6I3x0Ifql2AMj/zf4NM9No7Loi?=
 =?us-ascii?Q?vd7XEtmw2AM2XLJEA50THL0n+OKqSCi1A4gK6qNdbN2SF0iX2a9pi53qfk5G?=
 =?us-ascii?Q?uJMCWPIgL6jCTxurXhJ5LtokN/TMs1jBeBsiTVHKf9bjbRjcVU/7IgOTm6+Q?=
 =?us-ascii?Q?D5PEXO/srpP/RCjzrBPxiR0gKDPzoVBJeU6rSJkOXf2sYeeTsX2EiRROY9yo?=
 =?us-ascii?Q?PUTk1zagOYbQKBWplGSaFx5bdbsAyb9ZFjCceM7dCB3PTuyfVbG2yhboVV65?=
 =?us-ascii?Q?Qb0wB5utqcydE2m9Ou+Tu938HOux3wkQGUzv30xPQsq5MTuiISFNLCjCGdQ+?=
 =?us-ascii?Q?q/gMsx2oRZjTguDl9S6NUDfqoJ9Le5ZF/PTNsw6HiHV89lM5rb21GpdsI4cQ?=
 =?us-ascii?Q?bh/l+XkxozOI7MXgLxywLq43HqZElsbJqRtt3T9xH93uxj5XmfAWGl//q8Po?=
 =?us-ascii?Q?xiy6SZMHcPTqcNVae32Zc6Wy11LMD9RegQzef/1OkTgbPg2gM5dledD6zPVC?=
 =?us-ascii?Q?HDWCRQedOBxiaKQ9TAqJLn60xQXzesIAVXh8frmui1nMbt7K8SCniixfkx5c?=
 =?us-ascii?Q?bSjTAS8noObEesrG/WxcwdrNk0lmJMDlkX2aZG9RazBP5KkUY5oM+S9sV4db?=
 =?us-ascii?Q?fLAQ7tnRixkIxxYKrx6eU0cyBT1Mqs9yjTdKgOrvL+vnOD1vNJbA+7As2PAU?=
 =?us-ascii?Q?QQ+uDQXLfL4AsKMU/ZefuL/upQWIC7MZWS2s2Xd7CF71/QDN8JOQpCXEDY7V?=
 =?us-ascii?Q?BkGnDS9659JNY+uQ3ngZT/Y1PwDwWn2rWwMfGn1oPjN+Al51a6CIXP3YN9X9?=
 =?us-ascii?Q?Z9D3i9E3/Mnv7668Nk2DODy4FapkPuL9uOqQRNZA4ZK2RJQxkzFIdPWXUARs?=
 =?us-ascii?Q?nASaI7KYbVLPz1hm1LA4LV5IJ7htzi5WTcBI61dmt/yTi8kYogIM2ro5FeZr?=
 =?us-ascii?Q?cm9hqa1CgH5hZpEy6ybQFLIptK86FJTTrVkBdaqQmBxiEg3hbj+hXDn5WnA9?=
 =?us-ascii?Q?2eDS1LZj0P8UKUKlZ/CO1oVXOXX5Z/puwp4pcmtCoyItbq356r50okfDF3NO?=
 =?us-ascii?Q?yG140kRe5j/Ku+/BxbKn0He4u/eHYBp0Xa9X2E/hEIW53d2Wdnmm+tlT7EIY?=
 =?us-ascii?Q?frklwn0H0xRwy9xrtR6F8JCqsPHxJGxqDaWf1xelt/BUlivdYcCNqVYor0kX?=
 =?us-ascii?Q?bW24QKnheqSarHr9Omfm03eXla7G5MoOqZNv5TPqkUgTSLK9rpcuEuN9U0er?=
 =?us-ascii?Q?TVOy0GY86/l9Zdq9iJXUKADRDUJPaqhXkMKkSx0iwiNzu/aQdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:06.6872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f5732a-12bb-4fad-e587-08dc866bec86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis flagged this ternary operation as
DEADCODE.

Since 'total_y_free_entry' is initialized as 0x200 and
'total_c_free_entry' is initialized as 0x140, and they
never change values before the ternary operator, so
'total_y_free_entry' is always greater 'total_c_free_entry',
'so small_free_entry' is always set to 'total_c_free_entry'.

[HOW]
Replace the ternary operator with the variable declaration.

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index b2d79c908ec2..f93853d434d2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1612,7 +1612,7 @@ unsigned int dcn20_calc_max_scaled_time(
 	if (time_per_byte == 0)
 		time_per_byte = 1;
 
-	small_free_entry  = (total_y_free_entry > total_c_free_entry) ? total_c_free_entry : total_y_free_entry;
+	small_free_entry  = total_c_free_entry;
 	max_free_entry    = (mode == PACKED_444) ? total_y_free_entry + total_c_free_entry : small_free_entry;
 	buf_lh_capability = max_free_entry*time_per_byte*32/16; /* there is 4bit fraction */
 	max_scaled_time   = buf_lh_capability - urgent_watermark;
-- 
2.34.1

