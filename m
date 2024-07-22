Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45C3C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 13:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E24D10E48C;
	Mon, 22 Jul 2024 13:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VqLWRrt3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6486310E48C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 13:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaLTQqfZo50XmNMFP+VaX8dMX6T/0BtQENJAkbVPLisVCf+E9vMaOx/qVw9bHAnVKAYMLY+Zya85hK466YxfrfZm+jZwmz277iGH75H2alAHaohoIIC4qGqxefk+5gzw/3LfaoIVMLPOiLVWJ0s+4jJes/5lBlvCB4VgZZtk8v+tfxFfBEGcI4Xiy/s/kJMWYewbdAAb596IompiE5YJepCazuKD/gxD3QcouL/Wx0gLemr2VVJuElN4nybR5K5+3xT3Am35bSZ4S1iex60ju5U1SZKlNqycBDkPQC2FFgWHt/rIOFE47gufmV+kEgIIevEsr3Jzs0rEqtXVma3dLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRUAGrDkIa1VfLgmQeEdjJzPufJkh85pGIMA7WkqMY4=;
 b=ZgX49URa1epPVpNmR9EiO9EexRnBk2xO4v6GXLiVzqkh+dUroeB4loX4FZpLb9Qa5ZntR607ZjPy5ckFV1aDSYFwpaEiRmdN8BWEP+uSTmVz1Ua6sz1qFot0SZw7vCT1Raw8NuRJRRz3f2RbrklafT0BR11rGerua/FOW2rzhspJysRJc9xnGfNHbrWKpXmX75crYkJQvXTWeKyyw0twiKcEL32ZxptfPQPibMwzfwpZwBmC3qiGedgAewc+9gTT/dHDxwMFqopI5p6djAUiE9aaXk2HqnSAWioMfRdTbrABP0cfMbEjWjGfOsr92N4+fcVWSwDRPy7b6xLKmsu9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRUAGrDkIa1VfLgmQeEdjJzPufJkh85pGIMA7WkqMY4=;
 b=VqLWRrt3cIwFI4R18inkXmagu9xwrohELOkrO/unKBXTzg43tlrteYvxvO7c4961+m3OLN9FksjOmW04SwCcgUe1rDBb1+ntagZEpidgU4KhC/oaLs4UmdAO+PaDFbOWOeoYwPUhBqMynEhvoKaxyCAYf1xl0gdu53LwF+6IMfg=
Received: from MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::28)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 22 Jul
 2024 13:15:39 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::42) by MW4P220CA0023.outlook.office365.com
 (2603:10b6:303:115::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.35 via Frontend
 Transport; Mon, 22 Jul 2024 13:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 13:15:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 08:15:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add kdoc entry for 'bs_coeffs_updated' in
 dpp401_dscl_program_isharp
Date: Mon, 22 Jul 2024 18:45:14 +0530
Message-ID: <20240722131514.4003098-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f20c42-e862-4a56-21ae-08dcaa506124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7PybTS3vbO4Ep+ma6qN6jUoN4H32B4QKBBz2DjEUpN1SaeJochh6fF+DmI3s?=
 =?us-ascii?Q?N4ddxp8Ki3/3IXVxL9H4SF+jtE0gBtE8cyJfD3dRkCnOQFIVmjdwwscZr55P?=
 =?us-ascii?Q?TT34wlxbeDj0UwTCh8gA6sTGlwznj8wENzCXNGbOFBr2sEt1UpP1oKQ4FURb?=
 =?us-ascii?Q?1lmQBmHGMw3IzsMBcQPAlwMEOxRlah/CcvE7LAZEfZ/HIj1i7ZSYsKHhsCcI?=
 =?us-ascii?Q?WPM867aFNRRQo1d4s41aBnosSicmHfyBK3ylsrknxBGK6nHKQ1cQNq9KyXv7?=
 =?us-ascii?Q?m03d1y2YahygKMbrd+TXJxYT+MrBw93Gl+Vhsv2VBBPYWlgII9a70PlO1M2X?=
 =?us-ascii?Q?E/Wo9/FuejEJSmlyMO+dtLoo8gl3vf6JgMdaE3fFh8uh+ScX54nF8xRBewWx?=
 =?us-ascii?Q?MjPI2/+xzH2gFfuCDOZeN0oT3HA8beTiRpF9mmpZxVaUHVSKjXRMcM8U1GTT?=
 =?us-ascii?Q?wYgt0OGDrJlY+6jHDmbAv/qNdM032r5clqfQbcIIAsiojjY9cFZRjUyTDwcE?=
 =?us-ascii?Q?Lg5O8C/wKz3cTQ0bHW2Oj60Ssk+FeoSKvjNwolY1OjouCAWV0ZLp7vpLw+IU?=
 =?us-ascii?Q?8hzIj80dtGSw9f/3zGqLAzRBKLXVSQSYMTCmdpvj2LbsDQS8MaEvlXlLceTW?=
 =?us-ascii?Q?KKjulc0jhDAIfjytH2JfPa7RNGtW/TJQbNMuc1LbY7EkznpSWbkh8gIePJHF?=
 =?us-ascii?Q?HgF1YQ/05PF3FFKl9qhPeNhgy5d0aUZDfX3mRlYVAGjPy0Si1HHN1iKIk5D0?=
 =?us-ascii?Q?UwNRu/YCuRZ9SOZPaKI/SM7ZARXNKZfo6STnijkMyUqnpDvR0J4gzdxLLZcc?=
 =?us-ascii?Q?AFDIqKnKiWDgeQ28uhQ/gsi//kBuZuiQoJVvQTYB1Ow1+shUMDWYPDtTEEMz?=
 =?us-ascii?Q?mk4/IPae3eKuhQxTjoK11rUuL2814P5xlz5xKbRwdnvlc8UHfctJd/uxyu4X?=
 =?us-ascii?Q?sgOWiJmpIgjGcmhGSVWj4qA2LduvIKJwTsOB4q1Am8HYFOFEE5dM1mMqbV3W?=
 =?us-ascii?Q?GnPz25vDwxJhv1TqW7Nwtj4XdWZDFbSggTsC53BqXYU9FRSQI1H3E06/TtUh?=
 =?us-ascii?Q?Y2H2r1S+IORF6I+3aIfA5cBm9fj3klbb/A4nXIegwWUOMbQ353fvo02aYgFP?=
 =?us-ascii?Q?Rqf32wDOP6yoMgcPHbx0YLc3k+T2N5JQmYVSBUWjxXqIhUdaNzgExj0ei2nT?=
 =?us-ascii?Q?mkhdS3vTVkNyHfmAJbgFME9HKy2JUvTcZgZGqzLdvwBTGc6jtMHmb2AUExG3?=
 =?us-ascii?Q?0kBkXFXYCbSXx9QnM1Rv/kk+J1wu7tRAOih0gnVlYhtUi6k7yzP0pooZACyN?=
 =?us-ascii?Q?JwYaIFgFhXOJJqU9ZyiqlS4iqUxDruwPSbZiWHRLUBaNdIaMsY/bYZc02dUF?=
 =?us-ascii?Q?Dd7rc/gZ1zUPU63fQ+bA+f70aIN3muigHvSW+c+uArsklG2MoPR7IWex/MIV?=
 =?us-ascii?Q?VO+Xua+/r0ndv/g6rD33uimmrQEXICd+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 13:15:38.2225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f20c42-e862-4a56-21ae-08dcaa506124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:961: warning: Function parameter or struct member 'bs_coeffs_updated' not described in 'dpp401_dscl_program_isharp'

Fixes: 431ae65ea4e1 ("drm/amd/display: ensure EASF and ISHARP coefficients are programmed together")
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 703d7b51c6c2..3a3745597f0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -951,6 +951,7 @@ static void dpp401_dscl_set_isharp_filter(
  *
  * @dpp_base: High level DPP struct
  * @scl_data: scalaer_data info
+ * @bs_coeffs_updated: coeffs update flag
  *
  * This is the primary function to program isharp
  *
-- 
2.34.1

