Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CA4C55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 07:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB24910E88E;
	Tue,  4 Aug 2026 07:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cwu38HEr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5187C10E88E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 07:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWdMWLtpa7ddIxMcBQvHD6xaLvsTwWvpZhQLo8AFeQJBd1HVlxyaJ5GGbKu+eArsIGh7Z3mvXoo6yZi0uzU267zHRBnt1XXIj0YOFurnMzJPSX9+Djnm9ziGb9bVuyVYQ+secx7ITjbgCnveZTk5FfCChVOB+/qAXqrPr427jISut0YH6XX1TxGynqotE0/9O6CA51wuwW6ZI0cHi0jIYBQU1h2wbS0weOH5MhUrV8XUG6TVCbxa5gQv298dT7JwMORUAcQ9Y7Ib/ifYjvh7Jr6V1GstwDI5S3pcA00qojgVKteQDduU6DY0S8ubxCxdJlc/50nwt5yX0Q0ntaL4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RD2pd6Rhtj0oZhj/XMdo2BnDdJaaLcTzYctfnF47Vg=;
 b=hDjSkGQ/0JGVAmvmMNAPyX7T1Z+2lIXtmOKV5UV7XuEYW5SMhFKSjxKNAEA4/SWxl1967+Op3MNktHWNFQ/qqDj0lBcyzJ4xUiad8G70V8m1unDAC8lJmaCXn019sJZbYwW8Qs1IZC27oNbQ9YBgjxgkawUopvYsFWYwMWnCUzsBddE3ldjHRLhPLvPE41OhEax+Ce9/CQiMRjBfDsLHtBHv9wI8+HVAckM/8VQTbQz225VUKeUZ0A4IiWhx+fGDuaWygSqK/zIcZlrJkI7CxS77iKX12rBooSBLEe1JQIGioSeJAfiW7cnugCom6m5HztyV7I+U2DAP2T+MTnOXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RD2pd6Rhtj0oZhj/XMdo2BnDdJaaLcTzYctfnF47Vg=;
 b=cwu38HErBTP0OP7NJuJDpLWkY1YNrWtgpZWPJpgtwLWKZCUZ7OubgXAmk4ky+wDv24Tpg2g/WVKq2dzRE0GtOmP/pSwxCcA8f5dY3p6ryn8I8xdyXs4zght8foHUcHXD+MHYwLtO2f9Ue4hJPmnyhese4ZbFYdhEdE1Updm+LlE=
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 07:26:10 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::72) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 07:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 07:26:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 02:26:08 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 4 Aug 2026 02:26:07 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu/mes12: fix dropped dispatches under queue
 oversubscription
Date: Tue, 4 Aug 2026 15:23:32 +0800
Message-ID: <20260804072606.2710051-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 85eb2e09-34da-432f-518f-08def1f9a816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: CnLNbAzmlrK9I5GAE2B8v7CRNEFQGb1aH/DU5NJw3kIFtQWq5PfrfxHR3H9QSXLRllTBNoj7C+Z1xs6GojsbGvS6YCzyXKHmOoyKor2wDjDS1S+hJOygKe9hHiuUPMfBZwNjhi2YNZVC2V4hLRxpht5lhMosuwi/K6lqpgiq9x5FbA09ZwAwfsKKfnBmaXrfWRbjojyM30cfei78LwyUN6wQl4G3cEJqaM33xTGpaoU/H5Iz3uAu8NywTSbmokL570jk73l2dzevZnB8sf7jqCzBqfAiIu2eRTj1dvAilqillsugw6mLKyMcieuCW3rc2hBsas26vddW3jM1oH5Va75qcorNRtrvWmMX58jacYWmWMReLH/Fj1chVcHTIATbHOhTzIDybef0HXbx0KM8pdYZqm2NHBtJHgSFYER8/61m/GymSIbPXmVmaiWBAte81ZSDBvG+N5XSmapldAfSCTeQ/TM8BdK5fwxacccC6Igwd+X12aQq4fQIP8pHce/+Ihk42LFAlyXRJPD2ZOBJJR/cnj4es4CHd/A5rmiyPkBXCdDNHnnLDu9XffzwhpSpPcM0up9Le9aDLlP7pt/M73Ue61PiLPXMZ0wJ9Qdr9w89X3u16nT1ENC8uQTgfuhGb0PdMM3eSDnPhnENf758q+Qx4Gu2xCTeggV27M5lB19Kjt9lGnsmMSCqH3v+8YL8jUijaebY5hFMGhpK3di4Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XizXO4LdW2dVEngky5I1IAouTHwPcy1kunv0HQ2qFqhszWjDcZ8GS2AMQxzqHI9Vvfa5wAfQ1X45ISAuAsfSE34wox4l53MFkXh7vq1n1di/jykv+RhOCe8yMOHr/ERL3BbdK5NDr2uFK0DRxb5Z9MWmB2qtESCvieE8TvOsdw7uab4KEWRCtE7hrkcIZS+nBvHYreEomnF43ZMmi9Oyg+9oZBDMe2/EnjQeP4nslpeoxgTSb4FVRM7rTQl/mJ9gdLPykopxPDAtkqdy4x4qt/AUw32t9JdG3vorHGBSpf7Cg4hj7TS6vposyzajQYH+VoqZLUEG/2BflusA2dA3/rOrKpGW6TDJuTtZrOHCqIfOQJE8bTzm2D1jwUs3Jzj1dp6aEaxZ3FGmxeRbvokIVZHfNKD/vZrGvD67avspWjwZ/+D37P7bjT9m2xE3cbal
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 07:26:10.1029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eb2e09-34da-432f-518f-08def1f9a816
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790
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

On gfx12, when more queues are ready than there are HQD slots
(oversubscription), MES keeps queues unmapped and maps a queue to an HQD
on demand when its doorbell rings; a queue is only refetched once its
per-queue work_done is cleared.

Historically oversubscription was handled via the aggregated doorbell,
but that is a shared level-wide signal: MES cannot tell which queue rang
and never clears a queue's work_done, so it relies on the coarse
oversubscription timer to rescan. gfx12 therefore drives GFX/compute
through the per-queue unmapped-doorbell path instead (the aggregated
doorbell now only serves SDMA), which can pinpoint the ringing queue and
lets MES stay idle otherwise.

But with unmapped-doorbell mode 1 (basic) a ring only sets a coarse
level-wide ready flag and does not read the per-queue bitmap or clear the
ringing queue's work_done. A queue still marked done from a prior dispatch
is skipped and its new work is never fetched: the completion never
signals, while queue creation succeeds and no dmesg error is reported.

Switch to mode 2 (basic+): MES reads the per-queue CP_UNMAPPED_QUEUE
bitmap, identifies which queue rang, and clears its work_done so it is
rescheduled promptly. This affects every queue MES schedules on gfx12
(KFD and DRM user queues), which share the one MES instance and this
global setting.

Tested on gfx1201: concurrent multi-queue dispatch that intermittently
stalled under mode 1 now passes on both the KFD and DRM userq paths.

v2: update commit message: describe the oversubscription case, why the
    aggregated doorbell is not used for GFX/compute on gfx12, and why
    basic+ (not basic) is required.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 8d1d1bf9091c..cda83e6533cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1015,10 +1015,16 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
 	 * handling support, other queue will not use the oversubscribe timer.
-	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
+	 * handling  mode - 0: disabled; 1: basic; 2: basic+; 3: basic++
+	 *
+	 * Use basic+ (2): on an unmapped-queue doorbell ring MES reads the
+	 * per-queue CP_UNMAPPED_QUEUE bitmap and clears the ringing queue's
+	 * work_done so it is rescheduled. basic (1) only sets a coarse
+	 * level-wide ready flag without clearing work_done, so a queue that
+	 * rings after work_done was set is skipped and its work is lost.
 	 */
 	mes_set_hw_res_pkt.oversubscription_timer = mes_rev < 0x8b ? 0 : 50;
-	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
+	mes_set_hw_res_pkt.unmapped_doorbell_handling = 2;
 
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
-- 
2.49.0

