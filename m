Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F470E77180
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 20:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3B310F0CB;
	Fri, 13 Dec 2024 20:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vjih6Jku";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169FA10F0CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 20:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we7AgueBr6GWm15bZjH6wrR+MrLRR/OqkRTgrOmo9YGOv6zjgyCGw7iThybRwZuV7YmiWXEQ9AgE0U/C62+IrHRGizCsti4fim4KAqb0V3WHIHMlqlO5BDbQxLQaJm4Prh3b7VhRFR4G+Ww+nZ/zYqh1hy2zBvI4kRSovh8aqSC1iqKTUQGPpXwJY0Gf0fu1IWdQMcAg2qWnitLjaRuACxBzAG2YwuXu0+4gzZia0NUCSkq8gTM/Tw7Cw09aXQL3sshpMkpSMQKZBl1pxldxRa9HIzoekKQyzW7c3ugb7WF7QrQquGKlr0wYFg4H0R7CfypNeSczl6rdUNgz0kB8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6CEKRbRFQauKCl1bW/fV3fHY9QAAXkbb9q9VloOXTo=;
 b=ai0HlhbT9vlHkR0kPxqY+Vj6Q2SThHvDVsMNJeYf5sdPvjfXuclPGXWhFabDVUyQF5afXg0gtmXj1mKPJeH9Zw65betNWcwnMbM+ISBADhOcMFeStVEnqdhP93oUpmzjfnOfp9fmVCe8R7WpMeKCxPxccLFe6AcRdMIZYEIQYWDJctUiz/DGdY34AR1+yN4DopA+z8EE1r+Ss0QHDG2+pONvqFVSmA/2MtU84tdU1hm27ETNSLFQ3H0Bdqx99QW/6ElYQCwpKsR74LIodIa8BU+QHp7UrYsrP9k0m0VcYG2oJ3NuN7N639RWB6aZXF2og9C3NNGP3BZ2fU6i507PlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6CEKRbRFQauKCl1bW/fV3fHY9QAAXkbb9q9VloOXTo=;
 b=Vjih6JkuLGDYoYgGtHq2MWLSEUPtDl0q4HzdGtIkSMVutV1LDJeR83OWga6J7GrsyPYNxyz2H4T71tgAydzjQmyr0YcQwg3qxG8AuS7EkzarvaeFxyWNiZRCWPUj/FNFRy1IwVEylKDzQiRnFSMV0Qqw6cQaGDJmLrvoOaF6v6Y=
Received: from BN0PR04CA0192.namprd04.prod.outlook.com (2603:10b6:408:e9::17)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 20:34:07 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::bb) by BN0PR04CA0192.outlook.office365.com
 (2603:10b6:408:e9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 20:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Fri, 13 Dec 2024 20:34:07 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 14:34:06 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <jay.cornwall@amd.com>, <Hawking.Zhang@amd.com>, <flora.cui@amd.com>, "Philip
 Yang" <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 5/6] drm/amdkfd: Improve signal event slow path
Date: Fri, 13 Dec 2024 15:33:30 -0500
Message-ID: <20241213203332.18165-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213203332.18165-1-Philip.Yang@amd.com>
References: <20241213203332.18165-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6accc4-1fbd-41a4-d947-08dd1bb57e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z97K6YTUkg140O+XvOf1VRyt1YeBArfRptgEoMQuQECMMeb6oJhQ2AE59551?=
 =?us-ascii?Q?DES6z1cePbjx0A6fiCs1Kn5nCoZKVnthDUjKbq/NRVK7kBDciUy6wswBOAr6?=
 =?us-ascii?Q?5IZ6fKdcjX9HA0MYzpYinA2s43cKzDGkl4plJjnjsTzB1D+MI05F0wSi7lQh?=
 =?us-ascii?Q?BmlvNKF+calFKDwr5mvVqtAnMBtbB7iDrtuCfp3rdNPlo6w84dld4oBDXmLD?=
 =?us-ascii?Q?lpFfuUxToz3VrvYXp1p2jl8xDkszcRuPWEay+vrQLN4F6nB05Kfp9Wg8CRdk?=
 =?us-ascii?Q?P0FIbMVgGhvJIO3bGRYhe4hY5c/X53U0Q8bSRDeXSzEUb2N5Ee2ToOxrXcIS?=
 =?us-ascii?Q?BfqPEXXNZREbE34u8rghF1jqwLi91KbSnF85Eh4E5EOcGFe/nDxQzQGnT5Yu?=
 =?us-ascii?Q?3vURdGGektKdtLMqIVYsjLDK/pCYZbrAgPfn8p9t0dwbCZwOqo0PxKOqBJf4?=
 =?us-ascii?Q?2uviKr7IsTbhQc+vgksRxEV73ZPdWKo3aLIa2SL9HQ5MmbjZDlfT4CsgHMec?=
 =?us-ascii?Q?zXHj8vBBYDgtSZNsPfWrPWwjgGlIddZJo83cn/7Q6mwpbJxPhYKTuf+SVEa+?=
 =?us-ascii?Q?gp1D2n0KwxNhyaFE3NjVte72GAWaJLhMKwEMDsxkWh02Bpk19PIZ5ODJTtlo?=
 =?us-ascii?Q?5x4IuIjPDh5vSIfn7LMn5ZHyPVGKifaTF6aKf3d4YWtvJqx8WuoCtuaLhifM?=
 =?us-ascii?Q?qb27ojV56KX0c7sIfr/7f1VTqXEqbUTghJ/sxdjKg5fuCJAQ/za2xvyUAQz7?=
 =?us-ascii?Q?d8SvCOvsFVKo5/4YBEFn1x8h/tQWRZx7REaH3WpXhX30J545ar11CV11NovG?=
 =?us-ascii?Q?EMY2C58S9td+ddhSGlEVz+aoDAV+bfb9tQbjlnEtXsjB2oFT3z/TnpEvahG7?=
 =?us-ascii?Q?O5gsxNtbo12P6s6K2R4M7JGhTsKRh/lJBuZu6IcvSF7nMxvqU1mqlLPQ2p3F?=
 =?us-ascii?Q?Qefr9+C+t3ZuFj/m1Ois0t43wKwTOL3k+zBMritqKq1X9Hv9ikeruq57+MCQ?=
 =?us-ascii?Q?R+Y4dpmRvxjZxJ/cQJAT9m+P+K//q5/0ejrNlKzyJovHPOZL+Y47lSTvUH4B?=
 =?us-ascii?Q?6lGK8OSxsLeTGzNyC/6Efh6pN8g79aeUh5w5LCT6Xf5yCnxJlRQ8hTm63Sej?=
 =?us-ascii?Q?HxdS5w1NahuHC8Recekpsyc2+NSgRdODBi4NEvvmdYgd1Lv8T4lE+h9byiEO?=
 =?us-ascii?Q?NfFSFaZLqX/b8GHML1eQPM9Y3PICgTCtUwVz7hlJ2xI/YU1RU2qWrZlOfb7/?=
 =?us-ascii?Q?s5go8YaeTPT77w8UCS4dvoyizedmPs/qODynZ+QiD/KEuZ6FhqK61GcXJPbB?=
 =?us-ascii?Q?yw/5EWb2Oq/XYndHjOTyiT1F7cYAtuIzqShvDyOpKbDxVbzcl3mN3azj8ndZ?=
 =?us-ascii?Q?/O1hj/QiMDsg/nhfbQNJB1kXu4fFA5FHLeeEFM5DM+RU0iKgYP7lkYw/u4Fm?=
 =?us-ascii?Q?MKypsNz0m9HIZsZVeiql+ZawTJVGQ5Rg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:34:07.7194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6accc4-1fbd-41a4-d947-08dd1bb57e42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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

If event slot is not signaled, kfd_signal_event_interrupt goes to slow
path to scan all event slots to find the signaled event, this is needed
for old ASICs that don't have the event ID or the event IDs are
incorrect in the IH payload.

There is case that GPU signal the same event twice, then driver process
the first event interrupt, set_event and event slot is auto-reset, then
for the second event interrupt, KFD goes to slow path as event is not
signaled, just drop the second event interrupt because the application
only need wakeup once.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index ea3792249209..d075f24e5f9f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -748,6 +748,16 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 		uint64_t *slots = page_slots(p->signal_page);
 		uint32_t id;
 
+		/*
+		 * If id is valid but slot is not signaled, GPU may signal the same event twice
+		 * before driver have chance to process the first interrupt, then signal slot is
+		 * auto-reset after set_event wakeup the user space, just drop the second event as
+		 * the application only need wakeup once.
+		 */
+		if ((valid_id_bits > 31 || (1U << valid_id_bits) >= KFD_SIGNAL_EVENT_LIMIT) &&
+		    partial_id < KFD_SIGNAL_EVENT_LIMIT && slots[partial_id] == UNSIGNALED_EVENT_SLOT)
+			goto out_unlock;
+
 		if (valid_id_bits)
 			pr_debug_ratelimited("Partial ID invalid: %u (%u valid bits)\n",
 					     partial_id, valid_id_bits);
@@ -776,6 +786,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 		}
 	}
 
+out_unlock:
 	rcu_read_unlock();
 	kfd_unref_process(p);
 }
-- 
2.47.1

