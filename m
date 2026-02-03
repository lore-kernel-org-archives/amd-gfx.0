Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB766E8304E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609CC10E4FE;
	Tue,  3 Feb 2026 04:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i9gUM4rG";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB3110E505
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXlFucbx0Wrjcexck1QP1xwdAHAnac/gs7xpR7MkKiwAz+VUqKibKlN/Oxl2oZEoOeNEkeycldJXc+sSIKpaIf+IdmdQ3GX4Z5S0+kzcwpW+0xWhQaJ4wirvHoVhYMWQrYM4uwlT7mujEjARMFwGWV49RCOK5P18vSIp9m5vjohyqJ36SHAJrUwHIfBMmUvIF2fbkGmMky24UhJVOidQwmD1NlayzOrqPF02DtTzewSnPul3qrcdna6OULlJVmyWcHeq5T4Mi4wuNzJM0F9bf8bqsrpMKYQHH3mk1//1Bg0oBisiF9CLh+sWnajZH+Hc8axLHFlodyGYN7iIwnmljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re1ds1vlFPHla3WDJFARGxInplvlNgOR7UJX24mHAoU=;
 b=BmaIoxwRty2PLfRvPb2f81JMZjXyza251bv8XbhPDXCCd6tba5DCma+9PPS71qNvyGyyp8dquOLyBNYaWhtJjUmPx5BYl0JUV4guWgu5gPWpw67XpZ2dYIIXol1i8ZYZ7OocP88M432jw5pNriomfdMC7opiPQfHQe/S44Qs8pRakxec3ePgfD/3X0E8m5yhHtEFJ8kUUioizeJaW/5T0voCi4bsF4zgAQhTFWMFrDMK5ofh4RCK0dfNcuEOSignnHEbACc154/cRH1ILQ9blKQKWHCT40u2sn4uQ+k+5e5+qiVEMmWL0QsEcEk2C1ELR94zoY4svFEei2uN9+piLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re1ds1vlFPHla3WDJFARGxInplvlNgOR7UJX24mHAoU=;
 b=i9gUM4rG2oE6CEPOo3P+23XZ2uOwXd4SNWCaxEoLA9fWaqciM+fzO9hMwjx7zyZ/S9AAVBYQfwVj8A/3qdmjvyPWY25VWSJ/eZTseBQfAkJoK+rd+4/FGpv2DMcdhjwj/BlIJ5H3oqLeFQzVUx3uEKuyihj4JyvtWXiCa82W3ZQ=
Received: from BN0PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:e8::6)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:13:13 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::4c) by BN0PR04CA0031.outlook.office365.com
 (2603:10b6:408:e8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:13:12 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:13:08 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 14/14] drm/amd/ras: adapt sync info func for pmfw eeprom
Date: Tue, 3 Feb 2026 12:12:06 +0800
Message-ID: <20260203041206.1299104-14-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: d9707527-2d8c-4044-58ee-08de62da8c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tY3QzUhK8xGWVj5/lFRJIDLUfmow5hu1dq3LaTvpkUIYk5wUGWmnMWhgzf5F?=
 =?us-ascii?Q?V+lBWwDEzL7G1yj4YxHXNZluHX5ZvvHWLy8ESY7EBUdtQNb722UgetOI5NxW?=
 =?us-ascii?Q?ZcTUCMaef1BuCZe0eLi/xmZk/OlQsrraVc3x6/EWY4+RB0Pjue1wLwh6K/O+?=
 =?us-ascii?Q?HJYFdnM6hWhqfLe+TJUK+kEPlepE41OCb/OTc5z1FTjELFNvnnbL1EWHIAsI?=
 =?us-ascii?Q?3FEwnPR1YhNU5Aysbh6WqAfa92x26VqpD/RfH5Oru9h9x9Jhwph6OXzEVfPl?=
 =?us-ascii?Q?3o7nHxniy6z5lu/CQNiThl/QPc/3BnJVJXdaQKKUgLfIBnWstHdPVvSvwnxS?=
 =?us-ascii?Q?G4ffOjvCim7QqR3Rw6YgXCDJLPgtQSKBi5/ilVqoDT1iGaChPDaJPcC6GHgz?=
 =?us-ascii?Q?aoi9VAWUNMMBDWce8y8imbGobxDEodc/Sxc8Ayjpn1aizYS//9z06WgCKCwm?=
 =?us-ascii?Q?lKoaQIShlpCTtIwa6nLreSedhD8JpcZZ+fUkWzMBH6VJgFkXk54x6e4dhKKy?=
 =?us-ascii?Q?zd1cxthXW2aJ3/sG3QyeEMmZsh5wwkkm+LERXwGRYjQmAMZZnnkN2grPel7+?=
 =?us-ascii?Q?gK521TnJbYu6oywM7rNSxEgwbc31h+1S/6+rlqraOVlQ1fU10R/liM9SITEG?=
 =?us-ascii?Q?t0loKYOUonkY+j+C6h054bH491MMc0RIRcU5Ry4mBWEUcOvupae8C4FkSx2e?=
 =?us-ascii?Q?2iPmvwxgs1VuQWarHpk2gG0gTSyocYMp548JhfKLX/eGEsTC0OqsqyfJmWrN?=
 =?us-ascii?Q?gGIimyDVEKereyY8ejSVw58k4YT13wSwo8EYV2Ibb08rDlG/FDMHjQJ3wPxY?=
 =?us-ascii?Q?fTsWT4PRqtc1jjQo1EJexbjhmZ9gxDb1VCawju2uCjATvLnyjcMPJFElKn3I?=
 =?us-ascii?Q?9lUxDXzMqnyno+oyxWhUqNaYjPiVcUZeMrQY+vI1WIbKAb9/lfDeilGeQM2Y?=
 =?us-ascii?Q?9VUoETc4eK0RDKKde0Zms3ZIbGAe1wnaz4BrqHgZLgkXhbxSc5whWEV3GtST?=
 =?us-ascii?Q?JJO0JxAIPJ7B6WyUuU9yHWlTYhFsAMtD9f0hMGOHYu2gHsDWpkcrYrnKNEGo?=
 =?us-ascii?Q?I6vCVgt7qskQhnmR+eZ9401PyTs24z9XXN7SS/xCAsrComXx3D9wAwj8ZdO2?=
 =?us-ascii?Q?e2X0y0VHDuYPyaVHfgBSVE45l5ZEA/o41bRoWyHB389X5cEtwNebhAukz7/w?=
 =?us-ascii?Q?X0qhQ/R1JBYbV6LIOk9aLpsI6xPOkgPcLeoqRCUe0nAefWIHj82a4ZqIe9yZ?=
 =?us-ascii?Q?OVZolMZGB4LjvmqRxPsvEp28yYL75YxWhhKjXZ0hQ5DkE4vQoaIk8FFUEzRW?=
 =?us-ascii?Q?xeGqYKyDKTgsgp5fnslVIwlzC6kHO3sB9O+dYWhiSlZQjCn9MppxwWjEc2D3?=
 =?us-ascii?Q?UQ6lDf2mPVPb33cghqc5H8Ka+zSUhZh02A/BEOKhakKj27Mgti1s7OPZ55w0?=
 =?us-ascii?Q?GbiLXa6w1TWXBQSod1CeN+mnwPrwvJ1+qHvVCGcNPvYc47/cHJxMj1JCqhFl?=
 =?us-ascii?Q?TNGEXq++iv7DA8R4Y6dx8zxeTPTqw9KabK05P8GArrjMPDXlwBlQycnsLwfw?=
 =?us-ascii?Q?ATQchma569fAWgrGfeEIjmSYMWLmXvLCkHBB4p5WmB1kPheHZt+EBDUe1MH5?=
 =?us-ascii?Q?sP59QPusXrbdDcVcFQF+TS+w78AQhUyJqJlmF2KYXEHb144REljwqf57wlJA?=
 =?us-ascii?Q?y4tqEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mAkLsmcSO5ktvmzQkWasgZ9d1CEPaYs8VDIzoWhHMBsoOwYKMjlX9QXUtkr3KTDeeEA3paG8KECYCT4Yrcf5jVX5nh/l8DAC0Z+bqCe7ubE00VbP41JPvInt6L+RCiqoEMRmbq9QeiBxxA7umFwXuVCuytfhqMSz0J3HOAqevcNXcFHqcsGVun5feP/uXm17GceBauPjlpxvO33S5wVoIKE3mXBlOGfkMgX0EYm16ak6xTdYV8JKN6NzBvTfV05Mt1Szw+CB1tkXeeaY9TwHHTMHC0qCjZ+tWlL4Dh+4BmoZIEKLSzw2EKp5y3+rpLUEHFbRTYQ0qaLAOLnqgllBHXMr9RTdqQIEv1BkiOjR/84yxze+tE9j4MqelasUvogxXaMLvogw2uprjFBhidR7hwatiUVR0YgWTe4Y4aJo6A7S9uNRcmiJMq0rgZAtiHV4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:13:12.4384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9707527-2d8c-4044-58ee-08de62da8c06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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

adapt sync info func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c      |  5 ++++-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index a4e2ad6a159f..6a39e5499c5d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -256,7 +256,10 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
 		return ret;
 	}
 
-	ras_eeprom_sync_info(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ras_fw_eeprom_sync_info(ras_core);
+	else
+		ras_eeprom_sync_info(ras_core);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 70bbf1334c4f..29001e606d1b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -504,3 +504,17 @@ enum ras_gpu_health_status
 
 	return RAS_GPU_HEALTH_USABLE;
 }
+
+void ras_fw_eeprom_sync_info(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control;
+
+	if (!ras_core)
+		return;
+
+	control = &ras_core->ras_fw_eeprom;
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
+		&control->ras_num_recs);
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
+		&control->bad_channel_bitmap);
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 75d8b95c6923..762345be075c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -82,5 +82,6 @@ int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core);
 int ras_fw_eeprom_check_storage_status(struct ras_core_context *ras_core);
 enum ras_gpu_health_status
 	ras_fw_eeprom_check_gpu_status(struct ras_core_context *ras_core);
+void ras_fw_eeprom_sync_info(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

