Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E31C41535
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 15:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9540E10E7E4;
	Fri, 22 Dec 2023 15:27:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E722310E7E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 15:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCiFlXWiBC+ukHFgDRjKhOpShRPhBlArNr6sndbWzwREvtqRvAKOteNSQ4r2JNJyUL71N78KUDSKjoKSUrbM8U6o5Fi18mwfXWXhFC20Y+gjokMT0AxRL0e07nKqC9BU313pT6CTUmKAcSfRnSoMY0usqU7UVl+WucOnVF7WhMBXD5h1xds30/jzkdNDAx453WfHzMvQqkQVnn9nvcjnGdkzzI6PfLvLrnlsNgjFvLA19yJvLyX2nSZ4L461xkA4HnF++ETYKvOBnKf6W34rkzwJv65hECAsvqNx9qRu0zDh3DeulkS+XdvJYGIIrx7vfUSttUNcmKm5IBvrJGd0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESnNbpBhydxYHjxZSvaIPelJU6yEnjq1tIGnkIpZk98=;
 b=BJc3odoIYJtFlt8vzfT1FcySWfp8wBX/twcXzjIy1MZOqq4pgy5UxVsWN+aN5clgmRbcjWgzFuOA3AbtGorhuJBrH7mfZ/a8WPKhNJ9hUZttyb7bzkbKVkEONeFUbE7yZ8KopYYkyyrSGDGXWzVoRJDUSg/CrAs8b5l9F1ZgJbvdA+N9Sa+pMrOg4X716FHeviJV8BvccCZnJkVqUsXfUeUYj3SJqhTQcr1/5FVPMAyDK71AVvvbAeb0PR/9vKOzBBt9sq1GQBUxg0TLvr/Bwc5bRfLiWXllpQSWBcIQjIH9Y3zev6iPoELi/2w+YWm6ptgwHfn/wTMF33VJ/Lvsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESnNbpBhydxYHjxZSvaIPelJU6yEnjq1tIGnkIpZk98=;
 b=vdBgdH240O6NC2l4775jfWho35oM3YPKda0oTXFnk+0DJv7zu9M9l64cjc9H5bjqElvBXg9D8ObA/gax+wZXAFQ+K32Ng8MpjPW8N3gp7hcYR+hGZyKiAea6AmZcj0612cFdK2nY7ytVoiTFtDIbTaab5Kq9/lXWUWjqKCkzt9k=
Received: from MW4PR03CA0060.namprd03.prod.outlook.com (2603:10b6:303:8e::35)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 15:27:51 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::c4) by MW4PR03CA0060.outlook.office365.com
 (2603:10b6:303:8e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 15:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.21 via Frontend Transport; Fri, 22 Dec 2023 15:27:51 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 22 Dec
 2023 09:27:47 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: Use gpu_metrics_v1_5 for SMUv13.0.6
Date: Fri, 22 Dec 2023 23:27:27 +0800
Message-ID: <20231222152727.411440-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231222152727.411440-1-asad.kamal@amd.com>
References: <20231222152727.411440-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3c3e23-79e6-4b94-a172-08dc03028f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfQD8fP9uWzJRE9OWMsTs6hO1oJcAfGB/lVfvCEQZm2dm4dyH3nTvtameYyvE9L6r8N4X0FzSD7W54cEqVpQj/uT1eyDNhCdlRVmnKDsWe1zOl2AyNYp6NO/OGKAM9WftZ5xptSFA8gGXZIqzJm1XwJrefIJ8UqsgoHYOxGzcDPkOr8YdFPzRlqvDUUtWMg0eKD7Rm8sNXQpENlTELV6GkJcclKhZGO6QEaezXxbuwrGQFHSSqAteR2BwvDWbsZTb5CiVSsHpok+ncAN7B3tK4mjjPVCabY1JS7cDWYGXMp3895Bi7Biiw13hQM6pnZ/z6zXX9GT9bNX6szjxWiMZlt71+LZSJT89dQ+oIh3mpwIBqoIEMkjKV8ef/UOMhR4I7zqS+mnsFs9Y2he0X/fJ19xA8fKmjti0FXyQGzeH5v98oQLQwLEP65s8ynoBhcVguf903reOtSU8hnTaXZLME2J7iccKLD9EIvzFA9iLqlbKDD8uLyak9tPGQsYVKqtXKd9DQh7n5AAnzmcgl7N9PSTCoA1Tihe7sDC9BQ2IY9IoHKgYROnN+W0MTGPnB6hYfaxo/gsqeR2Mi4+WR5U8RmvU4yTmlOYGnsGG3OZ8+O9xi9rPMjZuoQaaOc18fUdVBJmoap6lu3Dab+9mG2MZel+TTN7xiHv2LN2+SekhZSNo6oZrz8az2Syw2X8FuOF6YQA0Ewh/0361odIBYTMNTvQG4V0sOb3TGNyN6J7JS/2vFbXQAl8xDu9GciREjUvJx3U6/MioPsDMhjeH4EoEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(478600001)(4326008)(316002)(6636002)(54906003)(110136005)(70206006)(70586007)(8676002)(8936002)(83380400001)(47076005)(6666004)(7696005)(1076003)(336012)(426003)(2616005)(41300700001)(44832011)(5660300002)(2906002)(26005)(36756003)(82740400003)(356005)(81166007)(36860700001)(86362001)(16526019)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 15:27:51.1053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3c3e23-79e6-4b94-a172-08dc03028f87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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
Cc: sepehr.khatir@amd.com, shiwu.zhang@amd.com, daniel.oliveira@amd.com,
 le.ma@amd.com, donald.cheung@amd.com, asad.kamal@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use gpu_metrics_v1_5 for SMUv13.0.6 to fill
gpu metric info

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 96777a365133..4ebc6b421c2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -347,7 +347,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_4);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_5);
 	smu_table->gpu_metrics_table =
 		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
@@ -2074,10 +2074,10 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_4 *gpu_metrics =
-		(struct gpu_metrics_v1_4 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_5 *gpu_metrics =
+		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0, xcc_id, inst, i;
+	int ret = 0, xcc_id, inst, i, j;
 	MetricsTableX_t *metrics_x;
 	MetricsTableA_t *metrics_a;
 	u16 link_width_level;
@@ -2091,7 +2091,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	metrics_a = (MetricsTableA_t *)metrics_x;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 4);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
@@ -2158,6 +2158,10 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				metrics_x->PCIenReplayAAcc;
 		gpu_metrics->pcie_replay_rover_count_acc =
 				metrics_x->PCIenReplayARolloverCountAcc;
+		gpu_metrics->pcie_nak_sent_count_acc =
+				metrics_x->PCIeNAKSentCountAcc;
+		gpu_metrics->pcie_nak_rcvd_count_acc =
+				metrics_x->PCIeNAKReceivedCountAcc;
 	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
@@ -2174,6 +2178,21 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc)[i]);
 	}
 
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		inst = GET_INST(JPEG, i);
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			gpu_metrics->jpeg_activity[(i * adev->jpeg.num_jpeg_rings) + j] =
+				SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy)
+				[(inst * adev->jpeg.num_jpeg_rings) + j]);
+		}
+	}
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		inst = GET_INST(VCN, i);
+		gpu_metrics->vcn_activity[i] =
+			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy)[inst]);
+	}
+
 	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth));
 	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate));
 
-- 
2.42.0

