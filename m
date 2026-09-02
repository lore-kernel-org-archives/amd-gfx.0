Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD71C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BCC10E6FD;
	Wed,  2 Sep 2026 05:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DtUCuD1R";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F0510E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xk8MfF5hROmG9M0ty111Vo/WmgmnFX3TsRPepjq72Z6d1S7ZJ2019ZRpDHl2xLwl5Nd0RGg2kKkipklIu28kNRn5uOZiXsKZRI5zMLKwBu+lmWnjmAIA6XdDp5SIDykzsuexOMMuYgURqzgITUvXGTKnAP75RrsJbObkPw2TxuMpe3bcsDXqyLGZOAvja78Oi/eb4djIZFKFz9xYbAkpVSnfu3tkWdBNu3Hjd2Q4i52mtVYf6Q9R1B3StXDTHF+RD1iDWNCxzkGNqisqxj3BCYo5SU6F3YFpS7wuo/HSJEYirnu3X6DpmFyUlVkHumLEZjE5mX1e+q/6PKiPidlmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UvoIybAGTwimqPmgHygHVuLtBMjdRwTx+jcUWOe6OI=;
 b=X1jsdTMybWlLFyfamOWSeYwW206Ccb0TkAWN7JS4NxLrcCQY5nlQ6wULV6RAnXXGc6FtxW8ewiMbKjiFeteN+BAYOcfIOIgb7gHS9PSRerWOtSDv5tgsjOQ1mLgbCOcuMDcQcaTgltWxR0qhQPOPcEqD00Bq+pd/k9lr2LeraN3dkv5MW/WepTMxBIY4cpuM0kRfi+MyjAM4x5KClZjBptkspEjeo7IjRUDemAQxR1CjGyRI7iH9pxibcg0CpzT/2lyCnqUteyfJxqDH1aVlLCRyCsEMT2KumEwohPuyvvmVJAnL5AsNYQZNPqJVzOW+a7xXOf4v3+oNkI20sCGlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UvoIybAGTwimqPmgHygHVuLtBMjdRwTx+jcUWOe6OI=;
 b=DtUCuD1RCLV9f6ebMUgGvFPI9jBNWA2y0d8CUr8OFjFYfMB6G8YL624mgaNkHXH9A4A9om3cfAQNH8Cq6nevRKEnMQjWenSn5103wbyGL3+J1d5RGUhmFDhxqj4RTUSwUzw9cYgW87aQPLMsa48ltNoeEkuuQErSaDGxTfmPIrs=
Received: from CH5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:1f4::26)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:07:15 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::51) by CH5PR04CA0014.outlook.office365.com
 (2603:10b6:610:1f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:07:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:14 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:07:05 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 19/40] drm/amd/display: Fix missing APG regs for DCN60 HDMI
Date: Wed, 2 Sep 2026 12:58:41 +0800
Message-ID: <20260902050411.3473916-20-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 251c7232-44d1-428c-27f6-08df08b00e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 77I/KsCth8zr9iQjGpCF37l9YdpPteVLg06PNc/2Og4nggwy7mB8CYNDNsnBV/BB9t2jNJbwLOjYi/Td8K4r6lKbkQrSRRAqt16Yeiw9oIciJqmGyq9kC84FD2ZjB5ZDia5rs6lTELoFlT/p6j00AO7yAkdDijm1ZI2VLxDK5GvAx7GAor+kAwgp6QIJIQi4uNzPl9AVbGjdcQ1drz9SkFlk/KeCVXzmS6vtqiCAnWOge8aeTACFkEa3GGBTqipU74qL1wPsfd+DdbX73yApOUWgCQguKMlhnIoF64IC4oYiWpQb59f+pBnbCdL+8iuLYRNR7xBEVJjbFadi/6ptKXWECevo4svZw+jzBBWogyzvkiyXjcz8lC9j6t2lrtSHKqkr+NWCCobO5BI7BpLhyN5nLSiTLOEzzZw3Pwp5Yva1M8sl4CZVxgzvvpdcON55N+eTrT/fV4K33hJgtGpXHreldGrBqXaAadMAgCwY7cs5QY6kUVHG154OJ2yY94oJmEKSC/Z5J7JotzcRFk6POuRkuoljOBjuxWWhIUuMpvgztz5jUphL1qm0K/Eom/M09oxXuaa+Y0+l0R95duh9oXhRWLT3cqHW39571nAXREIpb+SdqW4oQE992gfdNHheaWigTyOviYYQ3E9E3fa2wRdNKo6LcUouRpbjNUtdkZsy16S+hL/nmCpTQJh29Knar3eB8VrbVN1BWIA3fZLF8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n3N9020uQRpcnIfaF3aNJl2d3Lag23QwmzlY3h/63iwpSFOhkrhxOokdHylgeJLb/VzR3KDjwDbtbCOWWaYrNIljcJY8dbDhfqi3n4UU2UaNG8YVnjC00qfKm/qi7Q7IFQ0QB1pefxetGLjXlWvyzO9aZC09BRTIUan8IBuFseyheZL7EZofa9CxdCwES/POK95TtbV667NKG57NsHN3cesK9jv3BVC1hd4mdhDtFx+ck9kC5d/fHOQmVwKwr8I6Us/cBrjzAmlT4mKOAy4iWqskc3sG8Vq1u7jGGVaJDeQisqmVFyus4ITZZHAN3iR0QL4KtNTzdE+IDyMNnU+iXZBnghOKXX3pykko4ur2/UTIHoKRZJg3v+ezEHOmQCqc1ba3s6wFSWP6iRLvO0ihag+FEL02NCQy4K5+pU5px+carjDXCsOXe9fF3VNN8kaE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:07:15.3145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251c7232-44d1-428c-27f6-08df08b00e17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why & How]
Add missing APG instance for HDMI stream encoder.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c   | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 8228fb62a350..dff51b641552 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -286,7 +286,7 @@ static const struct dcn31_vpg_mask vpg_mask = {
 #define apg_regs_init(id)\
 	APG_DCN31_REG_LIST_RI(id)
 
-static struct dcn31_apg_registers apg_regs[4];
+static struct dcn31_apg_registers apg_regs[5];
 
 static const struct dcn31_apg_shift apg_shift = {
 	DCN31_APG_MASK_SH_LIST(__SHIFT)
@@ -1390,7 +1390,8 @@ static struct apg *dcn60_apg_create(
 	apg_regs_init(0),
 	apg_regs_init(1),
 	apg_regs_init(2),
-	apg_regs_init(3);
+	apg_regs_init(3),
+	apg_regs_init(4);
 
 	apg31_construct(apg60, ctx, inst,
 			&apg_regs[inst],
-- 
2.43.0

