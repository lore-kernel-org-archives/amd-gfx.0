Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6D6CD5BAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 13:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB8B10E1A6;
	Thu, 21 May 2026 13:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3avmWB/T";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA68510E1A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 13:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3D/AYYzLC8c7OycrBoDnCbbr3jFBWx66fdwI5Ddy4xzMslh1DfedoUrFaK5k5KLW02plQ/CQf9ZCBzDcBpU3+uP9N3F0GM8+mRsB9mVxJm8yX2+Zf2hN9kvn+f5PSBRRRQ+XxfIPF6Oze1gLiZeKz3iYMIEaofXrAIHUg0Db17l2s+8SIgMvUj6h14TdC1H9oqKo3RHzwtDQ/MWXmN6shK7idgv4Lm3pNixwnvx8us/xZ5ZeE0Pe9P35uhPV3eiGf58vBeckkNqOAXbbQBRBDEZP6TanjprUTnW5xOvIO6WHW+rGIDiDtLpIE+R750vDaXX9w5aUQbdnZnCjzRozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9cRqaPP+yFxD8nEO4KqxbibwIAEUPwky7kO2oxhfpU=;
 b=PmhkKqsx99LNeQPczUsQTVDV76Gqaem8WcSqKp57g2fBAanQ4QZ+bjjzkeVKr4SSj1hAvu/R88h9reKhMOFfihTPhTvbWZ5gdMSp7mgqGMWosXlKmuQfvBFqRcMxkZD+k9KcSUguYZzMpsQaaUONT+1WsTwvXFa+YCaIMYg3dcnr5rJzSyQ6X3zWeSthNY+5QqsQpcuUKF10WcMDro1Ib93f/F7Kp0CiKfUHcCAKn1GsRdGoxZR+O3FzcLlxofDpGyXEEB7gWsrEajVwXRonqD/LB1PkwzJY5Eb7UGQJXwmkV/D1WPXqfSEDBIGbfdUoamjMyu52K+5qdgN+exQvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9cRqaPP+yFxD8nEO4KqxbibwIAEUPwky7kO2oxhfpU=;
 b=3avmWB/TFp95oBdfNVAHTWJm3VJ4J63Bo3iTeERSBy0ek4JaAHDjbUP2wDrWO2q1fkF16DEv1Ce+wKgyaQybv5jzvjGtVUUESZN/wo/SPZUxYy1ZUFGk011DQ+uenexYFHTTyklN7SLKUECKy3vexI03bQaA0H2z2MtBXn1160M=
Received: from BN9PR03CA0134.namprd03.prod.outlook.com (2603:10b6:408:fe::19)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 21 May
 2026 13:29:08 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::18) by BN9PR03CA0134.outlook.office365.com
 (2603:10b6:408:fe::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 13:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 13:29:07 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 08:29:06 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Check bounds in allocate_event_notification_slot
Date: Thu, 21 May 2026 09:28:54 -0400
Message-ID: <20260521132854.1016622-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 506a7ee9-b565-467e-663c-08deb73cefa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: oF+YYIezL0f+/excNSyuQ/sgJ5bRKdGVmVh7ozuEAM3/H9vI3bAEdPKGXtrrqk+QA207449haY08iKYBdTicpSv53+ucvgKU8l0vNcNWDwJvmxKriyc6LOF7XRa2qgS20FKQu1zk5tDOcvGgcA9etvnaQCvjC9cYqzcNjPGc1kGezLSRv9/nwBZPbvcygkrcfIldg2qFe0BosNu1bmdhGvHMIitG1l4y+ZHzPtitBGGNWmNMnXJqVgmJ03iZsgtz6TTW7rn86YbYkSayq6GRJJu+nSSpOZbXg99q/gaOGtwQG0krbDqzLfFF+qr0aFSgZhQ8mw371GkCVWCJ+GONJAFMS8ISX9OwuAMRV+SZyL0d/l8bMuIYPUtspDb/mTts4fJVIW/XMSPQAv0y4IDNveSnQMW+LSuYlj8pOtrK/mLw7xKn3hXampJmnp5ToyCMNXscpdxmxEoC6stvGDWIS+49riOUWqBOEWpteA3yCxjTkAZaledUEUE4r/gfR2d0V3fCy4JQmFZcwHZE/S5iLyyCDAchSnJ4jtMuirF/+PQcu+viH3ip2/bwhEJfQjNquPEwRdzo1blfVl0r2Zp/DhX/1Zaw6+DxLRA+1vmqM7Bwyt1kLPrhsChto8AC8ABvamG9mWVBjmahhng7nMAUjHe5QxBEcX/1K9vUrNrV9H47vpLyCSRJ/dcRJGj5Jg73O7Iwrtj+DHLcc6lw5l+OpRYhJAao9KqY9TeP/3UgrZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 240sXkF0MLV7f6qJq7K3bXADLh2JTmLZY7zWSyc50DqgriRoJ6aqXkOj6gEO8CJN/4ZaTpiZ95jsN7A7/YyEEC3vIIZlKI460aocIt08uSkKwzXSfSeQiOg0pB4gtheVZ6o/O9jdlela9g/RSOfniUL3epw8Srpj75z5BS3UjPTX17JLXJQ4bRLdXGqlZ22UweeXxUZHug/5Nd4hl9n0K42PhIEZFRs5+EJjoOI43tyqXF0Wn5B0IFp3Ki6VmcBiEiUtg5xCmUOfHS7Z3y+vj+FaVu4yPK2Qhi+p9a79vfxpI/u3mVqdnU28+5WRZFixDOH4Kf4hEVXGd0Rm8lNI9Z/vmuwGVK/UJJdJefhZRqRsnzqvElu4AeEAvxoX/6e1SRLaDd55srMMwVgO0uIyLeg8pq77HLHg7dMXlepS142AzYTG4fxVegRnstjtSaG3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:29:07.9538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506a7ee9-b565-467e-663c-08deb73cefa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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

The valid event ids go from 0 to signal_mapped_size / 8
(usually 256).

allocate_event_notification_slot has an option to specify
an event id to allocate at, used by CRIU. We weren't checking
the bounds on that value.

Check them.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e9be798c0a2b..5a4fe68a7986 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 	}
 
 	if (restore_id) {
+		if (*restore_id < 0 || *restore_id >= p->signal_mapped_size / 8)
+			return -EINVAL;
+
 		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
 				GFP_KERNEL);
 	} else {
-- 
2.34.1

