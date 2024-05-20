Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB83C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 18:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA8210E849;
	Mon, 20 May 2024 18:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="In8Si+bL";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E159C10E849
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 18:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSLwod/DdTJ1EeVmpuoRtclJfPGwN6QFRKpIhaqMft23eEuF/uPmRCxnWB1DQgiq8y2aflF7i6WLZqXGK6XLpQNHzHETUIhsS9ZD1A+Dn2cOnvEYz9ZVRpYd/zbzLoHA7r3SaeR3sXjANtqtL3dyNdMPBPgMgAJ5nshr6Ns+kE7Xk9RJIXgcOxF2MVdBENxO+nz9dBkTEh1BM+x+1qSesAx5PyRd9jsmFPMIe+ndkSP5Cx+ekTIESXUYceYq12gExVDZ9WcWhj+h1Xuy9y0PZ0AeitM7fbqh3ui1UVu8YU/l8mb2DKNtk1hrTLtFUdMdKn4FXalFcwvbA/srGUuO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmrqJNg/riKpFEWDTCdkWsqHMh3VGXJFtUGMuonhO1w=;
 b=fOCXCcwKhA5G7FkPfTM9ZDT3IY6X1I/WzMu2yZ5t82CnU1hNKl44QaV/FH139RS4HTiUsrTpQicf6W1aWkdh5bKd462mGrJRpUweu5Abes+82uKD0sqETIdpJAuiS5xx51qvWaq47ZDWAYne4YwrKk32JPfjYKJdViu2kn9XTXSC5A9Ce5azaw0Ld0zgDs8YQggDDGy++rGOVCPl05YYUjrXtiTfHhXrb6rOS7LtofqL7+nWs9RqtvoL51AUKSxBU2Fa0eHuIDCipefgosGlhTzqZIMzLLIsE4YCCacmvbasIg/RcRcpf2kXeaUrDxiar0t5kGyD7Ml/MXx6Sdsgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmrqJNg/riKpFEWDTCdkWsqHMh3VGXJFtUGMuonhO1w=;
 b=In8Si+bLaErjnxGFOnZ0QBlx4yxWs7+UpHkBV8RpAGJrEM33nxc+gcY0JHykzdBE6vFkHfUK8DClzH4CiI7AivFQnm8JZOwNkMumQCjfyh9fmhWvNdSTGI4LtqVjJe61Ic3AWDwV3cTGwD+pAR/lrj4ta7ER+VWDTdkHVg/HTzY=
Received: from BLAPR03CA0154.namprd03.prod.outlook.com (2603:10b6:208:32f::28)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 18:45:55 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::62) by BLAPR03CA0154.outlook.office365.com
 (2603:10b6:208:32f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Mon, 20 May 2024 18:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 18:45:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 13:45:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <feifei.xu@amd.com>
Subject: [PATCH] Revert "drm/amdkfd: fix gfx_target_version for certain 11.0.3
 devices"
Date: Mon, 20 May 2024 14:45:38 -0400
Message-ID: <20240520184538.2711265-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: dcda5b8d-742e-4aba-c4a4-08dc78fd1469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9KO95Y2JKmPvHEh8yRD+x+D5pdZR2oj0JuBy5z9RU1VIQTzdNF9AUPT47gE?=
 =?us-ascii?Q?EUcHda/nr7d/F+Vw8Jipfa+BiAuAJAqjK4L9awXm0pQUb4lNSDsNuGL+S5GX?=
 =?us-ascii?Q?K1+m8XGZ2WOdYbOhvfis1UYDPbXwTmUx+GuDJOe+ckKRCRk/uvkPqZs/bqO1?=
 =?us-ascii?Q?c1gqdkT8Caad0nzugsVb7OjdKGvz/5bOe33glV4DP0zXXCFMdgDS/M5lbDqd?=
 =?us-ascii?Q?gOnMaQeCigt60bXnaUI2SeakPtLchihIw6gNyghZ/Tu69q6IHYOpTfQ7IC6m?=
 =?us-ascii?Q?1zXGPU8HiISUt1pXwqVreFI17ndk/kvV2AxPpCT9EIuLVhJCGI28N/NCUodC?=
 =?us-ascii?Q?wrLPHQXiJ1jSGZchMQUkBMPaWfjuLY9gA4p29UDrmuAk216r6xGtHMhw0YxI?=
 =?us-ascii?Q?PK3P/L6mH5aVLuyhBGdglhYVrdAdwKmXeBSn+Nqlq5TlTENgj39X/BQS/gVl?=
 =?us-ascii?Q?qp+KAPJ2VIGnAeHh7Wl1K+U+1J/dvx4dqj1BzT2XmH6zy7VsYJjK4J0Ovx8J?=
 =?us-ascii?Q?70SgCqElj59V51hAjsjvcn0y0X7ryvlyHCUVndqchkLeNcJe3ZrBRJse2n9l?=
 =?us-ascii?Q?Vr/OWd7dPTTbE0DkwgsDqfkZcxxhV87a1b7BuFL9zmIeTmvHx0YuHYhT047d?=
 =?us-ascii?Q?4I4F6Jw9dZMzjnJc09MuauyRNXatabA8Ufi4KzTUWHtgUWJzfHCoQFLib98B?=
 =?us-ascii?Q?riceFA+/W7YSNOGBfMCmrSM62Nq6mzblbl/OTS5GQGANTvgJaMSnZ/ZCZtdd?=
 =?us-ascii?Q?PhzCVtxAw8GflyPq1TyevV/CAjFZJLAj0+0eopwx2SvqhlBDNjdyW3SGASSY?=
 =?us-ascii?Q?mWQuihV3EeGaioy2Htc7E6Sv608CSNAJ1jcjnoH9WxA5o+77Ukspa8wHeQbi?=
 =?us-ascii?Q?OD/SFi64ny1vcQy4BnBkY3XJsVKTzgCAqAMROuu2TmcntGMHNEa465E6tjZr?=
 =?us-ascii?Q?0xj53VtoCUU6IGfgkjQjrQQNihiyP8doE63rOalYOPF8sJ+GFOUEZyWEfQNi?=
 =?us-ascii?Q?6VGJn95uXnzJjsvwzGtbDnJGRjXoFfvZ+XuX26BAtpgMVjcvtqImDRsjTZl9?=
 =?us-ascii?Q?xXuQEpHfRne7wFxTGqAF+Ypcp7/iUEHKUUXHi0jH58zE8smQUqlFGJa3im/X?=
 =?us-ascii?Q?0HUj0PHkzTWb4ayJMiBWABgn+J2UDIGn/I62dVpWaGLYZDK2SpKk2zJjV919?=
 =?us-ascii?Q?6Qi4XGwBYUEOHYVG9vnftEPMJxtdy7zvUYKbqZbe2I9giihsZrudcJbCR5wI?=
 =?us-ascii?Q?yqlPZSH5H+jiNXXUOGtiLVnWUtvZLprBr3V/CSB8P1qBI8ym6NoHt+8E06vn?=
 =?us-ascii?Q?GhIfqEwGyFZ7Iayvex1/6IhojtWwerdYYCNp6XITEA18KqKvkQCSXBB5fuip?=
 =?us-ascii?Q?StUjZGQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 18:45:54.3990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcda5b8d-742e-4aba-c4a4-08dc78fd1469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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

This reverts commit 28ebbb4981cb1fad12e0b1227dbecc88810b1ee8.

Revert this commit as apparently the LLVM code to take advantage of
this never landed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Feifei Xu <feifei.xu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 6b15e55811b69..fba9b9a258a50 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -426,15 +426,8 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		case IP_VERSION(11, 0, 3):
-			if ((adev->pdev->device == 0x7460 &&
-			     adev->pdev->revision == 0x00) ||
-			    (adev->pdev->device == 0x7461 &&
-			     adev->pdev->revision == 0x00))
-				/* Note: Compiler version is 11.0.5 while HW version is 11.0.3 */
-				gfx_target_version = 110005;
-			else
-				/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
-				gfx_target_version = 110001;
+			/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
+			gfx_target_version = 110001;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		case IP_VERSION(11, 5, 0):
-- 
2.45.1

