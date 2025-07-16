Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45E6C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 22:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5538110E2E4;
	Wed, 16 Jul 2025 22:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tZ0oZQiK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E4E10E2E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 22:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYdrPhDgHBLqyg9IUO5uI9P1NuhWk04glHmeBLaDRHZ8pq44uzAP1ijT5YsS3HTqkPuKtO4MLJ6IzczSSf9k08pYnFUE5Zh4059kz7EUOb/HddLPjlQSyRMUqB543+5oWAvoZtEI80SMEXSxLIqlzB9fmgyL+bPZWyxSs8QuLIf0ttq+z2EdtZ0mLseg8DazLevcQSYWF6rDHGenJ47dii5kLrQg3riDj9OcmaPzeEkSoHfr0ZBZc7bR4zxC4VjYj/t6QzuRyKTiJ2/k6JA5cTzpLA274uBYI5f09e79QaGVJEl8IVnhtTXEkuEadSPNZi1195iAHqQJQSrX3SRcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFQJkJzNaOca/TUvgapcrL5UpneNMamvoks2f9XvsmQ=;
 b=eZzW7Tu8cuozsmRS8GNqi/g7sD/PWZmgcI7OIPKr6hhCDpUp49lBLJzvA3NQeMzfxOSOQi0Wf07SnP/Yva53qhRPu3II53aEpHY4GkxsKaRTh/Ebj+iqX4l67qiznH6JRjxfA4zYipp6AkO2MP5Q9/G+JYDf2srR1Rz3H8SR08Jb7x2KIruSwxqLx7/gNeKblDIQec33GK2kQvPmFftS7t671L03XUo0tobXucPVBr42ZtWNfnWvm1N4MXfVHEUvWmAUA+fJqyFJazn46cZF0gRtXdSN3KLJS+urbTP/9uns3ycjOM1guQQkXT1hfVvUUUXFB1hVcV8iIUW2KMV9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFQJkJzNaOca/TUvgapcrL5UpneNMamvoks2f9XvsmQ=;
 b=tZ0oZQiKzCCguc68FH2p/e8FSGIRBwr7oWBvd6m4GKuCbIFm1RDvCBl+f6u+5p+ZU+KKLt0K95w9/e4M4Z/tqy2+Tyn8+geBkoSOW1vcCXF4RcDhr7rSxIj+LLScBWEt5UEdZwEvvjV48vOXGXdpRsvALkDfNVFbOXkK4aH9ghg=
Received: from BN9PR03CA0728.namprd03.prod.outlook.com (2603:10b6:408:110::13)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 22:01:32 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::bb) by BN9PR03CA0728.outlook.office365.com
 (2603:10b6:408:110::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 22:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 22:01:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 17:01:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue types
Date: Wed, 16 Jul 2025 18:01:14 -0400
Message-ID: <20250716220115.3872837-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716220115.3872837-1-alexander.deucher@amd.com>
References: <20250716220115.3872837-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f75f631-3e79-4da3-3f73-08ddc4b45315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2gzSGJiYVRhNkU4RWtnRjU3b28yZ2V0NnhIaU1hSVlXRGtrZ21UOW80aHYy?=
 =?utf-8?B?eGNtOUZqdFI0cStrbzNEZWRaRkRzSktBaTNLNXZFRlNkTlBsL3FHSGJWakVU?=
 =?utf-8?B?STlLeWJBdHZTY1dGNk9tck9TV3FwdDdyT0p0LzBlck93SlJFS1lIRGc3Mk5o?=
 =?utf-8?B?a0w3VHhaS2w1RTUreEp5VWpoRlRGVjlkYmN6TXZVWElYL3RCTVc2OEtJU3Ji?=
 =?utf-8?B?azc3REFxZXUvdEhMZG9BbHlwR1l0cjMvSmZuMVhZdUlHNFE5dDVrdnVVZjNC?=
 =?utf-8?B?U3VvMFptenQrUDJtS1F2MFFLbHJmdFVRSmhRd0c3Z2RxYVJmRGl0T0wrUWFJ?=
 =?utf-8?B?NU5pM09KeXRVVGZKK1czTi9UVHhUd0RmaE5pcE9JRi8zQnRpWjZiV2k5LzQz?=
 =?utf-8?B?alVKMDNNWmhjZ0d5QkNhUDRDVFdxUVYxM0lmektMTm5Yc1JqMW1FRFBHN2Q5?=
 =?utf-8?B?TEQvVk5HMy9YRjRkRVF5Q29TdngwSmZhUDJwcTI3a01XN3lVM2g3TlBUdnhV?=
 =?utf-8?B?MmVjUUlTR1l2RzMxL1BVZWJrVzJxVVVFWnFyakVIZWxHZm1CRTdKMXhuMmJT?=
 =?utf-8?B?N2NUWlVIeUt2Tm9DZWduMyt3b1ZkUDkxU3E3bm1DQkRqU3M3WDZ1SHd3V3ls?=
 =?utf-8?B?emNXSGo1dlFDaVhsR2hQeGdJaVE5aWhZQjZDR3ZmSmphZHltR21PREFtMG5s?=
 =?utf-8?B?Qm9jZklHRGFkazdZTCtFenZTejZDOTJ0MmVTMXZlSFRKOVZNMjJQMThpRHMr?=
 =?utf-8?B?OW5uMzd4ejlTOGxpNmxHeGhLSDE2WFZNSm9vaGFtV3pTM0xFQSt4S2tQaDJ4?=
 =?utf-8?B?OUFDdjljUnRGUVN1dGNMeHhvTll6ZU9kaERJT1VScDF2YVg1aU5IandYOFlY?=
 =?utf-8?B?bFp4U0RzcGJaaTVFUDhXam9SdDV0M1RQcDRYaENxTTVhM09HMHM2MmNYL3pY?=
 =?utf-8?B?L0F5WDhPWkxYSVVrOEt2SjN6cG1RWUlwRlUwUlU2Rm9iR1VrTHJSL3ZrUDU0?=
 =?utf-8?B?MzZwbGZsZDlWQVJzK2o1QVRsdW9RbUJxV200VnBjU0czZFR0elN0TG0zRDdF?=
 =?utf-8?B?TXI3TWNtQ0FqbDJzMnNvY3RScWNnRHFlaVhsODYzR05mdjRScHltQ0wrRmk2?=
 =?utf-8?B?a3NLUDRBcGl3S0tiaFNnSnRYTTR1S0owZUpYdTV0MnhsQVJOS0RrYlY5dmdU?=
 =?utf-8?B?dlR3V0NDbkFOTTV6bVJQdGJXT29qeE9QMHhUQ2RNNGM5eDlGRzhJMGhGWmdU?=
 =?utf-8?B?M1lFeldxcVY4ZGlLNFpKb21YUXZyeUp3YmdhZFhKbGFXbEsyaUpKNXlvbjFj?=
 =?utf-8?B?bitSVkl4RTRZZUQvalYxS2hMRFo1Z2lqSGZpOXBNd0JibS90WGhSbDlqZHNQ?=
 =?utf-8?B?RzljUGdDTkxQQXN6dG9ETTVJK25EYTBUOEFGRmt2Qmh1VkdxcklQaXFVV0c1?=
 =?utf-8?B?VzJjVzc1dnVoVW1YZW82YUxic2o5dHlCaWtMTnFidmhUL0R2TVJrdnlLMkJy?=
 =?utf-8?B?UGJVZzh4SzVBWVZuVGdsRU54TVRKTGkyRGRKekwrUmNuMjZDSUl3S2FuYWho?=
 =?utf-8?B?UVJzdXdDTVRsSkpCVi9tVlpPNGNvRlNsQTFzOFp5YmJyb2RqR2syd0R1UU4x?=
 =?utf-8?B?eFBYOFpQeGNNQW05RDdmWWtsb2FJSUxvRlI5TDkveXRXbGJxM3QzVVdJSzNB?=
 =?utf-8?B?RTZpbW9JUGprblVPUXBoYjF2RExJc0dldmg5TldLdWdRMkF5NEhMSG0vTkpC?=
 =?utf-8?B?RUIrSjJYSWpDeWdaWVdDNTQwLzFlTVp0U1FxNVI0TDdMejVPNWVORDRhdzEx?=
 =?utf-8?B?U0tYT09acFNINFI4dVBSTUVBZ2VUZDhFZDVrQlppSFNXNUZoVWNsbDI3bWxm?=
 =?utf-8?B?T3p2VGEwdVhzTUNxVDNXeTlJbnlrc1I3TXJteXoxOGwzMjRjMUFXNXNoTW1F?=
 =?utf-8?B?aGZYZnlwWnQ2UnJFb1daTmZXaDVaRlpheDRqb1RWMGJJczFBanRhamRxVElp?=
 =?utf-8?B?U2pROG1RS1ZkNGNUbEZCVVg3OFRBYjZOd2JSdUthVktOVHUyNXVWbGR6Tndj?=
 =?utf-8?Q?FTZb7S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 22:01:32.3102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f75f631-3e79-4da3-3f73-08ddc4b45315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812
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

Set the MQD as appropriate for the kernel vs user queues.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 372dceceff359..9dd49b1caa605 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4129,6 +4129,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 #endif
 	if (prop->tmz_queue)
 		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
+	if (!prop->kernel_queue)
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV, 1);
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
@@ -4281,8 +4283,10 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
 			    prop->allow_tunneling);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	if (prop->kernel_queue) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	}
 	if (prop->tmz_queue)
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
 	mqd->cp_hqd_pq_control = tmp;
-- 
2.50.1

