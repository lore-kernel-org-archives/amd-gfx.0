Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91EACF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C6E610E9A8;
	Thu,  3 Oct 2024 23:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cN+xTeId";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F16610E9A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+HP1Ow6JVKByIBS6O5DNesWmxfdawgU0VqofMiSjbniPvt1wmAaSN/DTydFpL4HobYhHgR4lyfS/OuXPqzIClJTi0Fex8FRecgt2zB+O0x1xyIhB/HUHqhmAYn7v9C8h2VZJKKhVfsmGcfbqqDxrhih/V72/3dNH3IJeH5nK5MqJmnOTq3RPw4PGWrpSn9c/b2+/g2O7Yybt0Jlh3LIqS/OgWD363L6HBzesSag76AMEtIDfrO+Z072fH0hcB4zUTL+oRiUzc2Piuh/ZF2hVBwsuzI2gGHJfQ1c8JPoIvdDDSDYSMeG2+W6Ty9+3/KFu3TaPiJNO2XZJThaE8pJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtKt4e5qCfaLDypSmux7iLAnK9CTZTljDVc5/9T/OLE=;
 b=IUAJW0I/YhuSG3iIZ/tLAWSIRnPsHtxIv8hMyX/n5yg0m2K5a4vkQnNXg79jOBhgogLb/neu+aKax8vavGgYYelLaB8Israb7ZD7dfX0o74g1Yz5SFvv4qY6doye3970oulQv4S+B3C/CGtUXB7NamGB/Aa63SavfR8wJjgJcTG6xZnCpufqk1V9qs6XkB48G5/foQ0m++iv6lsuSvXlSyUq5RAJRZKXQYlPCVsgbgpANXiFlUliP986Ce0qzZ8A2V6j7BXjmHC4dsYD1y0GaTKf0Q4ZZqmJ5NC+PXbz7T3YEgevdB8U1lmIbHzkpce1VudtWlE1d9BQcFX7smu6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtKt4e5qCfaLDypSmux7iLAnK9CTZTljDVc5/9T/OLE=;
 b=cN+xTeIdgJ30pSMzAXZ/ZJ7KLqqf8G/mpZ667SBjxLW7B350Wy+LAq/e7y7jb8qeMmtCNw6L71zFGMLRcc09iGOMZtY42Zwwt8cM6s7e/S7DrY4m96buMQvsHfLXvWtQvyqpk+irk/vfztPKDpJXDz2O+tXsT5YmmzL0bU0srT0=
Received: from PH3PEPF000040A0.namprd05.prod.outlook.com (2603:10b6:518:1::51)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:35:58 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF000040A0.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:57 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:55 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 12/26] drm/amd/display: update sr_exit latency for z8
Date: Thu, 3 Oct 2024 17:33:30 -0600
Message-ID: <20241003233509.210919-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3ed0e4-e5ce-4a03-d18a-08dce40421e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k0pR1C8T/UJwxQkOpUX0jVbHYEpLR3Fdjy+axpVIGvmqMCCUFzQTFLYYQ/lZ?=
 =?us-ascii?Q?2iQANquNozwUM20ID1XMP03pKsGAgnfHD5uyJyjPXdMTk9qLX9w8rM9M4Y7i?=
 =?us-ascii?Q?m2lqq0rIEQrEV6pv+C5cpqrBFxs2xso5+VJaLov4S3Hw6G3/gWnrZbadmILP?=
 =?us-ascii?Q?3e4pCI/TKfUpUfbDT3K7DgVOUedVZUhzURJQXfuQ0nrf9gYlMBR6Pq1Xsl5h?=
 =?us-ascii?Q?HZpNgqbmWK0ECwPjPfp/RBSyAX9S+ZUnfn1YbnxSqqEuQTVxJYFdH7Xt8C3S?=
 =?us-ascii?Q?+pKG5T8p+FDtZq7tYtlKQB8KcFj7o3GpFNoEGOhpCJlFiTJotJ3h1BU5L+/h?=
 =?us-ascii?Q?Ad77vIk8MWPT306YXFIeU1UPWjdSf+Nq/P6pe0Gmd9HOhWt0z860T8o8OU5f?=
 =?us-ascii?Q?jNo9m8IEDKO3bsT3RzlThxXyygjy4mPtNt8z+x+fd07fz9na+Je4a5mPmjcW?=
 =?us-ascii?Q?5HQlKvD1yl/Mt8wRDBRYcxWjSzAbfmPCitG4QnF3mL8tIux7MEEt1YyF7Gpa?=
 =?us-ascii?Q?jhJm1JvMiCSMC5GMnaMKZqJoxBeihwX4usuwrdcTYWbGFwqC/huOnbYNdqmy?=
 =?us-ascii?Q?oPsheGClpamQZ9CI3m7Gp7pNhXqDmaIgtnJNsEEUnX2DqkWGJ69oZ2AiPacJ?=
 =?us-ascii?Q?vaoK1WyE0ECn6ZG6VYtCTTFAqwL0KkIYvN5isJ60Fi5or1YHstGqlgT0tInn?=
 =?us-ascii?Q?TROSqDWaDVm8d3NQWewq4/rNynglOInuO3sAFGfBqluFWTclEH/s1TLIZo8n?=
 =?us-ascii?Q?MRWzHBZxX7Kq5XvhRpF0jqzJVjDdJRtBZend4TUVElV0rbmxkN0K/JYXAb4K?=
 =?us-ascii?Q?Kojhsme3f1WHaw0BkN60c+/VC8jagzt44OEi4azZ7YeReBqMm/QHU63801Aq?=
 =?us-ascii?Q?jREe9aEkF/uZYwJjteJ2Pdf0FqslOmSkfoJTgd0E49IDi/oFCVFGLXz7VouP?=
 =?us-ascii?Q?xsSh6k/gD5iQI5MtDL94NLsqEjBNRxBWVYs25aJ2dE+meyOIqBeiiNQMiJFq?=
 =?us-ascii?Q?/nRj6i+tQkomsPdGiukgNwEN9lqSSRnz12bpXr55XgU0dbRqQdYG18GAxh2B?=
 =?us-ascii?Q?ssvU+vy4+SR+MZMR7jU8hhvxEFD/DkijulamhEPr4vaB6rbH/vAtkGpSfaU2?=
 =?us-ascii?Q?JXvcXJn9bfMwk7/GeMTVuQQiv3nus0Aj95j41MqfQim60fT3UoUXBo1d67lE?=
 =?us-ascii?Q?hgogpmuZvwWfJyC348v/uGF6PhAgys8Rnn5M5zuArSJflsQWaYwa1T4CTRK8?=
 =?us-ascii?Q?uuM3/3ocTXKOISp5V+MIUWVhrThV/a2Bg2iesmKoE7HWPmeuxuRbmX5JROpy?=
 =?us-ascii?Q?Vbjqgd/Cd5PxY4Ikq4uXIj9ByYlI2OH+KkRizdEnGYasj4tMhB276ePDnklu?=
 =?us-ascii?Q?Vor2N9E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:57.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3ed0e4-e5ce-4a03-d18a-08dce40421e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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

From: Charlene Liu <Charlene.Liu@amd.com>

This is based on real asic performance result.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index a201dbb743d7..d9e63c4fdd95 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -204,8 +204,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_51_soc = {
 	.num_states = 8,
 	.sr_exit_time_us = 28.0,
 	.sr_enter_plus_exit_time_us = 30.0,
-	.sr_exit_z8_time_us = 250.0,
-	.sr_enter_plus_exit_z8_time_us = 350.0,
+	.sr_exit_z8_time_us = 263.0,
+	.sr_enter_plus_exit_z8_time_us = 363.0,
 	.fclk_change_latency_us = 24.0,
 	.usr_retraining_latency_us = 2,
 	.writeback_latency_us = 12.0,
-- 
2.45.2

