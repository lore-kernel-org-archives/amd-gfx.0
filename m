Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B353C27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 19:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3318D10E706;
	Tue, 11 Jun 2024 19:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y3z3jONv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B226D10E709
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 19:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJq9TfRK4D59U2NjwWMXuGM1tWN3DsaOFzNKjcRPYUTs9R5hlnR+vJiDvVxZSj+cWMxtYUtwmMDeBtuBhHUzQpDiGLSmuCyWbRfD+0AlRPlzrkWwq6IFGtwkIWmKzBC6zzzhBxmwsxYgDkEWj2dbnRFOIOH3O1izBkYd5I5PkUYsWFbVbY3Ejssmt0yRuBZUtQuMdrLcgKBnIrCYKnYAWjOc15VWH1LRAOGqx8dcdsewRwmIzBAm/znIK+qJR2QjgPxDD3mTnLzJbEj1G4O6nvXgFFU9UMlfVEMZbzrOaHJKMtWhhlBNUzrTXbNp4m9oYic0iqmxpJW3doMFVSDtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc9DLIc7gHStqlcz7PViENVB5lMGoQrHZ8eAbVFtm7E=;
 b=duLZNqeIeyngGfAryo+Dqdx7oMBWiMdVaK2rS9FrxfpQC785WTWHARxUS4CTSsqSdK4zyrr964ByzpoaL+V0d0TyRwks3LdiX4fhM2r+ZzO9l9m4RNJZC3TFpOD/Gp68VtVNV5QuSr5fUSfLzDj5H8YGbmpGQxaXlY1bmrrKah7x7kKELYo2xC8BaxiHNdncmclc3yhudgerZgMJUURZuMBo/+o5HKyypsMiSS4bokgaGZWxZdbRSPJcf1mgz0XgHJYcOh0VTD+ukb9Hh1uZ7XfMbSes0UX1jqUl0GDj5EqLhJj3iR0oXQnjQmZMsrKyKIVCE2pjVsipYNVNBp5Owg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc9DLIc7gHStqlcz7PViENVB5lMGoQrHZ8eAbVFtm7E=;
 b=Y3z3jONv9/HCkEy7lF0zpDjO4CjY2aAQIxfzcOc3p+JTo4FhJE0Klj/9xgxH4KWkB0KaZcFr4GKzou1NjLNimmZsn7/f+iimg7fFABxSWJglnY7skJyJqBNifESzh2mxiVHPkp6zIcNA4gl4HVsCx7QQ4Rg+eJGgF7MR6d54tpA=
Received: from CH2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:610:57::35)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 19:23:32 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::36) by CH2PR12CA0025.outlook.office365.com
 (2603:10b6:610:57::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 19:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 19:23:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 14:23:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 14:23:30 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 14:23:30 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Enable idle optimizations on DCN401
Date: Tue, 11 Jun 2024 15:23:29 -0400
Message-ID: <20240611192329.1983538-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 09eeb59d-3f1a-4fe8-962a-08dc8a4bfb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c8b+jXjibgwkQqkgutx0TDLth1vqv0besQ/ckZBdCJUHXhC1cKEzDlmkhiaX?=
 =?us-ascii?Q?Oa7nX2IxDilYAIYklfGb4jFdH7bAeq+kWopev6ri8QMZLeJ39P7ksOaTIax9?=
 =?us-ascii?Q?M9c1dOr1CN9rLmkZay/pn5D9gNAza3i3JKAAMLSVvZk0lCm/NkXyX2TIMAeb?=
 =?us-ascii?Q?3g9zWCnO9AbZzO3xMuiBj1BVO14hXKPMSoEqRwzXLUZZKHnJtXiU3wJTyUj6?=
 =?us-ascii?Q?FVMAsDXxY/VEIEN2hvSZvKjAYxofmkkg5IiTO7DV18MpSuVp/h3JGlqOvL1h?=
 =?us-ascii?Q?SniCBiDvazGzKKX91Wb3yblAeaBx9UlimnA8faBrrPoXirfhIce2OgFMoIPc?=
 =?us-ascii?Q?nIgFXQGos3BsoJHyOiNj9RYQEDLGjqwVljLraFFKUy2N+H5qgrupTi/DXdSl?=
 =?us-ascii?Q?oghNe7YJI45GorGp+DHwkH9gMH8S07h9evg9YAIJY1RerQnYt6Mak+MkR6wP?=
 =?us-ascii?Q?0vdYtONBH8P553j2ssm9I0cW2Hjkj4pI2tbZpAvc0MsIZZGRwDanHrAPr5S8?=
 =?us-ascii?Q?9JiGsgoJg/NQzNPy5pzKQxbNN4byoKphgO12IkmzQuNqrnQSctXYzimSs+r7?=
 =?us-ascii?Q?go94xTLjGTJDAyujjC7YXhHar4X9xTBWYi9Do9h6miW3VwmE3MK6HyNZ3rY5?=
 =?us-ascii?Q?dhVhC+Ra88rQ3ShZ217Qij5cWXQeYQdUZa1zBE1Bpz0CJvmdrxQGOYC8Rpqj?=
 =?us-ascii?Q?N5FzvTEe0sASkKoMXPrfQjddSpRVTwgXDSEgSg8IkOUmUzw+/nJL/IWoLmSt?=
 =?us-ascii?Q?hKkiZkcfaMHzWgBYZFahfWi8TIZ67obA2co6cc1x7BlCGqiixSrXqSvAE3gD?=
 =?us-ascii?Q?Ui9UNcOZC5nSpQASaIQwWwweRr5ysFztKFjGPXT8cGek+Q9LcbJ9DyblZ+au?=
 =?us-ascii?Q?6ffFsM8UqJ06Tro8Z5RJAgyazZYIAqByKwN4YcnJ0XXklgJK7pmbjy1D3d33?=
 =?us-ascii?Q?zk+jN8e1sV6WrPaCMXVOSAzYw8gWwiC/rm397e4yZEboi6nqCjlIt1H9vK22?=
 =?us-ascii?Q?PhKaBVkhcXgq3SMohodK6vbN0W11IID2MhWkHmXXfKmxvapj+FKUGRV6oRjQ?=
 =?us-ascii?Q?Ny2Rt0CahFiv8iKb1WuQ+d9Vo1FOgdhyaTmRw3F21UTu4ygBF0Vtl7cPzAhZ?=
 =?us-ascii?Q?z9vdC6fc573uFolEhb5663ASIOsVIbVcgRa1uJoGM2JioygPox6pPJl38a/8?=
 =?us-ascii?Q?qYgsIoxMViz9IzrFPpE5hZkC85BOJTPAxrjsz1n3EZMhU5SD6cnG/BlIl3Zu?=
 =?us-ascii?Q?8NBtZWS62LhUtRVxht2F+rKul8Wc7OHSmXIk4p6GbTowaODFWQZLI4QYK0sJ?=
 =?us-ascii?Q?z4ZrERvoJOkdG6AyGb2IYv2KaaFibwhSAuIZqQc+/T1CGKHirHHoAxMFYdWh?=
 =?us-ascii?Q?PG5duNUJPj1bLFINgU4V2zKYdDArpX1sZ0ICFCSYdb7D0A9scQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 19:23:31.6082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09eeb59d-3f1a-4fe8-962a-08dc8a4bfb0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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

Idle optimizations were disabled due to some bugs which are now fixed in
DMCUB and PM firwmare. Enable these the optimizations back.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index ea803df8645e..d78dc63f82fd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -731,9 +731,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.force_cositing = CHROMA_COSITING_TOPLEFT + 1,
-	.disable_idle_power_optimizations = true,
 	.edp_oled_no_backlight_enable = true,
-	.disable_boot_optimizations = true,
 };
 
 static struct dce_aux *dcn401_aux_engine_create(
-- 
2.45.2

