Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB7C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A631C21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NlE6IKHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A631C21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F9A6E941;
	Thu, 10 Sep 2020 13:47:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871726E941
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMpmURBpJ0PIlKFwkuNfw48WxoDYeVUN/DsXIU2t7G8UFGIvnnjmQKcv/8UvaoW3lf6cQAWHOP+Ecrv34+75ErsNib/IxgBLuyTJ76D6KgeBTC0wPvZ/AflCdHNVKeVP2n7DUUp1ZX+6GGzA0R0ZAaKszOJQNDZG9o1ic8mmFnwtklP+5Zl8MYElK8Cv15F6ifXlnlhz4Xu7OkSCG4zNklCkY1ziSxonWmCjHBpbhAKlSic0TexjBRDDt+ubmiBHB7p5b8vObQ7tEUS0UZkTcOI0BIrWM6cUyxVUCjxv2xiopBe8hI13zPOuoEJj13zxGNv8n30xHrY/L8G4DG7LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gegOMNK+McJT5y4fAcAS0gNqBEd6tA+36LfPkKcQN+4=;
 b=Xtr7miZJyCH+R/4F2uVc55A9Q3OiB50Nekj2PhK8Ookjk4fT2J1HtdDBnDPIAgtbkgwjOrhB5Foh+8J3rPCjx4PXNtY1bUYvaWV0/n9XCqq677xJ5FjlkJLmh2XHcEXGuNmmn7+f7zV0ZgV3FAmiOzYULDktvBn0bkEs+dtc5utI+811s0n2/YKVmoJ5ULROcS5+PG9STSQR67wVUbYCTztekkxX9RpBOuPd0mL1vulALa3uO7Eiq9FUhWqaHojiSnMz+L/Z11O30KkyeOHAF4OKssZYAihiAA6yJR0lmyUi4hHh7BY1hrjFbVQibPBhbwDOYHWj0bRsS4K1xo96eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gegOMNK+McJT5y4fAcAS0gNqBEd6tA+36LfPkKcQN+4=;
 b=NlE6IKHN94Q3y5+GmmZzGs5dc/5O0df9+WDvBhbhwlK7lPRKq3i0kyE5d56kI1MIfS8qg5Uiu0A2+MRPt94PoRwxx34+Rhn85RrSXlKYB0JSuZZCcIvjEh+VidVIpTO3s6gA7i7BcZ6bMxb3Dv6kbM0BYCAzxAxyMofccRtxkwA=
Received: from BN6PR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:405:15::30) by BYAPR12MB2600.namprd12.prod.outlook.com
 (2603:10b6:a03:69::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Thu, 10 Sep
 2020 13:47:53 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::43) by BN6PR1701CA0020.outlook.office365.com
 (2603:10b6:405:15::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:52 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:52 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/42] drm/amd/display: Add trigger connector unplug
Date: Thu, 10 Sep 2020 09:47:08 -0400
Message-ID: <20200910134723.27410-28-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7fc5015-6138-4e3a-91c0-08d855901d6c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26002AABA7324B0FEDC64CBE8B270@BYAPR12MB2600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKZJkyzCAsI5xGnyQmFi3zNl7dEAiQ1QOG5DvOcc3KgWWknEMbyuWK7zepSW4AyRaG834vRpq5tVt9X6r2lyKGaSh/gtys5SCqiEpHBMrgGQyMGeqPKhKSstLqxappfbQ2EUDmR25lTI+2cP4BG37HZgyNp0CcGScBMplW5qXlUrEbmeyEaL1QLx75o8PDuPGYpJrU21UYRazAJP9wgxmU1cyo9GGy4K06CkvUOJb4K/wqTkuTzijkgY2JDwHpvrhtZqAsMEVyPWA+XZoVMPrPFFIsJiIwpVHOH4AHLniMnVnNXPV/v1YmuhyZohJnbOSrVV/khGZBtVMkiwQb3nh72Uj30PRhNGRRPXVaO6GO+xu6QNTof7T4YMTpPiwfvb4moRy3kd0od4F1Z3pQDh5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(82310400003)(70586007)(2616005)(1076003)(478600001)(44832011)(426003)(5660300002)(336012)(356005)(8676002)(6916009)(54906003)(70206006)(7696005)(2906002)(186003)(4326008)(86362001)(36756003)(82740400003)(26005)(6666004)(81166007)(83380400001)(316002)(47076004)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:52.9801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fc5015-6138-4e3a-91c0-08d855901d6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[why]
We need a virtual tool that would emulate a physical
connector unplug to usermode, while connector is
still physically plugged in.

[how]
Added a new option to debugfs entry "trigger_hotplug".
It emulates hotplug irq handling scenario by clearing
DC and DM connector states.
It can be triggered with the following command:

	echo 0 > /sys/kernel/debug/dri/0/DP-X/trigger_hotplug

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 31 +++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 5cf3ba3ec5da..7c7f937166dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1058,12 +1058,17 @@ static int dp_dsc_fec_support_show(struct seq_file *m, void *data)
  *
  *	echo 1 > /sys/kernel/debug/dri/0/DP-X/trigger_hotplug
  *
+ * This function can perform HPD unplug:
+ *
+ *	echo 0 > /sys/kernel/debug/dri/0/DP-X/trigger_hotplug
+ *
  */
 static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
 							size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct drm_connector *connector = &aconnector->base;
+	struct dc_link *link = NULL;
 	struct drm_device *dev = connector->dev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	char *wr_buf = NULL;
@@ -1114,11 +1119,33 @@ static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
 		drm_modeset_unlock_all(dev);
 
 		drm_kms_helper_hotplug_event(dev);
+	} else if (param[0] == 0) {
+		if (!aconnector->dc_link)
+			goto unlock;
 
-unlock:
-		mutex_unlock(&aconnector->hpd_lock);
+		link = aconnector->dc_link;
+
+		if (link->local_sink) {
+			dc_sink_release(link->local_sink);
+			link->local_sink = NULL;
+		}
+
+		link->dpcd_sink_count = 0;
+		link->type = dc_connection_none;
+		link->dongle_max_pix_clk = 0;
+
+		amdgpu_dm_update_connector_after_detect(aconnector);
+
+		drm_modeset_lock_all(dev);
+		dm_restore_drm_connector_state(dev, connector);
+		drm_modeset_unlock_all(dev);
+
+		drm_kms_helper_hotplug_event(dev);
 	}
 
+unlock:
+	mutex_unlock(&aconnector->hpd_lock);
+
 	kfree(wr_buf);
 	return size;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
