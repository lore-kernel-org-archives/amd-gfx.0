Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F97E8B393
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8575510E34F;
	Wed,  4 Feb 2026 03:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5u01fTcR";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5C010E349
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgkiRtwYpQjP5AR+IIFw0hMskGqmyT8FE7PhGF/3QPOhFmNiYGLqWIJWaM7uC4EpH08kGUgV1zS+PjGHrMJS//kwZlXxFmRGAsjwWXK/XxE32le18LJWesTPXijhqK6NpWxYIuOwA0jvIiz+yR8xejRf+JbEC0eYLKx27jAjr9qdN1jmaHTOlOi3Rmtz1B0xU9MQX0dOeOTcfzuE24WsMzRISxbNtELJqnqiW+h/5kQeemv6e25kDtP+zZqWm7GkXHlWruAxi7+5PVlvHN6l2sRZDbdvUfkNsNJs9WYM7iGIDnbi99EZchmgzGFw8fIz0HfltPaZkclzxvyndlrQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRJmCN66RlSpctzdk6czFtW5FNuqozJeakc8nPV81/s=;
 b=OMQLrjnluGYx3RqrfObYlWIuUW6nGYU688iEBy/AbaMJqIfQPMDfTQ/Xsdql52N1EYVDs9awvjUxWkP0zjRTr5+T761EoQrpUDU2S003pHjRJe/eoQ/EiIOkyvaL5gOUfEpTmRNkpDQHMBAmKc0wL4TVXTu8A9AlgrHs1RZ5cg0RvnfLDvZl0M0C9rS29rvdezeuzU0+bHwSvjwnv5Nx58/1MOXQSx4M627ns0IZGqbDm2k7ecE3KDu4b6LQ/StGrHSvGwTXWU97vj/6kzUQA2FUZKl2RkJTh9457Fz9UMOTUPRGL9RDiUAwrGNYyPHzxgrDuOAVNcYc7wsPskwhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRJmCN66RlSpctzdk6czFtW5FNuqozJeakc8nPV81/s=;
 b=5u01fTcRyf9y4WEpUHZLwwaauYgm80Xicri5Vy8LbIMrctQLYBkd5ZqoVnl83x6y8F13iI1IMfph6+MR5qhvfEjAhSOieIdV5A0KJ7Jf/YhsMqhuXmdm/Amb9mc14lePkX1rgPLukvoqMLzpGsvmwvBeuGScskLd1EXoPrjWlZI=
Received: from CH2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:610:4f::17)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:06:47 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::96) by CH2PR18CA0007.outlook.office365.com
 (2603:10b6:610:4f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:06:46 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:45 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 01/13] drm/amdgpu: Skip SMU init for backdoor loading
Date: Wed, 4 Feb 2026 03:06:08 +0000
Message-ID: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 94979662-3008-4b81-27ef-08de639a6e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RAgGGHmzjXJqObJmA84SxJO3ZTjbmMFVxnt6/VOvv35HHRGqBPg8ydfES8We?=
 =?us-ascii?Q?LA/69BtE23H91630yWmICAWSO+zbcEC5BtrSSm8GGF7qjOYV0MOkaOuiJwFe?=
 =?us-ascii?Q?8IIRAtr0ciJhd5zPrRbtdZpH/4rHf1VlggQ0hh7kwzZU3H2truGGYwzw5dwZ?=
 =?us-ascii?Q?0LP8Ya54nuC4ilbImN0ysKWM+pqnFaSSwdog/9GJyV1ve6qWV7hii7WDB35B?=
 =?us-ascii?Q?/Yn85l3P+tJq9usiKzqizzg/7v/wBhtWrMjnTNOZoIzck1xOhy6AYYIUduSy?=
 =?us-ascii?Q?O7HORMCGi0IEPwbIpBuGzebupLxXxByhCerfV3oMbIP0TGBugp/lUIjBXM3f?=
 =?us-ascii?Q?sVMK8nAYDL5sFX0IDEMa6Ed7yAEYmT08H/MENU3Ix9MZhxmcxYxaBXao1rFp?=
 =?us-ascii?Q?3JNKjXN/DWaB9G7xy5M7n6BNk/swTpWlkGypQLEJytGr+5mNZv4qnTYDHN7z?=
 =?us-ascii?Q?yT+0WHdKOovhwgsVEQlr10VD56zcK/04rI59RiIJbZ/dSqGE1rjcG0j8Cqvi?=
 =?us-ascii?Q?bGDPngsO/LihrxSHEzAjSp5Gu9ZxcCMB4EDdQZlhXcmQl4KTHJnCOzvoWB2T?=
 =?us-ascii?Q?/nM8WdPOvuh12WHM3pTzzngFc8+aYnWn/kyva9Y0y0xrpyCnl/TSXwlTTal1?=
 =?us-ascii?Q?SXcYlqf3gickCBxneki++DmbORHJurFX2bPL7domxtjs6c8aKFVmbxT/RdLx?=
 =?us-ascii?Q?8Z1XPuBMdtIKVeub8fqES2/0n8pHG2Ylp/SUuy5PMiL/lEi/Bqnj9V1k/qw3?=
 =?us-ascii?Q?oomd7QsNO+oV9PqaEY7Seh43kMNLn98BCdL2+Xcint14UnXA0G7EM1kfD+Dj?=
 =?us-ascii?Q?MEYVKHAP1lgEAndiEl+MZK5JWsMixgvUNlpcMTZ4OXZPvWA1wQtISrqkxHYJ?=
 =?us-ascii?Q?8Y+zqkyOaXhd9RXRwOzgBo1FSDnyFZ5VcT2kGHvchrcucCNEq6Z3LCRd09sV?=
 =?us-ascii?Q?CFGUTVN3HZwaqm9LfGJCeDXkt+N0L2/OLKaFgukSg0lqrV0ybEbmygbA/lgM?=
 =?us-ascii?Q?Gz9JrTb8XioFE/bj8BZx7NCpPjLKYkx/fYa+ng7fG2VObKmmqUAxlWlDP/Kx?=
 =?us-ascii?Q?Nm8zQnRCOjd70qy+SySHOnzIeAXkTcBjXtPd8L9Ba2nedwhXjp1/lsI1iuWw?=
 =?us-ascii?Q?gKMR/x01lTT1KkSMdJYwmFwj0SD+P84YfF03vF8cQQS7zzszfnIQhS4yIYkG?=
 =?us-ascii?Q?8C3cFk94mlfuBw90MHXj1s0WZ9Z9m8natD2XYL2I/++9iQvRxlbeckmCT2U5?=
 =?us-ascii?Q?mQCIHHxQ/c2+uBYPPey8+KYNpONrWNmZ4lHIMFJ7lckMQu+RuGZpEpHo57kj?=
 =?us-ascii?Q?HjL97jt/h82UvfD2KC/z4ThSiWYNvtTSQS1/ObmCR9sa/+EJuxkLuSWF1PWv?=
 =?us-ascii?Q?6VZy+RK1j+1KwiM4tRvls2IX6Dbf7NqGep6DmQaXhOGyjaZ+azBnW6xyYMI9?=
 =?us-ascii?Q?fSryJGPZq6HKy20sruK2SEDeBFXnTPVWNAKLQQ/gjPFjv16793w4g5mKhmM0?=
 =?us-ascii?Q?a1/D6YHb1ndBfbuTb7Y58NgyDT/712GO+lgmM5lf+fT2SJa9IljNBXBH3Qs4?=
 =?us-ascii?Q?SU3G9ZHEDlQ46QP/pygnKQzc0T+YmIDpAvB+XC1XHepjYih4OEq+slMiyOZo?=
 =?us-ascii?Q?uz3HQknXklJ8+n7XI4UooBPiaGsV9xkFJJAL9BP3wOpG+kvd3v4do4/7BrVt?=
 =?us-ascii?Q?1dxIhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QOGWvduR1cXnyfu9h9xEgmpLvuX4Um3IS8+TobfbgdhpEL/jyHm3pbYTX+afWf49PyIEA5rSw6mrdbTWTsdsePgGvr///YCTXYkAsHKaiDRuManWiNkqIvyS25o0li432QIyv2SSZOsutaoXq599/s2XoEPFvSQcxH2yCWEk5+FfLeZfL4KbxoNwR+kZF5HbvNLQcwtD7A2hKqLhOmR6lc9SCfWno7OwZC7XWrw6r9YOrBJmRKuYSi4a57R3gvKOnHWQ0bZlCM8kUCc1F0OeNM4q7tvHb4NvfM6qil4O8oMTul6aA4gAvmyhvgWt8PJ0lzZjAJYzosQXZ8MyHxssythg08uc3N2X8/ufC6poIO4zpzqr1TERqEXB0H8CzZZNJ/CtEdYh8xaHc+l92k1aJkF39RiTOJfOOODhenHEpIttjaIIFuwGvqdaB5aRK1bt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:06:46.4121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94979662-3008-4b81-27ef-08de639a6e93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
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

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 9f52b7b24198..fc68dffdea98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1909,7 +1909,10 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		smu->pm_enabled = false;
 		return 0;
 	}
-
+	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
+		dev_info(adev->dev, "Do minimal SMU init for backdoor loading case\n");
+		return 0;
+	}
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
 		dev_err(adev->dev, "SMC engine is not correctly up!\n");
-- 
2.43.0

