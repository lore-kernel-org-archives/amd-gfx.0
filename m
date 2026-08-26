Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63A0C61DBD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 02:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F72110EBB7;
	Wed, 26 Aug 2026 02:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qxuntu/U";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E2A10EBD4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 02:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwFlqsQc6wbhdWwJoTXFSMCRmylhNAbyAE41pk3M9S5/Eu70TSxP5nqN+SHd7ZCYs+Lg0iCquoGe48m9w8+zngUelxXFo1UZ2QR7tFobwaKfH6a6NrODgBPaxnej738TNkIoaRl7gO4SGXS3/S8Hvw5w9HRzxKQws96QDjfugDDTj2nmXgPSwLVXXBr72RJZoq1pHOFHRuapLAZrlUUg37XwvqGmPYpYPjwkfVEsUcXjZMva6xep557kZRH47oJDXO44vXsAYRBdD+E+p2aE10HnWflnJlDrFBJluZIosjtFKnQJTIqaoieIgUEGG9facgLDqfL7IraWB16HNI34MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yve95c3XjElXCZwJV0QIdrz8tOrwx9g5iBoi/b3UqPM=;
 b=Jd9GgtFoHOXTy1+bwSGzL/03JAwTTiuZaWyfJRp6OtcFn2g2TM0WRP+FN4oJ5KHYs6cgpdRNNvlmPZ7fWfEaRyXA+SlzhCbR6vJfYBl2/5kMDRXX10lHi+c6+lPLMN6e+6arSVljIkvM0siP4TLdefMzO/213uU4aJM8MSGCvw++g+eaAyfAlcULJC8gGD6aqFrNiUk/lgH03nElVcEcF5APcp+KX7+uCYVHq0ZLGd2b47s2JXRJwo5kXI+idqcPv9I9HPg38+JH+vfqc7goNtYiufxpDx0ug/zY0VrJv8wGM7zE63PjAhERRwTaDYoKPCZLD5SANbSNgE+425yr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yve95c3XjElXCZwJV0QIdrz8tOrwx9g5iBoi/b3UqPM=;
 b=qxuntu/UJ+rw5oJNdp0/w3y2jcly8CM/7XVHOuNrkUq7NxYdiVc6iHau/VZ2dIRqHQdc8smoyXaL+/bv3c+V+F/I7DXADBa7OCmb+Y858LszNuzeO/wEi7FRq4CoEGmtlCOQMlBrt1GP6o4g89+8n5Jkr9rb/hQ/ADDw51I0PJg=
Received: from BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::16)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 02:01:26 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::44) by BN9P220CA0011.outlook.office365.com
 (2603:10b6:408:13e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Wed,
 26 Aug 2026 02:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 02:01:25 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 21:01:23 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <Maisam.Arif@amd.com>
Subject: [PATCH] drm/amd/pm: fix gpu metrics energy accumulator for smu
 13.0.0/13.0.7
Date: Wed, 26 Aug 2026 10:01:06 +0800
Message-ID: <20260826020106.1346230-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: a28f1b44-3f5c-4a15-8c08-08df0315ef8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: OV7OFsdqQgDln9Jet09Cl84mHpNk44NZANLtis8AHHLihktTY02aVCL/RsfzHRIa+vNR90pkNCK/1L+k13TDB07TxBYyqGZlzSi9PeoQr2yYtNmIPqSXZJv1bke4hKku3F9HYXHvJqQ93bfdz0BZG2XJsD02/ocfX+kFezqsheKj8C06VirXsQXEdhMm1Abc9ME3/8HkOQSj5U/Pid3tM5TdjV0ujrDv+6QkAZQciv7W2Uuhd5isNFv3fgy9SGwwGXuycefWY9RPnfD+atmxfTlxZb5rwWhjQrGcq4/iu6Upei/YR5hvY+xNVc6/W2MVJ0UfLEMMi1OC0GWqANhyqygGGdezNQ2CHeBaTVm7vVmL1gOX/mdSk5wgDHBwJYQFhh582tolduC5DDllvaAmtVXcSxecSe4Dv0fpu3S4zTQj4wMZhIWMvNZypDl3pQgdXjkH6fwFp4GRu+fSpUjbQvEoQDgp5ZJEtfyXJzdBpCyCuHkPopvWNk1VoB5WC01USAL0+/Hdmv1ewRxbs+3ZsjEOEm1BhOk3Q7fZuIeJwiq2aGtIQrAm6b6NqPX6Do3Sgd5j4XoS8jX+DOGHH0nrioT/XFV1t/lfkQghCwAz2kpMPNwLR9vYgDVbk8trvQaQFYhRVkUMbeNuk1w4maYDhgX9kiR5sIBxPf9WwFZf/+jB4J9tDqa548D3DJ0z51oBohT3lcD2+jpQjWWqFA02Fw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xFhfUnxAa1suInKktcOrLQLLeYlRqGzq00wdzIptoFlAEwgW5dgSq3MQ20XfUsW1WdOduHvxA2x6dBlZE2w43IwAm7hwotiCP6Sc4QX0T6ShyijBMfHK6OzIKZURrRmsqZ/yi22w6qOBUtaucbuWyH1Tana4bweQFbYE4uuwrSYtSzSCzdh4Fq/pQfQPAXSmQPT2hmqvSAlC9MjHA8CZOKn5g2RxFQf9qkZVRXTsvxiK6hTz3R7BfDy4E9Z/OocjzznQ5/RW56/V1lW08LGKJFfR3PbnntIx7XGwBmQg8VJRBAnUHbf6V5siXjpsNAQCjlFEmPZpsUOA6MCxgrAw6iktv385L32FYF8KIJ1J/SSEJFOeGo3UWtCZU1KaV+bSyN6fovDVgXmTjhlpCDijaoe0d+TR4PH+TB1yh076yEbM1MB2J3NwnwTvDwS/pu46
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 02:01:25.6339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28f1b44-3f5c-4a15-8c08-08df0315ef8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
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

GPU metrics v1.3 defines energy_accumulator as a 64‑bit field.
The unsupported‑firmware code path assigns UINT_MAX, which is neither the
full‑width invalid value for this field nor its default value.

Fixes: 8de9edb35976 ("drm/amd/pm: remove invalid gpu_metrics.energy_accumulator on smu v13.0.x")

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 81b7c2de45ae..16a6b8fd832c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2095,8 +2095,6 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	if ((mp1_ver == IP_VERSION(13, 0, 0) && smu->smc_fw_version <= 0x004e1e00) ||
 	    (mp1_ver == IP_VERSION(13, 0, 10) && smu->smc_fw_version <= 0x00500800))
 		gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
-	else
-		gpu_metrics->energy_accumulator = UINT_MAX;
 
 	if (metrics->AverageGfxActivity <= SMU_13_0_0_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b94ae43586df..5fe409a23772 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2097,8 +2097,8 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = smu->smc_fw_version <= 0x00521400 ?
-		metrics->EnergyAccumulator : UINT_MAX;
+	if (smu->smc_fw_version <= 0x00521400)
+		gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
 
 	if (metrics->AverageGfxActivity <= SMU_13_0_7_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
-- 
2.54.0

