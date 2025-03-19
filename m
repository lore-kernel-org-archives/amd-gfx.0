Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD323C35FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 05:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEEC10E1A4;
	Wed, 19 Mar 2025 05:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ON+YqhUn";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4847110E1A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 05:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYstYiIIy6hlaiBm+kgGnt32vuFPXLYJCL8/yHoRVyhpjN0bR+pc0zd4Cf15Y/P43fiS4Cd9h5mFsGLnOWq3SdbA9397p5YaRVTzuds5pmkOrDaeCyT4gOYaQ1xscFO5COOqvPF5+D9YWgmEz5sxbypA4YXgD+Gq8AYkoztJ/BPL+UdOSQi8e0qcNlZULQg+9i8soBgmUUv1V/fSGZAxvlxYkVOyrhlRJD6raarwrGhjtIQBNuMeMpNPTCZT8C3it9/228PvZpeEQ/FgQc572o0eg7GnmHFIDMcrma5HMTX2Dm/lghB/mf3y7cM8SKUQ5/axDXbCizviDjnTmvQD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4XIsLcNViRrN6l1IdRgXReVzAG9ujYjIaufZuCcL6w=;
 b=l45eBi0vxFCkC4yKWC+SnVM1MyJMJrDdyjpfkAEzkG9nmOJfwhZf5J7705oiEBIs9UnaAaHZmkDXqKySxy5wV670SFv4JLRKLySC9d4c92cKZeC9Fv1Te4GKPsB0ibb/uRF75wrFWeXN1ej7nR7O03P8xsLaAMMcscyCZgimizO6imgvfGlUluVAI7vp12KLzURKa+8TUk0yHaFbNCsRsvG44o4NqZ40n2gMinz1AtLucZK4dh5UoOGJ6YQrmI0dzCv5uTV/v7oumttnQLo17mB94V6uwc+Uy69EQ1tqj5wsDiKhliT45f4bFY41sXZ8P3W2pOlYFJlqaqSH65u9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4XIsLcNViRrN6l1IdRgXReVzAG9ujYjIaufZuCcL6w=;
 b=ON+YqhUnUSaIV11JVYWeBWtKQsHAffLLcBFcL+8MqkwfXzjcQsHmUjYygntezfU9BM0G+EAcmrFqHdmejsClJ8SmCAl8wjJKgKgrGKF83AuBhbCvcOX5/HCUVSO0BYaJr8K4ULTyoi+rFJ8bTeWwE7spJoRE25IZfaJr2JUFNSU=
Received: from SA0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:806:130::24)
 by DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 05:07:36 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::64) by SA0PR13CA0019.outlook.office365.com
 (2603:10b6:806:130::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 05:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 05:07:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 00:07:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 00:07:35 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 00:07:28 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH 1/3 v8] drm/amd/amdgpu: Increase max rings to enable SDMA page
 ring
Date: Wed, 19 Mar 2025 13:07:25 +0800
Message-ID: <20250319050727.4099266-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DS2PR12MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 3468c339-d66e-4434-7694-08dd66a3f6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QJO/pYhl+eXQhr94L7ao+b1InwNA0mfEwAi3ntV8oi2iSarXTMELHYctV5h5?=
 =?us-ascii?Q?lbYUPsQ5YetiIUKET3EgQdeFi8S47kb4XiakHN2aeZYIpStWDhZuCoB+QhfO?=
 =?us-ascii?Q?uVv76HIOgVz0Q4vkNYY5sgxQa1AJeB+t9cJK931AOkO0afpPLyDwqPbZqv+o?=
 =?us-ascii?Q?9FxevH3XFZT44e62AuZ1rVS9y0z6ilqZZoApKBzWavfWS4tCEi1W13Oq9T2z?=
 =?us-ascii?Q?NRA3arEI682agfVDuhWvxAuqwqA+d2VVSiXaphXd03Hwi3BwUtZ4/Plg1DWl?=
 =?us-ascii?Q?aQ87SOUp+QEld/Blxkahrv9YAMfiBAQtEAM4W0eFsvCuYh6NLmIz8H9fLMV2?=
 =?us-ascii?Q?9bSQpiErC4aHFVMA70738Jt1X3A5s961uvR10eU5L0uVhfjI+yihdikuZpp7?=
 =?us-ascii?Q?2yyuqrIf+ljLjw2FvKGAVSU7em0bGsMvTsLJxegDAAFp5h9RWAKz5iVavvGL?=
 =?us-ascii?Q?mArGCyHc+6RiK9UyLBxvFyOVyUJdw0QT/TI1GxQALuRMR3uYMhusBbvXgDad?=
 =?us-ascii?Q?r6opFWPAf0EjdNefIFDXFud173LRBPwfcfbBMIi8rMU0SAhkwm3ew9BENuc/?=
 =?us-ascii?Q?BaGOvv3w604ONDSSc/w43dTsnugBRfSMMHGMb/bx4EllJRO2c4Da3SCa9UkE?=
 =?us-ascii?Q?P+LlnrLmaaP5yEt52dweA5pmvmzgYbPGKkVPj8LWayXcdX5twYEYS7G5WWwP?=
 =?us-ascii?Q?8HRxdtgTyN6H5O98gYGDF7EylGvbKUnmrvUMh39/x4foHdgOPKTby4ud1WJE?=
 =?us-ascii?Q?phZW3WhFrA+2vmcXAA935P8ZSoP9yTQAoSIH3/3gQMp1GD88Q1CRO6IdI2ni?=
 =?us-ascii?Q?QEGkL2ehVRb8kvxSK6VxhGgRtaZPwvu8AsgELrV5k/yVWdQDoaay8kYdlJMc?=
 =?us-ascii?Q?7WXoomkcdY9mwMa67beE2eI5XRkOdmp8ygJ/AKADo4Y7/6LdwmwQD+/0yqFx?=
 =?us-ascii?Q?YLObK5dbzeoC/Pj6rZbfOGIkqX0ycX++P5F7jOUDONP+7NYdpI/vJLmd8GWW?=
 =?us-ascii?Q?+wPVDSP7pkB7bDDesXljmQwkE9Sm4piB9HYXtHb4YOoVWxGrPq7Cs68AZvSS?=
 =?us-ascii?Q?66k26nrheABmiUvwlCd6JjEjrb6a6SwRAIK78aj05LeP2MZX9t41+4n5UgOq?=
 =?us-ascii?Q?Wu5Nqf9PduC27X4x7yUesBGDGtIIWud42UeuOdslDkeoEbJ4oSW4LmcAN89n?=
 =?us-ascii?Q?S1bU2otJWJjxEjCleS2YWpPLdCNzCYwyNM9bpodOL2mb+tQZqFk9klhnd2lz?=
 =?us-ascii?Q?wnFb1AX2Z4ZT6sYHXktNpn5p8trGX44Z+OMXq9XhXYhl0CsVWonBYXclVAxr?=
 =?us-ascii?Q?U2VBi3L0Jy9tjql8HC7M0WaMBmmoguOSXR7x9SxlqOC8aW7kdyd9MexwZvRr?=
 =?us-ascii?Q?IjareAG/EMMhjCeHnqUaWlinpC+tzDTTBa0DLBkCzlO5qGqT3UwQLZ+vNsmD?=
 =?us-ascii?Q?Hc38Hkt3sH9B0joILJwxPBuf0HrvWWwylhrjm94GdMSSs6bMjg0EfAhcFD2z?=
 =?us-ascii?Q?m0Z4Pb0fdwPWifY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 05:07:36.1298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3468c339-d66e-4434-7694-08dd66a3f6bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Increase the maximum number of rings supported by the AMDGPU driver from 133 to 149.
This change is necessary to enable support for the SDMA page ring.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b4fd1e17205e..bb2b66385223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		133
+#define AMDGPU_MAX_RINGS		149
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

