Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0293ECCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 18:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9986210EB2F;
	Fri, 24 Oct 2025 18:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wyhMNfzM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241B010EB2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 18:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c18NmDjW126Q9pgoIHoxmVvvmtx/+rfTlAhSH6qj4BQExK9jZ6p5VD4nr1SU7XqJS6QcssQyd1Us1YYzY1Zhr+K8r87Icp+G+AvqZcC/PVhq8nhYjh/QHGBUqOQwjei5KkQmD/0+uLqbI8BakzNTWgma9LVavh63fn3ZyUOrybiEgu0LQgDjQgCBYa+l/j62USZ8KOpBlwyjG9Zcc+XvG3s8F+D3S1dsPobcc0usI/FCc3Xx9MRsmjOJNutU7I9oDALRgOB/9xP4NfQtkG0/wz+djnp0p0mfA+uvRA9XHjkVzJGhHTdJo8wsgrXLKI9ub720aLlLxY6q6nvpBi5OhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxj+kPVKnV4zz9M8ZAmx/mwvNneEgcPKXmU1tgY08BU=;
 b=vOXwiGLiyBL+ZatsiahkFrKlIm4+unJZITbTn25H0KHzzbewAr+ULvAHysFlAoL7xGp+BQXFgfxTtIrC6UCEN0j+o6t7VSBVHH208433egQ4tP+wCSDR9ZQkL3r/cg71o6ijnERm8Q24Sd5q3Y4AeY9NOYryQ9GnMFK5mskc2EdGbij1lEF6If3PMEoGcaOl1s8KbnYlwp5b+pKO4DFbKn8bTYZVs+ZhxQGnXpJ0AZNr8IHydvBKWjRff87DYZOqmVpjaPxZDJhXLIl/gDm2H/WZJg0NxDFNCsuIU3FqIu6I/kzhXFCg/rJAgbgMqJ+RvBRuImj7Oj8Q0nZHtaL5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxj+kPVKnV4zz9M8ZAmx/mwvNneEgcPKXmU1tgY08BU=;
 b=wyhMNfzMYDXYU8+s6SZoSux/XKRb7p9SwbHg2WS4+qpOkkLqiqbmXW0W3bt0f2PLUAL359SU5wAgnAWVV8JVF8qyEhf0jbJJ23VmKeuhFwEJSq06PP5aGBmVBAX0H12KOngWNFULqNjyHAfQKRVgoe+0E62My/i3GJwZo4wGGQw=
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:39:01 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::13) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 18:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 18:38:59 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Oct 2025 11:38:58 -0700
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Felix.Kuehling@amd.com>,
 <Philip.Yang@amd.com>, Sunday Clement <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Fix Unchecked Return Value
Date: Fri, 24 Oct 2025 14:38:28 -0400
Message-ID: <20251024183828.2954594-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3e591c-4bcb-4bef-1433-08de132c98d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FaPPa/pzRAR1MU4LKrnJFXwUcaAN2BE6qItNkRjzHaM/Ex+Yk4m8yK7izKG9?=
 =?us-ascii?Q?IfGpM/BcFBq0Aq/dgpbfo/YVA72YjrGSHJ1JapbqqWtvXLeeLeX/YevyM4As?=
 =?us-ascii?Q?vZOYOjNXpZPiBJndz9+sIBWryybscxligQSAhD+ENNwTjRIP9k0o2FEv6OeT?=
 =?us-ascii?Q?1DDJhVcapo+cZ2+jVPYEH6eQAAcCz7gu6C7pYfSi2tZFGP2eMqA/g1VGtDol?=
 =?us-ascii?Q?FEl8y77GHqZOmFz08BWkBLUTTyo7svN4ufrovnNBv0hs6Ec6arKVngKrA1nD?=
 =?us-ascii?Q?z11rmmUAblfdtSU5gsup9r7b0DEV97vC6jC4GOl2hPcN5dKgEotidqBwG4hR?=
 =?us-ascii?Q?d5u+2WE0rVQuvlkJZVXruHkwuPAP2ANjQhfjBUyIGmzO3+QLWYy99Xp79B/R?=
 =?us-ascii?Q?MpraId/HezfLU2wRMEZ1aJD3VzsO7k+6chgpTh1g9iJzlf3TD42T6rZZ0GoU?=
 =?us-ascii?Q?fp7dLQgMtbETiNecjOeYePhcTrB467G+VQc5ZHu4Qlq4gbuSzM1UztwIREEJ?=
 =?us-ascii?Q?Ssi/Ns29aRrb1w63xfBmrE91aUYiU4p3IAVtHHY7pNxJ25cTNHtO5N2qyBZr?=
 =?us-ascii?Q?dHKnCmYsKj8IcNNuVfC3JpPEl766p9myPuDt1yV0JyRm6DGZVMvB4YMvG4zb?=
 =?us-ascii?Q?CyPAzPUW4q7RvIdzLuNzUJ69lw9xhnrJZii1LL2y4SjOY2WMfWElgKbnodQQ?=
 =?us-ascii?Q?30pk0He3H/nea7wRmXwduCkmYreySfvor+18UCRwh20CXxLJ9NF+Qy8a0Rwc?=
 =?us-ascii?Q?fL3luQ0Wq3Bz3ud5vifm8LEFrEP31dWn3S8fzg5ppBr+PzbPQl+LCSm7GR2T?=
 =?us-ascii?Q?NRwpo8OuiCpRFObrWJHBlROGQllMc/u8ECU7K1vx7khXMYywccTDPHGGPERt?=
 =?us-ascii?Q?LN+/sQA4L3vIBB7oiGj/pj1R291edf3WtpCthBjqZha1ge91TAd7oHNZBshp?=
 =?us-ascii?Q?Vs5d0tLOoMUu/2vCM8oHWBnekAZa/3HCz3RqxkSqfew8S2gyjKgnIBNXx7mG?=
 =?us-ascii?Q?cI5jgtZi834lBcMj03NmZTaYUeQ91GMG1xRJL7bbu9R97iLhml8g/DyeevqV?=
 =?us-ascii?Q?W00rUEq11N1vyh6Fo/MeiD2jVQhWYwe4YUsKqF8hKgxFiiytB2z1SlWccQpo?=
 =?us-ascii?Q?Q3SSK28ih2QWjiFeDDzJf7RfwmZ3Np4AqdvQtDGMlA0MbUwEO0Rni7RGDSyl?=
 =?us-ascii?Q?qbbAUbcn0nEPIdSPs6ZQo72hMzJsNYnOzcTiaKaJFS2xN/h9gu/CE2zQznHI?=
 =?us-ascii?Q?ki0C+Xx7dKVt56YCaclbW0FX06QtAYwv1OzrqhXKgBGYG5zdZb/KO+k1rzjz?=
 =?us-ascii?Q?mfVZukytZ8XhJS65n6Ygis05t4C4BJclVvqOnYWkJEtLTco1LIudqIzHb8uE?=
 =?us-ascii?Q?Z5gYjmxH2iFAkMMtcJ8DSm5R4peCntLbR2XkO19WkyjRmJW/9/BS/ywhiM7s?=
 =?us-ascii?Q?Qmo6m+4Rk4lj/7fD6AVeI4QYC3fLJg4J8cgxgQKuFpoP1lXnpCtLgrAppBSF?=
 =?us-ascii?Q?DzNaIEFsW+aXcwB5frUr9T2enHiV+V1DP3Zrmct7/QKFOe1TBx+fn3mfl3XT?=
 =?us-ascii?Q?F8hH5a/dw9x5wOZjerU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:38:59.5443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3e591c-4bcb-4bef-1433-08de132c98d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
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

Properly check the return values for function, as done elsewhere.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6e7bc983fc0b..3b696c58c530 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1897,6 +1897,8 @@ static int start_cpsch(struct device_queue_manager *dqm)
 
 static int stop_cpsch(struct device_queue_manager *dqm)
 {
+	int ret = 0;
+
 	dqm_lock(dqm);
 	if (!dqm->sched_running) {
 		dqm_unlock(dqm);
@@ -1904,9 +1906,9 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
+		ret = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
 	else
-		remove_all_kfd_queues_mes(dqm);
+		ret = remove_all_kfd_queues_mes(dqm);
 
 	dqm->sched_running = false;
 
@@ -1920,7 +1922,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	dqm->detect_hang_info = NULL;
 	dqm_unlock(dqm);
 
-	return 0;
+	return ret;
 }
 
 static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
-- 
2.43.0

