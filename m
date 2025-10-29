Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048AACCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 16:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A201F10E1FD;
	Wed, 29 Oct 2025 16:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AjxzZH5k";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011067.outbound.protection.outlook.com
 [40.93.194.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3265210E1FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 16:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtUa6SAv0mkncrNBVKj5NaAqy3+A2afyaE9/RH5DTgO7D/y9paW1U+a6IXWnZQxrIN8Omj5av8x+Oc9drcEyINc0xq59Ja9fmx6avgLqRPVPqeZWF1t/FT2R08Fxc4pbjinnsg82mO/Mab17h+GwfYyqtHqGapmO/FmpzC4rlfWaM3kzHPpSWEoMNIgIGgfW21DURB9j05SQTMqelzOaDxomG/8GIjuRec/mHzeInV+Q6Z7EE3gwAD0djFDnUzy8dVjEmwj2r3BYV3w29+YE5SXUV3/MwUCAE5QPC50QpyOw/eZdJh26M+FxB4UB7MRKmgwDanJzu6gHOpVPLEIbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VfqxUCpDBUmC7RQUS9OpS3yJFbo9VtZSrW+DwfW+aE=;
 b=fb3JJQRrUsbN7zvkjwEwC09Rl8s5b48g1ETu0BYEbF0jAW275i5GKoxByYILAts0FjWGMSvjcvHgJxIKlEWoidiYaK7nDXeU5TJ7mjvc1N1A25Mu5tehiJpqL/bVAUmhhYwIkXJuBNL3HVVfowGdoQHKg4yX8+GL3txloY3rDls2ugfwW3ZSWgNY0hBI0vCfvLLq0ISp5rNjrwnbQVZs1VFw+crp3DoF+42YhkZyEhjTqzuBZVaRPlX54aalfj+FudUwHwJFlcZM5G1d3HI7819vnQEHAbUHlbeJaq0riYMLrFTBrxfoVm2ynstElXmrQGbqBrL5XnkIE1j28Swfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VfqxUCpDBUmC7RQUS9OpS3yJFbo9VtZSrW+DwfW+aE=;
 b=AjxzZH5kTdVggIL5bjQYjcT1BD4U/t2hAbQP2fc6MQVgE97b349KIIaawqtHQgKofbp4azG3wRip3iHQW2OV1D4rdQeByCRQzfedTi5wylA9UFAbxOtYcVyPvm3LEvjER0BB9xheL04m6SKSsrDylw3dtf8MKRNG5Aq/4AC2GdQ=
Received: from SJ0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:33a::35)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 16:16:26 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::68) by SJ0PR03CA0030.outlook.office365.com
 (2603:10b6:a03:33a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 16:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 16:16:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 09:16:18 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 09:16:18 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 09:16:18 -0700
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/display: Fix null pointer on analog detection
Date: Wed, 29 Oct 2025 12:16:07 -0400
Message-ID: <20251029161607.401452-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c377ca-2bfb-461d-7181-08de17068286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0swaitObXo1ZHRnRzY4K2NBdldCN0pTYzRBUmY3TnF0YnhOeCtpSlhXemNQ?=
 =?utf-8?B?OC8xb1FNQWNPb0V1VzdtbTNVSEtEWWE4YjdPMm15UmdEcWFVbDZlNnhGRFpu?=
 =?utf-8?B?RW1heURrRkV3QnFSMWl5NVJpVEtDc0tmOXZPNzd5R2hTdmw4VzEwcHE2c1RJ?=
 =?utf-8?B?MEFLaWtjUXk2ZWhaMUU1V1dYOWVTSEsvYlJNNlcrQmNTRGx3M2xiazdBSmhF?=
 =?utf-8?B?aUgwcW12NXQ4ZG4xSjZBV0Z3ZVcvQjJzZTM0RmhPZWduL1hYNlRwcVE0a0pM?=
 =?utf-8?B?aVdhenJjalRyeWIwWlk2TGJYZTZtN1plWW5FejVXbEg2QXJRU0JDeFhqQkkr?=
 =?utf-8?B?eGJDck81dXFybFp5Tkp5cWpPaW9yOE1sMzhaUjN4RHZoRTd5V1RiaXVKM2xM?=
 =?utf-8?B?b29NMTJjLzF2VEw1NmJPQ0xwaEo4Q3JZMXZKeUt3VHVkOXdiVWdOWGRDb2Nl?=
 =?utf-8?B?bS9iazRMSkxnSThWWEkrNGRmblZKSUFNdlMvVGJCRzloU1VrYjlYTkhURlNN?=
 =?utf-8?B?bXgyR012VmVZMEFhOFVmbWpBS0ZHZmhSY21NUUhsWnZONWppUndWQUdZTy9l?=
 =?utf-8?B?aGxRZDFINktwYTJDRXhuMnd4OUdtdXdOWE5rS3RDSCtUaXJjWXM0TmF0MDdZ?=
 =?utf-8?B?bEdsV1pBa0hDTGN4d2tVcjZsUitqTUtxa0wrcUFGVENMb3FIamt4Nk9qTlEz?=
 =?utf-8?B?R2l1a2p1VzZwSjBzcHdyekVMeTNiRTJPRVF5MXpqMVZ0NC85R2J1amx6T0VG?=
 =?utf-8?B?Qm9YU1VueEpaK3pqVkd3eFhVaEh3Mk1acWVSN0twQXdWZTl1QUUvTVVvTktt?=
 =?utf-8?B?Y0U3anNqb1JWVFZUbm53aklWelBWN0VzTVU0c3o0RkYzUXpFVmVWdlN0OE56?=
 =?utf-8?B?YWJ6a2daYmdBNDBVTk5mK1kwTnRxemM0NktzMUptR0w3VFp6TW13RTRlYWZ5?=
 =?utf-8?B?MkNwVnVXd3F1MW10aDJHaHREKzYwOHFwYVp5L1pEVzZ5T3Rra3ZMU0ZZTGxs?=
 =?utf-8?B?L3d1RjVjdktGYXY0QUwweC9xcWpQWC9McjNGSURYV0dkVW1tQjZRdll3Q25S?=
 =?utf-8?B?RXI5YlVtcmhtclZ5Q2t1SVZmaVBWTG5PT0V1MW5EOWE2UWd1eDZXQ0xINjM4?=
 =?utf-8?B?dC9lM1NsZlBlOGpBbVp4ZUlvTG1yQnhPYmFtSmxPOFZzMWwyR2c1UUNWMm9q?=
 =?utf-8?B?VDQxYncvUjMwUGJ5Vk1IY20rRUFPM2tHbDliMzVjV1NXZ0F1ZVJ2TEpTSHJL?=
 =?utf-8?B?d0ZVL1hIVm1odVFDZjgvVWJWeCtHejJ4VjJjbEw1NGZzTW9EcU80ZGkrVlJK?=
 =?utf-8?B?WmtXME9IN0lZazdvNnBiMTI5Y1pheVNFS3dSZ1IreXdBZWIrV2x4eEV2ZjRN?=
 =?utf-8?B?UDlNK211cUprbTIrY1hQRWxuY2RqSFdzcFE4VitXVkdPckI0OEpMSmZTZU5u?=
 =?utf-8?B?L21lTXgzSXNRVndEK3dFMmR5d05IY2RjTllWRDBFZURpUjlsck01Z2hxSjZ5?=
 =?utf-8?B?bUwwcWtlaXRKenVxQ1dZbExpWWlZajBjN2ZYRzZGdFA0T1NpSnU5K2J5dFg0?=
 =?utf-8?B?TldONGtzVUE3dFEyV2I3TDYxcGJYSHozY3hUeUJIMGpmYmNWb0drZUFYL2Jv?=
 =?utf-8?B?dFcxWStLQ3c0RTlBRTdnQzhidEZNYjRKQVpoQlgxVDM3MkhUYk9ZSDlIT2hL?=
 =?utf-8?B?OStvYXMyUU9HUnhtNjk3VG9TSGF3NCt4bjQ4Y2lJOWxvT2UyL0loa1NSVTN3?=
 =?utf-8?B?UzdNMXdDdmNsNUdOdWNqUTdoazZUdVk2My91U2tqaG82emZhbncyMG94MlQz?=
 =?utf-8?B?SXNtTHpDY1BCVXdDSkQrOFdaNUlmdnY2Y0hOUHkwNHRCN01oUXZTTzFnS0Rh?=
 =?utf-8?B?TDEwdStLRytTUnJhejVxM3M2RjhYS1JTNkVjeGU3dDRGbVlNbmpJQ2tkWW0w?=
 =?utf-8?B?cml6cU5pak85blFpQTAwSXBBWjB1Q2hlams4MVlEWkVNQjg4OGhwTzR1N212?=
 =?utf-8?B?YnBnN0NISDdWTDRiWmErMVpkclFuTUhxLzBCeS84TUdRd05URkdsaG9SVzQ2?=
 =?utf-8?B?M2xRTG5WeCtQYnpoeFBHbHgzSStISFRYS3h1TFRYbGttTmQyQnNOUzl0cU9i?=
 =?utf-8?Q?zXUw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:16:25.8947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c377ca-2bfb-461d-7181-08de17068286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
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

Check if we have an amdgpu_dm_connector->dc_sink first before
adding common modes for analog outputs. If we don't have a
sink yet we can safely skip this.

Fixes: 0c9f9ca99238 ("drm/amd/display: Add common modes to analog displays without EDID")
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c621e50f636a..bc5a8b8442a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8669,7 +8669,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 			amdgpu_dm_connector->num_modes +=
 				drm_add_modes_noedid(connector, 1920, 1080);
 
-		if (amdgpu_dm_connector->dc_sink->edid_caps.analog) {
+		if (amdgpu_dm_connector->dc_sink && amdgpu_dm_connector->dc_sink->edid_caps.analog) {
 			/* Analog monitor connected by DAC load detection.
 			 * Add common modes. It will be up to the user to select one that works.
 			 */
-- 
2.51.2

