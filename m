Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A35BC83000
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 109DE10E80E;
	Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RhJclyaD";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0530110E7ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5GvYd94htn1Dv+dXfvl+vhXa5CSQeik0t63Zztk/7SeTwgksQoSMc5eDSKtu9c8TA/s/slMfu70rtBfxLoN2kAvHfg9v8mV0I925i+39Fr8h02QeVzTZHoRHHDsbRtUjqQx4FDglH2JBpGLeiAE8ujWsf7JobuPSLiCCVjvdCtYjsK+AYzub0+VEMI/DYZUyQ3D0KAxyWChYs3TwtfXz1vz+imG/+gCkb8ZYc8ABFWVH8mWD3Juf/agqtQyjdi4Yv69Q047Ai3jDfhtdM/sNrAsQOLPcOyhnOttJ7SPGqx/IMSsotZp6Et8cbPn2oITaTIcb3b0Ac+/31K66TZwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=DK6kUh5MDGbjcilgZdech1SZgViJ/DG1NwxeAcWb8Kj/uxsOdv15gGplKWlOfxEpZ/32dlK2q16t8CYYOndyWu0PY/AckoHZX1/RT7bqozagcsC44Sdagp9Wu8KOM0nMuoZDo0/D9KkTK6L3iC2jHiLA7AJm+0iaf+v/2INBkloPIBwV1KScslks49IaWMlrZb5eSRqYnvi9GH+bDTXtLdggKUAT8mskqJulWynMV+hhb4TetFAArqmA7jzJ4iaWiinlOWDg8UT5DffnRE6ryYF8b0Q/ETtXoeVx8WZazHTEVXz41JO2CXvQYGxuyvUsAf0mIEO31JrqZFKNm19nlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=RhJclyaDvF9su+AO6QDQGc1undLFuVN+fY043EnKJn36HC4oG+eU+AykRqEE4bV6hWAFzRrkR8eyTRSUlrCmS3HBYHAyodyJ7Sd+UCMCTE9PhfWixKoUrcIlsrqAgaJ9QO2hpO50oFUKdhHLfDv6guOlJMb64kTxMKLtPrPvlGQ=
Received: from BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47) by
 MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Wed, 25 Jun 2025 21:07:10 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::bf) by BYAPR01CA0034.outlook.office365.com
 (2603:10b6:a02:80::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 22/30] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:30 -0400
Message-ID: <20250625210638.422479-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: f7270139-2133-4b6b-2bf2-08ddb42c4022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7KVw6mCqiy4O1dR4on1ExDGm2xxpPFjdYNd8PzvR8BcljULlac7M2GrqYixf?=
 =?us-ascii?Q?4Kfx6UoiIdCWN9KV5OVFYNobrW0pHBmAy2FlMAZMocfaYxl07UrcoF+e/XRx?=
 =?us-ascii?Q?SbUqw1KU9M+bax2DOdqMFJdz3LAsyMmoRIVta1wdY/IweHV2IOnt5s9ESg+8?=
 =?us-ascii?Q?hU3grp4m0KHpGobPWSo9gA+BaQ9Ncq5kgBC53sEotR7qx8dQskJrrCV64XC+?=
 =?us-ascii?Q?5vJ9i928aIBmZPOIah30txiaKJ2ketAlnnV8sZYawnE0+KE6DI/99viu//Dw?=
 =?us-ascii?Q?zM4ptVGNuytAfk93OaoRGfT04YBR1SZmnpmLrU/WTLsjZsWfn/JckMxHzoCx?=
 =?us-ascii?Q?op4Llh2sRrFv3jdhz6TqSRrK1htJQTtEGUdxHjkt6Tmgzb0LSJkRQaeHdr0V?=
 =?us-ascii?Q?IhzfokiHGpgQA7jdCOduJKBfifvVJb9Su25hybUPY6J7diX33zoeLXsmJXnk?=
 =?us-ascii?Q?gEa95+EmS5kDhhLCU/VcYHyXoHKbOq/P6zh9HiBSmgDNJySdRuRHDWWLzoBR?=
 =?us-ascii?Q?3lbRFrd9L53PWgTo7rPSET5PgHjAOg2wgca2M6k5gcvha3D/C+znRjznixXv?=
 =?us-ascii?Q?Y/KIbd9Y20A6AullhunZDSsRd9ip8nAlfnKefCWSgClZ/FaAhCRzdPjp5WsX?=
 =?us-ascii?Q?uUhMw1wwiSJSCQ+FeaYywK7CA6/s3puypRuvZaH6IdAPsiiGm7Yh0lwIDCTA?=
 =?us-ascii?Q?3qI7nUfgE4wmG6Ldsn638gV2k0DOGPDo2RC+OJYgxGFVEFaLsrFklMrRTCcZ?=
 =?us-ascii?Q?x1cIlRci1UqHYoN09KmUwFh/Lsyjt7d9MdHuDgbljHxOxz/O0XRiUFoQel+E?=
 =?us-ascii?Q?lE8R//kd7YVhurmZec/m4sLELC2iI955NZogX7hDVN65SiyBej+4fBSeI6cS?=
 =?us-ascii?Q?yXtpz2678ao+8joFQkb1SNlM4IA0zww32rN7+sko/5hn3kqETDt1Yr9AJiB4?=
 =?us-ascii?Q?lh1BJefYyJgF2jWZ/ejInHGzfsvvAd5KlqzQzcq60iS7HjFsl8tLq6ahAsw/?=
 =?us-ascii?Q?IDePMPiXe6YezAmkyFdlIjL/lpGb/FoCDASEdPQ4rrDVqPTmfRHqIyOI98A9?=
 =?us-ascii?Q?TzfaCRsxs0fHlbA1jHstCmjTUHDEDQtKa/yCcXBWlkA7VemvNhHcuo580kYw?=
 =?us-ascii?Q?8baeEMzHpBwhC1CxmwvSaLFTyVaQrIPvhOZRMIvdGFFt45NLgjedBQwmHa4j?=
 =?us-ascii?Q?PifKOZ3k9z32ubmwr9i0MuskMLPGTAIAfhpspFkL1LSfPjFLEXdijaJLDPN/?=
 =?us-ascii?Q?gE4JMmFphNmEWhiIlAjDBx3QEN8xnleIBFQtQp1xH+5BWbf1HNRg6TB96Bhy?=
 =?us-ascii?Q?g84Yxfu50E6ZzmDx5NJLJxiUmB8oPNkr8Rrw51nK0Vb9Zw9kssOLGmF8HR70?=
 =?us-ascii?Q?tUKQiI8o7st1bR7CiohpkXOPogUM1GcF3rFYGU6V21pUunp4kRQzCZXT0J06?=
 =?us-ascii?Q?m37vCbixcY8NvBJZLAoczgcmUWSp4FOncn57ODXwOmoihgFWyG301w8hWEnC?=
 =?us-ascii?Q?KY7aJPFrcFu4Lu9SvUQeXfEtagCYtd4J7WUC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:10.2670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7270139-2133-4b6b-2bf2-08ddb42c4022
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 6f8a16da9d608..5473cbaa5c0e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -838,20 +838,13 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
-- 
2.50.0

