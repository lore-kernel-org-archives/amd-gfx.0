Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFECC27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061D510E6EA;
	Tue, 11 Jun 2024 16:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YFwmJjyI";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A7110E6E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3RqduNsC1CON7zTLkClJj3lQYAaBUcR+AGtK0FkAFWURedxvOS4Gc+wH9ElBnyBTSIalFVwq41smpKEhEc1s38n79D/4hexkKJ/lFPEUKgHozxhPVTb0je8omSI7rzszVnX6Gh+tro+mQ/gMsZrdAVnvmrBEo6TTpXzsLsZoOMaY/OIdd8imYV6KfqWITtfuSgSbCs0HpoBdG1u9Sr5dVicIft6Ptv6UyKnHlOjvo1Jsz0Yz/MK34w/IZTcpkSeArIeI6vUN40iir3TRTH+PGJRrFqbQt2/MmFNE6ItCnOTOFs9iQ65AbFk7nZc4usWbBN9fLnNeogPwXb52kNYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLGh26hkn2hE3caJcBOKXVyefEzM4FXwdmEuG9zFrrk=;
 b=byxJ/oie8cpoJEiCHbY5L8xCC3xYF6QBzTqH68d8hWRj4S9tNZ6poMPiiVt5JkUfmG7Qan2AL+ACISkQ9K9yJge5VCtE18CwayN/vrJYkY12ck7aqzWSkJPsuDx1iraTxs/tL2HVzSTITu3pijnhH8htKF9kTTFf8SqSG39uTmr4nfy3Qfo9I7uJhDDmg5f0fm3uNxKCwH2wP08rZIebui35mOLNfB3fgu5+czMRWDENJawfLx/ig7vQrdc6o3iSnRVydl6fh/O4x3HmTAMKRo7/aqNqJpe1wdrWgBH/+yU0c9ihZpZb7jeK7ckPPz80b5I2iV5oSDLRICjCMjZlKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLGh26hkn2hE3caJcBOKXVyefEzM4FXwdmEuG9zFrrk=;
 b=YFwmJjyI/C05Iq/WoivZyFtsh3Gyg992gA52rGf8gSBu2jgYJQzNpo860+woo3r/r2DtSkhtZIljpJrSPazIvwxXFuSa8Z8bN4QbwkLNGvWNQ1nhDBv974bsk4HDMY6SBxjMcl0wrEJrJo3PURJNq0EMTxZr6Tpun3CQEUbsC7w=
Received: from BL1PR13CA0164.namprd13.prod.outlook.com (2603:10b6:208:2bd::19)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:53 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::fd) by BL1PR13CA0164.outlook.office365.com
 (2603:10b6:208:2bd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:52 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:51 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 33/36] drm/amd/display: Check UnboundedRequestEnabled's value
Date: Tue, 11 Jun 2024 12:51:36 -0400
Message-ID: <20240611165204.195093-34-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: a33f4294-ca26-42a4-9c73-08dc8a36ef57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j3XH8el65YJxpo5y8+jSAvyQsjckCt2ITTz3tT4tpyX0cpd0iLQseiGiWJvW?=
 =?us-ascii?Q?qfRbXnYqT2RlX9GZbHgN7mmTM0mNiansZVJ9GdFM9yhpi8CGA7EESvZDZjg/?=
 =?us-ascii?Q?LFlghYkt0GSVKCYM+xEBiJMdUryDHFWVuFKFVwxWoE88sYyr7nkiJ2mctsnd?=
 =?us-ascii?Q?1pV6rzKIagSYslvCqKDvLiUzay+2mSuQpeAoYzUhvkPfCoqkvY8UQczMbBrz?=
 =?us-ascii?Q?EnHSY2PTiMEgKExIYB61pZiC47ReG31EVzYht2pajMHVlDsR5njS7eveTuvl?=
 =?us-ascii?Q?Jb7czTuIplEyNA41d2mjJ5anxwW7iFCqFpOLDgoUtE/VENmhMDx5xQzOFT25?=
 =?us-ascii?Q?BKdTqGea+oYlBo2b41EV6dLi2eFHmSygbwG2N12yD1kGpXMQNQccK8n2I7R7?=
 =?us-ascii?Q?TYcwOPhgkceKlnJY8tjED7850lwWgnVCptWN7PurAwOmm6KJZRz1AH9GMq+n?=
 =?us-ascii?Q?zNBoJd1rW1DnOSA0yTQA5e7UrE4ff6CseO+D6ayQgB6VE28OuiFfTuJXwxb5?=
 =?us-ascii?Q?iMJBhhlblRCBRRCoWE0V9FCZD32qatYyrL487P/PyHtJR++BcMOc7DcjX7U3?=
 =?us-ascii?Q?zehBs3FATwMrJvZZDoIIs8RQQB/uEEXwWFSqF9suWih1IgOZabdoxkg+qNef?=
 =?us-ascii?Q?yjrht9BH8VGJxrLfNokHfYQNdD+/I1Kh3dRwQy14JpPqwmfciMs9vZfY+ZSy?=
 =?us-ascii?Q?45WWCjduEtB/SAs/7j+W1tLjY/HfYBNxeIt3JfGNW7BwT0NL/vlbB8826Ej8?=
 =?us-ascii?Q?YgCwR6UVk4QWL1sW9XQw36JDko9j/BseM6SIoQs/W5pNutzfYGA8a3JBngT9?=
 =?us-ascii?Q?tUWf6+MAGcQD466zpS35GIREXFpIDRiiOqdGJ0wrcw/FTb7nTdPPYenRYNC6?=
 =?us-ascii?Q?OAZKCyLuHO0D63z8hKGg/KoNxXRe6gUJbLVamatyFeGmK8/bJWdk0ALrIey7?=
 =?us-ascii?Q?IGWAozp5iTWoPykJksR/MTTe518yb4MUAC5MsFuTW9Eh80Hixi52qX9BKW3S?=
 =?us-ascii?Q?Qrl36VL6uLhfrUMgwgOXPaiHc5xJDfFBT8JuRAIFN4XlqQ6I70AfSD+8+Qo7?=
 =?us-ascii?Q?Mmb6f2rq7x9YCxKUHhFX7FTCCnvDULVa0ASaGk+tCo7724EqJhZNK+I8Tl1E?=
 =?us-ascii?Q?Bw0t1TjREXybGxrJe7eJEt9UDCmULFoZVQKFd9uWD5K6zfK+/865fgVl5C1S?=
 =?us-ascii?Q?QDwHwgwxyWypKamLgJkn7xZVoXlQsSma7GI5BM03h4CllEdyMjhq8AliF1NM?=
 =?us-ascii?Q?ddptyorBP/moAIB46HP/X+0kHiD+6VZG7QZGoT8plc/px5gZbesSUe+r533n?=
 =?us-ascii?Q?iQPMUwe2tyuLRYopBN3tQkEqWmAy4TprFIP7VN+gehSnEFHyuE2tSiOj53Vm?=
 =?us-ascii?Q?k28hbdyFf017D7SYD4fdJ3iuyXnr9L2qcJJq/gsOavWQ9orf2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:52.6538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a33f4294-ca26-42a4-9c73-08dc8a36ef57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

From: Alex Hung <alex.hung@amd.com>

CalculateSwathAndDETConfiguration_params_st's UnboundedRequestEnabled
is a pointer (i.e. dml_bool_t *UnboundedRequestEnabled), and thus
if (p->UnboundedRequestEnabled) checks its address, not bool value.

This fixes 1 REVERSE_INULL issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 791f1725b62b..547dfcc80fde 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -4283,7 +4283,7 @@ static void CalculateSwathAndDETConfiguration(struct display_mode_lib_scratch_st
 	}
 
 	*p->compbuf_reserved_space_64b = 2 * p->PixelChunkSizeInKByte * 1024 / 64;
-	if (p->UnboundedRequestEnabled) {
+	if (*p->UnboundedRequestEnabled) {
 		*p->compbuf_reserved_space_64b = dml_max(*p->compbuf_reserved_space_64b,
 				(dml_float_t)(p->ROBBufferSizeInKByte * 1024/64)
 				- (dml_float_t)(RoundedUpSwathSizeBytesY[SurfaceDoingUnboundedRequest] * TTUFIFODEPTH / MAXIMUMCOMPRESSION/64));
-- 
2.45.1

