Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72932C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06D564E16
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06D564E16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6906EC32;
	Fri, 29 Jan 2021 21:28:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53CE6EC32
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvKh8wlY1eE9V7mwUhNN7vYyjb+F0fCDu0bF2pN+Nqm86S/HFfqz2aZ3F+9ceF3zyHsUp9TuSwqzbtiLXUKB60qzxRpRzWVFTQ1JgByIiojjtHkrQamLOLiSiafZDrff2MNotZURpcENYwP7Y1dfIixbm0fpTRr4LJ+RgSAEM3IRqpVDO3sOhYRhqr1PUx2ay2Bpb8go6/K2zs74UOKMZXjngOOvcKrGP55pDe406Fs72c+klbgkBxRaxn1mUGqCKPOCjeTZyK90wR3ACaYNilLgtPiSvvrSX2JqQNwJapbw3kpUnPCzpLvngXDJPTwQH1bpBXi8LTlzFuXaTvd7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOHqpPtRwvoOt1zNS11w7CyJ4POn6Yltd6k1Lcj32Ro=;
 b=VIyJZyxVPbzz5jBQCoTYw2fBeHglLGvKLkTGUDkvQkAEfUzsP4yS/51Qr4qjqYxbOpZA48nQwXwYGhv3PL5bj4Xw5ZUOs1NwreWUiVitdrrAU9AMV+vzwcmSiNDrQmAhVych0g78+0YJEw2rV35pGYciQ/3i4FS74tOGFnVzihlmTgmBp4yXnk6aL1rlNM03P6KkzJNaqpVe5HTkodlY+cJQ+J0pIIyJ31es2fMTtDVJWquxWQ6NsmTp5Yv7zK1cWmDe4/aw2rjEkm0if8MwAIsKC7csHfLDZEHGcnQe3IPqvsXDzVvB3dgpkd0wpTB8FfQ564GR4F6QSjXkord82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOHqpPtRwvoOt1zNS11w7CyJ4POn6Yltd6k1Lcj32Ro=;
 b=e8NQdV83gvLB+yV+9MI5nrk840obM6Jt96B9Q5zGn/5+Cs5PqEonWLp9kqacbWFmdZnQJ7JXZzeQrnb6dQCuxkGTdF8GRwWt92DP70hiGjhdb7qxSAVrZXM8PpF562VkL2NibMzATwxTdyv66YWZ7PzkmKJInDb1FoLjCA34H6M=
Received: from BN9PR03CA0473.namprd03.prod.outlook.com (2603:10b6:408:139::28)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 21:28:35 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::67) by BN9PR03CA0473.outlook.office365.com
 (2603:10b6:408:139::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:34 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:21 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:20 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/27] drm/amd/display: Enable "trigger_hotplug" debugfs on
 all outputs
Date: Fri, 29 Jan 2021 16:27:43 -0500
Message-ID: <20210129212752.38865-19-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94825d1e-e6a4-4da8-33ea-08d8c49cd50a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4418:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4418C0C9BDC257CE2E334F2CEBB99@DM6PR12MB4418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRiHUzRPJt6DzAwOzXocT7QwjpWEVWcwifQmAVXtZkFP9ai3pjAPFDKnRy1qEJFuLOqHmX46e+Rcebfh4EFrFtpX7GUGB2l1LRHy1p0MqDV6i+hvuUn/QkWRJsQ6AVIdnaOoljj/ZJdgdSccQ+NF4TnlFibyXuwdGLNfA1TzlkMjU4RsQD7gnJaQeAJlc9eSA7nu1qfTthrwYHViaUR3RuBfls7D1Mw7jqV+sRCjle8/kcpqJHbCGCfAXMsUk5AdA114o8ADtS5+mUZuzkeCANgXoGkQ+X8qGe8njq1ejgqcNRLPMg3TiyzI2c4SpVT9rPWgjwpamRRjqp2c5GO/NGZvZ2HEVCVFMO3etRABDpL3xtSzD/16TQgXF69dLSvlWEQT+4oOkFVOE7bVw+d0rg9t1RAQT6o8XjvRYxlKDlUjULA8XvhJpbXcuT6Gzp2Gb3+mlziv3ysRkO2xt999oMczp6WziB/JIFFB0WH8MNTLS5kRoCiC9zXwmMRazcp87LJD28WR4066bW9ZQcMlJpZXChHeBVPxAzSrMubTBats8DAgtj9mZEpxE8ioV5jir9eDXKAyyl4LO+QJmeeWzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966006)(478600001)(26005)(8936002)(7696005)(8676002)(1076003)(2906002)(426003)(5660300002)(4326008)(6916009)(316002)(83380400001)(70206006)(70586007)(86362001)(82310400003)(82740400003)(356005)(6666004)(36756003)(47076005)(81166007)(2616005)(336012)(54906003)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:34.0633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94825d1e-e6a4-4da8-33ea-08d8c49cd50a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Per-connector debugfs entry "trigger_hotplug" is available on DP/eDP only.
New IGT tests need this entry to test other outputs.

[How]
Enable this debugfs entry on all types of connectors

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index d645f3e4610e..360952129b6d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1063,7 +1063,7 @@ static int dp_dsc_fec_support_show(struct seq_file *m, void *data)
  *	echo 0 > /sys/kernel/debug/dri/0/DP-X/trigger_hotplug
  *
  */
-static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
+static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 							size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
@@ -2214,9 +2214,9 @@ static const struct file_operations dp_dsc_slice_bpg_offset_debugfs_fops = {
 	.llseek = default_llseek
 };
 
-static const struct file_operations dp_trigger_hotplug_debugfs_fops = {
+static const struct file_operations trigger_hotplug_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.write = dp_trigger_hotplug,
+	.write = trigger_hotplug,
 	.llseek = default_llseek
 };
 
@@ -2270,7 +2270,6 @@ static const struct {
 	const struct file_operations *fops;
 } dp_debugfs_entries[] = {
 		{"link_settings", &dp_link_settings_debugfs_fops},
-		{"trigger_hotplug", &dp_trigger_hotplug_debugfs_fops},
 		{"phy_settings", &dp_phy_settings_debugfs_fop},
 		{"test_pattern", &dp_phy_test_pattern_fops},
 #ifdef CONFIG_DRM_AMD_DC_HDCP
@@ -2367,6 +2366,9 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	debugfs_create_file("output_bpc", 0644, dir, connector,
 			    &output_bpc_fops);
 
+	debugfs_create_file("trigger_hotplug", 0644, dir, connector,
+			    &trigger_hotplug_debugfs_fops);
+
 	connector->debugfs_dpcd_address = 0;
 	connector->debugfs_dpcd_size = 0;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
