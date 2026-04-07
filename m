Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA472FB5189
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 03:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6590C10E318;
	Tue,  7 Apr 2026 03:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NHK5tkmm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B747F10E318
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 03:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTLL6ieTL5Oh/62TV4flnBGcIDokWsA19dOnj3m/X8vNIrmvHFdAnbHBIs3PwqcQh/qhoiKSS6bJ+QZoowyPGbtP65FNSuZBt4eK3jsWe2LQZYyrBkdN0CVRh/uZWcVwmwJqfFfE79aABzwVHiFXR6OZvN0wzYlaxR7X8MS4cU6yBDqOKGNG6oe5zeagRAPk0t5W1qmaRPRV7alLIPL7JZLK07Du5TZI0po2GqBcSDtvYqvZre0Y5OYhNPmH6tHplIuiEI5VJZL4XNlRZJwD+kXjBJZbV1wi8Op8ZHgSHCui78TjGQGXVWE6RhLVhYw+lgDD8EEplRJanFYT36HibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J82bod82knbDGfsCevqOa5JFw4+I4SMak0YqSZPLVY=;
 b=kt3fsa8NxiaXJyLNBdNOlYIJ5cDBUzt+L09aAvYzR5pE7bY1KCTgQFFJeUFoWt5YOwg1Lrc//ImaBUP/e8Gm5ymm/2TvcIrGWYDud+Km604lq6DOWSiJe5pQG00S/LNR+1b1OeTcHX9eimCl4/tWfok+eJs4g+BC6izURNo8qBVaNkHIsQHRkv/De7YXga7/6hfZwqEDBuzJQBHsCugH9xoOUSjVImDkMXTMfDgh3Ot3+HezNOEbX/LVmHCS/obEMRFfyznc2aSz/PRDC60dnbvliSW5ofoxRDhDMTbi3w5BR7ywXEfb8OVqxH1G2M4DVVvySe9o4C2eoF8QKzsW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J82bod82knbDGfsCevqOa5JFw4+I4SMak0YqSZPLVY=;
 b=NHK5tkmmv+K+voTfjAeNDzaK8rRdJ2OM+SykES3N5G6yUMC9GOJX7wksvrKP9EFMMzFncBP93fsM0KqOW9fbF9q5tjc+6hWYK7RegfvzhYuYxxgt8kt8mIWsSO9Ql1uCR+Jo2rZ6RDqmDOTRNkZDUSqX0Jc3NKDFs9etMqAwguo=
Received: from DM6PR06CA0085.namprd06.prod.outlook.com (2603:10b6:5:336::18)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 03:09:49 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::52) by DM6PR06CA0085.outlook.office365.com
 (2603:10b6:5:336::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 03:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 03:09:48 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 22:09:47 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: add od table upload error message parsing for
 smu v14.0.x
Date: Mon, 6 Apr 2026 23:09:31 -0400
Message-ID: <20260407030931.2024335-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407030931.2024335-1-kevinyang.wang@amd.com>
References: <20260407030931.2024335-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 34375aac-197a-449f-2c8c-08de945320fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QR7KOzZbLOd3cKAvLplY5C6Vxb1U5qlAnR3XmuZNZT8NZrlmZaGTuJO77x2cV3qTlBVBEWv45zx4lOFcAyUxDR870x0pOva1NBRmtPiBjs48OD0SbcFwvg38jSKkN+klFTBaI9Y1ZnMXt/uIqO/3KBZx7u25wCPoFMHvPNs5rIBdzJYk6TYH887AzAuw7HqmOwL8pmxVbLaZVbu6nXlVCSdZb2DKpgmBG+YGAw7f/9FHFRlC4Pr0KBcoOUmFJiQ7ZeE/GmfqUjhzmcqPRm1eKXRXcUrmmKzJG4qRY+nJfxwXCcxFTS7uFYcRwhh4kfaUo5Z3Q3PTCCNri3l+vbFeUtrqhjQkh/Pflee48IwZjVoQnHCFl4ctP5tecTwHVV9GfZcTUvOimn8UiG6fmT4XrmJiDIEDhS2bRgxG7DjM3/L6ARwZZitlEAj0YodywPe2X56WzGE/yqGKBel5My154OaFoD1LKYwQ84vRP0M42Odo5mRP/3D90k778Vp8LbL6KkFBagKlgSGJl+GEg6T2iiiEhs3Qu7BnE1TzNnRGo6EZpdCY9T1UrwWDAO3ruUBm8U4QcD6v5vtXu95B8P5wrxJhLS+p1+4JLM+TgDAMRPqioCJhZ8oiLbfGXX0QAqWi86LFNNasC5ZnhO/2SYUqmLdn9B09Qim+2hIwG3QeqAJ+JZlPn8izoRaZDffqUFfi+TolT4u1zOmdXpJ5HyPxDWEkmBNNmEt2PxogP5rzh1OP5qE+0n+HqMWcI6xf8XCwSggGQNFjTkDmMRRfAVg5ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: htMjjR5RKzodPN13WfilXO92VhabrwAoXAOQyQH8QeywDOJSc1D6dR7/ZnQ56ToSPxnYpo/TPkgIeFZg0s0nM7h7xJltU/0GRtUq2iqoNo4sODG+/wyOti/kszC1YhXl4M1WV7Ax9w/ABESt7Aqy1RT26Cz/AsOZwkiNy8m1dwOMEEyPlJCz73aijeoZLbfsLBjDAl1TYAF+PibCClzunD3ga/vSnHVKOMElAhOX6rhr3kqD5iRFQLpFgbYU/7cggJ58HYPNdjeMxKYcH+R9ZwoceRqcmVkre198XqNT0Uu0ZO1x09ejowYum7O/Mi0QHNA9102oz9n708rjeh5olwu7LBv/oFqArMb/aZk+u3LyYRdh1bmI2/sL086gJ79P4jGxp5+WSc5B7lATDCwmuQEwO6WfBsdhNl/7aEQDccbXzM6vxTUMcoUk0J623EWs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 03:09:48.9336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34375aac-197a-449f-2c8c-08de945320fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
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

parse and print detailed reasons for od table upload failures to
help users understand error causes.

example:
$ echo "0 30 40" | sudo tee fan_curve
$ echo "1 40 30" | sudo tee fan_curve
$ echo "c" | sudo tee fan_curve

kernel log:
[   75.040174] amdgpu 0000:0a:00.0: Failed to upload overdrive table, ret:-5
[   75.040178] amdgpu 0000:0a:00.0: Invalid overdrive table content: OD_FAN_CURVE_PWM_ERROR (13)
[   75.040181] amdgpu 0000:0a:00.0: Failed to upload overdrive table!

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 60 ++++++++++++++++---
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0bad56a44f5c..0ccad0b48c09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2230,17 +2230,61 @@ static void smu_v14_0_2_dump_od_table(struct smu_context *smu,
 		 od_table->OverDriveTable.FanMode);
 }
 
+#define OD_ERROR_MSG_MAP(msg) \
+	[msg] = #msg
+
+static const char *od_error_message[] = {
+	OD_ERROR_MSG_MAP(OD_REQUEST_ADVANCED_NOT_SUPPORTED),
+	OD_ERROR_MSG_MAP(OD_UNSUPPORTED_FEATURE),
+	OD_ERROR_MSG_MAP(OD_INVALID_FEATURE_COMBO_ERROR),
+	OD_ERROR_MSG_MAP(OD_GFXCLK_VF_CURVE_OFFSET_ERROR),
+	OD_ERROR_MSG_MAP(OD_VDD_GFX_VMAX_ERROR),
+	OD_ERROR_MSG_MAP(OD_VDD_SOC_VMAX_ERROR),
+	OD_ERROR_MSG_MAP(OD_PPT_ERROR),
+	OD_ERROR_MSG_MAP(OD_FAN_MIN_PWM_ERROR),
+	OD_ERROR_MSG_MAP(OD_FAN_ACOUSTIC_TARGET_ERROR),
+	OD_ERROR_MSG_MAP(OD_FAN_ACOUSTIC_LIMIT_ERROR),
+	OD_ERROR_MSG_MAP(OD_FAN_TARGET_TEMP_ERROR),
+	OD_ERROR_MSG_MAP(OD_FAN_ZERO_RPM_STOP_TEMP_ERROR),
+	OD_ERROR_MSG_MAP(OD_FAN_CURVE_PWM_ERROR),
+	OD_ERROR_MSG_MAP(OD_FAN_CURVE_TEMP_ERROR),
+	OD_ERROR_MSG_MAP(OD_FULL_CTRL_GFXCLK_ERROR),
+	OD_ERROR_MSG_MAP(OD_FULL_CTRL_UCLK_ERROR),
+	OD_ERROR_MSG_MAP(OD_FULL_CTRL_FCLK_ERROR),
+	OD_ERROR_MSG_MAP(OD_FULL_CTRL_VDD_GFX_ERROR),
+	OD_ERROR_MSG_MAP(OD_FULL_CTRL_VDD_SOC_ERROR),
+	OD_ERROR_MSG_MAP(OD_TDC_ERROR),
+	OD_ERROR_MSG_MAP(OD_GFXCLK_ERROR),
+	OD_ERROR_MSG_MAP(OD_UCLK_ERROR),
+	OD_ERROR_MSG_MAP(OD_FCLK_ERROR),
+	OD_ERROR_MSG_MAP(OD_OP_TEMP_ERROR),
+	OD_ERROR_MSG_MAP(OD_OP_GFX_EDC_ERROR),
+	OD_ERROR_MSG_MAP(OD_OP_GFX_PCC_ERROR),
+	OD_ERROR_MSG_MAP(OD_POWER_FEATURE_CTRL_ERROR),
+};
+
 static int smu_v14_0_2_upload_overdrive_table(struct smu_context *smu,
 					      OverDriveTableExternal_t *od_table)
 {
-	int ret;
-	ret = smu_cmn_update_table(smu,
-				   SMU_TABLE_OVERDRIVE,
-				   0,
-				   (void *)od_table,
-				   true);
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+	uint32_t read_arg = 0;
+	int ret, od_error_type;
+
+	ret = smu_cmn_update_table_read_arg(smu,
+					    SMU_TABLE_OVERDRIVE,
+					    0,
+					    (void *)od_table,
+					    &read_arg,
+					    true);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to upload overdrive table, ret:%d\n", ret);
+		if ((read_arg & 0xff) == TABLE_TRANSFER_FAILED) {
+			od_error_type = read_arg >> 16;
+			dev_err(smu->adev->dev, "Invalid overdrive table content: %s (%d)\n",
+				od_error_type < ARRAY_SIZE(od_error_message) ?
+				od_error_message[od_error_type] : "unknown",
+				od_error_type);
+		}
+	}
 
 	return ret;
 }
-- 
2.47.3

