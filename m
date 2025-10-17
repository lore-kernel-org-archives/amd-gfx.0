Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C53CCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 18:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92CE10ECD5;
	Fri, 17 Oct 2025 18:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="obAgI7Hx";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B8B10ECD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 18:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WogS35tp+B2a1miOypTFaYle4on0w/DwBRLB557OiZDAz0WdVWFEsYaNvSA/uQE7NbfAiloYpON8z7c8JS2wLSTV3Yq1W6NjqvOm12ZAIEUvEbGIArVsWzGLzHVqTy+D9UfD9aeL6nciJ/utbfoqwHUCJq+OM1unRj7V7iTJHSucU1CUFHfxEo3NM+O8s16fkGAI7ZgAIyHe751K679Gouvap+t4K+2CpwQttemqD3HX0KzWloBasy/NC/dd7ixRXr2Us0F2blJmvgFZlGuZcYOR5Ui3dEPZDR6XADEurduufPyMMHZ2wHRJhaWDOXbi1bhyZrcBUjFKPH5FcSds6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuwXzTleBvo2wV807CwJjkumT9l7NBL29YcupaSyU+s=;
 b=tJToh/jLBO0xiR72i385JiWaACcnroBATMUh7WFLH0x4yN97kAEFc3YRfiF924HQLprtnQkfyG0AfNtDZ8zwQ+PaVBkzLSvzIYCGEbKj7OVPXnrBIUhX95gI1BlNfDg3k9yvonfQA2IEzLNQ1gwKum4OfPH9SNVlTjshapUUmaqjM7NFcgOWg+W7wJiLdlKyX5oT0mOLlCM+xuRBserYFm066Iqws6m701BNMwOfveF0T4003p8nVQb5dcV2gS4/fnvtFUbYKjnHJ2p8uRnNq4mpsbBsp41GKtNCXv4ZoeU0ZV77qg3MlurdZgZGFTOMnLHd7RcahZeZq77PZ2VbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuwXzTleBvo2wV807CwJjkumT9l7NBL29YcupaSyU+s=;
 b=obAgI7Hx+0ssSSMzqkCocoH+7thJPubJwEL1xCu5j02sIJDEgb/6PNc4p+3CLBNuqtMCS2ldmW1YMPzmh7yDfYMehi9Touq7923WnE05t1aHsCdL5+T5Srnz7MJJdQKaEUC4R3nAcsi1QFEkVumrUhx9xyp24UbKzx3shbxFbdA=
Received: from PH7P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::30)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 18:34:10 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:32a:cafe::5d) by PH7P221CA0022.outlook.office365.com
 (2603:10b6:510:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 18:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Fri, 17 Oct 2025 18:34:08 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 17 Oct 2025 11:34:06 -0700
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <philip.yang@amd.com>, Ahmad Rehman
 <Ahmad.Rehman@amd.com>
Subject: [PATCH] drm/amdkfd: Adding delay after sending the Exception event to
 runtime
Date: Fri, 17 Oct 2025 14:33:54 -0400
Message-ID: <20251017183354.116538-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 51314ed7-a71b-4030-0410-08de0dabc299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0qwe+qUe8jx7M5+d8NgcwFklgA7yUfCHfePbPzJdvBVKdYzqsssTqd8AmMYW?=
 =?us-ascii?Q?j2YRDZq+M9Rh0QAYbJuxMQVt4+DXvQtH5h9pVJQuVxpuF9NW0s9LfMLz/LJX?=
 =?us-ascii?Q?iM+bvq8AGe3oWtaJEALH2ypAVFGyjcIiWPSGSomL1+TWLS7o2ui8JhcfrV4U?=
 =?us-ascii?Q?4l1VJGD0Cc230rLm2Ph2RGowyH3VytueISW44xBR1l8pvFx+EZVjJUZjG2WP?=
 =?us-ascii?Q?YGqg9nPfyYxAlWgk06NJWnf8RZBG5eTKGvbZBOipH0vprX4rutlSYRF2t5Tu?=
 =?us-ascii?Q?niMvUSTFndrxjDl9cnK2frVkQimRAYw9kTrdhivx1CCkQSlp+nseJdD8gznE?=
 =?us-ascii?Q?T1F/n0FJqYeOKvAQwzNRnueAlWXI40VIE1aF64WlZ60dz/ekXsA2FA9oZFcz?=
 =?us-ascii?Q?mq7xSVUbNlLfZUMjtH3YVqNpFoPaNeOCqcE0zm9x+zK/9vk0nnIRLrdt9n0l?=
 =?us-ascii?Q?W8DDYqiScxjo5cYK3s82ZbG0z5KO4V9a89ZHExSZ709INmE0t6bbAqWXBsKt?=
 =?us-ascii?Q?JlECwtx7FDOUIPZKuZXrwEyFxhsdlv9M2HveClGDe4/c5l2hTY6SKfw7KpXA?=
 =?us-ascii?Q?cfbk1q/G+cjdj2FZeMcg4vUOyAXVtErQb8Z39yMnxkPLrFZR127PNX1TzTP4?=
 =?us-ascii?Q?/IYdzo5Lsv1lAQ9qgAGKyyZvNJ61Jra1fBfDjYITcqiddwoiMnBZXECj469Z?=
 =?us-ascii?Q?o5kQUoOVM7RoIP/pgjoamUZh4B4Zgbq1rMoY14vD9rJhMakXWSmskhqddFak?=
 =?us-ascii?Q?x9Yn6i6H7N753koOYbz97779LZkmpF6Pds/sFV823ZyB8211aeVgK/jO0sKb?=
 =?us-ascii?Q?Zb0dHKESLBkckeSjGBadn82G3wFkXhlku1B96cD+ulxnRgXaTjHCvdvAcKAz?=
 =?us-ascii?Q?aV27wGN8pB1InIG+omNv3sopAAzlIk1eRxyRD4QzurT01b5GvaEBRhpVNN4/?=
 =?us-ascii?Q?qBv9h9m/rKrUQmw/TsPvrnrog+cypZNYOdMiijRodHhD1ccGD8xRZsOxZr5v?=
 =?us-ascii?Q?hv5TCBUpD1Nmot/uI68D5h/kxMhsWWu0lsEJOYCvzl95ZFcTU1RZq9Q7lGPN?=
 =?us-ascii?Q?5/jqUjvnaIPgoyoYFikWgzBHq5qm++qiAzMpON2pg2AviRx/Peznc/lAiBzU?=
 =?us-ascii?Q?+F5sYYEibgy4gKBzLU2kbym28QPRgIQIixu8GsTpxWpLqB6XRbKDDXgrP1Ad?=
 =?us-ascii?Q?9uM0/KKnLasV6r7FnbIH4fIDVCobQa7Ho5KdSJ71naGrnx3XdrwRns9PFUDm?=
 =?us-ascii?Q?w233mqDGsxfu+x3vKdz2lcvBmlAuXo12Vb/pXd0SRJhQtQXXepvfMvuK4m0O?=
 =?us-ascii?Q?Tsgj5dmLU1KNsVwxrqUtKuC6Mp4EDOzkbw7y3ETcvMudxbOAqSPdMP6x1XBY?=
 =?us-ascii?Q?1tjcgewVKRQjhw919cQSr73ie/ioVOQWxmPqK4NKwSWHDAJuLT4zIDQw+wke?=
 =?us-ascii?Q?2vQH39RoQh5mzCdy4ucuo8Vs8ucV6emXThk+RGEJ6xuBptPXdwAsKa/h8EZy?=
 =?us-ascii?Q?8Uqs4vLtRskvQuYkmeVkXeAfI1dmW1wHPQ5w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 18:34:08.7224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51314ed7-a71b-4030-0410-08de0dabc299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621
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

The patch adds the sleep to yield for the runtime to act on
the EXCEPTION event. This allows the runtime/app to execute
actions on signal reception before driver gets a chance to
move ahead with the sequence.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 82905f3e54dd..8dfb796fd506 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1329,6 +1329,13 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 		}
 
 		rcu_read_unlock();
+
+		/*
+		 * Since the set_event is asynchronous, putting a delay
+		 * to give runtime sometime to act on the EXCEPTION before
+		 * driver moves ahead.
+		 */
+		ssleep(2);
 	}
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 }
-- 
2.34.1

