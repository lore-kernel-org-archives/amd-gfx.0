Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E98CCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 14:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962AC10E28C;
	Thu, 30 Oct 2025 14:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SN08ab3Q";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959A410E28C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 14:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iePGvDHt+z2k3nbdKBJLKxK7PJwrdYgwTuYDVxppJTZ+hrdijv/iPWOFjvDwwXxYTU7+buRVPcgsiDK3ZNuIkGWytoWUiIEp9BeYnUd820pmXwovy143LrfHqUNNygoIdHoHc7aQ4OR1UHwHnAPNJsEgajeaebdaccdOO89YEA2J8PnsciqEk0AHVsbMtfrZ2i/9Nic3b/YGeClJubO4tAH/Zwfj4OO0NNLxWksZocqK0Zq0J2d3R8FQ2Ne6OmwRIDr7Z3FXtq1a6aIqiu7LShkzN2H826KuFjIV2ZMpufCylteIi0fVuimt9RhVZJBKaKPG4ZyoXEgNMVsNHiHFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5biRSutkI3AWyCoA6oRNkxS5qJT3ib3kY0awITXv45Y=;
 b=lyor9evOBeG7K3jI0YutlqoLENU50bUHCzFAwS3IwrJ3zSYS4hlqxzVAng1eCOdvI6qlQWXaKTaHpWmqyIby8TbJc9/GQL09egEjIJLVsln7ytSqWmjas4LyNbkdO2SOfc33cFAXKXiIR2Snr7fedGbYTJGr0uYHypy7oTrVj9DBPoCig0XKYk40D7mwq0ICGoq0YdRTywEKnKOy3IClGOrxG2OgspHjtTVEW15N/uBovtSHTXFZ6FTHWp6xN8aj57yInQfmiHfRa9kDp8NbHs8A/YqYnPhF/m2Qr0pCMRoAbUvZSb3nnGwFIZdinVCLrBGGd5msAM9nizz48Ewlgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5biRSutkI3AWyCoA6oRNkxS5qJT3ib3kY0awITXv45Y=;
 b=SN08ab3Q5KRyeumiBI66bntRHyBk/Yw8P/oNRmaufMgL3Aye81rMZ8JtKceaMszpfpYuK6qh4SbRN/q5Q2BvXhav4Obejnc+MTaTNyD6c9V6FRXpWY+h4r+NRiclLFyakjnBLZHlz4uijwpKdQHRzTNWKrUAH+NLeH8qkS9UOYU=
Received: from SN7PR04CA0105.namprd04.prod.outlook.com (2603:10b6:806:122::20)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:42:26 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::89) by SN7PR04CA0105.outlook.office365.com
 (2603:10b6:806:122::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Thu,
 30 Oct 2025 14:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 14:42:25 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 07:42:22 -0700
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, <Lijo.Lazar@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: Fix format truncation
Date: Thu, 30 Oct 2025 22:41:13 +0800
Message-ID: <20251030144113.2702507-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3b92dd-8736-4e58-af10-08de17c28ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVJTL2lGcVlDVWpNNFlSZEw3WHBDODFBT1paeW1iaU43MXdvRlRJWnVOb3hW?=
 =?utf-8?B?aFo2aGhUSXJzUmJ0RXArQnNaNGJ5dDJ5TzYvTWwyUWFabCt0OUl5bGE0a1or?=
 =?utf-8?B?YStEQjBPd3ZwSU9FRzV1elBCb203ZWdzdUlCbldIZkVqemhVY2hrcmdvWHRG?=
 =?utf-8?B?OThyQ0lndXNFNFFUdFRiRWFJOUhaMUI2YnJXQ1o5L3VJNFZPSDFNSVBZdk9a?=
 =?utf-8?B?OC9CQ25MMko2cXIwcHZZM3ZycXhFY3dKQjR0Wk8vVU03ZzFwSUtsT2R5N1JB?=
 =?utf-8?B?a0dEZmVKSmdxMTRib2JySUVhcmxxMURzOEdvNUdjemFhNi9tYXZpakpaQktI?=
 =?utf-8?B?eWRDdXpaTGEzd24zODg5V2NValFnNEJMT2RCL1loL2lDY25CT0kvQitpUkdE?=
 =?utf-8?B?N2hCVGtEVWFzY2RGeDBPZG1oOTUxL2NpMXE1c3hoTzlwVDYxU0RHcWNZVUlT?=
 =?utf-8?B?aWVkUnpWL3prYXFGY1BQU25BNWFBemVyZWdqbnNYaUtLS1FlSTBmTlpSaG9E?=
 =?utf-8?B?OFplSWZFZ1ppQU9RSk1CQUNkWUtPa3g4SXBmKzdNa1g2ZG40cG9YTHBacUE3?=
 =?utf-8?B?TTlqSi9JbUYwWTZLS1krMDFKS3VWRHdBNFZhSThnWlByNHZQV2VXMzRSdDFm?=
 =?utf-8?B?ZUZzN29xcWJ5UjJ2MUtOc0k3Y1dzVTJJSlYyMDBtQmlzaTJUZ04zbTZZakha?=
 =?utf-8?B?WnJSOUNJUXVkZmJKUno4aXhXbnNnQzNxWllpWXk2ekR0TktxTlFPZHl4bTNZ?=
 =?utf-8?B?cW1yWXNEeUFKbXRXOGNVa0xyVUZBRld0eXE5bllINnJyb1FGY1lkRG1HbkNS?=
 =?utf-8?B?WGlFaEFCb2FMcWN1cWFubU0wamZadkJvc2pBbnRIN0dENVZhK0hlYkY0UzR4?=
 =?utf-8?B?ZXF2L1FrMW1hRW1hMk4rVlIzdVFuRWJCUWs0L1ZkWDNKdEtHSW10K0FMUFMv?=
 =?utf-8?B?anlPM2NpaVdHRDZEaW9pZStOMnByZU1qKzczMUQyc2hpRFhFbnBucDAvWllK?=
 =?utf-8?B?RFQ1VitXR0toZm1NeC9zSzFpRFVFRDNXRVlWcFA5SXoycTgwVUpucElMN2tT?=
 =?utf-8?B?TE8wR0c4cEZPamdOaW90aGNpUzA5V1lsUy8ydURYOUZ2d3NHcVcybjlQd20x?=
 =?utf-8?B?YzlpVFdPWGRLcHduNkpqKzNFU055SWV6T0FEMUtDS0F5YkhJRVN5YjZDOERq?=
 =?utf-8?B?QXJmNm9sTUJ4cytZMG1XTFRnR2ZEL2YwVk1naE5vUmp1Qi9zZk5kYlZtOUpM?=
 =?utf-8?B?Yythc25jNmdPTzR3MVdnQWtOMGx1T2RYT3pCaU5pWjE1QVBCVGhUdVIrelRJ?=
 =?utf-8?B?clVIWVF2WXFhMVk1T2gzSUs2L3Q4WEc1YmNMd25ZdlN0L0hSeXVlMUJKekQ3?=
 =?utf-8?B?VitxcE1UR3MwN0plR1ppdlpkalJrVVkwb0VEc2JTQWdPTW9KM2YxbmcyeUhy?=
 =?utf-8?B?Vmw1ajZyR0xhZGZXOUQreWEzNXVhb01BN2Q5OC9SNzBudk81NVQzSFhHeU5B?=
 =?utf-8?B?RVpVRVpjNlFSOUFRSm94SWhuWDZxMlUzcFJXaXZjNHNXbWV1TjJsdy91VWZE?=
 =?utf-8?B?ZjBVT0c5VHpQMWROV2xjMkxKVkR6THRBNytjMFRkNnhHbkZvaWlnSkhzMi9s?=
 =?utf-8?B?RFhNZ1FNRjhUK0tQSWk5a3R3RWJWSFpyMGIybU9PK1kxejIxUFFheEJwMVFo?=
 =?utf-8?B?YkN3bjlWZmFWWk8yeW5UTlJsd1dJY01mQXloN0FmRUVwd3UyUUltL3hVb2Y3?=
 =?utf-8?B?ckk5eGlWK3MvVk1odnNlNlU2eDE3UUk2OEMwR0FnU3hHaXNPdmVDanR2Tm5q?=
 =?utf-8?B?Wk5tdzQzMW1ZZ0tDOVp0NzhVSVRiZTVzM1ZNZ1ZTVnRkQkp5SDF2QnNNalhF?=
 =?utf-8?B?OTlWTk9ibDdFdmp4N01mK2ZkdktUZGhWNUZFR042RkxHSXJENE1YdmZBaExo?=
 =?utf-8?B?ZWsrV2srY1ZzMHNmUGovYktkTEl2WERDNFpwZ1VWVXNWUjFadVZxVHI5ZHpt?=
 =?utf-8?B?Zkd4MHBCUkthZGJvYldtbHdHK0NtN1hjcEFtVkxVbm1EeGFpU0JqSjJ1N003?=
 =?utf-8?B?Tk1MQWlnTmZXMlFXa3A3SXhqbzBpb0E4Nm1pTDJYZVFjWkdsNVNqZU82cDV4?=
 =?utf-8?Q?SHgM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:42:25.1943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3b92dd-8736-4e58-af10-08de17c28ac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
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

../ras/rascore/ras_cper.c: In function ‘cper_generate_fatal_record.isra’:
../ras/rascore/ras_cper.c:75:36: error: ‘%llX’ directive output may be truncated writing between 1 and 14 bytes into a region of size between 0 and 7 [-Werror=format-truncation=]
   75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
      |                                    ^~~~
../ras/rascore/ras_cper.c:75:32: note: directive argument in the range [0, 72057594037927935]
   75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
      |                                ^~~~~~~~~
../ras/rascore/ras_cper.c:75:9: note: ‘snprintf’ output between 4 and 27 bytes into a destination of size 9
   75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   76 |                     RAS_LOG_SEQNO_TO_BATCH_IDX(trace->seqno));
      |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../ras/rascore/ras_cper.c: In function ‘cper_generate_runtime_record.isra’:
../ras/rascore/ras_cper.c:75:36: error: ‘%llX’ directive output may be truncated writing between 1 and 14 bytes into a region of size between 0 and 7 [-Werror=format-truncation=]
   75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
      |                                    ^~~~
../ras/rascore/ras_cper.c:75:32: note: directive argument in the range [0, 72057594037927935]
   75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
      |                                ^~~~~~~~~
../ras/rascore/ras_cper.c:75:9: note: ‘snprintf’ output between 4 and 27 bytes into a destination of size 9
   75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   76 |                     RAS_LOG_SEQNO_TO_BATCH_IDX(trace->seqno));
      |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_cper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
index 2343991adccf..54503d0d4d36 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
@@ -54,7 +54,7 @@ static void fill_section_hdr(struct ras_core_context *ras_core,
 				enum ras_cper_severity sev, struct ras_log_info *trace)
 {
 	struct device_system_info dev_info = {0};
-	char record_id[16];
+	char record_id[32];
 
 	hdr->signature[0]		= 'C';
 	hdr->signature[1]		= 'P';
@@ -72,7 +72,7 @@ static void fill_section_hdr(struct ras_core_context *ras_core,
 
 	cper_get_timestamp(ras_core, &hdr->timestamp, trace->timestamp);
 
-	snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
+	snprintf(record_id, sizeof(record_id), "%d:%llX", dev_info.socket_id,
 		    RAS_LOG_SEQNO_TO_BATCH_IDX(trace->seqno));
 	memcpy(hdr->record_id, record_id, 8);
 
-- 
2.34.1

