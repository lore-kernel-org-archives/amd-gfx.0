Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383B5D12D60
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 02:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB21910E11C;
	Mon, 11 Nov 2024 02:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XMblRO3H";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2582410E11C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 02:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcaASJbdM1L33futc+Np7N3pDkyX118Qx+euZGkg3KaPSi2qXX4sTDrc+JK3EqpfiDia1tKVbvRebVytssMSMO7WMGJDtmP+Z92dWI71U9Z8GegEoAvGb+i+qTvcKvzR94Kr08BtcgIpTkaxle6m+P4bvyTK0D4GNlC7qobMj2zFgsZI/+U8vHtNeJDWcTRN4EqegR4xmrMTRS1JrnzoQkAGF2tGfoH0eqx8rcp6Im8VzfQQ0pDFxOX5Uz9RPEwSadFyh0ge+ZgiR269dRoANbNZ0bOc1rnfkNmXczXIUMOQO0iSFNDCx8THxj4jd5Y6CNqzVUs2Qjl7mdGGhtKNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TaXzBKqa5IiR2ESXu6dU/UM9xPt+PV3mbNyVE9kKuY=;
 b=bV63yHIj1z3+3c6vUOIwIHM/o4maR9kuOU0Mx7P41qawwReTTcM8l5PyRZ8NCGC74CWTq+pIpiKxR80DCJYfI99XxZsTJ2FdbwOuk9rAeAkxV2kv6QJWOyyQXyxE7zDfFfHBhRSqtPY6xWEQJ3UZzRhLjtI78UEGj0BG0/t6xOBSLylJNJw9AJPm7XF06cQNGEZVtuxVBz5Ww9DBgamXy/WMcBuHvd3zzcsWaALNYzABlaKaFrB664e+MSF281RSvAfyiuo6ArPExmlyNN3wg2qCCrnELnO+5HZavobGwufsi5vnsq99D4xc6/QH/gA38+CwMGiJRRlGWbSHHhLIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TaXzBKqa5IiR2ESXu6dU/UM9xPt+PV3mbNyVE9kKuY=;
 b=XMblRO3HRLGW+Jr9ym1LFElrbBIjTD/R5qBDv1P89ILXcHDju7EcalnoXhuLoErtpWcPexDaH1yZvLSLFPfPgKaN2yA8uXyy4cemLpPcaBRWvjtzcjvbp1h205gx7tI7t4a/YEj0YM/DoukZnqyEWicrJxeRfkJBAnpgtsDikeM=
Received: from SN1PR12CA0067.namprd12.prod.outlook.com (2603:10b6:802:20::38)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Mon, 11 Nov
 2024 02:44:47 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::33) by SN1PR12CA0067.outlook.office365.com
 (2603:10b6:802:20::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 02:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 02:44:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 20:44:45 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add missing kdoc 'inst' parameter in
 'amdgpu_device_ip_set_powergating_state'
Date: Mon, 11 Nov 2024 08:14:36 +0530
Message-ID: <20241111024436.1881300-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: eebb8c16-3402-4124-fa96-08dd01face63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGhGS0xRVkpENUYyM01aU0ZzWm53aTNSZjdOMWVUdU44czdmaFQzVXkyNFZ5?=
 =?utf-8?B?UTd4K2tVSXc2MXhwUm80aVBzR0JtOFBjOUk1RERGM1BHaGlNdCtuRjFJMVFE?=
 =?utf-8?B?aGVpQUh6S1VJWlRjNkVRdGptdXZud0J1T2VRTjUxWkQrYzYvbGx3NE5LNmNt?=
 =?utf-8?B?ZEtxeTVxYUpLMGpGZnIwQjlsU1lMSHdJUzY3TS9Vd055T28zcnBrWG1qcklD?=
 =?utf-8?B?a25NVDJQNVhEQ2hBYVV5MjZTTUpSbWJsc0Jxc1ZZTzRhdFBMeEl2Q05WRzZ2?=
 =?utf-8?B?OEZZNENJNGhsb09pTVk0dXVNalVSZzhWOUhBeFFYR0J6bzhKVGpJM2VCOXpx?=
 =?utf-8?B?a2IvZitOaGdNR3JFVThmNCsrQkdwa3F5L1ZJUU9XQ2M2VDVEZ3hKSHM2TzBl?=
 =?utf-8?B?N2Q1REhuaU5zZ2YzQ05YRDhNRHpCbEZhWHhHMUkrSTRNTGhNbnJLVGJnblJR?=
 =?utf-8?B?YjczaVNlb1JycHY5MVJZVVBBbElpcWZUb0hrUlBEYVlySzJOb2JvNG51STJr?=
 =?utf-8?B?b0Z1ZzRnY2szUWpJcndPUHlieW1WanplSVByeldhRjR5U2UwNTRJMytFS0Ri?=
 =?utf-8?B?ai9VeW9tU05XNXVZMWErcU9yZmpWbEh4dW9lYjIxL1kwN1I5MGRKSk1weUhT?=
 =?utf-8?B?SGNScXBWOXlXUzluMnliYWxjeTlRVFZmWU1MZHYxRzFJUE5hVksvak81QkUz?=
 =?utf-8?B?aTduN0FKMzVDWXRxbmVYRW5JaUdZQzJBWmlwNVFqYkpOdTRYWVVhbklob0d1?=
 =?utf-8?B?d0V3Ymp1RGVKSWdNSzdPaUJzQzRMaUNjMWx4VlhYdysxdFRrR2QwWjErVmJZ?=
 =?utf-8?B?WExqWHVZUlh0bzhMTzE5cFAra2pYSWFXWm8xVCtRTWZ6ZThlWlVrY295SzlE?=
 =?utf-8?B?ZlZld2JPazI4YUJ4bEJpbWtOd3M2MVFPMjRnSS9sdG5sc1ZNZlBra2tBMEpx?=
 =?utf-8?B?dXFhd3VMMGJlTWIxQ2hpYmZEWVB3ZStaQ0Z6dU54d0pyM25QbWNhTXg0am42?=
 =?utf-8?B?V09uSnFSRUlqWWd5YkpmWHh0SHRSaE4wYXdRTzNPUWd1VWo3d0xaczRKVzhF?=
 =?utf-8?B?cUZlQ25UMWdGeXZYUzhwUWRCYVFadjBRRVBtOXVIMjhZNjRRbXorOTFLc25j?=
 =?utf-8?B?UUdFd2E0dWZuMzdKRlN2TjJXRU1wbzhQUi8xMzlyNllqWHZlNWhEQVJGbDQ3?=
 =?utf-8?B?cHcvZEd4NnVYQkxzSmllOHVqWS93SzEyNzdoTjBXcm1hdVBtcUkvbDFmbWRR?=
 =?utf-8?B?SWp0ci82eDI4bkdYblhoK3BycW5tdlVqQmpNQ1d4T0ZsOXQ1eUpkN1BmUm5L?=
 =?utf-8?B?eFhnenA2b0xmak1KM051TDc3QUdZODhTckFFb1RwaW9meTVSMHBuSkFtYWVR?=
 =?utf-8?B?d3lIZUFwbmdqcWNMMndaK0thM1E0SVR5NGR2YyswZkV4QU9Hd2Iza09YTmFn?=
 =?utf-8?B?Wjg3dEtUNy9rU1R3emxtUzE0cGtHQnpqMEZWMlJORGdoMStkQVdXVkowVzRr?=
 =?utf-8?B?VVpPQlpBMm1zcnlHWklZK0w0K2x4NjIzMjQ1aURhSWd1WnBURHlIZjZmS08y?=
 =?utf-8?B?dHhOWGpkR2hrdUJwNkpicU9UMjdLT0QrWUMvRWVCUHRVUDlNM3BTNUlGaFhq?=
 =?utf-8?B?dk9iVlNBWlRkV3JGRjNsUkExa2psL05WL28vd3psdnFYOEZRYjVZZ01ONlFM?=
 =?utf-8?B?bmpTdVpHemNwM0lwUFl0WG5JcHdmZWZkUmRDYjAvOHZ2UlN0MWQrU0FwaHJW?=
 =?utf-8?B?SXlIcUd1TDR6c0VlSE1Gc0pOMGdSby8xNlY2M1dKRE50K3g3N2JxL1QvTXMz?=
 =?utf-8?B?Rm9xVXdFbUphR2lyV1lGU0tRS25QV1JOeWVKQWNaVnFUWFhZQTVWTFIxbjhJ?=
 =?utf-8?B?TjBtMCs5ZmVCL09GZnpleThIN21NTGNyK3EyUktiZ3R0SUE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:44:47.1807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eebb8c16-3402-4124-fa96-08dd01face63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:2182: warning: Function parameter or struct member 'inst' not described in 'amdgpu_device_ip_set_powergating_state'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bb530dd2b3e3..84cda483445b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2167,9 +2167,10 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 /**
  * amdgpu_device_ip_set_powergating_state - set the PG state
  *
- * @dev: amdgpu_device pointer
+ * @dev:        amdgpu_device pointer
  * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
- * @state: powergating state (gate or ungate)
+ * @state:      powergating state (gate or ungate)
+ * @inst:       instance of the hardware IP block
  *
  * Sets the requested powergating state for all instances of
  * the hardware IP specified.
-- 
2.34.1

