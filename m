Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A9DCD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 18:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7197110E20B;
	Mon, 11 May 2026 18:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OBU+GnoJ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013064.outbound.protection.outlook.com
 [40.93.196.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF6010E20B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 18:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/p9Sz8bN2RFws85hG5ZULTmYt4SvBOcZq6w2JZhiwG9iJyeEszf3R6qdA0/0GKdnXC6KlhB/vpozCrZDi+wajqzI7xJ1Ekb4KrL7ukuFbcy0kYS9YLvo4wzZPClSjylMTo2GMibtKYvruY1BIQlJ5ZKmZq3nQDYczkfYU+CjAowZgZGCESGTi/i/tvop8nw3lQ4sKN4zo8sT+fXMk/KLMeb+Vy13fiPwFc6E+OJqxbzBWDeOXieHR3vHbc5eQxRXbGRbw2OCPIS8tzzp5WGFMKkg8HHBpmZFlTo2DQJpBTVIYlubNGB+5bTkmtebHvPsG6lgJ0/WvwSTimV0f7WOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRS7Xo57OktoA+KsfGmvk9crL+AjlGvAc3Ywqc62HJg=;
 b=ufdD1Qzc+/ZbyDTSEusmPCkB+G+Aoo37O3E/t1fwvaYRXjwONaTGkmJqoZoRV6MlbQ74en0QpcMQG3FqEUZM/clb2xTJgGfDM5QVh+ffvR2ptw+MILhiJXWO1kBLX5A1JmAU1fOvwOurbiro5dQH5BrJNsxBCggJrBEvBVu5EqTOM6ihGfWEV4JWzmtiMH34H8hlQWfR8WEdIiTeEAclR6Aay4HjZmVI8631lpd1oqZbJgK+sks61RrRM11P1HfFdk3ubYcmpjxPYzY+vi9it/UdrYOyLunlGxesZFZJ1bClCrysVddh1zO8FdrzRsx/iyrNerH/PyGElJrprWx8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRS7Xo57OktoA+KsfGmvk9crL+AjlGvAc3Ywqc62HJg=;
 b=OBU+GnoJ0b+Lwim9aVLPvXXEy4q2vvj/8JkAcd+NofsbopHN9jQV5bk+L1nksqWtFgovYgsAcwCxOD0lvhKjTvNmH0diMAhArdADLU3zQaC1H6jhrxyzrYSK70XP4HW2i8CLew1yYNyu1fwCiszbmnu74O3NWaT1Osmdrjg5lTg=
Received: from MN2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:208:23e::12)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Mon, 11 May 2026 18:19:01 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::5d) by MN2PR14CA0007.outlook.office365.com
 (2603:10b6:208:23e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 18:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 18:19:01 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 13:19:00 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <yipeng.chai@amd.com>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <alexander.deucher@amd.com>, <chenglei.xie@amd.com>, <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Fix TOCTOU on UniRAS  command response size
Date: Mon, 11 May 2026 14:18:54 -0400
Message-ID: <20260511181854.37706-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 7247c9bd-683c-4d94-bb98-08deaf89c699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|3023799003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: r9glYNADp2qOx6JYo8jQcRZva9oJJEGhuKLri/6/aaMoPnGJGW/d8g4kzAfEPQYExpeNc/Vu8PwpNc2yUIinMF5/+ibh3nvvgoJ1ZplqYblhXTiNJFfnBZ48RcyWpnCJwWTwqPzbHhmYhHWTyrkyG1bNRKuYJJVSJNbtjDTQ/CxzFmPj0n/enjmloRgChb+NuxUw6vUGphQquA9TL6ALUfrrPdLxijDGfBvWcrjJUdI7LP3Y0qSbZI1SgA3gZL2Fj5SafJCYqxrCsUxk8GH4hAgZ17RD8b5pZBecJgf2mRq+DjQACNKBco5PqxvrqQyKFQ73/pJFA9jb14rxtS1rFRWYDojnCWg3X8zae2Ha5KXE0yKaYWF6SfzsE0dyI0V/fHvtDDb/dsGrarlPe7wcYlLLMnwlsHxPBcoxTdFYXsTqClMmaxV1asCmtJs69d9H9nLORwQcXv8hzEAZHxivHQdozxLlXapIyAOmCkkdQUlf9Ga3p+UveCSqlhvZui1SSX8Q5Dn7mlWxIFpSl+7sSC3vb+RYRPa9VrQ97qvHJQPl31VwrHCCCkrp2e60XBfsMGLrty39Q3J7L7cngy4WLqp9fRhydaxpT31dStWZyXULM91ONROfQ/Y9pz6hf0Fsae3jZwf5fbKgCGyN5pmy7xkrvc8VyZG3Io32r8yj7QH2E+WAA1tgweNlM1LyWpaBFUzqmJkNah54gabrNLAVF11Nwh8yArkggosTkIG6jAw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(3023799003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Q/RFkX80q6e5eGknuivgR1Wy9B/NPiMXQ9FRznGx4gzzAjnE/bl0VevK+zpy8fwh0miDO3t7T1aztzd6G76GK7i39p9WdoA3i4nF3zKGOhVthsyMYPq356GzYCVSbkTWHZDlVP7J39QbDJtfhvmEAY9YE5uIk3abMB1RUydmJ9plGNBkROtD4nNgWnGp5Fn1rEfKnh/r3YugB+mrhz4H/KzsH5BByg73P764jkkX+920vx7vUqscS+x8BqIIfwYZS/NEYL9bfuos5A5CYKgGaxyXos7tx0GCQBN4KPjMQGEqwb5g4gWO2PSygx1N41Ntb3Ex6HHTm7f3LhjLigNKh9uS6jS2nhxJOVozMk8MobzgenZLAE7/+5ExIRjpsFPQXpKDOrDL6m1uHmspOiHRhElaUxEK+yOKvxA/aOXHWt023Qc/h+xNiEhrgv1o/f1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 18:19:01.0080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7247c9bd-683c-4d94-bb98-08deaf89c699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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

The guest maps the PF response in shared VRAM (struct ras_cmd_ctx in the
command buffer). After amdgpu_virt_send_remote_ras_cmd() returns, the code
validated rcmd->output_size against the caller buffer, then copied
rcmd->output_buff_raw using rcmd->output_size again. A malicious PF could
change output_size between those reads so the memcpy length exceeds the
caller’s output_size and overflows guest stack or heap buffers.

Snapshot output_size with READ_ONCE() once, assign cmd->output_size from
that value, and use the same snapshot for the bounds check and memcpy.
Also read cmd_res once with READ_ONCE() so the error branch and
cmd->cmd_res assignment do not observe different values from shared memory.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I815c5edc234a651a29657d126bf117be9364920a
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 838eb91aef391..4a10c19128fb1 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -108,15 +108,19 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
 	ret = amdgpu_virt_send_remote_ras_cmd(ras_core->dev,
 				shared_mem.gpa, mem_len);
 	if (!ret) {
-		if (rcmd->cmd_res) {
-			ret = rcmd->cmd_res;
+		uint32_t cmd_res = READ_ONCE(rcmd->cmd_res);
+		uint32_t osz;
+
+		if (cmd_res) {
+			ret = cmd_res;
 			goto out;
 		}
 
-		cmd->cmd_res = rcmd->cmd_res;
-		cmd->output_size = rcmd->output_size;
-		if (rcmd->output_size && (rcmd->output_size <= output_size) && output_data)
-			memcpy(output_data, rcmd->output_buff_raw, rcmd->output_size);
+		osz = READ_ONCE(rcmd->output_size);
+		cmd->cmd_res = cmd_res;
+		cmd->output_size = osz;
+		if (osz && osz <= output_size && output_data)
+			memcpy(output_data, rcmd->output_buff_raw, osz);
 	}
 
 out:
-- 
2.34.1

