Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C11C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Mar 2022 00:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7B910E0A4;
	Sat, 26 Mar 2022 00:57:35 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4680710E0A4
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Mar 2022 00:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3XWdaX6GMVAf8HXslV5hwvncui65pKYC9W0qmcgkIAFrw6HsPPG83Coi2ik5/I8OgkAEOhFWYcW31zPMRI/N7Ci7jnmFBiH+70W09v5a0wTjjHnX4Qz62Q66KsGrWiODdCaC6x+OBg2D8ruDW/FzvVaaEvvJjKnuc+oqDXN5HfZyqTrOG6/nMhuTBitlRWuq2nqvN//AgWYZ0oClS5poHoGhAowoFfxm8SOU0dFCd4ZNHB0LDUM/tpvIOnPRxe0Lag0YVh1N0+VTD1bAmk4oJSihVq5G6xhOkKL91d23g3Nl4ZwpE6FwFKJ9lUFBWKObONQ6DQiCue5KwU2B1lZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7duohmn3ZKTGEeB0b7cjCuktApuq19KwWFuxLYflFaM=;
 b=gc5hu3yi0jIPHmgP7rXo925NUwz76OAEpZDJJm6q+tpVTkDl0mEXa52WfftDpbPAOPyemWCvzdQDM4PqP/pTqpFLiK+oiF2ipScJ1NBMfF/BHGAxcaqnZ+vTduwfUy9Zv6DtDK2M9fu6EXBWPJWG8XKlvN4T3S9Qek8XAn/KSSDZrutcVLzKkSYXrYWoqcTDv2xctCxMFPUFh+J+P5iUdRpkjghrwmMp9ZLSDPyo7ZUDcEpWolZVm7ymi9VFlF+r8SRF1XBu7GtikA6LwBfGVg38MT0OL8EMwT50p1vK+/wM5bqmrDqr0TFjGLzq3xrJd+ndsZN31sq34HJARvqbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7duohmn3ZKTGEeB0b7cjCuktApuq19KwWFuxLYflFaM=;
 b=GOiXt2IcHUaWPdM+V8Hy5FrqCoHGfh/UihFw5KamFqYLFGWSTiGJg8H98QLBVs6aVQS/rnPhtcugUdnyXtjWO6+Puk5Ql4O2HCfMWrBq1f3/0WPgo8R2UihBHcJ5rgwffw5ryyJAjrj5QCNNi/EYW3WflqfVEjR8X2gunKQTk6s=
Received: from DS7PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:3bb::26)
 by CY4PR12MB1271.namprd12.prod.outlook.com (2603:10b6:903:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sat, 26 Mar
 2022 00:57:31 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::bf) by DS7PR03CA0081.outlook.office365.com
 (2603:10b6:5:3bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Sat, 26 Mar 2022 00:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Sat, 26 Mar 2022 00:57:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 19:57:29 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Use last_unlocked fence for unlocked update
Date: Fri, 25 Mar 2022 20:56:41 -0400
Message-ID: <20220326005641.10284-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326005641.10284-1-Philip.Yang@amd.com>
References: <20220326005641.10284-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68c5c9ed-344e-4c89-a698-08da0ec39ac0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1271:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1271A7D04422157658854110E61B9@CY4PR12MB1271.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhRKlUszbiQH/UinK2gX45zkHJR9nX1/RD/i5wELKK2ZglF701/BXOZkxEpdalVoC2YqeOe5hfGOFS2YaiuoUtxRGvlhNUu87f8KztF2PjWw8ilPbwM00phtTLmaPTW1d7AeEXlK/h/y1G+X+MfQCFbaV0JWzx0UUI5xasE/hHuYEFSIhAlJcrmzV1JTFONqL/zekr073qPEhvbEdccwrt18d1kdiZGe/jwQmwpVN0/ca6W/fBr01evLv6l1FaVvooBJDFdgEiCzM3rmDsLE2xfYaMPwII8mSVAy6+S2JRndY37vv3uPRQikHXUgj1/H7vj0uNnwyfik0ATV7708CPb+QEJts3Ex7hojvDZVTK00IyfdRT3jo1XMPR++P4AbYiwvvBK2SFz4em3kHbYnnGydbuVe1b5v5lBzrj6KyAc/oay8kc6ayQq529VPCG7Nm3EaNWa2ZwbGNuCpUmIIKSpzczlM1Cv3w8tBX1McEN9O/ghoti1PpZkxHN8J7Y4o1PgDyT4ZlUZakTNx8BBXPstJ2Zsy0Ap789z6AjQUKRRi352mJlgxb7IGgnUjGxZagF9TiMODjd74ux29kt4ZjerFSaKr1KaLD/HbbuWmzb6cskoElfh6qc7hHFO/k93yHcAP5a/LW1cALZTQDbCvvz4/fcS/hqatPnQAeWVFNmIbx/4j5oYeEv4+7atTol8b7XFJ0u8YbT4u1abtjejMhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(1076003)(15650500001)(2616005)(82310400004)(7696005)(36756003)(6666004)(4326008)(47076005)(6916009)(16526019)(70586007)(426003)(186003)(2906002)(70206006)(336012)(83380400001)(26005)(81166007)(5660300002)(40460700003)(508600001)(86362001)(54906003)(36860700001)(4744005)(356005)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 00:57:30.3137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c5c9ed-344e-4c89-a698-08da0ec39ac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1271
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
Cc: Philip Yang <Philip.Yang@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MMU callback update page table set unlocked flag, add callback tlb_cb to
vm->last_unlocked fence, and pass it back to upper layer to wait for
page table update done.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 48f326609976..aac1b625194f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -927,7 +927,10 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->commit(&params, fence);
 
-	if (!unlocked && (!(flags & AMDGPU_PTE_VALID) || params.table_freed)) {
+	if (!(flags & AMDGPU_PTE_VALID) || params.table_freed) {
+		if (unlocked && fence)
+			*fence = dma_fence_get(vm->last_unlocked);
+
 		tlb_cb->vm = vm;
 		if (!fence || !*fence ||
 		    dma_fence_add_callback(*fence, &tlb_cb->cb,
-- 
2.35.1

