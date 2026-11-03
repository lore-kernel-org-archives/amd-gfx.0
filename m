Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B84606A942
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A/FypUa4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847F610E794;
	Tue,  3 Nov 2026 08:33:58 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B2610E794
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 08:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rfq4ViCnUHHLmDluwNc76XkE3nZv4Go6cYvptpD/4VnL9mQD5EPkqtoxGOkmz/D8770o4Oj6DOAd34znmJmGB/RzSkDJYJJ0LCwzAVQJMrWFwFL6qU+366Ul8AXRcPGTBCRw32rIN2pb05E4h7xM7CuLgU98Bl0Cy2P6KuSqYE1Oc8vm+Zu7CYXp+/V5vDdZMCT/Ycl5WmVO8odmPpwPa0wWtYg3rUyprVayxa9PzV6wmbbq0zc6DCfztYM5D0WAoo0UA0xiEYqIUI74n6+IyxbWE8lF17roFZ5/3VRcTJxVBW/zZpQ7L3GaXzo9/tTmGjEYfulIonZPoxThGvuaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8dZ6MX0P1FejefpZQC6YtmZ9c7FBWIrTMokRI0v+G8=;
 b=PrT9fKhDq9VS0T5tlYYVzOtN9TkpsyfBfBn2mNgVEFqERT2DRD33Nl88d4nIiyHQzdOb9Figj7PJVsOdyJROBpMmHYwFNMqIKDilcY9xbFx/lsEfDS4qPRk9lWzukmbIQlR/FyBu2aYtvES0KNEl1fKwEmiCV5rhrkeI1xtrRe1BuDa27XQ9FjwOZUlMIeHryR2Fzmbx559bPfKBseUhUDrcylYorkaFYm2nJVc7W5TKoZjIA1Ab/jH2//K0TttoRNpYXskrFJM37FBLp4dHnhtvPn3OOTr/DdbTbGG+aiBhKB2500rb4NQ2s5FQTXAPXecrcHpQORbxYiwd4RkB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8dZ6MX0P1FejefpZQC6YtmZ9c7FBWIrTMokRI0v+G8=;
 b=A/FypUa4mKGIt1pYcx0vsRQhqNv0iAKyf4dvPqJjgMsYed1uk1HV7lb/WBvVhfYUFU00ymvx+6UIJ9SRkLMA+fEb58Jh449QgIS0egWhLG47KG/8PLpC5DtD97oVVOUeCoHsxkJ8COgCq8ChjPiogaCwzhirEs7w5Oj0NVJFkTk=
Received: from SJ0PR05CA0158.namprd05.prod.outlook.com (2603:10b6:a03:339::13)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 08:33:49 +0000
Received: from MW2PEPF00014674.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::37) by SJ0PR05CA0158.outlook.office365.com
 (2603:10b6:a03:339::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 08:33:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW2PEPF00014674.mail.protection.outlook.com (10.167.249.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 08:33:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 02:33:47 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 02:33:46 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 02:33:45 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Yongqiang Sun <Yongqiang.Sun@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: initialize the dbgext work before it can be
 cancelled
Date: Tue, 3 Nov 2026 16:33:26 +0800
Message-ID: <20261103083344.3056713-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014674:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 4189b4d8-361f-44d4-6881-08df39852e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|18002099003|261102123227099003|261021123027099003|56012099006|11063799006|261026140227099003|261022105027099003|261009223027099003|261028144727099003|261021121427099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: H8XllJj73iLJtp69ORuOwlDtIaiDyWevn8QHjl1sKbnAnlKei0xwQG+X/xPG9ylPTtFmqaf1+wt56TK4Ba7EmOY1IwjhAkJjF5lYUdfl+POeJaK7wK97F2YHMuoM1XY+djIrmaFVEjtOwB243Clwf7NeIvK9yIIlA6slxdwEURjQeaP8ASyzrQvXFISwu/QO81Ryn3R44+b4l9Bv9Wcsw12FvCUMqksdXZqB3FoyfMeJjOnQWSFUBab1m2/I8VRBTjTEJLKMKhFMkYpxbYKKeOhU4Il8KWsdVdYjvVJV0sSrxng8UgjjMSFj5NBaIJlkacnr7/EB4Iw1EFMND3VBMCNAFTGf2hzjw1ibaeiVXtRb01dt9yNyzRPfwlqtER6m610nuiBU84wfZ/eheqAnHydCEldqNNblZmDw9QAiavt7fe1H+w8+3ie4CqD8ZetpHI/zPgt7dVpIt9uyMujIr3K3OM9oLRbrYvT5XfHHa2wce6lv9MVT/4c2eNzv+r+k6CrF1foY3sc7SQNAk4BCcrdVlBkMkpnQmQpa+wSpKYTeLcgV5QgjEzbtx8Qbq9gxkDXorgceITctWeK+KPhVosaVRFl0cSsqCfJjIZUoO6gB0JmjHh4nZSakFwYTlJoUOrIQePLf9CjzRUX8Nxnk8f6h32bbNXRGMYglgDsdnzjAUifIFNAMN2LvYrWra2ZKSGjbCldl13fjMgZDP+maiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(18002099003)(261102123227099003)(261021123027099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(261021121427099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FMvpAUh68KZBbWb/frD06cw1+/YgqS0/IsQpCtTSp2vsYod1WUo97QF/gC1gt74EuhWoWgnHjr84HgG9PPogsJ+oOxFuF6wAYfnXaFJd6CNmQUdWcfdIK82x6Dsv6RQuSWDn9VG9KjOVs1G6qsg2sHcmSHh7Q5D6hQP+TX3uClmkHOi6TNEUx3zDjWdFGHDLvlAmSQ1mpmk1PiQRoRh+8T+NWDRytQVUpQsogjDJjSir3knZQYDf/vpJFzR5XnusWlSz9mvL/KCSFYerFTKTS3yXaasv1p6votFVfFmjopaNtMpB3A97hymZhFH75EbDrqOJaQEotEuZcn7a3/2FsQ/UhMsfNYaE00kYvlywsF0D+mIHJb9Mgt0AmfGaW/775MKe+srzOdLnD9AusdxmnNmwrPfErN19GGvv56Eh6yF4jkI1ZfcDzhfkZhl8kcUh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:33:48.1892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4189b4d8-361f-44d4-6881-08df39852e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014674.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dbgext work is only initialized when the debug extension starts,
but stopping it cancels the work unconditionally, and every MES suspend
stops it. With the extension off, which is the default, each GPU reset,
suspend or disable through debugfs then cancels a work without a
function:

  WARNING: kernel/workqueue.c:4335 at __flush_work+0xa6d/0xd10, CPU#1: kworker/u64:4/406
  Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]
   cancel_work_sync+0x8d/0xa0
   amdgpu_mes_dbgext_stop_locked+0x197/0x420 [amdgpu]
   amdgpu_mes_dbgext_stop+0x2d/0x40 [amdgpu]
   mes_v12_0_suspend+0x35/0x50 [amdgpu]
   amdgpu_device_pre_asic_reset+0x403/0x8d0 [amdgpu]

Initialize the work once in amdgpu_mes_init(). On navi48 three GPU
resets through amdgpu_gpu_recover and the mes-dbgext-wakes-gpu IGT no
longer warn, and resets with the extension enabled still work.

Fixes: 9dc106cb56d7 ("drm/amdgpu: add mes_dbgext core support")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0409325017a2..2da4bb1994c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -109,6 +109,7 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,
 }
 
 static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work);
+static void amdgpu_mes_dbgext_work_fn(struct work_struct *work);
 
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
@@ -129,6 +130,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	mutex_init(&adev->mes.dbgext_lock);
 	mutex_init(&adev->mes.dbgext_drain_lock);
 	spin_lock_init(&adev->mes.dbgext_notify_lock);
+	/* stopping the debug extension cancels it, even if it never started */
+	INIT_WORK(&adev->mes.dbgext_work, amdgpu_mes_dbgext_work_fn);
 
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++)
 		spin_lock_init(&adev->mes.ring_lock[i]);
@@ -1765,7 +1768,6 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 			return r;
 		}
 		mes->dbgext_log_size = size;
-		INIT_WORK(&mes->dbgext_work, amdgpu_mes_dbgext_work_fn);
 	} else {
 		/*
 		 * Resume: the log buffer is kept allocated across a suspend/
-- 
2.50.1

