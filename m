Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F05EC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 09:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C07C10E877;
	Fri, 10 May 2024 09:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OrN9Au8n";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B30710E877
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 09:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyK90LvrnBivk1g5N72cS+X7QclgwIjAwaMyovljTJzyYIFld1kl1EJsKUgj74aiJ0WjyNEZ+QLbphzl2pcTB1Tpy3+jUUr8PKnqsjj8V7cwgZ8sH8IrpTdQbMWX9itQxxBNZzqqXZmqMUSatm2bR7pXHghkafMjmBSLboByaDfWbf5mjUBP0FwrkjP7+dEbukTKDeqfw670pwu77APSkVQO5XGkS/VJ5iU54B6nolLdVtiha2M/NJKRYxUI3+SROC+xyiq7FYOd0y003bOCABHe0hKRkPfiTzjUbLC+ZuCqkCoqz2g4/7EtIgWqR0e0YP3OZz1dDhdieNLlaIaorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntCa+IYnSiVJDjzL3jVFZockZp+iUfGZtbGPgmUS4u0=;
 b=eixhlE1hK3sg003ff45kj5uaZPFx51v52BbmKV3K05gY5TLxeEa4PLH85PfHFWvAZIZxyo1c+tn9m89gXlPOURGZuZXWwLZZ0oqViNy0TaXStihvVllYLenOw+S+CNAR4xPMiqzmlo3inmaaV8lPmRdd5ztKLhMQfpVB2FQP0mjc2o6/UY5XtjsU5KVkcanydvM63frWdteA4tk+S2eQk4Fg84+VPnjCxe+47137he5trL/MT60FXq86cckQnRSUcsIktuOqpJrxhrPrKnP+5NtiHu0JY1nWZ4YKRkslXfTYIkpJWtAaiWKCMs1SOn4YXVJvf395OSRs/8DFNVirPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntCa+IYnSiVJDjzL3jVFZockZp+iUfGZtbGPgmUS4u0=;
 b=OrN9Au8ndzVACS9UWAxkHqvbzIh3MTF89zqcqR9/yz478erYl0O6rzX4jSrCO8eBqbztwTisHGpMZQznQj1pSHhR7iCSyR1Ykm7yWLIlG9XXTzp16BRXJcMhvLZSxsjBS2v0guZAKTv3lbFKRK+UQO2L5yzgBtrZRYuozD2mpsY=
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:42:18 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::91) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 09:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 09:42:17 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 04:42:14 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/pm: Fix the null pointer dereference to
 pcurrent
Date: Fri, 10 May 2024 17:41:16 +0800
Message-ID: <20240510094117.493726-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510094117.493726-1-Jun.Ma2@amd.com>
References: <20240510094117.493726-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7c1c29-2aec-42ee-63a9-08dc70d57b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TvcsDJMbeVMLrhS92svF+LaLSQ7JKVR9Gr+OATf6QoqKB+fCToljgdpBj+9U?=
 =?us-ascii?Q?ZCYj+Srroj04gjMc5Js9aujFESeTNbQVyGo3RcJrNOat5G4WOEmWM3VHQXn/?=
 =?us-ascii?Q?OvCKu79PSIOrBNNf5JZtVxvf1xTazAS3jcWd5dPktTBPX93L0OOPDSYlnFzS?=
 =?us-ascii?Q?LGjGcWo4FZy0FGPTFH5XZ9OK/dtI2NdlQD8nHeoYqA5stwABV2Lm5O6iqcc5?=
 =?us-ascii?Q?T990/Y3IffYYu1dyPjctxBCcMsiuuX2r2ild+OZovzquXJE9ZN73MPSqiNOK?=
 =?us-ascii?Q?/Dw+Hl4ku91QqG5hUaKdK7ulQN6EnVQAcggWGj8UrWuTQMrLk0T4uWr/jjqU?=
 =?us-ascii?Q?IBKIi5VI3w1shRJh7VqiDz+67WRJohaPvUXW/PV3fZt7ylnMq650JJGx6uul?=
 =?us-ascii?Q?283xbt8NnNKqjJ8jfElZ5goOWj8kKkFQCSOVmdGH3g5rzL1dAv582X41hVpy?=
 =?us-ascii?Q?CCYHB9oVd6WA77+B/THYVhmQi3AAUrPH89mYy4yrNbA2YuumQQicyjhu/cXr?=
 =?us-ascii?Q?aDj+nAFKnlaex1+AyrMYHNVacpFF1spnhcsXnAfQCz10qMmJJTm7rN3QaY2g?=
 =?us-ascii?Q?MRU209GpEKHOc2y1iqzYwzTIDK8BaM+WpfRTLk4hvtjFT/THHgMO7x0wwBpC?=
 =?us-ascii?Q?cjk2zNOyZEs4CCGa3NR49uYgg2MIFIQ9tZHOj3pWY9NLnComV9nUMQeJMD31?=
 =?us-ascii?Q?giQWdIytJVzs3djEkibTCgV+ExSdeqS6DgyYyk7HMz5ZpShSvVQqxXNC3lBJ?=
 =?us-ascii?Q?Js64qgUfsJ2X1PocuVZ+84WVA2cu7gqcmHmUeKo566zeO1uAgMfXYx4X9tOS?=
 =?us-ascii?Q?oPDbWDK4WJ5xzKrbt15ULRnXG5ggVq28dPxUA15Uxtjr7bjV9T8lX/SqJ5Tw?=
 =?us-ascii?Q?siJzHrRV+jC6ufSlPV3c0jh/80Raz76U46xESsnrIOMnm4gJY0gIRXd9MdfU?=
 =?us-ascii?Q?2d8JtXWksqFOTVEgac9MgxDBIo5bKnUxfc7Op6j3mWSbRlE9oS3Q91iOKoqc?=
 =?us-ascii?Q?qm+Om1K0lKSkrc0fTp+0rLUAFBKcrBwykZeJTgKr/WgMTAJp3HKiV94oG7xv?=
 =?us-ascii?Q?f77KEJ//boYkSWF+imumJkQf+2+TOybHkea8CgTvjalYAgk9BIuRZeI7lcv8?=
 =?us-ascii?Q?kQ5me5QbjeDn5MYSyk2sPT+FjFirUwnY76UlwWCmawnQRTfLLrxYwwyBfCEp?=
 =?us-ascii?Q?cecZQb8BUEinA/80EH5HSteTl5++npoOssA4u3aq7q7aEATtRa6Zhoz65JnN?=
 =?us-ascii?Q?hit0yGMftUqM54S/2P1+Ud6mmK3w77HTqMmhdlC1PIaWTtI582BdMrwGhvHm?=
 =?us-ascii?Q?TY36Tmk3KURUMwViy5WrgiVjdUF5qITbJbScMx8sSSz8oJBHq7lRxqNtReCl?=
 =?us-ascii?Q?vZe+kfEgiZ/o5SfFhF1rC1YK9VMp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:42:17.5329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7c1c29-2aec-42ee-63a9-08dc70d57b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719
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

Check pcurrent pointer before using it to fix
the null pointer dereference

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index f4bd8e9357e2..eb4cdadf8419 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -254,10 +254,16 @@ static void power_state_management(struct pp_hwmgr *hwmgr,
 
 	pcurrent = hwmgr->current_ps;
 
-	phm_apply_state_adjust_rules(hwmgr, requested, pcurrent);
-	if (pcurrent == NULL || (0 != phm_check_states_equal(hwmgr,
-			&pcurrent->hardware, &requested->hardware, &equal)))
+	if (pcurrent) {
+		phm_apply_state_adjust_rules(hwmgr, requested, pcurrent);
+		if (phm_check_states_equal(hwmgr,
+				&pcurrent->hardware, &requested->hardware, &equal))
+			equal = false;
+		else
+			equal = true;
+	} else {
 		equal = false;
+	}
 
 	if (!equal || phm_check_smc_update_required_for_display_configuration(hwmgr)) {
 		phm_set_power_state(hwmgr, &pcurrent->hardware, &requested->hardware);
-- 
2.34.1

