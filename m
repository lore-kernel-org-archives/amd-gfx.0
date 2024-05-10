Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046EEC10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F92410E104;
	Fri, 10 May 2024 02:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RMtVfEC4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044B210E104
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJWfgxETAILTRnaOgIYsrS+S8YZHiOxmkXnR0yvtMtDKVJb4qXFzHV6/fqnbOiu8MhcZu8ZbNJTALGeonram/zbQ9YulVCcqh/bbAplho4s863l2geBwPlORZFqOZeceHkr36BsvjYEuEKJ6wrZqQcxECmLCX3C5nOhPtX7WtouJ5n9XSACg1JBqrFlI/SeihGOawO4yOxfDzBGBXlvrZg4+htKLV7j7WTgodnlIV/wPAadY2BBjkxBV/bd6GsfC2KuhSgniLV4dk+spd0Nh4iZ92rtTL0vPQjOA8gkRqipGCoEZH/gZY3Dk+ADM7m+b+9+ju3u96KhHG+vsxe3btA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dlpK/ad1NnXSrek30aMw49eZluePGTtEVZVxg0xYKE=;
 b=FOYwvThbEAHZilzqtmRn71W0zX/O+KIMmPTjjEApoC5BSBrJuJJjr6u9rdiKvXRPdP3xf6NXLLIYcQB6oA5QOybLV23CiOX1HhDaxdT0oRnP9rQkRGf/FinIh3647E8LeJhJwV6dLObYn426nJE0Ozu2sz3pBkRDHJtO0ROfVgoOVkj5jWJD4DLqiLNDHMqMpL0WQvv5n5S13C/FWs/otNPmenBKSPT8kn3jMiitMf931IOE7kZbeoKNm6EYRQUTj0xgv/j7mJIukerqIPTpiS+lQ+mAUtFerUVj6nbr4d4aVjfcSA+9s9vcsxGRzc4SP7uH842w297A+2LPL4vSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dlpK/ad1NnXSrek30aMw49eZluePGTtEVZVxg0xYKE=;
 b=RMtVfEC4kZqFPGdunH9S3GFFAiOTfomI7inWtBD1WLR3nagNAlx4G1JvXmTb2YtPH50Q6e1F+xJ/m9tzpl5bSwL7VCMxIodOVpXuVF4tJwn3IAkXhAtQAAvSu+ejQo9FqEDHPyyIpVoeY5dljPRLAfRIFgwwU1NjEJYKEgpGc9g=
Received: from BY5PR17CA0065.namprd17.prod.outlook.com (2603:10b6:a03:167::42)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 02:52:46 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::2a) by BY5PR17CA0065.outlook.office365.com
 (2603:10b6:a03:167::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 02:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:52:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:52:43 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:52:21 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 07/22] drm/amd/pm: check the return of send smc msg for navi10
Date: Fri, 10 May 2024 10:50:23 +0800
Message-ID: <20240510025038.3488381-7-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ace7b4-5ccd-4a7a-9466-08dc709c45be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DG7SWApf5CszBS5h98l3Nlou5rvlSjsgKHtBlfq1UFnw+TpndW5GM8zsV7Hg?=
 =?us-ascii?Q?vUU62NXEUxWESlROEsvdb8GWv+kopbGF6jIFDbOTK0nYq2ZRQ3Paiml2S0dR?=
 =?us-ascii?Q?G5gpbRdo0cHwtg8oeEXYjSRKMi7gQMYhOVDkxE8Bm25Sl7ispwYbUmorN9zo?=
 =?us-ascii?Q?AVgF/T+7Qgv/Gi+YWYlREBsW7IgnifBHnJX8FMnPfY4bvejJL5hNsjSI888F?=
 =?us-ascii?Q?8NaJG6LF6EwBrIN21fFRDb4uW3SALs1HRXtF+2fHqRdxkY+3mvEOt6mcRg3R?=
 =?us-ascii?Q?MEq5A878eqp+gplklK2rNQDDKoBEqx4/TdrU/gKcFkg/s+SZMny0fnBNEakJ?=
 =?us-ascii?Q?KGrGgR0an+n8vifLmd52e4Lal9OytdFfMOzkp9Ubijjm9hO/HeNE60OTxrgr?=
 =?us-ascii?Q?3jW6MP/2Zy9NmCGoAiGz+lZNunJjdr/Oa7qjMxEXp6MdSwt7UWWqoDh9VFOW?=
 =?us-ascii?Q?31lvrfpModEp3q93Vc6w6DVER4rj+z4xkOMu2lKLbnnID6MgJFkcaFj5K7K1?=
 =?us-ascii?Q?PAsJIfdAwR/7hNtX4mXwgVxkLl2Zu8kZ8+gr45AoRlZdic8X1U1FoHz5HICv?=
 =?us-ascii?Q?66/0Bd12LZ/tuNNokh65TRsRkT4+CDRywCgBuWIYojh996W8ZYU32/45DmTg?=
 =?us-ascii?Q?SyhdSLa/Q+NLu6Bdo9oYbbFTkD25YA561oLQatlYRCm7CD+QsZ0drY3UtjXR?=
 =?us-ascii?Q?fozOhMIV0V7jDbF+tnjQW48U24GQ/nBDiYEE60t62BQp+DLjYTkndDb1yyF2?=
 =?us-ascii?Q?0tOqEZXoL6k77/UAMa+9d2vckydoRu/+T8vRoO6RB4cC6g6mN2uT7VsukmOB?=
 =?us-ascii?Q?KbDe54/zkiZRmBJEaz2EP3BXbrAv7I0GYYaAJ3my5slMEMaetL3bMKhjdTI4?=
 =?us-ascii?Q?yUAtIV4K60bt9t+wbZQ9DrkZ4dv34eyU9f8qA9J/OPRvIfHsYmlDs+MNOYFg?=
 =?us-ascii?Q?LzKshwMF6isks+Qk4K9RcvdjYaLmN95wGmbUEaPbLn6q3HoPk6FdIvhy7Z3Y?=
 =?us-ascii?Q?0kE5NlhV3D9iElDEMEh7bmO8rstw4Vn3qAl9X1L3GYXkfNIR9vmgFr3iN9pb?=
 =?us-ascii?Q?0EKRdYoweL5SeAHu89EIQSGDlfd/rY3U1ULwEVpGvMAWSbcsoC7vYsLxXrL8?=
 =?us-ascii?Q?Dye/LKzizujQyw95viGV/dchL/EYbrtub699932LWGzpHY9DWCksqpBuU+/N?=
 =?us-ascii?Q?dGcXrc1CrNKUXB5HYAtpB7Kwq7dH+v+NHZy75Aa+o1V+Fc4euCPJxcTfcedV?=
 =?us-ascii?Q?Wa0iinNJuB0v2t5d5SLjg9z6dCTsu6Oa93daJrlk0nCWbn87PPp0s7r4uKcT?=
 =?us-ascii?Q?RxQbqMeCKTsQIFOzDn90pDHFKQDpbrykLewWvnvA0I4Z6ED+W41LtW5yu5XL?=
 =?us-ascii?Q?npw1A7AX13Ecl2mkyNljyXPPhC3i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:52:46.5532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ace7b4-5ccd-4a7a-9466-08dc709c45be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
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

Set smu work laod mask may fail, so check return.
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c06e0d6e3017..f30f1facc0f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2081,9 +2081,11 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type, NULL);
-
+	if (ret)
+		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+	
 	return ret;
 }
 
-- 
2.25.1

