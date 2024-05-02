Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797F2C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 13:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1228D10E5B7;
	Thu,  2 May 2024 13:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EBKyzeXR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F5510E5B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 13:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPMStYGIZIKp//MEvEzGVt+o0RManonWHriRgeuJpKRNa+Uudtz5dANvO5gCiEX44ugDh8BAd0Zi3UHglVzdarlY55hTQGVOOyEkhYQQixzzog1QDBpfdq3TvH7Xw3KLpocfXH969EPqoW7NGrhu5LCSmlILNWm5c77IwjfAjBMqR9/IT/QjT1kO21VdnaAR3I4A48KbD9CqwH6axIxSwfn0Uvn7JjFtr0deSJ69GwtGk0L0JKwZG65htAQcDCVUd+sVvj/lMPf7IbI1WCWvilWQu5O+X9geQFZl5juluTm3LBvWeQFOc9o9DltcrygBzuHJs9ldvZA3SKwnO2J36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDc7Qp+9RCif0C07qtyolU+KYz0eovOiiA/MthZOGcQ=;
 b=kNECCtfALz1mditWdOA+d84WA9KfnkRtHJFTFMK2zDKIhCKxI4j6Kc0gT4zi8vsrNmNrnFAWLVrU9Hr6QhUyCjolypBKvK5JfL8NSyFfs1GWBReepHwmSynzK7YesqIHdmT/m21i2gK6BpkHXlm9ubW/PqqtzOTWfoT8M5T+GXKPNKsbFkJW6UmT8ozbdZq0Ib4fCQNkRyWHVMafMr26WNIfs87vE28RC7k8W+chrf2Zxk9/fll7RgB7c5liMjnnkbE7QlqDHf48o7HnH6f8puAPUpWfAsxLZi/xbaoZ2/QQwYGk5znPnWOglaeOToQ5NV+5Oo9RwCn/ZzkTvNjKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDc7Qp+9RCif0C07qtyolU+KYz0eovOiiA/MthZOGcQ=;
 b=EBKyzeXR6kg1dtd5/sR8cRBycEA9Z29bRlk1LKfyttrhSURBHerRcyFtvnjtgmRnSqdOtJ6Z6akdewJMx0+qT2F6DPCbRvgDZARnICBfIAo45DPkP/Gs8VKfNLA+G17KbVU8DCc3Fu/Zk4kCCKeXAXvNXt5O9i83/UT0Pk7J6QE=
Received: from BL1PR13CA0393.namprd13.prod.outlook.com (2603:10b6:208:2c2::8)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 13:31:32 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::d5) by BL1PR13CA0393.outlook.office365.com
 (2603:10b6:208:2c2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 13:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 13:31:31 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 08:31:29 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Check tbo resource pointer
Date: Thu, 2 May 2024 21:31:16 +0800
Message-ID: <20240502133116.37630-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 619f90d3-08e1-43cf-c318-08dc6aac2e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXd6TDRlWktRSEpEclUrTVA3Z1A3aVJEUWNhR2VNZlhmUUpMZ1YzWE1TRFph?=
 =?utf-8?B?OUdGRXJHbWt2cmJ6aGFMQlZZN0tSTmtrV0xnbGVJWUNYVGdHRnVDYVhNb2pH?=
 =?utf-8?B?dXVyVlBWTWplczBQaThBbm5PbG5qY2dzYkpzRnkyY2tYM1c0cmdqSFNmclly?=
 =?utf-8?B?YVdSenhEVVpTR2QvWDd2dTBiMFVIUysycWJSRlBzdkRwc3Bkd3BlZ05xbEs2?=
 =?utf-8?B?aHJoMXJINmwybFh5VmsycSs2U2JqVWlvc011R0RlMndURWNhQXcrS0o2anVk?=
 =?utf-8?B?TE5VYWRERjRvOWRaVlJBVU1JRTFnMU5hdnYyUDkvMm16d1grT0QxY1FxbFg3?=
 =?utf-8?B?UmNXQTJDWEFSdDlwZWEyUWc1anVNNk9nTGNjaUo2UXkvV1pzMk1PYjd3ekJ5?=
 =?utf-8?B?WU9GaVBkQWRrTnRuOVVyUVJxVUs5VDhsQ1lLaXlPalVJWCtXRTVhVHZJTDQ0?=
 =?utf-8?B?RU5ZOXFQYXF0eGxWaU9YemRwSFduZUxQY1ZDSyt0c2xEcTdWeXl4RXhZeDVa?=
 =?utf-8?B?M1NQYlJhSkdOazZFbmcyeHdwRUY5K2JTaEpkV0ZOQ1BTNzNTK3gyMTk0V2RQ?=
 =?utf-8?B?cEtyUktDbG1FQWNzOXI1RGNtRFZ3V0NrdE9qZzhsVFNsblBSQU5YenJuYlp3?=
 =?utf-8?B?Rk5mNXpLN0d2NFJaZWZ0YzczRE9kR29QU2RRNHBmRVBNaVVlK09MdVYxS3gz?=
 =?utf-8?B?Smp2TVlDNGVrOHlMdmVFQVhVM0x2MzhCR0w4Yy9jWWhyeXZGUGVYZGFVSG9I?=
 =?utf-8?B?enlSNGV6aDFhc3p4cVNFYlVMamFiQnQwUXRNZ1VXQ3g5N2ppRUgvV3RhcFBK?=
 =?utf-8?B?dXBkSGFBMUUwR3NqMXNVS1F5aXVaS0llTlRlS0J2cS9IU25oSGxqOWgxdUVp?=
 =?utf-8?B?MXlMdHFjb3R2TEJ4Q2pMbXJXV1lrdW4vcFdmT05iay9SbVN6ZE9obURmN1Ro?=
 =?utf-8?B?OUlHQmw0VUtiN1BzT2xBZjJ0V3FCTmp2UXk2RHdvYllKK3h5Rm1VT25UMjJ4?=
 =?utf-8?B?ZWM5VjBwZ2I1NUJsdVFhL281SUZCZ1hIZEdwejRpUmpwUUgweGJ0TEZsQmNq?=
 =?utf-8?B?ZUN6R05jRjJ4SmtCazBhZTErTE5DTUc3aU9TZGdobDVhMGIxRERuZnVUVkhh?=
 =?utf-8?B?bjRyRlZvT3RqcGlVck9Rbk8wdU0ySU9ZT05DcGJMQkNEZ3J2c25MOEhBdTkv?=
 =?utf-8?B?aDhYUCs4dlJVZ2Z4N2VONHJqWDBJdnlBL05HRlpteFBESytwTGt2MVRPOWsw?=
 =?utf-8?B?bVFFT0dtRnYxMlBhVkErQjNyNFZKaW9uNGxhSWZvWFJSVllRc2lpaXVndkZu?=
 =?utf-8?B?WTc2VU0vN0NLNU9yMUFONTE2Y0hQVFhDUnltYmNrZWk2U1ZsaG8ydW9tVWxX?=
 =?utf-8?B?U2J5VXFWb1pCVmt3MnQ2SFBYWHl2YzB6cUtiYitNVnVnSXFKZlNrNlJ5ZWFE?=
 =?utf-8?B?WXJxdmZ5cXNsSE1xMXduUFUxUTNLcWxjZzV2Q040UjJMYjdBdzdkZTY1OG1s?=
 =?utf-8?B?V1l0M2hjMmxkVlE0eUJ6U3U3UHRmZFloT2tTd0hsYnZzaFdSdm9WNWFoOWdY?=
 =?utf-8?B?bG8rWTJIOW51bHk5VVdNanhXY1lCczcwa1l4dkZqMy9OamFjUGF0M1M0NUlk?=
 =?utf-8?B?RlpCK0crMXV3eVNzZkx1M2NjOG5lRDVDblczeENITGFXM1JXQTRBZVNsUVcv?=
 =?utf-8?B?alBlNVUyWE1tQWlNMVFOUHhScGtpVkVSQjlNeElDR3NUU3BoS21FYm00NlZZ?=
 =?utf-8?B?Szh6WlVXb2hLWlJZZEdSYWFlVU5NSVFvdGJMbmk1M1N5cVgvOHd5dnpNM2Qv?=
 =?utf-8?B?anIzSEVOSlByOHZDYVhqRDREcElxRVRNR0hhYmQ2WTdlTTM3TGg4b3VESmhl?=
 =?utf-8?Q?g1z3uSTO8aR9x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:31:31.6926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619f90d3-08e1-43cf-c318-08dc6aac2e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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

Validate tbo resource pointer, skip if NULL

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a6e3d13a454..77f6fd50002a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5012,7 +5012,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 		shadow = vmbo->shadow;
 
 		/* No need to recover an evicted BO */
-		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
+		if (!shadow->tbo.resource ||
+		    shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
 		    shadow->parent->tbo.resource->mem_type != TTM_PL_VRAM)
 			continue;
-- 
2.42.0

