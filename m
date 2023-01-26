Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B29C05027
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 14:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3723310E924;
	Thu, 26 Jan 2023 14:46:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993BB10E924
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 14:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAsPecfsm90v44cFNx+iSdkF+4Dn47V8UMZWI34ddtDg5STkKh4hgON7iOvyGTsKMcqahRJlQSUY3HlwqdUI6SS86iCgaBKrNmUp/7MYdZGzXvfiBq8hskRtVwgaCPW7pDzLn/rKLZPAz9VOJRa0726LRvmo4EtXH7YC2YS6UyIomMJcvq3HBlZVCqvHkZZoUXBGd0F6lFI74MZsuPIONkNWI56BdryewGeWQKqQQjXohJcawLBuZR+bVvWGpmgBFBUcdcXw9FnAXwGzKPKmCIIOLzGZaeUXxJILhKb0m0/3AgFZuVf+DwniIFNDFPjtO8U0KwfcdxrwUU43V36q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoWD3bNNhVsIhvYl2+eulYx5RlCEh7XoR8UDAzmiPCY=;
 b=MeLntDq+yh/siEI/P+PQ5FPW3xV3YGuwckzW/nzSZd4ee710xN9/grBawTOVFfHonigEmwwtKhrGSMW4KWBleC5sOEF7WGSIr07A2VjfYRs/F5hbwh1c+plNkzLWSZY7ecNBZVqO9OVP/0aKUw0sDH9E5C34KP4Bj6+J0qW+wYt6IICChDBqOyEQY31EAOGS+ha77RiVbx6R/0pxme1cGG8qsEAiU5I68LfHLAx1TK4HrBZPeGG0iC+K+R6dr47oiFlKbKVkzCJkQNZsGyqt06/CFgH2Csg7cOFxj5XvvAnYv2I/ly7yKgJCt4NaVVKvAN1cboPWVjkeQBtt6kDD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoWD3bNNhVsIhvYl2+eulYx5RlCEh7XoR8UDAzmiPCY=;
 b=VufgnoMLEveOQ4+p/LLojbbJ5IFjSkDryvjp2hqRwTZgK0YWS5Ex0Ms0on4lXbYeM7+3AM5llwouCJi4wVzOfx1JJj5MYr1PW0EDdebXcOA/4P8iDuwpnPjAyIO9T8dBX6yzNoEBD+8QwVtyvBy30OwBKm7lxUFk3qDqRiTSypg=
Received: from MW4PR03CA0039.namprd03.prod.outlook.com (2603:10b6:303:8e::14)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 14:46:42 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::51) by MW4PR03CA0039.outlook.office365.com
 (2603:10b6:303:8e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Thu, 26 Jan 2023 14:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 14:46:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 08:46:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 08:46:41 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 26 Jan 2023 08:46:41 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: always sending PSP messages LOAD_ASD and
 UNLOAD_TA
Date: Thu, 26 Jan 2023 09:46:32 -0500
Message-ID: <20230126144632.37532-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126144632.37532-1-vitaly.prosyak@amd.com>
References: <20230126144632.37532-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: db81a6f5-8549-4f73-d438-08daffac23df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18/GWtampN0+CYP4zlAr6Tg1V86wNs6K4giEWzj9rag+OEGk5DuP41B1F+4sUVGyDGCqsZgN4WbEOyoBBH2dIK2vARemT1s0A18ysH4peGGUoXf8+iy81rpvdrlX7w81I4HHKjX3gxDvIjqVEiHtG5LsyQeoupXwm9Yp6R4YNF+PAZX81YOmACLXaeT0+IDZBGDdnjYSL2YeM8joPwFFzoqMpHXU+ITCjgTrD2km/ZccBsbSxUq3rcIKtYA/ktyx5O8I/xWexGiYLQabBGgceAc3xN2pO5w+zB3C2cga7GwL1bk+oJ28os6M1/E5OixhEZNkaU16bztVC29+vaTf8xFNK6BcSlfUqSE1LC+b+SRgrBFgVIarHUpRRT+cDK0WLfVkyQQGJTFFtNyzQmidEewo8uFhtbpLXdpuVjkX5BMtg6sEVe/sqN2hEc+8xE9+5mJeAa0ImR9ot4K548Hbzqyrd9Lb5xoQaJU7/g2+LV87JHjGrEiHb2mouZ9QDJWflGOEBgvm1OWFnzYjn1cVt6vK1TrqLb5/Qx2F0faXECkNEzygqQKPHhRI9N7/P6c0KX5Jl+j7H63/KSlIjg6R0vqdrjNCl2L6dr16COQdGjIJ03jJFQa6fpG+zXfz8H60ekDZpMOB+rhVqexVsn39FeQiZ4ZRpot1NxW4nLgqw7QKugHoBBaxud6mJkuFhDSJ0rjMCtOZGbEniPBGVzUJI4az6nOPSENsQxJXBKrEsj4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(26005)(83380400001)(2876002)(81166007)(5660300002)(82740400003)(7696005)(41300700001)(2906002)(86362001)(15650500001)(82310400005)(8936002)(4326008)(40460700003)(40480700001)(356005)(6666004)(316002)(186003)(336012)(8676002)(47076005)(2616005)(478600001)(36756003)(110136005)(6636002)(70586007)(426003)(1076003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 14:46:42.6113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db81a6f5-8549-4f73-d438-08daffac23df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

We allow sending PSP messages LOAD_ASD and UNLOAD_TA without
acquiring a lock in drm_dev_enter during driver unload
because we must call drm_dev_unplug as the beginning
of unload driver sequence.
Added WARNING if other PSP messages are sent without a lock.
After this commit, the following commands would work
 -sudo modprobe -r amdgpu
 -sudo modprobe amdgpu

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a8391f269cd0..40929f34447c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -606,12 +606,21 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	int timeout = 20000;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
+	bool dev_entered;
 
 	if (psp->adev->no_hw_access)
 		return 0;
 
-	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
-		return 0;
+	dev_entered = drm_dev_enter(adev_to_drm(psp->adev), &idx);
+	/*
+	 * We allow sending PSP messages LOAD_ASD and UNLOAD_TA without acquiring
+	 * a lock in drm_dev_enter during driver unload because we must call
+	 * drm_dev_unplug as the beginning  of unload driver sequence . It is very
+	 * crucial that userspace can't access device instances anymore.
+	 */
+	if (!dev_entered)
+		WARN_ON(psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_LOAD_ASD &&
+			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA);
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
 
@@ -676,7 +685,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
 
 exit:
-	drm_dev_exit(idx);
+	if (dev_entered)
+		drm_dev_exit(idx);
 	return ret;
 }
 
-- 
2.25.1

