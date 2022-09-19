Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED2EECAAD3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 17:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5533910E0FD;
	Mon, 19 Sep 2022 17:16:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D6CF10E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 17:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL3P0XEUrjIszrrXIYRkZKSSsmP7DWmho6wh3BG0oci1ATBa8YjFssAcFivxmOQisuPJkt8jkI3BJsHJvHukuWmYsmOiUDszO/IMSVfogduFW7BAfj4Li2zs2eSARJq0gfsl1SpwQ2dQ4/vKX6LTIJ+sY7B+Svcr0S9R9FSncQWjrBopBN6/vmIGYsdQIKs2gPXAZ/CX9gHWKjBhQgKE2KJfTiiKe3rfW+Da19ZG/im1aOWp9V7Tx6nMMCyydvfsEIlXO9IK7qloEGGetpsnaj4HXcqZDrm6HbDXBldXDdGUxksW0IcIjutPrCxQhGtVcudnl7PWZ9cRFkLduuotWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/0saI1SrOaYKRXeSKet7tnPpWYOBbI9zK1NWG3dUxs=;
 b=JD20y4lu9yTiqsHgiM2L9dvEql5RE3NdXjCmDMm7IMpWJ4owh76RWnC+pZ2XhLsVL42SNTsqXnDfaQ51xUAKF7YHvzNRRD+Fz5JK246SJ+xQ7IIBMp5kUVmQwvJFJpAt9wsU1g+MlcoLZU5gKT8WHImqExVFUrHr6My2r7aFyFhf3F3bH5Dwaqpg7uEzWy+/Z8eloMcWxRRgr24XAXcgQi0X/ooJlFNCYE3aIuHJsS0WtRFkzhYIyCS2/f23zns+7rKuDpIIuEjTLHKX7RY4BVXf8KpFucw6rQsaLR+KRP7ARiPmXPtl5vwVVE0f120+1Nh0e+oAX+oyvgJXliERKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/0saI1SrOaYKRXeSKet7tnPpWYOBbI9zK1NWG3dUxs=;
 b=qgFrVS2KDYXJGSSSn1tpOyjPBLb0L/e2I2PS5QVHNMVnJjyMM8FTWnUeAgIkuvkHIS6FPW2qz54BEY2D+HCdLhq3PHO11i8A3zDcEHvDzHU7EmUtgRJvyRWZa+OTeB+t3hZz2DJ/AaSI/d9ebnKMam1ddttPpHNLUmIVfDRry10=
Received: from DM6PR03CA0001.namprd03.prod.outlook.com (2603:10b6:5:40::14) by
 IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Mon, 19 Sep 2022 17:16:24 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::90) by DM6PR03CA0001.outlook.office365.com
 (2603:10b6:5:40::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 17:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 17:16:24 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 12:16:23 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/7] drm/amdgpu: Use vm status_lock to protect relocated
 list
Date: Mon, 19 Sep 2022 13:15:48 -0400
Message-ID: <20220919171553.11286-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919171553.11286-1-Philip.Yang@amd.com>
References: <20220919171553.11286-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2da3ff-f3da-452b-98cd-08da9a62ade9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdu0HspNJdH6XA9YcYIn2XeMcrU4nCmeJZk0g7/CRLPk+HZhLDUvb0SKAy5nYoetj8SNhunTxJHiK/05Yo9Kib8f0fdTuenj4y6rvO1MJUBzoT8CSs1xwJHeQRLoRd19tmtEZOCv22J5HMguhbN0kpYaAltScBvhXdFPV8Y58hdDn9wOk0abeBupzGXPfC6m1HBP1uXTXtzzFrx+ANMgxBXj3fEtk2q/vZSUAJgjYDe50S1bXme0Fpa0NQrQTeSMM1SR+vjCF+VVtJLFzW6isKMTPsDL79WWjU+oYi+Obc/r5G80XodwmkFY5/JfxMTddekFfA8Mo9viTFKwu8GGguQoCpnPi0on/TYxajVcQnfoc6YODG2Gupc6SBI75R4N0uJyj9u7MG83DeSzm8fPNEwOTFjDDJQc+cFxZxKZmvInNMOzN0CgFjYPGQudu1zDUzLx/K/zuiTvQ57WyQDNDdb0eqg9xkW3iiEkQWht1gm0EjMqotoXpbc4Mzl0OesEZpLqmEWI+8QgPKvgegIk2ppp8pP1McOMAhfcGqXVnJZPpG8BU080Hr0Gg5l5FLt8eUWMNHVsW1ZEo88uhdXMOl6OeF+PvZraz5YQH0ZOSwUDCiFnMw8Pj5yUG0QaQKFjpE0+3d4k5FmfX0SeO5GbXKoU0NbVEbm2PoGCDtHhQODcN37kp9Zp01kT5ATNV4ucEi/pKwNCUhfn0BHiN4GLbqLtf0lUzx3Vx8c+LGm69okVhCiVFJJUCm040rZEkX1C9abDJflX0CsRmhn5y63Be7RD8K1nd3eMQrJ7JjEKpGc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(82310400005)(6666004)(478600001)(40460700003)(7696005)(36756003)(2906002)(316002)(186003)(82740400003)(36860700001)(6916009)(54906003)(1076003)(5660300002)(2616005)(86362001)(26005)(16526019)(8676002)(4326008)(426003)(70206006)(70586007)(47076005)(81166007)(356005)(336012)(8936002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 17:16:24.0492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2da3ff-f3da-452b-98cd-08da9a62ade9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 596f1ea8babc..4a1cb20deb2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -240,10 +240,13 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 {
-	if (vm_bo->bo->parent)
+	if (vm_bo->bo->parent) {
+		spin_lock(&vm_bo->vm->status_lock);
 		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-	else
+		spin_unlock(&vm_bo->vm->status_lock);
+	} else {
 		amdgpu_vm_bo_idle(vm_bo);
+	}
 }
 
 /**
@@ -680,9 +683,14 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_bo_base *entry;
 	bool flush_tlb_needed = false;
+	LIST_HEAD(relocated);
 	int r, idx;
 
-	if (list_empty(&vm->relocated))
+	spin_lock(&vm->status_lock);
+	list_splice_init(&vm->relocated, &relocated);
+	spin_unlock(&vm->status_lock);
+
+	if (list_empty(&relocated))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -697,7 +705,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &vm->relocated, vm_status) {
+	list_for_each_entry(entry, &relocated, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -713,9 +721,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	while (!list_empty(&vm->relocated)) {
-		entry = list_first_entry(&vm->relocated,
-					 struct amdgpu_vm_bo_base,
+	while (!list_empty(&relocated)) {
+		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
 					 vm_status);
 		amdgpu_vm_bo_idle(entry);
 	}
@@ -912,6 +919,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
 {
 	struct amdgpu_bo_va *bo_va, *tmp;
 
+	spin_lock(&vm->status_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
@@ -936,7 +944,6 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
 				gtt_mem, cpu_mem);
 	}
-	spin_lock(&vm->status_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-- 
2.35.1

