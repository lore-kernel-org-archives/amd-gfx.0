Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DCACAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 16:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A4E10E244;
	Wed, 24 Sep 2025 16:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SHfO3mlW";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C06D10E244
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 16:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Abe88brCc8IJeWgwSCpGSSk+AkS9xdN1pJr4Y9y1vacdcOF5Z7iukii5lw7GJo+spwa9Izp+V9XwTL23LB6v1f+SE4ND4POZr7cCp7WFeIwtdWLHmD0FtIXbrWWbKS+b2n6p/TrikPVLF13B9XL9r/NtNiSVZNLuELa3HhBZEwByfJalEdys6TlosyZpSSRzRIv6JbOf7msMlqSl771dv2g81Rb9XnTxAAOkjGlk6PG1152LJJw5dka8pZh1XqNubO8B3IBR8vDXxEkRDElRS5KG0/jPsESFBamuRim59ygUVARq3XwUPQI3SuEDiCbJWjLGFcSY2eBpLQnvC7K7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn5DbeFE9bTSvCgt9G1lI4O76DGHVdQfpn5Pl/Fircw=;
 b=O8VrB9RI7AOhf4rSOyzhLR1kHLQCYUDXZc0XGtsqfz/yUmSjM67qFLqOnyLBeDXVSUX4Mas7/Q5IwYa2rws9+8FPO0bXr01Ss/dO9+0Y0LIK6whI6mPECbtYqp6fNPNf7CKl4rytJRiDNuhFbmLGZXOmWVAkUdMtGM3nc+bCr7ffcZK4tPj4wfr+Y25o/ZoIjTPJ7dB6cpNUJ5RI9147Uebw9Se1Z23GDfHrSYRJvoHVEJuY3nzxE1C/wameP1rTUkHGDlzxnKfFwnwGNqo3OuVxxPE1nEreSPu85GHNPSEkFq4Cz/pr/k0vQc4esKq5/tXoih+qlj94jvs+7ltQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn5DbeFE9bTSvCgt9G1lI4O76DGHVdQfpn5Pl/Fircw=;
 b=SHfO3mlWsvbCBpsGvq3gOZERjPSdBJ7wsI73lTfoL8zk1WJEj0s/wElkYrUdOJ+7H7ZtN1cNAEmCj7hycqdsWuZX+JSkkoWYGTD76uKb2E4S0YAAd+knG1o27s8k6K4bvmXQCbODb984d9uhNQl56FxErdPUOXichRY1xHRcg6g=
Received: from CYZPR11CA0003.namprd11.prod.outlook.com (2603:10b6:930:8d::6)
 by CH8PR12MB9815.namprd12.prod.outlook.com (2603:10b6:610:277::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 16:16:47 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::50) by CYZPR11CA0003.outlook.office365.com
 (2603:10b6:930:8d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 16:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 16:16:46 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 09:16:43 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amd: Use dynamic array size declaration for
 amdgpu_connector_add_common_modes()
Date: Wed, 24 Sep 2025 11:16:22 -0500
Message-ID: <20250924161624.1975819-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924161624.1975819-1-mario.limonciello@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH8PR12MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ca3f58-0206-40d3-281a-08ddfb85c287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVBCWkxxWU1VcXRTMENVeEZOczNIRlEyZlJ2cEE1TnVuaUZqSFRPRURhYWRy?=
 =?utf-8?B?aGhWdDZ5WThKdmR3emsyaWl6ekdsaXcwak0rZ3IzYkh6aDZZY2c2STB4UGtu?=
 =?utf-8?B?ZlZhWGlsc2lFQm15Zng3YUV5TjFrMjZNeVlOeTRzQ2F2aEhieUZqSjBOL2Ix?=
 =?utf-8?B?V3J5aTVHcm50V1hqbS9CN0RSMHREN1lQZitXdkRpRlNiNnBCenNKVkFQdzVG?=
 =?utf-8?B?MnJrV0FkNTNSUCtrOEtHZ1FJYjNoYXZmZ25iOEJGZmh2aXl1YVJYMEFzdTQ1?=
 =?utf-8?B?M1hsM2V4YkViR2E0NkNNcUJPcThkcHYwVkQrRDRjVWNEOExaZ2RPRHE5SGMw?=
 =?utf-8?B?blNidXhWZVBtUDNiZHFCbVBYQmNVdmtHZHJzWjMrNEZUOVNLWEd4cENOWnk5?=
 =?utf-8?B?R1dlMDEvbXNVb3Y2YWdjV3VoNldTTlIzZVlIL0tqck0rVDNiQmtuVi80TDNY?=
 =?utf-8?B?N1l5QVpIRnc2bktpS2hZbms1amhFdy9IM3dCOHFicGpIampMTUQ5UUxFTUdV?=
 =?utf-8?B?azdLY0w1WTVCZjZnVnUwZWI4UEVPMXBCR095OXpFTktiZC9kNENvV0V1ZHNX?=
 =?utf-8?B?SlYzSEUzeFo3TEFSbnhOUHp0TTd6eTVXeHlDR3ZsQVJzanZvT2MvOU1RZ2s3?=
 =?utf-8?B?MGJkb3R4MlpxNUdaWmdNbFI5Y0VPSWhpZUtDQm1Eam9CQithSWlMSTdjNHQ1?=
 =?utf-8?B?TFIyTmdVV1kzTWVWK1hiM1hnbGhGb3dabmswS3BwMlF1TkM0Q0x5UEJoY2ln?=
 =?utf-8?B?bXFRWTFGZkpqM1NFRjA0Z0x5c1I2SzhLOVFnYVFueFFFMjNPWVk2TDFiTmxp?=
 =?utf-8?B?ampYUVNmbm5PY2xYbHQ4YlZ2YlFzSGFuaUl2TXBkREdrRzRON0c4eWJnQlg2?=
 =?utf-8?B?bHQ4My8xUEZZeUxMcm9UOFFVZjlrc3lVT00vSUU1U2o0ZmJPT2N0amZETlBs?=
 =?utf-8?B?clRHZS9zS1lUUXZraTRJcE45U3dnOTZKWU5xalR5TjgvSDd3eXVXNmdscWZ0?=
 =?utf-8?B?QkxxRXp1S0VSMmwrbjN5TnpoeFZOUlNYd0JoWnFBaFovU3V2aTNZVEtncXVX?=
 =?utf-8?B?WVVhOXVteFJaUG8raEFmQ3pnWWhWbmpxYWZBb1NiTDlFTzhHa3JrY0svSWJB?=
 =?utf-8?B?YkRiUmxCMGdnN2RZZXZDcm9aUVJGRW9YcjlBa0ptNFZtZXZ5eUczOGsvWmxa?=
 =?utf-8?B?dnpLck9TenBXUjRkTFJJNFJBbms2SVdHUkhvOGs5TnJEVDRrQTQrMmhKWHd2?=
 =?utf-8?B?UlBZbDlQWVJXclpBZWZ5YzBnMitkRmxKb1VsTVo5aDUzRzdibEN6Z0tqSzJk?=
 =?utf-8?B?ckJOaFdTYkV5bExtS3N5NnJHZUJyMHN6aitKMEFnNEZxTEI0QW9xZks1Y2px?=
 =?utf-8?B?L1VaMXl4N3J4WUNFQ2lDbFRPd1BzbVdYd1BtVHF3S1ZHdmZRVHIzRlVZNk9N?=
 =?utf-8?B?cGRWM0Q1VVBSOGRmeFU5bFUySEhKYVVEcFBQcHZleUFSSGpWYTR5SjZDZTJy?=
 =?utf-8?B?UkhZVDEvVUE2R0FMVGRZUHI5dUlpMVlQRFBKNVRzc3dZWFAvcFBEQnVMSHdj?=
 =?utf-8?B?cVYwUGM0aDlCVmpVSWhlS29acGVLRFlKYkp0WW11dFVKS3FVSjhJcHdOSnQz?=
 =?utf-8?B?NFpFZm1JczdHdDBkQ0pmMU9uVXdSQm5Sb1RIWjZYTFAvQUxrZ0FKT2ZQdDFj?=
 =?utf-8?B?ekEya0UwVmErdVJ2OUtlMm1iOTVqWFVJQzd2ZUpJVTlhUjdKK0pEdXgxNFlr?=
 =?utf-8?B?YTdLdy9ha3hzek5yWXcvOSthYVJabnpPN3NYcERzN2JmZU11cSt4YW1pUzlu?=
 =?utf-8?B?K3l3SHNKclJaZ0RjTHk5ZzE3dWFNdmdrOGE3ZDNjR0RQVXFVU05qQStFRmxv?=
 =?utf-8?B?b056VTVrWmx2a2x1bGljYUhxNCtaVmUybExPRzVscWM4cnRiM1h1aTFyczVJ?=
 =?utf-8?B?T0IxdENENXIvYU9HRy9QMWRteVVhekExZ2NYbFZHQWJ1RFVMNXloR0hLcGxo?=
 =?utf-8?B?d3o2Wm41VW0xWjArMUVWTVQya1RhTm10eFlOWm14WktKbTgxdk5lR00rSity?=
 =?utf-8?Q?9iZqVU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:16:46.8462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ca3f58-0206-40d3-281a-08ddfb85c287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9815
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

[Why]
Adding or removing a mode from common_modes[] can be fragile if a user
forgot to update the for loop boundaries.

[How]
Use ARRAY_SIZE() to detect size of the array and use that instead.

Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 84a8af961531..ba24a0eba2a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -398,10 +398,11 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 	struct drm_display_mode *mode = NULL;
 	struct drm_display_mode *native_mode = &amdgpu_encoder->native_mode;
 	int i;
+	int n;
 	static const struct mode_size {
 		int w;
 		int h;
-	} common_modes[17] = {
+	} common_modes[] = {
 		{ 640,  480},
 		{ 720,  480},
 		{ 800,  600},
@@ -421,7 +422,9 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 		{1920, 1200}
 	};
 
-	for (i = 0; i < 17; i++) {
+	n = ARRAY_SIZE(common_modes);
+
+	for (i = 0; i < n; i++) {
 		if (amdgpu_encoder->devices & (ATOM_DEVICE_TV_SUPPORT)) {
 			if (common_modes[i].w > 1024 ||
 			    common_modes[i].h > 768)
-- 
2.51.0

