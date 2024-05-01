Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABCCC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A7D1130BE;
	Wed,  1 May 2024 07:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1XoDJg6m";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8F01130BE
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2FX74CCi8CQ5iClwbr+f+OsdFEGAHuRkESzhTsiDnNa6oL/RY1HZrjcS2s5ZQmG6r1thXViryN0hRZ3+xs+Mmoi1j6J1sAn6D5PKUHGjILJorNMRNE9UN2ys/zYkElKtRWGv1r/rlrj0GGge+njfkxioTMbViqXno0UWBklogAlbN7aRv4eL8JTwQPpOZfHeQ5/wShNkFsJBFRbdMNP6nS0/Mx7zxOf5WudDlLIBDK3ca3Odk79BZCD45ymGVQqScd/oBHZX85eIYHGwodv5ER/CSlQ4Z5jLaGYg6zx3uTnZcgP7UfMwGvxBoL4/PV5AUIh5neZ1ZrsPAfG34VcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqnpuZhqvLefWVDWEfdbse7C+fzwoevvhiT/vQ227iA=;
 b=BmcOrh50n6LMzH0fvK9eT0QmU30MMa/CqBUGbz/1ecyBhqhW0QZaXCm6QsDtgTqzivN2IhOGTJJz/d0NRjbCgd+vi2ouMM5zqLxCFz26NT5Wntug9OMjgRNaMhfGTTk28a/r61Sor9U7r1wVZD1SHMhIg1J2FlC4vJT8XcyJjorxznUU01HBsUuWPQHPLUquJVTFQ+hCYJS8BIEC6DbRi+hsHm2/wcSF4ABikNVSwxyLNNHZq1oZXOyUd4rxLdyW/22nzlSlm5ipRDYjVqz7Way/9K3HszkIgoRLossZ23J5p/8Lm6KSOmdl0+ytSHSmAhDYOWwko1esAGLdmAeHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqnpuZhqvLefWVDWEfdbse7C+fzwoevvhiT/vQ227iA=;
 b=1XoDJg6mWJ3d0HL7qCuSdW2Rtr32OrDXxxuuqXYNFKRVT4JZEc1jIQWqOujxZQsYYA+YwbS80boKK0AJrs3lg58rz4T/Ike1dz9cDkJODyTsAHxKNh8vkqUhyEmO+B3VmNYnFvQddKolMIX4Cj0NACDjRU9k0gq8cfDi73efrD0=
Received: from CH2PR18CA0035.namprd18.prod.outlook.com (2603:10b6:610:55::15)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:18:52 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::b2) by CH2PR18CA0035.outlook.office365.com
 (2603:10b6:610:55::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 1 May 2024 07:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:18:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:51 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:43 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 19/45] drm/amd/display: Add missing NULL pointer check within
 dpcd_extend_address_range
Date: Wed, 1 May 2024 15:16:25 +0800
Message-ID: <20240501071651.3541919-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f316744-6f04-4587-5f0c-08dc69aef451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uCcFLsoQCaPnKAYiGl37zUG4rKkRjVzpnVM5pAHuQMpBmNBG0r2U1lnXDYMQ?=
 =?us-ascii?Q?7gqtL890++yTvrwh45T/skqKavnDi+/u6JZXpc87/6CqUnd6RGMQCRpiLotV?=
 =?us-ascii?Q?fVpbgOZfQkwiV5mCZnSSfte3MD6u4OEt6ARIl3I4XKR/d5SR59FoVdh29+mV?=
 =?us-ascii?Q?+1Qixiy2oVuwhl2N5SeRF6ezjHAFFHbX52XgrubSsCC14wiS+zDyWp78W0fU?=
 =?us-ascii?Q?plfidAmjgj1FhxaGRbZRGdKs8vTb0Onbw53FcdUeFbp0w1CT1WxxceK8kYWz?=
 =?us-ascii?Q?lCiXC/f7xXGjZiUNrYyINyxbzbtIRXhaKjM201KrquDwrtGwgN4sIq8HRQZH?=
 =?us-ascii?Q?sbqKQcbmEtS+AAMu9LQE9XJT6/+Dx13xMHioUp3DDzvne7aHYIQ5G19PR6Af?=
 =?us-ascii?Q?zFSQznVAA39vnnZS1FbSDRXi81TXEWQDkfyzvZN1y2Tm00Vjqd+6dkeRxiN0?=
 =?us-ascii?Q?8jE9xQqW6nALkFSkscYSOsrr69kpXBdmH+iKJLeFPyXMIU85wv5AM/2UvMPM?=
 =?us-ascii?Q?zprOB1EiXOpbPC4WehTnuG4X2KKM1+vc711+u/frbDhvOixY/Y9bMZNsaI0q?=
 =?us-ascii?Q?74D4NCv1COgdxeJHZdCc235HRuTO16k86bYjUOOFZnojWxYpRTGMnkKa/KJB?=
 =?us-ascii?Q?yWS6KcHgBK2z6+fLqPs3bh3C572mWPz0s27wZ8dxrA/vdEO2/hdYkvBTCEzz?=
 =?us-ascii?Q?IWdCFa4WVxyhXTgxUikqoV4z7ioe4uI1SGYkYYK2eQnTSBzpzC66POMfCEsw?=
 =?us-ascii?Q?/2UAmvN7jrQ8VLBUooBB4EdPfWzKPh8UbCfKBbe4fidjKPCEh2NZ19yfeG6U?=
 =?us-ascii?Q?j7x+6VDK7QF+3H6FpXrwfxwE9ZFlcFR6HdjdPiUquY4eLglrKWkFdfAQgj4N?=
 =?us-ascii?Q?jEIAmwIigS+o1E78MxLLfQyjG47Ht/CgDjTpysMEXeYlqCVtkspUM20CMjCF?=
 =?us-ascii?Q?BO4DksjAvAQ9ElU/Ri9fgRhGoZREG9I+R8+yc2fJXWGFAqv5dzrG9HDaptbx?=
 =?us-ascii?Q?95RYWxGYGh+Mu3B7gCbcS3HWuqM89rDJ4tQ5yrwJCmIaLPfyBJz3mav93S0g?=
 =?us-ascii?Q?H3FSL720wssyFHJo9PlH28C0TH8MKC4RY57CGOv7pSQC+0zYodMFl0jivBiR?=
 =?us-ascii?Q?QGsC2ZSmEF34GryWEMvjCIwZEU+tY/UWHz+r2XoMP/dUuRm9w7vJN4D+0A1D?=
 =?us-ascii?Q?s3Of3OL0HMa8B9BbHzdIIMw9+2Eg+nSfEI+3VnV7RUfAFasbMkGc/ji0s9T0?=
 =?us-ascii?Q?ksP1h3AlvOmSTzDSN/lXY8zquj6v7q0Y0DX+5fofIK8aFh/0lAxZY3CFw8H2?=
 =?us-ascii?Q?Mt7fohRm0E0NL1aGDblXkg/ZvMgJhPpt1eFztcgaSYBPLLSJymFuVzFgHPuP?=
 =?us-ascii?Q?2duUvbXZ60XpBGuhDVyCd4SoQVs4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:52.3498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f316744-6f04-4587-5f0c-08dc69aef451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why & How]
ASSERT if return NULL from kcalloc.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
index a72c898b64fa..584b9295a12a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
@@ -165,6 +165,7 @@ static void dpcd_extend_address_range(
 		*out_address = new_addr_range.start;
 		*out_size = ADDRESS_RANGE_SIZE(new_addr_range.start, new_addr_range.end);
 		*out_data = kcalloc(*out_size, sizeof(**out_data), GFP_KERNEL);
+		ASSERT(*out_data);
 	}
 }
 
-- 
2.34.1

