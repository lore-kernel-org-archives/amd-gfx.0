Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D436BCD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 21:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D5610E733;
	Mon, 15 Jun 2026 21:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jpp+Va24";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49B010E72C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 21:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+CadpHxsRryvS9gNO6NjoY/VIZ0/vXes877XW6Caipu4d3RaDVK1L851EZ5FZw994/f3cq2FV3Ewx/mtqvmJNlQ3OD7W3nTd15kR/EJ3qM1j0yQIXpdPQ+LNSciyJ+JgQ6rHrKaLM5gGJeZRQGse94JXGgySl9KoPldI9Wk/qzI/PWVTSuy9jufHGHZ9F77tZRQpiNVvBhA6ajFLD0Ntr1EUame1VwwqwjQtxaUFTrm/Qd1VdEahsmp63fDGFIyUgsbFQCBokmTD/vxU+CPbkjK0oZx4K1wrRyZl2hnEGydWPbx1wzuqjuXJSYjbEcuf5KqfkRWPtMXWZ9JWAPHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VcYjBSqpKgVSz+ETLqnvIM7tmj2hoQdgoitU8CkHzs=;
 b=ByFXLmgBQ5wOPAjR8MDtRXFZ7fKPc82+1U7r83VKYSEwX4VaCDYCI8t70fFnTskvZnJ8Zvnn8yUn0CNGEgl4TwqzsdmEIAp4noLaqAPiaKejP37EBF80kZSOK3k95SaYdHP/PpZ+mbtSJbv/8ceCoTxIFT/aOB8PEpiZ8//CfCBTBAopF7twpM7QlBYFEZ9Au82yIG1CO84uCis85CbSuBHDpwi0Cw8xVd+hKaRqOZMVn5QRCEz6f+9P07ehbV9PNn7fY4+tjUX+XzzYb8iI12QPI4AVh3Lc2hQUpcOA1Zwbdk3kHz7wQujHdqCQ9ajGWEv0Wp27zG0Kg1M1YXIz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VcYjBSqpKgVSz+ETLqnvIM7tmj2hoQdgoitU8CkHzs=;
 b=jpp+Va24UdT5fYg6snsfs/0ZgbExp0v9ACZPRbFbyE6NGF76iTy6YtGrraPzASwJdq/FjIfcOoE2682Xp5SRvnYsDr/1niTAZKhhl4GEBLyoPqycr2DNwk8F8njYSyXVsrHgDc02wEiDsCDaRWoDChFr5URhCigwiT02yHWJxuE=
Received: from SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 21:17:13 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::6) by SJ0PR03CA0113.outlook.office365.com
 (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 21:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 21:17:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:17:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:17:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 16:17:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kent.Russell@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/sdma4.4.2: add support for disabling kernel
 queues
Date: Mon, 15 Jun 2026 17:16:52 -0400
Message-ID: <20260615211654.676386-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615211654.676386-1-alexander.deucher@amd.com>
References: <20260615211654.676386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: b81fb01d-6a13-4bcd-6161-08decb237828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: UUTtZSb2l8ifrcWsaD5QI1E8RtFQh321gtAshSXu50BX1xJMYab9gsHjXBGKmj0UMV5YxjNmwEN5ri/hLiXltVQ0jbtG7r8Yax3XPqKuprPyJkmbka9sTSYsPn6/6gY93wFDy7pODK/4WIDEcQfyVgQ727dSCH70y2sMgl+ZeEa8V+mvCvGFWp7tLbmkJwtn/ZGvQ18KrWLwptUXaFKfEI5YuANQp/RaCxrpWTuhgqVuwHVMzvJ40u9AEMiy3JK/06RSqWHUO78FG848LXcq2dyczo6rG8nLavz8LY94Smx8QXnExcSjuw20LiB5ZdkBffbugJtl6X+tk8sh68KPj/rw0/OcksmCnN+U3rp4KIdOAnyc4k7fYbux1A5au5qxsOxpsyKCnlt0L4cunCUy6qHZYcZ6AwwpVTsuP4biPYkgWV3224AMFfTUm30Z2JvY0pq+Ivz2DjitXZ7/zZ6h7eQ7gi+0x1Fh/7DeEqcQeOoiHXHsoMO+qyW2vc15XDj+M8h+CniZ0M8TmrywADVXHTOQ0BK/c0AhyDKV575isHVH4lmGOLcyzEGIbNUyG2722B496HCIqqqgbejYtqUHt1/HRnwj73sZxhuz8+8cNtyYC0ir2FSdiguvFdx+cdyRbyoCW8V29srAo8BdcPPBwHbXXjOOejsr/Q67YjSQ5SFWhKHJUFG5TPiD+2MlaqGGUtogFaYqM6rbiRIV7hhO3oM5U7fXQ2tk3mroT3yQ7uw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uoO8Jn6mibt3uXPhpn8aPAzXOWtEr2X6O6cSYSEpOZAuaxZynCGzQyvZSmZtn8coxe0f1P19NSFcU3asKP8d3ukaOUhdgbW6v7wh49IzVqhXDDhu9mdXSWpqBsHj1B9mcEB/AVeij9IesPFYYh05IvWsV0wAf8fIRQiufJyNbOgAvoTYa6tHgWvrEf0dqX8utwGo3cEysPqhF4R3djloKMYuevd0lPzfGhhh856bnMslSTfwGsphkZSEMHaqMFaCpjIHxc7Pth2eUhYjc+vHiadVli5VtYdOQW5HoVC4GvC/p31jW3DlhsnBxBwlMDKKQgEYh4GLu+9+Qj9gDJJUSqhTrYM0TGMGI9wUb7JSYodKXMiKP7TAHyNstOuPSaQb3BP1JyAmR6jTEY7xEFeyElFmJJVIB/axiRvn39cdcqqOeIk2D8ml9/QKv0vQTav8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 21:17:13.2043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81fb01d-6a13-4bcd-6161-08decb237828
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
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

Allow the user to disable kernel queues.  This can be used
to free up vmid resources if kernel queues are not needed.

Set amdgpu.user_queue=2 to disable kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 88428b88e00fc..777a708528833 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1359,6 +1359,19 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	switch (amdgpu_user_queue) {
+	case -1:
+	case 0:
+	default:
+		adev->sdma.no_user_submission = false;
+		adev->sdma.disable_uq = true;
+		break;
+	case 2:
+		adev->sdma.no_user_submission = true;
+		adev->sdma.disable_uq = true;
+		break;
+	}
+
 	r = sdma_v4_4_2_init_microcode(adev);
 	if (r)
 		return r;
@@ -1478,6 +1491,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		/* doorbell size is 2 dwords, get DWORD offset */
 		ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
 		ring->vm_hub = AMDGPU_MMHUB0(aid_id);
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		sprintf(ring->name, "sdma%d.%d", aid_id,
 				i % adev->sdma.num_inst_per_aid);
-- 
2.54.0

