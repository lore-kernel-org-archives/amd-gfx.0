Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47410CA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 00:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C9310E546;
	Tue,  2 Sep 2025 00:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEv2+C93";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA62310E546
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 00:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYC9Rv+lk1B6W1B6uueEmoRCCm0C3D2N65Eq64c+scWziEcrdH7gAnIS5gsQa9L5ediVtu78VXL7HCxcuMAk8yj0tvQmV7M5l0ngF3T+vLYBfdMXQhl1eNvwxFlFJFdFlE/ExUJYctrXLsQbXm6aKIK5o/Cq/qQQD4pfq845B0rsGGfwrsANuCv9OyPM9VpISXOGuD/p7uEenrfDr7f3cpM2KMholNT4ov+6Ltk91Vz5NCPFVuH5QTMRJMgtl/z4PtjXxx7bIw+6R3fTwCgxKHme/eE2gxGMmXT1OtJLJpU/e55fycSwfUCrrawYnzlLeJrm1x+BiCNztZUpfYePrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmtbTwMrVsOczqI9fihgO/d0NrvaIA86PF0I5DdZEp8=;
 b=OiISYgqK0ljlek/s4yWkDjhqtYwQz7HejUv/0iReHYlo38/EYAO7y4YrMUAQUyL05td6bZRYBD6MUHXwlpRERHiA5vB7v6ZjxVvACU8AaAh5hfB0JLMxKTZHCM/ouL52uCb55V0a05UBy3mgFdvxBGKxB0svZToS75U+OZLiYGKDAUZFQRrAaS/nFKy83EmyCakZcFzVpX7ewOVtt03eY4BeYVUB1sE6jUef7DFAXc00youf/9ML+3ruz9WwxJ23SP1wmVXCgTZoO5flkIwzIaSOMfeQbWRWVYLKBmVG1vHwkpNYq/DVs7+flkGuTRBdd+7WnCUhuwioJDgwzETz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmtbTwMrVsOczqI9fihgO/d0NrvaIA86PF0I5DdZEp8=;
 b=mEv2+C93VP33605Uiwj6wevE/azrncQ+bxgDLFOESM2LcPgkorj7kY//eTd3bnJf0+nBAbyD/SL24abPMimzcsk4EDkSuZfTgcyyhekWlc64c2M9c4h6RnP00nR9Rm3sFf1ltnN3DrPZfwPLufSqoDPt7855FQ7SUXsaPoYtDD0=
Received: from DS7PR03CA0208.namprd03.prod.outlook.com (2603:10b6:5:3b6::33)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 00:46:17 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::2d) by DS7PR03CA0208.outlook.office365.com
 (2603:10b6:5:3b6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 00:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 00:46:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 19:46:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 17:46:14 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 19:46:09 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 03/11] drm/amd/display: dont wait for pipe update during
 medupdate/highirq
Date: Tue, 2 Sep 2025 08:42:48 +0800
Message-ID: <20250902004532.1833436-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: b97751ab-67f9-4cdf-31bb-08dde9ba2095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YRjDOLBJ7ZRMJTsO6vjfSmTDFqqERqWtQSNo/+frkdEApbYVeScJutvrbZhN?=
 =?us-ascii?Q?fy438H64UGmnTI2dpRQ+VtDFXOCwE1/JTwyGXEkeOKDdJgL569tvXrR7DIHS?=
 =?us-ascii?Q?GMVqEhTNLYraVV84FhrWDOq43nXUg2b8BHKeshQm9CtFApLBabB2t7+M39R1?=
 =?us-ascii?Q?4P5BgY1/EveGoEGH3ahEf6WiKvV77NQ67GU0Ry1JIhseQetswNSQJOmCXSQ9?=
 =?us-ascii?Q?oTL1LKCmwec5h3b+Tls6NgFdIRKGC4hWHOQi12C5rIDKC4kbMlgxsfvJXxKU?=
 =?us-ascii?Q?/7Lh+m2SUcnb8VCrnMad9v8GT5b0VY7z3DH/s+8oI1VeKrmz+/b8OFpQUjFH?=
 =?us-ascii?Q?3QoK9Y0/ctDGOD7UQ1ImqHKkNXSwfq4BsYrt5z4PVL5PObJHD7PF1H/yY44G?=
 =?us-ascii?Q?c0UI8dERg2Ou82LIgfLjrunbSQlMX+r5aBlt+vRiY8gptuK+pSZ/fw2JxyO2?=
 =?us-ascii?Q?LPBPYMswGmRHHYF5mtQgUldzUSYGZK5mkdzNQq8+70bvPp3SKZ22Em9+Dv8O?=
 =?us-ascii?Q?Y34hF58wdH7skcmjKW+ClG3v81xx+XEqhPxCeln3IaUjattmf6v9wVWQgrsE?=
 =?us-ascii?Q?1ftdP6kyYrd0IxGJVIEjxJtlZPLAGaJ1BRUA+om0hkI/5izXd532Sq+y4LVZ?=
 =?us-ascii?Q?JRKwIXkUIhD3M/EFqf/pvYPdMaOULuhT3y2lx0VnQY4itWMLPk1fk+dUnpsI?=
 =?us-ascii?Q?9pyBTMot2hG+NmMF7nxER9kPbJVD+d8HwO3UGvnq1ejKaz/6aNU8hZ3FShHI?=
 =?us-ascii?Q?Z3Ehlzb48xPO5GNIxxEey+k/24ob4jKPz70xhuB3gIdEKDAo0CvKztmcfjRh?=
 =?us-ascii?Q?c/IarUcAUgIEtMp7AKIMRTh+WeL3Yq7Z0FBZnJlfUs/rVERuEmVpnHuT9RSJ?=
 =?us-ascii?Q?7+YZM4Z994mxgkfcgd1Cu4/Cn532CyjKwpiv0GJV2e9YqMQXK14Jth+eBv7W?=
 =?us-ascii?Q?jDZDg2TSzi69S3gteHCXfVHEtw4Ml7qss0Xmjn41h8NONVnWmLuSfcP+JSDt?=
 =?us-ascii?Q?cbTB4N8kimFTPYdxa6y4dNqR9Ns0ka+3vhVqQJuDo1Uueeny1JG8HN3S5M2q?=
 =?us-ascii?Q?L83AloR7K23dPL+yJEjGllhk5hEN6evWCxq1l4jMzhgp0pXpQCPhl2p1IsJ6?=
 =?us-ascii?Q?NddI2GiIJbMFMo7+TsECQwRtAM2nJMmKgVo+Fmxr0Xum5fBdSvq/6FXXXiif?=
 =?us-ascii?Q?IxWxIGkRkw2IwW1B0Xq0XdngCRVE6+Qx2bxukgbSr3ddZzNKu5FkXexATdOS?=
 =?us-ascii?Q?ANcaFYRS2SZ67mPJGLuUUJugetrq4FQLwBjvtNxx99Wjqsz7UGl5M0HbRcJX?=
 =?us-ascii?Q?hjjT6xwxkke8KF/WhgLch1NDVUvZN9+oy4ruEfGzdHsCLr9wJsLHZ3pDoKeO?=
 =?us-ascii?Q?Sg9aGqdMf3wAc+Ers5ZCQKYliRwNZNQEPX4lIje0IA4zNUEVvPY0dr7YZKgp?=
 =?us-ascii?Q?6tU0jRk2MRIcSs3u+81omCAL/zOA8XIaXiS8p98cSPwEsj9xUbjXHgmL1sKf?=
 =?us-ascii?Q?d4EBeUTQ4Z5Fhjf6/n5voxAb20tvZ0LndrTeidvicHp7m0v+37055aTwXw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:46:17.5511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97751ab-67f9-4cdf-31bb-08dde9ba2095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[why&how]
control flag for the wait during pipe update wait for vupdate should
be set if update type is not fast or med to prevent an invalid sleep
operation

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 261b7d43e91d..5963019d1e74 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4169,7 +4169,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 
 	if (dc->hwseq->funcs.wait_for_pipe_update_if_needed)
-		dc->hwseq->funcs.wait_for_pipe_update_if_needed(dc, top_pipe_to_program, update_type == UPDATE_TYPE_FAST);
+		dc->hwseq->funcs.wait_for_pipe_update_if_needed(dc, top_pipe_to_program, update_type < UPDATE_TYPE_FULL);
 
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		if (dc->hwss.subvp_pipe_control_lock)
-- 
2.43.0

