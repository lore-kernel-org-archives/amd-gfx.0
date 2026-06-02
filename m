Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D86CD5BD1
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 14:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1EF410F207;
	Tue,  2 Jun 2026 14:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ibAjefLS";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0549210F207
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 14:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tq12SEfrskksVs2d3vPlNcBGI0SxJLMswgGxq9V/vzVYXtKKavXaanXv1llz7cnucC3NIFyCLyUFkKXujsdh4WtbhbA68StcweBqxoJLOB7thZ4XMAzdVo4dFPUiK2H3zCSsHvH1GfDcMgU455rGVv9JhqLKuoSf5WAioWL5B5ALpxW2/BWsJomrXkQ7xF7E5nQ2WmRThNrox/flSPMH5QLuU5xKjJ/I/7va/taiGFUjP8DqbIMbmpEtq55mRtKewPxcJP27Dhuohc9nN1Rz0FdH2Dnv9MBeNyJZFmxpdaRyXhkvPZYzuW5y0fwxSRjikbV3/qogvhBXaP74kKp2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQHXCcouAPhWL9UpmmttqzM0YA+9jxJ4izPBJZQKlb8=;
 b=KrZwDVQCwquewaQ8P6ErQDocyn2fh7+k7VHx1wABMfZwG469bpifkiguG7zdgDcN6WDwBIp+cVSMDbGZzhiXxj0zKYTSjP1D63e7LEI9qZnvGXiMLH8Ogea1Lrm54Mony665uoXhGBEh2YL6B8lBzEiLFHm4fEfQ1migz1PLJRZhLRZdz2wQqx1bkesjWexJ26Pdy90At9mRGGOJVnTz+eWBbLtgZxqGnYnI0eiNobD3lVAJHfZbF9tqLQ8O5Avaeyu8cd0PIdPonm0rcisaHeVCDqiJR98s/7eaBqR9kTlstyq9dUPYwe/a2dzu6VxIhzQvS/VIt/BupSLqDlDoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQHXCcouAPhWL9UpmmttqzM0YA+9jxJ4izPBJZQKlb8=;
 b=ibAjefLSLpw/IrJJF+jJ446OYFjpz8Y/Whrg7uiFDAP0hWSQmnP1m4dgXzOrrFD4IC9KpJPj30ne2soHraDtQhaYWmuSIBxMOsW8dkv38jiUw2uArIPy0XxwjcA2mDteO/jaXNAqPq6UgU0plCY+dQlwGWzZsB0F6RNRBtb88YE=
Received: from SJ0PR13CA0185.namprd13.prod.outlook.com (2603:10b6:a03:2c3::10)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 14:14:36 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a6) by SJ0PR13CA0185.outlook.office365.com
 (2603:10b6:a03:2c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 14:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 14:14:35 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 2 Jun 2026 09:14:34 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: Unwind debug trap enable on copy_to_user failure
Date: Tue, 2 Jun 2026 10:14:22 -0400
Message-ID: <20260602141422.4982-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: f521bcbe-a5bc-4b3f-700a-08dec0b1468a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: b3U6ljJjkI8QBpwCjm6yx0xi8d4ZOxME2zgvOVKhDuTud/N3DykASWVs7twbtEz2OMQgyfPQM3lYif4tyNFYZt4sSeRHBPDIgaIzF+hGPvHnHil+tLlXx3mmWPHroyOpk9K0girMYe0KxX8tjhzr2oOWC6OrnER7g0akutXN+QxwoVmhy97uY0LwnmRUfBdAZVsmkHNwzJQfQgdLlcFC91++d79e2qXkLNjDX93nfRH1qD21NC6AyFGFlIpsr7SA8R0fAHThhq8oogGpD3FTfhcUdjAYsSXkpboV0ZYUWVGXsSo4zffFIO587yLDJJ4NxzpfHjWOwGBrwqoZHDDGj6CjRkO/ClsA/rr7dhxMaF1uWSxZyNg7gdET3ZNu41IIGSpIoPM9x9SsvVQtPmDbCWs3YL88D0vf81huqEpwcdclvJ2mES78eGxsKhvXOc6d8gWxi5vKHOeqnGjbmJAb/2L1Aiu0rjPqny13S9kFOx9ROcA7O9VrmQu5rZYCyR91Ph1r/2i9fm9uILyfmXlKl0WCsLjAtyBJu3icYbZ0NI0C4dTCW8EIW0XD2fejqfPuC87h7rcZf1Tmrq9XDqt0pbZcq6C94xBZiQfg6GD66tElfmdwISYoyDVfxVxHuOPVVGmBMzGGM6Zv3+f2fnaSD9p8xYaVD9BAl9oPbyUecTL3/CCdS/rPmtOpUT8kvRNRPHixTB+jex0lscBpxcxz/J7csD85IAb94Iy7V1rakKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 57YnP66LKM5aREdmEf9MOEmRdhMTCEFMNzVfOq7aDh+QPZZv/SvaEwdr5AnaTCHw4rpMgYBXK4UW8jP/0XfO4YR8pP3XIxy/1EZ2WWu/4r9LpVJmch6HL8DEXYxRz3NUPOWhNGTu9nMc0CtpaYpb3FNtCb2NsEknzi9twGr/4g9U+s5HJSjIy19betxFEY9nJFDwdNy/3qZye3QUi1faC6YBZQUeo8ZNwNZkI+w164CMkmLIp4pKSNwWLWiDpprayQJpG6wyxMpZtVA7j7+QgYgYXE3Ok2NXIKI2VwFBOSfQna5HQiW4G+X1jQ33eTQkdcvaauJohJjPSz8XEov7J0ddSSJ4phUbZnb4s0tyIKkYQGm4W8S2dYChOGotjIli6cM7IsPK1+BZSlbYy58wZIIxDhXr57yt0V4XNCfGsWCwKJgvlxBqI4FHweFbdyKW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:14:35.7074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f521bcbe-a5bc-4b3f-700a-08dec0b1468a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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

If kfd_dbg_trap_enable() fails while copying runtime_info to userspace,
it had already activated the trap, set debug_trap_enabled, taken an extra
process reference, and opened the debug event file. Return -EFAULT without
unwinding that state, leaving inconsistent trap state and a refcount
imbalance that could break later DISABLE/ENABLE.

On copy_to_user failure, deactivate the trap and undo the rest of the
enable setup before returning.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 0f7aa51b629e..0dd1fd448059 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -832,6 +832,12 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 
 	if (copy_to_user(runtime_info, (void *)&target->runtime_info, copy_size)) {
 		kfd_dbg_trap_deactivate(target, false, 0);
+		fput(target->dbg_ev_file);
+		target->dbg_ev_file = NULL;
+		if (target->debugger_process)
+			atomic_dec(&target->debugger_process->debugged_process_count);
+		target->debug_trap_enabled = false;
+		kfd_unref_process(target);
 		r = -EFAULT;
 	}
 
-- 
2.43.0

