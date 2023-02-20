Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C8CC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 03:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A48610E087;
	Mon, 20 Feb 2023 03:17:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F401010E03E
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 03:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9XKc3iJwr/I3rEVWyqNoQsBMV3YvGgOR35AqmYxAdCy8YcvgZcHHXBXbVHU+D5pmvyXcUauHZRUmwvQj2d9xBKsAh1imv535qTfvzXjMImz4Ehpxaapdwlg5XxCfLGrObdWL48zzplWN2X0Fby4RicJpebHmpxeN2BvdYGrWArcl4nViWCYm5xfXZWRNTrf3pEAAIvQ7xXi/ODCY6ZhxPoptwI13EScfQwHyODLyjB0DtRwBGgFoSFUsAvg3qsUv94+05T0d08Xhh3u0W/q5URtHLVZjwJ8oIW4Kg36Tz75II+gepom4KVAIuxnzFXjwnjI6f2Txo6/QvwSzj7Sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFCc9ZbOFDuxhn22yF45Pm8+upKJOtJJpr7auVG/j9w=;
 b=gZufIBaQm1yUhkBuA2R9GZsdW+BazSImLWRKH4vED7SEIUNrjyYcZ0E1k2Meqp+rEs4S1eiaxWDJhwJnQ815vsFMeMMZ5AhzowU95fwIRfqFFkLiiG9ctKTjtWb8pKnZAMIChXPtFuJ4bzjtCPG0KABW3nU0VqXCRc5tUCVLZvaZz5RHsFl9HZ+dCnFvxXhDb5IWqGfXxuu0voEijdyuGi+eDJEguveCKhVhUEG8EOEOKt+Cj0d1en2aIbDqVRSJVhU37D6kXl1pDmRkFgNi8ElgEdO3wfFhXiJwVZO67r9xuzM0ft4g8N7xLiTwoz5F7nn0sMLtSlCRf5pzMq2JwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFCc9ZbOFDuxhn22yF45Pm8+upKJOtJJpr7auVG/j9w=;
 b=02OKbG/l7xW9Cwmhnvxjhh1nS6OIxqrHlM3+es4U1OT2BNUnkKahk6WJVYD72njeoC6oGVTZYSxhwImYQYiAyruWaotgfLVRHINdfv84mAC0F8LNZSKz7bbdERWiE9I5vjbggvO6zM3de8BaSApwWsRyQx6xVLQuagc3fV4wyfk=
Received: from MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 03:17:33 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::c5) by MW4PR04CA0068.outlook.office365.com
 (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19 via Frontend
 Transport; Mon, 20 Feb 2023 03:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.19 via Frontend Transport; Mon, 20 Feb 2023 03:17:31 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 19 Feb
 2023 21:17:28 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>,
 <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE count
Date: Mon, 20 Feb 2023 11:17:17 +0800
Message-ID: <20230220031717.18738-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230220031717.18738-1-tao.zhou1@amd.com>
References: <20230220031717.18738-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b7fd1a-efc4-4eda-f940-08db12f10104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVfvhw6sh4b/nhceCYqYcO7WPIUjsiGHU4rBA2Ju1NANDImumb+pWJzqseWnEP/ECCgyndjKMPph9aNnLw/szPeT/d4DmoBzCtQ1qgcdGfwpX7cwBEBwbJKxRUseITJOzmrfMO1wfrWqW05LrJ3cRtp1uFQXKyDrvsphnC95BPUteKTXNu5jupNUzbgd2E0f7FjUoj8P3eiPC+uUpxAJixOD+6zNuNw2Jd+eanRyxJZeicLyq/XfT1CupfFer7Tm46hVmX4AqibADQeLJX/N7KCQGMsmtiSqEzvuFXqn39df37I8p6AoE3M/Ru1q8/4/0Mw79i8h/BC2p68U6g3Kca9VICu5EpT8o2yaMgRF+5p1J7GRM7S/3dCbLC+87Evz46tIv+MhhU+Uza8R1jomkUJogZwTiRuzdGNeWDKEIM/H+hdY1yA27CjYLEGNbbrwr06L4htbzs1sYpBLaBAZsuyUdddk9KosROK3T3ehVAWpZfEWK3GIs95kggjVP7TneLgJANgoDEqmxyM3wRFxtAKchCro9nIJ638+9nh+WkmKHC+YvAuvz3h3Fd8bLsttJJdLRdQ8/SAA3AEAjx5el/LD1bqG4+w4RAzWehMTD5/bzUC5CBUDJXLuOUfkfFhYLKpR7iwDjtzag8WUnqj+lcZ4w22JPMTrFcrZUEe5xsdSjsC/uu+V3N0PK0YKjlbaPNJA0BE91iYaTXGUUVw7AGbPJDQVtLebBbddz34qO1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(186003)(26005)(356005)(1076003)(6666004)(2906002)(81166007)(16526019)(82740400003)(2616005)(86362001)(82310400005)(7696005)(110136005)(40460700003)(36860700001)(5660300002)(8936002)(41300700001)(8676002)(4326008)(70206006)(70586007)(47076005)(336012)(478600001)(426003)(40480700001)(83380400001)(6636002)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 03:17:31.5172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b7fd1a-efc4-4eda-f940-08db12f10104
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a UMC bad page is reserved but not freed by an application, the
application may trigger uncorrectable error repeatly by accessing the page.

v2: add specific function to do the check.
v3: remove duplicate pages, calculate new added bad page number.
v4: reuse save_bad_pages to calculate new added bad page number.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  5 +++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6e543558386d..5c02c6c9f773 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -176,7 +176,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
 					 err_data.err_addr_cnt);
-		amdgpu_ras_save_bad_pages(adev);
+		amdgpu_ras_save_bad_pages(adev, NULL);
 	}
 
 	dev_warn(adev->dev, "WARNING: THIS IS ONLY FOR TEST PURPOSES AND WILL CORRUPT RAS EEPROM\n");
@@ -2084,22 +2084,32 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 /*
  * write error record array to eeprom, the function should be
  * protected by recovery_lock
+ * new_cnt: new added UE count, excluding reserved bad pages, can be NULL
  */
-int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
+int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
+		unsigned long *new_cnt)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
 	struct amdgpu_ras_eeprom_control *control;
 	int save_count;
 
-	if (!con || !con->eh_data)
+	if (!con || !con->eh_data) {
+		if (new_cnt)
+			*new_cnt = 0;
+
 		return 0;
+	}
 
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
 	save_count = data->count - control->ras_num_recs;
 	mutex_unlock(&con->recovery_lock);
+
+	if (new_cnt)
+		*new_cnt = save_count / adev->umc.retire_unit;
+
 	/* only new entries are saved */
 	if (save_count > 0) {
 		if (amdgpu_ras_eeprom_append(control,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index f2ad999993f6..ef38f4c93df0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -547,7 +547,8 @@ int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages);
 
-int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
+int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
+		unsigned long *new_cnt);
 
 static inline enum ta_ras_block
 amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1c7fcb4f2380..7c6fc3214339 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -68,7 +68,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
 						err_data.err_addr_cnt);
-		amdgpu_ras_save_bad_pages(adev);
+		amdgpu_ras_save_bad_pages(adev, NULL);
 	}
 
 out:
@@ -147,7 +147,8 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt);
-			amdgpu_ras_save_bad_pages(adev);
+
+			amdgpu_ras_save_bad_pages(adev, &(err_data->ue_count));
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
 
-- 
2.35.1

