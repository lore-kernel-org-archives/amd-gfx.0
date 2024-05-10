Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCE2C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 08:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE6810E586;
	Fri, 10 May 2024 08:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qO3M2JxL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7030610E586
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJBNmtZnZpw6J1nJiyqXLekdQ4kC4/+BrqGobs2Qy/OhjjhexncKOFiUUZRgTuE18j3pMvN236dGMB2KYWP5H41BdgqjLLTsqaBr6n0yrc6TgsY7h6Db5ZJ8pLk0t8dRYxtjloygt91erNTmyhwQVaC7mca6saqd1wn5KU1TL3U2NxJEXeGi/MtYDV/QogExgZqVydXCtBw8S7UOTXCUEaFkWwwEbbRJ/EUFPFhUkgKTb57jCdvgsJaQYwsaIfwlb/5qLaW6gIFu+AfU0GjQlJTLZWhHxflBP7Zqsa0YQjjyo9jo5d4kCh+attTXrVhThgk7zv0b4SURW9lE0Q3sMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZx74y6r44SEmx8yH95IHI0bzJegC+QhBtc2d/bs3jc=;
 b=ZPJWCbJyHPh0LLNWOk+iSnzzbKHBpdkHiM0stMzwlQ8wBT+fKyz4PEh4WRBoj88tnsneYPg0Z/JSLd/tXqNZNae/rB2U9cTNiUcHtaMR/rm68z4q/dq99SYtTS2hksJlxOXsBY8ogB83VJ6jushANhbEafp42U3A8vA48OTgG263Mqwsm09htN1VPELxoBbwtOYKU1ZjbgxRrhoyu1cGEKep4k5XHBFz/giaPCmM5Ylt8ZhYA1YQEn0mFyXJRkF01jfzpM79vc7AqmFNBmf7pgDK+Y8+ozWHwyK5OJJ9YvDg5MaOeJcdFkXRTUwEFy5TUHnKicZxkEJVmoOPCda6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZx74y6r44SEmx8yH95IHI0bzJegC+QhBtc2d/bs3jc=;
 b=qO3M2JxLl3jphZB7bDdDhBnal5xqSoie9mUsDDyAtwkUqOpTf0AhzPlfxGjGQty6mFz5QEpALArPYOPrTIuqoJkDZFTyjK7oCEpO3NfokL6OePEntPniODGAzSP0drnNejfWIBIJQDQ1TcCVRLV9IKXKkNKMt06+7gjRwFnG+Q4=
Received: from BYAPR03CA0034.namprd03.prod.outlook.com (2603:10b6:a02:a8::47)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 08:26:33 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::17) by BYAPR03CA0034.outlook.office365.com
 (2603:10b6:a02:a8::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 08:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 08:26:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:26:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:26:31 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 10 May 2024 03:26:23 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 19/22 V2] drm/amdgpu: Fix the warning division or modulo by
 zero for the variable num_xcc_per_xcp
Date: Fri, 10 May 2024 16:26:23 +0800
Message-ID: <20240510082623.3500063-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: eca10be6-a04e-48f0-01e2-08dc70cae613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V3fF78+yE3QxNyVx6fEg5toliViAuLEFaldzJZOoaJL/qXDqsbUK20K5glBE?=
 =?us-ascii?Q?h32cqCLYkpvOl8lswWcsSNlKNeoYbv/EqDTJ1sw21SWHJK7aBYv374bqhDWu?=
 =?us-ascii?Q?SX3tUgZJFpG9VueZiPg0Dbv3JsHXk2pVa9koFnCg/0QlobHvqfxODbuwfl2j?=
 =?us-ascii?Q?DeF+vlXo3y9kbJjfXSb8shQw8uFT6e34ZSBch3XjRojUSPsbKb2t6r8hcCSk?=
 =?us-ascii?Q?rWGm1O5Y3FWcvdbDxeEHykGwbUkZySkXUeD2EXkgSRvpHz0uI2/ZdWO/s7ni?=
 =?us-ascii?Q?mj0bd0hbCeiow0h3GMeZOISUHDKFpcAbLiYAqLcH+15llEN2aEfr2wv/LFJC?=
 =?us-ascii?Q?IGL2qVlDQWvASwEAkrtFFJLimTvC4/eXwGXMxSqtHpCwaml07oM088MdbIaQ?=
 =?us-ascii?Q?yLwh+z/IDUJ2ewHsNqVPBVuP+kYWrFXILO2cSOg843i+yTsHu00DpOnwO4kp?=
 =?us-ascii?Q?1NtrQZrV49iyraHdgrIUJrRLqW7TbpLOBbEeC9bCkavbCDYhpzGbZHRq3VBi?=
 =?us-ascii?Q?605hXjdeQzP1zKlPJW1K20ux2+87iDVuCUfTys0aTOB5NGvVO218uJYrSftD?=
 =?us-ascii?Q?hMUQ4L2YBsAL5FNs7FGgHPLEB8Lc5tnlcs9o5+nBCORF3wETiNURtuH9S+KG?=
 =?us-ascii?Q?dOIskyYAmTvw3qui/R5bjzn07ZXfZVbPZNi8PYvyp7uQFnDXtb9B845qSd+W?=
 =?us-ascii?Q?f11y8gchaOB5DjutmZxSHrGnNcLtocaeEuY1O54D3/OjujRcU9TivpdDfqzw?=
 =?us-ascii?Q?Jid/NyOd4TJK6ivhZBYXxlSV9LvaUt5Bbo6RcsErzNJGjn2euWzJ1BSZExQT?=
 =?us-ascii?Q?+vwa8mXt94Qe9qW8tXIvZhbkkhaobR9a+Y/v6W7Ulb3B6hxeQz/USCPhvHfy?=
 =?us-ascii?Q?ePNX24+yANM0Yi8A/ATzO9djr24zw7bc/FpuI/TEKXY/vtckSQSQ2wypAwUn?=
 =?us-ascii?Q?sseRYRtdnKi0bTcIefdywl5jF059pJvbm7vXPywlDOELKZA/UieAsvbG8EDO?=
 =?us-ascii?Q?t0U23s5RDXlxpcsSIjmOA8stPOcTKnN6sk3oMwJrzpU8cd3OirZFuVvOH7cO?=
 =?us-ascii?Q?/FY/8ezsT/w9gyUWMqzv2uOSkufbHprOaWiZZCjAX9i6Ul3lHklhMeHaN6aX?=
 =?us-ascii?Q?AQILN1zNjb+4CP9qiQAzQi4MFgWUbbV4MnHBZJlPw2ZxxdatwLgbUHzthXPu?=
 =?us-ascii?Q?86/akMcqBrZ+LviGZxgtPdHj6pxwkFlvvoPUZ//enSrva5mc0UM3Gt6vAx14?=
 =?us-ascii?Q?874xFQQarTwc9oDEyIfmf85IByIdSnfUuzazLuoIn9mgviBpGzMsjErHvFTG?=
 =?us-ascii?Q?Tsqqy5hMEq4Y4VKED0G048HdjrdAFLSVnZbYcdrYiMS0LgV1MoPKH8k+ZIno?=
 =?us-ascii?Q?6kGckdYz3+yofbXeVInIczyqIXhH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:26:32.4227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca10be6-a04e-48f0-01e2-08dc70cae613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
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

Checks the partition mode and returns an error for an invalid mode.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:  Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 414ea3f560a7..b1c18b7a38ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -501,6 +501,12 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 
 	if (mode == AMDGPU_AUTO_COMPUTE_PARTITION_MODE) {
 		mode = __aqua_vanjaram_get_auto_mode(xcp_mgr);
+		if (mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) {
+			dev_err(adev->dev,
+				"Invalid compute partition mode requested, requested: %s, available memory partitions: %d",
+				amdgpu_gfx_compute_mode_desc(mode), adev->gmc.num_mem_partitions);
+			return -EINVAL;
+		}
 	} else if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode)) {
 		dev_err(adev->dev,
 			"Invalid compute partition mode requested, requested: %s, available memory partitions: %d",
@@ -522,6 +528,7 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		goto unlock;
 
 	num_xcc_per_xcp = __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr, mode);
 	if (adev->gfx.funcs->switch_partition_mode)
 		adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
 						       num_xcc_per_xcp);
-- 
2.25.1

