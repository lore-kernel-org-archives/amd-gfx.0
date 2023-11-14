Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593F3C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 23:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90E110E0EA;
	Tue, 14 Nov 2023 23:33:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B60910E0EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 23:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cATragdC3MdrCpIQ7+lLTm5ohbYdp9kpU39atjPY7kP1Q3ps387dRtbZ9IbJuhPASISkhNbBGD/h8/VSnsDYzB9OiMZwsiJDbsoLhStM7h3Wn5DDS6MnouOaHFWf56TyQmFdQhwDvY2lbE9RgKbG+y9BwVQ4tEO4HwtSGVdOo8i2KIvKOI2+5Ht+a3L2AtcjJsIBbSfItM29m4dbs16Kpe6rvU6uPkcCK6a6uyh1jeQwUutBZt8zSI2mipcSrpNIU5VDg1WBa0RXS75h8iBE8HAdYSaG4EgMwhSAJjgfFQH6j6EDScnUR+eqp39LsXaplIVwEB8QUjjDKMjMUhvr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntbuRUTQ8cRZCJJNYuMGBWgmJ1GfqdQyusJzdFr+dQ0=;
 b=FpT2s2+8jJfYIAdl6TOsGpq/7nFvKSixYhy7UcZVHG5G7Z8Zp2qyS+xPnMQCH0pCzaU+OLumLpTHA2PTjjuJHLKVu5XbumdVKsPmG2WoS71tIMFlq1QeGgFlqofUdMXUZIB3ibi+Vbg5YzQPhRjKyFh1hUYaZD+Up+WOflZXttWNMsIvt5FaRiTXnXNsyBN34BA54PD3TtvSnJTpObfDdHIIMnHNRuahYhgTaoF+z0z/2XCUqP8wrTxQTct/Ps6RHA5wkQz+a2/QuBSEqI8USbCLw3n2ICfEUZUrU7B86aXSzUHGFduxmVjNoPh1LNWrTRsjC9Rn0VHUX/Qm5F/SlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntbuRUTQ8cRZCJJNYuMGBWgmJ1GfqdQyusJzdFr+dQ0=;
 b=BCIQfTO5Hs9494im9NbQjhlNE7VCZhe0S4xpQ5FTFFeJbKUxyLp6Uo0UR6/DedW43zxY4NIIh1EaRW+asRAdGIvX5ko8zZvJY0DCrplP+TAxsH79GKdJX63ULSPJ8hpAO0PR51eQB+Cja9YWUV83Ymqc6hQ6OcBVGZFmPJAlxRY=
Received: from DM6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:5:1b3::30)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 23:33:44 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::77) by DM6PR17CA0017.outlook.office365.com
 (2603:10b6:5:1b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 14 Nov 2023 23:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Tue, 14 Nov 2023 23:33:44 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 17:33:43 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: New VM state for evicted user BOs
Date: Tue, 14 Nov 2023 18:32:53 -0500
Message-ID: <20231114233254.63139-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 70eb3385-a09a-4468-2c5b-08dbe56a2477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYASY7EQM3v3m0pXcJEUboG90pCZx7L3ijs2Har14j7UV1Yh/kWOMeg8BNTBfGA+ddJrkm2s5bFsHv/CCkjbOkpDXtH8eFZODOdpA7bBhSJ07tbhTlQFOGmzSzXjmXheytqIuHOD+EXYcZeR3ATYf1myW124U+T0stkvm3BTqUcSs0R2iYixqOmmazp4g47HYwVgSPSh6BxXSAubqRpCsVQZJW8v0B9DtgqGGHyMDwJvjs3mngMJ5ekWUsxZ2+D06hDiMvlShEHJFGjscSsP+gH0Jg3YQejaTtCy9Wweb0sxv9iXgX10yoLar4cj9iNNAPfwdmGdyuv4iJgjyhq6qvVEjwsG2JiHoIMu0V+jSrE6X4dfsHjcjzCNO8AQDQwA7ZHP/Fb50r+1fhqVRZUV84vKFNArD9L5O2bPXokhPkdYVNR4KAYaE1c1SOwqmJQM9mVyFSKEP/0sdQdmlAcIU3PB6SgxOyk/E9FbXMOhhyR80PlKc+BKZO2HNqDaC5iSEZm1HJhlstgq8eiOMJsgcYxwolMcCtZiUPbI3MGMlabgS4m/SfXG8Yi/JSS53KoL9qUyo+m+hxpQ+osvvTWLFFbxRdm5SS0uSXro0T0kWiySr80P9NbeX0u1z0svhDD+dcIeodAGpZKbMWs4xjScxLWD0IpvqkHX2SfASt76hEj/4U0uKnKE2+JHfdBkw5NIyAWw9/YddFXoVkYNob2GSvjVrz1jnKF+BDArdQ6zYA5wWN5N3uaOnsGfBjxGiSzXFzDnlOip+2grccxIo0R6ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(70206006)(70586007)(54906003)(6916009)(86362001)(356005)(82740400003)(81166007)(36756003)(336012)(36860700001)(83380400001)(426003)(26005)(1076003)(16526019)(2616005)(7696005)(6666004)(41300700001)(2906002)(316002)(478600001)(4326008)(5660300002)(47076005)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 23:33:44.3359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70eb3385-a09a-4468-2c5b-08dbe56a2477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Create a new VM state to track user BOs that are in the system domain.
In the next patch this will be used do conditionally re-validate them in
amdgpu_vm_handle_moved.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 ++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index be084cbe7501..1c9397198083 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -232,6 +232,22 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
 	spin_unlock(&vm_bo->vm->status_lock);
 }
 
+/**
+ * amdgpu_vm_bo_evicted_user - vm_bo is evicted
+ *
+ * @vm_bo: vm_bo which is evicted
+ *
+ * State for BOs used by user mode queues which are not at the location they
+ * should be.
+ */
+static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
+{
+	vm_bo->moved = true;
+	spin_lock(&vm_bo->vm->status_lock);
+	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
+	spin_unlock(&vm_bo->vm->status_lock);
+}
+
 /**
  * amdgpu_vm_bo_relocated - vm_bo is reloacted
  *
@@ -2111,6 +2127,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 	INIT_LIST_HEAD(&vm->evicted);
+	INIT_LIST_HEAD(&vm->evicted_user);
 	INIT_LIST_HEAD(&vm->relocated);
 	INIT_LIST_HEAD(&vm->moved);
 	INIT_LIST_HEAD(&vm->idle);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 12cac06fa289..939d0c2219c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -286,9 +286,12 @@ struct amdgpu_vm {
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
-	/* BOs who needs a validation */
+	/* Per VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
+	/* BOs for user mode queues that need a validation */
+	struct list_head	evicted_user;
+
 	/* PT BOs which relocated and their parent need an update */
 	struct list_head	relocated;
 
-- 
2.34.1

