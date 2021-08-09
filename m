Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C83DC4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 09:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198F26023D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 09:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 198F26023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEEE8894DC;
	Mon,  9 Aug 2021 09:37:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6486894E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 09:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5I/YtJddi2XdIPC1osRfNtK6qL5GHVj+RkVleP7YrgLwkJoQU9B52WXc6cLP5T1Ces8OTdwzmVeSzaAjt7GC8D87TgN8TmlP3hKZzw7loneB2rOjOY8ZlHYNBLyY4KmHnTXL00h1nd4LDlimWgYHQdBEroCYVNmMNMJ+LJhPSj5JG5B7YGXuBP6DEkHmmfFM8R/L3gFycTP+MVjF+698d+NljltyvUBH8HxprbmJQrNq7ZS58VvkNtYfXsunOpqqswT5A0qCPhdSP+Ee80VFtDBANiebKgUpqCk9L4tib++7gnbICBAjH2mCuXUYBbq6FkjVl4nUxLZU8VmfoTHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ChDOMX0p/Q3MDKMSlIXF5vmJZCoKVllRPiduhtniKY=;
 b=Ciq9j7PDQRJNO8dALO77VEy6338J0Ec/EzWzezLFI3gczSOHmfPqE6D1RqkR9F8wAZqOBaUqEtPLL6a6PEy14ZDl1bjF/VOrYQ8WhWm/lwwOHdD07qTzYuoAo+FsgxMLM0+F5rng0o2vNzFwuQPTWREgOKzsMtwJW9quplc4PbJMXoDUFlarFpYRbjvcYzTuS20C6uQW5iWuOCvyGmHklGosDNYDUNgBlNcrWC/ZRHkBT9b7AAnOELUD8GoBoG0ip2FaXetOzn5dpt9OmGBO25AFToVCX588ZfB7Wr3eSV2jqMtKJP13ZZqbF5T3EXeoopDAJuKrAnDgr8izZUGknQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ChDOMX0p/Q3MDKMSlIXF5vmJZCoKVllRPiduhtniKY=;
 b=vCBBZ2ia7PhEyyCCAx43/L6kiRjuUMK5GkoIyUOrbdxXLJ9rNZ6ogViZ2jDrBMGgG2lVUti3VuERQY6t2UjnhWfm8kIhcJu5/zMRRcl8HCKpSAF+RbEow7iqDUm8fNJo0k4EN4FhAwmtFPMJa6imzsLJPAdidb/u3dZSxbKuzfk=
Received: from MWHPR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:301:4a::20) by MWHPR12MB1262.namprd12.prod.outlook.com
 (2603:10b6:300:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Mon, 9 Aug
 2021 09:37:01 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::c7) by MWHPR1201CA0010.outlook.office365.com
 (2603:10b6:301:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Mon, 9 Aug 2021 09:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 09:37:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 9 Aug
 2021 04:37:00 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12 via Frontend
 Transport; Mon, 9 Aug 2021 04:36:59 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiange Zhao <Jiange.Zhao@amd.com>, Peng Ju Zhou <PengJu.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Add MB_REQ_MSG_READY_TO_RESET response when VF
 get FLR notification.
Date: Mon, 9 Aug 2021 17:36:44 +0800
Message-ID: <20210809093644.5952-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fcc1147-c58e-4dc5-a563-08d95b193dc3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1262:
X-Microsoft-Antispam-PRVS: <MWHPR12MB12629A8A8DA46FD1F6E43D2BF8F69@MWHPR12MB1262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnNKhzJt3+IOGxYusG8swapnFEUbe/B0F4wPnjeSXejhjFaF0AbQ6fJOz+UNML+/0p3JzwLQ5mqBYl71hOShP+qBpCITo4CS5+YdFg6PwFR1/dzoK4+dkRdyByzMcmYACESE+sRXqHZdE7n5zY8z4D4wBZaIKVjoIf7xeakQ+wK331Fpx7ntOwCgb7r9IAK2WtWoHQhiU+IQ2U6fnccKvRieY1OzdG+QlyZHrXUMF0Fp3YtJHQBeO8rbfnnCAlcOp6B6HHubTjbrTPsYMDAEjQ/d4n1u4NxzxZStB4/cVpR/F3OAU1O8o4sBpQJamnU4L91rsqlRXc+6fs1Talt+z4qQp3upBzcoua8koN4SUH1N/7HCIai9ZUZTM0CcDKzFhCbPOfN8HiGFHf0XDBFnRVOmk7SkpKWd6BKx6zUxCFmVpafTCEa314TAitY73HScZSnhNhdSkoyek6AjmhLtOpvEqFodPyR9llGO2w2cZvDlPcqk2rsUsYlvKbpevxBRyBnS5ErR1JewINKg1YvRIr83fyIMGDI9VFJi21HlEPy3MWV2U0OsFpWGOFHuFRFH3Z7/rEWWMEliDXRnXcanSOnw5CggKgaowplhfqtxIBQkGv6YII1nAaRL6/nrIqsHLSOxVN7FESM5NS2x42G4kS6HU01U7PyBDmmxYsr/xm4wSgljhvxK5bHtNUAdO1zzDRks4dN89PPq0eOMEJmBx15uTtDBtjX7W+wz8+/qO0bt65xXadeghDf3SAt90zC0eel6qkOeaeQmjBu8ERnmiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(5660300002)(82310400003)(8676002)(8936002)(15650500001)(81166007)(4326008)(36860700001)(34020700004)(26005)(1076003)(86362001)(6666004)(70586007)(70206006)(82740400003)(2906002)(7696005)(356005)(186003)(6916009)(316002)(83380400001)(2616005)(426003)(478600001)(47076005)(54906003)(336012)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 09:37:01.6548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcc1147-c58e-4dc5-a563-08d95b193dc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
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

From: Jiange Zhao <Jiange.Zhao@amd.com>

When guest received FLR notification from host, it would
lock adapter into reset state. There will be no more
job submission and hardware access after that.

Then it should send a response to host that it has prepared
for host reset.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index b48e68f46a5c..a35e6d87e537 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -287,6 +287,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	amdgpu_virt_fini_data_exchange(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
 
+	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
+
 	do {
 		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
 			goto flr_done;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 9f5808616174..73887b0aa1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -37,7 +37,8 @@ enum idh_request {
 	IDH_REQ_GPU_RESET_ACCESS,
 	IDH_REQ_GPU_INIT_DATA,
 
-	IDH_LOG_VF_ERROR       = 200,
+	IDH_LOG_VF_ERROR	= 200,
+	IDH_READY_TO_RESET 	= 201,
 };
 
 enum idh_event {
-- 
2.17.1

