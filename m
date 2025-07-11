Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6211AC83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 21:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0183210EAC3;
	Fri, 11 Jul 2025 21:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0i/Hb76B";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9641B10EAC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 21:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdyvtHLmwZb0lyRhKTiUr/pKBvmVIN8rt/deiPCS7cKGSrPuKNrDnDz66wHc+oW+mIURTwyzaTwwwCCoXgk8mnZ4qZYfff2YQk52gxjxfc2KULPKCn4lf/fyJxiYyQpXgL0h19zS2aAbzciIDO37fTLkyABdV24aFjMcihh5nvyY/XVs4QPwG++6hGPVXxDg10q2snJ0QlD5L8kYqDZkgIxCG4Ey7mVkeE5j3/HZdzyidbGcLS/vee/6wPL1THR4PhNcry5jdJOUu0aFBEYAzSN7iPaV8BmG27OD2qL+zn6SZoCoTMA/03yvKeQXmd1eUqk418RkSRL731kJW71Eew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9VTxuRoYlynQs1d2RuA4uxzRouovTGpL/794PDqxRw=;
 b=YOA9czN89Tme+MvF9X/q446xBIQonN5FsHVV8Ztzks90fvyo1vHTqaj3MULUXv/ymvmbjv87OxdNR+rdabZxvo5a0m8E3lCrfvqtaZvDersYERWHRRS2giqhwNM791eUaPYYPKcZBrDf+a2FInUNOLz/z95mKKN3KsJkhNORRzlwq1L4Jzd9BsUn80K7b+wNfAW/lTgGe3XspZ2wciZLWfPzUcduvIDYMXEEkm37V5D48gzAOVvf1Vf0HAq90JJ0oyWFEOXhuRxnTLLJVHGKFO939kOLpYJm1foCViQ+l60vHM890IAboyYNoXp6EQzXlyamRADdl+3kPy+JeEjAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9VTxuRoYlynQs1d2RuA4uxzRouovTGpL/794PDqxRw=;
 b=0i/Hb76B9xiD718Ukfm5T6KYf6QkZOZPoV/dNMtCvxJ/EShuQAGpN01pmr2bKN+h6eDM+nK2yaRlBvDz57cW7kHrBoyKdYbC58Zs72WU/Sr6GjEgc8dDgOUstGoLq3cMEvo2jWgl7GsinH4OrhBHV91YsGvFEI0LnWawtSD4sKE=
Received: from MW2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:907:1::16)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 21:51:38 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::d3) by MW2PR16CA0039.outlook.office365.com
 (2603:10b6:907:1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 21:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 21:51:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 16:51:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx12: set MQD as appriopriate for queue priv
Date: Fri, 11 Jul 2025 17:51:22 -0400
Message-ID: <20250711215122.23288-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711215122.23288-1-alexander.deucher@amd.com>
References: <20250711215122.23288-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfb713d-a827-43b0-ccfd-08ddc0c51cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUhGemx0RXN0WXRmcE90MzZXUkVjam9VZklvR3ppZXhlc1pkUXhlSG5xNmdx?=
 =?utf-8?B?MFRDZzhBQWl1aU9VelJXcXFDck9mZlhqSDBsdXlLUjV0eEFtOWY5NDJHM296?=
 =?utf-8?B?YzY5d0xvYkduWEFGM2NhQjRuRWNOZzJTaHl6YVhUbnhqOFpJeXI5dGJqMWln?=
 =?utf-8?B?amZkQjRRSnNDWjRNenZaa2lMeGZ0aitwTXNYTUxuc2VVUW1qYnI2N2RjbU15?=
 =?utf-8?B?R0k2TnJEd29UZHp0NGY5enVwaUx1U24vNjNCWGdzVnBvSEc2bGc3Tm9hbHo0?=
 =?utf-8?B?WWRnblk3UjJ5L2tNaUpjSGRCbVphMGZsNUNwYm1LSWprS0k1azZRTllibnJh?=
 =?utf-8?B?SGhON0tLUmVBYm5FUlpwUVd4T2tFTmk5ZTVJUWJDWms0eVFTdENNSzYvZEcx?=
 =?utf-8?B?WTJBT0szUTlwVEVzVWxjMDlUK1I3bkpiNmJhSStSZ2xDeStJS2Mvam45T1px?=
 =?utf-8?B?dGxhejUzaFRFV1c1UWVzOHdYdXRVazdieXE0bVJwMmx0V3BvTlB2TDhuSlhi?=
 =?utf-8?B?dFJxU1g3VURVcXoxMDRFZEJ5SHpVWHh0c3JPOGFVam00ci9RcWxnUXBXWHJV?=
 =?utf-8?B?cUFnRzJpbFdSSHVqWDZyZzNaK1p3eVNCRUZITHp1aEJrZ0FVWUszU0M5d1oy?=
 =?utf-8?B?ZFgzUVdCeEk3ak1PTGpXTzFub0dweEFpTlpBOE9xeDZZYXlzRnBScndRSksr?=
 =?utf-8?B?emd2LzAzU3VvMmRGOXg4RDgydEx6Z055R0JEYVpYcERvalordTdsRGFRdlBP?=
 =?utf-8?B?cHZ1U3ZoU1RTS3ljWFVXc3ZKTklkMC9McGJOeTFBZnVVVVl4K3hiN0V6N3R6?=
 =?utf-8?B?TjFPUlBMajJmTFViQWpLM0pNZDJFNmZYNmFTLzNHQ3JIalB6NzVwU2h0SjNr?=
 =?utf-8?B?dGhtVkIrWkM4UVV1NTVwd2I3dUdheVBnT3lLbitiUHEvakVHUkk4SkszQllz?=
 =?utf-8?B?WkRvWlJmTDdzcVJ3V3I0bEpvUTdNZURldzN2SXBOZEdxY1lYcnNPSDk4ZlUw?=
 =?utf-8?B?R1ErTFFabHl5aU1NdnYxZENmQ0kzVUw2Wjd4c0pscHI5eTVqU2M5Z2pWV0Fu?=
 =?utf-8?B?Y2dCWEdaOCtVRk1mQURPbThwMXRaeWR0dWdqYUVwd1dhS0U4Zlg1RlhTMTVu?=
 =?utf-8?B?bENrV3pwQnRQcTJJRmZmQVJnbm92T3lCc05IYlpOMGkvbHk0UUFFNS82bkdW?=
 =?utf-8?B?dVF4Y3l2bENtTVNTc1Yyei9xY2xUNDRuYkt2aUxZSHRtOVlzZU1uS242ZEN0?=
 =?utf-8?B?YWkyQnJmcDhCUXh1NWY1VC9UUnhab091ejZwY1lEVjhWcHJqSTdaam45TExo?=
 =?utf-8?B?ZFV6b1ZEQytGUmZMNTdlVjRjUU5pczViem9BN0gzek1QR2ZGMHFQL0dqSGJ0?=
 =?utf-8?B?VkpmcG5nMGdxN01iZDJyVGpoVjRiTmVqZGFNYWNncDQwMXBodkxYZ1RsanNj?=
 =?utf-8?B?STArZ0kxZHdvR2RJa1FJL0wzOWs3Mzdqam9HKzV1ajVPWjI1T2lMK1ZxUHZX?=
 =?utf-8?B?bXN5K2p6WjJXdGxmT1M1bjNDNDhXMmkxU2MySENtUTU1U0YwQmxYY1dLNmh2?=
 =?utf-8?B?QkJoRUR4dnJHUzlzSFNGU1B0eCsxaXRMMVVCMXBaMWxiTTczUzBCcEwwcHpp?=
 =?utf-8?B?bEhNM3p2WXNVeUFWNVhEbUVsYXNFT1pmSERNZkx6cXNGc2lmcyt1RG9XQ1RL?=
 =?utf-8?B?TVJZQlRhNW1mZlRFVlFSSk1JbTMzOUtMbS9PQUswb3FLU2xiU01qNlMzUTJn?=
 =?utf-8?B?VXNxUWZIYko1akxDVis0ZU95VEpMNWYvdmIxM0tDK0kvM0VlaXlCUXZNMnpv?=
 =?utf-8?B?dXFFRmRYTTFkaXJHTlhKUnd4amQ2R2w3WUM0bHBOVXdyV0VvTzZtY0c4UXRn?=
 =?utf-8?B?bk5Za1FyNWwrVDRjYXFoSXo3NUlzekQ5YXVWSjNIc1lEbHZnRStXSGFvQWhW?=
 =?utf-8?B?ejIycGltb2NKWlF1RVdlN2x3S2kvNXgxYUF1WElncGxaaEdFWjF5bm4wWXha?=
 =?utf-8?B?Q0hpK1JxK0VkSkdyZjZpVkJFNWJsMWVuTXZ3UzdEUzlrRVNHZ1hQVHpYcXJQ?=
 =?utf-8?Q?bBTAq9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 21:51:38.2362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfb713d-a827-43b0-ccfd-08ddc0c51cf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462
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

Set the MQD as appropriate for the queue priv state.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e4fc42470cf3e..c4dc6bfb0f6f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3016,6 +3016,8 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 #endif
 	if (prop->tmz_queue)
 		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
+	if (!prop->priv_queue)
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV, 1);
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
@@ -3165,8 +3167,10 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	if (prop->priv_queue) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	}
 	if (prop->tmz_queue)
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
 	mqd->cp_hqd_pq_control = tmp;
-- 
2.50.0

