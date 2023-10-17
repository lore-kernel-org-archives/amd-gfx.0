Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE582CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 14:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD7210E2FE;
	Tue, 17 Oct 2023 14:36:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B5710E2FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 14:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVqR4rNYDuFzF2E6EKWH682eMwk7Gh/xVG+DsVklTga7b3Wk54rkIsDaAubA6igJGnLLqrzmIplMG6uCakv9HZz7nDmgOnQemJvnipykqrhX0MoFN186PeQm2jF2E+OvOg3B/JFVFh+tcPBZ9u2uPZWdFesswwPKPJo0C3tZdwe5D0DHJFe+SlvYD4epFi/eUhmrocKzlovOsSFrItyISY9DklsnbNfyujuj3MfdUssk9N2kHWlOY8D+s4/f7cpp9szTHVhyI0ST1aAuL7b7tJygXuxd9CKeBdEf3YUcdzUkM2mFVM+4+F536R1Uc850o3J7ubEHU8N0Yld/w4Rhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6ov0d38xunc6XH0/+hQZR8UhsjYkrR+Alfn1MkiPp8=;
 b=B0B02ZmqJjii4PmnjwIASV4+I49+AVwnSOiAHiKWEJsLOCl4R78dNiSM6pTiPtav7jLWJekWpBqU6qg+cda67tME4jNGQ0o2QzKzhp11By6WMyJE2lzfnOAdQobl5d0eVS8eEQ9o1XA4HF4AlnC4ThI+xVa3o4E+A+7KPrdd1AUT/5f3AblsrOzdSOr98gXYmpS2J0zBsdqkFlYr3vJoIIUmOXNd4JTRdEYL5tUMKT273f0TDRar24jTA3+RPLOtSKpQ6dGaMJeXVDG8QFrTLyc1eEFCUHCwlxhUITBhjnPQVhc6ITe7s7wOWnihwznYBjWR1NoxSC5eM9YCc9P95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6ov0d38xunc6XH0/+hQZR8UhsjYkrR+Alfn1MkiPp8=;
 b=X1Fv814q9z0EpO19jH5Gi6aOUuRwgqcD19jNLXnY5WpYMD0sVXYxI1CGvSbPvZMg8nMH5GpiEk+ixDTJMgKTLq57SLENEveGTbLq9YLL6EqrganMHqFpHYLaYUquRdQ8qQvj+Dtgags8ZyViJh0o48TkTZNsPYxj9OYdZETAMDY=
Received: from MN2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:23a::22)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 14:36:41 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::14) by MN2PR03CA0017.outlook.office365.com
 (2603:10b6:208:23a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 14:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 14:36:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 09:36:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 09:36:40 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 09:36:39 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test
 during ras gpu recovery
Date: Tue, 17 Oct 2023 22:36:38 +0800
Message-ID: <20231017143638.3203961-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c6eb1b-4cb5-4ae3-e780-08dbcf1e7a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81khoN6gnwu1on0dA1XlFcdXTRyhQcfK6miuTPuDheGOAAEO94ttE/odg07EBc9Hi5LkZJf19P2tqj96BfFigFzaTQEfPH3EPW9QZEtwGLti4hEIwv4UuE8/b6gZdrjkuhy8YmWacQgmMVyA9KNfLe1+Kh6OUPmrgZXJ9H/67sN1/HII+CImehDwFlZji6GSXLFGQF2CXovmugqb3XWy/wLgtjQ2IcSKIc9fyUwP6ZmIs4124WogqJAFaG633+9Zws6qL/MnMXx6dnR5RLffcUG/hAhl5WOoOUlWHXpTqxHO3UrZplw09NkvFayWPwQSB/k3BT1jzqWJ7DgoZrAYkHp0Eq8bpYDL/0mVRAVMLo0WaR9FmjaYGPKFyFfLK5mFbGpoUTzTXwKZBrsugAkpYpaMGbb2bd9cDmD/7XghFbk11Zf7rwnPpJ3NrYaku+TA/dM76Ufq900ozgDIsMrnMvh7RvZvNqAqoUjvefjIhbhBoCTV6LwwEs2j0+uikexJx03PCR4GwpwtBM80CF7LdA/0ek8i0AAX+mStzM+cy7ojbD4nrgB6Q3tT94Y7PeN+c3StFqCMjLzbyMvOT7wqVObllCYX2IeVLobq8ja4hsk60CidJ5qc2i1++6flGTp5+hcthOMD3eROuB9k+atKG5rv/f8lczAQhBCuLyKbf3AhPPIt9mftchQZ1b+rPb8iE+xMqNRtIxI27zPZXuxGiRVbJ9uvTg2pIL+93kFZNbyZADMPysAcxRmPN6Pp9U3nWikShpSVh69Ml9gXtV5e4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(26005)(2616005)(426003)(1076003)(336012)(7696005)(47076005)(36860700001)(83380400001)(41300700001)(2906002)(8676002)(8936002)(4326008)(478600001)(5660300002)(70206006)(70586007)(6916009)(316002)(81166007)(356005)(40480700001)(36756003)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:36:41.3194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c6eb1b-4cb5-4ae3-e780-08dbcf1e7a74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is workaround, kiq ring test failed in suspend stage when do ras
recovery for gfx v9_4_3.

Change-Id: I8de9900aa76706f59bc029d4e9e8438c6e1db8e0
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9a158018ae16..902e60203809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -29,6 +29,7 @@
 #include "amdgpu_rlc.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_xgmi.h"
 
 /* delay 0.1 second to enable gfx off feature */
 #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
@@ -501,6 +502,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	struct amdgpu_hive_info *hive;
+	struct amdgpu_ras *ras;
+	int hive_ras_recovery;
 	int i, r = 0;
 	int j;
 
@@ -521,6 +525,23 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 					   RESET_QUEUES, 0, 0);
 	}
 
+	/**
+	 * This is workaround: only skip kiq_ring test
+	 * during ras recovery in suspend stage for gfx v9_4_3
+	 */
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		hive_ras_recovery = atomic_read(&hive->ras_recovery);
+		amdgpu_put_xgmi_hive(hive);
+	}
+
+	ras = amdgpu_ras_get_context(adev);
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) &&
+		ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery)) {
+		spin_unlock(&kiq->ring_lock);
+		return 0;
+	}
+
 	if (kiq_ring->sched.ready && !adev->job_hang)
 		r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
-- 
2.25.1

