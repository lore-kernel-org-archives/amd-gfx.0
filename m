Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F39C02194
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 18:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A563010E423;
	Fri, 31 Jan 2025 18:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1+X9r8RH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A5E10E423
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 18:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ja+Q+3qhfnIHnmUvoaOYt4IxITKWYCthn05jAKDiGrE0PlrikEa828cUFNM8bJPzRkcoYSmPbnj2zyueyoOdyxKSRePtyl6Pp9gixlXL8aLTEAzFB+9ID2VrAT+hYavkbOP4OlqWSXUgc9K/PUvAZB4xvLjV2gp2xfHMULhuoeA57iPZWDjdYOk1n4x59oMmfI3vOoR78GjnbdafGiFjmpvQ72jE0HnIuF05qanvR8wIizUrYbV6vJrfsQ/Ea/nmqucbOI/5VlczEq9bqQigQchZGzKaUshHhFI0ZA1sL40uL07b9xw49m7+zNJB+MArLX0rdw4Xzrn3+HC7BsOGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okQ9qg6LLtmToSJD/LjpqO6tvpiDayPaq8/ImPnVP00=;
 b=ZwrCm8DE7fB70Oi9Vjcu7m2qn/SUXRUcOKvnN0787FlAvOJwtcaP7M6nOFIgvFDVz7wo82oxqgWbQM/z2rH9lqL2wUiBfVnn8+GBThKM2ZzzoEsDo5/PxsxrZkP+UJnEaOJVoILErus/feRTTk3yHUxVYYabMqi5ysLSz56sMaUj0NwOcxVHQpjlwgGvuiHWcYVyLYpSJ7cKDCKIZ8EDqtytPzZdQ37IJvhxZl1D7/I29v4WIXkIy4K2rVcDiD9YusrdORO2PF8OXmMRL3fLHNn+ZtG4JUpxufTjv5VV5VngsoD5IzRduo7N6OiLvyiI77AEENRQhA7duRagRzpdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okQ9qg6LLtmToSJD/LjpqO6tvpiDayPaq8/ImPnVP00=;
 b=1+X9r8RHhD4eJM/xxKEUWOGX74VTTfrpLs6CvpY3yn74qgDU9YJ64Fr/U8owc8am8e7zqLC8dQpKw95ngn7pSB8hLjCM+afznILDVRUWk4pDkAg7l9Bxbqk/HNrkcChXv8Iipd5wSS2dFQtV6YJLyn9fo0ABnr/J2wdcizZXTec=
Received: from BN9PR03CA0109.namprd03.prod.outlook.com (2603:10b6:408:fd::24)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 18:59:21 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::32) by BN9PR03CA0109.outlook.office365.com
 (2603:10b6:408:fd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 18:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 18:59:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 12:59:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
Subject: [PATCH 3/4] drm/amdgpu/gfx9: use amdgpu_gfx_off_ctrl_immediate() for
 PG
Date: Fri, 31 Jan 2025 13:59:03 -0500
Message-ID: <20250131185905.2074016-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131185905.2074016-1-alexander.deucher@amd.com>
References: <20250131185905.2074016-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 37deb710-38a1-4d84-2c71-08dd42295efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUMrY2F4elRWNmNLWW5wbmdVd0ZmV2x2Z05ZVm55YUpxNFRjcDBocll1d1BM?=
 =?utf-8?B?akVaQzFOUjlIdGJvYU9OU1V1eVkxSExkMzdNeTlQWm1jSWpFY2szSCtDQ1or?=
 =?utf-8?B?V1p1VngxbnF5RVd1akJBbzdxNExjN2NQZTFxU2FiK283TnFCVDI0OHpucS8r?=
 =?utf-8?B?aXNNZWsvUXJoY0RpNksyMVhYK0pReXM5b1drUEIzLysvaU4wdDFZd0lJSWIz?=
 =?utf-8?B?Nkltc3lPLzJ3ek1EMEFpalpuZHJDS2Q2K1RsYWNpUTVtYWZRVjlRZGthWGl2?=
 =?utf-8?B?MUZ6QXR2TFpVRmtJOXVnNUtqTGVSdzhQTjRPTi9XMThYdENRQWZFbm00cENP?=
 =?utf-8?B?eHBLRi9BL1NiQUFJYkhDRmxCRmV0MDhXaGxvZGx0cm1RdjBlSWpCem50a0Fm?=
 =?utf-8?B?ZERlTDdiL1YwcGIvL0cwdXZEdTFpNFNWNHRwc1EwaUxWQzgrUlp4VjgySWJO?=
 =?utf-8?B?ZmNUQTdWbmdtbVdyMmRNWUMrNlBMUFBoUkNDVzF5STVRK0owZEF1K2h6dUlQ?=
 =?utf-8?B?clFYQUlPUDhsM0V1cDE1VU5zdlJySldVc3Q3bEVNSmU2MDVjaXQ5RWl1Z2Nv?=
 =?utf-8?B?RGhsL1lnVWwzcElRUWdYMmNTSC9UeVNWMy9lcWI1cXBjYm56ZGlTUjd4RHV1?=
 =?utf-8?B?WnFwK2RWWnFNOWdCTUVKU0M2anBSR0d3cnQwamNqblA1eTlQL3BuOXhiazJM?=
 =?utf-8?B?ZTgzNUsyK081ODNjZ1NNU1J5cmE4RFJvVjh0WGxKZndQS3VsRGV4YTNVQzBD?=
 =?utf-8?B?S3BtTWQ3TXZmWFdrNWhsUGxPVlI5YzJYNnpydDhNem5SbzJjYW5xZXhXclpR?=
 =?utf-8?B?d3hMd2tCK2JCNDNCSVRHZmV2Qm5JWENnRFNLT2o2R0JhS1ZwcUdtNTF0Tkts?=
 =?utf-8?B?SkwyUkpTZFR2UFNtVnA2aWJ6WFpUeUpqNjJDeFhXeHBERXRzMHJwVXN2azVh?=
 =?utf-8?B?TmM5bnF5c3BZdzV3ZXZRZXlKdEtDd3kxSFRyNm5paVdZVDlCNDAwclJsaE1j?=
 =?utf-8?B?dEE2TDJoMGF1b3oxenQwVVJGY0ZEM2JYOU9YMXFOM2R3bnNHeDF2YndmMDdy?=
 =?utf-8?B?ZW84eTRJYjZkS2JlNmsxUUhpYWF2Zk1pSTZFNVcyRkpROHh0Mk96c05YWEJa?=
 =?utf-8?B?bFhhaTVmK2c2MEdJWDNYRG1FU1pNcGlDQ0JkWU1jWTZDbVdhR3hFZFBNdlZT?=
 =?utf-8?B?bldNcGtDRko3SGxJWGdEY210aVVIU0pQNU03TDlNT1k5TTJHZitYQU1YK2di?=
 =?utf-8?B?dUV5TVo4Y3czUkt2MFY3WDRjaC85eEs0V05DS3p4RmdBUUxhQlZqdTNzZHFT?=
 =?utf-8?B?THcyZFBhQWVKRmRndnZ3YmI5QXlIaDF6U3RxWnFkOFF6RTNPeS9tRHd2ZmZt?=
 =?utf-8?B?bDVKakdHcHBVNTE4U2k0M0Y2b2xrbWZvNHdHVm9BQngxZ1NXSnFTTlRBdVZq?=
 =?utf-8?B?eE5zZmd4VGxtWWlLakw4SVprK2pUVTFYRkpGK0RTWU16U21vRndXOHVaczRI?=
 =?utf-8?B?MHZDZm1qRUU3U0FleXU1enJHdm1rayswM3kweXUyZlFwQy9IQWQ1WHVyVmVW?=
 =?utf-8?B?TXRoTzdRTCt0NndsS1ZuSElqbGUwM0JMSnN0N1VpMWM0aGhJeEF2VEgvSFhK?=
 =?utf-8?B?WUQ5NHlqVkVOYXhoa3haYnFPVnNwOHlLczJRK0dLZ2srVmxrOGFYaEVMYm9m?=
 =?utf-8?B?VW5VYlpjcnlSNm15VllwUWcycFNFUWlLNzhyM21aVlkwTHNiUnVCTStsTHpa?=
 =?utf-8?B?MUQ1NktwV2dYRHlIbFM0S1VncVdZRFFjTXJiaU1GNnZpM0NUTG5kS3N0UmVL?=
 =?utf-8?B?MFFCbTg4MTZOb3RTRXBOMFhNRlZnU1oyaHMwblQxSEprcm9uQjRqQVVEMDJl?=
 =?utf-8?B?WTRZbldDemNwYWdPcWdlMXV6OHNNT1NUVk1YTER3WWUxRnNPYUg0d01LN2FQ?=
 =?utf-8?Q?EZ+ceDGt1TE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 18:59:21.0218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37deb710-38a1-4d84-2c71-08dd42295efc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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

Use amdgpu_gfx_off_ctrl_immediate() when powergating.
There's no need for the delay in gfx off allow.  The
powergating is dynamically disabled/enabled as for
RV/PCO on compute queues and allowing gfx off again as
soon the job is submitted improves power savings.

Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3861
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 82e254c526705..cfdb864210264 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5241,7 +5241,7 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 3, 0):
 		if (!enable)
-			amdgpu_gfx_off_ctrl(adev, false);
+			amdgpu_gfx_off_ctrl_immediate(adev, false);
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_RLC_SMU_HS) {
 			gfx_v9_0_enable_sck_slow_down_on_power_up(adev, true);
@@ -5263,10 +5263,10 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		gfx_v9_0_update_gfx_mg_power_gating(adev, enable);
 
 		if (enable)
-			amdgpu_gfx_off_ctrl(adev, true);
+			amdgpu_gfx_off_ctrl_immediate(adev, true);
 		break;
 	case IP_VERSION(9, 2, 1):
-		amdgpu_gfx_off_ctrl(adev, enable);
+		amdgpu_gfx_off_ctrl_immediate(adev, enable);
 		break;
 	default:
 		break;
-- 
2.48.1

