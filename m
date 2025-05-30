Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C43C5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CABB10E811;
	Fri, 30 May 2025 09:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fLysuwTi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F75910E811
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iq60lWvphdzOUAXOluqTBAy2+nj0mhOamjKtLzusoNzI3lRZvfKGOR81UoJWe7KThiUz9uTJbVa2kIKQ7IYT67oPoTNWqcQ9EYi3gT+J6AdO5Xu+S8nzcJhguk5uesAJvXDdmAOzKm7kOcICxHXsXwIhW+p+kofXwz2PznNTRO79BhglAAjKAdhCqE1pJw0BvUpKfJj2gJ1wMCVcJjgupAJC/BlioMc391EdTG8MvlpD5qzaCMHN8NWJu7e2i+iIJSBkGOtdi0YjdxzpSwfKkjeCah95yV3VAXc9iI7CzWUHvKXtJT3y6Wi+CKRwgREU75ZFysh1BKx5/Hg1OgyX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ux7deOwoH/h39DZOIf3F17pJs3KPrjV6YrMTmuqO7o=;
 b=ycifopqTlmPvYngplBJeeBRrGxnlJzCB7Xxl3EY83/4g2bX1BlvQ8A+v8zpQNPJt8qWlbl+PUyshjHorD9fFvVOPN1mHVNE4giMYeCL2SpDrRRSA2Kafwtd2NvKBVll21pwRJadujT3hxpoQs6VjpsbEb8pz6wlKqI2rZUh7TkTlXC5nkDn3GvLemeAn2y+DLu6R/w8lLZe3S8AMa3TVdgD6un48Z2GFRKtSk9fMrgWoiJ8jGHuQBT7WuqSRW71Q8Ld5Ruiu30/bjXna2uESv/RmTa8pLSbvGttQsROkKQpTAKEboV9yUmUSWKSHXE+foj+pwLURhcu+FVTkxvMZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ux7deOwoH/h39DZOIf3F17pJs3KPrjV6YrMTmuqO7o=;
 b=fLysuwTi3pGMfcR2rkGIm2wB/xk93ST+qWNcgj7kl6Avm7MiLi5STe/noGdZR5jXMZKgkPR4ZErLRbuAwDTfICMVlrOITkY2SACsihdIVmzJA4bpCEKl9jwWju2g9fxBHWIHcoQUseCkCO3SUtb1Ubv5gkV553UNLdWHOYR1uoY=
Received: from CH2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:610:53::22)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 30 May
 2025 09:03:30 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::5c) by CH2PR17CA0012.outlook.office365.com
 (2603:10b6:610:53::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Fri,
 30 May 2025 09:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:03:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:03:29 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:03:23 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 01/14] drm/amdgpu: add user queue reset source
Date: Fri, 30 May 2025 17:00:02 +0800
Message-ID: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 372ee7ce-1869-4863-a64d-08dd9f58d904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0lwcGtiRUVDOThhMnZOaTlvT21VZzlFZ28yUU1lWkZKZGJjdmF1MUh3bHpI?=
 =?utf-8?B?WE5Tb3AxVUpoV2JwR08ycWthUTNCL1ZhMkZ1ditoVmdMcVh5WkJ1dkJmV2Nt?=
 =?utf-8?B?OW44cy8ybEVuWjZhd3JaU2VMWm5VeU8rSFFrSmVyMDNGYTRQdkNoUkNHVHE5?=
 =?utf-8?B?UWJHT2ZFYXVYNExHckVEelZyN2FVNnFWQU55c3FyWW5xamdEWmJwRGkraEJk?=
 =?utf-8?B?aloxRjNONGJaa1dPZnkyanhqeDgzQURiaytzNUcxTnNaWHEwTVBPckVYWFpD?=
 =?utf-8?B?d29kcHhqaWROTnFHcVdxdmV1bHY1K3NuTFpRcHFOak9QZFJlM1QyLzBRUkY2?=
 =?utf-8?B?dFp5bCtMbmdxYTcvN1l5Mko3UG85bldkVnI3bnJ5OGUrQU14alZwaXRTb0FX?=
 =?utf-8?B?SGdPU1cyemhORlp5cjRkdlZGcllkNnZhSzhxKzJpQzg4dE9icnQ0UkQvQWZ0?=
 =?utf-8?B?d3FleHBYQXkxRE5QMENjVjdoMjZ2TXBkeU5LRFgxV2tnSFJjTnhWM05qVU94?=
 =?utf-8?B?b2c0T0t4c3ZMQWxzNUp3WThnaTl6SDFra1NPSkxRai9uNGtjU2xTaTFVWmc0?=
 =?utf-8?B?NDVzZUxTd2s4NmtmKzBVemFLSkpiVzR5T00vYzIrTGZNMHFSYXZ4K3NGNzdt?=
 =?utf-8?B?ZE50SWQ5UWQ0VGJ1MDJLc3JidjVyM1g4dVFWQ2d3SW5PVHdVUVZxOERFR0ta?=
 =?utf-8?B?MVVwcFlGaVdYdTM3RFBKVTZ2U3MwdVVwclQ4RjB5TjI2cWQrVGo0cnhIdGRD?=
 =?utf-8?B?ZXF4VEwxNGJ0dXp2c2NtTE9ZSC95d1g4K0p0UEFnbURPZHZvKzZFUXU1blhz?=
 =?utf-8?B?VkNudjk1a2trdUQ3UHRtcUFPWXhvUGNIQjdTODBkVTBGTDUrTTVoUnJBTkV3?=
 =?utf-8?B?bFpTSEhiOFV2NDR4ZkhmU21zQWZNQU9DaEhtTTRqckhXbUdCaHJOTU42WWQ5?=
 =?utf-8?B?a2U2U3NZZEgyc0xTT3kzWWtKU2xndWR3cFhDR1h4RGhFcHViOE1TWmtVRDNz?=
 =?utf-8?B?UzQ4dTJwZ3FNMHhNSWNmV2Nic3BCam5lL0U3WWNsa0h0YXhva0V1UUFXRHZO?=
 =?utf-8?B?dWZiNFlINGtNM2M5TEh2ZmFLZ2xNWm5tUC9uYW9zQ3Y0aHg3TGl6OHJGUE9O?=
 =?utf-8?B?WUpkbyt3ZkUwRTJIRGJaQ05HNW5BWGFWcDVwZFQrZGozaytOdUNwTGExR0xz?=
 =?utf-8?B?eHR4bHoyYTd4VmFQVG9FWTRPc2t1bjNKenE4NnJaSmgvcWtSUUtvTVZ0Yll6?=
 =?utf-8?B?RUN2ZlIyVkFVN09KeHJiNmMzUUZjV1NFbnBtVGNvS0NSOXBlRDQ1TCsvckp1?=
 =?utf-8?B?MHZ0TTBWcXFXWW5sdHVTelorSFFBRVFLMitxTWZ1a1c0L1RrK0g0NHpiRmVK?=
 =?utf-8?B?YkJGdUhXaUZrTm9PTmwyS28zNVJqcXI4Z0ptSW9EYW9KRExybENaY3RyTCts?=
 =?utf-8?B?V0g3d0hZdVpjMERwRW9qQWpPcllkYmpsL0wxTzNRRWFiMXRHeEN4K2d1c012?=
 =?utf-8?B?MGtPYWdqQkEyaC9mYVR0QzBFQ2owK2xrTVlTNXI4dENSSWtsWlM2QVBRZ1FQ?=
 =?utf-8?B?RE9vVXJPSFBFOWMva2paWFBPZnAzRVNyQUY1WlF2NE9YMm80ZGhvOEhSeFJz?=
 =?utf-8?B?bFFWSnZaQmJKWHpNYnRqVkFHQkRmWVQvaEdrdEx6WDdKVE8va0d1bmhEbXNC?=
 =?utf-8?B?RUpmN1FRYXV2TytuSTNVcm00b1lzRGRnWkNpMU5qYXRzYXJ3TFVrcy9pV1JH?=
 =?utf-8?B?RzNJenE2NmUvREFPTms2VkZ5VURseU5vRE55RXlGTTNLMmgrVllDY1JtN1p2?=
 =?utf-8?B?SmNpZWxadkp4dW1valZNRTl4UUhwMlBRSjNjS1Y1QjNOMWdtT0Z3SDI0cGhq?=
 =?utf-8?B?YTAxdXpodFdSSEVtcVl6NG9jWUJSQzFoUXB1aHlhNStEQnlQb0ZZKzVQdjJY?=
 =?utf-8?B?ekhLYUxIekRXdlF1M3dZdzlKKzV6NXdGQzFlbCt0S0gvNGdnN3R0dmtVUXRt?=
 =?utf-8?B?Nm1TV250VDdKOGI1YWlzWG1USVp1eEhaWGlvQVc5OWNPNW9yRGhoTzhDdTlE?=
 =?utf-8?Q?6eUmBY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:03:30.2831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372ee7ce-1869-4863-a64d-08dd9f58d904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

From: Alex Deucher <alexander.deucher@amd.com>

Track resets from user queues.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

