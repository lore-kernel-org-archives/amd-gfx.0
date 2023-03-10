Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA6CC6FA99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 06:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7AC10E95C;
	Fri, 10 Mar 2023 06:24:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD1910E95C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 06:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMbRn9PHCDWMsT1K9AkKCiTmrM3kj7O1K5Gr3M8Phhm+jLSjv0RwN3eqgczsNQwiTKzKuleEeJPtuXtof/03+4a3GknARZwaMCOzY6XpQlk2wkKj1/14jKC/qtL2JNIU15S25BQStGqQHf1tHSIbKSaFLyE5CTstc/uwnqzRQPlOVzlKTPDpWm2mEOK+abyTuC0/u/4HlhN9L6tHzgn1L3eX9ai5to1SYvU93n3dhqailO11L8/Lb8LUFa4aD0u7K3cI1bmbddsa9eQm2JbcBDOP6+PGrOusG3d/ZdShGFO78loRoX9hodrv+NRLSyj1LALot9ejO3cNafSlaNe+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYqLJEOFGhvn4bKYkbyTgD0OSM+3uAKOz5T0jYA8aEU=;
 b=Rr6pEn3GgqEBVpvwkI1boRtw6x/2EbZH5NGcDXDLDz1zV7iwl0M+zEJS7vLL/qB+3s4w9JYzk41+uhTRQYj8+bYU7Go9ceDRJqHGqoPhGljWvyFSrJ/0/AX9OwaH0tlUzceGa/gzTWZa1jcn+auKhnBQ+mg1pEs2Ht59q4KNX5oi0rHgAV5kgu5BJb/0g63jtLxDVaiiu4TDLZqcLMs+6UYMokyPGTDzKDiv6GOAHiyZFQiVrDgaphB+itY2xqoL+SRWB/HTiCZ0ATbQnOGc4NQMoCRpo2ZiHuXwkbeKteTbZHy5shAQ8EUv7tzObww7U/ZP0X6HZPuvm8rlE2xxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYqLJEOFGhvn4bKYkbyTgD0OSM+3uAKOz5T0jYA8aEU=;
 b=5Jqa6MQXjxlCOfSM27372Hp023FgOrG3VjJiBl0BbVQhV1PTK3GaOsRWPM72EdhHz640tGKV/tLlbe8zZxQqLj86K+RssODyc7UGNTSzywoxAonEmFZQS7ErIpLKCxv00YD86G5O/wR1d+21SmYiffD1Oqz1EdIUqzw798V+rZ4=
Received: from MW4PR04CA0153.namprd04.prod.outlook.com (2603:10b6:303:85::8)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 06:24:38 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::de) by MW4PR04CA0153.outlook.office365.com
 (2603:10b6:303:85::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 06:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.14 via Frontend Transport; Fri, 10 Mar 2023 06:24:38 +0000
Received: from llvm-tr1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 00:24:30 -0600
From: Shirish S <shirish.s@amd.com>
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] amd/display/debugfs: add sysfs entry to read PSR residency
 from firmware
Date: Fri, 10 Mar 2023 11:54:17 +0530
Message-ID: <20230310062417.15861-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0d1964-e631-4a51-e276-08db21302003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebUl6IETY8sf4q4rOLqNgbs8pGrTjDdnEPpA611S9JiRNwYWBNsdYa7iCz2b65vnB6Ep8nPN4iWdErSsHglFpUIqb18lI3fH+VUscmkZPhoJHbEdFvk1pcTo4nfGD+Z4naOWjYyPPHDMmCZ2XKM2K7cMliOUpSOkSK2vI3WS+f2biyNjeCLE0yIZ51jGMBm9PVAxKOlZVF+D8Ki7PK+eiakfTpR1NMLPmDJLYP3keTrvmeQ2dZCIeic4/bZ0zM1bwx+A9mIq+VB6TUnjzXySmKPtU0y/YZCEh7E5tYNxNuHjR0Q1uzB9TJy9RBAb0s4P81yoUxQdaw5JfaWZOVbsQosXHh7w0JUbO4+vL1deXLRPfoa+JFJENKkKCG5Wfajgg4CQdN3JNIDuHfc/NM4DIlciILnmAtobOB1b4EeZ8KgRnep9qQSHlow7sYOr9QqlTeSFESEjwOU+tVPgFKajgdaGz38lXcGk4i4JYccy8mQk7Nq5RKcEPuGBG1tA7TOOd/wYYSFzHXZiO2amwk/0MRPSM0rGwui5PFoW9tp7ffdRkIscdRPEWfNBvYeuDZCaT93xeIGMhXUedep50k5l65flflN9jxQ8c+ci3efTHVLMz8eERgSX0U3B1GDAHAdU35GogsiWSrznBNZr8PQ2grX0QsfybOIOpTyISfUOCUywr3O5duRMPYm1+f3F1FqAnAU6ZHcWy06JIeGl+nJcmCYD7x2aQCOdnOfDMO5VgdE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(316002)(110136005)(54906003)(6636002)(478600001)(7696005)(70206006)(2906002)(4326008)(70586007)(8676002)(5660300002)(8936002)(41300700001)(36860700001)(81166007)(40480700001)(82740400003)(86362001)(186003)(2616005)(356005)(16526019)(6666004)(1076003)(26005)(82310400005)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:24:38.0610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0d1964-e631-4a51-e276-08db21302003
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Currently there aren't any methods to determine PSR state residency.

[How]
create a sysfs entry for reading residency and internally hook it up
to existing functionality of reading PSR residency from firmware.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index abf7895d1608..6dfd4cb42949 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2793,6 +2793,22 @@ static int psr_get(void *data, u64 *val)
 	return 0;
 }
 
+/*
+ *  Read PSR state residency
+ */
+static int psr_read_residency(void *data, u64 *val)
+{
+	struct amdgpu_dm_connector *connector = data;
+	struct dc_link *link = connector->dc_link;
+	u32 residency;
+
+	dc_link_get_psr_residency(link, &residency);
+
+	*val = (u64)residency;
+
+	return 0;
+}
+
 /*
  * Set dmcub trace event IRQ enable or disable.
  * Usage to enable dmcub trace event IRQ: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
@@ -2828,6 +2844,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, dmcub_trace_event_state_g
 			 dmcub_trace_event_state_set, "%llu\n");
 
 DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, NULL, "%llu\n");
 
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
 DEFINE_SHOW_ATTRIBUTE(target_backlight);
@@ -2991,6 +3008,7 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
 		debugfs_create_file_unsafe("psr_capability", 0444, dir, connector, &psr_capability_fops);
 		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
+		debugfs_create_file_unsafe("psr_residency", 0444, dir, connector, &psr_residency_fops);
 		debugfs_create_file("amdgpu_current_backlight_pwm", 0444, dir, connector,
 				    &current_backlight_fops);
 		debugfs_create_file("amdgpu_target_backlight_pwm", 0444, dir, connector,
-- 
2.17.1

