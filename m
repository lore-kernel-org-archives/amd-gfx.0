Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE63C83F27
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 22:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56ECB10E2ED;
	Wed, 16 Jul 2025 22:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sIgU4U2y";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A9110E2E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 22:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6Jp1Dv4k5kPwchpOG3MZ3f8mwdfU+acPr8iKMONGNJ0qNfS7wa9IcyqsAyqyo0qhMsmxSB+Qz3hAJ8+g/A0Hw/+K2KmRV1iu1AxHD8p2vYPWCqsMOOWwZfEsW6SGPhXJbi5IjemcW3L+e6AYdu4Ax7t22o3ARazugiRBW9OFp1fN/2jLDcTmsD+sszB028YO48aQ+GYp2mlArmaXnUkkpoccQTlWl7J6vWiuHLwzIaUF8XopM4yN8xAXC2SQk+VyIOpl9UDQuF1l7AROSJarfG32tVos4PRkWqE8IdNnRhsltWTA+wU3NYtB80pUokU1XpQH/U2zV1+RSi/XyLElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASCpAEqe2HUgdecAeUFZl/TL8QCbNOIEiGj0llLzySs=;
 b=lY1tzgopwPLmiyNO71+NMKrbqyrl6sS+Yr+//76MWz8BsdT/siN/iOfv8cuVDIIACIa8oKE566zVUbj3W8eMkOERaL6dh31AgXGHBWLEBMuCUw0aIYK35VTnNsj80HyAzhH0RSjmtdszAjqw7KPwFl72QcgiRhnILFaF1ibMYoLqnoiZOFma3lF3nAFKL8chhcOnIVSs/PnqD8IgZJR5tmREYo4sZzIMuk4TVVEQqFEY4LdWn5AzTnBLuT4dVcT5x1TJrkiURHMGzu9U9ne89OoQIhMkpJc3iigW1SE3beTPWMSJPp4MfA3eeqgG70Vvw9uoR0DmMwglK/mXemmn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASCpAEqe2HUgdecAeUFZl/TL8QCbNOIEiGj0llLzySs=;
 b=sIgU4U2yNnFItyA6cCIzuIAgakruW30zuovr/wVlFli/DTW8Y+ALeH+NPdkyES1GgB7G+fDX5sjW+Ow5XDjw+CnnNtp23FmGWMV2F8ToMjpFaWtOUmZ7h7AWD8kVv4IqUVq7uCoeHrkKgvQ8edTzl9o98L3sPlNIjsLKAoMxqKg=
Received: from MN2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:208:1a0::17)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 22:01:33 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::49) by MN2PR07CA0007.outlook.office365.com
 (2603:10b6:208:1a0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Wed,
 16 Jul 2025 22:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 22:01:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 17:01:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx12: set MQD as appriopriate for queue types
Date: Wed, 16 Jul 2025 18:01:15 -0400
Message-ID: <20250716220115.3872837-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: fdeded5d-7773-4724-f791-08ddc4b45375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjdSbmdDN3czdzd6YVBMaFhqZmlOMXVWTEkrem9nWVl2dzcxNVpYdVdqcW54?=
 =?utf-8?B?RURReDVIeHRuc3k3eDJ0MTBhMXUzQ214RmZuZDNSQnJ3eHZUaXRNc3VUZEdh?=
 =?utf-8?B?bWZneHd1aWUyZ3RkQTZJTGp2SEYwVmdVMzJxNU1qcXRGVkRpc0w3QWpiVFVH?=
 =?utf-8?B?bmlxU09xSDBhQjlDU3JDNUxiNVFZcGRvWnJINm1Ca2lKYjMraVlDNVFEei8y?=
 =?utf-8?B?cHNzS2NORC83MUkxZUFDcDdIVEsvYTlrUnNNZkFNbG53N1d2bCtlNXplZVpT?=
 =?utf-8?B?eXM4cFZ4WE9FZC9UMHhRRy9OeHJHYUh4eVh0YmJsN0ZaWERtVXUxT0VsQ29L?=
 =?utf-8?B?ZU9BMEd1VloyTHZFR1RjUkp5NXZLTzgzaFB3RW1DU3VLU0RJU0hNZm9Gc0NE?=
 =?utf-8?B?Vkg3ejBUbStpU3VWYzN3bnFLbWxZeVlCZGtNWkpDNzdNcGw5aTRaTjNVK0FG?=
 =?utf-8?B?RGdBcnhQUFlERU1WTXZpZmRoYlhTSkR2M3VjVHZzdTR3ZklUU1M1T2x1VVYz?=
 =?utf-8?B?cFR3dE40R24xSTJaL2RVKzVsZENOL2VrOUJ5UGJZbE85b056dEgzZ1N5amY4?=
 =?utf-8?B?Qk1GNVUzMUlvRFdFR3lBZlc5RXJ6TFNKNkxYejIwdHZydHAwYlRuajlhZThT?=
 =?utf-8?B?OHNwYjg1VDhZR0h2YTVqUWJ2dHRDdVJ3OFplRWtOQnFyRGJTbXhSK2p0ejU3?=
 =?utf-8?B?WDRHU3pqUi9XcHhHRVkrS1cvMGZNUEhxeXF6UjE1NCtnMldjUFVHc01ZQUZ6?=
 =?utf-8?B?YTYrdWNtc0NwMUs2ZTdYRHdLUk54WGR1bm9Qa041NndHbDhnTGo1a1l5SElt?=
 =?utf-8?B?VE9KaGpwZEorckZ3djNra1RMMkQyWlUyZ21pNkdseGo2RDh1cFJBb0R3QlFK?=
 =?utf-8?B?TTREM2ZjbnlobTNlOEpkSUJxcVhvMWYrcUZOS0MyVjRUcVBPQlZNb3VvYjRY?=
 =?utf-8?B?S2d5bVJYR1U2VmJlUi9MVHRkcEhMbUlQSmJWcmV5NUtESGlOQzlpWU5ZSkRR?=
 =?utf-8?B?QjFDS2Ixc0xTL1ZhUjM5VGRoalM5QVBIRzY4RSt1dHRnTDFuZkNPbG9IMVhm?=
 =?utf-8?B?RUV2bW1lbGY5NWhyaUFEVS9HNXZUVUZNUTd0MGVCamNES1p5SU5lczhzWHRN?=
 =?utf-8?B?UHo3YU9ZRWsrZW5YL2NrV3Q5OVUybk1jNmlEU1RqRUVwb0FUWi9vNnBWNjhU?=
 =?utf-8?B?WWc4N2hZcWlKbCtGMmIrdGt5ZVQ1RGRoc1JyQ1BtNzVVbSs5UStRTGFiN3FV?=
 =?utf-8?B?WGUyRkNGWUc4RmNGMjZPSCtQcjBVcEtoWEV4eGtScFRwUVZheUI3dmhsaTBS?=
 =?utf-8?B?YUg3Q2lldnE5a1lTc2lTMWMvQTNacGM3Mm52M1NycWkzdDZrUEVIMmNwQUh6?=
 =?utf-8?B?aTZ0ZkxicHdjeWkybU9OdFJDTDNBZFo1b1dTaktMeTJJWnR2RGZ5YWJ5MTIw?=
 =?utf-8?B?MjkvaVhOd0E4NitUdmhSVlRDcGRkS2hIVVlEZTJmemlScXMxU1VMWjhxbHJM?=
 =?utf-8?B?cnh0V2JXU2NWVVF6andReVVYOE5VWlh4K2IvS2Y2bkpoc0k0c0RWZFZWVU4z?=
 =?utf-8?B?bzFuNktuNm5sOE9sczR2Y2hXbndLTEt5MFhtVUdWbTUzcXdxc2xmMElVWlRl?=
 =?utf-8?B?d3NJMGkxa29qVzdpV2JmRlVOblgvV0ozVlhIaWt4dlJVV1Jjd0pwcTBLS3ZY?=
 =?utf-8?B?VW1CL0RWa1VyYXA1SkMzZ0NHOU1BbmFLdUJBbEsxS0VVTXltRGdETEZYV0pQ?=
 =?utf-8?B?OTVCc25zMTkvMjhmajBoTGtoQ1hxYWJJU3hBd2k2bklWU2ZNckdsRGticWh0?=
 =?utf-8?B?eUpvV1RXVFYyWmNyWHpEaExOeW5ZdmNWUTg1YzZDN2k3RTFwVjdQOVhENGhH?=
 =?utf-8?B?Q1NkaGFtc0Vzc25sY1hHaTJvb0pYN3NFOW5Ua2JWOGF0eVdUQmV1VGxVS2c4?=
 =?utf-8?B?NUVudXE0L2YvVjNraTdQem9ndVRGOEdPcW02K3VKZTJjdjBnVmdtOUlGWHBG?=
 =?utf-8?B?c2NGYlF4a0QyeW1xRTBEZHFUaFZSU1FZYk8vUHhWbVZEc2hsZHY0ckdwZllO?=
 =?utf-8?Q?4BQgg7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 22:01:32.9433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeded5d-7773-4724-f791-08ddc4b45375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 7220ed2fa2a33..73a04d07bb494 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3020,6 +3020,8 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 #endif
 	if (prop->tmz_queue)
 		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
+	if (!prop->kernel_queue)
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV, 1);
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
@@ -3169,8 +3171,10 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
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

